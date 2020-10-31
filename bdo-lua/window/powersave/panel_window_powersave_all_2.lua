function PaGlobalFunc_PowerSave_All_Open()
  PaGlobal_PowerSave_All:prepareOpen()
end
function PaGlobalFunc_PowerSave_All_Close()
  PaGlobal_PowerSave_All:prepareClose()
end
function PaGlobalFunc_PowerSave_All_Sleep()
  local hideColorAni = Panel_Window_PowerSave_All:addColorAnimation(0, 0.5, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
  hideColorAni:SetStartColor(Defines.Color.C_00FFFFFF)
  hideColorAni:SetEndColor(Defines.Color.C_FFFFFFFF)
  local topColorAni = PaGlobal_PowerSave_All._ui.stc_top:addColorAnimation(0, 0.5, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
  topColorAni:SetStartColor(Defines.Color.C_00FFFFFF)
  topColorAni:SetEndColor(Defines.Color.C_FFFFFFFF)
  local bottomColorAni = PaGlobal_PowerSave_All._ui.stc_bottom:addColorAnimation(0, 0.5, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
  bottomColorAni:SetStartColor(Defines.Color.C_00FFFFFF)
  bottomColorAni:SetEndColor(Defines.Color.C_FFFFFFFF)
  local centerColorAni = PaGlobal_PowerSave_All._ui.stc_center:addColorAnimation(0, 0.5, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
  centerColorAni:SetStartColor(Defines.Color.C_00FFFFFF)
  centerColorAni:SetEndColor(Defines.Color.C_FFFFFFFF)
end
function PaGlobalFunc_PowerSave_All_Awake()
  if true == PaGlobal_PowerSave_All._isAnimating then
    return
  end
  PaGlobal_PowerSave_All._isAnimating = true
  PaGlobal_PowerSave_All._isOpen = false
  ToClinet_SetConsoleSleepMode(false)
  PaGlobal_PowerSave_All._renderMode:reset()
  local moveDistance = 150
  local topMoveAni = PaGlobal_PowerSave_All._ui.stc_top:addMoveAnimation(0, 0.1, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_LINEAR)
  topMoveAni:SetStartPosition(PaGlobal_PowerSave_All._originMarkPosX, PaGlobal_PowerSave_All._originTopMarkPosY)
  topMoveAni:SetEndPosition(PaGlobal_PowerSave_All._originMarkPosX, PaGlobal_PowerSave_All._originTopMarkPosY - moveDistance)
  local bottomMoveAni = PaGlobal_PowerSave_All._ui.stc_bottom:addMoveAnimation(0, 0.1, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_LINEAR)
  bottomMoveAni:SetStartPosition(PaGlobal_PowerSave_All._originMarkPosX, PaGlobal_PowerSave_All._originBottomMarkPosY)
  bottomMoveAni:SetEndPosition(PaGlobal_PowerSave_All._originMarkPosX, PaGlobal_PowerSave_All._originBottomMarkPosY + moveDistance)
  PaGlobal_PowerSave_All._ui.stc_centerEffect:AddEffect("fUI_Consol_Lock_02A", false, 0, 0)
  local hideColorAni = Panel_Window_PowerSave_All:addColorAnimation(0.3, 0.7, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
  hideColorAni:SetStartColor(Defines.Color.C_FFFFFFFF)
  hideColorAni:SetEndColor(Defines.Color.C_00FFFFFF)
  hideColorAni:SetHideAtEnd(true)
  local topColorAni = PaGlobal_PowerSave_All._ui.stc_top:addColorAnimation(0.3, 0.7, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
  topColorAni:SetStartColor(Defines.Color.C_FFFFFFFF)
  topColorAni:SetEndColor(Defines.Color.C_00FFFFFF)
  local bottomColorAni = PaGlobal_PowerSave_All._ui.stc_bottom:addColorAnimation(0.3, 0.7, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
  bottomColorAni:SetStartColor(Defines.Color.C_FFFFFFFF)
  bottomColorAni:SetEndColor(Defines.Color.C_00FFFFFF)
  local centerColorAni = PaGlobal_PowerSave_All._ui.stc_center:addColorAnimation(0.3, 0.7, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
  centerColorAni:SetStartColor(Defines.Color.C_FFFFFFFF)
  centerColorAni:SetEndColor(Defines.Color.C_00FFFFFF)
end
function FromClient_PowerSave_All_Resize()
  if nil == Panel_PowerSave_All then
    return
  end
  PaGlobal_PowerSave_All:resize()
end
function FromClient_PowerSave_All_NotifyConsoleSleepMode(isSleep)
  if true == isSleep then
    PaGlobalFunc_PowerSave_All_Open()
  else
    PaGlobalFunc_PowerSave_All_Close()
  end
end
function PaGlobalFunc_PowerSave_All_GetOpen()
  return PaGlobal_PowerSave_All._isOpen
end
