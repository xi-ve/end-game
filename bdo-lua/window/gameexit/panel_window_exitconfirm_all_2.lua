function HandleEventLUp_ExitConfirm_All_ExitConfirm()
  PaGlobal_ExitConfirm_All:prepareClose()
  PaGlobal_GameExit_ALL_GameExitSuccess()
end
function HandleEventLUp_ExitConfirm_All_Close()
  PaGlobal_ExitConfirm_All:prepareClose()
end
function HandleEventOn_ExitConfirm_All_Tooltip(index, attantCount, stampIndex)
  local dailyStampKeys
  if true == _ContentsGroup_NewUI_DailyStamp_All then
    dailyStampKeys = PaGlobalFunc_DailyStamp_All_GetDailyStampKeys()
  else
    dailyStampKeys = FGlobal_DailyStamp_GetDailyStampKeys()
  end
  if nil == dailyStampKeys then
    return
  end
  local itemWrapper = dailyStampKeys[stampIndex][1]:getRewardItem(attantCount)
  local itemSSW = itemWrapper:getStaticStatus()
  local uiBase = PaGlobal_ExitConfirm_All._dayControl[index].slot.icon
  Panel_Tooltip_Item_Show(itemSSW, uiBase, true, false)
end
function HandleEventOut_ExitConfirm_All_Tooltip()
  Panel_Tooltip_Item_hideTooltip()
end
function PaGloabl_ContentsName_ShowAni()
  if nil == Panel_ExitConfirm then
    return
  end
end
function PaGloabl_ContentsName_HideAni()
  if nil == Panel_ExitConfirm then
    return
  end
end
function PaGlobal_ExitConfirm_All_Open()
  PaGlobal_ExitConfirm_All:prepareOpen()
end
function PaGlobal_ExitConfirm_All_Close()
  PaGlobal_ExitConfirm_All:prepareClose()
end
function PaGlobal_ExitConfirm_All_SetNextReward()
  PaGlobal_ExitConfirm_All:setNextReward()
end
function PaGlobal_ExitConfirm_All_GameExitSuccess()
  HandleEventLUp_ExitConfirm_All_ExitConfirm()
end
