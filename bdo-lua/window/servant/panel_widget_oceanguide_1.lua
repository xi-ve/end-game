function PaGlobal_OceanGuide:initialize()
  if true == PaGlobal_OceanGuide._initialize then
    return
  end
  local current_Ui = self._oceanCurrent._ui
  current_Ui.stc_BG = UI.getChildControl(Panel_Widget_OceanCurrent, "Static_OceanCurrent_BG")
  current_Ui.stc_Ring = UI.getChildControl(Panel_Widget_OceanCurrent, "Static_Ring1")
  current_Ui.txt_flow = UI.getChildControl(current_Ui.stc_Ring, "StaticText_Flow_1")
  current_Ui.stc_Sequence = UI.getChildControl(Panel_Widget_OceanCurrent, "Static_Sequence")
  current_Ui.stc_Sequence_All = UI.getChildControl(Panel_Widget_OceanCurrent, "Static_Sequence_AllDirection")
  local wind_Ui = self._oceanWind._ui
  wind_Ui.stc_BG = UI.getChildControl(Panel_Widget_OceanWind, "Static_SeaWind_BG")
  wind_Ui.stc_Ring = UI.getChildControl(Panel_Widget_OceanWind, "Static_Ring1")
  wind_Ui.txt_flow = UI.getChildControl(wind_Ui.stc_Ring, "StaticText_Flow_1")
  wind_Ui.stc_Sequence = UI.getChildControl(Panel_Widget_OceanWind, "Static_Sequence")
  PaGlobal_OceanGuide:registEventHandler()
  PaGlobal_OceanGuide:validate()
  if true == ToClient_isConsole() and nil ~= Panel_HorseMp then
    local newSpan = Panel_HorseMp:GetSpanSize().y - 10
    Panel_Widget_OceanCurrent:SetVerticalMiddle()
    Panel_Widget_OceanCurrent:SetSpanSize(Panel_Widget_OceanCurrent:GetSpanSize().x, newSpan)
    Panel_Widget_OceanCurrent:ComputePos()
    Panel_Widget_OceanWind:SetVerticalMiddle()
    Panel_Widget_OceanWind:SetSpanSize(Panel_Widget_OceanWind:GetSpanSize().x, newSpan)
    Panel_Widget_OceanWind:ComputePos()
  end
  FromClient_OceanGuide_PlayerRideOn()
end
function PaGlobal_OceanGuide:registEventHandler()
  if nil == Panel_Widget_OceanCurrent and nil == Panel_Widget_OceanWind then
    return
  end
  registerEvent("FromClient_UpdateOceanCurrent", "FromClient_OceanGuide_UpdateOceanCurrent")
  registerEvent("FromClient_UpdateWindDirection", "FromClient_OceanGuide_UpdateWindDirection")
  registerEvent("EventSelfPlayerRideOn", "FromClient_OceanGuide_PlayerRideOn")
  registerEvent("EventSelfPlayerRideOff", "FromClient_OceanGuide_PlayerRideOff")
  registerEvent("EventSelfPlayerCarrierChanged", "FromClient_OceanGuide_CarriageChange")
  registerEvent("onScreenResize", "FromClient_OceanGuide_PlayerRideOn")
  Panel_Widget_OceanWind:RegisterUpdateFunc("UpdateFunc_OceanGuide_ArrowbyPlayer")
end
function PaGlobal_OceanGuide:prepareOpen()
  if nil == Panel_Widget_OceanCurrent and nil == Panel_Widget_OceanWind then
    return
  end
  PaGlobal_OceanGuide:open()
end
function PaGlobal_OceanGuide:open()
  if nil == Panel_Widget_OceanCurrent and nil == Panel_Widget_OceanWind then
    return
  end
  Panel_Widget_OceanCurrent:SetShow(true)
  Panel_Widget_OceanWind:SetShow(true)
end
function PaGlobal_OceanGuide:prepareClose()
  if nil == Panel_Widget_OceanCurrent and nil == Panel_Widget_OceanWind then
    return
  end
  PaGlobal_OceanGuide:close()
end
function PaGlobal_OceanGuide:close()
  if nil == Panel_Widget_OceanCurrent and nil == Panel_Widget_OceanWind then
    return
  end
  Panel_Widget_OceanCurrent:SetShow(false)
  Panel_Widget_OceanWind:SetShow(false)
end
function PaGlobal_OceanGuide:validate()
  if nil == Panel_Widget_OceanCurrent and nil == Panel_Widget_OceanWind then
    return
  end
  self._oceanCurrent._ui.stc_BG:isValidate()
  self._oceanCurrent._ui.stc_Ring:isValidate()
  self._oceanCurrent._ui.txt_flow:isValidate()
  self._oceanCurrent._ui.stc_Sequence:isValidate()
  self._oceanCurrent._ui.stc_Sequence_All:isValidate()
  self._oceanWind._ui.stc_BG:isValidate()
  self._oceanWind._ui.stc_Ring:isValidate()
  self._oceanWind._ui.txt_flow:isValidate()
  self._oceanWind._ui.stc_Sequence:isValidate()
end
