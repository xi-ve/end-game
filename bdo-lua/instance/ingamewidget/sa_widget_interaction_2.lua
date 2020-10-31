function PaGlobal_SA_Widget_Interaction_Open(actor)
  PaGlobal_SA_Widget_Interaction:prepareOpen(actor)
  PaGlobal_SA_Widget_Interaction._isAnimating = true
  PaGlobal_SA_Widget_Interaction._alphaFadeType = CppEnums.PAUI_SHOW_FADE_TYPE.PAUI_ANI_TYPE_FADE_IN
end
function PaGlobal_SA_Widget_Interaction_Close()
  PaGlobal_SA_Widget_Interaction:prepareClose()
end
function FromClient_SA_Widget_Ingeraction_RenderModeChange_interactionReload(prevRenderModeList, nextRenderModeList)
  if CheckRenderModebyGameMode(nextRenderModeList) == false then
    return
  end
  PaGlobal_SA_Widget_Interaction:interactionReload()
end
function FromClient_SA_Widget_Ingeraction_NotifyObserverModeEnd()
  if false == _ContentsGroup_RenewUI_WatchMode then
  end
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  if selfPlayer:isDead() then
  end
end
function FromClient_SA_Widget_Ingeraction_Interaction()
  PaGlobal_SA_Widget_Interaction._isDeadPlayer = true
end
function FromClient_SA_Widget_Interaction_ReviveToInstanceField()
  PaGlobal_SA_Widget_Interaction._isDeadPlayer = false
end
function FromClient_SA_Widget_Ingeraction_InteractionFail()
  local preUIMode = GetUIMode()
  if nil == preUIMode then
    return
  end
  SetUIMode(preUIMode)
end
function FromClient_SA_Widget_Ingeraction_ReSizePanel()
  PaGlobal_SA_Widget_Interaction._ui.stc_interactionBG:ComputePos()
  PaGlobal_SA_Widget_Interaction._ui.stc_itemIcon:ComputePos()
  PaGlobal_SA_Widget_Interaction._ui.txt_itemName:ComputePos()
  PaGlobal_SA_Widget_Interaction._ui.stc_interactionIcon:ComputePos()
end
function PaGlobal_SA_Widget_Interaction_HideAni()
  if nil == Panel_SA_Interaction then
    return
  end
end
function PaGlobal_SA_Widget_Interaction_Update(deltaTime)
  local selfPlayer = getSelfPlayer()
  if selfPlayer == nil or selfPlayer:isDead() or Defines.UIMode.eUIMode_Default ~= GetUIMode() or PaGlobal_SA_Widget_Interaction._isDeadPlayer then
    PaGlobal_SA_Widget_Interaction_Close()
    return
  end
  local actor = interaction_getInteractable()
  if nil == actor then
    PaGlobal_SA_Widget_Interaction_Close()
    return
  end
  local actorKey = actor:getActorKey()
  local interactableFrag = actor:getInteractableFrag()
  if actorKey ~= PaGlobal_SA_Widget_Interaction.INTERACTABLE_ACTOR_KEY or interactableFrag ~= PaGlobal_SA_Widget_Interaction.INTERACTABLE_FRAG then
    PaGlobal_SA_Widget_Interaction.INTERACTABLE_ACTOR_KEY = actorKey
    PaGlobal_SA_Widget_Interaction.INTERACTABLE_FRAG = interactableFrag
    if true == PaGlobal_SA_Widget_Interaction:interactionShowableCheck(actor) then
      PaGlobal_SA_Widget_Interaction_Open(actor)
    else
      PaGlobal_SA_Widget_Interaction_Close()
      return
    end
  end
  PaGlobal_SA_Widget_Interaction_AlphaUpdate(deltaTime)
  PaGlobal_SA_Widget_Interaction_PositionUpdate(actor)
end
function PaGlobal_SA_Widget_Interaction_AlphaUpdate(deltaTime)
  if true == PaGlobal_SA_Widget_Interaction._isAnimating then
    PaGlobal_SA_Widget_Interaction._alphaAniTime = 0.5
    local progress = PaGlobal_SA_Widget_Interaction._processedTime / PaGlobal_SA_Widget_Interaction._alphaAniTime
    PaGlobal_SA_Widget_Interaction._processedTime = PaGlobal_SA_Widget_Interaction._processedTime + deltaTime
    if PaGlobal_SA_Widget_Interaction._processedTime >= PaGlobal_SA_Widget_Interaction._alphaAniTime then
      PaGlobal_SA_Widget_Interaction._processedTime = 0
      PaGlobal_SA_Widget_Interaction._isAnimating = false
      PaGlobal_SA_Widget_Interaction._alphaFadeType = CppEnums.PAUI_SHOW_FADE_TYPE.PAUI_ANI_TYPE_NONE
      return
    end
    if CppEnums.PAUI_SHOW_FADE_TYPE.PAUI_ANI_TYPE_FADE_OUT == PaGlobal_SA_Widget_Interaction._alphaFadeType then
      progress = 1 - progress
    end
    Panel_SA_Interaction:SetAlphaChild(progress)
    PaGlobal_SA_Widget_Interaction._ui.txt_itemName:SetFontAlpha(progress)
  end
end
function PaGlobal_SA_Widget_Interaction_PositionUpdate(actor)
  local pos2d = actor:get2DPosForInterAction()
  if pos2d.x < 0 and 0 > pos2d.y then
    Panel_SA_Interaction:SetPosX(-1000)
    Panel_SA_Interaction:SetPosY(-1000)
  else
    Panel_SA_Interaction:SetPosX(pos2d.x + 0)
    Panel_SA_Interaction:SetPosY(pos2d.y - 100)
  end
end
function PaGlobal_SA_Widget_Interaction_Forceed()
  local actor = interaction_getInteractable()
  if nil == actor then
    return
  end
  PaGlobal_SA_Widget_Interaction.INTERACTABLE_ACTOR_KEY = actor:getActorKey()
  PaGlobal_SA_Widget_Interaction.INTERACTABLE_FRAG = actor:getInteractableFrag()
  if true == PaGlobal_SA_Widget_Interaction:interactionShowableCheck(actor) then
    PaGlobal_SA_Widget_Interaction_Open(actor)
  else
    PaGlobal_SA_Widget_Interaction_Close()
  end
  PaGlobal_SA_Widget_Interaction_PositionUpdate(actor)
end
function PaGlobal_SA_Widget_Interaction_ExecuteByKeyMapping(keycode)
  DragManager:clearInfo()
  if keycode ~= CppEnums.ActionInputType.ActionInputType_Interaction then
    setUiInputProcessed(keycode)
  end
  local camBlur = getCameraBlur()
  local interactableActor = interaction_getInteractable()
  if interactableActor ~= nil and (not interactableActor:get():isPlayer() or interactableActor:get():isSelfPlayer()) and camBlur <= 0 then
    local interactionType = interactableActor:getSettedFirstInteractionType()
    if PaGlobal_SA_Widget_Interaction:InteractionCheck(interactionType) then
      return
    end
    interaction_processInteraction(interactionType)
  end
end
function PaGlobal_SA_Widget_Interaction_CheckAndGetPressedKeyCode()
  local keyCode = CppEnums.ActionInputType.ActionInputType_Interaction
  if keyCustom_IsDownOnce_Action(keyCode) then
    return keyCode
  end
  keyCode = __eUiInputType_Interaction0
  if GlobalKeyBinder_CheckCustomKeyPressed(keyCode) then
    return keyCode
  end
  keyCode = __eUiInputType_Interaction1
  if GlobalKeyBinder_CheckCustomKeyPressed(keyCode) then
    return keyCode
  end
  keyCode = __eUiInputType_Interaction2
  if GlobalKeyBinder_CheckCustomKeyPressed(keyCode) then
    return keyCode
  end
  keyCode = __eUiInputType_Interaction3
  if GlobalKeyBinder_CheckCustomKeyPressed(keyCode) then
    return keyCode
  end
  keyCode = __eUiInputType_Interaction4
  if GlobalKeyBinder_CheckCustomKeyPressed(keyCode) then
    return keyCode
  end
  keyCode = CppEnums.VirtualKeyCode.KeyCode_F10
  if GlobalKeyBinder_CheckKeyPressed(CppEnums.VirtualKeyCode.KeyCode_F10) then
    return keyCode
  end
  return nil
end
function PaGlobal_SA_Widget_Interaction_ClearSelectIndex()
  PaGlobal_SA_Widget_Interaction.currentInteractionSelectIndex = 0
end
function PaGlobal_SA_Widget_Interaction_Reset()
  PaGlobal_SA_Widget_Interaction.INTERACTABLE_ACTOR_KEY = 0
end
