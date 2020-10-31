function PaGlobal_PetControl_All:initialize()
  if true == PaGlobal_PetControl_All._initialize then
    return
  end
  self._maxUnsealCount = ToClient_getPetUseMaxCount()
  local temporaryPCRoomWrapper = getTemporaryInformationWrapper()
  local isPremiumPcRoom = temporaryPCRoomWrapper:isPremiumPcRoom()
  if isPremiumPcRoom then
    self._maxUnsealCount = self._maxUnsealCount + ToClient_getPetUseMaxCountPcRoom()
  end
  self._ui.Btn_IconPet = UI.getChildControl(Panel_Widget_PetControl_All, "Button_IconPet")
  self._ui.Stc_IconPetBg = UI.getChildControl(Panel_Widget_PetControl_All, "Static_IconPetBG")
  self._ui.Stc_HungryBG = UI.getChildControl(Panel_Widget_PetControl_All, "Static_HungryBG")
  self._ui.Progrss_Hungry = UI.getChildControl(Panel_Widget_PetControl_All, "Progress2_Hungry")
  self._ui.Txt_HungryAlert = UI.getChildControl(Panel_Widget_PetControl_All, "StaticText_HungryAlert")
  for _, control in pairs(self._ui) do
    control:SetShow(false)
  end
  self._ui.Btn_AllSeal = UI.getChildControl(Panel_Widget_PetControl_All, "Button_Allseal")
  self._ui.stc_CommandBtnBG = UI.getChildControl(Panel_Widget_PetControl_All, "Static_CommandBtnBG")
  self._ui.Btn_PetInfo = UI.getChildControl(self._ui.stc_CommandBtnBG, "Button_PetInfo")
  self._ui.Btn_Follow = UI.getChildControl(self._ui.stc_CommandBtnBG, "Button_Follow")
  self._ui.Btn_Wait = UI.getChildControl(self._ui.stc_CommandBtnBG, "Button_Wait")
  self._ui.Btn_Find = UI.getChildControl(self._ui.stc_CommandBtnBG, "Button_Find")
  self._ui.Btn_GetItem = UI.getChildControl(self._ui.stc_CommandBtnBG, "Button_GetItem")
  self._ui.Btn_Play = UI.getChildControl(self._ui.stc_CommandBtnBG, "CheckButton_Play")
  self._ui.Btn_Seal = UI.getChildControl(self._ui.stc_CommandBtnBG, "Button_Seal")
  self._palyIcons = {
    [0] = UI.getChildControl(self._ui.Btn_Play, "Static_Icon1"),
    [1] = UI.getChildControl(self._ui.Btn_Play, "Static_Icon2"),
    [2] = UI.getChildControl(self._ui.Btn_Play, "Static_Icon3")
  }
  local gapSizeX = self._ui.Stc_IconPetBg:GetSizeX() + 13
  for index = 0, self._maxUnsealCount - 1 do
    local temp = {}
    local _iconPet = UI.createControl(__ePAUIControl_Button, Panel_Widget_PetControl_All, "Button_IconPet_" .. index)
    CopyBaseProperty(self._ui.Btn_IconPet, _iconPet)
    _iconPet:addInputEvent("Mouse_LUp", "HanedleEventLUp_PetControl_CommandShow_All(" .. index .. ")")
    _iconPet:addInputEvent("Mouse_On", "HanedleEvent_PetControl_Tooltip_All( true," .. 98 .. ", " .. index .. ")")
    _iconPet:addInputEvent("Mouse_Out", "HanedleEvent_PetControl_Tooltip_All( false )")
    temp._iconPet = _iconPet
    local _iconPetBg = UI.createControl(__ePAUIControl_Static, Panel_Widget_PetControl_All, "Static_IconPetBG_" .. index)
    CopyBaseProperty(self._ui.Stc_IconPetBg, _iconPetBg)
    temp._iconPetBg = _iconPetBg
    local _hungryBg = UI.createControl(__ePAUIControl_Static, Panel_Widget_PetControl_All, "Static_HungryBG_" .. index)
    CopyBaseProperty(self._ui.Stc_HungryBG, _hungryBg)
    temp._hungryBg = _hungryBg
    local _progress = UI.createControl(__ePAUIControl_Progress2, Panel_Widget_PetControl_All, "Progress2_Hungry_" .. index)
    CopyBaseProperty(self._ui.Progrss_Hungry, _progress)
    temp._progress = _progress
    for v, control in pairs(temp) do
      control:SetPosX(control:GetPosX() + gapSizeX * index)
      control:SetShow(false)
    end
    self._petIcons[index] = temp
  end
  PaGlobal_PetControl_All:registEventHandler()
  PaGlobal_PetControl_All:validate()
  PaGlobal_PetControl_All._initialize = true
end
function PaGlobal_PetControl_All:registEventHandler()
  if nil == Panel_Widget_PetControl_All then
    return
  end
  registerEvent("FromClient_PetAddList", "FromClient_PetControl_HungryUpdate_All")
  registerEvent("FromClient_PetInfoChanged", "FromClient_PetControl_HungryUpdate_All")
  self._ui.Btn_PetInfo:addInputEvent("Mouse_LUp", "HanedleEventLUp_PetControl_PetInfo_Open_All()")
  self._ui.Btn_PetInfo:addInputEvent("Mouse_On", "HanedleEvent_PetControl_Tooltip_All( true," .. 4 .. ")")
  self._ui.Btn_PetInfo:addInputEvent("Mouse_Out", "HanedleEvent_PetControl_Tooltip_All( false )")
  self._ui.Btn_Follow:addInputEvent("Mouse_LUp", "HanedleEventLUp_PetControl_Order_All(0)")
  self._ui.Btn_Follow:addInputEvent("Mouse_On", "HanedleEvent_PetControl_Tooltip_All( true," .. 0 .. ")")
  self._ui.Btn_Follow:addInputEvent("Mouse_Out", "HanedleEvent_PetControl_Tooltip_All( false )")
  self._ui.Btn_Wait:addInputEvent("Mouse_LUp", "HanedleEventLUp_PetControl_Order_All(0)")
  self._ui.Btn_Wait:addInputEvent("Mouse_On", "HanedleEvent_PetControl_Tooltip_All( true," .. 1 .. ")")
  self._ui.Btn_Wait:addInputEvent("Mouse_Out", "HanedleEvent_PetControl_Tooltip_All( false )")
  self._ui.Btn_Find:addInputEvent("Mouse_LUp", "HanedleEventLUp_PetControl_Order_All(1)")
  self._ui.Btn_Find:addInputEvent("Mouse_On", "HanedleEvent_PetControl_Tooltip_All( true," .. 3 .. ")")
  self._ui.Btn_Find:addInputEvent("Mouse_Out", "HanedleEvent_PetControl_Tooltip_All( false )")
  self._ui.Btn_GetItem:addInputEvent("Mouse_LUp", "HanedleEventLUp_PetControl_Order_All(2)")
  self._ui.Btn_GetItem:addInputEvent("Mouse_On", "HanedleEvent_PetControl_Tooltip_All( true," .. 2 .. ")")
  self._ui.Btn_GetItem:addInputEvent("Mouse_Out", "HanedleEvent_PetControl_Tooltip_All( false )")
  self._ui.Btn_Play:addInputEvent("Mouse_LUp", "HanedleEventLUp_PetControl_SetPlay_All()")
  self._ui.Btn_Play:addInputEvent("Mouse_On", "HanedleEvent_PetControl_Tooltip_All( true," .. 5 .. ")")
  self._ui.Btn_Play:addInputEvent("Mouse_Out", "HanedleEvent_PetControl_Tooltip_All( false )")
  self._ui.Btn_Seal:addInputEvent("Mouse_LUp", "HanedleEventLUp_PetControl_SealPet_All()")
  self._ui.Btn_Seal:addInputEvent("Mouse_On", "HanedleEvent_PetControl_Tooltip_All( true," .. 97 .. ")")
  self._ui.Btn_Seal:addInputEvent("Mouse_Out", "HanedleEvent_PetControl_Tooltip_All( false )")
  self._ui.Btn_AllSeal:addInputEvent("Mouse_LUp", "HandleEventLUp_PetList_SealAllPet_All()")
end
function PaGlobal_PetControl_All:prepareOpen()
  if nil == Panel_Widget_PetControl_All then
    return
  end
  local unSealPetCount = ToClient_getPetUnsealedList()
  if unSealPetCount <= 0 then
    return
  end
  PaGlobal_PetControl_All:open()
  PaGlobal_PetControl_All:updatePetIcon()
end
function PaGlobal_PetControl_All:open()
  if nil == Panel_Widget_PetControl_All then
    return
  end
  Panel_Widget_PetControl_All:SetShow(true)
end
function PaGlobal_PetControl_All:prepareClose()
  if nil == Panel_Widget_PetControl_All then
    return
  end
  PaGlobal_PetControl_All:close()
end
function PaGlobal_PetControl_All:close()
  if nil == Panel_Widget_PetControl_All then
    return
  end
  Panel_Widget_PetControl_All:SetShow(false)
end
function PaGlobal_PetControl_All:validate()
  if nil == Panel_Widget_PetControl_All then
    return
  end
  self._ui.Btn_PetInfo:isValidate()
  self._ui.Btn_Follow:isValidate()
  self._ui.Btn_Wait:isValidate()
  self._ui.Btn_Find:isValidate()
  self._ui.Btn_GetItem:isValidate()
  self._ui.Btn_Play:isValidate()
  self._ui.Btn_Seal:isValidate()
  self._ui.Btn_IconPet:isValidate()
  self._ui.Stc_IconPetBg:isValidate()
  self._ui.Stc_HungryBG:isValidate()
  self._ui.Progrss_Hungry:isValidate()
  self._ui.Txt_HungryAlert:isValidate()
  self._ui.Btn_AllSeal:isValidate()
end
function PaGlobal_PetControl_All:getPetNo64ByIndex(index)
  local petCount = ToClient_getPetUnsealedList()
  if petCount == 0 then
    return nil
  end
  local petData = ToClient_getPetUnsealedDataByIndex(index)
  if nil == petData then
    return nil
  end
  return petData:getPcPetNo()
end
function PaGlobal_PetControl_All:updatePetIcon()
  if isFlushedUI() then
    return
  end
  if not Panel_Widget_PetControl_All:GetShow() then
    return
  end
  local unSealPetCount = ToClient_getPetUnsealedList()
  if 0 < unSealPetCount then
    for index = 0, self._maxUnsealCount - 1 do
      local PetUnSealData = ToClient_getPetUnsealedDataByIndex(index)
      if nil ~= PetUnSealData then
        local unsealPetStaticStatus = PetUnSealData:getPetStaticStatus()
        local unsealIconPath = PetUnSealData:getIconPath()
        local petNo = PetUnSealData:getPcPetNo()
        self._petIcons[index]._iconPet:ChangeTextureInfoName(unsealIconPath)
        for v, control in pairs(self._petIcons[index]) do
          control:SetShow(true)
        end
      else
        for v, control in pairs(self._petIcons[index]) do
          control:SetShow(false)
        end
      end
    end
    self:hungryGaugeUpdate()
  else
    self:prepareClose()
    return
  end
  self:hideCommandBG()
  self._ui.Btn_AllSeal:SetPosX(self._petIcons[unSealPetCount - 1]._iconPetBg:GetPosX() + 60)
  self:rePosition()
end
function PaGlobal_PetControl_All:rePosition()
  local posX = PaGlobalFunc_ServantIcon_GetIconPosX(9)
  local posY = PaGlobalFunc_ServantIcon_GetIconPosY(9)
  local screenX = getOriginScreenSizeX()
  if posX < screenX / 4 then
    Panel_Widget_PetControl_All:SetPosX(10)
  else
    local unSealPetCount = ToClient_getPetUnsealedList()
    local controlSizeX = math.max(184, 57 * unSealPetCount + 70)
    if screenX >= posX + controlSizeX then
      Panel_Widget_PetControl_All:SetPosX(posX)
    else
      Panel_Widget_PetControl_All:SetPosX(screenX - controlSizeX)
    end
  end
  Panel_Widget_PetControl_All:SetPosY(posY + PaGlobalFunc_ServantIcon_GetIconSizeY(9) + 10)
end
function PaGlobal_PetControl_All:hungryGaugeUpdate()
  if isFlushedUI() then
    return
  end
  local petCount = ToClient_getPetUnsealedList()
  if petCount == 0 then
    return
  end
  self._isHungry = false
  for index = 0, petCount - 1 do
    local pcPetData = ToClient_getPetUnsealedDataByIndex(index)
    if nil ~= pcPetData then
      local petStaticStatus = pcPetData:getPetStaticStatus()
      local petHungry = pcPetData:getHungry()
      local petMaxHungry = petStaticStatus._maxHungry
      local petHungryPercent = petHungry / petMaxHungry * 100
      self._petIcons[index]._progress:SetProgressRate(petHungryPercent)
      self._petIcons[index]._progress:SetShow(true)
      if petHungryPercent < 10 then
        self._isHungry = true
      end
    end
  end
  if false == _ContentsGroup_RenewUI then
    FGlobal_PetHungryAlert(self._isHungry)
  end
end
function PaGlobal_PetControl_All:showCommandBG(index)
  if self._ui.stc_CommandBtnBG:GetShow() and self._currentPetIndex == index then
    self:hideCommandBG()
    return
  end
  self._currentPetIndex = index
  self._ui.stc_CommandBtnBG:SetPosX(self._petIcons[index]._iconPetBg:GetPosX())
  self._ui.stc_CommandBtnBG:SetShow(true)
  self:updateCommandButton(index)
end
function PaGlobal_PetControl_All:hideCommandBG()
  self._ui.stc_CommandBtnBG:SetShow(false)
end
function PaGlobal_PetControl_All:updateCommandButton(index)
  local petData = ToClient_getPetUnsealedDataByIndex(index)
  if nil == petData then
    self:hideCommandBG()
    return
  end
  local petNo = petData:getPcPetNo()
  local petLootingType = petData:getPetLootingType()
  local orderList = PaGlobal_PetList_All._petOrderList
  local isFollow = orderList._follow[tostring(petNo)]
  local isFind = orderList._find[tostring(petNo)]
  local isGetItem = orderList._getItem[tostring(petNo)]
  if nil ~= petData:getSkillParam(1) and petData:getSkillParam(1):isPassiveSkill() then
    isFind = true
  end
  self._ui.Btn_Play:ChangeTextureInfoName("Combine/Etc/Combine_Etc_Pet_00.dds")
  local x1, y1, x2, y2
  if 0 == petLootingType then
    x1, y1, x2, y2 = setTextureUV_Func(self._ui.Btn_Play, 33, 138, 64, 169)
  elseif 1 == petLootingType then
    x1, y1, x2, y2 = setTextureUV_Func(self._ui.Btn_Play, 65, 138, 96, 169)
  elseif 2 == petLootingType then
    x1, y1, x2, y2 = setTextureUV_Func(self._ui.Btn_Play, 161, 138, 192, 169)
  end
  self._ui.Btn_Play:getBaseTexture():setUV(x1, y1, x2, y2)
  self._ui.Btn_Play:getOnTexture():setUV(x1, y1, x2, y2)
  self._ui.Btn_Follow:SetShow(isFollow)
  self._ui.Btn_Wait:SetShow(not isFollow)
  self._ui.Btn_Find:SetCheck(isFind)
  self._ui.Btn_GetItem:SetCheck(isGetItem)
  for idx, control in pairs(self._palyIcons) do
    control:SetShow(petLootingType == idx)
  end
  self._ui.Btn_Play:ChangeTextureInfoName("Combine/Etc/Combine_Etc_Pet_00.dds")
  local x1, y1, x2, y2
  if 0 == petLootingType then
    x1, y1, x2, y2 = setTextureUV_Func(self._ui.Btn_Play, 33, 138, 64, 169)
  elseif 1 == petLootingType then
    x1, y1, x2, y2 = setTextureUV_Func(self._ui.Btn_Play, 65, 138, 96, 169)
  elseif 2 == petLootingType then
    x1, y1, x2, y2 = setTextureUV_Func(self._ui.Btn_Play, 161, 138, 192, 169)
  end
  self._ui.Btn_Play:getBaseTexture():setUV(x1, y1, x2, y2)
  self._ui.Btn_Play:getOnTexture():setUV(x1, y1, x2, y2)
  self._ui.Btn_Play:setRenderTexture(self._ui.Btn_Play:getBaseTexture())
end
