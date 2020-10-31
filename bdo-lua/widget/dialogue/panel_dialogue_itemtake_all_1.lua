function PaGlobal_Dialogue_Itemtake_All:initialize()
  if true == self._initialize then
    return
  end
  self._isConsole = _ContentsGroup_UsePadSnapping
  self:controlAll_Init()
  self:controlPc_Init()
  self:controlConsole_Init()
  self:SetUiSetting()
  self:registEventHandler()
  self:validate()
  self._initialize = true
end
function PaGlobal_Dialogue_Itemtake_All:controlAll_Init()
  if nil == Panel_Dialogue_Itemtake_All then
    return
  end
  self._ui.stc_titleBG = UI.getChildControl(Panel_Dialogue_Itemtake_All, "Static_TitleBg")
  self._ui.txt_title = UI.getChildControl(Panel_Dialogue_Itemtake_All, "StaticText_Title")
  self._ui.stc_midBG = UI.getChildControl(Panel_Dialogue_Itemtake_All, "Static_MidBg")
  self._ui.stc_subFrameBG = UI.getChildControl(Panel_Dialogue_Itemtake_All, "Static_SubFrameBg")
  self._ui.stc_itemIcon = UI.getChildControl(Panel_Dialogue_Itemtake_All, "Static_Itemicon")
  self._ui.txt_Comment = UI.getChildControl(Panel_Dialogue_Itemtake_All, "StaticText_Comment")
  self._ui.txt_itemName = UI.getChildControl(Panel_Dialogue_Itemtake_All, "StaticText_Itemname")
  self._ui.stc_line = UI.getChildControl(Panel_Dialogue_Itemtake_All, "Static_Line")
  self._ui.txt_needContribution = UI.getChildControl(Panel_Dialogue_Itemtake_All, "StaticText_NeedContribution")
  self._ui.txt_myContribution = UI.getChildControl(Panel_Dialogue_Itemtake_All, "StaticText_MyContribution")
  self._ui.stc_territorymark = UI.getChildControl(Panel_Dialogue_Itemtake_All, "Static_territorymark")
  self._ui.txt_helpMsg = UI.getChildControl(Panel_Dialogue_Itemtake_All, "StaticText_helpMsg")
  self._ui.stc_titleDeco = UI.getChildControl(Panel_Dialogue_Itemtake_All, "Static_TitleDeco")
  self._ui._icon_items = {}
  SlotItem.new(self._ui._icon_items, "feeItem", nil, self._ui.stc_itemIcon, self.slotConfig)
  self._ui._icon_items:createChild()
  self._ui._icon_items:clearItem()
  self._ui._icon_items.icon:SetIgnore(false)
  self._ui.stc_itemIcon:SetSize(self._ui._icon_items.icon:GetSizeX(), self._ui._icon_items.icon:GetSizeY())
  self._ui._ICONPOSX = self._ui._icon_items.icon:GetPosX()
end
function PaGlobal_Dialogue_Itemtake_All:controlPc_Init()
  if nil == Panel_Dialogue_Itemtake_All then
    return
  end
  self._ui_pc.btn_yes = UI.getChildControl(Panel_Dialogue_Itemtake_All, "Button_Yes")
  self._ui_pc.btn_no = UI.getChildControl(Panel_Dialogue_Itemtake_All, "Button_No")
end
function PaGlobal_Dialogue_Itemtake_All:controlConsole_Init()
  if nil == Panel_Dialogue_Itemtake_All then
    return
  end
  self._ui_console.stc_bottomBg = UI.getChildControl(Panel_Dialogue_Itemtake_All, "Static_BottomBG_ConsoleUI")
  self._ui_console.stc_guideIconB = UI.getChildControl(self._ui_console.stc_bottomBg, "StaticText_B_ConsoleUI")
  self._ui_console.stc_guideIconX = UI.getChildControl(self._ui_console.stc_bottomBg, "StaticText_X_ConsoleUI")
  self._ui_console.stc_guideIconA = UI.getChildControl(self._ui_console.stc_bottomBg, "StaticText_A_ConsoleUI")
end
function PaGlobal_Dialogue_Itemtake_All:SetUiSetting()
  if nil == Panel_Dialogue_Itemtake_All then
    return
  end
  if true == self._isConsole then
    local minusSizeY = self._ui_pc.btn_yes:GetSizeY()
    self._ui.stc_subFrameBG:SetSize(self._ui.stc_subFrameBG:GetSizeX(), self._ui.stc_subFrameBG:GetSizeY() - minusSizeY - 20)
    Panel_Dialogue_Itemtake_All:SetSize(Panel_Dialogue_Itemtake_All:GetSizeX(), Panel_Dialogue_Itemtake_All:GetSizeY() - minusSizeY - 20)
    self._ui.txt_helpMsg:SetSpanSize(self._ui.txt_helpMsg:GetSpanSize().x, 10)
    self._ui_pc.btn_yes:SetShow(false)
    self._ui_pc.btn_no:SetShow(false)
    self._ui_console.stc_bottomBg:SetShow(true)
    self._ui.stc_itemIcon:SetIgnore(false)
  else
    self._ui_console.stc_bottomBg:SetShow(false)
    self._ui.stc_itemIcon:SetIgnore(true)
  end
  FromClient_Dialogue_Itemtake_All_ReSizePanel()
end
function PaGlobal_Dialogue_Itemtake_All:registEventHandler()
  if nil == Panel_Dialogue_Itemtake_All then
    return
  end
  registerEvent("onScreenResize", "FromClient_Dialogue_Itemtake_All_ReSizePanel()")
  if false == self._isConsole then
    self._ui_pc.btn_yes:addInputEvent("Mouse_LUp", "HandleEventLUp_Dialogue_Itemtake_All_ClickYes()")
    self._ui_pc.btn_no:addInputEvent("Mouse_LUp", "HandleEventLUp_Dialogue_Itemtake_All_ClickNo()")
    self._ui._icon_items.icon:addInputEvent("Mouse_On", "HandleEventOn_Dialogue_Itemtake_All_ShowTooltip()")
    self._ui._icon_items.icon:addInputEvent("Mouse_Out", "Panel_Tooltip_Item_hideTooltip()")
    Panel_Tooltip_Item_SetPosition(0, self._ui._icon_items.icon, "talkPopup")
  else
    if true == _ContentsGroup_RenewUI_Tooltip then
      Panel_Dialogue_Itemtake_All:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandlePadEventX_Dialogue_Itemtake_All_ShowTooltip()")
    else
      Panel_Dialogue_Itemtake_All:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandleEventOn_Dialogue_Itemtake_All_ShowTooltip()")
    end
    Panel_Dialogue_Itemtake_All:registerPadEvent(__eConsoleUIPadEvent_Up_A, "HandleEventLUp_Dialogue_Itemtake_All_ClickYes()")
  end
end
function PaGlobal_Dialogue_Itemtake_All:prepareOpen(displayData)
  if nil == Panel_Dialogue_Itemtake_All then
    return
  end
  self._currentDisplayData = displayData
  local itemStaticWrapper = getItemEnchantStaticStatus(displayData:getItemKey())
  if nil == itemStaticWrapper then
    return
  end
  local explorePoint = getExplorePointByTerritory(self._currentDisplayData._territoryKey)
  self._ui._icon_items:setItemByStaticStatus(itemStaticWrapper, displayData._itemCounts64)
  local strNeedPoint = string.format("%d", displayData._needPoint)
  local strHavePoint = string.format("%d", explorePoint:getRemainedPoint())
  self._ui.txt_itemName:SetTextMode(__eTextMode_AutoWrap)
  self._ui.txt_itemName:SetText(itemStaticWrapper:getName())
  self._ui.txt_itemName:ComputePos()
  self._ui.txt_needContribution:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "DIALOG_NEED_POINT", "point", strNeedPoint))
  self._ui.txt_myContribution:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "DIALOG_HAVE_POINT", "point", strHavePoint))
  self._ui.txt_needContribution:SetSize(self._ui.txt_needContribution:GetTextSizeX(), self._ui.txt_needContribution:GetSizeY())
  self._ui.txt_needContribution:ComputePos()
  self._ui.txt_myContribution:SetSize(self._ui.txt_myContribution:GetTextSizeX(), self._ui.txt_myContribution:GetSizeY())
  self._ui.txt_myContribution:ComputePos()
  local padding = 10
  self._ui._icon_items.icon:ComputePos()
  if selfPlayerCurrentTerritory() == PAGetString(Defines.StringSheet_GAME, "DIALOG_SERENDIA") then
    self._ui.stc_territorymark:ChangeTextureInfoName("New_UI_Common_forLua/Widget/Dialogue/Dialogue_Etc_00.dds")
    local x1, y1, x2, y2 = setTextureUV_Func(self._ui.stc_territorymark, 329, 1, 379, 60)
    self._ui.stc_territorymark:getBaseTexture():setUV(x1, y1, x2, y2)
    self._ui.stc_territorymark:setRenderTexture(self._ui.stc_territorymark:getBaseTexture())
  elseif selfPlayerCurrentTerritory() == PAGetString(Defines.StringSheet_GAME, "DIALOG_BALENOS") then
    self._ui.stc_territorymark:ChangeTextureInfoName("New_UI_Common_forLua/Widget/Dialogue/Dialogue_Etc_00.dds")
    local x1, y1, x2, y2 = setTextureUV_Func(self._ui.stc_territorymark, 278, 1, 328, 60)
    self._ui.stc_territorymark:getBaseTexture():setUV(x1, y1, x2, y2)
    self._ui.stc_territorymark:setRenderTexture(self._ui.stc_territorymark:getBaseTexture())
  elseif selfPlayerCurrentTerritory() == PAGetString(Defines.StringSheet_GAME, "LUA_GUILDWARINFO_TERRITORYNAME_2") then
    self._ui.stc_territorymark:ChangeTextureInfoName("New_UI_Common_forLua/Widget/Dialogue/Dialogue_Etc_00.dds")
    local x1, y1, x2, y2 = setTextureUV_Func(self._ui.stc_territorymark, 461, 309, 511, 368)
    self._ui.stc_territorymark:getBaseTexture():setUV(x1, y1, x2, y2)
    self._ui.stc_territorymark:setRenderTexture(self._ui.stc_territorymark:getBaseTexture())
  elseif selfPlayerCurrentTerritory() == PAGetString(Defines.StringSheet_GAME, "LUA_GUILDWARINFO_TERRITORYNAME_3") then
    self._ui.stc_territorymark:ChangeTextureInfoName("New_UI_Common_forLua/Widget/Dialogue/Dialogue_Etc_00.dds")
    local x1, y1, x2, y2 = setTextureUV_Func(self._ui.stc_territorymark, 461, 429, 511, 488)
    self._ui.stc_territorymark:getBaseTexture():setUV(x1, y1, x2, y2)
    self._ui.stc_territorymark:setRenderTexture(self._ui.stc_territorymark:getBaseTexture())
  elseif selfPlayerCurrentTerritory() == PAGetString(Defines.StringSheet_GAME, "LUA_CONTRYNAME_6") then
    self._ui.stc_territorymark:ChangeTextureInfoName("New_UI_Common_forLua/Widget/Dialogue/Dialogue_Etc_00.dds")
    local x1, y1, x2, y2 = setTextureUV_Func(self._ui.stc_territorymark, 461, 369, 511, 428)
    self._ui.stc_territorymark:getBaseTexture():setUV(x1, y1, x2, y2)
    self._ui.stc_territorymark:setRenderTexture(self._ui.stc_territorymark:getBaseTexture())
  end
  if displayData._needPoint > explorePoint:getRemainedPoint() then
    self._ui.txt_Comment:SetText(PAGetString(Defines.StringSheet_GAME, "DIALOG_ERROR_SHORTAGE_POINT"))
    self._ui_pc.btn_yes:SetEnable(false)
    self._ui_pc.btn_yes:SetMonoTone(true)
    self._ui_pc.btn_yes:SetFontColor(Defines.Color.C_FF515151)
  else
    self._ui.txt_Comment:SetText(PAGetString(Defines.StringSheet_GAME, "DIALOG_ITEMTAKE_TXT_COMMENT"))
    self._ui_pc.btn_yes:SetEnable(true)
    self._ui_pc.btn_yes:SetMonoTone(false)
    self._ui_pc.btn_yes:SetFontColor(Defines.Color.C_FFC4BEBE)
  end
  self._ui.txt_helpMsg:SetShow(true)
  self._ui.txt_helpMsg:SetTextMode(__eTextMode_AutoWrap)
  self._ui.txt_helpMsg:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_DIALOGUE_TXT_CONTRIHELP"))
  PaGlobal_Dialogue_Itemtake_All:open()
end
function PaGlobal_Dialogue_Itemtake_All:open()
  if nil == Panel_Dialogue_Itemtake_All then
    return
  end
  Panel_Dialogue_Itemtake_All:SetShow(true)
end
function PaGlobal_Dialogue_Itemtake_All:prepareClose()
  if nil == Panel_Dialogue_Itemtake_All then
    return
  end
  PaGlobal_Dialogue_Itemtake_All:close()
end
function PaGlobal_Dialogue_Itemtake_All:close()
  if nil == Panel_Dialogue_Itemtake_All then
    return
  end
  Panel_Dialogue_Itemtake_All:SetShow(false)
end
function PaGlobal_Dialogue_Itemtake_All:update()
  if nil == Panel_Dialogue_Itemtake_All then
    return
  end
end
function PaGlobal_Dialogue_Itemtake_All:validate()
  if nil == Panel_Dialogue_Itemtake_All then
    return
  end
  self:allValidate()
  self:pcValidate()
  self:consoleValidate()
end
function PaGlobal_Dialogue_Itemtake_All:allValidate()
  if nil == Panel_Dialogue_Itemtake_All then
    return
  end
  self._ui.stc_titleBG:isValidate()
  self._ui.txt_title:isValidate()
  self._ui.stc_midBG:isValidate()
  self._ui.stc_subFrameBG:isValidate()
  self._ui.stc_itemIcon:isValidate()
  self._ui.txt_Comment:isValidate()
  self._ui.txt_itemName:isValidate()
  self._ui.stc_line:isValidate()
  self._ui.txt_needContribution:isValidate()
  self._ui.txt_myContribution:isValidate()
  self._ui.stc_territorymark:isValidate()
  self._ui.txt_helpMsg:isValidate()
  self._ui.stc_titleDeco:isValidate()
end
function PaGlobal_Dialogue_Itemtake_All:pcValidate()
  if nil == Panel_Dialogue_Itemtake_All then
    return
  end
  self._ui_pc.btn_yes:isValidate()
  self._ui_pc.btn_no:isValidate()
end
function PaGlobal_Dialogue_Itemtake_All:consoleValidate()
  if nil == Panel_Dialogue_Itemtake_All then
    return
  end
end
