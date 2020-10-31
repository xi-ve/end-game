function PaGlobal_MentalGame_All:initialize()
  if true == PaGlobal_MentalGame_All._initialize then
    return
  end
  self._isConsole = _ContentsGroup_UsePadSnapping
  self:controlLeft_Init()
  self:controlRight_Init()
  self:controlSelect_Init()
  self:controlTooltip_Init()
  self:controlCenter_Init()
  self:controlPc_Init()
  self:controlConsole_Init()
  self:controlSetShow()
  self:controlCenterZodiac_Init()
  PaGlobal_MentalGame_All:registEventHandler()
  PaGlobal_MentalGame_All:mentalBaseInit()
  PaGlobal_MentalGame_All:createCenterUI()
  PaGlobal_MentalGame_All:createAnimationUI()
  PaGlobal_MentalGame_All:createInformationUI()
  PaGlobal_MentalGame_All:createMouseInputerAndSetting()
  PaGlobal_MentalGame_All:validate()
  PaGlobal_MentalGame_All._initialize = true
end
function PaGlobal_MentalGame_All:controlLeft_Init()
  if nil == Panel_MentalGameLeft_All then
    return
  end
  self._ui_left.stc_leftBg = UI.getChildControl(Panel_MentalGameLeft_All, "LeftBG")
  self._ui_left.txt_npcType = UI.getChildControl(self._ui_left.stc_leftBg, "StaticText_TypeIcon")
  self._ui_left.txt_npcName = UI.getChildControl(self._ui_left.stc_leftBg, "StaticText_Name")
  self._ui_left.txt_mission = UI.getChildControl(self._ui_left.stc_leftBg, "StaticText_Mission")
  self._ui_left.txt_tip = UI.getChildControl(self._ui_left.stc_leftBg, "StaticText_Tip")
  self._ui_left.txt_interest = UI.getChildControl(self._ui_left.stc_leftBg, "StaticText_Interest")
  self._ui_left.txt_impression = UI.getChildControl(self._ui_left.stc_leftBg, "StaticText_Impression")
  self._ui_left.stc_intimacyCircleProgressBg = UI.getChildControl(self._ui_left.stc_leftBg, "Static_CircularProgress_BG")
  self._ui_left.stc_intimacyCircleProgress = UI.getChildControl(self._ui_left.stc_leftBg, "CircularProgress_Friend_Point")
  self._ui_left.stc_intimacyCirclePoint = UI.getChildControl(self._ui_left.stc_intimacyCircleProgressBg, "StaticText_CurrentIntimacyPoint")
  self._ui_left.txt_imtimacyTitle = UI.getChildControl(self._ui_left.stc_intimacyCircleProgressBg, "StaticText_Intimacy")
  self._ui_left.stc_rewardIcon = UI.getChildControl(self._ui_left.stc_intimacyCircleProgressBg, "Static_RewardIcon")
  self._ui_left.txt_reward = UI.getChildControl(self._ui_left.stc_intimacyCircleProgressBg, "StaticText_Reward")
  self._ui_left.txt_giftNotice = UI.getChildControl(self._ui_left.stc_leftBg, "StaticText_GiftNotice")
  self._ui_left.stc_resultBg = UI.getChildControl(Panel_MentalGameLeft_All, "Static_ResultBg")
  self._ui_left.txt_result = UI.getChildControl(self._ui_left.stc_resultBg, "StaticText_ResultText")
  self._ui_left.btn_exit = UI.getChildControl(Panel_MentalGameLeft_All, "Button_Exit")
  self._ui_left.stc_resultBg:ComputePos()
  self._ui_left.txt_result:ComputePos()
  for index = 1, 4 do
    self._resultTextList[index] = UI.createAndCopyBasePropertyControl(self._ui_left.stc_resultBg, "StaticText_ResultText", self._ui_left.stc_resultBg, "StaticText_ResultText_" .. index)
    self._resultTextList[index]:SetSpanSize(0, self._ui_left.txt_result:GetSpanSize().y + 25 * (index - 1))
    self._resultTextList[index]:SetShow(true)
  end
  self._resultTextList[1]:SetText(PAGetString(Defines.StringSheet_RESOURCE, "MENTAL_LEFT_TEXT_COMBOCOUNT") .. " : " .. 0)
  self._resultTextList[2]:SetText(PAGetString(Defines.StringSheet_GAME, "MENTALGAME_TALK_INTERESTING_FAILED") .. " : " .. 0)
  self._resultTextList[3]:SetText(PAGetString(Defines.StringSheet_GAME, "MENTALGAME_TALK_ACC_INTERESTING") .. " : " .. 0)
  self._resultTextList[4]:SetText(PAGetString(Defines.StringSheet_GAME, "MENTALGAME_TALK_MOST_INTERESTING") .. " : " .. 0)
  self._ui_left.stc_rewardIcon:SetShow(false)
  self._ui_left.txt_reward:SetShow(false)
end
function PaGlobal_MentalGame_All:controlRight_Init()
  if nil == Panel_MentalGameRight_All then
    return
  end
  self._ui_right.stc_topBg = UI.getChildControl(Panel_MentalGameRight_All, "TopBG")
  self._ui_right.txt_comment1 = UI.getChildControl(self._ui_right.stc_topBg, "StaticText_Comment_1")
  self._ui_right.txt_comment2 = UI.getChildControl(self._ui_right.stc_topBg, "StaticText_Comment_2")
  self._ui_right.stc_bottomDecoBg = UI.getChildControl(Panel_MentalGameRight_All, "Static_BtmDecoBG")
  self._ui_right.stc_bottomBg = UI.getChildControl(Panel_MentalGameRight_All, "BottomBG")
  self._ui_right.stc_circleLineBg = UI.getChildControl(self._ui_right.stc_bottomBg, "Static_CircleBG")
  self._ui_right.btn_rightArrow = UI.getChildControl(self._ui_right.stc_bottomBg, "Button_RightArrow")
  self._ui_right.btn_leftArrow = UI.getChildControl(self._ui_right.stc_bottomBg, "Button_LeftArrow")
  self._ui_right.stc_nowListBg = UI.getChildControl(self._ui_right.stc_bottomBg, "Static_NowListBG")
  self._ui_right.stc_selectedNpc = UI.getChildControl(self._ui_right.stc_bottomBg, "Static_Selected_Npc")
  self._ui_right.stc_mentalNpcIcon = UI.getChildControl(self._ui_right.stc_bottomBg, "Static_MentalIcon_C_0")
  self._ui_right.stc_mentalNpcName = UI.getChildControl(self._ui_right.stc_bottomBg, "StaticText_MentalTxt_C_0")
  self._ui_right.stc_listPoint = UI.getChildControl(self._ui_right.stc_bottomBg, "Static_ListPoint")
  self._ui_right.stc_checkIcon = UI.getChildControl(self._ui_right.stc_bottomBg, "Static_SelectedCheckIcon")
  self._ui_right.stc_interestBg = UI.getChildControl(self._ui_right.stc_bottomBg, "Static_InterestBG")
  self._ui_right.txt_interestTitle = UI.getChildControl(self._ui_right.stc_bottomBg, "StaticText_Interest")
  self._ui_right.txt_mentalCount = UI.getChildControl(self._ui_right.stc_bottomBg, "StaticText_Count")
  self._ui_right.txt_intimacyGet = UI.getChildControl(Panel_MentalGameRight_All, "StaticText_Intimacy")
  self._ui_right.btn_rightArrow:SetAutoDisableTime(0)
  self._ui_right.btn_leftArrow:SetAutoDisableTime(0)
end
function PaGlobal_MentalGame_All:controlSelect_Init()
  if nil == Panel_MentalGameSelect_All then
    return
  end
  self._ui_select.txt_addInterest = UI.getChildControl(Panel_MentalGameSelect_All, "StaticText_AddInterest")
  self._ui_select.stc_npcCircleProgress = UI.getChildControl(Panel_MentalGameSelect_All, "CircularProgress_Progress")
  self._ui_select.stc_successIcon = UI.getChildControl(Panel_MentalGameSelect_All, "Static_Success")
  self._ui_select.stc_failedIcon = UI.getChildControl(Panel_MentalGameSelect_All, "Static_Failed")
end
function PaGlobal_MentalGame_All:controlTooltip_Init()
  if nil == Panel_MentalGameTooltip_All then
    return
  end
  self._ui_tooltip.txt_npcName = UI.getChildControl(Panel_MentalGameTooltip_All, "StaticText_NPC_Name")
  self._ui_tooltip.txt_statusTitle = UI.getChildControl(Panel_MentalGameTooltip_All, "StaticText_StatusTitle")
  self._ui_tooltip.txt_hitBase = UI.getChildControl(Panel_MentalGameTooltip_All, "StaticText_Hit_Base")
  self._ui_tooltip.txt_hitBonus = UI.getChildControl(Panel_MentalGameTooltip_All, "StaticText_Hit_Bonus")
  self._ui_tooltip.txt_valueBase = UI.getChildControl(Panel_MentalGameTooltip_All, "StaticText_DD_Base")
  self._ui_tooltip.txt_valueBonus = UI.getChildControl(Panel_MentalGameTooltip_All, "StaticText_DD_Bonus")
  self._ui_tooltip.txt_commentTitle = UI.getChildControl(Panel_MentalGameTooltip_All, "StaticText_CommentTitle")
  self._ui_tooltip.txt_commentInterest = UI.getChildControl(Panel_MentalGameTooltip_All, "StaticText_Comment_1")
  self._ui_tooltip.txt_commentFavorable = UI.getChildControl(Panel_MentalGameTooltip_All, "StaticText_Comment_2")
  self._ui_tooltip.txt_nextBonusTitle = UI.getChildControl(Panel_MentalGameTooltip_All, "StaticText_BonusTitle")
  self._ui_tooltip.txt_nextBonuse = UI.getChildControl(Panel_MentalGameTooltip_All, "StaticText_Bonus")
  self._ui_tooltip.txt_nextBonuse:SetTextMode(__eTextMode_AutoWrap)
end
function PaGlobal_MentalGame_All:controlCenter_Init()
  if nil == Panel_MentalGame_Center then
    return
  end
  self._ui_center.stc_finishBg = UI.getChildControl(Panel_MentalGame_Center, "Static_Finish")
  self._ui_center.txt_finishResult = UI.getChildControl(Panel_MentalGame_Center, "StaticText_Finish")
  self._ui_center.stc_finishBg:SetPosX(0)
  self._ui_center.txt_finishResult:SetPosX(0)
  self._ui_center.stc_finishBg:SetPosY(getScreenSizeY() / 2 - self._ui_center.stc_finishBg:GetSizeY() / 2)
  self._ui_center.txt_finishResult:SetPosY(getScreenSizeY() / 2 - self._ui_center.txt_finishResult:GetSizeY() / 2)
  self._ui_center.txt_finishResult:SetSize(getScreenSizeX(), self._ui_center.txt_finishResult:GetSizeY())
end
function PaGlobal_MentalGame_All:controlPc_Init()
  if nil == Panel_MentalGameLeft_All or nil == Panel_MentalGameRight_All then
    return
  end
  self._ui_pc.btn_exit = UI.getChildControl(Panel_MentalGameLeft_All, "Button_Exit")
  self._ui_pc.btn_try = UI.getChildControl(Panel_MentalGameRight_All, "Button_Try_PCUI")
  self._ui_pc.btn_continue = UI.getChildControl(Panel_MentalGameRight_All, "Button_Continue")
  self._ui_pc.btn_continueDesc = UI.getChildControl(self._ui_pc.btn_continue, "StaticText_Desc")
  self._ui_pc.btn_leave = UI.getChildControl(Panel_MentalGameRight_All, "Button_Leave")
  self._ui_pc.btn_leaveDesc = UI.getChildControl(self._ui_pc.btn_leave, "StaticText_Desc")
end
function PaGlobal_MentalGame_All:controlConsole_Init()
  if nil == Panel_MentalGameLeft_All or nil == Panel_MentalGameRight_All then
    return
  end
  self._ui_console.stc_keyGuideBg = UI.getChildControl(Panel_MentalGameLeft_All, "Static_Key_Guide_ConsoleUI")
  self._ui_console.stc_guideIconB = UI.getChildControl(self._ui_console.stc_keyGuideBg, "Button_Key_Guide_Back")
  self._ui_console.stc_guideIconA = UI.getChildControl(self._ui_console.stc_keyGuideBg, "Button_Key_Guide_Select")
  self._ui_console.stc_guideIconY = UI.getChildControl(self._ui_console.stc_keyGuideBg, "Button_Key_Guide_Clear")
  self._ui_console.stc_guideIconX = UI.getChildControl(self._ui_console.stc_keyGuideBg, "Button_Key_Guide_Restart")
  self._ui_console.stc_guideIconRB = UI.getChildControl(self._ui_right.btn_rightArrow, "Static_RB_ConsoleUI")
  self._ui_console.stc_guideIconLB = UI.getChildControl(self._ui_right.btn_leftArrow, "Static_LB_ConsoleUI")
  self._keyGuides = {
    self._ui_console.stc_guideIconY,
    self._ui_console.stc_guideIconX,
    self._ui_console.stc_guideIconA,
    self._ui_console.stc_guideIconB
  }
end
function PaGlobal_MentalGame_All:controlCenterZodiac_Init()
  self._ui_zodiac.panel = UI.createOtherPanel("ZodiacCenterPanel", CppEnums.OtherListType.OtherPanelType_Wiki)
  self._ui_zodiac.control = UI.createControl(__ePAUIControl_Static, self._ui_zodiac.panel, "ZodiacCenterPanelImage")
  if nil ~= self._ui_zodiac.panel then
    self._ui_zodiac.panel:SetAlpha(0)
    self._ui_zodiac.panel:SetSize(600, 600)
    self._ui_zodiac.panel:Set3DRenderType(3)
    self._ui_zodiac.panel:SetDepth(0)
    self._ui_zodiac.panel:SetIgnore(true)
    self._ui_zodiac.panel:SetShow(false)
    self._ui_zodiac.control:SetPosX(0)
    self._ui_zodiac.control:SetPosY(0)
    self._ui_zodiac.control:SetSize(600, 600)
    self._ui_zodiac.control:SetAlpha(1)
    self._ui_zodiac.control:SetVerticalMiddle()
    self._ui_zodiac.control:SetHorizonCenter()
    self._ui_zodiac.control:SetIgnore(true)
    self._ui_zodiac.control:SetShow(true)
  end
end
function PaGlobal_MentalGame_All:controlSetShow()
  if nil == Panel_MentalGameLeft_All or nil == Panel_MentalGameRight_All or nil == Panel_MentalGameSelect_All or nil == Panel_MentalGameTooltip_All or nil == Panel_MentalGame_Center then
    return
  end
  local isConsole = _ContentsGroup_UsePadSnapping
  self._ui_pc.btn_exit:SetShow(not isConsole)
  self._ui_pc.btn_try:SetShow(not isConsole)
  self._ui_pc.btn_continue:SetShow(not isConsole)
  self._ui_pc.btn_continueDesc:SetShow(not isConsole)
  self._ui_pc.btn_leave:SetShow(not isConsole)
  self._ui_pc.btn_leaveDesc:SetShow(not isConsole)
  self._ui_console.stc_keyGuideBg:SetShow(isConsole)
  self._ui_console.stc_guideIconB:SetShow(isConsole)
  self._ui_console.stc_guideIconA:SetShow(isConsole)
  self._ui_console.stc_guideIconY:SetShow(isConsole)
  self._ui_console.stc_guideIconX:SetShow(isConsole)
  self._ui_console.stc_guideIconRB:SetShow(isConsole)
  self._ui_console.stc_guideIconLB:SetShow(isConsole)
end
function PaGlobal_MentalGame_All:prepareOpen()
  if nil == Panel_MentalGameLeft_All or nil == Panel_MentalGameRight_All or nil == Panel_MentalGameSelect_All or nil == Panel_MentalGameTooltip_All or nil == Panel_MentalGame_Center then
    return
  end
  Panel_MentalGameLeft_All:RegisterUpdateFunc("FromClient_MentalGame_All_UpdatePosition")
  Panel_MentalGame_Center:RegisterUpdateFunc("FromClient_MentalGame_All_UpdateHideTime")
  Panel_MentalGameRight_All:RegisterUpdateFunc("FromClient_MentalGame_All_UpdateEndTimer")
  if true == Panel_MentalGameLeft_All:GetShow() then
    return
  end
  ToClient_SaveUiInfo(false)
  if GetUIMode() ~= Defines.UIMode.eUIMode_NpcDialog then
    return
  end
  SetUIMode(Defines.UIMode.eUIMode_MentalGame)
  self._renderMode:set()
  self._mentalGame_End = false
  PaGlobalFunc_MentalGame_All_PreClosePanel()
  if false == show_MentalGame() then
    _PA_ASSERT_NAME(false, "PaGlobal_MentalGame_All:prepareOpen() : \236\157\180\236\149\188\234\184\176 \234\181\144\235\165\152\234\176\128 \236\160\149\236\131\129\236\160\129\236\156\188\235\161\156 \236\151\180\235\166\172\236\167\128 \236\149\138\236\149\152\236\138\181\235\139\136\235\139\164.", "\236\160\149\236\167\128\237\152\156")
  end
  self._gameStep = 0
  self._gamePlayCount = 0
  self._addIntimacy = 0
  self._prevDragImageSizeX, self._prevDragImageSizeY = DragManager:getDragImageSize()
  PaGlobal_MentalGame_All:open()
  PaGlobal_MentalGame_All:resize()
  PaGlobal_MentalGame_All:setKeyGuideAndEvent()
  self:gameStartInit()
  self:insertCircleLineAndObject()
  self:insertCardList()
  self:giftIconInit()
  local mentalObject = getMentalgameObject()
  if nil == mentalObject then
    return
  end
  mentalObject:scaling(-0.2)
  ToClient_AudioPostEvent_UIAudioStateEvent("UISTATE_OPEN_STORY")
end
function PaGlobal_MentalGame_All:open()
  if nil == Panel_MentalGameLeft_All or nil == Panel_MentalGameRight_All or nil == Panel_MentalGameSelect_All or nil == Panel_MentalGameTooltip_All or nil == Panel_MentalGame_Center then
    return
  end
  Panel_MentalGameLeft_All:SetShow(true)
  Panel_MentalGameRight_All:SetShow(true)
  Panel_MentalGameSelect_All:SetShow(false)
  Panel_MentalGameTooltip_All:SetShow(false)
  Panel_MentalGame_Center:SetShow(false)
  self._ui_zodiac.panel:SetShow(true)
end
function PaGlobal_MentalGame_All:prepareClose()
  if nil == Panel_MentalGameLeft_All or nil == Panel_MentalGameRight_All or nil == Panel_MentalGameSelect_All or nil == Panel_MentalGameTooltip_All or nil == Panel_MentalGame_Center then
    return
  end
  local isClose = self:endUIProcessMentalOnly(true)
  if false == isClose then
    return
  end
  self._renderMode:reset()
  SetUIMode(Defines.UIMode.eUIMode_NpcDialog)
  ToClient_AudioPostEvent_UIAudioStateEvent("UISTATE_CLOSE_DEFAULT")
  if true == _ContentsGroup_NewUI_Dialog_All then
    PaGlobalFunc_DialogMain_All_MentalGameBtnWpUpdate()
    PaGlobalFunc_DialogMain_All_ShowToggle(true)
    HandleEventLUp_DialogMain_All_BackClick()
  elseif true == _ContentsGroup_RenewUI_Dailog then
    PaGlobalFunc_MainDialog_ReOpen()
  else
    FromClient_ShowDialog()
  end
  Panel_MentalGameLeft_All:ClearUpdateLuaFunc()
  Panel_MentalGame_Center:ClearUpdateLuaFunc()
  Panel_MentalGameRight_All:ClearUpdateLuaFunc()
end
function PaGlobal_MentalGame_All:close()
  if nil == Panel_MentalGameLeft_All or nil == Panel_MentalGameRight_All or nil == Panel_MentalGameSelect_All or nil == Panel_MentalGameTooltip_All or nil == Panel_MentalGame_Center then
    return
  end
  Panel_MentalGameLeft_All:SetShow(false)
  Panel_MentalGameRight_All:SetShow(false)
  Panel_MentalGameSelect_All:SetShow(false)
  Panel_MentalGameTooltip_All:SetShow(false)
  Panel_MentalGame_Center:SetShow(false)
  self._ui_zodiac.panel:SetShow(false)
end
function PaGlobal_MentalGame_All:insertCircleLineAndObject()
  MentalKnowledgeBase.init()
  MentalKnowledgeBase.circleSize = 25
  MentalKnowledgeBase.color = float4(1, 1, 1, 1)
  MentalKnowledgeBase.lineWidth = 1.5
  local mentalObject = getMentalgameObject()
  if nil == mentalObject then
    return
  end
  local basePos = mentalObject:getCardPos()
  local slotCount = mentalObject:getSlotCount()
  local pointCount = mentalObject:getPointCount()
  local orderCount = mentalObject:getOrderCount()
  for index = 0, pointCount - 1 do
    local starPos = mentalObject:getPoint(index)
    local float3Pos = Util.Math.AddVectorToVector(basePos, starPos)
    local circleKey = MentalKnowledgeBase.InsertCircle(float3Pos, 1)
    self._circleKeyList[index] = circleKey
  end
  local lineCount = mentalObject:getLineCount()
  for index = 0, lineCount - 1 do
    local firstIndex = mentalObject:getLineFirst(index)
    local secondIndex = mentalObject:getLineSecond(index)
    MentalKnowledgeBase.InsertLineByCircle(self._circleKeyList[firstIndex], self._circleKeyList[secondIndex])
  end
  MentalKnowledgeBase.usingEndArrow = true
  MentalKnowledgeBase.arrowLineWidth = 9
  MentalKnowledgeBase.lineWidth = 20
  MentalKnowledgeBase.color = float4(0.11764705882352941, 0.8196078431372549, 0.9921568627450981, 0.3)
  MentalKnowledgeBase.arrowColor = float4(0.11764705882352941, 0.8196078431372549, 0.9921568627450981, 0.3)
  for srcSlot = 0, orderCount - 2 do
    for dstSlot = srcSlot + 1, orderCount - 1 do
      local srcIndex = mentalObject:getOrder(srcSlot)
      local dstIndex = mentalObject:getOrder(dstSlot)
      if -1 ~= srcIndex and -1 ~= dstIndex then
        local isApplied = mentalObject:isAppliedEffect(srcSlot, dstSlot)
        local panel = self._informationUI[srcSlot][dstSlot].panel
        local nameTag = self._informationUI[srcSlot][dstSlot].nameTag
        local card = mentalObject:getCardBySlotIndex(srcIndex)
        if true == isApplied then
          MentalKnowledgeBase.InsertLineByCircle(self._circleKeyList[srcIndex], self._circleKeyList[dstIndex])
          local inputText = self._constValue.buffTypeString[card:getBuffType()] .. " : " .. card:getVariedValue()
          local pos = mentalObject:getLerpBySlot(srcSlot, dstSlot, 0.5)
          local float3Pos = Util.Math.AddVectorToVector(basePos, pos)
          local transformData = getTransformRevers(float3Pos.x, float3Pos.y, float3Pos.z)
          nameTag:SetText(inputText)
          panel:SetPosX(transformData.x - panel:GetSizeX() / 2)
          panel:SetPosY(transformData.y - panel:GetSizeY() / 2)
          panel:SetShow(true)
        else
          panel:SetShow(false)
        end
      end
    end
  end
  MentalKnowledgeBase.lineWidth = 4
  MentalKnowledgeBase.arrowLineWidth = 4
  MentalKnowledgeBase.color = float4(0.83, 0.79, 0.54, 1)
  MentalKnowledgeBase.arrowColor = float4(0.83, 0.79, 0.54, 1)
  local prevIndex = -1
  for srcIndex = 0, orderCount - 1 do
    if nil ~= mentalObject:getCardBySlotOrder(srcIndex) then
      local currIndex = srcIndex
      if -1 < prevIndex then
        local slotNumberSrc = mentalObject:getOrder(prevIndex)
        local slotNumberDst = mentalObject:getOrder(currIndex)
        MentalKnowledgeBase.InsertLineByCircle(self._circleKeyList[slotNumberSrc], self._circleKeyList[slotNumberDst])
      end
      prevIndex = currIndex
    end
  end
  MentalKnowledgeBase.UpdateLineAndCircle()
end
function PaGlobal_MentalGame_All:updateState()
  if nil == Panel_MentalGameLeft_All then
    return
  end
  local mentalState = RequestMentalGame_getMentalStage()
  local mentalObject = getMentalgameObject()
  if nil == mentalObject then
    return
  end
  local goaltype = mentalObject:getGoalType()
  local destGoalValue = mentalObject:getDestGoalValue()
  local currentDv = mentalObject:getCurrentDV()
  local currentPv = mentalObject:getCurrentPV()
  local comboCount = mentalObject:getCombo()
  local variedDv = mentalObject:getVariedDv()
  local variedPv = mentalObject:getVariedPv()
  local talker = dialog_getTalker()
  local talkerName = ""
  local dialogData = ToClient_GetCurrentDialogData()
  local talkerType = ""
  if nil ~= talker then
    talkerName = talker:getName()
  end
  self._ui_left.txt_npcName:SetText(tostring(talkerName))
  self._ui_left.txt_npcType:SetShow(false)
  if nil ~= dialogData then
    talkerType = dialogData:getContactNpcTitle()
    if talkerType ~= "" and talkerType ~= nil then
      self._ui_left.txt_npcType:SetText(tostring(talkerType))
      self._ui_left.txt_npcType:SetShow(true)
    end
  end
  if variedDv ~= 0 and variedPv ~= 0 then
    self._ui_left.txt_interest:SetText(self._constValue.buffTypeString[1] .. " : " .. tostring(currentDv) .. " - " .. variedDv)
    self._ui_left.txt_impression:SetText(self._constValue.buffTypeString[0] .. " : " .. tostring(currentPv) .. " - " .. variedPv)
  elseif variedDv == 0 and variedPv ~= 0 then
    self._ui_left.txt_interest:SetText(self._constValue.buffTypeString[1] .. " : " .. tostring(currentDv))
    self._ui_left.txt_impression:SetText(self._constValue.buffTypeString[0] .. " : " .. tostring(currentPv) .. " - " .. variedPv)
  elseif variedDv ~= 0 and variedPv == 0 then
    self._ui_left.txt_interest:SetText(self._constValue.buffTypeString[1] .. " : " .. tostring(currentDv) .. " - " .. variedDv)
    self._ui_left.txt_impression:SetText(self._constValue.buffTypeString[0] .. " : " .. tostring(currentPv))
  else
    self._ui_left.txt_interest:SetText(self._constValue.buffTypeString[1] .. " : " .. tostring(currentDv))
    self._ui_left.txt_impression:SetText(self._constValue.buffTypeString[0] .. " : " .. tostring(currentPv))
  end
  self._ui_left.txt_mission:SetShow(true)
  self._ui_left.txt_tip:SetShow(true)
  if 3 == self._gameStep then
    self._ui_left.txt_mission:SetShow(false)
    self._ui_left.txt_tip:SetShow(false)
  elseif goaltype == 0 then
    local temp1 = PAGetStringParam1(Defines.StringSheet_GAME, "MENTALGAME_TALKING_FREE", "target", tostring(talkerName))
    self._ui_left.txt_mission:SetText(temp1)
    self._ui_left.txt_tip:SetShow(false)
  elseif goaltype == 1 then
    local temp1 = ""
    if 1 == destGoalValue then
      temp1 = PAGetStringParam1(Defines.StringSheet_GAME, "MENTALGAME_TALKING_INTERESTING", "target", tostring(talkerName))
    else
      temp1 = PAGetStringParam2(Defines.StringSheet_GAME, "MENTALGAME_TALKING_INTERESTING_COMBO", "target", tostring(talkerName), "count", tostring(destGoalValue))
    end
    self._ui_left.txt_mission:SetText(temp1)
    self._ui_left.txt_tip:SetText(PAGetString(Defines.StringSheet_GAME, "MENTALGAME_TALK_TIP1"))
    self._ui_left.txt_tip:SetShow(true)
  elseif goaltype == 2 then
    local temp1 = PAGetStringParam2(Defines.StringSheet_GAME, "MENTALGAME_TALKING_ACCUMULATE", "target", tostring(talkerName), "count", tostring(destGoalValue))
    self._ui_left.txt_mission:SetText(temp1)
    self._ui_left.txt_tip:SetText(PAGetString(Defines.StringSheet_GAME, "MENTALGAME_TALK_TIP2"))
    self._ui_left.txt_tip:SetShow(true)
  elseif goaltype == 3 then
    local temp1 = PAGetStringParam2(Defines.StringSheet_GAME, "MENTALGAME_TALKING_MOST", "target", tostring(talkerName), "count", tostring(destGoalValue))
    self._ui_left.txt_mission:SetText(temp1)
    self._ui_left.txt_tip:SetText(PAGetString(Defines.StringSheet_GAME, "MENTALGAME_TALK_TIP3"))
    self._ui_left.txt_tip:SetShow(true)
  elseif goaltype == 4 then
    local temp1 = PAGetStringParam2(Defines.StringSheet_GAME, "MENTALGAME_TALKING_FAILED", "target", tostring(talkerName), "count", tostring(destGoalValue))
    self._ui_left.txt_mission:SetText(temp1)
    self._ui_left.txt_tip:SetText(PAGetString(Defines.StringSheet_GAME, "MENTALGAME_TALK_TIP4"))
    self._ui_left.txt_tip:SetShow(true)
  end
  self._resultTextList[1]:SetText(PAGetString(Defines.StringSheet_RESOURCE, "MENTAL_LEFT_TEXT_COMBOCOUNT") .. " : " .. comboCount)
  self:maxPointUpdate()
  if nil ~= self._resultTextList[2] then
    self._resultTextList[2]:SetText(PAGetString(Defines.StringSheet_GAME, "MENTALGAME_TALK_INTERESTING_FAILED") .. " : " .. mentalObject:getFail())
  end
  if nil ~= self._resultTextList[3] then
    self._resultTextList[3]:SetText(PAGetString(Defines.StringSheet_GAME, "MENTALGAME_TALK_ACC_INTERESTING") .. " : " .. mentalObject:getTotalInterest())
  end
  if nil ~= self._resultTextList[4] then
    self._resultTextList[4]:SetText(PAGetString(Defines.StringSheet_GAME, "MENTALGAME_TALK_MOST_INTERESTING") .. " : " .. self._bestPoint)
  end
  local talker = dialog_getTalker()
  local intimacy = 0
  if nil ~= talker then
    intimacy = talker:getIntimacy()
  end
  self._ui_left.stc_intimacyCirclePoint:SetText(tostring(intimacy))
  local intimacyValuePercent = intimacy / self._constValue.interestValueMax * 100
  if 100 < intimacyValuePercent then
    intimacyValuePercent = 100
  end
  self._ui_left.stc_intimacyCircleProgress:SetProgressRate(intimacyValuePercent)
end
function PaGlobal_MentalGame_All:maxPointUpdate()
  local mentalObject = getMentalgameObject()
  if nil == mentalObject then
    return
  end
  local currentPoint = mentalObject:getInterestValue()
  self._bestPoint = math.max(self._bestPoint, currentPoint)
end
function PaGlobal_MentalGame_All:updateStateUIShow()
  if nil == Panel_MentalGameRight_All or nil == Panel_MentalGame_Center or nil == Panel_MentalGameLeft_All then
    return
  end
  if false == self._mouseInputer:GetShow() then
    return
  end
  local isConsole = _ContentsGroup_UsePadSnapping
  if 0 == self._gameStep then
    self._ui_right.txt_comment1:SetShow(true)
    self._ui_right.txt_comment2:SetShow(true)
    self._ui_pc.btn_try:SetShow(false)
    self._ui_right.stc_interestBg:SetShow(true)
    self._ui_right.txt_interestTitle:SetShow(true)
    self._ui_right.txt_intimacyGet:SetShow(false)
    self._ui_pc.btn_continue:SetShow(false)
    self._ui_pc.btn_leave:SetShow(false)
    self._ui_center.stc_finishBg:SetShow(false)
    self._ui_center.txt_finishResult:SetShow(false)
  elseif 1 == self._gameStep then
    self._ui_right.txt_comment1:SetShow(false)
    self._ui_right.txt_comment2:SetShow(false)
    self._ui_pc.btn_try:SetShow(not isConsole)
    self._ui_pc.btn_try:SetIgnore(false)
    self._ui_right.stc_interestBg:SetShow(false)
    self._ui_right.txt_interestTitle:SetShow(false)
    self._ui_right.txt_intimacyGet:SetShow(false)
    self._ui_pc.btn_continue:SetShow(false)
    self._ui_pc.btn_leave:SetShow(false)
    self._ui_center.stc_finishBg:SetShow(false)
    self._ui_center.txt_finishResult:SetShow(false)
  elseif 2 == self._gameStep then
    self._ui_right.txt_comment1:SetShow(false)
    self._ui_right.txt_comment2:SetShow(false)
    self._ui_pc.btn_try:SetShow(false)
    self._ui_right.stc_interestBg:SetShow(true)
    self._ui_right.txt_interestTitle:SetShow(true)
    self._ui_right.txt_intimacyGet:SetShow(false)
    self._ui_pc.btn_continue:SetShow(false)
    self._ui_pc.btn_leave:SetShow(false)
    self._ui_center.stc_finishBg:SetShow(false)
    self._ui_center.txt_finishResult:SetShow(false)
  elseif 3 == self._gameStep then
    local mentalStage = RequestMentalGame_getMentalStage()
    local playableNextGame = self._gamePlayCount < self._constValue.maxPlayCount
    self._ui_right.txt_comment1:SetShow(false)
    self._ui_right.txt_comment2:SetShow(false)
    self._ui_pc.btn_try:SetShow(false)
    self._ui_right.stc_interestBg:SetShow(true)
    self._ui_right.txt_intimacyGet:SetShow(mentalStage._isSuccess and isConsole)
    self._ui_right.txt_interestTitle:SetShow(true)
    self._ui_pc.btn_continue:SetShow(mentalStage._isSuccess and playableNextGame and not isConsole)
    self._ui_pc.btn_leave:SetShow(not isConsole)
    self._ui_center.stc_finishBg:SetShow(false)
    self._ui_center.txt_finishResult:SetShow(false)
  elseif 4 == self._gameStep then
    Panel_MentalGameLeft_All:SetShow(false)
    Panel_MentalGameRight_All:SetShow(false)
    Panel_MentalGame_Center:SetShow(true)
    self._ui_center.stc_finishBg:SetShow(true)
    self._ui_center.txt_finishResult:SetShow(true)
    self._ui_center.txt_finishResult:SetTextHorizonCenter()
    self._ui_center.txt_finishResult:SetTextVerticalCenter()
    local aniInfo1 = self._ui_center.stc_finishBg:addScaleAnimation(0, 0.16, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_COS_HALF_PI)
    aniInfo1:SetStartScale(0.5)
    aniInfo1:SetEndScale(1.15)
    aniInfo1.AxisX = self._ui_center.stc_finishBg:GetSizeX() / 2
    aniInfo1.AxisY = self._ui_center.stc_finishBg:GetSizeY() / 2
    aniInfo1.ScaleType = 2
    aniInfo1.IsChangeChild = true
    local aniInfo2 = self._ui_center.stc_finishBg:addScaleAnimation(0.16, 0.3, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_COS_HALF_PI)
    aniInfo2:SetStartScale(1.15)
    aniInfo2:SetEndScale(1)
    aniInfo2.AxisX = self._ui_center.stc_finishBg:GetSizeX() / 2
    aniInfo2.AxisY = self._ui_center.stc_finishBg:GetSizeY() / 2
    aniInfo2.ScaleType = 2
    aniInfo2.IsChangeChild = true
    local aniInfo3 = self._ui_center.txt_finishResult:addScaleAnimation(0, 0.16, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_COS_HALF_PI)
    aniInfo3:SetStartScale(0.5)
    aniInfo3:SetEndScale(1.15)
    aniInfo3.AxisX = self._ui_center.txt_finishResult:GetSizeX() / 2
    aniInfo3.AxisY = self._ui_center.txt_finishResult:GetSizeY() / 2
    aniInfo3.ScaleType = 2
    aniInfo3.IsChangeChild = true
    local aniInfo4 = self._ui_center.txt_finishResult:addScaleAnimation(0.16, 0.3, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_COS_HALF_PI)
    aniInfo4:SetStartScale(1.15)
    aniInfo4:SetEndScale(1)
    aniInfo4.AxisX = self._ui_center.txt_finishResult:GetSizeX() / 2
    aniInfo4.AxisY = self._ui_center.txt_finishResult:GetSizeY() / 2
    aniInfo4.ScaleType = 2
    aniInfo4.IsChangeChild = true
  end
  if true == isConsole then
    self:setKeyGuideAndEvent()
  end
end
function PaGlobal_MentalGame_All:updateCardColor()
  local mentalObject = getMentalgameObject()
  if nil == mentalObject then
    return
  end
  local count = mentalObject:getCardCount()
  for index = 0, count - 1 do
    local cardWrapper = mentalObject:getCard(index)
    if nil ~= self._rightCardList[index] and nil ~= self._rightCardList[index].ui and nil ~= self._rightCardList[index].ui.cardIcon then
      local iconUI = self._rightCardList[index].ui.cardIcon
      local checkUI = self._rightCardList[index].ui.selectIcon
      if mentalObject:isBanedCard(cardWrapper) or mentalObject:isSelectedCard(cardWrapper) then
        iconUI:SetColor(Defines.Color.C_FF626262)
        if true == iconUI:GetShow() then
          checkUI:SetShow(true)
        else
          checkUI:SetShow(false)
        end
      else
        iconUI:SetColor(Defines.Color.C_FFFFFFFF)
        checkUI:SetShow(false)
      end
    end
  end
end
function PaGlobal_MentalGame_All:updateCardScrollButton()
  if nil == Panel_MentalGameRight_All then
    return
  end
  local mentalObject = getMentalgameObject()
  if nil == mentalObject then
    return
  end
  local maxValue = mentalObject:getCardCount() - 5
  local totalCard = mentalObject:getCardCount()
  if totalCard <= 4 then
    self._ui_right.btn_leftArrow:SetShow(false)
    self._ui_right.btn_rightArrow:SetShow(false)
    return
  end
  self._ui_right.btn_leftArrow:SetShow(0 < self._scrollPositionResult)
  self._ui_right.btn_rightArrow:SetShow(maxValue > self._scrollPositionResult)
end
function PaGlobal_MentalGame_All:updateNextTryEvent()
  local mentalObject = getMentalgameObject()
  if nil == mentalObject then
    return
  end
  local nextSlot = mentalObject:getNextSlot()
  if 0 < nextSlot then
    local prevSlot = nextSlot - 1
    local index = mentalObject:getOrder(prevSlot)
    if nil == self._centerUiList[index] or nil == self._centerUiList[index].SuccessIcon then
      return
    end
    self._centerUiList[index].SuccessIcon:ResetVertexAni()
    self._centerUiList[index].FailedIcon:ResetVertexAni()
    self._centerUiList[index].SuccessIcon:SetShow(false)
    self._centerUiList[index].FailedIcon:SetShow(false)
    if true == mentalObject:isComboSuccess() then
      self._centerUiList[index].panel:AddEffect("fUI_KnowledgeNotice02", false, 0, 0)
      self._centerUiList[index].SuccessIcon:SetVertexAniRun("Ani_Color_New", true)
      self._centerUiList[index].SuccessIcon:SetVertexAniRun("Ani_Move_Pos_New", true)
      self._centerUiList[index].SuccessIcon:SetShow(true)
      audioPostEvent_SystemUi(4, 9)
      _AudioPostEvent_SystemUiForXBOX(4, 9)
    else
      self._centerUiList[index].FailedIcon:SetVertexAniRun("Ani_Color_New", true)
      self._centerUiList[index].FailedIcon:SetVertexAniRun("Ani_Move_Pos_New", true)
      self._centerUiList[index].FailedIcon:SetShow(true)
      audioPostEvent_SystemUi(4, 8)
      _AudioPostEvent_SystemUiForXBOX(4, 8)
    end
    local lastIndex = mentalObject:getOrderCount() - 1
    local nextIndex = mentalObject:getOrder(nextSlot)
    if mentalObject:getHasNextSlot() and nil ~= self._centerUiList[nextIndex] then
      self._centerUiList[nextIndex].circularProgress:SetCurrentControlPos(0)
      self._centerUiList[nextIndex].circularProgress:SetProgressRate(100)
    end
    local isFirst = true
    for index = nextSlot, lastIndex do
      local isApplied = mentalObject:isAppliedEffect(prevSlot, index)
      local isFirstAnimation = false
      if true == isFirst and nil ~= mentalObject:getCardBySlotOrder(index) then
        isFirst = false
        isFirstAnimation = true
      end
      if true == isApplied or true == isFirstAnimation then
        if true == isFirstAnimation then
          self._animationUIList[prevSlot][index].pointImage:SetColor(Defines.Color.C_FFEF9C7F)
        else
          self._animationUIList[prevSlot][index].pointImage:SetColor(Defines.Color.C_FFFFFFFF)
        end
        local playCount = index - prevSlot - mentalObject:getEmptyCount(prevSlot, index)
        self:addAnimation(self._animationUIList[prevSlot][index].panel, 0, mentalObject:getMentalGameSpeed() / 1000 * playCount, prevSlot, index, PaGlobalFunc_MentalGame_All_PosUpdateAnimation)
        self:addAnimation(self._informationUI[prevSlot][index].nameTag, 0, mentalObject:getMentalGameSpeed() / 1000 * playCount, prevSlot, index, PaGlobalFunc_MentalGame_All_FontalphaUpdateAnimation)
      end
    end
  end
end
function PaGlobal_MentalGame_All:updateCenterUIPos(deltaTime)
  local mentalObject = getMentalgameObject()
  if nil == mentalObject then
    return
  end
  local basePos = mentalObject:getCardPos()
  local count = mentalObject:getPointCount()
  local gameOptionSetting = ToClient_getGameOptionControllerWrapper()
  local CropModeEnable = gameOptionSetting:getCropModeEnable()
  local CropModeScaleX = gameOptionSetting:getCropModeScaleX()
  local CropModeScaleY = gameOptionSetting:getCropModeScaleY()
  local screenX = getScreenSizeX() - getScreenSizeX() * CropModeScaleX
  local screenY = getScreenSizeY() - getScreenSizeY() * CropModeScaleY
  for index = 0, count - 1 do
    local starPos = mentalObject:getPoint(index)
    local float3Pos = Util.Math.AddVectorToVector(basePos, starPos)
    local panel = self._centerUiList[index].panel
    local progress = self._centerUiList[index].circularProgress
    local transformData = getTransformRevers(float3Pos.x, float3Pos.y, float3Pos.z)
    if transformData.x > -1 and transformData.y > -1 then
      local cameraDistance = distanceFromCamera(float3Pos.x, float3Pos.y, float3Pos.z)
      local scaleSize = 100000 / cameraDistance * 0.85
      panel:SetSize(scaleSize, scaleSize)
      progress:ComputePos()
      if CropModeEnable == true then
        panel:SetPosX(transformData.x * CropModeScaleX + screenX / 2 - panel:GetSizeX() / 2)
        panel:SetPosY(transformData.y * CropModeScaleY + screenY / 2 - panel:GetSizeY() / 2)
      else
        panel:SetPosX(transformData.x - panel:GetSizeX() / 2)
        panel:SetPosY(transformData.y - panel:GetSizeY() / 2)
      end
      panel:SetAlpha(1)
      panel:SetDepth(cameraDistance)
      panel:SetShow(true)
    end
  end
end
function PaGlobal_MentalGame_All:updateRotateProcess(deltaTime)
  if false == self._isRdown then
    return
  end
  local currPos = {
    x = getMousePosX(),
    y = getMousePosY()
  }
  if currPos.x == self._rMovePos.x and currPos.y == self._rMovePos.y then
    return
  end
  local mentalObject = getMentalgameObject()
  if nil == mentalObject then
    return
  end
  local diffPos = {
    x = (currPos.x - self._rMovePos.x) / getScreenSizeX(),
    y = (currPos.y - self._rMovePos.y) / getScreenSizeY()
  }
  mentalObject:rotate(diffPos.x * -3, diffPos.y * -3)
  self:updateCenterBackground()
  self._rMovePos = currPos
end
function PaGlobal_MentalGame_All:updateCenterBackground()
  local mentalObject = getMentalgameObject()
  if nil == mentalObject then
    return
  end
  if nil == self._ui_zodiac then
    return
  end
  local yawpitchroll = mentalObject:getYawPitchRoll()
  self._ui_zodiac.panel:Set3DRotationX(yawpitchroll.x)
  self._ui_zodiac.panel:Set3DRotationY(yawpitchroll.y)
  self._ui_zodiac.panel:Set3DRotationZ(yawpitchroll.z)
  self._ui_zodiac.panel:SetWorldPosX(mentalObject:getCardPos().x)
  self._ui_zodiac.panel:SetWorldPosY(mentalObject:getCardPos().y)
  self._ui_zodiac.panel:SetWorldPosZ(mentalObject:getCardPos().z)
  self._ui_zodiac.control:SetScale(mentalObject:getScale(), mentalObject:getScale())
end
function PaGlobal_MentalGame_All:updateAnimationList(deltaTime)
  for key, value in pairs(self._animationList) do
    value.deltaTime = value.deltaTime + deltaTime
    if value.endTime < value.deltaTime then
      value.ui:SetShow(false)
      self._animationList[key] = nil
    elseif value.startTime <= value.deltaTime then
      value.animationFunc(key, value)
      value.ui:SetShow(true)
    else
      value.ui:SetShow(false)
    end
  end
end
function PaGlobal_MentalGame_All:updateRightUIPos(deltaTime, forceRun)
  local diff = self._scrollPositionResult - self._scrollPosition
  if 2 <= self._gameStep then
    return
  end
  if 0 == diff and false == forceRun then
    return
  end
  local mentalObject = getMentalgameObject()
  if nil == mentalObject then
    return
  end
  self._scrollPosition = self._scrollPosition + diff * math.min(deltaTime * 8, 1)
  if math.abs(self._scrollPositionResult - self._scrollPosition) < 0.05 then
    self._scrollPosition = self._scrollPositionResult
  end
  local isIgnore = self._scrollPosition ~= self._scrollPositionResult
  for index, value in pairs(self._rightCardList) do
    if nil ~= value.ui and nil ~= value.ui.cardText then
      value.ui.cardIcon:SetIgnore(isIgnore)
      local posIndex = index - self._scrollPosition
      local position = mentalObject:getCirclePosition(float2((self._ui_right.btn_rightArrow:GetPosX() + self._ui_right.btn_rightArrow:GetPosX() + (self._ui_right.btn_leftArrow:GetSizeX() + self._ui_right.btn_rightArrow:GetSizeX()) / 2) / 2, self._ui_right.btn_leftArrow:GetPosY() + self._ui_right.btn_leftArrow:GetSizeY() / 2 + 320), 400, posIndex - 2)
      local cardWrapper = mentalObject:getCard(index)
      value.ui.cardText:SetPosX(position.x - value.ui.cardText:GetSizeX() / 2 - 280)
      value.ui.cardText:SetPosY(position.y - value.ui.cardText:GetSizeY() / 2 + 20)
      value.ui.cardIcon:SetPosX(position.x - value.ui.cardIcon:GetSizeX() / 2 - 280)
      value.ui.cardIcon:SetPosY(position.y - value.ui.cardIcon:GetSizeY() / 2 - 50)
      value.ui.selectIcon:SetPosX(position.x - value.ui.selectIcon:GetSizeX() / 2 - 280)
      value.ui.selectIcon:SetPosY(position.y - value.ui.selectIcon:GetSizeY() / 2 - 50)
      value.ui.cardText:SetIgnore(true)
      value.ui.selectIcon:SetShow(false)
      if -0.25 <= posIndex and posIndex <= 4.25 then
        value.ui.cardText:SetShow(true)
        value.ui.cardIcon:SetShow(true)
        if nil ~= cardWrapper and mentalObject:isSelectedCard(cardWrapper) then
          value.ui.selectIcon:SetShow(true)
        end
        value.ui.cardText:SetAlphaExtraChild(1)
      elseif -0.75 <= posIndex and posIndex < -0.25 then
        value.ui.cardText:SetShow(true)
        value.ui.cardIcon:SetShow(true)
        if nil ~= cardWrapper and mentalObject:isSelectedCard(cardWrapper) then
          value.ui.selectIcon:SetShow(true)
        end
        value.ui.cardText:SetAlphaExtraChild((posIndex + 0.75) * 2)
      elseif 4.25 < posIndex and posIndex <= 4.75 then
        value.ui.cardText:SetShow(true)
        value.ui.cardIcon:SetShow(true)
        if nil ~= cardWrapper and mentalObject:isSelectedCard(cardWrapper) then
          value.ui.selectIcon:SetShow(true)
        end
        value.ui.cardText:SetAlphaExtraChild((4.75 - posIndex) * 2)
      else
        value.ui.cardText:SetShow(false)
        value.ui.cardIcon:SetShow(false)
        value.ui.selectIcon:SetShow(false)
      end
    end
  end
end
function PaGlobal_MentalGame_All:insertCardList()
  local aControl = {}
  local aTextControl = {}
  local aSelectCheck = {}
  local index = 0
  local PrePosY = 0
  local mentalObject = getMentalgameObject()
  if nil == mentalObject then
    return
  end
  local count = mentalObject:getCardCount()
  for index = 0, count - 1 do
    local cardWrapper = mentalObject:getCard(index)
    local gap = self._ui_right.stc_mentalNpcIcon:GetSizeY() * 13 / 10
    if nil == self._rightCardList[index] then
      self._rightCardList[index] = {
        ui = {}
      }
    end
    if nil == self._rightCardList[index].ui then
      self._rightCardList[index].ui = {}
    end
    if nil == self._rightCardList[index].ui.cardText then
      aTextControl[index] = UI.createControl(__ePAUIControl_StaticText, self._ui_right.stc_bottomBg, "stc_mentalNpcName" .. tostring(index))
      self._rightCardList[index].ui.cardText = aTextControl[index]
      CopyBaseProperty(self._ui_right.stc_mentalNpcName, aTextControl[index])
      aTextControl[index]:SetShow(true)
      aTextControl[index]:ComputePos()
      aTextControl[index]:SetPosX(index * gap)
      aTextControl[index]:SetAutoResize(true)
      aTextControl[index]:SetTextMode(__eTextMode_AutoWrap)
      aTextControl[index]:SetText(cardWrapper:getName())
      aTextControl[index]:SetVerticalBottom()
      aControl[index] = UI.createControl(__ePAUIControl_Static, self._ui_right.stc_bottomBg, "stc_mentalNpcIcon" .. tostring(index))
      self._rightCardList[index].ui.cardIcon = aControl[index]
      CopyBaseProperty(self._ui_right.stc_mentalNpcIcon, aControl[index])
      ToClient_padSnapRefreshTarget(aControl[index])
      aControl[index]:SetShow(true)
      aControl[index]:ComputePos()
      aControl[index]:ChangeTextureInfoName(cardWrapper:getPicture())
      aControl[index]:SetVerticalTop()
      aControl[index]:SetSpanSize(0, 0 - aControl[index]:GetSizeY())
      aControl[index]:SetIgnore(false)
      if false == _ContentsGroup_UsePadSnapping then
        aControl[index]:addInputEvent("Mouse_LDown", "HandleEventLDown_MentalGame_All_Card(" .. index .. ")")
        aControl[index]:addInputEvent("Mouse_RDown", "HandleEventRDown_MentalGame_All_Card(" .. index .. ")")
      end
      if true == self._isConsole then
        aControl[index]:registerPadEvent(__eConsoleUIPadEvent_Up_A, "HandleEventRDown_MentalGame_All_Card(" .. index .. ")")
        aControl[index]:registerPadEvent(__eConsoleUIPadEvent_X, "HandleEventPad_MentalGame_All_CardOver(" .. index .. ", false)")
      else
        aControl[index]:addInputEvent("Mouse_On", "HandleEventOnOut_MentalGame_All_CardOver(" .. index .. ",false,true)")
        aControl[index]:addInputEvent("Mouse_Out", "HandleEventOnOut_MentalGame_All_CardOver(" .. index .. ",false,false)")
      end
      aControl[index]:addInputEvent("Mouse_DownScroll", "HandleEventLDown_MentalGame_All_CardRotation(false)")
      aControl[index]:addInputEvent("Mouse_UpScroll", "HandleEventLDown_MentalGame_All_CardRotation(true)")
      if mentalObject:isBanedCard(cardWrapper) or mentalObject:isSelectedCard(cardWrapper) then
        aControl[index]:SetColor(Defines.Color.C_FF626262)
      else
        aControl[index]:SetColor(Defines.Color.C_FFFFFFFF)
      end
      aControl[index]:SetHorizonCenter()
      aSelectCheck[index] = UI.createControl(__ePAUIControl_Static, self._ui_right.stc_bottomBg, "stc_checkIcon" .. tostring(index))
      self._rightCardList[index].ui.selectIcon = aSelectCheck[index]
      CopyBaseProperty(self._ui_right.stc_checkIcon, aSelectCheck[index])
      aSelectCheck[index]:SetPosX(aControl[index]:GetPosX())
      aSelectCheck[index]:SetHorizonCenter()
      aSelectCheck[index]:SetShow(false)
    else
      aControl[index] = self._rightCardList[index].ui.cardIcon
    end
    if PrePosY < aTextControl[index]:GetSizeY() then
      PrePosY = aTextControl[index]:GetSizeY()
    end
  end
  for index = 0, count - 1 do
    aTextControl[index]:SetSize(aTextControl[index]:GetSizeX(), PrePosY)
    aTextControl[index]:ComputePos()
    aControl[index]:ComputePos()
  end
end
function PaGlobal_MentalGame_All:updateTooltipContext(mentalCard, isInserted, slotIndex)
  if nil == Panel_MentalGameTooltip_All then
    return
  end
  local mentalObject = getMentalgameObject()
  if nil == mentalObject or nil == mentalCard then
    return false
  end
  local maxHitPercent = mentalCard:getHit() / mentalObject:getCurrentDV() * 100
  local minDamage = mentalCard:getMinDD() - mentalObject:getCurrentPV()
  local maxDamage = mentalCard:getMaxDD() - mentalObject:getCurrentPV()
  local _mentalCard = mentalCard:getStaticStatus()
  local objectHit = mentalCard:getHit()
  if maxHitPercent < 0 then
    maxHitPercent = 0
  elseif 100 < maxHitPercent then
    maxHitPercent = 100
  end
  if minDamage < 0 then
    minDamage = 0
  end
  if maxDamage < 0 then
    maxDamage = 0
  end
  local buffText = PAGetString(Defines.StringSheet_GAME, "MENTALGAME_BUFF_EMPTY")
  if _mentalCard:isBuff() then
    if _mentalCard:getApplyTurn() == 0 then
      if _mentalCard:getBuffType() < 2 then
        buffText = PAGetStringParam3(Defines.StringSheet_GAME, "MENTALGAME_BUFF_MESSAGE_1_UP", "buff", self._constValue.buffTypeString[_mentalCard:getBuffType()], "turn", tostring(_mentalCard:getValidTurn()), "value", tostring(_mentalCard:getVariedValue()))
      else
        buffText = PAGetStringParam3(Defines.StringSheet_GAME, "MENTALGAME_BUFF_MESSAGE_1_DOWN", "buff", self._constValue.buffTypeString[_mentalCard:getBuffType()], "turn", tostring(_mentalCard:getValidTurn()), "value", tostring(_mentalCard:getVariedValue()))
      end
    elseif _mentalCard:getBuffType() < 2 then
      buffText = PAGetStringParam4(Defines.StringSheet_GAME, "MENTALGAME_BUFF_MESSAGE_ANY_UP", "count", tostring(_mentalCard:getApplyTurn() + 1), "buff", self._constValue.buffTypeString[_mentalCard:getBuffType()], "turn", tostring(_mentalCard:getValidTurn()), "value", tostring(_mentalCard:getVariedValue()))
    else
      buffText = PAGetStringParam4(Defines.StringSheet_GAME, "MENTALGAME_BUFF_MESSAGE_ANY_DOWN", "count", tostring(_mentalCard:getApplyTurn() + 1), "buff", self._constValue.buffTypeString[_mentalCard:getBuffType()], "turn", tostring(_mentalCard:getValidTurn()), "value", tostring(_mentalCard:getVariedValue()))
    end
  end
  local overKey_StaticKey = _mentalCard:getKey()
  local overKeyIndex = -1
  for index = 0, self._constValue.slotCountMax - 1 do
    local mentalCardData = RequestMentalGame_getCardSlotAt(index)
    if mentalCardData ~= nil then
      if mentalCardData:getStaticStatus():getKey() == overKey_StaticKey then
        overKeyIndex = index
        break
      end
    else
      overKeyIndex = index
      break
    end
  end
  self._ui_tooltip.txt_npcName:SetText(mentalCard:getName())
  self._ui_tooltip.txt_hitBase:SetText(self._constValue.buffTypeString[1] .. " : " .. mentalCard:getHit())
  self._ui_tooltip.txt_valueBase:SetText(self._constValue.buffTypeString[0] .. " : " .. mentalCard:getMinDD() .. " ~ " .. mentalCard:getMaxDD())
  local temp1 = PAGetStringParam2(Defines.StringSheet_GAME, "MENTALGAME_TOOLTIP_CAUSE_INTERESTING", "hit", tostring(objectHit), "percent", string.format("%.0f", maxHitPercent))
  self._ui_tooltip.txt_commentInterest:SetText(temp1)
  local temp2 = PAGetStringParam2(Defines.StringSheet_GAME, "MENTALGAME_TOOLTIP_FAVOR", "min", tostring(minDamage), "max", tostring(maxDamage))
  self._ui_tooltip.txt_commentFavorable:SetText(temp2)
  local hitBonusText = ""
  local ddBonusText = ""
  local valueText = ""
  if true == isInserted then
    local startIndex = mentalObject:getBuffStartIndex(slotIndex, 0)
    for index = startIndex, slotIndex - 1 do
      local value = mentalObject:getBuffValue(index)
      if 0 < value then
        valueText = " +" .. tostring(value)
      elseif value < 0 then
        valueText = " " .. tostring(value)
      else
        valueText = ""
      end
      ddBonusText = ddBonusText .. valueText
    end
    local startIndex = mentalObject:getBuffStartIndex(slotIndex, 1)
    for index = startIndex, slotIndex - 1 do
      local value = mentalObject:getBuffValue(index)
      if 0 < value then
        valueText = " +" .. tostring(value)
      elseif value < 0 then
        valueText = " " .. tostring(value)
      else
        valueText = ""
      end
      hitBonusText = hitBonusText .. valueText
    end
  end
  self._ui_tooltip.txt_nextBonuse:SetText(buffText)
  self._ui_tooltip.txt_hitBonus:SetText(hitBonusText)
  self._ui_tooltip.txt_valueBonus:SetText(ddBonusText)
  return true
end
function PaGlobal_MentalGame_All:registEventHandler()
  if nil == Panel_MentalGameLeft_All or nil == Panel_MentalGameRight_All or nil == Panel_MentalGameSelect_All or nil == Panel_MentalGameTooltip_All or nil == Panel_MentalGame_Center then
    return
  end
  if true == _ContentsGroup_NewUI_MentalGame_All then
    registerEvent("startMentalGame", "FromClient_MentalGame_All_startMentalGame")
  end
  registerEvent("onScreenResize", "FromClient_MentalGame_All_onScreenResize")
  registerEvent("ResponseMentalGame_updateStage", "FromClient_MentalGame_All_UpdateStage")
  registerEvent("ResponseMentalGame_tryCard", "FromClient_MentalGame_All_TryCard")
  registerEvent("ResponseMentalGame_endStage", "FromClient_MentalGame_All_EndStage")
  registerEvent("MentalGame_updateMatrix", "FromClient_MentalGame_All_UpdateMatrix")
  registerEvent("EventSelfPlayerPreDead", "FromClient_MentalGame_All_HideByDead")
  registerEvent("progressEventCancelByAttacked", "FromClient_MentalGame_All_CloseFunctorRender")
  self._renderMode:setClosefunctor(renderMode, FromClient_MentalGame_All_CloseFunctorRender)
  if false == _ContentsGroup_UsePadSnapping then
    self._ui_pc.btn_try:addInputEvent("Mouse_LDown", "HandleEventLDown_MentalGame_All_Try()")
    self._ui_pc.btn_continue:addInputEvent("Mouse_LDown", "HandleEventLDown_MentalGame_All_Continue()")
    self._ui_pc.btn_leave:addInputEvent("Mouse_LDown", "HandleEventLDown_MentalGame_All_Leave()")
    self._ui_right.btn_rightArrow:addInputEvent("Mouse_LDown", "HandleEventLDown_MentalGame_All_CardRotation(false)")
    self._ui_right.btn_leftArrow:addInputEvent("Mouse_LDown", "HandleEventLDown_MentalGame_All_CardRotation(true)")
    self._ui_right.btn_rightArrow:addInputEvent("Mouse_DownScroll", "HandleEventLDown_MentalGame_All_CardRotation(false)")
    self._ui_right.btn_leftArrow:addInputEvent("Mouse_UpScroll", "HandleEventLDown_MentalGame_All_CardRotation(true)")
    self._ui_right.stc_bottomBg:addInputEvent("Mouse_DownScroll", "HandleEventLDown_MentalGame_All_CardRotation(false)")
    self._ui_right.stc_bottomBg:addInputEvent("Mouse_UpScroll", "HandleEventLDown_MentalGame_All_CardRotation(true)")
    self._ui_left.btn_exit:addInputEvent("Mouse_LUp", "PaGlobal_MentalGame_All:prepareClose()")
  else
    Panel_MentalGameRight_All:registerPadEvent(__eConsoleUIPadEvent_LB, "HandleEventLDown_MentalGame_All_CardRotation(true)")
    Panel_MentalGameRight_All:registerPadEvent(__eConsoleUIPadEvent_RB, "HandleEventLDown_MentalGame_All_CardRotation(false)")
    registerEvent("FromClient_PadSnapChangeTarget", "FromClient_MentalGame_All_ChangeTarget")
  end
end
function PaGlobal_MentalGame_All:resize()
  if nil == Panel_MentalGameLeft_All or nil == Panel_MentalGameRight_All or nil == Panel_MentalGameSelect_All or nil == Panel_MentalGameTooltip_All or nil == Panel_MentalGame_Center then
    return
  end
  local sizeX = getScreenSizeX()
  local sizeY = getScreenSizeY()
  Panel_MentalGameLeft_All:SetSize(sizeX, sizeY)
  Panel_MentalGameLeft_All:SetPosX(0)
  Panel_MentalGameLeft_All:SetPosY(0)
  Panel_MentalGameLeft_All:ComputePos()
  for k, v in pairs(self._ui_left) do
    v:ComputePos()
  end
  Panel_MentalGameRight_All:SetPosX(0)
  Panel_MentalGameRight_All:SetPosY(0)
  Panel_MentalGameRight_All:SetSize(sizeX, Panel_MentalGameRight_All:GetSizeY())
  Panel_MentalGameRight_All:ComputePos()
  self._ui_right.stc_bottomDecoBg:SetSize(sizeX, self._ui_right.stc_bottomDecoBg:GetSizeY())
  for k, v in pairs(self._ui_right) do
    v:ComputePos()
  end
  self._ui_select.stc_npcCircleProgress:ComputePos()
  self._ui_select.stc_successIcon:ComputePos()
  self._ui_select.stc_failedIcon:ComputePos()
  Panel_MentalGameSelect_All:ComputePos()
  for k, v in pairs(self._ui_select) do
    v:ComputePos()
  end
  self._ui_tooltip.txt_npcName:ComputePos()
  self._ui_tooltip.txt_statusTitle:ComputePos()
  self._ui_tooltip.txt_hitBase:ComputePos()
  self._ui_tooltip.txt_hitBonus:ComputePos()
  self._ui_tooltip.txt_valueBase:ComputePos()
  self._ui_tooltip.txt_valueBonus:ComputePos()
  self._ui_tooltip.txt_commentTitle:ComputePos()
  self._ui_tooltip.txt_commentInterest:ComputePos()
  self._ui_tooltip.txt_commentFavorable:ComputePos()
  self._ui_tooltip.txt_nextBonusTitle:ComputePos()
  self._ui_tooltip.txt_nextBonuse:ComputePos()
  Panel_MentalGameTooltip_All:ComputePos()
  Panel_MentalGame_Center:SetPosX(0)
  Panel_MentalGame_Center:SetPosY(0)
  Panel_MentalGame_Center:SetSize(sizeX, sizeY)
  self._ui_center.stc_finishBg:SetSize(sizeX, self._ui_center.stc_finishBg:GetSizeY())
  self._ui_center.txt_finishResult:SetSize(sizeX, self._ui_center.txt_finishResult:GetSizeY())
  self._ui_center.stc_finishBg:ComputePos()
  self._ui_center.txt_finishResult:ComputePos()
  Panel_MentalGame_Center:ComputePos()
  self._ui_pc.btn_try:ComputePos()
  self._ui_pc.btn_continue:ComputePos()
  self._ui_pc.btn_continueDesc:ComputePos()
  self._ui_pc.btn_leave:ComputePos()
  self._ui_pc.btn_leaveDesc:ComputePos()
  local keyGuidePosX = self._ui_right.stc_bottomBg:GetPosX() - self._ui_console.stc_keyGuideBg:GetSizeX()
  self._ui_console.stc_keyGuideBg:SetSpanSize(keyGuidePosX, self._ui_console.stc_keyGuideBg:GetSpanSize().y)
  self._ui_console.stc_keyGuideBg:ComputePos()
  self._ui_console.stc_guideIconB:ComputePos()
  self._ui_console.stc_guideIconA:ComputePos()
  self._ui_console.stc_guideIconY:ComputePos()
  self._ui_console.stc_guideIconX:ComputePos()
  self._ui_console.stc_guideIconRB:ComputePos()
  self._ui_console.stc_guideIconLB:ComputePos()
end
function PaGlobal_MentalGame_All:validate()
  if nil == Panel_MentalGameLeft_All or nil == Panel_MentalGameRight_All or nil == Panel_MentalGameSelect_All or nil == Panel_MentalGameTooltip_All or nil == Panel_MentalGame_Center then
    return
  end
  self._ui_left.stc_leftBg:isValidate()
  self._ui_left.txt_npcType:isValidate()
  self._ui_left.txt_npcName:isValidate()
  self._ui_left.txt_mission:isValidate()
  self._ui_left.txt_tip:isValidate()
  self._ui_left.txt_interest:isValidate()
  self._ui_left.txt_impression:isValidate()
  self._ui_left.stc_intimacyCircleProgressBg:isValidate()
  self._ui_left.stc_intimacyCircleProgress:isValidate()
  self._ui_left.stc_intimacyCirclePoint:isValidate()
  self._ui_left.txt_imtimacyTitle:isValidate()
  self._ui_left.stc_rewardIcon:isValidate()
  self._ui_left.txt_reward:isValidate()
  self._ui_left.stc_resultBg:isValidate()
  self._ui_left.txt_result:isValidate()
  self._ui_left.btn_exit:isValidate()
  self._ui_right.stc_topBg:isValidate()
  self._ui_right.txt_comment1:isValidate()
  self._ui_right.txt_comment2:isValidate()
  self._ui_right.stc_bottomDecoBg:isValidate()
  self._ui_right.stc_bottomBg:isValidate()
  self._ui_right.stc_circleLineBg:isValidate()
  self._ui_right.btn_rightArrow:isValidate()
  self._ui_right.btn_leftArrow:isValidate()
  self._ui_right.stc_nowListBg:isValidate()
  self._ui_right.stc_selectedNpc:isValidate()
  self._ui_right.stc_mentalNpcIcon:isValidate()
  self._ui_right.stc_mentalNpcName:isValidate()
  self._ui_right.stc_listPoint:isValidate()
  self._ui_right.stc_checkIcon:isValidate()
  self._ui_right.stc_interestBg:isValidate()
  self._ui_right.txt_interestTitle:isValidate()
  self._ui_right.txt_mentalCount:isValidate()
  self._ui_right.txt_intimacyGet:isValidate()
  self._ui_select.txt_addInterest:isValidate()
  self._ui_select.stc_npcCircleProgress:isValidate()
  self._ui_select.stc_successIcon:isValidate()
  self._ui_select.stc_failedIcon:isValidate()
  self._ui_tooltip.txt_npcName:isValidate()
  self._ui_tooltip.txt_statusTitle:isValidate()
  self._ui_tooltip.txt_hitBase:isValidate()
  self._ui_tooltip.txt_hitBonus:isValidate()
  self._ui_tooltip.txt_valueBase:isValidate()
  self._ui_tooltip.txt_valueBonus:isValidate()
  self._ui_tooltip.txt_commentTitle:isValidate()
  self._ui_tooltip.txt_commentInterest:isValidate()
  self._ui_tooltip.txt_commentFavorable:isValidate()
  self._ui_tooltip.txt_nextBonusTitle:isValidate()
  self._ui_tooltip.txt_nextBonuse:isValidate()
  self._ui_center.stc_finishBg:isValidate()
  self._ui_center.txt_finishResult:isValidate()
  self._ui_pc.btn_try:isValidate()
  self._ui_pc.btn_continue:isValidate()
  self._ui_pc.btn_continueDesc:isValidate()
  self._ui_pc.btn_leave:isValidate()
  self._ui_pc.btn_leaveDesc:isValidate()
  self._ui_console.stc_keyGuideBg:isValidate()
  self._ui_console.stc_guideIconB:isValidate()
  self._ui_console.stc_guideIconA:isValidate()
  self._ui_console.stc_guideIconY:isValidate()
  self._ui_console.stc_guideIconX:isValidate()
  self._ui_console.stc_guideIconRB:isValidate()
  self._ui_console.stc_guideIconLB:isValidate()
end
function PaGlobal_MentalGame_All:setKeyGuideAndEvent()
  if nil == Panel_MentalGameLeft_All or nil == Panel_MentalGameRight_All or nil == Panel_MentalGameSelect_All or nil == Panel_MentalGameTooltip_All or nil == Panel_MentalGame_Center then
    return
  end
  local mentalObject = getMentalgameObject()
  if nil == mentalObject then
    return
  end
  local filledCount = mentalObject:getFilledSlotCount()
  Panel_MentalGameRight_All:registerPadEvent(__eConsoleUIPadEvent_Up_A, "")
  Panel_MentalGameRight_All:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "")
  Panel_MentalGameRight_All:registerPadEvent(__eConsoleUIPadEvent_Up_X, "")
  self._ui_console.stc_guideIconX:SetShow(false)
  if 0 == self._gameStep then
    self._ui_console.stc_guideIconY:SetShow(0 < filledCount)
    self._ui_console.stc_guideIconA:SetShow(true)
    self._ui_console.stc_guideIconB:SetShow(true)
    self._ui_console.stc_guideIconX:SetShow(true)
    self._ui_console.stc_guideIconA:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WORLDMAP_GUILDHOUSE_CHANGEWORKER_SELECTBTN"))
    self._ui_console.stc_guideIconY:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_GAMEOPTION_GAME_BTN_RESET"))
    self._ui_console.stc_guideIconX:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_PEARLSHOP_DETAILINFOVIEW"))
    Panel_MentalGameRight_All:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "HandleEventUPY_MentalGame_All_Reset()")
  elseif 1 == self._gameStep then
    self._ui_console.stc_guideIconY:SetShow(true)
    self._ui_console.stc_guideIconA:SetShow(true)
    self._ui_console.stc_guideIconB:SetShow(true)
    self._ui_console.stc_guideIconX:SetShow(true)
    self._ui_console.stc_guideIconA:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_MENTALGAME_RIGHT_APPLY_NEW_BTN"))
    self._ui_console.stc_guideIconY:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_GAMEOPTION_GAME_BTN_RESET"))
    Panel_MentalGameRight_All:registerPadEvent(__eConsoleUIPadEvent_Up_A, "HandleEventLDown_MentalGame_All_Try()")
    Panel_MentalGameRight_All:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "HandleEventUPY_MentalGame_All_Reset()")
  elseif 2 == self._gameStep then
    self._ui_console.stc_guideIconA:SetShow(false)
    self._ui_console.stc_guideIconY:SetShow(false)
    self._ui_console.stc_guideIconB:SetShow(false)
  elseif 3 == self._gameStep then
    local mentalStage = RequestMentalGame_getMentalStage()
    local playableNextGame = self._gamePlayCount < self._constValue.maxPlayCount
    self._ui_console.stc_guideIconX:SetShow(mentalStage._isSuccess and playableNextGame)
    self._ui_console.stc_guideIconA:SetShow(false)
    self._ui_console.stc_guideIconB:SetShow(true)
    self._ui_console.stc_guideIconY:SetShow(false)
    if mentalStage._isSuccess and playableNextGame then
      self._ui_console.stc_guideIconX:SetText(PAGetString(Defines.StringSheet_RESOURCE, "MENTAL_BASE_TEXT_TRYAGAIN"))
      Panel_MentalGameRight_All:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandleEventLDown_MentalGame_All_Continue()")
    end
  end
  PaGlobalFunc_ConsoleKeyGuide_SetAlign(self._keyGuides, self._ui_console.stc_keyGuideBg, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHT)
end
function PaGlobal_MentalGame_All:gameStartInit()
  self._bestPoint = 0
  self._scrollPositionResult = 0
  self._scrollPosition = -5
  self._gamePlayCount = self._gamePlayCount + 1
  self._mouseInputer:SetShow(true)
  self._ui_zodiac.panel:SetShow(true)
  DragManager:setDragImageSize(80, 80)
  local mentalObject = getMentalgameObject()
  if nil == mentalObject then
    return
  end
  local zodiacSSW = mentalObject:getZodiacStaticStatusWrapper()
  if nil ~= zodiacSSW then
    self._ui_zodiac.control:ChangeTextureInfoName(zodiacSSW:getZodiacImagePath())
  end
  for key, value in pairs(self._centerUiList) do
    value.circularProgress:SetCurrentControlPos(0)
    value.circularProgress:SetProgressRate(0)
    value.SuccessIcon:ResetVertexAni()
    value.SuccessIcon:SetShow(false)
    value.FailedIcon:ResetVertexAni()
    value.FailedIcon:SetShow(false)
  end
  self:updateCardScrollButton()
end
function PaGlobal_MentalGame_All:mentalBaseInit()
  MentalKnowledgeBase.init()
end
function PaGlobal_MentalGame_All:createCenterUI()
  if nil == Panel_MentalGameSelect_All then
    return
  end
  local mentalObject = getMentalgameObject()
  if nil == mentalObject then
    return
  end
  local function funcCreateUI(key, uiGroup)
    if nil ~= uiGroup.panel then
      return
    end
    local panel = UI.createPanelAndSetPanelRenderMode("Panel_MentalGame_Select_" .. tostring(key), Defines.UIGroup.PAGameUIGroup_QuestLog, PAUIRenderModeBitSet({
      Defines.RenderMode.eRenderMode_MentalGame
    }))
    panel:SetAlpha(1)
    panel:SetSize(10, 10)
    if true == self._isConsole then
      panel:registerPadEvent(__eConsoleUIPadEvent_X, "HandleEventPad_MentalGame_All_CardOver(" .. key .. ", true)")
    else
      panel:addInputEvent("Mouse_On", "HandleEventOnOut_MentalGame_All_CardOver(" .. key .. ",true,true)")
      panel:addInputEvent("Mouse_Out", "HandleEventOnOut_MentalGame_All_CardOver(" .. key .. ",true,false)")
    end
    panel:addInputEvent("Mouse_RUp", "HandleEventRUp_MentalGame_All_UpdateCenterSlot(" .. key .. ")")
    uiGroup.panel = panel
    panel:SetAlpha(1)
    panel:SetPosX(0)
    panel:SetPosY(0)
    panel:SetIgnore(false)
    panel:SetShow(false)
    local circularProgress = UI.createControl(__ePAUIControl_CircularProgress, panel, "CircularProgres_" .. key)
    CopyBaseProperty(self._ui_select.stc_npcCircleProgress, circularProgress)
    uiGroup.circularProgress = circularProgress
    circularProgress:ComputePos()
    circularProgress:SetPosX(0)
    circularProgress:SetPosY(0)
    circularProgress:SetShow(true)
    circularProgress:SetCurrentControlPos(0)
    circularProgress:SetProgressRate(0)
    circularProgress:SetSmoothMode(true)
    circularProgress:SetAniSpeed(mentalObject:getMentalGameSpeed() / 100)
    local SuccessIcon = UI.createControl(__ePAUIControl_Static, panel, "SuccessIcon_" .. key)
    CopyBaseProperty(self._ui_select.stc_successIcon, SuccessIcon)
    uiGroup.SuccessIcon = SuccessIcon
    SuccessIcon:ComputePos()
    local FailedIcon = UI.createControl(__ePAUIControl_Static, panel, "FailedIcon_" .. key)
    CopyBaseProperty(self._ui_select.stc_failedIcon, FailedIcon)
    uiGroup.FailedIcon = FailedIcon
    FailedIcon:ComputePos()
  end
  local slotCount = mentalObject:getSlotCount()
  for index = 0, slotCount - 1 do
    if nil == self._centerUiList[index] then
      self._centerUiList[index] = {}
    end
    funcCreateUI(index, self._centerUiList[index])
  end
end
function PaGlobal_MentalGame_All:createAnimationUI()
  if nil == Panel_MentalGameSelect_All then
    return
  end
  local otherControlTextType = __ePAUIControl_StaticText
  for from = 0, 19 do
    if nil == self._animationUIList[from] then
      self._animationUIList[from] = {}
    end
    for to = from + 1, 19 do
      if nil == self._animationUIList[from][to] then
        self._animationUIList[from][to] = {}
      end
      local targetGroup = self._animationUIList[from][to]
      if nil == targetGroup.panel then
        local target = UI.createPanelAndSetPanelRenderMode("MentalGame_Animation_" .. tostring(from) .. "_" .. tostring(to), Defines.UIGroup.PAGameUIGroup_QuestLog, PAUIRenderModeBitSet({
          Defines.RenderMode.eRenderMode_MentalGame
        }))
        target:SetIgnore(true)
        target:SetShow(false)
        target:SetSpanSize(0, 0)
        target:SetAlpha(1)
        target:ComputePos()
        targetGroup.panel = target
      end
      if nil == targetGroup.pointImage then
        local target = UI.createControl(otherControlTextType, targetGroup.panel, "PointImage")
        CopyBaseProperty(self._ui_select.txt_addInterest, target)
        target:SetIgnore(true)
        target:SetShow(false)
        target:SetAlpha(0.5)
        target:SetFontAlpha(0)
        target:SetSpanSize(0, 0)
        target:ComputePos()
        target:SetHorizonCenter()
        target:SetVerticalMiddle()
        targetGroup.pointImage = target
      end
      if nil == targetGroup.nameTag then
        local nameTag = UI.createControl(otherControlTextType, targetGroup.pointImage, "NameTag")
        nameTag:SetIgnore(true)
        nameTag:SetShow(true)
        nameTag:SetSpanSize(0, 30)
        nameTag:SetHorizonCenter()
        nameTag:SetVerticalBottom()
        targetGroup.nameTag = nameTag
      end
    end
  end
end
function PaGlobal_MentalGame_All:createInformationUI()
  if nil == Panel_MentalGameSelect_All then
    return
  end
  local otherControlTextType = __ePAUIControl_StaticText
  for from = 0, 19 do
    if nil == self._informationUI[from] then
      self._informationUI[from] = {}
    end
    for to = from + 1, 19 do
      if nil == self._informationUI[from][to] then
        self._informationUI[from][to] = {}
      end
      local targetGroup = self._informationUI[from][to]
      if nil == targetGroup.panel then
        local target = UI.createPanel("MentalGame_Information_" .. tostring(from) .. "_" .. tostring(to), Defines.UIGroup.PAGameUIGroup_QuestLog)
        target:SetIgnore(true)
        target:SetShow(false)
        target:SetSpanSize(0, 0)
        target:SetAlpha(1)
        target:ComputePos()
        targetGroup.panel = target
      end
      if nil == targetGroup.pointImage then
        local target = UI.createControl(otherControlTextType, targetGroup.panel, "PointImage")
        CopyBaseProperty(self._ui_select.txt_addInterest, target)
        target:SetIgnore(false)
        target:SetShow(true)
        target:SetAlpha(1)
        target:SetSpanSize(0, 0)
        target:SetFontAlpha(0)
        target:ComputePos()
        target:SetHorizonCenter()
        target:SetVerticalMiddle()
        target:addInputEvent("Mouse_On", "HandleEventOnOut_MentalGame_All_InformationUIFontAlpha(" .. from .. ", " .. to .. ", 1.0,true)")
        target:addInputEvent("Mouse_Out", "HandleEventOnOut_MentalGame_All_InformationUIFontAlpha(" .. from .. ", " .. to .. ", 0.0,true)")
        targetGroup.pointImage = target
      end
      if nil == targetGroup.nameTag then
        local nameTag = UI.createControl(otherControlTextType, targetGroup.pointImage, "NameTag")
        nameTag:SetIgnore(true)
        nameTag:SetShow(true)
        nameTag:SetFontAlpha(0)
        nameTag:SetSpanSize(0, 30)
        nameTag:SetHorizonCenter()
        nameTag:SetVerticalBottom()
        targetGroup.nameTag = nameTag
      end
    end
  end
end
function PaGlobal_MentalGame_All:createMouseInputerAndSetting()
  self._mouseInputer = UI.createPanel("MentalGame_MouseInputer", Defines.UIGroup.PAGameUIGroup_ScreenEffect)
  self._mouseInputer:SetAlpha(0)
  self._mouseInputer:SetPosX(0)
  self._mouseInputer:SetPosY(0)
  self._mouseInputer:SetSize(getScreenSizeX(), getScreenSizeY())
  self._mouseInputer:addInputEvent("Mouse_LDown", "HandleEventLDown_MentalGame_All_MouseInputer()")
  self._mouseInputer:addInputEvent("Mouse_LUp", "HandleEventLUp_MentalGame_All_MouseInputer()")
  self._mouseInputer:addInputEvent("Mouse_RDown", "HandleEventRDown_MentalGame_All_MouseInputer()")
  self._mouseInputer:addInputEvent("Mouse_RUp", "HandleEventRUp_MentalGame_All_MouseInputer()")
  self._mouseInputer:addInputEvent("Mouse_UpScroll", "HandleEventUpScroll_MentalGame_All_MouseInputer()")
  self._mouseInputer:addInputEvent("Mouse_DownScroll", "HandleEventDownScroll_MentalGame_All_MouseInputer()")
  self._mouseInputer:SetShow(false, false)
end
function PaGlobal_MentalGame_All:addAnimation(ui, startTime, endTime, startIndex, endIndex, animationFunc)
  if endTime <= startTime or nil == ui or endTime <= 0 or nil == animationFunc then
    return
  end
  self._animationList[self._animationIndex] = {
    ui = ui,
    startTime = startTime,
    endTime = endTime,
    startIndex = startIndex,
    endIndex = endIndex,
    deltaTime = 0,
    animationFunc = animationFunc
  }
  self._animationIndex = self._animationIndex + 1
end
function PaGlobal_MentalGame_All:giftIconInit()
  if nil == Panel_MentalGameLeft_All then
    return
  end
  local talker = dialog_getTalker()
  if nil == talker then
    return
  end
  local characterKey = talker:getCharacterKey()
  local count = getIntimacyInformationCount(characterKey)
  local colorKey = float4(1, 1, 1, 1)
  local QuestCount = 1
  local talkerIntimacy = talker:getIntimacy()
  for index, value in pairs(self._giftIcon) do
    UI.deleteControl(value)
  end
  self._giftIcon = {}
  for index = 0, count - 1 do
    local intimacyInformationData = getIntimacyInformation(characterKey, index)
    local intimacyValue = intimacyInformationData:getIntimacy()
    local percent = intimacyValue / 1000
    local imageType = intimacyInformationData:getTypeIndex()
    local giftName = intimacyInformationData:getTypeName()
    local giftDesc = intimacyInformationData:getTypeDescription()
    local giftMentalCardWrapper = ToClinet_getMentalCardStaticStatus(intimacyInformationData:getMentalCardKeyRaw())
    local giftOperator = intimacyInformationData:getOperatorType()
    local imageFileName = ""
    if 0 <= percent and percent <= 1 and ToClient_checkIntimacyInformationFixedState(intimacyInformationData) then
      local angle = math.pi * 2 * percent
      local lineStart = float3(math.sin(angle), -math.cos(angle), 0)
      local lineEnd = float3(math.sin(angle), -math.cos(angle), 0)
      local startSize = 28
      local ProgressBG = self._ui_left.stc_intimacyCircleProgressBg
      local endSize = (ProgressBG:GetSizeX() + self._ui_left.stc_rewardIcon:GetSizeX()) / 2
      local centerPosition = float3(ProgressBG:GetPosX() + ProgressBG:GetSizeX() / 2, ProgressBG:GetPosY() + ProgressBG:GetSizeY() / 2, 0)
      centerPosition.x = centerPosition.x - 35
      centerPosition.y = centerPosition.y - 60
      lineStart = Util.Math.AddVectorToVector(centerPosition, Util.Math.MulNumberToVector(lineStart, startSize))
      lineEnd = Util.Math.AddVectorToVector(centerPosition, Util.Math.MulNumberToVector(lineEnd, endSize))
      local target = self._giftIcon[index]
      if nil == target then
        target = UI.createControl(__ePAUIControl_Static, self._ui_left.stc_intimacyCircleProgressBg, "GiftIcon_" .. tostring(index))
        self._giftIcon[index] = target
        CopyBaseProperty(self._ui_left.stc_rewardIcon, target)
      end
      target:SetShow(true)
      if nil ~= giftMentalCardWrapper then
        if giftMentalCardWrapper:isHasCard() then
          giftDesc = giftDesc .. " <PAColor0xFFF5BA3A>" .. self._text.hasMentalCardText .. "<PAOldColor>"
          target:SetColor(Defines.Color.C_FFFFEDD4)
        else
          giftDesc = giftDesc .. " " .. self._text.hasntMentalCardText
          target:SetColor(Defines.Color.C_FF585453)
        end
      else
        target:SetColor(Defines.Color.C_FFFFEDD4)
      end
      local giftValue = ""
      giftValue = "(" .. self._operatorString[giftOperator] .. " " .. percent * 1000 .. ")"
      local rewardText = giftName .. " : " .. giftDesc .. " " .. giftValue
      local IconType
      if 0 == imageType then
        IconType = self._intimacyIcon[imageType][QuestCount]
        QuestCount = QuestCount + 1
        if 3 < QuestCount then
          QuestCount = 3
        end
      else
        IconType = self._intimacyIcon[imageType]
      end
      target:ChangeTextureInfoName(IconType.texture)
      local x1, y1, x2, y2 = setTextureUV_Func(target, IconType.x1, IconType.y1, IconType.x2, IconType.y2)
      target:getBaseTexture():setUV(x1, y1, x2, y2)
      target:setRenderTexture(target:getBaseTexture())
      target:SetPosX(lineEnd.x - target:GetSizeX() / 2)
      target:SetPosY(lineEnd.y - target:GetSizeY() / 2)
      target:addInputEvent("Mouse_On", "HandleOnOutEvent_MentalGame_All_GiftIconTooltip(true," .. index .. ",\"" .. rewardText .. "\")")
      target:addInputEvent("Mouse_Out", "HandleOnOutEvent_MentalGame_All_GiftIconTooltip(false," .. index .. ",\"" .. rewardText .. "\")")
      target:SetMonoTone(talkerIntimacy < intimacyValue)
    end
  end
end
function PaGlobal_MentalGame_All:endUIProcessMentalOnly(isDead)
  if false == isShow_MentalGame() then
    return false
  end
  for key, value in pairs(self._centerUiList) do
    if nil ~= value.panel then
      value.panel:SetShow(false)
      value.panel:SetPosX(-1000)
      value.panel:SetPosY(-1000)
    end
  end
  for _, value in pairs(self._informationUI) do
    for _, value2 in pairs(value) do
      value2.panel:SetShow(false)
    end
  end
  self:clearCardList()
  self:clearAnimation()
  self:mentalBaseInit()
  self:removeCircleLineAndObject()
  hide_MentalGame(isDead)
  DragManager:setDragImageSize(self._prevDragImageSizeX, self._prevDragImageSizeY)
  DragManager:clearInfo()
  self._mouseInputer:SetShow(false)
  PaGlobal_MentalGame_All:close()
  RequestMentalGame_endGame()
  return true
end
function PaGlobal_MentalGame_All:clearCardList()
  for key, value in pairs(self._rightCardList) do
    if nil ~= value.ui and nil ~= value.ui.cardText then
      self._ui_right.stc_bottomBg:RemoveControl(value.ui.cardText)
      self._ui_right.stc_bottomBg:RemoveControl(value.ui.cardIcon)
      self._ui_right.stc_bottomBg:RemoveControl(value.ui.selectIcon)
    end
  end
  self._rightCardList = {}
end
function PaGlobal_MentalGame_All:clearAnimation()
  for _, value in pairs(self._animationList) do
    value.ui:SetShow(false)
  end
  self._animationList = {}
end
function PaGlobal_MentalGame_All:removeCircleLineAndObject()
  self._circleKeyList = {}
  MentalKnowledgeBase.ClearLineAndCircle()
end
function PaGlobal_MentalGame_All:getCheckApplyKeyIndex(cardIndex)
  local mentalObject = getMentalgameObject()
  if nil == mentalObject then
    return -1
  end
  local card = mentalObject:getCard(cardIndex)
  if nil == card then
    return -1
  end
  local cardKey = card:getStaticStatus():getKey()
  local count = mentalObject:getSlotCount()
  for index = 0, count do
    local slotCard = mentalObject:getCardBySlotIndex(index)
    if nil ~= slotCard and cardKey == slotCard:getStaticStatus():getKey() then
      return index
    end
  end
end
