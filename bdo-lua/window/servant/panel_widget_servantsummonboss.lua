PaGlobal_ServantSummonBoss = {
  _eStack = {
    non = 0,
    stack1 = 1,
    stack2 = 2,
    stack3 = 3,
    loopCount = 3
  },
  _ui = {
    _stc_progressBG = nil,
    _stc_progressBar = nil,
    _stc_commandBG = nil,
    _stc_moveTitle = nil,
    _stc_attackTitle = nil,
    _moveList = {},
    _attackList = {},
    _txt_hp = nil,
    _stc_stackGroup_crio = nil,
    _stc_stackIcon_crio = {},
    _stc_stackGroup_papu = nil,
    _stc_stackIcon_papu = {}
  },
  _bossInfo = {
    [1] = {
      _actorkey = 29880,
      _moveText = {
        [1] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_MOVE_BASIC"),
        [2] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_MOVE_FRONTRUN")
      },
      _attackText = {
        [1] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_ATTACK_BASIC"),
        [2] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_ATTACK_FOOT"),
        [3] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_ATTACK_JUMP"),
        [4] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_ATTACK_RUN"),
        [5] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_ATTACK_STOMACH")
      }
    },
    [2] = {
      _actorkey = 29800,
      _moveText = {
        [1] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_MOVE_BASIC"),
        [2] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_MOVE_FRONTRUN")
      },
      _attackText = {
        [1] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_ATTACK_BASIC"),
        [2] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_ATTACK_FOOT"),
        [3] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_ATTACK_JUMP"),
        [4] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_ATTACK_RUN"),
        [5] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_ATTACK_STOMACH")
      }
    },
    [3] = {
      _actorkey = 29805,
      _moveText = {
        [1] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_MOVE_BASIC"),
        [2] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_MOVE_FRONTRUN"),
        [3] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_MOVE_DASH")
      },
      _attackText = {
        [1] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_ATTACK_BASIC"),
        [2] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_ATTACK_FOOT"),
        [3] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_ATTACK_JUMP"),
        [4] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_ATTACK_RUN"),
        [5] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_ATTACK_PROMPTLY"),
        [6] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_ATTACK_ROAR")
      }
    },
    [4] = {
      _actorkey = 29806,
      _moveText = {
        [1] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_MOVE_BASIC"),
        [2] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_MOVE_FRONTRUN"),
        [3] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_MOVE_BASEATTACK")
      },
      _attackText = {
        [1] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_ATTACK_BASIC"),
        [2] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_ATTACK_DOWNWARD"),
        [3] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_ATTACK_RUN"),
        [4] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_ATTACK_TAPPING_FOOT"),
        [5] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_ATTACK_ROAR")
      }
    },
    [5] = {
      _actorkey = 29819,
      _moveText = {
        [1] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_MOVE_WALKING"),
        [2] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_MOVE_FRONT_RUN"),
        [3] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_MOVE_JUMP")
      },
      _attackText = {
        [1] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_ATTACK_MOUSE_ATTACK1") .. " " .. PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_PAPU_CITIZEN_MOTION_1"),
        [2] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_ATTACK_MOUSE_ATTACK2") .. " " .. PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_PAPU_CITIZEN_MOTION_2"),
        [3] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_ATTACK_KEYBOARD_KICK") .. " " .. PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_PAPU_CITIZEN_MOTION_3"),
        [4] = " ",
        [5] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_RELEASE")
      }
    },
    [6] = {
      _actorkey = 29809,
      _moveText = {
        [1] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_MOVE_WALKING"),
        [2] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_MOVE_FRONT_RUN"),
        [3] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_MOVE_JUMP")
      },
      _attackText = {
        [1] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_ATTACK_DESC"),
        [2] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_ATTACK_MOUSE_ATTACK1") .. " " .. PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_PAPU_MAGICSWORD_ATTACK_1"),
        [3] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_ATTACK_MOUSE_ATTACK2") .. " " .. PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_PAPU_MAGICSWORD_ATTACK_2"),
        [4] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_ATTACK_KEYBOARD_KICK") .. " " .. PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_PAPU_MAGICSWORD_ATTACK_3"),
        [5] = " ",
        [6] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_RELEASE")
      }
    },
    [7] = {
      _actorkey = 29810,
      _moveText = {
        [1] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_MOVE_WALKING"),
        [2] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_MOVE_FRONT_RUN"),
        [3] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_MOVE_JUMP")
      },
      _attackText = {
        [1] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_ATTACK_DESC"),
        [2] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_ATTACK_MOUSE_ATTACK1") .. " " .. PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_PAPU_CRUSADER_ATTACK_1"),
        [3] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_ATTACK_MOUSE_ATTACK2") .. " " .. PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_PAPU_CRUSADER_ATTACK_2"),
        [4] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_ATTACK_KEYBOARD_KICK") .. " " .. PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_PAPU_CRUSADER_ATTACK_3"),
        [5] = " ",
        [6] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_RELEASE")
      }
    },
    [8] = {
      _actorkey = 29811,
      _moveText = {
        [1] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_MOVE_WALKING"),
        [2] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_MOVE_FRONT_RUN"),
        [3] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_MOVE_JUMP")
      },
      _attackText = {
        [1] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_ATTACK_DESC"),
        [2] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_ATTACK_MOUSE_ATTACK1") .. " " .. PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_PAPU_PRIEST_ATTACK_1"),
        [3] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_ATTACK_MOUSE_ATTACK2") .. " " .. PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_PAPU_PRIEST_ATTACK_2"),
        [4] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_ATTACK_KEYBOARD_KICK") .. " " .. PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_PAPU_PRIEST_ATTACK_3"),
        [5] = " ",
        [6] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_RELEASE")
      }
    },
    [9] = {
      _actorkey = 29812,
      _moveText = {
        [1] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_MOVE_WALKING"),
        [2] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_MOVE_FRONT_RUN"),
        [3] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_MOVE_JUMP")
      },
      _attackText = {
        [1] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_ATTACK_DESC"),
        [2] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_ATTACK_MOUSE_ATTACK1") .. " " .. PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_PAPU_MAGICIAN_ATTACK_1"),
        [3] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_ATTACK_MOUSE_ATTACK2") .. " " .. PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_PAPU_MAGICIAN_ATTACK_2"),
        [4] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_ATTACK_KEYBOARD_KICK") .. " " .. PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_PAPU_MAGICIAN_ATTACK_3"),
        [5] = " ",
        [6] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_RELEASE")
      }
    },
    [10] = {
      _actorkey = 29813,
      _moveText = {
        [1] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_MOVE_WALKING"),
        [2] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_MOVE_FRONT_RUN"),
        [3] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_MOVE_JUMP")
      },
      _attackText = {
        [1] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_ATTACK_DESC"),
        [2] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_ATTACK_MOUSE_ATTACK1") .. " " .. PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_PAPU_ARCHER_ATTACK_1"),
        [3] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_ATTACK_MOUSE_ATTACK2") .. " " .. PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_PAPU_ARCHER_ATTACK_2"),
        [4] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_ATTACK_KEYBOARD_KICK") .. " " .. PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_PAPU_ARCHER_ATTACK_3"),
        [5] = " ",
        [6] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_RELEASE")
      }
    },
    [11] = {
      _actorkey = 29820,
      _moveText = {
        [1] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_MOVE_WALKING"),
        [2] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_MOVE_FRONT_RUN"),
        [3] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_MOVE_JUMP")
      },
      _attackText = {
        [1] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_ATTACK_MOUSE_ATTACK1") .. " " .. PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_PAPU_CITIZEN_MOTION_1"),
        [2] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_ATTACK_MOUSE_ATTACK2") .. " " .. PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_PAPU_CITIZEN_MOTION_2"),
        [3] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_ATTACK_KEYBOARD_KICK") .. " " .. PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_CRIO_CITIZEN_MOTION_3"),
        [4] = " ",
        [5] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_RELEASE")
      }
    },
    [12] = {
      _actorkey = 29814,
      _moveText = {
        [1] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_MOVE_WALKING"),
        [2] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_MOVE_FRONT_RUN"),
        [3] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_MOVE_JUMP")
      },
      _attackText = {
        [1] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_ATTACK_DESC"),
        [2] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_ATTACK_MOUSE_ATTACK1") .. " " .. PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_CRIO_MAGICSWORD_ATTACK_1"),
        [3] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_ATTACK_MOUSE_ATTACK2") .. " " .. PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_CRIO_MAGICSWORD_ATTACK_2"),
        [4] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_ATTACK_KEYBOARD_KICK") .. " " .. PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_PAPU_MAGICSWORD_ATTACK_3"),
        [5] = " ",
        [6] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_RELEASE")
      }
    },
    [13] = {
      _actorkey = 29815,
      _moveText = {
        [1] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_MOVE_WALKING"),
        [2] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_MOVE_FRONT_RUN"),
        [3] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_MOVE_JUMP")
      },
      _attackText = {
        [1] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_ATTACK_DESC"),
        [2] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_ATTACK_MOUSE_ATTACK1") .. " " .. PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_PAPU_CRUSADER_ATTACK_1"),
        [3] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_ATTACK_MOUSE_ATTACK2") .. " " .. PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_PAPU_CRUSADER_ATTACK_2"),
        [4] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_ATTACK_KEYBOARD_KICK") .. " " .. PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_PAPU_CRUSADER_ATTACK_3"),
        [5] = " ",
        [6] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_RELEASE")
      }
    },
    [14] = {
      _actorkey = 29817,
      _moveText = {
        [1] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_MOVE_WALKING"),
        [2] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_MOVE_FRONT_RUN"),
        [3] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_MOVE_JUMP")
      },
      _attackText = {
        [1] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_ATTACK_DESC"),
        [2] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_ATTACK_MOUSE_ATTACK1") .. " " .. PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_PAPU_PRIEST_ATTACK_1"),
        [3] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_ATTACK_MOUSE_ATTACK2") .. " " .. PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_PAPU_PRIEST_ATTACK_2"),
        [4] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_ATTACK_KEYBOARD_KICK") .. " " .. PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_PAPU_PRIEST_ATTACK_3"),
        [5] = " ",
        [6] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_RELEASE")
      }
    },
    [15] = {
      _actorkey = 29816,
      _moveText = {
        [1] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_MOVE_WALKING"),
        [2] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_MOVE_FRONT_RUN"),
        [3] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_MOVE_JUMP")
      },
      _attackText = {
        [1] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_ATTACK_DESC"),
        [2] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_ATTACK_MOUSE_ATTACK1") .. " " .. PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_CRIO_MAGICIAN_ATTACK_1"),
        [3] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_ATTACK_MOUSE_ATTACK2") .. " " .. PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_CRIO_MAGICIAN_ATTACK_2"),
        [4] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_ATTACK_KEYBOARD_KICK") .. " " .. PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_CRIO_MAGICIAN_ATTACK_3"),
        [5] = " ",
        [6] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_RELEASE")
      }
    },
    [16] = {
      _actorkey = 29818,
      _moveText = {
        [1] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_MOVE_WALKING"),
        [2] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_MOVE_FRONT_RUN"),
        [3] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_MOVE_JUMP")
      },
      _attackText = {
        [1] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_ATTACK_DESC"),
        [2] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_ATTACK_MOUSE_ATTACK1") .. " " .. PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_CRIO_FIGHTER_ATTACK_1"),
        [3] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_ATTACK_MOUSE_ATTACK2") .. " " .. PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_CRIO_FIGHTER_ATTACK_2"),
        [4] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_ATTACK_KEYBOARD_KICK") .. " " .. PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_PAPU_MAGICSWORD_ATTACK_3"),
        [5] = " ",
        [6] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_RELEASE")
      }
    },
    [17] = {
      _actorkey = 29951,
      _moveText = {
        [1] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_MOVE_BASIC"),
        [2] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_MOVE_FRONTRUN"),
        [3] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_MOVE_DASH")
      },
      _attackText = {
        [1] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_ATTACK_BASIC"),
        [2] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_ATTACK_FOOT"),
        [3] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_ATTACK_JUMP"),
        [4] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_ATTACK_RUN"),
        [5] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_ATTACK_PROMPTLY"),
        [6] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_ATTACK_ROAR")
      }
    },
    [18] = {
      _actorkey = 29952,
      _moveText = {
        [1] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_MOVE_BASIC"),
        [2] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_MOVE_FRONTRUN"),
        [3] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_MOVE_BASEATTACK")
      },
      _attackText = {
        [1] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_ATTACK_BASIC"),
        [2] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_ATTACK_DOWNWARD"),
        [3] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_ATTACK_RUN"),
        [4] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_ATTACK_TAPPING_FOOT"),
        [5] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_ATTACK_ROAR")
      }
    },
    [19] = {
      _actorkey = 29901,
      _moveText = {
        [1] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_MOVE_WALKING"),
        [2] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_RELEASE2")
      },
      _attackText = {}
    }
  },
  _motionTitleMonsterKey = {
    [1] = 29819,
    [2] = 29820
  },
  _MAX_MOVE_COUNT = 3,
  _MAX_ATTACK_COUNT = 6,
  _attackTitleStr = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SERVANTSUMMONBOSS_COMMAND_ATTACK_TITLE"),
  _motionTitleStr = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_MOTION_TITLE"),
  _crio_disable = {
    x1 = 103,
    y1 = 60,
    x2 = 130,
    y2 = 87
  },
  _crio_active = {
    x1 = 131,
    y1 = 60,
    x2 = 158,
    y2 = 87
  },
  _papu_disable = {
    x1 = 47,
    y1 = 60,
    x2 = 74,
    y2 = 87
  },
  _papu_active = {
    x1 = 75,
    y1 = 60,
    x2 = 102,
    y2 = 87
  },
  _isShowSkillCommand = false,
  _initialize = false
}
runLua("UI_Data/Script/Window/Servant/Panel_Widget_ServantSummonBoss_1.lua")
runLua("UI_Data/Script/Window/Servant/Panel_Widget_ServantSummonBoss_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_PaGlobal_ServantSummonBossInit")
function FromClient_PaGlobal_ServantSummonBossInit()
  PaGlobal_ServantSummonBoss:initialize()
end
