PaGlobal_Alchemy_All = {
  _ui = {
    stc_titleBG = nil,
    txt_alchemyTitle = nil,
    txt_cookTitle = nil,
    btn_question = nil,
    btn_close = nil,
    stc_leftArea = nil,
    txt_alchemyDesc = nil,
    btn_startAlchemy = nil,
    btn_massProduction = nil,
    stc_materialslots = {},
    stc_slotFocus = nil,
    stc_cookPotBack = nil,
    stc_cookPotFront = nil,
    stc_alchemyPotBack = nil,
    stc_alchemyPotFront = nil,
    animPushItemCook = {},
    animPushItemAlchemy = {},
    stc_searchArea = nil,
    chk_knownRecipe = nil,
    edit_searchBox = nil,
    stc_LSclick_consoleUI = nil,
    stc_LTX_consoleUI = nil,
    list2_knowledgeList = nil,
    txt_emptyKnowledge = nil,
    txt_searchFail = nil,
    frame_descBG = nil,
    txt_knowledgeDesc = nil,
    scroll_vertical = nil,
    stc_keyGuideBG = nil,
    stc_iconY = nil,
    stc_iconX = nil,
    stc_iconA = nil,
    stc_iconB = nil
  },
  _isCook = true,
  _maxMaterialCount = 5,
  _filterText = nil,
  _selectedKnowledge = -1,
  _focusedMaterialSlotIndex = 0,
  _invenFilterItemTypes = {
    [CppEnums.ItemType.Equip] = 1
  },
  _isConsole = false,
  _initialize = false
}
runLua("UI_Data/Script/Window/Alchemy/Panel_Window_Alchemy_All_1.lua")
runLua("UI_Data/Script/Window/Alchemy/Panel_Window_Alchemy_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_Alchemy_All_Init")
function FromClient_Alchemy_All_Init()
  PaGlobal_Alchemy_All:initialize()
end
