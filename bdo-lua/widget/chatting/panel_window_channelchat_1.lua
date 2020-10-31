function PaGlobal_ChannelChat:initialize()
  if true == PaGlobal_ChannelChat._initialize then
    return
  end
  self._isConsole = _ContentsGroup_UsePadSnapping
  self:controlInit_All()
  self:controlInit_Pc()
  self:controlInit_Console()
  self:controlSetShow()
  PaGlobal_ChannelChat:registEventHandler()
  PaGlobal_ChannelChat:validate()
  PaGlobal_ChannelChat._initialize = true
end
function PaGlobal_ChannelChat:controlInit_All()
  self._ui.stc_title = UI.getChildControl(Panel_Window_ChannelChat, "Static_Text_Title")
  self._ui.stc_bg = UI.getChildControl(Panel_Window_ChannelChat, "Static_Bg")
  local slot = {}
  slot.btn_title = UI.getChildControl(Panel_Window_ChannelChat, "RadioButton_Channel_Chat_temp")
  slot.btn_title:SetShow(false)
  self._ui.scrol_list = UI.getChildControl(Panel_Window_ChannelChat, "Scroll_1")
  self._ui.btn_scrolUp = UI.getChildControl(self._ui.scrol_list, "Scroll_1_UpButton")
  self._ui.btn_scrolDown = UI.getChildControl(self._ui.scrol_list, "Scroll_1_DownButton")
  self._ui.btn_ScrolCtrl = UI.getChildControl(self._ui.scrol_list, "Scroll_1_CtrlButton")
  self._ui.stc_bottomDescBG = UI.getChildControl(Panel_Window_ChannelChat, "Static_BottomDescBG")
  self._ui.stc_txt_bottomDesc = UI.getChildControl(self._ui.stc_bottomDescBG, "StaticText_Desc")
  self._ui.stc_txt_bottomDesc:SetTextMode(__eTextMode_AutoWrap)
  self._ui.stc_txt_bottomDesc:SetText(self._ui.stc_txt_bottomDesc:GetText())
  local basicSizeY = self._ui.stc_bottomDescBG:GetSizeY()
  local textSizeY = self._ui.stc_txt_bottomDesc:GetTextSizeY()
  local gapSizeY = math.max(basicSizeY, textSizeY) - basicSizeY
  if 0 < gapSizeY then
    gapSizeY = gapSizeY + 15
  end
  Panel_Window_ChannelChat:SetSize(Panel_Window_ChannelChat:GetSizeX(), Panel_Window_ChannelChat:GetSizeY() + gapSizeY)
  self._ui.stc_bottomDescBG:SetSize(self._ui.stc_bottomDescBG:GetSizeX(), basicSizeY + gapSizeY)
  self._ui.stc_txt_bottomDesc:SetSize(self._ui.stc_txt_bottomDesc:GetSizeX(), basicSizeY + gapSizeY - 20)
  self._ui.stc_bottomDescBG:ComputePos()
  self._ui.stc_txt_bottomDesc:ComputePos()
  for index = 0, self._serverListCount - 1 do
    local clonSlot = {}
    clonSlot.btn_title = UI.cloneControl(slot.btn_title, Panel_Window_ChannelChat, "ChannelChat_Title_" .. index)
    clonSlot.stc_title = UI.getChildControl(clonSlot.btn_title, "StaticText_Title")
    clonSlot.stc_desc = UI.getChildControl(clonSlot.btn_title, "StaticText_Money")
    clonSlot.btn_radio = UI.getChildControl(clonSlot.btn_title, "Button_Radio")
    clonSlot.btn_bg = UI.getChildControl(clonSlot.btn_title, "Static_DecoBG")
    if 0 ~= index then
      local slotPosX = clonSlot.btn_title:GetPosX()
      local slotPosY = clonSlot.btn_title:GetPosY()
      if 1 == index % 2 then
        slotPosX = slotPosX + 10 + clonSlot.btn_title:GetSizeX()
        slotPosY = slotPosY + (10 + clonSlot.btn_title:GetSizeY()) * ((index - 1) / 2)
      else
        slotPosY = slotPosY + (10 + clonSlot.btn_title:GetSizeY()) * (index / 2)
      end
      clonSlot.btn_title:SetPosXY(slotPosX, slotPosY)
      clonSlot.btn_title:SetShow(true)
    end
    local x1, y1, x2, y2 = 0, 0, 0, 0
    local textureKey = "LUA_CHANNELCHAT_ROOM_DESC_01"
    local baseTextureUV = self._bg_UV[textureKey]
    if nil == baseTextureUV then
      _PA_ASSERT(false, "\236\161\180\236\158\172 \237\149\152\236\167\128 \236\149\138\235\138\148 \235\140\128\237\153\148\234\183\184\235\163\185 Texture\236\158\133\235\139\136\235\139\164")
      baseTextureUV = self._bg_UV[textureKey]
    end
    local baseTexture = clonSlot.btn_bg:getBaseTexture()
    clonSlot.btn_bg:ChangeTextureInfoName("Combine/Etc/Combine_Etc_ChannelChat.dds")
    x1, y1, x2, y2 = setTextureUV_Func(clonSlot.btn_bg, baseTextureUV.x1, baseTextureUV.y1, baseTextureUV.x2, baseTextureUV.y2)
    baseTexture:setUV(x1, y1, x2, y2)
    clonSlot.btn_bg:setRenderTexture(baseTexture)
    clonSlot.btn_title:SetShow(false)
    clonSlot.btn_radio:SetGroup(1)
    self._ui.btn_title[index] = clonSlot.btn_title
    self._ui.stc_title[index] = clonSlot.stc_title
    self._ui.stc_desc[index] = clonSlot.stc_desc
    self._ui.btn_radio[index] = clonSlot.btn_radio
    self._ui.btn_bg[index] = clonSlot.btn_bg
  end
end
function PaGlobal_ChannelChat:controlInit_Pc()
  if nil == Panel_Window_ChannelChat then
    return
  end
  self._ui_pc.btn_close = UI.getChildControl(Panel_Window_ChannelChat, "Button_Close")
  self._ui_pc.btn_confirm = UI.getChildControl(Panel_Window_ChannelChat, "Button_Apply_PCUI")
  self._ui_pc.btn_exit = UI.getChildControl(Panel_Window_ChannelChat, "Button_Exit_PCUI")
  self._ui_pc.btn_cancel = UI.getChildControl(Panel_Window_ChannelChat, "Button_Cancel_PCUI")
end
function PaGlobal_ChannelChat:controlInit_Console()
  if nil == Panel_Window_ChannelChat then
    return
  end
  self._ui_console.stc_bottomBg = UI.getChildControl(Panel_Window_ChannelChat, "Static_BottomBg_ConsoleUI")
  self._ui_console.stc_TextA = UI.getChildControl(self._ui_console.stc_bottomBg, "StaticText_A_ConsoleUI")
  self._ui_console.stc_TextA2 = UI.getChildControl(self._ui_console.stc_bottomBg, "StaticText_A2_ConsoleUI")
  self._ui_console.stc_TextB = UI.getChildControl(self._ui_console.stc_bottomBg, "StaticText_B_ConsoleUI")
end
function PaGlobal_ChannelChat:controlSetShow()
  if nil == Panel_Window_ChannelChat then
    return
  end
  if false == self._isConsole then
    self._ui_pc.btn_close:SetShow(true)
    self._ui_pc.btn_confirm:SetShow(true)
    self._ui_pc.btn_exit:SetShow(true)
    self._ui_pc.btn_cancel:SetShow(true)
    self._ui_console.stc_bottomBg:SetShow(false)
  else
    self._ui_pc.btn_close:SetShow(false)
    self._ui_pc.btn_confirm:SetShow(false)
    self._ui_pc.btn_exit:SetShow(false)
    self._ui_pc.btn_cancel:SetShow(false)
    self._ui_console.stc_bottomBg:SetShow(true)
  end
end
function PaGlobal_ChannelChat:registEventHandler()
  if nil == Panel_Window_ChannelChat then
    return
  end
  UIScroll.InputEvent(self._ui.scrol_list, "PaGlobal_ChannelChat:Scroll")
  UIScroll.InputEventByControl(Panel_Window_ChannelChat, "PaGlobal_ChannelChat:Scroll")
  for index = 0, self._serverListCount - 1 do
    self._ui.btn_title[index]:addInputEvent("Mouse_LUp", "HandleEventLUp_Select_ChannelChat(" .. index .. ")")
    self._ui.btn_radio[index]:addInputEvent("Mouse_LUp", "HandleEventLUp_Select_ChannelChat(" .. index .. ")")
    UIScroll.InputEventByControl(self._ui.btn_title[index], "PaGlobal_ChannelChat:Scroll")
    UIScroll.InputEventByControl(self._ui.stc_desc[index], "PaGlobal_ChannelChat:Scroll")
    UIScroll.InputEventByControl(self._ui.btn_radio[index], "PaGlobal_ChannelChat:Scroll")
    UIScroll.InputEventByControl(self._ui.btn_bg[index], "PaGlobal_ChannelChat:Scroll")
  end
  if false == self._isConsole then
    self._ui_pc.btn_close:addInputEvent("Mouse_LUp", "PaGlobalFunc_ChannelChat_Close()")
    self._ui_pc.btn_confirm:addInputEvent("Mouse_LUp", "HandleEventLUp_ChannelChat_Confirm()")
    self._ui_pc.btn_exit:addInputEvent("Mouse_LUp", "HandleEventLUp_ChannelChat_Exit()")
    self._ui_pc.btn_cancel:addInputEvent("Mouse_LUp", "PaGlobalFunc_ChannelChat_Close()")
  else
    self._ui_console.stc_TextA:registerPadEvent(__eConsoleUIPadEvent_Up_A, "HandleEventLUp_ChannelChat_Confirm()")
    self._ui_console.stc_TextA2:registerPadEvent(__eConsoleUIPadEvent_Up_A, "HandleEventLUp_ChannelChat_Exit()")
    self._ui_console.stc_TextB:registerPadEvent(__eConsoleUIPadEvent_Up_B, "PaGlobalFunc_ChannelChat_Close()")
  end
  registerEvent("FromClient_ChannelChatList", "FromClient_ChannelChatList")
  registerEvent("FromClient_JoinChannelChatRoom", "FromClient_JoinChannelChatRoom")
  registerEvent("FromClient_LeaveChannelChatRoom", "FromClient_LeaveChannelChatRoom")
  registerEvent("FromClient_LogoutVoiceChatServer", "FromClient_LogoutVoiceChatServer")
  registerEvent("FromClient_LoginVoiceChatServer", "FromClient_LoginVoiceChatServer")
end
function PaGlobal_ChannelChat:prepareOpen()
  if nil == Panel_Window_ChannelChat then
    return
  end
  if false == ToClient_isLoggedInVoiceChatServer() then
    PaGlobalFunc_ChannelChat_Loading_Open()
    return
  end
  for index = 0, self._serverListCount - 1 do
    self._ui.btn_title[index]:SetShow(false)
  end
  ToClient_ChannelChattingRoomList()
  PaGlobal_ChannelChat:open()
end
function PaGlobal_ChannelChat:open()
  if nil == Panel_Window_ChannelChat then
    return
  end
  Panel_Window_ChannelChat:SetShow(true)
end
function PaGlobal_ChannelChat:prepareClose()
  if nil == Panel_Window_ChannelChat then
    return
  end
  PaGlobal_ChannelChat:close()
end
function PaGlobal_ChannelChat:close()
  if nil == Panel_Window_ChannelChat then
    return
  end
  Panel_Window_ChannelChat:SetShow(false)
end
function PaGlobal_ChannelChat:update()
  if nil == Panel_Window_ChannelChat then
    return
  end
end
function PaGlobal_ChannelChat:validate()
  if nil == Panel_Window_ChannelChat then
    return
  end
  self._ui.stc_title:isValidate()
  self._ui.stc_bg:isValidate()
  self._ui.scrol_list:isValidate()
  self._ui.btn_scrolUp:isValidate()
  self._ui.btn_scrolDown:isValidate()
  self._ui.btn_ScrolCtrl:isValidate()
  self._ui.stc_bottomDescBG:isValidate()
  self._ui.stc_txt_bottomDesc:isValidate()
  for index = 0, self._serverListCount - 1 do
    self._ui.btn_title[index]:isValidate()
    self._ui.stc_desc[index]:isValidate()
    self._ui.btn_radio[index]:isValidate()
  end
  self._ui_pc.btn_close:isValidate()
  self._ui_pc.btn_confirm:isValidate()
  self._ui_pc.btn_exit:isValidate()
  self._ui_pc.btn_cancel:isValidate()
  self._ui_console.stc_bottomBg:isValidate()
  self._ui_console.stc_TextA:isValidate()
  self._ui_console.stc_TextA2:isValidate()
  self._ui_console.stc_TextB:isValidate()
end
function PaGlobal_ChannelChat:Scroll(isUp)
  self._startItemIndex = UIScroll.ScrollEvent(self._ui.scrol_list, isUp, self._config._slotCount, self._serverListCount, self._startItemIndex, self._config._slotCols)
  self:UpdateSlot()
end
function PaGlobal_ChannelChat:UpdateSlot()
  self = PaGlobal_ChannelChat
  UIScroll.SetButtonSize(self._ui.scrol_list, self._config._slotCount, self._serverListCount)
  for index = 0, self._serverListCount - 1 do
    self._ui.btn_title[index]:SetShow(false)
    self._ui.btn_title[index]:SetCheck(self._ui.btn_radio[index]:IsChecked())
  end
  local baseControl = UI.getChildControl(Panel_Window_ChannelChat, "RadioButton_Channel_Chat_temp")
  local startPosY = baseControl:GetPosY()
  local slotCount = self._config._slotCount * self._config._slotCols
  if slotCount <= self._serverListCount then
    for i = 0, slotCount - 1 do
      self:slotInfoSetting(i, startPosY)
    end
  else
    for i = 0, self._serverListCount - 1 do
      self:slotInfoSetting(i, startPosY)
    end
  end
end
function PaGlobal_ChannelChat:slotInfoSetting(idx, startPosY)
  local slotIdx = self._startItemIndex + idx
  local slotCount = self._config._slotCount * self._config._slotCols
  if slotIdx < self._serverListCount then
    if idx < slotCount then
      self._ui.btn_title[slotIdx]:SetPosY(startPosY + (10 + self._ui.btn_title[slotIdx]:GetSizeY()) * math.floor(idx / self._config._slotCols))
      self._ui.btn_title[slotIdx]:SetShow(true)
    else
      self._ui.btn_title[slotIdx]:SetShow(false)
    end
  end
end
function PaGlobal_ChannelChat:clearAll()
  self._selectIndex = -1
  for index = 0, self._serverListCount - 1 do
    self._ui.btn_title[index]:SetCheck(false)
    self._ui.btn_radio[index]:SetCheck(false)
  end
  ChatInput_UpdatePermission()
  self._startItemIndex = 0
  self:Scroll(true)
  self:prepareClose()
  local enable = false
  self._ui_pc.btn_confirm:SetMonoTone(not enable)
  self._ui_pc.btn_exit:SetMonoTone(not enable)
  self._ui_pc.btn_confirm:SetIgnore(not enable)
  self._ui_pc.btn_exit:SetIgnore(not enable)
  self._ui_pc.btn_confirm:SetEnable(enable)
  self._ui_pc.btn_exit:SetEnable(enable)
end
function PaGlobal_ChannelChat:setTextureControl(control, stringHashKey)
  if nil == control then
    _PA_ASSERT(false, "\236\161\180\236\158\172\237\149\152\236\167\128 \236\149\138\235\138\148 \236\187\168\237\138\184\235\161\164\236\157\180\235\139\164")
  end
  if nil == stringHashKey then
    _PA_ASSERT(false, "\236\156\160\237\154\168\237\149\152\236\167\128 \236\149\138\235\138\148 \236\138\164\237\138\184\235\167\129 \237\130\164\235\139\164")
    stringHashKey = "LUA_CHANNELCHAT_ROOM_DESC_01"
  end
  local x1, y1, x2, y2 = 0, 0, 0, 0
  local baseTextureUV = self._bg_UV[stringHashKey]
  if nil == baseTextureUV then
    _PA_ASSERT(false, "\236\161\180\236\158\172 \237\149\152\236\167\128 \236\149\138\235\138\148 \235\140\128\237\153\148\234\183\184\235\163\185 Texture\236\158\133\235\139\136\235\139\164" .. tostring(stringHashKey))
    baseTextureUV = self._bg_UV.LUA_CHANNELCHAT_ROOM_DESC_01
  end
  local baseTexture = control:getBaseTexture()
  control:ChangeTextureInfoName("Combine/Etc/Combine_Etc_ChannelChat.dds")
  x1, y1, x2, y2 = setTextureUV_Func(control, baseTextureUV.x1, baseTextureUV.y1, baseTextureUV.x2, baseTextureUV.y2)
  baseTexture:setUV(x1, y1, x2, y2)
  control:setRenderTexture(baseTexture)
end
