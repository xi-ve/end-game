function PaGlobal_GameOption_All._elements.AimAssist:set(value)
  setAimAssist(value)
end
function PaGlobal_GameOption_All._elements.UseNewQuickSlot:set(value)
  ToClient_getGameUIManagerWrapper():setLuaCacheDataListBool(__eNewQuickSlot, value, CppEnums.VariableStorageType.eVariableStorageType_User)
end
function PaGlobal_GameOption_All._elements.EnableSimpleUI:set(value)
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
function PaGlobal_GameOption_All._elements.IsOnScreenSaver:set(value)
  setIsOnScreenSaver(value)
end
function PaGlobal_GameOption_All._elements.UIFontSizeType:set(value)
  local gameOptionWrapper = ToClient_getGameOptionControllerWrapper()
  if nil ~= gameOptionWrapper and value == gameOptionWrapper:getUIFontSizeType() then
    if true == PaGlobal_GameOption_All._resetCheck then
      ToClient_excuteReloadUI()
    end
    return
  end
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
function PaGlobal_GameOption_All._elements.UIFontType:set(value)
  if value == ToClient_GetUIfontType() then
    return
  end
  ToClient_SetUIfontType(value)
end
function PaGlobal_GameOption_All._elements.ShowNavPathEffectType:set(value)
  setShowNavPathEffectType(value)
end
function PaGlobal_GameOption_All._elements.AutoNaviMoveType:set(value)
  ToClient_SetAutomaticGuideSmooth(value)
end
function PaGlobal_GameOption_All._elements.AutoNaviMoveTypeAtGround:set(value)
  ToClient_SetAutomaticGuideSmoothAtGround(value)
end
function PaGlobal_GameOption_All._elements.RefuseRequests:set(value)
  setRefuseRequests(value)
end
function PaGlobal_GameOption_All._elements.IsPvpRefuse:set(value)
  setIsPvpRefuse(value)
end
function PaGlobal_GameOption_All._elements.IsExchangeRefuse:set(value)
  setIsExchangeRefuse(value)
end
function PaGlobal_GameOption_All._elements.RotateRadarMode:set(value)
  setRotateRadarMode(value)
end
function PaGlobal_GameOption_All._elements.HideWindowByAttacked:set(value)
  setHideWindowByAttacked(value)
end
function PaGlobal_GameOption_All._elements.CrossPlayEnable:set(value)
  local isOn = ToClient_getGameOptionControllerWrapper():getSamePlatformOnly()
  if isOn ~= value then
    if false == setSamePlatformOnly(value) then
      ToClient_showPrivilegeError(false, true)
    else
      if false == value then
        PaGlobal_GameOption_All:SetCurrentValue("CheckButton_CrossPlayCommunication", 0)
      end
      local messageboxData = {
        title = PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_ALERT_NOTIFICATIONS"),
        content = PAGetString(Defines.StringSheet_GAME, "LUA_ALERT_CROSSPLAY_OPTION"),
        functionApply = MessageBox_Empty_function,
        priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
      }
      MessageBox.showMessageBox(messageboxData)
    end
  end
end
function PaGlobal_GameOption_All._elements.CrossPlayCommunication:set(value)
  local isOn = ToClient_getGameOptionControllerWrapper():getCrossCommunity()
  if false == setCrossCommunity(value) and false == isOn and true == value then
    local messageboxData = {
      title = PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_ALERT_NOTIFICATIONS"),
      content = PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_ALERT_CROSSPLAY_COMMUNICATION"),
      functionApply = MessageBox_Empty_function,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageboxData)
    return
  end
end
function PaGlobal_GameOption_All._elements.ShowRightBottomAlarm:set(value)
  setShowRightBottomAlarm(value)
end
function PaGlobal_GameOption_All._elements.AutoRunCamera:set(value)
  setAutoRunCamera(value)
end
function PaGlobal_GameOption_All._elements.AutoRunCameraRotation:set(value)
  setAutoRunCameraRotation(value)
end
function PaGlobal_GameOption_All._elements.AudioResourceType:set(value)
  setAudioResourceType(PaGlobal_GameOption_All:radioButtonMapping_AudioResourceType(value))
end
function PaGlobal_GameOption_All._elements.ServiceResourceType:set(value)
  if false == ToClient_isAvailableChangeServiceType() then
    return
  end
  ToClient_saveServiceResourceType(PaGlobal_GameOption_All:radioButtonMapping_ServiceResourceType(value))
end
function PaGlobal_GameOption_All._elements.UseChattingFilter:set(value)
  setUseChattingFilter(value)
end
function PaGlobal_GameOption_All._elements.ChatChannelType:set(value)
  if false == ToClient_isAvailableChangeServiceType() then
    return
  end
  local chatType = PaGlobal_GameOption_All:radioButtonMapping_ChatChannelType(value)
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
function PaGlobal_GameOption_All._elements.SelfPlayerNameTagVisible:set(value)
  if nil == value then
    return
  end
  local realValue = PaGlobal_GameOption_All._SelfPlayerNameTagVisibleValue[value]
  if nil ~= realValue then
    setSelfPlayerNameTagVisible(realValue)
  end
end
function PaGlobal_GameOption_All._elements.OtherPlayerNameTagVisible:set(value)
  if true == value then
    value = CppEnums.VisibleNameTagType.eVisibleNameTagType_AllwaysShow
  else
    value = CppEnums.VisibleNameTagType.eVisibleNameTagType_ImportantShow
  end
  setOtherPlayerNameTagVisible(value)
end
function PaGlobal_GameOption_All._elements.PartyPlayerNameTagVisible:set(value)
  if true == value then
    value = CppEnums.VisibleNameTagType.eVisibleNameTagType_AllwaysShow
  else
    value = CppEnums.VisibleNameTagType.eVisibleNameTagType_ImportantShow
  end
  setPartyPlayerNameTagVisible(value)
end
function PaGlobal_GameOption_All._elements.GuildPlayerNameTagVisible:set(value)
  if true == value then
    value = CppEnums.VisibleNameTagType.eVisibleNameTagType_AllwaysShow
  else
    value = CppEnums.VisibleNameTagType.eVisibleNameTagType_ImportantShow
  end
  setGuildPlayerNameTagVisible(value)
end
function PaGlobal_GameOption_All._elements.RankingPlayerNameTagVisible:set(value)
  if true == value then
    value = CppEnums.VisibleNameTagType.eVisibleNameTagType_AllwaysShow
  else
    value = CppEnums.VisibleNameTagType.eVisibleNameTagType_NoShow
  end
  setRankingPlayerNameTagVisible(value)
end
function PaGlobal_GameOption_All._elements.NickNameOrCharacterName:set(value)
  ToClient_setChatNameType(value)
end
function PaGlobal_GameOption_All._elements.GuideLineZoneChange:set(value)
  setRenderPlayerColor("ZoneChange", value)
end
function PaGlobal_GameOption_All._elements.GuideLineQuestNPC:set(value)
  setShowQuestActorColor(value)
end
function PaGlobal_GameOption_All._elements.GuideLineNpcIntimacy:set(value)
  setShowHumanRelation(value)
end
function PaGlobal_GameOption_All._elements.GuideLineWarAlly:set(value)
  setRenderPlayerColor("WarAlly", value)
end
function PaGlobal_GameOption_All._elements.GuideLineNonWarPlayer:set(value)
  setRenderPlayerColor("NonWarPlayer", value)
end
function PaGlobal_GameOption_All._elements.GuideLineEnemy:set(value)
  setRenderPlayerColor("Enemy", value)
end
function PaGlobal_GameOption_All._elements.GuideLineGuild:set(value)
  setRenderPlayerColor("Guild", value)
end
function PaGlobal_GameOption_All._elements.GuideLineParty:set(value)
  setRenderPlayerColor("Party", value)
end
function PaGlobal_GameOption_All._elements.GuideLinePartyMemberEffect:set(value)
  ToClient_getGameOptionControllerWrapper():setRenderHitEffectParty(value)
end
function PaGlobal_GameOption_All._elements.PetRender:set(value)
  setPetRender(value)
end
function PaGlobal_GameOption_All._elements.FairyRender:set(value)
  if 0 == value then
    setFairyRender(true)
  else
    setFairyRender(false)
  end
end
function PaGlobal_GameOption_All._elements.TentRender:set(value)
  if 0 == value then
    setHideOtherPlayerTent(false)
  else
    setHideOtherPlayerTent(true)
  end
end
function PaGlobal_GameOption_All._elements.MaidView:set(value)
  local maidViewElement = PaGlobal_GameOption_All._elements.MaidView
  local maxMaidValue = maidViewElement._sliderValueMax
  setMaidView(value * maxMaidValue)
end
function PaGlobal_GameOption_All._elements.ShowReputation:set(value)
  if false == _ContentsGroup_StatTierIcon then
    return
  end
  return setShowStatTier(value)
end
function PaGlobal_GameOption_All._elements.RenderHitEffect:set(value)
  setRenderHitEffect(value)
  if nil ~= FGlobal_SetMamageShow then
    FGlobal_SetMamageShow()
  end
end
function PaGlobal_GameOption_All._elements.DamageMeter:set(value)
  setOnDamageMeter(value)
end
function PaGlobal_GameOption_All._elements.ShowComboGuide:set(value)
  setShowComboGuide(value)
  if nil ~= Panel_MovieTheater_320 then
    Panel_MovieTheater320_JustClose()
  end
end
function PaGlobal_GameOption_All._elements.HideMastOnCarrier:set(value)
  setHideMastOnCarrier(value)
end
function PaGlobal_GameOption_All._elements.WorkerVisible:set(value)
  ToClient_setWorkerVisible(value)
end
function PaGlobal_GameOption_All._elements.WorldMapOpenType:set(value)
  if nil == value then
    return
  end
  local realValue = PaGlobal_GameOption_All._worldMapOpenTypeValue[value]
  if nil ~= realValue then
    setWorldmapOpenType(realValue)
  end
end
function PaGlobal_GameOption_All._elements.WorldmapCameraPitchType:set(value)
  if nil == value then
    return
  end
  local realValue = PaGlobal_GameOption_All._worldMapCameraPitchTypeValue[value]
  if nil ~= realValue then
    setWorldMapCameraPitchType(realValue)
  end
end
function PaGlobal_GameOption_All._elements.TextureQuality:set(value)
  setTextureQuality(PaGlobal_GameOption_All:radioButtonMapping_TextureQuality(value))
end
function PaGlobal_GameOption_All._elements.GraphicOption:set(value)
  setGraphicOption(PaGlobal_GameOption_All:radioButtonMapping_GraphicOption(value))
end
function PaGlobal_GameOption_All._elements.AntiAliasing:set(value)
  setAntiAliasingIndex(value)
end
function PaGlobal_GameOption_All._elements.SSAO:set(value)
  setSSAO(value)
end
function PaGlobal_GameOption_All._elements.PostFilter:set(value)
  if true == value then
    setPostFilter(2)
  else
    setPostFilter(1)
  end
end
function PaGlobal_GameOption_All._elements.Tessellation:set(value)
  setTessellation(value)
end
function PaGlobal_GameOption_All._elements.Dof:set(value)
  setDof(value)
end
function PaGlobal_GameOption_All._elements.Representative:set(value)
  setRepresentative(value)
end
function PaGlobal_GameOption_All._elements.CharacterEffect:set(value)
  setCharacterEffect(value)
end
function PaGlobal_GameOption_All._elements.SnowPoolOnlyInSafeZone:set(value)
  setSnowPoolOnlyInSafeZone(value)
end
function PaGlobal_GameOption_All._elements.BloodEffect:set(value)
  if true == value then
    setBloodEffect(2)
  else
    setBloodEffect(0)
  end
end
function PaGlobal_GameOption_All._elements.LensBlood:set(value)
  setLensBlood(value)
end
function PaGlobal_GameOption_All._elements.AutoOptimization:set(value)
  setAutoOptimization(value)
end
function PaGlobal_GameOption_All._elements.AutoOptimizationFrameLimit:set(value)
  local convertedFrame = math.ceil(value * 60)
  local autoOptimization = PaGlobal_GameOption_All._elements.AutoOptimization
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
function PaGlobal_GameOption_All._elements.UpscaleEnable:set(value)
  setUpscaleEnable(value)
end
function PaGlobal_GameOption_All._elements.PresentLock:set(value)
  setPresentLock(value)
end
function PaGlobal_GameOption_All._elements.DataOptimize:set(value)
  ToClient_SetUseDynamicBSS(true ~= value)
end
function PaGlobal_GameOption_All._elements.UseEffectFrameOptimization:set(value)
  setUseOptimizationEffectFrame(value)
end
function PaGlobal_GameOption_All._elements.EffectFrameOptimization:set(value)
  local convertedFrame = value * 24.9 + 0.1
  local useEffectFrameOptimization = PaGlobal_GameOption_All._elements.UseEffectFrameOptimization
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
function PaGlobal_GameOption_All._elements.UsePlayerEffectDistOptimization:set(value)
  setUsePlayerOptimizationEffectFrame(value)
end
function PaGlobal_GameOption_All._elements.PlayerEffectDistOptimization:set(value)
  local convertedFrame = value * 40 + 10
  local usePlayerEffectDistOptimization = PaGlobal_GameOption_All._elements.UsePlayerEffectDistOptimization
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
function PaGlobal_GameOption_All._elements.UseCharacterUpdateFrameOptimize:set(value)
  setUseCharacterDistUpdate(value)
end
function PaGlobal_GameOption_All._elements.UseOtherPlayerUpdate:set(value)
  FromClient_GameOption_All_OtherPlayerUpdate(value, true)
end
function PaGlobal_GameOption_All._elements.ShowSpawnableNPC:set(value)
  setUseShowSpawnableNPCUpdate(value)
end
function PaGlobal_GameOption_All._elements.Fov:set(value)
  value = value * 30 + 40
  setFov(value)
end
function PaGlobal_GameOption_All._elements.CameraEffectMaster:set(value)
  setCameraMasterPower(value)
end
function PaGlobal_GameOption_All._elements.CameraShakePower:set(value)
  setCameraShakePower(value)
end
function PaGlobal_GameOption_All._elements.MotionBlurPower:set(value)
  setMotionBlurPower(value)
end
function PaGlobal_GameOption_All._elements.CameraTranslatePower:set(value)
  setCameraTranslatePower(value)
end
function PaGlobal_GameOption_All._elements.CameraFovPower:set(value)
  setCameraFovPower(value)
end
function PaGlobal_GameOption_All._elements.MouseInvertX:set(value)
  setMouseInvertX(value)
end
function PaGlobal_GameOption_All._elements.MouseInvertY:set(value)
  setMouseInvertY(value)
end
function PaGlobal_GameOption_All._elements.MouseSensitivityX:set(value)
  local convertedValue = value * 1.9 + 0.1
  setMouseSensitivityX(convertedValue)
end
function PaGlobal_GameOption_All._elements.MouseSensitivityY:set(value)
  local convertedValue = value * 1.9 + 0.1
  setMouseSensitivityY(convertedValue)
end
function PaGlobal_GameOption_All._elements.GameMouseMode:set(value)
  setGameMouseMode(value)
end
function PaGlobal_GameOption_All._elements.IsUIModeMouseLock:set(value)
  setIsUIModeMouseLock(value)
end
function PaGlobal_GameOption_All._elements.GamePadEnable:set(value)
  if true == _ContentsGroup_useUISnappingOption then
    ToClient_SetUsePadControlPC(value)
  else
    setGamePadEnable(value)
  end
end
function PaGlobal_GameOption_All._elements.GamePadVibration:set(value)
  setGamePadVibration(value)
end
function PaGlobal_GameOption_All._elements.GamePadInvertX:set(value)
  setGamePadInvertX(value)
end
function PaGlobal_GameOption_All._elements.GamePadInvertY:set(value)
  setGamePadInvertY(value)
end
function PaGlobal_GameOption_All._elements.GamePadSensitivityX:set(value)
  local convertedValue = value * 1.9 + 0.1
  setGamePadSensitivityX(convertedValue)
end
function PaGlobal_GameOption_All._elements.GamePadSensitivityY:set(value)
  local convertedValue = value * 1.9 + 0.1
  setGamePadSensitivityY(convertedValue)
end
function PaGlobal_GameOption_All._elements.ConsolePadKeyType:set(value)
  if true == _ContentsGroup_isConsoleTest then
    setConsoleKeyType(value)
  end
end
function PaGlobal_GameOption_All._elements.ScreenShotQuality:set(value)
  setScreenShotQuality(value)
end
function PaGlobal_GameOption_All._elements.ScreenShotFormat:set(value)
  setScreenShotFormat(value)
end
function PaGlobal_GameOption_All._elements.WatermarkAlpha:set(value)
  setWatermarkAlpha(value)
end
function PaGlobal_GameOption_All._elements.WatermarkScale:set(value)
  setWatermarkScale(value)
end
function PaGlobal_GameOption_All._elements.WatermarkPosition:set(value)
  setWatermarkPosition(value)
end
function PaGlobal_GameOption_All._elements.WatermarkService:set(value)
  setWatermarkService(value)
end
function PaGlobal_GameOption_All._elements.ScreenMode:set(value)
  setScreenMode(value)
  ischangedeplay = true
end
function PaGlobal_GameOption_All._elements.ScreenResolution:set(value)
  local width = 1280
  local height = 720
  if -1 == value then
    width = PaGlobal_GameOption_All._userInitScreenResolution.width
    height = PaGlobal_GameOption_All._userInitScreenResolution.height
  else
    width = PaGlobal_GameOption_All._availableResolutionList:getDisplayModeWidth(value)
    height = PaGlobal_GameOption_All._availableResolutionList:getDisplayModeHeight(value)
  end
  setScreenResolution(width, height)
end
function PaGlobal_GameOption_All._elements.CropModeEnable:set(value)
  setCropModeEnable(value)
end
function PaGlobal_GameOption_All._elements.CropModeScaleX:set(value)
  local convertedScale = 0.5 + value * 0.5
  local cropModeEnable = PaGlobal_GameOption_All:getOptionValue("CropModeEnable")
  local cropModeScaleX = convertedScale
  local cropModeScaleY = PaGlobal_GameOption_All:getOptionValue("CropModeScaleY")
  if 0.95 < cropModeScaleX and 0.95 < cropModeScaleY and true == cropModeEnable then
    PaGlobal_GameOption_All:setOptionValue("CropModeEnable", false)
  end
  setCropModeScaleX(convertedScale)
end
function PaGlobal_GameOption_All._elements.CropModeScaleY:set(value)
  local convertedScale = 0.5 + value * 0.5
  local cropModeEnable = PaGlobal_GameOption_All:getOptionValue("CropModeEnable")
  local cropModeScaleX = PaGlobal_GameOption_All:getOptionValue("CropModeScaleX")
  local cropModeScaleY = convertedScale
  if 0.95 < cropModeScaleX and 0.95 < cropModeScaleY and true == cropModeEnable then
    PaGlobal_GameOption_All:setOptionValue("CropModeEnable", false)
  end
  setCropModeScaleY(convertedScale)
end
function PaGlobal_GameOption_All._elements.UIScale:set(value)
  local interval = PaGlobal_GameOption_All._elements.UIScale._sliderValueMax - PaGlobal_GameOption_All._elements.UIScale._sliderValueMin
  local convertedValue = (PaGlobal_GameOption_All._elements.UIScale._sliderValueMin + interval * value) * 0.01
  convertedValue = math.floor((convertedValue + 0.002) * 100) / 100
  setUIScale(convertedValue)
end
function PaGlobal_GameOption_All._elements.GammaValue:set(value)
  setGammaValue(value)
end
function PaGlobal_GameOption_All._elements.ContrastValue:set(value)
  if true == PaGlobal_GameOption_All._isContrast then
    PaGlobal_GameOption_All:SetCurrentValue("PageButton_LUT", 1, -1)
    PaGlobal_GameOption_All._isContrast = false
  end
  setContrastValue(value)
  PaGlobal_GameOption_All._contrastValue = PaGlobal_GameOption_All:FromRealValueToSliderValue(value, 0, 1)
end
function PaGlobal_GameOption_All._elements.EffectAlpha:set(value)
  value = PaGlobal_GameOption_All:FromSliderValueToRealValue(value, PaGlobal_GameOption_All._elements.EffectAlpha._sliderValueMin, PaGlobal_GameOption_All._elements.EffectAlpha._sliderValueMax)
  value = value * 0.01
  setEffectAlpha(value)
end
function PaGlobal_GameOption_All._elements.SkillPostEffect:set(value)
  setSkillPostEffect(value)
end
function PaGlobal_GameOption_All._elements.ColorBlind:set(value)
  ToClient_getGameUIManagerWrapper():setLuaCacheDataListNumber(__eColorBlindMode, value, CppEnums.VariableStorageType.eVariableStorageType_User)
  ToClient_ChangeColorBlindMode(value)
  FGlobal_Radar_SetColorBlindMode()
  FGlobal_Window_Servant_ColorBlindUpdate()
  if false == _ContentsGroup_RemasterUI_Main_Alert then
    FGlobal_ChangeEffectCheck()
    UIMain_QuestUpdate()
  end
end
function PaGlobal_GameOption_All._elements.BlackSpiritNotice:set(value)
  setBlackSpiritNotice(value)
end
function PaGlobal_GameOption_All._elements.ShowCashAlert:set(value)
  setShowCashAlert(not value)
end
function PaGlobal_GameOption_All._elements.ShowGuildLoginMessage:set(value)
  setShowGuildLoginMessage(value)
end
function PaGlobal_GameOption_All._elements.HideOtherPlayerTent:set(value)
  setHideOtherPlayerTent(value)
end
function PaGlobal_GameOption_All._elements.LUT:set(LUT)
  local strsplit = string.split("Slider_ContrastValue", "_")
  local controlTypeName = strsplit[1]
  local elementName = strsplit[2]
  if 1 == LUT and true == PaGlobal_GameOption_All:isOpen() then
    if false == PaGlobal_GameOption_All._isContrast then
      local messageBoxMemo = PAGetString(Defines.StringSheet_GAME, "LUA_GAMEOPTION_POPUP_NONCONTRAST")
      local messageBoxData = {
        title = PAGetString(Defines.StringSheet_GAME, "LUA_WARNING"),
        content = messageBoxMemo,
        functionYes = MessageBox_Empty_function,
        priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
      }
      MessageBox.showMessageBox(messageBoxData)
    end
    PaGlobal_GameOption_All:SetControlSetting(PaGlobal_GameOption_All._elements.ContrastValue, 0.5)
    PaGlobal_GameOption_All._isContrast = true
  else
    local value = math.floor(PaGlobal_GameOption_All._contrastValue + 0.005)
    local realValue = PaGlobal_GameOption_All:FromSliderValueToRealValue(value, PaGlobal_GameOption_All._elements.ContrastValue._sliderValueMin, PaGlobal_GameOption_All._elements.ContrastValue._sliderValueMax)
    PaGlobal_GameOption_All:setOptionValue(PaGlobal_GameOption_All._elements.ContrastValue, realValue)
    PaGlobal_GameOption_All._isContrast = false
  end
  setCameraLUTFilter(LUT)
end
function PaGlobal_GameOption_All._elements.RefuseFriend:set(value)
  setConsoleRefuseDirectFriend(value)
end
function PaGlobal_GameOption_All._elements.LUT:GetButtonText(LUT)
  local filterName = getCameraLUTFilterName(LUT)
  local filterString = PAGetString(Defines.StringSheet_GAME, "LUA_GAMEOPTION_PHOTOFILTER_" .. filterName)
  if filterName == LUTRecommandationName or filterName == LUTRecommandationName2 then
    filterString = filterString .. "  <PAColor0xffffce22>[" .. PAGetString(Defines.StringSheet_GAME, "LUA_OPTION_RECOMMANDATION") .. "]<PAOldColor>"
  end
  return filterString
end
function PaGlobal_GameOption_All._elements.LUT:GetButtonListSize(value)
  return getCameraLUTFilterSize()
end
function PaGlobal_GameOption_All._elements.EnableMusic:set(value)
  setEnableSoundMusic(value)
end
function PaGlobal_GameOption_All._elements.EnableSound:set(value)
  setEnableSoundFx(value)
end
function PaGlobal_GameOption_All._elements.EnableEnv:set(value)
  setEnableSoundEnv(value)
end
function PaGlobal_GameOption_All._elements.EnableRidingSound:set(value)
  setEnableRidingSound(value)
end
function PaGlobal_GameOption_All._elements.EnableWhisperMusic:set(value)
  setEnableSoundWhisper(value)
end
function PaGlobal_GameOption_All._elements.EnableTraySoundOnOff:set(value)
  setEnableSoundTray(value)
end
function PaGlobal_GameOption_All._elements.EnableAroundPlayMusic:set(value)
  setEnableAroundPlayMusic(value)
end
function PaGlobal_GameOption_All._elements.BattleSoundType:set(value)
  setEnableBattleSoundType(value)
end
function PaGlobal_GameOption_All._elements.EnableAudioFairy:set(value)
  setEnableFairySound(value)
end
function PaGlobal_GameOption_All._elements.VolumeMaster:set(value)
  setVolumeParamMaster(value * 100)
end
function PaGlobal_GameOption_All._elements.VolumeMusicPlay:set(value)
  setVolumeParamAroundPlayMusic(value * 100)
end
function PaGlobal_GameOption_All._elements.VolumeMusic:set(value)
  setVolumeParamMusic(value * 100)
end
function PaGlobal_GameOption_All._elements.VolumeFx:set(value)
  setVolumeParamFx(value * 100)
end
function PaGlobal_GameOption_All._elements.VolumeEnv:set(value)
  setVolumeParamEnv(value * 100)
end
function PaGlobal_GameOption_All._elements.VolumeDlg:set(value)
  setVolumeParamDialog(value * 100)
end
function PaGlobal_GameOption_All._elements.VolumeHitFxVolume:set(value)
  setVolumeParamHitFxVolume(value * 100)
end
function PaGlobal_GameOption_All._elements.VolumeHitFxWeight:set(value)
  setVolumeParamHitFxWeight(value * 100)
end
function PaGlobal_GameOption_All._elements.VolumeOtherPlayer:set(value)
  setVolumeParamOtherPlayer(value * 100)
end
function PaGlobal_GameOption_All._elements.VolumeFairy:set(value)
  setVolumeFairy(value * 100)
end
function PaGlobal_GameOption_All._elements.AlertNormalTrade:set(value)
  ToClient_SetMessageFilter(PaGlobal_GameOption_All.ALERT.NormalTrade, not value)
end
function PaGlobal_GameOption_All._elements.AlertRoyalTrade:set(value)
  ToClient_SetMessageFilter(PaGlobal_GameOption_All.ALERT.RoyalTrade, not value)
end
function PaGlobal_GameOption_All._elements.AlertOtherPlayerGetItem:set(value)
  ToClient_SetMessageFilter(PaGlobal_GameOption_All.ALERT.OtherPlayerGetItem, not value)
end
function PaGlobal_GameOption_All._elements.AlertLifeLevelUp:set(value)
  ToClient_SetMessageFilter(PaGlobal_GameOption_All.ALERT.LifeLevelUp, not value)
end
function PaGlobal_GameOption_All._elements.AlertItemMarket:set(value)
  ToClient_SetMessageFilter(PaGlobal_GameOption_All.ALERT.ItemMarket, not value)
end
function PaGlobal_GameOption_All._elements.AlertOtherMarket:set(value)
  ToClient_SetMessageFilter(PaGlobal_GameOption_All.ALERT.OtherMarket, not value)
end
function PaGlobal_GameOption_All._elements.AlertChangeRegion:set(value)
  ToClient_SetMessageFilter(PaGlobal_GameOption_All.ALERT.ChangeRegion, not value)
end
function PaGlobal_GameOption_All._elements.AlertFitnessLevelUp:set(value)
  ToClient_SetMessageFilter(PaGlobal_GameOption_All.ALERT.FitnessLevelUp, not value)
end
function PaGlobal_GameOption_All._elements.AlertTerritoryWar:set(value)
  ToClient_SetMessageFilter(PaGlobal_GameOption_All.ALERT.TerritoryWar, not value)
end
function PaGlobal_GameOption_All._elements.AlertGuildWar:set(value)
  ToClient_SetMessageFilter(PaGlobal_GameOption_All.ALERT.GuildWar, not value)
end
function PaGlobal_GameOption_All._elements.AlertEnchantSuccess:set(value)
  ToClient_SetMessageFilter(PaGlobal_GameOption_All.ALERT.EnchantSuccess, not value)
end
function PaGlobal_GameOption_All._elements.AlertEnchantFail:set(value)
  ToClient_SetMessageFilter(PaGlobal_GameOption_All.ALERT.EnchantFail, not value)
end
function PaGlobal_GameOption_All._elements.AlertGuildQuestMessage:set(value)
  ToClient_SetMessageFilter(PaGlobal_GameOption_All.ALERT.GuildQuestMessage, not value)
end
function PaGlobal_GameOption_All._elements.AlertNearMonster:set(value)
  ToClient_SetMessageFilter(PaGlobal_GameOption_All.ALERT.NearMonster, not value)
end
function PaGlobal_GameOption_All._elements.SelfPlayerOnlyEffect:set(value)
  setSelfPlayerOnlyEffect(value)
end
function PaGlobal_GameOption_All._elements.NearestPlayerOnlyEffect:set(value)
  setNearestPlayerOnlyEffect(value)
end
function PaGlobal_GameOption_All._elements.SelfPlayerOnlyLantern:set(value)
  setSelfPlayerOnlyLantern(value)
end
function PaGlobal_GameOption_All._elements.ShowStackHp:set(value)
  if true == _ContentsGroup_StackingHpBar then
    setShowStackHp(GameOptionApply_CharacterNameTag_StackHpBar(value))
  end
end
function ConsolePadType(value)
  selfPlayerSetConsolePadType(value)
end
function PaGlobal_GameOption_All._elements.HDRDisplayGamma:set(value)
  value = PaGlobal_GameOption_All:FromSliderValueToRealValue(value, PaGlobal_GameOption_All._elements.HDRDisplayGamma._sliderValueMin, PaGlobal_GameOption_All._elements.HDRDisplayGamma._sliderValueMax)
  setHdrDisplayGamma(value)
end
function PaGlobal_GameOption_All._elements.HDRDisplayMaxNits:set(value)
  value = PaGlobal_GameOption_All:FromSliderValueToRealValue(value, PaGlobal_GameOption_All._elements.HDRDisplayMaxNits._sliderValueMin, PaGlobal_GameOption_All._elements.HDRDisplayMaxNits._sliderValueMax)
  setHdrDisplayMaxNits(value)
end
function PaGlobal_GameOption_All._elements.UltraHighDefinition:set(value)
  _PA_LOG("\237\155\132\236\167\132", "UltraHighDefinition value : " .. tostring(value))
  setUltraHighDefinition(value)
end
function PaGlobal_GameOption_All._elements.UseLedAnimation:set(value)
  setUseLedAnimation(value)
end
function PaGlobal_GameOption_All._elements.UseGamePadQuickTurn:set(value)
  setGamePadQuickTurn(value)
end
function PaGlobal_GameOption_All._elements.ChatFilterNotice:set(value)
  local chat = ToClient_getChattingPanel(0)
  chat:setShowChatType(CppEnums.ChatType.Notice, value)
end
function PaGlobal_GameOption_All._elements.ChatFilterWorld:set(value)
  local chat = ToClient_getChattingPanel(0)
  chat:setShowChatType(CppEnums.ChatType.WorldWithItem, value)
end
function PaGlobal_GameOption_All._elements.ChatFilterPublic:set(value)
  local chat = ToClient_getChattingPanel(0)
  chat:setShowChatType(CppEnums.ChatType.Public, value)
end
function PaGlobal_GameOption_All._elements.ChatFilterWhisper:set(value)
  local chat = ToClient_getChattingPanel(0)
  chat:setShowChatType(CppEnums.ChatType.Private, value)
end
function PaGlobal_GameOption_All._elements.ChatFilterParty:set(value)
  local chat = ToClient_getChattingPanel(0)
  chat:setShowChatType(CppEnums.ChatType.Party, value)
end
function PaGlobal_GameOption_All._elements.ChatFilterGuild:set(value)
  local chat = ToClient_getChattingPanel(0)
  chat:setShowChatType(CppEnums.ChatType.Guild, value)
end
function PaGlobal_GameOption_All._elements.ChatFilterServer:set(value)
  local chat = ToClient_getChattingPanel(0)
  chat:setShowChatType(CppEnums.ChatType.World, value)
end
function PaGlobal_GameOption_All._elements.ChatFilterBattle:set(value)
  local chat = ToClient_getChattingPanel(0)
  chat:setShowChatType(CppEnums.ChatType.Battle, value)
end
function PaGlobal_GameOption_All._elements.ChatFilterTeam:set(value)
  local chat = ToClient_getChattingPanel(0)
  chat:setShowChatType(CppEnums.ChatType.Team, value)
end
function PaGlobal_GameOption_All._elements.ChatFilterSystemAll:set(value)
  local chat = ToClient_getChattingPanel(0)
  chat:setShowChatType(CppEnums.ChatType.System, value)
end
function PaGlobal_GameOption_All._elements.ChatFilterSystemPrivateItem:set(value)
  local chat = ToClient_getChattingPanel(0)
  if true == chat:isShowChatType(CppEnums.ChatType.System) then
    chat:setShowChatSystemType(CppEnums.ChatSystemType.PrivateItem, value)
  end
end
function PaGlobal_GameOption_All._elements.ChatFilterSystemPartyItem:set(value)
  local chat = ToClient_getChattingPanel(0)
  if true == chat:isShowChatType(CppEnums.ChatType.System) then
    chat:setShowChatSystemType(CppEnums.ChatSystemType.PartyItem, value)
  end
end
function PaGlobal_GameOption_All._elements.ChatFilterSystemMarket:set(value)
  local chat = ToClient_getChattingPanel(0)
  if true == chat:isShowChatType(CppEnums.ChatType.System) then
    chat:setShowChatSystemType(CppEnums.ChatSystemType.Market, value)
  end
end
function PaGlobal_GameOption_All._elements.ChatFilterSystemWorker:set(value)
  local chat = ToClient_getChattingPanel(0)
  if true == chat:isShowChatType(CppEnums.ChatType.System) then
    chat:setShowChatSystemType(CppEnums.ChatSystemType.Worker, value)
  end
end
function PaGlobal_GameOption_All._elements.ChatFilterSystemHarvest:set(value)
  local chat = ToClient_getChattingPanel(0)
  if true == chat:isShowChatType(CppEnums.ChatType.System) then
    chat:setShowChatSystemType(CppEnums.ChatSystemType.Harvest, value)
  end
end
function PaGlobal_GameOption_All._elements.GraphicPreset:set(value)
  ToClient_SetConsoleGraphicPreset(value)
end
function PaGlobal_GameOption_All._elements.KeyCustomMode:set(value)
  local beforekeyCustomPadMode = PaGlobal_GameOption_All._keyCustomPadMode
  PaGlobal_GameOption_All._keyCustomPadMode = 1 == value
  if PaGlobal_GameOption_All._keyCustomPadMode == beforekeyCustomPadMode then
    return
  end
  PaGlobal_GameOption_All:ResetKeyCustomString()
end
function PaGlobal_GameOption_All._elements.UseDefaultCostumeOtherPlayer:set(value)
  ToClient_setUseDefaultCostumeOtherPlayer(value)
end
function PaGlobal_GameOption_All._elements.UseShowLootingPopupMenu:set(value)
  ToClient_setUseShowLootingPopupMenu(value)
end
