function PaGlobal_ServantList_All:initialize()
  if nil == Panel_Dialog_ServantList_All or true == self.initialize then
    return
  end
  self._ui._stc_TitleBar = UI.getChildControl(Panel_Dialog_ServantList_All, "Static_TitleBar")
  self._ui._txt_Title = UI.getChildControl(self._ui._stc_TitleBar, "StaticText_Title")
  self._ui._btn_Question = UI.getChildControl(self._ui._stc_TitleBar, "Button_Help")
  self._ui._txt_CurrentServantTitle = UI.getChildControl(Panel_Dialog_ServantList_All, "StaticText_UnsealServantTitle")
  self._ui._stc_CurrentServantBg = UI.getChildControl(Panel_Dialog_ServantList_All, "Static_CurrentServantBg")
  self._ui._btn_CurrentServant = UI.getChildControl(self._ui._stc_CurrentServantBg, "Button_CurentServant")
  self._ui._icon_CurrentServant = UI.getChildControl(self._ui._stc_CurrentServantBg, "Static_Icon")
  self._ui._icon_CurrentServantGender = UI.getChildControl(self._ui._stc_CurrentServantBg, "Static_GenderIcon")
  self._ui._txt_CurrentServantName = UI.getChildControl(self._ui._stc_CurrentServantBg, "StaticText_ServantName")
  self._ui._txt_CurrentServantLocate = UI.getChildControl(self._ui._stc_CurrentServantBg, "StaticText_Locate")
  self._ui._txt_CurrentServant_Tier = UI.getChildControl(self._ui._stc_CurrentServantBg, "StaticText_Tier")
  self._ui._icon_CurrentServant_Swift = UI.getChildControl(self._ui._stc_CurrentServantBg, "Static_SwiftHorseIcon")
  self._ui._stc_NoServant = UI.getChildControl(self._ui._stc_CurrentServantBg, "StaticText_NoServant")
  self._ui._txt_ServantListTitle = UI.getChildControl(Panel_Dialog_ServantList_All, "StaticText_ServantListTitle")
  self._ui._txt_ServantListValue = UI.getChildControl(Panel_Dialog_ServantList_All, "StaticText_ServantListValue")
  self._ui._list2_Servant = UI.getChildControl(Panel_Dialog_ServantList_All, "List2_Servant")
  self._ui._list2_ServantContent = UI.getChildControl(self._ui._list2_Servant, "List2_1_Content")
  self._ui._list2_ServantButton = UI.getChildControl(self._ui._list2_ServantContent, "Button_List")
  self._ui._list2_ServantImage = UI.getChildControl(self._ui._list2_ServantContent, "Static_Image")
  self._ui._list2_ServantGenderIcon = UI.getChildControl(self._ui._list2_ServantContent, "Static_GenderIcon")
  self._ui._list2_ServantName = UI.getChildControl(self._ui._list2_ServantContent, "StaticText_ServantName")
  self._ui._list2_ServantLocate = UI.getChildControl(self._ui._list2_ServantContent, "StaticText_Locate")
  self._ui._list2_ServantState = UI.getChildControl(self._ui._list2_ServantContent, "StaticText_State")
  self._ui._list2_ServantTier = UI.getChildControl(self._ui._list2_ServantContent, "StaticText_Tier")
  self._ui._list2_ServantSwiftHorseIcon = UI.getChildControl(self._ui._list2_ServantContent, "Static_SwiftHorseIcon")
  self._ui._list2_Servant_VertiScroll = UI.getChildControl(self._ui._list2_Servant, "List2_1_VerticalScroll")
  self._ui._list2_Servant_VertiScroll_Up = UI.getChildControl(self._ui._list2_Servant_VertiScroll, "List2_1_VerticalScroll_UpButton")
  self._ui._list2_Servant_VertiScroll_Down = UI.getChildControl(self._ui._list2_Servant_VertiScroll, "List2_1_VerticalScroll_DownButton")
  self._ui._list2_Servant_VertiScroll_Ctrl = UI.getChildControl(self._ui._list2_Servant_VertiScroll, "List2_1_VerticalScroll_CtrlButton")
  self._ui._list2_Servant_HoriScroll = UI.getChildControl(self._ui._list2_Servant, "List2_1_HorizontalScroll")
  self._ui._list2_Servant_HoriScroll_Up = UI.getChildControl(self._ui._list2_Servant_HoriScroll, "List2_1_HorizontalScroll_UpButton")
  self._ui._list2_Servant_HoriScroll_Down = UI.getChildControl(self._ui._list2_Servant_HoriScroll, "List2_1_HorizontalScroll_DownButton")
  self._ui._list2_Servant_HoriScroll_Ctrl = UI.getChildControl(self._ui._list2_Servant_HoriScroll, "List2_1_HorizontalScroll_CtrlButton")
  self._ui._stc_StatusBg = UI.getChildControl(Panel_Dialog_ServantList_All, "Static_StatusBg")
  self._ui._txt_UnSealServant_CountTitle = UI.getChildControl(self._ui._stc_StatusBg, "StaticText_UnsealCountTitle")
  self._ui._txt_SealServant_CountTitle = UI.getChildControl(self._ui._stc_StatusBg, "StaticText_SealCountTitle")
  self._ui._txt_UnSealServant_CountValue = UI.getChildControl(self._ui._stc_StatusBg, "StaticText_UnsealCountValue")
  self._ui._txt_SealServant_CountValue = UI.getChildControl(self._ui._stc_StatusBg, "StaticText_SealCountValue")
  self._ui.stc_emptyContorlForSnap = UI.getChildControl(Panel_Dialog_ServantList_All, "Static_EmptyForSnap")
  self._ui._btn_IncreaseSlot = UI.getChildControl(self._ui.stc_emptyContorlForSnap, "Button_IncreaseSlot")
  self._ui._btn_Regist = UI.getChildControl(self._ui.stc_emptyContorlForSnap, "Button_Regist")
  self._ui._stc_MenuListBg = UI.getChildControl(Panel_Dialog_ServantList_All, "Static_MenuListBg")
  self._ui._btn_Menu_Template = UI.getChildControl(self._ui._stc_MenuListBg, "Button_Menu_Template")
  self._ui._stc_ImportantMenuListBg = UI.getChildControl(Panel_Dialog_ServantList_All, "Static_ImportantMenuListBg")
  self._ui._btn_ImportantMenu_Template = UI.getChildControl(self._ui._stc_ImportantMenuListBg, "Button_ImportantMenu_Template")
  self._ui._btn_WildHorseBg = UI.getChildControl(Panel_Dialog_ServantList_All, "Static_WildHorseBg")
  self._ui._btn_WildHorse = UI.getChildControl(self._ui._btn_WildHorseBg, "Button_WildHorse")
  self._ui._stc_WildHorseImage = UI.getChildControl(self._ui._btn_WildHorseBg, "Static_WildHorseImage")
  self._ui._txt_WildHorseDesc = UI.getChildControl(self._ui._btn_WildHorseBg, "StaticText_Desc")
  self._ui._txt_WildHorseTitle = UI.getChildControl(self._ui._btn_WildHorseBg, "StaticText_Title")
  self._ui._stc_ConsoleKeyGuides = UI.getChildControl(Panel_Dialog_ServantList_All, "Static_BottomBg_ConsoleUI")
  self._ui._stc_KeyGuide_A = UI.getChildControl(self._ui._stc_ConsoleKeyGuides, "StaticText_A_ConsoleUI")
  self._ui._stc_MenuListBg:SetShow(false)
  self._ui._stc_ImportantMenuListBg:SetShow(false)
  self._ORIGINAL_PANEL_SIZEY = Panel_Dialog_ServantList_All:GetSizeY()
  self._ORIGINAL_SUBMENUBG_SIZEY = self._ui._stc_MenuListBg
  self._ORIGINAL_SUBMENU_SIZEY = self._ui._btn_Menu_Template:GetSizeY()
  self._ORIGINAL_LISTTITLE_SPANY = self._ui._txt_ServantListTitle:GetSpanSize().y
  self._ORIGINAL_LIST2_SPANY = self._ui._list2_Servant:GetSpanSize().y
  self._ORIGINAL_REGIST_SIZEX = self._ui._btn_Regist:GetSizeX()
  self._ui._stc_NoServant:SetTextMode(__eTextMode_AutoWrap)
  self._ui._stc_NoServant:SetText(self._ui._stc_NoServant:GetText())
  self._isConsole = _ContentsGroup_UsePadSnapping
  PaGlobal_ServantList_All:validate()
  PaGlobal_ServantList_All:isConsoleUI(self._isConsole)
  PaGlobal_ServantList_All:resize()
  PaGlobal_ServantList_All:registerEventHandler(self._isConsole)
  PaGlobal_ServantList_All:createSubMenu(true)
end
function PaGlobal_ServantList_All:resize()
  local screenSizeY = getScreenSizeY()
  local panelSizeY = screenSizeY - 70
  local list2ExeptionSizeY = Panel_Dialog_ServantList_All:GetSizeY() - self._ui._list2_Servant:GetSizeY()
  if screenSizeY < 1080 then
    Panel_Dialog_ServantList_All:SetSize(Panel_Dialog_ServantList_All:GetSizeX(), panelSizeY)
    self._ui._list2_Servant:SetSize(self._ui._list2_Servant:GetSizeX(), panelSizeY - list2ExeptionSizeY)
    self._ui._stc_StatusBg:ComputePos()
    self._ui._btn_IncreaseSlot:ComputePos()
    self._ui._btn_Regist:ComputePos()
    self._ui._btn_WildHorseBg:ComputePos()
    self._ui.stc_emptyContorlForSnap:ComputePos()
    self._ORIGINAL_PANEL_SIZEY = panelSizeY
  end
end
function PaGlobal_ServantList_All:registerEventHandler(isConsole)
  if nil == Panel_Dialog_ServantList_All or false == self._initialize then
    return
  end
  self._ui._list2_Servant:registEvent(__ePAUIList2EventType_LuaChangeContent, "FromClient_ServantList_All_List2ServantUpdate")
  self._ui._list2_Servant:createChildContent(__ePAUIList2ElementManagerType_List)
  Panel_Dialog_ServantList_All:setMaskingChild(true)
  Panel_Dialog_ServantList_All:ActiveMouseEventEffect(true)
  Panel_Dialog_ServantList_All:setGlassBackground(true)
  Panel_Dialog_ServantList_All:RegisterShowEventFunc(true, "PaGlobalFunc_ServantList_All_ShowAni()")
  Panel_Dialog_ServantList_All:RegisterShowEventFunc(false, "PaGlobalFunc_ServantList_All_HideAni()")
  registerEvent("onScreenResize", "FromClient_ServantList_All_OnScreenReSize")
  registerEvent("FromClient_ServantRegisterToAuction", "FromClient_ServantList_All_UpdateVehicleList")
  registerEvent("FromClient_ServantUpdate", "FromClient_ServantList_All_UpdateVehicleList")
  registerEvent("FromClient_ServantTaming", "FromClient_ServantList_All_UpdateVehicleList")
  registerEvent("EventSelfServantUpdateOnlyHp", "FromClient_ServantList_All_UpdateVehicleList")
  registerEvent("EventSelfServantUpdateOnlyMp", "FromClient_ServantList_All_UpdateVehicleList")
  registerEvent("FromClient_VaryExtendSlot", "FromClient_ServantList_All_UpdateVehicleList")
  registerEvent("FromClient_ServantSeal", "FromClient_ServantList_All_Servant_SealFinish")
  registerEvent("FromClient_ServantUnseal", "FromClient_ServantList_All_Servant_UnSealFinish")
  registerEvent("FromClient_ServantToReward", "FromClient_ServantList_All_ServantToReward")
  registerEvent("FromClient_ServantRecovery", "FromClient_ServantList_All_Servant_RecoveryFinish")
  registerEvent("FromClient_ServantChangeName", "FromClient_ServantList_All_Servant_NameChangeFinish")
  registerEvent("FromClient_ServantRegisterAuction", "FromClient_ServantList_All_RegisteringFinish")
  registerEvent("FromClient_ServantCancelAuction", "FromClient_ServantList_All_CancelRegisterFinish")
  registerEvent("FromClient_ServantReceiveAuction", "FromClient_ServantList_All_RecieveMarketFinish")
  registerEvent("FromClient_ServantBuyMarket", "FromClient_ServantList_All_BuyingServantFinish")
  registerEvent("FromClient_ServantStartMating", "FromClient_ServantList_All_StartMatingMarket")
  registerEvent("FromClient_ServantChildMating", "FromClient_ServantList_All_Recieve_MatingMarket")
  registerEvent("FromClient_ServantClearDeadCount", "FromClient_ServantList_All_Reset_DeadCountFinish")
  registerEvent("FromClient_ServantImprint", "FromClient_ServantList_All_Success_Imprint")
  registerEvent("FromClient_ServantClearMatingCount", "FromClient_ServantList_All_Reset_MatingCountFinish")
  registerEvent("FromClient_ServantLink", "FromClient_ServantList_All_LinkFinish")
  registerEvent("FromClient_ServantStartSkillTraining", "FromClient_ServantList_All_StartSkillTraining")
  registerEvent("FromClient_ServantEndSkillTraining", "FromClient_ServantList_All_EndSkillTraining")
  registerEvent("FromClient_StartStallionSkillTraining", "FromClient_ServantList_All_StartStallionTraining")
  registerEvent("FromClient_EndStallionSkillTraining", "FromClient_ServantList_All_EndStallionTraining")
  registerEvent("FromClient_OnChangeServantRegion", "FromClient_ServantList_All_ChangeRegion")
  registerEvent("FromClient_RegisterServantFail", "FromClient_ServantList_All_PopFailedMessage")
  if false == isConsole then
    self._ui._txt_ServantListValue:addInputEvent("Mouse_On", "HandleEventOn_ServantList_All_ShowCountTooltip(2)")
    self._ui._txt_ServantListValue:addInputEvent("Mouse_Out", "HandleEventOut_ServantList_All_HideCountTooltip()")
    self._ui._txt_UnSealServant_CountValue:addInputEvent("Mouse_On", "HandleEventOn_ServantList_All_ShowCountTooltip(1)")
    self._ui._txt_UnSealServant_CountValue:addInputEvent("Mouse_Out", "HandleEventOut_ServantList_All_HideCountTooltip()")
    self._ui._txt_SealServant_CountValue:addInputEvent("Mouse_On", "HandleEventOn_ServantList_All_ShowCountTooltip(0)")
    self._ui._txt_SealServant_CountValue:addInputEvent("Mouse_Out", "HandleEventOut_ServantList_All_HideCountTooltip()")
    self._ui._list2_Servant_VertiScroll:addInputEvent("Mouse_LUp", "PaGlobalFunc_ServantList_All_SubMenuClose()")
    self._ui._list2_Servant:addInputEvent("Mouse_UpScroll", "PaGlobalFunc_SeravntInfo_All_SaveScrollPos()")
    self._ui._list2_Servant:addInputEvent("Mouse_DownScroll", "PaGlobalFunc_SeravntInfo_All_SaveScrollPos()")
  else
    Panel_Dialog_ServantList_All:registerPadEvent(__eConsoleUIPadEvent_LB, "HandleEventPadPress_ServantFunction_All_ChangeTab(false)")
    Panel_Dialog_ServantList_All:registerPadEvent(__eConsoleUIPadEvent_RB, "HandleEventPadPress_ServantFunction_All_ChangeTab(true)")
  end
  self._ui._btn_IncreaseSlot:addInputEvent("Mouse_LUp", "HandleEventLUp_ServantList_All_StableSlotBuy()")
  self._ui._btn_Regist:addInputEvent("Mouse_LUp", "HandleEventLUp_ServantList_All_RegisterServantByMapae()")
end
function PaGlobal_ServantList_All:isConsoleUI(isConsole)
  if nil == Panel_Dialog_ServantList_All or false == self._initialize then
    return
  end
  self._ui._stc_ConsoleKeyGuides:SetShow(isConsole)
  self._ui._btn_Question:SetShow(not isConsole)
  if true == isConsole then
    self._ui._btn_Regist:SetSize(self._ORIGINAL_REGIST_SIZEX + self._ui._btn_IncreaseSlot:GetSizeX() + 5, self._ui._btn_Regist:GetSizeY())
    self._ui._btn_Regist:ComputePos()
  end
end
function PaGlobal_ServantList_All:createSubMenu(isInitialize)
  if nil == Panel_Dialog_ServantList_All then
    return
  end
  if 0 >= self._tempSubBtnCountForCreate then
    return
  end
  self._ui._btn_Menu_Template:SetShow(false)
  self._ui._btn_ImportantMenu_Template:SetShow(false)
  if true == isInitialize then
    for idx = 0, self._tempSubBtnCountForCreate - 1 do
      local subMenu = UI.createControl(__ePAUIControl_Button, self._ui._stc_MenuListBg, "ServantSubMenu_" .. tostring(idx))
      CopyBaseProperty(self._ui._btn_Menu_Template, subMenu)
      subMenu:SetShow(false)
      local PosY = self._ui._btn_Menu_Template:GetSizeY() * idx + 1
      subMenu:SetPosY(PosY)
      self._subMenuGroup[idx] = subMenu
      local importantMenu = UI.createControl(__ePAUIControl_Button, self._ui._stc_ImportantMenuListBg, "ServantImportantMenu_" .. tostring(idx))
      CopyBaseProperty(self._ui._btn_ImportantMenu_Template, importantMenu)
      importantMenu:SetShow(false)
      local PosY = self._ui._btn_ImportantMenu_Template:GetSizeY() * idx + 1
      importantMenu:SetPosY(PosY)
      self._importantMenuGroup[idx] = importantMenu
    end
  end
end
function PaGlobal_ServantList_All:prepareOpen()
  if nil == Panel_Dialog_ServantList_All or true == Panel_Dialog_ServantList_All:GetShow() then
    return
  end
  UIAni.fadeInSCR_Down(Panel_Dialog_ServantList_All)
  self._selectSceneIndex = -1
  local currentNPCType
  if nil ~= Panel_Dialog_ServantFunction_All then
    currentNPCType = PaGlobalFunc_ServantFunction_All_Get_NpcType()
  end
  if nil == currentNPCType then
    return
  end
  PaGlobalFunc_SeravntInfo_All_ResetScrollPos()
  if 2 == currentNPCType or 3 == currentNPCType then
    self._ui._txt_Title:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WHARFLIST_TITLE"))
    self._ui._btn_Regist:SetText(PAGetString(Defines.StringSheet_RESOURCE, "WHARF_FUNCTION_REGISTERSHIP"))
    self._ui._btn_IncreaseSlot:SetShow(false)
  else
    self._ui._btn_IncreaseSlot:SetShow(not self._isConsole and _ContentsGroup_EasyBuy)
    self._ui._txt_Title:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_WORLDMAPGRAND_MENUBUTTONTOOLTIP_STABLE"))
    self._ui._btn_Regist:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_STABLE_REGISTTITLE"))
  end
  if true == PaGlobalFunc_ServantFunction_All_GetIsGuild() then
    PaGlobal_ServantList_All:setGuildPanel(true)
  else
    PaGlobal_ServantList_All:setGuildPanel(false)
  end
  PaGlobal_ServantList_All:open()
  PaGlobal_ServantList_All:update()
  local temporaryWrapper = getTemporaryInformationWrapper()
  if nil == temporaryWrapper then
    return
  end
  local servantInfo = temporaryWrapper:getUnsealVehicle(stable_getServantType())
  if nil ~= servantInfo and false == PaGlobalFunc_ServantFunction_All_GetIsGuild() then
    if 2 == currentNPCType or 3 == currentNPCType then
      PaGlobal_ServantList_All:shipSubMenuOpen(self._ENUM_TYPEUNSEALED)
    else
      PaGlobal_ServantList_All:subMenuOpen(self._ENUM_TYPEUNSEALED)
    end
    PaGlobalFunc_ServantInfo_All_Open()
  else
    HandleEventOn_ServantList_All_SelectSevant(self._ENUM_TYPESEALED, 0)
  end
  local effectControl = Paglobal_ServantList_All_GetRegistBtn()
  if true == stable_doHaveRegisterItem() and false == isSiegeStable() then
    if false == self._isConsole then
      effectControl:EraseAllEffect()
      effectControl:AddEffect("fUI_Dialog_Servant_01A", true, 0, 0)
    end
    effectControl:SetMonoTone(false, false)
    effectControl:SetIgnore(false)
  else
    effectControl:SetMonoTone(true, true)
    effectControl:SetIgnore(true)
  end
  if true == self._isConsole and false == Panel_Window_MessageBox_All:GetShow() then
    PaGlobal_ServantList_All:setSnapTarget(0)
  end
  PaGlobal_ServantList_All:SetQuestionBtn()
end
function PaGlobal_ServantList_All:open()
  if nil == Panel_Dialog_ServantList_All or true == Panel_Dialog_ServantList_All:GetShow() then
    return
  end
  Panel_Dialog_ServantList_All:SetShow(true)
end
function PaGlobal_ServantList_All:update()
  if nil == Panel_Dialog_ServantList_All or false == Panel_Dialog_ServantList_All:GetShow() then
    return
  end
  if nil == getSelfPlayer() then
    return
  end
  self._ui._txt_ServantListValue:SetShow(false)
  self._ui._stc_StatusBg:SetShow(false)
  local servantCount = 0
  if true == PaGlobalFunc_ServantFunction_All_GetIsGuild() then
    servantCount = guildStable_count()
    self._ui._btn_IncreaseSlot:SetShow(false)
  else
    servantCount = stable_count()
  end
  if 0 ~= servantCount then
    PaGlobal_ServantList_All:sortingMyServant(num)
  end
  if false == isSiegeStable() then
    self._ui._stc_StatusBg:SetShow(true)
    self._ui._txt_ServantListValue:SetShow(true)
    local sealedCount = 0
    local unsealedCount = 0
    if false == PaGlobalFunc_ServantFunction_All_GetIsGuild() then
      sealedCount = stable_currentSlotCount()
      unsealedCount = stable_currentRegionSlotCountAll() - sealedCount + Int64toInt32(stable_currentRegionSlotCountOfOtherCharacter())
      self._ui._txt_ServantListValue:SetText(sealedCount + unsealedCount .. "/" .. stable_maxSlotCount())
      if unsealedCount < 0 then
        unsealedCount = math.abs(unsealedCount)
      end
      self._ui._txt_SealServant_CountValue:SetText(sealedCount)
      self._ui._txt_UnSealServant_CountValue:SetText(unsealedCount)
    else
      sealedCount = guildStable_currentSlotCount()
      unsealedCount = guildstable_getUnsealGuildServantCount()
      self._ui._txt_ServantListValue:SetText(guildStable_currentSlotCount() .. "/" .. guildStable_maxSlotCount())
      self._ui._txt_SealServant_CountValue:SetText(sealedCount)
      self._ui._txt_UnSealServant_CountValue:SetText(unsealedCount)
    end
  else
    self._ui._btn_IncreaseSlot:SetShow(false)
    self._ui._btn_Regist:SetShow(false)
  end
  PaGlobal_ServantList_All:sortDataUpdate()
  local regionInfo = getRegionInfoByPosition(getSelfPlayer():get():getPosition())
  self._currentRegionKey = regionInfo:getRegionKey()
  if nil == self._totalServantCount or servantCount ~= self._totalServantCount then
    self._totalServantCount = servantCount
    self._ui._list2_Servant:getElementManager():clearKey()
    for ii = 0, servantCount - 1 do
      self._ui._list2_Servant:getElementManager():pushKey(toInt64(0, ii))
    end
  else
    for ii = 0, servantCount - 1 do
      self._ui._list2_Servant:requestUpdateByKey(toInt64(0, ii))
    end
  end
  PaGlobal_ServantList_All:setMyServant()
  PaGlobal_ServantList_All:setTamingServant()
  PaGlobalFunc_SeravntInfo_All_LoadScrollPos()
end
function PaGlobal_ServantList_All:setDataList2MYServant(content, key)
  if nil == key or nil == Panel_Dialog_ServantList_All or false == Panel_Dialog_ServantList_All:GetShow() then
    return
  end
  local key32 = Int64toInt32(key)
  local linkedHorseCount = 0
  local sortedIndex = 0
  sortedIndex = PaGlobal_ServantList_All:sortByWayPointKey(key32)
  if nil == sortedIndex or -1 == sortedIndex then
    return
  end
  local btn = UI.getChildControl(content, "Button_List")
  local image = UI.getChildControl(content, "Static_Image")
  local genderIcon = UI.getChildControl(content, "Static_GenderIcon")
  local name = UI.getChildControl(content, "StaticText_ServantName")
  local locate = UI.getChildControl(content, "StaticText_Locate")
  local state = UI.getChildControl(content, "StaticText_State")
  local tier = UI.getChildControl(content, "StaticText_Tier")
  local horseIcon = UI.getChildControl(content, "Static_SwiftHorseIcon")
  if true == PaGlobalFunc_ServantFunction_All_GetIsGuild() then
    servantInfo = guildStable_getServant(sortedIndex)
  else
    servantInfo = stable_getServant(sortedIndex)
  end
  if nil ~= servantInfo then
    local servantRegionName = servantInfo:getRegionName()
    local servantType = servantInfo:getVehicleType()
    local isLinkedHorse = servantInfo:isLink() and CppEnums.VehicleType.Type_Horse == servantType
    local regionKey = servantInfo:getRegionKeyRaw()
    local regionInfoWrapper = getRegionInfoWrapper(regionKey)
    local exploerKey = regionInfoWrapper:getExplorationKey()
    local getState = servantInfo:getStateType()
    local vehicleType = servantInfo:getVehicleType()
    local servantNo = servantInfo:getServantNo()
    local level = servantInfo:getLevel()
    tier:SetMonoTone(false, false)
    image:SetMonoTone(false, false)
    genderIcon:SetMonoTone(false, false)
    locate:SetMonoTone(false, false)
    name:SetMonoTone(false, false)
    state:SetMonoTone(false, false)
    horseIcon:SetMonoTone(false, false)
    btn:SetMonoTone(false, false)
    btn:setNotImpactScrollEvent(true)
    state:SetText("")
    state:SetFontColor(Defines.Color.C_FFDDC39E)
    if true == isLinkedHorse then
      state:SetText(PAGetString(Defines.StringSheet_RESOURCE, "UI_WINDOW_STABLE_LIST_LINK"))
    end
    name:SetText(servantInfo:getName())
    if false == servantInfo:isPcroomOnly() and false == PaGlobalFunc_ServantFunction_All_GetIsGuild() and (servantType == CppEnums.VehicleType.Type_Horse or servantType == CppEnums.VehicleType.Type_Camel or servantType == CppEnums.VehicleType.Type_Donkey or servantType == CppEnums.VehicleType.Type_RidableBabyElephant) then
      name:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_LV") .. "." .. tostring(level) .. " " .. servantInfo:getName())
    end
    locate:SetText(servantRegionName)
    image:ChangeTextureInfoName(servantInfo:getIconPath1())
    if regionKey ~= self._currentRegionKey then
      if 0 == servantInfo:getHp() or CppEnums.ServantStateType.Type_Coma == getState then
        if CppEnums.VehicleType.Type_Carriage == vehicleType or CppEnums.VehicleType.Type_Elephant == vehicleType or CppEnums.VehicleType.Type_RepairableCarriage == vehicleType or CppEnums.VehicleType.Type_Elephant == vehicleType or CppEnums.VehicleType.Type_Train == vehicleType or CppEnums.VehicleType.Type_RidableBabyElephant == vehicleType or CppEnums.VehicleType.Type_SailingBoat == vehicleType then
          btn:SetMonoTone(true, true)
          btn:SetMonoTone(true, true)
          tier:SetMonoTone(true, true)
          image:SetMonoTone(true, true)
          genderIcon:SetMonoTone(true, true)
          locate:SetMonoTone(true, true)
          name:SetMonoTone(true, true)
          state:SetMonoTone(true, true)
        end
      elseif not isSiegeStable() then
        btn:SetMonoTone(true, true)
        tier:SetMonoTone(true, true)
        image:SetMonoTone(true, true)
        genderIcon:SetMonoTone(true, true)
        locate:SetMonoTone(true, true)
        name:SetMonoTone(true, true)
        state:SetMonoTone(true, true)
      end
    end
    local hasRentOwnerFlag = false
    if nil ~= servantInfo then
      hasRentOwnerFlag = Defines.s64_const.s64_0 < servantInfo:getRentOwnerNo()
    end
    if CppEnums.ServantStateType.Type_Return == servantInfo:getStateType() then
      state:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WINDOW_STABELLIST_RENTWAITING"))
    elseif true == hasRentOwnerFlag then
      state:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WINDOW_STABELLIST_RETRUNTAG"))
    end
    if true == servantInfo:isSeized() then
      state:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_STABLE_LIST_ATTACHMENT"))
    elseif CppEnums.ServantStateType.Type_RegisterMarket == getState then
      state:SetText(PAGetString(Defines.StringSheet_RESOURCE, "STABLE_LIST_TXT_MARKETREGISTER"))
    elseif CppEnums.ServantStateType.Type_RegisterMating == getState then
      state:SetText(PAGetString(Defines.StringSheet_RESOURCE, "STABLE_LIST_TXT_MATINGREGISTER"))
    elseif CppEnums.ServantStateType.Type_Mating == getState then
      if true == servantInfo:isMatingComplete() then
        state:SetText(PAGetString(Defines.StringSheet_RESOURCE, "STABLE_LIST_TXT_MATED"))
      else
        state:SetText(PAGetString(Defines.StringSheet_RESOURCE, "STABLE_LIST_TXT_MATING"))
      end
    elseif CppEnums.ServantStateType.Type_Coma == getState then
      if vehicleType == CppEnums.VehicleType.Type_Carriage or vehicleType == CppEnums.VehicleType.Type_CowCarriage or vehicleType == CppEnums.VehicleType.Type_RepairableCarriage or vehicleType == CppEnums.VehicleType.Type_SailingBoat or vehicleType == CppEnums.VehicleType.Type_FishingBoat or vehicleType == CppEnums.VehicleType.Type_Train or vehicleType == CppEnums.VehicleType.Type_ThrowStone or vehicleType == CppEnums.VehicleType.Type_PersonalBattleShip or vehicleType == CppEnums.VehicleType.Type_PersonTradeShip or vehicleType == CppEnums.VehicleType.Type_PersonalBoat or CppEnums.VehicleType.Type_CashPersonalTradeShip == vehicleType or CppEnums.VehicleType.Type_CashPersonalBattleShip == vehicleType or vehicleType == CppEnums.VehicleType.Type_Carrack or vehicleType == CppEnums.VehicleType.Type_FastShip or vehicleType == CppEnums.VehicleType.Type_Boat then
        state:SetText(PAGetString(Defines.StringSheet_RESOURCE, "STABLE_LIST_BTN_REPAIR"))
        state:SetFontColor(Defines.Color.C_FFD05D48)
      else
        state:SetText(PAGetString(Defines.StringSheet_RESOURCE, "STABLE_LIST_TXT_HURT"))
        state:SetFontColor(Defines.Color.C_FFD05D48)
      end
    elseif CppEnums.ServantStateType.Type_SkillTraining == getState then
      if true == stable_isSkillExpTrainingComplete(sortedIndex) then
        state:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_SERVANT_TRAINFINISH"))
      else
        state:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_SERVANT_TRAINING"))
      end
    elseif CppEnums.ServantStateType.Type_StallionTraining == getState and self._contentsOption._isContentsStallionEnable and self._contentsOption._isContentsNineTierEnable and self._contentsOption._isContentsNineTierTraining then
      state:SetText(PAGetString(Defines.StringSheet_RESOURCE, "LUA_SERVANT_TRAINING"))
    elseif true == servantInfo:isChangingRegion() then
      if true == isLinkedHorse then
        state:SetText(PAGetString(Defines.StringSheet_RESOURCE, "UI_WINDOW_STABLE_LIST_LINK") .. " / " .. PAGetString(Defines.StringSheet_RESOURCE, "STABLE_LIST_TXT_REGION_CHANGING"))
      else
        state:SetText(PAGetString(Defines.StringSheet_RESOURCE, "STABLE_LIST_TXT_REGION_CHANGING"))
      end
      btn:SetMonoTone(true, true)
      tier:SetMonoTone(true, true)
      image:SetMonoTone(true, true)
      genderIcon:SetMonoTone(true, true)
      locate:SetMonoTone(true, true)
      name:SetMonoTone(true, true)
      state:SetMonoTone(true, true)
    elseif CppEnums.ServantStateType.Type_Field == getState and true == PaGlobalFunc_ServantFunction_All_GetIsGuild() then
      state:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_STABLEINFO_ISIMPRINTING"))
    end
    if CppEnums.ServantStateType.Type_Rent == servantInfo:getStateType() then
      state:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WINDOW_STABELLIST_RENT"))
    end
    if servantInfo:getVehicleType() == CppEnums.VehicleType.Type_Horse then
      if true == servantInfo:isMale() then
        genderIcon:ChangeTextureInfoName("combine/etc/combine_etc_stable.dds")
        local x1, y1, x2, y2 = setTextureUV_Func(genderIcon, 1, 209, 31, 239)
        genderIcon:getBaseTexture():setUV(x1, y1, x2, y2)
        genderIcon:setRenderTexture(genderIcon:getBaseTexture())
      else
        genderIcon:ChangeTextureInfoName("combine/etc/combine_etc_stable.dds")
        local x1, y1, x2, y2 = setTextureUV_Func(genderIcon, 1, 178, 31, 208)
        genderIcon:getBaseTexture():setUV(x1, y1, x2, y2)
        genderIcon:setRenderTexture(genderIcon:getBaseTexture())
      end
      tier:SetShow(true)
      genderIcon:SetShow(true)
      if 9 == servantInfo:getTier() then
        tier:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_SERVANT_TEXT_TIER9"))
      else
        tier:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_SERVANT_TIER", "tier", servantInfo:getTier()))
      end
    else
      genderIcon:SetShow(false)
      if CppEnums.ServantType.Type_Ship == stable_getServantType() then
        local shipTypeStr = servantInfo:getDisplayName()
        if nil == shipTypeStr then
          shipTypeStr = ""
        end
        tier:SetText(shipTypeStr)
        tier:SetShow(true)
      else
        tier:SetShow(false)
      end
    end
    horseIcon:SetShow(false)
    if servantInfo:getVehicleType() == CppEnums.VehicleType.Type_Horse and 9 ~= servantInfo:getTier() and false == servantInfo:isPcroomOnly() and self._contentsOption._isContentsStallionEnable then
      local stallion = servantInfo:isStallion()
      horseIcon:SetShow(true)
      if true == stallion and regionKey == self._currentRegionKey then
        horseIcon:SetMonoTone(false, false)
      else
        horseIcon:SetMonoTone(true, false)
      end
    end
    local horseIconPosX = tier:GetPosX() + tier:GetSizeX() - tier:GetTextSizeX() - horseIcon:GetSizeX() - 5
    horseIcon:SetPosX(horseIconPosX)
    btn:SetShow(true)
    btn:addInputEvent("Mouse_LUp", "HandleEventOn_ServantList_All_SelectSevant(" .. self._ENUM_TYPESEALED .. "," .. key32 .. ")")
    if false == self._isConsole then
      btn:addInputEvent("Mouse_UpScroll", "PaGlobalFunc_SeravntInfo_All_SaveScrollPos()")
      btn:addInputEvent("Mouse_DownScroll", "PaGlobalFunc_SeravntInfo_All_SaveScrollPos()")
    else
      btn:addInputEvent("Mouse_On", "HandleEventOn_ServantList_All_CheckSameSlot_Console(" .. key32 .. ")")
    end
  end
end
function PaGlobal_ServantList_All:sortingMyServant(num)
  if nil == num or nil == Panel_Dialog_ServantList_All then
    return
  end
  self._sortByExploreKey = {}
  for i = 1, num do
    self._sortByExploreKey[i] = {
      _index = nil,
      _servantNo = nil,
      _exploreKey = nil,
      _areaName = nil,
      _isDead = nil,
      _exception = nil
    }
  end
end
function PaGlobal_ServantList_All:sortDataUpdate(forTest)
  if nil == Panel_Dialog_ServantList_All then
    return
  end
  local maxStableServantCount = 0
  if false == PaGlobalFunc_ServantFunction_All_GetIsGuild(forTest) then
    maxStableServantCount = stable_count()
  else
    maxStableServantCount = guildStable_count()
  end
  PaGlobal_ServantList_All:sortingMyServant(maxStableServantCount)
  for ii = 1, maxStableServantCount do
    local servantInfo
    if false == PaGlobalFunc_ServantFunction_All_GetIsGuild(forTest) then
      servantInfo = stable_getServant(ii - 1)
    else
      servantInfo = guildStable_getServant(ii - 1)
    end
    if nil ~= servantInfo then
      local regionKey = servantInfo:getRegionKeyRaw()
      local regionInfoWrapper = getRegionInfoWrapper(regionKey)
      local vehicleType = servantInfo:getVehicleType()
      self._sortByExploreKey[ii]._index = ii - 1
      self._sortByExploreKey[ii]._servantNo = servantInfo:getServantNo()
      self._sortByExploreKey[ii]._exploreKey = regionInfoWrapper:getExplorationKey()
      self._sortByExploreKey[ii]._areaName = regionInfoWrapper:getAreaName()
      self._sortByExploreKey[ii]._isDead = CppEnums.ServantStateType.Type_Coma == servantInfo:getStateType()
      self._sortByExploreKey[ii]._exception = CppEnums.VehicleType.Type_Carriage == vehicleType or CppEnums.VehicleType.Type_Elephant == vehicleType or CppEnums.VehicleType.Type_RepairableCarriage == vehicleType or CppEnums.VehicleType.Type_Elephant == vehicleType or CppEnums.VehicleType.Type_RidableBabyElephant == vehicleType or CppEnums.VehicleType.Type_SailingBoat == vehicleType
    end
  end
  local sortExplaoreKey = function(a, b)
    return a._exploreKey < b._exploreKey
  end
  table.sort(self._sortByExploreKey, sortExplaoreKey)
  local myRegionKey = getSelfPlayer():getRegionKey():get()
  local myRegionInfoWrapper = getRegionInfoWrapper(myRegionKey)
  local myWayPointKey = myRegionInfoWrapper:getExplorationKey()
  local areaName = myRegionInfoWrapper:getAreaName()
  local matchCount = 0
  local areaSortCount = 0
  local temp = {}
  local temp1 = {}
  for i = 1, maxStableServantCount do
    if myWayPointKey == self._sortByExploreKey[i]._exploreKey then
      temp1[matchCount] = self._sortByExploreKey[i]
      matchCount = matchCount + 1
    end
  end
  for ii = 0, matchCount - 1 do
    if areaName == temp1[ii]._areaName then
      temp[areaSortCount] = temp1[ii]
      areaSortCount = areaSortCount + 1
    end
  end
  for ii = 0, matchCount - 1 do
    if areaName ~= temp1[ii]._areaName then
      temp[areaSortCount] = temp1[ii]
      areaSortCount = areaSortCount + 1
    end
  end
  for i = 1, maxStableServantCount do
    if myWayPointKey ~= self._sortByExploreKey[i]._exploreKey then
      temp[matchCount] = self._sortByExploreKey[i]
      matchCount = matchCount + 1
    end
  end
  for i = 1, maxStableServantCount do
    self._sortByExploreKey[i] = temp[i - 1]
  end
  local sIndex = 0
  for servantIndex = 1, maxStableServantCount do
    if false == self._sortByExploreKey[servantIndex]._exception and true == self._sortByExploreKey[servantIndex]._isDead then
      temp[sIndex] = self._sortByExploreKey[servantIndex]
      sIndex = sIndex + 1
    end
  end
  for servantIndex = 1, maxStableServantCount do
    if true == self._sortByExploreKey[servantIndex]._exception and true == self._sortByExploreKey[servantIndex]._isDead then
      temp[sIndex] = self._sortByExploreKey[servantIndex]
      sIndex = sIndex + 1
    end
  end
  local affiliatedTerritory = function(exploerKey)
    local territoryKey = -1
    if 0 < exploerKey and exploerKey <= 300 then
      territoryKey = 0
    elseif 300 < exploerKey and exploerKey <= 600 then
      territoryKey = 1
    elseif 600 < exploerKey and exploerKey <= 1100 then
      territoryKey = 2
    elseif 1100 < exploerKey and exploerKey <= 1300 then
      territoryKey = 3
    elseif 1300 < exploerKey then
      territoryKey = 4
    else
      territoryKey = 5
    end
    return territoryKey
  end
  local function sortByTerritory(territoryKey)
    for servantIndex = 1, maxStableServantCount do
      if affiliatedTerritory(self._sortByExploreKey[servantIndex]._exploreKey) == territoryKey and false == self._sortByExploreKey[servantIndex]._isDead then
        temp[sIndex] = self._sortByExploreKey[servantIndex]
        sIndex = sIndex + 1
      end
    end
  end
  local myTerritoriKey = affiliatedTerritory(myWayPointKey)
  if 0 == myTerritoriKey then
    sortByTerritory(0)
    sortByTerritory(1)
    sortByTerritory(2)
    sortByTerritory(3)
    sortByTerritory(4)
    sortByTerritory(3)
  elseif 1 == myTerritoriKey then
    sortByTerritory(1)
    sortByTerritory(0)
    sortByTerritory(2)
    sortByTerritory(3)
    sortByTerritory(4)
    sortByTerritory(5)
  elseif 2 == myTerritoriKey then
    sortByTerritory(2)
    sortByTerritory(1)
    sortByTerritory(0)
    sortByTerritory(3)
    sortByTerritory(4)
    sortByTerritory(5)
  elseif 3 == myTerritoriKey then
    sortByTerritory(3)
    sortByTerritory(1)
    sortByTerritory(0)
    sortByTerritory(2)
    sortByTerritory(4)
    sortByTerritory(5)
  elseif 4 == myTerritoriKey then
    sortByTerritory(4)
    sortByTerritory(3)
    sortByTerritory(1)
    sortByTerritory(0)
    sortByTerritory(2)
    sortByTerritory(5)
  elseif 5 == myTerritoriKey then
    sortByTerritory(5)
    sortByTerritory(0)
    sortByTerritory(2)
    sortByTerritory(3)
    sortByTerritory(4)
    sortByTerritory(1)
  end
  for i = 1, maxStableServantCount do
    self._sortByExploreKey[i] = temp[i - 1]
  end
end
function PaGlobal_ServantList_All:stableList_SelectSlotNo(selectedSlotNo)
  if nil == Panel_Dialog_ServantList_All then
    return
  end
  if nil == selectedSlotNo or -1 == selectedSlotNo then
    return
  end
  return (PaGlobal_ServantList_All:sortByWayPointKey(selectedSlotNo))
end
function PaGlobal_ServantList_All:stableList_GetSlotNoByServentNo(servantNo)
  if nil == Panel_Dialog_ServantList_All then
    return nil
  end
  for k, value in pairs(self._sortByExploreKey) do
    if servantNo == value._servantNo then
      return value._index
    end
  end
end
function PaGlobal_ServantList_All:sortByWayPointKey(index)
  if nil == Panel_Dialog_ServantList_All or nil == index then
    return nil
  end
  if nil == self._sortByExploreKey[index + 1] then
    return nil
  end
  return self._sortByExploreKey[index + 1]._index
end
function PaGlobal_ServantList_All:setMyServant()
  if nil == Panel_Dialog_ServantList_All or false == Panel_Dialog_ServantList_All:GetShow() then
    return
  end
  self._ui._btn_CurrentServant:SetShow(true)
  self._ui._btn_CurrentServant:SetIgnore(true)
  self._ui._icon_CurrentServant:SetShow(false)
  self._ui._icon_CurrentServantGender:SetShow(false)
  self._ui._txt_CurrentServantName:SetShow(false)
  self._ui._txt_CurrentServantLocate:SetShow(false)
  self._ui._txt_CurrentServant_Tier:SetShow(false)
  self._ui._icon_CurrentServant_Swift:SetShow(false)
  self._ui._stc_NoServant:SetShow(false)
  if true == PaGlobalFunc_ServantFunction_All_GetIsGuild() then
    return
  end
  self._ui._stc_NoServant:SetShow(true)
  local temporaryWrapper = getTemporaryInformationWrapper()
  if nil == temporaryWrapper then
    return
  end
  local servantInfo = temporaryWrapper:getUnsealVehicle(stable_getServantType())
  if nil ~= servantInfo then
    self._ui._stc_NoServant:SetShow(false)
    self._ui._btn_CurrentServant:SetIgnore(false)
    self._ui._icon_CurrentServant:SetShow(true)
    self._ui._txt_CurrentServantName:SetShow(true)
    self._ui._txt_CurrentServantLocate:SetShow(true)
    self._ui._icon_CurrentServant:ChangeTextureInfoName(servantInfo:getIconPath1())
    self._ui._txt_CurrentServantLocate:SetShow(false)
    local servantTier = servantInfo:getTier()
    local servantType = servantInfo:getVehicleType()
    local isPcroomOnly = servantInfo:isPcroomOnly()
    local npcType = PaGlobalFunc_ServantFunction_All_Get_NpcType()
    self._ui._icon_CurrentServant_Swift:SetShow(false)
    if servantType == CppEnums.VehicleType.Type_Horse and 9 ~= servantTier and false == isPcroomOnly and self._contentsOption._isContentsStallionEnable then
      self._ui._icon_CurrentServant_Swift:SetShow(true)
      if true == servantInfo:isStallion() then
        self._ui._icon_CurrentServant_Swift:SetMonoTone(false, false)
      else
        self._ui._icon_CurrentServant_Swift:SetMonoTone(true, false)
      end
    end
    self._ui._icon_CurrentServantGender:SetShow(false)
    if servantType == CppEnums.VehicleType.Type_Horse and (0 == npcType or 1 == npcType) then
      self._ui._icon_CurrentServantGender:SetShow(true)
      self._ui._icon_CurrentServantGender:ChangeTextureInfoName("combine/etc/combine_etc_stable.dds")
      local x1, y1, x2, y2 = 0, 0, 0, 0
      if true == servantInfo:isMale() then
        x1, y1, x2, y2 = setTextureUV_Func(self._ui._icon_CurrentServantGender, 1, 209, 31, 239)
      else
        x1, y1, x2, y2 = setTextureUV_Func(self._ui._icon_CurrentServantGender, 1, 178, 31, 208)
      end
      self._ui._icon_CurrentServantGender:getBaseTexture():setUV(x1, y1, x2, y2)
      self._ui._icon_CurrentServantGender:setRenderTexture(self._ui._icon_CurrentServantGender:getBaseTexture())
    end
    self._ui._txt_CurrentServant_Tier:SetShow(false)
    if 0 == npcType or 1 == npcType then
      local servantWrapper = temporaryWrapper:getUnsealVehicle(CppEnums.ServantType.Type_Vehicle)
      local horseWrapper = temporaryWrapper:getUnsealVehicle(CppEnums.VehicleType.Type_Horse)
      if nil ~= horseWrapper and 0 < servantTier then
        self._ui._txt_CurrentServant_Tier:SetShow(true)
        if 9 == servantTier then
          self._ui._txt_CurrentServant_Tier:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_SERVANT_TEXT_TIER9"))
        else
          self._ui._txt_CurrentServant_Tier:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_SERVANT_TIER", "tier", servantTier))
        end
      end
    elseif CppEnums.ServantType.Type_Ship == stable_getServantType() then
      local servantWrapper = temporaryWrapper:getUnsealVehicle(CppEnums.ServantType.Type_Ship)
      local shipTypeStr = servantWrapper:getDisplayName()
      if nil == shipTypeStr then
        shipTypeStr = ""
      else
        self._ui._txt_CurrentServant_Tier:SetShow(true)
        self._ui._txt_CurrentServant_Tier:SetText(shipTypeStr)
      end
    end
    self._ui._txt_CurrentServantName:SetText(servantInfo:getName())
    if false == isPcroomOnly and false == PaGlobalFunc_ServantFunction_All_GetIsGuild() and (servantType == CppEnums.VehicleType.Type_Horse or servantType == CppEnums.VehicleType.Type_Camel or servantType == CppEnums.VehicleType.Type_Donkey or servantType == CppEnums.VehicleType.Type_RidableBabyElephant) then
      self._ui._txt_CurrentServantName:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_LV") .. "." .. tostring(servantInfo:getLevel()) .. " " .. servantInfo:getName())
    end
  end
  self._ui._btn_CurrentServant:addInputEvent("Mouse_LUp", "HandleEventOn_ServantList_All_SelectSevant(" .. self._ENUM_TYPEUNSEALED .. ",0)")
end
function PaGlobal_ServantList_All:setTamingServant()
  if nil == Panel_Dialog_ServantList_All or false == Panel_Dialog_ServantList_All:GetShow() then
    return
  end
  self._ui._btn_WildHorseBg:SetShow(false)
  if 0 == PaGlobalFunc_ServantFunction_All_Get_NpcType() or 1 == PaGlobalFunc_ServantFunction_All_Get_NpcType() then
    local characterKey = stable_getTamingServantCharacterKey()
    if nil ~= characterKey then
      local servantInfo = stable_getServantByCharacterKey(characterKey, 1)
      if nil ~= servantInfo then
        if false == PaGlobalFunc_ServantFunction_All_GetIsGuild() then
          if servantInfo:getVehicleType() ~= CppEnums.VehicleType.Type_BabyElephant then
            self._ui._stc_WildHorseImage:ReleaseTexture()
            self._ui._stc_WildHorseImage:ChangeTextureInfoName(servantInfo:getIconPath1())
            self._ui._btn_WildHorseBg:SetShow(true)
            if true == self._isConsole then
              PaGlobal_ServantList_All:setSnapTarget(2)
            end
          end
        elseif servantInfo:getVehicleType() == CppEnums.VehicleType.Type_BabyElephant then
          self._ui._stc_WildHorseImage:ReleaseTexture()
          self._ui._stc_WildHorseImage:ChangeTextureInfoName(servantInfo:getIconPath1())
          self._ui._btn_WildHorseBg:SetShow(true)
          if true == self._isConsole then
            PaGlobal_ServantList_All:setSnapTarget(2)
          end
        end
        self._ui._btn_WildHorse:addInputEvent("Mouse_LUp", "HandleEventLUp_ServantList_All_Register_To_Taming()")
      end
    end
  end
end
function PaGlobal_ServantList_All:dataClear()
  if nil == Panel_Dialog_ServantList_All or false == Panel_Dialog_ServantList_All:GetShow() then
    return
  end
  if false == self._isConsole then
    local effectControl = Paglobal_ServantList_All_GetRegistBtn()
    effectControl:EraseAllEffect()
    if true == stable_doHaveRegisterItem() and false == isSiegeStable() then
      if nil ~= effectControl and false == self._isConsole then
        effectControl:EraseAllEffect()
        effectControl:AddEffect("fUI_Dialog_Servant_01A", true, 0, 0)
        effectControl:SetMonoTone(false, false)
        effectControl:SetIgnore(false)
      end
    else
      effectControl:SetMonoTone(true, true)
      effectControl:SetIgnore(true)
    end
  end
  self._totalServantCount = nil
end
function PaGlobal_ServantList_All:prepareClose()
  if nil == Panel_Dialog_ServantList_All or false == Panel_Dialog_ServantList_All:GetShow() then
    return
  end
  PaGlobalFunc_ServantList_All_SubMenuClose()
  PaGlobal_ServantList_All:dataClear()
  PaGlobal_ServantList_All:close()
end
function PaGlobal_ServantList_All:close()
  if nil == Panel_Dialog_ServantList_All or false == Panel_Dialog_ServantList_All:GetShow() then
    return
  end
  Panel_Dialog_ServantList_All:SetShow(false)
end
function PaGlobal_ServantList_All:subMenuClose(isCloseAll)
  if nil == Panel_Dialog_ServantList_All then
    return
  end
  self._subMenuCount = 0
  self._importantMenuCount = 0
  self._ui._stc_MenuListBg:SetShow(false)
  self._ui._stc_ImportantMenuListBg:SetShow(false)
  if false ~= isCloseAll then
    PaGlobalFunc_ServantList_All_CloseAllShipPanel()
  end
end
function PaGlobal_ServantList_All:subMenuOpen(eType)
  if nil == Panel_Dialog_ServantList_All or false == Panel_Dialog_ServantList_All:GetShow() then
    return
  end
  if true == Panel_Dialog_ServantExchange_All:GetShow() and nil ~= Panel_Dialog_ServantExchange_All then
    return
  end
  PaGlobalFunc_ServantTransferList_All_Close()
  if true == Panel_Dialog_ServantLookChange_All:GetShow() and nil ~= Panel_Dialog_ServantLookChange_All then
    PaGlobalFunc_ServantLookChange_All_Close()
  end
  if nil == self._subMenuGroup or nil == eType then
    return
  end
  self._subMenuCount = 0
  self._importantMenuCount = 0
  for subMenuIndex = 0, self._tempSubBtnCountForCreate - 1 do
    if nil ~= self._subMenuGroup[subMenuIndex] then
      self._subMenuGroup[subMenuIndex]:SetShow(false)
    end
    if nil ~= self._importantMenuGroup[subMenuIndex] then
      self._importantMenuGroup[subMenuIndex]:SetShow(false)
    end
  end
  local regionInfo = getRegionInfoByPosition(getSelfPlayer():get():getPosition())
  local regionName = regionInfo:getAreaName()
  local eServantType = CppEnums.VehicleType
  if eType == self._ENUM_TYPESEALED then
    if nil == PaGlobal_ServantList_All._selectSlotNo or -1 == PaGlobal_ServantList_All._selectSlotNo then
      return
    end
    self._currentSealType = self._ENUM_TYPESEALED
    local index = PaGlobal_ServantList_All:stableList_SelectSlotNo(PaGlobal_ServantList_All._selectSlotNo)
    if nil == index then
      return
    end
    local servantInfo = stable_getServant(index)
    if nil == servantInfo then
      return
    elseif true == servantInfo:isChangingRegion() then
      PaGlobal_ServantList_All:subMenuClose(false)
      return
    end
    if CppEnums.ServantStateType.Type_Return == servantInfo:getStateType() then
      PaGlobal_ServantList_All:subMenuClose(false)
      return
    end
    local vehicleType = servantInfo:getVehicleType()
    local isLinkedHorse = servantInfo:isLink() and CppEnums.VehicleType.Type_Horse == vehicleType
    local servantRegionName = servantInfo:getRegionName()
    local servantLevel = servantInfo:getLevel()
    local getState = servantInfo:getStateType()
    local isPcroomOnly = servantInfo:isPcroomOnly()
    local stable = CppEnums.ServantStateType.Type_Stable
    local nowMating = CppEnums.ServantStateType.Type_Mating
    local regMarket = CppEnums.ServantStateType.Type_RegisterMarket
    local regMating = CppEnums.ServantStateType.Type_RegisterMating
    local training = CppEnums.ServantStateType.Type_SkillTraining
    local stallionTraining = CppEnums.ServantStateType.Type_StallionTraining
    local showChangeRegionButtonFlag = false
    local hasRentOwnerFlag = false
    local getHp = servantInfo:getHp()
    local maxHp = servantInfo:getMaxHp()
    local getMp = servantInfo:getMp()
    local maxMp = servantInfo:getMaxMp()
    if nil ~= servantInfo then
      hasRentOwnerFlag = Defines.s64_const.s64_0 < servantInfo:getRentOwnerNo()
    end
    if true == isSiegeStable() then
      PaGlobal_ServantList_All:setSubMenuData(self._subMenuGroup[self._subMenuCount], self._ENUM_SUBMENUTYPE._UNSEAL, index)
    elseif regionName == servantRegionName then
      audioPostEvent_SystemUi(1, 0)
      if true == isLinkedHorse and stallionTraining ~= getState then
        PaGlobal_ServantList_All:setSubMenuData(self._subMenuGroup[self._subMenuCount], self._ENUM_SUBMENUTYPE._RELEASELINK, index)
      else
        if eServantType.Type_Horse == vehicleType or eServantType.Type_Donkey == vehicleType or eServantType.Type_Camel == vehicleType or eServantType.Type_RidableBabyElephant == vehicleType then
          if nowMating ~= getState and regMarket ~= getState and regMating ~= getState and training ~= getState and stallionTraining ~= getState then
            PaGlobal_ServantList_All:setSubMenuData(self._subMenuGroup[self._subMenuCount], self._ENUM_SUBMENUTYPE._UNSEAL, index)
            showChangeRegionButtonFlag = not servantInfo:isChangingRegion()
          end
        else
          PaGlobal_ServantList_All:setSubMenuData(self._subMenuGroup[self._subMenuCount], self._ENUM_SUBMENUTYPE._UNSEAL, index)
          showChangeRegionButtonFlag = not servantInfo:isChangingRegion()
        end
        if (getHp < maxHp or getMp < maxMp) and (eServantType.Type_Horse == vehicleType or eServantType.Type_Donkey == vehicleType or eServantType.Type_Camel == vehicleType or eServantType.Type_MountainGoat == vehicleType or eServantType.Type_RidableBabyElephant == vehicleType) and not servantInfo:isMatingComplete() and nowMating ~= getState and regMarket ~= getState and regMating ~= getState and training ~= getState and stallionTraining ~= getState then
          PaGlobal_ServantList_All:setSubMenuData(self._subMenuGroup[self._subMenuCount], self._ENUM_SUBMENUTYPE._RECOVERY, index)
        end
        if eServantType.Type_RepairableCarriage == vehicleType then
          if getHp < maxHp or getMp < maxMp then
            PaGlobal_ServantList_All:setSubMenuData(self._subMenuGroup[self._subMenuCount], self._ENUM_SUBMENUTYPE._REPAIR, index)
          end
        elseif (eServantType.Type_Carriage == vehicleType or eServantType.Type_CowCarriage == vehicleType) and getHp < maxHp and stallionTraining ~= getState then
          PaGlobal_ServantList_All:setSubMenuData(self._subMenuGroup[self._subMenuCount], self._ENUM_SUBMENUTYPE._REPAIR, index)
        end
        if servantInfo:isMatingComplete() and stallionTraining ~= getState and false == servantInfo:isMale() then
          PaGlobal_ServantList_All:setSubMenuData(self._subMenuGroup[self._subMenuCount], self._ENUM_SUBMENUTYPE._EXPIREMATING, index)
        end
        if stable_isMarket() and nowMating ~= getState and regMarket ~= getState and regMating ~= getState and training ~= getState and stallionTraining ~= getState and false == hasRentOwnerFlag and (eServantType.Type_Horse == vehicleType or eServantType.Type_Donkey == vehicleType or eServantType.Type_Camel == vehicleType) and regionName == servantRegionName and not servantInfo:isChangingRegion() and 9113 ~= servantInfo:getCharacterKeyRaw() and 9114 ~= servantInfo:getCharacterKeyRaw() and 9115 ~= servantInfo:getCharacterKeyRaw() then
          PaGlobal_ServantList_All:setSubMenuData(self._subMenuGroup[self._subMenuCount], self._ENUM_SUBMENUTYPE._ADDMARKET, index)
        end
        if stable_isMating() and servantInfo:doMating() and servantInfo:isMale() and nowMating ~= getState and regMarket ~= getState and regMating ~= getState and training ~= getState and stallionTraining ~= getState and false == hasRentOwnerFlag and CppEnums.ServantStateType.Type_Stable == servantInfo:getStateType() and regionName == servantRegionName then
          PaGlobal_ServantList_All:setSubMenuData(self._subMenuGroup[self._subMenuCount], self._ENUM_SUBMENUTYPE._REGISTERMATING, index)
        end
        if false == isPcroomOnly and nowMating ~= getState and regMarket ~= getState and regMating ~= getState and training ~= getState and stallionTraining ~= getState and false == hasRentOwnerFlag then
          PaGlobal_ServantList_All:setSubMenuData(self._subMenuGroup[self._subMenuCount], self._ENUM_SUBMENUTYPE._CHANGENAME, index)
        end
        if false == isPcroomOnly and false == hasRentOwnerFlag and nowMating ~= getState and regMarket ~= getState and regMating ~= getState and training ~= getState and stallionTraining ~= getState then
          if vehicleType == eServantType.Type_Horse or vehicleType == eServantType.Type_Camel or vehicleType == eServantType.Type_Donkey or vehicleType == eServantType.Type_Elephant or vehicleType == eServantType.Type_RidableBabyElephant and stallionTraining ~= getState then
            PaGlobal_ServantList_All:setSubMenuData(self._subMenuGroup[self._subMenuCount], self._ENUM_SUBMENUTYPE._RESETDEADCOUNT, index)
          elseif vehicleType == eServantType.Type_Carriage or vehicleType == eServantType.Type_CowCarriage or vehicleType == eServantType.Type_RepairableCarriage and stallionTraining ~= getState then
            PaGlobal_ServantList_All:setSubMenuData(self._subMenuGroup[self._subMenuCount], self._ENUM_SUBMENUTYPE._RESETDESTROYCOUNT, index)
          elseif vehicleType == eServantType.Type_Boat or vehicleType == eServantType.Type_Raft or vehicleType == eServantType.Type_FishingBoat or vehicleType == eServantType.Type_SailingBoat and stallionTraining ~= getState then
            PaGlobal_ServantList_All:setSubMenuData(self._subMenuGroup[self._subMenuCount], self._ENUM_SUBMENUTYPE._RESETDESTROYCOUNT, index)
          end
        end
        if servantInfo:doClearCountByMating() and vehicleType == eServantType.Type_Horse and regMarket ~= getState and nowMating ~= getState and regMating ~= getState and training ~= getState and stallionTraining ~= getState and false == hasRentOwnerFlag then
          PaGlobal_ServantList_All:setSubMenuData(self._subMenuGroup[self._subMenuCount], self._ENUM_SUBMENUTYPE._RESETMATINGCOUNT, index)
        end
        if false == isPcroomOnly and servantInfo:doImprint() and stallionTraining ~= getState and false == hasRentOwnerFlag then
          PaGlobal_ServantList_All:setSubMenuData(self._subMenuGroup[self._subMenuCount], self._ENUM_SUBMENUTYPE._IMPRINT, index)
        end
        if false == isPcroomOnly and eServantType.Type_Horse == vehicleType and nowMating ~= getState and regMarket ~= getState and regMating ~= getState and training ~= getState and regionName == servantRegionName and self._contentsOption._isContentsEnable and stallionTraining ~= getState and false == hasRentOwnerFlag then
          PaGlobal_ServantList_All:setSubMenuData(self._subMenuGroup[self._subMenuCount], self._ENUM_SUBMENUTYPE._CHANGELOOK, index)
        end
        if false == isPcroomOnly and false == hasRentOwnerFlag then
          if eServantType.Type_Horse == vehicleType or eServantType.Type_Donkey == vehicleType or eServantType.Type_Camel == vehicleType or eServantType.Type_RidableBabyElephant == vehicleType and stallionTraining ~= getState then
            if nowMating ~= getState and regMarket ~= getState and regMating ~= getState and training ~= getState then
              if stable_isMarket() and 15 <= servantLevel and eServantType.Type_Horse == vehicleType and self._contentsOption._isContentsEnableSupply then
                PaGlobal_ServantList_All:setSubMenuData(self._subMenuGroup[self._subMenuCount], self._ENUM_SUBMENUTYPE._SUPPLYHORSE, index)
              elseif stallionTraining ~= getState then
                PaGlobal_ServantList_All:setSubMenuData(self._subMenuGroup[self._subMenuCount], self._ENUM_SUBMENUTYPE._RELEASEWILD, index)
              end
            end
          else
            PaGlobal_ServantList_All:setSubMenuData(self._subMenuGroup[self._subMenuCount], self._ENUM_SUBMENUTYPE._SELL, index)
          end
          if servantInfo:isSuppliableForQuest() then
            PaGlobal_ServantList_All:setSubMenuData(self._subMenuGroup[self._subMenuCount], self._ENUM_SUBMENUTYPE._SUPPLYFORQUEST, index)
          end
        end
        if eServantType.Type_Horse == vehicleType and true == servantInfo:isStallion() and stable_isPossibleStallionSkillExpTraining() and self._contentsOption._isContentsStallionEnable and self._contentsOption._isContentsNineTierEnable and self._contentsOption._isContentsNineTierTraining and false == hasRentOwnerFlag and 30 == servantInfo:getLevel() and 8 == servantInfo:getTier() and nowMating ~= getState and regMarket ~= getState and regMating ~= getState and training ~= getState then
          PaGlobal_ServantList_All:setSubMenuData(self._subMenuGroup[self._subMenuCount], self._ENUM_SUBMENUTYPE._SWIFT, index)
        end
        if true == _ContentsGroup_SetBeginningLevelServant and false == hasRentOwnerFlag and false == isPcroomOnly and (eServantType.Type_Horse == vehicleType or eServantType.Type_Donkey == vehicleType or eServantType.Type_Camel == vehicleType or eServantType.Type_RidableBabyElephant == vehicleType) and stable == getState and regionName == servantRegionName then
          PaGlobal_ServantList_All:setSubMenuData(self._subMenuGroup[self._subMenuCount], self._ENUM_SUBMENUTYPE._RESETSERVANT, index)
        end
        if stable_isSkillExpTrainingComplete(index) then
          PaGlobal_ServantList_All:setSubMenuData(self._subMenuGroup[self._subMenuCount], self._ENUM_SUBMENUTYPE._ENDTRAINING, index)
        elseif self._contentsOption._isContentsStallionEnable and stable_isEndStallionSkillExpTraining(index) and self._contentsOption._isContentsNineTierEnable and self._contentsOption._isContentsNineTierTraining then
          PaGlobal_ServantList_All:setSubMenuData(self._subMenuGroup[self._subMenuCount], self._ENUM_SUBMENUTYPE._ENDSWIFT, index)
        end
        if showChangeRegionButtonFlag and false == isPcroomOnly and false == hasRentOwnerFlag then
          PaGlobal_ServantList_All:setSubMenuData(self._subMenuGroup[self._subMenuCount], self._ENUM_SUBMENUTYPE._TRANSFER, index)
        end
        if false == isPcroomOnly and PaGlobal_ServantList_All:check_Show_Rent_Or_ReturnRent_Button(servantInfo, true) and false == isLinkedHorse then
          PaGlobal_ServantList_All:setSubMenuData(self._subMenuGroup[self._subMenuCount], self._ENUM_SUBMENUTYPE._RENT, index)
        end
        if PaGlobal_ServantList_All:check_Show_Rent_Or_ReturnRent_Button(servantInfo, false) then
          PaGlobal_ServantList_All:setSubMenuData(self._subMenuGroup[self._subMenuCount], self._ENUM_SUBMENUTYPE._RETURNRENT, index)
        end
        if eServantType.Type_RepairableCarriage == vehicleType or eServantType.Type_Carriage == vehicleType then
          PaGlobal_ServantList_All:setSubMenuData(self._subMenuGroup[self._subMenuCount], self._ENUM_SUBMENUTYPE._CARRIAGELINK, index)
        end
      end
    elseif not isLinkedHorse and 0 == getHp and (eServantType.Type_Horse == vehicleType or eServantType.Type_Donkey == vehicleType or eServantType.Type_Camel == vehicleType or eServantType.Type_MountainGoat == vehicleType) and not servantInfo:isMatingComplete() and nowMating ~= getState and regMarket ~= getState and regMating ~= getState and training ~= getState and stallionTraining ~= getState then
      PaGlobal_ServantList_All:setSubMenuData(self._subMenuGroup[self._subMenuCount], self._ENUM_SUBMENUTYPE._RECOVERY, index)
      PaGlobal_ServantList_All:setSubMenuData(self._subMenuGroup[self._subMenuCount], self._ENUM_SUBMENUTYPE._UNSEAL, index)
    end
  elseif eType == self._ENUM_TYPEUNSEALED then
    self._currentSealType = self._ENUM_TYPEUNSEALED
    if false == isSiegeStable() then
      local temporaryWrapper = getTemporaryInformationWrapper()
      if nil == temporaryWrapper then
        return
      end
      local unSealServantInfo = temporaryWrapper:getUnsealVehicle(stable_getServantType())
      local vehicleType = unSealServantInfo:getVehicleType()
      local getState = unSealServantInfo:getStateType()
      local nowMating = CppEnums.ServantStateType.Type_Mating
      local regMarket = CppEnums.ServantStateType.Type_RegisterMarket
      local regMating = CppEnums.ServantStateType.Type_RegisterMating
      local getHp = unSealServantInfo:getHp()
      local maxHp = unSealServantInfo:getMaxHp()
      local getMp = unSealServantInfo:getMp()
      local maxMp = unSealServantInfo:getMaxMp()
      PaGlobal_ServantList_All:setSubMenuData(self._subMenuGroup[self._subMenuCount], self._ENUM_SUBMENUTYPE._SEAL, index)
      PaGlobal_ServantList_All:setSubMenuData(self._subMenuGroup[self._subMenuCount], self._ENUM_SUBMENUTYPE._REMOTESEAL, index)
      if (getHp < maxHp or getMp < maxMp) and (eServantType.Type_Horse == vehicleType or eServantType.Type_Donkey == vehicleType or eServantType.Type_Camel == vehicleType or eServantType.Type_MountainGoat == vehicleType or eServantType.Type_RidableBabyElephant == vehicleType) and not unSealServantInfo:isMatingComplete() and nowMating ~= getState and regMarket ~= getState and regMating ~= getState then
        PaGlobal_ServantList_All:setSubMenuData(self._subMenuGroup[self._subMenuCount], self._ENUM_SUBMENUTYPE._RECOVERYUNSEALED, index)
      end
      if eServantType.Type_RepairableCarriage == vehicleType then
        if getHp < maxHp or getMp < maxMp then
          PaGlobal_ServantList_All:setSubMenuData(self._subMenuGroup[self._subMenuCount], self._ENUM_SUBMENUTYPE._REPAIRUNSEALED, index)
        end
      elseif (eServantType.Type_Carriage == vehicleType or eServantType.Type_CowCarriage == vehicleType) and getHp < maxHp then
        PaGlobal_ServantList_All:setSubMenuData(self._subMenuGroup[self._subMenuCount], self._ENUM_SUBMENUTYPE._REPAIRUNSEALED, index)
      end
    end
  end
  PaGlobal_ServantList_All:adjustSubMenu()
end
function PaGlobal_ServantList_All:guildSubMenuOpen(eType)
  if nil == Panel_Dialog_ServantList_All or false == Panel_Dialog_ServantList_All:GetShow() then
    return
  end
  if nil == self._subMenuGroup or nil == eType then
    return
  end
  self._subMenuCount = 0
  self._importantMenuCount = 0
  for subMenuIndex = 0, self._tempSubBtnCountForCreate - 1 do
    if nil ~= self._subMenuGroup[subMenuIndex] then
      self._subMenuGroup[subMenuIndex]:SetShow(false)
    end
    if nil ~= self._importantMenuGroup[subMenuIndex] then
      self._importantMenuGroup[subMenuIndex]:SetShow(false)
    end
  end
  local regionInfo = getRegionInfoByPosition(getSelfPlayer():get():getPosition())
  local regionName = regionInfo:getAreaName()
  if false == PaGlobalFunc_ServantFunction_All_GetIsGuild() then
    return
  end
  if eType == self._ENUM_TYPESEALED then
    if nil == PaGlobal_ServantList_All._selectSlotNo or -1 == PaGlobal_ServantList_All._selectSlotNo then
      return
    end
    self._currentSealType = self._ENUM_TYPESEALED
    local index = PaGlobal_ServantList_All:stableList_SelectSlotNo(PaGlobal_ServantList_All._selectSlotNo)
    if nil == index then
      return
    end
    local servantInfo = guildStable_getServant(index)
    if nil == servantInfo then
      return
    end
    local vehicleType = servantInfo:getVehicleType()
    local servantRegionName = servantInfo:getRegionName()
    local servantLevel = servantInfo:getLevel()
    local deadCount = servantInfo:getDeadCount()
    local getState = servantInfo:getStateType()
    local stable = CppEnums.ServantStateType.Type_Stable
    local stallionTraining = CppEnums.ServantStateType.Type_StallionTraining
    local showChangeRegionButtonFlag = false
    if regionName == servantRegionName then
      audioPostEvent_SystemUi(1, 0)
      if 10 <= deadCount then
        if CppEnums.ServantStateType.Type_Coma ~= getState then
          PaGlobal_ServantList_All:setSubMenuData(self._subMenuGroup[self._subMenuCount], self._ENUM_SUBMENUTYPE._UNSEAL, index)
        end
        PaGlobal_ServantList_All:setSubMenuData(self._subMenuGroup[self._subMenuCount], self._ENUM_SUBMENUTYPE._RECOVERINJURY, index)
        if servantInfo:getHp() < servantInfo:getMaxHp() or servantInfo:getMp() < servantInfo:getMaxMp() then
          PaGlobal_ServantList_All:setSubMenuData(self._subMenuGroup[self._subMenuCount], self._ENUM_SUBMENUTYPE._RECOVERY, index)
        end
      elseif CppEnums.ServantStateType.Type_Stable == getState then
        PaGlobal_ServantList_All:setSubMenuData(self._subMenuGroup[self._subMenuCount], self._ENUM_SUBMENUTYPE._UNSEAL, index)
        PaGlobal_ServantList_All:setSubMenuData(self._subMenuGroup[self._subMenuCount], self._ENUM_SUBMENUTYPE._RELEASESERVANT, index)
        if servantInfo:getHp() < servantInfo:getMaxHp() or servantInfo:getMp() < servantInfo:getMaxMp() then
          PaGlobal_ServantList_All:setSubMenuData(self._subMenuGroup[self._subMenuCount], self._ENUM_SUBMENUTYPE._RECOVERY, index)
        end
        if 0 < deadCount then
          PaGlobal_ServantList_All:setSubMenuData(self._subMenuGroup[self._subMenuCount], self._ENUM_SUBMENUTYPE._RECOVERINJURY, index)
        end
      elseif CppEnums.ServantStateType.Type_Coma == getState then
        PaGlobal_ServantList_All:setSubMenuData(self._subMenuGroup[self._subMenuCount], self._ENUM_SUBMENUTYPE._RECOVERY, index)
      end
    end
    if CppEnums.ServantStateType.Type_Field == getState then
      PaGlobal_ServantList_All:setSubMenuData(self._subMenuGroup[self._subMenuCount], self._ENUM_SUBMENUTYPE._SEAL, index)
      PaGlobal_ServantList_All:setSubMenuData(self._subMenuGroup[self._subMenuCount], self._ENUM_SUBMENUTYPE._REMOTESEAL, index)
    end
  end
  PaGlobal_ServantList_All:adjustSubMenu()
end
function PaGlobal_ServantList_All:shipSubMenuOpen(eType)
  if nil == Panel_Dialog_ServantList_All or false == Panel_Dialog_ServantList_All:GetShow() then
    return
  end
  if true == Panel_Dialog_ServantLookChange_All:GetShow() then
    PaGlobalFunc_ServantLookChange_All_Close()
  end
  if nil == self._subMenuGroup or nil == eType then
    return
  end
  self._subMenuCount = 0
  self._importantMenuCount = 0
  for subMenuIndex = 0, self._tempSubBtnCountForCreate - 1 do
    if nil ~= self._subMenuGroup[subMenuIndex] then
      self._subMenuGroup[subMenuIndex]:SetShow(false)
    end
    if nil ~= self._importantMenuGroup[subMenuIndex] then
      self._importantMenuGroup[subMenuIndex]:SetShow(false)
    end
  end
  local regionInfo = getRegionInfoByPosition(getSelfPlayer():get():getPosition())
  local regionName = regionInfo:getAreaName()
  if eType == self._ENUM_TYPESEALED then
    if nil == PaGlobal_ServantList_All._selectSlotNo or -1 == PaGlobal_ServantList_All._selectSlotNo then
      return
    end
    self._currentSealType = self._ENUM_TYPESEALED
    local index = PaGlobal_ServantList_All:stableList_SelectSlotNo(PaGlobal_ServantList_All._selectSlotNo)
    if nil == index then
      return
    end
    local servantInfo = stable_getServant(index)
    if nil == servantInfo then
      return
    elseif servantInfo:isChangingRegion() then
      PaGlobal_ServantList_All:subMenuClose(false)
      return
    end
    audioPostEvent_SystemUi(1, 0)
    local servantRegionName = servantInfo:getRegionName()
    local getState = servantInfo:getStateType()
    local nowHp = servantInfo:getHp()
    local maxHp = servantInfo:getMaxHp()
    local nowMp = getMpToServantInfo(servantInfo)
    local maxMp = getMaxMpToServantInfo(servantInfo)
    local vehicleType = servantInfo:getVehicleType()
    local showChangeRegionButtonFlag = false
    if regionName == servantRegionName then
      PaGlobal_ServantList_All:setSubMenuData(self._subMenuGroup[self._subMenuCount], self._ENUM_SUBMENUTYPE._UNSEAL, index)
      showChangeRegionButtonFlag = not servantInfo:isChangingRegion()
      if nowHp < maxHp then
        PaGlobal_ServantList_All:setSubMenuData(self._subMenuGroup[self._subMenuCount], self._ENUM_SUBMENUTYPE._REPAIR, index)
      end
      if FGlobal_IsCommercialService() then
        PaGlobal_ServantList_All:setSubMenuData(self._subMenuGroup[self._subMenuCount], self._ENUM_SUBMENUTYPE._CHANGENAME, index)
        if true == _ContentsGroup_OceanCurrent then
          if true == servantInfo:getIsDamageShip() then
            PaGlobal_ServantList_All:setSubMenuData(self._subMenuGroup[self._subMenuCount], self._ENUM_SUBMENUTYPE._RESTOREDAMAGE, index)
          else
            PaGlobal_ServantList_All:setSubMenuData(self._subMenuGroup[self._subMenuCount], self._ENUM_SUBMENUTYPE._RESETDESTROYCOUNT, index)
          end
        else
          PaGlobal_ServantList_All:setSubMenuData(self._subMenuGroup[self._subMenuCount], self._ENUM_SUBMENUTYPE._RESETDESTROYCOUNT, index)
        end
      end
      PaGlobal_ServantList_All:setSubMenuData(self._subMenuGroup[self._subMenuCount], self._ENUM_SUBMENUTYPE._SELL, index)
      if true == showChangeRegionButtonFlag then
        PaGlobal_ServantList_All:setSubMenuData(self._subMenuGroup[self._subMenuCount], self._ENUM_SUBMENUTYPE._TRANSFER, index)
      end
      if true == _ContentsGroup_SailBoatCash and (CppEnums.VehicleType.Type_PersonTradeShip == vehicleType or CppEnums.VehicleType.Type_PersonalBattleShip == vehicleType) then
        PaGlobal_ServantList_All:setSubMenuData(self._subMenuGroup[self._subMenuCount], self._ENUM_SUBMENUTYPE._CHANGELOOK, index)
      end
      if nil ~= servantInfo and nil ~= ToClient_servantUpgradeCharacterKeyList(servantInfo:getCharacterKeyRaw()) then
        PaGlobal_ServantList_All:setSubMenuData(self._subMenuGroup[self._subMenuCount], self._ENUM_SUBMENUTYPE._UPGRADE, index)
      end
    elseif nowHp <= 0 then
      PaGlobal_ServantList_All:setSubMenuData(self._subMenuGroup[self._subMenuCount], self._ENUM_SUBMENUTYPE._REPAIR, index)
    end
  elseif eType == self._ENUM_TYPEUNSEALED then
    self._currentSealType = self._ENUM_TYPEUNSEALED
    local temporaryWrapper = getTemporaryInformationWrapper()
    if nil == temporaryWrapper then
      return
    end
    local servantInfo = temporaryWrapper:getUnsealVehicle(stable_getServantType())
    if nil == servantInfo then
      return
    end
    PaGlobal_ServantList_All:setSubMenuData(self._subMenuGroup[self._subMenuCount], self._ENUM_SUBMENUTYPE._SEAL, index)
    if true == _ContentsGroup_Sailor then
      local shipStaticStatus = ToClient_EmployeeCharacterShipStaticStatusWrapper(servantInfo:getCharacterKeyRaw())
      if nil ~= shipStaticStatus and 0 < shipStaticStatus:getEmployeeMaxCost() then
        PaGlobal_ServantList_All:setSubMenuData(self._subMenuGroup[self._subMenuCount], self._ENUM_SUBMENUTYPE._SAILORMANGER, index)
      end
    end
    if true == _ContentsGroup_Barter then
      local shipStaticStatus = ToClient_EmployeeCharacterShipStaticStatusWrapper(servantInfo:getCharacterKeyRaw())
      PaGlobal_ServantList_All:setSubMenuData(self._subMenuGroup[self._subMenuCount], self._ENUM_SUBMENUTYPE._CARGOLOADING, index)
    end
    if true == _ContentsGroup_OceanCurrent then
      local shipStaticStatus = ToClient_EmployeeCharacterShipStaticStatusWrapper(servantInfo:getCharacterKeyRaw())
      if nil ~= shipStaticStatus and (0 < Int64toInt32(shipStaticStatus:getRecoveryFoodCount()) or 0 < Int64toInt32(shipStaticStatus:getRecoveryCannonCount())) then
        PaGlobal_ServantList_All:setSubMenuData(self._subMenuGroup[self._subMenuCount], self._ENUM_SUBMENUTYPE._FOODFEED, index)
      end
    end
    PaGlobal_ServantList_All:setSubMenuData(self._subMenuGroup[self._subMenuCount], self._ENUM_SUBMENUTYPE._REMOTESEAL, index)
  end
  PaGlobal_ServantList_All:adjustSubMenu()
end
function PaGlobal_ServantList_All:guildShipSubMenuOpen(eType)
  if nil == Panel_Dialog_ServantList_All or false == Panel_Dialog_ServantList_All:GetShow() then
    return
  end
  if nil == self._subMenuGroup or nil == eType then
    return
  end
  self._subMenuCount = 0
  self._importantMenuCount = 0
  for subMenuIndex = 0, self._tempSubBtnCountForCreate - 1 do
    if nil ~= self._subMenuGroup[subMenuIndex] then
      self._subMenuGroup[subMenuIndex]:SetShow(false)
    end
    if nil ~= self._importantMenuGroup[subMenuIndex] then
      self._importantMenuGroup[subMenuIndex]:SetShow(false)
    end
  end
  local regionInfo = getRegionInfoByPosition(getSelfPlayer():get():getPosition())
  local regionName = regionInfo:getAreaName()
  if eType == self._ENUM_TYPESEALED then
    if nil == PaGlobal_ServantList_All._selectSlotNo or -1 == PaGlobal_ServantList_All._selectSlotNo then
      return
    end
    self._currentSealType = self._ENUM_TYPESEALED
    local index = PaGlobal_ServantList_All:stableList_SelectSlotNo(PaGlobal_ServantList_All._selectSlotNo)
    if nil == index then
      return
    end
    local servantInfo = guildStable_getServant(index)
    if nil == servantInfo then
      return
    elseif servantInfo:isChangingRegion() then
      PaGlobal_ServantList_All:subMenuClose(false)
      return
    end
    local vehicleType = servantInfo:getVehicleType()
    local servantRegionName = servantInfo:getRegionName(index)
    local servantLevel = servantInfo:getLevel()
    local getState = servantInfo:getStateType()
    local deadCount = servantInfo:getDeadCount()
    if CppEnums.ServantStateType.Type_Field == servantInfo:getStateType() then
      PaGlobal_ServantList_All:setSubMenuData(self._subMenuGroup[self._subMenuCount], self._ENUM_SUBMENUTYPE._SEAL, index)
      PaGlobal_ServantList_All:setSubMenuData(self._subMenuGroup[self._subMenuCount], self._ENUM_SUBMENUTYPE._REMOTESEAL, index)
      if true == _ContentsGroup_Barter then
        PaGlobal_ServantList_All:setSubMenuData(self._subMenuGroup[self._subMenuCount], self._ENUM_SUBMENUTYPE._CARGOLOADING, index)
      end
    elseif regionName == servantRegionName then
      if 10 <= deadCount then
        if CppEnums.ServantStateType.Type_Coma ~= servantInfo:getStateType() then
          PaGlobal_ServantList_All:setSubMenuData(self._subMenuGroup[self._subMenuCount], self._ENUM_SUBMENUTYPE._SELL, index)
        end
        PaGlobal_ServantList_All:setSubMenuData(self._subMenuGroup[self._subMenuCount], self._ENUM_SUBMENUTYPE._RESTOREDAMAGE, index)
        if servantInfo:getHp() < servantInfo:getMaxHp() then
          PaGlobal_ServantList_All:setSubMenuData(self._subMenuGroup[self._subMenuCount], self._ENUM_SUBMENUTYPE._REPAIR, index)
        end
        if true == _ContentsGroup_OceanCurrent then
          PaGlobal_ServantList_All:setSubMenuData(self._subMenuGroup[self._subMenuCount], self._ENUM_SUBMENUTYPE._FOODFEED, index)
        end
      elseif CppEnums.ServantStateType.Type_Stable == servantInfo:getStateType() then
        PaGlobal_ServantList_All:setSubMenuData(self._subMenuGroup[self._subMenuCount], self._ENUM_SUBMENUTYPE._UNSEAL, index)
        PaGlobal_ServantList_All:setSubMenuData(self._subMenuGroup[self._subMenuCount], self._ENUM_SUBMENUTYPE._SELL, index)
        local isRepair = false
        if servantInfo:getHp() < servantInfo:getMaxHp() then
          isRepair = true
        end
        if false == isRepair and false == _ContentsGroup_OceanCurrent and getMpToServantInfo(servantInfo) < getMaxMpToServantInfo(servantInfo) then
          isRepair = true
        end
        if true == isRepair then
          PaGlobal_ServantList_All:setSubMenuData(self._subMenuGroup[self._subMenuCount], self._ENUM_SUBMENUTYPE._REPAIR, index)
        end
        if true == _ContentsGroup_OceanCurrent then
          PaGlobal_ServantList_All:setSubMenuData(self._subMenuGroup[self._subMenuCount], self._ENUM_SUBMENUTYPE._FOODFEED, index)
        end
        if 0 < deadCount then
          PaGlobal_ServantList_All:setSubMenuData(self._subMenuGroup[self._subMenuCount], self._ENUM_SUBMENUTYPE._RESTOREDAMAGE, index)
        end
      elseif CppEnums.ServantStateType.Type_Coma == servantInfo:getStateType() then
        PaGlobal_ServantList_All:setSubMenuData(self._subMenuGroup[self._subMenuCount], self._ENUM_SUBMENUTYPE._REPAIR, index)
      end
    end
  end
  PaGlobal_ServantList_All:adjustSubMenu()
end
function PaGlobal_ServantList_All:adjustSubMenu()
  if nil == Panel_Dialog_ServantList_All or false == Panel_Dialog_ServantList_All:GetShow() then
    return
  end
  local tempPosY = 0
  local possiblePosYRange = 0
  local total = 0
  if 0 ~= self._subMenuCount then
    local sizeX = self._ui._stc_MenuListBg:GetSizeX()
    local sizeY = self._ORIGINAL_SUBMENU_SIZEY * self._subMenuCount
    self._ui._stc_MenuListBg:SetSize(sizeX, sizeY)
    if self._currentSealType == self._ENUM_TYPEUNSEALED then
      local currentServantSlot = self._ui._stc_CurrentServantBg:GetPosY() + self._ui._btn_CurrentServant:GetPosY()
      self._ui._stc_MenuListBg:SetPosY(currentServantSlot)
    else
      local selectSlot = self._ui._list2_Servant:GetContentByKey(toInt64(0, PaGlobal_ServantList_All._selectSlotNo))
      if nil ~= PaGlobal_ServantList_All._selectSlotNo and nil ~= selectSlot then
        local selectSlotPosY = selectSlot:GetPosY()
        tempPosY = self._ui._list2_Servant:GetPosY() + selectSlotPosY
        possiblePosYRange = getScreenSizeY() - Panel_Dialog_ServantFunction_All:GetSizeY()
        total = tempPosY + self._ui._stc_MenuListBg:GetSizeY()
        if possiblePosYRange < total then
          local gap = total - possiblePosYRange + 10
          self._ui._stc_MenuListBg:SetPosY(self._ui._list2_Servant:GetPosY() + selectSlotPosY - gap)
        else
          self._ui._stc_MenuListBg:SetPosY(self._ui._list2_Servant:GetPosY() + selectSlotPosY)
        end
      else
        self._ui._stc_MenuListBg:SetPosY(self._ui._list2_Servant:GetPosY())
      end
    end
    self._ui._stc_MenuListBg:SetShow(true)
  else
    self._ui._stc_MenuListBg:SetShow(false)
  end
  if 0 ~= self._importantMenuCount then
    local sizeX = self._ui._stc_ImportantMenuListBg:GetSizeX()
    local sizeY = self._ORIGINAL_SUBMENU_SIZEY * self._importantMenuCount
    self._ui._stc_ImportantMenuListBg:SetSize(sizeX, sizeY)
    total = tempPosY + self._ui._stc_MenuListBg:GetSizeY() + self._ui._stc_ImportantMenuListBg:GetSizeY()
    if possiblePosYRange < total and 0 ~= tempPosY then
      self._ui._stc_MenuListBg:SetPosY(self._ui._stc_MenuListBg:GetPosY() - self._ui._stc_ImportantMenuListBg:GetSizeY() - 10)
    end
    self._ui._stc_ImportantMenuListBg:SetPosY(self._ui._stc_MenuListBg:GetPosY() + self._ui._stc_MenuListBg:GetSizeY() + 10)
    self._ui._stc_ImportantMenuListBg:SetShow(true)
  else
    self._ui._stc_ImportantMenuListBg:SetShow(false)
  end
end
function PaGlobal_ServantList_All:check_Show_Rent_Or_ReturnRent_Button(servantInfo, isRent)
  if nil == Panel_Dialog_ServantList_All or false == Panel_Dialog_ServantList_All:GetShow() then
    return
  end
  if false == self._contentsOption._isContentsGroup_ServantRent then
    return false
  end
  if true == isSiegeStable() then
    return false
  end
  if nil == getSelfPlayer() then
    return false
  end
  local regionInfo = getRegionInfoByPosition(getSelfPlayer():get():getPosition())
  if not regionInfo then
    return false
  end
  if regionInfo:getAreaName() ~= servantInfo:getRegionName() then
    return false
  end
  local availableTypeTable = {
    CppEnums.VehicleType.Type_Horse,
    CppEnums.VehicleType.Type_Donkey,
    CppEnums.VehicleType.Type_Camel,
    CppEnums.VehicleType.Type_RidableBabyElephant
  }
  local availableVehicleTypeFlag = false
  for i = 1, #availableTypeTable do
    if servantInfo:getVehicleType() == availableTypeTable[i] then
      availableVehicleTypeFlag = true
      break
    end
  end
  if not availableVehicleTypeFlag then
    return false
  end
  local unavailableStateTable = {
    CppEnums.ServantStateType.Type_Mating,
    CppEnums.ServantStateType.Type_RegisterMarket,
    CppEnums.ServantStateType.Type_RegisterMating,
    CppEnums.ServantStateType.Type_SkillTraining,
    CppEnums.ServantStateType.Type_StallionTraining
  }
  for i = 1, #unavailableStateTable do
    if servantInfo:getStateType() == unavailableStateTable[i] then
      return false
    end
  end
  local hasRentOwnerFlag = false
  if nil ~= servantInfo then
    hasRentOwnerFlag = Defines.s64_const.s64_0 < servantInfo:getRentOwnerNo()
  end
  if true == isRent then
    if hasRentOwnerFlag then
      return false
    end
  elseif not hasRentOwnerFlag then
    return false
  end
  return true
end
function PaGlobal_ServantList_All:setGuildPanel(isGuild)
  if true == isGuild then
    self._ui._stc_CurrentServantBg:SetShow(false)
    self._ui._txt_CurrentServantTitle:SetShow(false)
    Panel_Dialog_ServantList_All:SetSize(Panel_Dialog_ServantList_All:GetSizeX(), self._ORIGINAL_PANEL_SIZEY - self._ui._stc_CurrentServantBg:GetSizeY() - self._ui._txt_CurrentServantTitle:GetSizeY() - 30)
    self._ui._txt_ServantListTitle:SetSpanSize(self._ui._txt_ServantListTitle:GetSpanSize().x, self._ui._txt_CurrentServantTitle:GetSpanSize().y)
    self._ui._txt_ServantListValue:SetSpanSize(self._ui._txt_ServantListTitle:GetSpanSize().x, self._ui._txt_CurrentServantTitle:GetSpanSize().y)
    self._ui._list2_Servant:SetSpanSize(self._ui._list2_Servant:GetSpanSize().x, self._ui._stc_CurrentServantBg:GetSpanSize().y)
  else
    self._ui._stc_CurrentServantBg:SetShow(true)
    self._ui._txt_CurrentServantTitle:SetShow(true)
    Panel_Dialog_ServantList_All:SetSize(Panel_Dialog_ServantList_All:GetSizeX(), self._ORIGINAL_PANEL_SIZEY)
    self._ui._txt_ServantListTitle:SetSpanSize(self._ui._txt_ServantListTitle:GetSpanSize().x, self._ORIGINAL_LISTTITLE_SPANY)
    self._ui._txt_ServantListValue:SetSpanSize(self._ui._txt_ServantListTitle:GetSpanSize().x, self._ORIGINAL_LISTTITLE_SPANY)
    self._ui._list2_Servant:SetSpanSize(self._ui._list2_Servant:GetSpanSize().x, self._ORIGINAL_LIST2_SPANY)
  end
  Panel_Dialog_ServantList_All:ComputePos()
  self._ui._txt_ServantListTitle:ComputePos()
  self._ui._txt_ServantListValue:ComputePos()
  self._ui._list2_Servant:ComputePos()
  self._ui.stc_emptyContorlForSnap:ComputePos()
  self._ui._stc_StatusBg:ComputePos()
  self._ui._btn_IncreaseSlot:ComputePos()
  self._ui._btn_Regist:ComputePos()
end
function PaGlobal_ServantList_All:setSubMenuData(control, menutype, slotIndex)
  if nil == menutype or nil == control or nil == Panel_Dialog_ServantList_All or false == Panel_Dialog_ServantList_All:GetShow() then
    return
  end
  local currentNPCType = PaGlobalFunc_ServantFunction_All_Get_NpcType()
  control:SetText("")
  control:addInputEvent("Mouse_LUp", "")
  self._isImportantMenu = false
  if menutype == self._ENUM_SUBMENUTYPE._UNSEAL then
    control:SetText(PAGetString(Defines.StringSheet_RESOURCE, "STABLE_FUNCTION_BTN_UNSEAL"))
    control:addInputEvent("Mouse_LUp", "HandleEventLUp_ServantList_All_UnSealBy_CurrentServantNo()")
  elseif menutype == self._ENUM_SUBMENUTYPE._RECOVERY then
    control:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTLISTALL_RECOVERY"))
    control:addInputEvent("Mouse_LUp", "HandleEventLUp_ServantList_All_Recovery_Sealed_Servant()")
  elseif menutype == self._ENUM_SUBMENUTYPE._ADDMARKET then
    control:SetText(PAGetString(Defines.StringSheet_RESOURCE, "STABLE_LIST_BTN_MARKETREGISTER"))
    control:addInputEvent("Mouse_LUp", "HandleEventLUp_ServantList_All_Regist_To_ServantMarket()")
  elseif menutype == self._ENUM_SUBMENUTYPE._CHANGENAME then
    control:SetText(PAGetString(Defines.StringSheet_RESOURCE, "STABLE_LIST_BTN_CHANGENAME"))
    control:addInputEvent("Mouse_LUp", "HandleEventLUp_ServantList_All_ChangeName()")
  elseif menutype == self._ENUM_SUBMENUTYPE._RESETDEADCOUNT then
    control:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_STABLELIST_KILLCOUNTRESET"))
    control:addInputEvent("Mouse_LUp", "HandleEventLUp_ServantList_All_ResetDeadCount()")
  elseif menutype == self._ENUM_SUBMENUTYPE._RESETMATINGCOUNT then
    control:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_STABLE_LIST_INCREASEMATINGCOUNT"))
    control:addInputEvent("Mouse_LUp", "HandleEventLUp_ServantList_All_ResetMatingCount()")
  elseif menutype == self._ENUM_SUBMENUTYPE._RESETDESTROYCOUNT then
    control:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_STABLELIST_DESTROYCOUNTRESET"))
    control:addInputEvent("Mouse_LUp", "HandleEventLUp_ServantList_All_ResetDeadCount()")
  elseif menutype == self._ENUM_SUBMENUTYPE._RESTOREDAMAGE then
    control:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_STABLELIST_RESTOREDAMAGE"))
    control:addInputEvent("Mouse_LUp", "HandleEventLUp_ServantList_All_ResetDeadCount()")
  elseif menutype == self._ENUM_SUBMENUTYPE._SWIFT then
    control:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_STABLESTALLION_TRAINING"))
    control:addInputEvent("Mouse_LUp", "HandleEventLUp_ServantList_All_StartStallionTraining()")
  elseif menutype == self._ENUM_SUBMENUTYPE._CHANGELOOK then
    control:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WINDOW_STABLEFUNCTION_LOOKCHANGE"))
    control:addInputEvent("Mouse_LUp", "HandleEventLUp_ServantList_All_ServantLookChange()")
  elseif menutype == self._ENUM_SUBMENUTYPE._SELL then
    self._isImportantMenu = true
    control = self._importantMenuGroup[self._importantMenuCount]
    if 3 == currentNPCType then
      control:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTLISTALL_RETURN"))
    else
      control:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTLISTALL_SELL"))
    end
    control:addInputEvent("Mouse_LUp", "HandleEventLUp_ServantList_All_SellServant()")
  elseif menutype == self._ENUM_SUBMENUTYPE._TRANSFER then
    control:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTLISTALL_TRANSFER"))
    control:addInputEvent("Mouse_LUp", "HandleEventLUp_ServantList_All_TransferServant()")
  elseif menutype == self._ENUM_SUBMENUTYPE._RENT then
    control:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTLISTALL_RENT"))
    control:addInputEvent("Mouse_LUp", "HandleEventLUp_ServantList_All_Register_To_RentMarket()")
  elseif menutype == self._ENUM_SUBMENUTYPE._SEAL then
    control:SetText(PAGetString(Defines.StringSheet_RESOURCE, "STABLE_FUNCTION_BTN_SEAL"))
    control:addInputEvent("Mouse_LUp", "HandleEventLUp_ServantList_All_SealMyServant(false)")
  elseif menutype == self._ENUM_SUBMENUTYPE._REMOTESEAL then
    self._isImportantMenu = true
    control = self._importantMenuGroup[self._importantMenuCount]
    control:SetText(PAGetString(Defines.StringSheet_RESOURCE, "STABLE_LIST_BTN_REMOTE"))
    control:addInputEvent("Mouse_LUp", "HandleEventLUp_ServantList_All_SealMyServant(true)")
  elseif menutype == self._ENUM_SUBMENUTYPE._RELEASEWILD then
    self._isImportantMenu = true
    control = self._importantMenuGroup[self._importantMenuCount]
    control:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_SERVANT_STABEL_SELL_NOTIFY_TITLE"))
    control:addInputEvent("Mouse_LUp", "HandleEventLUp_ServantList_All_SellServant()")
  elseif menutype == self._ENUM_SUBMENUTYPE._RETURNRENT then
    control:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTLISTALL_RETURNRENT"))
    control:addInputEvent("Mouse_LUp", "HandleEventLUp_ServantList_All_ReturnRent()")
  elseif menutype == self._ENUM_SUBMENUTYPE._REPAIR then
    control:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTLISTALL_REPAIR"))
    if 0 == currentNPCType or 1 == currentNPCType then
      control:addInputEvent("Mouse_LUp", "HandleEventLUp_ServantList_All_Recovery_Sealed_Servant()")
    elseif 2 == currentNPCType or 3 == currentNPCType then
      control:addInputEvent("Mouse_LUp", "HandleEventLUp_ServantList_All_RepairShip()")
    end
  elseif menutype == self._ENUM_SUBMENUTYPE._ENDTRAINING then
    control:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WINDOW_STABLEFUNCTION_TRAINFINISH"))
    control:addInputEvent("Mouse_LUp", "HandleEventLUp_ServantList_All_TrainingFinish(false)")
  elseif menutype == self._ENUM_SUBMENUTYPE._RELEASELINK then
    control:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WINDOW_STABLELIST_RELEASETOCARRIAGE"))
    control:addInputEvent("Mouse_LUp", "HandleEventLUp_ServantList_All_Servant_UnLink()")
  elseif menutype == self._ENUM_SUBMENUTYPE._EXPIREMATING then
    control:SetText(PAGetString(Defines.StringSheet_RESOURCE, "STABLE_LIST_BTN_EXPIREMATING"))
    control:addInputEvent("Mouse_LUp", "HandleEventLUp_ServantList_All_RecieveChild()")
  elseif menutype == self._ENUM_SUBMENUTYPE._SUPPLYHORSE then
    control:SetText(PAGetString(Defines.StringSheet_RESOURCE, "STABLE_LIST_BTN_SUPPLY"))
    control:addInputEvent("Mouse_LUp", "HandleEventLUp_ServantList_All_SupplyServant()")
  elseif menutype == self._ENUM_SUBMENUTYPE._RESETSERVANT then
    control:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WINDOW_STABLEFUNCTION_SETBEGINNINGLEVEL"))
    control:addInputEvent("Mouse_LUp", "HandleEventLUp_ServantList_All_ResetServant()")
  elseif menutype == self._ENUM_SUBMENUTYPE._REGISTERMATING then
    control:SetText(PAGetString(Defines.StringSheet_RESOURCE, "STABLE_LIST_BTN_MATINGREGISTER"))
    control:addInputEvent("Mouse_LUp", "HandleEventLUp_ServantList_All_Regiset_To_Mating()")
  elseif menutype == self._ENUM_SUBMENUTYPE._SUPPLYFORQUEST then
    control:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WINDOW_STABLEFUNCTION_LOOKCHANGE"))
    control:addInputEvent("Mouse_LUp", "HandleEventLUp_ServantList_All_SupplyForQueset()")
  elseif menutype == self._ENUM_SUBMENUTYPE._RECOVERYUNSEALED then
    control:SetText(PAGetString(Defines.StringSheet_RESOURCE, "STABLE_LIST_BTN_HEAL"))
    control:addInputEvent("Mouse_LUp", "HandleEventLUp_ServantList_All_Recovery_UnSealed_Servant()")
  elseif menutype == self._ENUM_SUBMENUTYPE._IMPRINT then
    control:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTLISTALL_IMPRINT"))
    control:addInputEvent("Mouse_LUp", "HandleEventLUp_ServantList_All_Imprint(true)")
  elseif menutype == self._ENUM_SUBMENUTYPE._RECOVERINJURY then
    control:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_GUILDSTABLE_RECOVERYINJURY"))
    control:addInputEvent("Mouse_LUp", "HandleEventLUp_ServantList_All_RecoverInjury()")
  elseif menutype == self._ENUM_SUBMENUTYPE._RELEASESERVANT then
    self._isImportantMenu = true
    control = self._importantMenuGroup[self._importantMenuCount]
    control:SetText(PAGetString(Defines.StringSheet_RESOURCE, "STABLE_LIST_BTN_RELEASE"))
    control:addInputEvent("Mouse_LUp", "HandleEventLUp_ServantList_All_ReleaseServant()")
  elseif menutype == self._ENUM_SUBMENUTYPE._SAILORMANGER then
    control:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SAILORMANAGER_TITLE"))
    control:addInputEvent("Mouse_LUp", "HandleEventLUp_ServantList_All_SailorManagerOpen()")
  elseif menutype == self._ENUM_SUBMENUTYPE._CARGOLOADING then
    control:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WINDOW_CARGOLOADING"))
    control:addInputEvent("Mouse_LUp", "HandleEventLUp_ServantList_All_CargoLoadingOpen()")
  elseif menutype == self._ENUM_SUBMENUTYPE._FOODFEED then
    control:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_EMPLOYEE_SHIP_FOODFEED"))
    control:addInputEvent("Mouse_LUp", "HandlerEventLUp_ServantList_All_ShipFoodFeed()")
  elseif menutype == self._ENUM_SUBMENUTYPE._ENDSWIFT then
    control:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WINDOW_STABLEFUNCTION_TRAINFINISH"))
    control:addInputEvent("Mouse_LUp", "HandleEventLUp_ServantList_All_TrainingFinish(true)")
  elseif menutype == self._ENUM_SUBMENUTYPE._UPGRADE then
    control:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SHIP_EXTEND"))
    control:addInputEvent("Mouse_LUp", "HandleEventLUp_ServantList_All_Upgrade()")
  elseif menutype == self._ENUM_SUBMENUTYPE._REPAIRUNSEALED then
    control:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTLISTALL_REPAIR"))
    if 0 == currentNPCType or 1 == currentNPCType then
      control:addInputEvent("Mouse_LUp", "HandleEventLUp_ServantList_All_Recovery_UnSealed_Servant()")
    elseif 2 == currentNPCType or 3 == currentNPCType then
      control:addInputEvent("Mouse_LUp", "HandleEventLUp_ServantList_All_RepairShip()")
    end
  elseif menutype == self._ENUM_SUBMENUTYPE._CARRIAGELINK then
    control:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WINDOW_STABLEFUNCTION_HORSELINK"))
    control:addInputEvent("Mouse_LUp", "PaGlobalFunc_ServantFunction_All_ChangeTab(1)")
  end
  if self._isImportantMenu then
    self._importantMenuCount = self._importantMenuCount + 1
  else
    self._subMenuCount = self._subMenuCount + 1
  end
  control:SetShow(true)
end
function PaGlobal_ServantList_All:setSnapTarget(idx)
  if false == self._isConsole then
    return
  end
  if true == Panel_Dialog_ServantCarriageLink_All:GetShow() then
    return
  end
  if 0 == idx then
    ToClient_padSnapSetTargetPanel(Panel_Dialog_ServantList_All)
  elseif 1 == idx then
    if nil ~= PaGlobal_ServantList_All._subMenuGroup and nil ~= PaGlobal_ServantList_All._subMenuGroup[0] and 0 < PaGlobal_ServantList_All._subMenuCount and true == PaGlobal_ServantList_All._subMenuGroup[0]:GetShow() then
      ToClient_padSnapChangeToTarget(PaGlobal_ServantList_All._subMenuGroup[0])
    end
  elseif 2 == idx then
    ToClient_padSnapChangeToTarget(PaGlobal_ServantList_All._ui._btn_WildHorse)
  end
end
function PaGlobal_ServantList_All:SetQuestionBtn()
  if true == self._isConsole then
    return
  end
  local currentNPCType = PaGlobalFunc_ServantFunction_All_Get_NpcType()
  if 2 == currentNPCType or 3 == currentNPCType then
    self._ui._btn_Question:addInputEvent("Mouse_LUp", "Panel_WebHelper_ShowToggle( \"PanelWindowWharfShop\" )")
    PaGlobal_Util_RegistHelpTooltipEvent(self._ui._btn_Question, "\"PanelWindowWharfShop\"")
  else
    self._ui._btn_Question:addInputEvent("Mouse_LUp", "Panel_WebHelper_ShowToggle( \"PanelWindowStableShop\" )")
    PaGlobal_Util_RegistHelpTooltipEvent(self._ui._btn_Question, "\"PanelWindowStableShop\"")
  end
end
function PaGlobal_ServantList_All:validate()
  if nil == Panel_Dialog_ServantList_All then
    return
  end
  self._ui._stc_TitleBar:isValidate()
  self._ui._txt_Title:isValidate()
  self._ui._txt_CurrentServantTitle:isValidate()
  self._ui._stc_CurrentServantBg:isValidate()
  self._ui._btn_CurrentServant:isValidate()
  self._ui._icon_CurrentServant:isValidate()
  self._ui._icon_CurrentServantGender:isValidate()
  self._ui._txt_CurrentServantName:isValidate()
  self._ui._txt_CurrentServantLocate:isValidate()
  self._ui._txt_CurrentServant_Tier:isValidate()
  self._ui._icon_CurrentServant_Swift:isValidate()
  self._ui._stc_NoServant:isValidate()
  self._ui._txt_ServantListTitle:isValidate()
  self._ui._txt_ServantListValue:isValidate()
  self._ui._list2_Servant:isValidate()
  self._ui._list2_ServantContent:isValidate()
  self._ui._list2_ServantButton:isValidate()
  self._ui._list2_ServantImage:isValidate()
  self._ui._list2_ServantGenderIcon:isValidate()
  self._ui._list2_ServantName:isValidate()
  self._ui._list2_ServantTier:isValidate()
  self._ui._list2_ServantState:isValidate()
  self._ui._list2_ServantSwiftHorseIcon:isValidate()
  self._ui._list2_Servant_VertiScroll:isValidate()
  self._ui._list2_Servant_VertiScroll_Up:isValidate()
  self._ui._list2_Servant_VertiScroll_Down:isValidate()
  self._ui._list2_Servant_VertiScroll_Ctrl:isValidate()
  self._ui._list2_Servant_HoriScroll:isValidate()
  self._ui._list2_Servant_HoriScroll_Up:isValidate()
  self._ui._list2_Servant_HoriScroll_Down:isValidate()
  self._ui._list2_Servant_HoriScroll_Ctrl:isValidate()
  self._ui._stc_StatusBg:isValidate()
  self._ui._txt_UnSealServant_CountTitle:isValidate()
  self._ui._txt_SealServant_CountTitle:isValidate()
  self._ui._txt_UnSealServant_CountValue:isValidate()
  self._ui._txt_SealServant_CountValue:isValidate()
  self._ui._btn_IncreaseSlot:isValidate()
  self._ui._btn_Regist:isValidate()
  self._ui._stc_MenuListBg:isValidate()
  self._ui._btn_Menu_Template:isValidate()
  self._ui._btn_WildHorseBg:isValidate()
  self._ui._btn_WildHorse:isValidate()
  self._ui._stc_WildHorseImage:isValidate()
  self._ui._txt_WildHorseDesc:isValidate()
  self._ui._txt_WildHorseTitle:isValidate()
  self._ui._stc_ConsoleKeyGuides:isValidate()
  self._ui._stc_KeyGuide_A:isValidate()
  self._ui._btn_Question:isValidate()
  self._initialize = true
end
