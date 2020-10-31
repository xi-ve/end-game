function PaGlobal_SA_MainFrame_ChangeSkillSlotInfo()
  for idx = 1, PaGlobal_SA_MainFrame._value_skill._maxSkillCnt do
    PaGlobal_SA_MainFrame:setSlotInfo(idx)
  end
end
function PaGlobal_SA_MainFrame_ChangeSkillPoint()
  PaGlobal_SA_MainFrame:changeSkillPoint()
end
function PaGlobal_SA_MainFrame_UpdateSkillCoolTime(delta)
  for idx = 1, PaGlobal_SA_MainFrame._value_skill._maxSkillCnt do
    if nil ~= PaGlobal_SA_MainFrame._ui_skill.stc_skillSlot[idx] then
      PaGlobal_SA_MainFrame:changeSlotInfo(idx)
      local quickSlotInfo = getQuickSlotItem(idx - 1)
      local isLearned = ToClient_isLearnedSkill(quickSlotInfo._skillKey:getSkillNo())
      if true == isLearned then
        local skillStaticWrapper = getSkillStaticStatus(quickSlotInfo._skillKey:getSkillNo(), quickSlotInfo._skillKey:getLevel())
        if nil ~= skillStaticWrapper then
          if skillStaticWrapper:isUsableSkill() then
            PaGlobal_SA_MainFrame._ui_skill.stc_skillSlot[idx].slotBG.icon:SetMonoTone(false)
          else
            PaGlobal_SA_MainFrame._ui_skill.stc_skillSlot[idx].slotBG.icon:SetMonoTone(true)
          end
        end
        local remainTime = getSkillCooltime(quickSlotInfo._skillKey:get())
        local skillReuseTime = skillStaticWrapper:get()._reuseCycle / 1000
        local realRemainTime = remainTime * skillReuseTime
        local intRemainTime = realRemainTime - realRemainTime % 1 + 1
        if 0 < remainTime then
          PaGlobal_SA_MainFrame._ui_skill.stc_skillSlot[idx].slotBG.cooltime:UpdateCoolTime(remainTime)
          PaGlobal_SA_MainFrame._ui_skill.stc_skillSlot[idx].slotBG.cooltime:SetShow(true)
          PaGlobal_SA_MainFrame._ui_skill.stc_skillSlot[idx].slotBG.cooltimeText:SetText(PaGlobal_SA_MainFrame_Time_Formatting_ShowTop(intRemainTime))
          local coolitemPosX = PaGlobal_SA_MainFrame._ui_skill.stc_skillSlot[idx].slotBG.icon:GetPosX()
          local coolitemPosY = PaGlobal_SA_MainFrame._ui_skill.stc_skillSlot[idx].slotBG.icon:GetPosY()
          PaGlobal_SA_MainFrame._ui_skill.stc_skillSlot[idx].slotBG.cooltime:SetPosXY(coolitemPosX, coolitemPosY)
          PaGlobal_SA_MainFrame._ui_skill.stc_skillSlot[idx].slotBG.cooltimeText:SetPosXY(coolitemPosX, coolitemPosY)
          if skillReuseTime >= intRemainTime then
            PaGlobal_SA_MainFrame._ui_skill.stc_skillSlot[idx].slotBG.cooltimeText:SetShow(true)
          else
            PaGlobal_SA_MainFrame._ui_skill.stc_skillSlot[idx].slotBG.cooltimeText:SetShow(false)
          end
        elseif PaGlobal_SA_MainFrame._ui_skill.stc_skillSlot[idx].slotBG.cooltime:GetShow() then
          PaGlobal_SA_MainFrame._ui_skill.stc_skillSlot[idx].slotBG.cooltime:SetShow(false)
          PaGlobal_SA_MainFrame._ui_skill.stc_skillSlot[idx].slotBG.cooltimeText:SetShow(false)
        end
      else
        PaGlobal_SA_MainFrame._ui_skill.stc_skillSlot[idx].slotBG.icon:SetMonoTone(true)
        PaGlobal_SA_MainFrame._ui_skill.stc_skillSlot[idx].slotBG.cooltime:SetShow(false)
        PaGlobal_SA_MainFrame._ui_skill.stc_skillSlot[idx].slotBG.cooltimeText:SetShow(false)
      end
    end
  end
  PaGlobal_SA_MainFrame_UpdateBasicSkillCoolTime(delta)
  PaGlobal_SA_MainFrame_UpdateRClickSkillCoolTime(delta)
end
function PaGlobal_SA_MainFrame_UpdateBasicSkillCoolTime(delta)
  local quickSlotInfo = getQuickSlotItem(PaGlobal_SA_MainFrame._value_skill._basicSkillKey)
  if nil == quickSlotInfo then
    return
  end
  local remainTime = getSkillCooltime(quickSlotInfo._skillKey:get())
  local skillStaticWrapper = getSkillStaticStatus(quickSlotInfo._skillKey:getSkillNo(), quickSlotInfo._skillKey:getLevel())
  if nil == skillStaticWrapper then
    return
  end
  local skillReuseTime = skillStaticWrapper:get()._reuseCycle / 1000
  local realRemainTime = remainTime * skillReuseTime
  local intRemainTime = realRemainTime - realRemainTime % 1 + 1
  if 0 < remainTime then
    PaGlobal_SA_MainFrame._ui_skill.stc_basicSkillSlot.slotBG.cooltime:UpdateCoolTime(remainTime)
    PaGlobal_SA_MainFrame._ui_skill.stc_basicSkillSlot.slotBG.cooltime:SetShow(true)
    PaGlobal_SA_MainFrame._ui_skill.stc_basicSkillSlot.slotBG.cooltimeText:SetText(PaGlobal_SA_MainFrame_Time_Formatting_ShowTop(intRemainTime))
    local coolitemPosX = PaGlobal_SA_MainFrame._ui_skill.stc_basicSkillSlot.slotBG.icon:GetPosX()
    local coolitemPosY = PaGlobal_SA_MainFrame._ui_skill.stc_basicSkillSlot.slotBG.icon:GetPosY()
    PaGlobal_SA_MainFrame._ui_skill.stc_basicSkillSlot.slotBG.cooltime:SetPosXY(coolitemPosX, coolitemPosY)
    PaGlobal_SA_MainFrame._ui_skill.stc_basicSkillSlot.slotBG.cooltimeText:SetPosXY(coolitemPosX, coolitemPosY)
    if skillReuseTime >= intRemainTime then
      PaGlobal_SA_MainFrame._ui_skill.stc_basicSkillSlot.slotBG.cooltimeText:SetShow(true)
    else
      PaGlobal_SA_MainFrame._ui_skill.stc_basicSkillSlot.slotBG.cooltimeText:SetShow(false)
    end
  elseif PaGlobal_SA_MainFrame._ui_skill.stc_basicSkillSlot.slotBG.cooltime:GetShow() then
    PaGlobal_SA_MainFrame._ui_skill.stc_basicSkillSlot.slotBG.cooltime:SetShow(false)
    PaGlobal_SA_MainFrame._ui_skill.stc_basicSkillSlot.slotBG.cooltimeText:SetShow(false)
  end
end
function PaGlobal_SA_MainFrame_UpdateRClickSkillCoolTime(delta)
  local quickSlotInfo = getQuickSlotItem(PaGlobal_SA_MainFrame._value_skill._rClickSkillkey)
  if nil == quickSlotInfo then
    return
  end
  local remainTime = getSkillCooltime(quickSlotInfo._skillKey:get())
  local skillStaticWrapper = getSkillStaticStatus(quickSlotInfo._skillKey:getSkillNo(), quickSlotInfo._skillKey:getLevel())
  if nil == skillStaticWrapper then
    return
  end
  local skillReuseTime = skillStaticWrapper:get()._reuseCycle / 1000
  local realRemainTime = remainTime * skillReuseTime
  local intRemainTime = realRemainTime - realRemainTime % 1 + 1
  if 0 < remainTime then
    PaGlobal_SA_MainFrame._ui_skill.stc_rClickSkillSlot.slotBG.cooltime:UpdateCoolTime(remainTime)
    PaGlobal_SA_MainFrame._ui_skill.stc_rClickSkillSlot.slotBG.cooltime:SetShow(true)
    PaGlobal_SA_MainFrame._ui_skill.stc_rClickSkillSlot.slotBG.cooltimeText:SetText(PaGlobal_SA_MainFrame_Time_Formatting_ShowTop(intRemainTime))
    local coolitemPosX = PaGlobal_SA_MainFrame._ui_skill.stc_rClickSkillSlot.slotBG.icon:GetPosX()
    local coolitemPosY = PaGlobal_SA_MainFrame._ui_skill.stc_rClickSkillSlot.slotBG.icon:GetPosY()
    PaGlobal_SA_MainFrame._ui_skill.stc_rClickSkillSlot.slotBG.cooltime:SetPosXY(coolitemPosX, coolitemPosY)
    PaGlobal_SA_MainFrame._ui_skill.stc_rClickSkillSlot.slotBG.cooltimeText:SetPosXY(coolitemPosX, coolitemPosY)
    if skillReuseTime >= intRemainTime then
      PaGlobal_SA_MainFrame._ui_skill.stc_rClickSkillSlot.slotBG.cooltimeText:SetShow(true)
    else
      PaGlobal_SA_MainFrame._ui_skill.stc_rClickSkillSlot.slotBG.cooltimeText:SetShow(false)
    end
  elseif PaGlobal_SA_MainFrame._ui_skill.stc_rClickSkillSlot.slotBG.cooltime:GetShow() then
    PaGlobal_SA_MainFrame._ui_skill.stc_rClickSkillSlot.slotBG.cooltime:SetShow(false)
    PaGlobal_SA_MainFrame._ui_skill.stc_rClickSkillSlot.slotBG.cooltimeText:SetShow(false)
  end
end
function Panel_SA_MainFrame_ShowToolTip(slotNo)
  Panel_SkillTooltip_Show(slotNo, false, "QuickSlot")
end
function FromClient_SA_MainFrame_SkillResizePanel()
  PaGlobal_SA_MainFrame._ui_skill.stc_skill:ComputePos()
  PaGlobal_SA_MainFrame._ui_skill.stc_basicSkillSlot.slot:ComputePos()
  PaGlobal_SA_MainFrame._ui_skill.stc_basicSkillSlot.slotBG.icon:ComputePos()
  local skillIcon = UI.getChildControl(PaGlobal_SA_MainFrame._ui_skill.stc_basicSkillSlot.slot, "Static_SkillSlotBg")
  PaGlobal_SA_MainFrame._ui_skill.stc_basicSkillSlot.slotBG.icon:SetPosXY(skillIcon:GetPosX(), skillIcon:GetPosY())
  PaGlobal_SA_MainFrame._ui_skill.stc_basicSkillSlot.progress:ComputePos()
  PaGlobal_SA_MainFrame._ui_skill.stc_basicSkillSlot.key:ComputePos()
  for idx = 1, PaGlobal_SA_MainFrame._value_skill._maxSkillCnt do
    PaGlobal_SA_MainFrame._ui_skill.stc_skillSlot[idx].slot:ComputePos()
    PaGlobal_SA_MainFrame._ui_skill.stc_skillSlot[idx].slotBG.icon:ComputePos()
    local skillIcon = UI.getChildControl(PaGlobal_SA_MainFrame._ui_skill.stc_skillSlot[idx].slot, "Static_SkillSlotBg")
    PaGlobal_SA_MainFrame._ui_skill.stc_skillSlot[idx].slotBG.icon:SetPosXY(skillIcon:GetPosX(), skillIcon:GetPosY())
    PaGlobal_SA_MainFrame._ui_skill.stc_skillSlot[idx].progress:ComputePos()
    PaGlobal_SA_MainFrame._ui_skill.stc_skillSlot[idx].level:ComputePos()
    PaGlobal_SA_MainFrame._ui_skill.stc_skillSlot[idx].key:ComputePos()
  end
end
function PaGlobal_SA_MainFrame:skillValidate()
  if nil == Panel_SA_MainFrame then
    return
  end
  PaGlobal_SA_MainFrame._ui_skill.stc_skill:isValidate()
  PaGlobal_SA_MainFrame._ui_skill.stc_basicSkillSlot.slot:isValidate()
  for idx = 1, PaGlobal_SA_MainFrame._value_skill._maxSkillCnt do
    PaGlobal_SA_MainFrame._ui_skill.stc_skillSlot[idx].slot:isValidate()
    PaGlobal_SA_MainFrame._ui_skill.stc_skillSlot[idx].slotBG.icon:isValidate()
    PaGlobal_SA_MainFrame._ui_skill.stc_skillSlot[idx].progress:isValidate()
    PaGlobal_SA_MainFrame._ui_skill.stc_skillSlot[idx].level:isValidate()
    PaGlobal_SA_MainFrame._ui_skill.stc_skillSlot[idx].key:isValidate()
  end
end
function PaGlobal_SA_MainFrame:skillInit()
  if nil == Panel_SA_MainFrame then
    return
  end
  PaGlobal_SA_MainFrame:basicSkillInit()
  PaGlobal_SA_MainFrame:rClickSkillInit()
  PaGlobal_SA_MainFrame:upgradeSkillInit()
  PaGlobal_SA_MainFrame:changeSkillPoint()
end
function PaGlobal_SA_MainFrame:basicSkillInit()
  PaGlobal_SA_MainFrame._ui_skill.stc_skill = UI.getChildControl(Panel_SA_MainFrame, "Static_Skill")
  local stc_skillIcon = UI.getChildControl(Panel_SA_MainFrame, "Static_Skill_Icon")
  PaGlobal_SA_MainFrame._ui_skill.stc_numberBG = UI.getChildControl(stc_skillIcon, "Static_Number_BG")
  PaGlobal_SA_MainFrame._ui_skill.txt_skillPoint = UI.getChildControl(PaGlobal_SA_MainFrame._ui_skill.stc_numberBG, "StaticText_Number")
  PaGlobal_SA_MainFrame._ui_skill.stc_skillUpEffect = UI.getChildControl(stc_skillIcon, "Static_Skill_Upgrade_Ani")
  local basicSkill = {
    slot = nil,
    slotBG = {},
    progress = nil,
    key = nil
  }
  basicSkill.slot = UI.getChildControl(PaGlobal_SA_MainFrame._ui_skill.stc_skill, "Static_Slot1")
  PaGlobal_SA_MainFrame._value_skill.slotConfig_Skill.template.effect = UI.getChildControl(basicSkill.slot, "Static_SkillSlotBg")
  local basicSkillIcon = UI.getChildControl(basicSkill.slot, "Static_SkillSlotBg")
  SlotSkill.new(basicSkill.slotBG, 0, basicSkillIcon, PaGlobal_SA_MainFrame._value_skill.slotConfig_Skill)
  basicSkill.progress = UI.getChildControl(basicSkill.slot, "Progress2_1")
  basicSkill.key = UI.getChildControl(basicSkill.slot, "Static_KeyF")
  PaGlobal_SA_MainFrame._ui_skill.stc_basicSkillSlot = basicSkill
  PaGlobal_SA_MainFrame:setBasicSlotInfo()
end
function PaGlobal_SA_MainFrame:rClickSkillInit()
  local rClickSkill = {
    slot = nil,
    slotBG = {},
    progress = nil,
    key = nil
  }
  rClickSkill.slot = UI.getChildControl(PaGlobal_SA_MainFrame._ui_skill.stc_skill, "Static_Slot0")
  local rClickSkillIcon = UI.getChildControl(rClickSkill.slot, "Static_SkillSlotBg")
  SlotSkill.new(rClickSkill.slotBG, 0, rClickSkillIcon, PaGlobal_SA_MainFrame._value_skill.slotConfig_Skill)
  rClickSkill.progress = UI.getChildControl(rClickSkill.slot, "Progress2_1")
  rClickSkill.key = UI.getChildControl(rClickSkill.slot, "StaticText_Key")
  PaGlobal_SA_MainFrame._ui_skill.stc_rClickSkillSlot = rClickSkill
  PaGlobal_SA_MainFrame:setrClickSlotInfo()
end
function PaGlobal_SA_MainFrame:upgradeSkillInit()
  for idx = 1, PaGlobal_SA_MainFrame._value_skill._maxSkillCnt do
    local skill = {
      slot = nil,
      slotBG = {},
      progress = nil,
      level = nil,
      key = nil
    }
    skill.slot = UI.getChildControl(PaGlobal_SA_MainFrame._ui_skill.stc_skill, "Static_Slot" .. idx + 1)
    local skillIcon = UI.getChildControl(skill.slot, "Static_SkillSlotBg")
    SlotSkill.new(skill.slotBG, idx, skillIcon, PaGlobal_SA_MainFrame._value_skill.slotConfig_Skill)
    skill.progress = UI.getChildControl(skill.slot, "Progress2_1")
    skill.level = UI.getChildControl(skill.slot, "Static_SkillLevel_" .. idx)
    skill.key = UI.getChildControl(skill.slot, "Static_Key" .. idx)
    PaGlobal_SA_MainFrame._ui_skill.stc_skillSlot[idx] = skill
    PaGlobal_SA_MainFrame:setSlotInfo(idx)
  end
end
function PaGlobal_SA_MainFrame:setBasicSlotInfo()
  local quickSlotInfo = getQuickSlotItem(PaGlobal_SA_MainFrame._value_skill._basicSkillKey)
  if nil == quickSlotInfo then
    return
  end
  local skillNo = quickSlotInfo._skillKey:getSkillNo()
  local skillTypeStaticWrapper = getSkillTypeStaticStatus(skillNo)
  if nil == skillTypeStaticWrapper then
    return
  end
  PaGlobal_SA_MainFrame._ui_skill.stc_basicSkillSlot.slotBG.icon:addInputEvent("Mouse_On", "Panel_SkillTooltip_Show(" .. PaGlobal_SA_MainFrame._value_skill._basicSkillKey .. ", false, \"QuickSlot\")")
  PaGlobal_SA_MainFrame._ui_skill.stc_basicSkillSlot.slotBG.icon:addInputEvent("Mouse_Out", "Panel_SkillTooltip_Hide()")
  Panel_SkillTooltip_SetPosition(PaGlobal_SA_MainFrame._value_skill._basicSkillKey, PaGlobal_SA_MainFrame._ui_skill.stc_basicSkillSlot.slotBG.icon, "QuickSlot")
  PaGlobal_SA_MainFrame._ui_skill.stc_basicSkillSlot.slotBG:setSkillTypeStatic(skillTypeStaticWrapper)
end
function PaGlobal_SA_MainFrame:setrClickSlotInfo()
  local quickSlotInfo = getQuickSlotItem(PaGlobal_SA_MainFrame._value_skill._rClickSkillkey)
  if nil == quickSlotInfo then
    return
  end
  local skillNo = quickSlotInfo._skillKey:getSkillNo()
  local skillTypeStaticWrapper = getSkillTypeStaticStatus(skillNo)
  if nil == skillTypeStaticWrapper then
    return
  end
  PaGlobal_SA_MainFrame._ui_skill.stc_rClickSkillSlot.slotBG.icon:addInputEvent("Mouse_On", "Panel_SkillTooltip_Show(" .. PaGlobal_SA_MainFrame._value_skill._rClickSkillkey .. ", false, \"QuickSlot\")")
  PaGlobal_SA_MainFrame._ui_skill.stc_rClickSkillSlot.slotBG.icon:addInputEvent("Mouse_Out", "Panel_SkillTooltip_Hide()")
  Panel_SkillTooltip_SetPosition(PaGlobal_SA_MainFrame._value_skill._rClickSkillkey, PaGlobal_SA_MainFrame._ui_skill.stc_rClickSkillSlot.slotBG.icon, "QuickSlot")
  PaGlobal_SA_MainFrame._ui_skill.stc_rClickSkillSlot.slotBG:setSkillTypeStatic(skillTypeStaticWrapper)
end
function PaGlobal_SA_MainFrame:setSlotInfo(idx)
  local quickSlotKey = idx - 1
  local quickSlotInfo = getQuickSlotItem(quickSlotKey)
  if nil == quickSlotInfo then
    return
  end
  local skillNo = quickSlotInfo._skillKey:getSkillNo()
  local skillTypeStaticWrapper = getSkillTypeStaticStatus(skillNo)
  if nil == skillTypeStaticWrapper then
    return
  end
  PaGlobal_SA_MainFrame._ui_skill.stc_skillSlot[idx].slotBG:setSkillTypeStatic(skillTypeStaticWrapper)
  local isLearned = ToClient_isLearnedSkill(skillNo)
  if true == isLearned then
    PaGlobal_SA_MainFrame._ui_skill.stc_skillSlot[idx].slot:SetMonoTone(false)
  else
    PaGlobal_SA_MainFrame._ui_skill.stc_skillSlot[idx].slot:SetMonoTone(true)
  end
end
function PaGlobal_SA_MainFrame:changeSlotInfo(idx)
  local quickSlotKey = idx - 1
  local quickSlotInfo = getQuickSlotItem(quickSlotKey)
  if nil == quickSlotInfo then
    return
  end
  local skillNo = quickSlotInfo._skillKey:getSkillNo()
  local skillTypeStaticWrapper = getSkillTypeStaticStatus(skillNo)
  if nil == skillTypeStaticWrapper then
    return
  end
  PaGlobal_SA_MainFrame._ui_skill.stc_skillSlot[idx].slotBG:setSkillTypeStatic(skillTypeStaticWrapper)
  local isLearned = ToClient_isLearnedSkill(skillNo)
  if true == isLearned then
    PaGlobal_SA_MainFrame._ui_skill.stc_skillSlot[idx].slot:SetMonoTone(false)
  else
    PaGlobal_SA_MainFrame._ui_skill.stc_skillSlot[idx].slot:SetMonoTone(true)
  end
  PaGlobal_SA_MainFrame._ui_skill.stc_skillSlot[idx].slotBG.icon:addInputEvent("Mouse_On", "Panel_SA_MainFrame_ShowToolTip(" .. quickSlotKey .. ")")
  PaGlobal_SA_MainFrame._ui_skill.stc_skillSlot[idx].slotBG.icon:addInputEvent("Mouse_Out", "Panel_SkillTooltip_Hide()")
  Panel_SkillTooltip_SetPosition(quickSlotKey, PaGlobal_SA_MainFrame._ui_skill.stc_skillSlot[idx].slotBG.icon, "QuickSlot")
  local levIconUV = PaGlobal_SA_Widget_SkillList_GetSkillLevelTexUV(idx)
  if nil == levIconUV then
    return
  end
  local x1, y1, x2, y2 = setTextureUV_Func(PaGlobal_SA_MainFrame._ui_skill.stc_skillSlot[idx].level, levIconUV.x1, levIconUV.y1, levIconUV.x2, levIconUV.y2)
  PaGlobal_SA_MainFrame._ui_skill.stc_skillSlot[idx].level:getBaseTexture():setUV(x1, y1, x2, y2)
  PaGlobal_SA_MainFrame._ui_skill.stc_skillSlot[idx].level:setRenderTexture(PaGlobal_SA_MainFrame._ui_skill.stc_skillSlot[idx].level:getBaseTexture())
end
function PaGlobal_SA_MainFrame:changeSkillPoint()
  local skillPoint = ToClient_getSkillPointInfo(0)
  if nil == skillPoint then
    return
  end
  self._value_skill._skillPoint = skillPoint._remainPoint
  if 0 < skillPoint._remainPoint then
    self._ui_skill.txt_skillPoint:SetText(self._value_skill._skillPoint)
    self._ui_skill.stc_skillUpEffect:SetShow(true)
    self._ui_skill.stc_numberBG:SetShow(true)
  else
    self._ui_skill.stc_skillUpEffect:SetShow(false)
    self._ui_skill.stc_numberBG:SetShow(false)
  end
end
