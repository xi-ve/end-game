PaGlobal_SA_MainFrame = {
  _ui_mainStatus = {
    progress2_hp = nil,
    progress2_stamina = nil,
    _hpGaugeHead = nil,
    _staminaGaugeHead = nil,
    _txt_hp = nil,
    _txt_stamina = nil,
    _stc_characterBG = nil,
    _stc_characterIcon = nil,
    _stc_characterEffectSlot = nil
  },
  _ui_symbol = {
    stc_symbol = nil,
    stc_symbolHeal = nil,
    stc_symbolDamaged = nil,
    _symbolHeal = {
      [52] = nil,
      [53] = nil,
      [55] = nil,
      [58] = nil,
      [60] = nil,
      [63] = nil
    },
    _symbolDamaged = {
      [52] = nil,
      [53] = nil,
      [55] = nil,
      [58] = nil,
      [60] = nil,
      [63] = nil
    }
  },
  _ui_buff = {
    stc_buffLeftSide = nil,
    stc_buffBG = nil,
    stc_buffIcon = nil,
    stc_debuffRightSide = nil,
    stc_debuffBG = nil,
    stc_debuffIcon = nil,
    stc_buffList = {},
    stc_deBuffList = {}
  },
  _ui_skill = {
    stc_skill = nil,
    stc_basicSkillSlot = nil,
    stc_rClickSkillSlot = nil,
    stc_skillSlot = {},
    stc_skillUpEffect = nil,
    stc_numberBG = nil,
    txt_skillPoint = nil
  },
  _ui_item = {
    stc_item = nil,
    stc_itemSlot = {}
  },
  _ui_equip = {
    stc_equipBG = nil,
    stc_equipTop = nil,
    stc_partsHead = nil,
    stc_head = {},
    stc_partsArmor = nil,
    stc_armor = {},
    stc_partsHands = nil,
    stc_hands = {},
    stc_partsShoes = nil,
    stc_shoes = {},
    stc_accessoryNeck = nil,
    stc_neck = {},
    stc_accessoryBelt = nil,
    stc_belt = {},
    stc_accessoryEaring_1 = nil,
    stc_earing_1 = {},
    stc_accessoryEaring_2 = nil,
    stc_earing_2 = {},
    stc_accessoryRing_1 = nil,
    stc_ring_1 = {},
    stc_accessoryRing_2 = nil,
    stc_ring_2 = {},
    stc_weaponBG = nil,
    txt_weapon = nil,
    stc_weapon = {},
    txt_ap = nil,
    stc_subWeaponBG = nil,
    txt_subweapon = nil,
    stc_subWeapon = {},
    txt_dp = nil
  },
  _value_mainStatus = {
    _damageByOtherPlayer_Time = 0,
    _now_HpBarBurn = false,
    _hpBarBurnTimer = 0,
    _prevHp = -1,
    _prevMaxHP = -1,
    _prevStamina = -1,
    _prevMaxStamina = -1,
    _prevHpAlertTime = 0,
    _simpleUIFadeRate = 1,
    _staticGage_CombatResource = 0,
    _strongMonsterAlert = false,
    _isDamagedEffect = true,
    _effectTime = 2,
    _curEffectTime = 0,
    _spUseType = {
      Once = 0,
      Continue = 1,
      Recover = 2,
      Stop = 3,
      Reset = 4,
      None = 5
    },
    _characterIconUV = {
      path = "shadowarena/basic/sa_character_00.dds",
      [52] = {
        x1 = 343,
        x2 = 458,
        y1 = 465,
        y2 = 580
      },
      [53] = {
        x1 = 343,
        x2 = 458,
        y1 = 349,
        y2 = 464
      },
      [55] = {
        x1 = 343,
        x2 = 458,
        y1 = 117,
        y2 = 232
      },
      [58] = {
        x1 = 343,
        x2 = 458,
        y1 = 1,
        y2 = 116
      },
      [60] = {
        x1 = 343,
        x2 = 458,
        y1 = 233,
        y2 = 348
      },
      [63] = {
        x1 = 343,
        x2 = 458,
        y1 = 581,
        y2 = 696
      }
    },
    _symbolDamagedEffectName = {
      [52] = {
        effectName = "fUI_ShadowArena_Logo_PHM_Hit_01A",
        lifeTime = 0.3
      },
      [53] = {
        effectName = "fUI_ShadowArena_Logo_PKW_Hit_01A",
        lifeTime = 0.3
      },
      [55] = {
        effectName = "fUI_ShadowArena_Logo_PHW_Hit_01A",
        lifeTime = 0.3
      },
      [58] = {
        effectName = "fUI_ShadowArena_Logo_PGM_Hit_01A",
        lifeTime = 0.3
      },
      [60] = {
        effectName = "fUI_ShadowArena_Logo_PNW_Hit_01A",
        lifeTime = 0.3
      },
      [63] = {
        effectName = "fUI_ShadowArena_Logo_PWW_Hit_01A",
        lifeTime = 0.3
      }
    },
    _symbolHealEffectName = {
      [52] = {
        effectName = "fUI_ShadowArena_Logo_PHM_Heal_01A",
        lifeTime = 0.5
      },
      [53] = {
        effectName = "fUI_ShadowArena_Logo_PKW_Heal_01A",
        lifeTime = 0.5
      },
      [55] = {
        effectName = "fUI_ShadowArena_Logo_PHW_Heal_01A",
        lifeTime = 0.5
      },
      [58] = {
        effectName = "fUI_ShadowArena_Logo_PGM_Heal_01A",
        lifeTime = 0.5
      },
      [60] = {
        effectName = "fUI_ShadowArena_Logo_PNW_Heal_01A",
        lifeTime = 0.5
      },
      [63] = {
        effectName = "fUI_ShadowArena_Logo_PWW_Heal_01A",
        lifeTime = 0.5
      }
    }
  },
  _value_equip = {
    _itemGradeCnt = 5,
    _preAp = 0,
    _preDp = 0,
    _itemSlot = {
      [1] = CppEnums.EquipSlotNoClient.eEquipSlotNoRightHand,
      [2] = CppEnums.EquipSlotNoClient.eEquipSlotNoLeftHand,
      [3] = CppEnums.EquipSlotNoClient.eEquipSlotNoChest,
      [4] = CppEnums.EquipSlotNoClient.eEquipSlotNoGlove,
      [5] = CppEnums.EquipSlotNoClient.eEquipSlotNoBoots,
      [6] = CppEnums.EquipSlotNoClient.eEquipSlotNoHelm,
      [7] = CppEnums.EquipSlotNoClient.eEquipSlotNoNecklace,
      [8] = CppEnums.EquipSlotNoClient.eEquipSlotNoRing1,
      [9] = CppEnums.EquipSlotNoClient.eEquipSlotNoRing2,
      [10] = CppEnums.EquipSlotNoClient.eEquipSlotNoEaring1,
      [11] = CppEnums.EquipSlotNoClient.eEquipSlotNoEaring2,
      [12] = CppEnums.EquipSlotNoClient.eEquipSlotNoBelt
    }
  },
  _value_skill = {
    _maxSkillCnt = 4,
    _basicSkillKey = 9,
    _rClickSkillkey = 8,
    slotConfig_Skill = {
      createIcon = true,
      createEffect = true,
      createFG = false,
      createFGDisabled = false,
      createLevel = false,
      createLearnButton = false,
      createCooltime = true,
      createCooltimeText = true,
      template = {effect}
    },
    _skillPoint = 0
  },
  _value_item = {
    _maxItemCnt = 6,
    _curItemCnt = 0,
    _allowType = 2,
    _itemData = {},
    _centerIdx = 3,
    _hpSlotItemKey = 723154,
    _useSkillTypeItem = false,
    _subSlotItemKey = {},
    _skillBookItemKey = 723501,
    slotConfig_Item = {
      createIcon = true,
      createBorder = false,
      createCount = true,
      createCooltime = true,
      createCooltimeText = true,
      createEnchant = true
    }
  },
  _value_buff = {
    _maxBuffCnt = 10,
    _isShow = false,
    _sumCount = 0,
    _buffTooltipIndex = 0,
    _isTooltipDebuff = false,
    _cumulateTime = 0,
    slotPosInfo = {slotGapY = 40}
  },
  _isGameEnd = false,
  _isOpen = true,
  _isUseItem = false,
  _initialize = false
}
runLua("UI_Data/Script/Instance/IngameWidget/SA_Widget_MainFrame_1.lua")
runLua("UI_Data/Script/Instance/IngameWidget/SA_Widget_MainFrame_2.lua")
runLua("UI_Data/Script/Instance/IngameWidget/SA_Widget_MainFrame_3.lua")
runLua("UI_Data/Script/Instance/IngameWidget/SA_Widget_MainFrame_4.lua")
runLua("UI_Data/Script/Instance/IngameWidget/SA_Widget_MainFrame_5.lua")
runLua("UI_Data/Script/Instance/IngameWidget/SA_Widget_MainFrame_6.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_SA_MainFrameInit")
function FromClient_SA_MainFrameInit()
  PaGlobal_SA_MainFrame:initialize()
end
