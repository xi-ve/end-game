function PaGlobal_PowerSave_All:initialize()
  if true == PaGlobal_PowerSave_All._initialize then
    return
  end
  self._ui.stc_center = UI.getChildControl(Panel_Window_PowerSave_All, "Static_Center")
  self._ui.stc_top = UI.getChildControl(Panel_Window_PowerSave_All, "Static_Top")
  self._ui.stc_bottom = UI.getChildControl(Panel_Window_PowerSave_All, "Static_Bottom")
  self._ui.stc_centerEffect = UI.getChildControl(Panel_Window_PowerSave_All, "Static_CenterEffect")
  self._ui.txt_desc = UI.getChildControl(Panel_Window_PowerSave_All, "StaticText_Desc")
  self._originMarkPosX = self._ui.stc_top:GetPosX()
  self._originTopMarkPosY = self._ui.stc_top:GetPosY()
  self._originBottomMarkPosY = self._ui.stc_bottom:GetPosY()
  self._renderMode = RenderModeWrapper.new(100, {
    Defines.RenderMode.eRenderMode_PowerSave
  }, false)
  self._renderMode:setClosefunctor(self._renderMode, PaGlobalFunc_PowerSave_All_Awake)
  self._ui.txt_desc:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_POWERSAVEMODE_DESC"))
  self:registEventHandler()
  self:validate()
  self._initialize = true
end
function PaGlobal_PowerSave_All:registEventHandler()
  if nil == Panel_Window_PowerSave_All then
    return
  end
  registerEvent("onScreenResize", "FromClient_PowerSave_All_Resize")
  registerEvent("FromClient_notifyConsoleSleepMode", "FromClient_PowerSave_All_NotifyConsoleSleepMode")
end
function PaGlobal_PowerSave_All:resize()
  if nil == Panel_Window_PowerSave_All then
    return
  end
  Panel_Window_PowerSave_All:SetSize(getOriginScreenSizeX(), getOriginScreenSizeY())
  Panel_Window_PowerSave_All:ComputePosAllChild()
  self._originMarkPosX = self._ui.stc_top:GetPosX()
  self._originTopMarkPosY = self._ui.stc_top:GetPosY()
  self._originBottomMarkPosY = self._ui.stc_bottom:GetPosY()
end
function PaGlobal_PowerSave_All:resetMarkPosition()
  self._ui.stc_top:SetPosX(self._originMarkPosX)
  self._ui.stc_top:SetPosY(self._originTopMarkPosY)
  self._ui.stc_bottom:SetPosX(self._originMarkPosX)
  self._ui.stc_bottom:SetPosY(self._originBottomMarkPosY)
  self._isAnimating = false
end
function PaGlobal_PowerSave_All:prepareOpen()
  if nil == Panel_Window_PowerSave_All then
    return
  end
  if true == Panel_Window_PowerSave_All:GetShow() then
    return
  end
  self._isOpen = true
  self._ui.stc_centerEffect:EraseAllEffect()
  self._ui.stc_centerEffect:AddEffect("fUI_Consol_Lock_01A", true, 0, 0)
  close_attacked_WindowPanelList(true)
  close_WindowPanelList()
  ToClinet_SetConsoleSleepMode(true)
  self._renderMode:set()
  PaGlobal_PowerSave_All:resize()
  PaGlobal_PowerSave_All:resetMarkPosition()
  PaGlobal_PowerSave_All:resetVertexAni()
  PaGlobal_PowerSave_All:open()
end
function PaGlobal_PowerSave_All:open()
  if nil == Panel_Window_PowerSave_All then
    return
  end
  Panel_Window_PowerSave_All:SetShow(true)
end
function PaGlobal_PowerSave_All:prepareClose()
  if nil == Panel_Window_PowerSave_All then
    return
  end
  if false == Panel_Window_PowerSave_All:GetShow() then
    return
  end
  self._isOpen = false
  ToClinet_SetConsoleSleepMode(false)
  self._renderMode:reset()
  PaGlobal_PowerSave_All:close()
end
function PaGlobal_PowerSave_All:close()
  if nil == Panel_Window_PowerSave_All then
    return
  end
  Panel_Window_PowerSave_All:SetShow(false)
end
function PaGlobal_PowerSave_All:resetVertexAni()
  Panel_Window_PowerSave_All:ResetVertexAni()
  PaGlobal_PowerSave_All._ui.stc_top:ResetVertexAni()
  PaGlobal_PowerSave_All._ui.stc_center:ResetVertexAni()
  PaGlobal_PowerSave_All._ui.stc_bottom:ResetVertexAni()
end
function PaGlobal_PowerSave_All:validate()
  if nil == Panel_Window_PowerSave_All then
    return
  end
  self._ui.stc_center:isValidate()
  self._ui.stc_top:isValidate()
  self._ui.stc_bottom:isValidate()
  self._ui.txt_desc:isValidate()
end
