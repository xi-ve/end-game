function PaGlobal_PetFusion_All:initialize()
  if true == PaGlobal_PetFusion_All._initialize then
    return
  end
  self._ui.txt_Title = UI.getChildControl(Panel_Window_PetFusion_All, "Static_Text_Title")
  self._ui_pc.btn_Close = UI.getChildControl(Panel_Window_PetFusion_All, "Button_Close_PCUI")
  self._ui.stc_FusionBG = UI.getChildControl(Panel_Window_PetFusion_All, "Static_ComposeBg")
  self._ui.stc_LeaderPetIconBG = UI.getChildControl(self._ui.stc_FusionBG, "Static_Leader_PetIconBg")
  self._ui.stc_LeaderGradeLine = UI.getChildControl(self._ui.stc_LeaderPetIconBG, "Static_LeaderGradeLine")
  self._ui.stc_LeaderPetMarkBG = UI.getChildControl(self._ui.stc_LeaderPetIconBG, "Static_PetMarkBg")
  self._ui.stc_LeaderPetIcon = UI.getChildControl(self._ui.stc_LeaderPetIconBG, "Static_Leader_PetIcon")
  self._ui.txt_LeaderPetTier = UI.getChildControl(self._ui.stc_LeaderPetIconBG, "StaticText_Tier")
  self._ui.txt_LeaderPetLevel = UI.getChildControl(self._ui.stc_LeaderPetIconBG, "StaticText_Level")
  self._mainPetSlotTable = {
    _bg = self._ui.stc_LeaderPetIconBG,
    _grade = self._ui.stc_LeaderGradeLine,
    _mark = self._ui.stc_LeaderPetMarkBG,
    _icon = self._ui.stc_LeaderPetIcon,
    _tier = self._ui.txt_LeaderPetTier,
    _level = self._ui.txt_LeaderPetLevel
  }
  self._ui.stc_PetIconBG_Templete = UI.getChildControl(self._ui.stc_FusionBG, "Static_PetIconBg_Template")
  self._ui.txt_CompletePetGradeLine_Templete = UI.getChildControl(self._ui.stc_PetIconBG_Templete, "Static_GradeLine_Template")
  self._ui.stc_PetIcon_Templete = UI.getChildControl(self._ui.stc_PetIconBG_Templete, "Static_PetIcon")
  self._ui.txt_PetTier_Templete = UI.getChildControl(self._ui.stc_PetIconBG_Templete, "StaticText_Tier")
  self._ui.stc_PetPlusIcon_Templete = UI.getChildControl(self._ui.stc_PetIconBG_Templete, "Static_PlusIcon")
  for ii = 0, self._config._subPetMaxTableCount - 1 do
    local bg = UI.createControl(__ePAUIControl_Static, self._ui.stc_FusionBG, "Static_PetIconBg_" .. ii)
    CopyBaseProperty(self._ui.stc_PetIconBG_Templete, bg)
    local grade = UI.createControl(__ePAUIControl_Static, bg, "Static_GradeLine_" .. ii)
    CopyBaseProperty(self._ui.txt_CompletePetGradeLine_Templete, grade)
    local icon = UI.createControl(__ePAUIControl_Static, bg, "Static_PetIcon_" .. ii)
    CopyBaseProperty(self._ui.stc_PetIcon_Templete, icon)
    local tier = UI.createControl(__ePAUIControl_StaticText, bg, "StaticText_Tier_" .. ii)
    CopyBaseProperty(self._ui.txt_PetTier_Templete, tier)
    local plusicon = UI.createControl(__ePAUIControl_Static, bg, "StaticText_PlusIcon_" .. ii)
    CopyBaseProperty(self._ui.stc_PetPlusIcon_Templete, plusicon)
    bg:SetPosX(bg:GetPosX() + (bg:GetSizeX() + 10) * ii)
    self._subPetSlotTableList[ii] = {}
    self._subPetSlotTableList[ii]._bg = bg
    self._subPetSlotTableList[ii]._grade = grade
    self._subPetSlotTableList[ii]._icon = icon
    self._subPetSlotTableList[ii]._tier = tier
    self._subPetSlotTableList[ii]._plusicon = plusicon
    self._subPetSlotTableList[ii]._isSet = false
    self._subPetSlotTableList[ii]._petNo = -1
  end
  self._ui.stc_PetIconBG_Templete:SetShow(false)
  self._ui.stc_SelectDesc_BG = UI.getChildControl(self._ui.stc_FusionBG, "Static_SelectDescBg")
  self._ui.txt_SelectTitle = UI.getChildControl(self._ui.stc_SelectDesc_BG, "StaticText_SelectTitle")
  self._ui.txt_SelectDesc = UI.getChildControl(self._ui.stc_SelectDesc_BG, "StaticText_SelectDesc")
  self._ui.stc_SelectBG = UI.getChildControl(self._ui.stc_FusionBG, "Static_SelectBg")
  self._ui.stc_SelectLookIconBG = UI.getChildControl(self._ui.stc_SelectBG, "Static_SelectLookIconBg")
  self._ui.stc_SelectLookIcon = UI.getChildControl(self._ui.stc_SelectBG, "Static_SelectLookIcon")
  self._ui.stc_QuestionMarkIcon = UI.getChildControl(self._ui.stc_SelectBG, "StaticText_QuestionMark")
  self._ui.txt_SelectedPetLevel = UI.getChildControl(self._ui.stc_SelectBG, "StaticText_SelectPetLv")
  self._ui.txt_N1Title = UI.getChildControl(self._ui.stc_SelectBG, "StaticText_N1Title")
  self._ui.txt_N1Value = UI.getChildControl(self._ui.stc_SelectBG, "StaticText_N1Value")
  self._ui.progress_N1 = UI.getChildControl(self._ui.stc_SelectBG, "Static_N1_Progress_Value")
  self._ui.txt_N2Title = UI.getChildControl(self._ui.stc_SelectBG, "StaticText_N2Title")
  self._ui.txt_N2Value = UI.getChildControl(self._ui.stc_SelectBG, "StaticText_N2Value")
  self._ui.progress_N2 = UI.getChildControl(self._ui.stc_SelectBG, "Static_N2_Progress_Value")
  self._ui.progress_N2BG = UI.getChildControl(self._ui.stc_SelectBG, "Static_N2_Progress_Hungry_BG")
  self._ui_pc.rdo_SelectLook = UI.getChildControl(self._ui.stc_SelectBG, "RadioButton_SelectLook")
  self._ui_pc.rdo_SelectSkill = UI.getChildControl(self._ui.stc_SelectBG, "RadioButton_SelectSkill")
  self._ui.stc_SelectSkillIconBG = UI.getChildControl(self._ui.stc_SelectBG, "Static_SelectSkillBg")
  for index = 0, self._config._skillSlotMaxCount - 1 do
    self._skillSlotList[index] = UI.getChildControl(self._ui.stc_SelectBG, "Static_SkillPetSlot_" .. index + 1)
    self._skillRandomSlotList[index] = UI.getChildControl(self._ui.stc_SelectBG, "Static_SelectSkillRandomIcon_" .. index + 1)
    self._staticText_SelectSkillDesc[index] = UI.getChildControl(self._ui.stc_SelectBG, "StaticText_SelectSkillIDesc_" .. index + 1)
  end
  self._ui.edit_PetName = UI.getChildControl(self._ui.stc_FusionBG, "Edit_Naming")
  self._ui.txt_FusionDesc = UI.getChildControl(self._ui.stc_FusionBG, "StaticText_Desc")
  self._ui_pc.btn_Yes = UI.getChildControl(self._ui.stc_FusionBG, "Button_Yes_PCUI")
  self._ui_pc.btn_No = UI.getChildControl(self._ui.stc_FusionBG, "Button_No_PCUI")
  self._ui_console.stc_KeyGuideX = UI.getChildControl(self._ui.edit_PetName, "Static_KeyX_Console")
  self._ui.stc_FusionDoneBG = UI.getChildControl(Panel_Window_PetFusion_All, "Static_ComposeDoneBg")
  self._ui.stc_FusionDoneSubBG = UI.getChildControl(self._ui.stc_FusionDoneBG, "Static_SubBg")
  self._ui.txt_CompleteTierChange = UI.getChildControl(self._ui.stc_FusionDoneBG, "StaticText_CompleteTierChange")
  self._ui.stc_Effect_Bottom = UI.getChildControl(self._ui.stc_FusionDoneBG, "Static_Effect_Bottom")
  self._ui.stc_CompletePetIcon = UI.getChildControl(self._ui.stc_FusionDoneBG, "Static_ComposePetIcon")
  self._ui.stc_Effect = UI.getChildControl(self._ui.stc_FusionDoneBG, "Static_Effect")
  self._ui.txt_CompletePetGrade = UI.getChildControl(self._ui.stc_FusionDoneBG, "StaticText_Grade")
  self._ui.txt_PetNameLevel = UI.getChildControl(self._ui.stc_FusionDoneBG, "StaticText_PetNameLevel")
  self._ui.txt_SpecialSkill = UI.getChildControl(self._ui.stc_FusionDoneBG, "StaticText_SpecialSkill")
  self._ui_pc.btn_Compelte_Confirm = UI.getChildControl(self._ui.stc_FusionDoneBG, "Button_Confirm")
  self._ui.stc_GradeLine = UI.getChildControl(self._ui.stc_FusionDoneBG, "Static_GradeLine")
  self._ui.stc_CompleteEffectBG = UI.getChildControl(self._ui.stc_FusionDoneBG, "Static_CompleteEffectBg")
  self._ui.txt_CompleteMessage = UI.getChildControl(self._ui.stc_CompleteEffectBG, "StaticText_CompleteMessage")
  for index = 0, self._config._skillSlotMaxCount - 1 do
    self._completeSkillTableList[index] = {}
    self._completeSkillTableList[index]._iconBg = UI.getChildControl(self._ui.stc_FusionDoneBG, "Static_SkillBg_" .. index + 1)
    self._completeSkillTableList[index]._icon = UI.getChildControl(self._ui.stc_FusionDoneBG, "Static_SkillIcon_" .. index + 1)
    self._completeSkillTableList[index]._desc = UI.getChildControl(self._ui.stc_FusionDoneBG, "StaticText_SkillDesc_" .. index + 1)
  end
  self._ui.stc_SelectLookBG = UI.getChildControl(Panel_Window_PetFusion_All, "Static_PetSkinListBg")
  self._ui.list2_Look = UI.getChildControl(self._ui.stc_SelectLookBG, "List2_PetSkinList")
  self._ui_pc.btn_SelectLook_Close = UI.getChildControl(self._ui.stc_SelectLookBG, "Button_PetSkinListClose_PCUI")
  self._ui_console.stc_SelectLook_KeyGuideBG = UI.getChildControl(self._ui.stc_SelectLookBG, "Static_BottomKeyBG")
  self._ui_console.stc_SelectLook_KeyGuideA = UI.getChildControl(self._ui_console.stc_SelectLook_KeyGuideBG, "StaticText_Confirm_ConsoleUI")
  self._ui_console.stc_SelectLook_KeyGuideB = UI.getChildControl(self._ui_console.stc_SelectLook_KeyGuideBG, "StaticText_Cancel_ConsoleUI")
  self._ui.stc_SelectSkillBG = UI.getChildControl(Panel_Window_PetFusion_All, "Static_PetSkillListBg")
  self._ui.list2_Skill = UI.getChildControl(self._ui.stc_SelectSkillBG, "List2_PetSkillList")
  self._ui_pc.btn_SelectSkill_Close = UI.getChildControl(self._ui.stc_SelectSkillBG, "Button_PetSkillListClose_PCUI")
  self._ui_console.stc_SelectSkill_KeyGuideBG = UI.getChildControl(self._ui.stc_SelectSkillBG, "Static_BottomKeyBG")
  self._ui_console.stc_SelectSkill_KeyGuideA = UI.getChildControl(self._ui_console.stc_SelectSkill_KeyGuideBG, "StaticText_Confirm_ConsoleUI")
  self._ui_console.stc_SelectSkill_KeyGuideB = UI.getChildControl(self._ui_console.stc_SelectSkill_KeyGuideBG, "StaticText_Cancel_ConsoleUI")
  self._ui_console.stc_Bottom_KeyGuideBG = UI.getChildControl(Panel_Window_PetFusion_All, "Static_BottomKeyBG")
  self._ui_console.txt_KeyGuideY = UI.getChildControl(self._ui_console.stc_Bottom_KeyGuideBG, "StaticText_Exchange_ConsoleUI")
  self._ui_console.txt_KeyGuideA = UI.getChildControl(self._ui_console.stc_Bottom_KeyGuideBG, "StaticText_Confirm_ConsoleUI")
  self._ui_console.txt_KeyGuideB = UI.getChildControl(self._ui_console.stc_Bottom_KeyGuideBG, "StaticText_Cancel_ConsoleUI")
  self._isConsole = _ContentsGroup_UsePadSnapping
  self._ui.txt_FusionDesc:SetTextMode(__eTextMode_AutoWrap)
  self._ui.txt_FusionDesc:SetText(PAGetString(Defines.StringSheet_GAME, "PANEL_PETLIST_PETCOMPOSE_DESC"))
  self._config._infoTextsizeGap = self._ui.txt_FusionDesc:GetTextSizeY() - self._ui.txt_FusionDesc:GetSizeY()
  self._ui.txt_SelectDesc:SetTextMode(__eTextMode_AutoWrap)
  self._ui.txt_SelectDesc:SetText(self._ui.txt_SelectDesc:GetText())
  if 0 < self._config._infoTextsizeGap then
    Panel_Window_PetFusion_All:SetSize(Panel_Window_PetFusion_All:GetSizeX(), Panel_Window_PetFusion_All:GetSizeY() + self._config._infoTextsizeGap)
    self._ui.stc_FusionBG:SetSize(self._ui.stc_FusionBG:GetSizeX(), self._ui.stc_FusionBG:GetSizeY() + self._config._infoTextsizeGap)
    self._ui.stc_FusionDoneBG:SetSize(self._ui.stc_FusionDoneBG:GetSizeX(), self._ui.stc_FusionDoneBG:GetSizeY() + self._config._infoTextsizeGap)
    self._ui.stc_CompleteEffectBG:SetSize(self._ui.stc_CompleteEffectBG:GetSizeX(), self._ui.stc_CompleteEffectBG:GetSizeY() + self._config._infoTextsizeGap)
    self._ui_pc.btn_Yes:ComputePos()
    self._ui_pc.btn_No:ComputePos()
    self._ui_pc.btn_Compelte_Confirm:ComputePos()
    self._ui.stc_SelectSkillBG:ComputePos()
    self._ui.stc_SelectLookBG:ComputePos()
  end
  self._ui.stc_SelectDesc_BG:SetSize(self._ui.stc_SelectDesc_BG:GetSizeX(), self._ui.txt_SelectDesc:GetTextSizeY() + self._ui.txt_SelectDesc:GetPosY())
  self._ui.stc_SelectDesc_BG:ComputePos()
  self._ui.stc_SelectSkillBG:SetPosX(-1 * (self._ui.stc_SelectSkillBG:GetSizeX() / 2))
  self._ui.stc_SelectLookBG:SetPosX(-1 * (self._ui.stc_SelectLookBG:GetSizeX() / 2))
  self._ui_console.stc_Bottom_KeyGuideBG:ComputePos()
  local textSizeX = self._ui_pc.rdo_SelectLook:GetTextSizeX()
  local btnSizeX = self._ui_pc.rdo_SelectLook:GetSizeX()
  if textSizeX > btnSizeX then
    self._ui_pc.rdo_SelectLook:SetSize(textSizeX + 10, self._ui_pc.rdo_SelectLook:GetSizeY())
  end
  self._ui.txt_SelectedPetLevel:SetTextMode(__eTextMode_AutoWrap)
  PaGlobal_PetFusion_All:platformSetting()
  PaGlobal_PetFusion_All:registEventHandler()
  PaGlobal_PetFusion_All:validate()
  PaGlobal_PetFusion_All._initialize = true
end
function PaGlobal_PetFusion_All:resizeOnConsole()
  if false == self._isConsole then
    return
  end
  if self._isFusionStart then
    Panel_Window_PetFusion_All:SetSize(Panel_Window_PetFusion_All:GetSizeX(), self._smallPanelSizeY)
    self._ui.stc_FusionDoneBG:SetSize(self._ui.stc_FusionDoneBG:GetSizeX(), self._smallPanelSizeY)
    self._ui.stc_CompleteEffectBG:SetSize(self._ui.stc_CompleteEffectBG:GetSizeX(), self._smallPanelSizeY)
    Panel_Window_PetFusion_All:SetPosY(Panel_Window_PetList_All:GetPosY())
  else
    Panel_Window_PetFusion_All:SetSize(Panel_Window_PetFusion_All:GetSizeX(), self._bigPanelSizeY)
    self._ui.stc_CompleteEffectBG:SetSize(self._ui.stc_CompleteEffectBG:GetSizeX(), self._bigPanelSizeY)
    Panel_Window_PetFusion_All:SetPosY((getOriginScreenSizeY() - Panel_Window_PetFusion_All:GetSizeY()) / 2)
  end
  self._ui_console.stc_Bottom_KeyGuideBG:ComputePos()
end
function PaGlobal_PetFusion_All:platformSetting()
  if nil == Panel_Window_PetFusion_All then
    return
  end
  for _, control in pairs(self._ui_pc) do
    control:SetShow(not self._isConsole)
  end
  for _, control in pairs(self._ui_console) do
    control:SetShow(self._isConsole)
  end
  if self._isConsole then
    local keyGuides = {
      self._ui_console.txt_KeyGuideY,
      self._ui_console.txt_KeyGuideA,
      self._ui_console.txt_KeyGuideB
    }
    PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyGuides, self._ui_console.stc_Bottom_KeyGuideBG, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHT)
    keyGuides = {
      self._ui_console.stc_SelectLook_KeyGuideA,
      self._ui_console.stc_SelectLook_KeyGuideB
    }
    PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyGuides, self._ui_console.stc_SelectLook_KeyGuideBG, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHT)
    keyGuides = {
      self._ui_console.stc_SelectSkill_KeyGuideA,
      self._ui_console.stc_SelectSkill_KeyGuideB
    }
    PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyGuides, self._ui_console.stc_SelectSkill_KeyGuideBG, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHT)
    self._bigPanelSizeY = Panel_Window_PetFusion_All:GetSizeY()
    self._smallPanelSizeY = self._ui.stc_FusionDoneSubBG:GetSizeY() + self._ui_console.stc_Bottom_KeyGuideBG:GetSizeY()
  else
    self._ui.stc_SelectLookIconBG:SetIgnore(true)
    self._ui.stc_SelectSkillIconBG:SetIgnore(true)
  end
end
function PaGlobal_PetFusion_All:registEventHandler()
  if nil == Panel_Window_PetFusion_All then
    return
  end
  registerEvent("FromClient_PetFusionResult", "FromClient_PetFusionResult_All")
  registerEvent("FromClient_FusionComplete", "FromClient_FusionComplete_All")
  self._ui.list2_Skill:registEvent(__ePAUIList2EventType_LuaChangeContent, "PaGlobal_PetFusion_CreateSkillList_All")
  self._ui.list2_Skill:createChildContent(__ePAUIList2ElementManagerType_List)
  self._ui.list2_Look:registEvent(__ePAUIList2EventType_LuaChangeContent, "PaGlobal_PetFusion_CreateLookList_All")
  self._ui.list2_Look:createChildContent(__ePAUIList2ElementManagerType_List)
  if self._isConsole then
    self._ui.stc_SelectLookIconBG:addInputEvent("Mouse_LUp", "HandleEventLUp_PetFusion_OpenSelectLook_All()")
    self._ui.stc_SelectSkillIconBG:addInputEvent("Mouse_LUp", "HandleEventLUp_PetFusion_OpenSelectSkill_All()")
    Panel_Window_PetFusion_All:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandleEventLUp_PetFusion_ClearEdit_All()")
    Panel_Window_PetFusion_All:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "HandleEventLUp_PetFusion_Fusion_All()")
    self._ui.edit_PetName:setXboxVirtualKeyBoardEndEvent("Input_PetFusion_All_VirtualKeyboardEnd")
  else
    self._ui_pc.btn_Yes:addInputEvent("Mouse_LUp", "HandleEventLUp_PetFusion_Fusion_All()")
    self._ui_pc.btn_No:addInputEvent("Mouse_LUp", "PaGlobal_PetFusion_Close_All()")
    self._ui_pc.btn_Close:addInputEvent("Mouse_LUp", "PaGlobal_PetFusion_Close_All()")
    self._ui_pc.btn_Compelte_Confirm:addInputEvent("Mouse_LUp", "PaGlobal_PetFusion_Close_All()")
    self._ui.edit_PetName:addInputEvent("Mouse_LUp", "HandleEventLUp_PetFusion_ClearEdit_All()")
    self._ui_pc.rdo_SelectLook:addInputEvent("Mouse_LUp", "HandleEventLUp_PetFusion_OpenSelectLook_All()")
    self._ui_pc.rdo_SelectSkill:addInputEvent("Mouse_LUp", "HandleEventLUp_PetFusion_OpenSelectSkill_All()")
    self._ui_pc.btn_SelectLook_Close:addInputEvent("Mouse_LUp", "HandleEventLUp_PetFusion_CloseSelectLook_All()")
    self._ui_pc.btn_SelectSkill_Close:addInputEvent("Mouse_LUp", "HandleEventLUp_PetFusion_CloseSelectSkill_All()")
  end
end
function PaGlobal_PetFusion_All:prepareOpen()
  if nil == Panel_Window_PetFusion_All then
    return
  end
  self:clear()
  self:setPos()
  self:PetFusionInitControlSetting(true)
  PaGlobal_PetFusion_All:open()
end
function PaGlobal_PetFusion_All:open()
  if nil == Panel_Window_PetFusion_All then
    return
  end
  Panel_Window_PetFusion_All:SetShow(true)
end
function PaGlobal_PetFusion_All:prepareClose(forceClose)
  if nil == Panel_Window_PetFusion_All then
    return
  end
  TooltipSimple_Hide()
  if self._isConsole and true ~= forceClose then
    if self._isFusion or self._isFusion then
      return
    end
    if self._ui.stc_SelectLookBG:GetShow() then
      self:closeSelectLookBG()
      return
    end
    if self._ui.stc_SelectSkillBG:GetShow() then
      self:closeSelectSkillBG()
      return
    end
    if PaGlobal_PetFusion_IsMainPetSet_All() and false == PaGlobal_PetFusion_All._ui.stc_FusionDoneBG:GetShow() then
      self:clear()
      PaGlobal_PetList_All:SetPetList(true)
      return
    end
  end
  self:clear()
  self._ui_pc.btn_Close:SetShow(true)
  self._ui.txt_CompleteTierChange:SetShow(false)
  PaGlobal_PetList_All:SetPetList(self._isConsole)
  HandleEventMouseOut_PetList_Hide_SkillToolTip_All()
  self._ui.stc_CompleteEffectBG:SetShow(true)
  self._ui.stc_CompleteEffectBG:SetAlpha(1)
  self._ui.txt_CompleteMessage:SetAlpha(1)
  self._ui.txt_CompleteMessage:SetShow(true)
  self:closeSelectLookBG()
  self:closeSelectSkillBG()
  PaGlobal_PetList_All:setIgnoreAllSealBtns(false)
  Panel_Window_PetFusion_All:ClearUpdateLuaFunc()
  PaGlobal_PetFusion_All:close()
end
function PaGlobal_PetFusion_All:close()
  if nil == Panel_Window_PetFusion_All then
    return
  end
  Panel_Window_PetFusion_All:SetShow(false)
end
function PaGlobal_PetFusion_All:validate()
  if nil == Panel_Window_PetFusion_All then
    return
  end
  self._ui_pc.btn_Close:isValidate()
  self._ui.stc_FusionBG:isValidate()
  self._ui.stc_LeaderPetIconBG:isValidate()
  self._ui.stc_LeaderGradeLine:isValidate()
  self._ui.stc_LeaderPetMarkBG:isValidate()
  self._ui.stc_LeaderPetIcon:isValidate()
  self._ui.txt_LeaderPetTier:isValidate()
  self._ui.txt_LeaderPetLevel:isValidate()
  self._ui.stc_PetIconBG_Templete:isValidate()
  self._ui.txt_CompletePetGradeLine_Templete:isValidate()
  self._ui.stc_PetIcon_Templete:isValidate()
  self._ui.txt_PetTier_Templete:isValidate()
  self._ui.stc_PetPlusIcon_Templete:isValidate()
  for ii = 0, self._config._subPetMaxTableCount - 1 do
    self._subPetSlotTableList[ii]._bg:isValidate()
    self._subPetSlotTableList[ii]._grade:isValidate()
    self._subPetSlotTableList[ii]._icon:isValidate()
    self._subPetSlotTableList[ii]._tier:isValidate()
    self._subPetSlotTableList[ii]._plusicon:isValidate()
  end
  self._ui.stc_SelectDesc_BG:isValidate()
  self._ui.txt_SelectTitle:isValidate()
  self._ui.txt_SelectDesc:isValidate()
  self._ui.stc_SelectBG:isValidate()
  self._ui.stc_SelectLookIcon:isValidate()
  self._ui.stc_QuestionMarkIcon:isValidate()
  self._ui.txt_SelectedPetLevel:isValidate()
  self._ui.txt_N1Title:isValidate()
  self._ui.txt_N1Value:isValidate()
  self._ui.progress_N1:isValidate()
  self._ui.txt_N2Title:isValidate()
  self._ui.txt_N2Value:isValidate()
  self._ui.progress_N2:isValidate()
  self._ui_pc.rdo_SelectLook:isValidate()
  self._ui_pc.rdo_SelectSkill:isValidate()
  for index = 0, self._config._skillSlotMaxCount - 1 do
    self._skillSlotList[index]:isValidate()
    self._skillRandomSlotList[index]:isValidate()
    self._staticText_SelectSkillDesc[index]:isValidate()
  end
  self._ui.edit_PetName:isValidate()
  self._ui.txt_FusionDesc:isValidate()
  self._ui_pc.btn_Yes:isValidate()
  self._ui_pc.btn_No:isValidate()
  self._ui.stc_FusionDoneBG:isValidate()
  self._ui.txt_CompleteTierChange:isValidate()
  self._ui.stc_Effect_Bottom:isValidate()
  self._ui.stc_CompletePetIcon:isValidate()
  self._ui.stc_Effect:isValidate()
  self._ui.txt_CompletePetGrade:isValidate()
  self._ui.txt_PetNameLevel:isValidate()
  self._ui.txt_SpecialSkill:isValidate()
  self._ui_pc.btn_Compelte_Confirm:isValidate()
  self._ui.stc_GradeLine:isValidate()
  self._ui.stc_CompleteEffectBG:isValidate()
  self._ui.txt_CompleteMessage:isValidate()
  for index = 0, self._config._skillSlotMaxCount - 1 do
    self._completeSkillTableList[index]._iconBg:isValidate()
    self._completeSkillTableList[index]._icon:isValidate()
    self._completeSkillTableList[index]._desc:isValidate()
  end
  self._ui.stc_SelectLookBG:isValidate()
  self._ui.list2_Look:isValidate()
  self._ui_pc.btn_SelectLook_Close:isValidate()
  self._ui.stc_SelectSkillBG:isValidate()
  self._ui.list2_Skill:isValidate()
  self._ui_pc.btn_SelectSkill_Close:isValidate()
  self._ui_console.stc_Bottom_KeyGuideBG:isValidate()
  self._ui_console.txt_KeyGuideY:isValidate()
  self._ui_console.txt_KeyGuideA:isValidate()
  self._ui_console.txt_KeyGuideB:isValidate()
end
function PaGlobal_PetFusion_All:clear()
  if nil == Panel_Window_PetFusion_All then
    return
  end
  self._mainPetSlotTable._bg:SetIgnore(true)
  self._mainPetSlotTable._grade:SetShow(false)
  self._mainPetSlotTable._icon:SetShow(false)
  self._mainPetSlotTable._tier:SetShow(false)
  self._mainPetSlotTable._level:SetShow(false)
  self._mainPetSlotTable._mark:SetShow(true)
  self._mainPetSlotTable._petNo = -1
  self._mainPetSlotTable._isSet = false
  for _, slot in pairs(self._subPetSlotTableList) do
    slot._bg:SetIgnore(true)
    slot._grade:SetShow(false)
    slot._icon:SetShow(false)
    slot._tier:SetShow(false)
    slot._plusicon:SetShow(true)
    slot._isSet = false
    slot._petNo = -1
  end
  for _, control in pairs(self._staticText_SelectSkillDesc) do
    control:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_PET_COMPOSE_SKILLSELECT_NEW_DESC"))
  end
  self._isFourTier = false
  self._mainPetTier = -1
  self._mainRace = nil
  self._mainIsJokerPetUse = false
  self._isFusionAble = false
  self._currentLookIndex = 0
  self._currentSkillIndex = 0
  self._currentSkillPetNo = toInt64(0, -1)
  self._currentLookPetNo = toInt64(0, -1)
  self:listClear()
  self:rateClear()
  self._ui.stc_SelectLookIcon:SetShow(false)
  self._ui.stc_QuestionMarkIcon:SetShow(true)
  for _, control in pairs(self._skillSlotList) do
    control:SetShow(false)
  end
  self._ui.edit_PetName:SetEditText("", true)
  self._ui.edit_PetName:SetText(self._config._defaultName)
  self._ui.txt_SelectedPetLevel:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_LV") .. "." .. tostring(0))
  self._ui.stc_FusionBG:SetShow(true)
  self._ui.txt_Title:SetShow(true)
  self._ui_pc.btn_Close:SetShow(not self._isConsole)
  self._ui.stc_FusionDoneBG:SetShow(false)
  self:closeSelectLookBG()
  self:closeSelectSkillBG()
  self._fusionStartDelayTime = 0
  self._isFusionStart = false
  self._completeDelayTime = 0
  self._isFusion = false
  self._ui.txt_CompletePetGrade:SetText("")
  self._ui.txt_PetNameLevel:SetText("")
  self._ui.txt_SpecialSkill:SetText("")
  for index = 0, self._config._skillSlotMaxCount - 1 do
    self._completeSkillTableList[index]._icon:ChangeTextureInfoName("")
    self._completeSkillTableList[index]._desc:SetText("")
  end
  self._ui.stc_CompleteEffectBG:EraseAllEffect()
  self._ui.stc_CompletePetIcon:ChangeTextureInfoName("")
  self._ui.stc_Effect:EraseAllEffect()
  self._ui.stc_Effect_Bottom:EraseAllEffect()
  self._ui.txt_CompletePetGrade:ChangeTextureInfoName("")
  self._ui.txt_CompleteTierChange:EraseAllEffect()
  self._ui.txt_CompleteTierChange:SetText("")
  self._ui.stc_CompleteEffectBG:SetAlpha(1)
  self._ui.stc_CompleteEffectBG:SetShow(true)
  self._ui.stc_GradeLine:SetShow(false)
  if self._isConsole then
    self._ui_console.txt_KeyGuideY:SetShow(true)
    self._ui_console.txt_KeyGuideA:SetShow(true)
    self._ui_console.txt_KeyGuideB:SetShow(true)
    ToClient_padSnapSetTargetPanel(Panel_Window_PetList_All)
    Panel_Window_PetFusion_All:ignorePadSnapMoveToOtherPanelUpdate(true)
    self:resizeOnConsole()
  end
end
function PaGlobal_PetFusion_All:listClear()
  if nil == Panel_Window_PetFusion_All then
    return
  end
  for index = 0, self._config._petMaxTableCount - 1 do
    self._petNoList[index] = -1
    self._sealPetIndexList[index] = -1
  end
end
function PaGlobal_PetFusion_All:rateClear()
  if nil == Panel_Window_PetFusion_All then
    return
  end
  self._ui.txt_N1Title:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_SERVANT_TIER", "tier", 0))
  self._ui.txt_N2Title:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_SERVANT_TIER", "tier", 0))
  self._ui.txt_N1Title:SetFontColor(Defines.Color.C_FFEFEFEF)
  self._ui.txt_N2Title:SetFontColor(Defines.Color.C_FFEFEFEF)
  self._ui.txt_N1Value:SetText(0 .. "%")
  self._ui.txt_N2Value:SetText(0 .. "%")
  self._ui.progress_N1:SetProgressRate(0)
  self._ui.progress_N2:SetProgressRate(0)
  self._currentRate = 0
end
function PaGlobal_PetFusion_All:setPos()
  if nil == Panel_Window_PetFusion_All then
    return
  end
  Panel_Window_PetFusion_All:SetPosX(Panel_Window_PetList_All:GetPosX() + Panel_Window_PetList_All:GetSizeX() + 5)
  Panel_Window_PetFusion_All:SetPosY((getOriginScreenSizeY() - Panel_Window_PetFusion_All:GetSizeY()) / 2)
end
function PaGlobal_PetFusion_All:PetFusionInitControlSetting(isOn)
  self._ui.stc_SelectDesc_BG:SetShow(isOn)
  self._ui.stc_SelectBG:SetShow(not isOn)
  self._ui.edit_PetName:SetShow(not isOn)
  self._ui_pc.btn_Yes:SetShow(not isOn and not self._isConsole)
  self._ui_pc.btn_No:SetShow(not isOn and not self._isConsole)
  self._ui.txt_FusionDesc:SetShow(not isOn)
end
function PaGlobal_PetFusion_All:openSelectLookBG()
  if true == PaGlobal_PetFusion_IsEmpty_All() then
    self._ui_pc.rdo_SelectLook:SetCheck(false)
    return
  end
  self:loadLookData()
  self:createLookSlot()
  self:closeSelectSkillBG()
  self._ui.stc_SelectLookBG:SetShow(true)
end
function PaGlobal_PetFusion_All:closeSelectLookBG()
  self._ui_pc.rdo_SelectLook:SetCheck(false)
  self._ui.stc_SelectLookBG:SetShow(false)
end
function PaGlobal_PetFusion_All:loadLookData()
  self._lookDataTableList = {}
  self._lookDataTableList[0] = {}
  local count = 1
  for index = 0, self._config._petMaxTableCount - 1 do
    if -1 ~= self._petNoList[index] then
      for sealPetIndex = 0, ToClient_getPetSealedList() - 1 do
        local petData = ToClient_getPetSealedDataByIndex(sealPetIndex)
        local staticStatus = petData:getPetStaticStatus()
        local _petNo = petData._petNo
        if self._petNoList[index] == _petNo and 99 ~= staticStatus:getPetRace() then
          local iconPath = petData:getIconPath()
          self._lookDataTableList[count] = {}
          self._lookDataTableList[count]._iconPath = iconPath
          self._lookDataTableList[count]._petNo = self._petNoList[index]
          count = count + 1
        end
      end
    end
  end
end
function PaGlobal_PetFusion_All:createLookSlot()
  self._ui.list2_Look:getElementManager():clearKey()
  for index = 0, #self._lookDataTableList / 3 do
    self._ui.list2_Look:getElementManager():pushKey(toInt64(0, index))
  end
end
function PaGlobal_PetFusion_All:createLookList(content, key)
  local key = Int64toInt32(key)
  local leftKey = key * 3
  local centerKey = key * 3 + 1
  local rightKey = key * 3 + 2
  local leftData = self._lookDataTableList[leftKey]
  local centerData = self._lookDataTableList[centerKey]
  local rightData = self._lookDataTableList[rightKey]
  if nil == leftData then
    self._ui.list2_Look:getElementManager():removeKey(toInt64(0, key))
    return
  end
  local leftIcon = UI.getChildControl(content, "Static_PetIconLeft")
  local centerIcon = UI.getChildControl(content, "Static_PetIconCenter")
  local rightIcon = UI.getChildControl(content, "Static_PetIconRight")
  local leftIconBg = UI.getChildControl(content, "Static_PetIconBgLeft")
  local centerIconBg = UI.getChildControl(content, "Static_PetIconBgCenter")
  local rightIconBg = UI.getChildControl(content, "Static_PetIconBgRight")
  local randomIcon = UI.getChildControl(content, "Static_RandomIcon")
  if 0 == leftKey then
    leftIcon:SetShow(false)
    randomIcon:SetShow(true)
    leftIconBg:addInputEvent("Mouse_LUp", "HandleEventLUp_PetFusion_LookSelect_All()")
  else
    randomIcon:SetShow(false)
    leftIcon:SetShow(true)
    leftIcon:ChangeTextureInfoName(leftData._iconPath)
    leftIconBg:addInputEvent("Mouse_LUp", "HandleEventLUp_PetFusion_LookSelect_All( \"" .. tostring(leftData._petNo) .. "\")")
  end
  if nil == centerData then
    centerIcon:SetShow(false)
    centerIconBg:SetShow(false)
  else
    centerIcon:ChangeTextureInfoName(centerData._iconPath)
    centerIcon:SetShow(true)
    centerIconBg:SetShow(true)
    centerIconBg:addInputEvent("Mouse_LUp", "HandleEventLUp_PetFusion_LookSelect_All( \"" .. tostring(centerData._petNo) .. "\")")
  end
  if nil == rightData then
    rightIconBg:SetShow(false)
    rightIcon:SetShow(false)
  else
    rightIcon:SetShow(true)
    rightIcon:ChangeTextureInfoName(rightData._iconPath)
    rightIconBg:SetShow(true)
    rightIconBg:addInputEvent("Mouse_LUp", "HandleEventLUp_PetFusion_LookSelect_All( \"" .. tostring(rightData._petNo) .. "\")")
  end
end
function PaGlobal_PetFusion_All:lookSelect(petNoStr)
  local petNo = toInt64(0, -1)
  if nil ~= petNoStr then
    petNo = tonumber64(petNoStr)
  end
  local function confirm_look()
    self._currentLookIndex = self:findPetIndex(petNo) + 1
    self._currentLookPetNo = petNo
    self:updateLookSlot()
    self:closeSelectLookBG()
  end
  if nil == petNoStr then
    self._currentLookIndex = 0
    self._currentLookPetNo = toInt64(0, -1)
    self:updateLookSlot()
    self:closeSelectLookBG()
  else
    local mainPetStaticStatus = self:getStaticStatusByPetNo(self._petNoList[0])
    local subPetStaticStatus = self:getStaticStatusByPetNo(petNo)
    if nil == mainPetStaticStatus or nil == subPetStaticStatus then
      return
    end
    if mainPetStaticStatus:getPetRace() ~= subPetStaticStatus:getPetRace() then
      local messageBoxMemo = PAGetString(Defines.StringSheet_GAME, "LUA_PETFUSION_CAUTION_MESSAGE_DESC")
      local messageBoxData = {
        title = PAGetString(Defines.StringSheet_GAME, "PANEL_SERVANTMIX_TITLE"),
        content = messageBoxMemo,
        functionYes = confirm_look,
        functionNo = MessageBox_Empty_function,
        priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
      }
      MessageBox.showMessageBox(messageBoxData)
    else
      confirm_look()
    end
  end
end
function PaGlobal_PetFusion_All:updateLookSlot()
  self._ui.stc_SelectLookIcon:SetShow(false)
  self._ui.stc_QuestionMarkIcon:SetShow(true)
  if 0 == self._currentLookIndex then
    return
  end
  local selectPetNo = self._currentLookPetNo
  if -1 == selectPetNo then
    return
  end
  for sealPetIndex = 0, ToClient_getPetSealedList() - 1 do
    local petData = ToClient_getPetSealedDataByIndex(sealPetIndex)
    local _petNo = petData._petNo
    if nil ~= _petNo and selectPetNo == _petNo then
      local petSS = petData:getPetStaticStatus()
      local iconPath = petData:getIconPath()
      self._ui.stc_SelectLookIcon:ChangeTextureInfoName(iconPath)
      self._ui.stc_SelectLookIcon:SetShow(true)
      self._ui.stc_QuestionMarkIcon:SetShow(false)
      return
    end
  end
end
function PaGlobal_PetFusion_All:openSelectSkillBG()
  if true == PaGlobal_PetFusion_IsEmpty_All() then
    self._ui_pc.rdo_SelectSkill:SetCheck(false)
    return
  end
  self:loadSkillData()
  self:createSkillSlot()
  self:closeSelectLookBG()
  self._ui.stc_SelectSkillBG:SetShow(true)
end
function PaGlobal_PetFusion_All:closeSelectSkillBG()
  self._ui_pc.rdo_SelectSkill:SetCheck(false)
  self._ui.stc_SelectSkillBG:SetShow(false)
  Panel_SkillTooltip_Hide()
end
function PaGlobal_PetFusion_All:loadSkillData()
  self._skillDataTableList = {}
  self._skillDataTableList[0] = {}
  local count = 1
  local petIndex = 1
  for index = 0, self._config._petMaxTableCount - 1 do
    if -1 ~= self._petNoList[index] then
      for sealPetIndex = 0, ToClient_getPetSealedList() - 1 do
        local petData = ToClient_getPetSealedDataByIndex(sealPetIndex)
        local _petNo = petData._petNo
        if self._petNoList[index] == _petNo then
          local skillLearnCount = 0
          local skillMaxCount = ToClient_getPetEquipSkillMax()
          local petSkillCheck = {}
          self._skillDataTableList[count] = {}
          self._skillDataTableList[count]._iconPath = {}
          self._skillDataTableList[count]._skillName = {}
          self._skillDataTableList[count]._skillIndex = {}
          self._skillDataTableList[count]._skillLearnCount = 0
          self._skillDataTableList[count]._petIndex = petIndex
          for skill_idx = 0, skillMaxCount - 1 do
            local skillStaticStatus = ToClient_getPetEquipSkillStaticStatus(skill_idx)
            local isLearn = petData:isPetEquipSkillLearned(skill_idx)
            if true == isLearn and nil ~= skillStaticStatus and true ~= petSkillCheck[skill_idx] then
              petSkillCheck[skill_idx] = true
              local skillTypeStaticWrapper = skillStaticStatus:getSkillTypeStaticStatusWrapper()
              if nil ~= skillTypeStaticWrapper and skillLearnCount < self._config._skillSlotMaxCount then
                self._skillDataTableList[count]._iconPath[skillLearnCount] = "Icon/" .. skillTypeStaticWrapper:getIconPath()
                self._skillDataTableList[count]._skillIndex[skillLearnCount] = skill_idx
                self._skillDataTableList[count]._skillName[skillLearnCount] = skillStaticStatus:getName()
                skillLearnCount = skillLearnCount + 1
                self._skillDataTableList[count]._skillLearnCount = skillLearnCount
              end
            end
          end
          if 0 ~= skillLearnCount then
            count = count + 1
          else
            self._skillDataTableList[count] = nil
          end
          petIndex = petIndex + 1
        end
      end
    end
  end
end
function PaGlobal_PetFusion_All:createSkillSlot()
  self._ui.list2_Skill:getElementManager():clearKey()
  self._selectSkillList = {}
  for index = 0, #self._skillDataTableList / 2 do
    self._ui.list2_Skill:getElementManager():pushKey(toInt64(0, index))
  end
end
function PaGlobal_PetFusion_All:createSkillList(content, key)
  local key = Int64toInt32(key)
  local leftKey = key * 2
  local rightKey = leftKey + 1
  local leftSkillData = self._skillDataTableList[leftKey]
  local rightSkillData = self._skillDataTableList[rightKey]
  if nil == leftSkillData and nil == rightSkillData and 0 ~= key then
    self._ui.list2_Skill:getElementManager():removeKey(toInt64(0, key))
    return
  end
  local leftSkillBg = UI.getChildControl(content, "Static_SelectSkillIconsBg_Left")
  local rightSkillBg = UI.getChildControl(content, "Static_SelectSkillIconsBg_Right")
  leftSkillBg:SetShow(true)
  rightSkillBg:SetShow(true)
  if nil ~= leftSkillData or 0 == key then
    self:createSkillListSlot(leftSkillBg, leftKey, leftSkillData)
  end
  if nil ~= rightSkillData then
    self:createSkillListSlot(rightSkillBg, rightKey, rightSkillData)
  else
    rightSkillBg:SetShow(false)
  end
end
function PaGlobal_PetFusion_All:createSkillListSlot(skillBg, key, skillData)
  if 0 == skillData._skillLearnCount and 0 ~= key then
    skillBg:SetShow(false)
    return
  end
  local skillIcon = {}
  local skillIconBg = {}
  local skillName = {}
  local randomIcon = {}
  self._selectSkillList[key] = UI.getChildControl(skillBg, "Static_SkillSlot_Select")
  for index = 0, self._config._skillSlotMaxCount - 1 do
    skillIcon[index] = UI.getChildControl(skillBg, "Static_SelectSkillIcon_" .. index + 1)
    skillIconBg[index] = UI.getChildControl(skillBg, "Static_SkillIconBg_" .. index + 1)
    randomIcon[index] = UI.getChildControl(skillBg, "Static_SkillRandomIcon_" .. index + 1)
    skillName[index] = UI.getChildControl(skillBg, "StaticText_SkillName_" .. index + 1)
    skillIcon[index]:ChangeTextureInfoName("")
    skillIconBg[index]:SetShow(true)
    randomIcon[index]:SetShow(false)
    skillName[index]:SetShow(false)
    skillIconBg[index]:SetIgnore(true)
  end
  for index = 0, self._config._skillSlotMaxCount - 1 do
    if 0 == key then
      skillIcon[index]:SetShow(false)
      skillIconBg[index]:SetShow(false)
      randomIcon[index]:SetShow(true)
      randomIcon[index]:addInputEvent("Mouse_LUp", "HandleEventLUp_PetFusion_SkillSelect_All( 0 )")
      if false == self._isConsole then
        randomIcon[index]:addInputEvent("Mouse_On", "HandleEventMouseOn_PetFusion_SkillSelectOn_All( " .. key .. " )")
        randomIcon[index]:addInputEvent("Mouse_Out", "HandleEventMouseOut_PetFusion_SkillSelectOff_All( " .. key .. " )")
      end
      skillName[index]:SetShow(true)
      skillName[index]:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_PET_RANDOM_SELECT_TITLE"))
    else
      if nil ~= skillData._iconPath[index] then
        skillIcon[index]:ChangeTextureInfoName(skillData._iconPath[index])
        skillIcon[index]:setRenderTexture(skillIcon[index]:getBaseTexture())
        skillIcon[index]:SetShow(true)
        skillName[index]:SetText(skillData._skillName[index])
        skillName[index]:SetShow(true)
        skillIconBg[index]:SetIgnore(false)
        if false == self._isConsole then
          skillIconBg[index]:addInputEvent("Mouse_On", "HandleEventMouseOn_PetList_Show_SkillToolTip_All( " .. skillData._skillIndex[index] .. ", \"petFusion_Slot_" .. key .. "\" , " .. key .. "  )")
          skillIconBg[index]:addInputEvent("Mouse_Out", "HandleEventMouseOut_PetList_Hide_SkillToolTip_All(" .. key .. ")")
        end
        local str = "petFusion_Slot_" .. key
        local skillStaticStatus = ToClient_getPetEquipSkillStaticStatus(skillData._skillIndex[index])
        Panel_SkillTooltip_SetPosition(skillStaticStatus:getSkillNo(), skillIcon[index], str)
      end
      skillIconBg[index]:addInputEvent("Mouse_LUp", "HandleEventLUp_PetFusion_SkillSelect_All( " .. skillData._petIndex .. " )")
    end
  end
  if 0 ~= key then
    skillBg:addInputEvent("Mouse_LUp", "HandleEventLUp_PetFusion_SkillSelect_All( " .. skillData._petIndex .. " )")
  else
    skillBg:addInputEvent("Mouse_LUp", "HandleEventLUp_PetFusion_SkillSelect_All( 0 )")
  end
  if false == self._isConsole then
    skillBg:addInputEvent("Mouse_On", "HandleEventMouseOn_PetFusion_SkillSelectOn_All( " .. key .. " )")
    skillBg:addInputEvent("Mouse_Out", "HandleEventMouseOut_PetFusion_SkillSelectOff_All( " .. key .. " )")
  end
end
function PaGlobal_PetFusion_All:skillSelect(index)
  self._currentSkillIndex = index
  self._currentSkillPetNo = self:findPetNo(self._currentSkillIndex)
  self:updateSkillSlot()
  self:closeSelectSkillBG()
end
function PaGlobal_PetFusion_All:updateSkillSlot()
  self:skillSlotClear()
  if 0 == self._currentSkillIndex then
    return
  end
  local selectPetNo = self:findPetNo(self._currentSkillIndex)
  if -1 == selectPetNo then
    return
  end
  for index = 0, self._config._skillSlotMaxCount - 1 do
    self._skillRandomSlotList[index]:SetShow(false)
    self._staticText_SelectSkillDesc[index]:SetText("")
  end
  local skillLearnCount = 0
  local skillMaxCount = ToClient_getPetEquipSkillMax()
  local petSkillCheck = {}
  for sealPetIndex = 0, ToClient_getPetSealedList() - 1 do
    local petData = ToClient_getPetSealedDataByIndex(sealPetIndex)
    local _petNo = petData._petNo
    if nil ~= _petNo and selectPetNo == _petNo then
      for skill_idx = 0, skillMaxCount - 1 do
        local skillStaticStatus = ToClient_getPetEquipSkillStaticStatus(skill_idx)
        local isLearn = petData:isPetEquipSkillLearned(skill_idx)
        if true == isLearn and nil ~= skillStaticStatus and true ~= petSkillCheck[skill_idx] then
          petSkillCheck[skill_idx] = true
          local skillTypeStaticWrapper = skillStaticStatus:getSkillTypeStaticStatusWrapper()
          if nil ~= skillTypeStaticWrapper and skillLearnCount < self._config._skillSlotMaxCount then
            local skillNo = skillStaticStatus:getSkillNo()
            self._skillSlotList[skillLearnCount]:ChangeTextureInfoName("Icon/" .. skillTypeStaticWrapper:getIconPath())
            self._skillSlotList[skillLearnCount]:setRenderTexture(self._skillSlotList[skillLearnCount]:getBaseTexture())
            self._staticText_SelectSkillDesc[skillLearnCount]:SetText(skillTypeStaticWrapper:getDescription())
            self._skillSlotList[skillLearnCount]:SetShow(true)
            Panel_SkillTooltip_SetPosition(skillNo, self._skillSlotList[skillLearnCount], "petFusionSelect")
            skillLearnCount = skillLearnCount + 1
          end
        end
      end
    end
  end
end
function PaGlobal_PetFusion_All:skillSlotClear()
  for _, control in pairs(self._skillSlotList) do
    control:SetShow(false)
  end
  for _, control in pairs(self._skillRandomSlotList) do
    control:SetShow(true)
  end
  for _, control in pairs(self._staticText_SelectSkillDesc) do
    control:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_PET_RANDOM_SELECT_TITLE"))
  end
end
function PaGlobal_PetFusion_All:setPet(petNoStr, petRace, petTier, sealPetIndex, isJokerPetUse)
  if PaGlobal_PetFusion_GetShow_All() then
    self:PetFusionInitControlSetting(false)
  end
  if true == PaGlobal_PetFusion_IsFull_All() then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_PETFUSION_FULL_TEXT"))
    return
  end
  if false == self:checkSetAble(tonumber64(petNoStr), petRace, sealPetIndex, petTier) then
    return
  end
  if false == PaGlobal_PetFusion_IsMainPetSet_All() then
    self._mainRace = petRace
    self._mainIsJokerPetUse = isJokerPetUse
    self._mainPetTier = petTier - 1
    self:setMainSlot(tonumber64(petNoStr), sealPetIndex)
  else
    self:setSubSlot(tonumber64(petNoStr), sealPetIndex)
  end
  local nextPetNoIndex = self:findNextPetNoIndex()
  self._petNoList[nextPetNoIndex] = tonumber64(petNoStr)
  local nextSealPetIndex = self:findNextSealPetIndex()
  self._sealPetIndexList[nextSealPetIndex] = sealPetIndex
  self._isFusionAble = 1 < self:getPetNoCount() and true == PaGlobal_PetFusion_IsMainPetSet_All()
  PaGlobal_PetList_All:SetPetList(true)
  self:setRate()
  if true == self._ui.stc_SelectLookBG:GetShow() then
    self:openSelectLookBG()
  end
  if true == self._ui.stc_SelectSkillBG:GetShow() then
    self:openSelectSkillBG()
  end
end
function PaGlobal_PetFusion_All:setMainSlot(petNo, sealPetIndex)
  local slot = self._mainPetSlotTable
  for sealPetIndex = 0, ToClient_getPetSealedList() - 1 do
    local petData = ToClient_getPetSealedDataByIndex(sealPetIndex)
    local _petNo = petData._petNo
    if petNo == _petNo then
      local petSS = petData:getPetStaticStatus()
      local iconPath = petData:getIconPath()
      slot._bg:SetIgnore(not self._isConsole)
      slot._icon:ChangeTextureInfoName(iconPath)
      slot._icon:SetShow(true)
      slot._tier:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_SERVANT_TIER", "tier", petSS:getPetTier() + 1))
      slot._tier:SetShow(true)
      slot._level:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_LV") .. "." .. tostring(petData._level))
      slot._level:SetShow(true)
      slot._grade:SetColor(self._gradeColorConfig[petSS:getPetTier()])
      slot._grade:SetShow(true)
      slot._mark:SetShow(false)
      slot._petNo = petNo
      slot._isSet = true
      self._ui.txt_SelectedPetLevel:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_PET_COMPOSE_FACTORIAL_LV_TITLE", "level", tostring(petData._level)))
      if self._isConsole then
        slot._icon:addInputEvent("Mouse_LUp", "PaGlobal_PetFusion_Compose_UnSet_All(\"" .. tostring(petNo) .. "\"," .. sealPetIndex .. " )")
        Panel_Window_PetFusion_All:ignorePadSnapMoveToOtherPanelUpdate(false)
      else
        slot._icon:addInputEvent("Mouse_RUp", "PaGlobal_PetFusion_Compose_UnSet_All(\"" .. tostring(petNo) .. "\"," .. sealPetIndex .. " )")
      end
      return
    end
  end
end
function PaGlobal_PetFusion_All:setTargetTier(mainFusionPetTier)
  if 4 == mainFusionPetTier then
    self._isFourTier = true
  end
  if mainFusionPetTier < 3 then
    return 3
  else
    return 4
  end
end
function PaGlobal_PetFusion_All:findNextSlot()
  for index = 0, #self._subPetSlotTableList do
    if false == self._subPetSlotTableList[index]._isSet then
      return self._subPetSlotTableList[index]
    end
  end
  return nil
end
function PaGlobal_PetFusion_All:setSubSlot(petNo, sealPetIndex)
  local slot = self:findNextSlot()
  if nil == slot then
    return
  end
  for sealPetIndex = 0, ToClient_getPetSealedList() - 1 do
    local petData = ToClient_getPetSealedDataByIndex(sealPetIndex)
    local _petNo = petData._petNo
    if petNo == _petNo then
      local petSS = petData:getPetStaticStatus()
      local iconPath = petData:getIconPath()
      slot._bg:SetIgnore(not self._isConsole)
      slot._tier:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_SERVANT_TIER", "tier", petSS:getPetTier() + 1))
      slot._tier:SetShow(true)
      slot._grade:SetColor(self._gradeColorConfig[petSS:getPetTier()])
      slot._grade:SetShow(true)
      slot._plusicon:SetShow(false)
      slot._icon:ChangeTextureInfoName(iconPath)
      slot._icon:SetShow(true)
      slot._isSet = true
      slot._petNo = petNo
      if self._isConsole then
        slot._icon:addInputEvent("Mouse_LUp", "PaGlobal_PetFusion_Compose_UnSet_All(\"" .. tostring(petNo) .. "\"," .. sealPetIndex .. " )")
      else
        slot._icon:addInputEvent("Mouse_RUp", "PaGlobal_PetFusion_Compose_UnSet_All(\"" .. tostring(petNo) .. "\"," .. sealPetIndex .. " )")
      end
      return
    end
  end
end
function PaGlobal_PetFusion_All:unsetPet(petNoStr, sealPetIndex)
  local unSetPetNo = tonumber64(petNoStr)
  for index = 0, self._config._petMaxTableCount - 1 do
    if unSetPetNo == self._petNoList[index] then
      self._petNoList[index] = -1
      break
    end
  end
  for index = 0, self._config._petMaxTableCount - 1 do
    if sealPetIndex == self._sealPetIndexList[index] then
      self._sealPetIndexList[index] = -1
      break
    end
  end
  self:unSetSlot(unSetPetNo)
  self._isFusionAble = 1 < self:getPetNoCount() and true == PaGlobal_PetFusion_IsMainPetSet_All()
  PaGlobal_PetList_All:SetPetList(true)
  self:setRate()
  if true == self._ui.stc_SelectLookBG:GetShow() then
    PaGlobal_PetFusion_All:openSelectLookBG()
  end
  if true == self._ui.stc_SelectSkillBG:GetShow() then
    PaGlobal_PetFusion_All:openSelectSkillBG()
  end
  self._currentLookIndex = 0
  self._currentLookPetNo = toInt64(0, -1)
  self:updateLookSlot()
  self._currentSkillIndex = 0
  self._currentSkillPetNo = toInt64(0, -1)
  self:updateSkillSlot()
end
function PaGlobal_PetFusion_All:unSetSlot(unSetPetNo)
  if unSetPetNo == self._mainPetSlotTable._petNo then
    self:clear()
    return
  end
  for index = 0, self._config._subPetMaxTableCount - 1 do
    if unSetPetNo == self._subPetSlotTableList[index]._petNo then
      self._subPetSlotTableList[index]._bg:SetIgnore(true)
      self._subPetSlotTableList[index]._icon:SetShow(false)
      self._subPetSlotTableList[index]._grade:SetShow(false)
      self._subPetSlotTableList[index]._tier:SetShow(false)
      self._subPetSlotTableList[index]._plusicon:SetShow(true)
      self._subPetSlotTableList[index]._isSet = false
      self._subPetSlotTableList[index]._petNo = -1
    end
  end
  if self._isConsole then
    ToClient_padSnapSetTargetPanel(Panel_Window_PetList_All)
  end
end
function PaGlobal_PetFusion_All:getPetNoCount()
  local count = 0
  for index = 0, self._config._petMaxTableCount - 1 do
    if -1 ~= self._petNoList[index] then
      count = count + 1
    end
  end
  return count
end
function PaGlobal_PetFusion_All:checkSetAble(petNo, petRace, sealPetIndex, petTier)
  if true == PaGlobal_PetFusion_IsExist_All(petNo) then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_PETFUSION_SAME_PET_WARNING_TEXT"))
    return false
  end
  if false == PaGlobal_PetList_CheckFusionButtonPcRoomPet_All(petNo) then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WINDOW_PETLIST_PCROOM_FUSION"))
    return false
  end
  if 100 <= PaGlobal_PetFusion_GetRate_All() then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_PETFUSION_100PERCENT_TEXT"))
    return false
  end
  if true == PaGlobal_PetFusion_IsMainPetSet_All() and petTier > PaGlobal_PetFusion_GetMainPetTier_All() then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "PANEL_RENEWAL_PETLIST_TEMP_3"))
    return false
  end
  if true == PaGlobal_PetFusion_IsMainPetSet_All() and 99 == petRace and false == PaGlobal_PetFusion_GetIsJokerPetUse_All() then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "PANEL_RENEWAL_PETLIST_TEMP_8"))
    return false
  end
  if true == PaGlobal_PetFusion_IsMainPetSet_All() then
    local mainPetStaticStatus = self:getStaticStatusByPetNo(self._petNoList[0])
    local subPetStaticStatus = self:getStaticStatusByPetNo(petNo)
    local mainGrade = ToClient_getGrade(mainPetStaticStatus:getPetRace(), mainPetStaticStatus:getPetKind())
    local subGrade = ToClient_getGrade(subPetStaticStatus:getPetRace(), subPetStaticStatus:getPetKind())
    if 99 ~= petRace and mainGrade ~= subGrade then
      local message = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_PETCOMPOSE_SAME_GRADETYPE_WARNING_TEXT", "gradeType1", self._gradeStrConfig[mainGrade - 1], "gradeType2", self._gradeStrConfig[mainGrade - 1])
      Proc_ShowMessage_Ack(message)
      return false
    end
  end
  if false == PaGlobal_PetFusion_IsMainPetSet_All() and 99 == petRace then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "PANEL_RENEWAL_PETLIST_TEMP_9"))
    return false
  end
  return true
end
function PaGlobal_PetFusion_All:getStaticStatusByPetNo(petNo)
  for sealPetIndex = 0, ToClient_getPetSealedList() - 1 do
    local petData = ToClient_getPetSealedDataByIndex(sealPetIndex)
    local _petNo = petData._petNo
    if petNo == _petNo then
      return petData:getPetStaticStatus()
    end
  end
  return nil
end
function PaGlobal_PetFusion_All:findNextPetNoIndex()
  for index = 0, self._config._petMaxTableCount - 1 do
    if -1 == self._petNoList[index] then
      return index
    end
  end
  return -1
end
function PaGlobal_PetFusion_All:findNextSealPetIndex()
  for index = 0, self._config._petMaxTableCount - 1 do
    if -1 == self._sealPetIndexList[index] then
      return index
    end
  end
  return -1
end
function PaGlobal_PetFusion_All:findPetNo(index)
  local count = 0
  for i = 0, self._config._petMaxTableCount - 1 do
    if -1 ~= self._petNoList[i] then
      count = count + 1
    end
    if count == index then
      return self._petNoList[i]
    end
  end
  return toInt64(0, -1)
end
function PaGlobal_PetFusion_All:setRate()
  if false == self._isFusionAble then
    self:rateClear()
    return
  end
  local mainStaticStatus = self:getStaticStatusByPetNo(self._petNoList[0])
  if nil == mainStaticStatus then
    return
  end
  self._mainPetTier = mainStaticStatus:getPetTier()
  local targetTier = self:setTargetTier(self._mainPetTier + 1)
  local mainRate = Int64toInt32(ToClient_getMainFusionRate(self._mainPetTier)) / 10000
  local addRate = 0
  for index = 1, self._config._petMaxTableCount - 1 do
    if -1 ~= self._sealPetIndexList[index] then
      local subPetData = ToClient_getPetSealedDataByIndex(self._sealPetIndexList[index])
      if nil ~= subPetData then
        local subStaticStatus = subPetData:getPetStaticStatus()
        if nil ~= subStaticStatus then
          local subTier = subStaticStatus:getPetTier()
          local subRace = subStaticStatus:getPetRace()
          addRate = addRate + Int64toInt32(ToClient_getAddFusionRate(self._mainPetTier, subTier, subRace)) / 10000
        end
      end
    end
  end
  local totalRate = math.min(100, mainRate + addRate)
  totalRate = math.floor(totalRate + 0.5)
  self._currentRate = totalRate
  self._ui.txt_N1Title:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_SERVANT_TIER", "tier", targetTier))
  self._ui.txt_N2Title:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_SERVANT_TIER", "tier", targetTier - 1))
  self._ui.txt_N1Value:SetText(totalRate .. "%")
  self._ui.txt_N2Value:SetText(100 - totalRate .. "%")
  self._ui.progress_N1:ChangeTextureInfoName("Renewal/PcRemaster/Remaster_Pet_00.dds")
  local x1, y1, x2, y2 = setTextureUV_Func(self._ui.progress_N1, self._tierProgressTextureConfig[targetTier - 1][1], self._tierProgressTextureConfig[targetTier - 1][2], self._tierProgressTextureConfig[targetTier - 1][3], self._tierProgressTextureConfig[targetTier - 1][4])
  self._ui.progress_N1:getBaseTexture():setUV(x1, y1, x2, y2)
  self._ui.progress_N1:ChangeTextureInfoName("Renewal/PcRemaster/Remaster_Pet_00.dds")
  local x1, y1, x2, y2 = setTextureUV_Func(self._ui.progress_N1, self._tierProgressTextureConfig[targetTier - 1][1], self._tierProgressTextureConfig[targetTier - 1][2], self._tierProgressTextureConfig[targetTier - 1][3], self._tierProgressTextureConfig[targetTier - 1][4])
  self._ui.progress_N1:getBaseTexture():setUV(x1, y1, x2, y2)
  self._ui.progress_N2:ChangeTextureInfoName("Renewal/PcRemaster/Remaster_Pet_00.dds")
  local x1, y1, x2, y2 = setTextureUV_Func(self._ui.progress_N2, self._tierProgressTextureConfig[targetTier - 2][1], self._tierProgressTextureConfig[targetTier - 2][2], self._tierProgressTextureConfig[targetTier - 2][3], self._tierProgressTextureConfig[targetTier - 2][4])
  self._ui.progress_N2:getBaseTexture():setUV(x1, y1, x2, y2)
  self._ui.progress_N2:ChangeTextureInfoName("Renewal/PcRemaster/Remaster_Pet_00.dds")
  local x1, y1, x2, y2 = setTextureUV_Func(self._ui.progress_N2, self._tierProgressTextureConfig[targetTier - 2][1], self._tierProgressTextureConfig[targetTier - 2][2], self._tierProgressTextureConfig[targetTier - 2][3], self._tierProgressTextureConfig[targetTier - 2][4])
  self._ui.progress_N2:getBaseTexture():setUV(x1, y1, x2, y2)
  self._ui.progress_N1:SetProgressRate(totalRate)
  self._ui.progress_N2:SetProgressRate(100 - totalRate)
  self._ui.txt_N1Title:SetFontColor(self._gradeColorConfig[targetTier - 1])
  self._ui.txt_N2Title:SetFontColor(self._gradeColorConfig[targetTier - 2])
  self._ui.progress_N1:SetColor(self._gradeColorConfig[targetTier - 1])
  self._ui.progress_N2:SetColor(self._gradeColorConfig[targetTier - 2])
  self._ui.txt_N2Title:SetShow(not self._isFourTier)
  self._ui.txt_N2Value:SetShow(not self._isFourTier)
  self._ui.progress_N2:SetShow(not self._isFourTier)
  self._ui.progress_N2BG:SetShow(not self._isFourTier)
end
function PaGlobal_PetFusion_All:fusionPet()
  ClearFocusEdit(self._ui.edit_PetName)
  self:closeSelectLookBG()
  self:closeSelectSkillBG()
  self._petName = self._ui.edit_PetName:GetEditText()
  if "" == self._petName or self._config._defaultName == self._petName then
    Proc_ShowMessage_Ack(self._config._defaultName)
    return
  end
  if true == self._isFusionAble then
    local function confirm_compose()
      local count = 0
      for index = 0, self._config._petMaxTableCount - 1 do
        if -1 ~= self._petNoList[index] then
          ToClient_pushFusionPetList(self._petNoList[index], count)
          count = count + 1
        end
      end
      self._ui_pc.btn_Close:SetShow(false)
      self:fusionStartEffect()
      self._isFusionStart = true
      if self._isConsole then
        self._ui_console.txt_KeyGuideY:SetShow(false)
        self._ui_console.txt_KeyGuideA:SetShow(false)
        self._ui_console.txt_KeyGuideB:SetShow(false)
        PaGlobal_PetFusion_All:resizeOnConsole()
      end
      Panel_Window_PetFusion_All:RegisterUpdateFunc("PaGlobal_PetFusion_FusionStartDelay_PerFrameUpdate_All")
    end
    local messageBoxMemo = PAGetString(Defines.StringSheet_GAME, "PANEL_PETLIST_PETCOMPOSE_MSGCONTENT")
    local messageBoxData = {
      title = PAGetString(Defines.StringSheet_GAME, "PANEL_SERVANTMIX_TITLE"),
      content = messageBoxMemo,
      functionYes = confirm_compose,
      functionNo = MessageBox_Empty_function,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageBoxData)
  else
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "PANEL_PETLIST_PETCOMPOSE_REGIST"))
  end
end
function PaGlobal_PetFusion_All:fusionStartEffect()
  self._ui.stc_FusionBG:SetShow(false)
  self._ui.stc_FusionDoneBG:SetShow(true)
  self._ui.txt_Title:SetShow(false)
  self._ui_pc.btn_Close:SetShow(false)
  self._ui.stc_CompleteEffectBG:SetAlpha(1)
  self._ui.stc_CompleteEffectBG:SetShow(true)
  self._ui.stc_CompleteEffectBG:AddEffect("fUI_PetFusion_GreatSuccess", false, 0, -120)
  audioPostEvent_SystemUi(3, 21)
  _AudioPostEvent_SystemUiForXBOX(3, 21)
  self._ui.txt_CompleteMessage:SetShow(true)
end
function PaGlobal_PetFusion_All:loadCompleteData(petNo)
  local newPetData, skillType, isPassive
  for sealPetIndex = 0, ToClient_getPetSealedList() - 1 do
    local petData = ToClient_getPetSealedDataByIndex(sealPetIndex)
    local _petNo = petData._petNo
    if nil ~= _petNo and petNo == _petNo then
      newPetData = petData
      break
    end
  end
  if nil == newPetData then
    return
  end
  local staticStatus = newPetData:getPetStaticStatus()
  if nil == staticStatus then
    return
  end
  if nil ~= newPetData:getSkillParam(1) then
    skillType = newPetData:getSkillParam(1)._type
    isPassive = newPetData:getSkillParam(1):isPassiveSkill()
  end
  self._completeDataTable._name = newPetData:getName()
  self._completeDataTable._level = newPetData._level
  self._completeDataTable._tier = staticStatus:getPetTier() + 1
  self._completeDataTable._iconPath = newPetData:getIconPath()
  self._completeDataTable._specialSkill = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_PETINFO_SPECIALSKILL", "paramText", PaGlobal_PetList_GetSkillTypeString_All(skillType))
  self._completeDataTable._skillDescList = {}
  self._completeDataTable._skillIconPathList = {}
  local skillMaxCount = ToClient_getPetEquipSkillMax()
  local uiIndex = 0
  for skill_idx = 0, skillMaxCount - 1 do
    local skillStaticStatus = ToClient_getPetEquipSkillStaticStatus(skill_idx)
    local isLearn = newPetData:isPetEquipSkillLearned(skill_idx)
    if true == isLearn and nil ~= skillStaticStatus then
      local skillTypeStaticWrapper = skillStaticStatus:getSkillTypeStaticStatusWrapper()
      if nil ~= skillTypeStaticWrapper then
        local skillNo = skillStaticStatus:getSkillNo()
        self._completeDataTable._skillIconPathList[uiIndex] = "Icon/" .. skillTypeStaticWrapper:getIconPath()
        self._completeDataTable._skillDescList[uiIndex] = skillTypeStaticWrapper:getDescription()
        uiIndex = uiIndex + 1
      end
    end
  end
  if self._isConsole then
    self._ui_console.txt_KeyGuideB:SetShow(true)
  end
end
function PaGlobal_PetFusion_All:setComplete()
  local targetTier = self:setTargetTier(self._mainPetTier + 1)
  local tier = self._completeDataTable._tier
  self._isComplete = false
  if tier > self._mainPetTier + 1 then
    self._isComplete = true
  else
    self._isComplete = false
  end
  self._isFusion = true
  Panel_Window_PetFusion_All:RegisterUpdateFunc("PaGlobal_PetFusion_SetCompleteDelay_PerFrameUpdate_All")
end
function PaGlobal_PetFusion_All:showFusionResult()
  local tier = self._completeDataTable._tier
  self._ui.stc_CompleteEffectBG:EraseAllEffect()
  self._ui.stc_CompletePetIcon:ChangeTextureInfoName(self._completeDataTable._iconPath)
  self._ui.stc_Effect:EraseAllEffect()
  self._ui.stc_Effect_Bottom:EraseAllEffect()
  self._ui.stc_Effect_Bottom:AddEffect(self._tierBottomEfectConfig[tier - 1], true, 0, 0)
  self._ui.txt_CompleteTierChange:SetShow(true)
  self._ui.txt_CompletePetGrade:ChangeTextureInfoName(self._completeTierTextureConfig._texture)
  local x1, y1, x2, y2 = setTextureUV_Func(self._ui.txt_CompletePetGrade, self._completeTierTextureConfig[tier - 1][1], self._completeTierTextureConfig[tier - 1][2], self._completeTierTextureConfig[tier - 1][3], self._completeTierTextureConfig[tier - 1][4])
  self._ui.txt_CompletePetGrade:getBaseTexture():setUV(x1, y1, x2, y2)
  self._ui.txt_CompletePetGrade:ChangeTextureInfoName(self._completeTierTextureConfig._texture)
  local x1, y1, x2, y2 = setTextureUV_Func(self._ui.txt_CompletePetGrade, self._completeTierTextureConfig[tier - 1][1], self._completeTierTextureConfig[tier - 1][2], self._completeTierTextureConfig[tier - 1][3], self._completeTierTextureConfig[tier - 1][4])
  self._ui.txt_CompletePetGrade:getBaseTexture():setUV(x1, y1, x2, y2)
  self._ui.txt_CompletePetGrade:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_SERVANT_TIER", "tier", tier))
  self._ui.txt_PetNameLevel:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_LV") .. "." .. tostring(self._completeDataTable._level) .. " " .. self._completeDataTable._name)
  self._ui.txt_SpecialSkill:SetText(self._completeDataTable._specialSkill)
  self._ui.stc_GradeLine:SetShow(true)
  self._ui.stc_GradeLine:SetColor(self._gradeColorConfig[tier - 1])
  for index = 0, self._config._skillSlotMaxCount - 1 do
    if nil ~= self._completeDataTable._skillIconPathList[index] and nil ~= self._completeDataTable._skillDescList[index] then
      self._completeSkillTableList[index]._icon:ChangeTextureInfoName(self._completeDataTable._skillIconPathList[index])
      self._completeSkillTableList[index]._desc:SetText(self._completeDataTable._skillDescList[index])
    end
  end
  self._ui.txt_CompleteTierChange:SetShow(false)
  if true == self._isComplete then
    local _message = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_PETCOMPOSE_NEXTTIER_CHECK_TEXT", "BeforePetTier", self._mainPetTier + 1, "NextPetTier", tier)
    self._ui.txt_CompleteTierChange:SetShow(true)
    self._ui.txt_CompleteTierChange:EraseAllEffect()
    self._ui.txt_CompleteTierChange:AddEffect("fUI_PetGlow_Success_02A_Green", true, 0, 0)
    self._ui.txt_CompleteTierChange:SetText(_message)
    self._ui.stc_Effect:AddEffect(self._tierEfectConfig[tier - 1], true, 0, 0)
    audioPostEvent_SystemUi(3, 22)
    _AudioPostEvent_SystemUiForXBOX(3, 22)
    self._isComplete = false
  else
    audioPostEvent_SystemUi(3, 23)
    _AudioPostEvent_SystemUiForXBOX(3, 23)
  end
  self:loadCompleteData(petNo)
end
function PaGlobal_PetFusion_All:findPetIndex(petNo)
  for i = 0, self._config._petMaxTableCount - 1 do
    if petNo == self._petNoList[i] then
      return i
    end
  end
  return -1
end
