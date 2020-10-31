local UI_color = Defines.Color
local UI_ANI_ADV = CppEnums.PAUI_ANIM_ADVANCE_TYPE
local IM = CppEnums.EProcessorInputMode
local isFairyByPetNo = function(petNo)
  local countUnsealed = ToClient_getFairyUnsealedList()
  local countSealed = ToClient_getFairySealedList()
  local fairyData
  if countUnsealed < countSealed then
    fairyData = ToClient_getFairySealedDataByIndex(0)
    if nil == fairyData then
      return false
    end
    if petNo == fairyData._petNo then
      return true
    end
  else
    fairyData = ToClient_getFairyUnsealedDataByIndex(0)
    if nil == fairyData then
      return false
    end
    if petNo == fairyData:getPcPetNo() then
      return true
    end
  end
  return false
end
function PaGlobal_FairyInfo_All:initialize()
  if true == PaGlobal_FairyInfo_All._initialize then
    return
  end
  self._ui.stc_TitleBG = UI.getChildControl(Panel_FairyInfo_All, "Static_TitleBG")
  self._ui.stc_TitleImage = UI.getChildControl(Panel_FairyInfo_All, "Static_Image")
  self._ui_pc.btn_Question_pc = UI.getChildControl(self._ui.stc_TitleBG, "Button_Question_PC")
  self._ui_pc.btn_Close_pc = UI.getChildControl(self._ui.stc_TitleBG, "Button_Win_Close_PC")
  self._ui.stc_BasicInfoBG = UI.getChildControl(Panel_FairyInfo_All, "Static_BasicInfoGroup")
  self._ui.txt_FairyTier = UI.getChildControl(self._ui.stc_BasicInfoBG, "StaticText_FairyTier")
  self._ui.txt_FairyName = UI.getChildControl(self._ui.stc_BasicInfoBG, "StaticText_FairyName")
  self._ui.stc_LevleInfoBG = UI.getChildControl(self._ui.stc_BasicInfoBG, "Static_LevelPosition")
  self._ui.txt_Level = UI.getChildControl(self._ui.stc_LevleInfoBG, "StaticText_Level")
  self._ui.txt_Exp = UI.getChildControl(self._ui.stc_LevleInfoBG, "StaticText_LevelExp")
  self._ui.progress2_Exp = UI.getChildControl(self._ui.stc_LevleInfoBG, "Progress2_LevelGauge")
  self._ui.txt_FairyDesc = UI.getChildControl(self._ui.stc_BasicInfoBG, "StaticText_Desc")
  self._ui_pc.btn_FairyUpgrade_pc = UI.getChildControl(self._ui.stc_BasicInfoBG, "Button_FairyUpgradeBTN_PC")
  self._ui_pc.btn_FairyGrowth_pc = UI.getChildControl(self._ui.stc_BasicInfoBG, "Button_FairyGrowthBTN_PC")
  self._ui.stc_PotionBG = UI.getChildControl(Panel_FairyInfo_All, "Static_PotionPositionBG")
  self._ui.stc_HPPotionBG = UI.getChildControl(self._ui.stc_PotionBG, "Static_HpBG")
  self._ui.stc_HPIcon = UI.getChildControl(self._ui.stc_HPPotionBG, "Static_HpIcon")
  self._ui.stc_MPPotionBG = UI.getChildControl(self._ui.stc_PotionBG, "Static_MpBG")
  self._ui.stc_QuestionMarkHP = UI.getChildControl(self._ui.stc_HPPotionBG, "Static_1")
  self._ui.stc_QuestionMarkMP = UI.getChildControl(self._ui.stc_MPPotionBG, "Static_2")
  self._ui.stc_MPIcon = UI.getChildControl(self._ui.stc_MPPotionBG, "Static_MpIcon")
  self._ui.txt_HPSet = UI.getChildControl(self._ui.stc_PotionBG, "StaticText_HpSet")
  self._ui.txt_MPSet = UI.getChildControl(self._ui.stc_PotionBG, "StaticText_MpSet")
  self._ui_pc.btn_PotionSetting_pc = UI.getChildControl(self._ui.stc_PotionBG, "Button_PotionSet_PC")
  self._ui.stc_PotionLockBG = UI.getChildControl(Panel_FairyInfo_All, "Static_PotionPositionLockBG")
  self._ui.stc_SkillBG = UI.getChildControl(Panel_FairyInfo_All, "Static_SkillBG")
  for i = 0, self._MaxSkillCount - 1 do
    self._ui._skillIconBg[i] = UI.getChildControl(self._ui.stc_SkillBG, "Static_SkillIconBG" .. tostring(i + 1))
    self._ui._skillIcon[i] = UI.getChildControl(self._ui.stc_SkillBG, "Static_SkillIcon" .. tostring(i + 1))
    self._ui._skillMasterIcon[i] = UI.getChildControl(self._ui._skillIcon[i], "Static_MasterIcon" .. tostring(i + 1))
    self._ui._skillName[i] = UI.getChildControl(self._ui.stc_SkillBG, "StaticText_SkillName" .. tostring(i + 1))
    self._ui._skillDesc[i] = UI.getChildControl(self._ui.stc_SkillBG, "StaticText_SkillDesc" .. tostring(i + 1))
  end
  self._ui_pc.btn_LearnableSkill_pc = UI.getChildControl(self._ui.stc_SkillBG, "Button_LearnableSkill")
  self._ui_pc.btn_ChangeSkill = UI.getChildControl(self._ui.stc_SkillBG, "Button_ChangeSkill")
  self._ui.stc_BottomButtonBG = UI.getChildControl(Panel_FairyInfo_All, "Static_ButtonPosition")
  self._ui_pc.btn_Rebirth_pc = UI.getChildControl(self._ui.stc_BottomButtonBG, "Button_Rebirth")
  self._ui_pc.btn_Summon_pc = UI.getChildControl(self._ui.stc_BottomButtonBG, "Button_Summon")
  self._ui_pc.btn_Unsummon_pc = UI.getChildControl(self._ui.stc_BottomButtonBG, "Button_UnSummon")
  self._ui_pc.btn_Release_pc = UI.getChildControl(self._ui.stc_BottomButtonBG, "Button_FairyBTN")
  self._ui_pc.btn_SkinChange_pc = UI.getChildControl(self._ui.stc_BottomButtonBG, "Button_SkinChange")
  self._ui.chk_Lantern = UI.getChildControl(Panel_FairyInfo_All, "CheckButton_Lantern")
  self._ui.stc_BottomKeyGuide = UI.getChildControl(Panel_FairyInfo_All, "Static_KeyGuide_Console")
  self._ui_console.stc_KeyGuide_LTX = UI.getChildControl(self._ui.stc_BottomKeyGuide, "Static_LearnableSkillBTN_Console")
  self._ui_console.stc_KeyGuide_LTY = UI.getChildControl(self._ui.stc_BottomKeyGuide, "Static_TierUpgradeBTN_Console")
  self._ui_console.stc_KeyGuide_LTA = UI.getChildControl(self._ui.stc_BottomKeyGuide, "Static_FairyBTN_Console")
  self._ui_console.stc_KeyGuide_RTX = UI.getChildControl(self._ui.stc_BottomKeyGuide, "Static_ChangeSkillBTN_Console")
  self._ui_console.stc_KeyGuide_X = UI.getChildControl(self._ui.stc_BottomKeyGuide, "StaticText_PotionSet_Console")
  self._ui_console.stc_KeyGuide_Y = UI.getChildControl(self._ui.stc_BottomKeyGuide, "StaticText_Growth_Console")
  self._ui_console.stc_KeyGuide_A = UI.getChildControl(self._ui.stc_BottomKeyGuide, "StaticText_Summon_Console")
  self._ui_console.stc_KeyGuide_B = UI.getChildControl(self._ui.stc_BottomKeyGuide, "StaticText_Close_Console")
  self._keyguide = {
    self._ui_console.stc_KeyGuide_LTX,
    self._ui_console.stc_KeyGuide_LTY,
    self._ui_console.stc_KeyGuide_LTA,
    self._ui_console.stc_KeyGuide_RTX,
    self._ui_console.stc_KeyGuide_X,
    self._ui_console.stc_KeyGuide_Y,
    self._ui_console.stc_KeyGuide_A,
    self._ui_console.stc_KeyGuide_B
  }
  PaGlobal_FairyInfo_All._config._defaultMainImagePath = "combine/etc/combine_fairy_portrat_00.dds"
  self._ui_pc.btn_Release_pc:SetTextMode(__eTextMode_AutoWrap)
  self._ui_pc.btn_Release_pc:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_FAIRY_INFO_FREEDOM_NAME"))
  self._ui_pc.btn_SkinChange_pc:SetTextMode(__eTextMode_AutoWrap)
  self._ui_pc.btn_SkinChange_pc:SetText(PAGetString(Defines.StringSheet_RESOURCE, "INTERACTION_BTN_CHANGELOOK"))
  PaGlobal_FairyInfo_All:SetUiSetting()
  PaGlobal_FairyInfo_All:AlignKeyGuide()
  PaGlobal_FairyInfo_All:AdjustPanelSize()
  if false == isGameServiceTypeConsole() then
    if true ~= _ContentsOption_CH_WepHelperControl then
      self._ui_pc.btn_Question_pc:SetShow(true)
    end
  else
    self._ui_pc.btn_ChangeSkill:SetShow(false)
    self._ui_pc.btn_Question_pc:SetShow(false)
  end
  PaGlobal_FairyInfo_All:registEventHandler()
  PaGlobal_FairyInfo_All:validate()
  PaGlobal_FairyInfo_All._initialize = true
end
function PaGlobal_FairyInfo_All:AdjustPanelSize()
  if nil == Panel_FairyInfo_All then
    return
  end
  if false == _ContentsGroup_UsePadSnapping then
    return
  end
  local subtractSizeY = self._ui.stc_BottomButtonBG:GetSizeY()
  Panel_FairyInfo_All:SetSize(Panel_FairyInfo_All:GetSizeX(), Panel_FairyInfo_All:GetSizeY() - subtractSizeY)
  local stc_Image = UI.getChildControl(Panel_FairyInfo_All, "Static_Image")
  stc_Image:SetSize(stc_Image:GetSizeX(), stc_Image:GetSizeY() - subtractSizeY)
  self._ui.stc_BottomKeyGuide:ComputePos()
end
function PaGlobal_FairyInfo_All:SetUiSetting()
  if nil == Panel_FairyInfo_All then
    return
  end
  for _, value in pairs(self._ui_pc) do
    value:SetShow(not _ContentsGroup_UsePadSnapping)
  end
  for _, value in pairs(self._ui_console) do
    value:SetShow(_ContentsGroup_UsePadSnapping)
  end
  if true == _ContentsGroup_FairyChangeSkill then
    self._ui_pc.btn_ChangeSkill:SetShow(not _ContentsGroup_UsePadSnapping)
  else
    self._ui_pc.btn_ChangeSkill:SetShow(false)
    self._ui_pc.btn_LearnableSkill_pc:SetPosX(self._ui_pc.btn_LearnableSkill_pc:GetPosX() + 120)
  end
  if true == _ContentsGroup_UsePadSnapping or true == _ContentsOption_CH_WepHelperControl then
    self._ui_pc.btn_Question_pc:SetShow(false)
  end
  self._ui.stc_BottomButtonBG:SetShow(not _ContentsGroup_UsePadSnapping)
  self._ui.stc_BottomKeyGuide:SetShow(_ContentsGroup_UsePadSnapping)
end
function PaGlobal_FairyInfo_All:AlignKeyGuide()
  if nil == Panel_FairyInfo_All or false == _ContentsGroup_UsePadSnapping then
    return
  end
  PaGlobalFunc_ConsoleKeyGuide_SetAlign(self._keyguide, self._ui.stc_BottomKeyGuide, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_AUTO_WRAP_LEFT)
end
function PaGlobal_FairyInfo_All:registEventHandler()
  if nil == Panel_FairyInfo_All then
    return
  end
  if false == _ContentsGroup_UsePadSnapping then
    self._ui_pc.btn_Question_pc:addInputEvent("Mouse_LUp", "Panel_WebHelper_ShowToggle(\"Fairy\")")
    self._ui_pc.btn_Question_pc:addInputEvent("Mouse_On", "PaGlobal_FairyInfo_SimpleTooltip_All(true, 6)")
    self._ui_pc.btn_Question_pc:addInputEvent("Mouse_Out", "PaGlobal_FairyInfo_SimpleTooltip_All(false)")
    self._ui_pc.btn_Close_pc:addInputEvent("Mouse_LUp", "PaGlobal_FairyInfo_Close_All()")
    self._ui_pc.btn_FairyGrowth_pc:addInputEvent("Mouse_LUp", "PaGlobal_FairyGrowth_Open_All(false)")
    self._ui_pc.btn_FairyGrowth_pc:addInputEvent("Mouse_On", "PaGlobal_FairyInfo_SimpleTooltip_All(true,3)")
    self._ui_pc.btn_FairyGrowth_pc:addInputEvent("Mouse_Out", "PaGlobal_FairyInfo_SimpleTooltip_All(false)")
    if true == _ContentsGroup_FairyTierUpgradeAndRebirth then
      self._ui_pc.btn_Rebirth_pc:addInputEvent("Mouse_LUp", "PaGlobal_FairyChoiceTheReset_Open_All()")
    else
      self._ui_pc.btn_Rebirth_pc:addInputEvent("Mouse_LUp", "PaGlobal_FairyInfo_RequestRebirth_All()")
    end
    self._ui_pc.btn_Rebirth_pc:addInputEvent("Mouse_On", "PaGlobal_FairyInfo_SimpleTooltip_All(true, 2)")
    self._ui_pc.btn_Rebirth_pc:addInputEvent("Mouse_Out", "PaGlobal_FairyInfo_SimpleTooltip_All(false)")
    self._ui_pc.btn_Summon_pc:addInputEvent("Mouse_LUp", "InputMLClick_FairyInfo_SummonFairy_All()")
    self._ui_pc.btn_Summon_pc:addInputEvent("Mouse_On", "PaGlobal_FairyInfo_SimpleTooltip_All(true, 4)")
    self._ui_pc.btn_Summon_pc:addInputEvent("Mouse_Out", "PaGlobal_FairyInfo_SimpleTooltip_All(false)")
    self._ui_pc.btn_Unsummon_pc:addInputEvent("Mouse_LUp", "InputMLClick_FairyInfo_SummonFairy_All()")
    self._ui_pc.btn_Unsummon_pc:addInputEvent("Mouse_On", "PaGlobal_FairyInfo_SimpleTooltip_All(true, 5)")
    self._ui_pc.btn_Unsummon_pc:addInputEvent("Mouse_Out", "PaGlobal_FairyInfo_SimpleTooltip_All(false)")
    self._ui_pc.btn_Release_pc:addInputEvent("Mouse_LUp", "PaGlobal_FairyInfo_RequestFreedom_All()")
    self._ui_pc.btn_Release_pc:addInputEvent("Mouse_On", "PaGlobal_FairyInfo_SimpleTooltip_All(true, 0)")
    self._ui_pc.btn_Release_pc:addInputEvent("Mouse_Out", "PaGlobal_FairyInfo_SimpleTooltip_All(false)")
    self._ui_pc.btn_SkinChange_pc:addInputEvent("Mouse_LUp", "PaGlobal_FairySkinChange_Open_All()")
    self._ui_pc.btn_SkinChange_pc:addInputEvent("Mouse_On", "PaGlobal_FairyInfo_SimpleTooltip_All(true, 10)")
    self._ui_pc.btn_SkinChange_pc:addInputEvent("Mouse_Out", "PaGlobal_FairyInfo_SimpleTooltip_All(false)")
    self._ui_pc.btn_FairyUpgrade_pc:addInputEvent("Mouse_LUp", "PaGlobal_FairyTierUpgrade_Open_All(true)")
    self._ui_pc.btn_FairyUpgrade_pc:addInputEvent("Mouse_On", "PaGlobal_FairyInfo_SimpleTooltip_All(true, 8)")
    self._ui_pc.btn_FairyUpgrade_pc:addInputEvent("Mouse_Out", "PaGlobal_FairyInfo_SimpleTooltip_All(false)")
    self._ui_pc.btn_LearnableSkill_pc:addInputEvent("Mouse_LUp", "PaGlobalFunc_FairySkill_Open_All(false)")
    self._ui_pc.btn_LearnableSkill_pc:addInputEvent("Mouse_On", "PaGlobal_FairyInfo_SimpleTooltip_All(true, 9)")
    self._ui_pc.btn_LearnableSkill_pc:addInputEvent("Mouse_Out", "PaGlobal_FairyInfo_SimpleTooltip_All(false)")
    self._ui_pc.btn_ChangeSkill:addInputEvent("Mouse_On", "PaGlobal_FairyInfo_SimpleTooltip_All(true, 11)")
    self._ui_pc.btn_ChangeSkill:addInputEvent("Mouse_Out", "PaGlobal_FairyInfo_SimpleTooltip_All(false)")
    self._ui_pc.btn_LearnableSkill_pc:addInputEvent("Mouse_LUp", "PaGlobalFunc_FairySkill_Open_All(false)")
  else
    Panel_FairyInfo_All:registerPadEvent(__eConsoleUIPadEvent_Up_A, "InputMLClick_FairyInfo_SummonFairy_All()")
    Panel_FairyInfo_All:registerPadEvent(__eConsoleUIPadEvent_LTPress_X, "PaGlobalFunc_FairySkill_Open_All(false)")
    Panel_FairyInfo_All:registerPadEvent(__eConsoleUIPadEvent_RTPress_X, "PaGlobal_FairyChangeSkill_Open_All()")
  end
  self._ui_pc.btn_ChangeSkill:addInputEvent("Mouse_LUp", "PaGlobal_FairyChangeSkill_Open_All()")
  self._ui.chk_Lantern:addInputEvent("Mouse_LUp", "PaGlobal_FairyInfo_LanterOnOff_All()")
  self._ui.chk_Lantern:addInputEvent("Mouse_On", "PaGlobal_FairyInfo_SimpleTooltip_All(true, 7)")
  self._ui.chk_Lantern:addInputEvent("Mouse_Out", "PaGlobal_FairyInfo_SimpleTooltip_All(false)")
  self._ui.stc_HPIcon:addInputEvent("Mouse_On", "PaGlobal_FairyInfo_ShowToolTip_All(true, true)")
  self._ui.stc_HPIcon:addInputEvent("Mouse_Out", "PaGlobal_FairyInfo_ShowToolTip_All(true, false)")
  self._ui.stc_MPIcon:addInputEvent("Mouse_Out", "PaGlobal_FairyInfo_ShowToolTip_All(false, false)")
  self._ui.stc_MPIcon:addInputEvent("Mouse_On", "PaGlobal_FairyInfo_ShowToolTip_All(false, true)")
  registerEvent("FromClient_PetAddSealedList", "FromClient_FairyInfo_addSealedList_Open_All")
  registerEvent("FromClient_PetDelSealedList", "FromClient_FairyInfo_delSealedList_Open_All")
  registerEvent("FromClient_PetDelList", "FromClient_FiaryInfo_delList_Open_All")
  registerEvent("FromClient_InputFairyName", "FromClient_FairyInfo_InputFairyNameStart_All")
  registerEvent("FromClient_Fairy_Update", "FromClient_Fairy_Update_All")
end
function PaGlobal_FairyInfo_All:prepareOpen(noSetPos)
  if nil == Panel_FairyInfo_All then
    return
  end
  if true == _ContentsGroup_FairyChangeSkill and true == Panel_Window_FairyChangeSkill_All:GetShow() then
    return
  end
  if true == _ContentsGroup_NewUI_Camp_All and true == PaGlobal_FairyInfo_All:checkCamp() then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_FAIRYINFO_NOTAVAILABLE_WITHCAMPING"))
    return
  end
  if true == _ContentsGroup_NewUI_Inventory_All then
    if true == Panel_Window_Inventory_All:IsShow() then
      PaGlobalFunc_Inventory_All_Close()
    end
  elseif true == Panel_Window_Inventory:IsShow() then
    HandleClicked_InventoryWindow_Close()
  end
  local sealCount = ToClient_getFairySealedList()
  local unSealCount = ToClient_getFairyUnsealedList()
  local allCount = sealCount + unSealCount
  if allCount < 1 then
    if true == _ContentsGroup_ForceShowWidgetIcon then
      Panel_WebHelper_ShowToggle("Fairy")
    else
      PaGlobal_FairyInfo_Close_All()
    end
    return
  end
  PaGlobal_FairyInfo_All:Clear()
  PaGlobal_FairyInfo_All:update()
  if false == _ContentsGroup_RenewUI and true == _ContentsGroup_FairyLookChange then
    local skinCount = ToClient_getFairyChangeLookListSize()
    if 0 < skinCount then
      self._ui_pc.btn_SkinChange_pc:SetShow(true)
    else
      self._ui_pc.btn_SkinChange_pc:SetShow(false)
    end
  else
    self._ui_pc.btn_SkinChange_pc:SetShow(false)
  end
  PaGlobal_FairyInfo_All:open()
  if false == noSetPos then
    PaGlobal_FairyInfo_All:SetPos()
  end
end
function PaGlobal_FairyInfo_All:open()
  if nil == Panel_FairyInfo_All then
    return
  end
  Panel_FairyInfo_All:SetShow(true)
end
function PaGlobal_FairyInfo_All:prepareClose()
  if nil == Panel_FairyInfo_All then
    return
  end
  PaGlobal_FairyPanel_ALL_Close()
  if false == _ContentsGroup_RenewUI then
    Panel_Tooltip_Item_hideTooltip()
  else
    PaGlobalFunc_TooltipInfo_Close()
  end
  TooltipSimple_Hide()
  PaGlobal_FairyInfo_All:close()
end
function PaGlobal_FairyInfo_All:close()
  if nil == Panel_FairyInfo_All then
    return
  end
  Panel_FairyInfo_All:SetShow(false)
end
function PaGlobal_FairyInfo_All:update()
  if nil == Panel_FairyInfo_All then
    return
  end
  local isUnseal = false
  local pcFairyData
  local sealCount = ToClient_getFairySealedList()
  local unSealCount = ToClient_getFairyUnsealedList()
  local allCount = sealCount + unSealCount
  if allCount < 1 then
    PaGlobal_FairyInfo_Close_All()
    return
  end
  if 0 < unSealCount then
    isUnseal = true
  end
  if true == isUnseal then
    pcFairyData = ToClient_getFairyUnsealedDataByIndex(0)
  else
    pcFairyData = ToClient_getFairySealedDataByIndex(0)
  end
  self._isUnseal = isUnseal
  if nil == pcFairyData then
    return PaGlobal_FairyInfo_Close_All()
  end
  local fairyStaticStatus, iconPath, fairyNo_s64, fairyName, fairyLevel, fairyLovely, fairyhungry, fairyMaxLevel, fairyMaxHungry, fairyRace, fairyTier, fairyState, skillType, isPassive, tempIndex, fairyExp, MaxExp, fairyAttr
  if true == isUnseal then
    fairyStaticStatus = pcFairyData:getPetStaticStatus()
    self._iconPath = pcFairyData:getIconPath()
    fairyNo_s64 = pcFairyData:getPcPetNo()
    self._fairykey = pcFairyData:getCharacterKey()
    self._fairyNo = fairyNo_s64
    fairyName = pcFairyData:getName()
    self._fairyName = fairyName
    fairyTier = fairyStaticStatus:getPetTier()
    fairyLevel = pcFairyData:getLevel()
    fairyExp = Int64toInt32(pcFairyData:getExperience())
    MaxExp = Int64toInt32(fairyStaticStatus:getTotalExp(fairyLevel))
    fairyAttr = fairyStaticStatus:getPetKind()
  else
    fairyStaticStatus = pcFairyData:getPetStaticStatus()
    self._iconPath = pcFairyData:getIconPath()
    fairyNo_s64 = pcFairyData._petNo
    self._fairykey = pcFairyData:getCharacterKey()
    self._fairyNo = fairyNo_s64
    fairyName = pcFairyData:getName()
    self._fairyName = fairyName
    fairyTier = fairyStaticStatus:getPetTier()
    fairyLevel = pcFairyData._level
    fairyExp = Int64toInt32(pcFairyData:getExperience())
    MaxExp = Int64toInt32(fairyStaticStatus:getTotalExp(fairyLevel))
    fairyAttr = fairyStaticStatus:getPetKind()
  end
  self._fairyLevel = fairyLevel
  if fairyLevel >= (fairyTier + 1) * 10 then
    self._isFairyMaxLevel = true
  end
  if false == isUnseal then
    self._ui_pc.btn_Release_pc:SetShow(true)
    self._ui_console.stc_KeyGuide_LTA:SetShow(true)
    Panel_FairyInfo_All:registerPadEvent(__eConsoleUIPadEvent_LTPress_A, "PaGlobal_FairyInfo_RequestFreedom_All()")
  else
    self._ui_pc.btn_Release_pc:SetShow(false)
    self._ui_console.stc_KeyGuide_LTA:SetShow(false)
    Panel_FairyInfo_All:registerPadEvent(__eConsoleUIPadEvent_LTPress_A, "")
  end
  self._fairyUpgradeStack = pcFairyData:getUpgradeStackCount()
  if self._isFairyMaxLevel then
    self._ui_pc.btn_FairyGrowth_pc:SetEnable(false)
    self._ui_pc.btn_FairyGrowth_pc:SetMonoTone(true)
    if isUnseal then
      self._ui_console.stc_KeyGuide_Y:SetShow(false)
      Panel_FairyInfo_All:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "")
    end
  else
    self._ui_pc.btn_FairyGrowth_pc:SetEnable(true)
    self._ui_pc.btn_FairyGrowth_pc:SetMonoTone(false)
    self._ui_console.stc_KeyGuide_Y:SetShow(true)
    if isUnseal then
      self._ui_console.stc_KeyGuide_Y:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_FAIRYINFO_BTN_GROWTH"))
      Panel_FairyInfo_All:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "PaGlobal_FairyGrowth_Open_All(true)")
    end
  end
  if false == isUnseal then
    self._ui_console.stc_KeyGuide_Y:SetShow(true)
    self._ui_console.stc_KeyGuide_Y:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_FAIRYINFO_BTN_REBIRTH"))
    if true == _ContentsGroup_FairyTierUpgradeAndRebirth then
      Panel_FairyInfo_All:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "PaGlobal_FairyChoiceTheReset_Open_All()")
    else
      Panel_FairyInfo_All:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "PaGlobal_FairyInfo_RequestRebirth_All()")
    end
  end
  self._fairyTier = fairyTier
  if _ContentsGroup_UsePadSnapping then
    Panel_FairyInfo_All:registerPadEvent(__eConsoleUIPadEvent_LTPress_Y, "")
    self._ui_console.stc_KeyGuide_LTY:SetShow(false)
  end
  if _ContentsGroup_FairyTierUpgradeAndRebirth then
    self._enableFairyUpgrade = true
    if false == _ContentsGroup_RenewUI then
      self._ui_pc.btn_FairyUpgrade_pc:SetShow(true)
      if true == PaGlobal_FairyInfo_isMaxTier_All() then
        self._ui_pc.btn_FairyUpgrade_pc:SetShow(false)
      end
    end
    if 0 < self._fairyUpgradeStack and self._isFairyMaxLevel and not PaGlobal_FairyInfo_isMaxTier_All() then
      if isUnseal then
        self._ui_pc.btn_FairyUpgrade_pc:SetMonoTone(true)
      else
        self._ui_pc.btn_FairyUpgrade_pc:SetMonoTone(false)
        self._ui_console.stc_KeyGuide_LTY:SetShow(true)
        Panel_FairyInfo_All:registerPadEvent(__eConsoleUIPadEvent_LTPress_Y, "PaGlobal_FairyTierUpgrade_Open_All(true)")
      end
    else
      self._enableFairyUpgrade = false
    end
  else
    self._ui_pc.btn_FairyUpgrade_pc:SetShow(false)
    self._enableFairyUpgrade = false
  end
  local remainTime = 0
  for ii = self.eFairyMaxEquipSkill - 2, 0, -1 do
    if true == pcFairyData:isFairyEquipSkillLearned(ii) then
      self._skillKey[ii] = true
    end
  end
  local uiRow = 0
  local skillSSW = ToClient_Fairy_EquipSkillWrraper(self.eFairyMaxEquipSkill - 1)
  if nil ~= skillSSW then
    local skillTypeSSW = skillSSW:getSkillTypeStaticStatusWrapper()
    if nil ~= skillTypeSSW then
      self._ui._skillIconBg[uiRow]:SetShow(true)
      self._ui._skillIcon[uiRow]:ChangeTextureInfoName("Icon/" .. skillTypeSSW:getIconPath())
      self._ui._skillIcon[uiRow]:SetShow(true)
      self._ui._skillDesc[uiRow]:SetText(skillTypeSSW:getDescription())
      UI.setLimitTextAndAddTooltip(self._ui._skillDesc[uiRow], skillTypeSSW:getName(), skillTypeSSW:getDescription())
      self._ui._skillName[uiRow]:SetText(skillTypeSSW:getName())
      self._ui._skillName[uiRow]:SetShow(true)
      self._ui._skillName[uiRow]:SetMonoTone(false)
      self._skillTooltipDesc[uiRow] = skillTypeSSW:getDescription()
      self._ui._skillMasterIcon[uiRow]:SetShow(Toclient_FairySkill_IsMaxLevel(PaGlobal_FairyInfo_GetFairyKey_All(), self.eFairyMaxEquipSkill - 1))
      self._ui._skillIcon[uiRow]:addInputEvent("Mouse_On", "FairyInfo_SkillTooltip_All( true, " .. tostring(uiRow) .. ")")
      self._ui._skillIcon[uiRow]:addInputEvent("Mouse_Out", "FairyInfo_SkillTooltip_All( false, " .. tostring(uiRow) .. ")")
    end
  end
  uiRow = 1
  self._ui.chk_Lantern:SetShow(false)
  if nil ~= self._skillKey then
    for key, value in pairs(self._skillKey) do
      local skillSSW = ToClient_Fairy_EquipSkillWrraper(key)
      if nil ~= skillSSW then
        local skillTypeSSW = skillSSW:getSkillTypeStaticStatusWrapper()
        if nil ~= skillTypeSSW then
          self._ui._skillIconBg[uiRow]:SetShow(true)
          self._ui._skillIcon[uiRow]:ChangeTextureInfoName("Icon/" .. skillTypeSSW:getIconPath())
          self._ui._skillIcon[uiRow]:SetShow(true)
          self._ui._skillDesc[uiRow]:SetTextMode(__eTextMode_LimitText)
          self._ui._skillDesc[uiRow]:SetText(skillTypeSSW:getDescription())
          self._ui._skillMasterIcon[uiRow]:SetShow(Toclient_FairySkill_IsMaxLevel(PaGlobal_FairyInfo_GetFairyKey_All(), key))
          UI.setLimitTextAndAddTooltip(self._ui._skillDesc[uiRow], skillTypeSSW:getName(), skillTypeSSW:getDescription())
          if 10 <= key and key <= 13 and true == isUnseal then
            local remainTime = ToClient_getFairyRemainTime()
            if 0 < remainTime then
              remainTime = tostring(convertSecondsToClockTime(remainTime))
              self._ui._skillName[uiRow]:SetText(skillTypeSSW:getName() .. "  ( " .. PAGetStringParam1(Defines.StringSheet_GAME, "LUA_FAIRYINFO_RESPAWNTIME", "time", remainTime) .. " )")
              self._ui._skillIcon[uiRow]:SetMonoTone(true)
            else
              self._ui._skillName[uiRow]:SetText(skillTypeSSW:getName())
            end
          elseif 14 <= key and key <= 18 and true == isUnseal then
            local remainTime = ToClient_getFairyDesertRemainTime()
            if 0 < remainTime then
              remainTime = tostring(convertSecondsToClockTime(remainTime))
              self._ui._skillName[uiRow]:SetText(skillTypeSSW:getName() .. "  ( " .. PAGetStringParam1(Defines.StringSheet_GAME, "LUA_FAIRYINFO_RESPAWNTIME", "time", remainTime) .. " )")
              self._ui._skillIcon[uiRow]:SetMonoTone(true)
            else
              self._ui._skillName[uiRow]:SetText(skillTypeSSW:getName())
            end
          else
            self._ui._skillName[uiRow]:SetText(skillTypeSSW:getName())
          end
          self._ui._skillName[uiRow]:SetShow(true)
          self._ui._skillName[uiRow]:SetMonoTone(false)
          self._skillTooltipDesc[uiRow] = skillTypeSSW:getDescription()
          self._ui._skillIcon[uiRow]:addInputEvent("Mouse_On", "FairyInfo_SkillTooltip_All( true, " .. tostring(uiRow) .. ")")
          self._ui._skillIcon[uiRow]:addInputEvent("Mouse_Out", "FairyInfo_SkillTooltip_All( false, " .. tostring(uiRow) .. ")")
          if 20 <= key then
            self._learnPotionSkill = true
          end
          if true == isUnseal and 19 == key then
            self._ui.chk_Lantern:SetShow(true)
            self._ui.chk_Lantern:SetCheck(ToClient_isFairyLanternOnOff())
            self._ui.chk_Lantern:SetPosY(self._ui.stc_SkillBG:GetPosY() + self._ui._skillName[uiRow]:GetPosY() - 2)
            self._ui.chk_Lantern:SetPosX(self._ui.stc_SkillBG:GetPosX() + self._ui._skillName[uiRow]:GetPosX() + self._ui._skillName[uiRow]:GetTextSizeX() + 10)
          elseif false == isUnseal and 19 == key then
            Panel_FairyInfo_All:registerPadEvent(__eConsoleUIPadEvent_Up_A, "InputMLClick_FairyInfo_SummonFairy_All()")
          end
          uiRow = uiRow + 1
        end
      end
    end
  end
  if true == _ContentsGroup_RenewUI and true == self._isFairyMaxLevel then
    self._ui_pc.btn_LearnableSkill_pc:SetShow(false)
  end
  if uiRow < 5 then
    if true == self._isFairyMaxLevel then
      self._ui._skillIconBg[uiRow]:SetShow(false)
      self._ui._skillName[uiRow]:SetShow(false)
      self._ui._skillIcon[uiRow]:SetShow(false)
      self._ui._skillMasterIcon[uiRow]:SetShow(false)
    end
    for index = uiRow + 1, 4 do
      self._ui._skillIconBg[index]:SetShow(false)
      self._ui._skillName[index]:SetShow(false)
      self._ui._skillIcon[index]:SetShow(false)
      self._ui._skillMasterIcon[uiRow]:SetShow(false)
    end
  end
  local SettingData = ToClient_getFairySettingData(fairyNo_s64)
  if nil ~= SettingData and true == self._learnPotionSkill then
    local ItemSSW = getItemEnchantStaticStatus(SettingData._hpItemKey)
    self._currentHpKey = SettingData._hpItemKey
    if nil ~= ItemSSW then
      self._ui.stc_HPIcon:ChangeTextureInfoName("Icon/" .. ItemSSW:getIconPath())
      self._ui.stc_HPIcon:SetShow(true)
      self._ui.stc_QuestionMarkHP:SetShow(false)
      if 100 == SettingData._hpMinRate then
        self._ui.txt_HPSet:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_FAIRYINFO_ALWAYS_HPUSE"))
      elseif 0 < SettingData._hpMinRate then
        self._ui.txt_HPSet:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_FAIRYINFO_HPPERCENT", "percent", SettingData._hpMinRate))
      else
        self._ui.txt_HPSet:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_FAIRYINFO_HPNONE"))
      end
    else
      self._ui.txt_HPSet:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_FAIRYINFO_HPNONE"))
      self._ui.stc_HPIcon:SetShow(false)
      self._ui.stc_QuestionMarkHP:SetShow(true)
    end
    ItemSSW = getItemEnchantStaticStatus(SettingData._mpItemKey)
    self._currentMpKey = SettingData._mpItemKey
    if nil ~= ItemSSW then
      self._ui.stc_MPIcon:ChangeTextureInfoName("Icon/" .. ItemSSW:getIconPath())
      self._ui.stc_MPIcon:SetShow(true)
      self._ui.stc_QuestionMarkMP:SetShow(false)
      if 100 == SettingData._mpMinRate then
        self._ui.txt_MPSet:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_FAIRYINFO_ALWAYS_MPUSE"))
      elseif 0 < SettingData._mpMinRate then
        self._ui.txt_MPSet:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_FAIRYINFO_MPPERCENT", "percent", SettingData._mpMinRate))
      else
        self._ui.txt_MPSet:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_FAIRYINFO_MPNONE"))
      end
    else
      self._ui.txt_MPSet:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_FAIRYINFO_MPNONE"))
      self._ui.stc_MPIcon:SetShow(false)
      self._ui.stc_QuestionMarkMP:SetShow(true)
    end
  else
    self._ui.stc_HPIcon:SetShow(false)
    self._ui.stc_MPIcon:SetShow(false)
    self._ui.stc_QuestionMarkHP:SetShow(true)
    self._ui.stc_QuestionMarkMP:SetShow(true)
  end
  if true == self._learnPotionSkill then
    self._ui.stc_PotionLockBG:SetShow(false)
    self._ui.stc_PotionBG:SetShow(true)
    self._ui_console.stc_KeyGuide_X:SetShow(true)
    Panel_FairyInfo_All:registerPadEvent(__eConsoleUIPadEvent_Up_X, "PaGlobal_FairySetting_Open_All(" .. "\"" .. tostring(fairyNo_s64) .. "\"" .. ")")
  else
    self._ui.stc_PotionLockBG:SetShow(true)
    self._ui.stc_PotionBG:SetShow(false)
    self._ui_console.stc_KeyGuide_X:SetShow(false)
    Panel_FairyInfo_All:registerPadEvent(__eConsoleUIPadEvent_Up_X, "")
  end
  self._ui_pc.btn_PotionSetting_pc:addInputEvent("Mouse_On", "PaGlobal_FairyInfo_SimpleTooltip_All(true, 1)")
  self._ui_pc.btn_PotionSetting_pc:addInputEvent("Mouse_Out", "PaGlobal_FairyInfo_SimpleTooltip_All(false)")
  self._ui_pc.btn_PotionSetting_pc:addInputEvent("Mouse_LUp", "PaGlobal_FairySetting_Open_All(" .. "\"" .. tostring(fairyNo_s64) .. "\"" .. ")")
  self._ui.txt_FairyTier:SetText(self._GenerationStr[fairyTier])
  self._ui.txt_FairyName:SetText(self._fairyAttrStr[fairyAttr] .. " " .. fairyName)
  self._ui.txt_Level:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_LV") .. "." .. tostring(fairyLevel))
  self._currentExpRate = fairyExp / MaxExp * 100
  self._ui.txt_Exp:SetText(string.format("%.2f", self._currentExpRate) .. "%")
  self._ui.progress2_Exp:SetProgressRate(self._currentExpRate)
  self._ui.progress2_Exp:SetCurrentProgressRate(self._currentExpRate)
  self._ui.txt_FairyDesc:SetTextMode(__eTextMode_AutoWrap)
  self._ui.txt_FairyDesc:SetText(self._InfoDescStr[fairyTier])
  self._ui_pc.btn_Summon_pc:SetShow(false)
  self._ui_pc.btn_Unsummon_pc:SetShow(false)
  if true == isUnseal then
    self._ui_pc.btn_Unsummon_pc:SetShow(true)
    self._ui_pc.btn_Summon_pc:SetShow(false)
    self._ui_pc.btn_Summon_pc:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_FAIRY_INFO_UNSUMMON"))
    if true ~= self._checkLanternMouseOn then
      self._ui_console.stc_KeyGuide_A:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_FAIRY_INFO_UNSUMMON"))
    end
  else
    self._ui_pc.btn_Unsummon_pc:SetShow(false)
    self._ui_pc.btn_Summon_pc:SetShow(true)
    self._ui_pc.btn_Summon_pc:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_FAIRY_INFO_SUMMON"))
    self._ui_console.stc_KeyGuide_A:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_FAIRY_INFO_SUMMON"))
  end
  PaGlobal_FairyInfo_All:updateFairyLook()
  if true == isUnseal then
    self._ui_pc.btn_ChangeSkill:SetEnable(true)
    self._ui_pc.btn_ChangeSkill:SetMonoTone(false)
    self._ui_console.stc_KeyGuide_RTX:SetShow(true)
  else
    self._ui_pc.btn_ChangeSkill:SetEnable(false)
    self._ui_pc.btn_ChangeSkill:SetMonoTone(true)
    self._ui_console.stc_KeyGuide_RTX:SetShow(false)
  end
  PaGlobal_FairyInfo_All:AlignKeyGuide()
  PaGlobal_FairyChangeSkill_FairySkillUpdate(self._skillKey)
end
function PaGlobal_FairyInfo_All:updateFairyLook()
  if false == _ContentsGroup_FairyLookChange then
    return
  end
  local isDefault = ToClient_getIsFairyDefaultLook()
  if isDefault < 0 then
    return
  end
  local imagePath
  if 1 == isDefault then
    imagePath = PaGlobal_FairyInfo_All._config._defaultMainImagePath
  else
    local currentIndex = ToClient_getCurrentFairyLookIndex()
    local lookData = ToClient_getFairyChangeLookElementByActionIndex(currentIndex)
    if nil ~= lookData then
      imagePath = lookData:getIconPath2()
    end
  end
  self._ui.stc_TitleImage:ChangeTextureInfoName(imagePath)
  local pcFairyData
  if true == isUnseal then
    pcFairyData = ToClient_getFairyUnsealedDataByIndex(0)
  else
    pcFairyData = ToClient_getFairySealedDataByIndex(0)
  end
  if nil == pcFairyData then
    return
  end
  self._iconPath = pcFairyData:getIconPath()
  PaGlobal_FairyTierUpgrade_UpdateIcon_All()
end
function PaGlobal_FairyInfo_All:validate()
  if nil == Panel_FairyInfo_All then
    return
  end
  self._ui.stc_TitleBG:isValidate()
  self._ui_pc.btn_Question_pc:isValidate()
  self._ui_pc.btn_Close_pc:isValidate()
  self._ui.stc_BasicInfoBG:isValidate()
  self._ui.txt_FairyTier:isValidate()
  self._ui.txt_FairyName:isValidate()
  self._ui.stc_LevleInfoBG:isValidate()
  self._ui.txt_Level:isValidate()
  self._ui.txt_Exp:isValidate()
  self._ui.progress2_Exp:isValidate()
  self._ui.txt_FairyDesc:isValidate()
  self._ui_pc.btn_FairyUpgrade_pc:isValidate()
  self._ui_pc.btn_FairyGrowth_pc:isValidate()
  self._ui.stc_PotionBG:isValidate()
  self._ui.stc_HPPotionBG:isValidate()
  self._ui.stc_MPPotionBG:isValidate()
  self._ui.txt_HPSet:isValidate()
  self._ui.txt_MPSet:isValidate()
  self._ui_pc.btn_PotionSetting_pc:isValidate()
  self._ui.stc_PotionLockBG:isValidate()
  self._ui.stc_SkillBG:isValidate()
  for i = 0, self._MaxSkillCount - 1 do
    self._ui._skillIconBg[i]:isValidate()
    self._ui._skillIcon[i]:isValidate()
    self._ui._skillName[i]:isValidate()
    self._ui._skillDesc[i]:isValidate()
    self._ui._skillMasterIcon[i]:isValidate()
  end
  self._ui_pc.btn_LearnableSkill_pc:isValidate()
  self._ui.stc_BottomButtonBG:isValidate()
  self._ui_pc.btn_Rebirth_pc:isValidate()
  self._ui_pc.btn_Summon_pc:isValidate()
  self._ui_pc.btn_Unsummon_pc:isValidate()
  self._ui_pc.btn_Release_pc:isValidate()
  self._ui_pc.btn_SkinChange_pc:isValidate()
  self._ui.chk_Lantern:isValidate()
  self._ui.stc_BottomKeyGuide:isValidate()
  self._ui_console.stc_KeyGuide_LTA:isValidate()
  self._ui_console.stc_KeyGuide_X:isValidate()
  self._ui_console.stc_KeyGuide_Y:isValidate()
  self._ui_console.stc_KeyGuide_A:isValidate()
  self._ui_console.stc_KeyGuide_B:isValidate()
end
function PaGlobal_FairyInfo_All:Clear()
  if nil == Panel_FairyInfo_All then
    return
  end
  for _, value in pairs(self._ui._skillIconBg) do
    value:SetShow(true)
  end
  for _, value in pairs(self._ui._skillIcon) do
    value:SetShow(false)
    value:SetMonoTone(false)
  end
  for _, value in pairs(self._ui._skillName) do
    value:SetShow(true)
    value:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_FAIRY_INFO_NOSKILL"))
    value:SetMonoTone(true)
  end
  for _, value in pairs(self._ui._skillDesc) do
    value:SetShow(true)
    value:SetText(" ")
    value:SetMonoTone(true)
  end
  for _, value in pairs(self._ui._skillMasterIcon) do
    value:SetShow(false)
  end
  self._ui.stc_PotionLockBG:SetShow(true)
  self._fairykey = nil
  self._fairyNo = nil
  self._fairyName = nil
  self._iconPath = nil
  self._skillKey = {}
  self._learnPotionSkill = false
  self._skillTooltipDesc = {}
  self._currentHpKey = nil
  self._currentMpKey = nil
  self._ui.txt_HPSet:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_FAIRYINFO_HPNONE"))
  self._ui.txt_MPSet:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_FAIRYINFO_MPNONE"))
  self._ui_pc.btn_Rebirth_pc:SetIgnore(false)
  self._ui_pc.btn_Rebirth_pc:SetMonoTone(false)
  self._fairyLevel = 0
  self._isFairyMaxLevel = false
  self._currentExpRate = 0
end
function PaGlobal_FairyInfo_All:SetPos()
  if nil == Panel_FairyInfo_All then
    return
  end
  Panel_FairyInfo_All:ComputePos()
end
function PaGlobal_FairyInfo_All:summonFairy()
  if nil == Panel_FairyInfo_All then
    return
  end
  audioPostEvent_SystemUi(1, 40)
  _AudioPostEvent_SystemUiForXBOX(1, 40)
  if nil == self._fairyNo then
    return
  end
  if true == Panel_Window_FairySkill_All:GetShow() then
    PaGlobalFunc_FairySkill_Close_All()
  end
  if true == Panel_Window_FairySetting_All:GetShow() then
    PaGlobal_FairySetting_Close_All()
  end
  if true == self._isUnseal then
    ToClient_requestPetSeal(self._fairyNo)
    if true == Panel_Window_FairyGrowth_All:GetShow() then
      PaGlobal_FairyGrowth_Close_All()
    end
  else
    ToClient_requestPetUnseal(self._fairyNo)
    if nil ~= Panel_Window_FairySkinChange_All and true == Panel_Window_FairySkinChange_All:GetShow() then
      PaGlobal_FairySkinChange_Close_All()
    end
    if true == Panel_Window_FairyChoiceTheReset_All:GetShow() then
      PaGlobal_FairyChoiceTheReset_Close_All()
    end
    if true == _ContentsGroup_FairyTierUpgradeAndRebirth and true == Panel_Window_FairyTierUpgrade_All:GetShow() then
      PaGlobal_FairyTierUpgrade_Close_All()
    end
  end
  if true == self._isUnseal then
    self._ui_pc.btn_ChangeSkill:SetEnable(true)
    self._ui_pc.btn_ChangeSkill:SetMonoTone(false)
    self._ui_console.stc_KeyGuide_RTX:SetShow(true)
  else
    self._ui_pc.btn_ChangeSkill:SetEnable(false)
    self._ui_pc.btn_ChangeSkill:SetMonoTone(true)
    self._ui_console.stc_KeyGuide_RTX:SetShow(false)
  end
  PaGlobal_FairyInfo_All:AlignKeyGuide()
end
function PaGlobal_FairyInfo_All:requestRebirth()
  if nil == Panel_FairyInfo_All then
    return
  end
  PaGlobalFunc_FairySkill_Close_All()
  local FunctionYes = function()
    local self = PaGlobal_FairyInfo_All
    if nil == self._fairyNo then
      return
    end
    if self._fairyLevel < 10 then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrCantRebirthLessLevel"))
      return
    end
    ToClient_FairyRebirth(self._fairyNo, true, false)
  end
  local _title = PAGetString(Defines.StringSheet_GAME, "LUA_WARNING")
  local _contenet = PAGetString(Defines.StringSheet_GAME, "LUA_FAIRY_REBIRTH_ALERT")
  local messageBoxData = {
    title = _title,
    content = _contenet,
    functionYes = FunctionYes,
    functionNo = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageBoxData)
end
function PaGlobal_FairyInfo_All:requestFreedom()
  if nil == Panel_FairyInfo_All then
    return
  end
  local FunctionYes = function()
    local self = PaGlobal_FairyInfo_All
    if nil == self._fairyNo then
      return
    end
    ToClient_FairyFreedom(self._fairyNo)
  end
  local _title = PAGetString(Defines.StringSheet_GAME, "LUA_WARNING")
  local _contenet = PAGetString(Defines.StringSheet_GAME, "LUA_FAIRY_FREEDOM_ALERT")
  local messageBoxData = {
    title = _title,
    content = _contenet,
    functionYes = FunctionYes,
    functionNo = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  if _ContentsGroup_UsePadSnapping then
    MessageBox.showMessageBox(messageBoxData)
  else
    MessageBox.showMessageBox(messageBoxData, nil, nil, false)
  end
end
function PaGlobal_FairyInfo_All:ShowToolTip(isHp, isShow)
  if nil == Panel_FairyInfo_All then
    return
  end
  local itemSSW
  local index = 0
  local control
  if true == isHp then
    itemSSW = getItemEnchantStaticStatus(self._currentHpKey)
    index = 0
    control = self._ui.stc_HPPotionBG
  else
    itemSSW = getItemEnchantStaticStatus(self._currentMpKey)
    index = 1
    control = self._ui.stc_MPPotionBG
  end
  if nil == itemSSW then
    return
  end
  if true == isShow then
    Panel_Tooltip_Item_SetPosition(index, control, "fairyList")
    if false == _ContentsGroup_RenewUI then
      Panel_Tooltip_Item_Show(itemSSW, Panel_FairyInfo_All, true)
    else
      PaGlobalFunc_TooltipInfo_Open(Defines.TooltipDataType.ItemSSWrapper, itemSSW, Defines.TooltipTargetType.ItemWithoutCompare, 0)
    end
  elseif false == _ContentsGroup_RenewUI then
    Panel_Tooltip_Item_hideTooltip()
  else
    PaGlobalFunc_TooltipInfo_Close()
  end
end
function PaGlobal_FairyInfo_All:SimpleTooltip(isShow, tipType)
  if nil == Panel_FairyInfo_All then
    return
  end
  if false == isShow then
    if _ContentsGroup_UsePadSnapping then
      self._checkLanternMouseOn = false
      if 0 < ToClient_getFairyUnsealedList() then
        self._ui_console.stc_KeyGuide_A:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_FAIRY_INFO_UNSUMMON"))
      else
        self._ui_console.stc_KeyGuide_A:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_FAIRY_INFO_SUMMON"))
      end
      Panel_FairyInfo_All:registerPadEvent(__eConsoleUIPadEvent_Up_A, "InputMLClick_FairyInfo_SummonFairy_All()")
      self:AlignKeyGuide()
    end
    TooltipSimple_Hide()
    return
  end
  local control, name, desc
  if 0 == tipType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_FAIRY_INFO_FREEDOM_NAME")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_FAIRY_INFO_FREEDOM_DESC")
    control = self._ui_pc.btn_Release_pc
  elseif 1 == tipType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_FAIRYINFO_POTIONSETTING_TOOLTIP_TITLE")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_FAIRYINFO_POTIONSETTING_TOOLTIP_DESC")
    control = self._ui_pc.btn_PotionSetting_pc
  elseif 2 == tipType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_FAIRYINFO_TOOLTIP_REBIRTH_NAME")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_FAIRYINFO_TOOLTIP_REBIRTH_DESC")
    control = self._ui_pc.btn_Rebirth_pc
  elseif 3 == tipType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_FAIRYINFO_TOOLTIP_GROWTH_NAME")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_FAIRYINFO_TOOLTIP_GROWTH_DESC")
    control = self._ui_pc.btn_FairyGrowth_pc
  elseif 4 == tipType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_FAIRYINFO_TOOLTIP_SUMMON_NAME")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_FAIRYINFO_TOOLTIP_SUMMON_DESC")
    control = self._ui_pc.btn_Summon_pc
  elseif 5 == tipType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_FAIRYINFO_TOOLTIP_UNSUMMON_NAME")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_FAIRYINFO_TOOLTIP_UNSUMMON_DESC")
    control = self._ui_pc.btn_Unsummon_pc
  elseif 6 == tipType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_MENU_REMAKE_MENU_HELP")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_HELPMESSAGE_FAIRY")
    control = self._ui_pc.btn_Question_pc
  elseif 7 == tipType then
    if _ContentsGroup_UsePadSnapping then
      self._ui_console.stc_KeyGuide_A:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_COMMON_CONFIRM"))
      Panel_FairyInfo_All:registerPadEvent(__eConsoleUIPadEvent_Up_A, "")
      self._checkLanternMouseOn = true
    end
    name = PAGetString(Defines.StringSheet_GAME, "LUA_FAIRYINFO_TOOLTIP_LANTERN_NAME")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_FAIRYINFO_TOOLTIP_LANTERN_DESC")
    control = self._ui.chk_Lantern
  elseif 8 == tipType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_FAIRY_INFO_TIERUPGRADE_NAME")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_FAIRY_INFO_TIERUPGRADE_DESC")
    control = self._ui_pc.btn_FairyUpgrade_pc
  elseif 9 == tipType then
    name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_FAIRY_SHOW_SKILL_LIST")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_FAIRY_INFO_SHOW_SKILL_LIST_DESC")
    control = self._ui_pc.btn_LearnableSkill_pc
  elseif 10 == tipType then
    name = PAGetString(Defines.StringSheet_RESOURCE, "INTERACTION_BTN_CHANGELOOK")
    desc = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_FAIRYINFO_SKINCHANGE_DESC")
    control = self._ui_pc.btn_SkinChange_pc
  elseif 11 == tipType then
    name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WORKERCHANGESKILL_TITLE")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_FAIRYINFO_SKILLCHANGE_DESC")
    control = self._ui_pc.btn_ChangeSkill
  end
  TooltipSimple_Show(control, name, desc)
  self:AlignKeyGuide()
end
function PaGlobal_FairyInfo_All:SkillTooltip(isShow, index)
  if nil == Panel_FairyInfo_All then
    return
  end
  if false == isShow then
    TooltipSimple_Hide()
    return
  end
  local uiControl, name, desc
  if false == _ContentsGroup_UsePadSnapping then
    uiControl = self._ui._skillIcon[index]
  else
    uiControl = self._ui._skillName[index]
  end
  name = self._ui._skillName[index]:GetText()
  desc = self._skillTooltipDesc[index]
  TooltipSimple_Show(uiControl, name, desc)
  if true == self._ui._skillMasterIcon[index]:GetShow() then
    TooltipSimple_Show(uiControl, name, desc .. "\n" .. PAGetString(Defines.StringSheet_GAME, "LUA_FAIRY_SKILLTOOLTIP_MASTERSKILL"))
  else
    TooltipSimple_Show(uiControl, name, desc)
  end
end
function PaGlobal_FairyInfo_All:InputFairyNameStart(fromWhereType, fromSlotNo)
  if nil == Panel_FairyInfo_All then
    return
  end
  local selfPlayer = getSelfPlayer()
  local rotation = selfPlayer:get():getRotation()
  self._isAnimate = true
  self._fromWhereType = fromWhereType
  self._fromSlotNo = fromSlotNo
  self._timeStamp = 0
  Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrAppearFairy"))
  if true == _ContentsGroup_NewUI_Inventory_All then
    PaGlobalFunc_Inventory_All_Close()
  else
    HandleClicked_InventoryWindow_Close()
  end
end
function PaGlobal_FairyInfo_All:FairyRegisterAni(deltaTime)
  if nil == Panel_FairyInfo_All then
    return
  end
  if false == self._isAnimate then
    return
  end
  self._timeStamp = self._timeStamp + deltaTime
  if self._const_Ani_Time <= self._timeStamp then
    self._isAnimate = false
    self._timeStamp = 0
    FromClient_InputFairyName_All(self._fromWhereType, self._fromSlotNo)
    self._fromWhereType = 0
    self._fromSlotNo = 0
  end
end
function PaGlobal_FairyInfo_All:openFromAddSealedList(petNo, reason, petType)
  if nil == Panel_FairyInfo_All then
    return
  end
  if false == isFairyByPetNo(petNo) then
    return
  end
  if nil == reason then
    return
  end
  if __ePetType_Fairy == petType then
    self:Clear()
    self:update()
  end
end
function PaGlobal_FairyInfo_All:openFromDelSealedList(petNo)
  if nil == Panel_FairyInfo_All then
    return
  end
  if false == isFairyByPetNo(petNo) and self._fairyNo ~= petNo then
    return
  end
  self:Clear()
  self:update()
  if false == _ContentsGroup_UsePadSnapping then
    PaGlobal_Fairy_SetPosIcon()
  end
  if true == Panel_Window_FairyGrowth_All:GetShow() then
    PaGlobal_FairyGrowth_OnlyUpdate_All()
  end
end
function PaGlobal_FairyInfo_All:openFromDelList(petNo)
  if nil == Panel_FairyInfo_All then
    return
  end
  if false == isFairyByPetNo(petNo) then
    return
  end
  PaGlobal_FairyInfo_All:open()
end
function PaGlobal_FairyInfo_All:checkCamp()
  if nil ~= Panel_Window_Camp_All and Panel_Window_Camp_All:GetShow() then
    return true
  end
  if PaGlobalFunc_CampWarehouse_All_GetShow() then
    return true
  end
  if nil ~= Panel_Dialog_Repair_Function_All and Panel_Dialog_Repair_Function_All:GetShow() then
    return true
  end
  if nil ~= Panel_Dialog_NPCShop_All and Panel_Dialog_NPCShop_All:GetShow() then
    return true
  end
  if nil ~= Panel_Window_BuildingBuff_All and Panel_Window_BuildingBuff_All:GetShow() then
    return true
  end
  return false
end
