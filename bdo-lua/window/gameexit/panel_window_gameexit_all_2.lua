function HandleEventOnOut_GameExit_All_ClassTooltip(isShow, classType, index)
  if not isShow then
    TooltipSimple_Hide()
    return
  end
  local name, desc, control
  name = CppEnums.ClassType2String[classType]
  control = PaGlobal_GameExit_All._basic._txt_levelPool[index]
  TooltipSimple_Show(control, name, desc)
end
function HandleEventOnOut_GameExit_All_SimpleTooltip(isShow, index, tipType, defaultCount, valksCount, familyCount)
  if false == isShow then
    TooltipSimple_Hide()
    return
  end
  local name, desc, control
  if 0 == tipType then
    local isValksItemCheck
    if PaGlobal_GameExit_All._isValksContensOption then
      isValksItemCheck = PAGetStringParam3(Defines.StringSheet_GAME, "LUA_GAMEEXIT_ENCHANTCOUNT_TOOLTIP", "defaultCount", tostring(defaultCount), "valksCount", tostring(valksCount), "familyCount", tostring(familyCount))
    else
      isValksItemCheck = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GAMEEXIT_ENCHANTCOUNT_TOOLTIP_ADDCOUNT_NONE", "defaultCount", tostring(defaultCount))
    end
    name = PAGetString(Defines.StringSheet_GAME, "LUA_GAMEEXIT_NORMALSTACK_TOOLTIP_NAME")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_GAMEEXIT_NORMALSTACK_TOOLTIP_DESC") .. isValksItemCheck
    if PaGlobal_GameExit_All._eType._basic == PaGlobal_GameExit_All._eViewType then
      control = PaGlobal_GameExit_All._basic._txt_enchantFailCountPool[index]
    elseif PaGlobal_GameExit_All._eType._all == PaGlobal_GameExit_All._eViewType then
      control = PaGlobal_GameExit_All._all._txt_enchantFailCountPool[index]
    end
  elseif 1 == tipType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_GAMEEXIT_CHARWP_TITLE")
    desc = PAGetString(Defines.StringSheet_GAME, "MAINSTATUS_DESC_WP")
    if PaGlobal_GameExit_All._eType._basic == PaGlobal_GameExit_All._eViewType then
      control = PaGlobal_GameExit_All._basic._txt_energyPool[index]
    elseif PaGlobal_GameExit_All._eType._all == PaGlobal_GameExit_All._eViewType then
      control = PaGlobal_GameExit_All._all._txt_energyPool[index]
    end
  elseif 2 == tipType then
    name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_GAMEEXIT_TRAYWINDOW")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_GAMEEXIT_TOOLTIP_TRAYFORBLACKDESERT_DESC") .. "\n" .. PAGetString(Defines.StringSheet_GAME, "LUA_SHORTBUTTON_HOWTOUSE_TOOLTIP_DESC")
    control = PaGlobal_GameExit_All._ui._pc._btn_tray
  end
  TooltipSimple_Show(control, name, desc)
end
function HandleEvent_GameExit_All_UpdateSlot(startIdx)
  if true == PaGlobal_GameExit_All._isConsole and true == Panel_Window_SimpleInventory:GetShow() then
    return
  end
  _AudioPostEvent_SystemUiForXBOX(51, 6)
  TooltipSimple_Hide()
  PaGlobal_GameExit_All:updateCharacterSlot(startIdx)
end
function HandleEventLUp_GameExit_All_ChangeAccount()
  local messageBoxMemo = PAGetString(Defines.StringSheet_GAME, "LUA_WARNING_CHANGEACCOUNT_MSGBOX")
  local messageBoxData = {
    title = PAGetString(Defines.StringSheet_GAME, "LUA_WARNING"),
    content = messageBoxMemo,
    functionYes = PaGlobal_GameExit_All_ChangeAccount_MessageBoxConfirm,
    functionNo = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageBoxData, "top")
end
function HandleEventLUp_GameExit_All_Move()
  FGlobal_DeliveryForGameExit_Show(true)
end
function HandleEventOn_GameExit_All_SlotMouseOver(idx)
  if PaGlobal_GameExit_All._prevClickIndex ~= idx and false == PaGlobal_GameExit_All._isConsole then
    PaGlobal_GameExit_All._basic._btn_invenPool[PaGlobal_GameExit_All._prevClickIndex]:SetShow(false)
    PaGlobal_GameExit_All._basic._btn_change_pcPool[PaGlobal_GameExit_All._prevClickIndex]:SetShow(false)
    PaGlobal_GameExit_All._basic._stc_picturePool[PaGlobal_GameExit_All._prevClickIndex]:ResetVertexAni()
    PaGlobal_GameExit_All._basic._stc_picturePool[PaGlobal_GameExit_All._prevClickIndex]:SetAlpha(1)
  end
  if idx ~= PaGlobal_GameExit_All._nowPlayCharaterSlotNo and false == PaGlobal_GameExit_All._isConsole then
    PaGlobal_GameExit_All._basic._btn_invenPool[idx]:SetShow(true)
    local characterData = getCharacterDataByIndex(PaGlobal_GameExit_All._photoIndex + 1 + idx)
    if nil == characterData then
      return
    end
    local isSeasonCharacter = characterData._characterSeasonType == __eCharacterSeasonType_Season
    if true == _ContentsGroup_SeasonContents then
      PaGlobal_GameExit_All._basic._btn_change_pcPool[idx]:SetIgnore(false)
      PaGlobal_GameExit_All._basic._btn_change_pcPool[idx]:SetMonoTone(false, false)
      PaGlobal_GameExit_All._basic._btn_change_pcPool[idx]:SetShow(true)
    else
      local isPreSeasonContent = true == _ContentsGroup_PreSeason and true == isSeasonCharacter
      PaGlobal_GameExit_All._basic._btn_change_pcPool[idx]:SetIgnore(isPreSeasonContent)
      PaGlobal_GameExit_All._basic._btn_change_pcPool[idx]:SetMonoTone(isPreSeasonContent, isPreSeasonContent)
      PaGlobal_GameExit_All._basic._btn_invenPool[idx]:SetIgnore(isPreSeasonContent)
      PaGlobal_GameExit_All._basic._btn_invenPool[idx]:SetMonoTone(isPreSeasonContent, isPreSeasonContent)
      PaGlobal_GameExit_All._basic._btn_change_pcPool[idx]:SetShow(true)
    end
  end
  if true == _ContentsGroup_isConsolePadControl then
    PaGlobal_GameExit_All._basic._stc_picturePool[idx]:addInputEvent("Mouse_LUp", "HandleEventLUp_GameExit_All_ChangeCharacter(" .. idx .. ")")
  end
  PaGlobal_GameExit_All._basic._stc_picturePool[idx]:ResetVertexAni()
  PaGlobal_GameExit_All._basic._stc_picturePool[idx]:SetVertexAniRun("Ani_Color_New", true)
  PaGlobal_GameExit_All._prevClickIndex = idx
end
function HandleEventLDClick_GameExit_All_ChangeCharacter_slot(uiCount, idx)
  if true == _ContentsGroup_RenewUI then
    return
  end
  if true == PaGlobal_GameExit_All._basic._btn_change_pcPool[uiCount]:GetShow() then
    HandleEventLUp_GameExit_All_ChangeCharacter(idx)
  elseif true == PaGlobal_GameExit_All._basic._btn_move_pcPool[uiCount]:GetShow() then
    HandleEventLUp_GameExit_All_Move()
    return
  end
end
function HandleEventLUp_GameExit_All_ChangeCharacter(index)
  if nil == index and PaGlobal_GameExit_All._eType._all == PaGlobal_GameExit_All._eViewType then
    index = PaGlobal_GameExit_All._selectCharacterIdx
  end
  if true == _ContentsGroup_isConsolePadControl and true == ToClient_isSpecialCharacter() and true == ToClient_IsInstanceField() then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_WARNING_PREMIUMCHARACTER"))
    return
  end
  PaGlobal_GameExit_All._changeIndex = index
  local characterData = getCharacterDataByIndex(index)
  if nil == characterData then
    return
  end
  local classType = getCharacterClassType(characterData)
  local char_Name = getCharacterName(characterData)
  if ToClient_IsCustomizeOnlyClass(classType) then
    NotifyDisplay(PAGetString(Defines.StringSheet_GAME, "LUA_LOBBY_SELECTCHARACTER_NOTYET_1"))
    return
  end
  local isSeasonCharacter = characterData._characterSeasonType == __eCharacterSeasonType_Season
  if true == _ContentsGroup_SeasonContents then
    local isSeasonChannel = ToClient_isSeasonChannel()
    if false == isSeasonCharacter and true == isSeasonChannel then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_CHARACTERSELECT_SEASON_ALERT"))
      return
    end
  elseif true == _ContentsGroup_PreSeason and true == isSeasonCharacter then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_LOBBY_SELECTCHARACTER_NOTYET_1"))
    return
  end
  if characterData._level < 7 then
    NotifyDisplay(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GAMEEXIT_DONT_CHAGECHARACTER", "iLevel", 6))
    return
  end
  local removeTime = getCharacterDataRemoveTime(index)
  if nil ~= removeTime then
    NotifyDisplay(PAGetString(Defines.StringSheet_GAME, "GAMEEXIT_TEXT_CHARACTER_DELETE"))
    return
  end
  local usabelSlotCount = getUsableCharacterSlotCount()
  if index >= usabelSlotCount then
    NotifyDisplay(PAGetString(Defines.StringSheet_GAME, "GAME_MESSAGE_CLOSE_CHARACTER_SLOT"))
    return
  end
  if true == ToClient_CheckDuelCharacterInPrison(index) then
    NotifyDisplay(PAGetString(Defines.StringSheet_GAME, "LUA_CHARACTERTAG_PRISON_CANT_LOGIN"))
    return
  end
  local contentString = ""
  if Defines.s64_const.s64_m1 ~= characterData._lastTicketNoByRegion then
    contentString = PAGetString(Defines.StringSheet_GAME, "GAMEEXIT_TEXT_WAIT") .. "\n"
  end
  if ToClient_SelfPlayerCheckAction("READ_BOOK") then
    local messageBoxMemo = PAGetString(Defines.StringSheet_GAME, "LUA_GAMEEXIT_READBOOK_WARNNING")
    local messageboxData = {
      title = PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_ALERT_NOTIFICATIONS"),
      content = messageBoxMemo,
      functionYes = PaGlobal_GameExit_All_CharChangeConfirm,
      functionCancel = MessageBox_Empty_function,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageboxData)
  end
  if CppEnums.PcWorkType.ePcWorkType_Empty ~= characterData._pcWorkingType then
    if CppEnums.PcWorkType.ePcWorkType_ReadBook == characterData._pcWorkingType then
      contentString = contentString .. PAGetString(Defines.StringSheet_GAME, "LUA_GAMEEXIT_WORKING_NOW_READ_BOOK")
    elseif CppEnums.PcWorkType.ePcWorkType_RepairItem == characterData._pcWorkingType then
      contentString = contentString .. PAGetString(Defines.StringSheet_GAME, "LUA_GAMEEXIT_REPAIR_NOW_CHANGE_Q")
    elseif CppEnums.PcWorkType.ePcWorkType_Relax == characterData._pcWorkingType then
      contentString = contentString .. PAGetString(Defines.StringSheet_GAME, "LUA_GAMEEXIT_REST_NOW_CHANGE_Q")
    else
      contentString = contentString .. PAGetString(Defines.StringSheet_GAME, "LUA_GAMEEXIT_WORKING_NOW_CHANGE_Q")
    end
  end
  local pcDeliveryRegionKey = characterData._arrivalRegionKey
  local serverUtc64 = getServerUtc64()
  if 0 ~= pcDeliveryRegionKey:get() and serverUtc64 < characterData._arrivalTime then
    contentString = PAGetString(Defines.StringSheet_GAME, "Lua_deliveryPerson_SelectPcDelivery") .. "\n"
  end
  if nil ~= contentString then
    if ToClient_SelfPlayerCheckAction("READ_BOOK") then
      local messageBoxMemo = PAGetString(Defines.StringSheet_GAME, "LUA_GAMEEXIT_READBOOK_WARNNING")
      local messageboxData = {
        title = PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_ALERT_NOTIFICATIONS"),
        content = messageBoxMemo,
        functionYes = PaGlobal_GameExit_All_CharChangeConfirm,
        functionCancel = MessageBox_Empty_function,
        priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
      }
      MessageBox.showMessageBox(messageboxData)
    else
      contentString = contentString .. PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GAMEEXIT_ALL_CHARACTER_CHANGE_QUESTION", "characterName", char_Name)
      local messageboxData = {
        title = "",
        content = contentString,
        functionYes = PaGlobal_GameExit_All_CharChangeConfirm,
        functionCancel = MessageBox_Empty_function,
        priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
      }
      MessageBox.showMessageBox(messageboxData)
    end
  elseif ToClient_SelfPlayerCheckAction("READ_BOOK") then
    local messageBoxMemo = PAGetString(Defines.StringSheet_GAME, "LUA_GAMEEXIT_READBOOK_WARNNING")
    local messageboxData = {
      title = PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_ALERT_NOTIFICATIONS"),
      content = messageBoxMemo,
      functionYes = PaGlobal_GameExit_All_CharChangeConfirm,
      functionCancel = MessageBox_Empty_function,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageboxData)
  else
    PaGlobal_GameExit_All_CharChangeConfirm()
  end
end
function HandleEventOnOut_GameExit_All_ServantInfoTooltip(isShow, charDataIdx, uiIdx, servantIdx)
  UI.ASSERT_NAME(nil ~= isShow, "HandleEventOnOut_GameExit_All_ServantInfoTooltip isShow nil", "\236\178\156\235\167\140\234\184\176")
  if false == isShow then
    TooltipSimple_Hide()
    return
  else
    UI.ASSERT_NAME(nil ~= charDataIdx, "HandleEventOnOut_GameExit_All_ServantInfoTooltip charDataIdx nil", "\236\178\156\235\167\140\234\184\176")
    UI.ASSERT_NAME(nil ~= uiIdx, "HandleEventOnOut_GameExit_All_ServantInfoTooltip uiIdx nil", "\236\178\156\235\167\140\234\184\176")
    UI.ASSERT_NAME(nil ~= servantIdx, "HandleEventOnOut_GameExit_All_ServantInfoTooltip servantIdx nil", "\236\178\156\235\167\140\234\184\176")
  end
  local characterData = getCharacterDataByIndex(charDataIdx)
  if nil == characterData then
    return
  end
  local briefServantInfo = ToClient_GetBriefServantInfoByCharacter(characterData, servantIdx)
  if nil == briefServantInfo then
    return
  end
  local name = briefServantInfo:getName()
  local desc = PaGlobalFunc_GameExit_All_ServantInfoText(briefServantInfo)
  local control
  if PaGlobal_GameExit_All._eType._basic == PaGlobal_GameExit_All._eViewType then
    control = PaGlobal_GameExit_All._basic._txt_servantIconPool[uiIdx][servantIdx]
  elseif PaGlobal_GameExit_All._eType._all == PaGlobal_GameExit_All._eViewType then
    control = PaGlobal_GameExit_All._all._txt_servantIconPool[uiIdx][servantIdx]
  end
  TooltipSimple_Show(control, name, desc)
end
function HandleEventLUp_GameExit_All_SimpleInventory(index)
  if PaGlobal_GameExit_All._eType._basic == PaGlobal_GameExit_All._eViewType then
    PaGlobal_SimpleInventory:requestSimpleInventory(index)
  elseif PaGlobal_GameExit_All._eType._all == PaGlobal_GameExit_All._eViewType then
    PaGlobal_SimpleInventory:requestSimpleInventory(PaGlobal_GameExit_All._selectCharacterIdx)
  end
end
function HandleEventOnOut_GameExit_All_ShowSimpleInventoryTooltip(isShow, idx, uiCount)
  if false == isShow then
    TooltipSimple_Hide()
    return
  end
  local control
  if nil == idx then
    idx = PaGlobal_GameExit_All._selectCharacterIdx
    control = PaGlobal_GameExit_All._ui._charInfo._btn_inven_pc
  else
    control = PaGlobal_GameExit_All._basic._btn_invenPool[uiCount]
  end
  local characterData = getCharacterDataByIndex(idx)
  if nil == characterData then
    return
  end
  local char_Name = getCharacterName(characterData)
  local title = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GAMEEXIT_SIMPLEINVEN_TITLE", "name", char_Name)
  local desc = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GAMEEXIT_SIMPLEINVEN_DESC", "name", char_Name)
  TooltipSimple_Show(control, title, desc)
end
function HandleEventLUp_GameExit_All_CharacterSelect()
  if ToClient_SelfPlayerCheckAction("READ_BOOK") then
    local messageBoxMemo = PAGetString(Defines.StringSheet_GAME, "LUA_GAMEEXIT_READBOOK_WARNNING")
    local messageboxData = {
      title = PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_ALERT_NOTIFICATIONS"),
      content = messageBoxMemo,
      functionYes = PaGlobal_GameExit_All_GoToCharacterSelect,
      functionCancel = MessageBox_Empty_function,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageboxData)
  else
    local contentStr = PAGetString(Defines.StringSheet_GAME, "LUA_GAMEEXIT_BACK_TO_CHARACTERSELECT_Q")
    local messageboxData = {
      title = "",
      content = contentStr,
      functionYes = PaGlobal_GameExit_All_GoToCharacterSelect,
      functionCancel = MessageBox_Empty_function,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW,
      exitButton = true
    }
    MessageBox.showMessageBox(messageboxData)
  end
end
function HandleEventLUp_GameExit_All_Tray()
  Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_GAMEEXIT_TRAYBLACKDESERT_ACK"))
  ToClient_CheckTrayIcon()
  PaGlobal_GameExit_All:prepareClose()
end
function HandleEventLUp_GameExit_All_Close()
  PaGlobal_GameExit_All:prepareClose()
end
function HandleEventLUp_GameExit_All_SelectCharacter_all(index, isCurrentCharaceter)
  PaGlobal_GameExit_All:selectCharacter_all(index)
  if true == PaGlobal_GameExit_All._isConsole then
    PaGlobal_GameExit_All:updateKeyGuide(false, isCurrentCharaceter)
  end
end
function HandleEventLDClick_GameExit_All_ChangeCharacter_all(idx)
  if true == _ContentsGroup_RenewUI then
    return
  end
  if -1 == PaGlobal_GameExit_All._selectCharacterIdx then
    return
  end
  if true == PaGlobal_GameExit_All._ui._charInfo._btn_move_pc:GetShow() then
    HandleEventLUp_GameExit_All_Move()
    return
  elseif true == PaGlobal_GameExit_All._ui._charInfo._btn_change_pc:GetShow() then
    HandleEventLUp_GameExit_All_ChangeCharacter()
    return
  end
end
function HandleEventOn_GameExit_All_UpdateKeyGuide(isNormalButton, isCurrentCharaceter, uiCount)
  PaGlobal_GameExit_All:updateKeyGuide(isNormalButton, isCurrentCharaceter)
  PaGlobal_GameExit_All._nowSnapSlotNo = uiCount
end
function HandleEventLUp_GameExit_All_GameExit()
  if PaGlobal_GameExit_All._isConsole then
    _AudioPostEvent_SystemUiForXBOX(8, 14)
    local titleText = PAGetString(Defines.StringSheet_GAME, "GAME_EXIT_MESSAGEBOX_TITLE")
    local messageBoxMemo = PAGetString(Defines.StringSheet_GAME, "LUA_GAMEEXIT_DISCONNECT")
    local messageBoxData = {
      title = titleText,
      content = messageBoxMemo,
      functionYes = PaGlobal_GameExit_All_ExitButton,
      functionNo = MessageBox_Empty_function,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageBoxData)
  elseif true == isGameTypeKR2() then
    PaGlobalFunc_ExitTrayConfirm_All_ExitOpen()
  else
    PaGlobal_ExitConfirm_All_Open()
  end
end
function HandleEventLUp_GameExit_All_ServerChange()
  if true == _ContentsGroup_NewUI_ChannelSelect_All then
    PaGlobalFunc_ChannelSelect_All_Open()
  elseif PaGlobal_GameExit_All._isConsole then
    PaGlobalFunc_ServerSelect_Open()
  else
    FGlobal_ChannelSelect_Show()
  end
end
function HandleEventLUp_GameExit_All_ForFacePhoto()
  PaGlobal_GameExit_All._isExitPhoto = true
  PaGlobal_GameExit_All_Close()
  IsGameExitPhoto(true)
  IngameCustomize_Show()
  if PaGlobal_GameExit_All._eType._basic == PaGlobal_GameExit_All._eViewType then
    characterSlot_Index(PaGlobal_GameExit_All._photoIndex)
  elseif PaGlobal_GameExit_All._eType._all == PaGlobal_GameExit_All._eViewType then
    characterSlot_Index(PaGlobal_GameExit_All._selectCharacterIdx)
  end
end
function HandleEventLUp_GameExit_All_listToggle()
  _AudioPostEvent_SystemUiForXBOX(50, 0)
  TooltipSimple_Hide()
  if PaGlobal_GameExit_All._isConsole then
    local chkListToggle = PaGlobal_GameExit_All._ui._pc._chk_listToggle
    chkListToggle:SetCheck(not chkListToggle:IsCheck())
  end
  PaGlobal_GameExit_All:updateListToggle()
end
function HandleEventOn_GameExit_All_listToggleTooltip()
  local name = ""
  if PaGlobal_GameExit_All._eType._basic == PaGlobal_GameExit_All._eViewType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_CHARACTERSELECT_VIEWALL_TOOLTIP_DESC")
  elseif PaGlobal_GameExit_All._eType._all == PaGlobal_GameExit_All._eViewType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_CHARACTERSELECT_VIEWDETAIL_TOOLTIP_DESC")
  end
  local control = PaGlobal_GameExit_All._ui._pc._chk_listToggle
  TooltipSimple_Show(control, name, nil)
end
function HandleEventOut_GameExit_All_listToogleTooltipHide()
  TooltipSimple_Hide()
end
function HandleEventLUp_GameExit_All_TrayConfirm()
  if true == _ContentsGroup_NewUI_TrayConfirm_All then
    return
  end
  if PaGlobal_GameExit_All._ui._tray._chk_tray:IsCheck() then
    ToClient_CheckTrayIcon()
  else
    ToClient_UnCheckTrayIcon()
  end
  Panel_ExitConfirm_Old:SetShow(false)
end
function HandleEventLUp_GameExit_All_TrayCancel()
  if true == _ContentsGroup_NewUI_TrayConfirm_All then
    return
  end
  PaGlobal_ExitConfirm_All_Close()
  Panel_Tooltip_Item_hideTooltip()
  Panel_ExitConfirm_Old:SetShow(false)
end
function HandleEventLUp_GameExit_All_SeasonIconTooltip(idx, isGridSlot)
  if nil == idx or nil == isGridSlot then
    TooltipSimple_Hide()
    return
  end
  local control, name
  if true == isGridSlot then
    if nil ~= PaGlobal_GameExit_All._all._stc_seasonIconPool[idx] then
      control = PaGlobal_GameExit_All._all._stc_seasonIconPool[idx]
    end
  elseif nil ~= PaGlobal_GameExit_All._basic._stc_seasonIconPool[idx] then
    control = PaGlobal_GameExit_All._basic._stc_seasonIconPool[idx]
  end
  name = PAGetString(Defines.StringSheet_GAME, "LUA_SEASONCONTENT_SEASONCHARACTER")
  if nil == control then
    return
  end
  TooltipSimple_Show(control, name, nil)
end
function FromClient_GameExit_All_WindowClose()
  PaGlobal_GameExit_All:showToggle()
end
function FromClient_GameExit_All_RecentJournalUpdate()
  PaGlobal_GameExit_All:updateRecentJournal()
end
function FromClient_GameExit_All_OnScreenResize()
  if nil == Panel_Window_GameExit_All then
    return
  end
  Panel_Window_GameExit_All:ComputePos()
end
function FromClient_GameExit_All_UpdateSlot()
  PaGlobal_GameExit_All:updateCharacterSlot(PaGlobal_GameExit_All._photoIndex + 1)
  PaGlobal_GameExit_All:updateCharacterSlot_all()
end
function FromClient_GameExit_All_TrayIconMessageBox()
  if true == _ContentsGroup_NewUI_TrayConfirm_All then
    PaGlobalFunc_ExitTrayConfirm_All_TrayOpen()
  else
    PaGlobal_GameExit_All._ui._tray._txt_title:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_GAMEEXITCONFIRM_TITLE"))
    PaGlobal_GameExit_All._ui._tray._txt_contentsString:SetText(PAGetString(Defines.StringSheet_GAME, "PANEL_GAMEEXIT_TRAY_ASK2"))
    Panel_ExitConfirm_Old:SetShow(true)
  end
end
function PaGlobal_GameExit_All_ShowAni()
  if nil == Panel_Window_GameExit_All then
    return
  end
  UIAni.fadeInSCR_Down(Panel_Window_GameExit_All)
  audioPostEvent_SystemUi(1, 0)
end
function PaGlobal_GameExit_All_HideAni()
  if nil == Panel_Window_GameExit_All then
    return
  end
  Panel_Window_GameExit_All:SetShowWithFade(CppEnums.PAUI_SHOW_FADE_TYPE.PAUI_ANI_TYPE_FADE_OUT)
  local aniInfo1 = Panel_Window_GameExit_All:addColorAnimation(0, 0.2, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
  aniInfo1:SetStartColor(UI_color.C_FFFFFFFF)
  aniInfo1:SetEndColor(UI_color.C_00FFFFFF)
  aniInfo1:SetStartIntensity(3)
  aniInfo1:SetEndIntensity(1)
  aniInfo1.IsChangeChild = true
  aniInfo1:SetHideAtEnd(true)
  aniInfo1:SetDisableWhileAni(true)
  ButtonFacePhoto_ToolTip(false)
  audioPostEvent_SystemUi(1, 1)
end
function PaGlobal_GameExit_All_SetChallengeScroll(isUp)
  UIScroll.SetButtonSize(PaGlobal_GameExit_All._ui._scroll_frame, PaGlobal_GameExit_All._ui._frame_contents:GetSizeY(), PaGlobal_GameExit_All._ui._frame_todayMyChallenge:GetSizeY())
  local scrollBtnSizeY = PaGlobal_GameExit_All._ui._scroll_frame:GetControlButton():GetSizeY() * 0.5 / 100
  if true == isUp then
    scrollBtnSizeY = scrollBtnSizeY * -1
  end
  local scrollPosY = PaGlobal_GameExit_All._ui._scroll_frame:GetControlPos()
  PaGlobal_GameExit_All._ui._scroll_frame:SetControlPos(scrollPosY + scrollBtnSizeY)
  if scrollPosY + scrollBtnSizeY <= 0 then
    PaGlobal_GameExit_All._ui._scroll_frame:SetControlTop()
  elseif 1 <= scrollPosY + scrollBtnSizeY then
    PaGlobal_GameExit_All._ui._scroll_frame:SetControlBottom()
  end
  PaGlobal_GameExit_All._ui._frame_todayMyChallenge:UpdateContentScroll()
  PaGlobal_GameExit_All._ui._frame_todayMyChallenge:UpdateContentPos()
end
function PaGlobal_GameExit_All_ShowToggle(isAttacked)
  PaGlobal_GameExit_All:showToggle(isAttacked)
end
function PaGlobal_GameExit_All_GetWorkTypeString(workingType)
  local workingText
  if CppEnums.PcWorkType.ePcWorkType_Empty == workingType then
    workingText = ""
  elseif CppEnums.PcWorkType.ePcWorkType_Play == workingType then
    workingText = PAGetString(Defines.StringSheet_GAME, "CHARACTER_WORKING_TEXT_PLAY")
  elseif CppEnums.PcWorkType.ePcWorkType_RepairItem == workingType then
    workingText = PAGetString(Defines.StringSheet_GAME, "CHARACTER_WORKING_TEXT_REPAIRITEM")
  elseif CppEnums.PcWorkType.ePcWorkType_Relax == workingType then
    workingText = PAGetString(Defines.StringSheet_GAME, "CHARACTER_WORKING_TEXT_RELEX")
  elseif CppEnums.PcWorkType.ePcWorkType_ReadBook == workingType then
    workingText = PAGetString(Defines.StringSheet_GAME, "CHARACTER_WORKING_TEXT_READBOOK")
  else
    _PA_ASSERT(false, "\236\186\144\235\166\173\237\132\176 \236\158\145\236\151\133 \237\131\128\236\158\133\236\157\180 \236\182\148\234\176\128 \235\144\152\236\151\136\236\138\181\235\139\136\235\139\164. Panel_Window_GameExit_All_2.lua \235\143\132 \236\182\148\234\176\128\237\149\180 \236\163\188\236\150\180\236\149\188 \237\149\169\235\139\136\235\139\164.")
    workingText = "unKnown"
  end
  return workingText
end
function PaGlobal_GameExit_All_CharChangeConfirm()
  PaGlobal_GameExit_ALL_SaveCurrentData()
  local rv = swapCharacter_Select(PaGlobal_GameExit_All._changeIndex, true)
  if false == rv then
    return
  end
  PaGlobal_GameExit_All._exitMode = PaGlobal_GameExit_All._eExitMode._swapCharacter
  PaGlobal_GameExit_All:setShowHideBottomButton()
  local isTagchange = false
  if true == _ContentsGroup_CharacterTag then
    if true == _ContentsGroup_NewUI_CharacterTag_All then
      isTagchange = PaGlobalFunc_CharacterTag_All_IsTagChange()
    else
      isTagchange = PaGlobal_IsTagChange()
    end
  end
  if true == isTagchange then
    local messageBoxMemo = PAGetString(Defines.StringSheet_GAME, "LUA_TAG_CHANGING")
    local messageBoxData = {
      title = PAGetString(Defines.StringSheet_GAME, "LUA_WARNING"),
      content = messageBoxMemo,
      functionYes = MessageBox_Empty_function,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageBoxData)
  end
  if true == PaGlobal_GameExit_All._isConsole then
    local messageBoxData = {
      title = PAGetString(Defines.StringSheet_GAME, "LUA_MESSAGEBOX_NOTIFY"),
      content = PAGetString(Defines.StringSheet_GAME, "GAME_MESSAGE_WAIT_PROCESS"),
      isLoading = true,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_0
    }
    MessageBox.showMessageBox(messageBoxData)
  end
end
function PaGlobal_GameExit_ALL_SaveCurrentData()
  getSelfPlayer():saveCurrentDataForGameExit()
  ToClient_SaveUiInfo(false)
end
function PaGlobalFunc_GameExit_All_ServantInfoText(briefServantInfo)
  UI.ASSERT_NAME(nil ~= briefServantInfo, "PaGlobalFunc_GameExit_All_ServantInfoText briefServantInfo nil", "\236\178\156\235\167\140\234\184\176")
  local servantKind = briefServantInfo:getServantKind()
  local strKind = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTINFO_SERVANTKIND_" .. servantKind)
  if 31053 == briefServantInfo:getServantCharacterKeyRaw() then
    strKind = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTINFO_SERVANTKIND_15_1")
  end
  local strText = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_SERVANTINFO_TOOLTIP_KIND", "kind", strKind)
  local level = briefServantInfo:getLevel()
  if 0 < level then
    strText = strText .. "\n" .. PAGetStringParam1(Defines.StringSheet_GAME, "LUA_SERVANTINFO_TOOLTIP_LEVEL", "level", level)
  end
  if CppEnums.ServantKind.Type_Horse == servantKind then
    local tier = briefServantInfo:getTier()
    if 0 < tier then
      if 9 == tier then
        tier = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANT_TEXT_TIER9")
      end
      strText = strText .. "\n" .. PAGetStringParam1(Defines.StringSheet_GAME, "LUA_SERVANTINFO_TOOLTIP_TIER", "tier", tier)
    end
  end
  return strText
end
function PaGlobal_GameExit_All_GoToCharacterSelect()
  PaGlobal_GameExit_All._exitMode = PaGlobal_GameExit_All._eExitMode._backCharacter
  PaGlobal_GameExit_ALL_SaveCurrentData()
  if false == sendCharacterSelect() then
    PaGlobal_GameExit_All._exitMode = -1
    return
  end
  if PaGlobal_GameExit_All._isConsole then
    local messageBoxData = {
      title = PAGetString(Defines.StringSheet_GAME, "LUA_MESSAGEBOX_NOTIFY"),
      content = PAGetString(Defines.StringSheet_GAME, "GAME_MESSAGE_WAIT_PROCESS"),
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_0
    }
    MessageBox.showMessageBox(messageBoxData)
  else
    PaGlobal_GameExit_All:setShowHideBottomButton()
  end
end
function PaGlobal_GameExit_All_Close()
  PaGlobal_GameExit_All:prepareClose()
end
function PaGlobal_GameExit_ALL_GameExitSuccess()
  PaGlobal_GameExit_All._exitMode = PaGlobal_GameExit_All._eExitMode._gameExit
  PaGlobal_GameExit_ALL_SaveCurrentData()
  sendBeginGameDelayExit(false)
  PaGlobal_GameExit_All:setShowHideBottomButton()
end
function PaGlobal_GameExit_All_GetIsExitPhoto()
  return PaGlobal_GameExit_All._isExitPhoto
end
function PaGlobal_GameExit_All_UpdateSlot(startIdx)
  PaGlobal_GameExit_All:updateCharacterSlot(startIdx)
end
function PaGlobal_GameExit_All_ChangeCharacter(index)
  HandleEventLUp_GameExit_All_ChangeCharacter(index)
end
function PaGlobal_GameExit_All_ExitButton()
  _AudioPostEvent_SystemUiForXBOX(50, 1)
  getSelfPlayer():updateNavigationInformation("")
  getSelfPlayer():saveCurrentDataForGameExit()
  ToClient_SaveUiInfo(false)
  sendBeginGameDelayExit(false)
  local messageBoxData = {
    title = PAGetString(Defines.StringSheet_GAME, "LUA_MESSAGEBOX_NOTIFY"),
    content = PAGetString(Defines.StringSheet_GAME, "GAME_MESSAGE_WAIT_PROCESS"),
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_0
  }
  MessageBox.showMessageBox(messageBoxData)
end
function PaGlobal_GameExit_All_ChangeAccount_MessageBoxConfirm()
  _AudioPostEvent_SystemUiForXBOX(50, 1)
  ToClient_ChangeAccount()
end
function PaGlobal_GameExit_ALL_ShowAni()
  if nil == Panel_Window_GameExit_All then
    return
  end
  UIAni.fadeInSCR_Down(Panel_Window_GameExit_All)
end
function PaGlobal_GameExit_ALL_HideAni()
  if nil == Panel_Window_GameExit_All then
    return
  end
  Panel_Window_GameExit_All:SetShowWithFade(CppEnums.PAUI_SHOW_FADE_TYPE.PAUI_ANI_TYPE_FADE_OUT)
  local gameExitHideAni = Panel_Window_GameExit_All:addColorAnimation(0, 0.25, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
  gameExitHideAni:SetStartColor(Defines.Color.C_FFFFFFFF)
  gameExitHideAni:SetEndColor(Defines.Color.C_00FFFFFF)
  gameExitHideAni:SetStartIntensity(3)
  gameExitHideAni:SetEndIntensity(1)
  gameExitHideAni.IsChangeChild = true
  gameExitHideAni:SetHideAtEnd(true)
  gameExitHideAni:SetDisableWhileAni(true)
end
