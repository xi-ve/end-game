PaGlobal_Expirience_All = {
  _ui = {
    txt_title = nil,
    btn_close = nil,
    btn_question = nil,
    btn_refresh = nil,
    btn_popUp = nil,
    btn_produceNote = nil,
    stc_webControl = nil
  },
  _sizeX = 1280,
  _sizeY = 760,
  _panelSizeX = nil,
  _panelSizeY = nil,
  _titleBarSizeX = nil,
  _isFullSize = true,
  _initialize = false,
  _directLinkUrl = nil
}
runLua("UI_Data/Script/Window/ExpirienceWiki/Panel_Window_ExpirienceWiki_All_1.lua")
runLua("UI_Data/Script/Window/ExpirienceWiki/Panel_Window_ExpirienceWiki_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_Expirience_All_Init")
function FromClient_Expirience_All_Init()
  PaGlobal_Expirience_All:initialize()
end
