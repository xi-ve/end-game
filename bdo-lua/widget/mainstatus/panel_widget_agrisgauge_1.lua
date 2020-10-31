function PaGlobal_AgrisGauge:initialize()
  if true == PaGlobal_AgrisGauge._initialize then
    return
  end
  self._ui.stc_MainBG = UI.getChildControl(Panel_Widget_AgrisGauge, "Static_GaugeBg")
  self._ui.progress2_Fever = UI.getChildControl(self._ui.stc_MainBG, "Progress2_Drop")
  self._ui.txt_Fever = UI.getChildControl(self._ui.stc_MainBG, "StaticText_GaugeValue")
  self._ui.btn_Close = UI.getChildControl(Panel_Widget_AgrisGauge, "Button_Close")
  if true == _ContentsGroup_FeverBuff then
    self._curAgrisPointAble = questList_isClearQuest(834, 5)
  end
  PaGlobal_AgrisGauge:registEventHandler()
  PaGlobal_AgrisGauge:validate()
  PaGlobal_AgrisGauge._initialize = true
end
function PaGlobal_AgrisGauge:registEventHandler()
  if nil == Panel_Widget_AgrisGauge then
    return
  end
  registerEvent("FromClient_updateFeverPoint", "FromClient_AgrisGauge_UpdatePoint")
  self._ui.btn_Close:addInputEvent("Mouse_LUp", "InputMLUp_AgrisGauge_Clsoe()")
end
function PaGlobal_AgrisGauge:prepareOpen()
  if nil == Panel_Widget_AgrisGauge then
    return
  end
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  local player = selfPlayer:get()
  local maxFeverPoint = player:getMaxFeverPoint()
  if 0 == maxFeverPoint then
    return
  end
  PaGlobal_AgrisGauge:updatePos()
  PaGlobal_AgrisGauge:update()
  PaGlobal_AgrisGauge:open()
end
function PaGlobal_AgrisGauge:open()
  if nil == Panel_Widget_AgrisGauge then
    return
  end
  Panel_Widget_AgrisGauge:SetShow(true)
end
function PaGlobal_AgrisGauge:prepareClose()
  if nil == Panel_Widget_AgrisGauge then
    return
  end
  PaGlobal_AgrisGauge:close()
end
function PaGlobal_AgrisGauge:close()
  if nil == Panel_Widget_AgrisGauge then
    return
  end
  Panel_Widget_AgrisGauge:SetShow(false)
end
function PaGlobal_AgrisGauge:updatePos()
  local posX = Panel_PersonalIcon_Left:GetPosX() + FGlobal_PersonalIcon_GetFeverBuffIconPosX()
  local posY = Panel_PersonalIcon_Left:GetPosY() + Panel_PersonalIcon_Left:GetSizeY()
  Panel_Widget_AgrisGauge:SetPosXY(posX, posY)
end
function PaGlobal_AgrisGauge:update()
  if nil == Panel_Widget_AgrisGauge then
    return
  end
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    self:prepareClose()
    return
  end
  local player = selfPlayer:get()
  local feverPoint = player:getFeverPoint()
  local maxFeverPoint = player:getMaxFeverPoint()
  local feverPercent = 0
  if 0 ~= maxFeverPoint then
    feverPercent = 100 * feverPoint / maxFeverPoint
  end
  self._ui.progress2_Fever:SetProgressRate(feverPercent)
  self._ui.txt_Fever:SetText(feverPoint .. "/" .. maxFeverPoint)
end
function PaGlobal_AgrisGauge:validate()
  if nil == Panel_Widget_AgrisGauge then
    return
  end
  self._ui.stc_MainBG:isValidate()
  self._ui.progress2_Fever:isValidate()
  self._ui.txt_Fever:isValidate()
  self._ui.btn_Close:isValidate()
end
