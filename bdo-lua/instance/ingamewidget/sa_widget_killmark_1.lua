function PaGlobal_SA_Widget_KillMark:initialize()
  if true == self._initialize then
    return
  end
  self._ui.txt_killMessage = UI.getChildControl(Panel_SA_Widget_KillMark, "StaticText_UserName")
  self._ui.stc_effectSlot = UI.getChildControl(Panel_SA_Widget_KillMark, "Static_EffectSlot")
  self:registEventHandler()
  self:validate()
  self._initialize = true
end
function PaGlobal_SA_Widget_KillMark:registEventHandler()
  if nil == Panel_SA_Widget_KillMark then
    return
  end
  registerEvent("onScreenResize", "FromClient_SA_Widget_KillMark_ReSizePanel()")
end
function PaGlobal_SA_Widget_KillMark:prepareOpen(data)
  if nil == Panel_SA_Widget_KillMark then
    return
  end
  self._updateTime = 0
  local killMsg = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_BATTLEROYAL_KILLMSG_MAIN", "classType", tostring(data.loserName))
  self._ui.txt_killMessage:SetText(killMsg)
  self._ui.stc_effectSlot:EraseAllEffect()
  self._ui.stc_effectSlot:AddEffect("", false, 0, 0)
  Panel_SA_Widget_KillMark:RegisterUpdateFunc("FromClient_SA_Widget_KillMark_UpdatePerFrame")
  PaGlobal_SA_Widget_KillMark:open()
end
function PaGlobal_SA_Widget_KillMark:open()
  if nil == Panel_SA_Widget_KillMark then
    return
  end
  Panel_SA_Widget_KillMark:SetShow(true)
end
function PaGlobal_SA_Widget_KillMark:prepareClose()
  if nil == Panel_SA_Widget_KillMark then
    return
  end
  Panel_SA_Widget_KillMark:ClearUpdateLuaFunc()
  PaGlobal_SA_Widget_KillMark:close()
end
function PaGlobal_SA_Widget_KillMark:close()
  if nil == Panel_SA_Widget_KillMark then
    return
  end
  Panel_SA_Widget_KillMark:SetShow(false)
end
function PaGlobal_SA_Widget_KillMark:update()
  if nil == Panel_SA_Widget_KillMark then
    return
  end
end
function PaGlobal_SA_Widget_KillMark:validate()
  if nil == Panel_SA_Widget_KillMark then
    return
  end
  self._ui.txt_killMessage:isValidate()
  self._ui.stc_effectSlot:isValidate()
end
function PaGlobal_SA_Widget_KillMark:updatePerFrame(deltaTime)
  self._updateTime = self._updateTime + deltaTime
  if self._durationTime < self._updateTime then
    self._updateTime = 0
    PaGlobal_SA_Widget_KillMark:prepareClose()
  end
end
