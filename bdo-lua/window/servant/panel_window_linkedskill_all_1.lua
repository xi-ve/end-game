function PaGlobal_LinkedSkill_All:initialize()
  if true == PaGlobal_LinkedSkill_All._initialize then
    return
  end
  Panel_Window_LinkedSkill_All:SetShow(false)
  Panel_Window_LinkedSkill_All:SetDragEnable(true)
  Panel_Window_LinkedSkill_All:setGlassBackground(true)
  self._ui._txt_title = UI.getChildControl(Panel_Window_LinkedSkill_All, "StaticText_Title")
  self._ui._pc._btn_close = UI.getChildControl(self._ui._txt_title, "Button_Close")
  self._ui._console._stc_keyGuideBG = UI.getChildControl(Panel_Window_LinkedSkill_All, "Static_ConsoleKeyGuide")
  self._ui._stc_skillBg = UI.getChildControl(Panel_Window_LinkedSkill_All, "Static_SkillBg")
  self._ui._stc_skillIcon = UI.getChildControl(Panel_Window_LinkedSkill_All, "Static_SkillIcon")
  self._ui._txt_skillCondition = UI.getChildControl(Panel_Window_LinkedSkill_All, "StaticText_SkillCondition")
  self._ui._txt_skillName = UI.getChildControl(Panel_Window_LinkedSkill_All, "StaticText_SkillName")
  self._ui._txt_skillPercent = UI.getChildControl(Panel_Window_LinkedSkill_All, "StaticText_LearningPercent")
  self._ui._stc_learnBackground = UI.getChildControl(Panel_Window_LinkedSkill_All, "Static_CircleBG")
  self._ui._progress_skillLearnGauge = UI.getChildControl(Panel_Window_LinkedSkill_All, "CircularProgress_SkillExp")
  self._ui._scroll_skillScroll = UI.getChildControl(Panel_Window_LinkedSkill_All, "Scroll_Skill")
  self._ui._stc_skillInfoBg = UI.getChildControl(Panel_Window_LinkedSkill_All, "Static_skillInfoBg")
  self:init_skill()
  self:init_equipSlot()
  self:setShowControl()
  PaGlobal_LinkedSkill_All:registEventHandler()
  PaGlobal_LinkedSkill_All:validate()
  PaGlobal_LinkedSkill_All._initialize = true
end
function PaGlobal_LinkedSkill_All:registEventHandler()
  if nil == Panel_Window_LinkedSkill_All then
    return
  end
  self._ui._pc._btn_close:addInputEvent("Mouse_LUp", "PaGlobal_LinkedSkill_All_Close()")
  self._ui._stc_skillInfoBg:addInputEvent("Mouse_UpScroll", "EventHandler_LinkedSkill_SkillScroll(true)")
  self._ui._stc_skillInfoBg:addInputEvent("Mouse_DownScroll", "EventHandler_LinkedSkill_SkillScroll(false)")
  Panel_Window_LinkedSkill_All:registerPadEvent(__eConsoleUIPadEvent_RStickUp, "EventHandler_LinkedSkill_SkillScroll(true)")
  Panel_Window_LinkedSkill_All:registerPadEvent(__eConsoleUIPadEvent_RStickDown, "EventHandler_LinkedSkill_SkillScroll(false)")
  UIScroll.InputEvent(self._ui._scroll_skillScroll, "EventHandler_LinkedSkill_SkillScroll")
end
function PaGlobal_LinkedSkill_All:prepareOpen(actorKeyRaw, index)
  if nil == Panel_Window_LinkedSkill_All then
    return
  end
  if index == self._currentIndex then
    self:prepareClose()
    return
  end
  self._currentIndex = index
  self._skillStartIndex = 0
  self._actorKeyRaw = actorKeyRaw
  self:updateSkill()
  self:updateEquip()
  self:repostion()
  self:setAlignKeyGuide()
  ToClient_padSnapSetTargetPanel(Panel_Window_LinkedSkill_All)
  Panel_Window_LinkedSkill_All:ignorePadSnapMoveToOtherPanel()
  PaGlobal_LinkedSkill_All:open()
end
function PaGlobal_LinkedSkill_All:open()
  if nil == Panel_Window_LinkedSkill_All then
    return
  end
  Panel_Window_LinkedSkill_All:SetShow(true)
end
function PaGlobal_LinkedSkill_All:prepareClose()
  if nil == Panel_Window_LinkedSkill_All then
    return
  end
  self._currentIndex = -1
  ToClient_padSnapSetTargetPanel(Panel_Window_VehicleInfo_All)
  if true == _ContentsGroup_NewUI_Tooltip_All then
    PaGlobal_Tooltip_Skill_Servant_All_Close()
  else
    PaGlobal_Tooltip_Servant_Close()
  end
  PaGlobal_LinkedSkill_All:close()
end
function PaGlobal_LinkedSkill_All:close()
  if nil == Panel_Window_LinkedSkill_All then
    return
  end
  Panel_Window_LinkedSkill_All:SetShow(false)
end
function PaGlobal_LinkedSkill_All:update()
  if nil == Panel_Window_LinkedSkill_All then
    return
  end
end
function PaGlobal_LinkedSkill_All:validate()
  if nil == Panel_Window_LinkedSkill_All then
    return
  end
end
function PaGlobal_LinkedSkill_All:init_skill()
  local progressPosX = self._skillConfig.startIconX - (self._ui._stc_learnBackground:GetSizeX() - self._ui._stc_skillIcon:GetSizeX()) * 0.5
  local progressPosY = self._skillConfig.startIconY - (self._ui._stc_learnBackground:GetSizeY() - self._ui._stc_skillIcon:GetSizeY()) * 0.5
  for idx = 0, self._loopCount do
    local tempSkill = {}
    tempSkill._stc_skillBg = UI.createControl(__ePAUIControl_Static, self._ui._stc_skillInfoBg, "Static_SkillBg_" .. idx)
    CopyBaseProperty(self._ui._stc_skillBg, tempSkill._stc_skillBg)
    tempSkill._stc_skillBg:SetPosY(self._ui._stc_skillBg:GetSizeY() * idx)
    tempSkill._stc_learnBackground = UI.createControl(__ePAUIControl_Static, tempSkill._stc_skillBg, "Static_SkillGaugeBg_" .. idx)
    CopyBaseProperty(self._ui._stc_learnBackground, tempSkill._stc_learnBackground)
    tempSkill._stc_learnBackground:SetPosX(progressPosX)
    tempSkill._stc_learnBackground:SetPosY(progressPosY)
    tempSkill._stc_learnBackground:SetShow(true)
    tempSkill._stc_skillIcon = UI.createControl(__ePAUIControl_Static, tempSkill._stc_skillBg, "Static_SkillIcon_" .. idx)
    CopyBaseProperty(self._ui._stc_skillIcon, tempSkill._stc_skillIcon)
    tempSkill._stc_skillIcon:SetPosX(self._skillConfig.startIconX)
    tempSkill._stc_skillIcon:SetPosY(self._skillConfig.startIconY)
    tempSkill._stc_skillIcon:SetShow(true)
    if 0 == idx then
      tempSkill._stc_skillIcon:registerPadEvent(__eConsoleUIPadEvent_DpadUp, "EventHandler_LinkedSkill_SkillScroll(true)")
    elseif self._loopCount == idx then
      tempSkill._stc_skillIcon:registerPadEvent(__eConsoleUIPadEvent_DpadDown, "EventHandler_LinkedSkill_SkillScroll(false)")
    end
    tempSkill._txt_skillCondition = UI.createControl(__ePAUIControl_StaticText, tempSkill._stc_skillBg, "Static_SkillCondition_" .. idx)
    CopyBaseProperty(self._ui._txt_skillCondition, tempSkill._txt_skillCondition)
    tempSkill._txt_skillCondition:SetPosX(self._ui._stc_skillIcon:GetSizeX() + self._skillConfig.gapConditionX)
    tempSkill._txt_skillCondition:SetPosY(self._skillConfig.startConditionY)
    tempSkill._txt_skillCondition:SetShow(true)
    tempSkill._txt_skillName = UI.createControl(__ePAUIControl_StaticText, tempSkill._stc_skillBg, "Static_SkillName_" .. idx)
    CopyBaseProperty(self._ui._txt_skillName, tempSkill._txt_skillName)
    tempSkill._txt_skillName:SetPosX(self._ui._stc_skillIcon:GetSizeX() + self._skillConfig.gapNameX)
    tempSkill._txt_skillName:SetPosY(self._skillConfig.startNameY)
    tempSkill._txt_skillName:SetShow(true)
    tempSkill._progress_skillLearnGauge = UI.createControl(__ePAUIControl_CircularProgress, tempSkill._stc_skillBg, "Static_SkillGauge_" .. idx)
    CopyBaseProperty(self._ui._progress_skillLearnGauge, tempSkill._progress_skillLearnGauge)
    tempSkill._progress_skillLearnGauge:SetPosX(progressPosX)
    tempSkill._progress_skillLearnGauge:SetPosY(progressPosY)
    tempSkill._progress_skillLearnGauge:SetShow(true)
    tempSkill._txt_skillPercent = UI.createControl(__ePAUIControl_StaticText, tempSkill._stc_skillBg, "Static_SkillPercent_" .. idx)
    CopyBaseProperty(self._ui._txt_skillPercent, tempSkill._txt_skillPercent)
    tempSkill._txt_skillPercent:SetPosX(self._skillConfig.startPercenX)
    tempSkill._txt_skillPercent:SetPosY(self._skillConfig.startPercenY)
    tempSkill._txt_skillPercent:SetShow(true)
    self._skillSlot[idx] = tempSkill
  end
  ToClient_padSnapRefreshTarget(self._ui._stc_skillInfoBg)
end
function PaGlobal_LinkedSkill_All:setShowControl()
  if true == _ContentsGroup_UsePadSnapping then
    self._ui._pc._btn_close:SetShow(false)
  else
    self._ui._pc._btn_close:SetShow(true)
  end
end
function PaGlobal_LinkedSkill_All:init_equipSlot()
  self:initEquipSlotData(self._equip, self._equipSlotIds, "Static_EquipmentBg")
  self:initEquipSlotData(self._cache, self._cacheSlotIds, "Static_CashEquipBg")
end
function PaGlobal_LinkedSkill_All:initEquipSlotData(equipList, slotIds, parentName)
  local stc_equipBg = UI.getChildControl(Panel_Window_LinkedSkill_All, parentName)
  for index, value in pairs(equipList) do
    if nil == self._equipSlot[value._index] then
      local equipControl = UI.getChildControl(stc_equipBg, slotIds[value._slotNo])
      local temp = {}
      SlotItem.new(temp, slotIds[value._slotNo] .. value._slotNo, value._slotNo, equipControl, self._itemSlot)
      temp:createChild()
      temp.icon:SetPosX(0)
      temp.icon:SetPosY(0)
      temp.icon:addInputEvent("Mouse_On", "HandleEventOn_LinkedSkill_EquipTooltip(" .. value._index .. ")")
      temp.icon:addInputEvent("Mouse_Out", "HandleEventOut_LinkedSkill_EquipTooltip()")
      self._equipSlot[value._index] = temp
    end
  end
end
function PaGlobal_LinkedSkill_All:updateSkill()
  local carriageWrapper = getServantInfoFromActorKey(self._actorKeyRaw)
  if nil == carriageWrapper then
    return
  end
  local servantInfo = stable_getServantFromOwnerServant(carriageWrapper:getServantNo(), self._currentIndex)
  if nil == servantInfo then
    return
  end
  for ii = 0, self._loopCount do
    self._skillSlot[ii]._stc_skillBg:SetShow(false)
  end
  local skillCount = servantInfo:getSkillCount()
  local learnSkillCount = 0
  local startIndexCheck = 0
  self._skillCount = 0
  for skillIndex = 0, skillCount - 1 do
    local skillWrapper = servantInfo:getSkill(skillIndex)
    if nil ~= skillWrapper then
      if startIndexCheck == self._skillStartIndex then
        if learnSkillCount < self._skillConfig.count then
          local slot = self._skillSlot[learnSkillCount]
          slot._stc_skillBg:SetShow(true)
          slot._stc_skillIcon:ChangeTextureInfoName("Icon/" .. skillWrapper:getIconPath())
          slot._txt_skillName:SetText(skillWrapper:getName())
          slot._txt_skillCondition:SetText(skillWrapper:getDescription())
          UI.setLimitTextAndAddTooltip(slot._txt_skillCondition)
          slot._progress_skillLearnGauge:SetProgressRate(servantInfo:getSkillExp(skillIndex) / (skillWrapper:get()._maxExp * 0.01))
          slot._progress_skillLearnGauge:SetAniSpeed(0)
          local percent = tonumber(string.format("%.0f", servantInfo:getSkillExp(skillIndex) / (skillWrapper:get()._maxExp * 0.01)))
          if 100 < percent then
            percent = 100
          end
          slot._txt_skillPercent:SetText(percent .. "%")
          slot._stc_skillIcon:addInputEvent("Mouse_On", "HandleEventOn_LinkedSkill_SkillTooltip(" .. learnSkillCount .. ", " .. skillIndex .. ")")
          slot._stc_skillIcon:addInputEvent("Mouse_Out", "HandleEventOut_LinkedSkill_SkillTooltip()")
          learnSkillCount = learnSkillCount + 1
        end
      else
        startIndexCheck = startIndexCheck + 1
      end
      self._skillCount = self._skillCount + 1
    end
  end
  if self._skillConfig.count < self._skillCount then
    self._ui._scroll_skillScroll:SetShow(true)
    UIScroll.SetButtonSize(self._ui._scroll_skillScroll, self._skillConfig.count, self._skillCount)
  else
    self._ui._scroll_skillScroll:SetShow(false)
  end
  if 0 == self._skillStartIndex then
    self._ui._scroll_skillScroll:SetControlPos(0)
  end
end
function PaGlobal_LinkedSkill_All:updateEquip()
  self:updateEquipData(self._equip)
  self:updateEquipData(self._cache)
end
function PaGlobal_LinkedSkill_All:updateEquipData(equipList)
  local servantInfo = self:getServantInfo()
  if nil == servantInfo then
    return
  end
  for index, value in pairs(equipList) do
    local slot = self._equipSlot[value._index]
    local itemWrapper = servantInfo:getEquipItem(value._index)
    if nil ~= itemWrapper then
      slot:setItem(itemWrapper)
      slot.icon:SetIgnore(false)
    else
      slot:clearItem()
      slot.icon:SetIgnore(true)
    end
  end
end
function PaGlobal_LinkedSkill_All:getServantInfo()
  local carriageWrapper = getServantInfoFromActorKey(self._actorKeyRaw)
  if nil == carriageWrapper then
    return nil
  end
  local servantInfo = stable_getServantFromOwnerServant(carriageWrapper:getServantNo(), self._currentIndex)
  return servantInfo
end
function PaGlobal_LinkedSkill_All:repostion()
  if nil == Panel_Window_LinkedSkill_All then
    return
  end
  local posX = Panel_Window_VehicleInfo_All:GetPosX()
  local posY = Panel_Window_VehicleInfo_All:GetPosY()
  local sizeX = Panel_Window_VehicleInfo_All:GetSizeX()
  Panel_Window_LinkedSkill_All:SetPosX(posX + sizeX)
  Panel_Window_LinkedSkill_All:SetPosY(posY)
end
function PaGlobal_LinkedSkill_All:setAlignKeyGuide()
  if false == _ContentsGroup_UsePadSnapping then
    return
  end
  local keyGuide_RS = UI.getChildControl(self._ui._console._stc_keyGuideBG, "StaticText_Scroll")
  local keyGuide_B = UI.getChildControl(self._ui._console._stc_keyGuideBG, "StaticText_Close")
  local keyGuide = {keyGuide_RS, keyGuide_B}
  PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyGuide, self._ui._console._stc_keyGuideBG, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHT)
end
