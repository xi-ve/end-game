function PaGlobal_CharInfoFamilySkill_All:initialize()
  if true == self._initialize then
    return
  end
  local stc_LeftBg = UI.getChildControl(Panel_CharacterInfoFamilySkill_All, "Static_LeftArea")
  local stc_ProgArea = UI.getChildControl(stc_LeftBg, "Static_ProgressArea")
  self._ui.prog2_Circle_point = UI.getChildControl(stc_ProgArea, "CircularProgress_1")
  self._ui.txt_FamSkillPoint = UI.getChildControl(stc_ProgArea, "StaticText_Point")
  self._ui.txt_FamPercent = UI.getChildControl(stc_ProgArea, "StaticText_ExpPercent")
  self._ui.txt_FamPoint = UI.getChildControl(stc_ProgArea, "StaticText_Exp")
  local stc_InfoBg = UI.getChildControl(stc_LeftBg, "Static_StatusInfoArea")
  self._ui.txt_FamGrade = UI.getChildControl(stc_InfoBg, "StaticText_FamilyGradeValue")
  self._ui.txt_AP = UI.getChildControl(stc_InfoBg, "StaticText_APValue")
  self._ui.txt_DP = UI.getChildControl(stc_InfoBg, "StaticText_DPValue")
  self._ui.txt_SpiritRecovery = UI.getChildControl(stc_InfoBg, "StaticText_BlackSpiritRecoveryValue")
  self._ui.txt_ReduceTax = UI.getChildControl(stc_InfoBg, "StaticText_MarketPlaceTaxValue")
  self._ui.btn_AllReset = UI.getChildControl(stc_LeftBg, "Button_AllSkillReset")
  self._ui.stc_Question = UI.getChildControl(stc_LeftBg, "Static_Quetion")
  local stc_RightBg = UI.getChildControl(Panel_CharacterInfoFamilySkill_All, "Static_RightArea")
  local stc_TitleArea = UI.getChildControl(stc_RightBg, "Static_TitleArea")
  self._ui.txt_APUPTitle = UI.getChildControl(stc_TitleArea, "StaticText_AP")
  self._ui.txt_DPUpTitle = UI.getChildControl(stc_TitleArea, "StaticText_DP")
  self._ui.txt_SpiritTitle = UI.getChildControl(stc_TitleArea, "StaticText_BlackSpiritRecovery")
  self._ui.txt_TaxTitle = UI.getChildControl(stc_TitleArea, "StaticText_MarketPlaceTax")
  self._ui.stc_FrameBg = UI.getChildControl(stc_RightBg, "Frame_FamilySkill")
  self._ui.stc_FrameContent = UI.getChildControl(self._ui.stc_FrameBg, "Frame_1_Content")
  self._ui.btn_First_AP = UI.getChildControl(self._ui.stc_FrameContent, "Button_AP")
  self._ui.btn_First_DP = UI.getChildControl(self._ui.stc_FrameContent, "Button_DP")
  self._ui.btn_First_Spirit = UI.getChildControl(self._ui.stc_FrameContent, "Button_BlackSpiritRecovery")
  self._ui.btn_First_Tax = UI.getChildControl(self._ui.stc_FrameContent, "Button_MarketPlaceTax")
  self._ui.btn_Line_AP = UI.getChildControl(self._ui.stc_FrameContent, "Button_APLine")
  self._ui.btn_Line_DP = UI.getChildControl(self._ui.stc_FrameContent, "Button_DPLine")
  self._ui.btn_Line_Spirit = UI.getChildControl(self._ui.stc_FrameContent, "Button_BlackSpiritRecoveryLine")
  self._ui.btn_Line_Tax = UI.getChildControl(self._ui.stc_FrameContent, "Button_MarketPlaceTaxLine")
  self._ui.stc_Console_Cursor = UI.getChildControl(self._ui.stc_FrameContent, "Button_MarketPlaceTaxLine")
  self._ui.stc_Frame_VertiScroll = UI.getChildControl(self._ui.stc_FrameBg, "Frame_1_VerticalScroll")
  self._ui.stc_KeyGuide_Console = UI.getChildControl(Panel_CharacterInfoFamilySkill_All, "Static_Console_Buttons")
  self._ui.stc_KeyGuide_Y = UI.getChildControl(self._ui.stc_KeyGuide_Console, "Button_Y_ConsoleUI")
  self._ui.stc_KeyGuide_B = UI.getChildControl(self._ui.stc_KeyGuide_Console, "Button_B_ConsoleUI")
  self._ui.stc_KeyGuide_A = UI.getChildControl(self._ui.stc_KeyGuide_Console, "Button_A_ConsoleUI")
  self._ui.stc_KeyGuide_X = UI.getChildControl(self._ui.stc_KeyGuide_Console, "Button_X_ConsoleUI")
  self._isConsole = _ContentsGroup_UsePadSnapping
  self._selfPlayer = getSelfPlayer()
  UI.ASSERT_NAME(nil ~= self._selfPlayer, " Panel_CharacterInfoFamilySkill_All_1.lua / getSelfPlayer() is nil", "\234\185\128\234\183\188\236\154\176")
  if nil == self._selfPlayer then
    return
  end
  self._ui.txt_APUPTitle:SetTextMode(__eTextMode_AutoWrap)
  self._ui.txt_DPUpTitle:SetTextMode(__eTextMode_AutoWrap)
  self._ui.txt_SpiritTitle:SetTextMode(__eTextMode_AutoWrap)
  self._ui.txt_TaxTitle:SetTextMode(__eTextMode_AutoWrap)
  self._maxSkillCount = ToClient_GetFamilySkillKindCount()
  self._familySkillDesc = ToClient_GetFamilySkillContentsDescription()
  PaGlobal_CharInfoFamilySkill_All:validate()
  PaGlobal_CharInfoFamilySkill_All:createBtn()
  PaGlobal_CharInfoFamilySkill_All:registEventHandler(self._isConsole)
  PaGlobal_CharInfoFamilySkill_All._initialize = true
end
function PaGlobal_CharInfoFamilySkill_All:registEventHandler(console)
  registerEvent("FromClient_UpdateFamilySkillExpAndPoint", "FromClient_CharInfoFamilySkill_UpdateSkillExpAndPoint")
  registerEvent("FromClient_UpdateFamilySkill", "FromClient_CharInfoFamilySkill_UpdateFamilySkill")
  self._ui.stc_Question:addInputEvent("Mouse_On", "HandleEventOnOut_CharInfoFamilySkill_All_ShowQuestion(true)")
  self._ui.stc_Question:addInputEvent("Mouse_Out", "HandleEventOnOut_CharInfoFamilySkill_All_ShowQuestion(false)")
  self._ui.btn_AllReset:addInputEvent("Mouse_LUp", "HandleEventLUp_CharInfoFamilySkill_All_resetAllSkill()")
end
function PaGlobal_CharInfoFamilySkill_All:dataClear()
  self._ui.stc_Frame_VertiScroll:SetControlTop()
  self._ui.stc_FrameBg:UpdateContentScroll()
  self._ui.stc_FrameBg:UpdateContentPos()
  self._ui._learnFamilySkillKey = nil
  self._ui.txt_AP:SetText(0)
  self._ui.txt_DP:SetText(0)
  self._ui.txt_SpiritRecovery:SetText(string.format("%.2f", 0) .. "%")
  self._ui.txt_ReduceTax:SetText(string.format("%.1f", 0) .. "%")
end
function PaGlobal_CharInfoFamilySkill_All:createBtn()
  local btnData = {
    _skillBtn = {},
    _addBtn = {}
  }
  local lineBtnData = {
    _skillBtn = {},
    _addBtn = {}
  }
  btnData._skillBtn[self._eTYPE.AP] = self._ui.btn_First_AP
  btnData._skillBtn[self._eTYPE.DP] = self._ui.btn_First_DP
  btnData._skillBtn[self._eTYPE.SP] = self._ui.btn_First_Spirit
  btnData._skillBtn[self._eTYPE.TAX] = self._ui.btn_First_Tax
  lineBtnData._skillBtn[self._eTYPE.AP] = self._ui.btn_Line_AP
  lineBtnData._skillBtn[self._eTYPE.DP] = self._ui.btn_Line_DP
  lineBtnData._skillBtn[self._eTYPE.SP] = self._ui.btn_Line_Spirit
  lineBtnData._skillBtn[self._eTYPE.TAX] = self._ui.btn_Line_Tax
  for idx = 0, self._eTYPE.TOTALCOUNT - 1 do
    btnData._addBtn[idx] = UI.getChildControl(btnData._skillBtn[idx], "Button_Learn")
    btnData._addBtn[idx]:SetShow(false)
    lineBtnData._addBtn[idx] = UI.getChildControl(lineBtnData._skillBtn[idx], "Button_Learn")
    lineBtnData._addBtn[idx]:SetShow(false)
  end
  self.btn_Table[0] = btnData
  self.btn_Table[1] = lineBtnData
  PaGlobal_CharInfoFamilySkill_All:createMoreBtn()
end
function PaGlobal_CharInfoFamilySkill_All:createMoreBtn()
  local PosY = self._ui.btn_Line_AP:GetSpanSize().y + self._btnGap
  for idx = #self.btn_Table + 1, self._maxSkillCount do
    local btnData = {
      _skillBtn = {},
      _addBtn = {}
    }
    local copied_Ap = UI.cloneControl(self._ui.btn_Line_AP, self._ui.stc_FrameContent, "Copied_Btn_AP" .. tostring(idx))
    local copied_Dp = UI.cloneControl(self._ui.btn_Line_DP, self._ui.stc_FrameContent, "Copied_Btn_DP" .. tostring(idx))
    local copied_Sp = UI.cloneControl(self._ui.btn_Line_Spirit, self._ui.stc_FrameContent, "Copied_Btn_SP" .. tostring(idx))
    local copied_Tax = UI.cloneControl(self._ui.btn_Line_Tax, self._ui.stc_FrameContent, "Copied_Btn_Tax" .. tostring(idx))
    local parent = {
      [self._eTYPE.AP] = copied_Ap,
      [self._eTYPE.DP] = copied_Dp,
      [self._eTYPE.SP] = copied_Sp,
      [self._eTYPE.TAX] = copied_Tax
    }
    if 2 < idx then
      PosY = self._ui.btn_Line_AP:GetSpanSize().y + self._btnGap * (idx - 1)
    end
    for subIdx = 0, self._eTYPE.TOTALCOUNT - 1 do
      btnData._skillBtn[subIdx] = parent[subIdx]
      local addBtn = UI.getChildControl(btnData._skillBtn[subIdx], "Button_Learn")
      btnData._addBtn[subIdx] = addBtn
      btnData._addBtn[subIdx]:SetShow(false)
      btnData._skillBtn[subIdx]:SetSpanSize(btnData._skillBtn[subIdx]:GetSpanSize().x, PosY)
    end
    self.btn_Table[idx] = btnData
  end
  self._ui.stc_Frame_VertiScroll:SetInterval(self._ui.stc_FrameContent:GetSizeY() * 0.01 * 1.1)
  self._ui.stc_FrameBg:UpdateContentScroll()
  self._ui.stc_Frame_VertiScroll:SetControlTop()
  self._ui.stc_FrameBg:UpdateContentPos()
end
function PaGlobal_CharInfoFamilySkill_All:update()
  if false == PaGlobalFunc_ChracterInfo_All_GetBgShow(PaGlobal_CharInfo_All._TABINDEX._familySkill) then
    return
  end
  if self._maxSkillCount ~= ToClient_GetFamilySkillKindCount() and #self.btn_Table + 1 < ToClient_GetFamilySkillKindCount() then
    self._maxSkillCount = ToClient_GetFamilySkillKindCount()
    PaGlobal_CharInfoFamilySkill_All:createMoreBtn()
  end
  PaGlobal_CharInfoFamilySkill_All:updatePointAndGrade()
  PaGlobal_CharInfoFamilySkill_All:updateDesc()
  PaGlobal_CharInfoFamilySkill_All:updateSkillBtn()
end
function PaGlobal_CharInfoFamilySkill_All:updatePointAndGrade()
  local skillExp = Int64toInt32(ToClient_GetFamilySkillExp())
  local currentTotalPoint = ToClient_GetFamilySkillTotalPoint()
  local requireExp = Int64toInt32(ToClient_GetRequireExpForFamilySkillPoint(currentTotalPoint))
  local rate = 0
  local progRate = 0
  if 0 ~= requireExp then
    rate = skillExp / requireExp * 1000
    progRate = skillExp / requireExp * 750
    rate = math.floor(rate) / 10
    progRate = math.floor(progRate) / 10
  end
  self._ui.txt_FamPoint:SetText(tostring(skillExp) .. " / " .. tostring(requireExp))
  self._ui.txt_FamPercent:SetText(tostring(rate) .. "%")
  self._ui.txt_FamSkillPoint:SetText(tostring(ToClient_GetFamilySkillRemainedPoint()) .. " / " .. tostring(ToClient_GetFamilySkillTotalPoint()))
  self._ui.txt_FamGrade:SetText(tostring(ToClient_GetFamilySkillGrade()))
  self._ui.prog2_Circle_point:SetProgressRate(progRate)
end
function PaGlobal_CharInfoFamilySkill_All:updateDesc()
  local maxLevel = ToClient_GetFamilySkillMaxLevel()
  local familySkillWrapper
  for skillKind = 0, self._maxSkillCount - 1 do
    local value = 0
    local isApply = false
    for lv = 0, maxLevel do
      familySkillWrapper = ToClient_GetFamilySkillWrapperByKindAndLevel(skillKind, lv)
      if nil ~= familySkillWrapper and true == familySkillWrapper:isSet() then
        local skillKey = familySkillWrapper:getFamilySkillKey()
        if true == ToClient_IsLearnFamilySkill(skillKey) then
          value = value + familySkillWrapper:getParam()
        end
      end
    end
    if 0 < value then
      if __eFamilySkillKind_Market == skillKind then
        value = value / 10000
        self._ui.txt_ReduceTax:SetText(string.format("%.1f", value) .. "%")
      elseif __eFamilySkillKind_Adrenalin == skillKind then
        value = value / 100
        self._ui.txt_SpiritRecovery:SetText(string.format("%.2f", value) .. "%")
      elseif __eFamilySkillKind_Attack == skillKind then
        self._ui.txt_AP:SetText(value)
      elseif __eFamilySkillKind_Defense == skillKind then
        self._ui.txt_DP:SetText(value)
      end
    elseif __eFamilySkillKind_Market == skillKind then
      self._ui.txt_ReduceTax:SetText(string.format("%.1f", 0) .. "%")
    elseif __eFamilySkillKind_Adrenalin == skillKind then
      self._ui.txt_SpiritRecovery:SetText(string.format("%.2f", 0) .. "%")
    elseif __eFamilySkillKind_Attack == skillKind then
      self._ui.txt_AP:SetText(0)
    elseif __eFamilySkillKind_Defense == skillKind then
      self._ui.txt_DP:SetText(0)
    end
  end
end
function PaGlobal_CharInfoFamilySkill_All:updateSkillBtn()
  local playerGrade = ToClient_GetFamilySkillGrade()
  for btnLine = 0, self._maxSkillCount do
    for skillType = 0, self._eTYPE.TOTALCOUNT - 1 do
      local familySkillWrapper = ToClient_GetFamilySkillWrapperByKindAndLevel(skillType, btnLine)
      if nil ~= familySkillWrapper and true == familySkillWrapper:isSet() then
        local gradeLimit = familySkillWrapper:getLimitGrade()
        local currentSkillLevel = familySkillWrapper:getFamilySkillLevel()
        local skillKey = familySkillWrapper:getFamilySkillKey()
        self.btn_Table[btnLine]._skillBtn[skillType]:SetText(gradeLimit)
        local isLearned = ToClient_IsLearnFamilySkill(skillKey)
        self.btn_Table[btnLine]._addBtn[skillType]:SetShow(not isLearned)
        self.btn_Table[btnLine]._skillBtn[skillType]:SetCheck(isLearned)
        if true == isLearned then
          if skillKey == self._learnFamilySkillKey then
            self.btn_Table[btnLine]._skillBtn[skillType]:EraseAllEffect()
            self.btn_Table[btnLine]._skillBtn[skillType]:AddEffect("UI_NewSkill01", false, 0, 0)
            self.btn_Table[btnLine]._skillBtn[skillType]:AddEffect("fUI_NewSkill01", false, 0, 0)
            self._learnFamilySkillKey = nil
          end
          local maxSkillLevel = ToClient_GetFamilySkillMaxLevel()
          if currentSkillLevel < maxSkillLevel then
            local nextSkillLevel = currentSkillLevel + 1
            local nextfamilySkillWrapper = ToClient_GetFamilySkillWrapperByKindAndLevel(skillType, nextSkillLevel)
            if nil ~= nextfamilySkillWrapper and true == nextfamilySkillWrapper:isSet() then
              local nextSKillkey = nextfamilySkillWrapper:getFamilySkillKey()
              if false == ToClient_IsLearnFamilySkill(nextSKillkey) then
                self.btn_Table[btnLine]._skillBtn[skillType]:addInputEvent("Mouse_RUp", "HandleEventLUp_CharInfoFamilySkill_All_resetSkill(" .. skillType .. ", " .. btnLine .. ")")
              end
            end
          end
          if currentSkillLevel == maxSkillLevel then
            self.btn_Table[btnLine]._skillBtn[skillType]:addInputEvent("Mouse_RUp", "HandleEventLUp_CharInfoFamilySkill_All_resetSkill(" .. skillType .. ", " .. btnLine .. ")")
          end
          self.btn_Table[btnLine]._skillBtn[skillType]:addInputEvent("Mouse_LUp", "HandleEventLUp_CharInfoFamilySkill_All_IgnoreCheckClick(" .. btnLine .. ", " .. skillType .. ")")
        elseif 0 == currentSkillLevel then
          self.btn_Table[btnLine]._skillBtn[skillType]:addInputEvent("Mouse_LUp", "HandleEventLUp_CharInfoFamilySkill_All_applySkill(" .. skillType .. ", " .. btnLine .. ")")
          self.btn_Table[btnLine]._addBtn[skillType]:addInputEvent("Mouse_LUp", "HandleEventLUp_CharInfoFamilySkill_All_applySkill(" .. skillType .. ", " .. btnLine .. ")")
        elseif 0 < currentSkillLevel then
          local preSkillLevel = currentSkillLevel - 1
          local prefamilySkillWrapper = ToClient_GetFamilySkillWrapperByKindAndLevel(skillType, preSkillLevel)
          if nil ~= prefamilySkillWrapper and true == prefamilySkillWrapper:isSet() then
            local preSKillkey = prefamilySkillWrapper:getFamilySkillKey()
            if true == ToClient_IsLearnFamilySkill(preSKillkey) then
              self.btn_Table[btnLine]._skillBtn[skillType]:addInputEvent("Mouse_LUp", "HandleEventLUp_CharInfoFamilySkill_All_applySkill(" .. skillType .. ", " .. btnLine .. ")")
              self.btn_Table[btnLine]._addBtn[skillType]:addInputEvent("Mouse_LUp", "HandleEventLUp_CharInfoFamilySkill_All_applySkill(" .. skillType .. ", " .. btnLine .. ")")
            else
              self.btn_Table[btnLine]._skillBtn[skillType]:addInputEvent("Mouse_LUp", "HandleEventLUp_CharInfoFamilySkill_All_IgnoreCheckClick(" .. btnLine .. ", " .. skillType .. ")")
              self.btn_Table[btnLine]._addBtn[skillType]:addInputEvent("Mouse_LUp", "HandleEventLUp_CharInfoFamilySkill_All_IgnoreCheckClick(" .. btnLine .. ", " .. skillType .. ")")
              self.btn_Table[btnLine]._addBtn[skillType]:SetShow(false)
            end
          end
        end
        self.btn_Table[btnLine]._skillBtn[skillType]:addInputEvent("Mouse_On", "HandleEventOnOut_CharInfoFamilySkill_All_ShowSkillTooltip(true, " .. btnLine .. "," .. skillType .. ")")
        self.btn_Table[btnLine]._skillBtn[skillType]:addInputEvent("Mouse_Out", "HandleEventOnOut_CharInfoFamilySkill_All_ShowSkillTooltip(false)")
        self.btn_Table[btnLine]._addBtn[skillType]:addInputEvent("Mouse_On", "HandleEventOnOut_CharInfoFamilySkill_All_ShowSkillTooltip(true, " .. btnLine .. "," .. skillType .. ")")
        self.btn_Table[btnLine]._addBtn[skillType]:addInputEvent("Mouse_Out", "HandleEventOnOut_CharInfoFamilySkill_All_ShowSkillTooltip(false)")
      end
    end
  end
end
function PaGlobal_CharInfoFamilySkill_All:validate()
  self._ui.prog2_Circle_point:isValidate()
  self._ui.txt_FamSkillPoint:isValidate()
  self._ui.txt_FamPercent:isValidate()
  self._ui.txt_FamPoint:isValidate()
  self._ui.txt_FamGrade:isValidate()
  self._ui.txt_AP:isValidate()
  self._ui.txt_DP:isValidate()
  self._ui.txt_SpiritRecovery:isValidate()
  self._ui.txt_ReduceTax:isValidate()
  self._ui.btn_AllReset:isValidate()
  self._ui.stc_Question:isValidate()
  self._ui.txt_APUPTitle:isValidate()
  self._ui.txt_DPUpTitle:isValidate()
  self._ui.txt_SpiritTitle:isValidate()
  self._ui.txt_TaxTitle:isValidate()
  self._ui.stc_FrameBg:isValidate()
  self._ui.stc_FrameContent:isValidate()
  self._ui.btn_First_AP:isValidate()
  self._ui.btn_First_DP:isValidate()
  self._ui.btn_First_Spirit:isValidate()
  self._ui.btn_First_Tax:isValidate()
  self._ui.btn_Line_AP:isValidate()
  self._ui.btn_Line_DP:isValidate()
  self._ui.btn_Line_Spirit:isValidate()
  self._ui.btn_Line_Tax:isValidate()
  self._ui.stc_Console_Cursor:isValidate()
  self._ui.stc_Frame_VertiScroll:isValidate()
  self._ui.stc_KeyGuide_Console:isValidate()
  self._ui.stc_KeyGuide_Y:isValidate()
  self._ui.stc_KeyGuide_B:isValidate()
  self._ui.stc_KeyGuide_A:isValidate()
  self._ui.stc_KeyGuide_X:isValidate()
end
