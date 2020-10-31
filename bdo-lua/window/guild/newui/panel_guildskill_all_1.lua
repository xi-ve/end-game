function PaGlobal_GuildSkill_All:initialize()
  if true == PaGlobal_GuildSkill_All._initialize or nil == Panel_GuildSkill_All then
    return
  end
  self._ui.frame_GuildSkill = UI.getChildControl(Panel_GuildSkill_All, "Frame_GuildSkill")
  self._ui.stc_LeftBG = UI.getChildControl(Panel_GuildSkill_All, "Static_LeftArea")
  self._ui.stc_CircleArea = UI.getChildControl(self._ui.stc_LeftBG, "Static_CircleHere")
  self._ui.circle_GuildPoint = UI.getChildControl(self._ui.stc_CircleArea, "CircularProgress_GuildPoint")
  self._ui.txt_GuildPoint = UI.getChildControl(self._ui.stc_CircleArea, "StaticText_GuildPoint")
  self._ui.txt_GuildPointPercent = UI.getChildControl(self._ui.stc_CircleArea, "StaticText_GuildPointExp")
  self._ui.frame_Tooltip = UI.getChildControl(self._ui.stc_LeftBG, "Frame_Tooltip")
  self._ui.contents_Tooltip = self._ui.frame_Tooltip:GetFrameContent()
  self._ui.stc_TooltipBG = UI.getChildControl(self._ui.contents_Tooltip, "Static_TooltipBG")
  self._ui.stc_SkillBG = UI.getChildControl(self._ui.stc_TooltipBG, "Static_SkillBG")
  self._ui.stc_SkillIcon = UI.getChildControl(self._ui.stc_SkillBG, "Static_SkillIcon")
  self._ui.txt_LevelName = UI.getChildControl(self._ui.stc_TooltipBG, "StaticText_SkillLevelnName")
  self._ui.txt_NeedItem = UI.getChildControl(self._ui.stc_TooltipBG, "StaticText_Skill_NeedItem")
  self._ui.txt_RequirePoint = UI.getChildControl(self._ui.stc_TooltipBG, "StaticText_Skill_RequirePoint")
  self._ui.txt_CoolTime = UI.getChildControl(self._ui.stc_TooltipBG, "StaticText_Skill_Cooltime")
  self._ui.txt_CoolTimeDesc = UI.getChildControl(self._ui.stc_TooltipBG, "StaticText_Skill_CooltimeDesc")
  self._ui.txt_Desc = UI.getChildControl(self._ui.stc_TooltipBG, "StaticText_Skill_Desc")
  self._ui.txt_FrameDesc = UI.getChildControl(self._ui.contents_Tooltip, "StaticText_Skill_FrameDesc")
  self._ui.txt_NeedItem:SetTextMode(__eTextMode_AutoWrap)
  self._ui.txt_Desc:SetTextMode(__eTextMode_AutoWrap)
  self._ui.txt_CoolTimeDesc:SetTextMode(__eTextMode_AutoWrap)
  self._ui.txt_Desc:SetAutoResize(true)
  self._ui.txt_FrameDesc:SetTextMode(__eTextMode_AutoWrap)
  self.slotConfig.template.effect = UI.getChildControl(Panel_GuildSkill_All, "Static_Icon_Skill_Effect")
  self.slotConfig.template.iconFG = UI.getChildControl(Panel_GuildSkill_All, "Static_Icon_FG")
  self.slotConfig.template.iconFGDisabled = UI.getChildControl(Panel_GuildSkill_All, "Static_Icon_FG_DISABLE")
  self.slotConfig.template.iconFG_Passive = UI.getChildControl(Panel_GuildSkill_All, "Static_Icon_BG")
  self.slotConfig.template.learnButton = UI.getChildControl(Panel_GuildSkill_All, "Button_Skill_Point")
  self.template_guideLine = {
    h = {
      [3] = UI.getChildControl(Panel_GuildSkill_All, "Static_TypeH_LT"),
      [4] = UI.getChildControl(Panel_GuildSkill_All, "Static_TypeH_CT"),
      [5] = UI.getChildControl(Panel_GuildSkill_All, "Static_TypeH_RT"),
      [6] = UI.getChildControl(Panel_GuildSkill_All, "Static_TypeH_LM"),
      [7] = UI.getChildControl(Panel_GuildSkill_All, "Static_TypeH_CM"),
      [8] = UI.getChildControl(Panel_GuildSkill_All, "Static_TypeH_RM"),
      [9] = UI.getChildControl(Panel_GuildSkill_All, "Static_TypeH_LB"),
      [10] = UI.getChildControl(Panel_GuildSkill_All, "Static_TypeH_CB"),
      [11] = UI.getChildControl(Panel_GuildSkill_All, "Static_TypeH_RB"),
      [12] = UI.getChildControl(Panel_GuildSkill_All, "Static_TypeH_HORI"),
      [13] = UI.getChildControl(Panel_GuildSkill_All, "Static_TypeH_VERTI")
    },
    v = {
      [3] = UI.getChildControl(Panel_GuildSkill_All, "Static_TypeV_LT"),
      [4] = UI.getChildControl(Panel_GuildSkill_All, "Static_TypeV_CT"),
      [5] = UI.getChildControl(Panel_GuildSkill_All, "Static_TypeV_RT"),
      [6] = UI.getChildControl(Panel_GuildSkill_All, "Static_TypeV_LM"),
      [7] = UI.getChildControl(Panel_GuildSkill_All, "Static_TypeV_CM"),
      [8] = UI.getChildControl(Panel_GuildSkill_All, "Static_TypeV_RM"),
      [9] = UI.getChildControl(Panel_GuildSkill_All, "Static_TypeV_LB"),
      [10] = UI.getChildControl(Panel_GuildSkill_All, "Static_TypeV_CB"),
      [11] = UI.getChildControl(Panel_GuildSkill_All, "Static_TypeV_RB"),
      [12] = UI.getChildControl(Panel_GuildSkill_All, "Static_TypeV_HORI"),
      [13] = UI.getChildControl(Panel_GuildSkill_All, "Static_TypeV_VERTI")
    },
    l = {
      [3] = UI.getChildControl(Panel_GuildSkill_All, "Static_TypeL_LT"),
      [4] = UI.getChildControl(Panel_GuildSkill_All, "Static_TypeL_CT"),
      [5] = UI.getChildControl(Panel_GuildSkill_All, "Static_TypeL_RT"),
      [6] = UI.getChildControl(Panel_GuildSkill_All, "Static_TypeL_LM"),
      [7] = UI.getChildControl(Panel_GuildSkill_All, "Static_TypeL_CM"),
      [8] = UI.getChildControl(Panel_GuildSkill_All, "Static_TypeL_RM"),
      [9] = UI.getChildControl(Panel_GuildSkill_All, "Static_TypeL_LB"),
      [10] = UI.getChildControl(Panel_GuildSkill_All, "Static_TypeL_CB"),
      [11] = UI.getChildControl(Panel_GuildSkill_All, "Static_TypeL_RB"),
      [12] = UI.getChildControl(Panel_GuildSkill_All, "Static_TypeL_HORI"),
      [13] = UI.getChildControl(Panel_GuildSkill_All, "Static_TypeL_VERTI")
    },
    s = {
      [3] = UI.getChildControl(Panel_GuildSkill_All, "Static_TypeS_LT"),
      [4] = UI.getChildControl(Panel_GuildSkill_All, "Static_TypeS_CT"),
      [5] = UI.getChildControl(Panel_GuildSkill_All, "Static_TypeS_RT"),
      [6] = UI.getChildControl(Panel_GuildSkill_All, "Static_TypeS_LM"),
      [7] = UI.getChildControl(Panel_GuildSkill_All, "Static_TypeS_CM"),
      [8] = UI.getChildControl(Panel_GuildSkill_All, "Static_TypeS_RM"),
      [9] = UI.getChildControl(Panel_GuildSkill_All, "Static_TypeS_LB"),
      [10] = UI.getChildControl(Panel_GuildSkill_All, "Static_TypeS_CB"),
      [11] = UI.getChildControl(Panel_GuildSkill_All, "Static_TypeS_RB"),
      [12] = UI.getChildControl(Panel_GuildSkill_All, "Static_TypeS_HORI"),
      [13] = UI.getChildControl(Panel_GuildSkill_All, "Static_TypeS_VERTI")
    }
  }
  self._parentBG = PaGlobal_GuildMain_All._ui.stc_Skill_Bg
  self.slots = {}
  self._isConsole = _ContentsGroup_UsePadSnapping
  local cellTable = getGuildSkillTree()
  local content = self._ui.frame_GuildSkill:GetFrameContent()
  self:initSkillTreeControl(cellTable, content, self.slots)
  self._ui.frame_GuildSkill:UpdateContentScroll()
  content:SetSize(content:GetSizeX(), content:GetSizeY() + 20)
  PaGlobal_GuildSkill_All:validate()
end
function PaGlobal_GuildSkill_All:validate()
  self._ui.frame_GuildSkill:isValidate()
  self._ui.stc_CircleArea:isValidate()
  self._ui.circle_GuildPoint:isValidate()
  self._ui.txt_GuildPoint:isValidate()
  self._ui.txt_GuildPointPercent:isValidate()
  self._ui.frame_Tooltip:isValidate()
  self._ui.contents_Tooltip:isValidate()
  self._ui.stc_SkillBG:isValidate()
  self._ui.stc_SkillIcon:isValidate()
  self._ui.txt_LevelName:isValidate()
  self._ui.txt_NeedItem:isValidate()
  self._ui.txt_RequirePoint:isValidate()
  self._ui.txt_CoolTime:isValidate()
  self._ui.txt_CoolTimeDesc:isValidate()
  self._ui.txt_Desc:isValidate()
  self.slotConfig.template.effect:isValidate()
  self.slotConfig.template.iconFG:isValidate()
  self.slotConfig.template.iconFGDisabled:isValidate()
  self.slotConfig.template.iconFG_Passive:isValidate()
  self.slotConfig.template.learnButton:isValidate()
  self.template_guideLine.h[3]:isValidate()
  self.template_guideLine.h[4]:isValidate()
  self.template_guideLine.h[5]:isValidate()
  self.template_guideLine.h[6]:isValidate()
  self.template_guideLine.h[7]:isValidate()
  self.template_guideLine.h[8]:isValidate()
  self.template_guideLine.h[9]:isValidate()
  self.template_guideLine.h[10]:isValidate()
  self.template_guideLine.h[11]:isValidate()
  self.template_guideLine.h[12]:isValidate()
  self.template_guideLine.h[13]:isValidate()
  self.template_guideLine.v[3]:isValidate()
  self.template_guideLine.v[4]:isValidate()
  self.template_guideLine.v[5]:isValidate()
  self.template_guideLine.v[6]:isValidate()
  self.template_guideLine.v[7]:isValidate()
  self.template_guideLine.v[8]:isValidate()
  self.template_guideLine.v[9]:isValidate()
  self.template_guideLine.v[10]:isValidate()
  self.template_guideLine.v[11]:isValidate()
  self.template_guideLine.v[12]:isValidate()
  self.template_guideLine.v[13]:isValidate()
  self.template_guideLine.l[3]:isValidate()
  self.template_guideLine.l[4]:isValidate()
  self.template_guideLine.l[5]:isValidate()
  self.template_guideLine.l[6]:isValidate()
  self.template_guideLine.l[7]:isValidate()
  self.template_guideLine.l[8]:isValidate()
  self.template_guideLine.l[9]:isValidate()
  self.template_guideLine.l[10]:isValidate()
  self.template_guideLine.l[11]:isValidate()
  self.template_guideLine.l[12]:isValidate()
  self.template_guideLine.l[13]:isValidate()
  self.template_guideLine.s[3]:isValidate()
  self.template_guideLine.s[4]:isValidate()
  self.template_guideLine.s[5]:isValidate()
  self.template_guideLine.s[6]:isValidate()
  self.template_guideLine.s[7]:isValidate()
  self.template_guideLine.s[8]:isValidate()
  self.template_guideLine.s[9]:isValidate()
  self.template_guideLine.s[10]:isValidate()
  self.template_guideLine.s[11]:isValidate()
  self.template_guideLine.s[12]:isValidate()
  self.template_guideLine.s[13]:isValidate()
end
function PaGlobal_GuildSkill_All:openTab()
  if nil == self._parentBG or false == self._parentBG:GetShow() then
    return
  end
  local vScroll = self._ui.frame_GuildSkill:GetVScroll()
  vScroll:SetControlPos(0)
  self._ui.frame_GuildSkill:UpdateContentPos()
  PaGlobal_GuildSkill_All:update()
  self:initControl()
end
function PaGlobal_GuildSkill_All:update()
  if nil == self._parentBG or false == self._parentBG:GetShow() then
    return
  end
  self:updatePoint()
  self:updateFrame()
end
function PaGlobal_GuildSkill_All:updatePoint()
  local skillPointInfo = ToClient_getSkillPointInfo(3)
  local skillPointPercent = string.format("%.0f", skillPointInfo._currentExp / skillPointInfo._nextLevelExp * 100)
  self._ui.txt_GuildPoint:SetText(tostring(skillPointInfo._remainPoint))
  if 100 < tonumber(skillPointPercent) then
    skillPointPercent = 100
  end
  self._ui.txt_GuildPointPercent:SetText("( " .. skillPointPercent .. "% )")
  self._ui.circle_GuildPoint:SetProgressRate(skillPointInfo._currentExp / skillPointInfo._nextLevelExp * 100)
end
function PaGlobal_GuildSkill_All:updateFrame()
  local slots = self.slots
  for skillNo, slot in pairs(slots) do
    local skillLevelInfo = getSkillLevelInfo(skillNo)
    if nil ~= skillLevelInfo then
      local resultAble = slot:setSkill(skillLevelInfo, skillLevelInfo._learnable)
      local skillTypeStaticWrapper = getSkillTypeStaticStatus(skillNo)
      if not skillLevelInfo._learnable and skillLevelInfo._usable and skillTypeStaticWrapper:get():isActiveSkill() then
        if self._isConsole then
          slot.icon:registerPadEvent(__eConsoleUIPadEvent_A, "InputEventLUp_GuildSkill_All_UseSkill(" .. skillNo .. ")")
        else
          slot.icon:addInputEvent("Mouse_RUp", "InputEventLUp_GuildSkill_All_UseSkill(" .. skillNo .. ")")
        end
      else
        slot.icon:addInputEvent("Mouse_RUp", "")
        slot.icon:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "")
      end
      if skillTypeStaticWrapper:isValidLocalizing() then
        slot.icon:SetShow(true)
        slot.icon:SetIgnore(false)
        slot.icon:SetMonoTone(false)
      else
        slot.icon:SetShow(false)
        slot.icon:SetIgnore(true)
        slot.icon:SetMonoTone(true)
      end
    end
    self.skillNoSlot[skillNo] = slot
  end
end
function PaGlobal_GuildSkill_All:getLineTemplate(isSlotColumn, isSlotRow, lineType)
  local lineDef
  if isSlotColumn and isSlotRow then
    lineDef = self.template_guideLine.l
  elseif not isSlotColumn and isSlotRow then
    lineDef = self.template_guideLine.v
  elseif isSlotColumn and not isSlotRow then
    lineDef = self.template_guideLine.h
  else
    lineDef = self.template_guideLine.s
  end
  return lineDef[lineType]
end
function PaGlobal_GuildSkill_All:initControl()
  self._ui.txt_FrameDesc:SetShow(true)
  self._ui.txt_FrameDesc:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_GUILDSKILL_LEFTDESC"))
  self._ui.stc_TooltipBG:SetShow(false)
  self._ui.frame_Tooltip:UpdateContentScroll()
end
function PaGlobal_GuildSkill_All:initSkillTreeControl(cellTable, parent, container)
  local cols = cellTable:capacityX()
  local rows = cellTable:capacityY()
  self._cellTableCols = cols
  self._cellTableRows = rows
  local startY = self.config.slotStartY
  local inValidateCount = 0
  self._firstSkillNo = nil
  for row = 0, rows - 1 do
    local startX = self.config.slotStartX
    local isSlotRow = 0 == row % 2
    if isSlotRow then
      startY = startY + self.config.emptyGapY
    else
      startY = startY + self.config.slotGapY
    end
    for col = 0, cols - 1 do
      local cell = cellTable:atPointer(col, row)
      local skillNo = cell._skillNo
      local isSlotColumn = 0 == col % 2
      if isSlotColumn then
        startX = startX + self.config.emptyGapX
      else
        startX = startX + self.config.slotGapX
      end
      if cell:isSkillType() then
        local skillTypeStaticWrapper = getSkillTypeStaticStatus(skillNo)
        if skillTypeStaticWrapper:isValidLocalizing() then
          if nil == self._firstSkillNo then
            self._firstSkillNo = skillNo
          end
          local skillTypeStatic = skillTypeStaticWrapper:get()
          self.slotConfig.createFG = skillTypeStatic:isActiveSkill() and skillTypeStatic._isSettableQuickSlot
          self.slotConfig.createFGDisabled = self.slotConfig.createFG
          self.slotConfig.createFG_Passive = not self.slotConfig.createFG
          local slot = {}
          if self._isConsole then
            slot.icon = UI.createAndCopyBasePropertyControl(Panel_GuildSkill_All, "Static_Icon_Skill", parent, "StaticSkill_" .. col .. "_" .. row)
            ToClient_padSnapRefreshTarget(slot.icon)
          end
          SlotSkill.new(slot, skillNo, parent, self.slotConfig)
          slot:setPos(startX, startY)
          if nil ~= slot.learnButton then
            slot.learnButton:SetIgnore(true)
          end
          if nil ~= slot.icon then
            if self._isConsole then
              slot.icon:addInputEvent("Mouse_On", "InputEventMOn_GuildSkill_All_SetKeyGuideA(" .. skillNo .. ")")
              if true == _ContentsGroup_RenewUI_Tooltip then
                slot.icon:registerPadEvent(__eConsoleUIPadEvent_Up_X, "InputEventMLUp_GuildSkill_All_SkillTooltip(" .. skillNo .. ")")
              else
                slot.icon:registerPadEvent(__eConsoleUIPadEvent_Up_X, "InputEventMOn_GuildSkill_All_ShowSkillTooltip(" .. skillNo .. ", \"GuildSkillBox\", true)")
                slot.icon:addInputEvent("Mouse_Out", "InputEventMOn_GuildSkill_All_ShowSkillTooltip(" .. skillNo .. ",\"GuildSkillBox\", false)")
              end
              slot.icon:registerPadEvent(__eConsoleUIPadEvent_Up_A, "InputEventLUp_GuildSkill_All_LearnSkill(" .. skillNo .. ")")
            else
              slot.learnButton:SetIgnore(false)
              slot.learnButton:addInputEvent("Mouse_LUp", "InputEventLUp_GuildSkill_All_LearnSkill(" .. skillNo .. ")")
              slot.icon:addInputEvent("Mouse_On", "InputEventMOn_GuildSkill_All_ShowSkillTooltip(" .. skillNo .. ", \"GuildSkillBox\", true)")
              slot.icon:addInputEvent("Mouse_Out", "InputEventMOn_GuildSkill_All_ShowSkillTooltip(" .. skillNo .. ",\"GuildSkillBox\", false)")
            end
            Panel_SkillTooltip_SetPosition(skillNo, slot.icon, "GuildSkillBox")
          end
          slot:setSkillTypeStatic(skillTypeStaticWrapper)
          container[skillNo] = slot
        else
          inValidateCount = inValidateCount + 1
          local point = {_col = col, _row = row}
          self._inValidateSlots[inValidateCount] = point
        end
      elseif cell:isLineType() then
        local template = self:getLineTemplate(isSlotColumn, isSlotRow, cell._cellType)
        if nil ~= template then
          local line = UI.createControl(__ePAUIControl_Static, parent, "Static_Line_" .. col .. "_" .. row)
          CopyBaseProperty(template, line)
          line:SetPosX(startX)
          line:SetPosY(startY)
          line:SetIgnore(true)
          line:SetShow(true)
        end
      end
    end
  end
  if 0 < inValidateCount then
    for slotIdx = 1, inValidateCount do
      for dIdx = 0, #self._direction do
        self:hideInvalidateLine(cellTable, parent, self._inValidateSlots[slotIdx], self._direction[dIdx])
      end
    end
  end
end
function PaGlobal_GuildSkill_All:hideInvalidateLine(cellTable, parent, point, direction)
  local col = point._col + direction._col
  if col < 0 or col > self._cellTableCols then
    return
  end
  local row = point._row + direction._row
  if row < 0 or row > self._cellTableRows then
    return
  end
  local cell = cellTable:atPointer(col, row)
  if cell:isSkillType() then
    return
  elseif cell:isLineType() then
    local line = UI.getChildControl(parent, "Static_Line_" .. col .. "_" .. row)
    if nil ~= line then
      if line:GetShow() then
        line:SetShow(false)
      else
        return
      end
    end
    if 12 == cell._cellType or 13 == cell._cellType then
      local point = {_col = col, _row = row}
      self:hideInvalidateLine(cellTable, parent, point, direction)
    else
      local point = {_col = col, _row = row}
      self:hideInvalidateLine(cellTable, parent, point, self._direction[2])
    end
    return
  end
end
function PaGlobal_GuildSkill_All:updateToolTip(skillNo)
  local skillTypeSS = getSkillTypeStaticStatus(skillNo)
  local skillStatic = getSkillStaticStatus(skillNo, 1)
  if nil == skillStatic then
    return
  end
  local skillTypeSSW = skillStatic:getSkillTypeStaticStatusWrapper()
  if nil == skillTypeSSW then
    return
  end
  self._ui.txt_FrameDesc:SetShow(false)
  self._ui.stc_TooltipBG:SetShow(true)
  self._ui.txt_LevelName:SetText(skillTypeSS:getName())
  self._ui.stc_SkillIcon:ChangeTextureInfoNameAsync("icon/" .. skillTypeSS:getIconPath())
  local isShowNeedItem = nil ~= skillStatic:getItemInfo() and nil ~= skillStatic:getItemInfo():get()
  local needText = PAGetString(Defines.StringSheet_RESOURCE, "TOOLTIP_SKILLLEARN_TXT_NEEDITEM")
  if false == isShowNeedItem then
    self._ui.txt_NeedItem:SetText(needText .. " : " .. PAGetString(Defines.StringSheet_GAME, "Lua_TooltipSkill_NoItemConsumed"))
  else
    local useNeedItemName = skillStatic:getItemInfo():getName()
    local s64_useNeedItemCount = skillStatic:get()._needItemCount_s64
    self._ui.txt_NeedItem:SetText(needText .. " : " .. PAGetStringParam2(Defines.StringSheet_GAME, "Lua_TooltipSkill_UseNeedItem", "useNeedItemName", useNeedItemName, "useNeedItemCount", tostring(Int64toInt32(s64_useNeedItemCount))))
  end
  local _skillcondition = skillTypeSSW:getDescription()
  if "" ~= tostring(_skillcondition) then
    self._ui.txt_NeedItem:SetText(_skillcondition .. [[


]] .. self._ui.txt_NeedItem:GetText())
  end
  local posY = self._ui.txt_NeedItem:GetPosY() + self._ui.txt_NeedItem:GetTextSizeY()
  local pointStr = PAGetString(Defines.StringSheet_RESOURCE, "TOOLTIP_SKILLLEARN_TXT_NEEDSP")
  self._ui.txt_RequirePoint:SetText(pointStr .. " : " .. tostring(skillStatic:get()._needSkillPointForLearning))
  self._ui.txt_RequirePoint:SetPosY(posY)
  posY = self._ui.txt_RequirePoint:GetPosY() + self._ui.txt_RequirePoint:GetTextSizeY()
  local coolTime = skillStatic:get()._reuseCycle / 1000
  local isShowCoolTime = 0 ~= coolTime
  local reusability = skillStatic:get():isUsableWhileInCoolTime()
  self._ui.txt_CoolTime:SetShow(isShowCoolTime)
  self._ui.txt_CoolTimeDesc:SetShow(isShowCoolTime)
  if isShowCoolTime then
    local coolTimeStr = PAGetString(Defines.StringSheet_RESOURCE, "TOOLTIP_SKILL_TXT_REUSECYCLE") .. " : " .. convertStringFromDatetimeForSkillTooltip(coolTime)
    self._ui.txt_CoolTime:SetText(coolTimeStr)
    self._ui.txt_CoolTime:SetPosY(posY)
    posY = self._ui.txt_CoolTime:GetPosY() + self._ui.txt_CoolTime:GetTextSizeY()
    self._ui.txt_CoolTimeDesc:SetPosY(posY)
    if reusability then
      self._ui.txt_CoolTimeDesc:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_TOOLTIPSKILL_REUSABILITY"))
    else
      self._ui.txt_CoolTimeDesc:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_TOOLTIPSKILL_NOREUSABILITY"))
    end
    posY = self._ui.txt_CoolTimeDesc:GetPosY() + self._ui.txt_CoolTimeDesc:GetTextSizeY()
  end
  self._ui.txt_Desc:SetText(skillStatic:getDescription())
  self._ui.txt_Desc:SetPosY(posY + 20)
  local scroll = self._ui.frame_Tooltip:GetVScroll()
  self._ui.contents_Tooltip:SetSize(self._ui.contents_Tooltip:GetSizeX(), self._ui.txt_Desc:GetPosY() + self._ui.txt_Desc:GetSizeY() + 10)
  scroll:SetControlTop()
  self._ui.frame_Tooltip:UpdateContentScroll()
  self._ui.frame_Tooltip:UpdateContentPos()
  if self._isConsole then
    PaGlobal_GuildMain_All:setKeyguideTextWithShow(scroll:GetShow(), __eConsoleUIPadEvent_RStickUp)
  end
end
