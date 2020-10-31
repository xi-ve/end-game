function InputMLUp_FairySkinChange_SelectSlot_All(selectSlotIndex)
  if nil == Panel_Window_FairySkinChange_All then
    return
  end
  PaGlobal_FairySkinChange_All:selectSlot(selectSlotIndex)
end
function InputMLUp_FairySkinChange_SetFocus_All()
  if nil == Panel_Window_FairySkinChange_All then
    return
  end
  PaGlobal_FairySkinChange_All:setFocus()
end
function InputMLUp_FairySkinChange_SelectConfirm()
  if nil == Panel_Window_FairySkinChange_All then
    return
  end
  PaGlobal_FairySkinChange_All:selectConfirm()
end
function FromClient_FairyChangeLookResult()
  if nil == Panel_Window_FairySkinChange_All then
    return
  end
  PaGlobal_FairySkinChange_All:changeResult()
end
function PaGlobal_FairySkinChange_Open_All()
  if nil == Panel_Window_FairySkinChange_All then
    return
  end
  PaGlobal_FairySkinChange_All:prepareOpen()
end
function PaGlobal_FairySkinChange_Close_All()
  if nil == Panel_Window_FairySkinChange_All then
    return
  end
  PaGlobal_FairySkinChange_All:prepareClose()
end
