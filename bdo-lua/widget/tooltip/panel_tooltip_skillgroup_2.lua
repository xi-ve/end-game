function Panel_SkillTooltip_Show(slotNo, isShowNextLevel, SlotType, isReserveSkill, isResetable)
  audioPostEvent_SystemUi(1, 13)
  _AudioPostEvent_SystemUiForXBOX(1, 13)
  PaGlobal_TooltipSkill_All.TooltipSkillGroup._callTooltipType = SlotType
  local skillNo = slotNo
  if SlotType == "QuickSlot" then
    local quickSlotInfo = getQuickSlotItem(slotNo)
    if nil == quickSlotInfo then
      return
    end
    skillNo = quickSlotInfo._skillKey:getSkillNo()
  end
  local skillTypeSS = getSkillTypeStaticStatus(skillNo)
  if nil == skillTypeSS then
    return
  end
  local skillLevel = getLearnedSkillLevel(skillTypeSS)
  PaGlobal_TooltipSkill_All.TooltipSkillGroup._currentTooltip.slotNo = slotNo
  PaGlobal_TooltipSkill_All.TooltipSkillGroup._currentTooltip.isShowNext = isShowNextLevel
  PaGlobal_TooltipSkill_All.TooltipSkillGroup._currentTooltip.slotType = SlotType
  if SlotType == "itemToSkill" then
    slotNo = 1
  end
  local isForceResetable = false
  if SlotType == "SelectTypeBox" then
    isForceResetable = true
    isResetable = false
  end
  PaGlobal_TooltipSkill_All.TooltipSkillGroup._maxHeight = 0
  PaGlobal_TooltipSkill_All.TooltipSkillGroup._isReserveSkillOn = true == isReserveSkill
  PaGlobal_TooltipSkill_All:showTooltip(PaGlobal_TooltipSkill_All.TooltipSkillGroup, skillNo, skillTypeSS, isShowNextLevel, PaGlobal_TooltipSkill_All.TooltipSkillGroup._isReserveSkillOn, isResetable, isForceResetable)
  if false == isShowNextLevel and Panel_Tooltip_SkillGroup_forLearning:GetShow() then
    Panel_Tooltip_SkillGroup_forLearning:SetShow(false, false)
  else
    PaGlobal_TooltipSkill_All:showTooltip(PaGlobal_TooltipSkill_All.TooltipSkillGroup_Learning, skillNo, skillTypeSS, false, PaGlobal_TooltipSkill_All.TooltipSkillGroup._isReserveSkillOn)
  end
  local skillStatic
  skillStatic = getSkillStaticStatus(skillNo, 1)
  if nil ~= skillStatic then
    local blackSkillNo = skillStatic:getlinkBlackSkillNo()
    local blackSkillTypeSS = getSkillTypeStaticStatus(blackSkillNo)
    if nil ~= blackSkillTypeSS and blackSkillTypeSS:isValidLocalizing() then
      PaGlobal_TooltipSkill_All:showTooltip(PaGlobal_TooltipSkill_All.TooltipSkillGroup_BlackSpirit, blackSkillNo, blackSkillTypeSS, false, false)
    end
  end
  skillStatic = getSkillStaticStatus(skillNo, 1)
  if nil ~= skillStatic then
    local linkToolTipSkillNo = skillStatic:getLinkTooltipSkillNo()
    local linkToolTipSkillTypeSS = getSkillTypeStaticStatus(linkToolTipSkillNo)
    if nil ~= linkToolTipSkillTypeSS and linkToolTipSkillTypeSS:isValidLocalizing() then
      PaGlobal_TooltipSkill_All:showTooltip(PaGlobal_TooltipSkill_All.TooltipSkillGroup_LinkTooltip, linkToolTipSkillNo, linkToolTipSkillTypeSS, false, false)
    end
  end
  local groupNo, groupLevel = PaGlobalFunc_SkillGroup_GetMouseOnSkillGroupNo()
  if true == isShowNextLevel and nil ~= groupNo and nil ~= groupLevel and -1 ~= groupNo then
    local nextSkillkey = ToClient_getNextLevelSkill(groupNo, groupLevel)
    if nil ~= nextSkillkey and 0 ~= nextSkillkey then
      local nextSkillNo = nextSkillkey:getSkillNo()
      local nextSkillSS = getSkillTypeStaticStatus(nextSkillNo)
      if nil ~= nextSkillSS and nextSkillSS:isValidLocalizing() then
        PaGlobal_TooltipSkill_All:showTooltip(PaGlobal_TooltipSkill_All.TooltipSkillGroup_NextLevel, nextSkillNo, nextSkillSS, false, false)
      end
    end
  end
  local toolTipSize = {width = 0, hieght = 0}
  toolTipSize.width = 0
  toolTipSize.height = 0
  local posX = 0
  local posY = 0
  local panelCount = 0
  local panelList = {}
  if true == Panel_Tooltip_SkillGroup:GetShow() then
    panelList[panelCount] = Panel_Tooltip_SkillGroup
    panelCount = panelCount + 1
  end
  if true == Panel_Tooltip_SkillGroup_forLearning:GetShow() then
    panelList[panelCount] = Panel_Tooltip_SkillGroup_forLearning
    panelCount = panelCount + 1
  end
  if true == Panel_Tooltip_SkillGroup_forLinkTooltip:GetShow() then
    panelList[panelCount] = Panel_Tooltip_SkillGroup_forLinkTooltip
    panelCount = panelCount + 1
  end
  if true == Panel_Tooltip_Skill_NextLevel_All:GetShow() then
    panelList[panelCount] = Panel_Tooltip_Skill_NextLevel_All
    panelCount = panelCount + 1
  end
  if true == Panel_Tooltip_SkillGroup_forBlackSpirit:GetShow() then
    panelList[panelCount] = Panel_Tooltip_SkillGroup_forBlackSpirit
    panelCount = panelCount + 1
  end
  local screenSizeX = getScreenSizeX()
  local screenSizeY = getScreenSizeY()
  posX = getMousePosX()
  posY = getMousePosY()
  local isLeft = posX < screenSizeX / 2
  local isTop = posY < screenSizeY / 2
  local gapX = 30
  local gapY = 30
  if isLeft then
    posX = posX + gapX
  else
    posX = posX - gapX
  end
  local prevPanel
  for ii = 0, panelCount - 1 do
    local panel = panelList[ii]
    toolTipSize.width = panel:GetSizeX()
    tooltipSize.height = panel:GetSizeY()
    if isLeft then
      if nil ~= prevPanel then
        posX = posX + (prevPanel:GetSizeX() + 15)
      end
    else
      posX = posX - (toolTipSize.width + 15)
    end
    panel:SetPosX(posX)
    panel:SetPosY(posY)
    prevPanel = panel
  end
  if screenSizeY < posY + PaGlobal_TooltipSkill_All.TooltipSkillGroup._maxHeight then
    posY = screenSizeY - PaGlobal_TooltipSkill_All.TooltipSkillGroup._maxHeight - gapY
    for ii = 0, panelCount - 1 do
      local panel = panelList[ii]
      panel:SetPosY(posY)
    end
  end
end
function Panel_SkillTooltip_Hide()
  if Defines.CloseType.eCloseType_Attacked == getCurrentCloseType() then
    return
  end
  if Panel_Tooltip_SkillGroup:IsShow() then
    Panel_Tooltip_SkillGroup:SetShow(false, false)
    if Panel_Tooltip_SkillGroup:IsUISubApp() then
      Panel_Tooltip_SkillGroup:CloseUISubApp()
    end
    PaGlobal_TooltipSkill_All.TooltipSkillGroup._currentTooltip.slotNo = -1
  end
  if Panel_Tooltip_SkillGroup_forLearning:IsShow() then
    Panel_Tooltip_SkillGroup_forLearning:SetShow(false, false)
    if Panel_Tooltip_SkillGroup_forLearning:IsUISubApp() then
      Panel_Tooltip_SkillGroup_forLearning:CloseUISubApp()
    end
    PaGlobal_TooltipSkill_All.TooltipSkillGroup._currentTooltip.slotNo = -1
  end
  if Panel_Tooltip_SkillGroup_forBlackSpirit:IsShow() then
    Panel_Tooltip_SkillGroup_forBlackSpirit:SetShow(false, false)
    if Panel_Tooltip_SkillGroup_forBlackSpirit:IsUISubApp() then
      Panel_Tooltip_SkillGroup_forBlackSpirit:CloseUISubApp()
    end
    PaGlobal_TooltipSkill_All.TooltipSkillGroup._currentTooltip.slotNo = -1
  end
  if Panel_Tooltip_SkillGroup_forLinkTooltip:IsShow() then
    Panel_Tooltip_SkillGroup_forLinkTooltip:SetShow(false, false)
    if Panel_Tooltip_SkillGroup_forLinkTooltip:IsUISubApp() then
      Panel_Tooltip_SkillGroup_forLinkTooltip:CloseUISubApp()
    end
    PaGlobal_TooltipSkill_All.TooltipSkillGroup._currentTooltip.slotNo = -1
  end
  if Panel_Tooltip_Skill_NextLevel_All:IsShow() then
    Panel_Tooltip_Skill_NextLevel_All:SetShow(false, false)
    if Panel_Tooltip_Skill_NextLevel_All:IsUISubApp() then
      Panel_Tooltip_Skill_NextLevel_All:CloseUISubApp()
    end
    PaGlobal_TooltipSkill_All.TooltipSkillGroup._currentTooltip.slotNo = -1
  end
end
function Panel_SkillTooltip_GetShow()
  if nil == Panel_Tooltip_SkillGroup then
    return false
  end
  return Panel_Tooltip_SkillGroup:GetShow()
end
function HandleMOver_SkillWindow_ToolTipShow(skillNo, isShowNextLevel, SlotType, isFusion)
  Panel_SkillTooltip_Show(skillNo, false, SlotType)
end
function HandleMOver_SkillWindow_ToolTipHide(skillNo, SlotType, isFusion)
  Panel_SkillTooltip_Hide()
end
function SkillEvent_SkillGroupWindow_ClearSkill(skillPointType)
  local strTemp1, strTemp2
  if 0 == skillPointType then
    strTemp1 = PAGetString(Defines.StringSheet_GAME, "LUA_WINDOW_SKILL_CLEAR_COMBAT_SKILL_TITLE")
    strTemp2 = PAGetString(Defines.StringSheet_GAME, "LUA_WINDOW_SKILL_CLEAR_COMBAT_SKILL_MESSAGE")
  else
    strTemp1 = PAGetString(Defines.StringSheet_GAME, "LUA_WINDOW_SKILL_CLEAR_PRODUCT_SKILL_TITLE")
    strTemp2 = PAGetString(Defines.StringSheet_GAME, "LUA_WINDOW_SKILL_CLEAR_PRODUCT_SKILL_MESSAGE")
  end
  local messageboxData = {
    title = strTemp1,
    content = strTemp2,
    functionYes = Skill_ClearSkillGroup_ConfirmFromMessageBox,
    functionCancel = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageboxData)
end
function Skill_ClearSkillGroup_ConfirmFromMessageBox()
  skillWindow_ClearSkill()
end
function SkillEvent_SkillGroupWindow_ClearSkillMessage()
  PaGlobal_SkillGroup:resetSlot()
  PaGlobal_SkillGroup:update()
end
function Panel_SkillTooltip_SetPosition(skillNo, slot, slotType)
end
function Panel_SkillTooltip_GetCurrentSlotType()
  return PaGlobal_TooltipSkill_All.TooltipSkillGroup._currentTooltip.slotType
end
function Panel_SkillTooltip_Refresh()
  if -1 ~= PaGlobal_TooltipSkill_All.TooltipSkillGroup._currentTooltip.slotNo then
    Panel_SkillTooltip_Show(PaGlobal_TooltipSkill_All.TooltipSkillGroup._currentTooltip.slotNo, PaGlobal_TooltipSkill_All.TooltipSkillGroup._currentTooltip.isShowNext, PaGlobal_TooltipSkill_All.TooltipSkillGroup._currentTooltip.slotType, PaGlobal_TooltipSkill_All.TooltipSkillGroup._isReserveSkillOn)
  else
    Panel_SkillTooltip_Hide()
  end
end
function SkillGroup_GetControlTopPos(control)
  if nil == control then
    UI.ASSERT(false, "SkillGroup_GetBottomPos(control) , control nil")
    return
  end
  return control:GetPosY()
end
function SkillGroup_GetControlBottomPos(control)
  if nil == control then
    UI.ASSERT(false, "SkillGroup_GetBottomPos(control) , control nil")
    return
  end
  return control:GetPosY() + control:GetSizeY()
end
function SkillGroup_GetControlLeftPos(control)
  if nil == control then
    UI.ASSERT(false, "SkillGroup_GetBottomPos(control) , control nil")
    return
  end
  return control:GetPosX()
end
function SkillGroup_GetControlRightPos(control)
  if nil == control then
    UI.ASSERT(false, "SkillGroup_GetBottomPos(control) , control nil")
    return
  end
  return control:GetPosX() + control:GetSizeX()
end
function saveskillpreset(slotNo)
  ToClient_requestSaveSkillPreset(slotNo)
end
function applyskillpreset(slotNo)
  ToClient_requestApplySkillPreset(slotNo)
end
