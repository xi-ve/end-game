function PaGlobal_BlackSpiritSkillLock_All:initialize()
  if true == PaGlobal_BlackSpiritSkillLock_All._initialize then
    return
  end
  PaGlobal_BlackSpiritSkillLock_All._isConsole = _ContentsGroup_RenewUI
  PaGlobal_BlackSpiritSkillLock_All:ControlAll_Init()
  PaGlobal_BlackSpiritSkillLock_All:ControlPc_Init()
  PaGlobal_BlackSpiritSkillLock_All:ControlConsole_Init()
  PaGlobal_BlackSpiritSkillLock_All:ControlSetShow()
  PaGlobal_BlackSpiritSkillLock_All:registEventHandler()
  PaGlobal_BlackSpiritSkillLock_All:validate()
  PaGlobal_BlackSpiritSkillLock_All._initialize = true
end
function PaGlobal_BlackSpiritSkillLock_All:ControlAll_Init()
  if nil == Panel_Window_BlackSpiritSkillLock_All then
    return
  end
  self._ui.stc_titleBar = UI.getChildControl(Panel_Window_BlackSpiritSkillLock_All, "StaticText_Title")
  self._ui.chk_lockAll = UI.getChildControl(Panel_Window_BlackSpiritSkillLock_All, "CheckButton_LockAll")
  self._ui.stc_mainBg = UI.getChildControl(Panel_Window_BlackSpiritSkillLock_All, "Static_MainBg")
  self._ui.list2_skill = UI.getChildControl(Panel_Window_BlackSpiritSkillLock_All, "List2_SkillList")
  self._ui.stc_descBG = UI.getChildControl(Panel_Window_BlackSpiritSkillLock_All, "Static_DescBG")
  self._ui.txt_desc = UI.getChildControl(self._ui.stc_descBG, "StaticText_Desc")
  self._ui.stc_titleBar:SetTextMode(__eTextMode_AutoWrap)
  self._ui.txt_desc:SetTextMode(__eTextMode_AutoWrap)
  self._ui.txt_desc:SetText(self._ui.txt_desc:GetText())
  self._ui.chk_lockAll:SetEnableArea(0, 0, self._ui.chk_lockAll:GetSizeX() + self._ui.chk_lockAll:GetTextSizeX() + 10, self._ui.chk_lockAll:GetSizeY())
  self._uiSize.descBgY = self._ui.stc_descBG:GetSizeY()
  self._uiSize.panelY = Panel_Window_BlackSpiritSkillLock_All:GetSizeY()
end
function PaGlobal_BlackSpiritSkillLock_All:ControlPc_Init()
  if nil == Panel_Window_BlackSpiritSkillLock_All then
    return
  end
  self._ui_pc.btn_close = UI.getChildControl(self._ui.stc_titleBar, "Button_Win_Close")
end
function PaGlobal_BlackSpiritSkillLock_All:ControlConsole_Init()
  if nil == Panel_Window_BlackSpiritSkillLock_All then
    return
  end
  self._ui_console.stc_bottomGuideBg = UI.getChildControl(Panel_Window_BlackSpiritSkillLock_All, "Static_BottomGroup_ConsoleUI")
  self._ui_console.stc_guideA = UI.getChildControl(self._ui_console.stc_bottomGuideBg, "StaticText_A_ConsoleUI")
  self._ui_console.stc_guideB = UI.getChildControl(self._ui_console.stc_bottomGuideBg, "StaticText_B_ConsoleUI")
  self._ui_console.stc_guideY = UI.getChildControl(self._ui_console.stc_bottomGuideBg, "StaticText_Y_ConsoleUI")
end
function PaGlobal_BlackSpiritSkillLock_All:ControlSetShow()
  if nil == Panel_Window_BlackSpiritSkillLock_All then
    return
  end
  if false == self._isConsole then
    self._ui_pc.btn_close:SetShow(true)
    self._ui_console.stc_bottomGuideBg:SetShow(false)
  else
    self._ui_pc.btn_close:SetShow(false)
    self._ui_console.stc_bottomGuideBg:SetShow(true)
    self._ui_console.stc_guideA:SetShow(true)
    self._ui_console.stc_guideB:SetShow(true)
    self._ui_console.stc_guideY:SetShow(true)
  end
end
function PaGlobal_BlackSpiritSkillLock_All:prepareOpen(openType)
  if nil == Panel_Window_BlackSpiritSkillLock_All then
    return
  end
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  self._classType = selfPlayer:getClassType()
  self:setSkill()
  if 0 == self._skillCount then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_BLACKSPIRITLOCK_IMPOSSIBLE"), nil, nil, nil, true)
    return
  end
  if self._OPEN_TYPE.SKILLWINDOW == openType and false == _ContentsGroup_UISkillGroupTreeLayOut then
    if nil ~= Panel_EnableSkill and Panel_EnableSkill:GetShow() then
      FGlobal_EnableSkillCloseFunc()
    elseif nil ~= Panel_SkillCoolTimeSlot and Panel_SkillCoolTimeSlot:GetShow() then
      PaGlobal_Window_Skill_CoolTimeSlot:closeFunc()
    end
  end
  PaGlobal_BlackSpiritSkillLock_All:resize(openType)
  PaGlobal_BlackSpiritSkillLock_All:open()
end
function PaGlobal_BlackSpiritSkillLock_All:open()
  if nil == Panel_Window_BlackSpiritSkillLock_All then
    return
  end
  Panel_Window_BlackSpiritSkillLock_All:SetShow(true)
end
function PaGlobal_BlackSpiritSkillLock_All:prepareClose()
  if nil == Panel_Window_BlackSpiritSkillLock_All then
    return
  end
  Panel_SkillTooltip_Hide()
  if nil ~= Panel_Window_Skill and Panel_Window_Skill:GetShow() then
    EnableSkillShowFunc()
  end
  PaGlobal_BlackSpiritSkillLock_All:close()
end
function PaGlobal_BlackSpiritSkillLock_All:close()
  if nil == Panel_Window_BlackSpiritSkillLock_All then
    return
  end
  Panel_Window_BlackSpiritSkillLock_All:SetShow(false)
end
function PaGlobal_BlackSpiritSkillLock_All:registEventHandler()
  if nil == Panel_Window_BlackSpiritSkillLock_All then
    return
  end
  registerEvent("EventSkillWindowUpdate", "PaGlobalFunc_BlackSpiritSkillLock_All_Update")
  registerEvent("EventSkillWindowClearSkill", "PaGlobalFunc_BlackSpiritSkillLock_All_Update")
  registerEvent("EventSkillWindowClearSkillAll", "PaGlobalFunc_BlackSpiritSkillLock_All_Update")
  registerEvent("EventSkillWindowClearSkillByPoint", "PaGlobalFunc_BlackSpiritSkillLock_All_Update")
  self._ui.list2_skill:registEvent(__ePAUIList2EventType_LuaChangeContent, "PaGlobalFunc_BlackSpiritSkillLock_All_ListUpdate")
  self._ui.list2_skill:createChildContent(__ePAUIList2ElementManagerType_List)
  if false == self._isConsole then
    self._ui.chk_lockAll:addInputEvent("Mouse_LUp", "HandleEventLUp_BlackSpiritSkillLock_All_LockAll()")
    self._ui_pc.btn_close:addInputEvent("Mouse_LUp", "PaGlobalFunc_BlackSpiritSkillLock_All_Close()")
  else
    Panel_Window_BlackSpiritSkillLock_All:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "HandleEventLUp_BlackSpiritSkillLock_All_LockAll()")
  end
end
function PaGlobal_BlackSpiritSkillLock_All:validate()
  if nil == Panel_Window_BlackSpiritSkillLock_All then
    return
  end
end
function PaGlobal_BlackSpiritSkillLock_All:resize(openType)
  if nil == Panel_Window_BlackSpiritSkillLock_All then
    return
  end
  if self._OPEN_TYPE.BLACKSPIRIT == openType then
    Panel_Window_BlackSpiritSkillLock_All:SetPosX(math.min(Panel_Adrenallin:GetPosX() + Panel_Adrenallin:GetSizeX() + 20, getScreenSizeX() - Panel_Window_BlackSpiritSkillLock_All:GetSizeX()))
    Panel_Window_BlackSpiritSkillLock_All:SetPosY(math.max(0, Panel_Adrenallin:GetPosY() + Panel_Adrenallin:GetSizeY() - Panel_Window_BlackSpiritSkillLock_All:GetSizeY()))
  elseif self._OPEN_TYPE.REMASTER_BLACKSPIRIT == openType then
    Panel_Window_BlackSpiritSkillLock_All:SetPosX(80)
    Panel_Window_BlackSpiritSkillLock_All:SetPosY(140)
  elseif self._OPEN_TYPE.SKILLWINDOW == openType then
    if false == _ContentsGroup_UISkillGroupTreeLayOut then
      if getScreenSizeX() < Panel_Window_Skill:GetPosX() + Panel_Window_Skill:GetSizeX() + Panel_Window_BlackSpiritSkillLock_All:GetSizeX() then
        Panel_Window_BlackSpiritSkillLock_All:SetPosX(Panel_Window_Skill:GetPosX() - Panel_Window_BlackSpiritSkillLock_All:GetSizeX())
      else
        Panel_Window_BlackSpiritSkillLock_All:SetPosX(Panel_Window_Skill:GetPosX() + Panel_Window_Skill:GetSizeX())
      end
      Panel_Window_BlackSpiritSkillLock_All:SetPosY(Panel_Window_Skill:GetPosY())
    elseif false == Panel_SkillGroup_CoolTimeSlot:GetShow() then
      local screenY = getScreenSizeY()
      Panel_Window_BlackSpiritSkillLock_All:SetPosX(75)
      Panel_Window_BlackSpiritSkillLock_All:SetPosY((screenY - Panel_Window_BlackSpiritSkillLock_All:GetSizeY()) / 2 - 50)
    else
      local posX = Panel_SkillGroup_CoolTimeSlot:GetPosX() - Panel_Window_BlackSpiritSkillLock_All:GetSizeX() - 10
      local posY = Panel_SkillGroup_CoolTimeSlot:GetPosY()
      Panel_Window_BlackSpiritSkillLock_All:SetPosX(posX)
      Panel_Window_BlackSpiritSkillLock_All:SetPosY(posY)
    end
  elseif self._OPEN_TYPE.CONSOLE == openType then
    local screenX = getScreenSizeX()
    local screenY = getScreenSizeY()
    Panel_Window_BlackSpiritSkillLock_All:SetPosX(screenX / 2 - Panel_Window_BlackSpiritSkillLock_All:GetSizeX() / 2)
    Panel_Window_BlackSpiritSkillLock_All:SetPosY(screenY / 2 - Panel_Window_BlackSpiritSkillLock_All:GetSizeY() / 2 - 100)
  end
  local textSizeY = self._ui.txt_desc:GetTextSizeY() + 5
  if textSizeY > self._uiSize.descBgY then
    local addSizeY = textSizeY - self._uiSize.descBgY
    Panel_Window_BlackSpiritSkillLock_All:SetSize(Panel_Window_BlackSpiritSkillLock_All:GetSizeX(), self._uiSize.panelY + addSizeY)
    self._ui.txt_desc:SetSize(self._ui.txt_desc:GetSizeX(), self._uiSize.descBgY + addSizeY)
    self._ui.txt_desc:SetText(self._ui.txt_desc:GetText())
    self._ui.stc_descBG:SetSize(self._ui.stc_descBG:GetSizeX(), self._uiSize.descBgY + addSizeY)
    self._ui.stc_descBG:ComputePos()
    self._ui.txt_desc:ComputePos()
  end
  if true == self._isConsole then
    self._ui_console.stc_bottomGuideBg:ComputePos()
    local keyGuideList = {
      self._ui_console.stc_guideY,
      self._ui_console.stc_guideA,
      self._ui_console.stc_guideB
    }
    PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyGuideList, self._ui_console.stc_bottomGuideBg, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_AUTO_WRAP_LEFT)
  end
end
function PaGlobal_BlackSpiritSkillLock_All:setSkill()
  if nil == Panel_Window_BlackSpiritSkillLock_All then
    return
  end
  if true == self._isConsole then
    PaGlobalFunc_Skill_UpdateForBlackSpiritLock()
  end
  local num = ToClient_BlackSkillCount(self._classType)
  local count = 0
  for idx = 0, num - 1 do
    local skillWrapper = ToClient_GetBlackSkillWrapper(self._classType, idx)
    if nil ~= skillWrapper then
      local skillNo = skillWrapper:getSkillNo()
      local skillLevelInfo = getSkillLevelInfo(skillNo)
      if true == skillLevelInfo._usable and true == skillWrapper:isUseableActiveSkill() then
        local blackSkillNo = skillWrapper:getlinkBlackSkillNo()
        local isPushSkill = false
        if true == self._isConsole then
          if true == PaGlobalFunc_Skill_CheckIsBlackSkill(skillNo, blackSkillNo) then
            isPushSkill = true
          end
        else
          local blackSkillTypeSS = getSkillTypeStaticStatus(blackSkillNo)
          if nil ~= blackSkillTypeSS and blackSkillTypeSS:isValidLocalizing() then
            isPushSkill = true
          end
        end
        if true == isPushSkill then
          self._sortByRage[count + 1] = {
            index = idx,
            rage = skillWrapper:getNeedAdPoint() / 100
          }
          count = count + 1
        end
      end
    end
  end
  self._skillCount = count
  self._numsLocked = 0
  self._ui.list2_skill:getElementManager():clearKey()
  for idx = 0, count - 1 do
    self._ui.list2_skill:getElementManager():pushKey(toInt64(0, idx))
  end
end
function PaGlobal_BlackSpiritSkillLock_All:listUpdate(content, key)
  if nil == Panel_Window_BlackSpiritSkillLock_All then
    return
  end
  local key32 = Int64toInt32(key)
  local stc_bg = UI.getChildControl(content, "Static_Bg")
  local stc_icon = UI.getChildControl(content, "Static_SkillIcon")
  local txt_name = UI.getChildControl(content, "StaticText_SkillName")
  local txt_percent = UI.getChildControl(content, "StaticText_Percent")
  local chk_lock = UI.getChildControl(content, "CheckButton_Lock")
  local data = self._sortByRage[key32 + 1]
  local skillWrapper = ToClient_GetBlackSkillWrapper(self._classType, data.index)
  if nil ~= skillWrapper then
    local skillNo = skillWrapper:getSkillNo()
    local skillLevelInfo = getSkillLevelInfo(skillNo)
    local skillKey = skillLevelInfo._skillKey
    local skillTypeSSW = skillWrapper:getSkillTypeStaticStatusWrapper()
    local isLock = ToClient_isBlockBlackSpiritSkill(skillKey)
    local paColor = "<PAColor0xffddc39e>"
    if isLock then
      paColor = "<PAColor0xFF5A5A5A>"
      self:setCheckAllLocked(true)
    else
      self:setCheckAllLocked(false)
    end
    stc_icon:ChangeTextureInfoName("icon/" .. skillTypeSSW:getIconPath())
    txt_name:SetText(paColor .. skillWrapper:getName() .. "<PAOldColor>")
    txt_percent:SetText(paColor .. PAGetStringParam1(Defines.StringSheet_GAME, "LUA_BLACKSPIRITLOCK_RAGEDESC", "rageValue", data.rage) .. "<PAOldColor>")
    chk_lock:SetCheck(isLock)
    if false == self._isConsole then
      stc_bg:addInputEvent("Mouse_LUp", "HandleEventLUp_BlackSpiritSkillLock_All_LockTarget(" .. skillNo .. ", " .. key32 .. ")")
      stc_icon:addInputEvent("Mouse_LUp", "HandleEventLUp_BlackSpiritSkillLock_All_LockTarget(" .. skillNo .. ", " .. key32 .. ")")
      stc_icon:addInputEvent("Mouse_On", "HandleEventOnOut_BlackSpiritSkillLock_All_Tooltip(true," .. skillNo .. ")")
      stc_icon:addInputEvent("Mouse_Out", "HandleEventOnOut_BlackSpiritSkillLock_All_Tooltip(false)")
    else
      stc_bg:registerPadEvent(__eConsoleUIPadEvent_Up_A, "HandleEventLUp_BlackSpiritSkillLock_All_LockTarget(" .. skillNo .. ", " .. key32 .. ")")
      stc_icon:registerPadEvent(__eConsoleUIPadEvent_Up_A, "HandleEventLUp_BlackSpiritSkillLock_All_LockTarget(" .. skillNo .. ", " .. key32 .. ")")
    end
  end
end
function PaGlobal_BlackSpiritSkillLock_All:lockSkillTarget(skillNo, index)
  local skillLevelInfo = getSkillLevelInfo(skillNo)
  local skillTypeStaticWrapper = getSkillTypeStaticStatus(skillNo)
  local skillName = skillTypeStaticWrapper:getName()
  if nil ~= skillLevelInfo then
    local isBlockSkill = ToClient_isBlockBlackSpiritSkill(skillLevelInfo._skillKey)
    if isBlockSkill then
      self:setCheckAllLocked(false)
      ToClient_enableblockBlackSpiritSkill(skillLevelInfo._skillKey)
      Proc_ShowMessage_Ack(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_BLACKSPIRITLOCK_UNLOCKSKILL", "skillName", skillName), nil, nil, nil, true)
    else
      self:setCheckAllLocked(true)
      ToClient_blockBlackSpiritSkill(skillLevelInfo._skillKey)
      Proc_ShowMessage_Ack(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_BLACKSPIRITLOCK_LOCKSKILL", "skillName", skillName), nil, nil, nil, true)
    end
  end
  PaGlobal_BlackSpiritSkillLock_All._ui.list2_skill:requestUpdateByKey(toInt64(0, index))
  audioPostEvent_SystemUi(1, 46)
end
function PaGlobal_BlackSpiritSkillLock_All:lockSkillAll()
  if true == self._isConsole then
    self._ui.chk_lockAll:SetCheck(not self._ui.chk_lockAll:IsCheck())
  end
  local isCheck = self._ui.chk_lockAll:IsCheck()
  local num = ToClient_BlackSkillCount(self._classType)
  local count = 0
  for index = 0, num - 1 do
    local skillWrapper = ToClient_GetBlackSkillWrapper(self._classType, index)
    if nil ~= skillWrapper then
      local skillNo = skillWrapper:getSkillNo()
      local skillLevelInfo = getSkillLevelInfo(skillNo)
      local skillKey = skillLevelInfo._skillKey
      local blackSkillNo = skillWrapper:getlinkBlackSkillNo()
      if skillLevelInfo._usable and skillWrapper:isUseableActiveSkill() then
        local blackSkillNo = skillWrapper:getlinkBlackSkillNo()
        local isPushSkill = false
        if true == self._isConsole then
          if true == PaGlobalFunc_Skill_CheckIsBlackSkill(skillNo, blackSkillNo) then
            isPushSkill = true
          end
        else
          local blackSkillTypeSS = getSkillTypeStaticStatus(blackSkillNo)
          if nil ~= blackSkillTypeSS and blackSkillTypeSS:isValidLocalizing() then
            isPushSkill = true
          end
        end
        if true == isPushSkill then
          if isCheck then
            ToClient_blockBlackSpiritSkill(skillKey)
          else
            ToClient_enableblockBlackSpiritSkill(skillKey)
          end
          count = count + 1
        end
      end
    end
  end
  self._skillCount = count
  self._numsLocked = 0
  self._ui.list2_skill:getElementManager():clearKey()
  for index = 0, count - 1 do
    self._ui.list2_skill:getElementManager():pushKey(toInt64(0, index))
  end
  if isCheck then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_BLACKSPIRITLOCK_ALLLOCKSKILL"), nil, nil, nil, true)
  else
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_BLACKSPIRITLOCK_ALLUNLOCKSKILL"), nil, nil, nil, true)
  end
  audioPostEvent_SystemUi(1, 46)
end
function PaGlobal_BlackSpiritSkillLock_All:setCheckAllLocked(islock)
  if true == islock then
    self._numsLocked = self._numsLocked + 1
  else
    self._numsLocked = self._numsLocked - 1
  end
  if self._numsLocked == self._skillCount then
    self._ui.chk_lockAll:SetCheck(true)
  else
    self._ui.chk_lockAll:SetCheck(false)
  end
end
