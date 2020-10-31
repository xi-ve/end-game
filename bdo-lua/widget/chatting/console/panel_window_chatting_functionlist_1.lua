function PaGlobal_Chatting_FunctionList:initialize()
  if true == PaGlobal_Chatting_FunctionList._initialize then
    return
  end
  Panel_Chatting_FunctionList:ignorePadSnapMoveToOtherPanel()
  PaGlobal_Chatting_FunctionList._chatFunc = {
    [PaGlobal_Chatting_FunctionList._CHAT_FUNCTYPE.WHISPER] = {
      _title = PAGetString(Defines.StringSheet_RESOURCE, "CHAT_SUB_TXT_WHISPER"),
      _excuteFunc = PaGlobal_Chatting_FunctionList_Wispher,
      _isShow = true,
      _getSenderFunc = PaGlobalFunc_ChattingHistory_GetSelectedSender
    },
    [PaGlobal_Chatting_FunctionList._CHAT_FUNCTYPE.PARTY] = {
      _title = PAGetString(Defines.StringSheet_RESOURCE, "INTERACTION_BTN_PARTY"),
      _excuteFunc = PaGlobal_Chatting_FunctionList_InviteParty,
      _isShow = true,
      _getSenderFunc = PaGlobalFunc_ChattingHistory_GetSelectedSenderForPartyInvite
    },
    [PaGlobal_Chatting_FunctionList._CHAT_FUNCTYPE.LARGEPARTY] = {
      _title = PAGetString(Defines.StringSheet_RESOURCE, "INTERACTION_BTN_LARGEPARTY"),
      _excuteFunc = PaGlobal_Chatting_FunctionList_InviteLargeParty,
      _isShow = _ContentsGroup_LargeParty,
      _getSenderFunc = PaGlobalFunc_ChattingHistory_GetSelectedSenderForPartyInvite
    },
    [PaGlobal_Chatting_FunctionList._CHAT_FUNCTYPE.FRIEND] = {
      _title = PAGetString(Defines.StringSheet_RESOURCE, "CHAT_SUB_TXT_ADDFRIEND"),
      _excuteFunc = PaGlobal_Chatting_FunctionList_AddFriend,
      _isShow = true,
      _getSenderFunc = PaGlobalFunc_ChattingHistory_GetSelectedSender
    },
    [PaGlobal_Chatting_FunctionList._CHAT_FUNCTYPE.BLOCK] = {
      _title = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_CHAT_SUBMENU_BTN_BLOCK"),
      _excuteFunc = PaGlobal_Chatting_FunctionList_BlockUser,
      _isShow = true,
      _getSenderFunc = PaGlobalFunc_ChattingHistory_GetSelectedSender
    },
    [PaGlobal_Chatting_FunctionList._CHAT_FUNCTYPE.BLOCKLIST] = {
      _title = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_CHATTING_OPTION_BLOCKLIST_TITLE"),
      _excuteFunc = PaGlobal_Chatting_FunctionList_BlockList_Open,
      _isShow = true
    }
  }
  local centerBG = UI.getChildControl(Panel_Chatting_FunctionList, "Static_CenterBg")
  PaGlobal_Chatting_FunctionList._ui.list2_ChattingFunction = UI.getChildControl(centerBG, "List2_FunctionList")
  PaGlobal_Chatting_FunctionList._ui.stc_centerBG = UI.getChildControl(Panel_Chatting_FunctionList, "Static_CenterBg")
  PaGlobal_Chatting_FunctionList._ui.stc_keyguideBG = UI.getChildControl(Panel_Chatting_FunctionList, "Static_BottomBg")
  local _stc_keyguideY = UI.getChildControl(PaGlobal_Chatting_FunctionList._ui.stc_keyguideBG, "StaticText_Y_ConsoleUI")
  local _stc_keyguideB = UI.getChildControl(PaGlobal_Chatting_FunctionList._ui.stc_keyguideBG, "StaticText_B_ConsoleUI")
  local keyGuideList = {_stc_keyguideY, _stc_keyguideB}
  PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyGuideList, PaGlobal_Chatting_FunctionList._ui.stc_keyguideBG, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHT)
  PaGlobal_Chatting_FunctionList._ui.txt_famillyName = UI.getChildControl(Panel_Chatting_FunctionList, "StaticText_FamilyName")
  PaGlobal_Chatting_FunctionList._ui.txt_characterName = UI.getChildControl(Panel_Chatting_FunctionList, "StaticText_CharacterName")
  PaGlobal_Chatting_FunctionList._ui.stc_platformIcon = UI.getChildControl(Panel_Chatting_FunctionList, "Static_CrossPlay")
  PaGlobal_Chatting_FunctionList._defaultPanelSize = Panel_Chatting_FunctionList:GetSizeY()
  PaGlobal_Chatting_FunctionList:registEventHandler()
  PaGlobal_Chatting_FunctionList:validate()
  PaGlobal_Chatting_FunctionList._initialize = true
end
function PaGlobal_Chatting_FunctionList:registEventHandler()
  if nil == Panel_Chatting_FunctionList then
    return
  end
  PaGlobal_Chatting_FunctionList._ui.list2_ChattingFunction:registEvent(__ePAUIList2EventType_LuaChangeContent, "PaGlobalFunc_ChattingInfo_PushFunction")
  PaGlobal_Chatting_FunctionList._ui.list2_ChattingFunction:createChildContent(__ePAUIList2ElementManagerType_List)
  registerEvent("ResponseParty_refuse", "PaGlobal_Chatting_FunctionList_BlockList_Close")
end
function PaGlobal_Chatting_FunctionList:prepareOpen()
  if nil == Panel_Chatting_FunctionList then
    return
  end
  local vScroll = PaGlobal_Chatting_FunctionList._ui.list2_ChattingFunction:GetVScroll()
  vScroll:SetControlPos(0)
  local familyName = PaGlobalFunc_ChattingHistory_GetSelectedSender(1)
  local characterName = PaGlobalFunc_ChattingHistory_GetSelectedSender(0)
  local platformType = PaGlobalFunc_ChattingHistory_GetPlatformType()
  PaGlobal_Chatting_FunctionList._ui.stc_platformIcon:SetShow(false)
  if nil ~= familyName and "" ~= familyName and nil ~= characterName and "" ~= characterName then
    PaGlobal_Chatting_FunctionList._ui.txt_famillyName:SetText(familyName)
    PaGlobal_Chatting_FunctionList._ui.txt_characterName:SetText(characterName)
    PaGlobal_Chatting_FunctionList._ui.txt_characterName:SetShow(true)
    Panel_Chatting_FunctionList:SetSize(Panel_Chatting_FunctionList:GetSizeX(), PaGlobal_Chatting_FunctionList._defaultPanelSize)
  else
    PaGlobal_Chatting_FunctionList._ui.txt_famillyName:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_CHATTINGFUNCTION_TITLE"))
    PaGlobal_Chatting_FunctionList._ui.txt_characterName:SetShow(false)
    Panel_Chatting_FunctionList:SetSize(Panel_Chatting_FunctionList:GetSizeX(), PaGlobal_Chatting_FunctionList._defaultPanelSize - 30)
  end
  PaGlobal_Chatting_FunctionList._ui.stc_centerBG:ComputePos()
  PaGlobal_Chatting_FunctionList._ui.stc_keyguideBG:ComputePos()
  if true == ToClient_isTotalGameClient() then
    PaGlobal_Chatting_FunctionList:setPlatformIcon(PaGlobal_Chatting_FunctionList._ui.stc_platformIcon, platformType)
  end
  PaGlobal_Chatting_FunctionList:initChattingFuncList()
  PaGlobal_Chatting_FunctionList:open()
  ToClient_padSnapSetTargetPanel(Panel_Chatting_FunctionList)
end
function PaGlobal_Chatting_FunctionList:open()
  if nil == Panel_Chatting_FunctionList then
    return
  end
  Panel_Chatting_FunctionList:SetShow(true)
end
function PaGlobal_Chatting_FunctionList:prepareClose()
  if nil == Panel_Chatting_FunctionList then
    return
  end
  PaGlobal_Chatting_FunctionList:close()
end
function PaGlobal_Chatting_FunctionList:close()
  if nil == Panel_Chatting_FunctionList then
    return
  end
  Panel_Chatting_FunctionList:SetShow(false)
end
function PaGlobal_Chatting_FunctionList:update()
  if nil == Panel_Chatting_FunctionList then
    return
  end
end
function PaGlobal_Chatting_FunctionList:validate()
  if nil == Panel_Chatting_FunctionList then
    return
  end
  PaGlobal_Chatting_FunctionList._ui.list2_ChattingFunction:isValidate()
  PaGlobal_Chatting_FunctionList._ui.txt_famillyName:isValidate()
  PaGlobal_Chatting_FunctionList._ui.txt_characterName:isValidate()
end
function PaGlobalFunc_ChattingInfo_PushFunction(content, key)
  local index = Int64toInt32(key)
  local txt_functionName = UI.getChildControl(content, "StaticText_FunctionName")
  txt_functionName:SetTextMode(__eTextMode_LimitText)
  txt_functionName:SetText(PaGlobal_Chatting_FunctionList._chatFunc[index]._title)
  content:registerPadEvent(__eConsoleUIPadEvent_Y, "PaGlobal_Chatting_FunctionList_ExcuteChattingFunc(" .. index .. ")")
end
function PaGlobal_Chatting_FunctionList:initChattingFuncList()
  PaGlobal_Chatting_FunctionList._ui.list2_ChattingFunction:getElementManager():clearKey()
  local param
  PaGlobal_Chatting_FunctionList._currentFuncCount = 0
  local isShow = false
  for ii = 1, #PaGlobal_Chatting_FunctionList._chatFunc do
    isShow = false
    if true == PaGlobal_Chatting_FunctionList._chatFunc[ii]._isShow then
      if nil ~= PaGlobal_Chatting_FunctionList._chatFunc[ii]._getSenderFunc then
        if nil ~= PaGlobal_Chatting_FunctionList._chatFunc[ii]._getSenderFunc() and "" ~= PaGlobal_Chatting_FunctionList._chatFunc[ii]._getSenderFunc() then
          isShow = true
        end
      else
        isShow = true
      end
    end
    if true == isShow then
      PaGlobal_Chatting_FunctionList._ui.list2_ChattingFunction:getElementManager():pushKey(ii)
      PaGlobal_Chatting_FunctionList._currentFuncCount = PaGlobal_Chatting_FunctionList._currentFuncCount + 1
    end
  end
end
function PaGlobal_Chatting_FunctionList:setPlatformIcon(targetControl, platformType)
  targetControl:SetShow(false)
  if nil == platformType then
    return
  end
  if true == _ContentsGroup_ConsoleIntegration then
    targetControl:SetShow(true)
    local selfPlayerPlatform = ToClient_getGamePlatformType()
    if selfPlayerPlatform == platformType then
      if __eGAME_PLATFORM_TYPE_PS == selfPlayerPlatform then
        targetControl:ChangeTextureInfoName("combine/commonicon/crossplay_icon_ps.dds")
      elseif __eGAME_PLATFORM_TYPE_XB == selfPlayerPlatform then
        targetControl:ChangeTextureInfoName("combine/commonicon/crossplay_icon_xb.dds")
      end
    else
      targetControl:ChangeTextureInfoName("combine/commonicon/crossplay_icon_other.dds")
    end
  end
end
