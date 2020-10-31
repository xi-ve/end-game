function FromClient_CharInfoBasic_All_TendecyUpdate()
  if false == PaGlobalFunc_ChracterInfo_All_GetBgShow(PaGlobal_CharInfo_All._TABINDEX._basic) then
    return
  end
  PaGlobal_CharInfoBasic_All._ui.txt_Tendency:SetText(PaGlobal_CharInfoBasic_All._selfPlayer:get():getTendency())
  PaGlobal_CharInfoBasic_All:SetEnableAreaByTextSize(PaGlobal_CharInfoBasic_All._ui.txt_Tendency)
end
function FromClient_CharInfoBasic_All_ContributeUpdate()
  if false == PaGlobalFunc_ChracterInfo_All_GetBgShow(PaGlobal_CharInfo_All._TABINDEX._basic) then
    return
  end
  PaGlobal_CharInfoBasic_All._ui.txt_Contribute:SetText(PaGlobal_CharInfo_All:getContributeString())
  PaGlobal_CharInfoBasic_All:SetEnableAreaByTextSize(PaGlobal_CharInfoBasic_All._ui.txt_Contribute)
end
function FromClient_CharInfoBasic_All_MentalUpdate()
  if false == PaGlobalFunc_ChracterInfo_All_GetBgShow(PaGlobal_CharInfo_All._TABINDEX._basic) then
    return
  end
  PaGlobal_CharInfoBasic_All._ui.txt_Wp:SetText(tostring(PaGlobal_CharInfoBasic_All._selfPlayer:getWp()) .. " / " .. tostring(PaGlobal_CharInfoBasic_All._selfPlayer:getMaxWp()))
  PaGlobal_CharInfoBasic_All:SetEnableAreaByTextSize(PaGlobal_CharInfoBasic_All._ui.txt_Wp)
end
function FromClient_CharInfoBasic_All_LevelUpdate()
  if false == PaGlobalFunc_ChracterInfo_All_GetBgShow(PaGlobal_CharInfo_All._TABINDEX._basic) then
    return
  end
  local lv = PaGlobal_CharInfoBasic_All._selfPlayer:get():getLevel()
  PaGlobal_CharInfoBasic_All._ui.txt_PlayerLv:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_WORKERAUCTION_WORKERLEVEL", "level", tostring(lv)))
end
function FromClient_CharInfoBasic_All_HpUpdate()
  if false == PaGlobalFunc_ChracterInfo_All_GetBgShow(PaGlobal_CharInfo_All._TABINDEX._basic) then
    return
  end
  local hp = PaGlobal_CharInfoBasic_All._selfPlayer:get():getHp()
  local maxHp = PaGlobal_CharInfoBasic_All._selfPlayer:get():getMaxHp()
  local rate = hp / maxHp * 100
  local isShow = 0 < rate
  PaGlobal_CharInfoBasic_All._ui.txt_HpVal:SetText(tostring(hp) .. " / " .. tostring(maxHp))
end
function FromClient_CharInfoBasic_All_MpUpdate()
  if false == PaGlobalFunc_ChracterInfo_All_GetBgShow(PaGlobal_CharInfo_All._TABINDEX._basic) then
    return
  end
  local mp = PaGlobal_CharInfoBasic_All._selfPlayer:get():getMp()
  local maxMp = PaGlobal_CharInfoBasic_All._selfPlayer:get():getMaxMp()
  local rate = mp / maxMp * 100
  local isShow = 0 < rate
  PaGlobal_CharInfoBasic_All._ui.txt_Mp_Val:SetText(tostring(mp) .. " / " .. tostring(maxMp))
end
function FromClient_CharInfoBasic_All_WeightUpdate()
  if false == PaGlobalFunc_ChracterInfo_All_GetBgShow(PaGlobal_CharInfo_All._TABINDEX._basic) then
    return
  end
  local selfPlayerGet = PaGlobal_CharInfoBasic_All._selfPlayer:get()
  local s64_allWeight = selfPlayerGet:getCurrentWeight_s64()
  local s64_maxWeight = selfPlayerGet:getPossessableWeight_s64()
  local s64_maxWeight_div = s64_maxWeight / Defines.s64_const.s64_100
  local str_AllWeight = makeWeightString(s64_allWeight, 1)
  local str_MaxWeight = makeWeightString(s64_maxWeight, 0)
  local rate = Int64toInt32(s64_allWeight / s64_maxWeight_div)
  local isShow = 0 < rate
  PaGlobal_CharInfoBasic_All._ui.txt_LTVal:SetText(str_AllWeight .. " / " .. str_MaxWeight .. " " .. PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_WEIGHT"))
end
function FromClient_CharInfoBasic_All_AtkDefUpdate()
  if false == PaGlobalFunc_ChracterInfo_All_GetBgShow(PaGlobal_CharInfo_All._TABINDEX._basic) or false == PaGlobal_CharInfoBasic_All._ui.stc_BattleInfoBg:GetShow() then
    return
  end
  ToClient_updateAttackStat()
  local self = PaGlobal_CharInfoBasic_All
  self._ui.txt_Atk:SetText(tostring(ToClient_getOffence()))
  self._ui.txt_Def:SetText(tostring(ToClient_getDefence()))
  local BattileInfoTitleSpanY = 25
  local gap = 25
  local isSetAwakenWeapon = ToClient_getEquipmentItem(CppEnums.EquipSlotNo.awakenWeapon)
  local isShyWomen = __eClassType_ShyWaman == self._selfPlayer:getClassType()
  local flag = nil ~= isSetAwakenWeapon and self._isAwakenWeaponContentsOpen
  self._ui.txt_AwakenTitle:SetText(flag)
  if true == flag then
    self._ui.txt_AwakenAtk:SetText(tostring(ToClient_getAwakenOffence()))
  end
  if flag ~= self._checkAwaken then
    self._checkAwaken = flag
    self._ui.txt_AwakenTitle:SetShow(flag)
    self._ui.txt_AwakenAtk:SetShow(flag)
    local statUI = {
      [1] = self._ui.txt_AtkTitle,
      [2] = nil,
      [3] = self._ui.txt_DefTitle,
      [4] = self._ui.txt_StaminaTitle,
      [5] = self._ui.txt_StunRegistTitle,
      [6] = self._ui.txt_GrabRegistTitle,
      [7] = self._ui.txt_DownRegistTitle,
      [8] = self._ui.txt_AirRegistTitle
    }
    if true == flag then
      statUI[2] = self._ui.txt_AwakenTitle
      if true == isShyWomen then
        self._ui.txt_AwakenTitle:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_COMMON_SHYSTAT_1"))
      else
        self._ui.txt_AwakenTitle:SetText(PAGetString(Defines.StringSheet_RESOURCE, "CHARACTERINFO_TEXT_AWAKENATTACK"))
      end
    end
    local uiCount = 1
    for i = 1, 8 do
      if nil ~= statUI[i] then
        statUI[i]:SetSpanSize(statUI[i]:GetSpanSize().x, 0)
        statUI[i]:SetSpanSize(self._statOriginSpanX, BattileInfoTitleSpanY + statUI[i]:GetSpanSize().y + (gap * uiCount - 0))
        uiCount = uiCount + 1
      end
    end
    self._ui.txt_Atk:SetSpanSize(self._statOriginSpanX, self._ui.txt_AtkTitle:GetSpanSize().y)
    self._ui.txt_AwakenAtk:SetSpanSize(self._statOriginSpanX, self._ui.txt_AwakenTitle:GetSpanSize().y)
    self._ui.txt_Def:SetSpanSize(self._statOriginSpanX, self._ui.txt_DefTitle:GetSpanSize().y)
    self._ui.txt_Stamina:SetSpanSize(self._statOriginSpanX, self._ui.txt_StaminaTitle:GetSpanSize().y)
    self._ui.txt_StunRegist:SetSpanSize(self._statOriginSpanX, self._ui.txt_StunRegistTitle:GetSpanSize().y)
    self._ui.txt_GrabRegist:SetSpanSize(self._statOriginSpanX, self._ui.txt_GrabRegistTitle:GetSpanSize().y)
    self._ui.txt_DownRegist:SetSpanSize(self._statOriginSpanX, self._ui.txt_DownRegistTitle:GetSpanSize().y)
    self._ui.txt_AirRegist:SetSpanSize(self._statOriginSpanX, self._ui.txt_AirRegistTitle:GetSpanSize().y)
    if 1 >= Panel_CharacterInfo_All:GetScale().x then
      HandleEventLUp_ChracterInfo_All_ScaleResizeLDown()
      HandleEventLUp_ChracterInfo_All_ScaleResizeLPress()
      HandleEventLUp_ChracterInfo_All_ScaleResizeLUp()
    end
  end
end
function FromClient_CharInfoBasic_All_StaminaUpdate()
  if false == PaGlobalFunc_ChracterInfo_All_GetBgShow(PaGlobal_CharInfo_All._TABINDEX._basic) and false == PaGlobal_CharInfoBasic_All._ui.stc_BattleInfoBg:GetShow() then
    return
  end
  PaGlobal_CharInfoBasic_All._ui.txt_Stamina:SetText(tostring(PaGlobal_CharInfoBasic_All._selfPlayer:get():getStamina():getMaxSp()))
end
function FromClient_CharInfoBasic_All_SPUpdate()
  LUA_SCOPED_PROFILE("FromClient_CharInfoBasic_All_SPUpdate")
  if false == PaGlobalFunc_ChracterInfo_All_GetBgShow(PaGlobal_CharInfo_All._TABINDEX._basic) then
    return
  end
  local spInfo = ToClient_getSkillPointInfo(0)
  if nil ~= spInfo then
    PaGlobal_CharInfoBasic_All._ui.txt_SkillPoint:SetText(tostring(spInfo._remainPoint .. " / " .. spInfo._acquirePoint))
    PaGlobal_CharInfoBasic_All:SetEnableAreaByTextSize(PaGlobal_CharInfoBasic_All._ui.txt_SkillPoint)
  end
end
function FromClient_CharInfoBasic_All_FamliyFameUpdate()
  LUA_SCOPED_PROFILE("FromClient_CharInfoBasic_All_FamliyFameUpdate")
  if false == PaGlobalFunc_ChracterInfo_All_GetBgShow(PaGlobal_CharInfo_All._TABINDEX._basic) and false == PaGlobal_CharInfoBasic_All._ui.stc_BattleInfoBg:GetShow() then
    return
  end
  local battleFP = PaGlobal_CharInfoBasic_All._selfPlayer:get():getBattleFamilyPoint()
  local lifeFP = PaGlobal_CharInfoBasic_All._selfPlayer:get():getLifeFamilyPoint()
  local etcFP = PaGlobal_CharInfoBasic_All._selfPlayer:get():getEtcFamilyPoint()
  local sumFP = battleFP + lifeFP + etcFP
  PaGlobal_CharInfoBasic_All._ui.txt_BattlePoint:SetText(battleFP)
  PaGlobal_CharInfoBasic_All._ui.txt_LifePoint:SetText(lifeFP)
  PaGlobal_CharInfoBasic_All._ui.txt_SpecialPoint:SetText(etcFP)
  PaGlobal_CharInfoBasic_All._ui.txt_FamilyPoint:SetText(sumFP)
end
function FromClient_CharInfoBasic_All_ResistUpdate()
  if false == PaGlobalFunc_ChracterInfo_All_GetBgShow(PaGlobal_CharInfo_All._TABINDEX._basic) then
    return
  end
  PaGlobal_CharInfoBasic_All._ui.txt_StunRegist:SetText(math.floor(PaGlobal_CharInfoBasic_All._selfPlayer:getStunResistance() / 10000) .. "%")
  PaGlobal_CharInfoBasic_All._ui.txt_GrabRegist:SetText(math.floor(PaGlobal_CharInfoBasic_All._selfPlayer:getCatchResistance() / 10000) .. "%")
  PaGlobal_CharInfoBasic_All._ui.txt_DownRegist:SetText(math.floor(PaGlobal_CharInfoBasic_All._selfPlayer:getKnockdownResistance() / 10000) .. "%")
  PaGlobal_CharInfoBasic_All._ui.txt_AirRegist:SetText(math.floor(PaGlobal_CharInfoBasic_All._selfPlayer:getKnockbackResistance() / 10000) .. "%")
end
function FromClient_CharInfoBasic_All_LifeUpdate()
  if false == PaGlobalFunc_ChracterInfo_All_GetBgShow(PaGlobal_CharInfo_All._TABINDEX._basic) and false == PaGlobal_CharInfoBasic_All._ui.stc_LifeBg:GetShow() then
    return
  end
  if nil == PaGlobal_CharInfoBasic_All._ui.stc_LifeTable then
    UI.ASSERT_NAME(nil ~= PaGlobal_CharInfoBasic_All._ui.stc_LifeTable, " Panel_CharacterInfoBasic_All_3.lua / PaGlobal_CharInfoBasic_All._ui.stc_LifeTable is nil", "\234\185\128\234\183\188\236\154\176")
    return
  end
  for idx = 1, PaGlobal_CharInfoBasic_All._LIFEINFOCOUNT do
    local lifeType = idx - 1
    if 10 == lifeType then
      lifeType = lifeType + 1
    end
    local currentExp64 = PaGlobal_CharInfoBasic_All._selfPlayer:get():getCurrLifeExperiencePoint(lifeType)
    local needExp64 = PaGlobal_CharInfoBasic_All._selfPlayer:get():getDemandLifeExperiencePoint(lifeType)
    local currentExpRate64 = currentExp64 * toInt64(0, 10000) / needExp64
    local currentExpRate = Int64toInt32(currentExpRate64)
    currentExpRate = currentExpRate / 100
    local currentExpRateString = string.format("%.2f", currentExpRate)
    local lvString = PaGlobalFunc_Util_CraftLevelColorReplace(PaGlobal_CharInfoBasic_All._selfPlayer:get():getLifeExperienceLevel(lifeType))
    local isShow = 0 < currentExpRate
    PaGlobal_CharInfoBasic_All._ui.stc_LifeTable[idx].lv:SetText(lvString)
    PaGlobal_CharInfoBasic_All._ui.stc_LifeTable[idx].prog2:SetShow(isShow)
    PaGlobal_CharInfoBasic_All._ui.stc_LifeTable[idx].prog2:SetProgressRate(currentExpRate)
    PaGlobal_CharInfoBasic_All._ui.stc_LifeTable[idx].rate:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_TRADEMARKET_ALL_SELLRATES", "Percent", currentExpRateString))
    PaGlobal_CharInfoBasic_All._ui.stc_LifeTable[idx].expVal = currentExpRate
  end
end
function FromClient_CharInfoBasic_All_PotentialUpdate()
  if false == PaGlobalFunc_ChracterInfo_All_GetBgShow(PaGlobal_CharInfo_All._TABINDEX._basic) and false == PaGlobal_CharInfoBasic_All._ui.stc_BattleInfoBg:GetShow() then
    return
  end
  if nil == PaGlobal_CharInfoBasic_All._potentialData then
    UI.ASSERT_NAME(nil ~= PaGlobal_CharInfoBasic_All._ui.stc_LifeTable, " Panel_CharacterInfoBasic_All_3.lua / PaGlobal_CharInfoBasic_All._potentialData is nil", "\234\185\128\234\183\188\236\154\176")
    return
  end
  local self = PaGlobal_CharInfoBasic_All
  local levelText = PAGetString(Defines.StringSheet_GAME, "LUA_CHARACTERINFO_TEXT_POTENLEVEL")
  local classType = self._selfPlayer:getClassType()
  local localFlag = isGameTypeKorea() or isGameTypeTaiwan()
  local function potentialDataSet(potenType)
    local castData = {move = 0, attack = 1}
    local lvData = 1
    if self._ENUM_POTEN.ATKSPD == potenType then
      lvData = self._selfPlayer:characterStatPointSpeed(castData.attack + CppEnums.ClassType_BattleSpeed[classType])
      limitSpeed = self._selfPlayer:characterStatPointLimitedSpeed(castData.attack + CppEnums.ClassType_BattleSpeed[classType])
      if lvData > limitSpeed then
        lvData = limitSpeed
      end
      return lvData - 5
    elseif self._ENUM_POTEN.MOVESPD == potenType then
      lvData = self._selfPlayer:characterStatPointSpeed(castData.move)
      limitSpeed = self._selfPlayer:characterStatPointLimitedSpeed(castData.move)
      if lvData > limitSpeed then
        lvData = limitSpeed
      end
      return lvData - 5
    elseif self._ENUM_POTEN.CRITICAL == potenType then
      lvData = self._selfPlayer:characterStatPointCritical()
      limitSpeed = self._selfPlayer:characterStatPointLimitedCritical()
      if lvData > limitSpeed then
        lvData = limitSpeed
      end
      return lvData
    elseif self._ENUM_POTEN.FISH == potenType then
      lvData = self._selfPlayer:getCharacterStatPointFishing()
      limitSpeed = self._selfPlayer:getCharacterStatPointLimitedFishing()
      if lvData > limitSpeed then
        lvData = limitSpeed
      end
      return lvData
    elseif self._ENUM_POTEN.COLLECT == potenType then
      lvData = self._selfPlayer:getCharacterStatPointCollection()
      limitSpeed = self._selfPlayer:getCharacterStatPointLimitedCollection()
      if lvData > limitSpeed then
        lvData = limitSpeed
      end
      return lvData
    elseif self._ENUM_POTEN.LUCK == potenType then
      lvData = self._selfPlayer:getCharacterStatPointDropItem()
      limitSpeed = self._selfPlayer:getCharacterStatPointLimitedDropItem()
      if lvData > limitSpeed then
        lvData = limitSpeed
      end
      return lvData
    end
  end
  for potenIdx = 0, self._MAX_POTENCIALSLOT + 1 do
    if nil ~= self._potentialData[potenIdx] or nil ~= self._potentialData[potenIdx].slot then
      for idx = 0, self._MAX_POTENCIALSLOT do
        self._potentialData[potenIdx].slot[idx]:SetShow(false)
      end
      local lvCount = potentialDataSet(potenIdx)
      self._potentialData[potenIdx].val:SetShow(localFlag)
      if true == localFlag then
        self._potentialData[potenIdx].val:SetText(lvCount .. levelText)
      end
      for idx = 0, lvCount - 1 do
        self._potentialData[potenIdx].slot[idx]:SetShow(true)
      end
    end
  end
end
function FromClient_CharInfoBasic_All_FitnesspUpdate(addSp, addWeight, addHp, addMp)
  local self = PaGlobal_CharInfoBasic_All
  if false == PaGlobalFunc_ChracterInfo_All_GetBgShow(PaGlobal_CharInfo_All._TABINDEX._basic) and false == self._ui.stc_BattleInfoBg:GetShow() then
    return
  end
  if 0 < addSp then
    FGlobal_FitnessLevelUp(addSp, addWeight, addHp, addMp, self._ENUM_FITNESS.BREATH)
  elseif 0 < addWeight then
    FGlobal_FitnessLevelUp(addSp, addWeight, addHp, addMp, self._ENUM_FITNESS.POWER)
  elseif 0 < addHp or 0 < addMp then
    FGlobal_FitnessLevelUp(addSp, addWeight, addHp, addMp, self._ENUM_FITNESS.HEALTH)
  end
  local _mentalType = self._selfPlayer:getCombatResourceType()
  local _mpName = {
    [CppEnums.CombatResourceType.CombatType_MP] = PAGetString(Defines.StringSheet_GAME, "LUA_CHARACTERINFO_TEXT_MP"),
    [CppEnums.CombatResourceType.CombatType_FP] = PAGetString(Defines.StringSheet_GAME, "LUA_CHARACTERINFO_TEXT_FP_NEW"),
    [CppEnums.CombatResourceType.CombatType_EP] = PAGetString(Defines.StringSheet_GAME, "LUA_CHARACTERINFO_TEXT_EP"),
    [CppEnums.CombatResourceType.CombatType_BP] = PAGetString(Defines.StringSheet_GAME, "LUA_SELFCHARACTERINFO_BP")
  }
  local mpTypeTitle = _mpName[_mentalType]
  local titleString = {
    [0] = PAGetString(Defines.StringSheet_GAME, "LUA_CHARACTERINFO_FITNESS_STAMINA_TITLE"),
    [1] = PAGetString(Defines.StringSheet_GAME, "LUA_CHARACTERINFO_FITNESS_STRENGTH_TITLE"),
    [2] = PAGetString(Defines.StringSheet_GAME, "LUA_CHARACTERINFO_FITNESS_HEALTH_TITLE")
  }
  if false == self._asianFlag then
    titleString[0] = PAGetString(Defines.StringSheet_GAME, "LUA_CHARACTERINFO_FITNESS_STAMINA_TITLE_ONE")
    titleString[1] = PAGetString(Defines.StringSheet_GAME, "LUA_CHARACTERINFO_FITNESS_STRENGTH_TITLE_ONE")
    titleString[2] = PAGetString(Defines.StringSheet_GAME, "LUA_CHARACTERINFO_FITNESS_HEALTH_TITLE_ONE")
  end
  for index = 0, 2 do
    local current = Int64toInt32(self._selfPlayer:get():getCurrFitnessExperiencePoint(index))
    local max = Int64toInt32(self._selfPlayer:get():getDemandFItnessExperiencePoint(index))
    local rate = current / max * 100
    local level = self._selfPlayer:get():getFitnessLevel(index)
    local _hpIncrease = tostring(ToClient_GetFitnessLevelStatus(index, 0))
    local _mpIncrease = tostring(ToClient_GetFitnessLevelStatus(index, 1))
    local _heathInfo
    if nil == rate then
      rate = 0
    end
    self._fitnessData[index]._prog2:SetProgressRate(rate)
    self._fitnessData[index]._level:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_CHARACTERINFO_TEXT_CRAFTLEVEL") .. tostring(level))
    if true == PaGlobal_CharInfoBasic_All._asianFlag then
      if index == 0 then
        titleString[index] = titleString[index] .. tostring(ToClient_GetFitnessLevelStatus(index, 0))
      elseif index == 1 then
        titleString[index] = titleString[index] .. tostring(ToClient_GetFitnessLevelStatus(index, 0) / 10000)
      else
        titleString[index] = PAGetStringParam3(Defines.StringSheet_GAME, "LUA_CHARACTERINFO_FITNESS_HEALTHINFO_NEW", "hpIncrease", _hpIncrease, "mpTypeName", mpTypeTitle, "mpIncrease", _mpIncrease)
      end
    end
    self._fitnessData[index]._titleUI:SetText(titleString[index])
    self._fitnessData[index]._titleUI:SetEnableArea(0, 0, self._fitnessData[index]._titleUI:GetTextSizeX(), self._fitnessData[index]._titleUI:GetTextSizeY())
  end
end
function FromClient_CharInfoBasic_All_EnchantStackUpdate()
  if false == PaGlobalFunc_ChracterInfo_All_GetBgShow(PaGlobal_CharInfo_All._TABINDEX._basic) then
    return
  end
  local defaultCount = PaGlobal_CharInfoBasic_All._selfPlayer:get():getEnchantFailCount()
  local valksCount = PaGlobal_CharInfoBasic_All._selfPlayer:get():getEnchantValuePackCount()
  local familyCount = getEnchantInformation():ToClient_getBonusStackCount()
  if ToClient_IsReceivedEnchantFailCount() then
    PaGlobal_CharInfoBasic_All._ui.txt_EnchantCount:SetText(defaultCount + valksCount + familyCount)
    PaGlobal_CharInfoBasic_All._ui.txt_EnchantStackIcon_Value:SetText(defaultCount + valksCount + familyCount)
  else
    PaGlobal_CharInfoBasic_All._ui.txt_EnchantCount:SetText("-")
  end
  PaGlobal_CharInfoBasic_All._ui.txt_EnchantCount:SetEnableArea(0, 0, PaGlobal_CharInfoBasic_All._ui.txt_EnchantCount:GetTextSizeX(), PaGlobal_CharInfoBasic_All._ui.txt_EnchantCount:GetTextSizeY())
end
function FromClient_CharInfoBasic_All_IncreaseMusicExp()
  if false == PaGlobalFunc_ChracterInfo_All_GetBgShow(PaGlobal_CharInfo_All._TABINDEX._basic) then
    return
  end
  if true == _ContentsGroup_InstrumentPerformance then
    PaGlobal_CharInfoBasic_All._ui.txt_MusicGradeValue:SetText(ToClient_GetMusicRank())
    PaGlobal_CharInfoBasic_All._ui.txt_MusicGradeValue:SetEnableArea(0, 0, PaGlobal_CharInfoBasic_All._ui.txt_MusicGradeValue:GetTextSizeX(), PaGlobal_CharInfoBasic_All._ui.txt_MusicGradeValue:GetTextSizeY())
  end
end
