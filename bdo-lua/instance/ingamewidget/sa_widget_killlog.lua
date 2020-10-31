PaGlobal_SA_Widget_KillLog = {
  _ui = {stc_killLogBG = nil},
  _initialize = false,
  _maxKillLogCnt = 5,
  _killLog = {},
  _dataList = Array.new(),
  _killCount = {},
  _isShow = false,
  _maxViewTime = 10,
  _txtOffset = 5,
  _anitime = 0.1,
  _aniDeltaTime = 0,
  _isAniCooltime = false,
  _texUV = {
    path = "ShadowArena/Basic/SA_Character_00.dds",
    [__eClassType_Shadow_Warrior_Type1] = {
      x1 = 1,
      x2 = 1,
      y1 = 416,
      y2 = 91
    },
    [__eClassType_Shadow_Warrior_Type2] = {
      x1 = 1,
      x2 = 638,
      y1 = 416,
      y2 = 728
    },
    [__eClassType_Shadow_Maehwa_Type1] = {
      x1 = 1,
      x2 = 547,
      y1 = 416,
      y2 = 637
    },
    [__eClassType_Shadow_Maehwa_Type2] = {
      x1 = 1,
      x2 = 274,
      y1 = 416,
      y2 = 364
    },
    [__eClassType_Shadow_Sorcerer_Type1] = {
      x1 = 1,
      x2 = 183,
      y1 = 416,
      y2 = 273
    },
    [__eClassType_Shadow_Sorcerer_Type2] = {
      x1 = 1,
      x2 = 365,
      y1 = 416,
      y2 = 455
    },
    [__eClassType_Shadow_Giant_Type1] = {
      x1 = 1,
      x2 = 729,
      y1 = 416,
      y2 = 819
    },
    [__eClassType_Shadow_Giant_Type2] = {
      x1 = 1,
      x2 = 92,
      y1 = 416,
      y2 = 182
    },
    [__eClassType_Shadow_Kunoichi_Type1] = {
      x1 = 1,
      x2 = 456,
      y1 = 416,
      y2 = 546
    },
    [__eClassType_Shadow_Kunoichi_Type2] = {
      x1 = 1,
      x2 = 1002,
      y1 = 416,
      y2 = 1092
    },
    [__eClassType_Shadow_BladeMaster_Type1] = {
      x1 = 1,
      x2 = 820,
      y1 = 416,
      y2 = 910
    },
    [__eClassType_Shadow_WizardWoman_Type1] = {
      x1 = 1,
      x2 = 1093,
      y1 = 416,
      y2 = 1183
    },
    [__eClassType_Shadow_WizardWoman_Type2] = {
      x1 = 1,
      x2 = 1184,
      y1 = 416,
      y2 = 1274
    },
    [__eClassType_Shadow_Valkyrie_Type1] = {
      x1 = 1,
      x2 = 911,
      y1 = 416,
      y2 = 1001
    },
    lock = {
      x1 = 1,
      x2 = 1275,
      y1 = 416,
      y2 = 1365
    }
  },
  _rewardItemKeys = {724538, 723501}
}
runLua("UI_Data/Script/Instance/IngameWidget/SA_Widget_KillLog_1.lua")
runLua("UI_Data/Script/Instance/IngameWidget/SA_Widget_KillLog_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_SA_Widget_KillLogInit")
function FromClient_SA_Widget_KillLogInit()
  PaGlobal_SA_Widget_KillLog:initialize()
end
