function PaGlobal_Fishing_All:initialize()
  if true == PaGlobal_Fishing_All._initialize then
    return
  end
  self._isConsole = _ContentsGroup_UsePadSnapping
  self._ui._stc_fishIcon_title = UI.getChildControl(Panel_Widget_Fishing_All, "Static_Minigame_Fish_Title")
  self._ui._txt_purpose = UI.getChildControl(Panel_Widget_Fishing_All, "StaticText_Purpose")
  self._ui._stc_fishBg = UI.getChildControl(Panel_Widget_Fishing_All, "Static_OnlyFishBG")
  self._ui._txt_fishPercent = UI.getChildControl(self._ui._stc_fishBg, "StaticText_OnlyFish")
  self._ui._txt_fishWpDesc = UI.getChildControl(Panel_Widget_Fishing_All, "StaticText_OnlyFishWpDesc")
  self._ui._stc_spaceImage = UI.getChildControl(Panel_Widget_Fishing_All, "StaticText_Btn_Space_2")
  self._ui._stc_keyguideA = UI.getChildControl(Panel_Widget_Fishing_All, "StaticText_A_ConsoleUI")
  self._ui._btn_spread = UI.getChildControl(self._ui._stc_fishBg, "Button_Spread")
  self._ui._stc_help = UI.getChildControl(self._ui._stc_fishBg, "Static_Help")
  self._ui._stc_consoleKey_LT = UI.getChildControl(self._ui._stc_fishBg, "StaticText_ConsoleKey_LT")
  self._ui._stc_abdPreventionBg = UI.getChildControl(Panel_Widget_Fishing_All, "Static_AbductionPreventionBG")
  self._ui._chk_abdPrevention = UI.getChildControl(self._ui._stc_abdPreventionBg, "CheckBox_AbductionPrevention")
  self._ui._stc_keyGuideY = UI.getChildControl(self._ui._chk_abdPrevention, "StaticText_KeyGuideY")
  self._ui._txt_dropTrashDesc = UI.getChildControl(self._ui._stc_abdPreventionBg, "StaticText_DropTrashDesc")
  self._ui._stc_keyGuideX = UI.getChildControl(self._ui._stc_abdPreventionBg, "StaticText_KeyGuideX")
  self._ui._chk_fishGradeTemplate = UI.getChildControl(self._ui._stc_abdPreventionBg, "CheckButton_FishGrade")
  self._ui._stc_Line = UI.getChildControl(self._ui._stc_abdPreventionBg, "Static_Line_Middle")
  self._gradeString[self._eGradeList._none] = PAGetString(Defines.StringSheet_GAME, "LUA_FISHING_DISCARD_ITEM_GRADE_0")
  self._gradeString[self._eGradeList._normal] = PAGetString(Defines.StringSheet_GAME, "LUA_FISHING_DISCARD_ITEM_GRADE_1")
  self._gradeString[self._eGradeList._magic] = PAGetString(Defines.StringSheet_GAME, "LUA_FISHING_DISCARD_ITEM_GRADE_2")
  self._gradeString[self._eGradeList._rare] = PAGetString(Defines.StringSheet_GAME, "LUA_FISHING_DISCARD_ITEM_GRADE_3")
  self._gradeString[self._eGradeList._unique] = PAGetString(Defines.StringSheet_GAME, "LUA_FISHING_DISCARD_ITEM_GRADE_4")
  self._ui._txt_fishPercent:SetTextMode(__eTextMode_LimitText)
  local dropDescSizeY = self._ui._txt_dropTrashDesc:GetSizeY()
  self._ui._txt_dropTrashDesc:SetTextMode(__eTextMode_AutoWrap)
  self._ui._txt_dropTrashDesc:SetText(self._ui._txt_dropTrashDesc:GetText())
  local dropTextSizeY = self._ui._txt_dropTrashDesc:GetTextSizeY()
  if dropDescSizeY < dropTextSizeY then
    local sizeY = dropTextSizeY - dropDescSizeY
    self._ui._stc_abdPreventionBg:SetSize(self._ui._stc_abdPreventionBg:GetSizeX(), self._ui._stc_abdPreventionBg:GetSizeY() + sizeY)
  end
  self._abdPreventionBgOriginSizeY = self._ui._stc_abdPreventionBg:GetSizeY()
  self:initShowControl_All()
  self:initAbduction()
  self:initAbductionReposition()
  self._ui._stc_keyGuideY:SetShow(self._isConsole)
  self._ui._stc_keyGuideX:SetShow(self._isConsole)
  self._ui._stc_consoleKey_LT:SetShow(self._isConsole)
  self._ui._stc_spaceImage:SetShow(not self._isConsole)
  self._ui._stc_keyguideA:SetShow(self._isConsole)
  if true == self._isConsole then
    self._ui._stc_help:SetShow(false)
    self._ui._txt_fishWpDesc:SetTextMode(__eTextMode_AutoWrap)
    self._ui._txt_fishWpDesc:SetText(self._ui._txt_fishWpDesc:GetText())
    self._ui._txt_fishWpDesc:SetShow(true)
  end
  local selfPlayer = getSelfPlayer()
  if nil ~= selfPlayer then
    self._currentSelectGrade = getSelfPlayer():getFishingAutoItemGrade()
  end
  local posX = self._ui._chk_fishGradeTemplate:GetPosX()
  local gapX = self._ui._chk_fishGradeTemplate:GetSizeX() + 10
  for i = 0, self._eGradeList._count - 1 do
    self._ui._chk_fishGradeList[i] = UI.cloneControl(self._ui._chk_fishGradeTemplate, self._ui._stc_abdPreventionBg, "RadioButton_FIshGrade" .. i)
    if nil ~= self._ui._chk_fishGradeList[i] then
      self._ui._chk_fishGradeList[i]:SetShow(true)
      self._ui._chk_fishGradeList[i]:SetPosX(posX + gapX * i)
      self._ui._stc_gradeColorList[i] = UI.getChildControl(self._ui._chk_fishGradeList[i], "Static_FishIcon")
      self._ui._stc_gradeColorList[i]:SetColor(self._gradeColor[i])
      self._ui._stc_gradeSelectList[i] = UI.getChildControl(self._ui._chk_fishGradeList[i], "Static_Select")
      self._ui._stc_gradeNoSetList[i] = UI.getChildControl(self._ui._chk_fishGradeList[i], "Static_NoSet")
      self._ui._stc_gradeNoSetList[i]:SetShow(i == self._eGradeList._none)
      self._ui._chk_fishGradeList[i]:ComputePos()
    end
  end
  local noneIcon = self._ui._stc_gradeColorList[self._eGradeList._none]
  noneIcon:ChangeTextureInfoName("combine/etc/combine_etc_minigame_01.dds")
  local x1, y1, x2, y2 = setTextureUV_Func(noneIcon, 159, 576, 204, 621)
  noneIcon:getBaseTexture():setUV(x1, y1, x2, y2)
  noneIcon:setRenderTexture(noneIcon:getBaseTexture())
  local noneSelectIcon = self._ui._stc_gradeSelectList[self._eGradeList._none]
  noneSelectIcon:ChangeTextureInfoName("combine/etc/combine_etc_minigame_01.dds")
  x1, y1, x2, y2 = setTextureUV_Func(noneSelectIcon, 205, 576, 250, 621)
  noneSelectIcon:getBaseTexture():setUV(x1, y1, x2, y2)
  noneSelectIcon:setRenderTexture(noneSelectIcon:getBaseTexture())
  self._ui._chk_fishGradeTemplate:SetShow(false)
  self._helpText = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_GLOBAL_MANUAL_ONLYFISHWPDESC") .. [[


]] .. PAGetString(Defines.StringSheet_GAME, "LUA_GLOBALMANUAL_FISHING_FISHERY_COMMENT")
  self._defaultPurposeSizeY = self._ui._txt_purpose:GetSizeY()
  self._ui._txt_purpose:SetTextMode(__eTextMode_AutoWrap)
  self:initActionChartEvent()
  self:initViewData()
  self:updateSpread()
  PaGlobal_Fishing_All:registEventHandler()
  PaGlobal_Fishing_All:validate()
  PaGlobal_Fishing_All._initialize = true
end
function PaGlobal_Fishing_All:registEventHandler()
  if nil == Panel_Widget_Fishing_All then
    return
  end
  Panel_Widget_Fishing_All:RegisterShowEventFunc(true, "PaGloabl_Fishing_All_ShowAni()")
  if false == self._isConsole then
    for i = 0, self._eGradeList._count - 1 do
      if nil ~= self._ui._chk_fishGradeList[i] then
        self._ui._chk_fishGradeList[i]:addInputEvent("Mouse_LUp", "HandleEventLUp_Fishing_All_SelectGrade(" .. self._eGradeList._none + i .. ")")
        self._ui._chk_fishGradeList[i]:addInputEvent("Mouse_On", "HandleEventOn_Fishing_All_ShowGradeTooltip(" .. self._eGradeList._none + i .. ")")
        self._ui._chk_fishGradeList[i]:addInputEvent("Mouse_Out", "HandleEventOut_Fishing_All_HideGradeTooltip()")
      end
    end
    self._ui._stc_help:addInputEvent("Mouse_On", "HandleEventOn_Fishing_All_ShowHelpTooltip()")
    self._ui._stc_help:addInputEvent("Mouse_Out", "HandleEventOut_Fishing_All_HideHelpTooltip()")
    self._ui._chk_abdPrevention:addInputEvent("Mouse_LUp", "HandleEventLUp_Fishing_All_AbdPreventionCheck()")
    self._ui._btn_spread:addInputEvent("Mouse_LUp", "HandleEventLUp_Fishing_All_Spread()")
  end
end
function PaGlobal_Fishing_All:prepareOpen()
  if nil == Panel_Widget_Fishing_All then
    return
  end
  if true == self._isConsole then
    PaGlobal_ConsoleQuickMenu:widgetOpen(false)
  end
  PaGlobal_Fishing_All:open()
end
function PaGlobal_Fishing_All:open()
  if nil == Panel_Widget_Fishing_All then
    return
  end
  Panel_Widget_Fishing_All:SetShow(true)
end
function PaGlobal_Fishing_All:prepareClose()
  if nil == Panel_Widget_Fishing_All then
    return
  end
  PaGlobal_Fishing_All:close()
end
function PaGlobal_Fishing_All:close()
  if nil == Panel_Widget_Fishing_All then
    return
  end
  Panel_Widget_Fishing_All:SetShow(false)
end
function PaGlobal_Fishing_All:update()
  if nil == Panel_Widget_Fishing_All then
    return
  end
end
function PaGlobal_Fishing_All:validate()
  if nil == Panel_Widget_Fishing_All then
    return
  end
end
function PaGlobal_Fishing_All:initShowControl_All()
  self._ui._stc_fishIcon_title:SetShow(false)
  self._ui._txt_purpose:SetShow(false)
  self._ui._stc_fishBg:SetShow(false)
  self._ui._txt_fishPercent:SetShow(false)
  self._ui._stc_spaceImage:SetShow(false)
  self._ui._stc_keyguideA:SetShow(false)
  self._ui._stc_abdPreventionBg:SetShow(false)
  self._ui._stc_fishIcon_title:ComputePos()
  self._ui._txt_purpose:ComputePos()
  self._ui._stc_fishBg:ComputePos()
  self._ui._txt_fishPercent:ComputePos()
  self._ui._stc_spaceImage:ComputePos()
  self._ui._stc_keyguideA:ComputePos()
  self._ui._stc_abdPreventionBg:ComputePos()
end
function PaGlobal_Fishing_All:initStateValue()
  self._stateValue._isFishing_Start = true
  self._stateValue._isFishing_0 = true
  self._stateValue._isFishing_1 = true
  self._stateValue._isFishing_2 = true
  self._stateValue._isJaksal_0 = true
  self._stateValue._isJaksal_1 = true
  self._stateValue._isJaksal_2 = true
  self._stateValue._isJaksal_3 = true
  self._stateValue._isJaksal_4 = true
  self._stateValue._isJaksal_5 = true
end
function PaGlobal_Fishing_All:initShowControl_Press()
  self._ui._stc_spaceImage:SetShow(false)
  self._ui._stc_spaceImage:ComputePos()
  self._ui._stc_keyguideA:SetShow(false)
  self._ui._stc_keyguideA:ComputePos()
end
function PaGlobal_Fishing_All:fishing_Start()
  if self._stateValue._isFishing_Start == true and false == self:isHideMiniGameManual() then
    self:initShowControl_All()
    self._helpText = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_GLOBAL_MANUAL_ONLYFISHWPDESC") .. [[


]] .. PAGetString(Defines.StringSheet_GAME, "LUA_GLOBALMANUAL_FISHING_FISHERY_COMMENT")
    PaGlobalFunc_Util_ChangeKeyguideTexture(self._ui._stc_keyguideA, __eActionInputType_Jump)
    self:prepareOpen()
    self._ui._chk_abdPrevention:SetCheck(ToClient_IsAbductionPreventionForFishing())
    self:initViewData()
    self._isViewData._abdPreventionBg = true
    self._isViewData._helpTooltip = true
    self._ui._txt_purpose:SetShow(true)
    self._ui._txt_purpose:AddEffect("UI_QustComplete01", false, 0, 0)
    local actionString = self:getJumpKeyString()
    if true == self._isConsole then
      self:SetTextPurpose(PAGetString(Defines.StringSheet_GAME, "LUA_XBOX1_GLOBALMANUAL_FISHING_START"))
    else
      self:SetTextPurpose(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GLOBALMANUAL_FISHING_START", "key", actionString))
    end
    self._ui._stc_spaceImage:SetShow(not self._isConsole)
    self._ui._stc_spaceImage:SetText(actionString)
    self._ui._stc_keyguideA:SetShow(self._isConsole)
    self._isJaksal = false
    self._ui._stc_fishBg:SetShow(true)
    self._ui._txt_fishPercent:SetShow(true)
    self:updateFishingResourceText(true)
    self._ui._stc_fishIcon_title:SetShow(true)
    self:updateReposition()
    self._stateValue._isFishing_Start = false
    self._isFishingStart = true
  end
end
function PaGlobal_Fishing_All:fishing_0()
  PaGlobal_PowerGauge_All_Close()
  if self._stateValue._isFishing_0 == true then
    self:initShowControl_All()
    self:prepareOpen()
    self._isViewData._abdPreventionBg = true
    self._isViewData._helpTooltip = true
    self._ui._txt_purpose:SetShow(true)
    self._ui._txt_purpose:AddEffect("UI_QustComplete01", false, 0, 0)
    self:SetTextPurpose(PAGetString(Defines.StringSheet_GAME, "LUA_GLOBALMANUAL_FISHING_0"))
    self._isJaksal = false
    self._ui._stc_fishBg:SetShow(true)
    self._ui._txt_fishPercent:SetShow(true)
    self:updateFishingResourceText(true)
    self._ui._stc_fishIcon_title:SetShow(true)
    self:updateReposition()
    self._stateValue._isFishing_0 = false
  end
end
function PaGlobal_Fishing_All:fishing_1()
  if self._stateValue._isFishing_1 == true then
    self:initShowControl_All()
    close_WindowPanelList()
    if nil ~= Panel_Menu and true == Panel_Menu:GetShow() then
      Panel_Menu:SetShow(false, false)
    elseif nil ~= Panel_Menu_New and true == Panel_Menu_New:GetShow() then
      Panel_Menu_New:SetShow(false, false)
    elseif nil ~= Panel_Widget_Menu_Remake and true == Panel_Widget_Menu_Remake:GetShow() then
      Panel_Widget_Menu_Remake:SetShow(false, false)
    end
    self._ui._txt_purpose:SetShow(true)
    self._ui._txt_purpose:AddEffect("UI_QustComplete01", false, 0, 0)
    local actionString = self:getJumpKeyString()
    if true == self._isConsole then
      self:SetTextPurpose(PAGetString(Defines.StringSheet_GAME, "LUA_XBOX1_GLOBALMANUAL_FISHING_1"))
    else
      self:SetTextPurpose(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GLOBALMANUAL_FISHING_1", "key", actionString))
    end
    self._ui._stc_fishIcon_title:SetShow(true)
    self._isJaksal = false
    self._ui._stc_fishBg:SetShow(true)
    self._ui._txt_fishPercent:SetShow(true)
    self:updateFishingResourceText(false)
    self._ui._stc_spaceImage:SetShow(false)
    self._ui._stc_keyguideA:SetShow(false)
    self:updateReposition()
    self._stateValue._isFishing_1 = false
  end
end
function PaGlobal_Fishing_All:fishing_2()
  if self._stateValue._isFishing_2 == true then
    self:initShowControl_Press()
    self._isViewData._abdPreventionBg = true
    self._isViewData._helpTooltip = true
    audioPostEvent_SystemUi(11, 6)
    self._ui._txt_purpose:SetShow(true)
    self._ui._txt_purpose:AddEffect("UI_QustComplete01", false, 0, 0)
    local actionString = self:getJumpKeyString()
    if true == self._isConsole then
      self:SetTextPurpose(PAGetString(Defines.StringSheet_GAME, "LUA_XBOX1_GLOBALMANUAL_FISHING_3"))
    else
      self:SetTextPurpose(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GLOBALMANUAL_FISHING_3", "key", actionString))
    end
    if true == self._isConsole then
      PaGlobal_ConsoleQuickMenu:widgetClose(false)
    end
    self._ui._stc_fishIcon_title:SetShow(true)
    self._ui._stc_spaceImage:SetShow(not self._isConsole)
    self._ui._stc_spaceImage:SetText(actionString)
    if false == self._isConsole then
      self._ui._stc_spaceImage:SetAlpha(0)
      self._ui._stc_spaceImage:SetFontAlpha(0)
      UIAni.AlphaAnimation(1, self._ui._stc_spaceImage, 0.5, 0.75)
    end
    self._ui._stc_keyguideA:SetShow(self._isConsole)
    self:updateReposition()
    self._stateValue._isFishing_2 = false
  end
end
function PaGlobal_Fishing_All:fishing_auto()
  self:initShowControl_Press()
  self._isViewData._abdPreventionBg = true
  self._isViewData._helpTooltip = true
  self:updateReposition()
end
function PaGlobal_Fishing_All:jaksal_0()
  if self._stateValue._isJaksal_0 == true and false == self:isHideMiniGameManual() then
    self:initShowControl_All()
    self._helpText = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_GLOBAL_MANUAL_ONLYFISHWPDESC") .. [[


]] .. PAGetString(Defines.StringSheet_GAME, "LUA_GLOBALMANUAL_FISHING_FISHERY_COMMENT")
    self:prepareOpen()
    self:initViewData()
    self._isViewData._abdPreventionBg = true
    self._isViewData._helpTooltip = false
    self._isJaksal = true
    self._ui._stc_fishBg:SetShow(true)
    self._ui._txt_fishPercent:SetShow(true)
    self:updateFishingResourceText(true)
    self._ui._txt_purpose:SetShow(true)
    self._ui._txt_purpose:AddEffect("UI_QustComplete01", false, 0, 0)
    self:SetTextPurpose(PAGetString(Defines.StringSheet_GAME, "LUA_GLOBALMANUAL_Fishing_Use"))
    self._ui._stc_fishIcon_title:SetShow(true)
    self._ui._stc_spaceImage:SetShow(not self._isConsole)
    self._ui._stc_spaceImage:SetText(self:getJumpKeyString())
    self._ui._stc_keyguideA:SetShow(self._isConsole)
    self:updateReposition()
    self._stateValue._isJaksal_0 = false
  end
  self._isFishingStart = true
end
function PaGlobal_Fishing_All:jaksal_1()
  if self._stateValue._isJaksal_1 == true then
    self:initShowControl_All()
    self:prepareOpen()
    self._isViewData._abdPreventionBg = true
    self._isViewData._helpTooltip = false
    self._isJaksal = true
    self._ui._stc_fishBg:SetShow(true)
    self._ui._txt_fishPercent:SetShow(true)
    self:updateFishingResourceText(true)
    self._ui._txt_purpose:SetShow(true)
    self._ui._txt_purpose:AddEffect("UI_QustComplete01", false, 0, 0)
    self:SetTextPurpose(PAGetString(Defines.StringSheet_GAME, "LUA_GLOBALMANUAL_Fishing_Finding"))
    self._ui._stc_fishIcon_title:SetShow(true)
    self._ui._stc_spaceImage:SetShow(false)
    self._ui._stc_keyguideA:SetShow(false)
    self:updateReposition()
    self._stateValue._isJaksal_0 = true
    self._stateValue._isJaksal_1 = false
  end
end
function PaGlobal_Fishing_All:jaksal_2()
  if self._stateValue._isJaksal_2 == true then
    self:initShowControl_All()
    self:prepareOpen()
    self._isViewData._abdPreventionBg = true
    self._isViewData._helpTooltip = false
    self._isJaksal = true
    self._ui._stc_fishBg:SetShow(true)
    self._ui._txt_fishPercent:SetShow(true)
    self:updateFishingResourceText(true)
    self._ui._txt_purpose:SetShow(true)
    self._ui._txt_purpose:AddEffect("UI_QustComplete01", false, 0, 0)
    self:SetTextPurpose(PAGetString(Defines.StringSheet_GAME, "LUA_GLOBALMANUAL_Fishing_Find"))
    self._ui._stc_fishIcon_title:SetShow(true)
    self._ui._stc_spaceImage:SetShow(not self._isConsole)
    self._ui._stc_keyguideA:SetShow(self._isConsole)
    self:updateReposition()
    self._stateValue._isJaksal_0 = true
    self._stateValue._isJaksal_1 = false
    self._stateValue._isJaksal_2 = false
  end
end
function PaGlobal_Fishing_All:jaksal_3()
  if self._stateValue._isJaksal_3 == true then
    self:initShowControl_All()
    self:prepareOpen()
    close_WindowPanelList()
    if nil ~= Panel_Menu and true == Panel_Menu:GetShow() then
      Panel_Menu:SetShow(false, false)
    elseif nil ~= Panel_Menu_New and true == Panel_Menu_New:GetShow() then
      Panel_Menu_New:SetShow(false, false)
    elseif nil ~= Panel_Widget_Menu_Remake and true == Panel_Widget_Menu_Remake:GetShow() then
      Panel_Widget_Menu_Remake:SetShow(false, false)
    end
    self._isViewData._abdPreventionBg = true
    self._isViewData._helpTooltip = false
    self._isJaksal = true
    self._ui._stc_fishBg:SetShow(true)
    self._ui._txt_fishPercent:SetShow(true)
    self:updateFishingResourceText(true)
    self._ui._txt_purpose:SetShow(true)
    self._ui._txt_purpose:AddEffect("UI_QustComplete01", false, 0, 0)
    if true == self._isConsole then
      self:SetTextPurpose(PAGetString(Defines.StringSheet_GAME, "LUA_GLOBALMANUAL_CONSOLE_FISHING_SIGHT"))
    else
      self:SetTextPurpose(PAGetString(Defines.StringSheet_GAME, "LUA_GLOBALMANUAL_Fishing_Sight"))
    end
    self._ui._stc_fishIcon_title:SetShow(true)
    self._ui._stc_spaceImage:SetShow(not self._isConsole)
    self._ui._stc_keyguideA:SetShow(self._isConsole)
    self:updateReposition()
    self._stateValue._isJaksal_0 = true
    self._stateValue._isJaksal_1 = false
    self._stateValue._isJaksal_2 = false
    self._stateValue._isJaksal_3 = false
  end
end
function PaGlobal_Fishing_All:jaksal_4()
  if self._stateValue._isJaksal_4 == true then
    self:initShowControl_All()
    self:prepareOpen()
    self._isViewData._abdPreventionBg = true
    self._isViewData._helpTooltip = false
    self._isJaksal = true
    self._ui._stc_fishBg:SetShow(true)
    self._ui._txt_fishPercent:SetShow(true)
    self:updateFishingResourceText(true)
    self._ui._txt_purpose:SetShow(true)
    self._ui._txt_purpose:AddEffect("UI_QustComplete01", false, 0, 0)
    self:SetTextPurpose(PAGetString(Defines.StringSheet_GAME, "LUA_GLOBALMANUAL_Fishing_Success"))
    self._ui._stc_fishIcon_title:SetShow(true)
    self._ui._stc_spaceImage:SetShow(not self._isConsole)
    self._ui._stc_keyguideA:SetShow(self._isConsole)
    self:updateReposition()
    self._stateValue._isJaksal_0 = true
    self._stateValue._isJaksal_1 = false
    self._stateValue._isJaksal_2 = false
    self._stateValue._isJaksal_3 = false
    self._stateValue._isJaksal_4 = false
  end
end
function PaGlobal_Fishing_All:jaksal_5()
  if self._stateValue._isJaksal_5 == true then
    self:initShowControl_All()
    self:prepareOpen()
    self._isViewData._abdPreventionBg = true
    self._isViewData._helpTooltip = false
    self._isJaksal = true
    self._ui._stc_fishBg:SetShow(true)
    self._ui._txt_fishPercent:SetShow(true)
    self:updateFishingResourceText(true)
    self._ui._txt_purpose:SetShow(true)
    self._ui._txt_purpose:AddEffect("UI_QustComplete01", false, 0, 0)
    self:SetTextPurpose(PAGetString(Defines.StringSheet_GAME, "LUA_GLOBALMANUAL_Fishing_Fail"))
    self._ui._stc_fishIcon_title:SetShow(true)
    self._ui._stc_spaceImage:SetShow(not self._isConsole)
    self._ui._stc_keyguideA:SetShow(self._isConsole)
    self:updateReposition()
    self._stateValue._isJaksal_0 = true
    self._stateValue._isJaksal_1 = false
    self._stateValue._isJaksal_2 = false
    self._stateValue._isJaksal_3 = false
    self._stateValue._isJaksal_4 = false
    self._stateValue._isJaksal_5 = false
  end
end
function PaGlobal_Fishing_All:isHideMiniGameManual()
  local uiMode = GetUIMode()
  return getCustomizingManager():isShow() or uiMode == Defines.UIMode.eUIMode_NpcDialog or uiMode == Defines.UIMode.eUIMode_InGameCashShop or uiMode == Defines.UIMode.eUIMode_Mental or uiMode == Defines.UIMode.eUIMode_DyeNew
end
function PaGlobal_Fishing_All:setFishingAutoItemGrade(itemGrade)
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  selfPlayer:setFishingAutoItemGrade(itemGrade)
end
function PaGlobal_Fishing_All:updateFishingResourceText(isDropTrashShow)
  local fishComment_head = PAGetString(Defines.StringSheet_GAME, "LUA_MINIGAME_FISH_POOL_HEAD")
  local fishingPercent = math.floor(ToClient_CurrentFishingData() * 100)
  if 71 <= fishingPercent and fishingPercent <= 100 then
    fishComment = fishComment_head .. " " .. PAGetString(Defines.StringSheet_GAME, "LUA_MINIGAME_FISH_POOL_VALUE_1")
  elseif 46 <= fishingPercent and fishingPercent <= 70 then
    fishComment = fishComment_head .. " " .. PAGetString(Defines.StringSheet_GAME, "LUA_MINIGAME_FISH_POOL_VALUE_2")
  elseif 15 <= fishingPercent and fishingPercent <= 45 then
    fishComment = fishComment_head .. " " .. PAGetString(Defines.StringSheet_GAME, "LUA_MINIGAME_FISH_POOL_VALUE_3")
  elseif fishingPercent <= 14 and 0 <= fishingPercent then
    fishComment = fishComment_head .. " " .. PAGetString(Defines.StringSheet_GAME, "LUA_MINIGAME_FISH_POOL_VALUE_4")
  end
  self._ui._txt_fishPercent:SetText(fishComment)
  self:updateSpread()
  self:updateReposition()
end
function PaGlobal_Fishing_All:initActionChartEvent()
  ActionChartEventBindFunction(211, PaGlobal_Fishing_All_Fishing_0)
  ActionChartEventBindFunction(212, PaGlobal_Fishing_All_Fishing_1)
  ActionChartEventBindFunction(214, PaGlobal_Fishing_All_Fishing_Start)
  ActionChartEventBindFunction(215, PaGlobal_Fishing_All_Fishing_2)
  ActionChartEventBindFunction(216, PaGlobal_Fishing_All_CommonGaugeOpen)
  ActionChartEventBindFunction(217, PaGlobal_Fishing_All_CannonGaugeOpen)
  ActionChartEventBindFunction(218, PaGlobal_Fishing_All_Fishing_Auto)
  ActionChartEventBindFunction(219, PaGlobal_Fishing_All_Fishing_Wait)
  ActionChartEventBindFunction(281, PaGlobal_Fishing_All_Jaksal_0)
  ActionChartEventBindFunction(282, PaGlobal_Fishing_All_Jaksal_1)
  ActionChartEventBindFunction(283, PaGlobal_Fishing_All_Jaksal_2)
  ActionChartEventBindFunction(284, PaGlobal_Fishing_All_Jaksal_3)
  ActionChartEventBindFunction(285, PaGlobal_Fishing_All_Jaksal_4)
  ActionChartEventBindFunction(286, PaGlobal_Fishing_All_Jaksal_5)
end
function PaGlobal_Fishing_All:initAbduction()
  local enableAreaX = self._ui._chk_abdPrevention:GetTextSizeX() + self._ui._chk_abdPrevention:GetTextSpan().x
  local enableAreaY = self._ui._chk_abdPrevention:GetSizeY()
  self._ui._chk_abdPrevention:SetEnableArea(0, 0, enableAreaX, enableAreaY)
  self._ui._chk_abdPrevention:SetCheck(ToClient_IsAbductionPreventionForFishing())
end
function PaGlobal_Fishing_All:settingAbduction()
  local selfplayer = getSelfPlayer()
  if nil == selfplayer or nil == selfplayer:get() then
    return
  end
  selfplayer:get():sendAbductionPreventionForFishing(self._ui._chk_abdPrevention:IsCheck())
end
function PaGlobal_Fishing_All:updateReposition()
  self._ui._txt_purpose:ComputePos()
  self._ui._stc_fishBg:ComputePos()
  self._ui._stc_abdPreventionBg:ComputePos()
  self._ui._stc_spaceImage:ComputePos()
  self._ui._stc_keyguideA:ComputePos()
  local posY = self:updatePosition(self._ui._txt_purpose, self._ui._txt_purpose:GetPosY())
  posY = self:updatePosition(self._ui._stc_fishBg, posY, 0)
  posY = self:updatePosition(self._ui._stc_abdPreventionBg, posY, 0)
  if true == self._isConsole then
    posY = posY + 10
    posY = self:updatePosition(self._ui._txt_fishWpDesc, posY)
  end
  if true == self._isConsole then
    posY = self:updatePosition(self._ui._stc_keyguideA, posY)
  else
    posY = self:updatePosition(self._ui._stc_spaceImage, posY)
  end
end
function PaGlobal_Fishing_All:updatePosition(content, posY, addSizeY)
  if false == content:GetShow() then
    return posY
  end
  if nil == addSizeY then
    addSizeY = 10
  end
  content:SetPosY(posY)
  posY = posY + content:GetSizeY() + addSizeY
  return posY
end
function PaGlobal_Fishing_All:getJumpKeyString()
  local actionString = ""
  if getGamePadEnable() then
    actionString = keyCustom_GetString_ActionPad(self._gameOptionActionKey.Jump)
  else
    actionString = keyCustom_GetString_ActionKey(self._gameOptionActionKey.Jump)
  end
  return actionString
end
function PaGlobal_Fishing_All:initAbductionReposition()
  local abdBgSizeX = self._ui._stc_abdPreventionBg:GetSizeX()
  local abdChkBoxSizeX = self._ui._chk_abdPrevention:GetSizeX() + self._ui._chk_abdPrevention:GetTextSizeX()
  if true == self._isConsole then
    abdChkBoxSizeX = abdChkBoxSizeX + self._ui._stc_keyGuideY:GetSizeX()
  end
  local abdPosX = (abdBgSizeX - abdChkBoxSizeX) * 0.5
  self._ui._chk_abdPrevention:SetPosX(abdPosX)
end
function PaGlobal_Fishing_All:SetTextPurpose(strText)
  self._ui._txt_purpose:SetText(strText)
  local textSizeY = self._ui._txt_purpose:GetTextSizeY()
  if textSizeY > self._defaultPurposeSizeY then
    self._ui._txt_purpose:SetSize(self._ui._txt_purpose:GetSizeX(), textSizeY + 10)
  else
    self._ui._txt_purpose:SetSize(self._ui._txt_purpose:GetSizeX(), self._defaultPurposeSizeY)
  end
end
function PaGlobal_Fishing_All:updateSpread()
  local texUV
  if true == self._isSpreading then
    texUV = {
      x1 = 64,
      y1 = 176,
      x2 = 84,
      y2 = 196
    }
    self._ui._stc_abdPreventionBg:SetShow(self._isViewData._abdPreventionBg)
  else
    texUV = {
      x1 = 43,
      y1 = 176,
      x2 = 63,
      y2 = 196
    }
    self._ui._stc_abdPreventionBg:SetShow(false)
  end
  if nil ~= texUV then
    self._ui._btn_spread:ChangeTextureInfoName("combine/btn/combine_btn_00.dds")
    local x1, y1, x2, y2 = setTextureUV_Func(self._ui._btn_spread, texUV.x1, texUV.y1, texUV.x2, texUV.y2)
    self._ui._btn_spread:getBaseTexture():setUV(x1, y1, x2, y2)
    self._ui._btn_spread:setRenderTexture(self._ui._btn_spread:getBaseTexture())
  end
  if self._isJaksal then
    self._ui._txt_dropTrashDesc:SetShow(false)
    for i = 0, self._eGradeList._count - 1 do
      self._ui._chk_fishGradeList[i]:SetShow(false)
      self._ui._stc_gradeColorList[i]:SetShow(false)
      self._ui._stc_gradeSelectList[i]:SetShow(false)
      self._ui._stc_gradeNoSetList[i]:SetShow(false)
    end
    self._ui._stc_Line:SetShow(false)
    self._ui._stc_keyGuideX:SetShow(false)
    self._ui._stc_abdPreventionBg:SetSize(self._ui._stc_abdPreventionBg:GetSizeX(), self._ui._stc_Line:GetPosY() + self._ui._stc_Line:GetSizeY())
  else
    self._ui._txt_dropTrashDesc:SetShow(true)
    for i = 0, self._eGradeList._count - 1 do
      self._ui._chk_fishGradeList[i]:SetShow(true)
      self._ui._stc_gradeColorList[i]:SetShow(true)
      self._ui._stc_gradeSelectList[i]:SetShow(true)
      self._ui._stc_gradeNoSetList[i]:SetShow(i == self._eGradeList._none)
    end
    self._ui._stc_Line:SetShow(true)
    self._ui._stc_keyGuideX:SetShow(self._isConsole)
    self._ui._stc_abdPreventionBg:SetSize(self._ui._stc_abdPreventionBg:GetSizeX(), self._abdPreventionBgOriginSizeY)
  end
  HandleEventLUp_Fishing_All_SelectGrade(self._currentSelectGrade)
  self._ui._stc_help:SetShow(self._isViewData._helpTooltip and not self._isConsole)
  self._ui._txt_fishWpDesc:SetShow(self._isViewData._helpTooltip and self._isConsole)
  self:updateReposition()
end
function PaGlobal_Fishing_All:ShowAbdPreventionBg()
  if false == self._isSpreading then
    return
  end
  self._ui._stc_abdPreventionBg:SetShow(true)
end
function PaGlobal_Fishing_All:initViewData()
  self._isViewData._abdPreventionBg = false
  self._isViewData._helpTooltip = false
end
