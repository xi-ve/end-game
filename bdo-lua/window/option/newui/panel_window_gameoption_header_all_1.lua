PaGlobal_GameOption_All._frameOrder = {
  inGame = {
    consoleTest = {
      main = {
        "Graphic",
        "Function",
        "Interface",
        "Sound"
      },
      sub = {
        [1] = {"HDR"},
        [2] = {"Alert", "Etc"},
        [3] = {"Pad"},
        [4] = {"Volume"}
      }
    },
    china = {
      main = {
        "Performance",
        "Graphic",
        "Sound",
        "Function",
        "Interface"
      },
      sub = {
        [1] = {
          "GraphicQuality",
          "Optimize",
          "Camera",
          "Npc"
        },
        [2] = {
          "Window",
          "Quality",
          "Effect",
          "Camera",
          "ScreenShot"
        },
        [3] = {"Volume"},
        [4] = {
          "Convenience",
          "View",
          "Alert",
          "Worldmap",
          "Etc"
        },
        [5] = {
          "Action",
          "UI",
          "QuickSlot",
          "Function",
          "Mouse",
          "Pad"
        }
      }
    },
    default = {
      main = {
        "Performance",
        "Graphic",
        "Sound",
        "Function",
        "Interface"
      },
      sub = {
        [1] = {
          "GraphicQuality",
          "Optimize",
          "Camera",
          "Npc"
        },
        [2] = {
          "Window",
          "Quality",
          "Effect",
          "Camera",
          "ScreenShot"
        },
        [3] = {"Volume"},
        [4] = {
          "Convenience",
          "View",
          "Alert",
          "Worldmap",
          "Nation",
          "Etc"
        },
        [5] = {
          "Action",
          "UI",
          "QuickSlot",
          "Function",
          "Mouse",
          "Pad"
        }
      }
    }
  },
  login = {
    consoleTest = {
      main = {"Sound", "Graphic"},
      sub = {
        [1] = {"Volume"},
        [2] = {"HDR"}
      }
    },
    china = {
      main = {
        "Performance",
        "Graphic",
        "Sound"
      },
      sub = {
        [1] = {
          "GraphicQuality",
          "Optimize",
          "Camera",
          "Npc"
        },
        [2] = {
          "Window",
          "Quality",
          "Effect",
          "Camera",
          "ScreenShot"
        },
        [3] = {"Volume"}
      }
    },
    default = {
      main = {
        "Performance",
        "Graphic",
        "Sound",
        "Function"
      },
      sub = {
        [1] = {
          "GraphicQuality",
          "Optimize",
          "Camera",
          "Npc"
        },
        [2] = {
          "Window",
          "Quality",
          "Effect",
          "Camera",
          "ScreenShot"
        },
        [3] = {"Volume"},
        [4] = {"Nation"}
      }
    }
  }
}
PaGlobal_GameOption_All._frames = {
  Performance = {
    GraphicQuality = {
      _title = "PANEL_NEWGAMEOPTION_PERFORMANCE_GRAPHICQUALITY_DESC",
      {
        _element = PaGlobal_GameOption_All._elements.TextureQuality
      },
      {
        _element = PaGlobal_GameOption_All._elements.GraphicOption
      },
      {
        _element = PaGlobal_GameOption_All._elements.AntiAliasing
      },
      {
        _element = PaGlobal_GameOption_All._elements.SSAO
      },
      {
        _element = PaGlobal_GameOption_All._elements.PostFilter
      },
      {
        _element = PaGlobal_GameOption_All._elements.Tessellation
      },
      {
        _element = PaGlobal_GameOption_All._elements.Dof
      },
      {
        _element = PaGlobal_GameOption_All._elements.Representative
      },
      {
        _element = PaGlobal_GameOption_All._elements.CharacterEffect
      },
      {
        _element = PaGlobal_GameOption_All._elements.SnowPoolOnlyInSafeZone
      }
    },
    Optimize = {
      _title = "PANEL_NEWGAMEOPTION_PERFORMANCE_OPTIMIZE_DESC",
      {
        _element = PaGlobal_GameOption_All._elements.AutoOptimization
      },
      {
        _element = PaGlobal_GameOption_All._elements.AutoOptimizationFrameLimit
      },
      {
        _element = PaGlobal_GameOption_All._elements.UpscaleEnable
      },
      {
        _element = PaGlobal_GameOption_All._elements.PresentLock
      },
      {
        _element = PaGlobal_GameOption_All._elements.RenderHitEffect
      },
      {
        _element = PaGlobal_GameOption_All._elements.DataOptimize
      },
      {
        _element = PaGlobal_GameOption_All._elements.UseEffectFrameOptimization
      },
      {
        _element = PaGlobal_GameOption_All._elements.EffectFrameOptimization
      },
      {
        _element = PaGlobal_GameOption_All._elements.UsePlayerEffectDistOptimization
      },
      {
        _element = PaGlobal_GameOption_All._elements.PlayerEffectDistOptimization
      },
      {
        _element = PaGlobal_GameOption_All._elements.UseOtherPlayerUpdate
      }
    },
    Camera = {
      _title = "PANEL_NEWGAMEOPTION_PERFORMANCE_CAMERA_DESC",
      {
        _element = PaGlobal_GameOption_All._elements.Fov
      },
      {
        _element = PaGlobal_GameOption_All._elements.CameraEffectMaster
      }
    },
    Npc = {
      _title = "PANEL_NEWGAMEOPTION_PERFORMANCE_NPC_DESC",
      {
        _element = PaGlobal_GameOption_All._elements.WorkerVisible
      },
      {
        _element = PaGlobal_GameOption_All._elements.PetRender
      },
      {
        _element = PaGlobal_GameOption_All._elements.ShowSpawnableNPC,
        _contentsOption = _ContentsGroup_NPCSpawnOption
      }
    }
  },
  Graphic = {
    Window = {
      _title = "PANEL_NEWGAMEOPTION_GRAPHIC_WINDOW_DESC",
      {
        _element = PaGlobal_GameOption_All._elements.ScreenMode
      },
      {
        _element = PaGlobal_GameOption_All._elements.ScreenResolution
      },
      {
        _element = PaGlobal_GameOption_All._elements.UIScale
      },
      {
        _element = PaGlobal_GameOption_All._elements.CropModeEnable
      },
      {
        _element = PaGlobal_GameOption_All._elements.CropModeScaleX
      },
      {
        _element = PaGlobal_GameOption_All._elements.CropModeScaleY
      }
    },
    Quality = {
      _title = "PANEL_NEWGAMEOPTION_GRAPHIC_QUALITY_DESC",
      {
        _element = PaGlobal_GameOption_All._elements.TextureQuality
      },
      {
        _element = PaGlobal_GameOption_All._elements.GraphicOption
      },
      {
        _element = PaGlobal_GameOption_All._elements.AntiAliasing
      },
      {
        _element = PaGlobal_GameOption_All._elements.SSAO
      },
      {
        _element = PaGlobal_GameOption_All._elements.PostFilter
      },
      {
        _element = PaGlobal_GameOption_All._elements.Tessellation
      },
      {
        _element = PaGlobal_GameOption_All._elements.Dof
      },
      {
        _element = PaGlobal_GameOption_All._elements.Representative
      },
      {
        _element = PaGlobal_GameOption_All._elements.CharacterEffect
      },
      {
        _element = PaGlobal_GameOption_All._elements.SnowPoolOnlyInSafeZone
      },
      {
        _element = PaGlobal_GameOption_All._elements.BloodEffect
      },
      {
        _element = PaGlobal_GameOption_All._elements.LensBlood
      },
      {
        _subTitle = "PANEL_NEWGAMEOPTION_GRAPHIC_QUALITY_OPTIMIZETITLE"
      },
      {
        _element = PaGlobal_GameOption_All._elements.AutoOptimization
      },
      {
        _element = PaGlobal_GameOption_All._elements.AutoOptimizationFrameLimit
      },
      {
        _element = PaGlobal_GameOption_All._elements.SelfPlayerOnlyEffect
      },
      {
        _element = PaGlobal_GameOption_All._elements.NearestPlayerOnlyEffect
      },
      {
        _element = PaGlobal_GameOption_All._elements.UpscaleEnable
      },
      {
        _element = PaGlobal_GameOption_All._elements.PresentLock
      }
    },
    Effect = {
      _title = "PANEL_NEWGAMEOPTION_GRAPHIC_EFFECT_DESC",
      {
        _element = PaGlobal_GameOption_All._elements.LUT
      },
      {
        _element = PaGlobal_GameOption_All._elements.GammaValue
      },
      {
        _element = PaGlobal_GameOption_All._elements.ContrastValue
      },
      {
        _element = PaGlobal_GameOption_All._elements.EffectAlpha
      },
      {
        _element = PaGlobal_GameOption_All._elements.SkillPostEffect
      },
      {
        _element = PaGlobal_GameOption_All._elements.ColorBlind
      }
    },
    Camera = {
      _title = "PANEL_NEWGAMEOPTION_GRAPHIC_DESC",
      {
        _element = PaGlobal_GameOption_All._elements.Fov
      },
      {
        _subTitle = "PANEL_NEWGAMEOPTION_GRAPHIC_CAMERAEFFECT_TITLE"
      },
      {
        _element = PaGlobal_GameOption_All._elements.CameraEffectMaster
      },
      {
        _element = PaGlobal_GameOption_All._elements.CameraShakePower
      },
      {
        _element = PaGlobal_GameOption_All._elements.MotionBlurPower
      },
      {
        _element = PaGlobal_GameOption_All._elements.CameraTranslatePower
      },
      {
        _element = PaGlobal_GameOption_All._elements.CameraFovPower
      }
    },
    ScreenShot = {
      _title = "PANEL_NEWGAMEOPTION_GRAPHIC_SCREENSHOT_DESC",
      {
        _element = PaGlobal_GameOption_All._elements.ScreenShotQuality
      },
      {
        _element = PaGlobal_GameOption_All._elements.ScreenShotFormat
      },
      {
        _element = PaGlobal_GameOption_All._elements.WatermarkAlpha
      },
      {
        _element = PaGlobal_GameOption_All._elements.WatermarkScale
      },
      {
        _element = PaGlobal_GameOption_All._elements.WatermarkPosition
      },
      {
        _element = PaGlobal_GameOption_All._elements.WatermarkService
      }
    }
  },
  Sound = {
    Volume = {
      _title = "PANEL_NEWGAMEOPTION_SOUND_VOLUME_DESC",
      {
        _element = PaGlobal_GameOption_All._elements.EnableWhisperMusic
      },
      {
        _element = PaGlobal_GameOption_All._elements.EnableTraySoundOnOff
      },
      {
        _element = PaGlobal_GameOption_All._elements.EnableAroundPlayMusic,
        _contentsOption = _ContentsGroup_InstrumentPerformance
      },
      {
        _element = PaGlobal_GameOption_All._elements.BattleSoundType
      },
      {
        _element = PaGlobal_GameOption_All._elements.AudioResourceType
      },
      {
        _element = PaGlobal_GameOption_All._elements.VolumeMaster
      },
      {
        _element = PaGlobal_GameOption_All._elements.EnableMusic
      },
      {
        _element = PaGlobal_GameOption_All._elements.VolumeMusic
      },
      {
        _element = PaGlobal_GameOption_All._elements.EnableSound
      },
      {
        _element = PaGlobal_GameOption_All._elements.VolumeFx
      },
      {
        _element = PaGlobal_GameOption_All._elements.VolumeHitFxVolume
      },
      {
        _element = PaGlobal_GameOption_All._elements.VolumeHitFxWeight
      },
      {
        _element = PaGlobal_GameOption_All._elements.VolumeOtherPlayer
      },
      {
        _element = PaGlobal_GameOption_All._elements.VolumeMusicPlay,
        _contentsOption = _ContentsGroup_InstrumentPerformance
      },
      {
        _element = PaGlobal_GameOption_All._elements.EnableEnv
      },
      {
        _element = PaGlobal_GameOption_All._elements.VolumeEnv
      },
      {
        _element = PaGlobal_GameOption_All._elements.VolumeDlg
      },
      {
        _element = PaGlobal_GameOption_All._elements.EnableAudioFairy,
        _contentsOption = _ContentsGroup_isFairy
      },
      {
        _element = PaGlobal_GameOption_All._elements.VolumeFairy,
        _contentsOption = _ContentsGroup_isFairy
      }
    }
  },
  Function = {
    Convenience = {
      _title = "PANEL_NEWGAMEOPTION_FUNCTION_CONVENIENCE_DESC",
      {
        _element = PaGlobal_GameOption_All._elements.AimAssist
      },
      {
        _element = PaGlobal_GameOption_All._elements.UseNewQuickSlot
      },
      {
        _element = PaGlobal_GameOption_All._elements.EnableSimpleUI
      },
      {
        _element = PaGlobal_GameOption_All._elements.IsOnScreenSaver
      },
      {
        _element = PaGlobal_GameOption_All._elements.UIFontSizeType
      },
      {
        _element = PaGlobal_GameOption_All._elements.UIFontType
      }
    },
    View = {
      _title = "PANEL_NEWGAMEOPTION_FUNCTION_VIEW_DESC",
      {
        _subTitle = "PANEL_NEWGAMEOPTION_FUNCTION_VIEW_CHARACTERNAMETITLE"
      },
      {
        _element = PaGlobal_GameOption_All._elements.SelfPlayerNameTagVisible
      },
      {
        _element = PaGlobal_GameOption_All._elements.NickNameOrCharacterName,
        _contentsOption = _ContentsGroup_NameTypeEqually
      },
      {
        _element = PaGlobal_GameOption_All._elements.OtherPlayerNameTagVisible
      },
      {
        _element = PaGlobal_GameOption_All._elements.PartyPlayerNameTagVisible
      },
      {
        _element = PaGlobal_GameOption_All._elements.GuildPlayerNameTagVisible
      },
      {
        _element = PaGlobal_GameOption_All._elements.RankingPlayerNameTagVisible
      },
      {
        _element = PaGlobal_GameOption_All._elements.ShowStackHp,
        _contentsOption = _ContentsGroup_StackingHpBar
      },
      {
        _subTitle = "PANEL_NEWGAMEOPTION_FUNCTION_VIEW_CHARACTERLINETITLE"
      },
      {
        _element = PaGlobal_GameOption_All._elements.GuideLineZoneChange
      },
      {
        _element = PaGlobal_GameOption_All._elements.GuideLineQuestNPC
      },
      {
        _element = PaGlobal_GameOption_All._elements.GuideLineNpcIntimacy
      },
      {
        _element = PaGlobal_GameOption_All._elements.GuideLineWarAlly
      },
      {
        _element = PaGlobal_GameOption_All._elements.GuideLineNonWarPlayer
      },
      {
        _element = PaGlobal_GameOption_All._elements.GuideLineEnemy
      },
      {
        _element = PaGlobal_GameOption_All._elements.GuideLineGuild
      },
      {
        _element = PaGlobal_GameOption_All._elements.GuideLineParty
      },
      {
        _element = PaGlobal_GameOption_All._elements.PetRender
      },
      {
        _element = PaGlobal_GameOption_All._elements.FairyRender,
        _contentsOption = _ContentsGroup_isFairy
      },
      {
        _element = PaGlobal_GameOption_All._elements.TentRender
      },
      {
        _element = PaGlobal_GameOption_All._elements.MaidView
      },
      {
        _subTitle = "PANEL_NEWGAMEOPTION_FUNCTION_VIEW_ETCTITLE"
      },
      {
        _element = PaGlobal_GameOption_All._elements.ShowReputation,
        _contentsOption = _ContentsGroup_StatTierIcon
      },
      {
        _element = PaGlobal_GameOption_All._elements.RenderHitEffect
      },
      {
        _element = PaGlobal_GameOption_All._elements.ShowComboGuide
      },
      {
        _element = PaGlobal_GameOption_All._elements.HideMastOnCarrier
      },
      {
        _element = PaGlobal_GameOption_All._elements.DamageMeter,
        _contentsOption = _ContentsGroup_DamageMeter
      }
    },
    Alert = {
      _title = "PANEL_NEWGAMEOPTION_FUNCTION_ALERT_DESC",
      {
        _subTitle = "PANEL_NEWGAMEOPTION_FUNCTION_ALERT_COMMON"
      },
      {
        _element = PaGlobal_GameOption_All._elements.AlertNormalTrade
      },
      {
        _element = PaGlobal_GameOption_All._elements.AlertRoyalTrade
      },
      {
        _element = PaGlobal_GameOption_All._elements.AlertOtherPlayerGetItem
      },
      {
        _element = PaGlobal_GameOption_All._elements.AlertLifeLevelUp
      },
      {
        _element = PaGlobal_GameOption_All._elements.AlertEnchantSuccess
      },
      {
        _element = PaGlobal_GameOption_All._elements.AlertEnchantFail
      },
      {
        _element = PaGlobal_GameOption_All._elements.AlertItemMarket
      },
      {
        _element = PaGlobal_GameOption_All._elements.AlertOtherMarket
      },
      {
        _element = PaGlobal_GameOption_All._elements.ShowRightBottomAlarm
      },
      {
        _subTitle = "PANEL_NEWGAMEOPTION_FUNCTION_ALERT_PERSONAL"
      },
      {
        _element = PaGlobal_GameOption_All._elements.AlertChangeRegion
      },
      {
        _element = PaGlobal_GameOption_All._elements.AlertFitnessLevelUp
      },
      {
        _subTitle = "PANEL_NEWGAMEOPTION_FUNCTION_ALERT_BELONG"
      },
      {
        _element = PaGlobal_GameOption_All._elements.AlertTerritoryWar
      },
      {
        _element = PaGlobal_GameOption_All._elements.AlertGuildWar
      },
      {
        _subTitle = "PANEL_NEWGAMEOPTION_FUNCTION_ALERT_VIEW"
      },
      {
        _element = PaGlobal_GameOption_All._elements.BlackSpiritNotice
      },
      {
        _element = PaGlobal_GameOption_All._elements.ShowCashAlert
      },
      {
        _element = PaGlobal_GameOption_All._elements.ShowGuildLoginMessage
      },
      {
        _element = PaGlobal_GameOption_All._elements.AlertGuildQuestMessage
      },
      {
        _element = PaGlobal_GameOption_All._elements.AlertNearMonster
      }
    },
    Worldmap = {
      _title = "PANEL_NEWGAMEOPTION_FUNCTION_WORLDMAP_DESC",
      {
        _element = PaGlobal_GameOption_All._elements.WorldMapOpenType
      },
      {
        _element = PaGlobal_GameOption_All._elements.WorldmapCameraPitchType
      }
    },
    Nation = {
      _title = "PANEL_NEWGAMEOPTION_FUNCTION_NATION_DESC",
      {
        _element = PaGlobal_GameOption_All._elements.AudioResourceType
      },
      {
        _element = PaGlobal_GameOption_All._elements.WatermarkService
      },
      {
        _element = PaGlobal_GameOption_All._elements.UseChattingFilter
      },
      {
        _element = PaGlobal_GameOption_All._elements.ServiceResourceType
      },
      {
        _element = PaGlobal_GameOption_All._elements.ChatChannelType
      }
    },
    Etc = {
      _title = "PANEL_NEWGAMEOPTION_FUNCTION_ETC_DESC",
      {
        _element = PaGlobal_GameOption_All._elements.ShowNavPathEffectType
      },
      {
        _element = PaGlobal_GameOption_All._elements.AutoNaviMoveTypeAtGround,
        _contentsOption = _ContentsGroup_AutomaticGuildeSmooth
      },
      {
        _element = PaGlobal_GameOption_All._elements.AutoNaviMoveType,
        _contentsOption = _ContentsGroup_AutomaticGuildeSmooth
      },
      {
        _subTitle = "PANEL_NEWGAMEOPTION_FUNCTION_ETC_INTERACTIONTITLE"
      },
      {
        _element = PaGlobal_GameOption_All._elements.RefuseRequests
      },
      {
        _element = PaGlobal_GameOption_All._elements.IsPvpRefuse
      },
      {
        _element = PaGlobal_GameOption_All._elements.IsExchangeRefuse
      },
      {
        _subTitle = "PANEL_NEWGAMEOPTION_FUNCTION_ETC_ETCTITLE"
      },
      {
        _element = PaGlobal_GameOption_All._elements.RotateRadarMode
      },
      {
        _element = PaGlobal_GameOption_All._elements.HideWindowByAttacked
      },
      {
        _element = PaGlobal_GameOption_All._elements.AutoRunCamera
      },
      {
        _element = PaGlobal_GameOption_All._elements.UseLedAnimation
      },
      {
        _element = PaGlobal_GameOption_All._elements.AutoRunCameraRotation
      }
    }
  },
  Interface = {
    Action = {
      _title = "PANEL_NEWGAMEOPTION_INTERFACE_ACTION_DESC",
      {
        _element = PaGlobal_GameOption_All._elements.KeyCustomMode
      },
      {
        _keyTitle1 = "PANEL_NEWGAMEOPTION_INTERFACE_ACTION_ONLYPADTITLE",
        _keyTitle2 = "PANEL_NEWGAMEOPTION_INTERFACE_ACTION_HOTKEYTITLE"
      },
      {
        _element = PaGlobal_GameOption_All._elements.PadFunction1
      },
      {
        _element = PaGlobal_GameOption_All._elements.PadFunction2
      },
      {
        _keyTitle1 = "PANEL_NEWGAMEOPTION_INTERFACE_ACTION_BASESTANCETITLE",
        _keyTitle2 = "PANEL_NEWGAMEOPTION_INTERFACE_ACTION_COMBATSTANCETITLE",
        _keyTitle3 = "PANEL_NEWGAMEOPTION_INTERFACE_ACTION_HOTKEYTITLE"
      },
      {
        _element = PaGlobal_GameOption_All._elements.ActionMoveFront
      },
      {
        _element = PaGlobal_GameOption_All._elements.ActionMoveBack
      },
      {
        _element = PaGlobal_GameOption_All._elements.ActionMoveLeft
      },
      {
        _element = PaGlobal_GameOption_All._elements.ActionMoveRight
      },
      {
        _element = PaGlobal_GameOption_All._elements.ActionDash
      },
      {
        _element = PaGlobal_GameOption_All._elements.ActionJump
      },
      {
        _element = PaGlobal_GameOption_All._elements.ActionWeaponInOut
      },
      {
        _element = PaGlobal_GameOption_All._elements.ActionServantOrder3
      },
      {
        _element = PaGlobal_GameOption_All._elements.ActionAttack1
      },
      {
        _element = PaGlobal_GameOption_All._elements.ActionAttack2
      },
      {
        _element = PaGlobal_GameOption_All._elements.ActionCrouchOrSkill
      },
      {
        _element = PaGlobal_GameOption_All._elements.ActionGrabOrGuard
      },
      {
        _element = PaGlobal_GameOption_All._elements.ActionKick
      },
      {
        _element = PaGlobal_GameOption_All._elements.ActionServantOrder1
      },
      {
        _element = PaGlobal_GameOption_All._elements.ActionServantOrder2
      },
      {
        _element = PaGlobal_GameOption_All._elements.ActionServantOrder4
      },
      {
        _element = PaGlobal_GameOption_All._elements.ActionAutoRun
      },
      {
        _element = PaGlobal_GameOption_All._elements.ActionWalkMode
      },
      {
        _element = PaGlobal_GameOption_All._elements.ActionAutoMoveWalkMode
      },
      {
        _element = PaGlobal_GameOption_All._elements.UiAlchemyStone
      },
      {
        _element = PaGlobal_GameOption_All._elements.ActionInteraction
      },
      {
        _element = PaGlobal_GameOption_All._elements.UiInteraction1
      },
      {
        _element = PaGlobal_GameOption_All._elements.UiInteraction2
      },
      {
        _element = PaGlobal_GameOption_All._elements.UiInteraction3
      },
      {
        _element = PaGlobal_GameOption_All._elements.UiInteraction4
      },
      {
        _element = PaGlobal_GameOption_All._elements.UiInteraction5
      },
      {
        _element = PaGlobal_GameOption_All._elements.ActionComplicated0
      },
      {
        _element = PaGlobal_GameOption_All._elements.ActionComplicated1
      },
      {
        _element = PaGlobal_GameOption_All._elements.ActionComplicated2
      },
      {
        _element = PaGlobal_GameOption_All._elements.ActionComplicated3
      }
    },
    UI = {
      _title = "PANEL_NEWGAMEOPTION_INTERFACE_UI_DESC",
      {
        _element = PaGlobal_GameOption_All._elements.KeyCustomMode
      },
      {
        _keyTitle1 = "PANEL_NEWGAMEOPTION_INTERFACE_UI_TITLE",
        _keyTitle2 = "PANEL_NEWGAMEOPTION_INTERFACE_ACTION_HOTKEYTITLE"
      },
      {
        _element = PaGlobal_GameOption_All._elements.UiCursorOnOff
      },
      {
        _element = PaGlobal_GameOption_All._elements.UiHelp
      },
      {
        _element = PaGlobal_GameOption_All._elements.UiMentalKnowledge
      },
      {
        _element = PaGlobal_GameOption_All._elements.UiInventory
      },
      {
        _element = PaGlobal_GameOption_All._elements.UiBlackSpirit
      },
      {
        _element = PaGlobal_GameOption_All._elements.UiChat
      },
      {
        _element = PaGlobal_GameOption_All._elements.UiPlayerInfo
      },
      {
        _element = PaGlobal_GameOption_All._elements.UiSkill
      },
      {
        _element = PaGlobal_GameOption_All._elements.UiWorldMap
      },
      {
        _element = PaGlobal_GameOption_All._elements.UiDyeing
      },
      {
        _element = PaGlobal_GameOption_All._elements.UiProductionNote
      },
      {
        _element = PaGlobal_GameOption_All._elements.UiManufacture
      },
      {
        _element = PaGlobal_GameOption_All._elements.UiGuild
      },
      {
        _element = PaGlobal_GameOption_All._elements.UiMail
      },
      {
        _element = PaGlobal_GameOption_All._elements.UiFriendList
      },
      {
        _element = PaGlobal_GameOption_All._elements.UiPresent
      },
      {
        _element = PaGlobal_GameOption_All._elements.UiQuestHistory
      },
      {
        _element = PaGlobal_GameOption_All._elements.UiCashShop
      },
      {
        _element = PaGlobal_GameOption_All._elements.UiBeautyShop
      },
      {
        _element = PaGlobal_GameOption_All._elements.UiHouse
      },
      {
        _element = PaGlobal_GameOption_All._elements.UiWorker
      },
      {
        _element = PaGlobal_GameOption_All._elements.UiPet
      },
      {
        _element = PaGlobal_GameOption_All._elements.UiMaid
      },
      {
        _element = PaGlobal_GameOption_All._elements.UiServant
      },
      {
        _element = PaGlobal_GameOption_All._elements.UiGuildServant
      },
      {
        _element = PaGlobal_GameOption_All._elements.UiChatTabPrev
      },
      {
        _element = PaGlobal_GameOption_All._elements.UiChatTabNext
      },
      {
        _element = PaGlobal_GameOption_All._elements.UiAdventureBook
      },
      {
        _element = PaGlobal_GameOption_All._elements.UiBlackGift
      },
      {
        _element = PaGlobal_GameOption_All._elements.UiCallServantWater
      },
      {
        _element = PaGlobal_GameOption_All._elements.UiBarterInfo
      },
      {
        _element = PaGlobal_GameOption_All._elements.UiExpirienceWiki
      }
    },
    QuickSlot = {
      _title = "PANEL_NEWGAMEOPTION_INTERFACE_QUICKSLOT_DESC",
      {
        _element = PaGlobal_GameOption_All._elements.KeyCustomMode
      },
      {
        _keyTitle1 = "PANEL_NEWGAMEOPTION_INTERFACE_FUNCTION_FUNC_TITLE",
        _keyTitle2 = "PANEL_NEWGAMEOPTION_INTERFACE_ACTION_HOTKEYTITLE"
      },
      {
        _element = PaGlobal_GameOption_All._elements.ActionQuickSlot1
      },
      {
        _element = PaGlobal_GameOption_All._elements.ActionQuickSlot2
      },
      {
        _element = PaGlobal_GameOption_All._elements.ActionQuickSlot3
      },
      {
        _element = PaGlobal_GameOption_All._elements.ActionQuickSlot4
      },
      {
        _element = PaGlobal_GameOption_All._elements.ActionQuickSlot5
      },
      {
        _element = PaGlobal_GameOption_All._elements.ActionQuickSlot6
      },
      {
        _element = PaGlobal_GameOption_All._elements.ActionQuickSlot7
      },
      {
        _element = PaGlobal_GameOption_All._elements.ActionQuickSlot8
      },
      {
        _element = PaGlobal_GameOption_All._elements.ActionQuickSlot9
      },
      {
        _element = PaGlobal_GameOption_All._elements.ActionQuickSlot10
      },
      {
        _element = PaGlobal_GameOption_All._elements.ActionQuickSlot11
      },
      {
        _element = PaGlobal_GameOption_All._elements.ActionQuickSlot12
      },
      {
        _element = PaGlobal_GameOption_All._elements.ActionQuickSlot13
      },
      {
        _element = PaGlobal_GameOption_All._elements.ActionQuickSlot14
      },
      {
        _element = PaGlobal_GameOption_All._elements.ActionQuickSlot15
      },
      {
        _element = PaGlobal_GameOption_All._elements.ActionQuickSlot16
      },
      {
        _element = PaGlobal_GameOption_All._elements.ActionQuickSlot17
      },
      {
        _element = PaGlobal_GameOption_All._elements.ActionQuickSlot18
      },
      {
        _element = PaGlobal_GameOption_All._elements.ActionQuickSlot19
      },
      {
        _element = PaGlobal_GameOption_All._elements.ActionQuickSlot20
      }
    },
    Function = {
      _title = "PANEL_NEWGAMEOPTION_INTERFACE_FUNCTION_DESC",
      {
        _element = PaGlobal_GameOption_All._elements.KeyCustomMode
      },
      {
        _keyTitle1 = "PANEL_NEWGAMEOPTION_INTERFACE_FUNCTION_FUNC_TITLE",
        _keyTitle2 = "PANEL_NEWGAMEOPTION_INTERFACE_ACTION_HOTKEYTITLE"
      },
      {
        _element = PaGlobal_GameOption_All._elements.ActionCameraReset
      },
      {
        _element = PaGlobal_GameOption_All._elements.ActionCameraUp
      },
      {
        _element = PaGlobal_GameOption_All._elements.ActionCameraDown
      },
      {
        _element = PaGlobal_GameOption_All._elements.ActionCameraLeft
      },
      {
        _element = PaGlobal_GameOption_All._elements.ActionCameraRight
      },
      {
        _element = PaGlobal_GameOption_All._elements.ActionCameraRotateGameMode
      },
      {
        _element = PaGlobal_GameOption_All._elements.UiCameraSpeedUp
      },
      {
        _element = PaGlobal_GameOption_All._elements.UiCameraSpeedDown
      },
      {
        _element = PaGlobal_GameOption_All._elements.ActionPushToTalk,
        _contentsOption = _ContentsGroup_VoiceChat
      },
      {
        _element = PaGlobal_GameOption_All._elements.UiDeleteNavigation
      },
      {
        _element = PaGlobal_GameOption_All._elements.UiPositionNotify
      }
    },
    Mouse = {
      _title = "PANEL_NEWGAMEOPTION_INTERFACE_MOUSE_DESC",
      {
        _element = PaGlobal_GameOption_All._elements.MouseInvertX
      },
      {
        _element = PaGlobal_GameOption_All._elements.MouseInvertY
      },
      {
        _element = PaGlobal_GameOption_All._elements.MouseSensitivityX
      },
      {
        _element = PaGlobal_GameOption_All._elements.MouseSensitivityY
      },
      {
        _element = PaGlobal_GameOption_All._elements.GameMouseMode
      },
      {
        _element = PaGlobal_GameOption_All._elements.IsUIModeMouseLock
      }
    },
    Pad = {
      _title = "PANEL_NEWGAMEOPTION_INTERFACE_PAD_DESC",
      {
        _element = PaGlobal_GameOption_All._elements.GamePadEnable
      },
      {
        _element = PaGlobal_GameOption_All._elements.GamePadVibration
      },
      {
        _element = PaGlobal_GameOption_All._elements.GamePadInvertX
      },
      {
        _element = PaGlobal_GameOption_All._elements.GamePadInvertY
      },
      {
        _element = PaGlobal_GameOption_All._elements.GamePadSensitivityX
      },
      {
        _element = PaGlobal_GameOption_All._elements.GamePadSensitivityY
      }
    }
  }
}
