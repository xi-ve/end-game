function PaGlobalFunc_ServantOnlyList_All_Open(matingSlotIdx)
  if nil == Panel_Dialog_ServantOnlyList_All or true == Panel_Dialog_ServantOnlyList_All:GetShow() or nil == matingSlotIdx then
    return
  end
  PaGlobal_ServantOnlyList_All._matingSlotIdx = matingSlotIdx
  PaGlobal_ServantOnlyList_All:prepareOpen()
end
function PaGlobalFunc_ServantOnlyList_All_Close()
  if nil == Panel_Dialog_ServantOnlyList_All or false == Panel_Dialog_ServantOnlyList_All:GetShow() then
    return
  end
  PaGlobal_ServantOnlyList_All:prepareClose()
end
function FromClient_ServantOnlyList_All_OnScreenResize()
  if nil == Panel_Dialog_ServantOnlyList_All or false == Panel_Dialog_ServantOnlyList_All:GetShow() then
    return
  end
  self._ui_stc_BlockBG:SetSize(getScreenSizeX(), getScreenSizeY())
  self._ui_stc_BlockBG:ComputePos()
  Panel_Dialog_ServantOnlyList_All:SetHorizonCenter()
  Panel_Dialog_ServantOnlyList_All:SetVerticalMiddle()
  Panel_Dialog_ServantOnlyList_All:ComputePos()
end
function FromClient_ServantOnlyList_All_List2Update(content, key)
  if nil == Panel_Dialog_ServantOnlyList_All or false == Panel_Dialog_ServantOnlyList_All:GetShow() then
    return
  end
  local key32 = Int64toInt32(key)
  if nil == PaGlobal_ServantOnlyList_All._servantTable[key32] then
    return
  end
  local servantDataTable = PaGlobal_ServantOnlyList_All._servantTable[key32]
  local servantInfo = stable_getServant(servantDataTable.servantNo)
  if nil == servantInfo then
    content:SetShow(false)
    return
  end
  content:SetShow(true)
  local btn = UI.getChildControl(content, "RadioButton_List")
  local image = UI.getChildControl(content, "Static_Image")
  local genderIcon = UI.getChildControl(content, "Static_GenderIcon")
  local name = UI.getChildControl(content, "StaticText_ServantName")
  local locate = UI.getChildControl(content, "StaticText_Locate")
  local state = UI.getChildControl(content, "StaticText_State")
  local tier = UI.getChildControl(content, "StaticText_Tier")
  local horseIcon = UI.getChildControl(content, "Static_SwiftHorseIcon")
  local checkBtn = UI.getChildControl(content, "CheckButton_List")
  local leftMatingCount = UI.getChildControl(content, "StaticText_State")
  PaGlobal_ServantOnlyList_All._servantTable[key32].checkBtn = checkBtn
  local isSameRegion = servantDataTable.isSameRegion
  state:SetShow(false)
  btn:setNotImpactScrollEvent(true)
  btn:SetCheck(false)
  checkBtn:SetCheck(false)
  name:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_LV") .. "." .. tostring(servantInfo:getLevel()) .. " " .. servantInfo:getName())
  locate:SetText(servantInfo:getRegionName())
  image:ChangeTextureInfoName(servantInfo:getIconPath1())
  genderIcon:ChangeTextureInfoName("combine/etc/combine_etc_stable.dds")
  local x1, y1, x2, y2 = setTextureUV_Func(genderIcon, 1, 178, 31, 208)
  genderIcon:getBaseTexture():setUV(x1, y1, x2, y2)
  genderIcon:setRenderTexture(genderIcon:getBaseTexture())
  genderIcon:SetShow(true)
  if 9 == servantInfo:getTier() then
    tier:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_SERVANT_TEXT_TIER9"))
  else
    tier:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_SERVANT_TIER", "tier", servantInfo:getTier()))
  end
  if 9 ~= servantInfo:getTier() and false == servantInfo:isPcroomOnly() and ToClient_IsContentsGroupOpen("243") and ToClient_IsContentsGroupOpen("469") then
    local stallion = servantInfo:isStallion()
    if true == stallion then
      horseIcon:SetShow(true)
      horseIcon:SetMonoTone(false)
    else
      horseIcon:SetShow(false)
    end
  else
    horseIcon:SetShow(false)
  end
  local leftCount = servantInfo:getMatingCount()
  local leftCountString = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_STABLEMATING_MATINGCOUNT")
  leftMatingCount:SetShow(true)
  leftMatingCount:SetText(leftCountString .. " " .. leftCount)
  local regeionTextSizeX = locate:GetTextSizeX()
  local leftCountTextSizeX = leftMatingCount:GetTextSizeX()
  local avaliableSize = btn:GetSizeX() - (checkBtn:GetSizeX() + image:GetSizeX())
  function locationLimitTooltip(isShow)
    if false == isShow then
      TooltipSimple_Hide()
      return
    end
    TooltipSimple_Show(locate, locate:GetText(), "")
  end
  if avaliableSize < regeionTextSizeX + leftCountTextSizeX then
    local reducedLocateTxt = PaGlobal_ServantOnlyList_All._ui._list2_locate_Temp:GetSizeX() / 3
    locate:SetSize(reducedLocateTxt, PaGlobal_ServantOnlyList_All._ui._list2_locate_Temp:GetSizeY())
    locate:SetTextMode(__eTextMode_LimitText)
    locate:SetText(locate:GetText())
    locate:SetIgnore(false)
    locate:addInputEvent("Mouse_On", "locationLimitTooltip(true)")
    locate:addInputEvent("Mouse_Out", "locationLimitTooltip(false)")
    local gap = avaliableSize - (locate:GetSizeX() + PaGlobal_ServantOnlyList_All._ui._list2_locate_Temp:GetSizeX())
    leftMatingCount:SetSize(gap, leftMatingCount:GetSizeY())
    leftMatingCount:ComputePos()
    leftMatingCount:SetTextMode(__eTextMode_LimitText)
    leftMatingCount:SetText(locate:GetText())
    leftMatingCount:SetIgnore(false)
    leftMatingCount:addInputEvent("Mouse_On", "locationLimitTooltip(true)")
    leftMatingCount:addInputEvent("Mouse_Out", "locationLimitTooltip(false)")
  end
  btn:SetIgnore(not isSameRegion)
  btn:SetMonoTone(not isSameRegion, not isSameRegion)
  image:SetMonoTone(not isSameRegion, not isSameRegion)
  genderIcon:SetMonoTone(not isSameRegion, not isSameRegion)
  name:SetMonoTone(not isSameRegion, not isSameRegion)
  locate:SetMonoTone(not isSameRegion, not isSameRegion)
  state:SetMonoTone(not isSameRegion, not isSameRegion)
  tier:SetMonoTone(not isSameRegion, not isSameRegion)
  horseIcon:SetMonoTone(not isSameRegion, not isSameRegion)
  btn:addInputEvent("Mouse_LUp", "PaGlobalFunc_ServantOnlyList_All_SelectMatingTarget(" .. key32 .. ")")
end
function PaGlobalFunc_ServantOnlyList_All_SelectMatingTarget(idx)
  if nil ~= idx and true == Panel_Dialog_ServantOnlyList_All:GetShow() then
    local curIdx = PaGlobal_ServantOnlyList_All._currentSelectIdx
    if nil ~= curIdx and nil ~= PaGlobal_ServantOnlyList_All._servantTable[curIdx].checkBtn then
      PaGlobal_ServantOnlyList_All._servantTable[curIdx].checkBtn:SetCheck(false)
    end
    PaGlobal_ServantOnlyList_All._currentSelectIdx = idx
    if nil ~= PaGlobal_ServantOnlyList_All._servantTable[idx].checkBtn then
      PaGlobal_ServantOnlyList_All._servantTable[idx].checkBtn:SetCheck(true)
    end
  end
end
function PaGlobalFunc_ServantOnlyList_All_MatingStart()
  if false == Panel_Dialog_ServantOnlyList_All:GetShow() or nil == PaGlobal_ServantOnlyList_All._matingSlotIdx then
    return
  end
  local curIdx = PaGlobal_ServantOnlyList_All._currentSelectIdx
  if nil == curIdx or nil == PaGlobal_ServantOnlyList_All._servantTable[curIdx] then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_SERVANT_STABLE_MATING_PLZSELECT"))
    return
  end
  local fromServantNo = PaGlobal_ServantOnlyList_All._servantTable[curIdx].servantNo
  local function matingConfirm()
    local transferType = CppEnums.TransferType.TransferType_Normal
    if PaGlobal_ServantMarket_Rental_Mating_All._ENUM_TAB_RIGHT == PaGlobalFunc_ServantMarket_Rental_Mating_All_GetCurrentTab() then
      transferType = CppEnums.TransferType.TransferType_Self
    end
    local fromWhereType = MessageBoxCheck.isCheck()
    stable_startServantMating(fromServantNo, PaGlobal_ServantOnlyList_All._matingSlotIdx, transferType, fromWhereType)
    PaGlobalFunc_ServantOnlyList_All_Close()
  end
  local _title = PAGetString(Defines.StringSheet_GAME, "LUA_MESSAGEBOX_NOTIFY")
  local _desc = PAGetString(Defines.StringSheet_GAME, "LUA_STABLE_MATING_NOTIFY")
  local _confirmFunction = matingConfirm
  local _cancel = MessageBox_Empty_function
  local _priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  local messageboxData = {
    title = _title,
    content = _desc,
    functionApply = _confirmFunction,
    functionCancel = _cancel,
    priority = _priority
  }
  MessageBoxCheck.showMessageBox(messageboxData)
end
