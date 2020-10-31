function HandleEventLUp_Anchor_SelectType(eSelectType)
  if eSelectType == PaGlobal_Anchor._eSelectButtonType.sailor then
    return
  elseif eSelectType == PaGlobal_Anchor._eSelectButtonType.barter then
    PaGlobal_Barter:open(PaGlobal_Anchor._actorKey, PaGlobal_Anchor._regionKey)
  elseif PaGlobal_Anchor._eSelectButtonType.explore == eSelectType then
    PaGlobal_GreatSeaEvent:requestGreatSeaEvent(true)
  elseif PaGlobal_Anchor._eSelectButtonType.supply == eSelectType then
    PaGlobal_GreatSeaEvent:requestGreatSeaEvent(false)
  else
    return
  end
end
function HandleEventOn_ShowTooltip(isShow, eSelectType)
  if false == isShow then
    TooltipSimple_Hide()
  end
  if eSelectType == PaGlobal_Anchor._eSelectButtonType.sailor then
    return
  elseif eSelectType == PaGlobal_Anchor._eSelectButtonType.barter then
    return
  elseif PaGlobal_Anchor._eSelectButtonType.explore == eSelectType then
    TooltipSimple_Show(PaGlobal_Anchor._ui.btn_explore, "", PAGetString(Defines.StringSheet_GAME, "LUA_SEARCHING_EXPLORE_INFO"))
    return
  elseif PaGlobal_Anchor._eSelectButtonType.supply == eSelectType then
    TooltipSimple_Show(PaGlobal_Anchor._ui.btn_supply, "", PAGetString(Defines.StringSheet_GAME, "LUA_SEARCHING_SUPPLY_INFO"))
  else
    return
  end
end
function HandleEventLUp_Anchorage_SetAnchorage(isClicked)
  local temporaryWrapper = getTemporaryInformationWrapper()
  if nil == temporaryWrapper then
    return
  end
  local unsealServantInfo = temporaryWrapper:getUnsealVehicle(CppEnums.ServantType.Type_Ship)
  if nil == unsealServantInfo then
    return
  end
  local anchorMode = false
  if isClicked then
    anchorMode = not unsealServantInfo:isAnchorMode()
  else
    anchorMode = unsealServantInfo:isAnchorMode()
  end
  if true == PaGlobal_Anchor._isCloseWidget and isClicked and false == anchorMode then
    unsealServantInfo:setAnchorMode(anchorMode)
    PaGlobal_Anchor:prepareClose()
    PaGlobal_Barter_Close()
    return
  end
  PaGlobal_Anchor._ui.btn_barter:SetShow(anchorMode)
  PaGlobal_Anchor._ui.btn_explore:SetShow(anchorMode)
  PaGlobal_Anchor._ui.btn_supply:SetShow(anchorMode)
  PaGlobal_Anchor._ui.btn_anchor:SetShow(not anchorMode)
  PaGlobal_Anchor._ui.btn_departure:SetShow(anchorMode)
  if true == isClicked then
    unsealServantInfo:setAnchorMode(anchorMode)
    if anchorMode then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_DROP_ANCHOR_UI_BUTTON"))
    else
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_UP_ANCHOR_UI_BUTTON"))
    end
  end
end
function FromClient_UpdateNearBarterNPC(isShow, actorKey, regionKey)
  if nil == Panel_Widget_Anchorage then
    return
  end
  if true == isShow then
    PaGlobal_Anchor:prepareOpen()
    PaGlobal_Anchor._actorKey = actorKey
    PaGlobal_Anchor._regionKey = regionKey
    PaGlobal_Anchor._isCloseWidget = false
  else
    local temporaryWrapper = getTemporaryInformationWrapper()
    local unsealServantInfo = temporaryWrapper:getUnsealVehicle(CppEnums.ServantType.Type_Ship)
    if nil ~= unsealServantInfo and unsealServantInfo:isAnchorMode() then
      Panel_Widget_Anchorage:SetShow(true)
      PaGlobal_Anchor._ui.btn_barter:SetShow(false)
      PaGlobal_Anchor._ui.btn_explore:SetShow(false)
      PaGlobal_Anchor._ui.btn_supply:SetShow(false)
      PaGlobal_Anchor._ui.btn_anchor:SetShow(false)
      PaGlobal_Anchor._ui.btn_departure:SetShow(true)
      PaGlobal_Anchor._isCloseWidget = true
    else
      PaGlobal_Anchor:prepareClose()
      PaGlobal_Barter_Close()
    end
  end
end
function PaGlobal_Anchor_FromClient_RideOff()
  Panel_Widget_Anchorage:SetShow(false)
  PaGlobal_Anchor:prepareClose()
  PaGlobal_Barter_Close()
end
function PaGloabl_Anchor_ShowAni()
  if nil == Panel_Widget_Anchorage then
    return
  end
end
function PaGloabl_Anchor_HideAni()
  if nil == Panel_Widget_Anchorage then
    return
  end
end
