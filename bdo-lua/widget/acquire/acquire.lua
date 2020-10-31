local UI_VT = CppEnums.VehicleType
Panel_Acquire:SetShow(false, false)
Panel_Acquire:setGlassBackground(true)
Panel_Acquire:RegisterShowEventFunc(true, "Acquire_ShowAni()")
Panel_Acquire:SetOffsetIgnorePanel(true)
local TitleTable = {
  PAGetString(Defines.StringSheet_GAME, "ACQUIRE_TITLEMESSAGE_1"),
  PAGetString(Defines.StringSheet_GAME, "ACQUIRE_TITLEMESSAGE_2"),
  PAGetString(Defines.StringSheet_GAME, "ACQUIRE_TITLEMESSAGE_3"),
  PAGetString(Defines.StringSheet_GAME, "ACQUIRE_TITLEMESSAGE_4"),
  PAGetString(Defines.StringSheet_GAME, "ACQUIRE_TITLEMESSAGE_5"),
  PAGetString(Defines.StringSheet_GAME, "ACQUIRE_TITLEMESSAGE_6"),
  PAGetString(Defines.StringSheet_GAME, "ACQUIRE_TITLEMESSAGE_7"),
  PAGetString(Defines.StringSheet_GAME, "ACQUIRE_TITLEMESSAGE_8"),
  PAGetString(Defines.StringSheet_GAME, "ACQUIRE_TITLEMESSAGE_9"),
  PAGetString(Defines.StringSheet_GAME, "ACQUIRE_TITLEMESSAGE_10"),
  PAGetString(Defines.StringSheet_GAME, "ACQUIRE_TITLEMESSAGE_11"),
  PAGetString(Defines.StringSheet_GAME, "ACQUIRE_TITLEMESSAGE_12"),
  PAGetString(Defines.StringSheet_GAME, "ACQUIRE_TITLEMESSAGE_13"),
  PAGetString(Defines.StringSheet_GAME, "ACQUIRE_TITLEMESSAGE_14"),
  PAGetString(Defines.StringSheet_GAME, "ACQUIRE_TITLEMESSAGE_15"),
  PAGetString(Defines.StringSheet_GAME, "ACQUIRE_TITLEMESSAGE_16"),
  PAGetString(Defines.StringSheet_GAME, "ACQUIRE_TITLEMESSAGE_17"),
  PAGetString(Defines.StringSheet_GAME, "ACQUIRE_TITLEMESSAGE_18"),
  PAGetString(Defines.StringSheet_GAME, "ACQUIRE_TITLEMESSAGE_19"),
  PAGetString(Defines.StringSheet_GAME, "ACQUIRE_TITLEMESSAGE_20"),
  "",
  PAGetString(Defines.StringSheet_GAME, "ACQUIRE_TITLEMESSAGE_22"),
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  PAGetString(Defines.StringSheet_GAME, "ACQUIRE_TITLEMESSAGE_30")
}
local objectMessage = {
  PAGetString(Defines.StringSheet_GAME, "ACQUIRE_OBJECTMESSAGE_1"),
  PAGetString(Defines.StringSheet_GAME, "ACQUIRE_OBJECTMESSAGE_2"),
  PAGetString(Defines.StringSheet_GAME, "ACQUIRE_OBJECTMESSAGE_3"),
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  PAGetString(Defines.StringSheet_GAME, "ACQUIRE_OBJECTMESSAGE_12"),
  "",
  "",
  "",
  PAGetString(Defines.StringSheet_GAME, "ACQUIRE_OBJECTMESSAGE_16"),
  PAGetString(Defines.StringSheet_GAME, "ACQUIRE_OBJECTMESSAGE_17"),
  "",
  "",
  PAGetString(Defines.StringSheet_GAME, "ACQUIRE_OBJECTMESSAGE_20"),
  "",
  "",
  "",
  "",
  "",
  ""
}
local productLevelUpObejctMessage = {
  "ACQUIRE_OBJECTMESSAGE_PRODUCTLEVELUP_0",
  "ACQUIRE_OBJECTMESSAGE_PRODUCTLEVELUP_1",
  "ACQUIRE_OBJECTMESSAGE_PRODUCTLEVELUP_2",
  "ACQUIRE_OBJECTMESSAGE_PRODUCTLEVELUP_3",
  "ACQUIRE_OBJECTMESSAGE_PRODUCTLEVELUP_4",
  "ACQUIRE_OBJECTMESSAGE_PRODUCTLEVELUP_5",
  "ACQUIRE_OBJECTMESSAGE_PRODUCTLEVELUP_6",
  "ACQUIRE_OBJECTMESSAGE_PRODUCTLEVELUP_7",
  "ACQUIRE_OBJECTMESSAGE_PRODUCTLEVELUP_8",
  "ACQUIRE_OBJECTMESSAGE_PRODUCTLEVELUP_9",
  "",
  "ACQUIRE_OBJECTMESSAGE_PRODUCTLEVELUP_11"
}
local Acquire_UI = {
  mainPanel = Panel_Acquire,
  ArcText = UI.getChildControl(Panel_Acquire, "ArchiveText"),
  titleText = UI.getChildControl(Panel_Acquire, "TitleText"),
  iconBack = UI.getChildControl(Panel_Acquire, "IconBack"),
  iconImage = UI.getChildControl(Panel_Acquire, "IconSlot"),
  iconEtc = UI.getChildControl(Panel_Acquire, "IconEtc"),
  iconGrade = UI.getChildControl(Panel_Acquire, "IconGrade"),
  servantSkillIcon = UI.getChildControl(Panel_Acquire, "Static_SkillIcon"),
  servantSkillName = UI.getChildControl(Panel_Acquire, "StaticText_SkillName"),
  servantSkillgetHigh = UI.getChildControl(Panel_Acquire, "StaticText_SkillGetHigh")
}
local knowledge_Level = {}
knowledge_Level[1] = UI.getChildControl(Panel_Acquire, "Static_Knowledge_Level1")
knowledge_Level[2] = UI.getChildControl(Panel_Acquire, "Static_Knowledge_Level2")
knowledge_Level[3] = UI.getChildControl(Panel_Acquire, "Static_Knowledge_Level3")
knowledge_Level[4] = UI.getChildControl(Panel_Acquire, "Static_Knowledge_Level4")
knowledge_Level[5] = UI.getChildControl(Panel_Acquire, "Static_Knowledge_Level5")
if isGameTypeKR2() then
  for idx = 1, #knowledge_Level do
    knowledge_Level[idx]:SetShow(false)
  end
  knowledge_Level[1] = UI.getChildControl(Panel_Acquire, "Static_Knowledge_Level1_CH")
  knowledge_Level[2] = UI.getChildControl(Panel_Acquire, "Static_Knowledge_Level2_CH")
  knowledge_Level[3] = UI.getChildControl(Panel_Acquire, "Static_Knowledge_Level3_CH")
  knowledge_Level[4] = UI.getChildControl(Panel_Acquire, "Static_Knowledge_Level4_CH")
  knowledge_Level[5] = UI.getChildControl(Panel_Acquire, "Static_Knowledge_Level5_CH")
end
local Acquire_ConstValue = {animationEndTime = 3.5, showTime = 3}
local itemGradeBorderData = {
  [0] = {
    texture = "new_ui_common_forlua/default/default_etc_00.dds",
    x1 = 103,
    y1 = 176,
    x2 = 153,
    y2 = 226
  },
  [1] = {
    texture = "new_ui_common_forlua/window/skill/skill_ui_00.dds",
    x1 = 172,
    y1 = 44,
    x2 = 214,
    y2 = 86
  },
  [2] = {
    texture = "new_ui_common_forlua/window/skill/skill_ui_00.dds",
    x1 = 172,
    y1 = 1,
    x2 = 214,
    y2 = 43
  },
  [3] = {
    texture = "new_ui_common_forlua/window/skill/skill_ui_00.dds",
    x1 = 129,
    y1 = 1,
    x2 = 171,
    y2 = 43
  },
  [4] = {
    texture = "new_ui_common_forlua/window/skill/skill_ui_00.dds",
    x1 = 129,
    y1 = 44,
    x2 = 171,
    y2 = 86
  }
}
local Acquire_Enum = {
  LevelUp = 0,
  GainProductSkillPoint = 1,
  GainCombatSkillPoint = 2,
  GainGuildSkillPoint = 3,
  LearnSkill = 4,
  SkillLearnable = 5,
  SkillAwakened = 6,
  QuestAccept = 7,
  QuestFailed = 8,
  QuestComplete = 9,
  GetRareItem = 10,
  DiscoveryExplorationNode = 11,
  UpgradeExplorationNode = 12,
  LearnMentalCard = 13,
  ServantLevelUp = 14,
  GainExplorePoint = 15,
  Detected = 16,
  AddNpcWorker = 17,
  GetAlchemy = 18,
  GetManufacture = 19,
  LearnGuildSkill = 20,
  MentalThemeComplete = 21,
  ProductLevelUp = 22,
  GetFishEncyclopedia = 23,
  UpdateFishLength = 24,
  GetFish = 25,
  AcquiredTitle = 26,
  ServantLearnSkill = 27,
  ServantSkillMaster = 28,
  PetLearnSkill = 29,
  ClearGuildSkill = 30,
  AlertInvidualShutDown = 31,
  AlertWorldShutDown = 32,
  FairyLearnSkill = 33,
  Normal = 0,
  Viliage = 1,
  City = 2,
  Gate = 3,
  Farm = 4,
  Filtration = 5,
  Collect = 6,
  Quarry = 7,
  Logging = 8,
  Deco_Tree = 9
}
local Acquire_Value = {
  elapsedTime = Acquire_ConstValue.animationEndTime,
  isLocalQuestAlertShow = false
}
local skillInfo = {
  _learnSkill = {},
  _learnableSkill = {}
}
local isView = false
local preDefaultMsg, preArcObjectMsg, saveEventItem
local function Acquire_Initialize()
  UI.ASSERT(nil ~= Acquire_UI.mainPanel, "mainPanel\tnil")
  UI.ASSERT(nil ~= Acquire_UI.ArcText, "ArcText\t\tnil")
  UI.ASSERT(nil ~= Acquire_UI.titleText, "titleText\tnil")
  UI.ASSERT(nil ~= Acquire_UI.iconBack, "iconBack\t\tnil")
  UI.ASSERT(nil ~= Acquire_UI.iconImage, "iconImage\tnil")
  UI.ASSERT(nil ~= Acquire_UI.iconEtc, "iconEtc\t\tnil")
  UI.ASSERT(nil ~= Acquire_UI.iconGrade, "iconGrade\tnil")
  Acquire_UI.iconImage:SetSize(44, 44)
  Acquire_UI.mainPanel:SetPosX(0)
  Acquire_UI.mainPanel:SetAlpha(1)
  while nil ~= Acquire_getNextData() do
    getAcquirePopFront()
  end
  Acquire_OnResize()
end
function Acquire_Animation()
  local showTime = Acquire_ConstValue.showTime
  local showToHideTime = Acquire_ConstValue.animationEndTime
  local hideToShowTime = 0.7
  Acquire_UI.mainPanel:SetShow(true, true)
  local anim = Acquire_UI.mainPanel:addColorAnimation(0, hideToShowTime, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
  anim:SetStartColor(Defines.Color.C_00FFFFFF)
  anim:SetEndColor(Defines.Color.C_FFFFFFFF)
  anim.IsChangeChild = true
  local anim2 = Acquire_UI.mainPanel:addColorAnimation(showTime, showToHideTime, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
  anim2:SetStartColor(Defines.Color.C_FFFFFFFF)
  anim2:SetEndColor(Defines.Color.C_00FFFFFF)
  anim2.IsChangeChild = true
  return true
end
function Acquire_getNextData()
