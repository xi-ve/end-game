PaGlobal_ProductNote_Search = {
  _ui = {
    edit_search = nil,
    stc_keyguideBG = nil,
    txt_keyguideA = nil,
    txt_keyguideB = nil
  },
  _initialize = false
}
runLua("UI_Data/Script/Window/ProductNote/Panel_ProductNote_Search_Renew_1.lua")
runLua("UI_Data/Script/Window/ProductNote/Panel_ProductNote_Search_Renew_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_ProductNote_Search_Init")
function FromClient_ProductNote_Search_Init()
  PaGlobal_ProductNote_Search:initialize()
end
