function PaGlobal_DeadMessage_All:initialize()
  if nil == Panel_Window_DeadMessage_All or true == PaGlobal_DeadMessage_All._initialize then
    return
  end
  PaGlobal_DeadMessage_All._isConsole = _ContentsGroup_UsePadSnapping
  PaGlobal_DeadMessage_All:controlInit()
  PaGlobal_DeadMessage_All:controlCreate()
  PaGlobal_DeadMessage_All:setConsole()
  PaGlobal_DeadMessage_All:setData()
  PaGlobal_DeadMessage_All:registerEventHandler()
  PaGlobal_DeadMessage_All:validate()
  PaGlobal_DeadMessage_All._initialize = true
end
function PaGlobal_DeadMessage_All:controlInit()
  PaGlobal_DeadMessage_All._ui.stc_circleBG = UI.getChildControl(Panel_Window_DeadMessage_All, "Static_CircleBG")
  PaGlobal_DeadMessage_All._ui.stc_centerBG = UI.getChildControl(Panel_Window_DeadMessage_All, "Static_CenterBG")
  PaGlobal_DeadMessage_All._ui.txt_deathTitle = UI.getChildControl(PaGlobal_DeadMessage_All._ui.stc_centerBG, "StaticText_DeathTitle")
  PaGlobal_DeadMessage_All._ui.txt_resurrectionTime = UI.getChildControl(PaGlobal_DeadMessage_All._ui.stc_centerBG, "StaticText_CountDown")
  PaGlobal_DeadMessage_All._ui.txt_GuildSkillApply = UI.getChildControl(PaGlobal_DeadMessage_All._ui.stc_centerBG, "StaticText_GuildSkillApply")
  PaGlobal_DeadMessage_All._ui.stc_lostItemBG = UI.getChildControl(Panel_Window_DeadMessage_All, "Static_LostItemListBG")
  PaGlobal_DeadMessage_All._ui.stc_lineTop = UI.getChildControl(PaGlobal_DeadMessage_All._ui.stc_lostItemBG, "Static_LineTop")
  PaGlobal_DeadMessage_All._ui.stc_lineBottom = UI.getChildControl(PaGlobal_DeadMessage_All._ui.stc_lostItemBG, "Static_LineBottom")
  PaGlobal_DeadMessage_All._ui.list2_lostItem = UI.getChildControl(PaGlobal_DeadMessage_All._ui.stc_lostItemBG, "List2_ItemList")
  PaGlobal_DeadMessage_All._ui.list2_content = UI.getChildControl(PaGlobal_DeadMessage_All._ui.list2_lostItem, "List2_1_Content")
  PaGlobal_DeadMessage_All._ui.stc_resurrectionBG = UI.getChildControl(Panel_Window_DeadMessage_All, "Static_ResurrectionBG")
  PaGlobal_DeadMessage_All._ui.btn_largeTemplate = UI.getChildControl(PaGlobal_DeadMessage_All._ui.stc_resurrectionBG, "Button_LargeButton")
  PaGlobal_DeadMessage_All._ui.btn_smallTemplate = UI.getChildControl(PaGlobal_DeadMessage_All._ui.stc_resurrectionBG, "Button_SmallButton")
  PaGlobal_DeadMessage_All._ui.btn_largeTemplate:SetShow(false)
  PaGlobal_DeadMessage_All._ui.btn_smallTemplate:SetShow(false)
  PaGlobal_DeadMessage_All._ui.btn_noticeIcon = UI.getChildControl(PaGlobal_DeadMessage_All._ui.stc_resurrectionBG, "Button_NoticeIcon")
  PaGlobal_DeadMessage_All._ui.btn_selectButton_console = UI.getChildControl(PaGlobal_DeadMessage_All._ui.stc_resurrectionBG, "Static_SelectButton_Console")
  PaGlobal_DeadMessage_All._ui.btn_useItemCheck = UI.getChildControl(PaGlobal_DeadMessage_All._ui.stc_resurrectionBG, "CheckButton_UseTears")
  PaGlobal_DeadMessage_All._ui.btn_useItemCheck:SetEnableArea(0, 0, PaGlobal_DeadMessage_All._ui.btn_useItemCheck:GetSizeX() + PaGlobal_DeadMessage_All._ui.btn_useItemCheck:GetTextSizeX(), PaGlobal_DeadMessage_All._ui.btn_useItemCheck:GetSizeY())
  PaGlobal_DeadMessage_All._ui.btn_useFairyCheck = UI.getChildControl(PaGlobal_DeadMessage_All._ui.stc_resurrectionBG, "CheckButton_UseFairy")
  PaGlobal_DeadMessage_All._ui.btn_useFairyCheck:SetEnableArea(0, 0, PaGlobal_DeadMessage_All._ui.btn_useFairyCheck:GetSizeX() + PaGlobal_DeadMessage_All._ui.btn_useFairyCheck:GetTextSizeX(), PaGlobal_DeadMessage_All._ui.btn_useFairyCheck:GetSizeY())
  PaGlobal_DeadMessage_All._ui.txt_siegeNotice = UI.getChildControl(Panel_Window_DeadMessage_All, "StaticText_ExcludMSG")
  PaGlobal_DeadMessage_All._ui.stc_paneltyBG = UI.getChildControl(Panel_Window_DeadMessage_All, "Static_PenaltyBG")
  PaGlobal_DeadMessage_All._ui.stc_paneltyTitle = UI.getChildControl(PaGlobal_DeadMessage_All._ui.stc_paneltyBG, "StaticText_PenaltyText1")
  PaGlobal_DeadMessage_All._ui.stc_paneltyDesc = UI.getChildControl(PaGlobal_DeadMessage_All._ui.stc_paneltyBG, "StaticText_PenaltyText2")
  PaGlobal_DeadMessage_All._ui.stc_paneltyBG:SetShow(false)
end
function PaGlobal_DeadMessage_All:controlCreate()
  FromClient_DeadMessage_All_OnScreenReSize()
  for index = 0, PaGlobal_DeadMessage_All._respawnButtonMaxCount - 1 do
    local respawnButton = UI.cloneControl(PaGlobal_DeadMessage_All._ui.btn_largeTemplate, PaGlobal_DeadMessage_All._ui.stc_resurrectionBG, "_respawn_Button_" .. index)
    respawnButton:ComputePos()
    respawnButton:SetIgnore(false)
    respawnButton:SetSize(respawnButton:GetSizeX(), PaGlobal_DeadMessage_All._ui.btn_smallTemplate:GetSizeY())
    respawnButton:SetPosY((respawnButton:GetSizeY() + 10) * index)
    respawnButton:SetShow(false)
    PaGlobal_DeadMessage_All._ui._button_Respawn[index] = respawnButton
  end
end
function PaGlobal_DeadMessage_All:setConsole()
  if true == PaGlobal_DeadMessage_All._isConsole then
    PaGlobal_DeadMessage_All._ui.btn_noticeIcon:SetShow(false)
    PaGlobal_DeadMessage_All._ui.btn_selectButton_console:SetShow(true)
    PaGlobal_DeadMessage_All._ui.stc_paneltyTitle:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_DEADMESSAGE_PK_PENALTY_TOOLTIP_TITLE"))
    PaGlobal_DeadMessage_All._ui.stc_paneltyDesc:SetTextMode(__eTextMode_AutoWrap)
    if isGameTypeKorea() or isGameTypeJapan() then
      PaGlobal_DeadMessage_All._ui.stc_paneltyDesc:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_DEADMESSAGE_PK_PENALTY_TOOLTIP_DESC"))
    else
      PaGlobal_DeadMessage_All._ui.stc_paneltyDesc:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_DEADMESSAGE_PK_PENALTY_TOOLTIP_DESC_OTHER"))
    end
    local sizeX = PaGlobal_DeadMessage_All._ui.stc_paneltyBG:GetSizeX()
    local sizeY = PaGlobal_DeadMessage_All._ui.stc_paneltyDesc:GetPosY() + PaGlobal_DeadMessage_All._ui.stc_paneltyDesc:GetTextSizeY() + 20
    PaGlobal_DeadMessage_All._ui.stc_paneltyBG:SetPosY(PaGlobal_DeadMessage_All._ui.stc_resurrectionBG:GetPosY())
    PaGlobal_DeadMessage_All._ui.stc_paneltyBG:SetPosX(PaGlobal_DeadMessage_All._ui.stc_resurrectionBG:GetPosX() - sizeX - 50)
    PaGlobal_DeadMessage_All._ui.stc_paneltyBG:SetSize(sizeX, sizeY)
  else
    PaGlobal_DeadMessage_All._ui.btn_noticeIcon:SetShow(true)
    PaGlobal_DeadMessage_All._ui.btn_selectButton_console:SetShow(false)
  end
end
function PaGlobal_DeadMessage_All:setData()
  PaGlobal_DeadMessage_All:setButtonString()
  PaGlobal_DeadMessage_All:setButtonList()
  PaGlobal_DeadMessage_All:setButtonEvent()
end
function PaGlobal_DeadMessage_All:registerEventHandler()
  if nil == Panel_Window_DeadMessage_All then
    return
  end
  PaGlobal_DeadMessage_All._ui.btn_noticeIcon:addInputEvent("Mouse_On", "HandleEventOnOut_DeadMessage_All_ShowPKTooltip(true)")
  PaGlobal_DeadMessage_All._ui.btn_noticeIcon:addInputEvent("Mouse_Out", "HandleEventOnOut_DeadMessage_All_ShowPKTooltip(false)")
  PaGlobal_DeadMessage_All._ui.btn_useItemCheck:addInputEvent("Mouse_LUp", "HandleEventLUp_DeadMessage_All_SetCheckBox(true)")
  PaGlobal_DeadMessage_All._ui.btn_useFairyCheck:addInputEvent("Mouse_LUp", "HandleEventLUp_DeadMessage_All_SetCheckBox(false)")
  PaGlobal_DeadMessage_All._ui.btn_useItemCheck:addInputEvent("Mouse_On", "HandleEventOnOut_DeadMessage_All_UseItemTooltip(true, 0)")
  PaGlobal_DeadMessage_All._ui.btn_useFairyCheck:addInputEvent("Mouse_On", "HandleEventOnOut_DeadMessage_All_UseItemTooltip(true, 1)")
  PaGlobal_DeadMessage_All._ui.btn_useItemCheck:addInputEvent("Mouse_Out", "HandleEventOnOut_DeadMessage_All_UseItemTooltip(false)")
  PaGlobal_DeadMessage_All._ui.btn_useFairyCheck:addInputEvent("Mouse_Out", "HandleEventOnOut_DeadMessage_All_UseItemTooltip(false)")
  PaGlobal_DeadMessage_All._ui.list2_lostItem:registEvent(__ePAUIList2EventType_LuaChangeContent, "PaGlobalFunc_DeadMessage_All_ListControlCreate")
  PaGlobal_DeadMessage_All._ui.list2_lostItem:createChildContent(__ePAUIList2ElementManagerType_List)
  registerEvent("onScreenResize", "FromClient_DeadMessage_All_OnScreenReSize")
  registerEvent("EventSelfPlayerDead", "FromClient_DeadMessage_All_SetDeadMessage")
  registerEvent("EventSelfPlayerRevive", "PaGlobalFunc_DeadMessage_All_Close")
  registerEvent("Event_DeadMessage_AddDropItem", "FromClient_DeadMessage_All_AddDropItem")
  registerEvent("Event_DeadMessage_WeakEquip", "FromClient_DeadMessage_All_WeakEquip")
  registerEvent("Event_DeadMessage_WeakEquipCantPushInventory", "FromClient_DeadMessage_All_WeakEquipCantPushInventory")
  registerEvent("Event_DeadMessage_DestroyJewel", "FromClient_DeadMessage_All_DestroyJewel")
  registerEvent("FromClient_NotifySiegeShowWatchPanel", "FromClient_DeadMessage_All_NotifySiegeShowWatchPanel")
  registerEvent("FromClient_VaryRespawnTime", "FromClient_VaryRespawnTime")
end
function PaGlobal_DeadMessage_All:prepareOpen()
  if true == ToClient_IsPlayingReplay() or true == ToClient_IsReplayStreamingMode() then
    return
  end
  if nil == Panel_Window_DeadMessage_All then
    return
  end
  SetUIMode(Defines.UIMode.eUIMode_DeadMessage)
  FromClient_DeadMessage_All_OnScreenReSize()
  PaGlobal_DeadMessage_All._isObserverMode = false
  PaGlobal_DeadMessage_All:open()
end
function PaGlobal_DeadMessage_All:open()
  if nil == Panel_Window_DeadMessage_All or true == Panel_Window_DeadMessage_All:GetShow() then
    return
  end
  Panel_Window_DeadMessage_All:SetShow(true)
end
function PaGlobal_DeadMessage_All:prepareClose()
  if nil == Panel_Window_DeadMessage_All or false == Panel_Window_DeadMessage_All:GetShow() then
    return
  end
  self._ui.txt_GuildSkillApply:SetShow(false)
  SetUIMode(Defines.UIMode.eUIMode_Default)
  _AudioPostEvent_SystemUiForXBOX(50, 3)
  PaGlobal_DeadMessage_All._currentPaneltyStringCount = 0
  PaGlobal_DeadMessage_All._ui.list2_lostItem:getElementManager():clearKey()
  HandleEventOnOut_DeadMessage_All_ShowPKTooltip()
  PaGlobal_DeadMessage_All:close()
end
function PaGlobal_DeadMessage_All:close()
  if nil == Panel_Window_DeadMessage_All or false == Panel_Window_DeadMessage_All:GetShow() then
    return
  end
  Panel_Window_DeadMessage_All:SetShow(false)
end
function PaGlobal_DeadMessage_All:setButtonString()
  local button = PaGlobal_DeadMessage_All._eButtonType
  local buttonString = PaGlobal_DeadMessage_All._ButtonString
  buttonString[button.Immediate] = "<PAColor0xFFB5FF6D>" .. PAGetString(Defines.StringSheet_RESOURCE, "DEADMESSAGE_BTN_IMMEDIATE") .. "<PAOldColor>"
  buttonString[button.Exploration] = PAGetString(Defines.StringSheet_RESOURCE, "DEADMESSAGE_BTN_MOVEEXPLORATION")
  buttonString[button.InSiegeingFortress] = PAGetString(Defines.StringSheet_RESOURCE, "DEADMESSAGE_BTN_SIEGEING")
  buttonString[button.NearTown] = PAGetString(Defines.StringSheet_RESOURCE, "DEADMESSAGE_BTN_MOVETOWN")
  buttonString[button.LocalWar] = PAGetString(Defines.StringSheet_RESOURCE, "DEADMESSAGE_BTN_LOCALWAR")
  buttonString[button.AdvancedBase] = "<PAColor0xFF6DC6FF>" .. PAGetString(Defines.StringSheet_RESOURCE, "DEADMESSAGE_BTN_ADVANCEDBASE") .. "<PAOldColor>"
  buttonString[button.GuildSpawn] = PAGetString(Defines.StringSheet_RESOURCE, "DEADMESSAGE_BTN_GUILDSPAWN")
  buttonString[button.Competition] = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_COMPETITIONGAME_PVP_EXIT")
  buttonString[button.SavageDefence] = PAGetString(Defines.StringSheet_GAME, "LUA_MENU_WAVE_OUT")
  buttonString[button.Volunteer] = PAGetString(Defines.StringSheet_RESOURCE, "DEADMESSAGE_BTN_VALUNTEER")
  buttonString[button.Plunder] = PAGetString(Defines.StringSheet_GAME, "LUA_DEADMESSAGE_IMMEDIATE_RESURRECTION")
  buttonString[button.GuildTeamBattle] = PAGetString(Defines.StringSheet_GAME, "LUA_DEADMESSAGE_IMMEDIATE_RESURRECTION")
  buttonString[button.OutsideGate] = PAGetString(Defines.StringSheet_RESOURCE, "DEADMESSAGE_OUTSIDEGATE_BUTTON")
  buttonString[button.InsideGate] = PAGetString(Defines.StringSheet_RESOURCE, "DEADMESSAGE_INSIDEGATE_BUTTON")
  buttonString[button.Observer] = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_DEADMESSAGE_WATCHINGMODE")
  buttonString[button.GuildObServerMode] = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_GUILDWATCH_BUTTON")
  buttonString[button.NationSiege_BlackSpirit] = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_DEADMESSAGE_BLACKSPIRITMODE_BUTTON")
end
function PaGlobal_DeadMessage_All:setButtonList()
  local buttonList = PaGlobal_DeadMessage_All._ButtonListByDeadType
  local button = PaGlobal_DeadMessage_All._eButtonType
  local deadType = PaGlobal_DeadMessage_All._eDeadType
  buttonList[deadType.Dead_Normal] = {
    [0] = button.Immediate,
    [1] = button.Exploration,
    [2] = button.NearTown,
    [3] = button.GuildSpawn,
    [4] = button.AdvancedBase
  }
  buttonList[deadType.DeadLocate_InPlunder] = {
    [0] = button.NearTown,
    [1] = button.Plunder,
    [2] = button.Observer
  }
  buttonList[deadType.DeadLocate_InBattleGround] = {
    [0] = button.Immediate
  }
  buttonList[deadType.DeadLocate_InCompetition] = {
    [0] = button.Immediate,
    [1] = button.Observer
  }
  buttonList[deadType.DeadLocate_InSavageDefence] = {
    [0] = button.Observer,
    [1] = button.SavageDefence
  }
  buttonList[deadType.DeadLocate_InGuildBattle] = {
    [0] = button.Immediate,
    [1] = button.Observer
  }
  buttonList[deadType.DeadLocate_InGuildTeamBattle] = {
    [0] = button.GuildTeamBattle
  }
  buttonList[deadType.DeadLocate_InPVP] = {
    [0] = button.Immediate
  }
  buttonList[deadType.DeadLocate_InLocarWar] = {
    [0] = button.LocalWar
  }
  buttonList[deadType.DeadLocate_InPrision] = {}
  buttonList[deadType.DeadLocate_InSiegeBeingChannel] = {
    [0] = button.Exploration,
    [1] = button.NearTown,
    [2] = button.Volunteer,
    [3] = button.GuildSpawn,
    [4] = button.AdvancedBase,
    [5] = button.Observer,
    [6] = button.GuildObServerMode
  }
  buttonList[deadType.DeadLocate_InSiegeBeingInCurrentPos] = {
    [0] = button.NearTown,
    [1] = button.Volunteer,
    [2] = button.GuildSpawn,
    [3] = button.AdvancedBase,
    [4] = button.Observer,
    [5] = button.GuildObServerMode
  }
  buttonList[deadType.DeadLocate_InSiegeBattle] = {
    [0] = button.Exploration,
    [1] = button.InSiegeingFortress,
    [2] = button.NearTown,
    [3] = button.Volunteer,
    [4] = button.GuildSpawn,
    [5] = button.AdvancedBase,
    [6] = button.Observer,
    [7] = button.GuildObServerMode
  }
  buttonList[deadType.DeadLocate_InMajorSiegeBattle] = {
    [0] = button.InSiegeingFortress,
    [1] = button.NearTown,
    [2] = button.OutsideGate,
    [3] = button.InsideGate,
    [4] = button.Volunteer,
    [5] = button.GuildSpawn,
    [6] = button.AdvancedBase,
    [7] = button.Observer,
    [8] = button.GuildObServerMode
  }
  buttonList[deadType.DeadLocate_InNoAccessArea] = {
    [0] = button.Exploration,
    [1] = button.NearTown,
    [2] = button.GuildSpawn,
    [3] = button.AdvancedBase
  }
  buttonList[deadType.IsSpecialCharacter] = {
    [0] = button.Immediate
  }
  buttonList[deadType.DeadLocate_InNationSiege] = {
    [0] = button.Observer,
    [1] = button.NationSiege_BlackSpirit,
    [2] = button.GuildSpawn,
    [3] = button.AdvancedBase
  }
  buttonList[deadType.DeadLocate_InBloodAltar] = {
    [0] = button.Observer
  }
end
function PaGlobal_DeadMessage_All:setButtonEvent()
  local buttonEvent = PaGlobal_DeadMessage_All._ButtonEvent
  local button = PaGlobal_DeadMessage_All._eButtonType
  buttonEvent[button.Immediate] = "PaGlobalFunc_DeadMessage_All_ButtonPushEvent_Immediate"
  buttonEvent[button.Exploration] = "PaGlobalFunc_DeadMessage_All_ButtonPushEvent_Exploration"
  buttonEvent[button.NearTown] = "PaGlobalFunc_DeadMessage_All_ButtonPushEvent_NearTown"
  buttonEvent[button.InSiegeingFortress] = "PaGlobalFunc_DeadMessage_All_ButtonPushEvent_InSiegeingFortress"
  buttonEvent[button.LocalWar] = "PaGlobalFunc_DeadMessage_All_ButtonPushEvent_LocalWar"
  buttonEvent[button.AdvancedBase] = "PaGlobalFunc_DeadMessage_All_ButtonPushEvent_AdvancedBase"
  buttonEvent[button.GuildSpawn] = "PaGlobalFunc_DeadMessage_All_ButtonPushEvent_GuildSpawn"
  buttonEvent[button.SavageDefence] = "PaGlobalFunc_DeadMessage_All_ButtonPushEvent_SavageDefence"
  buttonEvent[button.Volunteer] = "PaGlobalFunc_DeadMessage_All_ButtonPushEvent_Volunteer"
  buttonEvent[button.Plunder] = "PaGlobalFunc_DeadMessage_All_ButtonPushEvent_Plunder"
  buttonEvent[button.GuildTeamBattle] = "PaGlobalFunc_DeadMessage_All_ButtonPushEvent_GuildTeamBattle"
  buttonEvent[button.OutsideGate] = "PaGlobalFunc_DeadMessage_All_ButtonPushEvent_OutsideGate"
  buttonEvent[button.InsideGate] = "PaGlobalFunc_DeadMessage_All_ButtonPushEvent_InsideGate"
  buttonEvent[button.Observer] = "PaGlobalFunc_DeadMessage_All_ButtonPushEvent_Observer"
  buttonEvent[button.GuildObServerMode] = "PaGlobalFunc_DeadMessage_All_ButtonPushEvent_GuildObserverMode"
  buttonEvent[button.NationSiege_BlackSpirit] = "PaGlobalFunc_DeadMessage_All_ButtonPushEvent_NationSiege_BlackSpirit"
end
function PaGlobal_DeadMessage_All:resetData()
  PaGlobal_DeadMessage_All._isHasResotreExp = false
  PaGlobal_DeadMessage_All._isAblePvPMatchRevive = false
  PaGlobal_DeadMessage_All._currentDeadType = nil
  PaGlobal_DeadMessage_All._isObserverMode = false
  PaGlobal_DeadMessage_All._deadCheckTime = 0
  PaGlobal_DeadMessage_All._isSkipDeathPenalty = false
  PaGlobal_DeadMessage_All._buttonTypeArray = nil
  PaGlobal_DeadMessage_All._buttonWaitTime = 0
  PaGlobal_DeadMessage_All._isButtonWaitTimeEnd = false
  PaGlobal_DeadMessage_All._isUseButtonAbleTime = false
  PaGlobal_DeadMessage_All._resurrectionTime = 600
  PaGlobal_DeadMessage_All._lastUpdateTime = 0
  PaGlobal_DeadMessage_All._tempButtonAbleTimeForGuildObserver = nil
  PaGlobal_DeadMessage_All._startTimeForGuildObserver = nil
  for index = 0, PaGlobal_DeadMessage_All._respawnButtonMaxCount - 1 do
    PaGlobal_DeadMessage_All._ui._button_Respawn[index]:SetPosY((PaGlobal_DeadMessage_All._ui._button_Respawn[index]:GetSizeY() + 10) * index)
  end
  PaGlobal_DeadMessage_All._ui.list2_lostItem:getElementManager():clearKey()
end
function PaGlobal_DeadMessage_All:closeChannelMoveWindow()
  if false == _ContentsGroup_RenewUI_ExitGame then
    if true == _ContentsGroup_NewUI_GameExit then
      if Panel_Window_GameExit_All:GetShow() then
        PaGlobal_GameExit_All_Close()
      end
    elseif Panel_GameExit:GetShow() then
      Panel_GameExit:SetShow(false)
    end
    if true == _ContentsGroup_NewUI_ChannelSelect_All then
      if nil ~= Panel_ChannelSelect_All and true == Panel_ChannelSelect_All:GetShow() then
        PaGlobalFunc_ChannelSelect_All_Close()
      end
    elseif nil ~= Panel_ChannelSelect and true == Panel_ChannelSelect:GetShow() then
      FGlobal_ChannelSelect_Hide()
    end
  else
    if true == _ContentsGroup_NewUI_GameExit then
      if Panel_Window_GameExit_All:GetShow() then
        PaGlobal_GameExit_All_Close()
      end
    elseif true == PaGlobalFunc_GameExit_GetShow() then
      PaGlobalFunc_GameExit_SetShow(false, false)
    end
    if true == _ContentsGroup_NewUI_ChannelSelect_All then
      if nil ~= Panel_ChannelSelect_All and true == Panel_ChannelSelect_All:GetShow() then
        PaGlobalFunc_ChannelSelect_All_Close()
      end
    elseif false == _ContentsGroup_RenewUI_ServerSelect then
      if Panel_ChannelSelect:GetShow() then
        FGlobal_ChannelSelect_Hide()
      end
    else
      PaGlobalFunc_ServerSelect_Close()
    end
  end
end
function PaGlobal_DeadMessage_All:setResurrectionTime(respawnTime)
  if nil == respawnTime then
    PaGlobal_DeadMessage_All._resurrectionTime = 0
    return
  end
  local deadType = PaGlobal_DeadMessage_All._eDeadType
  local curDeadType = PaGlobal_DeadMessage_All._currentDeadType
  local selfProxy = getSelfPlayer()
  PaGlobal_DeadMessage_All._isUseButtonAbleTime = false
  if curDeadType == deadType.DeadLocate_InPlunder then
    PaGlobal_DeadMessage_All._resurrectionTime = PaGlobal_DeadMessage_All._revivalTime
  elseif curDeadType == deadType.DeadLocate_InBattleGround then
    PaGlobal_DeadMessage_All._resurrectionTime = PaGlobal_DeadMessage_All._revivalTime
  elseif curDeadType == deadType.DeadLocate_InCompetition then
    PaGlobal_DeadMessage_All._resurrectionTime = ToClient_CompetitionMatchTimeLimit() + ToClient_GetMaxWaitTime()
  elseif curDeadType == deadType.DeadLocate_InSavageDefence then
    PaGlobal_DeadMessage_All._resurrectionTime = 0
  elseif curDeadType == deadType.DeadLocate_InGuildBattle then
    PaGlobal_DeadMessage_All._resurrectionTime = 0
  elseif curDeadType == deadType.DeadLocate_InGuildTeamBattle then
    PaGlobal_DeadMessage_All._resurrectionTime = 25
  elseif curDeadType == deadType.DeadLocate_InPVP then
    PaGlobal_DeadMessage_All._resurrectionTime = PaGlobal_DeadMessage_All._revivalTime
  elseif curDeadType == deadType.DeadLocate_InLocarWar then
    PaGlobal_DeadMessage_All._resurrectionTime = 600
  elseif curDeadType == deadType.DeadLocate_InNationSiege then
    PaGlobal_DeadMessage_All._resurrectionTime = nil
  elseif curDeadType == deadType.DeadLocate_InPrision then
    PaGlobal_DeadMessage_All._resurrectionTime = 2
  elseif curDeadType == deadType.IsSpecialCharacter then
    PaGlobal_DeadMessage_All._resurrectionTime = PaGlobal_DeadMessage_All._revivalTime
  elseif curDeadType == deadType.DeadLocate_InBloodAltar then
    PaGlobal_DeadMessage_All._resurrectionTime = 0
  elseif curDeadType == deadType.DeadLocate_InSiegeBeingChannel or curDeadType == deadType.DeadLocate_InSiegeBeingInCurrentPos or curDeadType == deadType.DeadLocate_InSiegeBattle or curDeadType == deadType.DeadLocate_InMajorSiegeBattle or curDeadType == deadType.DeadLocate_InNoAccessArea then
    if true == deadMessage_isSiegeBeingMyChannel() and deadMessage_isInSiegeBattle() or 0 ~= selfProxy:get():getVolunteerTeamNoForLua() then
      respawnTime = respawnTime / 1000
      PaGlobal_DeadMessage_All._buttonWaitTime = respawnTime
      if 0 <= PaGlobal_DeadMessage_All._buttonWaitTime then
        PaGlobal_DeadMessage_All._isUseButtonAbleTime = true
        PaGlobal_DeadMessage_All._buttonAbleTime = respawnTime
      end
      PaGlobal_DeadMessage_All._resurrectionTime = respawnTime
    elseif true == deadMessage_isSiegeBeingMyChannel() then
      PaGlobal_DeadMessage_All._resurrectionTime = 0
    else
      PaGlobal_DeadMessage_All._resurrectionTime = 0
    end
  elseif curDeadType == deadType.Dead_Normal then
    PaGlobal_DeadMessage_All._resurrectionTime = 0
  end
end
function PaGlobal_DeadMessage_All:getDeadType()
  local deadType = PaGlobal_DeadMessage_All._eDeadType
  local selfProxy = getSelfPlayer()
  if nil == selfProxy then
    return nil
  end
  local regionInfo = getRegionInfoByPosition(selfProxy:get():getPosition())
  local isArenaArea = regionInfo:get():isArenaArea()
  local isMyChannelSiegeBeing = deadMessage_isSiegeBeingMyChannel()
  local isSiegeBeingInCurrentPosition = deadMessage_isSiegeBeingInCurrentPosition()
  if true == ToClient_isPlunderGameBeing() then
    return deadType.DeadLocate_InPlunder
  end
  if true == selfProxy:get():isBattleGroundDefine() then
    return deadType.DeadLocate_InBattleGround
  end
  if true == selfProxy:get():isCompetitionDefined() then
    return deadType.DeadLocate_InCompetition
  end
  if true == ToClient_getPlayNowSavageDefence() then
    return deadType.DeadLocate_InSavageDefence
  end
  if true == ToClient_getJoinGuildBattle() then
    return deadType.DeadLocate_InGuildBattle
  end
  if true == ToClient_IsSelfInGuildTeamBattle() then
    return deadType.DeadLocate_InGuildTeamBattle
  end
  if true == PaGlobal_DeadMessage_All._isAblePvPMatchRevive then
    return deadType.DeadLocate_InPVP
  end
  if 0 ~= ToClient_GetMyTeamNoLocalWar() then
    return deadType.DeadLocate_InLocarWar
  end
  if true == regionInfo:isPrison() or true == goToPrison() then
    return deadType.DeadLocate_InPrision
  end
  if true == ToClient_isSpecialCharacter() and false == ToClient_getPlayNowSavageDefence() and 0 == ToClient_GetMyTeamNoLocalWar() then
    return deadType.IsSpecialCharacter
  end
  if true == deadMessage_isInMajorSiegeBattle() then
    return deadType.DeadLocate_InMajorSiegeBattle
  end
  if true == deadMessage_isInSiegeBattle() then
    return deadType.DeadLocate_InSiegeBattle
  end
  if true == isSiegeBeingInCurrentPosition then
    return deadType.DeadLocate_InSiegeBeingInCurrentPos
  end
  if true == isMyChannelSiegeBeing then
    return deadType.DeadLocate_InSiegeBeingChannel
  end
  if true == ToClient_isBeingNationSiege() and true == deadMessage_isInNationSiegeBattle() then
    return deadType.DeadLocate_InNationSiege
  end
  if true == ToClient_IsInstanceFieldPlayerbyContentsType(__eInstanceContentsType_SavageDefence) then
    return deadType.DeadLocate_InBloodAltar
  end
  return deadType.Dead_Normal
end
function PaGlobal_DeadMessage_All:setRespawnButton()
  local buttonString = PaGlobal_DeadMessage_All._ButtonString
  local buttonControl = PaGlobal_DeadMessage_All._ui._button_Respawn
  local deadType = PaGlobal_DeadMessage_All._currentDeadType
  PaGlobal_DeadMessage_All._buttonTypeArray = Array.new()
  local buttonArray = PaGlobal_DeadMessage_All._buttonTypeArray
  for index = 0, PaGlobal_DeadMessage_All._respawnButtonMaxCount - 1 do
    buttonControl[index]:SetShow(false)
  end
  local buttonList = PaGlobal_DeadMessage_All._ButtonListByDeadType[deadType]
  if nil == buttonList then
    return
  end
  for _, buttonType in pairs(buttonList) do
    if nil ~= buttonType and true == PaGlobal_DeadMessage_All:checkButtonCondition(buttonType) then
      buttonArray:push_back(buttonType)
    end
  end
  local buttonSort_do = function(a, b)
    return a < b
  end
  table.sort(buttonArray, buttonSort_do)
  local freeRevivalLevel = FromClient_getFreeRevivalLevel()
  local regionInfo = getRegionInfoByPosition(getSelfPlayer():get():getPosition())
  local isFreeArea = regionInfo:get():isFreeRevivalArea()
  local showItemCheckBox = false
  local showFairyCheckBox = false
  local _eDeadType = PaGlobal_DeadMessage_All._eDeadType
  if freeRevivalLevel >= getSelfPlayer():get():getLevel() and isFreeArea or _eDeadType.DeadLocate_InPlunder == PaGlobal_DeadMessage_All._currentDeadType or _eDeadType.DeadLocate_InBattleGround == PaGlobal_DeadMessage_All._currentDeadType or _eDeadType.DeadLocate_InCompetition == PaGlobal_DeadMessage_All._currentDeadType or _eDeadType.DeadLocate_InSavageDefence == PaGlobal_DeadMessage_All._currentDeadType or _eDeadType.DeadLocate_InGuildBattle == PaGlobal_DeadMessage_All._currentDeadType or _eDeadType.DeadLocate_InGuildTeamBattle == PaGlobal_DeadMessage_All._currentDeadType or _eDeadType.DeadLocate_InPVP == PaGlobal_DeadMessage_All._currentDeadType or _eDeadType.DeadLocate_InLocarWar == PaGlobal_DeadMessage_All._currentDeadType or _eDeadType.DeadLocate_InPrision == PaGlobal_DeadMessage_All._currentDeadType or _eDeadType.DeadLocate_InNationSiege == PaGlobal_DeadMessage_All._currentDeadType or _eDeadType.IsSpecialCharacter == PaGlobal_DeadMessage_All._currentDeadType then
    showItemCheckBox = false
    showFairyCheckBox = false
  else
    showItemCheckBox = true
    if true == ToClient_Fairy_CanRespawn() and true == _ContentsGroup_isFairy then
      showFairyCheckBox = true
    end
  end
  if true == showFairyCheckBox then
    PaGlobal_DeadMessage_All._ui.btn_useFairyCheck:SetShow(true)
    local buttonSizeY = PaGlobal_DeadMessage_All._ui.btn_useFairyCheck:GetSizeY()
    for ii = 0, #buttonArray - 1 do
      buttonControl[ii]:SetPosY(buttonControl[ii]:GetPosY() + buttonSizeY + 5)
    end
  else
    PaGlobal_DeadMessage_All._ui.btn_useFairyCheck:SetShow(false)
    PaGlobal_DeadMessage_All._ui.btn_useFairyCheck:SetCheck(false)
  end
  if true == PaGlobal_DeadMessage_All._isConsole then
    PaGlobal_DeadMessage_All._ui.btn_selectButton_console:SetPosY(PaGlobal_DeadMessage_All._ui.btn_useFairyCheck:GetPosY() - 15)
  end
  if true == showItemCheckBox then
    PaGlobal_DeadMessage_All._ui.btn_useItemCheck:SetShow(true)
    local buttonSizeY = PaGlobal_DeadMessage_All._ui.btn_useItemCheck:GetSizeY()
    if true == showFairyCheckBox then
      PaGlobal_DeadMessage_All._ui.btn_useItemCheck:SetPosY(PaGlobal_DeadMessage_All._ui.btn_useFairyCheck:GetPosY() + buttonSizeY + 5)
    else
      PaGlobal_DeadMessage_All._ui.btn_useItemCheck:SetPosY(PaGlobal_DeadMessage_All._ui.btn_useFairyCheck:GetPosY())
    end
    for ii = 0, #buttonArray - 1 do
      buttonControl[ii]:SetPosY(buttonControl[ii]:GetPosY() + buttonSizeY + 5)
    end
  else
    PaGlobal_DeadMessage_All._ui.btn_useItemCheck:SetShow(false)
    PaGlobal_DeadMessage_All._ui.btn_useItemCheck:SetCheck(false)
  end
  local buttonUIIndex = 0
  for buttonIndex = 1, #buttonArray do
    local buttonType = buttonArray[buttonIndex]
    local buttonString = PaGlobal_DeadMessage_All._ButtonString[buttonType]
    local buttonEvent = PaGlobal_DeadMessage_All._ButtonEvent[buttonType]
    PaGlobal_DeadMessage_All:checkUseItemFairy(buttonType)
    buttonControl[buttonUIIndex]:addInputEvent("Mouse_LUp", buttonEvent .. "()")
    if true == PaGlobal_DeadMessage_All._isConsole then
      buttonControl[buttonUIIndex]:addInputEvent("Mouse_On", "HandleEventOn_DeadMessage_All_ButtonMouseOn(" .. buttonUIIndex .. ")")
    end
    buttonControl[buttonUIIndex]:SetSize(buttonControl[buttonUIIndex]:GetSizeX(), PaGlobal_DeadMessage_All._ui.btn_smallTemplate:GetSizeY())
    buttonControl[buttonUIIndex]:SetShow(true)
    local stringControl = UI.getChildControl(buttonControl[buttonUIIndex], "StaticText_ButtonText1")
    stringControl:SetText(buttonString)
    local reviveStringControl = UI.getChildControl(buttonControl[buttonUIIndex], "StaticText_ButtonText2")
    if PaGlobal_DeadMessage_All._eButtonType.Immediate == buttonType then
      reviveStringControl:SetShow(true)
      local revivalItemCount = ToClient_InventorySizeByProductCategory(CppEnums.ItemWhereType.eCashInventory, CppEnums.ItemProductCategory.eItemProductCategory_Revival)
      if _eDeadType.DeadLocate_InBattleGround == PaGlobal_DeadMessage_All._currentDeadType or _eDeadType.DeadLocate_InCompetition == PaGlobal_DeadMessage_All._currentDeadType or _eDeadType.DeadLocate_InGuildBattle == PaGlobal_DeadMessage_All._currentDeadType and 0 == ToClient_GuildBattle_GetCurrentState() or _eDeadType.DeadLocate_InGuildTeamBattle == PaGlobal_DeadMessage_All._currentDeadType or _eDeadType.DeadLocate_InPVP == PaGlobal_DeadMessage_All._currentDeadType or _eDeadType.IsSpecialCharacter == PaGlobal_DeadMessage_All._currentDeadType then
        local noPaneltyString = "(" .. PAGetString(Defines.StringSheet_GAME, "LUA_PVPBATTLE_IMMEDIATECOUNT_TEXT") .. ")"
        reviveStringControl:SetText(noPaneltyString)
      elseif isFreeArea and freeRevivalLevel >= getSelfPlayer():get():getLevel() then
        local freeRevivalString = "(" .. PAGetStringParam1(Defines.StringSheet_GAME, "LUA_DEADMESSAGE_RESURRECTION_POSSIBLE", "freeRevivalLevel", freeRevivalLevel) .. ")"
        reviveStringControl:SetText(freeRevivalString)
      elseif revivalItemCount <= 0 then
        local purchaseItemString = "(" .. PAGetString(Defines.StringSheet_GAME, "LUA_DEADMESSAGE_ITEM_RESURRECTION") .. ")"
        reviveStringControl:SetText(purchaseItemString)
      else
        local haveItemString = "(" .. PAGetStringParam1(Defines.StringSheet_GAME, "LUA_DEADMESSAGE_GET_ITEM_RESURRECTION", "revivalItemCount", revivalItemCount) .. ")"
        reviveStringControl:SetText(haveItemString)
      end
      buttonControl[buttonUIIndex]:SetSize(buttonControl[buttonUIIndex]:GetSizeX(), PaGlobal_DeadMessage_All._ui.btn_largeTemplate:GetSizeY())
      stringControl:SetSpanSize(0, -15)
      stringControl:ComputePos()
      for ii = buttonIndex, #buttonArray do
        buttonControl[ii]:SetPosY(buttonControl[ii]:GetPosY() + 30)
      end
    else
      reviveStringControl:SetShow(false)
      stringControl:SetSpanSize(0, 0)
      stringControl:ComputePos()
    end
    buttonUIIndex = buttonUIIndex + 1
  end
end
function PaGlobal_DeadMessage_All:checkUseItemFairy(buttonType)
  local _eDeadType = PaGlobal_DeadMessage_All._eDeadType
  local button = PaGlobal_DeadMessage_All._eButtonType
  local buttonEvent = PaGlobal_DeadMessage_All._ButtonEvent[buttonType]
  if nil == buttonEvent then
    return
  end
  local useItem = true
  local useFairy = true
  local selfProxy = getSelfPlayer()
  local regionInfo = getRegionInfoByPosition(selfProxy:get():getPosition())
  if _eDeadType.DeadLocate_InPlunder == PaGlobal_DeadMessage_All._currentDeadType or _eDeadType.DeadLocate_InBattleGround == PaGlobal_DeadMessage_All._currentDeadType or _eDeadType.DeadLocate_InCompetition == PaGlobal_DeadMessage_All._currentDeadType or _eDeadType.DeadLocate_InSavageDefence == PaGlobal_DeadMessage_All._currentDeadType or _eDeadType.DeadLocate_InGuildBattle == PaGlobal_DeadMessage_All._currentDeadType or _eDeadType.DeadLocate_InGuildTeamBattle == PaGlobal_DeadMessage_All._currentDeadType or _eDeadType.DeadLocate_InPVP == PaGlobal_DeadMessage_All._currentDeadType or _eDeadType.DeadLocate_InLocarWar == PaGlobal_DeadMessage_All._currentDeadType or _eDeadType.DeadLocate_InPrision == PaGlobal_DeadMessage_All._currentDeadType or _eDeadType.DeadLocate_InNationSiege == PaGlobal_DeadMessage_All._currentDeadType or _eDeadType.IsSpecialCharacter == PaGlobal_DeadMessage_All._currentDeadType then
    useItem = false
    useFairy = false
  elseif true == FGlobal_IsCommercialService() then
    local freeRevivalLevel = FromClient_getFreeRevivalLevel()
    local isFreeArea = regionInfo:get():isFreeRevivalArea()
    if freeRevivalLevel >= selfProxy:get():getLevel() and true == isFreeArea then
      useItem = false
      useFairy = false
    end
  else
    useItem = false
    useFairy = false
  end
  if true == useItem then
    if button.NearTown == buttonType or button.Exploration == buttonType or button.GuildSpawn == buttonType then
      useItem = true
    else
      useItem = false
    end
  end
  if true == useFairy then
    if button.NearTown == buttonType or button.Exploration == buttonType or button.Immediate == buttonType then
      useFairy = true
    else
      useFairy = false
    end
  end
  if true == useItem then
    local prevExp = selfProxy:get():getPrevExp_s64()
    local currentExp = selfProxy:get():getExp_s64()
    local isArena = regionInfo:get():isArenaArea()
    if false == isArena and (true == PaGlobal_DeadMessage_All._isHasResotreExp or prevExp > currentExp) then
      useItem = true
    else
      useItem = false
    end
  end
  if true == useFairy then
    local canFairyRespawn = ToClient_Fairy_CanRespawn()
    if canFairyRespawn and _ContentsGroup_isFairy then
      useFairy = true
    else
      useFairy = false
    end
  end
  PaGlobal_DeadMessage_All._useItem = useItem
  PaGlobal_DeadMessage_All._useFairy = useFairy
end
function PaGlobal_DeadMessage_All:showDeadMessage(attackerActorKeyRaw, isSkipDeathPenalty)
  local _eDeadType = PaGlobal_DeadMessage_All._eDeadType
  local deadType = PaGlobal_DeadMessage_All._currentDeadType
  local aniType = PaGlobal_DeadMessage_All._aniType
  local selfProxy = getSelfPlayer()
  local attackerActorProxyWrapper
  if nil ~= attackerActorKeyRaw then
    attackerActorProxyWrapper = getActor(attackerActorKeyRaw)
  end
  local isMilitia = false
  local playerActorProxyWrapper
  if nil ~= attackerActorKeyRaw then
    playerActorProxyWrapper = getPlayerActor(attackerActorKeyRaw)
  end
  if nil ~= playerActorProxyWrapper then
    isMilitia = playerActorProxyWrapper:get():isVolunteer()
  end
  local deadMessageString = PAGetString(Defines.StringSheet_GAME, "DEADMESSAGE_TEXT_DisplayMsg")
  local deadWhoString
  if _eDeadType.DeadLocate_InGuildTeamBattle == deadType then
    deadMessageString = PAGetString(Defines.StringSheet_GAME, "LUA_GUILDTEAMBATTLE_DEADATFIGHT")
  elseif nil ~= attackerActorProxyWrapper then
    if attackerActorKeyRaw == selfProxy:getActorKey() then
      deadWhoString = PAGetString(Defines.StringSheet_GAME, "DEADMESSAGE_TEXT_DisplayMsg")
    elseif true == isMilitia then
      deadWhoString = PAGetStringParam1(Defines.StringSheet_GAME, "DEADMESSAGE_TEXT_KilledDisplayMsg", "attackerName", PAGetString(Defines.StringSheet_GAME, "LUA_WARINFOMESSAGE_MILITIA"))
    elseif true == _ContentsGroup_NameTypeEqually then
      local nameType = ToClient_getChatNameType()
      if __eChatNameType_NickName == nameType then
        if nil ~= playerActorProxyWrapper then
          deadWhoString = PAGetStringParam1(Defines.StringSheet_GAME, "DEADMESSAGE_TEXT_KilledDisplayMsg", "attackerName", playerActorProxyWrapper:getUserNickname())
        end
      else
        deadWhoString = PAGetStringParam1(Defines.StringSheet_GAME, "DEADMESSAGE_TEXT_KilledDisplayMsg", "attackerName", attackerActorProxyWrapper:getOriginalName())
      end
    else
      deadWhoString = PAGetStringParam1(Defines.StringSheet_GAME, "DEADMESSAGE_TEXT_KilledDisplayMsg", "attackerName", attackerActorProxyWrapper:getOriginalName())
    end
  end
  PaGlobal_DeadMessage_All._ui.txt_deathTitle:SetText(deadMessageString)
  PaGlobal_DeadMessage_All._ui.txt_deathTitle:SetShow(true)
  if nil ~= deadWhoString then
    PaGlobal_DeadMessage_All._ui.txt_deathTitle:SetText(deadWhoString)
  end
  PaGlobal_DeadMessage_All:setDeadMessageAni()
  PaGlobal_DeadMessage_All:prepareOpen()
  if true == isSkipDeathPenalty then
    PaGlobal_DeadMessage_All._ui.list2_lostItem:getElementManager():pushKey(Defines.s64_const.s64_1)
  else
    for idx = 1, PaGlobal_DeadMessage_All._currentPaneltyStringCount do
      PaGlobal_DeadMessage_All._ui.list2_lostItem:getElementManager():pushKey(toInt64(0, idx))
    end
  end
  if 0 < Int64toInt32(PaGlobal_DeadMessage_All._ui.list2_lostItem:getElementManager():getSize()) then
    PaGlobal_DeadMessage_All._ui.stc_lostItemBG:SetShow(true)
  else
    PaGlobal_DeadMessage_All._ui.stc_lostItemBG:SetShow(false)
  end
  PaGlobal_DeadMessage_All._ui.txt_siegeNotice:SetShow(false)
  if true == deadMessage_isSiegeBeingMyChannel() then
    local isSiegeBeingInDead = deadMessage_isSiegeBeingInCurrentPosition()
    if true == isHasFortress() and false == isSiegeBeingInDead then
      PaGlobal_DeadMessage_All._ui.txt_siegeNotice:SetShow(true)
    end
  end
  if _eDeadType.DeadLocate_InPlunder == deadType or _eDeadType.DeadLocate_InBattleGround == deadType or _eDeadType.DeadLocate_InCompetition == deadType or _eDeadType.DeadLocate_InSavageDefence == deadType or _eDeadType.DeadLocate_InBloodAltar == deadType or _eDeadType.DeadLocate_InGuildBattle == deadType or _eDeadType.DeadLocate_InGuildTeamBattle == deadType or _eDeadType.DeadLocate_InPVP == deadType or _eDeadType.DeadLocate_InLocarWar == deadType or _eDeadType.DeadLocate_InPrision == deadType or _eDeadType.DeadLocate_InMajorSiegeBattle == deadType or _eDeadType.DeadLocate_InSiegeBattle == deadType or _eDeadType.DeadLocate_InSiegeBeingInCurrentPos == deadType or _eDeadType.DeadLocate_InSiegeBeingChannel == deadType or _eDeadType.DeadLocate_InNationSiege == deadType or _eDeadType.IsSpecialCharacter == deadType then
    PaGlobal_DeadMessage_All._ui.btn_noticeIcon:SetShow(false)
  elseif nil ~= attackerActorProxyWrapper then
    local isAttackPlayer = attackerActorProxyWrapper:get():isPlayer()
    if true == isAttackPlayer then
      if ToClient_isDontPvPDecreaseTendency() then
        PaGlobal_DeadMessage_All._ui.btn_noticeIcon:SetShow(false)
        PaGlobal_DeadMessage_All._ui.stc_paneltyBG:SetShow(false)
      else
        PaGlobal_DeadMessage_All._ui.btn_noticeIcon:SetShow(true)
        PaGlobal_DeadMessage_All._ui.stc_paneltyBG:SetShow(PaGlobal_DeadMessage_All._isConsole)
      end
    else
      PaGlobal_DeadMessage_All._ui.btn_noticeIcon:SetShow(false)
    end
  end
end
function PaGlobal_DeadMessage_All:setAniToControl(control, aniType, startTime, endTime, startValue, endValue, isDisable)
  if nil == control then
    return
  end
  local aniInfo
  if aniType == PaGlobal_DeadMessage_All._aniType._changeColor then
    aniInfo = control:addColorAnimation(startTime, endTime, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_COS_HALF_PI)
    aniInfo:SetStartColor(startValue)
    aniInfo:SetEndColor(endValue)
  elseif aniType == PaGlobal_DeadMessage_All._aniType._changeScale then
    aniInfo = control:addScaleAnimation(startTime, endTime, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_COS_HALF_PI)
    aniInfo:SetStartScale(startValue)
    aniInfo:SetEndScale(endValue)
  else
    return
  end
  aniInfo.IsChangeChild = true
  aniInfo:SetDisableWhileAni(true)
  control:SetDisableWhileAnimationChild(true)
  if true == isDisable then
    aniInfo:SetIgnoreUpdateSnapping(true)
  end
end
function PaGlobal_DeadMessage_All:setDeadMessageAni()
  local buttonControl = PaGlobal_DeadMessage_All._ui._button_Respawn
  local button = PaGlobal_DeadMessage_All._eButtonType
  local aniType = PaGlobal_DeadMessage_All._aniType
  local buttonUIIndex = 0
  for index = 1, #PaGlobal_DeadMessage_All._buttonTypeArray do
    local buttonType = PaGlobal_DeadMessage_All._buttonTypeArray[index]
    local control = buttonControl[buttonUIIndex]
    if nil == control then
    elseif button.Immediate == buttonType then
      PaGlobal_DeadMessage_All:setAniToControl(control, aniType._changeColor, 0, 3, Defines.Color.C_00FFFFFF, Defines.Color.C_00FFFFFF, true)
      PaGlobal_DeadMessage_All:setAniToControl(control, aniType._changeColor, 3, 4, Defines.Color.C_00FFFFFF, Defines.Color.C_FFFFFFFF, true)
    elseif button.Exploration == buttonType or button.NearTown == buttonType or button.InSiegeingFortress == buttonType or button.LocalWar == buttonType or button.AdvancedBase == buttonType or button.GuildSpawn == buttonType or button.SavageDefence == buttonType or button.Volunteer == buttonType or button.Plunder == buttonType or button.GuildTeamBattle == buttonType or button.OutsideGate == buttonType or button.InsideGate == buttonType then
      PaGlobal_DeadMessage_All:setAniToControl(control, aniType._changeColor, 0, 3, Defines.Color.C_00FFFFFF, Defines.Color.C_00FFFFFF, true)
      PaGlobal_DeadMessage_All:setAniToControl(control, aniType._changeColor, 3, 4, Defines.Color.C_00FFFFFF, Defines.Color.C_FFFFFFFF, true)
      PaGlobal_DeadMessage_All:setAniToControl(control, aniType._changeScale, 2.5, 3.2, 0.5, 1, true)
    elseif button.Observer == buttonType or button.GuildObServerMode == buttonType or button.NationSiege_BlackSpirit == buttonType then
      PaGlobal_DeadMessage_All:setAniToControl(control, aniType._changeColor, 0, 3, Defines.Color.C_00FFFFFF, Defines.Color.C_00FFFFFF, true)
      PaGlobal_DeadMessage_All:setAniToControl(control, aniType._changeColor, 3, 4, Defines.Color.C_00FFFFFF, Defines.Color.C_FFFFFFFF, true)
    end
    buttonUIIndex = buttonUIIndex + 1
  end
  local messageControl = PaGlobal_DeadMessage_All._ui.txt_deathTitle
  PaGlobal_DeadMessage_All:setAniToControl(messageControl, aniType._changeColor, 0, 0.5, Defines.Color.C_00FFFFFF, Defines.Color.C_00FFFFFF, true)
  PaGlobal_DeadMessage_All:setAniToControl(messageControl, aniType._changeColor, 1.5, 2.3, Defines.Color.C_00FFFFFF, Defines.Color.C_FFFFFFFF, true)
  PaGlobal_DeadMessage_All:setAniToControl(messageControl, aniType._changeScale, 0.7, 2.5, 0.5, 1)
  messageControl = PaGlobal_DeadMessage_All._ui.stc_circleBG
  PaGlobal_DeadMessage_All:setAniToControl(messageControl, aniType._changeColor, 0, 3, Defines.Color.C_00FFFFFF, Defines.Color.C_FFFFFFFF, true)
  messageControl = PaGlobal_DeadMessage_All._ui.txt_resurrectionTime
  PaGlobal_DeadMessage_All:setAniToControl(messageControl, aniType._changeColor, 0, 0.5, Defines.Color.C_00FFFFFF, Defines.Color.C_00FFFFFF, true)
  PaGlobal_DeadMessage_All:setAniToControl(messageControl, aniType._changeColor, 2, 2.3, Defines.Color.C_00FFFFFF, Defines.Color.C_FFFFFFFF, true)
  PaGlobal_DeadMessage_All:setAniToControl(messageControl, aniType._changeScale, 0.7, 2.3, 0.5, 1)
  messageControl = PaGlobal_DeadMessage_All._ui.list2_content
  PaGlobal_DeadMessage_All:setAniToControl(messageControl, aniType._changeColor, 0, 0.5, Defines.Color.C_00FFFFFF, Defines.Color.C_00FFFFFF)
  PaGlobal_DeadMessage_All:setAniToControl(messageControl, aniType._changeColor, 2.5, 3, Defines.Color.C_00FFFFFF, Defines.Color.C_FFFFFFFF)
  messageControl = PaGlobal_DeadMessage_All._ui.stc_lineTop
  PaGlobal_DeadMessage_All:setAniToControl(messageControl, aniType._changeColor, 0, 0.5, Defines.Color.C_00FFFFFF, Defines.Color.C_00FFFFFF, true)
  PaGlobal_DeadMessage_All:setAniToControl(messageControl, aniType._changeColor, 2.5, 3, Defines.Color.C_00FFFFFF, Defines.Color.C_FFFFFFFF, true)
  messageControl = PaGlobal_DeadMessage_All._ui.stc_lineBottom
  PaGlobal_DeadMessage_All:setAniToControl(messageControl, aniType._changeColor, 0, 0.5, Defines.Color.C_00FFFFFF, Defines.Color.C_00FFFFFF, true)
  PaGlobal_DeadMessage_All:setAniToControl(messageControl, aniType._changeColor, 2.5, 3, Defines.Color.C_00FFFFFF, Defines.Color.C_FFFFFFFF, true)
  messageControl = PaGlobal_DeadMessage_All._ui.stc_lostItemBG
  PaGlobal_DeadMessage_All:setAniToControl(messageControl, aniType._changeColor, 0, 0.5, Defines.Color.C_00FFFFFF, Defines.Color.C_00FFFFFF, true)
  PaGlobal_DeadMessage_All:setAniToControl(messageControl, aniType._changeColor, 2.5, 3, Defines.Color.C_00FFFFFF, Defines.Color.C_FFFFFFFF, true)
  messageControl = PaGlobal_DeadMessage_All._ui.btn_useItemCheck
  if true == messageControl:GetShow() then
    PaGlobal_DeadMessage_All:setAniToControl(messageControl, aniType._changeColor, 0, 3, Defines.Color.C_00FFFFFF, Defines.Color.C_00FFFFFF, true)
    PaGlobal_DeadMessage_All:setAniToControl(messageControl, aniType._changeColor, 3, 4, Defines.Color.C_00FFFFFF, Defines.Color.C_FFFFFFFF, true)
  end
  messageControl = PaGlobal_DeadMessage_All._ui.btn_useFairyCheck
  if true == messageControl:GetShow() then
    PaGlobal_DeadMessage_All:setAniToControl(messageControl, aniType._changeColor, 0, 3, Defines.Color.C_00FFFFFF, Defines.Color.C_00FFFFFF, true)
    PaGlobal_DeadMessage_All:setAniToControl(messageControl, aniType._changeColor, 3, 4, Defines.Color.C_00FFFFFF, Defines.Color.C_FFFFFFFF, true)
  end
  messageControl = PaGlobal_DeadMessage_All._ui.txt_siegeNotice
  PaGlobal_DeadMessage_All:setAniToControl(messageControl, aniType._changeColor, 0, 3, Defines.Color.C_00FFFFFF, Defines.Color.C_00FFFFFF, true)
  PaGlobal_DeadMessage_All:setAniToControl(messageControl, aniType._changeColor, 3, 4, Defines.Color.C_00FFFFFF, Defines.Color.C_FFFFFFFF, true)
  messageControl = PaGlobal_DeadMessage_All._ui.btn_noticeIcon
  PaGlobal_DeadMessage_All:setAniToControl(messageControl, aniType._changeColor, 0, 3, Defines.Color.C_00FFFFFF, Defines.Color.C_00FFFFFF, true)
  PaGlobal_DeadMessage_All:setAniToControl(messageControl, aniType._changeColor, 3, 4, Defines.Color.C_00FFFFFF, Defines.Color.C_FFD05D48, true)
  if true == PaGlobal_DeadMessage_All._isConsole then
    messageControl = PaGlobal_DeadMessage_All._ui.btn_selectButton_console
    PaGlobal_DeadMessage_All:setAniToControl(messageControl, aniType._changeColor, 0, 3, Defines.Color.C_00FFFFFF, Defines.Color.C_00FFFFFF, true)
    PaGlobal_DeadMessage_All:setAniToControl(messageControl, aniType._changeColor, 3, 4, Defines.Color.C_00FFFFFF, Defines.Color.C_FFFFFFFF, true)
    messageControl = PaGlobal_DeadMessage_All._ui.stc_paneltyBG
    PaGlobal_DeadMessage_All:setAniToControl(messageControl, aniType._changeColor, 0, 3, Defines.Color.C_00FFFFFF, Defines.Color.C_00FFFFFF, true)
    PaGlobal_DeadMessage_All:setAniToControl(messageControl, aniType._changeColor, 3, 4, Defines.Color.C_00FFFFFF, Defines.Color.C_FFD05D48, true)
  end
end
function PaGlobal_DeadMessage_All:useCheckFairy(respawnType)
  local selfProxy = getSelfPlayer()
  if nil == selfProxy then
    return
  end
  local regionInfo = getRegionInfoByPosition(selfProxy:get():getPosition())
  local isArena = regionInfo:get():isArenaArea()
  if true == isArena and respawnType == PaGlobal_DeadMessage_All._eRespawnType.respawnType_Immediate then
    deadMessage_Revival(PaGlobal_DeadMessage_All._eRespawnType.respawnType_Immediate, 0, CppEnums.ItemWhereType.eCashInventory, getSelfPlayer():getRegionKey(), false, toInt64(0, 0), false)
  else
    deadMessage_Revival(respawnType, 255, CppEnums.ItemWhereType.eCashInventory, getSelfPlayer():getRegionKey(), false, toInt64(0, 0), true)
  end
end
function PaGlobal_DeadMessage_All:respawnWithCashItem(respawnType)
  local revivalItemCount = ToClient_InventorySizeByProductCategory(CppEnums.ItemWhereType.eCashInventory, CppEnums.ItemProductCategory.eItemProductCategory_Revival)
  local selfProxy = getSelfPlayer()
  if nil == selfProxy then
    return
  end
  local regionInfo = getRegionInfoByPosition(selfProxy:get():getPosition())
  local isArena = regionInfo:get():isArenaArea()
  if true == isArena and respawnType == PaGlobal_DeadMessage_All._eRespawnType.respawnType_Immediate then
    deadMessage_Revival(PaGlobal_DeadMessage_All._eRespawnType.respawnType_Immediate, 0, CppEnums.ItemWhereType.eCashInventory, getSelfPlayer():getRegionKey(), false, toInt64(0, 0))
  elseif 1 == revivalItemCount then
    HandleEventLUp_Cash_Revival_BuyItem_All_Apply_CashRevivalItem(respawnType)
  elseif 1 < revivalItemCount then
    PaGlobal_Cash_Revival_BuyItem_All_Open(respawnType)
  else
    HandleEventLUp_Cash_Revival_BuyItem_All_Buy_CashRevivalItem(respawnType)
  end
end
function PaGlobal_DeadMessage_All:checkButtonCondition(buttonType)
  local button = PaGlobal_DeadMessage_All._eButtonType
  if button.Immediate == buttonType then
    return PaGlobal_DeadMessage_All:checkButtonCondition_Immediate()
  elseif button.Exploration == buttonType then
    return PaGlobal_DeadMessage_All:checkButtonCondition_Exploration()
  elseif button.Observer == buttonType then
    return PaGlobal_DeadMessage_All:checkButtonCondition_Observer()
  elseif button.Volunteer == buttonType then
    return PaGlobal_DeadMessage_All:checkButtonCondition_Volunteer()
  elseif button.GuildObServerMode == buttonType then
    return PaGlobal_DeadMessage_All:checkButtonCondition_GuildObserverMode()
  elseif button.GuildSpawn == buttonType then
    return PaGlobal_DeadMessage_All:checkButtonCondition_GuildSpawn()
  elseif button.AdvancedBase == buttonType then
    return PaGlobal_DeadMessage_All:checkButtonCondition_AdvancedBase()
  elseif button.OutsideGate == buttonType or button.InsideGate == buttonType then
    return PaGlobal_DeadMessage_All:checkButtonCondition_MajorSiegeGate()
  elseif button.NearTown == buttonType then
    return PaGlobal_DeadMessage_All:checkButtonCondition_NearTown()
  end
  return true
end
function PaGlobal_DeadMessage_All:checkButtonCondition_Immediate()
  local deadType = PaGlobal_DeadMessage_All._currentDeadType
  local _eDeadType = PaGlobal_DeadMessage_All._eDeadType
  local selfProxy = getSelfPlayer()
  if _eDeadType.DeadLocate_InGuildBattle == deadType then
    if 0 ~= ToClient_GuildBattle_GetCurrentState() then
      return false
    end
  elseif _eDeadType.DeadLocate_InCompetition == deadType then
    if false == selfProxy:get():isCompetitionHost() then
      return false
    end
  elseif _eDeadType.Dead_Normal == deadType and false == FGlobal_IsCommercialService() then
    local regionInfo = getRegionInfoByPosition(selfProxy:get():getPosition())
    if false == regionInfo:get():isArenaArea() then
      return false
    end
  end
  return true
end
function PaGlobal_DeadMessage_All:checkButtonCondition_Exploration()
  local deadType = PaGlobal_DeadMessage_All._currentDeadType
  local _eDeadType = PaGlobal_DeadMessage_All._eDeadType
  if _eDeadType.DeadLocate_InSiegeBattle == deadType then
    local regionInfo = getRegionInfoByPosition(getSelfPlayer():get():getPosition())
    local linkedSiegeRegionInfoWrapper = ToClient_getVillageSiegeRegionInfoWrapperByPosition(getSelfPlayer():get():getPosition())
    if regionInfo:get():isMajorSiegeBeing() or linkedSiegeRegionInfoWrapper:get():isMinorSiegeBeing() then
      return false
    end
  end
  return true
end
function PaGlobal_DeadMessage_All:checkButtonCondition_Volunteer()
  local deadType = PaGlobal_DeadMessage_All._currentDeadType
  local _eDeadType = PaGlobal_DeadMessage_All._eDeadType
  local selfProxy = getSelfPlayer()
  if _eDeadType.DeadLocate_InSiegeBeingChannel == deadType or _eDeadType.DeadLocate_InSiegeBeingInCurrentPos == deadType or _eDeadType.DeadLocate_InSiegeBattle == deadType or _eDeadType.DeadLocate_InMajorSiegeBattle == deadType then
    local isMyChannelSiegeBeing = deadMessage_isSiegeBeingMyChannel()
    if true == isMyChannelSiegeBeing and selfProxy:get():isVolunteer() then
      return true
    end
  end
  return false
end
function PaGlobal_DeadMessage_All:checkButtonCondition_Observer()
  local deadType = PaGlobal_DeadMessage_All._currentDeadType
  local _eDeadType = PaGlobal_DeadMessage_All._eDeadType
  if _eDeadType.DeadLocate_InCompetition == deadType then
    if CppEnums.CompetitionMatchType.eCompetitionMatchMode_Personal == ToClient_CompetitionMatchType() then
      return false
    end
  elseif _eDeadType.DeadLocate_InGuildBattle == deadType then
    if 0 == ToClient_GuildBattle_GetCurrentState() then
      return false
    end
    if __eGuildBattleGameMode_OneOne == ToClient_GuildBattle_GetCurrentMode() then
      return false
    end
  elseif _eDeadType.DeadLocate_InSiegeBeingChannel == deadType or _eDeadType.DeadLocate_InSiegeBeingInCurrentPos == deadType or _eDeadType.DeadLocate_InSiegeBattle == deadType or _eDeadType.DeadLocate_InMajorSiegeBattle == deadType then
    local myGuildInfo = ToClient_GetMyGuildInfoWrapper()
    if nil == myGuildInfo then
      return false
    end
    local guildNo = myGuildInfo:getGuildNo_s64()
    if false == ToClient_IsInSiegeBattle(guildNo) then
      return false
    end
  end
  return true
end
function PaGlobal_DeadMessage_All:checkButtonCondition_GuildObserverMode()
  if true == PaGlobal_DeadMessage_All._isConsole then
    return false
  end
  local myGuildInfo = ToClient_GetMyGuildInfoWrapper()
  if nil ~= myGuildInfo then
    local guildNo = myGuildInfo:getGuildNo_s64()
    if ToClient_IsInSiegeBattle(guildNo) and true == _ContentsGroup_SeigeSeason5 then
      return true
    end
  end
  return false
end
function PaGlobal_DeadMessage_All:checkButtonCondition_GuildSpawn()
  local deadType = PaGlobal_DeadMessage_All._currentDeadType
  local _eDeadType = PaGlobal_DeadMessage_All._eDeadType
  if _eDeadType.Dead_Normal == deadType or _eDeadType.DeadLocate_InNoAccessArea == deadType or _eDeadType.DeadLocate_InSiegeBeingChannel == deadType or _eDeadType.DeadLocate_InSiegeBeingInCurrentPos == deadType or _eDeadType.DeadLocate_InSiegeBattle == deadType or _eDeadType.DeadLocate_InMajorSiegeBattle == deadType or _eDeadType.DeadLocate_InNationSiege == deadType then
    local guildUnSealCount = guildstable_getUnsealGuildServantCount()
    if 0 == guildUnSealCount then
      return false
    end
    local isGuildServant = false
    for index = 0, guildUnSealCount - 1 do
      local servantInfo = guildStable_getUnsealGuildServantAt(index)
      if nil ~= servantInfo and (CppEnums.VehicleType.Type_SailingBoat == servantInfo:getVehicleType() or CppEnums.VehicleType.Type_PersonalBattleShip == servantInfo:getVehicleType()) then
        isGuildServant = true
      end
    end
    if false == isGuildServant then
      return false
    end
  end
  return true
end
function PaGlobal_DeadMessage_All:checkButtonCondition_AdvancedBase()
  local deadType = PaGlobal_DeadMessage_All._currentDeadType
  local _eDeadType = PaGlobal_DeadMessage_All._eDeadType
  if _eDeadType.Dead_Normal == deadType or _eDeadType.DeadLocate_InNoAccessArea == deadType or _eDeadType.DeadLocate_InSiegeBeingChannel == deadType or _eDeadType.DeadLocate_InSiegeBeingInCurrentPos == deadType or _eDeadType.DeadLocate_InSiegeBattle == deadType or _eDeadType.DeadLocate_InMajorSiegeBattle == deadType or _eDeadType.DeadLocate_InNationSiege == deadType then
    local selfProxy = getSelfPlayer()
    if false == selfProxy:get():isGuildMember() then
      return false
    end
    if false == selfProxy:get():isAdvancedBaseActorKey() then
      return false
    end
  end
  return true
end
function PaGlobal_DeadMessage_All:checkButtonCondition_MajorSiegeGate()
  return deadMessage_isInMajorSiegeBattle()
end
function PaGlobal_DeadMessage_All:checkButtonCondition_NearTown()
  local selfProxy = getSelfPlayer()
  if nil == selfProxy then
    return true
  end
  local regionInfo = getRegionInfoByPosition(getSelfPlayer():get():getPosition())
  if nil == regionInfo then
    return true
  end
  local isPVEArenaZone = regionInfo:get():isPVEArenaZone()
  if true == isPVEArenaZone then
    return false
  end
  return true
end
function PaGlobal_DeadMessage_All:validate()
  if nil == Panel_Window_DeadMessage_All then
    return
  end
  PaGlobal_DeadMessage_All._ui.stc_centerBG:isValidate()
  PaGlobal_DeadMessage_All._ui.txt_deathTitle:isValidate()
  PaGlobal_DeadMessage_All._ui.txt_resurrectionTime:isValidate()
  PaGlobal_DeadMessage_All._ui.txt_GuildSkillApply:isValidate()
  PaGlobal_DeadMessage_All._ui.stc_lostItemBG:isValidate()
  PaGlobal_DeadMessage_All._ui.stc_lineTop:isValidate()
  PaGlobal_DeadMessage_All._ui.stc_lineBottom:isValidate()
  PaGlobal_DeadMessage_All._ui.list2_lostItem:isValidate()
  PaGlobal_DeadMessage_All._ui.stc_resurrectionBG:isValidate()
  PaGlobal_DeadMessage_All._ui.btn_noticeIcon:isValidate()
  PaGlobal_DeadMessage_All._ui.btn_selectButton_console:isValidate()
  PaGlobal_DeadMessage_All._ui.txt_siegeNotice:isValidate()
  PaGlobal_DeadMessage_All._ui.stc_paneltyBG:isValidate()
end
