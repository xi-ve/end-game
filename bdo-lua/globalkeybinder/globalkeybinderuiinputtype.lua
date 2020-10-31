local IM = CppEnums.EProcessorInputMode
local VCK = CppEnums.VirtualKeyCode
local UIMode = Defines.UIMode
function Process_UIMode_CommonWindow_MentalKnowledge()
  if GlobalValue_MiniGame_Value_HorseDrop == true then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_MINIGAMING_DO_NOT_USE"))
    return
  end
  if false == _ContentsGroup_RenewUI_Knowledge then
    Panel_Knowledge_Show()
  elseif PaGlobalFunc_Window_Knowledge_GetShow() then
    PaGlobalFunc_Window_Knowledge_Exit()
  else
    PaGlobalFunc_Window_Knowledge_Show()
  end
end
function Process_UIMode_CommonWindow_PositionNotify(fastPinDelta)
  local isGuild = false == isKeyPressed(VCK.KeyCode_SHIFT)
  local targetPosition = crossHair_GetTargetPosition()
  if true == ToClient_IsViewSelfPlayer(targetPosition) then
    if fastPinDelta < 0.5 then
      ToClient_RequestSendPositionGuide(isGuild, true, false, targetPosition)
      fastPinDelta = 10
    else
      ToClient_RequestSendPositionGuide(isGuild, false, false, targetPosition)
      fastPinDelta = 0
    end
  end
end
function Process_UIMode_CommonWindow_CashShop()
  if getContentsServiceType() == CppEnums.ContentsServiceType.eContentsServiceType_Commercial or isGameTypeTaiwan() then
    if PaGlobal_TutorialManager:isDoingTutorial() then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_GLOBALKEYBINDER_TUTORIALALERT"))
      return
    end
    InGameShop_Open()
  end
end
function Process_UIMode_CommonWindow_CashShop_HotDeal()
  InGameShop_SetHotDeal()
  Process_UIMode_CommonWindow_CashShop()
end
function Process_UIMode_CommonWindow_BlackSpirit()
  if true == Panel_Window_Exchange:GetShow() then
    return
  end
  if not IsSelfPlayerWaitAction() then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_CURRENTACTION_NOT_SUMMON_BLACKSPIRIT"))
    return
  end
  if true == PaGlobal_TutorialManager:isDoingTutorial() and false == PaGlobal_TutorialManager:isAllowCallBlackSpirit() then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_GLOBALKEYBINDER_TUTORIALALERT"))
    return
  end
  FGlobal_TentTooltipHide()
  ToClient_AddBlackSpiritFlush()
end
function Process_UIMode_CommonWindow_Chatting()
  if true == _ContentsGroup_RenewUI_Chatting then
    PaGlobalFunc_ChattingInfo_Open()
  else
    ChatInput_Show()
  end
end
function Process_UIMode_CommonWindow_ProductionNote()
  if nil ~= Panel_ProductNote and not Panel_ProductNote:IsUISubApp() then
    Panel_ProductNote_ShowToggle()
  end
end
function Process_UIMode_CommonWindow_ExpirienceWiki()
  if true == _ContentsGroup_ExpirienceWiki_All and true == _ContentsGroup_ExpirienceWiki_KorVersion then
    if nil == Panel_Window_ExpirienceWiki_All then
      _PA_ASSERT_NAME(false, "\235\170\168\237\151\152\234\176\128 \235\133\184\237\138\184\234\176\128 \235\161\156\235\147\156 \235\144\152\236\167\128 \236\149\138\236\149\152\236\138\181\235\139\136\235\139\164")
      return
    end
    PaGlobal_ExpirienceWiki_All_Open()
  else
    if nil == Panel_Window_ExpirienceWiki then
      _PA_ASSERT_NAME(false, "\235\170\168\237\151\152\234\176\128 \235\133\184\237\138\184\234\176\128 \235\161\156\235\147\156 \235\144\152\236\167\128 \236\149\138\236\149\152\236\138\181\235\139\136\235\139\164")
      return
    end
    PaGlobal_ExpirienceWiki_Open()
  end
end
function Process_UIMode_CommonWindow_PlayerInfo()
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  if true == _ContentsGroup_NewUI_CharInfo_All then
    if nil ~= Panel_CharacterInfo_All then
      if true == Panel_CharacterInfo_All:GetShow() then
        HandleEventLUp_ChracterInfo_All_CloseAll()
      else
        PaGlobalFunc_ChracterInfo_All_Open()
      end
      return
    end
  elseif true == _ContentsGroup_RenewUI then
    if Panel_Window_CharacterInfo_Renew ~= nil then
      if Panel_Window_CharacterInfo_Renew:GetShow() and not Panel_Window_CharacterInfo_Renew:IsUISubApp() then
        audioPostEvent_SystemUi(1, 31)
        _AudioPostEvent_SystemUiForXBOX(1, 31)
        PaGlobalFunc_Window_CharacterInfo_Close()
      else
        if true == _ContentsGroup_NewUI_ServantInfo_All then
          if true == PaGlobal_VehicleInfo_All_GetPanelShow() then
            PaGlobal_VehicleInfo_All_Close()
            Panel_Tooltip_Item_hideTooltip()
            TooltipSimple_Hide()
            return
          elseif true == PaGlobal_ShipInfo_All_GetShowPanel() then
            PaGlobal_ShipInfo_All_Close()
            Panel_Tooltip_Item_hideTooltip()
            TooltipSimple_Hide()
            return
          end
        elseif true == PaGlobalFunc_ServantInfo_GetShow() then
          PaGlobalFunc_ServantInfo_Exit()
          TooltipSimple_Hide()
          return
        end
        PaGlobalFunc_Window_CharacterInfo_Open()
      end
    end
  elseif nil ~= PaGlobal_CharacterInfoPanel_GetShowPanelStatus then
    if PaGlobal_CharacterInfoPanel_GetShowPanelStatus() and false == PaGlobal_CharacterInfoPanel_IsUISubAppStatus() then
      audioPostEvent_SystemUi(1, 31)
      _AudioPostEvent_SystemUiForXBOX(1, 31)
      if _ContentsGroup_isUsedNewCharacterInfo == false then
        CharacterInfoWindow_Hide()
      else
        PaGlobal_CharacterInfo:hideWindow()
      end
    else
      if true == _ContentsGroup_NewUI_ServantInfo_All then
        if true == PaGlobal_VehicleInfo_All_GetPanelShow() then
          PaGlobal_VehicleInfo_All_Close()
          Panel_Tooltip_Item_hideTooltip()
          TooltipSimple_Hide()
          return
        elseif true == PaGlobal_ShipInfo_All_GetShowPanel() then
          PaGlobal_ShipInfo_All_Close()
          Panel_Tooltip_Item_hideTooltip()
          TooltipSimple_Hide()
          return
        end
      elseif Panel_Window_ServantInfo:GetShow() or Panel_CarriageInfo:GetShow() or Panel_ShipInfo:GetShow() then
        ServantInfo_Close()
        CarriageInfo_Close()
        ShipInfo_Close()
        Panel_Tooltip_Item_hideTooltip()
        TooltipSimple_Hide()
        return
      end
      if _ContentsGroup_isUsedNewCharacterInfo == false then
        CharacterInfoWindow_Show()
      else
        local idx = PaGlobal_CharacterInfo_GetBasicIdx()
        PaGlobal_CharacterInfo:showWindow(idx)
      end
    end
  end
  local selfProxy = selfPlayer:get()
  if nil ~= selfProxy then
    local actorKeyRaw = selfProxy:getRideVehicleActorKeyRaw()
    local temporaryWrapper = getTemporaryInformationWrapper()
    local unsealCacheData = getServantInfoFromActorKey(actorKeyRaw)
    if nil ~= unsealCacheData then
      local inventory = unsealCacheData:getInventory()
      local invenSize = inventory:size()
      if 0 ~= actorKeyRaw then
        if true == _ContentsGroup_UsePadSnapping then
          return
        end
        if true == _ContentsGroup_NewUI_ServantInfo_All then
          if true == PaGlobal_VehicleInfo_All_GetPanelShow() then
            PaGlobal_VehicleInfo_All_Close()
          elseif true == PaGlobal_ShipInfo_All_GetShowPanel() then
            PaGlobal_ShipInfo_All_Close()
          end
          Panel_Tooltip_Item_hideTooltip()
          TooltipSimple_Hide()
        elseif Panel_Window_ServantInfo:GetShow() or Panel_CarriageInfo:GetShow() or Panel_ShipInfo:GetShow() then
          ServantInfo_Close()
          CarriageInfo_Close()
          ShipInfo_Close()
          Panel_Tooltip_Item_hideTooltip()
          TooltipSimple_Hide()
        end
        requestInformationFromServant()
        if true == _ContentsGroup_NewUI_ServantInfo_All then
          PaGlobal_VehicleInfo_All_Open(actorKeyRaw)
        else
          ServantInfo_BeforOpenByActorKeyRaw(actorKeyRaw)
        end
      end
    end
  end
end
function Process_UIMode_CommonWindow_Skill()
  if false == ToClient_IsGrowStepOpen(__eGrowStep_skillWindow) then
    return
  end
  if true == _ContentsGroup_UISkillGroupTreeLayOut then
    PaGlobalFunc_SkillGroup_HotKeyToggle()
  elseif false == _ContentsGroup_RenewUI then
    if nil ~= Panel_Window_Skill then
      if true == Panel_Window_Skill:IsShow() then
        audioPostEvent_SystemUi(1, 17)
        _AudioPostEvent_SystemUiForXBOX(1, 17)
        HandleMLUp_SkillWindow_Close()
      else
        audioPostEvent_SystemUi(1, 18)
        PaGlobal_Skill:SkillWindow_Show()
      end
    end
  elseif true == PaGlobalFunc_Skill_GetShow() then
    audioPostEvent_SystemUi(1, 17)
    _AudioPostEvent_SystemUiForXBOX(1, 17)
    PaGlobalFunc_Skill_Close()
  else
    audioPostEvent_SystemUi(1, 18)
    _AudioPostEvent_SystemUiForXBOX(1, 18)
    PaGlobalFunc_Skill_Open()
  end
end
function Process_UIMode_CommonWindow_PossessionByBlackSpirit()
  if PaGlobal_AutoManager._ActiveState then
    FGlobal_MouseclickTest()
  end
end
function Process_UIMode_CommonWindow_Inventory()
  if true == _ContentsGroup_RenewUI_ItemMarketPlace and true == PaGlobalFunc_MarketPlace_MyInven_GetShow() then
    return
  end
  if true == _ContentsGroup_RenewUI_Inventory then
    if false == PaGlobalFunc_InventoryInfo_GetShow() then
      PaGlobalFunc_InventoryInfo_Open(1)
    else
      PaGlobalFunc_InventoryInfo_Close()
    end
  else
    local isInvenOpen = false
    if true == _ContentsGroup_NewUI_Inventory_All then
      isInvenOpen = Panel_Window_Inventory_All:IsShow()
    else
      isInvenOpen = Panel_Window_Inventory:IsShow()
    end
    local isEquipOpen = false
    if true == _ContentsGroup_NewUI_Equipment_All then
      isEquipOpen = Panel_Window_Equipment_All:GetShow()
    else
      isEquipOpen = Panel_Equipment:IsShow()
    end
    local temporaryWrapper = getTemporaryInformationWrapper()
    local servantInfo = temporaryWrapper:getUnsealVehicle(CppEnums.ServantType.Type_Vehicle)
    local servantShipInfo = temporaryWrapper:getUnsealVehicle(CppEnums.ServantType.Type_Ship)
    if isInvenOpen == false and isEquipOpen == false then
      if isEquipOpen == false then
        if true == _ContentsGroup_NewUI_Equipment_All then
          PaGlobalFunc_Equipment_All_SetShow(true)
        else
          Equipment_SetShow(true)
        end
      end
      audioPostEvent_SystemUi(1, 16)
      _AudioPostEvent_SystemUiForXBOX(1, 16)
      InventoryWindow_Show(true)
      if nil ~= PaGlobalFunc_ServantInventory_GetShow and true == PaGlobalFunc_ServantInventory_GetShow() then
        TooltipSimple_Hide()
        Panel_Tooltip_Item_hideTooltip()
      end
    else
      if Panel_Window_Exchange:GetShow() then
        Panel_ExchangePC_BtnClose_Mouse_Click()
        return
      end
      local isInvenUISubApp = false
      if true == _ContentsGroup_NewUI_Inventory_All then
        isInvenUISubApp = Panel_Window_Inventory_All:IsUISubApp()
      else
        isInvenUISubApp = Panel_Window_Inventory:IsUISubApp()
      end
      if true == isInvenUISubApp and isEquipOpen == false then
        if true == _ContentsGroup_NewUI_Equipment_All then
          PaGlobalFunc_Equipment_All_SetShow(true)
        else
          Equipment_SetShow(true)
        end
      elseif true == _ContentsGroup_NewUI_Equipment_All then
        PaGlobalFunc_Equipment_All_SetShow(false)
      else
        Equipment_SetShow(false)
      end
      audioPostEvent_SystemUi(1, 15)
      _AudioPostEvent_SystemUiForXBOX(1, 15)
      InventoryWindow_Close()
      if nil ~= Panel_Window_ServantInventory then
        ServantInventory_Close()
      end
      if true == _ContentsGroup_NewUI_ClothInventory_All or true == _ContentsGroup_RenewUI then
        PaGlobalFunc_ClothInventory_All_Close()
      else
        ClothInventory_Close()
      end
      TooltipSimple_Hide()
    end
  end
end
function Process_UIMode_CommonWindow_Dyeing()
  if PaGlobal_TutorialManager:isDoingTutorial() then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_GLOBALKEYBINDER_TUTORIALALERT"))
    return
  end
  if MiniGame_Manual_Value_FishingStart == true then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_GLOBALKEYBINDER_FISHING_ACK"))
    return
  elseif true == _ContentsGroup_RenewUI_Dyeing then
    audioPostEvent_SystemUi(1, 24)
    _AudioPostEvent_SystemUiForXBOX(1, 24)
    if _ContentsGroup_NewUI_Dye_All then
      if nil ~= Panel_Widget_Dye_All and not Panel_Widget_Dye_All:GetShow() then
        PaGlobal_Dye_All_Open()
      end
    else
      PaGlobalFunc_Dyeing_Open()
    end
  else
    audioPostEvent_SystemUi(1, 24)
    _AudioPostEvent_SystemUiForXBOX(1, 24)
    if _ContentsGroup_NewUI_Dye_All then
      if nil ~= Panel_Widget_Dye_All and not Panel_Widget_Dye_All:GetShow() then
        PaGlobal_Dye_All_Open()
      end
    elseif nil ~= Panel_Dye_ReNew and not Panel_Dye_ReNew:GetShow() then
      FGlobal_Panel_Dye_ReNew_Open()
    end
  end
end
function Process_UIMode_CommonWindow_Present()
  if true == _ContentsGroup_NewUI_CharInfo_All then
    if nil ~= Panel_CharacterInfo_All then
      if true == Panel_CharacterInfo_All:GetShow() then
        if false == PaGlobalFunc_ChracterInfo_All_GetBgShow(PaGlobal_CharInfo_All._TABINDEX._challenge) then
          HandleEventLUp_ChracterInfo_All_ClickOtherTab(PaGlobal_CharInfo_All._TABINDEX._challenge)
          HandleEventLUp_CharInfoChallenge_All_ChallengeTabClick(5)
        else
          PaGlobalFunc_ChracterInfo_All_Close()
        end
      else
        PaGlobalFunc_ChracterInfo_All_Open(true)
        HandleEventLUp_ChracterInfo_All_ClickOtherTab(PaGlobal_CharInfo_All._TABINDEX._challenge)
        HandleEventLUp_CharInfoChallenge_All_ChallengeTabClick(5)
      end
    end
  elseif nil ~= PaGlobal_CharacterInfoPanel_GetShowPanelStatus and false == PaGlobal_CharacterInfoPanel_GetShowPanelStatus() then
    audioPostEvent_SystemUi(1, 34)
    _AudioPostEvent_SystemUiForXBOX(1, 34)
    if _ContentsGroup_isUsedNewCharacterInfo == false then
      FGlobal_Challenge_Show()
    else
      local idx = PaGlobal_CharacterInfo_GetChallengeIdx()
      PaGlobal_CharacterInfo:showWindow(idx)
      FGlobal_TapButton_Complete()
    end
  else
    audioPostEvent_SystemUi(1, 31)
    _AudioPostEvent_SystemUiForXBOX(1, 31)
    if _ContentsGroup_isUsedNewCharacterInfo == false then
      FGlobal_Challenge_Hide()
    else
      PaGlobal_CharacterInfo:hideWindow()
    end
  end
end
function Process_UIMode_CommonWindow_Manufacture()
  if MiniGame_Manual_Value_FishingStart == true then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_GLOBALKEYBINDER_FISHING_ACK"))
    return
  elseif 0 ~= ToClient_GetMyTeamNoLocalWar() then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_INVENTORY_LOCALWAR_ALERT"))
    return
  elseif true == PaGlobal_TutorialManager:isDoingTutorial() then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_GLOBALKEYBINDER_TUTORIALALERT"))
    return
  elseif false == ToClient_IsGrowStepOpen(__eGrowStep_manufacture) then
    return
  else
    if not IsSelfPlayerWaitAction() then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_CURRENTACTION_NOT_MANUFACTURE"))
      return
    end
    if _ContentsGroup_RenewUI_Manufacture then
      local isManufactureOpen = false
      if false == _ContentsGroup_NewUI_Manufacture_All then
        if false == PaGlobalFunc_ManufactureCheckShow() then
          audioPostEvent_SystemUi(1, 26)
          _AudioPostEvent_SystemUiForXBOX(1, 26)
          PaGlobalFunc_ManufactureOpen(true)
        else
          audioPostEvent_SystemUi(1, 25)
          _AudioPostEvent_SystemUiForXBOX(1, 25)
          PaGlobalFunc_ManufactureClose()
        end
      elseif false == Panel_Window_Manufacture_All:GetShow() then
        audioPostEvent_SystemUi(1, 26)
        _AudioPostEvent_SystemUiForXBOX(1, 26)
        PaGlobalFunc_Manufacture_All_Open(nil, CppEnums.ItemWhereType.eInventory, true)
      else
        audioPostEvent_SystemUi(1, 25)
        _AudioPostEvent_SystemUiForXBOX(1, 25)
        PaGlobalFunc_Manufacture_All_Close()
      end
    else
      local isInvenOpen = false
      if true == _ContentsGroup_NewUI_Inventory_All then
        isInvenOpen = Panel_Window_Inventory_All:GetShow()
      else
        isInvenOpen = Panel_Window_Inventory:GetShow()
      end
      local isManufactureOpen = false
      if false == _ContentsGroup_NewUI_Manufacture_All then
        if nil ~= Panel_Manufacture then
          isManufactureOpen = Panel_Manufacture:GetShow()
        end
      elseif nil ~= Panel_Window_Manufacture_All then
        isManufactureOpen = Panel_Window_Manufacture_All:GetShow()
      end
      if isManufactureOpen == false or isInvenOpen == false then
        audioPostEvent_SystemUi(1, 26)
        _AudioPostEvent_SystemUiForXBOX(1, 26)
        if false == _ContentsGroup_NewUI_Manufacture_All then
          Manufacture_Show(nil, CppEnums.ItemWhereType.eInventory, true)
        else
          PaGlobalFunc_Manufacture_All_Open(nil, CppEnums.ItemWhereType.eInventory, true)
        end
      else
        audioPostEvent_SystemUi(1, 25)
        _AudioPostEvent_SystemUiForXBOX(1, 25)
        if not _ContentsGroup_RenewUI_Manufacture then
          if false == _ContentsGroup_NewUI_Manufacture_All then
            Manufacture_Close()
          else
            PaGlobalFunc_Manufacture_All_Close()
          end
        end
      end
    end
  end
end
function Process_UIMode_CommonWindow_Guild()
  local guildWrapper = ToClient_GetMyGuildInfoWrapper()
  if false == _ContentsGroup_RenewUI_Guild then
    if nil ~= guildWrapper then
      local guildGrade = guildWrapper:getGuildGrade()
      if 0 == guildGrade then
        if true == _ContentsGroup_NewUI_Guild_All then
          if false == Panel_Window_ClanList_All:IsShow() then
            audioPostEvent_SystemUi(1, 36)
            _AudioPostEvent_SystemUiForXBOX(1, 36)
            PaGlobal_ClanList_All_Open()
          else
            audioPostEvent_SystemUi(1, 31)
            _AudioPostEvent_SystemUiForXBOX(1, 31)
            PaGlobal_ClanList_All_Close()
          end
        elseif false == Panel_ClanList:IsShow() then
          audioPostEvent_SystemUi(1, 36)
          _AudioPostEvent_SystemUiForXBOX(1, 36)
          FGlobal_ClanList_Open()
        else
          audioPostEvent_SystemUi(1, 31)
          _AudioPostEvent_SystemUiForXBOX(1, 31)
          FGlobal_ClanList_Close()
        end
      elseif false == _ContentsGroup_NewUI_Guild_All then
        local isPanelGuildShow = false
        if nil == PaGlobal_GuildPanelLoad_GetShowPanelGuildMain then
          isPanelGuildShow = Panel_Window_Guild:IsShow()
        else
          isPanelGuildShow = PaGlobal_GuildPanelLoad_GetShowPanelGuildMain()
        end
        if false == isPanelGuildShow then
          audioPostEvent_SystemUi(1, 36)
          _AudioPostEvent_SystemUiForXBOX(1, 36)
          GuildManager:Show()
        else
          audioPostEvent_SystemUi(1, 31)
          _AudioPostEvent_SystemUiForXBOX(1, 31)
          GuildManager:Hide()
        end
      elseif nil ~= Panel_GuildMain_All then
        if true == Panel_GuildMain_All:GetShow() then
          audioPostEvent_SystemUi(1, 36)
          _AudioPostEvent_SystemUiForXBOX(1, 36)
          PaGlobalFunc_GuildMain_All_Close()
        else
          audioPostEvent_SystemUi(1, 36)
          _AudioPostEvent_SystemUiForXBOX(1, 36)
          PaGlobalFunc_GuildMain_All_Open()
        end
      end
    elseif false == _ContentsGroup_RenewUI then
      if true == _ContentsGroup_Guild_JoinRequest then
        if nil ~= Panel_Guild_NoneGuild and true == Panel_Guild_NoneGuild:GetShow() then
          PaGlobal_Guild_NoneGuild_SetShow(false)
        else
          PaGlobal_Guild_NoneGuild_SetShow(true)
        end
      else
        PaGlobal_GuildNonJoinMember_SetShow(true)
      end
    end
  elseif nil ~= guildWrapper then
    local guildGrade = guildWrapper:getGuildGrade()
    if 0 == guildGrade then
      if true == _ContentsGroup_NewUI_Guild_All then
        if false == Panel_Window_ClanList_All:IsShow() then
          audioPostEvent_SystemUi(1, 36)
          _AudioPostEvent_SystemUiForXBOX(1, 36)
          PaGlobal_ClanList_All_Open()
        else
          audioPostEvent_SystemUi(1, 31)
          _AudioPostEvent_SystemUiForXBOX(1, 31)
          PaGlobal_ClanList_All_Close()
        end
      elseif false == Panel_ClanList:IsShow() then
        audioPostEvent_SystemUi(1, 36)
        _AudioPostEvent_SystemUiForXBOX(1, 36)
        FGlobal_ClanList_Open()
      else
        audioPostEvent_SystemUi(1, 31)
        _AudioPostEvent_SystemUiForXBOX(1, 31)
        FGlobal_ClanList_Close()
      end
    elseif true == _ContentsGroup_NewUI_Guild_All then
      if nil ~= Panel_GuildMain_All then
        if true == Panel_GuildMain_All:GetShow() then
          audioPostEvent_SystemUi(1, 36)
          _AudioPostEvent_SystemUiForXBOX(1, 36)
          PaGlobalFunc_GuildMain_All_Close()
        else
          audioPostEvent_SystemUi(1, 36)
          _AudioPostEvent_SystemUiForXBOX(1, 36)
          PaGlobalFunc_GuildMain_All_Open()
        end
      end
    elseif false == PaGlobalFunc_GuildMain_GetShow() then
      audioPostEvent_SystemUi(1, 36)
      _AudioPostEvent_SystemUiForXBOX(1, 36)
      PaGlobalFunc_GuildMain_Open()
    else
      audioPostEvent_SystemUi(1, 31)
      _AudioPostEvent_SystemUiForXBOX(1, 31)
      PaGlobalFunc_GuildMain_Close()
    end
  else
    local messageBoxData = {
      title = PAGetString(Defines.StringSheet_GAME, "LUA_MESSAGEBOX_NOTIFY"),
      content = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_NO_GUILD"),
      functionYes = MessageBox_Empty_function,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageBoxData)
  end
end
function Process_UIMode_CommonWindow_Mail()
  local isMailMain = false
  if false == _ContentsGroup_NewUI_Mail_All then
    if Panel_Mail_Main ~= nil and Panel_Mail_Detail ~= nil then
      isMailMain = Panel_Mail_Main:IsShow()
      if isMailMain == false then
        audioPostEvent_SystemUi(1, 22)
        _AudioPostEvent_SystemUiForXBOX(1, 22)
        Mail_Open()
      else
        audioPostEvent_SystemUi(1, 21)
        _AudioPostEvent_SystemUiForXBOX(1, 22)
        Mail_Close()
      end
    elseif Panel_Window_Mail_Renew ~= nil and Panel_Window_MailDetail_Renew ~= nil then
      isMailMain = Panel_Window_Mail_Renew:IsShow()
      if isMailMain == false then
        audioPostEvent_SystemUi(1, 22)
        _AudioPostEvent_SystemUiForXBOX(1, 22)
        Mail_Open()
      else
        audioPostEvent_SystemUi(1, 21)
        _AudioPostEvent_SystemUiForXBOX(1, 21)
        Mail_Close()
      end
    end
  else
    isMailMain = Panel_Window_Mail_All:IsShow()
    if isMailMain == false then
      audioPostEvent_SystemUi(1, 22)
      _AudioPostEvent_SystemUiForXBOX(1, 22)
      PaGlobal_Window_Mail_All_Open()
    else
      audioPostEvent_SystemUi(1, 21)
      _AudioPostEvent_SystemUiForXBOX(1, 22)
      PaGlobal_Window_Mail_All_Close()
    end
  end
end
function Process_UIMode_CommonWindow_FriendList()
  if Panel_FriendList ~= nil then
    local isFriendList = Panel_FriendList:IsShow()
    if isFriendList == false then
      FriendList_show()
      audioPostEvent_SystemUi(1, 28)
      _AudioPostEvent_SystemUiForXBOX(1, 28)
    else
      FriendList_hide()
      audioPostEvent_SystemUi(1, 27)
      _AudioPostEvent_SystemUiForXBOX(1, 27)
    end
  end
  if true == _ContentsGroup_NewUI_Friend_All and Panel_FriendList_All ~= nil then
    local isFriendList = Panel_FriendList_All:IsShow()
    if isFriendList == false then
      PaGlobal_FriendList_Show_All()
      audioPostEvent_SystemUi(1, 28)
      _AudioPostEvent_SystemUiForXBOX(1, 28)
    else
      PaGlobal_FriendList_Hide_All()
      audioPostEvent_SystemUi(1, 27)
      _AudioPostEvent_SystemUiForXBOX(1, 27)
    end
  end
end
function Process_UIMode_CommonWindow_QuestHistory()
  if true == ToClient_IsInstanceFieldPlayerbyContentsType(__eInstanceContentsType_SavageDefence) then
    return
  end
  local QuestWindowSound = function(isOpen)
    if true == isOpen then
      audioPostEvent_SystemUi(1, 29)
      _AudioPostEvent_SystemUiForXBOX(1, 29)
    elseif false == isOpen then
      audioPostEvent_SystemUi(1, 27)
      _AudioPostEvent_SystemUiForXBOX(1, 27)
    end
  end
  if true == _ContentsGroup_RenewUI then
    if true == _ContentsGroup_NewUI_Quest_All then
      if Panel_Window_Quest_All:GetShow() then
        QuestWindowSound(false)
        PaGlobalFunc_Quest_All_Close()
      else
        QuestWindowSound(true)
        PaGlobalFunc_Quest_All_Open()
      end
    elseif true == PaGlobalFunc_Quest_GetShow() then
      QuestWindowSound(false)
      PaGlobalFunc_Quest_SetShow(false)
    else
      QuestWindowSound(false)
      PaGlobalFunc_Quest_SetShow(true)
    end
  elseif true == _ContentsGroup_NewUI_Quest_All then
    if Panel_Window_Quest_All:GetShow() and false == Panel_Window_Quest_All:IsUISubApp() then
      QuestWindowSound(false)
      PaGlobalFunc_Quest_All_Close()
    else
      QuestWindowSound(true)
      PaGlobalFunc_Quest_All_Open()
    end
  elseif Panel_Window_Quest_New:GetShow() then
    QuestWindowSound(false)
    Panel_Window_QuestNew_Show(false)
  else
    QuestWindowSound(true)
    Panel_Window_QuestNew_Show(true)
  end
  TooltipSimple_Hide()
end
function Process_UIMode_CommonWindow_BeautyShop()
  if false == _ContentsGroup_RenewUI_Customization then
    if not isKeyPressed(VCK.KeyCode_MENU) then
      if PaGlobal_TutorialManager:isDoingTutorial() then
        Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_GLOBALKEYBINDER_TUTORIALALERT"))
        return
      end
      if not getCustomizingManager():isShow() then
        IngameCustomize_Show()
        return
      end
    end
  elseif not isKeyPressed(VCK.KeyCode_MENU) then
    if PaGlobal_TutorialManager:isDoingTutorial() then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_GLOBALKEYBINDER_TUTORIALALERT"))
      return
    end
    if false == PaGlobalFunc_Customization_GetShow() then
      IngameCustomize_Show()
    end
  end
end
function Process_UIMode_CommonWindow_WorldMap()
  if not Panel_Global_Manual:GetShow() or FGlobal_BulletCount_UiShowCheck() then
    if true == _ContentsGroup_RenewUI_WorldMap then
      PaGlobalFunc_WorldMap_Open()
    else
      PaGlobalFunc_MarketPlace_Close()
      FGlobal_PushOpenWorldMap()
    end
  else
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_GLOBALKEYBINDER_MINIGAMING_NOT_WORLDMAP"))
    return
  end
  if false == _ContentsGroup_UsePadSnapping then
    PaGlobalFunc_Panel_WorldMap_Open()
  end
end
function Process_UIMode_CommonWindow_House()
  if Panel_HousingList:GetShow() then
    HousingList_Close()
  else
    FGlobal_HousingList_Open()
  end
end
function Process_UIMode_CommonWindow_WorkerManager()
  if true == _ContentsGroup_NewUI_WorkerManager_All then
    PaGlobalFunc_WorkerManager_All_ShowToggle()
  else
    FGlobal_WorkerManger_ShowToggle()
  end
end
function Process_UIMode_CommonWindow_Maid()
  if false == _ContentsGroup_NewUI_Maid_All then
    if nil ~= Panel_Window_MaidList and true == Panel_Window_MaidList:GetShow() then
      MaidList_Close()
    else
      MaidList_Open()
    end
  elseif nil ~= Panel_Window_MaidList_All and true == Panel_Window_MaidList_All:GetShow() then
    PaGlobalFunc_MaidList_All_Close()
  else
    PaGlobalFunc_MaidList_All_Open()
  end
end
function Process_UIMode_CommonWindow_DeleteNavigation()
  if true == PaGlobal_TutorialManager:isDoingTutorial() then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_RADER_TUTORIAL_PROGRSS_ACK"))
    return
  end
  ToClient_DeleteNaviGuideByGroup(0)
  Panel_NaviButton:SetShow(false)
  audioPostEvent_SystemUi(0, 15)
  _AudioPostEvent_SystemUiForXBOX(0, 15)
end
function Process_UIMode_CommonWindow_AdventureBook()
  if false == _ContentsGroup_NewUI_Achievement_All then
    PaGlobal_Achievement_BookShelf_Open()
  else
    PaGlobalFunc_Achievement_BookShelf_All_ShowToggle()
  end
end
function Process_UIMode_CommonWindow_BlackGift()
  if true == _ContentsGroup_NewUI_TotalReward_All then
    PaGlobal_TotalReward_All_Open()
  else
    PaGlobal_TotalReward_Open()
  end
end
function Process_UIMode_CommonWindow_CallServantWater()
  ToClient_AutoRideOnShip()
end
function Process_UIMode_CommonWindow_BarterInfo()
  PaGlobal_BarterInfoSearch_OpenToggle()
end
function Process_UIMode_CommonWindow_PartySetting()
  if true == PaGlobal_TutorialManager:isDoingTutorial() then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_GLOBALKEYBINDER_TUTORIALALERT"))
    return
  end
  audioPostEvent_SystemUi(0, 16)
  _AudioPostEvent_SystemUiForXBOX(0, 16)
  PaGlobalFunc_PartySetting_Open(CppEnums.PartyType.ePartyType_Normal)
end
function Process_UIMode_CommonWindow_PlatoonSetting()
  if true == PaGlobal_TutorialManager:isDoingTutorial() then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_GLOBALKEYBINDER_TUTORIALALERT"))
    return
  end
  audioPostEvent_SystemUi(0, 16)
  _AudioPostEvent_SystemUiForXBOX(0, 16)
  PaGlobalFunc_PartySetting_Open(CppEnums.PartyType.ePartyType_Large)
end
