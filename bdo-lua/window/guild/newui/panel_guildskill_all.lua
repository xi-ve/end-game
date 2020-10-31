PaGlobal_GuildSkill_All = {
  _ui = {},
  slotConfig = {
    createIcon = true,
    createEffect = true,
    createFG = true,
    createFGDisabled = true,
    createFG_Passive = true,
    createLevel = true,
    createLearnButton = true,
    template = {}
  },
  config = {
    slotStartX = 90,
    slotStartY = 6,
    slotGapX = 42,
    slotGapY = 42,
    emptyGapX = 22,
    emptyGapY = 18
  },
  _direction = {
    [0] = {_col = -1, _row = 0},
    [1] = {_col = 1, _row = 0},
    [2] = {_col = 0, _row = -1},
    [3] = {_col = 0, _row = 1}
  },
  slots = {},
  skillNoSlot = {},
  template_guideLine = {},
  _progressSkillPoint = nil,
  _inValidateSlots = {},
  _initialize = false,
  _isConsole = false
}
runLua("UI_Data/Script/Window/Guild/NewUI/Panel_GuildSkill_All_1.lua")
runLua("UI_Data/Script/Window/Guild/NewUI/Panel_GuildSkill_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_GuildSkill_All_Init")
function FromClient_GuildSkill_All_Init()
  PaGlobal_GuildSkill_All:initialize()
end
