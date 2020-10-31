local Panel_Widget_TopIcon_Camp_info = {
  _ui = {stc_CampIcon = nil}
}
function Panel_Widget_TopIcon_Camp_info:registEventHandler()
  registerEvent("onScreenResize", "FromClient_TopIcon_Camp_Resize")
  registerEvent("FromClient_RenderModeChangeState", "FromClient_renderModeChange_TopIcon_Camp_Update")
end
function Panel_Widget_TopIcon_Camp_info:initialize()
  self:childControl()
  self:initValue()
  self:resize()
  self:registEventHandler()
end
function Panel_Widget_TopIcon_Camp_info:initValue()
  self._ui.stc_CampIcon:ChangeTextureInfoName("Renewal/Button/Console_Btn_Main.dds")
  local x1, y1, x2, y2 = setTextureUV_Func(self._ui.stc_CampIcon, 313, 1, 364, 52)
  self._ui.stc_CampIcon:getBaseTexture():setUV(x1, y1, x2, y2)
  self._ui.stc_CampIcon:setRenderTexture(self._ui.stc_CampIcon:getBaseTexture())
  local isShow = ToClient_isCampingReigsted()
  if isShow then
    Panel_Icon_Camp:SetShow(isShow)
  end
end
function Panel_Widget_TopIcon_Camp_info:resize()
  local panelSize = 52
  local posY = Panel_SelfPlayerExpGage:GetPosY() + Panel_SelfPlayerExpGage:GetSizeY() + 4
  Panel_Icon_Camp:SetPosY(posY)
  Panel_Icon_Camp:SetSize(panelSize, panelSize)
  self._ui.stc_CampIcon:SetSize(panelSize, panelSize)
  PaGlobalFunc_TopIcon_UpdatePos()
end
function Panel_Widget_TopIcon_Camp_info:childControl()
  self._ui.stc_CampIcon = UI.getChildControl(Panel_Icon_Camp, "Button_CampIcon")
end
function Panel_Widget_TopIcon_Camp_info:updateContent()
  local isShow = ToClient_isCampingReigsted()
  if false == isShow then
    PaGlobalFunc_TopIcon_Exit(TopWidgetIconType.Camp)
    return
  end
  PaGlobalFunc_TopIcon_Show(TopWidgetIconType.Camp)
end
function Panel_Widget_TopIcon_Camp_info:open()
  Panel_Icon_Camp:SetShow(true)
end
function Panel_Widget_TopIcon_Camp_info:close()
  Panel_Icon_Camp:SetShow(false)
end
function PaGlobalFunc_TopIcon_Camp_GetShow()
  return Panel_Icon_Camp:GetShow()
end
function PaGlobalFunc_TopIcon_Camp_Open()
  local self = Panel_Widget_TopIcon_Camp_info
  self:initValue()
  self:resize()
  self:open()
end
function PaGlobalFunc_TopIcon_Camp_Close()
  local self = Panel_Widget_TopIcon_Camp_info
  self:close()
end
function PaGlobalFunc_TopIcon_Camp_Update()
  local self = Panel_Widget_TopIcon_Camp_info
  self:updateContent()
end
function FromClient_TopIcon_Camp_Init()
  local self = Panel_Widget_TopIcon_Camp_info
  self:initialize()
end
function FromClient_TopIcon_Camp_Resize()
  local self = Panel_Widget_TopIcon_Camp_info
  self:resize()
end
function FromClient_renderModeChange_TopIcon_Camp_Update(prevRenderModeList, nextRenderModeList)
  local self = Panel_Widget_TopIcon_Camp_info
  PaGlobalFunc_TopIcon_UpdatePos()
end
registerEvent("FromClient_luaLoadComplete", "FromClient_TopIcon_Camp_Init")
