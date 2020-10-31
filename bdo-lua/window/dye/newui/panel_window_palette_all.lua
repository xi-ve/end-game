PaGlobal_Palette_All = {
  _ui = {
    stc_TitleBG = nil,
    stc_TabGroup = nil,
    rdo_TabAll = nil,
    rdo_TabMine = nil,
    stc_SelectedTabLine = nil,
    stc_MaterialTabGroup = nil,
    txt_SelectedMaterialName = nil,
    scroll = nil,
    scrollBtn = nil,
    stc_BottomGroup = nil,
    edit_AmpuleCount = nil,
    txt_SelectedAmpuleName = nil,
    stc_SelectedAmpuleBG = nil,
    stc_SelectedAmpule = nil
  },
  _ui_pc = {
    btn_Close = nil,
    btn_Help = nil,
    btn_Withdraw = nil
  },
  _ui_console = {
    stc_KeyGuideLB = nil,
    stc_KeyGuideRB = nil,
    stc_KeyGuideBG = nil,
    txt_KeyGuideA = nil,
    txt_KeyGuideB = nil
  },
  _materialCount = 8,
  _rdo_Material = {},
  _materialName = {},
  slot = {},
  config = {
    maxSlotColsCount = 10,
    maxSlotRowsCount = 9,
    startPosX = 15,
    startPosY = -5,
    cellSpan = 2,
    selectedCategoryIdx = 0,
    isShowAll = true,
    selectedColorIdx = 0,
    selectedAmplurCount_s64 = 0,
    scrollStartIdx = 0,
    colorTotalRows = 0
  },
  _isConsole = false,
  _initialize = false
}
runLua("UI_Data/Script/Window/Dye/NewUI/Panel_Window_Palette_All_1.lua")
runLua("UI_Data/Script/Window/Dye/NewUI/Panel_Window_Palette_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_PaletteInit")
function FromClient_PaletteInit()
  PaGlobal_Palette_All:initialize()
end
