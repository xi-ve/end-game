function PaGlobal_GameOption_All._elements.AimAssist:get(wrapper)
  return wrapper:getAimAssist()
end
function PaGlobal_GameOption_All._elements.UseNewQuickSlot:get(wrapper)
  return ToClient_getGameUIManagerWrapper():getLuaCacheDataListBool(__eNewQuickSlot)
end
function PaGlobal_GameOption_All._elements.EnableSimpleUI:get(wrapper)
  return wrapper:getEnableSimpleUI()
end
function PaGlobal_GameOption_All._elements.IsOnScreenSaver:get(wrapper)
  return wrapper:getIsOnScreenSaver()
end
function PaGlobal_GameOption_All._elements.UIFontSizeType:get(wrapper)
  return wrapper:getUIFontSizeType()
end
function PaGlobal_GameOption_All._elements.UIFontType:get(wrapper)
  return ToClient_GetUIfontType()
end
function PaGlobal_GameOption_All._elements.ShowNavPathEffectType:get(wrapper)
  return wrapper:getShowNavPathEffectType()
end
function PaGlobal_GameOption_All._elements.AutoNaviMoveType:get(wrapper)
  if false == wrapper:getAutomaticGuideSmooth() then
    return 0
  else
    return 1
  end
end
function PaGlobal_GameOption_All._elements.AutoNaviMoveTypeAtGround:get(wrapper)
  if false == wrapper:getAutomaticGuideSmoothAtGround() then
    return 0
  else
    return 1
  end
end
function PaGlobal_GameOption_All._elements.RefuseRequests:get(wrapper)
  return wrapper:getRefuseRequests()
end
function PaGlobal_GameOption_All._elements.IsPvpRefuse:get(wrapper)
  return wrapper:getPvpRefuse()
end
function PaGlobal_GameOption_All._elements.IsExchangeRefuse:get(wrapper)
  return wrapper:getIsExchangeRefuse()
end
function PaGlobal_GameOption_All._elements.RotateRadarMode:get(wrapper)
  return wrapper:getRadarRotateMode()
end
function PaGlobal_GameOption_All._elements.HideWindowByAttacked:get(wrapper)
  return wrapper:getHideWindowByAttacked()
end
function PaGlobal_GameOption_All._elements.CrossPlayEnable:get(wrapper)
  if false == ToClient_isCrossNetworkPlayAllowed() then
    setSamePlatformOnly(false)
  end
  return wrapper:getSamePlatformOnly()
end
function PaGlobal_GameOption_All._elements.CrossPlayCommunication:get(wrapper)
  return wrapper:getCrossCommunity()
end
function PaGlobal_GameOption_All._elements.ShowRightBottomAlarm:get(wrapper)
  return wrapper:getShowRightBottomAlarm()
end
function PaGlobal_GameOption_All._elements.AutoRunCamera:get(wrapper)
  return wrapper:getAutoRunCamera()
end
function PaGlobal_GameOption_All._elements.AutoRunCameraRotation:get(wrapper)
  return wrapper:getAutoRunCameraRotation()
end
function PaGlobal_GameOption_All._elements.AudioResourceType:get(wrapper)
  return PaGlobal_GameOption_All:radioButtonMapping_AudioResourceType(wrapper:getAudioResourceType(), true)
end
function PaGlobal_GameOption_All._elements.ServiceResourceType:get(wrapper)
  return PaGlobal_GameOption_All:radioButtonMapping_ServiceResourceType(wrapper:getServiceResType(), true)
end
function PaGlobal_GameOption_All._elements.UseChattingFilter:get(wrapper)
  return wrapper:getUseChattingFilter()
end
function PaGlobal_GameOption_All._elements.ChatChannelType:get(wrapper)
  return PaGlobal_GameOption_All:radioButtonMapping_ChatChannelType(wrapper:getChatLanguageType(), true)
end
function PaGlobal_GameOption_All._elements.SelfPlayerNameTagVisible:get(wrapper)
  local realValue = wrapper:getSelfPlayerNameTagVisible()
  for index = 0, 2 do
    if realValue == PaGlobal_GameOption_All._SelfPlayerNameTagVisibleValue[index] then
      return index
    end
  end
  return 0
end
function PaGlobal_GameOption_All._elements.OtherPlayerNameTagVisible:get(wrapper)
  return CppEnums.VisibleNameTagType.eVisibleNameTagType_AllwaysShow == wrapper:getOtherPlayerNameTagVisible()
end
function PaGlobal_GameOption_All._elements.PartyPlayerNameTagVisible:get(wrapper)
  return CppEnums.VisibleNameTagType.eVisibleNameTagType_AllwaysShow == wrapper:getPartyPlayerNameTagVisible()
end
function PaGlobal_GameOption_All._elements.GuildPlayerNameTagVisible:get(wrapper)
  return CppEnums.VisibleNameTagType.eVisibleNameTagType_AllwaysShow == wrapper:getGuildPlayerNameTagVisible()
end
function PaGlobal_GameOption_All._elements.RankingPlayerNameTagVisible:get(wrapper)
  return CppEnums.VisibleNameTagType.eVisibleNameTagType_AllwaysShow == wrapper:getRankingPlayerNameTagVisible()
end
function PaGlobal_GameOption_All._elements.NickNameOrCharacterName:get(wrapper)
  local nameType = ToClient_getChatNameType()
  if __eChatNameType_NickName == nameType then
    return 1
  else
    return 0
  end
end
function PaGlobal_GameOption_All._elements.GuideLineZoneChange:get(wrapper)
  return wrapper:getRenderPlayerColor("ZoneChange")
end
function PaGlobal_GameOption_All._elements.GuideLineQuestNPC:get(wrapper)
  return wrapper:getShowQuestActorColor()
end
function PaGlobal_GameOption_All._elements.GuideLineNpcIntimacy:get(wrapper)
  return wrapper:getShowHumanRelation()
end
function PaGlobal_GameOption_All._elements.GuideLineWarAlly:get(wrapper)
  return wrapper:getRenderPlayerColor("WarAlly")
end
function PaGlobal_GameOption_All._elements.GuideLineNonWarPlayer:get(wrapper)
  return wrapper:getRenderPlayerColor("NonWarPlayer")
end
function PaGlobal_GameOption_All._elements.GuideLineEnemy:get(wrapper)
  return wrapper:getRenderPlayerColor("Enemy")
end
function PaGlobal_GameOption_All._elements.GuideLineGuild:get(wrapper)
  return wrapper:getRenderPlayerColor("Guild")
end
function PaGlobal_GameOption_All._elements.GuideLineParty:get(wrapper)
  return wrapper:getRenderPlayerColor("Party")
end
function PaGlobal_GameOption_All._elements.GuideLinePartyMemberEffect:get(wrapper)
  return wrapper:getRenderHitEffectParty()
end
function PaGlobal_GameOption_All._elements.PetRender:get(wrapper)
  return wrapper:getPetRender()
end
function PaGlobal_GameOption_All._elements.FairyRender:get(wrapper)
  if true == wrapper:getFairyRender() then
    return 0
  else
    return 1
  end
end
function PaGlobal_GameOption_All._elements.TentRender:get(wrapper)
  if false == wrapper:getHideOtherPlayerTent() then
    return 0
  else
    return 1
  end
end
function PaGlobal_GameOption_All._elements.MaidView:get(wrapper)
  PaGlobal_GameOption_All._elements.MaidView._sliderValueMax = wrapper:getMaidMaxCount()
  return PaGlobal_GameOption_All:FromRealValueToSliderValue(wrapper:getMaidView(), 0, wrapper:getMaidMaxCount())
end
function PaGlobal_GameOption_All._elements.ShowReputation:get(wrapper)
  return wrapper:getShowStatTier()
end
function PaGlobal_GameOption_All._elements.RenderHitEffect:get(wrapper)
  return wrapper:getRenderHitEffect()
end
function PaGlobal_GameOption_All._elements.DamageMeter:get(wrapper)
  return wrapper:getOnDamageMeter()
end
function PaGlobal_GameOption_All._elements.ShowComboGuide:get(wrapper)
  return wrapper:getShowComboGuide()
end
function PaGlobal_GameOption_All._elements.HideMastOnCarrier:get(wrapper)
  return wrapper:getHideMastOnCarrier()
end
function PaGlobal_GameOption_All._elements.WorkerVisible:get(wrapper)
  return wrapper:getWorkerVisible()
end
function PaGlobal_GameOption_All._elements.WorldMapOpenType:get(wrapper)
  local realValue = wrapper:getWorldmapOpenType()
  for index = 0, 3 do
    if realValue == PaGlobal_GameOption_All._worldMapOpenTypeValue[index] then
      return index
    end
  end
  return 0
end
function PaGlobal_GameOption_All._elements.WorldmapCameraPitchType:get(wrapper)
  local realValue = wrapper:getWorldMapCameraPitchType()
  for index = 0, 2 do
    if realValue == PaGlobal_GameOption_All._worldMapCameraPitchTypeValue[index] then
      return index
    end
  end
  return 0
end
function PaGlobal_GameOption_All._elements.TextureQuality:get(wrapper)
  return PaGlobal_GameOption_All:radioButtonMapping_TextureQuality(wrapper:getTextureQuality(), true)
end
function PaGlobal_GameOption_All._elements.GraphicOption:get(wrapper)
  return PaGlobal_GameOption_All:radioButtonMapping_GraphicOption(wrapper:getGraphicOption(), true)
end
function PaGlobal_GameOption_All._elements.AntiAliasing:get(wrapper)
  return wrapper:getAntiAliasingIndex()
end
function PaGlobal_GameOption_All._elements.SSAO:get(wrapper)
  return wrapper:getSSAO()
end
function PaGlobal_GameOption_All._elements.PostFilter:get(wrapper)
  return wrapper:getPostFilter() == 2
end
function PaGlobal_GameOption_All._elements.Tessellation:get(wrapper)
  return wrapper:getTessellation()
end
function PaGlobal_GameOption_All._elements.Dof:get(wrapper)
  return wrapper:getDof()
end
function PaGlobal_GameOption_All._elements.Representative:get(wrapper)
  return wrapper:getRepresentative()
end
function PaGlobal_GameOption_All._elements.CharacterEffect:get(wrapper)
  return wrapper:getCharacterEffect()
end
function PaGlobal_GameOption_All._elements.SnowPoolOnlyInSafeZone:get(wrapper)
  return wrapper:getSnowPoolOnlyInSafeZone()
end
function PaGlobal_GameOption_All._elements.BloodEffect:get(wrapper)
  return wrapper:getBloodEffect() == 2
end
function PaGlobal_GameOption_All._elements.LensBlood:get(wrapper)
  return wrapper:getLensBlood()
end
function PaGlobal_GameOption_All._elements.AutoOptimization:get(wrapper)
  return wrapper:getAutoOptimization()
end
function PaGlobal_GameOption_All._elements.AutoOptimizationFrameLimit:get(wrapper)
  return PaGlobal_GameOption_All:FromRealValueToSliderValue(wrapper:getAutoOptimizationFrameLimit(), 0, 60)
end
function PaGlobal_GameOption_All._elements.UpscaleEnable:get(wrapper)
  return wrapper:getUpscaleEnable()
end
function PaGlobal_GameOption_All._elements.PresentLock:get(wrapper)
  return wrapper:getPresentLock()
end
function PaGlobal_GameOption_All._elements.DataOptimize:get(wrapper)
  return true ~= wrapper:isUseDynamicBSS()
end
function PaGlobal_GameOption_All._elements.UseEffectFrameOptimization:get(wrapper)
  return wrapper:getUseOptimizationEffectFrame()
end
function PaGlobal_GameOption_All._elements.EffectFrameOptimization:get(wrapper)
  return PaGlobal_GameOption_All:FromRealValueToSliderValue(wrapper:getEffectFrameEffectOptimization(), 0.1, 25)
end
function PaGlobal_GameOption_All._elements.UsePlayerEffectDistOptimization:get(wrapper)
  return wrapper:getUsePlayerOptimizationEffectFrame()
end
function PaGlobal_GameOption_All._elements.PlayerEffectDistOptimization:get(wrapper)
  return PaGlobal_GameOption_All:FromRealValueToSliderValue(wrapper:getPlayerEffectFrameEffectOptimization() * 0.01, 10, 50)
end
function PaGlobal_GameOption_All._elements.UseCharacterUpdateFrameOptimize:get(wrapper)
  return wrapper:getUseCharacterDistUpdate()
end
function PaGlobal_GameOption_All._elements.UseOtherPlayerUpdate:get(wrapper)
  return true ~= wrapper:getUseOtherPlayerUpdate()
end
function PaGlobal_GameOption_All._elements.ShowSpawnableNPC:get(wrapper)
  return wrapper:getUseSpawnableNpc()
end
function PaGlobal_GameOption_All._elements.Fov:get(wrapper)
  return PaGlobal_GameOption_All:FromRealValueToSliderValue(wrapper:getFov(), 40, 70)
end
function PaGlobal_GameOption_All._elements.CameraEffectMaster:get(wrapper)
  return PaGlobal_GameOption_All:FromRealValueToSliderValue(wrapper:getCameraMasterPower(), 0, 1)
end
function PaGlobal_GameOption_All._elements.CameraShakePower:get(wrapper)
  return PaGlobal_GameOption_All:FromRealValueToSliderValue(wrapper:getCameraShakePower(), 0, 1)
end
function PaGlobal_GameOption_All._elements.MotionBlurPower:get(wrapper)
  return PaGlobal_GameOption_All:FromRealValueToSliderValue(wrapper:getMotionBlurPower(), 0, 1)
end
function PaGlobal_GameOption_All._elements.CameraTranslatePower:get(wrapper)
  return PaGlobal_GameOption_All:FromRealValueToSliderValue(wrapper:getCameraTranslatePower(), 0, 1)
end
function PaGlobal_GameOption_All._elements.CameraFovPower:get(wrapper)
  return PaGlobal_GameOption_All:FromRealValueToSliderValue(wrapper:getCameraFovPower(), 0, 1)
end
function PaGlobal_GameOption_All._elements.MouseInvertX:get(wrapper)
  return wrapper:getMouseInvertX()
end
function PaGlobal_GameOption_All._elements.MouseInvertY:get(wrapper)
  return wrapper:getMouseInvertY()
end
function PaGlobal_GameOption_All._elements.MouseSensitivityX:get(wrapper)
  return PaGlobal_GameOption_All:FromRealValueToSliderValue(wrapper:getMouseSensitivityX(), 0.1, 2)
end
function PaGlobal_GameOption_All._elements.MouseSensitivityY:get(wrapper)
  return PaGlobal_GameOption_All:FromRealValueToSliderValue(wrapper:getMouseSensitivityY(), 0.1, 2)
end
function PaGlobal_GameOption_All._elements.GameMouseMode:get(wrapper)
  return wrapper:getGameMouseMode()
end
function PaGlobal_GameOption_All._elements.IsUIModeMouseLock:get(wrapper)
  return wrapper:getUIModeMouseLock()
end
function PaGlobal_GameOption_All._elements.GamePadEnable:get(wrapper)
  if true == _ContentsGroup_useUISnappingOption then
    return ToClient_isUsePadSnapping()
  else
    return wrapper:getGamePadEnable()
  end
end
function PaGlobal_GameOption_All._elements.GamePadVibration:get(wrapper)
  return wrapper:getGamePadVibration()
end
function PaGlobal_GameOption_All._elements.GamePadInvertX:get(wrapper)
  return wrapper:getGamePadInvertX()
end
function PaGlobal_GameOption_All._elements.GamePadInvertY:get(wrapper)
  return wrapper:getGamePadInvertY()
end
function PaGlobal_GameOption_All._elements.GamePadSensitivityX:get(wrapper)
  return PaGlobal_GameOption_All:FromRealValueToSliderValue(wrapper:getGamePadSensitivityX(), 0.1, 2)
end
function PaGlobal_GameOption_All._elements.GamePadSensitivityY:get(wrapper)
  return PaGlobal_GameOption_All:FromRealValueToSliderValue(wrapper:getGamePadSensitivityY(), 0.1, 2)
end
function PaGlobal_GameOption_All._elements.ConsolePadKeyType:get(wrapper)
  local keyType = wrapper:getConsoleKeyType()
  if 1 == keyType then
    return 0
  elseif 2 == keyType then
    return 1
  end
end
function PaGlobal_GameOption_All._elements.ScreenShotQuality:get(wrapper)
  return wrapper:getScreenShotQuality()
end
function PaGlobal_GameOption_All._elements.ScreenShotFormat:get(wrapper)
  return wrapper:getScreenShotFormat()
end
function PaGlobal_GameOption_All._elements.WatermarkAlpha:get(wrapper)
  return PaGlobal_GameOption_All:FromRealValueToSliderValue(wrapper:getWatermarkAlpha(), 0, 1)
end
function PaGlobal_GameOption_All._elements.WatermarkScale:get(wrapper)
  return wrapper:getWatermarkScale()
end
function PaGlobal_GameOption_All._elements.WatermarkPosition:get(wrapper)
  return wrapper:getWatermarkPosition()
end
function PaGlobal_GameOption_All._elements.WatermarkService:get(wrapper)
  return wrapper:getWatermarkService()
end
function PaGlobal_GameOption_All._elements.ScreenMode:get(wrapper)
  return wrapper:getScreenMode()
end
function PaGlobal_GameOption_All._elements.ScreenResolution:get(wrapper)
  return PaGlobal_GameOption_All._availableResolutionList:findResolution(wrapper:getScreenResolutionWidth(), wrapper:getScreenResolutionHeight())
end
function PaGlobal_GameOption_All._elements.CropModeEnable:get(wrapper)
  return wrapper:getCropModeEnable()
end
function PaGlobal_GameOption_All._elements.CropModeScaleX:get(wrapper)
  return PaGlobal_GameOption_All:FromRealValueToSliderValue(wrapper:getCropModeScaleX(), 0.5, 1)
end
function PaGlobal_GameOption_All._elements.CropModeScaleY:get(wrapper)
  return PaGlobal_GameOption_All:FromRealValueToSliderValue(wrapper:getCropModeScaleY(), 0.5, 1)
end
function PaGlobal_GameOption_All._elements.UIScale:get(wrapper)
  if true == UI.checkResolution4KForXBox() then
    PaGlobal_GameOption_All._elements.UIScale._initValue = 2
  end
  return PaGlobal_GameOption_All:FromRealValueToSliderValue(wrapper:getUIScale(), 0.5, 2)
end
function PaGlobal_GameOption_All._elements.GammaValue:get(wrapper)
  return PaGlobal_GameOption_All:FromRealValueToSliderValue(wrapper:getGammaValue(), 0, 1)
end
function PaGlobal_GameOption_All._elements.ContrastValue:get(wrapper)
  return PaGlobal_GameOption_All:FromRealValueToSliderValue(wrapper:getContrastValue(), 0, 1)
end
function PaGlobal_GameOption_All._elements.EffectAlpha:get(wrapper)
  return PaGlobal_GameOption_All:FromRealValueToSliderValue(wrapper:getEffectAlpha(), 0.3, 1)
end
function PaGlobal_GameOption_All._elements.SkillPostEffect:get(wrapper)
  return PaGlobal_GameOption_All:FromRealValueToSliderValue(wrapper:getSkillPostEffect(), 0, 1)
end
function PaGlobal_GameOption_All._elements.ColorBlind:get(wrapper)
  return ToClient_getGameUIManagerWrapper():getLuaCacheDataListNumber(__eColorBlindMode)
end
function PaGlobal_GameOption_All._elements.BlackSpiritNotice:get(wrapper)
  return wrapper:getBlackSpiritNotice()
end
function PaGlobal_GameOption_All._elements.ShowCashAlert:get(wrapper)
  return not wrapper:getCashAlert()
end
function PaGlobal_GameOption_All._elements.ShowGuildLoginMessage:get(wrapper)
  return wrapper:getShowGuildLoginMessage()
end
function PaGlobal_GameOption_All._elements.HideOtherPlayerTent:get(wrapper)
  return wrapper:getHideOtherPlayerTent()
end
function PaGlobal_GameOption_All._elements.LUT:get(wrapper)
  return wrapper:getCameraLUTFilter()
end
function PaGlobal_GameOption_All._elements.RefuseFriend:get(wrapper)
  return wrapper:getConsoleRefuseDirectFriend()
end
function PaGlobal_GameOption_All._elements.EnableMusic:get(wrapper)
  return wrapper:getEnableMusic()
end
function PaGlobal_GameOption_All._elements.EnableSound:get(wrapper)
  return wrapper:getEnableSound()
end
function PaGlobal_GameOption_All._elements.EnableEnv:get(wrapper)
  return wrapper:getEnableEnvSound()
end
function PaGlobal_GameOption_All._elements.EnableRidingSound:get(wrapper)
  return wrapper:getEnableRidingSound()
end
function PaGlobal_GameOption_All._elements.EnableWhisperMusic:get(wrapper)
  return wrapper:getEnableWhisperSound()
end
function PaGlobal_GameOption_All._elements.EnableTraySoundOnOff:get(wrapper)
  return wrapper:getEnableTraySound()
end
function PaGlobal_GameOption_All._elements.EnableAroundPlayMusic:get(wrapper)
  return wrapper:getEnableAroundPlayMusic()
end
function PaGlobal_GameOption_All._elements.BattleSoundType:get(wrapper)
  return wrapper:getEnableBattleSoundType()
end
function PaGlobal_GameOption_All._elements.EnableAudioFairy:get(wrapper)
  return wrapper:getEnableFairySound()
end
function PaGlobal_GameOption_All._elements.VolumeMaster:get(wrapper)
  return PaGlobal_GameOption_All:FromRealValueToSliderValue(wrapper:getMasterVolume(), 0, 100)
end
function PaGlobal_GameOption_All._elements.VolumeMusicPlay:get(wrapper)
  return PaGlobal_GameOption_All:FromRealValueToSliderValue(wrapper:getAroundPlayMusicVolume(), 0, 100)
end
function PaGlobal_GameOption_All._elements.VolumeMusic:get(wrapper)
  return PaGlobal_GameOption_All:FromRealValueToSliderValue(wrapper:getMusicVolume(), 0, 100)
end
function PaGlobal_GameOption_All._elements.VolumeFx:get(wrapper)
  return PaGlobal_GameOption_All:FromRealValueToSliderValue(wrapper:getFxVolume(), 0, 100)
end
function PaGlobal_GameOption_All._elements.VolumeEnv:get(wrapper)
  return PaGlobal_GameOption_All:FromRealValueToSliderValue(wrapper:getEnvSoundVolume(), 0, 100)
end
function PaGlobal_GameOption_All._elements.VolumeDlg:get(wrapper)
  return PaGlobal_GameOption_All:FromRealValueToSliderValue(wrapper:getDialogueVolume(), 0, 100)
end
function PaGlobal_GameOption_All._elements.VolumeHitFxVolume:get(wrapper)
  return PaGlobal_GameOption_All:FromRealValueToSliderValue(wrapper:getHitFxVolume(), 0, 100)
end
function PaGlobal_GameOption_All._elements.VolumeHitFxWeight:get(wrapper)
  return PaGlobal_GameOption_All:FromRealValueToSliderValue(wrapper:getHitFxWeight(), 0, 100)
end
function PaGlobal_GameOption_All._elements.VolumeOtherPlayer:get(wrapper)
  return PaGlobal_GameOption_All:FromRealValueToSliderValue(wrapper:getOtherPlayerVolume(), 0, 100)
end
function PaGlobal_GameOption_All._elements.VolumeFairy:get(wrapper)
  return PaGlobal_GameOption_All:FromRealValueToSliderValue(wrapper:getFairyVolume(), 0, 100)
end
function PaGlobal_GameOption_All._elements.AlertNormalTrade:get(wrapper)
  return not ToClient_GetMessageFilter(PaGlobal_GameOption_All.ALERT.NormalTrade)
end
function PaGlobal_GameOption_All._elements.AlertRoyalTrade:get(wrapper)
  return not ToClient_GetMessageFilter(PaGlobal_GameOption_All.ALERT.RoyalTrade)
end
function PaGlobal_GameOption_All._elements.AlertOtherPlayerGetItem:get(wrapper)
  return not ToClient_GetMessageFilter(PaGlobal_GameOption_All.ALERT.OtherPlayerGetItem)
end
function PaGlobal_GameOption_All._elements.AlertLifeLevelUp:get(wrapper)
  return not ToClient_GetMessageFilter(PaGlobal_GameOption_All.ALERT.LifeLevelUp)
end
function PaGlobal_GameOption_All._elements.AlertItemMarket:get(wrapper)
  return not ToClient_GetMessageFilter(PaGlobal_GameOption_All.ALERT.ItemMarket)
end
function PaGlobal_GameOption_All._elements.AlertOtherMarket:get(wrapper)
  return not ToClient_GetMessageFilter(PaGlobal_GameOption_All.ALERT.OtherMarket)
end
function PaGlobal_GameOption_All._elements.AlertChangeRegion:get(wrapper)
  return not ToClient_GetMessageFilter(PaGlobal_GameOption_All.ALERT.ChangeRegion)
end
function PaGlobal_GameOption_All._elements.AlertFitnessLevelUp:get(wrapper)
  return not ToClient_GetMessageFilter(PaGlobal_GameOption_All.ALERT.FitnessLevelUp)
end
function PaGlobal_GameOption_All._elements.AlertTerritoryWar:get(wrapper)
  return not ToClient_GetMessageFilter(PaGlobal_GameOption_All.ALERT.TerritoryWar)
end
function PaGlobal_GameOption_All._elements.AlertGuildWar:get(wrapper)
  return not ToClient_GetMessageFilter(PaGlobal_GameOption_All.ALERT.GuildWar)
end
function PaGlobal_GameOption_All._elements.AlertEnchantSuccess:get(wrapper)
  return not ToClient_GetMessageFilter(PaGlobal_GameOption_All.ALERT.EnchantSuccess)
end
function PaGlobal_GameOption_All._elements.AlertEnchantFail:get(wrapper)
  return not ToClient_GetMessageFilter(PaGlobal_GameOption_All.ALERT.EnchantFail)
end
function PaGlobal_GameOption_All._elements.AlertGuildQuestMessage:get(wrapper)
  return not ToClient_GetMessageFilter(PaGlobal_GameOption_All.ALERT.GuildQuestMessage)
end
function PaGlobal_GameOption_All._elements.AlertNearMonster:get(wrapper)
  return not ToClient_GetMessageFilter(PaGlobal_GameOption_All.ALERT.NearMonster)
end
function PaGlobal_GameOption_All._elements.SelfPlayerOnlyEffect:get(wrapper)
  return wrapper:getSelfPlayerOnlyEffect()
end
function PaGlobal_GameOption_All._elements.NearestPlayerOnlyEffect:get(wrapper)
  return wrapper:getNearestPlayerOnlyEffect()
end
function PaGlobal_GameOption_All._elements.SelfPlayerOnlyLantern:get(wrapper)
  return wrapper:getSelfPlayerOnlyLantern()
end
function PaGlobal_GameOption_All._elements.ShowStackHp:get(wrapper)
  return wrapper:getIsShowHpBar()
end
function PaGlobal_GameOption_All._elements.HDRDisplayGamma:get(wrapper)
  return PaGlobal_GameOption_All:FromRealValueToSliderValue(wrapper:getHdrDisplayGamma(), PaGlobal_GameOption_All._elements.HDRDisplayGamma._sliderValueMin * 0.01, PaGlobal_GameOption_All._elements.HDRDisplayGamma._sliderValueMax * 0.01)
end
function PaGlobal_GameOption_All._elements.HDRDisplayMaxNits:get(wrapper)
  return PaGlobal_GameOption_All:FromRealValueToSliderValue(wrapper:getHdrDisplayMaxNits(), PaGlobal_GameOption_All._elements.HDRDisplayMaxNits._sliderValueMin, PaGlobal_GameOption_All._elements.HDRDisplayMaxNits._sliderValueMax)
end
function PaGlobal_GameOption_All._elements.UltraHighDefinition:get(wrapper)
  return wrapper:getIsUHDMode()
end
function PaGlobal_GameOption_All._elements.UseLedAnimation:get(wrapper)
  return wrapper:getUseLedAnimation()
end
function PaGlobal_GameOption_All._elements.UseGamePadQuickTurn:get(wrapper)
  return wrapper:getGamePadUseQuickTurn()
end
function PaGlobal_GameOption_All._elements.ChatFilterNotice:get()
  local chat = ToClient_getChattingPanel(0)
  return chat:isShowChatType(CppEnums.ChatType.Notice)
end
function PaGlobal_GameOption_All._elements.ChatFilterWorld:get()
  local chat = ToClient_getChattingPanel(0)
  return chat:isShowChatType(CppEnums.ChatType.WorldWithItem)
end
function PaGlobal_GameOption_All._elements.ChatFilterPublic:get()
  local chat = ToClient_getChattingPanel(0)
  return chat:isShowChatType(CppEnums.ChatType.Public)
end
function PaGlobal_GameOption_All._elements.ChatFilterWhisper:get()
  local chat = ToClient_getChattingPanel(0)
  return chat:isShowChatType(CppEnums.ChatType.Private)
end
function PaGlobal_GameOption_All._elements.ChatFilterParty:get()
  local chat = ToClient_getChattingPanel(0)
  return chat:isShowChatType(CppEnums.ChatType.Party)
end
function PaGlobal_GameOption_All._elements.ChatFilterGuild:get()
  local chat = ToClient_getChattingPanel(0)
  return chat:isShowChatType(CppEnums.ChatType.Guild)
end
function PaGlobal_GameOption_All._elements.ChatFilterServer:get()
  local chat = ToClient_getChattingPanel(0)
  return chat:isShowChatType(CppEnums.ChatType.World)
end
function PaGlobal_GameOption_All._elements.ChatFilterBattle:get()
  local chat = ToClient_getChattingPanel(0)
  return chat:isShowChatType(CppEnums.ChatType.Battle)
end
function PaGlobal_GameOption_All._elements.ChatFilterTeam:get()
  local chat = ToClient_getChattingPanel(0)
  return chat:isShowChatType(CppEnums.ChatType.Team)
end
function PaGlobal_GameOption_All._elements.ChatFilterSystemAll:get()
  local chat = ToClient_getChattingPanel(0)
  return chat:isShowChatType(CppEnums.ChatType.System)
end
function PaGlobal_GameOption_All._elements.ChatFilterSystemPrivateItem:get()
  local chat = ToClient_getChattingPanel(0)
  return chat:isShowChatSystemType(CppEnums.ChatSystemType.PrivateItem)
end
function PaGlobal_GameOption_All._elements.ChatFilterSystemPartyItem:get()
  local chat = ToClient_getChattingPanel(0)
  return chat:isShowChatSystemType(CppEnums.ChatSystemType.PartyItem)
end
function PaGlobal_GameOption_All._elements.ChatFilterSystemMarket:get()
  local chat = ToClient_getChattingPanel(0)
  return chat:isShowChatSystemType(CppEnums.ChatSystemType.Market)
end
function PaGlobal_GameOption_All._elements.ChatFilterSystemWorker:get()
  local chat = ToClient_getChattingPanel(0)
  return chat:isShowChatSystemType(CppEnums.ChatSystemType.Worker)
end
function PaGlobal_GameOption_All._elements.ChatFilterSystemHarvest:get()
  local chat = ToClient_getChattingPanel(0)
  return chat:isShowChatSystemType(CppEnums.ChatSystemType.Harvest)
end
function PaGlobal_GameOption_All._elements.GraphicPreset:get(wrapper)
  return wrapper:getConsoleGraphicPresetIndex()
end
function PaGlobal_GameOption_All._elements.KeyCustomMode:get()
  if true == PaGlobal_GameOption_All._keyCustomPadMode then
    return 1
  else
    return 0
  end
end
function PaGlobal_GameOption_All._elements.UseDefaultCostumeOtherPlayer:get(wrapper)
  return wrapper:getUseDefaultCostumeOtherPlayer()
end
function PaGlobal_GameOption_All._elements.UseShowLootingPopupMenu:get(wrapper)
  return wrapper:getShowLootingPopupMenu()
end
