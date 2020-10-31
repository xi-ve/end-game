PaGlobal_FarmInfo_All = {
  _eTooltipType = {
    temperature = 0,
    humidity = 1,
    undergroundWater = 2,
    compost = 3,
    growing = 4,
    helth = 5,
    needWater = 6,
    loopCount = 6
  },
  _ePopupType = {installation = 0, interaction = 1},
  _ePlantType = {crops = 0, livestock = 1},
  _ui = {
    _txt_title = nil,
    _btn_close = nil,
    _btn_question = nil,
    _txt_remainTime = nil,
    _txt_spaceValue = nil,
    _stc_temperatureBg = nil,
    _stc_temperatureProgressBg = nil,
    _stc_temperatureHighLight = nil,
    _stc_temperatureArrow = nil,
    _slider_temperature = nil,
    _txt_temperatureValue = nil,
    _stc_humidityBg = nil,
    _stc_humidityProgressBg = nil,
    _stc_humidityHighLight = nil,
    _stc_humidityArrow = nil,
    _slider_humidity = nil,
    _txt_humidityValue = nil,
    _progress_undergroundWaterBack = nil,
    _progress_undergroundWaterFront = nil,
    _txt_undergroundWaterValue = nil,
    _txt_compostTitle = nil,
    _progress_compost = nil,
    _stc_compostBg = nil,
    _stc_compostAdd = nil,
    _stc_scarecrowIcon = nil,
    _txt_scarecrowDesc = nil,
    _stc_waterwayIcon = nil,
    _txt_waterwayDesc = nil,
    _progress_growing = nil,
    _txt_growingValue = nil,
    _progress_helth = nil,
    _txt_helthValue = nil,
    _progress_needWater = nil,
    _txt_needWaterValue = nil,
    _stc_pruningIcon = nil,
    _txt_pruningDesc = nil,
    _stc_insectDamegeIcon = nil,
    _txt_insectDamegeDesc = nil,
    _txt_tooltipTitles = {}
  },
  _uiIconUV = {},
  _popupType = 0,
  _plantType = 0,
  _currentActorKeyRaw = 0,
  _tempPercent = 0,
  _humidityPercent = 0,
  _isConsole = false,
  _initialize = false
}
runLua("UI_Data/Script/Widget/Housing/Panel_Housing_FarmInfo_All_1.lua")
runLua("UI_Data/Script/Widget/Housing/Panel_Housing_FarmInfo_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_PaGlobal_FarmInfo_All_Init")
function FromClient_PaGlobal_FarmInfo_All_Init()
  PaGlobal_FarmInfo_All:initialize()
end
