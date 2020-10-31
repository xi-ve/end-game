function PaGlobalFunc_ServantInfo_All_Open(servantNo)
  if nil == Panel_Dialog_ServantInfo_All then
    return
  end
  if PaGlobal_ServantInfo_All._currentVehicleIndexNo ~= servantNo then
    PaGlobal_ServantInfo_All._currentSkillListData._index = nil
    PaGlobal_ServantInfo_All._currentSkillListData._pos = nil
  end
  PaGlobal_ServantInfo_All._currentSlotType = -1
  if nil ~= Panel_Dialog_ServantList_All then
    PaGlobal_ServantInfo_All._currentSlotType = PaGlobalFunc_ServantList_All_Get_CurrentSlotType()
  end
  if -1 == PaGlobal_ServantInfo_All._currentSlotType or nil == PaGlobal_ServantInfo_All._currentSlotType then
    return
  end
  if nil ~= Panel_Dialog_ServantLookChange_All and true == Panel_Dialog_ServantLookChange_All:GetShow() then
    PaGlobalFunc_ServantLookChange_All_Close()
  end
  PaGlobal_ServantInfo_All._currentVehicleIndexNo = servantNo
  PaGlobal_ServantInfo_All._currentNpcType = PaGlobalFunc_ServantFunction_All_Get_NpcType()
  PaGlobal_ServantInfo_All:prepareOpen()
end
function PaGlobalFunc_ServantInfo_All_Close()
  if nil == Panel_Dialog_ServantInfo_All or false == Panel_Dialog_ServantInfo_All:GetShow() then
    return
  end
  PaGlobal_ServantInfo_All:prepareClose()
end
function FromClient_ServantInfo_All_OnScreenSize()
  if nil == Panel_Dialog_ServantInfo_All or false == Panel_Dialog_ServantInfo_All:GetShow() then
    return
  end
  Panel_Dialog_ServantInfo_All:ComputePos()
end
function PaGlobalFunc_ServantInfo_All_ShowAni()
  UIAni.fadeInSCR_Right(Panel_Dialog_ServantInfo_All)
  local aniInfo3 = Panel_Dialog_ServantInfo_All:addColorAnimation(0, 0.2, UI_ANI_ADV.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfo3:SetStartColor(UI_color.C_00FFFFFF)
  aniInfo3:SetEndColor(UI_color.C_FFFFFFFF)
  aniInfo3.IsChangeChild = false
end
function PaGlobalFunc_ServantInfo_All_HideAni()
  Panel_Dialog_ServantInfo_All:SetShowWithFade(CppEnums.PAUI_SHOW_FADE_TYPE.PAUI_ANI_TYPE_FADE_OUT)
  local aniInfo1 = Panel_Dialog_ServantInfo_All:addColorAnimation(0, 0.22, UI_ANI_ADV.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
  aniInfo1:SetStartColor(UI_color.C_FFFFFFFF)
  aniInfo1:SetEndColor(UI_color.C_00FFFFFF)
  aniInfo1:SetStartIntensity(3)
  aniInfo1:SetEndIntensity(1)
  aniInfo1.IsChangeChild = true
  aniInfo1:SetHideAtEnd(true)
  aniInfo1:SetDisableWhileAni(true)
end
function FromClient_ClearGuildServantDeadCount()
  if nil == Panel_Dialog_ServantInfo_All or false == Panel_Dialog_ServantInfo_All:GetShow() then
    return
  end
  local currentServantNo = PaGlobal_ServantList_All:stableList_SelectSlotNo(PaGlobal_ServantList_All._selectSlotNo)
  if nil == currentServantNo then
    return
  end
  local servantInfo = guildStable_getServant(currentServantNo)
  if nil == servantInfo then
    return
  end
  if servantInfo:getVehicleType() == CppEnums.VehicleType.Type_Elephant then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_SERVANT_RECOVERINJURY_ELEPHANT"))
  else
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_STABLELIST_RESTOREDAMAGE_ACK"))
  end
  PaGlobal_ServantInfo_All:update()
end
function PaGlobalFunc_ServantInfo_All_Update()
  if nil == Panel_Dialog_ServantInfo_All or false == Panel_Dialog_ServantInfo_All:GetShow() then
    return
  end
  PaGlobal_ServantInfo_All:update()
end
function FromClient_ServantInfo_All_List2ServantSkill(content, key)
  if nil == Panel_Dialog_ServantInfo_All or false == Panel_Dialog_ServantInfo_All:GetShow() then
    return
  end
  PaGlobal_ServantInfo_All:updateServantSkillByList2(content, key)
end
function FromClient_ServantInfo_All_ForgetServantSkill(notUse, notUse)
  if nil == Panel_Dialog_ServantInfo_All or false == Panel_Dialog_ServantInfo_All:GetShow() then
    return
  end
  PaGlobal_ServantInfo_All:update()
  PaGlobal_ServantList_All:update()
end
function FromClient_ServantInfo_All_SkillChangeFinish()
  if nil == Panel_Dialog_ServantInfo_All or false == Panel_Dialog_ServantInfo_All:GetShow() then
    return
  end
  PaGlobal_ServantInfo_All:update()
  PaGlobal_ServantList_All:update()
end
function FromClient_ServantInfo_All_SetBeginningLevelServant()
  if nil == Panel_Dialog_ServantInfo_All or false == Panel_Dialog_ServantInfo_All:GetShow() then
    return
  end
  local msg = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANT_COMPLETE_SETBEGINNINGLEVEL")
  Proc_ShowMessage_Ack_WithOut_ChattingMessage(msg)
  if nil == PaGlobal_ServantInfo_All._currentVehicleIndexNo then
    PaGlobalFunc_ServantInfo_All_Open(0)
  else
    PaGlobal_ServantInfo_All:update()
  end
  PaGlobal_ServantList_All:update()
end
function HandleEventLUp_ServantInfo_All_SkillChangeOpen()
  if nil == Panel_Dialog_ServantInfo_All or false == Panel_Dialog_ServantInfo_All:GetShow() then
    return
  end
  PaGlobalFunc_ServantFunction_All_ChangeTab(0)
  if nil ~= Panel_Dialog_ServantSkillManagement_All then
    PaGlobalFunc_ServantSkillManagement_All_Open(PaGlobal_ServantInfo_All._currentVehicleIndexNo)
  end
  local servantInfo = stable_getServant(PaGlobal_ServantInfo_All._currentVehicleIndexNo)
  if nil == servantInfo then
    return
  end
end
function HandleEventLUp_ServantInfo_All_MatingCompleteImmediately()
  if nil == Panel_Dialog_ServantInfo_All or false == Panel_Dialog_ServantInfo_All:GetShow() or nil == PaGlobal_ServantInfo_All._currentVehicleIndexNo then
    return
  end
  local servantInfo = stable_getServant(PaGlobal_ServantInfo_All._currentVehicleIndexNo)
  if nil == servantInfo then
    return
  end
  local function matingImmediately()
    stable_requestCompleteServantMating(PaGlobal_ServantInfo_All._currentVehicleIndexNo, servantInfo:getCompleteMatingFromPearl_s64())
  end
  local titleString = PAGetString(Defines.StringSheet_GAME, "LUA_IMMDEDIATELY_MSGBOX_TITLE")
  local contentString = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_IMMDEDIATELY_MSGBOX_SERVANT_MEMO", "pearl", tostring(servantInfo:getCompleteMatingFromPearl_s64()))
  local messageboxData = {
    title = titleString,
    content = contentString,
    functionYes = matingImmediately,
    functionCancel = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageboxData)
end
function HandleEventLUp_ServantInfo_All_MatingCompleteImmediately()
  if nil == Panel_Dialog_ServantInfo_All or false == Panel_Dialog_ServantInfo_All:GetShow() or nil == PaGlobal_ServantInfo_All._currentVehicleIndexNo then
    return
  end
  local servantInfo = stable_getServant(PaGlobal_ServantInfo_All._currentVehicleIndexNo)
  if nil == servantInfo then
    return
  end
  local function matingImmediately()
    stable_requestCompleteServantMating(PaGlobal_ServantInfo_All._currentVehicleIndexNo, servantInfo:getCompleteMatingFromPearl_s64())
  end
  local titleString = PAGetString(Defines.StringSheet_GAME, "LUA_IMMDEDIATELY_MSGBOX_TITLE")
  local contentString = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_IMMDEDIATELY_MSGBOX_SERVANT_MEMO", "pearl", tostring(servantInfo:getCompleteMatingFromPearl_s64()))
  local messageboxData = {
    title = titleString,
    content = contentString,
    functionYes = matingImmediately,
    functionCancel = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageboxData)
end
function HandleEventLUp_ServantInfo_All_MatingCompleteImmediately()
  if nil == Panel_Dialog_ServantInfo_All or false == Panel_Dialog_ServantInfo_All:GetShow() or nil == PaGlobal_ServantInfo_All._currentVehicleIndexNo then
    return
  end
  local servantInfo = stable_getServant(PaGlobal_ServantInfo_All._currentVehicleIndexNo)
  if nil == servantInfo then
    return
  end
  local function matingImmediately()
    stable_requestCompleteServantMating(PaGlobal_ServantInfo_All._currentVehicleIndexNo, servantInfo:getCompleteMatingFromPearl_s64())
  end
  local titleString = PAGetString(Defines.StringSheet_GAME, "LUA_IMMDEDIATELY_MSGBOX_TITLE")
  local contentString = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_IMMDEDIATELY_MSGBOX_SERVANT_MEMO", "pearl", tostring(servantInfo:getCompleteMatingFromPearl_s64()))
  local messageboxData = {
    title = titleString,
    content = contentString,
    functionYes = matingImmediately,
    functionCancel = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageboxData)
end
function HandleEventOn_Servant_Tooltip_Open(key32)
  if nil == Panel_Dialog_ServantInfo_All then
    return
  end
  PaGlobal_ServantInfo_All:Servant_Tooltip_Open(key32)
end
function HandleEventOnOut_ServantInfo_All_ShowSkillTitleToolTip(key32, isShow)
  if false == isShow then
    TooltipSimple_Hide()
    return
  end
  local content = PaGlobal_ServantInfo_All._ui._list2_Skill:GetContentByKey(toInt64(0, key32))
  local control = UI.getChildControl(content, "StaticText_SkillName")
  if nil == control then
    return
  end
  local name = ""
  local desc = control:GetText()
  TooltipSimple_Show(control, name, desc)
end
function HandleEventScroll_ServantInfo_All_saveScrollPos()
  PaGlobal_ServantInfo_All._currentSkillListData._index = PaGlobal_ServantInfo_All._ui._list2_Skill:getCurrenttoIndex()
  PaGlobal_ServantInfo_All._currentSkillListData._pos = PaGlobal_ServantInfo_All._ui._list2_Skill:GetVScroll():GetControlPos()
end
function HandleEventOut_ServantInfo_All_SkillTooltipClose()
  if true == PaGlobal_ServantInfo_All._isConsole then
    return
  end
  if true == _ContentsGroup_NewUI_Tooltip_All then
    if nil ~= PaGlobal_Tooltip_Skill_Servant_All_Close then
      PaGlobal_Tooltip_Skill_Servant_All_Close()
    end
  elseif nil ~= PaGlobal_Tooltip_Servant_Close then
    PaGlobal_Tooltip_Servant_Close()
  end
end
function PaGlobalFunc_ServantInfo_All_IsSkillBgShow()
  return PaGlobal_ServantInfo_All._ui._stc_SkillBg:GetShow()
end
