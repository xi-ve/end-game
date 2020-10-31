function PaGlobalFunc_ServantSwiftTraining_All_Open(servantNo)
  if nil == Panel_Dialog_ServantSwiftTraining_All or true == Panel_Dialog_ServantSwiftTraining_All:GetShow() or nil == servantNo then
    return
  end
  PaGlobal_ServantSwiftTraining_All._currentServentNo = servantNo
  PaGlobal_ServantSwiftTraining_All:prepareOpen()
end
function PaGlobalFunc_ServantSwiftTraining_All_Close()
  if nil == Panel_Dialog_ServantSwiftTraining_All or false == Panel_Dialog_ServantSwiftTraining_All:GetShow() then
    return
  end
  PaGlobal_ServantSwiftTraining_All:prepareClose()
end
function PaGlobalFunc_ServantSwiftTraining_All_OnScreenResize()
  if nil == Panel_Dialog_ServantSwiftTraining_All or false == Panel_Dialog_ServantSwiftTraining_All:GetShow() then
    return
  end
  Panel_Dialog_ServantSwiftTraining_All:ComputePos()
end
function HandleEventLUp_ServantSwiftTraining_All_ShowGuide()
  if nil == Panel_Dialog_ServantSwiftTraining_All or false == Panel_Dialog_ServantSwiftTraining_All:GetShow() then
    return
  end
  local _ui = PaGlobal_ServantSwiftTraining_All._ui
  if false == PaGlobal_ServantSwiftTraining_All._isGuideShow then
    _ui._stc_DescTooltipBg:SetShow(true)
    local gap = _ui._txt_DescTooltip:GetTextSizeY() + 20 - PaGlobal_ServantSwiftTraining_All._ORIGIN_SWIFTGUIDEBG_SIZEY
    _ui._stc_DescTooltipBg:SetSize(_ui._stc_DescTooltipBg:GetSizeX(), PaGlobal_ServantSwiftTraining_All._ORIGIN_SWIFTGUIDEBG_SIZEY + gap)
    _ui._stc_DescTooltipBg:ComputePos()
    _ui._txt_DescTooltip:ComputePos()
    _ui._stc_CronTooltipBg:SetShow(true)
    local cronTextSize = _ui._txt_CronTooltip:GetTextSizeY()
    if cronTextSize + 10 >= PaGlobal_ServantSwiftTraining_All._ORIGIN_CRONGUIDEBG_SIZEY then
      local cronGap = _ui._txt_CronTooltip:GetTextSizeY() - PaGlobal_ServantSwiftTraining_All._ORIGIN_CRONGUIDEBG_SIZEY
      _ui._stc_CronTooltipBg:SetSize(_ui._stc_CronTooltipBg:GetSizeX(), PaGlobal_ServantSwiftTraining_All._ORIGIN_CRONGUIDEBG_SIZEY + cronGap)
      _ui._stc_CronTooltipBg:ComputePos()
    else
      _ui._stc_CronTooltipBg:SetSize(_ui._stc_CronTooltipBg:GetSizeX(), _ui._txt_CronTooltip:GetTextSizeY() + 10)
      _ui._stc_CronTooltipBg:ComputePos()
    end
    PaGlobal_ServantSwiftTraining_All._isGuideShow = true
  else
    _ui._stc_DescTooltipBg:SetShow(false)
    _ui._stc_CronTooltipBg:SetShow(false)
    PaGlobal_ServantSwiftTraining_All._isGuideShow = false
  end
end
function PaGlobalFunc_ServantSwiftTraining_All_listCreate(control, key)
  if nil == Panel_Dialog_ServantSwiftTraining_All or false == Panel_Dialog_ServantSwiftTraining_All:GetShow() then
    return
  end
  PaGlobal_ServantSwiftTraining_All:listCreate(control, key)
end
function HandleEventOnOut_ServantSwiftTraining_All_AwakenItemToolTip(isShow, isCron)
  if nil == Panel_Dialog_ServantSwiftTraining_All or false == Panel_Dialog_ServantSwiftTraining_All:GetShow() or false == isShow or nil == isShow or nil == isCron then
    Panel_Tooltip_Item_hideTooltip()
    return
  end
  local control, itemSSW
  if true == isCron then
    itemSSW = FromClient_getPreventDownGradeItem()
    control = PaGlobal_ServantSwiftTraining_All._ui._btn_Check_Cron
  else
    itemSSW = stable_getStallionTrainingCompleteRequiredItem()
    control = PaGlobal_ServantSwiftTraining_All._ui._stc_CrogdaloSlot
  end
  if true == isShow and nil ~= control then
    Panel_Tooltip_Item_Show(itemSSW, control, true, false, nil, nil, nil)
  end
end
function HandleEventOnOut_ServantSwiftTraining_All_MaterialToolTip(slotType, UIIdx, slotNo, itemCategory)
  if nil == Panel_Dialog_ServantSwiftTraining_All or false == Panel_Dialog_ServantSwiftTraining_All:GetShow() then
    return
  end
  local itemWrapper
  if nil ~= itemCategory then
    local skillWrapper = stable_getStallionTrainingSkillListAt(itemCategory)
    if nil == skillWrapper then
      return
    end
    local skillKey = skillWrapper:getKey()
    itemWrapper = stable_getStallionSkillItemListAt(skillKey, slotNo)
  else
    itemWrapper = getInventoryItemByType(CppEnums.ItemWhereType.eInventory, slotNo)
  end
  if nil ~= itemWrapper then
    local itemSSW
    if nil == itemCategory then
      itemSSW = itemWrapper:getStaticStatus()
    else
      itemSSW = itemWrapper
    end
    local control
    if 0 == slotType or 1 == slotType or 2 == slotType then
      control = PaGlobal_ServantSwiftTraining_All._trainingSlot[slotType]._materialIconSlot.icon
    elseif 3 == slotType and nil ~= UIIdx then
      control = PaGlobal_ServantSwiftTraining_All._itemSlotList[UIIdx].icon
    end
    if nil ~= control then
      Panel_Tooltip_Item_Show(itemSSW, Panel_Dialog_ServantSwiftTraining_All, true, false, nil, nil, nil)
    end
  end
end
function HandleEventOut_ServantSwiftTraining_All_HideMaterialToolTip()
  Panel_Tooltip_Item_hideTooltip()
end
function HandleEventLUp_ServantSwiftTraining_All_ItemSet_NumPadOn(slotType, itemSlotNo)
  if nil == Panel_Dialog_ServantSwiftTraining_All or false == Panel_Dialog_ServantSwiftTraining_All:GetShow() or nil == PaGlobal_ServantSwiftTraining_All._trainingSlot then
    return
  end
  if PaGlobal_ServantSwiftTraining_All._enum_BtnType._NOTCLICK ~= PaGlobal_ServantSwiftTraining_All._isButtonClick then
    return
  end
  if true == Panel_NumberPad_IsPopUp then
    Panel_NumberPad_Close()
  end
  if 180 <= PaGlobal_ServantSwiftTraining_All._trainingSlot[slotType]._skillExpCount or 100 <= PaGlobal_ServantSwiftTraining_All._awakenExpCount then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_SWIFTTRAINING_ALL_CANNOT_TRAIN"))
    return
  end
  local satllionSkillWrapper = stable_getStallionTrainingSkillListAt(slotType)
  local stallionSkillWrapperKey = satllionSkillWrapper:getKey()
  local itemWhereType = CppEnums.ItemWhereType.eInventory
  local itemWrapper = getInventoryItemByType(itemWhereType, itemSlotNo)
  if nil == itemWrapper then
    return
  end
  local itemMaxCount = ToClient_availableStallionTrainingItemMaxCount(PaGlobal_ServantSwiftTraining_All._currentServentNo, stallionSkillWrapperKey, itemWhereType, itemSlotNo)
  if nil ~= itemMaxCount then
    if itemMaxCount < Int64toInt32(itemWrapper:get():getCount_s64()) then
      itemMaxCount = tonumber64(itemMaxCount)
    else
      itemMaxCount = itemWrapper:get():getCount_s64()
    end
    Panel_NumberPad_Show(true, itemMaxCount, itemSlotNo, HandleEventLUp_ServantSwiftTraining_All_ItemSetConfirm, nil, slotType, nil, nil)
  end
end
function HandleEventLUp_ServantSwiftTraining_All_ItemSetConfirm(inputNumber, slotIdx, slotType)
  if nil == Panel_Dialog_ServantSwiftTraining_All or false == Panel_Dialog_ServantSwiftTraining_All:GetShow() then
    return
  end
  if nil == inputNumber or nil == slotIdx or nil == slotType then
    return
  end
  local itemWrapper = getInventoryItemByType(CppEnums.ItemWhereType.eInventory, slotIdx)
  if nil == itemWrapper then
    return
  end
  local invenItemSSW = itemWrapper:getStaticStatus()
  if nil ~= PaGlobal_ServantSwiftTraining_All._trainingSlot and nil ~= PaGlobal_ServantSwiftTraining_All._trainingSlot[slotType] then
    for i = 0, PaGlobal_ServantSwiftTraining_All._slotCount - 1 do
      if nil ~= PaGlobal_ServantSwiftTraining_All._trainingSlot and nil ~= PaGlobal_ServantSwiftTraining_All._trainingSlot[i] and i ~= slotType then
        HandleEventLUp_ServantSwiftTraining_All_ItemClear(i)
        local skillbg = PaGlobal_ServantSwiftTraining_All._trainingSlot[i]._skillBg
        PaGlobalFunc_ServantSwiftTraining_All_SkillBgHighLight(skillbg, false)
      end
    end
    PaGlobal_ServantSwiftTraining_All._currentSkillBg = slotType
    PaGlobal_ServantSwiftTraining_All._trainingSlot[slotType]._materialIconSlot:setItemByStaticStatus(invenItemSSW, inputNumber)
    PaGlobal_ServantSwiftTraining_All._trainingSlot[slotType]._currentItemSlotNo = slotIdx
    PaGlobal_ServantSwiftTraining_All._trainingSlot[slotType]._currentItemCount = inputNumber
    local skillbg = PaGlobal_ServantSwiftTraining_All._trainingSlot[slotType]._skillBg
    PaGlobalFunc_ServantSwiftTraining_All_SkillBgHighLight(skillbg, true)
    PaGlobal_ServantSwiftTraining_All._trainingSlot[slotType]._currentItemWrapper = itemWrapper
    PaGlobal_ServantSwiftTraining_All._ui._btn_Train:SetIgnore(false)
    PaGlobal_ServantSwiftTraining_All._ui._btn_Train:SetMonoTone(false)
  end
end
function HandleEventLUp_ServantSwiftTraining_All_ItemClear(slotType)
  if nil == Panel_Dialog_ServantSwiftTraining_All or false == Panel_Dialog_ServantSwiftTraining_All:GetShow() then
    return
  end
  if nil ~= PaGlobal_ServantSwiftTraining_All._trainingSlot and nil ~= PaGlobal_ServantSwiftTraining_All._trainingSlot[slotType] then
    PaGlobal_ServantSwiftTraining_All._trainingSlot[slotType]._materialIconSlot:clearItem()
    PaGlobal_ServantSwiftTraining_All._trainingSlot[slotType]._currentItemSlotNo = -1
    PaGlobal_ServantSwiftTraining_All._trainingSlot[slotType]._currentItemCount = -1
    PaGlobal_ServantSwiftTraining_All._trainingSlot[slotType]._materialIconSlot.icon:EraseAllEffect()
    PaGlobal_ServantSwiftTraining_All._trainingSlot[slotType]._materialIconSlot.icon:addInputEvent("Mouse_On", "")
    PaGlobal_ServantSwiftTraining_All._trainingSlot[slotType]._materialIconSlot.icon:addInputEvent("Mouse_Out", "")
    PaGlobalFunc_ServantSwiftTraining_All_SkillBgHighLight(PaGlobal_ServantSwiftTraining_All._trainingSlot[slotType]._skillBg, false)
  end
  local materialCount = 0
  for i = 0, PaGlobal_ServantSwiftTraining_All._slotCount - 1 do
    if nil ~= PaGlobal_ServantSwiftTraining_All._trainingSlot and nil ~= PaGlobal_ServantSwiftTraining_All._trainingSlot[slotType] then
      local materialSlot = PaGlobal_ServantSwiftTraining_All._trainingSlot[slotType]
      if nil ~= materialSlot._currentItemSlotNo and -1 ~= materialSlot._currentItemSlotNo then
        materialCount = materialCount + 1
      end
    end
  end
  if materialCount <= 0 then
    PaGlobal_ServantSwiftTraining_All._ui._btn_Train:SetIgnore(true)
    PaGlobal_ServantSwiftTraining_All._ui._btn_Train:SetMonoTone(true)
  end
  Panel_Tooltip_Item_hideTooltip()
end
function HandleEventLUp_ServantSwiftTraining_All_Training()
  if nil == PaGlobal_ServantSwiftTraining_All._trainingSlot or nil == Panel_Dialog_ServantSwiftTraining_All or false == Panel_Dialog_ServantSwiftTraining_All:GetShow() then
    return
  end
  if Panel_NumberPad_IsPopUp() then
    return
  end
  if 0 ~= PaGlobal_ServantSwiftTraining_All._effectType and PaGlobal_ServantSwiftTraining_All._isButtonClick ~= PaGlobal_ServantSwiftTraining_All._enum_BtnType._NOTCLICK then
    return
  end
  local itemWhereType = CppEnums.ItemWhereType.eInventory
  local materialSlot = PaGlobal_ServantSwiftTraining_All._trainingSlot
  local materialCount = 0
  for i = 0, PaGlobal_ServantSwiftTraining_All._slotCount - 1 do
    if nil ~= materialSlot[i]._currentItemSlotNo and nil ~= materialSlot[i]._currentItemSlotNo and -1 ~= materialSlot[i]._currentItemSlotNo then
      local itemWrapper = getInventoryItemByType(itemWhereType, materialSlot[i]._currentItemSlotNo)
      if nil == itemWrapper then
        return
      end
      materialCount = materialCount + 1
    end
  end
  if materialCount <= 0 then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_STABLESTALLION_TEXT_ITEMREGISTER"))
    return
  end
  local isTrainingAble = false
  for index = 0, PaGlobal_ServantSwiftTraining_All._slotCount - 1 do
    local skillWrapper = stable_getStallionTrainingSkillListAt(index)
    local skillKey = skillWrapper:getKey()
    if nil ~= materialSlot[index]._currentItemSlotNo and -1 ~= materialSlot[index]._currentItemSlotNo then
      ToClient_increaseStallionSkillExpByItem(skillKey, PaGlobal_ServantSwiftTraining_All._currentServentNo, itemWhereType, materialSlot[index]._currentItemSlotNo, materialSlot[index]._currentItemCount)
      isTrainingAble = true
      if false == materialSlot[index]._isExpUp then
        materialSlot[index]._isExpUp = true
      end
    end
  end
  if true == isTrainingAble then
    Panel_Dialog_ServantList_All:RegisterUpdateFunc("PaGlobalFunc_ServantSwiftTraining_All_UpdatePerFrame_For_Effect")
  end
end
function HandleEventLUp_ServantSwiftTraining_All_TrySwift()
  if nil == Panel_Dialog_ServantSwiftTraining_All or false == Panel_Dialog_ServantSwiftTraining_All:GetShow() then
    return
  end
  if Panel_NumberPad_IsPopUp() then
    return
  end
  if 0 ~= PaGlobal_ServantSwiftTraining_All._effectType or nil == PaGlobal_ServantSwiftTraining_All._currentServentNo then
    return
  end
  if -1 < PaGlobal_ServantSwiftTraining_All._isButtonClick then
    return
  end
  local isAwaken = ToClient_isCompleteStallionTraining(PaGlobal_ServantSwiftTraining_All._currentServentNo)
  local needCount = toInt64(0, 1)
  local haveCount = toInt64(0, 0)
  PaGlobal_ServantSwiftTraining_All._crogdaloInfo._crogdaloSlotNo, haveCount = PaGlobal_ServantSwiftTraining_All:update_Cron_Crogdalo_Count(false)
  if needCount > haveCount then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_STABLESTALLION_TEXT_AWAKENITEM"))
    return
  end
  if false == isAwaken then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_STABLESTALLION_TEXT_AWAKENGAUGELACK"))
    return
  end
  function awaken_Training_Confirm()
    PaGlobal_ServantSwiftTraining_All._isButtonClick = PaGlobal_ServantSwiftTraining_All._enum_BtnType._SWIFT
    PaGlobal_ServantSwiftTraining_All._awakenDoing = true
    Panel_Dialog_ServantList_All:RegisterUpdateFunc("PaGlobalFunc_ServantSwiftTraining_All_UpdatePerFrame_For_Effect")
  end
  local _title = ""
  local _desc = PAGetString(Defines.StringSheet_GAME, "LUA_STABLESTALLION_TEXT_LOOKCHANGEWARNING")
  local _confirmFunction = awaken_Training_Confirm
  local _cancel = MessageBox_Empty_function
  local _priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  messageboxData = {
    title = _title,
    content = _desc,
    functionYes = _confirmFunction,
    functionCancel = _cancel,
    priority = _priority,
    exitButton = true
  }
  MessageBox.showMessageBox(messageboxData)
end
function FromClient_ServantSwiftTraining_All_IncreaseStallionSkillExpAck(servantNo, skillKey, skillExp)
  if nil == Panel_Dialog_ServantSwiftTraining_All or false == Panel_Dialog_ServantSwiftTraining_All:GetShow() then
    return
  end
  PaGlobal_ServantSwiftTraining_All._isButtonClick = PaGlobal_ServantSwiftTraining_All._enum_BtnType._TRAINING
  for i = 0, PaGlobal_ServantSwiftTraining_All._slotCount - 1 do
    HandleEventLUp_ServantSwiftTraining_All_ItemClear(i)
  end
end
function PaGlobalFunc_ServantSwiftTraining_All_SkillBgHighLight(control, isShow)
  if nil == control or nil == Panel_Dialog_ServantSwiftTraining_All or false == Panel_Dialog_ServantSwiftTraining_All:GetShow() then
    return
  end
  if true == isShow then
    control:ChangeTextureInfoName("combine/etc/combine_etc_stable_01.dds")
    local x1, y1, x2, y2 = setTextureUV_Func(control, 1, 389, 111, 597)
    control:getBaseTexture():setUV(x1, y1, x2, y2)
    control:setRenderTexture(control:getBaseTexture())
  else
    control:ChangeTextureInfoName("combine/etc/combine_etc_stable_01.dds")
    local x1, y1, x2, y2 = setTextureUV_Func(control, 0, 0, 0, 0)
    control:getBaseTexture():setUV(x1, y1, x2, y2)
    control:setRenderTexture(control:getBaseTexture())
  end
end
function FromClient_ServantSwiftTraining_All_CompleteStallionTrainingAck(servantNo, servantCharacterKey)
  if nil == Panel_Dialog_ServantSwiftTraining_All then
    return
  end
  local servantKey = servantCharacterKey
  if 0 == servantKey then
    PaGlobalFunc_ServantSwiftResult_All_AwakenEffect(false)
    audioPostEvent_SystemUi(13, 22)
    _AudioPostEvent_SystemUiForXBOX(13, 22)
  else
    PaGlobalFunc_ServantSwiftResult_All_AwakenEffect(true, servantKey)
    audioPostEvent_SystemUi(13, 21)
    _AudioPostEvent_SystemUiForXBOX(13, 21)
  end
  PaGlobal_ServantSwiftTraining_All:update()
end
function PaGlobalFunc_ServantSwiftTraining_All_UpdatePerFrame_For_Effect(updateTime)
  if nil == Panel_Dialog_ServantSwiftTraining_All or nil == Panel_Dialog_ServantSwiftResult_All then
    return
  end
  if PaGlobal_ServantSwiftTraining_All._enum_BtnType._NOTCLICK == PaGlobal_ServantSwiftTraining_All._isButtonClick then
    return
  end
  PaGlobal_ServantSwiftTraining_All._elapsedTime = PaGlobal_ServantSwiftTraining_All._elapsedTime + updateTime
  local currentIdx = PaGlobal_ServantSwiftTraining_All._currentSkillBg
  if PaGlobal_ServantSwiftTraining_All._enum_BtnType._TRAINING == PaGlobal_ServantSwiftTraining_All._isButtonClick then
    PaGlobal_ServantSwiftTraining_All._frame = PaGlobal_ServantSwiftTraining_All._frame + updateTime
    if PaGlobal_ServantSwiftTraining_All._elapsedTime < 2.5 then
      if 0 == PaGlobal_ServantSwiftTraining_All._effectType then
        PaGlobalFunc_ServantSwiftResult_All_AddEffect(PaGlobal_ServantSwiftTraining_All._trainingSlot[currentIdx]._materialIconSlot.icon, 0, 0, 0)
        local effectIndex = 0
        if 0 == currentIdx then
          effectIndex = 9
        elseif 1 == currentIdx then
          effectIndex = 10
        elseif 2 == currentIdx then
          effectIndex = 11
        end
        if 0 ~= effectIndex then
          PaGlobalFunc_ServantSwiftResult_All_AddEffect(PaGlobal_ServantSwiftTraining_All._trainingSlot[currentIdx]._skillPercent, effectIndex, 0, -18)
        end
        PaGlobalFunc_ServantSwiftResult_All_AddEffect(PaGlobal_ServantSwiftTraining_All._trainingSlot[currentIdx]._skillPercent, 3, 0, -18)
        audioPostEvent_SystemUi(13, 19)
        _AudioPostEvent_SystemUiForXBOX(13, 19)
        PaGlobal_ServantSwiftTraining_All._effectType = 1
      end
      PaGlobalFunc_ServantSwiftTraining_All_UpdateCount(false)
      PaGlobal_ServantSwiftTraining_All:update()
    elseif PaGlobal_ServantSwiftTraining_All._elapsedTime < 3 then
      if 1 == PaGlobal_ServantSwiftTraining_All._effectType then
        PaGlobalFunc_ServantSwiftResult_All_AddEffect(PaGlobal_ServantSwiftTraining_All._ui._txt_TotalPercent, 4, -3, -30)
        PaGlobalFunc_ServantSwiftResult_All_AddEffect(PaGlobal_ServantSwiftTraining_All._ui._txt_TotalPercent, 3, -3, -30)
        PaGlobal_ServantSwiftTraining_All._effectType = 2
      end
    elseif PaGlobal_ServantSwiftTraining_All._elapsedTime > 4.2 and PaGlobal_ServantSwiftTraining_All._elapsedTime < 4.5 then
      if 2 == PaGlobal_ServantSwiftTraining_All._effectType then
        PaGlobalFunc_ServantSwiftResult_All_AddEffect(PaGlobal_ServantSwiftTraining_All._ui._txt_TotalPercent, 5, 0, -30)
        PaGlobal_ServantSwiftTraining_All:update()
        HandleEventLUp_ServantSwiftTraining_All_ItemClear(currentIdx)
        PaGlobal_ServantSwiftTraining_All._effectType = 3
      end
    elseif PaGlobal_ServantSwiftTraining_All._elapsedTime > 5.5 then
      PaGlobalFunc_ServantSwiftResult_All_EffectErase()
      PaGlobal_ServantSwiftTraining_All._elapsedTime = 0
      PaGlobal_ServantSwiftTraining_All._isButtonClick = PaGlobal_ServantSwiftTraining_All._enum_BtnType._NOTCLICK
      PaGlobal_ServantSwiftTraining_All._effectType = 0
      PaGlobal_ServantSwiftTraining_All:update()
      Panel_Dialog_ServantList_All:ClearUpdateLuaFunc()
    end
  elseif 1 == PaGlobal_ServantSwiftTraining_All._isButtonClick then
    if false == Panel_Dialog_ServantSwiftResult_All:GetShow() then
      PaGlobalFunc_ServantSwiftResult_All_OnlyPanelShow(true)
    end
    PaGlobalFunc_ServantSwiftTraining_All_UpdateCount(true)
    if PaGlobal_ServantSwiftTraining_All._elapsedTime < 2 then
      if 0 == PaGlobal_ServantSwiftTraining_All._effectType then
        audioPostEvent_SystemUi(13, 20)
        _AudioPostEvent_SystemUiForXBOX(13, 20)
        for i = 0, PaGlobal_ServantSwiftTraining_All._slotCount - 1 do
          if nil ~= PaGlobal_ServantSwiftTraining_All._trainingSlot and true == PaGlobal_ServantSwiftTraining_All._trainingSlot[i]._isExpUp then
            PaGlobalFunc_ServantSwiftResult_All_AddEffect(PaGlobal_ServantSwiftTraining_All._trainingSlot[i]._skillPercent, i + 9, 0, -18)
          end
        end
        PaGlobalFunc_ServantSwiftTraining_All_SkillBgHighLight(PaGlobal_ServantSwiftTraining_All._trainingSlot[currentIdx]._skillBg, false)
        PaGlobal_ServantSwiftTraining_All._effectType = 1
        PaGlobal_ServantSwiftTraining_All._ui._btn_Check_Cron:SetIgnore(true)
      end
    elseif PaGlobal_ServantSwiftTraining_All._elapsedTime < 2.5 then
      if 1 == PaGlobal_ServantSwiftTraining_All._effectType then
        PaGlobalFunc_ServantSwiftResult_All_AddEffect(PaGlobal_ServantSwiftTraining_All._ui._txt_TotalPercent, 4, -3, -30)
        PaGlobal_ServantSwiftTraining_All._effectType = 2
        PaGlobalFunc_ServantSwiftResult_All_DoAwakenEffect()
      end
    elseif PaGlobal_ServantSwiftTraining_All._elapsedTime > 3.7 and PaGlobal_ServantSwiftTraining_All._elapsedTime < 6.5 then
      if true == Panel_Dialog_ServantSwiftTraining_All:GetShow() then
        Panel_Dialog_ServantSwiftTraining_All:SetShow(false)
        for index = 0, PaGlobal_ServantSwiftTraining_All._slotCount - 1 do
          HandleEventLUp_ServantSwiftTraining_All_ItemClear(i)
        end
      end
      if 2 == PaGlobal_ServantSwiftTraining_All._effectType then
        PaGlobal_ServantSwiftTraining_All._frame = PaGlobal_ServantSwiftTraining_All._frame + updateTime
        if PaGlobal_ServantSwiftTraining_All._frame > 0.2 then
          PaGlobal_ServantSwiftTraining_All._frame = 0
          PaGlobalFunc_ServantSwiftResult_All_AwakenEffect(0)
          PaGlobal_ServantSwiftTraining_All._effectType = 3
        end
      end
    elseif PaGlobal_ServantSwiftTraining_All._elapsedTime > 8 and true == PaGlobal_ServantSwiftTraining_All._awakenDoing then
      PaGlobal_ServantSwiftTraining_All:Awaken_Training_isNineTier()
      PaGlobal_ServantSwiftTraining_All._awakenDoing = false
    elseif PaGlobal_ServantSwiftTraining_All._elapsedTime > 11.5 and PaGlobal_ServantSwiftTraining_All._elapsedTime < 12 then
      if 3 == PaGlobal_ServantSwiftTraining_All._effectType then
        PaGlobal_ServantSwiftTraining_All:update()
        PaGlobalFunc_ServantList_All_CharacterSceneResetServantNo(PaGlobal_ServantSwiftTraining_All._currentServentNo)
        PaGlobal_ServantSwiftTraining_All._effectType = 4
      end
    elseif PaGlobal_ServantSwiftTraining_All._elapsedTime > 12 then
      PaGlobalFunc_ServantSwiftResult_All_EffectErase()
      PaGlobalFunc_ServantSwiftResult_All_EffectClose()
      PaGlobal_ServantSwiftTraining_All:update()
      PaGlobal_ServantSwiftTraining_All._effectType = 0
      PaGlobal_ServantSwiftTraining_All._elapsedTime = 0
      PaGlobal_ServantSwiftTraining_All._isButtonClick = -1
      PaGlobalFunc_ServantFunction_All_TempOnOff(true)
      PaGlobal_ServantSwiftTraining_All._ui._btn_Check_Cron:SetIgnore(false)
      PaGlobal_ServantSwiftTraining_All._ui._btn_Check_Cron:SetCheck(false)
      Panel_Dialog_ServantList_All:ClearUpdateLuaFunc()
      PaGlobal_ServantSwiftTraining_All:prepareClose()
    end
  end
end
function PaGlobalFunc_ServantSwiftTraining_All_UpdateCount(isAwakenBtn)
  local progressSpeed = 2
  if true == isAwakenBtn then
    for i = 0, PaGlobal_ServantSwiftTraining_All._slotCount - 1 do
      if nil ~= PaGlobal_ServantSwiftTraining_All._trainingSlot and PaGlobal_ServantSwiftTraining_All._trainingSlot[i] then
        local trainingSlot = PaGlobal_ServantSwiftTraining_All._trainingSlot[i]
        if 1 < trainingSlot._skillExpCount then
          trainingSlot._skillExpCount = trainingSlot._skillExpCount - 1 * progressSpeed
          local floorValueString = PaGlobal_ServantSwiftTraining_All:getfloorValueString(trainingSlot._skillExpCount)
          trainingSlot._skillPercent:SetText(floorValueString .. "%")
          trainingSlot._skillProg2:SetProgressRate(trainingSlot._skillExpCount / 1.8)
        else
          trainingSlot._skillExpCount = 0
          trainingSlot._skillPercent:SetText(0 .. "%")
          trainingSlot._skillProg2:SetProgressRate(0)
        end
      end
    end
    if 0 <= PaGlobal_ServantSwiftTraining_All._awakenExpCount - 1 then
      PaGlobal_ServantSwiftTraining_All._awakenExpCount = PaGlobal_ServantSwiftTraining_All._awakenExpCount - 1
      local floorValueString = PaGlobal_ServantSwiftTraining_All:getfloorValueString(PaGlobal_ServantSwiftTraining_All._awakenExpCount * 2)
      PaGlobal_ServantSwiftTraining_All._ui._txt_TotalPercent:SetText(floorValueString .. "%")
    end
  else
    for i = 0, PaGlobal_ServantSwiftTraining_All._slotCount - 1 do
      if nil ~= PaGlobal_ServantSwiftTraining_All._trainingSlot and PaGlobal_ServantSwiftTraining_All._trainingSlot[i] then
        local trainingSlot = PaGlobal_ServantSwiftTraining_All._trainingSlot[i]
        if trainingSlot._skillExpCount >= 180 then
          trainingSlot._skillExpCount = 180
          progressSpeed = 3
          if 0 < trainingSlot._skillExpCount then
            if 2 >= trainingSlot._currentItemCount then
              progressSpeed = 1
            end
            trainingSlot._currentItemCount = trainingSlot._currentItemCount - 1 * progressSpeed
          end
        elseif 0 < trainingSlot._currentItemCount then
          if 1 == trainingSlot._currentItemCount then
            progressSpeed = 1
          end
          if trainingSlot._skillExpCount >= 100 then
            trainingSlot._skillExpCount = trainingSlot._skillExpCount + 0.5 * progressSpeed
            PaGlobal_ServantSwiftTraining_All._awakenExpCount = PaGlobal_ServantSwiftTraining_All._awakenExpCount + 0.25 * progressSpeed
          else
            trainingSlot._skillExpCount = trainingSlot._skillExpCount + 1 * progressSpeed
            PaGlobal_ServantSwiftTraining_All._awakenExpCount = PaGlobal_ServantSwiftTraining_All._awakenExpCount + 0.5 * progressSpeed
          end
          if PaGlobal_ServantSwiftTraining_All._awakenExpCount > 100 then
            PaGlobal_ServantSwiftTraining_All._awakenExpCount = 100
          end
          trainingSlot._currentItemCount = trainingSlot._currentItemCount - 1 * progressSpeed
          local floorValueString = PaGlobal_ServantSwiftTraining_All:getfloorValueString(PaGlobal_ServantSwiftTraining_All._awakenExpCount * 2)
          PaGlobal_ServantSwiftTraining_All._ui._txt_TotalPercent:SetText(floorValueString .. "%")
          floorValueString = PaGlobal_ServantSwiftTraining_All:getfloorValueString(trainingSlot._skillExpCount)
          trainingSlot._skillPercent:SetText(floorValueString .. "%")
          trainingSlot._skillProg2:SetProgressRate(trainingSlot._skillExpCount / 1.8)
          trainingSlot._materialIconSlot:setItemByStaticStatus(trainingSlot._currentItemWrapper, trainingSlot._currentItemCount)
        end
      end
    end
  end
end
