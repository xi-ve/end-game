PaGlobal_Option = {
  UIMODE = {
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
  _tooltip = {
    ResetAll = {},
    SaveSetting = {},
    Apply = {},
    Cancel = {},
    Confirm = {},
    Home = {},
    CustomSave = {},
    ResetFrame = {}
  },
  _ui = {
    _staticMainTopBg = UI.getChildControl(Panel_Window_cOption, "Static_MainTopBg"),
    _staticSubTopBg = UI.getChildControl(Panel_Window_cOption, "Static_SubTopBg"),
    _staticMainBg = UI.getChildControl(Panel_Window_cOption, "Static_MainBg"),
    _staticSpecBG = nil,
    _staticCategoryBG = nil,
    _list2 = nil,
    _listSearchBg = UI.getChildControl(Panel_Window_cOption, "List2_Search"),
    _specDescTable = {},
    _categoryTitleTable = {},
    _categoryDescTable = {},
    _atFieldString = nil
  },
  _list2 = {
    _curCategory = nil,
    _curFrame = nil,
    _tree2IndexMap = {},
    _selectedKey = nil,
    _selectedSubKey = nil
  },
  _frames = {
    Performance = {
      Optimize = Panel_Performance_Optimize,
      GraphicQuality = Panel_Performance_GraphicQuality,
      Camera = Panel_Performance_Camera,
      Npc = Panel_Performance_Npc
    },
    Graphic = {
      Window = Panel_Graphic_Window,
      Quality = Panel_Graphic_Quality,
      Effect = Panel_Graphic_Effect,
      Camera = Panel_Graphic_Camera,
      ScreenShot = Panel_Graphic_ScreenShot,
      HDR = Panel_Graphic_HDR
    },
    Sound = {OnOff = Panel_Sound_OnOff, Volume = Panel_Sound_Volume},
    Function = {
      Convenience = Panel_Function_Convenience,
      View = Panel_Function_View,
      Alert = Panel_Function_Alert,
      Worldmap = Panel_Function_Worldmap,
      Nation = Panel_Function_Nation,
      Etc = Panel_Function_Etc
    },
    Interface = {
      Action = Panel_Interface_Action,
      UI = Panel_Interface_UI,
      QuickSlot = Panel_Interface_QuickSlot,
      Function = Panel_Interface_Function,
      Mouse = Panel_Interface_Mouse,
      Pad = Panel_Interface_Pad
    }
  },
  _functions = {},
  _searchElementTable = {},
  _elements = {
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
    SelfPlayerNameTagVisible = {_defaultValue = 0, _controlType = __ePAUIControl_RadioButton},
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
      _sliderValueMax = 100
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
    GraphicOption = {_defaultValue = 2, _controlType = __ePAUIControl_RadioButton},
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
      _sliderValueMax = 100
    },
    CropModeScaleY = {
      _defaultValue = 0.6,
      _controlType = __ePAUIControl_Slider,
      _sliderValueMin = 50,
      _sliderValueMax = 100
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
    EnableAudioFairy = {_defaultValue = 1, _controlType = __ePAUIControl_RadioButton},
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
      _settingRightNow = true
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
      _settingRightNow = true
    },
    VolumeHitFxWeight = {
      _defaultValue = 1,
      _controlType = __ePAUIControl_Slider,
      _sliderValueMin = 0,
      _sliderValueMax = 100,
      _settingRightNow = true
    },
    VolumeOtherPlayer = {
      _defaultValue = 1,
      _controlType = __ePAUIControl_Slider,
      _sliderValueMin = 0,
      _sliderValueMax = 100,
      _settingRightNow = true
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
  },
  _userInitScreenResolution = {width = 0, height = 0},
  _findStrings = {},
  _keyCustomPadMode = nil,
  _keyCustomInputType = nil,
  _resetCheck = nil,
  _availableResolutionList = nil,
  _screenResolutionCount = nil,
  _fpsTextControl = {},
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
  }
}
if true == isGameServiceTypeConsole() then
  PaGlobal_Option._elements.TextureQuality._defaultValue = 0
  PaGlobal_Option._elements.ConsolePadKeyType._defaultValue = 2
end
if true == isGameTypeKR2() then
  PaGlobal_Option._elements.WatermarkService._defaultValue = 6
end
isChecked_SkillCommand = true
function PaGlobal_Option:Get(optionName)
  local option = self._elements[optionName]
  if nil == option then
    return false
  end
  local value = option._initValue
  if nil ~= option._applyValue then
    value = option._applyValue
  end
  if nil == value then
    _PA_LOG("\237\155\132\236\167\132", "[GameOption][GET] \234\176\146\236\157\132 \236\150\187\236\150\180 \236\152\164\235\138\148\235\141\176 \236\139\164\237\140\168\237\150\136\236\138\181\235\139\136\235\139\164.  Name : " .. optionName)
  end
  return value
end
function PaGlobal_Option._functions.AimAssist(value)
  setAimAssist(value)
end
function PaGlobal_Option._functions.UseNewQuickSlot(value)
  ToClient_getGameUIManagerWrapper():setLuaCacheDataListBool(__eNewQuickSlot, value, CppEnums.VariableStorageType.eVariableStorageType_User)
end
function PaGlobal_Option._functions.EnableSimpleUI(value)
  local selfPlayer = getSelfPlayer()
  if nil ~= selfPlayer then
    if 5 < selfPlayer:get():getLevel() then
      setEnableSimpleUI(value)
    else
      setEnableSimpleUI(false)
    end
  else
    setEnableSimpleUI(false)
  end
end
function PaGlobal_Option._functions.IsOnScreenSaver(value)
  setIsOnScreenSaver(value)
end
function PaGlobal_Option._functions.UIFontSizeType(value)
  setUIFontSizeType(value)
  local addFontSize = convertUIFontTypeToUIFontSize(value)
  ToClient_getFontWrapper("BaseFont_10"):changeCurrentFontSizeBeMore(addFontSize)
  ToClient_getFontWrapper("BaseFont"):changeCurrentFontSizeBeMore(addFontSize)
  ToClient_getFontWrapper("BaseFont_Glow"):changeCurrentFontSizeBeMore(addFontSize)
  ToClient_getFontWrapper("BaseFont_10_Bold"):changeCurrentFontSizeBeMore(addFontSize)
  ToClient_getFontWrapper("BaseFont_10_Normal"):changeCurrentFontSizeBeMore(addFontSize)
  ToClient_getFontWrapper("BaseFont_10_Line"):changeCurrentFontSizeBeMore(addFontSize)
  ToClient_getFontWrapper("BaseFont_10_Glow"):changeCurrentFontSizeBeMore(addFontSize)
  ToClient_getFontWrapper("BaseFont_8"):changeCurrentFontSizeBeMore(addFontSize)
  ToClient_getFontWrapper("BaseFont_8_Bold"):changeCurrentFontSizeBeMore(addFontSize)
  ToClient_getFontWrapper("BaseFont_8_Line"):changeCurrentFontSizeBeMore(addFontSize)
  ToClient_getFontWrapper("BaseFont_8_Glow"):changeCurrentFontSizeBeMore(addFontSize)
  ToClient_getFontWrapper("BaseFont_7_Bold"):changeCurrentFontSizeBeMore(addFontSize)
  ToClient_getFontWrapper("BaseFont_6"):changeCurrentFontSizeBeMore(addFontSize)
  ToClient_getFontWrapper("BaseFont_12"):changeCurrentFontSizeBeMore(addFontSize)
  ToClient_getFontWrapper("BaseFont_12_Yellow"):changeCurrentFontSizeBeMore(addFontSize)
  ToClient_getFontWrapper("BaseFont_12_Bold"):changeCurrentFontSizeBeMore(addFontSize)
  ToClient_getFontWrapper("BaseFont_12_Glow"):changeCurrentFontSizeBeMore(addFontSize)
  ToClient_getFontWrapper("BaseFont_14_Bold"):changeCurrentFontSizeBeMore(addFontSize)
  ToClient_getFontWrapper("SubTitleFont_14"):changeCurrentFontSizeBeMore(addFontSize)
  ToClient_getFontWrapper("SubTitleFont_14_Bold"):changeCurrentFontSizeBeMore(addFontSize)
  ToClient_getFontWrapper("SubTitleFont_14_Glow"):changeCurrentFontSizeBeMore(addFontSize)
  ToClient_getFontWrapper("TitleFont_18"):changeCurrentFontSizeBeMore(addFontSize)
  ToClient_getFontWrapper("BaseFont_18_Glow"):changeCurrentFontSizeBeMore(addFontSize)
  ToClient_getFontWrapper("TitleFont_22"):changeCurrentFontSizeBeMore(addFontSize)
  ToClient_getFontWrapper("BaseFont_22_Glow"):changeCurrentFontSizeBeMore(addFontSize)
  ToClient_getFontWrapper("HeaderFont_26"):changeCurrentFontSizeBeMore(addFontSize)
  ToClient_getFontWrapper("BaseFont_26_Glow"):changeCurrentFontSizeBeMore(addFontSize)
end
function PaGlobal_Option._functions.UIFontType(value)
  ToClient_SetUIfontType(value)
end
function PaGlobal_Option._functions.ShowNavPathEffectType(value)
  setShowNavPathEffectType(value)
end
function PaGlobal_Option._functions.AutoNaviMoveType(value)
  ToClient_SetAutomaticGuideSmooth(value)
end
function PaGlobal_Option._functions.AutoNaviMoveTypeAtGround(value)
  ToClient_SetAutomaticGuideSmoothAtGround(value)
end
function PaGlobal_Option._functions.RefuseRequests(value)
  setRefuseRequests(value)
end
function PaGlobal_Option._functions.IsPvpRefuse(value)
  setIsPvpRefuse(value)
end
function PaGlobal_Option._functions.IsExchangeRefuse(value)
  setIsExchangeRefuse(value)
end
function PaGlobal_Option._functions.RotateRadarMode(value)
  setRotateRadarMode(value)
end
function PaGlobal_Option._functions.HideWindowByAttacked(value)
  setHideWindowByAttacked(value)
end
function PaGlobal_Option._functions.ShowRightBottomAlarm(value)
  setShowRightBottomAlarm(value)
end
function PaGlobal_Option._functions.AutoRunCamera(value)
  setAutoRunCamera(value)
end
function PaGlobal_Option._functions.AutoRunCameraRotation(value)
  setAutoRunCameraRotation(value)
end
function PaGlobal_Option._functions.AudioResourceType(value)
  setAudioResourceType(PaGlobal_Option:radioButtonMapping_AudioResourceType(value))
end
function PaGlobal_Option._functions.ServiceResourceType(value)
  if false == ToClient_isAvailableChangeServiceType() then
    return
  end
  ToClient_saveServiceResourceType(PaGlobal_Option:radioButtonMapping_ServiceResourceType(value))
end
function PaGlobal_Option._functions.UseChattingFilter(value)
  setUseChattingFilter(value)
end
function PaGlobal_Option._functions.ChatChannelType(value)
  if false == ToClient_isAvailableChangeServiceType() then
    return
  end
  local chatType = PaGlobal_Option:radioButtonMapping_ChatChannelType(value)
  ToClient_saveChatChannelType(chatType)
  if CppEnums.LangType.LangType_AE == chatType then
    ToClient_setUseHarfBuzz(true)
    if nil ~= FGlobal_ChattingcheckArabicType then
      FGlobal_ChattingcheckArabicType(true)
    end
  else
    ToClient_setUseHarfBuzz(false)
    if nil ~= FGlobal_ChattingcheckArabicType then
      FGlobal_ChattingcheckArabicType(false)
    end
  end
end
function PaGlobal_Option._functions.SelfPlayerNameTagVisible(value)
  setSelfPlayerNameTagVisible(value)
end
function PaGlobal_Option._functions.OtherPlayerNameTagVisible(value)
  if true == value then
    value = CppEnums.VisibleNameTagType.eVisibleNameTagType_AllwaysShow
  else
    value = CppEnums.VisibleNameTagType.eVisibleNameTagType_ImportantShow
  end
  setOtherPlayerNameTagVisible(value)
end
function PaGlobal_Option._functions.PartyPlayerNameTagVisible(value)
  if true == value then
    value = CppEnums.VisibleNameTagType.eVisibleNameTagType_AllwaysShow
  else
    value = CppEnums.VisibleNameTagType.eVisibleNameTagType_ImportantShow
  end
  setPartyPlayerNameTagVisible(value)
end
function PaGlobal_Option._functions.GuildPlayerNameTagVisible(value)
  if true == value then
    value = CppEnums.VisibleNameTagType.eVisibleNameTagType_AllwaysShow
  else
    value = CppEnums.VisibleNameTagType.eVisibleNameTagType_ImportantShow
  end
  setGuildPlayerNameTagVisible(value)
end
function PaGlobal_Option._functions.RankingPlayerNameTagVisible(value)
  if true == value then
    value = CppEnums.VisibleNameTagType.eVisibleNameTagType_AllwaysShow
  else
    value = CppEnums.VisibleNameTagType.eVisibleNameTagType_NoShow
  end
  setRankingPlayerNameTagVisible(value)
end
function PaGlobal_Option._functions.GuideLineZoneChange(value)
  setRenderPlayerColor("ZoneChange", value)
end
function PaGlobal_Option._functions.GuideLineQuestNPC(value)
  setShowQuestActorColor(value)
end
function PaGlobal_Option._functions.GuideLineNpcIntimacy(value)
  setShowHumanRelation(value)
end
function PaGlobal_Option._functions.GuideLineWarAlly(value)
  setRenderPlayerColor("WarAlly", value)
end
function PaGlobal_Option._functions.GuideLineNonWarPlayer(value)
  setRenderPlayerColor("NonWarPlayer", value)
end
function PaGlobal_Option._functions.GuideLineEnemy(value)
  setRenderPlayerColor("Enemy", value)
end
function PaGlobal_Option._functions.GuideLineGuild(value)
  setRenderPlayerColor("Guild", value)
end
function PaGlobal_Option._functions.GuideLineParty(value)
  setRenderPlayerColor("Party", value)
end
function PaGlobal_Option._functions.GuideLinePartyMemberEffect(value)
  ToClient_getGameOptionControllerWrapper():setRenderHitEffectParty(value)
end
function PaGlobal_Option._functions.PetRender(value)
  setPetRender(value)
end
function PaGlobal_Option._functions.FairyRender(value)
  if 0 == value then
    setFairyRender(true)
  else
    setFairyRender(false)
  end
end
function PaGlobal_Option._functions.TentRender(value)
  if 0 == value then
    setHideOtherPlayerTent(false)
  else
    setHideOtherPlayerTent(true)
  end
end
function PaGlobal_Option._functions.MaidView(value)
  local maidViewElement = PaGlobal_Option._elements.MaidView
  local maxMaidValue = maidViewElement._sliderValueMax
  setMaidView(value * maxMaidValue)
end
function PaGlobal_Option._functions.ShowReputation(value)
  if false == _ContentsGroup_StatTierIcon then
    return
  end
  return setShowStatTier(value)
end
function PaGlobal_Option._functions.RenderHitEffect(value)
  setRenderHitEffect(value)
  FGlobal_SetMamageShow()
end
function PaGlobal_Option._functions.DamageMeter(value)
  setOnDamageMeter(value)
end
function PaGlobal_Option._functions.ShowComboGuide(value)
  setShowComboGuide(value)
  if nil ~= Panel_MovieTheater_320 then
    Panel_MovieTheater320_JustClose()
  end
end
function PaGlobal_Option._functions.HideMastOnCarrier(value)
  setHideMastOnCarrier(value)
end
function PaGlobal_Option._functions.WorkerVisible(value)
  ToClient_setWorkerVisible(value)
end
function PaGlobal_Option._functions.WorldMapOpenType(value)
  setWorldmapOpenType(value)
end
function PaGlobal_Option._functions.WorldmapCameraPitchType(value)
  setWorldMapCameraPitchType(value)
end
function PaGlobal_Option._functions.TextureQuality(value)
  setTextureQuality(PaGlobal_Option:radioButtonMapping_TextureQuality(value))
end
function PaGlobal_Option._functions.AntiAliasing(value)
  setAntiAliasingIndex(value)
end
function PaGlobal_Option._functions.GraphicOption(value)
  setGraphicOption(PaGlobal_Option:radioButtonMapping_GraphicOption(value))
end
function PaGlobal_Option._functions.SSAO(value)
  setSSAO(value)
end
function PaGlobal_Option._functions.PostFilter(value)
  if true == value then
    setPostFilter(2)
  else
    setPostFilter(1)
  end
end
function PaGlobal_Option._functions.Tessellation(value)
  setTessellation(value)
end
function PaGlobal_Option._functions.Dof(value)
  setDof(value)
end
function PaGlobal_Option._functions.Representative(value)
  setRepresentative(value)
end
function PaGlobal_Option._functions.CharacterEffect(value)
  setCharacterEffect(value)
end
function PaGlobal_Option._functions.SnowPoolOnlyInSafeZone(value)
  setSnowPoolOnlyInSafeZone(value)
end
function PaGlobal_Option._functions.BloodEffect(value)
  if true == value then
    setBloodEffect(2)
  else
    setBloodEffect(0)
  end
end
function PaGlobal_Option._functions.LensBlood(value)
  setLensBlood(value)
end
function PaGlobal_Option._functions.AutoOptimization(value)
  setAutoOptimization(value)
end
function PaGlobal_Option._functions.AutoOptimizationFrameLimit(value)
  local convertedFrame = math.ceil(value * 60)
  local autoOptimization = PaGlobal_Option._elements.AutoOptimization
  local check = autoOptimization._initValue
  if nil ~= autoOptimization._curValue then
    check = autoOptimization._curValue
  elseif nil ~= autoOptimization._applyValue then
    check = autoOptimization._applyValue
  end
  if true == check then
    setAutoOptimizationFrameLimit(convertedFrame)
  end
end
function PaGlobal_Option._functions.UpscaleEnable(value)
  setUpscaleEnable(value)
end
function PaGlobal_Option._functions.PresentLock(value)
  setPresentLock(value)
end
function PaGlobal_Option._functions.DataOptimize(value)
  ToClient_SetUseDynamicBSS(true ~= value)
end
function PaGlobal_Option._functions.UseEffectFrameOptimization(value)
  setUseOptimizationEffectFrame(value)
end
function PaGlobal_Option._functions.EffectFrameOptimization(value)
  local convertedFrame = value * 24.9 + 0.1
  local useEffectFrameOptimization = PaGlobal_Option._elements.UseEffectFrameOptimization
  local check = useEffectFrameOptimization._initValue
  if nil ~= useEffectFrameOptimization._curValue then
    check = useEffectFrameOptimization._curValue
  elseif nil ~= useEffectFrameOptimization._applyValue then
    check = useEffectFrameOptimization._applyValue
  end
  if true == check then
    setEffectFrameEffectOptimization(convertedFrame)
  end
end
function PaGlobal_Option._functions.UsePlayerEffectDistOptimization(value)
  setUsePlayerOptimizationEffectFrame(value)
end
function PaGlobal_Option._functions.PlayerEffectDistOptimization(value)
  local convertedFrame = value * 40 + 10
  local usePlayerEffectDistOptimization = PaGlobal_Option._elements.UsePlayerEffectDistOptimization
  local check = usePlayerEffectDistOptimization._initValue
  if nil ~= usePlayerEffectDistOptimization._curValue then
    check = usePlayerEffectDistOptimization._curValue
  elseif nil ~= usePlayerEffectDistOptimization._applyValue then
    check = usePlayerEffectDistOptimization._applyValue
  end
  if true == check then
    setPlayerEffectFrameEffectOptimization(convertedFrame * 100)
  end
end
function PaGlobal_Option._functions.UseCharacterUpdateFrameOptimize(value)
  setUseCharacterDistUpdate(value)
end
function PaGlobal_Option._functions.UseOtherPlayerUpdate(value)
  FromClient_OtherPlayeUpdate(value, true)
end
function PaGlobal_Option._functions.ShowSpawnableNPC(value)
  setUseShowSpawnableNPCUpdate(value)
end
function PaGlobal_Option._functions.Fov(value)
  value = value * 30 + 40
  setFov(value)
end
function PaGlobal_Option._functions.CameraEffectMaster(value)
  setCameraMasterPower(value)
end
function PaGlobal_Option._functions.CameraShakePower(value)
  setCameraShakePower(value)
end
function PaGlobal_Option._functions.MotionBlurPower(value)
  setMotionBlurPower(value)
end
function PaGlobal_Option._functions.CameraTranslatePower(value)
  setCameraTranslatePower(value)
end
function PaGlobal_Option._functions.CameraFovPower(value)
  setCameraFovPower(value)
end
function PaGlobal_Option._functions.MouseInvertX(value)
  setMouseInvertX(value)
end
function PaGlobal_Option._functions.MouseInvertY(value)
  setMouseInvertY(value)
end
function PaGlobal_Option._functions.MouseSensitivityX(value)
  local convertedValue = value * 1.9 + 0.1
  setMouseSensitivityX(convertedValue)
end
function PaGlobal_Option._functions.MouseSensitivityY(value)
  local convertedValue = value * 1.9 + 0.1
  setMouseSensitivityY(convertedValue)
end
function PaGlobal_Option._functions.GameMouseMode(value)
  setGameMouseMode(value)
end
function PaGlobal_Option._functions.IsUIModeMouseLock(value)
  setIsUIModeMouseLock(value)
end
function PaGlobal_Option._functions.GamePadEnable(value)
  setGamePadEnable(value)
end
function PaGlobal_Option._functions.GamePadVibration(value)
  setGamePadVibration(value)
end
function PaGlobal_Option._functions.GamePadInvertX(value)
  setGamePadInvertX(value)
end
function PaGlobal_Option._functions.GamePadInvertY(value)
  setGamePadInvertY(value)
end
function PaGlobal_Option._functions.GamePadSensitivityX(value)
  local convertedValue = value * 1.8 + 0.2
  setGamePadSensitivityX(convertedValue)
end
function PaGlobal_Option._functions.GamePadSensitivityY(value)
  local convertedValue = value * 1.8 + 0.2
  setGamePadSensitivityY(convertedValue)
end
function PaGlobal_Option._functions.ConsolePadKeyType(value)
  if true == _ContentsGroup_isConsoleTest then
    setConsoleKeyType(value)
  end
end
function PaGlobal_Option._functions.ScreenShotQuality(value)
  setScreenShotQuality(value)
end
function PaGlobal_Option._functions.ScreenShotFormat(value)
  setScreenShotFormat(value)
end
function PaGlobal_Option._functions.WatermarkAlpha(value)
  setWatermarkAlpha(value)
end
function PaGlobal_Option._functions.WatermarkScale(value)
  setWatermarkScale(value)
end
function PaGlobal_Option._functions.WatermarkPosition(value)
  setWatermarkPosition(value)
end
function PaGlobal_Option._functions.WatermarkService(value)
  setWatermarkService(value)
end
function PaGlobal_Option._functions.ScreenMode(value)
  setScreenMode(value)
  ischangedeplay = true
end
function PaGlobal_Option._functions.ScreenResolution(value)
  local width = 1280
  local height = 720
  if -1 == value then
    width = PaGlobal_Option._userInitScreenResolution.width
    height = PaGlobal_Option._userInitScreenResolution.height
  else
    width = PaGlobal_Option._availableResolutionList:getDisplayModeWidth(value)
    height = PaGlobal_Option._availableResolutionList:getDisplayModeHeight(value)
  end
  setScreenResolution(width, height)
end
function PaGlobal_Option._functions.CropModeEnable(value)
  setCropModeEnable(value)
end
function PaGlobal_Option._functions.CropModeScaleX(value)
  local convertedScale = 0.5 + value * 0.5
  local cropModeEnable = PaGlobal_Option:Get("CropModeEnable")
  local cropModeScaleX = convertedScale
  local cropModeScaleY = PaGlobal_Option:Get("CropModeScaleY")
  if 0.95 < cropModeScaleX and 0.95 < cropModeScaleY and true == cropModeEnable then
    PaGlobal_Option:SetXXX("CropModeEnable", false)
  end
  if true == cropModeEnable then
    setCropModeScaleX(convertedScale)
  end
end
function PaGlobal_Option._functions.CropModeScaleY(value)
  local convertedScale = 0.5 + value * 0.5
  local cropModeEnable = PaGlobal_Option:Get("CropModeEnable")
  local cropModeScaleX = PaGlobal_Option:Get("CropModeScaleX")
  local cropModeScaleY = convertedScale
  if 0.95 < cropModeScaleX and 0.95 < cropModeScaleY and true == cropModeEnable then
    PaGlobal_Option:SetXXX("CropModeEnable", false)
  end
  if true == cropModeEnable then
    setCropModeScaleY(convertedScale)
  end
end
function PaGlobal_Option._functions.UIScale(value)
  local interval = PaGlobal_Option._elements.UIScale._sliderValueMax - PaGlobal_Option._elements.UIScale._sliderValueMin
  local convertedValue = (PaGlobal_Option._elements.UIScale._sliderValueMin + interval * value) * 0.01
  convertedValue = math.floor((convertedValue + 0.002) * 100) / 100
  setUIScale(convertedValue)
end
function PaGlobal_Option._functions.GammaValue(value)
  setGammaValue(value)
end
function PaGlobal_Option._functions.ContrastValue(value)
  if true == PaGlobal_Option._isContrast then
    local controlName = "Button_LUT"
    local controlIndex = 1
    local order = 1
    PaGlobal_Option:EventXXX(controlName, controlIndex, order)
    PaGlobal_Option._isContrast = false
  end
  setContrastValue(value)
  PaGlobal_Option._contrastValue = PaGlobal_Option:FromRealValueToSliderValue(value, 0, 1)
end
function PaGlobal_Option._functions.EffectAlpha(value)
  value = PaGlobal_Option:FromSliderValueToRealValue(value, PaGlobal_Option._elements.EffectAlpha._sliderValueMin, PaGlobal_Option._elements.EffectAlpha._sliderValueMax)
  value = value * 0.01
  setEffectAlpha(value)
end
function PaGlobal_Option._functions.SkillPostEffect(value)
  setSkillPostEffect(value)
end
function PaGlobal_Option._functions.ColorBlind(value)
  ToClient_getGameUIManagerWrapper():setLuaCacheDataListNumber(__eColorBlindMode, value, CppEnums.VariableStorageType.eVariableStorageType_User)
  ToClient_ChangeColorBlindMode(value)
  FGlobal_Radar_SetColorBlindMode()
  FGlobal_Window_Servant_ColorBlindUpdate()
  if false == _ContentsGroup_RemasterUI_Main_Alert then
    FGlobal_ChangeEffectCheck()
    UIMain_QuestUpdate()
  end
end
function PaGlobal_Option._functions.BlackSpiritNotice(value)
  setBlackSpiritNotice(value)
end
function PaGlobal_Option._functions.ShowCashAlert(value)
  setShowCashAlert(not value)
end
function PaGlobal_Option._functions.ShowGuildLoginMessage(value)
  setShowGuildLoginMessage(value)
end
function PaGlobal_Option._functions.LUT(LUT)
  local strsplit = string.split("Slider_ContrastValue", "_")
  local controlTypeName = strsplit[1]
  local elementName = strsplit[2]
  if 1 == LUT and false == PaGlobal_Option._isExit then
    if false == PaGlobal_Option._isContrast then
      local messageBoxMemo = PAGetString(Defines.StringSheet_GAME, "LUA_GAMEOPTION_POPUP_NONCONTRAST")
      local messageBoxData = {
        title = PAGetString(Defines.StringSheet_GAME, "LUA_WARNING"),
        content = messageBoxMemo,
        functionYes = MessageBox_Empty_function,
        priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
      }
      MessageBox.showMessageBox(messageBoxData)
    end
    PaGlobal_Option._elements[elementName]._curvalueControl[1]:SetText(PaGlobal_Option._sliderButtonString .. 0 .. "<PAOldColor>")
    PaGlobal_Option._elements[elementName]._eventControl[1]:SetControlPos(50)
    PaGlobal_Option._isContrast = true
  else
    local value = math.floor((PaGlobal_Option._contrastValue + 0.005) * 100)
    PaGlobal_Option._elements[elementName]._curvalueControl[1]:SetText(PaGlobal_Option._sliderButtonString .. value - 50 .. "<PAOldColor>")
    PaGlobal_Option._elements[elementName]._eventControl[1]:SetControlPos(value)
    PaGlobal_Option._isContrast = false
  end
  setCameraLUTFilter(LUT)
end
function PaGlobal_Option._elements.LUT:GetButtonText(LUT)
  local filterName = getCameraLUTFilterName(LUT)
  local filterString = PAGetString(Defines.StringSheet_GAME, "LUA_GAMEOPTION_PHOTOFILTER_" .. filterName)
  if filterName == LUTRecommandationName or filterName == LUTRecommandationName2 then
    filterString = filterString .. "  <PAColor0xffffce22>[" .. PAGetString(Defines.StringSheet_GAME, "LUA_OPTION_RECOMMANDATION") .. "]<PAOldColor>"
  end
  return filterString
end
function PaGlobal_Option._elements.LUT:GetButtonListSize(value)
  return getCameraLUTFilterSize()
end
function PaGlobal_Option._functions.EnableMusic(value)
  setEnableSoundMusic(value)
end
function PaGlobal_Option._functions.EnableSound(value)
  setEnableSoundFx(value)
end
function PaGlobal_Option._functions.EnableEnv(value)
  setEnableSoundEnv(value)
end
function PaGlobal_Option._functions.EnableRidingSound(value)
  setEnableRidingSound(value)
end
function PaGlobal_Option._functions.EnableWhisperMusic(value)
  setEnableSoundWhisper(value)
end
function PaGlobal_Option._functions.EnableTraySoundOnOff(value)
  setEnableSoundTray(value)
end
function PaGlobal_Option._functions.EnableAroundPlayMusic(value)
  setEnableAroundPlayMusic(value)
end
function PaGlobal_Option._functions.BattleSoundType(value)
  setEnableBattleSoundType(value)
end
function PaGlobal_Option._functions.EnableAudioFairy(value)
  setEnableFairySound(value)
end
function PaGlobal_Option._functions.VolumeMaster(value)
  setVolumeParamMaster(value * 100)
end
function PaGlobal_Option._functions.VolumeMusicPlay(value)
  setVolumeParamAroundPlayMusic(value * 100)
end
function PaGlobal_Option._functions.VolumeMusic(value)
  setVolumeParamMusic(value * 100)
end
function PaGlobal_Option._functions.VolumeFx(value)
  setVolumeParamFx(value * 100)
end
function PaGlobal_Option._functions.VolumeEnv(value)
  setVolumeParamEnv(value * 100)
end
function PaGlobal_Option._functions.VolumeDlg(value)
  setVolumeParamDialog(value * 100)
end
function PaGlobal_Option._functions.VolumeHitFxVolume(value)
  setVolumeParamHitFxVolume(value * 100)
end
function PaGlobal_Option._functions.VolumeHitFxWeight(value)
  setVolumeParamHitFxWeight(value * 100)
end
function PaGlobal_Option._functions.VolumeOtherPlayer(value)
  setVolumeParamOtherPlayer(value * 100)
end
function PaGlobal_Option._functions.VolumeFairy(value)
  setVolumeFairy(value * 100)
end
function PaGlobal_Option._functions.AlertNormalTrade(value)
  ToClient_SetMessageFilter(PaGlobal_Option.ALERT.NormalTrade, not value)
end
function PaGlobal_Option._functions.AlertRoyalTrade(value)
  ToClient_SetMessageFilter(PaGlobal_Option.ALERT.RoyalTrade, not value)
end
function PaGlobal_Option._functions.AlertOtherPlayerGetItem(value)
  ToClient_SetMessageFilter(PaGlobal_Option.ALERT.OtherPlayerGetItem, not value)
end
function PaGlobal_Option._functions.AlertLifeLevelUp(value)
  ToClient_SetMessageFilter(PaGlobal_Option.ALERT.LifeLevelUp, not value)
end
function PaGlobal_Option._functions.AlertItemMarket(value)
  ToClient_SetMessageFilter(PaGlobal_Option.ALERT.ItemMarket, not value)
end
function PaGlobal_Option._functions.AlertOtherMarket(value)
  ToClient_SetMessageFilter(PaGlobal_Option.ALERT.OtherMarket, not value)
end
function PaGlobal_Option._functions.AlertChangeRegion(value)
  ToClient_SetMessageFilter(PaGlobal_Option.ALERT.ChangeRegion, not value)
end
function PaGlobal_Option._functions.AlertFitnessLevelUp(value)
  ToClient_SetMessageFilter(PaGlobal_Option.ALERT.FitnessLevelUp, not value)
end
function PaGlobal_Option._functions.AlertTerritoryWar(value)
  ToClient_SetMessageFilter(PaGlobal_Option.ALERT.TerritoryWar, not value)
end
function PaGlobal_Option._functions.AlertGuildWar(value)
  ToClient_SetMessageFilter(PaGlobal_Option.ALERT.GuildWar, not value)
end
function PaGlobal_Option._functions.AlertEnchantSuccess(value)
  ToClient_SetMessageFilter(PaGlobal_Option.ALERT.EnchantSuccess, not value)
end
function PaGlobal_Option._functions.AlertEnchantFail(value)
  ToClient_SetMessageFilter(PaGlobal_Option.ALERT.EnchantFail, not value)
end
function PaGlobal_Option._functions.AlertGuildQuestMessage(value)
  ToClient_SetMessageFilter(PaGlobal_Option.ALERT.GuildQuestMessage, not value)
end
function PaGlobal_Option._functions.AlertNearMonster(value)
  ToClient_SetMessageFilter(PaGlobal_Option.ALERT.NearMonster, not value)
end
function PaGlobal_Option._functions.SelfPlayerOnlyEffect(value)
  setSelfPlayerOnlyEffect(value)
end
function PaGlobal_Option._functions.NearestPlayerOnlyEffect(value)
  setNearestPlayerOnlyEffect(value)
end
function PaGlobal_Option._functions.SelfPlayerOnlyLantern(value)
  setSelfPlayerOnlyLantern(value)
end
function PaGlobal_Option._functions.ShowStackHp(value)
  if true == _ContentsGroup_StackingHpBar then
    setShowStackHp(GameOptionApply_CharacterNameTag_StackHpBar(value))
  end
end
function ConsolePadType(value)
  selfPlayerSetConsolePadType(value)
end
function PaGlobal_Option._functions.HDRDisplayGamma(value)
  value = PaGlobal_Option:FromSliderValueToRealValue(value, PaGlobal_Option._elements.HDRDisplayGamma._sliderValueMin, PaGlobal_Option._elements.HDRDisplayGamma._sliderValueMax)
  setHdrDisplayGamma(value)
end
function PaGlobal_Option._functions.HDRDisplayMaxNits(value)
  value = PaGlobal_Option:FromSliderValueToRealValue(value, PaGlobal_Option._elements.HDRDisplayMaxNits._sliderValueMin, PaGlobal_Option._elements.HDRDisplayMaxNits._sliderValueMax)
  setHdrDisplayMaxNits(value)
end
function PaGlobal_Option._functions.UltraHighDefinition(value)
  _PA_LOG("\237\155\132\236\167\132", "UltraHighDefinition value : " .. tostring(value))
  setUltraHighDefinition(value)
end
function PaGlobal_Option._functions.UseLedAnimation(value)
  setUseLedAnimation(value)
end
