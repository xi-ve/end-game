function PaGlobal_Extraction_All_Open()
  SetUIMode(Defines.UIMode.eUIMode_Extraction)
  UIAni.fadeInSCR_Down(Panel_Window_Extraction_All)
  if false == _ContentsGroup_RenewUI_InventoryEquip then
    if true == _ContentsGroup_NewUI_Equipment_All then
      PaGlobalFunc_Equipment_All_PosSave()
      Panel_Window_Equipment_All:SetPosX(10)
      Panel_Window_Equipment_All:SetPosY(getScreenSizeY() - getScreenSizeY() / 2 - Panel_Window_Equipment_All:GetSizeY() / 2)
    else
      Equipment_PosSaveMemory()
      Panel_Equipment:SetPosX(10)
      Panel_Equipment:SetPosY(getScreenSizeY() - getScreenSizeY() / 2 - Panel_Equipment:GetSizeY() / 2)
    end
  end
  if true == _ContentsGroup_NewUI_Dialog_All then
    PaGlobalFunc_DialogMain_All_SetIgnoreShowDialog(true)
    PaGlobalFunc_DialogMain_All_ShowToggle(false)
  elseif true == _ContentsGroup_RenewUI_Dailog then
    PaGlobalFunc_MainDialog_setIgnoreShowDialog(true)
    PaGlobalFunc_MainDialog_Close()
  else
    setIgnoreShowDialog(true)
    Panel_Npc_Dialog:SetShow(false)
  end
  PaGlobal_Extraction_All:prepareOpen()
end
function PaGlobal_Extraction_All_Close()
  SetUIMode(Defines.UIMode.eUIMode_NpcDialog)
  if false == _ContentsGroup_NewUI_BlackSmith_All then
    PaGlobal_ExtractionCaphras_Close()
    ExtractionEnchantStone_WindowClose()
    ExtractionCloth_WindowClose()
    PaGlobal_ExtractionSystem_ForceClose()
    Socket_ExtractionCrystal_WindowClose()
    PaGlobal_ExtractionCrystal:clearData()
  else
    PaGlobal_Extraction_Costume_All_Close()
    PaGlobal_Extraction_Caphras_All_Close()
    PaGlobal_Extraction_Blackstone_All_Close()
    PaGlobal_Extraction_System_All_Close()
    PaGlobal_Extraction_Crystal_All_Close()
  end
  InventoryWindow_Close()
  if false == _ContentsGroup_RenewUI_InventoryEquip then
    if true == _ContentsGroup_NewUI_Equipment_All then
      PaGlobalFunc_Equipment_All_PosLoad()
      Panel_Window_Equipment_All:SetShow(false, false)
    else
      Equipment_PosLoadMemory()
      Panel_Equipment:SetShow(false, false)
    end
    if true == _ContentsGroup_NewUI_ClothInventory_All or true == _ContentsGroup_RenewUI then
      PaGlobalFunc_ClothInventory_All_Close()
    else
      ClothInventory_Close()
    end
  else
    PaGlobalFunc_ClothInventory_All_Close()
  end
  PaGlobal_Extraction_All:prepareClose()
  if true == _ContentsGroup_NewUI_Dialog_All then
    PaGlobalFunc_DialogMain_All_SetIgnoreShowDialog(true)
    PaGlobalFunc_DialogMain_All_ShowToggle(true)
    HandleEventLUp_DialogMain_All_BackClick()
  elseif true == _ContentsGroup_RenewUI_Dailog then
    PaGlobalFunc_MainDialog_setIgnoreShowDialog(false)
    PaGlobalFunc_MainDialog_ReOpen()
  else
    setIgnoreShowDialog(false)
    Panel_Npc_Dialog:SetShow(true)
  end
end
function PaGlobal_Extraction_All_MoveTab(value)
  if nil == Panel_Window_Extraction_All then
    return
  end
  PaGlobal_Extraction_Costume_All_Close()
  PaGlobal_Extraction_Caphras_All_Close()
  PaGlobal_Extraction_Blackstone_All_Close()
  PaGlobal_Extraction_System_All_Close()
  PaGlobal_Extraction_Crystal_All_Close()
  PaGlobal_Extraction_All._currentTabIndex = PaGlobal_Extraction_All._currentTabIndex + value
  if PaGlobal_Extraction_All._funcButtonCount < PaGlobal_Extraction_All._currentTabIndex then
    PaGlobal_Extraction_All._currentTabIndex = 1
  elseif PaGlobal_Extraction_All._currentTabIndex < 1 then
    PaGlobal_Extraction_All._currentTabIndex = PaGlobal_Extraction_All._funcButtonCount
  end
  for idx = 1, PaGlobal_Extraction_All._funcButtonCount do
    if true == PaGlobal_Extraction_All._btnTable[idx - 1]:GetShow() then
      PaGlobal_Extraction_All._btnTable[idx - 1]:SetCheck(false)
    end
  end
  PaGlobal_Extraction_All._btnTable[PaGlobal_Extraction_All._currentTabIndex - 1]:SetCheck(true)
  local posX = PaGlobal_Extraction_All._btnTable[PaGlobal_Extraction_All._currentTabIndex - 1]:GetPosX() + PaGlobal_Extraction_All._btnTable[PaGlobal_Extraction_All._currentTabIndex - 1]:GetSizeX() * 0.5 - PaGlobal_Extraction_All._ui_console.btn_A:GetSizeX() * 0.5
  PaGlobal_Extraction_All._ui_console.btn_A:SetPosX(posX)
  posX = PaGlobal_Extraction_All._btnTable[PaGlobal_Extraction_All._currentTabIndex - 1]:GetPosX() + PaGlobal_Extraction_All._btnTable[PaGlobal_Extraction_All._currentTabIndex - 1]:GetSizeX() * 0.5 - PaGlobal_Extraction_All._ui.stc_selectLine:GetSizeX() * 0.5
  PaGlobal_Extraction_All._ui.stc_selectLine:SetShow(true)
  PaGlobal_Extraction_All._ui.stc_selectLine:SetPosX(posX)
end
function PaGlobal_Extraction_All_SelectCurrentTab()
  if nil == Panel_Window_Extraction_All then
    return
  end
  PaGlobal_Extraction_All._funcTable[PaGlobal_Extraction_All._currentTabIndex - 1]()
end
function HandleEventLUp_Extraction_All_Button_ExtractionCrystal_Click()
  if false == _ContentsGroup_NewUI_BlackSmith_All then
    if false == Panel_Window_Extraction_Crystal:GetShow() then
      PaGlobal_ExtractionCaphras_Close()
      ExtractionEnchantStone_WindowClose()
      ExtractionCloth_WindowClose()
      PaGlobal_ExtractionSystem_ForceClose()
      PaGlobal_ExtractionCrystal:show(true)
      Inventory_SetFunctor(Socket_Extraction_InvenFiler_EquipItem, Panel_Socket_ExtractionCrystal_InteractortionFromInventory, Socket_ExtractionCrystal_WindowClose, nil)
      InventoryWindow_Show()
      if not _ContentsGroup_RenewUI_InventoryEquip then
        if true == _ContentsGroup_NewUI_Equipment_All then
          Panel_Window_Equipment_All:SetShow(true, true)
        else
          Panel_Equipment:SetShow(true, true)
        end
      end
    else
      PaGlobal_ExtractionCrystal:show(false)
      InventoryWindow_Close()
      if not _ContentsGroup_RenewUI_InventoryEquip then
        if true == _ContentsGroup_NewUI_Equipment_All then
          PaGlobalFunc_Equipment_All_Close(false)
        else
          EquipmentWindow_Close()
        end
      end
    end
    PaGlobal_TutorialManager:handleClickExtractionCrystalButton(Panel_Window_Extraction_Crystal:GetShow())
  else
    if nil ~= Panel_Window_Extraction_Crystal_All and false == Panel_Window_Extraction_Crystal_All:GetShow() then
      PaGlobal_Extraction_Costume_All_Close()
      PaGlobal_Extraction_Caphras_All_Close()
      PaGlobal_Extraction_Blackstone_All_Close()
      PaGlobal_Extraction_System_All_Close()
      InventoryWindow_Close()
      if not _ContentsGroup_RenewUI_InventoryEquip then
        if true == _ContentsGroup_NewUI_Equipment_All then
          PaGlobalFunc_Equipment_All_Close(false)
        else
          EquipmentWindow_Close()
        end
      end
      PaGlobal_Extraction_Crystal_All_Open()
    else
      PaGlobal_Extraction_Crystal_All_Close()
      InventoryWindow_Close()
      if not _ContentsGroup_RenewUI_InventoryEquip then
        if true == _ContentsGroup_NewUI_Equipment_All then
          PaGlobalFunc_Equipment_All_Close(false)
        else
          EquipmentWindow_Close()
        end
      end
    end
    PaGlobal_TutorialManager:handleClickExtractionCrystalButton(Panel_Window_Extraction_Crystal_All:GetShow())
  end
  if false == PaGlobal_Extraction_All._isConsole then
    PaGlobal_Extraction_All._ui.stc_selectLine:SetShow(true)
    local posX = PaGlobal_Extraction_All._ui.btn_crystal:GetPosX() + PaGlobal_Extraction_All._ui.btn_crystal:GetSizeX() * 0.25
    PaGlobal_Extraction_All._ui.stc_selectLine:SetPosX(posX)
  end
end
function HandleEventLUp_Extraction_All_Button_ExtractionCaphras_Click()
  if false == _ContentsGroup_NewUI_BlackSmith_All then
    if nil == Panel_Window_Extraction_Caphras then
      return
    end
    if false == Panel_Window_Extraction_Caphras:GetShow() then
      ExtractionEnchantStone_WindowClose()
      Socket_ExtractionCrystal_WindowClose()
      ExtractionCloth_WindowClose()
      PaGlobal_ExtractionSystem_ForceClose()
      PaGlobal_Extraction_Caphras_Open()
      if not _ContentsGroup_RenewUI_InventoryEquip then
        if true == _ContentsGroup_NewUI_Equipment_All then
          Panel_Window_Equipment_All:SetShow(true, true)
        else
          Panel_Equipment:SetShow(true, true)
        end
      end
    else
      PaGlobal_ExtractionCaphras_Close()
      InventoryWindow_Close()
      if not _ContentsGroup_RenewUI_InventoryEquip then
        if true == _ContentsGroup_NewUI_Equipment_All then
          PaGlobalFunc_Equipment_All_Close(false)
        else
          EquipmentWindow_Close()
        end
      end
    end
    PaGlobal_TutorialManager:handleClickExtractionCaphrasButton(Panel_Window_Extraction_Caphras:GetShow())
  else
    if nil == Panel_Window_Extraction_Caphras_All then
      return
    end
    if false == Panel_Window_Extraction_Caphras_All:GetShow() then
      PaGlobal_Extraction_Blackstone_All_Close()
      PaGlobal_Extraction_Crystal_All_Close()
      PaGlobal_Extraction_Costume_All_Close()
      PaGlobal_Extraction_System_All_Close()
      InventoryWindow_Close()
      if not _ContentsGroup_RenewUI_InventoryEquip then
        if true == _ContentsGroup_NewUI_Equipment_All then
          PaGlobalFunc_Equipment_All_Close(false)
        else
          EquipmentWindow_Close()
        end
      end
      PaGlobal_Extraction_Caphras_All_Open()
    else
      PaGlobal_Extraction_Caphras_All_Close()
    end
    PaGlobal_TutorialManager:handleClickExtractionCaphrasButton(Panel_Window_Extraction_Caphras_All:GetShow())
  end
  if false == PaGlobal_Extraction_All._isConsole then
    PaGlobal_Extraction_All._ui.stc_selectLine:SetShow(true)
    local posX = PaGlobal_Extraction_All._ui.btn_caphras:GetPosX() + PaGlobal_Extraction_All._ui.btn_caphras:GetSizeX() * 0.25
    PaGlobal_Extraction_All._ui.stc_selectLine:SetPosX(posX)
  end
end
function HandleEventLUp_Extraction_All_Button_ExtractionEnchantStone_Click()
  if false == _ContentsGroup_NewUI_BlackSmith_All then
    if false == Panel_Window_Extraction_EnchantStone:GetShow() then
      Socket_ExtractionCrystal_WindowClose()
      ExtractionCloth_WindowClose()
      PaGlobal_ExtractionCaphras_Close()
      PaGlobal_ExtractionSystem_ForceClose()
      ExtractionEnchantStone_WindowOpen()
      if true == _ContentsGroup_NewUI_Equipment_All then
        Panel_Window_Equipment_All:SetShow(true, true)
      else
        Panel_Equipment:SetShow(true, true)
      end
    else
      ExtractionEnchantStone_WindowClose()
      InventoryWindow_Close()
      if true == _ContentsGroup_NewUI_Equipment_All then
        PaGlobalFunc_Equipment_All_Close(false)
      else
        EquipmentWindow_Close()
      end
    end
    PaGlobal_TutorialManager:handleClickExtractionEnchantStoneButton(Panel_Window_Extraction_EnchantStone:GetShow())
  else
    if nil ~= Panel_Window_Extraction_EnchantStone_All and false == Panel_Window_Extraction_EnchantStone_All:GetShow() then
      PaGlobal_Extraction_Crystal_All_Close()
      PaGlobal_Extraction_Costume_All_Close()
      PaGlobal_Extraction_Caphras_All_Close()
      PaGlobal_Extraction_System_All_Close()
      PaGlobal_Extraction_Blackstone_All_Open()
    else
      PaGlobal_Extraction_Blackstone_All_Close()
      InventoryWindow_Close()
      if true == _ContentsGroup_NewUI_Equipment_All then
        PaGlobalFunc_Equipment_All_Close(false)
      else
        EquipmentWindow_Close()
      end
    end
    PaGlobal_TutorialManager:handleClickExtractionEnchantStoneButton(Panel_Window_Extraction_EnchantStone_All:GetShow())
  end
  if false == PaGlobal_Extraction_All._isConsole then
    PaGlobal_Extraction_All._ui.stc_selectLine:SetShow(true)
    local posX = PaGlobal_Extraction_All._ui.btn_enchantStone:GetPosX() + PaGlobal_Extraction_All._ui.btn_enchantStone:GetSizeX() * 0.25
    PaGlobal_Extraction_All._ui.stc_selectLine:SetPosX(posX)
  end
end
function HandleEventLUp_Extraction_All_Button_ExtractionCloth_Click()
  if false == _ContentsGroup_NewUI_BlackSmith_All then
    if false == PaGlobal_ExtractionCloth:getShow() then
      Socket_ExtractionCrystal_WindowClose()
      PaGlobal_ExtractionCaphras_Close()
      ExtractionEnchantStone_WindowClose()
      PaGlobal_ExtractionSystem_ForceClose()
      ExtractionCloth_WindowOpen()
      if true == _ContentsGroup_NewUI_Equipment_All then
        Panel_Window_Equipment_All:SetShow(true, true)
      else
        Panel_Equipment:SetShow(true, true)
      end
    else
      ExtractionCloth_WindowClose()
      InventoryWindow_Close()
      if true == _ContentsGroup_NewUI_Equipment_All then
        PaGlobalFunc_Equipment_All_Close(false)
      else
        EquipmentWindow_Close()
      end
    end
    PaGlobal_TutorialManager:handleClickExtractionClothButton(PaGlobal_ExtractionCloth:getShow())
  else
    if nil ~= Panel_Window_Extraction_Costume_All and false == Panel_Window_Extraction_Costume_All:GetShow() then
      PaGlobal_Extraction_Crystal_All_Close()
      PaGlobal_Extraction_Caphras_All_Close()
      PaGlobal_Extraction_Blackstone_All_Close()
      PaGlobal_Extraction_System_All_Close()
      PaGlobal_Extraction_Costume_All_Open()
      InventoryWindow_Close()
      if true == _ContentsGroup_NewUI_Equipment_All then
        PaGlobalFunc_Equipment_All_Close(false)
      else
        EquipmentWindow_Close()
      end
    else
      PaGlobal_Extraction_Costume_All_Close()
      InventoryWindow_Close()
      if true == _ContentsGroup_NewUI_Equipment_All then
        PaGlobalFunc_Equipment_All_Close(false)
      else
        EquipmentWindow_Close()
      end
    end
    PaGlobal_TutorialManager:handleClickExtractionClothButton(Panel_Window_Extraction_Costume_All:GetShow())
  end
  if false == PaGlobal_Extraction_All._isConsole then
    PaGlobal_Extraction_All._ui.stc_selectLine:SetShow(true)
    local posX = PaGlobal_Extraction_All._ui.btn_cloth:GetPosX() + PaGlobal_Extraction_All._ui.btn_cloth:GetSizeX() * 0.25
    PaGlobal_Extraction_All._ui.stc_selectLine:SetPosX(posX)
  end
end
function HandleEventLUp_Extraction_All_Button_ExtractionSystem_Click()
  if false == _ContentsGroup_NewUI_BlackSmith_All then
    if false == Panel_Window_ExtractionSystem:GetShow() then
      Socket_ExtractionCrystal_WindowClose()
      PaGlobal_ExtractionCaphras_Close()
      ExtractionEnchantStone_WindowClose()
      ExtractionCloth_WindowClose()
      PaGlobal_ExtractionSystem_ForceOpen()
      InventoryWindow_Show()
      if true == _ContentsGroup_NewUI_Equipment_All then
        Panel_Window_Equipment_All:SetShow(true, true)
      else
        Panel_Equipment:SetShow(true, true)
      end
    else
      PaGlobal_ExtractionSystem_ForceClose()
      InventoryWindow_Close()
      if true == _ContentsGroup_NewUI_Equipment_All then
        PaGlobalFunc_Equipment_All_Close(false)
      else
        EquipmentWindow_Close()
      end
    end
  elseif nil ~= Panel_Window_Extraction_System_All and false == Panel_Window_Extraction_System_All:GetShow() then
    PaGlobal_Extraction_Crystal_All_Close()
    PaGlobal_Extraction_Costume_All_Close()
    PaGlobal_Extraction_Caphras_All_Close()
    PaGlobal_Extraction_Blackstone_All_Close()
    InventoryWindow_Close()
    if true == _ContentsGroup_NewUI_Equipment_All then
      PaGlobalFunc_Equipment_All_Close(false)
    else
      EquipmentWindow_Close()
    end
    PaGlobal_Extraction_System_All_Open()
  else
    PaGlobal_Extraction_System_All_Close()
  end
  if false == PaGlobal_Extraction_All._isConsole then
    PaGlobal_Extraction_All._ui.stc_selectLine:SetShow(true)
    local posX = PaGlobal_Extraction_All._ui.btn_system:GetPosX() + PaGlobal_Extraction_All._ui.btn_system:GetSizeX() * 0.25
    PaGlobal_Extraction_All._ui.stc_selectLine:SetPosX(posX)
  end
end
function FromClient_PaGlobal_Extraction_All_ReSizePanel()
  if nil == Panel_Window_Extraction_All then
    return
  end
  PaGlobal_Extraction_All._screenX = getScreenSizeX()
  PaGlobal_Extraction_All._screenY = getScreenSizeY()
  Panel_Window_Extraction_All:SetSize(PaGlobal_Extraction_All._screenX, Panel_Window_Extraction_All:GetSizeY())
  Panel_Window_Extraction_All:ComputePos()
  if ToClient_IsContentsGroupOpen("1006") or ToClient_IsContentsGroupOpen("1007") or isGameServiceTypeConsole() then
    PaGlobal_Extraction_All._ui.btn_enchantStone:ComputePos()
    PaGlobal_Extraction_All._ui.btn_system:ComputePos()
    PaGlobal_Extraction_All._ui.btn_cloth:ComputePos()
    PaGlobal_Extraction_All._ui.btn_crystal:ComputePos()
    PaGlobal_Extraction_All._ui.btn_caphras:ComputePos()
    PaGlobal_Extraction_All._ui.stc_selectLine:ComputePos()
    PaGlobal_Extraction_All._ui.btn_cloth:SetShow(true)
  else
    PaGlobal_Extraction_All._ui.btn_enchantStone:SetPosX(PaGlobal_Extraction_All._screenX * 0.5 - PaGlobal_Extraction_All._ui.btn_enchantStone:GetSizeX() * 0.5 - 10)
    PaGlobal_Extraction_All._ui.btn_caphras:SetPosX(PaGlobal_Extraction_All._screenX * 0.5 - PaGlobal_Extraction_All._ui.btn_caphras:GetSizeX() * 0.5 - 10)
    PaGlobal_Extraction_All._ui.btn_crystal:SetPosX(PaGlobal_Extraction_All._screenX * 0.5 + PaGlobal_Extraction_All._ui.btn_crystal:GetSizeX() * 0.5 + 10)
    PaGlobal_Extraction_All._ui.btn_system:SetPosX(PaGlobal_Extraction_All._screenX * 0.5 + PaGlobal_Extraction_All._ui.btn_system:GetSizeX() * 0.5 + 10)
    PaGlobal_Extraction_All._ui.btn_cloth:SetShow(false)
  end
  if true == _ContentsGroup_ReformStoneExtract then
    PaGlobal_Extraction_All._ui.btn_system:SetShow(true)
  else
    PaGlobal_Extraction_All._ui.btn_system:SetShow(false)
  end
  if true == _ContentsGroup_Caphras then
    PaGlobal_Extraction_All._ui.btn_caphras:SetShow(true)
  else
    PaGlobal_Extraction_All._ui.btn_caphras:SetShow(false)
  end
  PaGlobal_Extraction_All._ui.btn_exit:ComputePos()
  PaGlobal_Extraction_All:BottomButtonPosition()
  if false == _ContentsGroup_UsePadSnapping then
    local equipmentPanel
    if true == _ContentsGroup_NewUI_Equipment_All then
      equipmentPanel = Panel_Window_Equipment_All
    else
      equipmentPanel = Panel_Equipment
    end
    if true == equipmentPanel:IsShow() then
      if nil ~= Panel_Window_Inventory and true == Panel_Window_Inventory:GetShow() or nil ~= Panel_Window_Inventory_All and true == Panel_Window_Inventory_All:GetShow() then
        if true == _ContentsGroup_NewUI_Equipment_All then
          PaGlobalFunc_Equipment_All_BesideInvenPos()
        else
          Equipment_BesideInvenPos()
        end
      else
        equipmentPanel:SetPosX(10)
        equipmentPanel:SetPosY(PaGlobal_Extraction_All._screenY - PaGlobal_Extraction_All._screenY * 0.5 - equipmentPanel:GetSizeY() * 0.5)
      end
    end
  end
end
function PaGlobal_Extraction_All_GetExtractionButtonEnchantStone()
  return PaGlobal_Extraction_All._ui.btn_enchantStone
end
function PaGlobal_Extraction_All_GetExtractionButtonCaphras()
  return PaGlobal_Extraction_All._ui.btn_caphras
end
function PaGlobal_Extraction_All_GetExtractionButtonCrystal()
  return PaGlobal_Extraction_All._ui.btn_crystal
end
function PaGlobal_Extraction_All_GetExtractionButtonCloth()
  return PaGlobal_Extraction_All._ui.btn_cloth
end
function PaGlobal_Extraction_All_ShowAni()
  if nil == Panel_Window_Extraction_All then
    return
  end
end
function PaGlobal_Extraction_All_HideAni()
  if nil == Panel_Window_Extraction_All then
    return
  end
end
