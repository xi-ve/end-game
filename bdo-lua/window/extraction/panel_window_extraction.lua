local UI_ANI_ADV = CppEnums.PAUI_ANIM_ADVANCE_TYPE
local UI_color = Defines.Color
Panel_Window_Extraction:SetShow(false, false)
Panel_Window_Extraction:setMaskingChild(true)
Panel_Window_Extraction:ActiveMouseEventEffect(true)
Panel_Window_Extraction:RegisterShowEventFunc(true, "ExtractionShowAni()")
Panel_Window_Extraction:RegisterShowEventFunc(false, "ExtractionHideAni()")
function ExtractionShowAni()
end
function ExtractionHideAni()
end
PaGlobal_Extraction = {
  _screenX = nil,
  _screenY = nil,
  _extractionBG = UI.getChildControl(Panel_Window_Extraction, "ExtractionBackGround"),
  _buttonExtraction_EnchantStone = UI.getChildControl(Panel_Window_Extraction, "Button_Extraction_EnchantStone"),
  _buttonExtraction_Caphras = UI.getChildControl(Panel_Window_Extraction, "Button_Extraction_Caphras"),
  _buttonExtraction_Crystal = UI.getChildControl(Panel_Window_Extraction, "Button_Extraction_Crystal"),
  _buttonExtraction_Cloth = UI.getChildControl(Panel_Window_Extraction, "Button_Extraction_Cloth"),
  _buttonExtractionExit = UI.getChildControl(Panel_Window_Extraction, "Button_Exit"),
  _buttonExtraction_System = UI.getChildControl(Panel_Window_Extraction, "Button_Extraction_System")
}
function PaGlobal_Extraction:getExtractionButtonEnchantStone()
  return self._buttonExtraction_EnchantStone
end
function PaGlobal_Extraction:getExtractionButtonCaphras()
  return self._buttonExtraction_Caphras
end
function PaGlobal_Extraction:getExtractionButtonCrystal()
  return self._buttonExtraction_Crystal
end
function PaGlobal_Extraction:getExtractionButtonCloth()
  return self._buttonExtraction_Cloth
end
function PaGlobal_Extraction:initialize()
  self._extractionBG:setGlassBackground(true)
  self._extractionBG:SetShow(true)
  self._buttonExtraction_EnchantStone:SetShow(true)
  self._buttonExtraction_Caphras:SetShow(true)
  self._buttonExtraction_Crystal:SetShow(true)
  self._buttonExtraction_System:SetShow(true)
  self._buttonExtractionExit:SetShow(true)
  self._buttonExtraction_System:SetTextMode(__eTextMode_AutoWrap)
  self._buttonExtraction_System:SetText(self._buttonExtraction_System:GetText())
  self._buttonExtraction_EnchantStone:addInputEvent("Mouse_LUp", "PaGlobal_Extraction:button_ExtractionEnchantStone_Click()")
  self._buttonExtraction_Caphras:addInputEvent("Mouse_LUp", "PaGlobal_Extraction:button_ExtractionCaphras_Click()")
  self._buttonExtraction_Crystal:addInputEvent("Mouse_LUp", "PaGlobal_Extraction:button_ExtractionCrystal_Click()")
  self._buttonExtraction_Cloth:addInputEvent("Mouse_LUp", "PaGlobal_Extraction:button_ExtractionCloth_Click()")
  self._buttonExtraction_System:addInputEvent("Mouse_LUp", "PaGlobal_Extraction:button_ExtractionSystem_Click()")
  self._buttonExtractionExit:addInputEvent("Mouse_LUp", "PaGlobal_Extraction:openPanel( false )")
end
registerEvent("onScreenResize", "Extraction_Resize")
function PaGlobal_Extraction:extraction_BtnResize()
  local btnEnchantStoneSizeX = self._buttonExtraction_EnchantStone:GetSizeX() + 23
  local btnEnchantStoneTextPosX = btnEnchantStoneSizeX - btnEnchantStoneSizeX / 2 - self._buttonExtraction_EnchantStone:GetTextSizeX() / 2
  local btnCrystalSizeX = self._buttonExtraction_Crystal:GetSizeX() + 23
  local btnCrystalTextPosX = btnCrystalSizeX - btnCrystalSizeX / 2 - self._buttonExtraction_Crystal:GetTextSizeX() / 2
  local btnClothSizeX = self._buttonExtraction_Cloth:GetSizeX() + 23
  local btnClothTextPosX = btnClothSizeX - btnClothSizeX / 2 - self._buttonExtraction_Cloth:GetTextSizeX() / 2
  local btnExtractionSystemPosX = self._buttonExtraction_System:GetSizeX() + 23
  local btnExtractionSystemTextPosX = btnExtractionSystemPosX - btnExtractionSystemPosX / 2 - self._buttonExtraction_System:GetTextSizeX() / 2
  local btnExitSizeX = self._buttonExtractionExit:GetSizeX() + 23
  local btnExitTextPosX = btnExitSizeX - btnExitSizeX / 2 - self._buttonExtractionExit:GetTextSizeX() / 2
  self._buttonExtraction_EnchantStone:SetTextSpan(btnEnchantStoneTextPosX, 5)
  self._buttonExtraction_Crystal:SetTextSpan(btnCrystalTextPosX, 5)
  self._buttonExtraction_Cloth:SetTextSpan(btnClothTextPosX, 5)
  self._buttonExtraction_System:SetTextSpan(btnExtractionSystemTextPosX, 5)
  self._buttonExtractionExit:SetTextSpan(btnExitTextPosX, 5)
end
function Extraction_Resize()
  local self = PaGlobal_Extraction
  self._screenX = getScreenSizeX()
  self._screenY = getScreenSizeY()
  Panel_Window_Extraction:SetSize(self._screenX, Panel_Window_Extraction:GetSizeY())
  Panel_Window_Extraction:ComputePos()
  self._extractionBG:SetSize(self._screenX, self._extractionBG:GetSizeY())
  self._extractionBG:ComputePos()
  if ToClient_IsContentsGroupOpen("1006") or ToClient_IsContentsGroupOpen("1007") then
    self._buttonExtraction_EnchantStone:ComputePos()
    self._buttonExtraction_Caphras:ComputePos()
    self._buttonExtraction_Crystal:ComputePos()
    self._buttonExtraction_Cloth:ComputePos()
    self._buttonExtraction_System:ComputePos()
    self._buttonExtraction_Cloth:SetShow(true)
  else
    self._buttonExtraction_EnchantStone:SetPosX(getScreenSizeX() / 2 - self._buttonExtraction_EnchantStone:GetSizeX() / 2 - 10)
    self._buttonExtraction_Caphras:SetPosX(getScreenSizeX() / 2 - self._buttonExtraction_Caphras:GetSizeX() / 2 - 10)
    self._buttonExtraction_Crystal:SetPosX(getScreenSizeX() / 2 + self._buttonExtraction_Crystal:GetSizeX() / 2 + 10)
    self._buttonExtraction_System:SetPosX(getScreenSizeX() / 2 + self._buttonExtraction_System:GetSizeX() / 2 + 10)
    self._buttonExtraction_Cloth:SetShow(false)
  end
  if true == _ContentsGroup_ReformStoneExtract then
    self._buttonExtraction_System:SetShow(true)
  else
    self._buttonExtraction_System:SetShow(false)
  end
  if _ContentsGroup_Caphras then
    self._buttonExtraction_Caphras:SetShow(true)
  else
    self._buttonExtraction_Caphras:SetShow(false)
  end
  self._buttonExtractionExit:ComputePos()
  PaGlobal_Extraction:BottomButtonPosition()
  if true == _ContentsGroup_NewUI_Equipment_All then
    if true == Panel_Window_Equipment_All:IsShow() then
      Panel_Window_Equipment_All:SetPosX(10)
      Panel_Window_Equipment_All:SetPosY(getScreenSizeY() - getScreenSizeY() / 2 - Panel_Window_Equipment_All:GetSizeY() / 2)
    end
  elseif true == Panel_Equipment:IsShow() then
    Panel_Equipment:SetPosX(10)
    Panel_Equipment:SetPosY(getScreenSizeY() - getScreenSizeY() / 2 - Panel_Equipment:GetSizeY() / 2)
  end
end
function PaGlobal_Extraction:BottomButtonPosition()
  local btnCount = 0
  local btnTable = {}
  btnTable[0] = self._buttonExtraction_EnchantStone
  btnTable[1] = self._buttonExtraction_Caphras
  btnTable[2] = self._buttonExtraction_Crystal
  btnTable[3] = self._buttonExtraction_Cloth
  btnTable[4] = self._buttonExtraction_System
  btnTable[5] = self._buttonExtractionExit
  if self._buttonExtraction_EnchantStone:GetShow() then
    btnCount = btnCount + 1
  end
  if self._buttonExtraction_Caphras:GetShow() then
    btnCount = btnCount + 1
  end
  if self._buttonExtraction_Crystal:GetShow() then
    btnCount = btnCount + 1
  end
  if self._buttonExtraction_Cloth:GetShow() then
    btnCount = btnCount + 1
  end
  if self._buttonExtraction_System:GetShow() then
    btnCount = btnCount + 1
  end
  if self._buttonExtractionExit:GetShow() then
    btnCount = btnCount + 1
  end
  local sizeX = getScreenSizeX()
  local funcButtonCount = btnCount
  local buttonSize = btnTable[0]:GetSizeX()
  local buttonGap = 10
  local startPosX = (sizeX - (buttonSize * funcButtonCount + buttonGap * (funcButtonCount - 1))) / 2
  local posX = 0
  local jindex = 0
  for index = 0, 5 do
    if btnTable[index]:GetShow() then
      posX = startPosX + (buttonSize + buttonGap) * jindex
      jindex = jindex + 1
    end
    btnTable[index]:SetPosX(posX)
  end
end
function PaGlobal_Extraction:togglePanel()
  if false == Panel_Window_Extraction:GetShow() then
    PaGlobal_Extraction:openPanel(true)
  else
    PaGlobal_Extraction:openPanel(false)
  end
end
function PaGlobal_Extraction:openPanel(isShow)
  if true == isShow then
    SetUIMode(Defines.UIMode.eUIMode_Extraction)
    if true == _ContentsGroup_NewUI_Dialog_All then
      PaGlobalFunc_DialogMain_All_SetIgnoreShowDialog(true)
    elseif true == _ContentsGroup_RenewUI_Dailog then
      PaGlobalFunc_MainDialog_setIgnoreShowDialog(true)
    else
      setIgnoreShowDialog(true)
    end
    UIAni.fadeInSCR_Down(Panel_Window_Extraction)
    if not _ContentsGroup_RenewUI_InventoryEquip then
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
  else
    SetUIMode(Defines.UIMode.eUIMode_NpcDialog)
    if true == _ContentsGroup_NewUI_Dialog_All then
      PaGlobalFunc_DialogMain_All_SetIgnoreShowDialog(false)
    elseif true == _ContentsGroup_RenewUI_Dailog then
      PaGlobalFunc_MainDialog_setIgnoreShowDialog(false)
    else
      setIgnoreShowDialog(false)
    end
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
    if not _ContentsGroup_RenewUI_InventoryEquip then
      if true == _ContentsGroup_NewUI_Equipment_All then
        PaGlobalFunc_Equipment_All_PosLoad()
        Panel_Window_Equipment_All:SetShow(false, false)
      else
        Equipment_PosLoadMemory()
        Panel_Equipment:SetShow(false, false)
      end
    end
    if true == _ContentsGroup_NewUI_ClothInventory_All or true == _ContentsGroup_RenewUI then
      PaGlobalFunc_ClothInventory_All_Close()
    else
      ClothInventory_Close()
    end
  end
  if true == _ContentsGroup_NewUI_Dialog_All then
    PaGlobalFunc_DialogMain_All_ShowToggle(not isShow)
  else
    Panel_Npc_Dialog:SetShow(not isShow)
  end
  Panel_Window_Extraction:SetShow(isShow, false)
  PaGlobal_Extraction:extraction_BtnResize()
  PaGlobal_TutorialManager:handleOpenExtractionPanel(isShow)
  PaGlobal_Extraction:BottomButtonPosition()
end
function PaGlobal_Extraction:button_ExtractionCrystal_Click()
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
end
function PaGlobal_Extraction:button_ExtractionCaphras_Click()
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
end
function PaGlobal_Extraction:button_ExtractionEnchantStone_Click()
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
end
function PaGlobal_Extraction:button_ExtractionCloth_Click()
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
end
function PaGlobal_Extraction:button_ExtractionSystem_Click()
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
end
PaGlobal_Extraction:initialize()
