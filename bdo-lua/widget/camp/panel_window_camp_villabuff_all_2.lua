function PaGlobalFunc_BuildingBuff_All_Open()
  if nil == Panel_Window_BuildingBuff_All then
    return
  end
  PaGlobal_BuildingBuff_All:prepareOpen()
end
function PaGlobalFunc_BuildingBuff_All_Close()
  if nil == Panel_Window_BuildingBuff_All then
    return
  end
  PaGlobal_BuildingBuff_All:prepareClose()
  ToClient_openCampingInfo()
end
function PaGlobalFunc_BuildingBuff_All_UpdateMoney()
  if nil == Panel_Window_BuildingBuff_All or false == Panel_Window_BuildingBuff_All:GetShow() then
    return
  end
  PaGlobal_BuildingBuff_All:updateMoney()
end
function PaGlobalFunc_BuildingBuff_All_ListControlCreate(content, key)
  if nil == Panel_Window_BuildingBuff_All then
    return
  end
  PaGlobal_BuildingBuff_All:listControlCreate(content, key)
end
function PaGlobal_BuildingBuff_All_LimitTextTooltip(isShow, index, skillWrapper)
  if nil == Panel_Window_BuildingBuff_All then
    return
  end
  PaGlobal_BuildingBuff_All:limitTextTooltip(isShow, index, skillWrapper)
end
function HandleEventLUp_BuildingBuff_All_ApplyBuff(keyCount, buffIndex, index)
  if nil == Panel_Window_BuildingBuff_All then
    return
  end
  PaGlobal_BuildingBuff_All:applyBuff(keyCount, buffIndex, index)
end
