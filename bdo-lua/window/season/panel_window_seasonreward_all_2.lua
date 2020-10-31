function PaGlobal_SeasonReward_All_Open()
  if nil == Panel_Window_SeasonReward_All then
    return
  end
  PaGlobal_SeasonReward_All:prepareOpen()
end
function PaGlobal_SeasonReward_All_Close()
  if nil == Panel_Window_SeasonReward_All then
    return
  end
  PaGlobal_SeasonReward_All:prepareClose()
end
function PaGlobal_SeasonReward_All_CreateSeasonList(content, key)
  local key32 = Int64toInt32(key)
  local button = UI.getChildControl(content, "Button_LeftContentBg")
  local buttonText = UI.getChildControl(button, "StaticText_ButtonText")
  local completeIcon = UI.getChildControl(button, "Static_StatusIcon_Complete")
  local activateIcon = UI.getChildControl(button, "Static_StatusIcon_Activate")
  local lockIcon = UI.getChildControl(button, "Static_StatusIcon_Lock")
  local seasonRewardStaticStatus = getSeasonRewardStaticStatus(key32)
  if nil ~= seasonRewardStaticStatus then
    local seasonNameKey = seasonRewardStaticStatus:getSeasonName()
    local seasonName = PAGetString(Defines.StringSheet_GAME, seasonNameKey)
    buttonText:SetText(seasonName)
  else
    buttonText:SetText("")
  end
  completeIcon:SetShow(false)
  activateIcon:SetShow(false)
  lockIcon:SetShow(false)
  local lastClearSeasonNo = ToClient_getCompleteLastSeasonNo()
  if key32 > lastClearSeasonNo then
    lockIcon:SetShow(true)
  else
    local isReceivedReward = ToClient_isSelectedRewardSeasonNo(key32)
    if true == isReceivedReward then
      completeIcon:SetShow(true)
    else
      activateIcon:SetShow(true)
    end
  end
  button:addInputEvent("Mouse_LUp", "PaGlobal_SeasonReward_All_SelectSeason(" .. tostring(key32) .. ")")
end
function PaGlobal_SeasonReward_All_SelectSeason(seasonNo)
  PaGlobal_SeasonReward_All._selectedSeasonNo = seasonNo
  PaGlobal_SeasonReward_All._selectedItemIndex = 1
  PaGlobal_SeasonReward_All:contentUpdate()
end
function PaGlobal_SeasonReward_All_SelectRewardIndex(index)
  PaGlobal_SeasonReward_All._selectedItemIndex = index
  PaGlobal_SeasonReward_All:contentUpdate()
end
function PaGlobal_SeasonReward_All_ReceiveReward()
  local isReceivedReward = ToClient_isSelectedRewardSeasonNo(PaGlobal_SeasonReward_All._selectedSeasonNo)
  if true == isReceivedReward then
    return
  end
  ToClient_selectSeasonReward(PaGlobal_SeasonReward_All._selectedSeasonNo, PaGlobal_SeasonReward_All._selectedItemIndex - 1)
end
function HandleEventOnOut_SeasonReward_All_ShowRewardItemTooltip(isShow, itemKey, enchantLevel)
  if nil == Panel_Window_SeasonReward_All then
    return
  end
  if false == isShow then
    Panel_Tooltip_Item_hideTooltip()
    return
  end
  local itemSSW = getItemEnchantStaticStatus(ItemEnchantKey(itemKey, enchantLevel))
  if nil == itemSSW then
    return
  end
  local control = PaGlobal_SeasonReward_All._ui.rewardItemSlot.icon
  Panel_Tooltip_Item_Show(itemSSW, control, true)
end
function HandleEventOnOut_SeasonReward_All_ShowListItemTooltip(isShow, index, itemKey, enchantLevel)
  if nil == Panel_Window_SeasonReward_All then
    return
  end
  if false == isShow then
    Panel_Tooltip_Item_hideTooltip()
    return
  end
  local itemSSW = getItemEnchantStaticStatus(ItemEnchantKey(itemKey, enchantLevel))
  if nil == itemSSW then
    return
  end
  local control = PaGlobal_SeasonReward_All._ui.rewardSlotList[index].icon
  Panel_Tooltip_Item_Show(itemSSW, control, true)
end
function FromClient_SeasonReward_All_OnScreenResize()
  if nil == Panel_Window_SeasonReward_All then
    return
  end
  Panel_Window_SeasonReward_All:ComputePosAllChild()
end
function FromClient_SeasonReward_All_ResponseSelectSeasonReward()
  if nil == Panel_Window_SeasonReward_All or false == Panel_Window_SeasonReward_All:GetShow() then
    return
  end
  Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_CHANGEWEAPON_SUCCESS_CHANGEITEM"))
  PaGlobal_SeasonReward_All._ui.stc_exchangeEffect:EraseAllEffect()
  PaGlobal_SeasonReward_All._ui.stc_exchangeEffect:AddEffect("fUI_Season_Gift_01A", false, 0, 0)
  audioPostEvent_SystemUi(28, 2)
  _AudioPostEvent_SystemUiForXBOX(28, 2)
  PaGlobal_SeasonReward_All:listUpdate()
  PaGlobal_SeasonReward_All:contentUpdate()
end
