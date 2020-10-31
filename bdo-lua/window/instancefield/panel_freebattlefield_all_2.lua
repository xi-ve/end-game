function PaGlobalFunc_FreeBaettleField_All_Open()
  if true == Panel_FreeBattleField_All:GetShow() then
    return
  end
  PaGlobal_FreeBaettleField_All:prepareOpen()
end
function PaGlobalFunc_FreeBaettleField_All_OnScreenResize()
  if nil == Panel_FreeBattleField_All then
    return
  end
  Panel_FreeBattleField_All:ComputePos()
end
function PaGlobalFunc_FreeBaettleField_All_Close()
  if false == Panel_FreeBattleField_All:GetShow() then
    return
  end
  PaGlobal_FreeBaettleField_All:prepareClose()
end
function FromClient_FreeBattleField_ListUpdate()
  if false == Panel_FreeBattleField_All:GetShow() then
    return
  end
  PaGlobal_FreeBaettleField_All._ui.list2_FieldList:getElementManager():clearKey()
  local roomCount = ToClient_requestGetInstancePrivateRoomCountWithType(__eInstanceContentsType_FreeBattleField)
  for index = 0, roomCount - 1 do
    PaGlobal_FreeBaettleField_All._ui.list2_FieldList:getElementManager():pushKey(toInt64(0, index))
  end
end
function FromClient_FreeBattleField_List2Update(content, key)
  if nil == Panel_FreeBattleField_All or false == Panel_FreeBattleField_All:GetShow() then
    return
  end
  local key32 = Int64toInt32(key)
  local txt_FieldName = UI.getChildControl(content, "StaticText_Channel")
  local txt_PlayerCount = UI.getChildControl(content, "StaticText_JoinMemberCount")
  local btn_Join = UI.getChildControl(content, "Button_Join")
  local roomInfoWrapper = ToClient_InstanceFieldRoomInfoWrapperWithType(__eInstanceContentsType_FreeBattleField, key32)
  if nil == roomInfoWrapper then
    content:SetShow(false)
    return
  end
  content:SetShow(true)
  local playerCount = roomInfoWrapper:getMatchedCount()
  local fieldName = roomInfoWrapper:getTitle()
  txt_FieldName:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_INSTANCEFIELD_FREEARENA") .. " - " .. tostring(key32 + 1))
  txt_PlayerCount:SetText(playerCount)
  btn_Join:addInputEvent("Mouse_LUp", "HandleEventLUp_FreeBattleField_Join(" .. key32 .. ")")
end
function HandleEventLUp_FreeBattleField_Join(roomIndex)
  local function joinConfirm()
    ToClient_FindForJoinPrivateRoomForAll(__eInstanceContentsType_FreeBattleField, roomIndex)
    if true == _ContentsGroup_RenewUI then
      PaGlobalFunc_FreeBaettleField_All_Close()
      local selfPlayer = getSelfPlayer()
      if nil == selfPlayer then
        return
      end
      if false == selfPlayer:isInstancePlayer() and false == getPvPMode() then
        local messageData = {
          title = PAGetString(Defines.StringSheet_GAME, "LUA_MESSAGEBOX_NOTIFY"),
          content = PAGetString(Defines.StringSheet_GAME, "GAME_MESSAGE_WAIT_PROCESS"),
          functionCancel = MessageBox_Empty_function,
          isLoading = true,
          priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_0
        }
        MessageBox.showMessageBox(messageData)
      end
    end
  end
  if true == ToClient_IsInstanceRandomMatching() then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_BLOODALTAR_RANDOMMATCH_FAILACK"))
    return
  end
  local player = getSelfPlayer():get()
  local maxHp = player:getMaxHp()
  local playerHp = player:getHp()
  if player:getLevel() < 50 then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_MENU_FREEFIGHTALERT"))
    return
  end
  if maxHp == playerHp then
    if false == IsSelfPlayerWaitAction() then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_MENU_PVPBATTLEGROUND_CONDITION_WAIT"))
      return
    end
  else
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_CURRENTACTION_CHECKHP"))
  end
  local messageBoxMemo = PAGetString(Defines.StringSheet_GAME, "LUA_MENU_PVPBATTLEGROUND_JOIN")
  local messageBoxData = {
    title = PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_ALERT_NOTIFICATIONS"),
    content = messageBoxMemo,
    functionYes = joinConfirm,
    functionNo = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageBoxData)
end
