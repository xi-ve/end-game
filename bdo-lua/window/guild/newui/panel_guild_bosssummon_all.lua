PaGlobal_Guild_BossSummon_All = {
  _ui = {
    list2_BossList = nil,
    stc_BottomBG = nil,
    txt_Desc = nil,
    stc_RewardIcon = nil
  },
  _state = {
    NOTREADY = 0,
    GOPOSITION = 1,
    READY = 2,
    CLEAR = 3,
    StateMax = 4
  },
  _bossInfoList = {},
  _isConsole = false,
  _initialize = false
}
runLua("UI_Data/Script/Window/Guild/NewUI/Panel_Guild_BossSummon_All_1.lua")
runLua("UI_Data/Script/Window/Guild/NewUI/Panel_Guild_BossSummon_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_Guild_BossSummon_All_Init")
function FromClient_Guild_BossSummon_All_Init()
  PaGlobal_Guild_BossSummon_All:initialize()
end
