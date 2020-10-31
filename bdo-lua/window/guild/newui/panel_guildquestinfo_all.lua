PaGlobal_GuildQuestInfo_All = {
  _ui = {
    stc_TitleArea = nil,
    btn_Close = nil,
    stc_MainArea = nil,
    txt_QuestTitle = nil,
    txt_QuestDesc = nil,
    txt_QuestCondition = nil,
    txt_QuestTime = nil,
    txt_QuestFunds = nil,
    stc_SlotArea = nil,
    stc_SlotTemplete = nil,
    btn_function = nil
  },
  _rewardSlotConfig = {
    createIcon = true,
    createBorder = true,
    createCount = true,
    createClassEquipBG = true,
    createCash = true
  },
  _keyguide = {},
  _defaultPanelSizeY = nil,
  _rewardSlotBG = {},
  _rewardSlot = {},
  _defaultSlotCount = 12,
  _slotXGap = 50,
  _slotYGap = 50,
  _isProgressingQuest = false,
  _gapSizeYBig = 20,
  _gapSizeYSmall = 10,
  _initialize = false,
  _isConsole = false
}
runLua("UI_Data/Script/Window/Guild/NewUI/Panel_GuildQuestInfo_All_1.lua")
runLua("UI_Data/Script/Window/Guild/NewUI/Panel_GuildQuestInfo_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_GuildQuestInfo_All_Init")
function FromClient_GuildQuestInfo_All_Init()
  PaGlobal_GuildQuestInfo_All:initialize()
end
