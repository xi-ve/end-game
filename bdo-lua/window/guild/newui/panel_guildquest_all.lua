PaGlobal_GuildQuest_All = {
  _ui = {
    stc_TopBG = nil,
    txt_ProgressQuestTime = nil,
    txt_ProgressQuestName = nil,
    txt_ProgressQuestCondition = nil,
    stc_TitleTabBG = nil,
    stc_SelectLine = nil,
    stc_MainArea = nil,
    btn_LeftArrow = nil,
    btn_RightArrow = nil,
    txt_PageCount = nil,
    stc_QuestList_Templete = nil,
    btn_Left_Templete = nil,
    txt_QuestTitle_Templete = nil,
    txt_QuestDesc_Templete = nil,
    txt_QuestCondition_Templete = nil,
    txt_QuestLimitTime_Templete = nil,
    stc_QuestIcon_Templete = nil,
    btn_Right_Templete = nil,
    txt_QuestAccept_Templete = nil,
    txt_QuestFunds_Templete = nil,
    txt_GuildFunds = nil,
    btn_GetGuildMoney = nil
  },
  _ui_Console = {},
  _parentBG = nil,
  _rdo_Tab = {},
  _TabCount = 3,
  _guildQuestType = nil,
  _qeustListMaxShowCount = 4,
  _questList = {},
  _progressQuestConditionMaxCount = 5,
  _progressQuestCondition = {},
  _currentPage = nil,
  _maxPageCount = nil,
  _acceptIndex = 0,
  _isReqeustMemberBonus = false,
  _initialize = false,
  _isConsole = false
}
runLua("UI_Data/Script/Window/Guild/NewUI/Panel_GuildQuest_All_1.lua")
runLua("UI_Data/Script/Window/Guild/NewUI/Panel_GuildQuest_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_GuildQuest_All_Init")
function FromClient_GuildQuest_All_Init()
  PaGlobal_GuildQuest_All:initialize()
end
