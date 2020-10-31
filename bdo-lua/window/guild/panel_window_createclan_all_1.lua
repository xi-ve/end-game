function PaGlobal_CreateClan_All:initialize()
  if true == PaGlobal_CreateClan_All._initialize then
    return
  end
  PaGlobal_CreateClan_All._isConsole = _ContentsGroup_UsePadSnapping
  PaGlobal_CreateClan_All:controlAll_Init()
  PaGlobal_CreateClan_All:controlPc_Init()
  PaGlobal_CreateClan_All:controlConsole_Init()
  PaGlobal_CreateClan_All:SetUiSetting()
  PaGlobal_CreateClan_All._typeDescOriginSizeY = PaGlobal_CreateClan_All._ui.stc_selectTypeDescBG:GetSizeY()
  if false == PaGlobal_CreateClan_All._isConsole then
    PaGlobal_CreateClan_All._confirmOriginPosY = PaGlobal_CreateClan_All._ui_pc.btn_confirm:GetPosY()
  else
    PaGlobal_CreateClan_All._confirmOriginPosY = PaGlobal_CreateClan_All._ui_console.stc_bottomBg:GetPosY()
    local tempBtnGroup = {
      PaGlobal_CreateClan_All._ui_console.btn_confirm,
      PaGlobal_CreateClan_All._ui_console.btn_close
    }
    PaGlobalFunc_ConsoleKeyGuide_SetAlign(tempBtnGroup, PaGlobal_CreateClan_All._ui_console.stc_bottomBg, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHT)
  end
  PaGlobal_CreateClan_All:registEventHandler()
  PaGlobal_CreateClan_All:validate()
  PaGlobal_CreateClan_All._initialize = true
end
function PaGlobal_CreateClan_All:controlAll_Init()
  if nil == Panel_CreateClan_All then
    return
  end
  PaGlobal_CreateClan_All._ui.stc_title = UI.getChildControl(Panel_CreateClan_All, "StaticText_Title")
  PaGlobal_CreateClan_All._ui.stc_btnBg = UI.getChildControl(Panel_CreateClan_All, "Static_ButtonBg")
  PaGlobal_CreateClan_All._ui.btn_clan = UI.getChildControl(PaGlobal_CreateClan_All._ui.stc_btnBg, "RadioButton_Clan")
  PaGlobal_CreateClan_All._ui.btn_guild = UI.getChildControl(PaGlobal_CreateClan_All._ui.stc_btnBg, "RadioButton_Guild")
  PaGlobal_CreateClan_All._ui.stc_selectTypeDescBG = UI.getChildControl(Panel_CreateClan_All, "StaticText_SelectedTypeDescBG")
  PaGlobal_CreateClan_All._ui.stc_selectTypeDesc = UI.getChildControl(PaGlobal_CreateClan_All._ui.stc_selectTypeDescBG, "StaticText_SelectedTypeDesc")
  PaGlobal_CreateClan_All._ui.stc_selectTypeDesc:SetShow(true)
end
function PaGlobal_CreateClan_All:controlPc_Init()
  if nil == Panel_CreateClan_All then
    return
  end
  PaGlobal_CreateClan_All._ui_pc.btn_close = UI.getChildControl(PaGlobal_CreateClan_All._ui.stc_title, "Button_Close_PCUI")
  PaGlobal_CreateClan_All._ui_pc.btn_question = UI.getChildControl(PaGlobal_CreateClan_All._ui.stc_title, "Button_Question_PCUI")
  PaGlobal_CreateClan_All._ui_pc.btn_confirm = UI.getChildControl(Panel_CreateClan_All, "Button_Confirm")
end
function PaGlobal_CreateClan_All:controlConsole_Init()
  if nil == Panel_CreateClan_All then
    return
  end
  PaGlobal_CreateClan_All._ui_console.stc_bottomBg = UI.getChildControl(Panel_CreateClan_All, "Static_BottomBg_ConsoleUI")
  PaGlobal_CreateClan_All._ui_console.btn_confirm = UI.getChildControl(PaGlobal_CreateClan_All._ui_console.stc_bottomBg, "StaticText_Create_ConsoleUI")
  PaGlobal_CreateClan_All._ui_console.btn_close = UI.getChildControl(PaGlobal_CreateClan_All._ui_console.stc_bottomBg, "StaticText_Close_ConsoleUI")
end
function PaGlobal_CreateClan_All:SetUiSetting()
  if nil == Panel_CreateClan_All then
    return
  end
  if false == PaGlobal_CreateClan_All._isConsole then
    PaGlobal_CreateClan_All._ui_console.stc_bottomBg:SetShow(false)
    PaGlobal_CreateClan_All._ui_pc.btn_confirm:SetShow(true)
    PaGlobal_CreateClan_All._ui_pc.btn_close:SetShow(true)
    PaGlobal_CreateClan_All._ui_pc.btn_question:SetShow(true)
    Panel_CreateClan_All:SetSize(Panel_CreateClan_All:GetSizeX(), PaGlobal_CreateClan_All._pcPanelSizeY)
  else
    PaGlobal_CreateClan_All._ui_pc.btn_confirm:SetShow(false)
    PaGlobal_CreateClan_All._ui_pc.btn_close:SetShow(false)
    PaGlobal_CreateClan_All._ui_pc.btn_question:SetShow(false)
    PaGlobal_CreateClan_All._ui_console.stc_bottomBg:SetShow(true)
    Panel_CreateClan_All:SetSize(Panel_CreateClan_All:GetSizeX(), PaGlobal_CreateClan_All._consolePanelSizeY)
    local movePosY = PaGlobal_CreateClan_All._ui_console.stc_bottomBg:GetPosY() - (PaGlobal_CreateClan_All._pcPanelSizeY - PaGlobal_CreateClan_All._consolePanelSizeY)
    PaGlobal_CreateClan_All._ui_console.stc_bottomBg:SetPosY(movePosY)
    PaGlobal_CreateClan_All._originPanelPosY = Panel_CreateClan_All:GetPosY()
  end
end
function PaGlobal_CreateClan_All:registEventHandler()
  if nil == Panel_CreateClan_All then
    return
  end
  registerEvent("onScreenResize", "FromClient_CreateClan_All_ReSizePanel")
  if false == PaGlobal_CreateClan_All._isConsole then
    PaGlobal_CreateClan_All._ui_pc.btn_close:addInputEvent("Mouse_LUp", "PaGlobal_CreateClan_All_Close()")
    PaGlobal_CreateClan_All._ui.btn_clan:addInputEvent("Mouse_LUp", "HandleEventLUp_CreateClan_All_clickedSelectType()")
    PaGlobal_CreateClan_All._ui.btn_guild:addInputEvent("Mouse_LUp", "HandleEventLUp_CreateClan_All_clickedSelectType()")
    PaGlobal_CreateClan_All._ui_pc.btn_confirm:addInputEvent("Mouse_LUp", "HandleEventLUp_CreateClan_All_clickedConfirm()")
    PaGlobal_CreateClan_All._ui_pc.btn_question:addInputEvent("Mouse_LUp", "Panel_WebHelper_ShowToggle( \"PanelClan\" )")
    PaGlobal_Util_RegistHelpTooltipEvent(PaGlobal_CreateClan_All._ui_pc.btn_question, "\"PanelClan\"")
  else
    Panel_CreateClan_All:registerPadEvent(__eConsoleUIPadEvent_Up_A, "HandleEventLUp_CreateClan_All_clickedConfirm()")
    PaGlobal_CreateClan_All._ui.btn_clan:addInputEvent("Mouse_On", "HandleEventMOn_CreateClan_All_SetButtonCheck(true)")
    PaGlobal_CreateClan_All._ui.btn_guild:addInputEvent("Mouse_On", "HandleEventMOn_CreateClan_All_SetButtonCheck(false)")
  end
end
function PaGlobal_CreateClan_All:prepareOpen()
  if nil == Panel_CreateClan_All then
    return
  end
  PaGlobal_CreateClan_All:setButtonClick()
  PaGlobal_CreateClan_All:open()
  if true == PaGlobal_CreateClan_All._isConsole then
    FromClient_CreateClan_All_ReSizePanel()
  end
end
function PaGlobal_CreateClan_All:open()
  if nil == Panel_CreateClan_All then
    return
  end
  Panel_CreateClan_All:SetShow(true)
end
function PaGlobal_CreateClan_All:prepareClose()
  if nil == Panel_CreateClan_All then
    return
  end
  PaGlobalFunc_DialogMain_All_SubPanelSetShow(true)
  PaGlobal_CreateClan_All:close()
end
function PaGlobal_CreateClan_All:close()
  if nil == Panel_CreateClan_All then
    return
  end
  Panel_CreateClan_All:SetShow(false)
end
function PaGlobal_CreateClan_All:update()
  if nil == Panel_CreateClan_All then
    return
  end
end
function PaGlobal_CreateClan_All:validate()
  if nil == Panel_CreateClan_All then
    return
  end
  PaGlobal_CreateClan_All:allValidate()
  PaGlobal_CreateClan_All:pcValidate()
  PaGlobal_CreateClan_All:consoleValidate()
end
function PaGlobal_CreateClan_All:allValidate()
  PaGlobal_CreateClan_All._ui.stc_title:isValidate()
  PaGlobal_CreateClan_All._ui.stc_btnBg:isValidate()
  PaGlobal_CreateClan_All._ui.btn_clan:isValidate()
  PaGlobal_CreateClan_All._ui.btn_guild:isValidate()
  PaGlobal_CreateClan_All._ui.stc_selectTypeDesc:isValidate()
  PaGlobal_CreateClan_All._ui.stc_selectTypeDescBG:isValidate()
end
function PaGlobal_CreateClan_All:pcValidate()
  PaGlobal_CreateClan_All._ui_pc.btn_close:isValidate()
  PaGlobal_CreateClan_All._ui_pc.btn_question:isValidate()
  PaGlobal_CreateClan_All._ui_pc.btn_confirm:isValidate()
end
function PaGlobal_CreateClan_All:consoleValidate()
  PaGlobal_CreateClan_All._ui_console.stc_bottomBg:isValidate()
  PaGlobal_CreateClan_All._ui_console.btn_confirm:isValidate()
  PaGlobal_CreateClan_All._ui_console.btn_close:isValidate()
end
function PaGlobal_CreateClan_All:setButtonClick()
  if nil == Panel_CreateClan_All then
    return
  end
  if false == isGameServiceTypeConsole() then
    PaGlobal_CreateClan_All._ui.btn_clan:SetCheck(true)
    PaGlobal_CreateClan_All._ui.btn_guild:SetCheck(false)
  else
    PaGlobal_CreateClan_All._ui.btn_clan:SetCheck(false)
    PaGlobal_CreateClan_All._ui.btn_guild:SetCheck(false)
  end
  PaGlobal_CreateClan_All._ui.btn_clan:SetMonoTone(false)
  PaGlobal_CreateClan_All._ui.btn_guild:SetMonoTone(false)
  PaGlobal_CreateClan_All._ui.btn_clan:SetEnable(true)
  PaGlobal_CreateClan_All._ui.btn_guild:SetEnable(true)
  PaGlobal_CreateClan_All._ui.btn_clan:SetIgnore(false)
  PaGlobal_CreateClan_All._ui.btn_guild:SetIgnore(false)
  if false == PaGlobal_CreateClan_All._isConsole then
    PaGlobal_CreateClan_All._ui_pc.btn_confirm:SetMonoTone(false)
    PaGlobal_CreateClan_All._ui_pc.btn_confirm:SetEnable(true)
  else
    PaGlobal_CreateClan_All._ui_console.btn_confirm:SetShow(true)
    PaGlobal_CreateClan_All._ui_console.btn_confirm:SetEnable(true)
  end
  if false == ToClient_CanMakeGuild() then
    PaGlobal_CreateClan_All._ui.btn_guild:SetEnable(false)
    PaGlobal_CreateClan_All._ui.btn_guild:SetMonoTone(true)
    Panel_CreateClan_All:registerPadEvent(__eConsoleUIPadEvent_Up_A, "")
  else
    Panel_CreateClan_All:registerPadEvent(__eConsoleUIPadEvent_Up_A, "HandleEventLUp_CreateClan_All_clickedConfirm()")
  end
  local myGuildListInfo = ToClient_GetMyGuildInfoWrapper()
  if nil ~= myGuildListInfo then
    local guildGrade = myGuildListInfo:getGuildGrade()
    local isGuildMaster = getSelfPlayer():get():isGuildMaster()
    if 0 ~= guildGrade then
      PaGlobal_CreateClan_All._ui.btn_clan:SetMonoTone(true)
      PaGlobal_CreateClan_All._ui.btn_clan:SetIgnore(true)
      PaGlobal_CreateClan_All._ui.btn_guild:SetMonoTone(true)
      PaGlobal_CreateClan_All._ui.btn_guild:SetIgnore(true)
      PaGlobal_CreateClan_All._ui_pc.btn_confirm:SetMonoTone(true)
      PaGlobal_CreateClan_All._ui_pc.btn_confirm:SetEnable(false)
      PaGlobal_CreateClan_All._ui_console.btn_confirm:SetShow(false)
      PaGlobal_CreateClan_All._ui_console.btn_confirm:SetEnable(false)
      Panel_CreateClan_All:registerPadEvent(__eConsoleUIPadEvent_Up_A, "")
    else
      if false == isGameServiceTypeConsole() then
        PaGlobal_CreateClan_All._ui.btn_clan:SetCheck(not isGuildMaster)
        PaGlobal_CreateClan_All._ui.btn_guild:SetCheck(isGuildMaster)
      end
      if isGuildMaster then
        PaGlobal_CreateClan_All._ui.btn_clan:SetMonoTone(true)
        PaGlobal_CreateClan_All._ui.btn_clan:SetIgnore(true)
        PaGlobal_CreateClan_All._ui.btn_guild:SetMonoTone(false)
        PaGlobal_CreateClan_All._ui.btn_guild:SetEnable(true)
      else
        PaGlobal_CreateClan_All._ui.btn_clan:SetMonoTone(false)
        PaGlobal_CreateClan_All._ui.btn_clan:SetEnable(true)
        PaGlobal_CreateClan_All._ui.btn_guild:SetMonoTone(false)
        PaGlobal_CreateClan_All._ui.btn_guild:SetEnable(true)
      end
    end
  end
  PaGlobal_CreateClan_All:setSelectTypeDesc()
end
function PaGlobal_CreateClan_All:setSelectTypeDesc()
  if nil == Panel_CreateClan_All then
    return
  end
  local title = ""
  local desc = ""
  if PaGlobal_CreateClan_All._ui.btn_clan:IsChecked() then
    title = PAGetString(Defines.StringSheet_GAME, "LUA_CREATECLAN_GUIDETITLE_CLAN")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_CREATECLAN_GUIDEDESC_CLAN")
  else
    title = PAGetString(Defines.StringSheet_GAME, "LUA_CREATECLAN_GUIDETITLE_GUILD")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_CREATECLAN_GUIDEDESC_GUILD")
  end
  PaGlobal_CreateClan_All._ui.stc_selectTypeDesc:SetTextMode(__eTextMode_AutoWrap)
  PaGlobal_CreateClan_All._ui.stc_selectTypeDesc:SetText(desc)
  local padding = 20
  PaGlobal_CreateClan_All._ui.stc_selectTypeDesc:SetSize(PaGlobal_CreateClan_All._ui.stc_selectTypeDesc:GetSizeX(), PaGlobal_CreateClan_All._ui.stc_selectTypeDesc:GetTextSizeY())
  PaGlobal_CreateClan_All._ui.stc_selectTypeDescBG:SetSize(PaGlobal_CreateClan_All._ui.stc_selectTypeDescBG:GetSizeX(), PaGlobal_CreateClan_All._ui.stc_selectTypeDesc:GetTextSizeY() + padding)
  local topBGSizeY = UI.getChildControl(Panel_CreateClan_All, "Static_TopBG"):GetSizeY()
  local descBGSizeY = PaGlobal_CreateClan_All._ui.stc_selectTypeDescBG:GetSizeY()
  local confirmSizeY = PaGlobal_CreateClan_All._ui_pc.btn_confirm:GetSizeY()
  local btnBGSizeY = PaGlobal_CreateClan_All._ui.stc_btnBg:GetSizeY()
  local titleSizeY = PaGlobal_CreateClan_All._ui.stc_title:GetSizeY()
  local consoleSizeY = PaGlobal_CreateClan_All._ui_console.stc_bottomBg:GetSizeY()
  local panelSizeY = 0
  if false == PaGlobal_CreateClan_All._isConsole then
    panelSizeY = descBGSizeY + padding + topBGSizeY + padding + confirmSizeY + padding + btnBGSizeY + padding + titleSizeY
  else
    panelSizeY = descBGSizeY + padding + topBGSizeY + padding + consoleSizeY + padding + btnBGSizeY + padding + titleSizeY
  end
  Panel_CreateClan_All:SetSize(Panel_CreateClan_All:GetSizeX(), panelSizeY)
  FromClient_CreateClan_All_ReSizePanel()
end
