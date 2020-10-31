PaGlobal_WarInfomation_All = {
  _eCategory = {
    name = 0,
    count = 1,
    maxCount = 2,
    needSpace = 3,
    needMaterial = 4,
    loopCount = 4
  },
  _ui = {
    _stc_titleBg = nil,
    _stc_categoryBg = nil,
    _txt_objectTitle = {},
    _stc_detailGroup = nil,
    _stc_templeteBg = nil,
    _txt_templete = {},
    _stc_bottomBg = nil,
    _txt_objectCount = nil,
    _txt_maxInnerSize = nil,
    _txt_titlePos = {},
    _txt_templetePos = {}
  },
  _innerObjectCount = 0,
  _innerObjectPool = {},
  _addedNameSizeX = 0,
  _defaultPanelSpan = nil,
  _defualtPanelSizeX = 0,
  _defaultCategoryBgSizeX = 0,
  _defaultDetailBgSizeX = 0,
  _defaultTempleteBgSizeX = 0,
  _initialize = false
}
runLua("UI_Data/Script/Window/Housing/Panel_House_InstallationMode_WarInfomation_All_1.lua")
runLua("UI_Data/Script/Window/Housing/Panel_House_InstallationMode_WarInfomation_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_WarInfomation_All_Init")
function FromClient_WarInfomation_All_Init()
  PaGlobal_WarInfomation_All:initialize()
end
