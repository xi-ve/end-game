PaGlobal_SetVoiceChat_All = {
  _ui = {
    stc_title = nil,
    stc_insideBg = nil,
    stc_micHeadPhoneOnOffBg = nil,
    txt_micHeadPhoneOnOff = nil,
    stc_micHeadPhoneCheckBg = nil,
    chk_mic = nil,
    chk_listen = nil,
    chk_pushMic = nil,
    stc_menuBg = nil,
    txt_micMenu = nil,
    txt_vol_0 = nil,
    txt_vol_50 = nil,
    txt_vol_100 = nil,
    slider_volControl_0 = nil,
    slider_volControl_1 = nil,
    slider_volControl_2 = nil,
    slider_volControl_3 = nil
  },
  _ui_pc = {
    btn_close = nil,
    btn_confirm = nil,
    btn_cancle = nil
  },
  _ui_console = {
    stc_bottomGuideBg = nil,
    stc_guideA = nil,
    stc_guideB = nil,
    stc_guideY = nil
  },
  _VOICE_TYPE = {
    enVoiceChatType_Guild = 0,
    enVoiceChatType_Party = 1,
    enVoiceChatType_World = 2
  },
  _config = {
    sliderCount = 4,
    openIsMicOn = true,
    openIsHeadphoneOn = true,
    openIsPushToTalk = true,
    openMicVolume = 0,
    openHeadphoneVolume = 0,
    openMicSensitivity = 0,
    openMicAmplification = 0
  },
  _titleArray = {
    [0] = PAGetString(Defines.StringSheet_GAME, "LUA_SETVOICECHAT_TALK_VOLUME"),
    [1] = PAGetString(Defines.StringSheet_GAME, "LUA_SETVOICECHAT_HEARING_VOLUME"),
    [2] = PAGetString(Defines.StringSheet_GAME, "LUA_SETVOICECHAT_MIC_SENSITIVITY"),
    [3] = PAGetString(Defines.StringSheet_GAME, "LUA_SETVOICECHAT_MIC_AMPLIFICATION")
  },
  _uiSize = {panelsizeY_pc = 505, panelsizeY_console = 445},
  _uiPool = {},
  _isConsole = false,
  _initialize = false
}
runLua("UI_Data/Script/Widget/RightTopIcons/Panel_Window_PersonalIcon_SetVoiceChat_All_1.lua")
runLua("UI_Data/Script/Widget/RightTopIcons/Panel_Window_PersonalIcon_SetVoiceChat_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_SetVoiceChat_All_Init")
function FromClient_SetVoiceChat_All_Init()
  PaGlobal_SetVoiceChat_All:initialize()
end
