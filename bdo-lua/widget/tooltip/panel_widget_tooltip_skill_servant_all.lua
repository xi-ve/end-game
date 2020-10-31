PaGlobal_Tooltip_Skill_Servant_All = {
  _ui = {
    txt_SkillName = nil,
    stc_SkillIcon = nil,
    txt_SkillCommandDesc = nil,
    txt_SkillDesc = nil,
    txt_SkillCondition_Title = nil,
    txt_SkillCondition_Value = nil,
    stc_DescBG = nil
  },
  _slotData = {},
  _initialize = false
}
runLua("UI_Data/Script/Widget/ToolTip/Panel_Widget_Tooltip_Skill_Servant_All_1.lua")
runLua("UI_Data/Script/Widget/ToolTip/Panel_Widget_Tooltip_Skill_Servant_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_Tooltip_Skill_Servant_All_Init")
function FromClient_Tooltip_Skill_Servant_All_Init()
  PaGlobal_Tooltip_Skill_Servant_All:initialize()
end
