PaGlobal_Camp_All = {
  _ui = {
    stc_TitleBG = nil,
    btn_Close = nil,
    btn_Guide = nil,
    stc_Unseal = nil,
    stc_UnsealImg = nil,
    btn_UnsealTent = nil,
    btn_RemoteTent = nil,
    btn_Villa = nil,
    stc_Bottom = nil,
    stc_slot = nil,
    slotBg = {
      [3] = nil,
      [4] = nil,
      [5] = nil,
      [6] = nil
    },
    slotAddBtn = {
      [3] = nil,
      [4] = nil,
      [5] = nil,
      [6] = nil
    },
    btn_Menu = {
      [3] = nil,
      [4] = nil,
      [5] = nil
    },
    nonActiveMenuBtn = {
      [3] = nil,
      [4] = nil,
      [5] = nil
    }
  },
  _config = {
    _itemSlot = {
      createIcon = false,
      createBorder = true,
      createCount = true,
      createEnchant = true,
      createCash = true,
      createEnduranceIcon = true
    },
    _slotNo = {
      3,
      4,
      5,
      6
    },
    _menuNo = {
      3,
      4,
      5
    },
    _isSetItem = {
      [3] = false,
      [4] = false,
      [5] = false,
      [6] = false
    },
    _menuStr = {
      [3] = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_CAMP_WAREHOUSETOOL"),
      [4] = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_CAMP_REPAIRTOOL"),
      [5] = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_CAMP_SHOPTOOL"),
      [6] = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_CAMP_TENTLOOKTITLE")
    },
    _menuNonActiveStr = {
      [3] = PAGetString(Defines.StringSheet_GAME, "LUA_CAMP_NEEDWAREHOUSETOOL"),
      [4] = PAGetString(Defines.StringSheet_GAME, "LUA_CAMP_NEEDREPAIRTOOL"),
      [5] = PAGetString(Defines.StringSheet_GAME, "LUA_CAMP_NEEDSHOPTOOL")
    }
  },
  _isOpen = false,
  _isCamping = false,
  _itemSlots = Array.new(),
  _actorKeyRaw = nil,
  _panelSizeY = nil,
  _initialize = false
}
runLua("UI_Data/Script/Widget/Camp/Panel_Window_Camp_All_1.lua")
runLua("UI_Data/Script/Widget/Camp/Panel_Window_Camp_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_Camp_All_luaLoadComplete")
function FromClient_Camp_All_luaLoadComplete()
  PaGlobal_Camp_All:initialize()
end
