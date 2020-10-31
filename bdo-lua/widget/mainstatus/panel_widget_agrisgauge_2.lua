function InputMLUp_AgrisGauge_Clsoe()
  PaGlobal_AgrisGauge:prepareClose()
end
function FromClient_AgrisGauge_UpdatePoint(isFirstOpened)
  PaGlobal_AgrisGauge:update()
  local isOn = false
  local selfPlayer = getSelfPlayer()
  if nil ~= selfPlayer then
    local feverPoint = selfPlayer:get():getFeverPoint()
    isOn = 0 < feverPoint
  end
  local isUseFeverSkill = selfPlayer:get():getIsUseFeverSkill()
  FGlobal_PersonalIcon_FeverBuffOnIcon_SetShow(isOn)
  FGlobal_PersonalIcon_FeverBuffOnIcon_Toggle(isUseFeverSkill)
  if true == _ContentsGroup_FeverBuff and nil ~= selfPlayer then
    local maxFeverPoint = selfPlayer:get():getMaxFeverPoint()
    if 0 ~= maxFeverPoint and true == isFirstOpened then
      local msg = {
        main = PAGetString(Defines.StringSheet_GAME, "LUA_NAK_AGRIS_OPEN"),
        sub = ""
      }
      Proc_ShowMessage_Ack_For_RewardSelect(msg, 2.5, 125)
      PaGlobal_AgrisGauge._curAgrisPointAble = true
    end
  end
end
function PaGlobal_AgrisGauge_GetShow()
  return Panel_Widget_AgrisGauge:GetShow()
end
function PaGlobal_AgrisGauge_Toggle()
  if Panel_Widget_AgrisGauge:GetShow() then
    PaGlobal_AgrisGauge:prepareClose()
  else
    PaGlobal_AgrisGauge:prepareOpen()
  end
end
function PaGlobal_AgrisGauge_OnOffToggle()
  ToClient_FeverBuffOnOff()
end
