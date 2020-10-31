function LoadComplete_SkillWindow_Initialize()
  PaGlobal_Skill:initialize()
  PaGlobal_AwakenSkill:initalize()
  PaGlobal_SuccessionSkill:initalize()
  Skill_RegistEventHandler()
end
function SkillEvent_SkillWindow_ControlInitialize()
  local self = PaGlobal_Skill
  if self.controlInitialize then
    return
  end
  self:initTabControl_Combat()
  self:initTabControl_AwakeningWeapon()
  self:initTabControl_Succession()
  self:initTabControl_Combination(true)
  self.slotConfig.template.effect:SetShow(false)
  self.slotConfig.template.iconFG:SetShow(false)
  self.slotConfig.template.iconFGDisabled:SetShow(false)
  self.slotConfig.template.learnButton:SetShow(false)
  self.slotConfig.template.lockIcon:SetShow(false)
  self.radioButtons[self.eTabIndex.combat]:SetCheck(true)
  self.radioButtons[self.eTabIndex.awaken]:SetCheck(false)
  self.radioButtons[self.eTabIndex.succession]:SetCheck(false)
  PaGlobal_Skill:setPreSkillList()
  HandleMLUp_SkillWindow_UpdateData(self.eTabIndex.combat, false, true)
  self._btn_MovieToolTipDesc:SetTextMode(__eTextMode_AutoWrap)
  self._btn_MovieToolTipDesc:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SKILL_MOVIETOOLTIP"))
  self.controlInitialize = true
end
function SkillEvent_SkillWindow_LearnQuest(skillNo)
  local skillTypeStaticWrapper = getSkillTypeStaticStatus(skillNo)
  if false == skillTypeStaticWrapper:isValidLocalizing() then
    return
  end
  local self = PaGlobal_Skill
  if nil ~= self.skillNoSlot[skillNo] then
    audioPostEvent_SystemUi(4, 2)
    self.skillNoSlot[skillNo].icon:AddEffect("UI_NewSkill01", false, 0, 0)
    self.skillNoSlot[skillNo].icon:AddEffect("fUI_NewSkill01", false, 0, 0)
    PaGlobal_Window_Skill_CoolTimeSlot:skillUpdate()
  end
  UI_MAIN_checkSkillLearnable()
end
function SkillEvent_SkillWindow_ClearSkill(skillPointType)
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
    functionYes = Skill_ClearSkill_ConfirmFromMessageBox,
    functionCancel = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageboxData)
  PaGlobal_Skill._isLevelupEffect = false
end
function Handle_SkillEnable_CoolTime_Change()
  if true == Panel_EnableSkill:GetShow() then
    Panel_EnableSkill:SetShow(false)
    PaGlobal_Window_Skill_CoolTimeSlot:showFunc()
  else
    Panel_EnableSkill:SetShow(true)
    PaGlobal_Window_Skill_CoolTimeSlot:closeFunc()
  end
  Panel_SkillCombination:SetShow(false)
end
function SkillEvent_SkillWindow_ClearSkillsByPoint()
  HandleMLUp_SkillWindow_UpdateData()
end
function SkillEvent_SkillWindow_SetTopGuide(tabIndex)
  local self = PaGlobal_Skill
  local selfPlayerSkillType = ToClient_GetSelfPlayerSkillType()
  if PaGlobal_Skill.eTabIndex.combat == tabIndex or __eSkillTypeParam_Normal == selfPlayerSkillType then
    self._txt_topGuide:SetShow(false)
    return
  else
    if PaGlobal_Skill.eTabIndex.succession == tabIndex and __eSkillTypeParam_Inherit == selfPlayerSkillType or PaGlobal_Skill.eTabIndex.awaken == tabIndex and __eSkillTypeParam_Awaken == selfPlayerSkillType then
      self._txt_topGuide:SetShow(false)
      return
    end
    self._txt_topGuide:SetShow(true)
    local guideText = ""
    if __eSkillTypeParam_Awaken == selfPlayerSkillType then
      guideText = PAGetString(Defines.StringSheet_GAME, "LUA_SKILL_SKILLALERT_SUCCESSION")
    elseif __eSkillTypeParam_Inherit == selfPlayerSkillType then
      guideText = PAGetString(Defines.StringSheet_GAME, "LUA_SKILL_SKILLALERT_AWAKEN")
    end
    self._txt_topGuide:SetText(guideText)
  end
end
function SkillEvent_SkillWindow_SetTranscendenceIcon(tabIndex)
  local self = PaGlobal_Skill
  local selfPlayerSkillType = ToClient_GetSelfPlayerSkillType()
  if __eSkillTypeParam_Inherit == selfPlayerSkillType and PaGlobal_Skill.eTabIndex.combat == tabIndex then
    for idx = 1, #self.preSkillList do
      local skillNo = self.preSkillList[idx]
      local slot = self.slots[tabIndex][skillNo]
      if nil ~= slot then
        if nil == slot.transcendenceIcon then
          local parent = slot.icon:getParent()
          slot.transcendenceIcon = UI.createControl(__ePAUIControl_Static, parent, "Static_TranscendenceIcon" .. skillNo)
          CopyBaseProperty(self._stc_transcendenceIcon, slot.transcendenceIcon)
        end
        slot.transcendenceIcon:SetShow(true)
        slot.transcendenceIcon:SetPosXY(slot.icon:GetPosX() + 8.5, slot.icon:GetPosY() + 8.5)
      end
    end
  end
end
function HandleEventLUp_SkillWindow_Tab(tabIndex, isLearnMode, doForce)
  PaGlobal_Skill._isLevelupEffect = false
  HandleMLUp_SkillWindow_UpdateData(tabIndex, isLearnMode, doForce)
end
function HandleMLUp_SkillWindow_UpdateData(tabIndex, isLearnMode, doForce)
  local self = PaGlobal_Skill
  tabIndex = tabIndex or self.lastTabIndex
  self.tabIndex = tabIndex
  isLearnMode = isLearnMode or self.lastLearnMode
  doForce = doForce or false
  if not doForce and not Panel_Window_Skill:GetShow() then
    return
  end
  self.lastTabIndex = tabIndex
  self.lastLearnMode = isLearnMode
  PaGlobal_Skill:setPreSkillList()
  SkillEvent_SkillWindow_SetTopGuide(tabIndex)
  if false == PaGlobal_Skill._isLevelupEffect then
    self:resetSkillWindowEffect()
  end
  for index, frame in pairs(self.frames) do
    if tabIndex == index then
      frame:SetShow(true)
      PaGlobal_Skill.radioButtons[index]:SetCheck(true)
    else
      frame:SetShow(false)
      PaGlobal_Skill.radioButtons[index]:SetCheck(false)
    end
  end
  self.learnableSlotsSortList = {}
  self.learnableSlotsSortListCount = 0
  local slots = self.slots[tabIndex]
  for skillNo, slot in pairs(slots) do
    slot.iconMinus:SetShow(false)
    slot.icon:addInputEvent("Mouse_LUp", "HandleMLUp_SkillWindow_LearnButtonClick(" .. skillNo .. ")")
    slot.icon:EraseAllEffect()
    if nil ~= slot.transcendenceIcon then
      slot.transcendenceIcon:SetShow(false)
    end
    local skillLevelInfo = getSkillLevelInfo(skillNo)
    if nil ~= skillLevelInfo then
      self.saved_isLearnMode = isLearnMode
      local resultAble = slot:setSkill(skillLevelInfo, isLearnMode)
      if false == resultAble then
        self.learnableSlotsSortList[self.learnableSlotsSortListCount] = skillNo
        self.learnableSlotsSortListCount = self.learnableSlotsSortListCount + 1
      end
      local skillTypeStaticWrapper = getSkillTypeStaticStatus(skillNo)
      if false == skillLevelInfo._learnable and skillLevelInfo._usable and skillTypeStaticWrapper:get()._isSettableQuickSlot then
        slot.icon:addInputEvent("Mouse_PressMove", "HandleMLUp_SkillWindow_StartDrag(" .. skillNo .. ")")
        slot.icon:SetEnableDragAndDrop(true)
      else
        slot.icon:addInputEvent("Mouse_PressMove", "")
        slot.icon:SetEnableDragAndDrop(false)
      end
      local skillStaticWrapper = getSkillStaticStatus(skillNo, 1)
      if nil ~= skillStaticWrapper then
        local function changeTextureLockIcon(isBlockSkill, isLearnable, isUseable)
          if isBlockSkill then
            slot.lockIcon:SetShow(true)
            slot.lockIcon:ChangeTextureInfoName("renewal/pcremaster/remaster_btn_00.dds")
            local x1, y1, x2, y2 = setTextureUV_Func(slot.lockIcon, 364, 177, 382, 195)
            slot.lockIcon:getBaseTexture():setUV(x1, y1, x2, y2)
            slot.lockIcon:setRenderTexture(slot.lockIcon:getBaseTexture())
            slot.lockIcon:ChangeOnTextureInfoName("renewal/pcremaster/remaster_btn_00.dds")
            local x1, y1, x2, y2 = setTextureUV_Func(slot.lockIcon, 364, 177, 382, 195)
            slot.lockIcon:getOnTexture():setUV(x1, y1, x2, y2)
            slot.lockIcon:ChangeClickTextureInfoName("renewal/pcremaster/remaster_btn_00.dds")
            local x1, y1, x2, y2 = setTextureUV_Func(slot.lockIcon, 364, 110, 382, 128)
            slot.lockIcon:getClickTexture():setUV(x1, y1, x2, y2)
            slot.lockIcon:addInputEvent("Mouse_LUp", "Request_SkillCommandLock(" .. skillNo .. ")")
            slot.lockIcon:addInputEvent("Mouse_On", "SkillCommandTooltip(" .. skillNo .. ", " .. tabIndex .. ", true )")
            slot.lockIcon:addInputEvent("Mouse_Out", "SkillCommandTooltip(" .. skillNo .. ", " .. tabIndex .. ", false )")
          elseif false == isLearnable and skillLevelInfo._usable then
            slot.lockIcon:SetShow(false)
            slot.lockIcon:ChangeTextureInfoName("renewal/pcremaster/remaster_btn_00.dds")
            local x1, y1, x2, y2 = setTextureUV_Func(slot.lockIcon, 364, 110, 382, 128)
            slot.lockIcon:getBaseTexture():setUV(x1, y1, x2, y2)
            slot.lockIcon:setRenderTexture(slot.lockIcon:getBaseTexture())
            slot.lockIcon:ChangeOnTextureInfoName("renewal/pcremaster/remaster_btn_00.dds")
            local x1, y1, x2, y2 = setTextureUV_Func(slot.lockIcon, 383, 110, 401, 128)
            slot.lockIcon:getOnTexture():setUV(x1, y1, x2, y2)
            slot.lockIcon:ChangeClickTextureInfoName("renewal/pcremaster/remaster_btn_00.dds")
            local x1, y1, x2, y2 = setTextureUV_Func(slot.lockIcon, 364, 177, 382, 195)
            slot.lockIcon:getClickTexture():setUV(x1, y1, x2, y2)
            slot.lockIcon:addInputEvent("Mouse_LUp", "Request_SkillCommandLock(" .. skillNo .. ")")
            slot.lockIcon:addInputEvent("Mouse_On", "SkillCommandTooltip(" .. skillNo .. ", " .. tabIndex .. ", true )")
            slot.lockIcon:addInputEvent("Mouse_Out", "SkillCommandTooltip(" .. skillNo .. ", " .. tabIndex .. ", false )")
          else
            slot.lockIcon:SetShow(false)
            slot.lockIcon:addInputEvent("Mouse_LUp", "")
          end
        end
        local skillTypeStaticStatusWrapper = skillStaticWrapper:getSkillTypeStaticStatusWrapper()
        if skillTypeStaticStatusWrapper:isSkillCommandCheck() then
          local isBlockSkill = ToClient_isBlockSkillCommand(skillLevelInfo._skillKey)
          changeTextureLockIcon(isBlockSkill, skillLevelInfo._learnable, skillLevelInfo._usable)
        end
      end
    end
    self.skillNoSlot[skillNo] = slot
  end
  SkillEvent_SkillWindow_SetTranscendenceIcon(tabIndex)
  self:UpdateLearnableSlots()
  local selfPlayer = getSelfPlayer()
  local posY = 75
  if nil == selfPlayer then
    self.staticRemainPoint:SetShow(false)
    self.staticSkillLevel:SetShow(false)
    self.progressSkillExp:SetShow(false)
  else
    self.staticSkillLevel:SetShow(false)
    self.progressSkillExp:SetShow(false)
    local skillPointInfo = ToClient_getSkillPointInfo(0)
    if nil ~= skillPointInfo then
      self.staticRemainPoint:SetText(tostring(skillPointInfo._remainPoint .. " / " .. skillPointInfo._acquirePoint))
      if true == PaGlobal_SuccessionSkill_IsCheckOpenContents() then
        self.staticRemainPoint:SetPosX(Panel_Window_Skill:GetSizeX() - self.staticRemainPoint:GetTextSizeX() - 40)
        self.textSkillPoint:SetPosX(self.staticRemainPoint:GetPosX() - self.textSkillPoint:GetTextSizeX() - 10)
        self.textSkillPoint:SetSize(self.textSkillPoint:GetTextSizeX(), self.textSkillPoint:GetSizeY())
        self.staticRemainPoint:SetPosY(600)
        self.textSkillPoint:SetPosY(600)
      else
        self.staticRemainPoint:SetPosX(self._btn_Enable_CoolTime_Change:GetPosX() - self.staticRemainPoint:GetTextSizeX() - 30)
        self.textSkillPoint:SetPosX(self.staticRemainPoint:GetPosX() - self.textSkillPoint:GetTextSizeX() - 30)
        self.textSkillPoint:SetSize(self.textSkillPoint:GetTextSizeX(), self.textSkillPoint:GetSizeY())
        if false == _ContentsGroup_skillOldandNew then
          posY = 60
        end
        self.staticRemainPoint:SetPosY(posY)
        self.textSkillPoint:SetPosY(posY)
      end
    end
  end
  if self.isPartsSkillReset then
    self:SkillWindow_UpdateClearData()
  end
  self.awakenDesc:SetShow(false)
  PaGlobal_Window_Skill_CoolTimeSlot:skillUpdate()
end
function PAGlobalFunc_BlackSkillLock(skillNo)
  local skillLevelInfo = getSkillLevelInfo(skillNo)
  if nil ~= skillLevelInfo then
    local isBlockSkill = ToClient_isBlockBlackSpiritSkill(skillLevelInfo._skillKey)
    if isBlockSkill then
      ToClient_enableblockBlackSpiritSkill(skillLevelInfo._skillKey)
    else
      ToClient_blockBlackSpiritSkill(skillLevelInfo._skillKey)
    end
  end
end
function Request_SkillCommandLock(skillNo)
  local skillLevelInfo = getSkillLevelInfo(skillNo)
  if nil ~= skillLevelInfo then
    local isBlockSkill = ToClient_isBlockSkillCommand(skillLevelInfo._skillKey)
    if isBlockSkill then
      ToClient_enableSkillCommand(skillLevelInfo._skillKey)
    else
      ToClient_blockSkillCommand(skillLevelInfo._skillKey)
    end
    local function changeTextureLockIcon(isBlockSkill)
      local slot = PaGlobal_Skill.skillNoSlot[skillNo]
      if isBlockSkill then
        slot.lockIcon:ChangeTextureInfoName("renewal/pcremaster/remaster_btn_00.dds")
        local x1, y1, x2, y2 = setTextureUV_Func(slot.lockIcon, 364, 177, 382, 195)
        slot.lockIcon:getBaseTexture():setUV(x1, y1, x2, y2)
        slot.lockIcon:setRenderTexture(slot.lockIcon:getBaseTexture())
        slot.lockIcon:ChangeOnTextureInfoName("renewal/pcremaster/remaster_btn_00.dds")
        local x1, y1, x2, y2 = setTextureUV_Func(slot.lockIcon, 364, 177, 382, 195)
        slot.lockIcon:getOnTexture():setUV(x1, y1, x2, y2)
        slot.lockIcon:ChangeClickTextureInfoName("renewal/pcremaster/remaster_btn_00.dds")
        local x1, y1, x2, y2 = setTextureUV_Func(slot.lockIcon, 364, 110, 382, 128)
        slot.lockIcon:getClickTexture():setUV(x1, y1, x2, y2)
      else
        slot.lockIcon:ChangeTextureInfoName("renewal/pcremaster/remaster_btn_00.dds")
        local x1, y1, x2, y2 = setTextureUV_Func(slot.lockIcon, 364, 110, 382, 128)
        slot.lockIcon:getBaseTexture():setUV(x1, y1, x2, y2)
        slot.lockIcon:setRenderTexture(slot.lockIcon:getBaseTexture())
        slot.lockIcon:ChangeOnTextureInfoName("renewal/pcremaster/remaster_btn_00.dds")
        local x1, y1, x2, y2 = setTextureUV_Func(slot.lockIcon, 383, 110, 401, 128)
        slot.lockIcon:getOnTexture():setUV(x1, y1, x2, y2)
        slot.lockIcon:ChangeClickTextureInfoName("renewal/pcremaster/remaster_btn_00.dds")
        local x1, y1, x2, y2 = setTextureUV_Func(slot.lockIcon, 364, 177, 382, 195)
        slot.lockIcon:getClickTexture():setUV(x1, y1, x2, y2)
      end
    end
    changeTextureLockIcon(not isBlockSkill)
    TooltipSimple_Hide()
  end
end
function SkillCommandTooltip(skillNo, tabIndex, isShow)
  if not isShow then
    local skillLevelInfo = getSkillLevelInfo(skillNo)
    local isBlockSkill = ToClient_isBlockSkillCommand(skillLevelInfo._skillKey)
    if not isBlockSkill then
      PaGlobal_Skill.skillNoSlot[skillNo].lockIcon:SetShow(false)
    else
      PaGlobal_Skill.skillNoSlot[skillNo].lockIcon:SetShow(true)
    end
    TooltipSimple_Hide()
    return
  end
  local skillLevelInfo = getSkillLevelInfo(skillNo)
  if nil ~= skillLevelInfo then
    local name, desc, uiControl
    local isBlockSkill = ToClient_isBlockSkillCommand(skillLevelInfo._skillKey)
    if isBlockSkill then
      name = PAGetString(Defines.StringSheet_GAME, "LUA_SKILL_COMMANDLOCK_TITLE")
      desc = PAGetString(Defines.StringSheet_GAME, "LUA_SKILL_COMMANDLOCK_DESC")
    else
      name = PAGetString(Defines.StringSheet_GAME, "LUA_SKILL_COMMANDUNLOCK_TITLE")
      desc = PAGetString(Defines.StringSheet_GAME, "LUA_SKILL_COMMANDUNLOCK_DESC")
    end
    uiControl = PaGlobal_Skill.slots[tabIndex][skillNo].lockIcon
    TooltipSimple_Show(uiControl, name, desc)
  end
end
function HandleMLUp_SkillWindow_OpenForLearn()
  local self = PaGlobal_Skill
  local screenSizeX = getScreenSizeX()
  local screenSizeY = getScreenSizeY()
  self.saved_isLearnMode = true
  PaGlobal_Skill._isLevelupEffect = false
  if not Panel_Window_Skill:IsShow() then
    UIAni.fadeInSCRDialog_Down(Panel_Window_Skill)
    Panel_Window_Skill:SetShow(true, IsAniUse())
    if screenSizeX <= 1400 then
      Panel_Window_Skill:SetPosX(screenSizeX / 2 - Panel_Window_Skill:GetSizeX() / 2 - 100)
    else
      Panel_Window_Skill:SetPosX(screenSizeX / 2 - Panel_Window_Skill:GetSizeX() / 2 - 150)
    end
    Panel_Window_Skill:SetPosY(screenSizeY / 2 - Panel_Window_Skill:GetSizeY() / 2)
    EnableSkillShowFunc()
    Panel_EnableSkill_SetPosition()
    self:OpenLearnAni1()
    self:OpenLearnAni2()
  end
  HandleMLUp_SkillWindow_UpdateData(self.tabIndex, true)
  for i = self.eTabIndex.combat, self.eTabIndex.loopCount do
    if self.radioButtons[i]:IsCheck() then
      HandleMLUp_SkillWindow_UpdateData(i)
      break
    end
  end
  if false == _ContentsGroup_UISkillGroupTreeLayOut then
    FGlobal_SetUrl_Tooltip_SkillForLearning()
  end
end
function HandleMLUp_SkillWindow_Close(isManualClick)
  if nil == Panel_Window_Skill or false == Panel_Window_Skill:GetShow() then
    return
  end
  if Panel_Window_Skill:IsShow() then
    PaGlobal_Skill.isPartsSkillReset = false
    local self = PaGlobal_Skill
    self.lastLearnMode = true
    self.saved_isLearnMode = true
    Panel_SkillTooltip_Hide()
    UIMain_SkillPointUpdateRemove()
    Panel_Window_Skill:SetShow(false, IsAniUse())
    Panel_SkillCombination:SetShow(false)
    Panel_SkillCombination._isFirstOpen = false
    Panel_SkillCombination._currentSlotIndex = -1
    Panel_Scroll:SetShow(false, false)
    FGlobal_EnableSkillCloseFunc()
    PaGlobal_Window_Skill_CoolTimeSlot:closeFunc()
    if true == _ContentsGroup_NewUI_BlackSpiritSkillLock_All then
      PaGlobalFunc_BlackSpiritSkillLock_All_Close()
    else
      FGlobal_BlackSpiritSkillLock_Close()
    end
    if nil ~= Panel_Npc_Dialog and true == Panel_Npc_Dialog:GetShow() then
      Dialog_updateButtons()
    end
    if nil ~= Panel_Npc_Dialog_All and true == Panel_Npc_Dialog_All:GetShow() then
      PaGlobalFunc_DialogMain_All_BottomFuncBtnUpdate()
    end
  end
  PaGlobal_Skill._isLevelupEffect = false
  for _, value in pairs(PaGlobal_Skill.skillNoSlot) do
    value.icon:EraseAllEffect()
  end
  HelpMessageQuestion_Out()
  local vScroll = PaGlobal_Skill.frames[0]:GetVScroll()
  PaGlobal_Skill.scrollPos = 0
  if false == _ContentsGroup_UISkillGroupTreeLayOut then
    FGlobal_ResetUrl_Tooltip_SkillForLearning()
  end
  TooltipSimple_Hide()
  if true == _ContentsGroup_NewUI_Dialog_All then
    PaGlobalFunc_DialogMain_All_SubPanelSetShow(true)
  end
end
function HandleMOver_SkillWindow_ToolTipHide(skillNo, SlotType, isFusion)
  if PaGlobal_Skill.skillNoCache == skillNo and PaGlobal_Skill.slotTypeCache == SlotType then
    PaGlobal_Skill.tooltipcacheCount = PaGlobal_Skill.tooltipcacheCount - 1
  else
    PaGlobal_Skill.tooltipcacheCount = 0
  end
  if PaGlobal_Skill.tooltipcacheCount <= 0 then
    Panel_SkillTooltip_Hide()
  end
  for _, value in pairs(PaGlobal_Skill.skillNoSlot) do
    value.iconMinus:SetShow(false)
  end
  local skillLevelInfo = getSkillLevelInfo(skillNo)
  if isFusion then
    return
  end
  if nil == skillLevelInfo then
    return
  end
  local isBlockSkill = ToClient_isBlockSkillCommand(skillLevelInfo._skillKey)
  if not isBlockSkill and not Panel_Tooltip_SimpleText:GetShow() then
    local skillStaticWrapper = getSkillStaticStatus(skillNo, 1)
    if nil == skillStaticWrapper then
      return
    end
    local skillTypeStaticStatusWrapper = skillStaticWrapper:getSkillTypeStaticStatusWrapper()
    if false == skillLevelInfo._learnable and skillLevelInfo._usable and skillTypeStaticStatusWrapper:isSkillCommandCheck() then
      PaGlobal_Skill.skillNoSlot[skillNo].lockIcon:SetShow(false)
    end
  end
end
function HandleMOver_SkillWindow_ToolTipShow(skillNo, isShowNextLevel, SlotType, isFusion)
  if PaGlobal_Skill.skillNoCache == skillNo and PaGlobal_Skill.slotTypeCache == SlotType then
    PaGlobal_Skill.tooltipcacheCount = PaGlobal_Skill.tooltipcacheCount + 1
  else
    PaGlobal_Skill.skillNoCache = skillNo
    PaGlobal_Skill.slotTypeCache = SlotType
    PaGlobal_Skill.tooltipcacheCount = 1
  end
  Panel_SkillTooltip_Show(skillNo, false, SlotType)
  if false == isFusion then
    PaGlobal_Skill.skillNoSlot[skillNo].icon:EraseAllEffect()
  end
  if "SkillBoxBottom" == SlotType then
    local selectedSlot = UI.getChildControl(PaGlobal_Skill.frames[0]:GetFrameContent(), "StaticSkill_" .. skillNo)
    PaGlobal_Skill:Skill_WindowPosSet(selectedSlot:GetPosY())
  end
  local skillLevelInfo = getSkillLevelInfo(skillNo)
  if nil == skillLevelInfo then
    return
  end
  if isFusion then
    return
  end
  if skillLevelInfo._usable then
    local isAwakenSkillBtn = PaGlobal_Skill.radioButtons[PaGlobal_Skill.eTabIndex.awaken]:IsCheck()
    local isSuccessionSkillBtn = PaGlobal_Skill.radioButtons[PaGlobal_Skill.eTabIndex.succession]:IsCheck()
    local slots
    if isAwakenSkillBtn then
      slots = PaGlobal_Skill.slots[PaGlobal_Skill.eTabIndex.awaken]
    elseif isSuccessionSkillBtn then
      slots = PaGlobal_Skill.slots[PaGlobal_Skill.eTabIndex.succession]
    else
      slots = PaGlobal_Skill.slots[PaGlobal_Skill.eTabIndex.combat]
    end
    local skillStaticWrapper = getSkillStaticStatus(skillNo, 1)
    if nil == skillStaticWrapper then
      return
    end
    if not skillStaticWrapper:isAutoLearnSkillByLevel() and not skillStaticWrapper:isLearnSkillByItem() and skillStaticWrapper:isLastSkill() then
      slots[skillNo].iconMinus:SetShow(true)
      if false == GlobalSwitch_UseDummyPlayerSkillWindow then
        slots[skillNo].icon:addInputEvent("Mouse_RUp", "HandleMLUp_SkillWindow_ClearButtonClick(" .. skillNo .. ")")
      else
        slots[skillNo].icon:addInputEvent("Mouse_RUp", "TestFunc_SkillAction(" .. skillNo .. ")")
      end
      Panel_SkillTooltip_Show(skillNo, false, SlotType, nil, true)
    end
  end
  local skillStaticWrapper = getSkillStaticStatus(skillNo, 1)
  local skillTypeStaticStatusWrapper = skillStaticWrapper:getSkillTypeStaticStatusWrapper()
  if false == skillLevelInfo._learnable and skillLevelInfo._usable and skillTypeStaticStatusWrapper:isSkillCommandCheck() then
    PaGlobal_Skill.skillNoSlot[skillNo].lockIcon:SetShow(true)
  end
end
function HandleMLUp_SkillWindow_LearnButtonClick(skillNo)
  audioPostEvent_SystemUi(0, 0)
  local skillTypeStaticWrapper = getSkillTypeStaticStatus(skillNo)
  if nil == skillTypeStaticWrapper then
    return
  end
  local skillLevelInfo = getSkillLevelInfo(skillNo)
  if nil == skillLevelInfo then
    return
  end
  local function NeedSkillEffect()
    if true == PaGlobal_SkillWindow_SkillFocusEffect(skillLevelInfo._needSkillNo1) then
      return
    end
    PaGlobal_SkillWindow_SkillFocusEffect(skillLevelInfo._needSkillNo2)
  end
  local learnedSkillLevel = getLearnedSkillLevel(skillTypeStaticWrapper)
  if false == skillLevelInfo._learnable and 0 == learnedSkillLevel then
    local resultString = SkillWindow_GetLearnSkillAlert(skillLevelInfo)
    if "" ~= resultString then
      local messageBoxMemo = resultString
      local messageBoxData = {
        title = PAGetString(Defines.StringSheet_GAME, "LUA_ALERT_DEFAULT_TITLE"),
        content = messageBoxMemo,
        functionYes = NeedSkillEffect,
        priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
      }
      MessageBox.showMessageBox(messageBoxData)
    end
    return
  end
  local function DolearnSkill()
    PaGlobal_Skill:SkillWindow_LearnButtonClick(skillNo)
    EnableSkillWindow_EffectOff()
  end
  local skillType = skillTypeStaticWrapper:requiredEquipType()
  if 55 == skillType then
    local messageBoxMemo = PAGetString(Defines.StringSheet_GAME, "LUA_SKILL_SKILLTYPE_MEMO1")
    local messageBoxData = {
      title = PAGetString(Defines.StringSheet_GAME, "LUA_WARNING"),
      content = messageBoxMemo,
      functionYes = DolearnSkill,
      functionNo = MessageBox_Empty_function,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageBoxData)
  elseif 56 == skillType then
    local messageBoxMemo = PAGetString(Defines.StringSheet_GAME, "LUA_SKILL_SKILLTYPE_MEMO2")
    local messageBoxData = {
      title = PAGetString(Defines.StringSheet_GAME, "LUA_WARNING"),
      content = messageBoxMemo,
      functionYes = DolearnSkill,
      functionNo = MessageBox_Empty_function,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageBoxData)
  else
    DolearnSkill()
  end
  PaGlobal_Skill._isLevelupEffect = false
end
function HandleMLUp_SkillWindow_ClearButtonClick(skillNo)
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  local function partlySkillReset()
    local returnValue = ToClient_RequestClearSkillPartly(skillNo)
    PaGlobal_Skill.isPartsSkillReset = false
    if 0 == returnValue then
      ToClient_clearSkillCoolTimeSlot(skillNo)
    end
  end
  partlySkillReset()
end
function HandleMLUp_SkillWindow_StartDrag(skillNo)
  if Defines.UIMode.eUIMode_NpcDialog == GetUIMode() then
    return
  end
  local skillLevelInfo = getSkillLevelInfo(skillNo)
  local skillTypeStaticWrapper = getSkillTypeStaticStatus(skillNo)
  if nil ~= skillLevelInfo and nil ~= skillTypeStaticWrapper then
    DragManager:setDragInfo(Panel_Window_Skill, nil, skillLevelInfo._skillKey:get(), "Icon/" .. skillTypeStaticWrapper:getIconPath(), Skill_GroundClick, nil)
  end
end
function HandleMScroll_SkillWindow_ScrollEvent(isShow)
  local vScroll = PaGlobal_Skill.frames[0]:GetVScroll()
  if isShow then
  else
    UIScrollButton.ScrollButtonEvent(false, Panel_Window_Skill, PaGlobal_Skill.frames[0], vScroll)
  end
end
function Skill_GroundClick(whereType, skillKey)
  if isUseNewQuickSlot() then
    FGlobal_SetNewQuickSlot_BySkillGroundClick(skillKey)
  end
end
function Skill_ClearSkill_ConfirmFromMessageBox()
  skillWindow_ClearSkill()
  if PaGlobal_Skill.radioButtons[PaGlobal_Skill.eTabIndex.combat]:IsCheck() then
    HandleMLUp_SkillWindow_UpdateData(PaGlobal_Skill.eTabIndex.combat)
  elseif PaGlobal_Skill.radioButtons[PaGlobal_Skill.eTabIndex.succession]:IsCheck() then
    HandleMLUp_SkillWindow_UpdateData(PaGlobal_Skill.eTabIndex.succession)
  else
    HandleMLUp_SkillWindow_UpdateData(PaGlobal_Skill.eTabIndex.awaken)
  end
end
function SkillWindow_GetLearnSkillAlert(skillLevelInfo)
  if false == _ContentsGroup_Succession then
    return ""
  end
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return ""
  end
  if false == PaGlobal_SuccessionSkill.classSuccessionSkill[selfPlayer:getClassType()] then
    return ""
  end
  if nil == skillLevelInfo then
    return ""
  end
  local needSkillString = ""
  local forbidSkillString = ""
  local resultString = ""
  local SkillStaticWrapper = getSkillStaticStatus(skillLevelInfo._needSkillNo1, 1)
  if nil ~= SkillStaticWrapper then
    needSkillString = SkillStaticWrapper:getName()
  end
  SkillStaticWrapper = getSkillStaticStatus(skillLevelInfo._needSkillNo2, 1)
  if nil ~= SkillStaticWrapper then
    if needSkillString ~= "" then
      needSkillString = needSkillString .. ", "
    end
    needSkillString = needSkillString .. SkillStaticWrapper:getName()
  end
  local index = 0
  local currentForbidSkillString = ""
  while true do
    local skillNo = skillLevelInfo:atValue(index)
    if 0 == skillNo or 10 < index then
      break
    end
    SkillStaticWrapper = getSkillStaticStatus(skillNo, 1)
    if nil ~= SkillStaticWrapper then
      currentForbidSkillString = SkillStaticWrapper:getName()
      if "" ~= currentForbidSkillString then
        if "" == forbidSkillString then
          forbidSkillString = currentForbidSkillString
        else
          forbidSkillString = forbidSkillString .. ", " .. currentForbidSkillString
        end
      end
    end
    index = index + 1
  end
  if "" ~= needSkillString then
    resultString = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_SKILL_SKILLALERT_01", "SkillName", needSkillString)
  end
  if "" ~= forbidSkillString then
    if "" == resultString then
      resultString = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_SKILL_SKILLALERT_02", "SkillName", forbidSkillString)
    else
      resultString = resultString .. "\n" .. PAGetStringParam1(Defines.StringSheet_GAME, "LUA_SKILL_SKILLALERT_02", "SkillName", forbidSkillString)
    end
  end
  return resultString
end
function Skill_RegistEventHandler()
  local vScroll = PaGlobal_Skill.frames[0]:GetVScroll()
  vScroll:addInputEvent("Mouse_LDown", "HandleMScroll_SkillWindow_ScrollEvent(true)")
  PaGlobal_Skill.buttonClose:addInputEvent("Mouse_LUp", "HandleMLUp_SkillWindow_Close( true )")
  PaGlobal_Skill._buttonQuestion:addInputEvent("Mouse_LUp", "Panel_WebHelper_ShowToggle( \"PanelWindowSkill\" )")
  PaGlobal_Util_RegistHelpTooltipEvent(PaGlobal_Skill._buttonQuestion, "\"PanelWindowSkill\"")
  PaGlobal_Skill.frames[0]:addInputEvent("Mouse_UpScroll", "HandleMScroll_SkillWindow_ScrollEvent(true)")
  PaGlobal_Skill.frames[0]:addInputEvent("Mouse_DownScroll", "HandleMScroll_SkillWindow_ScrollEvent(true)")
  PaGlobal_Skill.frames[0]:addInputEvent("Mouse_On", "HandleMScroll_SkillWindow_ScrollEvent(true)")
  PaGlobal_Skill.frames[0]:addInputEvent("Mouse_Out", "HandleMScroll_SkillWindow_ScrollEvent(false)")
  PaGlobal_Skill._btn_MovieToolTip:addInputEvent("Mouse_LUp", "PaGlobal_MovieSkillGuide_Web:Open()")
  PaGlobal_Skill._btn_MovieToolTip2:addInputEvent("Mouse_LUp", "PaGlobal_MovieSkillGuide_Web:Open()")
  if true == _ContentsGroup_skillOldandNew then
    if true == _ContentsGroup_NewUI_BlackSpiritSkillLock_All then
      PaGlobal_Skill._btn_BlackSpiritLock:addInputEvent("Mouse_LUp", "PaGlobalFunc_BlackSpiritSkillLock_All_Open(2)")
    else
      PaGlobal_Skill._btn_BlackSpiritLock:addInputEvent("Mouse_LUp", "FGlobal_BlackSpiritSkillLock_Open(2)")
    end
  end
  PaGlobal_Skill.radioButtons[PaGlobal_Skill.eTabIndex.combat]:addInputEvent("Mouse_LUp", "HandleEventLUp_SkillWindow_Tab(" .. PaGlobal_Skill.eTabIndex.combat .. ")")
  PaGlobal_Skill.radioButtons[PaGlobal_Skill.eTabIndex.awaken]:addInputEvent("Mouse_LUp", "HandleEventLUp_SkillWindow_Tab(" .. PaGlobal_Skill.eTabIndex.awaken .. ")")
  PaGlobal_Skill.radioButtons[PaGlobal_Skill.eTabIndex.succession]:addInputEvent("Mouse_LUp", "HandleEventLUp_SkillWindow_Tab(" .. PaGlobal_Skill.eTabIndex.succession .. ")")
  Panel_Window_Skill:RegisterShowEventFunc(true, "Skill_ShowAni()")
  Panel_Window_Skill:RegisterShowEventFunc(false, "Skill_HideAni()")
  PaGlobal_Skill._btn_ResetAllSkill:addInputEvent("Mouse_LUp", "SkillEvent_SkillWindow_ClearSkill(" .. 0 .. ")")
  PaGlobal_Skill._btn_ResetAllSkill:addInputEvent("Mouse_On", "SkillEvent_ResetTooltip( true )")
  PaGlobal_Skill._btn_ResetAllSkill:addInputEvent("Mouse_Out", "SkillEvent_ResetTooltip()")
  PaGlobal_Skill._btn_Enable_CoolTime_Change:addInputEvent("Mouse_LUp", "Handle_SkillEnable_CoolTime_Change()")
  PaGlobal_Skill._btn_Enable_CoolTime_Change:addInputEvent("Mouse_On", "Handle_SkillCollTimeTooltip( true )")
  PaGlobal_Skill._btn_Enable_CoolTime_Change:addInputEvent("Mouse_Out", "Handle_SkillCollTimeTooltip()")
end
function SkillEvent_ResetTooltip(isShow)
  if nil == isShow then
    TooltipSimple_Hide()
    return
  end
  local uiControl = PaGlobal_Skill._btn_ResetAllSkill
  local name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SKILL_RESETALL")
  local desc = PAGetString(Defines.StringSheet_GAME, "LUA_SKILL_RESETBUTTON_TOOLTIPDESC")
  TooltipSimple_Show(uiControl, name, desc)
end
function Handle_SkillCollTimeTooltip(isShow)
  if nil == isShow then
    TooltipSimple_Hide()
    return
  end
  local uiControl = PaGlobal_Skill._btn_Enable_CoolTime_Change
  local name = ""
  local desc = PAGetString(Defines.StringSheet_GAME, "LUA_SKILL_COOLTIMESLOT_TOOLTIPDESC")
  TooltipSimple_Show(uiControl, name, desc)
end
function SkillEvent_SkillWindow_ClearSkillMessage()
  Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_SKILL_RESETSUCCESS"))
  HandleMLUp_SkillWindow_UpdateData()
  PaGlobal_Window_Skill_CoolTimeSlot:skillUpdate()
end
function PaGlobal_SkillWindow_OpenForLearn(tabIndex)
  if nil == tabIndex then
    tabIndex = self.eTabIndex.combat
  end
  self.tabIndex = tabIndex
  HandleMLUp_SkillWindow_OpenForLearn()
end
function PaGlobal_SkillWindow_SkillFocusEffect(SkillNo, isLevelupEffect)
  if nil == isLevelupEffect then
    isLevelupEffect = false
  end
  PaGlobal_Skill._isLevelupEffect = isLevelupEffect
  local needSkill = getSkillStaticStatus(SkillNo, 1)
  if nil ~= needSkill and nil ~= PaGlobal_Skill.skillNoSlot[SkillNo] then
    local row = enableSkill_GetSkillRow(SkillNo)
    local needSkillType = needSkill:getSkillAwakenBranchType()
    PaGlobal_Skill:SkillWindowEffect(row, 1, SkillNo, true, needSkillType)
    return true
  end
  return false
end
function Skill_RegistMessageHandler()
  registerEvent("FromClient_luaLoadComplete", "LoadComplete_SkillWindow_Initialize")
  registerEvent("EventSkillWindowInit", "SkillEvent_SkillWindow_ControlInitialize")
  registerEvent("EventlearnedSkill", "SkillEvent_SkillWindow_LearnQuest")
  registerEvent("EventSkillWindowClearSkill", "SkillEvent_SkillWindow_ClearSkill")
  registerEvent("EventSkillWindowClearSkillByPoint", "HandleMLUp_SkillWindow_UpdateData")
  registerEvent("EventSkillWindowClearSkillAll", "SkillEvent_SkillWindow_ClearSkillMessage")
  registerEvent("EventSkillWindowUpdate", "HandleMLUp_SkillWindow_UpdateData")
  registerEvent("EventSkillWindowShowForLearn", "HandleMLUp_SkillWindow_OpenForLearn")
  registerEvent("FromClient_SkillWindowClose", "HandleMLUp_SkillWindow_UpdateData")
end
Skill_RegistMessageHandler()
