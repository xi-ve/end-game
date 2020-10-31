PaGlobal_OceanGuide = {
  _oceanCurrent = {
    _ui = {
      stc_BG = nil,
      stc_Ring = nil,
      txt_flow = nil,
      stc_Sequence = nil,
      stc_Sequence_All = nil
    }
  },
  _oceanWind = {
    _ui = {
      stc_BG = nil,
      stc_Ring = nil,
      txt_flow = nil,
      stc_Sequence = nil
    }
  },
  _nowCurrentRadian = 0,
  _nowWindRadian = 0,
  _initialize = false
}
runLua("UI_Data/Script/Window/Servant/Panel_Widget_OceanGuide_1.lua")
runLua("UI_Data/Script/Window/Servant/Panel_Widget_OceanGuide_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_OceanGuide_luaLoadComplete")
function FromClient_OceanGuide_luaLoadComplete()
  PaGlobal_OceanGuide:initialize()
end
