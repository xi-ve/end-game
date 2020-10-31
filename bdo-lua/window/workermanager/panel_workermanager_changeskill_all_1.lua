function PaGlobal_WorkerManagerChangeSkill_All:initialize()
  if true == PaGlobal_WorkerManagerChangeSkill_All._initialize then
    return
  end
  PaGlobal_WorkerManagerChangeSkill_All._isConsole = _ContentsGroup_RenewUI
  PaGlobal_WorkerManagerChangeSkill_All._isPadSnap = _ContentsGroup_UsePadSnapping
  PaGlobal_WorkerManagerChangeSkill_All:ControlAll_Init()
  PaGlobal_WorkerManagerChangeSkill_All:ControlPc_Init()
  PaGlobal_WorkerManagerChangeSkill_All:ControlConsole_Init()
  PaGlobal_WorkerManagerChangeSkill_All:ControlSetShow()
  PaGlobal_WorkerManagerChangeSkill_All:registEventHandler()
  PaGlobal_WorkerManagerChangeSkill_All:validate()
  PaGlobal_WorkerManagerChangeSkill_All._initialize = true
end
function PaGlobal_WorkerManagerChangeSkill_All:ControlAll_Init()
  if nil == Panel_Window_WorkerManagerChangeSkill_All then
    return
  end
  self._ui.stc_titleBg = UI.getChildControl(Panel_Window_WorkerManagerChangeSkill_All, "titlebar_manageWorker")
  self._ui.stc_mainBg = UI.getChildControl(Panel_Window_WorkerManagerChangeSkill_All, "Static_MainBG")
  self._ui.txt_notice = UI.getChildControl(Panel_Window_WorkerManagerChangeSkill_All, "StaticText_Notice")
  self._ui.stc_skillBg = UI.getChildControl(Panel_Window_WorkerManagerChangeSkill_All, "Static_SkillBG")
  self._ui.txt_exp = UI.getChildControl(self._ui.stc_skillBg, "StaticText_EXP")
  self._ui.radio_skillSlotBg = UI.getChildControl(self._ui.stc_skillBg, "RadioButton_SkillSlotBG")
  self._ui.stc_skillIconBg = UI.getChildControl(self._ui.radio_skillSlotBg, "Static_SkillSlotBG_00")
  self._ui.stc_skillIcon = UI.getChildControl(self._ui.radio_skillSlotBg, "Static_SkillSlot_00")
  self._ui.txt_skillName = UI.getChildControl(self._ui.radio_skillSlotBg, "StaticText_SkillName_00")
  self._ui.txt_skillDesc = UI.getChildControl(self._ui.radio_skillSlotBg, "StaticText_SkillDesc_00")
  local addSizeY = 0
  local gabSizeY = 10
  local controlSizeY = self._ui.txt_notice:GetSizeY()
  self._ui.txt_notice:SetTextMode(__eTextMode_AutoWrap)
  self._ui.txt_notice:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_WORKERMANAGER_TOOLTIP_CHANGESKILL_DESC"))
  if controlSizeY < self._ui.txt_notice:GetTextSizeY() + gabSizeY then
    addSizeY = self._ui.txt_notice:GetTextSizeY() + gabSizeY - controlSizeY
    self._ui.txt_notice:SetSize(self._ui.txt_notice:GetSizeX(), self._ui.txt_notice:GetSizeY() + addSizeY)
    Panel_Window_WorkerManagerChangeSkill_All:SetSize(Panel_Window_WorkerManagerChangeSkill_All:GetSizeX(), Panel_Window_WorkerManagerChangeSkill_All:GetSizeY() + addSizeY)
    self._ui.stc_mainBg:SetSize(self._ui.stc_mainBg:GetSizeX(), self._ui.stc_mainBg:GetSizeY() + addSizeY)
  end
  self._originPanelSizeY = Panel_Window_WorkerManagerChangeSkill_All:GetSizeY()
  self._originMainBgSizeY = self._ui.stc_mainBg:GetSizeY()
  local slotStartPosX = self._ui.radio_skillSlotBg:GetPosX()
  local slotStartPosY = self._ui.txt_exp:GetPosY() + self._ui.txt_exp:GetSizeY() + gabSizeY
  for idx = 0, self._maxSkillCount - 1 do
    local tempSlot = {}
    tempSlot.bg = UI.createAndCopyBasePropertyControl(self._ui.stc_skillBg, "RadioButton_SkillSlotBG", self._ui.stc_skillBg, "workerChangeSkill_SlotBG_" .. idx)
    tempSlot.iconBg = UI.createAndCopyBasePropertyControl(self._ui.radio_skillSlotBg, "Static_SkillSlotBG_00", tempSlot.bg, "workerChangeSkill_SkillIconBG_" .. idx)
    tempSlot.icon = UI.createAndCopyBasePropertyControl(self._ui.radio_skillSlotBg, "Static_SkillSlot_00", tempSlot.bg, "workerChangeSkill_SkillIcon_" .. idx)
    tempSlot.name = UI.createAndCopyBasePropertyControl(self._ui.radio_skillSlotBg, "StaticText_SkillName_00", tempSlot.bg, "workerChangeSkill_SkillName_" .. idx)
    tempSlot.desc = UI.createAndCopyBasePropertyControl(self._ui.radio_skillSlotBg, "StaticText_SkillDesc_00", tempSlot.bg, "workerChangeSkill_SkillDesc_" .. idx)
    tempSlot.bg:SetPosX(slotStartPosX)
    tempSlot.bg:SetPosY(slotStartPosY + (tempSlot.bg:GetSizeY() + 3) * idx)
    tempSlot.iconBg:ComputePos()
    tempSlot.icon:ComputePos()
    tempSlot.name:ComputePos()
    tempSlot.desc:ComputePos()
    tempSlot.name:SetTextMode(__eTextMode_LimitText)
    tempSlot.desc:SetTextMode(__eTextMode_LimitText)
    local skillLev = 0
    if 0 == idx then
      skillLev = 1
    else
      skillLev = idx * 5
    end
    tempSlot.name:SetText(skillLev .. PAGetString(Defines.StringSheet_GAME, "JOURNAL_WORD_LEVEL"))
    self._skillList[idx] = tempSlot
  end
end
function PaGlobal_WorkerManagerChangeSkill_All:ControlPc_Init()
  if nil == Panel_Window_WorkerManagerChangeSkill_All then
    return
  end
  self._ui_pc.btn_close = UI.getChildControl(self._ui.stc_titleBg, "Button_Close")
  self._ui_pc.btn_confirm = UI.getChildControl(Panel_Window_WorkerManagerChangeSkill_All, "Button_Confirm")
  self._ui_pc.btn_cancle = UI.getChildControl(Panel_Window_WorkerManagerChangeSkill_All, "Button_Cancel")
end
function PaGlobal_WorkerManagerChangeSkill_All:ControlConsole_Init()
  if nil == Panel_Window_WorkerManagerChangeSkill_All then
    return
  end
  self._ui_console.stc_keyguideBg = UI.getChildControl(Panel_Window_WorkerManagerChangeSkill_All, "Static_ConsoleKeyGuide")
  self._ui_console.stc_confirm = UI.getChildControl(self._ui_console.stc_keyguideBg, "StaticText_Confirm")
  self._ui_console.stc_close = UI.getChildControl(self._ui_console.stc_keyguideBg, "StaticText_Close")
  local keyGuide = {
    self._ui_console.stc_confirm,
    self._ui_console.stc_close
  }
  PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyGuide, self._ui_console.stc_keyguideBg, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP, nil, 10)
end
function PaGlobal_WorkerManagerChangeSkill_All:ControlSetShow()
  if nil == Panel_Window_WorkerManagerChangeSkill_All then
    return
  end
  if true == self._isPadSnap then
    self._ui_pc.btn_close:SetShow(false)
    self._ui_pc.btn_confirm:SetShow(false)
    self._ui_pc.btn_cancle:SetShow(false)
    self._ui_console.stc_keyguideBg:SetShow(true)
  else
    self._ui_pc.btn_close:SetShow(true)
    self._ui_pc.btn_confirm:SetShow(true)
    self._ui_pc.btn_cancle:SetShow(true)
    self._ui_console.stc_keyguideBg:SetShow(false)
  end
end
function PaGlobal_WorkerManagerChangeSkill_All:prepareOpen(workerIdx)
  if nil == Panel_Window_WorkerManagerChangeSkill_All then
    return
  end
  if false == Panel_Window_WorkerManager_All:IsShow() or false == Panel_Window_WorkerManager_All:GetShow() then
    return
  end
  if nil == workerIdx then
    return
  end
  self._selectedSkillKeyRaw = nil
  self._selectedWorkerNoRaw = nil
  self._selectedWorkerNoRaw = PaGlobalFunc_WorkerManager_All_GetWorkerNoRaw(workerIdx)
  PaGlobal_WorkerManagerChangeSkill_All:update()
  PaGlobal_WorkerManagerChangeSkill_All:open()
  PaGlobal_WorkerManagerChangeSkill_All:resize()
end
function PaGlobal_WorkerManagerChangeSkill_All:open()
  if nil == Panel_Window_WorkerManagerChangeSkill_All then
    return
  end
  Panel_Window_WorkerManagerChangeSkill_All:SetShow(true)
end
function PaGlobal_WorkerManagerChangeSkill_All:prepareClose()
  if nil == Panel_Window_WorkerManagerChangeSkill_All then
    return
  end
  if true == Panel_Window_WorkerManagerChangeSkill_All:IsUISubApp() then
    Panel_Window_WorkerManagerChangeSkill_All:CloseUISubApp()
  end
  self._selectedSkillKeyRaw = nil
  self._selectedWorkerNoRaw = nil
  PaGlobal_WorkerManagerChangeSkill_All:close()
end
function PaGlobal_WorkerManagerChangeSkill_All:close()
  if nil == Panel_Window_WorkerManagerChangeSkill_All then
    return
  end
  Panel_Window_WorkerManagerChangeSkill_All:SetShow(false)
end
function PaGlobal_WorkerManagerChangeSkill_All:update()
  if nil == Panel_Window_WorkerManagerChangeSkill_All then
    return
  end
  for idx = 0, self._maxSkillCount - 1 do
    self._skillList[idx].bg:SetShow(false)
    self._skillList[idx].bg:SetCheck(false)
  end
  local workerWrapperLua = getWorkerWrapper(self._selectedWorkerNoRaw, true)
  local skillCount = workerWrapperLua:getSkillCount()
  local curExperience = Int64toInt32(workerWrapperLua:getExperience())
  local maxExperience = Int64toInt32(workerWrapperLua:getMaxExperience())
  local exp = 0
  if 0 == curExperience or 0 == maxExperience then
    exp = 0
  else
    exp = math.floor(curExperience / maxExperience * 100)
  end
  self._ui.txt_exp:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_WORKERSKILLCHANGE_EXP", "exp", exp))
  for skillIdx = 0, skillCount - 1 do
    local skillSSW = workerWrapperLua:getSkillSSW(skillIdx)
    local skillKeyRaw = skillSSW:getKeyRaw()
    self._skillList[skillIdx].bg:SetShow(true)
    self._skillList[skillIdx].icon:ChangeTextureInfoName(skillSSW:getIconPath())
    self._skillList[skillIdx].name:SetText(skillSSW:getName())
    self._skillList[skillIdx].desc:SetText(skillSSW:getDescription())
    self._skillList[skillIdx].desc:SetEnableArea(0, 0, self._skillList[skillIdx].desc:GetTextSizeX() + 5, self._skillList[skillIdx].desc:GetSizeY())
    UI.setLimitTextAndAddTooltip(self._skillList[skillIdx].name)
    UI.setLimitTextAndAddTooltip(self._skillList[skillIdx].desc)
    if true == self._isPadSnap then
      self._skillList[skillIdx].bg:addInputEvent("Mouse_On", "HandleEventLup_WorkerManagerChangeSkill_All_SelectSkill(" .. skillKeyRaw .. ")")
    else
      self._skillList[skillIdx].bg:addInputEvent("Mouse_LUp", "HandleEventLup_WorkerManagerChangeSkill_All_SelectSkill( " .. skillKeyRaw .. " )")
    end
  end
end
function PaGlobal_WorkerManagerChangeSkill_All:registEventHandler()
  if nil == Panel_Window_WorkerManagerChangeSkill_All then
    return
  end
  Panel_Window_WorkerManagerChangeSkill_All:ignorePadSnapMoveToOtherPanel()
  registerEvent("FromClient_ChangeWorkerSkillNoOne", "FromClient_WorkerManagerChangeSkill_All_ChangeWorkerSkillNoOne")
  registerEvent("FromClient_ChangeWorkerSkillNo", "FromClient_WorkerManagerChangeSkill_All_ChangeWorkerSkillNo")
  if true == self._isPadSnap then
    Panel_Window_WorkerManagerChangeSkill_All:registerPadEvent(__eConsoleUIPadEvent_Up_A, "HandleEventLup_WorkerManagerChangeSkill_All_ConfirmChange()")
  else
    self._ui_pc.btn_close:addInputEvent("Mouse_LUp", "PaGlobalFunc_WorkerManagerChangeSkill_All_Close()")
    self._ui_pc.btn_cancle:addInputEvent("Mouse_LUp", "PaGlobalFunc_WorkerManagerChangeSkill_All_Close()")
    self._ui_pc.btn_confirm:addInputEvent("Mouse_LUp", "HandleEventLup_WorkerManagerChangeSkill_All_ConfirmChange()")
  end
end
function PaGlobal_WorkerManagerChangeSkill_All:validate()
  if nil == Panel_Window_WorkerManagerChangeSkill_All then
    return
  end
  self._ui.stc_titleBg:isValidate()
  self._ui.stc_mainBg:isValidate()
  self._ui.txt_notice:isValidate()
  self._ui.stc_skillBg:isValidate()
  self._ui.txt_exp:isValidate()
  self._ui.radio_skillSlotBg:isValidate()
  self._ui.stc_skillIconBg:isValidate()
  self._ui.stc_skillIcon:isValidate()
  self._ui.txt_skillName:isValidate()
  self._ui.txt_skillDesc:isValidate()
  self._ui_pc.btn_close:isValidate()
  self._ui_pc.btn_confirm:isValidate()
  self._ui_pc.btn_cancle:isValidate()
end
function PaGlobal_WorkerManagerChangeSkill_All:resize()
  if nil == Panel_Window_WorkerManagerChangeSkill_All then
    return
  end
  self._ui.stc_skillBg:ComputePos()
  self._ui_pc.btn_cancle:ComputePos()
  self._ui_pc.btn_confirm:ComputePos()
  if nil ~= Panel_Window_WorkerManager_All and true == Panel_Window_WorkerManager_All:GetShow() then
    local mainPanelPosX = Panel_Window_WorkerManager_All:GetPosX()
    local mainPanelPosY = Panel_Window_WorkerManager_All:GetPosY()
    local mainPanelSizeX = Panel_Window_WorkerManager_All:GetSizeX()
    local endPosX = mainPanelPosX + mainPanelSizeX + 10 + Panel_Window_WorkerManagerChangeSkill_All:GetSizeX()
    if endPosX < getScreenSizeX() then
      Panel_Window_WorkerManagerChangeSkill_All:SetPosX(mainPanelPosX + mainPanelSizeX + 10)
      Panel_Window_WorkerManagerChangeSkill_All:SetPosY(mainPanelPosY)
    else
      Panel_Window_WorkerManagerChangeSkill_All:SetPosX(math.max(0, mainPanelPosX - 10 - Panel_Window_WorkerManagerChangeSkill_All:GetSizeX()))
      Panel_Window_WorkerManagerChangeSkill_All:SetPosY(mainPanelPosY)
    end
  end
  if true == Panel_Window_WorkerManager_All:IsUISubApp() then
    if 0 < Panel_Window_WorkerManager_All:GetScreenParentPosX() then
      Panel_Window_WorkerManagerChangeSkill_All:SetPosX(Panel_Window_WorkerManager_All:GetScreenParentPosX() - Panel_Window_WorkerManagerChangeSkill_All:GetSizeX() - 10)
    else
      Panel_Window_WorkerManagerChangeSkill_All:SetPosX(Panel_Window_WorkerManager_All:GetScreenParentPosX() + Panel_Window_WorkerManager_All:GetSizeX() - 10)
    end
    Panel_Window_WorkerManagerChangeSkill_All:SetPosY(Panel_Window_WorkerManager_All:GetScreenParentPosY())
    Panel_Window_WorkerManagerChangeSkill_All:OpenUISubApp()
  end
  if true == self._isPadSnap then
    Panel_Window_WorkerManagerChangeSkill_All:SetSize(Panel_Window_WorkerManagerChangeSkill_All:GetSizeX(), self._originPanelSizeY - self._ui_pc.btn_cancle:GetSizeY() - 20)
    self._ui.stc_mainBg:SetSize(self._ui.stc_mainBg:GetSizeX(), self._originMainBgSizeY - self._ui_pc.btn_cancle:GetSizeY() - 20)
    self._ui.stc_skillBg:SetSpanSize(self._ui.stc_skillBg:GetSpanSize().x, 0)
    self._ui.stc_skillBg:ComputePos()
    self._ui_console.stc_keyguideBg:ComputePos()
  end
end
