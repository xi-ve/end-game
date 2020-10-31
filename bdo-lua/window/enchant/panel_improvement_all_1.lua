function PaGlobal_Improvement_All:initialize()
  if true == PaGlobal_Improvement_All._initialize then
    return
  end
  self._isConsole = _ContentsGroup_UsePadSnapping
  self:controlAll_Init()
  self:controlPc_Init()
  self:controlConsole_Init()
  self:controlSetShow()
  PaGlobal_Improvement_All:registEventHandler()
  PaGlobal_Improvement_All:validate()
  PaGlobal_Improvement_All._initialize = true
end
function PaGlobal_Improvement_All:controlAll_Init()
  if nil == Panel_Window_Improvement_All then
    return
  end
  Panel_Window_Improvement_All:setMaskingChild(true)
  Panel_Window_Improvement_All:setGlassBackground(true)
  Panel_Window_Improvement_All:SetDragEnable(true)
  Panel_Window_Improvement_All:SetDragAll(true)
  self._ui.stc_titleBar = UI.getChildControl(Panel_Window_Improvement_All, "Static_TitleBar")
  self._ui.stc_leftBg = UI.getChildControl(Panel_Window_Improvement_All, "Static_GuideNSlot")
  self._ui.txt_desc = UI.getChildControl(self._ui.stc_leftBg, "StaticText_Text")
  self._ui.stc_decoLine = UI.getChildControl(self._ui.stc_leftBg, "Static_DecoLine")
  self._ui.stc_improveBg = UI.getChildControl(self._ui.stc_leftBg, "Static_ImprovementSlot")
  self._ui.stc_enchantItemSlot = UI.getChildControl(self._ui.stc_improveBg, "Static_Slot1")
  self._ui.stc_equipItemSlot = UI.getChildControl(self._ui.stc_improveBg, "Static_Slot2")
  self._ui.txt_result = UI.getChildControl(self._ui.stc_improveBg, "StaticText_Result")
  self._ui.stc_leftBtnBg = UI.getChildControl(Panel_Window_Improvement_All, "Static_Button")
  self._ui.chk_skipAni = UI.getChildControl(self._ui.stc_leftBtnBg, "CheckButton_CheckButton")
  self._ui.txt_itemListTitle = UI.getChildControl(Panel_Window_Improvement_All, "StaticText_ItemListTitle")
  self._ui.stc_itemListBg = UI.getChildControl(Panel_Window_Improvement_All, "Static_ItemList")
  self._ui.list2_item = UI.getChildControl(self._ui.stc_itemListBg, "List2_ItemList")
  local listContent = UI.getChildControl(self._ui.list2_item, "List2_1_Content")
  local btn_list = UI.getChildControl(listContent, "RadioButton_EquipList")
  local itemlistSlot = UI.getChildControl(btn_list, "Static_EquipListSlot")
  local itemSlot = {}
  SlotItem.new(itemSlot, "Improve_All_ItemSlot_", 0, itemlistSlot, self._slotConfig)
  itemSlot:createChild()
  itemSlot.empty = true
  itemSlot:clearItem()
  itemSlot.icon:SetPosX(1)
  itemSlot.icon:SetPosY(1)
  itemSlot.border:SetSize(44, 44)
  self._ui._vscroll = self._ui.list2_item:GetVScroll()
  self._ui.txt_enchantItemListTitle = UI.getChildControl(Panel_Window_Improvement_All, "StaticText_EnchantItemListText")
  self._ui.stc_enchantItemListBg = UI.getChildControl(Panel_Window_Improvement_All, "Static_EnchantItemList")
  self._ui.list2_enchantItem = UI.getChildControl(self._ui.stc_enchantItemListBg, "List2_1")
  local m_listContent = UI.getChildControl(self._ui.list2_enchantItem, "List2_1_Content")
  local m_btn_list = UI.getChildControl(m_listContent, "RadioButton_EnchantItemList")
  local m_itemlistSlot = UI.getChildControl(m_btn_list, "Static_EnchantItemSlot")
  local m_itemSlot = {}
  SlotItem.new(m_itemSlot, "Improve_All_MaterialSlot_", 0, m_itemlistSlot, self._slotConfig)
  m_itemSlot:createChild()
  m_itemSlot.empty = true
  m_itemSlot:clearItem()
  m_itemSlot.icon:SetPosX(1)
  m_itemSlot.icon:SetPosY(1)
  m_itemSlot.border:SetSize(44, 44)
  SlotItem.new(self._equipSlot, "Improvement_All_EquipSlot", 0, self._ui.stc_equipItemSlot, self._slotConfig)
  self._equipSlot:createChild()
  self._equipSlot.icon:SetPosX(-1)
  self._equipSlot.icon:SetPosY(-1)
  self._equipSlot.icon:addInputEvent("Mouse_On", "")
  self._equipSlot.icon:addInputEvent("Mouse_Out", "")
  self._equipSlot.icon:addInputEvent("Mouse_RUp", "")
  SlotItem.new(self._materialSlot, "Improvement_All_MaterialSlot", 0, self._ui.stc_enchantItemSlot, self._slotConfig)
  self._materialSlot:createChild()
  self._materialSlot.icon:SetPosX(-1)
  self._materialSlot.icon:SetPosY(-1)
  self._materialSlot.icon:addInputEvent("Mouse_On", "")
  self._materialSlot.icon:addInputEvent("Mouse_Out", "")
  self._materialSlot.icon:addInputEvent("Mouse_RUp", "")
  self._ui.chk_skipAni:SetCheck(false)
  self._ui.txt_desc:SetTextMode(__eTextMode_AutoWrap)
  self._ui.txt_desc:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_IMPROVEMENT_DESC"))
  self._ui.txt_noItem = UI.getChildControl(self._ui.stc_itemListBg, "StaticText_NoItemDesc")
  self._ui.txt_noImprovement = UI.getChildControl(self._ui.stc_enchantItemListBg, "StaticText_NoItemDesc")
  if true == _ContentsGroup_Media then
    for index = 5, 8 do
      self._materialItemCount = self._materialItemCount + 1
      self._useMaterialItemKey[self._materialItemCount] = self._materialItemKey[index]
    end
  end
  if true == _ContentsGroup_Dragan and true == _ContentsGroup_DriganBossDragon then
    self._materialItemCount = self._materialItemCount + 1
    self._useMaterialItemKey[self._materialItemCount] = self._materialItemKey[9]
  end
end
function PaGlobal_Improvement_All:controlPc_Init()
  if nil == Panel_Window_Improvement_All then
    return
  end
  self._ui_pc.btn_closeIcon = UI.getChildControl(self._ui.stc_titleBar, "Static_CloseIcon")
  self._ui_pc.btn_enchant = UI.getChildControl(self._ui.stc_leftBtnBg, "Button_EnchantButton")
end
function PaGlobal_Improvement_All:controlConsole_Init()
  if nil == Panel_Window_Improvement_All then
    return
  end
  self._ui_console.stc_enchantY = UI.getChildControl(self._ui.stc_leftBtnBg, "StaticText_EnchantButton_C")
  self._ui_console.stc_guideBg = UI.getChildControl(Panel_Window_Improvement_All, "Static_ConsoleKeyGuide")
  self._ui_console.stc_guideSelect = UI.getChildControl(self._ui_console.stc_guideBg, "StaticText_SelectButton_C")
  self._ui_console.stc_guideCancle = UI.getChildControl(self._ui_console.stc_guideBg, "StaticText_CancelButton_C")
  self._ui_console.stc_guideDetail = UI.getChildControl(self._ui_console.stc_guideBg, "StaticText_DetailButton_C")
end
function PaGlobal_Improvement_All:controlSetShow()
  if nil == Panel_Window_Improvement_All then
    return
  end
  if false == self._isConsole then
    for _, v in pairs(self._ui_pc) do
      v:SetShow(true)
    end
    for _, v in pairs(self._ui_console) do
      v:SetShow(false)
    end
  else
    for _, v in pairs(self._ui_pc) do
      v:SetShow(false)
    end
    for _, v in pairs(self._ui_console) do
      v:SetShow(true)
    end
  end
  self._ui.txt_result:SetShow(false)
end
function PaGlobal_Improvement_All:prepareOpen()
  if nil == Panel_Window_Improvement_All then
    return
  end
  self._equipListCount = 0
  self._indexInvenEnd = -1
  self._materialListCount = -1
  self._equipSlotNo = -1
  self._materialSlotNo = -1
  getImproveInformation():clearData()
  self._equipSlot:clearItem()
  self._materialSlot:clearItem()
  self._ui.chk_skipAni:SetCheck(false)
  self._ui.list2_item:moveTopIndex()
  Panel_Npc_Dialog_All:ignorePadSnapMoveToOtherPanelUpdate(true)
  Panel_Window_Improvement_All:RegisterUpdateFunc("FromeClient_ImprovementAll_UpdateFuncDoingImprove")
  PaGlobal_Improvement_All:update()
  PaGlobal_Improvement_All:open()
  PaGlobal_Improvement_All:resize()
  audioPostEvent_SystemUi(1, 0)
  _AudioPostEvent_SystemUiForXBOX(1, 0)
end
function PaGlobal_Improvement_All:open()
  if nil == Panel_Window_Improvement_All then
    return
  end
  Panel_Window_Improvement_All:SetShow(true)
end
function PaGlobal_Improvement_All:prepareClose()
  if nil == Panel_Window_Improvement_All then
    return
  end
  if true == PaGlobal_Improvement_All_IsImprovementing() then
    HandleEventLUp_Improvement_All_DoImprove()
  end
  HandleEventRUp_Improvement_All_SlotInit()
  Panel_Npc_Dialog_All:ignorePadSnapMoveToOtherPanelUpdate(false)
  self._doImprove = false
  self._doAnimation = false
  ToClient_BlackspiritEnchantClose()
  Panel_Window_Improvement_All:ClearUpdateLuaFunc()
  PaGlobal_Improvement_All:close()
end
function PaGlobal_Improvement_All:close()
  if nil == Panel_Window_Improvement_All then
    return
  end
  Panel_Window_Improvement_All:SetShow(false)
end
function PaGlobal_Improvement_All:update()
  if nil == Panel_Window_Improvement_All then
    return
  end
  getImproveInformation():clearData()
  self._equipSlot:clearItem()
  self._materialSlot:clearItem()
  self:updateEquipList()
  self:updateBaseMaterialList()
end
function PaGlobal_Improvement_All:registEventHandler()
  if nil == Panel_Window_Improvement_All then
    return
  end
  registerEvent("FromClient_ResponseImporve", "FromClient_Improvement_All_ResponseImprove")
  registerEvent("FromClient_InventoryUpdate", "FromClient_Improvement_All_UpdateItemList")
  registerEvent("EventEquipmentUpdate", "FromClient_Improvement_All_UpdateItemList")
  if true == self._isConsole then
    Panel_Window_Improvement_All:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "HandleEventLUp_Improvement_All_DoImprove()")
  else
    self._ui.chk_skipAni:addInputEvent("Mouse_On", "HandleEventOnOut_Improvement_All_AniSkipToolTip(true)")
    self._ui.chk_skipAni:addInputEvent("Mouse_Out", "HandleEventOnOut_Improvement_All_AniSkipToolTip(false)")
    self._ui_pc.btn_closeIcon:addInputEvent("Mouse_LUp", "PaGlobalFunc_Improvement_All_Close()")
    self._ui_pc.btn_enchant:addInputEvent("Mouse_LUp", "HandleEventLUp_Improvement_All_DoImprove()")
  end
  self._ui.list2_item:registEvent(__ePAUIList2EventType_LuaChangeContent, "PaGlobalFunc_Improvement_All_UpdateEquipList")
  self._ui.list2_item:createChildContent(__ePAUIList2ElementManagerType_List)
  self._ui.list2_enchantItem:registEvent(__ePAUIList2EventType_LuaChangeContent, "PaGlobalFunc_Improvement_All_UpdateMaterialList")
  self._ui.list2_enchantItem:createChildContent(__ePAUIList2ElementManagerType_List)
end
function PaGlobal_Improvement_All:validate()
  if nil == Panel_Window_Improvement_All then
    return
  end
  self._ui.stc_titleBar:isValidate()
  self._ui.stc_leftBg:isValidate()
  self._ui.txt_desc:isValidate()
  self._ui.stc_decoLine:isValidate()
  self._ui.stc_improveBg:isValidate()
  self._ui.stc_enchantItemSlot:isValidate()
  self._ui.stc_equipItemSlot:isValidate()
  self._ui.txt_result:isValidate()
  self._ui.stc_leftBtnBg:isValidate()
  self._ui.chk_skipAni:isValidate()
  self._ui.txt_itemListTitle:isValidate()
  self._ui.stc_itemListBg:isValidate()
  self._ui.list2_item:isValidate()
  self._ui.txt_enchantItemListTitle:isValidate()
  self._ui.stc_enchantItemListBg:isValidate()
  self._ui.list2_enchantItem:isValidate()
  self._ui_pc.btn_closeIcon:isValidate()
  self._ui_pc.btn_enchant:isValidate()
  self._ui_console.stc_enchantY:isValidate()
  self._ui_console.stc_guideBg:isValidate()
  self._ui_console.stc_guideSelect:isValidate()
  self._ui_console.stc_guideCancle:isValidate()
  self._ui_console.stc_guideDetail:isValidate()
end
function PaGlobal_Improvement_All:resize()
  if nil == Panel_Window_Improvement_All then
    return
  end
  if true == _ContentsGroup_NewUI_Dialog_All and true == Panel_Npc_Dialog_All:GetShow() then
    Panel_Window_Improvement_All:SetPosY(Panel_Npc_Dialog_All:GetPosY() - Panel_Window_Improvement_All:GetSizeY() - 50)
  elseif false == _ContentsGroup_NewUI_Dialog_All and nil ~= Panel_Npc_Dialog and true == Panel_Npc_Dialog:GetShow() then
    Panel_Window_Improvement_All:SetPosY(Panel_Npc_Dialog:GetPosY() - Panel_Window_Improvement_All:GetSizeY() - 50)
  end
  Panel_Window_Improvement_All:SetSpanSize(0, -PaGlobalFunc_DialogMain_All_FunctionSizeY())
  Panel_Window_Improvement_All:ComputePos()
  self._ui.stc_leftBg:ComputePos()
  self._ui.stc_improveBg:ComputePos()
  self._ui.stc_leftBtnBg:ComputePos()
  self._ui.txt_itemListTitle:ComputePos()
  self._ui.stc_itemListBg:ComputePos()
  self._ui.list2_item:ComputePos()
  self._ui.txt_enchantItemListTitle:ComputePos()
  self._ui.stc_enchantItemListBg:ComputePos()
  self._ui.list2_enchantItem:ComputePos()
  local tempBtnGroup = {
    self._ui_console.stc_guideDetail,
    self._ui_console.stc_guideSelect,
    self._ui_console.stc_guideCancle
  }
  PaGlobalFunc_ConsoleKeyGuide_SetAlign(tempBtnGroup, self._ui_console.stc_guideBg, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP)
end
function PaGlobal_Improvement_All:updateEquipList()
  local selfPlayerWrapper = getSelfPlayer()
  if nil == selfPlayerWrapper then
    return
  end
  local selfPlayer = selfPlayerWrapper:get()
  local invenSize = selfPlayer:getInventorySlotCount(false)
  self._toIndex = self._ui.list2_item:getCurrenttoIndex()
  self._scrollValue = self._ui._vscroll:GetControlPos()
  self._ui.list2_item:getElementManager():clearKey()
  self._equipListCount = 0
  self._equipList = {}
  self._indexInvenEnd = -1
  for invenIdx = 0, invenSize - 1 do
    local itemWrapper = getInventoryItemByType(self._whereType, invenIdx)
    if nil ~= itemWrapper and true == self:filterImproveEquipItem(invenIdx, itemWrapper, self._whereType) then
      self._equipListCount = self._equipListCount + 1
      self._equipList[self._equipListCount] = invenIdx
      self._ui.list2_item:getElementManager():pushKey(toInt64(0, self._equipListCount))
    end
  end
  self._indexInvenEnd = self._equipListCount
  for equipIdx = CppEnums.EquipSlotNo.rightHand, CppEnums.EquipSlotNo.equipSlotNoCount do
    local itemWrapper = ToClient_getEquipmentItem(equipIdx)
    if nil ~= itemWrapper and true == self:filterImproveEquipItem(equipIdx, itemWrapper, self._whereType, true) then
      self._equipListCount = self._equipListCount + 1
      self._equipList[self._equipListCount] = equipIdx
      self._ui.list2_item:getElementManager():pushKey(toInt64(0, self._equipListCount))
    end
  end
  if self._equipListCount <= 0 then
    self._ui.txt_noItem:SetShow(true)
  else
    self._ui.txt_noItem:SetShow(false)
    self._ui.list2_item:setCurrenttoIndex(self._toIndex)
    if false == self._ui.list2_item:IsIgnoreVerticalScroll() then
      self._ui._vscroll:SetControlPos(self._scrollValue)
    end
  end
end
function PaGlobal_Improvement_All:filterImproveEquipItem(slotNo, itemWrapper, whereType, isEquip)
  if nil == itemWrapper then
    return false
  end
  if true == isEquip and true == ToClient_EquipSlot_CheckItemLock(slotNo, CppEnums.ItemWhereType.eEquip) then
    return false
  end
  if true == ToClient_Inventory_CheckItemLock(slotNo, whereType) then
    return false
  end
  local itemSSW = itemWrapper:getStaticStatus():get()
  return (itemSSW:isImprovable())
end
function PaGlobal_Improvement_All:updateBaseMaterialList()
  local selfPlayerWrapper = getSelfPlayer()
  if nil == selfPlayerWrapper then
    return
  end
  local selfPlayer = selfPlayerWrapper:get()
  local invenSize = selfPlayer:getInventorySlotCount(false)
  self._ui.list2_enchantItem:getElementManager():clearKey()
  self._materialList = {}
  self._materialListItemCount = {}
  self._itemCount = {}
  self._materialListCount = -1
  for invenIdx = 0, invenSize - 1 do
    local itemWrapper = getInventoryItemByType(self._whereType, invenIdx)
    if nil ~= itemWrapper then
      for m_index = 1, self._materialItemCount do
        local itemkey = itemWrapper:getStaticStatus():get()._key:getItemKey()
        local itemCount = Int64toInt32(itemWrapper:get():getCount_s64())
        if itemkey == self._useMaterialItemKey[m_index] then
          self._itemCount[m_index] = itemCount
          break
        end
      end
    end
  end
  for mIdx = 1, self._materialItemCount do
    self._materialListCount = self._materialListCount + 1
    self._materialList[self._materialListCount] = self._useMaterialItemKey[mIdx]
    self._materialListItemCount[self._materialListCount] = self._itemCount[mIdx]
    self._ui.list2_enchantItem:getElementManager():pushKey(toInt64(0, self._materialListCount))
  end
  self._ui.txt_noImprovement:SetShow(false)
  self._ui.list2_enchantItem:SetShow(true)
end
function PaGlobal_Improvement_All:updateInventoryMaterialList()
  local selfPlayerWrapper = getSelfPlayer()
  if nil == selfPlayerWrapper then
    return
  end
  local selfPlayer = selfPlayerWrapper:get()
  local invenSize = selfPlayer:getInventorySlotCount(false)
  if -1 ~= self._materialSlotNo then
    self._ui.list2_enchantItem:requestUpdateVisible()
    return
  end
  self._ui.list2_enchantItem:getElementManager():clearKey()
  self._materialList = {}
  self._materialListItemCount = {}
  self._materialListCount = -1
  for invenIdx = 0, invenSize - 1 do
    local itemWrapper = getInventoryItemByType(self._whereType, invenIdx)
    if nil ~= itemWrapper and true == self:filterImproveMaterialItem(invenIdx) then
      local itemkey = itemWrapper:getStaticStatus():get()._key:getItemKey()
      local itemCount = Int64toInt32(itemWrapper:get():getCount_s64())
      self._materialListCount = self._materialListCount + 1
      self._materialList[self._materialListCount] = invenIdx
      self._materialListItemCount[self._materialListCount] = itemCount
      self._ui.list2_enchantItem:getElementManager():pushKey(toInt64(0, self._materialListCount))
    end
  end
  if -1 >= self._materialListCount then
    self._ui.list2_enchantItem:SetShow(false)
    self._ui.txt_noImprovement:SetShow(true)
  else
    self._ui.list2_enchantItem:SetShow(true)
    self._ui.txt_noImprovement:SetShow(false)
  end
end
function PaGlobal_Improvement_All:filterImproveMaterialItem(slotNo)
  local returnValue = false
  if 0 ~= getImproveInformation():checkIsValidSubItem(slotNo) then
    returnValue = false
  else
    returnValue = true
    if CppEnums.ItemWhereType.eInventory ~= self._whereType then
      returnValue = false
    end
  end
  return returnValue
end
function PaGlobal_Improvement_All:convertFromItemGradeColor(nameColorGrade)
  if 0 == nameColorGrade then
    return 4293388263
  elseif 1 == nameColorGrade then
    return 4288921664
  elseif 2 == nameColorGrade then
    return 4283938018
  elseif 3 == nameColorGrade then
    return 4293904710
  elseif 4 == nameColorGrade then
    return 4294929482
  else
    return UI_color.C_FFFFFFFF
  end
end
