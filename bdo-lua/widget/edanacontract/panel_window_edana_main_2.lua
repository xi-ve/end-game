function HandleEventMouseLup_FamilySkill_applySkill(familySkillKind, familySkillLevel)
  if nil == Panel_Window_FamilySkill_Main then
    return
  end
  local familySkillWrapper = ToClient_GetFamilySkillWrapperByKindAndLevel(familySkillKind, familySkillLevel)
  if nil == familySkillWrapper or false == familySkillWrapper:isSet() then
    return
  end
  local familySkillKey = familySkillWrapper:getFamilySkillKey()
  local rv = ToClient_RequestLearnFamilySkill(familySkillKey)
  if true == rv then
    local self = PaGlobal_Window_FamilySkill_Main
    self._learnFamilySkillKey = familySkillKey
  end
end
function HandleEventMouseLup_FamilySkill_clearSkill(familySkillKind, familySkillLevel)
  if nil == Panel_Window_FamilySkill_Main then
    return
  end
  local familySkillWrapper = ToClient_GetFamilySkillWrapperByKindAndLevel(familySkillKind, familySkillLevel)
  if nil == familySkillWrapper or false == familySkillWrapper:isSet() then
    return
  end
  local familySkillKey = familySkillWrapper:getFamilySkillKey()
  local rv = ToClient_RequestClearFamilySkill(familySkillKey)
end
function HandleEventMouseOn_FamilySkillGrade_ShowTooltip(isShowTooltip)
  if nil == Panel_Window_FamilySkill_Main then
    return
  end
  local self = PaGlobal_Window_FamilySkill_Main
  local familySkillList = PaGlobal_Window_FamilySkill_Main._ui._skillList
  if true == isShowTooltip then
    local listSize = ToClient_GetFamilySkillLevelListSize()
    local control = self._ui._skillPointTitleArray[self._ePoint.grade]
    local tooltipName = familySkillWrapper:getFamilySkillName()
    local tooltipDesc = familySkillWrapper:getFamilySkillDescription()
    local listContent = familySkillList:GetContentByKey(toInt64(0, listContentKey))
    if nil ~= control then
      tooltipDesc = PAGetString
      local skillIconBg = UI.getChildControl(listContent, "Static_SkillBg" .. familySkillKind)
      local skillIcon = UI.getChildControl(skillIconBg, "Static_SkillIcon" .. familySkillKind)
      if false == ToClient_IsLearnFamilySkill(skillkey) then
        tooltipDesc = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_FAMILYSKILL_TOOLTIP_NEEDPOINT", "point", needPoint) .. "\n" .. tooltipDesc
      end
      TooltipSimple_Show(skillIcon, tooltipName, tooltipDesc)
    end
  else
    TooltipSimple_Hide()
  end
end
function HandleEventMouseOn_FamilySkill_ShowTooltip(isShowTooltip, listContentKey, familySkillKind, familySkillLevel)
  if nil == Panel_Window_FamilySkill_Main then
    return
  end
  local familySkillList = PaGlobal_Window_FamilySkill_Main._ui._skillList
  if true == isShowTooltip then
    local familySkillWrapper = ToClient_GetFamilySkillWrapperByKindAndLevel(familySkillKind, familySkillLevel)
    local tooltipName = familySkillWrapper:getFamilySkillName()
    local tooltipDesc = familySkillWrapper:getFamilySkillDescription()
    local listContent = familySkillList:GetContentByKey(toInt64(0, listContentKey))
    local needPoint = familySkillWrapper:getNeedPoint()
    local skillkey = familySkillWrapper:getFamilySkillKey()
    if nil ~= listContent then
      local skillIconBg = UI.getChildControl(listContent, "Static_SkillBg" .. familySkillKind)
      local skillIcon = UI.getChildControl(skillIconBg, "Static_SkillIcon" .. familySkillKind)
      if false == ToClient_IsLearnFamilySkill(skillkey) then
        tooltipDesc = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_FAMILYSKILL_TOOLTIP_NEEDPOINT", "point", needPoint) .. "\n" .. tooltipDesc
      end
      TooltipSimple_Show(skillIcon, tooltipName, tooltipDesc)
    end
  else
    TooltipSimple_Hide()
  end
end
function HandleEventMOn_FamilySkill_ShowSkillKindTooltip(isShow, skillKindIdx)
  if nil == Panel_Window_FamilySkill_Main then
    return
  end
  if true == isShow then
    local content = PaGlobal_Window_FamilySkill_Main._ui._skillIconBgArray[skillKindIdx]
    local skillName = PaGlobal_Window_FamilySkill_Main._ui._skillIconTextArray[skillKindIdx]:GetText()
    TooltipSimple_Show(content, skillName, nil)
  else
    TooltipSimple_Hide()
  end
end
function HandleEventMouseLup_FamilySkill_resetSkill()
  if nil == Panel_Window_FamilySkill_Main then
    return
  end
  local messageboxData = {
    title = PAGetString(Defines.StringSheet_GAME, "LUA_EDANAMESSAGE_RESET_TITLE"),
    content = PAGetString(Defines.StringSheet_GAME, "LUA_EDANAMESSAGE_RESET_DESC"),
    functionYes = ToClient_RequestAllClearFamilySkill,
    functionNo = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageboxData)
end
function FromClient_UpdateFamilySkillExpAndPoint(isChangeExp, isChangePointOrGrade)
  if nil == Panel_Window_FamilySkill_Main then
    return
  end
  local self = PaGlobal_Window_FamilySkill_Main
  self:updatePointDescription()
  if true == isChangePointOrGrade then
    self:update()
  end
end
function FromClient_UpdateFamilySkill()
  if nil == Panel_Window_FamilySkill_Main then
    return
  end
  local self = PaGlobal_Window_FamilySkill_Main
  self:update()
end
function HandleEventChangeListContent_createSkillList(list_content, key)
  local self = PaGlobal_Window_FamilySkill_Main
  if nil == Panel_Window_FamilySkill_Main or false == self._initialize then
    return
  end
  if nil == getSelfPlayer() or nil == getSelfPlayer():get() then
    return
  end
  local playerGrade = ToClient_GetFamilySkillGrade()
  local listKey = Int64toInt32(key)
  local level = Int64toInt32(key)
  local skillKindCount = ToClient_GetFamilySkillKindCount()
  for skillKind = 0, skillKindCount - 1 do
    local skillLevel = level
    local skillIconBg = UI.getChildControl(list_content, "Static_SkillBg" .. skillKind)
    local gradeText = UI.getChildControl(skillIconBg, "StaticText_SkillGrade" .. skillKind)
    local skillIcon = UI.getChildControl(skillIconBg, "Static_SkillIcon" .. skillKind)
    local skillLearnIcon = UI.getChildControl(skillIconBg, "Static_EnableLearnIcon_" .. skillKind)
    local familySkillWrapper = ToClient_GetFamilySkillWrapperByKindAndLevel(skillKind, skillLevel)
    if nil ~= familySkillWrapper and false ~= familySkillWrapper:isSet() then
      local gradeLimit = familySkillWrapper:getLimitGrade()
      local currentSkillLevel = familySkillWrapper:getFamilySkillLevel()
      gradeText:SetShow(true)
      gradeText:SetText(tostring(gradeLimit))
      local skillKey = familySkillWrapper:getFamilySkillKey()
      local iconBackgroundFile = familySkillWrapper:getIconBackgroundPath()
      local iconFile = familySkillWrapper:getIconPath()
      local leftTopUV, rightBottomUV, x1, y1, x2, y2
      local isLearnSkill = false
      skillLearnIcon:SetShow(false)
      if true == ToClient_IsLearnFamilySkill(skillKey) then
        leftTopUV = familySkillWrapper:getBackgroundLeftTopUV()
        rightBottomUV = familySkillWrapper:getBackgroundRightBottomUV()
        isLearnSkill = true
        if skillKey == self._learnFamilySkillKey then
          skillIcon:EraseAllEffect()
          skillIcon:AddEffect("UI_NewSkill01", false, 0, 0)
          skillIcon:AddEffect("fUI_NewSkill01", false, 0, 0)
          self._learnFamilySkillKey = nil
        end
        local maxSkillLevel = ToClient_GetFamilySkillMaxLevel()
        if currentSkillLevel < maxSkillLevel then
          local nextSkillLevel = currentSkillLevel + 1
          local nextfamilySkillWrapper = ToClient_GetFamilySkillWrapperByKindAndLevel(skillKind, nextSkillLevel)
          if nil ~= nextfamilySkillWrapper and true == nextfamilySkillWrapper:isSet() then
            local nextSKillkey = nextfamilySkillWrapper:getFamilySkillKey()
            if false == ToClient_IsLearnFamilySkill(nextSKillkey) then
              skillIcon:addInputEvent("Mouse_RUp", "HandleEventMouseLup_FamilySkill_clearSkill(" .. skillKind .. ", " .. skillLevel .. ")")
            end
          end
        end
        if currentSkillLevel == maxSkillLevel then
          skillIcon:addInputEvent("Mouse_RUp", "HandleEventMouseLup_FamilySkill_clearSkill(" .. skillKind .. ", " .. skillLevel .. ")")
        end
      else
        leftTopUV = familySkillWrapper:getDefaultBackgroundLeftTopUV()
        rightBottomUV = familySkillWrapper:getDefaultBackgroundRightBottomUV()
        if playerGrade >= gradeLimit then
          if 0 == currentSkillLevel then
            skillLearnIcon:addInputEvent("Mouse_LUp", "HandleEventMouseLup_FamilySkill_applySkill(" .. skillKind .. ", " .. skillLevel .. ")")
            skillLearnIcon:addInputEvent("Mouse_On", "HandleEventMouseOn_FamilySkill_ShowTooltip(true, " .. listKey .. ", " .. skillKind .. ", " .. skillLevel .. ")")
            skillLearnIcon:addInputEvent("Mouse_Out", "HandleEventMouseOn_FamilySkill_ShowTooltip(false, " .. listKey .. ", " .. skillKind .. ", " .. skillLevel .. ")")
            skillLearnIcon:SetShow(true)
          end
          if 0 < currentSkillLevel then
            local preSkillLevel = currentSkillLevel - 1
            local prefamilySkillWrapper = ToClient_GetFamilySkillWrapperByKindAndLevel(skillKind, preSkillLevel)
            if nil ~= prefamilySkillWrapper and true == prefamilySkillWrapper:isSet() then
              local preSKillkey = prefamilySkillWrapper:getFamilySkillKey()
              if true == ToClient_IsLearnFamilySkill(preSKillkey) then
                skillLearnIcon:addInputEvent("Mouse_LUp", "HandleEventMouseLup_FamilySkill_applySkill(" .. skillKind .. ", " .. skillLevel .. ")")
                skillLearnIcon:addInputEvent("Mouse_On", "HandleEventMouseOn_FamilySkill_ShowTooltip(true, " .. listKey .. ", " .. skillKind .. ", " .. skillLevel .. ")")
                skillLearnIcon:addInputEvent("Mouse_Out", "HandleEventMouseOn_FamilySkill_ShowTooltip(false, " .. listKey .. ", " .. skillKind .. ", " .. skillLevel .. ")")
                skillLearnIcon:SetShow(true)
              end
            end
          end
        end
      end
      skillIconBg:ChangeTextureInfoName(iconBackgroundFile)
      x1, y1, x2, y2 = setTextureUV_Func(skillIconBg, leftTopUV.x, leftTopUV.y, rightBottomUV.x, rightBottomUV.y)
      skillIconBg:getBaseTexture():setUV(x1, y1, x2, y2)
      skillIconBg:setRenderTexture(skillIconBg:getBaseTexture())
      skillIconBg:SetShow(true)
      skillIcon:ChangeTextureInfoName(iconFile)
      if __eFamilySkillKind_Attack == skillKind then
        if true == isLearnSkill then
          x1, y1, x2, y2 = setTextureUV_Func(skillIcon, 2, 2, 46, 46)
        else
          x1, y1, x2, y2 = setTextureUV_Func(skillIcon, 2, 48, 46, 92)
        end
      elseif __eFamilySkillKind_Defense == skillKind then
        if true == isLearnSkill then
          x1, y1, x2, y2 = setTextureUV_Func(skillIcon, 48, 2, 92, 46)
        else
          x1, y1, x2, y2 = setTextureUV_Func(skillIcon, 48, 48, 92, 92)
        end
      elseif __eFamilySkillKind_Adrenalin == skillKind then
        if true == isLearnSkill then
          x1, y1, x2, y2 = setTextureUV_Func(skillIcon, 94, 2, 138, 46)
        else
          x1, y1, x2, y2 = setTextureUV_Func(skillIcon, 94, 48, 138, 92)
        end
      elseif __eFamilySkillKind_Market == skillKind then
        if true == isLearnSkill then
          x1, y1, x2, y2 = setTextureUV_Func(skillIcon, 140, 2, 184, 46)
        else
          x1, y1, x2, y2 = setTextureUV_Func(skillIcon, 140, 48, 184, 92)
        end
      end
      skillIcon:getBaseTexture():setUV(x1, y1, x2, y2)
      skillIcon:setRenderTexture(skillIcon:getBaseTexture())
      skillIcon:SetShow(true)
      skillIcon:addInputEvent("Mouse_LUp", "HandleEventMouseLup_FamilySkill_applySkill(" .. skillKind .. ", " .. skillLevel .. ")")
      skillIcon:addInputEvent("Mouse_On", "HandleEventMouseOn_FamilySkill_ShowTooltip(true, " .. listKey .. ", " .. skillKind .. ", " .. skillLevel .. ")")
      skillIcon:addInputEvent("Mouse_Out", "HandleEventMouseOn_FamilySkill_ShowTooltip(false, " .. listKey .. ", " .. skillKind .. ", " .. skillLevel .. ")")
    end
  end
end
function HandleEventChangeListContent_createSkillDescription(list_content, key)
  local self = PaGlobal_Window_FamilySkill_Main
  if nil == Panel_Window_FamilySkill_Main or false == self._initialize then
    return
  end
  local skillKind = Int64toInt32(key)
  local startLevel = 0
  local maxLevel = ToClient_GetFamilySkillMaxLevel()
  local skillValue = 0
  local familySkillWrapper
  local apply = false
  local skillDescriptionControl = UI.getChildControl(list_content, "StaticText_ResultDesc")
  skillDescriptionControl:SetText("")
  for level = startLevel, maxLevel do
    familySkillWrapper = ToClient_GetFamilySkillWrapperByKindAndLevel(skillKind, level)
    if nil == familySkillWrapper or false == familySkillWrapper:isSet() then
    else
      local skillKey = familySkillWrapper:getFamilySkillKey()
      if true == ToClient_IsLearnFamilySkill(skillKey) then
        skillValue = skillValue + familySkillWrapper:getParam()
        apply = true
      end
    end
  end
  if true == apply then
    local skillDescriptionText = ""
    if __eFamilySkillKind_Market == skillKind then
      local skillValue = skillValue / 10000
      skillDescriptionText = string.gsub(familySkillWrapper:getFamilySkillDescription(), "%d.%d+", skillValue)
    elseif __eFamilySkillKind_Adrenalin == skillKind then
      local skillValue = skillValue / 100
      skillDescriptionText = string.gsub(familySkillWrapper:getFamilySkillDescription(), "%d.%d+", skillValue)
    else
      skillDescriptionText = string.gsub(familySkillWrapper:getFamilySkillDescription(), "%d+", skillValue)
    end
    skillDescriptionControl:SetTextMode(__eTextMode_AutoWrap)
    skillDescriptionControl:SetText(skillDescriptionText)
    skillDescriptionControl:SetShow(true)
  else
    skillDescriptionText = string.gsub(familySkillWrapper:getFamilySkillDescription(), "%d+", 0)
    skillDescriptionControl:SetTextMode(__eTextMode_AutoWrap)
    skillDescriptionControl:SetText(skillDescriptionText)
    skillDescriptionControl:SetShow(true)
  end
end
