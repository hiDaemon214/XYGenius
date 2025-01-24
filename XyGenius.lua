local XyInProgress
local strTestXY = {
    { 1, 2, 3 }, -- 第1行
    { 4, 5, 6 }, -- 第2行
    { 7, 8, 9 }  -- 第3行
}

-- print("hello 许愿精灵")

-- function InitUI()
--     local XyGen = CreateFrame("Frame", "XyGen", UIParent, "BasicFrameTemplate");
--     XyGen:SetWidth(400);
--     XyGen:SetHeight(285);
--     XyGen.TitleText:SetText("许愿精灵")
--     XyGen:SetMovable(true)
--     XyGen:SetClampedToScreen(true)

--     XyGen:SetScript("OnMouseUp", function()
--         XyGen:StopMovingOrSizing();
--     end);
--     XyGen:SetScript("OnMouseDown", function()
--         XyGen:StartMoving();
--     end);

--     XyGen:SetFrameStrata("HIGH");
--     XyGen:SetPoint("TOPRIGHT", Minimap, "BOTTOMRIGHT", 0, -20);
--     XyGen:Show()


--     local button = CreateFrame("Button", "Frame", XyGen, "UIPanelButtonTemplate");
--     button:SetSize(130, 30)
--     button:SetPoint("TOPLEFT", XyGen, "TOPLEFT", 8, -28);
--     button:SetText("重载");
--     button:Show()
--     button:SetScript("OnClick", function()
--         ReloadUI()
--     end);
--     preWidget = button

--     -- 创建一个多行 EditBox 控件
--     local editBox = CreateFrame("EditBox", "MyAddonEditBox", XyGen, "InputBoxTemplate")
--     editBox:SetSize(360, 200)
--     editBox:SetPoint("TOP", 0, -40)
--     editBox:SetMultiLine(true) -- 启用多行模式
--     editBox:SetAutoFocus(false) -- 禁用自动获取焦点
--     editBox:SetMaxLetters(1000) -- 最大字符数限制
--     editBox:SetFontObject("ChatFontNormal") -- 设置字体样式

--     -- 添加滚动功能
--     local scrollFrame = CreateFrame("ScrollFrame", "MyAddonScrollFrame", XyGen, "UIPanelScrollFrameTemplate")
--     scrollFrame:SetSize(360, 200)
--     scrollFrame:SetPoint("TOP", 0, -40)
--     scrollFrame:SetScrollChild(editBox)

--     -- 修正 EditBox 和滚动框的关系
--     editBox:SetScript("OnCursorChanged", function(self, x, y, width, height)
--         local cursorOffset = y + height
--         local scrollHeight = scrollFrame:GetHeight()
--         local maxScroll = math.max(cursorOffset - scrollHeight, 0)
--         scrollFrame:SetVerticalScroll(maxScroll)
--     end)

--     -- 添加标题
--     local title = XyGen:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
--     title:SetPoint("TOP", 0, -10)
--     title:SetText("多行输入框示例")

--     -- 添加关闭按钮
--     local closeButton = CreateFrame("Button", nil, XyGen, "UIPanelCloseButton")
--     closeButton:SetPoint("TOPRIGHT", frame, "TOPRIGHT", -5, -5)
-- end


-- local frame = CreateFrame("Frame")
-- frame:RegisterEvent("ADDON_LOADED")
-- frame:SetScript("OnEvent", function(self, event, addonName)
--     if addonName == "XyGenius" then
--       InitUI()
--     --   StartTickers()
--     end
-- end)


-- SlashCmdList["XYG"] = function()
--     if XyGen and not XyGen:IsVisible() then
--         XyGen:Show()
--     end
-- end
-- SLASH_XYG1 = "/xyg";

-- 创建一个框体作为父框体


local frame = CreateFrame("Frame", "MyAddonFrame", UIParent, "BasicFrameTemplate BackdropTemplate");
frame:SetWidth(505);
frame:SetHeight(705);
frame.TitleText:SetText("许愿精灵")
frame:SetMovable(true)
frame:SetClampedToScreen(true)
frame:SetScript("OnMouseUp", function()
    frame:StopMovingOrSizing();
end);
frame:SetScript("OnMouseDown", function()
    frame:StartMoving();
end);

frame:SetScript("OnHide", function()
    print("The frame was hidden!");
end);

frame:SetBackdrop({
    bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",
    edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
    tile = true,
    tileSize = 32,
    edgeSize = 16,
    insets = { left = 8, right = 8, top = 0, bottom = 8 }
})

frame:RegisterEvent("CHAT_MSG_SYSTEM")
frame:RegisterEvent("CHAT_MSG_PARTY")
frame:RegisterEvent("CHAT_MSG_RAID")
frame:RegisterEvent("CHAT_MSG_RAID_LEADER")
frame:RegisterEvent("CHAT_MSG_RAID_WARNING")
frame:RegisterEvent("CHAT_MSG_ADDON")
frame:RegisterEvent("CHAT_MSG_WHISPER")
frame:RegisterEvent("PLAYER_LOGIN")

frame:SetFrameStrata("HIGH");
frame:SetPoint("CENTER", UIParent, "CENTER", 0, -20);
frame:Show();


-- 开始许愿
local button = CreateFrame("Button", "Frame", frame, "UIPanelButtonTemplate");
button:SetSize(100, 20)
button:SetPoint("TOPLEFT", frame, "TOPLEFT", 20, -30);
button:SetText("开始许愿");
button:Show();
button:SetScript("OnClick", function()
    --  ReloadUI()
    XyInProgress = true
    local n = getn(XyArray)
    for i = 1, n do
        print(XyArray[i])
    end

    print("开始许愿，在团队频道输入【XY 许愿装备】可以被记录");
    SendChatMessage("开始许愿，在团队频道输入【XY 许愿装备】可以被记录", "RAID");
end);
preWidget = button


-- 创建一个多行 EditBox 控件
local editBox = CreateFrame("EditBox", "MyAddonEditBox", frame, "InputBoxTemplate ")
editBox:SetPoint("TOPLEFT", preWidget, "BOTTOMLEFT", 0, -10);
editBox:SetSize(470, 690)
editBox:SetMultiLine(true)              -- 启用多行模式
editBox:SetAutoFocus(false)             -- 禁用自动获取焦点
editBox:SetMaxLetters(1000)             -- 最大字符数限制
editBox:SetFontObject("ChatFontNormal") -- 设置字体样式



-- 停止跟随
local button = CreateFrame("Button", "Frame", preWidget, "UIPanelButtonTemplate");
button:SetSize(100, 20)
button:SetPoint("LEFT", preWidget, "RIGHT", 20, 0);
button:SetText("停止许愿");
button:Show()
button:SetScript("OnClick", function()
    XyInProgress = false
    print("许愿结束，后续许愿无效");
    SendChatMessage("许愿结束，后续许愿无效", "RAID");
end);
preWidget = button

-- 重置许愿
local button = CreateFrame("Button", "Frame", preWidget, "UIPanelButtonTemplate");
button:SetSize(100, 20)
button:SetPoint("LEFT", preWidget, "RIGHT", 20, 0);
button:SetText("重置许愿");
button:Show()

button:SetScript("OnClick", function()
    XyInProgress = true
    XyArray = {}
    local totalMembers = GetNumGroupMembers()
    if totalMembers then
        for i = 1, totalMembers do
            local name, rank, subgroup, level, class, fileName, zone, online = GetRaidRosterInfo(i);
            info = {}
            info["name"] = name
            info["class"] = class
            info["dkp"] = 4
            info["xy"] = "---未许愿---"
            --  print(info["name"].."-"..info["class"].."-"..info["dkp"].."-"..info["xy"])
            table.insert(XyArray, info)
            --  NoXyList = NoXyList .. name .. " "
        end
    end
    local i = getn(XyArray)
    if i then
        for n = 1, i do
            SendChatMessage(XyArray[n]["name"] .. "-" ..
                XyArray[n]["class"] .. "-" .. XyArray[n]["dkp"] .. "-" .. XyArray[n]["xy"], "RAID")
        end
    end
    print("许愿已经被重置，请重新许愿.")
    SendChatMessage("许愿已经被重置，请重新许愿.", "RAID");
end);
preWidget = button

-- 团队人数
local button = CreateFrame("Button", "Frame", preWidget, "UIPanelButtonTemplate");
button:SetSize(100, 20);
button:SetPoint("LEFT", preWidget, "RIGHT", 20, 0);
button:SetText("更新许愿");
button:Show();
--  button:SetScript("OnClick", function()

--     -- local numGroupMembers = GetNumGroupMembers()
--     -- SendChatMessage("当前团队人数为："..numGroupMembers.."人", "RAID");
--     -- for i = 1, numGroupMembers do
--     --     local name, rank, subgroup, level, class, fileName, zone, online, isDead, role, isML = GetRaidRosterInfo(i)
--     --     SendChatMessage(string.format(
--     --         "Name: %s, Rank: %d, Subgroup: %d, Level: %d, Class: %s, Zone: %s, Online: %s, Dead: %s, Role: %s, MasterLooter: %s",
--     --         name or "N/A",
--     --         rank or -1,
--     --         subgroup or -1,
--     --         level or -1,
--     --         class or "N/A",
--     --         zone or "N/A",
--     --         tostring(online),
--     --         tostring(isDead),
--     --         role or "N/A",
--     --         tostring(isML)
--     --     ),"RAID")
--     -- end
--  end);
preWidget = button



frame:SetScript("OnEvent", function(self, event, msg, sender)
    if event == "PLAYER_LOGIN" then --登录游戏的时候
        XyGenius_Onload()
        print(XyInProgress)
        print("玩家登录，加载插件中.")
        SendChatMessage("玩家登录，加载插件中.", "RAID")
        -- if XyInProgress then
        --     SendChatMessage("当前许愿模式已关闭","RAID")
        -- end
        -- else
        --     SendChatMessage("当前许愿模式已开启","RAID")
    end

    if event == "CHAT_MSG_RAID" or event == "CHAT_MSG_RAID_LEADER" then --捕捉团队聊天内容
        print("start pase")
        if XyInProgress then
            local xyvalues = {}
            for word in string.gmatch(msg, "%S+") do --拆分解析 许愿内容  "姓名-服务器名称 xy 装备"
                table.insert(xyvalues, word)
            end

            local val1 = xyvalues[1]
            -- print("sender:"..sender)
            -- print("split:"..string.split(sender, "-")[1].."！")
            local s = string.find(sender, "-")
            local sendername = string.sub(sender, 1, s - 1)
            
            if string.lower(val1) == "xy" and getn(xyvalues) > 1 then
                local Xy = xyvalues[2]
                local xyinfo = getXyInfo(sendername)
                
                info = {}
                info["name"] = sendername
                info["class"] = xyinfo['class']    --可能存在问题 ，当有人加入团队，输入xy的时候
                info["dkp"] = 4
                info["xy"] = Xy
                --  print(info["name"].."-"..info["class"].."-"..info["dkp"].."-"..info["xy"])
                table.insert(XyArray, info)
                SendChatMessage(sendername .. " 许愿 " .. Xy, "RAID")
            end

        end
        print("end pase")
    end
end)


--加载执行函数
function XyGenius_Onload()
    XyInProgress = false --默认为关闭许愿模式

    print("客户端版本:" .. GetBuildInfo())

    -- 初始化许愿表
    -- 初始化变量
    if XyArray == nil then
        XyArray = {}
    end


    local totalMembers = GetNumGroupMembers() --获取团队总人数
    if totalMembers then
        for i = 1, totalMembers do
            local name, rank, subgroup, level, class, fileName, zone, online = GetRaidRosterInfo(i);
            info = {}
            info["name"] = name
            info["class"] = class
            info["dkp"] = 4
            info["xy"] = "---未许愿---"
            --  print(info["name"].."-"..info["class"].."-"..info["dkp"].."-"..info["xy"])
            table.insert(XyArray, info)
            --  NoXyList = NoXyList .. name .. " "
        end
    end
    --初始化结束 ，后期做成函数


    SlashCmdList["XYG"] = function()
        frame:Show();
        print("Hello xygenius");
    end

    SLASH_XYG1 = "/xyg"
    SLASH_XYG2 = "/xygen"
end

function XyTracker_OnXy(name, Xy)
    local info = getXyInfo(name) --name为许愿者 ,Xy 为许愿内容
    info["xy"] = Xy
    XyTracker_ShowXyWindow()
end

-- 获取指定名字的许愿信息
function getXyInfo(name)
    local n = getn(XyArray)
    if n > 0 then
        for i = 1, n do
            local info = XyArray[i]
            if info["name"] == name then
                return info
            end
        end
    end
    return nil
end

-- local frame = CreateFrame("Frame", "MyAddonFrame", xymainFrame ,"BackdropTemplate")
-- frame:SetSize(500, 700)
-- frame:SetPoint("CENTER")
-- frame:SetBackdrop({
--     bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",
--     edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
--     tile = true, tileSize = 32, edgeSize = 16,
--     insets = { left = 8, right = 8, top = 0, bottom = 8 }
-- })
-- frame:SetBackdropColor(0, 0, 0, 1)
-- frame:EnableMouse(true)
-- frame:SetMovable(true)
-- frame:RegisterForDrag("LeftButton")
-- frame:SetScript("OnDragStart", frame.StartMoving)
-- frame:SetScript("OnDragStop", frame.StopMovingOrSizing)

-- frame:RegisterEvent("CHAT_MSG_SYSTEM")
-- frame:RegisterEvent("CHAT_MSG_PARTY")
-- frame:RegisterEvent("CHAT_MSG_RAID")
-- frame:RegisterEvent("CHAT_MSG_RAID_LEADER")
-- frame:RegisterEvent("CHAT_MSG_RAID_WARNING")
-- frame:RegisterEvent("CHAT_MSG_ADDON")
-- frame:RegisterEvent("CHAT_MSG_WHISPER")
-- frame:RegisterEvent("PLAYER_LOGIN")



--设置许愿窗口的内容
-- function setXyTestEdit()
--     local n = getn(XyArray)
--     local csvText = ""
--     for i = 1, n do
--         local xy = XyArray[i]["xy"]
--         if not xy then
--             xy = ""
--         end
--         csvText = csvText .. XyArray[i]["class"] .. "-" .. XyArray[i]["name"] .. "-" .. xy .. "-当前剩余:[" .. XyArray[i]["dkp"] .. "]分" .. "\n"
--     end
--     getglobal("XyExportEdit"):SetText(csvText);
--     getglobal("XyExportFrame"):Show();
-- end



-- editBox:SetText("猎人-老板多点香菜----未许愿----当前剩余:[6]分\n盗贼-张小张-[神圣其拉占卜法杖]-当前剩余:[3]分")

-- -- 添加滚动功能
-- local scrollFrame = CreateFrame("ScrollFrame", "MyAddonScrollFrame", frame, "UIPanelScrollFrameTemplate")
-- scrollFrame:SetSize(490, 200)
-- scrollFrame:SetPoint("TOP", 0, -10)
-- scrollFrame:SetScrollChild(editBox)

-- -- 修正 EditBox 和滚动框的关系
-- editBox:SetScript("OnCursorChanged", function(self, x, y, width, height)
--     local cursorOffset = y + height
--     local scrollHeight = scrollFrame:GetHeight()
--     local maxScroll = math.max(cursorOffset - scrollHeight, 0)
--     scrollFrame:SetVerticalScroll(maxScroll)
-- end)


-- -- 添加关闭按钮
-- local closeButton = CreateFrame("Button", nil, frame, "UIPanelCloseButton")
-- closeButton:SetPoint("TOPRIGHT", frame, "TOPRIGHT", -5, -5)
