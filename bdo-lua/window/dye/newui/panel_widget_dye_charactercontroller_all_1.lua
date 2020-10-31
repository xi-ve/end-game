function PaGlobal_Dye_CharacterController:initialize()
  if true == PaGlobal_Dye_CharacterController._initialize then
    return
  end
  self._isConsole = _ContentsGroup_UsePadSnapping
  self._ui_pc.chk_SeePlayer = UI.getChildControl(Panel_Widget_CharacterController_All, "CheckButton_EyeSee")
  self._ui_pc.chk_ShowUI = UI.getChildControl(Panel_Widget_CharacterController_All, "CheckButton_ShowUI")
  self._ui_pc.chk_Weather = UI.getChildControl(Panel_Widget_CharacterController_All, "CheckButton_Weather")
  self._ui_pc.btn_Pose = UI.getChildControl(Panel_Widget_CharacterController_All, "Button_pose")
  for i = 1, self._weatherCount do
    self._btn_Weather[i] = UI.getChildControl(Panel_Widget_CharacterController_All, "Button_pose" .. tostring(i))
  end
  self._ui_pc.btn_Pallet = UI.getChildControl(Panel_Widget_CharacterController_All, "Button_Pallet_PCUI")
  self._ui_pc.btn_Inventory = UI.getChildControl(Panel_Widget_CharacterController_All, "Button_Inventory_PCUI")
  self._ui_pc.btn_Exit = UI.getChildControl(Panel_Widget_CharacterController_All, "Button_Exit_PCUI")
  self._ui_console.stc_KeyGuideBG = UI.getChildControl(Panel_Widget_CharacterController_All, "Static_KeyGuideBg_ConsoleUI")
  self._ui_console.txt_KeyGuideLSClick = UI.getChildControl(self._ui_console.stc_KeyGuideBG, "StaticText_LSClick_ConsoleUI")
  self._ui_console.txt_KeyGuideB = UI.getChildControl(self._ui_console.stc_KeyGuideBG, "StaticText_B_ConsoleUI")
  PaGlobal_Dye_CharacterController:validate()
  PaGlobal_Dye_CharacterController:switchPlatform()
  PaGlobal_Dye_CharacterController:registEventHandler()
  PaGlobal_Dye_CharacterController._initialize = true
end
function PaGlobal_Dye_CharacterController:switchPlatform()
  for key, control in pairs(self._ui_pc) do
    control:SetShow(not self._isConsole)
  end
  for key, control in pairs(self._ui_console) do
    control:SetShow(self._isConsole)
  end
end
function PaGlobal_Dye_CharacterController:onScreenResize()
  if nil == Panel_Widget_CharacterController_All then
    return
  end
  Panel_Widget_CharacterController_All:SetSize(getScreenSizeX(), getScreenSizeY())
  Panel_Widget_CharacterController_All:ComputePosAllChild()
end
function PaGlobal_Dye_CharacterController:registEventHandler()
  if nil == Panel_Widget_CharacterController_All then
    return
  end
  if false == self._isConsole then
    Panel_Widget_CharacterController_All:addInputEvent("Mouse_LDown", "InputMDown_Dye_SetCharacterRotate_Start(true)")
    Panel_Widget_CharacterController_All:addInputEvent("Mouse_LUp", "InputMUp_Dye_SetCharacterRotate_End(true)")
    Panel_Widget_CharacterController_All:addInputEvent("Mouse_Out", "InputMUp_Dye_SetCharacterRotate_End()")
    Panel_Widget_CharacterController_All:addInputEvent("Mouse_RDown", "InputMDown_Dye_SetCharacterRotate_Start(false)")
    Panel_Widget_CharacterController_All:addInputEvent("Mouse_RUp", "InputMUp_Dye_SetCharacterRotate_End(false)")
    Panel_Widget_CharacterController_All:addInputEvent("Mouse_UpScroll", "InputScroll_Dye_SetCharacterZoom(true)")
    Panel_Widget_CharacterController_All:addInputEvent("Mouse_DownScroll", "InputScroll_Dye_SetCharacterZoom(false)")
    self._ui_pc.btn_Pose:addInputEvent("Mouse_LUp", "InputMLUp_Dye_RandomPose()")
    self._ui_pc.btn_Pose:addInputEvent("Mouse_On", "InputMOver_Dye_SimpleTooltips( true, 0 )")
    self._ui_pc.btn_Pose:addInputEvent("Mouse_Out", "InputMOver_Dye_SimpleTooltips( false, 0 )")
    self._ui_pc.chk_SeePlayer:addInputEvent("Mouse_LUp", "InputMLUp_Dye_SetCharacterViewCamera()")
    self._ui_pc.chk_SeePlayer:addInputEvent("Mouse_On", "InputMOver_Dye_SimpleTooltips( true, 1 )")
    self._ui_pc.chk_SeePlayer:addInputEvent("Mouse_Out", "InputMOver_Dye_SimpleTooltips( false, 1 )")
    self._ui_pc.chk_ShowUI:addInputEvent("Mouse_LUp", "InputMLUp_Dye_SetShowUI()")
    self._ui_pc.chk_ShowUI:addInputEvent("Mouse_On", "InputMOver_Dye_SimpleTooltips( true, 2 )")
    self._ui_pc.chk_ShowUI:addInputEvent("Mouse_Out", "InputMOver_Dye_SimpleTooltips( false, 2 )")
    self._ui_pc.chk_Weather:addInputEvent("Mouse_LUp", "InputMLUp_Dye_WeatherBtnToggle()")
    self._ui_pc.chk_Weather:addInputEvent("Mouse_On", "InputMOver_Dye_SimpleTooltips( true, 3 )")
    self._ui_pc.chk_Weather:addInputEvent("Mouse_Out", "InputMOver_Dye_SimpleTooltips( false, 3 )")
    for i = 1, self._weatherCount do
      self._btn_Weather[i]:addInputEvent("Mouse_LUp", "InputMLUp_Dye_WeatherSetting(" .. i .. ")")
    end
    self._ui_pc.btn_Exit:addInputEvent("Mouse_LUp", "PaGlobal_Dye_All_Close()")
    self._ui_pc.btn_Pallet:addInputEvent("Mouse_LUp", "PaGlobal_Palette_All_Open()")
    self._ui_pc.btn_Inventory:addInputEvent("Mouse_LUp", "InventoryWindow_Show()")
  end
end
function PaGlobal_Dye_CharacterController:prepareOpen()
  if nil == Panel_Widget_CharacterController_All then
    return
  end
  self:onScreenResize()
  FGlobal_BuffTooltipOff()
  Panel_Widget_CharacterController_All:RegisterUpdateFunc("PaGlobal_Dye_CharacterRotate_PerFrameUpdate")
  PaGlobal_Dye_CharacterController:open()
end
function PaGlobal_Dye_CharacterController:open()
  if nil == Panel_Widget_CharacterController_All then
    return
  end
  Panel_Widget_CharacterController_All:SetShow(true)
end
function PaGlobal_Dye_CharacterController:prepareClose()
  if nil == Panel_Widget_CharacterController_All then
    return
  end
  self._ui_pc.chk_Weather:SetCheck(false)
  for i = 1, self._weatherCount do
    self._btn_Weather[i]:SetShow(false)
  end
  self._ui_pc.chk_SeePlayer:SetCheck(false)
  self._ui_pc.chk_ShowUI:SetCheck(false)
  InputMLUp_Dye_SetCharacterViewCamera()
  self._isPaletteShow = false
  Panel_Widget_CharacterController_All:ClearUpdateLuaFunc()
  PaGlobal_Dye_CharacterController:close()
end
function PaGlobal_Dye_CharacterController:close()
  if nil == Panel_Widget_CharacterController_All then
    return
  end
  Panel_Widget_CharacterController_All:SetShow(false)
end
function PaGlobal_Dye_CharacterController:validate()
  if nil == Panel_Widget_CharacterController_All then
    return
  end
  self._ui_pc.chk_SeePlayer:isValidate()
  self._ui_pc.chk_ShowUI:isValidate()
  self._ui_pc.chk_Weather:isValidate()
  self._ui_pc.btn_Pose:isValidate()
  for i = 1, self._weatherCount do
    self._btn_Weather[i]:isValidate()
  end
  self._ui_pc.btn_Pallet:isValidate()
  self._ui_pc.btn_Inventory:isValidate()
  self._ui_pc.btn_Exit:isValidate()
  self._ui_console.stc_KeyGuideBG:isValidate()
  self._ui_console.txt_KeyGuideLSClick:isValidate()
  self._ui_console.txt_KeyGuideB:isValidate()
end
