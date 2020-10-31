function PaGlobal_AgrisGaugeTooltip:initialize()
  if true == self._initialize then
    return
  end
  self._ui.progressBG = UI.getChildControl(Panel_Widget_AgrisGaugeTooltip, "Static_DropProgressBg")
  self._ui.progressBar = UI.getChildControl(Panel_Widget_AgrisGaugeTooltip, "Progress2_Drop")
  self._ui.txt_feverPoint = UI.getChildControl(Panel_Widget_AgrisGaugeTooltip, "StaticText_GaugeValue")
  self._ui.txt_tooltipDesc = UI.getChildControl(Panel_Widget_AgrisGaugeTooltip, "StaticText_TooltipDesc")
  self:registEventHandler()
  self:validate()
  self._initialize = true
end
function PaGlobal_AgrisGaugeTooltip:registEventHandler()
  if nil == Panel_Widget_AgrisGaugeTooltip then
    return
  end
end
function PaGlobal_AgrisGaugeTooltip:prepareOpen(posX, posY)
  if nil == Panel_Widget_AgrisGaugeTooltip then
    return
  end
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  local player = selfPlayer:get()
  if nil == player then
    return
  end
  local feverPoint = player:getFeverPoint()
  local maxFeverPoint = player:getMaxFeverPoint()
  local addFeverPoint = player:getAddFeverPoint()
  local feverDropRate = player:getUseFeverSkillDropDesc()
  feverDropRate = feverDropRate / 10000
  self._ui.txt_tooltipDesc:SetTextMode(__eTextMode_AutoWrap)
  self._ui.txt_tooltipDesc:SetText(PAGetStringParam3(Defines.StringSheet_GAME, "LUA_AGRISSPOINT_ICON_TOOLTIP", "addFeverPoint", addFeverPoint, "maxFeverPoint", maxFeverPoint, "feverDropRate", feverDropRate))
  Panel_Widget_AgrisGaugeTooltip:SetPosXY(posX, posY)
  local sizeX = self._ui.txt_tooltipDesc:GetTextSizeX() + 40
  local sizeY = self._ui.txt_tooltipDesc:GetTextSizeY() + 10
  if 0 ~= maxFeverPoint then
    local feverRate = 100 * feverPoint / maxFeverPoint
    self._ui.txt_feverPoint:SetShow(true)
    self._ui.progressBG:SetShow(true)
    self._ui.txt_feverPoint:SetText(feverPoint .. "/" .. maxFeverPoint)
    self._ui.progressBar:SetProgressRate(feverRate)
    sizeX = sizeX + self._ui.progressBG:GetSizeX()
    self._ui.txt_tooltipDesc:SetPosX(150)
  else
    self._ui.txt_feverPoint:SetShow(false)
    self._ui.progressBG:SetShow(false)
    self._ui.txt_tooltipDesc:SetPosX(20)
  end
  Panel_Widget_AgrisGaugeTooltip:SetSize(sizeX, sizeY)
  PaGlobal_AgrisGaugeTooltip:open()
end
function PaGlobal_AgrisGaugeTooltip:open()
  if nil == Panel_Widget_AgrisGaugeTooltip then
    return
  end
  Panel_Widget_AgrisGaugeTooltip:SetShow(true)
end
function PaGlobal_AgrisGaugeTooltip:prepareClose()
  if nil == Panel_Widget_AgrisGaugeTooltip then
    return
  end
  PaGlobal_AgrisGaugeTooltip:close()
end
function PaGlobal_AgrisGaugeTooltip:close()
  if nil == Panel_Widget_AgrisGaugeTooltip then
    return
  end
  Panel_Widget_AgrisGaugeTooltip:SetShow(false)
end
function PaGlobal_AgrisGaugeTooltip:update()
  if nil == Panel_Widget_AgrisGaugeTooltip then
    return
  end
end
function PaGlobal_AgrisGaugeTooltip:validate()
  if nil == Panel_Widget_AgrisGaugeTooltip then
    return
  end
end
