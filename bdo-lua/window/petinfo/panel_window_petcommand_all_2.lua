function PaGlobal_PetCommand_All_Open(index)
  if Panel_Window_PetFusion_All:GetShow() then
    return
  end
  if PaGlobal_PetList_All_GetFeedShow() then
    return
  end
  local unsealPetCount = ToClient_getPetUnsealedList()
  if 0 == unsealPetCount then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_PETLISTNEW_UNSEALALERT"))
    return
  end
  PaGlobal_PetCommand_All:prepareOpen(index)
end
function PaGlobal_PetCommad_All_Close()
  PaGlobal_PetCommand_All:prepareClose()
end
function HandleEventLUp_PetCommand_All_SetPlay(petLootingType)
  local selectedPetNo
  if nil ~= PaGlobal_PetCommand_All._targetPetIndex then
    local selectedPetData = ToClient_getPetUnsealedDataByIndex(PaGlobal_PetCommand_All._targetPetIndex)
    selectedPetNo = selectedPetData:getPcPetNo()
  end
  local unsealPetCount = ToClient_getPetUnsealedList()
  for pIndex = 0, unsealPetCount - 1 do
    local pcPetData = ToClient_getPetUnsealedDataByIndex(pIndex)
    if nil ~= pcPetData then
      local petNo = pcPetData:getPcPetNo()
      if nil == selectedPetNo then
        ToClient_requestChangePetLootingType(petNo, petLootingType)
      elseif petNo == selectedPetNo then
        ToClient_requestChangePetLootingType(petNo, petLootingType)
        PaGlobal_PetList_All:SetPetList(true)
        return
      end
    end
  end
  PaGlobal_PetList_All:SetPetList(true)
end
function HandleEventLUp_PetCommand_All_OrderPet(orderType, value)
  local unsealPetCount = ToClient_getPetUnsealedList()
  if unsealPetCount == 0 then
    return
  end
  for pIndex = 0, unsealPetCount do
    local pcPetData = ToClient_getPetUnsealedDataByIndex(pIndex)
    if nil ~= pcPetData then
      local petNo = pcPetData:getPcPetNo()
      if nil == PaGlobal_PetCommand_All._targetPetIndex then
        PaGlobal_PetCommand_All:orderPet(petNo, orderType, value)
      elseif pIndex == PaGlobal_PetCommand_All._targetPetIndex then
        PaGlobal_PetCommand_All:orderPet(petNo, orderType, value)
      end
    end
  end
end
