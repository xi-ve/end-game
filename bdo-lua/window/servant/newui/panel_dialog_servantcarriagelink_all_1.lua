function PaGlobal_ServantCarriageLink_All:initialize()
  if nil == Panel_Dialog_ServantCarriageLink_All or true == self.initialize then
    return
  end
  self._ui._stc_TitleBG = UI.getChildControl(Panel_Dialog_ServantCarriageLink_All, "Static_TitleBg")
  self._ui._stc_TitleIcon = UI.getChildControl(self._ui._stc_TitleBG, "StaticText_TitleIcon")
  self._ui._btn_Close_PC = UI.getChildControl(self._ui._stc_TitleBG, "Button_Close")
  self._ui._btn_Question_PC = UI.getChildControl(self._ui._stc_TitleBG, "Button_Question")
  self._ui._btn_Question_PC:SetShow(false)
  self._ui._stc_MainBg = UI.getChildControl(Panel_Dialog_ServantCarriageLink_All, "Static_MainBg")
  self._ui._txt_NoCarriage = UI.getChildControl(self._ui._stc_MainBg, "StaticText_NoCarriage")
  self._ui._txt_NoHorse = UI.getChildControl(self._ui._stc_MainBg, "StaticText_NoHorse")
  self._ui._txt_NoCarriage:SetTextMode(__eTextMode_AutoWrap)
  self._ui._txt_NoCarriage:SetText(self._ui._txt_NoCarriage:GetText())
  self._ui._txt_NoHorse:SetTextMode(__eTextMode_AutoWrap)
  self._ui._txt_NoHorse:SetText(self._ui._txt_NoHorse:GetText())
  self._ui._stc_MouseGuideArea = UI.getChildControl(self._ui._stc_MainBg, "Static_MouseGuideArea")
  self._ui._txt_LClick = UI.getChildControl(self._ui._stc_MouseGuideArea, "StaticText_LClick")
  self._ui._txt_RClick = UI.getChildControl(self._ui._stc_MouseGuideArea, "StaticText_RClick")
  self._ui._list2_Carriage = UI.getChildControl(self._ui._stc_MainBg, "List2_Carriage")
  self._ui._list2_Carriage_Content = UI.getChildControl(self._ui._list2_Carriage, "List2_1_Content")
  self._ui._list2_Carriage_Slot = UI.getChildControl(self._ui._list2_Carriage_Content, "RadioButton_CarriageSlot")
  self._ui._list2_NoEnduranceBg = UI.getChildControl(self._ui._list2_Carriage_Content, "Static_NoEnduranceBg")
  self._ui._list2_Carriage_CarriageIcon = UI.getChildControl(self._ui._list2_Carriage_Content, "Static_CarriageIcon")
  self._ui._list2_Carriage_Name = UI.getChildControl(self._ui._list2_Carriage_Content, "StaticText_CarriageName")
  self._ui._list2_Carriage_RegionName = UI.getChildControl(self._ui._list2_Carriage_Content, "StaticText_RegionName")
  self._ui._list2_Carriage_SlotCount = UI.getChildControl(self._ui._list2_Carriage_Content, "StaticText_SlotCount")
  self._ui._list2_Carriage_VertiScroll = UI.getChildControl(self._ui._list2_Carriage, "List2_1_VerticalScroll")
  self._ui._list2_Carriage_VertiScroll_Up = UI.getChildControl(self._ui._list2_Carriage_VertiScroll, "List2_1_VerticalScroll_UpButton")
  self._ui._list2_Carriage_VertiScroll_Down = UI.getChildControl(self._ui._list2_Carriage_VertiScroll, "List2_1_VerticalScroll_DownButton")
  self._ui._list2_Carriage_VertiScroll_Ctrl = UI.getChildControl(self._ui._list2_Carriage_VertiScroll, "List2_1_VerticalScroll_CtrlButton")
  self._ui._List2_Carriage_HoriScroll = UI.getChildControl(self._ui._list2_Carriage, "List2_1_HorizontalScroll")
  self._ui._List2_Carriage_HoriScroll_Up = UI.getChildControl(self._ui._List2_Carriage_HoriScroll, "List2_1_HorizontalScroll_UpButton")
  self._ui._List2_Carriage_HoriScroll_Down = UI.getChildControl(self._ui._List2_Carriage_HoriScroll, "List2_1_HorizontalScroll_DownButton")
  self._ui._List2_Carriage_HoriScroll_Ctrl = UI.getChildControl(self._ui._List2_Carriage_HoriScroll, "List2_1_HorizontalScroll_CtrlButton")
  self._ui._list2_Horse = UI.getChildControl(self._ui._stc_MainBg, "List2_Horse")
  self._ui._list2_Horse_Content = UI.getChildControl(self._ui._list2_Horse, "List2_1_Content")
  self._ui._list2_Horse_HorseSlot = UI.getChildControl(self._ui._list2_Horse_Content, "CheckButton_HorseSlot")
  self._ui._list2_Horse_IconBg = UI.getChildControl(self._ui._list2_Horse_Content, "Static_IconBg")
  self._ui._list2_Horse_Icon = UI.getChildControl(self._ui._list2_Horse_Content, "Static_Icon")
  self._ui._list2_Horse_LinkIcon = UI.getChildControl(self._ui._list2_Horse_Content, "Static_LinkIcon")
  self._ui._list2_Horse_Level_Name = UI.getChildControl(self._ui._list2_Horse_Content, "StaticText_LevelAndName")
  self._ui._list2_Horse_RegionName = UI.getChildControl(self._ui._list2_Horse_Content, "StaticText_RegionName")
  self._ui._list2_Horse_Tier = UI.getChildControl(self._ui._list2_Horse_Content, "StaticText_Tier")
  self._ui._list2_Horse_State = UI.getChildControl(self._ui._list2_Horse_Content, "StaticText_State")
  self._ui._list2_Horse_VertiScroll = UI.getChildControl(self._ui._list2_Horse, "List2_1_VerticalScroll")
  self._ui._list2_Horse_VertiScroll_Up = UI.getChildControl(self._ui._list2_Horse_VertiScroll, "List2_1_VerticalScroll_UpButton")
  self._ui._list2_Horse_VertiScroll_Down = UI.getChildControl(self._ui._list2_Horse_VertiScroll, "List2_1_VerticalScroll_DownButton")
  self._ui._list2_Horse_VertiScroll_Ctrl = UI.getChildControl(self._ui._list2_Horse_VertiScroll, "List2_1_VerticalScroll_CtrlButton")
  self._ui._List2_Horse_HoriScroll = UI.getChildControl(self._ui._list2_Horse, "List2_1_HorizontalScroll")
  self._ui._List2_Horse_HoriScroll_Up = UI.getChildControl(self._ui._List2_Horse_HoriScroll, "List2_1_HorizontalScroll_UpButton")
  self._ui._List2_Horse_HoriScroll_Down = UI.getChildControl(self._ui._List2_Horse_HoriScroll, "List2_1_HorizontalScroll_DownButton")
  self._ui._List2_Horse_HoriScroll_Ctrl = UI.getChildControl(self._ui._List2_Horse_HoriScroll, "List2_1_HorizontalScroll_CtrlButton")
  self._ui._btn_Link_PC = UI.getChildControl(Panel_Dialog_ServantCarriageLink_All, "Button_Link_PCUI")
  self._ui._btn_Cancel_PC = UI.getChildControl(Panel_Dialog_ServantCarriageLink_All, "Button_Cancel_PCUI")
  self._ui._stc_Bottom_KeyGuides = UI.getChildControl(Panel_Dialog_ServantCarriageLink_All, "Static_BottomBg_ConsoleUI")
  self._ui._stc_KeyGuide_A = UI.getChildControl(self._ui._stc_Bottom_KeyGuides, "StaticText_A_ConsoleUI")
  self._ui._stc_KeyGuide_B = UI.getChildControl(self._ui._stc_Bottom_KeyGuides, "StaticText_B_ConsoleUI")
  self._ui._stc_KeyGuide_Y = UI.getChildControl(self._ui._stc_Bottom_KeyGuides, "StaticText_Y_ConsoleUI")
  self._isConsole = _ContentsGroup_UsePadSnapping
  PaGlobal_ServantCarriageLink_All:validate()
  PaGlobal_ServantCarriageLink_All:isConsoleUI(self._isConsole)
  PaGlobal_ServantCarriageLink_All:registerEventHandler(self._isConsole)
end
function PaGlobal_ServantCarriageLink_All:registerEventHandler(isConsole)
  if nil == Panel_Dialog_ServantCarriageLink_All or false == self._initialize then
    return
  end
  self._ui._list2_Carriage:registEvent(__ePAUIList2EventType_LuaChangeContent, "PaGlobalFunc_ServantCarriageLink_All_List2UpdateCarriage")
  self._ui._list2_Carriage:createChildContent(__ePAUIList2ElementManagerType_List)
  self._ui._list2_Horse:registEvent(__ePAUIList2EventType_LuaChangeContent, "PaGlobalFunc_ServantCarriageLink_All_List2UpdateHorse")
  self._ui._list2_Horse:createChildContent(__ePAUIList2ElementManagerType_List)
  registerEvent("onScreenResize", "PaGlobalFunc_ServantCarriageLink_All_OnScreenResize")
  if false == isConsole then
    self._ui._btn_Link_PC:addInputEvent("Mouse_LUp", "HandleEventLUp_ServantCarriageLink_All_UnLinkAll()")
    self._ui._btn_Cancel_PC:addInputEvent("Mouse_LUp", "PaGlobalFunc_ServantFunction_All_Close()")
    self._ui._btn_Close_PC:addInputEvent("Mouse_LUp", "PaGlobalFunc_ServantFunction_All_Close()")
    Panel_Dialog_ServantCarriageLink_All:SetDragEnable(true)
    Panel_Dialog_ServantCarriageLink_All:SetDragAll(true)
  else
    Panel_Dialog_ServantCarriageLink_All:ignorePadSnapMoveToOtherPanel()
    Panel_Dialog_ServantCarriageLink_All:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "HandleEventLUp_ServantCarriageLink_All_UnLinkAll()")
    Panel_Dialog_ServantCarriageLink_All:registerPadEvent(__eConsoleUIPadEvent_LB, "HandleEventPadPress_ServantFunction_All_ChangeTab(false)")
    Panel_Dialog_ServantCarriageLink_All:registerPadEvent(__eConsoleUIPadEvent_RB, "HandleEventPadPress_ServantFunction_All_ChangeTab(true)")
  end
end
function PaGlobal_ServantCarriageLink_All:isConsoleUI(isConsole)
  if nil == Panel_Dialog_ServantCarriageLink_All or false == self._initialize then
    return
  end
  self._ui._stc_Bottom_KeyGuides:SetShow(isConsole)
  self._ui._btn_Close_PC:SetShow(not isConsole)
  self._ui._btn_Link_PC:SetShow(not isConsole)
  self._ui._btn_Cancel_PC:SetShow(not isConsole)
  self._ui._stc_MouseGuideArea:SetShow(not isConsole)
  if false == isConsole then
  else
    local btnSize = self._ui._btn_Cancel_PC:GetSizeY() + 20
    Panel_Dialog_ServantCarriageLink_All:SetSize(Panel_Dialog_ServantCarriageLink_All:GetSizeX(), Panel_Dialog_ServantCarriageLink_All:GetSizeY() - btnSize)
    self._ui._list2_Horse:SetSize(self._ui._list2_Horse:GetSizeX(), Panel_Dialog_ServantCarriageLink_All:GetSizeY())
    self._ui._stc_Bottom_KeyGuides:SetSpanSize(self._ui._stc_Bottom_KeyGuides:GetSpanSize().x, self._ui._stc_Bottom_KeyGuides:GetSpanSize().y, -btnSize)
    local keyguide = {
      self._ui._stc_KeyGuide_Y,
      self._ui._stc_KeyGuide_A,
      self._ui._stc_KeyGuide_B
    }
    PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyguide, self._ui._stc_Bottom_KeyGuides, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP)
    self._ui._list2_Horse:SetSize(self._ui._list2_Horse:GetSizeX(), self._ui._list2_Horse:GetSizeY() - btnSize)
  end
end
function PaGlobal_ServantCarriageLink_All:prepareOpen()
  if nil == Panel_Dialog_ServantCarriageLink_All or true == Panel_Dialog_ServantCarriageLink_All:GetShow() then
    return
  end
  self._currentCarriageIndex = nil
  PaGlobal_ServantCarriageLink_All:open()
  PaGlobalFunc_ServantCarriageLink_All_OnScreenResize()
  PaGlobal_ServantCarriageLink_All:update()
end
function PaGlobal_ServantCarriageLink_All:open()
  if nil == Panel_Dialog_ServantCarriageLink_All or true == Panel_Dialog_ServantCarriageLink_All:GetShow() then
    return
  end
  Panel_Dialog_ServantCarriageLink_All:SetShow(true)
end
function PaGlobal_ServantCarriageLink_All:update()
  if nil == Panel_Dialog_ServantCarriageLink_All then
    return
  end
  local servantCount = stable_count()
  local regionInfo = getRegionInfoByPosition(getSelfPlayer():get():getPosition())
  local currentRegionKey = regionInfo:getRegionKey()
  local ENUMCARRIAGE = CppEnums.VehicleType.Type_Carriage
  local ENUMREPAIRABLE_CARRIAGE = CppEnums.VehicleType.Type_RepairableCarriage
  self._ui._txt_NoCarriage:SetShow(false)
  self._ui._txt_NoHorse:SetShow(false)
  self._ui._list2_Carriage:getElementManager():clearKey()
  local carriageCount = 0
  for idx = 0, servantCount - 1 do
    local servantInfo = stable_getServant(idx)
    local servantRegionKey = servantInfo:getRegionKeyRaw()
    local servantType = servantInfo:getVehicleType()
    if currentRegionKey == servantRegionKey and (servantType == ENUMCARRIAGE or servantType == ENUMREPAIRABLE_CARRIAGE) then
      carriageCount = carriageCount + 1
      self._ui._list2_Carriage:getElementManager():pushKey(toInt64(0, idx))
    end
  end
  if carriageCount <= 0 then
    self._ui._txt_NoCarriage:SetShow(true)
    self._ui._txt_NoHorse:SetShow(true)
  end
  self._ui._txt_LClick:SetTextMode(__eTextMode_Limit_AutoWrap)
  self._ui._txt_LClick:setLineCountByLimitAutoWrap(2)
  self._ui._txt_LClick:SetText(self._ui._txt_LClick:GetText())
  if true == self._ui._txt_LClick:IsLimitText() then
    self._ui._txt_LClick:addInputEvent("Mouse_On", "HandleEventOnOut_Dialog_ServantCarriageLink_All_ShowMouseToolTip(true , true)")
    self._ui._txt_LClick:addInputEvent("Mouse_Out", "HandleEventOnOut_Dialog_ServantCarriageLink_All_ShowMouseToolTip(true , false)")
  else
    self._ui._txt_LClick:addInputEvent("Mouse_On", "")
    self._ui._txt_LClick:addInputEvent("Mouse_Out", "")
  end
  self._ui._txt_RClick:SetTextMode(__eTextMode_Limit_AutoWrap)
  self._ui._txt_RClick:setLineCountByLimitAutoWrap(2)
  self._ui._txt_RClick:SetText(self._ui._txt_RClick:GetText())
  if true == self._ui._txt_RClick:IsLimitText() then
    self._ui._txt_RClick:addInputEvent("Mouse_On", "HandleEventOnOut_Dialog_ServantCarriageLink_All_ShowMouseToolTip(false , true)")
    self._ui._txt_RClick:addInputEvent("Mouse_Out", "HandleEventOnOut_Dialog_ServantCarriageLink_All_ShowMouseToolTip(false , false)")
  else
    self._ui._txt_RClick:addInputEvent("Mouse_On", "")
    self._ui._txt_RClick:addInputEvent("Mouse_Out", "")
  end
end
function PaGlobal_ServantCarriageLink_All:list2Update_Carriage(content, key)
  if nil == key or nil == Panel_Dialog_ServantCarriageLink_All or false == Panel_Dialog_ServantCarriageLink_All then
    return
  end
  local key32 = Int64toInt32(key)
  local carriage_Slot = UI.getChildControl(content, "RadioButton_CarriageSlot")
  local noEnduranceBg = UI.getChildControl(content, "Static_NoEnduranceBg")
  local carriage_CarriageIcon = UI.getChildControl(content, "Static_CarriageIcon")
  local carriage_Name = UI.getChildControl(content, "StaticText_CarriageName")
  local carriage_RegionName = UI.getChildControl(content, "StaticText_RegionName")
  local carriage_SlotCount = UI.getChildControl(content, "StaticText_SlotCount")
  carriage_Slot:setNotImpactScrollEvent(true)
  carriage_Slot:SetShow(false)
  noEnduranceBg:SetShow(false)
  carriage_Slot:SetCheck(false)
  carriage_RegionName:SetShow(false)
  local servantInfo = stable_getServant(key32)
  if nil == servantInfo then
    return
  end
  carriage_Slot:SetShow(true)
  local regeionName = servantInfo:getRegionName()
  local leftLinkSlot = servantInfo:getCurrentLinkCount()
  local maxLinkSlot = servantInfo:getLinkCount()
  local hp = servantInfo:getHp()
  local level = servantInfo:getLevel()
  local name = servantInfo:getName()
  if hp <= 0 then
    noEnduranceBg:SetShow(true)
  end
  carriage_CarriageIcon:ChangeTextureInfoName(servantInfo:getIconPath1())
  carriage_Name:SetText(name)
  carriage_SlotCount:SetText(leftLinkSlot .. " / " .. maxLinkSlot)
  carriage_Slot:addInputEvent("Mouse_LUp", "HandleEventLUp_ServantCarriageLink_All_SelectCarriage(" .. key32 .. ")")
  PaGlobal_ServantCarriageLink_All._carriageBtn_List[key32] = carriage_Slot
  if nil == self._currentCarriage._slotIdx then
    self._currentCarriage._slotIdx = key32
    HandleEventLUp_ServantCarriageLink_All_SelectCarriage(key32)
    carriage_Slot:SetCheck(true)
  end
end
function PaGlobal_ServantCarriageLink_All:list2Update_Horse(content, key)
  if nil == key or nil == Panel_Dialog_ServantCarriageLink_All or false == Panel_Dialog_ServantCarriageLink_All then
    return
  end
  local key32 = Int64toInt32(key)
  local horse_HorseSlot = UI.getChildControl(content, "CheckButton_HorseSlot")
  local horse_IconBg = UI.getChildControl(content, "Static_IconBg")
  local horse_Icon = UI.getChildControl(content, "Static_Icon")
  local horse_LinkIcon = UI.getChildControl(content, "Static_LinkIcon")
  local horse_Level_Name = UI.getChildControl(content, "StaticText_LevelAndName")
  local horse_RegionName = UI.getChildControl(content, "StaticText_RegionName")
  local horse_Tier = UI.getChildControl(content, "StaticText_Tier")
  local horse_linkState = UI.getChildControl(content, "StaticText_State")
  local genderIcon = UI.getChildControl(horse_IconBg, "Static_GenderIcon")
  horse_HorseSlot:setNotImpactScrollEvent(true)
  horse_LinkIcon:SetShow(false)
  horse_HorseSlot:SetShow(false)
  horse_LinkIcon:SetShow(false)
  horse_HorseSlot:SetIgnore(false)
  horse_linkState:SetShow(false)
  genderIcon:SetShow(false)
  local servantInfo = stable_getServant(key32)
  if nil == servantInfo or CppEnums.VehicleType.Type_Horse ~= servantInfo:getVehicleType() then
    return
  end
  horse_HorseSlot:SetShow(true)
  local regeionName = servantInfo:getRegionName()
  local level_Name = PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_LV") .. "." .. tostring(servantInfo:getLevel()) .. " " .. servantInfo:getName()
  local tier = servantInfo:getTier()
  local servantNo = servantInfo:getServantNo()
  local servantInfoTable = {
    servantNo = nil,
    servantSlotIndex = nil,
    checkBtn = nil
  }
  servantInfoTable.servantNo = servantNo
  servantInfoTable.servantSlotIndex = key32
  servantInfoTable.checkBtn = horse_HorseSlot
  if 9 == tier then
    horse_Tier:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_SERVANT_TEXT_TIER9"))
  else
    horse_Tier:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_SERVANT_TIER", "tier", servantInfo:getTier()))
  end
  horse_Icon:ChangeTextureInfoName(servantInfo:getIconPath1())
  horse_Level_Name:SetText(level_Name)
  horse_RegionName:SetText(regeionName)
  local isLinked = servantInfo:isLink()
  horse_LinkIcon:SetShow(isLinked)
  horse_linkState:SetShow(isLinked)
  horse_HorseSlot:SetCheck(isLinked)
  if isLinked then
    horse_linkState:SetText(PAGetString(Defines.StringSheet_RESOURCE, "UI_WINDOW_STABLE_LIST_LINK"))
    if false == self._isConsole then
      horse_HorseSlot:addInputEvent("Mouse_RUp", "HandleEventLUp_ServantCarriageLink_All_SelectHorse(" .. key32 .. ",true)")
      horse_HorseSlot:addInputEvent("Mouse_LUp", "HandleEventLUp_ServantCarriageLink_All_IgnoreCheckBtn(" .. key32 .. ",false)")
    else
      horse_HorseSlot:addInputEvent("Mouse_LUp", "HandleEventLUp_ServantCarriageLink_All_SelectHorse(" .. key32 .. ",true)")
    end
  elseif false == self._isConsole then
    horse_HorseSlot:addInputEvent("Mouse_LUp", "HandleEventLUp_ServantCarriageLink_All_SelectHorse(" .. key32 .. ",false)")
    horse_HorseSlot:addInputEvent("Mouse_RUp", "HandleEventLUp_ServantCarriageLink_All_IgnoreCheckBtn(" .. key32 .. ",true)")
  else
    horse_HorseSlot:addInputEvent("Mouse_LUp", "HandleEventLUp_ServantCarriageLink_All_SelectHorse(" .. key32 .. ",false)")
  end
  self._linkAbleHorse_List[key32] = servantInfoTable
  local x1, y1, x2, y2 = 0, 0, 0, 0
  if true == servantInfo:isMale() then
    genderIcon:ChangeTextureInfoName("combine/etc/combine_etc_stable.dds")
    x1, y1, x2, y2 = setTextureUV_Func(genderIcon, 1, 209, 31, 239)
  else
    genderIcon:ChangeTextureInfoName("combine/etc/combine_etc_stable.dds")
    x1, y1, x2, y2 = setTextureUV_Func(genderIcon, 1, 178, 31, 208)
  end
  genderIcon:SetShow(true)
  genderIcon:getBaseTexture():setUV(x1, y1, x2, y2)
  genderIcon:setRenderTexture(genderIcon:getBaseTexture())
end
function PaGlobal_ServantCarriageLink_All:prepareClose()
  if nil == Panel_Dialog_ServantCarriageLink_All or false == Panel_Dialog_ServantCarriageLink_All:GetShow() then
    return
  end
  PaGlobal_ServantCarriageLink_All:dataClear()
  PaGlobal_ServantCarriageLink_All:close()
end
function PaGlobal_ServantCarriageLink_All:dataClear()
  self._currentCarriageIndex = -1
  self._ui._list2_Carriage:getElementManager():clearKey()
  self._ui._list2_Horse:getElementManager():clearKey()
  self._carriage_List = {}
  self._linkAbleHorse_List = {}
  self._currentSelectedHorse = {}
  self._currentSelectedHorseCount = 0
  self._currentCarriage._slotIdx = nil
  self._currentCarriage._carriageNo = nil
  self._currentCarriage._maxLinkAbleHorse = nil
  self.scrollPos._horseIdx = 0
  self.scrollPos._horseScrollPos = 0
  self.scrollPos._carriageScrollPos = 0
  self.scrollPos._carriageIdx = 0
end
function PaGlobal_ServantCarriageLink_All:close()
  if nil == Panel_Dialog_ServantCarriageLink_All or false == Panel_Dialog_ServantCarriageLink_All:GetShow() then
    return
  end
  Panel_Dialog_ServantCarriageLink_All:SetShow(false)
end
function PaGlobal_ServantCarriageLink_All:validate()
  if nil == Panel_Dialog_ServantCarriageLink_All then
    return
  end
  self._ui._stc_TitleBG:isValidate()
  self._ui._stc_TitleIcon:isValidate()
  self._ui._btn_Close_PC:isValidate()
  self._ui._btn_Question_PC:isValidate()
  self._ui._stc_MainBg:isValidate()
  self._ui._list2_Carriage:isValidate()
  self._ui._list2_Carriage_Content:isValidate()
  self._ui._list2_Carriage_Slot:isValidate()
  self._ui._list2_NoEnduranceBg:isValidate()
  self._ui._list2_Carriage_CarriageIcon:isValidate()
  self._ui._list2_Carriage_Name:isValidate()
  self._ui._list2_Carriage_RegionName:isValidate()
  self._ui._list2_Carriage_SlotCount:isValidate()
  self._ui._list2_Carriage_VertiScroll:isValidate()
  self._ui._list2_Carriage_VertiScroll_Up:isValidate()
  self._ui._list2_Carriage_VertiScroll_Down:isValidate()
  self._ui._list2_Carriage_VertiScroll_Ctrl:isValidate()
  self._ui._List2_Carriage_HoriScroll:isValidate()
  self._ui._List2_Carriage_HoriScroll_Up:isValidate()
  self._ui._List2_Carriage_HoriScroll_Down:isValidate()
  self._ui._List2_Carriage_HoriScroll_Ctrl:isValidate()
  self._ui._list2_Horse:isValidate()
  self._ui._list2_Horse_Content:isValidate()
  self._ui._list2_Horse_HorseSlot:isValidate()
  self._ui._list2_Horse_IconBg:isValidate()
  self._ui._list2_Horse_Icon:isValidate()
  self._ui._list2_Horse_LinkIcon:isValidate()
  self._ui._list2_Horse_Level_Name:isValidate()
  self._ui._list2_Horse_RegionName:isValidate()
  self._ui._list2_Horse_Tier:isValidate()
  self._ui._list2_Horse_State:isValidate()
  self._ui._list2_Horse_VertiScroll:isValidate()
  self._ui._list2_Horse_VertiScroll_Up:isValidate()
  self._ui._list2_Horse_VertiScroll_Down:isValidate()
  self._ui._list2_Horse_VertiScroll_Ctrl:isValidate()
  self._ui._List2_Horse_HoriScroll:isValidate()
  self._ui._List2_Horse_HoriScroll_Up:isValidate()
  self._ui._List2_Horse_HoriScroll_Down:isValidate()
  self._ui._List2_Horse_HoriScroll_Ctrl:isValidate()
  self._ui._btn_Link_PC:isValidate()
  self._ui._btn_Cancel_PC:isValidate()
  self._ui._stc_Bottom_KeyGuides:isValidate()
  self._ui._stc_KeyGuide_A:isValidate()
  self._ui._stc_KeyGuide_B:isValidate()
  self._ui._stc_KeyGuide_Y:isValidate()
  self._initialize = true
end
function PaGlobal_ServantCarriageLink_All:getCarriageLinkCount()
  if nil == self._currentCarriage._slotIdx then
    return
  end
  local carriageInfo = stable_getServant(self._currentCarriage._slotIdx)
  if nil == carriageInfo then
    return 0
  end
  return carriageInfo:getCurrentLinkCount()
end
