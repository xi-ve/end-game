function PaGlobal_Socket_All:initialize()
  if true == PaGlobal_Socket_All._initialize then
    return
  end
  self:controlAll_Init()
  self:controlPc_Init()
  self:controlConsole_Init()
  self:controlSetShow()
  PaGlobal_Socket_All:registEventHandler()
  PaGlobal_Socket_All:validate()
  PaGlobal_Socket_All._initialize = true
end
function PaGlobal_Socket_All:controlAll_Init()
  if nil == Panel_Window_Socket_All then
    return
  end
  self._ui.stc_titleBg = UI.getChildControl(Panel_Window_Socket_All, "Static_TitlebarArea")
  self._ui.stc_leftAreaBg = UI.getChildControl(Panel_Window_Socket_All, "Static_LeftMainArea")
  self._ui.stc_imageArea = UI.getChildControl(self._ui.stc_leftAreaBg, "Static_BottomImageArea")
  self._ui.stc_imagePartArea = UI.getChildControl(self._ui.stc_imageArea, "Static_ImagePartArea")
  self._ui.stc_extractArea = UI.getChildControl(self._ui.stc_imagePartArea, "Static_CrystalExtractImage")
  self._ui.stc_equipSlot = UI.getChildControl(self._ui.stc_extractArea, "Static_ExtractionHammerItemSlot")
  local itemSlot = {}
  SlotItem.new(itemSlot, "SocketEquip", 0, self._ui.stc_equipSlot, self._slotConfig)
  itemSlot:createChild()
  itemSlot.empty = true
  itemSlot:clearItem()
  itemSlot.border:SetSize(44, 44)
  self._equipItemSlotInfo.slot = itemSlot
  self._equipItemSlotInfo.slotNo = -1
  self._equipItemSlotInfo.empty = true
  self._ui.stc_crystalInfoBg = {}
  self._ui.stc_crystalSlotBg = {}
  for idx = 1, self._socketSlotCount do
    self._ui.stc_crystalInfoBg[idx] = UI.getChildControl(self._ui.stc_extractArea, "Button_CrystalInfo" .. idx)
    self._ui.stc_crystalSlotBg[idx] = UI.getChildControl(self._ui.stc_extractArea, "Static_CrystalItemSlotBG" .. idx)
  end
  for idx = 1, self._socketSlotCount do
    self._ui.stc_crystalInfo[idx] = {}
    self._ui.stc_crystalInfo[idx].name = UI.getChildControl(self._ui.stc_crystalInfoBg[idx], "StaticText_CrystalName")
    self._ui.stc_crystalInfo[idx].desc = UI.getChildControl(self._ui.stc_crystalInfoBg[idx], "StaticText_CrystalDesc")
    self._ui.stc_crystalInfo[idx].none = UI.getChildControl(self._ui.stc_crystalInfoBg[idx], "StaticText_CrystalNone")
    self._ui.stc_crystalInfo[idx].empty = true
    self._ui.stc_crystalSlot[idx] = UI.getChildControl(self._ui.stc_crystalSlotBg[idx], "Static_" .. idx)
    if true == self._isConsole then
      self._ui.stc_crystalSlot[idx]:ChangeOnTextureInfoName("Combine/Etc/Combine_Etc_Extract_UI_05.dds")
      local x1, y1, x2, y2 = setTextureUV_Func(self._ui.stc_crystalSlot[idx], 339, 181, 395, 237)
      self._ui.stc_crystalSlot[idx]:getOnTexture():setUV(x1, y1, x2, y2)
    end
    local crystalSlot = {}
    SlotItem.new(crystalSlot, "SocketCrystal_" .. tostring(idx), 0, self._ui.stc_crystalSlot[idx], self._slotConfig)
    crystalSlot:createChild()
    crystalSlot.empty = true
    crystalSlot:clearItem()
    crystalSlot.icon:SetPosX(1)
    crystalSlot.icon:SetPosY(1)
    crystalSlot.border:SetSize(44, 44)
    self._ui.stc_crystalInfo[idx].slot = crystalSlot
  end
  self._ui.stc_descArea = UI.getChildControl(self._ui.stc_leftAreaBg, "Static_BottomDescArea")
  self._ui.txt_desc = UI.getChildControl(self._ui.stc_descArea, "StaticText_LeftTopDesc")
  self._ui.txt_desc:SetTextMode(__eTextMode_AutoWrap)
  self._ui.txt_desc:SetText(self._ui.txt_desc:GetText())
  self._ui.stc_rightArea = UI.getChildControl(Panel_Window_Socket_All, "Static_RightTopArea")
  self._ui.stc_tabBg = UI.getChildControl(self._ui.stc_rightArea, "Static_TabTypeBg")
  self._ui.radio_tab = {}
  self._ui.radio_tab[self._TAB.EQUIPMENT] = UI.getChildControl(self._ui.stc_tabBg, "Radiobutton_Equipment")
  self._ui.radio_tab[self._TAB.CRYSCTAL] = UI.getChildControl(self._ui.stc_tabBg, "Radiobutton_Crystal")
  self._ui.stc_selectBar = UI.getChildControl(self._ui.stc_tabBg, "Static_SelectBar")
  self._ui.list2_item = UI.getChildControl(self._ui.stc_rightArea, "List2_ExtractableItemList")
  local listContent = UI.getChildControl(self._ui.list2_item, "List2_1_Content")
  local btn_list = UI.getChildControl(listContent, "RadioButton_ExtractableItem")
  local stc_itemSlotBg = UI.getChildControl(btn_list, "Static_ItemSlotBG")
  local itemlistSlot = UI.getChildControl(stc_itemSlotBg, "Static_ItemIcon")
  local slot = {}
  SlotItem.new(slot, "Socket_All_Slot_", 0, itemlistSlot, self._slotConfig)
  slot:createChild()
  slot.empty = true
  slot:clearItem()
  slot.icon:SetPosX(1)
  slot.icon:SetPosY(1)
  slot.border:SetSize(44, 44)
  self._ui._vscroll = self._ui.list2_item:GetVScroll()
end
function PaGlobal_Socket_All:controlPc_Init()
  if nil == Panel_Window_Socket_All then
    return
  end
  self._ui_pc.btn_question = UI.getChildControl(self._ui.stc_titleBg, "Button_Question")
  self._ui_pc.btn_close = UI.getChildControl(self._ui.stc_titleBg, "Button_Close")
  self._ui_pc.stc_LClick = UI.getChildControl(self._ui.stc_imageArea, "StaticText_LClick")
  self._ui_pc.stc_RClick = UI.getChildControl(self._ui.stc_imageArea, "StaticText_RClick")
end
function PaGlobal_Socket_All:controlConsole_Init()
  if nil == Panel_Window_Socket_All then
    return
  end
  self._ui_console.stc_guideBg = UI.getChildControl(Panel_Window_Socket_All, "Static_BottomConsoleButtons")
  self._ui_console.stc_iconLB = UI.getChildControl(self._ui.stc_tabBg, "Static_LB_ConsoleUI")
  self._ui_console.stc_iconRB = UI.getChildControl(self._ui.stc_tabBg, "Static_RB_ConsoleUI")
  self._ui_console.stc_select = UI.getChildControl(self._ui_console.stc_guideBg, "Button_Select")
  self._ui_console.stc_cancle = UI.getChildControl(self._ui_console.stc_guideBg, "Button_Cancel")
  self._ui_console.stc_detail = UI.getChildControl(self._ui_console.stc_guideBg, "Button_Detail")
  self._ui_console.stc_delete = UI.getChildControl(self._ui_console.stc_guideBg, "Button_Delete")
end
function PaGlobal_Socket_All:controlSetShow()
  if nil == Panel_Window_Socket_All then
    return
  end
  if false == self._isConsole then
    self._ui_pc.btn_question:SetShow(true)
    self._ui_pc.btn_close:SetShow(true)
    self._ui_pc.stc_LClick:SetShow(true)
    self._ui_pc.stc_RClick:SetShow(true)
    self._ui_console.stc_guideBg:SetShow(false)
    self._ui_console.stc_iconLB:SetShow(false)
    self._ui_console.stc_iconRB:SetShow(false)
    for idx = 1, self._socketSlotCount do
      self._ui.stc_crystalInfoBg[idx]:SetIgnore(true)
    end
  else
    self._ui_pc.btn_question:SetShow(false)
    self._ui_pc.btn_close:SetShow(false)
    self._ui_pc.stc_LClick:SetShow(false)
    self._ui_pc.stc_RClick:SetShow(false)
    self._ui_console.stc_guideBg:SetShow(true)
    self._ui_console.stc_iconLB:SetShow(true)
    self._ui_console.stc_iconRB:SetShow(true)
  end
end
function PaGlobal_Socket_All:prepareOpen()
  if nil == Panel_Window_Socket_All then
    return
  end
  self._indexPopSocket = -1
  self._ui.list2_item:moveTopIndex()
  Panel_Npc_Dialog_All:ignorePadSnapMoveToOtherPanelUpdate(true)
  PaGlobal_Socket_All:resize()
  PaGlobal_Socket_All:open()
  PaGlobal_Socket_All:clearAllSlots()
  for idx = 1, self._socketSlotCount do
    self:updateSocketSlotBg(idx, false)
  end
  PaGlobalFunc_Socket_All_SetTab(self._TAB.EQUIPMENT)
end
function PaGlobal_Socket_All:open()
  if nil == Panel_Window_Socket_All then
    return
  end
  Panel_Window_Socket_All:SetShow(true)
end
function PaGlobal_Socket_All:prepareClose()
  if nil == Panel_Window_Socket_All then
    return
  end
  Panel_Npc_Dialog_All:ignorePadSnapMoveToOtherPanelUpdate(false)
  PaGlobal_Socket_All:close()
end
function PaGlobal_Socket_All:close()
  if nil == Panel_Window_Socket_All then
    return
  end
  Panel_Window_Socket_All:SetShow(false)
end
function PaGlobal_Socket_All:updateEquipList()
  if nil == Panel_Window_Socket_All then
    return
  end
  local selfPlayerWrapper = getSelfPlayer()
  if nil == selfPlayerWrapper then
    return
  end
  local selfPlayer = selfPlayerWrapper:get()
  local invenSize = selfPlayer:getInventorySlotCount(false)
  local listCount = -1
  self._toIndex = self._ui.list2_item:getCurrenttoIndex()
  self._scrollValue = self._ui._vscroll:GetControlPos()
  self._ui.list2_item:getElementManager():clearKey()
  self._crystalList = {}
  self._equipList = {}
  self._slotIconList = {}
  self._indexInvenEnd = -1
  self._indexCashInvenEnd = -1
  for idx = 0, invenSize - 1 do
    local itemWrapper = getInventoryItemByType(CppEnums.ItemWhereType.eInventory, idx)
    if nil ~= itemWrapper and true == self:filterInvenItem(idx, itemWrapper, CppEnums.ItemWhereType.eInventory) then
      listCount = listCount + 1
      self._equipList[listCount] = idx
      self._ui.list2_item:getElementManager():pushKey(toInt64(0, listCount))
    end
  end
  self._indexInvenEnd = listCount
  local cashInven = getSelfPlayer():get():getCashInventory()
  if nil == cashInven then
    return
  end
  local invenMaxSize = cashInven:sizeXXX()
  for idx = 0, invenMaxSize - 1 do
    local itemWrapper = getInventoryItemByType(CppEnums.ItemWhereType.eCashInventory, idx)
    if nil ~= itemWrapper and true == self:filterInvenItem(idx, itemWrapper, CppEnums.ItemWhereType.eCashInventory) then
      listCount = listCount + 1
      self._equipList[listCount] = idx
      self._ui.list2_item:getElementManager():pushKey(toInt64(0, listCount))
    end
  end
  self._indexCashInvenEnd = listCount
  for equipIdx = CppEnums.EquipSlotNo.rightHand, CppEnums.EquipSlotNo.equipSlotNoCount do
    local itemWrapper = ToClient_getEquipmentItem(equipIdx)
    if nil ~= itemWrapper and true == self:filterEquipItem(equipIdx, itemWrapper) then
      listCount = listCount + 1
      self._equipList[listCount] = equipIdx
      self._ui.list2_item:getElementManager():pushKey(toInt64(0, listCount))
    end
  end
  self._ui.list2_item:setCurrenttoIndex(self._toIndex)
  if false == self._ui.list2_item:IsIgnoreVerticalScroll() then
    self._ui._vscroll:SetControlPos(self._scrollValue)
  end
  self._ui.list2_item:SetShow(0 <= listCount)
end
function PaGlobal_Socket_All:updateCrystalList()
  if nil == Panel_Window_Socket_All then
    return
  end
  local selfPlayerWrapper = getSelfPlayer()
  if nil == selfPlayerWrapper then
    return
  end
  local selfPlayer = selfPlayerWrapper:get()
  local invenSize = selfPlayer:getInventorySlotCount(false)
  local listCount = -1
  self._ui.list2_item:getElementManager():clearKey()
  self._crystalList = {}
  self._equipList = {}
  self._slotIconList = {}
  for idx = 0, invenSize - 1 do
    local itemWrapper = getInventoryItemByType(CppEnums.ItemWhereType.eInventory, idx)
    if nil ~= itemWrapper and true == self:filterCrystalItem(idx, itemWrapper) then
      listCount = listCount + 1
      self._crystalList[listCount] = idx
      self._ui.list2_item:getElementManager():pushKey(toInt64(0, listCount))
    end
  end
  self._ui.list2_item:setCurrenttoIndex(self._toIndex)
  if false == self._ui.list2_item:IsIgnoreVerticalScroll() then
    self._ui._vscroll:SetControlPos(self._scrollValue)
  end
  self._ui.list2_item:SetShow(0 <= listCount)
end
function PaGlobal_Socket_All:updateSocket()
  if true == self._equipItemSlotInfo.empty then
    UI.ASSERT(false, "socket empty ???")
    return
  end
  if self._selectKey <= self._indexInvenEnd then
    self._whereType = CppEnums.ItemWhereType.eInventory
  elseif self._selectKey <= self._indexCashInvenEnd then
    self._whereType = CppEnums.ItemWhereType.eCashInventory
  end
  local invenItemWrapper = getInventoryItemByType(self._whereType, self._equipItemSlotInfo.slotNo)
  if nil == invenItemWrapper then
    UI.ASSERT(false, "invenitemWrapper nil ???")
    return
  end
  self._equipItemSlotInfo.slot.icon:EraseAllEffect()
  self._equipItemSlotInfo.slot.icon:AddEffect("fUI_ItemJewel_01A", false, 0, 0)
  for idx = 1, self._socketSlotCount do
    self:updateSocketSlotBg(idx, false)
  end
  local maxCount = invenItemWrapper:get():getUsableItemSocketCount()
  local classType = getSelfPlayer():getClassType()
  for idx = 1, maxCount do
    self:updateSocketSlotBg(idx, true)
    local socketSlot = self._ui.stc_crystalInfo[idx].slot
    local itemSW = invenItemWrapper:getPushedItem(idx - 1)
    if nil == itemSW then
      socketSlot.icon:SetShow(false)
      socketSlot:clearItem()
      socketSlot.empty = true
      self._ui.stc_crystalInfo[idx].name:SetText("")
      self._ui.stc_crystalInfo[idx].desc:SetText("")
      self._ui.stc_crystalInfo[idx].none:SetShow(true)
      self._ui.stc_crystalInfo[idx].empty = true
      self._ui.stc_crystalInfo[idx].none:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_SOCKET_EMPTYSLOT_DESC"))
      if true == self._isConsole then
        self._ui.stc_crystalSlot[idx]:registerPadEvent(__eConsoleUIPadEvent_Up_X, "")
        self._ui.stc_crystalSlot[idx]:addInputEvent("Mouse_On", "")
        self._ui.stc_crystalSlot[idx]:addInputEvent("Mouse_Out", "")
      else
        self._ui.stc_crystalInfo[idx].slot.icon:SetIgnore(true)
        self._ui.stc_crystalInfo[idx].slot.icon:addInputEvent("Mouse_On", "")
        self._ui.stc_crystalInfo[idx].slot.icon:addInputEvent("Mouse_Out", "")
      end
    else
      local itemKey = itemSW:get()._key:getItemKey()
      socketSlot.icon:SetShow(true)
      socketSlot:setItemByStaticStatus(itemSW, 0)
      self._ui.stc_crystalInfo[idx].name:SetText(itemSW:getName())
      PAGlobalFunc_SetItemTextColorForNewUI(self._ui.stc_crystalInfo[idx].name, itemSW)
      self._ui.stc_crystalInfo[idx].none:SetShow(false)
      self._ui.stc_crystalInfo[idx].empty = false
      if true == self._isConsole then
        self._ui.stc_crystalSlot[idx]:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandleEventOnOut_Socket_All_SlotItemTooltip(" .. itemKey .. ",true," .. idx .. ")")
        self._ui.stc_crystalSlot[idx]:addInputEvent("Mouse_On", "HandlePadEventOn_Socket_All_SocketOnTextureChange(" .. idx .. ", true)")
        self._ui.stc_crystalSlot[idx]:addInputEvent("Mouse_Out", "HandlePadEventOn_Socket_All_SocketOnTextureChange(" .. idx .. ", false)")
      else
        self._ui.stc_crystalInfo[idx].slot.icon:SetIgnore(false)
        self._ui.stc_crystalInfo[idx].slot.icon:addInputEvent("Mouse_On", "HandleEventOnOut_Socket_All_SlotItemTooltip(" .. itemKey .. ",true," .. idx .. ")")
        self._ui.stc_crystalInfo[idx].slot.icon:addInputEvent("Mouse_Out", "HandleEventOnOut_Socket_All_SlotItemTooltip(" .. itemKey .. ",false," .. idx .. ")")
      end
      local jewelSkillStaticWrapper = itemSW:getSkillByIdx(classType)
      if nil ~= jewelSkillStaticWrapper then
        local buffCount = jewelSkillStaticWrapper:getBuffCount()
        local descText = ""
        for buffIdx = 0, buffCount - 1 do
          local descCurrent = jewelSkillStaticWrapper:getBuffDescription(buffIdx)
          if "" == descCurrent then
            break
          end
          if 0 == buffIdx then
            descText = descCurrent
          else
            descText = descText .. "\n" .. descCurrent
          end
        end
        self._ui.stc_crystalInfo[idx].desc:SetTextMode(__eTextMode_AutoWrap)
        self._ui.stc_crystalInfo[idx].desc:SetText(descText)
      end
      self._ui.stc_crystalInfo[idx].slot.icon:EraseAllEffect()
      if 1 == idx then
        self._ui.stc_crystalInfo[idx].slot.icon:AddEffect("fUI_InstallCrystal_01A", true, 0, 0)
      elseif 2 == idx then
        self._ui.stc_crystalInfo[idx].slot.icon:AddEffect("fUI_InstallCrystal_01B", true, 0, 0)
      elseif 3 == idx then
        self._ui.stc_crystalInfo[idx].slot.icon:AddEffect("fUI_InstallCrystal_01C", true, 0, 0)
      end
    end
  end
end
function PaGlobal_Socket_All:updateSocketSlotBg(index, isNormal)
  if nil == Panel_Window_Socket_All then
    return
  end
  local texturePath = ""
  self._ui.stc_crystalInfoBg[index]:ChangeTextureInfoName("Combine/Frame/Combine_Frame_00.dds")
  if false == isNormal then
    local x1, y1, x2, y2 = setTextureUV_Func(self._ui.stc_crystalInfoBg[index], self._crystalSlotBgUV.disable.x1, self._crystalSlotBgUV.disable.y1, self._crystalSlotBgUV.disable.x2, self._crystalSlotBgUV.disable.y2)
    self._ui.stc_crystalInfoBg[index]:getBaseTexture():setUV(x1, y1, x2, y2)
    self._ui.stc_crystalInfoBg[index]:setRenderTexture(self._ui.stc_crystalInfoBg[index]:getBaseTexture())
  else
    local x1, y1, x2, y2 = setTextureUV_Func(self._ui.stc_crystalInfoBg[index], self._crystalSlotBgUV.normal.x1, self._crystalSlotBgUV.normal.y1, self._crystalSlotBgUV.normal.x2, self._crystalSlotBgUV.normal.y2)
    self._ui.stc_crystalInfoBg[index]:getBaseTexture():setUV(x1, y1, x2, y2)
    self._ui.stc_crystalInfoBg[index]:setRenderTexture(self._ui.stc_crystalInfoBg[index]:getBaseTexture())
  end
end
function PaGlobal_Socket_All:registEventHandler()
  if nil == Panel_Window_Socket_All then
    return
  end
  Panel_Window_Socket_All:RegisterShowEventFunc(true, "PaGlobalFunc_Socket_All_ShowAni()")
  Panel_Window_Socket_All:RegisterShowEventFunc(false, "PaGlobalFunc_Socket_All_HideAni()")
  registerEvent("EventSocketResult", "FromClient_Socket_All_EventSocketResult")
  registerEvent("onScreenResize", "FromCleint_Socket_All_onScreenResize")
  registerEvent("FromClient_InventoryUpdate", "FromClient_Socket_All_UpdateEquipList")
  registerEvent("EventEquipmentUpdate", "FromClient_Socket_All_UpdateEquipList")
  if false == self._isConsole then
    self._ui_pc.btn_question:addInputEvent("Mouse_LUp", "Panel_WebHelper_ShowToggle( \"Socket\" )")
    PaGlobal_Util_RegistHelpTooltipEvent(self._ui_pc.btn_question, "\"Socket\"")
    self._ui_pc.btn_close:addInputEvent("Mouse_LUp", "PaGlobalFunc_Socket_All_Close()")
    self._equipItemSlotInfo.slot.icon:addInputEvent("Mouse_RUp", "HandleEventRUp_Socket_All_SlotInit()")
    for idx = 1, self._socketSlotCount do
      self._ui.stc_crystalInfo[idx].slot.icon:addInputEvent("Mouse_RUp", "HandleEventRUp_Socket_All_RemoveCrystal(" .. idx .. ")")
    end
    self._ui.radio_tab[self._TAB.EQUIPMENT]:addInputEvent("Mouse_LUp", "PaGlobalFunc_Socket_All_SetTab(" .. self._TAB.EQUIPMENT .. ")")
    self._ui.radio_tab[self._TAB.CRYSCTAL]:addInputEvent("Mouse_LUp", "PaGlobalFunc_Socket_All_SetTab(" .. self._TAB.CRYSCTAL .. ")")
  else
    for idx = 1, self._socketSlotCount do
      self._ui.stc_crystalSlot[idx]:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "HandleEventRUp_Socket_All_RemoveCrystal(" .. idx .. ")")
    end
    Panel_Window_Socket_All:registerPadEvent(__eConsoleUIPadEvent_LB, "HandleEventLBRB_Socket_All_MoveTab(-1)")
    Panel_Window_Socket_All:registerPadEvent(__eConsoleUIPadEvent_RB, "HandleEventLBRB_Socket_All_MoveTab(1)")
  end
  self._ui.list2_item:registEvent(__ePAUIList2EventType_LuaChangeContent, "PaGlobalFunc_Socket_All_UpdateList")
  self._ui.list2_item:createChildContent(__ePAUIList2ElementManagerType_List)
end
function PaGlobal_Socket_All:resize()
  if nil == Panel_Window_Socket_All then
    return
  end
  local RPosX = self._ui.stc_imagePartArea:GetPosX() + self._ui.stc_imagePartArea:GetSizeX() - self._ui_pc.stc_RClick:GetTextSizeX() - self._ui_pc.stc_RClick:GetSizeX()
  self._ui_pc.stc_RClick:SetPosX(RPosX - 30)
  local LPosX = self._ui_pc.stc_RClick:GetPosX() - self._ui_pc.stc_LClick:GetTextSizeX() - self._ui_pc.stc_LClick:GetSizeX()
  self._ui_pc.stc_LClick:SetPosX(LPosX - 20)
  Panel_Window_Socket_All:ComputePos()
  if true == _ContentsGroup_NewUI_Dialog_All and nil ~= Panel_Npc_Dialog_All then
    Panel_Window_Socket_All:SetPosY((Panel_Npc_Dialog_All:GetPosY() - Panel_Window_Socket_All:GetSizeY()) / 2)
  end
  local tempBtnGroup = {
    self._ui_console.stc_delete,
    self._ui_console.stc_detail,
    self._ui_console.stc_select,
    self._ui_console.stc_cancle
  }
  PaGlobalFunc_ConsoleKeyGuide_SetAlign(tempBtnGroup, self._ui_console.stc_guideBg, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP)
  self._ui_console.stc_delete:SetShow(false)
end
function PaGlobal_Socket_All:validate()
  if nil == Panel_Window_Socket_All then
    return
  end
  self._ui.stc_titleBg:isValidate()
  self._ui.stc_leftAreaBg:isValidate()
  self._ui.stc_imageArea:isValidate()
  self._ui.stc_imagePartArea:isValidate()
  self._ui.stc_extractArea:isValidate()
  self._ui.stc_equipSlot:isValidate()
  self._ui.stc_descArea:isValidate()
  self._ui.txt_desc:isValidate()
  self._ui.stc_rightArea:isValidate()
  self._ui.stc_tabBg:isValidate()
  self._ui.radio_tab[self._TAB.EQUIPMENT]:isValidate()
  self._ui.radio_tab[self._TAB.CRYSCTAL]:isValidate()
  self._ui.stc_selectBar:isValidate()
  self._ui.list2_item:isValidate()
  self._ui_pc.btn_question:isValidate()
  self._ui_pc.btn_close:isValidate()
  self._ui_pc.stc_LClick:isValidate()
  self._ui_pc.stc_RClick:isValidate()
  self._ui_console.stc_guideBg:isValidate()
  self._ui_console.stc_iconLB:isValidate()
  self._ui_console.stc_iconRB:isValidate()
  self._ui_console.stc_select:isValidate()
  self._ui_console.stc_cancle:isValidate()
end
function PaGlobal_Socket_All:filterEquipItem(slotNo, itemWrapper)
  if nil == itemWrapper then
    return false
  end
  if true == ToClient_EquipSlot_CheckItemLock(slotNo, CppEnums.ItemWhereType.eEquip) then
    return false
  end
  local itemSSW = itemWrapper:getStaticStatus()
  if true == itemSSW:get():doHaveSocket() then
    if 22 == itemSSW:getEquipType() and false == itemWrapper:get():isVested() then
      return false
    else
      return true
    end
  end
  return false
end
function PaGlobal_Socket_All:filterInvenItem(slotNo, itemWrapper, whereType)
  if nil == itemWrapper then
    return false
  end
  if true == ToClient_Inventory_CheckItemLock(slotNo, whereType) then
    return false
  end
  local itemSSW = itemWrapper:getStaticStatus()
  if true == itemSSW:get():doHaveSocket() then
    return true
  end
  return false
end
function PaGlobal_Socket_All:filterCrystalItem(slotNo, itemWrapper)
  if nil == itemWrapper then
    return false
  end
  local invenType = PaGlobalFunc_Socket_All_GetInvenType(PaGlobal_Socket_All._selectKey)
  if CppEnums.ItemWhereType.eCashInventory == invenType then
    return false
  end
  if ToClient_Inventory_CheckItemLock(slotNo, invenType) then
    return false
  end
  local isAble = getSocketInformation():isFilterJewelEquipType(invenType, slotNo)
  return isAble
end
function PaGlobal_Socket_All:clearAllSlots()
  self._equipItemSlotInfo.slotNo = -1
  self._equipItemSlotInfo.slot:clearItem()
  self._equipItemSlotInfo.slot.icon:SetShow(false)
  self._equipItemSlotInfo.empty = true
  self._ui_console.stc_delete:SetShow(false)
  for idx = 1, self._socketSlotCount do
    self._ui.stc_crystalInfo[idx].name:SetText("")
    self._ui.stc_crystalInfo[idx].desc:SetText("")
    self._ui.stc_crystalInfo[idx].slot:clearItem()
    self._ui.stc_crystalInfo[idx].slot.icon:addInputEvent("Mouse_On", "")
    self._ui.stc_crystalInfo[idx].slot.icon:addInputEvent("Mouse_Out", "")
    self._ui.stc_crystalSlot[idx]:addInputEvent("Mouse_On", "")
    self._ui.stc_crystalSlot[idx]:addInputEvent("Mouse_Out", "")
    self._ui.stc_crystalInfo[idx].slot.icon:EraseAllEffect()
    self._ui.stc_crystalInfo[idx].none:SetShow(false)
    self._ui.stc_crystalInfo[idx].empty = true
    self:updateSocketSlotBg(idx, false)
  end
  getSocketInformation():clearData()
end
