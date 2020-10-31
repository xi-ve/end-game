function PaGlobal_Window_FamilySkill_Main:initialize()
  local static_TopBg = UI.getChildControl(Panel_Window_FamilySkill_Main, "Static_TopBg")
  local static_1 = UI.getChildControl(static_TopBg, "Static_1")
  for index = self._ePoint.exp, self._ePoint.count do
    self._ui._skillPointTitleArray[index] = UI.getChildControl(static_1, "StaticText_SkillPointTitle" .. index)
    self._ui._skillPointValueArray[index] = UI.getChildControl(static_1, "StaticText_SkillPointValue" .. index)
    self._ui._skillPointTitleArray[index]:SetTextMode(__eTextMode_AutoWrap)
    self._ui._skillPointValueArray[index]:SetTextMode(__eTextMode_AutoWrap)
  end
  self._ui._skillExpProgressBar = UI.getChildControl(static_1, "Progress2_Exp")
  self._ui._resetSkillButton = UI.getChildControl(static_1, "Button_Reset")
  local familySkillContentsDescription = UI.getChildControl(static_1, "StaticText_Desc")
  familySkillContentsDescription:SetTextMode(__eTextMode_AutoWrap)
  familySkillContentsDescription:SetText(ToClient_GetFamilySkillContentsDescription())
  local static_ResultBg = UI.getChildControl(static_TopBg, "Static_ResultBg")
  self._ui._skillDescription = UI.getChildControl(static_ResultBg, "List2_1")
  local static_MidBg = UI.getChildControl(Panel_Window_FamilySkill_Main, "Static_MidBg")
  local skillKindCount = ToClient_GetFamilySkillKindCount()
  for index = 0, skillKindCount - 1 do
    self._ui._skillIconBgArray[index] = UI.getChildControl(static_MidBg, "Static_SkillBg_" .. index)
    self._ui._skillIconArray[index] = UI.getChildControl(self._ui._skillIconBgArray[index], "Static_SkillIcon_" .. index)
    self._ui._skillIconTextArray[index] = UI.getChildControl(self._ui._skillIconBgArray[index], "StaticText_" .. index)
  end
  self._ui._skillList = UI.getChildControl(static_MidBg, "List2_SKillList")
  self:registEventHandler()
  self:validate()
  self._initialize = true
end
function PaGlobal_Window_FamilySkill_Main:updateSkillList()
  if nil == Panel_Window_FamilySkill_Main or false == self._initialize then
    return
  end
  self._ui._skillList:getElementManager():clearKey()
  local maxSkilLevel = ToClient_GetFamilySkillMaxLevel()
  for skilLevel = 0, maxSkilLevel do
    self._ui._skillList:getElementManager():pushKey(toInt64(0, skilLevel))
    self._ui._skillList:requestUpdateByKey(toInt64(0, skilLevel))
  end
end
function PaGlobal_Window_FamilySkill_Main:updateSkillDescription()
  if nil == Panel_Window_FamilySkill_Main or false == self._initialize then
    return
  end
  self._ui._skillDescription:getElementManager():clearKey()
  local skillKindCount = ToClient_GetFamilySkillKindCount()
  for index = 0, skillKindCount - 1 do
    self._ui._skillDescription:getElementManager():pushKey(toInt64(0, index))
    self._ui._skillDescription:requestUpdateByKey(toInt64(0, index))
  end
end
function PaGlobal_Window_FamilySkill_Main:updateBigSkillIcon()
  if nil == Panel_Window_FamilySkill_Main or false == self._initialize then
    return
  end
  local skillIconBgUV = {
    [0] = {
      1,
      82,
      82,
      162
    },
    [1] = {
      65,
      244,
      128,
      306
    },
    [2] = {
      129,
      244,
      192,
      306
    },
    [3] = {
      193,
      244,
      256,
      306
    }
  }
  local skillIconUV = {
    [0] = {
      2,
      2,
      46,
      46
    },
    [1] = {
      48,
      2,
      92,
      46
    },
    [2] = {
      94,
      2,
      138,
      46
    },
    [3] = {
      140,
      2,
      184,
      46
    }
  }
  local x1, y1, x2, y2
  local skillKindCount = ToClient_GetFamilySkillKindCount()
  for index = 0, skillKindCount - 1 do
    local skillIconBg = self._ui._skillIconBgArray[index]
    skillIconBg:ChangeTextureInfoName("renewal/PcRemaster/Remaster_Edana_00.dds")
    x1, y1, x2, y2 = setTextureUV_Func(skillIconBg, skillIconBgUV[index][1], skillIconBgUV[index][2], skillIconBgUV[index][3], skillIconBgUV[index][4])
    skillIconBg:getBaseTexture():setUV(x1, y1, x2, y2)
    skillIconBg:setRenderTexture(skillIconBg:getBaseTexture())
    skillIconBg:SetShow(true)
  end
  for index = 0, skillKindCount - 1 do
    local skillIcon = self._ui._skillIconArray[index]
    skillIcon:ChangeTextureInfoName("renewal/PcRemaster/Remaster_Edana_01.dds")
    x1, y1, x2, y2 = setTextureUV_Func(skillIcon, skillIconUV[index][1], skillIconUV[index][2], skillIconUV[index][3], skillIconUV[index][4])
    skillIcon:getBaseTexture():setUV(x1, y1, x2, y2)
    skillIcon:setRenderTexture(skillIcon:getBaseTexture())
    skillIcon:SetShow(true)
  end
end
function PaGlobal_Window_FamilySkill_Main:registEventHandler()
  if nil == Panel_Window_FamilySkill_Main then
    return
  end
  self._ui._resetSkillButton:addInputEvent("Mouse_LUp", "HandleEventMouseLup_FamilySkill_resetSkill()")
  self._ui._skillList:registEvent(__ePAUIList2EventType_LuaChangeContent, "HandleEventChangeListContent_createSkillList")
  self._ui._skillList:createChildContent(__ePAUIList2ElementManagerType_List)
  self._ui._skillDescription:registEvent(__ePAUIList2EventType_LuaChangeContent, "HandleEventChangeListContent_createSkillDescription")
  self._ui._skillDescription:createChildContent(__ePAUIList2ElementManagerType_List)
  for index = 0, ToClient_GetFamilySkillKindCount() - 1 do
    self._ui._skillIconBgArray[index]:addInputEvent("Mouse_On", "HandleEventMOn_FamilySkill_ShowSkillKindTooltip(true, " .. index .. ")")
    self._ui._skillIconBgArray[index]:addInputEvent("Mouse_Out", "HandleEventMOn_FamilySkill_ShowSkillKindTooltip(false, " .. index .. ")")
  end
end
function PaGlobal_Window_FamilySkill_Main:prepareOpen()
  if nil == Panel_Window_FamilySkill_Main then
    return
  end
  self:update()
  self:open()
end
function PaGlobal_Window_FamilySkill_Main:open()
  if nil == Panel_Window_FamilySkill_Main then
    return
  end
  Panel_Window_FamilySkill_Main:SetShow(true)
end
function PaGlobal_Window_FamilySkill_Main:prepareClose()
  if nil == Panel_Window_FamilySkill_Main then
    return
  end
  self:close()
end
function PaGlobal_Window_FamilySkill_Main:close()
  if nil == Panel_Window_FamilySkill_Main then
    return
  end
  Panel_Window_FamilySkill_Main:SetShow(false)
end
function PaGlobal_Window_FamilySkill_Main:validate()
  if nil == Panel_Window_FamilySkill_Main then
    return
  end
  for index, skillPointTitle in pairs(self._ui._skillPointTitleArray) do
    skillPointTitle:isValidate()
  end
  for index, skillPointValue in pairs(self._ui._skillPointValueArray) do
    skillPointValue:isValidate()
  end
  local skillKindCount = ToClient_GetFamilySkillKindCount()
  self._ui._resetSkillButton:isValidate()
  for index = 0, skillKindCount - 1 do
    local skillIcon = self._ui._skillIconArray[index]
    skillIcon:isValidate()
  end
  local skillKindCount = ToClient_GetFamilySkillKindCount()
  for index = 0, skillKindCount - 1 do
    local skillIconBg = self._ui._skillIconBgArray[index]
    skillIconBg:isValidate()
  end
  self._ui._skillList:isValidate()
  self._ui._skillDescription:isValidate()
end
function PaGlobal_Window_FamilySkill_Main:showWindow()
  if nil == Panel_Window_FamilySkill_Main then
    return
  end
  self:update()
end
function PaGlobal_Window_FamilySkill_Main:update()
  if nil == Panel_Window_FamilySkill_Main then
    return
  end
  self:updateBigSkillIcon()
  self:updateSkillList()
  self:updateSkillDescription()
  self:updatePointDescription()
end
function PaGlobal_Window_FamilySkill_Main:updatePointDescription()
  if nil == Panel_Window_FamilySkill_Main or false == self._initialize then
    return
  end
  local skillExp = Int64toInt32(ToClient_GetFamilySkillExp())
  local currentTotalPoint = ToClient_GetFamilySkillTotalPoint()
  local requireExp = Int64toInt32(ToClient_GetRequireExpForFamilySkillPoint(currentTotalPoint))
  local rate = 0
  if 0 ~= requireExp then
    rate = skillExp / requireExp * 1000
    rate = math.floor(rate) / 10
  end
  self._ui._skillPointValueArray[self._ePoint.exp]:SetText(tostring(skillExp) .. " / " .. tostring(requireExp) .. " (" .. rate .. "%)")
  self._ui._skillPointValueArray[self._ePoint.point]:SetText(tostring(ToClient_GetFamilySkillRemainedPoint()) .. " / " .. tostring(ToClient_GetFamilySkillTotalPoint()))
  self._ui._skillPointValueArray[self._ePoint.grade]:SetText(tostring(ToClient_GetFamilySkillGrade()))
  self._ui._skillExpProgressBar:SetProgressRate(rate)
end
function PaGlobal_CharacterInfoFamilySkill_Init()
  PaGlobal_Window_FamilySkill_Main:initialize()
  PaGlobal_Window_FamilySkill_Main:update()
end
