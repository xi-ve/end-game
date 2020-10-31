function PaGlobal_LifeRanking_All:initialize()
  if true == PaGlobal_LifeRanking_All._initialize then
    return
  end
  PaGlobal_LifeRanking_All._isConsole = _ContentsGroup_RenewUI
  PaGlobal_LifeRanking_All._isPadSnap = _ContentsGroup_UsePadSnapping
  PaGlobal_LifeRanking_All._ui.stc_TitleBG = UI.getChildControl(Panel_LifeRanking_All, "Static_TitleBg")
  PaGlobal_LifeRanking_All._ui.btn_Close = UI.getChildControl(PaGlobal_LifeRanking_All._ui.stc_TitleBG, "Button_Close_PCUI")
  PaGlobal_LifeRanking_All._ui.btn_Question = UI.getChildControl(PaGlobal_LifeRanking_All._ui.stc_TitleBG, "Button_Question_PCUI")
  PaGlobal_LifeRanking_All._ui.stc_RankingTypeBG = UI.getChildControl(Panel_LifeRanking_All, "Static_RankingTypeBG")
  PaGlobal_LifeRanking_All._ui.stc_KeyGuideLB = UI.getChildControl(PaGlobal_LifeRanking_All._ui.stc_RankingTypeBG, "Static_LB_ConsoleUI")
  PaGlobal_LifeRanking_All._ui.stc_KeyGuideRB = UI.getChildControl(PaGlobal_LifeRanking_All._ui.stc_RankingTypeBG, "Static_RB_ConsoleUI")
  PaGlobal_LifeRanking_All._ui.txt_CurRankingTypeTitle = UI.getChildControl(PaGlobal_LifeRanking_All._ui.stc_RankingTypeBG, "StaticText_LifeTitle")
  for i = 0, PaGlobal_LifeRanking_All._MAX_RANKTYPE_COUNT - 1 do
    local typeName = tostring(PaGlobal_LifeRanking_All._rankTypeName[i])
    if "" ~= typeName and nil ~= typeName then
      PaGlobal_LifeRanking_All._ui.stc_RankingIcons[i] = UI.getChildControl(PaGlobal_LifeRanking_All._ui.stc_RankingTypeBG, "RadioButton_RankIcon" .. typeName)
      PaGlobal_LifeRanking_All._ui.stc_RankingIcons[i]:SetShow(self._rankContentsOption[i])
      if self._rankContentsOption[i] then
        self._rightShowRankType = i
      end
    end
  end
  PaGlobal_LifeRanking_All._ui.stc_LeftBG = UI.getChildControl(Panel_LifeRanking_All, "Static_LeftBG")
  PaGlobal_LifeRanking_All._ui.stc_GradeBG = UI.getChildControl(PaGlobal_LifeRanking_All._ui.stc_LeftBG, "Static_GradeBG")
  PaGlobal_LifeRanking_All._ui.stc_CurRankingIconBG = UI.getChildControl(PaGlobal_LifeRanking_All._ui.stc_GradeBG, "Static_RankingBg")
  PaGlobal_LifeRanking_All._ui.txt_CurRankingGradeValue = UI.getChildControl(PaGlobal_LifeRanking_All._ui.stc_CurRankingIconBG, "StaticText_RankingValue")
  PaGlobal_LifeRanking_All._ui.txt_CurRankingType = UI.getChildControl(PaGlobal_LifeRanking_All._ui.stc_GradeBG, "StaticText_MyRankingTitle")
  PaGlobal_LifeRanking_All._ui.stc_GradeBar = UI.getChildControl(PaGlobal_LifeRanking_All._ui.stc_GradeBG, "Static_GradeBar")
  PaGlobal_LifeRanking_All._ui.stc_GradeBarArrow = UI.getChildControl(PaGlobal_LifeRanking_All._ui.stc_GradeBar, "Static_Arrow")
  PaGlobal_LifeRanking_All._ui.txt_CurRankingDesc = UI.getChildControl(PaGlobal_LifeRanking_All._ui.stc_GradeBG, "StaticText_MyRanking")
  local txtGradeA = UI.getChildControl(PaGlobal_LifeRanking_All._ui.stc_GradeBar, "StaticText_Rank_A")
  local txtGradeB = UI.getChildControl(PaGlobal_LifeRanking_All._ui.stc_GradeBar, "StaticText_Rank_B")
  local txtGradeC = UI.getChildControl(PaGlobal_LifeRanking_All._ui.stc_GradeBar, "StaticText_Rank_C")
  local txtGradeD = UI.getChildControl(PaGlobal_LifeRanking_All._ui.stc_GradeBar, "StaticText_Rank_D")
  local txtGradeE = UI.getChildControl(PaGlobal_LifeRanking_All._ui.stc_GradeBar, "StaticText_Rank_E")
  self._lifeGradeString = {}
  if true == isGameTypeKR2() then
    self._lifeGradeString[0] = PAGetString(Defines.StringSheet_GAME, "LUA_LIFERANKING_A")
    self._lifeGradeString[1] = PAGetString(Defines.StringSheet_GAME, "LUA_LIFERANKING_B")
    self._lifeGradeString[2] = PAGetString(Defines.StringSheet_GAME, "LUA_LIFERANKING_C")
    self._lifeGradeString[3] = PAGetString(Defines.StringSheet_GAME, "LUA_LIFERANKING_D")
    self._lifeGradeString[4] = PAGetString(Defines.StringSheet_GAME, "LUA_LIFERANKING_E")
  else
    self._lifeGradeString[0] = "A"
    self._lifeGradeString[1] = "B"
    self._lifeGradeString[2] = "C"
    self._lifeGradeString[3] = "D"
    self._lifeGradeString[4] = "E"
  end
  txtGradeA:SetText(self._lifeGradeString[0])
  txtGradeB:SetText(self._lifeGradeString[1])
  txtGradeC:SetText(self._lifeGradeString[2])
  txtGradeD:SetText(self._lifeGradeString[3])
  txtGradeE:SetText(self._lifeGradeString[4])
  PaGlobal_LifeRanking_All._ui.stc_MyRankingBG = UI.getChildControl(PaGlobal_LifeRanking_All._ui.stc_LeftBG, "Static_MyRankingBG")
  local rankTitle = UI.getChildControl(PaGlobal_LifeRanking_All._ui.stc_MyRankingBG, "StaticText_Title")
  local rankValue = UI.getChildControl(PaGlobal_LifeRanking_All._ui.stc_MyRankingBG, "StaticText_Value")
  local defaultPosY = rankTitle:GetPosY()
  local defalutGapY = rankTitle:GetSizeY() + 5
  PaGlobal_LifeRanking_All._ui.stc_MyRankingBG:ComputePos()
  rankTitle:SetTextVerticalTop()
  rankValue:SetTextVerticalTop()
  local uiCount = 0
  for i = 0, PaGlobal_LifeRanking_All._MAX_RANKTYPE_COUNT - 1 do
    if nil ~= PaGlobal_LifeRanking_All._ui.stc_RankingIcons[i] and self._rankContentsOption[i] then
      local typeName = tostring(PaGlobal_LifeRanking_All._rankTypeName[i])
      PaGlobal_LifeRanking_All._ui.txt_MyRanking_Title[i] = UI.cloneControl(rankTitle, PaGlobal_LifeRanking_All._ui.stc_MyRankingBG, "StaticText_" .. typeName .. "_Title")
      PaGlobal_LifeRanking_All._ui.txt_MyRanking_Value[i] = UI.cloneControl(rankValue, PaGlobal_LifeRanking_All._ui.stc_MyRankingBG, "StaticText_" .. typeName .. "_Value")
      PaGlobal_LifeRanking_All._ui.txt_MyRanking_Title[i]:SetText(PaGlobal_LifeRanking_All._tabName[i])
      PaGlobal_LifeRanking_All._ui.txt_MyRanking_Title[i]:SetPosX(rankTitle:GetPosX())
      PaGlobal_LifeRanking_All._ui.txt_MyRanking_Value[i]:SetPosX(rankValue:GetPosX())
      PaGlobal_LifeRanking_All._ui.txt_MyRanking_Title[i]:SetPosY(defaultPosY + uiCount * defalutGapY)
      PaGlobal_LifeRanking_All._ui.txt_MyRanking_Value[i]:SetPosY(defaultPosY + uiCount * defalutGapY)
      uiCount = uiCount + 1
    end
  end
  rankTitle:SetShow(false)
  rankValue:SetShow(false)
  PaGlobal_LifeRanking_All._ui.stc_ListTitleBG = UI.getChildControl(Panel_LifeRanking_All, "Static_ListTitleBg")
  PaGlobal_LifeRanking_All._ui.txt_CharacterNameTitle = UI.getChildControl(PaGlobal_LifeRanking_All._ui.stc_ListTitleBG, "StaticText_CharacterName")
  PaGlobal_LifeRanking_All._ui.txt_GuildNameTitle = UI.getChildControl(PaGlobal_LifeRanking_All._ui.stc_ListTitleBG, "StaticText_GuildName")
  PaGlobal_LifeRanking_All._ui.txt_RankTitle = UI.getChildControl(PaGlobal_LifeRanking_All._ui.stc_ListTitleBG, "StaticText_Rank")
  if _ContentsGroup_RenewUI then
    PaGlobal_LifeRanking_All._ui.txt_CharacterNameTitle:SetText(PAGetString(Defines.StringSheet_RESOURCE, "UI_CHARACTERCREATE1_STCTXT_FAMILYNAMETITLE") .. "(" .. ToClient_ConsoleUserNameString() .. ")")
  end
  PaGlobal_LifeRanking_All._ui.list2_Ranking = UI.getChildControl(Panel_LifeRanking_All, "List2_RankingListBg")
  PaGlobal_LifeRanking_All._ui.txt_Comment = UI.getChildControl(Panel_LifeRanking_All, "StaticText_Comment")
  PaGlobal_LifeRanking_All._ui.stc_BottomBG = UI.getChildControl(Panel_LifeRanking_All, "Static_BottomBg")
  PaGlobal_LifeRanking_All._ui.txt_KeyGuide_A = UI.getChildControl(PaGlobal_LifeRanking_All._ui.stc_BottomBG, "StaticText_A_ConsoleUI")
  PaGlobal_LifeRanking_All._ui.txt_KeyGuide_B = UI.getChildControl(PaGlobal_LifeRanking_All._ui.stc_BottomBG, "StaticText_B_ConsoleUI")
  PaGlobal_LifeRanking_All._ui.txt_KeyGuide_X = UI.getChildControl(PaGlobal_LifeRanking_All._ui.stc_BottomBG, "StaticText_X_ConsoleUI")
  PaGlobal_LifeRanking_All._ui.txt_KeyGuide_Y = UI.getChildControl(PaGlobal_LifeRanking_All._ui.stc_BottomBG, "StaticText_Y_ConsoleUI")
  PaGlobal_LifeRanking_All._ui.txt_KeyGuide_LT = UI.getChildControl(PaGlobal_LifeRanking_All._ui.stc_BottomBG, "StaticText_LT_ConsoleUI")
  PaGlobal_LifeRanking_All._ui.txt_KeyGuide_X:SetText(PAGetString(Defines.StringSheet_GAME, "INTERACTION_MENU48"))
  PaGlobal_LifeRanking_All._ui.txt_KeyGuide_Y:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_TOGGLE_SHOW"))
  PaGlobal_LifeRanking_All._ui.txt_KeyGuide_LT:SetText(PAGetString(Defines.StringSheet_GAME, "FRIEND_TEXT_XBOX_PROFILE"))
  PaGlobal_LifeRanking_All._ui.txt_KeyGuide_LT:SetShow(_ContentsGroup_isXBOXUI)
  PaGlobal_LifeRanking_All._keyGuideGroup = {
    PaGlobal_LifeRanking_All._ui.txt_KeyGuide_LT,
    PaGlobal_LifeRanking_All._ui.txt_KeyGuide_X,
    PaGlobal_LifeRanking_All._ui.txt_KeyGuide_Y,
    PaGlobal_LifeRanking_All._ui.txt_KeyGuide_A,
    PaGlobal_LifeRanking_All._ui.txt_KeyGuide_B
  }
  PaGlobal_LifeRanking_All._ui.tooltipBG = UI.getChildControl(Panel_LifeRanking_All, "Static_Tooltip")
  PaGlobal_LifeRanking_All._ui.tooltipName = UI.getChildControl(PaGlobal_LifeRanking_All._ui.tooltipBG, "StaticText_Name")
  PaGlobal_LifeRanking_All._ui.tooltipDesc = UI.getChildControl(PaGlobal_LifeRanking_All._ui.tooltipBG, "StaticText_Desc")
  PaGlobal_LifeRanking_All._ui.list2_Ranking:createChildContent(__ePAUIList2ElementManagerType_List)
  PaGlobal_LifeRanking_All._ui.list2_Ranking:registEvent(__ePAUIList2EventType_LuaChangeContent, "PaGlobal_LifeRanking_All_CreateRankingList")
  local commentPosX = PaGlobal_LifeRanking_All._ui.txt_Comment:GetPosX()
  PaGlobal_LifeRanking_All._ui.txt_Comment:SetPosX(commentPosX - PaGlobal_LifeRanking_All._ui.txt_Comment:GetTextSizeX())
  PaGlobal_LifeRanking_All._ui.txt_CurRankingDesc:SetTextMode(__eTextMode_AutoWrap)
  PaGlobal_LifeRanking_All._ui.tooltipDesc:SetTextMode(__eTextMode_AutoWrap)
  PaGlobal_LifeRanking_All._defaultTooltipSizeX = PaGlobal_LifeRanking_All._ui.tooltipBG:GetSizeX()
  PaGlobal_LifeRanking_All:alignTabIcons()
  PaGlobal_LifeRanking_All:prepareForPlatform()
  PaGlobal_LifeRanking_All:registEventHandler()
  PaGlobal_LifeRanking_All._initialize = true
end
function PaGlobal_LifeRanking_All:registEventHandler()
  if nil == Panel_LifeRanking_All then
    return
  end
  registerEvent("onScreenResize", "HandleEvent_LifeRanking_RePos")
  registerEvent("FromClient_ShowLifeRank", "PaGloabl_LifeRanking_UpdateAndShow_All")
  registerEvent("FromClient_ShowContentsRank", "FromClient_LifeRanking_ShowContentsRank_All")
  registerEvent("FromClient_ResponseMatchRank", "PaGloabl_LifeRanking_UpdateAndShow_All")
  registerEvent("FromClient_LifeRanking_Refresh", "FromClient_LifeRanking_Refresh_All")
  registerEvent("FromClient_UpdateLifeRanking", "FromClient_LifeRanking_Update_All")
  if true == PaGlobal_LifeRanking_All._isPadSnap then
    Panel_LifeRanking_All:registerPadEvent(__eConsoleUIPadEvent_LB, "HandleEvent_LifeRanking_MoveTab(" .. -1 .. ")")
    Panel_LifeRanking_All:registerPadEvent(__eConsoleUIPadEvent_RB, "HandleEvent_LifeRanking_MoveTab(" .. 1 .. ")")
    Panel_LifeRanking_All:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "HandleEvent_LifeRanking_ShowNameToggle()")
  else
    PaGlobal_LifeRanking_All._ui.btn_Question:addInputEvent("Mouse_LUp", "Panel_WebHelper_ShowToggle( \"LifeRanking\" )")
    PaGlobal_Util_RegistHelpTooltipEvent(PaGlobal_LifeRanking_All._ui.btn_Question, "\"LifeRanking\"")
    PaGlobal_LifeRanking_All._ui.btn_Close:addInputEvent("Mouse_LUp", "PaGlobal_LifeRanking_Close_All()")
    for idx = 0, PaGlobal_LifeRanking_All._MAX_RANKTYPE_COUNT - 1 do
      if nil ~= PaGlobal_LifeRanking_All._ui.stc_RankingIcons[idx] then
        PaGlobal_LifeRanking_All._ui.stc_RankingIcons[idx]:addInputEvent("Mouse_LUp", "PaGlobal_LifeRanking_All:setTabTo( " .. idx .. " )")
        PaGlobal_LifeRanking_All._ui.stc_RankingIcons[idx]:addInputEvent("Mouse_On", "HandleEventOnOut_LifeRanking_CategoryNameTooltip( " .. idx .. ", true )")
        PaGlobal_LifeRanking_All._ui.stc_RankingIcons[idx]:addInputEvent("Mouse_Out", "HandleEventOnOut_LifeRanking_CategoryNameTooltip( " .. idx .. ", false )")
      end
    end
  end
end
function PaGlobal_LifeRanking_All:prepareOpen()
  if nil == Panel_LifeRanking_All then
    return
  end
  if true == ToClient_IsInstanceFieldPlayerbyContentsType(__eInstanceContentsType_SavageDefence) then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoCantDoingAlterOfBlood"))
    return
  end
  PaGlobal_LifeRanking_All:setTabTo(PaGlobal_LifeRanking_All._selectedTabIdx)
  if true == PaGlobal_LifeRanking_All._serverChange then
    for idx = 0, PaGlobal_LifeRanking_All._MAX_RANKTYPE_COUNT - 1 do
      PaGlobal_LifeRanking_All._listUpdate[idx] = false
    end
    ToClient_RequestMyLifeRankRefresh()
  else
    _AudioPostEvent_SystemUiForXBOX(1, 30)
    PaGlobal_LifeRanking_All:update()
    if false == Panel_LifeRanking_All:GetShow() then
      PaGlobal_LifeRanking_All:open()
    end
  end
end
function PaGlobal_LifeRanking_All:open()
  if nil == Panel_LifeRanking_All then
    return
  end
  Panel_LifeRanking_All:SetShow(true)
end
function PaGlobal_LifeRanking_All:prepareClose()
  if nil == Panel_LifeRanking_All then
    return
  end
  _AudioPostEvent_SystemUiForXBOX(1, 30)
  PaGlobal_LifeRanking_All:close()
end
function PaGlobal_LifeRanking_All:close()
  if nil == Panel_LifeRanking_All then
    return
  end
  Panel_LifeRanking_All:SetShow(false)
end
function PaGlobal_LifeRanking_All:update()
  if nil == Panel_LifeRanking_All then
    return
  end
  PaGlobal_LifeRanking_All:updateCurrentTab()
  PaGlobal_LifeRanking_All:updateCurrentGrade()
  if true == PaGlobal_LifeRanking_All._serverChange then
    PaGlobal_LifeRanking_All:MyLifeRankingText_Refresh()
    PaGlobal_LifeRanking_All._serverChange = false
  end
end
function PaGlobal_LifeRanking_All:alignTabIcons()
  if nil == Panel_LifeRanking_All then
    return
  end
  local maxSizeX = PaGlobal_LifeRanking_All._ui.stc_RankingTypeBG:GetSizeX()
  local totalSizeX = 0
  local gapSizeX = 30
  local posX = 0
  for i = 0, PaGlobal_LifeRanking_All._MAX_RANKTYPE_COUNT - 1 do
    if nil ~= PaGlobal_LifeRanking_All._ui.stc_RankingIcons[i] then
      local icon = PaGlobal_LifeRanking_All._ui.stc_RankingIcons[i]
      if true == icon:GetShow() then
        totalSizeX = totalSizeX + icon:GetSizeX()
        if PaGlobal_LifeRanking_All._MAX_RANKTYPE_COUNT - 1 ~= i then
          totalSizeX = totalSizeX + gapSizeX
        end
      end
    end
  end
  posX = (maxSizeX - totalSizeX) / 2
  PaGlobal_LifeRanking_All._ui.stc_KeyGuideLB:SetPosX(posX - PaGlobal_LifeRanking_All._ui.stc_KeyGuideLB:GetSizeX() - gapSizeX)
  for i = 0, PaGlobal_LifeRanking_All._MAX_RANKTYPE_COUNT - 1 do
    if nil ~= PaGlobal_LifeRanking_All._ui.stc_RankingIcons[i] then
      local icon = PaGlobal_LifeRanking_All._ui.stc_RankingIcons[i]
      if true == icon:GetShow() then
        icon:SetPosX(posX)
        posX = posX + gapSizeX + icon:GetSizeX()
      end
    end
  end
  PaGlobal_LifeRanking_All._ui.stc_KeyGuideRB:SetPosX(posX)
end
function PaGlobal_LifeRanking_All:prepareForPlatform()
  if nil == Panel_LifeRanking_All then
    return
  end
  if true == PaGlobal_LifeRanking_All._isPadSnap then
    PaGlobal_LifeRanking_All._ui.btn_Question:SetShow(false)
    PaGlobal_LifeRanking_All._ui.btn_Close:SetShow(false)
    PaGlobalFunc_ConsoleKeyGuide_SetAlign(PaGlobal_LifeRanking_All._keyGuideGroup, PaGlobal_LifeRanking_All._ui.stc_BottomBG, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHT, nil, 30)
    Panel_LifeRanking_All:SetSpanSize(0, -70)
    Panel_LifeRanking_All:ComputePos()
  else
    PaGlobal_LifeRanking_All._ui.stc_BottomBG:SetShow(false)
    PaGlobal_LifeRanking_All._ui.stc_KeyGuideLB:SetShow(false)
    PaGlobal_LifeRanking_All._ui.stc_KeyGuideRB:SetShow(false)
  end
end
function PaGlobal_LifeRanking_All:updateCurrentTab()
  if nil == Panel_LifeRanking_All then
    return
  end
  if PaGlobal_LifeRanking_All._selectedTabIdx <= self._eType._TEMP5 then
    PaGlobal_LifeRanking_All._listCount = ToClient_GetLifeRankerCount()
    PaGlobal_LifeRanking_All._ui.txt_RankTitle:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_LIFERANKING_RANKTITLE_LIFELEVEL"))
  elseif self._eType._WEALTH == PaGlobal_LifeRanking_All._selectedTabIdx then
    PaGlobal_LifeRanking_All._listCount = ToClient_GetContentsRankCount(1)
    PaGlobal_LifeRanking_All._ui.txt_RankTitle:SetText("")
  elseif self._eType._COMBAT == PaGlobal_LifeRanking_All._selectedTabIdx then
    PaGlobal_LifeRanking_All._listCount = ToClient_GetContentsRankCount(0)
    PaGlobal_LifeRanking_All._ui.txt_RankTitle:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_LIFERANKING_RANKTITLE_LEVEL"))
  elseif self._eType._LOCALWAR == PaGlobal_LifeRanking_All._selectedTabIdx then
    PaGlobal_LifeRanking_All._listCount = ToClient_GetContentsRankCount(2)
    PaGlobal_LifeRanking_All._ui.txt_RankTitle:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_LIFERANKING_RANKTITLE_SCORE"))
  elseif self._eType._PVP == PaGlobal_LifeRanking_All._selectedTabIdx then
    PaGlobal_LifeRanking_All._listCount = math.max(ToClient_GetMatchRankerCount(1), 1)
  end
  PaGlobal_LifeRanking_All._rankerData = {}
  PaGlobal_LifeRanking_All._ui.list2_Ranking:getElementManager():clearKey()
  for listIdx = 0, PaGlobal_LifeRanking_All._listCount do
    local lifeRanker = PaGlobal_LifeRanking_All:GetLifeRankerAt(listIdx)
    if nil ~= lifeRanker then
      local lifeRankerLv = PaGlobal_LifeRanking_All:GetLifeRankerLv(lifeRanker, PaGlobal_LifeRanking_All._selectedTabIdx)
      if 0 == lifeRankerLv then
        break
      end
      PaGlobal_LifeRanking_All._ui.list2_Ranking:getElementManager():pushKey(toInt64(0, listIdx))
    end
  end
  if true == PaGlobal_LifeRanking_All._isPadSnap then
    ToClient_padSnapResetControl()
    PaGlobal_LifeRanking_All._currentTooltipIndex = nil
  end
end
function PaGlobal_LifeRanking_All:updateCurrentGrade()
  if nil == Panel_LifeRanking_All then
    return
  end
  local myLifeRanker = PaGlobal_LifeRanking_All:GetMyLifeRank(PaGlobal_LifeRanking_All._selectedTabIdx)
  local serverUserCnt = PaGlobal_LifeRanking_All:GetUserCount(PaGlobal_LifeRanking_All._selectedTabIdx)
  local myLifeRankerRate = tonumber(myLifeRanker * 100 / serverUserCnt)
  local myLifeRankGroup
  local lifeType = PaGlobal_LifeRanking_All._tabName[PaGlobal_LifeRanking_All._selectedTabIdx]
  local lifeRankerLv = PaGlobal_LifeRanking_All:CheckMyLifeLv(PaGlobal_LifeRanking_All._selectedTabIdx)
  local lifeGrade
  if myLifeRanker <= 30 and 0 < lifeRankerLv then
    if 12 == PaGlobal_LifeRanking_All._selectedTabIdx then
      myLifeRankGroup = PAGetStringParam3(Defines.StringSheet_GAME, "LUA_LIFERANKING_MYRANKING2_LOCALWAR", "lifeType", lifeType, "myLifeRanker", myLifeRanker, "point", lifeRankerLv)
      PaGlobal_LifeRanking_All._ui.txt_CurRankingGradeValue:SetText(lifeRankerLv)
    else
      myLifeRankGroup = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_LIFERANKING_MYRANKING2", "lifeType", lifeType, "myLifeRanker", myLifeRanker)
      PaGlobal_LifeRanking_All._ui.txt_CurRankingGradeValue:SetText(myLifeRanker)
    end
    PaGlobal_LifeRanking_All._ui.stc_GradeBarArrow:SetShow(false)
    if 1 == myLifeRanker then
      PaGlobal_LifeRanking_All._ui.txt_CurRankingGradeValue:SetFontColor(PaGlobal_LifeRanking_All._rankFontColor[myLifeRanker - 1])
    elseif 2 == myLifeRanker then
      PaGlobal_LifeRanking_All._ui.txt_CurRankingGradeValue:SetFontColor(PaGlobal_LifeRanking_All._rankFontColor[myLifeRanker - 1])
    elseif 3 == myLifeRanker then
      PaGlobal_LifeRanking_All._ui.txt_CurRankingGradeValue:SetFontColor(PaGlobal_LifeRanking_All._rankFontColor[myLifeRanker - 1])
    else
      PaGlobal_LifeRanking_All._ui.txt_CurRankingGradeValue:SetFontColor(PaGlobal_LifeRanking_All._defaultFontColor)
    end
  elseif 0 == lifeRankerLv then
    myLifeRankGroup = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_RALLYRANKING_MYRANK_NOPOINT", "rallyType", lifeType)
    PaGlobal_LifeRanking_All._ui.stc_GradeBarArrow:SetShow(false)
    PaGlobal_LifeRanking_All._ui.txt_CurRankingGradeValue:SetText("-")
    PaGlobal_LifeRanking_All._ui.txt_CurRankingGradeValue:SetFontColor(PaGlobal_LifeRanking_All._defaultFontColor)
  else
    if 0 <= myLifeRankerRate and myLifeRankerRate <= 20 then
      lifeGrade = self._lifeGradeString[0]
    elseif 20 < myLifeRankerRate and myLifeRankerRate <= 40 then
      lifeGrade = self._lifeGradeString[1]
    elseif 40 < myLifeRankerRate and myLifeRankerRate <= 60 then
      lifeGrade = self._lifeGradeString[2]
    elseif 60 < myLifeRankerRate and myLifeRankerRate <= 80 then
      lifeGrade = self._lifeGradeString[3]
    elseif 80 < myLifeRankerRate and myLifeRankerRate <= 100 then
      lifeGrade = self._lifeGradeString[4]
    end
    myLifeRankGroup = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_LIFERANKING_GRADETYPE", "lifeType", lifeType, "lifeGrade", tostring(lifeGrade))
    PaGlobal_LifeRanking_All._ui.txt_CurRankingGradeValue:SetText(lifeGrade)
    PaGlobal_LifeRanking_All._ui.txt_CurRankingGradeValue:SetFontColor(PaGlobal_LifeRanking_All._gradeFontColor[lifeGrade])
    PaGlobal_LifeRanking_All._ui.stc_GradeBarArrow:SetShow(true)
    PaGlobal_LifeRanking_All:setGradeArrowPos(myLifeRankerRate)
  end
  PaGlobal_LifeRanking_All._ui.txt_CurRankingType:SetText(lifeType)
  PaGlobal_LifeRanking_All._ui.txt_CurRankingDesc:SetText(myLifeRankGroup)
end
function PaGlobal_LifeRanking_All:setGradeArrowPos(rate)
  if nil == Panel_LifeRanking_All then
    return
  end
  if nil == rate then
    PaGlobal_LifeRanking_All._ui.stc_GradeBarArrow:SetShow(false)
  end
  local range = PaGlobal_LifeRanking_All._ui.stc_GradeBar:GetSizeX()
  local posX = range * rate / 100 - PaGlobal_LifeRanking_All._ui.stc_GradeBarArrow:GetSizeX() / 2
  PaGlobal_LifeRanking_All._ui.stc_GradeBarArrow:SetPosX(posX)
end
function PaGlobal_LifeRanking_All:MyLifeRankingText_Refresh()
  if nil == Panel_LifeRanking_All then
    return
  end
  for tab = 0, PaGlobal_LifeRanking_All._MAX_RANKTYPE_COUNT - 1 do
    if nil ~= PaGlobal_LifeRanking_All._ui.stc_RankingIcons[tab] and self._rankContentsOption[tab] then
      local typeName = PaGlobal_LifeRanking_All._rankTypeName[tab]
      if nil ~= typeName and "" ~= typeName then
        if self._eType._PVP == tab or self._eType._LOCALWAR == tab then
          local lifeRankerLvTmp = PaGlobal_LifeRanking_All:CheckMyLifeLv(tab)
          if lifeRankerLvTmp == 0 then
            PaGlobal_LifeRanking_All._ui.txt_MyRanking_Value[tab]:SetText("-")
            return
          end
        end
        local myLifeRanking = PaGlobal_LifeRanking_All:GetMyLifeRank(tab)
        if myLifeRanking <= 30 then
          if PaGlobal_LifeRanking_All._isConsole then
            PaGlobal_LifeRanking_All._ui.txt_MyRanking_Value[tab]:SetText(myLifeRanking)
          else
            PaGlobal_LifeRanking_All._ui.txt_MyRanking_Value[tab]:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_LIFERANKING_RANK", "listIdx", myLifeRanking))
          end
          if 3 < myLifeRanking then
            PaGlobal_LifeRanking_All._ui.txt_MyRanking_Value[tab]:SetFontColor(PaGlobal_LifeRanking_All._defaultFontColor)
          elseif 1 == myLifeRanking then
            PaGlobal_LifeRanking_All._ui.txt_MyRanking_Value[tab]:SetFontColor(PaGlobal_LifeRanking_All._rankFontColor[myLifeRanking - 1])
          elseif 2 == myLifeRanking then
            PaGlobal_LifeRanking_All._ui.txt_MyRanking_Value[tab]:SetFontColor(PaGlobal_LifeRanking_All._rankFontColor[myLifeRanking - 1])
          elseif 3 == myLifeRanking then
            PaGlobal_LifeRanking_All._ui.txt_MyRanking_Value[tab]:SetFontColor(PaGlobal_LifeRanking_All._rankFontColor[myLifeRanking - 1])
          else
            PaGlobal_LifeRanking_All._ui.txt_MyRanking_Value[tab]:SetFontColor(PaGlobal_LifeRanking_All._defaultFontColor)
            PaGlobal_LifeRanking_All._ui.txt_MyRanking_Value[tab]:SetText("-")
          end
        else
          local serverUserCnt = PaGlobal_LifeRanking_All:GetUserCount(tab)
          local myLifeRankerRate = tonumber(myLifeRanking * 100 / serverUserCnt)
          local gradeText = ""
          if 0 <= myLifeRankerRate and myLifeRankerRate <= 20 then
            gradeText = self._lifeGradeString[0]
          elseif 20 < myLifeRankerRate and myLifeRankerRate <= 40 then
            gradeText = self._lifeGradeString[1]
          elseif 40 < myLifeRankerRate and myLifeRankerRate <= 60 then
            gradeText = self._lifeGradeString[2]
          elseif 60 < myLifeRankerRate and myLifeRankerRate <= 80 then
            gradeText = self._lifeGradeString[3]
          elseif 80 < myLifeRankerRate and myLifeRankerRate <= 100 then
            gradeText = self._lifeGradeString[4]
          end
          PaGlobal_LifeRanking_All._ui.txt_MyRanking_Value[tab]:SetText(gradeText)
          PaGlobal_LifeRanking_All._ui.txt_MyRanking_Value[tab]:SetFontColor(PaGlobal_LifeRanking_All._gradeFontColor[gradeText])
        end
      end
    end
  end
end
function PaGlobal_LifeRanking_All:LevelFlotFunc(lifeRankerWrp)
  if nil == Panel_LifeRanking_All or nil == lifeRankerWrp then
    return
  end
  local _const = Defines.s64_const
  local rate = 0
  local rateDisplay = 0
  local s64_needExp = lifeRankerWrp:getNeedExp_s64()
  local s64_exp = lifeRankerWrp:getExperience_s64()
  if s64_needExp > _const.s64_10000 then
    rate = Int64toInt32(s64_exp / (s64_needExp / _const.s64_100))
  elseif _const.s64_0 ~= s64_needExp then
    rate = Int64toInt32(s64_exp * _const.s64_100 / s64_needExp)
  end
  if rate < 10 then
    rateDisplay = ".0" .. rate
  else
    rateDisplay = "." .. rate
  end
  return rateDisplay
end
function PaGlobal_LifeRanking_All:RequestLifeRank(tab)
  if nil == Panel_LifeRanking_All then
    return
  end
  if tab <= self._eType._TEMP5 then
    ToClient_RequestLifeRanker(tab)
  elseif self._eType._WEALTH == tab then
    ToClient_RequestContentsRank(1)
  elseif self._eType._COMBAT == tab then
    ToClient_RequestContentsRank(0)
  elseif self._eType._LOCALWAR == tab then
    ToClient_RequestContentsRank(2)
  elseif self._eType._PVP == tab then
    ToClient_RequestMatchRanker(0)
  end
end
function PaGlobal_LifeRanking_All:GetMyLifeRank(tab)
  if nil == Panel_LifeRanking_All then
    return
  end
  local myRank = 0
  if tab <= self._eType._TEMP5 then
    myRank = ToClient_GetLifeMyRank_Param(tab)
  elseif self._eType._WEALTH == tab then
    myRank = ToClient_GetContentsMyRank(1)
  elseif self._eType._COMBAT == tab then
    myRank = ToClient_GetContentsMyRank(0)
  elseif self._eType._LOCALWAR == tab then
    myRank = ToClient_GetContentsMyRank(2)
  elseif self._eType._PVP == tab then
    myRank = ToClient_GetMyMatchRank(0)
  end
  return myRank
end
function PaGlobal_LifeRanking_All:GetUserCount(tab)
  if nil == Panel_LifeRanking_All then
    return
  end
  local userCount = 0
  if tab <= self._eType._TEMP5 then
    userCount = ToClient_GetLifeRankerUserCount()
  elseif self._eType._WEALTH == tab then
    userCount = ToClient_GetContentsRankUserCount(1)
  elseif self._eType._COMBAT == tab then
    userCount = ToClient_GetContentsRankUserCount(0)
  elseif self._eType._LOCALWAR == tab then
    userCount = ToClient_GetContentsRankUserCount(2)
  elseif self._eType._PVP == tab then
    userCount = ToClient_GetMatchRankerUserCount(0)
  end
  return userCount
end
function PaGlobal_LifeRanking_All:GetLifeRankerAt(listIdx)
  if nil == Panel_LifeRanking_All then
    return
  end
  local lifeRanker
  if PaGlobal_LifeRanking_All._selectedTabIdx <= self._eType._TEMP5 then
    lifeRanker = ToClient_GetLifeRankerAt(listIdx)
  elseif self._eType._WEALTH == PaGlobal_LifeRanking_All._selectedTabIdx then
    lifeRanker = ToClient_GetMoneyRankAt(listIdx)
  elseif self._eType._COMBAT == PaGlobal_LifeRanking_All._selectedTabIdx then
    lifeRanker = ToClient_GetBattleRankAt(listIdx)
  elseif self._eType._LOCALWAR == PaGlobal_LifeRanking_All._selectedTabIdx then
    lifeRanker = ToClient_GetLocalWarRankAt(listIdx)
  elseif self._eType._PVP == PaGlobal_LifeRanking_All._selectedTabIdx then
    lifeRanker = ToClient_GetMatchRankerAt(0, listIdx)
  end
  return lifeRanker
end
function PaGlobal_LifeRanking_All:GetLifeRankerLv(lifeRanker, tab)
  if nil == Panel_LifeRanking_All then
    return
  end
  local lifeRankerLv = 0
  if self._eType._PVP == tab then
    lifeRankerLv = lifeRanker:getMatchPoint()
  elseif self._eType._LOCALWAR == tab then
    lifeRankerLv = lifeRanker:getAccumulatedKillCount()
  else
    lifeRankerLv = lifeRanker:getLevel()
  end
  return lifeRankerLv
end
function PaGlobal_LifeRanking_All:CheckMyLifeLv(tab)
  if nil == Panel_LifeRanking_All then
    return
  end
  local lifeRankerLv = 0
  if self._eType._LOCALWAR == tab then
    lifeRankerLv = ToClient_GetMyAccumulatedKillCount()
  elseif self._eType._PVP == tab then
    lifeRankerLv = ToClient_GetMyMatchPoint(0)
  else
    lifeRankerLv = 1
  end
  return lifeRankerLv
end
function PaGlobal_LifeRanking_All:moveTabIndex(value)
  if nil == Panel_LifeRanking_All then
    return
  end
  local prevIndex = PaGlobal_LifeRanking_All._selectedTabIdx
  for i = 0, self._MAX_RANKTYPE_COUNT do
    PaGlobal_LifeRanking_All._selectedTabIdx = PaGlobal_LifeRanking_All._selectedTabIdx + value
    if PaGlobal_LifeRanking_All._selectedTabIdx < 0 then
      PaGlobal_LifeRanking_All._selectedTabIdx = self._rightShowRankType
    elseif self._rightShowRankType < PaGlobal_LifeRanking_All._selectedTabIdx then
      PaGlobal_LifeRanking_All._selectedTabIdx = 0
    end
    if self._rankContentsOption[PaGlobal_LifeRanking_All._selectedTabIdx] then
      break
    end
  end
  if nil ~= prevIndex then
    local prevIcon = PaGlobal_LifeRanking_All._ui.stc_RankingIcons[prevIndex]
    if nil ~= prevIcon then
      prevIcon:setRenderTexture(prevIcon:getBaseTexture())
    end
  end
  PaGlobal_LifeRanking_All:setTabTo(PaGlobal_LifeRanking_All._selectedTabIdx)
end
function PaGlobal_LifeRanking_All:setTabTo(idx)
  if nil == Panel_LifeRanking_All then
    return
  end
  if nil ~= PaGlobal_LifeRanking_All._ui.stc_RankingIcons[idx] then
    PaGlobal_LifeRanking_All._selectedTabIdx = idx
    if idx <= self._eType._TEMP5 then
      ToClient_SetLifeRankType(idx)
    end
    if PaGlobal_LifeRanking_All._serverChange == true then
      for idx = 0, PaGlobal_LifeRanking_All._MAX_RANKTYPE_COUNT - 1 do
        if nil ~= PaGlobal_LifeRanking_All._listUpdate[idx] then
          PaGlobal_LifeRanking_All._listUpdate[idx] = false
        end
      end
      ToClient_RequestMyLifeRankRefresh()
    elseif false == PaGlobal_LifeRanking_All._listUpdate[idx] then
      PaGlobal_LifeRanking_All:RequestLifeRank(idx)
      PaGlobal_LifeRanking_All._listUpdate[idx] = true
    else
      PaGlobal_LifeRanking_All:update()
    end
    local curIcon = PaGlobal_LifeRanking_All._ui.stc_RankingIcons[idx]
    curIcon:setRenderTexture(curIcon:getOnTexture())
    local tabTitle = PaGlobal_LifeRanking_All._ui.txt_CurRankingTypeTitle
    tabTitle:SetText(PaGlobal_LifeRanking_All._tabName[idx])
    tabTitle:SetSize(tabTitle:GetTextSizeX())
    tabTitle:SetPosX(curIcon:GetPosX() + curIcon:GetSizeX() / 2 - tabTitle:GetSizeX() / 2)
    local textPadding = 20
    tabTitle:SetPosY(curIcon:GetPosY() + (curIcon:GetSizeY() + textPadding))
  end
end
function PaGlobal_LifeRanking_All:setRankIcon(control, rank)
  if nil == Panel_LifeRanking_All or nil == control or nil == rank then
    return
  end
  control:ChangeTextureInfoName("renewal/etc/console_etc_ranking.dds")
  local texUV = PaGlobal_LifeRanking_All._rankIconTextureUV[rank]
  local x1, y1, x2, y2 = setTextureUV_Func(control, texUV._x1, texUV._y1, texUV._x2, texUV._y2)
  control:getBaseTexture():setUV(x1, y1, x2, y2)
  control:setRenderTexture(control:getBaseTexture())
end
function PaGlobal_LifeRanking_All:validate()
  if nil == Panel_LifeRanking_All then
    return
  end
  for _, control in pairs(PaGlobal_LifeRanking_All._ui) do
    control:isValidate()
  end
end
function PaGlobal_LifeRanking_All:RankerWhisper(listIdx)
  if nil == Panel_LifeRanking_All then
    return
  end
  local lifeRanker
  lifeRanker = PaGlobal_LifeRanking_All:GetLifeRankerAt(listIdx)
  if nil == lifeRanker then
    return
  end
  local lifeRankerCharName = lifeRanker:getCharacterName()
  if true == PaGlobal_LifeRanking_All._isConsole then
    PaGlobalFunc_ChattingHistory_Open(CppEnums.ChatType.Private)
    PaGlobalFunc_ChattingInfo_Open()
    PaGlobalFunc_ChattingInfo_DirectWhisperToNick(lifeRankerCharName)
  else
    FGlobal_ChattingInput_ShowWhisper(lifeRankerCharName)
  end
end
function PaGlobal_LifeRanking_All:TooltipHide()
  if nil == Panel_LifeRanking_All then
    return
  end
  PaGlobal_LifeRanking_All._currentTooltipIndex = nil
  PaGlobal_LifeRanking_All._ui.tooltipBG:SetShow(false)
  PaGlobal_LifeRanking_All._ui.tooltipName:SetShow(false)
  PaGlobal_LifeRanking_All._ui.tooltipDesc:SetShow(false)
  TooltipSimple_Hide()
end
function PaGlobal_LifeRanking_All:TooltipShow(uiControl, name, desc, index)
  if nil == Panel_LifeRanking_All then
    return
  end
  PaGlobal_LifeRanking_All._ui.tooltipBG:SetShow(true)
  PaGlobal_LifeRanking_All._ui.tooltipName:SetShow(true)
  PaGlobal_LifeRanking_All._ui.tooltipDesc:SetShow(true)
  PaGlobal_LifeRanking_All._ui.tooltipName:SetText(name .. PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_RECRUITMENT_PLAYERINTRO"))
  PaGlobal_LifeRanking_All._ui.tooltipDesc:SetText(desc)
  local sizeX = PaGlobal_LifeRanking_All._ui.tooltipBG:GetSizeX()
  local sizeY = PaGlobal_LifeRanking_All._ui.tooltipDesc:GetTextSizeY() + PaGlobal_LifeRanking_All._ui.tooltipDesc:GetPosY() + 20
  PaGlobal_LifeRanking_All._ui.tooltipBG:SetSize(sizeX, sizeY)
  PaGlobal_LifeRanking_All._ui.tooltipDesc:ComputePos()
  local posX = uiControl:GetPosX() + PaGlobal_LifeRanking_All._ui.list2_Ranking:GetPosX() + 40
  local posY = uiControl:GetPosY() + PaGlobal_LifeRanking_All._ui.list2_Ranking:GetPosY() + 40
  PaGlobal_LifeRanking_All._ui.tooltipBG:SetPosX(posX)
  PaGlobal_LifeRanking_All._ui.tooltipBG:SetPosY(posY)
end
function PaGlobal_LifeRanking_All:NameTooltip(index)
  if nil == Panel_LifeRanking_All then
    return
  end
  if nil == index then
    PaGlobal_LifeRanking_All._currentTooltipIndex = nil
    TooltipSimple_Hide()
    return
  end
  local uiControl = PaGlobal_LifeRanking_All._ui.list2_Ranking:GetContentByKey(toInt64(0, index))
  if nil == uiControl then
    PaGlobal_LifeRanking_All._currentTooltipIndex = nil
    TooltipSimple_Hide()
    return
  end
  local nameText = UI.getChildControl(uiControl, "StaticText_CharacterName")
  if false == nameText:IsLimitText() then
    TooltipSimple_Hide()
    return
  end
  PaGlobal_LifeRanking_All._currentTooltipIndex = index
  local desc = ""
  if PaGlobal_LifeRanking_All._isFamilyNameShow then
    desc = PaGlobal_LifeRanking_All._rankerData[index]._name .. "(" .. PaGlobal_LifeRanking_All._rankerData[index]._gamerTag .. ")"
  else
    desc = PaGlobal_LifeRanking_All._rankerData[index]._charName .. "(" .. PaGlobal_LifeRanking_All._rankerData[index]._gamerTag .. ")"
  end
  TooltipSimple_Show(nameText, desc)
end
function PaGlobal_LifeRanking_All:Tooltip(index)
  if nil == Panel_LifeRanking_All then
    return
  end
  if PaGlobal_LifeRanking_All._isConsole and true == PaGlobal_LifeRanking_All._ui.tooltipBG:GetShow() then
    PaGlobal_LifeRanking_All._ui.tooltipBG:SetShow(false)
    return
  end
  if nil == index then
    PaGlobal_LifeRanking_All:TooltipHide()
    return
  end
  local uiControl = PaGlobal_LifeRanking_All._ui.list2_Ranking:GetContentByKey(toInt64(0, index))
  local name = PaGlobal_LifeRanking_All._rankerData[index]._name
  local desc = PaGlobal_LifeRanking_All._rankerData[index]._desc
  if nil == desc or "" == desc then
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_RECRUITMENT_PLAYERINTRO_NODATA")
  end
  PaGlobal_LifeRanking_All:TooltipShow(uiControl, name, desc, index)
end
function PaGlobal_LifeRanking_All:setCrossPlayIcon(targetControl, platformType, nameControl)
  targetControl:SetShow(false)
  if nil == platformType then
    return
  end
  if true == _ContentsGroup_ConsoleIntegration then
    targetControl:SetPosX(nameControl:GetPosX() + nameControl:GetTextSizeX() + 5)
    targetControl:SetShow(true)
    local selfPlayerPlatform = ToClient_getGamePlatformType()
    if selfPlayerPlatform == platformType then
      if __eGAME_PLATFORM_TYPE_PS == selfPlayerPlatform then
        targetControl:ChangeTextureInfoName("combine/commonicon/crossplay_icon_ps.dds")
      elseif __eGAME_PLATFORM_TYPE_XB == selfPlayerPlatform then
        targetControl:ChangeTextureInfoName("combine/commonicon/crossplay_icon_xb.dds")
      end
    else
      targetControl:ChangeTextureInfoName("combine/commonicon/crossplay_icon_other.dds")
    end
  end
end
function PaGlobal_LifeRanking_All_CreateRankingList(control, listIdx64)
  local listIdx = Int64toInt32(listIdx64)
  local lifeRanker = PaGlobal_LifeRanking_All:GetLifeRankerAt(listIdx)
  if nil == lifeRanker then
    control:SetShow(false)
    return
  end
  local rankText = UI.getChildControl(control, "StaticText_Rank_Value")
  local nameText = UI.getChildControl(control, "StaticText_CharacterName")
  local guildText = UI.getChildControl(control, "StaticText_GuildName")
  local gradeText = UI.getChildControl(control, "StaticText_Grade_Value")
  local rankIcon = UI.getChildControl(control, "Static_RankIcon")
  local button = UI.getChildControl(control, "Static_BG")
  local platformIcon = UI.getChildControl(control, "Static_PlatformIcon")
  button:setNotImpactScrollEvent(true)
  local lifeRankerLv = PaGlobal_LifeRanking_All:GetLifeRankerLv(lifeRanker, PaGlobal_LifeRanking_All._selectedTabIdx)
  local lifeRankerName = lifeRanker:getUserName()
  local lifeRankerCharName = lifeRanker:getCharacterName()
  local lifeRankerGuild = lifeRanker:getGuildName()
  local lifeRankerIntroDesc = lifeRanker:getUserIntroduction()
  local lifeRankerGamerTag = lifeRanker:getGamerTag()
  local lifeRankerPlatformType = lifeRanker:getPlatformType()
  local selfPlayerPlatform = ToClient_getGamePlatformType()
  if selfPlayerPlatform ~= lifeRankerPlatformType then
    lifeRankerGamerTag = "-"
  end
  if listIdx <= 2 then
    rankIcon:SetShow(true)
    PaGlobal_LifeRanking_All:setRankIcon(rankIcon, listIdx)
    rankText:SetFontColor(PaGlobal_LifeRanking_All._rankFontColor[listIdx])
    nameText:SetFontColor(PaGlobal_LifeRanking_All._rankFontColor[listIdx])
    guildText:SetFontColor(PaGlobal_LifeRanking_All._rankFontColor[listIdx])
    gradeText:SetFontColor(PaGlobal_LifeRanking_All._rankFontColor[listIdx])
  else
    rankIcon:SetShow(false)
    rankText:SetFontColor(PaGlobal_LifeRanking_All._defaultFontColor)
    nameText:SetFontColor(PaGlobal_LifeRanking_All._defaultFontColor)
    guildText:SetFontColor(PaGlobal_LifeRanking_All._defaultFontColor)
    gradeText:SetFontColor(PaGlobal_LifeRanking_All._defaultFontColor)
  end
  if 0 == lifeRankerLv then
    return false
  end
  PaGlobal_LifeRanking_All._rankerData[listIdx] = {}
  PaGlobal_LifeRanking_All._rankerData[listIdx]._name = lifeRankerName
  PaGlobal_LifeRanking_All._rankerData[listIdx]._charName = lifeRankerCharName
  PaGlobal_LifeRanking_All._rankerData[listIdx]._desc = lifeRankerIntroDesc
  PaGlobal_LifeRanking_All._rankerData[listIdx]._gamerTag = lifeRankerGamerTag
  rankText:SetShow(true)
  nameText:SetShow(true)
  guildText:SetShow(true)
  gradeText:SetShow(true)
  nameText:SetTextMode(__eTextMode_LimitText)
  if PaGlobal_LifeRanking_All._isConsole then
    rankText:SetText(listIdx + 1)
    if PaGlobal_LifeRanking_All._isFamilyNameShow then
      nameText:SetText(lifeRankerName .. "(" .. lifeRankerGamerTag .. ")")
    else
      nameText:SetText(lifeRankerCharName .. "(" .. lifeRankerGamerTag .. ")")
    end
  else
    rankText:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_LIFERANKING_RANK", "listIdx", listIdx + 1))
    nameText:SetText(lifeRankerName .. "(" .. lifeRankerCharName .. ")")
  end
  guildText:SetText(lifeRankerGuild)
  if PaGlobal_LifeRanking_All._selectedTabIdx <= PaGlobal_LifeRanking_All._eType._TEMP5 then
    gradeText:SetText(PaGlobalFunc_Util_CraftLevelReplace(lifeRankerLv))
  elseif PaGlobal_LifeRanking_All._eType._WEALTH == PaGlobal_LifeRanking_All._selectedTabIdx then
    gradeText:SetShow(false)
  elseif PaGlobal_LifeRanking_All._eType._COMBAT == PaGlobal_LifeRanking_All._selectedTabIdx then
    local levelFlot = PaGlobal_LifeRanking_All:LevelFlotFunc(lifeRanker)
    gradeText:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_LV") .. " " .. tostring(lifeRankerLv) .. tostring(levelFlot))
  elseif PaGlobal_LifeRanking_All._eType._LOCALWAR == PaGlobal_LifeRanking_All._selectedTabIdx then
    gradeText:SetText(lifeRankerLv)
  elseif PaGlobal_LifeRanking_All._eType._PVP == PaGlobal_LifeRanking_All._selectedTabIdx then
    gradeText:SetText(lifeRankerLv)
  end
  button:addInputEvent("Mouse_LUp", "PaGlobal_LifeRanking_All:RankerWhisper( " .. listIdx .. " )")
  if false == PaGlobal_LifeRanking_All._isPadSnap then
    button:addInputEvent("Mouse_On", "PaGlobal_LifeRanking_All:Tooltip( " .. listIdx .. ")")
    button:addInputEvent("Mouse_Out", "PaGlobal_LifeRanking_All:Tooltip()")
  else
    control:registerPadEvent(__eConsoleUIPadEvent_Up_X, "PaGlobal_LifeRanking_All:Tooltip( " .. listIdx .. ")")
    control:addInputEvent("Mouse_On", "PaGlobal_LifeRanking_All:NameTooltip( " .. listIdx .. ")")
    control:addInputEvent("Mouse_Out", "PaGlobal_LifeRanking_All:TooltipHide()")
  end
  if _ContentsGroup_isXBOXUI then
    control:registerPadEvent(__eConsoleUIPadEvent_LT, "HandleEvent_LifeRanking_ShowXboxProfile(" .. listIdx .. ")")
  end
  platformIcon:SetShow(false)
  if true == ToClient_isTotalGameClient() then
    PaGlobal_LifeRanking_All:setCrossPlayIcon(platformIcon, lifeRankerPlatformType, nameText)
  end
end
local rankingTabId = {
  tab_Gathering = 0,
  tab_Fishing = 1,
  tab_Hunting = 2,
  tab_Cook = 3,
  tab_Alchemy = 4,
  tab_Manufacture = 5,
  tab_Mating = 6,
  tab_Trade = 7,
  tab_Growth = 8,
  tab_Sail = 9,
  tab_Wealth = 10,
  tab_Combat = 11,
  tab_LocalWar = 12,
  tab_Rally = 13,
  tab_Barter = 14
}
function FGlobal_LifeRanking_CheckEnAble(rankType)
  local self = rankingTabId
  local returnValue = true
  if self.tab_Hunting == rankType then
    if ToClient_IsContentsGroupOpen("28") then
      returnValue = true
    else
      returnValue = false
    end
  elseif self.tab_Rally == rankType then
    if ToClient_IsContentsGroupOpen("38") then
      returnValue = true
    else
      returnValue = false
    end
  elseif self.tab_LocalWar == rankType then
    if ToClient_IsContentsGroupOpen("43") then
      returnValue = true
    else
      returnValue = false
    end
  elseif self.tab_Sail == rankType then
    if ToClient_IsContentsGroupOpen("83") then
      returnValue = true
    else
      returnValue = false
    end
  elseif self.tab_Barter == rankType then
    returnValue = _ContentsGroup_Barter
  end
  return returnValue
end
