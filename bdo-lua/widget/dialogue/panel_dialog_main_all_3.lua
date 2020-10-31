function FromClient_DialogFunctionClick_Contents_Shop()
  local targetWindowList
  local count = 0
  local dialogData = ToClient_GetCurrentDialogData()
  local shopType = dialogData:getShopType()
  local isMessageBox = PaGlobal_DialogMain_All:shopTypeMessage(shopType)
  if true == isMessageBox then
    return
  end
  if true == _ContentsGroup_NewUI_NpcShop_All and nil ~= Panel_Dialog_NPCShop_All then
    if true == _ContentsGroup_NewUI_Inventory_All then
      targetWindowList = {Panel_Dialog_NPCShop_All, Panel_Window_Inventory_All}
    else
      targetWindowList = {Panel_Dialog_NPCShop_All, Panel_Window_Inventory}
    end
  elseif true == _ContentsGroup_NewUI_Inventory_All then
    targetWindowList = {Panel_Window_NpcShop, Panel_Window_Inventory_All}
  else
    targetWindowList = {Panel_Window_NpcShop, Panel_Window_Inventory}
  end
  count = 2
  PaGlobal_DialogMain_All:innerPanelShow(count, targetWindowList)
  npcShop_requestList(CppEnums.ContentsType.Contents_Shop)
  FGlobal_NodeWarMenuClose()
end
function FromClient_DialogFunctionClick_Contents_Skill()
  local targetWindowList
  local count = 0
  if false == _ContentsGroup_RenewUI_Skill then
    count = 1
    if false == _ContentsGroup_UISkillGroupTreeLayOut then
      targetWindowList = {Panel_Window_Skill}
    else
      targetWindowList = {Panel_Window_SkillGroup}
    end
  end
  PaGlobal_DialogMain_All:innerPanelShow(count, targetWindowList)
  if false == _ContentsGroup_RenewUI_Skill then
    if false == _ContentsGroup_UISkillGroupTreeLayOut then
      HandleMLUp_SkillWindow_OpenForLearn()
    else
      PaGlobal_SkillGroup:setDialog(true)
      HandleMLUp_SkillWindow_OpenForLearn()
      PaGlobalFunc_DialogMain_All_ShowToggle(false)
    end
  elseif true == ToClient_LearnSkillCameraIsShowable() then
    PaGlobalFunc_Skill_Open(true)
    PaGlobalFunc_DialogMain_All_ShowToggle(false)
  end
end
function FromClient_DialogFunctionClick_Contents_Guild()
  if false == _ContentsGroup_NewUI_CreateClan_All then
    if false == _ContentsGroup_RenewUI then
      FGlobal_GuildCreateManagerPopup()
    else
      PaGlobalFunc_GuildPopup_Open()
    end
  else
    PaGlobal_CreateClan_All_Open()
  end
end
function FromClient_DialogFunctionClick_Contents_Enchant()
  if false == _ContentsGroup_NewUI_SpiritEnchant_All then
    if false == _ContentsGroup_RenewUI then
      PaGlobal_Enchant:enchant_Show()
    else
      PaGlobalFunc_EnchantInfo_Open()
    end
  else
    PaGlobalFunc_SpiritEnchant_All_Open()
    PaGlobalFunc_DialogMain_All_ShowToggle(false)
  end
end
function FromClient_DialogFunctionClick_Contents_Socket()
  if true == _ContentsGroup_NewUI_Socket_All then
    PaGlobalFunc_Socket_All_Open()
  elseif false == _ContentsGroup_RenewUI then
    Socket_Window_Show()
  else
    PaGlobalFunc_SocketInfo_Open()
  end
end
function FromClient_DialogFunctionClick_Contents_LordMenu()
  if false == _ContentsGroup_NewUI_LordMenu_All then
    if false == _ContentsGroup_RenewUI then
      LordMenu_Show()
    else
      PaGlobalFunc_LordMenu_Open()
    end
  else
    PaGlobalFunc_LordMenu_All_Open()
  end
end
function FromClient_DialogFunctionClick_Contents_Extract()
  if false == _ContentsGroup_NewUI_ExtractionFunction_All then
    if false == _ContentsGroup_RenewUI then
      if nil ~= Panel_Window_Extraction then
        PaGlobal_Extraction:openPanel(true)
      end
    else
      PaGlobalFunc_ExtractInfo_Open()
    end
  else
    PaGlobal_Extraction_All_Open()
  end
end
function FromClient_DialogFunctionClick_Contents_TerritoryTrade()
  npcShop_requestList(CppEnums.ContentsType.Contents_TerritoryTrade)
end
function FromClient_DialogFunctionClick_Contents_TerritorySupply()
  if true == PaGlobal_DialogMain_All._isConsole then
  end
  npcShop_requestList(CppEnums.ContentsType.Contents_TerritorySupply)
end
function FromClient_DialogFunctionClick_Contents_GuildShop()
  local targetWindowList
  local count = 0
  count = 2
  if true == _ContentsGroup_NewUI_NpcShop_All then
    if true == _ContentsGroup_NewUI_Inventory_All then
      targetWindowList = {Panel_Dialog_NPCShop_All, Panel_Window_Inventory_All}
    else
      targetWindowList = {Panel_Dialog_NPCShop_All, Panel_Window_Inventory}
    end
  elseif false == _ContentsGroup_RenewUI then
    if true == _ContentsGroup_NewUI_Inventory_All then
      targetWindowList = {Panel_Window_NpcShop, Panel_Window_Inventory_All}
    else
      targetWindowList = {Panel_Window_NpcShop, Panel_Window_Inventory}
    end
  else
    targetWindowList = {Panel_Dialog_NPCShop, Panel_Window_Inventory}
  end
  PaGlobal_DialogMain_All:innerPanelShow(count, targetWindowList)
  npcShop_requestList(CppEnums.ContentsType.Contents_GuildShop)
end
function FromClient_DialogFunctionClick_Contents_SupplyShop()
  npcShop_requestList(CppEnums.ContentsType.Contents_SupplyShop)
end
function FromClient_DialogFunctionClick_Contents_FishSupplyShop()
  npcShop_requestList(CppEnums.ContentsType.Contents_FishSupplyShop)
end
function FromClient_DialogFunctionClick_Contents_GuildSupplyShop()
  npcShop_requestList(CppEnums.ContentsType.Contents_GuildSupplyShop)
end
function FromClient_DialogFunctionClick_Contents_MinorLordMenu()
  FGlobal_NodeWarMenuOpen()
end
function FromClient_DialogFunctionClick_Contents_Improve()
  if true == _ContentsGroup_NewUI_Improvement_All then
    PaGlobalFunc_Improvement_All_Open()
  elseif false == _ContentsGroup_RenewUI then
    Panel_Improvement_Show()
  else
    PaGlobalFunc_ImprovementInfo_Open()
  end
end
function FromClient_DialogFunctionClick_Contents_Repair()
  if true == _ContentsGroup_NewUI_RepairFunction_All then
    PaGlobalFunc_RepairFunc_All_Open(PaGlobal_RepairFunc_All._eType._dialog)
  elseif false == _ContentsGroup_RenewUI then
    PaGlobal_Repair:repair_OpenPanel(true, PaGlobal_Repair._eType._dialog)
  else
    PaGlobalFunc_RepairInfo_Open()
  end
end
function FromClient_DialogFunctionClick_Contents_Warehouse()
  if true == _ContentsGroup_NewUI_WareHouse_All then
    PaGlobal_Warehouse_All_OpenPanelFromDialog()
  else
    Warehouse_OpenPanelFromDialog()
  end
end
function FromClient_DialogFunctionClick_Contents_Stable()
  if isGuildStable() then
    if false == _ContentsGroup_NewUI_Servant_All then
      if CppEnums.ServantType.Type_Vehicle == stable_getServantType() then
        GuildStableFunction_Open()
      elseif CppEnums.ServantType.Type_Ship == stable_getServantType() then
        GuildWharfFunction_Open()
      end
    else
      PaGlobalFunc_ServantFunction_All_Open(isGuildStable(), stable_getServantType())
    end
  else
    warehouse_requestInfoFromNpc()
    if false == _ContentsGroup_NewUI_Servant_All then
      if CppEnums.ServantType.Type_Vehicle == stable_getServantType() then
        if false == _ContentsGroup_RenewUI then
          StableFunction_Open()
        else
          PaGlobalFunc_StableFunction_Open()
        end
      elseif CppEnums.ServantType.Type_Ship == stable_getServantType() then
        if false == _ContentsGroup_RenewUI then
          if 1 == ToClient_getGameUIManagerWrapper():getLuaCacheDataListNumber(9991) then
            PaGlobal_SailorManager_All:prepareOpen()
          else
            WharfFunction_Open()
          end
        else
          PaGlobalFunc_WharfFunction_Show()
        end
      else
        PetFunction_Open()
        PetList_Open()
      end
    elseif CppEnums.ServantType.Type_Vehicle == stable_getServantType() then
      PaGlobalFunc_ServantFunction_All_Open(isGuildStable(), CppEnums.ServantType.Type_Vehicle)
    elseif CppEnums.ServantType.Type_Ship == stable_getServantType() then
      if 1 == ToClient_getGameUIManagerWrapper():getLuaCacheDataListNumber(9991) then
        PaGlobal_SailorManager_All:prepareOpen()
      else
        PaGlobalFunc_ServantFunction_All_Open(isGuildStable(), CppEnums.ServantType.Type_Ship)
      end
    else
      PetFunction_Open()
      PetList_Open()
    end
  end
  show_DialogPanel()
end
function FromClient_DialogFunctionClick_Contents_Transfer()
  DeliveryInformation_OpenPanelFromDialog()
end
function FromClient_DialogFunctionClick_Contents_ItemMarket()
  if PaGlobalFunc_ItemMarket_IsUISubApp() then
    Panel_Window_ItemMarket:CloseUISubApp()
    Panel_Window_ItemMarket:SetShow(false)
  end
  if not PaGlobalFunc_ItemMarket_GetShow() then
    FGolbal_ItemMarket_Function_Open()
  else
    FGolbal_ItemMarket_Function_Close()
  end
end
function FromClient_DialogFunctionClick_Contents_NewItemMarket()
  if not PaGlobalFunc_MarketPlace_GetShow() then
    PaGlobalFunc_MarketPlace_OpenFromDialog()
  else
    PaGlobalFunc_MarketPlace_CloseToDialog()
  end
end
function FromClient_DialogFunctionClick_Contents_Knowledge()
  if false == _ContentsGroup_RenewUI then
    FGlobal_KnowledgeManagementShow()
  else
    PaGlobalFunc_KnowledgeManage_Open()
  end
end
function FromClient_DialogFunctionClick_Contents_Join()
  Panel_Join_Show()
end
function FromClient_DialogFunctionClick_Contents_NpcGift()
  if true == _ContentsGroup_NewUI_NpcGift_All then
    PaGlobalFunc_DialogNpcGift_All_Open()
  else
    FGlobal_NpcGift_Open()
  end
  PaGlobalFunc_DialogIntimacy_All_Open()
end
function FromClient_DialogFunctionClick_Contents_WeakenEnchant()
  if true == _ContentsGroup_NewUI_Purification_All then
    PaGlobalFunc_Purification_All_Open()
  else
    PuriManager:Open()
  end
end
function FromClient_DialogFunctionClick_Contents_Employee()
  local talker = dialog_getTalker()
  if nil ~= talker then
    local charSSW = getCharacterStaticStatusWarpper(talker:getCharacterKey())
    if nil ~= charSSW then
      local needItemKey = ToClient_GetEmployeeNeedItemKey(talker:getCharacterKey())
      local slotNo = ToClient_InventoryGetSlotNo(needItemKey)
      ToClient_requestRegisterEmployee(slotNo)
      ToClient_PopDialogueFlush()
    end
  end
end
function FromClient_DialogFunctionClick_Contents_HelpDesk()
  PaGlobalFunc_DialogList_All_Open()
end
function FromClient_DialogFunctionClick_Contents_EdanPass()
  PaGlobalFunc_EdanPass_Open()
end
function FromClient_DialogFunctionClick_Contents_SeasonReward()
  PaGlobal_SeasonReward_All_Open()
end
function PaGloalFunc_DialogMain_All_PreClosePanel()
  if nil == Panel_Npc_Dialog_All then
    return
  end
  local simpleCloseFuncs = {
    DetectPlayer_Close,
    InventoryWindow_Close,
    ClothInventory_Close,
    Panel_Tooltip_Item_hideTooltip,
    Panel_SkillTooltip_Hide,
    FGlobal_BuffTooltipOff,
    Interaction_Close,
    Panel_MovieTheater_LowLevel_WindowClose
  }
  for index = 1, #simpleCloseFuncs do
    local func = simpleCloseFuncs[index]
    if nil ~= func then
      func()
    end
  end
  local checkCloseFuncs = {
    PreClose_Improvement,
    PreClose_Skill,
    PreClose_QuestInfo,
    PreClose_ReinforceSkill,
    PreClose_GameOption,
    PreClose_ItemMarket,
    PreClose_WareHouse,
    PreClose_Shop,
    PreClose_BlackSmith,
    PreClose_DyeColor,
    PreClose_WorkerManager,
    PreClose_WorkerAuction,
    PreClose_Menu,
    PreClose_Camp,
    PreClose_SearchMode,
    PreClose_SpiritEnchant,
    PreClose_Socket,
    PreClose_KnowledgeManagement,
    PreClose_NPCGift,
    PreClose_MasterpieceAuction,
    PreClose_Dialog,
    PreClose_GameExit,
    PreClose_Exchange,
    PreClose_MarketPlace
  }
  for index = 1, #checkCloseFuncs do
    local func = checkCloseFuncs[index]
    if nil ~= func then
      func()
    end
  end
  if nil ~= close_WindowPanelList then
    close_WindowPanelList()
  end
end
function PaGlobalFunc_DialogMain_All_CloseWithDialog()
  local simpleCloseFuncs = {
    PaGlobalFunc_DialogQuest_All_Close,
    PaGlobalFunc_MarketPlace_WalletInven_Close,
    PaGlobalFunc_MarketPlace_MyInven_Close,
    ServantInventory_Close,
    FGlobal_RaceInfo_Hide,
    GuildServantList_Close,
    DetectPlayer_Close,
    BlackSpiritAd_Hide,
    click_DeliveryForPerson_Close,
    FGlobal_NodeWarMenuClose,
    ChatInput_Close,
    InventoryWindow_Close
  }
  for index = 1, #simpleCloseFuncs do
    local func = simpleCloseFuncs[index]
    if nil ~= func then
      func()
    end
  end
  local checkCloseFuncs = {
    PreClose_ReinforceSkill,
    PreClose_ItemMarket,
    PreClose_Improvement,
    PreClose_EasyBuy,
    PreClose_BlackSmith,
    PreClose_TranslationReport,
    PreClose_WareHouse,
    PreClose_CreateGuildClan,
    PreClose_Skill,
    PreClose_MonsterBar,
    PreClose_Exchange,
    PreClose_GuildHouseAuction,
    PreClose_Shop,
    PreClose_Manufacture,
    PreClose_WorkerAuction,
    PreClose_NPCGift,
    PreClose_Purification,
    PreClose_SpiritEnchant,
    PreClose_Socket,
    PreClose_MasterpieceAuction,
    PreClose_Customize,
    PreClose_TradeMarket,
    PreClose_ServantDialog,
    CloseWith_BlackSmith,
    PreClose_ServantInfo,
    PreClose_MarketPlace,
    PreClose_Knowledge,
    PreClose_Dye,
    PreClose_RandomShop,
    CloseWith_Dialog,
    PreClose_LordMenu,
    PreClose_Delivery
  }
  for index = 1, #checkCloseFuncs do
    local func = checkCloseFuncs[index]
    if nil ~= func then
      func()
    end
  end
  return true
end
function FromClient_DialogMain_All_CloseAllPanelWhenNpcGoHome()
  if GetUIMode() == Defines.UIMode.eUIMode_Stable then
    if false == _ContentsGroup_NewUI_Servant_All then
      if nil ~= Panel_Window_StableFunction and true == Panel_Window_StableFunction:GetShow() then
        StableFunction_Close()
      end
    elseif nil ~= Panel_Dialog_ServantFunction_All and true == Panel_Dialog_ServantFunction_All:GetShow() then
      PaGlobalFunc_ServantFunction_All_Close()
    end
  end
  if false == _ContentsGroup_NewUI_Servant_All then
    if nil ~= Panel_Window_WharfFunction and true == Panel_Window_WharfFunction:GetShow() then
      WharfFunction_Close()
    end
  elseif nil ~= Panel_Dialog_ServantFunction_All and true == Panel_Dialog_ServantFunction_All:GetShow() then
    PaGlobalFunc_ServantFunction_All_Close()
  end
  if GetUIMode() == Defines.UIMode.eUIMode_Trade then
    if true == _ContentsGroup_NewUI_TradeMarket_All then
      if nil ~= Panel_Dialog_Trade_Function_All and true == Panel_Dialog_Trade_Function_All:GetShow() then
        HandleEventLUp_TradeFunction_All_Close()
      end
    elseif nil ~= Panel_Npc_Trade_Market and true == Panel_Npc_Trade_Market:GetShow() then
      closeNpcTrade_Basket()
    end
  end
  if GetUIMode() == Defines.UIMode.eUIMode_Repair then
    if true == _ContentsGroup_NewUI_RepairFunction_All then
      PaGlobalFunc_RepairFunc_All_Close()
    elseif true == _ContentsGroup_RenewUI_Repair then
      PaGlobalFunc_RepairInfo_Close()
    else
      PaGlobal_Repair:repair_OpenPanel(false, nil)
    end
  end
  if GetUIMode() == Defines.UIMode.eUIMode_Extraction then
    if false == _ContentsGroup_NewUI_ExtractionFunction_All then
      PaGlobal_Extraction:openPanel(false)
    else
      PaGlobal_Extraction_All_Close()
    end
  end
  if GetUIMode() == Defines.UIMode.eUIMode_MentalGame then
    if false == _ContentsGroup_NewUI_MentalGame_All then
      MentalGame_Hide()
    else
      PaGlobalFunc_MentalGame_All_Close()
    end
  end
end
function PreClose_Improvement()
  if true == _ContentsGroup_NewUI_Improvement_All then
    if nil ~= Panel_Window_Improvement_All and true == Panel_Window_Improvement_All:GetShow() then
      if true == PaGlobal_Improvement_All_IsImprovementing() then
        return false
      end
      PaGlobalFunc_Improvement_All_Close()
    end
  elseif nil ~= Panel_Improvement and true == Panel_Improvement:GetShow() then
    if true == PaGlobal_Improvement_IsImprovementing() then
      return false
    end
    Panel_Improvement_Hide()
  end
end
function PreClose_Skill()
  if false == _ContentsGroup_RenewUI_Skill then
    HandleMLUp_SkillWindow_Close()
  end
  if nil ~= Panel_SkillAwaken and true == Panel_SkillAwaken:GetShow() then
    SkillAwaken_Close()
  end
  if nil ~= Panel_Window_SkillGroup and true == Panel_Window_SkillGroup:GetShow() then
    PaGlobalFunc_SkillGroup_Close()
  end
end
function PreClose_ReinforceSkill()
  if false == PaGlobal_DialogMain_All._isConsole then
    Panel_Window_ReinforceSkill_Close()
    Panel_SkillReinforce_Close()
  end
end
function PreClose_QuestInfo()
  if nil ~= Panel_QuestInfo and true == Panel_QuestInfo:GetShow() then
    questInfo_TooltipShow(false)
  end
end
function PreClose_GameOption()
  if nil ~= FGlobal_Option_GetShow and true == FGlobal_Option_GetShow() then
    GameOption_Cancel()
    TooltipSimple_Hide()
  end
end
function PreClose_ItemMarket()
  if nil ~= PaGlobalFunc_ItemMarketFunction_GetShow and true == PaGlobalFunc_ItemMarketFunction_GetShow() then
    FGolbal_ItemMarket_Function_Close()
    if nil ~= PaGlobalFunc_ItemMarketRegistItem_GetShow and true == PaGlobalFunc_ItemMarketRegistItem_GetShow() then
      FGlobal_ItemMarketRegistItem_Close()
    end
    if nil ~= PaGlobalFunc_ItemMarketBuyConfirm_GetShow and true == PaGlobalFunc_ItemMarketBuyConfirm_GetShow() then
      FGlobal_ItemMarket_BuyConfirm_Close()
    end
    if nil ~= PaGlobalFunc_ItemMarketItemSet_GetShow and true == PaGlobalFunc_ItemMarketItemSet_GetShow() then
      FGlobal_ItemMarketItemSet_Close()
    end
    if nil ~= PaGlobalFunc_ItemMarket_GetShow and true == PaGlobalFunc_ItemMarket_GetShow() then
      FGolbal_ItemMarketNew_Close()
      if true == MessageBoxPanelNilCheck() and true == MessageBoxGetShow() then
        messageBox_NoButtonUp()
      end
    end
  end
end
function PreClose_MarketPlace()
  if true == _ContentsGroup_RenewUI_ItemMarketPlace then
    if nil ~= PaGlobalFunc_MarketPlace_GetShow and true == PaGlobalFunc_MarketPlace_GetShow() or nil ~= PaGlobalFunc_MarketWallet_GetShow and true == PaGlobalFunc_MarketWallet_GetShow() then
      PaGlobalFunc_MarketPlace_CloseAllCheck()
    end
    if nil ~= PaGlobalFunc_MarketPlace_Function_GetShow and true == PaGlobalFunc_MarketPlace_Function_GetShow() then
      PaGlobalFunc_MarketPlace_Function_Close()
    end
  end
end
function PreClose_WareHouse()
  if nil ~= Panel_Window_Warehouse and true == Panel_Window_Warehouse:GetShow() then
    if _ContentsGroup_NewUI_WareHouse_All then
      if nil ~= Panel_Window_WareHouse_Search and true == Panel_Window_WareHouse_Search:GetShow() then
        PaGlobal_Warehouse_Search_All_Close()
      else
        PaGlobal_Warehouse_All_Close()
      end
    else
      Warehouse_Close()
    end
  end
end
function PreClose_Shop()
  if true == _ContentsGroup_NewUI_NpcShop_All then
    if nil ~= Panel_Dialog_NPCShop_All and true == Panel_Dialog_NPCShop_All:GetShow() then
      HandleEventLUp_NPCShop_ALL_Close(false)
    end
  elseif false == PaGlobal_DialogMain_All._isConsole then
    NpcShop_WindowClose()
  end
end
function PreClose_BlackSmith()
  if false == _ContentsGroup_NewUI_BlackSmith_All then
    if nil ~= Panel_Window_Extraction_Caphras and Panel_Window_Extraction_Caphras:GetShow() then
      PaGlobal_ExtractionCaphras_Close()
    end
    if nil ~= Panel_FixEquip and true == Panel_FixEquip:GetShow() then
      FixEquip_Close()
    end
  else
    if nil ~= Panel_Window_Extraction_Caphras_All and Panel_Window_Extraction_Caphras_All:GetShow() then
      PaGlobal_Extraction_Caphras_All_Close()
    end
    if nil ~= Panel_Window_Endurance_Recovery_All and true == Panel_Window_Endurance_Recovery_All:GetShow() then
      PaGlobal_Endurance_Recovery_All_Close()
    end
  end
  if nil ~= Panel_Window_Extraction_Result and true == Panel_Window_Extraction_Result:GetShow() then
    PaGlobal_ExtractionResult:setHide()
  end
  if false == _ContentsGroup_NewUI_ExtractionFunction_All then
    if nil ~= Panel_Window_Extraction and true == Panel_Window_Extraction:IsShow() then
      PaGlobal_Extraction:openPanel(false)
    end
  elseif nil ~= Panel_Window_Extraction_All and true == Panel_Window_Extraction_All:IsShow() then
    PaGlobal_Extraction_All_Close()
  end
end
function PreClose_DyeColor()
  if _ContentsGroup_NewUI_Dye_All then
    if Panel_Window_ColorMix_All:GetShow() then
      PaGlobal_ColorMix_All_Clsoe()
    end
  elseif nil ~= Panel_ColorBalance and true == Panel_ColorBalance:GetShow() then
    Panel_ColorBalance_Close()
  end
end
function PreClose_WorkerManager()
  if true == _ContentsGroup_NewUI_WorkerManager_All then
    if nil ~= Panel_Window_WorkerManager_All and true == Panel_Window_WorkerManager_All:GetShow() then
      PaGlobalFunc_WorkerManager_All_Close()
    end
  elseif nil ~= Panel_WorkerManager and true == Panel_WorkerManager:GetShow() then
    workerManager_Close()
    FGlobal_InitWorkerTooltip()
  end
end
function PreClose_WorkerAuction()
  if true == _ContentsGroup_NewUI_WorkerAuction_All and nil ~= Panel_Window_WorkerAuction_All then
    HandleEventLUp_WorkerAuction_All_Close()
  else
    if nil ~= Panel_Worker_Auction and true == Panel_Worker_Auction:GetShow() then
      WorkerAuction_Close()
      Panel_Window_WorkerRandomSelect:SetShow(false)
    end
    if nil ~= Panel_WorkerResist_Auction and nil ~= Panel_WorkerList_Auction then
      Panel_WorkerResist_Auction:SetShow(false)
      Panel_WorkerList_Auction:SetShow(false)
    end
  end
  if true == _ContentsGroup_NewUI_WorkerRandomSelect_All and nil ~= Panel_Window_WorkerRandomSelect_All then
    HandleEventLUp_WorkerRandomSelect_All_ForceClose()
  end
end
function PreClose_Menu()
  if nil ~= Panel_Menu and true == Panel_Menu:GetShow() then
    Panel_Menu_Close()
  end
end
function PreClose_Camp()
  if nil ~= Panel_Window_Camp and true == Panel_Window_Camp:GetShow() then
    PaGlobal_Camp:close()
  end
end
function PreClose_SearchMode()
  if true == _ContentsGroup_NewUI_DialogSearch_All then
    if nil ~= Panel_Widget_Dialog_Search_All and true == Panel_Widget_Dialog_Search_All:IsShow() then
      PaGlobalFunc_DialogSearch_All_Close()
    end
  elseif false == _ContentsGroup_RenewUI_SearchMode then
    if nil ~= Panel_Dialog_Search and true == Panel_Dialog_Search:IsShow() then
      searchView_Close()
    end
  elseif true == PaGlobalFunc_SearchMode_IsSearchMode() then
    searchView_Close()
  end
end
function PreClose_SpiritEnchant()
  if true == _ContentsGroup_NewUI_SpiritEnchant_All then
    if nil ~= Panel_Window_StackExtraction_All and true == Panel_Window_StackExtraction_All:GetShow() then
      PaGlobalFunc_SpiritEnchant_All_Close()
    end
  elseif nil ~= Panel_Window_Enchant and true == Panel_Window_Enchant:GetShow() then
    PaGlobal_Enchant:enchantClose()
  end
end
function PreClose_Socket()
  if true == _ContentsGroup_NewUI_Socket_All then
    if nil ~= Panel_Window_Socket_All and true == Panel_Window_Socket_All:GetShow() then
      PaGlobalFunc_Socket_All_Close()
    end
  elseif nil ~= Panel_Window_Socket and true == Panel_Window_Socket:GetShow() then
    Socket_WindowClose()
  end
end
function PreClose_KnowledgeManagement()
  if nil ~= Panel_KnowledgeManagement and true == Panel_KnowledgeManagement:GetShow() then
    KnowledgeClose()
  end
end
function PreClose_NPCGift()
  if true == _ContentsGroup_RenewUI_Gift then
    PaGlobalFunc_NpcGift_Close()
  elseif true == _ContentsGroup_NewUI_NpcGift_All then
    PaGlobalFunc_DialogNpcGift_All_Close()
  else
    FGlobal_NpcGift_Close()
  end
end
function PreClose_MasterpieceAuction()
  if false == _ContentsGroup_NewUI_Masterpiece_Auction_All then
    if nil ~= Panel_Window_MasterpieceAuction and true == Panel_Window_MasterpieceAuction:GetShow() then
      PaGlobal_MasterpieceAuction:close()
    end
  elseif nil ~= Panel_Masterpiece_Auction_All and true == Panel_Masterpiece_Auction_All:GetShow() then
    PaGlobal_Masterpiece_Auction_All_Close()
  end
end
function PreClose_Dialog()
  if nil ~= Panel_Dialog_List_All and true == Panel_Dialog_List_All:GetShow() then
    PaGlobalFunc_DialogList_All_Close()
  end
  if nil ~= Panel_Dialog_Exchange_All and true == Panel_Dialog_Exchange_All:GetShow() then
    PaGlobalFunc_DialogExchange_All_Close()
  end
end
function PreClose_GameExit()
  if nil ~= Panel_GameExit and true == Panel_GameExit:GetShow() then
    GameExit_Close()
  end
  if nil ~= Panel_Window_GameExit_All then
    Panel_Window_GameExit_All:SetShow(false)
  end
end
function PreClose_Exchange()
  if nil ~= Panel_Window_Exchange and true == Panel_Window_Exchange:GetShow() then
    ExchangePC_MessageBox_ResponseCancel()
  end
  if nil ~= Panel_Window_Exchange and true == Panel_Window_Exchange:IsShow() then
    ExchangePc_MessageBox_CloseConfirm()
  end
  if true == _ContentsGroup_Barter then
    PaGlobal_Barter_Close()
    Panel_Exchange_Item_Hide()
  end
end
function PreClose_EasyBuy()
  if nil ~= Panel_IngameCashShop_EasyPayment and true == Panel_IngameCashShop_EasyPayment:GetShow() then
    if nil ~= Panel_IngameCashShop_BuyOrGift and true == Panel_IngameCashShop_BuyOrGift:GetShow() then
      local couponOpen = nil ~= Panel_IngameCashShop_Coupon and true == Panel_IngameCashShop_Coupon:GetShow()
      InGameShopBuy_Close(couponOpen)
    end
    PaGlobal_EasyBuy_Close()
  end
end
function PreClose_TranslationReport()
  if nil ~= Panel_TranslationReport and true == Panel_TranslationReport:GetShow() then
    TranslationReport_Close()
  end
end
function PreClose_CreateGuildClan()
  if false == _ContentsGroup_NewUI_CreateClan_All then
    if Panel_CreateClan ~= nil and Panel_CreateClan:GetShow() or nil ~= Panel_CreateGuild and Panel_CreateGuild:GetShow() then
      CreateClan_Close()
    end
  else
    if nil ~= Panel_CreateClan_All and Panel_CreateClan_All:GetShow() then
      PaGlobal_CreateClan_All_Close()
    end
    if nil ~= Panel_Guild_Create_All and Panel_Guild_Create_All:GetShow() then
      PaGlobal_Guild_Create_All_Close()
    end
  end
end
function PreClose_MonsterBar()
  if true == isMonsterBarShow then
    Panel_Monster_Bar:SetShow(true, false)
    isMonsterBarShow = false
  end
end
function PreClose_GuildHouseAuction()
  if nil ~= Panel_GuildHouse_Auction_All and Panel_GuildHouse_Auction_All:GetShow() then
    PaGlobal_GuildHouse_Auction_All_Close()
  end
  if nil ~= Panel_GuildHouse_Auction_Detail_All and Panel_GuildHouse_Auction_Detail_All:GetShow() then
    PaGlobal_GuildHouse_Auction_Detail_All_Close()
  end
  if nil ~= Panel_GuildHouse_Auction_Bid_All and Panel_GuildHouse_Auction_Bid_All:GetShow() then
    PaGlobal_GuildHouse_Auction_Bid_All_Close()
  end
end
function PreClose_Manufacture()
  if not _ContentsGroup_RenewUI_Manufacture then
    if false == _ContentsGroup_NewUI_Manufacture_All then
      Manufacture_Close()
    else
      PaGlobalFunc_Manufacture_All_Close()
    end
  end
end
function PreClose_Purification()
  if true == _ContentsGroup_NewUI_Purification_All and nil ~= Panel_Purification_All then
    HandleEventLUp_Purification_All_Close()
  elseif nil ~= Panel_Purification_Renew or nil ~= Panel_Purification then
    PaGlobal_Purification_Close()
  end
end
function PreClose_Customize()
  if nil ~= getCustomizingManager and true == getCustomizingManager():isShow() then
    HandleClicked_CloseIngameCustomization()
  end
  if nil ~= Panel_CustomizationMain and true == Panel_CustomizationMain:GetShow() then
    IngameCustomize_Hide()
  end
end
function PreClose_TradeMarket()
  if true == _ContentsGroup_NewUI_TradeMarket_All then
    if nil ~= Panel_Dialog_Trade_Function_All and true == Panel_Dialog_Trade_Function_All:GetShow() then
      HandleEventLUp_TradePriceRate_All_Close()
      HandleEventLUp_TradeFunction_All_Close()
    end
  elseif nil ~= Panel_Npc_Trade_Market and true == Panel_Npc_Trade_Market:IsShow() then
    closeNpcTrade_Basket()
  end
end
function PreClose_ServantDialog()
  if false == _ContentsGroup_NewUI_Servant_All then
    if nil ~= Panel_Window_StableFunction and true == Panel_Window_StableFunction:IsShow() then
      StableFunction_Close()
    end
    if nil ~= Panel_Window_GuildStableFunction and true == Panel_Window_GuildStableFunction:IsShow() then
      GuildStableFunction_Close()
    end
    if nil ~= Panel_Window_WharfFunction and true == Panel_Window_WharfFunction:GetShow() then
      WharfFunction_Close()
    end
  else
    if nil ~= Panel_Dialog_ServantFunction_All and true == Panel_Dialog_ServantFunction_All:GetShow() then
      PaGlobalFunc_ServantFunction_All_Close()
    end
    if nil ~= Panel_Window_GuildWharfFunction and true == Panel_Window_GuildWharfFunction:GetShow() then
      GuildWharfFunction_Close()
    end
  end
end
function PreClose_ServantInfo()
  if true == _ContentsGroup_NewUI_ServantInfo_All then
    PaGlobal_VehicleInfo_All_Close()
  elseif false == PaGlobal_DialogMain_All._isConsole then
    ServantInfo_Close()
    CarriageInfo_Close()
  end
end
function PreClose_Knowledge()
  if nil ~= Panel_Knowledge_Main and true == Panel_Knowledge_Main:GetShow() then
    Panel_Knowledge_Hide()
  end
end
function PreClose_Dye()
  if _ContentsGroup_NewUI_Dye_All then
    if nil ~= Panel_Widget_CharacterController_All and true == Panel_Widget_CharacterController_All:GetShow() then
      PaGlobal_Dye_All_Close()
    end
  elseif false == _ContentsGroup_RenewUI_Dyeing and nil ~= Panel_DyeNew_CharacterController and true == Panel_DyeNew_CharacterController:GetShow() then
    FGlobal_Panel_DyeReNew_Hide()
  end
end
function PreClose_RandomShop()
  if false == _ContentsGroup_NewUI_RandomShop_All then
    randomSelectHide()
  else
    PaGlobalFunc_RandomShop_All_Close()
  end
end
function PreClose_LordMenu()
  if false == _ContentsGroup_NewUI_LordMenu_All and nil ~= Panel_LordMenu then
    LordMenu_Hide()
  elseif nil ~= Panel_Window_LordMenu_All then
    HandleEventLUp_LordMenu_All_Close()
  end
end
function PreClose_Delivery()
  if true == _ContentsGroup_NewUI_Delivery_All then
    Panel_Window_Delivery_All:SetShow(false)
  elseif false == PaGlobal_DialogMain_All._isConsole then
    Panel_Window_Delivery_Information:SetShow(false)
    Panel_Window_Delivery_Request:SetShow(false)
  end
end
function CloseWith_BlackSmith()
  if false == _ContentsGroup_NewUI_BlackSmith_All then
    if nil ~= Panel_FixEquip and true == Panel_FixEquip:GetShow() then
      if true == _ContentsGroup_NewUI_RepairFunction_All then
        PaGlobalFunc_RepairFunc_All_Close()
      else
        handleMClickedRepairExitButton()
        PaGlobal_Repair:repair_OpenPanel(false, nil)
      end
      Panel_FixEquip:SetShow(false)
      SetUIMode(Defines.UIMode.eUIMode_Default)
    end
  elseif nil ~= Panel_Window_Endurance_Recovery_All and true == Panel_Window_Endurance_Recovery_All:GetShow() then
    if true == _ContentsGroup_NewUI_RepairFunction_All then
      PaGlobalFunc_RepairFunc_All_Close()
    else
      handleMClickedRepairExitButton()
      PaGlobal_Repair:repair_OpenPanel(false, nil)
    end
    SetUIMode(Defines.UIMode.eUIMode_Default)
  end
end
function CloseWith_Dialog()
  if nil ~= Panel_Dialog_List_All and true == Panel_Dialog_List_All:GetShow() then
    PaGlobalFunc_DialogList_All_Close(false)
  end
  if nil ~= Panel_Dialog_Exchange_All and true == Panel_Dialog_Exchange_All:GetShow() then
    PaGlobalFunc_DialogExchange_All_Close(false)
  end
end
