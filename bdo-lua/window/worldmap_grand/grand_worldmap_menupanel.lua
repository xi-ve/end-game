local UI_color = Defines.Color
local ServantStable_Btn = UI.getChildControl(Panel_WorldMap, "BottomMenu_ServantStable")
local WareHouse_Btn = UI.getChildControl(Panel_WorldMap, "BottomMenu_WareHouse")
local Quest_Btn = UI.getChildControl(Panel_WorldMap, "BottomMenu_Quest")
local Transport_Btn = UI.getChildControl(Panel_WorldMap, "BottomMenu_Transport")
local transportAlert = UI.getChildControl(Panel_WorldMap, "Static_TransportAlert")
local ItemMarket_Btn = UI.getChildControl(Panel_WorldMap, "BottomMenu_ItemMarket")
local MarketPlace_Btn = UI.getChildControl(Panel_WorldMap, "BottomMenu_MarketPlace")
local WorkerList_Btn = UI.getChildControl(Panel_WorldMap, "BottomMenu_WorkerList")
local HelpMenu_Btn = UI.getChildControl(Panel_WorldMap, "BottomMenu_HelpMovie")
local Exit_Btn = UI.getChildControl(Panel_WorldMap, "BottomMenu_Exit")
local WorkerTrade_Btn = UI.getChildControl(Panel_WorldMap, "BottomMenu_WorkerTrade")
local StableMarket_Btn = UI.getChildControl(Panel_WorldMap, "BottomMenu_StableMarket")
local NpcFind = UI.getChildControl(Panel_WorldMap, "BottomMenu_NpcFind")
local btn_inMyPosition = UI.getChildControl(Panel_WorldMap, "BottomMenu_InMyPosition")
local BarterFind = UI.getChildControl(Panel_WorldMap, "BottomMenu_BarterFind")
local WaypointPreset_Btn = UI.getChildControl(Panel_WorldMap, "BottomMenu_WaypointPreset")
local WaypointOption_Btn = UI.getChildControl(Panel_WorldMap, "Button_WayPointOption")
local isWorkerTradeOpen = ToClient_IsContentsGroupOpen("209")
local base_carriageMoveCount = ToClient_MaxCarriageCount()
local gab_carriageText = 35
local txt_NationSiegeCarriageCount = UI.getChildControl(Panel_WorldMap, "StaticText_RemainCarriage")
local NationSiegeCarriage_A = UI.getChildControl(Panel_WorldMap, "Button_NationSiegeCarriage_A")
local NationSiegeCarriage_B = UI.getChildControl(Panel_WorldMap, "Button_NationSiegeCarriage_B")
local NationSiegeCarriage_C = UI.getChildControl(Panel_WorldMap, "Button_NationSiegeCarriage_C")
local txt_pingTooltip = UI.getChildControl(Panel_WorldMap, "StaticText_KeyGuide")
local currentNodeKey
local popupType = {
  stable = 0,
  wareHouse = 1,
  quest = 2,
  transport = 3,
  itemMarket = 4,
  workerList = 5,
  helpMovie = 6,
  workerTrade = 7,
  workerTradeCaravan = 8,
  stableMarket = 9,
  npcNavi = 10,
  marketPlace = 11,
  workerList_All = 12,
  servantMarket_All = 13,
  barterFind = 14,
  waypointPreset = 15,
  waypointOption = 16
}
local popupTypeCount = 17
local popupPanelList = {}
Panel_WorldMap:SetShow(false, false)
local function worldMap_Init()
  Exit_Btn:SetSize(44, 44)
  HelpMenu_Btn:SetSize(44, 44)
  WorkerList_Btn:SetSize(44, 44)
  ItemMarket_Btn:SetSize(44, 44)
  MarketPlace_Btn:SetSize(44, 44)
  Transport_Btn:SetSize(44, 44)
  Quest_Btn:SetSize(44, 44)
  WareHouse_Btn:SetSize(44, 44)
  ServantStable_Btn:SetSize(44, 44)
  WorkerTrade_Btn:SetSize(44, 44)
  StableMarket_Btn:SetSize(44, 44)
  NpcFind:SetSize(44, 44)
  btn_inMyPosition:SetSize(44, 44)
  BarterFind:SetSize(44, 44)
  WaypointPreset_Btn:SetSize(44, 44)
  WaypointOption_Btn:SetSize(44, 44)
  transportAlert:SetShow(false)
  Exit_Btn:SetSpanSize(5, 5)
  local isShowNationCarriage = false
  if true == _ContentsGroup_NationSiege and true == ToClient_isBeingNationSiege() and nil ~= getSelfPlayer() then
    local isGuildMaster = getSelfPlayer():get():isGuildMaster()
    local isCastleGuild = checkIsHasCastle()
    if true == isGuildMaster and true == isCastleGuild then
      isShowNationCarriage = true
    end
  end
  if true == isShowNationCarriage then
    txt_NationSiegeCarriageCount:SetShow(true)
    NationSiegeCarriage_A:SetShow(true)
    NationSiegeCarriage_B:SetShow(true)
    NationSiegeCarriage_C:SetShow(true)
    local offsetX = getScreenSizeX()
    NationSiegeCarriage_A:SetPosX(offsetX - 200 + NationSiegeCarriage_A:GetSizeX() * 1 + 5)
    NationSiegeCarriage_B:SetPosX(NationSiegeCarriage_A:GetPosX() + NationSiegeCarriage_A:GetSizeX() + 5)
    NationSiegeCarriage_C:SetPosX(NationSiegeCarriage_B:GetPosX() + NationSiegeCarriage_B:GetSizeX() + 5)
    local remainCount = base_carriageMoveCount - ToClient_CurrentCarriageMoveCount()
    txt_NationSiegeCarriageCount:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_NATIONSIEGE_CARRIAGE_COUNT_TEXT_SET", "remainCount", remainCount))
    txt_NationSiegeCarriageCount:SetPosX(NationSiegeCarriage_A:GetPosX() - txt_NationSiegeCarriageCount:GetTextSizeX() - gab_carriageText)
    txt_pingTooltip:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_WORLDMAP_GRAND_PING_TOOLTIP_NATIONSEIGE_ING"))
    txt_pingTooltip:SetSize(txt_pingTooltip:GetTextSizeX() + 20, txt_pingTooltip:GetTextSizeY() + 20)
  else
    txt_NationSiegeCarriageCount:SetShow(false)
    NationSiegeCarriage_A:SetShow(false)
    NationSiegeCarriage_B:SetShow(false)
    NationSiegeCarriage_C:SetShow(false)
    txt_pingTooltip:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_WORLDMAP_GRAND_PING_TOOLTIP_BASE"))
    txt_pingTooltip:SetSize(txt_pingTooltip:GetTextSizeX() + 20, txt_pingTooltip:GetTextSizeY() + 20)
  end
  NationSiegeCarriage_A:addInputEvent("Mouse_LUp", "HandleClick_NationSiegeCarriage(1)")
  NationSiegeCarriage_B:addInputEvent("Mouse_LUp", "HandleClick_NationSiegeCarriage(2)")
  NationSiegeCarriage_C:addInputEvent("Mouse_LUp", "HandleClick_NationSiegeCarriage(3)")
  NationSiegeCarriage_A:addInputEvent("Mouse_On", "HandleOnOut_WorldmapGrand_NationSiegeCarriage_Tooltip(1, true)")
  NationSiegeCarriage_A:addInputEvent("Mouse_Out", "HandleOnOut_WorldmapGrand_NationSiegeCarriage_Tooltip(1, false)")
  NationSiegeCarriage_B:addInputEvent("Mouse_On", "HandleOnOut_WorldmapGrand_NationSiegeCarriage_Tooltip(2, true)")
  NationSiegeCarriage_B:addInputEvent("Mouse_Out", "HandleOnOut_WorldmapGrand_NationSiegeCarriage_Tooltip(2, false)")
  NationSiegeCarriage_C:addInputEvent("Mouse_On", "HandleOnOut_WorldmapGrand_NationSiegeCarriage_Tooltip(3, true)")
  NationSiegeCarriage_C:addInputEvent("Mouse_Out", "HandleOnOut_WorldmapGrand_NationSiegeCarriage_Tooltip(3, false)")
  ServantStable_Btn:addInputEvent("Mouse_LUp", "BtnEvent_ServantStable()")
  WareHouse_Btn:addInputEvent("Mouse_LUp", "BtnEvent_WareHouse()")
  Quest_Btn:addInputEvent("Mouse_LUp", "BtnEvent_Quest()")
  Transport_Btn:addInputEvent("Mouse_LUp", "BtnEvent_Transport()")
  ItemMarket_Btn:addInputEvent("Mouse_LUp", "BtnEvent_ItemMarket()")
  MarketPlace_Btn:addInputEvent("Mouse_LUp", "BtnEvent_MarketPlace()")
  WorkerList_Btn:addInputEvent("Mouse_LUp", "BtnEvent_WorkerList()")
  HelpMenu_Btn:addInputEvent("Mouse_LUp", "BtnEvent_HelpMovie()")
  Exit_Btn:addInputEvent("Mouse_LUp", "BtnEvent_Exit()")
  StableMarket_Btn:addInputEvent("Mouse_LUp", "BtnEvent_StableMarket()")
  WorkerTrade_Btn:addInputEvent("Mouse_LUp", "BtnEvent_WorkerTrade()")
  NpcFind:addInputEvent("Mouse_LUp", "BtnEvent_NpcNavi()")
  btn_inMyPosition:addInputEvent("Mouse_LUp", "BtnEvent_InMyPosition()")
  BarterFind:addInputEvent("Mouse_LUp", "BtnEvent_BarterFind()")
  WaypointPreset_Btn:addInputEvent("Mouse_LUp", "BtnEvent_WaypointPreset()")
  WaypointOption_Btn:addInputEvent("Mouse_LUp", "BtnEvent_WaypointOption()")
  ServantStable_Btn:addInputEvent("Mouse_On", "HandleOnOut_WorldmapGrand_MenuButtonTooltip( true, " .. 0 .. " )")
  ServantStable_Btn:addInputEvent("Mouse_Out", "HandleOnOut_WorldmapGrand_MenuButtonTooltip( false, " .. 0 .. " )")
  WareHouse_Btn:addInputEvent("Mouse_On", "HandleOnOut_WorldmapGrand_MenuButtonTooltip( true, " .. 1 .. " )")
  WareHouse_Btn:addInputEvent("Mouse_Out", "HandleOnOut_WorldmapGrand_MenuButtonTooltip( false, " .. 1 .. " )")
  Quest_Btn:addInputEvent("Mouse_On", "HandleOnOut_WorldmapGrand_MenuButtonTooltip( true, " .. 2 .. " )")
  Quest_Btn:addInputEvent("Mouse_Out", "HandleOnOut_WorldmapGrand_MenuButtonTooltip( false, " .. 2 .. " )")
  Transport_Btn:addInputEvent("Mouse_On", "HandleOnOut_WorldmapGrand_MenuButtonTooltip( true, " .. 3 .. " )")
  Transport_Btn:addInputEvent("Mouse_Out", "HandleOnOut_WorldmapGrand_MenuButtonTooltip( false, " .. 3 .. " )")
  ItemMarket_Btn:addInputEvent("Mouse_On", "HandleOnOut_WorldmapGrand_MenuButtonTooltip( true, " .. 4 .. " )")
  ItemMarket_Btn:addInputEvent("Mouse_Out", "HandleOnOut_WorldmapGrand_MenuButtonTooltip( false, " .. 4 .. " )")
  WorkerList_Btn:addInputEvent("Mouse_On", "HandleOnOut_WorldmapGrand_MenuButtonTooltip( true, " .. 5 .. " )")
  WorkerList_Btn:addInputEvent("Mouse_Out", "HandleOnOut_WorldmapGrand_MenuButtonTooltip( false, " .. 5 .. " )")
  HelpMenu_Btn:addInputEvent("Mouse_On", "HandleOnOut_WorldmapGrand_MenuButtonTooltip( true, " .. 6 .. " )")
  HelpMenu_Btn:addInputEvent("Mouse_Out", "HandleOnOut_WorldmapGrand_MenuButtonTooltip( false, " .. 6 .. " )")
  Exit_Btn:addInputEvent("Mouse_On", "HandleOnOut_WorldmapGrand_MenuButtonTooltip( true, " .. 7 .. " )")
  Exit_Btn:addInputEvent("Mouse_Out", "HandleOnOut_WorldmapGrand_MenuButtonTooltip( false, " .. 7 .. " )")
  WorkerTrade_Btn:addInputEvent("Mouse_On", "HandleOnOut_WorldmapGrand_MenuButtonTooltip( true, " .. 8 .. " )")
  WorkerTrade_Btn:addInputEvent("Mouse_Out", "HandleOnOut_WorldmapGrand_MenuButtonTooltip( false, " .. 8 .. " )")
  StableMarket_Btn:addInputEvent("Mouse_On", "HandleOnOut_WorldmapGrand_MenuButtonTooltip( true, " .. 9 .. " )")
  StableMarket_Btn:addInputEvent("Mouse_Out", "HandleOnOut_WorldmapGrand_MenuButtonTooltip( false, " .. 9 .. " )")
  NpcFind:addInputEvent("Mouse_On", "HandleOnOut_WorldmapGrand_MenuButtonTooltip( true, " .. 10 .. " )")
  NpcFind:addInputEvent("Mouse_Out", "HandleOnOut_WorldmapGrand_MenuButtonTooltip( false, " .. 10 .. " )")
  btn_inMyPosition:addInputEvent("Mouse_On", "HandleOnOut_WorldmapGrand_MenuButtonTooltip( true, " .. 12 .. " )")
  btn_inMyPosition:addInputEvent("Mouse_Out", "HandleOnOut_WorldmapGrand_MenuButtonTooltip( false, " .. 12 .. " )")
  MarketPlace_Btn:addInputEvent("Mouse_On", "HandleOnOut_WorldmapGrand_MenuButtonTooltip( true, " .. 11 .. " )")
  MarketPlace_Btn:addInputEvent("Mouse_Out", "HandleOnOut_WorldmapGrand_MenuButtonTooltip( false, " .. 11 .. " )")
  BarterFind:addInputEvent("Mouse_On", "HandleOnOut_WorldmapGrand_MenuButtonTooltip( true, " .. 13 .. " )")
  BarterFind:addInputEvent("Mouse_Out", "HandleOnOut_WorldmapGrand_MenuButtonTooltip( false, " .. 13 .. " )")
  WaypointPreset_Btn:addInputEvent("Mouse_On", "HandleOnOut_WorldmapGrand_MenuButtonTooltip( true, " .. 14 .. " )")
  WaypointPreset_Btn:addInputEvent("Mouse_Out", "HandleOnOut_WorldmapGrand_MenuButtonTooltip( false, " .. 14 .. " )")
  WaypointOption_Btn:addInputEvent("Mouse_On", "HandleOnOut_WorldmapGrand_MenuButtonTooltip( true, " .. 15 .. " )")
  WaypointOption_Btn:addInputEvent("Mouse_Out", "HandleOnOut_WorldmapGrand_MenuButtonTooltip( false, " .. 15 .. " )")
end
function GrandWorldMap_CheckPopup(openPanel, exceptionPopPanel)
  for idx = 0, popupTypeCount - 1 do
    if openPanel ~= idx and nil ~= popupPanelList[idx].panelname and popupPanelList[idx].panelname:GetShow() and (nil == exceptionPopPanel or popupPanelList[idx].panelname ~= exceptionPopPanel) then
      popupPanelList[idx].closeFunc()
    end
  end
  PaGlobal_TutorialManager:handleGrandWorldMap_CheckPopup(openPanel, popupPanelList[openPanel].panelname)
end
function BtnEvent_ServantStable()
  if not Panel_NodeStable:GetShow() then
    if nil ~= currentNodeKey then
      GrandWorldMap_CheckPopup(popupType.stable)
      StableOpen_FromWorldMap(currentNodeKey)
    else
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_WORLDMAP_GRAND_WRONG_STABLE"))
      return
    end
  else
    StableClose_FromWorldMap()
  end
end
function BtnEvent_StableMarket()
  if false == _ContentsGroup_NewUI_Servant_All and nil ~= Panel_Window_StableMarket then
    if true == Panel_Window_StableMarket:GetShow() then
      StableMarket_Close()
    else
      GrandWorldMap_CheckPopup(popupType.stableMarket)
      StableMarket_Open()
    end
  elseif nil ~= Panel_Dialog_ServantMarket_All then
    if true == Panel_Dialog_ServantMarket_All:GetShow() then
      PaGlobalFunc_ServantMarket_All_Close()
    else
      GrandWorldMap_CheckPopup(popupType.servantMarket_All)
      PaGlobalFunc_ServantMarket_All_Open()
    end
  end
end
function BtnEvent_WorkerTrade()
  if not ToClient_IsActiveWorkerTrade() then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_WORLDMAPGRAND_WORKERTRADEALERT"))
    return
  end
  if Panel_WorkerTrade:GetShow() then
    WorkerTrade_Close()
  else
    GrandWorldMap_CheckPopup(popupType.workerTrade)
    WorldMapPopupManager:increaseLayer(true)
    WorldMapPopupManager:push(Panel_WorkerTrade, true)
    FGlobal_WorkerTrade_Update()
  end
end
function BtnEvent_NpcNavi()
  if _ContentsGroup_NewUI_NpcNavi_All then
    if Panel_NpcNavi_All:GetShow() then
      PaGlobal_NpcNavi_All_ShowToggle()
    else
      GrandWorldMap_CheckPopup(popupType.npcNavi)
      PaGlobal_NpcNavi_All_ShowToggle()
      WorldMapPopupManager:increaseLayer(true)
      WorldMapPopupManager:push(Panel_NpcNavi_All, true)
    end
  elseif Panel_NpcNavi:GetShow() then
    NpcNavi_ShowToggle()
  else
    GrandWorldMap_CheckPopup(popupType.npcNavi)
    NpcNavi_ShowToggle()
    WorldMapPopupManager:increaseLayer(true)
    WorldMapPopupManager:push(Panel_NpcNavi, true)
  end
end
function BtnEvent_InMyPosition()
  if true == btn_inMyPosition:IsIgnore() then
    return
  end
  ToClient_moveCameraSelfPlayerForWorldmap()
end
function BtnEvent_WareHouse()
  if Panel_Window_Warehouse:GetShow() then
    if _ContentsGroup_NewUI_WareHouse_All then
      PaGlobal_Warehouse_All_Close()
    else
      Warehouse_Close()
    end
  elseif nil ~= currentNodeKey then
    GrandWorldMap_CheckPopup(popupType.wareHouse, Panel_Window_Barter_Search)
    if _ContentsGroup_NewUI_WareHouse_All then
      PaGlobal_Warehouse_All_OpenPanelFromWorldmap(currentNodeKey, CppEnums.WarehoouseFromType.eWarehoouseFromType_Worldmap)
    else
      Warehouse_OpenPanelFromWorldmap(currentNodeKey, CppEnums.WarehoouseFromType.eWarehoouseFromType_Worldmap)
    end
  end
end
function BtnEvent_BarterFind()
  if nil == Panel_Window_Barter_Search then
    return
  end
  if true == Panel_Window_Barter_Search:GetShow() then
    PaGlobal_BarterInfoSearch:close()
  else
    GrandWorldMap_CheckPopup(popupType.barterFind, Panel_Window_Warehouse)
    if nil ~= Panel_Window_WareHouse_Search and true == Panel_Window_WareHouse_Search:GetShow() then
      WorldMapPopupManager:popWantPanel(Panel_Window_WareHouse_Search)
    end
    if nil ~= Panel_Window_Delivery_All and true == Panel_Window_Delivery_All:GetShow() then
      WorldMapPopupManager:popWantPanel(Panel_Window_Delivery_All)
    end
    WorldMapPopupManager:increaseLayer(true)
    WorldMapPopupManager:push(Panel_Window_Barter_Search, true)
    PaGlobal_BarterInfoSearch:open()
  end
end
function BtnEvent_WaypointPreset()
  if nil == Panel_Worldmap_WaypointPreset then
    return
  end
  if false == Panel_Worldmap_WaypointPreset:GetShow() then
    GrandWorldMap_CheckPopup(popupType.waypointPreset)
    WorldMapPopupManager:increaseLayer(true)
    WorldMapPopupManager:push(Panel_Worldmap_WaypointPreset, true)
    Panel_Worldmap_WaypointPreset:SetPosX(WaypointPreset_Btn:GetPosX())
    Panel_Worldmap_WaypointPreset:SetPosY(WaypointPreset_Btn:GetPosY() - Panel_Worldmap_WaypointPreset:GetSizeY())
    PaGlobal_Worldmap_Grand_WaypointPreset_Open()
  else
    PaGlobal_Worldmap_Grand_WaypointPreset_Close()
  end
end
function BtnEvent_WaypointOption()
  if nil == Panel_Worldmap_WaypointOption then
    return
  end
  if false == Panel_Worldmap_WaypointOption:GetShow() then
    GrandWorldMap_CheckPopup(popupType.waypointOption)
    WorldMapPopupManager:increaseLayer(true)
    WorldMapPopupManager:push(Panel_Worldmap_WaypointOption, true)
    Panel_Worldmap_WaypointOption:SetPosX(WaypointOption_Btn:GetPosX())
    Panel_Worldmap_WaypointOption:SetPosY(WaypointOption_Btn:GetPosY() - Panel_Worldmap_WaypointOption:GetSizeY())
    PaGlobal_Worldmap_Grand_WaypointOption_Open()
  else
    PaGlobal_Worldmap_Grand_WaypointOption_Close()
  end
end
function BtnEvent_Quest()
  if Panel_CheckedQuest:GetShow() then
    FGlobal_QuestWidget_Close()
  else
    GrandWorldMap_CheckPopup(popupType.quest)
    FGlobal_QuestWidget_Open()
  end
end
function BtnEvent_Transport()
  if Panel_Window_Delivery_InformationView:GetShow() then
    DeliveryInformationView_Close()
  else
    GrandWorldMap_CheckPopup(popupType.transport)
    DeliveryInformationView_Open()
  end
end
function BtnEvent_ItemMarket()
  if Panel_Window_ItemMarket:IsShow() then
    FGolbal_ItemMarketNew_Close()
  else
    GrandWorldMap_CheckPopup(popupType.itemMarket)
    FGlobal_ItemMarket_Open_ForWorldMap(1)
  end
end
function BtnEvent_MarketPlace()
  if false == _ContentsGroup_RenewUI_ItemMarketPlace then
    return
  end
  if true == PaGlobalFunc_MarketPlace_GetShow() then
    PaGlobalFunc_MarketPlace_Close()
  else
    GrandWorldMap_CheckPopup(popupType.marketPlace)
    PaGlobalFunc_MarketPlace_OpenForWorldMap(1)
  end
end
function BtnEvent_WorkerList()
  if true == _ContentsGroup_NewUI_WorkerManager_All then
    if nil ~= Panel_Window_WorkerManager_All and true == Panel_Window_WorkerManager_All:GetShow() then
      PaGlobalFunc_WorkerManager_All_Close()
    else
      GrandWorldMap_CheckPopup(popupType.workerList_All)
      if nil ~= currentNodeKey then
        PaGlobalFunc_WorkerManager_All_UpdateNode(ToClient_convertWaypointKeyToPlantKey(currentNodeKey))
      else
        PaGlobalFunc_WorkerManager_All_OpenWorldMap()
      end
    end
  elseif nil ~= Panel_WorkerManager and Panel_WorkerManager:GetShow() then
    workerManager_Close()
  else
    GrandWorldMap_CheckPopup(popupType.workerList)
    if nil ~= currentNodeKey then
      FGlobal_workerManager_UpdateNode(ToClient_convertWaypointKeyToPlantKey(currentNodeKey))
    else
      FGlobal_workerManager_OpenWorldMap()
    end
  end
end
function BtnEvent_HelpMovie()
  PaGlobal_MovieGuide_Web:Open()
end
function BtnEvent_Exit()
  FGlobal_CloseWorldmapForLuaKeyHandling()
end
function HandleClick_NationSiegeCarriage(point)
  local remainCount = base_carriageMoveCount - ToClient_CurrentCarriageMoveCount()
  local isMove = false
  if remainCount < 0 then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_NATIONSIEGE_CARRIAGE_COUNT_ZERO"))
  end
  if 1 == point then
    ToClient_MoveSupplyCarriage(__eNationSiegeCarriage_APoint)
    isMove = true
  elseif 2 == point then
    ToClient_MoveSupplyCarriage(__eNationSiegeCarriage_BPoint)
    isMove = true
  elseif 3 == point then
    ToClient_MoveSupplyCarriage(__eNationSiegeCarriage_CPoint)
    isMove = true
  end
  if true == isMove then
    txt_NationSiegeCarriageCount:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_NATIONSIEGE_CARRIAGE_COUNT_TEXT_SET", "remainCount", remainCount - 1))
  end
end
function HandleOnOut_WorldmapGrand_NationSiegeCarriage_Tooltip(point, isShow)
  local name, desc, control
  name = PAGetString(Defines.StringSheet_GAME, "LUA_WORLDMAP_GRAND_NATIONSIEGECARRIAGE_TOOLTIP_TITLE")
  if 1 == point then
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_WORLDMAP_GRAND_NATIONSIEGECARRIAGE_TOOLTIP_POINT_A")
    control = NationSiegeCarriage_A
  elseif 2 == point then
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_WORLDMAP_GRAND_NATIONSIEGECARRIAGE_TOOLTIP_POINT_B")
    control = NationSiegeCarriage_B
  elseif 3 == point then
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_WORLDMAP_GRAND_NATIONSIEGECARRIAGE_TOOLTIP_POINT_C")
    control = NationSiegeCarriage_C
  end
  if true == isShow then
    TooltipSimple_Show(control, name, desc)
  else
    TooltipSimple_Hide()
  end
end
function checkIsHasCastle()
  local myGuildWrapper = ToClient_GetMyGuildInfoWrapper()
  if nil == myGuildWrapper then
    return false
  end
  local myGuildNo = myGuildWrapper:getGuildNo_s64()
  local calpheonWrapper = ToClient_getNationSiegeTeamWrapper(2)
  if nil ~= calpheonWrapper then
    local calpheonGuildCount = calpheonWrapper:getGuildCount()
    for ii = 1, calpheonGuildCount do
      local guildNo = calpheonWrapper:getGuildNoRawByIndex(ii - 1)
      if true == calpheonWrapper:isKingByIndex(ii - 1) and myGuildNo == guildNo then
        return true
      end
    end
  end
  local valenciaWrapper = ToClient_getNationSiegeTeamWrapper(4)
  if nil ~= valenciaWrapper then
    local valenciaGuildCount = valenciaWrapper:getGuildCount()
    for ii = 1, valenciaGuildCount do
      local guildNo = valenciaWrapper:getGuildNoRawByIndex(ii - 1)
      if true == valenciaWrapper:isKingByIndex(ii - 1) and myGuildNo == guildNo then
        return true
      end
    end
  end
  return false
end
local function makePopupPanelList()
  popupPanelList = {
    [popupType.stable] = {panelname = Panel_NodeStable, closeFunc = StableClose_FromWorldMap},
    [popupType.wareHouse] = {panelname = Panel_Window_Warehouse, closeFunc = Warehouse_Close},
    [popupType.quest] = {panelname = Panel_CheckedQuest, closeFunc = FGlobal_QuestWidget_Close},
    [popupType.transport] = {panelname = Panel_Window_Delivery_InformationView, closeFunc = DeliveryInformationView_Close},
    [popupType.itemMarket] = {panelname = Panel_Window_ItemMarket, closeFunc = FGolbal_ItemMarketNew_Close},
    [popupType.workerList] = {panelname = Panel_WorkerManager, closeFunc = HandleClicked_WorkerManager_Close},
    [popupType.helpMovie] = {panelname = Panel_WorldMap_MovieGuide, closeFunc = Panel_Worldmap_MovieGuide_Close},
    [popupType.workerTrade] = {panelname = Panel_WorkerTrade, closeFunc = WorkerTrade_Close},
    [popupType.workerTradeCaravan] = {panelname = Panel_WorkerTrade_Caravan, closeFunc = FGlobal_WorkerTradeCaravan_Hide},
    [popupType.stableMarket] = {panelname = Panel_Window_StableMarket, closeFunc = StableMarket_Close},
    [popupType.npcNavi] = {panelname = Panel_NpcNavi, closeFunc = NpcNavi_ShowToggle},
    [popupType.marketPlace] = {panelname = Panel_Window_MarketPlace_Main, closeFunc = PaGlobalFunc_MarketPlace_Close},
    [popupType.workerList_All] = {panelname = Panel_Window_WorkerManager_All, closeFunc = PaGlobalFunc_WorkerManager_All_Close},
    [popupType.servantMarket_All] = {panelname = Panel_Dialog_ServantMarket_All, closeFunc = PaGlobalFunc_ServantMarket_All_Close},
    [popupType.barterFind] = {panelname = Panel_Window_Barter_Search, closeFunc = PaGlobal_BarterInfoSearch_Close},
    [popupType.waypointPreset] = {panelname = Panel_Worldmap_WaypointPreset, closeFunc = PaGlobal_Worldmap_Grand_WaypointPreset_Close},
    [popupType.waypointOption] = {panelname = Panel_Worldmap_WaypointOption, closeFunc = PaGlobal_Worldmap_Grand_WaypointOption_Close}
  }
  if true == _ContentsGroup_NewUI_WareHouse_All then
    popupPanelList[popupType.wareHouse].closeFunc = PaGlobal_Warehouse_All_Close
  end
  if true == _ContentsGroup_NewUI_WorkerManager_All then
    popupPanelList[popupType.workerList].closeFunc = PaGlobalFunc_WorkerManager_All_Close
  end
  if true == _ContentsGroup_NewUI_NpcNavi_All then
    popupPanelList[popupType.npcNavi] = {panelname = Panel_NpcNavi_All, closeFunc = PaGlobal_NpcNavi_All_ShowToggle}
  end
end
function FGlobal_WorldMapOpenForMenu()
  local isGrowStep = true
  if true == _ContentsGroup_GrowStep then
    isGrowStep = ToClient_IsGrowStepOpen(__eGrowStep_worker)
  else
    isGrowStep = true
  end
  local btnList = {
    [1] = {btn = Exit_Btn, show = true},
    [2] = {
      btn = HelpMenu_Btn,
      show = not isGameTypeKR2() and not isGameTypeGT()
    },
    [3] = {btn = WorkerList_Btn, show = isGrowStep},
    [4] = {
      btn = MarketPlace_Btn,
      show = _ContentsGroup_RenewUI_ItemMarketPlace and not isGameTypeKR2()
    },
    [5] = {btn = Transport_Btn, show = true},
    [6] = {btn = Quest_Btn, show = true},
    [7] = {btn = WareHouse_Btn, show = true},
    [8] = {btn = ServantStable_Btn, show = true},
    [9] = {
      btn = StableMarket_Btn,
      show = not isGameTypeKR2()
    },
    [10] = {btn = NpcFind, show = true},
    [11] = {btn = btn_inMyPosition, show = true},
    [12] = {btn = WaypointPreset_Btn, show = true},
    [13] = {
      btn = ItemMarket_Btn,
      show = not _ContentsGroup_RenewUI_ItemMarketPlace_Only
    },
    [14] = {btn = BarterFind, show = _ContentsGroup_Barter},
    [15] = {btn = WaypointOption_Btn, show = _ContentsGroup_AutomaticGuildeSmooth},
    [16] = {btn = WorkerTrade_Btn, show = isWorkerTradeOpen}
  }
  local spanSizeX = Exit_Btn:GetSpanSize().x
  local spanSizeY = Exit_Btn:GetSpanSize().y
  local gabX = 3
  local beforIdx = 1
  for i = 1, #btnList do
    btnList[i].btn:SetShow(btnList[i].show)
    if 1 ~= i and true == btnList[i].btn:GetShow() then
      btnList[i].btn:SetSpanSize(spanSizeX + btnList[beforIdx].btn:GetSizeX() + gabX, spanSizeY)
      spanSizeX = btnList[i].btn:GetSpanSize().x
      beforIdx = i
      btnList[i].btn:ComputePos()
    end
  end
  makePopupPanelList()
  Panel_WorldMap:SetShow(true, false)
  Panel_Worldmap_MovieGuide_Init()
end
function WorldmapGrand_setAlpha(boolValue)
  local returnValue = ""
  if true == boolValue then
    returnValue = 1
  else
    returnValue = 0.7
  end
  return returnValue
end
function HandleOnOut_WorldmapGrand_MenuButtonTooltip(isShow, buttonType)
  if isShow then
    local control
    local name = ""
    local desc
    if 0 == buttonType then
      control = ServantStable_Btn
      name = PAGetString(Defines.StringSheet_GAME, "LUA_WORLDMAPGRAND_MENUBUTTONTOOLTIP_STABLE")
    elseif 1 == buttonType then
      control = WareHouse_Btn
      name = PAGetString(Defines.StringSheet_GAME, "DIALOG_BUTTON_WAREHOUSE")
    elseif 2 == buttonType then
      control = Quest_Btn
      name = PAGetString(Defines.StringSheet_GAME, "DIALOG_BUTTON_QUEST")
    elseif 3 == buttonType then
      control = Transport_Btn
      name = PAGetString(Defines.StringSheet_GAME, "DIALOG_BUTTON_DELIVERY")
    elseif 4 == buttonType then
      control = ItemMarket_Btn
      name = PAGetString(Defines.StringSheet_GAME, "GAME_ITEM_MARKET_NAME")
    elseif 5 == buttonType then
      control = WorkerList_Btn
      name = PAGetString(Defines.StringSheet_GAME, "LUA_MENU_WORKERTITLE")
    elseif 6 == buttonType then
      control = HelpMenu_Btn
      name = PAGetString(Defines.StringSheet_GAME, "LUA_WORLDMAPGRAND_MENUBUTTONTOOLTIP_HELPMOVIE")
    elseif 7 == buttonType then
      control = Exit_Btn
      name = PAGetString(Defines.StringSheet_RESOURCE, "UICONTROL_BTN_GAMEEXIT")
    elseif 8 == buttonType then
      control = WorkerTrade_Btn
      name = PAGetString(Defines.StringSheet_GAME, "LUA_WORLDMAPGRAND_HELPWORKERTRADE")
    elseif 9 == buttonType then
      control = StableMarket_Btn
      name = PAGetString(Defines.StringSheet_RESOURCE, "STABLE_FUNCTION_BTN_MARKET")
    elseif 10 == buttonType then
      control = StableMarket_Btn
      name = PAGetString(Defines.StringSheet_GAME, "NPCNAVIGATION_NOTDRAGABLE")
    elseif 11 == buttonType then
      control = MarketPlace_Btn
      name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_MARKETPLACE_TITLE")
    elseif 12 == buttonType then
      control = btn_inMyPosition
      name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WORLDMAP_INMYPOSITION")
      desc = PAGetString(Defines.StringSheet_GAME, "PANEL_WORLDMAP_INMYPOSITION_DESC")
    elseif 13 == buttonType then
      control = BarterFind
      name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SEA_BARTER_SERACH")
      desc = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WHERE_ISLAND_BARTER_LIST_SERACH")
    elseif 14 == buttonType then
      control = WaypointPreset_Btn
      name = PAGetString(Defines.StringSheet_GAME, "LUA_WORLDMAPGRAND_MENUBUTTONTOOLTIP_WAYPOINTPRESET")
    elseif 15 == buttonType then
      control = WaypointOption_Btn
      name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WORLDMAP_WAYPOINTOPTION_TITLE")
    end
    TooltipSimple_Show(control, name, desc)
  else
    TooltipSimple_Hide()
  end
end
function FGlobal_WorldmapGrand_Bottom_MenuSet(waypointKey)
  if nil ~= waypointKey then
    currentNodeKey = waypointKey
    local isStableOpen = false
    local isWareHouseOpen = false
    local regionInfoWrapper = ToClient_getRegionInfoWrapperByWaypoint(waypointKey)
    if nil ~= regionInfoWrapper then
      isStableOpen = regionInfoWrapper:get():hasStableNpc()
      isWareHouseOpen = regionInfoWrapper:get():hasWareHouseNpc()
    end
    ServantStable_Btn:SetAlpha(WorldmapGrand_setAlpha(isStableOpen))
    ServantStable_Btn:SetIgnore(not isStableOpen)
    WareHouse_Btn:SetAlpha(WorldmapGrand_setAlpha(isWareHouseOpen))
    WareHouse_Btn:SetIgnore(not isWareHouseOpen)
    WorkerTrade_Btn:SetAlpha(WorldmapGrand_setAlpha(not isWorkerTradeOpen))
    WorkerTrade_Btn:SetIgnore(isWorkerTradeOpen)
    btn_inMyPosition:SetAlpha(WorldmapGrand_setAlpha(false))
    btn_inMyPosition:SetIgnore(true)
  else
    currentNodeKey = nil
    ServantStable_Btn:SetAlpha(WorldmapGrand_setAlpha(false))
    ServantStable_Btn:SetIgnore(true)
    WareHouse_Btn:SetAlpha(WorldmapGrand_setAlpha(false))
    WareHouse_Btn:SetIgnore(true)
    WorkerTrade_Btn:SetAlpha(WorldmapGrand_setAlpha(isWorkerTradeOpen))
    WorkerTrade_Btn:SetIgnore(not isWorkerTradeOpen)
    btn_inMyPosition:SetAlpha(WorldmapGrand_setAlpha(true))
    btn_inMyPosition:SetIgnore(false)
  end
end
function worldmapGrand_Base_OnScreenResize()
  local offsetX = getScreenSizeX()
  local offsetY = getScreenSizeY()
  local remainCount = base_carriageMoveCount - ToClient_CurrentCarriageMoveCount()
  Panel_WorldMap:SetSize(offsetX, offsetY)
  ServantStable_Btn:ComputePos()
  WareHouse_Btn:ComputePos()
  Quest_Btn:ComputePos()
  Transport_Btn:ComputePos()
  ItemMarket_Btn:ComputePos()
  MarketPlace_Btn:ComputePos()
  WorkerList_Btn:ComputePos()
  HelpMenu_Btn:ComputePos()
  Exit_Btn:ComputePos()
  WorkerTrade_Btn:ComputePos()
  StableMarket_Btn:ComputePos()
  NpcFind:ComputePos()
  btn_inMyPosition:ComputePos()
  transportAlert:ComputePos()
  BarterFind:ComputePos()
  WaypointPreset_Btn:ComputePos()
  WaypointOption_Btn:ComputePos()
  NationSiegeCarriage_A:ComputePos()
  NationSiegeCarriage_B:ComputePos()
  NationSiegeCarriage_C:ComputePos()
  txt_NationSiegeCarriageCount:ComputePos()
  NationSiegeCarriage_A:SetPosX(offsetX - 200 + NationSiegeCarriage_A:GetSizeX() * 1 + 5)
  NationSiegeCarriage_B:SetPosX(NationSiegeCarriage_A:GetPosX() + NationSiegeCarriage_A:GetSizeX() + 5)
  NationSiegeCarriage_C:SetPosX(NationSiegeCarriage_B:GetPosX() + NationSiegeCarriage_B:GetSizeX() + 5)
  txt_NationSiegeCarriageCount:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_NATIONSIEGE_CARRIAGE_COUNT_TEXT_SET", "remainCount", remainCount))
  txt_NationSiegeCarriageCount:SetPosX(NationSiegeCarriage_A:GetPosX() - txt_NationSiegeCarriageCount:GetTextSizeX() - gab_carriageText)
end
function FromClient_isCompletedTransport(isComplete)
  if nil == isComplete then
    return
  end
end
function PaGlobalFunc_Panel_WorldMap_Open()
  worldMap_Init()
end
worldMap_Init()
registerEvent("onScreenResize", "worldmapGrand_Base_OnScreenResize")
registerEvent("FromClient_isCompletedTransport", "FromClient_isCompletedTransport")
