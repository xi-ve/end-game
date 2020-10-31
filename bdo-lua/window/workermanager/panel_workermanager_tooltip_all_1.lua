function PaGlobal_WorkerManagerTooltip_All:initialize()
  if true == PaGlobal_WorkerManagerTooltip_All._initialize then
    return
  end
  PaGlobal_WorkerManagerTooltip_All._isConsole = _ContentsGroup_UsePadSnapping
  PaGlobal_WorkerManagerTooltip_All:ControlAll_Init()
  PaGlobal_WorkerManagerTooltip_All:ControlPc_Init()
  PaGlobal_WorkerManagerTooltip_All:ControlConsole_Init()
  PaGlobal_WorkerManagerTooltip_All:ControlSetShow()
  PaGlobal_WorkerManagerTooltip_All:registEventHandler()
  PaGlobal_WorkerManagerTooltip_All:validate()
  PaGlobal_WorkerManagerTooltip_All._initialize = true
end
function PaGlobal_WorkerManagerTooltip_All:ControlAll_Init()
  if nil == Panel_Widget_WorkerManagerTooltip_All then
    return
  end
  self._ui.txt_workerName = UI.getChildControl(Panel_Widget_WorkerManagerTooltip_All, "StaticText_workerName")
  self._ui.stc_mainBg = UI.getChildControl(Panel_Widget_WorkerManagerTooltip_All, "Static_MainBG")
  self._ui.stc_skillBg = UI.getChildControl(Panel_Widget_WorkerManagerTooltip_All, "Static_SkillBG")
  self._ui.stc_workerImgBg = UI.getChildControl(Panel_Widget_WorkerManagerTooltip_All, "Static_workerImgBG")
  self._ui.stc_workerImg = UI.getChildControl(self._ui.stc_workerImgBg, "Static_workerImg")
  self._ui.stc_progressBg = UI.getChildControl(self._ui.stc_workerImgBg, "Static_ProgressBG")
  self._ui.proegress_exp = UI.getChildControl(self._ui.stc_workerImgBg, "Progress2_ExpPoint")
  self._ui.txt_level = UI.getChildControl(Panel_Widget_WorkerManagerTooltip_All, "StaticText_Level")
  self._ui.txt_exp = UI.getChildControl(Panel_Widget_WorkerManagerTooltip_All, "StaticText_EXP_Value")
  self._ui.txt_workSpeed = UI.getChildControl(Panel_Widget_WorkerManagerTooltip_All, "StaticText_WorkerWork2Speed")
  self._ui.txt_workSpeedVal = UI.getChildControl(Panel_Widget_WorkerManagerTooltip_All, "StaticText_WorkerWork2Speed_Value")
  self._ui.txt_moveSpeed = UI.getChildControl(Panel_Widget_WorkerManagerTooltip_All, "StaticText_WorkerMoveSpeed")
  self._ui.txt_moveSpeedVal = UI.getChildControl(Panel_Widget_WorkerManagerTooltip_All, "StaticText_workerMoveSpeed_value")
  self._ui.txt_lucky = UI.getChildControl(Panel_Widget_WorkerManagerTooltip_All, "StaticText_WorkerLucky")
  self._ui.txt_luckyVal = UI.getChildControl(Panel_Widget_WorkerManagerTooltip_All, "StaticText_workerLuck_value")
  self._ui.txt_action = UI.getChildControl(Panel_Widget_WorkerManagerTooltip_All, "StaticText_WorkerActionPoint")
  self._ui.txt_actionVal = UI.getChildControl(Panel_Widget_WorkerManagerTooltip_All, "StaticText_workerActionPoint_value")
  self._ui.txt_town = UI.getChildControl(Panel_Widget_WorkerManagerTooltip_All, "StaticText_TownInfo")
  self._ui.txt_advence = UI.getChildControl(Panel_Widget_WorkerManagerTooltip_All, "StaticText_AdvanceCount")
  self._ui.stc_skillBoxBg = UI.getChildControl(Panel_Widget_WorkerManagerTooltip_All, "Static_SkillBoxBG")
  self._ui.stc_skillBoxDefault = UI.getChildControl(self._ui.stc_skillBoxBg, "Static_SkillBox_Default")
  self._ui.stc_skillSlotBg = UI.getChildControl(self._ui.stc_skillBoxBg, "Static_SkillSlotBG_00")
  self._ui.stc_skillSlot = UI.getChildControl(self._ui.stc_skillBoxBg, "Static_SkillSlot_00")
  self._ui.txt_skillName = UI.getChildControl(self._ui.stc_skillBoxBg, "StaticText_SkillName_00")
  self._ui.txt_skillDesc = UI.getChildControl(self._ui.stc_skillBoxBg, "StaticText_SkillDesc_00")
  self._basePanelSizeY = Panel_Widget_WorkerManagerTooltip_All:GetSizeY()
  self._baseMainBgSizeY = self._ui.stc_mainBg:GetSizeY()
  self._baseSkillBgSizeY = self._ui.stc_skillBg:GetSizeY()
  self._slotStartPosY = self._ui.stc_skillBoxBg:GetPosY()
  local defaultSlot = {}
  defaultSlot.skillBox = UI.createAndCopyBasePropertyControl(Panel_Widget_WorkerManagerTooltip_All, "Static_SkillBoxBG", Panel_Widget_WorkerManagerTooltip_All, "WorkerSkillDefualt_SkillBoxBg_")
  defaultSlot.default = UI.createAndCopyBasePropertyControl(self._ui.stc_skillBoxBg, "Static_SkillBox_Default", defaultSlot.skillBox, "WorkerSkillDefualt_SkillDefault_")
  defaultSlot.iconBg = UI.createAndCopyBasePropertyControl(self._ui.stc_skillBoxBg, "Static_SkillSlotBG_00", defaultSlot.skillBox, "WorkerSkillDefualt_SlotBG_")
  defaultSlot.icon = UI.createAndCopyBasePropertyControl(self._ui.stc_skillBoxBg, "Static_SkillSlot_00", defaultSlot.skillBox, "WorkerSkillDefualt_SlotIcon_")
  defaultSlot.name = UI.createAndCopyBasePropertyControl(self._ui.stc_skillBoxBg, "StaticText_SkillName_00", defaultSlot.skillBox, "WorkerSkillDefualt_SlotName_")
  defaultSlot.desc = UI.createAndCopyBasePropertyControl(self._ui.stc_skillBoxBg, "StaticText_SkillDesc_00", defaultSlot.skillBox, "WorkerSkillDefualt_SlotDesc_")
  defaultSlot.skillBox:SetPosY(self._slotStartPosY)
  defaultSlot.default:ComputePos()
  defaultSlot.iconBg:ComputePos()
  defaultSlot.icon:ComputePos()
  defaultSlot.name:ComputePos()
  defaultSlot.desc:ComputePos()
  defaultSlot.skillBox:SetShow(false)
  self._defaultSlot = defaultSlot
  for idx = 0, self._maxSkillCount - 1 do
    local tempSlot = {}
    tempSlot.skillBox = UI.createAndCopyBasePropertyControl(Panel_Widget_WorkerManagerTooltip_All, "Static_SkillBoxBG", Panel_Widget_WorkerManagerTooltip_All, "WorkerSkill_SkillBoxBg_" .. idx)
    tempSlot.default = UI.createAndCopyBasePropertyControl(self._ui.stc_skillBoxBg, "Static_SkillBox_Default", tempSlot.skillBox, "WorkerSkill_SkillDefault_" .. idx)
    tempSlot.iconBg = UI.createAndCopyBasePropertyControl(self._ui.stc_skillBoxBg, "Static_SkillSlotBG_00", tempSlot.skillBox, "WorkerSkill_SlotBG_" .. idx)
    tempSlot.icon = UI.createAndCopyBasePropertyControl(self._ui.stc_skillBoxBg, "Static_SkillSlot_00", tempSlot.skillBox, "WorkerSkill_SlotIcon_" .. idx)
    tempSlot.name = UI.createAndCopyBasePropertyControl(self._ui.stc_skillBoxBg, "StaticText_SkillName_00", tempSlot.skillBox, "WorkerSkill_SlotName_" .. idx)
    tempSlot.desc = UI.createAndCopyBasePropertyControl(self._ui.stc_skillBoxBg, "StaticText_SkillDesc_00", tempSlot.skillBox, "WorkerSkill_SlotDesc_" .. idx)
    tempSlot.skillBox:SetPosY(self._slotStartPosY + (tempSlot.skillBox:GetSizeY() + 3) * idx)
    tempSlot.default:ComputePos()
    tempSlot.iconBg:ComputePos()
    tempSlot.icon:ComputePos()
    tempSlot.name:ComputePos()
    tempSlot.desc:ComputePos()
    tempSlot.default:SetShow(false)
    self._skill[idx] = tempSlot
  end
end
function PaGlobal_WorkerManagerTooltip_All:ControlPc_Init()
  if nil == Panel_Widget_WorkerManagerTooltip_All then
    return
  end
end
function PaGlobal_WorkerManagerTooltip_All:ControlConsole_Init()
  if nil == Panel_Widget_WorkerManagerTooltip_All then
    return
  end
end
function PaGlobal_WorkerManagerTooltip_All:ControlSetShow()
  if nil == Panel_Widget_WorkerManagerTooltip_All then
    return
  end
end
function PaGlobal_WorkerManagerTooltip_All:prepareOpen(workerNoRaw, panel, isRight, isPlant)
  if nil == Panel_Widget_WorkerManagerTooltip_All then
    return
  end
  PaGlobalFunc_WorkerManagerTooltip_All_Audio(1, 13)
  self._workerData = workerNoRaw
  self._parentPanel = panel
  self._isRight = isRight
  self._isPlant = isPlant
  PaGlobal_WorkerManagerTooltip_All:update()
  PaGlobal_WorkerManagerTooltip_All:open()
  PaGlobal_WorkerManagerTooltip_All:resize()
end
function PaGlobal_WorkerManagerTooltip_All:open()
  if nil == Panel_Widget_WorkerManagerTooltip_All then
    return
  end
  Panel_Widget_WorkerManagerTooltip_All:SetShow(true)
end
function PaGlobal_WorkerManagerTooltip_All:prepareClose()
  if nil == Panel_Widget_WorkerManagerTooltip_All then
    return
  end
  self._workerData = -1
  self._parentPanel = nil
  self._isRight = true
  self._isPlant = false
  PaGlobal_WorkerManagerTooltip_All:close()
end
function PaGlobal_WorkerManagerTooltip_All:close()
  if nil == Panel_Widget_WorkerManagerTooltip_All then
    return
  end
  Panel_Widget_WorkerManagerTooltip_All:SetShow(false)
end
function PaGlobal_WorkerManagerTooltip_All:update()
  if nil == Panel_Widget_WorkerManagerTooltip_All then
    return
  end
  if false == self._initialize then
    return
  end
  self:updateWorkerInfo()
  self:updateSkillList()
end
function PaGlobal_WorkerManagerTooltip_All:registEventHandler()
  if nil == Panel_Widget_WorkerManagerTooltip_All then
    return
  end
  registerEvent("FromClient_WorkerInfoChanged", "FromClient_WorkerManagerTooltip_All_WorkerInfoChanged")
end
function PaGlobal_WorkerManagerTooltip_All:validate()
  if nil == Panel_Widget_WorkerManagerTooltip_All then
    return
  end
  self._ui.txt_workerName:isValidate()
  self._ui.stc_mainBg:isValidate()
  self._ui.stc_skillBg:isValidate()
  self._ui.stc_workerImgBg:isValidate()
  self._ui.stc_workerImg:isValidate()
  self._ui.stc_progressBg:isValidate()
  self._ui.proegress_exp:isValidate()
  self._ui.txt_level:isValidate()
  self._ui.txt_exp:isValidate()
  self._ui.txt_workSpeed:isValidate()
  self._ui.txt_workSpeedVal:isValidate()
  self._ui.txt_moveSpeed:isValidate()
  self._ui.txt_moveSpeedVal:isValidate()
  self._ui.txt_lucky:isValidate()
  self._ui.txt_luckyVal:isValidate()
  self._ui.txt_action:isValidate()
  self._ui.txt_actionVal:isValidate()
  self._ui.txt_town:isValidate()
  self._ui.txt_advence:isValidate()
  self._ui.stc_skillBoxBg:isValidate()
  self._ui.stc_skillBoxDefault:isValidate()
  self._ui.stc_skillSlotBg:isValidate()
  self._ui.stc_skillSlot:isValidate()
  self._ui.txt_skillName:isValidate()
  self._ui.txt_skillDesc:isValidate()
end
function PaGlobal_WorkerManagerTooltip_All:resize()
  if nil == Panel_Widget_WorkerManagerTooltip_All then
    return
  end
  self._ui.stc_mainBg:ComputePos()
  self._ui.stc_skillBg:ComputePos()
  if nil ~= self._parentPanel then
    local posX = self._parentPanel:GetParentPosX()
    local posY = self._parentPanel:GetParentPosY()
    local panelSizeX = self._parentPanel:GetSizeX()
    local panelSizeY = self._parentPanel:GetSizeY()
    local tooltipSizeX = Panel_Widget_WorkerManagerTooltip_All:GetSizeX()
    local tooltipSizeY = Panel_Widget_WorkerManagerTooltip_All:GetSizeY()
    local scrnSizeX = getScreenSizeX()
    local scrnSizeY = getScreenSizeY()
    if posX - tooltipSizeX - 5 < 10 then
      Panel_Widget_WorkerManagerTooltip_All:SetPosX(posX + panelSizeX + 5)
    else
      Panel_Widget_WorkerManagerTooltip_All:SetPosX(posX - tooltipSizeX - 5)
    end
    if scrnSizeY > posY + tooltipSizeY then
      Panel_Widget_WorkerManagerTooltip_All:SetPosY(posY)
    else
      local sizeY = posY + tooltipSizeY - scrnSizeY
      Panel_Widget_WorkerManagerTooltip_All:SetPosY(posY - sizeY)
    end
  end
  Panel_Widget_WorkerManagerTooltip_All:setFlushAble(false)
end
function PaGlobal_WorkerManagerTooltip_All:updateWorkerInfo()
  if nil == Panel_Widget_WorkerManagerTooltip_All then
    return
  end
  local workerWrapperLua = getWorkerWrapper(self._workerData, true)
  if nil == workerWrapperLua then
    return
  end
  local workerIcon = workerWrapperLua:getWorkerIcon()
  self._ui.stc_workerImg:ChangeTextureInfoName(workerIcon)
  local workerName = workerWrapperLua:getGradeToColorString() .. workerWrapperLua:getName() .. "<PAOldColor>"
  self._ui.txt_workerName:SetText(workerName)
  local workerLv = PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_LV") .. workerWrapperLua:getLevel()
  self._ui.txt_level:SetText(workerLv)
  local curExperience = Int64toInt32(workerWrapperLua:getExperience())
  local maxExperience = Int64toInt32(workerWrapperLua:getMaxExperience())
  local exp = 0
  if 0 == curExperience or 0 == maxExperience then
    exp = 0
  else
    exp = math.floor(curExperience / maxExperience * 100)
  end
  self._ui.txt_exp:SetText(exp .. "%")
  self._ui.proegress_exp:SetProgressRate(exp)
  local workerActionPoint = workerWrapperLua:getActionPoint()
  local workerMaxActionPoint = workerWrapperLua:getMaxActionPoint()
  local _tempActionPoint = tostring(workerActionPoint) .. "/" .. tostring(workerMaxActionPoint)
  self._ui.txt_actionVal:SetText(_tempActionPoint)
  local _tempWorkEfficiency = 0
  if _tempWorkEfficiency < workerWrapperLua:getWorkEfficiency(CppEnums.ProductCategory.ProductCategory_Farm) then
    _tempWorkEfficiency = workerWrapperLua:getWorkEfficiency(CppEnums.ProductCategory.ProductCategory_Farm)
  end
  if _tempWorkEfficiency < workerWrapperLua:getWorkEfficiency(CppEnums.ProductCategory.ProductCategory_UseRecipes) then
    _tempWorkEfficiency = workerWrapperLua:getWorkEfficiency(CppEnums.ProductCategory.ProductCategory_UseRecipes)
  end
  if _tempWorkEfficiency < workerWrapperLua:getWorkEfficiency(CppEnums.ProductCategory.ProductCategory_DynamicPlant) then
    _tempWorkEfficiency = workerWrapperLua:getWorkEfficiency(CppEnums.ProductCategory.ProductCategory_DynamicPlant)
  end
  if _tempWorkEfficiency < workerWrapperLua:getWorkEfficiency(CppEnums.ProductCategory.ProductCategory_LargeCraft) then
    _tempWorkEfficiency = workerWrapperLua:getWorkEfficiency(CppEnums.ProductCategory.ProductCategory_LargeCraft)
  end
  self._ui.txt_workSpeedVal:SetText(string.format("%.2f", tostring(_tempWorkEfficiency / 1000000)))
  self._ui.txt_moveSpeedVal:SetText(string.format("%.2f", workerWrapperLua:getMoveSpeed() / 100))
  self._ui.txt_luckyVal:SetText(string.format("%.2f", workerWrapperLua:getLuck() / 10000))
  local homeWayPoint = ToClient_GetNodeNameByWaypointKey(workerWrapperLua:getHomeWaypoint())
  self._ui.txt_town:SetText(tostring(homeWayPoint))
  local workerUpgradeCount = workerWrapperLua:getUpgradePoint()
  self._ui.txt_advence:SetShow(true)
  self._ui.txt_advence:SetText(workerUpgradeCount)
  if false == workerWrapperLua:isUpgradable() or 30 == workerLv and 0 == workerUpgradeCount or nil ~= workerWrapperLua:getWorkerDefaultSkillStaticStatus() or CppEnums.CharacterGradeType.CharacterGradeType_Boss == workerWrapperLua:getGrade() then
    self._ui.txt_advence:SetShow(false)
  end
end
function PaGlobal_WorkerManagerTooltip_All:updateSkillList()
  local workerWrapperLua = getWorkerWrapper(self._workerData, true)
  if nil == workerWrapperLua then
    return
  end
  local defaultSkill = workerWrapperLua:getWorkerDefaultSkillStaticStatus()
  local defaultSkillCnt = 0
  if nil ~= defaultSkill then
    self._defaultSlot.skillBox:SetShow(true)
    self._defaultSlot.icon:ChangeTextureInfoName(defaultSkill:getIconPath())
    self._defaultSlot.name:SetText(defaultSkill:getName())
    self._defaultSlot.desc:SetTextMode(__eTextMode_AutoWrap)
    self._defaultSlot.desc:SetText(defaultSkill:getDescription())
    defaultSkillCnt = 1
    local addSizeY = self._defaultSlot.skillBox:GetSizeY()
    self._ui.stc_mainBg:SetSize(self._ui.stc_mainBg:GetSizeX(), self._baseMainBgSizeY + addSizeY)
    self._ui.stc_skillBg:SetSize(self._ui.stc_skillBg:GetSizeX(), self._baseSkillBgSizeY + addSizeY)
    Panel_Widget_WorkerManagerTooltip_All:SetSize(Panel_Widget_WorkerManagerTooltip_All:GetSizeX(), self._basePanelSizeY + addSizeY)
  else
    self._defaultSlot.skillBox:SetShow(false)
    self._ui.stc_mainBg:SetSize(self._ui.stc_mainBg:GetSizeX(), self._baseMainBgSizeY)
    self._ui.stc_skillBg:SetSize(self._ui.stc_skillBg:GetSizeX(), self._baseSkillBgSizeY)
    Panel_Widget_WorkerManagerTooltip_All:SetSize(Panel_Widget_WorkerManagerTooltip_All:GetSizeX(), self._basePanelSizeY)
  end
  for idx = 0, self._maxSkillCount - 1 do
    self._skill[idx].skillBox:SetPosY(self._slotStartPosY + (self._skill[idx].skillBox:GetSizeY() + 3) * (idx + defaultSkillCnt))
    local skillLev = 0
    if 0 == idx then
      skillLev = 1
    else
      skillLev = idx * 5
    end
    self._skill[idx].skillBox:SetShow(true)
    self._skill[idx].icon:SetShow(false)
    self._skill[idx].name:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_LV") .. "." .. skillLev)
    self._skill[idx].desc:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_WORKER_TOOLTIP_HAVENT_THISSKILL"))
  end
  local skillCount = workerWrapperLua:getSkillCount()
  if 0 ~= skillCount then
    workerWrapperLua:foreachSkillList(function(index, skillStaticStatusWrapper)
      if nil == self._skill[index] then
        return true
      end
      self._skill[index].icon:SetShow(true)
      self._skill[index].icon:ChangeTextureInfoName(skillStaticStatusWrapper:getIconPath())
      self._skill[index].name:SetText(skillStaticStatusWrapper:getName())
      self._skill[index].desc:SetTextMode(__eTextMode_AutoWrap)
      self._skill[index].desc:SetText(skillStaticStatusWrapper:getDescription())
      return false
    end)
  end
end
