function PaGlobal_SkillGroup_Controller:initialize()
  if true == PaGlobal_SkillGroup_Controller._initialize then
    return
  end
  self._isConsole = _ContentsGroup_RenewUI
  self:controlInit_All()
  self:initString()
  self:registEventHandler()
  self:validate()
  self._initialize = true
end
function PaGlobal_SkillGroup_Controller:controlInit_All()
  local ui = PaGlobal_SkillGroup_Controller._ui
  ui._btn_playSkill = UI.getChildControl(Panel_Window_SkillGroup_Controller, "Button_PlaySkill")
  ui._btn_cameraReset = UI.getChildControl(Panel_Window_SkillGroup_Controller, "Button_CameraReset")
  ui._btn_playBlack = UI.getChildControl(Panel_Window_SkillGroup_Controller, "Button_PlayBlack")
  ui._stc_descBg = UI.getChildControl(Panel_Window_SkillGroup_Controller, "Static_NormalDescBG")
  ui._stc_skillIcon = UI.getChildControl(ui._stc_descBg, "Static_SkillIcon")
  ui._txt_skillName = UI.getChildControl(ui._stc_descBg, "StaticText_SkillName")
  ui._txt_skillDesc = UI.getChildControl(ui._stc_descBg, "StaticText_SkillDesc")
  ui._txt_skillCommandDesc = UI.getChildControl(ui._stc_descBg, "StaticText_Skill_CommandDesc")
  ui._txt_skillEffectTitle = UI.getChildControl(ui._stc_descBg, "StaticText_Skill_Effect_Title")
  ui._txt_skillEffectDesc = UI.getChildControl(ui._stc_descBg, "StaticText_Skill_EffectDesc")
  ui._txt_skillNeedResource = UI.getChildControl(ui._stc_descBg, "StaticText_NeedMp")
  ui._txt_requiredLevel = UI.getChildControl(ui._stc_descBg, "StaticText_RequiredLevel")
  ui._txt_requiredSkillPoint = UI.getChildControl(ui._stc_descBg, "StaticText_RequiredSkillPoint")
  ui._txt_reuseCycle = UI.getChildControl(ui._stc_descBg, "StaticText_ReuseCycle")
  Panel_Window_SkillGroup_Controller:SetSize(Panel_Window_SkillGroup:GetPosX(), getScreenSizeY())
  ui._btn_playBlack:SetPosX(Panel_Window_SkillGroup_Controller:GetSizeX() / 2 - ui._btn_playSkill:GetSizeX() - ui._btn_playBlack:GetSizeX() - 10)
  ui._btn_playSkill:SetPosX(Panel_Window_SkillGroup_Controller:GetSizeX() / 2 - ui._btn_playSkill:GetSizeX())
  ui._btn_cameraReset:SetPosX(Panel_Window_SkillGroup_Controller:GetSizeX() / 2 + ui._btn_cameraReset:GetSizeX())
  local selfPlayerWrapper = getSelfPlayer()
  if nil == selfPlayerWrapper then
    UI.ASSERT(false, "PaGlobal_SkillGroup_Controller:controlInit_All() selfPlayerWrapper is nil")
    return
  end
  ui._btn_playBlack:SetShow(false)
  ui._stc_descBg:SetShow(true)
  ui._stc_descBg:SetIgnore(true)
  ui._txt_skillName:SetTextMode(__eTextMode_AutoWrap)
  ui._txt_skillDesc:SetSize((getScreenSizeX() - Panel_Window_SkillGroup:GetSizeX() - ui._txt_skillDesc:GetPosX()) * 0.6, ui._txt_skillDesc:GetSizeY())
  ui._txt_skillDesc:SetTextMode(__eTextMode_AutoWrap)
  ui._txt_skillDesc:SetAutoResize(true)
  ui._txt_skillCommandDesc:SetAutoResize(true)
  ui._txt_skillCommandDesc:SetTextMode(__eTextMode_AutoWrap)
  ui._txt_skillEffectDesc:SetAutoResize(false)
  ui._txt_skillEffectDesc:SetTextMode(__eTextMode_AutoWrap)
  ui._txt_skillNeedResource:SetAutoResize(true)
end
function PaGlobal_SkillGroup_Controller:initString()
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  local characterActorProxyWrapper = getCharacterActor(selfPlayer:get():getActorKeyRaw())
  if nil == characterActorProxyWrapper then
    return
  end
  local mentalType = characterActorProxyWrapper:getCombatResourceType()
  if CppEnums.CombatResourceType.CombatType_MP == mentalType then
    self._fixedDescString._needMantalString = PAGetString(Defines.StringSheet_GAME, "LUA_SKILLWINDOW_ALL_DESC_NEED_MP")
    self._fixedDescString._mantalString = PAGetString(Defines.StringSheet_GAME, "LUA_CHARACTERINFO_TEXT_MP")
  elseif CppEnums.CombatResourceType.CombatType_FP == mentalType then
    self._fixedDescString._needMantalString = PAGetString(Defines.StringSheet_GAME, "LUA_SKILLWINDOW_ALL_DESC_NEED_FP")
    self._fixedDescString._mantalString = PAGetString(Defines.StringSheet_GAME, "LUA_CHARACTERINFO_TEXT_FP")
  elseif CppEnums.CombatResourceType.CombatType_EP == mentalType then
    self._fixedDescString._needMantalString = PAGetString(Defines.StringSheet_GAME, "LUA_SKILLWINDOW_ALL_DESC_NEED_EP")
    self._fixedDescString._mantalString = PAGetString(Defines.StringSheet_GAME, "LUA_CHARACTERINFO_TEXT_EP")
  elseif CppEnums.CombatResourceType.CombatType_BP == mentalType then
    self._fixedDescString._needMantalString = PAGetString(Defines.StringSheet_GAME, "LUA_SKILLWINDOW_ALL_DESC_NEED_BP")
    self._fixedDescString._mantalString = PAGetString(Defines.StringSheet_GAME, "LUA_SELFCHARACTERINFO_BP")
  end
end
function PaGlobal_SkillGroup_Controller:open()
  if nil == Panel_Window_SkillGroup_Controller then
    return
  end
  if nil == self._renderMode then
    self._renderMode = RenderModeWrapper.new(100, {
      Defines.RenderMode.eRenderMode_SkillWindow
    }, false)
    self._renderMode:setPrefunctor(self._renderMode, PaGlobalFunc_SkillGroup_PreRenderMode)
    self._renderMode:setClosefunctor(self._renderMode, PaGlobalFunc_SkillGroup_CloseRenderMode)
  end
  self._renderMode:set()
  SetUIMode(Defines.UIMode.eUIMode_SkillWindow)
  self:reset()
  ToClient_AudioPostEvent_UIAudioStateEvent("UISTATE_OPEN_SKILLGROUP_FULLSCREEN")
  Panel_Window_SkillGroup_Controller:SetShow(true)
end
function PaGlobal_SkillGroup_Controller:close()
  if nil == Panel_Window_SkillGroup_Controller then
    return
  end
  self._renderMode:reset()
  SetUIMode(Defines.UIMode.eUIMode_Default)
  ToClient_AudioPostEvent_UIAudioStateEvent("UISTATE_OPEN_SKILLGROUP_WINDOW")
  Panel_Window_SkillGroup_Controller:SetShow(false)
end
function PaGlobal_SkillGroup_Controller:getSkillInfo(skillNo)
  local skillTypeStaticWrapper = getSkillTypeStaticStatus(skillNo)
  if nil == skillTypeStaticWrapper then
    return
  end
  local skillTypeStatic = skillTypeStaticWrapper:get()
  if nil == skillTypeStatic then
    return
  end
  local skillLevelInfo = getSkillLevelInfo(skillNo)
  local skillLearndLevel = getLearnedSkillLevel(skillTypeStaticWrapper)
  local skillStaticWrapper = getSkillStaticStatus(skillNo, 1)
  if nil == skillStaticWrapper then
    return
  end
  local skillStatic = skillStaticWrapper:get()
  if nil == skillStatic then
    return
  end
  local havePrevActionHashKey = ToClient_LearnSkillCameraHavePrevActionHashKey(skillStatic)
  local skillAwakenStr = ""
  local activeSkillSS
  local isAwakeningData = false
  if true == skillStaticWrapper:isActiveSkillHas() and false == skillStaticWrapper:isFusionSkill() then
    activeSkillSS = getActiveSkillStatus(skillStaticWrapper)
    if nil ~= activeSkillSS then
      local awakeInfo = ""
      local awakeningDataCount = activeSkillSS:getSkillAwakenInfoCount() - 1
      local realCount = 0
      for idx = 0, awakeningDataCount do
        local skillInfo = activeSkillSS:getSkillAwakenInfo(idx)
        if "" ~= skillInfo then
          awakeInfo = awakeInfo .. "\n" .. skillInfo
          realCount = realCount + 1
        end
      end
      skillAwakenStr = awakeInfo
      isAwakeningData = 0 < realCount
    end
  end
  local skillAwakenTitleStr = PAGetString(Defines.StringSheet_RESOURCE, "TOOLTIP_SKILL_TXT_AWAKEN")
  local buffStr = skillStaticWrapper:getDescription()
  if true == skillLevelInfo._usable and true == isAwakeningData then
    buffStr = buffStr .. [[


]] .. skillAwakenTitleStr .. skillAwakenStr
  end
  local skillInfo = {
    _no = skillNo,
    _name = skillTypeStaticWrapper:getName(),
    _learndLevel = skillLearndLevel,
    _learnable = skillLevelInfo._learnable,
    _usable = skillLevelInfo._usable,
    _command = skillTypeStaticWrapper:getCommand(),
    _mainCommand = skillTypeStaticWrapper:getSimpleCommand(),
    _iconPath = skillTypeStaticWrapper:getIconPath(),
    _desc = skillTypeStaticWrapper:getDescription(),
    _buffDesc = buffStr,
    _requireHp = skillStatic._requireHp,
    _requireMp = skillStatic._requireMp,
    _requireSp = skillStatic._requireSp,
    _reuseCycle = skillStatic._reuseCycle,
    _needCharacterLevel = skillStatic._needCharacterLevelForLearning,
    _needSkillPoint = skillStatic._needSkillPointForLearning,
    _blackSkillNo = skillStaticWrapper:getlinkBlackSkillNo(),
    _isCommand = skillTypeStaticWrapper:isSkillCommandCheck(),
    _isLock = ToClient_isBlockSkillCommand(skillLevelInfo._skillKey),
    _isActiveSkill = skillStaticWrapper:isActiveSkillHas(),
    _learndLevelMainSkill = 0,
    _learndLevelSubSkill = 0,
    _havePrevActionHashKey = havePrevActionHashKey
  }
  if false == skillInfo._usable or false == skillInfo._isCommand then
    skillInfo._isLock = false
  end
  return skillInfo
end
function PaGlobal_SkillGroup_Controller:updateEditMode(isEditMode)
  self._ui._btn_playSkill:SetShow(not isEditMode)
  self._ui._btn_cameraReset:SetShow(not isEditMode)
  self._ui._btn_playBlack:SetShow(not isEditMode and nil ~= PaGlobal_SkillGroup_Controller:getBlackSpiritSkillNo())
  self._isEditMode = isEditMode
  if true == isEditMode then
    self._ui._stc_descBg:SetShow(false)
  elseif nil ~= self._selectSkillNo then
    PaGloabl_SkillGroup_ShowDesc(self._selectSkillNo)
  end
end
function PaGlobal_SkillGroup_Controller:reset()
  isLdown = false
  isRdown = false
  xMovePos = 0
  yMovePos = 0
  self._selectSkillNo = 0
  self._ui._stc_descBg:SetShow(false)
  self:updateEditMode(false)
end
function PaGlobal_SkillGroup_Controller:HandleEventLUp_PlaySkill()
  PaGlobalFunc_SkillGroup_SkillAction(PaGlobal_SkillGroup._selectSkillNo)
end
function PaGlobal_SkillGroup_Controller:registEventHandler()
  if nil == Panel_Window_SkillGroup_Controller then
    return
  end
  local panel = Panel_Window_SkillGroup_Controller
  PaGlobal_SkillGroup_Controller._ui._btn_playSkill:addInputEvent("Mouse_LUp", "PaGlobal_SkillGroup_Controller:HandleEventLUp_PlaySkill()")
  PaGlobal_SkillGroup_Controller._ui._btn_cameraReset:addInputEvent("Mouse_LUp", "HandleEventLUp_SkillGroup_Controller_All_CameraReset()")
  PaGlobal_SkillGroup_Controller._ui._btn_playSkill:addInputEvent("Mouse_On", "PaGlobal_SkillGroup_Controller:TooltipShow(0)")
  PaGlobal_SkillGroup_Controller._ui._btn_cameraReset:addInputEvent("Mouse_On", "PaGlobal_SkillGroup_Controller:TooltipShow(1)")
  PaGlobal_SkillGroup_Controller._ui._btn_playBlack:addInputEvent("Mouse_On", "PaGlobal_SkillGroup_Controller:TooltipShow(2)")
  PaGlobal_SkillGroup_Controller._ui._btn_playSkill:addInputEvent("Mouse_Out", "PaGlobal_SkillGroup_Controller:TooltipHide()")
  PaGlobal_SkillGroup_Controller._ui._btn_cameraReset:addInputEvent("Mouse_Out", "PaGlobal_SkillGroup_Controller:TooltipHide()")
  PaGlobal_SkillGroup_Controller._ui._btn_playBlack:addInputEvent("Mouse_Out", "PaGlobal_SkillGroup_Controller:TooltipHide()")
  panel:addInputEvent("Mouse_LDown", "HandleClicked_SkillGroupController_SetCharacterRotate_Start(true)")
  panel:addInputEvent("Mouse_LUp", "HandleClicked_SkillGroupController_SetCharacterRotate_End(true)")
  panel:addInputEvent("Mouse_Out", "HandleClicked_SkillGroupController_SetCharacterRotate_End()")
  panel:addInputEvent("Mouse_RDown", "HandleClicked_SkillGroupController_SetCharacterRotate_Start(false)")
  panel:addInputEvent("Mouse_RUp", "HandleClicked_SkillGroupController_SetCharacterRotate_End(false)")
  panel:addInputEvent("Mouse_UpScroll", "HandleClicked_SkillGroupController_SetCharacterScroll(true)")
  panel:addInputEvent("Mouse_DownScroll", "HandleClicked_SkillGroupController_SetCharacterScroll(false)")
  panel:addInputEvent("Mouse_On", "PaGlobal_SkillGroup:HandleMOut_FrameOut()")
  PaGlobal_SkillGroup_Controller._ui._btn_playBlack:addInputEvent("Mouse_LUp", "PaGlobal_SkillGroup_Controller:showBlackSpirit()")
  panel:RegisterUpdateFunc("SkillGroupController_UpdateCharacterRotate")
  registerEvent("onScreenResize", "PaGlobal_SkillGroup_Controller_Resize")
end
function PaGlobal_SkillGroup_Controller:validate()
  if nil == Panel_Window_SkillGroup_Controller then
    return
  end
  local ui = self._ui
  ui._btn_playSkill:isValidate()
end
function PaGlobal_SkillGroup_Controller:showBlackSpirit()
  if nil == Panel_Window_SkillGroup_Controller then
    return
  end
  if false == self._isShowBlackSpiritSkill then
    local blackSkillNo = PaGlobal_SkillGroup_Controller:getBlackSpiritSkillNo()
    local skillStaticWrapper = getSkillStaticStatus(blackSkillNo, 1)
    if nil == skillStaticWrapper then
      return
    end
    ToClient_LearnSkillCameraStartSkillAction(skillStaticWrapper:get())
    PaGloabl_SkillGroup_ShowDesc(blackSkillNo, true)
  else
    local skillStaticWrapper = getSkillStaticStatus(self._selectSkillNo, 1)
    if nil == skillStaticWrapper then
      return
    end
    ToClient_LearnSkillCameraStartSkillAction(skillStaticWrapper:get())
    PaGloabl_SkillGroup_ShowDesc(self._selectSkillNo, true)
  end
end
function PaGlobal_SkillGroup_Controller:getBlackSpiritSkillNo()
  if true == self._isShowBlackSpiritSkill then
    return self._selectSkillNo
  end
  local skillStatic = getSkillStaticStatus(self._selectSkillNo, 1)
  if nil ~= skillStatic and false == self._isShowBlackSpiritSkill then
    local blackSkillNo = skillStatic:getlinkBlackSkillNo()
    local blackSkillTypeSS = getSkillTypeStaticStatus(blackSkillNo)
    if nil ~= blackSkillTypeSS and blackSkillTypeSS:isValidLocalizing() then
      return blackSkillNo
    end
  end
  return nil
end
function PaGlobal_SkillGroup_Controller:TooltipShow(index)
  if 0 == index then
    TooltipSimple_Show(self._ui._btn_playSkill, PAGetString(Defines.StringSheet_GAME, "LUA_PLAYSKILL"))
  elseif 1 == index then
    TooltipSimple_Show(self._ui._btn_cameraReset, PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SKILL_RESETCAMERA"))
  elseif 2 == index then
    TooltipSimple_Show(self._ui._btn_playBlack, PAGetString(Defines.StringSheet_GAME, "LUA_PLAY_BLACKSKILL"))
  end
end
function PaGlobal_SkillGroup_Controller:TooltipHide()
  TooltipSimple_Hide()
end
