-- 0.0.2 アシスターオートセット修正、クイックスロットオペレート修正、フレームをalwaysVisible="true"に
-- リバイバルタイマーバグ修正、always_statusバグ修正、separate_buff_custom追加
-- 0.0.3 vakarine_equipのボタンクリックで設定開かなかったの修正、always_statusがどっかに行ってたの修正、old_funcの処理間違ってたの修正
-- 0.0.4 skill_gem_tooltip作り直して移植、save_quest移植、off時のバグ修正、
-- sub_mapミニマップモードを作成、status_point_checkとsilent_velnice_ranking移植
-- 0.0.5 always_statusバグ修正、another_warehouse追加、色々バグ修正
-- 0.0.6 GAMEEXIT_TIMER_ENDを取るのやめた、load_settingsの時に、新しいデフォルトを設定。
-- info.GetBuff(my_handle, 70002)これでトークン有る無し判断する様にこっちの方が早い
-- 0.0.7 instantCCがOFFの場合に、バラックに戻れなかったの修正、オリジナルアドオンの関数名と干渉する問題を頭文字大文字で解消
-- 全部のアドオンを再チェック。バグ修正、初回起動時重すぎたの修正
-- 0.0.8 cchとawhとsslotとipとmutekiとilvとocsl移植、起動最適化。まだ重いけど。。。ラストテストバージョン
-- 1.0.0 公開予定
-- 1.0.1 ANOTHER_WAREHOUSEアドオンと喧嘩してたの修正、other_character_skill_listのロードのタイミング修正、旧CC_HELPERとの競合修正
-- 1.0.2 AlwaysStatus修正。セーブファイルのバージョン管理。quickslot_operate修正、持ってない場合アイコン赤表示に変更
-- 1.0.3 MKC、PITフレームちらつき修正、AW自動設定修正、SSSドロップ挙動修正。
-- 1.0.3.1 エラー時にlogを吐く様に設定。
-- 1.0.3.2 インベントリのボタンが消える怪現象を明示的に修正。なんでや？
-- 1.0.4 NCのゴミ箱バグ修正、SQ SSSのクエスト表示バグ修正、IP ILV OCSL ESCキーで消える様に。IP掃討ボタンバグ修正。
-- 1.0.4.1 読み込み時の負荷を分散、ocslがクソ重たかったの修正
-- 1.0.5 チーム倉庫のバニラ挙動修正、AWHのjsonをluaに変更
-- 1.0.6 ILVのloadにバージョン管理追加。AWH使ってない場合のインベントリの挙動修正。IP激動の核の掃討部分修正
-- 1.0.7 IPの表示読込優先。CCH自動着脱を見直し。ILV最初回のロード処理変更。SSSスキルフレーム表示時の挙動変更。競合アドオン有効時の排他処理を厳格化。
-- 1.0.8 CCH自動着脱更に見直し、フレーム作成修正、AWHのセッティング時の挙動見直し、VEのバグ修正。ICC掃討バフ12時間以下で表示。ARフレーム非表示に変更。IPフレーム挙動修正、NCのフレームボタン修正。
-- 1.0.9 Mutekiゲージ位置修正、ESCの挙動修正。IPベリオラアイコン修正。AR再修正。CCHロード修正。ILV掃討バフ12時間以下で表示。
-- 1.1.0 Battle_ritualフレームスクロール。AWH fixinventorysort使える様に。DRPC200未満ですぐ補充に。
-- 1.1.1 CCH装備外すロジック見直し。GIM追加。ILV掃討の残り時間のロジック修正。NCゴッデスアクセバグ修正。AWH CC後最速読込。
-- 1.1.2 不安定なバラックへ移動の挙動を見直し。CCH装備装着時のロジック見直し、倉庫入庫のロジック修正。BRバグ修正。SM修正。
-- 1.1.3 AWH1個取り出す挙動修正、同一clsidの処理見直し。PIT初期化処理見直し。CRプレミアム補助材バグ修正。EBバフ部分修正。TOS追加。AOH追加
-- 1.1.4 AS表示名をカスタマイズ可能に
-- 1.1.5 CCHロード処理見直し、AS位置固定修正、TOSモンスター検索修正、CCHレベル判定修正、IP掃討ボタンの挙動修正、NCアイテム連続使用ロジック修正
-- 1.1.6 AS%表示追加、IPフィールド表示修正、TOS表示位置修正、SGT無効処理追加
-- 1.1.7 ズメイを全機能に対応(IP/ILV/quickslot)
-- 1.1.8 Auto RepairアイテムID修正(Lv550)、Another Warehouse保存修正、ILVハードモードnilガード、save/load堅牢化
-- 1.1.9 GEWギルドイベントワープ修正(削除された_BORUTA_ZONE_MOVE_CLICKを封鎖線ランキングと同じMOVE_TO_ENTER_NPCに置換)
-- 1.1.10 GEWワープに移動可否チェック追加(PVP/レイヤー変更/ダンジョン/レイド地域では不可)、save_jsonをtmp+renameでアトミック化
-- 1.1.11 yoma16版修正の移植(CCHマルチセット/load堅牢化)、OCSLバラック別グループ表示
-- 1.1.12 save/load堅牢化(rename失敗検知・load_jsonはdecode成功後に差し替え・atomic_replace共通化)、get_map_type/CCHセット/ILV設定のnilガードとデータ消失防止
-- 1.1.13 IndunPanelのPVP_MINEショップ同期をログイン時→パネル展開時の遅延同期に変更(セッション中1回・完了後に再描画)。ログイン時にウィンドウが開いてインベントリが閉じる不具合を解消。同期でインベントリが閉じた場合は復元。IndunPanelの位置がドラッグ後に保存されず閉じると戻る不具合を修正(保存ハンドラが固定側分岐にあったのを移動可側に修正)
local addon_name = "_NEXUS_ADDONS"
local addon_name_lower = string.lower(addon_name)
local author = "norisan"
local ver = "1.1.13"

_G["ADDONS"] = _G["ADDONS"] or {}
_G["ADDONS"][author] = _G["ADDONS"][author] or {}
_G["ADDONS"][author][addon_name] = _G["ADDONS"][author][addon_name] or {}
local g = _G["ADDONS"][author][addon_name]
local json = require("json")

local function ts(...)
    local num_args = select('#', ...)
    if num_args == 0 then
        print("ts() -- 引数がありません")
        return
    end
    local string_parts = {}
    for i = 1, num_args do
        local arg = select(i, ...)
        local arg_type = type(arg)
        local is_success, value_str = pcall(tostring, arg)
        if not is_success then
            value_str = "[tostringでエラー発生]"
        end
        table.insert(string_parts, string.format("(%s) %s", arg_type, value_str))
    end
    print(table.concat(string_parts, "   |   "))
end

local function print_all_child(ctrl, prefix)
    prefix = prefix or ""
    local count = ctrl:GetChildCount()
    for i = 0, count - 1 do
        local child = ctrl:GetChildByIndex(i)
        local name = child:GetName()
        local class_name = child:GetClassName()
        local w = child:GetWidth()
        local h = child:GetHeight()
        print(string.format("%sName: %s | Class: %s | Size: %dx%d", prefix, name, class_name, w, h))
        if child:GetChildCount() > 0 then
            print_all_child(child, prefix .. "  ")
        end
    end
end

function g.mkdir_new_folder()
    local function create_folder(folder_path, file_path)
        local file = io.open(file_path, "r")
        if not file then
            os.execute('mkdir "' .. folder_path .. '"')
            file = io.open(file_path, "w")
            if file then
                file:write("A new file has been created")
                file:close()
            end
        else
            file:close()
        end
    end
    local folder = string.format("../addons/%s", addon_name_lower)
    local file_path = string.format("../addons/%s/mkdir.txt", addon_name_lower)
    create_folder(folder, file_path)
    local user_folder = string.format("../addons/%s/%s", addon_name_lower, g.active_id)
    local user_file_path = string.format("../addons/%s/%s/mkdir.txt", addon_name_lower, g.active_id)
    create_folder(user_folder, user_file_path)
end

function g.setup_hook_and_event(my_addon, origin_func_name, my_func_name, bool)
    g.FUNCS = g.FUNCS or {}
    if not g.FUNCS[origin_func_name] then
        g.FUNCS[origin_func_name] = _G[origin_func_name]
    end
    local origin_func = g.FUNCS[origin_func_name]
    local function hooked_function(...)
        local original_results
        if bool == true then
            original_results = {origin_func(...)}
        end
        g.ARGS = g.ARGS or {}
        g.ARGS[origin_func_name] = {...}
        imcAddOn.BroadMsg(origin_func_name)
        if original_results then
            return table.unpack(original_results)
        else
            return
        end
    end
    _G[origin_func_name] = hooked_function
    if not g.REGISTER[origin_func_name .. my_func_name] then -- g.REGISTERはON_INIT内で都度初期化
        g.REGISTER[origin_func_name .. my_func_name] = true
        my_addon:RegisterMsg(origin_func_name, my_func_name)
    end
end

function g.get_event_args(origin_func_name)
    local args = g.ARGS[origin_func_name]
    if args then
        return table.unpack(args)
    end
    return nil
end

function g.setup_hook(my_func, origin_func_name)
    local addon_upper = string.upper(addon_name)
    local replace_name = addon_upper .. "_REPLACE_" .. origin_func_name
    g.FUNCS = g.FUNCS or {}
    if not _G[replace_name] then
        _G[replace_name] = _G[origin_func_name]
    end
    _G[origin_func_name] = my_func
    g.FUNCS[origin_func_name] = _G[replace_name]
end

-- tmp を path へ差し替える(remove→rename)。成功可否を返す。
-- 厳密なアトミック差し替えではない: remove と rename の間でクラッシュすると path は
-- 消えるが、tmp に完全な内容が残るため次回 load の .tmp リカバリで復旧できる。この
-- tmp リカバリと対で実効的な原子性(=設定を失わない)を担保する。
-- Windows の os.rename は移動先が存在すると失敗するため先に remove する。
-- rename 失敗時は path が remove 済みのまま false を返す(呼び出し側が検知して報告)。
function g.atomic_replace(tmp_path, path)
    os.remove(path)
    local ok, err = os.rename(tmp_path, path)
    if not ok then
        return false, err
    end
    return true
end

function g.save_lua(path, tbl)
    local function serialize(o)
        if type(o) == "number" then
            return tostring(o)
        elseif type(o) == "string" then
            return string.format("%q", o)
        elseif type(o) == "boolean" then
            return tostring(o)
        elseif type(o) == "table" then
            local parts = {"{\n"}
            for k, v in pairs(o) do
                parts[#parts + 1] = "[" .. serialize(k) .. "]=" .. serialize(v) .. ",\n"
            end
            parts[#parts + 1] = "}"
            return table.concat(parts)
        else
            return "nil"
        end
    end
    local ok_s, content = pcall(function() return "return " .. serialize(tbl) end)
    if not ok_s or not content then
        if ts then ts("Save Lua Serialize Error:", tostring(content)) end
        return
    end
    local tmp_path = path .. ".tmp"
    local file, err = io.open(tmp_path, "w")
    if file then
        local ok_w, w_err = file:write(content)
        file:close()
        if ok_w then
            local ok_r, r_err = g.atomic_replace(tmp_path, path)
            if not ok_r and ts then ts("Save Lua Rename Error:", tostring(r_err)) end
        else
            if ts then ts("Save Lua Write Error:", tostring(w_err)) end
        end
    else
        if ts then ts("Save Lua Error:", err) end
    end
end

function g.load_lua(path)
    local chunk, err = loadfile(path)
    if chunk then
        local status, result = pcall(chunk)
        if status then
            return result
        end
    end
    local tmp_path = path .. ".tmp"
    local tmp_chunk = loadfile(tmp_path)
    if tmp_chunk then
        local status, result = pcall(tmp_chunk)
        if status then
            g.atomic_replace(tmp_path, path)
            return result
        end
    end
    return nil
end

-- path の .tmp をデコード成功時のみ path へ昇格し、(true, 値) を返す。
-- 壊れた/空/不在の .tmp は昇格させず(リカバリ元を失わないため) false を返す。
-- 本体ファイルが開けない/空の 2 経路で共通のリカバリ手順。
local function load_json_recover_from_tmp(path)
    local tmp_file = io.open(path .. ".tmp", "r")
    if not tmp_file then
        return false
    end
    local tmp_content = tmp_file:read("*all")
    tmp_file:close()
    if not tmp_content or tmp_content == "" then
        return false
    end
    local s, r = pcall(json.decode, tmp_content)
    if not s then
        return false
    end
    g.atomic_replace(path .. ".tmp", path)
    return true, r
end

function g.load_json(path)
    local file = io.open(path, "r")
    if not file then
        local ok, recovered = load_json_recover_from_tmp(path)
        if ok then
            return recovered, nil
        end
        return nil, "Error opening file: " .. path
    end
    local content = file:read("*all")
    file:close()
    if not content or content == "" then
        local ok, recovered = load_json_recover_from_tmp(path)
        if ok then
            return recovered, nil
        end
        return nil, "File content is empty or could not be read: " .. path
    end
    if string.sub(content, 1, 3) == "\239\187\191" then
        content = string.sub(content, 4)
    end
    local success, result = pcall(json.decode, content)
    if success then
        return result, nil
    else
        return nil, result
    end
end

function g.save_json(path, tbl)
    -- 先にエンコードしてから書き込む。エンコード失敗時に本体ファイルを
    -- 空に潰さないよう、まず tmp に書いてから rename でアトミックに差し替える。
    -- (load_json の .tmp リカバリと対になる)
    local success, str = pcall(json.encode, tbl)
    if not success then
        print(string.format("[g.save_json] JSON Encode Error in '%s': %s", tostring(path), tostring(str)))
        return false
    end
    local tmp_path = path .. ".tmp"
    local file, err = io.open(tmp_path, "w")
    if not file then
        print(string.format("[g.save_json] Error opening file for write: %s (Error: %s)", tostring(tmp_path), tostring(err)))
        return false
    end
    local ok_w, w_err = file:write(str)
    file:close()
    if not ok_w then
        print(string.format("[g.save_json] Write Error in '%s': %s", tostring(tmp_path), tostring(w_err)))
        return false
    end
    local ok_r, r_err = g.atomic_replace(tmp_path, path)
    if not ok_r then
        print(string.format("[g.save_json] Rename Error in '%s': %s", tostring(path), tostring(r_err)))
        return false
    end
    return true
end

function g.get_map_type()
    local map_name = session.GetMapName()
    local map_cls = GetClass("Map", map_name)
    -- 未知/インスタンスマップでは GetClass が nil を返しうるので nil ガード。
    -- 呼び出し側はいずれも文字列比較(== "Dungeon" 等)なので nil で問題ない。
    if not map_cls then
        return nil
    end
    return map_cls.MapType
end

function g.debug_print_table(tbl, indent)
    indent = indent or ""
    for key, value in pairs(tbl) do
        local key_str = indent .. "[" .. tostring(key) .. "] ="
        if type(value) == "table" then
            print(key_str .. "{")
            g.debug_print_table(value, indent .. "  ")
            print(indent .. "}")
        else
            print(key_str .. tostring(value))
        end
    end
end

function g.log_to_file(message)
    local log_file_path = string.format('../addons/%s/debug_log.txt', addon_name_lower)
    local file, err = io.open(log_file_path, "a")
    if file then
        local timestamp = os.date("[%Y-%m-%d %H:%M:%S] ")
        file:write(timestamp .. tostring(message) .. "\n")
        file:close()
    end
end

