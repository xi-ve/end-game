function PaGlobalFunc_ServantLookChange_All_Open()
  if nil == Panel_Dialog_ServantLookChange_All then
    return
  end
  local servantNo
  if nil ~= Panel_Dialog_ServantList_All then
    servantNo = PaGlobalFunc_ServantList_All_Get_SortedServantNo()
  end
  if nil == servantNo then
    return
  end
  PaGlobal_ServantLookChange_All._currentServantNo = servantNo
  if nil ~= Panel_Dialog_ServantInfo_All and true == Panel_Dialog_ServantInfo_All:GetShow() then
    PaGlobalFunc_ServantInfo_All_Close()
  end
  PaGlobal_ServantLookChange_All:prepareOpen()
end
function PaGlobalFunc_ServantLookChange_All_Close()
  PaGlobal_ServantLookChange_All:prepareClose()
end
function PaGlobalFunc_ServantLookChange_All_OnScreenReSize()
  Panel_Dialog_ServantLookChange_All:ComputePos()
end
function HandleEventLUp_ServantLookChange_All_OpenComboBox()
  PaGlobal_ServantLookChange_All._ui._comboBox_TierSelect_PC:ToggleListbox()
end
function HandleEventLUp_ServantLookChange_All_SelectComboBox()
  local tierIndex = PaGlobal_ServantLookChange_All._ui._comboBox_TierSelect_PC:GetSelectIndex()
  if tierIndex <= 0 then
    PaGlobal_ServantLookChange_All._ui._comboBox_TierSelect_PC:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_STABLELIST_LOOKCHANGE_SPECIAL"))
  else
    PaGlobal_ServantLookChange_All._ui._comboBox_TierSelect_PC:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_STABLELIST_LOOKCHANGE_SPECIAL_TIER", "tierIndex", tierIndex))
  end
  PaGlobal_ServantLookChange_All:updateHorseLook()
end
function FromClient_ServantLookChange_All_list2Update(content, key)
  PaGlobal_ServantLookChange_All:list2UpdateHorseLook(content, key)
end
function HandleEventLUp_ServantLookChange_All_SelectTier(idx)
  if nil == idx then
    return
  end
  local selectedSceneIndex, sortedSlotNo
  if nil ~= Panel_Dialog_ServantList_All then
    selectedSceneIndex = PaGlobalFunc_ServantList_All_GetSceneIndex()
    sortedSlotNo = PaGlobalFunc_ServantList_All_Get_SortedServantNo()
  end
  if nil == selectedSceneIndex or nil == sortedSlotNo then
    return
  end
  local formManager = getServantFormManager()
  local tierIndex = PaGlobal_ServantLookChange_All._ui._comboBox_TierSelect_PC:GetSelectIndex()
  if tierIndex <= 0 then
    tierIndex = 0
  end
  local servantInfo = stable_getServant(PaGlobal_ServantLookChange_All._currentServantNo)
  if nil == servantInfo then
    return
  end
  local actionIndex
  local servantActionIndex = servantInfo:getActionIndex()
  local formInfo
  if 0 < tierIndex then
    formInfo = formManager:getFormTierStaticWrapper(tierIndex, idx)
  else
    formInfo = formManager:getFormTierStaticWrapper(0, idx)
  end
  if nil ~= formInfo then
    PaGlobalFunc_ServantFunction_All_Servant_ScenePopObject(selectedSceneIndex)
    actionIndex = formInfo:getActionIndex()
    if -1 ~= PaGlobal_ServantLookChange_All._beforeSceneIndex then
      showSceneCharacter(selectedSceneIndex, false)
    end
    showSceneCharacter(selectedSceneIndex, true, actionIndex)
    PaGlobal_ServantLookChange_All._beforeSceneIndex = actionIndex
  else
    PaGlobalFunc_ServantFunction_All_Servant_ScenePopObject(selectedSceneIndex)
    actionIndex = servantInfo:getBaseActionIndex()
    if -1 ~= PaGlobal_ServantLookChange_All._beforeSceneIndex then
      showSceneCharacter(selectedSceneIndex, false)
    end
    showSceneCharacter(selectedSceneIndex, true, actionIndex)
    PaGlobal_ServantLookChange_All._beforeSceneIndex = actionIndex
  end
  PaGlobal_ServantLookChange_All._ui._btn_ChangeLook:SetIgnore(servantActionIndex == actionIndex)
  PaGlobal_ServantLookChange_All._ui._btn_ChangeLook:SetMonoTone(servantActionIndex == actionIndex)
  PaGlobal_ServantLookChange_All._ui._btn_ChangeSpecialLook:SetIgnore(servantActionIndex == actionIndex)
  PaGlobal_ServantLookChange_All._ui._btn_ChangeSpecialLook:SetMonoTone(servantActionIndex == actionIndex)
  local isPossibleLearnSkill = stable_isPossibleLearnServantSkill(sortedSlotNo)
  if 30 == servantInfo:getLevel() and not isPossibleLearnSkill then
    PaGlobal_ServantLookChange_All._ui._btn_ChangeSpecialLook:SetIgnore(true)
    PaGlobal_ServantLookChange_All._ui._btn_ChangeSpecialLook:SetMonoTone(true)
  end
  PaGlobal_ServantLookChange_All._currentLookIndex = idx
end
function HandleEventLUp_ServantLookChange_All_ShipLookChange(idx)
  if nil == idx then
    return
  end
  local selectedSceneIndex, sortedSlotNo
  if nil ~= Panel_Dialog_ServantList_All then
    selectedSceneIndex = PaGlobalFunc_ServantList_All_GetSceneIndex()
    sortedSlotNo = PaGlobalFunc_ServantList_All_Get_SortedServantNo()
  end
  if nil == selectedSceneIndex or nil == sortedSlotNo then
    return
  end
  local servantInfo = stable_getServant(PaGlobal_ServantLookChange_All._currentServantNo)
  if nil == servantInfo then
    return
  end
  local formInfo
  local formManager = getServantTransformManager()
  local fromCharacterKey = servantInfo:getCharacterKeyRaw()
  formInfo = formManager:getFormStaticWrapper(fromCharacterKey, idx)
  if nil == formInfo then
    return
  end
  actionIndex = formInfo:getActionIndex()
  PaGlobalFunc_ServantFunction_All_Servant_ScenePopObject(selectedSceneIndex)
  if -1 ~= PaGlobal_ServantLookChange_All._beforeSceneIndex then
    showSceneCharacter(PaGlobal_ServantLookChange_All._beforeSceneIndex, false)
  end
  showSceneCharacter(formInfo:getTransformCharacterKey(), true)
  PaGlobal_ServantLookChange_All._beforeSceneIndex = formInfo:getTransformCharacterKey()
  if nil ~= formInfo and fromCharacterKey == formInfo:getTransformCharacterKey() then
    PaGlobal_ServantLookChange_All._ui._btn_ChangeLook:SetIgnore(true)
    PaGlobal_ServantLookChange_All._ui._btn_ChangeLook:SetMonoTone(true)
  else
    PaGlobal_ServantLookChange_All._ui._btn_ChangeLook:SetIgnore(false)
    PaGlobal_ServantLookChange_All._ui._btn_ChangeLook:SetMonoTone(false)
  end
  PaGlobal_ServantLookChange_All._currentLookIndex = idx
end
function HandleEventLUp_ServantLookChange_All_ChangeLook(isPremium)
  if nil == PaGlobal_ServantLookChange_All._currentLookIndex then
    return
  end
  local sortedSlotNo
  if nil ~= Panel_Dialog_ServantList_All then
    sortedSlotNo = PaGlobalFunc_ServantList_All_Get_SortedServantNo()
  end
  if nil == sortedSlotNo then
    return
  end
  local servantInfo = stable_getServant(PaGlobal_ServantLookChange_All._currentServantNo)
  if nil == servantInfo then
    return
  end
  local _title = PAGetString(Defines.StringSheet_GAME, "LUA_STABLELIST_CHANGECONFIRM_TITLE")
  local _desc = PAGetString(Defines.StringSheet_GAME, "LUA_STABLELIST_CHANGECONFIRM_MEMO")
  local _confirmFunction = MessageBox_Empty_function
  local _cancel = MessageBox_Empty_function
  local _priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  if 0 == PaGlobalFunc_ServantFunction_All_Get_NpcType() then
    do
      local isPossibleLearnSkill = stable_isPossibleLearnServantSkill(sortedSlotNo)
      local formManager = getServantFormManager()
      local tierIndex = PaGlobal_ServantLookChange_All._ui._comboBox_TierSelect_PC:GetSelectIndex()
      if tierIndex <= 0 then
        tierIndex = 0
      end
      local formInfo, formIndex
      local lookCount = formManager:getFormTierSize(tierIndex)
      if lookCount > PaGlobal_ServantLookChange_All._currentLookIndex then
        formInfo = formManager:getFormTierStaticWrapper(tierIndex, PaGlobal_ServantLookChange_All._currentLookIndex)
        if nil == formInfo then
          return
        end
        formIndex = formInfo:getIndexRaw()
      else
        local servantInfo = stable_getServant(sortedSlotNo)
        if nil == servantInfo then
          return
        end
        formIndex = 0
      end
      local function changeConfirm()
        stable_changeForm(sortedSlotNo, formIndex, 0)
        PaGlobalFunc_ServantList_All_Update()
        PaGlobalFunc_ServantLookChange_All_Close()
      end
      local function premiumChangeConfirm()
        stable_changeForm(sortedSlotNo, formIndex, 1, isPossibleLearnSkill)
        PaGlobalFunc_ServantList_All_Update()
        PaGlobalFunc_ServantLookChange_All_Close()
      end
      _confirmFunction = changeConfirm
      if true == isPremium then
        _confirmFunction = premiumChangeConfirm
        if true == isPossibleLearnSkill then
          _desc = PAGetString(Defines.StringSheet_GAME, "LUA_STABLELIST_PREMIUMCHANGECONFIRM_MEMO")
        else
          _desc = PAGetString(Defines.StringSheet_GAME, "LUA_STABLELIST_PREMIUMCHANGEALERT")
        end
      end
    end
  elseif 2 == PaGlobalFunc_ServantFunction_All_Get_NpcType() then
    _title = PAGetString(Defines.StringSheet_GAME, "LUA_WHARFLIST_CHANGECONFIRM_TITLE")
    _desc = PAGetString(Defines.StringSheet_GAME, "LUA_WHARFLIST_CHANGECONFIRM_MEMO")
    do
      local formManager = getServantTransformManager()
      local formIndex
      local chracterKey = servantInfo:getCharacterKeyRaw()
      local lookCount = formManager:getFormListSize(chracterKey)
      if lookCount <= PaGlobal_ServantLookChange_All._currentLookIndex then
        return
      end
      local formInfo = formManager:getFormStaticWrapper(chracterKey, PaGlobal_ServantLookChange_All._currentLookIndex)
      if nil == formInfo then
        return
      end
      formIndex = formInfo:getTransformIndex()
      local function shipChangeConfirm()
        stable_servantTransform(sortedSlotNo, formIndex)
        PaGlobalFunc_ServantList_All_Update()
        PaGlobalFunc_ServantLookChange_All_Close()
      end
      _confirmFunction = shipChangeConfirm
    end
  else
    return
  end
  messageboxData = {
    title = _title,
    content = _desc,
    functionYes = _confirmFunction,
    functionCancel = _cancel,
    priority = _priority
  }
  MessageBox.showMessageBox(messageboxData)
end
