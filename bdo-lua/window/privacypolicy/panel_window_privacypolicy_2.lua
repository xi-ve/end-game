function HandleEvent_PrivacyPolicy_WebBannerInput(key)
  if nil == Panel_Window_PrivacyPolicy then
    return
  end
  if false == Panel_Window_PrivacyPolicy:GetShow() then
    return
  end
  PaGlobal_PrivacyPolicy:webBannerInput(key)
end
function PaGlobal_PrivacyPolicy_onScreenResize()
  if nil == Panel_Window_PrivacyPolicy then
    return
  end
  PaGlobal_PrivacyPolicy:onScreenResize()
end
function PaGlobal_PrivacyPolicy_CheckAcceptPolicy()
  if true == lobbyGetNeedToReacceptPolicy() then
    PaGlobal_Copyright_Open(false, true)
  else
    registerNickname()
  end
end
registerEvent("onScreenResize", "PaGlobal_PrivacyPolicy_onScreenResize")
registerEvent("FromClient_CheckAcceptPolicy", "PaGlobal_PrivacyPolicy_CheckAcceptPolicy")
