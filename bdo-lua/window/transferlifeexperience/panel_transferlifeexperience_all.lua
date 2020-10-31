PaGlobal_TransferLifeExp_All = {
  _ui = {
    stc_TitleBg = nil,
    txt_Title = nil,
    btn_Close = nil,
    btn_Question = nil,
    stc_SubBg = nil,
    stc_Top = nil,
    txt_FromName = nil,
    txt_FromLifeValue = nil,
    stc_BottomBg = nil,
    txt_ChooseDesc = nil,
    list2_Characters = nil,
    stc_BottomSubBg = nil,
    txt_desc = nil,
    btn_Confirm = nil,
    btn_Cancel = nil,
    stc_Bottom_Keyguides = nil,
    stc_KeyGuide_A = nil,
    stc_KeyGuide_B = nil
  },
  _transferItemData = {
    where = nil,
    slotIdx = nil,
    lifeType = nil
  },
  _STRINGTABLE = {
    _lifeExpTitle = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_TRANSFERLIFEXPERIENCE_TITLE"),
    _lifeExpDesc = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_LIFEEXP_DESC"),
    _battleExpTitle = PAGetString(Defines.StringSheet_GAME, "LUA_TRANSFERLIFEEXPERIENCE_TITLE"),
    _battleExpDesc = PAGetString(Defines.StringSheet_GAME, "LUA_TRANSFERBATTLEEXPERIENCE_NOTIFY"),
    lifeType = {
      [0] = PAGetString(Defines.StringSheet_GAME, "LUA_CHARACTERINFO_LIFE0"),
      [1] = PAGetString(Defines.StringSheet_GAME, "LUA_CHARACTERINFO_LIFE1"),
      [2] = PAGetString(Defines.StringSheet_GAME, "LUA_CHARACTERINFO_LIFE2"),
      [3] = PAGetString(Defines.StringSheet_GAME, "LUA_CHARACTERINFO_LIFE3"),
      [4] = PAGetString(Defines.StringSheet_GAME, "LUA_CHARACTERINFO_LIFE4"),
      [5] = PAGetString(Defines.StringSheet_GAME, "LUA_CHARACTERINFO_LIFE5"),
      [6] = PAGetString(Defines.StringSheet_GAME, "LUA_CHARACTERINFO_LIFE6"),
      [7] = PAGetString(Defines.StringSheet_GAME, "LUA_CHARACTERINFO_LIFE7"),
      [8] = PAGetString(Defines.StringSheet_GAME, "LUA_CHARACTERINFO_LIFE8"),
      [9] = PAGetString(Defines.StringSheet_GAME, "LUA_CHARACTERINFO_LIFE9"),
      [10] = PAGetString(Defines.StringSheet_GAME, "LUA_CHARACTERINFO_LIFE10"),
      [11] = PAGetString(Defines.StringSheet_GAME, "LUA_CHARACTERINFO_LIFE11"),
      [12] = PAGetString(Defines.StringSheet_GAME, "LUA_CHARACTERINFO_LIFE12"),
      [13] = PAGetString(Defines.StringSheet_GAME, "LUA_CHARACTERINFO_LIFE13"),
      [14] = PAGetString(Defines.StringSheet_GAME, "LUA_CHARACTERINFO_LIFE14")
    }
  },
  _currentCharacter64 = nil,
  _selectedCharacterIdx = nil,
  _currentCharacterLifeData = {_name = "", _lifeLevel = 0},
  _initialize = false,
  _isConsole = false
}
function PaGlobal_TransferLifeExp_All_Init()
  PaGlobal_TransferLifeExp_All:initailze()
end
registerEvent("FromClient_luaLoadComplete", "PaGlobal_TransferLifeExp_All_Init")
function PaGlobal_TransferLifeExp_All:initailze()
  if true == PaGlobal_TransferLifeExp_All._initialize then
    return
  end
  self._ui.stc_TitleBg = UI.getChildControl(Panel_TransferLifeExperience_All, "Static_TitleBg")
  self._ui.txt_Title = UI.getChildControl(self._ui.stc_TitleBg, "StaticText_Title")
  self._ui.btn_Close = UI.getChildControl(self._ui.stc_TitleBg, "Button_Win_Close")
  self._ui.btn_Question = UI.getChildControl(self._ui.stc_TitleBg, "Button_Win_Close")
  self._ui.stc_SubBg = UI.getChildControl(Panel_TransferLifeExperience_All, "Static_SubBG")
  self._ui.stc_Top = UI.getChildControl(Panel_TransferLifeExperience_All, "Static_Top")
  self._ui.txt_FromName = UI.getChildControl(self._ui.stc_Top, "StaticText_CharacterName")
  self._ui.txt_FromLifeValue = UI.getChildControl(self._ui.stc_Top, "StaticText_LifeExpValue")
  self._ui.stc_BottomBg = UI.getChildControl(Panel_TransferLifeExperience_All, "Static_RightBg")
  self._ui.txt_ChooseDesc = UI.getChildControl(self._ui.stc_BottomBg, "StaticText_SelectCharacterDesc")
  self._ui.list2_Characters = UI.getChildControl(self._ui.stc_BottomBg, "List2_Character")
  self._ui.stc_BottomSubBg = UI.getChildControl(Panel_TransferLifeExperience_All, "Static_SubBGUnder")
  self._ui.txt_desc = UI.getChildControl(self._ui.stc_BottomSubBg, "StaticText_Desc")
  self._ui.btn_Confirm = UI.getChildControl(Panel_TransferLifeExperience_All, "Button_Confirm_PCUI")
  self._ui.btn_Cancel = UI.getChildControl(Panel_TransferLifeExperience_All, "Button_Cancel_PCUI")
  self._ui.stc_Bottom_Keyguides = UI.getChildControl(Panel_TransferLifeExperience_All, "Static_BottomBg_ConsoleUI")
  self._ui.stc_KeyGuide_A = UI.getChildControl(self._ui.stc_Bottom_Keyguides, "StaticText_A_ConsoleUI")
  self._ui.stc_KeyGuide_B = UI.getChildControl(self._ui.stc_Bottom_Keyguides, "StaticText_B_ConsoleUI")
  self._isConsole = _ContentsGroup_UsePadSnapping
  PaGlobal_TransferLifeExp_All:validate()
  PaGlobal_TransferLifeExp_All:SwitchPlatform(self._isConsole)
  PaGlobal_TransferLifeExp_All:registEventHandler(self._isConsole)
end
function PaGlobal_TransferLifeExp_All:validate()
  if true == PaGlobal_TransferLifeExp_All._initialize then
    return
  end
  self._ui.stc_TitleBg:isValidate()
  self._ui.txt_Title:isValidate()
  self._ui.btn_Close:isValidate()
  self._ui.btn_Question:isValidate()
  self._ui.stc_SubBg:isValidate()
  self._ui.stc_Top:isValidate()
  self._ui.txt_FromName:isValidate()
  self._ui.txt_FromLifeValue:isValidate()
  self._ui.stc_BottomBg:isValidate()
  self._ui.txt_ChooseDesc:isValidate()
  self._ui.list2_Characters:isValidate()
  self._ui.stc_BottomSubBg:isValidate()
  self._ui.txt_desc:isValidate()
  self._ui.btn_Confirm:isValidate()
  self._ui.btn_Cancel:isValidate()
  self._ui.stc_Bottom_Keyguides:isValidate()
  self._ui.stc_KeyGuide_A:isValidate()
  self._ui.stc_KeyGuide_B:isValidate()
  PaGlobal_TransferLifeExp_All._initialize = true
end
function PaGlobal_TransferLifeExp_All:SwitchPlatform(isConsole)
  self._ui.stc_Bottom_Keyguides:SetShow(isConsole)
  self._ui.stc_KeyGuide_B:SetShow(isConsole)
  self._ui.stc_KeyGuide_A:SetShow(isConsole)
  self._ui.btn_Confirm:SetShow(not isConsole)
  self._ui.btn_Cancel:SetShow(not isConsole)
  self._ui.btn_Close:SetShow(not isConsole)
  if true == isConsole then
    local btnSizeY = self._ui.btn_Confirm:GetSizeY() + self._ui.btn_Confirm:GetSpanSize().y
    local panel = Panel_TransferLifeExperience_All
    panel:SetSize(panel:GetSizeX(), panel:GetSizeY() - btnSizeY)
    self._ui.stc_SubBg:SetSize(self._ui.stc_SubBg:GetSizeX(), self._ui.stc_SubBg:GetSizeY() - btnSizeY)
    local keyGuides = {
      self._ui.stc_KeyGuide_A,
      self._ui.stc_KeyGuide_B
    }
    PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyGuides, self._ui.stc_Bottom_Keyguides, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHT)
    self._ui.stc_Bottom_Keyguides:ComputePos()
  end
end
function PaGlobal_TransferLifeExp_All:registEventHandler(isConsole)
  Panel_TransferLifeExperience_All:RegisterShowEventFunc(true, "PaGlobalFunc_TransferLifeExp_All_SetAni( true )")
  Panel_TransferLifeExperience_All:RegisterShowEventFunc(false, "PaGlobalFunc_TransferLifeExp_All_SetAni( false )")
  registerEvent("FromClient_RequestUseTransferLifeExperience", "FromClient_RequestUseTransferLifeExperience")
  registerEvent("FromClient_TransferLifeExperience", "FromClient_TransferLifeExperience")
  registerEvent("FromClient_RequestUseExchangeBattleAndSkillExp", "FromClient_RequestUseExchangeBattleAndSkillExp")
  registerEvent("FromClient_ResponseExchangeBattleAndSkillExp", "FromClient_ResponseExchangeBattleAndSkillExp")
  registerEvent("onScreenResize", "FromClient_TransferLifeExp_All_OnScreenResize")
  self._ui.list2_Characters:registEvent(__ePAUIList2EventType_LuaChangeContent, "FromClient_TransferLifeExp_ALL_UpdateContent")
  self._ui.list2_Characters:createChildContent(__ePAUIList2ElementManagerType_List)
  if false == isConsole then
    self._ui.btn_Close:addInputEvent("Mouse_LUp", "HandleEventLUp_TransferLifeExp_All_Close()")
    self._ui.btn_Cancel:addInputEvent("Mouse_LUp", "HandleEventLUp_TransferLifeExp_All_Close()")
  end
end
function PaGlobal_TransferLifeExp_All:prepareOpen()
  PaGlobal_TransferLifeExp_All:dataClear()
  PaGlobal_TransferLifeExp_All:open()
  FromClient_TransferLifeExp_All_OnScreenResize()
  PaGlobal_TransferLifeExp_All:update()
end
function PaGlobal_TransferLifeExp_All:open()
  if true == Panel_TransferLifeExperience_All:GetShow() then
    return
  end
  Panel_TransferLifeExperience_All:SetShow(true)
end
function PaGlobal_TransferLifeExp_All:update()
  local characterSize = getCharacterDataCount()
  if characterSize < 0 or nil == characterSize then
    return
  end
  if nil == getSelfPlayer() then
    return
  end
  local myName = getSelfPlayer():getOriginalName()
  self._ui.txt_FromName:SetText(myName)
  self._currentCharacterLifeData.name = myName
  if nil ~= self._transferItemData.lifeType then
    local playerGetter = getSelfPlayer():get()
    local lifeType = self._transferItemData.lifeType
    local gatherLevel = playerGetter:getLifeExperienceLevel(lifeType)
    local gatherCurrentExp = playerGetter:getCurrLifeExperiencePoint(lifeType)
    local gatherMaxExp = playerGetter:getDemandLifeExperiencePoint(lifeType)
    local gatherExpRate = Int64toInt32(gatherCurrentExp * toInt64(0, 100) / gatherMaxExp)
    local lifeGrade = PaGlobal_TransferLifeExp_All:LifeLevelToString(gatherLevel, lifeType, gatherExpRate)
    local lifelvText = self._STRINGTABLE.lifeType[lifeType] .. " " .. lifeGrade
    self._ui.txt_FromLifeValue:SetText(lifelvText)
    self._currentCharacterLifeData._lifeLevel = lifeGrade
  else
    self._ui.txt_FromLifeValue:SetText("")
  end
  self._currentCharacter64 = getSelfPlayer():getCharacterNo_64()
  self._ui.list2_Characters:getElementManager():clearKey()
  for idx = 0, characterSize do
    local characterData = getCharacterDataByIndex(idx)
    if nil ~= characterData then
      self._ui.list2_Characters:getElementManager():pushKey(toInt64(0, idx))
    end
  end
  self._ui.btn_Confirm:addInputEvent("Mouse_LUp", "")
  if nil == self._transferItemData.lifeType then
    self._ui.txt_Title:SetText(self._STRINGTABLE._battleExpTitle)
    self._ui.txt_desc:SetText(self._STRINGTABLE._battleExpDesc)
    if false == self._isConsole then
      self._ui.btn_Confirm:addInputEvent("Mouse_LUp", "HandleEventLUp_TransferLifeExp_All_ConfirmTransfer(1)")
    end
  else
    self._ui.txt_Title:SetText(self._STRINGTABLE._lifeExpTitle)
    self._ui.txt_desc:SetText(self._STRINGTABLE._lifeExpDesc)
    if false == self._isConsole then
      self._ui.btn_Confirm:addInputEvent("Mouse_LUp", "HandleEventLUp_TransferLifeExp_All_ConfirmTransfer(0)")
    end
  end
  local descControlSize = self._ui.txt_desc:GetSizeX()
  local txtSize = self._ui.txt_desc:GetTextSizeX()
  if descControlSize < txtSize then
    self._ui.txt_desc:SetTextMode(__eTextMode_AutoWrap)
    self._ui.txt_desc:SetText(self._ui.txt_desc:GetText())
  end
end
function PaGlobal_TransferLifeExp_All:dataClear()
  self._currentCharacter64 = nil
  self._selectedCharacterIdx = nil
  self._transferType.where = nil
  self._transferType.slotIdx = nil
  self._transferType.lifeType = nil
  self._currentCharacterLifeData.name = ""
  self._currentCharacterLifeData._lifeLevel = 0
end
function PaGlobal_TransferLifeExp_All:prepareClose()
  PaGlobal_TransferLifeExp_All:dataClear()
  PaGlobal_TransferLifeExp_All:close()
end
function PaGlobal_TransferLifeExp_All:close()
  Panel_TransferLifeExperience_All:SetShow(false)
end
function PaGlobal_TransferLifeExp_All:LifeLevelToString(lev, lifeType, lifeExp)
  if 1 <= lev and lev <= 10 then
    lev = "<PAColor0xFFC4C4C4>" .. PAGetString(Defines.StringSheet_GAME, "LUA_CHARACTERINFO_CRAFTLEVEL_GROUP_1") .. lev .. " " .. lifeExp .. "%<PAOldColor>"
  elseif 11 <= lev and lev <= 20 then
    lev = "<PAColor0xFF76B24D>" .. PAGetString(Defines.StringSheet_GAME, "LUA_CHARACTERINFO_CRAFTLEVEL_GROUP_2") .. lev - 10 .. " " .. lifeExp .. "%<PAOldColor>"
  elseif 21 <= lev and lev <= 30 then
    lev = "<PAColor0xFF3B8BBE>" .. PAGetString(Defines.StringSheet_GAME, "LUA_CHARACTERINFO_CRAFTLEVEL_GROUP_3") .. lev - 20 .. " " .. lifeExp .. "%<PAOldColor>"
  elseif 31 <= lev and lev <= 40 then
    lev = "<PAColor0xFFEBC467>" .. PAGetString(Defines.StringSheet_GAME, "LUA_CHARACTERINFO_CRAFTLEVEL_GROUP_4") .. lev - 30 .. " " .. lifeExp .. "%<PAOldColor>"
  elseif 41 <= lev and lev <= 50 then
    lev = "<PAColor0xFFD04D47>" .. PAGetString(Defines.StringSheet_GAME, "LUA_CHARACTERINFO_CRAFTLEVEL_GROUP_5") .. lev - 40 .. " " .. lifeExp .. "%<PAOldColor>"
  elseif 51 <= lev and lev <= 80 then
    lev = "<PAColor0xFFB23BC7>" .. PAGetString(Defines.StringSheet_GAME, "LUA_CHARACTERINFO_CRAFTLEVEL_GROUP_6") .. lev - 50 .. " " .. lifeExp .. "%<PAOldColor>"
  elseif 81 <= lev and lev <= 130 then
    lev = "<PAColor0xFFC78045>" .. PAGetString(Defines.StringSheet_GAME, "LUA_CHARACTERINFO_CRAFTLEVEL_GROUP_7") .. lev - 80 .. " " .. lifeExp .. "%<PAOldColor>"
  end
  return lev
end
function PaGlobal_TransferLifeExp_All:changeTexture_Class(control, classType)
  control:ChangeTextureInfoName("Combine/Icon/Combine_Class_Icon_00.dds")
  local x1, y1, x2, y2 = 0, 0, 0, 0
  if classType == __eClassType_Warrior then
    x1, y1, x2, y2 = setTextureUV_Func(control, 1, 1, 51, 51)
  elseif classType == __eClassType_ElfRanger then
    x1, y1, x2, y2 = setTextureUV_Func(control, 52, 1, 102, 51)
  elseif classType == __eClassType_Sorcerer then
    x1, y1, x2, y2 = setTextureUV_Func(control, 103, 1, 153, 51)
  elseif classType == __eClassType_Giant then
    x1, y1, x2, y2 = setTextureUV_Func(control, 154, 1, 204, 54)
  elseif classType == __eClassType_Tamer then
    x1, y1, x2, y2 = setTextureUV_Func(control, 205, 1, 255, 51)
  elseif classType == __eClassType_BladeMaster then
    x1, y1, x2, y2 = setTextureUV_Func(control, 256, 1, 306, 51)
  elseif classType == __eClassType_BladeMasterWoman then
    x1, y1, x2, y2 = setTextureUV_Func(control, 358, 1, 408, 51)
  elseif classType == __eClassType_Valkyrie then
    x1, y1, x2, y2 = setTextureUV_Func(control, 307, 1, 357, 51)
  elseif classType == __eClassType_WizardMan then
    x1, y1, x2, y2 = setTextureUV_Func(control, 409, 1, 459, 51)
  elseif classType == __eClassType_WizardWoman then
    x1, y1, x2, y2 = setTextureUV_Func(control, 460, 1, 510, 51)
  elseif classType == __eClassType_Kunoichi then
    x1, y1, x2, y2 = setTextureUV_Func(control, 1, 52, 51, 102)
  elseif classType == __eClassType_NinjaMan then
    x1, y1, x2, y2 = setTextureUV_Func(control, 52, 52, 102, 102)
  elseif classType == __eClassType_DarkElf then
    x1, y1, x2, y2 = setTextureUV_Func(control, 103, 52, 153, 102)
  elseif classType == __eClassType_Combattant then
    x1, y1, x2, y2 = setTextureUV_Func(control, 154, 52, 204, 102)
  elseif classType == __eClassType_Mystic then
    x1, y1, x2, y2 = setTextureUV_Func(control, 205, 52, 255, 102)
  elseif classType == __eClassType_Lhan then
    x1, y1, x2, y2 = setTextureUV_Func(control, 256, 52, 306, 102)
  elseif classType == __eClassType_RangerMan then
    x1, y1, x2, y2 = setTextureUV_Func(control, 307, 52, 357, 102)
  elseif classType == __eClassType_ShyWaman then
    x1, y1, x2, y2 = setTextureUV_Func(control, 1, 103, 51, 153)
  elseif classType == __eClassType_Guardian then
    x1, y1, x2, y2 = setTextureUV_Func(control, 52, 103, 102, 153)
  elseif classType == __eClassType_Hashashin then
    x1, y1, x2, y2 = setTextureUV_Func(control, 103, 103, 153, 153)
  end
  control:getBaseTexture():setUV(x1, y1, x2, y2)
  control:setRenderTexture(control:getBaseTexture())
end
function HandleEventLUp_TransferLifeExp_All_Close()
  if false == Panel_TransferLifeExperience_All:GetShow() then
    return
  end
  PaGlobal_TransferLifeExp_All:prepareClose()
end
function HandleEventLUp_TransferLifeExp_All_SelectCharacter(idx)
  if nil == idx then
    return
  end
  PaGlobal_TransferLifeExp_All._selectedCharacterIdx = idx
  if true == PaGlobal_TransferLifeExp_All._isConsole then
    if nil == PaGlobal_TransferLifeExp_All._transferItemData.lifeType then
      HandleEventLUp_TransferLifeExp_All_ConfirmTransfer(1)
    else
      HandleEventLUp_TransferLifeExp_All_ConfirmTransfer(0)
    end
  end
end
function HandleEventLUp_TransferLifeExp_All_ConfirmTransfer(_transferType)
  if nil == PaGlobal_TransferLifeExp_All._selectedCharacterIdx then
    return
  end
  local PALifeExp = PaGlobal_TransferLifeExp_All
  local selIdx = PALifeExp._selectedCharacterIdx
  if nil == PALifeExp._transferItemData.where or nil == PALifeExp._transferItemData.slotIdx or nil == PALifeExp._selectedCharacterIdx then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_TRANSFERLIFEEXPERIENCE_WRONGVALUE"))
    return
  end
  if 0 == _transferType then
    if nil == PALifeExp._transferItemData.lifeType then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_TRANSFERLIFEEXPERIENCE_WRONGVALUE"))
      return
    end
    local function lifeTransferConfirm()
      ToClient_requestTransferLifeExperience(PALifeExp._transferItemData.where, PALifeExp._transferItemData.slotIdx, PALifeExp._transferItemData.lifeType, selIdx)
    end
    local myName = PALifeExp._currentCharacterLifeData.name
    local lifeExp = PALifeExp._currentCharacterLifeData._lifeLevel
    local lifeType = PALifeExp._STRINGTABLE.lifeType[PALifeExp._transferItemData.lifeType]
    local selectedCharacterData = getCharacterDataByIndex(PALifeExp._selectedCharacterIdx)
    local selectedCharacterName = getCharacterName(selectedCharacterData)
    local _title = PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_ALERT_NOTIFICATIONS")
    local _desc = PAGetStringParam4(Defines.StringSheet_GAME, "LUA_WINDOW_TRANSFERLIFEEXPALL_CONFIRM", "from", myName, "lifeType", lifeType, "lifeExp", lifeExp, "to", selectedCharacterName)
    local _confirmFunction = lifeTransferConfirm
    local _cancel = MessageBox_Empty_function
    local _priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    messageboxData = {
      title = _title,
      content = _desc,
      functionYes = _confirmFunction,
      functionNo = _cancel,
      priority = _priority
    }
    MessageBox.showMessageBox(messageboxData)
  elseif 1 == _transferType then
    if nil ~= PALifeExp._transferItemData.lifeType then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_TRANSFERLIFEEXPERIENCE_WRONGVALUE"))
      return
    end
    ToClient_requestExchangeBattleAndSkillExp(PALifeExp._transferItemData.where, PALifeExp._transferItemData.slotIdx, selIdx)
  end
end
function PaGlobalFunc_TransferLifeExp_All_SetAni(isShow)
  if true == isShow then
    Panel_TransferLifeExperience_All:SetAlpha(0)
    UIAni.AlphaAnimation(1, Panel_TransferLifeExperience_All, 0, 0.15)
    local aniInfo1 = Panel_TransferLifeExperience_All:addScaleAnimation(0, 0.15, UI_ANI_ADV.PAUI_ANIM_ADVANCE_COS_HALF_PI)
    aniInfo1:SetStartScale(1.5)
    aniInfo1:SetEndScale(0.8)
    aniInfo1.AxisX = Panel_TransferLifeExperience_All:GetSizeX() / 2
    aniInfo1.AxisY = Panel_TransferLifeExperience_All:GetSizeY() / 2
    aniInfo1.ScaleType = 0
    aniInfo1.IsChangeChild = true
    local aniInfo2 = Panel_TransferLifeExperience_All:addScaleAnimation(0.15, 0.2, UI_ANI_ADV.PAUI_ANIM_ADVANCE_COS_HALF_PI)
    aniInfo2:SetStartScale(0.8)
    aniInfo2:SetEndScale(1)
    aniInfo2.AxisX = Panel_TransferLifeExperience_All:GetSizeX() / 2
    aniInfo2.AxisY = Panel_TransferLifeExperience_All:GetSizeY() / 2
    aniInfo2.ScaleType = 0
    aniInfo2.IsChangeChild = true
  else
    Panel_TransferLifeExperience_All:SetAlpha(1)
    local aniInfo = UIAni.AlphaAnimation(0, Panel_TransferLifeExperience_All, 0, 0.1)
    aniInfo:SetHideAtEnd(true)
  end
end
function FromClient_RequestUseTransferLifeExperience(fromWhereType, fromSlotNo, lifeType)
  if 1 == lifeType then
    local itemWrapper = ToClient_getEquipmentItem(0)
    if itemWrapper ~= nil then
      local itemSSW = itemWrapper:getStaticStatus()
      if itemEquipType_FishingRod == itemSSW:getEquipType() then
        Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_TRANSFER_LIFE_CANTUSE_EQUIPFISHINGITEM"))
        return
      end
    end
  end
  if nil ~= ToClient_getEquipmentItem(2) then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_TRANSFER_LIFE_CANTUSE_EQUIPLIFEITEM"))
    return
  end
  PaGlobal_TransferLifeExp_All._transferItemData.where = fromWhereType
  PaGlobal_TransferLifeExp_All._transferItemData.slotIdx = fromSlotNo
  PaGlobal_TransferLifeExp_All._transferItemData.lifeType = lifeType
  PaGlobal_TransferLifeExp_All:prepareOpen()
end
function FromClient_TransferLifeExperience(lifeType)
  Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_TRANSFERLIFEEXPERIENCE_SUCCESS_TRANSFER"))
  HandleEventLUp_TransferLifeExp_All_Close()
end
function FromClient_RequestUseExchangeBattleAndSkillExp(fromWhereType, fromSlotNo)
  PaGlobal_TransferLifeExp_All._transferItemData.where = fromWhereType
  PaGlobal_TransferLifeExp_All._transferItemData.slotIdx = fromSlotNo
  PaGlobal_TransferLifeExp_All._transferItemData.lifeType = nil
  PaGlobal_TransferLifeExp_All:prepareOpen()
end
function FromClient_ResponseExchangeBattleAndSkillExp()
  Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_TRANSFERLIFEEXPERIENCE_SUCCESS_TRANSFER"))
  HandleEventLUp_TransferLifeExp_All_Close()
end
function FromClient_TransferLifeExp_ALL_UpdateContent(content, key)
  if false == Panel_TransferLifeExperience_All:GetShow() then
    return
  end
  local key32 = Int64toInt32(key)
  local rdo_Slot = UI.getChildControl(content, "RadioButton_CharacterSlot")
  local txt_Name = UI.getChildControl(content, "StaticText_CharacterName")
  local icon = UI.getChildControl(content, "Static_ClassTypeIcon")
  icon:ReleaseTexture()
  rdo_Slot:setNotImpactScrollEvent(true)
  content:SetShow(false)
  rdo_Slot:SetCheck(false)
  rdo_Slot:SetEnable(true)
  rdo_Slot:SetMonoTone(false, false)
  txt_Name:SetMonoTone(false, false)
  rdo_Slot:SetIgnore(false)
  local characterData = getCharacterDataByIndex(key32)
  if nil ~= characterData then
    local characterName = getCharacterName(characterData)
    local classType = getCharacterClassType(characterData)
    local characterLevel = string.format("%d", characterData._level)
    if PaGlobal_TransferLifeExp_All._currentCharacter64 == characterData._characterNo_s64 then
      characterName = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_TRANSFERLIFEEXPERIENCE_CHARACTERNAME", "characterName", characterName)
      rdo_Slot:SetEnable(false)
      rdo_Slot:SetIgnore(true)
      rdo_Slot:SetMonoTone(true, true)
      txt_Name:SetMonoTone(true, true)
    end
    if PaGlobal_TransferLifeExp_All._selectedCharacterIdx == key32 then
      rdo_Slot:SetCheck(true)
    end
    txt_Name:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_LV") .. "." .. characterLevel .. " " .. characterName)
    PaGlobal_TransferLifeExp_All:changeTexture_Class(icon, classType)
    icon:SetColor(Defines.Color.C_FFFFEDD4)
    if true == PaGlobal_TransferLifeExp_All._isConsole then
      rdo_Slot:registerPadEvent(__eConsoleUIPadEvent_Up_A, "HandleEventLUp_TransferLifeExp_All_SelectCharacter(" .. key32 .. ")")
    else
      rdo_Slot:addInputEvent("Mouse_LUp", "HandleEventLUp_TransferLifeExp_All_SelectCharacter(" .. key32 .. ")")
    end
    content:SetShow(true)
  end
end
function FromClient_TransferLifeExp_All_OnScreenResize()
  if false == Panel_TransferLifeExperience_All:GetShow() then
    return
  end
  Panel_TransferLifeExperience_All:ComputePos()
end
