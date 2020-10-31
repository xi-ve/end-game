function PaGlobal_UiSetting_ButtonTooltip(_eBtnType, isShow)
  if false == isShow then
    TooltipSimple_Hide()
    return
  end
  local control, name, desc
  if PaGlobal_UISetting._eBtnType.preset1 == _eBtnType then
    control = PaGlobal_UISetting._ui.btn_UIFreeSet1
    name = PAGetString(Defines.StringSheet_GAME, "LUA_UISETTING_BTNTOOLTIP_PRESET1_TITLE")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_UISETTING_BTNTOOLTIP_PRESET1_DESC")
  elseif PaGlobal_UISetting._eBtnType.preset2 == _eBtnType then
    control = PaGlobal_UISetting._ui.btn_UIFreeSet2
    name = PAGetString(Defines.StringSheet_GAME, "LUA_UISETTING_BTNTOOLTIP_PRESET2_TITLE")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_UISETTING_BTNTOOLTIP_PRESET2_DESC")
  elseif PaGlobal_UISetting._eBtnType.preset3 == _eBtnType then
    control = PaGlobal_UISetting._ui.btn_UIFreeSet3
    name = PAGetString(Defines.StringSheet_GAME, "LUA_UISETTING_BTNTOOLTIP_PRESET3_TITLE")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_UISETTING_BTNTOOLTIP_PRESET3_DESC")
  elseif PaGlobal_UISetting._eBtnType.battleMode == _eBtnType then
    control = PaGlobal_UISetting._ui.btn_DefaultSet1
    name = PAGetString(Defines.StringSheet_GAME, "LUA_UISETTING_BTNTOOLTIP_BATTLEMODE_TITLE")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_UISETTING_BTNTOOLTIP_BATTLEMODE_DESC")
  elseif PaGlobal_UISetting._eBtnType.revertMode == _eBtnType then
    control = PaGlobal_UISetting._ui.btn_RevertMod
    name = PAGetString(Defines.StringSheet_GAME, "LUA_UISETTING_BTNTOOLTIP_REVERTMODE_TITLE")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_UISETTING_BTNTOOLTIP_REVERTMODE_DESC")
  end
  TooltipSimple_Show(control, name, desc)
end
function UiSet_FreeSet_Open()
  Panel_SaveFreeSet:SetShow(true)
  PaGlobal_UISetting._ui.title:SetShow(false)
  PaGlobal_Panel_SaveSetting_Hide()
end
function PaGlobal_UiSet_FreeSet_Close()
  Panel_SaveFreeSet:SetShow(false)
  PaGlobal_UISetting._ui.title:SetShow(true)
  PaGlobal_UISetting._ui.chk_GridView:SetCheck(false)
end
function HandleLUp_ToggleGrid()
  local isCheck = PaGlobal_UISetting._ui.chk_GridView:IsCheck()
  PaGlobal_UISetting._ui.bg_Grid:SetShow(isCheck)
end
function HandleLUp_UiSetting_DefaultSet(isShortcuts)
  if not IsSelfPlayerWaitAction() then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_UI_SETTING_NOTCURRENTACTION_ACK"))
    return
  end
  PaGlobal_UISetting:applyDefaultSet(isShortcuts)
end
function HandleEventLUp_UiSet_MoveControlSet_Start(idx)
  if PaGlobal_UISetting._panelControl[idx].posFixed then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_UI_SETTING_POSFIXED_ACK"))
    return
  end
  local control = PaGlobal_UISetting._panelPool[idx].control
  PaGlobal_UISetting._original_MouseX = getMousePosX()
  PaGlobal_UISetting._original_MouseY = getMousePosY()
  PaGlobal_UISetting._original_controlPosX = control:GetPosX()
  PaGlobal_UISetting._original_controlPosY = control:GetPosY()
  PaGlobal_UISetting._posGapX = PaGlobal_UISetting._original_MouseX - PaGlobal_UISetting._original_controlPosX
  PaGlobal_UISetting._posGapY = PaGlobal_UISetting._original_MouseY - PaGlobal_UISetting._original_controlPosY
end
function HandleEventLUp_UiSet_MoveControl(idx)
  if PaGlobal_UISetting._panelControl[idx].posFixed then
    return
  end
  local scale = PaGlobal_UISetting._currentScale / 100
  local mouseX = getMousePosX()
  local mouseY = getMousePosY()
  local control = PaGlobal_UISetting._panelPool[idx].control
  control:SetPosX(mouseX - PaGlobal_UISetting._posGapX)
  control:SetPosY(mouseY - PaGlobal_UISetting._posGapY)
  PaGlobal_UISetting._cachePosX[idx] = control:GetPosX()
  PaGlobal_UISetting._cachePosY[idx] = control:GetPosY()
  PaGlobal_UISetting._cachePreScale[idx] = scale
  PaGlobal_UISetting._cacheSizeX[idx] = control:GetSizeX()
  PaGlobal_UISetting._cacheSizeY[idx] = control:GetSizeY()
  PaGlobal_UISetting._panelControl[idx].isChange = true
end
function HandleEventLUp_UiSet_PositionCheck(index)
  if not PaGlobal_UISetting._ui.btn_QuickSlotMagnetic:IsCheck() then
    return
  end
  if index >= PaGlobal_UISetting._panelID.NewQuickSlot0 and index <= PaGlobal_UISetting._panelID.NewQuickSlot19 then
    HandleEventLUp_UiSet_PositionCheck_SetPos(index, PaGlobal_UISetting._panelID.NewQuickSlot0, PaGlobal_UISetting._panelID.NewQuickSlot19)
  elseif index >= PaGlobal_UISetting._panelID.SkillCoolTimeQuickSlot0 and index <= PaGlobal_UISetting._panelID.SkillCoolTimeQuickSlot9 then
    HandleEventLUp_UiSet_PositionCheck_SetPos(index, PaGlobal_UISetting._panelID.SkillCoolTimeQuickSlot0, PaGlobal_UISetting._panelID.SkillCoolTimeQuickSlot9)
  end
end
function HandleEventLUp_UiSet_PositionCheck_SetPos(index, startIndex, endIndex)
  local basePosX = PaGlobal_UISetting._panelPool[index].control:GetPosX()
  local basePosY = PaGlobal_UISetting._panelPool[index].control:GetPosY()
  for qIndex = startIndex, endIndex do
    if index ~= qIndex then
      local control = PaGlobal_UISetting._panelPool[qIndex].control
      if basePosX < control:GetPosX() + control:GetSizeX() + 25 and basePosX > control:GetPosX() and basePosY > control:GetPosY() - 20 and basePosY < control:GetPosY() + 20 then
        PaGlobal_UISetting._panelPool[index].control:SetPosX(control:GetPosX() + control:GetSizeX())
        PaGlobal_UISetting._panelPool[index].control:SetPosY(control:GetPosY())
        break
      end
      if basePosY < control:GetPosY() + control:GetSizeY() + 32 and basePosY > control:GetPosY() and basePosX > control:GetPosX() - 20 and basePosX < control:GetPosX() + 20 then
        PaGlobal_UISetting._panelPool[index].control:SetPosX(control:GetPosX())
        PaGlobal_UISetting._panelPool[index].control:SetPosY(control:GetPosY() + control:GetSizeY())
        break
      end
      if basePosX > control:GetPosX() - control:GetSizeX() - 25 and basePosX < control:GetPosX() and basePosY > control:GetPosY() - 20 and basePosY < control:GetPosY() + 20 then
        PaGlobal_UISetting._panelPool[index].control:SetPosX(control:GetPosX() - control:GetSizeX())
        PaGlobal_UISetting._panelPool[index].control:SetPosY(control:GetPosY())
        break
      end
      if basePosY > control:GetPosY() - control:GetSizeY() - 32 and basePosY < control:GetPosY() and basePosX > control:GetPosX() - 20 and basePosX < control:GetPosX() + 20 then
        PaGlobal_UISetting._panelPool[index].control:SetPosX(control:GetPosX())
        PaGlobal_UISetting._panelPool[index].control:SetPosY(control:GetPosY() - control:GetSizeY())
        break
      end
    end
  end
end
function HandleEventLUp_UiSet_ControlShowToggle(idx)
  local panelOpen = 0
  if idx == PaGlobal_UISetting._panelID.Adrenallin and not getSelfPlayer():isEnableAdrenalin() then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_UI_SETTING_NOTYETSPRIT_ACK"))
    PaGlobal_UISetting._panelPool[idx].close:SetCheck(PaGlobal_UISetting._panelControl[idx].isShow)
    return
  elseif idx == PaGlobal_UISetting._panelID.House or idx == PaGlobal_UISetting._panelID.NewEquip or idx == PaGlobal_UISetting._panelID.Party or idx == PaGlobal_UISetting._panelID.QuickSlot or idx == PaGlobal_UISetting._panelID.Adrenallin or idx == PaGlobal_UISetting._panelID.LargeParty then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_UI_SETTING_NOTRANDOMHIDE_ACK"))
    PaGlobal_UISetting._panelPool[idx].close:SetCheck(PaGlobal_UISetting._panelControl[idx].isShow)
    return
  elseif idx >= PaGlobal_UISetting._panelID.NewQuickSlot0 and idx <= PaGlobal_UISetting._panelID.NewQuickSlot19 and not isUseNewQuickSlot() then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_UI_SETTING_NEWQUICKSETTING"))
    PaGlobal_UISetting._panelPool[idx].close:SetCheck(PaGlobal_UISetting._panelControl[idx].isShow)
    return
  elseif PaGlobal_UISetting._panelControl[idx].isShow then
    PaGlobal_UISetting._panelControl[idx].isShow = false
    PaGlobal_UISetting._panelPool[idx].close:SetCheck(false)
    PaGlobal_UISetting:changePanelBGTexture(idx, 1)
    if 21 == idx then
      PaGlobal_UISetting._panelPool[idx].control:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_UISETTING_SKILLGUIDE_EXTRA"))
    else
      PaGlobal_UISetting._panelPool[idx].control:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_UI_SETTING_SLOTCONTROL_OFF", "name", PaGlobal_UISetting._panelControl[idx].name))
    end
    panelOpen = false
  else
    PaGlobal_UISetting._panelControl[idx].isShow = true
    PaGlobal_UISetting._panelPool[idx].close:SetCheck(true)
    if PaGlobal_UISetting._panelControl[idx].posFixed then
      PaGlobal_UISetting:changePanelBGTexture(idx, 3)
    else
      PaGlobal_UISetting:changePanelBGTexture(idx, 2)
    end
    if PaGlobal_UISetting._panelControl[idx].posFixed then
      PaGlobal_UISetting._panelPool[idx].control:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_UI_SETTING_SLOTCONTROL_IMPOSSIBLE", "name", PaGlobal_UISetting._panelControl[idx].name))
    else
      PaGlobal_UISetting._panelPool[idx].control:SetText(PaGlobal_UISetting._panelControl[idx].name)
    end
    panelOpen = true
  end
  if idx >= PaGlobal_UISetting._panelID.Chat0 and idx <= PaGlobal_UISetting._panelID.Chat4 then
    Chatting_setIsOpenValue(idx - PaGlobal_UISetting._panelID.Chat0, panelOpen)
  end
end
function HandleClicked_UiSet_ConfirmSetting(isShortcuts)
  PaGlobal_UiSet_FreeSet_Close()
  SetUIMode(Defines.UIMode.eUIMode_Default)
  PaGlobal_UISetting._renderMode:reset()
  ToClient_getGameUIManagerWrapper():setLuaCacheDataListBool(__eSwapRemasterUISetting, PaGlobal_UISetting._isShowRemasterUI, CppEnums.VariableStorageType.eVariableStorageType_User)
  ToClient_getGameUIManagerWrapper():setLuaCacheDataListBool(__eUiSetting_useMode, false, CppEnums.VariableStorageType.eVariableStorageType_User)
  if PaGlobal_UISetting._prevRemasterUI ~= PaGlobal_UISetting._isShowRemasterUI then
    FromClient_MainStatus_SwapUIOption(PaGlobal_UISetting._isShowRemasterUI)
  end
  local scale = PaGlobal_UISetting:confrimSetting_Sub()
  if false == _ContentsGroup_RemasterUI_Main_Alert then
    Panel_NewEquip_EffectLastUpdate()
  end
  FGlobal_PetListNew_NoPet()
  scale = scale + 0.002
  local uiScale_Percent = math.floor(scale * 100)
  scale = uiScale_Percent / 100
  if true == UI.checkResolution4KForXBox() then
    scale = 2
  end
  setUIScale(scale)
  GameOption_SetUIMode(scale)
  saveGameOption(false)
  if false == isShortcuts then
    if PaGlobal_UISetting._isMenu then
      Panel_Menu_ShowToggle()
    else
      Panel_Window_Skill:SetShow(true, true)
      PaGlobal_Window_Skill_CoolTimeSlot:showFunc()
    end
  end
  if false == ToClient_isConsole() then
    ToClient_AudioPostEvent_UIAudioStateEvent("UISTATE_CLOSE_DEFAULT")
  end
end
function HandleEventLUp_UiSet_FieldViewToggle()
  if PaGlobal_UISetting._ui.btn_FieldView:IsCheck() then
    FieldViewMode_ShowToggle(true)
  else
    FieldViewMode_ShowToggle(false)
  end
end
function HandleEventLUp_UiSet_SwapRemasterUI()
  PaGlobal_UISetting._prevRemasterUI = PaGlobal_UISetting._isShowRemasterUI
  if PaGlobal_UISetting._ui.btn_remsaterUI:IsCheck() then
    PaGlobal_UISetting._isShowRemasterUI = false
  else
    PaGlobal_UISetting._isShowRemasterUI = true
  end
  PaGlobal_UISetting:update(true)
end
function HandleEventLDown_UiSet_ChangeScale()
  local scale = PaGlobal_UISetting._currentScale / 100
  for idx = 1, PaGlobal_UISetting._panelCount do
    local control = PaGlobal_UISetting._panelPool[idx].control
    PaGlobal_UISetting._cachePosX[idx] = control:GetPosX()
    PaGlobal_UISetting._cachePosY[idx] = control:GetPosY()
    PaGlobal_UISetting._cachePreScale[idx] = scale
    PaGlobal_UISetting._cacheSizeX[idx] = control:GetSizeX()
    PaGlobal_UISetting._cacheSizeY[idx] = control:GetSizeY()
  end
end
function HandleEventLPress_UiSet_ChangeScale()
  local nowPercent = PaGlobal_UISetting._ui.slider_UI_Scale:GetControlPos()
  local realPercent = math.ceil(PaGlobal_UISetting._replaceScale / 100 * (nowPercent * 100) + PaGlobal_UISetting._minScale)
  local scaleText = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_UI_SETTING_SCALETEXT", "currentScale", realPercent)
  PaGlobal_UISetting._currentScale = realPercent
  PaGlobal_UISetting._ui.txt_UISize:SetText(tostring(scaleText))
  PaGlobal_UISetting:changePanelPoolScale(PaGlobal_UISetting._currentScale / 100)
end
function HandleClicked_Reset_UiSetting_Msg()
  local reset_GameUI = function()
    local panelID = PaGlobal_UISetting._panelID
    local panelControl = PaGlobal_UISetting._panelControl
    local panelPool = PaGlobal_UISetting._panelPool
    local cachePosX = PaGlobal_UISetting._cachePosX
    local cachePosY = PaGlobal_UISetting._cachePosY
    local screenSizeX = getScreenSizeX()
    local screenSizeY = getScreenSizeY()
    local const_LowMaxScaleValue = 90
    local const_MidleMaxScaleValue = 100
    local const_HightMaxScaleValue = 120
    local minScaleHeight = 720
    local midleScaleHeight = 900
    local uiScale = 1
    local gameOptionSetting = ToClient_getGameOptionControllerWrapper()
    local screenWidth = gameOptionSetting:getScreenResolutionWidth()
    local screenHeight = gameOptionSetting:getScreenResolutionHeight()
    if false == isGameTypeThisCountry(CppEnums.ContryCode.eContryCode_KOR) then
      const_LowMaxScaleValue = 100
    end
    if minScaleHeight >= screenHeight then
      maxScaleValue = const_LowMaxScaleValue
    elseif minScaleHeight < screenHeight and midleScaleHeight >= screenHeight then
      maxScaleValue = const_MidleMaxScaleValue
    else
      maxScaleValue = const_HightMaxScaleValue
    end
    uiScale = math.floor(uiScale * 100) / 100
    if uiScale * 100 > maxScaleValue then
      uiScale = 0.8
    end
    if true == UI.checkResolution4KForXBox() then
      uiScale = 2
    end
    PaGlobal_UISetting._uiSet.nowCurrentPercent = uiScale
    SetUIMode(Defines.UIMode.eUIMode_Default)
    PaGlobal_UISetting._renderMode:reset()
    for idx = 1, PaGlobal_UISetting._panelCount do
      panelControl[idx].control:SetRelativePosX(0)
      panelControl[idx].control:SetRelativePosY(0)
      panelControl[idx].isChange = false
      if idx == panelID.ServantIcon or idx == panelID.House or idx == panelID.NewEquip or idx == panelID.Party or idx == panelID.Adrenallin or idx == panelID.QuickSlot or idx == panelID.LargeParty or idx == panelID.ServantIconRemaster or idx >= panelID.NewQuickSlot0 and idx <= panelID.NewQuickSlot19 then
      else
        panelControl[idx].isShow = true
      end
      if panelControl[idx].posFixed then
        PaGlobal_UISetting:changePanelBGTexture(idx, 3)
      else
        PaGlobal_UISetting:changePanelBGTexture(idx, 2)
      end
      if idx == panelID.Pvp then
        if isPvpEnable() then
          panelControl[idx].control:SetShow(panelControl[idx].isShow)
        end
      elseif idx == panelID.Adrenallin then
        if getSelfPlayer():isEnableAdrenalin() then
          panelControl[idx].control:SetShow(panelControl[idx].isShow)
        end
      elseif idx == panelID.GameTip then
        panelControl[idx].control:SetShow(panelControl[idx].isShow)
        if false == _ContentsGroup_RenewUI then
          Panel_GameTipMask:SetShow(panelControl[idx].isShow)
          Panel_GameTipMask:SetPosX(panelPool[idx].control:GetPosX() + 15)
          Panel_GameTipMask:SetPosY(panelPool[idx].control:GetPosY() - 7)
        end
      elseif idx == panelID.ClassResource then
        if __eClassType_Sorcerer == getSelfPlayer():getClassType() or __eClassType_Combattant == getSelfPlayer():getClassType() or __eClassType_Mystic == getSelfPlayer():getClassType() or __eClassType_ShyWaman == getSelfPlayer():getClassType() then
          panelControl[idx].control:SetShow(panelControl[idx].isShow)
        end
      elseif idx == panelID.QuickSlot then
        panelControl[idx].control:SetShow(panelControl[idx].isShow)
      elseif idx == panelID.ActionGuide then
        setShowSkillCmd(panelControl[idx].isShow)
        isChecked_SkillCommand = panelControl[idx].isShow
        panelControl[idx].control:SetShow(panelControl[idx].isShow)
        GameOption_UpdateOptionChanged()
      elseif idx == panelID.KeyGuide then
        panelControl[idx].isShow = false
        Panel_KeyViewer_Hide()
        PanelMovieKeyViewer_RestorePosition()
      elseif idx >= panelID.NewQuickSlot0 and idx <= panelID.NewQuickSlot19 then
        panelControl[idx].control:SetShow(panelControl[idx].isShow)
      elseif idx == panelID.Party then
        panelControl[idx].control:SetShow(panelControl[idx].isShow)
      elseif idx == panelID.LargeParty then
        panelControl[idx].control:SetShow(panelControl[idx].isShow)
      elseif idx >= panelID.SkillCoolTimeQuickSlot0 and idx <= panelID.SkillCoolTimeQuickSlot9 then
        panelControl[idx].control:SetShow(false)
      elseif idx == panelID.AppliedBuffList then
        panelControl[idx].control:SetShow(panelControl[idx].isShow)
      elseif idx == panelID.LeftIcon then
        panelControl[idx].control:SetShow(panelControl[idx].isShow)
      elseif idx == panelID.RightIcon then
        panelControl[idx].control:SetShow(panelControl[idx].isShow)
      elseif idx == panelID.AreaOfHadum then
        if true == _ContentsGroup_AreaOfHadum then
          panelControl[idx].control:SetShow(panelControl[idx].isShow)
        else
          panelControl[idx].control:SetShow(false)
        end
      else
        panelControl[idx].control:SetShow(true)
      end
      if idx == panelID.ServantIcon then
        cachePosX[idx] = 10
        cachePosY[idx] = panelPool[panelID.ExpGage].control:GetPosY() + panelPool[panelID.ExpGage].control:GetSizeY() + 15
      elseif idx == panelID.ServantIconRemaster then
        cachePosX[idx] = 10
        cachePosY[idx] = panelPool[panelID.MainStatusRemaster].control:GetPosY() + panelPool[panelID.MainStatusRemaster].control:GetSizeY() - 50
      elseif idx == panelID.Quest then
        cachePosX[idx] = screenSizeX - panelPool[panelID.Quest].control:GetSizeX() - 20
        cachePosY[idx] = panelPool[panelID.Radar].control:GetPosY() + panelPool[panelID.Radar].control:GetSizeY() + panelPool[panelID.MainQuest].control:GetSizeY() + 20 + panelPool[panelID.NewEquip].control:GetSizeY()
      elseif idx >= panelID.Chat0 and idx <= panelID.Chat4 then
        cachePosX[idx] = 0
        cachePosY[idx] = screenSizeY - panelPool[idx].control:GetSizeY() - Panel_GameTips:GetSizeY()
      elseif idx == panelID.QuickSlot then
        cachePosX[idx] = (screenSizeX - panelPool[panelID.QuickSlot].control:GetSizeX()) / 2
        cachePosY[idx] = screenSizeY - panelPool[panelID.QuickSlot].control:GetSizeY()
      elseif idx == panelID.HPBar then
        cachePosX[idx] = screenSizeX / 2 - panelPool[panelID.HPBar].control:GetSizeX() / 2
        cachePosY[idx] = screenSizeY - panelPool[panelID.QuickSlot].control:GetSizeY() - panelPool[panelID.HPBar].control:GetSizeY()
      elseif idx == panelID.Pvp then
        cachePosX[idx] = screenSizeX / 2 - panelPool[panelID.HPBar].control:GetSizeX() / 2 - 20
        cachePosY[idx] = screenSizeY - panelPool[panelID.QuickSlot].control:GetSizeY() - panelPool[panelID.Pvp].control:GetSizeY()
      elseif idx == panelID.ClassResource then
        cachePosX[idx] = screenSizeX / 2 - panelPool[panelID.HPBar].control:GetSizeX() / 2 + panelPool[panelID.ClassResource].control:GetSizeX() - 5
        cachePosY[idx] = screenSizeY - panelPool[panelID.QuickSlot].control:GetSizeY() - panelPool[panelID.HPBar].control:GetSizeY() - panelPool[panelID.ClassResource].control:GetSizeY() + 5
      elseif idx == panelID.Adrenallin then
        cachePosX[idx] = screenSizeX / 2 - panelPool[panelID.Adrenallin].control:GetSizeX() / 2 + 225
        cachePosY[idx] = screenSizeY - panelPool[panelID.QuickSlot].control:GetSizeY() - 76
      elseif idx == panelID.House then
        cachePosX[idx] = 10
        if Panel_Window_Servant:GetShow() then
          cachePosX[idx] = panelPool[panelID.ServantIcon].control:GetSizeX() + 10
        end
        cachePosY[idx] = panelPool[panelID.ExpGage].control:GetPosY() + panelPool[panelID.ExpGage].control:GetSizeY() + 15
      elseif idx == panelID.NewEquip then
        cachePosX[idx] = FGlobal_GetPersonalIconPosY(4) + FGlobal_GetPersonalIconSizeY()
        cachePosY[idx] = FGlobal_GetPersonalIconPosX(4)
      elseif idx == panelID.ActionGuide then
        cacahePosX[idx] = screenSizeX / 2 * 1.2
        cachePosY[idx] = screenSizeY / 2 * 0.85
      elseif idx == panelID.KeyGuide then
        cachePosX[idx] = panelPool[panelID.KeyGuide].control:GetSizeX() / 3
        cachePosY[idx] = panelPool[panelID.KeyGuide].control:GetSizeY() * 2.3
      elseif idx == panelID.SkillCoolTime then
        cachePosX[idx] = screenSizeX * 0.33
        cachePosY[idx] = screenSizeY * 0.42
      elseif idx == panelID.MainQuest then
        cachePosX[idx] = screenSizeX - panelPool[panelID.MainQuest].control:GetSizeX() - 20
        cachePosY[idx] = panelPool[panelID.Radar].control:GetPosY() + panelPool[panelID.Radar].control:GetSizeY() + 10
      end
      if idx >= panelID.NewQuickSlot0 and idx <= panelID.NewQuickSlot19 then
        local panelIdx = idx - panelID.NewQuickSlot0
        cachePosX[idx] = screenSizeX * 0.35 + (panelControl[idx].control:GetSizeX() + 5) * panelIdx
        cachePosY[idx] = screenSizeY - panelControl[idx].control:GetSizeY() - 5
      end
      if idx >= panelID.SkillCoolTimeQuickSlot0 and idx <= panelID.SkillCoolTimeQuickSlot9 then
        local panelIdx = idx - panelID.SkillCoolTimeQuickSlot0
        cachePosX[idx] = screenSizeX * 0.25 + panelControl[idx].control:GetSizeX() * (panelIdx % 2)
        cachePosY[idx] = screenSizeY * 0.29 + panelControl[idx].control:GetSizeY() * math.floor(panelIdx / 2)
      end
    end
    if false == _ContentsGroup_RemasterUI_Main_Alert then
      Panel_NewEquip_EffectLastUpdate()
    end
    FGlobal_ResetRadarUI(true)
    if nil ~= PaGlobal_WorldMiniMap then
      PaGlobal_WorldMiniMap:resetPanelSize()
    end
    HouseNaviBasicInitPosition()
    FGlobal_PetListNew_NoPet()
    local count = ToClient_getChattingPanelCount()
    for chattingPanelindex = 0, count - 1 do
      Chatting_setIsOpenValue(chattingPanelindex, PaGlobal_UISetting._chatPanelIsOpenState[chattingPanelindex + 1])
      PaGlobal_UISetting._chatPanelIsOpenState[chattingPanelindex + 1] = false
    end
    Chatting_setIsOpenValue(0, true)
    PaGlobal_UISetting._chatPanelIsOpenState[1] = true
    FGlobal_ChattingPanel_Reset()
    FGlobal_NewQuickSlot_InitPos(false)
    PaGlobal_SkillCoolTimeQuickSlot:settingPos(false)
    FGlobal_SkillCommand_ResetPosition()
    PaGlobalFunc_AppliedBuffList_ResetPosition()
    PaGlobal_UISetting._isShowRemasterUI = true
    ToClient_getGameUIManagerWrapper():setLuaCacheDataListBool(__eSwapRemasterUISetting, PaGlobal_UISetting._isShowRemasterUI, CppEnums.VariableStorageType.eVariableStorageType_User)
    FromClient_MainStatus_SwapUIOption(PaGlobal_UISetting._isShowRemasterUI)
    PaGlobal_UISetting:checkOldMainStatus()
    PaGlobal_Stamina_ResetPosition()
    resetGameUI()
    PaGlobal_UISetting:update()
    ToClient_SaveUiInfo(true)
    FGlobal_MyHouseNavi_Update()
    if false == ToClient_isConsole() then
      ToClient_AudioPostEvent_UIAudioStateEvent("UISTATE_CLOSE_DEFAULT")
    end
  end
  local messageBoxMemo = PAGetString(Defines.StringSheet_GAME, "LUA_UI_SETTING_ALLINTERFACERESET_CONFIRM")
  local messageBoxData = {
    title = PAGetString(Defines.StringSheet_GAME, "LUA_UI_SETTING_ALLINTERFACERESET"),
    content = messageBoxMemo,
    functionYes = reset_GameUI,
    functionNo = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageBoxData)
end
function HandleLUp_SavePresetInfo(presetIndex)
  PaGlobal_UISetting:savePresetInfo(presetIndex)
end
function HandleEventLUp_ApplyPresetInfo(presetIndex, isShortcuts)
  PaGlobal_UISetting:applyPresetInfo(presetIndex, isShortcuts)
end
function FromClient_UISetting_Resize()
  Panel_UI_Setting:SetSize(getScreenSizeX(), getScreenSizeY())
  Panel_UI_Setting:ComputePos()
  Panel_SaveFreeSet:ComputePos()
  PaGlobal_UISetting._ui.title:ComputePos()
  PaGlobal_UISetting._ui.bg_Grid:ComputePos()
  PaGlobal_UISetting._uiSave.bg_Block:ComputePos()
  local scale = ToClient_GetUIScale()
  scale = scale + 0.002
  scale = math.floor(scale * 100)
  FGlobal_saveUIScale(scale)
end
function FromClient_getUiSettingChattingPanelInfo(chatWindowIndex, isOpen, isCombined, sizeX, sizeY, isUsedSmoothChattingup)
  local index = chatWindowIndex + PaGlobal_UISetting._panelID.Chat0
  PaGlobal_UISetting._closePanelState[chatWindowIndex] = false
  PaGlobal_UISetting._closeEmptyPanelState[chatWindowIndex] = false
  local chatPanel = ToClient_getChattingPanel(chatWindowIndex)
  if isOpen then
    PaGlobal_UISetting._chatPanelIsOpenState[chatWindowIndex + 1] = true
    HandleClicked_Chatting_AddTabByIndex(chatWindowIndex)
    if index == PaGlobal_UISetting._panelID.Chat0 then
      PaGlobal_UISetting._panelPool[index].control:SetShow(true)
      PaGlobal_UISetting._panelPool[index].close:SetShow(true)
      PaGlobal_UISetting._panelControl[index].control:SetSize(sizeX, sizeY)
      PaGlobal_UISetting._panelPool[index].control:SetSize(sizeX, sizeY)
      chatPanel:setPanelSize(sizeX, sizeY)
    elseif isCombined then
      HandleClicked_Chatting_CombineTab(chatWindowIndex)
      PaGlobal_UISetting._panelPool[index].control:SetShow(false)
      PaGlobal_UISetting._panelPool[index].close:SetShow(false)
    else
      HandleClicked_Chatting_Division(chatWindowIndex)
      PaGlobal_UISetting._panelPool[index].control:SetShow(true)
      PaGlobal_UISetting._panelPool[index].close:SetShow(true)
      PaGlobal_UISetting._panelControl[index].control:SetSize(sizeX, sizeY)
      PaGlobal_UISetting._panelPool[index].control:SetSize(sizeX, sizeY)
      chatPanel:setPanelSize(sizeX, sizeY)
    end
  elseif isCombined == false or index == PaGlobal_UISetting._panelID.Chat0 then
    if index ~= PaGlobal_UISetting._panelID.Chat0 then
      HandleClicked_Chatting_Division(chatWindowIndex)
    end
    PaGlobal_UISetting._panelPool[index].control:SetShow(true)
    PaGlobal_UISetting._panelPool[index].close:SetShow(true)
    PaGlobal_UISetting._panelControl[index].control:SetSize(sizeX, sizeY)
    PaGlobal_UISetting._panelPool[index].control:SetSize(sizeX, sizeY)
    PaGlobal_UISetting._panelControl[index].control:SetShow(true)
    chatPanel:setPanelSize(sizeX, sizeY)
    PaGlobal_UISetting._closeEmptyPanelState[chatWindowIndex] = true
    PaGlobal_UISetting._chatPanelIsOpenState[chatWindowIndex + 1] = false
  else
    PaGlobal_UISetting._panelPool[index].control:SetShow(false)
    PaGlobal_UISetting._panelPool[index].close:SetShow(false)
    HandleClicked_Chatting_Close(chatWindowIndex, 0)
    PaGlobal_UISetting._closePanelState[chatWindowIndex] = true
  end
  Chatting_setUsedSmoothChattingUp(isUsedSmoothChattingup)
end
function FromClient_getUiSettingPanelInfo(panelIndex, posX, posY, isShow, chatWindowIndex, relativePosX, relativePosY)
  PaGlobal_UISetting:getUiSettingPanelInfo(panelIndex, posX, posY, isShow, chatWindowIndex, relativePosX, relativePosY)
end
function FromClient_applyChattingOptionToLua(presetIndex, chatWindowIndex, chatFontSizeType, chatNameType, isCombined, transparency, isUsedSmoothChattingUp)
  ChattingOption_Open(chatWindowIndex, chatWindowIndex, isCombined)
  FGlobal_Chatting_PanelTransparency(chatWindowIndex, transparency, false)
  HandleClicked_ChattingTypeFilter_Notice(chatWindowIndex)
  HandleClicked_ChattingTypeFilter_World(chatWindowIndex)
  HandleClicked_ChattingTypeFilter_Battle(chatWindowIndex)
  HandleClicked_ChattingTypeFilter_Public(chatWindowIndex)
  HandleClicked_ChattingTypeFilter_RolePlay(chatWindowIndex)
  HandleClicked_ChattingTypeFilter_Team(chatWindowIndex)
  HandleClicked_ChattingDivision()
  HandleClicked_ChattingTypeFilter_WorldWithItem(chatWindowIndex)
  HandleClicked_ChattingTypeFilter_Guild(chatWindowIndex)
  HandleClicked_ChattingTypeFilter_Party(chatWindowIndex)
  HandleClicked_ChattingTypeFilter_Private(chatWindowIndex)
  HandleClicked_ChattingTypeFilter_Arsha(chatWindowIndex)
  HandleClicked_ChattingTypeFilter_System(chatWindowIndex)
  HandleClicked_ChattingSystemTypeFilter_Undefine(chatWindowIndex)
  HandleClicked_ChattingSystemTypeFilter_PrivateItem(chatWindowIndex)
  HandleClicked_ChattingSystemTypeFilter_PartyItem(chatWindowIndex)
  HandleClicked_ChattingSystemTypeFilter_Market(chatWindowIndex)
  HandleClicked_ChattingSystemTypeFilter_Worker(chatWindowIndex)
  HandleClicked_ChattingSystemTypeFilter_Harvest(chatWindowIndex)
  HandleClicked_ChattingColor_Notice(chatWindowIndex)
  HandleClicked_ChattingColor_World(chatWindowIndex)
  HandleClicked_ChattingColor_Public(chatWindowIndex)
  HandleClicked_ChattingColor_RolePlay(chatWindowIndex)
  HandleClicked_ChattingColor_Team(chatWindowIndex)
  HandleClicked_ChattingColor_WorldWithItem(chatWindowIndex)
  HandleClicked_ChattingColor_Guild(chatWindowIndex)
  HandleClicked_ChattingColor_Party(chatWindowIndex)
  HandleClicked_ChattingColor_Private(chatWindowIndex)
  HandleClicked_ChattingColor_Arsha(chatWindowIndex)
  HandleClicked_ChattingColor_MainSystem(chatWindowIndex)
  Panel_ChatOption:SetShow(false, false)
  Panel_ChatOption:SetIgnore(true)
  ChattingColor_Hide()
  Chatting_setUsedSmoothChattingUp(isUsedSmoothChattingUp)
  ChattingOption_UpdateChattingAnimationControl(isUsedSmoothChattingUp)
  setisChangeFontSize(true)
end
function PaGlobal_SimpleTooltips(isShow)
  if not isShow then
    TooltipSimple_Hide()
    return
  end
  local name, desc, control
  name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_GAMEOPTION_SAVESETTING")
  desc = PAGetString(Defines.StringSheet_GAME, "LUA_SAVESETTING_BTN_DESC")
  control = PaGlobal_UISetting._uiSet.btn_save
  TooltipSimple_Show(control, name, desc)
end
function PaGlobal_SimpleTooltips_Index(isShow, idx)
  if not isShow then
    TooltipSimple_Hide()
    return
  end
  if 46 <= idx and idx <= 55 then
    local name, desc, control
    name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SKILLCOOLTIME_TITLE")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_UISETTING_COOLTIME_DESC")
    control = PaGlobal_UISetting._panelPool[idx].control
    TooltipSimple_Show(control, name, desc)
  end
end
function setChangeUiSettingRadarUI(panel, uiType)
  PaGlobal_UISetting._panelControl[PaGlobal_UISetting._panelID.Radar].control = panel
  PaGlobal_UISetting._panelControl[PaGlobal_UISetting._panelID.Radar].PAGameUIType = uiType
end
function FGlobal_UiSet_Open(isMenu)
  if nil == isMenu then
    PaGlobal_UISetting._isMenu = true
  else
    PaGlobal_UISetting._isMenu = isMenu
  end
  PaGlobal_UISetting:prepareOpen()
end
function FGlobal_UiSet_Close()
  PaGlobal_UISetting:prepareClose()
end
function UiSet_update(isRemasterSwap)
  PaGlobal_UISetting:update(isRemasterSwap)
end
function PAGlobal_setIsChangePanelState(index, state, ischatPanel)
  if false == ischatPanel then
    for idx = 1, PaGlobal_UISetting._panelCount do
      if PaGlobal_UISetting._panelControl[idx].PAGameUIType == index then
        PaGlobal_UISetting._panelControl[idx].isChange = state
        return
      end
    end
  else
    PaGlobal_UISetting._panelControl[index].isChange = state
  end
end
function PAGlobal_setPanelChattingPoolRelativeSize(index, sizex, sizey)
  local scale = PaGlobal_UISetting._currentScale / 100
  local preScale = PaGlobal_UISetting._preScale
  local currentScreenSize = {
    x = getScreenSizeX(),
    y = getScreenSizeY()
  }
  index = index + PaGlobal_UISetting._panelID.Chat0
  local slot = PaGlobal_UISetting._panelControl[index].control
  local posX = slot:GetPosX()
  local posY = slot:GetPosY()
  local rateX = 0
  local rateY = 0
  rateX = posX + slot:GetSizeX() / 2
  rateY = posY + slot:GetSizeY() / 2
  if PaGlobal_UISetting._panelControl[index].isChange == false then
    PaGlobal_UISetting._panelPool[index].control:SetRelativePosX(0)
    PaGlobal_UISetting._panelPool[index].control:SetRelativePosY(0)
    slot:SetRelativePosX(0)
    slot:SetRelativePosY(0)
  else
    PaGlobal_UISetting._panelPool[index].control:SetRelativePosX(rateX / currentScreenSize.x)
    PaGlobal_UISetting._panelPool[index].control:SetRelativePosY(rateY / currentScreenSize.y)
    slot:SetRelativePosX(rateX / currentScreenSize.x)
    slot:SetRelativePosY(rateY / currentScreenSize.y)
  end
end
