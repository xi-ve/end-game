function PaGlobal_ServantSwiftResult_All:initialize()
  if nil == Panel_Dialog_ServantSwiftResult_All or true == PaGlobal_ServantSwiftResult_All.initialize then
    return
  end
  PaGlobal_ServantSwiftResult_All._ui._stc_Horse_ToeHold = UI.getChildControl(Panel_Dialog_ServantSwiftResult_All, "Static_HorseToehold")
  PaGlobal_ServantSwiftResult_All._ui._stc_Success = UI.getChildControl(Panel_Dialog_ServantSwiftResult_All, "Static_AwakenSuccess")
  PaGlobal_ServantSwiftResult_All._ui._stc_Fail = UI.getChildControl(Panel_Dialog_ServantSwiftResult_All, "Static_AwakenSuccess")
  PaGlobal_ServantSwiftResult_All.initialize = true
  PaGlobal_ServantSwiftResult_All:validate()
  PaGlobal_ServantSwiftResult_All:RegisterEventHandler()
end
function PaGlobal_ServantSwiftResult_All:validate()
  if nil == Panel_Dialog_ServantSwiftResult_All or true == PaGlobal_ServantSwiftResult_All.initialize then
    return
  end
  PaGlobal_ServantSwiftResult_All._ui._stc_Horse_ToeHold:isValidate()
  PaGlobal_ServantSwiftResult_All._ui._stc_Success:isValidate()
  PaGlobal_ServantSwiftResult_All._ui._stc_Fail:isValidate()
  PaGlobal_ServantSwiftResult_All.initialize = true
end
function PaGlobal_ServantSwiftResult_All:RegisterEventHandler()
  if nil == Panel_Dialog_ServantSwiftResult_All or false == PaGlobal_ServantSwiftResult_All.initialize then
    return
  end
  registerEvent("onScreenResize", "PaGlobalFunc_ServantSwiftResult_All_OnScreenResize")
end
function PaGlobalFunc_ServantSwiftResult_All_OnScreenResize()
  if nil == Panel_Dialog_ServantSwiftResult_All or false == Panel_Dialog_ServantSwiftResult_All:GetShow() then
    return
  end
  Panel_Dialog_ServantSwiftResult_All:ComputePos()
end
function PaGlobalFunc_ServantSwiftResult_All_AwakenEffect(isAwaken, servantKey)
  if nil == Panel_Dialog_ServantSwiftResult_All then
    return
  end
  if 0 == isAwaken then
    PaGlobalFunc_ServantSwiftResult_All_AddEffect(Panel_Dialog_ServantSwiftResult_All, 6, 0, 220, servantKey)
    return
  elseif true == isAwaken then
    PaGlobal_ServantSwiftResult_All._ui._stc_Horse_ToeHold:SetShow(true)
    PaGlobal_ServantSwiftResult_All._ui._stc_Fail:SetShow(false)
    PaGlobal_ServantSwiftResult_All._ui._stc_Horse_ToeHold:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_STABLESTALLION_TEXT_AWAKENSUCCESS"))
    PaGlobalFunc_ServantSwiftResult_All_AddEffect(Panel_Dialog_ServantSwiftResult_All, 7, 0, 220, servantKey)
  else
    PaGlobal_ServantSwiftResult_All._ui._stc_Horse_ToeHold:SetShow(true)
    PaGlobal_ServantSwiftResult_All._ui._stc_Success:SetShow(false)
    PaGlobal_ServantSwiftResult_All._ui._stc_Horse_ToeHold:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_STABLESTALLION_TEXT_AWAKENFAIL"))
    PaGlobalFunc_ServantSwiftResult_All_AddEffect(Panel_Dialog_ServantSwiftResult_All, 12, 0, 220, servantKey)
  end
end
function PaGlobalFunc_ServantSwiftResult_All_DoAwakenEffect()
  if nil == Panel_Dialog_ServantSwiftResult_All then
    return
  end
  PaGlobalFunc_ServantSwiftResult_All_AddEffect(Panel_Dialog_ServantSwiftResult_All, 13, 0, -190)
end
function PaGlobalFunc_ServantSwiftResult_All_AddEffect(control, index, posX, posY, servantKey)
  if nil == Panel_Dialog_ServantSwiftResult_All then
    return
  end
  if 0 == index then
    control:AddEffect("fUI_Horse_Upgrade_NEW_02A", false, posX, posY)
  elseif 1 == index then
  elseif 2 == index then
    control:AddEffect("fCO_Egg_Random_01B", false, posX, posY)
  elseif 3 == index then
  elseif 4 == index then
    control:AddEffect("fUI_Horse_Upgrade_03A", false, posX, -50)
  elseif 5 == index then
    control:AddEffect("fUI_Horse_Upgrade_04A", false, posX, -50)
  elseif 6 == index then
    control:AddEffect("fUI_Horse_Upgrade_NEW_05B", false, posX, posY)
  elseif 7 == index then
    if 9989 == servantKey or 9889 == servantKey then
      control:AddEffect("fUI_Horse_Upgrade_06B", false, posX, posY)
    elseif 9988 == servantKey or 9888 == servantKey then
      control:AddEffect("fUI_Horse_Upgrade_06C", false, posX, posY)
    elseif 9987 == servantKey or 9887 == servantKey then
      control:AddEffect("fUI_Horse_Upgrade_06D", false, posX, posY)
    end
  elseif 8 == index then
  elseif 9 == index then
    control:AddEffect("fUI_Horse_Upgrade_NEW_01A", false, posX, -80)
  elseif 10 == index then
    control:AddEffect("fUI_Horse_Upgrade_NEW_01B", false, posX, -80)
  elseif 11 == index then
    control:AddEffect("fUI_Horse_Upgrade_NEW_01C", false, posX, -80)
  elseif 12 == index then
    control:AddEffect("fUI_Horse_Upgrade_06A", false, posX, posY)
  elseif 13 == index then
  end
  if nil ~= PaGlobal_ServantSwiftResult_All._effectControl and nil ~= PaGlobal_ServantSwiftResult_All._controlCount then
    PaGlobal_ServantSwiftResult_All._effectControl[PaGlobal_ServantSwiftResult_All._controlCount] = control
    PaGlobal_ServantSwiftResult_All._controlCount = PaGlobal_ServantSwiftResult_All._controlCount + 1
  end
end
function PaGlobalFunc_ServantSwiftResult_All_EffectErase()
  if nil == Panel_Dialog_ServantSwiftResult_All then
    return
  end
  for i = 0, PaGlobal_ServantSwiftResult_All._controlCount - 1 do
    if nil ~= PaGlobal_ServantSwiftResult_All._effectControl[i] then
      PaGlobal_ServantSwiftResult_All._effectControl[i]:EraseAllEffect()
    end
  end
end
function PaGlobalFunc_ServantSwiftResult_All_EffectClose()
  if nil == Panel_Dialog_ServantSwiftResult_All then
    return
  end
  PaGlobal_ServantSwiftResult_All._controlCount = 0
  PaGlobal_ServantSwiftResult_All._effectControl = {}
  Panel_Dialog_ServantSwiftResult_All:SetShow(false)
  PaGlobal_ServantSwiftResult_All._ui._stc_Horse_ToeHold:SetShow(false)
  PaGlobal_ServantSwiftResult_All._ui._stc_Success:SetShow(false)
  PaGlobal_ServantSwiftResult_All._ui._stc_Fail:SetShow(false)
end
function PaGlobalFunc_ServantSwiftResult_All_OnlyPanelShow(isShow)
  if nil == Panel_Dialog_ServantSwiftResult_All then
    return
  end
  Panel_Dialog_ServantSwiftResult_All:SetShow(isShow)
end
