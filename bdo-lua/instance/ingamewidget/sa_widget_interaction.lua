PaGlobal_SA_Widget_Interaction = {
  _ui = {
    stc_interactionBG = nil,
    stc_itemIconSlot = nil,
    txt_itemName = nil,
    stc_interactionIcon = nil,
    stc_icon = nil,
    stc_itemIcon = nil,
    stc_servantIcon = nil
  },
  _initialize = false,
  _pcExchangeDisableTime = 60,
  _eInteractionTypeMax = CppEnums.InteractionType.InteractionType_Count,
  _preUIMode = nil,
  _isDeadPlayer = false,
  INTERACTABLE_ACTOR_KEY = 0,
  INTERACTABLE_FRAG = 0,
  basicInteractionType = 0,
  focusInteractionType = 0,
  isFocusInteractionType = false,
  currentInteractionSelectIndex = 0,
  currentInteractionKeyPressedTime = 0,
  isReloadState = true,
  _isLooting = false,
  _isAnimating = false,
  _processedTime = 0,
  _alphaAniTime = 0,
  _alphaAniProgress = 0
}
runLua("UI_Data/Script/Instance/IngameWidget/SA_Widget_Interaction_1.lua")
runLua("UI_Data/Script/Instance/IngameWidget/SA_Widget_Interaction_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_SA_Widget_InteractionInit")
function FromClient_SA_Widget_InteractionInit()
  PaGlobal_SA_Widget_Interaction:initialize()
end
