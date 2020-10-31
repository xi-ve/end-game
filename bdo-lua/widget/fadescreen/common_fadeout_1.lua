function PaGlobal_FadeOut:initialize()
  if true == PaGlobal_FadeOut._initialize then
    return
  end
  PaGlobal_FadeOut._ui._loadingText = UI.getChildControl(Common_FadeOut, "StaticText_LoadingEffect")
  PaGlobal_FadeOut._ui._loadingText:EraseAllEffect()
  if true == _ContetnsGroup_ChangeLoadingImg then
    PaGlobal_FadeOut._ui.temp_img1 = UI.getChildControl(Common_FadeOut, "Static_Img1")
  end
  PaGlobal_FadeOut._ui._staticText_Desc = UI.getChildControl(Common_FadeOut, "StaticText_Desc")
  PaGlobal_FadeOut:registEventHandler()
  PaGlobal_FadeOut:validate()
  PaGlobal_FadeOut:initBackGroundImage()
  PaGlobal_FadeOut._initialize = true
end
function PaGlobal_FadeOut:registEventHandler()
  Common_FadeOut:RegisterShowEventFunc(true, "PaGlobal_FadeOutShowAni()")
  registerEvent("onScreenResize", "PaGlobal_FadeOutResize")
  registerEvent("FromClinet_FadeOut", "PaGlobal_FadeOutOpen")
  registerEvent("FromClient_BattleRoyaleLoading", "PaGlobal_FadeOutOpen")
  registerEvent("FromClient_CloseBattleRoyaleEnterLoading", "PaGlobal_FadeOutClose")
end
function PaGlobal_FadeOut:initBackGroundImage()
  if nil == Common_FadeOut then
    return
  end
  if false == _ContetnsGroup_ChangeLoadingImg then
    return
  end
  PaGlobal_FadeOut._bgImageTexture = {}
  if true == isGameTypeKorea() then
    PaGlobal_FadeOut._bgImageTexture = {
      [0] = "New_UI_Common_forLua/Window/Lobby/bgOdyllita_1.dds ",
      [1] = "New_UI_Common_forLua/Window/Lobby/bgOdyllita_2.dds ",
      [2] = "New_UI_Common_forLua/Window/Lobby/bgOdyllita_3.dds ",
      [3] = "New_UI_Common_forLua/Window/Lobby/bgOdyllita_4.dds "
    }
    self._totalImageCount = 4
  elseif true == _ContentsOption_CH_LoadingImage then
    PaGlobal_FadeOut._bgImageTexture = {
      [0] = "New_UI_Common_forLua/Window/Lobby/bgCalpeon_1.dds ",
      [1] = "New_UI_Common_forLua/Window/Lobby/bgCalpeon_2.dds ",
      [2] = "New_UI_Common_forLua/Window/Lobby/bgCalpeon_3.dds ",
      [3] = "New_UI_Common_forLua/Window/Lobby/bgCalpeon_4.dds ",
      [4] = "New_UI_Common_forLua/Window/Lobby/bgCalpeon_5.dds ",
      [5] = "New_UI_Common_forLua/Window/Lobby/bgCalpeon_6.dds "
    }
    self._totalImageCount = 6
  else
    PaGlobal_FadeOut._bgImageTexture = {
      [0] = "New_UI_Common_forLua/Window/Lobby/bgDraganServer_1.dds "
    }
    self._totalImageCount = 1
  end
  self._bgEmptyControl = {}
  for idx = 0, self._totalImageCount - 1 do
    local emptyControl = UI.createAndCopyBasePropertyControl(Common_FadeOut, "Static_Img1", Common_FadeOut, "Static_FadeBg_" .. tostring(idx))
    emptyControl:SetHorizonCenter()
    emptyControl:SetVerticalMiddle()
    emptyControl:ChangeTextureInfoNameDefault(self._bgImageTexture[idx])
    emptyControl:getBaseTexture():setUV(0, 0, 1, 1)
    emptyControl:setRenderTexture(emptyControl:getBaseTexture())
    self._bgEmptyControl[idx] = emptyControl
  end
  Common_FadeOut:SetChildIndex(self._ui._loadingText, 9999)
end
function PaGlobal_Common_FadeOutUpdate(deltaTime)
  if PaGlobal_FadeOut._fadeDuration < PaGlobal_FadeOut._fadeDruationMaxTime then
    PaGlobal_FadeOut._fadeDuration = PaGlobal_FadeOut._fadeDuration + deltaTime
    PaGlobal_FadeOut:FadeLoadingImagePerFrame(deltaTime)
    return
  end
  PaGlobal_FadeOutEscapeClose()
end
function PaGlobal_FadeOut:showAni()
  if nil == Common_FadeOut then
    return
  end
  local showAni = Common_FadeOut:addColorAnimation(0, PaGlobal_FadeOut._ANIMATION_TIME, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
  showAni:SetStartColor(Defines.Color.C_00000000)
  showAni:SetEndColor(Defines.Color.C_FF000000)
  showAni:SetStartIntensity(3)
  showAni:SetEndIntensity(1)
  showAni.IsChangeChild = false
end
function PaGlobal_FadeOut:hideAni()
  if nil == Common_FadeOut then
    return
  end
  local closeAni = Common_FadeOut:addColorAnimation(0, PaGlobal_FadeOut._ANIMATION_TIME, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
  closeAni:SetStartColor(Defines.Color.C_00000000)
  closeAni:SetEndColor(Defines.Color.C_FF000000)
  closeAni:SetStartIntensity(3)
  closeAni:SetEndIntensity(1)
  closeAni.IsChangeChild = false
  closeAni:SetHideAtEnd(true)
end
function PaGlobal_FadeOut:resize()
  if nil == Common_FadeOut then
    return
  end
  if false == PaGlobal_FadeOut._initialize then
    return
  end
  Common_FadeOut:SetSize(getScreenSizeX(), getScreenSizeY())
  PaGlobal_FadeOut._ui._loadingText:ComputePos()
  PaGlobal_FadeOut._ui._loadingText:SetPosX(getScreenSizeX() / 2 - (PaGlobal_FadeOut._ui._loadingText:GetTextSpan().x + PaGlobal_FadeOut._ui._loadingText:GetTextSizeX()) / 2)
end
function PaGlobal_FadeOut:open()
  if nil == Common_FadeOut then
    return
  end
  PaGlobal_FadeOut:resize()
  PaGlobal_FadeOut._ui._loadingText:SetShow(true)
  PaGlobal_FadeOut._ui._loadingText:EraseAllEffect()
  PaGlobal_FadeOut._ui._loadingText:AddEffect("UI_Loading_01A", true, 0, 0)
  Common_FadeOut:SetShow(true, true)
  if true == _ContetnsGroup_ChangeLoadingImg then
    for idx = 0, self._totalImageCount - 1 do
      if nil ~= PaGlobal_FadeOut._bgEmptyControl[idx] then
        PaGlobal_FadeOut._bgEmptyControl[idx]:SetShow(false)
        PaGlobal_FadeOut._bgEmptyControl[idx]:SetColor(Defines.Color.C_00FFFFFF)
        PaGlobal_FadeOut._bgEmptyControl[idx]:SetSize(getScreenSizeX(), getScreenSizeY())
        PaGlobal_FadeOut._bgEmptyControl[idx]:ComputePos()
      end
      PaGlobal_FadeOut._currentFadeTIme = 0
      PaGlobal_FadeOut._isFadeProcessing = false
      PaGlobal_FadeOut._isImageFadeOut = false
    end
  end
  Common_FadeOut:RegisterUpdateFunc("PaGlobal_Common_FadeOutUpdate")
end
function PaGlobal_FadeOut:close()
  if nil == Common_FadeOut then
    return
  end
  if true == Common_FadeOut:GetShow() then
    Common_FadeOut:SetShow(false, true)
    PaGlobal_FadeOut._ui._loadingText:SetShow(false)
    PaGlobal_FadeOut._ui._loadingText:EraseAllEffect()
    PaGlobal_FadeOut._fadeDuration = 0
    Common_FadeOut:ClearUpdateLuaFunc()
  end
end
function PaGlobal_FadeOut:validate()
  PaGlobal_FadeOut._ui._loadingText:isValidate()
end
function PaGlobal_FadeOut:FadeLoadingImagePerFrame(deltaTime)
  if false == _ContetnsGroup_ChangeLoadingImg or false == Common_FadeOut:GetShow() then
    return
  end
  if nil == PaGlobal_FadeOut._bgImageTexture or nil == PaGlobal_FadeOut._bgEmptyControl then
    return
  end
  if false == PaGlobal_FadeOut._isImageFadeOut then
    local randomIdx = 0
    if 1 < PaGlobal_FadeOut._totalImageCount then
      randomIdx = math.random(0, PaGlobal_FadeOut._totalImageCount - 1)
    end
    PaGlobal_FadeOut._currentImageIdx = randomIdx
    if nil ~= PaGlobal_FadeOut._bgEmptyControl[PaGlobal_FadeOut._currentImageIdx] then
      PaGlobal_FadeOut._isImageFadeOut = true
      PaGlobal_FadeOut._isFadeProcessing = false
      PaGlobal_FadeOut._bgEmptyControl[PaGlobal_FadeOut._currentImageIdx]:SetShow(true)
      local showAni = PaGlobal_FadeOut._bgEmptyControl[PaGlobal_FadeOut._currentImageIdx]:addColorAnimation(0, PaGlobal_FadeOut._imageFadeTime, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
      showAni:SetStartColor(Defines.Color.C_00FFFFFF)
      showAni:SetEndColor(Defines.Color.C_FFFFFFFF)
      showAni:SetStartIntensity(1)
      showAni:SetEndIntensity(1)
      PaGlobal_FadeOut._currentFadeTIme = 0
    end
  elseif nil ~= PaGlobal_FadeOut._bgEmptyControl[PaGlobal_FadeOut._currentImageIdx] then
    PaGlobal_FadeOut._currentFadeTIme = PaGlobal_FadeOut._currentFadeTIme + deltaTime
    if PaGlobal_FadeOut._imageFadeTime * 2 < PaGlobal_FadeOut._currentFadeTIme and false == PaGlobal_FadeOut._isFadeProcessing then
      PaGlobal_FadeOut._isFadeProcessing = true
      local offAni = PaGlobal_FadeOut._bgEmptyControl[PaGlobal_FadeOut._currentImageIdx]:addColorAnimation(0, PaGlobal_FadeOut._imageFadeTime, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
      offAni:SetStartColor(Defines.Color.C_FFFFFFFF)
      offAni:SetEndColor(Defines.Color.C_00FFFFFF)
      offAni:SetStartIntensity(1)
      offAni:SetEndIntensity(1)
      offAni:SetHideAtEnd(true)
    elseif PaGlobal_FadeOut._imageFadeTime * 2 + 1 < PaGlobal_FadeOut._currentFadeTIme then
      PaGlobal_FadeOut._isImageFadeOut = false
    end
  else
    PaGlobal_FadeOut._isFadeProcessing = false
  end
end
