function PaGlobal_RandomBoxSelect_All:initialize()
  if nil == Panel_RandomBoxSelect_All or nil == Panel_Gacha_Roulette or true == self._initialize then
    return
  end
  self._ui.stc_title = UI.getChildControl(Panel_RandomBoxSelect_All, "Static_Text_Title")
  self._ui.btn_Close = UI.getChildControl(Panel_RandomBoxSelect_All, "Button_Win_Close_PCUI")
  self._ui.stc_SubFrame = UI.getChildControl(Panel_RandomBoxSelect_All, "Static_SubFrameBg")
  self._ui.stc_SelectRandomBoxBg = UI.getChildControl(Panel_RandomBoxSelect_All, "Static_SelectRandomBoxBG")
  self._ui.rdo_Normal = UI.getChildControl(Panel_RandomBoxSelect_All, "RadioButton_NormalRandomBox")
  self._ui.rdo_Speed = UI.getChildControl(Panel_RandomBoxSelect_All, "RadioButton_SpeedRandomBox")
  self._ui.rdo_Auto = UI.getChildControl(Panel_RandomBoxSelect_All, "RadioButton_AutoRandomBox")
  self._ui.stc_DescBG = UI.getChildControl(Panel_RandomBoxSelect_All, "StaticText_BottomDescBG")
  self._ui.txt_Desc = UI.getChildControl(self._ui.stc_DescBG, "StaticText_BottomDesc")
  self._ui.btn_Start = UI.getChildControl(Panel_RandomBoxSelect_All, "Button_StartRandomBox_PCUI")
  self._ui.btn_Cancel = UI.getChildControl(Panel_RandomBoxSelect_All, "Button_Cancel_PCUI")
  self._ui.stc_KeyGuide = UI.getChildControl(self._ui.stc_SubFrame, "Static_BottomBg_ConsoleUI")
  self._ui.stc_KeyGuide_A = UI.getChildControl(self._ui.stc_KeyGuide, "Button_OK_ConsoleUI")
  self._ui.stc_KeyGuide_B = UI.getChildControl(self._ui.stc_KeyGuide, "Button_NO_ConsoleUI")
  self._isConsole = _ContentsGroup_UsePadSnapping
  self._ui._gachaPanel.coverThis = UI.getChildControl(Panel_Gacha_Roulette, "Static_Cover")
  self._ui._gachaPanel.notify = UI.getChildControl(Panel_Gacha_Roulette, "StaticText_Notify")
  self._ui._gachaPanel.effectControl = UI.getChildControl(Panel_Gacha_Roulette, "Static_EffectControl")
  if false == self._isConsole then
    self._ui._gachaPanel.pushSpace = UI.getChildControl(Panel_Gacha_Roulette, "Static_PushSpace")
    self._ui.txt_Desc:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_RANDOMBOXSELECT_DESC"))
  else
    self._ui._gachaPanel.pushSpace = UI.getChildControl(Panel_Gacha_Roulette, "Static_PressA")
    self._ui.txt_Desc:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_XBOX1_RANDOMBOXSELECT_DESC"))
  end
  self._ui._gachaPanel.coverThis:SetIgnore(true)
  self._ui._gachaPanel.notify:SetNotAbleMasking(true)
  Panel_RandomBoxSelect_All:SetChildIndex(self._ui._gachaPanel.coverThis, 9999)
  self._ui.rdo_Normal:SetEnableArea(0, 0, self._ui.rdo_Normal:GetSizeX() + self._ui.rdo_Normal:GetTextSizeX() + 5, self._ui.rdo_Normal:GetSizeY())
  self._ui.rdo_Speed:SetEnableArea(0, 0, self._ui.rdo_Speed:GetSizeX() + self._ui.rdo_Speed:GetTextSizeX() + 5, self._ui.rdo_Speed:GetSizeY())
  self._ui.rdo_Auto:SetEnableArea(0, 0, self._ui.rdo_Auto:GetSizeX() + self._ui.rdo_Auto:GetTextSizeX() + 5, self._ui.rdo_Auto:GetSizeY())
  self._ui.txt_Desc:SetTextMode(__eTextMode_AutoWrap)
  self._ui.txt_Desc:SetText(self._ui.txt_Desc:GetText())
  local descSize = self._ui.txt_Desc:GetSizeY()
  self._ui.txt_Desc:SetSize(self._ui.txt_Desc:GetSizeX(), self._ui.txt_Desc:GetTextSizeY())
  Panel_RandomBoxSelect_All:SetSize(Panel_RandomBoxSelect_All:GetSizeX(), Panel_RandomBoxSelect_All:GetSizeY() - self._ui.rdo_Auto:GetSizeY() + 10)
  local gap = 0
  if descSize < self._ui.txt_Desc:GetTextSizeY() then
    gap = self._ui.txt_Desc:GetTextSizeY() - descSize
    self._ui.stc_DescBG:SetSize(self._ui.stc_DescBG:GetSizeX(), self._ui.txt_Desc:GetTextSizeY() + 10)
    Panel_RandomBoxSelect_All:SetSize(Panel_RandomBoxSelect_All:GetSizeX(), Panel_RandomBoxSelect_All:GetSizeY() + gap)
  end
  self._ui.stc_SubFrame:SetSize(self._ui.stc_SubFrame:GetSizeX(), Panel_RandomBoxSelect_All:GetSizeY() - (self._ui.stc_title:GetSizeY() + 30))
  self._ui.stc_DescBG:SetSpanSize(self._ui.stc_DescBG:GetSpanSize().x, self._ui.stc_DescBG:GetSpanSize().y - (self._ui.rdo_Auto:GetSizeY() + 5))
  self._ui.stc_SubFrame:ComputePos()
  self._ui.txt_Desc:ComputePos()
  self._ui.stc_DescBG:ComputePos()
  self._ui.btn_Start:ComputePos()
  self._ui.btn_Cancel:ComputePos()
  self._ui.stc_KeyGuide:ComputePos()
  self._ui.rdo_Auto:SetIgnore(true)
  self._ui.rdo_Auto:SetShow(false)
  self._ui.rdo_Normal:SetCheck(true)
  self._ui.btn_Start:SetShow(not self._isConsole)
  self._ui.btn_Cancel:SetShow(not self._isConsole)
  self._ui.btn_Close:SetShow(not self._isConsole)
  self._ui.stc_KeyGuide:SetShow(self._isConsole)
  PaGlobal_RandomBoxSelect_All:registerEventHandler()
  PaGlobal_RandomBoxSelect_All:validate()
  PaGlobal_RandomBoxSelect_All:createGachaSlot()
  ToClient_CloseRandomBox()
  self.rouletteState = self._rouletteState.eClose
end
function PaGlobal_RandomBoxSelect_All:createGachaSlot()
  for slotIdx = 0, self.maxSlotCount - 1 do
    slotBg = UI.createAndCopyBasePropertyControl(Panel_Gacha_Roulette, "Static_ItemSlot", Panel_Gacha_Roulette, "Static_ItemSlot_" .. slotIdx)
    slotBg:SetPosX(130)
    slotBg:SetPosY(-(self.slot_PosYGap * slotIdx))
    self.slotBGPool[slotIdx] = slotBg
    local slot = {}
    SlotItem.new(slot, "Static_ItemSlot_Item_" .. slotIdx, slotIdx, slotBg, self.slotConfing)
    slot:createChild()
    slot.icon:SetPosX(9)
    slot.icon:SetPosY(9)
    self.slotPool[slotIdx] = slot
  end
end
function PaGlobal_RandomBoxSelect_All:registerEventHandler()
  Panel_Gacha_Roulette:SetShow(false)
  Panel_Gacha_Roulette:setMaskingChild(true)
  registerEvent("onScreenResize", "PaGlobalFunc_RandomBoxSelect_All_OnScreenResize")
  registerEvent("FromClient_ShowRandomBox", "FromClient_RandomBoxSelect_All_Show")
  registerEvent("FromClient_SelectRandomItem", "FromClient_RandomBoxSelect_All_SelectRandomItem")
  registerEvent("FromClient_CloseRandomBox", "FromClient_RandomBoxSelect_All_Close")
  if true == self._isConsole then
    PaGlobal_registerPanelOnBlackBackground(Panel_RandomBoxSelect_All)
    Panel_RandomBoxSelect_All:ignorePadSnapMoveToOtherPanel()
    self._ui.rdo_Normal:addInputEvent("Mouse_On", "HandleEventPadPress_RandomBoxSelect_All_CheckOption(0)")
    self._ui.rdo_Speed:addInputEvent("Mouse_On", "HandleEventPadPress_RandomBoxSelect_All_CheckOption(1)")
    Panel_RandomBoxSelect_All:registerPadEvent(__eConsoleUIPadEvent_Up_A, "HandleEventLUp_RandomBoxSelect_All_Start()")
    PaGlobalFunc_ConsoleKeyGuide_SetAlign({
      self._ui.stc_KeyGuide_A,
      self._ui.stc_KeyGuide_B
    }, self._ui.stc_KeyGuide, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHT)
  else
    self._ui.btn_Start:addInputEvent("Mouse_LUp", "HandleEventLUp_RandomBoxSelect_All_Start()")
    self._ui.btn_Cancel:addInputEvent("Mouse_LUp", "HandleEventLUp_RandomBoxSelect_All_Close()")
    self._ui.btn_Close:addInputEvent("Mouse_LUp", "HandleEventLUp_RandomBoxSelect_All_Close()")
  end
  Panel_Gacha_Roulette:RegisterUpdateFunc("PaGlobalFunc_RandomBoxSelect_All_AniByDeltaTime")
end
function PaGlobal_RandomBoxSelect_All:validate()
  self._ui.stc_title:isValidate()
  self._ui.btn_Close:isValidate()
  self._ui.stc_SubFrame:isValidate()
  self._ui.stc_SelectRandomBoxBg:isValidate()
  self._ui.rdo_Normal:isValidate()
  self._ui.rdo_Speed:isValidate()
  self._ui.rdo_Auto:isValidate()
  self._ui.txt_Desc:isValidate()
  self._ui.btn_Start:isValidate()
  self._ui.btn_Cancel:isValidate()
end
function PaGlobal_RandomBoxSelect_All:prepareOpen()
  local isContinue = false
  if PaGlobal_RandomBoxSelect_All.rouletteState == PaGlobal_RandomBoxSelect_All._rouletteState.eWaitContinue then
    isContinue = true
  elseif PaGlobal_RandomBoxSelect_All.rouletteState == PaGlobal_RandomBoxSelect_All._rouletteState.eClose then
    isContinue = false
  else
    ToClient_CloseRandomBox()
    return
  end
  PaGlobal_RandomBoxSelect_All.rouletteState = PaGlobal_RandomBoxSelect_All._rouletteState.eClose
  local itemCount = ToClient_GetRandomItemListCount()
  if nil == itemCount or 0 == itemCount then
    ToClient_CloseRandomBox()
    return
  end
  if false == PaGlobal_RandomBoxSelect_All:checkInvenSize() then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_GACHA_ROULETTE_EMPTYSLOT"))
    PaGlobal_RandomBoxSelect_All:prepareClose()
    return
  end
  for slot_idx = 0, PaGlobal_RandomBoxSelect_All.maxSlotCount - 1 do
    local slotBg = PaGlobal_RandomBoxSelect_All.slotBGPool[slot_idx]
    slotBg:SetShow(false)
    local slot = PaGlobal_RandomBoxSelect_All.slotPool[slot_idx]
    slot:clearItem()
  end
  self.useSlotCount = itemCount
  while self.useSlotCount < self.rollSpeedInit do
    self.useSlotCount = self.useSlotCount + itemCount
  end
  local slotIndexList = {}
  for slot_idx = 0, self.useSlotCount - 1 do
    slotIndexList[slot_idx] = slot_idx % itemCount
  end
  for slot_idx = 0, self.useSlotCount * 2 - 1 do
    local ia = math.random(self.useSlotCount - 1)
    local ib = math.random(self.useSlotCount - 1)
    slotIndexList[ia], slotIndexList[ib] = slotIndexList[ib], slotIndexList[ia]
  end
  for slot_idx = 0, self.useSlotCount - 1 do
    local slotBg = self.slotBGPool[slot_idx]
    slotBg:SetShow(true)
    local slot = self.slotPool[slot_idx]
    local randomIndex = slotIndexList[slot_idx]
    local itemWrapper = ToClient_GetRandomItemListAt(randomIndex)
    slot:setItemByStaticStatus(itemWrapper, 1, -1)
    slot.icon:addInputEvent("Mouse_Out", "HandleEventLUp_RandomBoxSelect_All_ShowTooltip( false )")
  end
  if isContinue then
    InventoryWindow_Close()
    PaGlobal_RandomBoxSelect_All:gatchaPanelOpen()
    PaGlobal_RandomBoxSelect_All:close(self._ePanelType._modeSelect)
  else
    PaGlobal_RandomBoxSelect_All:open(self._ePanelType._modeSelect)
    PaGlobal_RandomBoxSelect_All:checkSelectMode()
  end
end
function PaGlobal_RandomBoxSelect_All:gatchaPanelOpen()
  PaGlobal_RandomBoxSelect_All:resetPos()
  self.rollSpeedCur = self.rollSpeedInit
  self.rollSpeedMin = 1
  self.rouletteState = self._rouletteState.eRoll
  self.elapsTime = 0
  PaGlobal_RandomBoxSelect_All:open(self._ePanelType._roulette)
  PaGlobalFunc_RandomBoxSelect_All_OnScreenResize()
  self._ui._gachaPanel.pushSpace:SetShow(false)
  self._ui._gachaPanel.notify:SetShow(false)
  self._ui._gachaPanel.pushSpace:SetVertexAniRun("Ani_Color_New", true)
  self._ui._gachaPanel.notify:SetVertexAniRun("Ani_Color_New", true)
  self._ui._gachaPanel.effectControl:EraseAllEffect()
  self._ui._gachaPanel.effectControl:AddEffect("fUI_Gacha_Spark01", true, 0, 50)
  if self.rouletteState == self._rouletteState.eRoll then
    SetUIMode(Defines.UIMode.eUIMode_Gacha_Roulette)
  end
end
function PaGlobal_RandomBoxSelect_All:checkSelectMode()
  if true == self._ui.rdo_Speed:IsCheck() then
    self.rollMode = 1
    self._ui.rdo_Speed:SetCheck(true)
    self._ui.rdo_Normal:SetCheck(false)
  elseif true == self._ui.rdo_Normal:IsCheck() then
    self.rollMode = 0
    self._ui.rdo_Speed:SetCheck(false)
    self._ui.rdo_Normal:SetCheck(true)
  else
    self.rollMode = 1
    self.autoSelectTimeCheck = 0
    self._ui.rdo_Speed:SetCheck(false)
    self._ui.rdo_Normal:SetCheck(false)
  end
end
function PaGlobal_RandomBoxSelect_All:checkInvenSize()
  if nil == Panel_Gacha_Roulette or nil == Panel_RandomBoxSelect_All then
    return false
  end
  local canRoulette = true
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return nil
  end
  local selfPlayerGet = selfPlayer:get()
  local inventory_normal = selfPlayerGet:getInventoryByType(CppEnums.ItemWhereType.eInventory)
  local inventory_cash = selfPlayerGet:getInventoryByType(CppEnums.ItemWhereType.eCashInventory)
  local freeCount_normal = inventory_normal:getFreeCount()
  local freeCount_cash = inventory_cash:getFreeCount()
  if freeCount_normal < 1 or freeCount_cash < 1 then
    canRoulette = false
  end
  return canRoulette
end
function PaGlobal_RandomBoxSelect_All:open(type)
  if self._ePanelType._modeSelect == type then
    Panel_RandomBoxSelect_All:SetShow(true)
  else
    Panel_Gacha_Roulette:SetShow(true)
  end
end
function PaGlobal_RandomBoxSelect_All:prepareClose()
  if false == Panel_RandomBoxSelect_All:GetShow() and false == Panel_Gacha_Roulette:GetShow() then
    return
  end
  SetUIMode(Defines.UIMode.eUIMode_Default)
  Panel_Tooltip_Item_hideTooltip()
  self.rouletteState = self._rouletteState.eClose
  PaGlobal_RandomBoxSelect_All:close(self._ePanelType._modeSelect)
  PaGlobal_RandomBoxSelect_All:close(self._ePanelType._roulette)
  CheckChattingInput()
  if ToClient_CloseRandomBox ~= nil then
    ToClient_CloseRandomBox()
  end
end
function PaGlobal_RandomBoxSelect_All:close(type)
  if self._ePanelType._modeSelect == type then
    Panel_RandomBoxSelect_All:SetShow(false)
  else
    Panel_Gacha_Roulette:SetShow(false)
  end
end
function PaGlobal_RandomBoxSelect_All:dataClear()
  self.rollMode = 1
  self.useSlotCount = 0
  self.rollSpeedCur = 0
  self.rollSpeedAccel = 0
  self.rollPos = 0.5
  self.pickItemKey = nil
  self.pickSlotIndex = 0
  self.elapsTime = 0
  PaGlobal_RandomBoxSelect_All:SetRollPos(0.5)
end
function PaGlobal_RandomBoxSelect_All:resetPos()
  if nil == Panel_Gacha_Roulette or nil == Panel_RandomBoxSelect_All then
    return
  end
  PaGlobal_RandomBoxSelect_All:SetRollPos(0.5)
  for slotIdx = 0, self.maxSlotCount - 1 do
    local slotBg = self.slotBGPool[slotIdx]
    slotBg:SetPosX(23)
    slotBg:SetPosY(-(self.slot_PosYGap * slotIdx))
    local slot = self.slotPool[slotIdx]
    slot.icon:SetPosX(115)
    slot.icon:SetPosY(0)
  end
end
function PaGlobal_RandomBoxSelect_All:SetRollPos(rollPosition)
  if nil == Panel_Gacha_Roulette or nil == Panel_RandomBoxSelect_All then
    return
  end
  self.rollPos = rollPosition
  self.rollPos = self.rollPos % self.useSlotCount
  local slot_CenterY = self._ui._gachaPanel.coverThis:GetPosY() + 18
  local rollSlot = math.floor(self.rollPos)
  local rollDecimal = self.rollPos - rollSlot
  local centerSlotY = slot_CenterY + (rollDecimal - 0.5) * self.slot_PosYGap
  local bottomSlot = rollSlot - math.floor(self.useSlotCount / 2)
  if bottomSlot < 0 then
    bottomSlot = bottomSlot + self.useSlotCount
  end
  local bottomSlotY = centerSlotY + math.floor(self.useSlotCount / 2) * self.slot_PosYGap
  for slotIdx = 0, self.useSlotCount - 1 do
    local slotBg = self.slotBGPool[slotIdx]
    local slotY = 0
    if slotIdx < bottomSlot then
      slotY = bottomSlotY - self.slot_PosYGap * (slotIdx - bottomSlot + self.useSlotCount)
    else
      slotY = bottomSlotY - self.slot_PosYGap * (slotIdx - bottomSlot)
    end
    slotBg:SetPosY(slotY)
  end
end
function PaGlobal_RandomBoxSelect_All:moveByDeltaTime(deltaTime)
  if nil == Panel_Gacha_Roulette or nil == Panel_RandomBoxSelect_All then
    return
  end
  if self.rouletteState == self._rouletteState.eRoll then
    PaGlobal_RandomBoxSelect_All:SetRollPos(self.rollPos + deltaTime * self.rollSpeedCur)
  elseif self.rouletteState == self._rouletteState.ePickAndSlow then
    if self.rollSpeedCur > self.rollSpeedMin then
      local rollSpeedPrev = self.rollSpeedCur
      self.rollSpeedCur = self.rollSpeedCur + deltaTime * self.rollSpeedAccel
      if self.rollSpeedCur < self.rollSpeedMin then
        self.rollSpeedCur = self.rollSpeedMin
      end
      local deltaPos = (self.rollSpeedCur * self.rollSpeedCur - rollSpeedPrev * rollSpeedPrev) / (2 * self.rollSpeedAccel)
      PaGlobal_RandomBoxSelect_All:SetRollPos(self.rollPos + deltaPos)
    else
      local speed = self.rollSpeedCur
      if self.rollPos > self.pickSlotIndex + 0.5 then
        speed = -self.rollSpeedCur
      end
      local deltaPos = deltaTime * self.rollSpeedCur
      if math.abs(self.pickSlotIndex + 0.5 - self.rollPos) > math.abs(deltaPos) then
        PaGlobal_RandomBoxSelect_All:SetRollPos(self.rollPos + deltaPos)
      else
        PaGlobal_RandomBoxSelect_All:SetRollPos(self.pickSlotIndex + 0.5)
        PaGlobalFunc_RandomBoxSelect_All_ShowResult()
      end
    end
  end
end
function PaGlobal_RandomBoxSelect_All:aniByDeltaTime(deltaTime)
  if nil == Panel_Gacha_Roulette or nil == Panel_RandomBoxSelect_All then
    return
  end
  self.elapsTime = self.elapsTime + deltaTime
  self.autoSelectTimeCheck = self.autoSelectTimeCheck + deltaTime
  if self.rouletteState == self._rouletteState.eRoll then
    self.soundPlayTime = self.soundPlayTime + deltaTime
    if self.soundPlayTime > 0.076 then
      audioPostEvent_SystemUi(11, 10)
      _AudioPostEvent_SystemUiForXBOX(11, 10)
      self.soundPlayTime = 0
    end
    if self.elapsTime > 1 and not self._ui._gachaPanel.pushSpace:GetShow() then
      self._ui._gachaPanel.pushSpace:SetShow(true)
      self._ui._gachaPanel.notify:SetShow(true)
    end
    local outIndex = 0
    PaGlobal_RandomBoxSelect_All:moveByDeltaTime(deltaTime)
  elseif self.rouletteState == self._rouletteState.ePickAndSlow then
    PaGlobal_RandomBoxSelect_All:moveByDeltaTime(deltaTime)
  elseif self.rouletteState == self._rouletteState.eResult then
    PaGlobal_RandomBoxSelect_All:SetRollPos(0.5 + self.pickSlotIndex)
    self.resultShowTime = self.resultShowTime + deltaTime
    if self.rollMode == 1 then
      if 1 < self.resultShowTime then
        self.resultShowTime = 0
        local isCanContinue = ToClient_IsCanContinueRandomBox()
        if self.rollMode == 1 and isCanContinue then
          self.rouletteState = self._rouletteState.eWaitContinue
          ToClient_ContinueRandomBox()
        else
          PaGlobal_RandomBoxSelect_All:prepareClose()
        end
      end
    elseif self.resultShowTime > 2.5 then
      self.resultShowTime = 0
      PaGlobal_RandomBoxSelect_All:prepareClose()
    end
  elseif self.rouletteState == self._rouletteState.eWaitContinue then
    PaGlobal_RandomBoxSelect_All:SetRollPos(0.5 + self.pickSlotIndex)
  end
  if self.rouletteState == self._rouletteState.eRoll then
    local autoLimitTime = string.format("%d", self.autoEndTime - self.elapsTime)
    if true == self._isConsole then
      self._ui._gachaPanel.notify:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_XBOX1_GACHA_ROULETTE_NOTIFY", "autoLimitTime", autoLimitTime))
    else
      self._ui._gachaPanel.notify:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GACHA_ROULETTE_NOTIFY", "autoLimitTime", autoLimitTime))
    end
    if self.autoEndTime < self.elapsTime then
      self.elapsTime = 0
      PaGlobal_RandomBoxSelect_All:prepareClose()
    end
  end
end
