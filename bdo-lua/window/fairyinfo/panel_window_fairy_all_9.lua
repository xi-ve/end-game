function PaGlobal_FairyChangeSkill_All:initialize()
  if true == PaGlobal_FairyChangeSkill_All._initialize then
    return
  end
  self._ui.stc_TitleBG = UI.getChildControl(Panel_Window_FairyChangeSkill_All, "Static_TitleBG")
  self._ui.txt_Title_Name = UI.getChildControl(self._ui.stc_TitleBG, "StaticText_Title_Name")
  self._ui.stc_MainBG = UI.getChildControl(Panel_Window_FairyChangeSkill_All, "Static_MainBG")
  self._ui.stc_HasSkillSlot = UI.getChildControl(self._ui.stc_MainBG, "Static_HasSkillSlot")
  self._ui.stc_GetSkillSlot = UI.getChildControl(self._ui.stc_MainBG, "Static_GetSkillSlot")
  self._ui.mtl_Change = UI.getChildControl(self._ui.stc_MainBG, "MultilineText_Change")
  self._ui.btn_Template = UI.getChildControl(Panel_Window_FairyChangeSkill_All, "RadioButton_Template")
  self._ui.stc_SkillSlotBg = UI.getChildControl(self._ui.btn_Template, "Static_SkillSlotBg")
  self._ui.stc_MasterIcon = UI.getChildControl(self._ui.stc_SkillSlotBg, "Static_MasterIcon")
  self._ui.txt_SkillName = UI.getChildControl(self._ui.btn_Template, "StaticText_SkillName")
  self._ui.txt_SkillDesc = UI.getChildControl(self._ui.btn_Template, "StaticText_SkillDesc")
  self._ui.btn_ViewSkill = UI.getChildControl(Panel_Window_FairyChangeSkill_All, "Button_ViewSkill")
  self._ui.btn_VIewHelp = UI.getChildControl(Panel_Window_FairyChangeSkill_All, "CheckButton_VIewHelp")
  self._ui.stc_SlotBG = UI.getChildControl(Panel_Window_FairyChangeSkill_All, "Static_SlotBG")
  self._ui_pc.btn_Close_pc = UI.getChildControl(self._ui.stc_TitleBG, "Button_Win_Close_PC")
  self._ui_pc.btn_Change_pc = UI.getChildControl(Panel_Window_FairyChangeSkill_All, "Button_Change_PCUI")
  self._ui_console.stc_KeyGuide = UI.getChildControl(Panel_Window_FairyChangeSkill_All, "Static_KeyGuide_ConsoleUI")
  self._ui_console.txt_KeyGuide_A = UI.getChildControl(self._ui_console.stc_KeyGuide, "StaticText_B_Console")
  self._ui_console.txt_KeyGuide_B = UI.getChildControl(self._ui_console.stc_KeyGuide, "StaticText_A_ConsoleUI")
  PaGlobal_FairyChangeSkill_All:registEventHandler()
  self._changeAniState = self._ANI_STATE.STOP
  PaGlobal_FairyChangeSkill_All:validate()
  self._ui.stc_HasSkillSlot:SetEnable(true)
  self._ui.stc_GetSkillSlot:SetEnable(true)
  self._ui.mtl_Change:SetPosY(self._ui.mtl_Change:GetPosY() - 20)
  self._ui.mtl_Change:SetShow(true)
  self._ui.stc_SlotBG:SetShow(false)
  self:createSlot()
  if _ContentsGroup_UsePadSnapping then
    self._ui_pc.btn_Close_pc:SetShow(false)
    self._ui_console.stc_KeyGuide:SetShow(true)
    local keyGuide = {
      self._ui_console.txt_KeyGuide_A,
      self._ui_console.txt_KeyGuide_B
    }
    PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyGuide, self._ui_console.stc_KeyGuide, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHT)
  end
  PaGlobal_FairyChangeSkill_All._initialize = true
end
function PaGlobal_FairyChangeSkill_All:registEventHandler()
  if nil == Panel_Window_FairyChangeSkill_All then
    return
  end
  self._ui_pc.btn_Change_pc:addInputEvent("Mouse_LUp", "InputMLUp_FairyChangeSkill_Confirm()")
  self._ui_pc.btn_Close_pc:addInputEvent("Mouse_LUp", "PaGlobal_FairyChangeSkill_Close_All(false)")
  self._ui.btn_VIewHelp:addInputEvent("Mouse_LUp", "PaGlobal_FairyChangeSkill_Viewhelper_Open_All()")
  self._ui.btn_ViewSkill:addInputEvent("Mouse_LUp", "PaGlobalFunc_FairySkill_Open_All(true)")
  Panel_Window_FairyChangeSkill_All:RegisterUpdateFunc("FromClient_FairyChangeSkill_UpdatePerFrame")
end
function PaGlobal_FairyChangeSkill_All:prepareOpen()
  if ToClient_getFairyUnsealedList() < 1 then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoNeedUnsealFairy"))
    return
  end
  self._ui.stc_HasSkillSlot:SetShow(false)
  self._ui.stc_GetSkillSlot:SetShow(false)
  PaGlobal_FairyChangeSkill_FairySetting()
  PaGlobal_FairyChangeSkill_ChangeBtnSetting()
  PaGlobal_FairyChangeSkill_Viewhelper_Open_All()
  PaGlobal_FairyChangeSkill_All:open()
  PaGlobal_FairyChangeSkill_CurrentItemCountSetting()
end
function PaGlobal_FairyChangeSkill_All:open()
  Panel_Window_FairyChangeSkill_All:SetShow(true)
end
function PaGlobal_FairyChangeSkill_All:prepareClose(isAttack)
  if nil ~= self._changeAnimationEffect then
    self._ui.stc_MainBG:EraseEffect(self._changeAnimationEffect)
  end
  if nil ~= self._changeEffect then
    self._changeEffectControl:EraseEffect(self._changeEffect)
  end
  audioPostEvent_SystemUi(21, 99)
  _AudioPostEvent_SystemUiForXBOX(21, 99)
  PaGlobal_EasyBuy_Close()
  TooltipSimple_Hide()
  PaGlobalFunc_FairySkill_Close_All()
  PaGlobal_FairyChangeSkill_Viewhelper_Close_All()
  PaGlobal_FairyChangeSkill_FairySkillSettingReset()
  PaGlobal_FairyChangeSkill_All:close(isAttack)
end
function PaGlobal_FairyChangeSkill_All:close(isAttack)
  Panel_Window_FairyChangeSkill_All:SetShow(false)
  if false == isAttack then
    PaGlobal_FairyInfo_Open_All(false)
  end
end
function PaGlobal_FairyChangeSkill_All:validate()
  if nil == Panel_Window_FairyChangeSkill_All then
    return
  end
  self._ui.stc_TitleBG:isValidate()
  self._ui.txt_Title_Name:isValidate()
  self._ui.stc_MainBG:isValidate()
  self._ui.stc_HasSkillSlot:isValidate()
  self._ui.stc_GetSkillSlot:isValidate()
  self._ui.mtl_Change:isValidate()
  self._ui.btn_Template:isValidate()
  self._ui.stc_SkillSlotBg:isValidate()
  self._ui.txt_SkillName:isValidate()
  self._ui.stc_MasterIcon:isValidate()
  self._ui.txt_SkillDesc:isValidate()
  self._ui.stc_SlotBG:isValidate()
  self._ui.btn_ViewSkill:isValidate()
  self._ui.btn_VIewHelp:isValidate()
  self._ui_pc.btn_Close_pc:isValidate()
  self._ui_pc.btn_Change_pc:isValidate()
  self._ui_console.stc_KeyGuide:isValidate()
  self._ui_console.txt_KeyGuide_A:isValidate()
  self._ui_console.txt_KeyGuide_B:isValidate()
end
function PaGlobal_FairyChangeSkill_All:createSlot()
  for i = 0, self._learnSkillMaxCount - 1 do
    local slot = {}
    slot.Btn = UI.createControl(__ePAUIControl_RadioButton, Panel_Window_FairyChangeSkill_All, "Slot_SkillBtn" .. i)
    slot.SkillSlotBg = UI.createControl(__ePAUIControl_Static, slot.Btn, "Slot_SkillSlotBg" .. i)
    slot.MasterIcon = UI.createControl(__ePAUIControl_Static, slot.SkillSlotBg, "Slot_MasterIcon" .. i)
    slot.SkillName = UI.createControl(__ePAUIControl_StaticText, slot.Btn, "Slot_SkillName" .. i)
    slot.SkillDesc = UI.createControl(__ePAUIControl_StaticText, slot.Btn, "Slot_SkillDesc" .. i)
    slot.stc_SlotBG = UI.createControl(__ePAUIControl_Static, Panel_Window_FairyChangeSkill_All, "Slot_SlotBG" .. i)
    CopyBaseProperty(self._ui.btn_Template, slot.Btn)
    CopyBaseProperty(self._ui.stc_SkillSlotBg, slot.SkillSlotBg)
    CopyBaseProperty(self._ui.stc_MasterIcon, slot.MasterIcon)
    CopyBaseProperty(self._ui.txt_SkillName, slot.SkillName)
    CopyBaseProperty(self._ui.txt_SkillDesc, slot.SkillDesc)
    CopyBaseProperty(self._ui.stc_SlotBG, slot.stc_SlotBG)
    local PosX = self._ui.stc_MainBG:GetPosX()
    local PosY = self._ui.stc_MainBG:GetPosY()
    local gapY = 70
    slot.Btn:SetPosX(self._ui.btn_Template:GetPosX())
    slot.Btn:SetPosY(self._ui.btn_Template:GetPosY() + gapY * i)
    slot.Btn:SetShow(false)
    slot.stc_SlotBG:SetShow(false)
    slot.MasterIcon:SetShow(false)
    self._skillSlot[i] = slot
  end
  self._ui.btn_Template:SetShow(false)
end
function PaGlobal_FairyChangeSkill_All:update(skillKeyList)
  if nil == Panel_Window_FairyChangeSkill_All then
    return
  end
  if nil == skillKeyList then
    return
  end
  self._ui.mtl_Change:SetText()
  self._skillKeyList = skillKeyList
  PaGlobal_FairyChangeSkill_FairySkillSettingReset()
  PaGlobal_FairyChangeSkill_FairySetting()
  local count = 0
  for key, value in pairs(self._skillKeyList) do
    local skillSSW = ToClient_Fairy_EquipSkillWrraper(key)
    if nil == skillSSW then
      return
    end
    local skillTypeSSW = skillSSW:getSkillTypeStaticStatusWrapper()
    if nil == skillTypeSSW then
      return
    end
    local slot = self._skillSlot[count]
    slot.Btn:SetShow(true)
    slot.Btn:SetMonoTone(false)
    slot.Btn:SetEnable(true)
    slot.Btn:setRenderTexture(slot.Btn:getBaseTexture())
    slot.SkillSlotBg:getBaseTexture():setUV(0, 0, 1, 1)
    slot.SkillSlotBg:ChangeTextureInfoName("Icon/" .. skillTypeSSW:getIconPath())
    slot.SkillSlotBg:setRenderTexture(slot.SkillSlotBg:getBaseTexture())
    slot.MasterIcon:SetShow(Toclient_FairySkill_IsMaxLevel(PaGlobal_FairyInfo_GetFairyKey_All(), key))
    slot.SkillName:SetText(skillTypeSSW:getName())
    slot.SkillDesc:SetTextMode(__eTextMode_LimitText)
    slot.SkillDesc:SetText(skillTypeSSW:getDescription())
    slot.Btn:addInputEvent("Mouse_LUp", "InputMLUp_FairyChangeSkill_SelectSkill(" .. key .. ")")
    slot.Btn:addInputEvent("Mouse_On", "PaGlobal_FairyChangeSkill_ShowTooltip(true, " .. key .. "," .. count .. ")")
    slot.Btn:addInputEvent("Mouse_Out", "PaGlobal_FairyChangeSkill_ShowTooltip(false)")
    if nil ~= self._newSkillkey and key == self._newSkillkey and nil == self._changeEffect then
      self._changeEffect = slot.Btn:AddEffect("fUI_Fairy_Skill_Change_01A", false, 0, 0)
      self._changeEffectControl = slot.Btn
    end
    count = count + 1
  end
end
function PaGlobal_FairyChangeSkill_All:settingReset()
  local count = 0
  if nil ~= self._skillKeyList then
    for key, value in pairs(self._skillKeyList) do
      local slot = self._skillSlot[count]
      slot.Btn:SetShow(true)
      slot.Btn:SetCheck(false)
      slot.Btn:SetMonoTone(false)
      slot.Btn:SetEnable(true)
      slot.Btn:setRenderTexture(slot.Btn:getBaseTexture())
      count = count + 1
    end
  end
  if 0 == count then
    for i = 0, self._learnSkillMaxCount - 1 do
      local slot = self._skillSlot[i]
      slot.Btn:SetShow(false)
      slot.Btn:SetCheck(false)
      slot.Btn:SetMonoTone(false)
      slot.Btn:SetEnable(true)
      slot.Btn:setRenderTexture(slot.Btn:getBaseTexture())
      count = count + 1
    end
  end
  self._changeAniState = self._ANI_STATE.STOP
  self._selectSkillKey = nil
  PaGlobal_FairyChangeSkill_ChangeBtnSetting()
  PaGlobal_FairyChangeSkill_CurrentItemCountSetting()
end
function PaGlobal_FairyChangeSkill_All:fairySetting()
  self._fairyNo = PaGlobal_FairyInfo_GetFairyNo_All()
  self._fairyLevel = PaGlobal_FairyInfo_GetLevel_All()
  if nil ~= self._fairyLevel then
    local needCount = ToClient_getSkillChangeItemCount(self._fairyLevel)
    self._ui_pc.btn_Change_pc:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_FAIRYINFO_SKILLCHANGE_BUTTON", "needCount", tostring(needCount)))
  end
end
function PaGlobal_FairyChangeSkill_All:selectSkill(key)
  self._newSkillkey = nil
  self._changeEffect = nil
  self._changeEffectControl = nil
  self._selectSkillKey = key
  self._ui.stc_GetSkillSlot:SetShow(false)
  local skillSSW = ToClient_Fairy_EquipSkillWrraper(self._selectSkillKey)
  if nil == skillSSW then
    return
  end
  local skillTypeSSW = skillSSW:getSkillTypeStaticStatusWrapper()
  if nil == skillTypeSSW then
    return
  end
  self._ui.stc_HasSkillSlot:SetShow(true)
  self._ui.stc_HasSkillSlot:getBaseTexture():setUV(0, 0, 1, 1)
  self._ui.stc_HasSkillSlot:ChangeTextureInfoName("Icon/" .. skillTypeSSW:getIconPath())
  self._ui.stc_HasSkillSlot:setRenderTexture(self._ui.stc_HasSkillSlot:getBaseTexture())
  self._ui.stc_HasSkillSlot:addInputEvent("Mouse_On", "PaGlobal_FairyChangeSkill_ShowTooltip(true, " .. key .. "," .. "100" .. ")")
  self._ui.stc_HasSkillSlot:addInputEvent("Mouse_Out", "PaGlobal_FairyChangeSkill_ShowTooltip(false)")
  PaGlobal_FairyChangeSkill_ChangeBtnSetting()
end
function PaGlobal_FairyChangeSkill_All:contirm()
  ToClient_requestChangeFairySkill(self._fairyNo, self._selectSkillKey)
  PaGlobal_FairyChangeSkill_FairySkillSettingReset()
end
function PaGlobal_FairyChangeSkill_All:fairyNewSkillKey(newSkillKey)
  local selectSkillSSW = ToClient_Fairy_EquipSkillWrraper(newSkillKey)
  if nil == selectSkillSSW then
    return
  end
  local selectSkillTypeSSW = selectSkillSSW:getSkillTypeStaticStatusWrapper()
  if nil == selectSkillTypeSSW then
    return
  end
  self._ui.stc_GetSkillSlot:SetShow(true)
  self._ui.stc_GetSkillSlot:getBaseTexture():setUV(0, 0, 1, 1)
  self._ui.stc_GetSkillSlot:ChangeTextureInfoName("Icon/" .. selectSkillTypeSSW:getIconPath())
  self._ui.stc_GetSkillSlot:setRenderTexture(self._ui.stc_GetSkillSlot:getBaseTexture())
  self._ui.stc_GetSkillSlot:addInputEvent("Mouse_On", "PaGlobal_FairyChangeSkill_ShowTooltip(true, " .. newSkillKey .. "," .. "200" .. ")")
  self._ui.stc_GetSkillSlot:addInputEvent("Mouse_Out", "PaGlobal_FairyChangeSkill_ShowTooltip(false)")
  self._newSkillkey = newSkillKey
end
function PaGlobal_FairyChangeSkill_All:confirmMessageBox()
  if nil == self._selectSkillKey then
    return
  end
  local skillSSW = ToClient_Fairy_EquipSkillWrraper(self._selectSkillKey)
  if nil == skillSSW then
    return
  end
  local skillTypeSSW = skillSSW:getSkillTypeStaticStatusWrapper()
  if nil == skillTypeSSW then
    return
  end
  local selfPlayer = getSelfPlayer():get()
  if nil == selfPlayer then
    return
  end
  local invenSize = selfPlayer:getInventorySlotCount(true)
  local needCount = ToClient_getSkillChangeItemCount(self._fairyLevel)
  local itemCount = 0
  for invenIdx = 0, invenSize - 1 do
    local itemWrapper = getInventoryItemByType(CppEnums.ItemWhereType.eCashInventory, invenIdx)
    if nil ~= itemWrapper then
      local itemSSW = itemWrapper:getStaticStatus()
      if CppEnums.ContentsEventType.ContentsType_ChangeFairySkill == itemSSW:get():getContentsEventType() then
        itemCount = Int64toInt32(itemWrapper:getCount())
        invenIdx = 0
      end
    end
  end
  if needCount > itemCount or 0 == itemCount then
    if false == _ContentsGroup_UsePadSnapping then
      PaGlobal_EasyBuy:Open(79, nil, false)
    else
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_FAIRYINFO_SKILLCHANGE_NOT_ENOUGH"))
    end
  else
    local FunctionYes = function()
      PaGlobal_FairyChangeSkill_All:confirmStartAni()
    end
    local _title = PAGetString(Defines.StringSheet_GAME, "LUA_MESSAGEBOX_NOTIFY")
    local _contenet = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_FAIRYINFO_SKILLCHANGE_CONFIRMDESC", "changeSkill", skillTypeSSW:getName(), "count", tostring(needCount))
    local messageBoxData = {
      title = _title,
      content = _contenet,
      functionYes = FunctionYes,
      functionNo = MessageBox_Empty_function,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageBoxData, "middle")
  end
end
function PaGlobal_FairyChangeSkill_All:confirmStartAni()
  self._changeAnimationEffect = self._ui.stc_MainBG:AddEffect("fUI_Fairy_Skill_Upgrade_01A", false, 0, 0)
  self._ui_pc.btn_Change_pc:SetMonoTone(true)
  self._ui_pc.btn_Change_pc:SetEnable(false)
  for i = 0, self._learnSkillMaxCount - 1 do
    local slot = self._skillSlot[i]
    slot.Btn:SetMonoTone(true)
    slot.Btn:SetEnable(false)
  end
  audioPostEvent_SystemUi(21, 3)
  _AudioPostEvent_SystemUiForXBOX(21, 3)
  self._ui.mtl_Change:SetShow(false)
  self._changeAniState = self._ANI_STATE.START
end
function PaGlobal_FairyChangeSkill_All:confirmPlayAni(deltaTime)
  self._aniStartTime = deltaTime
  self._aniEndTime = self._aniStartTime + self._aniDelayTime
  self._changeAniState = self._ANI_STATE.PLAY
end
function PaGlobal_FairyChangeSkill_All:confirmEndAni()
  self._ui_pc.btn_Change_pc:SetMonoTone(false)
  self._ui_pc.btn_Change_pc:SetEnable(true)
  for i = 0, self._learnSkillMaxCount - 1 do
    local slot = self._skillSlot[i]
    slot.Btn:SetMonoTone(false)
    slot.Btn:SetEnable(true)
  end
  self._ui.mtl_Change:SetShow(true)
  self._changeAniState = self._ANI_STATE.STOP
end
function PaGlobal_FairyChangeSkill_All:changeBtnSetting()
  if nil ~= self._selectSkillKey then
    self._ui_pc.btn_Change_pc:SetEnable(true)
    self._ui_pc.btn_Change_pc:SetMonoTone(false)
  else
    self._ui_pc.btn_Change_pc:SetEnable(false)
    self._ui_pc.btn_Change_pc:SetMonoTone(true)
  end
end
function PaGlobal_FairyChangeSkill_All:currentItemCountSetting()
  if false == PaGlobal_FairyChangeSkill_IsGetShow() then
    return
  end
  local selfPlayer = getSelfPlayer():get()
  if nil == selfPlayer then
    return
  end
  local invenSize = selfPlayer:getInventorySlotCount(true)
  local itemCount = 0
  for invenIdx = 0, invenSize - 1 do
    local itemWrapper = getInventoryItemByType(CppEnums.ItemWhereType.eCashInventory, invenIdx)
    if nil ~= itemWrapper then
      local itemSSW = itemWrapper:getStaticStatus()
      if CppEnums.ContentsEventType.ContentsType_ChangeFairySkill == itemSSW:get():getContentsEventType() then
        itemCount = Int64toInt32(itemWrapper:getCount())
        break
      end
    end
  end
  self._ui.mtl_Change:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_FAIRYINFO_SKILLCHANGE_ITEMCOUNT", "count", tostring(itemCount)))
  self._ui.mtl_Change:SetShow(true)
end
function PaGlobal_FairyChangeSkill_All:ShowTooltip(isShow, key, slotIdx)
  if false == isShow then
    TooltipSimple_Hide()
    return
  end
  local skillSSW = ToClient_Fairy_EquipSkillWrraper(key)
  if nil == skillSSW then
    return
  end
  local skillTypeSSW = skillSSW:getSkillTypeStaticStatusWrapper()
  if nil == skillTypeSSW then
    return
  end
  if 100 == slotIdx then
    TooltipSimple_Show(self._ui.stc_HasSkillSlot, skillTypeSSW:getName(), skillTypeSSW:getDescription())
  elseif 200 == slotIdx then
    TooltipSimple_Show(self._ui.stc_GetSkillSlot, skillTypeSSW:getName(), skillTypeSSW:getDescription())
  elseif nil ~= self._skillSlot[slotIdx].SkillSlotBg then
    if true == Toclient_FairySkill_IsMaxLevel(PaGlobal_FairyInfo_GetFairyKey_All(), key) then
      TooltipSimple_Show(self._skillSlot[slotIdx].SkillSlotBg, skillTypeSSW:getName(), skillTypeSSW:getDescription() .. "\n" .. PAGetString(Defines.StringSheet_GAME, "LUA_FAIRY_SKILLTOOLTIP_MASTERSKILL"))
    else
      TooltipSimple_Show(self._skillSlot[slotIdx].SkillSlotBg, skillTypeSSW:getName(), skillTypeSSW:getDescription())
    end
  end
end
