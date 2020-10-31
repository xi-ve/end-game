function PaGlobal_MiniGame_Find_All:initialize()
  if nil == Panel_MiniGame_Find_All or true == self._initialize then
    return
  end
  self:controlAll_Init()
  self:controlPc_Init()
  self:controlConsole_Init()
  self:createSlot()
  self:createRewardSlot()
  self:controlSetShow()
  self:registerEventHandler()
  self:validate()
  self._miniGameResult_OriginSizeX = Panel_MiniGame_MiniGameResult:GetSizeX()
  self:initDescriptionFrame()
  self._initialize = true
end
function PaGlobal_MiniGame_Find_All:controlAll_Init()
  if nil == Panel_MiniGame_Find_All then
    return
  end
  self._ui._template._stc_openSlot = UI.getChildControl(Panel_MiniGame_Find_All, "Static_OpenSlot")
  self._ui._template._stc_closeSlot = UI.getChildControl(Panel_MiniGame_Find_All, "Static_CloseSlot")
  self._ui._stc_flower = UI.getChildControl(Panel_MiniGame_Find_All, "Static_Body")
  local rightBG = UI.getChildControl(Panel_MiniGame_Find_All, "Static_RightBg")
  local gradeBG = UI.getChildControl(rightBG, "Static_GradeBg")
  self._ui._txt_grade = UI.getChildControl(gradeBG, "MultilineText_GradeTitle")
  for gradeIdx = 1, 5 do
    self._ui._stc_grade[gradeIdx] = UI.getChildControl(gradeBG, "Static_Grade_" .. tostring(gradeIdx))
    self._ui._stc_grade[gradeIdx]:SetShow(false)
  end
  local scoreBG = UI.getChildControl(rightBG, "Static_ScoreBg")
  self._ui._txt_endurance = UI.getChildControl(scoreBG, "StaticText_DDPercent")
  self._ui._txt_RClickCnt = UI.getChildControl(scoreBG, "StaticText_RClickCount")
  local leftoverValueBg = UI.getChildControl(rightBG, "Static_LeftValueBg")
  self._ui._stc_emptyIcon = UI.getChildControl(leftoverValueBg, "StaticText_LandCountTitle")
  self._ui._txt_emptyCnt = UI.getChildControl(leftoverValueBg, "StaticText_LandCountValue")
  self._ui._stc_subObjIcon = UI.getChildControl(leftoverValueBg, "StaticText_RootCountTitle")
  self._ui._txt_subObjCnt = UI.getChildControl(leftoverValueBg, "StaticText_RootCountValue")
  self._ui._stc_trapIcon = UI.getChildControl(leftoverValueBg, "StaticText_StoneCountTitle")
  self._ui._txt_trapCnt = UI.getChildControl(leftoverValueBg, "StaticText_StoneCountValue")
  local bottomBG = UI.getChildControl(Panel_MiniGame_Find_All, "Static_GradeBg")
  self._ui._progress_damage = UI.getChildControl(bottomBG, "Progress2_DamageDegree")
  self._ui._template._stc_rewardSlot = UI.getChildControl(bottomBG, "Static_RewardSlotBg")
  self._ui._stc_rewardFocus = UI.getChildControl(bottomBG, "Static_CurrentSlotFocus")
  local commercialBG = UI.getChildControl(bottomBG, "StaticText_CommercialBg")
  self._ui._txt_commercial = UI.getChildControl(commercialBG, "StaticText_CommercialValue")
  self._ui._frame_desc = UI.getChildControl(Panel_MiniGame_Find_All, "Frame_Desc")
  self._ui._stc_maskBG = UI.getChildControl(Panel_MiniGame_Find_All, "Static_MaskBg")
  self._ui._stc_bubbleBG = UI.getChildControl(Panel_MiniGame_Find_All, "Static_Obsidian_B")
  self._ui._txt_bubbleChat = UI.getChildControl(self._ui._stc_bubbleBG, "StaticText_BubbleText")
  self._ui._stc_blackSpirit = UI.getChildControl(Panel_MiniGame_Find_All, "Static_Obsidian")
  for index = 1, self._tutorialCount do
    self._ui._tutorial[index]._stc_BG = UI.getChildControl(Panel_MiniGame_Find_All, "Static_TutorialStep_" .. tostring(index))
    self._ui._tutorial[index]._stc_maskingBG = UI.getChildControl(self._ui._tutorial[index]._stc_BG, "Static_MaskingBg")
    self._ui._tutorial[index]._stc_focusBox = UI.getChildControl(self._ui._tutorial[index]._stc_BG, "Static_Focus")
  end
  self._ui._stc_startMsg = UI.getChildControl(Panel_MiniGame_Find_All, "Static_Msg")
  self._ui._stc_timerMsg = UI.getChildControl(Panel_MiniGame_MiniGameResult, "StaticText_Msg")
end
function PaGlobal_MiniGame_Find_All:controlPc_Init()
  if nil == Panel_MiniGame_Find_All then
    return
  end
  local titleBG = UI.getChildControl(Panel_MiniGame_Find_All, "Static_Title_BG")
  self._ui_pc._btn_close = UI.getChildControl(titleBG, "Button_Close_PCUI")
  self._ui_pc._stc_startMsg_PCKey = UI.getChildControl(self._ui._stc_startMsg, "Static_PC_KeyGuide")
  local stc_MsgMouseL = UI.getChildControl(self._ui_pc._stc_startMsg_PCKey, "StaticText_MouseL_Desc")
  local stc_MsgMouseR = UI.getChildControl(self._ui_pc._stc_startMsg_PCKey, "StaticText_MouseR_Desc")
  stc_MsgMouseL:SetSpanSize(-1 * (stc_MsgMouseL:GetSizeX() + stc_MsgMouseL:GetTextSizeX() + 5), stc_MsgMouseL:GetSpanSize().y)
  stc_MsgMouseR:SetSpanSize(stc_MsgMouseR:GetSizeX(), stc_MsgMouseR:GetSpanSize().y)
  stc_MsgMouseL:ComputePos()
  stc_MsgMouseR:ComputePos()
  local rightBG = UI.getChildControl(Panel_MiniGame_Find_All, "Static_RightBg")
  self._ui_pc._stc_mouseLDesc = UI.getChildControl(rightBG, "StaticText_MouseL_Desc")
  self._ui_pc._stc_mouseRDesc = UI.getChildControl(rightBG, "StaticText_MouseR_Desc")
  self._gradeMouseArea_SizeX = rightBG:GetSizeX()
  self._gradeMouseL_DescSizeX = self._ui_pc._stc_mouseLDesc:GetSizeX() + self._ui_pc._stc_mouseLDesc:GetTextSizeX()
  self._gradeMouseR_DescSizeX = self._ui_pc._stc_mouseRDesc:GetSizeX() + self._ui_pc._stc_mouseRDesc:GetTextSizeX()
  local mouseDescSizeX = self._gradeMouseL_DescSizeX + self._gradeMouseR_DescSizeX
  if mouseDescSizeX > self._gradeMouseArea_SizeX then
    self._ui_pc._stc_mouseLDesc:SetSpanSize(self._ui._stc_trapIcon:GetSpanSize().x, self._ui_pc._stc_mouseRDesc:GetSizeY())
    self._ui_pc._stc_mouseRDesc:SetSpanSize(self._ui._stc_trapIcon:GetSpanSize().x, self._ui_pc._stc_mouseRDesc:GetSpanSize().y)
    self._ui_pc._stc_mouseLDesc:ComputePos()
    self._ui_pc._stc_mouseRDesc:ComputePos()
  end
end
function PaGlobal_MiniGame_Find_All:controlConsole_Init()
  if nil == Panel_MiniGame_Find_All then
    return
  end
  self._ui_console._stc_startMsg_ConsoleKey = UI.getChildControl(self._ui._stc_startMsg, "Static_Console_KeyGuide")
  local stc_MsgMouseL = UI.getChildControl(self._ui_console._stc_startMsg_ConsoleKey, "StaticText_MouseL_Desc")
  local stc_MsgMouseR = UI.getChildControl(self._ui_console._stc_startMsg_ConsoleKey, "StaticText_MouseR_Desc")
  stc_MsgMouseL:SetSpanSize(-1 * (stc_MsgMouseL:GetSizeX() + stc_MsgMouseL:GetTextSizeX() + 5), stc_MsgMouseL:GetSpanSize().y)
  stc_MsgMouseR:SetSpanSize(stc_MsgMouseR:GetSizeX(), stc_MsgMouseR:GetSpanSize().y)
  stc_MsgMouseL:ComputePos()
  stc_MsgMouseR:ComputePos()
  self._ui_console._stc_KeyGuide = UI.getChildControl(Panel_MiniGame_Find_All, "Static_Key_Guide_ConsoleUI")
  self._ui_console._stc_Key_Scroll = UI.getChildControl(self._ui_console._stc_KeyGuide, "StaticText_R_Scroll_ConsoleUI")
  self._ui_console._stc_Key_Reward = UI.getChildControl(self._ui_console._stc_KeyGuide, "StaticText_Y_ConsoleUI")
  self._ui_console._stc_Key_DeepDig = UI.getChildControl(self._ui_console._stc_KeyGuide, "StaticText_X_ConsoleUI")
  self._ui_console._stc_Key_ShallowDig = UI.getChildControl(self._ui_console._stc_KeyGuide, "StaticText_A_ConsoleUI")
  self._ui_console._stc_Key_Exit = UI.getChildControl(self._ui_console._stc_KeyGuide, "StaticText_B_ConsoleUI")
end
function PaGlobal_MiniGame_Find_All:controlSetShow()
  if nil == Panel_MiniGame_Find_All then
    return
  end
  self._ui._stc_maskBG:SetShow(false)
  self._ui._stc_startMsg:SetShow(false)
  self._ui_pc._btn_close:SetShow(not self._isConsole)
  self._ui_pc._stc_mouseLDesc:SetShow(not self._isConsole)
  self._ui_pc._stc_mouseRDesc:SetShow(not self._isConsole)
  self._ui_console._stc_KeyGuide:SetShow(self._isConsole)
  self._ui_pc._stc_startMsg_PCKey:SetShow(not self._isConsole)
  self._ui_console._stc_startMsg_ConsoleKey:SetShow(self._isConsole)
end
function PaGlobal_MiniGame_Find_All:registerEventHandler()
  if nil == Panel_MiniGame_Find_All then
    return
  end
  if true == self._isConsole then
    Panel_MiniGame_Find_All:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "HandleEventOnOut_Minigame_Find_All_ShowItemTooltip( true, nil )")
    Panel_MiniGame_Find_All:registerPadEvent(__eConsoleUIPadEvent_Up_B, "HandleEventLUp_Minigame_Find_All_AskGameClose()")
    Panel_MiniGame_Find_All:registerPadEvent(__eConsoleUIPadEvent_RStickUp, "HandleRSticEventUp_Minigame_Find_All_MoveScroll( true )")
    Panel_MiniGame_Find_All:registerPadEvent(__eConsoleUIPadEvent_RStickDown, "HandleRSticEventUp_Minigame_Find_All_MoveScroll( false )")
  else
    self._ui_pc._btn_close:addInputEvent("Mouse_LUp", "HandleEventLUp_Minigame_Find_All_AskGameClose()")
    self._ui._stc_maskBG:addInputEvent("Mouse_LUp", "HandleEventLUp_Minigame_Find_All_TutorialNextStep()")
  end
  registerEvent("FromClient_MiniGameFindSlotShowEmpty", "FromClient_Minigame_Find_All_SlotShowEmpty")
  registerEvent("FromClient_MiniGameFindSlotShowMain", "FromClient_Minigame_Find_All_SlotShowMain")
  registerEvent("FromClient_MiniGameFindSlotShowMainTexture", "FromClient_Minigame_Find_All_SlotShowMainTexture")
  registerEvent("FromClient_MiniGameFindSlotShowSub", "FromClient_Minigame_Find_All_SlotShowSub")
  registerEvent("FromClient_MiniGameFindSlotShowTrap", "FromClient_Minigame_Find_All_SlotShowTrap")
  registerEvent("FromClient_MiniGameFindSetShow", "FromClient_Minigame_Find_All_SetShow")
  registerEvent("FromClient_MiniGameFindSetReward", "FromClient_Minigame_Find_All_SetReward")
  registerEvent("FromClient_MiniGameFindSetState", "FromClient_Minigame_Find_All_SetState")
  registerEvent("FromClient_MiniGameFindDefaultImage", "FromClient_Minigame_Find_All_DefaultImage")
  registerEvent("FromClient_MiniGameFindDynamicInfo", "FromClient_Minigame_Find_All_DynamicInfo")
  registerEvent("FromClient_MiniGameFindStaticInfo", "FromClient_Minigame_Find_All_StaticInfo")
end
function PaGlobal_MiniGame_Find_All:prepareOpen(col, row)
  if nil == Panel_MiniGame_Find_All then
    return
  end
  self._curRClickCount = 0
  self._tmpRClickCount = 0
  self._gameState = self._state.Play
  for _, slot in pairs(self._damageSlot) do
    slot:SetShow(false)
  end
  self._damageSlot = {}
  self:refresh(col, row)
  self._isMainLoad = false
  self._curSec = 0
  self._tutorialTime = 0
  self._tutorialIndex = -1
  if false == _ContentsGroup_NewUI_Manufacture_All then
    if true == Panel_Manufacture:GetShow() then
      Manufacture_Close()
    end
  elseif true == Panel_Window_Manufacture_All:GetShow() then
    PaGlobalFunc_Manufacture_All_Close()
  end
  Panel_MiniGame_Find_All:RegisterUpdateFunc("PaGlobal_MiniGame_Find_All_Update")
  self._tutorialOpen = ToClient_getGameUIManagerWrapper():getLuaCacheDataListNumber(__eRakiaroTutorial)
  self._readyToEndGame = false
  self._readyToNextGame = false
  self:open()
end
function PaGlobal_MiniGame_Find_All:open()
  if nil == Panel_MiniGame_Find_All or true == Panel_MiniGame_Find_All:GetShow() then
    return
  end
  Panel_MiniGame_Find_All:SetShow(true)
end
function PaGlobal_MiniGame_Find_All:prepareClose()
  if nil == Panel_MiniGame_Find_All or false == Panel_MiniGame_Find_All:GetShow() then
    return
  end
  if true == self._isConsole then
    PaGlobalFunc_TooltipInfo_Close()
  else
    Panel_Tooltip_Item_hideTooltip()
  end
  self._gameState = self._state.None
  self._readyToNextGame = false
  self._readyToEndGame = false
  self._stateMsgKey = 0
  for _, slot in pairs(self._damageSlot) do
    slot:SetShow(false)
  end
  self._damageSlot = {}
  Panel_MiniGame_MiniGameResult:SetShow(false)
  ToClient_MiniGameFindHide()
  Panel_MiniGame_Find_All:ClearUpdateLuaFunc()
  self._ui._stc_maskBG:SetShow(false)
  self._ui._stc_blackSpirit:SetShow(false)
  self._ui._stc_bubbleBG:SetShow(false)
  for index = 1, self._tutorialCount do
    self._ui._tutorial[index]._stc_BG:SetShow(false)
  end
  self:close()
end
function PaGlobal_MiniGame_Find_All:close()
  if nil == Panel_MiniGame_Find_All or false == Panel_MiniGame_Find_All:GetShow() then
    return
  end
  Panel_MiniGame_Find_All:SetShow(false)
end
function PaGlobal_MiniGame_Find_All:validate()
  if nil == Panel_MiniGame_Find_All then
    return
  end
  self._ui._template._stc_openSlot:isValidate()
  self._ui._template._stc_closeSlot:isValidate()
  self._ui._template._stc_rewardSlot:isValidate()
  self._ui._stc_emptyIcon:isValidate()
  self._ui._txt_emptyCnt:isValidate()
  self._ui._stc_subObjIcon:isValidate()
  self._ui._txt_subObjCnt:isValidate()
  self._ui._stc_trapIcon:isValidate()
  self._ui._txt_trapCnt:isValidate()
  self._ui._txt_endurance:isValidate()
  self._ui._txt_RClickCnt:isValidate()
  self._ui._progress_damage:isValidate()
  self._ui._stc_rewardFocus:isValidate()
  self._ui._txt_commercial:isValidate()
  self._ui._stc_flower:isValidate()
  self._ui._stc_maskBG:isValidate()
  self._ui._stc_bubbleBG:isValidate()
  self._ui._txt_bubbleChat:isValidate()
  self._ui._stc_blackSpirit:isValidate()
  self._ui._stc_startMsg:isValidate()
  self._ui._stc_timerMsg:isValidate()
  for index = 1, self._tutorialCount do
    self._ui._tutorial[index]._stc_BG:isValidate()
    self._ui._tutorial[index]._stc_maskingBG:isValidate()
    self._ui._tutorial[index]._stc_focusBox:isValidate()
  end
  self._ui_pc._btn_close:isValidate()
end
function PaGlobal_MiniGame_Find_All:initDescriptionFrame()
  if nil == Panel_MiniGame_Find_All then
    return
  end
  local vScroll = self._ui._frame_desc:GetVScroll()
  local content = self._ui._frame_desc:GetFrameContent()
  local descBG = UI.getChildControl(content, "Static_DescBg")
  local txtDesc = UI.getChildControl(descBG, "StaticText_BottomDesc")
  local strDesc = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_MINIGAME_FINDROOT_DESC")
  local gabY = 10
  txtDesc:SetTextMode(__eTextMode_AutoWrap)
  txtDesc:SetText(strDesc)
  if false == self._isConsole then
    txtDesc:SetTextVerticalCenter()
    if descBG:GetSizeY() < txtDesc:GetTextSizeY() + gabY then
      local addSizeY = txtDesc:GetTextSizeY() + gabY - descBG:GetSizeY()
      local mainBg = UI.getChildControl(Panel_MiniGame_Find_All, "Static_MainBg")
      txtDesc:SetSize(txtDesc:GetSizeX(), txtDesc:GetTextSizeY())
      self._ui._frame_desc:SetSize(self._ui._frame_desc:GetSizeX(), self._ui._frame_desc:GetSizeY() + addSizeY)
      content:SetSize(content:GetSizeX(), content:GetSizeY() + addSizeY)
      descBG:SetSize(descBG:GetSizeX(), descBG:GetSizeY() + addSizeY)
      mainBg:SetSize(mainBg:GetSizeX(), mainBg:GetSizeY() + addSizeY)
      Panel_MiniGame_Find_All:SetSize(Panel_MiniGame_Find_All:GetSizeX(), Panel_MiniGame_Find_All:GetSizeY() + addSizeY)
      self._ui._frame_desc:ComputePos()
      content:ComputePos()
      descBG:ComputePos()
      txtDesc:ComputePos()
      mainBg:ComputePos()
      Panel_MiniGame_Find_All:ComputePos()
    end
  else
    if txtDesc:GetSizeY() < txtDesc:GetTextSizeY() then
      local textBGSizeY = txtDesc:GetTextSizeY() + gabY
      descBG:SetSize(descBG:GetSizeX(), textBGSizeY)
      content:SetSize(content:GetSizeX(), textBGSizeY)
      self._keyGuideList = {
        self._ui_console._stc_Key_Scroll,
        self._ui_console._stc_Key_Reward,
        self._ui_console._stc_Key_DeepDig,
        self._ui_console._stc_Key_ShallowDig,
        self._ui_console._stc_Key_Exit
      }
    else
      txtDesc:SetTextVerticalCenter()
      self._keyGuideList = {
        self._ui_console._stc_Key_Reward,
        self._ui_console._stc_Key_DeepDig,
        self._ui_console._stc_Key_ShallowDig,
        self._ui_console._stc_Key_Exit
      }
      self._ui_console._stc_Key_Scroll:SetShow(false)
    end
    PaGlobalFunc_ConsoleKeyGuide_SetAlign(self._keyGuideList, self._ui_console._stc_KeyGuide, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP)
    self._ui_console._stc_KeyGuide:ComputePos()
    local panelSize = Panel_MiniGame_Find_All:GetSizeY() + self._ui_console._stc_KeyGuide:GetSizeY()
    local screenSizeY = getScreenSizeY()
    local panelPosY = screenSizeY / 2 - panelSize / 2
    Panel_MiniGame_Find_All:SetPosY(panelPosY)
  end
  local frameSizeY = self._ui._frame_desc:GetSizeY()
  local contentSizeY = content:GetSizeY()
  UIScroll.SetButtonSize(vScroll, frameSizeY, contentSizeY)
  self._ui._frame_desc:UpdateContentPos()
  self._ui._frame_desc:UpdateContentScroll()
end
function PaGlobal_MiniGame_Find_All:createSlot()
  if nil == Panel_MiniGame_Find_All then
    return
  end
  for col = 0, self._config._slotCols - 1 do
    self._slots[col] = Array.new()
    for row = 0, self._config._slotRows - 1 do
      local slot = {
        close = nil,
        open = nil,
        damage = nil,
        isOpen = false
      }
      slot.close = UI.createControl(__ePAUIControl_Static, Panel_MiniGame_Find_All, "Slot_Close_" .. col .. "_" .. row)
      slot.open = UI.createControl(__ePAUIControl_Static, Panel_MiniGame_Find_All, "Slot_Open_" .. col .. "_" .. row)
      slot.damage = UI.createControl(__ePAUIControl_Static, Panel_MiniGame_Find_All, "Slot_Damage_" .. col .. "_" .. row)
      CopyBaseProperty(self._ui._template._stc_closeSlot, slot.close)
      CopyBaseProperty(self._ui._template._stc_openSlot, slot.open)
      CopyBaseProperty(self._ui._template._stc_closeSlot, slot.damage)
      slot.close:SetShow(false)
      slot.close:SetEnable(true)
      slot.open:SetShow(false)
      slot.open:SetEnable(false)
      slot.damage:SetShow(false)
      slot.damage:SetEnable(false)
      slot.isOpen = false
      if true == self._isConsole then
        slot.close:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandleEventLUp_Minigame_Find_All_CloseSlot(" .. col .. "," .. row .. "," .. self._clickType.LClcik .. ")")
        slot.close:registerPadEvent(__eConsoleUIPadEvent_Up_A, "HandleEventLUp_Minigame_Find_All_CloseSlot(" .. col .. "," .. row .. "," .. self._clickType.RClcik .. ")")
      else
        slot.close:addInputEvent("Mouse_On", "HandleEventOnOut_Minigame_Find_All_CloseSlot(" .. col .. "," .. row .. ", true)")
        slot.close:addInputEvent("Mouse_Out", "HandleEventOnOut_Minigame_Find_All_CloseSlot(" .. col .. "," .. row .. ", false)")
        slot.close:addInputEvent("Mouse_LUp", "HandleEventLUp_Minigame_Find_All_CloseSlot(" .. col .. "," .. row .. "," .. self._clickType.LClcik .. ")")
        slot.close:addInputEvent("Mouse_RUp", "HandleEventLUp_Minigame_Find_All_CloseSlot(" .. col .. "," .. row .. "," .. self._clickType.RClcik .. ")")
      end
      self._slots[col][row] = slot
    end
  end
  Panel_MiniGame_Find_All:SetChildIndex(self._ui._stc_maskBG, 9999)
  for index = 1, self._tutorialCount do
    Panel_MiniGame_Find_All:SetChildIndex(self._ui._tutorial[index]._stc_BG, 9999)
  end
  Panel_MiniGame_Find_All:SetChildIndex(self._ui._stc_bubbleBG, 9999)
  Panel_MiniGame_Find_All:SetChildIndex(self._ui._stc_blackSpirit, 9999)
  Panel_MiniGame_Find_All:SetChildIndex(self._ui._stc_flower, 9999)
  Panel_MiniGame_Find_All:SetChildIndex(self._ui._stc_startMsg, 9999)
end
function PaGlobal_MiniGame_Find_All:createRewardSlot()
  if nil == Panel_MiniGame_Find_All then
    return
  end
  self._ui._template._stc_rewardSlot:SetShow(false)
  for ii = 0, self._config._rewardMaxCount - 1 do
    local rewardSlot = {}
    local bottomBG = UI.getChildControl(Panel_MiniGame_Find_All, "Static_GradeBg")
    rewardSlot.BG = UI.createControl(__ePAUIControl_Static, bottomBG, "Static_RewardSlotBg_" .. ii)
    CopyBaseProperty(self._ui._template._stc_rewardSlot, rewardSlot.BG)
    rewardSlot.BG:SetPosX(755 - ii * 107)
    rewardSlot.BG:SetShow(true)
    SlotItem.new(rewardSlot, "RewardItemIcon_" .. ii, ii, rewardSlot.BG, self._rewardSlotConfig)
    rewardSlot:createChild()
    rewardSlot.icon:SetPosX(4)
    rewardSlot.icon:SetPosY(4)
    rewardSlot.icon:SetShow(true)
    rewardSlot.icon:addInputEvent("Mouse_On", "HandleEventOnOut_Minigame_Find_All_ShowItemTooltip( true, " .. ii .. " )")
    rewardSlot.icon:addInputEvent("Mouse_Out", "HandleEventOnOut_Minigame_Find_All_ShowItemTooltip( false )")
    self._rewardSlot[ii] = rewardSlot
  end
end
function PaGlobal_MiniGame_Find_All:refresh(slotMaxCol, slotMaxRow)
  if nil == Panel_MiniGame_Find_All then
    return
  end
  local slotSize = self._config._totalSlotSize / slotMaxCol
  for row = 0, self._config._slotRows - 1 do
    for col = 0, self._config._slotCols - 1 do
      local slot = self._slots[col][row]
      slot.isOpen = false
      if slotMaxCol <= col or slotMaxRow <= row then
        slot.close:SetShow(false)
        slot.close:SetEnable(false)
        slot.open:SetShow(false)
        slot.damage:SetShow(false)
      else
        slot.close:SetSize(slotSize, slotSize)
        slot.close:SetPosX(self._config._slotStartPosX + slotSize * col)
        slot.close:SetPosY(self._config._slotStartPosY + slotSize * row)
        slot.close:SetShow(true)
        slot.close:SetEnable(true)
        slot.close:setOnMouseCursorType(__eMouseCursorType_Dig)
        slot.close:setClickMouseCursorType(__eMouseCursorType_Dig)
        slot.open:SetSize(slotSize, slotSize)
        slot.open:SetPosX(self._config._slotStartPosX + slotSize * col)
        slot.open:SetPosY(self._config._slotStartPosY + slotSize * row)
        slot.open:SetShow(false)
        slot.damage:SetSize(slotSize, slotSize)
        slot.damage:SetPosX(self._config._slotStartPosX + slotSize * col)
        slot.damage:SetPosY(self._config._slotStartPosY + slotSize * row)
        slot.damage:SetShow(false)
      end
    end
  end
  self._curSlotSize = slotSize
  self._ui._stc_flower:SetSize(self._mainColCnt * slotSize + self._addSize, self._mainRowCnt * slotSize + self._addSize)
  if true == self._isConsole then
    for row = 4, 7 do
      for col = 4, 7 do
        local slot = self._slots[col][row]
        slot.open:SetIgnore(true)
        slot.close:SetIgnore(true)
        slot.damage:SetIgnore(true)
      end
    end
  end
end
function PaGlobal_MiniGame_Find_All:getRewardIndex(pct)
  if 100 == pct then
    return 0
  else
    for ii = 1, self._config._rewardMaxCount - 1 do
      if pct <= ii * 20 then
        return self._config._rewardMaxCount - ii
      end
    end
    return self._config._rewardMaxCount - 1
  end
end
function PaGlobal_MiniGame_Find_All:endGame()
  if nil == Panel_MiniGame_Find_All then
    return
  end
  for row = 0, self._config._slotRows - 1 do
    for col = 0, self._config._slotCols - 1 do
      local slot = self._slots[col][row]
      slot.close:SetEnable(false)
    end
  end
  audioPostEvent_SystemUi(11, 33)
  _AudioPostEvent_SystemUiForXBOX(11, 33)
end
function PaGlobal_MiniGame_Find_All:getWaitStateString(stringKey)
  if 1 == stringKey then
    return PAGetStringParam1(Defines.StringSheet_GAME, "LUA_MINIGAME_FIND_LEFTTIME", "second", math.floor(self._config._nextGameSec - self._curSec + 1))
  elseif 2 == stringKey then
    return PAGetStringParam1(Defines.StringSheet_GAME, "LUA_MINIGAME_FIND_LEFTTIME_01", "second", math.floor(self._config._nextGameSec - self._curSec + 1))
  elseif 3 == stringKey then
    return PAGetStringParam1(Defines.StringSheet_GAME, "LUA_MINIGAME_FIND_LEFTTIME_02", "second", math.floor(self._config._nextGameSec - self._curSec + 1))
  elseif 4 == stringKey then
  end
  return ""
end
function PaGlobal_MiniGame_Find_All:getNonStateString(stringKey)
  if 1 == stringKey then
    return PAGetString(Defines.StringSheet_GAME, "LUA_MINIGAME_FIND_FINISH")
  elseif 2 == stringKey then
    return PAGetString(Defines.StringSheet_GAME, "LUA_MINIGAME_FIND_FINISH_01")
  elseif 3 == stringKey then
    return PAGetString(Defines.StringSheet_GAME, "LUA_MINIGAME_FIND_FINISH_02")
  elseif 4 == stringKey then
  end
  return ""
end
function PaGlobal_MiniGame_Find_All:updateStateText(serverState)
  local strMsg = ""
  if serverState == self._state.None then
    strMsg = self:getNonStateString(self._stateMsgKey)
  elseif serverState == self._state.Wait then
    strMsg = self:getWaitStateString(self._stateMsgKey)
  end
  self._ui._stc_timerMsg:SetText(strMsg)
  Panel_MiniGame_MiniGameResult:SetSize(self._miniGameResult_OriginSizeX, Panel_MiniGame_MiniGameResult:GetSizeY())
  local panelSizeX = Panel_MiniGame_MiniGameResult:GetSizeX()
  local textSizeX = self._ui._stc_timerMsg:GetTextSizeX()
  local textLimitSizeX = getScreenSizeX() * 0.8
  if panelSizeX < textSizeX then
    if textSizeX > textLimitSizeX then
      self._ui._stc_timerMsg:SetSize(textSizeX * 0.5, self._ui._stc_timerMsg:GetSizeY())
      self._ui._stc_timerMsg:SetTextMode(__eTextMode_AutoWrap)
      self._ui._stc_timerMsg:SetText(strMsg)
      Panel_MiniGame_MiniGameResult:SetSize(self._ui._stc_timerMsg:GetTextSizeX(), Panel_MiniGame_MiniGameResult:GetSizeY())
    else
      Panel_MiniGame_MiniGameResult:SetSize(textSizeX, Panel_MiniGame_MiniGameResult:GetSizeY())
    end
    Panel_MiniGame_MiniGameResult:SetHorizonCenter()
    self._ui._stc_timerMsg:SetHorizonCenter()
  end
end
function PaGlobal_MiniGame_Find_All:tutorialUpdate(deltaTime)
  if -1 == self._tutorialIndex then
    self._tutorialTime = self._tutorialTime + deltaTime
    if self._tutorialTime > 0.5 then
      self._tutorialIndex = 0
      self:bubbleShow()
      self._tutorialTime = 0
    end
  end
end
function PaGlobal_MiniGame_Find_All:noneStateUpdate(deltaTime)
  if nil == Panel_MiniGame_Find_All then
    return
  end
  if self._gameState ~= self._state.None then
    return
  end
  if false == self._readyToEndGame then
    return
  end
  self._curSec = self._curSec + deltaTime
  if self._config._endGameSec <= self._curSec then
    PaGlobal_MiniGame_Find_All_Close()
  end
end
function PaGlobal_MiniGame_Find_All:waitStateUpdate(deltaTime)
  if nil == Panel_MiniGame_Find_All then
    return
  end
  if self._gameState ~= self._state.Wait then
    return
  end
  if false == self._readyToNextGame then
    return
  end
  self._curSec = self._curSec + deltaTime
  local strMsg = self:getWaitStateString(self._stateMsgKey)
  self._ui._stc_timerMsg:SetText(strMsg)
  if self._config._nextGameSec <= self._curSec then
    self:nextGameStart()
  end
end
function PaGlobal_MiniGame_Find_All:damageSlotUpdate(deltaTime)
  if nil == Panel_MiniGame_Find_All then
    return
  end
  if self._gameState ~= self._state.Play then
    return
  end
  if false == self._alphaDirChange then
    self._alphaValue = self._alphaValue + deltaTime / 2
    if self._alphaValue > 0.8 then
      self._alphaValue = 0.8
      self._alphaDirChange = true
    end
  else
    self._alphaValue = self._alphaValue - deltaTime / 2
    if self._alphaValue < 0 then
      self._alphaValue = 0
      self._alphaDirChange = false
    end
  end
  for _, slot in pairs(self._damageSlot) do
    slot:SetAlpha(self._alphaValue)
  end
end
function PaGlobal_MiniGame_Find_All:StartTutorial(index)
  if nil == Panel_MiniGame_Find_All then
    return
  end
  self._ui._tutorial[index + 1]._stc_BG:SetShow(true)
  self._ui._tutorial[index + 1]._stc_maskingBG:SetShow(false)
  self._ui._tutorial[index + 1]._stc_focusBox:SetShow(true)
  self._ui._tutorial[index + 1]._stc_focusBox:ResetVertexAni()
  self._ui._tutorial[index + 1]._stc_focusBox:SetVertexAniRun("Ani_Scale_New1", true)
  self._ui._tutorial[index + 1]._stc_focusBox:SetVertexAniRun("Ani_Move_Pos_New1", true)
end
function PaGlobal_MiniGame_Find_All:bubbleShow()
  if nil == Panel_MiniGame_Find_All then
    return
  end
  if 0 == self._tutorialIndex then
    self._ui._stc_maskBG:SetShow(true)
    self._ui._stc_blackSpirit:SetShow(true)
    self._ui._stc_blackSpirit:EraseAllEffect()
    self._ui._stc_blackSpirit:AddEffect("fUI_DarkSpirit_Tutorial", true, 0, 0)
    self._ui._stc_bubbleBG:SetShow(true)
    self._ui._txt_bubbleChat:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_MINIGAMEFIND_TUTORIALDESC_1"))
    if self._isConsole then
      Panel_MiniGame_Find_All:registerPadEvent(__eConsoleUIPadEvent_Up_A, "HandleEventLUp_Minigame_Find_All_TutorialNextStep()")
    end
    self:SetIgnoreSlotForConsole(true)
  elseif 1 == self._tutorialIndex then
    self._ui._stc_maskBG:SetShow(true)
    self._ui._stc_blackSpirit:SetShow(true)
    self._ui._stc_blackSpirit:EraseAllEffect()
    self._ui._stc_blackSpirit:AddEffect("fUI_DarkSpirit_Tutorial", true, 0, 0)
    self._ui._stc_bubbleBG:SetShow(true)
    self._ui._txt_bubbleChat:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_MINIGAMEFIND_TUTORIALDESC_2"))
    if not self._tutorialEffectShow then
      self:StartTutorial(0)
      self._tutorialEffectShow = true
    end
    self:SetIgnoreSlotForConsole(true)
  elseif 2 == self._tutorialIndex then
    self._ui._stc_maskBG:SetShow(true)
    self._ui._stc_blackSpirit:SetShow(true)
    self._ui._stc_blackSpirit:EraseAllEffect()
    self._ui._stc_blackSpirit:AddEffect("fUI_DarkSpirit_Tutorial", true, 0, 0)
    self._ui._stc_bubbleBG:SetShow(true)
    self._ui._txt_bubbleChat:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_MINIGAMEFIND_TUTORIALDESC_3"))
    if not self._tutorialEffectShow then
      self:StartTutorial(2)
      self._tutorialEffectShow = true
    end
    self:SetIgnoreSlotForConsole(true)
  elseif 3 == self._tutorialIndex then
    self._ui._stc_maskBG:SetShow(true)
    self._ui._stc_blackSpirit:SetShow(true)
    self._ui._stc_blackSpirit:EraseAllEffect()
    self._ui._stc_blackSpirit:AddEffect("fUI_DarkSpirit_Tutorial", true, 0, 0)
    self._ui._stc_bubbleBG:SetShow(true)
    self._ui._txt_bubbleChat:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_MINIGAMEFIND_TUTORIALDESC_4"))
    if not self._tutorialEffectShow then
      self:StartTutorial(2)
      self._tutorialEffectShow = true
    end
    self:SetIgnoreSlotForConsole(true)
  elseif 4 == self._tutorialIndex then
    self._ui._stc_maskBG:SetShow(true)
    self._ui._stc_blackSpirit:SetShow(true)
    self._ui._stc_blackSpirit:EraseAllEffect()
    self._ui._stc_blackSpirit:AddEffect("fUI_DarkSpirit_Tutorial", true, 0, 0)
    self._ui._stc_bubbleBG:SetShow(true)
    self._ui._txt_bubbleChat:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_MINIGAMEFIND_TUTORIALDESC_5"))
    if not self._tutorialEffectShow then
      self:StartTutorial(1)
      self._tutorialEffectShow = true
    end
    self:SetIgnoreSlotForConsole(true)
  elseif 5 == self._tutorialIndex then
    self._ui._stc_maskBG:SetShow(true)
    self._ui._stc_blackSpirit:SetShow(true)
    self._ui._stc_blackSpirit:EraseAllEffect()
    self._ui._stc_blackSpirit:AddEffect("fUI_DarkSpirit_Tutorial", true, 0, 0)
    self._ui._stc_bubbleBG:SetShow(true)
    self._ui._txt_bubbleChat:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_MINIGAMEFIND_TUTORIALDESC_6"))
    self._tutorialEffectShow = false
    self:SetIgnoreSlotForConsole(true)
  else
    self._ui._stc_maskBG:SetShow(false)
    self._ui._stc_blackSpirit:SetShow(false)
    self._ui._stc_blackSpirit:EraseAllEffect()
    self._ui._stc_bubbleBG:SetShow(false)
    ToClient_getGameUIManagerWrapper():setLuaCacheDataListNumber(__eRakiaroTutorial, 1, CppEnums.VariableStorageType.eVariableStorageType_User)
    self._tutorialOpen = 1
    self:StartMsg(0, 0.2)
    self:HideMsg(4, 5)
    if self._isConsole then
      Panel_MiniGame_Find_All:registerPadEvent(__eConsoleUIPadEvent_Up_A, "")
    end
    self:SetIgnoreSlotForConsole(false)
  end
  local textSizeX = self._ui._txt_bubbleChat:GetTextSizeX()
  local textSizeY = self._ui._txt_bubbleChat:GetTextSizeY()
  self._ui._txt_bubbleChat:SetSize(textSizeX, textSizeY)
  self._ui._stc_bubbleBG:SetSize(textSizeX + 25, textSizeY + 50)
  self._ui._stc_bubbleBG:ComputePosAllChild()
end
function PaGlobal_MiniGame_Find_All:SetIgnoreSlotForConsole(isIgnore)
  if nil == Panel_MiniGame_Find_All then
    return
  end
  if false == self._isConsole then
    return
  end
  for col = 0, self._config._slotCols - 1 do
    for row = 0, self._config._slotRows - 1 do
      local slot = self._slots[col][row]
      if nil ~= slot then
        slot.open:SetIgnore(isIgnore)
        slot.close:SetIgnore(isIgnore)
        slot.damage:SetIgnore(isIgnore)
      end
    end
  end
  for row = 4, 7 do
    for col = 4, 7 do
      local slot = self._slots[col][row]
      slot.open:SetIgnore(true)
      slot.close:SetIgnore(true)
      slot.damage:SetIgnore(true)
    end
  end
end
function PaGlobal_MiniGame_Find_All:StartMsg(startTime, endTime)
  if nil == Panel_MiniGame_Find_All then
    return
  end
  local control = self._ui._stc_startMsg
  local closeAni = control:addColorAnimation(startTime, endTime, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
  closeAni:SetStartColor(Defines.Color.C_00FFFFFF)
  closeAni:SetEndColor(Defines.Color.C_FFFFFFFF)
  closeAni.IsChangeChild = true
  closeAni:SetDisableWhileAni(true)
  local showAni = control:addMoveAnimation(startTime, endTime, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
  showAni:SetStartPosition(control:GetPosX(), control:GetPosY() - control:GetSizeY())
  showAni:SetEndPosition(control:GetPosX(), control:GetPosY())
  control:CalcUIAniPos(showAni)
  showAni:SetDisableWhileAni(true)
  control:SetShow(true)
end
function PaGlobal_MiniGame_Find_All:HideMsg(startTime, endTime)
  if nil == Panel_MiniGame_Find_All then
    return
  end
  local closeAni = self._ui._stc_startMsg:addColorAnimation(startTime, endTime, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
  closeAni:SetStartColor(Defines.Color.C_FFFFFFFF)
  closeAni:SetEndColor(Defines.Color.C_00FFFFFF)
  closeAni:SetStartIntensity(3)
  closeAni:SetEndIntensity(1)
  closeAni.IsChangeChild = true
  closeAni:SetHideAtEnd(true)
  closeAni:SetDisableWhileAni(true)
end
function PaGlobal_MiniGame_Find_All:updateGameDepth(gameCurDepth, gameLastDepth)
  if nil == Panel_MiniGame_Find_All then
    return
  end
  self._gameCurDepth = gameCurDepth
  self._gameLastDepth = gameLastDepth
  self._ui._txt_grade:SetText(PAGetStringParam2(Defines.StringSheet_GAME, "LUA_MINIGAME_FIND_CURRENTGRADE", "currentGrade", self._gameCurDepth, "maxGrade", self._gameLastDepth))
  for ii = 1, self._gameMaxDepth do
    if self._gameCurDepth == ii then
      self._ui._stc_grade[ii]:SetShow(true)
    else
      self._ui._stc_grade[ii]:SetShow(false)
    end
  end
end
function PaGlobal_MiniGame_Find_All:updateValue(commercialPercent, RClickCount, isDynamic, emptyCount, subObjCount, trapCount)
  if nil == Panel_MiniGame_Find_All then
    return
  end
  if commercialPercent ~= self._curPecent and true == isDynamic then
    PaGlobal_MiniGame_Find_All._ui._txt_commercial:AddEffect("fUI_Skill_Cooltime01", false, 5, 0)
  end
  self._curPecent = commercialPercent
  if true == isDynamic or commercialPercent == 100 then
    self._ui._txt_commercial:SetText(string.format("%.1f", commercialPercent) .. "%")
    self._ui._progress_damage:SetProgressRate(commercialPercent)
    self._ui._progress_damage:SetCurrentProgressRate(commercialPercent)
  end
  local idx = self:getRewardIndex(commercialPercent)
  for ii = 0, self._config._rewardMaxCount - 1 do
    if idx == ii then
      self._rewardSlot[ii].icon:SetMonoTone(false)
    else
      self._rewardSlot[ii].icon:SetMonoTone(true)
    end
  end
  self._ui._stc_rewardFocus:SetPosX(self._rewardSlot[idx].BG:GetPosX() - 5)
  self._ui._stc_rewardFocus:SetPosY(self._rewardSlot[idx].BG:GetPosY() - 5)
  self._rewardIndex = idx
  self._curRClickCount = RClickCount
  local itemWrapper = ToClient_getEquipmentItem(CppEnums.EquipSlotNoClient.eEquipSlotNoSubTool)
  if itemWrapper ~= nil then
    local grade = itemWrapper:getStaticStatus():getGradeType()
    local lv = 0
    if 0 ~= itemWrapper:get():getEndurance() then
      lv = itemWrapper:get():getKey():getEnchantLevel()
    end
    local RClickCount = ToClient_MiniGameFindMaxRClickCount(grade, lv) - self._curRClickCount
    if RClickCount < 0 then
      RClickCount = 0
    end
    if RClickCount ~= self._tmpRClickCount then
      self._ui._txt_RClickCnt:AddEffect("fUI_Light", false, 5, 0)
      self._tmpRClickCount = RClickCount
      if true == isMsgShow then
        if 0 < RClickCount then
          local strMsg = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_MINIGAMEFIND_RCLICK", "rclick", RClickCount)
          Proc_ShowMessage_Ack(strMsg)
        else
          Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_MINIGAME_FINDROOT_RCLICKCOUNTTITLE_1"))
        end
      end
    end
    self._ui._txt_RClickCnt:SetText(tostring(RClickCount))
    self._ui._txt_endurance:SetText(tostring(itemWrapper:get():getEndurance()))
  end
  if emptyCount ~= self._curEmptyCnt and true == isDynamic then
    self._ui._stc_emptyIcon:AddEffect("UI_LevelUP_Skill", false, 5, 0)
  end
  if subObjCount ~= self._curSubObjCnt and true == isDynamic then
    self._ui._stc_subObjIcon:AddEffect("UI_LevelUP_Skill", false, 5, 0)
  end
  if trapCount ~= self._curTrapCnt and true == isDynamic then
    self._ui._stc_trapIcon:AddEffect("UI_LevelUP_Skill", false, 5, 0)
  end
  self._curEmptyCnt = emptyCount
  self._curSubObjCnt = subObjCount
  self._curTrapCnt = trapCount
  self._ui._txt_emptyCnt:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_MINIGAME_FIND_COUNT", "count", emptyCount))
  self._ui._txt_subObjCnt:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_MINIGAME_FIND_COUNT", "count", subObjCount))
  self._ui._txt_trapCnt:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_MINIGAME_FIND_COUNT", "count", trapCount))
end
function PaGlobal_MiniGame_Find_All:nextGameStart()
  if nil == Panel_MiniGame_Find_All then
    return
  end
  Panel_MiniGame_MiniGameResult:SetShow(false)
  self._readyToNextGame = false
  if self._gameCurDepth + 1 <= self._gameLastDepth then
    ToClient_MiniGameFindNext()
  end
end
