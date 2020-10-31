PaGlobal_FarmingTimerReport = {
  _ui = {
    group_TitleGroup = nil,
    txt_Title = nil,
    btn_Close = nil,
    bg_BackImage = nil,
    bg_CharacterStatBg = nil,
    im_CharacterImage = nil,
    txt_BaseInfo = nil,
    txt_MoneyBg = nil,
    txt_PlayTime = nil,
    txt_Revenue = nil,
    txt_Attack = nil,
    txt_Awaken = nil,
    txt_Defence = nil,
    group_ItemGroup = nil,
    btn_GetItemList = nil,
    btn_ConsumeItemList = nil,
    btn_Experience = nil,
    bg_ItemListBg = nil,
    list2_Item = nil,
    list2_1_VerticalScroll = nil,
    list2_1_VerticalScroll_UpButton = nil,
    list2_1_VerticalScroll_DownButton = nil,
    list2_1_VerticalScroll_CtrlButton = nil,
    list2_1_HorizontalScroll = nil,
    list2_1_HorizontalScroll_UpButton = nil,
    list2_1_HorizontalScroll_DownButton = nil,
    list2_1_HorizontalScroll_CtrlButton = nil,
    bg_DescBg = nil,
    txt_Text_Desc = nil
  },
  _slotConfig = {createIcon = true, createCount = true},
  _config = {
    _slotCount = 5,
    _slotCols = 1,
    _slotRows = 0,
    _slotBGStartX = 10,
    _slotBGStartY = 10,
    _slotStartX = 10,
    _slotStartY = 10,
    _slotGapX = 54,
    _slotGapY = 54
  },
  _awakenWeapon = {
    [__eClassType_Warrior] = ToClient_IsContentsGroupOpen("901"),
    [__eClassType_ElfRanger] = ToClient_IsContentsGroupOpen("902"),
    [__eClassType_Sorcerer] = ToClient_IsContentsGroupOpen("903"),
    [__eClassType_Giant] = ToClient_IsContentsGroupOpen("904"),
    [__eClassType_Tamer] = ToClient_IsContentsGroupOpen("905"),
    [__eClassType_BladeMaster] = ToClient_IsContentsGroupOpen("906"),
    [__eClassType_BladeMasterWoman] = ToClient_IsContentsGroupOpen("907"),
    [__eClassType_Valkyrie] = ToClient_IsContentsGroupOpen("908"),
    [__eClassType_WizardMan] = ToClient_IsContentsGroupOpen("909"),
    [__eClassType_WizardWoman] = ToClient_IsContentsGroupOpen("910"),
    [__eClassType_NinjaMan] = ToClient_IsContentsGroupOpen("911"),
    [__eClassType_Kunoichi] = ToClient_IsContentsGroupOpen("912"),
    [__eClassType_DarkElf] = ToClient_IsContentsGroupOpen("913"),
    [__eClassType_Combattant] = ToClient_IsContentsGroupOpen("914"),
    [__eClassType_Mystic] = ToClient_IsContentsGroupOpen("918"),
    [__eClassType_Lhan] = ToClient_IsContentsGroupOpen("916"),
    [__eClassType_RangerMan] = ToClient_IsContentsGroupOpen("942"),
    [__eClassType_ShyWaman] = ToClient_IsContentsGroupOpen("1366"),
    [__eClassType_Guardian] = ToClient_IsContentsGroupOpen("1317"),
    [__eClassType_Hashashin] = ToClient_IsContentsGroupOpen("1136")
  },
  _itemGradeColor = {
    [__eItemGradeNormal] = Defines.Color.C_FFFFFFFF,
    [__eItemGradeMagic] = 4284350320,
    [__eItemGradeRare] = 4283144191,
    [__eItemGradeUnique] = 4294953010,
    [__eItemGradeEpic] = 4294929408,
    [__eItemGradeTypeCount] = Defines.Color.C_FFFFFFFF
  },
  _slotBgBases = nil,
  _slots = nil,
  _defaultBgSize = {x = 0, y = 0},
  _defaultPanelSize = {x = 0, y = 0},
  _startItemIndex = 0,
  _startItemSaveIndex = 0,
  _selectTab = __eFarmingReportTab_FarmingItemList
}
runLua("UI_Data/Script/Widget/FarmingTimer/Panel_Widget_FarmingTimerReport_1.lua")
runLua("UI_Data/Script/Widget/FarmingTimer/Panel_Widget_FarmingTimerReport_2.lua")
registerEvent("FromClient_luaLoadComplete", "PaGlobal_FarmingTimerReport_luaLoadComplete")
function PaGlobal_FarmingTimerReport_luaLoadComplete()
  PaGlobal_FarmingTimerReport:initialize()
end
