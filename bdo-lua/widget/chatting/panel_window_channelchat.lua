PaGlobal_ChannelChat = {
  _ui = {
    stc_title = nil,
    stc_bg = nil,
    btn_title = {},
    stc_title = {},
    stc_desc = {},
    btn_radio = {},
    btn_bg = {},
    scrol_list = nil,
    btn_scrolUp = nil,
    btn_scrolDown = nil,
    btn_ScrolCtrl = nil,
    stc_bottomDescBG = nil,
    stc_txt_bottomDesc = nil
  },
  _ui_pc = {
    btn_close = nil,
    btn_confirm = nil,
    btn_exit = nil,
    btn_cancel = nil
  },
  _ui_console = {
    stc_bottomBg = nil,
    stc_TextA = nil,
    stc_TextA2 = nil,
    stc_TextB = nil
  },
  _config = {_slotCount = 3, _slotCols = 2},
  _bg_UV = {
    LUA_CHANNELCHAT_ROOM_DESC_01 = {
      x1 = 0,
      y1 = 0,
      x2 = 520,
      y2 = 110
    },
    LUA_CHANNELCHAT_ROOM_DESC_02 = {
      x1 = 0,
      y1 = 111,
      x2 = 520,
      y2 = 221
    },
    LUA_CHANNELCHAT_ROOM_DESC_03 = {
      x1 = 0,
      y1 = 222,
      x2 = 520,
      y2 = 332
    },
    LUA_CHANNELCHAT_ROOM_DESC_04 = {
      x1 = 0,
      y1 = 333,
      x2 = 520,
      y2 = 443
    },
    LUA_CHANNELCHAT_ROOM_DESC_05 = {
      x1 = 0,
      y1 = 444,
      x2 = 520,
      y2 = 554
    },
    LUA_CHANNELCHAT_ROOM_DESC_06 = {
      x1 = 0,
      y1 = 555,
      x2 = 520,
      y2 = 665
    },
    LUA_CHANNELCHAT_ROOM_DESC_07 = {
      x1 = 521,
      y1 = 0,
      x2 = 1041,
      y2 = 110
    },
    LUA_CHANNELCHAT_ROOM_DESC_08 = {
      x1 = 521,
      y1 = 111,
      x2 = 1041,
      y2 = 221
    },
    LUA_CHANNELCHAT_ROOM_DESC_09 = {
      x1 = 521,
      y1 = 222,
      x2 = 1041,
      y2 = 332
    },
    LUA_CHANNELCHAT_ROOM_DESC_10 = {
      x1 = 521,
      y1 = 333,
      x2 = 1041,
      y2 = 443
    },
    LUA_CHANNELCHAT_ROOM_DESC_11 = {
      x1 = 521,
      y1 = 444,
      x2 = 1041,
      y2 = 554
    },
    LUA_CHANNELCHAT_ROOM_DESC_12 = {
      x1 = 521,
      y1 = 555,
      x2 = 1041,
      y2 = 665
    },
    LUA_CHANNELCHAT_ROOM_DESC_13 = {
      x1 = 521,
      y1 = 666,
      x2 = 1041,
      y2 = 776
    },
    LUA_CHANNELCHAT_ROOM_DESC_14 = {
      x1 = 0,
      y1 = 666,
      x2 = 520,
      y2 = 776
    },
    LUA_CHANNELCHAT_ROOM_DESC_15 = {
      x1 = 0,
      y1 = 777,
      x2 = 520,
      y2 = 887
    },
    LUA_CHANNELCHAT_ROOM_DESC_16 = {
      x1 = 521,
      y1 = 777,
      x2 = 1041,
      y2 = 887
    },
    LUA_CHANNELCHAT_ROOM_DESC_17 = {
      x1 = 0,
      y1 = 888,
      x2 = 520,
      y2 = 998
    },
    LUA_CHANNELCHAT_ROOM_DESC_18 = {
      x1 = 521,
      y1 = 888,
      x2 = 1041,
      y2 = 998
    },
    LUA_CHANNELCHAT_ROOM_DESC_19 = {
      x1 = 0,
      y1 = 999,
      x2 = 520,
      y2 = 1109
    },
    LUA_CHANNELCHAT_ROOM_DESC_20 = {
      x1 = 521,
      y1 = 999,
      x2 = 1041,
      y2 = 1109
    },
    LUA_CHANNELCHAT_ROOM_DESC_21 = {
      x1 = 0,
      y1 = 1110,
      x2 = 520,
      y2 = 1220
    },
    LUA_CHANNELCHAT_ROOM_DESC_22 = {
      x1 = 521,
      y1 = 1110,
      x2 = 1041,
      y2 = 1220
    },
    LUA_CHANNELCHAT_ROOM_DESC_23 = {
      x1 = 2,
      y1 = 1221,
      x2 = 520,
      y2 = 1331
    },
    LUA_CHANNELCHAT_ROOM_DESC_24 = {
      x1 = 521,
      y1 = 1221,
      x2 = 1041,
      y2 = 1331
    },
    LUA_CHANNELCHAT_ROOM_DESC_25 = {
      x1 = 0,
      y1 = 1332,
      x2 = 520,
      y2 = 1442
    },
    LUA_CHANNELCHAT_ROOM_DESC_26 = {
      x1 = 521,
      y1 = 1332,
      x2 = 1041,
      y2 = 1442
    }
  },
  _currentIndex = -1,
  _selectIndex = -1,
  _maxListCount = 26,
  _serverListCount = 26,
  channelIndexToTextureIndex = {
    [0] = 0,
    [1] = 3,
    [2] = 4,
    [3] = 1,
    [4] = 2
  },
  _startItemIndex = 0,
  _isFirstLogin = true,
  _isConsole = false,
  _initialize = false
}
runLua("UI_Data/Script/Widget/Chatting/Panel_Window_ChannelChat_1.lua")
runLua("UI_Data/Script/Widget/Chatting/Panel_Window_ChannelChat_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_ChannelChatInit")
function FromClient_ChannelChatInit()
  PaGlobal_ChannelChat:initialize()
end
