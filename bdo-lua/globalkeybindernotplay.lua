local VCK = CppEnums.VirtualKeyCode
local GlobalKeyBinder_CheckKeyPressed = function(keyCode)
  return isKeyDown_Once(keyCode)
end
function GlobalKeyBinder_UpdateNotPlay(deltaTime)
  if MessageBox.isPopUp() then
    local pcKey = GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_RETURN) or GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_SPACE)
    if pcKey and not _ContentsGroup_UsePadSnapping then
      MessageBox.keyProcessEnter()
      setUiInputProcessed(VCK.KeyCode_RETURN)
      setUiInputProcessed(VCK.KeyCode_SPACE)
      return true
    elseif isPadUp(__eJoyPadInputType_A) and _ContentsGroup_UsePadSnapping then
    elseif GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
      MessageBox.keyProcessEscape()
      return true
    end
  end
  local uiEdit = GetFocusEdit()
  if nil ~= Panel_Login and Panel_Login:GetShow() or nil ~= Panel_Login_Renew and Panel_Login_Renew:GetShow() or nil ~= Panel_Login_Remaster and Panel_Login_Remaster:GetShow() or nil ~= Panel_Lobby_Login_All and Panel_Lobby_Login_All:GetShow() then
    if nil ~= Panel_Window_Policy and Panel_Window_Policy:GetShow() then
      if true == ToClient_isConsole() and GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
        PaGlobal_Policy_Decline()
        return
      end
    elseif nil ~= Panel_Window_Copyright and Panel_Window_Copyright:GetShow() then
      if true == ToClient_isConsole() and GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
        PaGlobal_Copyright_ForceClose()
        return
      end
    elseif nil ~= Panel_Copyright and Panel_Copyright:GetShow() then
      if false == ToClient_isConsole() and GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
        PaGlobal_Copyright_Close()
        return
      end
    elseif nil ~= Panel_Window_PrivacyPolicy and Panel_Window_PrivacyPolicy:GetShow() then
      if true == ToClient_isConsole() and GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
        PaGlobal_PrivacyPolicy_ForceClose()
        return
      end
    elseif nil ~= uiEdit and true == _ContentsGroup_isNewOption and true == FGlobal_Option_CheckUiEdit(uiEdit) then
      if GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
        ClearFocusEdit()
      elseif GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_RETURN) and true == _ContentsGroup_NewUI_GameOption_All then
        PaGlobal_GameOption_All:ClickedSearchOption()
      end
    elseif nil ~= Panel_TermsofGameUse and Panel_TermsofGameUse:GetShow() then
      if GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_RETURN) then
        FGlobal_HandleClicked_TermsofGameUse_Next()
      elseif GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
        FGlobal_TermsofGameUse_Close()
      end
    elseif nil ~= Panel_Login_Password and Panel_Login_Password:GetShow() then
      if GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_RETURN) then
        LoginPassword_Enter()
      elseif GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
        LoginPassword_Cancel()
      end
    elseif nil ~= Panel_Login_Password_All and Panel_Login_Password_All:GetShow() then
      if GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_RETURN) then
        HandleEventLUp_LoginPassword_All_Apply()
      elseif GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
        HandleEventLUp_LoginPassword_All_Cancel()
      end
    elseif nil ~= Panel_Login_Nickname and Panel_Login_Nickname:GetShow() then
      return
    elseif nil ~= Panel_Login_Nickname_Renew and Panel_Login_Nickname_Renew:GetShow() then
      return
    elseif nil ~= Panel_Login_Nickname_All and Panel_Login_Nickname_All:GetShow() then
      if GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_RETURN) and false == _ContentsGroup_UsePadSnapping then
        HandleEventLUp_LoginNickname_All_ApplyNickname()
      end
      return
    elseif GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_RETURN) then
      if true == _ContentsGroup_NewUI_Login_All then
        if false == _ContentsGroup_UsePadSnapping then
          HandleEventLUp_Login_All_LoginStart()
        end
      else
        Panel_Login_BeforOpen()
      end
    elseif nil ~= Panel_Lobby_UserSetting and Panel_Lobby_UserSetting:GetShow() then
      if GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
        PaGlobalFunc_UserSetting_Close()
      end
    elseif nil ~= Panel_Window_ConsoleUIOffset and Panel_Window_ConsoleUIOffset:GetShow() and GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
      PaGlobal_ConsoleUIOffset_Close()
    end
    if _ContentsGroup_RenewUI and GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) and isLoginIDShow() then
      ClearFocusEdit()
      return
    end
  end
  if true == _ContentsGroup_UsePadSnapping then
    if true == ToClient_isServerSelectProcessor() and GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
      if nil ~= Panel_WebControl_Renew and Panel_WebControl_Renew:GetShow() then
        PaGlobalFunc_WebControl_Close()
        return
      end
      ToClient_disConnectToPressAForXBOX()
    end
  elseif nil ~= Panel_Lobby_ServerSelect_All and true == Panel_Lobby_ServerSelect_All:GetShow() then
    if GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_F1) then
      HandleEventLUp_ServerSelect_All_EnterMainServer()
      return
    elseif GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_F2) then
      HandleEventLUp_ServerSelect_All_EnterLastJoinedServer()
      return
    elseif GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_F3) then
      HandleEventLUp_ServerSelect_All_EnterRandomServer()
      return
    end
  elseif nil ~= Panel_Lobby_ServerSelect_Remaster and true == Panel_Lobby_ServerSelect_Remaster:GetShow() then
    if GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_F1) then
      InputMLUp_ServerSelect_EnterMainServer()
      return
    elseif GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_F2) then
      InputMLUp_ServerSelect_EnterLastJoinedServer()
      return
    elseif GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_F3) then
      InputMLUp_ServerSelect_EnterRandomServer()
      return
    end
  end
  if false == _ContentsGroup_RenewUI and (true == _ContentsGroup_SeasonContents or true == _ContentsGroup_PreSeason) and nil ~= Panel_Window_SeasonBanner and true == Panel_Window_SeasonBanner:GetShow() and (GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) or GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_RETURN) or GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_SPACE)) then
    PaGlobalFunc_SeasonBanner_SpaceKeyInput(true)
    return
  end
  if nil ~= Panel_CharacterCreateSelectClass and Panel_CharacterCreateSelectClass:GetShow() then
    if GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
      Panel_CharacterCreateCancel()
    end
    if GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_CONTROL) then
      PaGlobalFunc_SelectShadowCharacter_Toggle()
    end
  end
  if nil ~= Panel_Lobby_ClassSelect_Renew and Panel_Lobby_ClassSelect_Renew:GetShow() and GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
    Panel_CharacterCreateCancel()
  end
  if nil ~= Panel_CustomizationMain and GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) and true == characterCreateIsOnLookAtCameraTimerRunning() then
    characterCreateCancelIntroAction()
    return
  end
  if true == _ContentsGroup_NewUI_CharacterSelect_All then
    if nil ~= Panel_CharacterSelect_All and true == Panel_CharacterSelect_All:GetShow() and GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
      HandleEventLUp_CharacterSelect_All_BackToServerSelect()
    end
  else
    if nil ~= Panel_CharacterSelectNew and Panel_CharacterSelectNew:GetShow() and GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
      CharacterSelect_Back()
    end
    if nil ~= Panel_CharacterSelect_Renew and Panel_CharacterSelect_Renew:GetShow() and GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
      PaGlobal_CharacterSelect_BackToServerSelect()
    end
    if nil ~= Panel_Lobby_CharacterSelect_Remaster and Panel_Lobby_CharacterSelect_Remaster:GetShow() and GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
      InputMLUp_CharacterSelect_ExitToServerSelect()
    end
  end
  if nil ~= Panel_Window_GameOption_All and Panel_Window_GameOption_All:GetShow() and GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
    Panel_Window_GameOption_All:SetShow(false)
    TooltipSimple_Hide()
  end
  if nil ~= Panel_Window_cOption and Panel_Window_cOption:GetShow() and GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
    Panel_Window_cOption:SetShow(false, true)
  end
  if true == _ContentsGroup_RenewUI_Customization then
    if nil ~= Panel_Customizing and true == PaGlobalFunc_Customization_GetShow() and GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
      PaGlobalFunc_Customization_Back()
    end
    if nil ~= Panel_Widget_ScreenShotFrame and Panel_Widget_ScreenShotFrame:GetShow() and GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
      local screenShotFrame_Close = function()
        FGlobal_ScreenShotFrame_Close()
      end
      local messageBoxMemo = PAGetString(Defines.StringSheet_GAME, "LUA_SCREENSHOTFRAME_MSGBOX_CONTENT")
      local messageBoxData = {
        title = PAGetString(Defines.StringSheet_GAME, "LUA_SCREENSHOTFRAME_MSGBOX_TITLE"),
        content = messageBoxMemo,
        functionYes = screenShotFrame_Close,
        functionNo = MessageBox_Empty_function,
        exitButton = true,
        priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
      }
      MessageBox.showMessageBox(messageBoxData)
      return
    end
  end
end
registerEvent("EventGlobalKeyBinderNotPlay", "GlobalKeyBinder_UpdateNotPlay")
