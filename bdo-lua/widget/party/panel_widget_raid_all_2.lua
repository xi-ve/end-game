function PaGlobalFunc_Widget_Raid_All_Open()
  PaGlobal_Raid_All:prepareOpen()
end
function PaGlobalFunc_Widget_Raid_All_Close()
  PaGlobal_Raid_All:prepareClose()
end
function HandleEventOnOut_Widget_Raid_All_LimitTextTooptip(isShow, index)
  PaGlobal_Raid_All:limitTextTooptip(isShow, index)
end
function HanldeEventOnOut_Widget_Raid_All_ButtonAction(isShow, index)
  PaGlobal_Raid_All:showButtonAction(isShow, index)
end
function HanldeEventLUp_Widget_Raid_All_ClickButtonAction(index)
  PaGlobal_Raid_All:clickButtonAction(index)
end
function HandleEventLUp_Widget_Raid_All_ChangeLeader()
  PaGlobal_Raid_All:changeLeader()
end
function HandleEventLUp_Widget_Raid_All_BanishMember()
  PaGlobal_Raid_All:banishMember()
end
function HandleEventLUp_Widget_Raid_All_ExitParty()
  PaGlobal_Raid_All:exitParty()
end
function FromClient_Widget_Raid_All_HideOption()
  if nil == Panel_Widget_Raid_All then
    return
  end
  PaGlobal_Raid_All._ui_pc.btn_leave:SetShow(false)
  PaGlobal_Raid_All._ui_pc.btn_ordersBg:SetShow(false)
end
function FromClient_Widget_Raid_All_ScreenResize()
  PaGlobal_Raid_All:resize()
end
function PaGlobalFunc_Widget_Raid_All_Update()
  PaGlobal_Raid_All:update()
end
function PaGlobalFunc_Widget_Raid_All_GetShow()
  if nil == Panel_Widget_Raid_All then
    return false
  end
  return Panel_Widget_Raid_All:GetShow()
end
