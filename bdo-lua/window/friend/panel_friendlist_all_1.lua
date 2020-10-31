function PaGlobal_FriendList_All:initialize()
  if true == PaGlobal_FriendList_All._initialize then
    return
  end
  PaGlobal_FriendList_All._ui.stc_TitleBG = UI.getChildControl(Panel_FriendList_All, "Static_PartLine")
  PaGlobal_FriendList_All._ui.btn_Close = UI.getChildControl(PaGlobal_FriendList_All._ui.stc_TitleBG, "Button_Close_PCUI")
  PaGlobal_FriendList_All._ui.btn_Question = UI.getChildControl(PaGlobal_FriendList_All._ui.stc_TitleBG, "Button_Question_PCUI")
  PaGlobal_FriendList_All._ui.stc_soundOptionBG = UI.getChildControl(Panel_FriendList_All, "Static_SoundOptionBg_PCUI")
  PaGlobal_FriendList_All._ui.chk_Sound = UI.getChildControl(PaGlobal_FriendList_All._ui.stc_soundOptionBG, "CheckButton_Sound_PCUI")
  PaGlobal_FriendList_All._ui.chk_Effect = UI.getChildControl(PaGlobal_FriendList_All._ui.stc_soundOptionBG, "CheckButton_Effect_PCUI")
  PaGlobal_FriendList_All._ui.chk_Sound:SetEnableArea(0, 0, PaGlobal_FriendList_All._ui.chk_Sound:GetSizeX() + PaGlobal_FriendList_All._ui.chk_Sound:GetTextSizeX(), PaGlobal_FriendList_All._ui.chk_Sound:GetSizeY())
  PaGlobal_FriendList_All._ui.chk_Effect:SetEnableArea(0, 0, PaGlobal_FriendList_All._ui.chk_Effect:GetSizeX() + PaGlobal_FriendList_All._ui.chk_Effect:GetTextSizeX(), PaGlobal_FriendList_All._ui.chk_Effect:GetSizeY())
  PaGlobal_FriendList_All._ui.stc_TabBG = UI.getChildControl(Panel_FriendList_All, "Static_TabTypeBg_ConsoleUI")
  PaGlobal_FriendList_All._ui.rdo_PCFriend = UI.getChildControl(PaGlobal_FriendList_All._ui.stc_TabBG, "RadioButton_PCFrined")
  PaGlobal_FriendList_All._ui.rdo_ConsoleFriend = UI.getChildControl(PaGlobal_FriendList_All._ui.stc_TabBG, "RadioButton_XBoxFrined")
  PaGlobal_FriendList_All._ui.stc_KeyGuide_LB = UI.getChildControl(PaGlobal_FriendList_All._ui.stc_TabBG, "Static_LB")
  PaGlobal_FriendList_All._ui.stc_KeyGuide_RB = UI.getChildControl(PaGlobal_FriendList_All._ui.stc_TabBG, "Static_RB")
  PaGlobal_FriendList_All._ui.list2_Friend = UI.getChildControl(Panel_FriendList_All, "List2_Friend")
  PaGlobal_FriendList_All._ui.txt_Info = UI.getChildControl(Panel_FriendList_All, "StaticText_Info")
  PaGlobal_FriendList_All._ui.btn_Request = UI.getChildControl(Panel_FriendList_All, "Button_Offer_PCUI")
  PaGlobal_FriendList_All._ui.btn_AddFriend = UI.getChildControl(Panel_FriendList_All, "Button_AddFriend_PCUI")
  PaGlobal_FriendList_All._ui.stc_XBFunctionBG = UI.getChildControl(Panel_FriendList_All, "Static_Function_BG_1")
  PaGlobal_FriendList_All._ui.stc_PopupFunctionBG = UI.getChildControl(Panel_FriendList_All, "Static_Function_BG_2")
  PaGlobal_FriendList_All._ui.stc_SubFunctionBG = UI.getChildControl(Panel_FriendList_All, "Static_Function_BG_3")
  PaGlobal_FriendList_All._ui.stc_function = UI.getChildControl(Panel_FriendList_All, "Style_Function")
  PaGlobal_FriendList_All._ui.stc_BottomBG = UI.getChildControl(Panel_FriendList_All, "Static_BottomBg")
  PaGlobal_FriendList_All._ui.txt_KeyGuide_X = UI.getChildControl(PaGlobal_FriendList_All._ui.stc_BottomBG, "StaticText_GroupRename")
  PaGlobal_FriendList_All._ui.txt_KeyGuide_Y = UI.getChildControl(PaGlobal_FriendList_All._ui.stc_BottomBG, "StaticText_RequestList")
  PaGlobal_FriendList_All._ui.txt_KeyGuide_A = UI.getChildControl(PaGlobal_FriendList_All._ui.stc_BottomBG, "StaticText_Select")
  PaGlobal_FriendList_All._ui.txt_KeyGuide_B = UI.getChildControl(PaGlobal_FriendList_All._ui.stc_BottomBG, "StaticText_Close")
  PaGlobal_FriendList_All._ui.txt_KeyGuide_LT = UI.getChildControl(PaGlobal_FriendList_All._ui.stc_BottomBG, "StaticText_AddFriend")
  PaGlobal_FriendList_All._ui.txt_KeyGuide_LB = UI.getChildControl(PaGlobal_FriendList_All._ui.stc_BottomBG, "StaticText_PS4Invite")
  PaGlobal_FriendList_All._keyGuides = {
    PaGlobal_FriendList_All._ui.txt_KeyGuide_LB,
    PaGlobal_FriendList_All._ui.txt_KeyGuide_LT,
    PaGlobal_FriendList_All._ui.txt_KeyGuide_X,
    PaGlobal_FriendList_All._ui.txt_KeyGuide_Y,
    PaGlobal_FriendList_All._ui.txt_KeyGuide_A,
    PaGlobal_FriendList_All._ui.txt_KeyGuide_B
  }
  PaGlobal_FriendList_All._ui.btn_scaleResize = UI.getChildControl(Panel_FriendList_All, "Button_ScaleResize")
  PaGlobal_FriendList_All._isPS4 = ToClient_isPS4()
  PaGlobal_FriendList_All:initPopup()
  PaGlobal_FriendList_All:preparePlatform()
  PaGlobal_FriendList_All._ui.stc_function:SetShow(false)
  Panel_FriendList_All:setDynamicScalePanelIndex(__eDynamicScalePanel_FriendList)
  FromClient_FriendList_All_OnScreenResize()
  PaGlobal_FriendList_All:registEventHandler()
  PaGlobal_FriendList_All._initialize = true
end
function PaGlobal_FriendList_All:preparePlatform()
  if true == _ContentsGroup_UsePadSnapping then
    PaGlobal_FriendList_All._ui.btn_Close:SetShow(false)
    PaGlobal_FriendList_All._ui.btn_Question:SetShow(false)
    PaGlobal_FriendList_All._ui.btn_Request:SetShow(false)
    PaGlobal_FriendList_All._ui.btn_AddFriend:SetShow(false)
    PaGlobal_FriendList_All._ui.btn_scaleResize:SetShow(false)
    local listContent = UI.getChildControl(PaGlobal_FriendList_All._ui.list2_Friend, "List2_1_Content")
    local child = UI.getChildControl(listContent, "Static_ChildBG")
    child:ChangeOnTextureInfoName("combine/btn/combine_btn_00.dds")
    local x1, y1, x2, y2 = setTextureUV_Func(child, 42, 1, 82, 41)
    child:getOnTexture():setUV(x1, y1, x2, y2)
    child:ChangeClickTextureInfoName("combine/btn/combine_btn_00.dds")
    x1, y1, x2, y2 = setTextureUV_Func(child, 83, 1, 123, 41)
    child:getClickTexture():setUV(x1, y1, x2, y2)
    if true == _ContentsGroup_RenewUI then
      PaGlobal_FriendList_All._ui.chk_Sound:SetShow(false)
      PaGlobal_FriendList_All._ui.chk_Effect:SetShow(false)
      PaGlobal_FriendList_All._ui.txt_Info:SetShow(false)
      if true == PaGlobal_FriendList_All._isPS4 then
        PaGlobal_FriendList_All._ui.stc_TabBG:SetShow(false)
        PaGlobal_FriendList_All._ui.list2_Friend:SetSpanSize(0, PaGlobal_FriendList_All._ui.list2_Friend:GetSpanSize().y - PaGlobal_FriendList_All._ui.stc_TabBG:GetSizeY())
        Panel_FriendList_All:SetSize(Panel_FriendList_All:GetSizeX(), Panel_FriendList_All:GetSizeY() - PaGlobal_FriendList_All._ui.stc_TabBG:GetSizeY())
      else
        PaGlobal_FriendList_All._ui.stc_TabBG:SetShow(true)
      end
    end
    PaGlobal_FriendList_All._ui.txt_Info:SetSpanSize(PaGlobal_FriendList_All._ui.txt_Info:GetSpanSize().x, 10)
    PaGlobal_FriendList_All._ui.list2_Friend:SetSize(PaGlobal_FriendList_All._ui.list2_Friend:GetSizeX(), PaGlobal_FriendList_All._ui.list2_Friend:GetSizeY() + 85)
    PaGlobal_FriendList_All:updateKeyGuides()
  else
    PaGlobal_FriendList_All._ui.stc_BottomBG:SetShow(false)
    PaGlobal_FriendList_All._ui.stc_TabBG:SetShow(false)
    PaGlobal_FriendList_All._ui.btn_scaleResize:SetShow(true)
  end
end
function PaGlobal_FriendList_All:initPopup()
  if nil == Panel_FriendList_All then
    return
  end
  local bgSizeX = PaGlobal_FriendList_All._ui.stc_XBFunctionBG:GetSizeX()
  local buttonSizeY = PaGlobal_FriendList_All._ui.stc_function:GetSizeY()
  for i = 0, 1 do
    local control = UI.cloneControl(PaGlobal_FriendList_All._ui.stc_function, PaGlobal_FriendList_All._ui.stc_XBFunctionBG, "Static_Funtion_" .. i)
    control:SetPosX(0)
    control:SetPosY(buttonSizeY * i)
    PaGlobal_FriendList_All._ui.stc_XBFunctionList[i] = control
  end
  PaGlobal_FriendList_All._ui.stc_XBFunctionBG:SetSize(bgSizeX, buttonSizeY * 2)
  PaGlobal_FriendList_All._ui.stc_XBFunctionList[0]:SetText(PAGetString(Defines.StringSheet_GAME, "FRIEND_TEXT_XBOX_PROFILE"))
  PaGlobal_FriendList_All._ui.stc_XBFunctionList[1]:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_XBOX_FRIEND_GAMEINVITE"))
  PaGlobal_FriendList_All._ui.stc_XBFunctionList[0]:addInputEvent("Mouse_LUp", "PaGlobal_FriendList_All:ShowXBoxProfile()")
  PaGlobal_FriendList_All._ui.stc_XBFunctionList[1]:addInputEvent("Mouse_LUp", "PaGlobal_FriendList_All:SendXboxInvite()")
  PaGlobal_FriendList_All._ui.stc_XBFunctionBG:SetShow(false)
  for i = 0, 3 do
    local control = UI.cloneControl(PaGlobal_FriendList_All._ui.stc_function, PaGlobal_FriendList_All._ui.stc_PopupFunctionBG, "Static_Funtion_" .. i)
    control:SetPosX(0)
    control:SetPosY(buttonSizeY * i)
    PaGlobal_FriendList_All._ui.stc_PopupFunctionList[i] = control
  end
  if true == _ContentsGroup_RenewUI then
    PaGlobal_FriendList_All._ui.stc_PopupFunctionList[0]:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_TEXT_GUILD_INVITE"))
  else
    PaGlobal_FriendList_All._ui.stc_PopupFunctionList[0]:SetText(PAGetString(Defines.StringSheet_GAME, "INTERACTION_MENU3"))
  end
  PaGlobal_FriendList_All._ui.stc_PopupFunctionList[1]:SetText(PAGetString(Defines.StringSheet_GAME, "FRIEND_TEXT_REMOVE_FRIEND"))
  PaGlobal_FriendList_All._ui.stc_PopupFunctionList[2]:SetText(PAGetString(Defines.StringSheet_GAME, "FRIEND_TEXT_CHANGE_GROUP"))
  PaGlobal_FriendList_All._ui.stc_PopupFunctionList[3]:SetText(PAGetString(Defines.StringSheet_GAME, "FRIEND_TEXT_WHISPER"))
  if true == _ContentsGroup_RenewUI then
    PaGlobal_FriendList_All._ui.stc_PopupFunctionList[0]:addInputEvent("Mouse_LUp", "PaGlobal_FriendList_All:guildInvite()")
  else
    PaGlobal_FriendList_All._ui.stc_PopupFunctionList[0]:addInputEvent("Mouse_LUp", "PaGlobal_FriendList_All:partyInvite()")
  end
  PaGlobal_FriendList_All._ui.stc_PopupFunctionList[1]:addInputEvent("Mouse_LUp", "PaGlobal_FriendList_All:deleteFriend()")
  PaGlobal_FriendList_All._ui.stc_PopupFunctionList[2]:addInputEvent("Mouse_LUp", "PaGlobal_FriendList_All:groupMoveList()")
  PaGlobal_FriendList_All._ui.stc_PopupFunctionList[3]:addInputEvent("Mouse_LUp", "PaGlobal_FriendList_All:messangerOpen()")
  if true == _ContentsGroup_RenewUI then
    PaGlobal_FriendList_All._ui.stc_PopupFunctionList[PaGlobal_FriendList_All._popupFunction.MESSANGER]:SetShow(false)
    PaGlobal_FriendList_All._ui.stc_PopupFunctionBG:SetSize(bgSizeX, buttonSizeY * 3)
  else
    PaGlobal_FriendList_All._ui.stc_PopupFunctionBG:SetSize(bgSizeX, buttonSizeY * 4)
  end
  PaGlobal_FriendList_All._ui.stc_PopupFunctionBG:SetShow(false)
  for i = 0, PaGlobal_FriendList_All._MAX_GROUP_COUNT - 1 do
    local control = UI.cloneControl(PaGlobal_FriendList_All._ui.stc_function, PaGlobal_FriendList_All._ui.stc_SubFunctionBG, "Static_Funtion_" .. i)
    control:SetPosX(0)
    control:SetPosY(buttonSizeY * i)
    PaGlobal_FriendList_All._ui.stc_SubFunctionList[i] = control
  end
  PaGlobal_FriendList_All._ui.stc_SubFunctionBG:SetShow(false)
end
function PaGlobal_FriendList_All:registEventHandler()
  if nil == Panel_FriendList_All then
    return
  end
  registerEvent("ResponseFriendList_updateFriends", "FromClient_FriendList_All_ResponseUpdateFriends")
  PaGlobal_FriendList_All._ui.list2_Friend:registEvent(__ePAUIList2EventType_LuaChangeContent, "PaGlobal_FriendList_All_List2ControlCreate")
  PaGlobal_FriendList_All._ui.list2_Friend:createChildContent(__ePAUIList2ElementManagerType_Tree)
  if true == _ContentsGroup_UsePadSnapping then
    Panel_FriendList_All:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "PaGlobal_FriendRequest_All_OpenToggle()")
    Panel_FriendList_All:registerPadEvent(__eConsoleUIPadEvent_LT, "PaGlobal_FriendList_All_ClickAddFriendButton()")
    if true == _ContentsGroup_RenewUI then
      if true == PaGlobal_FriendList_All._isPS4 then
        Panel_FriendList_All:registerPadEvent(__eConsoleUIPadEvent_LB, "PaGlobal_FriendList_All_ShowPSInviteDialog()")
      else
        Panel_FriendList_All:registerPadEvent(__eConsoleUIPadEvent_LB, "PaGlobal_FriendList_All_ChangeTab()")
        Panel_FriendList_All:registerPadEvent(__eConsoleUIPadEvent_RB, "PaGlobal_FriendList_All_ChangeTab()")
      end
    end
  else
    PaGlobal_FriendList_All._ui.btn_Close:addInputEvent("Mouse_LUp", "PaGlobal_FriendList_Hide_All()")
    PaGlobal_FriendList_All._ui.btn_Question:addInputEvent("Mouse_LUp", "Panel_WebHelper_ShowToggle( \"PanelFriends\" )")
    PaGlobal_Util_RegistHelpTooltipEvent(PaGlobal_FriendList_All._ui.btn_Question, "\"PanelFriends\"")
    PaGlobal_FriendList_All._ui.btn_Request:addInputEvent("Mouse_LUp", "PaGlobal_FriendRequest_All_OpenToggle()")
    PaGlobal_FriendList_All._ui.btn_AddFriend:addInputEvent("Mouse_LUp", "PaGlobal_FriendList_All_ClickAddFriendButton()")
    PaGlobal_FriendList_All._ui.btn_scaleResize:addInputEvent("Mouse_LDown", "HandleEventLDown_FriendList_All_ScaleResizeStart()")
    PaGlobal_FriendList_All._ui.btn_scaleResize:addInputEvent("Mouse_LPress", "HandleEventLPress_FriendList_All_ScaleResizing()")
    PaGlobal_FriendList_All._ui.btn_scaleResize:addInputEvent("Mouse_LUp", "HandleEventLUp_FriendList_All_ScaleResizeEnd()")
  end
  if true == _ContentsGroup_RenewUI then
    registerEvent("FromClient_CantFindFriendForXbox", "FromClient_FriendList_All_CantFindFriendForXbox")
    registerEvent("FromClient_ResponseFriendResult", "FromClient_FriendList_All_ResponseFriendResult")
  else
    PaGlobal_FriendList_All._ui.chk_Sound:addInputEvent("Mouse_LUp", "ToClient_RequestToggleSoundNotice()")
    PaGlobal_FriendList_All._ui.chk_Effect:addInputEvent("Mouse_LUp", "ToClient_RequestToggleEffectNotice()")
    registerEvent("FromClient_NoticeNewMessage", "FromClient_NoticeNewMessage_All")
  end
end
function PaGlobal_AddFriend_All:initialize()
  if true == PaGlobal_AddFriend_All._initialize then
    return
  end
  PaGlobal_AddFriend_All._ui.btn_Close = UI.getChildControl(Panel_FriendList_Add_All, "Button_AddFriend_Close_PCUI")
  PaGlobal_AddFriend_All._ui.txt_Desc = UI.getChildControl(Panel_FriendList_Add_All, "StaticText_NameDesc")
  PaGlobal_AddFriend_All._ui.sub_BG = UI.getChildControl(Panel_FriendList_Add_All, "Static_FriendName_SubBg")
  PaGlobal_AddFriend_All._ui.chk_isFamilyName = UI.getChildControl(Panel_FriendList_Add_All, "CheckButton_IsUserNickName_PCUI")
  PaGlobal_AddFriend_All._ui.rdo_Family = UI.getChildControl(Panel_FriendList_Add_All, "RadioButton_PCFrined_ConsoleUI")
  PaGlobal_AddFriend_All._ui.rdo_Character = UI.getChildControl(Panel_FriendList_Add_All, "RadioButton_XBoxFrined_ConsoleUI")
  PaGlobal_AddFriend_All._ui.stc_KeyGuide_RB = UI.getChildControl(Panel_FriendList_Add_All, "Static_RB_ConsoleUI")
  PaGlobal_AddFriend_All._ui.stc_KeyGuide_LB = UI.getChildControl(Panel_FriendList_Add_All, "Static_LB_ConsoleUI")
  PaGlobal_AddFriend_All._ui.stc_keyGuide_X = UI.getChildControl(Panel_FriendList_Add_All, "StaticText_EditNameKeyGuide_ConsoleUI")
  PaGlobal_AddFriend_All._ui.edit_Name = UI.getChildControl(Panel_FriendList_Add_All, "Edit_FriendName")
  PaGlobal_AddFriend_All._ui.btn_Confirm = UI.getChildControl(Panel_FriendList_Add_All, "Button_AddFriend_Yes_PCUI")
  PaGlobal_AddFriend_All._ui.btn_Cancel = UI.getChildControl(Panel_FriendList_Add_All, "Button_AddFriend_No_PCUI")
  PaGlobal_AddFriend_All._ui.stc_keyGuideBG = UI.getChildControl(Panel_FriendList_Add_All, "Static_FriendBotton_ConsoleUI")
  PaGlobal_AddFriend_All._ui.stc_KeyGuide_A = UI.getChildControl(PaGlobal_AddFriend_All._ui.stc_keyGuideBG, "StaticText_Apply")
  PaGlobal_AddFriend_All._ui.stc_KeyGuide_B = UI.getChildControl(PaGlobal_AddFriend_All._ui.stc_keyGuideBG, "StaticText_Cancel")
  PaGlobal_AddFriend_All._keyGuides = {
    PaGlobal_AddFriend_All._ui.stc_KeyGuide_A,
    PaGlobal_AddFriend_All._ui.stc_KeyGuide_B
  }
  PaGlobal_AddFriend_All._ui.edit_Name:SetMaxInput(getGameServiceTypeUserNickNameLength())
  PaGlobal_AddFriend_All:preparePlatform()
  PaGlobal_AddFriend_All:registEventHandler()
  PaGlobal_AddFriend_All._initialize = true
end
function PaGlobal_AddFriend_All:preparePlatform()
  if nil == Panel_FriendList_Add_All then
    return
  end
  if true == _ContentsGroup_UsePadSnapping then
    PaGlobal_AddFriend_All._ui.btn_Close:SetShow(false)
    PaGlobal_AddFriend_All._ui.chk_isFamilyName:SetShow(false)
    PaGlobal_AddFriend_All._ui.btn_Confirm:SetShow(false)
    PaGlobal_AddFriend_All._ui.btn_Cancel:SetShow(false)
    local subBG = PaGlobal_AddFriend_All._ui.sub_BG
    Panel_FriendList_Add_All:SetSize(Panel_FriendList_Add_All:GetSizeX(), Panel_FriendList_Add_All:GetSizeY() - 40)
    subBG:SetSize(subBG:GetSizeX(), subBG:GetSizeY() - 40)
    Panel_FriendList_Add_All:ComputePos()
    PaGlobal_AddFriend_All._ui.stc_keyGuideBG:ComputePos()
    PaGlobal_AddFriend_All:updateTab()
    PaGlobalFunc_ConsoleKeyGuide_SetAlign(PaGlobal_AddFriend_All._keyGuides, PaGlobal_AddFriend_All._ui.stc_keyGuideBG, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP)
  else
    PaGlobal_AddFriend_All._ui.rdo_Family:SetShow(false)
    PaGlobal_AddFriend_All._ui.rdo_Character:SetShow(false)
    PaGlobal_AddFriend_All._ui.stc_KeyGuide_RB:SetShow(false)
    PaGlobal_AddFriend_All._ui.stc_KeyGuide_LB:SetShow(false)
    PaGlobal_AddFriend_All._ui.stc_keyGuide_X:SetShow(false)
    PaGlobal_AddFriend_All._ui.stc_keyGuideBG:SetShow(false)
    PaGlobal_AddFriend_All._ui.chk_isFamilyName:SetCheck(PaGlobal_AddFriend_All._isFamilyName)
    PaGlobal_AddFriend_All._ui.chk_isFamilyName:SetText(PAGetString(Defines.StringSheet_GAME, "FRIEND_BTN_NICKNAME"))
  end
end
function PaGlobal_AddFriend_All:registEventHandler()
  if nil == Panel_FriendList_Add_All then
    return
  end
  Panel_FriendList_Add_All:ignorePadSnapMoveToOtherPanel()
  if true == _ContentsGroup_UsePadSnapping then
    if true == _ContentsGroup_RenewUI then
      PaGlobal_AddFriend_All._ui.edit_Name:setXboxVirtualKeyBoardEndEvent("PaGlobal_AddFriend_All_EnterAddFriend")
    else
      PaGlobal_AddFriend_All._ui.edit_Name:RegistReturnKeyEvent("PaGlobal_AddFriend_All_SendAddFriend()")
    end
    Panel_FriendList_Add_All:registerPadEvent(__eConsoleUIPadEvent_Up_X, "PaGlobal_AddFriend_All_SetFocusEdit()")
    Panel_FriendList_Add_All:registerPadEvent(__eConsoleUIPadEvent_Up_A, "PaGlobal_AddFriend_All_SendAddFriend()")
    Panel_FriendList_Add_All:registerPadEvent(__eConsoleUIPadEvent_LB, "PaGlobal_AddFriend_All_ChangeNicknameMode()")
    Panel_FriendList_Add_All:registerPadEvent(__eConsoleUIPadEvent_RB, "PaGlobal_AddFriend_All_ChangeNicknameMode()")
  else
    PaGlobal_AddFriend_All._ui.edit_Name:RegistReturnKeyEvent("PaGlobal_AddFriend_All_SendAddFriend()")
    PaGlobal_AddFriend_All._ui.chk_isFamilyName:addInputEvent("Mouse_LUp", "PaGlobal_AddFriend_All_ChangeNicknameMode()")
    PaGlobal_AddFriend_All._ui.btn_Confirm:addInputEvent("Mouse_LUp", "PaGlobal_AddFriend_All_SendAddFriend()")
    PaGlobal_AddFriend_All._ui.btn_Cancel:addInputEvent("Mouse_LUp", "PaGlobal_AddFriend_All_Close()")
    PaGlobal_AddFriend_All._ui.btn_Close:addInputEvent("Mouse_LUp", "PaGlobal_AddFriend_All_Close()")
  end
end
function PaGlobal_FriendRequest_All:initialize()
  if true == PaGlobal_FriendRequest_All._initialize then
    return
  end
  PaGlobal_FriendRequest_All._ui.btn_Close = UI.getChildControl(Panel_Friend_RequestList_All, "RequestFriend_Close_PCUI")
  PaGlobal_FriendRequest_All._ui.list2_request = UI.getChildControl(Panel_Friend_RequestList_All, "List2_RequestFriend")
  PaGlobal_FriendRequest_All._ui.stc_keyGuideBG = UI.getChildControl(Panel_Friend_RequestList_All, "Static_RequestBottom_ConsoleUI")
  PaGlobal_FriendRequest_All._ui.stc_keyGuide_X = UI.getChildControl(PaGlobal_FriendRequest_All._ui.stc_keyGuideBG, "StaticText_Refuse")
  PaGlobal_FriendRequest_All._ui.stc_keyGuide_A = UI.getChildControl(PaGlobal_FriendRequest_All._ui.stc_keyGuideBG, "StaticText_Accept")
  PaGlobal_FriendRequest_All._ui.stc_KeyGuide_B = UI.getChildControl(PaGlobal_FriendRequest_All._ui.stc_keyGuideBG, "StaticText_Cancel")
  PaGlobal_FriendRequest_All._keyGuides = {
    PaGlobal_FriendRequest_All._ui.stc_keyGuide_X,
    PaGlobal_FriendRequest_All._ui.stc_keyGuide_A,
    PaGlobal_FriendRequest_All._ui.stc_KeyGuide_B
  }
  PaGlobal_FriendRequest_All:preparePlatform()
  PaGlobal_FriendRequest_All._ui.list2_request:createChildContent(__ePAUIList2ElementManagerType_List)
  PaGlobal_FriendRequest_All:registEventHandler()
  PaGlobal_FriendRequest_All._initialize = true
end
function PaGlobal_FriendRequest_All:preparePlatform()
  if nil == Panel_Friend_RequestList_All then
    return
  end
  if true == _ContentsGroup_UsePadSnapping then
    local listContent = UI.getChildControl(PaGlobal_FriendRequest_All._ui.list2_request, "List2_1_Content")
    local child = UI.getChildControl(listContent, "Static_BG")
    child:ChangeOnTextureInfoName("combine/btn/combine_btn_00.dds")
    local x1, y1, x2, y2 = setTextureUV_Func(child, 42, 1, 82, 41)
    child:getOnTexture():setUV(x1, y1, x2, y2)
    PaGlobal_FriendRequest_All._ui.btn_Close:SetShow(false)
    PaGlobalFunc_ConsoleKeyGuide_SetAlign(PaGlobal_FriendRequest_All._keyGuides, PaGlobal_FriendRequest_All._ui.stc_keyGuideBG, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP)
  else
    PaGlobal_FriendRequest_All._ui.stc_keyGuideBG:SetShow(false)
  end
end
function PaGlobal_FriendRequest_All:registEventHandler()
  if nil == Panel_Friend_RequestList_All then
    return
  end
  Panel_Friend_RequestList_All:ignorePadSnapMoveToOtherPanel()
  registerEvent("ResponseFriendList_updateAddFriends", "FromClient_FriendRequest_All_UpdateAddFriends")
  PaGlobal_FriendRequest_All._ui.list2_request:registEvent(__ePAUIList2EventType_LuaChangeContent, "PaGlobal_FriendRequest_All_List2EventControlCreate")
  if false == _ContentsGroup_UsePadSnapping then
    PaGlobal_FriendRequest_All._ui.btn_Close:addInputEvent("Mouse_LUp", "PaGlobal_FriendRequest_All_Close()")
  end
end
function PaGlobal_Friend_GroupRename_All:initialize()
  if true == PaGlobal_Friend_GroupRename_All._initialize then
    return
  end
  PaGlobal_Friend_GroupRename_All._ui.btn_Close = UI.getChildControl(Panel_Friend_GroupRename_All, "Button_GroupName_Close_PCUI")
  PaGlobal_Friend_GroupRename_All._ui.txt_title = UI.getChildControl(Panel_Friend_GroupRename_All, "StaticText_ChangeGroupName")
  PaGlobal_Friend_GroupRename_All._ui.txt_groupDesc = UI.getChildControl(Panel_Friend_GroupRename_All, "StaticText_GruopDesc")
  PaGlobal_Friend_GroupRename_All._ui.sub_BG = UI.getChildControl(Panel_Friend_GroupRename_All, "Static_GroupName_SubBg")
  PaGlobal_Friend_GroupRename_All._ui.edit_GroupName = UI.getChildControl(Panel_Friend_GroupRename_All, "Edit_GroupName")
  PaGlobal_Friend_GroupRename_All._ui.stc_keyGuide_X = UI.getChildControl(Panel_Friend_GroupRename_All, "StaticText_EditGroupKeyGuide_ConsoleUI")
  PaGlobal_Friend_GroupRename_All._ui.btn_Confirm = UI.getChildControl(Panel_Friend_GroupRename_All, "Button_GroupName_Yes_PCUI")
  PaGlobal_Friend_GroupRename_All._ui.btn_Cancel = UI.getChildControl(Panel_Friend_GroupRename_All, "Button_GroupName_No_PCUI")
  PaGlobal_Friend_GroupRename_All._ui.stc_keyGuideBG = UI.getChildControl(Panel_Friend_GroupRename_All, "Static_Bottom_ConsoleUI")
  PaGlobal_Friend_GroupRename_All._ui.stc_KeyGuide_A = UI.getChildControl(PaGlobal_Friend_GroupRename_All._ui.stc_keyGuideBG, "StaticText_Apply")
  PaGlobal_Friend_GroupRename_All._ui.stc_KeyGuide_B = UI.getChildControl(PaGlobal_Friend_GroupRename_All._ui.stc_keyGuideBG, "StaticText_Cancel")
  PaGlobal_Friend_GroupRename_All._keyGuides = {
    PaGlobal_Friend_GroupRename_All._ui.stc_KeyGuide_A,
    PaGlobal_Friend_GroupRename_All._ui.stc_KeyGuide_B
  }
  PaGlobal_Friend_GroupRename_All._ui.edit_GroupName:SetMaxInput(getGameServiceTypeUserNickNameLength())
  PaGlobal_Friend_GroupRename_All:preparePlatform()
  PaGlobal_Friend_GroupRename_All:registEventHandler()
  PaGlobal_Friend_GroupRename_All._initialize = true
end
function PaGlobal_Friend_GroupRename_All:preparePlatform()
  if nil == Panel_Friend_GroupRename_All then
    return
  end
  if true == _ContentsGroup_UsePadSnapping then
    PaGlobal_Friend_GroupRename_All._ui.btn_Close:SetShow(false)
    PaGlobal_Friend_GroupRename_All._ui.btn_Confirm:SetShow(false)
    PaGlobal_Friend_GroupRename_All._ui.btn_Cancel:SetShow(false)
    local subBG = PaGlobal_Friend_GroupRename_All._ui.sub_BG
    Panel_Friend_GroupRename_All:SetSize(Panel_Friend_GroupRename_All:GetSizeX(), Panel_Friend_GroupRename_All:GetSizeY() - 90)
    subBG:SetSize(subBG:GetSizeX(), subBG:GetSizeY() - 90)
    Panel_Friend_GroupRename_All:ComputePos()
    PaGlobal_Friend_GroupRename_All._ui.stc_keyGuideBG:ComputePos()
    PaGlobalFunc_ConsoleKeyGuide_SetAlign(PaGlobal_Friend_GroupRename_All._keyGuides, PaGlobal_Friend_GroupRename_All._ui.stc_keyGuideBG, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP)
  else
    PaGlobal_Friend_GroupRename_All._ui.stc_keyGuide_X:SetShow(false)
    PaGlobal_Friend_GroupRename_All._ui.stc_keyGuideBG:SetShow(false)
  end
end
function PaGlobal_Friend_GroupRename_All:registEventHandler()
  if nil == Panel_Friend_GroupRename_All then
    return
  end
  Panel_Friend_GroupRename_All:ignorePadSnapMoveToOtherPanel()
  if true == _ContentsGroup_UsePadSnapping then
    if true == _ContentsGroup_RenewUI then
      PaGlobal_Friend_GroupRename_All._ui.edit_GroupName:setXboxVirtualKeyBoardEndEvent("PaGlobal_Friend_GroupRename_All_EnterGroupName")
    else
      PaGlobal_Friend_GroupRename_All._ui.edit_GroupName:RegistReturnKeyEvent("PaGlobal_Friend_GroupRename_All_Confirm()")
    end
    Panel_Friend_GroupRename_All:registerPadEvent(__eConsoleUIPadEvent_Up_X, "PaGlobal_Friend_GroupRename_All_SetFocusEdit()")
    Panel_Friend_GroupRename_All:registerPadEvent(__eConsoleUIPadEvent_Up_A, "PaGlobal_Friend_GroupRename_All_Confirm()")
  else
    PaGlobal_Friend_GroupRename_All._ui.edit_GroupName:RegistReturnKeyEvent("PaGlobal_Friend_GroupRename_All_Confirm()")
    PaGlobal_Friend_GroupRename_All._ui.edit_GroupName:addInputEvent("Mouse_LUp", "PaGlobal_Friend_GroupRename_All_SetFocusEdit()")
    PaGlobal_Friend_GroupRename_All._ui.btn_Confirm:addInputEvent("Mouse_LUp", "PaGlobal_Friend_GroupRename_All_Confirm()")
    PaGlobal_Friend_GroupRename_All._ui.btn_Cancel:addInputEvent("Mouse_LUp", "PaGlobal_Friend_GroupRename_All_Close()")
    PaGlobal_Friend_GroupRename_All._ui.btn_Close:addInputEvent("Mouse_LUp", "PaGlobal_Friend_GroupRename_All_Close()")
  end
end
Panel_FriendList_All:RegisterShowEventFunc(true, "PaGlobal_FriendList_All_ShowAni()")
Panel_FriendList_All:RegisterShowEventFunc(false, "PaGlobal_FriendList_All_HideAni()")
registerEvent("onScreenResize", "FromClient_FriendList_All_OnScreenResize")
registerEvent("FromClient_FriendListUpdateMessanger", "FromClient_FriendListUpdateMessanger")
registerEvent("FromClient_FriendListOpenMessanger", "FromClient_FriendListOpenMessanger")
registerEvent("FromClient_GroundMouseClick", "FriendMessanger_KillFocusEdit")
registerEvent("FromClient_NotifyFriendMessage", "FromClient_NotifyFriendMessage")
registerEvent("FromClient_FriendDirectlyMessage", "FromClient_FriendDirectlyMessage")
