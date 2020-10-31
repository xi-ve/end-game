PaGlobal_SkillPreset = {
  _ui = {
    stc_Block = nil,
    stc_BG = nil,
    btn_Close = nil,
    stc_Desc = nil,
    stc_Save = nil,
    stc_title = nil,
    txt_title = nil,
    btn_Close2 = nil,
    btn_Slot = {}
  },
  _maxSlotCount = 0,
  _selectSlot = nil,
  _initialize = false
}
runLua("UI_Data/Script/Window/Skill/Panel_Window_SkillPreset_1.lua")
runLua("UI_Data/Script/Window/Skill/Panel_Window_SkillPreset_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_SkillPresetInit")
function FromClient_SkillPresetInit()
  PaGlobal_SkillPreset:initialize()
end
