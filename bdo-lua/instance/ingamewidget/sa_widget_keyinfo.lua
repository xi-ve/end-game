PaGlobal_SA_Widget_KeyInfo = {
  _ui = {
    stc_invenBG = nil,
    txt_inven = nil,
    stc_invenKey = nil,
    stc_EscBG = nil,
    txt_Esc = nil,
    stc_EscKey = nil
  },
  _initialize = false
}
runLua("UI_Data/Script/Instance/IngameWidget/SA_Widget_keyInfo_1.lua")
runLua("UI_Data/Script/Instance/IngameWidget/SA_Widget_keyInfo_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_SA_Widget_KeyInfoInit")
function FromClient_SA_Widget_KeyInfoInit()
  PaGlobal_SA_Widget_KeyInfo:initialize()
end
