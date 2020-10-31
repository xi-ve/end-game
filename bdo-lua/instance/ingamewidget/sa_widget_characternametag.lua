local UI_ANI_ADV = CppEnums.PAUI_ANIM_ADVANCE_TYPE
local UI_AV = CppEnums.PA_UI_ALIGNVERTICAL
local UI_TT = CppEnums.PAUI_TEXTURE_TYPE
local UI_color = Defines.Color
local UI_TM = CppEnums.TextMode
local UI_classType = CppEnums.ClassType
local ActorProxyType = {
  isActorProxy = 0,
  isCharacter = 1,
  isPlayer = 2,
  isSelfPlayer = 3,
  isOtherPlayer = 4,
  isAlterego = 5,
  isMonster = 6,
  isNpc = 7,
  isDeadBody = 8,
  isVehicle = 9,
  isGate = 10,
  isHouseHold = 11,
  isInstallationActor = 12,
  isCollect = 13,
  isInstanceObject = 14
}
local actorProxyBufferSize = {
  [ActorProxyType.isOtherPlayer] = 300,
  [ActorProxyType.isMonster] = 150
}
local actorProxyCapacitySize = {
  [ActorProxyType.isOtherPlayer] = 50,
  [ActorProxyType.isMonster] = 25
}
local basePanel = {
  [ActorProxyType.isOtherPlayer] = Panel_Copy_OtherPlayer,
  [ActorProxyType.isMonster] = Panel_Copy_Monster
}
local function init()
  for _, value in pairs(ActorProxyType) do
    if basePanel[value] then
      ToClient_SetNameTagPanel(value, basePanel[value])
      if nil ~= actorProxyBufferSize[value] and nil ~= actorProxyCapacitySize[value] then
        ToClient_InitializeOverHeadPanelPool(value, actorProxyBufferSize[value], actorProxyCapacitySize[value])
      end
    end
  end
end
init()
local _stackHpBarColor = {
  [-1] = Defines.Color.C_FF000000,
  [0] = 4291035148,
  [1] = 4294934576,
  [2] = 4294953029,
  [3] = 4287220554,
  [4] = 4281445845,
  [5] = 4278220233,
  [6] = 4289076667
}
local _normalHpBarColor = {
  defaultColor = Defines.Color.C_FFD20000,
  blindMode_Red = Defines.Color.C_FFFFCE22,
  blindMode_Blue = Defines.Color.C_FFFFCE22,
  partyMemeberColor = Defines.Color.C_FF008AFF
}
local _mpBarColor = {
  ep_Character = Defines.Color.C_FF81CE1C,
  fp_Character = Defines.Color.C_FFF0D147,
  bp_Character = Defines.Color.C_FFBFBFB7,
  darkelf = Defines.Color.C_FF8B4DFF,
  mp_Character = Defines.Color.C_FF367CFE
}
local _defaultUsePotionPosY
local _characterHpBarContainer = {}
local _maxHpCount = 1000
local _maxHpBarColorCount = 7
local _isStackOvered = false
local TypeByLoadData = {
  [ActorProxyType.isOtherPlayer] = function(actorKeyRaw, targetPanel, actorProxyWrapper)
    local insertedArray = Array.new()
    settingHpBarInitState(actorKeyRaw, targetPanel, actorProxyWrapper)
    settingHpBar(actorKeyRaw, targetPanel, actorProxyWrapper)
  end,
  [ActorProxyType.isMonster] = function(actorKeyRaw, targetPanel, actorProxyWrapper)
    settingHpBarInitState(actorKeyRaw, targetPanel, actorProxyWrapper)
    settingHpBar(actorKeyRaw, targetPanel, actorProxyWrapper)
  end
}
local function CharacterNameTag_SetHpBarContainer(actorKeyRaw, actorProxy, targetPanel)
  local hpRate = actorProxy:getHp() % _maxHpCount / _maxHpCount * 100
  local modifiedHpIdx = math.floor(actorProxy:getHp() / _maxHpCount)
  local hpRatePerMaxHP = actorProxy:getHp() * 100 / actorProxy:getMaxHp()
  local stackHpBack = UI.getChildControl(targetPanel, "ProgressBack")
  local stackHpBackColor = UI.getChildControl(targetPanel, "Progress2_StackHpBackColor")
  local stackHpbar = UI.getChildControl(targetPanel, "CharacterHPGageProgress")
  local hpPointer = UI.getChildControl(targetPanel, "StaticText_HP")
  local isColorBlindMode = ToClient_getGameUIManagerWrapper():getLuaCacheDataListNumber(__eColorBlindMode)
  if nil == _characterHpBarContainer[actorKeyRaw] then
    local hpBarData = {}
    hpBarData.stackHpBar = stackHpbar
    hpBarData.stackHpBarBackColor = stackHpBackColor
    hpBarData.hpPointer = hpPointer
    local colorValue = modifiedHpIdx % _maxHpBarColorCount
    local backColorValue = colorValue - 1
    if modifiedHpIdx <= 0 then
      backColorValue = -1
    elseif backColorValue < 0 then
      backColorValue = _maxHpBarColorCount - 1
    end
    if modifiedHpIdx > _maxHpBarColorCount * 2 then
      hpBarData.stackHpBarBackColor:SetColor(_stackHpBarColor[_maxHpBarColorCount - 1])
      hpBarData.stackHpBar:SetColor(_stackHpBarColor[_maxHpBarColorCount - 1])
    else
      hpBarData.stackHpBarBackColor:SetColor(_stackHpBarColor[backColorValue])
      hpBarData.stackHpBar:SetColor(_stackHpBarColor[colorValue])
    end
    hpBarData.stackHpBar:SetAniSpeed(0)
    hpBarData.stackHpBar:SetProgressRate(hpRate)
    hpBarData.stackHpBarBackColor:SetAniSpeed(0)
    hpBarData.stackHpBarBackColor:SetProgressRate(100)
    hpBarData.targetHpIdx = modifiedHpIdx
    hpBarData.currentHpIdx = modifiedHpIdx
    hpBarData.currentHpRate = hpRate
    hpBarData.hpBack = stackHpBack
    _characterHpBarContainer[actorKeyRaw] = hpBarData
  else
    _characterHpBarContainer[actorKeyRaw].stackHpBar = stackHpbar
    _characterHpBarContainer[actorKeyRaw].stackHpBarBackColor = stackHpBackColor
    _characterHpBarContainer[actorKeyRaw].targetHpIdx = modifiedHpIdx
    _characterHpBarContainer[actorKeyRaw].currentHpRate = hpRate
    _characterHpBarContainer[actorKeyRaw].hpPointer = hpPointer
  end
  if modifiedHpIdx == _characterHpBarContainer[actorKeyRaw].currentHpIdx then
    _characterHpBarContainer[actorKeyRaw].stackHpBar:SetProgressRate(hpRate)
  end
end
local function CharacterNameTag_FreeHpBarContainer(actorKeyRaw)
  _characterHpBarContainer[actorKeyRaw] = nil
end
local hideTimeType = {
  overHeadUI = 0,
  preemptiveStrike = 1,
  bubbleBox = 2,
  murdererEnd = 3
}
local isFourty = false
local isTwenty = false
local furnitureCheck = false
local function settingHpBarInitState(actorKeyRaw, targetPanel, actorProxyWrapper)
  local actorProxy = actorProxyWrapper:get()
  if nil == actorProxy then
    return
  end
  local hpBack, hpLater, hpMain
  if actorProxy:isKingOrLordTent() then
    hpBack = UI.getChildControl(targetPanel, "KingOrLordTentProgressBack")
    hpLater = UI.getChildControl(targetPanel, "KingOrLordTentProgress2_HpLater")
    hpMain = UI.getChildControl(targetPanel, "KingOrLordTentHPGageProgress")
  elseif actorProxy:isLargeHpBarCharacter() then
    hpBack = UI.getChildControl(targetPanel, "KingOrLordTentProgressBack")
    hpLater = UI.getChildControl(targetPanel, "KingOrLordTentProgress2_HpLater")
    hpMain = UI.getChildControl(targetPanel, "KingOrLordTentHPGageProgress")
  else
    hpBack = UI.getChildControl(targetPanel, "ProgressBack")
    hpLater = UI.getChildControl(targetPanel, "Progress2_HpLater")
    hpMain = UI.getChildControl(targetPanel, "CharacterHPGageProgress")
  end
  local characterStaticStatus = actorProxy:getCharacterStaticStatus()
  if nil == hpBack or nil == hpLater or nil == hpMain or nil == characterStaticStatus then
    return
  end
  hpMain:ResetVertexAni(true)
  hpLater:ResetVertexAni(true)
  hpMain:SetAlpha(1)
  hpLater:SetAlpha(1)
  if actorProxy:isSelfPlayer() then
    local usePotion = UI.getChildControl(targetPanel, "StaticText_UsePotion")
    usePotion:SetShow(false)
  elseif true == actorProxy:isPlayer() then
    CharacterNameTag_SetHpBarContainer(actorKeyRaw, actorProxy, targetPanel)
  elseif true == actorProxy:isReplayActor() then
    CharacterNameTag_SetHpBarContainer(actorKeyRaw, actorProxy, targetPanel)
  end
end
local beforeMaxHp = {}
local rulerControl = {}
function checkAvailableRular(index, rularCount)
  if 1000 < rularCount then
    return false
  elseif 100 <= rularCount then
    if 9 == index % 10 then
      return true
    end
  elseif 40 <= rularCount then
    if 1 == index % 2 then
      return true
    end
  else
    return true
  end
  return false
end
local function settingHpBar(actorKeyRaw, targetPanel, actorProxyWrapper)
  local actorProxy = actorProxyWrapper:get()
  if nil == actorProxy then
    return
  end
  local isColorBlindMode = ToClient_getGameUIManagerWrapper():getLuaCacheDataListNumber(__eColorBlindMode)
  local hpBack, hpLater, hpMain, hpName
  if actorProxy:isKingOrLordTent() then
    hpBack = UI.getChildControl(targetPanel, "KingOrLordTentProgressBack")
    hpLater = UI.getChildControl(targetPanel, "KingOrLordTentProgress2_HpLater")
    hpMain = UI.getChildControl(targetPanel, "KingOrLordTentHPGageProgress")
  elseif actorProxy:isLargeHpBarCharacter() then
    hpBack = UI.getChildControl(targetPanel, "KingOrLordTentProgressBack")
    hpLater = UI.getChildControl(targetPanel, "KingOrLordTentProgress2_HpLater")
    hpMain = UI.getChildControl(targetPanel, "KingOrLordTentHPGageProgress")
  else
    hpBack = UI.getChildControl(targetPanel, "ProgressBack")
    hpLater = UI.getChildControl(targetPanel, "Progress2_HpLater")
    hpMain = UI.getChildControl(targetPanel, "CharacterHPGageProgress")
  end
  local characterName = UI.getChildControl(targetPanel, "CharacterName")
  characterName:SetText(actorProxyWrapper:getName())
  if false == ToClient_isConsole() and true == ToClient_isNationSiegeBoss(actorProxyWrapper:getCharacterKeyRaw()) then
    hpBack = UI.getChildControl(targetPanel, "KingOrLordTentProgressBack")
    hpLater = UI.getChildControl(targetPanel, "KingOrLordTentProgress2_HpLater")
    hpMain = UI.getChildControl(targetPanel, "KingOrLordTentHPGageProgress")
  end
  local characterStaticStatus = actorProxy:getCharacterStaticStatus()
  if nil == hpBack or nil == hpLater or nil == hpMain or nil == characterStaticStatus then
    return
  end
  if characterStaticStatus._isHiddenHp and not actorProxy:isInstallationActor() then
    hpBack:SetShow(false)
    hpLater:SetShow(false)
    hpMain:SetShow(false)
    characterName:SetShow(false)
    return
  end
  if actorProxy:isPlayer() then
    if false == _ContentsGroup_StackingHpBar then
      local prevRate = hpMain:GetProgressRate()
      local isParty = Requestparty_isPartyPlayer(actorKeyRaw)
      local playerActorProxyWrapper = getPlayerActor(actorKeyRaw)
      local isArenaAreaOrZone = playerActorProxyWrapper:get():isArenaAreaRegion() or playerActorProxyWrapper:get():isArenaZoneRegion() or playerActorProxyWrapper:get():isCompetitionDefined() or playerActorProxyWrapper:get():isGuildTeamBattleAttend()
      local hpRate = actorProxy:getHp() * 100 / actorProxy:getMaxHp()
      if prevRate > hpRate then
        hpMain:SetVertexAniRun("Ani_Color_Damage_0", true)
        hpLater:SetVertexAniRun("Ani_Color_Damage_White", true)
      elseif prevRate < hpRate then
        hpMain:ResetVertexAni(true)
        hpLater:ResetVertexAni(true)
        hpMain:SetAlpha(1)
        hpLater:SetAlpha(1)
      end
      hpMain:SetProgressRate(hpRate)
      hpLater:SetProgressRate(hpRate)
      local isShow = false == actorProxy:isHideTimeOver(hideTimeType.overHeadUI) or isParty or isArenaAreaOrZone
      hpMain:SetShow(true)
      characterName:SetShow(true)
      hpBack:SetShow(isShow)
      hpLater:SetShow(isShow)
      hpMain:SetShow(isShow)
      local x1, y1, x2, y2
      if isParty then
        hpMain:ChangeTextureInfoNameAsync("new_ui_common_forlua/default/default_gauges.dds")
        x1, y1, x2, y2 = setTextureUV_Func(hpMain, 1, 63, 233, 69)
      else
        if 0 == isColorBlindMode then
          hpMain:ChangeTextureInfoNameAsync("new_ui_common_forlua/default/default_gauges.dds")
          x1, y1, x2, y2 = setTextureUV_Func(hpMain, 206, 112, 255, 115)
        elseif 1 == isColorBlindMode then
          hpMain:ChangeTextureInfoNameAsync("new_ui_common_forlua/default/Default_Gauges_01.dds")
          x1, y1, x2, y2 = setTextureUV_Func(hpMain, 1, 247, 255, 250)
        elseif 2 == isColorBlindMode then
          hpMain:ChangeTextureInfoNameAsync("new_ui_common_forlua/default/Default_Gauges_01.dds")
          x1, y1, x2, y2 = setTextureUV_Func(hpMain, 1, 247, 255, 250)
        end
        hpMain:getBaseTexture():setUV(x1, y1, x2, y2)
      end
      hpMain:getBaseTexture():setUV(x1, y1, x2, y2)
      hpMain:setRenderTexture(hpMain:getBaseTexture())
    else
      local isParty = Requestparty_isPartyPlayer(actorKeyRaw)
      local playerActorProxyWrapper = getPlayerActor(actorKeyRaw)
      local isArenaAreaOrZone = playerActorProxyWrapper:get():isArenaAreaRegion() or playerActorProxyWrapper:get():isArenaZoneRegion() or playerActorProxyWrapper:get():isCompetitionDefined() or playerActorProxyWrapper:get():isGuildTeamBattleAttend()
      local isShow = false == actorProxy:isHideTimeOver(hideTimeType.overHeadUI) or isParty or isArenaAreaOrZone
      local hpPointer = UI.getChildControl(targetPanel, "StaticText_HP")
      local hpRate = actorProxy:getHp() * 100 / actorProxy:getMaxHp()
      if true == GameOption_GetShowStackHp() and true == _ContentsGroup_StackingHpBar then
        hpBack = UI.getChildControl(targetPanel, "ProgressBack")
        hpMain = UI.getChildControl(targetPanel, "Progress2_StackHpBackColor")
        hpLater = UI.getChildControl(targetPanel, "CharacterHPGageProgress")
        hpBack:SetShow(isShow)
        hpLater:SetShow(isShow)
        hpMain:SetShow(isShow)
        hpPointer:SetShow(isShow)
        characterName:SetShow(isShow)
        local pointerHalfSize = hpPointer:GetSizeX() * 0.5
        hpPointer:SetPosX(hpBack:GetPosX() + 0.01 * hpRate * hpBack:GetSizeX() - pointerHalfSize)
        if true == isShow then
          CharacterNameTag_SetHpBarContainer(actorKeyRaw, actorProxy, targetPanel)
          targetPanel:RegisterUpdateFunc("PaGlobal_WaitUntilHpBarChange_UpdateFunc")
        else
          CharacterNameTag_FreeHpBarContainer(actorKeyRaw)
        end
      else
        local prevRate = hpMain:GetProgressRate()
        hpBack:SetShow(isShow)
        hpLater:SetShow(isShow)
        hpMain:SetShow(isShow)
        hpPointer:SetShow(false)
        characterName:SetShow(isShow)
        if true == isParty then
          hpMain:SetColor(_normalHpBarColor.partyMemeberColor)
        elseif 0 == isColorBlindMode then
          hpMain:SetColor(_normalHpBarColor.defaultColor)
        elseif 1 == isColorBlindMode then
          hpMain:SetColor(_normalHpBarColor.blindMode_Red)
        elseif 2 == isColorBlindMode then
          hpMain:SetColor(_normalHpBarColor.blindMode_Blue)
        end
        hpMain:SetAniSpeed(0)
        hpMain:SetProgressRate(hpRate)
        if true == _ContentsGroup_StackingHpBar then
          local data = {}
          data.stackHpBar = hpMain
          data.stackHpBarBackColor = hpLater
          data.hpBack = hpBack
          data.hpPointer = hpPointer
          _characterHpBarContainer[actorKeyRaw] = data
        end
      end
    end
  elseif actorProxy:isMonster() then
    local prevRate = hpMain:GetProgressRate()
    local hpRate = actorProxy:getHp() * 100 / actorProxy:getMaxHp()
    local characterActorProxyWrapper = getCharacterActor(actorKeyRaw)
    characterName:SetShow(true)
    hpBack:SetShow(true)
    hpLater:SetShow(true)
    hpMain:SetShow(true)
    if checkActiveCondition(characterActorProxyWrapper:getCharacterKey()) == true then
      hpMain:SetProgressRate(hpRate)
      hpLater:SetProgressRate(hpRate)
      if prevRate > hpRate then
        hpMain:SetVertexAniRun("Ani_Color_Damage_0", true)
        hpLater:SetVertexAniRun("Ani_Color_Damage_White", true)
      elseif prevRate < hpRate then
        if hpLater:GetCurrentProgressRate() < hpMain:GetCurrentProgressRate() then
          hpLater:SetCurrentProgressRate(hpMain:GetCurrentProgressRate())
        end
        hpMain:ResetVertexAni(true)
        hpLater:ResetVertexAni(true)
        hpMain:SetAlpha(1)
        hpLater:SetAlpha(1)
      end
      hpMain:ChangeTextureInfoNameAsync("new_ui_common_forlua/default/default_gauges.dds")
      local x1, y1, x2, y2 = setTextureUV_Func(hpMain, 206, 96, 255, 99)
      if false == ToClient_isConsole() and true == ToClient_isNationSiegeBoss(actorProxyWrapper:getCharacterKeyRaw()) then
        x1, y1, x2, y2 = setTextureUV_Func(hpMain, 206, 112, 255, 115)
      end
      hpMain:getBaseTexture():setUV(x1, y1, x2, y2)
      hpMain:setRenderTexture(hpMain:getBaseTexture())
    else
      local x1, y1, x2, y2
      hpMain:ChangeTextureInfoNameAsync("new_ui_common_forlua/default/default_gauges.dds")
      if 75 < hpRate then
        x1, y1, x2, y2 = setTextureUV_Func(hpMain, 206, 96, 255, 99)
      elseif 50 < hpRate then
        x1, y1, x2, y2 = setTextureUV_Func(hpMain, 206, 100, 255, 103)
      elseif 25 < hpRate then
        x1, y1, x2, y2 = setTextureUV_Func(hpMain, 206, 104, 255, 107)
      elseif 10 < hpRate then
        x1, y1, x2, y2 = setTextureUV_Func(hpMain, 206, 108, 255, 111)
      elseif 5 < hpRate then
        x1, y1, x2, y2 = setTextureUV_Func(hpMain, 206, 112, 255, 115)
      else
        x1, y1, x2, y2 = setTextureUV_Func(hpMain, 206, 112, 255, 115)
      end
      hpMain:getBaseTexture():setUV(x1, y1, x2, y2)
      hpMain:setRenderTexture(hpMain:getBaseTexture())
      hpMain:SetProgressRate(100)
      hpLater:SetProgressRate(100)
      hpMain:SetCurrentProgressRate(100)
      hpLater:SetCurrentProgressRate(100)
    end
  end
end
local function CharacterNameTag_HpBarUpdateCheck()
  for _, hpBarData in pairs(_characterHpBarContainer) do
    if nil ~= hpBarData then
      if hpBarData.currentHpIdx ~= hpBarData.targetHpIdx then
        hpBarData.stackHpBar:SetAniSpeed(1 / (math.abs(hpBarData.currentHpIdx - hpBarData.targetHpIdx) + 1))
        if hpBarData.currentHpIdx < hpBarData.targetHpIdx then
          hpBarData.stackHpBar:SetProgressRate(100)
        elseif hpBarData.targetHpIdx < hpBarData.currentHpIdx then
          hpBarData.stackHpBar:SetProgressRate(0)
        end
      end
      if hpBarData.currentHpIdx == hpBarData.targetHpIdx then
        hpBarData.stackHpBar:SetProgressRate(hpBarData.currentHpRate)
      elseif 100 <= hpBarData.stackHpBar:GetCurrentProgressRate() then
        hpBarData.currentHpIdx = hpBarData.currentHpIdx + 1
        if hpBarData.currentHpIdx >= _maxHpBarColorCount * 2 then
          hpBarData.stackHpBarBackColor:SetColor(_stackHpBarColor[_maxHpBarColorCount - 1])
          hpBarData.stackHpBar:SetColor(_stackHpBarColor[_maxHpBarColorCount - 1])
        else
          local colorValue = hpBarData.currentHpIdx % _maxHpBarColorCount
          local backColorValue = colorValue - 1
          if hpBarData.currentHpIdx <= 0 then
            backColorValue = -1
          elseif backColorValue < 0 then
            backColorValue = _maxHpBarColorCount - 1
          end
          hpBarData.stackHpBarBackColor:SetColor(_stackHpBarColor[backColorValue])
          hpBarData.stackHpBar:SetColor(_stackHpBarColor[colorValue])
        end
        hpBarData.stackHpBar:SetProgressRate(0)
      elseif 0 >= hpBarData.stackHpBar:GetCurrentProgressRate() then
        hpBarData.currentHpIdx = hpBarData.currentHpIdx - 1
        hpBarData.stackHpBar:SetProgressRate(100)
        if hpBarData.currentHpIdx >= _maxHpBarColorCount * 2 then
          hpBarData.stackHpBarBackColor:SetColor(_stackHpBarColor[_maxHpBarColorCount - 1])
          hpBarData.stackHpBar:SetColor(_stackHpBarColor[_maxHpBarColorCount - 1])
        else
          local colorValue = hpBarData.currentHpIdx % _maxHpBarColorCount
          local backColorValue = colorValue - 1
          if hpBarData.currentHpIdx <= 0 then
            backColorValue = -1
          elseif backColorValue < 0 then
            backColorValue = _maxHpBarColorCount - 1
          end
          hpBarData.stackHpBarBackColor:SetColor(_stackHpBarColor[backColorValue])
          hpBarData.stackHpBar:SetColor(_stackHpBarColor[colorValue])
        end
      end
    end
  end
end
function PaGlobal_WaitUntilHpBarChange_UpdateFunc()
  if true == GameOption_GetShowStackHp() and true == _ContentsGroup_StackingHpBar then
    CharacterNameTag_HpBarUpdateCheck()
  end
end
function EventActorHpChanged(actorKeyRaw, hp, maxHp)
  local actorProxyWrapper = getActor(actorKeyRaw)
  if nil == actorProxyWrapper then
    return
  end
  local panel = actorProxyWrapper:get():getUIPanel()
  if nil == panel then
    return
  end
  settingHpBar(actorKeyRaw, panel, actorProxyWrapper)
end
function EventActorAddDamage(actorKeyRaw, variedPoint, attackResult_IntValue, additionalDamageType, position)
  if 0 == attackResult_IntValue or 1 == attackResult_IntValue or 2 == attackResult_IntValue or 3 == attackResult_IntValue or 4 == attackResult_IntValue or 5 == attackResult_IntValue then
    ActorInsertShowTime(actorKeyRaw, hideTimeType.overHeadUI, 0)
  end
end
function EventShowProgressBar(actorKeyRaw, aHideTimeType)
  local actorProxyWrapper = getActor(actorKeyRaw)
  if nil == actorProxyWrapper then
    return
  end
  if hideTimeType.overHeadUI == aHideTimeType then
    local panel = actorProxyWrapper:get():getUIPanel()
    if nil == panel then
      return
    end
    settingHpBar(actorKeyRaw, panel, actorProxyWrapper)
  end
end
function EventHideProgressBar(actorKeyRaw, aHideTimeType)
  local actorProxyWrapper = getActor(actorKeyRaw)
  if nil == actorProxyWrapper then
    return
  end
  if hideTimeType.overHeadUI == aHideTimeType then
    local panel = actorProxyWrapper:get():getUIPanel()
    if nil == panel then
      return
    end
    settingHpBar(actorKeyRaw, panel, actorProxyWrapper)
  end
end
registerEvent("hpChanged", "EventActorHpChanged")
registerEvent("addDamage", "EventActorAddDamage")
registerEvent("EventShowProgressBar", "EventShowProgressBar")
registerEvent("EventHideProgressBar", "EventHideProgressBar")
