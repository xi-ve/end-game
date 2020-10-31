PaGlobal_SkillGroup_QuickSlot = {
  _ui = {_stc_topLine = nil, _stc_bottomLine = nil},
  _slotConfig = {createIcon = true, createEnchant = true},
  _config = {
    oldSlotCount = 10,
    slotCount = 20,
    slotGapX = 10,
    slotGapY = 20
  },
  _slots = {},
  _isNewQuickSlot = false,
  _initialize = false,
  slotKey = {
    [0] = CppEnums.ActionInputType.ActionInputType_QuickSlot1,
    [1] = CppEnums.ActionInputType.ActionInputType_QuickSlot2,
    [2] = CppEnums.ActionInputType.ActionInputType_QuickSlot3,
    [3] = CppEnums.ActionInputType.ActionInputType_QuickSlot4,
    [4] = CppEnums.ActionInputType.ActionInputType_QuickSlot5,
    [5] = CppEnums.ActionInputType.ActionInputType_QuickSlot6,
    [6] = CppEnums.ActionInputType.ActionInputType_QuickSlot7,
    [7] = CppEnums.ActionInputType.ActionInputType_QuickSlot8,
    [8] = CppEnums.ActionInputType.ActionInputType_QuickSlot9,
    [9] = CppEnums.ActionInputType.ActionInputType_QuickSlot10,
    [10] = CppEnums.ActionInputType.ActionInputType_QuickSlot11,
    [11] = CppEnums.ActionInputType.ActionInputType_QuickSlot12,
    [12] = CppEnums.ActionInputType.ActionInputType_QuickSlot13,
    [13] = CppEnums.ActionInputType.ActionInputType_QuickSlot14,
    [14] = CppEnums.ActionInputType.ActionInputType_QuickSlot15,
    [15] = CppEnums.ActionInputType.ActionInputType_QuickSlot16,
    [16] = CppEnums.ActionInputType.ActionInputType_QuickSlot17,
    [17] = CppEnums.ActionInputType.ActionInputType_QuickSlot18,
    [18] = CppEnums.ActionInputType.ActionInputType_QuickSlot19,
    [19] = CppEnums.ActionInputType.ActionInputType_QuickSlot20
  }
}
runLua("UI_Data/Script/Window/Skill/Panel_Window_SkillGroup_QuickSlot_1.lua")
runLua("UI_Data/Script/Window/Skill/Panel_Window_SkillGroup_QuickSlot_2.lua")
runLua("UI_Data/Script/Window/Skill/Panel_Window_SkillGroup_QuickSlot_3.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_SkillGroup_QuickSlot_Init")
function FromClient_SkillGroup_QuickSlot_Init()
  PaGlobal_SkillGroup_QuickSlot:initialize()
end
