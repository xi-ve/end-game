PaGlobal_Arena_Battle = {
  _ui = {
    progress_winnerHp = nil,
    progress_challengerHp = nil,
    txt_winnerName = nil,
    txt_challengerName = nil,
    txt_curPvPMaxTime = nil,
    txt_win = nil
  },
  _curPvPMaxTime = 0,
  _initialize = false
}
runLua("UI_Data/Script/Widget/Arena/Panel_Arena_Battle_1.lua")
runLua("UI_Data/Script/Widget/Arena/Panel_Arena_Battle_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_Arena_BattleInit")
function FromClient_Arena_BattleInit()
  PaGlobal_Arena_Battle:initialize()
end
