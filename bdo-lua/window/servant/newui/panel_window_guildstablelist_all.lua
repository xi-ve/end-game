PaGlobal_GuildStableList_All = {
  _ui = {
    stc_Title = nil,
    btn_Close = nil,
    stc_MainBg = nil,
    stc_SubBg = nil,
    list2_StableList = nil,
    list2_Content = nil,
    list2_BtnBg = nil,
    stc_KeyGuide = nil,
    stc_KeyGuide_B = nil,
    stc_KeyGuide_A = nil,
    stc_KeyGuide_RS = nil
  },
  _servantNo = {},
  _initialize = false
}
registerEvent("FromClient_luaLoadComplete", "FromClient_GuildStableList_All_Init")
function FromClient_GuildStableList_All_Init()
  PaGlobal_GuildStableList_All:initialize()
end
function PaGlobal_GuildStableList_All:initialize()
  if true == PaGlobal_GuildStableList_All._initialize or nil == Panel_GuildStableList_All then
    return
  end
  self._ui.stc_Title = UI.getChildControl(Panel_GuildStableList_All, "Static_MainTitleBar")
  self._ui.btn_Close = UI.getChildControl(self._ui.stc_Title, "Button_Close_PCUI")
  self._ui.stc_MainBg = UI.getChildControl(Panel_GuildStableList_All, "Static_MainBg")
  self._ui.stc_SubBg = UI.getChildControl(Panel_GuildStableList_All, "Static_SubTitleBG")
  self._ui.list2_StableList = UI.getChildControl(self._ui.stc_MainBg, "List2_Stable")
  self._ui.list2_Content = UI.getChildControl(self._ui.list2_StableList, "List2_1_Content")
  self._ui.list2_BtnBg = UI.getChildControl(self._ui.list2_Content, "Button_ListObject")
  self._ui.stc_KeyGuide = UI.getChildControl(Panel_GuildStableList_All, "Static_KeyGuideArea_ConsoleUI")
  self._ui.stc_KeyGuide_B = UI.getChildControl(self._ui.stc_KeyGuide, "StaticText_B")
  self._ui.stc_KeyGuide_A = UI.getChildControl(self._ui.stc_KeyGuide, "StaticText_A")
  Panel_GuildStableList_All:SetHorizonCenter()
  Panel_GuildStableList_All:SetVerticalMiddle()
  Panel_GuildStableList_All:SetSpanSize(0, 0)
  PaGlobal_GuildStableList_All:validate()
  PaGlobal_GuildStableList_All:registEventHandler()
  PaGlobal_GuildStableList_All:swichPlatform(_ContentsGroup_UsePadSnapping)
  PaGlobal_GuildStableList_All._initialize = true
end
function PaGlobal_GuildStableList_All:registEventHandler()
  if nil == Panel_GuildStableList_All then
    return
  end
  registerEvent("FromClient_GuildServantListUpdate", "PaGlobal_GuildStableList_All_Update")
  registerEvent("FromClient_ServantUnseal", "PaGlobal_GuildStableList_All_Update")
  registerEvent("FromClient_ServantSeal", "PaGlobal_GuildStableList_All_Update")
  registerEvent("onScreenResize", "PaGlobal_GuildStableList_All_OnScreenResize")
  self._ui.list2_StableList:registEvent(__ePAUIList2EventType_LuaChangeContent, "FromClient_GuildStableList_All_List2Update")
  self._ui.list2_StableList:createChildContent(__ePAUIList2ElementManagerType_List)
end
function PaGlobal_GuildStableList_All:swichPlatform(isConsole)
  self._ui.stc_KeyGuide:SetShow(isConsole)
  self._ui.btn_Close:SetShow(not isConsole)
  if true == isConsole then
    local keyGuild = {
      self._ui.stc_KeyGuide_A,
      self._ui.stc_KeyGuide_B
    }
    PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyGuild, self._ui.stc_KeyGuide, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHT)
    Panel_GuildStableList_All:ignorePadSnapMoveToOtherPanel()
  else
    self._ui.btn_Close:addInputEvent("Mouse_LUp", "PaGlobal_GuildStableList_All_Close()")
  end
end
function PaGlobal_GuildStableList_All:prepareOpen()
  if nil == Panel_GuildStableList_All then
    return
  end
  PaGlobal_GuildStableList_All:open()
  PaGlobal_GuildStableList_All:update()
end
function PaGlobal_GuildStableList_All:update()
  local totalCount = guildstable_getUnsealGuildServantCount()
  self._ui.list2_StableList:getElementManager():clearKey()
  self._servantNo = {}
  if totalCount <= 0 or nil == totalCount then
    return
  end
  local contentCount = math.max(3, totalCount)
  self._ui.list2_StableList:SetSize(self._ui.list2_StableList:GetSizeX(), self._ui.list2_Content:GetSizeY() * contentCount)
  Panel_GuildStableList_All:SetSize(Panel_GuildStableList_All:GetSizeX(), self._ui.stc_Title:GetSizeY() + self._ui.list2_StableList:GetSizeY() + self._ui.stc_SubBg:GetSizeY() + 15)
  self._ui.stc_MainBg:SetSize(self._ui.stc_MainBg:GetSizeX(), math.abs(Panel_GuildStableList_All:GetSizeY() - (self._ui.stc_Title:GetSizeY() + self._ui.stc_SubBg:GetSizeY())))
  if true == _ContentsGroup_UsePadSnapping then
    self._ui.stc_KeyGuide:ComputePos()
    Panel_GuildStableList_All:ComputePos()
  end
  for idx = 0, totalCount - 1 do
    self._ui.list2_StableList:getElementManager():pushKey(toInt64(0, idx))
  end
end
function PaGlobal_GuildStableList_All:open()
  if nil == Panel_GuildStableList_All then
    return
  end
  Panel_GuildStableList_All:SetShow(true)
end
function PaGlobal_GuildStableList_All:prepareClose()
  if nil == Panel_GuildStableList_All then
    return
  end
  TooltipSimple_Hide()
  PaGlobal_GuildStableList_All:close()
end
function PaGlobal_GuildStableList_All:close()
  if nil == Panel_GuildStableList_All then
    return
  end
  Panel_GuildStableList_All:SetShow(false)
end
function PaGlobal_GuildStableList_All:validate()
  if nil == Panel_GuildStableList_All then
    return
  end
  self._ui.stc_Title:isValidate()
  self._ui.btn_Close:isValidate()
  self._ui.stc_MainBg:isValidate()
  self._ui.list2_StableList:isValidate()
  self._ui.list2_Content:isValidate()
  self._ui.list2_BtnBg:isValidate()
  self._ui.stc_KeyGuide:isValidate()
  self._ui.stc_KeyGuide_B:isValidate()
  self._ui.stc_KeyGuide_A:isValidate()
end
function FGlobal_GuildServantList_Open()
  if true == Panel_GuildStableList_All:GetShow() then
    PaGlobal_GuildStableList_All:prepareClose()
    return
  end
  PaGlobal_GuildStableList_All:prepareOpen()
end
function PaGlobal_GuildStableList_All_Close()
  if false == Panel_GuildStableList_All:GetShow() then
    return
  end
  PaGlobal_GuildStableList_All:prepareClose()
end
function PaGlobal_GuildStableList_All_Update()
  if false == Panel_GuildStableList_All:GetShow() then
    return
  end
  PaGlobal_GuildStableList_All:update()
end
function FromClient_GuildStableList_All_List2Update(content, key)
  local guildServantCount = guildstable_getUnsealGuildServantCount()
  local temporaryWrapper = getTemporaryInformationWrapper()
  if nil == temporaryWrapper then
    return
  end
  local key32 = Int64toInt32(key)
  local worldNo = temporaryWrapper:getSelectedWorldServerNo()
  local servantWrapper = guildStable_getUnsealGuildServantAt(key32)
  if nil == servantWrapper then
    content:SetShow(false)
  end
  content:SetShow(true)
  local bg = UI.getChildControl(content, "Button_ListObject")
  local txt_Name = UI.getChildControl(bg, "StaticText_Name")
  local txt_ServerName = UI.getChildControl(bg, "StaticText_Server")
  local servantName = servantWrapper:getName()
  local servantNo = servantWrapper:getServantNo()
  local servantServerNo = servantWrapper:getServerNo()
  local channelName = getChannelName(worldNo, servantServerNo)
  local vehicleType = servantWrapper:getServantType()
  txt_Name:SetTextMode(__eTextMode_LimitText)
  txt_ServerName:SetTextMode(__eTextMode_LimitText)
  txt_Name:SetText(servantName)
  if nil == channelName then
    channelName = ""
  end
  txt_ServerName:SetText(channelName)
  local isCallAble = CppEnums.ServantType.Type_Ship ~= vehicleType
  PaGlobal_GuildStableList_All._servantNo[key32] = servantNo
  if true == isCallAble then
    bg:addInputEvent("Mouse_LUp", "HandleEventLUp_GuildStableList_All_CallServent( " .. tostring(key32) .. ")")
  else
    bg:addInputEvent("Mouse_LUp", "")
  end
  if false == _ContentsGroup_UsePadSnapping and isCallAble then
    bg:addInputEvent("Mouse_On", "HandleEventOnOut_GuildStableList_PCTooltip(" .. tostring(key32) .. ",true)")
    bg:addInputEvent("Mouse_Out", "HandleEventOnOut_GuildStableList_PCTooltip(" .. tostring(key32) .. ",false)")
  else
    bg:addInputEvent("Mouse_On", "HandleEventOnOut_GuildStableList_SetKeyGuide(" .. tostring(isCallAble) .. ")")
    bg:addInputEvent("Mouse_Out", "")
  end
end
function HandleEventOnOut_GuildStableList_PCTooltip(key, isShow)
  if nil == key or false == isShow then
    TooltipSimple_Hide()
    return
  end
  local content = PaGlobal_GuildStableList_All._ui.list2_StableList:GetContentByKey(key)
  if nil == content then
    TooltipSimple_Hide()
    return
  end
  local bg = UI.getChildControl(content, "Button_ListObject")
  local txt_name = UI.getChildControl(bg, "StaticText_Name"):GetText()
  local name = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GUILDSTABLELIST_PCTOOLTIP", "servantName", txt_name)
  TooltipSimple_Show(bg, name, nil)
end
function HandleEventLUp_GuildStableList_All_CallServent(idx)
  if nil == idx or nil == PaGlobal_GuildStableList_All._servantNo or nil == PaGlobal_GuildStableList_All._servantNo[idx] then
    return
  end
  local servantNo = PaGlobal_GuildStableList_All._servantNo[idx]
  if nil == servantNo then
    return
  end
  servant_callGuildServant(servantNo)
end
function HandleEventOnOut_GuildStableList_SetKeyGuide(isCallAble)
  PaGlobal_GuildStableList_All._ui.stc_KeyGuide_A:SetShow(isCallAble)
end
function PaGlobal_GuildStableList_All_OnScreenResize()
  if false == Panel_GuildStableList_All:GetShow() then
    return
  end
  Panel_GuildStableList_All:ComputePos()
end
