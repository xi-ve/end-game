function PaGlobalFunc_CharacterTag_All_Open()
  PaGlobal_CharacterTag_All:prepareOpen()
end
function PaGlobalFunc_CharacterTag_All_Close()
  PaGlobal_CharacterTag_All:prepareClose()
end
function PaGlobalFunc_CharacterTag_All_IsTagChange()
  local retBool = PaGlobal_CharacterTag_All._doTag
  if true == PaGlobal_CharacterTag_All._doTag then
    PaGlobal_CharacterTag_All._doTag = false
  end
  return retBool
end
function PaGlobalFunc_CharacterTag_All_DeleteTagCharacter(characterKey)
  ToClient_RequestDeleteDuelCharacter(characterKey)
end
function PaGlobalFunc_CharacterTag_All_RequestTagCharacter(characterKey)
  ToClient_RequestDuelCharacter(characterKey)
end
function PaGlobalFunc_CharacterTag_All_Change()
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  local index = ToClient_GetMyDuelCharacterIndex()
  if PaGlobal_CharacterTag_All.LOCAL_DEFINE.NODUEL == index then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_TAG_CURRENT_NOT_TAGGING"))
    return
  end
  if true == ToClient_getJoinGuildBattle() then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_TAG_CANTDO_GUILDBATTLE"))
    return
  end
  local regionInfo = getRegionInfoByPosition(selfPlayer:get():getPosition())
  if true == regionInfo:isPrison() then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_CHARACTERTAG_PRISON_CANT_TAG"))
    return
  end
  PaGlobal_CharacterTag_All._doTag = true
  if true == _ContentsGroup_NewUI_GameExit then
    PaGlobal_GameExit_All_ChangeCharacter(index)
  else
    Panel_GameExit_ChangeCharacter(index)
  end
end
function HandleEventLUp_CharacterTag_All_Close()
  PaGlobalFunc_CharacterTag_All_Close()
end
function HandleEventLUp_CharacterTag_All_PopUpUI()
  if true == PaGlobal_CharacterTag_All._ui_pc.chk_popup:IsCheck() then
    Panel_CharacterTag_All:OpenUISubApp()
  else
    Panel_CharacterTag_All:CloseUISubApp()
  end
  TooltipSimple_Hide()
end
function HandleEventOnOut_CharacterTag_All_PopUpTooltip(isShow)
  if isShow then
    local name = PAGetString(Defines.StringSheet_GAME, "LUA_POPUI_TOOLTIP_NAME")
    local desc = ""
    if PaGlobal_CharacterTag_All._ui_pc.chk_popup:IsCheck() then
      desc = PAGetString(Defines.StringSheet_GAME, "LUA_POPUI_CHECK_TOOLTIP")
    else
      desc = PAGetString(Defines.StringSheet_GAME, "LUA_POPUI_NOCHECK_TOOLTIP")
    end
    TooltipSimple_Show(PaGlobal_CharacterTag_All._ui_pc.chk_popup, name, desc)
  else
    TooltipSimple_Hide()
  end
end
function HandleEventScroll_CharacterTag_All_ScrollEvent(isUp)
  PaGlobal_CharacterTag_All._pageIndex = UIScroll.ScrollEvent(PaGlobal_CharacterTag_All._ui.stc_scrollBg, isUp, 1, math.ceil(PaGlobal_CharacterTag_All._maxCharacterCount / 6), PaGlobal_CharacterTag_All._pageIndex, 1)
  for idx = 0, 5 do
    local targetUI = PaGlobal_CharacterTag_All._ui.characterList[idx]
    local Static_BG = UI.getChildControl(targetUI, "Static_BG")
    if PaGlobal_CharacterTag_All._pageIndex == PaGlobal_CharacterTag_All._sideImg._page and idx == PaGlobal_CharacterTag_All._sideImg._index then
      Static_BG:SetShow(true)
    else
      Static_BG:SetShow(false)
    end
  end
  PaGlobal_CharacterTag_All:loadList()
end
function HandleEventLUp_CharacterTag_All_ClickCharacterList(charIndex)
  local slotNo = PaGlobal_CharacterTag_All.LOCAL_DEFINE.CHARSLOTCOLMAX * PaGlobal_CharacterTag_All._pageIndex
  local charMaxCount = getCharacterDataCount()
  if charIndex < 0 or charIndex > charMaxCount then
    return
  end
  PaGlobal_CharacterTag_All:setRightFace(charIndex)
  PaGlobal_CharacterTag_All._ui.mainImg2.stc_addIcon:SetShow(false)
  local characterData = getCharacterDataByIndex(charIndex)
  PaGlobal_CharacterTag_All._requestCharacterKey = characterData._characterNo_s64
  for idx = 0, 5 do
    local targetUI = PaGlobal_CharacterTag_All._ui.characterList[idx]
    local Static_BG = UI.getChildControl(targetUI, "Static_BG")
    if idx == charIndex - slotNo then
      Static_BG:SetShow(true)
      PaGlobal_CharacterTag_All._sideImg._page = PaGlobal_CharacterTag_All._pageIndex
      PaGlobal_CharacterTag_All._sideImg._index = idx
    else
      Static_BG:SetShow(false)
    end
  end
end
function HandleEventRUp_CharacterTag_All_DeleteTagCharacter()
  PaGlobal_CharacterTag_All._ui.chk_tagState:SetCheck(PaGlobal_CharacterTag_All._currentTagState)
  PaGlobal_CharacterTag_All._ui.chk_tagStateExp:SetCheck(PaGlobal_CharacterTag_All._currentTagState)
  if false == PaGlobal_CharacterTag_All._selfCharTag then
    return
  end
  if PaGlobal_CharacterTag_All.LOCAL_DEFINE.NODUEL == PaGlobal_CharacterTag_All._requestCharacterKey then
    return
  end
  if PaGlobal_CharacterTag_All._currentTagState then
    PaGlobalFunc_CharacterTag_All_DeleteTagCharacter(PaGlobal_CharacterTag_All._requestCharacterKey)
  end
end
function HandleEventLUp_CharacterTag_All_ClickRequestTag()
  PaGlobal_CharacterTag_All._ui.chk_tagState:SetCheck(PaGlobal_CharacterTag_All._currentTagState)
  PaGlobal_CharacterTag_All._ui.chk_tagStateExp:SetCheck(PaGlobal_CharacterTag_All._currentTagState)
  if false == PaGlobal_CharacterTag_All._selfCharTag then
    return
  end
  if PaGlobal_CharacterTag_All.LOCAL_DEFINE.NODUEL == PaGlobal_CharacterTag_All._requestCharacterKey then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_TAG_NEEDSELECTCHARACTER"))
    return
  end
  if PaGlobal_CharacterTag_All._currentTagState then
    PaGlobalFunc_CharacterTag_All_DeleteTagCharacter(PaGlobal_CharacterTag_All._requestCharacterKey)
  else
    PaGlobalFunc_CharacterTag_All_RequestTagCharacter(PaGlobal_CharacterTag_All._requestCharacterKey)
  end
end
function HandleEventLUp_CharacterTag_All_CharacterTagButton()
  local selfPlayer = getSelfPlayer()
  local duelCharIndex = ToClient_GetMyDuelCharacterIndex()
  local selfPlayerChar_No_s64 = selfPlayer:getCharacterNo_64()
  local selfPlayerChar_No_s32 = Int64toInt32(selfPlayerChar_No_s64)
  local characterData = getCharacterDataByIndex(duelCharIndex)
  if nil == characterData then
    return
  end
  local duelChar_No_s64 = characterData._duelCharacterNo
  local duelChar_No_s32 = Int64toInt32(duelChar_No_s64)
  if selfPlayerChar_No_s32 == duelChar_No_s32 then
    ToClient_updateDuelExp()
  else
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_TAKEEXP_WARNING2"))
  end
end
function FromClient_CharacterTag_All_SelfPlayerLevelUp()
  if true == _ContentsGroup_RemasterUI_Main then
    PaGlobalFunc_ServantIcon_UpdateOtherIcon(PaGlobalFunc_ServantIcon_GetTagIndex())
  end
end
function FromClient_CharacterTag_All_SuccessRequest()
  local showModeNum = 0
  local mainCharater = getCharacterDataByIndex(ToClient_GetMyCharacterIndex())
  local subCharacter = getCharacterDataByIndex(ToClient_GetMyDuelCharacterIndex())
  local subCharacterLV = 0
  local expUI_Show = 0
  if nil ~= mainCharater and true == ToClient_isDuelCharacterExpClass(mainCharater) then
    expUI_Show = 1
  end
  if nil ~= subCharacter then
    local subType = getCharacterClassType(subCharacter)
    if true == ToClient_isDuelCharacterExpClass(subType) then
      expUI_Show = 2
    end
    subCharacterLV = subCharacter._level
  end
  PaGlobal_CharacterTag_All:showManager(showModeNum, subCharacterLV)
  PaGlobalFunc_CharacterTag_All_Open()
end
function FromClient_CharacterTag_All_SuccessDelete()
  local showModeNum = 0
  PaGlobal_CharacterTag_All._doTag = false
  PaGlobalFunc_CharacterTag_All_Open()
  if true == ToClient_isDuelCharacterExpClass(getSelfPlayer():getClassType()) then
    showModeNum = 1
  end
  PaGlobal_CharacterTag_All:showManager(showModeNum)
end
function FromClient_CharacterTag_All_NotifyUpdateDuelCharacterExp(result)
  if true == result then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_TAKEEXP_WARNING"))
    return
  else
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_TAG_TAKEEXP_SUCCESS"))
    PaGlobal_CharacterTag_All._ui.btn_takeEXP:SetShow(false)
    PaGlobal_CharacterTag_All._ui.btn_charTAG:SetShow(true)
    PaGlobal_CharacterTag_All._ui.btn_charTAG:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_TAG_DELETEDUEL"))
    if false == _ContentsGroup_AddExpEvent_TagCharacter then
      PaGlobal_CharacterTag_All:showManager(0)
    end
  end
end
function HandleEventLUp_CharacterTag_All_ItemCopy()
  ToClient_CopyMyEquipItems()
end
