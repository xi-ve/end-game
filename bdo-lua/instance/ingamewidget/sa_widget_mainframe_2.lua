function PaGlobal_SA_MainFrame:characterInfoUpdate()
  local playerWrapper = getSelfPlayer()
  if nil == playerWrapper then
    return
  end
  local classType = playerWrapper:getClassType()
  local player = playerWrapper:get()
  local regionKeyRaw = playerWrapper:getRegionKeyRaw()
  local regionWrapper = getRegionInfoWrapper(regionKeyRaw)
  local isArenaZone = regionWrapper:get():isArenaZone()
  local hp = math.floor(player:getHp())
  local maxHp = math.floor(player:getMaxHp())
  local percentHp = math.floor(hp / maxHp * 100)
  if hp < self._value_mainStatus._prevHp then
    PaGlobal_SA_MainFrame._value_mainStatus._isDamagedEffect = true
    PaGlobalFunc_SA_MainFrame_SymbolDamagedEffect()
  elseif true == PaGlobal_SA_MainFrame_IsSkillTypeItem() and hp > self._value_mainStatus._prevHp then
    PaGlobal_SA_MainFrame._value_mainStatus._isDamagedEffect = false
    PaGlobalFunc_SA_MainFrame_SymbolHealEffect()
    PaGlobal_SA_MainFrame_SetUseSkillTypeItem(false)
  end
  if percentHp < 20 and hp < self._value_mainStatus._prevHp and self._value_mainStatus._prevHpAlertTime + 20 <= FGlobal_getLuaLoadTime() and not isArenaZone then
    self._value_mainStatus._prevHpAlertTime = FGlobal_getLuaLoadTime()
  end
  if 0 ~= maxHp and (hp ~= self._value_mainStatus._prevHp or maxHp ~= self._value_mainStatus._prevMaxHP) then
    self._ui_mainStatus._txt_hp:SetText(tostring(hp) .. " / " .. tostring(maxHp))
    self._ui_mainStatus._txt_hp:SetSize(self._ui_mainStatus._txt_hp:GetTextSizeX(), self._ui_mainStatus._txt_hp:GetSizeY())
    self._ui_mainStatus._txt_hp:ComputePos()
    self._ui_mainStatus.progress2_hp:SetProgressRate(hp / maxHp * 100)
    if hp - self._value_mainStatus._prevHp > 5 then
      self._ui_mainStatus.progress2_hp:EraseAllEffect()
      self._ui_mainStatus.progress2_hp:AddEffect("fUI_Gauge_Red", false, 0, 0)
    end
    self._value_mainStatus._prevHp = hp
    self._value_mainStatus._prevMaxHP = maxHp
    self:checkHpAlert(hp, maxHp, false)
  end
end
function PaGlobal_SA_MainFrame:checkHpAlert(hp, maxHp, isLevelUp)
  local isUpdate = Defines.UIMode.eUIMode_Default == GetUIMode()
  if false == global_danger_MessageShow and false == isLevelUp then
    return
  end
  local totalHp = hp / maxHp * 100
  if totalHp <= 99.99 and false == self._value_mainStatus._strongMonsterAlert then
    self._ui_mainStatus._hpGaugeHead:SetShow(true)
  end
  if totalHp == 100 and false == self._value_mainStatus._strongMonsterAlert then
    self._ui_mainStatus._hpGaugeHead:SetShow(false)
  end
  if 40 <= totalHp and false == self._value_mainStatus._strongMonsterAlert then
    self._ui_mainStatus._txt_hp:SetFontColor(Defines.Color.C_FFF0EF9D)
  end
  if totalHp <= 39 and 20 <= totalHp then
    self._ui_mainStatus._txt_hp:SetFontColor(Defines.Color.C_FFF26A6A)
  end
end
function PaGlobal_SA_MainFrame:SetCharacterIcon()
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  local classType = selfPlayer:getClassType()
  if nil == PaGlobal_SA_MainFrame._value_mainStatus._characterIconUV[classType] then
    return
  end
  local x1, y1, x2, y2 = setTextureUV_Func(PaGlobal_SA_MainFrame._ui_mainStatus._stc_characterIcon, PaGlobal_SA_MainFrame._value_mainStatus._characterIconUV[classType].x1, PaGlobal_SA_MainFrame._value_mainStatus._characterIconUV[classType].y1, PaGlobal_SA_MainFrame._value_mainStatus._characterIconUV[classType].x2, PaGlobal_SA_MainFrame._value_mainStatus._characterIconUV[classType].y2)
  PaGlobal_SA_MainFrame._ui_mainStatus._stc_characterIcon:getBaseTexture():setUV(x1, y1, x2, y2)
  PaGlobal_SA_MainFrame._ui_mainStatus._stc_characterIcon:setRenderTexture(PaGlobal_SA_MainFrame._ui_mainStatus._stc_characterIcon:getBaseTexture())
  PaGlobal_SA_MainFrame._ui_mainStatus._stc_characterIcon:ComputePos()
end
function FromClient_DamageByOtherPlayer()
  if PaGlobal_SA_MainFrame._value_mainStatus._now_HpBarBurn == false then
    PaGlobal_SA_MainFrame._value_mainStatus._hpBarBurnTimer = PaGlobal_SA_MainFrame._ui_mainStatus.progress2_hp:EraseAllEffect()
    PaGlobal_SA_MainFrame._value_mainStatus._hpBarBurnTimer = PaGlobal_SA_MainFrame._ui_mainStatus.progress2_hp:AddEffect("fUI_Gauge_PvP", false, 0, 0)
    PaGlobal_SA_MainFrame._value_mainStatus._hpBarBurnTimer = 0
  end
end
function PaGlobal_SA_MainFrame_UpdateEffectTime(delta)
  if true == PaGlobal_SA_MainFrame._ui_mainStatus._stc_characterIcon:GetShow() then
    return
  end
  PaGlobal_SA_MainFrame._value_mainStatus._curEffectTime = PaGlobal_SA_MainFrame._value_mainStatus._curEffectTime + delta
  if PaGlobal_SA_MainFrame._value_mainStatus._curEffectTime >= PaGlobal_SA_MainFrame._value_mainStatus._effectTime then
    PaGlobal_SA_MainFrame._value_mainStatus._curEffectTime = 0
    PaGlobal_SA_MainFrame._ui_mainStatus._stc_characterIcon:SetShow(true)
    return
  end
end
function PaGlobalFunc_SA_MainFrame_SymbolDamagedEffect()
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  local classType = selfPlayer:getClassType()
  if nil == classType then
    return
  end
  if true == PaGlobal_SA_MainFrame._ui_mainStatus._stc_characterIcon:GetShow() then
    PaGlobal_SA_MainFrame._ui_mainStatus._stc_characterIcon:SetShow(false)
    PaGlobal_SA_MainFrame._ui_mainStatus._stc_characterEffectSlot:EraseAllEffect()
    PaGlobal_SA_MainFrame._value_mainStatus._effectTime = PaGlobal_SA_MainFrame._value_mainStatus._symbolDamagedEffectName[classType].lifeTime
    local effectName = PaGlobal_SA_MainFrame._value_mainStatus._symbolDamagedEffectName[classType].effectName
    PaGlobal_SA_MainFrame._ui_mainStatus._stc_characterEffectSlot:AddEffect(effectName, false, 0, 0)
  end
end
function PaGlobalFunc_SA_MainFrame_SymbolHealEffect()
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  local classType = selfPlayer:getClassType()
  if nil == classType then
    return
  end
  PaGlobal_SA_MainFrame._ui_mainStatus._stc_characterIcon:SetShow(true)
  PaGlobal_SA_MainFrame._ui_mainStatus._stc_characterEffectSlot:EraseAllEffect()
  PaGlobal_SA_MainFrame._value_mainStatus._effectTime = PaGlobal_SA_MainFrame._value_mainStatus._symbolHealEffectName[classType].lifeTime
  local effectName = PaGlobal_SA_MainFrame._value_mainStatus._symbolHealEffectName[classType].effectName
  PaGlobal_SA_MainFrame._ui_mainStatus._stc_characterEffectSlot:AddEffect(effectName, false, 0, 0)
end
function PaGlobalFunc_SA_MainFrame_User_Bar_Show()
  PaGlobal_SA_MainFrame:prepareOpen()
end
function PaGlobalFunc_SA_MainFrame_RenderModeChange_checkHpAlertPostEvent(prevRenderModeList, nextRenderModeList)
  local currentRenderMode = {
    Defines.RenderMode.eRenderMode_Default,
    Defines.RenderMode.eRenderMode_WorldMap
  }
  if CheckRenderModebyGameMode(nextRenderModeList) or CheckRenderMode(prevRenderModeList, currentRenderMode) then
    PaGlobal_SA_MainFrame:checkHpAlert(1, 1, false)
  end
end
function PaGlobalFunc_SA_MainFrame_DamageByOtherPlayer_chkOnEffectTime(DeltaTime)
  PaGlobal_SA_MainFrame._value_mainStatus._hpBarBurnTimer = PaGlobal_SA_MainFrame._value_mainStatus._hpBarBurnTimer + DeltaTime
  if PaGlobal_SA_MainFrame._value_mainStatus._hpBarBurnTimer > 10 and PaGlobal_SA_MainFrame._value_mainStatus._now_HpBarBurn ~= false then
    selfPlayerStatusBar._staticHP_BG:EraseEffect(PaGlobal_SA_MainFrame._value_mainStatus._now_HpBarBurn)
    PaGlobal_SA_MainFrame._value_mainStatus._now_HpBarBurn = false
    PaGlobal_SA_MainFrame._value_mainStatus._hpBarBurnTimer = 0
  end
  if PaGlobal_SA_MainFrame._value_mainStatus._hpBarBurnTimer > 12 then
    PaGlobal_SA_MainFrame._value_mainStatus._hpBarBurnTimer = 0
  end
end
function PaGlobalFunc_SA_MainFrame_CharacterInfoWindowUpdate()
  PaGlobal_SA_MainFrame:characterInfoUpdate()
end
function PaGlobalFunc_SA_MainFrame_RefreshHpAlertForLevelup()
  local playerWrapper = getSelfPlayer()
  if nil == playerWrapper then
    return
  end
  local player = playerWrapper:get()
  local hp = math.floor(player:getHp())
  local maxHp = math.floor(player:getMaxHp())
  PaGlobal_SA_MainFrame:checkHpAlert(hp, maxHp, true)
end
function PaGlobalFunc_SA_MainFrame_UpdateStamina()
  local selfPlayerWrapper = getSelfPlayer()
  if nil == selfPlayerWrapper then
    return
  end
  local stamina = selfPlayerWrapper:get():getStamina()
  if nil == stamina then
    return
  end
  local sp = stamina:getSp()
  local maxSp = stamina:getMaxSp()
  local useType = stamina:getUseType()
  local spRate = sp / maxSp
  local fullGauge = spRate * 100
  PaGlobal_SA_MainFrame._ui_mainStatus.progress2_stamina:SetProgressRate(fullGauge)
  PaGlobal_SA_MainFrame._ui_mainStatus._txt_stamina:SetText(tostring(math.floor(spRate * 100)) .. " / " .. tostring(math.floor(maxSp / 10)))
end
function FromClient_SA_MainFrame_MainStatusResizePanel()
  PaGlobal_SA_MainFrame._ui_mainStatus.progress2_hp:ComputePos()
  PaGlobal_SA_MainFrame._ui_mainStatus.progress2_stamina:ComputePos()
  PaGlobalFunc_SA_MainFrame_User_Bar_Show()
end
function PaGlobal_SA_MainFrame:mainStatusValidate()
  if nil == Panel_SA_MainFrame then
    return
  end
  PaGlobal_SA_MainFrame._ui_mainStatus.progress2_hp:isValidate()
  PaGlobal_SA_MainFrame._ui_mainStatus.progress2_stamina:isValidate()
end
function PaGlobal_SA_MainFrame:mainStatusInit()
  if nil == Panel_SA_MainFrame then
    return
  end
  local mainStatusBg = UI.getChildControl(Panel_SA_MainFrame, "Static_HPMP")
  local hpBg = UI.getChildControl(mainStatusBg, "Static_HP_Info_BG")
  local staminaBg = UI.getChildControl(mainStatusBg, "Static_MP_Info_BG")
  PaGlobal_SA_MainFrame._ui_mainStatus.progress2_hp = UI.getChildControl(hpBg, "Progress2_1")
  PaGlobal_SA_MainFrame._ui_mainStatus.progress2_stamina = UI.getChildControl(staminaBg, "Progress2_1")
  PaGlobal_SA_MainFrame._ui_mainStatus._hpGaugeHead = UI.getChildControl(PaGlobal_SA_MainFrame._ui_mainStatus.progress2_hp, "Progress2_1_Bar_Head")
  PaGlobal_SA_MainFrame._ui_mainStatus._staminaGaugeHead = UI.getChildControl(PaGlobal_SA_MainFrame._ui_mainStatus.progress2_stamina, "Progress2_1_Bar_Head")
  PaGlobal_SA_MainFrame._ui_mainStatus._txt_hp = UI.getChildControl(hpBg, "StaticText_HP")
  PaGlobal_SA_MainFrame._ui_mainStatus._txt_stamina = UI.getChildControl(staminaBg, "StaticText_MP")
  PaGlobal_SA_MainFrame._ui_mainStatus._stc_characterBG = UI.getChildControl(Panel_SA_MainFrame, "Static_Character")
  PaGlobal_SA_MainFrame._ui_mainStatus._stc_characterIcon = UI.getChildControl(PaGlobal_SA_MainFrame._ui_mainStatus._stc_characterBG, "Static_Character_Slot")
  PaGlobal_SA_MainFrame._ui_mainStatus._stc_characterEffectSlot = UI.getChildControl(PaGlobal_SA_MainFrame._ui_mainStatus._stc_characterBG, "Static_Character_EffectSlot")
  PaGlobal_SA_MainFrame:SetCharacterIcon()
  PaGlobalFunc_SA_MainFrame_User_Bar_Show()
end
function PaGlobal_SA_MainFrame:symbolInit()
  PaGlobal_SA_MainFrame._ui_symbol.stc_symbol = UI.getChildControl(Panel_SA_MainFrame, "Static_Symbol")
  PaGlobal_SA_MainFrame._ui_symbol.stc_symbolHeal = UI.getChildControl(PaGlobal_SA_MainFrame._ui_symbol.stc_symbol, "Static_Symbol_H")
  PaGlobal_SA_MainFrame._ui_symbol.stc_symbolDamaged = UI.getChildControl(PaGlobal_SA_MainFrame._ui_symbol.stc_symbol, "Static_Symbol_P")
  PaGlobal_SA_MainFrame._ui_symbol._symbolHeal[52] = UI.getChildControl(PaGlobal_SA_MainFrame._ui_symbol.stc_symbolHeal, "Static_Jorthaine")
  PaGlobal_SA_MainFrame._ui_symbol._symbolHeal[53] = UI.getChildControl(PaGlobal_SA_MainFrame._ui_symbol.stc_symbolHeal, "Static_Moran")
  PaGlobal_SA_MainFrame._ui_symbol._symbolHeal[55] = UI.getChildControl(PaGlobal_SA_MainFrame._ui_symbol.stc_symbolHeal, "Static_AhhornCyrus")
  PaGlobal_SA_MainFrame._ui_symbol._symbolHeal[58] = UI.getChildControl(PaGlobal_SA_MainFrame._ui_symbol.stc_symbolHeal, "Static_Phobius")
  PaGlobal_SA_MainFrame._ui_symbol._symbolHeal[60] = UI.getChildControl(PaGlobal_SA_MainFrame._ui_symbol.stc_symbolHeal, "Static_Saki")
  PaGlobal_SA_MainFrame._ui_symbol._symbolHeal[63] = UI.getChildControl(PaGlobal_SA_MainFrame._ui_symbol.stc_symbolHeal, "Static_NellyDormin")
  PaGlobal_SA_MainFrame._ui_symbol._symbolDamaged[52] = UI.getChildControl(PaGlobal_SA_MainFrame._ui_symbol.stc_symbolDamaged, "Static_Jorthaine")
  PaGlobal_SA_MainFrame._ui_symbol._symbolDamaged[53] = UI.getChildControl(PaGlobal_SA_MainFrame._ui_symbol.stc_symbolDamaged, "Static_Moran")
  PaGlobal_SA_MainFrame._ui_symbol._symbolDamaged[55] = UI.getChildControl(PaGlobal_SA_MainFrame._ui_symbol.stc_symbolDamaged, "Static_AhhornCyrus")
  PaGlobal_SA_MainFrame._ui_symbol._symbolDamaged[58] = UI.getChildControl(PaGlobal_SA_MainFrame._ui_symbol.stc_symbolDamaged, "Static_Phobius")
  PaGlobal_SA_MainFrame._ui_symbol._symbolDamaged[60] = UI.getChildControl(PaGlobal_SA_MainFrame._ui_symbol.stc_symbolDamaged, "Static_Saki")
  PaGlobal_SA_MainFrame._ui_symbol._symbolDamaged[63] = UI.getChildControl(PaGlobal_SA_MainFrame._ui_symbol.stc_symbolDamaged, "Static_NellyDormin")
end
