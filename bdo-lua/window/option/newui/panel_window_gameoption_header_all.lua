PaGlobal_GameOption_All = {
  OPTION_TYPE = {
    RADIOBUTTON = 0,
    CHECKBUTTON = 1,
    SLIDER = 2,
    KEYCUSTOMIZE = 3,
    COMBOBOX = 4,
    BUTTON = 5,
    RADIOVERTICAL = 6,
    PAGETITLE = 7,
    RADIOBUTTON2 = 8,
    KEYCUSTOMETITLE = 9,
    SUBSLIDER = 10,
    SUBTITLE = 11
  },
  PAGE = {
    Main = 1,
    Category = 2,
    Search = 3
  },
  SPEC = {
    LowNormal = 1,
    MidNormal = 2,
    HighNormal = 3,
    HighestNormal = 4,
    LowSiege = 5,
    MidSiege = 6,
    HighSiege = 7,
    HighestSiege = 8
  },
  GRAPHIC = {
    VeryVeryLow = 6,
    VeryLow = 0,
    Low = 1,
    Medium = 2,
    High = 3,
    VeryHigh = 4,
    VeryVeryHigh = 5,
    UltraHigh = 8,
    UltraLow = 7
  },
  ALERT = {
    ChangeRegion = 0,
    NormalTrade = 1,
    RoyalTrade = 2,
    FitnessLevelUp = 3,
    TerritoryWar = 4,
    GuildWar = 5,
    OtherPlayerGetItem = 6,
    ItemMarket = 7,
    LifeLevelUp = 8,
    GuildQuestMessage = 9,
    NearMonster = 10,
    OtherMarket = 11,
    EnchantSuccess = 12,
    EnchantFail = 13
  },
  _tooltip = {},
  _homeTooltip = {},
  _ui = {_currentPage = 1},
  _list2 = {
    _curCategory = nil,
    _curFrame = nil,
    _tree2IndexMap = {},
    _selectedKey = nil,
    _selectedSubKey = nil
  },
  _searchElementTable = {},
  _controlCache = {
    [0] = {},
    [1] = {},
    [2] = {},
    [3] = {},
    [4] = {},
    [5] = {},
    [6] = {},
    [7] = {},
    [8] = {},
    [9] = {},
    [10] = {},
    [11] = {}
  },
  _categoryIconUV = {
    Performance = {
      x1 = 32,
      y1 = 1,
      x2 = 62,
      y2 = 31
    },
    Graphic = {
      x1 = 63,
      y1 = 1,
      x2 = 93,
      y2 = 31
    },
    Sound = {
      x1 = 94,
      y1 = 1,
      x2 = 124,
      y2 = 31
    },
    Function = {
      x1 = 156,
      y1 = 1,
      x2 = 186,
      y2 = 31
    },
    Interface = {
      x1 = 125,
      y1 = 1,
      x2 = 155,
      y2 = 31
    }
  },
  _currentFrame = nil,
  _userInitScreenResolution = {width = 0, height = 0},
  _findStrings = {},
  _keyCustomPadMode = nil,
  _keyCustomInputType = nil,
  _resetCheck = nil,
  _availableResolutionList = nil,
  _screenResolutionCount = nil,
  _fpsTextControl = nil,
  _sliderButtonString = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_NEWGAMEOPTION_CURRENT_SLIDERVALUE") .. " <PAColor0xfff5ba3a>",
  _radioButtonOnString = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_NEWGAMEOPTION_SWITCHON"),
  _radioButtonOffString = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_NEWGAMEOPTION_SWITCHOFF"),
  _recommendUIScaleBase = 1080,
  _pageBottomSpan = 20,
  _isChecked_SkillCommand = true,
  _contrastValue = 0,
  _isContrast = false,
  _isExit = false,
  _tempKR2BlockString = {
    [1] = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_NEWGAMEOPTION_UiGuildServant"),
    [2] = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_NEWGAMEOPTION_UiBlackGift"),
    [3] = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_GAMEOPTION_DISPLAY_WATERMARK_ALPHASET"),
    [4] = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_GAMEOPTION_DISPLAY_WATERMARK_SCALESET"),
    [5] = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_GAMEOPTION_DISPLAY_WATERMARK_POSSET"),
    [6] = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_GAMEOPTION_DISPLAY_WATERMARK_TYPE"),
    [7] = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_NEWGAMEOPTION_WatermarkAlpha"),
    [8] = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_NEWGAMEOPTION_WatermarkScale"),
    [9] = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_NEWGAMEOPTION_WatermarkPosition"),
    [10] = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_NEWGAMEOPTION_WatermarkService"),
    [11] = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_NEWGAMEOPTION_TentRender"),
    [12] = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_NEWGAMEOPTION_ActionPushToTalk"),
    [13] = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_NEWGAMEOPTION_AudioResourceType"),
    [14] = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_GAMEOPTION_NPCVOICESELECT")
  },
  _tempKRBlockString = {
    [1] = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_GAMEOPTION_CHATFILTERING")
  },
  _tempRUBlockString = {
    [1] = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_NEWGAMEOPTION_ActionPushToTalk")
  },
  _worldMapOpenTypeValue = {
    [0] = 3,
    [1] = 1,
    [2] = 0,
    [3] = 2
  },
  _worldMapCameraPitchTypeValue = {
    [0] = 1,
    [1] = 0,
    [2] = 2
  },
  _SelfPlayerNameTagVisibleValue = {
    [0] = 0,
    [1] = 2,
    [2] = 1
  }
}
PaGlobal_GameOption_All._elements = {
  AimAssist = {_defaultValue = true, _controlType = __ePAUIControl_CheckButton},
  UseNewQuickSlot = {_defaultValue = false, _controlType = __ePAUIControl_CheckButton},
  EnableSimpleUI = {_defaultValue = false, _controlType = __ePAUIControl_CheckButton},
  IsOnScreenSaver = {_defaultValue = true, _controlType = __ePAUIControl_CheckButton},
  UIFontSizeType = {_defaultValue = 0, _controlType = __ePAUIControl_RadioButton},
  UIFontType = {_defaultValue = 0, _controlType = __ePAUIControl_RadioButton},
  ShowNavPathEffectType = {_defaultValue = 1, _controlType = __ePAUIControl_RadioButton},
  AutoNaviMoveType = {_defaultValue = 1, _controlType = __ePAUIControl_RadioButton},
  AutoNaviMoveTypeAtGround = {_defaultValue = 0, _controlType = __ePAUIControl_RadioButton},
  RefuseRequests = {_defaultValue = false, _controlType = __ePAUIControl_CheckButton},
  IsPvpRefuse = {_defaultValue = false, _controlType = __ePAUIControl_CheckButton},
  IsExchangeRefuse = {_defaultValue = false, _controlType = __ePAUIControl_CheckButton},
  RotateRadarMode = {_defaultValue = false, _controlType = __ePAUIControl_CheckButton},
  HideWindowByAttacked = {_defaultValue = true, _controlType = __ePAUIControl_CheckButton},
  AudioResourceType = {_defaultValue = 0, _controlType = __ePAUIControl_RadioButton},
  ServiceResourceType = {_controlType = __ePAUIControl_RadioButton},
  UseChattingFilter = {_defaultValue = true, _controlType = __ePAUIControl_CheckButton},
  ChatChannelType = {_defaultValue = 0, _controlType = __ePAUIControl_RadioButton},
  SelfPlayerNameTagVisible = {
    _defaultValue = 0,
    _controlType = __ePAUIControl_RadioButton,
    _alignVertical = true
  },
  NickNameOrCharacterName = {_defaultValue = 1, _controlType = __ePAUIControl_RadioButton},
  OtherPlayerNameTagVisible = {_defaultValue = true, _controlType = __ePAUIControl_CheckButton},
  PartyPlayerNameTagVisible = {_defaultValue = true, _controlType = __ePAUIControl_CheckButton},
  GuildPlayerNameTagVisible = {_defaultValue = true, _controlType = __ePAUIControl_CheckButton},
  RankingPlayerNameTagVisible = {_defaultValue = true, _controlType = __ePAUIControl_CheckButton},
  GuideLineZoneChange = {_defaultValue = true, _controlType = __ePAUIControl_CheckButton},
  GuideLineQuestNPC = {_defaultValue = true, _controlType = __ePAUIControl_CheckButton},
  GuideLineNpcIntimacy = {_defaultValue = true, _controlType = __ePAUIControl_CheckButton},
  GuideLineWarAlly = {_defaultValue = true, _controlType = __ePAUIControl_CheckButton},
  GuideLineNonWarPlayer = {_defaultValue = true, _controlType = __ePAUIControl_CheckButton},
  GuideLineEnemy = {_defaultValue = true, _controlType = __ePAUIControl_CheckButton},
  GuideLineGuild = {_defaultValue = true, _controlType = __ePAUIControl_CheckButton},
  GuideLineParty = {_defaultValue = true, _controlType = __ePAUIControl_CheckButton},
  WorkerVisible = {_defaultValue = 0, _controlType = __ePAUIControl_CheckButton},
  PetRender = {_defaultValue = 1, _controlType = __ePAUIControl_RadioButton},
  FairyRender = {_defaultValue = 1, _controlType = __ePAUIControl_RadioButton},
  TentRender = {_defaultValue = 0, _controlType = __ePAUIControl_RadioButton},
  MaidView = {
    _defaultValue = 1,
    _controlType = __ePAUIControl_Slider,
    _sliderValueMin = 0,
    _sliderValueMax = 1
  },
  ShowReputation = {_defaultValue = true, _controlType = __ePAUIControl_CheckButton},
  RenderHitEffect = {
    _defaultValue = true,
    _controlType = __ePAUIControl_CheckButton,
    _isPictureTooltipOn = true
  },
  DamageMeter = {_defaultValue = false, _controlType = __ePAUIControl_CheckButton},
  ShowComboGuide = {_defaultValue = true, _controlType = __ePAUIControl_CheckButton},
  HideMastOnCarrier = {_defaultValue = true, _controlType = __ePAUIControl_CheckButton},
  WorldMapOpenType = {_defaultValue = 3, _controlType = __ePAUIControl_RadioButton},
  WorldmapCameraPitchType = {_defaultValue = 1, _controlType = __ePAUIControl_RadioButton},
  TextureQuality = {
    _defaultValue = 1,
    _controlType = __ePAUIControl_RadioButton,
    _isPictureTooltipOn = true
  },
  GraphicOption = {
    _defaultValue = 2,
    _controlType = __ePAUIControl_RadioButton,
    _use2option = true
  },
  AntiAliasing = {
    _defaultValue = 1,
    _controlType = __ePAUIControl_RadioButton,
    _isPictureTooltipOn = true
  },
  SSAO = {
    _defaultValue = true,
    _controlType = __ePAUIControl_CheckButton,
    _isPictureTooltipOn = true
  },
  PostFilter = {_defaultValue = true, _controlType = __ePAUIControl_CheckButton},
  Tessellation = {
    _defaultValue = false,
    _controlType = __ePAUIControl_CheckButton,
    _isPictureTooltipOn = true
  },
  Dof = {
    _defaultValue = true,
    _controlType = __ePAUIControl_CheckButton,
    _isPictureTooltipOn = true
  },
  Representative = {
    _defaultValue = false,
    _controlType = __ePAUIControl_CheckButton,
    _isPictureTooltipOn = true
  },
  CharacterEffect = {_defaultValue = true, _controlType = __ePAUIControl_CheckButton},
  SnowPoolOnlyInSafeZone = {_defaultValue = false, _controlType = __ePAUIControl_CheckButton},
  BloodEffect = {_defaultValue = true, _controlType = __ePAUIControl_CheckButton},
  LensBlood = {_defaultValue = true, _controlType = __ePAUIControl_CheckButton},
  AutoOptimization = {_defaultValue = true, _controlType = __ePAUIControl_CheckButton},
  AutoOptimizationFrameLimit = {
    _defaultValue = 0.33333,
    _controlType = __ePAUIControl_Slider,
    _sliderValueMin = 0,
    _sliderValueMax = 60
  },
  UpscaleEnable = {_defaultValue = false, _controlType = __ePAUIControl_CheckButton},
  SelfPlayerOnlyEffect = {_defaultValue = false, _controlType = __ePAUIControl_CheckButton},
  NearestPlayerOnlyEffect = {_defaultValue = false, _controlType = __ePAUIControl_CheckButton},
  PresentLock = {_defaultValue = true, _controlType = __ePAUIControl_CheckButton},
  ShowStackHp = {_defaultValue = false, _controlType = __ePAUIControl_CheckButton},
  DataOptimize = {_defaultValue = false, _controlType = __ePAUIControl_CheckButton},
  UseEffectFrameOptimization = {_defaultValue = true, _controlType = __ePAUIControl_CheckButton},
  EffectFrameOptimization = {
    _defaultValue = 0.03,
    _controlType = __ePAUIControl_Slider,
    _sliderValueMin = 0.1,
    _sliderValueMax = 25
  },
  UsePlayerEffectDistOptimization = {_defaultValue = true, _controlType = __ePAUIControl_CheckButton},
  PlayerEffectDistOptimization = {
    _defaultValue = 0.5,
    _controlType = __ePAUIControl_Slider,
    _sliderValueMin = 10,
    _sliderValueMax = 50
  },
  UseCharacterUpdateFrameOptimize = {_defaultValue = true, _controlType = __ePAUIControl_CheckButton},
  UseOtherPlayerUpdate = {_defaultValue = false, _controlType = __ePAUIControl_CheckButton},
  ShowSpawnableNPC = {_defaultValue = false, _controlType = __ePAUIControl_CheckButton},
  Fov = {
    _defaultValue = 0.33333,
    _controlType = __ePAUIControl_Slider,
    _sliderValueMin = 0,
    _sliderValueMax = 100,
    _settingRightNow = true
  },
  CameraEffectMaster = {
    _defaultValue = 1,
    _controlType = __ePAUIControl_Slider,
    _sliderValueMin = 0,
    _sliderValueMax = 100
  },
  CameraShakePower = {
    _defaultValue = 0.5,
    _controlType = __ePAUIControl_Slider,
    _sliderValueMin = 0,
    _sliderValueMax = 100
  },
  MotionBlurPower = {
    _defaultValue = 0.1,
    _controlType = __ePAUIControl_Slider,
    _sliderValueMin = 0,
    _sliderValueMax = 100
  },
  CameraTranslatePower = {
    _defaultValue = 0.5,
    _controlType = __ePAUIControl_Slider,
    _sliderValueMin = 0,
    _sliderValueMax = 100
  },
  CameraFovPower = {
    _defaultValue = 0.5,
    _controlType = __ePAUIControl_Slider,
    _sliderValueMin = 0,
    _sliderValueMax = 100
  },
  LUT = {
    _defaultValue = 8,
    _controlType = __ePAUIControl_Button,
    _settingRightNow = true
  },
  HDRDisplayGamma = {
    _defaultValue = 0.5,
    _controlType = __ePAUIControl_Slider,
    _sliderValueMin = 0.5,
    _sliderValueMax = 1.5,
    _settingRightNow = true
  },
  HDRDisplayMaxNits = {
    _defaultValue = 0.5,
    _controlType = __ePAUIControl_Slider,
    _sliderValueMin = 500,
    _sliderValueMax = 10000,
    _settingRightNow = true
  },
  UltraHighDefinition = {_defaultValue = false, _controlType = __ePAUIControl_CheckButton},
  MouseInvertX = {_defaultValue = false, _controlType = __ePAUIControl_CheckButton},
  MouseInvertY = {_defaultValue = false, _controlType = __ePAUIControl_CheckButton},
  MouseSensitivityX = {
    _defaultValue = 0.473684,
    _controlType = __ePAUIControl_Slider,
    _sliderValueMin = 0,
    _sliderValueMax = 100
  },
  MouseSensitivityY = {
    _defaultValue = 0.473684,
    _controlType = __ePAUIControl_Slider,
    _sliderValueMin = 0,
    _sliderValueMax = 100
  },
  GameMouseMode = {_defaultValue = false, _controlType = __ePAUIControl_CheckButton},
  IsUIModeMouseLock = {_defaultValue = false, _controlType = __ePAUIControl_CheckButton},
  GamePadEnable = {_defaultValue = false, _controlType = __ePAUIControl_CheckButton},
  GamePadVibration = {_defaultValue = false, _controlType = __ePAUIControl_CheckButton},
  GamePadInvertX = {_defaultValue = false, _controlType = __ePAUIControl_CheckButton},
  GamePadInvertY = {_defaultValue = false, _controlType = __ePAUIControl_CheckButton},
  UseLedAnimation = {_defaultValue = false, _controlType = __ePAUIControl_CheckButton},
  GamePadSensitivityX = {
    _defaultValue = 0.473684,
    _controlType = __ePAUIControl_Slider,
    _sliderValueMin = 0,
    _sliderValueMax = 100
  },
  GamePadSensitivityY = {
    _defaultValue = 0.315789,
    _controlType = __ePAUIControl_Slider,
    _sliderValueMin = 0,
    _sliderValueMax = 100
  },
  ConsolePadKeyType = {_defaultValue = 0, _controlType = __ePAUIControl_RadioButton},
  ScreenShotQuality = {
    _defaultValue = 0,
    _controlType = __ePAUIControl_RadioButton,
    _tooltipControl = {}
  },
  ScreenShotFormat = {_defaultValue = 1, _controlType = __ePAUIControl_RadioButton},
  WatermarkAlpha = {
    _defaultValue = 1,
    _controlType = __ePAUIControl_Slider,
    _sliderValueMin = 20,
    _sliderValueMax = 100
  },
  WatermarkScale = {_defaultValue = 1, _controlType = __ePAUIControl_RadioButton},
  WatermarkPosition = {_defaultValue = 3, _controlType = __ePAUIControl_RadioButton},
  WatermarkService = {_defaultValue = 0, _controlType = __ePAUIControl_RadioButton},
  ScreenMode = {
    _defaultValue = 2,
    _isChangeDisplay = true,
    _controlType = __ePAUIControl_RadioButton
  },
  ScreenResolution = {
    _isChangeDisplay = true,
    _controlType = __ePAUIControl_ComboBox,
    _comboBoxList = nil
  },
  CropModeEnable = {_defaultValue = false, _controlType = __ePAUIControl_CheckButton},
  CropModeScaleX = {
    _defaultValue = 1,
    _controlType = __ePAUIControl_Slider,
    _sliderValueMin = 50,
    _sliderValueMax = 100,
    _isSubSlider = true
  },
  CropModeScaleY = {
    _defaultValue = 0.6,
    _controlType = __ePAUIControl_Slider,
    _sliderValueMin = 50,
    _sliderValueMax = 100,
    _isSubSlider = true
  },
  UIScale = {
    _defaultValue = 0.3333,
    _isChangeDisplay = true,
    _controlType = __ePAUIControl_Slider,
    _sliderValueMin = 50,
    _sliderValueMax = 200
  },
  GammaValue = {
    _defaultValue = 0.5,
    _controlType = __ePAUIControl_Slider,
    _sliderValueMin = -50,
    _sliderValueMax = 50,
    _settingRightNow = true
  },
  ContrastValue = {
    _defaultValue = 0.7,
    _controlType = __ePAUIControl_Slider,
    _sliderValueMin = -50,
    _sliderValueMax = 50,
    _settingRightNow = true
  },
  EffectAlpha = {
    _defaultValue = 1,
    _controlType = __ePAUIControl_Slider,
    _sliderValueMin = 30,
    _sliderValueMax = 100
  },
  SkillPostEffect = {
    _defaultValue = 1,
    _controlType = __ePAUIControl_Slider,
    _sliderValueMin = 0,
    _sliderValueMax = 100
  },
  ColorBlind = {_defaultValue = 0, _controlType = __ePAUIControl_RadioButton},
  BlackSpiritNotice = {_defaultValue = true, _controlType = __ePAUIControl_CheckButton},
  ShowCashAlert = {_defaultValue = true, _controlType = __ePAUIControl_CheckButton},
  ShowGuildLoginMessage = {_defaultValue = false, _controlType = __ePAUIControl_CheckButton},
  EnableMusic = {
    _defaultValue = true,
    _controlType = __ePAUIControl_CheckButton,
    _settingRightNow = true
  },
  EnableSound = {
    _defaultValue = true,
    _controlType = __ePAUIControl_CheckButton,
    _settingRightNow = true
  },
  EnableEnv = {
    _defaultValue = true,
    _controlType = __ePAUIControl_CheckButton,
    _settingRightNow = true
  },
  EnableWhisperMusic = {
    _defaultValue = true,
    _controlType = __ePAUIControl_CheckButton,
    _settingRightNow = true
  },
  EnableTraySoundOnOff = {
    _defaultValue = false,
    _controlType = __ePAUIControl_CheckButton,
    _settingRightNow = true
  },
  EnableAroundPlayMusic = {
    _defaultValue = true,
    _controlType = __ePAUIControl_CheckButton,
    _settingRightNow = true
  },
  BattleSoundType = {
    _defaultValue = 1,
    _controlType = __ePAUIControl_RadioButton,
    _settingRightNow = true
  },
  EnableAudioFairy = {_defaultValue = true, _controlType = __ePAUIControl_CheckButton},
  VolumeMaster = {
    _defaultValue = 1,
    _controlType = __ePAUIControl_Slider,
    _sliderValueMin = 0,
    _sliderValueMax = 100,
    _settingRightNow = true
  },
  VolumeMusicPlay = {
    _defaultValue = 1,
    _controlType = __ePAUIControl_Slider,
    _sliderValueMin = 0,
    _sliderValueMax = 100,
    _settingRightNow = true,
    _isSubSlider = true
  },
  VolumeMusic = {
    _defaultValue = 1,
    _controlType = __ePAUIControl_Slider,
    _sliderValueMin = 0,
    _sliderValueMax = 100,
    _settingRightNow = true
  },
  VolumeFx = {
    _defaultValue = 1,
    _controlType = __ePAUIControl_Slider,
    _sliderValueMin = 0,
    _sliderValueMax = 100,
    _settingRightNow = true
  },
  VolumeEnv = {
    _defaultValue = 1,
    _controlType = __ePAUIControl_Slider,
    _sliderValueMin = 0,
    _sliderValueMax = 100,
    _settingRightNow = true
  },
  VolumeDlg = {
    _defaultValue = 1,
    _controlType = __ePAUIControl_Slider,
    _sliderValueMin = 0,
    _sliderValueMax = 100,
    _settingRightNow = true
  },
  VolumeHitFxVolume = {
    _defaultValue = 1,
    _controlType = __ePAUIControl_Slider,
    _sliderValueMin = 0,
    _sliderValueMax = 100,
    _settingRightNow = true,
    _isSubSlider = true
  },
  VolumeHitFxWeight = {
    _defaultValue = 1,
    _controlType = __ePAUIControl_Slider,
    _sliderValueMin = 0,
    _sliderValueMax = 100,
    _settingRightNow = true,
    _isSubSlider = true
  },
  VolumeOtherPlayer = {
    _defaultValue = 1,
    _controlType = __ePAUIControl_Slider,
    _sliderValueMin = 0,
    _sliderValueMax = 100,
    _settingRightNow = true,
    _isSubSlider = true
  },
  VolumeFairy = {
    _defaultValue = 0.5,
    _controlType = __ePAUIControl_Slider,
    _sliderValueMin = 0,
    _sliderValueMax = 100,
    _settingRightNow = true
  },
  AlertNormalTrade = {_defaultValue = true, _controlType = __ePAUIControl_CheckButton},
  AlertRoyalTrade = {_defaultValue = true, _controlType = __ePAUIControl_CheckButton},
  AlertOtherPlayerGetItem = {_defaultValue = true, _controlType = __ePAUIControl_CheckButton},
  AlertLifeLevelUp = {_defaultValue = true, _controlType = __ePAUIControl_CheckButton},
  AlertItemMarket = {_defaultValue = true, _controlType = __ePAUIControl_CheckButton},
  AlertOtherMarket = {_defaultValue = true, _controlType = __ePAUIControl_CheckButton},
  AlertChangeRegion = {_defaultValue = true, _controlType = __ePAUIControl_CheckButton},
  AlertFitnessLevelUp = {_defaultValue = true, _controlType = __ePAUIControl_CheckButton},
  AlertTerritoryWar = {_defaultValue = true, _controlType = __ePAUIControl_CheckButton},
  AlertGuildWar = {_defaultValue = true, _controlType = __ePAUIControl_CheckButton},
  AlertEnchantSuccess = {_defaultValue = true, _controlType = __ePAUIControl_CheckButton},
  AlertEnchantFail = {_defaultValue = true, _controlType = __ePAUIControl_CheckButton},
  AlertGuildQuestMessage = {_defaultValue = true, _controlType = __ePAUIControl_CheckButton},
  AlertNearMonster = {_defaultValue = true, _controlType = __ePAUIControl_CheckButton},
  ShowRightBottomAlarm = {_defaultValue = true, _controlType = __ePAUIControl_CheckButton},
  AutoRunCamera = {_defaultValue = true, _controlType = __ePAUIControl_CheckButton},
  AutoRunCameraRotation = {
    _defaultValue = 1,
    _controlType = __ePAUIControl_Slider,
    _sliderValueMin = 10,
    _sliderValueMax = 30
  },
  KeyCustomMode = {
    _defaultValue = 0,
    _controlType = __ePAUIControl_RadioButton,
    _settingRightNow = true
  },
  PadFunction1 = {
    actionInputType = "PadFunction1",
    _controlType = __ePAUIControl_RadioButton
  },
  PadFunction2 = {
    actionInputType = "PadFunction2",
    _controlType = __ePAUIControl_RadioButton
  },
  ActionMoveFront = {actionInputType = 0, _controlType = __ePAUIControl_RadioButton},
  ActionMoveBack = {actionInputType = 1, _controlType = __ePAUIControl_RadioButton},
  ActionMoveLeft = {actionInputType = 2, _controlType = __ePAUIControl_RadioButton},
  ActionMoveRight = {actionInputType = 3, _controlType = __ePAUIControl_RadioButton},
  ActionAttack1 = {actionInputType = 4, _controlType = __ePAUIControl_RadioButton},
  ActionAttack2 = {actionInputType = 5, _controlType = __ePAUIControl_RadioButton},
  ActionDash = {actionInputType = 6, _controlType = __ePAUIControl_RadioButton},
  ActionJump = {actionInputType = 7, _controlType = __ePAUIControl_RadioButton},
  ActionInteraction = {actionInputType = 8, _controlType = __ePAUIControl_RadioButton},
  ActionAutoRun = {actionInputType = 9, _controlType = __ePAUIControl_RadioButton},
  ActionWeaponInOut = {actionInputType = 10, _controlType = __ePAUIControl_RadioButton},
  ActionCameraReset = {actionInputType = 11, _controlType = __ePAUIControl_RadioButton},
  ActionCrouchOrSkill = {actionInputType = 12, _controlType = __ePAUIControl_RadioButton},
  ActionGrabOrGuard = {actionInputType = 13, _controlType = __ePAUIControl_RadioButton},
  ActionKick = {actionInputType = 14, _controlType = __ePAUIControl_RadioButton},
  ActionServantOrder1 = {actionInputType = 15, _controlType = __ePAUIControl_RadioButton},
  ActionServantOrder2 = {actionInputType = 16, _controlType = __ePAUIControl_RadioButton},
  ActionServantOrder3 = {actionInputType = 17, _controlType = __ePAUIControl_RadioButton},
  ActionServantOrder4 = {actionInputType = 18, _controlType = __ePAUIControl_RadioButton},
  ActionQuickSlot1 = {actionInputType = 19, _controlType = __ePAUIControl_RadioButton},
  ActionQuickSlot2 = {actionInputType = 20, _controlType = __ePAUIControl_RadioButton},
  ActionQuickSlot3 = {actionInputType = 21, _controlType = __ePAUIControl_RadioButton},
  ActionQuickSlot4 = {actionInputType = 22, _controlType = __ePAUIControl_RadioButton},
  ActionQuickSlot5 = {actionInputType = 23, _controlType = __ePAUIControl_RadioButton},
  ActionQuickSlot6 = {actionInputType = 24, _controlType = __ePAUIControl_RadioButton},
  ActionQuickSlot7 = {actionInputType = 25, _controlType = __ePAUIControl_RadioButton},
  ActionQuickSlot8 = {actionInputType = 26, _controlType = __ePAUIControl_RadioButton},
  ActionQuickSlot9 = {actionInputType = 27, _controlType = __ePAUIControl_RadioButton},
  ActionQuickSlot10 = {actionInputType = 28, _controlType = __ePAUIControl_RadioButton},
  ActionQuickSlot11 = {actionInputType = 29, _controlType = __ePAUIControl_RadioButton},
  ActionQuickSlot12 = {actionInputType = 30, _controlType = __ePAUIControl_RadioButton},
  ActionQuickSlot13 = {actionInputType = 31, _controlType = __ePAUIControl_RadioButton},
  ActionQuickSlot14 = {actionInputType = 32, _controlType = __ePAUIControl_RadioButton},
  ActionQuickSlot15 = {actionInputType = 33, _controlType = __ePAUIControl_RadioButton},
  ActionQuickSlot16 = {actionInputType = 34, _controlType = __ePAUIControl_RadioButton},
  ActionQuickSlot17 = {actionInputType = 35, _controlType = __ePAUIControl_RadioButton},
  ActionQuickSlot18 = {actionInputType = 36, _controlType = __ePAUIControl_RadioButton},
  ActionQuickSlot19 = {actionInputType = 37, _controlType = __ePAUIControl_RadioButton},
  ActionQuickSlot20 = {actionInputType = 38, _controlType = __ePAUIControl_RadioButton},
  ActionComplicated0 = {actionInputType = 39, _controlType = __ePAUIControl_RadioButton},
  ActionComplicated1 = {actionInputType = 40, _controlType = __ePAUIControl_RadioButton},
  ActionComplicated2 = {actionInputType = 41, _controlType = __ePAUIControl_RadioButton},
  ActionComplicated3 = {actionInputType = 42, _controlType = __ePAUIControl_RadioButton},
  ActionAutoMoveWalkMode = {actionInputType = 43, _controlType = __ePAUIControl_RadioButton},
  ActionCameraUp = {actionInputType = 44, _controlType = __ePAUIControl_RadioButton},
  ActionCameraDown = {actionInputType = 45, _controlType = __ePAUIControl_RadioButton},
  ActionCameraLeft = {actionInputType = 46, _controlType = __ePAUIControl_RadioButton},
  ActionCameraRight = {actionInputType = 47, _controlType = __ePAUIControl_RadioButton},
  ActionCameraRotateGameMode = {actionInputType = 48, _controlType = __ePAUIControl_RadioButton},
  ActionPushToTalk = {actionInputType = 49, _controlType = __ePAUIControl_RadioButton},
  ActionWalkMode = {actionInputType = 50, _controlType = __ePAUIControl_RadioButton},
  UiCursorOnOff = {uiInputType = 0, _controlType = __ePAUIControl_RadioButton},
  UiHelp = {uiInputType = 1, _controlType = __ePAUIControl_RadioButton},
  UiMentalKnowledge = {uiInputType = 2, _controlType = __ePAUIControl_RadioButton},
  UiInventory = {uiInputType = 3, _controlType = __ePAUIControl_RadioButton},
  UiBlackSpirit = {uiInputType = 4, _controlType = __ePAUIControl_RadioButton},
  UiChat = {uiInputType = 5, _controlType = __ePAUIControl_RadioButton},
  UiPlayerInfo = {uiInputType = 6, _controlType = __ePAUIControl_RadioButton},
  UiSkill = {uiInputType = 7, _controlType = __ePAUIControl_RadioButton},
  UiWorldMap = {uiInputType = 8, _controlType = __ePAUIControl_RadioButton},
  UiDyeing = {uiInputType = 9, _controlType = __ePAUIControl_RadioButton},
  UiProductionNote = {uiInputType = 10, _controlType = __ePAUIControl_RadioButton},
  UiManufacture = {uiInputType = 11, _controlType = __ePAUIControl_RadioButton},
  UiGuild = {uiInputType = 12, _controlType = __ePAUIControl_RadioButton},
  UiMail = {uiInputType = 13, _controlType = __ePAUIControl_RadioButton},
  UiFriendList = {uiInputType = 14, _controlType = __ePAUIControl_RadioButton},
  UiPresent = {uiInputType = 15, _controlType = __ePAUIControl_RadioButton},
  UiQuestHistory = {uiInputType = 16, _controlType = __ePAUIControl_RadioButton},
  UiCashShop = {uiInputType = 18, _controlType = __ePAUIControl_RadioButton},
  UiBeautyShop = {uiInputType = 19, _controlType = __ePAUIControl_RadioButton},
  UiAlchemyStone = {uiInputType = 20, _controlType = __ePAUIControl_RadioButton},
  UiHouse = {uiInputType = 21, _controlType = __ePAUIControl_RadioButton},
  UiWorker = {uiInputType = 22, _controlType = __ePAUIControl_RadioButton},
  UiPet = {uiInputType = 23, _controlType = __ePAUIControl_RadioButton},
  UiMaid = {uiInputType = 24, _controlType = __ePAUIControl_RadioButton},
  UiServant = {uiInputType = 25, _controlType = __ePAUIControl_RadioButton},
  UiGuildServant = {uiInputType = 26, _controlType = __ePAUIControl_RadioButton},
  UiDeleteNavigation = {uiInputType = 27, _controlType = __ePAUIControl_RadioButton},
  UiCameraSpeedUp = {uiInputType = 28, _controlType = __ePAUIControl_RadioButton},
  UiCameraSpeedDown = {uiInputType = 29, _controlType = __ePAUIControl_RadioButton},
  UiPositionNotify = {uiInputType = 30, _controlType = __ePAUIControl_RadioButton},
  UiInteraction1 = {uiInputType = 31, _controlType = __ePAUIControl_RadioButton},
  UiInteraction2 = {uiInputType = 32, _controlType = __ePAUIControl_RadioButton},
  UiInteraction3 = {uiInputType = 33, _controlType = __ePAUIControl_RadioButton},
  UiInteraction4 = {uiInputType = 34, _controlType = __ePAUIControl_RadioButton},
  UiInteraction5 = {uiInputType = 35, _controlType = __ePAUIControl_RadioButton},
  UiChatTabPrev = {uiInputType = 36, _controlType = __ePAUIControl_RadioButton},
  UiChatTabNext = {uiInputType = 37, _controlType = __ePAUIControl_RadioButton},
  UiAdventureBook = {uiInputType = 47, _controlType = __ePAUIControl_RadioButton},
  UiBlackGift = {uiInputType = 48, _controlType = __ePAUIControl_RadioButton},
  UiCallServantWater = {uiInputType = 49, _controlType = __ePAUIControl_RadioButton},
  UiBarterInfo = {uiInputType = 50, _controlType = __ePAUIControl_RadioButton},
  UiExpirienceWiki = {uiInputType = 53, _controlType = __ePAUIControl_RadioButton}
}
runLua("UI_Data/Script/Window/Option/NewUI/Panel_Window_GameOption_Header_All_1.lua")
runLua("UI_Data/Script/Window/Option/NewUI/Panel_Window_GameOption_Header_All_2.lua")
