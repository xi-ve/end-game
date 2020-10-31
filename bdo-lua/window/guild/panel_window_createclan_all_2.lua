function PaGlobal_CreateClan_All_Open()
  PaGlobal_CreateClan_All:prepareOpen()
end
function PaGlobal_CreateClan_All_Close()
  PaGlobal_CreateClan_All:prepareClose()
  PaGlobal_Guild_Create_All_Close()
  ClearFocusEdit()
end
function HandleEventLUp_CreateClan_All_clickedSelectType()
  PaGlobal_CreateClan_All:setSelectTypeDesc()
end
function HandleEventLUp_CreateClan_All_clickedConfirm()
  PaGlobal_Guild_Create_All_Open(PaGlobal_CreateClan_All._ui.btn_clan:IsChecked())
end
function Input_CreateClan_All_ChangeType()
  if PaGlobal_CreateClan_All._ui.btn_guild:IsChecked() and PaGlobal_CreateClan_All._ui.btn_clan:IsIgnore() or PaGlobal_CreateClan_All._ui.btn_clan:IsChecked() and PaGlobal_CreateClan_All._ui.btn_guild:IsIgnore() then
    return
  end
  if PaGlobal_CreateClan_All._ui.btn_clan:IsChecked() then
    PaGlobal_CreateClan_All._ui.btn_clan:SetCheck(false)
    PaGlobal_CreateClan_All._ui.btn_guild:SetCheck(true)
  else
    PaGlobal_CreateClan_All._ui.btn_clan:SetCheck(true)
    PaGlobal_CreateClan_All._ui.btn_guild:SetCheck(false)
  end
  PaGlobal_CreateClan_All:setSelectTypeDesc()
end
function FromClient_CreateClan_All_ReSizePanel()
  if false == PaGlobal_CreateClan_All._isConsole then
    PaGlobal_CreateClan_All._ui_pc.btn_close:ComputePos()
    PaGlobal_CreateClan_All._ui_pc.btn_question:ComputePos()
    PaGlobal_CreateClan_All._ui_pc.btn_confirm:ComputePos()
  else
    Panel_CreateClan_All:ComputePos()
    local panelPosY = Panel_CreateClan_All:GetPosY()
    Panel_CreateClan_All:SetPosY(panelPosY - PaGlobal_CreateClan_All._consloeMoveY)
    PaGlobal_CreateClan_All._ui_console.stc_bottomBg:ComputePos()
    PaGlobal_CreateClan_All._ui_console.btn_confirm:ComputePos()
    PaGlobal_CreateClan_All._ui_console.btn_close:ComputePos()
  end
  PaGlobal_CreateClan_All._ui.stc_title:ComputePos()
  PaGlobal_CreateClan_All._ui.stc_btnBg:ComputePos()
  PaGlobal_CreateClan_All._ui.btn_clan:ComputePos()
  PaGlobal_CreateClan_All._ui.btn_guild:ComputePos()
  PaGlobal_CreateClan_All._ui.stc_selectTypeDesc:ComputePos()
end
function HandleEventMOn_CreateClan_All_SetButtonCheck(isClan)
  if nil == Panel_CreateClan_All then
    return
  end
  PaGlobal_CreateClan_All._ui.btn_clan:SetCheck(isClan)
  PaGlobal_CreateClan_All._ui.btn_guild:SetCheck(not isClan)
end
function PaGloabl_CreateClan_All_ShowAni()
  if nil == Panel_CreateClan_All then
    return
  end
end
function PaGloabl_CreateClan_All_HideAni()
  if nil == Panel_CreateClan_All then
    return
  end
end
