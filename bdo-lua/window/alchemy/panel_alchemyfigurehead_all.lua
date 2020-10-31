PaGlobal_AlchemyFigureHead_All = {
  _ui = {
    stc_contentBG = nil,
    txt_guide = nil,
    stc_totemSlotBG = nil,
    stc_totemSlot = {},
    stc_blackstoneSlotBG = nil,
    stc_blackstoneSlot = {},
    stc_effect = nil,
    stc_descBG = nil,
    txt_desc = nil
  },
  _ui_pc = {btn_close = nil, btn_doit = nil},
  _ui_console = {
    txt_consoleBG = nil,
    txt_showDetail = nil,
    txt_confirm = nil,
    txt_close = nil
  },
  slotConfig = {
    createIcon = true,
    createBorder = true,
    createCount = true,
    createCash = true
  },
  _totemData = {
    inventoryType = nil,
    slotNo = nil,
    selectedType = nil,
    itemKey = nil
  },
  _blackstoneData = {
    inventoryType = nil,
    slotNo = nil,
    count = nil
  },
  _curTime = 0,
  _maxTime = 6,
  _effectFlag = {
    startPlay = {time = 0, isCheck = false},
    contentEffect = {time = 1, isCheck = false},
    slotEffect = {time = 2, isCheck = false},
    resultSound = {time = 4.5, isCheck = false}
  },
  _initialize = false,
  _isConsole = false
}
runLua("UI_Data/Script/Window/Alchemy/Panel_AlchemyFigureHead_All_1.lua")
runLua("UI_Data/Script/Window/Alchemy/Panel_AlchemyFigureHead_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_AlchemyFigureHead_AllInit")
function FromClient_AlchemyFigureHead_AllInit()
  PaGlobal_AlchemyFigureHead_All:initialize()
end
