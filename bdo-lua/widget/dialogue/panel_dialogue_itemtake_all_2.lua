function PaGlobal_Dialogue_Itemtake_All_Open(displayData)
  PaGlobal_Dialogue_Itemtake_All:prepareOpen(displayData)
end
function PaGlobal_Dialogue_Itemtake_All_Close()
  PaGlobal_Dialogue_Itemtake_All:prepareClose()
end
function HandleEventOn_Dialogue_Itemtake_All_ShowTooltip()
  local itemStaticWrapper = getItemEnchantStaticStatus(PaGlobal_Dialogue_Itemtake_All._currentDisplayData:getItemKey())
  if nil == itemStaticWrapper then
    return
  end
  if true == PaGlobal_Dialogue_Itemtake_All._isConsole then
    Panel_Tooltip_Item_Show(itemStaticWrapper, Panel_Dialogue_Itemtake_All, true, false)
  else
    Panel_Tooltip_Item_Show(itemStaticWrapper, PaGlobal_Dialogue_Itemtake_All._ui._icon_items.icon, true, false)
  end
end
function HandlePadEventX_Dialogue_Itemtake_All_ShowTooltip()
  if true == PaGlobalFunc_TooltipInfo_GetShow() then
    PaGlobalFunc_TooltipInfo_Close()
    return
  end
  local itemStaticWrapper = getItemEnchantStaticStatus(PaGlobal_Dialogue_Itemtake_All._currentDisplayData:getItemKey())
  if nil == itemStaticWrapper then
    return
  end
  PaGlobalFunc_TooltipInfo_Open(Defines.TooltipDataType.ItemSSWrapper, itemStaticWrapper, Defines.TooltipTargetType.Item, 0, getScreenSizeX())
end
function HandleEventLUp_Dialogue_Itemtake_All_ClickYes()
  local explorePoint = getExplorePointByTerritory(PaGlobal_Dialogue_Itemtake_All._currentDisplayData._territoryKey)
  if explorePoint:getRemainedPoint() < PaGlobal_Dialogue_Itemtake_All._currentDisplayData._needPoint then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "DIALOG_ERROR_SHORTAGE_POINT"))
    return
  end
  Dialog_clickDialogButtonReq(PaGlobal_Dialogue_Itemtake_All._selectedIndex)
  PaGlobal_Dialogue_Itemtake_All_Close()
end
function HandleEventLUp_Dialogue_Itemtake_All_ClickNo()
  PaGlobalFunc_DialogList_All_SetContactTalk(false)
  PaGlobal_Dialogue_Itemtake_All_Close()
end
function FromClient_Dialogue_Itemtake_All_ReSizePanel()
  Panel_Dialogue_Itemtake_All:ComputePos()
  if false == PaGlobal_Dialogue_Itemtake_All._isConsole then
    PaGlobal_Dialogue_Itemtake_All._ui_pc.btn_yes:ComputePos()
    PaGlobal_Dialogue_Itemtake_All._ui_pc.btn_no:ComputePos()
  else
    local tempBtnGroup = {
      PaGlobal_Dialogue_Itemtake_All._ui_console.stc_guideIconA,
      PaGlobal_Dialogue_Itemtake_All._ui_console.stc_guideIconX,
      PaGlobal_Dialogue_Itemtake_All._ui_console.stc_guideIconB
    }
    PaGlobalFunc_ConsoleKeyGuide_SetAlign(tempBtnGroup, PaGlobal_Dialogue_Itemtake_All._ui_console.stc_bottomBg, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP)
    PaGlobal_Dialogue_Itemtake_All._ui_console.stc_bottomBg:ComputePos()
  end
  PaGlobal_Dialogue_Itemtake_All._ui.stc_titleBG:ComputePos()
  PaGlobal_Dialogue_Itemtake_All._ui.txt_title:ComputePos()
  PaGlobal_Dialogue_Itemtake_All._ui.stc_midBG:ComputePos()
  PaGlobal_Dialogue_Itemtake_All._ui.stc_subFrameBG:ComputePos()
  PaGlobal_Dialogue_Itemtake_All._ui.stc_itemIcon:ComputePos()
  PaGlobal_Dialogue_Itemtake_All._ui.txt_Comment:ComputePos()
  PaGlobal_Dialogue_Itemtake_All._ui.txt_itemName:ComputePos()
  PaGlobal_Dialogue_Itemtake_All._ui.stc_line:ComputePos()
  PaGlobal_Dialogue_Itemtake_All._ui.txt_needContribution:ComputePos()
  PaGlobal_Dialogue_Itemtake_All._ui.txt_myContribution:ComputePos()
  PaGlobal_Dialogue_Itemtake_All._ui.stc_territorymark:ComputePos()
  PaGlobal_Dialogue_Itemtake_All._ui.txt_helpMsg:ComputePos()
  PaGlobal_Dialogue_Itemtake_All._ui.stc_titleDeco:ComputePos()
end
function PaGlobal_Dialogue_Itemtake_All_SelectedIndex(index)
  PaGlobal_Dialogue_Itemtake_All._selectedIndex = index
end
function PaGlobal_Dialogue_Itemtake_All_ShowAni()
  if nil == Panel_Dialogue_Itemtake_All then
    return
  end
end
function PaGlobal_Dialogue_Itemtake_All_HideAni()
  if nil == Panel_Dialogue_Itemtake_All then
    return
  end
end
