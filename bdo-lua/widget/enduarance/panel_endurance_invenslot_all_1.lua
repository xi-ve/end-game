function PaGlobal_Endurance_InvenSlot_All:initialize()
  if true == self._initialize then
    return
  end
  self._ui.txt_InvenSlotIcon = UI.getChildControl(Panel_Endurance, "StaticText_InvenSlotOver")
  self._ui.txt_InvenSlotText = UI.getChildControl(Panel_Endurance, "StaticText_NoticeInvenSlot")
  self._ui.btn_RepairAutoNavi = UI.getChildControl(Panel_Endurance, "CheckButton_Repair_AutoNavi")
  self:registEventHandler()
  self:validate()
  self._initialize = true
end
function PaGlobal_Endurance_InvenSlot_All:registEventHandler()
  if nil == Panel_Endurance then
    return
  end
  registerEvent("FromClient_InventoryUpdate", "PaGlobalFunc_Endurance_InvenSlot_All_CheckInvenSlot")
end
function PaGlobal_Endurance_InvenSlot_All:prepareOpen()
  if nil == Panel_Endurance then
    return
  end
  self:open()
end
function PaGlobal_Endurance_InvenSlot_All:open()
  if nil == Panel_Endurance then
    return
  end
  Panel_Endurance:SetShow(true)
end
function PaGlobal_Endurance_InvenSlot_All:prepareClose()
  if nil == Panel_Endurance then
    return
  end
  self:close()
end
function PaGlobal_Endurance_InvenSlot_All:close()
  if nil == Panel_Endurance then
    return
  end
  Panel_Endurance:SetShow(false)
end
function PaGlobal_Endurance_InvenSlot_All:checkInvenSlot()
  if nil == Panel_Endurance then
    return
  end
  if false == self._initialize then
    self:initialize()
    self._ui.txt_InvenSlotIcon:SetShow(false)
  end
  if false == _ContentsGroup_NewUI_InvenSlot_All then
    self._ui.txt_InvenSlotIcon:SetShow(false)
    self._ui.txt_InvenSlotText:SetShow(false)
    return
  end
  if false == _ContentsGroup_NewUI_Servant_All then
    if nil ~= Panel_Window_StableList and true == Panel_Window_StableList:GetShow() or nil ~= Panel_Window_WharfList and true == Panel_Window_WharfList:GetShow() or nil ~= Panel_Window_Repair and true == Panel_Window_Repair:GetShow() or nil ~= Panel_Dialog_Repair_Function_All and true == Panel_Dialog_Repair_Function_All:GetShow() then
      if true == _ContentsGroup_NewUI_Camp_All then
        if false == PaGlobalFunc_Camp_All_GetIsCamping() then
          return
        end
      elseif false == PaGlobal_Camp:getIsCamping() then
        return
      end
    end
  elseif nil ~= Panel_Dialog_ServantList_All and true == Panel_Dialog_ServantList_All:GetShow() then
    if true == _ContentsGroup_NewUI_Camp_All then
      if false == PaGlobalFunc_Camp_All_GetIsCamping() then
        return
      end
    elseif false == PaGlobal_Camp:getIsCamping() then
      return
    end
  end
  local selfPlayerWrapper = getSelfPlayer()
  if nil == selfPlayerWrapper then
    return
  end
  local selfPlayer = selfPlayerWrapper:get()
  local slotFreeCount = selfPlayer:getInventory():getFreeCount()
  local slotMaxCount = selfPlayer:getInventory():size()
  if slotFreeCount <= 5 then
    if self._ui.btn_RepairAutoNavi:GetShow() then
      self._ui.txt_InvenSlotIcon:SetPosY(Panel_Endurance:GetSizeY() + 50)
    else
      self._ui.txt_InvenSlotIcon:SetPosY(5)
    end
    if Panel_HorseEndurance:GetShow() or Panel_CarriageEndurance:GetShow() or Panel_ShipEndurance:GetShow() or Panel_SailShipEndurance:GetShow() then
      self._ui.txt_InvenSlotIcon:SetPosY(Panel_Endurance:GetSizeY() + 35)
    end
    if true == _ContentsGroup_RenewUI_Main then
      self._ui.txt_InvenSlotIcon:SetPosY(Panel_Endurance:GetSizeY() + 50)
    end
    local txt_Weight = UI.getChildControl(Panel_Endurance, "StaticText_WeightOver")
    if txt_Weight:GetShow() then
      self._ui.txt_InvenSlotIcon:SetPosY(txt_Weight:GetPosY() + txt_Weight:GetSizeY() + 30)
    end
    self._ui.txt_InvenSlotIcon:SetShow(true)
    self._ui.txt_InvenSlotText:SetShow(true)
    self._ui.txt_InvenSlotIcon:SetAlpha(0.9)
    if false == _ContentsGroup_RenewUI_Tutorial and false == _ContentsGroup_Tutorial_Renewal then
      local tutorialMenuShow = PaGlobal_TutorialMenu:checkShowCondition()
      PaGlobal_TutorialMenu:setShow(tutorialMenuShow, tutorialMenuShow)
    end
    local x1, y1, x2, y2
    if slotFreeCount <= 2 then
      x1, y1, x2, y2 = setTextureUV_Func(self._ui.txt_InvenSlotIcon, 28, 55, 54, 81)
    else
      x1, y1, x2, y2 = setTextureUV_Func(self._ui.txt_InvenSlotIcon, 55, 55, 81, 81)
    end
    self._ui.txt_InvenSlotIcon:getBaseTexture():setUV(x1, y1, x2, y2)
    self._ui.txt_InvenSlotIcon:setRenderTexture(self._ui.txt_InvenSlotIcon:getBaseTexture())
    self:prepareOpen()
  else
    self._ui.txt_InvenSlotIcon:SetShow(false)
    self._ui.txt_InvenSlotText:SetShow(false)
    if false == _ContentsGroup_RenewUI_Tutorial and false == _ContentsGroup_Tutorial_Renewal then
      local tutorialMenuShow = PaGlobal_TutorialMenu:checkShowCondition()
      PaGlobal_TutorialMenu:setShow(tutorialMenuShow, tutorialMenuShow)
    end
  end
  self._ui.txt_InvenSlotText:SetPosX(self._ui.txt_InvenSlotIcon:GetPosX() - self._ui.txt_InvenSlotText:GetSizeX() - 25)
  self._ui.txt_InvenSlotText:SetPosY(self._ui.txt_InvenSlotIcon:GetPosY() - 4)
  self:setEffect(slotFreeCount)
end
function PaGlobal_Endurance_InvenSlot_All:setPosY(posY)
  if nil == Panel_Endurance then
    return
  end
  if false == PaGlobal_Endurance_InvenSlot_All._initialize then
    return
  end
  self._ui.txt_InvenSlotIcon:SetPosY(posY)
  self._ui.txt_InvenSlotText:SetPosY(posY)
end
function PaGlobal_Endurance_InvenSlot_All:setEffect(slotCount)
  self._ui.txt_InvenSlotIcon:EraseAllEffect()
  if slotCount <= 2 then
    self._ui.txt_InvenSlotIcon:AddEffect("fUI_Weight_02B", true, -0.5, -1.3)
  elseif slotCount <= 5 then
    self._ui.txt_InvenSlotIcon:AddEffect("fUI_Weight_02A", true, -0.5, -1.3)
  end
end
function PaGlobal_Endurance_InvenSlot_All:validate()
  if nil == Panel_Endurance then
    return
  end
  self._ui.txt_InvenSlotIcon:isValidate()
  self._ui.txt_InvenSlotText:isValidate()
  self._ui.btn_RepairAutoNavi:isValidate()
end
