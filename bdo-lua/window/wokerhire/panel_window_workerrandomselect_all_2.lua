function HandleEventOnOut_WorkerRandomSelect_All_SimpleTooltips(tipType, isShow)
  if nil == Panel_Window_WorkerRandomSelect_All or false == Panel_Window_WorkerRandomSelect_All:GetShow() then
    return
  end
  local name, desc, control
  if 0 == tipType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_ITEMMARKET_TOOLTIP_INVEN_NAME")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_ITEMMARKET_TOOLTIP_INVEN_DESC")
    control = PaGlobal_WorkerRandomSelect_All._ui._rdo_WareMoney
  elseif 1 == tipType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_ITEMMARKET_TOOLTIP_WAREHOUSE_NAME")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_ITEMMARKET_TOOLTIP_WAREHOUSE_DESC")
    control = PaGlobal_WorkerRandomSelect_All._ui._rdo_InvenMoney
  end
  if isShow == true then
    registTooltipControl(control, Panel_Tooltip_SimpleText)
    TooltipSimple_Show(control, name, desc)
  else
    TooltipSimple_Hide()
  end
end
function FromClient_WorkerRandomSelect_All_OnScreenResize()
  if nil == Panel_Window_WorkerRandomSelect_All then
    return
  end
  PaGlobal_WorkerRandomSelect_All:onScreenResize()
end
function HandleEventLUp_WorkerRandomSelect_All_Close(isDialogClose)
  if nil == Panel_Window_WorkerRandomSelect_All then
    return
  end
  if false == PaGlobal_WorkerRandomSelect_All._isCurrectWorkerCondition or true == PaGlobal_WorkerRandomSelect_All._isContinueSelectWorkerStart then
    PaGlobal_WorkerRandomSelect_All:clearData()
    return
  end
  if false == PaGlobal_WorkerRandomSelect_All._isConsole then
    if true == Panel_Window_WorkerRandomSelectOption_All:GetShow() then
      HandleEventLUp_WorkerRandomSelectOption_All_Close()
      return
    end
  elseif true == Panel_Window_WorkerRandomSelectOption_All:GetShow() then
    HandleEventLUp_WorkerRandomSelectOption_All_CloseForConsole()
    return
  end
  PaGlobal_WorkerRandomSelect_All:prepareClose()
end
function HandleEventLUp_WorkerRandomSelect_All_ForceClose()
  if nil == Panel_Window_WorkerRandomSelect_All or false == Panel_Window_WorkerRandomSelect_All:GetShow() then
    return
  end
  if false == PaGlobal_WorkerRandomSelect_All._isCurrectWorkerCondition or true == PaGlobal_WorkerRandomSelect_All._isContinueSelectWorkerStart then
    PaGlobal_WorkerRandomSelect_All:clearData()
  end
  HandleEventLUp_WorkerRandomSelectOption_All_Close()
  HandleEventLUp_WorkerRandomSelect_All_Close()
end
function HandleEventLUp_WorkerRandomSelect_WorkerReSelect()
  if nil == Panel_Window_WorkerRandomSelect_All then
    return
  end
  if nil == getSelfPlayer() then
    return
  end
  local pcPosition = getSelfPlayer():get():getPosition()
  local regionInfo = getRegionInfoByPosition(pcPosition)
  local region = regionInfo:get()
  local regionPlantKey = regionInfo:getPlantKeyByWaypointKey()
  local waitWorkerCount = ToClient_getPlantWaitWorkerListCount(regionPlantKey, 0)
  local maxWorkerCount = ToClient_getTownWorkerMaxCapacity(regionPlantKey)
  if waitWorkerCount == maxWorkerCount then
    local buyCash = function()
      PaGlobal_EasyBuy:Open(16, getCurrentWaypointKey())
    end
    if isGameTypeKorea() and false == isGameServiceTypeConsole() and _ContentsGroup_EasyBuy then
      local messageboxData = {
        title = PAGetString(Defines.StringSheet_GAME, "Lua_WorkerShop_ReSelect"),
        content = PAGetString(Defines.StringSheet_GAME, "Lua_WorkerShop_Cant_Employ") .. [[


]] .. PAGetString(Defines.StringSheet_GAME, "LUA_WORKERHOUSE_EASYBUY"),
        functionYes = buyCash,
        functionNo = MessageBox_Empty_function,
        priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
      }
      MessageBox.showMessageBox(messageboxData)
    else
      local messageboxData = {
        title = PAGetString(Defines.StringSheet_GAME, "Lua_WorkerShop_ReSelect"),
        content = PAGetString(Defines.StringSheet_GAME, "Lua_WorkerShop_Cant_Employ"),
        functionApply = MessageBox_Empty_function,
        priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
      }
      MessageBox.showMessageBox(messageboxData)
    end
    return
  end
  local contentString = PAGetString(Defines.StringSheet_GAME, "Lua_WorkerShop_ReSelect_Question") .. PAGetStringParam1(Defines.StringSheet_GAME, "LUA_WORKERRANDOMSELECT_NOWWP", "getWp", getSelfPlayer():getWp())
  local Worker_RequestShopList = function()
    if nil ~= getSelfPlayer() then
      local myWp = getSelfPlayer():getWp()
      local isReselectAble = myWp < 5
      if isReselectAble then
        Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_WORKERRANDOMSELECT_SHORTAGE_WP_ACK"))
        PaGlobal_WorkerRandomSelect_All:prepareClose()
      else
        npcShop_requestList(CppEnums.ContentsType.Contents_Shop)
        if isReselectAble then
          if true == PaGlobal_WorkerRandomSelect_All._isConsole then
            Panel_Window_WorkerRandomSelect_All:registerPadEvent(__eConsoleUIPadEvent_RTPress_X, "")
            Panel_Window_WorkerRandomSelect_All:registerPadEvent(__eConsoleUIPadEvent_Up_X, "")
          else
            PaGlobal_WorkerRandomSelect_All._ui._btn_OtherWorker_PC:SetEnable(false)
            PaGlobal_WorkerRandomSelect_All._ui._btn_OtherWorker_PC:SetMonoTone(true)
            PaGlobal_WorkerRandomSelect_All._ui._btn_Continuation_PC:SetEnable(false)
            PaGlobal_WorkerRandomSelect_All._ui._btn_Continuation_PC:SetMonoTone(true)
          end
        elseif true == PaGlobal_WorkerRandomSelect_All._isConsole then
          Panel_Window_WorkerRandomSelect_All:registerPadEvent(__eConsoleUIPadEvent_RTPress_X, "HandleEventLUp_WorkerRandomSelectOption_All_Open()")
          Panel_Window_WorkerRandomSelect_All:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandleEventLUp_WorkerRandomSelect_WorkerReSelect()")
        else
          PaGlobal_WorkerRandomSelect_All._ui._btn_OtherWorker_PC:SetEnable(true)
          PaGlobal_WorkerRandomSelect_All._ui._btn_OtherWorker_PC:SetMonoTone(false)
          PaGlobal_WorkerRandomSelect_All._ui._btn_Continuation_PC:SetEnable(true)
          PaGlobal_WorkerRandomSelect_All._ui._btn_Continuation_PC:SetMonoTone(false)
        end
      end
      if true == PaGlobal_WorkerRandomSelect_All._isConsole then
        PaGlobal_WorkerRandomSelect_All._ui._stc_KeyGuide_X_With_RT:SetShow(not isReselectAble)
        PaGlobal_WorkerRandomSelect_All._ui._stc_KeyGuide_X:SetShow(not isReselectAble)
      end
      PaGlobalFunc_ConsoleKeyGuide_SetAlign(PaGlobal_WorkerRandomSelect_All._keyGuides, PaGlobal_WorkerRandomSelect_All._ui._stc_KeyGuideBg, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP)
    end
  end
  local messageboxData = {
    title = PAGetString(Defines.StringSheet_GAME, "Lua_WorkerShop_ReSelect"),
    content = contentString,
    functionYes = Worker_RequestShopList,
    functionCancel = PaGlobalFunc_WorkerRandomSelect_All_SetSnapToThisPanel,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageboxData)
end
function HandleEventLUp_WorkerRandomSelect_WorkerSelect()
  if nil == Panel_Window_WorkerRandomSelect_All then
    return
  end
  if nil == getSelfPlayer() or nil == PaGlobal_WorkerRandomSelect_All._currentWorkerinfo._workerIdx or nil == PaGlobal_WorkerRandomSelect_All._currentWorkerinfo._workerPrice64 then
    return
  end
  if false == PaGlobal_WorkerRandomSelect_All._isCurrectWorkerCondition or true == PaGlobal_WorkerRandomSelect_All._isContinueSelectWorkerStart then
    PaGlobal_WorkerRandomSelect_All:clearData()
  end
  local selfPlayer = getSelfPlayer()
  local myInvenMoney64 = selfPlayer:get():getInventory():getMoney_s64()
  local myWareHouseMoney64 = warehouse_moneyFromNpcShop_s64()
  local workeridx = PaGlobal_WorkerRandomSelect_All._currentWorkerinfo._workerIdx
  local workerPrice64 = PaGlobal_WorkerRandomSelect_All._currentWorkerinfo._workerPrice64
  local IsCheckInven = PaGlobal_WorkerRandomSelect_All._ui._rdo_InvenMoney:IsCheck()
  local IsCheckWare = PaGlobal_WorkerRandomSelect_All._ui._rdo_WareMoney:IsCheck()
  local function Worker_RequestDoBuy()
    local fromWhereType = CppEnums.ItemWhereType.eInventory
    if true == IsCheckWare then
      fromWhereType = CppEnums.ItemWhereType.eWarehouse
    end
    npcShop_doBuy(workeridx, 1, fromWhereType, 0, false)
    if false == PaGlobal_WorkerRandomSelect_All._isConsole then
      Panel_MyHouseNavi_Update(true)
    end
    PaGlobal_WorkerRandomSelect_All._currentWorkerinfo = {}
    PaGlobal_WorkerRandomSelect_All:prepareClose()
  end
  if myInvenMoney64 < workerPrice64 and true == IsCheckInven or myWareHouseMoney64 < workerPrice64 and true == IsCheckWare then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_KNOWLEDGEMANAGEMENT_ACK_MAKEBOOK"))
  else
    local messageboxData = {
      title = PAGetString(Defines.StringSheet_GAME, "Lua_WorkerShop_Employ"),
      content = PAGetString(Defines.StringSheet_GAME, "Lua_WorkerShop_Employ_Question"),
      functionYes = Worker_RequestDoBuy,
      functionCancel = PaGlobalFunc_WorkerRandomSelect_All_SetSnapToThisPanel,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageboxData)
  end
end
function FromClient_EventRandomShopShow_Worker(shopType, slotNo)
  if nil == Panel_Window_WorkerRandomSelect_All then
    return
  end
  if 7 == shopType then
    if true == PaGlobal_WorkerRandomSelect_All._isContinueSelectWorkerStart then
      PaGlobalFunc_WorkerRandomSelect_All_CheckCondition(slotNo)
    else
      PaGlobal_WorkerRandomSelect_All:prepareOpen()
      PaGlobal_WorkerRandomSelect_All:update(slotNo)
    end
  end
end
function PaGlobalFunc_WorkerRandomSelect_All_SetConfig(grade, count)
  if nil == Panel_Window_WorkerRandomSelect_All then
    return
  end
  if nil == grade or nil == count then
    return
  end
  Panel_Window_WorkerRandomSelect_All:RegisterUpdateFunc("PaGlobalFunc_WorkerRandomSelect_All_UpdatePerFrameFunc")
  PaGlobal_WorkerRandomSelect_All._config._workerGrade = grade
  PaGlobal_WorkerRandomSelect_All._config._repetitionCount = count
  PaGlobal_WorkerRandomSelect_All._isContinueSelectWorkerStart = true
  npcShop_requestList(CppEnums.ContentsType.Contents_Shop)
  PaGlobal_WorkerRandomSelect_All:setButtonWhilePerFrame(false)
  if true == PaGlobal_WorkerRandomSelect_All._isConsole then
    PaGlobal_WorkerRandomSelect_All:switchKeyGuide(true)
  end
end
function PaGlobalFunc_WorkerRandomSelect_All_CheckCondition(slotNo)
  if nil == Panel_Window_WorkerRandomSelect_All or false == Panel_Window_WorkerRandomSelect_All:GetShow() then
    return
  end
  local sellCount = npcShop_getBuyCount()
  local CurrentGradeFilter = PaGlobal_WorkerRandomSelect_All._config._workerGrade
  for index = 0, sellCount - 1 do
    local itemwrapper = npcShop_getItemBuy(index)
    local shopItem = itemwrapper:get()
    if slotNo == shopItem.shopSlotNo then
      local plantWorkerSS = itemwrapper:getPlantWorkerStaticStatus()
      local efficiency = plantWorkerSS:getEfficiency(2, ItemExchangeKey(0))
      local plantWorkerGrade = plantWorkerSS:getCharacterStaticStatus()._gradeType:get()
      local isFindWorker = false
      if 0 == CurrentGradeFilter then
        if 1 == plantWorkerGrade or 2 == plantWorkerGrade or 3 == plantWorkerGrade or 4 == plantWorkerGrade then
          isFindWorker = true
        end
      elseif 1 == CurrentGradeFilter then
        if 2 == plantWorkerGrade or 3 == plantWorkerGrade or 4 == plantWorkerGrade then
          isFindWorker = true
        end
      elseif 2 == CurrentGradeFilter then
        if 3 == plantWorkerGrade or 4 == plantWorkerGrade then
          isFindWorker = true
        end
      elseif 3 == CurrentGradeFilter and 4 == plantWorkerGrade then
        isFindWorker = true
      end
      if nil ~= plantWorkerSS then
        PaGlobal_WorkerRandomSelect_All:updateWp()
        PaGlobal_WorkerRandomSelect_All._currentWorkerinfo = {}
        PaGlobal_WorkerRandomSelect_All._currentWorkerinfo._workerIdx = shopItem.shopSlotNo
        PaGlobal_WorkerRandomSelect_All._currentWorkerinfo._workerPrice64 = shopItem.price_s64
        local workerName = getWorkerName(plantWorkerSS)
        local workerNameByGrade = PaGlobal_WorkerRandomSelect_All:setNameByGrade(workerName, plantWorkerGrade)
        local workerIconPath = getWorkerIcon(plantWorkerSS)
        PaGlobal_WorkerRandomSelect_All._ui._stc_WokerImg:ChangeTextureInfoName(workerIconPath)
        PaGlobal_WorkerRandomSelect_All._ui._txt_WorkerActionPoint:SetText(plantWorkerSS._actionPoint)
        PaGlobal_WorkerRandomSelect_All._ui._txt_WokrerLuck:SetText(plantWorkerSS._luck / 10000)
        PaGlobal_WorkerRandomSelect_All._ui._txt_WokrerMoveSpeed:SetText(plantWorkerSS._moveSpeed / 100)
        PaGlobal_WorkerRandomSelect_All._ui._txt_WorkerSpeed:SetText(efficiency / 1000000)
        PaGlobal_WorkerRandomSelect_All._ui._txt_WorkerHireFee:SetText(makeDotMoney(shopItem.price_s64))
        PaGlobal_WorkerRandomSelect_All._ui._txt_WorkerName:SetText(workerNameByGrade)
        local workerFeeText = PaGlobal_WorkerRandomSelect_All._ui._txt_WorkerHireFee
        local workerIcon = PaGlobal_WorkerRandomSelect_All._ui._icon_WorkerHireFee
        workerIcon:SetPosX(workerFeeText:GetPosX() + workerFeeText:GetSizeX() - workerFeeText:GetTextSizeX() - workerIcon:GetSizeX() - 5)
        PaGlobal_WorkerRandomSelect_All._config._repetitionCount = PaGlobal_WorkerRandomSelect_All._config._repetitionCount - 1
        PaGlobal_WorkerRandomSelect_All._Count = PaGlobal_WorkerRandomSelect_All._Count + 1
        if true == isFindWorker then
          PaGlobal_WorkerRandomSelect_All._isCurrectWorkerCondition = true
          PaGlobal_WorkerRandomSelect_All._isContinueSelectWorkerStart = false
          PaGlobal_WorkerRandomSelect_All:setButtonWhilePerFrame(true)
          if true == PaGlobal_WorkerRandomSelect_All._isConsole then
            ToClient_padSnapResetControl()
            ToClient_padSnapSetTargetPanel(Panel_Window_WorkerRandomSelect_All)
            PaGlobal_WorkerRandomSelect_All:switchKeyGuide(false)
          end
          return
        else
          PaGlobal_WorkerRandomSelect_All._isCurrectWorkerCondition = false
        end
      end
    end
  end
end
function PaGlobalFunc_WorkerRandomSelect_All_UpdatePerFrameFunc(delta)
  if nil == Panel_Window_WorkerRandomSelect_All or false == Panel_Window_WorkerRandomSelect_All:GetShow() then
    return
  end
  if true == PaGlobal_WorkerRandomSelect_All._isCurrectWorkerCondition or false == PaGlobal_WorkerRandomSelect_All._isContinueSelectWorkerStart then
    return
  end
  if nil == PaGlobal_WorkerRandomSelect_All._delta_Time then
    PaGlobal_WorkerRandomSelect_All._delta_Time = 0
  end
  PaGlobal_WorkerRandomSelect_All._delta_Time = PaGlobal_WorkerRandomSelect_All._delta_Time + delta
  if PaGlobal_WorkerRandomSelect_All._delta_Time >= PaGlobal_WorkerRandomSelect_All._REFRESH_RATE then
    PaGlobal_WorkerRandomSelect_All._delta_Time = 0
    if 0 >= PaGlobal_WorkerRandomSelect_All._config._repetitionCount then
      PaGlobal_WorkerRandomSelect_All._isCurrectWorkerCondition = true
      PaGlobal_WorkerRandomSelect_All._isContinueSelectWorkerStart = false
      PaGlobal_WorkerRandomSelect_All:setButtonWhilePerFrame(true)
      Panel_Window_WorkerRandomSelect_All:ClearUpdateLuaFunc()
      PaGlobal_WorkerRandomSelect_All:switchKeyGuide(false)
    else
      npcShop_requestList(CppEnums.ContentsType.Contents_Shop)
    end
  end
end
function FromClient_WorkerRandomSelect_All_UpdateRadioButton()
  if nil == Panel_Window_WorkerRandomSelect_All then
    return
  end
  if false == PaGlobal_WorkerRandomSelect_All._initialize then
    return
  end
  PaGlobal_WorkerRandomSelect_All:updateRadioButton()
end
function PaGlobalFunc_WorkerRandomSelect_All_TempClose(isShow)
  Panel_Window_WorkerRandomSelect_All:SetShow(isShow)
end
function PaGlobalFunc_WorkerRandomSelect_All_SetSnapToThisPanel()
  if false == PaGlobal_WorkerRandomSelect_All._isConsole then
    return
  else
    ToClient_padSnapResetControl()
    ToClient_padSnapSetTargetPanel(Panel_Window_WorkerRandomSelect_All)
  end
end
