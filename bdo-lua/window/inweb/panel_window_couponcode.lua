PaGlobal_CouponCode = {
  _ui = {
    stc_Title = nil,
    txt_Title = nil,
    btn_Close = nil,
    btn_Qusetion = nil,
    btn_Refresh = nil
  },
  _webSizeX = 800,
  _webSizeY = 640,
  _isPadSnap = _ContentsGroup_UsePadSnapping,
  _initialize = false
}
runLua("UI_Data/Script/Window/InWeb/Panel_Window_CouponCode_1.lua")
runLua("UI_Data/Script/Window/InWeb/Panel_Window_CouponCode_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_CouponCode_Init")
function FromClient_CouponCode_Init()
  PaGlobal_CouponCode:initialize()
end
