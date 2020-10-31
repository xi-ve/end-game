function PaGlobal_ServantSwiftTraining_All:initialize()
  if nil == Panel_Dialog_ServantSwiftTraining_All or true == self.initialize then
    return
  end
  self._ui._txt_Title = UI.getChildControl(Panel_Dialog_ServantSwiftTraining_All, "StaticText_Title")
  self._ui._btn_Close_PC = UI.getChildControl(Panel_Dialog_ServantSwiftTraining_All, "Button_Close")
  self._ui._stc_Bg = UI.getChildControl(Panel_Dialog_ServantSwiftTraining_All, "Static_Bg")
  self._ui._stc_MainBg = UI.getChildControl(Panel_Dialog_ServantSwiftTraining_All, "Static_MainBg")
  self._ui._txt_TopDesc = UI.getChildControl(self._ui._stc_MainBg, "StaticText_TopDesc")
  self._ui._txt_Stack = UI.getChildControl(self._ui._stc_MainBg, "StaticText_Stack")
  self._ui._btn_Train = UI.getChildControl(self._ui._stc_MainBg, "Button_Train")
  self._ui._stc_SkillBg = UI.getChildControl(self._ui._stc_MainBg, "Static_SkillBg")
  self._ui._stc_EleganceBg = UI.getChildControl(self._ui._stc_MainBg, "Static_EleganceBg")
  self._ui._stc_StaminaBg = UI.getChildControl(self._ui._stc_MainBg, "Static_StaminaBg")
  self._ui._stc_CrogdaloSlot = UI.getChildControl(self._ui._stc_MainBg, "Static_CrogdaloSlot")
  self._ui._txt_CrogdaloCount = UI.getChildControl(self._ui._stc_MainBg, "StaticText_CrogdaloCount")
  self._ui._icon_Skill = UI.getChildControl(self._ui._stc_MainBg, "Static_SkillIcon")
  self._ui._stc_ProgressBg_Skill = UI.getChildControl(self._ui._stc_MainBg, "Static_ProgressBg_Skill")
  self._ui._prog2_Skill = UI.getChildControl(self._ui._stc_MainBg, "CircularProgress_Skill")
  self._ui._prog2_Skill_Head = UI.getChildControl(self._ui._prog2_Skill, "Progress2_1_Bar_Head")
  self._ui._stc_Skill_Material = UI.getChildControl(self._ui._stc_MainBg, "Static_SkillMaterial")
  self._ui._txt_Skill_Percent = UI.getChildControl(self._ui._stc_MainBg, "StaticText_SkillPercent")
  self._ui._txt_Skill_Title = UI.getChildControl(self._ui._stc_MainBg, "StaticText_SkillTitle")
  self._ui._icon_Elegance = UI.getChildControl(self._ui._stc_MainBg, "Static_EleganceIcon")
  self._ui._stc_ProgressBg_Elegance = UI.getChildControl(self._ui._stc_MainBg, "Static_ProgressBg_Elegance")
  self._ui._prog2_Elegance = UI.getChildControl(self._ui._stc_MainBg, "CircularProgress_Elegance")
  self._ui._prog2_Elegance_Head = UI.getChildControl(self._ui._prog2_Elegance, "Progress2_1_Bar_Head")
  self._ui._stc_Elegance_Material = UI.getChildControl(self._ui._stc_MainBg, "Static_EleganceMaterial")
  self._ui._txt_Elegance_Percent = UI.getChildControl(self._ui._stc_MainBg, "StaticText_ElegancePercent")
  self._ui._txt_Elegance_Title = UI.getChildControl(self._ui._stc_MainBg, "StaticText_EleganceTitle")
  self._ui._icon_Stamina = UI.getChildControl(self._ui._stc_MainBg, "Static_StaminaIcon")
  self._ui._stc_ProgressBg_Stamina = UI.getChildControl(self._ui._stc_MainBg, "Static_ProgressBg_Stamina")
  self._ui._prog2_Stamina = UI.getChildControl(self._ui._stc_MainBg, "CircularProgress_Stamina")
  self._ui._prog2_Stamina_Head = UI.getChildControl(self._ui._prog2_Stamina, "Progress2_1_Bar_Head")
  self._ui._stc_Stamina_Material = UI.getChildControl(self._ui._stc_MainBg, "Static_StaminaMaterial")
  self._ui._txt_Stamina_Percent = UI.getChildControl(self._ui._stc_MainBg, "StaticText_StaminaPercent")
  self._ui._txt_Stamina_Title = UI.getChildControl(self._ui._stc_MainBg, "StaticText_StaminaTitle")
  self._ui._btn_Guide_Pc = UI.getChildControl(self._ui._stc_MainBg, "Button_Guide_PCUI")
  self._ui._icon_Guide = UI.getChildControl(self._ui._btn_Guide_Pc, "Static_Icon")
  self._ui._txt_TotalPercent = UI.getChildControl(self._ui._stc_MainBg, "StaticText_TotalPercent")
  self._ui._stc_ButtonBg = UI.getChildControl(Panel_Dialog_ServantSwiftTraining_All, "Static_ButtonBg")
  self._ui._btn_Check_Cron = UI.getChildControl(self._ui._stc_ButtonBg, "CheckButton_Cron")
  self._ui._txt_Count_Cron = UI.getChildControl(self._ui._stc_ButtonBg, "StaticText_Count")
  self._ui._btn_Try_Swift = UI.getChildControl(self._ui._stc_ButtonBg, "Button_Try")
  self._ui._list_NeedItemList = UI.getChildControl(Panel_Dialog_ServantSwiftTraining_All, "List2_Skill")
  self._ui._stc_toolTipControl = UI.getChildControl(Panel_Dialog_ServantSwiftTraining_All, "Static_MaterialToolTip")
  self._originToolTipControlSizeY = self._ui._list_NeedItemList:GetSizeY() + self.SLOTBGSIZEY
  self._ui._stc_CronTooltipBg = UI.getChildControl(Panel_Dialog_ServantSwiftTraining_All, "Static_CronTooltipBg")
  self._ui._txt_CronTooltip = UI.getChildControl(self._ui._stc_CronTooltipBg, "StaticText_Desc")
  self._ui._stc_DescTooltipBg = UI.getChildControl(Panel_Dialog_ServantSwiftTraining_All, "Static_DescTooltipBg")
  self._ui._txt_DescTooltip = UI.getChildControl(self._ui._stc_DescTooltipBg, "StaticText_Desc")
  self._ui._stc_Console_KeyGuides = UI.getChildControl(Panel_Dialog_ServantSwiftTraining_All, "Static_BottomBg_ConsoleUI")
  self._ui._stc_KeyGuide_A = UI.getChildControl(self._ui._stc_Console_KeyGuides, "StaticText_A_ConsoleUI")
  self._ui._stc_KeyGuide_B = UI.getChildControl(self._ui._stc_Console_KeyGuides, "StaticText_B_ConsoleUI")
  self._ui._stc_KeyGuide_X = UI.getChildControl(self._ui._stc_Console_KeyGuides, "StaticText_X_ConsoleUI")
  self._ui._stc_KeyGuide_Y = UI.getChildControl(self._ui._stc_Console_KeyGuides, "StaticText_Y_ConsoleUI")
  self._ui._txt_TopDesc:SetTextMode(__eTextMode_AutoWrap)
  self._ui._txt_TopDesc:SetText(self._ui._txt_TopDesc:GetText())
  for i = 0, self._slotCount - 1 do
    self.slotConfig.createBorder = false
    local trainingUI = {
      _skillIcon = nil,
      _skillProg2 = nil,
      _skillMaterial = nil,
      _materialIconSlot = {},
      _skillBg = nil,
      _skillPercent = nil,
      _currentItemSlotNo = nil,
      _currentItemCount = nil,
      _currentItemWrapper = nil,
      _isExpUp = false,
      _skillExpCount = nil
    }
    if 0 == i then
      trainingUI._skillIcon = self._ui._icon_Skill
      trainingUI._skillProg2 = self._ui._prog2_Skill
      trainingUI._skillMaterial = self._ui._stc_Skill_Material
      trainingUI._skillPercent = self._ui._txt_Skill_Percent
      trainingUI._skillBg = self._ui._stc_SkillBg
      SlotItem.new(trainingUI._materialIconSlot, "Static_SkillMaterialIcon", i, self._ui._stc_Skill_Material, self.slotConfig)
      trainingUI._materialIconSlot:createChild()
      trainingUI._materialIconSlot.icon:addInputEvent("Mouse_LUp", "HandleEventLUp_ServantSwiftTraining_All_ItemClear(0)")
    elseif 1 == i then
      trainingUI._skillIcon = self._ui._icon_Elegance
      trainingUI._skillProg2 = self._ui._prog2_Elegance
      trainingUI._skillMaterial = self._ui._stc_Elegance_Material
      trainingUI._skillPercent = self._ui._txt_Elegance_Percent
      trainingUI._skillBg = self._ui._stc_EleganceBg
      SlotItem.new(trainingUI._materialIconSlot, "Static_EleganceMaterialIcon", i, self._ui._stc_Elegance_Material, self.slotConfig)
      trainingUI._materialIconSlot:createChild()
      trainingUI._materialIconSlot.icon:addInputEvent("Mouse_LUp", "HandleEventLUp_ServantSwiftTraining_All_ItemClear(1)")
    else
      trainingUI._skillIcon = self._ui._icon_Stamina
      trainingUI._skillProg2 = self._ui._prog2_Stamina
      trainingUI._skillMaterial = self._ui._stc_Stamina_Material
      trainingUI._skillPercent = self._ui._txt_Stamina_Percent
      trainingUI._skillBg = self._ui._stc_StaminaBg
      SlotItem.new(trainingUI._materialIconSlot, "Static_StaminaMaterialIcon", i, self._ui._stc_Stamina_Material, self.slotConfig)
      trainingUI._materialIconSlot:createChild()
      trainingUI._materialIconSlot.icon:addInputEvent("Mouse_LUp", "HandleEventLUp_ServantSwiftTraining_All_ItemClear(2)")
    end
    self._trainingSlot[i] = trainingUI
  end
  self.slotConfig.createBorder = true
  local index = 0
  for materialIdx = 0, self._slotCount - 1 do
    local skillWrapper = stable_getStallionTrainingSkillListAt(materialIdx)
    if nil ~= skillWrapper then
      local itemCount = stable_getStallionSkillItemListCount(skillWrapper:getKey())
      for i = 0, itemCount - 1 do
        local material = {
          iconSlot = {},
          itemName = nil,
          itemSlotNo = nil,
          itemCategory = nil,
          itemCount = nil
        }
        self._materialItemSlot[index] = material
        index = index + 1
      end
    end
  end
  self._isConsole = _ContentsGroup_UsePadSnapping
  PaGlobal_ServantSwiftTraining_All:validate()
  PaGlobal_ServantSwiftTraining_All:switchPlatform(self._isConsole)
  PaGlobal_ServantSwiftTraining_All:registerEventHandler(self._isConsole)
end
function PaGlobal_ServantSwiftTraining_All:registerEventHandler(isConsole)
  if nil == Panel_Dialog_ServantSwiftTraining_All or false == self._initialize then
    return
  end
  registerEvent("FromClient_IncreaseStallionSkillExpAck", "FromClient_ServantSwiftTraining_All_IncreaseStallionSkillExpAck")
  registerEvent("FromClient_CompleteStallionTrainingAck", "FromClient_ServantSwiftTraining_All_CompleteStallionTrainingAck")
  self._ui._list_NeedItemList:registEvent(__ePAUIList2EventType_LuaChangeContent, "PaGlobalFunc_ServantSwiftTraining_All_listCreate")
  self._ui._list_NeedItemList:createChildContent(__ePAUIList2ElementManagerType_List)
  if false == isConsole then
    self._ui._btn_Guide_Pc:addInputEvent("Mouse_LUp", "HandleEventLUp_ServantSwiftTraining_All_ShowGuide()")
    self._ui._btn_Close_PC:addInputEvent("Mouse_LUp", "PaGlobalFunc_ServantSwiftTraining_All_Close()")
    self._ui._btn_Try_Swift:addInputEvent("Mouse_LUp", "HandleEventLUp_ServantSwiftTraining_All_TrySwift()")
    self._ui._btn_Train:addInputEvent("Mouse_LUp", "HandleEventLUp_ServantSwiftTraining_All_Training()")
    self._ui._stc_toolTipControl:addInputEvent("Mouse_On", "")
    self._ui._stc_toolTipControl:addInputEvent("Mouse_Out", "HandleEventOut_ServantSwiftTraining_All_HideMaterialToolTip()")
  else
    self._ui._btn_Try_Swift:registerPadEvent(__eConsoleUIPadEvent_Up_A, "HandleEventLUp_ServantSwiftTraining_All_TrySwift()")
    self._ui._btn_Train:registerPadEvent(__eConsoleUIPadEvent_A, "HandleEventLUp_ServantSwiftTraining_All_Training()")
    Panel_Dialog_ServantSwiftTraining_All:registerPadEvent(__eConsoleUIPadEvent_Y, "HandleEventLUp_ServantSwiftTraining_All_ShowGuide()")
  end
end
function PaGlobal_ServantSwiftTraining_All:switchPlatform(isConsole)
  if nil == Panel_Dialog_ServantSwiftTraining_All or false == self._initialize then
    return
  end
  self._ORIGIN_SWIFTGUIDEBG_SIZEY = self._ui._stc_CronTooltipBg:GetSizeY()
  self._ORIGIN_CRONGUIDEBG_SIZEY = self._ui._stc_DescTooltipBg:GetSizeY()
  self._ui._txt_DescTooltip:SetTextMode(__eTextMode_AutoWrap)
  self._ui._txt_DescTooltip:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_STABLESTALLION_TEXT_NOTIFY"))
  self._ui._txt_CronTooltip:SetTextMode(__eTextMode_AutoWrap)
  self._ui._txt_CronTooltip:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_STABLESTALLION_TEXT_PROTECTITEMNOTIFY"))
  self._ui._btn_Guide_Pc:SetShow(not isConsole)
  self._ui._btn_Close_PC:SetShow(not isConsole)
  self._ui._stc_Console_KeyGuides:SetShow(isConsole)
  if true == isConsole then
    local keyGuides = {
      self._ui._stc_KeyGuide_A,
      self._ui._stc_KeyGuide_B,
      self._ui._stc_KeyGuide_X,
      self._ui._stc_KeyGuide_Y
    }
    PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyGuides, self._ui._stc_Console_KeyGuides, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP)
  end
end
function PaGlobal_ServantSwiftTraining_All:prepareOpen()
  if nil == Panel_Dialog_ServantSwiftTraining_All or true == Panel_Dialog_ServantSwiftTraining_All:GetShow() then
    return
  end
  PaGlobalFunc_ServantFunction_All_TempOnOff(false)
  PaGlobal_ServantSwiftTraining_All:dataClear()
  self._ui._stc_CronTooltipBg:SetShow(false)
  self._ui._stc_DescTooltipBg:SetShow(false)
  self._ui._btn_Train:SetIgnore(true, true)
  self._ui._btn_Train:SetMonoTone(true, true)
  Panel_Dialog_ServantList_All:ClearUpdateLuaFunc()
  local skillCount = stable_getStallionTrainingSkillCount()
  if false == self._isSkillIconSet then
    for i = 0, skillCount - 1 do
      local skillWrapper = stable_getStallionTrainingSkillListAt(i)
      if nil ~= skillWrapper then
        self._trainingSlot[i]._skillIcon:ChangeTextureInfoName("Icon/" .. skillWrapper:getIconPath())
      end
    end
    local itemSSW = stable_getStallionTrainingCompleteRequiredItem()
    if nil ~= itemSSW then
      self._ui._stc_CrogdaloSlot:ChangeTextureInfoName("Icon/" .. itemSSW:getIconPath())
    end
    self._isSkillIconSet = true
  end
  PaGlobalFunc_ServantNameRegist_All_SetIgnoreBtn(true)
  PaGlobal_ServantSwiftTraining_All:open()
  PaGlobalFunc_ServantSwiftTraining_All_OnScreenResize()
  PaGlobal_ServantSwiftTraining_All:update()
end
function PaGlobal_ServantSwiftTraining_All:open()
  if nil == Panel_Dialog_ServantSwiftTraining_All or true == Panel_Dialog_ServantSwiftTraining_All:GetShow() then
    return
  end
  Panel_Dialog_ServantSwiftTraining_All:SetShow(true)
end
function PaGlobal_ServantSwiftTraining_All:update()
  if nil == Panel_Dialog_ServantSwiftTraining_All or false == Panel_Dialog_ServantSwiftTraining_All:GetShow() then
    return
  end
  local servantInfo = stable_getServantByServantNo(self._currentServentNo)
  if nil == servantInfo then
    return
  end
  local name = servantInfo:getName()
  local skillCount = servantInfo:getSkillCount()
  local awakenExp = 0
  local awakenMaxExp = stable_getStallionTrainingCompleteRequiredExperience()
  local statckCount = servantInfo:getServantAwakenStack()
  local highestExp = 0
  local highestIndex
  for i = 0, self._slotCount - 1 do
    local satllionSkillWrapper = stable_getStallionTrainingSkillListAt(i)
    local stallionSkillWrapperKey = satllionSkillWrapper:getKey()
    for ii = 1, skillCount - 1 do
      local skillWrapper = servantInfo:getSkill(ii)
      if nil ~= skillWrapper then
        local skillname = skillWrapper:getName()
        local skillKey = skillWrapper:getKey()
        if stallionSkillWrapperKey == skillKey then
          self._trainingSlot[i]._skillExpCount = servantInfo:getSkillExp(ii) / (skillWrapper:getMaxExp() / 100)
          if 0 ~= self._trainingSlot[i]._skillExpCount then
            self._trainingSlot[i]._isExpUp = true
            if highestExp <= self._trainingSlot[i]._skillExpCount and nil == self._currentSkillBg then
              highestExp = self._trainingSlot[i]._skillExpCount
              highestIndex = i
            end
          else
            self._trainingSlot[i]._isExpUp = false
          end
          local floorValueString = PaGlobal_ServantSwiftTraining_All:getfloorValueString(self._trainingSlot[i]._skillExpCount)
          self._trainingSlot[i]._skillPercent:SetText(floorValueString .. "%")
          self._trainingSlot[i]._skillProg2:SetSmoothMode(true)
          self._trainingSlot[i]._skillProg2:SetAniSpeed(3)
          self._trainingSlot[i]._skillProg2:SetProgressRate(self._trainingSlot[i]._skillExpCount / 1.8)
          awakenExp = awakenExp + servantInfo:getSkillExp(ii)
        end
      end
    end
  end
  if nil ~= highestIndex then
    self._currentSkillBg = highestIndex
  end
  self._awakenExpCount = awakenExp / (awakenMaxExp / 100)
  if 100 < self._awakenExpCount then
    self._awakenExpCount = 100
  end
  local successRate = string.format("%0.1f", statckCount * 0.2 + 1)
  self._ui._txt_Stack:SetText(PAGetStringParam2(Defines.StringSheet_GAME, "LUA_SERVANT_SWIFTTRAINING_RATE", "count", tostring(statckCount), "rate", tostring(successRate)))
  self._ui._txt_TotalPercent:SetText(self:getfloorValueString(self._awakenExpCount * 2) .. "%")
  PaGlobal_ServantSwiftTraining_All:updateCronStone()
  PaGlobal_ServantSwiftTraining_All:updateCrogdaloItem()
  PaGlobal_ServantSwiftTraining_All:updateMaterials()
  PaGlobal_ServantSwiftTraining_All:setScroll()
end
function PaGlobal_ServantSwiftTraining_All:updateCronStone()
  if nil == Panel_Dialog_ServantSwiftTraining_All or false == Panel_Dialog_ServantSwiftTraining_All:GetShow() then
    return
  end
  local itemSSW = stable_getPreventStallionTrainingSkillExpItem()
  if nil ~= itemSSW then
    local needCount = toInt64(0, 0)
    local haveCount = toInt64(0, 0)
    needCount = toInt64(0, stable_getPreventStallionTrainingSkillExpDownItemCount())
    self._cronStoneInfo._cronStoneSlotNo, haveCount = PaGlobal_ServantSwiftTraining_All:update_Cron_Crogdalo_Count(true)
    self._ui._btn_Check_Cron:SetIgnore(true)
    self._ui._btn_Check_Cron:SetMonoTone(true, true)
    if needCount > haveCount then
      haveCount = "<PAColor0xFFD05D48>" .. tostring(haveCount) .. "<PAOldColor>"
      self._ui._btn_Check_Cron:SetIgnore(true)
      self._ui._btn_Check_Cron:SetMonoTone(true, true)
      self._cronStoneInfo._isEnableCronStone = false
    else
      haveCount = "<PAColor0xFFF5BA3A>" .. tostring(haveCount) .. "<PAOldColor>"
      self._ui._btn_Check_Cron:SetIgnore(false)
      self._ui._btn_Check_Cron:SetMonoTone(false, false)
      self._cronStoneInfo._isEnableCronStone = true
    end
    self._cronStoneInfo._cronStoneCount = haveCount
    self._ui._txt_Count_Cron:SetText(tostring(haveCount) .. "/" .. tostring(needCount))
    if false == self._isConsole then
      self._ui._btn_Check_Cron:addInputEvent("Mouse_On", "HandleEventOnOut_ServantSwiftTraining_All_AwakenItemToolTip( true, true )")
    else
      self._ui._btn_Check_Cron:registerPadEvent(__eConsoleUIPadEvent_X, "HandleEventOnOut_ServantSwiftTraining_All_AwakenItemToolTip( true, true )")
    end
    self._ui._btn_Check_Cron:addInputEvent("Mouse_Out", "HandleEventOnOut_ServantSwiftTraining_All_AwakenItemToolTip( false )")
  end
end
function PaGlobal_ServantSwiftTraining_All:updateCrogdaloItem()
  if nil == Panel_Dialog_ServantSwiftTraining_All or false == Panel_Dialog_ServantSwiftTraining_All:GetShow() then
    return
  end
  local itemSSW = stable_getStallionTrainingCompleteRequiredItem()
  if nil ~= itemSSW then
    local needCount = toInt64(0, 1)
    local haveCount = toInt64(0, 0)
    self._crogdaloInfo._crogdaloSlotNo, haveCount = PaGlobal_ServantSwiftTraining_All:update_Cron_Crogdalo_Count(false)
    if needCount > haveCount then
      haveCount = "<PAColor0xFFD05D48>" .. tostring(haveCount) .. "<PAOldColor>"
      self._ui._stc_CrogdaloSlot:SetMonoTone(true, true)
      self._crogdaloInfo._isEnableCrogdalo = false
      self._ui._btn_Try_Swift:SetIgnore(true)
      self._ui._btn_Try_Swift:SetMonoTone(true, true)
    else
      haveCount = "<PAColor0xFFF5BA3A>" .. tostring(haveCount) .. "<PAOldColor>"
      self._ui._stc_CrogdaloSlot:SetMonoTone(false, false)
      self._crogdaloInfo._isEnableCrogdalo = true
      self._ui._btn_Try_Swift:SetIgnore(false)
      self._ui._btn_Try_Swift:SetMonoTone(false, false)
    end
    self._crogdaloInfo._crogdaloCount = haveCount
    self._ui._txt_CrogdaloCount:SetText(tostring(haveCount) .. "/" .. tostring(needCount))
    if false == self._isConsole then
      self._ui._stc_CrogdaloSlot:addInputEvent("Mouse_On", "HandleEventOnOut_ServantSwiftTraining_All_AwakenItemToolTip( true, false )")
    else
      self._ui._stc_CrogdaloSlot:registerPadEvent(__eConsoleUIPadEvent_X, "HandleEventOnOut_ServantSwiftTraining_All_AwakenItemToolTip( true, false )")
    end
    self._ui._stc_CrogdaloSlot:addInputEvent("Mouse_Out", "HandleEventOnOut_ServantSwiftTraining_All_AwakenItemToolTip( false )")
  end
end
function PaGlobal_ServantSwiftTraining_All:updateMaterials()
  if nil == Panel_Dialog_ServantSwiftTraining_All or false == Panel_Dialog_ServantSwiftTraining_All:GetShow() then
    return
  end
  self._ui._list_NeedItemList:getElementManager():clearKey()
  local listSize = Int64toInt32(self._ui._list_NeedItemList:getElementManager():getSize())
  local uiCount = 0
  for materialIdx = 0, self._slotCount - 1 do
    local skillWrapper = stable_getStallionTrainingSkillListAt(materialIdx)
    if nil ~= skillWrapper then
      local skillKey = skillWrapper:getKey()
      local itemCount = stable_getStallionSkillItemListCount(skillKey)
      local itemSSW
      for index = 0, itemCount - 1 do
        itemSSW = stable_getStallionSkillItemListAt(skillKey, index)
        if nil ~= itemSSW then
          local itemName = itemSSW:getName()
          local invenSlotIdx, count, itemWrapper = PaGlobal_ServantSwiftTraining_All:findInventoryItemByName(itemName)
          if nil ~= invenSlotIdx and nil ~= count and nil ~= itemWrapper then
            self._materialItemSlot[uiCount].itemName = itemName
            self._materialItemSlot[uiCount].itemCount = count
            self._materialItemSlot[uiCount].itemSlotNo = invenSlotIdx
            self._materialItemSlot[uiCount].itemCategory = materialIdx
            self._materialItemSlot[uiCount].itemIndex = index
          else
            self._materialItemSlot[uiCount].itemName = itemName
            self._materialItemSlot[uiCount].itemCount = toInt64(0, 0)
            self._materialItemSlot[uiCount].itemCategory = materialIdx
            self._materialItemSlot[uiCount].itemIndex = index
          end
          self._ui._list_NeedItemList:getElementManager():pushKey(toInt64(0, uiCount))
          self._ui._list_NeedItemList:requestUpdateByKey(toInt64(0, uiCount))
          uiCount = uiCount + 1
        end
      end
    end
  end
  local padding = 15
  local toolTipControlSizeY = (self.SLOTBGSIZEY + padding) * uiCount
  if toolTipControlSizeY > self._originToolTipControlSizeY then
    toolTipControlSizeY = self._originToolTipControlSizeY
  end
  self._ui._stc_toolTipControl:SetSize(self._ui._stc_toolTipControl:GetSizeX(), toolTipControlSizeY)
  self._ui._stc_toolTipControl:ComputePos()
  self._itemTotalCount = uiCount
end
function PaGlobal_ServantSwiftTraining_All:listCreate(control, key)
  local key32 = Int64toInt32(key)
  local materialItemSlot
  local stc_SlotBG = UI.getChildControl(control, "Static_MaterialBg")
  local stc_ItemIcon = UI.getChildControl(stc_SlotBG, "Static_ItemIcon")
  local txt_ItemName = UI.getChildControl(stc_SlotBG, "StaticText_ItemName")
  materialItemSlot = self._materialItemSlot[key32]
  if nil == materialItemSlot then
    return
  end
  local itemSlot
  if nil == self._itemSlotList[key32] then
    itemSlot = {}
    SlotItem.new(itemSlot, "Material_Skill_ItemSlot_" .. key32, key32, stc_ItemIcon, self.slotConfig)
    itemSlot:createChild()
    self._itemSlotList[key32] = itemSlot
  end
  itemSlot = self._itemSlotList[key32]
  itemSlot:clearItem()
  stc_SlotBG:SetShow(true)
  stc_SlotBG:SetMonoTone(false, false)
  stc_SlotBG:SetEnable(true)
  stc_SlotBG:SetIgnore(false)
  if toInt64(0, 0) < materialItemSlot.itemCount then
    local invenSlotIdx, count, itemWrapper = PaGlobal_ServantSwiftTraining_All:findInventoryItemByName(materialItemSlot.itemName)
    itemSlot:setItem(itemWrapper, invenSlotIdx)
    if false == self._isConsole then
      stc_SlotBG:addInputEvent("Mouse_LUp", "HandleEventLUp_ServantSwiftTraining_All_ItemSet_NumPadOn(" .. materialItemSlot.itemCategory .. ", " .. materialItemSlot.itemSlotNo .. ")")
      itemSlot.icon:addInputEvent("Mouse_On", "HandleEventOnOut_ServantSwiftTraining_All_MaterialToolTip(3, " .. key32 .. ", " .. materialItemSlot.itemSlotNo .. ")")
    else
      stc_SlotBG:registerPadEvent(__eConsoleUIPadEvent_A, "HandleEventLUp_ServantSwiftTraining_All_ItemSet_NumPadOn(" .. materialItemSlot.itemCategory .. ", " .. materialItemSlot.itemSlotNo .. ")")
      stc_SlotBG:registerPadEvent(__eConsoleUIPadEvent_X, "HandleEventOnOut_ServantSwiftTraining_All_MaterialToolTip(3, " .. key32 .. ", " .. materialItemSlot.itemSlotNo .. ")")
    end
  else
    local skillWrapper = stable_getStallionTrainingSkillListAt(materialItemSlot.itemCategory)
    if nil == skillWrapper then
      return
    end
    local skillKey = skillWrapper:getKey()
    local index = materialItemSlot.itemIndex
    local itemWrapper = stable_getStallionSkillItemListAt(skillKey, index)
    itemSlot:setItemByStaticStatus(itemWrapper, toInt64(0, 0))
    stc_SlotBG:SetMonoTone(true, true)
    if false == self._isConsole then
      stc_SlotBG:addInputEvent("Mouse_On", "HandleEventOnOut_ServantSwiftTraining_All_MaterialToolTip(3, " .. key32 .. ", " .. materialItemSlot.itemIndex .. ", " .. materialItemSlot.itemCategory .. ")")
      itemSlot.icon:addInputEvent("Mouse_On", "HandleEventOnOut_ServantSwiftTraining_All_MaterialToolTip(3, " .. key32 .. ", " .. materialItemSlot.itemIndex .. ", " .. materialItemSlot.itemCategory .. ")")
    else
      stc_SlotBG:registerPadEvent(__eConsoleUIPadEvent_X, "HandleEventOnOut_ServantSwiftTraining_All_MaterialToolTip(3, " .. key32 .. ", " .. materialItemSlot.itemIndex .. ", " .. materialItemSlot.itemCategory .. ")")
    end
  end
  local nameStr = materialItemSlot.itemName
  if 0 == materialItemSlot.itemCategory then
    nameStr = "(" .. PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SWIFTTRAIN_SKILL") .. ") " .. nameStr
  elseif 1 == materialItemSlot.itemCategory then
    nameStr = "(" .. PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SWIFTTRAIN_ELEGANCE") .. ") " .. nameStr
  elseif 2 == materialItemSlot.itemCategory then
    nameStr = "(" .. PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SWIFTTRAIN_STAMINA") .. ") " .. nameStr
  end
  txt_ItemName:SetText(nameStr)
  if txt_ItemName:GetSizeX() < txt_ItemName:GetTextSizeX() then
    txt_ItemName:SetTextMode(__eTextMode_AutoWrap)
    txt_ItemName:SetText(nameStr)
  end
end
function PaGlobal_ServantSwiftTraining_All:setScroll(isSelected)
  local toIndex = 0
  local scrollvalue = 0
  toIndex = self._ui._list_NeedItemList:getCurrenttoIndex()
  if isSelected then
    toIndex = math.floor(toIndex)
  end
  if false == self._ui._list_NeedItemList:IsIgnoreVerticalScroll() then
    scrollvalue = self._ui._list_NeedItemList:GetVScroll():GetControlPos()
  end
  self._ui._list_NeedItemList:getElementManager():clearKey()
  for itemIdx = 0, self._itemTotalCount - 1 do
    self._ui._list_NeedItemList:getElementManager():pushKey(toInt64(0, itemIdx))
  end
  self._ui._list_NeedItemList:setCurrenttoIndex(toIndex)
  if false == self._ui._list_NeedItemList:IsIgnoreVerticalScroll() then
    self._ui._list_NeedItemList:GetVScroll():SetControlPos(scrollvalue)
  end
end
function PaGlobal_ServantSwiftTraining_All:findInventoryItemByName(name)
  if nil == Panel_Dialog_ServantSwiftTraining_All or false == Panel_Dialog_ServantSwiftTraining_All:GetShow() then
    return
  end
  local whereType = CppEnums.ItemWhereType.eInventory
  local inventory = getSelfPlayer():get():getInventory(whereType)
  if nil == inventory then
    return
  end
  local invenMaxSize = inventory:sizeXXX()
  for slotIdx = 0, invenMaxSize - 1 do
    local itemWrapper = getInventoryItemByType(whereType, slotIdx)
    if nil ~= itemWrapper then
      local invenItemSSW = itemWrapper:getStaticStatus()
      if nil ~= invenItemSSW then
        local invenItemName = invenItemSSW:getName()
        local isItemLock = ToClient_Inventory_CheckItemLock(slotIdx, whereType)
        if invenItemName == name and false == isItemLock then
          local count = itemWrapper:getCount()
          return slotIdx, count, itemWrapper
        end
      end
    end
  end
end
function PaGlobal_ServantSwiftTraining_All:update_Cron_Crogdalo_Count(isCron)
  if nil == Panel_Dialog_ServantSwiftTraining_All or false == Panel_Dialog_ServantSwiftTraining_All:GetShow() then
    return
  end
  local selfPlayerWrapper = getSelfPlayer()
  local selfPlayer = selfPlayerWrapper:get()
  local useStartSlot = inventorySlotNoUserStart()
  local normalInventory = selfPlayer:getInventoryByType(CppEnums.ItemWhereType.eInventory)
  local invenUseSize = selfPlayer:getInventorySlotCount(false)
  if true == isCron then
    local protectItemSSW = stable_getPreventStallionTrainingSkillExpItem()
    if nil ~= protectItemSSW then
      local protectItemName = protectItemSSW:getName()
      local protectItemSlotNo
      local protectItemCounts = 0
      for idx = useStartSlot, invenUseSize - 1 do
        local itemWrapper = getInventoryItemByType(CppEnums.ItemWhereType.eInventory, idx)
        if nil ~= itemWrapper then
          local itemSSW = itemWrapper:getStaticStatus()
          local itemName = itemSSW:getName()
          if protectItemName == itemName then
            protectItemSlotNo = idx
            protectItemCounts = getInventoryItemByType(CppEnums.ItemWhereType.eInventory, idx):get():getCount_s64()
            break
          end
        end
      end
      if nil ~= protectItemSlotNo then
        return protectItemSlotNo, protectItemCounts
      else
        return protectItemSlotNo, toInt64(0, 0)
      end
    end
  else
    local awakenItemSSW = stable_getStallionTrainingCompleteRequiredItem()
    if nil ~= awakenItemSSW then
      local awakenItemName = awakenItemSSW:getName()
      local awakenItemSlotNo
      local awakenItemCounts = 0
      for idx = useStartSlot, invenUseSize - 1 do
        local itemWrapper = getInventoryItemByType(CppEnums.ItemWhereType.eInventory, idx)
        if nil ~= itemWrapper then
          local itemSSW = itemWrapper:getStaticStatus()
          local itemName = itemSSW:getName()
          if awakenItemName == itemName then
            awakenItemSlotNo = idx
            awakenItemCounts = getInventoryItemByType(CppEnums.ItemWhereType.eInventory, idx):get():getCount_s64()
            break
          end
        end
      end
      if nil ~= awakenItemSlotNo then
        return awakenItemSlotNo, awakenItemCounts
      else
        return awakenItemSlotNo, toInt64(0, 0)
      end
    end
  end
end
function PaGlobal_ServantSwiftTraining_All:getfloorValueString(value)
  if nil == Panel_Dialog_ServantSwiftTraining_All then
    return 0
  end
  return string.format(math.floor(value * 10) / 10)
end
function PaGlobal_ServantSwiftTraining_All:Awaken_Training_isNineTier()
  if nil == Panel_Dialog_ServantSwiftTraining_All then
    return
  end
  local awakenItemWrapper = stable_getStallionTrainingCompleteRequiredItem()
  if nil == awakenItemWrapper then
    return
  end
  local whereType = CppEnums.ItemWhereType.eInventory
  local protectWrapper = stable_getPreventStallionTrainingSkillExpItem()
  if nil == protectWrapper then
    return
  end
  local selfPlayerWrapper = getSelfPlayer()
  local selfPlayer = selfPlayerWrapper:get()
  local useStartSlot = inventorySlotNoUserStart()
  local invenUseSize = selfPlayer:getInventorySlotCount(false)
  local itemSlotNo = __eTInventorySlotNoUndefined
  local protectSlotNo = __eTInventorySlotNoUndefined
  local itemKey = awakenItemWrapper:get()._key:getItemKey()
  local protectKey = protectWrapper:get()._key:getItemKey()
  for idx = useStartSlot, invenUseSize - 1 do
    local itemWrapper = getInventoryItemByType(whereType, idx)
    if nil ~= itemWrapper then
      local invenItemSSW = itemWrapper:getStaticStatus()
      if itemKey == invenItemSSW:get()._key:getItemKey() then
        itemSlotNo = idx
      end
      if protectKey == invenItemSSW:get()._key:getItemKey() then
        protectSlotNo = idx
      end
      if __eTInventorySlotNoUndefined ~= itemSlotNo and __eTInventorySlotNoUndefined ~= protectSlotNo then
        break
      end
    end
  end
  if __eTInventorySlotNoUndefined ~= itemSlotNo then
    if not self._ui._btn_Check_Cron:IsCheck() then
      protectSlotNo = __eTInventorySlotNoUndefined
    end
    ToClient_completeStallionTraining(self._currentServentNo, whereType, itemSlotNo, whereType, protectSlotNo)
  end
  PaGlobal_ServantSwiftTraining_All:updateCronStone()
  PaGlobal_ServantSwiftTraining_All:updateCrogdaloItem()
end
function PaGlobal_ServantSwiftTraining_All:prepareClose()
  if nil == Panel_Dialog_ServantSwiftTraining_All then
    return
  end
  if -1 < self._isButtonClick then
    return
  end
  PaGlobalFunc_ServantNameRegist_All_SetIgnoreBtn(false)
  Panel_Tooltip_Item_hideTooltip()
  PaGlobal_ServantSwiftTraining_All:dataClear()
  PaGlobalFunc_ServantFunction_All_TempOnOff(true)
  PaGlobalFunc_ServantSwiftResult_All_EffectErase()
  PaGlobalFunc_ServantSwiftResult_All_EffectClose()
  PaGlobal_ServantSwiftTraining_All:close()
end
function PaGlobal_ServantSwiftTraining_All:dataClear()
  if nil == Panel_Dialog_ServantSwiftTraining_All or false == Panel_Dialog_ServantSwiftTraining_All:GetShow() then
    return
  end
  for itemIdx = 0, self._itemTotalCount do
    self._materialItemSlot[itemIdx].itemName = nil
    self._materialItemSlot[itemIdx].itemCount = nil
    self._materialItemSlot[itemIdx].itemSlotNo = nil
    self._materialItemSlot[itemIdx].itemCategory = nil
    self._materialItemSlot[itemIdx].itemWrapper = nil
  end
  for slotIdx = 0, self._slotCount - 1 do
    HandleEventLUp_ServantSwiftTraining_All_ItemClear(slotIdx)
  end
  self._cronStoneInfo._cronStoneSlotNo = -1
  self._cronStoneInfo._isEnableCronStone = false
  self._cronStoneInfo._cronStoneCount = 0
  self._crogdaloInfo._crogdaloSlotNo = -1
  self._crogdaloInfo._isEnableCrogdalo = false
  self._crogdaloInfo._crogdaloCount = 0
  self._effectControl = {}
  self._controlCount = 0
  self._isButtonClick = self._enum_BtnType._NOTCLICK
  self._awakenDoing = false
  self._effectType = 0
  self._elapsedTime = 0
  self._awakenExpCount = 0
  self._isGuideShow = false
  self._skillExpCount = {}
end
function PaGlobal_ServantSwiftTraining_All:close()
  if nil == Panel_Dialog_ServantSwiftTraining_All or false == Panel_Dialog_ServantSwiftTraining_All:GetShow() then
    return
  end
  Panel_Dialog_ServantSwiftTraining_All:SetShow(false)
end
function PaGlobal_ServantSwiftTraining_All:validate()
  if nil == Panel_Dialog_ServantSwiftTraining_All then
    return
  end
  self._ui._txt_Title:isValidate()
  self._ui._btn_Close_PC:isValidate()
  self._ui._stc_Bg:isValidate()
  self._ui._stc_MainBg:isValidate()
  self._ui._txt_TopDesc:isValidate()
  self._ui._txt_Stack:isValidate()
  self._ui._btn_Train:isValidate()
  self._ui._stc_SkillBg:isValidate()
  self._ui._stc_EleganceBg:isValidate()
  self._ui._stc_StaminaBg:isValidate()
  self._ui._stc_CrogdaloSlot:isValidate()
  self._ui._txt_CrogdaloCount:isValidate()
  self._ui._icon_Skill:isValidate()
  self._ui._stc_ProgressBg_Skill:isValidate()
  self._ui._prog2_Skill:isValidate()
  self._ui._prog2_Skill_Head:isValidate()
  self._ui._stc_Skill_Material:isValidate()
  self._ui._txt_Skill_Percent:isValidate()
  self._ui._txt_Skill_Title:isValidate()
  self._ui._icon_Elegance:isValidate()
  self._ui._stc_ProgressBg_Elegance:isValidate()
  self._ui._prog2_Elegance:isValidate()
  self._ui._prog2_Elegance_Head:isValidate()
  self._ui._stc_Elegance_Material:isValidate()
  self._ui._txt_Elegance_Percent:isValidate()
  self._ui._txt_Elegance_Title:isValidate()
  self._ui._icon_Stamina:isValidate()
  self._ui._stc_ProgressBg_Stamina:isValidate()
  self._ui._prog2_Stamina:isValidate()
  self._ui._prog2_Stamina_Head:isValidate()
  self._ui._stc_Stamina_Material:isValidate()
  self._ui._txt_Stamina_Percent:isValidate()
  self._ui._txt_Stamina_Percent:isValidate()
  self._ui._txt_Stamina_Title:isValidate()
  self._ui._btn_Guide_Pc:isValidate()
  self._ui._icon_Guide:isValidate()
  self._ui._txt_TotalPercent:isValidate()
  self._ui._stc_ButtonBg:isValidate()
  self._ui._btn_Check_Cron:isValidate()
  self._ui._txt_Count_Cron:isValidate()
  self._ui._btn_Try_Swift:isValidate()
  self._ui._stc_CronTooltipBg:isValidate()
  self._ui._txt_CronTooltip:isValidate()
  self._ui._stc_DescTooltipBg:isValidate()
  self._ui._txt_DescTooltip:isValidate()
  self._ui._stc_Console_KeyGuides:isValidate()
  self._ui._stc_KeyGuide_A:isValidate()
  self._ui._stc_KeyGuide_B:isValidate()
  self._ui._stc_KeyGuide_X:isValidate()
  self._ui._stc_KeyGuide_Y:isValidate()
  self._ui._list_NeedItemList:isValidate()
  self.initialize = true
end
