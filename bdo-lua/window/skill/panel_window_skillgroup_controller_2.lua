function PaGloabl_SkillGroup_ShowDesc(skillNo, isBlackSpirit)
  local self = PaGlobal_SkillGroup_Controller
  if false == Panel_Window_SkillGroup_Controller:GetShow() then
    return
  end
  local skillInfo = self:getSkillInfo(skillNo)
  local selfPlayerActorProxy = getSelfPlayer():get()
  if nil == selfPlayerActorProxy then
    return
  end
  if nil == isBlackSpirit then
    self._selectSkillNo = skillNo
    self._isShowBlackSpiritSkill = false
  else
    self._selectSkillNo = skillNo
    self._isShowBlackSpiritSkill = true
  end
  if true == self._isEditMode then
    return
  end
  if nil ~= skillInfo then
    local ui = self._ui
    local TooltipYPos = 0
    local elementGap = 10
    ui._stc_skillIcon:ChangeTextureInfoName("Icon/" .. skillInfo._iconPath)
    ui._txt_skillName:SetText(skillInfo._name)
    ui._txt_skillName:SetSize(ui._txt_skillName:GetSizeX(), ui._txt_skillName:GetTextSizeY())
    ui._txt_skillDesc:SetText(skillInfo._desc)
    local isShowCommand = "" ~= skillInfo._command
    ui._txt_skillCommandDesc:SetShow(isShowCommand)
    if true == isShowCommand then
      ui._txt_skillCommandDesc:SetText(skillInfo._command)
    end
    if true == self._isShowBlackSpiritSkill then
      ui._txt_skillNeedResource:SetText("")
      ui._txt_requiredLevel:SetText("")
      ui._txt_requiredSkillPoint:SetText("")
      ui._txt_reuseCycle:SetText("")
    else
      local needResource = ""
      local selfPlayerLevel = selfPlayerActorProxy:getLevel()
      if selfPlayerLevel >= skillInfo._needCharacterLevel then
        needResource = needResource .. "<PAColor0xFFEEEEEE>"
      else
        needResource = needResource .. "<PAColor0xFFDDA309>"
      end
      if 0 == skillInfo._needCharacterLevel then
        needResource = needResource .. self._fixedDescString._level .. " : " .. PAGetString(Defines.StringSheet_GAME, "Lua_TooltipSkill_QuestGain") .. "<PAOldColor>\n"
      else
        needResource = needResource .. self._fixedDescString._level .. " : " .. PAGetStringParam1(Defines.StringSheet_GAME, "LUA_WINDOW_SKILL_CONTROLLER_NEEDLEVEL", "needLvLearning", skillInfo._needCharacterLevel) .. "<PAOldColor>\n"
      end
      if skillInfo._needSkillPoint <= PaGlobal_SkillGroup._remainSkillPoint then
        needResource = needResource .. "<PAColor0xFFEEEEEE>"
      else
        needResource = needResource .. "<PAColor0xFFDDA309>"
      end
      needResource = needResource .. self._fixedDescString._skillPoint .. " : " .. skillInfo._needSkillPoint .. "<PAOldColor>\n"
      if 1 < skillInfo._requireHp then
        needResource = needResource .. PAGetString(Defines.StringSheet_GAME, "LUA_SKILLWINDOW_ALL_DESC_NEED_HP") .. " : " .. skillInfo._requireHp .. "\n"
      end
      if 1 < skillInfo._requireMp then
        needResource = needResource .. self._fixedDescString._needMantalString .. " : " .. skillInfo._requireMp .. "\n"
      end
      if 1 < skillInfo._requireSp then
        needResource = needResource .. PAGetString(Defines.StringSheet_GAME, "LUA_SKILLWINDOW_ALL_DESC_NEED_SP") .. " : " .. skillInfo._requireSp .. "\n"
      end
      needResource = needResource .. self._fixedDescString._reuseCycle .. " : " .. convertStringFromDatetimeForSkillTooltip(skillInfo._reuseCycle / 1000) .. "<PAOldColor>"
      ui._txt_skillNeedResource:SetText(needResource)
      ui._txt_requiredSkillPoint:SetShow(false)
      ui._txt_reuseCycle:SetShow(false)
    end
    ui._btn_playSkill:SetShow(skillInfo._havePrevActionHashKey)
    if nil ~= PaGlobal_SkillGroup_Controller:getBlackSpiritSkillNo() then
      ui._btn_playBlack:SetShow(true)
    else
      ui._btn_playBlack:SetShow(false)
    end
    TooltipYPos = SkillGroup_GetControlBottomPos(ui._txt_skillName) + elementGap
    ui._txt_skillDesc:SetPosY(TooltipYPos)
    TooltipYPos = SkillGroup_GetControlBottomPos(ui._txt_skillDesc) + elementGap
    if isShowCommand then
      ui._txt_skillCommandDesc:SetPosY(TooltipYPos + elementGap)
      TooltipYPos = SkillGroup_GetControlBottomPos(ui._txt_skillCommandDesc) + elementGap
    end
    local needResourcePosX = getScreenSizeX() - Panel_Window_SkillGroup:GetSizeX() - ui._txt_skillNeedResource:GetTextSizeX() - PaGlobal_SkillGroup._skillPreset.stc_presetBG:GetSizeX() - 100
    local leftDescSize = needResourcePosX - ui._txt_skillEffectDesc:GetPosX() - 10
    ui._txt_skillEffectDesc:SetSize(leftDescSize, ui._txt_skillEffectDesc:GetSizeY())
    ui._txt_skillEffectDesc:ComputePos()
    ui._txt_skillEffectDesc:SetText(skillInfo._buffDesc)
    ui._txt_skillEffectTitle:SetPosY(ui._txt_skillEffectDesc:GetPosY() - ui._txt_skillEffectDesc:GetTextSizeY() + ui._txt_skillEffectDesc:GetSizeY() - ui._txt_skillEffectTitle:GetSizeY() - 5)
    ui._txt_skillNeedResource:ComputePos()
    ui._txt_skillNeedResource:SetPosX(needResourcePosX)
    ui._txt_skillNeedResource:SetPosY(ui._txt_skillEffectDesc:GetPosY() - ui._txt_skillNeedResource:GetTextSizeY() + ui._txt_skillEffectDesc:GetSizeY())
    if "" == skillInfo._buffDesc then
      ui._txt_skillEffectTitle:SetShow(false)
    else
      ui._txt_skillEffectTitle:SetShow(true)
    end
    self._ui._stc_descBg:SetShow(true)
  else
    self._ui._stc_descBg:SetShow(false)
  end
end
function PaGloabl_SkillPlayIcon_HideAni(skillNo)
end
function PaGlobal_SkillGroup_Controller_Resize()
  local self = PaGlobal_SkillGroup_Controller
  local panel = Panel_Window_SkillGroup_Controller
  local ui = self._ui
  panel:ComputePos()
  panel:SetSize(getScreenSizeX() - Panel_Window_SkillGroup:GetSizeX() - 10, getScreenSizeY())
  ui._btn_playSkill:ComputePos()
  ui._btn_cameraReset:ComputePos()
  ui._btn_playBlack:ComputePos()
  ui._btn_playSkill:SetPosX(Panel_Window_SkillGroup_Controller:GetSizeX() / 2 - ui._btn_playSkill:GetSizeX())
  ui._btn_cameraReset:SetPosX(ui._btn_playSkill:GetPosX() + ui._btn_playSkill:GetSizeX() + 10)
  ui._btn_playBlack:SetPosX(Panel_Window_SkillGroup_Controller:GetSizeX() / 2 - ui._btn_playSkill:GetSizeX() - ui._btn_playBlack:GetSizeX() - 10)
  ui._btn_playBlack:SetText("")
  ui._stc_descBg:SetPosX(panel:GetPosX())
  ui._stc_descBg:SetPosY(panel:GetPosY())
  ui._stc_descBg:SetSize(panel:GetSizeX(), panel:GetSizeY())
  ui._stc_descBg:ComputePos()
  ui._stc_skillIcon:ComputePos()
  ui._txt_skillName:ComputePos()
  ui._txt_skillDesc:ComputePos()
  ui._txt_skillCommandDesc:ComputePos()
  ui._txt_skillEffectTitle:ComputePos()
  ui._txt_skillEffectDesc:ComputePos()
  ui._txt_skillNeedResource:ComputePos()
  ui._txt_requiredLevel:ComputePos()
  ui._txt_requiredSkillPoint:ComputePos()
  ui._txt_reuseCycle:ComputePos()
end
function PaGlobalFunc_SkillGroup_SkillAction(skillNo)
  local skillStaticWrapper = getSkillStaticStatus(skillNo, 1)
  if nil == skillStaticWrapper then
    return
  end
  ToClient_LearnSkillCameraStartSkillAction(skillStaticWrapper:get())
  PaGloabl_SkillGroup_ShowDesc(skillNo)
end
function HandleClicked_SkillGroupController_SetCharacterRotate_Start(isLDown)
  local self = PaGlobal_SkillGroup_Controller
  if isLDown then
    self.isLdown = true
  else
    self.isRdown = true
  end
  self.xMovePos = getMousePosX()
  self.yMovePos = getMousePosY()
end
function HandleClicked_SkillGroupController_SetCharacterRotate_End(isLDown)
  local self = PaGlobal_SkillGroup_Controller
  if nil == isLDown then
    self.isLdown = false
    self.isRdown = false
  elseif isLDown then
    self.isLdown = false
  else
    self.isRdown = false
  end
  if true == isLDown and false == PaGlobal_SkillGroup._isDraggingFromTree and DragManager.groundClickFunc ~= nil then
    DragManager.groundClickFunc(DragManager.dragWhereTypeInfo, DragManager.dragSlotInfo)
    if DragManager.dragStartPanel == Panel_Window_SkillGroup_QuickSlot then
      DragManager:clearInfo()
      PaGlobal_SkillGroup_QuickSlot:update()
    end
  end
end
function HandleClicked_SkillGroupController_SetCharacterScroll(isUp)
  local upValue = 25
  if true == isUp then
    upValue = -upValue
  end
  ToClient_LearnSkillCameraSetZoom(upValue)
end
function HandleEventLUp_SkillGroup_Controller_All_CameraReset()
  if Defines.UIMode.eUIMode_SkillWindow ~= GetUIMode() or false == Panel_Window_SkillGroup_Controller:GetShow() then
    return
  end
  if false == PaGlobal_SkillGroup_Controller._ui._btn_cameraReset:GetShow() then
    return
  end
  ToClient_LearnSkillCameraReset()
  ToClient_LearnSkillCameraSetZoom(200)
  ToClient_LearnSkillCameraSetPosition(70, -10)
  ToClient_LearnSkillCameraSetRotation(-2.5, -0.3)
end
function SkillGroupController_UpdateCharacterRotate(deltatime)
  local self = PaGlobal_SkillGroup_Controller
  if false == self.isLdown and false == self.isRdown then
    return
  end
  if DragManager.dragStartPanel ~= nil then
    return
  end
  local currPosX = getMousePosX()
  local currPosY = getMousePosY()
  if currPosX == self.xMovePos and currPosY == self.yMovePos then
    return
  end
  local radianAngle = (self.xMovePos - currPosX) / (getScreenSizeX() / 10)
  local cameraPitch = (currPosY - self.yMovePos) / (getScreenSizeY() / 2)
  if self.isLdown then
    ToClient_LearnSkillCameraSetPosition(radianAngle * 30, cameraPitch * 90)
  end
  if self.isRdown then
    ToClient_LearnSkillCameraSetRotation(-radianAngle * 0.8, -(cameraPitch * 2))
  end
  self.xMovePos = currPosX
  self.yMovePos = currPosY
end
