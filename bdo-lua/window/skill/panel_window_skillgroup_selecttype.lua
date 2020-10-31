PaGlobal_SkillGroup_SelectType = {
  _panel = nil,
  _ui = {
    _stc_centerMainArea = nil,
    _stc_bottomBG = nil,
    _stc_bottomSkillArea = nil,
    _stc_bottomSkillAreaBg = nil,
    _stc_bigCharacter = nil,
    _stc_skillTypeTop = nil,
    _stc_skillTypeBottom = nil,
    _txt_title = nil,
    _txt_desc = nil,
    _stc_skillTypeLine = nil,
    _stc_horizonLineTop = nil,
    _stc_horizonLineBottom = nil,
    _stc_combatTypeTitle = nil,
    _stc_Dot1 = nil,
    _stc_Dot2 = nil,
    _txt_weaponTypeTitle = nil,
    _txt_weaponTypeValue = nil,
    _txt_combatTypeTitle = nil,
    _txt_combatTypeValue = nil,
    _stc_skillSlotBg = nil,
    _stc_skillSlot = nil,
    _txt_skillName = nil,
    _txt_skillPoint = nil,
    _btn_confirm = nil,
    _btn_cancel = nil,
    _stc_centerMainArea = nil,
    _txt_learnSkill = nil
  },
  _texturePath = "Combine/Etc/Combine_Etc_Skill_00.dds",
  _originBottomAreaPosY = 0,
  _originBottomBgPosY = 0,
  _originCenterMainAreaSizeY = 0,
  _treeTypeDataList = {
    [__eSkillTypeParam_Awaken] = {
      _uv = {
        x1 = 518,
        y1 = 212,
        x2 = 599,
        y2 = 422
      },
      _title = "PANEL_STABLESTALLION_AWAKEN",
      _titleSub = "AWAKEN",
      _weaponType = "LUA_SKILL_AWAKEN_WEAPON_NAME"
    },
    [__eSkillTypeParam_Inherit] = {
      _uv = {
        x1 = 518,
        y1 = 1,
        x2 = 599,
        y2 = 211
      },
      _title = "PANEL_SKILL_SUCCESSTIONSKILL_TAB_NAME",
      _titleSub = "SUCCESSION",
      _weaponType = "LUA_SKILL_SUCCESSION_WEAPON_NAME"
    }
  },
  _classDataList = {
    [__eClassType_Warrior] = {
      [__eSkillTypeParam_Awaken] = {
        _texture = "Combine/Etc/Combine_Etc_Skill_Awaken_Warrior.dds",
        _weaponType = "LUA_WARRIOR_AWAKEN_WEAPON_TYPE",
        _combatType = "LUA_WARRIOR_AWAKEN_COMBAT_TYPE",
        _desc = "LUA_WARRIOR_AWAKEN_DESC"
      },
      [__eSkillTypeParam_Inherit] = {
        _texture = "Combine/Etc/Combine_Etc_Skill_Succesion_Warrior.dds",
        _weaponType = "LUA_WARRIOR_SUCCESSION_WEAPON_TYPE",
        _combatType = "LUA_WARRIOR_SUCCESSION_COMBAT_TYPE",
        _desc = "LUA_WARRIOR_SUCCESSION_DESC"
      }
    },
    [__eClassType_Hashashin] = {
      [__eSkillTypeParam_Awaken] = {
        _texture = "Combine/Etc/Combine_Etc_Skill_Awaken_Hashashin.dds",
        _weaponType = "LUA_HASHASHIN_AWAKEN_WEAPON_TYPE",
        _combatType = "LUA_HASHASHIN_AWAKEN_COMBAT_TYPE",
        _desc = "LUA_HASHASHIN_AWAKEN_DESC"
      },
      [__eSkillTypeParam_Inherit] = {
        _texture = "Combine/Etc/Combine_Etc_Skill_Succesion_Hashashin.dds",
        _weaponType = "LUA_HASHASHIN_SUCCESSION_WEAPON_TYPE",
        _combatType = "LUA_HASHASHIN_SUCCESSION_COMBAT_TYPE",
        _desc = "LUA_HASHASHIN_SUCCESSION_DESC"
      }
    },
    [2] = {
      [__eSkillTypeParam_Awaken] = {
        _texture = "Combine/Etc/Combine_Etc_Skill_Awaken_Striker.dds",
        _weaponType = "LUA_WARRIOR_AWAKEN_WEAPON_TYPE",
        _combatType = "LUA_WARRIOR_AWAKEN_COMBAT_TYPE",
        _desc = "LUA_WARRIOR_AWAKEN_DESC"
      },
      [__eSkillTypeParam_Inherit] = {
        _texture = "Combine/Etc/Combine_Etc_Skill_Succesion_Striker.dds",
        _weaponType = "LUA_WARRIOR_SUCCESSION_WEAPON_TYPE",
        _combatType = "LUA_WARRIOR_SUCCESSION_COMBAT_TYPE",
        _desc = "LUA_WARRIOR_SUCCESSION_DESC"
      }
    },
    [__eClassType_ElfRanger] = {
      [__eSkillTypeParam_Awaken] = {
        _texture = "Combine/Etc/Combine_Etc_Skill_Awaken_Ranger.dds",
        _weaponType = "LUA_RANGER_AWAKEN_WEAPON_TYPE",
        _combatType = "LUA_RANGER_AWAKEN_COMBAT_TYPE",
        _desc = "LUA_RANGER_AWAKEN_DESC"
      },
      [__eSkillTypeParam_Inherit] = {
        _texture = "Combine/Etc/Combine_Etc_Skill_Succesion_Ranger.dds",
        _weaponType = "LUA_RANGER_SUCCESSION_WEAPON_TYPE",
        _combatType = "LUA_RANGER_SUCCESSION_COMBAT_TYPE",
        _desc = "LUA_RANGER_SUCCESSION_DESC"
      }
    },
    [__eClassType_Sorcerer] = {
      [__eSkillTypeParam_Awaken] = {
        _texture = "Combine/Etc/Combine_Etc_Skill_Awaken_Sorceress.dds",
        _weaponType = "LUA_SORCERER_AWAKEN_WEAPON_TYPE",
        _combatType = "LUA_SORCERER_AWAKEN_COMBAT_TYPE",
        _desc = "LUA_SORCERER_AWAKEN_DESC"
      },
      [__eSkillTypeParam_Inherit] = {
        _texture = "Combine/Etc/Combine_Etc_Skill_Succesion_Sorceress.dds",
        _weaponType = "LUA_SORCERER_SUCCESSION_WEAPON_TYPE",
        _combatType = "LUA_SORCERER_SUCCESSION_COMBAT_TYPE",
        _desc = "LUA_SORCERER_SUCCESSION_DESC"
      }
    },
    [__eClassType_Sorcerer_Reserved1] = {
      [__eSkillTypeParam_Awaken] = {
        _texture = "Combine/Etc/Combine_Etc_Skill_Awaken_Sorceress.dds",
        _weaponType = "LUA_SORCERER_AWAKEN_WEAPON_TYPE",
        _combatType = "LUA_SORCERER_AWAKEN_COMBAT_TYPE",
        _desc = "LUA_SORCERER_AWAKEN_DESC"
      },
      [__eSkillTypeParam_Inherit] = {
        _texture = "Combine/Etc/Combine_Etc_Skill_Succesion_Sorceress.dds",
        _weaponType = "LUA_SORCERER_SUCCESSION_WEAPON_TYPE",
        _combatType = "LUA_SORCERER_SUCCESSION_COMBAT_TYPE",
        _desc = "LUA_SORCERER_SUCCESSION_DESC"
      }
    },
    [__eClassType_Lhan] = {
      [__eSkillTypeParam_Awaken] = {
        _texture = "Combine/Etc/Combine_Etc_Skill_Awaken_Lahn.dds",
        _weaponType = "LUA_LHAN_AWAKEN_WEAPON_TYPE",
        _combatType = "LUA_LHAN_AWAKEN_COMBAT_TYPE",
        _desc = "LUA_LHAN_AWAKEN_DESC"
      },
      [__eSkillTypeParam_Inherit] = {
        _texture = "Combine/Etc/Combine_Etc_Skill_Succesion_Lahn.dds",
        _weaponType = "LUA_LHAN_SUCCESSION_WEAPON_TYPE",
        _combatType = "LUA_LHAN_SUCCESSION_COMBAT_TYPE",
        _desc = "LUA_LHAN_SUCCESSION_DESC"
      }
    },
    [__eClassType_Giant] = {
      [__eSkillTypeParam_Awaken] = {
        _texture = "Combine/Etc/Combine_Etc_Skill_Awaken_Berserker.dds",
        _weaponType = "LUA_GIANT_AWAKEN_WEAPON_TYPE",
        _combatType = "LUA_GIANT_AWAKEN_COMBAT_TYPE",
        _desc = "LUA_GIANT_AWAKEN_DESC"
      },
      [__eSkillTypeParam_Inherit] = {
        _texture = "Combine/Etc/Combine_Etc_Skill_Succesion_Berserker.dds",
        _weaponType = "LUA_GIANT_SUCCESSION_WEAPON_TYPE",
        _combatType = "LUA_GIANT_SUCCESSION_COMBAT_TYPE",
        _desc = "LUA_GIANT_SUCCESSION_DESC"
      }
    },
    [__eClassType_Tamer] = {
      [__eSkillTypeParam_Awaken] = {
        _texture = "Combine/Etc/Combine_Etc_Skill_Awaken_Tamer.dds",
        _weaponType = "LUA_TAMER_AWAKEN_WEAPON_TYPE",
        _combatType = "LUA_TAMER_AWAKEN_COMBAT_TYPE",
        _desc = "LUA_TAMER_AWAKEN_DESC"
      },
      [__eSkillTypeParam_Inherit] = {
        _texture = "Combine/Etc/Combine_Etc_Skill_Succesion_Tamer.dds",
        _weaponType = "LUA_TAMER_SUCCESSION_WEAPON_TYPE",
        _combatType = "LUA_TAMER_SUCCESSION_COMBAT_TYPE",
        _desc = "LUA_TAMER_SUCCESSION_DESC"
      }
    },
    [__eClassType_ShyWaman] = {
      [__eSkillTypeParam_Awaken] = {
        _texture = "Combine/Etc/Combine_Etc_Skill_Awaken_Shai.dds",
        _weaponType = "LUA_SHAI_AWAKEN_WEAPON_TYPE",
        _combatType = "LUA_SHAI_AWAKEN_COMBAT_TYPE",
        _desc = "LUA_SHAI_AWAKEN_DESC"
      },
      [__eSkillTypeParam_Inherit] = {
        _texture = "Combine/Etc/Combine_Etc_Skill_Succesion_Shai.dds",
        _weaponType = "LUA_SHAI_SUCCESSION_WEAPON_TYPE",
        _combatType = "LUA_SHAI_SUCCESSION_COMBAT_TYPE",
        _desc = "LUA_SHAI_SUCCESSION_DESC"
      }
    },
    [__eClassType_ShyMan] = {
      [__eSkillTypeParam_Awaken] = {
        _texture = "Combine/Etc/Combine_Etc_Skill_Awaken_Shai.dds",
        _weaponType = "LUA_SHAI_AWAKEN_WEAPON_TYPE",
        _combatType = "LUA_SHAI_AWAKEN_COMBAT_TYPE",
        _desc = "LUA_SHAI_AWAKEN_DESC"
      },
      [__eSkillTypeParam_Inherit] = {
        _texture = "Combine/Etc/Combine_Etc_Skill_Succesion_Shai.dds",
        _weaponType = "LUA_SHAI_SUCCESSION_WEAPON_TYPE",
        _combatType = "LUA_SHAI_SUCCESSION_COMBAT_TYPE",
        _desc = "LUA_SHAI_SUCCESSION_DESC"
      }
    },
    [__eClassType_Combattant] = {
      [__eSkillTypeParam_Awaken] = {
        _texture = "Combine/Etc/Combine_Etc_Skill_Awaken_Striker.dds",
        _weaponType = "LUA_COMBATTANT_AWAKEN_WEAPON_TYPE",
        _combatType = "LUA_COMBATTANT_AWAKEN_COMBAT_TYPE",
        _desc = "LUA_COMBATTANT_AWAKEN_DESC"
      },
      [__eSkillTypeParam_Inherit] = {
        _texture = "Combine/Etc/Combine_Etc_Skill_Succesion_Striker.dds",
        _weaponType = "LUA_COMBATTANT_SUCCESSION_WEAPON_TYPE",
        _combatType = "LUA_COMBATTANT_SUCCESSION_COMBAT_TYPE",
        _desc = "LUA_COMBATTANT_SUCCESSION_DESC"
      }
    },
    [__eClassType_BladeMaster] = {
      [__eSkillTypeParam_Awaken] = {
        _texture = "Combine/Etc/Combine_Etc_Skill_Awaken_Musa.dds",
        _weaponType = "LUA_MUSA_AWAKEN_WEAPON_TYPE",
        _combatType = "LUA_MUSA_AWAKEN_COMBAT_TYPE",
        _desc = "LUA_MUSA_AWAKEN_DESC"
      },
      [__eSkillTypeParam_Inherit] = {
        _texture = "Combine/Etc/Combine_Etc_Skill_Succesion_Musa.dds",
        _weaponType = "LUA_MUSA_SUCCESSION_WEAPON_TYPE",
        _combatType = "LUA_MUSA_SUCCESSION_COMBAT_TYPE",
        _desc = "LUA_MUSA_SUCCESSION_DESC"
      }
    },
    [__eClassType_BladeMasterWoman] = {
      [__eSkillTypeParam_Awaken] = {
        _texture = "Combine/Etc/Combine_Etc_Skill_Awaken_Maewha.dds",
        _weaponType = "LUA_MAEWHA_AWAKEN_WEAPON_TYPE",
        _combatType = "LUA_MAEWHA_AWAKEN_COMBAT_TYPE",
        _desc = "LUA_MAEWHA_AWAKEN_DESC"
      },
      [__eSkillTypeParam_Inherit] = {
        _texture = "Combine/Etc/Combine_Etc_Skill_Succesion_Maewha.dds",
        _weaponType = "LUA_MAEWHA_SUCCESSION_WEAPON_TYPE",
        _combatType = "LUA_MAEWHA_SUCCESSION_COMBAT_TYPE",
        _desc = "LUA_MAEWHA_SUCCESSION_DESC"
      }
    },
    [__eClassType_BladeMaster_Reserved1] = {
      [__eSkillTypeParam_Awaken] = {
        _texture = "Combine/Etc/Combine_Etc_Skill_Awaken_Maewha.dds",
        _weaponType = "LUA_MAEWHA_AWAKEN_WEAPON_TYPE",
        _combatType = "LUA_MAEWHA_AWAKEN_COMBAT_TYPE",
        _desc = "LUA_MAEWHA_AWAKEN_DESC"
      },
      [__eSkillTypeParam_Inherit] = {
        _texture = "Combine/Etc/Combine_Etc_Skill_Succesion_Maewha.dds",
        _weaponType = "LUA_MAEWHA_SUCCESSION_WEAPON_TYPE",
        _combatType = "LUA_MAEWHA_SUCCESSION_COMBAT_TYPE",
        _desc = "LUA_MAEWHA_SUCCESSION_DESC"
      }
    },
    [__eClassType_Mystic] = {
      [__eSkillTypeParam_Awaken] = {
        _texture = "Combine/Etc/Combine_Etc_Skill_Awaken_Mystic.dds",
        _weaponType = "LUA_MYSTIC_AWAKEN_WEAPON_TYPE",
        _combatType = "LUA_MYSTIC_AWAKEN_COMBAT_TYPE",
        _desc = "LUA_MYSTIC_AWAKEN_DESC"
      },
      [__eSkillTypeParam_Inherit] = {
        _texture = "Combine/Etc/Combine_Etc_Skill_Succesion_Mystic.dds",
        _weaponType = "LUA_MYSTIC_SUCCESSION_WEAPON_TYPE",
        _combatType = "LUA_MYSTIC_SUCCESSION_COMBAT_TYPE",
        _desc = "LUA_MYSTIC_SUCCESSION_DESC"
      }
    },
    [__eClassType_Valkyrie] = {
      [__eSkillTypeParam_Awaken] = {
        _texture = "Combine/Etc/Combine_Etc_Skill_Awaken_Valkyrie.dds",
        _weaponType = "LUA_VALKYRIE_AWAKEN_WEAPON_TYPE",
        _combatType = "LUA_VALKYRIE_AWAKEN_COMBAT_TYPE",
        _desc = "LUA_VALKYRIE_AWAKEN_DESC"
      },
      [__eSkillTypeParam_Inherit] = {
        _texture = "Combine/Etc/Combine_Etc_Skill_Succesion_Valkyrie.dds",
        _weaponType = "LUA_VALKYRIE_SUCCESSION_WEAPON_TYPE",
        _combatType = "LUA_VALKYRIE_SUCCESSION_COMBAT_TYPE",
        _desc = "LUA_VALKYRIE_SUCCESSION_DESC"
      }
    },
    [__eClassType_Kunoichi] = {
      [__eSkillTypeParam_Awaken] = {
        _texture = "Combine/Etc/Combine_Etc_Skill_Awaken_Kunoichi.dds",
        _weaponType = "LUA_KUNOICHI_AWAKEN_WEAPON_TYPE",
        _combatType = "LUA_KUNOICHI_AWAKEN_COMBAT_TYPE",
        _desc = "LUA_KUNOICHI_AWAKEN_DESC"
      },
      [__eSkillTypeParam_Inherit] = {
        _texture = "Combine/Etc/Combine_Etc_Skill_Succesion_Kunoichi.dds",
        _weaponType = "LUA_KUNOICHI_SUCCESSION_WEAPON_TYPE",
        _combatType = "LUA_KUNOICHI_SUCCESSION_COMBAT_TYPE",
        _desc = "LUA_KUNOICHI_SUCCESSION_DESC"
      }
    },
    [__eClassType_NinjaMan] = {
      [__eSkillTypeParam_Awaken] = {
        _texture = "Combine/Etc/Combine_Etc_Skill_Awaken_Ninja.dds",
        _weaponType = "LUA_NINJA_AWAKEN_WEAPON_TYPE",
        _combatType = "LUA_NINJA_AWAKEN_COMBAT_TYPE",
        _desc = "LUA_NINJA_AWAKEN_DESC"
      },
      [__eSkillTypeParam_Inherit] = {
        _texture = "Combine/Etc/Combine_Etc_Skill_Succesion_Ninja.dds",
        _weaponType = "LUA_NINJA_SUCCESSION_WEAPON_TYPE",
        _combatType = "LUA_NINJA_SUCCESSION_COMBAT_TYPE",
        _desc = "LUA_NINJA_SUCCESSION_DESC"
      }
    },
    [__eClassType_DarkElf] = {
      [__eSkillTypeParam_Awaken] = {
        _texture = "Combine/Etc/Combine_Etc_Skill_Awaken_DK.dds",
        _weaponType = "LUA_DARKKNIGHT_AWAKEN_WEAPON_TYPE",
        _combatType = "LUA_DARKKNIGHT_AWAKEN_COMBAT_TYPE",
        _desc = "LUA_DARKKNIGHT_AWAKEN_DESC"
      },
      [__eSkillTypeParam_Inherit] = {
        _texture = "Combine/Etc/Combine_Etc_Skill_Succesion_DK.dds",
        _weaponType = "LUA_DARKKNIGHT_SUCCESSION_WEAPON_TYPE",
        _combatType = "LUA_DARKKNIGHT_SUCCESSION_COMBAT_TYPE",
        _desc = "LUA_DARKKNIGHT_SUCCESSION_DESC"
      }
    },
    [__eClassType_WizardMan] = {
      [__eSkillTypeParam_Awaken] = {
        _texture = "Combine/Etc/Combine_Etc_Skill_Awaken_Wizard.dds",
        _weaponType = "LUA_WIZARD_AWAKEN_WEAPON_TYPE",
        _combatType = "LUA_WIZARD_AWAKEN_COMBAT_TYPE",
        _desc = "LUA_WIZARD_AWAKEN_DESC"
      },
      [__eSkillTypeParam_Inherit] = {
        _texture = "Combine/Etc/Combine_Etc_Skill_Succesion_Wizard.dds",
        _weaponType = "LUA_WIZARD_SUCCESSION_WEAPON_TYPE",
        _combatType = "LUA_WIZARD_SUCCESSION_COMBAT_TYPE",
        _desc = "LUA_WIZARD_SUCCESSION_DESC"
      }
    },
    [__eClassType_KunoichiOld] = {
      [__eSkillTypeParam_Awaken] = {
        _texture = "Combine/Etc/Combine_Etc_Skill_Awaken_Kunoichi.dds",
        _weaponType = "LUA_KUNOICHI_AWAKEN_WEAPON_TYPE",
        _combatType = "LUA_KUNOICHI_AWAKEN_COMBAT_TYPE",
        _desc = "LUA_KUNOICHI_AWAKEN_DESC"
      },
      [__eSkillTypeParam_Inherit] = {
        _texture = "Combine/Etc/Combine_Etc_Skill_Succesion_Kunoichi.dds",
        _weaponType = "LUA_KUNOICHI_SUCCESSION_WEAPON_TYPE",
        _combatType = "LUA_KUNOICHI_SUCCESSION_COMBAT_TYPE",
        _desc = "LUA_KUNOICHI_SUCCESSION_DESC"
      }
    },
    [__eClassType_WizardWoman] = {
      [__eSkillTypeParam_Awaken] = {
        _texture = "Combine/Etc/Combine_Etc_Skill_Awaken_Witch.dds",
        _weaponType = "LUA_WITCH_AWAKEN_WEAPON_TYPE",
        _combatType = "LUA_WITCH_AWAKEN_COMBAT_TYPE",
        _desc = "LUA_WITCH_AWAKEN_DESC"
      },
      [__eSkillTypeParam_Inherit] = {
        _texture = "Combine/Etc/Combine_Etc_Skill_Succesion_Witch.dds",
        _weaponType = "LUA_WITCH_SUCCESSION_WEAPON_TYPE",
        _combatType = "LUA_WITCH_SUCCESSION_COMBAT_TYPE",
        _desc = "LUA_WITCH_SUCCESSION_DESC"
      }
    },
    [__eClassType_RangerMan] = {
      [__eSkillTypeParam_Awaken] = {
        _texture = "Combine/Etc/Combine_Etc_Skill_Awaken_Archer.dds",
        _weaponType = "LUA_ARCHER_AWAKEN_WEAPON_TYPE",
        _combatType = "LUA_ARCHER_AWAKEN_COMBAT_TYPE",
        _desc = "LUA_ARCHER_AWAKEN_DESC"
      },
      [__eSkillTypeParam_Inherit] = {
        _texture = "Combine/Etc/Combine_Etc_Skill_Succesion_Archer.dds",
        _weaponType = "LUA_ARCHER_SUCCESSION_WEAPON_TYPE",
        _combatType = "LUA_ARCHER_SUCCESSION_COMBAT_TYPE",
        _desc = "LUA_ARCHER_SUCCESSION_DESC"
      }
    },
    [__eClassType_Guardian] = {
      [__eSkillTypeParam_Awaken] = {
        _texture = "Combine/Etc/Combine_Etc_Skill_Awaken_Guardian.dds",
        _weaponType = "LUA_GUARDIAN_AWAKEN_WEAPON_TYPE",
        _combatType = "LUA_GUARDIAN_AWAKEN_COMBAT_TYPE",
        _desc = "LUA_GUARDIAN_AWAKEN_DESC"
      },
      [__eSkillTypeParam_Inherit] = {
        _texture = "Combine/Etc/Combine_Etc_Skill_Succesion_Guardian.dds",
        _weaponType = "LUA_GUARDIAN_SUCCESSION_WEAPON_TYPE",
        _combatType = "LUA_GUARDIAN_SUCCESSION_COMBAT_TYPE",
        _desc = "LUA_GUARDIAN_SUCCESSION_DESC"
      }
    },
    [__eClassType_Count] = {
      [__eSkillTypeParam_Awaken] = {
        _texture = "Combine/Etc/Combine_Etc_Skill_Awaken_Striker.dds",
        _weaponType = "LUA_WARRIOR_AWAKEN_WEAPON_TYPE",
        _combatType = "LUA_WARRIOR_AWAKEN_COMBAT_TYPE",
        _desc = "LUA_WARRIOR_AWAKEN_DESC"
      },
      [__eSkillTypeParam_Inherit] = {
        _texture = "Combine/Etc/Combine_Etc_Skill_Succesion_Striker.dds",
        _weaponType = "LUA_WARRIOR_SUCCESSION_WEAPON_TYPE",
        _combatType = "LUA_WARRIOR_SUCCESSION_COMBAT_TYPE",
        _desc = "LUA_WARRIOR_SUCCESSION_DESC"
      }
    }
  }
}
runLua("UI_Data/Script/Window/Skill/Panel_Window_SkillGroup_SelectType_1.lua")
runLua("UI_Data/Script/Window/Skill/Panel_Window_SkillGroup_SelectType_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_SkillGroupSelectTypeInit")
function FromClient_SkillGroupSelectTypeInit()
  PaGlobal_SkillGroup_SelectType:init()
end
