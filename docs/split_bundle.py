# -*- coding: utf-8 -*-
"""nexus_addons の bundle を機能ごとの src ファイルへ分割する（初回移行用）。

分割は「行頭バイトオフセット」だけで行う。チャンクは元ファイル全域をギャップ
なく被覆するため、raw 連結（bundle_from_src.py）で元と byte 一致する。
分割後、その場で再連結して byte 一致を自己検証する。

使い方:
    python docs/split_bundle.py            # 分割 + 自己検証
    python docs/split_bundle.py --check    # 分割せず、現 src が現 bundle を再現するか検証のみ

境界アンカー（現 v1.1.12 bundle 基準）:
    main:  header 1-337 / registry 338-1027 / lifecycle 1028-1488
           addons 各 `ここから`〜次 `ここから` の直前 / tail(norisan_menu) 29403-EOF
    conclude: header 1-27 / ancient_monster_bookshelf 28-EOF
"""
import json, os, sys

HERE = os.path.dirname(os.path.abspath(__file__))
REPO = os.path.dirname(HERE)
BUNDLE_DIR = os.path.join(REPO, "nexus_addons", "_nexus_addons")
MAIN = os.path.join(BUNDLE_DIR, "_nexus_addons.lua")
CONCLUDE = os.path.join(BUNDLE_DIR, "_nexus_addons_conclude.lua")
SRC = os.path.join(REPO, "nexus_addons", "src")
MANIFEST = os.path.join(SRC, "build_manifest.json")

# 48 addon keys — main 内で `ここから` マーカーが現れる順（＝関数定義順）と一致。
ADDON_ORDER = [
    "always_status", "indun_panel", "cc_helper", "tavern_of_soul",
    "archeology_helper", "easy_buff", "continue_reinforce", "pick_item_tracker",
    "another_warehouse", "sub_map", "battle_ritual", "other_character_skill_list",
    "instant_cc", "indun_list_viewer", "characters_item_serch",
    "goddess_icor_manager", "vakarine_equip", "sub_slotset", "muteki",
    "no_check", "monster_kill_count", "quickslot_operate", "cupole_manager",
    "ancient_auto_set", "save_quest", "my_buffs_control", "status_point_check",
    "silent_velnice_ranking", "skill_gem_tooltip", "separate_buff_custom",
    "revival_timer", "relic_change", "monster_card_changer", "market_voucher",
    "lets_go_home", "debuff_notice", "boss_gauge", "party_marker",
    "aethergem_manager", "job_change_helper", "guild_event_warp",
    "dungeon_rp_charger", "boss_direction", "auto_repair", "acquire_relic_reward",
    "auto_pet_summon", "auto_map_change", "bulk_sales",
]
MARKER = "ここから".encode("utf-8")
NORISAN_TAIL = 29403  # `-- アドオンメニューボタン`（共有メニュー先頭）


def line_offsets(data):
    """offs[n] = 1-indexed 行 n の先頭バイトオフセット。末尾に EOF センチネル。"""
    offs = [0, 0]
    for i, b in enumerate(data):
        if b == 0x0A:
            offs.append(i + 1)
    offs.append(len(data))
    return offs


def marker_lines(data):
    res, line, start = [], 1, 0
    for i, b in enumerate(data):
        if b == 0x0A:
            if MARKER in data[start:i]:
                res.append(line)
            line, start = line + 1, i + 1
    if start < len(data) and MARKER in data[start:]:
        res.append(line)
    return res


def sub(data, offs, a, b):
    end = offs[b] if b < len(offs) else len(data)
    return data[offs[a]:end]


def build_plan():
    """(manifest, {relpath: bytes}) を返す。ファイルを書かずに構築のみ。"""
    main_b = open(MAIN, "rb").read()
    conc_b = open(CONCLUDE, "rb").read()
    m_off, marks = line_offsets(main_b), marker_lines(main_b)
    if len(marks) != 48:
        raise SystemExit(f"[split] main の ここから が48でない: {len(marks)}")

    chunks = [
        ("core/00_header.lua", 1, 338),
        ("core/10_registry.lua", 338, 1028),
        ("core/20_lifecycle.lua", 1028, marks[0]),
    ]
    for i, key in enumerate(ADDON_ORDER):
        end = marks[i + 1] if i + 1 < len(marks) else NORISAN_TAIL
        chunks.append((f"addons/{key}.lua", marks[i], end))
    chunks.append(("core/90_norisan_menu.lua", NORISAN_TAIL, len(m_off)))

    prev = 1
    for rel, a, b in chunks:
        if a != prev:
            raise SystemExit(f"[split] 被覆ギャップ/重複 @ {rel}: {a} != {prev}")
        if b <= a:
            raise SystemExit(f"[split] 空チャンク {rel}")
        prev = b

    files, manifest = {}, {"_nexus_addons.lua": [], "_nexus_addons_conclude.lua": []}
    for rel, a, b in chunks:
        files[rel] = sub(main_b, m_off, a, b)
        manifest["_nexus_addons.lua"].append(rel)

    c_off, cmarks = line_offsets(conc_b), marker_lines(conc_b)
    if cmarks != [28]:
        raise SystemExit(f"[split] conclude の ここから が[28]でない: {cmarks}")
    for rel, a, b in [("conclude_header.lua", 1, 28),
                      ("addons/ancient_monster_bookshelf.lua", 28, len(c_off))]:
        files[rel] = sub(conc_b, c_off, a, b)
        manifest["_nexus_addons_conclude.lua"].append(rel)

    return manifest, files, {"_nexus_addons.lua": main_b,
                             "_nexus_addons_conclude.lua": conc_b}


def verify(manifest, files, originals):
    ok = True
    for target, orig in originals.items():
        rebuilt = b"".join(files[rel] for rel in manifest[target])
        same = rebuilt == orig
        ok = ok and same
        print(f"  {target}: {len(rebuilt)}B vs {len(orig)}B -> "
              f"{'OK byte-identical' if same else 'MISMATCH'}")
    return ok


def main():
    check_only = "--check" in sys.argv
    manifest, files, originals = build_plan()

    if check_only:
        print("[split --check] src を書かずに再現性のみ検証")
        sys.exit(0 if verify(manifest, files, originals) else 1)

    os.makedirs(os.path.join(SRC, "core"), exist_ok=True)
    os.makedirs(os.path.join(SRC, "addons"), exist_ok=True)
    for rel, data in files.items():
        open(os.path.join(SRC, rel), "wb").write(data)
    with open(MANIFEST, "w", encoding="utf-8") as f:
        json.dump(manifest, f, ensure_ascii=False, indent=2)
        f.write("\n")
    print(f"[split] {len(files)} files + manifest -> {SRC}")
    print("[split] self-verify (rejoin == original):")
    sys.exit(0 if verify(manifest, files, originals) else 1)


if __name__ == "__main__":
    main()
