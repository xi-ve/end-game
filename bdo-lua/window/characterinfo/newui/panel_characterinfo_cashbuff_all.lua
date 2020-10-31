PaGlobal_CharInfoCashBuff_All = {
  _ui = {
    list2_buff = nil,
    txt_NoBuff = nil,
    stc_PopupTooltip = nil,
    stc_PopupTooltipBg = nil,
    stc_PopupTooltipTitle = nil,
    stc_PopupTooltipDesc = nil,
    stc_PopupTooltipBG_Title = nil,
    stc_Console_KeyGuideBg = nil,
    stc_KeyGuide_X = nil,
    stc_KeyGuide_B = nil
  },
  _eBUFF_TYPE = {
    PCRoom = 1,
    RussiaMonthly = 2,
    Kamasylvia = 3,
    ValuePack = 4,
    GoldValuePack = 5,
    GuildWar = 6,
    Pearl = 7,
    EXP = 8,
    Drop = 9,
    Exchange = 10,
    Merv = 11,
    GoldenBell = 12,
    SkillChange = 13,
    AwakenChange = 14,
    BlackSpiritSkill = 15,
    MemoryofArtisan = 16,
    KamasylviaForRussia = 17,
    PremiumPackForRussia = 18,
    ArshaServerBuff = 19,
    BlackSpiritEXP = 20,
    BookOfCombat = 21,
    FeverBuff = 22
  },
  _buffTypeCount = 22,
  _iconUV = {
    {
      1,
      1,
      41,
      41
    },
    {
      165,
      1,
      205,
      41
    },
    {
      83,
      1,
      123,
      41
    },
    {
      124,
      1,
      164,
      41
    },
    {
      124,
      1,
      164,
      41
    },
    {
      1,
      42,
      41,
      82
    },
    {
      42,
      42,
      82,
      82
    },
    {
      83,
      42,
      123,
      82
    },
    {
      124,
      42,
      164,
      82
    },
    {
      1,
      83,
      41,
      123
    },
    {
      42,
      83,
      82,
      123
    },
    {
      83,
      83,
      123,
      123
    },
    {
      124,
      83,
      164,
      123
    },
    {
      1,
      124,
      41,
      164
    },
    {
      42,
      124,
      82,
      164
    },
    {
      83,
      124,
      123,
      164
    },
    {
      83,
      1,
      123,
      41
    },
    {
      165,
      42,
      205,
      82
    },
    {
      1,
      165,
      41,
      205
    },
    {
      42,
      165,
      82,
      205
    },
    {
      1,
      247,
      41,
      287
    },
    {
      42,
      288,
      82,
      328
    }
  },
  _feverIconUV = {
    off = {
      42,
      288,
      82,
      328
    },
    on = {
      1,
      288,
      41,
      328
    }
  },
  _oriDescSizeX = 0,
  _oriDescSizeY = 0,
  _currentToolTipType = nil,
  _localNodeInvestment = false,
  _buffData = {},
  _listShowBuff = {},
  _defaultEventExp = 1000000,
  _columnCount = 2,
  _saveWayPoint = nil,
  _selfPlayer = nil,
  _initialize = false
}
runLua("UI_Data/Script/Window/CharacterInfo/NewUI/Panel_CharacterInfo_CashBuff_All_1.lua")
runLua("UI_Data/Script/Window/CharacterInfo/NewUI/Panel_CharacterInfo_CashBuff_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_CharInfoCashBuff_AllInit")
function FromClient_CharInfoCashBuff_AllInit()
  PaGlobal_CharInfoCashBuff_All:initialize()
end
