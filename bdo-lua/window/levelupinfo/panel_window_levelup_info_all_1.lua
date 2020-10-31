function PaGlobal_Levelup_Info_All:initialize()
  if true == PaGlobal_Levelup_Info_All._initialize then
    return
  end
  self._isConsole = _ContentsGroup_UsePadSnapping
  self._ui.stc_KeyGuide_Console = UI.getChildControl(Panel_Window_LevelUp_Info_All, "Static_KeyGuide_Console")
  self._ui.stcText_Close_Console = UI.getChildControl(self._ui.stc_KeyGuide_Console, "StaticText_Close_Console")
  self._ui._stc_TitleBar = UI.getChildControl(Panel_Window_LevelUp_Info_All, "Static_TitleBg")
  self._ui._stc_MiddleDecoLine = UI.getChildControl(Panel_Window_LevelUp_Info_All, "Static_MiddleDecoLine")
  self._ui._stc_StatusBG = UI.getChildControl(Panel_Window_LevelUp_Info_All, "Static_StatBg")
  self._ui._stc_LearnSkillBG = UI.getChildControl(Panel_Window_LevelUp_Info_All, "Static_LearnSkillBg")
  self._ui._stc_LearnableSkillBG = UI.getChildControl(Panel_Window_LevelUp_Info_All, "Static_LearnableSkillBg")
  self._ui._stc_Unfold = UI.getChildControl(Panel_Window_LevelUp_Info_All, "Static_Unfold")
  self._ui._stc_KeyGuid = UI.getChildControl(Panel_Window_LevelUp_Info_All, "Static_KeyGuide_Console")
  self._ui._stcText_TitleLevel = UI.getChildControl(self._ui._stc_TitleBar, "StaticText_LevelUpNo")
  self._ui._btn_Close_PC = UI.getChildControl(self._ui._stc_TitleBar, "Button_CloseIcon")
  self._ui._stcText_MaxHpTitle = UI.getChildControl(self._ui._stc_StatusBG, "StaticText_HpTitle")
  self._ui._stcText_MaxHpValue = UI.getChildControl(self._ui._stc_StatusBG, "StaticText_PrevHp")
  self._ui._stc_HpArrow = UI.getChildControl(self._ui._stc_StatusBG, "Static_HpArrow")
  self._ui._stcText_IncreaseHpValue = UI.getChildControl(self._ui._stc_StatusBG, "StaticText_CurrentHp")
  self._ui._stcText_MaxMpTitle = UI.getChildControl(self._ui._stc_StatusBG, "StaticText_MpTitle")
  self._ui._stcText_MaxMpValue = UI.getChildControl(self._ui._stc_StatusBG, "StaticText_PrevMp")
  self._ui._stc_MpArrow = UI.getChildControl(self._ui._stc_StatusBG, "Static_MpArrow")
  self._ui._stcText_IncreaseMpValue = UI.getChildControl(self._ui._stc_StatusBG, "StaticText_CurrentMp")
  self._ui._stcText_WeightTitle = UI.getChildControl(self._ui._stc_StatusBG, "StaticText_WeightTitle")
  self._ui._stcText_WeightValue = UI.getChildControl(self._ui._stc_StatusBG, "StaticText_PrevWeight")
  self._ui._stc_WeightArrow = UI.getChildControl(self._ui._stc_StatusBG, "Static_WeightArrow")
  self._ui._stcText_IncreaseWeightValue = UI.getChildControl(self._ui._stc_StatusBG, "StaticText_CurrentWeight")
  self._ui._stcText_AttTitle = UI.getChildControl(self._ui._stc_StatusBG, "StaticText_AttTitle")
  self._ui._stc_AttArrow = UI.getChildControl(self._ui._stc_StatusBG, "Static_AttArrow")
  self._ui._stcText_PreAttValue = UI.getChildControl(self._ui._stc_StatusBG, "StaticText_PreAtt")
  self._ui._stcText_IncreaseAttValue = UI.getChildControl(self._ui._stc_StatusBG, "StaticText_CurrentAtt")
  self._ui._stcText_DefTitle = UI.getChildControl(self._ui._stc_StatusBG, "StaticText_DefTitle")
  self._ui._stc_DefArrow = UI.getChildControl(self._ui._stc_StatusBG, "Static_DefArrow")
  self._ui._stcText_PreDefValue = UI.getChildControl(self._ui._stc_StatusBG, "StaticText_PreDef")
  self._ui._stcText_IncreaseDefValue = UI.getChildControl(self._ui._stc_StatusBG, "StaticText_CurrentDef")
  self._ui._stcText_LearnSkillTitle = UI.getChildControl(self._ui._stc_LearnSkillBG, "StaticText_LearnSkillTitle")
  self._ui._stcText_LearnSkillNoSkill = UI.getChildControl(self._ui._stc_LearnSkillBG, "StaticText_NoSkill")
  self._ui._stc_paging = UI.getChildControl(self._ui._stc_LearnSkillBG, "Static_Paging")
  self._ui._btn_learnLeftArrow = UI.getChildControl(self._ui._stc_paging, "Button_LeftArrow")
  self._ui._btn_learnRightArrow = UI.getChildControl(self._ui._stc_paging, "Button_RightArrow")
  self._ui._txt_page = UI.getChildControl(self._ui._stc_paging, "StaticText_Page")
  self._ui._btn_quickSlotGo = UI.getChildControl(self._ui._stc_LearnSkillBG, "Button_QuickSlotGo")
  self._ui._stc_LearnSkillArea = UI.getChildControl(self._ui._stc_LearnSkillBG, "Static_TemplateArea1")
  self._ui._txt_learnSkillName = UI.getChildControl(self._ui._stc_LearnSkillArea, "StaticText_LearnSkillName")
  self._ui._stc_learnSkillIcon = UI.getChildControl(self._ui._stc_LearnSkillArea, "Static_LearnSkillIcon")
  self._ui._txt_learnSkillCommand = UI.getChildControl(self._ui._stc_LearnSkillArea, "StaticText_SkillCommand")
  self._ui._stcText_LearnableSkillTitle = UI.getChildControl(self._ui._stc_LearnableSkillBG, "StaticText_LearnableSkillTitle")
  self._ui._stcText_LearnableNoSkill = UI.getChildControl(self._ui._stc_LearnableSkillBG, "StaticText_NoSkill")
  self._ui._frm_LearnableSkill = UI.getChildControl(self._ui._stc_LearnableSkillBG, "Frame_LearnableSkill")
  self._ui._frm_LearnableSkillContent = self._ui._frm_LearnableSkill:GetFrameContent()
  self._ui._frm_LearnableSkillScroll = self._ui._frm_LearnableSkill:GetVScroll()
  self._ui._stc_LearnableSkillArea = UI.getChildControl(self._ui._frm_LearnableSkillContent, "Static_TemplateArea1")
  self._ui._btn_Unfold = UI.getChildControl(self._ui._stc_Unfold, "Button_Unfold")
  local stc_titleBG = UI.getChildControl(Panel_Window_LevelUp_Info_All, "Static_TitleBg")
  self._defaultStatBGSizeY = stc_titleBG:GetSizeY()
  self._ui._stcText_MaxHpTitle:SetTextMode(__eTextMode_LimitText)
  self._ui._stcText_MaxMpTitle:SetTextMode(__eTextMode_LimitText)
  self._ui._stcText_WeightTitle:SetTextMode(__eTextMode_LimitText)
  self._ui._stcText_MaxHpTitle:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_LEVELUP_INFO_MAXHPUP"))
  self._ui._stcText_WeightTitle:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_LEVELUPINFO_MAXWEIGHT_TITLE"))
  self._ui._stcText_AttTitle:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_LEVELUP_INFO_ATTACK"))
  self._ui._stcText_DefTitle:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_LEVELUP_INFO_DEFENCE"))
  self._ui._stcText_LearnSkillTitle:SetTextMode(__eTextMode_LimitText)
  self._ui._stcText_LearnSkillTitle:SetText(self._ui._stcText_LearnSkillTitle:GetText())
  self._ui._stcText_LearnableSkillTitle:SetTextMode(__eTextMode_LimitText)
  self._ui._stcText_LearnableSkillTitle:SetText(self._ui._stcText_LearnableSkillTitle:GetText())
  self._stc_LearnSkillBG_OriginSizeY = self._ui._stc_LearnSkillBG:GetSizeY()
  self._stc_LearnableSkillBG_OriginSizeY = self._ui._stc_LearnableSkillBG:GetSizeY()
  self._frm_LearnableSkill_OriginSizeY = self._ui._frm_LearnableSkill:GetSizeY()
  self._ui._stc_HpArrow:SetPosX(self._ui._stc_HpArrow:GetPosX() - 10)
  self._ui._stc_MpArrow:SetPosX(self._ui._stc_MpArrow:GetPosX() - 10)
  self._ui._stc_WeightArrow:SetPosX(self._ui._stc_WeightArrow:GetPosX() - 10)
  self._ui._stc_AttArrow:SetPosX(self._ui._stc_AttArrow:GetPosX() - 10)
  self._ui._stc_DefArrow:SetPosX(self._ui._stc_DefArrow:GetPosX() - 10)
  if false == self._isConsole then
    self._ui._btn_Close_PC:SetShow(true)
    self._ui.stc_KeyGuide_Console:SetShow(false)
  else
    self._ui._btn_Close_PC:SetShow(false)
    self._ui.stc_KeyGuide_Console:SetShow(true)
  end
  PaGlobal_Levelup_Info_All:registEventHandler()
  PaGlobal_Levelup_Info_All:validate()
  PaGlobal_Levelup_Info_All._initialize = true
end
function PaGlobal_Levelup_Info_All:registEventHandler()
  if nil == Panel_Window_LevelUp_Info_All then
    return
  end
  self._ui._btn_Close_PC:addInputEvent("Mouse_LUp", "PaGlobalFunc_Levelup_Info_All_Close()")
  self._ui._btn_Unfold:addInputEvent("Mouse_LUp", "HandleEventLUp_Levelup_Info_All_LeftOpen()")
  self._ui._btn_Unfold:addInputEvent("Mouse_On", "HandleEventOnOut_Levelup_Info_All_LeftOpenTooltip(true)")
  self._ui._btn_Unfold:addInputEvent("Mouse_Out", "HandleEventOnOut_Levelup_Info_All_LeftOpenTooltip(false)")
  self._ui._btn_learnLeftArrow:addInputEvent("Mouse_LUp", "HandleEventLUp_LevelUp_Info_All_LearnSkillArrow(true)")
  self._ui._btn_learnRightArrow:addInputEvent("Mouse_LUp", "HandleEventLUp_LevelUp_Info_All_LearnSkillArrow(false)")
  self._ui._stc_LearnSkillArea:addInputEvent("Mouse_UpScroll", "HandleEventLUp_LevelUp_Info_All_LearnSkillArrow(false)")
  self._ui._stc_LearnSkillArea:addInputEvent("Mouse_DownScroll", "HandleEventLUp_LevelUp_Info_All_LearnSkillArrow(true)")
  registerEvent("FromClient_SelfPlayerCurrentLevelInfo", "PaGlobalFunc_Levelup_Info_All_SelfPlayerCurrentLevelInfo")
  registerEvent("onScreenResize", "FromClient_LevelUp_Info_All_ScreenResize")
end
function PaGlobal_Levelup_Info_All:CurrentState()
  if nil == Panel_Window_LevelUp_Info_All then
    return
  end
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  ToClient_updateAttackStat()
  PaGlobal_Levelup_Info_All._maxHp = selfPlayer:get():getMaxHp()
  PaGlobal_Levelup_Info_All._maxMp = selfPlayer:get():getMaxMp()
  PaGlobal_Levelup_Info_All._maxWeight = selfPlayer:get():getPossessableWeight_s64()
  PaGlobal_Levelup_Info_All._maxAtt = ToClient_getOffence()
  PaGlobal_Levelup_Info_All._maxDef = ToClient_getDefence()
end
function PaGlobal_Levelup_Info_All:additionalStatShowOff(lvdd, lvpv)
  if nil == Panel_Window_LevelUp_Info_All then
    return
  end
  UI.ASSERT_NAME(nil ~= lvdd, "PaGlobal_Levelup_Info_All:additionalStatShowOff lvdd nil", "\236\157\180\236\138\185\237\153\152")
  UI.ASSERT_NAME(nil ~= lvpv, "PaGlobal_Levelup_Info_All:additionalStatShowOff lvpv nil", "\236\157\180\236\138\185\237\153\152")
  if 0 == lvdd then
    PaGlobal_Levelup_Info_All._ui._stcText_AttTitle:SetShow(false)
    PaGlobal_Levelup_Info_All._ui._stc_AttArrow:SetShow(false)
    PaGlobal_Levelup_Info_All._ui._stcText_PreAttValue:SetText("")
    PaGlobal_Levelup_Info_All._ui._stcText_IncreaseAttValue:SetText("")
  end
  if 0 == lvpv then
    PaGlobal_Levelup_Info_All._ui._stcText_DefTitle:SetShow(false)
    PaGlobal_Levelup_Info_All._ui._stc_DefArrow:SetShow(false)
    PaGlobal_Levelup_Info_All._ui._stcText_IncreaseDefValue:SetText("")
    PaGlobal_Levelup_Info_All._ui._stcText_PreDefValue:SetText("")
  end
end
function PaGlobal_Levelup_Info_All:calculateStatBGResize(lvdd, lvpv)
  if nil == Panel_Window_LevelUp_Info_All then
    return
  end
  UI.ASSERT_NAME(nil ~= lvdd, "PaGlobal_Levelup_Info_All:calculateStatBGResize lvdd nil", "\236\157\180\236\138\185\237\153\152")
  UI.ASSERT_NAME(nil ~= lvpv, "PaGlobal_Levelup_Info_All:calculateStatBGResize lvpv nil", "\236\157\180\236\138\185\237\153\152")
  local addSizeY = 0
  local textSizeY = PaGlobal_Levelup_Info_All._ui._stcText_MaxHpTitle:GetSizeY()
  local spanSizeY = PaGlobal_Levelup_Info_All._ui._stcText_MaxHpTitle:GetSpanSize().y
  local visibleTitleNum = 3
  if 0 ~= lvdd then
    addSizeY = addSizeY + textSizeY
    visibleTitleNum = visibleTitleNum + 1
  end
  if 0 ~= lvpv then
    addSizeY = addSizeY + textSizeY
    visibleTitleNum = visibleTitleNum + 1
  end
  PaGlobal_Levelup_Info_All:changeDefPosY(addSizeY)
  PaGlobal_Levelup_Info_All._ui._stc_StatusBG:SetSize(PaGlobal_Levelup_Info_All._ui._stc_StatusBG:GetSizeX(), (textSizeY + spanSizeY) * visibleTitleNum)
  PaGlobal_Levelup_Info_All._ui._stc_MiddleDecoLine:SetPosY(PaGlobal_Levelup_Info_All._ui._stc_StatusBG:GetPosY() + PaGlobal_Levelup_Info_All._ui._stc_StatusBG:GetSizeY() + spanSizeY)
end
function PaGlobal_Levelup_Info_All:calculateTopResize(index)
  if nil == Panel_Window_LevelUp_Info_All then
    return
  end
  UI.ASSERT_NAME(nil ~= index, "PaGlobal_Levelup_Info_All:calculateTopResize index nil", "\236\157\180\236\138\185\237\153\152")
  local learnSkillFramPosY = self._ui._stc_MiddleDecoLine:GetPosY()
  self._ui._stc_LearnSkillBG:SetPosY(learnSkillFramPosY)
end
function PaGlobal_Levelup_Info_All:calculateBottomResize(index)
  if nil == Panel_Window_LevelUp_Info_All then
    return
  end
  UI.ASSERT_NAME(nil ~= index, "PaGlobal_Levelup_Info_All:calculateBottomResize index nil", "\236\157\180\236\138\185\237\153\152")
  PaGlobal_Levelup_Info_All._ui._stc_LearnableSkillArea:SetShow(false)
  if nil == PaGlobal_Levelup_Info_All._learnableSkillBG[index] then
    PaGlobal_Levelup_Info_All._learnableSkillBG[index] = UI.cloneControl(PaGlobal_Levelup_Info_All._ui._stc_LearnableSkillArea, PaGlobal_Levelup_Info_All._ui._frm_LearnableSkillContent, "Static_LearnableSkillAreaBG_" .. index)
  end
  local learnalbeSkillAreaSizeY = PaGlobal_Levelup_Info_All._ui._stc_LearnableSkillArea:GetSizeY()
  PaGlobal_Levelup_Info_All._learnableSkillBG[index]:SetPosY(index * learnalbeSkillAreaSizeY)
  PaGlobal_Levelup_Info_All._ui._frm_LearnableSkillContent:SetSize(PaGlobal_Levelup_Info_All._ui._frm_LearnableSkillContent:GetSizeX(), learnalbeSkillAreaSizeY + index * learnalbeSkillAreaSizeY)
  PaGlobal_Levelup_Info_All._ui._stc_LearnableSkillBG:SetSize(PaGlobal_Levelup_Info_All._ui._stc_LearnableSkillBG:GetSizeX(), PaGlobal_Levelup_Info_All._stc_LearnableSkillBG_OriginSizeY)
  if 3 <= index then
    PaGlobal_Levelup_Info_All._ui._frm_LearnableSkill:SetSize(Panel_Window_LevelUp_Info_All:GetSizeX(), PaGlobal_Levelup_Info_All._frm_LearnableSkill_OriginSizeY)
  else
    PaGlobal_Levelup_Info_All._ui._frm_LearnableSkill:SetSize(Panel_Window_LevelUp_Info_All:GetSizeX(), learnalbeSkillAreaSizeY + index * learnalbeSkillAreaSizeY)
    if true == PaGlobal_Levelup_Info_All._isLearnableSkill then
      local sizeY = PaGlobal_Levelup_Info_All._ui._frm_LearnableSkill:GetSizeY() + PaGlobal_Levelup_Info_All._ui._stcText_LearnableSkillTitle:GetSizeY() + PaGlobal_Levelup_Info_All._ui._stcText_LearnableSkillTitle:GetSpanSize().y * 2
      PaGlobal_Levelup_Info_All._ui._stc_LearnableSkillBG:SetSize(PaGlobal_Levelup_Info_All._ui._stc_LearnableSkillBG:GetSizeX(), sizeY)
    end
  end
  local learnableSkill = UI.getChildControl(self._ui._frm_LearnableSkill, "Frame_1_Content")
  learnableSkill:SetSize(learnableSkill:GetSizeX(), self._ui._frm_LearnableSkill:GetSizeY())
  local learnableSkillFramPosY = PaGlobal_Levelup_Info_All._ui._stc_LearnSkillBG:GetPosY() + PaGlobal_Levelup_Info_All._ui._stc_LearnSkillBG:GetSizeY()
  PaGlobal_Levelup_Info_All._ui._stc_LearnableSkillBG:SetPosY(learnableSkillFramPosY)
  local panelResizeY = PaGlobal_Levelup_Info_All._ui._stc_TitleBar:GetSizeY() + PaGlobal_Levelup_Info_All._ui._stc_StatusBG:GetSizeY() + PaGlobal_Levelup_Info_All._ui._stc_LearnSkillBG:GetSizeY() + PaGlobal_Levelup_Info_All._ui._stc_LearnableSkillBG:GetSizeY()
  Panel_Window_LevelUp_Info_All:SetSize(Panel_Window_LevelUp_Info_All:GetSizeX(), panelResizeY + 10)
end
function PaGlobal_Levelup_Info_All:changeDefPosY(addSizeY)
  if nil == Panel_Window_LevelUp_Info_All then
    return
  end
  if 0 == addSizeY then
    return
  end
  local textSizeY = PaGlobal_Levelup_Info_All._ui._stcText_MaxHpTitle:GetSizeY()
  local defaultSpanY = PaGlobal_Levelup_Info_All._ui._stcText_AttTitle:GetSpanSize().y - textSizeY
  PaGlobal_Levelup_Info_All._ui._stcText_DefTitle:SetSpanSize(PaGlobal_Levelup_Info_All._ui._stcText_DefTitle:GetSpanSize().x, defaultSpanY + addSizeY)
  PaGlobal_Levelup_Info_All._ui._stcText_IncreaseDefValue:SetSpanSize(PaGlobal_Levelup_Info_All._ui._stcText_IncreaseDefValue:GetSpanSize().x, defaultSpanY + addSizeY)
  PaGlobal_Levelup_Info_All._ui._stcText_PreDefValue:SetSpanSize(PaGlobal_Levelup_Info_All._ui._stcText_PreDefValue:GetSpanSize().x, defaultSpanY + addSizeY)
  PaGlobal_Levelup_Info_All._ui._stc_DefArrow:SetSpanSize(PaGlobal_Levelup_Info_All._ui._stc_DefArrow:GetSpanSize().x, defaultSpanY + addSizeY)
  PaGlobal_Levelup_Info_All._ui._stcText_DefTitle:ComputePos()
  PaGlobal_Levelup_Info_All._ui._stcText_IncreaseDefValue:ComputePos()
  PaGlobal_Levelup_Info_All._ui._stcText_PreDefValue:ComputePos()
  PaGlobal_Levelup_Info_All._ui._stc_DefArrow:ComputePos()
end
function PaGlobal_Levelup_Info_All:prepareOpen()
  if nil == Panel_Window_LevelUp_Info_All then
    return
  end
  Panel_Window_LevelUp_Info_All:SetPosX(getScreenSizeX() + Panel_Window_LevelUp_Info_All:GetSizeX())
  Panel_Window_LevelUp_Info_All:SetPosY(getScreenSizeY() - Panel_Window_LevelUp_Info_All:GetSizeY() - 30)
  PaGlobal_Levelup_Info_All._ui._frm_LearnableSkill:UpdateContentPos()
  PaGlobal_Levelup_Info_All._ui._frm_LearnableSkill:UpdateContentScroll()
  PaGlobal_Levelup_Info_All._ui._frm_LearnableSkillScroll:SetControlTop()
  local moveAni1 = Panel_Window_LevelUp_Info_All:addMoveAnimation(0, 0.3, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  moveAni1:SetStartPosition(getScreenSizeX() + Panel_Window_LevelUp_Info_All:GetSizeX(), getScreenSizeY() - Panel_Window_LevelUp_Info_All:GetSizeY() - 30)
  moveAni1:SetEndPosition(getScreenSizeX() - Panel_Window_LevelUp_Info_All:GetSizeX() - 20, getScreenSizeY() - Panel_Window_LevelUp_Info_All:GetSizeY() - 30)
  moveAni1:SetDisableWhileAni(true)
  PaGlobal_Levelup_Info_All._ui._btn_Unfold:ChangeTextureInfoName("combine/btn/combine_btn_00.dds")
  local x1, y1, x2, y2 = setTextureUV_Func(PaGlobal_Levelup_Info_All._ui._btn_Unfold, 94, 124, 117, 164)
  PaGlobal_Levelup_Info_All._ui._btn_Unfold:getBaseTexture():setUV(x1, y1, x2, y2)
  x1, y1, x2, y2 = setTextureUV_Func(PaGlobal_Levelup_Info_All._ui._btn_Unfold, 118, 124, 141, 164)
  PaGlobal_Levelup_Info_All._ui._btn_Unfold:getOnTexture():setUV(x1, y1, x2, y2)
  x1, y1, x2, y2 = setTextureUV_Func(PaGlobal_Levelup_Info_All._ui._btn_Unfold, 142, 124, 165, 164)
  PaGlobal_Levelup_Info_All._ui._btn_Unfold:getClickTexture():setUV(x1, y1, x2, y2)
  PaGlobal_Levelup_Info_All._ui._btn_Unfold:setRenderTexture(PaGlobal_Levelup_Info_All._ui._btn_Unfold:getBaseTexture())
  PaGlobal_Levelup_Info_All._isFoldCheck = false
  PaGlobal_Levelup_Info_All:open()
end
function PaGlobal_Levelup_Info_All:open()
  if nil == Panel_Window_LevelUp_Info_All then
    return
  end
  Panel_Window_LevelUp_Info_All:SetShow(true)
end
function PaGlobal_Levelup_Info_All:prepareClose()
  if nil == Panel_Window_LevelUp_Info_All then
    return
  end
  PaGlobal_Levelup_Info_All:close()
end
function PaGlobal_Levelup_Info_All:close()
  if nil == Panel_Window_LevelUp_Info_All then
    return
  end
  Panel_Window_LevelUp_Info_All:SetShow(false)
end
function PaGlobal_Levelup_Info_All:validate()
  if nil == Panel_Window_LevelUp_Info_All then
    return
  end
  PaGlobal_Levelup_Info_All._ui._stc_TitleBar:isValidate()
  PaGlobal_Levelup_Info_All._ui._stc_MiddleDecoLine:isValidate()
  PaGlobal_Levelup_Info_All._ui._stc_StatusBG:isValidate()
  PaGlobal_Levelup_Info_All._ui._stc_LearnSkillBG:isValidate()
  PaGlobal_Levelup_Info_All._ui._stc_LearnableSkillBG:isValidate()
  PaGlobal_Levelup_Info_All._ui._stc_Unfold:isValidate()
  PaGlobal_Levelup_Info_All._ui._stc_KeyGuid:isValidate()
  PaGlobal_Levelup_Info_All._ui._stcText_TitleLevel:isValidate()
  PaGlobal_Levelup_Info_All._ui._btn_Close_PC:isValidate()
  PaGlobal_Levelup_Info_All._ui._stcText_MaxHpTitle:isValidate()
  PaGlobal_Levelup_Info_All._ui._stcText_MaxHpValue:isValidate()
  PaGlobal_Levelup_Info_All._ui._stc_HpArrow:isValidate()
  PaGlobal_Levelup_Info_All._ui._stcText_IncreaseHpValue:isValidate()
  PaGlobal_Levelup_Info_All._ui._stcText_MaxMpTitle:isValidate()
  PaGlobal_Levelup_Info_All._ui._stcText_MaxMpValue:isValidate()
  PaGlobal_Levelup_Info_All._ui._stc_MpArrow:isValidate()
  PaGlobal_Levelup_Info_All._ui._stcText_IncreaseMpValue:isValidate()
  PaGlobal_Levelup_Info_All._ui._stcText_WeightTitle:isValidate()
  PaGlobal_Levelup_Info_All._ui._stcText_WeightValue:isValidate()
  PaGlobal_Levelup_Info_All._ui._stc_WeightArrow:isValidate()
  PaGlobal_Levelup_Info_All._ui._stcText_IncreaseWeightValue:isValidate()
  PaGlobal_Levelup_Info_All._ui._stcText_AttTitle:isValidate()
  PaGlobal_Levelup_Info_All._ui._stcText_IncreaseAttValue:isValidate()
  PaGlobal_Levelup_Info_All._ui._stc_AttArrow:isValidate()
  PaGlobal_Levelup_Info_All._ui._stcText_PreAttValue:isValidate()
  PaGlobal_Levelup_Info_All._ui._stcText_DefTitle:isValidate()
  PaGlobal_Levelup_Info_All._ui._stc_DefArrow:isValidate()
  PaGlobal_Levelup_Info_All._ui._stcText_PreDefValue:isValidate()
  PaGlobal_Levelup_Info_All._ui._stcText_IncreaseDefValue:isValidate()
  PaGlobal_Levelup_Info_All._ui._stcText_LearnSkillTitle:isValidate()
  PaGlobal_Levelup_Info_All._ui._stcText_LearnSkillNoSkill:isValidate()
  PaGlobal_Levelup_Info_All._ui._stc_LearnSkillArea:isValidate()
  PaGlobal_Levelup_Info_All._ui._stcText_LearnableSkillTitle:isValidate()
  PaGlobal_Levelup_Info_All._ui._stcText_LearnableNoSkill:isValidate()
  PaGlobal_Levelup_Info_All._ui._frm_LearnableSkill:isValidate()
  PaGlobal_Levelup_Info_All._ui._frm_LearnableSkillContent:isValidate()
  PaGlobal_Levelup_Info_All._ui._frm_LearnableSkillScroll:isValidate()
  PaGlobal_Levelup_Info_All._ui._stc_LearnableSkillArea:isValidate()
  PaGlobal_Levelup_Info_All._ui._btn_Unfold:isValidate()
  PaGlobal_Levelup_Info_All._ui.stc_KeyGuide_Console:isValidate()
  PaGlobal_Levelup_Info_All._ui.stcText_Close_Console:isValidate()
end
function PaGlobal_Levelup_Info_All:updateLearnSkill(index)
  self._currentLearnSkillIndex = index
  local learnSkillWrapper = ToClient_getCurrentLearnedSkill(index)
  if nil ~= learnSkillWrapper then
    local skillNo = learnSkillWrapper:getSkillNo()
    PaGlobal_Levelup_Info_All_UpdateLearnSkillData(skillNo, index)
    self:calculateTopResize(self._maxLearnSkillIndex)
    self:updatePageText()
  end
end
function PaGlobal_Levelup_Info_All:updatePageText()
  self._ui._txt_page:SetText(tostring(self._currentLearnSkillIndex + 1) .. "/" .. tostring(self._maxLearnSkillIndex + 1))
end
function PaGlobal_Levelup_Info_All:updateButtonQuickSlotGo(isIgnore)
  self._ui._btn_quickSlotGo:SetIgnore(isIgnore)
  self._ui._btn_quickSlotGo:SetMonoTone(isIgnore)
  if true == isIgnore then
    self._ui._btn_quickSlotGo:SetFontColor(Defines.Color.C_FF6C6C6C)
  else
    self._ui._btn_quickSlotGo:SetFontColor(Defines.Color.C_FFE0E0E0)
  end
end
function PaGlobal_Levelup_Info_All:updateScreenResize()
  if nil == Panel_Window_LevelUp_Info_All then
    return
  end
  Panel_Window_LevelUp_Info_All:ComputePos()
  Panel_Window_LevelUp_Info_All:SetPosX(getScreenSizeX() - Panel_Window_LevelUp_Info_All:GetSizeX() - 20)
  Panel_Window_LevelUp_Info_All:SetPosY(getScreenSizeY() - Panel_Window_LevelUp_Info_All:GetSizeY() - 30)
end
