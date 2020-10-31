PaGlobal_SA_Widget_SkillList = {
  _ui = {
    stc_skillBG = {},
    stc_skillSlot = {},
    stc_skillUpgrade = nil,
    stc_upgradeNew = nil,
    stc_ctrlIcon = nil,
    stc_upgradeIcon = nil,
    txt_skillPoint = nil
  },
  _initialize = false,
  _isOpenPanel = false,
  _isOpen = false,
  _skillSlot = {},
  _SKILLBG_ORIGIN_SIZEY = 0,
  _PANEL_ORIGIN_SIZEY = 0,
  _maxSkillCnt = 4,
  _maxSkillLev = 3,
  slotConfig_Skill = {
    createIcon = true,
    createEffect = true,
    createFG = false,
    createFGDisabled = false,
    createLevel = false,
    createLearnButton = false,
    createCooltime = true,
    createCooltimeText = true,
    template = {
      effect = {}
    }
  },
  config = {
    slotCount = 10,
    slotInitStartX = -5,
    slotInitStartY = 13,
    slotInitGapX = 0,
    slotInitGapY = 55
  },
  levIconUV = {
    [0] = {
      x1 = 48,
      y1 = 290,
      x2 = 98,
      y2 = 310
    },
    [1] = {
      x1 = 48,
      y1 = 311,
      x2 = 98,
      y2 = 331
    },
    [2] = {
      x1 = 48,
      y1 = 332,
      x2 = 98,
      y2 = 352
    },
    [3] = {
      x1 = 48,
      y1 = 353,
      x2 = 98,
      y2 = 373
    }
  }
}
runLua("UI_Data/Script/Instance/IngameWidget/SA_Widget_SkillList_1.lua")
runLua("UI_Data/Script/Instance/IngameWidget/SA_Widget_SkillList_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_SA_Widget_SkillListInit")
function FromClient_SA_Widget_SkillListInit()
  PaGlobal_SA_Widget_SkillList:initialize()
end
