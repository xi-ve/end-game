function HandleEventLUp_PetFusion_OpenSelectLook_All()
  if nil == Panel_Window_PetFusion_All then
    return
  end
  PaGlobal_PetFusion_All:openSelectLookBG()
end
function HandleEventLUp_PetFusion_CloseSelectLook_All()
  if nil == Panel_Window_PetFusion_All then
    return
  end
  PaGlobal_PetFusion_All:closeSelectLookBG()
end
function HandleEventLUp_PetFusion_LookSelect_All(petNoStr)
  if nil == Panel_Window_PetFusion_All then
    return
  end
  PaGlobal_PetFusion_All:lookSelect(petNoStr)
end
function HandleEventLUp_PetFusion_OpenSelectSkill_All()
  if nil == Panel_Window_PetFusion_All then
    return
  end
  PaGlobal_PetFusion_All:openSelectSkillBG()
end
function HandleEventLUp_PetFusion_CloseSelectSkill_All()
  if nil == Panel_Window_PetFusion_All then
    return
  end
  PaGlobal_PetFusion_All:closeSelectSkillBG()
end
function HandleEventLUp_PetFusion_SkillSelect_All(index)
  if nil == Panel_Window_PetFusion_All then
    return
  end
  PaGlobal_PetFusion_All:skillSelect(index)
end
function HandleEventMouseOn_PetFusion_SkillSelectOn_All(key)
  PaGlobal_PetFusion_All._selectSkillList[key]:SetShow(true)
end
function HandleEventMouseOut_PetFusion_SkillSelectOff_All(key)
  PaGlobal_PetFusion_All._selectSkillList[key]:SetShow(false)
end
function HandleEventLUp_PetFusion_ClearEdit_All()
  if PaGlobal_PetFusion_All._ui.stc_FusionDoneBG:GetShow() then
    return
  end
  PaGlobal_PetFusion_All._ui.edit_PetName:SetMaxInput(getGameServiceTypePetNameLength())
  if _ContentsGroup_RenewUI then
    local randomIndex = math.floor(math.random(0, PaGlobal_PetFusion_All._config._defaultPetNameCount - 1))
    PaGlobal_PetFusion_All._ui.edit_PetName:SetEditText(PaGlobal_PetFusion_All._config._defaultPetName[randomIndex], true)
    TooltipSimple_CommonShow("", PAGetStringParam2(Defines.StringSheet_GAME, "LUA_PETREGISTER_DESC_PARAM", "min", tostring(getGameServiceTypeNameMinLength()), "max", tostring(getGameServiceTypePetNameLength())))
    local panelSizeX = Panel_Window_PetFusion_All:GetSizeX()
    local panelPosX = Panel_Window_PetFusion_All:GetPosX()
    TooltipSimple_Common_Pos(panelSizeX + panelPosX + 20, Panel_Window_PetFusion_All:GetPosY() + PaGlobal_PetFusion_All._ui.edit_PetName:GetPosY())
  else
    PaGlobal_PetFusion_All._ui.edit_PetName:SetEditText("", true)
  end
  SetFocusEdit(PaGlobal_PetFusion_All._ui.edit_PetName)
end
function HandleEventLUp_PetFusion_Fusion_All()
  if PaGlobal_PetFusion_All._ui.stc_FusionDoneBG:GetShow() and PaGlobal_PetFusion_All._isConsole then
    return
  end
  PaGlobal_PetFusion_All:fusionPet()
end
function Input_PetFusion_All_VirtualKeyboardEnd(str)
  if getGameServiceTypePetNameLength() >= string.wlen(str) then
    PaGlobal_PetFusion_All._ui.edit_PetName:SetEditText(str, true)
  else
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoNameLengthIsTooLong"))
    PaGlobal_PetFusion_All._ui.edit_PetName:SetEditText("", true)
  end
  TooltipSimple_Hide()
  ClearFocusEdit()
end
function FromClient_PetFusionResult_All(rv)
  if 0 ~= rv then
    PaGlobal_PetFusion_All:prepareClose(true)
    local str = PAGetStringSymNo(rv)
    Proc_ShowMessage_Ack(str)
  end
end
function FromClient_FusionComplete_All(petNo)
  PaGlobal_PetFusion_All._ui.stc_CompleteEffectBG:SetShow(false)
  PaGlobal_PetFusion_All:loadCompleteData(petNo)
  PaGlobal_PetFusion_All:setComplete()
  PaGlobal_PetFusion_All:showFusionResult()
end
function PaGlobal_PetFusion_Close_All()
  if nil == Panel_Window_PetFusion_All then
    return
  end
  PaGlobal_PetFusion_All:prepareClose()
end
function PaGlobal_PetFusion_Open_All()
  if nil == Panel_Window_PetFusion_All then
    return
  end
  PaGlobal_PetFusion_All:prepareOpen()
end
function PaGlobal_PetFusion_Compose_Set_All(petNoStr, petRace, petTier, sealPetIndex, isJokerPetUse)
  if nil == Panel_Window_PetFusion_All then
    return
  end
  if PaGlobal_PetFusion_All._ui.stc_FusionDoneBG:GetShow() then
    return
  end
  PaGlobal_PetFusion_All:setPet(petNoStr, petRace, petTier, sealPetIndex, isJokerPetUse)
end
function PaGlobal_PetFusion_Compose_UnSet_All(petNoStr, sealPetIndex)
  if nil == Panel_Window_PetFusion_All then
    return
  end
  if PaGlobal_PetFusion_All._ui.stc_FusionDoneBG:GetShow() then
    return
  end
  PaGlobal_PetFusion_All:unsetPet(petNoStr, sealPetIndex)
end
function PaGlobal_PetFusion_CreateLookList_All(content, key)
  PaGlobal_PetFusion_All:createLookList(content, key)
end
function PaGlobal_PetFusion_CreateSkillList_All(content, key)
  PaGlobal_PetFusion_All:createSkillList(content, key)
end
function PaGlobal_PetFusion_SetCompleteDelay_PerFrameUpdate_All(deltaTime)
  if false == PaGlobal_PetFusion_All._isFusion then
    return
  else
    PaGlobal_PetFusion_All._completeDelayTime = PaGlobal_PetFusion_All._completeDelayTime + deltaTime
  end
  if PaGlobal_PetFusion_All._completeDelayTime >= 0.5 then
    PaGlobal_PetFusion_All._completeDelayTime = 0
    PaGlobal_PetFusion_All._isFusion = false
  end
end
function PaGlobal_PetFusion_FusionStartDelay_PerFrameUpdate_All(deltaTime)
  if false == PaGlobal_PetFusion_All._isFusionStart then
    return
  end
  PaGlobal_PetFusion_All._fusionStartDelayTime = PaGlobal_PetFusion_All._fusionStartDelayTime + deltaTime
  if PaGlobal_PetFusion_All._fusionStartDelayTime >= 2.5 then
    PaGlobal_PetFusion_All._isFusionStart = false
    PaGlobal_PetFusion_All._fusionStartDelayTime = 0
    ToClient_requestPetFusionUsePetNo(PaGlobal_PetFusion_All._petName, PaGlobal_PetFusion_All._currentSkillPetNo, PaGlobal_PetFusion_All._currentLookPetNo)
    return
  end
end
function PaGlobal_EscapeEditBox_PetCompose_All()
  if nil == Panel_Window_PetRegister_All then
    return
  end
  ClearFocusEdit()
  if PaGlobal_PetFusion_All._isConsole then
    TooltipSimple_Hide()
  end
end
function PaGlobal_PetFusion_GetShow_All()
  if nil ~= Panel_Window_PetFusion_All then
    return Panel_Window_PetFusion_All:GetShow()
  end
end
function PaGlobal_PetFusion_GetRate_All()
  return PaGlobal_PetFusion_All._currentRate
end
function PaGlobal_PetFusion_GetIsJokerPetUse_All()
  return PaGlobal_PetFusion_All._mainIsJokerPetUse
end
function PaGlobal_PetFusion_GetRace_All()
  return PaGlobal_PetFusion_All._mainRace
end
function PaGlobal_PetFusion_IsFull_All()
  return 5 <= PaGlobal_PetFusion_All:getPetNoCount()
end
function PaGlobal_PetFusion_IsEmpty_All()
  return 0 == PaGlobal_PetFusion_All:getPetNoCount()
end
function PaGlobal_PetFusion_IsMainPetSet_All()
  return PaGlobal_PetFusion_All._mainPetSlotTable._isSet
end
function PaGlobal_PetFusion_GetMainPetTier_All()
  if true == PaGlobal_PetFusion_IsEmpty_All() then
    return -1
  end
  return PaGlobal_PetFusion_All._mainPetTier + 1
end
function PaGlobal_PetFusion_IsExist_All(petNo)
  for _, number in pairs(PaGlobal_PetFusion_All._petNoList) do
    if petNo == number then
      return true
    end
  end
  return false
end
function PaGlobal_PetFusion_GetPetEditName_All()
  return PaGlobal_PetFusion_All._ui.edit_PetName
end
function PaGlobal_PetFusion_EscapeEditBox_All(bool)
  ClearFocusEdit(PaGlobal_PetFusion_All._ui.edit_PetName)
end
function PaGlobal_PetFusion_SetAbleByGrade_All(petNo)
  if false == PaGlobal_PetFusion_IsMainPetSet_All() then
    return true
  end
  local mainPetStaticStatus = PaGlobal_PetFusion_All:getStaticStatusByPetNo(PaGlobal_PetFusion_All._petNoList[0])
  local subPetStaticStatus = PaGlobal_PetFusion_All:getStaticStatusByPetNo(petNo)
  if nil == mainPetStaticStatus or nil == subPetStaticStatus then
    return
  end
  local mainGrade = ToClient_getGrade(mainPetStaticStatus:getPetRace(), mainPetStaticStatus:getPetKind())
  local subGrade = ToClient_getGrade(subPetStaticStatus:getPetRace(), subPetStaticStatus:getPetKind())
  if mainGrade == subGrade then
    return true
  else
    return false
  end
end
function PaGlobal_PetFusion_SetAbleByTier_All(tier)
  if false == PaGlobal_PetFusion_IsMainPetSet_All() then
    return true
  end
  if tier > PaGlobal_PetFusion_GetMainPetTier_All() then
    return false
  else
    return true
  end
end
