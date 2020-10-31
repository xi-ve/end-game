function PaGlobalFunc_ServantCarriageLink_All_Open()
  if nil == Panel_Dialog_ServantCarriageLink_All or true == Panel_Dialog_ServantCarriageLink_All:GetShow() then
    return
  end
  PaGlobal_ServantCarriageLink_All:prepareOpen()
end
function PaGlobalFunc_ServantCarriageLink_All_Close()
  if nil == Panel_Dialog_ServantCarriageLink_All or false == Panel_Dialog_ServantCarriageLink_All:GetShow() then
    return
  end
  PaGlobal_ServantCarriageLink_All:prepareClose()
end
function PaGlobalFunc_ServantCarriageLink_All_OnScreenResize()
  if nil == Panel_Dialog_ServantCarriageLink_All or false == Panel_Dialog_ServantCarriageLink_All:GetShow() then
    return
  end
  Panel_Dialog_ServantCarriageLink_All:ComputePos()
end
function PaGlobalFunc_ServantCarriageLink_All_List2UpdateCarriage(content, key)
  if nil == Panel_Dialog_ServantCarriageLink_All or false == Panel_Dialog_ServantCarriageLink_All:GetShow() then
    return
  end
  PaGlobal_ServantCarriageLink_All:list2Update_Carriage(content, key)
end
function PaGlobalFunc_ServantCarriageLink_All_List2UpdateHorse(content, key)
  if nil == Panel_Dialog_ServantCarriageLink_All or false == Panel_Dialog_ServantCarriageLink_All:GetShow() then
    return
  end
  PaGlobal_ServantCarriageLink_All:list2Update_Horse(content, key)
end
function PaGlobalFunc_ServantCarriageLink_All_UpdateCarriage()
  if nil == Panel_Dialog_ServantCarriageLink_All or false == Panel_Dialog_ServantCarriageLink_All:GetShow() then
    return
  end
  if nil == PaGlobal_ServantCarriageLink_All._currentCarriage or false == Panel_Dialog_ServantCarriageLink_All:GetShow() then
    return
  end
  local carriageIdx = PaGlobal_ServantCarriageLink_All._currentCarriage._slotIdx
  PaGlobal_ServantCarriageLink_All._ui._list2_Carriage:requestUpdateVisible()
  PaGlobal_ServantCarriageLink_All._ui._list2_Horse:requestUpdateVisible()
end
function HandleEventLUp_ServantCarriageLink_All_SelectCarriage(slotIdx)
  if nil == Panel_Dialog_ServantCarriageLink_All or false == Panel_Dialog_ServantCarriageLink_All:GetShow() then
    return
  end
  if nil == slotIdx or false == Panel_Dialog_ServantCarriageLink_All:GetShow() or nil == Panel_Dialog_ServantCarriageLink_All then
    return
  end
  if nil ~= PaGlobal_ServantCarriageLink_All._carriageBtn_List[slotIdx] then
    PaGlobal_ServantCarriageLink_All._carriageBtn_List[slotIdx]:SetCheck(true)
  end
  PaGlobal_ServantCarriageLink_All._currentCarriage._slotIdx = slotIdx
  local carriageInfo = stable_getServant(slotIdx)
  if nil == carriageInfo then
    return
  end
  local carriageNo = carriageInfo:getServantNo()
  local leftLinkSlot = carriageInfo:getCurrentLinkCount()
  local maxLinkSlot = carriageInfo:getLinkCount()
  if PaGlobal_ServantCarriageLink_All._currentCarriage._carriageNo ~= carriageNo then
    PaGlobal_ServantCarriageLink_All._scrollPos._horseScrollPos = 0
    PaGlobal_ServantCarriageLink_All._scrollPos._horseIdx = 0
  end
  PaGlobal_ServantCarriageLink_All._scrollPos._carriageScrollPos = PaGlobal_ServantCarriageLink_All._ui._list2_Carriage:GetVScroll():GetControlPos()
  PaGlobal_ServantCarriageLink_All._scrollPos._carriageIdx = PaGlobal_ServantCarriageLink_All._ui._list2_Carriage:getCurrenttoIndex()
  PaGlobal_ServantCarriageLink_All._currentCarriage._carriageNo = carriageNo
  PaGlobal_ServantCarriageLink_All._currentCarriage._slotIdx = slotIdx
  PaGlobal_ServantCarriageLink_All._currentCarriage._maxLinkAbleHorse = maxLinkSlot
  local servantCount = stable_count()
  PaGlobal_ServantCarriageLink_All._ui._list2_Horse:getElementManager():clearKey()
  local regionInfo = getRegionInfoByPosition(getSelfPlayer():get():getPosition())
  local currentRegionKey = regionInfo:getRegionKey()
  local ENUMHORSE = CppEnums.VehicleType.Type_Horse
  PaGlobal_ServantCarriageLink_All._linkAbleHorse_List = {}
  PaGlobal_ServantCarriageLink_All._currentSelectedHorse = {}
  PaGlobal_ServantCarriageLink_All._ui._txt_NoHorse:SetShow(false)
  local ableServantCount = 0
  local linkedCount = 0
  for idx = 0, servantCount - 1 do
    local servantInfo = stable_getServant(idx)
    if nil ~= servantInfo then
      local servantRegionKey = servantInfo:getRegionKeyRaw()
      local servantType = servantInfo:getVehicleType()
      local servantState = servantInfo:getStateType()
      local servantInfoTable = {
        servantNo = nil,
        servantSlotIndex = nil,
        checkBtn = nil
      }
      if currentRegionKey ~= servantRegionKey or servantType ~= ENUMHORSE or servantInfo:isSeized() or CppEnums.ServantStateType.Type_RegisterMarket == servantState or CppEnums.ServantStateType.Type_RegisterMating == servantState or CppEnums.ServantStateType.Type_Mating == servantState or servantInfo:isMatingComplete() or CppEnums.ServantStateType.Type_Coma == servantState or CppEnums.ServantStateType.Type_Rent == servantState or CppEnums.ServantStateType.Type_SkillTraining == servantState or CppEnums.ServantStateType.Type_Return == servantState or Defines.s64_const.s64_0 < servantInfo:getRentOwnerNo() then
      else
        if servantInfo:isLink() then
          if carriageNo == servantInfo:getOwnerServantNo_s64() then
            PaGlobal_ServantCarriageLink_All._ui._list2_Horse:getElementManager():pushKey(toInt64(0, idx))
            servantInfoTable.servantno = servantInfo:getServantNo()
            servantInfoTable.servantSlotIndex = idx
            servantInfoTable.checkBtn = true
            PaGlobal_ServantCarriageLink_All._currentSelectedHorse[linkedCount] = servantInfoTable
            linkedCount = linkedCount + 1
          end
        else
          PaGlobal_ServantCarriageLink_All._ui._list2_Horse:getElementManager():pushKey(toInt64(0, idx))
        end
        ableServantCount = ableServantCount + 1
      end
    end
  end
  if ableServantCount <= 0 then
    PaGlobal_ServantCarriageLink_All._ui._txt_NoHorse:SetShow(true)
  end
  local scrollPos = PaGlobal_ServantCarriageLink_All._scrollPos
  if scrollPos._horseIdx ~= PaGlobal_ServantCarriageLink_All._ui._list2_Horse:getCurrenttoIndex() and 0 < scrollPos._horseIdx then
    PaGlobal_ServantCarriageLink_All._ui._list2_Horse:setCurrenttoIndex(scrollPos._horseIdx)
    PaGlobal_ServantCarriageLink_All._ui._list2_Horse:GetVScroll():SetControlPos(scrollPos._horseScrollPos)
  end
  if scrollPos._carriageIdx ~= PaGlobal_ServantCarriageLink_All._ui._list2_Carriage:getCurrenttoIndex() and 0 < scrollPos._carriageIdx then
    PaGlobal_ServantCarriageLink_All._ui._list2_Carriage:setCurrenttoIndex(scrollPos._carriageIdx)
    PaGlobal_ServantCarriageLink_All._ui._list2_Carriage:GetVScroll():SetControlPos(scrollPos._carriageScrollPos)
  end
end
function HandleEventLUp_ServantCarriageLink_All_SelectHorse(slotIdx, isRClick)
  if nil == Panel_Dialog_ServantCarriageLink_All or false == Panel_Dialog_ServantCarriageLink_All:GetShow() then
    return
  end
  if nil == slotIdx or nil == PaGlobal_ServantCarriageLink_All._currentCarriage then
    return
  end
  local currentCarriageTable = PaGlobal_ServantCarriageLink_All._currentCarriage
  local servantInfoTable = PaGlobal_ServantCarriageLink_All._linkAbleHorse_List[slotIdx]
  local leftSlot = PaGlobal_ServantCarriageLink_All:getCarriageLinkCount()
  if nil == servantInfoTable then
    return
  end
  local servantno = servantInfoTable.servantSlotIndex
  local servantInfo = stable_getServant(slotIdx)
  if nil == servantInfo then
    return
  end
  local maxSlot = PaGlobal_ServantCarriageLink_All._currentCarriage._maxLinkAbleHorse
  if true == isRClick then
    if true == servantInfo:isLink() then
      PaGlobal_ServantCarriageLink_All._linkAbleHorse_List[slotIdx].checkBtn:SetCheck(false)
      stable_link(slotIdx, currentCarriageTable._slotIdx, false)
    else
      PaGlobal_ServantCarriageLink_All._linkAbleHorse_List[slotIdx].checkBtn:SetCheck(true)
    end
  elseif leftSlot < maxSlot then
    if false == servantInfo:isLink() then
      PaGlobal_ServantCarriageLink_All._currentSelectedHorse[leftSlot] = servantInfoTable
      PaGlobal_ServantCarriageLink_All._linkAbleHorse_List[slotIdx].checkBtn:SetCheck(true)
      stable_link(slotIdx, currentCarriageTable._slotIdx, true)
    end
  else
    PaGlobal_ServantCarriageLink_All._linkAbleHorse_List[slotIdx].checkBtn:SetCheck(false)
  end
  PaGlobal_ServantCarriageLink_All._scrollPos._horseScrollPos = PaGlobal_ServantCarriageLink_All._ui._list2_Horse:GetVScroll():GetControlPos()
  PaGlobal_ServantCarriageLink_All._scrollPos._horseIdx = PaGlobal_ServantCarriageLink_All._ui._list2_Horse:getCurrenttoIndex()
end
function HandleEventLUp_ServantCarriageLink_All_IgnoreCheckBtn(slotIdx, isLinkBtn)
  if nil ~= PaGlobal_ServantCarriageLink_All._linkAbleHorse_List[slotIdx] then
    if true == isLinkBtn then
      PaGlobal_ServantCarriageLink_All._linkAbleHorse_List[slotIdx].checkBtn:SetCheck(false)
    else
      PaGlobal_ServantCarriageLink_All._linkAbleHorse_List[slotIdx].checkBtn:SetCheck(true)
    end
  end
end
function HandleEventLUp_ServantCarriageLink_All_UnLinkAll()
  if nil == PaGlobal_ServantCarriageLink_All._currentCarriage then
    return
  end
  local currentCarriageTable = PaGlobal_ServantCarriageLink_All._currentCarriage
  local maxCount = PaGlobal_ServantCarriageLink_All:getCarriageLinkCount()
  local currentSelectedHorseTable = PaGlobal_ServantCarriageLink_All._currentSelectedHorse
  local currentCarriageSlotIdx = currentCarriageTable._slotIdx
  if nil == currentCarriageSlotIdx then
    return
  end
  for idx = 0, maxCount do
    if nil ~= currentSelectedHorseTable[idx] then
      stable_link(currentSelectedHorseTable[idx].servantSlotIndex, currentCarriageSlotIdx, false)
    end
  end
  PaGlobal_ServantCarriageLink_All._scrollPos._horseScrollPos = PaGlobal_ServantCarriageLink_All._ui._list2_Horse:GetVScroll():GetControlPos()
  PaGlobal_ServantCarriageLink_All._scrollPos._horseIdx = PaGlobal_ServantCarriageLink_All._ui._list2_Horse:getCurrenttoIndex()
  PaGlobal_ServantCarriageLink_All._scrollPos._carriageScrollPos = PaGlobal_ServantCarriageLink_All._ui._list2_Carriage:GetVScroll():GetControlPos()
  PaGlobal_ServantCarriageLink_All._scrollPos._carriageIdx = PaGlobal_ServantCarriageLink_All._ui._list2_Carriage:getCurrenttoIndex()
end
function HandleEventOnOut_Dialog_ServantCarriageLink_All_ShowMouseToolTip(isLeft, isShow)
  if false == isShow then
    TooltipSimple_Hide()
    return
  end
  local control
  if true == isLeft then
    control = PaGlobal_ServantCarriageLink_All._ui._txt_LClick
  else
    control = PaGlobal_ServantCarriageLink_All._ui._txt_RClick
  end
  local name = ""
  local desc = control:GetText()
  TooltipSimple_Show(control, name, desc)
end
