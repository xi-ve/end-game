local UI_ANI_ADV = CppEnums.PAUI_ANIM_ADVANCE_TYPE
Panel_Window_MessageBox_All:RegisterShowEventFunc(true, "MessageBox_ShowAni()")
Panel_Window_MessageBox_All:RegisterShowEventFunc(false, "MessageBox_HideAni()")
Panel_Window_MessageBox_All:SetShow(false, false)
Panel_Window_MessageBox_All:setGlassBackground(true)
if _ContentsGroup_UsePadSnapping then
  Panel_Window_MessageBox_All:ignorePadSnapMoveToOtherPanel()
end
local UI_PP = CppEnums.PAUIMB_PRIORITY
local UI_color = Defines.Color
local UI_PSFT = CppEnums.PAUI_SHOW_FADE_TYPE
local UI_ANI_ADV = CppEnums.PAUI_ANIM_ADVANCE_TYPE
local functionKeyUse = true
local globalButtonShowCount = 0
local elapsedTime = 0
local textTitle = UI.getChildControl(Panel_Window_MessageBox_All, "Static_Text_Title")
local textBG = UI.getChildControl(Panel_Window_MessageBox_All, "Static_Text")
local textContent = UI.getChildControl(Panel_Window_MessageBox_All, "StaticText_Content")
local buttonYes = UI.getChildControl(Panel_Window_MessageBox_All, "Button_Yes")
local buttonApply = UI.getChildControl(Panel_Window_MessageBox_All, "Button_Apply")
local buttonNo = UI.getChildControl(Panel_Window_MessageBox_All, "Button_No")
local buttonIgnore = UI.getChildControl(Panel_Window_MessageBox_All, "Button_Ignore")
local buttonCancel = UI.getChildControl(Panel_Window_MessageBox_All, "Button_Cancel")
local buttonClose = UI.getChildControl(Panel_Window_MessageBox_All, "Button_Close")
local refuseInvite = UI.getChildControl(Panel_Window_MessageBox_All, "CheckButton_RefuseGo")
local blockBG = UI.getChildControl(Panel_Window_MessageBox_All, "Static_BlockBG")
local loadSequence = UI.getChildControl(Panel_Window_MessageBox_All, "Static_Sequence")
local static_Beginner_BG = UI.getChildControl(Panel_Window_MessageBox_All, "Static_Beginner_BG")
local static_BeginnerTitleBG = UI.getChildControl(Panel_Window_MessageBox_All, "Static_BeginnerTitleBG")
local staticText_BeginnerTxt1 = UI.getChildControl(Panel_Window_MessageBox_All, "StaticText_BeginnerTxt1")
local staticText_BeginnerTxt2 = UI.getChildControl(Panel_Window_MessageBox_All, "StaticText_BeginnerTxt2")
local static_iconArea_BG = UI.getChildControl(Panel_Window_MessageBox_All, "Static_IconBg")
local static_IconTitle = UI.getChildControl(static_iconArea_BG, "StaticText_IconTitle")
local static_IconValue = UI.getChildControl(static_iconArea_BG, "StaticText_IconValue")
local iconInven = UI.getChildControl(Panel_Window_MessageBox_All, "RadioButton_Icon_Inven")
local iconWarehouse = UI.getChildControl(Panel_Window_MessageBox_All, "RadioButton_Icon_Warehouse")
local checkInven = UI.getChildControl(iconInven, "StaticText_Money")
local checkWarehouse = UI.getChildControl(iconWarehouse, "StaticText_Money")
local progress = UI.getChildControl(textContent, "Progress2_1")
local checkCustom1 = UI.getChildControl(Panel_Window_MessageBox_All, "Button_CustomString1")
local checkCustom2 = UI.getChildControl(Panel_Window_MessageBox_All, "Button_CustomString2")
checkCustom1:SetShow(false)
checkCustom2:SetShow(false)
local static_consloeUI = UI.getChildControl(Panel_Window_MessageBox_All, "Static_BottomBg_ConsoleUI")
local static_consoleUI_A = UI.getChildControl(static_consloeUI, "StaticText_A_ConsoleUI")
local static_consoleUI_B = UI.getChildControl(static_consloeUI, "StaticText_B_ConsoleUI")
local isPadDisConnect = false
static_consloeUI:SetShow(_ContentsGroup_UsePadSnapping)
local buttonTextSizeX = buttonYes:GetTextSizeX()
buttonTextSizeX = math.max(buttonTextSizeX, buttonApply:GetTextSizeX())
buttonTextSizeX = math.max(buttonTextSizeX, buttonNo:GetTextSizeX())
buttonTextSizeX = math.max(buttonTextSizeX, buttonIgnore:GetTextSizeX())
buttonTextSizeX = math.max(buttonTextSizeX, buttonCancel:GetTextSizeX())
buttonTextSizeX = math.min(buttonTextSizeX, 150)
if buttonYes:GetSizeX() < buttonTextSizeX + 20 then
  buttonYes:SetSize(buttonTextSizeX + 20, buttonYes:GetSizeY())
  buttonApply:SetSize(buttonTextSizeX + 20, buttonApply:GetSizeY())
  buttonNo:SetSize(buttonTextSizeX + 20, buttonNo:GetSizeY())
  buttonIgnore:SetSize(buttonTextSizeX + 20, buttonIgnore:GetSizeY())
  buttonCancel:SetSize(buttonTextSizeX + 20, buttonCancel:GetSizeY())
end
if true == _ContentsGroup_UsePadSnapping then
  blockBG:ChangeTextureInfoNameAsync("combine/frame/combine_frame_00.dds")
  local x1, y1, x2, y2 = setTextureUV_Func(blockBG, 11, 11, 41, 41)
  blockBG:getBaseTexture():setUV(x1, y1, x2, y2)
  blockBG:setRenderTexture(blockBG:getBaseTexture())
  blockBG:SetAlpha(0.75)
end
MessageBox = {}
local MessageData = {
  title = nil,
  content = nil,
  functionYes = nil,
  functionApply = nil,
  functionNo = nil,
  functionIgnore = nil,
  functionCancel = nil,
  priority = UI_PP.PAUIMB_PRIORITY_LOW,
  clientMessage = nil,
  exitButton = true,
  isTimeCount = false,
  countTime = 10,
  timeString = nil,
  isStartTimer = nil,
  afterFunction = nil,
  isCancelClose = false,
  isProgress = false,
  iconTitle = nil,
  iconValue = nil
}
local functionYes, list, _currentMessageBoxData
MessageBoxCheck = {}
local MessageCheckData = {
  title = nil,
  content = nil,
  functionApply = nil,
  functionCancel = nil,
  priority = UI_PP.PAUIMB_PRIORITY_LOW,
  clientMessage = nil,
  exitButton = true,
  isTimeCount = false,
  countTime = 10,
  timeString = nil,
  isStartTimer = nil,
  afterFunction = nil,
  isProgress = false,
  isCancelClose = false
}
local orginPanelSizeY = Panel_Window_MessageBox_All:GetSizeY()
local function updateRefuseType(refuseType)
  refuseInvite:SetShow(false)
  if true == _ContentsGroup_UsePadSnapping then
    return
  end
  local isTooltip = false
  local optionWrapper = ToClient_getGameOptionControllerWrapper()
  if 0 == refuseType then
    local isRefuseRequests = optionWrapper:getRefuseRequests()
    refuseInvite:SetCheck(isRefuseRequests)
    refuseInvite:SetShow(true)
    refuseInvite:addInputEvent("Mouse_LUp", "PaGlobal_MessageBox_RefuseOption(0)")
    refuseInvite:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_MESSAGEBOX_ALWAYSREFUSE"))
    isTooltip = true
  elseif 1 == refuseType then
    local isRefusePvP = optionWrapper:getPvpRefuse()
    refuseInvite:SetCheck(isRefusePvP)
    refuseInvite:SetShow(true)
    refuseInvite:addInputEvent("Mouse_LUp", "PaGlobal_MessageBox_RefuseOption(1)")
    refuseInvite:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_MESSAGEBOX_ALWAYSREFUSE"))
    isTooltip = true
  elseif 2 == refuseType then
    local isRefusePersonTrade = optionWrapper:getIsExchangeRefuse()
    refuseInvite:SetCheck(isRefusePersonTrade)
    refuseInvite:SetShow(true)
    refuseInvite:addInputEvent("Mouse_LUp", "PaGlobal_MessageBox_RefuseOption(2)")
    refuseInvite:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_MESSAGEBOX_ALWAYSREFUSE"))
    isTooltip = true
  elseif 3 == refuseType then
    local isRefuseUiScale = ToClient_getGameUIManagerWrapper():getLuaCacheDataListBool(__eUiInterfaceSizeMessagePanel)
    refuseInvite:SetCheck(isRefuseUiScale)
    refuseInvite:SetShow(true)
    refuseInvite:addInputEvent("Mouse_LUp", "PaGlobal_MessageBox_RefuseOption(3)")
    refuseInvite:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_MESSAGEBOX_NAVERLOOK"))
    refuseInvite:addInputEvent("Mouse_On", "")
    refuseInvite:addInputEvent("Mouse_Out", "")
  else
    refuseInvite:SetShow(false)
  end
  refuseInvite:SetEnableArea(0, 0, refuseInvite:GetTextSizeX() + 20, 25)
  if true == isTooltip then
    refuseInvite:addInputEvent("Mouse_On", "PaGlobal_MessageBox_RefuseTip(true)")
    refuseInvite:addInputEvent("Mouse_Out", "PaGlobal_MessageBox_RefuseTip(false)")
  end
end
local function messageBox_Resize(refuseType)
  local padding = 10
  local textSizeY = textContent:GetTextSizeY()
  textContent:SetSize(textContent:GetSizeX(), textSizeY)
  if 0 ~= static_IconTitle:GetTextSizeY() then
    static_IconTitle:SetSize(static_IconTitle:GetSizeX(), static_IconValue:GetTextSizeY() + padding)
    static_iconArea_BG:SetSize(static_iconArea_BG:GetSizeX(), static_IconValue:GetTextSizeY() + padding * 2)
    static_IconValue:SetSize(static_IconValue:GetSizeX(), static_IconValue:GetTextSizeY())
    static_iconArea_BG:SetPosY(textContent:GetPosY() + textContent:GetSizeY() + padding)
    static_IconTitle:ComputePos()
    static_IconValue:ComputePos()
    static_consloeUI:ComputePos()
    static_IconValue:SetPosX(static_IconValue:GetPosX() - (static_IconValue:GetTextSizeX() + padding))
    textSizeY = textSizeY + static_iconArea_BG:GetSizeY() + padding
  else
    textSizeY = textSizeY + static_IconTitle:GetTextSizeY()
  end
  local refuseGap = 0
  if nil ~= refuseType then
    refuseGap = 30
  end
  textBG:SetSize(textBG:GetSizeX(), textSizeY + refuseGap + 40)
  Panel_Window_MessageBox_All:SetSize(Panel_Window_MessageBox_All:GetSizeX(), textBG:GetSizeY() + 97 + padding)
  orginPanelSizeY = Panel_Window_MessageBox_All:GetSizeY()
end
local function messageCheckBox_Resize()
  local textSizeY = textContent:GetTextSizeY()
  textContent:SetSize(textContent:GetSizeX(), textSizeY)
  textSizeY = textSizeY + iconInven:GetSizeY()
  local padding = 5
  textBG:SetSize(textBG:GetSizeX(), textSizeY + 95 + padding)
  Panel_Window_MessageBox_All:SetSize(Panel_Window_MessageBox_All:GetSizeX(), textBG:GetSizeY() + 97 + padding * 2)
  orginPanelSizeY = Panel_Window_MessageBox_All:GetSizeY()
end
function setCurrentMessageData(currentData, position, refuseType)
  if currentData ~= nil then
    progress:SetShow(false)
    buttonYes:SetShow(false)
    buttonApply:SetShow(false)
    buttonNo:SetShow(false)
    buttonIgnore:SetShow(false)
    buttonCancel:SetShow(false)
    buttonClose:SetShow(false)
    loadSequence:SetShow(false)
    refuseInvite:SetShow(false)
    static_consoleUI_A:SetShow(false)
    static_consoleUI_B:SetShow(false)
    static_iconArea_BG:SetShow(false)
    iconInven:SetShow(false)
    iconWarehouse:SetShow(false)
    Panel_Window_MessageBox_All:SetShow(true, false)
    Panel_Window_MessageBox_All:SetScaleChild(1, 1)
    if currentData.title ~= nil then
      textTitle:SetText(currentData.title)
    end
    if currentData.content ~= nil then
      textContent:SetTextMode(__eTextMode_AutoWrap)
      textContent:SetText(currentData.content)
      messageBox_Resize(refuseType)
    end
    if currentData.iconTitle ~= nil then
      static_iconArea_BG:SetShow(true)
      static_IconTitle:SetText(currentData.iconTitle)
      messageBox_Resize(refuseType)
    end
    if currentData.iconValue ~= nil then
      static_IconValue:SetText(currentData.iconValue)
      messageBox_Resize(refuseType)
    end
    local isConsole = _ContentsGroup_UsePadSnapping
    local buttonShowCount = 0
    if currentData.functionYes ~= nil then
      buttonYes:SetShow(not isConsole)
      buttonShowCount = buttonShowCount + 1
      static_consoleUI_A:SetShow(isConsole)
      static_consoleUI_A:SetText(PAGetString(Defines.StringSheet_RESOURCE, "MESSAGEBOX_BTN_YES_WITHOUT_KEY"))
    elseif currentData.functionApply ~= nil then
      buttonApply:SetShow(not isConsole)
      buttonShowCount = buttonShowCount + 1
      static_consoleUI_A:SetShow(isConsole)
      static_consoleUI_A:SetText(PAGetString(Defines.StringSheet_RESOURCE, "MESSAGEBOX_BTN_APPLY_WITHOUT_KEY"))
    end
    if currentData.functionNo ~= nil then
      buttonNo:SetShow(not isConsole)
      buttonShowCount = buttonShowCount + 1
      static_consoleUI_B:SetShow(isConsole)
      static_consoleUI_B:SetText(PAGetString(Defines.StringSheet_RESOURCE, "MESSAGEBOX_BTN_NO_WITHOUT_KEY"))
    elseif currentData.functionIgnore ~= nil then
      buttonIgnore:SetShow(not isConsole)
      buttonShowCount = buttonShowCount + 1
      static_consoleUI_B:SetShow(isConsole)
      static_consoleUI_B:SetText(PAGetString(Defines.StringSheet_RESOURCE, "MESSAGEBOX_BTN_CANCEL_WITHOUT_KEY"))
    end
    if currentData.functionCancel ~= nil then
      buttonCancel:SetShow(not isConsole)
      buttonShowCount = buttonShowCount + 1
      static_consoleUI_B:SetShow(isConsole)
      static_consoleUI_B:SetText(PAGetString(Defines.StringSheet_RESOURCE, "MESSAGEBOX_BTN_CANCEL_WITHOUT_KEY"))
    end
    if currentData.exitButton == true and false == _ContentsGroup_UsePadSnapping then
      buttonClose:SetShow(not isConsole)
    end
    if currentData.isLoading == true then
      loadSequence:SetShow(true)
      loadSequence:ComputePos()
    end
    globalButtonShowCount = buttonShowCount
    if 1 == buttonShowCount then
      buttonYes:SetPosX(Panel_Window_MessageBox_All:GetSizeX() / 2 - buttonYes:GetSizeX() / 2)
      buttonApply:SetPosX(Panel_Window_MessageBox_All:GetSizeX() / 2 - buttonApply:GetSizeX() / 2)
      buttonNo:SetPosX(Panel_Window_MessageBox_All:GetSizeX() / 2 - buttonNo:GetSizeX() / 2)
      buttonIgnore:SetPosX(Panel_Window_MessageBox_All:GetSizeX() / 2 - buttonIgnore:GetSizeX() / 2)
      buttonCancel:SetPosX(Panel_Window_MessageBox_All:GetSizeX() / 2 - buttonCancel:GetSizeX() / 2)
    elseif 2 == buttonShowCount then
      buttonYes:SetPosX(Panel_Window_MessageBox_All:GetSizeX() / 2 - (buttonYes:GetSizeX() / 2 + 5))
      buttonNo:SetPosX(Panel_Window_MessageBox_All:GetSizeX() / 2 + (buttonNo:GetSizeX() / 2 + 5))
      buttonApply:SetPosX(Panel_Window_MessageBox_All:GetSizeX() / 2 - (buttonApply:GetSizeX() / 2 + 5))
      buttonIgnore:SetPosX(Panel_Window_MessageBox_All:GetSizeX() / 2 + (buttonIgnore:GetSizeX() / 2 + 5))
      buttonCancel:SetPosX(Panel_Window_MessageBox_All:GetSizeX() / 2 + (buttonCancel:GetSizeX() / 2 + 5))
    elseif 3 == buttonShowCount then
      local buttonSize = buttonYes:GetSizeX()
      buttonYes:SetPosX(5)
      buttonNo:SetPosX(buttonSize + 10)
      buttonApply:SetPosX(5)
      buttonIgnore:SetPosX(buttonSize + 10)
      buttonCancel:SetPosX(buttonSize * 2 + 15)
    end
    if true == currentData.isProgress then
      progress:SetShow(true)
      progress:SetProgressRate(100)
      local bgSizeY = textContent:GetTextSizeY() + static_iconArea_BG:GetSizeY() + 10
      textBG:SetSize(textBG:GetSizeX(), bgSizeY + progress:GetSizeY())
      Panel_Window_MessageBox_All:SetSize(Panel_Window_MessageBox_All:GetSizeX(), textBG:GetSizeY() + 100)
      orginPanelSizeY = Panel_Window_MessageBox_All:GetSizeY()
      progress:ComputePos()
    end
    if isConsole then
      local keyGuideTable = {static_consoleUI_A, static_consoleUI_B}
      PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyGuideTable, static_consloeUI, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHT)
    end
    _currentMessageBoxData = currentData
  end
end
function setCurrentMessageCheckData(currentData, position)
  if currentData ~= nil then
    buttonYes:SetShow(false)
    buttonNo:SetShow(false)
    buttonIgnore:SetShow(false)
    refuseInvite:SetShow(false)
    static_iconArea_BG:SetShow(false)
    buttonApply:SetShow(false)
    buttonCancel:SetShow(false)
    buttonClose:SetShow(false)
    loadSequence:SetShow(false)
    iconInven:SetShow(true)
    iconWarehouse:SetShow(true)
    Panel_Window_MessageBox_All:SetShow(true, false)
    Panel_Window_MessageBox_All:SetScaleChild(1, 1)
    if currentData.title ~= nil then
      textTitle:SetText(currentData.title)
    end
    if currentData.content ~= nil then
      textContent:SetTextMode(__eTextMode_AutoWrap)
      textContent:SetText(currentData.content)
      messageCheckBox_Resize()
    end
    local isConsole = _ContentsGroup_UsePadSnapping
    local buttonShowCount = 0
    if currentData.functionApply ~= nil then
      buttonApply:SetShow(not isConsole)
      buttonShowCount = buttonShowCount + 1
      static_consoleUI_A:SetShow(isConsole)
      static_consoleUI_A:SetText(PAGetString(Defines.StringSheet_RESOURCE, "MESSAGEBOX_BTN_APPLY_WITHOUT_KEY"))
    end
    if currentData.functionCancel ~= nil then
      buttonCancel:SetShow(not isConsole)
      buttonShowCount = buttonShowCount + 1
      static_consoleUI_B:SetShow(isConsole)
      static_consoleUI_B:SetText(PAGetString(Defines.StringSheet_RESOURCE, "MESSAGEBOX_BTN_CANCEL_WITHOUT_KEY"))
    end
    if currentData.exitButton == true then
      buttonClose:SetShow(not isConsole)
    end
    globalButtonShowCount = buttonShowCount
    if 1 == buttonShowCount then
      buttonApply:SetPosX(Panel_Window_MessageBox_All:GetSizeX() / 2 - buttonApply:GetSizeX() / 2)
      buttonCancel:SetPosX(Panel_Window_MessageBox_All:GetSizeX() / 2 - buttonCancel:GetSizeX() / 2)
    elseif 2 == buttonShowCount then
      buttonApply:SetPosX(Panel_Window_MessageBox_All:GetSizeX() / 2 - (buttonApply:GetSizeX() + 4))
      buttonCancel:SetPosX(Panel_Window_MessageBox_All:GetSizeX() / 2 + 4)
    elseif 3 == buttonShowCount then
      local buttonSize = buttonApply:GetSizeX()
      buttonApply:SetPosX(5)
      buttonCancel:SetPosX(buttonSize * 2 + 15)
    end
    if isConsole then
      local keyGuideTable = {static_consoleUI_A, static_consoleUI_B}
      PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyGuideTable, static_consloeUI, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHT)
    end
    _currentMessageBoxData = currentData
  end
end
function setKeyUseStringForBtn(keyUse)
  if nil ~= keyUse and false == keyUse then
    buttonYes:SetText(PAGetString(Defines.StringSheet_RESOURCE, "MESSAGEBOX_BTN_YES_WITHOUT_KEY"))
    buttonNo:SetText(PAGetString(Defines.StringSheet_RESOURCE, "MESSAGEBOX_BTN_NO_WITHOUT_KEY"))
    buttonApply:SetText(PAGetString(Defines.StringSheet_RESOURCE, "MESSAGEBOX_BTN_APPLY_WITHOUT_KEY"))
    buttonCancel:SetText(PAGetString(Defines.StringSheet_RESOURCE, "MESSAGEBOX_BTN_CANCEL_WITHOUT_KEY"))
  else
    buttonYes:SetText(PAGetString(Defines.StringSheet_RESOURCE, "MESSAGEBOX_BTN_YES"))
    buttonNo:SetText(PAGetString(Defines.StringSheet_RESOURCE, "MESSAGEBOX_BTN_NO"))
    buttonApply:SetText(PAGetString(Defines.StringSheet_RESOURCE, "MESSAGEBOX_BTN_APPLY"))
    buttonCancel:SetText(PAGetString(Defines.StringSheet_RESOURCE, "MESSAGEBOX_BTN_CANCEL"))
  end
end
function MessageBox.showMessageBox(MessageData, position, isGameExit, keyUse, refuseType)
  if Panel_Window_MessageBox_All:GetShow() and nil == MessageData.enablePriority then
    return
  end
  Panel_Window_MessageBox_All:RegisterUpdateFunc("messageBox_UpdatePerFrame")
  _AudioPostEvent_SystemUiForXBOX(8, 14)
  checkCustom1:SetShow(false)
  checkCustom2:SetShow(false)
  local Front = list
  local preList
  functionKeyUse = keyUse
  setKeyUseStringForBtn(functionKeyUse)
  while true do
    if list == nil or list.data.priority > MessageData.priority then
      list = {
        next = list,
        pre = preList,
        data = MessageData
      }
      if list.pre == nil then
        setCurrentMessageData(list.data, position, refuseType)
        break
      end
      list.pre.next = list
      list = Front
      break
    else
      preList = list
      list = list.next
    end
  end
  if nil ~= MessageData.countTime then
    elapsedTime = 0
  end
  updateRefuseType(refuseType)
  if true == isGameExit and ToClient_GetUserPlayMinute() < 1440 then
    Panel_Window_MessageBox_All:SetSize(441, 317)
    textBG:SetSize(420, 120)
    static_Beginner_BG:SetShow(true)
    static_BeginnerTitleBG:SetShow(true)
    staticText_BeginnerTxt1:SetShow(true)
    staticText_BeginnerTxt2:SetShow(true)
    static_Beginner_BG:ComputePos()
    static_BeginnerTitleBG:ComputePos()
    staticText_BeginnerTxt1:ComputePos()
    staticText_BeginnerTxt2:ComputePos()
  else
    static_Beginner_BG:SetShow(false)
    static_BeginnerTitleBG:SetShow(false)
    staticText_BeginnerTxt1:SetShow(false)
    staticText_BeginnerTxt2:SetShow(false)
  end
  local textSizeY = textContent:GetTextSizeY()
  local textBGSizeY = textContent:GetSizeY()
  local panelSizeY = textBG:GetSizeY()
  local resizePanelY = textSizeY + 90
  textBG:ComputePos()
  textContent:ComputePos()
  refuseInvite:ComputePos()
  refuseInvite:SetPosX(Panel_Window_MessageBox_All:GetSizeX() / 2 - (refuseInvite:GetSizeX() + refuseInvite:GetTextSizeX() / 2))
  blockBG:SetSize(getScreenSizeX() + 500, getScreenSizeY() + 500)
  blockBG:ComputePos()
  messageBoxComputePos()
  if true == _ContentsGroup_UsePadSnapping then
    ToClient_padSnapRefreshTarget(Panel_Window_MessageBox_All)
  end
end
function MessageBoxCheck.showMessageBox(MessageCheckData, position, keyUse)
  local Front = list
  local preList
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  local myInvenMoney = selfPlayer:get():getInventory():getMoney_s64()
  functionKeyUse = keyUse
  setKeyUseStringForBtn(functionKeyUse)
  while true do
    if list == nil or list.data.priority > MessageCheckData.priority then
      list = {
        next = list,
        pre = preList,
        data = MessageCheckData
      }
      if list.pre == nil then
        setCurrentMessageCheckData(list.data, position)
        break
      end
      list.pre.next = list
      list = Front
      break
    else
      preList = list
      list = list.next
    end
  end
  local useCustomButtonFlag = MessageCheckData.buttonStrings and 2 <= table.getn(MessageCheckData.buttonStrings)
  if useCustomButtonFlag then
    iconInven:SetShow(false)
    iconWarehouse:SetShow(false)
    checkCustom1:SetShow(true)
    checkCustom2:SetShow(true)
    checkCustom1:SetText(MessageCheckData.buttonStrings[1])
    checkCustom2:SetText(MessageCheckData.buttonStrings[2])
  else
    iconInven:SetShow(true)
    iconWarehouse:SetShow(true)
    checkCustom1:SetShow(false)
    checkCustom2:SetShow(false)
    if ToClient_HasWareHouseFromNpc() then
      if false == iconInven:IsCheck() and false == iconWarehouse:IsCheck() then
        if toInt64(0, 0) == warehouse_moneyFromNpcShop_s64() then
          iconInven:SetCheck(true)
          iconWarehouse:SetCheck(false)
        else
          iconInven:SetCheck(false)
          iconWarehouse:SetCheck(true)
        end
      end
      checkWarehouse:SetShow(true)
      iconWarehouse:SetShow(true)
      checkInven:SetShow(true)
      iconInven:SetShow(true)
    else
      iconInven:SetCheck(true)
      iconWarehouse:SetCheck(false)
      checkWarehouse:SetShow(false)
      iconWarehouse:SetShow(false)
      checkInven:SetShow(false)
      iconInven:SetShow(false)
    end
  end
  local padding = 10
  if false == iconWarehouse:GetShow() and false == checkCustom1:GetShow() then
    Panel_Window_MessageBox_All:SetSize(Panel_Window_MessageBox_All:GetSizeX(), orginPanelSizeY - (iconWarehouse:GetSizeY() + iconInven:GetSizeY() + padding))
  else
    Panel_Window_MessageBox_All:SetSize(Panel_Window_MessageBox_All:GetSizeX(), orginPanelSizeY)
  end
  checkInven:SetText(makeDotMoney(myInvenMoney))
  checkWarehouse:SetText(makeDotMoney(warehouse_moneyFromNpcShop_s64()))
  iconInven:SetEnableArea(0, 0, iconInven:GetSizeX(), iconInven:GetSizeY() + 3)
  iconWarehouse:SetEnableArea(0, 0, iconWarehouse:GetSizeX(), iconWarehouse:GetSizeY() + 3)
  local blockBGSizeY = Panel_Window_MessageBox_All:GetSizeY() - (padding + textTitle:GetSizeY() + padding * 3 + buttonApply:GetSizeY() + padding)
  textBG:SetSize(textBG:GetSizeX(), blockBGSizeY)
  textBG:ComputePos()
  textContent:ComputePos()
  messageBoxCheckComputePos()
  if true == _ContentsGroup_UsePadSnapping then
    if useCustomButtonFlag then
      if true == checkCustom1:IsCheck() then
        ToClient_padSnapChangeToTarget(checkCustom1)
        checkCustom1:SetCheck(true)
        checkCustom2:SetCheck(false)
      else
        ToClient_padSnapChangeToTarget(checkCustom2)
        checkCustom1:SetCheck(false)
        checkCustom2:SetCheck(true)
      end
    elseif true == iconInven:IsCheck() then
      ToClient_padSnapChangeToTarget(iconInven)
      iconInven:SetCheck(true)
      iconWarehouse:SetCheck(false)
    else
      ToClient_padSnapChangeToTarget(iconWarehouse)
      iconInven:SetCheck(false)
      iconWarehouse:SetCheck(true)
    end
    ToClient_padSnapRefreshTarget(Panel_Window_MessageBox_All)
  end
end
function PaGlobal_MessageBox_RefuseOption(refuseType)
  if 0 == refuseType then
    setRefuseRequests(refuseInvite:IsCheck())
  elseif 1 == refuseType then
    setIsPvpRefuse(refuseInvite:IsCheck())
  elseif 2 == refuseType then
    setIsExchangeRefuse(refuseInvite:IsCheck())
  elseif 3 == refuseType then
    ToClient_getGameUIManagerWrapper():setLuaCacheDataListBool(__eUiInterfaceSizeMessagePanel, refuseInvite:IsCheck(), CppEnums.VariableStorageType.eVariableStorageType_User)
  end
end
function PaGlobal_MessageBox_RefuseTip(isShow)
  if not isShow then
    TooltipSimple_Hide()
    return
  end
  local name, desc, control
  name = PAGetString(Defines.StringSheet_GAME, "LUA_MESSAGEBOX_ALWAYSREFUSE")
  desc = PAGetString(Defines.StringSheet_GAME, "LUA_MESSAGEBOX_ALWAYSREFUSE_TIP_DESC")
  control = refuseInvite
  TooltipSimple_Show(control, name, desc)
end
function MessageBoxCheck.showMessageBoxForRegion(MessageCheckData, position, keyUse)
  local Front = list
  local preList
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  local myInvenMoney = selfPlayer:get():getInventory():getMoney_s64()
  functionKeyUse = keyUse
  while true do
    if list == nil or list.data.priority > MessageCheckData.priority then
      list = {
        next = list,
        pre = preList,
        data = MessageCheckData
      }
      if list.pre == nil then
        setCurrentMessageCheckData(list.data, position)
        break
      end
      list.pre.next = list
      list = Front
      break
    else
      preList = list
      list = list.next
    end
  end
  checkCustom1:SetShow(false)
  checkCustom2:SetShow(false)
  if ToClient_HasWareHouseFromNpc() then
    if false == iconInven:IsCheck() and false == iconWarehouse:IsCheck() then
      if toInt64(0, 0) == warehouse_moneyByCurrentRegionMainTown_s64() then
        iconInven:SetCheck(true)
        iconWarehouse:SetCheck(false)
      else
        iconInven:SetCheck(false)
        iconWarehouse:SetCheck(true)
      end
    end
    checkWarehouse:SetShow(true)
    iconWarehouse:SetShow(true)
  else
    iconInven:SetCheck(true)
    iconWarehouse:SetCheck(false)
    checkWarehouse:SetShow(false)
    iconWarehouse:SetShow(false)
  end
  checkInven:SetText(makeDotMoney(myInvenMoney))
  checkWarehouse:SetText(makeDotMoney(warehouse_moneyByCurrentRegionMainTown_s64()))
  iconInven:SetEnableArea(0, 0, iconInven:GetSizeX(), iconInven:GetSizeY() + 3)
  iconWarehouse:SetEnableArea(0, 0, iconWarehouse:GetSizeX(), iconWarehouse:GetSizeY() + 3)
  local textSizeY = textContent:GetTextSizeY() + 100 + 20
  local textBGSizeY = textContent:GetSizeY()
  local panelSizeY = textBG:GetSizeY()
  local resizePanelY = textSizeY + 114
  textContent:ComputePos()
  messageBoxCheckComputePos()
  if true == _ContentsGroup_UsePadSnapping then
    ToClient_padSnapRefreshTarget(Panel_Window_MessageBox_All)
  end
end
function messageBoxComputePos()
  blockBG:SetSize(getScreenSizeX() + 500, getScreenSizeY() + 500)
  Panel_Window_MessageBox_All:ComputePos()
  textTitle:ComputePos()
  textContent:ComputePos()
  textBG:ComputePos()
  buttonYes:ComputePos()
  buttonApply:ComputePos()
  buttonNo:ComputePos()
  buttonIgnore:ComputePos()
  buttonCancel:ComputePos()
  buttonClose:ComputePos()
  blockBG:ComputePos()
  static_consloeUI:ComputePos()
  if 1 == globalButtonShowCount then
    buttonYes:SetPosX(Panel_Window_MessageBox_All:GetSizeX() / 2 - buttonYes:GetSizeX() / 2)
    buttonApply:SetPosX(Panel_Window_MessageBox_All:GetSizeX() / 2 - buttonApply:GetSizeX() / 2)
    buttonNo:SetPosX(Panel_Window_MessageBox_All:GetSizeX() / 2 - buttonNo:GetSizeX() / 2)
    buttonIgnore:SetPosX(Panel_Window_MessageBox_All:GetSizeX() / 2 - buttonIgnore:GetSizeX() / 2)
    buttonCancel:SetPosX(Panel_Window_MessageBox_All:GetSizeX() / 2 - buttonCancel:GetSizeX() / 2)
  elseif 2 == globalButtonShowCount then
    buttonYes:SetPosX(Panel_Window_MessageBox_All:GetSizeX() / 2 - (buttonYes:GetSizeX() + 4))
    buttonNo:SetPosX(Panel_Window_MessageBox_All:GetSizeX() / 2 + 4)
    buttonApply:SetPosX(Panel_Window_MessageBox_All:GetSizeX() / 2 - (buttonApply:GetSizeX() + 4))
    buttonIgnore:SetPosX(Panel_Window_MessageBox_All:GetSizeX() / 2 + 4)
    buttonCancel:SetPosX(Panel_Window_MessageBox_All:GetSizeX() / 2 + 4)
  elseif 3 == globalButtonShowCount then
    local buttonSize = buttonYes:GetSizeX()
    buttonYes:SetPosX(5)
    buttonNo:SetPosX(buttonSize + 10)
    buttonApply:SetPosX(5)
    buttonIgnore:SetPosX(buttonSize + 10)
    buttonCancel:SetPosX(buttonSize * 2 + 15)
  end
end
function messageBoxCheckComputePos()
  local padding = 10
  blockBG:SetSize(getScreenSizeX() + 500, getScreenSizeY() + 500)
  Panel_Window_MessageBox_All:ComputePos()
  local blockBGSizeY = Panel_Window_MessageBox_All:GetSizeY() - (padding + textTitle:GetSizeY() + padding * 3 + buttonApply:GetSizeY() + padding)
  textBG:SetSize(textBG:GetSizeX(), blockBGSizeY)
  textBG:ComputePos()
  textTitle:ComputePos()
  textContent:ComputePos()
  textBG:ComputePos()
  buttonApply:ComputePos()
  buttonCancel:ComputePos()
  buttonClose:ComputePos()
  iconInven:ComputePos()
  iconWarehouse:ComputePos()
  checkInven:ComputePos()
  checkWarehouse:ComputePos()
  static_consloeUI:ComputePos()
  checkCustom1:ComputePos()
  checkCustom2:ComputePos()
  iconInven:SetPosY(textContent:GetPosY() + textContent:GetSizeY() + padding * 2)
  iconWarehouse:SetPosY(iconInven:GetPosY() + iconInven:GetSizeY() + padding)
  checkCustom1:SetPosY(textContent:GetPosY() + textContent:GetSizeY() + padding * 2)
  checkCustom2:SetPosY(checkCustom1:GetPosY() + checkCustom1:GetSizeY() + padding)
  if 1 == globalButtonShowCount then
    buttonApply:SetPosX(Panel_Window_MessageBox_All:GetSizeX() / 2 - buttonApply:GetSizeX() / 2)
    buttonCancel:SetPosX(Panel_Window_MessageBox_All:GetSizeX() / 2 - buttonCancel:GetSizeX() / 2)
  elseif 2 == globalButtonShowCount then
    buttonApply:SetPosX(Panel_Window_MessageBox_All:GetSizeX() / 2 - buttonApply:GetSizeX() - 4)
    buttonCancel:SetPosX(Panel_Window_MessageBox_All:GetSizeX() / 2 + 4)
  elseif 3 == globalButtonShowCount then
    local buttonSize = buttonApply:GetSizeX()
    buttonApply:SetPosX(5)
    buttonCancel:SetPosX(buttonSize * 2 + 15)
  end
end
function postProcessMessageData()
  Panel_Window_MessageBox_All:SetShow(false, false)
  _currentMessageBoxData = nil
  if list ~= nil and list.data ~= nil then
    list.data = nil
    list = list.next
    if list ~= nil then
      setCurrentMessageData(list.data)
    end
  end
end
function postProcessMessageCheckData()
  Panel_Window_MessageBox_All:SetShow(false, false)
  _currentMessageBoxData = nil
  if list ~= nil and list.data ~= nil then
    list.data = nil
    list = list.next
    if list ~= nil then
      setCurrentMessageCheckData(list.data)
    end
  end
end
function allClearMessageData()
  Panel_Window_MessageBox_All:SetShow(false, false)
  if list == nil then
    return
  end
  while list ~= nil and list.data ~= nil do
    list.data = nil
    list = list.next
  end
end
function allClearMessageCheckData()
  Panel_Window_MessageBox_All:SetShow(false, false)
  if list == nil then
    return
  end
  while list ~= nil and list.data ~= nil do
    list.data = nil
    list = list.next
  end
end
function MessageBox.doHaveMessageBoxData(title)
  while list ~= nil and list.data ~= nil do
    if list.data.title == title then
      return true
    end
    list = list.next
  end
  if MessageBox.isCurrentOpen(title) then
    return true
  end
  return false
end
function MessageBoxCheck.doHaveMessageBoxData(title)
  while list ~= nil and list.data ~= nil do
    if list.data.title == title then
      return true
    end
    list = list.next
  end
  if MessageBoxCheck.isCurrentOpen(title) then
    return true
  end
  return false
end
function MessageBox.isPopUp()
  return Panel_Window_MessageBox_All:IsShow()
end
function MessageBoxCheck.isPopUp()
  return Panel_Window_MessageBox_All:IsShow()
end
function MessageBoxCheck.isCheck()
  local isMoneyWhereType = CppEnums.ItemWhereType.eInventory
  if iconInven:IsCheck() then
    isMoneyWhereType = CppEnums.ItemWhereType.eInventory
  elseif iconWarehouse:IsCheck() then
    isMoneyWhereType = CppEnums.ItemWhereType.eWarehouse
  else
    isMoneyWhereType = CppEnums.ItemWhereType.eInventory
  end
  return isMoneyWhereType
end
function MessageBox.isCurrentOpen(title)
  if nil ~= _currentMessageBoxData and _currentMessageBoxData.title == title then
    return true
  end
  return false
end
function MessageBoxCheck.isCurrentOpen(title)
  if nil ~= _currentMessageBoxData and _currentMessageBoxData.title == title then
    return true
  end
  return false
end
function MessageBox.keyProcessEnter()
  local enterkeyExecute
  if not functionKeyUse and nil ~= functionKeyUse then
    return
  end
  if list ~= nil and list.data.functionYes ~= nil then
    list.data.isStartTimer = true
    enterkeyExecute = list.data.functionYes
  end
  if list ~= nil and list.data.functionApply ~= nil then
    enterkeyExecute = list.data.functionApply
  end
  if list ~= nil and nil == list.data.functionYes and nil == list.data.functionApply then
    enterkeyExecute = nil
    return
  end
  if list ~= nil and list.data.clientMessage ~= nil then
    sendGameMessageParam0(list.data.clientMessage)
  end
  postProcessMessageData()
  if enterkeyExecute ~= nil then
    if false == _ContentsGroup_UsePadSnapping then
      enterkeyExecute()
    else
      enterkeyExecute(MessageBoxCheck.getSelectedButtonIndex())
    end
  end
end
function MessageBoxCheck.keyProcessEnter()
  if not functionKeyUse and nil ~= functionKeyUse then
    return
  end
  if list ~= nil and list.data.functionApply ~= nil then
    if false == _ContentsGroup_UsePadSnapping then
      list.data.functionApply()
    else
      list.data.functionApply(MessageBoxCheck.getSelectedButtonIndex())
    end
  end
  if list ~= nil and nil == list.data.functionApply then
    return
  end
  if list ~= nil and list.data.clientMessage ~= nil then
    sendGameMessageParam0(list.data.clientMessage)
  end
  postProcessMessageCheckData()
end
function MessageBox.keyProcessEscape()
  if not functionKeyUse and nil ~= functionKeyUse then
    return
  end
  if list ~= nil and (list.data.exitButton or list.data.functionCancel or list.data.functionNo) then
    messageBox_CloseButtonUp()
  end
end
function MessageBoxCheck.keyProcessEscape()
  if not functionKeyUse and nil ~= functionKeyUse then
    return
  end
  if list ~= nil and (list.data.exitButton or list.data.functionCancel) then
    messageBoxCheck_CloseButtonUp()
  end
end
function MessageBox_ShowAni()
  local aniInfo8 = Panel_Window_MessageBox_All:addColorAnimation(0, 0.15, UI_ANI_ADV.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfo8:SetStartColor(UI_color.C_00FFFFFF)
  aniInfo8:SetEndColor(UI_color.C_FFFFFFFF)
  aniInfo8:SetStartIntensity(5)
  aniInfo8:SetEndIntensity(1)
  local aniInfo1 = Panel_Window_MessageBox_All:addScaleAnimation(0, 0.08, UI_ANI_ADV.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfo1:SetStartScale(0.1)
  aniInfo1:SetEndScale(1.1)
  aniInfo1.AxisX = Panel_Window_MessageBox_All:GetSizeX() / 2
  aniInfo1.AxisY = Panel_Window_MessageBox_All:GetSizeY() / 2
  aniInfo1.ScaleType = 2
  aniInfo1.IsChangeChild = true
  local aniInfo2 = Panel_Window_MessageBox_All:addScaleAnimation(0.08, 0.14, UI_ANI_ADV.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfo2:SetStartScale(1.1)
  aniInfo2:SetEndScale(1)
  aniInfo2.AxisX = Panel_Window_MessageBox_All:GetSizeX() / 2
  aniInfo2.AxisY = Panel_Window_MessageBox_All:GetSizeY() / 2
  aniInfo2.ScaleType = 2
  aniInfo2.IsChangeChild = true
end
function MessageBoxCheck_ShowAni()
  local aniInfo8 = Panel_Window_MessageBox_All:addColorAnimation(0, 0.15, UI_ANI_ADV.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfo8:SetStartColor(UI_color.C_00FFFFFF)
  aniInfo8:SetEndColor(UI_color.C_FFFFFFFF)
  aniInfo8:SetStartIntensity(5)
  aniInfo8:SetEndIntensity(1)
  local aniInfo1 = Panel_Window_MessageBox_All:addScaleAnimation(0, 0.08, UI_ANI_ADV.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfo1:SetStartScale(0.1)
  aniInfo1:SetEndScale(1.1)
  aniInfo1.AxisX = Panel_Window_MessageBox_All:GetSizeX() / 2
  aniInfo1.AxisY = Panel_Window_MessageBox_All:GetSizeY() / 2
  aniInfo1.ScaleType = 2
  aniInfo1.IsChangeChild = true
  local aniInfo2 = Panel_Window_MessageBox_All:addScaleAnimation(0.08, 0.14, UI_ANI_ADV.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfo2:SetStartScale(1.1)
  aniInfo2:SetEndScale(1)
  aniInfo2.AxisX = Panel_Window_MessageBox_All:GetSizeX() / 2
  aniInfo2.AxisY = Panel_Window_MessageBox_All:GetSizeY() / 2
  aniInfo2.ScaleType = 2
  aniInfo2.IsChangeChild = true
  _AudioPostEvent_SystemUiForXBOX(8, 14)
end
function MessageBox_HideAni()
  _AudioPostEvent_SystemUiForXBOX(50, 3)
  Panel_Window_MessageBox_All:SetShow(false, false)
end
function MessageBoxCheck_HideAni()
  _AudioPostEvent_SystemUiForXBOX(50, 3)
  Panel_Window_MessageBox_All:SetShow(false, false)
end
function MessageBox_GetPadState()
  if false == _ContentsGroup_UsePadSnapping then
    return
  end
  return isPadDisConnect
end
function MessageBox_SetPadState(set)
  if false == _ContentsGroup_UsePadSnapping then
    return
  end
  isPadDisConnect = set
end
function messageBox_YesButtonUp()
  local functionYes
  if list ~= nil and list.data.functionYes ~= nil then
    list.data.isStartTimer = true
    functionYes = list.data.functionYes
  end
  if list ~= nil and list.data.clientMessage ~= nil then
    sendGameMessageParam0(list.data.clientMessage)
  end
  postProcessMessageData()
  if functionYes ~= nil then
    functionYes()
  end
  _AudioPostEvent_SystemUiForXBOX(50, 1)
end
function messageBox_ApplyButtonUp()
  local functionApply
  if list ~= nil and list.data.functionApply ~= nil then
    elapsedTime = 0
    functionApply = list.data.functionApply
  end
  if list ~= nil and list.data.clientMessage ~= nil then
    sendGameMessageParam0(list.data.clientMessage)
  end
  postProcessMessageData()
  if functionApply ~= nil then
    functionApply()
  end
  _AudioPostEvent_SystemUiForXBOX(50, 1)
end
function messageBoxCheck_ApplyButtonUp()
  local functionApply
  if list ~= nil and list.data.functionApply ~= nil then
    elapsedTime = 0
    functionApply = list.data.functionApply
  end
  if list ~= nil and list.data.clientMessage ~= nil then
    sendGameMessageParam0(list.data.clientMessage)
  end
  postProcessMessageCheckData()
  if functionApply ~= nil then
    if false == _ContentsGroup_UsePadSnapping then
      functionApply()
    else
      functionApply(MessageBoxCheck.getSelectedButtonIndex())
    end
  end
  _AudioPostEvent_SystemUiForXBOX(50, 1)
end
function messageBox_NoButtonUp()
  local functionNo
  if list ~= nil and list.data.functionNo ~= nil then
    functionNo = list.data.functionNo
  end
  postProcessMessageData()
  if functionNo ~= nil then
    functionNo()
  end
end
function messageBox_IgnoreButtonUp()
  local functionIgnore
  if list ~= nil and list.data.functionIgnore ~= nil then
    functionIgnore = list.data.functionIgnore
  end
  postProcessMessageData()
  if functionIgnore ~= nil then
    functionIgnore()
  end
end
function messageBox_CancelButtonUp()
  local functionCancel
  if list ~= nil and list.data.functionCancel ~= nil then
    elapsedTime = 0
    functionCancel = list.data.functionCancel
  end
  postProcessMessageData()
  if functionCancel ~= nil then
    functionCancel()
  end
end
function messageBoxCheck_CancelButtonUp()
  local functionCancel
  if list ~= nil and list.data.functionCancel ~= nil then
    elapsedTime = 0
    functionCancel = list.data.functionCancel
  end
  postProcessMessageCheckData()
  if functionCancel ~= nil then
    functionCancel()
  end
end
function messageBox_CloseButtonUp()
  local functionNo
  if list ~= nil and list.data.functionNo ~= nil then
    functionNo = list.data.functionNo
  end
  local functionCancel
  if list ~= nil and list.data.functionCancel ~= nil then
    functionCancel = list.data.functionCancel
  elseif true == isCancelClose then
    MessageBox_Empty_function()
  end
  postProcessMessageData()
  if functionNo ~= nil then
    functionNo()
  end
  if functionCancel ~= nil then
    functionCancel()
  end
end
function messageBoxCheck_CloseButtonUp()
  local functionCancel
  if list ~= nil and list.data.functionCancel ~= nil then
    functionCancel = list.data.functionCancel
  elseif true == isCancelClose then
    MessageBoxCheck_Empty_function()
  end
  postProcessMessageCheckData()
  if functionCancel ~= nil then
    functionCancel()
  end
end
function Event_MessageBox_NotifyMessage_CashAlert(message)
  local titleText = PAGetString(Defines.StringSheet_GAME, "LUA_MESSAGEBOX_NOTIFY")
  local messageboxData = {
    title = titleText,
    content = message,
    functionApply = MessageBox_Empty_function,
    priority = UI_PP.PAUIMB_PRIORITY_LOW,
    exitButton = false
  }
  MessageBox.showMessageBox(messageboxData, "top")
end
function Event_MessageBox_NotifyMessage(message)
  if nil ~= Panel_CharacterSelect_Renew and true == Panel_CharacterSelect_Renew:GetShow() then
    PaGlobal_CharacterSelect_SetBlockSelectFalse()
  end
  local titleText = PAGetString(Defines.StringSheet_GAME, "LUA_MESSAGEBOX_NOTIFY")
  local messageboxData = {
    title = titleText,
    content = message,
    functionApply = MessageBox_Empty_function,
    priority = UI_PP.PAUIMB_PRIORITY_LOW,
    exitButton = false
  }
  MessageBox.showMessageBox(messageboxData)
end
function Event_MessageBox_NotifyMessage_FreeButton(message)
  if true == _ContentsGroup_UsePadSnapping then
    local messageboxData = {
      title = "",
      content = message,
      priority = UI_PP.PAUIMB_PRIORITY_LOW,
      exitButton = false
    }
    MessageBox.showMessageBox(messageboxData)
  else
    local messageboxData = {
      title = "",
      content = message,
      priority = UI_PP.PAUIMB_PRIORITY_1,
      exitButton = false
    }
    MessageBox.showMessageBox(messageboxData)
  end
end
function Event_MessageBox_NotifyMessage_With_ClientMessage(message, gameMessageType)
  local titleText = PAGetString(Defines.StringSheet_GAME, "LUA_MESSAGEBOX_NOTIFY")
  local messageboxData = {
    title = titleText,
    content = message,
    functionApply = MessageBox_Empty_function,
    priority = UI_PP.PAUIMB_PRIORITY_1,
    clientMessage = gameMessageType,
    exitButton = false
  }
  MessageBox.showMessageBox(messageboxData)
end
function Event_MessageBox_ConsoleDisconnect(message, gameMessageType)
  local titleText = PAGetString(Defines.StringSheet_GAME, "LUA_MESSAGEBOX_NOTIFY")
  local messageboxData = {
    title = titleText,
    content = message,
    functionApply = disConnectToGame,
    priority = UI_PP.PAUIMB_PRIORITY_1,
    clientMessage = gameMessageType,
    exitButton = false
  }
  MessageBox.showMessageBox(messageboxData)
end
function Event_MessageBox_NotifyMessage_EnablePriority(message)
  local curUIMode
  if true == ToClient_isGamePlayProcessor() then
    curUIMode = GetUIMode()
    if curUIMode == Defines.UIMode.eUIMode_MiniGame and nil ~= curUIMode then
      isPadDisConnect = true
    end
  end
  if nil ~= GetFocusEdit() then
    ClearFocusEdit()
  end
  local titleText = PAGetString(Defines.StringSheet_GAME, "LUA_MESSAGEBOX_NOTIFY")
  local messageboxData = {
    title = titleText,
    content = message,
    functionApply = MessageBox_Empty_function,
    priority = UI_PP.PAUIMB_PRIORITY_2,
    exitButton = false,
    enablePriority = true
  }
  MessageBox.showMessageBox(messageboxData)
end
function Event_MessageBox_Update_NotifyMessage(message)
  if false == MessageBoxGetShow() then
    return
  end
  if nil ~= message then
    textContent:SetTextMode(__eTextMode_AutoWrap)
    textContent:SetText(message)
    messageBox_Resize()
    messageBoxComputePos()
  end
end
function Event_MessageBoxCheck_NotifyMessage_CashAlert(message)
  local titleText = PAGetString(Defines.StringSheet_GAME, "LUA_MESSAGEBOX_NOTIFY")
  local messageboxData = {
    title = titleText,
    content = message,
    functionApply = MessageBox_Empty_function,
    priority = UI_PP.PAUIMB_PRIORITY_LOW,
    exitButton = false
  }
  MessageBoxCheck.showMessageBox(messageboxData, "top")
end
function Event_MessageBoxCheck_NotifyMessage(message)
  local titleText = PAGetString(Defines.StringSheet_GAME, "LUA_MESSAGEBOX_NOTIFY")
  local messageboxData = {
    title = titleText,
    content = message,
    functionApply = MessageBox_Empty_function,
    priority = UI_PP.PAUIMB_PRIORITY_LOW,
    exitButton = false
  }
  MessageBoxCheck.showMessageBox(messageboxData)
end
function Event_MessageBoxCheck_NotifyMessage_FreeButton(message)
  local messageboxData = {
    title = "",
    content = message,
    priority = UI_PP.PAUIMB_PRIORITY_1,
    exitButton = false
  }
  MessageBoxCheck.showMessageBox(messageboxData)
end
function Event_MessageBoxCheck_NotifyMessage_With_ClientMessage(message, gameMessageType)
  local titleText = PAGetString(Defines.StringSheet_GAME, "LUA_MESSAGEBOX_NOTIFY")
  local messageboxData = {
    title = titleText,
    content = message,
    functionApply = MessageBox_Empty_function,
    priority = UI_PP.PAUIMB_PRIORITY_1,
    clientMessage = gameMessageType,
    exitButton = false
  }
  MessageBoxCheck.showMessageBox(messageboxData)
end
function MessageBox_Empty_function()
  _AudioPostEvent_SystemUiForXBOX(50, 3)
end
function MessageBoxCheck_Empty_function()
  _AudioPostEvent_SystemUiForXBOX(50, 3)
end
function MessageBoxCheck.getSelectedButtonIndex()
  if checkCustom1:IsCheck() then
    return 1
  elseif checkCustom2:IsCheck() then
    return 2
  end
  return 0
end
function messageBox_UpdatePerFrame(deltaTime)
  if nil == list or nil == list.data or nil == list.data.isTimeCount or false == list.data.isStartTimer then
    return
  end
  elapsedTime = elapsedTime + deltaTime
  if elapsedTime < list.data.countTime then
    if nil ~= list.data.timeString or true == list.data.isProgress then
      local remainTime = math.floor(list.data.countTime - elapsedTime)
      if true == list.data.isProgress then
        progress:SetShow(true)
        local rate = (list.data.countTime - elapsedTime) / list.data.countTime * 100
        progress:SetProgressRate(rate)
      else
        textTitle:SetText(remainTime .. list.data.timeString)
      end
    end
  elseif nil ~= list.data.afterFunction then
    list.data.isTimeCount = false
    list.data.isProgress = false
    list.data.afterFunction()
  end
end
function messageBoxCheck_UpdatePerFrame(deltaTime)
  if nil == list or nil == list.data or nil == list.data.isTimeCount or false == list.data.isStartTimer then
    return
  end
  elapsedTime = elapsedTime + deltaTime
  if elapsedTime < list.data.countTime then
    if nil ~= list.data.timeString then
      local remainTime = math.floor(list.data.countTime - elapsedTime)
      textTitle:SetText(remainTime .. list.data.timeString)
    end
  elseif nil ~= list.data.afterFunction then
    list.data.isTimeCount = false
    list.data.afterFunction()
  end
end
local function postRestoreEvent()
  if nil == _currentMessageBoxData then
    return
  end
  setCurrentMessageData(_currentMessageBoxData)
end
local function postRestoreEventMessageBoxCheck()
  if nil == _currentMessageBoxData then
    return
  end
  setCurrentMessageCheckData(_currentMessageBoxData)
end
buttonYes:addInputEvent("Mouse_LUp", "messageBox_YesButtonUp()")
buttonApply:addInputEvent("Mouse_LUp", "messageBox_ApplyButtonUp()")
buttonNo:addInputEvent("Mouse_LUp", "messageBox_NoButtonUp()")
buttonIgnore:addInputEvent("Mouse_LUp", "messageBox_IgnoreButtonUp()")
buttonCancel:addInputEvent("Mouse_LUp", "messageBox_CancelButtonUp()")
buttonClose:addInputEvent("Mouse_LUp", "messageBox_CloseButtonUp()")
buttonApply:addInputEvent("Mouse_LUp", "messageBoxCheck_ApplyButtonUp()")
buttonCancel:addInputEvent("Mouse_LUp", "messageBoxCheck_CancelButtonUp()")
buttonClose:addInputEvent("Mouse_LUp", "messageBoxCheck_CloseButtonUp()")
registerEvent("EventNotifyMessage", "Event_MessageBox_NotifyMessage")
registerEvent("EventNotifyMessageFreeButton", "Event_MessageBox_NotifyMessage_FreeButton")
registerEvent("EventNotifyFreeButtonMessageProcess", "postProcessMessageData")
registerEvent("EventNotifyAllClearMessageData", "allClearMessageData")
registerEvent("FromClient_DisconnectMessageBoxForConsole", "Event_MessageBox_ConsoleDisconnect")
registerEvent("EventNotifyMessageWithClientMessage", "Event_MessageBox_NotifyMessage_With_ClientMessage")
registerEvent("EventNotifyMessageEnablePriority", "Event_MessageBox_NotifyMessage_EnablePriority")
registerEvent("EventUpdateNotifyMessage", "Event_MessageBox_Update_NotifyMessage")
registerEvent("EventNotifyMessageDiffrentPadOption", "Event_MessageBox_DiffrentPadOption")
Panel_Window_MessageBox_All:RegisterUpdateFunc("messageBox_UpdatePerFrame")
Panel_Window_MessageBox_All:registerPadEvent(__eConsoleUIPadEvent_Up_A, "MessageBox.keyProcessEnter()")
Panel_Window_MessageBox_All:RegisterUpdateFunc("messageBoxCheck_UpdatePerFrame")
Panel_Window_MessageBox_All:registerPadEvent(__eConsoleUIPadEvent_DpadUp, "PaGlobalFunc_MessageCheck_Check_Up()")
Panel_Window_MessageBox_All:registerPadEvent(__eConsoleUIPadEvent_DpadDown, "PaGlobalFunc_MessageCheck_Check_Down()")
function PaGlobalFunc_MessageCheck_Check_Up()
  if true == checkCustom1:GetShow() then
    checkCustom1:SetCheck(true)
    checkCustom2:SetCheck(false)
    ToClient_padSnapChangeToTarget(checkCustom1)
    _AudioPostEvent_SystemUiForXBOX(50, 0)
  else
    if false == iconInven:GetShow() or false == iconWarehouse:GetShow() then
      return
    end
    iconInven:SetCheck(true)
    iconWarehouse:SetCheck(false)
    ToClient_padSnapChangeToTarget(iconInven)
    _AudioPostEvent_SystemUiForXBOX(50, 0)
  end
end
function PaGlobalFunc_MessageCheck_Check_Down()
  if true == checkCustom1:GetShow() then
    checkCustom1:SetCheck(false)
    checkCustom2:SetCheck(true)
    ToClient_padSnapChangeToTarget(checkCustom2)
    _AudioPostEvent_SystemUiForXBOX(50, 0)
  else
    if false == iconInven:GetShow() or false == iconWarehouse:GetShow() then
      return
    end
    iconInven:SetCheck(false)
    iconWarehouse:SetCheck(true)
    ToClient_padSnapChangeToTarget(iconWarehouse)
    _AudioPostEvent_SystemUiForXBOX(50, 0)
  end
end
function NotifyMessage_CashAlert(message)
  Event_MessageBox_NotifyMessage_CashAlert(message)
  Event_MessageBoxCheck_NotifyMessage_CashAlert(message)
end
function Event_MessageBox_DiffrentPadOption(message)
  if nil == message or false == _ContentsGroup_useUISnappingOption then
    return
  end
  local SetUsePadControlPC_Yes = function()
    ToClient_SetUsePadControlPC(true)
  end
  local SetUsePadControlPC_No = function()
    ToClient_SetUsePadControlPC(false)
  end
  local titleText = PAGetString(Defines.StringSheet_GAME, "LUA_MESSAGEBOX_NOTIFY")
  local messageboxData = {
    title = titleText,
    content = message,
    functionYes = SetUsePadControlPC_Yes,
    functionNo = SetUsePadControlPC_No,
    priority = UI_PP.PAUIMB_PRIORITY_2,
    exitButton = false,
    enablePriority = true
  }
  MessageBox.showMessageBox(messageboxData)
end
registerEvent("EventNotifyMessageCashAlert", "NotifyMessage_CashAlert")
