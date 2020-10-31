function PaGlobal_LevelupInfo:initialize()
  if true == PaGlobal_LevelupInfo._initialize then
    return
  end
  Panel_Levelup_Info:SetDragAll(false)
  PaGlobal_LevelupInfo._ui._txt_titleLevel = UI.getChildControl(PaGlobal_LevelupInfo._ui._stc_titleBar, "StaticText_LevelUpNo")
  PaGlobal_LevelupInfo._ui._btn_close = UI.getChildControl(PaGlobal_LevelupInfo._ui._stc_titleBar, "Button_CloseIcon")
  PaGlobal_LevelupInfo._ui._txt_maxHpTitle = UI.getChildControl(PaGlobal_LevelupInfo._ui._stc_statusBG, "StaticText_HpTitle")
  PaGlobal_LevelupInfo._ui._txt_maxHpValue = UI.getChildControl(PaGlobal_LevelupInfo._ui._stc_statusBG, "StaticText_PrevHp")
  PaGlobal_LevelupInfo._ui._stc_hpArrow = UI.getChildControl(PaGlobal_LevelupInfo._ui._stc_statusBG, "Static_HpArrow")
  PaGlobal_LevelupInfo._ui._txt_increaseHpValue = UI.getChildControl(PaGlobal_LevelupInfo._ui._stc_statusBG, "StaticText_CurrentHp")
  PaGlobal_LevelupInfo._ui._txt_maxMpTitle = UI.getChildControl(PaGlobal_LevelupInfo._ui._stc_statusBG, "StaticText_MpTitle")
  PaGlobal_LevelupInfo._ui._txt_maxMpValue = UI.getChildControl(PaGlobal_LevelupInfo._ui._stc_statusBG, "StaticText_PrevMp")
  PaGlobal_LevelupInfo._ui._stc_mpArrow = UI.getChildControl(PaGlobal_LevelupInfo._ui._stc_statusBG, "Static_MpArrow")
  PaGlobal_LevelupInfo._ui._txt_increaseMpValue = UI.getChildControl(PaGlobal_LevelupInfo._ui._stc_statusBG, "StaticText_CurrentMp")
  PaGlobal_LevelupInfo._ui._txt_weightTitle = UI.getChildControl(PaGlobal_LevelupInfo._ui._stc_statusBG, "StaticText_WeightTitle")
  PaGlobal_LevelupInfo._ui._txt_weightValue = UI.getChildControl(PaGlobal_LevelupInfo._ui._stc_statusBG, "StaticText_PrevWeight")
  PaGlobal_LevelupInfo._ui._stc_weightArrow = UI.getChildControl(PaGlobal_LevelupInfo._ui._stc_statusBG, "Static_WeightArrow")
  PaGlobal_LevelupInfo._ui._txt_increaseWeightValue = UI.getChildControl(PaGlobal_LevelupInfo._ui._stc_statusBG, "StaticText_CurrentWeight")
  PaGlobal_LevelupInfo._ui._txt_attTitle = UI.getChildControl(PaGlobal_LevelupInfo._ui._stc_statusBG, "StaticText_AttTitle")
  PaGlobal_LevelupInfo._ui._txt_increaseAttValue = UI.getChildControl(PaGlobal_LevelupInfo._ui._stc_statusBG, "StaticText_CurrentAtt")
  PaGlobal_LevelupInfo._ui._stc_attArrow = UI.getChildControl(PaGlobal_LevelupInfo._ui._stc_statusBG, "Static_AttArrow")
  PaGlobal_LevelupInfo._ui._txt_preAttValue = UI.getChildControl(PaGlobal_LevelupInfo._ui._stc_statusBG, "StaticText_PreAtt")
  PaGlobal_LevelupInfo._ui._txt_defTitle = UI.getChildControl(PaGlobal_LevelupInfo._ui._stc_statusBG, "StaticText_DefTitle")
  PaGlobal_LevelupInfo._ui._stc_defArrow = UI.getChildControl(PaGlobal_LevelupInfo._ui._stc_statusBG, "Static_DefArrow")
  PaGlobal_LevelupInfo._ui._txt_preDefValue = UI.getChildControl(PaGlobal_LevelupInfo._ui._stc_statusBG, "StaticText_PreDef")
  PaGlobal_LevelupInfo._ui._txt_increaseDefValue = UI.getChildControl(PaGlobal_LevelupInfo._ui._stc_statusBG, "StaticText_CurrentDef")
  PaGlobal_LevelupInfo._ui._txt_learnSkillTitle = UI.getChildControl(PaGlobal_LevelupInfo._ui._stc_LearnSkillBG, "StaticText_LearnSkillTitle")
  PaGlobal_LevelupInfo._ui._stc_learnSkillLine_Deco = UI.getChildControl(PaGlobal_LevelupInfo._ui._stc_LearnSkillBG, "Static_LearnSkillTitleLine")
  PaGlobal_LevelupInfo._ui._frm_learnSkill = UI.getChildControl(PaGlobal_LevelupInfo._ui._stc_LearnSkillBG, "Frame_LearnSkill")
  PaGlobal_LevelupInfo._ui._frm_learnSkillContent = PaGlobal_LevelupInfo._ui._frm_learnSkill:GetFrameContent()
  PaGlobal_LevelupInfo._ui._frm_learnSkillScroll = PaGlobal_LevelupInfo._ui._frm_learnSkill:GetVScroll()
  PaGlobal_LevelupInfo._ui._txt_learnSkillNoSkill = UI.getChildControl(PaGlobal_LevelupInfo._ui._stc_LearnSkillBG, "StaticText_NoSkill")
  PaGlobal_LevelupInfo._ui._stc_learnSkillArea = UI.getChildControl(PaGlobal_LevelupInfo._ui._frm_learnSkillContent, "Static_TemplateArea1")
  PaGlobal_LevelupInfo._ui._txt_learnableSkillTitle = UI.getChildControl(PaGlobal_LevelupInfo._ui._stc_LearnableSkillBG, "StaticText_LearnableSkillTitle")
  PaGlobal_LevelupInfo._ui._stc_learnableSkillLine_Deco = UI.getChildControl(PaGlobal_LevelupInfo._ui._stc_LearnableSkillBG, "Static_LearnableSkillTitleLine")
  PaGlobal_LevelupInfo._ui._frm_learnableSkill = UI.getChildControl(PaGlobal_LevelupInfo._ui._stc_LearnableSkillBG, "Frame_LearnableSkill")
  PaGlobal_LevelupInfo._ui._frm_learnableSkillContent = PaGlobal_LevelupInfo._ui._frm_learnableSkill:GetFrameContent()
  PaGlobal_LevelupInfo._ui._frm_learnableSkillScroll = PaGlobal_LevelupInfo._ui._frm_learnableSkill:GetVScroll()
  PaGlobal_LevelupInfo._ui._txt_learnableSkillNoSkill = UI.getChildControl(PaGlobal_LevelupInfo._ui._stc_LearnableSkillBG, "StaticText_NoSkill")
  PaGlobal_LevelupInfo._ui._stc_learnableSkillArea = UI.getChildControl(PaGlobal_LevelupInfo._ui._frm_learnableSkillContent, "Static_TemplateArea1")
  PaGlobal_LevelupInfo._ui._txt_maxHpTitle:SetTextMode(__eTextMode_LimitText)
  PaGlobal_LevelupInfo._ui._txt_maxMpTitle:SetTextMode(__eTextMode_LimitText)
  PaGlobal_LevelupInfo._ui._txt_weightTitle:SetTextMode(__eTextMode_LimitText)
  PaGlobal_LevelupInfo._ui._txt_maxHpTitle:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_LEVELUP_INFO_MAXHPUP"))
  PaGlobal_LevelupInfo._ui._txt_weightTitle:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_LEVELUPINFO_MAXWEIGHT_TITLE"))
  PaGlobal_LevelupInfo._ui._txt_attTitle:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_LEVELUP_INFO_ATTACK"))
  PaGlobal_LevelupInfo._ui._txt_defTitle:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_LEVELUP_INFO_DEFENCE"))
  PaGlobal_LevelupInfo._ui._txt_learnSkillTitle:SetTextMode(__eTextMode_LimitText)
  PaGlobal_LevelupInfo._ui._txt_learnSkillTitle:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_LEVELUP_INFO_LEARNSKILL_TITLE"))
  PaGlobal_LevelupInfo._ui._txt_learnableSkillTitle:SetTextMode(__eTextMode_LimitText)
  PaGlobal_LevelupInfo._ui._txt_learnableSkillTitle:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_LEVELUP_INFO_LEARNABLESKILL_TITLE"))
  PaGlobal_LevelupInfo._ui._btn_unfold = UI.getChildControl(PaGlobal_LevelupInfo._ui._stc_unfold, "Button_Unfold")
  local stc_titleBG = UI.getChildControl(Panel_Levelup_Info, "Static_TitleBg")
  PaGlobal_LevelupInfo._defaultStatBGSizeY = stc_titleBG:GetSizeY()
  PaGlobal_LevelupInfo:registEventHandler()
  PaGlobal_LevelupInfo:validate()
  PaGlobal_LevelupInfo._initialize = true
end
function PaGlobal_LevelupInfo:CurrentState()
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  ToClient_updateAttackStat()
  PaGlobal_LevelupInfo._maxHp = selfPlayer:get():getMaxHp()
  PaGlobal_LevelupInfo._maxMp = selfPlayer:get():getMaxMp()
  PaGlobal_LevelupInfo._maxWeight = selfPlayer:get():getPossessableWeight_s64()
  PaGlobal_LevelupInfo._maxAtt = ToClient_getOffence()
  PaGlobal_LevelupInfo._maxDef = ToClient_getDefence()
end
function PaGlobal_LevelupInfo:registEventHandler()
  if nil == Panel_Levelup_Info then
    return
  end
  PaGlobal_LevelupInfo._ui._btn_close:addInputEvent("Mouse_LUp", "PaGlobal_LevelupInfo_Close()")
  PaGlobal_LevelupInfo._ui._btn_unfold:addInputEvent("Mouse_LUp", "PaGlobal_LevelupInfo_LeftOpen()")
  PaGlobal_LevelupInfo._ui._btn_unfold:addInputEvent("Mouse_On", "PaGlobal_LevelupInfo_LeftOpenTooltip(true)")
  PaGlobal_LevelupInfo._ui._btn_unfold:addInputEvent("Mouse_Out", "PaGlobal_LevelupInfo_LeftOpenTooltip(false)")
  registerEvent("FromClient_SelfPlayerCurrentLevelInfo", "FromClient_SelfPlayerCurrentLevelInfo")
end
function PaGlobal_LevelupInfo:prepareOpen()
  if nil == Panel_Levelup_Info then
    return
  end
  if false == _ContentsGroup_LevelupInfo then
    return
  end
  Panel_Levelup_Info:ComputePos()
  PaGlobal_LevelupInfo._ui._frm_learnSkill:UpdateContentPos()
  PaGlobal_LevelupInfo._ui._frm_learnSkill:UpdateContentScroll()
  PaGlobal_LevelupInfo._ui._frm_learnSkillScroll:SetControlTop()
  PaGlobal_LevelupInfo._ui._frm_learnableSkill:UpdateContentPos()
  PaGlobal_LevelupInfo._ui._frm_learnableSkill:UpdateContentScroll()
  PaGlobal_LevelupInfo._ui._frm_learnableSkillScroll:SetControlTop()
  Panel_Levelup_Info:SetPosX(getScreenSizeX() + Panel_Levelup_Info:GetSizeX())
  Panel_Levelup_Info:SetPosY(getScreenSizeY() - Panel_Levelup_Info:GetSizeY() - 30)
  local moveAni1 = Panel_Levelup_Info:addMoveAnimation(0, 0.3, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  moveAni1:SetStartPosition(getScreenSizeX() + Panel_Levelup_Info:GetSizeX(), getScreenSizeY() - Panel_Levelup_Info:GetSizeY() - 30)
  moveAni1:SetEndPosition(getScreenSizeX() - Panel_Levelup_Info:GetSizeX() - 20, getScreenSizeY() - Panel_Levelup_Info:GetSizeY() - 30)
  moveAni1:SetDisableWhileAni(true)
  PaGlobal_LevelupInfo._ui._btn_unfold:ChangeTextureInfoName("Combine/Btn/Combine_Btn_00.dds")
  local x1, y1, x2, y2 = setTextureUV_Func(PaGlobal_LevelupInfo._ui._btn_unfold, 94, 124, 117, 164)
  PaGlobal_LevelupInfo._ui._btn_unfold:getBaseTexture():setUV(x1, y1, x2, y2)
  local x1, y1, x2, y2 = setTextureUV_Func(PaGlobal_LevelupInfo._ui._btn_unfold, 118, 124, 141, 164)
  PaGlobal_LevelupInfo._ui._btn_unfold:getOnTexture():setUV(x1, y1, x2, y2)
  local x1, y1, x2, y2 = setTextureUV_Func(PaGlobal_LevelupInfo._ui._btn_unfold, 142, 124, 165, 164)
  PaGlobal_LevelupInfo._ui._btn_unfold:getClickTexture():setUV(x1, y1, x2, y2)
  PaGlobal_LevelupInfo._ui._btn_unfold:setRenderTexture(PaGlobal_LevelupInfo._ui._btn_unfold:getBaseTexture())
  PaGlobal_LevelupInfo._isFoldCheck = false
  PaGlobal_LevelupInfo:open()
end
function PaGlobal_LevelupInfo:open()
  if nil == Panel_Levelup_Info then
    return
  end
  Panel_Levelup_Info:SetShow(true)
  Panel_Levelup_Info:ComputePos()
end
function PaGlobal_LevelupInfo:prepareClose()
  if nil == Panel_Levelup_Info then
    return
  end
  PaGlobal_LevelupInfo:close()
end
function PaGlobal_LevelupInfo:close()
  if nil == Panel_Levelup_Info then
    return
  end
  Panel_Levelup_Info:SetShow(false)
end
function PaGlobal_LevelupInfo:validate()
  if nil == Panel_Levelup_Info then
    return
  end
end
function PaGlobal_LevelupInfo:additionalStatShowOff(lvdd, lvpv)
  UI.ASSERT_NAME(nil ~= lvdd, "PaGlobal_LevelupInfo:additionalStatShowOff lvdd nil", "\236\154\176\236\160\149\235\172\180")
  UI.ASSERT_NAME(nil ~= lvpv, "PaGlobal_LevelupInfo:additionalStatShowOff lvpv nil", "\236\154\176\236\160\149\235\172\180")
  if 0 == lvdd then
    PaGlobal_LevelupInfo._ui._txt_attTitle:SetShow(false)
    PaGlobal_LevelupInfo._ui._stc_attArrow:SetShow(false)
    PaGlobal_LevelupInfo._ui._txt_preAttValue:SetText("")
    PaGlobal_LevelupInfo._ui._txt_increaseAttValue:SetText("")
  end
  if 0 == lvpv then
    PaGlobal_LevelupInfo._ui._txt_defTitle:SetShow(false)
    PaGlobal_LevelupInfo._ui._stc_defArrow:SetShow(false)
    PaGlobal_LevelupInfo._ui._txt_increaseDefValue:SetText("")
    PaGlobal_LevelupInfo._ui._txt_preDefValue:SetText("")
  end
end
function PaGlobal_LevelupInfo:changeDefPosY(addSizeY)
  if 0 == addSizeY then
    return
  end
  local textSizeY = PaGlobal_LevelupInfo._ui._txt_maxHpTitle:GetSizeY()
  local defaultSpanY = PaGlobal_LevelupInfo._ui._txt_attTitle:GetSpanSize().y - textSizeY
  PaGlobal_LevelupInfo._ui._txt_defTitle:SetSpanSize(PaGlobal_LevelupInfo._ui._txt_defTitle:GetSpanSize().x, defaultSpanY + addSizeY)
  PaGlobal_LevelupInfo._ui._txt_increaseDefValue:SetSpanSize(PaGlobal_LevelupInfo._ui._txt_increaseDefValue:GetSpanSize().x, defaultSpanY + addSizeY)
  PaGlobal_LevelupInfo._ui._txt_preDefValue:SetSpanSize(PaGlobal_LevelupInfo._ui._txt_preDefValue:GetSpanSize().x, defaultSpanY + addSizeY)
  PaGlobal_LevelupInfo._ui._stc_defArrow:SetSpanSize(PaGlobal_LevelupInfo._ui._stc_defArrow:GetSpanSize().x, defaultSpanY + addSizeY)
  PaGlobal_LevelupInfo._ui._txt_defTitle:ComputePos()
  PaGlobal_LevelupInfo._ui._txt_increaseDefValue:ComputePos()
  PaGlobal_LevelupInfo._ui._txt_preDefValue:ComputePos()
  PaGlobal_LevelupInfo._ui._stc_defArrow:ComputePos()
end
function PaGlobal_LevelupInfo:calculateStatResize(lvdd, lvpv)
  UI.ASSERT_NAME(nil ~= lvdd, "PaGlobal_LevelupInfo:calculateStatResize lvdd nil", "\236\154\176\236\160\149\235\172\180")
  UI.ASSERT_NAME(nil ~= lvpv, "PaGlobal_LevelupInfo:calculateStatResize lvpv nil", "\236\154\176\236\160\149\235\172\180")
  local addSizeY = 0
  local textSizeY = PaGlobal_LevelupInfo._ui._txt_maxHpTitle:GetSizeY()
  if 0 ~= lvdd then
    addSizeY = addSizeY + textSizeY
  end
  if 0 ~= lvpv then
    addSizeY = addSizeY + textSizeY
  end
  PaGlobal_LevelupInfo:changeDefPosY(addSizeY)
  PaGlobal_LevelupInfo._ui._stc_statusBG:SetSize(PaGlobal_LevelupInfo._ui._stc_statusBG:GetSizeX(), PaGlobal_LevelupInfo._defaultStatBGSizeY + addSizeY)
end
function PaGlobal_LevelupInfo:calculateTopResize(index)
  UI.ASSERT_NAME(nil ~= index, "PaGlobal_LevelupInfo:calculateTopResize index nil", "\236\178\156\235\167\140\234\184\176")
  if nil == PaGlobal_LevelupInfo._skillBG[index] then
    PaGlobal_LevelupInfo._skillBG[index] = UI.cloneControl(PaGlobal_LevelupInfo._ui._stc_learnSkillArea, PaGlobal_LevelupInfo._ui._frm_learnSkillContent, "Static_LearnSkillAreaBG_" .. index)
  end
  PaGlobal_LevelupInfo._skillBG[index]:SetPosY(index * 45)
  PaGlobal_LevelupInfo._ui._frm_learnSkillContent:SetSize(300, 45 + index * 45)
  if 3 <= index then
    PaGlobal_LevelupInfo._ui._frm_learnSkill:SetSize(300, 150)
  else
    PaGlobal_LevelupInfo._ui._frm_learnSkill:SetSize(300, 45 + index * 45)
  end
  local topSize = PaGlobal_LevelupInfo._ui._stc_statusBG:GetPosY() + PaGlobal_LevelupInfo._ui._stc_statusBG:GetSizeY()
  PaGlobal_LevelupInfo._ui._stc_LearnSkillBG:SetPosY(topSize + 10)
end
function PaGlobal_LevelupInfo:calculateBottomResize(index)
  UI.ASSERT_NAME(nil ~= index, "PaGlobal_LevelupInfo:calculateBottomResize index nil", "\236\178\156\235\167\140\234\184\176")
  if nil == PaGlobal_LevelupInfo._learnableSkillBG[index] then
    PaGlobal_LevelupInfo._learnableSkillBG[index] = UI.cloneControl(PaGlobal_LevelupInfo._ui._stc_learnableSkillArea, PaGlobal_LevelupInfo._ui._frm_learnableSkillContent, "Static_LearnableSkillAreaBG_" .. index)
  end
  PaGlobal_LevelupInfo._learnableSkillBG[index]:SetPosY(index * 45)
  PaGlobal_LevelupInfo._ui._frm_learnableSkillContent:SetSize(310, 45 + index * 45)
  if 3 <= index then
    PaGlobal_LevelupInfo._ui._frm_learnableSkill:SetSize(300, 150)
  else
    PaGlobal_LevelupInfo._ui._frm_learnableSkill:SetSize(300, 45 + index * 45)
  end
  local topSize = PaGlobal_LevelupInfo._ui._stc_LearnSkillBG:GetPosY() + PaGlobal_LevelupInfo._ui._stc_LearnSkillBG:GetSizeY() + PaGlobal_LevelupInfo._ui._frm_learnSkill:GetSizeY()
  local botSize = topSize + PaGlobal_LevelupInfo._ui._stc_LearnableSkillBG:GetSizeY() + PaGlobal_LevelupInfo._ui._frm_learnableSkill:GetSizeY()
  PaGlobal_LevelupInfo._ui._stc_LearnableSkillBG:SetPosY(topSize + 10)
  Panel_Levelup_Info:SetSize(330, botSize + 30)
end
