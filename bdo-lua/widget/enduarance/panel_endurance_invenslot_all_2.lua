function PaGlobalFunc_Endurance_InvenSlot_All_Open()
  if nil == Panel_Endurance then
    return
  end
  PaGlobal_Endurance_InvenSlot_All:prepareOpen()
end
function PaGlobalFunc_Endurance_InvenSlot_All_Close()
  if nil == Panel_Endurance then
    return
  end
  PaGlobal_Endurance_InvenSlot_All:prepareClose()
end
function PaGlobalFunc_Endurance_InvenSlot_All_CheckInvenSlot()
  if nil == Panel_Endurance then
    return
  end
  PaGlobal_Endurance_InvenSlot_All:checkInvenSlot()
end
function PaGlobalFunc_Endurance_InvenSlot_All_GetShow()
  if nil == PaGlobal_Endurance_InvenSlot_All._ui.txt_InvenSlotIcon then
    return
  end
  return PaGlobal_Endurance_InvenSlot_All._ui.txt_InvenSlotIcon:GetShow()
end
function PaGlobalFunc_Endurance_InvenSlot_All_SetPosY(posY)
  if nil == Panel_Endurance then
    return
  end
  PaGlobal_Endurance_InvenSlot_All:setPosY(posY)
  if true == _ContentsGroup_AccesoryQuest and nil ~= Panel_Widget_AccesoryQuest then
    PaGlobalFunc_AccesoryQuest_resetPosition()
  end
end
