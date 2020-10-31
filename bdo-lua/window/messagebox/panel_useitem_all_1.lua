function PaGlobal_UseItem_All:initialize()
  if true == PaGlobal_UseItem_All._initialize then
    return
  end
  self:controlAll_Init()
  self:controlPC_Init()
  self:controlConsole_Init()
  self:controlSetShow()
  self:createPopupSlotControl()
  Panel_UseItem_All:setGlassBackground(true)
  Panel_UseItem_All:ActiveMouseEventEffect(true)
  PaGlobal_UseItem_All:registEventHandler()
  PaGlobal_UseItem_All:validate()
  PaGlobal_UseItem_All._initialize = true
end
function PaGlobal_UseItem_All:controlAll_Init()
  if nil == Panel_UseItem_All then
    return
  end
  self._ui._frame = UI.getChildControl(Panel_UseItem_All, "Frame_UseItem")
  self._ui._frameContent = UI.getChildControl(self._ui._frame, "Frame_1_Content")
  self._ui._frameScroll = UI.getChildControl(self._ui._frame, "Frame_1_VerticalScroll")
  self._ui._desc = UI.getChildControl(self._ui._frameContent, "StaticText_Desc")
  self._ui._copyItemSlotBG = UI.getChildControl(self._ui._frameContent, "Static_C_ItemSlotBG")
  self._ui._copyItemSlot = UI.getChildControl(self._ui._copyItemSlotBG, "Static_ItemIcon")
end
function PaGlobal_UseItem_All:controlPC_Init()
  if nil == Panel_UseItem_All then
    return
  end
  self._ui_pc._btn_Yes = UI.getChildControl(Panel_UseItem_All, "Button_Yes")
  self._ui_pc._btn_No = UI.getChildControl(Panel_UseItem_All, "Button_No")
  local stc_titleBG = UI.getChildControl(Panel_UseItem_All, "Static_TitleBG")
  self._ui_pc._btn_Close = UI.getChildControl(stc_titleBG, "Button_Close")
end
function PaGlobal_UseItem_All:controlConsole_Init()
  if nil == Panel_UseItem_All then
    return
  end
  self._ui_console._stc_ConsoleKeyBG = UI.getChildControl(Panel_UseItem_All, "Static_ConsoleButtonsBG")
  self._ui_console._btn_Select = UI.getChildControl(self._ui_console._stc_ConsoleKeyBG, "Button_Select")
  self._ui_console._btn_Move = UI.getChildControl(self._ui_console._stc_ConsoleKeyBG, "Button_Move")
  self._ui_console._btn_Cancel = UI.getChildControl(self._ui_console._stc_ConsoleKeyBG, "Button_Cancel")
end
function PaGlobal_UseItem_All:controlSetShow()
  if nil == Panel_UseItem_All then
    return
  end
  self._ui_pc._btn_Yes:SetShow(not self._isConsole)
  self._ui_pc._btn_No:SetShow(not self._isConsole)
  self._ui_pc._btn_Close:SetShow(not self._isConsole)
  self._ui_console._stc_ConsoleKeyBG:SetShow(self._isConsole)
  self._ui_console._btn_Select:SetShow(self._isConsole)
  self._ui_console._btn_Move:SetShow(self._isConsole)
  self._ui_console._btn_Cancel:SetShow(self._isConsole)
end
function PaGlobal_UseItem_All:registEventHandler()
  if nil == Panel_UseItem_All then
    return
  end
  if false == self._isConsole then
    self._ui_pc._btn_Close:addInputEvent("Mouse_LUp", "HandleEventLUp_UseItem_All_Close()")
    self._ui_pc._btn_Yes:addInputEvent("Mouse_LUp", "HandleEventLUp_UseItem_All_UseItem()")
    self._ui_pc._btn_No:addInputEvent("Mouse_LUp", "HandleEventLUp_UseItem_All_No()")
  else
    Panel_UseItem_All:ignorePadSnapMoveToOtherPanel()
    Panel_UseItem_All:registerPadEvent(__eConsoleUIPadEvent_Up_A, "HandleEventLUp_UseItem_All_UseItem()")
    Panel_UseItem_All:registerPadEvent(__eConsoleUIPadEvent_Up_B, "HandleEventLUp_UseItem_All_Close()")
  end
end
function PaGlobal_UseItem_All:prepareOpen()
  if nil == Panel_UseItem_All then
    return
  end
  SetUIMode(Defines.UIMode.eUIMode_PopupItem)
  self._ui._frame:UpdateContentScroll()
  self._ui._frameScroll:SetControlTop()
  self._ui._frame:UpdateContentPos()
  self._descBG_sizeY = 0
  PaGlobal_UseItem_All:open()
  _AudioPostEvent_SystemUiForXBOX(8, 14)
end
function PaGlobal_UseItem_All:open()
  if nil == Panel_UseItem_All then
    return
  end
  Panel_UseItem_All:SetShow(true)
end
function PaGlobal_UseItem_All:prepareClose()
  if nil == Panel_UseItem_All then
    return
  end
  SetUIMode(Defines.UIMode.eUIMode_Default)
  self._descBG_sizeY = 0
  PaGlobal_UseItem_All:close()
end
function PaGlobal_UseItem_All:close()
  if nil == Panel_UseItem_All then
    return
  end
  Panel_UseItem_All:SetShow(false)
end
function PaGlobal_UseItem_All:update()
  if nil == Panel_UseItem_All then
    return
  end
end
function PaGlobal_UseItem_All:validate()
  if nil == Panel_UseItem_All then
    return
  end
  self._ui._frame:isValidate()
  self._ui._frameContent:isValidate()
  self._ui._frameScroll:isValidate()
  self._ui._desc:isValidate()
  self._ui._copyItemSlotBG:isValidate()
  self._ui._copyItemSlot:isValidate()
  self._ui_pc._btn_Yes:isValidate()
  self._ui_pc._btn_No:isValidate()
  self._ui_pc._btn_Close:isValidate()
  self._ui_console._stc_ConsoleKeyBG:isValidate()
  self._ui_console._btn_Select:isValidate()
  self._ui_console._btn_Move:isValidate()
  self._ui_console._btn_Cancel:isValidate()
end
function PaGlobal_UseItem_All:getBottomPos(control)
  if nil == control then
    return
  end
  return control:GetPosY() + control:GetSizeY()
end
function PaGlobal_UseItem_All:createPopupSlotControl()
  if nil == Panel_UseItem_All then
    return
  end
  self._ui._descBG_sizeY = 0
  for idx = 1, self._maxPopupSlotCount do
    self._popupItem.slotInfoBG[idx] = UI.createControl(__ePAUIControl_Static, self._ui._copyItemSlotBG, "Static_EmptyItemSlotBG_" .. idx)
    CopyBaseProperty(self._ui._copyItemSlot, self._popupItem.slotInfoBG[idx])
    local slot = {}
    SlotItem.new(slot, "PopupUserItem_" .. idx, idx, Panel_UseItem_All, self._slotConfig)
    slot:createChild()
    self._popupItem.slotInfo[idx] = slot
    self._popupItem.slotInfoForBuffBG[idx] = UI.createControl(__ePAUIControl_Static, self._ui._copyItemSlotBG, "Static_EmptyBuffSlotBG_" .. idx)
    CopyBaseProperty(self._ui._copyItemSlot, self._popupItem.slotInfoForBuffBG[idx])
    self._popupItem.slotInfoForBuff[idx] = UI.createControl(__ePAUIControl_Static, self._ui._copyItemSlotBG, "Static_EmptyBuffSlot_" .. idx)
    CopyBaseProperty(self._ui._copyItemSlot, self._popupItem.slotInfoForBuff[idx])
  end
  self._ui._copyItemSlotBG:SetShow(false)
end
function PaGlobal_UseItem_All:resetUIcontrol()
  if nil == Panel_UseItem_All then
    return
  end
  for idx = 1, self._maxPopupSlotCount do
    self._popupItem.slotInfoBG[idx]:SetShow(false)
    self._popupItem.slotInfo[idx].icon:SetShow(false)
    self._popupItem.slotInfoForBuff[idx]:SetShow(false)
    self._popupItem.slotInfoForBuffBG[idx]:SetShow(false)
  end
  self._popupItem.totalRowCount = 0
end
function PaGlobal_UseItem_All:fillPopupUseItemData(itemEnchatWrapper)
  if nil == Panel_UseItem_All then
    return
  end
  self._ui._desc:SetTextMode(__eTextMode_AutoWrap)
  self._ui._desc:SetText(itemEnchatWrapper:getPopupItemDesc())
  self._ui._frameContent:SetSize(self._ui._frameContent:GetSizeX(), self._ui._desc:GetTextSizeY() + 60)
  self._ui._desc:SetPosY(30)
  self._ui._desc:SetSize(self._ui._desc:GetSizeX(), self._ui._desc:GetTextSizeY())
  local descSizeY = self._ui._desc:GetTextSizeY()
  if 180 < descSizeY then
    self._ui._frameScroll:SetShow(true)
    self._ui_console._btn_Move:SetShow(true)
    self._ui._frame:SetSize(self._ui._frame:GetSizeX(), 210)
    if false == self._isConsole then
      Panel_UseItem_All:SetSize(Panel_UseItem_All:GetSizeX(), self._ui._frame:GetSizeY() + 124)
      self._ui_pc._btn_Yes:ComputePos()
      self._ui_pc._btn_No:ComputePos()
    else
      Panel_UseItem_All:SetSize(Panel_UseItem_All:GetSizeX(), self._ui._frame:GetSizeY() + 70)
      self._ui_console._stc_ConsoleKeyBG:SetPosY(Panel_UseItem_All:GetSizeY())
    end
  else
    self._ui._frameScroll:SetShow(false)
    self._ui_console._btn_Move:SetShow(false)
    self._ui._frame:SetSize(self._ui._frame:GetSizeX(), descSizeY + 60)
    if false == self._isConsole then
      Panel_UseItem_All:SetSize(Panel_UseItem_All:GetSizeX(), self._ui._frame:GetSizeY() + 114)
      self._ui_pc._btn_Yes:ComputePos()
      self._ui_pc._btn_No:ComputePos()
    else
      Panel_UseItem_All:SetSize(Panel_UseItem_All:GetSizeX(), self._ui._frame:GetSizeY() + 60)
      self._ui_console._stc_ConsoleKeyBG:SetPosY(Panel_UseItem_All:GetSizeY())
    end
  end
  local ConsoleKeyGroup = {
    self._ui_console._btn_Move,
    self._ui_console._btn_Select,
    self._ui_console._btn_Cancel
  }
  PaGlobalFunc_ConsoleKeyGuide_SetAlign(ConsoleKeyGroup, self._ui_console._stc_ConsoleKeyBG, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP)
  self._descBG_sizeY = self._descBG_sizeY + self._ui._desc:GetSizeY()
  local popupItemSize = itemEnchatWrapper:getPopupItemSize()
  self:repositionItemSlot(popupItemSize)
  if 0 ~= popupItemSize then
    local itemESS
    local itemStack = Defines.s64_const.s64_0
    local expiration
    for idx = 1, popupItemSize do
      itemESS = itemEnchatWrapper:getPopupItemAt(idx - 1)
      if nil == itemESS then
        self._popupItem.slotInfo[idx].count:SetText("")
        self._popupItem.slotInfo[idx].icon:ChangeTextureInfoName("icon/new_icon/03_etc/item_unknown.dds")
      else
        itemStack = itemEnchatWrapper:getPopupItemAtStatckCount(idx - 1)
        self._popupItem.slotInfo[idx]:setItemByStaticStatus(itemESS, itemStack, -1)
        self._popupItem.slotInfo[idx].icon:addInputEvent("Mouse_On", "Panel_Tooltip_Item_Show_GeneralStatic(" .. idx .. ", \"popupItem\", true)")
        self._popupItem.slotInfo[idx].icon:addInputEvent("Mouse_Out", "Panel_Tooltip_Item_Show_GeneralStatic(" .. idx .. ", \"popupItem\", false)")
        Panel_Tooltip_Item_SetPosition(idx, self._popupItem.slotInfo[idx], "popupItem")
      end
    end
  end
  local popupBuffSize = itemEnchatWrapper:getPopupBuffSize()
  if 0 == popupBuffSize then
    return
  end
  self:repositionBuffSlot(popupBuffSize)
  local buffSSW
  for idxBuff = 1, popupBuffSize do
    buffSSW = itemEnchatWrapper:getPopupBuffStaticStatusWrapperAt(idxBuff - 1)
    if nil == buffSSW then
      self._popupItem.slotInfoForBuff[idxBuff]:ChangeTextureInfoName("icon/new_icon/03_etc/item_unknown.dds")
    else
      self._popupItem.slotInfoForBuff[idxBuff]:ChangeTextureInfoName("icon/" .. buffSSW:getIconPath())
      self._popupItem.slotInfoForBuff[idxBuff]:addInputEvent("Mouse_On", "HandleEventOnOut_UseItem_All_ShowPopupBuffTooltip( true, " .. idxBuff .. ")")
      self._popupItem.slotInfoForBuff[idxBuff]:addInputEvent("Mouse_Out", "HandleEventOnOut_UseItem_All_ShowPopupBuffTooltip( false, " .. idxBuff .. ")")
    end
  end
end
function PaGlobal_UseItem_All:repositionItemSlot(slotCount)
  local remain = slotCount % self._baseSlotLineCount
  local row = math.floor(slotCount / self._baseSlotLineCount)
  local slotIndexCount = row * self._baseSlotLineCount + remain
  if 0 == slotIndexCount then
    self._popupItem.slotIndex = 0
    return
  end
  self._popupItem.totalRowCount = row + 1
  local startX = _desc:GetPosX() + 5
  local startY = _desc:GetPosY() + _desc:GetSizeY() + 30
  local slotSizeX = _copyItemSlot:GetSizeX()
  local slotSizeY = _copyItemSlot:GetSizeY()
  local UIindex = 0
  local UIPosX = 0
  local UIPosY = 0
  for idy = 0, row do
    for idx = 1, baseSlotLineCount do
      UIindex = idx + idy * baseSlotLineCount
      if slotIndexCount < UIindex then
        break
      end
      UIPosX = startX + slotSizeX * (idx - 1) + 8 * (idx - 1)
      UIPosY = startY + slotSizeY * idy + 5 * idy
      if slotIndexCount == 1 then
        self._popupItem.slotInfoBG[UIindex]:SetPosX(Panel_UseItem_All:GetSizeX() / 2 - self._popupItem.slotInfoBG[UIindex]:GetSizeX() / 2)
        self._popupItem.slotInfoBG[UIindex]:SetPosY(UIPosY)
        self._popupItem.slotInfoBG[UIindex]:SetShow(true)
        self._popupItem.slotInfo[UIindex].icon:SetPosX(Panel_UseItem_All:GetSizeX() / 2 - self._popupItem.slotInfoBG[UIindex]:GetSizeX() / 2 + 2)
        self._popupItem.slotInfo[UIindex].icon:SetPosY(UIPosY + 3)
        self._popupItem.slotInfo[UIindex].icon:SetShow(true)
        local bgBottomPos = self:getBottomPos(self._popupItem.slotInfoBG[UIindex])
        self._descBG_sizeY = bgBottomPos - self._ui._frame:GetPosY() + 7
      elseif slotIndexCount <= 4 then
        self._popupItem.slotInfoBG[UIindex]:SetPosX(UIPosX)
        self._popupItem.slotInfoBG[UIindex]:SetPosY(UIPosY)
        self._popupItem.slotInfoBG[UIindex]:SetShow(true)
        self._popupItem.slotInfo[UIindex].icon:SetPosX(UIPosX + 3)
        self._popupItem.slotInfo[UIindex].icon:SetPosY(UIPosY + 3)
        self._popupItem.slotInfo[UIindex].icon:SetShow(true)
        local bgBottomPos = self:getBottomPos(self._popupItem.slotInfoBG[UIindex])
        self._descBG_sizeY = bgBottomPos - self._ui._frame:GetPosY() + 7
      elseif 4 < slotIndexCount then
        self._popupItem.slotInfoBG[UIindex]:SetPosX(UIPosX)
        self._popupItem.slotInfoBG[UIindex]:SetPosY(UIPosY)
        self._popupItem.slotInfoBG[UIindex]:SetShow(true)
        self._popupItem.slotInfo[UIindex].icon:SetPosX(UIPosX + 3)
        self._popupItem.slotInfo[UIindex].icon:SetPosY(UIPosY + 3)
        self._popupItem.slotInfo[UIindex].icon:SetShow(true)
        local bgBottomPos = self:getBottomPos(self._popupItem.slotInfoBG[UIindex])
        self._descBG_sizeY = bgBottomPos - self._ui._frame:GetPosY() + 7
      end
    end
  end
end
function PaGlobal_UseItem_All:repositionBuffSlot(buffCount)
  local remain = buffCount % self._baseSlotLineCount
  local row = math.floor(buffCount / self._baseSlotLineCount)
  local slotIndexCount = row * self._baseSlotLineCount + remain
  local startUI
  local startX = 0
  local startY = 0
  if 0 ~= self._popupItem.slotIndex then
    startUI = self._popupItem.slotInfoBG[self._popupItem.slotIndex]
    startX = self._ui._desc:GetPosX() + 5
    startY = startUI:GetPosY() + startUI:GetSizeY() + 30
    self._popupItem.totalRowCount = self._popupItem.totalRowCount + row + 1
  else
    startX = self._ui._desc:GetPosX() + 5
    startY = self._ui._desc:GetPosY() + self._ui._desc:GetSizeY() + 30
    self._popupItem.totalRowCount = row + 1
  end
  local slotSizeX = self._ui._copyItemSlot:GetSizeX()
  local slotSizeY = self._ui._copyItemSlot:GetSizeY()
  local UIindex = 1
  for idy = 0, row do
    for idx = 1, self._baseSlotLineCount do
      UIindex = idx + idy * self._baseSlotLineCount
      if slotIndexCount < UIindex then
        break
      end
      UIPosX = startX + slotSizeX * (idx - 1) + 8 * (idx - 1)
      UIPosY = startY + slotSizeY * idy + 5 * idy
      if slotIndexCount == 1 then
        self._popupItem.slotInfoBG[UIindex]:SetPosX(Panel_UseItem_All:GetSizeX() / 2 - self._popupItem.slotInfoBG[UIindex]:GetSizeX() / 2)
        self._popupItem.slotInfoBG[UIindex]:SetPosY(UIPosY)
        self._popupItem.slotInfoBG[UIindex]:SetShow(true)
        self._popupItem.slotInfo[UIindex].icon:SetPosX(Panel_UseItem_All:GetSizeX() / 2 - self._popupItem.slotInfoBG[UIindex]:GetSizeX() / 2 + 2)
        self._popupItem.slotInfo[UIindex].icon:SetPosY(UIPosY + 3)
        self._popupItem.slotInfo[UIindex].icon:SetShow(true)
        local bgBottomPos = self:getBottomPos(self._popupItem.slotInfoBG[UIindex])
        self._descBG_sizeY = bgBottomPos - self._ui._frame:GetPosY() + 7
      elseif slotIndexCount <= 4 then
        self._popupItem.slotInfoBG[UIindex]:SetPosX(UIPosX)
        self._popupItem.slotInfoBG[UIindex]:SetPosY(UIPosY)
        self._popupItem.slotInfoBG[UIindex]:SetShow(true)
        self._popupItem.slotInfo[UIindex].icon:SetPosX(UIPosX + 3)
        self._popupItem.slotInfo[UIindex].icon:SetPosY(UIPosY + 3)
        self._popupItem.slotInfo[UIindex].icon:SetShow(true)
        local bgBottomPos = self:getBottomPos(self._popupItem.slotInfoBG[UIindex])
        self._descBG_sizeY = bgBottomPos - self._ui._frame:GetPosY() + 7
      elseif 4 < slotIndexCount then
        self._popupItem.slotInfoBG[UIindex]:SetPosX(UIPosX)
        self._popupItem.slotInfoBG[UIindex]:SetPosY(UIPosY)
        self._popupItem.slotInfoBG[UIindex]:SetShow(true)
        self._popupItem.slotInfo[UIindex].icon:SetPosX(UIPosX + 3)
        self._popupItem.slotInfo[UIindex].icon:SetPosY(UIPosY + 3)
        self._popupItem.slotInfo[UIindex].icon:SetShow(true)
        local bgBottomPos = self:getBottomPos(self._popupItem.slotInfoBG[UIindex])
        self._descBG_sizeY = bgBottomPos - self._ui._frame:GetPosY() + 7
      end
    end
  end
end
