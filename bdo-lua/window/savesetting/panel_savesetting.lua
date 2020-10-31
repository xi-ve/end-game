local UI_ANI_ADV = CppEnums.PAUI_ANIM_ADVANCE_TYPE
local PaGlobal_SaveSetting = {
  _ui = {
    _titleArea = nil,
    _btnClose = nil,
    _btnRefresh = nil,
    _Web = nil
  },
  _webSizeX = 470,
  _webSizeY = 345
}
function PaGlobal_Panel_SaveSetting_ShowAni()
  UIAni.fadeInSCR_Down(Panel_SaveSetting)
  local aniInfo1 = Panel_SaveSetting:addScaleAnimation(0, 0.08, UI_ANI_ADV.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfo1:SetStartScale(0.5)
  aniInfo1:SetEndScale(1.2)
  aniInfo1.AxisX = Panel_SaveSetting:GetSizeX() / 2
  aniInfo1.AxisY = Panel_SaveSetting:GetSizeY() / 2
  aniInfo1.ScaleType = 2
  aniInfo1.IsChangeChild = true
  local aniInfo2 = Panel_SaveSetting:addScaleAnimation(0.08, 0.15, UI_ANI_ADV.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfo2:SetStartScale(1.2)
  aniInfo2:SetEndScale(1)
  aniInfo2.AxisX = Panel_SaveSetting:GetSizeX() / 2
  aniInfo2.AxisY = Panel_SaveSetting:GetSizeY() / 2
  aniInfo2.ScaleType = 2
  aniInfo2.IsChangeChild = true
end
function PaGlobal_Panel_SaveSetting_HideAni()
  Panel_SaveSetting:SetAlpha(1)
  local aniInfo = UIAni.AlphaAnimation(0, Panel_SaveSetting, 0, 0.1)
  aniInfo:SetHideAtEnd(true)
end
function PaGlobal_SaveSetting:initialize()
  PaGlobal_SaveSetting._ui._titleArea = UI.getChildControl(Panel_SaveSetting, "StaticText_TitleArea")
  PaGlobal_SaveSetting._ui._btnClose = UI.getChildControl(PaGlobal_SaveSetting._ui._titleArea, "Button_Win_Close")
  PaGlobal_SaveSetting._ui._btnClose:addInputEvent("Mouse_LUp", "PaGlobal_Panel_SaveSetting_Hide()")
  PaGlobal_SaveSetting._ui._btnRefresh = UI.getChildControl(PaGlobal_SaveSetting._ui._titleArea, "Button_Refresh")
  PaGlobal_Util_RegistWebResetControl(PaGlobal_SaveSetting._ui._btnRefresh)
  PaGlobal_SaveSetting._ui._btnRefresh:SetShow(_ContentsGroup_ResetCoherent)
  PaGlobal_SaveSetting._ui._Web = UI.createControl(__ePAUIControl_WebControl, Panel_SaveSetting, "WebControl_SaveSetting")
  PaGlobal_SaveSetting._ui._Web:SetShow(true)
  PaGlobal_SaveSetting._ui._Web:SetHorizonCenter()
  PaGlobal_SaveSetting._ui._Web:SetPosY(60)
  PaGlobal_SaveSetting._ui._Web:SetSize(self._webSizeX, self._webSizeY)
  PaGlobal_SaveSetting._ui._Web:ResetUrl()
  self:registerEventHandler()
end
function PaGlobal_SaveSetting:registerEventHandler()
  if nil == Panel_SaveSetting then
    return
  end
  registerEvent("FromClient_OpenExplorer", "FromClient_OpenExplorer_SaveGameOption")
  registerEvent("FromClient_OnDownloadFromWeb", "FromClient_OnDownloadFromWeb_loadGameOption")
  registerEvent("FromClient_applyGameOptionEnd", "FromClient_applyGameOptionEnd")
  registerEvent("FromClient_NotifyMessageAboutSaveSetting", "FromClient_NotifyMessageAboutSaveSetting")
  Panel_SaveSetting:SetShow(false)
  Panel_SaveSetting:setMaskingChild(true)
  Panel_SaveSetting:setGlassBackground(true)
  Panel_SaveSetting:SetDragAll(true)
  Panel_SaveSetting:RegisterShowEventFunc(true, "PaGlobal_Panel_SaveSetting_ShowAni()")
  Panel_SaveSetting:RegisterShowEventFunc(false, "PaGlobal_Panel_SaveSetting_HideAni()")
end
function PaGlobal_Panel_SaveSetting_Show(ignoreRollBack)
  if nil == getSelfPlayer() then
    return
  end
  Panel_SaveSetting:SetShow(true, true)
  Panel_SaveSetting:SetPosX(getScreenSizeX() / 2 - Panel_SaveSetting:GetSizeX() / 2)
  Panel_SaveSetting:SetPosY(getScreenSizeY() / 2 - Panel_SaveSetting:GetSizeY() / 2)
  if false == ignoreRollBack then
    GameOption_Cancel()
  end
  local myUserNo = getSelfPlayer():get():getUserNo()
  local cryptKey = getSelfPlayer():get():getWebAuthenticKeyCryptString()
  local temporaryWrapper = getTemporaryInformationWrapper()
  local worldNo = temporaryWrapper:getSelectedWorldServerNo()
  local url = PaGlobal_URL_Check(worldNo)
  local fileName = "UserCachePack" .. tostring(myUserNo) .. ".bdcp"
  if nil ~= url then
    local realUrl = url .. "/SaveSettings?userNo=" .. tostring(myUserNo) .. "&certKey=" .. tostring(cryptKey) .. "&fileName=" .. tostring(fileName)
    PaGlobal_SaveSetting._ui._Web:SetIME(false)
    PaGlobal_SaveSetting._ui._Web:SetUrl(470, 345, realUrl, false, true)
  end
end
function PaGlobal_Panel_SaveSetting_Hide()
  audioPostEvent_SystemUi(1, 1)
  _AudioPostEvent_SystemUiForXBOX(1, 1)
  Panel_SaveSetting:SetShow(false, false)
  PaGlobal_SaveSetting._ui._Web:ResetUrl()
end
function PaGlobal_Panel_SaveSetting_WebCall_CheckSafetyzone()
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  local regionInfo = getRegionInfoByPosition(selfPlayer:get():getPosition())
  local isSafeZone = regionInfo:get():isSafeZone()
  return isSafeZone
end
function FromClient_SaveSetting_Initialize()
  PaGlobal_SaveSetting:initialize()
end
function FromClient_OpenExplorer_SaveGameOption(title, defaultName, paramList)
  local paramCount = 0
  local subNameStringBDC = ""
  local myUserNo = getSelfPlayer():get():getUserNo()
  for key, value in pairs(paramList) do
    if ".bdcp" ~= string.sub(value, 1, 5) then
      return
    end
    subNameStringBDC = string.sub(value, 5, -2)
    if "" == subNameStringBDC then
      subNameStringBDC = "_"
    end
    paramCount = paramCount + 1
    if 1 < paramCount then
      return
    end
  end
  ToClient_cacheToPackFile(PaGlobal_SaveSetting._ui._Web, tostring(myUserNo))
end
function FromClient_OnDownloadFromWeb_loadGameOption(path, filename)
  if nil == string.find(filename, ".bdcp", -5) then
    return
  end
  path = path .. filename
  ToClient_packFileToCache(path)
end
function FromClient_applyGameOptionEnd()
  chatting_sendMessage("", PAGetString(Defines.StringSheet_GAME, "LUA_SAVESETTING_APPLYCOMPLETE"), CppEnums.ChatType.System)
  UiSet_update()
end
function FromClient_NotifyMessageAboutSaveSetting()
  local messageBoxMemo = PAGetString(Defines.StringSheet_GAME, "LUA_GAMEOPTION_ISOPTIONVARIABLEACTION_MEMO")
  local messageBoxData = {
    title = PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_ALERT_NOTIFICATIONS"),
    content = messageBoxMemo,
    functionYes = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageBoxData)
end
function FromClient_resetCoherentUIForSaveSetting()
  if Panel_SaveSetting:GetShow() then
    TooltipSimple_Hide()
    PaGlobal_Panel_SaveSetting_Hide()
  end
end
registerEvent("FromClient_luaLoadComplete", "FromClient_SaveSetting_Initialize")
registerEvent("FromClient_resetCoherentUI", "FromClient_resetCoherentUIForSaveSetting")
