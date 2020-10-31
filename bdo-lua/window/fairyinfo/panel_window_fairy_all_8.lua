function InputMLUp_FairyRegister_RegisterName_All(str)
  if nil == Panel_Window_FairyRegister_All then
    return
  end
  PaGlobal_FairyRegister_All:registerName(str)
end
function InputMLUp_FairyRegister_SetFocus_All()
  if nil == Panel_Window_FairyRegister_All then
    return
  end
  PaGlobal_FairyRegister_All:setFocus()
end
function PaGlobal_FairyRegister_RegisterYes_All()
  if nil == Panel_Window_FairyRegister_All then
    return
  end
  PaGlobal_FairyRegister_All:registerNameConfirm()
end
function FromClient_InputFairyName_All(fromWhereType, fromSlotNo)
  if nil == Panel_Window_FairyRegister_All then
    return
  end
  PaGlobal_FairyRegister_All:prepareOpen(fromWhereType, fromSlotNo)
end
function PaGlobal_FairyRegister_Close_All()
  if nil == Panel_Window_FairyRegister_All then
    return
  end
  PaGlobal_FairyRegister_All:prepareClose()
end
function InputMLClick_FairyInfo_SummonFairy_All()
  if nil == Panel_FairyInfo_All then
    return
  end
  PaGlobal_FairyInfo_All:summonFairy()
end
function PaGlobal_FairyInfo_RequestRebirth_All()
  if nil == Panel_FairyInfo_All then
    return
  end
  PaGlobal_FairyInfo_All:requestRebirth()
end
function PaGlobal_FairyInfo_RequestFreedom_All()
  if nil == Panel_FairyInfo_All then
    return
  end
  PaGlobal_FairyInfo_All:requestFreedom()
end
function PaGlobal_FairyInfo_ShowToolTip_All(isHp, isShow)
  if nil == Panel_FairyInfo_All then
    return
  end
  PaGlobal_FairyInfo_All:ShowToolTip(isHp, isShow)
end
function PaGlobal_FairyInfo_SimpleTooltip_All(isShow, tipType)
  if nil == Panel_FairyInfo_All then
    return
  end
  PaGlobal_FairyInfo_All:SimpleTooltip(isShow, tipType)
end
function PaGlobal_FairyInfo_LanterOnOff_All()
  if nil == Panel_FairyInfo_All then
    return
  end
  ToClient_RequestFairyLanterOnOff()
  PaGlobal_FairyInfo_Open_All(true)
end
function FairyInfo_SkillTooltip_All(isShow, index)
  if nil == Panel_FairyInfo_All then
    return
  end
  PaGlobal_FairyInfo_All:SkillTooltip(isShow, index)
end
function FromClient_FairyInfo_InputFairyNameStart_All(fromWhereType, fromSlotNo)
  if nil == Panel_FairyInfo_All then
    return
  end
  PaGlobal_FairyInfo_All:InputFairyNameStart(fromWhereType, fromSlotNo)
end
function UpdateFunc_FairyRegisterAni(deltaTime)
  if nil == Panel_FairyInfo_All then
    return
  end
  PaGlobal_FairyInfo_All:FairyRegisterAni(deltaTime)
end
function FromClient_FairyInfo_addSealedList_Open_All(petNo, reason, petType)
  if nil == Panel_FairyInfo_All then
    return
  end
  PaGlobal_FairyInfo_All:openFromAddSealedList(petNo, reason, petType)
end
function FromClient_Fairy_Update_All()
  PaGlobal_FairyInfo_All:Clear()
  PaGlobal_FairyInfo_All:update()
end
function FromClient_FairyInfo_delSealedList_Open_All(petNo)
  if nil == Panel_FairyInfo_All then
    return
  end
  PaGlobal_FairyInfo_All:openFromDelSealedList(petNo)
end
function FromClient_FiaryInfo_delList_Open_All(petNo)
  if nil == Panel_FairyInfo_All then
    return
  end
  PaGlobal_FairyInfo_All:openFromDelList(petNo)
end
function PaGloblFunc_FairyInfo_GetFairySkillCount_All()
  if nil == Panel_FairyInfo_All then
    return
  end
  return PaGlobal_FairyInfo_All.eFairyMaxEquipSkill
end
function PaGlobalFunc_FairyInfo_UpdateFairyLook_ALL()
  if nil == Panel_FairyInfo_All then
    return
  end
  PaGlobal_FairyInfo_All:updateFairyLook()
end
function PaGlobal_FairyInfo_GetFairyKey_All()
  if nil == Panel_FairyInfo_All then
    return
  end
  return PaGlobal_FairyInfo_All._fairykey
end
function PaGlobal_FairyInfo_GetFairyNo_All()
  if nil == Panel_FairyInfo_All then
    return
  end
  return PaGlobal_FairyInfo_All._fairyNo
end
function PaGlobal_FairyInfo_GetFairyName_All()
  if nil == Panel_FairyInfo_All then
    return
  end
  return PaGlobal_FairyInfo_All._fairyName
end
function PaGlobal_FairyInfo_GetIconPath_All()
  if nil == Panel_FairyInfo_All then
    return
  end
  return PaGlobal_FairyInfo_All._iconPath
end
function PaGlobal_FairyInfo_GetLevel_All()
  if nil == Panel_FairyInfo_All then
    return
  end
  return PaGlobal_FairyInfo_All._fairyLevel
end
function PaGlobal_FairyInfo_isUnseal_All()
  if nil == Panel_FairyInfo_All then
    return
  end
  return PaGlobal_FairyInfo_All._isUnseal
end
function PaGlobal_FairyInfo_getUpgradeStack_All()
  if nil == Panel_FairyInfo_All then
    return
  end
  return PaGlobal_FairyInfo_All._fairyUpgradeStack
end
function PaGlobal_FairyInfo_isMaxTier_All()
  if nil == Panel_FairyInfo_All then
    return
  end
  if PaGlobal_FairyInfo_All._fairyTierMax <= PaGlobal_FairyInfo_All._fairyTier then
    return true
  else
    return false
  end
end
function PaGlobal_FairyInfo_FairyTier_All()
  if nil == Panel_FairyInfo_All then
    return
  end
  return PaGlobal_FairyInfo_All._fairyTier
end
function PaGlobal_FairyInfo_CurrentExpRate_All()
  if nil == Panel_FairyInfo_All then
    return
  end
  return PaGlobal_FairyInfo_All._currentExpRate
end
function PaGlobal_FairyInfo_isMaxLevel_All()
  if nil == Panel_FairyInfo_All then
    return
  end
  return PaGlobal_FairyInfo_All._isFairyMaxLevel
end
function PaGlobal_FairyInfo_Update_All()
  if nil == Panel_FairyInfo_All then
    return
  end
  PaGlobal_FairyInfo_All:update()
end
function PaGlobal_FairyInfo_Open_All(noSetPos)
  if nil == Panel_FairyInfo_All then
    return
  end
  PaGlobal_FairyInfo_All:prepareOpen(noSetPos)
end
function PaGlobal_FairyInfo_Close_All()
  if nil == Panel_FairyInfo_All then
    return
  end
  PaGlobal_FairyInfo_All:prepareClose()
end
function PaGlobal_FairyInfo_IsGetShow()
  if nil == Panel_FairyInfo_All then
    return
  end
  return Panel_FairyInfo_All:GetShow()
end
function PaGlobal_FairyInfo_EnableFairyUpgrade_All()
  if nil == Panel_FairyInfo_All then
    return
  end
  return PaGlobal_FairyInfo_All._enableFairyUpgrade
end
function InputMLUp_FairyGorwth_SelectFeedingItem(index, isHoney)
  if nil == Panel_Window_FairyGrowth_All then
    return
  end
  PaGlobal_FairyGrowth_All:selectFeedingItem(index, isHoney)
end
function InputMLUp_FairyGrowth_RequestGrowth()
  if nil == Panel_Window_FairyGrowth_All then
    return
  end
  PaGlobal_FairyGrowth_All:requestGrowth()
end
function InputMOn_FairyGrowth_ShowItemTooltip(index, isHoney, isShow)
  if nil == Panel_Window_FairyGrowth_All then
    return
  end
  PaGlobal_FairyGrowth_All:showItemTooltip(index, isHoney, isShow)
end
function InputLTX_FairyGrowth_SetCheckContinuous()
  if nil == Panel_Window_FairyGrowth_All then
    return
  end
  PaGlobal_FairyGrowth_All._ui.chk_Continuous:SetCheck(not PaGlobal_FairyGrowth_All._ui.chk_Continuous:IsCheck())
end
function FromClient_FairyGrowth_PetInfoChanged_All(petNo)
  if nil == Panel_Window_FairyGrowth_All then
    return
  end
  PaGlobal_FairyGrowth_All:petInfoChanged(petNo)
end
function PaGlobal_FairyGrowth_Open_All(PositionReset)
  if nil == Panel_Window_FairyGrowth_All then
    return
  end
  PaGlobal_FairyGrowth_All:prepareOpen(PositionReset)
end
function PaGlobal_FairyGrowth_Close_All(PositionReset)
  if nil == Panel_Window_FairyGrowth_All then
    return
  end
  PaGlobal_FairyGrowth_All:prepareClose()
end
function PaGlobal_FairyGrowth_All_CreateFeedList(control, key)
  if nil == Panel_Window_FairyGrowth_All then
    return
  end
  PaGlobal_FairyGrowth_All:createFeedList(control, key)
end
function PaGlobal_FairyGrowth_All_SetFeedItem(count, slotNo, itemKey)
  if nil == Panel_Window_FairyGrowth_All then
    return
  end
  PaGlobal_FairyGrowth_All:setFeedItem(count, slotNo, itemKey)
end
function PaGlobal_FairyGrowth_All_FairyGrowthAni(deltaTime)
  if nil == Panel_Window_FairyGrowth_All then
    return
  end
  PaGlobal_FairyGrowth_All:updateAni(deltaTime)
end
function PaGlobal_FairyGrowth_OnlyUpdate_All()
  if nil == Panel_Window_FairyGrowth_All then
    return
  end
  PaGlobal_FairyGrowth_All:onlyUpdate()
end
function PaGlobal_FairyGrowth_ClearFeedItem_All()
  if nil == Panel_Window_FairyGrowth_All then
    return
  end
  PaGlobal_FairyGrowth_All:clearFeedItem()
end
function InputMLUp_FairySetting_ClearHP_All()
  if nil == Panel_Window_FairySetting_All then
    return
  end
  PaGlobal_FairySetting_All:clearHP()
end
function InputMLUp_FairySetting_ClearMP_All()
  if nil == Panel_Window_FairySetting_All then
    return
  end
  PaGlobal_FairySetting_All:clearMP()
end
function InputMLUp_FairySetting_Request_All()
  if nil == Panel_Window_FairySetting_All then
    return
  end
  PaGlobal_FairySetting_All:Request()
end
function InputMLUp_FairySetting_SetPotion_All(key)
  if nil == Panel_Window_FairySetting_All then
    return
  end
  PaGlobal_FairySetting_All:SetPotion(key)
end
function InputMOn_FairySetting_ShowToolTip(index, isShow)
  if nil == Panel_Window_FairySetting_All then
    return
  end
  PaGlobal_FairySetting_All:ShowToolTip(index, isShow)
end
function InputMOn_FairySetting_ShowLimitTextToolTip(index, isShow)
  if nil == Panel_Window_FairySetting_All then
    return
  end
  PaGlobal_FairySetting_All:showLimitTextToolTip(index, isShow)
end
function InputMLPress_FairySetting_UpdateHpSlider()
  if nil == Panel_Window_FairySetting_All then
    return
  end
  PaGlobal_FairySetting_All:UpdateHpSlider()
end
function InputMLPress_FairySetting_UpdateMpSlider()
  if nil == Panel_Window_FairySetting_All then
    return
  end
  PaGlobal_FairySetting_All:UpdateMpSlider()
end
function InputXUp_FairySetting_ShowPotionToopTip(key, isShow)
  if nil == Panel_Window_FairySetting_All then
    return
  end
  PaGlobal_FairySetting_All:ShowPotionTooltip(key, isShow)
end
function InputDpadLeft_FairySetting_MoveSnapToLeft_All()
  if nil == Panel_Window_FairySetting_All then
    return
  end
  PaGlobal_FairySetting_All:moveSnapToLeft()
end
function InputDpadLeft_FairySetting_MoveSnapToRight_All()
  if nil == Panel_Window_FairySetting_All then
    return
  end
  PaGlobal_FairySetting_All:moveSnapToRight()
end
function PaGlobal_FairySetting_Open_All(petNoStr)
  if nil == Panel_Window_FairySetting_All then
    return
  end
  PaGlobal_FairySetting_All:prepareOpen(petNoStr)
end
function PaGlobal_FairySetting_Close_All()
  if nil == Panel_Window_FairySetting_All then
    return
  end
  PaGlobal_FairySetting_All:prepareClose()
end
function PaGlobal_FairyList_IsMp_All(mpKeyStr)
  if nil == Panel_Window_FairySetting_All then
    return
  end
  return PaGlobal_FairySetting_All:isMP(mpKeyStr)
end
function PaGlobal_FairyList_IsHp_All(hpKeyStr)
  if nil == Panel_Window_FairySetting_All then
    return
  end
  return PaGlobal_FairySetting_All:isHP(hpKeyStr)
end
function PaGlobal_FairySetting_All_CreatePotionList(control, key)
  if nil == Panel_Window_FairySetting_All then
    return
  end
  PaGlobal_FairySetting_All:createPotionList(control, key)
end
function InputMOn_FairySkill_ShowTooltip(isShow, skillkey)
  if nil == Panel_Window_FairySkill_All then
    return
  end
  PaGlobal_FairySkill_All:ShowTooltip(isShow, skillkey)
end
function FromClient_FairySkill_Update()
  if nil == Panel_Window_FairySkill_All and false == Panel_Window_FairySkill_All:GetShow() then
    return
  end
  PaGlobal_FairySkill_All:update()
end
function PaGlobalFunc_FairySkill_Open_All(isAllSkillShow)
  if nil == Panel_Window_FairySkill_All then
    return
  end
  PaGlobal_FairySkill_All:prepareOpen(isAllSkillShow)
end
function PaGlobalFunc_FairySkill_Close_All()
  if nil == Panel_Window_FairySkill_All then
    return
  end
  PaGlobal_FairySkill_All:prepareClose()
end
function PaGlobalFunc_FairySkill_GetShow()
  if nil == Panel_Window_FairySkill_All then
    return
  end
  return Panel_Window_FairySkill_All:GetShow()
end
function InputMOn_FairyChoiceTheReset_ShowTooltip_All(isShow, idx)
  if nil == Panel_Window_FairyChoiceTheReset_All then
    return
  end
  PaGlobal_FairyChoiceTheReset_All:SimpleTooltip(isShow, idx)
end
function InputMLClick_FairyChoiceTheReset_RequestRebirth()
  if nil == Panel_Window_FairyChoiceTheReset_All then
    return
  end
  PaGlobal_FairyChoiceTheReset_All:RequestRebirth()
end
function PaGlobal_FairyChoiceTheReset_Open_All()
  if nil == Panel_Window_FairyChoiceTheReset_All then
    return
  end
  PaGlobal_FairyChoiceTheReset_All:prepareOpen()
end
function PaGlobal_FairyChoiceTheReset_Close_All()
  if nil == Panel_Window_FairyChoiceTheReset_All then
    return
  end
  PaGlobal_FairyChoiceTheReset_All:prepareClose()
end
function PaGlobal_FairyTierUpgrade_UpdateIcon_All()
  if nil == Panel_Window_FairyTierUpgrade_All then
    return
  end
  PaGlobal_FairyTierUpgrade_All:updateIcon()
end
function InputMLClick_FairyTierUpgrade_TierUpgrade_All()
  if nil == Panel_Window_FairyTierUpgrade_All then
    return
  end
  PaGlobal_FairyTierUpgrade_All:TierUpgrade()
end
function InputMLClick_FairyTierUpgrade_SelectHoney_All(index)
  if nil == Panel_Window_FairyTierUpgrade_All then
    return
  end
  PaGlobal_FairyTierUpgrade_All:selectHoney(index)
end
function InputMLPress_FairyTierUpgrade_SliderUpdate_All()
  if nil == Panel_Window_FairyTierUpgrade_All then
    return
  end
  PaGlobal_FairyTierUpgrade_All:updateSlider()
end
function InputMOn_FairyTierUpgrade_ShowItemToolTip_All(index, isShow)
  if nil == Panel_Window_FairyTierUpgrade_All then
    return
  end
  PaGlobal_FairyTierUpgrade_All:showItemToolTip(index, isShow)
end
function InputMOn_FairyTierUpgrade_ShowToolTip_All(isShow)
  if nil == Panel_Window_FairyTierUpgrade_All then
    return
  end
  PaGlobal_FairyTierUpgrade_All:showToolTip(isShow)
end
function FromClient_FairyTierUpgrade_UpdatePerFrame(deltaTime)
  local self = PaGlobal_FairyTierUpgrade_All
  for i = 1, self._rimCount do
    if self._RIM_ANI_STATE.IDLE == self._rim[i]._state then
      self:idleAnimation(self._rim[i], i, deltaTime)
    elseif self._RIM_ANI_STATE.ROTATING == self._rim[i]._state then
      self:rotating(self._rim[i], deltaTime)
    elseif self._RIM_ANI_STATE.INDICATING == self._rim[i]._state then
      self:indicating(self._rim[i], deltaTime)
    elseif self._RIM_ANI_STATE.WAITING_FOR_RESULT == self._rim[i]._state then
      self:waitingForResult(self._rim[i], deltaTime)
    end
  end
  if self._isResultAnimating then
    self:resultAniUpdate(deltaTime)
  end
end
function FromClient_FairyTierUpgrade_TierUpSuccess()
  if nil == Panel_Window_FairyTierUpgrade_All then
    return
  end
  PaGlobal_FairyTierUpgrade_All._result = PaGlobal_FairyTierUpgrade_All._RESULT_TYPE.SUCCESS
end
function FromClient_FairyTierUpgrade_TierUpFailed()
  if nil == Panel_Window_FairyTierUpgrade_All then
    return
  end
  PaGlobal_FairyTierUpgrade_All._result = PaGlobal_FairyTierUpgrade_All._RESULT_TYPE.FAIL
end
function PaGlobal_FairyTierUpgrade_Open_All(PositionReset)
  if nil == Panel_Window_FairyTierUpgrade_All then
    return
  end
  PaGlobal_FairyTierUpgrade_All:prepareOpen(PositionReset)
end
function PaGlobal_FairyTierUpgrade_Close_All()
  if nil == Panel_Window_FairyTierUpgrade_All then
    return
  end
  PaGlobal_FairyTierUpgrade_All:prepareClose()
end
function PaGlobal_FairyTierUpgrade_ClearFeedItem_All()
  if nil == Panel_Window_FairyTierUpgrade_All then
    return
  end
  PaGlobal_FairyTierUpgrade_All:clearFeedItem()
end
function PaGlobal_FairyTierUpgrade_TierUpgradeConfirm_All()
  if nil == Panel_Window_FairyTierUpgrade_All then
    return
  end
  PaGlobal_FairyTierUpgrade_All:TierUpgradeConfirm()
end
function InputMLUp_FairyChangeSkill_SelectSkill(key)
  PaGlobal_FairyChangeSkill_All:selectSkill(key)
end
function InputMLUp_FairyChangeSkill_Confirm()
  PaGlobal_FairyChangeSkill_All:confirmMessageBox()
end
function PaGlobal_FairyChangeSkill_Open_All()
  if nil == Panel_Window_FairyChangeSkill_All then
    return
  end
  PaGlobal_FairyChangeSkill_All:prepareOpen()
end
function PaGlobal_FairyChangeSkill_Close_All(isAttack)
  if nil == Panel_Window_FairyChangeSkill_All then
    return
  end
  PaGlobal_FairyChangeSkill_All:prepareClose(isAttack)
end
function PaGlobal_FairyChangeSkill_FairySetting()
  if nil == Panel_Window_FairyChangeSkill_All then
    return
  end
  PaGlobal_FairyChangeSkill_All:fairySetting()
end
function PaGlobal_FairyChangeSkill_FairySkillUpdate(skillKeyList)
  if nil == Panel_Window_FairyChangeSkill_All then
    return
  end
  PaGlobal_FairyChangeSkill_All:update(skillKeyList)
end
function PaGlobal_FairyChangeSkill_FairySkillSettingReset()
  if nil == Panel_Window_FairyChangeSkill_All then
    return
  end
  PaGlobal_FairyChangeSkill_All:settingReset()
end
function PaGlobal_FairyChangeSkill_ChangeBtnSetting()
  if nil == Panel_Window_FairyChangeSkill_All then
    return
  end
  PaGlobal_FairyChangeSkill_All:changeBtnSetting()
end
function PaGlobal_FairyChangeSkill_CurrentItemCountSetting()
  if nil == Panel_Window_FairyChangeSkill_All or false == Panel_Window_FairyChangeSkill_All:GetShow() then
    return
  end
  PaGlobal_FairyChangeSkill_All:currentItemCountSetting()
end
function FromClient_FairyChangeSkill_UpdatePerFrame(deltaTime)
  if nil == Panel_Window_FairyChangeSkill_All then
    return
  end
  if PaGlobal_FairyChangeSkill_All._ANI_STATE.STOP == PaGlobal_FairyChangeSkill_All._changeAniState then
    return
  end
  if PaGlobal_FairyChangeSkill_All._ANI_STATE.START == PaGlobal_FairyChangeSkill_All._changeAniState then
    PaGlobal_FairyChangeSkill_All:confirmPlayAni(deltaTime)
    return
  end
  if PaGlobal_FairyChangeSkill_All._ANI_STATE.PLAY == PaGlobal_FairyChangeSkill_All._changeAniState then
    PaGlobal_FairyChangeSkill_All._aniStartTime = PaGlobal_FairyChangeSkill_All._aniStartTime + deltaTime
    if PaGlobal_FairyChangeSkill_All._aniEndTime <= PaGlobal_FairyChangeSkill_All._aniStartTime then
      PaGlobal_FairyChangeSkill_All:confirmEndAni()
      PaGlobal_FairyChangeSkill_All:contirm()
    end
  end
end
function FromClient_FairyNewSkillKey(newSkillKey)
  if nil == Panel_Window_FairyChangeSkill_All then
    return
  end
  if true == Panel_Window_FairyChangeSkill_All:GetShow() then
    PaGlobal_FairyChangeSkill_All:fairyNewSkillKey(newSkillKey)
  end
end
function PaGlobal_FairyChangeSkill_IsGetShow()
  if nil == Panel_Window_FairyChangeSkill_All then
    return
  end
  return Panel_Window_FairyChangeSkill_All:GetShow()
end
function PaGlobal_FairyChangeSkill_ShowTooltip(isShow, key, slotIdx)
  PaGlobal_FairyChangeSkill_All:ShowTooltip(isShow, key, slotIdx)
end
function PaGlobal_FairyChangeSkill_Viewhelper_Open_All()
  if nil == Panel_FairySkillChange_Viewhelp then
    return
  end
  if true == Panel_FairySkillChange_Viewhelp:GetShow() then
    PaGlobal_FairyChangeSkill_All._ui.btn_VIewHelp:SetCheck(false)
    PaGlobal_FairyChangeSkill_Viewhelper_All:prepareClose()
  else
    PaGlobal_FairyChangeSkill_All._ui.btn_VIewHelp:SetCheck(true)
    PaGlobal_FairyChangeSkill_Viewhelper_All:prepareOpen()
  end
end
function PaGlobal_FairyChangeSkill_Viewhelper_Close_All()
  if nil == Panel_FairySkillChange_Viewhelp then
    return
  end
  PaGlobal_FairyChangeSkill_All._ui.btn_VIewHelp:SetCheck(false)
  PaGlobal_FairyChangeSkill_Viewhelper_All:prepareClose()
end
function PaGlobal_FairyPanel_ALL_Close()
  if true == Panel_Window_FairyGrowth_All:GetShow() then
    PaGlobal_FairyGrowth_Close_All()
    if true == Panel_Window_FairyGrowth_All:GetShow() then
      PaGlobal_FairyGrowth_Close_All()
    end
  end
  if true == Panel_Window_FairySkill_All:GetShow() then
    PaGlobalFunc_FairySkill_Close_All()
  end
  if true == Panel_Window_FairyChoiceTheReset_All:GetShow() then
    PaGlobal_FairyChoiceTheReset_Close_All()
  end
  if true == _ContentsGroup_FairyTierUpgradeAndRebirth and true == Panel_Window_FairyTierUpgrade_All:GetShow() then
    PaGlobal_FairyTierUpgrade_Close_All()
  end
  if true == Panel_Window_FairySetting_All:GetShow() then
    PaGlobal_FairySetting_Close_All()
  end
  if nil ~= Panel_Window_FairySkinChange_All and true == Panel_Window_FairySkinChange_All:GetShow() then
    PaGlobal_FairySkinChange_Close_All()
  end
  if true == _ContentsGroup_FairyChangeSkill and true == Panel_Window_FairyChangeSkill_All:GetShow() then
    PaGlobal_FairyChangeSkill_Close_All(false)
  end
end
