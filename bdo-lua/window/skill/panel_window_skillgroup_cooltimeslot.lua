PaGlobal_SkillGroup_CoolTimeSlot = {
  _ui = {
    _stc_title = nil,
    _txt_title = nil,
    _btn_close = nil,
    _stc_frameBG = nil,
    _slide = nil,
    _btn_slide = nil,
    _txt_desc = nil,
    _btn_initAll = nil,
    _btn_uiSetting = nil,
    _stc_descBg = nil
  },
  _editSearch = {
    _editSearchText = UI.getChildControl(Panel_SkillGroup_CoolTimeSlot, "EditSearchText"),
    _editSearchButton = nil
  },
  _copyUI = {
    _base_SkillBG = UI.getChildControl(Panel_SkillGroup_CoolTimeSlot, "Static_C_SkillBG"),
    _base_SkillIcon = UI.getChildControl(Panel_SkillGroup_CoolTimeSlot, "Static_C_SkillIcon"),
    _base_SkillName = UI.getChildControl(Panel_SkillGroup_CoolTimeSlot, "StaticText_C_SkillName"),
    _base_ComboBox = UI.getChildControl(Panel_SkillGroup_CoolTimeSlot, "Combobox_Sort")
  },
  _uiSize = {descBgY = 0, panelY = 702},
  _comboBoxString = {
    [0] = PAGetString(Defines.StringSheet_GAME, "LUA_UI_SETTING_SKILLCOLLTIMEQUICKSLOT_NOT"),
    [1] = PAGetString(Defines.StringSheet_GAME, "LUA_UI_SETTING_SKILLCOLLTIMEQUICKSLOT_1"),
    [2] = PAGetString(Defines.StringSheet_GAME, "LUA_UI_SETTING_SKILLCOLLTIMEQUICKSLOT_2"),
    [3] = PAGetString(Defines.StringSheet_GAME, "LUA_UI_SETTING_SKILLCOLLTIMEQUICKSLOT_3"),
    [4] = PAGetString(Defines.StringSheet_GAME, "LUA_UI_SETTING_SKILLCOLLTIMEQUICKSLOT_4"),
    [5] = PAGetString(Defines.StringSheet_GAME, "LUA_UI_SETTING_SKILLCOLLTIMEQUICKSLOT_5"),
    [6] = PAGetString(Defines.StringSheet_GAME, "LUA_UI_SETTING_SKILLCOLLTIMEQUICKSLOT_6"),
    [7] = PAGetString(Defines.StringSheet_GAME, "LUA_UI_SETTING_SKILLCOLLTIMEQUICKSLOT_7"),
    [8] = PAGetString(Defines.StringSheet_GAME, "LUA_UI_SETTING_SKILLCOLLTIMEQUICKSLOT_8"),
    [9] = PAGetString(Defines.StringSheet_GAME, "LUA_UI_SETTING_SKILLCOLLTIMEQUICKSLOT_9"),
    [10] = PAGetString(Defines.StringSheet_GAME, "LUA_UI_SETTING_SKILLCOLLTIMEQUICKSLOT_10")
  },
  _skillCoolTimeSlotList_MaxCount = 7,
  _uiData = {},
  _slideIndex = 0,
  _panel_SkillCoolTimeSlot_Value_elementCount = 1,
  _usableSkillTable = {},
  _usableSkillCount = 1,
  _originbuttonSizeX = 0,
  _initialize = false
}
runLua("UI_Data/Script/Window/Skill/Panel_Window_SkillGroup_CoolTimeSlot_1.lua")
runLua("UI_Data/Script/Window/Skill/Panel_Window_SkillGroup_CoolTimeSlot_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_SkillGroup_CoolTimeSlotInit")
function FromClient_SkillGroup_CoolTimeSlotInit()
  PaGlobal_SkillGroup_CoolTimeSlot:initialize()
end
