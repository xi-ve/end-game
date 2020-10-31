local UI_color = Defines.Color
local UI_ANI_ADV = CppEnums.PAUI_ANIM_ADVANCE_TYPE
local UI_VT = CppEnums.VehicleType
Panel_Cannon:SetShow(false, false)
Panel_Cannon:RegisterShowEventFunc(true, "CannonShowAni()")
Panel_Cannon:RegisterShowEventFunc(false, "CannonHideAni()")
Panel_Cannon_Value_IsCannon = false
local _enum_CannonType = {
  _default = 0,
  _cannon = 1,
  _throwStone = 2,
  _throwFire = 3,
  _ballista = 4,
  _train = 5,
  _monsterHuntCannon = 6
}
local progresssBG = UI.getChildControl(Panel_Cannon, "Cannon_ProgresssBG")
local progresss = UI.getChildControl(Panel_Cannon, "Progress2_1")
local progresss_Head = UI.getChildControl(progresss, "Progress2_1_Bar_Head")
local arrowProgressBG = UI.getChildControl(Panel_Cannon, "Arrow_ProgresssBG")
local arrowProgress = UI.getChildControl(Panel_Cannon, "ArrowProgress2_1")
local arrowProgress_Head = UI.getChildControl(arrowProgress, "Progress2_1_Bar_Head")
local flameProgressBG = UI.getChildControl(Panel_Cannon, "FlameThrower_ProgresssBG")
local flameProgress = UI.getChildControl(Panel_Cannon, "FlameThrowerProgress2_1")
local flameProgress_Head = UI.getChildControl(flameProgress, "Progress2_1_Bar_Head")
local ballistaProgressBG = UI.getChildControl(Panel_Cannon, "Ballista_ProgresssBG")
local ballistaProgresss = UI.getChildControl(Panel_Cannon, "BallistaProgress2_1")
local shootCount = UI.getChildControl(Panel_Cannon, "StaticText_ShootCount")
local vehicle_actorKeyRaw = 0
local vehicle_characterKeyRaw = 0
local skillCommandAlreadyShow = false
local _current_cannonType = _enum_CannonType._default
local shiftPosX = 10
local shiftKeyPosX = 65
local descPosX = 65
local shiftDescPosX = 70
local shiftKeyDescPosX = 100
local shiftMouseDescPosX = 116
local basicPosY = 10
local keySizeY = 30
local mouseSizeY = 37
local fireGuide = {
  fireGuide_BG = UI.getChildControl(Panel_Cannon, "Static_CommandBG"),
  fireGuide_KeyShift1 = UI.getChildControl(Panel_Cannon, "StaticText_Key_Shift1"),
  fireGuide_KeyShift2 = UI.getChildControl(Panel_Cannon, "StaticText_Key_Shift2"),
  fireGuide_KeyShift3 = UI.getChildControl(Panel_Cannon, "StaticText_Key_Shift3"),
  fireGuide_KeyShift4 = UI.getChildControl(Panel_Cannon, "StaticText_Key_Shift4"),
  fireGuide_KeyW = UI.getChildControl(Panel_Cannon, "StaticText_Key_W"),
  fireGuide_KeyS = UI.getChildControl(Panel_Cannon, "StaticText_Key_S"),
  fireGuide_MouseL = UI.getChildControl(Panel_Cannon, "Static_Key_MouseL_0"),
  fireGuide_MouseR = UI.getChildControl(Panel_Cannon, "Static_Key_MouseR_0"),
  fireGuide_MouseL2 = UI.getChildControl(Panel_Cannon, "Static_Key_MouseL_1"),
  fireGuide_MouseR2 = UI.getChildControl(Panel_Cannon, "Static_Key_MouseR_1"),
  fireGuide_Space = UI.getChildControl(Panel_Cannon, "StaticText_Key_Space"),
  fireGuide_Text_Ready = UI.getChildControl(Panel_Cannon, "StaticText_Ready"),
  fireGuide_Text_High = UI.getChildControl(Panel_Cannon, "StaticText_HighAngle"),
  fireGuide_Text_Low = UI.getChildControl(Panel_Cannon, "StaticText_LowAngle"),
  fireGuide_Text_Fire = UI.getChildControl(Panel_Cannon, "StaticText_Fire"),
  fireGuide_KeyQ = UI.getChildControl(Panel_Cannon, "StaticText_Key_Q"),
  fireGuide_KeyE = UI.getChildControl(Panel_Cannon, "StaticText_Key_E"),
  fireGuide_KeyX = UI.getChildControl(Panel_Cannon, "StaticText_Key_X"),
  fireGuide_KeyC = UI.getChildControl(Panel_Cannon, "StaticText_Key_C"),
  fireGuide_Text_Rapid = UI.getChildControl(Panel_Cannon, "StaticText_Rapidfire"),
  fireGuide_Text_Protect = UI.getChildControl(Panel_Cannon, "StaticText_Protect"),
  fireGuide_Text_Charge = UI.getChildControl(Panel_Cannon, "StaticText_ChargeFire")
}
fireGuide.fireGuide_BG:AddChild(fireGuide.fireGuide_KeyShift1)
fireGuide.fireGuide_BG:AddChild(fireGuide.fireGuide_KeyShift2)
fireGuide.fireGuide_BG:AddChild(fireGuide.fireGuide_KeyShift3)
fireGuide.fireGuide_BG:AddChild(fireGuide.fireGuide_KeyShift4)
fireGuide.fireGuide_BG:AddChild(fireGuide.fireGuide_KeyW)
fireGuide.fireGuide_BG:AddChild(fireGuide.fireGuide_KeyS)
fireGuide.fireGuide_BG:AddChild(fireGuide.fireGuide_MouseL)
fireGuide.fireGuide_BG:AddChild(fireGuide.fireGuide_MouseR)
fireGuide.fireGuide_BG:AddChild(fireGuide.fireGuide_Space)
fireGuide.fireGuide_BG:AddChild(fireGuide.fireGuide_Text_Ready)
fireGuide.fireGuide_BG:AddChild(fireGuide.fireGuide_Text_High)
fireGuide.fireGuide_BG:AddChild(fireGuide.fireGuide_Text_Low)
fireGuide.fireGuide_BG:AddChild(fireGuide.fireGuide_Text_Fire)
fireGuide.fireGuide_BG:AddChild(fireGuide.fireGuide_KeyQ)
fireGuide.fireGuide_BG:AddChild(fireGuide.fireGuide_KeyE)
fireGuide.fireGuide_BG:AddChild(fireGuide.fireGuide_KeyX)
fireGuide.fireGuide_BG:AddChild(fireGuide.fireGuide_KeyC)
fireGuide.fireGuide_BG:AddChild(fireGuide.fireGuide_Text_Rapid)
fireGuide.fireGuide_BG:AddChild(fireGuide.fireGuide_Text_Protect)
fireGuide.fireGuide_BG:AddChild(fireGuide.fireGuide_MouseL2)
fireGuide.fireGuide_BG:AddChild(fireGuide.fireGuide_MouseR2)
fireGuide.fireGuide_BG:AddChild(fireGuide.fireGuide_Text_Charge)
Panel_Cannon:RemoveControl(fireGuide.fireGuide_KeyShift1)
Panel_Cannon:RemoveControl(fireGuide.fireGuide_KeyShift2)
Panel_Cannon:RemoveControl(fireGuide.fireGuide_KeyShift3)
Panel_Cannon:RemoveControl(fireGuide.fireGuide_KeyShift4)
Panel_Cannon:RemoveControl(fireGuide.fireGuide_KeyW)
Panel_Cannon:RemoveControl(fireGuide.fireGuide_KeyS)
Panel_Cannon:RemoveControl(fireGuide.fireGuide_MouseL)
Panel_Cannon:RemoveControl(fireGuide.fireGuide_MouseR)
Panel_Cannon:RemoveControl(fireGuide.fireGuide_Space)
Panel_Cannon:RemoveControl(fireGuide.fireGuide_Text_Ready)
Panel_Cannon:RemoveControl(fireGuide.fireGuide_Text_High)
Panel_Cannon:RemoveControl(fireGuide.fireGuide_Text_Low)
Panel_Cannon:RemoveControl(fireGuide.fireGuide_Text_Fire)
Panel_Cannon:RemoveControl(fireGuide.fireGuide_KeyQ)
Panel_Cannon:RemoveControl(fireGuide.fireGuide_KeyE)
Panel_Cannon:RemoveControl(fireGuide.fireGuide_KeyX)
Panel_Cannon:RemoveControl(fireGuide.fireGuide_KeyC)
Panel_Cannon:RemoveControl(fireGuide.fireGuide_Text_Rapid)
Panel_Cannon:RemoveControl(fireGuide.fireGuide_Text_Protect)
Panel_Cannon:RemoveControl(fireGuide.fireGuide_MouseL2)
Panel_Cannon:RemoveControl(fireGuide.fireGuide_MouseR2)
Panel_Cannon:RemoveControl(fireGuide.fireGuide_Text_Charge)
function CannonShowAni()
  local aniInfo1 = Panel_Cannon:addScaleAnimation(0, 0.08, UI_ANI_ADV.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfo1:SetStartScale(0.5)
  aniInfo1:SetEndScale(1.05)
  aniInfo1.AxisX = Panel_Cannon:GetSizeX() / 2
  aniInfo1.AxisY = Panel_Cannon:GetSizeY() / 2
  aniInfo1.ScaleType = 2
  aniInfo1.IsChangeChild = true
  local aniInfo2 = Panel_Cannon:addScaleAnimation(0.08, 0.15, UI_ANI_ADV.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfo2:SetStartScale(1.05)
  aniInfo2:SetEndScale(1)
  aniInfo2.AxisX = Panel_Cannon:GetSizeX() / 2
  aniInfo2.AxisY = Panel_Cannon:GetSizeY() / 2
  aniInfo2.ScaleType = 2
  aniInfo2.IsChangeChild = true
end
function CannonHideAni()
  Panel_Cannon:SetShowWithFade(CppEnums.PAUI_SHOW_FADE_TYPE.PAUI_ANI_TYPE_FADE_OUT)
  local aniInfo1 = Panel_Cannon:addColorAnimation(0, 0.15, UI_ANI_ADV.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
  aniInfo1:SetStartColor(UI_color.C_FFFFFFFF)
  aniInfo1:SetEndColor(UI_color.C_00FFFFFF)
  aniInfo1:SetStartIntensity(3)
  aniInfo1:SetEndIntensity(1)
  aniInfo1.IsChangeChild = true
  aniInfo1:SetHideAtEnd(true)
  aniInfo1:SetDisableWhileAni(true)
end
local function Cannon_Initialize()
  Panel_Cannon:SetPosX(getScreenSizeX() / 2 - Panel_Cannon:GetSizeX() / 2 - 240)
  Panel_Cannon:SetPosY(getScreenSizeY() / 2)
  progresssBG:SetShow(false)
  progresss:SetShow(false)
  progresss:SetProgressRate(100)
  progresss:SetCurrentProgressRate(100)
  progresss_Head:SetShow(false)
  progresss:SetAniSpeed(0)
  arrowProgressBG:SetShow(false)
  arrowProgress:SetShow(false)
  arrowProgress:SetProgressRate(100)
  arrowProgress:SetCurrentProgressRate(100)
  arrowProgress_Head:SetShow(false)
  arrowProgress:SetAniSpeed(0)
  flameProgressBG:SetShow(false)
  flameProgress:SetShow(false)
  flameProgress:SetProgressRate(100)
  flameProgress:SetCurrentProgressRate(100)
  flameProgress_Head:SetShow(false)
  flameProgress:SetAniSpeed(0)
  local offset = shootCount:GetSizeX() / 2 - ballistaProgressBG:GetSizeX() / 2 - 3
  ballistaProgressBG:SetSpanSize(offset, 0)
  ballistaProgresss:SetSpanSize(offset, 0)
  ballistaProgressBG:SetShow(false)
  ballistaProgresss:SetShow(false)
  ballistaProgresss:SetProgressRate(100)
  ballistaProgresss:SetCurrentProgressRate(100)
  ballistaProgresss:SetAniSpeed(0)
  fireGuide.fireGuide_BG:SetPosX(Panel_Cannon:GetSizeX() / 2 + 400)
  fireGuide.fireGuide_KeyShift1:SetPosX(10)
  fireGuide.fireGuide_KeyShift2:SetPosX(10)
  fireGuide.fireGuide_KeyShift3:SetPosX(10)
  fireGuide.fireGuide_KeyShift4:SetPosX(10)
  fireGuide.fireGuide_KeyW:SetPosX(65)
  fireGuide.fireGuide_KeyS:SetPosX(65)
  fireGuide.fireGuide_MouseL:SetPosX(65)
  fireGuide.fireGuide_MouseR:SetPosX(81)
  fireGuide.fireGuide_Text_Ready:SetPosX(70)
  fireGuide.fireGuide_Text_High:SetPosX(100)
  fireGuide.fireGuide_Text_Low:SetPosX(100)
  fireGuide.fireGuide_Text_Fire:SetPosX(112)
  fireGuide.fireGuide_KeyShift1:SetFontColor(4294312447)
  fireGuide.fireGuide_KeyShift2:SetFontColor(4294312447)
  fireGuide.fireGuide_KeyShift3:SetFontColor(4294312447)
  fireGuide.fireGuide_KeyShift4:SetFontColor(4294312447)
  fireGuide.fireGuide_KeyW:SetFontColor(4294312447)
  fireGuide.fireGuide_KeyS:SetFontColor(4294312447)
end
local nowCool = 0
local cannon = {}
function FromClient_Cannon_ProgressUpdate()
  if 0 == vehicle_actorKeyRaw then
    return
  end
  cannon = getVehicleActor(vehicle_actorKeyRaw)
  local nowCoolTime = 0
  if nil ~= cannon then
    local mp = cannon:get():getMp()
    local maxMp = cannon:get():getMaxMp()
    nowCoolTime = mp / maxMp * 100
  end
  if UI_VT.Type_Cannon == cannon:get():getVehicleType() or UI_VT.Type_PracticeCannon == cannon:get():getVehicleType() then
    progresss:SetAniSpeed(0.5)
    progresss:SetProgressRate(nowCoolTime)
  elseif UI_VT.Type_ThrowFire == cannon:get():getVehicleType() then
    flameProgress:SetAniSpeed(0.5)
    flameProgress:SetProgressRate(nowCoolTime)
  elseif UI_VT.Type_ThrowStone == cannon:get():getVehicleType() then
    arrowProgress:SetAniSpeed(0.5)
    arrowProgress:SetProgressRate(nowCoolTime)
  elseif UI_VT.Type_Ballista == cannon:get():getVehicleType() then
    ballistaProgresss:SetAniSpeed(0.5)
    ballistaProgresss:SetProgressRate(nowCoolTime)
  else
    return
  end
end
function Cannon_ShowCannonGuide(show)
  fireGuide.fireGuide_BG:SetSize(185, 145)
  fireGuide.fireGuide_KeyShift1:SetPosY(basicPosY)
  fireGuide.fireGuide_KeyShift2:SetPosY(basicPosY + keySizeY)
  fireGuide.fireGuide_KeyShift3:SetPosY(basicPosY + keySizeY * 2)
  fireGuide.fireGuide_KeyShift4:SetPosY(basicPosY + keySizeY * 3)
  fireGuide.fireGuide_KeyW:SetPosY(basicPosY)
  fireGuide.fireGuide_KeyS:SetPosY(basicPosY + keySizeY)
  fireGuide.fireGuide_MouseL:SetPosY(basicPosY + keySizeY * 3)
  fireGuide.fireGuide_MouseR:SetPosY(basicPosY + keySizeY * 3)
  fireGuide.fireGuide_Text_High:SetPosY(basicPosY)
  fireGuide.fireGuide_Text_Low:SetPosY(basicPosY + keySizeY)
  fireGuide.fireGuide_Text_Ready:SetPosY(basicPosY + keySizeY * 2)
  fireGuide.fireGuide_Text_Fire:SetPosY(basicPosY + keySizeY * 2 + mouseSizeY)
  fireGuide.fireGuide_KeyShift1:SetPosX(shiftPosX)
  fireGuide.fireGuide_KeyShift2:SetPosX(shiftPosX)
  fireGuide.fireGuide_KeyShift3:SetPosX(shiftPosX)
  fireGuide.fireGuide_KeyShift4:SetPosX(shiftPosX)
  fireGuide.fireGuide_KeyW:SetPosX(shiftKeyPosX)
  fireGuide.fireGuide_KeyS:SetPosX(shiftKeyPosX)
  fireGuide.fireGuide_MouseL:SetPosX(shiftKeyPosX)
  fireGuide.fireGuide_MouseR:SetPosX(shiftKeyPosX + 16)
  fireGuide.fireGuide_Text_Ready:SetPosX(shiftDescPosX)
  fireGuide.fireGuide_Text_High:SetPosX(shiftKeyDescPosX)
  fireGuide.fireGuide_Text_Low:SetPosX(shiftKeyDescPosX)
  fireGuide.fireGuide_Text_Fire:SetPosX(shiftMouseDescPosX)
  fireGuide.fireGuide_BG:SetShow(show)
  fireGuide.fireGuide_KeyShift1:SetShow(show)
  fireGuide.fireGuide_KeyShift2:SetShow(show)
  fireGuide.fireGuide_KeyShift3:SetShow(show)
  fireGuide.fireGuide_KeyShift4:SetShow(show)
  fireGuide.fireGuide_KeyW:SetShow(show)
  fireGuide.fireGuide_KeyS:SetShow(show)
  fireGuide.fireGuide_MouseL:SetShow(show)
  fireGuide.fireGuide_MouseR:SetShow(show)
  fireGuide.fireGuide_Text_Ready:SetShow(show)
  fireGuide.fireGuide_Text_High:SetShow(show)
  fireGuide.fireGuide_Text_Low:SetShow(show)
  fireGuide.fireGuide_Text_Fire:SetShow(show)
end
function Cannon_ShowThrowFireGuide(show)
  fireGuide.fireGuide_BG:SetSize(185, 45)
  fireGuide.fireGuide_Space:SetPosY(basicPosY)
  fireGuide.fireGuide_Space:SetPosX(shiftPosX)
  fireGuide.fireGuide_Text_Fire:SetPosY(basicPosY)
  fireGuide.fireGuide_Text_Fire:SetPosX(shiftDescPosX)
  fireGuide.fireGuide_BG:SetShow(show)
  fireGuide.fireGuide_Space:SetShow(show)
  fireGuide.fireGuide_Text_Fire:SetShow(show)
end
function Cannon_ShowBallistaGuide(show)
  fireGuide.fireGuide_BG:SetSize(185, 145)
  fireGuide.fireGuide_KeyShift1:SetPosY(basicPosY)
  fireGuide.fireGuide_KeyShift2:SetPosY(basicPosY + keySizeY)
  fireGuide.fireGuide_KeyShift3:SetPosY(basicPosY + keySizeY * 2)
  fireGuide.fireGuide_KeyShift4:SetPosY(basicPosY + keySizeY * 3)
  fireGuide.fireGuide_KeyW:SetPosY(basicPosY + keySizeY)
  fireGuide.fireGuide_KeyS:SetPosY(basicPosY)
  fireGuide.fireGuide_MouseL:SetPosY(basicPosY + keySizeY * 3)
  fireGuide.fireGuide_MouseR:SetPosY(basicPosY + keySizeY * 3)
  fireGuide.fireGuide_Text_High:SetPosY(basicPosY)
  fireGuide.fireGuide_Text_Low:SetPosY(basicPosY + keySizeY)
  fireGuide.fireGuide_Text_Ready:SetPosY(basicPosY + keySizeY * 2)
  fireGuide.fireGuide_Text_Fire:SetPosY(basicPosY + keySizeY * 2 + mouseSizeY)
  fireGuide.fireGuide_KeyShift1:SetPosX(shiftPosX)
  fireGuide.fireGuide_KeyShift2:SetPosX(shiftPosX)
  fireGuide.fireGuide_KeyShift3:SetPosX(shiftPosX)
  fireGuide.fireGuide_KeyShift4:SetPosX(shiftPosX)
  fireGuide.fireGuide_KeyW:SetPosX(shiftKeyPosX)
  fireGuide.fireGuide_KeyS:SetPosX(shiftKeyPosX)
  fireGuide.fireGuide_MouseL:SetPosX(shiftKeyPosX)
  fireGuide.fireGuide_MouseR:SetPosX(shiftKeyPosX + 16)
  fireGuide.fireGuide_Text_Ready:SetPosX(shiftDescPosX)
  fireGuide.fireGuide_Text_High:SetPosX(shiftKeyDescPosX)
  fireGuide.fireGuide_Text_Low:SetPosX(shiftKeyDescPosX)
  fireGuide.fireGuide_Text_Fire:SetPosX(shiftMouseDescPosX)
  fireGuide.fireGuide_BG:SetShow(show)
  fireGuide.fireGuide_KeyShift1:SetShow(show)
  fireGuide.fireGuide_KeyShift2:SetShow(show)
  fireGuide.fireGuide_KeyShift3:SetShow(show)
  fireGuide.fireGuide_KeyShift4:SetShow(show)
  fireGuide.fireGuide_KeyW:SetShow(show)
  fireGuide.fireGuide_KeyS:SetShow(show)
  fireGuide.fireGuide_MouseL:SetShow(show)
  fireGuide.fireGuide_MouseR:SetShow(show)
  fireGuide.fireGuide_Text_Ready:SetShow(show)
  fireGuide.fireGuide_Text_High:SetShow(show)
  fireGuide.fireGuide_Text_Low:SetShow(show)
  fireGuide.fireGuide_Text_Fire:SetShow(show)
end
function Cannon_ShowTrainGuide(show)
  fireGuide.fireGuide_BG:SetSize(185, 105)
  fireGuide.fireGuide_KeyW:SetPosY(basicPosY)
  fireGuide.fireGuide_KeyS:SetPosY(basicPosY + keySizeY)
  fireGuide.fireGuide_Text_High:SetPosY(basicPosY)
  fireGuide.fireGuide_Text_Low:SetPosY(basicPosY + keySizeY)
  fireGuide.fireGuide_Space:SetPosY(basicPosY + keySizeY * 2)
  fireGuide.fireGuide_Text_Fire:SetPosY(basicPosY + keySizeY * 2)
  fireGuide.fireGuide_KeyW:SetPosX(shiftPosX)
  fireGuide.fireGuide_KeyS:SetPosX(shiftPosX)
  fireGuide.fireGuide_Text_High:SetPosX(shiftKeyPosX)
  fireGuide.fireGuide_Text_Low:SetPosX(shiftKeyPosX)
  fireGuide.fireGuide_Space:SetPosX(shiftPosX)
  fireGuide.fireGuide_Text_Fire:SetPosX(shiftKeyPosX)
  fireGuide.fireGuide_BG:SetShow(show)
  fireGuide.fireGuide_KeyW:SetShow(show)
  fireGuide.fireGuide_KeyS:SetShow(show)
  fireGuide.fireGuide_Space:SetShow(show)
  fireGuide.fireGuide_Text_High:SetShow(show)
  fireGuide.fireGuide_Text_Low:SetShow(show)
  fireGuide.fireGuide_Text_Fire:SetShow(show)
end
function Cannon_ShowMonsterHuntCannonGuide(show)
  local addSizeIndex = 0
  fireGuide.fireGuide_KeyQ:SetPosY(basicPosY + keySizeY * addSizeIndex)
  fireGuide.fireGuide_Text_High:SetPosY(basicPosY + keySizeY * addSizeIndex)
  addSizeIndex = addSizeIndex + 1
  fireGuide.fireGuide_KeyE:SetPosY(basicPosY + keySizeY * addSizeIndex)
  fireGuide.fireGuide_Text_Low:SetPosY(basicPosY + keySizeY * addSizeIndex)
  addSizeIndex = addSizeIndex + 1
  fireGuide.fireGuide_KeyX:SetPosY(basicPosY + keySizeY * addSizeIndex)
  fireGuide.fireGuide_Text_Rapid:SetPosY(basicPosY + keySizeY * addSizeIndex)
  addSizeIndex = addSizeIndex + 1
  fireGuide.fireGuide_MouseL:SetPosY(basicPosY + keySizeY * addSizeIndex)
  fireGuide.fireGuide_MouseR:SetPosY(basicPosY + keySizeY * addSizeIndex)
  fireGuide.fireGuide_Text_Fire:SetPosY(basicPosY + keySizeY * addSizeIndex)
  fireGuide.fireGuide_MouseL2:SetPosY(basicPosY + keySizeY * addSizeIndex + mouseSizeY)
  fireGuide.fireGuide_MouseR2:SetPosY(basicPosY + keySizeY * addSizeIndex + mouseSizeY)
  fireGuide.fireGuide_Text_Charge:SetPosY(basicPosY + keySizeY * addSizeIndex + mouseSizeY)
  local sizeY = basicPosY + keySizeY * addSizeIndex + mouseSizeY + fireGuide.fireGuide_Text_Charge:GetSizeY() + 20
  local keyguides = {
    [0] = fireGuide.fireGuide_Text_High,
    fireGuide.fireGuide_Text_Low,
    fireGuide.fireGuide_Text_Rapid,
    fireGuide.fireGuide_Text_Fire,
    fireGuide.fireGuide_Text_Charge
  }
  local margin = 55
  local textSizeX = 0
  for i = 0, #keyguides do
    if textSizeX < keyguides[i]:GetTextSizeX() then
      textSizeX = keyguides[i]:GetTextSizeX()
    end
  end
  local sizeX = textSizeX + margin + fireGuide.fireGuide_KeyQ:GetSizeX()
  fireGuide.fireGuide_BG:SetSize(sizeX, sizeY)
  fireGuide.fireGuide_KeyQ:SetPosX(shiftPosX)
  fireGuide.fireGuide_Text_High:SetPosX(descPosX)
  fireGuide.fireGuide_KeyE:SetPosX(shiftPosX)
  fireGuide.fireGuide_Text_Low:SetPosX(descPosX)
  fireGuide.fireGuide_KeyX:SetPosX(shiftPosX)
  fireGuide.fireGuide_Text_Rapid:SetPosX(descPosX)
  fireGuide.fireGuide_MouseL:SetPosX(shiftPosX)
  fireGuide.fireGuide_MouseR:SetPosX(shiftPosX + 16)
  fireGuide.fireGuide_Text_Fire:SetPosX(descPosX)
  fireGuide.fireGuide_MouseL2:SetPosX(shiftPosX)
  fireGuide.fireGuide_MouseR2:SetPosX(shiftPosX + 16)
  fireGuide.fireGuide_Text_Charge:SetPosX(descPosX)
  fireGuide.fireGuide_BG:SetShow(show)
  fireGuide.fireGuide_KeyQ:SetShow(show)
  fireGuide.fireGuide_Text_High:SetShow(show)
  fireGuide.fireGuide_KeyE:SetShow(show)
  fireGuide.fireGuide_Text_Low:SetShow(show)
  fireGuide.fireGuide_KeyX:SetShow(show)
  fireGuide.fireGuide_Text_Rapid:SetShow(show)
  fireGuide.fireGuide_MouseL:SetShow(show)
  fireGuide.fireGuide_MouseR:SetShow(show)
  fireGuide.fireGuide_Text_Fire:SetShow(show)
  fireGuide.fireGuide_MouseL2:SetShow(show)
  fireGuide.fireGuide_MouseR2:SetShow(show)
  fireGuide.fireGuide_Text_Charge:SetShow(show)
end
function Cannon_GuideShow(show)
  if show == fireGuide.fireGuide_BG:GetShow() then
    return
  end
  for _, value in pairs(fireGuide) do
    value:SetShow(false)
  end
  fireGuide.fireGuide_BG:SetSize(185, 145)
  if _current_cannonType == _enum_CannonType._cannon or _current_cannonType == _enum_CannonType._throwStone then
    Cannon_ShowCannonGuide(show)
  elseif _current_cannonType == _enum_CannonType._throwFire then
    Cannon_ShowThrowFireGuide(show)
  elseif _current_cannonType == _enum_CannonType._ballista then
    Cannon_ShowBallistaGuide(show)
  elseif _current_cannonType == _enum_CannonType._train then
    Cannon_ShowTrainGuide(show)
  elseif _current_cannonType == _enum_CannonType._monsterHuntCannon then
    Cannon_ShowMonsterHuntCannonGuide(show)
  end
end
function PaGlobal_Cannon_SetControlShowByType(isVehicleType)
  progresssBG:SetShow(false)
  progresss:SetShow(false)
  progresss_Head:SetShow(false)
  arrowProgressBG:SetShow(false)
  arrowProgress:SetShow(false)
  arrowProgress_Head:SetShow(false)
  flameProgress:SetShow(false)
  flameProgressBG:SetShow(false)
  flameProgress_Head:SetShow(false)
  ballistaProgresss:SetShow(false)
  ballistaProgressBG:SetShow(false)
  if UI_VT.Type_Cannon == isVehicleType or UI_VT.Type_PracticeCannon == isVehicleType then
    progresssBG:SetShow(true)
    progresss:SetShow(true)
    progresss_Head:SetShow(true)
  elseif UI_VT.Type_ThrowStone == isVehicleType then
    arrowProgressBG:SetShow(true)
    arrowProgress:SetShow(true)
    arrowProgress_Head:SetShow(true)
  elseif UI_VT.Type_ThrowFire == isVehicleType then
    flameProgress:SetShow(true)
    flameProgressBG:SetShow(true)
    flameProgress_Head:SetShow(true)
  elseif UI_VT.Type_Ballista == isVehicleType then
    ballistaProgresss:SetShow(true)
    ballistaProgressBG:SetShow(true)
  elseif UI_VT.Type_Train == isVehicleType then
  end
end
function FromClient_Cannon_Show(actorKeyRaw)
  if Panel_Cannon:GetShow() then
    return
  end
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  local seatPosition = selfPlayer:get():getVehicleSeatIndex()
  local isVehicleType = getVehicleActor(actorKeyRaw):get():getVehicleType()
  local servantWrapper = getVehicleActor(actorKeyRaw)
  if nil ~= servantWrapper then
    vehicle_characterKeyRaw = servantWrapper:getCharacterKeyRaw()
  end
  Cannon_Initialize()
  vehicle_actorKeyRaw = actorKeyRaw
  PaGlobal_Cannon_SetControlShowByType(isVehicleType)
  if true == Panel_SkillCommand:GetShow() then
    Panel_SkillCommand:SetShow(false)
    skillCommandAlreadyShow = true
  end
  local nowCoolTime = 0
  if UI_VT.Type_Cannon == isVehicleType or UI_VT.Type_PracticeCannon == isVehicleType or UI_VT.Type_ThrowStone == isVehicleType or UI_VT.Type_ThrowFire == isVehicleType or UI_VT.Type_Ballista == isVehicleType then
    Panel_Cannon:SetShow(true, true)
    Panel_Cannon_Value_IsCannon = true
    cannon = getVehicleActor(vehicle_actorKeyRaw)
    local mp = cannon:get():getMp()
    local maxMp = cannon:get():getMaxMp()
    nowCoolTime = mp / maxMp * 100
  end
  if UI_VT.Type_Cannon == isVehicleType or UI_VT.Type_PracticeCannon == isVehicleType then
    progresss:SetProgressRate(nowCoolTime)
    if 31046 == vehicle_characterKeyRaw then
      _current_cannonType = _enum_CannonType._monsterHuntCannon
      Cannon_GuideShow(true)
    else
      _current_cannonType = _enum_CannonType._cannon
      Cannon_GuideShow(true)
    end
  elseif UI_VT.Type_ThrowStone == isVehicleType then
    arrowProgress:SetProgressRate(nowCoolTime)
    _current_cannonType = _enum_CannonType._throwStone
    Cannon_GuideShow(true)
  elseif UI_VT.Type_ThrowFire == isVehicleType then
    flameProgress:SetProgressRate(nowCoolTime)
    _current_cannonType = _enum_CannonType._throwFire
    Cannon_GuideShow(true)
  elseif UI_VT.Type_Ballista == isVehicleType then
    ballistaProgresss:SetProgressRate(nowCoolTime)
    _current_cannonType = _enum_CannonType._ballista
    Cannon_GuideShow(true)
  elseif UI_VT.Type_Train == isVehicleType then
    _current_cannonType = _enum_CannonType._train
    if 0 == seatPosition then
      Panel_Cannon:SetShow(false, false)
    elseif 1 == seatPosition then
      Panel_Cannon:SetShow(true, true)
    end
    Cannon_GuideShow(true)
  else
    _current_cannonType = _enum_CannonType._default
    return
  end
end
function FromClient_Cannon_Hide()
  if not Panel_Cannon:GetShow() then
    return
  end
  if true == skillCommandAlreadyShow then
    Panel_SkillCommand:SetShow(true)
    skillCommandAlreadyShow = false
  end
  Cannon_GuideShow(false)
  Panel_Cannon:SetShow(false, false)
  FGlobal_CannonGauge_Close()
  Panel_Cannon_Value_IsCannon = false
end
function FromClient_UpdateCannonBallCount(count, VehicleTpye)
  if UI_VT.Type_SailingBoat == VehicleTpye or UI_VT.Type_PersonalBattleShip == VehicleTpye or UI_VT.Type_PersonTradeShip == VehicleTpye or UI_VT.Type_CashPersonalBattleShip == VehicleTpye or UI_VT.Type_CashPersonalTradeShip == VehicleTpye then
    return
  end
  local shootCountValue = Int64toInt32(count)
  shootCount:SetShow(true)
  shootCount:SetText(shootCountValue)
  shootCount:SetPosY(180)
end
Cannon_Initialize()
registerEvent("EventSelfPlayerRideOn", "FromClient_Cannon_Show")
registerEvent("EventSelfPlayerRideOff", "FromClient_Cannon_Hide")
registerEvent("FromClient_RideVehicleMpUpdate", "FromClient_Cannon_ProgressUpdate")
registerEvent("FromClient_UpdateCannonBallCount", "FromClient_UpdateCannonBallCount")
