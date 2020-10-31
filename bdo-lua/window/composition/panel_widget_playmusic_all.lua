PaGlobal_PlayMusic_All = {
  _ui = {_btn_Close = nil, _static_bubbleBox = nil}
}
runLua("UI_Data/Script/Window/Composition/Panel_Widget_PlayMusic_All_1.lua")
runLua("UI_Data/Script/Window/Composition/Panel_Widget_PlayMusic_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_PlayMusic_All_Init")
function FromClient_PlayMusic_All_Init()
  PaGlobal_PlayMusic_All:initialize()
end
