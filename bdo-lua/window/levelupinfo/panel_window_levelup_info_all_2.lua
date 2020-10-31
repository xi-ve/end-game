function PaGlobalFunc_Levelup_Info_All_Open()
  if nil == Panel_Window_LevelUp_Info_All then
    return
  end
  PaGlobal_Levelup_Info_All:CurrentState()
  PaGlobal_Levelup_Info_All:prepareOpen()
end
function PaGlobalFunc_Levelup_Info_All_Close()
  if nil == Panel_Window_LevelUp_Info_All then
    return
  end
  PaGlobal_Levelup_Info_All:CurrentState()
  PaGlobal_Levelup_Info_All:prepareClose()
end
function PaGlobalFunc_Levelup_Info_All_Hide()
  if nil == Panel_Window_LevelUp_Info_All then
    return false
  end
  if false == Panel_Window_LevelUp_Info_All:IsShow() then
    return false
  end
  if true == PaGlobal_Levelup_Info_All._isFoldCheck then
    return false
  end
  HandleEventLUp_Levelup_Info_All_LeftOpen()
  return true
end
function HandleEventLUp_Levelup_Info_All_LeftOpen()
  if nil == Panel_Window_LevelUp_Info_All then
    return
  end
  PaGlobal_Levelup_Info_All._ui._btn_Unfold:ChangeTextureInfoName("combine/btn/combine_btn_00.dds")
  if false == PaGlobal_Levelup_Info_All._isFoldCheck then
    local moveAni2 = Panel_Window_LevelUp_Info_All:addMoveAnimation(0, 0.3, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_SQUARE)
    moveAni2:SetStartPosition(getScreenSizeX() - Panel_Window_LevelUp_Info_All:GetSizeX() - 20, getScreenSizeY() - Panel_Window_LevelUp_Info_All:GetSizeY() - 30)
    moveAni2:SetEndPosition(getScreenSizeX(), getScreenSizeY() - Panel_Window_LevelUp_Info_All:GetSizeY() - 30)
    moveAni2:SetHideAtEnd(false)
    moveAni2:SetDisableWhileAni(true)
    local x1, y1, x2, y2 = setTextureUV_Func(PaGlobal_Levelup_Info_All._ui._btn_Unfold, 94, 83, 117, 123)
    PaGlobal_Levelup_Info_All._ui._btn_Unfold:getBaseTexture():setUV(x1, y1, x2, y2)
    x1, y1, x2, y2 = setTextureUV_Func(PaGlobal_Levelup_Info_All._ui._btn_Unfold, 118, 83, 141, 123)
    PaGlobal_Levelup_Info_All._ui._btn_Unfold:getOnTexture():setUV(x1, y1, x2, y2)
    x1, y1, x2, y2 = setTextureUV_Func(PaGlobal_Levelup_Info_All._ui._btn_Unfold, 142, 83, 165, 123)
    PaGlobal_Levelup_Info_All._ui._btn_Unfold:getClickTexture():setUV(x1, y1, x2, y2)
    PaGlobal_Levelup_Info_All._ui._btn_Unfold:setRenderTexture(PaGlobal_Levelup_Info_All._ui._btn_Unfold:getBaseTexture())
    PaGlobal_Levelup_Info_All._isFoldCheck = true
  else
    local moveAni2 = Panel_Window_LevelUp_Info_All:addMoveAnimation(0, 0.3, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_SQUARE)
    moveAni2:SetStartPosition(getScreenSizeX(), getScreenSizeY() - Panel_Window_LevelUp_Info_All:GetSizeY() - 30)
    moveAni2:SetEndPosition(getScreenSizeX() - Panel_Window_LevelUp_Info_All:GetSizeX() - 20, getScreenSizeY() - Panel_Window_LevelUp_Info_All:GetSizeY() - 30)
    moveAni2:SetHideAtEnd(false)
    moveAni2:SetDisableWhileAni(true)
    local x1, y1, x2, y2 = setTextureUV_Func(PaGlobal_Levelup_Info_All._ui._btn_Unfold, 94, 124, 117, 164)
    PaGlobal_Levelup_Info_All._ui._btn_Unfold:getBaseTexture():setUV(x1, y1, x2, y2)
    x1, y1, x2, y2 = setTextureUV_Func(PaGlobal_Levelup_Info_All._ui._btn_Unfold, 118, 124, 141, 164)
    PaGlobal_Levelup_Info_All._ui._btn_Unfold:getOnTexture():setUV(x1, y1, x2, y2)
    x1, y1, x2, y2 = setTextureUV_Func(PaGlobal_Levelup_Info_All._ui._btn_Unfold, 142, 124, 165, 164)
    PaGlobal_Levelup_Info_All._ui._btn_Unfold:getClickTexture():setUV(x1, y1, x2, y2)
    PaGlobal_Levelup_Info_All._ui._btn_Unfold:setRenderTexture(PaGlobal_Levelup_Info_All._ui._btn_Unfold:getBaseTexture())
    PaGlobal_Levelup_Info_All._isFoldCheck = false
  end
end
function HandleEventOnOut_Levelup_Info_All_LeftOpenTooltip(isShow)
  if nil == Panel_Window_LevelUp_Info_All then
    return
  end
  if true == isShow and true == PaGlobal_Levelup_Info_All._isFoldCheck then
    HandleEventLUp_Levelup_Info_All_LeftOpen()
  end
  if false == isShow then
    TooltipSimple_Hide()
    return
  end
  local name = PAGetString(Defines.StringSheet_GAME, "LUA_LEVELUPINFO_LEFTOPEN_TOOLTIP_TITLE")
  local desc = PAGetString(Defines.StringSheet_GAME, "LUA_LEVELUPINFO_LEFTOPEN_TOOLTIP_DESC")
  local control = PaGlobal_Levelup_Info_All._ui._btn_Unfold
  TooltipSimple_Show(control, name, desc)
end
function PaGlobalFunc_Levelup_Info_All_SelfPlayerCurrentLevelInfo(learnableSkillCount, learnSkillCount, hp, mp, stun, weight, lvdd, lvpv)
  if nil == Panel_Window_LevelUp_Info_All then
    return
  end
  UI.ASSERT_NAME(nil ~= learnSkillCount, "PaGlobalFunc_Levelup_Info_All_SelfPlayerCurrentLevelInfo learnSkillCount nil", "\236\157\180\236\138\185\237\153\152")
  UI.ASSERT_NAME(nil ~= learnableSkillCount, "PaGlobalFunc_Levelup_Info_All_SelfPlayerCurrentLevelInfo learnableSkillCount nil", "\236\157\180\236\138\185\237\153\152")
  UI.ASSERT_NAME(nil ~= hp, "PaGlobalFunc_Levelup_Info_All_SelfPlayerCurrentLevelInfo hp nil", "\236\157\180\236\138\185\237\153\152")
  UI.ASSERT_NAME(nil ~= mp, "PaGlobalFunc_Levelup_Info_All_SelfPlayerCurrentLevelInfo mp nil", "\236\157\180\236\138\185\237\153\152")
  UI.ASSERT_NAME(nil ~= weight, "PaGlobalFunc_Levelup_Info_All_SelfPlayerCurrentLevelInfo weight nil", "\236\157\180\236\138\185\237\153\152")
  UI.ASSERT_NAME(nil ~= lvdd, "PaGlobalFunc_Levelup_Info_All_SelfPlayerCurrentLevelInfo lvdd nil", "\236\157\180\236\138\185\237\153\152")
  UI.ASSERT_NAME(nil ~= lvpv, "PaGlobalFunc_Levelup_Info_All_SelfPlayerCurrentLevelInfo lvpv nil", "\236\157\180\236\138\185\237\153\152")
  local playerLevel = getSelfPlayer():get():getLevel()
  if 56 ~= playerLevel then
    lvpv = 0
  end
  if 60 ~= playerLevel then
    lvdd = 0
  end
  PaGlobal_Levelup_Info_All:additionalStatShowOff(lvdd, lvpv)
  PaGlobal_Levelup_Info_All:calculateStatBGResize(lvdd, lvpv)
  PaGlobal_Levelup_Info_All:CurrentState()
  PaGlobalFunc_Levelup_Info_All_SelfPlayerLevelUp_StatusDataSet(hp, mp, stun, weight, lvdd, lvpv)
  PaGlobal_Levelup_Info_All._ui._stcText_LearnSkillNoSkill:SetShow(true)
  PaGlobal_Levelup_Info_All._ui._stcText_LearnableNoSkill:SetShow(true)
  PaGlobal_Levelup_Info_All._ui._stc_LearnSkillArea:SetShow(false)
  PaGlobal_Levelup_Info_All._ui._frm_LearnableSkill:SetShow(false)
  PaGlobal_Levelup_Info_All._ui._frm_LearnableSkillContent:SetShow(false)
  PaGlobal_Levelup_Info_All._ui._frm_LearnableSkillScroll:SetShow(false)
  PaGlobal_Levelup_Info_All._ui._stcText_LearnSkillTitle:SetFontColor(Defines.Color.C_FFEE7001)
  PaGlobal_Levelup_Info_All._ui._stcText_LearnableSkillTitle:SetFontColor(Defines.Color.C_FFEE7001)
  PaGlobalFunc_Levelup_Info_All_SkillClear()
  PaGlobal_Levelup_Info_All._isLearnSkill = false
  PaGlobal_Levelup_Info_All._isLearnableSkill = false
  PaGlobal_Levelup_Info_All._isLevelUp = true
  PaGlobal_Levelup_Info_All._showTime = 0
  PaGlobal_Levelup_Info_All._mySkillPoint = getSelfPlayer():get():getRemainSkillPoint()
  if 0 < learnSkillCount then
    PaGlobal_Levelup_Info_All._isLearnSkill = true
    PaGlobal_Levelup_Info_All._maxLearnSkillIndex = learnSkillCount - 1
    PaGlobal_Levelup_Info_All._currentLearnSkillIndex = 0
    PaGlobal_Levelup_Info_All._ui._btn_quickSlotGo:SetShow(true)
    PaGlobal_Levelup_Info_All:updateLearnSkill(PaGlobal_Levelup_Info_All._currentLearnSkillIndex)
    PaGlobal_Levelup_Info_All._ui._stc_LearnSkillArea:SetShow(true)
    PaGlobal_Levelup_Info_All._ui._stcText_LearnSkillNoSkill:SetShow(false)
    PaGlobal_Levelup_Info_All._ui._stc_paging:SetShow(true)
  else
    PaGlobal_Levelup_Info_All._maxLearnSkillIndex = 0
    PaGlobal_Levelup_Info_All._ui._btn_quickSlotGo:SetShow(false)
    PaGlobal_Levelup_Info_All._ui._stc_paging:SetShow(false)
  end
  PaGlobal_Levelup_Info_All:calculateTopResize(PaGlobal_Levelup_Info_All._maxLearnSkillIndex)
  PaGlobal_Levelup_Info_All._maxLearnableSkillCount = learnableSkillCount
  if 0 < learnableSkillCount then
    PaGlobal_Levelup_Info_All._isLearnableSkill = true
    for j = 0, learnableSkillCount - 1 do
      local learnableSkillWrapper = ToClient_getCurrentLearnableSkill(j)
      if nil ~= learnableSkillWrapper then
        local isSkillNo = learnableSkillWrapper:getSkillNo()
        local needSkillPoint = learnableSkillWrapper:get()._needSkillPointForLearning
        PaGlobalFunc_Levelup_Info_All_LearnableSkillDataSet(isSkillNo, j, needSkillPoint)
      end
    end
    PaGlobal_Levelup_Info_All._ui._frm_LearnableSkill:SetShow(true)
    PaGlobal_Levelup_Info_All._ui._frm_LearnableSkillContent:SetShow(true)
  else
    PaGlobal_Levelup_Info_All:calculateBottomResize(0)
  end
  Panel_Window_LevelUp_Info_All:ComputePos()
  Panel_Window_LevelUp_Info_All:RegisterUpdateFunc("PaGlobalFunc_Levelup_Info_All_AutoTimerHide")
  PaGlobalFunc_Levelup_Info_All_Open()
end
function PaGlobalFunc_Levelup_Info_All_AutoTimerHide(deltaTime)
  if nil == Panel_Window_LevelUp_Info_All then
    return
  end
  if true == PaGlobal_Levelup_Info_All._isFoldCheck then
    Panel_Window_LevelUp_Info_All:ClearUpdateLuaFunc()
  end
  PaGlobal_Levelup_Info_All._showTime = PaGlobal_Levelup_Info_All._showTime + deltaTime
  if PaGlobal_Levelup_Info_All._autoHideTime < PaGlobal_Levelup_Info_All._showTime then
    HandleEventLUp_Levelup_Info_All_LeftOpen()
    Panel_Window_LevelUp_Info_All:ClearUpdateLuaFunc()
  end
end
function PaGlobalFunc_Levelup_Info_All_SelfPlayerLevelUp_StatusDataSet(hp, mp, stun, weight, lvdd, lvpv)
  if nil == Panel_Window_LevelUp_Info_All then
    return
  end
  UI.ASSERT_NAME(nil ~= hp, "PaGlobalFunc_Levelup_Info_All_SelfPlayerLevelUp_StatusDataSet hp nil", "\236\157\180\236\138\185\237\153\152")
  UI.ASSERT_NAME(nil ~= mp, "PaGlobalFunc_Levelup_Info_All_SelfPlayerLevelUp_StatusDataSet mp nil", "\236\157\180\236\138\185\237\153\152")
  UI.ASSERT_NAME(nil ~= weight, "PaGlobalFunc_Levelup_Info_All_SelfPlayerLevelUp_StatusDataSet weight nil", "\236\157\180\236\138\185\237\153\152")
  UI.ASSERT_NAME(nil ~= lvdd, "PaGlobalFunc_Levelup_Info_All_SelfPlayerLevelUp_StatusDataSet lvdd nil", "\236\157\180\236\138\185\237\153\152")
  UI.ASSERT_NAME(nil ~= lvpv, "PaGlobalFunc_Levelup_Info_All_SelfPlayerLevelUp_StatusDataSet lvpv nil", "\236\157\180\236\138\185\237\153\152")
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  local isLevel = selfPlayer:get():getLevel()
  local isMyClassType = selfPlayer:getClassType()
  PaGlobal_Levelup_Info_All._ui._stcText_TitleLevel:SetText(tostring(isLevel))
  PaGlobal_Levelup_Info_All._ui._stcText_TitleLevel:EraseAllEffect()
  if __eClassType_ElfRanger == isMyClassType or __eClassType_RangerMan == isMyClassType or __eClassType_ShyWaman == isMyClassType then
    PaGlobal_Levelup_Info_All._ui._stcText_MaxMpTitle:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_LEVELUP_INFO_MAXMPUP"))
  elseif isMyClassType == __eClassType_Warrior or isMyClassType == __eClassType_Giant or isMyClassType == __eClassType_Lhan or isMyClassType == __eClassType_Combattant or isMyClassType == __eClassType_Mystic or isMyClassType == __eClassType_BladeMaster or isMyClassType == __eClassType_BladeMasterWoman or isMyClassType == __eClassType_Kunoichi or isMyClassType == __eClassType_NinjaMan or isMyClassType == __eClassType_Guardian then
    PaGlobal_Levelup_Info_All._ui._stcText_MaxMpTitle:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_LEVELUP_INFO_MAXFPUP"))
  elseif isMyClassType == __eClassType_Sorcerer or isMyClassType == __eClassType_WizardWoman or isMyClassType == __eClassType_WizardMan or isMyClassType == __eClassType_Tamer or isMyClassType == __eClassType_DarkElf or isMyClassType == __eClassType_Hashashin then
    PaGlobal_Levelup_Info_All._ui._stcText_MaxMpTitle:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_LEVELUP_INFO_MAXMPUP"))
  elseif __eClassType_Valkyrie == isMyClassType then
    PaGlobal_Levelup_Info_All._ui._stcText_MaxMpTitle:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_LEVELUP_INFO_MAXBPUP"))
  else
    PaGlobal_Levelup_Info_All._ui._stcText_MaxMpTitle:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_LEVELUP_INFO_MAXFPUP"))
  end
  PaGlobal_Levelup_Info_All._ui._stcText_MaxHpValue:SetText(tostring(PaGlobal_Levelup_Info_All._maxHp - hp))
  PaGlobal_Levelup_Info_All._ui._stcText_IncreaseHpValue:SetText("<PAColor0xFF00C0D7>" .. tostring(PaGlobal_Levelup_Info_All._maxHp) .. "<PAOldColor><PAColor0xfff5ba3a>(+" .. hp .. ")<PAOldColor>")
  PaGlobal_Levelup_Info_All._ui._stcText_MaxMpValue:SetText(tostring(PaGlobal_Levelup_Info_All._maxMp - mp))
  PaGlobal_Levelup_Info_All._ui._stcText_IncreaseMpValue:SetText("<PAColor0xFF00C0D7>" .. tostring(PaGlobal_Levelup_Info_All._maxMp) .. "<PAOldColor><PAColor0xfff5ba3a>(+" .. mp .. ")<PAOldColor>")
  PaGlobal_Levelup_Info_All._ui._stcText_WeightValue:SetText(string.format("%.0f", Int64toInt32(PaGlobal_Levelup_Info_All._maxWeight - weight) / 10000))
  if weight > Defines.s64_const.s64_0 then
    PaGlobal_Levelup_Info_All._ui._stcText_IncreaseWeightValue:SetText("<PAColor0xFF00C0D7>" .. string.format("%.0f", Int64toInt32(PaGlobal_Levelup_Info_All._maxWeight) / 10000) .. "<PAOldColor><PAColor0xfff5ba3a>(+" .. string.format("%.0f", Int64toInt32(weight) / 10000) .. ")<PAOldColor>")
  end
  if 0 ~= lvdd then
    PaGlobal_Levelup_Info_All._ui._stcText_AttTitle:SetShow(true)
    PaGlobal_Levelup_Info_All._ui._stc_AttArrow:SetShow(true)
    PaGlobal_Levelup_Info_All._ui._stcText_PreAttValue:SetText(tostring(PaGlobal_Levelup_Info_All._maxAtt - lvdd))
    PaGlobal_Levelup_Info_All._ui._stcText_IncreaseAttValue:SetText("<PAColor0xFF00C0D7>" .. PaGlobal_Levelup_Info_All._maxAtt .. "<PAOldColor><PAColor0xfff5ba3a>(+" .. lvdd .. ")<PAOldColor>")
  end
  if 0 ~= lvpv then
    PaGlobal_Levelup_Info_All._ui._stcText_DefTitle:SetShow(true)
    PaGlobal_Levelup_Info_All._ui._stc_DefArrow:SetShow(true)
    PaGlobal_Levelup_Info_All._ui._stcText_PreDefValue:SetText(tostring(PaGlobal_Levelup_Info_All._maxDef - lvpv))
    PaGlobal_Levelup_Info_All._ui._stcText_IncreaseDefValue:SetText("<PAColor0xFF00C0D7>" .. PaGlobal_Levelup_Info_All._maxDef .. "<PAOldColor><PAColor0xfff5ba3a>(+" .. lvpv .. ")<PAOldColor>")
  end
end
function PaGlobalFunc_Levelup_Info_All_SkillClear()
  if nil == Panel_Window_LevelUp_Info_All then
    return
  end
  PaGlobal_Levelup_Info_All._ui._stc_LearnSkillArea:SetShow(false)
  for index, value in pairs(PaGlobal_Levelup_Info_All._learnableSkillBG) do
    value:SetShow(false)
  end
end
function PaGlobal_Levelup_Info_All_UpdateLearnSkillData(skillNo, index)
  local skillTypeStaticWrapper = getSkillTypeStaticStatus(skillNo)
  if nil == skillTypeStaticWrapper then
    return
  end
  PaGlobal_Levelup_Info_All._currentLearnSkillIndex = index
  PaGlobal_Levelup_Info_All._ui._txt_learnSkillName:SetShow(true)
  PaGlobal_Levelup_Info_All._ui._txt_learnSkillName:SetTextMode(__eTextMode_AutoWrap)
  PaGlobal_Levelup_Info_All._ui._txt_learnSkillName:SetText(skillTypeStaticWrapper:getName())
  PaGlobal_Levelup_Info_All._ui._stc_learnSkillIcon:SetShow(true)
  PaGlobal_Levelup_Info_All._ui._stc_learnSkillIcon:ChangeTextureInfoNameAsync("Icon/" .. skillTypeStaticWrapper:getIconPath())
  PaGlobal_Levelup_Info_All._ui._stc_learnSkillIcon:addInputEvent("Mouse_LUp", "HandleEventLUp_LevelUp_Info_All_LearnableSkillGotoFocusEffect(" .. skillNo .. ")")
  PaGlobal_Levelup_Info_All._ui._stc_learnSkillIcon:addInputEvent("Mouse_On", "Panel_SkillTooltip_Show(" .. skillNo .. ", false, \"LevelupInfoLearn\", false)")
  PaGlobal_Levelup_Info_All._ui._stc_learnSkillIcon:addInputEvent("Mouse_Out", "Panel_SkillTooltip_Hide()")
  Panel_SkillTooltip_SetPosition(skillNo, PaGlobal_Levelup_Info_All._ui._stc_learnSkillIcon, "LevelupInfoLearn")
  PaGlobal_Levelup_Info_All._ui._txt_learnSkillCommand:SetText(skillTypeStaticWrapper:getCommand())
  UI.setLimitAutoWrapTextAndAddTooltip(PaGlobal_Levelup_Info_All._ui._txt_learnSkillCommand, 3)
  if true == PaGlobal_Levelup_Info_All_IsLearnSkillAddQuickSlot(skillNo) then
    PaGlobal_Levelup_Info_All:updateButtonQuickSlotGo(false)
    PaGlobal_Levelup_Info_All._ui._btn_quickSlotGo:addInputEvent("Mouse_LUp", "HandleEventLUp_LevelUp_Info_All_LearnSkillAddQuickSlot(" .. skillNo .. ")")
  else
    PaGlobal_Levelup_Info_All:updateButtonQuickSlotGo(true)
  end
  PaGlobal_Levelup_Info_All._ui._btn_learnLeftArrow:SetShow(true)
  PaGlobal_Levelup_Info_All._ui._btn_learnRightArrow:SetShow(true)
  if 0 == index then
    PaGlobal_Levelup_Info_All._ui._btn_learnLeftArrow:SetShow(false)
  end
  if index == PaGlobal_Levelup_Info_All._maxLearnSkillIndex then
    PaGlobal_Levelup_Info_All._ui._btn_learnRightArrow:SetShow(false)
  end
end
function PaGlobalFunc_Levelup_Info_All_LearnableSkillDataSet(skillNo, index, needSkillPoint)
  if nil == Panel_Window_LevelUp_Info_All then
    return
  end
  UI.ASSERT_NAME(nil ~= skillNo, "skillNo\234\176\128 nil\236\158\133\235\139\136\235\139\164.", "\236\157\180\236\138\185\237\153\152")
  UI.ASSERT_NAME(nil ~= index, "index\234\176\128 nil\236\158\133\235\139\136\235\139\164.", "\236\157\180\236\138\185\237\153\152")
  PaGlobal_Levelup_Info_All._ui._stcText_LearnableNoSkill:SetShow(false)
  local posIndex = index - 1
  local skillTypeStaticWrapper = getSkillTypeStaticStatus(skillNo)
  PaGlobal_Levelup_Info_All:calculateBottomResize(index)
  PaGlobal_Levelup_Info_All._ui._frm_LearnableSkillScroll:SetControlTop()
  PaGlobal_Levelup_Info_All._ui._stc_Unfold:ComputePos()
  PaGlobal_Levelup_Info_All._learnableSkillBG[index]:SetShow(true)
  local skillIcon = UI.getChildControl(PaGlobal_Levelup_Info_All._learnableSkillBG[index], "Static_LearnableSkillIcon")
  skillIcon:SetShow(true)
  skillIcon:ChangeTextureInfoNameAsync("Icon/" .. skillTypeStaticWrapper:getIconPath())
  skillIcon:addInputEvent("Mouse_LUp", "HandleEventLUp_LevelUp_Info_All_LearnableSkillGotoFocusEffect(" .. skillNo .. ")")
  skillIcon:addInputEvent("Mouse_On", "Panel_SkillTooltip_Show(" .. skillNo .. ", false, \"LevelupInfoLearnable\", false)")
  skillIcon:addInputEvent("Mouse_Out", "Panel_SkillTooltip_Hide()")
  Panel_SkillTooltip_SetPosition(skillNo, skillIcon, "LevelupInfoLearnable")
  local skillName = UI.getChildControl(PaGlobal_Levelup_Info_All._learnableSkillBG[index], "StaticText_LearnableSkillName")
  skillName:SetShow(true)
  skillName:SetTextMode(__eTextMode_AutoWrap)
  skillName:SetText(tostring(skillTypeStaticWrapper:getName()))
  local btn_learn = UI.getChildControl(PaGlobal_Levelup_Info_All._learnableSkillBG[index], "Button_Learn")
  local txt_enable = UI.getChildControl(PaGlobal_Levelup_Info_All._learnableSkillBG[index], "StaticText_enableSkill")
  if needSkillPoint > PaGlobal_Levelup_Info_All._mySkillPoint then
    btn_learn:SetShow(false)
    txt_enable:SetShow(true)
  else
    btn_learn:SetShow(true)
    txt_enable:SetShow(false)
    btn_learn:addInputEvent("Mouse_LUp", "HandleEventLUp_LevelUp_Info_All_StudyLearnSkill(" .. skillNo .. ")")
  end
  PaGlobal_Levelup_Info_All._ui._frm_LearnableSkillScroll:SetInterval(index)
end
function PaGlobalFunc_Levelup_Info_All_ForceLeftClose()
  if nil == Panel_Window_LevelUp_Info_All then
    return
  end
  local moveAni2 = Panel_Window_LevelUp_Info_All:addMoveAnimation(0, 0.3, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_SQUARE)
  moveAni2:SetStartPosition(getScreenSizeX() - Panel_Window_LevelUp_Info_All:GetSizeX() - 20, getScreenSizeY() - Panel_Window_LevelUp_Info_All:GetSizeY() - 30)
  moveAni2:SetEndPosition(getScreenSizeX(), getScreenSizeY() - Panel_Window_LevelUp_Info_All:GetSizeY() - 30)
  moveAni2:SetHideAtEnd(false)
  moveAni2:SetDisableWhileAni(true)
  local x1, y1, x2, y2 = setTextureUV_Func(PaGlobal_Levelup_Info_All._ui._btn_Unfold, 94, 83, 117, 123)
  PaGlobal_Levelup_Info_All._ui._btn_Unfold:getBaseTexture():setUV(x1, y1, x2, y2)
  x1, y1, x2, y2 = setTextureUV_Func(PaGlobal_Levelup_Info_All._ui._btn_Unfold, 118, 83, 141, 123)
  PaGlobal_Levelup_Info_All._ui._btn_Unfold:getOnTexture():setUV(x1, y1, x2, y2)
  x1, y1, x2, y2 = setTextureUV_Func(PaGlobal_Levelup_Info_All._ui._btn_Unfold, 142, 83, 165, 123)
  PaGlobal_Levelup_Info_All._ui._btn_Unfold:getClickTexture():setUV(x1, y1, x2, y2)
  PaGlobal_Levelup_Info_All._ui._btn_Unfold:setRenderTexture(PaGlobal_Levelup_Info_All._ui._btn_Unfold:getBaseTexture())
  PaGlobal_Levelup_Info_All._isFoldCheck = true
end
function PaGlobal_Levelup_Info_All_IsLearnSkillAddQuickSlot(skillNo)
  local skillLevelInfo = getSkillLevelInfo(skillNo)
  if nil == skillLevelInfo then
    return false
  end
  local skillTypeStaticWrapper = getSkillTypeStaticStatus(skillNo)
  if nil == skillTypeStaticWrapper then
    return false
  end
  if true == skillLevelInfo._learnable or false == skillLevelInfo._usable or false == skillTypeStaticWrapper:get()._isSettableQuickSlot then
    return false
  end
  return true
end
function HandleEventLUp_LevelUp_Info_All_LearnSkillAddQuickSlot(skillNo)
  local skillLevelInfo = getSkillLevelInfo(skillNo)
  if nil == skillLevelInfo then
    return
  end
  local skillTypeStaticWrapper = getSkillTypeStaticStatus(skillNo)
  if nil == skillTypeStaticWrapper then
    return
  end
  if true == skillLevelInfo._learnable or false == skillLevelInfo._usable or false == skillTypeStaticWrapper:get()._isSettableQuickSlot then
    return
  end
  local addIndex
  for i = 0, 9 do
    local quickSlotInfo = getQuickSlotItem(i)
    if CppEnums.QuickSlotType.eEmpty == quickSlotInfo._type then
      addIndex = i
      break
    end
  end
  if nil == addIndex then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_LEVELUP_INFO_SKILL_QUICKSLOT_FAIL"))
    return
  end
  quickSlot_RegistSkill(addIndex, skillLevelInfo._skillKey:get())
end
function HandleEventLUp_LevelUp_Info_All_LearnableSkillGotoFocusEffect(skillNo)
  local skill = getSkillStaticStatus(skillNo, 1)
  if nil == skill then
    return
  end
  local skillType = skill:getSkillAwakenBranchType()
  if false == _ContentsGroup_UISkillGroupTreeLayOut then
    PaGlobal_SkillWindow_OpenForLearn(PaGlobal_SkillWindow_GetConvertTabIndex(skillType))
  else
    PaGlobal_SkillGroup:OpenForLearn(PaGlobal_SkillGroup:GetConvertTabIndex(skillType))
  end
  PaGlobal_SkillWindow_SkillFocusEffect(skillNo, true)
end
function HandleEventLUp_LevelUp_Info_All_LearnSkillArrow(isLeft)
  if true == isLeft then
    if 0 < PaGlobal_Levelup_Info_All._currentLearnSkillIndex then
      PaGlobal_Levelup_Info_All:updateLearnSkill(PaGlobal_Levelup_Info_All._currentLearnSkillIndex - 1)
    end
  elseif PaGlobal_Levelup_Info_All._currentLearnSkillIndex < PaGlobal_Levelup_Info_All._maxLearnSkillIndex then
    PaGlobal_Levelup_Info_All:updateLearnSkill(PaGlobal_Levelup_Info_All._currentLearnSkillIndex + 1)
  end
end
function HandleEventLUp_LevelUp_Info_All_StudyLearnSkill(skillNo)
  local skill = getSkillStaticStatus(skillNo, 1)
  if nil == skill then
    return
  end
  if true == skill:isFusionSkill() then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_LEVELUP_INFO_SKILL_FUSIONSKILL"))
    return
  end
  if true == ToClient_isLearnedSkill(skillNo) then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_LEVELUPSKILL_LEARNABLE"))
    return
  end
  local skillType = skill:getSkillAwakenBranchType()
  if false == _ContentsGroup_UISkillGroupTreeLayOut then
    PaGlobal_SkillWindow_OpenForLearn(PaGlobal_SkillWindow_GetConvertTabIndex(skillType))
  else
    PaGlobal_SkillGroup:OpenForLearn(PaGlobal_SkillGroup:GetConvertTabIndex(skillType))
  end
  local skillTypeStaticWrapper = getSkillTypeStaticStatus(skillNo)
  if nil == skillTypeStaticWrapper then
    return
  end
  local skillLevelInfo = getSkillLevelInfo(skillNo)
  if nil == skillLevelInfo then
    return
  end
  local learnedSkillLevel = getLearnedSkillLevel(skillTypeStaticWrapper)
  if false == skillLevelInfo._learnable and 0 == learnedSkillLevel then
  elseif false == _ContentsGroup_UISkillGroupTreeLayOut then
    HandleMLUp_SkillWindow_LearnButtonClick(skillNo)
  else
    PaGlobal_SkillGroup:HandleEventLUpLearnSkill(skillNo)
  end
  PaGlobal_SkillWindow_SkillFocusEffect(skillNo, true)
end
function FromClient_LevelUp_Info_All_ScreenResize()
  PaGlobal_Levelup_Info_All:updateScreenResize()
end
