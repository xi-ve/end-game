function PaGlobal_FriendMessangerManager_All:createMessanger(messangerId, userName, isOnline)
  local messanger = {
    _mainPanel = nil,
    _uiTitleBg = nil,
    _uiClose = nil,
    _uiEnter = nil,
    _uiEditInputChat = nil,
    _uiStaticTitle = nil,
    _uiStaticTitleImg = nil,
    _uiSizeControl = nil,
    _uiSlider = nil,
    _uiSliderButton = nil,
    _uiFrame = nil,
    _uiFrameContent = nil,
    _uiFrameScroll = nil,
    _uiStaticText = {},
    _uiStaticBg = {},
    _messangerAlpha = 1,
    _messageCount = 0,
    _isCallShow = false
  }
  function messanger:initialize(messangerId, userName, isOnline)
    messanger:createPanel(messangerId, isOnline)
    messanger:prepareControl(messangerId, userName, isOnline)
    PaGlobal_FriendMessangerManager_All._messangerMinSizeX = messanger._mainPanel:GetSizeX()
    PaGlobal_FriendMessangerManager_All._messangerMinSizeY = messanger._mainPanel:GetSizeY()
  end
  function messanger:clear()
    UI.deletePanel(messanger._mainPanel:GetID())
    messanger._mainPanel = nil
  end
  function messanger:createPanel(messangerId, isOnline)
    local newName = "Panel_FriendMessanger" .. messangerId
    messanger._mainPanel = UI.createPanel(newName, Defines.UIGroup.PAGameUIGroup_WorldMap_Popups)
    CopyBaseProperty(Panel_Friend_Messanger_All, messanger._mainPanel)
    messanger._mainPanel:SetDragAll(true)
    messanger._mainPanel:SetShow(true)
    messanger._mainPanel:addInputEvent("Mouse_UpScroll", "FriendMessanger_OnMouseWheel( " .. messangerId .. ", true )")
    messanger._mainPanel:addInputEvent("Mouse_DownScroll", "FriendMessanger_OnMouseWheel( " .. messangerId .. ", false )")
    if true == _ContentsGroup_UsePadSnapping then
      messanger._mainPanel:registerPadEvent(__eConsoleUIPadEvent_Up_X, "FriendMessanger_SetFocusEdit(" .. messangerId .. ")")
      messanger._mainPanel:registerPadEvent(__eConsoleUIPadEvent_RStickUp, "FriendMessanger_OnMouseWheel( " .. messangerId .. ", true )")
      messanger._mainPanel:registerPadEvent(__eConsoleUIPadEvent_RStickDown, "FriendMessanger_OnMouseWheel( " .. messangerId .. ", false )")
      registerCloseLuaEvent(messanger._mainPanel, PAUIRenderModeBitSet({
        Defines.CloseType.eCloseType_Escape
      }), "FriendMessanger_Close(" .. messangerId .. ")")
    end
  end
  function messanger:prepareControl(messangerId, userName, isOnline)
    messanger._uiTitleBg = messanger:createControl(__ePAUIControl_Static, Panel_Friend_Messanger_All, messanger._mainPanel, "Static_TitleBarBG", 0)
    messanger._uiStaticTitle = messanger:createControl(__ePAUIControl_StaticText, Panel_Friend_Messanger_All, messanger._mainPanel, "StaticText_TitleName", 0)
    messanger._uiStaticTitle:SetText(userName)
    messanger._uiStaticTitleImg = messanger:createControl(__ePAUIControl_Static, Panel_Friend_Messanger_All, messanger._mainPanel, "Static_TitleImage", 0)
    messanger._uiSlider = messanger:createControl(__ePAUIControl_Slider, Panel_Friend_Messanger_All, messanger._mainPanel, "Slider_Alpha", 0)
    messanger._uiSlider:SetInterval(100)
    messanger._uiSlider:SetControlPos(100)
    messanger._uiSlider:addInputEvent("Mouse_LUp", "FriendMessanger_AlphaSlider( " .. messangerId .. ")")
    messanger._uiSliderButton = messanger._uiSlider:GetControlButton()
    messanger._uiSliderButton:addInputEvent("Mouse_LPress", "FriendMessanger_AlphaSlider( " .. messangerId .. ")")
    messanger._uiClose = messanger:createControl(__ePAUIControl_Button, Panel_Friend_Messanger_All, messanger._mainPanel, "Button_Close", 0)
    messanger._uiClose:addInputEvent("Mouse_LUp", "FriendMessanger_Close(" .. messangerId .. ")")
    messanger._subBG = messanger:createControl(__ePAUIControl_Static, Panel_Friend_Messanger_All, messanger._mainPanel, "Static_SubBg", 0)
    messanger._subBG:addInputEvent("Mouse_UpScroll", "FriendMessanger_OnMouseWheel( " .. messangerId .. ", true )")
    messanger._subBG:addInputEvent("Mouse_DownScroll", "FriendMessanger_OnMouseWheel( " .. messangerId .. ", false )")
    messanger._uiFrame = messanger:createControl(__ePAUIControl_Frame, Panel_Friend_Messanger_All, messanger._mainPanel, "Frame_1", 0)
    messanger._uiFrameContent = messanger._uiFrame:GetFrameContent()
    messanger._uiFrameScroll = messanger._uiFrame:GetVScroll()
    messanger._uiFrameHScroll = messanger._uiFrame:GetHScroll()
    local styleFrame = UI.getChildControl(Panel_Friend_Messanger_All, "Frame_1")
    local styleScroll = UI.getChildControl(styleFrame, "Frame_1_VerticalScroll")
    CopyBaseProperty(styleScroll, messanger._uiFrameScroll)
    messanger._uiFrameHScroll:SetIgnoreChild(true)
    messanger._uiEnter = messanger:createControl(__ePAUIControl_Button, Panel_Friend_Messanger_All, messanger._mainPanel, "Button_Enter", 0)
    messanger._uiEnter:addInputEvent("Mouse_LUp", "friend_sendMessage(" .. messangerId .. ")")
    local btn_Enter = UI.getChildControl(Panel_Friend_Messanger_All, "Button_Enter")
    messanger._uiEnterIcon = messanger:createControl(__ePAUIControl_Static, btn_Enter, messanger._uiEnter, "Static_EnterIcon", 0)
    messanger._uiEditInputChat = messanger:createControl(__ePAUIControl_Edit, Panel_Friend_Messanger_All, messanger._mainPanel, "Edit_InputChat", 0)
    messanger._uiEditInputChat:SetMaxInput(100)
    if isOnline then
      messanger._uiEditInputChat:SetEnable(true)
      messanger._uiEnter:SetEnable(true)
      messanger._uiEditInputChat:addInputEvent("Mouse_LUp", "FriendMessanger_SetFocusEdit(" .. messangerId .. ")")
      if true == _ContentsGroup_RenewUI then
        messanger._uiEditInputChat:setXboxVirtualKeyBoardEndEvent("friend_sendMessageByKey")
      else
        messanger._uiEditInputChat:RegistReturnKeyEvent("friend_sendMessageByKey()")
      end
    else
      messanger._uiEditInputChat:SetEnable(false)
      messanger._uiEnter:SetEnable(false)
    end
    messanger._uiSizeControl = messanger:createControl(__ePAUIControl_Button, Panel_Friend_Messanger_All, messanger._mainPanel, "Button_SizeControl", 0)
    messanger._uiSizeControl:addInputEvent("Mouse_LDown", "FriendMessanger_ResizeStartPos( " .. messangerId .. " )")
    messanger._uiSizeControl:addInputEvent("Mouse_LPress", "FriendMessanger_Resize( " .. messangerId .. " )")
    messanger._keyguideBg = messanger:createControl(__ePAUIControl_Static, Panel_Friend_Messanger_All, messanger._mainPanel, "Static_KeyGuide_Console", 0)
    local keyguideBg = UI.getChildControl(Panel_Friend_Messanger_All, "Static_KeyGuide_Console")
    messanger._keyguideClose = messanger:createControl(__ePAUIControl_StaticText, keyguideBg, messanger._keyguideBg, "StaticText_Close_Console", 0)
    messanger._keyguideSend = messanger:createControl(__ePAUIControl_StaticText, keyguideBg, messanger._keyguideBg, "StaticText_Send_Console", 0)
    messanger._keyguideScroll = messanger:createControl(__ePAUIControl_StaticText, keyguideBg, messanger._keyguideBg, "StaticText_Scroll_Console", 0)
    if true == _ContentsGroup_UsePadSnapping then
      messanger._keyguideBg:SetShow(true)
      messanger._uiEditInputChat:SetSize(messanger._uiEditInputChat:GetSizeX() + messanger._uiEnter:GetSizeX(), messanger._uiEditInputChat:GetSizeY())
      messanger._uiClose:SetShow(false)
      messanger._uiEnter:SetShow(false)
      messanger._uiSizeControl:SetShow(false)
      messanger._keyguideBg:ComputePos()
    else
      messanger._keyguideBg:SetShow(false)
    end
  end
  function messanger:createControl(controlType, parentStyleControl, parentControl, controlName, index)
    local styleControl = UI.getChildControl(parentStyleControl, controlName)
    local control = UI.createControl(controlType, parentControl, controlName .. index)
    CopyBaseProperty(styleControl, control)
    return control
  end
  function messanger:clearAllMessage()
    for index = 0, messanger._messageCount - 1 do
      messanger._uiStaticText[index]:SetShow(false)
      messanger._uiStaticBg[index]:SetShow(false)
      UI.deleteControl(messanger._uiStaticText[index])
      UI.deleteControl(messanger._uiStaticBg[index])
    end
    messanger._messageCount = 0
  end
  function messanger:updateMessage(chattingMessage)
    local msg = chattingMessage:getContent()
    local isMe = chattingMessage.isMe
    messanger:showMessage(isMe, msg)
    messanger._messageCount = messanger._messageCount + 1
  end
  function messanger:showMessage(isMe, msg)
    messanger:createMessageUI(isMe)
    messanger:resizeMessageUI(msg)
    messanger:setPosMessageUI(isMe)
  end
  function messanger:resizeMessageUI(msg)
    local panelSizeX = messanger._mainPanel:GetSizeX()
    local maxTextSizeX = panelSizeX - 100
    local staticText = messanger._uiStaticText[messanger._messageCount]
    local staticBg = messanger._uiStaticBg[messanger._messageCount]
    staticText:SetSize(maxTextSizeX, staticText:GetSizeY())
    staticText:SetAutoResize(true)
    staticText:SetTextMode(__eTextMode_AutoWrap)
    staticText:SetText(msg)
    staticBg:SetSize(staticText:GetTextSizeX() + 20, staticText:GetSizeY() + 10)
  end
  function messanger:createMessageUI(isMe)
    local styleBg = UI.getChildControl(Panel_Friend_Messanger_All, "Static_To")
    local styleText = UI.getChildControl(Panel_Friend_Messanger_All, "StaticText_To")
    if false == isMe then
      styleBg = UI.getChildControl(Panel_Friend_Messanger_All, "Static_From")
      styleText = UI.getChildControl(Panel_Friend_Messanger_All, "StaticText_From")
    end
    messanger._uiStaticBg[messanger._messageCount] = UI.createControl(__ePAUIControl_Static, messanger._uiFrameContent, "Static_BG_" .. messanger._messageCount)
    messanger._uiStaticText[messanger._messageCount] = UI.createControl(__ePAUIControl_StaticText, messanger._uiFrameContent, "Static_Text_" .. messanger._messageCount)
    CopyBaseProperty(styleBg, messanger._uiStaticBg[messanger._messageCount])
    CopyBaseProperty(styleText, messanger._uiStaticText[messanger._messageCount])
    messanger._uiStaticBg[messanger._messageCount]:SetShow(true)
    messanger._uiStaticText[messanger._messageCount]:SetIgnore(true)
    messanger._uiStaticText[messanger._messageCount]:SetShow(true)
  end
  function messanger:setPosMessageUI(isMe)
    local prevBgPosY = 0
    local prevBgSizeY = 0
    if 0 < messanger._messageCount then
      prevBgPosY = messanger._uiStaticBg[messanger._messageCount - 1]:GetPosY()
      prevBgSizeY = messanger._uiStaticBg[messanger._messageCount - 1]:GetSizeY()
    end
    if false == isMe then
      messanger._uiStaticBg[messanger._messageCount]:SetPosX(5)
    else
      messanger._uiStaticBg[messanger._messageCount]:SetPosX(messanger._uiFrameScroll:GetPosX() - messanger._uiStaticBg[messanger._messageCount]:GetSizeX() - 20)
    end
    messanger._uiStaticText[messanger._messageCount]:SetPosX(messanger._uiStaticBg[messanger._messageCount]:GetPosX() + 10)
    messanger._uiStaticBg[messanger._messageCount]:SetPosY(prevBgPosY + prevBgSizeY + 5)
    messanger._uiStaticText[messanger._messageCount]:SetPosY(messanger._uiStaticBg[messanger._messageCount]:GetPosY() + 1)
  end
  messanger:initialize(messangerId, userName, isOnline)
  return messanger
end
function FriendMessanger_AlphaSlider(messangerId)
  local messanger = PaGlobal_FriendMessangerManager_All._messangerList[messangerId]
  local panel = PaGlobal_FriendMessangerManager_All._messangerList[messangerId]._mainPanel
  local subBG = PaGlobal_FriendMessangerManager_All._messangerList[messangerId]._subBG
  messanger._messangerAlpha = math.max(messanger._uiSlider:GetControlPos(), 0.1)
  panel:SetAlpha(messanger._messangerAlpha)
  subBG:SetAlpha(messanger._messangerAlpha)
end
local orgMouseX = 0
local orgMouseY = 0
local orgPanelSizeX = 0
local orgPanelSizeY = 0
local orgPanelPosY = 0
local scrollPos = 0
function FriendMessanger_ResizeStartPos(messangerId)
  local panel = PaGlobal_FriendMessangerManager_All._messangerList[messangerId]._mainPanel
  orgMouseX = getMousePosX()
  orgMouseY = getMousePosY()
  orgPanelPosX = panel:GetPosX()
  orgPanelSizeX = panel:GetSizeX()
  orgPanelSizeY = panel:GetSizeY()
  scrollPos = PaGlobal_FriendMessangerManager_All._messangerList[messangerId]._uiFrameScroll:GetControlPos()
end
function FriendMessanger_Resize(messangerId)
  local messanger = PaGlobal_FriendMessangerManager_All._messangerList[messangerId]
  local panel = messanger._mainPanel
  local currentPosX = panel:GetPosX()
  local currentX = getMousePosX()
  local currentY = getMousePosY()
  local deltaX = orgMouseX - currentX
  local deltaY = currentY - orgMouseY
  local sizeX = orgPanelSizeX + deltaX
  local sizeY = orgPanelSizeY + deltaY
  if sizeX > PaGlobal_FriendMessangerManager_All._messangerMaxSizeX then
    sizeX = PaGlobal_FriendMessangerManager_All._messangerMaxSizeX
  elseif sizeX < PaGlobal_FriendMessangerManager_All._messangerMinSizeX then
    sizeX = PaGlobal_FriendMessangerManager_All._messangerMinSizeX
  end
  if sizeY > PaGlobal_FriendMessangerManager_All._messangerMaxSizeY then
    sizeY = PaGlobal_FriendMessangerManager_All._messangerMaxSizeY
  elseif sizeY < PaGlobal_FriendMessangerManager_All._messangerMinSizeY then
    sizeY = PaGlobal_FriendMessangerManager_All._messangerMinSizeY
  end
  local currentSizeX = panel:GetSizeX()
  local currentSizeY = panel:GetSizeY()
  local titleSizeY = 50
  local gap = 10
  panel:SetSize(sizeX, sizeY)
  panel:SetPosX(currentPosX + currentSizeX - sizeX)
  messanger._uiTitleBg:SetSize(sizeX - 2, titleSizeY)
  messanger._subBG:SetSize(sizeX - 2, sizeY - titleSizeY)
  messanger._uiClose:SetPosX(panel:GetSizeX() - messanger._uiClose:GetSizeX() - gap)
  messanger._uiSlider:SetPosX(messanger._uiClose:GetPosX() - messanger._uiSlider:GetSizeX() - gap)
  messanger._uiSizeControl:SetPosY(panel:GetSizeY() - messanger._uiSizeControl:GetSizeY())
  messanger._uiEditInputChat:SetPosX(gap)
  messanger._uiEditInputChat:SetPosY(panel:GetSizeY() - messanger._uiEditInputChat:GetSizeY() - gap)
  messanger._uiEditInputChat:SetSize(panel:GetSizeX() - messanger._uiEnter:GetSizeX() - gap * 2, messanger._uiEditInputChat:GetSizeY())
  messanger._uiEnter:SetPosX(panel:GetSizeX() - messanger._uiEnter:GetSizeX() - gap)
  messanger._uiEnter:SetPosY(messanger._uiEditInputChat:GetPosY())
  messanger._uiFrame:SetSize(panel:GetSizeX() - gap * 2, messanger._subBG:GetSizeY() - messanger._uiEditInputChat:GetSizeY() - gap * 3)
  messanger._uiFrameContent:SetSize(messanger._uiFrame:GetSizeX(), messanger._uiFrame:GetSizeY())
  messanger._uiFrameScroll:SetControlPos(scrollPos)
  if true == _ContentsGroup_UsePadSnapping then
    messanger._keyguideBg:SetSize(panel:GetSizeX(), messanger._keyguideBg:GetSizeY())
    messanger._keyguideBg:ComputePos()
    local keyGuides = {
      messanger._keyguideScroll,
      messanger._keyguideClose
    }
    PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyGuides, messanger._keyguideBg, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP)
  end
  FriendMessanger_ListUpdateMessanger(messangerId)
end
function FriendMessanger_OnMouseWheel(messangerId, isUp)
  local messanger = PaGlobal_FriendMessangerManager_All._messangerList[messangerId]
  local targetScroll = messanger._uiFrameScroll
  if isUp then
    targetScroll:ControlButtonUp()
  else
    targetScroll:ControlButtonDown()
  end
  messanger._uiFrame:UpdateContentPos()
end
function FriendMessanger_CheckCurrentUiEdit(targetUI)
  if -1 == PaGlobal_FriendMessangerManager_All._currentFocusId then
    return false
  end
  local currentEdit = PaGlobal_FriendMessangerManager_All._messangerList[PaGlobal_FriendMessangerManager_All._currentFocusId]._uiEditInputChat
  return nil ~= targetUI and targetUI:GetKey() == currentEdit:GetKey()
end
function FriendMessanger_Close(messangerId)
  local messanger = PaGlobal_FriendMessangerManager_All._messangerList[messangerId]
  if nil == messanger then
    return
  end
  ToClient_FriendListCloseMessanger(messangerId)
  messanger:clear()
  PaGlobal_FriendMessangerManager_All._messangerList[messangerId] = nil
  if messangerId == PaGlobal_FriendMessangerManager_All._currentFocusId then
    PaGlobal_FriendMessangerManager_All._currentFocusId = -1
    ClearFocusEdit()
  end
  CheckChattingInput()
  if true == _ContentsGroup_UsePadSnapping and nil ~= Panel_FriendList_All and true == Panel_FriendList_All:GetShow() then
    ToClient_padSnapSetTargetPanel(Panel_FriendList_All)
  end
end
function FriendMessanger_SetFocusEdit(messangerId)
  local messanger = PaGlobal_FriendMessangerManager_All._messangerList[messangerId]
  SetFocusEdit(messanger._uiEditInputChat)
  PaGlobal_FriendMessangerManager_All._currentFocusId = messangerId
end
function FriendMessanger_KillFocusEdit()
  if -1 == PaGlobal_FriendMessangerManager_All._currentFocusId then
    return false
  end
  ClearFocusEdit()
  CheckChattingInput()
  PaGlobal_FriendMessangerManager_All._currentFocusId = -1
  PaGlobal_FriendList_All:hidePopupMenu()
  return false
end
function friend_sendMessageByKey()
  friend_sendMessage(PaGlobal_FriendMessangerManager_All._currentFocusId)
end
function friend_killFocusMessangerByKey()
  FriendMessanger_KillFocusEdit()
end
function friend_sendMessage(messangerId)
  local messanger = PaGlobal_FriendMessangerManager_All._messangerList[messangerId]
  local rv = chatting_sendMessageByUserNo(RequestFriendList_GetMessageListById(messangerId):getUserNo(), messanger._uiEditInputChat:GetEditText(), CppEnums.ChatType.Friend)
  if 0 == rv then
    RequestFriendList_GetMessageListById(messangerId):pushFromMessage(messanger._uiEditInputChat:GetEditText())
  end
  messanger._uiEditInputChat:SetEditText("", true)
end
function FriendMessanger_ListUpdateMessanger(messangerId)
  local friendMesaageList = RequestFriendList_GetMessageListById(messangerId)
  local message = friendMesaageList:beginMessage()
  local messanger = PaGlobal_FriendMessangerManager_All._messangerList[messangerId]
  if nil == messanger then
    return
  end
  if 0 < messanger._messageCount then
    messanger:clearAllMessage()
  end
  while message ~= nil do
    messanger:updateMessage(message)
    message = friendMesaageList:nextMessage()
  end
  messanger._uiFrame:UpdateContentScroll()
  messanger._uiFrame:UpdateContentPos()
  messanger._uiFrameScroll:GetControlButton():SetPosX(0)
  if true == _ContentsGroup_UsePadSnapping then
    if true == messanger._uiFrameScroll:GetShow() then
      messanger._keyguideScroll:SetShow(true)
    else
      messanger._keyguideScroll:SetShow(false)
    end
    local keyGuides = {
      messanger._keyguideScroll,
      messanger._keyguideClose
    }
    PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyGuides, messanger._keyguideBg, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP)
  end
end
function FromClient_FriendListUpdateMessanger(messangerId)
  FriendMessanger_ListUpdateMessanger(messangerId)
  local messanger = PaGlobal_FriendMessangerManager_All._messangerList[messangerId]
  if nil == messanger then
    return
  end
  messanger._uiFrameScroll:SetControlBottom()
  messanger._uiFrame:UpdateContentScroll()
  messanger._uiFrame:UpdateContentPos()
  messanger._uiFrameScroll:GetControlButton():SetPosX(0)
end
function FromClient_FriendListOpenMessanger(messangerId, userName, isOnline)
  if nil == PaGlobal_FriendMessangerManager_All._messangerList[messangerId] and true == _ContentsGroup_NewUI_Friend_All then
    PaGlobal_FriendMessangerManager_All._messangerList[messangerId] = PaGlobal_FriendMessangerManager_All:createMessanger(messangerId, userName, isOnline)
  end
  if isOnline then
    FriendMessanger_SetFocusEdit(messangerId)
  end
  FromClient_FriendListUpdateMessanger(messangerId)
end
function FromClient_FriendListUpdateLogOnOffForMessanger(messangerId, isOnline)
  local messanger = PaGlobal_FriendMessangerManager_All._messangerList[messangerId]
  if messangerId == PaGlobal_FriendMessangerManager_All._currentFocusId and -1 ~= messangerId then
    PaGlobal_FriendMessangerManager_All._currentFocusId = -1
    ClearFocusEdit()
    CheckChattingInput()
  end
  if nil ~= messanger then
    if 1 == isOnline then
      messanger._uiEditInputChat:SetEnable(true)
      messanger._uiEnter:SetEnable(true)
    else
      messanger._uiEditInputChat:SetEnable(false)
      messanger._uiEnter:SetEnable(false)
    end
  end
end
