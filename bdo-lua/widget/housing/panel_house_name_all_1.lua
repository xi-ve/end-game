function PaGlobal_HouseName_All:initialize()
  if true == PaGlobal_HouseName_All._initialize then
    return
  end
  self._isConsole = _ContentsGroup_UsePadSnapping
  self._ui._txt_houseName = UI.getChildControl(Panel_House_Name_All, "StaticText_HouseName")
  self._ui._stc_deco_left = UI.getChildControl(self._ui._txt_houseName, "Static_Deco_L")
  self._ui._stc_deco_right = UI.getChildControl(self._ui._txt_houseName, "Static_Deco_R")
  self._ui._txt_houseAddress = UI.getChildControl(Panel_House_Name_All, "StaticText_Add")
  self._ui._txt_houseScore = UI.getChildControl(Panel_House_Name_All, "StaticText_Score")
  self._ui._pc._stc_btnBg = UI.getChildControl(Panel_House_Name_All, "Static_Btn_BG_PC")
  self._ui._btn_installMode = UI.getChildControl(self._ui._pc._stc_btnBg, "Button_Install")
  self._ui._btn_installGift = UI.getChildControl(self._ui._pc._stc_btnBg, "Button_InstallGift")
  self._ui._btn_showRank = UI.getChildControl(self._ui._pc._stc_btnBg, "Button_ShowRank")
  self._ui._chk_setUnderwear = UI.getChildControl(self._ui._pc._stc_btnBg, "CheckButton_SetUnderwear")
  self._ui._chk_hidePet = UI.getChildControl(self._ui._pc._stc_btnBg, "CheckButton_ToggleHidePet")
  self._ui._chk_hideMaid = UI.getChildControl(self._ui._pc._stc_btnBg, "CheckButton_ToggleHideMaid")
  self._ui._txt_noticeLighting = UI.getChildControl(Panel_House_Name_All, "StaticText_NoticeLighting")
  self._ui._console._stc_consoleKey = UI.getChildControl(Panel_House_Name_All, "Static_ConsoleKeyGuide")
  self._ui._console._stc_editMode = UI.getChildControl(self._ui._console._stc_consoleKey, "Static_Intallation")
  self._ui._console._stc_underWear = UI.getChildControl(self._ui._console._stc_consoleKey, "Static_Underwear")
  self._ui._console._stc_inventory = UI.getChildControl(self._ui._console._stc_consoleKey, "Static_Inventory")
  self._ui._console._stc_petMaid = UI.getChildControl(self._ui._console._stc_consoleKey, "Static_PetMaid")
  local isPc = false == self._isConsole
  for k, value in pairs(self._ui._pc) do
    value:SetShow(isPc)
  end
  for k, value in pairs(self._ui._console) do
    value:SetShow(self._isConsole)
  end
  Panel_House_Name_All:RegisterShowEventFunc(true, "PaGlobal_HouseName_All_ShowAni()")
  Panel_House_Name_All:RegisterShowEventFunc(false, "PaGlobal_HouseName_All_HideAni()")
  self._defaultNameSizeX = self._ui._txt_houseName:GetSizeX()
  PaGlobal_HouseName_All:registEventHandler()
  PaGlobal_HouseName_All:validate()
  PaGlobal_HouseName_All._initialize = true
end
function PaGlobal_HouseName_All:registEventHandler()
  if nil == Panel_House_Name_All then
    return
  end
  self._ui._btn_installMode:addInputEvent("Mouse_LUp", "HandleEventLUp_HouseName_All_InstallationMode()")
  self._ui._btn_installMode:addInputEvent("Mouse_On", "HandleEventOn_HouseName_All_ButtonTooltip(" .. self._eButtonType.installMode .. ")")
  self._ui._btn_installMode:addInputEvent("Mouse_Out", "TooltipSimple_Hide()")
  self._ui._btn_installGift:addInputEvent("Mouse_LUp", "HandleEventLUp_HouseName_All_InstallationMode()")
  self._ui._btn_installGift:addInputEvent("Mouse_On", "HandleEventOn_HouseName_All_ButtonTooltip(" .. self._eButtonType.installGift .. ")")
  self._ui._btn_installGift:addInputEvent("Mouse_Out", "TooltipSimple_Hide()")
  self._ui._btn_showRank:addInputEvent("Mouse_LUp", "HandleEventLUp_HouseName_All_ShowRank()")
  self._ui._btn_showRank:addInputEvent("Mouse_On", "HandleEventOn_HouseName_All_ButtonTooltip(" .. self._eButtonType.showRank .. ")")
  self._ui._btn_showRank:addInputEvent("Mouse_Out", "TooltipSimple_Hide()")
  self._ui._chk_setUnderwear:addInputEvent("Mouse_LUp", "HandleEventLUp_HouseName_All_SetUnderwearToggle()")
  self._ui._chk_setUnderwear:addInputEvent("Mouse_On", "HandleEventOn_HouseName_All_ButtonTooltip(" .. self._eButtonType.underwear .. ")")
  self._ui._chk_setUnderwear:addInputEvent("Mouse_Out", "TooltipSimple_Hide()")
  self._ui._chk_hidePet:addInputEvent("Mouse_LUp", "HandleEventLUp_HouseName_All_SetPetToggle()")
  self._ui._chk_hidePet:addInputEvent("Mouse_On", "HandleEventOn_HouseName_All_ButtonTooltip(" .. self._eButtonType.pet .. ")")
  self._ui._chk_hidePet:addInputEvent("Mouse_Out", "TooltipSimple_Hide()")
  self._ui._chk_hideMaid:addInputEvent("Mouse_LUp", "HandleEventLUp_HouseName_All_SetMaidToggle()")
  self._ui._chk_hideMaid:addInputEvent("Mouse_On", "HandleEventOn_HouseName_All_ButtonTooltip(" .. self._eButtonType.maid .. ")")
  self._ui._chk_hideMaid:addInputEvent("Mouse_Out", "TooltipSimple_Hide()")
  registerEvent("FromClient_RenderModeChangeState", "FromClient_HouseName_All_RenderModeChangeState")
  registerEvent("EventHousingShowVisitHouse", "FromClient_HouseName_All_EventHousingShowVisitHouse")
  registerEvent("FromClient_ChangeUnderwearModeInHouse", "FromClient_HouseName_All_ChangeUnderwearModeInHouse")
  registerEvent("onScreenResize", "FromClient_HouseName_All_ScreenResize")
end
function PaGlobal_HouseName_All:prepareOpen(isAni)
  if nil == Panel_House_Name_All then
    return
  end
  self._updateTime = 0
  self._isAlertHouseLighting = false
  self._ui._txt_noticeLighting:SetShow(false)
  Panel_House_Name_All:RegisterUpdateFunc("FromClient_HouseName_All_UpdatePerFrame")
  if true == self._isConsole then
    PaGlobal_ConsoleQuickMenu:widgetClose()
  end
  PaGlobal_HouseName_All:open(isAni)
end
function PaGlobal_HouseName_All:open(isAni)
  if nil == Panel_House_Name_All then
    return
  end
  Panel_House_Name_All:SetShow(true, isAni)
end
function PaGlobal_HouseName_All:prepareClose(isAni)
  if nil == Panel_House_Name_All then
    return
  end
  Panel_House_Name_All:ClearUpdateLuaFunc()
  if true == self._isConsole then
    PaGlobal_ConsoleQuickMenu:widgetOpen()
  end
  PaGlobal_HouseName_All:close(isAni)
end
function PaGlobal_HouseName_All:close(isAni)
  if nil == Panel_House_Name_All then
    return
  end
  Panel_House_Name_All:SetShow(false, isAni)
end
function PaGlobal_HouseName_All:update()
  if nil == Panel_House_Name_All then
    return
  end
end
function PaGlobal_HouseName_All:validate()
  if nil == Panel_House_Name_All then
    return
  end
end
function PaGlobal_HouseName_All:resetAlertHouseLighting()
  self._updateTime = 0
  self._isAlertHouseLighting = false
end
function PaGlobal_HouseName_All:updatePerFrame(deltaTime)
  self._updateTime = self._updateTime + deltaTime
  if false == self._isAlertHouseLighting and 5 == math.ceil(self._updateTime) then
    local houseWrapper = housing_getHouseholdActor_CurrentPosition()
    local isHaveLightInstallation = houseWrapper:isHaveLightInstallation()
    if true == isHaveLightInstallation then
      self._ui._txt_noticeLighting:SetShow(false)
    else
      self._ui._txt_noticeLighting:SetShow(true)
    end
    self._isAlertHouseLighting = true
  end
  self:updateCheckWidget(deltaTime)
end
function PaGlobal_HouseName_All:updateCheckWidget(deltaTime)
  if false == self._isConsole then
    return
  end
  self._updateWidgetTime = self._updateWidgetTime + deltaTime
  if 1 == math.ceil(self._updateWidgetTime) then
    PaGlobal_ConsoleQuickMenu:widgetClose(false)
    self._updateWidgetTime = 0
  end
end
