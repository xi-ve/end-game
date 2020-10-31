function PaGlobal_BloodAltar_All:initialize()
  if true == PaGlobal_BloodAltar_All._initialize then
    return
  end
  PaGlobal_BloodAltar_All._isConsole = _ContentsGroup_UsePadSnapping
  PaGlobal_BloodAltar_All._ui.stc_TitleBG = UI.getChildControl(Panel_Window_BloodAltar_All, "Static_TitleBG")
  PaGlobal_BloodAltar_All._ui.txt_Title = UI.getChildControl(PaGlobal_BloodAltar_All._ui.stc_TitleBG, "StaticText_Title")
  PaGlobal_BloodAltar_All._ui.btn_PC_Close = UI.getChildControl(PaGlobal_BloodAltar_All._ui.stc_TitleBG, "Button_Win_Close_PCUI")
  PaGlobal_BloodAltar_All._ui.stc_Image = UI.getChildControl(Panel_Window_BloodAltar_All, "Static_Image")
  PaGlobal_BloodAltar_All._ui.stc_DescBG = UI.getChildControl(Panel_Window_BloodAltar_All, "Static_DescBg")
  PaGlobal_BloodAltar_All._ui.txt_Desc = UI.getChildControl(PaGlobal_BloodAltar_All._ui.stc_DescBG, "StaticText_Desc")
  PaGlobal_BloodAltar_All._ui.list_Stage = UI.getChildControl(Panel_Window_BloodAltar_All, "List2_Stage")
  PaGlobal_BloodAltar_All._ui.btn_Start = UI.getChildControl(Panel_Window_BloodAltar_All, "Button_Start")
  PaGlobal_BloodAltar_All._ui.stc_ConsoleKeyGuide = UI.getChildControl(Panel_Window_BloodAltar_All, "Static_BottomBg_ConsoleUI")
  PaGlobal_BloodAltar_All._ui.btn_PC_Close:SetShow(false)
  PaGlobal_BloodAltar_All._ui.stc_ConsoleKeyGuide:SetShow(true == PaGlobal_BloodAltar_All._isConsole)
  PaGlobal_BloodAltar_All._ui.btn_Start:SetShow(false == PaGlobal_BloodAltar_All._isConsole)
  if true == PaGlobal_BloodAltar_All._isConsole then
    PaGlobal_BloodAltar_All._ui.txt_Desc:SetTextMode(__eTextMode_AutoWrap)
    PaGlobal_BloodAltar_All._ui.txt_Desc:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WINDOW_BLOODALTAR_MINOR_DESC"))
    self._ui.stc_ConsoleKeyGuide:ComputePos()
    local confirm = UI.getChildControl(self._ui.stc_ConsoleKeyGuide, "Button_Confirm_ConsoleUI")
    local close = UI.getChildControl(self._ui.stc_ConsoleKeyGuide, "Button_Close_ConsoleUI")
    local partySetting = UI.getChildControl(self._ui.stc_ConsoleKeyGuide, "Button_PartySetting_ConsoleUI")
    local keyGuide = {
      partySetting,
      confirm,
      close
    }
    PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyGuide, self._ui.stc_ConsoleKeyGuide, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHT)
  else
    PaGlobal_BloodAltar_All._ui.txt_Desc:SetTextMode(__eTextMode_AutoWrap)
    PaGlobal_BloodAltar_All._ui.txt_Desc:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WINDOW_BLOODALTAR_DESC"))
  end
  local txtGap = 20
  if self._ui.stc_DescBG:GetSizeY() < self._ui.txt_Desc:GetTextSizeY() then
    local gap = self._ui.txt_Desc:GetTextSizeY() - self._ui.stc_DescBG:GetSizeY() + 15
    self._ui.stc_DescBG:SetSize(self._ui.stc_DescBG:GetSizeX(), self._ui.txt_Desc:GetTextSizeY() + 10)
    self._ui.stc_DescBG:ComputePos()
    self._ui.stc_DescBG:SetPosY(self._ui.stc_DescBG:GetPosY() + gap)
    txtGap = txtGap + math.abs(self._ui.stc_DescBG:GetSizeY() - self._ui.txt_Desc:GetTextSizeY())
  end
  local panelY = self._ui.stc_TitleBG:GetSizeY() + self._ui.stc_Image:GetSizeY() + self._ui.stc_DescBG:GetSizeY() + txtGap
  Panel_Window_BloodAltar_All:SetSize(Panel_Window_BloodAltar_All:GetSizeX(), panelY)
  local content = UI.getChildControl(self._ui.list_Stage, "List2_1_Content")
  local contentCount = math.min(ToClient_GetInstanceFieldScriptUiSize(), 10)
  if contentCount < 10 then
    contentCount = 10
  end
  self._ui.list_Stage:SetSize(self._ui.list_Stage:GetSizeX(), content:GetSizeY() * (contentCount - 1) + 10)
  PaGlobal_BloodAltar_All._ui.btn_Start:ComputePos()
  Panel_Window_BloodAltar_All:ComputePos()
  PaGlobal_BloodAltar_All:registEventHandler()
  PaGlobal_BloodAltar_All:validate()
  PaGlobal_BloodAltar_All._initialize = true
end
function PaGlobal_BloodAltar_All:registEventHandler()
  if nil == Panel_Window_BloodAltar_All then
    return
  end
  if false == PaGlobal_BloodAltar_All._isConsole then
    PaGlobal_BloodAltar_All._ui.btn_Start:addInputEvent("Mouse_LUp", "HandleEventLUp_BloodAltar_StartStage()")
  end
  PaGlobal_BloodAltar_All._ui.list_Stage:registEvent(__ePAUIList2EventType_LuaChangeContent, "PaGlobal_BloodAltar_CreateStageList")
  PaGlobal_BloodAltar_All._ui.list_Stage:createChildContent(__ePAUIList2ElementManagerType_List)
  registerEvent("FromClient_EndInstanceSavageDefenceWave", "FromClient_BloodAltar_EndInstanceSavageDefenceWave")
  registerEvent("FromClient_CheckSetSubScriptInstanceFieldAck", "FromClient_BloodAltar_CheckSetSubScriptInstanceFieldAck")
  registerEvent("FromClient_SetSubScriptForInstanceFieldResult", "FromClient_BloodAltar_SetSubScriptForInstanceFieldResult")
end
function PaGlobal_BloodAltar_All:listUpdate()
  if nil == Panel_Window_BloodAltar_All then
    return
  end
  PaGlobal_BloodAltar_All._listCount = ToClient_GetInstanceFieldScriptUiSize()
  local listManager = PaGlobal_BloodAltar_All._ui.list_Stage:getElementManager()
  if nil ~= listManager then
    listManager:clearKey()
    for i = 0, PaGlobal_BloodAltar_All._listCount - 1 do
      listManager:pushKey(toInt64(0, i))
    end
  end
  PaGlobal_BloodAltar_All:startButtonUpdate()
  PaGlobal_BloodAltar_All._selectStageIndex = -1
end
function PaGlobal_BloodAltar_All:startButtonUpdate()
  if nil == Panel_Window_BloodAltar_All or true == PaGlobal_BloodAltar_All._isConsole then
    return
  end
  if 0 < PaGlobal_BloodAltar_All._listCount and -1 < PaGlobal_BloodAltar_All._selectStageIndex then
    PaGlobal_BloodAltar_All._ui.btn_Start:SetIgnore(false)
    PaGlobal_BloodAltar_All._ui.btn_Start:SetFontColor(Defines.Color.C_FFFFEDD4)
  else
    PaGlobal_BloodAltar_All._ui.btn_Start:SetIgnore(true)
    PaGlobal_BloodAltar_All._ui.btn_Start:SetFontColor(Defines.Color.C_FF5A5A5A)
  end
end
function PaGlobal_BloodAltar_All:createStageList(content, key)
  local index = Int64toInt32(key)
  local list_ui = {}
  list_ui.btn_Stage = UI.getChildControl(content, "Button_Stage")
  list_ui.txt_StageName = UI.getChildControl(content, "StaticText_StageName")
  list_ui.txt_NeedEnergy = UI.getChildControl(content, "StaticText_NeedEnergy")
  list_ui.stc_LockIcon = UI.getChildControl(content, "Static_LockIcon")
  list_ui.stc_ClosedIcon = UI.getChildControl(content, "Static_NotOpenIcon")
  local isStageClose = ToClient_IsInstanceFieldScriptClose(index)
  local isDirectOpen = ToClient_CanEnterInstanceFieldScript(index)
  local isClear = ToClient_IsInstanceFieldScriptClear(index)
  local isPlayable = false
  local isItemPlayable = false == isDirectOpen and true == isClear and true == ToClient_HasInstanceSavageDefenceDirectJoinItem()
  list_ui.txt_StageName:SetText(ToClient_GetInstanceFieldScriptUiName(index))
  list_ui.txt_StageName:SetSpanSize(25, list_ui.txt_StageName:GetSpanSize().y)
  if false == isStageClose then
    isPlayable = true == isDirectOpen or true == isItemPlayable
    if false == isDirectOpen then
      list_ui.txt_StageName:SetSpanSize(40, list_ui.txt_StageName:GetSpanSize().y)
    end
  end
  list_ui.stc_LockIcon:SetShow(false == isClear and false == isDirectOpen and false == isStageClose)
  list_ui.stc_ClosedIcon:SetShow(true == isStageClose)
  list_ui.btn_Stage:SetIgnore(false == isPlayable)
  list_ui.txt_NeedEnergy:SetShow(true == isPlayable)
  if true == isPlayable then
    if true == PaGlobal_BloodAltar_All._isConsole then
      list_ui.btn_Stage:registerPadEvent(__eConsoleUIPadEvent_Up_A, "HandleEventLUp_BloodAltar_SelectStage(" .. index .. ")")
      list_ui.btn_Stage:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "HandleEventLUp_BloodAltar_OpenPartySetting()")
    else
      list_ui.btn_Stage:SetCheck(false)
      list_ui.btn_Stage:addInputEvent("Mouse_LUp", "HandleEventLUp_BloodAltar_SelectStage(" .. index .. ")")
    end
    list_ui.txt_NeedEnergy:SetText(ToClient_GetInstanceFieldScriptUseWp(index))
    list_ui.txt_StageName:SetFontColor(Defines.Color.C_FFDDC39E)
  elseif true == isClear then
    list_ui.txt_StageName:SetFontColor(Defines.Color.C_FFDDC39E)
    list_ui.btn_Stage:addInputEvent("", "")
  else
    list_ui.txt_StageName:SetFontColor(Defines.Color.C_FF5A5A5A)
    list_ui.btn_Stage:addInputEvent("", "")
  end
  if true == self._isConsole and (0 < index and index <= 3 or 4 < index and index < 10) then
    list_ui.btn_Stage:addInputEvent("", "")
    list_ui.btn_Stage:SetIgnore(true)
    list_ui.txt_StageName:SetFontColor(Defines.Color.C_FF5A5A5A)
    list_ui.stc_LockIcon:SetShow(true)
    list_ui.stc_ClosedIcon:SetShow(false)
    list_ui.txt_NeedEnergy:SetShow(false)
  end
end
function PaGlobal_BloodAltar_All:prepareOpen()
  if nil == Panel_Window_BloodAltar_All then
    return
  end
  PaGlobal_BloodAltar_All:listUpdate()
  PaGlobal_BloodAltar_All:open()
end
function PaGlobal_BloodAltar_All:open()
  if nil == Panel_Window_BloodAltar_All then
    return
  end
  Panel_Window_BloodAltar_All:SetShow(true)
end
function PaGlobal_BloodAltar_All:prepareClose()
  if nil == Panel_Window_BloodAltar_All then
    return
  end
  PaGlobal_BloodAltar_All:close()
end
function PaGlobal_BloodAltar_All:close()
  if nil == Panel_Window_BloodAltar_All then
    return
  end
  Panel_Window_BloodAltar_All:SetShow(false)
end
function PaGlobal_BloodAltar_All:validate()
  if nil == Panel_Window_BloodAltar_All then
    return
  end
  PaGlobal_BloodAltar_All._ui.stc_TitleBG:isValidate()
  PaGlobal_BloodAltar_All._ui.txt_Title:isValidate()
  PaGlobal_BloodAltar_All._ui.btn_PC_Close:isValidate()
  PaGlobal_BloodAltar_All._ui.stc_Image:isValidate()
  PaGlobal_BloodAltar_All._ui.stc_DescBG:isValidate()
  PaGlobal_BloodAltar_All._ui.txt_Desc:isValidate()
  PaGlobal_BloodAltar_All._ui.list_Stage:isValidate()
  PaGlobal_BloodAltar_All._ui.btn_Start:isValidate()
  PaGlobal_BloodAltar_All._ui.stc_ConsoleKeyGuide:isValidate()
end
