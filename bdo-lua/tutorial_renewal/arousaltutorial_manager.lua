local VCK = CppEnums.VirtualKeyCode
local UI_color = Defines.Color
local IM = CppEnums.EProcessorInputMode
PaGlobal_ArousalTutorial_Manager = {_isDoingArousalTutorial = false}
local _stepNo = 0
local _updateTime = 0
local curcomboIdx = 0
local classType
local function get_ClassType()
  local selfPlayer = getSelfPlayer()
  if nil ~= selfPlayer then
    classType = selfPlayer:getClassType()
  end
end
get_ClassType()
local baseComboCount = 4
local usedSkillKey = {}
local usedSkillMatch = {}
local comboQuestClear = false
local progressQuestIndex = 0
local _ramainTime = 0
local StepCommentboxOriSizeX = 0
local StepCommentboxOriSizeY = 0
local comboKeyStr
local function setComboKeyStr()
  if false == _ContentsGroup_UsePadSnapping then
    comboKeyStr = PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_Warrior_0_ComboKey_2")
  else
    comboKeyStr = PAGetString(Defines.StringSheet_GAME, "LUA_CONSOLE_TUTORIAL_COMBO_ComboKey")
  end
end
setComboKeyStr()
Panel_ArousalTutorial:RegisterUpdateFunc("FGlobal_ArousalTutorial_UpdatePerFrame")
function FGlobal_ArousalTutorial_UpdatePerFrame(deltaTime)
  PaGlobal_ArousalTutorial_Manager:updatePerFrame(deltaTime)
end
function PaGlobal_ArousalTutorial_Manager:isDoingArousalTutorial()
  return self._isDoingArousalTutorial
end
function PaGlobal_ArousalTutorial_Manager:setDoingArousalTutorial(bDoing)
  self._isDoingArousalTutorial = bDoing
end
function PaGlobal_ArousalTutorial_Manager:endTutorial()
  for index = 0, baseComboCount - 1 do
    usedSkillKey[index] = nil
    usedSkillMatch[index] = false
  end
  PaGlobal_ArousalTutorial_Manager:initTutorial()
  PaGlobal_ArousalTutorial_UiManager:hideAllTutorialUi()
  Panel_ArousalTutorial:SetShow(false, true)
  PaGlobal_ArousalTutorial_Manager:setDoingArousalTutorial(false)
end
local SkillComboCheck = {
  [__eClassType_Warrior] = {
    [0] = {
      [0] = {
        349,
        350,
        351,
        705,
        2847
      },
      {
        349,
        350,
        351,
        705,
        2847
      },
      {1712}
    },
    [1] = {
      [0] = {385, 2848},
      {1712},
      {
        1765,
        1766,
        1767,
        1768
      }
    }
  },
  [__eClassType_ElfRanger] = {
    [0] = {
      [0] = {
        1006,
        1091,
        1092,
        1093,
        375,
        1102,
        2855
      },
      {1855}
    },
    [1] = {
      [0] = {
        1029,
        1119,
        1250,
        1251,
        2864
      },
      {1855},
      {
        1875,
        1876,
        1877,
        1878
      }
    }
  },
  [__eClassType_Sorcerer] = {
    [0] = {
      [0] = {
        1056,
        1202,
        1203,
        583,
        2876
      },
      {1769}
    },
    [1] = {
      [0] = {
        1056,
        1202,
        1203,
        583,
        2876
      },
      {1769},
      {
        1785,
        1786,
        1787,
        1788
      }
    }
  },
  [__eClassType_Giant] = {
    [0] = {
      [0] = {
        1041,
        1163,
        1164,
        1165,
        1166,
        296,
        2895
      },
      {1812}
    },
    [1] = {
      [0] = {
        1042,
        1167,
        1168,
        1169,
        1170,
        1171,
        2896
      },
      {1812},
      {
        1830,
        1831,
        1832,
        1833
      }
    }
  },
  [__eClassType_Tamer] = {
    [0] = {
      [0] = {
        1070,
        1232,
        1233,
        1234,
        2926
      },
      {1898}
    },
    [1] = {
      [0] = {
        129,
        130,
        131,
        132,
        205,
        2930
      },
      {1898},
      {
        1913,
        1914,
        1915,
        1916
      }
    }
  },
  [__eClassType_BladeMaster] = {
    [0] = {
      [0] = {
        1445,
        1446,
        1447,
        3169
      },
      {1986}
    },
    [1] = {
      [0] = {
        1263,
        1264,
        1265,
        418,
        3154
      },
      {1986},
      {
        2000,
        2001,
        2002,
        2003
      }
    }
  },
  [__eClassType_BladeMasterWoman] = {
    [0] = {
      [0] = {
        1549,
        1550,
        1551,
        1552,
        1553,
        3184
      },
      {2029}
    },
    [1] = {
      [0] = {
        1515,
        1516,
        1517,
        1518,
        1520,
        3176
      },
      {2029},
      {
        2040,
        2041,
        2042,
        2043
      }
    }
  },
  [__eClassType_Valkyrie] = {
    [0] = {
      [0] = {
        732,
        733,
        734,
        735,
        770,
        3202
      },
      {1943}
    },
    [1] = {
      [0] = {
        1497,
        1498,
        1499,
        3203
      },
      {1943},
      {
        1963,
        1964,
        1965,
        1966
      }
    }
  },
  [__eClassType_WizardMan] = {
    [0] = {
      [0] = {
        822,
        823,
        824,
        825,
        826,
        3133
      },
      {2209}
    },
    [1] = {
      [0] = {
        834,
        835,
        836,
        837,
        838,
        3137
      },
      {2209},
      {
        2225,
        2226,
        2227,
        2228
      }
    }
  },
  [__eClassType_WizardWoman] = {
    [0] = {
      [0] = {
        822,
        823,
        824,
        825,
        826,
        3133
      },
      {2163}
    },
    [1] = {
      [0] = {
        834,
        835,
        836,
        837,
        838,
        3137
      },
      {2163},
      {
        2186,
        2187,
        2188,
        2189
      }
    }
  },
  [__eClassType_NinjaMan] = {
    [0] = {
      [0] = {
        962,
        963,
        964,
        965,
        3111
      },
      {2077}
    },
    [1] = {
      [0] = {
        966,
        967,
        968,
        969,
        970,
        3112
      },
      {2077},
      {
        2104,
        2105,
        2106,
        2107
      }
    }
  },
  [__eClassType_Kunoichi] = {
    [0] = {
      [0] = {
        962,
        963,
        964,
        965,
        3111
      },
      {2120}
    },
    [1] = {
      [0] = {
        966,
        967,
        968,
        969,
        970,
        3112
      },
      {2120},
      {
        2154,
        2155,
        2156,
        2157
      }
    }
  },
  [__eClassType_DarkElf] = {
    [0] = {
      [0] = {
        2268,
        2340,
        2363,
        2341,
        3075
      },
      {2380}
    },
    [1] = {
      [0] = {
        2269,
        2270,
        2271,
        2272,
        2273,
        3089
      },
      {2380},
      {
        2391,
        2392,
        2393,
        2394
      }
    }
  },
  [__eClassType_Combattant] = {
    [0] = {
      [0] = {
        2486,
        2487,
        2488,
        2489,
        3038
      },
      {2558}
    },
    [1] = {
      [0] = {
        2486,
        2487,
        2488,
        2489,
        3038
      },
      {2558},
      {
        2562,
        2563,
        2564,
        2565
      }
    }
  },
  [__eClassType_Mystic] = {
    [0] = {
      [0] = {
        2674,
        2675,
        2676,
        2677,
        3062
      },
      {2762}
    },
    [1] = {
      [0] = {
        2691,
        2692,
        2693,
        3064
      },
      {2762},
      {
        2776,
        2777,
        2778,
        2779
      }
    }
  },
  [__eClassType_Lhan] = {
    [0] = {
      [0] = {
        2967,
        3007,
        3008,
        3009,
        3010,
        3314
      },
      {3255}
    },
    [1] = {
      [0] = {
        2967,
        3007,
        3008,
        3009,
        3010,
        3314
      },
      {3255},
      {
        3267,
        3268,
        3269,
        3270
      }
    }
  },
  [__eClassType_RangerMan] = {
    [0] = {
      [0] = {
        3944,
        3945,
        3946
      },
      {3915},
      {3348},
      {
        3929,
        3930,
        3931,
        3932
      }
    },
    [1] = {
      [0] = {
        3934,
        3935,
        3936,
        3937
      },
      {3927},
      {3928},
      {3927}
    }
  },
  [__eClassType_Guardian] = {
    [0] = {
      [0] = {
        5114,
        5115,
        5116,
        5117
      },
      {5146}
    },
    [1] = {
      [0] = {
        5011,
        5012,
        5013,
        5014
      },
      {5146},
      {
        5154,
        5155,
        5156,
        5157
      }
    }
  },
  [__eClassType_Hashashin] = {
    [0] = {
      [0] = {
        5599,
        5600,
        5601,
        5602,
        5603
      },
      {5584}
    },
    [1] = {
      [0] = {
        5534,
        5535,
        5536,
        5537,
        5538,
        5539
      },
      {5584},
      {
        5625,
        5626,
        5627,
        5628
      }
    },
    [2] = {
      [0] = {
        5625,
        5626,
        5627,
        5628
      },
      {
        5638,
        5639,
        5640
      },
      {
        5642,
        5643,
        5644
      },
      {
        5629,
        5630,
        5631,
        5632
      }
    },
    [3] = {
      [0] = {
        5519,
        5520,
        5521,
        5522,
        5523,
        5665
      },
      {
        5605,
        5606,
        5607,
        5608,
        5609,
        5666
      },
      {
        5524,
        5525,
        5526,
        5527,
        5528,
        5677,
        5678,
        5679
      },
      {
        5560,
        5561,
        5562,
        5563,
        5564,
        5565,
        5580,
        5585,
        5586,
        5587,
        5588,
        5589,
        5688,
        5689,
        5690,
        5691,
        5697,
        5698,
        5699,
        5700
      }
    }
  }
}
local questCheck = {
  [__eClassType_Warrior] = {
    [0] = {
      questGroup = 285,
      questId = 6,
      clearMinigameIndex = 100,
      purposeText = PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_Warrior_0_PurposeText"),
      combo = {
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_Warrior_0_Combo_1"),
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_Warrior_0_Combo_1"),
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_Warrior_0_Combo_2")
      },
      comboKey = {
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_Warrior_0_ComboKey_1"),
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_Warrior_0_ComboKey_1"),
        comboKeyStr
      }
    },
    [1] = {
      questGroup = 285,
      questId = 7,
      clearMinigameIndex = 101,
      purposeText = PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_Warrior_1_PurposeText"),
      combo = {
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_Warrior_1_Combo_1"),
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_Warrior_0_Combo_2"),
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_Warrior_1_Combo_2")
      },
      comboKey = {
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_Warrior_1_ComboKey_1"),
        comboKeyStr,
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_Warrior_1_ComboKey_2")
      }
    }
  },
  [__eClassType_ElfRanger] = {
    [0] = {
      questGroup = 293,
      questId = 6,
      clearMinigameIndex = 100,
      purposeText = PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_Ranger_0_PurposeText"),
      combo = {
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_Ranger_0_Combo_1"),
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_Ranger_0_Combo_2")
      },
      comboKey = {
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_Ranger_0_ComboKey_1"),
        comboKeyStr
      }
    },
    [1] = {
      questGroup = 293,
      questId = 7,
      clearMinigameIndex = 101,
      purposeText = PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_Ranger_1_PurposeText"),
      combo = {
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_Ranger_1_Combo_1"),
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_Ranger_1_Combo_2"),
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_Ranger_1_Combo_3")
      },
      comboKey = {
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_Ranger_1_ComboKey_1"),
        comboKeyStr,
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_Ranger_1_ComboKey_3")
      }
    }
  },
  [__eClassType_Sorcerer] = {
    [0] = {
      questGroup = 287,
      questId = 6,
      clearMinigameIndex = 100,
      purposeText = PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_Socceror_0_PurposeText"),
      combo = {
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_Socceror_0_Combo_1"),
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_Socceror_0_Combo_2")
      },
      comboKey = {
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_Socceror_0_ComboKey_1"),
        comboKeyStr
      }
    },
    [1] = {
      questGroup = 287,
      questId = 7,
      clearMinigameIndex = 101,
      purposeText = PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_Socceror_1_PurposeText"),
      combo = {
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_Socceror_0_Combo_1"),
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_Socceror_0_Combo_2"),
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_Socceror_0_Combo_3")
      },
      comboKey = {
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_Socceror_0_ComboKey_1"),
        comboKeyStr,
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_Socceror_0_ComboKey_1")
      }
    }
  },
  [__eClassType_Giant] = {
    [0] = {
      questGroup = 290,
      questId = 6,
      clearMinigameIndex = 100,
      purposeText = PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_Giant_0_PurposeText"),
      combo = {
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_Giant_0_Combo_1"),
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_Giant_0_Combo_2")
      },
      comboKey = {
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_Giant_0_ComboKey_1"),
        comboKeyStr
      }
    },
    [1] = {
      questGroup = 290,
      questId = 7,
      clearMinigameIndex = 101,
      purposeText = PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_Giant_1_PurposeText"),
      combo = {
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_Giant_1_Combo_1"),
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_Giant_1_Combo_2"),
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_Giant_1_Combo_3")
      },
      comboKey = {
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_Giant_1_ComboKey_1"),
        comboKeyStr,
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_Giant_1_ComboKey_3")
      }
    }
  },
  [__eClassType_Tamer] = {
    [0] = {
      questGroup = 296,
      questId = 6,
      clearMinigameIndex = 100,
      purposeText = PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_Tamer_0_PurposeText"),
      combo = {
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_Tamer_0_Combo_1"),
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_Tamer_0_Combo_2")
      },
      comboKey = {
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_Tamer_0_ComboKey_1"),
        comboKeyStr
      }
    },
    [1] = {
      questGroup = 296,
      questId = 7,
      clearMinigameIndex = 101,
      purposeText = PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_Tamer_1_PurposeText"),
      combo = {
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_Tamer_1_Combo_1"),
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_Tamer_0_Combo_2"),
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_Tamer_1_Combo_3")
      },
      comboKey = {
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_Giant_0_ComboKey_1"),
        comboKeyStr,
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_Ranger_1_ComboKey_3")
      }
    }
  },
  [__eClassType_BladeMaster] = {
    [0] = {
      questGroup = 319,
      questId = 6,
      clearMinigameIndex = 100,
      purposeText = PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_BladeMaster_0_PurposeText"),
      combo = {
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_BladeMaster_0_Combo_1"),
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_BladeMaster_0_Combo_2")
      },
      comboKey = {
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_BladeMaster_0_ComboKey_1"),
        comboKeyStr
      }
    },
    [1] = {
      questGroup = 319,
      questId = 7,
      clearMinigameIndex = 101,
      purposeText = PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_BladeMaster_1_PurposeText"),
      combo = {
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_BladeMaster_1_Combo_1"),
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_BladeMaster_1_Combo_2"),
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_BladeMaster_1_Combo_3")
      },
      comboKey = {
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_BladeMaster_1_ComboKey_1"),
        comboKeyStr,
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_BladeMaster_1_ComboKey_3")
      }
    }
  },
  [__eClassType_BladeMasterWoman] = {
    [0] = {
      questGroup = 321,
      questId = 6,
      clearMinigameIndex = 100,
      purposeText = PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_BladeMasterWoman_0_PurposeText"),
      combo = {
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_BladeMasterWoman_0_Combo_1"),
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_BladeMasterWoman_0_Combo_2")
      },
      comboKey = {
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_BladeMasterWoman_0_ComboKey_1"),
        comboKeyStr
      }
    },
    [1] = {
      questGroup = 321,
      questId = 7,
      clearMinigameIndex = 101,
      purposeText = PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_BladeMasterWoman_1_PurposeText"),
      combo = {
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_BladeMasterWoman_1_Combo_1"),
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_BladeMasterWoman_1_Combo_2"),
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_BladeMasterWoman_1_Combo_3")
      },
      comboKey = {
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_BladeMasterWoman_1_ComboKey_1"),
        comboKeyStr,
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_BladeMasterWoman_1_ComboKey_3")
      }
    }
  },
  [__eClassType_Valkyrie] = {
    [0] = {
      questGroup = 298,
      questId = 6,
      clearMinigameIndex = 100,
      purposeText = PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_Valkyrie_0_PurposeText"),
      combo = {
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_Valkyrie_0_Combo_1"),
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_Valkyrie_0_Combo_2")
      },
      comboKey = {
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_Valkyrie_0_ComboKey_1"),
        comboKeyStr
      }
    },
    [1] = {
      questGroup = 298,
      questId = 7,
      clearMinigameIndex = 101,
      purposeText = PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_Valkyrie_1_PurposeText"),
      combo = {
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_Valkyrie_1_Combo_1"),
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_Valkyrie_1_Combo_2"),
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_Valkyrie_1_Combo_3")
      },
      comboKey = {
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_Valkyrie_1_ComboKey_1"),
        comboKeyStr,
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_Valkyrie_1_ComboKey_3")
      }
    }
  },
  [__eClassType_WizardMan] = {
    [0] = {
      questGroup = 336,
      questId = 6,
      clearMinigameIndex = 100,
      purposeText = PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_WIZARD_PURPOSETEXT_0_0"),
      combo = {
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_WIZARD_COMBO_0_0"),
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_WIZARD_COMBO_0_1")
      },
      comboKey = {
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_WIZARD_COMBOKEY_0_0"),
        comboKeyStr
      }
    },
    [1] = {
      questGroup = 336,
      questId = 7,
      clearMinigameIndex = 101,
      purposeText = PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_WIZARD_PURPOSETEXT_1_0"),
      combo = {
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_WIZARD_COMBO_1_0"),
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_WIZARD_COMBO_1_1"),
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_WIZARD_COMBO_1_2")
      },
      comboKey = {
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_WIZARD_COMBOKEY_1_0"),
        comboKeyStr,
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_WIZARD_COMBOKEY_1_2")
      }
    }
  },
  [__eClassType_WizardWoman] = {
    [0] = {
      questGroup = 334,
      questId = 6,
      clearMinigameIndex = 100,
      purposeText = PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_WITCH_PURPOSETEXT_0_0"),
      combo = {
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_WITCH_COMBO_0_0"),
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_WITCH_COMBO_0_1")
      },
      comboKey = {
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_WITCH_COMBOKEY_0_0"),
        comboKeyStr
      }
    },
    [1] = {
      questGroup = 334,
      questId = 7,
      clearMinigameIndex = 101,
      purposeText = PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_WITCH_PURPOSETEXT_1_0"),
      combo = {
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_WITCH_COMBO_1_0"),
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_WITCH_COMBO_1_1"),
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_WITCH_COMBO_1_2")
      },
      comboKey = {
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_WITCH_COMBOKEY_1_0"),
        comboKeyStr,
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_WITCH_COMBOKEY_1_2")
      }
    }
  },
  [__eClassType_NinjaMan] = {
    [0] = {
      questGroup = 325,
      questId = 6,
      clearMinigameIndex = 100,
      purposeText = PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_Ninja_0_PurposeText"),
      combo = {
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_Ninja_0_Combo_1"),
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_Ninja_0_Combo_2")
      },
      comboKey = {
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_Ninja_0_ComboKey_1"),
        comboKeyStr
      }
    },
    [1] = {
      questGroup = 325,
      questId = 7,
      clearMinigameIndex = 101,
      purposeText = PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_Ninja_1_PurposeText"),
      combo = {
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_Ninja_1_Combo_1"),
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_Ninja_1_Combo_2"),
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_Ninja_1_Combo_3")
      },
      comboKey = {
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_Ninja_1_ComboKey_1"),
        comboKeyStr,
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_Ninja_1_ComboKey_3")
      }
    }
  },
  [__eClassType_Kunoichi] = {
    [0] = {
      questGroup = 327,
      questId = 6,
      clearMinigameIndex = 100,
      purposeText = PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_NinjaWoman_0_PurposeText"),
      combo = {
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_NinjaWoman_0_Combo_1"),
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_NinjaWoman_0_Combo_2")
      },
      comboKey = {
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_NinjaWoman_0_ComboKey_1"),
        comboKeyStr
      }
    },
    [1] = {
      questGroup = 327,
      questId = 7,
      clearMinigameIndex = 101,
      purposeText = PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_NinjaWoman_1_PurposeText"),
      combo = {
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_NinjaWoman_1_Combo_1"),
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_NinjaWoman_1_Combo_2"),
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_NinjaWoman_1_Combo_3")
      },
      comboKey = {
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_NinjaWoman_1_ComboKey_1"),
        comboKeyStr,
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_NinjaWoman_1_ComboKey_3")
      }
    }
  },
  [__eClassType_DarkElf] = {
    [0] = {
      questGroup = 338,
      questId = 6,
      clearMinigameIndex = 100,
      purposeText = PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_DarkElf_0_PurposeText"),
      combo = {
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_DarkElf_0_Combo_1"),
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_DarkElf_0_Combo_2")
      },
      comboKey = {
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_DarkElf_0_ComboKey_1"),
        comboKeyStr
      }
    },
    [1] = {
      questGroup = 338,
      questId = 7,
      clearMinigameIndex = 101,
      purposeText = PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_DarkElf_1_PurposeText"),
      combo = {
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_DarkElf_1_Combo_1"),
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_DarkElf_1_Combo_2"),
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_DarkElf_1_Combo_3")
      },
      comboKey = {
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_DarkElf_1_ComboKey_1"),
        comboKeyStr,
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_DarkElf_1_ComboKey_3")
      }
    }
  },
  [__eClassType_Combattant] = {
    [0] = {
      questGroup = 342,
      questId = 8,
      clearMinigameIndex = 100,
      purposeText = PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_Combattant_0_PurposeText"),
      combo = {
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_Combattant_0_Combo_1"),
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_Combattant_0_Combo_2")
      },
      comboKey = {
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_Combattant_0_ComboKey_1"),
        comboKeyStr
      }
    },
    [1] = {
      questGroup = 342,
      questId = 9,
      clearMinigameIndex = 101,
      purposeText = PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_Combattant_1_PurposeText"),
      combo = {
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_Combattant_1_Combo_1"),
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_Combattant_1_Combo_2"),
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_Combattant_1_Combo_3")
      },
      comboKey = {
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_Combattant_1_ComboKey_1"),
        comboKeyStr,
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_Combattant_1_ComboKey_3")
      }
    }
  },
  [__eClassType_Mystic] = {
    [0] = {
      questGroup = 343,
      questId = 6,
      clearMinigameIndex = 100,
      purposeText = PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_CombattantWoman_0_PurposeText"),
      combo = {
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_CombattantWoman_0_Combo_1"),
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_CombattantWoman_0_Combo_2")
      },
      comboKey = {
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_CombattantWoman_0_ComboKey_1"),
        comboKeyStr
      }
    },
    [1] = {
      questGroup = 343,
      questId = 7,
      clearMinigameIndex = 101,
      purposeText = PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_CombattantWoman_1_PurposeText"),
      combo = {
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_CombattantWoman_1_Combo_1"),
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_CombattantWoman_1_Combo_2"),
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_CombattantWoman_1_Combo_3")
      },
      comboKey = {
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_CombattantWoman_1_ComboKey_1"),
        comboKeyStr,
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_CombattantWoman_1_ComboKey_3")
      }
    }
  },
  [__eClassType_Lhan] = {
    [0] = {
      questGroup = 345,
      questId = 6,
      clearMinigameIndex = 100,
      purposeText = PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_Lahn_0_PurposeText"),
      combo = {
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_Lahn_0_Combo_1"),
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_Lahn_0_Combo_2")
      },
      comboKey = {
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_Lahn_0_ComboKey_1"),
        comboKeyStr
      }
    },
    [1] = {
      questGroup = 345,
      questId = 7,
      clearMinigameIndex = 101,
      purposeText = PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_Lahn_1_PurposeText"),
      combo = {
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_Lahn_1_Combo_1"),
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_Lahn_1_Combo_2"),
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_Lahn_1_Combo_3")
      },
      comboKey = {
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_Lahn_1_ComboKey_1"),
        comboKeyStr,
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_Lahn_1_ComboKey_3")
      }
    }
  },
  [__eClassType_RangerMan] = {
    [0] = {
      questGroup = 347,
      questId = 9,
      clearMinigameIndex = 100,
      purposeText = PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_RangerMan_0_PurposeText"),
      combo = {
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_RangerMan_0_Combo_1"),
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_RangerMan_0_Combo_2"),
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_RangerMan_0_Combo_3"),
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_RangerMan_0_Combo_4")
      },
      comboKey = {
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_RangerMan_0_ComboKey_1"),
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_RangerMan_0_ComboKey_2"),
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_RangerMan_0_ComboKey_3"),
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_RangerMan_0_ComboKey_4")
      }
    },
    [1] = {
      questGroup = 347,
      questId = 10,
      clearMinigameIndex = 101,
      purposeText = PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_RangerMan_1_PurposeText"),
      combo = {
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_RangerMan_1_Combo_1"),
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_RangerMan_1_Combo_1"),
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_RangerMan_1_Combo_1"),
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_RangerMan_1_Combo_1")
      },
      comboKey = {
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_RangerMan_1_ComboKey_1"),
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_RangerMan_1_ComboKey_1"),
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_RangerMan_1_ComboKey_1"),
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_RangerMan_1_ComboKey_1")
      }
    }
  },
  [__eClassType_Guardian] = {
    [0] = {
      questGroup = 363,
      questId = 9,
      clearMinigameIndex = 100,
      purposeText = PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_Guardian_0_PurposeText"),
      combo = {
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_Guardian_0_Combo_1"),
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_Guardian_0_Combo_2")
      },
      comboKey = {
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_Guardian_0_ComboKey_1"),
        comboKeyStr
      }
    },
    [1] = {
      questGroup = 363,
      questId = 10,
      clearMinigameIndex = 101,
      purposeText = PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_Guardian_1_PurposeText"),
      combo = {
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_Guardian_1_Combo_1"),
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_Guardian_1_Combo_2"),
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_Guardian_1_Combo_3")
      },
      comboKey = {
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_Guardian_1_ComboKey_1"),
        comboKeyStr,
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_Guardian_1_ComboKey_2")
      }
    }
  },
  [__eClassType_Hashashin] = {
    [0] = {
      questGroup = 366,
      questId = 10,
      clearMinigameIndex = 100,
      purposeText = PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_Hashashin_0_PurposeText"),
      combo = {
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_Hashashin_0_Combo_1"),
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_Hashashin_0_Combo_2")
      },
      comboKey = {
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_Hashashin_0_ComboKey_1"),
        comboKeyStr
      }
    },
    [1] = {
      questGroup = 366,
      questId = 11,
      clearMinigameIndex = 101,
      purposeText = PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_Hashashin_1_PurposeText"),
      combo = {
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_Hashashin_1_Combo_1"),
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_Hashashin_1_Combo_2"),
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_Hashashin_1_Combo_3")
      },
      comboKey = {
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_Hashashin_1_ComboKey_1"),
        comboKeyStr,
        PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_Hashashin_1_ComboKey_2")
      }
    },
    [2] = {
      questGroup = 845,
      questId = 2,
      clearMinigameIndex = 102,
      purposeText = PAGetString(Defines.StringSheet_GAME, "LUA_EVENT_TUTORIAL_COMBO_Hashashin_0_PurposeText"),
      combo = {
        PAGetString(Defines.StringSheet_GAME, "LUA_EVENT_TUTORIAL_COMBO_Hashashin_0_Combo_1"),
        PAGetString(Defines.StringSheet_GAME, "LUA_EVENT_TUTORIAL_COMBO_Hashashin_0_Combo_2"),
        PAGetString(Defines.StringSheet_GAME, "LUA_EVENT_TUTORIAL_COMBO_Hashashin_0_Combo_3"),
        PAGetString(Defines.StringSheet_GAME, "LUA_EVENT_TUTORIAL_COMBO_Hashashin_0_Combo_4")
      },
      comboKey = {
        PAGetString(Defines.StringSheet_GAME, "LUA_EVENT_TUTORIAL_COMBO_Hashashin_0_ComboKey_1"),
        PAGetString(Defines.StringSheet_GAME, "LUA_EVENT_TUTORIAL_COMBO_Hashashin_0_ComboKey_2"),
        PAGetString(Defines.StringSheet_GAME, "LUA_EVENT_TUTORIAL_COMBO_Hashashin_0_ComboKey_3"),
        PAGetString(Defines.StringSheet_GAME, "LUA_EVENT_TUTORIAL_COMBO_Hashashin_0_ComboKey_4")
      }
    },
    [3] = {
      questGroup = 845,
      questId = 3,
      clearMinigameIndex = 103,
      purposeText = PAGetString(Defines.StringSheet_GAME, "LUA_EVENT_TUTORIAL_COMBO_Hashashin_1_PurposeText"),
      combo = {
        PAGetString(Defines.StringSheet_GAME, "LUA_EVENT_TUTORIAL_COMBO_Hashashin_1_Combo_1"),
        PAGetString(Defines.StringSheet_GAME, "LUA_EVENT_TUTORIAL_COMBO_Hashashin_1_Combo_2"),
        PAGetString(Defines.StringSheet_GAME, "LUA_EVENT_TUTORIAL_COMBO_Hashashin_1_Combo_3"),
        PAGetString(Defines.StringSheet_GAME, "LUA_EVENT_TUTORIAL_COMBO_Hashashin_1_Combo_4")
      },
      comboKey = {
        PAGetString(Defines.StringSheet_GAME, "LUA_EVENT_TUTORIAL_COMBO_Hashashin_1_ComboKey_1"),
        PAGetString(Defines.StringSheet_GAME, "LUA_EVENT_TUTORIAL_COMBO_Hashashin_1_ComboKey_2"),
        PAGetString(Defines.StringSheet_GAME, "LUA_EVENT_TUTORIAL_COMBO_Hashashin_1_ComboKey_3"),
        PAGetString(Defines.StringSheet_GAME, "LUA_EVENT_TUTORIAL_COMBO_Hashashin_1_ComboKey_4")
      }
    }
  }
}
local SkillComment = {
  [__eClassType_Warrior] = nil,
  [__eClassType_ElfRanger] = nil,
  [__eClassType_Sorcerer] = nil,
  [__eClassType_Giant] = nil,
  [__eClassType_Tamer] = nil,
  [__eClassType_BladeMaster] = nil,
  [__eClassType_BladeMasterWoman] = nil,
  [__eClassType_Valkyrie] = nil,
  [__eClassType_WizardMan] = nil,
  [__eClassType_WizardWoman] = nil,
  [__eClassType_NinjaMan] = nil,
  [__eClassType_Kunoichi] = nil,
  [__eClassType_DarkElf] = nil,
  [__eClassType_Combattant] = nil,
  [__eClassType_Mystic] = nil,
  [__eClassType_Lhan] = nil,
  [__eClassType_RangerMan] = {
    [0] = {
      [1] = PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_RangerMan_Step_Comment_1"),
      [2] = PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_RangerMan_Step_Comment_2"),
      [3] = PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_RangerMan_Step_Comment_3"),
      [4] = PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_COMBO_RangerMan_Step_Comment_4")
    }
  },
  [__eClassType_Guardian] = nil
}
local function checkCurrentProgressQuest()
  progressQuestIndex = -1
  for index = 0, #questCheck[classType] do
    if questList_hasProgressQuest(questCheck[classType][index].questGroup, questCheck[classType][index].questId) then
      progressQuestIndex = index
      if not PaGlobal_ArousalTutorial_Manager:isDoingArousalTutorial() and false == comboQuestClear then
        PaGlobal_ArousalTutorial_Manager:startTutorial()
      end
    end
  end
end
function PaGlobal_ArousalTutorial_Manager:checkSkillComboIsComplete(skillNo)
  checkCurrentProgressQuest()
  if -1 == progressQuestIndex then
    return
  end
  local classSkillComboData = SkillComboCheck[classType][progressQuestIndex]
  for key, value in pairs(classSkillComboData[curcomboIdx]) do
    if skillNo == value then
      audioPostEvent_SystemUi(4, 12)
      if true == _ContentsGroup_RenewUI then
        _AudioPostEvent_SystemUiForXBOX(4, 12)
      end
      usedSkillMatch[curcomboIdx] = true
      curcomboIdx = curcomboIdx + 1
      self:ComboStepClearCheck()
    end
  end
  if #classSkillComboData + 1 == curcomboIdx then
    return true
  end
  return false
end
function Tutorial_CheckUsedSkill(skillWrapper)
  local self = PaGlobal_ArousalTutorial_Manager
  if getSelfPlayer():get():getLevel() < 56 then
    return
  end
  if nil == SkillComboCheck[classType] then
    return
  end
  for index = 0, #questCheck[classType] do
    if questList_hasProgressQuest(questCheck[classType][index].questGroup, questCheck[classType][index].questId) then
      local uiQuestInfo = ToClient_GetQuestInfo(questCheck[classType][index].questGroup, questCheck[classType][index].questId)
      if nil == uiQuestInfo then
        _PA_ASSERT(false, "\234\179\181\236\161\180\237\149\160 \236\136\152 \236\151\134\235\138\148 \237\128\152\236\138\164\237\138\184\234\176\128 \234\179\181\236\161\180\237\149\180\236\132\156 \235\172\184\236\160\156\234\176\128 \236\131\157\234\178\188\236\138\181\235\139\136\235\139\164. \236\153\132\235\163\140\237\150\136\236\150\180\236\149\188 \237\149\152\235\138\148 \236\151\176\234\179\132\237\128\152\236\138\164\237\138\184\235\165\188 \236\150\181\236\167\128\235\161\156 \236\180\136\234\184\176\237\153\148\237\149\152\234\179\160 \235\139\164\236\139\156 \235\176\155\236\156\188\235\169\180 \236\157\180\235\159\180 \236\136\152 \236\158\136\236\138\181\235\139\136\235\139\164.")
        return
      end
      local questCondition = uiQuestInfo:getDemandAt(0)
      if questCondition._destCount <= questCondition._currentCount then
        return
      elseif not PaGlobal_ArousalTutorial_Manager:isDoingArousalTutorial() then
        PaGlobal_ArousalTutorial_Manager:startTutorial()
      end
    end
  end
  if comboQuestClear then
    return
  end
  local skillWrapper = selfPlayerUsedSkillFront()
  local skillNo, skillName
  if nil ~= skillWrapper then
    skillNo = skillWrapper:getSkillNo()
    skillName = skillWrapper:getName()
    selfPlayerUsedSkillPopFront()
  end
  comboQuestClear = false
  if self:checkSkillComboIsComplete(skillNo) then
    request_clearMiniGame(questCheck[classType][progressQuestIndex].clearMinigameIndex)
    PaGlobal_ArousalTutorial_UiManager:getUiHeadlineMessage()._ui._purposeText:AddEffect("fUI_Gauge_BigWhite", false, 0, 0)
    comboQuestClear = true
  end
end
function PaGlobal_ArousalTutorial_Manager:ComboStepClearCheck()
  checkCurrentProgressQuest()
  if -1 == progressQuestIndex then
    return
  end
  local descBoxPosX, descBosPosY
  if usedSkillMatch[3] then
    PaGlobal_ArousalTutorial_UiManager:getUiHeadlineMessage()._ui._nextStep_4:SetFontColor(UI_color.C_FFB5FF6D)
    descBoxPosX = PaGlobal_ArousalTutorial_UiManager:getUiHeadlineMessage()._ui._nextStep_4:GetPosX() + PaGlobal_ArousalTutorial_UiManager:getUiHeadlineMessage()._ui._nextStep_4:GetSizeX() / 2
    descBosPosY = PaGlobal_ArousalTutorial_UiManager:getUiHeadlineMessage()._ui._nextStep_4:GetPosY() - PaGlobal_ArousalTutorial_UiManager:getUiHeadlineMessage()._ui._descBox:GetSizeY() - 35
  elseif usedSkillMatch[2] then
    PaGlobal_ArousalTutorial_UiManager:getUiHeadlineMessage()._ui._nextStep_3:SetFontColor(UI_color.C_FFB5FF6D)
    PaGlobal_ArousalTutorial_UiManager:getUiHeadlineMessage()._ui._clearStep_4:SetShow(true)
    PaGlobal_ArousalTutorial_UiManager:getUiHeadlineMessage()._ui._nextArrow_2:SetShow(true)
    descBoxPosX = PaGlobal_ArousalTutorial_UiManager:getUiHeadlineMessage()._ui._nextStep_4:GetPosX() + PaGlobal_ArousalTutorial_UiManager:getUiHeadlineMessage()._ui._nextStep_4:GetSizeX() / 2
    descBosPosY = PaGlobal_ArousalTutorial_UiManager:getUiHeadlineMessage()._ui._nextStep_4:GetPosY() - PaGlobal_ArousalTutorial_UiManager:getUiHeadlineMessage()._ui._descBox:GetSizeY() - 35
  elseif usedSkillMatch[1] then
    PaGlobal_ArousalTutorial_UiManager:getUiHeadlineMessage()._ui._nextStep_2:SetFontColor(UI_color.C_FFB5FF6D)
    PaGlobal_ArousalTutorial_UiManager:getUiHeadlineMessage()._ui._clearStep_3:SetShow(true)
    PaGlobal_ArousalTutorial_UiManager:getUiHeadlineMessage()._ui._nextArrow_1:SetShow(true)
    descBoxPosX = PaGlobal_ArousalTutorial_UiManager:getUiHeadlineMessage()._ui._nextStep_3:GetPosX() + PaGlobal_ArousalTutorial_UiManager:getUiHeadlineMessage()._ui._nextStep_3:GetSizeX() / 2
    descBosPosY = PaGlobal_ArousalTutorial_UiManager:getUiHeadlineMessage()._ui._nextStep_3:GetPosY() - PaGlobal_ArousalTutorial_UiManager:getUiHeadlineMessage()._ui._descBox:GetSizeY() - 35
  elseif usedSkillMatch[0] then
    PaGlobal_ArousalTutorial_UiManager:getUiHeadlineMessage()._ui._nextStep_1:SetFontColor(UI_color.C_FFB5FF6D)
    PaGlobal_ArousalTutorial_UiManager:getUiHeadlineMessage()._ui._clearStep_2:SetShow(true)
    PaGlobal_ArousalTutorial_UiManager:getUiHeadlineMessage()._ui._nextArrow_0:SetShow(true)
    descBoxPosX = PaGlobal_ArousalTutorial_UiManager:getUiHeadlineMessage()._ui._nextStep_2:GetPosX() + PaGlobal_ArousalTutorial_UiManager:getUiHeadlineMessage()._ui._nextStep_2:GetSizeX() / 2
    descBosPosY = PaGlobal_ArousalTutorial_UiManager:getUiHeadlineMessage()._ui._nextStep_2:GetPosY() - PaGlobal_ArousalTutorial_UiManager:getUiHeadlineMessage()._ui._descBox:GetSizeY() - 35
  else
    PaGlobal_ArousalTutorial_UiManager:getUiHeadlineMessage()._ui._clearStep_1:SetShow(true)
    descBoxPosX = PaGlobal_ArousalTutorial_UiManager:getUiHeadlineMessage()._ui._nextStep_1:GetPosX() + PaGlobal_ArousalTutorial_UiManager:getUiHeadlineMessage()._ui._nextStep_1:GetSizeX() / 2
    descBosPosY = PaGlobal_ArousalTutorial_UiManager:getUiHeadlineMessage()._ui._nextStep_1:GetPosY() - PaGlobal_ArousalTutorial_UiManager:getUiHeadlineMessage()._ui._descBox:GetSizeY() - 35
  end
  if nil ~= questCheck[classType][progressQuestIndex].comboKey[curcomboIdx + 1] then
    PaGlobal_ArousalTutorial_UiManager:getUiHeadlineMessage()._ui._descBox:SetPosX(descBoxPosX - PaGlobal_ArousalTutorial_UiManager:getUiHeadlineMessage()._ui._descBox:GetSizeX() / 2)
    PaGlobal_ArousalTutorial_UiManager:getUiHeadlineMessage()._ui._descBox:SetPosY(descBosPosY)
    PaGlobal_ArousalTutorial_UiManager:getUiHeadlineMessage()._ui._command:SetText(questCheck[classType][progressQuestIndex].comboKey[curcomboIdx + 1])
  end
  if nil == SkillComment[classType] then
    PaGlobal_ArousalTutorial_UiManager:getUiHeadlineMessage()._ui._commentBox:SetShow(false)
    PaGlobal_ArousalTutorial_UiManager:getUiHeadlineMessage()._ui._comment:SetShow(false)
  else
    PaGlobal_ArousalTutorial_UiManager:getUiHeadlineMessage()._ui._commentBox:SetShow(true)
    PaGlobal_ArousalTutorial_UiManager:getUiHeadlineMessage()._ui._comment:SetShow(true)
    PaGlobal_ArousalTutorial_UiManager:getUiHeadlineMessage()._ui._comment:SetText(SkillComment[classType][progressQuestIndex][curcomboIdx + 1])
    local textSizeX = PaGlobal_ArousalTutorial_UiManager:getUiHeadlineMessage()._ui._comment:GetTextSizeX()
    if StepCommentboxOriSizeX < textSizeX + 20 then
      PaGlobal_ArousalTutorial_UiManager:getUiHeadlineMessage()._ui._commentBox:SetSize(textSizeX + 40, StepCommentboxOriSizeY)
    else
      PaGlobal_ArousalTutorial_UiManager:getUiHeadlineMessage()._ui._commentBox:SetSize(StepCommentboxOriSizeX, StepCommentboxOriSizeY)
    end
    PaGlobal_ArousalTutorial_UiManager:getUiHeadlineMessage()._ui._commentBox:ComputePos()
    PaGlobal_ArousalTutorial_UiManager:getUiHeadlineMessage()._ui._comment:ComputePos()
  end
end
function PaGlobal_ArousalTutorial_Manager:checkQuestCondition()
  checkCurrentProgressQuest()
  if -1 == progressQuestIndex then
    self:endTutorial()
    return
  end
end
local function updateDeltaTime_ComboTutorial(deltaTime)
  _ramainTime = _ramainTime + deltaTime
  if comboQuestClear and 3 < _ramainTime then
    _stepNo = 0
    PaGlobal_ArousalTutorial_Manager:endTutorial()
  end
  PaGlobal_ArousalTutorial_Manager:checkQuestCondition()
end
function PaGlobal_ArousalTutorial_Manager:updatePerFrame(deltaTime)
  if 101 == _stepNo then
    updateDeltaTime_ComboTutorial(deltaTime)
  end
end
function PaGlobal_ArousalTutorial_Manager:initTutorial()
  PaGlobal_ArousalTutorial_UiHeadlineMessage:mainBGShow()
  PaGlobal_ArousalTutorial_UiManager:getUiHeadlineMessage():computePosAll()
  PaGlobal_ArousalTutorial_UiManager:getUiHeadlineMessage():setShowAll(false)
  PaGlobal_ArousalTutorial_UiManager:getUiHeadlineMessage()._ui._purposeText:SetText("")
  PaGlobal_ArousalTutorial_UiManager:getUiHeadlineMessage()._ui._purposeText:SetShow(true)
  PaGlobal_ArousalTutorial_UiManager:getUiHeadlineMessage()._ui._purposeText:SetAlpha(1)
  PaGlobal_ArousalTutorial_UiManager:getUiHeadlineMessage()._ui._mainBG:SetShow(true)
  PaGlobal_ArousalTutorial_UiManager:getUiHeadlineMessage()._ui._nextStep_1:SetAlpha(1)
  PaGlobal_ArousalTutorial_UiManager:getUiHeadlineMessage()._ui._nextStep_2:SetAlpha(1)
  PaGlobal_ArousalTutorial_UiManager:getUiHeadlineMessage()._ui._nextStep_3:SetAlpha(1)
  PaGlobal_ArousalTutorial_UiManager:getUiHeadlineMessage()._ui._nextArrow_0:SetAlpha(1)
  PaGlobal_ArousalTutorial_UiManager:getUiHeadlineMessage()._ui._nextArrow_1:SetAlpha(1)
  PaGlobal_ArousalTutorial_UiManager:getUiBlackSpirit():hideBubbleKey()
  PaGlobal_ArousalTutorial_UiBlackSpirit:showObsidian(false)
  PaGlobal_ArousalTutorial_UiManager:getUiHeadlineMessage()._ui._descBox:SetShow(true)
  PaGlobal_ArousalTutorial_UiManager:getUiHeadlineMessage()._ui._command:SetShow(true)
  StepCommentboxOriSizeX = PaGlobal_ArousalTutorial_UiManager:getUiHeadlineMessage()._ui._commentBox:GetSizeX()
  StepCommentboxOriSizeY = PaGlobal_ArousalTutorial_UiManager:getUiHeadlineMessage()._ui._commentBox:GetSizeY()
  PaGlobal_ArousalTutorial_UiManager:getUiKeyButton():setShowAll(false)
  PaGlobal_ArousalTutorial_UiManager:getUiKeyButton():ButtonToggleAll(false)
  PaGlobal_ArousalTutorial_UiManager:getUiKeyButton():ButtonToggle("_button_Q", false)
  PaGlobal_ArousalTutorial_UiManager:getUiKeyButton():ButtonToggle("_button_W", false)
  PaGlobal_ArousalTutorial_UiManager:getUiKeyButton():ButtonToggle("_button_A", false)
  PaGlobal_ArousalTutorial_UiManager:getUiKeyButton():ButtonToggle("_button_S", false)
  PaGlobal_ArousalTutorial_UiManager:getUiKeyButton():ButtonToggle("_button_D", false)
  PaGlobal_ArousalTutorial_UiManager:getUiKeyButton():ButtonToggle("_button_Shift", false)
  PaGlobal_ArousalTutorial_UiManager:getUiKeyButton()._ui._prevUsingKey._button_Q = false
  PaGlobal_ArousalTutorial_UiManager:getUiKeyButton()._ui._prevUsingKey._button_W = false
  PaGlobal_ArousalTutorial_UiManager:getUiKeyButton()._ui._prevUsingKey._button_A = false
  PaGlobal_ArousalTutorial_UiManager:getUiKeyButton()._ui._prevUsingKey._button_S = false
  PaGlobal_ArousalTutorial_UiManager:getUiKeyButton()._ui._prevUsingKey._button_D = false
  PaGlobal_ArousalTutorial_UiManager:getUiKeyButton()._ui._prevUsingKey._button_F = false
  PaGlobal_ArousalTutorial_UiManager:getUiKeyButton()._ui._prevUsingKey._button_Shift = false
  PaGlobal_ArousalTutorial_UiManager:getUiKeyButton()._ui._prevUsingKey._m0 = false
  PaGlobal_ArousalTutorial_UiManager:getUiKeyButton()._ui._prevUsingKey._m1 = false
end
function PaGlobal_ArousalTutorial_Manager:startTutorial()
  Panel_ArousalTutorial:SetShow(true, true)
  PaGlobal_ArousalTutorial_Manager:setDoingArousalTutorial(true)
  PaGlobal_ArousalTutorial_Manager:initTutorial()
  for index = 0, #questCheck[classType] do
    if questList_hasProgressQuest(questCheck[classType][index].questGroup, questCheck[classType][index].questId) then
      PaGlobal_ArousalTutorial_UiManager:getUiHeadlineMessage()._ui._purposeText:SetText(questCheck[classType][index].purposeText)
      comboQuestClear = false
      curcomboIdx = 0
      self:ComboStepClearCheck()
      for ii = 1, #questCheck[classType][index].combo do
        if nil ~= questCheck[classType][index].combo[ii] then
          if 1 == ii then
            PaGlobal_ArousalTutorial_UiManager:getUiHeadlineMessage()._ui._nextStep_1:SetTextMode(__eTextMode_AutoWrap)
            PaGlobal_ArousalTutorial_UiManager:getUiHeadlineMessage()._ui._nextStep_1:SetText(questCheck[classType][index].combo[ii])
            PaGlobal_ArousalTutorial_UiManager:getUiHeadlineMessage()._ui._nextStep_1:SetFontColor(UI_color.C_FFC4BEBE)
            PaGlobal_ArousalTutorial_UiManager:getUiHeadlineMessage()._ui._nextStep_1:SetShow(true)
          elseif 2 == ii then
            PaGlobal_ArousalTutorial_UiManager:getUiHeadlineMessage()._ui._nextStep_2:SetTextMode(__eTextMode_AutoWrap)
            PaGlobal_ArousalTutorial_UiManager:getUiHeadlineMessage()._ui._nextStep_2:SetText(questCheck[classType][index].combo[ii])
            PaGlobal_ArousalTutorial_UiManager:getUiHeadlineMessage()._ui._nextStep_2:SetShow(true)
            PaGlobal_ArousalTutorial_UiManager:getUiHeadlineMessage()._ui._nextStep_2:SetFontColor(UI_color.C_FFC4BEBE)
          elseif 3 == ii then
            PaGlobal_ArousalTutorial_UiManager:getUiHeadlineMessage()._ui._nextStep_3:SetTextMode(__eTextMode_AutoWrap)
            PaGlobal_ArousalTutorial_UiManager:getUiHeadlineMessage()._ui._nextStep_3:SetText(questCheck[classType][index].combo[ii])
            PaGlobal_ArousalTutorial_UiManager:getUiHeadlineMessage()._ui._nextStep_3:SetShow(true)
            PaGlobal_ArousalTutorial_UiManager:getUiHeadlineMessage()._ui._nextStep_3:SetFontColor(UI_color.C_FFC4BEBE)
          elseif 4 == ii then
            PaGlobal_ArousalTutorial_UiManager:getUiHeadlineMessage()._ui._nextStep_4:SetTextMode(__eTextMode_AutoWrap)
            PaGlobal_ArousalTutorial_UiManager:getUiHeadlineMessage()._ui._nextStep_4:SetText(questCheck[classType][index].combo[ii])
            PaGlobal_ArousalTutorial_UiManager:getUiHeadlineMessage()._ui._nextStep_4:SetShow(true)
            PaGlobal_ArousalTutorial_UiManager:getUiHeadlineMessage()._ui._nextStep_4:SetFontColor(UI_color.C_FFC4BEBE)
          end
        end
      end
    end
  end
  for index = 0, baseComboCount - 1 do
    usedSkillKey[index] = nil
    usedSkillMatch[index] = false
  end
  _stepNo = 101
end
