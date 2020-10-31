function PaGlobal_SA_Widget_Interaction:initialize()
  if true == PaGlobal_SA_Widget_Interaction._initialize then
    return
  end
  self._ui.stc_interactionBG = UI.getChildControl(Panel_SA_Interaction, "Static_InteractionBG")
  self._ui.stc_interactionBG:setGlassBackground(true)
  self._ui.stc_itemIconSlot = UI.getChildControl(self._ui.stc_interactionBG, "Static_ItemIconSlot")
  self._ui.txt_itemName = UI.getChildControl(self._ui.stc_interactionBG, "StaticText_ItemName")
  self._ui.stc_interactionIcon = UI.getChildControl(Panel_SA_Interaction, "Static_InteractionIcon")
  self._ui.stc_icon = UI.getChildControl(self._ui.stc_interactionBG, "Static_Icon")
  self._ui.stc_itemIcon = UI.getChildControl(self._ui.stc_icon, "Static_Icon_Item")
  self._ui.stc_servantIcon = UI.getChildControl(self._ui.stc_icon, "Static_Icon_Board")
  self:registEventHandler()
  self:validate()
  self._isDoneStartAni = true
  self._initialize = true
end
function PaGlobal_SA_Widget_Interaction:registEventHandler()
  if nil == Panel_SA_Interaction then
    return
  end
  registerEvent("onScreenResize", "FromClient_SA_Widget_Ingeraction_ReSizePanel")
  Panel_SA_Interaction:RegisterShowEventFunc(true, "PaGlobal_SA_Widget_Interaction_ShowAni()")
  Panel_SA_Interaction:RegisterShowEventFunc(false, "PaGlobal_SA_Widget_Interaction_HideAni()")
  registerEvent("EventSelfPlayerDead", "FromClient_SA_Widget_Ingeraction_Interaction")
  registerEvent("FromClient_ReviveToInstanceField", "FromClient_SA_Widget_Interaction_ReviveToInstanceField")
  registerEvent("FromClient_InterAction_UpdatePerFrame", "PaGlobal_SA_Widget_Interaction_Update")
  registerEvent("FromClient_InteractionFail", "FromClient_SA_Widget_Ingeraction_InteractionFail")
  registerEvent("FromClient_NotifyObserverModeEnd", "FromClient_SA_Widget_Ingeraction_NotifyObserverModeEnd")
  registerEvent("FromClient_RenderModeChangeState", "FromClient_SA_Widget_Ingeraction_RenderModeChange_interactionReload")
end
function PaGlobal_SA_Widget_Interaction:prepareOpen(actor)
  if nil == Panel_SA_Interaction then
    return
  end
  if nil == actor then
    self:prepareClose()
    return
  end
  audioPostEvent_SystemUi(1, 5)
  local firstInteractionType = actor:getSettedFirstInteractionType()
  self.basicInteractionType = firstInteractionType
  self.focusInteractionType = firstInteractionType
  local isLooting = false
  local actorName
  actorName = actor:getName()
  if true == actor:get():isLoot() then
    actorName = actor:getLootItemName()
    isLooting = true
  end
  if nil ~= actorName then
    self._ui.txt_itemName:SetTextHorizonCenter()
    self._ui.txt_itemName:SetTextVerticalTop()
    self._ui.txt_itemName:SetAutoResize(true)
    self._ui.txt_itemName:SetText(actorName)
    if true == isLooting then
      self._ui.stc_itemIcon:SetShow(true)
      self._ui.stc_servantIcon:SetShow(false)
    else
      self._ui.stc_itemIcon:SetShow(false)
      self._ui.stc_servantIcon:SetShow(true)
    end
  else
    self:prepareClose()
  end
  PaGlobal_SA_Widget_Interaction_ClearSelectIndex()
  PaGlobal_SA_Widget_Interaction:open()
end
function PaGlobal_SA_Widget_Interaction:open()
  if nil == Panel_SA_Interaction then
    return
  end
  Panel_SA_Interaction:SetShow(true)
end
function PaGlobal_SA_Widget_Interaction:prepareClose()
  if nil == Panel_SA_Interaction then
    return
  end
  self.INTERACTABLE_ACTOR_KEY = 0
  self.INTERACTABLE_FRAG = 0
  PaGlobal_SA_Widget_Interaction:close()
end
function PaGlobal_SA_Widget_Interaction:close()
  if nil == Panel_SA_Interaction then
    return
  end
  Panel_SA_Interaction:SetShow(false)
end
function PaGlobal_SA_Widget_Interaction:update()
  if nil == Panel_SA_Interaction then
    return
  end
end
function PaGlobal_SA_Widget_Interaction:validate()
  if nil == Panel_SA_Interaction then
    return
  end
  self._ui.stc_interactionBG:isValidate()
  self._ui.stc_itemIconSlot:isValidate()
  self._ui.txt_itemName:isValidate()
  self._ui.stc_interactionIcon:isValidate()
  self._ui.stc_icon:isValidate()
  self._ui.stc_itemIcon:isValidate()
  self._ui.stc_servantIcon:isValidate()
end
function PaGlobal_SA_Widget_Interaction:interactionShowableCheck(actor)
  if nil == actor then
    return false
  else
    return interaction_showableCheck(actor:get())
  end
end
function PaGlobal_SA_Widget_Interaction:getBottomPos(control)
  if nil == control then
    return
  end
  return control:GetPosY() + control:GetSizeY()
end
function PaGlobal_SA_Widget_Interaction:interactionCheck(interactionType)
  if interactionType == CppEnums.InteractionType.InteractionType_ExchangeItem or interactionType == CppEnums.InteractionType.InteractionType_InvitedParty or interactionType == CppEnums.InteractionType.InteractionType_GuildInvite then
    return true
  end
  return false
end
function PaGlobal_SA_Widget_Interaction:interactionReload()
  if false == self.isReloadState then
    PaGlobal_SA_Widget_Interaction_Close()
    return
  end
  local actor = interaction_getInteractable()
  if nil == actor then
    PaGlobal_SA_Widget_Interaction_Close()
    return
  end
end
function PaGlobal_SA_Widget_Interaction:InteractionCheck(interactionType)
  if interactionType == CppEnums.InteractionType.InteractionType_ExchangeItem or interactionType == CppEnums.InteractionType.InteractionType_InvitedParty or interactionType == CppEnums.InteractionType.InteractionType_GuildInvite then
    return true
  end
  return false
end
