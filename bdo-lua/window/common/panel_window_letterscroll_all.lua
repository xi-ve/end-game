PaGlobal_LetterScroll_All = {
  _eType = {
    jLetter = 0,
    crape = 1,
    graduation = 2,
    season2graduation = 3
  },
  _ui = {
    btn_Close = nil,
    txt_Contents = nil,
    stc_DecoSeal = nil
  },
  _contentsSpanY = 0,
  _initialize = false
}
runLua("UI_Data/Script/Window/Common/Panel_Window_LetterScroll_All_1.lua")
runLua("UI_Data/Script/Window/Common/Panel_Window_LetterScroll_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_LetterScroll_All_Init")
function FromClient_LetterScroll_All_Init()
  PaGlobal_LetterScroll_All:initialize()
end
