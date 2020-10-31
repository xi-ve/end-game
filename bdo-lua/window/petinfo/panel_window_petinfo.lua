Panel_Window_PetInfoNew:SetShow(false)
local PetInfo = {
  BTN_Close = UI.getChildControl(Panel_Window_PetInfoNew, "Button_Win_Close"),
  petInfoBg = UI.getChildControl(Panel_Window_PetInfoNew, "Static_BG"),
  iconPet = UI.getChildControl(Panel_Window_PetInfoNew, "Static_IconPet"),
  petName = UI.getChildControl(Panel_Window_PetInfoNew, "StaticText_PetName"),
  progress_EXP = UI.getChildControl(Panel_Window_PetInfoNew, "Static_Progress_EXP"),
  level_Title = UI.getChildControl(Panel_Window_PetInfoNew, "StaticText_Level_Title"),
  level_Value = UI.getChildControl(Panel_Window_PetInfoNew, "StaticText_Level_Value"),
  progress_Hungry = UI.getChildControl(Panel_Window_PetInfoNew, "Static_Progress_Hungry"),
  icon_Lovely = UI.getChildControl(Panel_Window_PetInfoNew, "Static_LovelyIcon"),
  bg_Lovely = UI.getChildControl(Panel_Window_PetInfoNew, "Static_Progress_Lovely_BG"),
  progress_Lovely = UI.getChildControl(Panel_Window_PetInfoNew, "Static_Progress_Lovely"),
  action = {
    [0] = UI.getChildControl(Panel_Window_PetInfoNew, "Static_Specificity_1"),
    UI.getChildControl(Panel_Window_PetInfoNew, "Static_Specificity_2"),
    UI.getChildControl(Panel_Window_PetInfoNew, "Static_Specificity_3"),
    UI.getChildControl(Panel_Window_PetInfoNew, "Static_Specificity_4"),
    UI.getChildControl(Panel_Window_PetInfoNew, "Static_Specificity_5"),
    UI.getChildControl(Panel_Window_PetInfoNew, "Static_Specificity_6"),
    UI.getChildControl(Panel_Window_PetInfoNew, "Static_Specificity_7"),
    UI.getChildControl(Panel_Window_PetInfoNew, "Static_Specificity_8"),
    UI.getChildControl(Panel_Window_PetInfoNew, "Static_Specificity_9"),
    UI.getChildControl(Panel_Window_PetInfoNew, "Static_Specificity_10")
  },
  actionSlot = {
    [0] = UI.getChildControl(Panel_Window_PetInfoNew, "Static_1"),
    UI.getChildControl(Panel_Window_PetInfoNew, "Static_2"),
    UI.getChildControl(Panel_Window_PetInfoNew, "Static_3"),
    UI.getChildControl(Panel_Window_PetInfoNew, "Static_4"),
    UI.getChildControl(Panel_Window_PetInfoNew, "Static_5"),
    UI.getChildControl(Panel_Window_PetInfoNew, "Static_6"),
    UI.getChildControl(Panel_Window_PetInfoNew, "Static_7"),
    UI.getChildControl(Panel_Window_PetInfoNew, "Static_8"),
    UI.getChildControl(Panel_Window_PetInfoNew, "Static_9"),
    UI.getChildControl(Panel_Window_PetInfoNew, "Static_10")
  },
  skillBg = UI.getChildControl(Panel_Window_PetInfoNew, "Static_SkillBg"),
  skillSlotBg = {
    [0] = UI.getChildControl(Panel_Window_PetInfoNew, "Static_SkillBg_1"),
    UI.getChildControl(Panel_Window_PetInfoNew, "Static_SkillBg_2"),
    UI.getChildControl(Panel_Window_PetInfoNew, "Static_SkillBg_3"),
    UI.getChildControl(Panel_Window_PetInfoNew, "Static_SkillBg_4"),
    UI.getChildControl(Panel_Window_PetInfoNew, "Static_SkillBg_5")
  },
  skillSlot = {
    [0] = UI.getChildControl(Panel_Window_PetInfoNew, "Static_SkillSlot_1"),
    UI.getChildControl(Panel_Window_PetInfoNew, "Static_SkillSlot_2"),
    UI.getChildControl(Panel_Window_PetInfoNew, "Static_SkillSlot_3"),
    UI.getChildControl(Panel_Window_PetInfoNew, "Static_SkillSlot_4"),
    UI.getChildControl(Panel_Window_PetInfoNew, "Static_SkillSlot_5")
  },
  baseSkill_1 = UI.getChildControl(Panel_Window_PetInfoNew, "StaticText_Skill_1"),
  baseSkill_2 = UI.getChildControl(Panel_Window_PetInfoNew, "StaticText_Skill_2"),
  PetNo = 0,
  currentPetLv = {}
}
local _buttonQuestion = UI.getChildControl(Panel_Window_PetInfoNew, "Button_Question")
_buttonQuestion:addInputEvent("Mouse_LUp", "Panel_WebHelper_ShowToggle( \"Pet\" )")
PaGlobal_Util_RegistHelpTooltipEvent(_buttonQuestion, "\"Pet\"")
local petIcon = false
function PetInfo:Update(isSealed)
  local function petSkillType(PcPetData, param)
    local skillParam = PcPetData:getSkillParam(param)
    local paramText = ""
    if 1 == skillParam._type then
      local petLootingType = PcPetData:getPetLootingType()
      local variableCount = 1
      if 0 == petLootingType then
        variableCount = 1.1
      elseif 2 == petLootingType then
        variableCount = 0.9
      end
      paramText = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_PETINFO_PETSKILLTYPE_ITEMGETTIME", "itemGetTime", string.format("%.1f", skillParam:getParam(0) * variableCount / 1000))
    elseif 2 == skillParam._type then
      paramText = PAGetString(Defines.StringSheet_GAME, "LUA_PETINFO_PETSKILLTYPE_FINDGATHER")
    elseif 3 == skillParam._type then
      paramText = PAGetString(Defines.StringSheet_GAME, "LUA_PETINFO_PETSKILLTYPE_FINDPK")
    elseif 4 == skillParam._type then
      paramText = PAGetString(Defines.StringSheet_GAME, "LUA_PETINFO_PETSKILLTYPE_FINDPLACE")
    elseif 5 == skillParam._type then
      paramText = PAGetString(Defines.StringSheet_GAME, "LUA_PETINFO_PETSKILLTYPE_MOBAGGRO")
    elseif 6 == skillParam._type then
      paramText = PAGetString(Defines.StringSheet_GAME, "LUA_PETINFO_PETSKILLTYPE_FINDRAREMONSTER")
    elseif 7 == skillParam._type then
      paramText = PAGetString(Defines.StringSheet_GAME, "LUA_PETINFO_PETSKILLTYPE_REDUCEAUTOFISHINGTIME")
    elseif 8 == skillParam._type then
      paramText = PAGetString(Defines.StringSheet_GAME, "LUA_PETINFO_PETSKILLTYPE_REGISTILL")
    elseif 9 == skillParam._type then
      paramText = PAGetString(Defines.StringSheet_GAME, "LUA_PETINFO_PETSKILLTYPE_AUTOGETHERING")
    elseif 10 == skillParam._type then
      paramText = PAGetString(Defines.StringSheet_GAME, "LUA_PETINFO_PETSKILLTYPE_GETHERINGINCREASE")
    else
      if 0 == param then
        self.baseSkill_1:SetShow(false)
      elseif 1 == param then
        self.baseSkill_2:SetShow(false)
      end
      return
    end
    if 0 == param then
      self.baseSkill_1:SetShow(true)
      self.baseSkill_1:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_PETINFO_BASESKILL", "paramText", paramText))
    elseif 1 == param then
      self.baseSkill_2:SetShow(true)
      self.baseSkill_2:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_PETINFO_SPECIALSKILL", "paramText", paramText))
    end
  end
  if isSealed then
    local petNo = self.PetNo
    local petCount = ToClient_getPetSealedList()
    if petCount == 0 then
      return
    end
    for index = 0, petCount - 1 do
      local PetSealData = ToClient_getPetSealedDataByIndex(index)
      if nil == PetSealData then
        return
      end
      if petNo == PetSealData._petNo then
        local petStaticStatus = PetSealData:getPetStaticStatus()
        local patName = PetSealData:getName()
        local petNum_s64 = PetSealData._petNo
        local petNum_S32 = Int64toInt32(petNum_s64)
        local petLevel = PetSealData._level
        local petLovely = PetSealData._lovely
        local petMaxLovely = 100
        local petLovelyPercent = petLovely / petMaxLovely * 100
        local petHungry = PetSealData._hungry
        local petMaxHungry = petStaticStatus._maxHungry
        local petHungryPercent = petHungry / petMaxHungry * 100
        local iconPath = PetSealData:getIconPath()
        local petTier = petStaticStatus:getPetTier() + 1
        petSkillType(PetSealData, 0)
        petSkillType(PetSealData, 1)
        local actionMaxCount = ToClient_getPetActionMax()
        local uiIdx = 0
        for action_idx = 0, actionMaxCount - 1 do
          self.actionSlot[action_idx]:SetShow(false)
          local actionStaticStatus = ToClient_getPetActionStaticStatus(action_idx)
          local isLearn = PetSealData:isPetActionLearned(action_idx)
          if true == isLearn then
            self.actionSlot[uiIdx]:SetShow(true)
            self.actionSlot[uiIdx]:ChangeTextureInfoName("Icon/" .. actionStaticStatus:getIconPath())
            self.actionSlot[uiIdx]:addInputEvent("Mouse_On", "_PetInfo_ShowActionToolTip( " .. action_idx .. ", " .. uiIdx .. " )")
            self.actionSlot[uiIdx]:addInputEvent("Mouse_Out", "_PetInfo_HideActionToolTip( " .. action_idx .. " )")
            uiIdx = uiIdx + 1
          end
        end
        local skillMaxCount = ToClient_getPetEquipSkillMax()
        PetInfo_SkillSlot_Show(true)
        for i = 0, 4 do
          self.skillSlot[i]:SetShow(false)
          self.skillSlot[i]:SetIgnore(true)
          self.skillSlot[i]:ChangeTextureInfoName("")
        end
        uiIdx = 0
        if 0 < uiIdx then
          Panel_Window_PetInfoNew:SetSize(Panel_Window_PetInfoNew:GetSizeX(), 410)
          self.petInfoBg:SetSize(self.petInfoBg:GetSizeX(), 349)
        else
          Panel_Window_PetInfoNew:SetSize(Panel_Window_PetInfoNew:GetSizeX(), 335)
          self.petInfoBg:SetSize(self.petInfoBg:GetSizeX(), 274)
          PetInfo_SkillSlot_Show(false)
        end
        if nil == self.currentPetLv[petNum_S32] then
          self.currentPetLv[petNum_S32] = petLevel
        end
        if self.currentPetLv[petNum_S32] ~= petLevel and self.currentPetLv[petNum_S32] ~= nil then
          if petLevel ~= 0 and petLevel ~= 1 and self.currentPetLv[petNum_S32] ~= 0 and self.currentPetLv[petNum_S32] ~= 1 then
            Proc_ShowMessage_Ack(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_PETINFO_PETLEVELUP_ACK", "patName", patName))
          end
          self.currentPetLv[petNum_S32] = petLevel
        end
        self.iconPet:ChangeTextureInfoName(iconPath)
        self.petName:SetText(patName .. " (" .. PAGetStringParam1(Defines.StringSheet_GAME, "LUA_SERVANT_TIER", "tier", petTier) .. ")")
        self.level_Title:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_LV") .. "." .. petLevel)
        self.progress_Hungry:SetProgressRate(petHungryPercent)
        self.progress_Lovely:SetProgressRate(petLovelyPercent)
        self.icon_Lovely:SetShow(false)
        self.bg_Lovely:SetShow(false)
        self.progress_Lovely:SetShow(false)
      end
    end
  else
    local petNo = self.PetNo
    local petCount = ToClient_getPetUnsealedList()
    if petCount == 0 then
      return
    end
    for index = 0, petCount - 1 do
      local PcPetData = ToClient_getPetUnsealedDataByIndex(index)
      if nil == PcPetData then
        return
      end
      if petNo == PcPetData:getPcPetNo() then
        local petStaticStatus = PcPetData:getPetStaticStatus()
        local patName = PcPetData:getName()
        local petNum_s64 = PcPetData:getPcPetNo()
        local petNum_S32 = Int64toInt32(petNum_s64)
        local petLevel = PcPetData:getLevel()
        local petExp_s64 = PcPetData:getExperience()
        local petExp_s32 = Int64toInt32(petExp_s64)
        local petMaxExp_s64 = PcPetData:getMaxExperience()
        local petMaxExp_s32 = Int64toInt32(petMaxExp_s64)
        local petExpPercent = petExp_s32 / petMaxExp_s32 * 100
        local petLovely = PcPetData:getLovely()
        local petMaxLovely = 100
        local petLovelyPercent = petLovely / petMaxLovely * 100
        local petHungry = PcPetData:getHungry()
        local petMaxHungry = petStaticStatus._maxHungry
        local petHungryPercent = petHungry / petMaxHungry * 100
        local iconPath = PcPetData:getIconPath()
        local petTier = petStaticStatus:getPetTier() + 1
        petSkillType(PcPetData, 0)
        petSkillType(PcPetData, 1)
        local actionMaxCount = ToClient_getPetActionMax()
        local uiIdx = 0
        for action_idx = 0, actionMaxCount - 1 do
          self.actionSlot[action_idx]:SetShow(false)
          local actionStaticStatus = ToClient_getPetActionStaticStatus(action_idx)
          local isLearn = PcPetData:isPetActionLearned(action_idx)
          if true == isLearn then
            self.actionSlot[uiIdx]:SetShow(true)
            self.actionSlot[uiIdx]:ChangeTextureInfoName("Icon/" .. actionStaticStatus:getIconPath())
            self.actionSlot[uiIdx]:addInputEvent("Mouse_On", "_PetInfo_ShowActionToolTip( " .. action_idx .. ", " .. uiIdx .. " )")
            self.actionSlot[uiIdx]:addInputEvent("Mouse_Out", "_PetInfo_HideActionToolTip( " .. action_idx .. " )")
            uiIdx = uiIdx + 1
          end
        end
        local skillMaxCount = ToClient_getPetEquipSkillMax()
        PetInfo_SkillSlot_Show(true)
        for i = 0, 4 do
          self.skillSlot[i]:SetShow(false)
          self.skillSlot[i]:SetIgnore(true)
          self.skillSlot[i]:ChangeTextureInfoName("")
        end
        uiIdx = 0
        local baseskillindex = PcPetData:getPetBaseSkillIndex()
        local skillStaticStatus = ToClient_getPetBaseSkillStaticStatus(baseskillindex)
        if nil ~= skillStaticStatus then
          local skillTypeStaticWrapper = skillStaticStatus:getSkillTypeStaticStatusWrapper()
          if nil ~= skillTypeStaticWrapper then
            local skillNo = skillStaticStatus:getSkillNo()
            self.skillSlot[uiIdx]:SetShow(true)
            self.skillSlot[uiIdx]:SetIgnore(false)
            self.skillSlot[uiIdx]:ChangeTextureInfoName("Icon/" .. skillTypeStaticWrapper:getIconPath())
            self.skillSlot[uiIdx]:addInputEvent("Mouse_On", "PetInfo_BaseSkill_ShowTooltip( " .. baseskillindex .. ", " .. uiIdx .. " )")
            self.skillSlot[uiIdx]:addInputEvent("Mouse_Out", "PetInfo_BaseSkill_HideTooltip()")
            Panel_SkillTooltip_SetPosition(skillNo, self.skillSlot[uiIdx], "PetSkill")
          end
        end
        uiIdx = uiIdx + 1
        for skill_idx = 0, skillMaxCount - 1 do
          local skillStaticStatus = ToClient_getPetEquipSkillStaticStatus(skill_idx)
          local isLearn = PcPetData:isPetEquipSkillLearned(skill_idx)
          if true == isLearn and nil ~= skillStaticStatus then
            local skillTypeStaticWrapper = skillStaticStatus:getSkillTypeStaticStatusWrapper()
            if nil ~= skillTypeStaticWrapper then
              local skillNo = skillStaticStatus:getSkillNo()
              self.skillSlot[uiIdx]:SetShow(true)
              self.skillSlot[uiIdx]:SetIgnore(false)
              self.skillSlot[uiIdx]:ChangeTextureInfoName("Icon/" .. skillTypeStaticWrapper:getIconPath())
              self.skillSlot[uiIdx]:addInputEvent("Mouse_On", "PetInfo_ShowSkillToolTip( " .. skill_idx .. ", " .. uiIdx .. " )")
              self.skillSlot[uiIdx]:addInputEvent("Mouse_Out", "PetInfo_HideSkillToolTip()")
              Panel_SkillTooltip_SetPosition(skillNo, self.skillSlot[uiIdx], "PetSkill")
            end
            uiIdx = uiIdx + 1
          end
        end
        if 0 < uiIdx then
          Panel_Window_PetInfoNew:SetSize(Panel_Window_PetInfoNew:GetSizeX(), 430)
          self.petInfoBg:SetSize(self.petInfoBg:GetSizeX(), 369)
        else
          Panel_Window_PetInfoNew:SetSize(Panel_Window_PetInfoNew:GetSizeX(), 355)
          self.petInfoBg:SetSize(self.petInfoBg:GetSizeX(), 294)
          PetInfo_SkillSlot_Show(false)
        end
        if nil == self.currentPetLv[petNum_S32] then
          self.currentPetLv[petNum_S32] = petLevel
        end
        if self.currentPetLv[petNum_S32] ~= petLevel and self.currentPetLv[petNum_S32] ~= nil then
          if petLevel ~= 0 and petLevel ~= 1 and self.currentPetLv[petNum_S32] ~= 0 and self.currentPetLv[petNum_S32] ~= 1 then
            Proc_ShowMessage_Ack(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_PETINFO_PETLEVELUP_ACK", "patName", patName))
          end
          self.currentPetLv[petNum_S32] = petLevel
        end
        self.iconPet:ChangeTextureInfoName(iconPath)
        self.petName:SetText(patName .. " (" .. PAGetStringParam1(Defines.StringSheet_GAME, "LUA_SERVANT_TIER", "tier", petTier) .. ")")
        self.progress_EXP:SetProgressRate(petExpPercent)
        self.level_Title:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_LV") .. "." .. petLevel)
        self.level_Value:SetText(string.format("%.1f", petExpPercent) .. "%")
        self.progress_Hungry:SetProgressRate(petHungryPercent)
        self.progress_Lovely:SetProgressRate(petLovelyPercent)
        self.icon_Lovely:SetShow(false)
        self.bg_Lovely:SetShow(false)
        self.progress_Lovely:SetShow(false)
      end
    end
  end
end
function PetInfo_SkillSlot_Show(isShow)
  local self = PetInfo
  self.skillBg:SetShow(false)
  for v, control in pairs(self.skillSlotBg) do
    control:SetShow(isShow)
  end
  for v, control in pairs(self.skillSlot) do
    control:SetShow(isShow)
  end
end
function PetInfo:SetPosition()
  local scrSizeX = getScreenSizeX()
  local scrSizeY = getScreenSizeY()
  local panelSizeX = Panel_Window_PetInfoNew:GetSizeX()
  local panelSizeY = Panel_Window_PetInfoNew:GetSizeY()
  Panel_Window_PetInfoNew:SetPosX(scrSizeX / 2 - panelSizeX / 2)
  Panel_Window_PetInfoNew:SetPosY(scrSizeY / 2 - panelSizeY / 2)
end
function _PetInfo_ShowActionToolTip(action_idx, uiIdx)
  local self = PetInfo
  local actionStaticStatus = ToClient_getPetActionStaticStatus(action_idx)
  if nil == actionStaticStatus then
    return
  end
  local actionIconPath = actionStaticStatus:getIconPath()
  local actionName = actionStaticStatus:getName()
  local actionDesc = actionStaticStatus:getDescription()
  local uiBase = self.actionSlot[uiIdx]
  if "" == actionDesc then
    actionDesc = nil
  end
  TooltipSimple_Show(uiBase, actionName, actionDesc)
end
function _PetInfo_HideActionToolTip(action_idx)
  TooltipSimple_Hide()
end
function PetInfo_BaseSkill_ShowTooltip(baseskillindex, uiIx)
  local skillStaticStatus = ToClient_getPetBaseSkillStaticStatus(baseskillindex)
  local skillTypeStaticWrapper = skillStaticStatus:getSkillTypeStaticStatusWrapper()
  local petSkillNo = skillStaticStatus:getSkillNo()
  local uiBase = PetInfo.skillSlot[uiIdx]
  Panel_SkillTooltip_Show(petSkillNo, false, "PetSkill")
end
function PetInfo_BaseSkill_HideTooltip()
  Panel_SkillTooltip_Hide()
end
function PetInfo_ShowSkillToolTip(skill_idx, uiIdx)
  local skillStaticStatus = ToClient_getPetEquipSkillStaticStatus(skill_idx)
  local skillTypeStaticWrapper = skillStaticStatus:getSkillTypeStaticStatusWrapper()
  local petSkillNo = skillStaticStatus:getSkillNo()
  local uiBase = PetInfo.skillSlot[uiIdx]
  Panel_SkillTooltip_Show(petSkillNo, false, "PetSkill")
end
function PetInfo_HideSkillToolTip()
  Panel_SkillTooltip_Hide()
end
function FGlobal_PetInfoNew_Open(petNo, isShow, isSealed)
  local self = PetInfo
  local petNo_s32 = petNo
  self.PetNo = petNo_s32
  petIcon = isShow
  self:SetPosition()
  self:Update(isSealed)
  Panel_Window_PetInfoNew:SetShow(true)
end
function FGlobal_PetInfoNew_Close()
  Panel_Window_PetInfoNew:SetShow(false)
  local actionMaxCount = ToClient_getPetActionMax()
  for ii = 0, actionMaxCount - 1 do
    _PA_LOG("\236\155\144\236\132\160", "ii = =" .. ii)
    _PetInfo_HideActionToolTip(ii)
  end
  PetInfo_HideSkillToolTip()
  PetInfo_BaseSkill_HideTooltip()
  if true ~= petIcon then
    FGlobal_PetListNew_Open()
    petIcon = false
  end
end
function PetInfo_Update()
  PetInfo:Update()
end
function PetInfo:registEventHandler()
  self.BTN_Close:addInputEvent("Mouse_LUp", "FGlobal_PetInfoNew_Close()")
  registerEvent("FromClient_PetInfoChanged", "PetInfo_Update")
end
PetInfo:registEventHandler()
