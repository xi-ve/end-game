function ToClient_SelfPlayerLevelUp_StatusDataSet(hp, mp, stun, weight, lvdd, lvpv)
  if false == _ContentsGroup_LevelupInfo then
    return
  end
  if nil == Panel_Levelup_Info then
    return
  end
  if nil == hp then
    UI.ASSERT_NAME(nil ~= hp, "ToClient_SelfPlayerLevelUp_StatusDataSet hp nil", "\236\154\176\236\160\149\235\172\180")
  end
  if nil == mp then
    UI.ASSERT_NAME(nil ~= mp, "ToClient_SelfPlayerLevelUp_StatusDataSet mp nil", "\236\154\176\236\160\149\235\172\180")
  end
  if nil == weight then
    UI.ASSERT_NAME(nil ~= weight, "ToClient_SelfPlayerLevelUp_StatusDataSet weight nil", "\236\154\176\236\160\149\235\172\180")
  end
  if nil == lvdd then
    UI.ASSERT_NAME(nil ~= lvdd, "ToClient_SelfPlayerLevelUp_StatusDataSet lvdd nil", "\236\154\176\236\160\149\235\172\180")
    return
  end
  if nil == lvpv then
    UI.ASSERT_NAME(nil ~= lvpv, "ToClient_SelfPlayerLevelUp_StatusDataSet lvpv nil", "\236\154\176\236\160\149\235\172\180")
    return
  end
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  local isLevel = selfPlayer:get():getLevel()
  local isMyClassType = selfPlayer:getClassType()
  PaGlobal_LevelupInfo._ui._txt_titleLevel:SetText(tostring(isLevel))
  PaGlobal_LevelupInfo._ui._txt_titleLevel:EraseAllEffect()
  if __eClassType_ElfRanger == isMyClassType or __eClassType_RangerMan == isMyClassType or __eClassType_ShyWaman == isMyClassType then
    PaGlobal_LevelupInfo._ui._txt_maxMpTitle:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_LEVELUP_INFO_MAXMPUP"))
  elseif isMyClassType == __eClassType_Warrior or isMyClassType == __eClassType_Giant or isMyClassType == __eClassType_Lhan or isMyClassType == __eClassType_Combattant or isMyClassType == __eClassType_Mystic or isMyClassType == __eClassType_BladeMaster or isMyClassType == __eClassType_BladeMasterWoman or isMyClassType == __eClassType_Kunoichi or isMyClassType == __eClassType_NinjaMan or isMyClassType == __eClassType_Guardian then
    PaGlobal_LevelupInfo._ui._txt_maxMpTitle:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_LEVELUP_INFO_MAXFPUP"))
  elseif isMyClassType == __eClassType_Sorcerer or isMyClassType == __eClassType_WizardWoman or isMyClassType == __eClassType_WizardMan or isMyClassType == __eClassType_Tamer or isMyClassType == __eClassType_DarkElf then
    PaGlobal_LevelupInfo._ui._txt_maxMpTitle:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_LEVELUP_INFO_MAXMPUP"))
  elseif __eClassType_Valkyrie == isMyClassType then
    PaGlobal_LevelupInfo._ui._txt_maxMpTitle:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_LEVELUP_INFO_MAXBPUP"))
  else
    PaGlobal_LevelupInfo._ui._txt_maxMpTitle:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_LEVELUP_INFO_MAXFPUP"))
  end
  PaGlobal_LevelupInfo._ui._txt_maxHpValue:SetText(tostring(PaGlobal_LevelupInfo._maxHp - hp))
  PaGlobal_LevelupInfo._ui._txt_increaseHpValue:SetText("<PAColor0xFF00C0D7>" .. tostring(PaGlobal_LevelupInfo._maxHp) .. "<PAOldColor><PAColor0xfff5ba3a>(+" .. hp .. ")<PAOldColor>")
  PaGlobal_LevelupInfo._ui._txt_maxMpValue:SetText(tostring(PaGlobal_LevelupInfo._maxMp - mp))
  PaGlobal_LevelupInfo._ui._txt_increaseMpValue:SetText("<PAColor0xFF00C0D7>" .. tostring(PaGlobal_LevelupInfo._maxMp) .. "<PAOldColor><PAColor0xfff5ba3a>(+" .. mp .. ")<PAOldColor>")
  PaGlobal_LevelupInfo._ui._txt_weightValue:SetText(string.format("%.0f", Int64toInt32(PaGlobal_LevelupInfo._maxWeight - weight) / 10000))
  if weight > Defines.s64_const.s64_0 then
    PaGlobal_LevelupInfo._ui._txt_increaseWeightValue:SetText("<PAColor0xFF00C0D7>" .. string.format("%.0f", Int64toInt32(PaGlobal_LevelupInfo._maxWeight) / 10000) .. "<PAOldColor><PAColor0xfff5ba3a>(+" .. string.format("%.0f", Int64toInt32(weight) / 10000) .. ")<PAOldColor>")
  end
  if 0 ~= lvdd then
    PaGlobal_LevelupInfo._ui._txt_attTitle:SetShow(true)
    PaGlobal_LevelupInfo._ui._stc_attArrow:SetShow(true)
    PaGlobal_LevelupInfo._ui._txt_preAttValue:SetText(tostring(PaGlobal_LevelupInfo._maxAtt - lvdd))
    PaGlobal_LevelupInfo._ui._txt_increaseAttValue:SetText("<PAColor0xFF00C0D7>" .. PaGlobal_LevelupInfo._maxAtt .. "<PAOldColor><PAColor0xfff5ba3a>(+" .. lvdd .. ")<PAOldColor>")
  end
  if 0 ~= lvpv then
    PaGlobal_LevelupInfo._ui._txt_defTitle:SetShow(true)
    PaGlobal_LevelupInfo._ui._stc_defArrow:SetShow(true)
    PaGlobal_LevelupInfo._ui._txt_preDefValue:SetText(tostring(PaGlobal_LevelupInfo._maxDef - lvpv))
    PaGlobal_LevelupInfo._ui._txt_increaseDefValue:SetText("<PAColor0xFF00C0D7>" .. PaGlobal_LevelupInfo._maxDef .. "<PAOldColor><PAColor0xfff5ba3a>(+" .. lvpv .. ")<PAOldColor>")
  end
end
function FromClient_SelfPlayerCurrentLevelInfo(learnableSkillCount, learnSkillCount, hp, mp, stun, weight, lvdd, lvpv)
  if nil == Panel_Levelup_Info then
    return
  end
  if nil == learnSkillCount then
    UI.ASSERT_NAME(nil ~= learnSkillCount, "FromClient_SelfPlayerCurrentLevelInfo learnSkillCount nil", "\236\154\176\236\160\149\235\172\180")
    return
  end
  if nil == learnableSkillCount then
    UI.ASSERT_NAME(nil ~= learnableSkillCount, "FromClient_SelfPlayerCurrentLevelInfo learnableSkillCount nil", "\236\154\176\236\160\149\235\172\180")
    return
  end
  if nil == hp then
    UI.ASSERT_NAME(nil ~= hp, "FromClient_SelfPlayerCurrentLevelInfo hp nil", "\236\154\176\236\160\149\235\172\180")
    return
  end
  if nil == mp then
    UI.ASSERT_NAME(nil ~= mp, "FromClient_SelfPlayerCurrentLevelInfo mp nil", "\236\154\176\236\160\149\235\172\180")
    return
  end
  if nil == weight then
    UI.ASSERT_NAME(nil ~= weight, "FromClient_SelfPlayerCurrentLevelInfo weight nil", "\236\154\176\236\160\149\235\172\180")
    return
  end
  if nil == lvdd then
    UI.ASSERT_NAME(nil ~= lvdd, "FromClient_SelfPlayerCurrentLevelInfo lvdd nil", "\236\154\176\236\160\149\235\172\180")
    return
  end
  if nil == lvpv then
    UI.ASSERT_NAME(nil ~= lvpv, "FromClient_SelfPlayerCurrentLevelInfo lvpv nil", "\236\154\176\236\160\149\235\172\180")
    return
  end
  local playerLevel = getSelfPlayer():get():getLevel()
  if 56 ~= playerLevel then
    lvpv = 0
  end
  if 60 ~= playerLevel then
    lvdd = 0
  end
  PaGlobal_LevelupInfo:additionalStatShowOff(lvdd, lvpv)
  PaGlobal_LevelupInfo:calculateStatResize(lvdd, lvpv)
  PaGlobal_LevelupInfo:CurrentState()
  ToClient_SelfPlayerLevelUp_StatusDataSet(hp, mp, stun, weight, lvdd, lvpv)
  PaGlobal_LevelupInfo._ui._txt_learnSkillNoSkill:SetShow(false)
  PaGlobal_LevelupInfo._ui._txt_learnableSkillNoSkill:SetShow(false)
  PaGlobal_LevelupInfo._ui._frm_learnSkill:SetShow(false)
  PaGlobal_LevelupInfo._ui._frm_learnSkillContent:SetShow(false)
  PaGlobal_LevelupInfo._ui._frm_learnableSkill:SetShow(false)
  PaGlobal_LevelupInfo._ui._frm_learnableSkillContent:SetShow(false)
  PaGlobal_LevelupInfo._ui._frm_learnSkillScroll:SetShow(false)
  PaGlobal_LevelupInfo._ui._frm_learnableSkillScroll:SetShow(false)
  PaGlobal_LevelupInfo._ui._txt_learnSkillTitle:SetFontColor(Defines.Color.C_FFEE7001)
  PaGlobal_LevelupInfo._ui._txt_learnableSkillTitle:SetFontColor(Defines.Color.C_FFEE7001)
  PaGlobal_LevelupInfo_SkillClear(0)
  PaGlobal_LevelupInfo_SkillClear(1)
  if 0 == learnSkillCount then
    PaGlobal_LevelupInfo._ui._txt_learnSkillNoSkill:SetShow(true)
  end
  if 0 == learnableSkillCount then
    PaGlobal_LevelupInfo._ui._txt_learnableSkillNoSkill:SetShow(true)
  end
  if 3 < learnSkillCount then
    PaGlobal_LevelupInfo._ui._frm_learnSkillScroll:SetShow(true)
  end
  if 3 < learnableSkillCount then
    PaGlobal_LevelupInfo._ui._frm_learnableSkillScroll:SetShow(true)
  end
  if 0 < learnSkillCount then
    for i = 0, learnSkillCount - 1 do
      local learnSkillWrapper = ToClient_getCurrentLearnedSkill(i)
      if nil ~= learnSkillWrapper then
        local isKey = learnSkillWrapper:getKey()
        local isSkillNo = learnSkillWrapper:getSkillNo()
        local isSkillName = learnSkillWrapper:getName()
        PaGlobal_LevelupInfo_LearnSkillDataSet(isSkillNo, i)
      end
    end
    PaGlobal_LevelupInfo._ui._frm_learnSkill:SetShow(true)
    PaGlobal_LevelupInfo._ui._frm_learnSkillContent:SetShow(true)
  else
    PaGlobal_LevelupInfo:calculateTopResize(0)
  end
  if 0 < learnableSkillCount then
    for j = 0, learnableSkillCount - 1 do
      local learnableSkillWrapper = ToClient_getCurrentLearnableSkill(j)
      if nil ~= learnableSkillWrapper then
        local isKey = learnableSkillWrapper:getKey()
        local isSkillNo = learnableSkillWrapper:getSkillNo()
        local isSkillName = learnableSkillWrapper:getName()
        PaGlobal_LevelupInfo_LearnableSkillDataSet(isSkillNo, j)
      end
    end
    PaGlobal_LevelupInfo._ui._frm_learnableSkill:SetShow(true)
    PaGlobal_LevelupInfo._ui._frm_learnableSkillContent:SetShow(true)
  else
    PaGlobal_LevelupInfo:calculateBottomResize(0)
  end
  Panel_Levelup_Info:ComputePos()
  PaGlobal_LevelupInfo_Open()
end
function PaGlobal_LevelupInfo_LeftOpenTooltip(isShow)
  if false == isShow then
    TooltipSimple_Hide()
    return
  end
  local name, desc, control
  name = PAGetString(Defines.StringSheet_GAME, "LUA_LEVELUPINFO_LEFTOPEN_TOOLTIP_TITLE")
  desc = PAGetString(Defines.StringSheet_GAME, "LUA_LEVELUPINFO_LEFTOPEN_TOOLTIP_DESC")
  control = PaGlobal_LevelupInfo._ui._btn_unfold
  TooltipSimple_Show(control, name, desc)
end
function PaGlobal_LevelupInfo_ShowAni()
  if nil == Panel_Levelup_Info then
    return
  end
end
function PaGlobal_LevelupInfo_HideAni()
  if nil == Panel_Levelup_Info then
    return
  end
end
function PaGlobal_LevelupInfo_Open()
  if false == _ContentsGroup_LevelupInfo then
    return
  end
  if nil == Panel_Levelup_Info then
    return
  end
  PaGlobal_LevelupInfo:CurrentState()
  PaGlobal_LevelupInfo:prepareOpen()
end
function PaGlobal_LevelupInfo_LeftOpen()
  PaGlobal_LevelupInfo._ui._btn_unfold:ChangeTextureInfoName("Combine/Btn/Combine_Btn_00.dds")
  if false == PaGlobal_LevelupInfo._isFoldCheck then
    local moveAni2 = Panel_Levelup_Info:addMoveAnimation(0, 0.3, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_SQUARE)
    moveAni2:SetStartPosition(getScreenSizeX() - Panel_Levelup_Info:GetSizeX() - 20, getScreenSizeY() - Panel_Levelup_Info:GetSizeY() - 30)
    moveAni2:SetEndPosition(getScreenSizeX(), getScreenSizeY() - Panel_Levelup_Info:GetSizeY() - 30)
    moveAni2:SetHideAtEnd(false)
    moveAni2:SetDisableWhileAni(true)
    local x1, y1, x2, y2 = setTextureUV_Func(PaGlobal_LevelupInfo._ui._btn_unfold, 94, 83, 117, 123)
    PaGlobal_LevelupInfo._ui._btn_unfold:getBaseTexture():setUV(x1, y1, x2, y2)
    local x1, y1, x2, y2 = setTextureUV_Func(PaGlobal_LevelupInfo._ui._btn_unfold, 118, 83, 141, 123)
    PaGlobal_LevelupInfo._ui._btn_unfold:getOnTexture():setUV(x1, y1, x2, y2)
    local x1, y1, x2, y2 = setTextureUV_Func(PaGlobal_LevelupInfo._ui._btn_unfold, 142, 83, 165, 123)
    PaGlobal_LevelupInfo._ui._btn_unfold:getClickTexture():setUV(x1, y1, x2, y2)
    PaGlobal_LevelupInfo._ui._btn_unfold:setRenderTexture(PaGlobal_LevelupInfo._ui._btn_unfold:getBaseTexture())
    PaGlobal_LevelupInfo._isFoldCheck = true
  else
    local moveAni2 = Panel_Levelup_Info:addMoveAnimation(0, 0.3, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_SQUARE)
    moveAni2:SetStartPosition(getScreenSizeX(), getScreenSizeY() - Panel_Levelup_Info:GetSizeY() - 30)
    moveAni2:SetEndPosition(getScreenSizeX() - Panel_Levelup_Info:GetSizeX() - 20, getScreenSizeY() - Panel_Levelup_Info:GetSizeY() - 30)
    moveAni2:SetHideAtEnd(false)
    moveAni2:SetDisableWhileAni(true)
    local x1, y1, x2, y2 = setTextureUV_Func(PaGlobal_LevelupInfo._ui._btn_unfold, 94, 124, 117, 164)
    PaGlobal_LevelupInfo._ui._btn_unfold:getBaseTexture():setUV(x1, y1, x2, y2)
    local x1, y1, x2, y2 = setTextureUV_Func(PaGlobal_LevelupInfo._ui._btn_unfold, 118, 124, 141, 164)
    PaGlobal_LevelupInfo._ui._btn_unfold:getOnTexture():setUV(x1, y1, x2, y2)
    local x1, y1, x2, y2 = setTextureUV_Func(PaGlobal_LevelupInfo._ui._btn_unfold, 142, 124, 165, 164)
    PaGlobal_LevelupInfo._ui._btn_unfold:getClickTexture():setUV(x1, y1, x2, y2)
    PaGlobal_LevelupInfo._ui._btn_unfold:setRenderTexture(PaGlobal_LevelupInfo._ui._btn_unfold:getBaseTexture())
    PaGlobal_LevelupInfo._isFoldCheck = false
  end
end
function PaGlobal_LevelupInfo_ForceLeftClose()
  local moveAni2 = Panel_Levelup_Info:addMoveAnimation(0, 0.3, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_SQUARE)
  moveAni2:SetStartPosition(getScreenSizeX() - Panel_Levelup_Info:GetSizeX() - 20, getScreenSizeY() - Panel_Levelup_Info:GetSizeY() - 30)
  moveAni2:SetEndPosition(getScreenSizeX(), getScreenSizeY() - Panel_Levelup_Info:GetSizeY() - 30)
  moveAni2:SetHideAtEnd(false)
  moveAni2:SetDisableWhileAni(true)
  local x1, y1, x2, y2 = setTextureUV_Func(PaGlobal_LevelupInfo._ui._btn_unfold, 94, 83, 117, 123)
  PaGlobal_LevelupInfo._ui._btn_unfold:getBaseTexture():setUV(x1, y1, x2, y2)
  local x1, y1, x2, y2 = setTextureUV_Func(PaGlobal_LevelupInfo._ui._btn_unfold, 118, 83, 141, 123)
  PaGlobal_LevelupInfo._ui._btn_unfold:getOnTexture():setUV(x1, y1, x2, y2)
  local x1, y1, x2, y2 = setTextureUV_Func(PaGlobal_LevelupInfo._ui._btn_unfold, 142, 83, 165, 123)
  PaGlobal_LevelupInfo._ui._btn_unfold:getClickTexture():setUV(x1, y1, x2, y2)
  PaGlobal_LevelupInfo._ui._btn_unfold:setRenderTexture(PaGlobal_LevelupInfo._ui._btn_unfold:getBaseTexture())
  PaGlobal_LevelupInfo._isFoldCheck = true
end
function PaGlobal_LevelupInfo_Close()
  if nil == Panel_Levelup_Info then
    return
  end
  PaGlobal_LevelupInfo:CurrentState()
  PaGlobal_LevelupInfo:prepareClose()
end
function PaGlobal_LevelupInfo_SkillClear(skillType)
  if false == _ContentsGroup_LevelupInfo then
    return
  end
  if nil == Panel_Levelup_Info then
    return
  end
  if 0 == skillType then
    for index, value in pairs(PaGlobal_LevelupInfo._skillBG) do
      value:SetShow(false)
    end
  elseif 1 == skillType then
    for index, value in pairs(PaGlobal_LevelupInfo._learnableSkillBG) do
      value:SetShow(false)
    end
  end
  Panel_Levelup_Info:SetSize(330, 325)
end
function PaGlobal_LevelupInfo_LearnSkillDataSet(skillNo, index)
  if nil == Panel_Levelup_Info then
    return
  end
  if nil == skillNo then
    UI_ASSERT_NAME(nil ~= skillNo, "skillNo\234\176\128 nil\236\157\180\235\169\180 \236\149\136\235\144\1341", "\236\160\149\237\131\156\234\179\164")
    return
  end
  PaGlobal_LevelupInfo._ui._txt_learnSkillNoSkill:SetShow(false)
  local posIndex = index - 1
  local skillTypeStaticWrapper = getSkillTypeStaticStatus(skillNo)
  PaGlobal_LevelupInfo:calculateTopResize(index)
  PaGlobal_LevelupInfo._ui._stc_unfold:ComputePos()
  PaGlobal_LevelupInfo._ui._frm_learnSkillScroll:SetControlTop()
  PaGlobal_LevelupInfo._skillBG[index]:SetShow(true)
  local skillIcon = UI.getChildControl(PaGlobal_LevelupInfo._skillBG[index], "Static_LearnSkillIcon")
  skillIcon:SetShow(true)
  skillIcon:ChangeTextureInfoNameAsync("Icon/" .. skillTypeStaticWrapper:getIconPath())
  skillIcon:SetPosX(10)
  skillIcon:SetPosY(0)
  skillIcon:addInputEvent("Mouse_On", "Panel_SkillTooltip_Show(" .. skillNo .. ", false, \"LevelupInfoLearn\", false)")
  skillIcon:addInputEvent("Mouse_Out", "Panel_SkillTooltip_Hide()")
  Panel_SkillTooltip_SetPosition(skillNo, skillIcon, "LevelupInfoLearn")
  local skillName = UI.getChildControl(PaGlobal_LevelupInfo._skillBG[index], "StaticText_LearnSkillName")
  skillName:SetShow(true)
  skillName:SetTextMode(__eTextMode_AutoWrap)
  skillName:SetText(tostring(skillTypeStaticWrapper:getName()))
  skillName:SetPosX(skillIcon:GetPosX() + skillIcon:GetSizeX() + 10)
  PaGlobal_LevelupInfo._ui._frm_learnSkillScroll:SetInterval(index)
end
function PaGlobal_LevelupInfo_LearnableSkillDataSet(skillNo, index)
  if false == _ContentsGroup_LevelupInfo then
    return
  end
  if nil == Panel_Levelup_Info then
    return
  end
  if nil == skillNo then
    UI_ASSERT_NAME(nil ~= skillNo, "skillNo\234\176\128 nil\236\157\180\235\169\180 \236\149\136\235\144\1342", "\236\160\149\237\131\156\234\179\164")
    return
  end
  if nil == index then
    UI_ASSERT_NAME(nil ~= index, "index\234\176\128 nil\236\157\180\235\169\180 \236\149\136\235\144\1342", "\236\160\149\237\131\156\234\179\164")
    return
  end
  PaGlobal_LevelupInfo._ui._txt_learnableSkillNoSkill:SetShow(false)
  local posIndex = index - 1
  local skillTypeStaticWrapper = getSkillTypeStaticStatus(skillNo)
  PaGlobal_LevelupInfo:calculateBottomResize(index)
  PaGlobal_LevelupInfo._ui._frm_learnableSkillScroll:SetControlTop()
  PaGlobal_LevelupInfo._ui._stc_unfold:ComputePos()
  PaGlobal_LevelupInfo._learnableSkillBG[index]:SetShow(true)
  local skillIcon = UI.getChildControl(PaGlobal_LevelupInfo._learnableSkillBG[index], "Static_LearnableSkillIcon")
  skillIcon:SetShow(true)
  skillIcon:ChangeTextureInfoNameAsync("Icon/" .. skillTypeStaticWrapper:getIconPath())
  skillIcon:SetPosX(10)
  skillIcon:SetPosY(0)
  skillIcon:addInputEvent("Mouse_On", "Panel_SkillTooltip_Show(" .. skillNo .. ", false, \"LevelupInfoLearnable\", false)")
  skillIcon:addInputEvent("Mouse_Out", "Panel_SkillTooltip_Hide()")
  Panel_SkillTooltip_SetPosition(skillNo, skillIcon, "LevelupInfoLearnable")
  local skillName = UI.getChildControl(PaGlobal_LevelupInfo._learnableSkillBG[index], "StaticText_LearnableSkillName")
  skillName:SetShow(true)
  skillName:SetTextMode(__eTextMode_AutoWrap)
  skillName:SetText(tostring(skillTypeStaticWrapper:getName()))
  skillName:SetPosX(skillIcon:GetPosX() + skillIcon:GetSizeX() + 10)
  PaGlobal_LevelupInfo._ui._frm_learnableSkillScroll:SetInterval(index)
end
