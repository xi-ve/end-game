function PaGlobal_SA_Widget_Respon_Time:initialize()
  if true == PaGlobal_SA_Widget_Respon_Time._initialize then
    return
  end
  self._ui.stc_responBG = UI.getChildControl(Panel_SA_Widget_Respon_Time, "Static_Respon_BG")
  self._ui.txt_info = UI.getChildControl(self._ui.stc_responBG, "StaticText_Info")
  self._ui.txt_time = UI.getChildControl(self._ui.stc_responBG, "StaticText_Time")
  self:registEventHandler()
  self:validate()
  self._initialize = true
  local remainTime = Int64toInt32(ToClient_BattleRoyaleRemainTime())
  if 0 < remainTime then
    PaGlobal_SA_Widget_Respon_Time_StartGame()
  end
end
function PaGlobal_SA_Widget_Respon_Time:registEventHandler()
  if nil == Panel_SA_Widget_Respon_Time then
    return
  end
  registerEvent("onScreenResize", "FromClient_SA_Widget_Respon_Time_ReSizePanel")
  registerEvent("FromClient_BattleRoyaleStateChanged", "FromClient_SA_Widget_Respon_Time_BattleRoyaleStateChanged")
  Panel_SA_Widget_Respon_Time:RegisterShowEventFunc(true, "PaGlobal_SA_Widget_Respon_Time_ShowAni()")
  Panel_SA_Widget_Respon_Time:RegisterShowEventFunc(false, "PaGlobal_SA_Widget_Respon_Time_HideAni()")
end
function PaGlobal_SA_Widget_Respon_Time:prepareOpen()
  if nil == Panel_SA_Widget_Respon_Time then
    return
  end
  PaGlobal_SA_Widget_Respon_Time:open()
end
function PaGlobal_SA_Widget_Respon_Time:open()
  if nil == Panel_SA_Widget_Respon_Time then
    return
  end
  Panel_SA_Widget_Respon_Time:SetShow(true)
end
function PaGlobal_SA_Widget_Respon_Time:prepareClose()
  if nil == Panel_SA_Widget_Respon_Time then
    return
  end
  Panel_SA_Widget_Respon_Time:ClearUpdateLuaFunc()
  PaGlobal_SA_Widget_Respon_Time:close()
end
function PaGlobal_SA_Widget_Respon_Time:close()
  if nil == Panel_SA_Widget_Respon_Time then
    return
  end
  Panel_SA_Widget_Respon_Time:SetShow(false)
end
function PaGlobal_SA_Widget_Respon_Time:update()
  if nil == Panel_SA_Widget_Respon_Time then
    return
  end
end
function PaGlobal_SA_Widget_Respon_Time:validate()
  if nil == Panel_SA_Widget_Respon_Time then
    return
  end
  self._ui.stc_responBG:isValidate()
  self._ui.txt_info:isValidate()
  self._ui.txt_time:isValidate()
end
