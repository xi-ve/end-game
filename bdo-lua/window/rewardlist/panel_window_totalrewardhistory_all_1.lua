function PaGlobal_TotalRewardHistory_All:initialize()
  if nil == Panel_Window_TotalReward_All then
    return
  end
  if true == PaGlobal_TotalRewardHistory_All._initialize then
    return
  end
  PaGlobal_TotalRewardHistory_All._isConsole = _ContentsGroup_UsePadSnapping
  PaGlobal_TotalRewardHistory_All._mainControl = UI.getChildControl(Panel_Window_TotalReward_All, "Static_TotalRewardHistory")
  PaGlobal_TotalRewardHistory_All._ui.frame_itemLog = UI.getChildControl(PaGlobal_TotalRewardHistory_All._mainControl, "Frame_ItemLog")
  PaGlobal_TotalRewardHistory_All._ui.frame_itemLog_content = UI.getChildControl(PaGlobal_TotalRewardHistory_All._ui.frame_itemLog, "Frame_1_Content")
  PaGlobal_TotalRewardHistory_All._ui.frame_itemLog_vscroll = UI.getChildControl(PaGlobal_TotalRewardHistory_All._ui.frame_itemLog, "Frame_1_VerticalScroll")
  PaGlobal_TotalRewardHistory_All._ui.frame_itemLog_vscroll_ctrl = UI.getChildControl(PaGlobal_TotalRewardHistory_All._ui.frame_itemLog_vscroll, "Frame_1_VerticalScroll_CtrlButton")
  PaGlobal_TotalRewardHistory_All._ui.txt_noLog = UI.getChildControl(PaGlobal_TotalRewardHistory_All._mainControl, "StaticText_ItemLog_Widget_NoLog")
  PaGlobal_TotalRewardHistory_All._ui.txt_dateTitle = UI.getChildControl(PaGlobal_TotalRewardHistory_All._ui.frame_itemLog_content, "StaticText_DateTitle_Template")
  PaGlobal_TotalRewardHistory_All._ui.stc_itemLog = UI.getChildControl(PaGlobal_TotalRewardHistory_All._ui.frame_itemLog_content, "StaticText_ItemLog_Template")
  PaGlobal_TotalRewardHistory_All._ui.stc_keyGuideBg = UI.getChildControl(PaGlobal_TotalRewardHistory_All._mainControl, "Static_HistoryGuide_ConsoleUI")
  PaGlobal_TotalRewardHistory_All._ui.stc_keyGuideScroll = UI.getChildControl(PaGlobal_TotalRewardHistory_All._ui.stc_keyGuideBg, "StaticText_Scroll_ConsoleUI")
  PaGlobal_TotalRewardHistory_All._ui.txt_dateTitle:SetShow(false)
  PaGlobal_TotalRewardHistory_All._ui.stc_itemLog:SetShow(false)
  PaGlobal_TotalRewardHistory_All:registEventHandler()
  PaGlobal_TotalRewardHistory_All:validate()
  PaGlobal_TotalRewardHistory_All._initialize = true
end
function PaGlobal_TotalRewardHistory_All:registEventHandler()
  if nil == PaGlobal_TotalRewardHistory_All._mainControl then
    return
  end
  registerEvent("FromClient_PendingRewardLogUpdated", "FromClient_TotalRewardHistory_All_PendingRewardLogUpdated")
end
function PaGlobal_TotalRewardHistory_All:prepareOpen()
  if nil == PaGlobal_TotalRewardHistory_All._mainControl then
    return
  end
  PaGlobal_TotalRewardHistory_All._ui.frame_itemLog:GetVScroll():SetControlTop()
  PaGlobal_TotalRewardHistory_All:setStartPos()
  PaGlobal_TotalRewardHistory_All:update()
  PaGlobal_TotalRewardHistory_All:open()
end
function PaGlobal_TotalRewardHistory_All:open()
  if nil == PaGlobal_TotalRewardHistory_All._mainControl then
    return
  end
  PaGlobal_TotalRewardHistory_All._mainControl:SetShow(true)
end
function PaGlobal_TotalRewardHistory_All:prepareClose()
  if nil == PaGlobal_TotalRewardHistory_All._mainControl then
    return
  end
  PaGlobal_TotalRewardHistory_All:close()
end
function PaGlobal_TotalRewardHistory_All:close()
  if nil == PaGlobal_TotalRewardHistory_All._mainControl then
    return
  end
  PaGlobal_TotalRewardHistory_All._mainControl:SetShow(false)
end
function PaGlobal_TotalRewardHistory_All:setStartPos()
  if nil == PaGlobal_TotalRewardHistory_All._mainControl then
    return
  end
  if nil == Panel_Window_TotalReward_All then
    return
  end
  PaGlobal_TotalRewardHistory_All._mainControl:ComputePos()
end
function PaGlobal_TotalRewardHistory_All:update()
  if nil == PaGlobal_TotalRewardHistory_All._mainControl then
    return
  end
  for index, control in pairs(PaGlobal_TotalRewardHistory_All._itemLogControl) do
    if nil ~= control then
      control:SetShow(false)
    end
  end
  local logCount = ToClient_GetPendingRewardLogCount()
  if nil == logCount then
    return
  end
  logCount = Int64toInt32(logCount)
  if 0 < logCount then
    PaGlobal_TotalRewardHistory_All:setLogData(logCount)
    PaGlobal_TotalRewardHistory_All:setLogPosition()
    PaGlobal_TotalRewardHistory_All._ui.txt_noLog:SetShow(false)
  else
    PaGlobal_TotalRewardHistory_All._ui.txt_noLog:SetShow(true)
  end
  PaGlobal_TotalRewardHistory_All._ui.frame_itemLog:UpdateContentScroll()
  PaGlobal_TotalRewardHistory_All._ui.frame_itemLog:UpdateContentPos()
  if true == PaGlobal_TotalRewardHistory_All._isConsole and true == PaGlobal_TotalRewardHistory_All._ui.frame_itemLog_vscroll:GetShow() then
    PaGlobal_TotalRewardHistory_All._ui.stc_keyGuideBg:SetShow(true)
    local keyGuides = {
      PaGlobal_TotalRewardHistory_All._ui.stc_keyGuideScroll
    }
    PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyGuides, PaGlobal_TotalRewardHistory_All._ui.stc_keyGuideBg, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP)
  else
    PaGlobal_TotalRewardHistory_All._ui.stc_keyGuideBg:SetShow(false)
  end
end
function PaGlobal_TotalRewardHistory_All:setLogData(logCount)
  PaGlobal_TotalRewardHistory_All._logTable = {}
  local beforeMonth = 0
  local beforeDay = 0
  for ii = 1, logCount do
    local logDate = ToClient_GetPendingRewardLogDateByIndex(ii - 1)
    local rewardKey = ToClient_GetPendingRewardLogTypeByIndex(ii - 1)
    local itemKey = ToClient_GetPendingRewardLogItemKeyByIndex(ii - 1)
    local itemCount = ToClient_GetPendingRewardLogItemCountByIndex(ii - 1)
    if nil == logDate or nil == rewardKey or nil == itemKey or nil == itemCount then
      return
    end
    local timeValue = PATime(logDate)
    if beforeMonth ~= tostring(timeValue:GetMonth()) or beforeDay ~= tostring(timeValue:GetDay()) then
      local timeStr = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_TOTALREWARD_ITEMLOG_DATE", "month", tostring(timeValue:GetMonth()), "day", tostring(timeValue:GetDay()))
      PaGlobal_TotalRewardHistory_All._logTable[#PaGlobal_TotalRewardHistory_All._logTable + 1] = {}
      PaGlobal_TotalRewardHistory_All._logTable[#PaGlobal_TotalRewardHistory_All._logTable].text = timeStr
      PaGlobal_TotalRewardHistory_All._logTable[#PaGlobal_TotalRewardHistory_All._logTable].color = Defines.Color.C_FFFFFFFF
    end
    beforeMonth = tostring(timeValue:GetMonth())
    beforeDay = tostring(timeValue:GetDay())
    local itemStatic = getItemEnchantStaticStatus(ItemEnchantKey(itemKey))
    if nil == itemStatic then
      return
    end
    local itemNameColor = PaGlobal_TotalRewardHistory_All:getItemGradeColor(itemStatic:getGradeType())
    local itemName = "<PAColor0x" .. itemNameColor .. ">[" .. itemStatic:getName() .. "]<PAOldColor>"
    local category = PAGetString(Defines.StringSheet_GAME, "LUA_TOTALREWARD_CATEGORY_" .. rewardKey)
    local logText = PAGetStringParam3(Defines.StringSheet_GAME, "LUA_TOTALREWARD_ITEMLOG_TEXT", "itemName", itemName, "itemCount", makeDotMoney(itemCount), "category", category)
    PaGlobal_TotalRewardHistory_All._logTable[#PaGlobal_TotalRewardHistory_All._logTable + 1] = {}
    PaGlobal_TotalRewardHistory_All._logTable[#PaGlobal_TotalRewardHistory_All._logTable].text = logText
  end
end
function PaGlobal_TotalRewardHistory_All:setLogPosition()
  local nextPosY = 0
  for ii = 1, #PaGlobal_TotalRewardHistory_All._logTable do
    if nil == PaGlobal_TotalRewardHistory_All._logTable[ii] then
      return
    end
    local control = PaGlobal_TotalRewardHistory_All._itemLogControl[ii]
    if nil == control then
      if PaGlobal_TotalRewardHistory_All._logTable[ii].color ~= nil then
        control = UI.createAndCopyBasePropertyControl(PaGlobal_TotalRewardHistory_All._ui.frame_itemLog_content, "StaticText_DateTitle_Template", PaGlobal_TotalRewardHistory_All._ui.frame_itemLog_content, "TotalReward_ItemLog_" .. ii)
      else
        control = UI.createAndCopyBasePropertyControl(PaGlobal_TotalRewardHistory_All._ui.frame_itemLog_content, "StaticText_ItemLog_Template", PaGlobal_TotalRewardHistory_All._ui.frame_itemLog_content, "TotalReward_ItemLog_" .. ii)
      end
      if nil ~= control then
        PaGlobal_TotalRewardHistory_All._itemLogControl[ii] = control
      end
    else
      local template
      if PaGlobal_TotalRewardHistory_All._logTable[ii].color ~= nil then
        template = PaGlobal_TotalRewardHistory_All._ui.txt_dateTitle
      else
        template = PaGlobal_TotalRewardHistory_All._ui.stc_itemLog
      end
      CopyBaseProperty(template, control)
    end
    if nil == control then
      return
    end
    control:SetShow(true)
    control:SetTextMode(__eTextMode_AutoWrap)
    control:SetText(PaGlobal_TotalRewardHistory_All._logTable[ii].text)
    control:SetPosY(nextPosY)
    control:SetSize(control:GetSizeX(), control:GetTextSizeY() + 2)
    if PaGlobal_TotalRewardHistory_All._logTable[ii].color ~= nil then
      control:SetFontColor(PaGlobal_TotalRewardHistory_All._logTable[ii].color)
      nextPosY = nextPosY + 10
      control:SetPosY(nextPosY)
      nextPosY = nextPosY + 5
    else
      control:ChangeTextureInfoName("")
      control:setRenderTexture(control:getBaseTexture())
    end
    nextPosY = nextPosY + control:GetTextSizeY() + 5
  end
  PaGlobal_TotalRewardHistory_All._ui.frame_itemLog_content:SetSize(PaGlobal_TotalRewardHistory_All._ui.frame_itemLog:GetSizeX(), nextPosY)
end
function PaGlobal_TotalRewardHistory_All:getItemGradeColor(grade)
  local itemNameColor = "FFFFFFFF"
  if 0 == grade then
    itemNameColor = "FFFFFFFF"
  elseif 1 == grade then
    itemNameColor = "FF5DFF70"
  elseif 2 == grade then
    itemNameColor = "FF4B97FF"
  elseif 3 == grade then
    itemNameColor = "FFFFC832"
  elseif 4 == grade then
    itemNameColor = "FFFF6C00"
  end
  return itemNameColor
end
function PaGlobal_TotalRewardHistory_All:validate()
  if nil == PaGlobal_TotalRewardHistory_All._mainControl then
    return
  end
  PaGlobal_TotalRewardHistory_All._ui.frame_itemLog:isValidate()
  PaGlobal_TotalRewardHistory_All._ui.frame_itemLog_content:isValidate()
  PaGlobal_TotalRewardHistory_All._ui.frame_itemLog_vscroll:isValidate()
  PaGlobal_TotalRewardHistory_All._ui.frame_itemLog_vscroll_ctrl:isValidate()
  PaGlobal_TotalRewardHistory_All._ui.txt_noLog:isValidate()
  PaGlobal_TotalRewardHistory_All._ui.txt_dateTitle:isValidate()
  PaGlobal_TotalRewardHistory_All._ui.stc_itemLog:isValidate()
  PaGlobal_TotalRewardHistory_All._ui.stc_keyGuideBg:isValidate()
  PaGlobal_TotalRewardHistory_All._ui.stc_keyGuideScroll:isValidate()
end
