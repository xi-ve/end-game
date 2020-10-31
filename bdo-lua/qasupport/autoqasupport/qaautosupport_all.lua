PaGlobal_AutoQASupport = {
  _itemSlot = -1,
  _enchantResult = {_resultType = -1}
}
function PaGlobal_AutoQASupport:getResultString(result)
  local resultString = "\t"
  if true == result then
    resultString = "[PASS]"
  elseif false == result then
    resultString = "[FAIL]"
  end
  return resultString
end
function PaGlobal_AutoQASupport:writeLogFile(content, result)
  local convertDateStr = function()
    local paTime = PATime(getServerUtc64())
    return tostring(paTime:GetYear()) .. tostring(paTime:GetMonth()) .. tostring(paTime:GetDay())
  end
  local convertLogTimeStr = function()
    local paTime = PATime(getServerUtc64())
    return string.format([[

%.2d:%.2d:%.2d	]], paTime:GetHour(), paTime:GetMinute(), paTime:GetSecond())
  end
  _PA_LOG("\236\157\180\235\139\164\237\152\156", content)
  ToClient_QAsupportCheckDir("D:\\AutoQALog\\")
  ToClient_QAsupportFileOpen("D:\\AutoQALog\\Log" .. convertDateStr() .. "_rev(" .. getVersion() .. ").txt")
  ToClient_QAsupportFileWrite(convertLogTimeStr() .. self:getResultString(result) .. "\t" .. content)
  ToClient_QAsupportFileClose()
end
function PaGlobal_AutoQASupport:getInvenSlotByItemKey(whereType, inputItemKey)
  local selfPlayerWrapper = getSelfPlayer():get()
  local invenUseSize = selfPlayerWrapper:getInventorySlotCount(false)
  local slotNo
  for i = 2, invenUseSize - 1 do
    local itemWrapper = getInventoryItemByType(whereType, i)
    if nil ~= itemWrapper then
      local itemKey = itemWrapper:get():getKey():getItemKey()
      if itemKey == inputItemKey then
        slotNo = i
        break
      end
    end
  end
  if slotNo == nil then
    return -1
  end
  return slotNo - 2
end
function PaGlobal_AutoQASupport:updatePerFrameFunc()
  ToClient_qaExcuteCurrentJob(getTickCount32())
end
function PaGlobalFunc_AutoQASupport_SetEnchantResult(resultType, mainWhereType, mainSlotNo, subWhereType, subSlotNo)
  PaGlobal_AutoQASupport._enchantResult = {
    _resultType = resultType,
    _mainWhereType = mainWhereType,
    _mainSlotNo = mainSlotNo,
    _subWhereType = subWhereType,
    _subSlotNo = subSlotNo
  }
end
function PaGlobalFunc_AutoQASupport_EnchanIsSuccess()
  if PaGlobal_AutoQASupport._enchantResult == 0 then
    return "SUCCESS"
  end
  return "FAIL"
end
registerEvent("EventEnchantResultShow", "PaGlobalFunc_AutoQASupport_SetEnchantResult")
function loadBlackSpirit()
  local BlackSpiritsSummon = ToClient_BlackspiritisSummoning()
  if BlackSpiritsSummon == true then
    ToClient_qaRegisterTimerForQA(5000, "ToClient_AddBlackSpiritFlush()")
  else
    ToClient_AddBlackSpiritFlush()
  end
end
function ErrorHandler(errorString)
  Proc_ShowMessage_Ack("\235\172\184\236\160\156\234\176\128 \235\176\156\236\131\157\237\149\152\236\151\172 \237\133\140\236\138\164\237\138\184\235\165\188 \236\164\145\235\139\168\237\149\169\235\139\136\235\139\164. [\235\130\180\236\154\169 : " .. errorString .. " ]")
  _PA_LOG("AutoQA", "\236\151\144\235\159\172 \235\176\156\236\131\157! [\235\130\180\236\154\169 : " .. errorString .. " ]")
  PaGlobal_AutoQASupport:writeLogFile(errorString, false)
  ToClient_qaRegisterTimerForQA(2000, "ToClient_qaresetTimerJobList()")
end
function QA_ItemStackCount(materialKey)
  saveItemSlotForQA(CppEnums.ItemWhereType.eInventory, materialKey)
  local targetSlotNo = getItemSlotForQA()
  if targetSlotNo == -1 or targetSlotNo == nil then
    return 0
  else
    local itemWrapper = getInventoryItemByType(CppEnums.ItemWhereType.eInventory, targetSlotNo + 2)
    local getCountMaterial_str = tostring(itemWrapper:get():getCount_s64())
    local getCountMaterial = tonumber(getCountMaterial_str)
    return getCountMaterial
  end
end
