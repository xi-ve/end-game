function PaGlobal_SA_Widget_SkillCooltime_Open()
  PaGlobal_SA_Widget_SkillCooltime:prepareOpen()
end
function PaGlobal_SA_Widget_SkillCooltime_Close()
  PaGlobal_SA_Widget_SkillCooltime:prepareClose()
end
function FromClient_SA_Widget_SkillCooltime_ReSizePanel()
  Panel_SA_Widget_SkillCooltime:ComputePosAllChild()
  local screenSizeX = getScreenSizeX()
  local screenSizeY = getScreenSizeY()
  if Panel_SA_Widget_SkillCooltime:GetRelativePosX() == -1 and Panel_SA_Widget_SkillCooltime:GetRelativePosY() == -1 then
    local initPosX = screenSizeX * PaGlobal_SA_Widget_SkillCooltime.config.screenPosX
    local initPosY = screenSizeY * PaGlobal_SA_Widget_SkillCooltime.config.screenPosY
    Panel_SA_Widget_SkillCooltime:SetPosX(initPosX)
    Panel_SA_Widget_SkillCooltime:SetPosY(initPosY)
    changePositionBySever(Panel_SA_Widget_SkillCooltime, CppEnums.PAGameUIType.PAGameUIPanel_SkillCoolTime, true, true, false)
    FGlobal_InitPanelRelativePos(Panel_SA_Widget_SkillCooltime, initPosX, initPosY)
  elseif Panel_SA_Widget_SkillCooltime:GetRelativePosX() == 0 and Panel_SA_Widget_SkillCooltime:GetRelativePosY() == 0 then
    Panel_SA_Widget_SkillCooltime:SetPosX(screenSizeX * PaGlobal_SA_Widget_SkillCooltime.config.screenPosX)
    Panel_SA_Widget_SkillCooltime:SetPosY(screenSizeY * PaGlobal_SA_Widget_SkillCooltime.config.screenPosY)
  else
    Panel_SA_Widget_SkillCooltime:SetPosX(screenSizeX * Panel_SA_Widget_SkillCooltime:GetRelativePosX() - Panel_SA_Widget_SkillCooltime:GetSizeX() / 2)
    Panel_SA_Widget_SkillCooltime:SetPosY(screenSizeY * Panel_SA_Widget_SkillCooltime:GetRelativePosY() - Panel_SA_Widget_SkillCooltime:GetSizeY() / 2)
  end
  if 0 < ToClient_GetUiInfo(CppEnums.PAGameUIType.PAGameUIPanel_SkillCoolTime, 0, CppEnums.PanelSaveType.PanelSaveType_IsSaved) then
    Panel_SA_Widget_SkillCooltime:SetShow(ToClient_GetUiInfo(CppEnums.PAGameUIType.PAGameUIPanel_SkillCoolTime, 0, CppEnums.PanelSaveType.PanelSaveType_IsShow))
  end
  FGlobal_PanelRepostionbyScreenOut(Panel_SA_Widget_SkillCooltime)
end
function PaGlobal_SA_Widget_SkillCooltime_Add(TSkillKey, TSkillNo)
  local slot = PaGlobal_SA_Widget_SkillCooltime.slots[TSkillKey]
  if nil == slot then
    slot = PaGlobal_SA_Widget_SkillCooltime:getSlot()
    PaGlobal_SA_Widget_SkillCooltime.slots[TSkillKey] = slot
  end
  local slotDesc = PaGlobal_SA_Widget_SkillCooltime.slots_description[TSkillKey]
  if nil == slotDesc then
    slotDesc = {
      remainTime = PaGlobal_SA_Widget_SkillCooltime.textRemainTime,
      skillNo = TSkillNo
    }
    PaGlobal_SA_Widget_SkillCooltime.slots_description[TSkillKey] = slotDesc
  end
  local skillTypeStaticWrapper = getSkillTypeStaticStatus(TSkillNo)
  if nil == skillTypeStaticWrapper then
    return
  end
  local isGuildSkill = skillTypeStaticWrapper:isGuildSkill()
  if true == isGuildSkill then
    slot.iconBg:SetShow(true)
  else
    slot.iconBg:SetShow(false)
  end
  local level = getLearnedSkillLevel(skillTypeStaticWrapper)
  local skillSS = getSkillStaticStatus(TSkillNo, level)
  skillReuseTime = skillSS:get()._reuseCycle / 1000
  slot:clearSkill()
  slot:setSkillTypeStatic(skillTypeStaticWrapper)
  slotDesc.remainTime = PaGlobal_SA_Widget_SkillCooltime.textRemainTime
end
function PaGlobal_SA_Widget_SkillCooltime_UpdatePerFrame(deltaTime)
  if false == PaGlobal_SA_Widget_SkillCooltime.showToggle then
    return
  end
  local remainTime = 0
  local row = 0
  local col = 0
  local count = 0
  local readyCount = 0
  for tSkillKey, slot_desc in pairs(PaGlobal_SA_Widget_SkillCooltime.slots_description) do
    local slot = PaGlobal_SA_Widget_SkillCooltime.slots[tSkillKey]
    remainTime = getSkillCooltime(tSkillKey)
    local realRemainTime = 0
    local intRemainTime = 0
    local skillReuseTime = 0
    local skillStaticWrapper = getSkillStaticStatus(slot_desc.skillNo, 1)
    if nil ~= skillStaticWrapper then
      skillReuseTime = skillStaticWrapper:get()._reuseCycle / 1000
    end
    if 0 < slot_desc.remainTime then
      row = count % 2
      col = math.floor(count / 2)
    end
    if 0 < remainTime and nil ~= slot then
      slot.icon:SetShow(true)
      slot.cooltime:UpdateCoolTime(remainTime)
      slot.cooltime:SetShow(true)
      realRemainTime = remainTime * skillReuseTime
      intRemainTime = realRemainTime - realRemainTime % 1 + 1
      slot.cooltimeText:SetText(Time_Formatting_ShowTop(intRemainTime))
      if skillReuseTime >= intRemainTime then
        slot.cooltimeText:SetShow(true)
      else
        slot.cooltimeText:SetShow(false)
      end
      slot:setPos(col * PaGlobal_SA_Widget_SkillCooltime.config.slotGapX, row * PaGlobal_SA_Widget_SkillCooltime.config.slotGapY)
    elseif nil ~= slot then
      slot.icon:SetShow(false)
      local slotPosX = slot.icon:GetParentPosX()
      local slotPosY = slot.icon:GetParentPosY()
      audioPostEvent_SystemUi(2, 1)
      _AudioPostEvent_SystemUiForXBOX(2, 1)
      Panel_SA_CoolTime_Effect:SetShow(true, true)
      Panel_SA_CoolTime_Effect:SetIgnore(true)
      Panel_SA_CoolTime_Effect:AddEffect("fUI_Light", false, 0, 0)
      Panel_SA_CoolTime_Effect:SetPosX(slotPosX - 5)
      Panel_SA_CoolTime_Effect:SetPosY(slotPosY - 5)
      slot:clearSkill()
      PaGlobal_SA_Widget_SkillCooltime.slotPool:push_back(slot)
      PaGlobal_SA_Widget_SkillCooltime.slots[tSkillKey] = nil
    end
    if nil == PaGlobal_SA_Widget_SkillCooltime.slots[tSkillKey] then
      slot_desc.remainTime = slot_desc.remainTime - deltaTime
    end
    if 0 < slot_desc.remainTime then
      count = count + 1
    end
  end
end
function PaGlobal_SA_Widget_SkillCooltime_Reload()
  local coolTimeSkillList = getCoolTimeSkillList()
  if nil == coolTimeSkillList then
    return
  end
  for index = 0, coolTimeSkillList:size() - 1 do
    local skillInfo = coolTimeSkillList:atPointer(index)
    local skillKey = skillInfo._skillKey:get()
    local skillNo = skillInfo._skillKey:getSkillNo()
    PaGlobal_SA_Widget_SkillCooltime_Add(skillKey, skillNo)
  end
end
function PaGlobal_SA_Widget_SkillCooltime_ShowAni()
  if nil == Panel_SA_Widget_SkillCooltime then
    return
  end
end
function PaGlobal_SA_Widget_SkillCooltime_HideAni()
  if nil == Panel_SA_Widget_SkillCooltime then
    return
  end
  Panel_SA_CoolTime_Effect:SetShowWithFade(CppEnums.PAUI_SHOW_FADE_TYPE.PAUI_ANI_TYPE_FADE_OUT)
  local coolTime = Panel_SA_CoolTime_Effect:addColorAnimation(0, 0.5, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
  coolTime:SetStartColor(Defines.Color.C_FFFFFFFF)
  coolTime:SetEndColor(Defines.Color.C_00FFFFFF)
  coolTime:SetStartIntensity(3)
  coolTime:SetEndIntensity(1)
  coolTime.IsChangeChild = true
  coolTime:SetHideAtEnd(true)
  coolTime:SetDisableWhileAni(true)
end
