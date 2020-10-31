local UI_color = Defines.Color
Panel_Stamina:SetShow(false, false)
local staticBar = UI.getChildControl(Panel_Stamina, "StaminaBar")
local _bar_FullGauge = UI.getChildControl(Panel_Stamina, "Static_FullGauge")
local _txt_StaminaMax = UI.getChildControl(Panel_Stamina, "StaticText_StaminaMax")
local _cannonDesc = UI.getChildControl(Panel_Stamina, "StaticText_CannonDesc")
local maxBarSize = staticBar:GetSizeX()
Panel_Stamina:RegisterShowEventFunc(false, "Panel_Stamina_HideAni()")
function Panel_Stamina_HideAni()
  local aniInfo = UIAni.AlphaAnimation(0, Panel_Stamina, 0, 0.2)
  aniInfo:SetHideAtEnd(true)
end
local SpUseType = {
  Once = 0,
  Continue = 1,
  Recover = 2,
  Stop = 3,
  Reset = 4,
  None = 5
}
function Stamina_Update()
  local selfPlayerWrapper = getSelfPlayer()
  if nil ~= selfPlayerWrapper then
    local stamina = selfPlayerWrapper:get():getStamina()
    if nil ~= stamina then
      local sp = stamina:getSp()
      local maxSp = stamina:getMaxSp()
      local useType = stamina:getUseType()
      if Panel_Cannon_Value_IsCannon == true then
        _cannonDesc:SetShow(true)
      else
        _cannonDesc:SetShow(false)
      end
      if sp == maxSp and useType == SpUseType.Recover then
        _bar_FullGauge:SetShow(true)
        _bar_FullGauge:EraseAllEffect()
        Panel_Stamina:SetShow(false, false)
        return
      end
      if true == UI.isFlushedUI() then
        Panel_Stamina:SetShow(false, false)
        return
      end
      local spRate = sp / maxSp
      local alpha = (1 - spRate) * 15
      local fullGauge = spRate * 100
      if 1 < alpha then
        alpha = 1
      end
      Panel_Stamina:SetAlphaChild(alpha)
      staticBar:SetProgressRate(fullGauge)
      _txt_StaminaMax:SetFontAlpha(alpha)
      _txt_StaminaMax:SetText(tostring(math.floor(spRate * 100)))
      Panel_Stamina:SetShow(true, false)
      local totalStamina = math.floor(spRate * 100)
    end
  end
end
function FromClient_Stamina_Init()
end
function PaGlobal_Stamina_ResetPosition()
  local scrX = getOriginScreenSizeX()
  local scrY = getOriginScreenSizeY()
  local relativePosX = ToClient_GetUiInfo(CppEnums.PAGameUIType.PAGameUIPanel_Stamina, 0, CppEnums.PanelSaveType.PanelSaveType_RelativePositionX)
  local relativePosY = ToClient_GetUiInfo(CppEnums.PAGameUIType.PAGameUIPanel_Stamina, 0, CppEnums.PanelSaveType.PanelSaveType_RelativePositionY)
  local initPosX = (scrX - Panel_Stamina:GetSizeX()) * 0.5
  local initPosY = scrY * 0.85
  if relativePosX == -1 and relativePosY == -1 then
    local haveServerPosotion = 0 < ToClient_GetUiInfo(CppEnums.PAGameUIType.PAGameUIPanel_Stamina, 0, CppEnums.PanelSaveType.PanelSaveType_IsSaved)
    if not haveServerPosotion then
      Panel_Stamina:SetPosX(initPosX)
      Panel_Stamina:SetPosY(initPosY)
    end
    changePositionBySever(Panel_Stamina, CppEnums.PAGameUIType.PAGameUIPanel_Stamina, true, true, false)
    FGlobal_InitPanelRelativePos(Panel_Stamina, initPosX, initPosY)
  elseif relativePosX == 0 and relativePosY == 0 then
    Panel_Stamina:SetPosX(initPosX)
    Panel_Stamina:SetPosY(initPosY)
  else
    Panel_Stamina:SetRelativePosX(relativePosX)
    Panel_Stamina:SetRelativePosY(relativePosY)
    Panel_Stamina:SetPosX(getOriginScreenSizeX() * relativePosX - Panel_Stamina:GetSizeX() * 0.5)
    Panel_Stamina:SetPosY(getOriginScreenSizeY() * relativePosY - Panel_Stamina:GetSizeY() * 0.5)
  end
  FGlobal_PanelRepostionbyScreenOut(Panel_Stamina)
end
registerEvent("FromClient_luaLoadComplete", "FromClient_Stamina_Init")
registerEvent("EventStaminaUpdate", "Stamina_Update()")
registerEvent("onScreenResize", "PaGlobal_Stamina_ResetPosition")
registerEvent("FromClient_ApplyUISettingPanelInfo", "PaGlobal_Stamina_ResetPosition")
Panel_Stamina:RegisterUpdateFunc("Stamina_Update")
