function HanedleEventLUp_PetControl_PetInfo_Open_All()
  TooltipSimple_Hide()
  local petCount = ToClient_getPetUnsealedList()
  if petCount == 0 then
    return
  end
  local currentPetData = ToClient_getPetUnsealedDataByIndex(PaGlobal_PetControl_All._currentPetIndex)
  if nil ~= currentPetData then
    local petNo = currentPetData:getPcPetNo()
    PaGlobal_PetInfo_Open_All(tostring(petNo))
    PaGlobal_PetControl_All:hideCommandBG()
  end
end
function HanedleEventLUp_PetControl_CommandShow_All(index)
  PaGlobal_PetControl_All:showCommandBG(index)
end
function HanedleEventLUp_PetControl_Order_All(orderType)
  TooltipSimple_Hide()
  HandleEventLUp_PetList_SetOrder_ToOne_All(orderType, PaGlobal_PetControl_All._currentPetIndex)
  PaGlobal_PetControl_All:hideCommandBG()
end
function HanedleEventLUp_PetControl_SetPlay_All()
  TooltipSimple_Hide()
  HandleEventLUp_PetList_SetPlay_ToOne_All(PaGlobal_PetControl_All._currentPetIndex)
end
function HanedleEventLUp_PetControl_SealPet_All()
  local petNo = PaGlobal_PetControl_All:getPetNo64ByIndex(PaGlobal_PetControl_All._currentPetIndex)
  if nil ~= petNo then
    TooltipSimple_Hide()
    ToClient_requestPetSeal(petNo)
  end
end
function HanedleEvent_PetControl_Tooltip_All(isShow, buttonType, index)
  if false == isShow then
    TooltipSimple_Hide()
    return
  end
  local self = PaGlobal_PetControl_All
  local uiControl, name, desc
  if 0 == buttonType then
    uiControl = self._ui.Btn_Follow
    name = PAGetString(Defines.StringSheet_GAME, "LUA_PETCONTROL_TOOLTIP_FOLLOW_NAME")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_PETCONTROL_TOOLTIP_FOLLOW_DESC")
  elseif 1 == buttonType then
    uiControl = self._ui.Btn_Wait
    name = PAGetString(Defines.StringSheet_GAME, "LUA_PETCONTROL_TOOLTIP_WAIT_NAME")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_PETCONTROL_TOOLTIP_WAIT_DESC")
  elseif 2 == buttonType then
    uiControl = self._ui.Btn_GetItem
    name = PAGetString(Defines.StringSheet_GAME, "LUA_PETCONTROL_TOOLTIP_GETITEM_NAME")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_PETCONTROL_TOOLTIP_GETITEM_DESC")
  elseif 3 == buttonType then
    uiControl = self._ui.Btn_Find
    name = PAGetString(Defines.StringSheet_GAME, "LUA_PETCONTROL_TOOLTIP_FIND_NAME")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_PETCONTROL_TOOLTIP_FIND_DESC")
  elseif 4 == buttonType then
    uiControl = self._ui.Btn_PetInfo
    name = PAGetString(Defines.StringSheet_GAME, "LUA_PETCONTROL_TOOLTIP_PETINFO_NAME")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_PETCONTROL_TOOLTIP_PETINFO_DESC")
  elseif 5 == buttonType then
    local pcPetData = ToClient_getPetUnsealedDataByIndex(PaGlobal_PetControl_All._currentPetIndex)
    if nil == pcPetData then
      return
    end
    local petLootingType = pcPetData:getPetLootingType()
    local lootingTypeString = ""
    if 0 == petLootingType then
      lootingTypeString = PAGetString(Defines.StringSheet_GAME, "LUA_IPETCONTROL_TOOLTIP_LOOTINGTYPE_0")
    elseif 1 == petLootingType then
      lootingTypeString = PAGetString(Defines.StringSheet_GAME, "LUA_IPETCONTROL_TOOLTIP_LOOTINGTYPE_1")
    elseif 2 == petLootingType then
      lootingTypeString = PAGetString(Defines.StringSheet_GAME, "LUA_IPETCONTROL_TOOLTIP_LOOTINGTYPE_2")
    end
    uiControl = self._ui.Btn_Play
    name = PAGetString(Defines.StringSheet_GAME, "LUA_PETCONTROL_TOOLTIP_PLAY_NAME") .. lootingTypeString
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_PETCONTROL_TOOLTIP_PLAY_DESC")
  elseif 97 == buttonType then
    uiControl = self._ui.Btn_Seal
    name = PAGetString(Defines.StringSheet_GAME, "LUA_PETCONTROL_TOOLTIP_PETSEAL_NAME")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_PETCONTROL_TOOLTIP_PETSEAL_DESC")
  elseif 98 == buttonType then
    uiControl = self._petIcons[index]._iconPet
    name = PAGetString(Defines.StringSheet_GAME, "LUA_PETCONTROL_TOOLTIP_PETCONTROL_NAME")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_PETCONTROL_TOOLTIP_PETCONTROL_DESC")
  end
  registTooltipControl(uiControl, Panel_Tooltip_SimpleText)
  TooltipSimple_Show(uiControl, name, desc)
end
function FromClient_PetControl_HungryUpdate_All()
  PaGlobal_PetControl_All:hungryGaugeUpdate()
end
function Panel_Widget_PetControl_ShowToggle_All()
  if Panel_Widget_PetControl_All:GetShow() then
    PaGlobal_PetControl_All:prepareClose()
  else
    PaGlobal_PetControl_All:prepareOpen()
  end
  local panelParty
  if true == _ContentsGroup_NewUI_PartyWidget_All then
    panelParty = Panel_Widget_Party_All
  else
    panelParty = Panel_Widget_Party
  end
  if panelParty:GetShow() and Panel_Widget_PetControl_All:GetShow() then
    local petCount = ToClient_getPetUnsealedList()
    local isOverlap = false
    for overlapY = panelParty:GetPosY(), panelParty:GetPosY() + panelParty:GetSizeY(), panelParty:GetSizeY() do
      if overlapY >= Panel_Widget_PetControl_All:GetPosY() and overlapY <= Panel_Widget_PetControl_All:GetPosY() + Panel_Widget_PetControl_All:GetSizeY() then
        isOverlap = true
      end
    end
    if isOverlap then
      for overlapX = panelParty:GetPosX(), panelParty:GetPosX() + panelParty:GetSizeX(), panelParty:GetSizeX() do
        if overlapX >= Panel_Widget_PetControl_All:GetPosX() and overlapX <= Panel_Widget_PetControl_All:GetPosX() + (Panel_Widget_PetControl_All:GetSizeX() + 10) * petCount + 60 then
          PartyPanel_Repos()
          return
        end
      end
    end
  end
end
function PaGlobal_PetControl_PetIconUpdate_All()
  PaGlobal_PetControl_All:updatePetIcon()
end
