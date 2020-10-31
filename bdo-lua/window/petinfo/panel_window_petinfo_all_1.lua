function PaGlobal_PetInfo_All:initialize()
  if true == PaGlobal_PetInfo_All._initialize then
    return
  end
  self._ui.stc_PetIcon = UI.getChildControl(Panel_Window_PetInfo_All, "Static_IconPet")
  self._ui.stc_ActionTitle = UI.getChildControl(Panel_Window_PetInfo_All, "StaticText_ActionTitle")
  self._ui.txt_PetName = UI.getChildControl(Panel_Window_PetInfo_All, "StaticText_PetName")
  self._ui.txt_PetLevel = UI.getChildControl(Panel_Window_PetInfo_All, "StaticText_Level_Title")
  self._ui.progress_PetExp = UI.getChildControl(Panel_Window_PetInfo_All, "Static_Progress_EXP")
  self._ui.txt_ExpValue = UI.getChildControl(Panel_Window_PetInfo_All, "StaticText_Level_Value")
  self._ui.txt_Tier = UI.getChildControl(Panel_Window_PetInfo_All, "StaticText_Tier")
  self._ui.txt_baseSkill = UI.getChildControl(Panel_Window_PetInfo_All, "StaticText_Skill_1")
  self._ui.txt_SpecialSkill = UI.getChildControl(Panel_Window_PetInfo_All, "StaticText_Skill_2")
  self._actionCount = ToClient_getPetActionMax()
  for index = 1, self._actionCount do
    self._actionSlot[index] = UI.getChildControl(Panel_Window_PetInfo_All, "Static_" .. tostring(index))
  end
  self._skillSlotCount = 5
  for index = 1, self._skillSlotCount do
    self._skillSlot[index] = UI.getChildControl(Panel_Window_PetInfo_All, "Static_SkillSlot_" .. tostring(index))
    if 1 == index then
      self._skillDesc[index] = UI.getChildControl(Panel_Window_PetInfo_All, "StaticText_SkillDesc_" .. tostring(index))
    else
      self._skillDesc[index] = UI.cloneControl(self._skillDesc[1], Panel_Window_PetInfo_All, "StaticText_SkillDesc_" .. index)
      self._skillDesc[index]:SetPosY(self._skillDesc[index]:GetPosY() + self._skillDescGapSizeY * (index - 1))
    end
    self._skillDesc[index]:SetTextMode(__eTextMode_Limit_AutoWrap)
    self._skillDesc[index]:setLineCountByLimitAutoWrap(2)
  end
  self._ui_pc.btn_Close = UI.getChildControl(Panel_Window_PetInfo_All, "Button_Win_Close")
  self._ui_pc.btn_Question = UI.getChildControl(Panel_Window_PetInfo_All, "Button_Question")
  self._ui_console.stc_KeyGuideBG = UI.getChildControl(Panel_Window_PetInfo_All, "Static_BottomKeyBG_ConsoleUI")
  self._ui_console.txt_KeyGuideX = UI.getChildControl(self._ui_console.stc_KeyGuideBG, "StaticText_Detail_ConsoleUI")
  self._ui_console.txt_KeyGuideB = UI.getChildControl(self._ui_console.stc_KeyGuideBG, "StaticText_Close_ConsoleUI")
  self._isConsole = _ContentsGroup_UsePadSnapping
  Panel_Window_PetInfo_All:SetVerticalMiddle()
  Panel_Window_PetInfo_All:SetHorizonCenter()
  self._ui.txt_baseSkill:SetTextMode(__eTextMode_AutoWrap)
  self._ui.txt_SpecialSkill:SetTextMode(__eTextMode_AutoWrap)
  self._ui.stc_ActionTitle:SetTextMode(__eTextMode_AutoWrap)
  self._ui.stc_ActionTitle:SetText(self._ui.stc_ActionTitle:GetText())
  self._defaultDescPosY = self._ui.txt_SpecialSkill:GetPosY()
  PaGlobal_PetInfo_All:platformSetting()
  PaGlobal_PetInfo_All:setPosition()
  PaGlobal_PetInfo_All:registEventHandler()
  PaGlobal_PetInfo_All:validate()
  PaGlobal_PetInfo_All._initialize = true
end
function PaGlobal_PetInfo_All:platformSetting()
  if nil == Panel_Window_PetInfo_All then
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
      self._ui_console.txt_KeyGuideX,
      self._ui_console.txt_KeyGuideB
    }
    PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyGuides, self._ui_console.stc_KeyGuideBG, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHT)
  end
end
function PaGlobal_PetInfo_All:setPosition()
  if nil == Panel_Window_PetInfo_All then
    return
  end
  Panel_Window_PetInfo_All:ComputePos()
end
function PaGlobal_PetInfo_All:registEventHandler()
  if nil == Panel_Window_PetInfo_All then
    return
  end
  registerEvent("FromClient_PetInfoChanged", "FromClient_PetInfo_Update_All")
  if self._isConsole then
  else
    self._ui_pc.btn_Question:addInputEvent("Mouse_LUp", "Panel_WebHelper_ShowToggle( \"Pet\" )")
    PaGlobal_Util_RegistHelpTooltipEvent(self._ui_pc.btn_Question, "\"Pet\"")
    self._ui_pc.btn_Close:addInputEvent("Mouse_LUp", "PaGlobal_PetInfo_Close_All()")
  end
end
function PaGlobal_PetInfo_All:update()
  if nil == Panel_Window_PetInfo_All then
    return
  end
  local petNo = self._currentPetNo
  local petCount = ToClient_getPetUnsealedList()
  if petCount == 0 then
    return
  end
  for index = 0, petCount - 1 do
    local PcPetData = ToClient_getPetUnsealedDataByIndex(index)
    if nil == PcPetData then
      return
    end
    if petNo == PcPetData:getPcPetNo() then
      local petStaticStatus = PcPetData:getPetStaticStatus()
      local patName = PcPetData:getName()
      local petNum_s64 = PcPetData:getPcPetNo()
      local petNum_S32 = Int64toInt32(petNum_s64)
      local petLevel = PcPetData:getLevel()
      local petExp_s64 = PcPetData:getExperience()
      local petExp_s32 = Int64toInt32(petExp_s64)
      local petMaxExp_s64 = PcPetData:getMaxExperience()
      local petMaxExp_s32 = Int64toInt32(petMaxExp_s64)
      local petExpPercent = petExp_s32 / petMaxExp_s32 * 100
      local iconPath = PcPetData:getIconPath()
      local petTier = petStaticStatus:getPetTier() + 1
      PaGlobal_PetInfo_All:setPetSkillType(PcPetData, 0)
      PaGlobal_PetInfo_All:setPetSkillType(PcPetData, 1)
      local learnedActionCount = 0
      for index = 1, self._actionCount do
        local actionStaticStatus = ToClient_getPetActionStaticStatus(index - 1)
        local isLearn = PcPetData:isPetActionLearned(index - 1)
        self._actionSlot[index]:SetShow(false)
        if true == isLearn then
          learnedActionCount = learnedActionCount + 1
          self._actionSlot[learnedActionCount]:SetShow(true)
          self._actionSlot[learnedActionCount]:ChangeTextureInfoName("Icon/" .. actionStaticStatus:getIconPath())
          if self._isConsole then
            self._actionSlot[learnedActionCount]:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandleEventMouseOn_PetInfo_ActionToolTip_Show_All( " .. index - 1 .. ", " .. index .. " )")
          else
            self._actionSlot[learnedActionCount]:addInputEvent("Mouse_On", "HandleEventMouseOn_PetInfo_ActionToolTip_Show_All( " .. index - 1 .. ", " .. index .. " )")
          end
          self._actionSlot[learnedActionCount]:addInputEvent("Mouse_Out", "TooltipSimple_Hide()")
        else
        end
      end
      local uiIdx = 1
      local baseskillindex = PcPetData:getPetBaseSkillIndex()
      local skillStaticStatus = ToClient_getPetBaseSkillStaticStatus(baseskillindex)
      if nil ~= skillStaticStatus then
        local skillTypeStaticWrapper = skillStaticStatus:getSkillTypeStaticStatusWrapper()
        if nil ~= skillTypeStaticWrapper then
          local skillNo = skillStaticStatus:getSkillNo()
          self._skillSlot[uiIdx]:SetShow(true)
          self._skillSlot[uiIdx]:SetIgnore(false)
          self._skillSlot[uiIdx]:ChangeTextureInfoName("Icon/" .. skillTypeStaticWrapper:getIconPath())
          if self._isConsole then
            self._skillSlot[uiIdx]:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandleEventMouseOn_PetInfo_BaseSkillTooltip_Show_All( " .. baseskillindex .. ", " .. uiIdx .. " )")
          else
            self._skillSlot[uiIdx]:addInputEvent("Mouse_On", "HandleEventMouseOn_PetInfo_BaseSkillTooltip_Show_All( " .. baseskillindex .. ", " .. uiIdx .. " )")
          end
          self._skillSlot[uiIdx]:addInputEvent("Mouse_Out", "Panel_SkillTooltip_Hide()")
          self._skillDesc[uiIdx]:SetText(skillTypeStaticWrapper:getDescription())
          Panel_SkillTooltip_SetPosition(skillNo, self._skillSlot[uiIdx], "PetSkill")
        end
      end
      uiIdx = uiIdx + 1
      local petSkillMaxCount = ToClient_getPetEquipSkillMax()
      for skill_idx = 0, petSkillMaxCount - 1 do
        local skillStaticStatus = ToClient_getPetEquipSkillStaticStatus(skill_idx)
        local isLearn = PcPetData:isPetEquipSkillLearned(skill_idx)
        if true == isLearn and nil ~= skillStaticStatus then
          local skillTypeStaticWrapper = skillStaticStatus:getSkillTypeStaticStatusWrapper()
          if nil ~= skillTypeStaticWrapper then
            local skillNo = skillStaticStatus:getSkillNo()
            self._skillSlot[uiIdx]:SetShow(true)
            self._skillSlot[uiIdx]:SetIgnore(false)
            self._skillSlot[uiIdx]:ChangeTextureInfoName("Icon/" .. skillTypeStaticWrapper:getIconPath())
            if self._isConsole then
              self._skillSlot[uiIdx]:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandleEventMouseOn_PetInfo_SkillTooltip_Show_All( " .. skill_idx .. ", " .. uiIdx .. " )")
            else
              self._skillSlot[uiIdx]:addInputEvent("Mouse_On", "HandleEventMouseOn_PetInfo_SkillTooltip_Show_All( " .. skill_idx .. ", " .. uiIdx .. " )")
            end
            self._skillSlot[uiIdx]:addInputEvent("Mouse_Out", "Panel_SkillTooltip_Hide()")
            self._skillDesc[uiIdx]:SetShow(true)
            self._skillDesc[uiIdx]:SetTextMode(__eTextMode_AutoWrap)
            self._skillDesc[uiIdx]:SetText(skillTypeStaticWrapper:getDescription())
            Panel_SkillTooltip_SetPosition(skillNo, self._skillSlot[uiIdx], "PetSkill")
          else
            self._skillSlot[uiIdx]:SetShow(false)
            self._skillSlot[uiIdx]:SetIgnore(true)
            self._skillSlot[uiIdx]:ChangeTextureInfoName("")
            self._skillDesc[uiIdx]:SetShow(false)
          end
          uiIdx = uiIdx + 1
        end
      end
      for index = uiIdx, self._skillSlotCount do
        self._skillSlot[index]:SetShow(false)
        self._skillDesc[index]:SetShow(false)
      end
      if nil == self._currentPetLv then
        self._currentPetLv = petLevel
      end
      if self._currentPetLv ~= petLevel then
        if petLevel ~= 0 and petLevel ~= 1 and self._currentPetLv ~= 0 and self._currentPetLv ~= 1 then
          Proc_ShowMessage_Ack(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_PETINFO_PETLEVELUP_ACK", "patName", patName))
        end
        self._currentPetLv = petLevel
      end
      self._ui.stc_PetIcon:ChangeTextureInfoName(iconPath)
      self._ui.txt_PetName:SetText(patName)
      self._ui.txt_Tier:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_SERVANT_TIER", "tier", petTier))
      self._ui.progress_PetExp:SetProgressRate(petExpPercent)
      self._ui.txt_PetLevel:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_LV") .. "." .. petLevel)
      self._ui.txt_ExpValue:SetText(string.format("%.1f", petExpPercent) .. "%")
    end
  end
end
function PaGlobal_PetInfo_All:setPetSkillType(PcPetData, param)
  if nil == Panel_Window_PetInfo_All then
    return
  end
  local skillParam = PcPetData:getSkillParam(param)
  local paramText = ""
  if 1 == skillParam._type then
    local petLootingType = PcPetData:getPetLootingType()
    local variableCount = 1
    if 0 == petLootingType then
      variableCount = 1.1
    elseif 2 == petLootingType then
      variableCount = 0.9
    end
    paramText = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_PETINFO_PETSKILLTYPE_ITEMGETTIME", "itemGetTime", string.format("%.1f", skillParam:getParam(0) * variableCount / 1000))
  elseif 2 == skillParam._type then
    paramText = PAGetString(Defines.StringSheet_GAME, "LUA_PETINFO_PETSKILLTYPE_FINDGATHER")
  elseif 3 == skillParam._type then
    paramText = PAGetString(Defines.StringSheet_GAME, "LUA_PETINFO_PETSKILLTYPE_FINDPK")
  elseif 4 == skillParam._type then
    paramText = PAGetString(Defines.StringSheet_GAME, "LUA_PETINFO_PETSKILLTYPE_FINDPLACE")
  elseif 5 == skillParam._type then
    paramText = PAGetString(Defines.StringSheet_GAME, "LUA_PETINFO_PETSKILLTYPE_MOBAGGRO")
  elseif 6 == skillParam._type then
    paramText = PAGetString(Defines.StringSheet_GAME, "LUA_PETINFO_PETSKILLTYPE_FINDRAREMONSTER")
  elseif 7 == skillParam._type then
    paramText = PAGetString(Defines.StringSheet_GAME, "LUA_PETINFO_PETSKILLTYPE_REDUCEAUTOFISHINGTIME")
  elseif 8 == skillParam._type then
    paramText = PAGetString(Defines.StringSheet_GAME, "LUA_PETINFO_PETSKILLTYPE_REGISTILL")
  elseif 9 == skillParam._type then
    paramText = PAGetString(Defines.StringSheet_GAME, "LUA_PETINFO_PETSKILLTYPE_AUTOGETHERING")
  elseif 10 == skillParam._type then
    paramText = PAGetString(Defines.StringSheet_GAME, "LUA_PETINFO_PETSKILLTYPE_GETHERINGINCREASE")
  else
    if 0 == param then
      self._ui.txt_baseSkill:SetShow(false)
    elseif 1 == param then
      self._ui.txt_SpecialSkill:SetShow(false)
    end
    return
  end
  if 0 == param then
    self._ui.txt_baseSkill:SetShow(true)
    self._ui.txt_baseSkill:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_PETINFO_BASESKILL", "paramText", paramText))
  elseif 1 == param then
    self._ui.txt_SpecialSkill:SetShow(true)
    self._ui.txt_SpecialSkill:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_PETINFO_SPECIALSKILL", "paramText", paramText))
  end
  local posY = self._defaultDescPosY
  if self._ui.txt_SpecialSkill:GetShow() then
    self._ui.txt_SpecialSkill:SetPosY(posY)
    posY = posY + self._ui.txt_SpecialSkill:GetTextSizeY()
  end
  if self._ui.txt_baseSkill:GetShow() then
    self._ui.txt_baseSkill:SetPosY(posY)
  end
end
function PaGlobal_PetInfo_All:prepareOpen(petNo_s64)
  if nil == Panel_Window_PetInfo_All then
    return
  end
  self._currentPetNo = tonumber64(petNo_s64)
  self:setPosition()
  self:update()
  if self._isConsole then
    PaGlobal_PetList_All_TempClose()
  end
  PaGlobal_PetInfo_All:open()
end
function PaGlobal_PetInfo_All:open()
  if nil == Panel_Window_PetInfo_All then
    return
  end
  Panel_Window_PetInfo_All:SetShow(true)
end
function PaGlobal_PetInfo_All:prepareClose()
  if nil == Panel_Window_PetInfo_All then
    return
  end
  Panel_SkillTooltip_Hide()
  TooltipSimple_Hide()
  if self._isConsole then
    PaGlobal_PetList_All_TempOpen()
  end
  PaGlobal_PetInfo_All:close()
end
function PaGlobal_PetInfo_All:close()
  if nil == Panel_Window_PetInfo_All then
    return
  end
  Panel_Window_PetInfo_All:SetShow(false)
end
function PaGlobal_PetInfo_All:validate()
  if nil == Panel_Window_PetInfo_All then
    return
  end
  self._ui.stc_PetIcon:isValidate()
  self._ui.txt_PetName:isValidate()
  self._ui.txt_PetLevel:isValidate()
  self._ui.progress_PetExp:isValidate()
  self._ui.txt_ExpValue:isValidate()
  self._ui.txt_Tier:isValidate()
  self._ui.txt_baseSkill:isValidate()
  self._ui.txt_SpecialSkill:isValidate()
  for index = 1, self._actionCount do
    self._actionSlot[index]:isValidate()
  end
  for index = 1, self._skillSlotCount do
    self._skillSlot[index]:isValidate()
    self._skillDesc[index]:isValidate()
  end
  self._ui_pc.btn_Close:isValidate()
  self._ui_pc.btn_Question:isValidate()
  self._ui_console.stc_KeyGuideBG:isValidate()
  self._ui_console.txt_KeyGuideB:isValidate()
end
