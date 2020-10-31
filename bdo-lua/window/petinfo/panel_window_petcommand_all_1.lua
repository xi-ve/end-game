function PaGlobal_PetCommand_All:initialize()
  if true == PaGlobal_PetCommand_All._initialize then
    return
  end
  local centerBG = UI.getChildControl(Panel_Window_PetCommand_All, "Static_CenterBG")
  local palyBG = UI.getChildControl(centerBG, "Static_SpeedBg")
  self._playBtns = {
    [0] = UI.getChildControl(palyBG, "RadioButton_Slow"),
    [1] = UI.getChildControl(palyBG, "RadioButton_Normal"),
    [2] = UI.getChildControl(palyBG, "RadioButton_High")
  }
  local actionBG = UI.getChildControl(centerBG, "Static_ActionBg")
  self._actionBtns = {
    _follow = UI.getChildControl(actionBG, "RadioButton_Follow"),
    _wait = UI.getChildControl(actionBG, "RadioButton_Wait")
  }
  local talentBG = UI.getChildControl(centerBG, "Static_TalentBg")
  self._talentBtns = {
    _on = UI.getChildControl(talentBG, "RadioButton_On"),
    _off = UI.getChildControl(talentBG, "RadioButton_Off")
  }
  local getItemBG = UI.getChildControl(centerBG, "Static_GetItemBg")
  self._getItemBtns = {
    _on = UI.getChildControl(getItemBG, "RadioButton_On"),
    _off = UI.getChildControl(getItemBG, "RadioButton_Off")
  }
  self._keyGuideBG = UI.getChildControl(Panel_Window_PetCommand_All, "Static_BottomKeyBG")
  self._keyGuideB = UI.getChildControl(self._keyGuideBG, "StaticText_Cansel_ConsoleUI")
  PaGlobalFunc_ConsoleKeyGuide_SetAlign({
    self._keyGuideB
  }, self._keyGuideBG, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHT)
  PaGlobal_PetCommand_All:registEventHandler()
  PaGlobal_PetCommand_All:validate()
  PaGlobal_PetCommand_All._initialize = true
end
function PaGlobal_PetCommand_All:reposition()
  if nil == Panel_Window_PetCommand_All then
    return
  end
  local scrSizeX = getOriginScreenSizeX()
  local scrSizeY = getOriginScreenSizeY()
  local panelSizeX = Panel_Window_PetCommand_All:GetSizeX()
  local panelSizeY = Panel_Window_PetCommand_All:GetSizeY()
  Panel_Window_PetCommand_All:SetPosX(scrSizeX / 2 - panelSizeX / 2)
  Panel_Window_PetCommand_All:SetPosY(scrSizeY / 2 - panelSizeY / 2)
end
function PaGlobal_PetCommand_All:registEventHandler()
  if nil == Panel_Window_PetCommand_All then
    return
  end
  for index = 0, #self._playBtns do
    self._playBtns[index]:addInputEvent("Mouse_LUp", "HandleEventLUp_PetCommand_All_SetPlay( " .. index .. ")")
  end
  self._actionBtns._follow:addInputEvent("Mouse_LUp", "HandleEventLUp_PetCommand_All_OrderPet( 0 , true)")
  self._actionBtns._wait:addInputEvent("Mouse_LUp", "HandleEventLUp_PetCommand_All_OrderPet( 0 , false)")
  self._talentBtns._on:addInputEvent("Mouse_LUp", "HandleEventLUp_PetCommand_All_OrderPet( 1 , true)")
  self._talentBtns._off:addInputEvent("Mouse_LUp", "HandleEventLUp_PetCommand_All_OrderPet( 1 , false)")
  self._getItemBtns._on:addInputEvent("Mouse_LUp", "HandleEventLUp_PetCommand_All_OrderPet( 2 , true)")
  self._getItemBtns._off:addInputEvent("Mouse_LUp", "HandleEventLUp_PetCommand_All_OrderPet( 2 , false)")
end
function PaGlobal_PetCommand_All:prepareOpen(index)
  if nil == Panel_Window_PetCommand_All then
    return
  end
  self._targetPetIndex = index
  PaGlobal_PetList_All_TempClose()
  self:reposition()
  self:update()
  self:open()
end
function PaGlobal_PetCommand_All:open()
  if nil == Panel_Window_PetCommand_All then
    return
  end
  Panel_Window_PetCommand_All:SetShow(true)
end
function PaGlobal_PetCommand_All:prepareClose()
  if nil == Panel_Window_PetCommand_All then
    return
  end
  PaGlobal_PetList_All_TempOpen()
  PaGlobal_PetCommand_All:close()
end
function PaGlobal_PetCommand_All:close()
  if nil == Panel_Window_PetCommand_All then
    return
  end
  Panel_Window_PetCommand_All:SetShow(false)
end
function PaGlobal_PetCommand_All:validate()
  if nil == Panel_Window_PetCommand_All then
    return
  end
  self._playBtns[0]:isValidate()
  self._playBtns[1]:isValidate()
  self._playBtns[2]:isValidate()
  self._actionBtns._follow:isValidate()
  self._actionBtns._wait:isValidate()
  self._talentBtns._on:isValidate()
  self._talentBtns._off:isValidate()
  self._getItemBtns._on:isValidate()
  self._getItemBtns._off:isValidate()
end
function PaGlobal_PetCommand_All:update()
  local pcPetData
  if nil == self._targetPetIndex then
    pcPetData = ToClient_getPetUnsealedDataByIndex(0)
  else
    pcPetData = ToClient_getPetUnsealedDataByIndex(self._targetPetIndex)
  end
  if nil == pcPetData then
    PaGlobal_PetCommand_All:prepareClose()
    return
  end
  local petOrderList = PaGlobal_PetList_All._petOrderList
  local playType = pcPetData:getPetLootingType()
  local petNoStr = tostring(pcPetData:getPcPetNo())
  local isFollow = petOrderList._follow[petNoStr]
  local isFind = petOrderList._find[petNoStr]
  local isGetItem = petOrderList._getItem[petNoStr]
  for index = 0, #self._playBtns do
    if index == playType then
      self._playBtns[index]:SetCheck(true)
    else
      self._playBtns[index]:SetCheck(false)
    end
  end
  self._actionBtns._follow:SetCheck(isFollow)
  self._actionBtns._wait:SetCheck(not isFollow)
  self._talentBtns._on:SetCheck(isFind)
  self._talentBtns._off:SetCheck(not isFind)
  self._getItemBtns._on:SetCheck(isGetItem)
  self._getItemBtns._off:SetCheck(not isGetItem)
end
function PaGlobal_PetCommand_All:orderPet(petNo, orderType, value)
  if 0 == orderType then
    if value then
      ToClient_callHandlerToPetNo("handlePetFollowMaster", petNo)
    else
      ToClient_callHandlerToPetNo("handlePetWaitMaster", petNo)
    end
    PaGlobal_PetList_All._petOrderList._follow[tostring(petNo)] = value
  elseif 1 == orderType then
    if value then
      ToClient_callHandlerToPetNo("handlePetFindThatOn", petNo)
    else
      ToClient_callHandlerToPetNo("handlePetFindThatOff", petNo)
    end
    PaGlobal_PetList_All._petOrderList._find[tostring(petNo)] = value
  elseif 2 == orderType then
    if value then
      ToClient_callHandlerToPetNo("handlePetGetItemOn", petNo)
    else
      ToClient_callHandlerToPetNo("handlePetGetItemOff", petNo)
    end
    PaGlobal_PetList_All._petOrderList._getItem[tostring(petNo)] = value
  end
  PaGlobal_PetList_All._ui.list2_Pet:requestUpdateByKey(petNo)
end
