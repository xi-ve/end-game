function PaGlobal_TotalReward_All:initialize()
  if nil == Panel_Window_TotalReward_All then
    return
  end
  if true == PaGlobal_TotalReward_All._initialize then
    return
  end
  PaGlobal_TotalReward_All._ui.stc_topGroup = UI.getChildControl(Panel_Window_TotalReward_All, "Static_TopGroup")
  PaGlobal_TotalReward_All._ui.stc_contentGroup = UI.getChildControl(Panel_Window_TotalReward_All, "Static_ContentGroup")
  PaGlobal_TotalReward_All._ui.stc_bottomGroup = UI.getChildControl(Panel_Window_TotalReward_All, "Static_BottomGroup")
  PaGlobal_TotalReward_All._ui.stc_bottom_KeyGuides = UI.getChildControl(Panel_Window_TotalReward_All, "Static_Key_Guide_ConsoleUI")
  PaGlobal_TotalReward_All._ui.btn_close = UI.getChildControl(PaGlobal_TotalReward_All._ui.stc_topGroup, "Button_Close")
  PaGlobal_TotalReward_All._ui.btn_itemLog = UI.getChildControl(PaGlobal_TotalReward_All._ui.stc_contentGroup, "StaticText_ItemLog")
  PaGlobal_TotalReward_All._ui.btn_itemLog_ConsoleUI = UI.getChildControl(PaGlobal_TotalReward_All._ui.stc_contentGroup, "StaticText_ItemLog_ConsoleUI")
  PaGlobal_TotalReward_All._ui.txt_itemLogText = UI.getChildControl(PaGlobal_TotalReward_All._ui.btn_itemLog, "StaticText_HistoryText")
  PaGlobal_TotalReward_All._ui.txt_itemLogText_ConsoleUI = UI.getChildControl(PaGlobal_TotalReward_All._ui.btn_itemLog_ConsoleUI, "StaticText_HistoryText_ConsoleUI")
  PaGlobal_TotalReward_All._ui.stc_mouseR = UI.getChildControl(PaGlobal_TotalReward_All._ui.stc_contentGroup, "StaticText_MouseR")
  PaGlobal_TotalReward_All._ui.txt_receiveBagText = UI.getChildControl(PaGlobal_TotalReward_All._ui.stc_mouseR, "StaticText_ReceiveBag")
  PaGlobal_TotalReward_All._ui.frame_BG = UI.getChildControl(PaGlobal_TotalReward_All._ui.stc_contentGroup, "Static_Frame_BG")
  PaGlobal_TotalReward_All._ui.frame_totalReward = UI.getChildControl(PaGlobal_TotalReward_All._ui.stc_contentGroup, "Frame_TotalReward")
  PaGlobal_TotalReward_All._ui.frame_content = UI.getChildControl(PaGlobal_TotalReward_All._ui.frame_totalReward, "Frame_1_Content")
  PaGlobal_TotalReward_All._ui.stc_group = UI.getChildControl(PaGlobal_TotalReward_All._ui.frame_content, "Static_Group")
  PaGlobal_TotalReward_All._ui.txt_groupTitle = UI.getChildControl(PaGlobal_TotalReward_All._ui.stc_group, "StaticText_GroupTitle")
  PaGlobal_TotalReward_All._ui.stc_itemSlotBg = UI.getChildControl(PaGlobal_TotalReward_All._ui.stc_group, "Static_ItemSlotBg")
  PaGlobal_TotalReward_All._ui.txt_noItem = UI.getChildControl(PaGlobal_TotalReward_All._ui.frame_content, "StaticText_No_Itemlog")
  PaGlobal_TotalReward_All._ui.frame_totalReward_vscroll = UI.getChildControl(PaGlobal_TotalReward_All._ui.frame_totalReward, "Frame_1_VerticalScroll")
  PaGlobal_TotalReward_All._ui.frame_totalReward_vscroll_ctrl = UI.getChildControl(PaGlobal_TotalReward_All._ui.frame_totalReward_vscroll, "Frame_1_VerticalScroll_CtrlButton")
  PaGlobal_TotalReward_All._ui.btn_receiveSilver = UI.getChildControl(PaGlobal_TotalReward_All._ui.stc_bottomGroup, "Button_Receive")
  PaGlobal_TotalReward_All._ui.btn_receiveAll = UI.getChildControl(PaGlobal_TotalReward_All._ui.stc_bottomGroup, "Button_ReceiveAll")
  PaGlobal_TotalReward_All._ui.stc_moneyArea = UI.getChildControl(PaGlobal_TotalReward_All._ui.stc_bottomGroup, "Static_MoneyArea")
  PaGlobal_TotalReward_All._ui.stc_rewardArea = UI.getChildControl(PaGlobal_TotalReward_All._ui.stc_bottomGroup, "Static_RewardCntArea")
  PaGlobal_TotalReward_All._ui.txt_moneyText = UI.getChildControl(PaGlobal_TotalReward_All._ui.stc_moneyArea, "StaticText_MoneyIcon")
  PaGlobal_TotalReward_All._ui.txt_rewardText = UI.getChildControl(PaGlobal_TotalReward_All._ui.stc_rewardArea, "StaticText_RewardCountValue")
  PaGlobal_TotalReward_All._ui.stc_KeyGuide_A = UI.getChildControl(PaGlobal_TotalReward_All._ui.stc_bottom_KeyGuides, "StaticText_Receive_ConsoleUI")
  PaGlobal_TotalReward_All._ui.stc_KeyGuide_Y = UI.getChildControl(PaGlobal_TotalReward_All._ui.stc_bottom_KeyGuides, "StaticText_Coin_ConsoleUI")
  PaGlobal_TotalReward_All._ui.stc_KeyGuide_B = UI.getChildControl(PaGlobal_TotalReward_All._ui.stc_bottom_KeyGuides, "StaticText_Close_ConsoleUI")
  PaGlobal_TotalReward_All._ui.stc_KeyGuide_ReceiveAll = UI.getChildControl(PaGlobal_TotalReward_All._ui.stc_bottom_KeyGuides, "StaticText_LTA_ReceiveAll_ConsoleUI")
  PaGlobal_TotalReward_All._ui.stc_keyGuide_Detail = UI.getChildControl(PaGlobal_TotalReward_All._ui.stc_bottom_KeyGuides, "StaticText_Detail_ConsoleUI")
  PaGlobal_TotalReward_All._isConsole = _ContentsGroup_UsePadSnapping
  UI.setLimitTextAndAddTooltip(PaGlobal_TotalReward_All._ui.txt_itemLogText)
  UI.setLimitTextAndAddTooltip(PaGlobal_TotalReward_All._ui.txt_itemLogText_ConsoleUI)
  UI.setLimitTextAndAddTooltip(PaGlobal_TotalReward_All._ui.txt_receiveBagText)
  PaGlobal_TotalReward_All._ui.txt_itemLogText:SetEnableArea(0, 0, PaGlobal_TotalReward_All._ui.txt_itemLogText:GetTextSizeX(), PaGlobal_TotalReward_All._ui.txt_itemLogText:GetSizeY())
  PaGlobal_TotalReward_All._ui.txt_groupTitle:SetShow(false)
  PaGlobal_TotalReward_All._ui.stc_itemSlotBg:SetShow(false)
  PaGlobal_TotalReward_All._ui.txt_noItem:SetTextMode(__eTextMode_AutoWrap)
  PaGlobal_TotalReward_All._ui.txt_noItem:SetText(PaGlobal_TotalReward_All._ui.txt_noItem:GetText())
  PaGlobal_TotalReward_All._COL_SLOT_COUNT = math.floor(PaGlobal_TotalReward_All._ui.frame_content:GetSizeX() / (PaGlobal_TotalReward_All._ICONSIZE + 10))
  PaGlobal_TotalReward_All._CONTENT_FRAME_SIZE_Y = PaGlobal_TotalReward_All._ui.frame_content:GetSizeY()
  PaGlobal_TotalReward_All._ORIGIN_PANEL_SIZE_Y = Panel_Window_TotalReward_All:GetSizeY()
  PaGlobal_TotalReward_All:setHistoryIcon(false)
  PaGlobal_TotalReward_All:setConsoleUI()
  PaGlobal_TotalReward_All:registEventHandler()
  PaGlobal_TotalReward_All:validate()
  PaGlobal_TotalReward_All._initialize = true
end
function PaGlobal_TotalReward_All:registEventHandler()
  if nil == Panel_Window_TotalReward_All then
    return
  end
  registerEvent("FromClient_PendingRewardUpdated", "FromClient_TotalReward_All_PendingRewardUpdated")
  PaGlobal_TotalReward_All._ui.btn_close:addInputEvent("Mouse_LUp", "PaGlobal_TotalReward_All_Close()")
  if true == PaGlobal_TotalReward_All._isConsole then
    Panel_Window_TotalReward_All:registerPadEvent(__eConsoleUIPadEvent_LSClick, "HandleEventLUp_TotalReward_All_History_ToggleShow()")
    Panel_Window_TotalReward_All:registerPadEvent(__eConsoleUIPadEvent_Y, "HandleEventLUp_TotalReward_All_ReceiveSilver()")
    Panel_Window_TotalReward_All:registerPadEvent(__eConsoleUIPadEvent_LTPress_A, "HandleEventLUp_TotalReward_All_ReceiveAll()")
  else
    PaGlobal_TotalReward_All._ui.btn_itemLog:addInputEvent("Mouse_LUp", "HandleEventLUp_TotalReward_All_History_ToggleShow()")
    PaGlobal_TotalReward_All._ui.txt_itemLogText:addInputEvent("Mouse_LUp", "HandleEventLUp_TotalReward_All_History_ToggleShow()")
    PaGlobal_TotalReward_All._ui.btn_receiveSilver:addInputEvent("Mouse_LUp", "HandleEventLUp_TotalReward_All_ReceiveSilver()")
    PaGlobal_TotalReward_All._ui.btn_receiveAll:addInputEvent("Mouse_LUp", "HandleEventLUp_TotalReward_All_ReceiveAll()")
  end
end
function PaGlobal_TotalReward_All:setConsoleUI()
  if true == PaGlobal_TotalReward_All._isConsole then
    PaGlobal_TotalReward_All._ui.btn_close:SetShow(false)
    PaGlobal_TotalReward_All._ui.stc_mouseR:SetShow(false)
    PaGlobal_TotalReward_All._ui.btn_receiveSilver:SetShow(false)
    PaGlobal_TotalReward_All._ui.btn_receiveAll:SetShow(false)
    PaGlobal_TotalReward_All._ui.btn_itemLog:SetShow(false)
    PaGlobal_TotalReward_All._ui.btn_itemLog_ConsoleUI:SetShow(true)
    PaGlobal_TotalReward_All._ui.stc_bottom_KeyGuides:SetShow(true)
    Panel_Window_TotalReward_All:SetSize(Panel_Window_TotalReward_All:GetSizeX(), Panel_Window_TotalReward_All:GetSizeY() - PaGlobal_TotalReward_All._ui.btn_receiveSilver:GetSizeY() - 10)
    PaGlobal_TotalReward_All._ui.stc_bottom_KeyGuides:SetPosY(Panel_Window_TotalReward_All:GetSizeY())
    local keyGuides = {
      PaGlobal_TotalReward_All._ui.stc_KeyGuide_B,
      PaGlobal_TotalReward_All._ui.stc_keyGuide_Detail,
      PaGlobal_TotalReward_All._ui.stc_KeyGuide_A,
      PaGlobal_TotalReward_All._ui.stc_KeyGuide_Y,
      PaGlobal_TotalReward_All._ui.stc_KeyGuide_ReceiveAll
    }
    PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyGuides, PaGlobal_TotalReward_All._ui.stc_bottom_KeyGuides, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP)
  else
    PaGlobal_TotalReward_All._ui.btn_close:SetShow(true)
    PaGlobal_TotalReward_All._ui.stc_mouseR:SetShow(true)
    PaGlobal_TotalReward_All._ui.btn_receiveSilver:SetShow(true)
    PaGlobal_TotalReward_All._ui.btn_receiveAll:SetShow(true)
    PaGlobal_TotalReward_All._ui.btn_itemLog:SetShow(true)
    PaGlobal_TotalReward_All._ui.btn_itemLog_ConsoleUI:SetShow(false)
    PaGlobal_TotalReward_All._ui.stc_bottom_KeyGuides:SetShow(false)
    Panel_Window_TotalReward_All:SetSize(Panel_Window_TotalReward_All:GetSizeX(), PaGlobal_TotalReward_All._ORIGIN_PANEL_SIZE_Y)
  end
end
function PaGlobal_TotalReward_All:setHistoryIcon(isOn)
  if true == PaGlobal_TotalReward_All._isConsole then
    return
  end
  if true == isOn then
    local x1, y1, x2, y2 = setTextureUV_Func(PaGlobal_TotalReward_All._ui.btn_itemLog, 89, 434, 117, 462)
    PaGlobal_TotalReward_All._ui.btn_itemLog:getBaseTexture():setUV(x1, y1, x2, y2)
    local onX1, onY1, onX2, onY2 = setTextureUV_Func(PaGlobal_TotalReward_All._ui.btn_itemLog, 118, 434, 146, 462)
    PaGlobal_TotalReward_All._ui.btn_itemLog:getOnTexture():setUV(onX1, onY1, onX2, onY2)
    local clickX1, clickY1, clickX2, clickY2 = setTextureUV_Func(PaGlobal_TotalReward_All._ui.btn_itemLog, 147, 434, 175, 462)
    PaGlobal_TotalReward_All._ui.btn_itemLog:getClickTexture():setUV(clickX1, clickY1, clickX2, clickY2)
    PaGlobal_TotalReward_All._ui.btn_itemLog:setRenderTexture(PaGlobal_TotalReward_All._ui.btn_itemLog:getBaseTexture())
  else
    local x1, y1, x2, y2 = setTextureUV_Func(PaGlobal_TotalReward_All._ui.btn_itemLog, 117, 434, 89, 462)
    PaGlobal_TotalReward_All._ui.btn_itemLog:getBaseTexture():setUV(x1, y1, x2, y2)
    local onX1, onY1, onX2, onY2 = setTextureUV_Func(PaGlobal_TotalReward_All._ui.btn_itemLog, 146, 434, 118, 462)
    PaGlobal_TotalReward_All._ui.btn_itemLog:getOnTexture():setUV(onX1, onY1, onX2, onY2)
    local clickX1, clickY1, clickX2, clickY2 = setTextureUV_Func(PaGlobal_TotalReward_All._ui.btn_itemLog, 175, 434, 147, 462)
    PaGlobal_TotalReward_All._ui.btn_itemLog:getClickTexture():setUV(clickX1, clickY1, clickX2, clickY2)
    PaGlobal_TotalReward_All._ui.btn_itemLog:setRenderTexture(PaGlobal_TotalReward_All._ui.btn_itemLog:getBaseTexture())
  end
end
function PaGlobal_TotalReward_All:prepareOpen()
  if nil == Panel_Window_TotalReward_All then
    return
  end
  PaGlobal_TotalReward_All._ui.frame_totalReward:GetVScroll():SetControlTop()
  PaGlobal_TotalReward_All:update()
  warehouse_requestInfoByCurrentRegionMainTown()
  PaGlobal_TotalRewardHistory_All_Open()
  PaGlobal_TotalReward_All:open()
end
function PaGlobal_TotalReward_All:open()
  if nil == Panel_Window_TotalReward_All then
    return
  end
  Panel_Window_TotalReward_All:SetShow(true)
end
function PaGlobal_TotalReward_All:prepareClose()
  if nil == Panel_Window_TotalReward_All then
    return
  end
  PaGlobal_TotalReward_All:resetSlot()
  PaGlobal_TotalReward_All:setHistoryIcon(false)
  PaGlobal_TotalRewardHistory_All_Close()
  PaGlobal_TotalReward_All:close()
end
function PaGlobal_TotalReward_All:close()
  if nil == Panel_Window_TotalReward_All then
    return
  end
  Panel_Window_TotalReward_All:SetShow(false)
end
function PaGlobal_TotalReward_All:receiveSilver()
  if nil == Panel_Window_TotalReward_All then
    return
  end
  if nil == PaGlobal_TotalReward_All._rewardSilver or toInt64(0, 0) == PaGlobal_TotalReward_All._rewardSilver then
    return
  end
  local messageBoxData = {
    title = PAGetString(Defines.StringSheet_GAME, "LUA_TOTALREWARD_CHECKBOX_SILVER_TITLE"),
    content = PAGetString(Defines.StringSheet_GAME, "LUA_TOTALREWARD_CHECKBOX_SILVER_DESC"),
    functionApply = PaGlobal_TotalReward_All_ConfirmReceiveSilver,
    functionCancel = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBoxCheck.showMessageBoxForRegion(messageBoxData)
end
function PaGlobal_TotalReward_All:receiveAll()
  if nil == Panel_Window_TotalReward_All then
    return
  end
  local messageBoxData = {
    title = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_BLACKSPIRITGIFT_ALLITEMGET"),
    content = PAGetString(Defines.StringSheet_GAME, "LUA_BLACKSPIRITGIFT_RECEIVEALLITEM_DESC"),
    functionApply = PaGlobal_TotalReward_All_ConfirmReceiveAll,
    functionCancel = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageBoxData)
end
function PaGlobal_TotalReward_All:receiveItem(rewardKey, index, toWarehouse)
  if nil == Panel_Window_TotalReward_All then
    return
  end
  if nil == rewardKey or nil == index or nil == toWarehouse then
    return
  end
  if nil == PaGlobal_TotalReward_All._uiSlot[rewardKey] then
    return
  end
  local uiSlot = PaGlobal_TotalReward_All._uiSlot[rewardKey][index]
  if nil == uiSlot then
    return
  end
  if nil == PaGlobal_TotalReward_All._itemDatas[rewardKey] then
    return
  end
  local itemDatas = PaGlobal_TotalReward_All._itemDatas[rewardKey][index]
  if nil == itemDatas then
    return
  end
  local itemIdx = itemDatas.itemIndex
  if nil == itemIdx then
    return
  end
  local itemKey = ToClient_GetPendingRewardItemKeyByIndex(itemIdx)
  if nil == itemKey then
    return
  end
  ToClient_ReceivePendingReward(itemIdx, toWarehouse)
end
function PaGlobal_TotalReward_All:resetSlot()
  if nil == Panel_Window_TotalReward_All then
    return
  end
  local slotIndex = 1
  for rewardKey, slotDatas in pairs(PaGlobal_TotalReward_All._uiSlot) do
    if nil ~= slotDatas then
      for index, uiSlot in pairs(slotDatas) do
        if nil ~= uiSlot then
          Panel_Tooltip_Item_Show_GeneralStatic(slotIndex, "totalReward", false, false)
          uiSlot:clearItem()
          uiSlot.iconBg:SetShow(false)
          if true == PaGlobal_TotalReward_All._isConsole then
            uiSlot.icon:registerPadEvent(__eConsoleUIPadEvent_A, "")
          else
            uiSlot.icon:addInputEvent("Mouse_RUp", "")
          end
          uiSlot.icon:addInputEvent("Mouse_On", "")
          uiSlot.icon:addInputEvent("Mouse_Out", "")
          slotIndex = slotIndex + 1
        end
      end
    end
  end
end
function PaGlobal_TotalReward_All:dataSet()
  if nil == Panel_Window_TotalReward_All then
    return
  end
  PaGlobal_TotalReward_All._itemDatas = {}
  PaGlobal_TotalReward_All._rewardSilver = toInt64(0, 0)
  PaGlobal_TotalReward_All._rewardSilverIndex = {}
  PaGlobal_TotalReward_All:resetSlot()
  local rewardCnt = ToClient_GetPendingRewardCount()
  PaGlobal_TotalReward_All._ui.txt_noItem:SetShow(true)
  rewardCnt = Int64toInt32(rewardCnt)
  local itemCount = 0
  local silverFlag = false
  if 0 < rewardCnt then
    for ii = 1, rewardCnt do
      local rewardKey = ToClient_GetPendingRewardTypeByIndex(ii - 1)
      local itemKey = ToClient_GetPendingRewardItemKeyByIndex(ii - 1)
      local itemCnt = ToClient_GetPendingRewardItemCountByIndex(ii - 1)
      if nil ~= rewardKey and nil ~= itemKey and nil ~= itemCnt then
        if 1 ~= itemKey then
          itemCnt = Int64toInt32(itemCnt)
          if nil == PaGlobal_TotalReward_All._itemDatas[rewardKey] then
            PaGlobal_TotalReward_All._itemDatas[rewardKey] = {}
            if nil == PaGlobal_TotalReward_All._categoryGroups[rewardKey] then
              PaGlobal_TotalReward_All._categoryGroups[rewardKey] = {}
              local tempContent = UI.createAndCopyBasePropertyControl(PaGlobal_TotalReward_All._ui.frame_content, "Static_Group", PaGlobal_TotalReward_All._ui.frame_content, "TotalRewardGroup_" .. rewardKey)
              if nil ~= tempContent then
                local tempTitle = UI.createAndCopyBasePropertyControl(PaGlobal_TotalReward_All._ui.stc_group, "StaticText_GroupTitle", tempContent, "TotalRewardGroup_Title_" .. rewardKey)
                if nil ~= tempTitle then
                  PaGlobal_TotalReward_All._categoryGroups[rewardKey].content = tempContent
                  tempTitle:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_TOTALREWARD_CATEGORY_" .. rewardKey))
                  PaGlobal_TotalReward_All._categoryGroups[rewardKey].title = tempTitle
                else
                  return
                end
              else
                return
              end
            end
          end
          PaGlobal_TotalReward_All._itemDatas[rewardKey][#PaGlobal_TotalReward_All._itemDatas[rewardKey] + 1] = {}
          PaGlobal_TotalReward_All._itemDatas[rewardKey][#PaGlobal_TotalReward_All._itemDatas[rewardKey]].itemIndex = ii - 1
          PaGlobal_TotalReward_All._itemDatas[rewardKey][#PaGlobal_TotalReward_All._itemDatas[rewardKey]].rewardKey = rewardKey
          PaGlobal_TotalReward_All._itemDatas[rewardKey][#PaGlobal_TotalReward_All._itemDatas[rewardKey]].itemKey = itemKey
          PaGlobal_TotalReward_All._itemDatas[rewardKey][#PaGlobal_TotalReward_All._itemDatas[rewardKey]].itemCnt = itemCnt
          itemCount = itemCount + 1
          PaGlobal_TotalReward_All._ui.txt_noItem:SetShow(false)
        else
          PaGlobal_TotalReward_All._rewardSilver = PaGlobal_TotalReward_All._rewardSilver + itemCnt
          PaGlobal_TotalReward_All._rewardSilverIndex[#PaGlobal_TotalReward_All._rewardSilverIndex + 1] = ii - 1
          if false == silverFlag then
            itemCount = itemCount + 1
            silverFlag = true
          end
        end
      end
    end
    PaGlobal_TotalReward_All._ui.btn_receiveAll:SetMonoTone(false)
    PaGlobal_TotalReward_All._ui.btn_receiveAll:SetIgnore(false)
    PaGlobal_TotalReward_All._ui.txt_noItem:SetShow(false)
    if 1 == itemCount and true == silverFlag then
      PaGlobal_TotalReward_All._ui.btn_receiveAll:SetMonoTone(true)
      PaGlobal_TotalReward_All._ui.btn_receiveAll:SetIgnore(true)
    end
  else
    PaGlobal_TotalReward_All._ui.btn_receiveAll:SetMonoTone(true)
    PaGlobal_TotalReward_All._ui.btn_receiveAll:SetIgnore(true)
    PaGlobal_TotalReward_All._ui.txt_noItem:SetShow(true)
  end
  PaGlobal_TotalReward_All._ui.txt_rewardText:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_ENDURANCE_RECOVERY_METERIALITEMCNT", "count", itemCount))
  if toInt64(0, 0) == PaGlobal_TotalReward_All._rewardSilver then
    PaGlobal_TotalReward_All._ui.btn_receiveSilver:SetMonoTone(true)
    PaGlobal_TotalReward_All._ui.btn_receiveSilver:SetIgnore(true)
  else
    PaGlobal_TotalReward_All._ui.btn_receiveSilver:SetMonoTone(false)
    PaGlobal_TotalReward_All._ui.btn_receiveSilver:SetIgnore(false)
  end
end
function PaGlobal_TotalReward_All:update()
  if nil == Panel_Window_TotalReward_All then
    return
  end
  PaGlobal_TotalReward_All:dataSet()
  PaGlobal_TotalRewardHistory_All_Update()
  PaGlobal_TotalReward_All._ui.txt_moneyText:SetText(0)
  if toInt64(0, 0) < PaGlobal_TotalReward_All._rewardSilver then
    PaGlobal_TotalReward_All._ui.txt_moneyText:SetText(makeDotMoney(PaGlobal_TotalReward_All._rewardSilver))
  end
  for index, value in pairs(PaGlobal_TotalReward_All._categoryGroups) do
    if nil == value or nil == value.content or nil == value.title then
      return
    end
    value.content:SetShow(false)
  end
  local slotIndex = 1
  local nextPosY = 0
  for rewardKey, rewardDatas in pairs(PaGlobal_TotalReward_All._itemDatas) do
    PaGlobal_TotalReward_All._categoryGroups[rewardKey].content:SetShow(true)
    for index, itemDatas in pairs(rewardDatas) do
      if nil ~= itemDatas then
        if nil == PaGlobal_TotalReward_All._uiSlot[rewardKey] then
          PaGlobal_TotalReward_All._uiSlot[rewardKey] = {}
        end
        local uiSlot = PaGlobal_TotalReward_All._uiSlot[rewardKey][index]
        local row = math.floor((index - 1) / PaGlobal_TotalReward_All._COL_SLOT_COUNT)
        local col = (index - 1) % PaGlobal_TotalReward_All._COL_SLOT_COUNT
        PaGlobal_TotalReward_All._categoryGroups[rewardKey].content:SetSize(PaGlobal_TotalReward_All._categoryGroups[rewardKey].content:GetSizeX(), 100 + (PaGlobal_TotalReward_All._ICONSIZE + 10) * row)
        if nil == uiSlot then
          PaGlobal_TotalReward_All._uiSlot[rewardKey][index] = {}
          if nil == PaGlobal_TotalReward_All._categoryGroups[rewardKey].content then
            return
          end
          local itemSlotBg = UI.createAndCopyBasePropertyControl(PaGlobal_TotalReward_All._ui.stc_group, "Static_ItemSlotBg", PaGlobal_TotalReward_All._categoryGroups[rewardKey].content, "TotalReward_SlotBG_" .. rewardKey .. "_" .. index)
          local slot = {}
          SlotItem.new(slot, "TotalReward_Slot_" .. rewardKey .. "_" .. index, index, itemSlotBg, PaGlobal_TotalReward_All._slotConfig)
          slot:createChild()
          slot.iconBg = itemSlotBg
          itemSlotBg:SetPosX(15 + (PaGlobal_TotalReward_All._ICONSIZE + 10) * col)
          itemSlotBg:SetPosY(45 + (PaGlobal_TotalReward_All._ICONSIZE + 10) * row)
          itemSlotBg:SetShow(true)
          PaGlobal_TotalReward_All._uiSlot[rewardKey][index] = slot
          uiSlot = slot
          slot.icon:SetAutoDisableTime(0.5)
        end
        local rewardKey = itemDatas.rewardKey
        local itemKey = itemDatas.itemKey
        local itemCnt = itemDatas.itemCnt
        if nil ~= rewardKey and nil ~= itemKey and nil ~= itemCnt then
          local itemStatic = getItemEnchantStaticStatus(ItemEnchantKey(itemKey))
          if nil ~= itemStatic and 1 ~= itemKey then
            uiSlot.iconBg:SetShow(true)
            uiSlot:setItemByStaticStatus(itemStatic, itemCnt)
            uiSlot.count:SetText(tostring(itemCnt))
            uiSlot.count:SetShow(true)
            uiSlot._item = itemKey
            Panel_Tooltip_Item_SetPosition(slotIndex, uiSlot, "totalReward")
            if true == PaGlobal_TotalReward_All._isConsole then
              uiSlot.iconBg:registerPadEvent(__eConsoleUIPadEvent_Up_A, "HandleEventRUp_TotalReward_All_ReceiveSlot(" .. rewardKey .. "," .. index .. ")")
              uiSlot.iconBg:registerPadEvent(__eConsoleUIPadEvent_X, "HandlePadEventX_TotalReward_All_SlotTooltip(" .. itemKey .. ")")
            else
              uiSlot.icon:addInputEvent("Mouse_RUp", "HandleEventRUp_TotalReward_All_ReceiveSlot(" .. rewardKey .. "," .. index .. ")")
              uiSlot.icon:addInputEvent("Mouse_On", "HandleEventOn_TotalReward_All_SlotTooltip(" .. rewardKey .. "," .. index .. "," .. slotIndex .. ", true)")
              uiSlot.icon:addInputEvent("Mouse_Out", "HandleEventOn_TotalReward_All_SlotTooltip(" .. rewardKey .. "," .. index .. "," .. slotIndex .. ", false)")
            end
            slotIndex = slotIndex + 1
          end
        end
      end
    end
    PaGlobal_TotalReward_All._categoryGroups[rewardKey].content:SetPosY(nextPosY)
    nextPosY = nextPosY + PaGlobal_TotalReward_All._categoryGroups[rewardKey].content:GetSizeY()
    PaGlobal_TotalReward_All._ui.frame_content:SetSize(PaGlobal_TotalReward_All._ui.frame_content:GetSizeX(), nextPosY)
  end
  local tempSizeY = PaGlobal_TotalReward_All._ui.frame_totalReward_vscroll:GetSizeY() * (PaGlobal_TotalReward_All._CONTENT_FRAME_SIZE_Y / nextPosY)
  PaGlobal_TotalReward_All._ui.frame_totalReward_vscroll_ctrl:SetSize(PaGlobal_TotalReward_All._ui.frame_totalReward_vscroll_ctrl:GetSizeX(), tempSizeY)
  PaGlobal_TotalReward_All._ui.frame_totalReward:UpdateContentScroll()
  PaGlobal_TotalReward_All._ui.frame_totalReward:UpdateContentPos()
end
function PaGlobal_TotalReward_All:validate()
  if nil == Panel_Window_TotalReward_All then
    return
  end
  PaGlobal_TotalReward_All._ui.stc_topGroup:isValidate()
  PaGlobal_TotalReward_All._ui.stc_contentGroup:isValidate()
  PaGlobal_TotalReward_All._ui.stc_bottomGroup:isValidate()
  PaGlobal_TotalReward_All._ui.stc_bottom_KeyGuides:isValidate()
  PaGlobal_TotalReward_All._ui.btn_close:isValidate()
  PaGlobal_TotalReward_All._ui.btn_itemLog:isValidate()
  PaGlobal_TotalReward_All._ui.stc_mouseR:isValidate()
  PaGlobal_TotalReward_All._ui.frame_BG:isValidate()
  PaGlobal_TotalReward_All._ui.frame_totalReward:isValidate()
  PaGlobal_TotalReward_All._ui.frame_content:isValidate()
  PaGlobal_TotalReward_All._ui.stc_group:isValidate()
  PaGlobal_TotalReward_All._ui.txt_groupTitle:isValidate()
  PaGlobal_TotalReward_All._ui.stc_itemSlotBg:isValidate()
  PaGlobal_TotalReward_All._ui.txt_noItem:isValidate()
  PaGlobal_TotalReward_All._ui.frame_totalReward_vscroll:isValidate()
  PaGlobal_TotalReward_All._ui.frame_totalReward_vscroll_ctrl:isValidate()
  PaGlobal_TotalReward_All._ui.btn_receiveSilver:isValidate()
  PaGlobal_TotalReward_All._ui.btn_receiveAll:isValidate()
  PaGlobal_TotalReward_All._ui.stc_moneyArea:isValidate()
  PaGlobal_TotalReward_All._ui.stc_rewardArea:isValidate()
  PaGlobal_TotalReward_All._ui.txt_moneyText:isValidate()
  PaGlobal_TotalReward_All._ui.txt_rewardText:isValidate()
end
