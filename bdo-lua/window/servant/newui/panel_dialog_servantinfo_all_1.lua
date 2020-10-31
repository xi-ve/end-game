function PaGlobal_ServantInfo_All:initialize()
  if nil == Panel_Dialog_ServantInfo_All or true == self.initialize then
    return
  end
  self._ui._stc_infoBg = UI.getChildControl(Panel_Dialog_ServantInfo_All, "Static_InfoBg")
  self._ui._txt_Name = UI.getChildControl(self._ui._stc_infoBg, "StaticText_ServantName")
  self._ui._icon_ServantGender = UI.getChildControl(self._ui._stc_infoBg, "Static_GenderIcon")
  self._ui._icon_SwiftHorse = UI.getChildControl(self._ui._stc_infoBg, "Static_SwiftHorseIcon")
  self._ui._txt_Tier = UI.getChildControl(self._ui._stc_infoBg, "StaticText_Tier")
  self._ui._stc_ExpBg = UI.getChildControl(self._ui._stc_infoBg, "Static_ExpBg")
  self._ui._txt_ExpTitle = UI.getChildControl(self._ui._stc_ExpBg, "StaticText_ExpTitle")
  self._ui._txt_ExpValue = UI.getChildControl(self._ui._stc_ExpBg, "StaticText_ExpValue")
  self._ui._stc_ExpProgressBg = UI.getChildControl(self._ui._stc_ExpBg, "Static_ExpProgressBg")
  self._ui._prog2_Exp = UI.getChildControl(self._ui._stc_ExpBg, "Progress2_Exp")
  self._ui._prog2_Exp_Head = UI.getChildControl(self._ui._prog2_Exp, "Progress2_1_Bar_Head")
  self._ui._stc_HpBg = UI.getChildControl(self._ui._stc_infoBg, "Static_LifeBg")
  self._ui._txt_HpTitle = UI.getChildControl(self._ui._stc_HpBg, "StaticText_HpTitle")
  self._ui._txt_HpValue = UI.getChildControl(self._ui._stc_HpBg, "StaticText_HpValue")
  self._ui._stc_HpProgressBg = UI.getChildControl(self._ui._stc_HpBg, "Static_HpProgressBg")
  self._ui._prog2_Hp = UI.getChildControl(self._ui._stc_HpBg, "Progress2_Hp")
  self._ui._prog2_Hp_Head = UI.getChildControl(self._ui._prog2_Hp, "Progress2_1_Bar_Head")
  self._ui._stc_StaminaBg = UI.getChildControl(self._ui._stc_infoBg, "Static_StaminaBg")
  self._ui._stc_StaminaProgressBg = UI.getChildControl(self._ui._stc_StaminaBg, "Static_StaminaProgressBg")
  self._ui._txt_StatminaTitle = UI.getChildControl(self._ui._stc_StaminaBg, "StaticText_StaminaTitle")
  self._ui._txt_StatminaValue = UI.getChildControl(self._ui._stc_StaminaBg, "StaticText_StaminaValue")
  self._ui._prog2_Stamina = UI.getChildControl(self._ui._stc_StaminaBg, "Progress2_Stamina")
  self._ui._prog2_Stamina_Head = UI.getChildControl(self._ui._prog2_Stamina, "Progress2_1_Bar_Head")
  self._ui._stc_WeightBg = UI.getChildControl(self._ui._stc_infoBg, "Static_WeightBg")
  self._ui._txt_WeightTitle = UI.getChildControl(self._ui._stc_WeightBg, "StaticText_WeightTitle")
  self._ui._txt_WeightValue = UI.getChildControl(self._ui._stc_WeightBg, "StaticText_WeightValue")
  self._ui._stc_WeightProgressBg = UI.getChildControl(self._ui._stc_WeightBg, "Static_WeightProgressBg")
  self._ui._prog2_Weight = UI.getChildControl(self._ui._stc_WeightBg, "Progress2_Weight")
  self._ui._prog2_Weight_Head = UI.getChildControl(self._ui._prog2_Weight, "Progress2_1_Bar_Head")
  self._ui._stc_StatBg = UI.getChildControl(self._ui._stc_infoBg, "Static_StatBg")
  self._ui._txt_SpeedTitle = UI.getChildControl(self._ui._stc_StatBg, "StaticText_SpeedTitle")
  self._ui._txt_SpeedValue = UI.getChildControl(self._ui._stc_StatBg, "StaticText_SpeedValue")
  self._ui._txt_CorneringTitle = UI.getChildControl(self._ui._stc_StatBg, "StaticText_CorneringSpeedTitle")
  self._ui._txt_CorneringValue = UI.getChildControl(self._ui._stc_StatBg, "StaticText_CorneringSpeedValue")
  self._ui._txt_AccelrationTitle = UI.getChildControl(self._ui._stc_StatBg, "StaticText_AccelerationTitle")
  self._ui._txt_AccelrationValue = UI.getChildControl(self._ui._stc_StatBg, "StaticText_AccelerationValue")
  self._ui._txt_BreakTitle = UI.getChildControl(self._ui._stc_StatBg, "StaticText_BreakTitle")
  self._ui._txt_BreakValue = UI.getChildControl(self._ui._stc_StatBg, "StaticText_BreakValue")
  self._ui._txt_DeadTitle = UI.getChildControl(self._ui._stc_StatBg, "StaticText_DeadCountTitle")
  self._ui._txt_DeadValue = UI.getChildControl(self._ui._stc_StatBg, "StaticText_DeadCountValue")
  self._ui._txt_MatingTitle = UI.getChildControl(self._ui._stc_StatBg, "StaticText_LeftMatingCountTitle")
  self._ui._txt_MatingValue = UI.getChildControl(self._ui._stc_StatBg, "StaticText_LeftMatingCountValue")
  self._ui._txt_LeftLifeTitle = UI.getChildControl(self._ui._stc_StatBg, "StaticText_LifeTitle")
  self._ui._txt_LeftLifeValue = UI.getChildControl(self._ui._stc_StatBg, "StaticText_LifeValue")
  self._ui._txt_ImprintTitle = UI.getChildControl(self._ui._stc_StatBg, "StaticText_ImprintTitle")
  self._ui._txt_ImprintValue = UI.getChildControl(self._ui._stc_StatBg, "StaticText_ImprintValue")
  self._ui._stc_StatusArea = UI.getChildControl(Panel_Dialog_ServantInfo_All, "Static_StatusArea")
  self._ui._txt_StatusTitle = UI.getChildControl(self._ui._stc_StatusArea, "StaticText_StatusTitle")
  self._ui._btn_Immediate = UI.getChildControl(self._ui._stc_StatusArea, "Button_Immediate")
  self._ui._btn_GetHorse = UI.getChildControl(self._ui._stc_StatusArea, "Button_GetHorse")
  self._ui._stc_SkillBg = UI.getChildControl(Panel_Dialog_ServantInfo_All, "Static_SkillBg")
  self._ui._txt_SkillBgTitle = UI.getChildControl(self._ui._stc_SkillBg, "StaticText_SkillTitle")
  self._ui._list2_Skill = UI.getChildControl(self._ui._stc_SkillBg, "List2_ServantSkill")
  self._ui._list2_Content = UI.getChildControl(self._ui._list2_Skill, "List2_1_Content")
  self._ui._list2_SkillSlotBg = UI.getChildControl(self._ui._list2_Content, "Static_SkillSlotBg")
  self._ui._list2_list2_ExpBg = UI.getChildControl(self._ui._list2_Content, "Static_SkillExpBg")
  self._ui._list2_Circle_Prog2_Exp = UI.getChildControl(self._ui._list2_Content, "CircularProgress_SkillExp")
  self._ui._list2_stc_SkillIcon = UI.getChildControl(self._ui._list2_Content, "Static_SkillIcon")
  self._ui._list2_txt_SkillExpPercent = UI.getChildControl(self._ui._list2_Content, "StaticText_SkillExpPercent")
  self._ui._list2_txt_SkillName = UI.getChildControl(self._ui._list2_Content, "StaticText_SkillName")
  self._ui._list2_txt_SkillCommand = UI.getChildControl(self._ui._list2_Content, "StaticText_SkillCommandValue")
  self._ui._list2_VertiScroll = UI.getChildControl(self._ui._list2_Skill, "List2_1_VerticalScroll")
  self._ui._list2_VertiScroll_Up = UI.getChildControl(self._ui._list2_VertiScroll, "List2_1_VerticalScroll_UpButton")
  self._ui._list2_VertiScroll_Down = UI.getChildControl(self._ui._list2_VertiScroll, "List2_1_VerticalScroll_DownButton")
  self._ui._list2_VertiScroll_Ctrl = UI.getChildControl(self._ui._list2_VertiScroll, "List2_1_VerticalScroll_CtrlButton")
  self._ui._list2_HoriScroll = UI.getChildControl(self._ui._list2_Skill, "List2_1_HorizontalScroll")
  self._ui._list2_HoriScroll_Up = UI.getChildControl(self._ui._list2_HoriScroll, "List2_1_HorizontalScroll_UpButton")
  self._ui._list2_HoriScroll_Down = UI.getChildControl(self._ui._list2_HoriScroll, "List2_1_HorizontalScroll_DownButton")
  self._ui._list2_HoriScroll_Ctrl = UI.getChildControl(self._ui._list2_HoriScroll, "List2_1_HorizontalScroll_CtrlButton")
  self._ui._btn_SkillManagerBg = UI.getChildControl(self._ui._stc_SkillBg, "Button_SkillManagementBG")
  self._ui._btn_SkillManager = UI.getChildControl(self._ui._btn_SkillManagerBg, "Button_SkillManagement")
  self._ui._stc_ConsoleHighlight = UI.getChildControl(Panel_Dialog_ServantInfo_All, "Static_consoleBox")
  self._OriginSkillBgSizeY = self._ui._stc_SkillBg:GetSizeY()
  self._OriginSkillBgPosY = self._ui._stc_SkillBg:GetSpanSize().y
  self._OriginList2SizeY = self._ui._list2_Skill:GetSizeY()
  self._OriginPanelSizeY = Panel_Dialog_ServantInfo_All:GetSizeY()
  self._OriginList2PosY = self._ui._list2_Skill:GetPosY()
  self._ui._stc_ConsoleHighlight:SetShow(_ContentsGroup_UsePadSnapping)
  self._isConsole = _ContentsGroup_UsePadSnapping
  PaGlobal_ServantInfo_All:validate()
  PaGlobal_ServantInfo_All:registerEventHandler(self._isConsole)
end
function PaGlobal_ServantInfo_All:registerEventHandler(isConsole)
  if nil == Panel_Dialog_ServantInfo_All or false == self._initialize then
    return
  end
  self._ui._list2_Skill:registEvent(__ePAUIList2EventType_LuaChangeContent, "FromClient_ServantInfo_All_List2ServantSkill")
  self._ui._list2_Skill:createChildContent(__ePAUIList2ElementManagerType_List)
  registerEvent("onScreenResize", "FromClient_ServantInfo_All_OnScreenSize")
  self._ui._btn_SkillManager:addInputEvent("Mouse_LUp", "HandleEventLUp_ServantInfo_All_SkillChangeOpen()")
  self._ui._btn_Immediate:addInputEvent("Mouse_LUp", "HandleEventLUp_ServantInfo_All_MatingCompleteImmediately()")
  if false == isConsole then
    self._ui._list2_Skill:addInputEvent("Mouse_UpScroll", "HandleEventScroll_ServantInfo_All_saveScrollPos()")
    self._ui._list2_Skill:addInputEvent("Mouse_DownScroll", "HandleEventScroll_ServantInfo_All_saveScrollPos()")
    self._ui._list2_Skill:addInputEvent("Mouse_LUp", "HandleEventScroll_ServantInfo_All_saveScrollPos()")
  else
    Panel_Dialog_ServantInfo_All:registerPadEvent(__eConsoleUIPadEvent_LB, "HandleEventPadPress_ServantFunction_All_ChangeTab(false)")
    Panel_Dialog_ServantInfo_All:registerPadEvent(__eConsoleUIPadEvent_RB, "HandleEventPadPress_ServantFunction_All_ChangeTab(true)")
  end
  registerEvent("FromClient_SetBeginningLevelServant", "FromClient_ServantInfo_All_SetBeginningLevelServant")
  registerEvent("FromClient_updateFood", "PaGlobalFunc_ServantInfo_All_Update")
  registerEvent("FromClient_updateServantSupply", "PaGlobalFunc_ServantInfo_All_Update")
  if true == _ContentsGroup_Sailor then
    registerEvent("FromClient_EmployeeUpdateAck", "PaGlobalFunc_ServantInfo_All_Update")
    registerEvent("FromClient_EmployeeDeleteAck", "PaGlobalFunc_ServantInfo_All_Update")
  end
  registerEvent("FromClient_ServantInventoryUpdate", "PaGlobalFunc_ServantInfo_All_Update")
  registerEvent("EventServantEquipItem", "PaGlobalFunc_ServantInfo_All_Update")
  registerEvent("EventServantEquipmentUpdate", "PaGlobalFunc_ServantInfo_All_Update")
  registerEvent("EventSelfServantUpdate", "PaGlobalFunc_ServantInfo_All_Update")
  registerEvent("FromClient_ClearGuildServantDeadCount", "FromClient_ClearGuildServantDeadCount")
  registerEvent("FromClient_ServantChangeSkill", "FromClient_ServantInfo_All_SkillChangeFinish")
  registerEvent("FromClient_ForgetServantSkill", "FromClient_ServantInfo_All_ForgetServantSkill")
  Panel_Dialog_ServantInfo_All:RegisterShowEventFunc(true, "PaGlobalFunc_ServantInfo_All_ShowAni()")
  Panel_Dialog_ServantInfo_All:RegisterShowEventFunc(false, "PaGlobalFunc_ServantInfo_All_HideAni()")
  Panel_Dialog_ServantInfo_All:setMaskingChild(true)
  Panel_Dialog_ServantInfo_All:ActiveMouseEventEffect(true)
end
function PaGlobal_ServantInfo_All:prepareOpen()
  if nil == Panel_Dialog_ServantInfo_All then
    return
  end
  PaGlobal_ServantInfo_All:open()
  FromClient_ServantInfo_All_OnScreenSize()
  PaGlobal_ServantInfo_All:update()
end
function PaGlobal_ServantInfo_All:open()
  if nil == Panel_Dialog_ServantInfo_All or true == Panel_Dialog_ServantInfo_All:GetShow() then
    return
  end
  Panel_Dialog_ServantInfo_All:SetShow(true)
end
function PaGlobal_ServantInfo_All:update()
  if nil == Panel_Dialog_ServantInfo_All or nil == self._currentNpcType then
    return
  end
  if self._currentNpcType == self._ENUM_NPC_TYPE._LAND or self._currentNpcType == self._ENUM_NPC_TYPE._GUILD_LAND then
    PaGlobal_ServantInfo_All:updateLandVehicle()
  elseif self._currentNpcType == self._ENUM_NPC_TYPE._SEA or self._currentNpcType == self._ENUM_NPC_TYPE._GUILD_SEA then
    PaGlobal_ServantInfo_All:updateSeaVehicle()
  end
end
function PaGlobal_ServantInfo_All:updateLandVehicle()
  if nil == Panel_Dialog_ServantInfo_All or -1 == self._currentSlotType then
    return
  end
  local servantInfo
  local isImprintAble = false
  local isUnSealed = false
  local isGuild = PaGlobalFunc_ServantFunction_All_GetIsGuild()
  self._statCount = 1
  if nil == self._currentVehicleIndexNo then
    self._currentSlotType = 1
  end
  if 0 == self._currentSlotType then
    servantInfo = stable_getServant(self._currentVehicleIndexNo)
  elseif 1 == self._currentSlotType then
    local temporaryWrapper = getTemporaryInformationWrapper()
    if nil == temporaryWrapper then
      return
    end
    servantInfo = temporaryWrapper:getUnsealVehicle(stable_getServantType())
    isUnSealed = true
  elseif 2 == self._currentSlotType then
  end
  if true == isGuild then
    servantInfo = guildStable_getServant(self._currentVehicleIndexNo)
    self._currentSlotType = 0
  end
  if nil == servantInfo then
    PaGlobal_ServantInfo_All:close()
    return
  end
  PaGlobal_ServantInfo_All:switchVehicleInfo(isGuild)
  self._currentServantInfo = servantInfo
  self._currentVehicleNo = servantInfo:getServantNo()
  local myservantinfo = stable_getServantByServantNo(servantInfo:getServantNo())
  local hasRentOwnerFlag = false
  if nil ~= myservantinfo then
    hasRentOwnerFlag = Defines.s64_const.s64_0 < myservantinfo:getRentOwnerNo()
  end
  self._ui._btn_SkillManagerBg:SetShow(false)
  self._ui._btn_SkillManager:SetShow(false)
  self._ui._txt_Tier:SetShow(false)
  local servantType = servantInfo:getVehicleType()
  local servantTier = servantInfo:getTier()
  local regionInfo = getRegionInfoByPosition(getSelfPlayer():get():getPosition())
  local regionName = regionInfo:getAreaName()
  local servantRegionName = servantInfo:getRegionName()
  local servantState = servantInfo:getStateType()
  local isMatingComplete = servantInfo:isMatingComplete()
  local isChangingRegion = servantInfo:isChangingRegion()
  local isPcroomOnly = servantInfo:isPcroomOnly()
  local characterKeyRaw = servantInfo:getCharacterKeyRaw()
  if servantType == CppEnums.VehicleType.Type_Horse or servantType == CppEnums.VehicleType.Type_Camel or servantType == CppEnums.VehicleType.Type_RidableBabyElephant or 9113 == characterKeyRaw or 9114 == characterKeyRaw or 9115 == characterKeyRaw then
    self._ui._txt_Tier:SetShow(true)
    if 9 == servantTier then
      self._ui._txt_Tier:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_SERVANT_TEXT_TIER9"))
    elseif 0 ~= servantTier then
      self._ui._txt_Tier:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_SERVANT_TIER", "tier", tostring(servantTier)))
    else
      self._ui._txt_Tier:SetShow(false)
    end
    if regionName == servantRegionName and false == servantInfo:isSeized() and CppEnums.ServantStateType.Type_RegisterMarket ~= servantState and CppEnums.ServantStateType.Type_RegisterMating ~= servantState and CppEnums.ServantStateType.Type_Mating ~= servantState and CppEnums.ServantStateType.Type_Coma ~= servantState and CppEnums.ServantStateType.Type_SkillTraining ~= servantState and false == isMatingComplete and false == isChangingRegion and false == hasRentOwnerFlag and false == isPcroomOnly then
      self._ui._btn_SkillManagerBg:SetShow(true)
      self._ui._btn_SkillManager:SetShow(true)
    end
  elseif true == servantInfo:doHaveVehicleSkill() and false == isGuild then
    self._ui._btn_SkillManagerBg:SetShow(true)
    self._ui._btn_SkillManager:SetShow(true)
  end
  self._ui._icon_SwiftHorse:SetShow(false)
  self._ui._icon_SwiftHorse:SetMonoTone(true, true)
  if servantType == CppEnums.VehicleType.Type_Horse and 9 ~= servantTier and false == isPcroomOnly and self._isContentsStallionEnable then
    local isStallion = servantInfo:isStallion()
    self._ui._icon_SwiftHorse:SetShow(true)
    if true == isStallion then
      self._ui._icon_SwiftHorse:SetMonoTone(false, false)
    else
      self._ui._icon_SwiftHorse:SetMonoTone(true, false)
    end
  end
  local servantName = ""
  if true == isGuild then
    servantName = servantInfo:getName()
  else
    servantName = PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_LV") .. "." .. tostring(servantInfo:getLevel()) .. " " .. servantInfo:getName()
  end
  self._ui._txt_Name:SetText(servantName)
  local curHp = servantInfo:getHp()
  local maxHp = servantInfo:getMaxHp()
  local curStamina = servantInfo:getMp()
  local maxStamina = servantInfo:getMaxMp()
  self._ui._txt_HpValue:SetText(makeDotMoney(curHp) .. " / " .. makeDotMoney(maxHp))
  self._ui._txt_StatminaValue:SetText(makeDotMoney(curStamina) .. " / " .. makeDotMoney(maxStamina))
  self._ui._prog2_Hp:SetProgressRate(curHp / maxHp * 100)
  self._ui._prog2_Stamina:SetProgressRate(curStamina / maxStamina * 100)
  local max_weight_s64 = servantInfo:getMaxWeight_s64()
  local max_weight = Int64toInt32(max_weight_s64 / Defines.s64_const.s64_10000)
  self._ui._prog2_Weight:SetProgressRate(0)
  self._ui._txt_WeightTitle:SetText(PAGetString(Defines.StringSheet_RESOURCE, "STABLE_INFO_TEXT_WEIGHT"))
  self._ui._txt_WeightValue:SetText(makeDotMoney(max_weight) .. PAGetString(Defines.StringSheet_RESOURCE, "TRADEMARKET_STD_TXT_LT"))
  self._ui._stc_WeightProgressBg:SetShow(false)
  self._ui._prog2_Weight:SetShow(false)
  if true == isUnSealed then
    local actorKeyRaw = servantInfo:getActorKeyRaw()
    local vehicleActorWrapper = getVehicleActor(actorKeyRaw)
    if nil ~= vehicleActorWrapper then
      local vehicleActor = vehicleActorWrapper:get()
      local possessableWeight_s64 = vehicleActor:getPossessableWeight_s64()
      local total_weight_s64 = vehicleActor:getCurrentWeight_s64()
      max_weight = possessableWeight_s64 / Defines.s64_const.s64_100
      local weightPercent = Int64toInt32(total_weight_s64 / max_weight)
      self._ui._txt_WeightValue:SetText(makeWeightString(total_weight_s64, 1) .. " / " .. makeWeightString(possessableWeight_s64, 0) .. PAGetString(Defines.StringSheet_RESOURCE, "TRADEMARKET_STD_TXT_LT"))
      self._ui._stc_WeightProgressBg:SetShow(true)
      self._ui._prog2_Weight:SetShow(true)
      self._ui._prog2_Weight:SetProgressRate(weightPercent)
    end
  else
    self._ui._txt_WeightValue:SetText(makeWeightString(max_weight_s64, 0) .. PAGetString(Defines.StringSheet_RESOURCE, "TRADEMARKET_STD_TXT_LT"))
  end
  self._ui._txt_SpeedValue:SetText(string.format("%.1f", servantInfo:getStat(CppEnums.ServantStatType.Type_MaxMoveSpeed) / 10000) .. "%")
  self._ui._txt_AccelrationValue:SetText(string.format("%.1f", servantInfo:getStat(CppEnums.ServantStatType.Type_Acceleration) / 10000) .. "%")
  self._ui._txt_CorneringValue:SetText(string.format("%.1f", servantInfo:getStat(CppEnums.ServantStatType.Type_CorneringSpeed) / 10000) .. "%")
  self._ui._txt_BreakValue:SetText(string.format("%.1f", servantInfo:getStat(CppEnums.ServantStatType.Type_BrakeSpeed) / 10000) .. "%")
  local deadCount = servantInfo:getDeadCount()
  if true == isGuild then
    if servantType == CppEnums.VehicleType.Type_Elephant then
      self._ui._txt_DeadTitle:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_GUILDSERVANTINFO_INJURY"))
      self._ui._txt_DeadValue:SetText(deadCount * 10 .. "%")
    else
      self._ui._txt_DeadTitle:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_STABLEINFO_DESTROYCOUNT"))
      self._ui._txt_DeadValue:SetText(deadCount)
    end
  else
    self._ui._prog2_Exp:SetShow(true)
    local s64_exp = servantInfo:getExp_s64()
    local s64_needexp = servantInfo:getNeedExp_s64()
    local s64_exp_percent = Defines.s64_const.s64_0
    self._ui._txt_ExpValue:SetText(makeDotMoney(s64_exp) .. " / " .. makeDotMoney(s64_needexp))
    if s64_exp > Defines.s64_const.s64_0 then
      self._ui._prog2_Exp:SetProgressRate(Int64toInt32(s64_exp) / Int64toInt32(s64_needexp) * 100)
    else
      self._ui._prog2_Exp:SetProgressRate(0)
    end
    if servantType == CppEnums.VehicleType.Type_Horse or servantType == CppEnums.VehicleType.Type_Camel or servantType == CppEnums.VehicleType.Type_Donkey or servantType == CppEnums.VehicleType.Type_Elephant then
      self._ui._txt_DeadTitle:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_STABLEINFO_KILLCOUNT"))
    elseif servantType == CppEnums.VehicleType.Type_Carriage or servantType == CppEnums.VehicleType.Type_CowCarriage or servantType == CppEnums.VehicleType.Type_RepairableCarriage then
      self._ui._txt_DeadTitle:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_STABLEINFO_DESTROYCOUNT"))
    end
    if true == servantInfo:doClearCountByDead() then
      deadCount = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_STABLEINFO_RESETOK", "deadCount", deadCount)
    else
      deadCount = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_STABLEINFO_RESETNO", "deadCount", deadCount)
    end
    self._ui._txt_DeadValue:SetText(deadCount)
  end
  PaGlobal_ServantInfo_All:uiReposition(self._ui._txt_DeadTitle, self._ui._txt_DeadValue)
  self._ui._txt_MatingTitle:SetShow(false)
  self._ui._txt_MatingValue:SetShow(false)
  PaGlobal_ServantInfo_All:SetTimerShow(false)
  if true == servantInfo:doMating() and 9 ~= servantTier then
    local matingCount = servantInfo:getMatingCount()
    if servantInfo:doClearCountByMating() then
      matingCount = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_STABLEINFO_RESETOK", "deadCount", matingCount)
    else
      matingCount = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_STABLEINFO_RESETNO", "deadCount", matingCount)
    end
    self._ui._txt_MatingValue:SetText(matingCount)
    self._ui._txt_MatingValue:SetShow(true)
    self._ui._txt_MatingTitle:SetShow(true)
    PaGlobal_ServantInfo_All:uiReposition(self._ui._txt_MatingTitle, self._ui._txt_MatingValue)
    if CppEnums.ServantStateType.Type_Mating == servantState and not isMatingComplete then
      PaGlobal_ServantInfo_All:SetTimerShow(true, 1, PAGetString(Defines.StringSheet_RESOURCE, "PANEL_STABLE_INFO_MATINGTIME") .. " " .. convertStringFromDatetime(servantInfo:getMatingTime()), servantInfo)
    end
  end
  self._ui._txt_LeftLifeValue:SetShow(true)
  self._ui._txt_LeftLifeTitle:SetShow(true)
  if true == servantInfo:isPeriodLimit() then
    self._ui._txt_LeftLifeValue:SetText(convertStringFromDatetime(servantInfo:getExpiredTime()))
  else
    self._ui._txt_LeftLifeValue:SetText(PAGetString(Defines.StringSheet_RESOURCE, "STABLE_INFO_TEXT_LIFEVALUE"))
  end
  PaGlobal_ServantInfo_All:uiReposition(self._ui._txt_LeftLifeTitle, self._ui._txt_LeftLifeValue)
  if servantType == CppEnums.VehicleType.Type_Carriage or servantType == CppEnums.VehicleType.Type_CowCarriage then
    self._ui._txt_HpTitle:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTINFO_DURABILITY"))
    self._ui._txt_StatminaTitle:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTINFO_LIFE"))
    self._ui._txt_LeftLifeTitle:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTINFO_PERIOD"))
  elseif servantType == CppEnums.VehicleType.Type_RepairableCarriage then
    self._ui._txt_HpTitle:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTINFO_DURABILITY"))
    self._ui._txt_StatminaTitle:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SERVANT_SHIPINFO_MP"))
  else
    self._ui._txt_HpTitle:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_HORSEHP_TOOLTIP_HORSEHP_NAME"))
    self._ui._txt_StatminaTitle:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTINFO_STAMINA"))
  end
  if true == isGuild then
    self._ui._txt_StatminaTitle:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTINFO_STAMINA"))
  end
  self._ui._icon_ServantGender:SetShow(false)
  if servantType == CppEnums.VehicleType.Type_Horse then
    self._ui._icon_ServantGender:SetShow(true)
    self._ui._icon_ServantGender:ChangeTextureInfoName("combine/etc/combine_etc_stable.dds")
    local x1, y1, x2, y2 = 0, 0, 0, 0
    if true == servantInfo:isMale() then
      x1, y1, x2, y2 = setTextureUV_Func(self._ui._icon_ServantGender, 1, 209, 31, 239)
    else
      x1, y1, x2, y2 = setTextureUV_Func(self._ui._icon_ServantGender, 1, 178, 31, 208)
    end
    self._ui._icon_ServantGender:getBaseTexture():setUV(x1, y1, x2, y2)
    self._ui._icon_ServantGender:setRenderTexture(self._ui._icon_ServantGender:getBaseTexture())
  end
  local remainSecondsToUneal = servantInfo:getRemainSecondsToUnseal()
  if true == isChangingRegion then
    PaGlobal_ServantInfo_All:SetTimerShow(true, 0, PAGetString(Defines.StringSheet_RESOURCE, "PANEL_STABLE_INFO_REGION_CHANGING_TIME") .. " " .. convertStringFromDatetime(remainSecondsToUneal), servantInfo)
  elseif servantState == CppEnums.ServantStateType.Type_SkillTraining and false == stable_isSkillExpTrainingComplete(self._currentVehicleNo) then
    PaGlobal_ServantInfo_All:SetTimerShow(true, 0, PAGetString(Defines.StringSheet_RESOURCE, "PANEL_STABLELIST_TRAININGTIME") .. " " .. convertStringFromDatetime(servantInfo:getSkillTrainingTime()), servantInfo)
  end
  self._ui._txt_ImprintTitle:SetShow(false)
  self._ui._txt_ImprintValue:SetShow(false)
  if true == servantInfo:isImprint() then
    isImprintAble = true
    self._ui._txt_ImprintValue:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_STABLEINFO_ISIMPRINTING"))
  elseif servantType == CppEnums.VehicleType.Type_Horse or servantType == CppEnums.VehicleType.Type_Camel or servantType == CppEnums.VehicleType.Type_Donkey or servantType == CppEnums.VehicleType.Type_Elephant or servantType == CppEnums.VehicleType.Type_RidableBabyElephant then
    isImprintAble = true
    self._ui._txt_ImprintValue:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_STABLEINFO_ISIMPRINTPOSSIBLE"))
  end
  if true == isImprintAble then
    self._ui._txt_ImprintTitle:SetShow(true)
    self._ui._txt_ImprintValue:SetShow(true)
    PaGlobal_ServantInfo_All:uiReposition(self._ui._txt_ImprintTitle, self._ui._txt_ImprintValue)
  end
  local statBgSizeY = 20 + (self._ui._txt_SpeedTitle:GetSizeY() + 10) * (self._statCount + 1)
  local infoBgSizeY = statBgSizeY + (self._ui._stc_HpBg:GetSizeY() + 15) * 4 + self._ui._txt_Tier:GetSizeY() + self._ui._txt_Name:GetSizeY() + 50
  self._ui._stc_StatBg:SetSize(self._ui._stc_StatBg:GetSizeX(), statBgSizeY)
  self._ui._stc_infoBg:SetSize(self._ui._stc_infoBg:GetSizeX(), infoBgSizeY)
  self._ui._stc_StatusArea:SetPosY(self._ui._stc_infoBg:GetPosY() + self._ui._stc_infoBg:GetSizeY())
  if 2 ~= self._currentVehicleNo then
    PaGlobal_ServantInfo_All:skillUpdate()
  end
end
function PaGlobal_ServantInfo_All:updateSeaVehicle()
  if nil == Panel_Dialog_ServantInfo_All then
    return
  end
  local isUnSealed = false
  local servantInfo
  self._statCount = 1
  if nil == self._currentVehicleIndexNo then
    self._currentSlotType = 1
  end
  if 0 == self._currentSlotType then
    if true == PaGlobalFunc_ServantFunction_All_GetIsGuild() then
      servantInfo = guildStable_getServant(self._currentVehicleIndexNo)
    else
      servantInfo = stable_getServant(self._currentVehicleIndexNo)
    end
  elseif 1 == self._currentSlotType and false == PaGlobalFunc_ServantFunction_All_GetIsGuild() then
    local temporaryWrapper = getTemporaryInformationWrapper()
    if nil == temporaryWrapper then
      return
    end
    servantInfo = temporaryWrapper:getUnsealVehicle(stable_getServantType())
    isUnSealed = true
  end
  if true == PaGlobalFunc_ServantFunction_All_GetIsGuild() and true == _ContentsGroup_OceanCurrent then
    local servantInfoByActor
    if nil ~= servantInfo then
      servantInfoByActor = getServantInfoFromActorKey(servantInfo:getActorKeyRaw())
    end
    if nil ~= servantInfoByActor then
      servantInfo = servantInfoByActor
    end
  end
  if nil == servantInfo then
    return
  end
  local actorKeyRaw = servantInfo:getActorKeyRaw()
  local vehicleActorWrapper = getVehicleActor(actorKeyRaw)
  self._currentServantInfo = servantInfo
  self._currentVehicleNo = servantInfo:getServantNo()
  PaGlobal_ServantInfo_All:switchVehicleInfo(true)
  local servantName = servantInfo:getName()
  self._ui._txt_Name:SetText(servantName)
  self._ui._txt_Tier:SetShow(false)
  if CppEnums.ServantType.Type_Ship == stable_getServantType() then
    local shipTypeStr = servantInfo:getDisplayName()
    if nil == shipTypeStr then
      shipTypeStr = ""
    else
      self._ui._txt_Tier:SetShow(true)
      self._ui._txt_Tier:SetText(shipTypeStr)
    end
  end
  local curHp = servantInfo:getHp()
  local maxHp = servantInfo:getMaxHp()
  local curStamina = getMpToServantInfo(servantInfo)
  local maxStamina = getMaxMpToServantInfo(servantInfo)
  self._ui._txt_HpTitle:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTINFO_DURABILITY"))
  self._ui._txt_HpValue:SetText(makeDotMoney(curHp) .. " / " .. makeDotMoney(maxHp))
  self._ui._txt_StatminaValue:SetText(makeDotMoney(curStamina) .. " / " .. makeDotMoney(maxStamina))
  self._ui._prog2_Hp:SetProgressRate(curHp / maxHp * 100)
  self._ui._prog2_Stamina:SetProgressRate(curStamina / maxStamina * 100)
  local max_weight_s64 = servantInfo:getMaxWeight_s64()
  local max_weight = Int64toInt32(max_weight_s64 / Defines.s64_const.s64_10000)
  self._ui._prog2_Weight:SetProgressRate(0)
  self._ui._stc_WeightProgressBg:SetShow(false)
  self._ui._prog2_Weight:SetShow(false)
  if false == isUnSealed then
    self._ui._txt_WeightValue:SetText(makeWeightString(max_weight_s64, 0) .. PAGetString(Defines.StringSheet_RESOURCE, "TRADEMARKET_STD_TXT_LT"))
  elseif nil ~= servantInfo then
    local currentWeight = servantInfo:getInventoryWeight_s64() + servantInfo:getEquipWeight_s64() + servantInfo:getMoneyWeight_s64()
    if nil ~= vehicleActorWrapper then
      local vehicleActor = vehicleActorWrapper:get()
      if nil ~= vehicleActor then
        currentWeight = vehicleActor:getCurrentWeight_s64()
      end
    end
    local total_weight = Int64toInt32(currentWeight / Defines.s64_const.s64_10000)
    local weightPercent = total_weight / max_weight * 100
    self._ui._txt_WeightValue:SetText(makeWeightString(currentWeight, 1) .. " / " .. makeWeightString(max_weight_s64, 0) .. PAGetString(Defines.StringSheet_RESOURCE, "TRADEMARKET_STD_TXT_LT"))
    self._ui._stc_WeightProgressBg:SetShow(true)
    self._ui._prog2_Weight:SetShow(true)
    self._ui._prog2_Weight:SetProgressRate(weightPercent)
  end
  local speed = servantInfo:getStat(CppEnums.ServantStatType.Type_MaxMoveSpeed)
  local accel = servantInfo:getStat(CppEnums.ServantStatType.Type_Acceleration)
  local cornering = servantInfo:getStat(CppEnums.ServantStatType.Type_CorneringSpeed)
  local braking = servantInfo:getStat(CppEnums.ServantStatType.Type_BrakeSpeed)
  if true == _ContentsGroup_Sailor and nil ~= vehicleActorWrapper then
    speed = speed + vehicleActorWrapper:getEmployeeStats(__eEmployeeAbility_Servant_Speed)
    accel = accel + vehicleActorWrapper:getEmployeeStats(__eEmployeeAbility_Servant_Acceleration)
    cornering = cornering + vehicleActorWrapper:getEmployeeStats(__eEmployeeAbility_Servant_Cornering)
    braking = braking + vehicleActorWrapper:getEmployeeStats(__eEmployeeAbility_Servant_Brake)
  end
  self._ui._txt_SpeedValue:SetText(string.format("%.1f", speed / 10000) .. "%")
  self._ui._txt_AccelrationValue:SetText(string.format("%.1f", accel / 10000) .. "%")
  self._ui._txt_CorneringValue:SetText(string.format("%.1f", cornering / 10000) .. "%")
  self._ui._txt_BreakValue:SetText(string.format("%.1f", braking / 10000) .. "%")
  if true == _ContentsGroup_OceanCurrent then
    local characterKey = servantInfo:getCharacterKeyRaw()
    local shipStaticStatus = ToClient_EmployeeCharacterShipStaticStatusWrapper(characterKey)
    if nil ~= shipStaticStatus and false == shipStaticStatus:getIsSummonFull() then
      self._ui._txt_StatminaTitle:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_HORSEHP_TOOLTIP_FOOD_NAME"))
    else
      self._ui._txt_StatminaTitle:SetText(PAGetString(Defines.StringSheet_RESOURCE, "STABLE_INFO_TEXT_HEART"))
    end
  else
    local vehicleType = servantInfo:getVehicleType()
    if CppEnums.VehicleType.Type_PersonTradeShip == vehicleType or CppEnums.VehicleType.Type_SailingBoat == vehicleType or CppEnums.VehicleType.Type_PersonalBattleShip == vehicleType or CppEnums.VehicleType.Type_CashPersonalTradeShip == vehicleType or CppEnums.VehicleType.Type_CashPersonalBattleShip == vehicleType then
      self._ui._txt_StatminaTitle:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SERVANT_SHIPINFO_MP"))
    else
      self._ui._txt_StatminaTitle:SetText(PAGetString(Defines.StringSheet_RESOURCE, "STABLE_INFO_TEXT_HEART"))
    end
  end
  PaGlobal_ServantInfo_All:SetTimerShow(false)
  if true == isChangingRegion then
    local remainSecondsToUneal = servantInfo:getRemainSecondsToUnseal()
    PaGlobal_ServantInfo_All:SetTimerShow(true, 0, PAGetString(Defines.StringSheet_RESOURCE, "PANEL_STABLE_INFO_REGION_CHANGING_TIME") .. " " .. convertStringFromDatetime(remainSecondsToUneal), servantInfo)
  end
  local deadCount = servantInfo:getDeadCount()
  local deadTitleStr = PAGetString(Defines.StringSheet_GAME, "LUA_STABLEINFO_DESTROYCOUNT")
  if true == _ContentsGroup_OceanCurrent and true == servantInfo:getIsDamageShip() then
    deadCount = deadCount / ToClinet_GetServantMaxDeadCount() * 100 .. "%"
    deadTitleStr = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SHIPINFO_WOUNDEDPERCENT")
  else
  end
  if servantInfo:doClearCountByDead() then
    deadCount = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_STABLEINFO_RESETOK", "deadCount", deadCount)
  else
    deadCount = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_STABLEINFO_RESETNO", "deadCount", deadCount)
  end
  self._ui._txt_DeadTitle:SetText(deadTitleStr)
  self._ui._txt_DeadValue:SetText(deadCount)
  PaGlobal_ServantInfo_All:uiReposition(self._ui._txt_DeadTitle, self._ui._txt_DeadValue)
  local statBgSizeY = 20 + (self._ui._txt_SpeedTitle:GetSizeY() + 10) * (self._statCount + 1)
  local infoBgSizeY = statBgSizeY + (self._ui._stc_HpBg:GetSizeY() + 15) * 3 + self._ui._txt_Tier:GetSizeY() + self._ui._txt_Name:GetSizeY() + 50
  self._ui._stc_StatBg:SetSize(self._ui._stc_StatBg:GetSizeX(), statBgSizeY)
  self._ui._stc_infoBg:SetSize(self._ui._stc_infoBg:GetSizeX(), infoBgSizeY)
  self._ui._stc_StatusArea:SetPosY(self._ui._stc_infoBg:GetPosY() + self._ui._stc_infoBg:GetSizeY())
  PaGlobal_ServantInfo_All:skillUpdate()
end
function PaGlobal_ServantInfo_All:uiReposition(titleControl, valueControl)
  if nil == titleControl or nil == valueControl then
    return
  end
  titleControl:SetSpanSize(titleControl:GetSpanSize().x, self._ui._txt_AccelrationValue:GetSpanSize().y + self._ADDPOSY * self._statCount)
  valueControl:SetSpanSize(titleControl:GetSpanSize().x, self._ui._txt_AccelrationValue:GetSpanSize().y + self._ADDPOSY * self._statCount)
  self._statCount = self._statCount + 1
end
function PaGlobal_ServantInfo_All:skillUpdate()
  if nil == self._currentSlotType or nil == self._currentVehicleNo then
    return
  end
  local servantInfo
  if 0 == self._currentSlotType then
    if true == PaGlobalFunc_ServantFunction_All_GetIsGuild() then
      servantInfo = guildStable_getServant(self._currentVehicleIndexNo)
    else
      servantInfo = stable_getServant(self._currentVehicleIndexNo)
    end
  elseif 1 == self._currentSlotType then
    local temporaryWrapper = getTemporaryInformationWrapper()
    if nil == temporaryWrapper then
      return
    end
    servantInfo = temporaryWrapper:getUnsealVehicle(stable_getServantType())
    isUnSealed = true
  end
  if nil == servantInfo then
    return
  end
  if 1 == self._currentSlotType and true == self._ui._btn_SkillManagerBg:GetShow() then
    self._ui._btn_SkillManagerBg:SetShow(false)
    self._ui._btn_SkillManager:SetShow(false)
  end
  local skillCount = 0
  self._ui._stc_SkillBg:SetSize(self._ui._stc_SkillBg:GetSizeX(), self._OriginSkillBgSizeY)
  self._ui._list2_Skill:SetSize(self._ui._list2_Skill:GetSizeX(), self._OriginList2SizeY)
  Panel_Dialog_ServantInfo_All:SetSize(Panel_Dialog_ServantInfo_All:GetSizeX(), self._OriginPanelSizeY)
  if false == servantInfo:doHaveVehicleSkill() then
    Panel_Dialog_ServantInfo_All:SetSize(Panel_Dialog_ServantInfo_All:GetSizeX(), self._ui._stc_infoBg:GetSizeY())
    self._ui._stc_SkillBg:SetShow(false)
    if true == self._isConsole then
      self._ui._stc_ConsoleHighlight:SetSize(Panel_Dialog_ServantInfo_All:GetSizeX() + 1, Panel_Dialog_ServantInfo_All:GetSizeY() + 1)
    end
    return
  else
    self._ui._stc_SkillBg:SetShow(true)
    skillCount = servantInfo:getSortedSkillCountForDisplay()
  end
  local addSpanY = 0
  if true == self._ui._stc_StatusArea:GetShow() then
    addSpanY = self._ui._stc_StatusArea:GetSizeY()
  end
  if self._currentNpcType == self._ENUM_NPC_TYPE._SEA or self._currentNpcType == self._ENUM_NPC_TYPE._GUILD_SEA then
    local spanY = self._ui._stc_StatBg:GetSpanSize().y + self._ui._txt_SpeedTitle:GetSpanSize().y + self._ADDPOSY + 10 + addSpanY
    self._ui._stc_SkillBg:SetSpanSize(self._ui._stc_SkillBg:GetSpanSize().x, spanY)
  else
    local spanY = self._ui._stc_StatBg:GetSpanSize().y + (self._ui._txt_AccelrationValue:GetSpanSize().y + self._statCount * self._ADDPOSY) + addSpanY
    self._ui._stc_SkillBg:SetSpanSize(self._ui._stc_SkillBg:GetSpanSize().x, spanY)
  end
  self._ui._list2_Skill:ComputePos()
  self._skillIdxTable = {}
  self._ui._list2_Skill:getElementManager():clearKey()
  local uiCount = 0
  for skillIdx = 0, skillCount - 1 do
    skillWrapper = servantInfo:getSortedSkillForDisplay(skillIdx)
    if nil ~= skillWrapper and false == skillWrapper:isTrainingSkill() then
      self._skillIdxTable[skillIdx] = skillIdx
      self._ui._list2_Skill:getElementManager():pushKey(toInt64(0, skillIdx))
      uiCount = uiCount + 1
    end
  end
  if nil ~= self._currentSkillListData._pos and nil ~= self._currentSkillListData._index then
    self._ui._list2_Skill:setCurrenttoIndex(self._currentSkillListData._index)
    self._ui._list2_Skill:GetVScroll():SetControlPos(self._currentSkillListData._pos)
  end
  local gap = self._OriginSkillBgSizeY - self._OriginList2SizeY
  if uiCount <= 0 then
    Panel_Dialog_ServantInfo_All:SetSize(Panel_Dialog_ServantInfo_All:GetSizeX(), self._ui._stc_infoBg:GetSizeY())
    self._ui._btn_SkillManagerBg:SetShow(false)
    self._ui._btn_SkillManager:SetShow(false)
    self._ui._stc_SkillBg:SetShow(false)
    if true == self._isConsole then
      self._ui._stc_ConsoleHighlight:SetSize(Panel_Dialog_ServantInfo_All:GetSizeX() + 1, Panel_Dialog_ServantInfo_All:GetSizeY() + 1)
    end
    return
  elseif uiCount <= 4 then
    self._ui._list2_Skill:SetSize(self._ui._list2_Skill:GetSizeX(), self._ui._list2_Content:GetSizeY() * uiCount + 5)
    self._ui._stc_SkillBg:SetSize(self._ui._list2_Skill:GetSizeX(), self._ui._list2_Skill:GetSizeY() + gap)
  else
    self._ui._list2_Skill:SetSize(self._ui._list2_Skill:GetSizeX(), self._OriginList2SizeY)
    self._ui._stc_SkillBg:SetSize(self._ui._stc_SkillBg:GetSizeX(), self._OriginSkillBgSizeY)
  end
  local isSKillManagerBtnOn = self._ui._btn_SkillManagerBg:GetShow()
  if true == isSKillManagerBtnOn then
    Panel_Dialog_ServantInfo_All:SetSize(Panel_Dialog_ServantInfo_All:GetSizeX(), self._ui._stc_infoBg:GetSizeY() + self._ui._stc_SkillBg:GetSizeY() + 15)
    self._ui._btn_SkillManagerBg:ComputePos()
    self._ui._btn_SkillManager:SetIgnore(false)
  else
    Panel_Dialog_ServantInfo_All:SetSize(Panel_Dialog_ServantInfo_All:GetSizeX(), self._ui._stc_infoBg:GetSizeY() + self._ui._stc_SkillBg:GetSizeY() - 5)
    self._ui._btn_SkillManager:SetIgnore(true)
  end
  if true == self._ui._stc_StatusArea:GetShow() then
    Panel_Dialog_ServantInfo_All:SetSize(Panel_Dialog_ServantInfo_All:GetSizeX(), Panel_Dialog_ServantInfo_All:GetSizeY() + self._ui._stc_StatusArea:GetSizeY() + 10)
  end
  if true == self._isConsole then
    self._ui._stc_ConsoleHighlight:SetSize(Panel_Dialog_ServantInfo_All:GetSizeX() + 1, Panel_Dialog_ServantInfo_All:GetSizeY() + 1)
  end
end
function PaGlobal_ServantInfo_All:switchVehicleInfo(isShip_orGuild)
  if nil == Panel_Dialog_ServantInfo_All then
    return
  end
  self._ui._stc_StatusArea:SetShow(false)
  self._ui._btn_SkillManagerBg:SetShow(false)
  self._ui._btn_SkillManager:SetShow(false)
  if false == isShip_orGuild then
    self._ui._txt_MatingTitle:SetShow(false)
    self._ui._txt_MatingValue:SetShow(false)
    self._ui._txt_LeftLifeTitle:SetShow(false)
    self._ui._txt_LeftLifeValue:SetShow(false)
    self._ui._txt_ImprintTitle:SetShow(false)
    self._ui._txt_ImprintValue:SetShow(false)
    self._ui._stc_ExpBg:SetShow(true)
    local statBgGroup = {}
    statBgGroup[0] = self._ui._stc_ExpBg
    statBgGroup[1] = self._ui._stc_HpBg
    statBgGroup[2] = self._ui._stc_StaminaBg
    statBgGroup[3] = self._ui._stc_WeightBg
    for i = 0, #statBgGroup do
      statBgGroup[i]:SetSpanSize(0, self._ui._stc_ExpBg:GetSpanSize().y + self._STATBGGAP * i)
    end
    self._ui._stc_StatBg:SetPosY(statBgGroup[3]:GetPosY() + self._STATBGGAP - 10)
    self._ui._stc_SkillBg:SetPosY(self._ui._stc_StatBg:GetPosY() - self._STATBGGAP * 2)
  else
    self._ui._txt_MatingTitle:SetShow(false)
    self._ui._txt_MatingValue:SetShow(false)
    self._ui._txt_LeftLifeTitle:SetShow(false)
    self._ui._txt_LeftLifeValue:SetShow(false)
    self._ui._txt_ImprintTitle:SetShow(false)
    self._ui._txt_ImprintValue:SetShow(false)
    self._ui._icon_SwiftHorse:SetShow(false)
    self._ui._btn_SkillManagerBg:SetShow(false)
    self._ui._btn_SkillManager:SetShow(false)
    self._ui._icon_ServantGender:SetShow(false)
    PaGlobal_ServantInfo_All:SetTimerShow(false)
    self._ui._stc_ExpBg:SetShow(false)
    local statBgGroup = {}
    statBgGroup[0] = self._ui._stc_HpBg
    statBgGroup[1] = self._ui._stc_StaminaBg
    statBgGroup[2] = self._ui._stc_WeightBg
    for i = 0, #statBgGroup do
      statBgGroup[i]:SetSpanSize(0, self._ui._stc_ExpBg:GetSpanSize().y + self._STATBGGAP * i)
    end
    self._ui._stc_StatBg:SetPosY(statBgGroup[2]:GetPosY() + self._STATBGGAP - 10)
    self._ui._stc_SkillBg:SetPosY(self._ui._stc_StatBg:GetPosY() - self._STATBGGAP * 2)
  end
end
function PaGlobal_ServantInfo_All:updateServantSkillByList2(content, key)
  if nil == Panel_Dialog_ServantInfo_All or false == Panel_Dialog_ServantInfo_All:GetShow() then
    return
  end
  if nil == key or nil == self._currentSlotType then
    return
  end
  local servantInfo
  if 0 == self._currentSlotType then
    if true == PaGlobalFunc_ServantFunction_All_GetIsGuild() then
      servantInfo = guildStable_getServant(self._currentVehicleIndexNo)
    else
      servantInfo = stable_getServant(self._currentVehicleIndexNo)
    end
  elseif 1 == self._currentSlotType then
    local temporaryWrapper = getTemporaryInformationWrapper()
    if nil == temporaryWrapper then
      return
    end
    servantInfo = temporaryWrapper:getUnsealVehicle(stable_getServantType())
    isUnSealed = true
  end
  if nil == servantInfo then
    content:SetShow(false)
    return
  else
    content:SetShow(true)
  end
  local key32 = Int64toInt32(key)
  local skillSlotBg = UI.getChildControl(content, "Static_SkillSlotBg")
  local expBg = UI.getChildControl(content, "Static_SkillExpBg")
  local circle_Prog2_Exp = UI.getChildControl(content, "CircularProgress_SkillExp")
  local skillIcon = UI.getChildControl(content, "Static_SkillIcon")
  local skillExpPercent = UI.getChildControl(content, "StaticText_SkillExpPercent")
  local skillName = UI.getChildControl(content, "StaticText_SkillName")
  local skillCommand = UI.getChildControl(content, "StaticText_SkillCommandValue")
  circle_Prog2_Exp:SetProgressRate(0)
  circle_Prog2_Exp:SetShow(false)
  expBg:SetShow(false)
  skillExpPercent:SetShow(false)
  skillSlotBg:setNotImpactScrollEvent(true)
  skillName:SetTextMode(__eTextMode_LimitText)
  skillCommand:SetTextMode(__eTextMode_AutoWrap)
  local actorKeyRaw = servantInfo:getActorKeyRaw()
  local skillWrapper = servantInfo:getSortedSkillForDisplay(key32)
  local sortedKey32 = servantInfo:getSortedSkillKey(key32)
  if nil ~= skillWrapper and false == skillWrapper:isTrainingSkill() then
    skillIcon:ChangeTextureInfoName("Icon/" .. skillWrapper:getIconPath())
    skillIcon:addInputEvent("Mouse_On", "HandleEventOn_Servant_Tooltip_Open(" .. key32 .. ")")
    skillIcon:addInputEvent("Mouse_Out", "HandleEventOut_ServantInfo_All_SkillTooltipClose()")
    skillName:SetText(skillWrapper:getName())
    skillCommand:SetText(skillWrapper:getDescription())
    if self._currentNpcType ~= self._ENUM_NPC_TYPE._SEA and self._currentNpcType ~= self._ENUM_NPC_TYPE._GUILD_SEA then
      expBg:SetShow(true)
      local expPercentTxt = servantInfo:getSkillExp(sortedKey32) / (skillWrapper:getMaxExp() / 100)
      if 100 <= expPercentTxt then
        expPercentTxt = 100
      end
      circle_Prog2_Exp:SetShow(true)
      skillExpPercent:SetShow(true)
      skillExpPercent:SetText(tonumber(string.format("%.0f", expPercentTxt)) .. "%")
      circle_Prog2_Exp:SetProgressRate(expPercentTxt)
      circle_Prog2_Exp:SetAniSpeed(0)
    end
  end
  if true == skillName:IsLimitText() then
    skillName:addInputEvent("Mouse_On", "HandleEventOnOut_ServantInfo_All_ShowSkillTitleToolTip(" .. key32 .. " , true)")
    skillName:addInputEvent("Mouse_Out", "HandleEventOnOut_ServantInfo_All_ShowSkillTitleToolTip(" .. key32 .. " , false)")
  else
    skillName:addInputEvent("Mouse_On", "")
    skillName:addInputEvent("Mouse_Out", "")
  end
  if false == self._isConsole then
    skillSlotBg:addInputEvent("Mouse_UpScroll", "HandleEventScroll_ServantInfo_All_saveScrollPos()")
    skillSlotBg:addInputEvent("Mouse_DownScroll", "HandleEventScroll_ServantInfo_All_saveScrollPos()")
    skillSlotBg:addInputEvent("Mouse_LUp", "HandleEventScroll_ServantInfo_All_saveScrollPos()")
  end
end
function PaGlobal_ServantInfo_All:Servant_Tooltip_Open(key32)
  if nil == Panel_Dialog_ServantInfo_All or true == self._isConsole then
    return
  end
  local content = PaGlobal_ServantInfo_All._ui._list2_Skill:GetContentByKey(toInt64(0, key32))
  local skillIcon = UI.getChildControl(content, "Static_SkillIcon")
  local servantInfo
  if 0 == self._currentSlotType then
    if true == PaGlobalFunc_ServantFunction_All_GetIsGuild() then
      servantInfo = guildStable_getServant(self._currentVehicleIndexNo)
    else
      servantInfo = stable_getServant(self._currentVehicleIndexNo)
    end
  elseif 1 == self._currentSlotType then
    local temporaryWrapper = getTemporaryInformationWrapper()
    if nil == temporaryWrapper then
      return
    end
    servantInfo = temporaryWrapper:getUnsealVehicle(stable_getServantType())
    isUnSealed = true
  end
  if nil ~= servantInfo then
    local skillWrapper = servantInfo:getSortedSkillForDisplay(key32)
    if true == _ContentsGroup_NewUI_Tooltip_All then
      PaGlobal_Tooltip_Skill_Servant_All_Open(skillWrapper, skillIcon, false)
    else
      PaGlobal_Tooltip_Servant_Open(skillWrapper, skillIcon, false)
    end
  end
end
function PaGlobal_ServantInfo_All:SetTimerShow(isShow, btnType, text, servantInfo)
  if false == isShow or true == PaGlobalFunc_ServantFunction_All_GetIsGuild() or nil == servantInfo then
    self._ui._stc_StatusArea:SetShow(false)
    return
  end
  self._ui._stc_StatusArea:SetShow(isShow)
  self._ui._btn_Immediate:SetShow(false)
  self._ui._btn_GetHorse:SetShow(false)
  local isBtnAble = false
  if 0 == btnType or nil == btnType then
    self._ui._txt_StatusTitle:SetText(text)
  elseif 1 == btnType then
    self._ui._txt_StatusTitle:SetText(text)
    if FGlobal_IsCommercialService() and not servantInfo:isMale() then
      self._ui._btn_Immediate:SetShow(true)
      isBtnAble = true
    end
  elseif 2 == btnType then
  end
  if true == isBtnAble then
    self._ui._txt_StatusTitle:SetHorizonLeft()
    self._ui._txt_StatusTitle:SetTextHorizonLeft()
    self._ui._stc_StatusArea:SetPosY(self._ui._stc_infoBg:GetPosY() + self._ui._stc_infoBg:GetSizeY())
    self._ui._txt_StatusTitle:SetSpanSize(20, 0)
  else
    self._ui._txt_StatusTitle:SetHorizonCenter()
    self._ui._txt_StatusTitle:SetTextHorizonCenter()
    self._ui._stc_StatusArea:SetPosY(self._ui._stc_infoBg:GetPosY() + self._ui._stc_infoBg:GetSizeY())
    self._ui._txt_StatusTitle:SetSpanSize(0, 0)
  end
end
function PaGlobal_ServantInfo_All:prepareClose()
  if nil == Panel_Dialog_ServantInfo_All or false == Panel_Dialog_ServantInfo_All:GetShow() then
    return
  end
  self._currentNpcType = nil
  self._currentVehicleIndexNo = nil
  self._currentSlotType = nil
  self._currentVehicleNo = nil
  self._currentSkillListData._pos = nil
  self._currentSkillListData._index = nil
  HandleEventOut_ServantInfo_All_SkillTooltipClose()
  PaGlobal_ServantInfo_All:close()
end
function PaGlobal_ServantInfo_All:close()
  if nil == Panel_Dialog_ServantInfo_All or false == Panel_Dialog_ServantInfo_All:GetShow() then
    return
  end
  Panel_Dialog_ServantInfo_All:SetShow(false)
end
function PaGlobal_ServantInfo_All:validate()
  if nil == Panel_Dialog_ServantInfo_All then
    return
  end
  self._ui._stc_infoBg:isValidate()
  self._ui._txt_Name:isValidate()
  self._ui._icon_ServantGender:isValidate()
  self._ui._icon_SwiftHorse:isValidate()
  self._ui._txt_Tier:isValidate()
  self._ui._txt_ExpTitle:isValidate()
  self._ui._txt_ExpValue:isValidate()
  self._ui._stc_ExpProgressBg:isValidate()
  self._ui._prog2_Exp:isValidate()
  self._ui._prog2_Exp_Head:isValidate()
  self._ui._txt_HpTitle:isValidate()
  self._ui._txt_HpValue:isValidate()
  self._ui._stc_HpProgressBg:isValidate()
  self._ui._prog2_Hp:isValidate()
  self._ui._prog2_Hp_Head:isValidate()
  self._ui._stc_StaminaProgressBg:isValidate()
  self._ui._txt_StatminaTitle:isValidate()
  self._ui._txt_StatminaValue:isValidate()
  self._ui._prog2_Stamina:isValidate()
  self._ui._prog2_Stamina_Head:isValidate()
  self._ui._txt_WeightTitle:isValidate()
  self._ui._txt_WeightValue:isValidate()
  self._ui._stc_WeightProgressBg:isValidate()
  self._ui._prog2_Weight:isValidate()
  self._ui._prog2_Weight_Head:isValidate()
  self._ui._stc_StatBg:isValidate()
  self._ui._txt_SpeedTitle:isValidate()
  self._ui._txt_SpeedValue:isValidate()
  self._ui._txt_CorneringTitle:isValidate()
  self._ui._txt_CorneringValue:isValidate()
  self._ui._txt_AccelrationTitle:isValidate()
  self._ui._txt_AccelrationValue:isValidate()
  self._ui._txt_BreakTitle:isValidate()
  self._ui._txt_BreakValue:isValidate()
  self._ui._txt_DeadTitle:isValidate()
  self._ui._txt_DeadValue:isValidate()
  self._ui._txt_MatingTitle:isValidate()
  self._ui._txt_MatingValue:isValidate()
  self._ui._txt_LeftLifeTitle:isValidate()
  self._ui._txt_LeftLifeValue:isValidate()
  self._ui._txt_ImprintTitle:isValidate()
  self._ui._txt_ImprintValue:isValidate()
  self._ui._stc_StatusArea:isValidate()
  self._ui._txt_StatusTitle:isValidate()
  self._ui._btn_Immediate:isValidate()
  self._ui._btn_GetHorse:isValidate()
  self._ui._stc_SkillBg:isValidate()
  self._ui._txt_SkillBgTitle:isValidate()
  self._ui._list2_Skill:isValidate()
  self._ui._list2_Content:isValidate()
  self._ui._list2_SkillSlotBg:isValidate()
  self._ui._list2_list2_ExpBg:isValidate()
  self._ui._list2_Circle_Prog2_Exp:isValidate()
  self._ui._list2_stc_SkillIcon:isValidate()
  self._ui._list2_txt_SkillExpPercent:isValidate()
  self._ui._list2_txt_SkillName:isValidate()
  self._ui._list2_txt_SkillCommand:isValidate()
  self._ui._list2_VertiScroll:isValidate()
  self._ui._list2_VertiScroll_Up:isValidate()
  self._ui._list2_VertiScroll_Down:isValidate()
  self._ui._list2_VertiScroll_Ctrl:isValidate()
  self._ui._list2_HoriScroll_Up:isValidate()
  self._ui._list2_HoriScroll_Down:isValidate()
  self._ui._list2_HoriScroll_Ctrl:isValidate()
  self._ui._stc_ExpBg:isValidate()
  self._ui._stc_HpBg:isValidate()
  self._ui._stc_StaminaBg:isValidate()
  self._ui._stc_WeightBg:isValidate()
  self._ui._stc_ConsoleHighlight:isValidate()
  self._initialize = true
end
