local UIGroup = Defines.UIGroup
local RenderMode = Defines.RenderMode
local _IsXbox = _ContentsGroup_UsePadSnapping
runLua("UI_Data/Script/RenderMode/renderMode.lua")
local isActionModeActive = false
function isActionUiOpen()
  return isActionModeActive
end
local _isRemasterUIOption = ToClient_getGameUIManagerWrapper():getLuaCacheDataListBool(__eSwapRemasterUISetting)
local _isRemasterUIInit = ToClient_getGameUIManagerWrapper():getLuaCacheDataListBool(__eInitRemasterUI)
function PaGlobalFunc_IsRemasterUIOption()
  if false == _isRemasterUIInit then
    return true
  end
  return _isRemasterUIOption
end
function PaGlobalFunc_SetRemasterUIOption(isRemaster)
  _isRemasterUIOption = isRemaster
end
function basicLoadUI(panelNodeName, panelID, panelGroup)
  loadUI(panelNodeName, panelID, panelGroup, SETRENDERMODE_BITSET_DEFULAT())
end
function CheckTutorialEnd()
  if getSelfPlayer() == nil then
    return false
  end
  if true == _ContentsGroup_Tutorial_Renewal then
    return 7 <= getSelfPlayer():get():getLevel()
  end
  return ToClient_getTutorialLimitLevel() <= getSelfPlayer():get():getLevel()
end
LOADUI_TYPE = {
  logoUI = 0,
  loginUI = 1,
  serverSelectUI = 2,
  loadingUI = 3,
  lobbyUI = 4,
  preLoadGameUI = 5,
  GameUI = 6
}
local _loadUIFunc = {}
function PaGlobal_SetLoadUIFunc(func, Type)
  _loadUIFunc[Type] = func
end
local ePlatform = {
  PC = 0,
  XBox = 1,
  PS4 = 2,
  Instance = 3,
  InstanceLobby = 4
}
local platformType = ePlatform.PC
function PaGlobal_LoadPlatformUI()
  if true == ToClient_isConsole() then
    runLua("UI_Data/Script/loadUI_Console.lua")
    platformType = ePlatform.XBox
  elseif true == _ContentsGroup_UsePadSnapping then
    runLua("UI_Data/Script/loadUI_PC_PadControl.lua")
    platformType = ePlatform.PC
  else
    runLua("UI_Data/Script/loadUI_PC.lua")
    platformType = ePlatform.PC
  end
end
PaGlobal_LoadPlatformUI()
function loadLogoUI()
  local func = _loadUIFunc[LOADUI_TYPE.logoUI]
  func()
end
function loadLoginUI()
  local func = _loadUIFunc[LOADUI_TYPE.loginUI]
  func()
end
function loadServerSelectUI()
  local func = _loadUIFunc[LOADUI_TYPE.serverSelectUI]
  func()
end
function loadLoadingUI()
  local func = _loadUIFunc[LOADUI_TYPE.loadingUI]
  func()
end
function loadSceneEditUI()
end
function loadLobbyUI()
  local func = _loadUIFunc[LOADUI_TYPE.lobbyUI]
  func()
end
function loadLobbyUI_SteamBattleRoyal()
  loadUI("UI_Data/Instance/MainLobby/SA_Widget_Lobby_CharacterSelect_Bottom.XML", "SA_Widget_Lobby_CharacterSelect_Bottom", UIGroup.PAGameUIGroup_Widget, SETRENDERMODE_BITSET_ALLRENDER())
  loadUI("UI_Data/Instance/MainLobby/SA_Widget_Lobby_CharacterSelect_CharacterInfo.XML", "SA_Widget_Lobby_CharacterSelect_CharacterInfo", UIGroup.PAGameUIGroup_Widget, SETRENDERMODE_BITSET_ALLRENDER())
  loadUI("UI_Data/Instance/MainLobby/SA_Widget_Lobby_CharacterSelect_FriendsSlot.XML", "SA_Widget_Lobby_CharacterSelect_FriendsSlot", UIGroup.PAGameUIGroup_Widget, SETRENDERMODE_BITSET_ALLRENDER())
  loadUI("UI_Data/Instance/MainLobby/SA_Widget_Lobby_CharacterSelect_InviteFriend.XML", "SA_Widget_Lobby_CharacterSelect_InviteFriend", UIGroup.PAGameUIGroup_Widget, SETRENDERMODE_BITSET_ALLRENDER())
  loadUI("UI_Data/Instance/MainLobby/SA_Widget_Lobby_CharacterSelect_ItemSlot.XML", "SA_Widget_Lobby_CharacterSelect_ItemSlot", UIGroup.PAGameUIGroup_Widget, SETRENDERMODE_BITSET_ALLRENDER())
  loadUI("UI_Data/Instance/MainLobby/SA_Widget_Lobby_CharacterSelect_List.XML", "SA_Widget_Lobby_CharacterSelect_List", UIGroup.PAGameUIGroup_Widget, SETRENDERMODE_BITSET_ALLRENDER())
  loadUI("UI_Data/Instance/MainLobby/SA_Widget_Lobby_CharacterSelect_Top.XML", "SA_Widget_Lobby_CharacterSelect_Top", UIGroup.PAGameUIGroup_Widget, SETRENDERMODE_BITSET_ALLRENDER())
  loadUI("UI_Data/Instance/MainLobby/SA_Widget_Lobby_ChatingMenu.XML", "SA_Widget_Lobby_ChatingMenu", UIGroup.PAGameUIGroup_Widget, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_WorldMap
  }))
  loadUI("UI_Data/Instance/MainLobby/SA_Widget_Lobby_MainMenu.XML", "SA_Widget_Lobby_MainMenu", UIGroup.PAGameUIGroup_Widget, SETRENDERMODE_BITSET_ALLRENDER())
  loadUI("UI_Data/Instance/MainLobby/SA_Widget_Lobby_TopMenu.XML", "SA_Widget_Lobby_TopMenu", UIGroup.PAGameUIGroup_Widget, SETRENDERMODE_BITSET_ALLRENDER())
  loadUI("UI_Data/Instance/MainLobby/SA_Widget_Lobby_CharacterSelect_ItemShop.XML", "SA_Widget_Lobby_CharacterSelect_ItemShop", UIGroup.PAGameUIGroup_Widget, SETRENDERMODE_BITSET_ALLRENDER())
  loadUI("UI_Data/Instance/Instance_Tooltip_SimpleText.XML", "Instance_Tooltip_SimpleText", UIGroup.PAGameUIGroup_SimpleTooltip, SETRENDERMODE_BITSET_ALLRENDER())
  loadUI("UI_Data/Instance/Instance_Chatting_Input.XML", "Instance_Chatting_Input", UIGroup.PAGameUIGroup_ModalDialog, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_WorldMap,
    RenderMode.eRenderMode_SniperGame
  }))
  loadUI("UI_Data/Instance/IngameWidget/SA_Widget_NakMessage.XML", "Panel_SA_NakMessage", UIGroup.PAGameUIGroup_ModalDialog, SETRENDERMODE_BITSET_ALLRENDER())
  loadUI("UI_Data/Instance/MainLobby/SA_Widget_Lobby_Popup.XML", "Panel_SA_Window_MessageBox", UIGroup.PAGameUIGroup_FadeScreen, SETRENDERMODE_BITSET_ALLRENDER())
  loadUI("UI_Data/Instance/Instance_Window_Inventory.xml", "Instance_Window_Inventory", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_Dye,
    RenderMode.eRenderMode_InGameCashShop,
    RenderMode.eRenderMode_Dialog
  }))
  loadUI("UI_Data/Instance/Instance_Tooltip_Skill.XML", "Instance_Tooltip_Skill", UIGroup.PAGameUIGroup_GameMenu, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_Dialog
  }))
  loadUI("UI_Data/Instance/Instance_Tooltip_Skill_forLearning.XML", "Instance_Tooltip_Skill_forLearning", UIGroup.PAGameUIGroup_GameMenu, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_Dialog
  }))
  loadUI("UI_Data/Instance/Instance_Tooltip_Skill_forBlackSpirit.XML", "Instance_Tooltip_Skill_forBlackSpirit", UIGroup.PAGameUIGroup_GameMenu, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_Dialog
  }))
  loadUI("UI_Data/Instance/Instance_Tooltip_Item.XML", "Instance_Tooltip_Item", UIGroup.PAGameUIGroup_SimpleTooltip, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_Dialog,
    RenderMode.eRenderMode_InGameCashShop,
    RenderMode.eRenderMode_WorldMap,
    RenderMode.eRenderMode_Dialog,
    RenderMode.eRenderMode_HouseInstallation,
    RenderMode.eRenderMode_Dye
  }))
  loadUI("UI_Data/Instance/Instance_Tooltip_Item_chattingLinkedItem.XML", "Instance_Tooltip_Item_chattingLinkedItem", UIGroup.PAGameUIGroup_SimpleTooltip, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_WorldMap,
    RenderMode.eRenderMode_Dialog,
    RenderMode.eRenderMode_Dye,
    RenderMode.eRenderMode_HouseInstallation,
    RenderMode.eRenderMode_InGameCashShop
  }))
  loadUI("UI_Data/Instance/Instance_Tooltip_Item_chattingLinkedItemClick.XML", "Instance_Tooltip_Item_chattingLinkedItemClick", UIGroup.PAGameUIGroup_SimpleTooltip, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_WorldMap,
    RenderMode.eRenderMode_Dialog,
    RenderMode.eRenderMode_Dye,
    RenderMode.eRenderMode_HouseInstallation,
    RenderMode.eRenderMode_InGameCashShop
  }))
  loadUI("UI_Data/Instance/Instance_Tooltip_Item_equipped.XML", "Instance_Tooltip_Item_equipped", UIGroup.PAGameUIGroup_SimpleTooltip, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_WorldMap,
    RenderMode.eRenderMode_Dialog,
    RenderMode.eRenderMode_Dye,
    RenderMode.eRenderMode_HouseInstallation,
    RenderMode.eRenderMode_InGameCashShop
  }))
  loadUI("UI_Data/Instance/Instance_Tooltip_SimpleText.XML", "Instance_Tooltip_SimpleText", UIGroup.PAGameUIGroup_SimpleTooltip, SETRENDERMODE_BITSET_ALLRENDER())
  loadUI("UI_Data/Instance/Instance_Tooltip_Common.XML", "Instance_Tooltip_Common", UIGroup.PAGameUIGroup_GameMenu, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_WorldMap,
    RenderMode.eRenderMode_Dialog,
    RenderMode.eRenderMode_Dye,
    RenderMode.eRenderMode_HouseInstallation,
    RenderMode.eRenderMode_InGameCashShop
  }))
  runLua("UI_Data/Script/Instance/Instance_Tooltip_Skill.lua")
  runLua("UI_Data/Script/Instance/Instance_Tooltip_Item.lua")
  runLua("UI_Data/Script/Instance/Instance_Tooltip_Common.lua")
  runLua("UI_Data/Script/Instance/Instance_Tooltip_SimpleText.lua")
  runLua("UI_Data/Script/Instance/Lobby/SA_Widget_Lobby_MainMenu.lua")
  runLua("UI_Data/Script/Instance/Lobby/SA_Widget_Lobby_ChatingMenu.lua")
  runLua("UI_Data/Script/Instance/Lobby/SA_Widget_Lobby_CharacterSelect_FriendsSlot.lua")
  runLua("UI_Data/Script/Instance/Lobby/SA_Widget_Lobby_CharacterSelect_CharacterInfo.lua")
  runLua("UI_Data/Script/Instance/Lobby/SA_Widget_Lobby_CharacterSelect_List.lua")
  runLua("UI_Data/Script/Instance/Lobby/SA_Widget_Lobby_CharacterSelect_Top.lua")
  runLua("UI_Data/Script/Instance/Lobby/SA_Widget_Lobby_CharacterSelect_InviteFriend.lua")
  runLua("UI_Data/Script/Instance/Lobby/SA_Widget_Lobby_CharacterSelect_Bottom.lua")
  runLua("UI_Data/Script/Instance/Lobby/SA_Widget_Lobby_CharacterSelect_ItemSlot.lua")
  runLua("UI_Data/Script/Instance/Lobby/SA_Widget_Lobby_TopMenu.lua")
  runLua("UI_Data/Script/Instance/Lobby/SA_Widget_Lobby_CharacterSelect_ItemShop.lua")
  runLua("UI_Data/Script/Instance/Instance_Chatting_Input.lua")
  runLua("UI_Data/Script/Instance/IngameWidget/SA_DragManager.lua")
  runLua("UI_Data/Script/Instance/IngameWidget/SA_globalKeyBinderUiInputType.lua")
  runLua("UI_Data/Script/Instance/IngameWidget/SA_globalKeyBinderManager.lua")
  runLua("UI_Data/Script/Instance/globalKeyBinderShadowArenaLobby.lua")
  runLua("UI_Data/Script/Instance/IngameWidget/SA_Widget_NakMessage.lua")
  runLua("UI_Data/Script/Instance/IngameWidget/SA_Window_MessageBox.lua")
end
function preLoadGameUI()
  local func = _loadUIFunc[LOADUI_TYPE.preLoadGameUI]
  func()
  basicLoadUI("UI_Data/Widget/UIcontrol/QASupport_AutomationPanel.XML", "QASupport_AutomationPanel", UIGroup.PAGameUIGroup_DeadMessage)
end
function loadGameUI()
  local func = _loadUIFunc[LOADUI_TYPE.GameUI]
  func()
  runLua("UI_Data/Script/QASupport/QASupport_AutomationPanel/QASupport_AutomationPanel.lua")
end
function preLoadGameOptionUI()
  basicLoadUI("UI_Data/Window/WebHelper/Panel_WebControl.XML", "Panel_WebControl", UIGroup.PAGameUIGroup_DeadMessage)
  if true == _ContentsGroup_NewUI_GameOption_All then
    basicLoadUI("UI_Data/Window/c_Option/Panel_Window_Gameoption_Main_All.XML", "Panel_Window_GameOption_All", UIGroup.PAGameUIGroup_Windows)
  elseif true == _ContentsGroup_isNewOption then
    basicLoadUI("UI_Data/Window/c_Option/Panel_Option_Main.XML", "Panel_Window_cOption", UIGroup.PAGameUIGroup_Windows)
    basicLoadUI("UI_Data/Window/c_Option/Option_Performance_Camera.XML", "Panel_Performance_Camera", UIGroup.PAGameUIGroup_Windows)
    basicLoadUI("UI_Data/Window/c_Option/Option_Performance_GraphicQuality.XML", "Panel_Performance_GraphicQuality", UIGroup.PAGameUIGroup_Windows)
    basicLoadUI("UI_Data/Window/c_Option/Option_Performance_Npc.XML", "Panel_Performance_Npc", UIGroup.PAGameUIGroup_Windows)
    basicLoadUI("UI_Data/Window/c_Option/Option_Performance_Optimize.XML", "Panel_Performance_Optimize", UIGroup.PAGameUIGroup_Windows)
    basicLoadUI("UI_Data/Window/c_Option/Option_Function_Alert.XML", "Panel_Function_Alert", UIGroup.PAGameUIGroup_Windows)
    basicLoadUI("UI_Data/Window/c_Option/Option_Function_Nation.XML", "Panel_Function_Nation", UIGroup.PAGameUIGroup_Windows)
    basicLoadUI("UI_Data/Window/c_Option/Option_Graphic_Camera.XML", "Panel_Graphic_Camera", UIGroup.PAGameUIGroup_Windows)
    basicLoadUI("UI_Data/Window/c_Option/Option_Graphic_Effect.XML", "Panel_Graphic_Effect", UIGroup.PAGameUIGroup_Windows)
    basicLoadUI("UI_Data/Window/c_Option/Option_Graphic_Quality.XML", "Panel_Graphic_Quality", UIGroup.PAGameUIGroup_Windows)
    basicLoadUI("UI_Data/Window/c_Option/Option_Graphic_ScreenShot.XML", "Panel_Graphic_ScreenShot", UIGroup.PAGameUIGroup_Windows)
    basicLoadUI("UI_Data/Window/c_Option/Option_Graphic_Window.XML", "Panel_Graphic_Window", UIGroup.PAGameUIGroup_Windows)
    basicLoadUI("UI_Data/Window/c_Option/Option_Graphic_Hdr.XML", "Panel_Graphic_HDR", UIGroup.PAGameUIGroup_Windows)
    basicLoadUI("UI_Data/Window/c_Option/Option_Sound_OnOff.XML", "Panel_Sound_OnOff", UIGroup.PAGameUIGroup_Windows)
    if true == _ContentsGroup_InstrumentPerformance then
      basicLoadUI("UI_Data/Window/c_Option/Option_Sound_Volume.XML", "Panel_Sound_Volume", UIGroup.PAGameUIGroup_Windows)
    else
      basicLoadUI("UI_Data/Window/c_Option/Option_Sound_Volume_NonMusicPlayOption.XML", "Panel_Sound_Volume", UIGroup.PAGameUIGroup_Windows)
    end
  elseif true == _ContentsGroup_RenewUI_RenewOPtion then
    basicLoadUI("UI_Data/Window/c_Option/Console/Panel_Window_OptionMain_Renew.XML", "Panel_Window_Option_Main", UIGroup.PAGameUIGroup_Windows)
  end
  basicLoadUI("UI_Data/Widget/Tooltip/UI_Tooltip_Skill.XML", "Panel_Tooltip_Skill", UIGroup.PAGameUIGroup_GameMenu)
  basicLoadUI("UI_Data/Widget/Tooltip/UI_Tooltip_Skill_forLearning.XML", "Panel_Tooltip_Skill_forLearning", UIGroup.PAGameUIGroup_GameMenu)
  basicLoadUI("UI_Data/Widget/Tooltip/UI_Tooltip_Skill_BlackSpirit.XML", "Panel_Tooltip_Skill_forBlackSpirit", UIGroup.PAGameUIGroup_GameMenu)
  basicLoadUI("UI_Data/Widget/Tooltip/UI_Tooltip_Skill_forLinkTooltip.XML", "Panel_Tooltip_Skill_forLinkTooltip", UIGroup.PAGameUIGroup_GameMenu)
  loadUI("UI_Data/Widget/Tooltip/UI_Tooltip_Item.XML", "Panel_Tooltip_Item", UIGroup.PAGameUIGroup_ModalDialog, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_InGameCashShop,
    RenderMode.eRenderMode_WorldMap
  }))
  basicLoadUI("UI_Data/Widget/Tooltip/UI_Tooltip_Item_chattingLinkedItem.XML", "Panel_Tooltip_Item_chattingLinkedItem", UIGroup.PAGameUIGroup_ModalDialog)
  basicLoadUI("UI_Data/Widget/Tooltip/UI_Tooltip_Item_chattingLinkedItemClick.XML", "Panel_Tooltip_Item_chattingLinkedItemClick", UIGroup.PAGameUIGroup_ModalDialog)
  basicLoadUI("UI_Data/Widget/Tooltip/UI_Tooltip_Item_equipped.XML", "Panel_Tooltip_Item_equipped", UIGroup.PAGameUIGroup_ModalDialog)
  basicLoadUI("UI_Data/Widget/Tooltip/UI_Tooltip_Guild_Introduce.XML", "Panel_Tooltip_Guild_Introduce", UIGroup.PAGameUIGroup_GameMenu)
  basicLoadUI("UI_Data/Widget/Tooltip/UI_Tooltip_Common.XML", "Panel_Tooltip_Common", UIGroup.PAGameUIGroup_GameMenu)
  basicLoadUI("UI_Data/Widget/Tooltip/UI_Tooltip_Worker.XML", "Panel_Worker_Tooltip", UIGroup.PAGameUIGroup_GameMenu)
  basicLoadUI("UI_Data/Widget/Tooltip/UI_Tooltip_Work.XML", "Panel_Tooltip_Work", UIGroup.PAGameUIGroup_GameMenu)
  basicLoadUI("UI_Data/Widget/Tooltip/UI_Tooltip_SimpleText.XML", "Panel_Tooltip_SimpleText", UIGroup.PAGameUIGroup_SimpleTooltip)
end
function loadGameOptionUI()
  if true == _ContentsGroup_NewUI_GameOption_All then
    runLua("UI_Data/Script/Window/Option/NewUI/Panel_Window_GameOption_Header_All.lua")
    runLua("UI_Data/Script/Window/Option/NewUI/Panel_Window_GameOption_Initialize_All.lua")
    runLua("UI_Data/Script/Window/Option/NewUI/Panel_Window_GameOption_OptionFunc_All.lua")
    runLua("UI_Data/Script/Window/Option/NewUI/Panel_Window_GameOption_Main_All.lua")
    runLua("UI_Data/Script/Window/Option/NewUI/Panel_Window_GameOption_Util_All.lua")
    PaGlobal_GameOption_All:Init()
    ToClient_initGameOption()
  elseif true == _ContentsGroup_isNewOption then
    runLua("UI_Data/Script/Window/Option/GameOptionHeader.lua")
    runLua("UI_Data/Script/Window/Option/GameOptionMain.lua")
    runLua("UI_Data/Script/Window/Option/GameOptionUtil.lua")
    runLua("UI_Data/Script/Window/Option/Panel_Option_Main.lua")
    PaGlobal_Option:Init()
    ToClient_initGameOption()
  elseif true == _ContentsGroup_RenewUI_RenewOPtion then
    runLua("UI_Data/Script/Window/Option/GameOptionHeader_Renew.lua")
    runLua("UI_Data/Script/Window/Option/GameOptionMain_Renew.lua")
    runLua("UI_Data/Script/Window/Option/GameOptionUtil.lua")
    runLua("UI_Data/Script/Window/Option/Panel_Option_Main_Renew.lua")
    PaGlobal_Option:Init()
    ToClient_initGameOption()
  end
  runLua("UI_Data/Script/GlobalKeyBinder/globalKeyBinderManager.lua")
  runLua("UI_Data/Script/GlobalKeyBinder/globalKeyBinder.lua")
  runLua("UI_Data/Script/Tutorial/Panel_WebControl.lua")
  runLua("UI_Data/Script/Widget/ToolTip/Panel_Tooltip_Skill.lua")
  runLua("UI_Data/Script/Widget/ToolTip/Panel_Tooltip_Item.lua")
  runLua("UI_Data/Script/Widget/ToolTip/Panel_Tooltip_Guild_Introduce.lua")
  runLua("UI_Data/Script/Widget/ToolTip/Panel_Tooltip_Common.lua")
  runLua("UI_Data/Script/Widget/ToolTip/Panel_Tooltip_SimpleText.lua")
  runLua("UI_Data/Script/Widget/ToolTip/Panel_Tooltip_New_Worker.lua")
  runLua("UI_Data/Script/Widget/ToolTip/Panel_Tooltip_New_Work.lua")
end
function loadOceanUI()
  basicLoadUI("UI_Data/Window/Cutscene/Panel_CutsceneMovie.XML", "Panel_Cutscene", UIGroup.PAGameUIGroup_MainUI)
  basicLoadUI("UI_Data/Widget/Acquire/Acquire.XML", "Panel_Acquire", UIGroup.PAGameUIGroup_MainUI)
  basicLoadUI("UI_Data/Widget/Acquire/Acquire_QuestDirect.XML", "Panel_QuestDirect", UIGroup.PAGameUIGroup_ModalDialog)
  runLua("UI_Data/Script/Widget/Acquire/Acquire.lua")
  runLua("UI_Data/Script/CutScene_Ocean.lua")
  runLua("UI_Data/Script/Widget/Acquire/Acquire_QuestDirect.lua")
end
function PaGlobal_GetPanelWindowInventory()
  if ePlatform.Instance == platformType then
    return Instance_Window_Inventory
  elseif ePlatform.InstanceLobby == platformType then
    return Instance_Window_Inventory
  elseif true == _ContentsGroup_NewUI_Inventory_All then
    return Panel_Window_Inventory_All
  else
    return Panel_Window_Inventory
  end
end
function PaGlobal_GetPanelTooltipSimpleText()
  if ePlatform.Instance == platformType then
    return Instance_Tooltip_SimpleText
  elseif ePlatform.InstanceLobby == platformType then
    return Instance_Tooltip_SimpleText
  else
    return Panel_Tooltip_SimpleText
  end
end
