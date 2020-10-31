function HandleEventLUp_SA_Widget_SkillList_LearnSkill(idx)
  local isSuccess = ToClient_BattleRoyalLearnSkill(idx - 1)
  if isSuccess then
    audioPostEvent_SystemUi(4, 2)
    PaGlobal_SA_Widget_SkillList._skillSlot[idx].isUpdate = true
  end
end
function FromClient_SA_Widget_SkillList_ReSizePanel()
  for idx = 1, PaGlobal_SA_Widget_SkillList._maxSkillCnt do
    PaGlobal_SA_Widget_SkillList._ui.stc_skillBG[idx]:ComputePos()
  end
  PaGlobal_SA_Widget_SkillList._ui.stc_skillUpgrade:ComputePos()
  PaGlobal_SA_Widget_SkillList._ui.stc_ctrlIcon:ComputePos()
  PaGlobal_SA_Widget_SkillList._ui.stc_upgradeIcon:ComputePos()
  PaGlobal_SA_Widget_SkillList._ui.txt_skillPoint:ComputePos()
  PaGlobal_SA_Widget_SkillList._ui.stc_upgradeNew:ComputePos()
  if false == PaGlobal_SA_Widget_SkillList._isOpenPanel then
    PaGlobal_SA_Widget_SkillList._SKILLBG_ORIGIN_SIZEY = PaGlobal_SA_Widget_SkillList._ui.stc_skillBG[1]:GetSizeY()
    PaGlobal_SA_Widget_SkillList._PANEL_ORIGIN_SIZEY = Panel_SA_SkillList:GetSizeY()
  end
  PaGlobal_SA_Widget_SkillList_ChangeViewType(false)
end
function PaGlobal_SA_Widget_SkillList_ChangeViewType(isOpen)
  if nil == Panel_SA_SkillList or nil == PaGlobal_SA_Widget_SkillList._skillSlot[1] then
    return
  end
  PaGlobal_SA_Widget_SkillList._isOpenPanel = isOpen
  if true == PaGlobal_SA_Widget_SkillList._isOpen then
    PaGlobal_SA_Widget_SkillList._isOpen = false
  end
  local padding = 20
  local isShow = false
  if false == PaGlobal_SA_Widget_SkillList._isOpenPanel then
    for idx = 1, PaGlobal_SA_Widget_SkillList._maxSkillCnt do
      PaGlobal_SA_Widget_SkillList._ui.stc_skillBG[idx]:ComputePos()
    end
    Panel_SA_SkillList:ComputePos()
    PaGlobal_SA_Widget_SkillList._ui.stc_upgradeNew:ComputePos()
    PaGlobal_SA_Widget_SkillList._ui.stc_skillUpgrade:ComputePos()
    PaGlobal_SA_Widget_SkillList._ui.stc_ctrlIcon:ComputePos()
    PaGlobal_SA_Widget_SkillList._ui.stc_upgradeIcon:ComputePos()
    PaGlobal_SA_Widget_SkillList._ui.txt_skillPoint:ComputePos()
    isShow = false
    Panel_SkillTooltip_Hide()
  else
    PaGlobal_SA_Widget_SkillList._ui.stc_upgradeNew:SetShow(false)
    Panel_SA_SkillList:SetSize(Panel_SA_SkillList:GetSizeX(), PaGlobal_SA_Widget_SkillList._PANEL_ORIGIN_SIZEY)
    Panel_SA_SkillList:ComputePos()
    for idx = 1, PaGlobal_SA_Widget_SkillList._maxSkillCnt do
      PaGlobal_SA_Widget_SkillList._ui.stc_skillBG[idx]:SetSize(PaGlobal_SA_Widget_SkillList._ui.stc_skillBG[idx]:GetSizeX(), PaGlobal_SA_Widget_SkillList._SKILLBG_ORIGIN_SIZEY)
      PaGlobal_SA_Widget_SkillList._ui.stc_skillBG[idx]:ComputePos()
    end
    PaGlobal_SA_Widget_SkillList._ui.stc_upgradeNew:ComputePos()
    PaGlobal_SA_Widget_SkillList._ui.stc_skillUpgrade:ComputePos()
    PaGlobal_SA_Widget_SkillList._ui.stc_ctrlIcon:ComputePos()
    PaGlobal_SA_Widget_SkillList._ui.stc_upgradeIcon:ComputePos()
    PaGlobal_SA_Widget_SkillList._ui.txt_skillPoint:ComputePos()
    local sizeY = PaGlobal_SA_Widget_SkillList._ui.stc_skillBG[1]:GetSizeY()
    local iconPosY = PaGlobal_SA_Widget_SkillList._ui.stc_upgradeIcon:GetPosY() - sizeY * 4
    local pointPosY = PaGlobal_SA_Widget_SkillList._ui.txt_skillPoint:GetPosY() - sizeY * 4
    PaGlobal_SA_Widget_SkillList._ui.stc_upgradeIcon:SetPosY(iconPosY)
    PaGlobal_SA_Widget_SkillList._ui.txt_skillPoint:SetPosY(pointPosY)
    isShow = true
    PaGlobal_SA_Widget_SkillList_ShowAni()
  end
  for idx = 1, PaGlobal_SA_Widget_SkillList._maxSkillCnt do
    PaGlobal_SA_Widget_SkillList._ui.stc_skillBG[idx]:SetShow(isShow)
  end
  PaGlobal_SA_Widget_SkillList_ChangeSkillPoint()
end
function PaGlobal_SA_Widget_SkillList_ChangeSkillPoint()
  local skillPoint = ToClient_getSkillPointInfo(0)
  if nil == skillPoint then
    return
  end
  if false == PaGlobal_SA_Widget_SkillList._isOpenPanel then
    PaGlobal_SA_Widget_SkillList._ui.stc_upgradeNew:ComputePos()
    PaGlobal_SA_Widget_SkillList._ui.stc_skillUpgrade:ComputePos()
    PaGlobal_SA_Widget_SkillList._ui.stc_ctrlIcon:ComputePos()
    PaGlobal_SA_Widget_SkillList._ui.stc_upgradeIcon:ComputePos()
    PaGlobal_SA_Widget_SkillList._ui.txt_skillPoint:ComputePos()
  end
  local isMonoTone = false
  PaGlobal_SA_Widget_SkillList._skillPoint = skillPoint._remainPoint
  if 0 == PaGlobal_SA_Widget_SkillList._skillPoint or true == PaGlobal_SA_Widget_SkillList:isFullSkill() then
    isMonoTone = true
    for idx = 1, PaGlobal_SA_Widget_SkillList._maxSkillCnt do
      PaGlobal_SA_Widget_SkillList_ChangeSkillSlotTexture(nil, idx)
      PaGlobal_SA_Widget_SkillList._skillSlot[idx].skillSlotUpgradeIcon:SetShow(false)
      PaGlobal_SA_Widget_SkillList._ui.stc_skillBG[idx]:addInputEvent("Mouse_On", "")
      PaGlobal_SA_Widget_SkillList._ui.stc_skillBG[idx]:addInputEvent("Mouse_LUp", "")
    end
  else
    isMonoTone = false
    PaGlobal_SA_Widget_SkillList._ui.txt_skillPoint:SetText("+" .. tostring(PaGlobal_SA_Widget_SkillList._skillPoint))
    for idx = 1, PaGlobal_SA_Widget_SkillList._maxSkillCnt do
      PaGlobal_SA_Widget_SkillList_ChangeSkillSlotTexture(0, idx)
      PaGlobal_SA_Widget_SkillList._skillSlot[idx].skillSlotUpgradeIcon:SetShow(true)
      PaGlobal_SA_Widget_SkillList._ui.stc_skillBG[idx]:addInputEvent("Mouse_On", "")
      PaGlobal_SA_Widget_SkillList._ui.stc_skillBG[idx]:addInputEvent("Mouse_LUp", "")
      local isSkillLevMax = PaGlobal_SA_Widget_SkillList_IsMaxLev(idx)
      if isSkillLevMax then
        PaGlobal_SA_Widget_SkillList_ChangeSkillSlotTexture(nil, idx)
      else
        PaGlobal_SA_Widget_SkillList._ui.stc_skillBG[idx]:addInputEvent("Mouse_On", "PaGlobal_SA_Widget_SkillList_ChangeSkillSlotTexture(1))")
        PaGlobal_SA_Widget_SkillList._ui.stc_skillBG[idx]:addInputEvent("Mouse_LUp", "PaGlobal_SA_Widget_SkillList_ChangeSkillSlotTexture(2)")
      end
      PaGlobal_SA_Widget_SkillList._skillSlot[idx].skillUpIcon:SetShow(not isSkillLevMax)
      PaGlobal_SA_Widget_SkillList._skillSlot[idx].skillMaxIcon:SetShow(isSkillLevMax)
    end
  end
end
function PaGlobal_SA_Widget_SkillList_ChangeSkillInfo()
  for idx = 1, PaGlobal_SA_Widget_SkillList._maxSkillCnt do
    PaGlobal_SA_Widget_SkillList:setSkillInfo(idx)
  end
end
function PaGlobal_SA_Widget_SkillList_UpSkillLevel(skillNo)
  for idx = 1, PaGlobal_SA_Widget_SkillList._maxSkillCnt do
    if true == PaGlobal_SA_Widget_SkillList._skillSlot[idx].isUpdate then
      PaGlobal_SA_Widget_SkillList_LearnSkillEffect(idx)
      PaGlobal_SA_Widget_SkillList_ChangeSkillLevel(idx)
    end
  end
end
function PaGlobal_SA_Widget_SkillList_ChangeSkillLevel(idx)
  if nil == PaGlobal_SA_Widget_SkillList._skillSlot[idx] or PaGlobal_SA_Widget_SkillList._maxSkillLev <= PaGlobal_SA_Widget_SkillList._skillSlot[idx].skillLev then
    return
  end
  local quickSlotKey = idx - 1
  local quickSlotInfo = getQuickSlotItem(quickSlotKey)
  if nil == quickSlotInfo then
    return
  end
  local skillStaticWrapper = getSkillStaticStatus(quickSlotInfo._skillKey:getSkillNo(), quickSlotInfo._skillKey:getLevel())
  if nil == skillStaticWrapper then
    return
  end
  local skillLev = skillStaticWrapper:get()._needCharacterLevelForLearning
  local skillNo = quickSlotInfo._skillKey:getSkillNo()
  if false == ToClient_isLearnedSkill(skillNo) then
    skillLev = 0
  end
  if true == PaGlobal_SA_Widget_SkillList._skillSlot[idx].isUpdate then
    if 0 == PaGlobal_SA_Widget_SkillList._skillSlot[idx].skillLev then
      skillLev = 1
    else
      skillLev = skillLev + 1
    end
    PaGlobal_SA_Widget_SkillList._skillSlot[idx].isUpdate = false
  end
  if 3 < skillLev then
    skillLev = 3
  end
  PaGlobal_SA_Widget_SkillList._skillSlot[idx].skillLev = skillLev
  local levIconUV = PaGlobal_SA_Widget_SkillList.levIconUV[PaGlobal_SA_Widget_SkillList._skillSlot[idx].skillLev]
  local x1, y1, x2, y2 = setTextureUV_Func(PaGlobal_SA_Widget_SkillList._skillSlot[idx].skillLevel, levIconUV.x1, levIconUV.y1, levIconUV.x2, levIconUV.y2)
  PaGlobal_SA_Widget_SkillList._skillSlot[idx].skillLevel:getBaseTexture():setUV(x1, y1, x2, y2)
  PaGlobal_SA_Widget_SkillList._skillSlot[idx].skillLevel:setRenderTexture(PaGlobal_SA_Widget_SkillList._skillSlot[idx].skillLevel:getBaseTexture())
  if PaGlobal_SA_Widget_SkillList._maxSkillLev == PaGlobal_SA_Widget_SkillList._skillSlot[idx].skillLev then
  end
end
function PaGlobal_SA_Widget_SkillList_LearnSkillEffect(idx)
  if nil == PaGlobal_SA_Widget_SkillList._skillSlot[idx] then
    return
  end
  PaGlobal_SA_Widget_SkillList._skillSlot[idx].skillIcon.icon:EraseAllEffect()
  PaGlobal_SA_Widget_SkillList._skillSlot[idx].skillIcon.icon:AddEffect("UI_NewSkill01", false, 0, 0)
  PaGlobal_SA_Widget_SkillList._skillSlot[idx].skillIcon.icon:AddEffect("fUI_NewSkill01", false, 0, 0)
end
function PaGlobal_SA_Widget_SkillList_GetSkillLevelTexUV(idx)
  return PaGlobal_SA_Widget_SkillList.levIconUV[PaGlobal_SA_Widget_SkillList._skillSlot[idx].skillLev]
end
function PaGlobal_SA_Widget_SkillList_IsLearnAbleSkill()
  local isLearnAble = false
  local skillPoint = ToClient_getSkillPointInfo(0)
  if nil ~= skillPoint and 0 < skillPoint._remainPoint then
    isLearnAble = true
  end
  return isLearnAble
end
function PaGlobal_SA_Widget_SkillList_IsMaxLev(idx)
  local isMaxLev = false
  if 3 <= PaGlobal_SA_Widget_SkillList._skillSlot[idx].skillLev then
    isMaxLev = true
  end
  return isMaxLev
end
function PaGlobal_SA_Widget_SkillList_ChangeSkillSlotTexture(flag, idx)
  if nil == PaGlobal_SA_Widget_SkillList._skillSlot or nil == idx then
    return
  end
  PaGlobal_SA_Widget_SkillList:changeSkillSlotTexture(flag, idx)
end
function PaGlobal_SA_Widget_SkillList_ShowSkillTooltip(key, flag, slotType)
  if nil == Panel_SA_SkillList then
    return
  end
  if false == Panel_SA_SkillList:GetShow() then
    return
  end
  Panel_SkillTooltip_Show(key, flag, slotType)
  if Instance_Tooltip_Skill:GetShow() then
    Instance_Tooltip_Skill:SetPosX(Panel_SA_SkillList:GetPosX() - PaGlobal_SA_Widget_SkillList._PANEL_ORIGIN_SIZEY)
    Instance_Tooltip_Skill:SetPosY(Panel_SA_SkillList:GetPosY())
  end
  if Instance_Tooltip_Skill_forLearning:GetShow() then
    Instance_Tooltip_Skill_forLearning:SetPosX(Panel_SA_SkillList:GetPosX() - PaGlobal_SA_Widget_SkillList._PANEL_ORIGIN_SIZEY)
    Instance_Tooltip_Skill_forLearning:SetPosY(Panel_SA_SkillList:GetPosY())
  end
end
function PaGlobal_SA_Widget_SkillList_IsShow()
  return PaGlobal_SA_Widget_SkillList._isOpenPanel
end
function PaGlobal_SA_Widget_SkillList_ShowAni()
  if nil == Panel_SA_SkillList then
    return
  end
  for idx = 1, PaGlobal_SA_Widget_SkillList._maxSkillCnt do
    local control = PaGlobal_SA_Widget_SkillList._ui.stc_skillBG[idx]
    local moveAni = control:addMoveAnimation(0, 0.2, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
    moveAni:SetStartPosition(control:GetPosX() + 50, control:GetPosY())
    moveAni:SetEndPosition(control:GetPosX(), control:GetPosY())
  end
end
function PaGlobal_SA_Widget_SkillList_HideAni()
  if nil == Panel_SA_SkillList then
    return
  end
end
