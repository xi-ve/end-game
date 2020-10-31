function PaGlobal_Ship_Control_All:initialize()
  if true == self._initialize then
    return
  end
  self._ui.stc_TitleArea = UI.getChildControl(Panel_Widget_Ship_Control, "Static_TitleArea")
  self._ui.btn_Close = UI.getChildControl(self._ui.stc_TitleArea, "Button_Close")
  self._ui.btn_ShipCall = UI.getChildControl(Panel_Widget_Ship_Control, "Button_ShipCall")
  self._ui.btn_ShipDrive = UI.getChildControl(Panel_Widget_Ship_Control, "Button_ShipDrive")
  self._ui.btn_GoDrive = UI.getChildControl(Panel_Widget_Ship_Control, "Button_GoDrive")
  self._ui.stc_KeyGuide = UI.getChildControl(Panel_Widget_Ship_Control, "Static_KeyGuide_ConsoleUI")
  self:setControl()
  self:registEventHandler()
  self:validate()
  self._initialize = true
end
function PaGlobal_Ship_Control_All:registEventHandler()
  if nil == Panel_Widget_Ship_Control then
    return
  end
  self._ui.btn_Close:addInputEvent("Mouse_LUp", "PaGlobalFunc_Ship_Control_All_Close()")
  self._ui.btn_ShipCall:addInputEvent("Mouse_LUp", "HandleEventLUp_Ship_Control_All_Recall()")
  self._ui.btn_ShipDrive:addInputEvent("Mouse_LUp", "HandleEventLUp_Ship_Control_All_Interaction()")
  self._ui.btn_GoDrive:addInputEvent("Mouse_LUp", "HandleEventLUp_Ship_Control_All_AutoRide()")
  registerEvent("onScreenResize", "PaGlobalFunc_Ship_Control_All_Resize")
end
function PaGlobal_Ship_Control_All:setControl()
  local isConsole = _ContentsGroup_UsePadSnapping
  self._ui.btn_Close:SetShow(not isConsole)
  self._ui.stc_KeyGuide:SetShow(isConsole)
  if true == isConsole then
    local keyGuides = {
      stc_KeyGuide_Y = UI.getChildControl(self._ui.stc_KeyGuide, "StaticText_Y_ConsoleUI"),
      stc_KeyGuide_X = UI.getChildControl(self._ui.stc_KeyGuide, "StaticText_X_ConsoleUI"),
      stc_KeyGuide_A = UI.getChildControl(self._ui.stc_KeyGuide, "StaticText_A_ConsoleUI"),
      stc_KeyGuide_B = UI.getChildControl(self._ui.stc_KeyGuide, "StaticText_B_ConsoleUI")
    }
    PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyGuides, self._ui.stc_KeyGuide, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHT)
  end
end
function PaGlobal_Ship_Control_All:prepareOpen()
  if nil == Panel_Widget_Ship_Control then
    return
  end
  self:open()
  self:resize()
end
function PaGlobal_Ship_Control_All:open()
  if nil == Panel_Widget_Ship_Control then
    return
  end
  Panel_Widget_Ship_Control:SetShow(true)
end
function PaGlobal_Ship_Control_All:prepareClose()
  if nil == Panel_Widget_Ship_Control then
    return
  end
  self:close()
end
function PaGlobal_Ship_Control_All:close()
  if nil == Panel_Widget_Ship_Control then
    return
  end
  Panel_Widget_Ship_Control:SetShow(false)
end
function PaGlobal_Ship_Control_All:validate()
  if nil == Panel_Widget_Ship_Control then
    return
  end
  self._ui.stc_TitleArea:isValidate()
  self._ui.btn_Close:isValidate()
  self._ui.btn_ShipCall:isValidate()
  self._ui.btn_ShipDrive:isValidate()
  self._ui.btn_GoDrive:isValidate()
  self._ui.stc_KeyGuide:isValidate()
end
function PaGlobal_Ship_Control_All:resize()
  local posX = PaGlobalFunc_ServantIcon_GetIconPosX(2)
  local posY = PaGlobalFunc_ServantIcon_GetIconPosY(2)
  local size = PaGlobalFunc_ServantIcon_GetIconSizeX(2)
  Panel_Widget_Ship_Control:SetPosXY(posX + size, posY + size)
end
