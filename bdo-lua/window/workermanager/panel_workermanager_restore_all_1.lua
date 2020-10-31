function PaGlobal_WorkerManagerRestore_All:initialize()
  if true == PaGlobal_WorkerManagerRestore_All._initialize then
    return
  end
  PaGlobal_WorkerManagerRestore_All._isConsole = _ContentsGroup_RenewUI
  PaGlobal_WorkerManagerRestore_All._isPadSnap = _ContentsGroup_UsePadSnapping
  PaGlobal_WorkerManagerRestore_All:ControlAll_Init()
  PaGlobal_WorkerManagerRestore_All:ControlPc_Init()
  PaGlobal_WorkerManagerRestore_All:ControlConsole_Init()
  PaGlobal_WorkerManagerRestore_All:ControlSetShow()
  PaGlobal_WorkerManagerRestore_All:registEventHandler()
  PaGlobal_WorkerManagerRestore_All:validate()
  PaGlobal_WorkerManagerRestore_All._initialize = true
end
function PaGlobal_WorkerManagerRestore_All:ControlAll_Init()
  if nil == Panel_Window_WorkerManagerRestore_All then
    return
  end
  self._ui.stc_titleBg = UI.getChildControl(Panel_Window_WorkerManagerRestore_All, "titlebar_RestoreAll")
  self._ui.txt_titleName = UI.getChildControl(self._ui.stc_titleBg, "StaticText_TitleName")
  self._ui.stc_itemlistBg = UI.getChildControl(Panel_Window_WorkerManagerRestore_All, "Static_ItemList_BG")
  self._ui.txt_itemlistGuide = UI.getChildControl(self._ui.stc_itemlistBg, "StaticText_Select_Item_Guide")
  self._ui.stc_itemIconBg = UI.getChildControl(self._ui.stc_itemlistBg, "Static_Restore_Item_Icone_BG")
  self._ui.stc_itemIcon = UI.getChildControl(self._ui.stc_itemIconBg, "Static_Restore_Item_Icone")
  self._ui.stc_itemCnt = UI.getChildControl(self._ui.stc_itemIconBg, "StaticText_Item_Count")
  self._ui.stc_itemRetoreVal = UI.getChildControl(self._ui.stc_itemIconBg, "StaticText_Item_Restore_Value")
  self._ui.txt_workerCnt = UI.getChildControl(Panel_Window_WorkerManagerRestore_All, "StaticText_Worker")
  self._ui.txt_restorePoint = UI.getChildControl(Panel_Window_WorkerManagerRestore_All, "StaticText_RestorePoint")
  self._ui.txt_possiblePoint = UI.getChildControl(Panel_Window_WorkerManagerRestore_All, "StaticText_PossiblePoint")
  self._ui.stc_slider = UI.getChildControl(self._ui.stc_itemlistBg, "Slider_Restore_Item")
  self._ui.btn_slider = UI.getChildControl(self._ui.stc_slider, "Slider_Restore_Item_Button")
  self._ui.txt_itemlistGuide:SetTextMode(__eTextMode_AutoWrap)
  self._ui.txt_workerCnt:SetTextMode(__eTextMode_AutoWrap)
  self._ui.txt_restorePoint:SetTextMode(__eTextMode_AutoWrap)
  self._ui.txt_possiblePoint:SetTextMode(__eTextMode_AutoWrap)
  self._ui.txt_itemlistGuide:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WORKERRESTOREALL_DESC_USEITEM"))
  self._originPanelSizeY = Panel_Window_WorkerManagerRestore_All:GetSizeY()
  for resIdx = 0, self._restoreItemMaxCount - 1 do
    local tempItemSlot = {}
    tempItemSlot.slotBG = UI.createAndCopyBasePropertyControl(self._ui.stc_itemlistBg, "Static_Restore_Item_Icone_BG", self._ui.stc_itemlistBg, "workerManager_restoreSlotBG_" .. resIdx)
    tempItemSlot.slotIcon = UI.createAndCopyBasePropertyControl(self._ui.stc_itemIconBg, "Static_Restore_Item_Icone", tempItemSlot.slotBG, "workerManager_restoreSlot_" .. resIdx)
    tempItemSlot.itemCount = UI.createAndCopyBasePropertyControl(self._ui.stc_itemIconBg, "StaticText_Item_Count", tempItemSlot.slotIcon, "workerManager_restoreItemCount_" .. resIdx)
    tempItemSlot.restorePoint = UI.createAndCopyBasePropertyControl(self._ui.stc_itemIconBg, "StaticText_Item_Restore_Value", tempItemSlot.slotIcon, "workerManager_restorePoint_" .. resIdx)
    tempItemSlot.slotBG:SetPosX(15 + resIdx * 55)
    tempItemSlot.slotBG:SetPosY(37)
    tempItemSlot.slotIcon:ComputePos()
    tempItemSlot.itemCount:ComputePos()
    tempItemSlot.restorePoint:ComputePos()
    tempItemSlot.slotBG:SetShow(false)
    self._restoreItemSlot[resIdx] = tempItemSlot
  end
end
function PaGlobal_WorkerManagerRestore_All:ControlPc_Init()
  if nil == Panel_Window_WorkerManagerRestore_All then
    return
  end
  self._ui_pc.btn_close = UI.getChildControl(self._ui.stc_titleBg, "Button_Close")
  self._ui_pc.btn_confirm = UI.getChildControl(Panel_Window_WorkerManagerRestore_All, "Button_Restore")
  self._ui_pc.btn_cancle = UI.getChildControl(Panel_Window_WorkerManagerRestore_All, "Button_Cancel")
end
function PaGlobal_WorkerManagerRestore_All:ControlConsole_Init()
  if nil == Panel_Window_WorkerManagerRestore_All then
    return
  end
  self._ui_console.stc_keyguideBg = UI.getChildControl(Panel_Window_WorkerManagerRestore_All, "Static_ConsoleKeyGuide_DatailMenu")
  self._ui_console.stc_feedAll = UI.getChildControl(self._ui_console.stc_keyguideBg, "StaticText_FeedAll")
  self._ui_console.stc_confirm = UI.getChildControl(self._ui_console.stc_keyguideBg, "StaticText_Confirm")
  self._ui_console.stc_close = UI.getChildControl(self._ui_console.stc_keyguideBg, "StaticText_Close")
end
function PaGlobal_WorkerManagerRestore_All:ControlSetShow()
  if nil == Panel_Window_WorkerManagerRestore_All then
    return
  end
  self._ui.stc_slider:SetShow(false)
  if true == self._isPadSnap then
    self._ui_pc.btn_close:SetShow(false)
    self._ui_pc.btn_confirm:SetShow(false)
    self._ui_pc.btn_cancle:SetShow(false)
    self._ui_console.stc_keyguideBg:SetShow(true)
    self._ui_console.stc_confirm:SetShow(true)
    self._ui_console.stc_close:SetShow(true)
  else
    self._ui_pc.btn_close:SetShow(true)
    self._ui_pc.btn_confirm:SetShow(true)
    self._ui_pc.btn_cancle:SetShow(true)
    self._ui_console.stc_keyguideBg:SetShow(false)
    self._ui_console.stc_confirm:SetShow(false)
    self._ui_console.stc_close:SetShow(false)
  end
end
function PaGlobal_WorkerManagerRestore_All:prepareOpen(listCount, workerArray)
  if nil == Panel_Window_WorkerManagerRestore_All then
    return
  end
  if false == Panel_Window_WorkerManager_All:IsShow() or false == Panel_Window_WorkerManager_All:GetShow() then
    return
  end
  self._workerListCount = listCount
  self._workerArray = workerArray
  self._sliderStartIdx = 0
  if nil ~= self._workerArray then
    self._ui.txt_titleName:SetText(self._titleText.All)
    self._ui.txt_itemlistGuide:SetText(self._guideText.All)
  else
    self._ui.txt_titleName:SetText(self._titleText.ONE)
    if true == self._isPadSnap then
      self._ui.txt_itemlistGuide:SetText(self._guideText.CONSOLE)
    else
      self._ui.txt_itemlistGuide:SetText(self._guideText.PC)
    end
  end
  self._ui.stc_slider:SetControlPos(0)
  PaGlobal_WorkerManagerRestore_All:update()
  if true == ToClient_WorldMapIsShow() then
    WorldMapPopupManager:push(Panel_Window_WorkerManagerRestore_All, true, nil, PaGlobalFunc_WorkerManagerRestore_All_Close)
  else
    PaGlobal_WorkerManagerRestore_All:open()
  end
  PaGlobal_WorkerManagerRestore_All:resize()
  HandleEventLUp_WorkerManagerRestore_All_SelectItem(0)
end
function PaGlobal_WorkerManagerRestore_All:open()
  if nil == Panel_Window_WorkerManagerRestore_All then
    return
  end
  Panel_Window_WorkerManagerRestore_All:SetShow(true)
end
function PaGlobal_WorkerManagerRestore_All:prepareClose()
  if nil == Panel_Window_WorkerManagerRestore_All then
    return
  end
  if true == Panel_Window_WorkerManagerRestore_All:IsUISubApp() then
    Panel_Window_WorkerManagerRestore_All:CloseUISubApp()
  end
  self._workerListCount = 0
  self._workerArray = {}
  self._workerNoRaw = -1
  self._selectedItemIdx = -1
  self._isContinue = false
  self._sliderStartIdx = 0
  PaGlobal_WorkerManagerRestore_All:close()
end
function PaGlobal_WorkerManagerRestore_All:close()
  if nil == Panel_Window_WorkerManagerRestore_All then
    return
  end
  Panel_Window_WorkerManagerRestore_All:SetShow(false)
end
function PaGlobal_WorkerManagerRestore_All:update()
  if nil == Panel_Window_WorkerManagerRestore_All then
    return
  end
  self:updateItemSlot()
  self:updateBottomDesc()
end
function PaGlobal_WorkerManagerRestore_All:registEventHandler()
  if nil == Panel_Window_WorkerManagerRestore_All then
    return
  end
  Panel_Window_WorkerManagerRestore_All:ignorePadSnapMoveToOtherPanel()
  self._ui_pc.btn_close:addInputEvent("Mouse_LUp", "PaGlobalFunc_WorkerManagerRestore_All_Close()")
  self._ui_pc.btn_cancle:addInputEvent("Mouse_LUp", "PaGlobalFunc_WorkerManagerRestore_All_Close()")
  self._ui_pc.btn_confirm:addInputEvent("Mouse_LUp", "HandleEventLUp_WorkerManagerRestore_All_Confirm()")
  Panel_Window_WorkerManagerRestore_All:addInputEvent("Mouse_UpScroll", "HandleEventScroll_WorkerManagerRestore_All_SliderScroll(true)")
  Panel_Window_WorkerManagerRestore_All:addInputEvent("Mouse_DownScroll", "HandleEventScroll_WorkerManagerRestore_All_SliderScroll(false)")
end
function PaGlobal_WorkerManagerRestore_All:validate()
  if nil == Panel_Window_WorkerManagerRestore_All then
    return
  end
  self._ui.stc_titleBg:isValidate()
  self._ui.stc_itemlistBg:isValidate()
  self._ui.txt_itemlistGuide:isValidate()
  self._ui.stc_itemIconBg:isValidate()
  self._ui.stc_itemIcon:isValidate()
  self._ui.stc_itemCnt:isValidate()
  self._ui.stc_itemRetoreVal:isValidate()
  self._ui.txt_workerCnt:isValidate()
  self._ui.txt_restorePoint:isValidate()
  self._ui.txt_possiblePoint:isValidate()
  self._ui_pc.btn_close:isValidate()
  self._ui_pc.btn_confirm:isValidate()
  self._ui_pc.btn_cancle:isValidate()
  self._ui_console.stc_keyguideBg:isValidate()
  self._ui_console.stc_confirm:isValidate()
  self._ui_console.stc_close:isValidate()
end
function PaGlobal_WorkerManagerRestore_All:resize()
  if nil == Panel_Window_WorkerManagerRestore_All then
    return
  end
  if true == self._isPadSnap then
    Panel_Window_WorkerManagerRestore_All:SetSize(Panel_Window_WorkerManagerRestore_All:GetSizeX(), self._originPanelSizeY - self._ui_console.stc_close:GetSizeY() - 10)
  else
    Panel_Window_WorkerManagerRestore_All:SetSize(Panel_Window_WorkerManagerRestore_All:GetSizeX(), self._originPanelSizeY)
  end
  if nil ~= Panel_Window_WorkerManager_All and true == Panel_Window_WorkerManager_All:GetShow() then
    local mainPanelPosX = Panel_Window_WorkerManager_All:GetPosX()
    local mainPanelPosY = Panel_Window_WorkerManager_All:GetPosY()
    local mainPanelSizeX = Panel_Window_WorkerManager_All:GetSizeX()
    local endPosX = mainPanelPosX + mainPanelSizeX + 10 + Panel_Window_WorkerManagerRestore_All:GetSizeX()
    if endPosX < getScreenSizeX() then
      Panel_Window_WorkerManagerRestore_All:SetPosX(mainPanelPosX + mainPanelSizeX + 10)
      Panel_Window_WorkerManagerRestore_All:SetPosY(mainPanelPosY)
    else
      Panel_Window_WorkerManagerRestore_All:SetPosX(math.max(0, mainPanelPosX - 10 - Panel_Window_WorkerManagerRestore_All:GetSizeX()))
      Panel_Window_WorkerManagerRestore_All:SetPosY(mainPanelPosY)
    end
  end
  if true == Panel_Window_WorkerManager_All:IsUISubApp() then
    if 0 < Panel_Window_WorkerManager_All:GetScreenParentPosX() then
      Panel_Window_WorkerManagerRestore_All:SetPosX(Panel_Window_WorkerManager_All:GetScreenParentPosX() - Panel_Window_WorkerManagerRestore_All:GetSizeX() - 10)
    else
      Panel_Window_WorkerManagerRestore_All:SetPosX(Panel_Window_WorkerManager_All:GetScreenParentPosX() + Panel_Window_WorkerManager_All:GetSizeX() - 10)
    end
    Panel_Window_WorkerManagerRestore_All:SetPosY(Panel_Window_WorkerManager_All:GetScreenParentPosY())
    Panel_Window_WorkerManagerRestore_All:OpenUISubApp()
  end
  local gabY = 30
  local afterPanelSizeY = self._ui.stc_titleBg:GetSizeY() + self._ui.txt_itemlistGuide:GetTextSizeY() + self._restoreItemSlot[0].slotBG:GetSizeY() + self._ui.stc_slider:GetSizeY() + gabY
  local afterListBgSizeY = afterPanelSizeY - self._ui.stc_titleBg:GetSizeY()
  if nil == self._workerArray then
    self._ui.txt_workerCnt:SetShow(false)
    self._ui.txt_restorePoint:SetShow(false)
    self._ui.txt_possiblePoint:SetShow(false)
    self._ui_console.stc_feedAll:SetShow(true)
    self._ui.stc_itemlistBg:SetSize(self._ui.stc_itemlistBg:GetSizeX(), afterListBgSizeY)
    Panel_Window_WorkerManagerRestore_All:SetSize(Panel_Window_WorkerManagerRestore_All:GetSizeX(), afterPanelSizeY)
  else
    self._ui.txt_workerCnt:SetShow(true)
    self._ui.txt_restorePoint:SetShow(true)
    self._ui.txt_possiblePoint:SetShow(true)
    self._ui_console.stc_feedAll:SetShow(false)
    afterPanelSizeY = afterPanelSizeY + self._ui.txt_workerCnt:GetTextSizeY() + self._ui.txt_restorePoint:GetTextSizeY() + self._ui.txt_possiblePoint:GetTextSizeY()
    if true == self._isPadSnap then
      self._ui.stc_itemlistBg:SetSize(self._ui.stc_itemlistBg:GetSizeX(), afterListBgSizeY)
      Panel_Window_WorkerManagerRestore_All:SetSize(Panel_Window_WorkerManagerRestore_All:GetSizeX(), afterPanelSizeY)
    else
      afterPanelSizeY = afterPanelSizeY + self._ui_pc.btn_confirm:GetSizeY() + 10
      self._ui.stc_itemlistBg:SetSize(self._ui.stc_itemlistBg:GetSizeX(), afterListBgSizeY)
      Panel_Window_WorkerManagerRestore_All:SetSize(Panel_Window_WorkerManagerRestore_All:GetSizeX(), afterPanelSizeY)
      self._ui_pc.btn_confirm:SetShow(true)
      self._ui_pc.btn_cancle:SetShow(true)
      self._ui_pc.btn_confirm:ComputePos()
      self._ui_pc.btn_cancle:ComputePos()
    end
  end
  self._ui.stc_itemlistBg:ComputePos()
  self._ui.stc_slider:ComputePos()
  for itemIdx = 0, self._restoreItemMaxCount - 1 do
    self._restoreItemSlot[itemIdx].slotBG:SetPosY(self._ui.txt_itemlistGuide:GetPosY() + self._ui.txt_itemlistGuide:GetTextSizeY() + 5)
  end
  if true == self._isPadSnap then
    local keyGuide = {
      self._ui_console.stc_feedAll,
      self._ui_console.stc_confirm,
      self._ui_console.stc_close
    }
    PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyGuide, self._ui_console.stc_keyguideBg, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP, nil, 10)
    self._ui_console.stc_keyguideBg:ComputePos()
  end
end
function PaGlobal_WorkerManagerRestore_All:updateItemSlot()
  if nil == Panel_Window_WorkerManagerRestore_All then
    return
  end
  for itemIdx = 0, self._restoreItemMaxCount - 1 do
    self._restoreItemSlot[itemIdx].slotBG:SetShow(false)
    self._restoreItemSlot[itemIdx].slotBG:SetCheck(false)
    self._restoreItemSlot[itemIdx].slotBG:addInputEvent("Mouse_RUp", "")
  end
  self._restoreItemHasCount = ToClient_getNpcRecoveryItemList()
  if nil == self._restoreItemHasCount or 0 >= self._restoreItemHasCount then
    PaGlobalFunc_WorkerManagerRestore_All_Close()
    return
  end
  local itemCnt = 0
  for itemIdx = self._sliderStartIdx, self._restoreItemHasCount - 1 do
    if itemCnt >= self._restoreItemMaxCount then
      break
    end
    if true == self._itemSelectList[itemIdx] then
      self._restoreItemSlot[itemCnt].slotBG:SetCheck(true)
    elseif false == self._itemSelectList[itemIdx] then
      self._restoreItemSlot[itemCnt].slotBG:SetCheck(false)
    end
    local recoveryItem = ToClient_getNpcRecoveryItemByIndex(itemIdx)
    local itemStatic = recoveryItem:getItemStaticStatus()
    self._restoreItemSlot[itemCnt].slotBG:SetShow(true)
    self._restoreItemSlot[itemCnt].slotIcon:ChangeTextureInfoName("icon/" .. getItemIconPath(itemStatic))
    self._restoreItemSlot[itemCnt].itemCount:SetText(tostring(recoveryItem._itemCount_s64))
    self._restoreItemSlot[itemCnt].restorePoint:SetText("+" .. tostring(recoveryItem._contentsEventParam1))
    if true == self._isPadSnap then
      self._restoreItemSlot[itemCnt].slotBG:addInputEvent("Mouse_On", "HandleEventLUp_WorkerManagerRestore_All_SelectItem(" .. itemIdx .. ")")
      self._restoreItemSlot[itemCnt].slotBG:registerPadEvent(__eConsoleUIPadEvent_DpadLeft, "HandleEventScroll_WorkerManagerRestore_All_SliderScroll(true)")
      self._restoreItemSlot[itemCnt].slotBG:registerPadEvent(__eConsoleUIPadEvent_DpadRight, "HandleEventScroll_WorkerManagerRestore_All_SliderScroll(false)")
    else
      self._restoreItemSlot[itemCnt].slotBG:addInputEvent("Mouse_LUp", "HandleEventLUp_WorkerManagerRestore_All_SelectItem(" .. itemIdx .. ")")
      self._restoreItemSlot[itemCnt].slotBG:addInputEvent("Mouse_UpScroll", "HandleEventScroll_WorkerManagerRestore_All_SliderScroll(true)")
      self._restoreItemSlot[itemCnt].slotBG:addInputEvent("Mouse_DownScroll", "HandleEventScroll_WorkerManagerRestore_All_SliderScroll(false)")
    end
    itemCnt = itemCnt + 1
  end
  if self._restoreItemMaxCount < self._restoreItemHasCount then
    self._ui.stc_slider:SetShow(true)
    local sliderSize = self._ui.stc_slider:GetSizeX()
    local targetPercent = self._restoreItemMaxCount / self._restoreItemHasCount * 100
    local sliderBtnSize = sliderSize * (targetPercent / 100)
    self._ui.btn_slider:SetSize(sliderBtnSize, self._ui.btn_slider:GetSizeY())
    self._ui.stc_slider:SetInterval(self._restoreItemHasCount - self._restoreItemMaxCount)
    self._ui.stc_slider:addInputEvent("Mouse_LUp", "HandleEventLPress_WorkerManagerRestore_All_SliderPress()")
    self._ui.btn_slider:addInputEvent("Mouse_LPress", "HandleEventLPress_WorkerManagerRestore_All_SliderPress()")
  else
    self._ui.stc_slider:SetShow(false)
  end
end
function PaGlobal_WorkerManagerRestore_All:updateBottomDesc()
  if nil == self._selectedItemIdx or -1 == self._selectedItemIdx then
    return
  end
  if nil == self._workerArray then
    return
  end
  local workerCount = 0
  local totalPoint = 0
  local selectItem = ToClient_getNpcRecoveryItemByIndex(self._selectedItemIdx)
  if nil == selectItem then
    return
  end
  local selectItemCount = Int64toInt32(selectItem._itemCount_s64)
  local selectItemPoint = selectItem._contentsEventParam1
  local totalselectItemPoint = selectItemCount * selectItemPoint
  for index = 1, self._workerListCount do
    local workerNoRaw = self._workerArray[index]
    if nil ~= workerNoRaw then
      local workerWrapperLua = getWorkerWrapper(workerNoRaw, false)
      local maxPoint = workerWrapperLua:getMaxActionPoint()
      local currentPoint = workerWrapperLua:getActionPoint()
      local restoreActionPoint = maxPoint - currentPoint
      local remainder = 0
      remainder = restoreActionPoint % selectItemPoint
      if maxPoint >= currentPoint + selectItemPoint then
        workerCount = workerCount + 1
        totalPoint = totalPoint + (restoreActionPoint - remainder)
      end
    end
  end
  self._ui.txt_workerCnt:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_WORKERRESTORE_WORKERCOUNT", "count", tostring(workerCount)))
  self._ui.txt_restorePoint:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_WORKERRESTORE_POSSIBLE", "totalPoint", tostring(totalPoint)))
  if totalselectItemPoint >= totalPoint then
    self._ui.txt_possiblePoint:SetText(PAGetStringParam2(Defines.StringSheet_GAME, "LUA_WORKERRESTORE_CONSUMEITEM", "selectItemCount", tostring(totalPoint / selectItemPoint), "totalPoint", tostring(totalPoint)))
  elseif totalselectItemPoint < totalPoint then
    self._ui.txt_possiblePoint:SetText(PAGetStringParam2(Defines.StringSheet_GAME, "LUA_WORKERRESTORE_CONSUMEITEM", "selectItemCount", tostring(selectItemCount), "totalPoint", tostring(totalselectItemPoint)))
  end
end
function PaGlobal_WorkerManagerRestore_All:selectItem(itemIdx)
  if nil == Panel_Window_WorkerManagerRestore_All then
    return
  end
  for idx = 0, self._restoreItemHasCount - 1 do
    self._itemSelectList[idx] = false
  end
  self._selectedItemIdx = itemIdx
  if nil == self._itemSelectList[itemIdx] or false == self._itemSelectList[itemIdx] then
    self._itemSelectList[itemIdx] = true
  else
    self._itemSelectList[itemIdx] = false
  end
  if nil ~= self._workerArray then
    if true == self._isPadSnap then
      Panel_Window_WorkerManagerRestore_All:registerPadEvent(__eConsoleUIPadEvent_Up_A, "HandleEventLUp_WorkerManagerRestore_All_Confirm()")
      Panel_Window_WorkerManagerRestore_All:registerPadEvent(__eConsoleUIPadEvent_Up_X, "")
    end
  elseif true == self._isPadSnap then
    Panel_Window_WorkerManagerRestore_All:registerPadEvent(__eConsoleUIPadEvent_Up_A, "HandlePadEventA_WorkerManagerRestore_All_UseItemToWorker()")
    Panel_Window_WorkerManagerRestore_All:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandlePadEventX_WorkerManagerRestore_All_UseItemContinueToWorker()")
  end
  self:update()
end
function PaGlobal_WorkerManagerRestore_All:confirm(itemIdx)
  if nil == Panel_Window_WorkerManagerRestore_All then
    return
  end
  if nil == self._selectedItemIdx or -1 == self._selectedItemIdx then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_WORKERRESTORE_NOSELECTITEM"))
    return
  end
  local recoveryItem = ToClient_getNpcRecoveryItemByIndex(self._selectedItemIdx)
  local recoveryItemCount = Int64toInt32(recoveryItem._itemCount_s64)
  local restorePoint = recoveryItem._contentsEventParam1
  local slotNo = recoveryItem._slotNo
  local currentItemCount = recoveryItemCount
  for idx = 1, self._workerListCount do
    local workerNoRaw = self._workerArray[idx]
    if nil ~= workerNoRaw then
      local workerWrapperLua = getWorkerWrapper(workerNoRaw, false)
      local maxPoint = workerWrapperLua:getMaxActionPoint()
      local currentPoint = workerWrapperLua:getActionPoint()
      local restoreItemCount = ToClient_getNpcRecoveryItemList()
      local restoreActionPoint = maxPoint - currentPoint
      local itemNeedCount = math.floor(restoreActionPoint / restorePoint)
      if currentItemCount < itemNeedCount then
        itemNeedCount = currentItemCount
      end
      if 1 <= itemNeedCount then
        _AudioPostEvent_SystemUiForXBOX(50, 1)
        requestRecoveryWorker(WorkerNo(workerNoRaw), slotNo, itemNeedCount)
        currentItemCount = currentItemCount - itemNeedCount
      end
    end
  end
  self:update()
end
function PaGlobal_WorkerManagerRestore_All:useItemToWorker()
  if nil == Panel_Window_WorkerManagerRestore_All then
    return
  end
  if nil == self._selectedItemIdx or -1 == self._selectedItemIdx then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_WORKERRESTORE_NOSELECTITEM"))
    return
  end
  local workerWrapperLua = getWorkerWrapper(self._workerNoRaw, false)
  if nil == workerWrapperLua then
    return
  end
  local workerNo = self._workerNoRaw
  local maxPoint = workerWrapperLua:getMaxActionPoint()
  local currentPoint = workerWrapperLua:getActionPoint()
  local actionPointPer = workerWrapperLua:getActionPointPercents()
  if 100 <= actionPointPer then
    Proc_ShowMessage_Ack_With_ChatType(PAGetString(Defines.StringSheet_GAME, "LUA_WORLD_MAP_TOWN_WORKER_RESTORE_MAX"), nil, CppEnums.ChatType.System, CppEnums.ChatSystemType.Undefine)
    return
  end
  local recoveryItem = ToClient_getNpcRecoveryItemByIndex(self._selectedItemIdx)
  if nil == recoveryItem then
    return
  end
  local recoveryItemCount = Int64toInt32(recoveryItem._itemCount_s64)
  local slotNo = recoveryItem._slotNo
  local restorePoint = recoveryItem._contentsEventParam1
  local isContinue = false
  if true == self._isPadSnap then
    if true == self._isContinue then
      isContinue = true
      self._isContinue = false
    end
  elseif true == isKeyPressed(CppEnums.VirtualKeyCode.KeyCode_SHIFT) then
    isContinue = true
  end
  if true == isContinue then
    local restoreItemCount = ToClient_getNpcRecoveryItemList()
    local restoreActionPoint = maxPoint - currentPoint
    local itemNeedCount = math.floor(restoreActionPoint / restorePoint)
    local currentItemCount = recoveryItemCount
    if itemNeedCount > currentItemCount then
      itemNeedCount = currentItemCount
    end
    if 1 <= itemNeedCount then
      _AudioPostEvent_SystemUiForXBOX(50, 0)
      requestRecoveryWorker(WorkerNo(workerNo), slotNo, itemNeedCount)
    else
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoNpcWorkerActionPointIsOver"))
    end
    return
  end
  _AudioPostEvent_SystemUiForXBOX(50, 0)
  requestRecoveryWorker(WorkerNo(workerNo), slotNo, 1)
end
