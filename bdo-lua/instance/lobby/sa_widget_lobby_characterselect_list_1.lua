function PaGlobal_Lobby_CharacterSelect_List:initialize()
  if true == self._initialize then
    return
  end
  if nil == SA_Widget_Lobby_CharacterSelect_List then
    return
  end
  self._ACTIVATION_COUNT = ToClient_getShadowArenaActivateClassCount()
  self._nowSelectClassNo = ToClient_getShadowArenaClassTypeByIndex(0)
  self._ui._Static_CharactorListGroup = UI.getChildControl(SA_Widget_Lobby_CharacterSelect_List, "Static_CharactorListGroup")
  self._ui._Button_SlotExpansive = UI.getChildControl(SA_Widget_Lobby_CharacterSelect_List, "Button_SlotExpansive")
  for index = 1, self._ACTIVATION_COUNT do
    self._ui._RadioButton_CharacterSlot_Activation[index] = UI.getChildControl(self._ui._Static_CharactorListGroup, "RadioButton_CharacterSlot_Activation" .. index)
    self._ui._Static_CharacterIcon[index] = UI.getChildControl(self._ui._RadioButton_CharacterSlot_Activation[index], "Static_CharacterIcon")
    self._ui._StaticText_CharacterName[index] = UI.getChildControl(self._ui._RadioButton_CharacterSlot_Activation[index], "StaticText_CharacterName")
    self._ui._Static_LockIcon[index] = UI.getChildControl(self._ui._RadioButton_CharacterSlot_Activation[index], "Static_LockIcon")
    self._ui._StaticText_CharacterName[index]:SetText(ToClient_getShadowArenaCharacterNameByIndex(index - 1))
    self._ui._Static_LockIcon[index]:SetShow(false)
    self._ui._RadioButton_CharacterSlot_Activation[index]:addInputEvent("Mouse_LUp", "HandleEventLup_SelectClass(" .. tostring(index) .. ")")
    self._ui._RadioButton_CharacterSlot_Activation[index]:addInputEvent("Mouse_On", "HandleEventOnOut_CharacterSelect_List_MoveEffect(" .. index .. ", true)")
    self._ui._RadioButton_CharacterSlot_Activation[index]:addInputEvent("Mouse_Out", "HandleEventOnOut_CharacterSelect_List_MoveEffect(" .. index .. ", false)")
  end
  self:registEventHandler()
  self:validate()
  self._initialize = true
end
function PaGlobal_Lobby_CharacterSelect_List:registEventHandler()
  if nil == SA_Widget_Lobby_CharacterSelect_List then
    return
  end
end
function PaGlobal_Lobby_CharacterSelect_List:prepareOpen()
  if nil == SA_Widget_Lobby_CharacterSelect_List then
    return
  end
  PaGlobal_Lobby_CharacterSelect_List:setCharacterIcon()
  local chracterSlotNo = ToClient_GetIndexByShadowArenaClassType() + 1
  HandleEventLup_SelectClass(chracterSlotNo)
  self._ui._RadioButton_CharacterSlot_Activation[chracterSlotNo]:SetCheck(true)
  PaGlobal_Lobby_CharacterSelect_List:open()
end
function PaGlobal_Lobby_CharacterSelect_List:open()
  if nil == SA_Widget_Lobby_CharacterSelect_List then
    return
  end
  SA_Widget_Lobby_CharacterSelect_List:SetShow(true)
end
function PaGlobal_Lobby_CharacterSelect_List:prepareClose()
  if nil == SA_Widget_Lobby_CharacterSelect_List then
    return
  end
  for index = 1, self._ACTIVATION_COUNT do
    if true == self._ui._RadioButton_CharacterSlot_Activation[index]:IsCheck() then
      self._ui._RadioButton_CharacterSlot_Activation[index]:SetCheck(false)
    end
  end
  SA_Widget_Lobby_CharacterSelect_List:ClearUpdateLuaFunc()
  PaGlobal_Lobby_CharacterSelect_List:close()
end
function PaGlobal_Lobby_CharacterSelect_List:close()
  if nil == SA_Widget_Lobby_CharacterSelect_List then
    return
  end
  SA_Widget_Lobby_CharacterSelect_List:SetShow(false)
end
function PaGlobal_Lobby_CharacterSelect_List:update()
  if nil == SA_Widget_Lobby_CharacterSelect_List then
    return
  end
end
function PaGlobal_Lobby_CharacterSelect_List:setCharacterIcon()
  for index = 1, self._ACTIVATION_COUNT do
    local classType = ToClient_getShadowArenaClassTypeByIndex(index - 1)
    self._ui._Static_CharacterIcon[index]:ChangeTextureInfoName(self._characterIconUV.path)
    local x1, y1, x2, y2 = setTextureUV_Func(self._ui._Static_CharacterIcon[index], self._characterIconUV[classType].x1, self._characterIconUV[classType].y1, self._characterIconUV[classType].x2, self._characterIconUV[classType].y2)
    self._ui._Static_CharacterIcon[index]:getBaseTexture():setUV(x1, y1, x2, y2)
    self._ui._Static_CharacterIcon[index]:setRenderTexture(self._ui._Static_CharacterIcon[index]:getBaseTexture())
  end
end
function PaGlobal_Lobby_CharacterSelect_List:validate()
  if nil == SA_Widget_Lobby_CharacterSelect_List then
    return
  end
  self._ui._Static_CharactorListGroup:isValidate()
  self._ui._Button_SlotExpansive:isValidate()
  for index = 1, self._ACTIVATION_COUNT do
    self._ui._RadioButton_CharacterSlot_Activation[index]:isValidate()
    self._ui._Static_CharacterIcon[index]:isValidate()
    self._ui._StaticText_CharacterName[index]:isValidate()
    self._ui._Static_LockIcon[index]:isValidate()
  end
end
