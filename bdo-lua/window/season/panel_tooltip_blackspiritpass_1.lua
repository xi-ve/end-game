function PaGlobal_BlackspiritPassTooltip:initialize()
  if true == self._initialize then
    return
  end
  self._ui._txt_title = UI.getChildControl(Panel_Window_BlackspiritPassTooltip, "StaticText_Title")
  self._ui._stc_descBG = UI.getChildControl(Panel_Window_BlackspiritPassTooltip, "Static_BG")
  self._ui._txt_desc = UI.getChildControl(self._ui._stc_descBG, "StaticText_DESC")
  self._ui._stc_expIcon = UI.getChildControl(Panel_Window_BlackspiritPassTooltip, "Static_Icon")
  self:registEventHandler()
  self:validate()
  self._initialize = true
end
function PaGlobal_BlackspiritPassTooltip:registEventHandler()
  if nil == Panel_Window_BlackspiritPassTooltip then
    return
  end
end
function PaGlobal_BlackspiritPassTooltip:prepareOpen(title, desc, showExpIcon)
  if nil == Panel_Window_BlackspiritPassTooltip then
    return
  end
  self._ui._txt_title:SetText(title)
  self._ui._txt_desc:SetTextMode(__eTextMode_AutoWrap)
  self._ui._txt_desc:SetText(desc)
  self._ui._stc_expIcon:SetShow(showExpIcon)
  self:setPosition()
  self:setSizeY()
  PaGlobal_BlackspiritPassTooltip:open()
end
function PaGlobal_BlackspiritPassTooltip:open()
  if nil == Panel_Window_BlackspiritPassTooltip then
    return
  end
  Panel_Window_BlackspiritPassTooltip:SetShow(true)
end
function PaGlobal_BlackspiritPassTooltip:prepareClose()
  if nil == Panel_Window_BlackspiritPassTooltip then
    return
  end
  PaGlobal_BlackspiritPassTooltip:close()
end
function PaGlobal_BlackspiritPassTooltip:close()
  if nil == Panel_Window_BlackspiritPassTooltip then
    return
  end
  Panel_Window_BlackspiritPassTooltip:SetShow(false)
end
function PaGlobal_BlackspiritPassTooltip:update()
  if nil == Panel_Window_BlackspiritPassTooltip then
    return
  end
end
function PaGlobal_BlackspiritPassTooltip:validate()
  if nil == Panel_Window_BlackspiritPassTooltip then
    return
  end
  self._ui._txt_title:isValidate()
  self._ui._stc_descBG:isValidate()
  self._ui._txt_desc:isValidate()
  self._ui._stc_expIcon:isValidate()
end
function PaGlobal_BlackspiritPassTooltip:setPosition()
  if nil == Panel_Window_BlackspiritPassTooltip then
    return
  end
  local screenSizeX = getScreenSizeX()
  local screenSizeY = getScreenSizeY()
  local mousePosX = getMousePosX()
  local mousePosY = getMousePosY()
  local panelPosX = mousePosX + 15
  local panelPosY = mousePosY + 15
  local panelSizeX = Panel_Window_BlackspiritPassTooltip:GetSizeX()
  local panelSizeY = Panel_Window_BlackspiritPassTooltip:GetSizeY()
  if screenSizeX < panelPosX + panelSizeX then
    panelPosX = mousePosX - panelSizeX - 15
  end
  if screenSizeY < panelPosY + panelSizeY then
    panelPosY = mousePosY - panelSizeY - 15
  end
  Panel_Window_BlackspiritPassTooltip:SetPosXY(panelPosX, panelPosY)
end
function PaGlobal_BlackspiritPassTooltip:setSizeY()
  if nil == Panel_Window_BlackspiritPassTooltip then
    return
  end
  local txtSizeY = self._ui._txt_desc:GetTextSizeY()
  self._ui._txt_desc:SetSize(self._ui._txt_desc:GetSizeX(), txtSizeY)
  local spanSizeY = 20
  self._ui._stc_descBG:SetSize(self._ui._stc_descBG:GetSizeX(), txtSizeY + spanSizeY)
  local panelSizeY = self._ui._stc_descBG:GetPosY() + self._ui._stc_descBG:GetSizeY()
  Panel_Window_BlackspiritPassTooltip:SetSize(Panel_Window_BlackspiritPassTooltip:GetSizeX(), panelSizeY)
end
