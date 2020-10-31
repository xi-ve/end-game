PaGlobal_ServantNameRegist_All = {
  _ui = {
    _stc_Title = nil,
    _btn_Close_PC = nil,
    _stc_MainBg = nil,
    _stc_ContentBg = nil,
    _stc_HorseImage = nil,
    _stc_GenderIcon = nil,
    _txt_HpTitle = nil,
    _txt_HpValue = nil,
    _txt_StaminaTitle = nil,
    _txt_StaminaValue = nil,
    _txt_WeightTitle = nil,
    _txt_WeightValue = nil,
    _txt_LeftLifeTitle = nil,
    _txt_LeftLifeValue = nil,
    _txt_SpeedTitle = nil,
    _txt_SpeedValue = nil,
    _txt_AccelTitle = nil,
    _txt_AccelValue = nil,
    _txt_CorneringTitle = nil,
    _txt_CorneringValue = nil,
    _txt_BreakTitle = nil,
    _txt_BreakValue = nil,
    _stc_EditNaming = nil,
    _stc_EditRentalName = nil,
    _stc_KeyGuide_X = nil,
    _stc_PriceBg = nil,
    _txt_Price = nil,
    _rdo_Mine = nil,
    _rdo_All = nil,
    _btn_Confirm = nil,
    _btn_Cancel = nil,
    _stc_Console_KeyGuides = nil,
    _stc_KeyGuide_A = nil,
    _stc_KeyGuide_B = nil
  },
  _ENUM_OPENTYPE = {
    _TAMING = CppEnums.ServantRegist.eEventType_Taming,
    _MATING = CppEnums.ServantRegist.eEventType_Mating,
    _CHANGENAME = CppEnums.ServantRegist.eEventType_ChangeName,
    _REGISTER_MARKET = CppEnums.ServantRegist.eEventType_RegisterMarket,
    _REGISTER_MATING = CppEnums.ServantRegist.eEventType_RegisterMating,
    _REGISTER_RENTAL = 6
  },
  _preServantCount = nil,
  _currentServantCount = nil,
  _currentServantNo = nil,
  _registerType = nil,
  _txt_LeftLifeValue = nil,
  _characterKey = nil,
  _minPrice = nil,
  _maxPrice = nil,
  _registerMatingType = nil,
  _ORIGIN_PANELSIZE_Y = nil,
  _ORIGIN_MAINBGSIZE_Y = nil,
  _ORIGIN_BUTTONPOS_Y = nil,
  _isConsole = false,
  _initailize = false
}
runLua("UI_Data/Script/Window/Servant/NewUI/Panel_Dialog_ServantNameRegist_All_1.lua")
runLua("UI_Data/Script/Window/Servant/NewUI/Panel_Dialog_ServantNameRegist_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_ServantNameRegist_All_Init")
function FromClient_ServantNameRegist_All_Init()
  PaGlobal_ServantNameRegist_All:initialize()
end
