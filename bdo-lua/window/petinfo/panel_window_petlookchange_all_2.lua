function HandleEventLUp_PetLookChange_SelectPet_All(petIndex)
  if nil == Panel_Window_PetLookChange_All then
    return
  end
  PaGlobal_PetLookChange_All:selectPet(petIndex)
end
function HandleEventLUp_PetLookChange_SelectLook_All(petIndex, lookIndex)
  if nil == Panel_Window_PetLookChange_All then
    return
  end
  PaGlobal_PetLookChange_All:iconChange(petIndex, lookIndex)
end
function HandleEventMouseOnPetLookChange_SimpleTooltip_All(isShow, index, changableIndex)
  if not isShow then
    TooltipSimple_Hide()
    return
  end
  local name, desc, control
  local petData = ToClient_getPetSealedDataByIndex(changableIndex)
  local petName = petData:getName()
  name = petName
  local contents = PaGlobal_PetLookChange_All._ui.list2_Pet:GetContentByKey(toInt64(0, index))
  local rdo_BG = UI.getChildControl(contents, "RadioButton_PetList")
  control = UI.getChildControl(rdo_BG, "StaticText_PetName")
  TooltipSimple_Show(control, name, desc)
end
function FromClient_PetLookChange_Open_All(whereType, slotNo)
  if nil == Panel_Window_PetLookChange_All then
    return
  end
  PaGlobal_PetLookChange_All:prepareOpen(whereType, slotNo)
end
function FromClient_PetLookChange_LookChanged_All(petNo, actionIndex)
  Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_PETLOOKCHANGE_CHANGEPET"))
  PaGlobal_PetLookChange_All:prepareClose()
end
function FromClient_PetLookChange_SealPetCountChange_All()
  if not Panel_Window_PetLookChange_All:GetShow() then
    return
  end
  PaGlobal_PetLookChange_All._selectedPetIndex = 0
  PaGlobal_PetLookChange_All._selectedLookIndex = 0
  PaGlobal_PetLookChange_All._petCount = PaGlobal_PetLookChange_All:getPetLookChangeableCount()
  PaGlobal_PetLookChange_All:updatePetList()
  PaGlobal_PetLookChange_All:selectPet(PaGlobal_PetLookChange_All._selectedPetIndex)
end
function PaGlobal_PetLookChange_Close_All()
  if nil == Panel_Window_PetLookChange_All then
    return
  end
  PaGlobal_PetLookChange_All:prepareClose()
end
function PaGlobal_PetLookChange_ListCreate_All(contents, key)
  if nil == Panel_Window_PetLookChange_All then
    return
  end
  PaGlobal_PetLookChange_All:createListContents(contents, key)
end
function PaGlobal_PetLookChange_Request_All(petIndex, actionIndex)
  local petData = ToClient_getPetSealedDataByIndex(PaGlobal_PetLookChange_All._changableIndex[petIndex])
  if nil == petData then
    return
  end
  local currentActionIndex = petData._actionIndex
  if currentActionIndex == actionIndex then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_PETLOOKCHANGE_SAMETHING"))
    return
  end
  local petNo = petData._petNo
  ToClient_requestPetChangeLook(petNo, actionIndex, PaGlobal_PetLookChange_All._whereType, PaGlobal_PetLookChange_All._slotNo)
end
