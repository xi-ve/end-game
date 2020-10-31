function PaGlobalFunc_DeadMessage_All_Open()
  if nil == Panel_Window_DeadMessage_All then
    return
  end
  PaGlobal_DeadMessage_All:prepareOpen()
end
function PaGlobalFunc_DeadMessage_All_Close()
  if nil == Panel_Window_DeadMessage_All or false == Panel_Window_DeadMessage_All:GetShow() then
    return
  end
  PaGlobal_DeadMessage_All:prepareClose()
end
function PaGlobalFunc_DeadMessage_All_Update(deltaTime)
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer or nil == selfPlayer:get() then
    return
  end
  if true == ToClient_IsInstanceFieldPlayerbyContentsType(__eInstanceContentsType_OthilitaDungeon) then
    return
  end
  PaGlobal_DeadMessage_All._deadCheckTime = PaGlobal_DeadMessage_All._deadCheckTime + deltaTime
  if PaGlobal_DeadMessage_All._deadCheckGap < PaGlobal_DeadMessage_All._deadCheckTime then
    PaGlobal_DeadMessage_All._deadCheckTime = 0
    if true == selfPlayer:isDead() or 0 >= selfPlayer:get():getHp() then
      if false == PaGlobal_DeadMessage_All._isObserverMode and false == Panel_Window_DeadMessage_All:GetShow() then
        FromClient_DeadMessage_All_SetDeadMessage(PaGlobal_DeadMessage_All._attackerActorKeyRaw, PaGlobal_DeadMessage_All._isSkipDeathPenalty, PaGlobal_DeadMessage_All._isHasResotreExp, PaGlobal_DeadMessage_All._isAblePvPMatchRevive, PaGlobal_DeadMessage_All._resurrectionTime)
      end
    else
      PaGlobalFunc_DeadMessage_All_Close()
    end
  end
  if true == selfPlayer:isDead() or 0 >= selfPlayer:get():getHp() then
    local button = PaGlobal_DeadMessage_All._eButtonType
    local isMyChannelSiegeBeing = deadMessage_isSiegeBeingMyChannel()
    if true == PaGlobal_DeadMessage_All._isUseButtonAbleTime then
      PaGlobal_DeadMessage_All._buttonWaitTime = PaGlobal_DeadMessage_All._buttonWaitTime - deltaTime
      PaGlobal_DeadMessage_All._buttonAbleTime = PaGlobal_DeadMessage_All._buttonAbleTime - deltaTime
      if 0 > PaGlobal_DeadMessage_All._buttonWaitTime then
        if nil ~= PaGlobal_DeadMessage_All._buttonTypeArray then
          local UIindex = 0
          local buttonControl = PaGlobal_DeadMessage_All._ui._button_Respawn
          for index = 1, #PaGlobal_DeadMessage_All._buttonTypeArray do
            local control = buttonControl[UIindex]
            local buttonType = PaGlobal_DeadMessage_All._buttonTypeArray[index]
            if button.Immediate == buttonType or button.Exploration == buttonType or button.NearTown == buttonType or button.InSiegeingFortress == buttonType or button.GuildSpawn == buttonType or button.AdvancedBase == buttonType or button.Volunteer == buttonType or button.OutsideGate == buttonType or button.InsideGate == buttonType then
              control:SetEnable(true)
            end
            UIindex = UIindex + 1
          end
          PaGlobal_DeadMessage_All._isUseButtonAbleTime = false
        end
      elseif nil ~= PaGlobal_DeadMessage_All._buttonTypeArray then
        local UIindex = 0
        local buttonControl = PaGlobal_DeadMessage_All._ui._button_Respawn
        for index = 1, #PaGlobal_DeadMessage_All._buttonTypeArray do
          local control = buttonControl[UIindex]
          local buttonType = PaGlobal_DeadMessage_All._buttonTypeArray[index]
          if button.Immediate == buttonType or button.Exploration == buttonType or button.NearTown == buttonType or button.InSiegeingFortress == buttonType or button.GuildSpawn == buttonType or button.AdvancedBase == buttonType or button.Volunteer == buttonType or button.OutsideGate == buttonType or button.InsideGate == buttonType then
            control:SetEnable(false)
          end
          UIindex = UIindex + 1
        end
      end
    end
    if nil == PaGlobal_DeadMessage_All._resurrectionTime then
      PaGlobal_DeadMessage_All._ui.txt_resurrectionTime:SetShow(false)
      return
    end
    if 0 < PaGlobal_DeadMessage_All._resurrectionTime then
      PaGlobal_DeadMessage_All._resurrectionTime = PaGlobal_DeadMessage_All._resurrectionTime - deltaTime
      local regenTime = math.floor(PaGlobal_DeadMessage_All._resurrectionTime)
      if PaGlobal_DeadMessage_All._lastUpdateTime == regenTime then
        return
      end
      if PaGlobal_DeadMessage_All._eDeadType.DeadLocate_InCompetition == PaGlobal_DeadMessage_All._currentDeadType then
        PaGlobal_DeadMessage_All._ui.txt_resurrectionTime:SetShow(false)
      else
        PaGlobal_DeadMessage_All._ui.txt_resurrectionTime:SetShow(true)
      end
      PaGlobal_DeadMessage_All._lastUpdateTime = regenTime
      if true == PaGlobal_DeadMessage_All._isUseButtonAbleTime and false == isMyChannelSiegeBeing then
        PaGlobal_DeadMessage_All._ui.txt_resurrectionTime:SetText(PAGetString(Defines.StringSheet_GAME, "DEADMESSAGE_TEXT_RespawnWaitting"))
      elseif true == PaGlobal_DeadMessage_All._isUseButtonAbleTime and false == PaGlobal_DeadMessage_All._isButtonWaitTimeEnd then
        PaGlobal_DeadMessage_All._ui.txt_resurrectionTime:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "DEADMESSAGE_TEXT_RESPAWN_TIME", "regenTime", tostring(regenTime)))
      else
        PaGlobal_DeadMessage_All._ui.txt_resurrectionTime:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "DEADMESSAGE_TEXT_RESPAWN_TIME2", "regenTime", tostring(regenTime)))
      end
      if 0 < regenTime then
        return
      end
      if (PaGlobal_DeadMessage_All._eDeadType.DeadLocate_InSiegeBattle == PaGlobal_DeadMessage_All._currentDeadType or PaGlobal_DeadMessage_All._eDeadType.DeadLocate_InMajorSiegeBattle == PaGlobal_DeadMessage_All._currentDeadType) and false == PaGlobal_DeadMessage_All._isButtonWaitTimeEnd then
        PaGlobal_DeadMessage_All._isButtonWaitTimeEnd = true
        PaGlobal_DeadMessage_All._resurrectionTime = PaGlobal_DeadMessage_All._revivalTime
        PaGlobalFunc_DeadMessage_All_HideObserverButton()
        return
      end
      PaGlobal_DeadMessage_All._ui.txt_resurrectionTime:SetShow(false)
      if true == goToPrison() then
        deadMessage_Revival(PaGlobal_DeadMessage_All._eRespawnType.respawnType_TimeOver, 255, 0, getSelfPlayer():getRegionKey(), false, toInt64(0, 0))
        SetUIMode(Defines.UIMode.eUIMode_Default)
      elseif true == isMyChannelSiegeBeing and (true == deadMessage_isInSiegeBattle() or true == deadMessage_isInMajorSiegeBattle()) or 0 ~= getSelfPlayer():get():getVolunteerTeamNoForLua() then
        deadMessage_Revival(PaGlobal_DeadMessage_All._eRespawnType.respawnType_TimeOver, 255, 0, getSelfPlayer():getRegionKey(), false, toInt64(0, 0))
        SetUIMode(Defines.UIMode.eUIMode_Default)
      elseif true == ToClient_IsSelfInGuildTeamBattle() then
        deadMessage_Revival(PaGlobal_DeadMessage_All._eRespawnType.respawnType_GuildTeamBattle, 0, CppEnums.ItemWhereType.eCashInventory, getSelfPlayer():getRegionKey(), false, toInt64(0, 0))
        SetUIMode(Defines.UIMode.eUIMode_Default)
      else
        deadMessage_Revival(PaGlobal_DeadMessage_All._eRespawnType.respawnType_TimeOver, 255, 0, getSelfPlayer():getRegionKey(), false, toInt64(0, 0))
        SetUIMode(Defines.UIMode.eUIMode_Default)
      end
    else
      PaGlobalFunc_DeadMessage_All_HideObserverButton()
      PaGlobal_DeadMessage_All._ui.txt_resurrectionTime:SetShow(false)
    end
  end
end
function PaGlobalFunc_DeadMessage_All_HideObserverButton()
  local UIindex = 0
  local buttonControl = PaGlobal_DeadMessage_All._ui._button_Respawn
  local button = PaGlobal_DeadMessage_All._eButtonType
  for index = 1, #PaGlobal_DeadMessage_All._buttonTypeArray do
    local control = buttonControl[UIindex]
    local buttonType = PaGlobal_DeadMessage_All._buttonTypeArray[index]
    if button.GuildObServerMode == buttonType then
      if true == control:GetShow() then
        control:SetShow(false)
        local buttonSizeY = control:GetSizeY()
        for ii = UIindex + 1, #PaGlobal_DeadMessage_All._buttonTypeArray do
          buttonControl[ii]:SetPosY(buttonControl[ii]:GetPosY() - buttonSizeY - 10)
        end
      end
    elseif button.Observer == buttonType then
      local isObserverButtonShow = false
      if getSelfPlayer():get():isCompetitionDefined() and CppEnums.CompetitionMatchType.eCompetitionMatchMode_Personal ~= ToClient_CompetitionMatchType() then
        isObserverButtonShow = true
      end
      if true == ToClient_getJoinGuildBattle() then
        isObserverButtonShow = true
      end
      if true == ToClient_getPlayNowSavageDefence() then
        isObserverButtonShow = true
      end
      if true == ToClient_IsSelfInGuildTeamBattle() then
        isObserverButtonShow = false
      end
      if true == ToClient_IsInstanceFieldPlayerbyContentsType(__eInstanceContentsType_SavageDefence) then
        isObserverButtonShow = true
      end
      if true == control:GetShow() and false == isObserverButtonShow then
        control:SetShow(isObserverButtonShow)
        local buttonSizeY = control:GetSizeY()
        for ii = UIindex + 1, #PaGlobal_DeadMessage_All._buttonTypeArray do
          buttonControl[ii]:SetPosY(buttonControl[ii]:GetPosY() - buttonSizeY - 10)
        end
      end
      control:SetShow(isObserverButtonShow)
    end
    UIindex = UIindex + 1
  end
end
function deadMessage_ResurrectionTimeReturn(Rtime)
  if false == PaGlobal_DeadMessage_All._isButtonWaitTimeEnd then
    PaGlobal_DeadMessage_All._resurrectionTime = Rtime
    PaGlobal_DeadMessage_All._buttonAbleTime = Rtime
  end
end
function HandleEventOn_DeadMessage_All_ButtonMouseOn(buttonUIIndex)
  if nil == Panel_Window_DeadMessage_All then
    return
  end
  if false == PaGlobal_DeadMessage_All._isConsole then
    return
  end
  local buttonControl = PaGlobal_DeadMessage_All._ui._button_Respawn
  local keyPosY = buttonControl[buttonUIIndex]:GetPosY()
  PaGlobal_DeadMessage_All._ui.btn_selectButton_console:SetPosY(keyPosY)
end
function FromClient_DeadMessage_All_OnScreenReSize()
  if nil == Panel_Window_DeadMessage_All then
    return
  end
  Panel_Window_DeadMessage_All:SetSize(getScreenSizeX(), getScreenSizeY())
  PaGlobal_DeadMessage_All._ui.stc_circleBG:SetPosX((getScreenSizeX() - PaGlobal_DeadMessage_All._ui.stc_circleBG:GetSizeX()) / 2)
  PaGlobal_DeadMessage_All._ui.stc_circleBG:SetPosY((getScreenSizeY() - PaGlobal_DeadMessage_All._ui.stc_circleBG:GetSizeY()) / 2)
  Panel_Window_DeadMessage_All:ComputePos()
  PaGlobal_DeadMessage_All._ui.stc_centerBG:ComputePos()
  PaGlobal_DeadMessage_All._ui.stc_lostItemBG:ComputePos()
  PaGlobal_DeadMessage_All._ui.stc_resurrectionBG:ComputePos()
  PaGlobal_DeadMessage_All._ui.txt_siegeNotice:ComputePos()
  PaGlobal_DeadMessage_All._ui.txt_siegeNotice:SetPosY(getScreenSizeY() / 2 - 40)
  PaGlobal_DeadMessage_All._ui.stc_resurrectionBG:SetPosY(getScreenSizeY() / 2 + 50)
  PaGlobalFunc_DeadMessage_All_ScreenOutCheck()
end
function PaGlobalFunc_DeadMessage_All_ScreenOutCheck()
  local buttonArray = PaGlobal_DeadMessage_All._buttonTypeArray
  if nil == buttonArray then
    return
  end
  if 0 < #buttonArray then
    local checkButtonSizeY = PaGlobal_DeadMessage_All._ui.btn_useItemCheck:GetSizeY()
    local checkButtonAreaSizeY = 0
    if true == PaGlobal_DeadMessage_All._ui.btn_useItemCheck:GetShow() then
      checkButtonAreaSizeY = checkButtonAreaSizeY + checkButtonSizeY
    end
    if true == PaGlobal_DeadMessage_All._ui.btn_useFairyCheck:GetShow() then
      checkButtonAreaSizeY = checkButtonAreaSizeY + checkButtonSizeY
    end
    local buttonSizeY = PaGlobal_DeadMessage_All._ui.btn_smallTemplate:GetSizeY()
    PaGlobal_DeadMessage_All._ui.stc_resurrectionBG:SetSize(PaGlobal_DeadMessage_All._ui.stc_resurrectionBG:GetSizeX(), checkButtonAreaSizeY + (buttonSizeY + 10) * #buttonArray + 20)
    local screenGap = PaGlobal_DeadMessage_All._ui.stc_resurrectionBG:GetPosY() + PaGlobal_DeadMessage_All._ui.stc_resurrectionBG:GetSizeY() - getScreenSizeY()
    if 0 < screenGap then
      PaGlobal_DeadMessage_All._ui.stc_resurrectionBG:SetPosY(PaGlobal_DeadMessage_All._ui.stc_resurrectionBG:GetPosY() - screenGap)
    end
  end
end
function FromClient_DeadMessage_All_SetDeadMessage(attackerActorKeyRaw, isSkipDeathPenalty, isHasRestoreExp, isAblePvPMatchRevive, respawnTime)
  if nil == Panel_Window_DeadMessage_All then
    return
  end
  PaGlobal_DeadMessage_All:resetData()
  PaGlobal_DeadMessage_All:closeChannelMoveWindow()
  close_attacked_WindowPanelList(true)
  SetUIMode(Defines.UIMode.eUIMode_DeadMessage)
  PaGlobal_DeadMessage_All._attackerActorKeyRaw = attackerActorKeyRaw
  PaGlobal_DeadMessage_All._isSkipDeathPenalty = isSkipDeathPenalty
  PaGlobal_DeadMessage_All._isHasResotreExp = isHasRestoreExp
  PaGlobal_DeadMessage_All._isAblePvPMatchRevive = isAblePvPMatchRevive
  PaGlobal_DeadMessage_All._currentDeadType = PaGlobal_DeadMessage_All:getDeadType()
  PaGlobal_DeadMessage_All:setResurrectionTime(respawnTime)
  PaGlobal_DeadMessage_All:setRespawnButton()
  PaGlobal_DeadMessage_All:showDeadMessage(attackerActorKeyRaw, isSkipDeathPenalty)
end
function FromClient_DeadMessage_All_AddDropItem(itemName, count, enchantLevel, dropType)
  PaGlobal_DeadMessage_All._currentPaneltyStringCount = PaGlobal_DeadMessage_All._currentPaneltyStringCount + 1
  local strDropType = PAGetString(Defines.StringSheet_GAME, "LUA_DEADMESSAGE_DRIPTYPE1")
  if 1 == dropType then
    strDropType = PAGetString(Defines.StringSheet_GAME, "LUA_DEADMESSAGE_DRIPTYPE2")
  end
  local dropString = ""
  if 0 ~= enchantLevel then
    dropString = "+" .. enchantLevel .. " " .. itemName .. "[" .. count .. "]" .. " (" .. strDropType .. ")"
  else
    dropString = itemName .. "[" .. count .. "]" .. " (" .. strDropType .. ")"
  end
  PaGlobal_DeadMessage_All._PaneltyString[PaGlobal_DeadMessage_All._currentPaneltyStringCount] = dropString
  PaGlobal_DeadMessage_All._PaneltyColor[PaGlobal_DeadMessage_All._currentPaneltyStringCount] = PaGlobal_DeadMessage_All._paneltyColor.RED
end
function FromClient_DeadMessage_All_WeakEquip(slotNo)
  PaGlobal_DeadMessage_All._currentPaneltyStringCount = PaGlobal_DeadMessage_All._currentPaneltyStringCount + 1
  PaGlobal_DeadMessage_All._PaneltyString[PaGlobal_DeadMessage_All._currentPaneltyStringCount] = PAGetStringParam1(Defines.StringSheet_GAME, "DEADMESSAGE_TEXT_DownEnchantMsg", "enchantDownSlot", CppEnums.EquipSlotNoString[slotNo])
  PaGlobal_DeadMessage_All._PaneltyColor[PaGlobal_DeadMessage_All._currentPaneltyStringCount] = PaGlobal_DeadMessage_All._paneltyColor.BLUE
end
function FromClient_DeadMessage_All_WeakEquipCantPushInventory(notify)
  PaGlobal_DeadMessage_All._currentPaneltyStringCount = PaGlobal_DeadMessage_All._currentPaneltyStringCount + 1
  PaGlobal_DeadMessage_All._PaneltyString[PaGlobal_DeadMessage_All._currentPaneltyStringCount] = notify
  PaGlobal_DeadMessage_All._PaneltyColor[PaGlobal_DeadMessage_All._currentPaneltyStringCount] = PaGlobal_DeadMessage_All._paneltyColor.BLUE
end
function FromClient_DeadMessage_All_DestroyJewel(destoryJewel01, destoryJewel02, destoryJewel03, destoryJewel04, destoryJewel05)
  local jewelKey = {
    [0] = destoryJewel01,
    [1] = destoryJewel02,
    [2] = destoryJewel03,
    [3] = destoryJewel04,
    [4] = destoryJewel05
  }
  local jewelName = ""
  for idx = 0, #jewelKey do
    if nil ~= jewelKey[idx] and 0 ~= jewelKey[idx] then
      jewelName = getItemEnchantStaticStatus(ItemEnchantKey(jewelKey[idx])):getName()
      PaGlobal_DeadMessage_All._currentPaneltyStringCount = PaGlobal_DeadMessage_All._currentPaneltyStringCount + 1
      PaGlobal_DeadMessage_All._PaneltyString[PaGlobal_DeadMessage_All._currentPaneltyStringCount] = PAGetString(Defines.StringSheet_GAME, "LUA_DEADMESSAGE_JEWELDESTROYED") .. " " .. jewelName
      PaGlobal_DeadMessage_All._PaneltyColor[PaGlobal_DeadMessage_All._currentPaneltyStringCount] = PaGlobal_DeadMessage_All._paneltyColor.RED
    end
  end
end
function FromClient_DeadMessage_All_NotifySiegeShowWatchPanel(isShow)
  if true == ToClient_IsPlayingReplay() or true == ToClient_IsReplayStreamingMode() then
    return
  end
  if true == PaGlobal_DeadMessage_All._isConsole then
    if true == isShow then
      ToClient_CanOpenGuildBattleCam(isShow)
      PaGlobalFunc_ConsoleKeyGuide_SetGuide(Defines.ConsoleKeyGuideType.observeMode)
    else
      local currentTime = getTickCount32()
      if nil ~= PaGlobal_DeadMessage_All._tempButtonAbleTimeForGuildObserver then
        PaGlobal_DeadMessage_All._tempButtonAbleTimeForGuildObserver = PaGlobal_DeadMessage_All._tempButtonAbleTimeForGuildObserver - (currentTime - PaGlobal_DeadMessage_All._startTimeForGuildObserver)
        PaGlobal_DeadMessage_All._buttonAbleTime = PaGlobal_DeadMessage_All._tempButtonAbleTimeForGuildObserver
        if false == PaGlobal_DeadMessage_All._isButtonWaitTimeEnd then
          PaGlobal_DeadMessage_All._resurrectionTime = PaGlobal_DeadMessage_All._tempButtonAbleTimeForGuildObserver
        end
        PaGlobal_DeadMessage_All._tempButtonAbleTimeForGuildObserver = nil
      end
      ToClient_CanOpenGuildBattleCam(isShow)
      PaGlobalFunc_ConsoleKeyGuide_PopGuide()
      Panel_Window_DeadMessage_All:SetShow(true)
    end
  else
    if false == isShowGuildBattleCam then
      ToClient_CanOpenGuildBattleCam(false)
      return
    end
    if false == Panel_GuildBattleWatchingMode:GetShow() and true == isShow then
      WatchingPanel_SetPosition()
      PaGlobal_GuildBattle_WatchModeStringSetting()
      GuildWatchMode.UI_BG:SetShow(isShow)
      GuildWatchMode.UI_KeyQ:SetShow(isShow)
      GuildWatchMode.UI_KeyE:SetShow(isShow)
      GuildWatchMode.UI_KeyR:SetShow(isShow)
      GuildWatchMode.UI_TextSmall:SetShow(isShow)
      GuildWatchMode.UI_TextBig:SetShow(isShow)
      GuildWatchMode.UI_TextExit:SetShow(isShow)
      GuildWatchMode.UI_TextDesc:SetShow(isShow)
      GuildWatchMode.UI_ShowButton:SetCheck(isShow)
      GuildWatchMode.UI_RemainTime:SetShow(isShow)
      Panel_GuildBattleWatchingMode:SetShow(isShow)
      ToClient_CanOpenGuildBattleCam(isShow)
      GuildWatchMode._isSeigeWatching = true
      GuildWatchMode._remainTime = PaGlobal_DeadMessage_All._tempButtonAbleTimeForGuildObserver
    end
    if false == isShow then
      local currentTime = os.time()
      if nil ~= PaGlobal_DeadMessage_All._tempButtonAbleTimeForGuildObserver then
        PaGlobal_DeadMessage_All._tempButtonAbleTimeForGuildObserver = PaGlobal_DeadMessage_All._tempButtonAbleTimeForGuildObserver - (currentTime - PaGlobal_DeadMessage_All._startTimeForGuildObserver)
        PaGlobal_DeadMessage_All._buttonAbleTime = PaGlobal_DeadMessage_All._tempButtonAbleTimeForGuildObserver
        if false == PaGlobal_DeadMessage_All._isButtonWaitTimeEnd then
          PaGlobal_DeadMessage_All._resurrectionTime = PaGlobal_DeadMessage_All._tempButtonAbleTimeForGuildObserver
        end
        PaGlobal_DeadMessage_All._tempButtonAbleTimeForGuildObserver = nil
      end
      GuildWatchMode._isSeigeWatching = false
      GuildWatchMode._remainTime = -1
      GuildWatchMode.UI_BG:SetShow(isShow)
      GuildWatchMode.UI_KeyQ:SetShow(isShow)
      GuildWatchMode.UI_KeyE:SetShow(isShow)
      GuildWatchMode.UI_KeyR:SetShow(isShow)
      GuildWatchMode.UI_TextSmall:SetShow(isShow)
      GuildWatchMode.UI_TextBig:SetShow(isShow)
      GuildWatchMode.UI_TextExit:SetShow(isShow)
      GuildWatchMode.UI_TextDesc:SetShow(isShow)
      GuildWatchMode.UI_ShowButton:SetCheck(isShow)
      GuildWatchMode.UI_RemainTime:SetShow(isShow)
      Panel_GuildBattleWatchingMode:SetShow(isShow)
      ToClient_CanOpenGuildBattleCam(isShow)
      Panel_Window_DeadMessage_All:SetShow(true)
    end
  end
end
function HandleEventOnOut_DeadMessage_All_ShowPKTooltip(isShow)
  if not isShow then
    TooltipSimple_Hide()
    return
  end
  local name, desc, control
  name = PAGetString(Defines.StringSheet_GAME, "LUA_DEADMESSAGE_PK_PENALTY_TOOLTIP_TITLE")
  if isGameTypeKorea() or isGameTypeJapan() then
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_DEADMESSAGE_PK_PENALTY_TOOLTIP_DESC")
  else
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_DEADMESSAGE_PK_PENALTY_TOOLTIP_DESC_OTHER")
  end
  control = PaGlobal_DeadMessage_All._ui.btn_noticeIcon
  TooltipSimple_Show(control, name, desc)
end
function HandleEventLUp_DeadMessage_All_SetCheckBox(useItem)
  if true == useItem then
    if nil ~= PaGlobal_DeadMessage_All._ui.btn_useFairyCheck then
      PaGlobal_DeadMessage_All._ui.btn_useFairyCheck:SetCheck(false)
    end
  elseif nil ~= PaGlobal_DeadMessage_All._ui.btn_useItemCheck then
    PaGlobal_DeadMessage_All._ui.btn_useItemCheck:SetCheck(false)
  end
end
function HandleEventOnOut_DeadMessage_All_UseItemTooltip(isShow, type)
  if false == isShow or nil == type then
    TooltipSimple_Hide()
    return
  end
  local uiControl, name, desc
  name = PAGetString(Defines.StringSheet_GAME, "LUA_DEADMESSAGE_TOOLTIP_NAME")
  if 0 == type then
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_DEADMESSAGE_TOOLTIP_DESC")
    uiControl = PaGlobal_DeadMessage_All._ui.btn_useItemCheck
  else
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_DEADMESSAGE_TOOLTIP_FAIRY_DESC")
    uiControl = PaGlobal_DeadMessage_All._ui.btn_useFairyCheck
  end
  if nil == uiControl then
    UI.ASSERT(false, "uiControl is nil")
    return
  end
  TooltipSimple_Show(uiControl, name, desc)
  if true == PaGlobal_DeadMessage_All._isConsole then
    PaGlobal_DeadMessage_All._ui.btn_selectButton_console:SetPosY(uiControl:GetPosY() - 15)
  end
end
function PaGlobalFunc_DeadMessage_All_ListControlCreate(control, key)
  local key_32 = Int64toInt32(key)
  local redText = UI.getChildControl(control, "StaticText_ItemList")
  local blueText = UI.getChildControl(control, "StaticText_ItemList2")
  if true == PaGlobal_DeadMessage_All._isSkipDeathPenalty and 1 == key_32 then
    if true == isGameTypeKorea() and false == PaGlobal_DeadMessage_All._isConsole then
      blueText:SetText(PAGetString(Defines.StringSheet_GAME, "DEADMESSAGE_TEXT_NoDeathPenalty"))
    else
      blueText:SetText(PAGetString(Defines.StringSheet_GAME, "DEADMESSAGE_TEXT_NoDeathPenalty_OTHER"))
    end
    blueText:SetShow(true)
    redText:SetShow(false)
    PaGlobal_DeadMessage_All._isSkipDeathPenalty = false
  elseif PaGlobal_DeadMessage_All._paneltyColor.RED == PaGlobal_DeadMessage_All._PaneltyColor[key_32] then
    redText:SetText(PaGlobal_DeadMessage_All._PaneltyString[key_32])
    redText:SetShow(true)
    blueText:SetShow(false)
  elseif PaGlobal_DeadMessage_All._paneltyColor.BLUE == PaGlobal_DeadMessage_All._PaneltyColor[key_32] then
    blueText:SetText(PaGlobal_DeadMessage_All._PaneltyString[key_32])
    blueText:SetShow(true)
    redText:SetShow(false)
  else
    redText:SetShow(false)
    blueText:SetShow(false)
  end
end
function PaGlobalFunc_DeadMessage_All_ButtonPushEvent_Immediate()
  local revivalItemCount = ToClient_InventorySizeByProductCategory(CppEnums.ItemWhereType.eCashInventory, CppEnums.ItemProductCategory.eItemProductCategory_Revival)
  local selfProxy = getSelfPlayer()
  if nil == selfProxy then
    return
  end
  local regionInfo = getRegionInfoByPosition(selfProxy:get():getPosition())
  local isArena = regionInfo:get():isArenaArea()
  local isCompetition = selfProxy:get():isCompetitionDefined()
  local isGuildBattle = ToClient_getJoinGuildBattle()
  local useItem = PaGlobal_DeadMessage_All._ui.btn_useItemCheck:IsCheck()
  local useFairy = PaGlobal_DeadMessage_All._ui.btn_useFairyCheck:IsCheck()
  local freeRevivalLevel = FromClient_getFreeRevivalLevel()
  local isFreeArea = regionInfo:get():isFreeRevivalArea()
  if true == isGuildBattle or true == isArena or isFreeArea and freeRevivalLevel >= selfProxy:get():getLevel() then
    deadMessage_Revival(PaGlobal_DeadMessage_All._eRespawnType.respawnType_Immediate, 0, CppEnums.ItemWhereType.eCashInventory, getSelfPlayer():getRegionKey(), false, toInt64(0, 0))
  elseif true == PaGlobal_DeadMessage_All._isAblePvPMatchRevive or true == isCompetition then
    deadMessage_Revival(PaGlobal_DeadMessage_All._eRespawnType.respawnType_Immediate, 0, CppEnums.ItemWhereType.eCashInventory, getSelfPlayer():getRegionKey(), PaGlobal_DeadMessage_All._isAblePvPMatchRevive, toInt64(0, 0))
  elseif true == useFairy then
    PaGlobal_DeadMessage_All:useCheckFairy(PaGlobal_DeadMessage_All._eRespawnType.respawnType_Immediate)
  elseif 1 == revivalItemCount then
    HandleEventLUp_Cash_Revival_BuyItem_All_Apply_CashRevivalItem(PaGlobal_DeadMessage_All._eRespawnType.respawnType_Immediate)
  elseif 1 < revivalItemCount then
    PaGlobal_Cash_Revival_BuyItem_All_Open(PaGlobal_DeadMessage_All._eRespawnType.respawnType_Immediate)
  else
    HandleEventLUp_Cash_Revival_BuyItem_All_Buy_CashRevivalItem(PaGlobal_DeadMessage_All._eRespawnType.respawnType_Immediate)
  end
  FGlobal_ImmediatelyResurrection(selfProxy:get():getMaxHp())
end
function PaGlobalFunc_DeadMessage_All_ButtonPushEvent_Exploration()
  local selfProxy = getSelfPlayer()
  if nil == selfProxy then
    return
  end
  local regionInfo = getRegionInfoByPosition(selfProxy:get():getPosition())
  local linkedSiegeRegionInfoWrapper = ToClient_getVillageSiegeRegionInfoWrapperByPosition(selfProxy:get():getPosition())
  local isVillageWarZone = linkedSiegeRegionInfoWrapper:get():isVillageWarZone()
  local isKingOrLordWarZone = regionInfo:get():isKingOrLordWarZone()
  local isSiegeBeing = deadMessage_isSiegeBeingInCurrentPosition()
  local prevExp = selfProxy:get():getPrevExp_s64()
  local currentExp = selfProxy:get():getExp_s64()
  local isArena = regionInfo:get():isArenaArea()
  local useItem = PaGlobal_DeadMessage_All._ui.btn_useItemCheck:IsCheck()
  local useFairy = PaGlobal_DeadMessage_All._ui.btn_useFairyCheck:IsCheck()
  if true == useItem and false == isArena and (true == PaGlobal_DeadMessage_All._isHasResotreExp or prevExp > currentExp) then
    PaGlobal_DeadMessage_All:respawnWithCashItem(PaGlobal_DeadMessage_All._eRespawnType.respawnType_Exploration)
    return
  end
  local contentString = PAGetString(Defines.StringSheet_GAME, "DEADMESSAGE_TEXT_RESPAWN_TO_EXPLORE")
  if isSiegeBeing and (true == isKingOrLordWarZone or true == isVillageWarZone) then
  else
    if (PaGlobal_DeadMessage_All._isHasResotreExp or prevExp > currentExp) and false == useFairy then
      contentString = contentString .. "\n" .. PAGetString(Defines.StringSheet_GAME, "DEADMESSAGE_TEXT_EXP_DOWN")
    else
    end
    if ToClient_IsOpendDesertPK() and true == isBadPlayer and 0 ~= regionInfo:getVillainRespawnWaypointKey() then
      contentString = contentString .. "\n" .. PAGetString(Defines.StringSheet_GAME, "DEADMESSAGE_TEXT_BadPlayerMoveVillage")
    end
  end
  local revivalExplorationConfirm = function()
    deadMessage_Revival(PaGlobal_DeadMessage_All._eRespawnType.respawnType_Exploration, 255, 0, getSelfPlayer():getRegionKey(), false, toInt64(0, 0), PaGlobal_DeadMessage_All._ui.btn_useFairyCheck:IsCheck())
  end
  local messageboxData = {
    title = PAGetString(Defines.StringSheet_GAME, "DEADMESSAGE_TEXT_RESPAWN_MB_TITLE"),
    content = contentString,
    functionYes = revivalExplorationConfirm,
    functionCancel = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_1
  }
  MessageBox.showMessageBox(messageboxData)
end
function PaGlobalFunc_DeadMessage_All_ButtonPushEvent_NearTown()
  local selfProxy = getSelfPlayer()
  if nil == selfProxy then
    return
  end
  local regionInfo = getRegionInfoByPosition(selfProxy:get():getPosition())
  local linkedSiegeRegionInfoWrapper = ToClient_getVillageSiegeRegionInfoWrapperByPosition(selfProxy:get():getPosition())
  local isVillageWarZone = linkedSiegeRegionInfoWrapper:get():isVillageWarZone()
  local isKingOrLordWarZone = regionInfo:get():isKingOrLordWarZone()
  local isSiegeBeing = deadMessage_isSiegeBeingInCurrentPosition()
  local prevExp = selfProxy:get():getPrevExp_s64()
  local currentExp = selfProxy:get():getExp_s64()
  local isArena = regionInfo:get():isArenaArea()
  local useItem = PaGlobal_DeadMessage_All._ui.btn_useItemCheck:IsCheck()
  local useFairy = PaGlobal_DeadMessage_All._ui.btn_useFairyCheck:IsCheck()
  if true == useItem and false == isArena and (true == PaGlobal_DeadMessage_All._isHasResotreExp or prevExp > currentExp) then
    PaGlobal_DeadMessage_All:respawnWithCashItem(PaGlobal_DeadMessage_All._eRespawnType.respawnType_NearTown)
    return
  end
  local isBadPlayer = selfProxy:get():getTendency() < 0
  local contentString = PAGetString(Defines.StringSheet_GAME, "DEADMESSAGE_TEXT_RESPAWN_TO_VILLAGE")
  if isSiegeBeing and (true == isKingOrLordWarZone or true == isVillageWarZone) then
  else
    if (PaGlobal_DeadMessage_All._isHasResotreExp or prevExp > currentExp) and false == useFairy then
      contentString = contentString .. "\n" .. PAGetString(Defines.StringSheet_GAME, "DEADMESSAGE_TEXT_EXP_DOWN")
    else
    end
    if ToClient_IsOpendDesertPK() and true == isBadPlayer and 0 ~= regionInfo:getVillainRespawnWaypointKey() then
      contentString = contentString .. "\n" .. PAGetString(Defines.StringSheet_GAME, "DEADMESSAGE_TEXT_BadPlayerMoveVillage")
    end
  end
  local revivalVillageConfirm = function()
    deadMessage_Revival(PaGlobal_DeadMessage_All._eRespawnType.respawnType_NearTown, 255, 0, getSelfPlayer():getRegionKey(), false, toInt64(0, 0), PaGlobal_DeadMessage_All._ui.btn_useFairyCheck:IsCheck())
  end
  local messageboxData = {
    title = PAGetString(Defines.StringSheet_GAME, "DEADMESSAGE_TEXT_RESPAWN_MB_TITLE"),
    content = contentString,
    functionYes = revivalVillageConfirm,
    functionCancel = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_1
  }
  MessageBox.showMessageBox(messageboxData)
end
function PaGlobalFunc_DeadMessage_All_ButtonPushEvent_InSiegeingFortress()
  local buildingRegionKey = 0
  local currentBuildInfo = ToClient_getCurrentBuildingInfo()
  if nil == currentBuildInfo then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "DEADMESSAGE_TEXT_NOSIEGEBUILDING"))
    return
  end
  if ToClient_IsVillageSiegeBeing() then
    buildingRegionKey = currentBuildInfo:getBuildingRegionKey()
  else
    buildingRegionKey = currentBuildInfo:getAffiliatedRegionKey()
  end
  deadMessage_Revival(PaGlobal_DeadMessage_All._eRespawnType.respawnType_InSiegeingFortress, 255, 0, buildingRegionKey, false, toInt64(0, 0))
end
function PaGlobalFunc_DeadMessage_All_ButtonPushEvent_LocalWar()
  deadMessage_Revival(PaGlobal_DeadMessage_All._eRespawnType.respawnType_LocalWar, 255, 0, getSelfPlayer():getRegionKey(), false, toInt64(0, 0))
  if nil ~= PaGlobal_FadeOutOpen then
    PaGlobal_FadeOutOpen()
  end
end
function PaGlobalFunc_DeadMessage_All_ButtonPushEvent_AdvancedBase()
  deadMessage_Revival(PaGlobal_DeadMessage_All._eRespawnType.respawnType_AdvancedBase, 255, 0, getSelfPlayer():getRegionKey(), false, toInt64(0, 0))
end
function PaGlobalFunc_DeadMessage_All_ButtonPushEvent_GuildSpawn()
  local selfProxy = getSelfPlayer()
  if nil == selfProxy then
    return
  end
  local regionInfo = getRegionInfoByPosition(selfProxy:get():getPosition())
  local linkedSiegeRegionInfoWrapper = ToClient_getVillageSiegeRegionInfoWrapperByPosition(selfProxy:get():getPosition())
  local isVillageWarZone = linkedSiegeRegionInfoWrapper:get():isVillageWarZone()
  local isKingOrLordWarZone = regionInfo:get():isKingOrLordWarZone()
  local isSiegeBeing = deadMessage_isSiegeBeingInCurrentPosition()
  local prevExp = selfProxy:get():getPrevExp_s64()
  local currentExp = selfProxy:get():getExp_s64()
  local isArena = regionInfo:get():isArenaArea()
  local useItem = PaGlobal_DeadMessage_All._ui.btn_useItemCheck:IsCheck()
  if true == useItem and false == isArena and (true == PaGlobal_DeadMessage_All._isHasResotreExp or prevExp > currentExp) then
    PaGlobal_DeadMessage_All:respawnWithCashItem(PaGlobal_DeadMessage_All._eRespawnType.respawnType_GuildSpawn)
    return
  end
  local contentString = PAGetString(Defines.StringSheet_GAME, "DEADMESSAGE_TEXT_RESPAWN_GUILDSPAWN")
  if isSiegeBeing and (true == isKingOrLordWarZone or true == isVillageWarZone) then
  else
    if true == PaGlobal_DeadMessage_All._isHasResotreExp or prevExp > currentExp then
      contentString = contentString .. "\n" .. PAGetString(Defines.StringSheet_GAME, "DEADMESSAGE_TEXT_EXP_DOWN")
    else
    end
  end
  local revivalGuildSpawnConfirm = function()
    local servantNo = 0
    local guildServantCount = guildServant_count()
    local selfPosition = getSelfPlayer():get():getPosition()
    local distance = 99999999
    for index = 0, guildServantCount do
      local servantInfo = guildStable_getServantByOrder(index)
      if nil ~= servantInfo then
        local giantActorPosition = getGiantActorPosition(servantInfo:getActorKeyRaw())
        if nil ~= giantActorPosition then
          local shipToPlayerDistance = Util.Math.calculateDistance(giantActorPosition, selfPosition)
          if distance > shipToPlayerDistance then
            distance = shipToPlayerDistance
            servantNo = servantInfo:getServantNo()
          end
        end
      end
    end
    if 0 == servantNo then
      return
    end
    deadMessage_Revival(PaGlobal_DeadMessage_All._eRespawnType.respawnType_GuildSpawn, 255, 0, getSelfPlayer():getRegionKey(), false, servantNo)
  end
  local messageboxData = {
    title = PAGetString(Defines.StringSheet_GAME, "DEADMESSAGE_TEXT_RESPAWN_MB_TITLE"),
    content = contentString,
    functionYes = revivalGuildSpawnConfirm,
    functionCancel = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_1
  }
  MessageBox.showMessageBox(messageboxData)
end
function PaGlobalFunc_DeadMessage_All_ButtonPushEvent_SavageDefence()
  local executeSavageDefenceOut = function()
    ToClient_SavageDefenceUnJoin()
  end
  local contentString = PAGetString(Defines.StringSheet_GAME, "LUA_DEADMESSAGE_SAVAGEDEAD")
  local messageBoxData = {
    title = PAGetString(Defines.StringSheet_GAME, "LUA_WARNING"),
    content = contentString,
    functionYes = executeSavageDefenceOut,
    functionNo = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageBoxData)
end
function PaGlobalFunc_DeadMessage_All_ButtonPushEvent_Volunteer()
  deadMessage_Revival(PaGlobal_DeadMessage_All._eRespawnType.respawnType_Volunteer, 255, 0, getSelfPlayer():getRegionKey(), false, toInt64(0, 0))
end
function PaGlobalFunc_DeadMessage_All_ButtonPushEvent_Plunder()
  deadMessage_Revival(PaGlobal_DeadMessage_All._eRespawnType.respawnType_Plunder, 255, 0, getSelfPlayer():getRegionKey(), false, toInt64(0, 0))
end
function PaGlobalFunc_DeadMessage_All_ButtonPushEvent_GuildTeamBattle()
  local selfProxy = getSelfPlayer()
  if nil == selfProxy then
    return
  end
  deadMessage_Revival(PaGlobal_DeadMessage_All._eRespawnType.respawnType_GuildTeamBattle, 0, CppEnums.ItemWhereType.eCashInventory, getSelfPlayer():getRegionKey(), false, toInt64(0, 0))
  FGlobal_ImmediatelyResurrection(selfProxy:get():getMaxHp())
end
function PaGlobalFunc_DeadMessage_All_ButtonPushEvent_OutsideGate()
  deadMessage_Revival(PaGlobal_DeadMessage_All._eRespawnType.respawnType_OutsideGate, 255, 0, getSelfPlayer():getRegionKey(), false, toInt64(0, 0))
end
function PaGlobalFunc_DeadMessage_All_ButtonPushEvent_InsideGate()
  deadMessage_Revival(PaGlobal_DeadMessage_All._eRespawnType.respawnType_InsideGate, 255, 0, getSelfPlayer():getRegionKey(), false, toInt64(0, 0))
end
function PaGlobalFunc_DeadMessage_All_ButtonPushEvent_Observer()
  PaGlobal_DeadMessage_All:close()
  PaGlobal_DeadMessage_All._isObserverMode = true
  observerCameraModeStart()
  if true == ToClient_isBeingNationSiege() then
    ToClient_FirstPersonOpserverModeInNationSiege(false)
  end
  local selfProxy = getSelfPlayer()
  if nil == selfProxy then
    return
  end
  if false == ToClient_getJoinGuildBattle() and false == ToClient_getPlayNowSavageDefence() and false == ToClient_IsSelfInGuildTeamBattle() and false == ToClient_IsInstanceFieldPlayerbyContentsType(__eInstanceContentsType_SavageDefence) and false == selfProxy:get():isCompetitionDefined() then
    ShowCommandFunc(PaGlobal_DeadMessage_All._resurrectionTime)
  else
    ShowCommandFunc(nil)
  end
end
function PaGlobalFunc_DeadMessage_All_ButtonPushEvent_GuildObserverMode()
  PaGlobal_DeadMessage_All:close()
  PaGlobal_DeadMessage_All._isObserverMode = true
  if true == ToClient_isBeingNationSiege() then
    ToClient_FirstPersonOpserverModeInNationSiege(true)
  else
    ToClient_FirstPersonOpserverModeInSiege(true)
  end
  PaGlobal_DeadMessage_All._tempButtonAbleTimeForGuildObserver = PaGlobal_DeadMessage_All._buttonAbleTime
  if true == PaGlobal_DeadMessage_All._isConsole then
    PaGlobal_DeadMessage_All._startTimeForGuildObserver = getTickCount32()
  else
    PaGlobal_DeadMessage_All._startTimeForGuildObserver = os.time()
  end
end
function PaGlobalFunc_DeadMessage_All_ButtonPushEvent_NationSiege_BlackSpirit()
  deadMessage_Revival(PaGlobal_DeadMessage_All._eRespawnType.respawnType_NationSiege_BlackSpirit, 255, 0, getSelfPlayer():getRegionKey(), false, toInt64(0, 0))
end
function FromClient_VaryRespawnTime(varyRespawnTime)
  local message = PAGetString(Defines.StringSheet_GAME, "LUA_USE_REDUCE_RESPAWN_COOLTIME_SKILL")
  if nil ~= PaGlobal_DeadMessage_All._ui.txt_GuildSkillApply then
    PaGlobal_DeadMessage_All._ui.txt_GuildSkillApply:SetText(message)
    PaGlobal_DeadMessage_All._ui.txt_GuildSkillApply:SetShow(true)
  end
  local respawnTime = Uint64toUint32(varyRespawnTime / 1000)
  PaGlobal_DeadMessage_All._buttonWaitTime = respawnTime
  PaGlobal_DeadMessage_All._isUseButtonAbleTime = true
  if 0 == respawnTime then
    if (PaGlobal_DeadMessage_All._eDeadType.DeadLocate_InSiegeBattle == PaGlobal_DeadMessage_All._currentDeadType or PaGlobal_DeadMessage_All._eDeadType.DeadLocate_InMajorSiegeBattle == PaGlobal_DeadMessage_All._currentDeadType) and false == PaGlobal_DeadMessage_All._isButtonWaitTimeEnd then
      PaGlobal_DeadMessage_All._isButtonWaitTimeEnd = true
      PaGlobal_DeadMessage_All._resurrectionTime = PaGlobal_DeadMessage_All._revivalTime
      PaGlobalFunc_DeadMessage_All_HideObserverButton()
    end
  else
    PaGlobal_DeadMessage_All._resurrectionTime = respawnTime
  end
  PaGlobal_DeadMessage_All._buttonAbleTime = respawnTime
  if true == PaGlobal_DeadMessage_All._isObserverMode then
    if nil ~= GuildWatchMode and nil ~= GuildWatchMode.UI_BG and true == GuildWatchMode.UI_BG:GetShow() then
      GuildWatchMode._remainTime = respawnTime
    end
    if nil ~= Panel_WatchingMode and true == Panel_WatchingMode:GetShow() then
      ShowCommandFunc(0)
    end
  end
end
