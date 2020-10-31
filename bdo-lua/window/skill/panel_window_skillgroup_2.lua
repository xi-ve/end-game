SkillGroup = {}
SkillGroup.__index = SkillGroup
function SkillGroup.new(key, parent, subGroupNo)
  newObj = {}
  setmetatable(newObj, SkillGroup)
  newObj:init(key, parent, subGroupNo)
  return newObj
end
function SkillGroup:init(key, parent, subGroupNo)
  self._key = 0
  local skillKey = ToClient_getSkillKeyBySkillGroupNo(key, 1)
  if false == skillKey:isDefined() then
    return
  end
  local skillNo = skillKey:getSkillNo()
  local skillTypeSSW = getSkillTypeStaticStatus(skillNo)
  if nil == skillTypeSSW then
    return
  end
  if false == skillTypeSSW:isValidLocalizing() then
    self._isValidLocalizing = false
  else
    self._isValidLocalizing = true
  end
  self._key = key
  self._groupBg = UI.cloneControl(PaGlobal_SkillGroup._baseSkillGroupControl, parent, "SkillGroup_" .. key)
  self._groupBg:SetResetPressControl(false)
  self._subGroupNo = subGroupNo
  self._maxLevel = ToClient_getSkillGroupMaxLevel(key)
  self._slot = {}
  local maxLevelSkillKey = ToClient_getSkillKeyBySkillGroupNo(self._key, self._maxLevel)
  if true == maxLevelSkillKey:isDefined() then
    local iconBg = UI.getChildControl(self._groupBg, "Static_SlotIcon")
    SlotSkill.new(self._slot, maxLevelSkillKey:getSkillNo(), iconBg, PaGlobal_SkillGroup._slotConfig)
    self._slot.icon:SetAutoDisableTime(0.5)
  end
  self._btn_learn = UI.getChildControl(self._groupBg, "Static_Icon_Skill_Effect")
  self._circle = Array.new()
  self._isLearnedSkill = false
  local selectLevel = 1
  for ii = 1, self._maxLevel do
    local circle = {_default = nil, _learn = nil}
    function circle:SetPosition(x, y)
      circle._default:SetPosX(x)
      circle._default:SetPosY(y)
      circle._learn:SetPosX(x)
      circle._learn:SetPosY(y)
    end
    circle._default = UI.createControl(__ePAUIControl_Button, self._groupBg, "Static_Circle_Default_" .. tostring(ii))
    CopyBaseProperty(UI.getChildControl(self._groupBg, "Button_SkillLevelNone"), circle._default)
    circle._learn = UI.createControl(__ePAUIControl_Button, self._groupBg, "Static_Circle_Learn_" .. tostring(ii))
    CopyBaseProperty(UI.getChildControl(self._groupBg, "Button_SkillLevelLearn"), circle._learn)
    circle:SetPosition(72 + (ii - 1) % 17 * 10, 32 + math.floor((ii - 1) / 17) * 10)
    local skillKey = ToClient_getSkillKeyBySkillGroupNo(self._key, ii)
    if true == skillKey:isDefined() then
      local isLearn = ToClient_isLearnedSkill(skillKey:getSkillNo())
      if true == isLearn then
        selectLevel = ii
        self._isLearnedSkill = true
      end
    else
    end
    self._circle[ii] = circle
  end
  local effect = UI.getChildControl(self._groupBg, "Static_Icon_Skill_Effect")
  effect:SetShow(false)
  self._ableQuickSlotEffect = UI.getChildControl(self._groupBg, "Static_QuickSlotRegist")
  self._focus = UI.getChildControl(self._groupBg, "Static_SkillLevelFocus")
  txt_skillName = UI.getChildControl(self._groupBg, "StaticText_SkillName")
  txt_skillName:SetTextMode(__eTextMode_Limit_AutoWrap)
  self._txt_originSizeX = txt_skillName:GetSizeX()
  self._btn_prev = UI.getChildControl(self._groupBg, "Button_LeftArrow")
  self._btn_next = UI.getChildControl(self._groupBg, "Button_RIghtArrow")
  self._check_blackSpirit = UI.getChildControl(self._groupBg, "CheckButton_Lock_Black")
  self._check_command = UI.getChildControl(self._groupBg, "CheckButton_Lock_Skill")
  self._stc_CC = UI.getChildControl(self._groupBg, "Static_CC")
  self._stc_icon_effect = UI.getChildControl(self._groupBg, "Static_Icon_Skill_Effect")
  if 1 <= self._maxLevel then
    local skillSSW = getSkillStaticStatus(maxLevelSkillKey:getSkillNo(), 1)
    if nil ~= skillSSW then
      self:initSkillCCType(skillSSW)
    end
  end
  self._stc_CC:SetShow(false)
  self:registerEvent(key)
  self._focus:SetShow(false)
  self._btn_prev:SetShow(false)
  self._btn_next:SetShow(false)
  self._check_blackSpirit:SetShow(false)
  self._check_command:SetShow(false)
  self:selectLevel(selectLevel)
  local skillSSW = getSkillStaticStatus(skillNo, 1)
  if nil ~= skillSSW then
    self:updateSkillCCType(skillSSW)
  end
end
function SkillGroup:initSkillCCType(skillSSW)
  local maxSkillCCTypeCount = ToClient_getMaxSkillCCTypeCount()
  local idxOfSkillCCType = 0
  local gapX = self._stc_CC:GetSizeX() + 2
  local skillCCTypeConfig = PaGlobal_SkillGroup._skillCCTypeConfig
  for ii = 1, maxSkillCCTypeCount - 1 do
    if true == skillSSW:isSetSkillCCType(ii - 1) and nil ~= skillCCTypeConfig.uv[ii] then
      if idxOfSkillCCType < 6 then
        local control = UI.cloneControl(self._stc_CC, self._groupBg, "Static_CC_" .. ii)
        local posX = control:GetPosX() + gapX * idxOfSkillCCType
        control:SetPosX(posX)
        control:ChangeTextureInfoName(skillCCTypeConfig.iconPath)
        local x1, y1, x2, y2 = setTextureUV_Func(control, skillCCTypeConfig.uv[ii].x1, skillCCTypeConfig.uv[ii].y1, skillCCTypeConfig.uv[ii].x2, skillCCTypeConfig.uv[ii].y2)
        control:getBaseTexture():setUV(x1, y1, x2, y2)
        control:setRenderTexture(control:getBaseTexture())
        control:addInputEvent("Mouse_On", "PaGlobal_SkillGroup:ShowSkillGroupCCTooltip(" .. self._key .. "," .. ii .. "," .. "true" .. ")")
        control:addInputEvent("Mouse_Out", "PaGlobal_SkillGroup:ShowSkillGroupCCTooltip(" .. self._key .. "," .. ii .. "," .. "false" .. ")")
        control:addInputEvent("Mouse_LUp", "PaGlobal_SkillGroup:HandleEventLUp_SkillGroup(" .. self._key .. ")")
        control:SetShow(true)
        idxOfSkillCCType = idxOfSkillCCType + 1
      end
      if idxOfSkillCCType == 6 then
        local control = UI.createControl(__ePAUIControl_StaticText, self._groupBg, "Static_CC_limit" .. ii)
        control:SetSize(20, 20)
        control:SetHorizonLeft()
        control:SetVerticalTop()
        control:SetSpanSize(70, 45)
        local posX = control:GetPosX() + gapX * idxOfSkillCCType
        control:SetPosX(posX)
        control:SetText("...")
        control:SetShow(true)
      end
    end
  end
end
function SkillGroup:updateSkillCCType(skillSSW)
  local maxSkillCCTypeCount = ToClient_getMaxSkillCCTypeCount()
  local idxOfSkillCCType = 0
  local gapX = self._stc_CC:GetSizeX() + 2
  local skillCCTypeConfig = PaGlobal_SkillGroup._skillCCTypeConfig
  for ii = 1, maxSkillCCTypeCount - 1 do
    if true == skillSSW:isSetSkillCCType(ii - 1) and nil ~= skillCCTypeConfig.uv[ii] then
      if idxOfSkillCCType < 6 then
        local control = UI.getChildControlNoneAssert(self._groupBg, "Static_CC_" .. ii)
        if nil == control then
          control = UI.cloneControl(self._stc_CC, self._groupBg, "Static_CC_" .. ii)
        end
        local posX = self._stc_CC:GetPosX() + gapX * idxOfSkillCCType
        control:SetPosX(posX)
        control:ChangeTextureInfoName(skillCCTypeConfig.iconPath)
        local x1, y1, x2, y2 = setTextureUV_Func(control, skillCCTypeConfig.uv[ii].x1, skillCCTypeConfig.uv[ii].y1, skillCCTypeConfig.uv[ii].x2, skillCCTypeConfig.uv[ii].y2)
        control:getBaseTexture():setUV(x1, y1, x2, y2)
        control:setRenderTexture(control:getBaseTexture())
        control:addInputEvent("Mouse_On", "PaGlobal_SkillGroup:ShowSkillGroupCCTooltip(" .. self._key .. "," .. ii .. "," .. "true" .. ")")
        control:addInputEvent("Mouse_Out", "PaGlobal_SkillGroup:ShowSkillGroupCCTooltip(" .. self._key .. "," .. ii .. "," .. "false" .. ")")
        control:addInputEvent("Mouse_LUp", "PaGlobal_SkillGroup:HandleEventLUp_SkillGroup(" .. self._key .. ")")
        control:SetShow(true)
        idxOfSkillCCType = idxOfSkillCCType + 1
      end
      if idxOfSkillCCType == 6 then
        local control = UI.getChildControl(self._groupBg, "Static_CC_limit" .. ii)
        control:SetSize(20, 20)
        control:SetHorizonLeft()
        control:SetVerticalTop()
        control:SetSpanSize(70, 45)
        local posX = self._stc_CC:GetPosX() + gapX * idxOfSkillCCType
        control:SetPosX(posX)
        control:SetText("...")
        control:SetShow(true)
      end
    else
      local control = UI.getChildControlNoneAssert(self._groupBg, "Static_CC_" .. ii)
      if nil ~= control then
        control:SetShow(false)
      end
    end
  end
end
function PaGlobal_SkillGroup:ShowSkillGroupCCTooltip(key, index, isShow)
  local skillGroup = self._skillGroupList[key]
  if nil == skillGroup then
    return
  end
  local control = UI.getChildControl(skillGroup._groupBg, "Static_CC_" .. index)
  if nil == control then
    return
  end
  local title = ""
  local desc = ""
  if index == 1 then
    title = PAGetString(Defines.StringSheet_GAME, "LUA_PLAYSKILL_INVINCIBILITY")
  elseif index == 2 then
    title = PAGetString(Defines.StringSheet_GAME, "LUA_PLAYSKILL_SUPERARMOR")
  elseif index == 3 then
    title = PAGetString(Defines.StringSheet_GAME, "LUA_PLAYSKILL_FRONTGUARD")
  elseif index == 4 then
    title = PAGetString(Defines.StringSheet_GAME, "LUA_PLAYSKILL_KNOCKDOWN")
  elseif index == 5 then
    title = PAGetString(Defines.StringSheet_GAME, "LUA_PLAYSKILL_JUMP")
  elseif index == 6 then
    title = PAGetString(Defines.StringSheet_GAME, "LUA_PLAYSKILL_BOUND")
  elseif index == 7 then
    title = PAGetString(Defines.StringSheet_GAME, "LUA_PLAYSKILL_FAINT")
  elseif index == 8 then
    title = PAGetString(Defines.StringSheet_GAME, "LUA_PLAYSKILL_STIFFNESS")
  elseif index == 9 then
    title = PAGetString(Defines.StringSheet_GAME, "LUA_PLAYSKILL_KNOCKBACK")
  elseif index == 10 then
    title = PAGetString(Defines.StringSheet_GAME, "LUA_PLAYSKILL_CATCH")
  elseif index == 11 then
    title = PAGetString(Defines.StringSheet_GAME, "LUA_PLAYSKILL_FREEZE")
  elseif index == 12 then
    title = PAGetString(Defines.StringSheet_GAME, "LUA_PLAYSKILL_DOWNSMASH")
  elseif index == 13 then
    title = PAGetString(Defines.StringSheet_GAME, "LUA_PLAYSKILL_AIRSMASH")
  elseif index == 14 then
    title = PAGetString(Defines.StringSheet_GAME, "LUA_PLAYSKILL_DOWNATTACK")
  elseif index == 15 then
    title = PAGetString(Defines.StringSheet_GAME, "LUA_PLAYSKILL_AIRATTACK")
  elseif index == 16 then
    title = PAGetString(Defines.StringSheet_GAME, "LUA_PLAYSKILL_COUNTERATTACK")
  elseif index == 17 then
    title = PAGetString(Defines.StringSheet_GAME, "LUA_PLAYSKILL_SPEEDATTACK")
  else
    UI.ASSERT(false, "SkillCCType \236\149\132\236\157\180\236\189\152\236\157\180 \236\182\148\234\176\128\235\144\160 \234\178\189\236\154\176 \237\136\180\237\140\129 \236\138\164\237\138\184\235\167\129 \236\182\148\234\176\128\235\143\132 \237\149\132\236\154\148\237\149\169\235\139\136\235\139\164.")
  end
  if true == isShow then
    TooltipSimple_Show(control, title, desc)
  else
    TooltipSimple_Hide()
  end
end
function SkillGroup:getPosX()
  if nil ~= self._groupBg then
    return self._groupBg:GetPosX()
  else
    return 0
  end
end
function SkillGroup:getPosY()
  if nil ~= self._groupBg then
    return self._groupBg:GetPosY()
  else
    return 0
  end
end
function SkillGroup:getCurrentGroupLevel()
  local selectLevel = 1
  for ii = 1, self._maxLevel do
    local skillKey = ToClient_getSkillKeyBySkillGroupNo(self._key, ii)
    if true == skillKey:isDefined() then
      local isLearn = ToClient_isLearnedSkill(skillKey:getSkillNo())
      if true == isLearn then
        selectLevel = ii
      end
    end
  end
  return selectLevel
end
function SkillGroup:getSelectSkillLevel()
  return self._selectLevel
end
function SkillGroup:HandleEventLUp_PrevLevelButton()
  local isPressShift = false
  if true == isKeyPressed(CppEnums.VirtualKeyCode.KeyCode_SHIFT) then
    isPressShift = true
  end
  if true == isPressShift then
    local level = 1
    self:selectLevel(level)
    local skillKey = ToClient_getSkillKeyBySkillGroupNo(self._key, level)
    if false == skillKey:isDefined() then
      return
    end
    local skillNo = skillKey:getSkillNo()
    local skillSSW = getSkillStaticStatus(skillNo, 1)
    if nil ~= skillSSW then
      self:updateSkillCCType(skillSSW)
    end
    PaGlobal_SkillGroup._selectSkillNo = skillNo
    PaGloabl_SkillGroup_ShowDesc(skillNo)
  else
    local level = self._selectLevel - 1
    if level <= 1 then
      level = 1
    end
    self:selectLevel(level)
    local skillKey = ToClient_getSkillKeyBySkillGroupNo(self._key, level)
    if false == skillKey:isDefined() then
      return
    end
    local skillNo = skillKey:getSkillNo()
    local skillSSW = getSkillStaticStatus(skillNo, 1)
    if nil ~= skillSSW then
      self:updateSkillCCType(skillSSW)
    end
    PaGlobal_SkillGroup._selectSkillNo = skillNo
    PaGloabl_SkillGroup_ShowDesc(skillNo)
  end
end
function SkillGroup:HandleEventLUp_NextLevelButton()
  local isPressShift = false
  if true == isKeyPressed(CppEnums.VirtualKeyCode.KeyCode_SHIFT) then
    isPressShift = true
  end
  if true == isPressShift then
    level = self._maxLevel
    self:selectLevel(level)
    local skillKey = ToClient_getSkillKeyBySkillGroupNo(self._key, level)
    if false == skillKey:isDefined() then
      return
    end
    local skillNo = skillKey:getSkillNo()
    local skillSSW = getSkillStaticStatus(skillNo, 1)
    if nil ~= skillSSW then
      self:updateSkillCCType(skillSSW)
    end
    PaGlobal_SkillGroup._selectSkillNo = skillNo
    PaGloabl_SkillGroup_ShowDesc(skillNo)
  else
    local level = self._selectLevel + 1
    if level > self._maxLevel then
      level = self._maxLevel
    end
    self:selectLevel(level)
    local skillKey = ToClient_getSkillKeyBySkillGroupNo(self._key, level)
    if false == skillKey:isDefined() then
      return
    end
    local skillNo = skillKey:getSkillNo()
    local skillSSW = getSkillStaticStatus(skillNo, 1)
    if nil ~= skillSSW then
      self:updateSkillCCType(skillSSW)
    end
    PaGlobal_SkillGroup._selectSkillNo = skillNo
    PaGloabl_SkillGroup_ShowDesc(skillNo)
  end
end
function SkillGroup:HandleEventLUp_BlackSpiritLock()
end
function SkillGroup:HandleEventLUp_SkillCommandLock()
  local currentLevel = self:getCurrentGroupLevel()
  local skillKey = ToClient_getSkillKeyBySkillGroupNo(self._key, currentLevel)
  if false == skillKey:isDefined() then
    return
  end
  local skillNo = skillKey:getSkillNo()
  local skillLevelInfo = getSkillLevelInfo(skillNo)
  if nil ~= skillLevelInfo then
    local isBlockSkill = ToClient_isBlockSkillCommand(skillLevelInfo._skillKey)
    if isBlockSkill then
      ToClient_enableSkillCommand(skillLevelInfo._skillKey)
    else
      ToClient_blockSkillCommand(skillLevelInfo._skillKey)
    end
  end
  self:selectLevel(currentLevel)
end
function SkillGroup:showLock(isShow)
  local currentLevel = self._selectLevel
  local skillKey = ToClient_getSkillKeyBySkillGroupNo(self._key, currentLevel)
  if false == skillKey:isDefined() then
    return
  end
  local skillNo = skillKey:getSkillNo()
  local skillLevelInfo = getSkillLevelInfo(skillNo)
  local skillTypeSSW = getSkillTypeStaticStatus(skillNo)
  if nil ~= skillTypeSSW then
    if skillTypeSSW:isSkillCommandCheck() then
      local isBlockSkill = ToClient_isBlockSkillCommand(skillLevelInfo._skillKey)
      if isBlockSkill then
        self._check_command:SetShow(true)
      elseif false == skillLevelInfo._learnable and skillLevelInfo._usable and isShow then
        self._check_command:SetShow(true)
      else
        self._check_command:SetShow(false)
      end
      self._check_command:SetCheck(isBlockSkill)
    else
      self._check_command:SetShow(false)
    end
  end
end
function SkillGroup:cannotLernSkill(branchType)
  local messageBoxData = {
    content = "",
    functionYes = function()
      PaGlobal_SkillGroup_SelectType:close()
    end,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  if __eSkillTypeParam_Inherit == branchType then
    messageBoxData.content = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_MUST_SELECT_TREE", "type", PAGetString(Defines.StringSheet_GAME, "LUA_SUCCESSION"))
  elseif __eSkillTypeParam_Awaken == branchType then
    messageBoxData.content = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_MUST_SELECT_TREE", "type", PAGetString(Defines.StringSheet_GAME, "LUA_AWAKEN"))
  end
  MessageBox.showMessageBox(messageBoxData)
end
function SkillGroup:selectLevel(level, isLearnSkill)
  local skillKey = ToClient_getSkillKeyBySkillGroupNo(self._key, level)
  if false == skillKey:isDefined() then
    return
  end
  local skillNo = skillKey:getSkillNo()
  local skillTypeSSW = getSkillTypeStaticStatus(skillNo)
  if nil ~= skillTypeSSW then
    self._slot:setSkillTypeStatic(skillTypeSSW)
    local txt_skillName = UI.getChildControl(self._groupBg, "StaticText_SkillName")
    txt_skillName:SetTextMode(__eTextMode_Limit_AutoWrap)
    if 1 == self._maxLevel then
      txt_skillName:SetSize(self._txt_originSizeX + 40, txt_skillName:GetSizeY())
    end
    self._name = skillTypeSSW:getName()
    txt_skillName:SetText(skillTypeSSW:getName())
  end
  local skillLevelInfo = getSkillLevelInfo(skillNo)
  local skillSSW = getSkillStaticStatus(skillNo, 1)
  local skillTypeStatic = skillTypeSSW:get()
  if true == skillSSW:isUseableActiveSkill() then
    if nil ~= self._useableEffectID and 0 ~= self._useableEffectID then
      self._groupBg:EraseEffect(self._useableEffectID)
    end
  elseif nil ~= self._useableEffectID and 0 ~= self._useableEffectID then
    self._groupBg:EraseEffect(self._useableEffectID)
    self._useableEffectID = 0
  end
  if nil == skillTypeSSW then
    return
  end
  if true == skillTypeSSW:isSkillCommandCheck() then
    local isBlockSkill = ToClient_isBlockSkillCommand(skillLevelInfo._skillKey)
    if isBlockSkill then
      self._check_command:SetShow(true)
    elseif false == skillLevelInfo._learnable and true == skillLevelInfo._usable and PaGlobal_SkillGroup._mouseOnSkillGroupNo == self._key then
      self._check_command:SetShow(true)
    else
      self._check_command:SetShow(false)
    end
    self._check_command:SetCheck(isBlockSkill)
  else
    self._check_command:SetShow(false)
  end
  local txt_needPoint = UI.getChildControl(self._groupBg, "StaticText_SkillPoint")
  local isLearnedSkill = ToClient_isLearnedSkill(skillNo)
  local playerSkillType = ToClient_GetCurrentPlayerSkillType()
  local branchType = skillSSW:getSkillAwakenBranchType()
  local isOtherBranch = 0 < PaGlobal_SkillGroup._isShowTreeSelectBookmark and branchType ~= __eSkillTypeParam_Normal and branchType ~= PaGlobal_SkillGroup._selectedTree
  if true == isLearnedSkill and false == isOtherBranch then
    txt_needPoint:SetShow(false)
    self._btn_learn:SetShow(false)
    self._slot.icon:addInputEvent("Mouse_RUp", "HandleMRUp_SkillGroupWindow_ClearButtonClick(" .. skillNo .. ")")
    local skillTypeStaticWrapper = getSkillTypeStaticStatus(skillNo)
    if false == skillLevelInfo._learnable and skillLevelInfo._usable and skillTypeStaticWrapper:get()._isSettableQuickSlot then
      self._slot.icon:addInputEvent("Mouse_PressMove", "HandleEventLUp_SkillGroup_StartDrag(" .. skillNo .. ")")
      self._slot.icon:SetEnableDragAndDrop(true)
    else
      self._slot.icon:addInputEvent("Mouse_PressMove", "")
      self._slot.icon:SetEnableDragAndDrop(false)
    end
    local nextSkillKey = ToClient_getNextLevelSkill(self._key, level)
    local canLearnNextLevel = true
    if true == nextSkillKey:isDefined() then
      local nextSkillNo = nextSkillKey:getSkillNo()
      local nextSkillLevelInfo = getSkillLevelInfo(nextSkillNo)
      local nextSkillSSW = getSkillStaticStatus(nextSkillNo, 1)
      if nil ~= nextSkillLevelInfo and true == nextSkillLevelInfo._learnable and false == nextSkillLevelInfo._usable then
        self._slot.icon:addInputEvent("Mouse_LUp", "PaGlobal_SkillGroup:HandleEventLUp_SkillGroup(" .. self._key .. "," .. nextSkillNo .. ")")
        self._btn_learn:SetIgnore(true)
        self._btn_learn:SetShow(true)
      else
        self._slot.icon:addInputEvent("Mouse_LUp", "PaGlobal_SkillGroup:HandleEventLUp_SkillGroup(" .. self._key .. ")")
        self._btn_learn:SetShow(false)
        self._btn_learn:SetIgnore(false)
      end
    else
      self._slot.icon:addInputEvent("Mouse_LUp", "PaGlobal_SkillGroup:HandleEventLUp_SkillGroup(" .. self._key .. ")")
    end
  else
    if nil ~= skillSSW then
      txt_needPoint:SetText(tostring(skillSSW:get()._needSkillPointForLearning) .. "P")
      txt_needPoint:SetShow(false)
    else
      txt_needPoint:SetText("")
    end
    if nil == skillLevelInfo then
      return
    end
    if true == skillLevelInfo._learnable then
      if true == isOtherBranch then
        self._btn_learn:SetShow(false)
        self._btn_learn:SetIgnore(false)
      else
        self._btn_learn:SetShow(true)
        self._btn_learn:SetIgnore(true)
      end
    else
      self._btn_learn:SetShow(false)
      self._btn_learn:SetIgnore(false)
    end
    self._slot.icon:addInputEvent("Mouse_PressMove", "")
    self._slot.icon:addInputEvent("Mouse_RUp", "")
    self._slot.icon:SetEnableDragAndDrop(false)
  end
  if true == isOtherBranch then
    self._slot.icon:addInputEvent("Mouse_LUp", "SkillGroup:cannotLernSkill(" .. branchType .. ")")
    self._groupBg:SetMonoTone(true, true)
    self._slot.icon:SetMonoTone(true, true)
    self._ableQuickSlotEffect:SetMonoTone(true, true)
  elseif true == isLearnedSkill then
    if true == skillTypeStatic:isActiveSkill() and true == skillTypeStatic._isSettableQuickSlot then
      self._ableQuickSlotEffect:SetShow(true)
    else
      self._ableQuickSlotEffect:SetShow(false)
    end
    self._groupBg:SetMonoTone(false)
    self._slot.icon:SetMonoTone(false)
    self._ableQuickSlotEffect:SetMonoTone(false)
  elseif true == skillLevelInfo._learnable then
    self._slot.icon:addInputEvent("Mouse_LUp", "PaGlobal_SkillGroup:HandleEventLUpLearnSkill(" .. skillNo .. ")")
    self._groupBg:SetMonoTone(false)
    self._slot.icon:SetMonoTone(true, true)
    self._ableQuickSlotEffect:SetMonoTone(true, true)
  else
    self._slot.icon:addInputEvent("Mouse_LUp", "PaGlobal_SkillGroup:HandleEventLUpLearnSkill(" .. skillNo .. ")")
    self._groupBg:SetMonoTone(true, true)
    self._slot.icon:SetMonoTone(true, true)
    self._ableQuickSlotEffect:SetMonoTone(true, true)
  end
  if true == isLearnSkill then
    self._slot.icon:EraseAllEffect()
    audioPostEvent_SystemUi(4, 2)
    self._slot.icon:AddEffect("fUI_NewSkill_New_Skill_01A", false, 0, 0)
    self._slot.icon:AddEffect("", false, 0, 0)
    self._slot.icon:AddEffect("fUI_NewSkill_New_Skill_Slot_01A", false, 0, 0)
  end
  for ii = 1, self._maxLevel do
    local circle = self._circle[ii]
    local skillKey = ToClient_getSkillKeyBySkillGroupNo(self._key, ii)
    if true == skillKey:isDefined() then
      local isLearn = ToClient_isLearnedSkill(skillKey:getSkillNo())
      circle._default:SetShow(false == isLearn)
      circle._learn:SetShow(true == isLearn)
    else
      circle._default:SetShow(true)
      circle._learn:SetShow(false)
    end
  end
  self._slot.icon:addInputEvent("Mouse_On", "SkillGroup:HandleMOver_SkillGroupWindow_ToolTipShow(" .. skillNo .. ", " .. self._key .. ")")
  self._slot.icon:addInputEvent("Mouse_Out", "HandleMOver_SkillWindow_ToolTipHide(" .. skillNo .. ", \"SkillBox\")")
  self._focus:SetPosX(self._circle[level]._default:GetPosX() - 2)
  self._focus:SetPosY(self._circle[level]._default:GetPosY() - 2)
  self._focus:SetShow(true)
  self._selectLevel = level
end
function SkillGroup:HandleMOver_SkillGroupWindow_ToolTipShow(skillNo, key)
  self._mouseOnSkillGroupNo = key
  HandleMOver_SkillWindow_ToolTipShow(skillNo, false, "SkillBox")
end
function SkillGroup:SetPosX(posX)
  self._groupBg:SetPosX(posX)
end
function SkillGroup:SetPosY(posY)
  self._groupBg:SetPosY(posY)
end
function SkillGroup:SetShow(isShow)
  self._groupBg:SetShow(isShow)
end
function SkillGroup:registerEvent(key)
  self._groupBg:addInputEvent("Mouse_On", "PaGlobal_SkillGroup:HandleMOver_SkillGroupOn(" .. key .. ")")
  self._groupBg:addInputEvent("Mouse_LUp", "PaGlobal_SkillGroup:HandleEventLUp_SkillGroup(" .. key .. ")")
  self._btn_prev:addInputEvent("Mouse_LUp", "PaGlobal_SkillGroup:HandleEventLUp_PrevLevelButton(" .. key .. ")")
  self._btn_next:addInputEvent("Mouse_LUp", "PaGlobal_SkillGroup:HandleEventLUp_NextLevelButton(" .. key .. ")")
  self._check_blackSpirit:addInputEvent("Mouse_LUp", "PaGlobal_SkillGroup:HandleEventLUp_BlackSpiritLock(" .. key .. ")")
  self._check_command:addInputEvent("Mouse_LUp", "PaGlobal_SkillGroup:HandleEventLUp_SkillCommandLock(" .. key .. ")")
end
