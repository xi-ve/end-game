PaGlobal_ChangeItem_All = {
  _ui = {
    stc_titleBg = nil,
    stc_subBg = nil,
    stc_backPanel = nil,
    stc_backEffect = nil,
    txt_target = nil,
    txt_result = nil,
    stc_targetSlot = nil,
    stc_resultSlot = nil
  },
  _ui_pc = {btn_close = nil, btn_apply = nil},
  _ui_console = {
    stc_bottomGuideBg = nil,
    stc_guideX = nil,
    stc_guideY = nil,
    stc_guideB = nil
  },
  _slotConfig = {
    createIcon = true,
    createBorder = true,
    createCount = true,
    createCash = false,
    createEnchant = true
  },
  _resize = {
    pc = {
      panelY = 460,
      subBgY = 410,
      resultTxtSpanY = 80
    },
    console = {
      panelY = 400,
      subBgY = 350,
      resultTxtSpanY = 30
    }
  },
  _selectedItemSlotNo = nil,
  _selectedItemWhereType = nil,
  _materialItemSlotNo = nil,
  _materialItemWhereType = nil,
  _elapsTime = 0,
  _effect_ani_time = 4,
  _sound_ani_time = 3.2,
  _sound_ani_flag = false,
  _doChange = false,
  _resultItemKey = nil,
  _isChangeDoing = false,
  _equipSlot = {},
  _resultSlot = {},
  _isConsole = false,
  _initialize = false
}
runLua("UI_Data/Script/Window/ChangeItem/Panel_Window_ChangeItem_All_1.lua")
runLua("UI_Data/Script/Window/ChangeItem/Panel_Window_ChangeItem_All_2.lua")
registerEvent("FromClient_luaLoadCompleteLateUdpate", "FromClient_ChangeItem_All_Init")
function FromClient_ChangeItem_All_Init()
  PaGlobal_ChangeItem_All:initialize()
end
