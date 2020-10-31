PaGlobal_SA_Widget_SkillCooltime = {
  _ui = {txt_coolTimeTitle = nil},
  config = {
    slotGapX = 50,
    slotGapY = 50,
    screenPosX = 0.67,
    screenPosY = 0.42
  },
  slotConfig = {
    createIcon = true,
    createEffect = false,
    createFG = false,
    createFGDisabled = false,
    createLevel = false,
    createLearnButton = false,
    createCooltime = true,
    createCooltimeText = true
  },
  slots = {},
  slots_description = {},
  slotPool = Array.new(),
  slotPool_desc = Array.new(),
  slotCount = 0,
  slotCount_desc = 0,
  textRemainTime = 1.5,
  showToggle = true,
  skillReuseTime = nil,
  _initialize = false
}
runLua("UI_Data/Script/Instance/IngameWidget/SA_Widget_SkillCooltime_1.lua")
runLua("UI_Data/Script/Instance/IngameWidget/SA_Widget_SkillCooltime_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_SA_Widget_SkillCooltimeInit")
function FromClient_SA_Widget_SkillCooltimeInit()
  PaGlobal_SA_Widget_SkillCooltime:initialize()
end
