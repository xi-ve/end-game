function PaGlobal_CampWarehouse_All:initialize()
  if true == PaGlobal_CampWarehouse_All._initialize then
    return
  end
  PaGlobal_CampWarehouse_All._ui.stc_TopBG = UI.getChildControl(Panel_Window_CampWarehouse_All, "Static_Camp_WarehouseBG")
  PaGlobal_CampWarehouse_All._ui.btn_Close = UI.getChildControl(PaGlobal_CampWarehouse_All._ui.stc_TopBG, "Button_Close")
  PaGlobal_CampWarehouse_All._ui.stc_SlotBG = UI.getChildControl(PaGlobal_CampWarehouse_All._ui.stc_TopBG, "Static_SlotBG")
  PaGlobal_CampWarehouse_All._ui.stc_Slot = UI.getChildControl(PaGlobal_CampWarehouse_All._ui.stc_SlotBG, "Static_ItemSlot")
  PaGlobal_CampWarehouse_All._ui.stc_Weight = UI.getChildControl(Panel_Window_CampWarehouse_All, "Static_Weight")
  PaGlobal_CampWarehouse_All._ui.txt_WeightVal = UI.getChildControl(PaGlobal_CampWarehouse_All._ui.stc_Weight, "StaticText_WeightValue")
  PaGlobal_CampWarehouse_All._ui.stc_ProgressBG = UI.getChildControl(PaGlobal_CampWarehouse_All._ui.stc_Weight, "Static_ProgressBG")
  PaGlobal_CampWarehouse_All._ui.prg_Red = UI.getChildControl(PaGlobal_CampWarehouse_All._ui.stc_Weight, "Progress2_Red")
  PaGlobal_CampWarehouse_All._ui.prg_Yellow = UI.getChildControl(PaGlobal_CampWarehouse_All._ui.stc_Weight, "Progress2_Yellow")
  PaGlobal_CampWarehouse_All._ui.txt_ProgVal = UI.getChildControl(PaGlobal_CampWarehouse_All._ui.stc_Weight, "StaticText_SlotValue")
  PaGlobal_CampWarehouse_All:createNewSlot()
  PaGlobal_CampWarehouse_All:registEventHandler()
  PaGlobal_CampWarehouse_All:validate()
  PaGlobal_CampWarehouse_All._initialize = true
end
function PaGlobal_CampWarehouse_All:registEventHandler()
  if nil == Panel_Window_CampWarehouse_All then
    return
  end
  registerEvent("FromClient_ServantInventoryUpdate", "FromClient_CampWarehouse_All_UpdateCampInven")
  PaGlobal_CampWarehouse_All._ui.btn_Close:addInputEvent("Mouse_LUp", "HandleEventLUp_CampWarehouse_All_Close()")
end
function PaGlobal_CampWarehouse_All:prepareOpen(actorKeyRaw)
  if nil == Panel_Window_CampWarehouse_All then
    return
  end
  PaGlobal_CampWarehouse_All:setUI()
  PaGlobal_CampWarehouse_All:setInitialInfo(actorKeyRaw)
  if nil ~= Panel_Widget_Tooltip_Renew and PaGlobalFunc_TooltipInfo_GetShow() then
    PaGlobalFunc_TooltipInfo_Close()
    return
  end
  PaGlobal_CampWarehouse_All:open()
end
function PaGlobal_CampWarehouse_All:open()
  if nil == Panel_Window_CampWarehouse_All then
    return
  end
  Panel_Window_CampWarehouse_All:SetShow(true)
end
function PaGlobal_CampWarehouse_All:prepareClose()
  if nil == Panel_Window_CampWarehouse_All then
    return
  end
  PaGlobal_CampWarehouse_All:close()
end
function PaGlobal_CampWarehouse_All:close()
  if nil == Panel_Window_CampWarehouse_All then
    return
  end
  Panel_Window_CampWarehouse_All:SetShow(false)
end
function PaGlobal_CampWarehouse_All:setInitialInfo(actorKeyRaw)
  local selfPlayer = getSelfPlayer()
  if selfPlayer == nil then
    return
  end
  PaGlobal_CampWarehouse_All._playerActorKeyRaw = selfPlayer:get():getActorKeyRaw()
  PaGlobal_CampWarehouse_All._vehicleActorKeyRaw = actorKeyRaw
  PaGlobal_CampWarehouse_All:update()
end
function PaGlobal_CampWarehouse_All:update()
  if nil == Panel_Window_CampWarehouse_All then
    return
  end
  PaGlobal_CampWarehouse_All:updateCampInven()
end
function PaGlobal_CampWarehouse_All:updateCampInven()
  if nil == PaGlobal_CampWarehouse_All._vehicleActorKeyRaw then
    return
  end
  local vehicleActorWrapper = getVehicleActor(PaGlobal_CampWarehouse_All._vehicleActorKeyRaw)
  if nil == vehicleActorWrapper then
    return
  end
  local vehicleActor = vehicleActorWrapper:get()
  if nil == vehicleActor then
    return
  end
  for idx = 1, PaGlobal_CampWarehouse_All._campSlotCountMax do
    local slot = PaGlobal_CampWarehouse_All._ui.slot_campSlotList[idx]
    slot.isEmpty = true
    slot:clearItem()
  end
  local vehicleInven = vehicleActor:getInventory()
  local capacity = vehicleInven:size()
  for idx = 0, capacity - 1 do
    local itemWrapper = getServantInventoryItemBySlotNo(PaGlobal_CampWarehouse_All._vehicleActorKeyRaw, idx)
    local slot
    if nil ~= itemWrapper then
      local itemSSW = itemWrapper:getStaticStatus()
      if nil ~= itemSSW then
        slot = PaGlobal_CampWarehouse_All._ui.slot_campSlotList[idx - 1]
        slot:setItem(itemWrapper)
        slot.isEmpty = false
        PaGlobal_CampWarehouse_All._ui.stc_campSlotBGList[idx - 1]:SetShow(true)
        PaGlobal_CampWarehouse_All._campInvenIndexList[idx - 1] = idx - 1
      end
    end
  end
  local s64_weightMax = vehicleActor:getPossessableWeight_s64()
  local s64_weightAll = vehicleActor:getCurrentWeight_s64()
  local s64_weightMax_div = s64_weightMax / Defines.s64_const.s64_100
  local s64_weightAll_div = s64_weightAll / Defines.s64_const.s64_100
  PaGlobal_CampWarehouse_All._ui.prg_Yellow:SetProgressRate(Int64toInt32(s64_weightAll / s64_weightMax_div))
  local allWeight = makeWeightString(s64_weightAll, 1)
  local maxWeight = makeWeightString(s64_weightMax, 0)
  PaGlobal_CampWarehouse_All._ui.txt_WeightVal:SetText(allWeight .. " /" .. maxWeight .. " " .. PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_WEIGHT"))
  local capacity = vehicleInven:size() - __eTInventorySlotNoUseStart
  local freeCount = vehicleInven:getFreeCount()
  PaGlobal_CampWarehouse_All._ui.txt_ProgVal:SetText(tostring(capacity - freeCount .. "/" .. capacity))
end
function PaGlobal_CampWarehouse_All:createNewSlot()
  local slotConfig = {
    createIcon = true,
    createBorder = true,
    createCount = true,
    createEnchant = true,
    createClassEquipBG = true,
    createCash = true,
    createItemLock = true,
    createClassEquipBG = true,
    createEnduranceIcon = true,
    createSoulComplete = true,
    createExpiration = true,
    createExpirationBG = true
  }
  local posY = 0
  for index = 1, PaGlobal_CampWarehouse_All._campSlotCountMax do
    PaGlobal_CampWarehouse_All._ui.stc_campSlotBGList[index] = UI.cloneControl(PaGlobal_CampWarehouse_All._ui.stc_Slot, PaGlobal_CampWarehouse_All._ui.stc_SlotBG, "Static_CampSlotBG" .. index)
    local slot = {}
    SlotItem.new(slot, "CampSlot" .. index, index, PaGlobal_CampWarehouse_All._ui.stc_campSlotBGList[index], slotConfig)
    slot:createChild()
    PaGlobal_CampWarehouse_All._ui.slot_campSlotList[index] = slot
    if index >= PaGlobal_CampWarehouse_All._campSlotCountMax / 2 + 1 then
      posX = PaGlobal_CampWarehouse_All._ui.stc_Slot:GetPosX() + (PaGlobal_CampWarehouse_All._ui.stc_Slot:GetSizeX() + 7) * (index - PaGlobal_CampWarehouse_All._campSlotCountMax / 2 - 1)
      posY = PaGlobal_CampWarehouse_All._ui.stc_Slot:GetPosY() + PaGlobal_CampWarehouse_All._ui.stc_Slot:GetSizeY() + 5
    else
      posX = PaGlobal_CampWarehouse_All._ui.stc_Slot:GetPosX() + (PaGlobal_CampWarehouse_All._ui.stc_Slot:GetSizeX() + 7) * (index - 1)
      posY = PaGlobal_CampWarehouse_All._ui.stc_Slot:GetPosY()
    end
    PaGlobal_CampWarehouse_All._ui.stc_campSlotBGList[index]:SetPosX(posX)
    PaGlobal_CampWarehouse_All._ui.stc_campSlotBGList[index]:SetPosY(posY)
    PaGlobal_CampWarehouse_All._ui.stc_campSlotBGList[index]:SetShow(true)
    PaGlobal_CampWarehouse_All._ui.slot_campSlotList[index].icon:addInputEvent("Mouse_On", "PaGlobalFunc_CampWarehouse_All_ShowFloatingTooltip(" .. index .. ", true)")
    PaGlobal_CampWarehouse_All._ui.slot_campSlotList[index].icon:addInputEvent("Mouse_Out", "PaGlobalFunc_CampWarehouse_All_ShowFloatingTooltip(" .. index .. ", false)")
    if false == _ContentsGroup_UsePadSnapping then
      PaGlobal_CampWarehouse_All._ui.slot_campSlotList[index].icon:SetEnableDragAndDrop(true)
      PaGlobal_CampWarehouse_All._ui.slot_campSlotList[index].icon:SetAutoDisableTime(2)
      PaGlobal_CampWarehouse_All._ui.slot_campSlotList[index].icon:addInputEvent("Mouse_RUp", "PaGlobalFunc_CampWarehouse_All_RemoveCampItemPopUp(" .. index .. ")")
    else
      PaGlobal_CampWarehouse_All._ui.stc_campSlotBGList[index]:registerPadEvent(__eConsoleUIPadEvent_Up_A, "PaGlobalFunc_CampWarehouse_All_RemoveCampItemPopUp(" .. index .. ")")
      if true == _ContentsGroup_RenewUI_Tooltip then
        PaGlobal_CampWarehouse_All._ui.stc_campSlotBGList[index]:registerPadEvent(__eConsoleUIPadEvent_Up_X, "PaGlobalFunc_CampWarehouse_All_ShowDetailTooltip(" .. index .. ")")
      end
    end
  end
end
function PaGlobal_CampWarehouse_All:setUI()
  if true == _ContentsGroup_UsePadSnapping then
    PaGlobal_CampWarehouse_All._ui.btn_Close:SetShow(false)
  elseif true == _ContentsGroup_NewUI_Inventory_All then
    if true == Panel_Window_Inventory_All:IsUISubApp() then
      Panel_Window_Inventory_All:CloseUISubApp()
    end
    Panel_Window_CampWarehouse_All:SetPosX(Panel_Window_Inventory_All:GetPosX() - Panel_Window_CampWarehouse_All:GetSizeX() - 10)
    Panel_Window_CampWarehouse_All:SetPosY(Panel_Window_Inventory_All:GetPosY() + 4)
  else
    if true == Panel_Window_Inventory:IsUISubApp() then
      Panel_Window_Inventory:CloseUISubApp()
    end
    Panel_Window_CampWarehouse_All:SetPosX(Panel_Window_Inventory:GetPosX() - Panel_Window_CampWarehouse_All:GetSizeX() - 10)
    Panel_Window_CampWarehouse_All:SetPosY(Panel_Window_Inventory:GetPosY() + 4)
  end
  PaGlobal_CampWarehouse_All:update()
end
function PaGlobal_CampWarehouse_All:showDetailTooltip(index)
  local itemWrapper = getServantInventoryItemBySlotNo(self._vehicleActorKeyRaw, index + 1)
  if nil == itemWrapper then
    return
  end
  if _ContentsGroup_UsePadSnapping then
    PaGlobalFunc_FloatingTooltip_Close()
    PaGlobalFunc_TooltipInfo_Open(Defines.TooltipDataType.ItemWrapper, itemWrapper, Defines.TooltipTargetType.Item, 0)
  end
end
function PaGlobal_CampWarehouse_All:validate()
  if nil == Panel_Window_CampWarehouse_All then
    return
  end
  PaGlobal_CampWarehouse_All._ui.stc_TopBG:isValidate()
  PaGlobal_CampWarehouse_All._ui.btn_Close:isValidate()
  PaGlobal_CampWarehouse_All._ui.stc_SlotBG:isValidate()
  PaGlobal_CampWarehouse_All._ui.stc_Slot:isValidate()
  PaGlobal_CampWarehouse_All._ui.stc_Weight:isValidate()
  PaGlobal_CampWarehouse_All._ui.txt_WeightVal:isValidate()
  PaGlobal_CampWarehouse_All._ui.stc_ProgressBG:isValidate()
  PaGlobal_CampWarehouse_All._ui.prg_Red:isValidate()
  PaGlobal_CampWarehouse_All._ui.prg_Yellow:isValidate()
  PaGlobal_CampWarehouse_All._ui.txt_ProgVal:isValidate()
end
