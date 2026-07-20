# -*- coding: utf-8 -*-
"""nexus_addons/src/**  を連結して配布用 bundle（2 ファイル）を生成する。

これがビルド時の正の入口。manifest の順に src ファイルの中身を raw 連結して
    nexus_addons/_nexus_addons/_nexus_addons.lua
    nexus_addons/_nexus_addons/_nexus_addons_conclude.lua
を書き出す（この 2 ファイルは .gitignore 済みの生成物）。

使い方:
    python docs/bundle_from_src.py           # src -> bundle を生成
    python docs/bundle_from_src.py --check    # 生成せず、既存 bundle と一致するか比較のみ

生成後、この bundle を docs/build_addon_ipf.py に渡して .ipf 化する。
"""
import json, os, sys

HERE = os.path.dirname(os.path.abspath(__file__))
REPO = os.path.dirname(HERE)
SRC = os.path.join(REPO, "nexus_addons", "src")
MANIFEST = os.path.join(SRC, "build_manifest.json")
BUNDLE_DIR = os.path.join(REPO, "nexus_addons", "_nexus_addons")


def build():
    with open(MANIFEST, encoding="utf-8") as f:
        manifest = json.load(f)
    out = {}
    for target, rels in manifest.items():
        parts = []
        for rel in rels:
            path = os.path.join(SRC, rel)
            if not os.path.isfile(path):
                raise SystemExit(f"[bundle] src が無い: {rel}")
            parts.append(open(path, "rb").read())
        out[target] = b"".join(parts)
    return out


def main():
    check_only = "--check" in sys.argv
    out = build()
    rc = 0
    for target, data in out.items():
        dst = os.path.join(BUNDLE_DIR, target)
        old = open(dst, "rb").read() if os.path.isfile(dst) else None
        if check_only:
            same = old == data
            print(f"  {target}: src再現 {len(data)}B vs 既存 "
                  f"{len(old) if old is not None else '-'}B -> "
                  f"{'MATCH' if same else 'DIFF'}")
            rc = rc or (0 if same else 1)
        else:
            open(dst, "wb").write(data)
            note = "" if old is None else (
                " (unchanged)" if old == data else " (CHANGED)")
            print(f"  wrote {target}: {len(data)}B{note}")
    sys.exit(rc)


if __name__ == "__main__":
    main()
