PaGlobal_QuestInfo_All = {
  _ui = {
    stc_titleBg = nil,
    stc_subBg = nil,
    txt_attributionType = nil,
    txt_questGroupTitle = nil,
    txt_questTitle = nil,
    chk_autoNavi = nil,
    chk_questNavi = nil,
    chk_questGiveUp = nil,
    stc_questIconBg = nil,
    stc_questIcon = nil,
    txt_acceptNPC = nil,
    txt_completeNPC = nil,
    txt_condition = nil,
    frame_questDesc = nil,
    frame_content = nil,
    txt_frameDesc = nil,
    stc_rewardGroupBg = nil,
    stc_baseRewardBg = nil,
    txt_baseRewardTitle = nil,
    _baseRewardSlotBg = {},
    _baseRewardSlot = {},
    stc_selectRewardBg = nil,
    txt_selectRewardTitle = nil,
    _selectRewardSlotBg = {},
    _selectRewardSlot = {}
  },
  _ui_pc = {
    btn_close = nil,
    btn_giveUp = nil,
    btn_callSpirit = nil,
    chk_questNavi = nil,
    chk_autoNavi = nil
  },
  _ui_console = {
    stc_keyGuideBg = nil,
    stc_tooltip = nil,
    stc_scroll = nil,
    stc_giveUp = nil,
    stc_navi = nil,
    stc_close = nil
  },
  _rewardSlotConfig = {
    createIcon = true,
    createBorder = true,
    createEnchant = true,
    createCount = true,
    createClassEquipBG = true,
    createCash = true
  },
  _MAX_BASE_REWARD = 12,
  _MAX_SELECT_REWARD = 6,
  _baseReward = {},
  _uiBackBaseReward = {},
  _listBaseRewardSlots = {},
  _selectReward = {},
  _uiBackSelectReward = {},
  _listSelectRewardSlots = {},
  _selectRewardCount = 0,
  _OpenInfo = {
    _groupId = nil,
    _qeustId = nil,
    _uiCondition = nil,
    _groupTitle = nil,
    _questGroupCount = nil,
    _fromQuestWidget = nil,
    _isRecommand = nil,
    _isNextQuest = nil,
    _isCleared = nil
  },
  _originDescBgSizeY = 0,
  _isConsole = false,
  _initialize = false
}
runLua("UI_Data/Script/Window/Quest/Panel_Window_QuestInfo_All_1.lua")
runLua("UI_Data/Script/Window/Quest/Panel_Window_QuestInfo_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_QuestInfo_All_Init")
function FromClient_QuestInfo_All_Init()
  PaGlobal_QuestInfo_All:initialize()
end
