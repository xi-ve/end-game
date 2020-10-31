function PaGlobal_ShipControl_Console:initialize()
  if true == self._initialize then
    return
  end
  self._ui.stc_btnBG = UI.getChildControl(Panel_Window_ShipControl, "Static_skillInfoBg")
  self._ui.btn_function1 = UI.getChildControl(self._ui.stc_btnBG, "Button_Function_1")
  self._ui.btn_function2 = UI.getChildControl(self._ui.stc_btnBG, "Button_Function_2")
  self._ui.txt_desc = UI.getChildControl(Panel_Window_ShipControl, "StaticText_Desc")
  self._ui.stc_keyGuideBG = UI.getChildControl(Panel_Window_ShipControl, "Static_ConsoleKeyGuide")
  self._ui.txt_keyGuideA = UI.getChildControl(self._ui.stc_keyGuideBG, "StaticText_Select")
  self._ui.txt_keyGuideB = UI.getChildControl(self._ui.stc_keyGuideBG, "StaticText_Close")
  self:registEventHandler()
  self:validate()
  self._ui.txt_desc:SetTextMode(__eTextMode_AutoWrap)
  local keyGuides = {
    self._ui.txt_keyGuideA,
    self._ui.txt_keyGuideB
  }
  PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyGuides, self._ui.stc_keyGuideBG, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHT)
  self._initialize = true
end
function PaGlobal_ShipControl_Console:registEventHandler()
  if nil == Panel_Window_ShipControl then
    return
  end
  self._ui.btn_function1:addInputEvent("Mouse_LUp", "HandleEventLUp_ShipControl_Console_Function_1()")
  self._ui.btn_function1:addInputEvent("Mouse_On", "HandleEventLUp_ShipControl_Console_SetDescription(1)")
  self._ui.btn_function2:addInputEvent("Mouse_LUp", "HandleEventLUp_ShipControl_Console_Function_2()")
  self._ui.btn_function2:addInputEvent("Mouse_On", "HandleEventLUp_ShipControl_Console_SetDescription(2)")
  registerEvent("onScreenResize", "PaGlobal_ShipControl_Console_Resize")
end
function PaGlobal_ShipControl_Console:prepareOpen()
  if nil == Panel_Window_ShipControl then
    return
  end
  local temporaryWrapper = getTemporaryInformationWrapper()
  if nil == temporaryWrapper then
    return
  end
  local seaVehicleWrapper = temporaryWrapper:getUnsealVehicle(CppEnums.ServantType.Type_Ship)
  if nil == seaVehicleWrapper or __eVehicleType_GalleyShip == seaVehicleWrapper:getVehicleType() then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_STABLELIST_NOT_UNSEAL_SERVANT"))
    return
  end
  self:open()
end
function PaGlobal_ShipControl_Console:open()
  if nil == Panel_Window_ShipControl then
    return
  end
  Panel_Window_ShipControl:SetShow(true)
end
function PaGlobal_ShipControl_Console:prepareClose()
  if nil == Panel_Window_ShipControl then
    return
  end
  self._isNaviOn = false
  self:close()
end
function PaGlobal_ShipControl_Console:close()
  if nil == Panel_Window_ShipControl then
    return
  end
  Panel_Window_ShipControl:SetShow(false)
end
function PaGlobal_ShipControl_Console:validate()
  if nil == Panel_Window_ShipControl then
    return
  end
  self._ui.stc_btnBG:isValidate()
  self._ui.btn_function1:isValidate()
  self._ui.btn_function2:isValidate()
  self._ui.txt_desc:isValidate()
  self._ui.stc_keyGuideBG:isValidate()
  self._ui.txt_keyGuideA:isValidate()
  self._ui.txt_keyGuideB:isValidate()
end
function PaGlobal_ShipControl_Console:resize()
  Panel_Window_ShipControl:ComputePos()
end
