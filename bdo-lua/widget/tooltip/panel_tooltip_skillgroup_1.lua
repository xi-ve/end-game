function PaGlobal_TooltipSkill_All:initialize()
  self._isConsole = _ContentsGroup_RenewUI
  PaGlobal_TooltipSkill_All:controlInit()
  PaGlobal_TooltipSkill_All:controlNextInit()
  PaGlobal_TooltipSkill_All:learningControlInit()
  PaGlobal_TooltipSkill_All:blackSpiritControlInit()
  PaGlobal_TooltipSkill_All:linkControlInit()
  PaGlobal_TooltipSkill_All:registEventHandler()
  PaGlobal_TooltipSkill_All:validate()
  self._initialize = true
end
function PaGlobal_TooltipSkill_All:commonControlInit(tooltipInfo)
  UI.ASSERT(nil ~= tooltipInfo, "TooltipSkillGroup_commonContorlInit(tooltipInfo) , tooltipInfo nil")
  tooltipInfo.titleArea = UI.getChildControl(tooltipInfo.main, "Static_TitleArea")
  tooltipInfo.title = UI.getChildControl(tooltipInfo.titleArea, "StaticText_Title")
  tooltipInfo.iconArea = UI.getChildControl(tooltipInfo.main, "Static_IconArea")
  tooltipInfo.skillIconBg = UI.getChildControl(tooltipInfo.iconArea, "Static_IconBG")
  tooltipInfo.skillIcon = UI.getChildControl(tooltipInfo.skillIconBg, "Static_SkillIcon")
  tooltipInfo.skillName = UI.getChildControl(tooltipInfo.iconArea, "StaticText_SkillName")
  tooltipInfo.useCondition_category = UI.getChildControl(tooltipInfo.main, "Tooltip_Skill_UseCondition_category")
  tooltipInfo.useCondition_category_panel = UI.getChildControl(tooltipInfo.main, "Tooltip_Skill_UseCondition_panel")
  tooltipInfo.needHP = UI.getChildControl(tooltipInfo.main, "Tooltip_Skill_UseCondition_needHP")
  tooltipInfo.needHP_value = UI.getChildControl(tooltipInfo.main, "Tooltip_Skill_UseCondition_needHP_value")
  tooltipInfo.needMP = UI.getChildControl(tooltipInfo.main, "Tooltip_Skill_UseCondition_needMP")
  tooltipInfo.needMP_value = UI.getChildControl(tooltipInfo.main, "Tooltip_Skill_UseCondition_needMP_value")
  tooltipInfo.needSP = UI.getChildControl(tooltipInfo.main, "Tooltip_Skill_UseCondition_needSP")
  tooltipInfo.needSP_value = UI.getChildControl(tooltipInfo.main, "Tooltip_Skill_UseCondition_needSP_value")
  tooltipInfo.needItem = UI.getChildControl(tooltipInfo.main, "Tooltip_Skill_UseCondition_needItem")
  tooltipInfo.needItem_value = UI.getChildControl(tooltipInfo.main, "Tooltip_Skill_UseCondition_needItem_value")
  tooltipInfo.reuseCycle = UI.getChildControl(tooltipInfo.main, "Tooltip_Skill_UseCondition_reuseCycle")
  tooltipInfo.reuseCycle_value = UI.getChildControl(tooltipInfo.main, "Tooltip_Skill_UseCondition_reuseCycle_value")
  tooltipInfo.reusability = UI.getChildControl(tooltipInfo.main, "Tooltip_Skill_UseCondition_reusability")
  tooltipInfo.useMethod = UI.getChildControl(tooltipInfo.main, "Tooltip_Skill_UseMethod")
  tooltipInfo.skillEffect_category = UI.getChildControl(tooltipInfo.main, "Tooltip_Skill_SkillEffect_category")
  tooltipInfo.skillEffect_panel = UI.getChildControl(tooltipInfo.main, "Tooltip_Skill_SkillEffect_panel")
  tooltipInfo.skillEffect_value = UI.getChildControl(tooltipInfo.main, "Tooltip_Skill_SkillEffect_buff_value")
  tooltipInfo.awakeningEffect_category = UI.getChildControl(tooltipInfo.main, "Tooltip_Skill_AwakeningEffect_category")
  tooltipInfo.awakeningEffect_panel = UI.getChildControl(tooltipInfo.main, "Tooltip_Skill_AwakeningEffect_panel")
  tooltipInfo.awakeningeffect = UI.getChildControl(tooltipInfo.main, "Tooltip_Skill_AwakeningEffect_effect")
  tooltipInfo.skillDescription = UI.getChildControl(tooltipInfo.main, "Tooltip_Skill_Description")
  tooltipInfo.static_bg = UI.getChildControl(tooltipInfo.main, "Static_BG")
  tooltipInfo.horizonLine1 = UI.getChildControl(tooltipInfo.main, "Static_HorizonLine1")
  tooltipInfo.horizonLine2 = UI.getChildControl(tooltipInfo.main, "Static_HorizonLine2")
  tooltipInfo.static_bg:SetShow(false)
  tooltipInfo.horizonLine1:SetShow(true)
  tooltipInfo.horizonLine2:SetShow(true)
end
function PaGlobal_TooltipSkill_All:controlInit()
  PaGlobal_TooltipSkill_All:commonControlInit(self.TooltipSkillGroup)
  self.TooltipSkillGroup.learnRequirement_category = UI.getChildControl(self.TooltipSkillGroup.main, "Tooltip_Skill_LearnRequirement_category")
  self.TooltipSkillGroup.learnRequirement_panel = UI.getChildControl(self.TooltipSkillGroup.main, "Tooltip_Skill_LearnRequirement_panel")
  self.TooltipSkillGroup.requireLevel = UI.getChildControl(self.TooltipSkillGroup.main, "Tooltip_Skill_LearnRequirement_level")
  self.TooltipSkillGroup.requireLevel_value = UI.getChildControl(self.TooltipSkillGroup.main, "Tooltip_Skill_LearnRequirement_level_value")
  self.TooltipSkillGroup.requireSP = UI.getChildControl(self.TooltipSkillGroup.main, "Tooltip_Skill_LearnRequirement_skillPoint")
  self.TooltipSkillGroup.requireSP_value = UI.getChildControl(self.TooltipSkillGroup.main, "Tooltip_Skill_LearnRequirement_skillPoint_value")
  self.TooltipSkillGroup.requireItem = UI.getChildControl(self.TooltipSkillGroup.main, "Tooltip_Skill_LearnRequirement_item")
  self.TooltipSkillGroup.requireItem_value = UI.getChildControl(self.TooltipSkillGroup.main, "Tooltip_Skill_LearnRequirement_item_value")
  self.TooltipSkillGroup.titleArea:SetShow(false)
end
function PaGlobal_TooltipSkill_All:controlNextInit()
  PaGlobal_TooltipSkill_All:commonControlInit(self.TooltipSkillGroup_NextLevel)
  self.TooltipSkillGroup_NextLevel.learnRequirement_category = UI.getChildControl(self.TooltipSkillGroup_NextLevel.main, "Tooltip_Skill_LearnRequirement_category")
  self.TooltipSkillGroup_NextLevel.learnRequirement_panel = UI.getChildControl(self.TooltipSkillGroup_NextLevel.main, "Tooltip_Skill_LearnRequirement_panel")
  self.TooltipSkillGroup_NextLevel.requireLevel = UI.getChildControl(self.TooltipSkillGroup_NextLevel.main, "Tooltip_Skill_LearnRequirement_level")
  self.TooltipSkillGroup_NextLevel.requireLevel_value = UI.getChildControl(self.TooltipSkillGroup_NextLevel.main, "Tooltip_Skill_LearnRequirement_level_value")
  self.TooltipSkillGroup_NextLevel.requireSP = UI.getChildControl(self.TooltipSkillGroup_NextLevel.main, "Tooltip_Skill_LearnRequirement_skillPoint")
  self.TooltipSkillGroup_NextLevel.requireSP_value = UI.getChildControl(self.TooltipSkillGroup_NextLevel.main, "Tooltip_Skill_LearnRequirement_skillPoint_value")
  self.TooltipSkillGroup_NextLevel.requireItem = UI.getChildControl(self.TooltipSkillGroup_NextLevel.main, "Tooltip_Skill_LearnRequirement_item")
  self.TooltipSkillGroup_NextLevel.requireItem_value = UI.getChildControl(self.TooltipSkillGroup_NextLevel.main, "Tooltip_Skill_LearnRequirement_item_value")
  self.TooltipSkillGroup_NextLevel.titleArea:SetShow(true)
  self.TooltipSkillGroup_NextLevel.title:SetText(PAGetString(Defines.StringSheet_GAME, "PANEL_TOOLTIP_NEXTLEVELSKILL"))
end
function PaGlobal_TooltipSkill_All:learningControlInit()
  PaGlobal_TooltipSkill_All:commonControlInit(self.TooltipSkillGroup_Learning)
  self.TooltipSkillGroup_Learning.learnRequirement_category = UI.getChildControl(self.TooltipSkillGroup_Learning.main, "Tooltip_Skill_LearnRequirement_category")
  self.TooltipSkillGroup_Learning.learnRequirement_panel = UI.getChildControl(self.TooltipSkillGroup_Learning.main, "Tooltip_Skill_LearnRequirement_panel")
  self.TooltipSkillGroup_Learning.requireLevel = UI.getChildControl(self.TooltipSkillGroup_Learning.main, "Tooltip_Skill_LearnRequirement_level")
  self.TooltipSkillGroup_Learning.requireLevel_value = UI.getChildControl(self.TooltipSkillGroup_Learning.main, "Tooltip_Skill_LearnRequirement_level_value")
  self.TooltipSkillGroup_Learning.requireSP = UI.getChildControl(self.TooltipSkillGroup_Learning.main, "Tooltip_Skill_LearnRequirement_skillPoint")
  self.TooltipSkillGroup_Learning.requireSP_value = UI.getChildControl(self.TooltipSkillGroup_Learning.main, "Tooltip_Skill_LearnRequirement_skillPoint_value")
  self.TooltipSkillGroup_Learning.requireItem = UI.getChildControl(self.TooltipSkillGroup_Learning.main, "Tooltip_Skill_LearnRequirement_item")
  self.TooltipSkillGroup_Learning.requireItem_value = UI.getChildControl(self.TooltipSkillGroup_Learning.main, "Tooltip_Skill_LearnRequirement_item_value")
  self.TooltipSkillGroup_Learning.reservation_helpMsg = UI.getChildControl(self.TooltipSkillGroup_Learning.main, "StaticText_Reservation_Help")
  self.TooltipSkillGroup_Learning.reservation_helpMsg:SetShow(false)
  self.TooltipSkillGroup_Learning.titleArea:SetShow(false)
end
function PaGlobal_TooltipSkill_All:blackSpiritControlInit()
  PaGlobal_TooltipSkill_All:commonControlInit(self.TooltipSkillGroup_BlackSpirit)
  self.TooltipSkillGroup_BlackSpirit.titleArea:SetShow(true)
  self.TooltipSkillGroup_BlackSpirit.title:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_TOOLTIP_SKILLGROUP_BLACKSPIRIT_TITLE"))
end
function PaGlobal_TooltipSkill_All:linkControlInit()
  PaGlobal_TooltipSkill_All:commonControlInit(self.TooltipSkillGroup_LinkTooltip)
  self.TooltipSkillGroup_LinkTooltip.titleArea:SetShow(false)
end
function PaGlobal_TooltipSkill_All:registEventHandler()
  if nil == Panel_Tooltip_SkillGroup then
    return
  end
  registerEvent("EventSkillWindowClearSkill", "SkillEvent_SkillGroupWindow_ClearSkill")
  registerEvent("EventSkillWindowClearSkillAll", "SkillEvent_SkillGroupWindow_ClearSkillMessage")
  registerEvent("EventSkillWindowShowForLearn", "HandleMLUp_SkillWindow_OpenForLearn")
end
function PaGlobal_TooltipSkill_All:validate()
  if nil == Panel_Tooltip_SkillGroup then
    return
  end
end
function PaGlobal_TooltipSkill_All:resize()
  if nil == Panel_Tooltip_SkillGroup then
    return
  end
end
function PaGlobal_TooltipSkill_All:showTooltip(target, skillNo, skillTypeSS, isShowNextLevel, isReserveSkillOn, isResetable, isForceResetable)
  target.main:SetShow(false, false)
  local isNextLvWidget = target.main ~= Panel_Tooltip_SkillGroup and target.main ~= Panel_Tooltip_SkillGroup_forBlackSpirit and target.main ~= Panel_Tooltip_SkillGroup_forLinkTooltip and target.main ~= Panel_Tooltip_Skill_NextLevel_All
  local isLearnRequireInfo = target.main ~= Panel_Tooltip_SkillGroup_forBlackSpirit and target.main ~= Panel_Tooltip_SkillGroup_forLinkTooltip
  local level = getLearnedSkillLevel(skillTypeSS)
  local skillStatic, nextLevelStatic
  if isNextLvWidget then
    level = level + 1
    target.requireLevel:SetShow(false)
    target.requireLevel_value:SetShow(false)
  end
  if target.main == Panel_Tooltip_Skill_NextLevel_All then
    level = 1
  end
  local skillLevelInfo = getSkillLevelInfo(skillNo)
  if nil == skillLevelInfo then
    return
  end
  skillStatic = getSkillStaticStatus(skillNo, level)
  if nil == skillStatic then
    return
  end
  if true == skillLevelInfo._usable and not skillStatic:isAutoLearnSkillByLevel() and not skillStatic:isLearnSkillByItem() and skillStatic:isLastSkill() and (nil == isForceResetable or false == isForceResetable) then
    isResetable = true
  end
  local skillTypeSSW = skillStatic:getSkillTypeStaticStatusWrapper()
  if nil == skillTypeSSW then
    return
  end
  if Panel_Tooltip_SkillGroup == target.main then
    if true == isResetable then
      target.titleArea:SetShow(true)
      target.title:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SKILLTOOLTIP_RESETDESC"))
    else
      target.titleArea:SetShow(false)
    end
  end
  target.skillIcon:ChangeTextureInfoName("icon/" .. skillTypeSSW:getIconPath())
  local x1, y1, x2, y2 = setTextureUV_Func(target.skillIcon, 0, 0, 43, 43)
  target.skillIcon:getBaseTexture():setUV(x1, y1, x2, y2)
  target.skillIcon:setRenderTexture(target.skillIcon:getBaseTexture())
  target.skillName:SetTextMode(__eTextMode_AutoWrap)
  target.skillName:SetText(skillTypeSSW:getName())
  target.skillName:SetTextVerticalCenter()
  local needLvLearning = skillStatic:get()._needCharacterLevelForLearning
  local needSkillLearning = skillStatic:get()._needSkillPointForLearning
  local needItemLearning
  local isNeedLvLearning = false
  if isLearnRequireInfo then
    local needItemLearningItem = skillStatic:get():needItemForLearning()
    if nil ~= needItemLearningItem then
      local needItemLearningKey = needItemLearningItem._key
      needItemLearning = getItemEnchantStaticStatus(needItemLearningKey)
    end
    target.requireLevel_value:SetTextMode(__eTextMode_AutoWrap)
    local compareType
    if "GuildSkillBox" == self.TooltipSkillGroup._callTooltipType then
      local myGuildInfo = ToClient_GetMyGuildInfoWrapper()
      if nil == myGuildInfo then
        return
      end
      local myGuildRank = myGuildInfo:getMemberCountLevel()
      compareType = myGuildRank
    else
      compareType = getSelfPlayer():get():getLevel()
    end
    if 1 <= needLvLearning then
      if needLvLearning > compareType then
        isNeedLvLearning = true
        local requireLevel_valueText = PAGetStringParam1(Defines.StringSheet_GAME, "Lua_TooltipSkill_NeedLevel", "needLvLearning", needLvLearning)
        target.requireLevel_value:SetText(": " .. "<PAColor0xFFDB2B2B>" .. requireLevel_valueText .. "<PAOldColor>")
      else
        if "GuildSkillBox" ~= self.TooltipSkillGroup._callTooltipType then
          isNeedLvLearning = true
        else
          isNeedLvLearning = false
        end
        target.requireLevel_value:SetText(": " .. PAGetStringParam1(Defines.StringSheet_GAME, "Lua_TooltipSkill_NeedLevel", "needLvLearning", needLvLearning))
      end
    elseif 0 == needLvLearning then
      isNeedLvLearning = true
      target.requireLevel_value:SetText(": " .. PAGetString(Defines.StringSheet_GAME, "Lua_TooltipSkill_QuestGain"))
    end
    target.requireSP_value:SetTextMode(__eTextMode_AutoWrap)
    if needSkillLearning > getSelfPlayer():get():getRemainSkillPoint() then
      local requireSP_valueText = PAGetStringParam1(Defines.StringSheet_GAME, "Lua_TooltipSkill_NeedSP", "needSkillLearning", needSkillLearning)
      target.requireSP_value:SetText(": <PAColor0xFFDB2B2B>" .. requireSP_valueText .. "<PAOldColor>")
    else
      target.requireSP_value:SetText(": " .. PAGetStringParam1(Defines.StringSheet_GAME, "Lua_TooltipSkill_NeedSP", "needSkillLearning", needSkillLearning))
    end
    if nil ~= needItemLearning then
      target.requireItem_value:SetTextMode(__eTextMode_AutoWrap)
      target.requireItem_value:SetAutoResize(true)
      local needItemName = needItemLearning:getName()
      local needCount = tostring(skillStatic:get()._needItemCountForLearning_s64)
      target.requireItem_value:SetText(": " .. PAGetStringParam2(Defines.StringSheet_GAME, "Lua_TooltipSkill_NeedItem", "needItemName", needItemName, "needCount", needCount))
    end
  end
  target.needHP_value:SetTextMode(__eTextMode_AutoWrap)
  target.needHP_value:SetAutoResize(true)
  target.needHP_value:SetText(": " .. skillStatic:get()._requireHp)
  local isShowNeedHp = 0 ~= skillStatic:get()._requireHp
  local playerWrapper = getSelfPlayer()
  local player = playerWrapper:get()
  if __eClassType_ElfRanger == playerWrapper:getClassType() or __eClassType_RangerMan == playerWrapper:getClassType() then
    target.needMP:SetText(PAGetString(Defines.StringSheet_GAME, "Lua_TooltipSkill_NeedEP"))
  elseif __eClassType_Warrior == playerWrapper:getClassType() or __eClassType_Giant == playerWrapper:getClassType() or __eClassType_BladeMaster == playerWrapper:getClassType() or __eClassType_BladeMasterWoman == playerWrapper:getClassType() or __eClassType_Kunoichi == playerWrapper:getClassType() or __eClassType_NinjaMan == playerWrapper:getClassType() or __eClassType_Combattant == playerWrapper:getClassType() or __eClassType_Mystic == playerWrapper:getClassType() or __eClassType_Lhan == playerWrapper:getClassType() or __eClassType_Unknown1 == playerWrapper:getClassType() or __eClassType_Guardian == playerWrapper:getClassType() then
    target.needMP:SetText(PAGetString(Defines.StringSheet_GAME, "Lua_TooltipSkill_NeedFP"))
  elseif __eClassType_Valkyrie == playerWrapper:getClassType() then
    target.needMP:SetText(PAGetString(Defines.StringSheet_GAME, "Lua_TooltipSkill_NeedBP"))
  else
    target.needMP:SetText(PAGetString(Defines.StringSheet_GAME, "Lua_TooltipSkill_NeedMP"))
  end
  target.needMP_value:SetTextMode(__eTextMode_AutoWrap)
  target.needMP_value:SetAutoResize(true)
  target.needMP_value:SetText(": " .. skillStatic:get()._requireMp)
  local isShowNeedMp = 0 ~= skillStatic:get()._requireMp
  local isShowNeedSp = false
  target.needSP_value:SetTextMode(__eTextMode_AutoWrap)
  target.needSP_value:SetAutoResize(true)
  if 1 < skillStatic:get()._requireSp then
    target.needSP_value:SetText(": " .. skillStatic:get()._requireSp)
    isShowNeedSp = true
  else
    isShowNeedSp = false
  end
  local isShowNeedItem = nil ~= skillStatic:getItemInfo() and nil ~= skillStatic:getItemInfo():get()
  target.needItem_value:SetTextMode(__eTextMode_AutoWrap)
  target.needItem_value:SetTextVerticalTop()
  if not isShowNeedItem then
    target.needItem_value:SetText(PAGetString(Defines.StringSheet_GAME, "Lua_TooltipSkill_NoItemConsumed"))
  else
    local useNeedItemName = skillStatic:getItemInfo():getName()
    local s64_useNeedItemCount = skillStatic:get()._needItemCount_s64
    target.needItem_value:SetText(": " .. PAGetStringParam2(Defines.StringSheet_GAME, "Lua_TooltipSkill_UseNeedItem", "useNeedItemName", useNeedItemName, "useNeedItemCount", tostring(Int64toInt32(s64_useNeedItemCount))))
  end
  local _time = skillStatic:get()._reuseCycle / 1000
  target.reuseCycle_value:SetText(": " .. convertStringFromDatetimeForSkillTooltip(_time))
  local isShowReuseCycle = 0 ~= skillStatic:get()._reuseCycle
  local reusability = skillStatic:get():isUsableWhileInCoolTime()
  if reusability then
    target.reusability:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_TOOLTIPSKILL_REUSABILITY"))
  else
    target.reusability:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_TOOLTIPSKILL_NOREUSABILITY"))
  end
  local commandText = skillTypeSSW:getCommand()
  if "GuildSkillBox" == self.TooltipSkillGroup._callTooltipType then
    commandText = ""
  end
  local isShowCommand = "" ~= commandText
  target.useMethod:SetAutoResize(true)
  target.useMethod:SetTextMode(__eTextMode_AutoWrap)
  target.useMethod:SetText(commandText)
  target.skillEffect_value:SetTextMode(__eTextMode_AutoWrap)
  target.skillEffect_value:SetAutoResize(true)
  target.skillEffect_value:SetText(skillStatic:getDescription())
  local isAwakeningData = false
  local activeSkillSS
  if skillStatic:isActiveSkillHas() and false == skillStatic:isFusionSkill() then
    activeSkillSS = getActiveSkillStatus(skillStatic)
    if nil == activeSkillSS then
      target.awakeningeffect:SetText("")
    else
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
      target.awakeningeffect:SetText(awakeInfo)
      isAwakeningData = 0 < realCount
    end
  else
    target.awakeningeffect:SetText("")
  end
  target.skillDescription:SetTextMode(__eTextMode_AutoWrap)
  target.skillDescription:SetAutoResize(true)
  target.skillDescription:SetText(skillTypeSSW:getDescription())
  local elementBiggap = 10
  local elementgap = 0
  local TooltipYPos = 10
  TooltipYPos = SkillGroup_GetControlBottomPos(target.iconArea) + elementBiggap
  local isPetSkill = false
  if target.main == Panel_Tooltip_SkillGroup and (PaGlobal_TooltipSkill_All.TooltipSkillGroup._currentTooltip.slotType == "sealPetListSkill" or PaGlobal_TooltipSkill_All.TooltipSkillGroup._currentTooltip.slotType == "unSealPetListSkill" or PaGlobal_TooltipSkill_All.TooltipSkillGroup._currentTooltip.slotType == "PetSkill") then
    isPetSkill = true
  end
  if isLearnRequireInfo then
    if false == isPetSkill then
      target.learnRequirement_panel:SetPosY(TooltipYPos)
      TooltipYPos = TooltipYPos + elementBiggap
    end
    local isLevelShow = false == isPetSkill
    target.requireLevel:SetShow(isLevelShow)
    target.requireLevel_value:SetShow(isLevelShow)
    if isLevelShow then
      target.requireLevel:SetPosY(TooltipYPos)
      target.requireLevel_value:SetPosX(target.requireLevel:GetPosX() + target.requireLevel:GetTextSizeX() + 5)
      target.requireLevel_value:SetPosY(TooltipYPos)
      TooltipYPos = SkillGroup_GetControlBottomPos(target.requireLevel_value) + elementgap
    end
    local isSpShow = false == isPetSkill
    target.requireSP:SetShow(isSpShow)
    target.requireSP_value:SetShow(isSpShow)
    if isSpShow then
      target.requireSP:SetPosY(TooltipYPos)
      target.requireSP_value:SetPosX(target.requireSP:GetPosX() + target.requireSP:GetTextSizeX() + 5)
      target.requireSP_value:SetPosY(TooltipYPos)
      TooltipYPos = SkillGroup_GetControlBottomPos(target.requireSP_value) + elementgap
    end
    local isItemShow = nil ~= needItemLearning and false == isPetSkill
    target.requireItem:SetShow(isItemShow)
    target.requireItem_value:SetShow(isItemShow)
    if isItemShow then
      target.requireItem:SetPosY(TooltipYPos)
      target.requireItem_value:SetPosY(TooltipYPos)
      TooltipYPos = SkillGroup_GetControlBottomPos(target.requireItem_value) + elementgap
    end
    if isLevelShow or isSpShow or isItemShow then
      TooltipYPos = TooltipYPos + elementBiggap
      target.learnRequirement_panel:SetSize(target.learnRequirement_panel:GetSizeX(), TooltipYPos - target.learnRequirement_panel:GetPosY())
      TooltipYPos = SkillGroup_GetControlBottomPos(target.learnRequirement_panel) + 5
      target.learnRequirement_panel:SetShow(true)
    else
      target.learnRequirement_panel:SetShow(false)
    end
  end
  target.skillDescription:SetPosY(TooltipYPos)
  TooltipYPos = SkillGroup_GetControlBottomPos(target.skillDescription) + elementgap
  if isShowNeedHp or isShowNeedMp or isShowNeedSp or isShowNeedItem or isShowReuseCycle then
    target.useCondition_category:SetPosY(TooltipYPos - 5)
    TooltipYPos = SkillGroup_GetControlBottomPos(target.useCondition_category) + elementgap - elementBiggap
    target.useCondition_category_panel:SetPosY(TooltipYPos)
    TooltipYPos = TooltipYPos + elementBiggap / 2
    if isShowNeedHp then
      target.needHP:SetPosY(TooltipYPos)
      target.needHP_value:SetPosY(TooltipYPos)
      TooltipYPos = SkillGroup_GetControlBottomPos(target.needHP_value) + elementgap
    end
    target.needHP:SetShow(isShowNeedHp)
    target.needHP_value:SetShow(isShowNeedHp)
    if isShowNeedMp then
      target.needMP:SetPosY(TooltipYPos)
      target.needMP_value:SetPosY(TooltipYPos)
      TooltipYPos = SkillGroup_GetControlBottomPos(target.needMP_value) + elementgap
    end
    target.needMP:SetShow(isShowNeedMp)
    target.needMP_value:SetShow(isShowNeedMp)
    if isShowNeedSp then
      target.needSP:SetPosY(TooltipYPos)
      target.needSP_value:SetPosY(TooltipYPos)
      TooltipYPos = SkillGroup_GetControlBottomPos(target.needSP_value) + elementgap
    end
    target.needSP:SetShow(isShowNeedSp)
    target.needSP_value:SetShow(isShowNeedSp)
    if isShowNeedItem then
      target.needItem:SetPosY(TooltipYPos)
      target.needItem_value:SetPosY(TooltipYPos)
      target.needItem_value:SetSize(target.needItem_value:GetSizeX(), target.needItem_value:GetTextSizeY())
      TooltipYPos = SkillGroup_GetControlBottomPos(target.needItem_value) + elementgap
    end
    target.needItem:SetShow(isShowNeedItem)
    target.needItem_value:SetShow(isShowNeedItem)
    if isShowReuseCycle then
      target.reuseCycle:SetPosY(TooltipYPos)
      if target.reuseCycle_value:GetPosX() < target.reuseCycle:GetTextSizeX() + target.reuseCycle:GetPosX() then
        target.reuseCycle_value:SetPosX(target.reuseCycle:GetTextSizeX() + target.reuseCycle:GetPosX() + 20)
      end
      target.reuseCycle_value:SetPosY(TooltipYPos)
      TooltipYPos = SkillGroup_GetControlBottomPos(target.reuseCycle_value) + elementgap - 2
      target.reusability:SetPosY(TooltipYPos)
      TooltipYPos = SkillGroup_GetControlBottomPos(target.reusability) + elementgap + target.reusability:GetTextSizeY() - target.reusability:GetSizeY()
    end
    target.reusability:SetTextMode(__eTextMode_AutoWrap)
    target.reuseCycle:SetShow(isShowReuseCycle)
    target.reuseCycle_value:SetShow(isShowReuseCycle)
    target.reusability:SetShow(isShowReuseCycle)
    target.useCondition_category_panel:SetSize(target.useCondition_category_panel:GetSizeX(), TooltipYPos - target.useCondition_category_panel:GetPosY() + elementBiggap)
    TooltipYPos = SkillGroup_GetControlBottomPos(target.useCondition_category_panel) + elementgap
    target.useCondition_category:SetShow(true)
    target.useCondition_category_panel:SetShow(true)
  else
    target.needHP:SetShow(isShowNeedHp)
    target.needHP_value:SetShow(isShowNeedHp)
    target.needMP:SetShow(isShowNeedMp)
    target.needMP_value:SetShow(isShowNeedMp)
    target.needSP:SetShow(isShowNeedSp)
    target.needSP_value:SetShow(isShowNeedSp)
    target.needItem:SetShow(isShowNeedItem)
    target.needItem_value:SetShow(isShowNeedItem)
    target.reuseCycle:SetShow(isShowReuseCycle)
    target.reuseCycle_value:SetShow(isShowReuseCycle)
    target.reusability:SetShow(isShowReuseCycle)
    target.useCondition_category:SetShow(false)
    target.useCondition_category_panel:SetShow(false)
  end
  if isShowCommand then
    target.useMethod:SetPosY(TooltipYPos + elementBiggap)
    TooltipYPos = SkillGroup_GetControlBottomPos(target.useMethod) + elementgap
  end
  target.horizonLine1:SetPosY(TooltipYPos)
  target.skillEffect_category:SetPosY(TooltipYPos - 5)
  TooltipYPos = SkillGroup_GetControlBottomPos(target.skillEffect_category) + elementgap - elementBiggap
  target.skillEffect_panel:SetPosY(TooltipYPos)
  TooltipYPos = TooltipYPos + elementBiggap / 2
  target.skillEffect_value:SetPosY(TooltipYPos)
  TooltipYPos = SkillGroup_GetControlBottomPos(target.skillEffect_value) + elementgap
  target.skillEffect_panel:SetSize(target.skillEffect_panel:GetSizeX(), TooltipYPos - target.skillEffect_panel:GetPosY() + elementBiggap)
  TooltipYPos = SkillGroup_GetControlBottomPos(target.skillEffect_panel) + elementgap
  TooltipYPos = SkillGroup_GetControlBottomPos(target.skillEffect_panel)
  target.horizonLine2:SetPosY(TooltipYPos)
  target.horizonLine2:SetShow(isAwakeningData)
  target.awakeningEffect_category:SetShow(isAwakeningData)
  target.awakeningEffect_panel:SetShow(isAwakeningData)
  target.awakeningeffect:SetShow(isAwakeningData)
  if isAwakeningData then
    target.awakeningEffect_category:SetPosY(TooltipYPos + elementBiggap)
    TooltipYPos = SkillGroup_GetControlBottomPos(target.awakeningEffect_category) + elementgap
    target.awakeningEffect_panel:SetPosY(TooltipYPos)
    TooltipYPos = TooltipYPos + elementBiggap
    target.awakeningeffect:SetPosY(TooltipYPos)
    TooltipYPos = target.awakeningeffect:GetSizeY()
    target.awakeningEffect_panel:SetSize(target.awakeningEffect_panel:GetSizeX(), target.awakeningeffect:GetSizeY() + elementBiggap + 30)
    TooltipYPos = SkillGroup_GetControlBottomPos(target.awakeningEffect_panel) + elementgap
  end
  if true == isPetSkill then
    target.horizonLine1:SetShow(false)
    target.horizonLine2:SetShow(false)
    TooltipYPos = TooltipYPos - elementBiggap * 2
  end
  local panelSizeY = TooltipYPos + elementBiggap
  target.main:SetSize(target.main:GetSizeX(), panelSizeY)
  target.main:SetShow(true, false)
  if panelSizeY > self.TooltipSkillGroup._maxHeight then
    self.TooltipSkillGroup._maxHeight = panelSizeY
  end
end
