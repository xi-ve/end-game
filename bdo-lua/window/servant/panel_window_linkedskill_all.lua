PaGlobal_LinkedSkill_All = {
  _ui = {
    _txt_title = nil,
    _pc = {_btn_close = nil},
    _console = {_stc_keyGuideBG = nil},
    _stc_skillBg = nil,
    _stc_skillIcon = nil,
    _txt_skillCondition = nil,
    _txt_skillName = nil,
    _txt_skillPercent = nil,
    _stc_learnBackground = nil,
    _progress_skillLearnGauge = nil,
    _scroll_skillScroll = nil,
    _stc_skillInfoBg = nil
  },
  _equip = {
    {_index = 3, _slotNo = 0},
    {_index = 4, _slotNo = 1},
    {_index = 5, _slotNo = 2},
    {_index = 6, _slotNo = 3},
    {_index = 12, _slotNo = 4}
  },
  _cache = {
    {_index = 14, _slotNo = 0},
    {_index = 15, _slotNo = 1},
    {_index = 16, _slotNo = 2},
    {_index = 17, _slotNo = 3}
  },
  _equipSlotIds = {
    [0] = "Static_EquipSlot_1",
    [1] = "Static_EquipSlot_2",
    [2] = "Static_EquipSlot_3",
    [3] = "Static_EquipSlot_4",
    [4] = "Static_EquipSlot_5"
  },
  _cacheSlotIds = {
    [0] = "Static_AvatarSlot_1",
    [1] = "Static_AvatarSlot_2",
    [2] = "Static_AvatarSlot_3",
    [3] = "Static_AvatarSlot_4"
  },
  _itemSlot = {
    createIcon = false,
    createBorder = true,
    createCount = true,
    createEnchant = true,
    createCash = true,
    createEnduranceIcon = true
  },
  _skillConfig = {
    startX = 0,
    startY = 0,
    startIconX = 5,
    startIconY = 5,
    gapConditionX = 15,
    startConditionY = 28,
    gapNameX = 15,
    startNameY = 5,
    startPercenX = 2,
    startPercenY = 28,
    startLearnBgX = 5,
    startLearnBgY = 50,
    gapY = 52,
    count = 4
  },
  _skillSlot = {},
  _equipSlot = {},
  _loopCount = 3,
  _skillStartIndex = 0,
  _skillCount = 0,
  _currentIndex = -1,
  _actorKeyRaw = 0,
  _initialize = false
}
runLua("UI_Data/Script/Window/Servant/Panel_Window_LinkedSkill_All_1.lua")
runLua("UI_Data/Script/Window/Servant/Panel_Window_LinkedSkill_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_LinkedSkill_All_Init")
function FromClient_LinkedSkill_All_Init()
  PaGlobal_LinkedSkill_All:initialize()
end
