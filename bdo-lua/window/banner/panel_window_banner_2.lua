function HandleEventMLUp_Banner_ClickEvent()
  if PaGlobal_Banner._eBannerType._onAir == PaGlobal_Banner._currentBanner then
    ToClient_OpenChargeWebPage("https://www.twitch.tv/blackdesertkr")
  elseif PaGlobal_Banner._eBannerType._eventBanner == PaGlobal_Banner._currentBanner then
    ToClient_OpenChargeWebPage(PaGlobal_Banner_GetEventPageMoveURL())
  elseif PaGlobal_Banner._eBannerType._blackFriday == PaGlobal_Banner._currentBanner then
    PaGlobal_Banner_GoToPearlShop()
  end
  PaGlobal_Banner:updatePerSkipNextState()
end
function HandleEventMLUp_Banner_NotShowClose()
  PaGlobal_Banner:saveNoShowToDay(PaGlobal_Banner._currentBanner)
  PaGlobal_Banner:updatePerSkipNextState()
end
function FromClient_Banner_showOnAirBanner(isOnAir)
  if nil == Panel_Window_Banner then
    return
  end
  if true == isOnAir then
    PaGlobal_Banner:runSingleBanner(PaGlobal_Banner._eBannerType._onAir)
  elseif true == Panel_Window_Banner:GetShow() and PaGlobal_Banner._eBannerType._onAir == PaGlobal_Banner._currentBanner then
    PaGlobal_Banner:updatePerSkipNextState()
  end
end
function PaGloabl_Banner_ShowAni()
  if nil == Panel_Window_Banner then
    return
  end
  local startAniTime = PaGlobal_Banner._startAniTime[PaGlobal_Banner._currentBanner]
  local ImageMoveAni = Panel_Window_Banner:addMoveAnimation(startAniTime._start, startAniTime._end, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
  ImageMoveAni:SetStartPosition(getScreenSizeX() - Panel_Window_Banner:GetSizeX() - 10, getScreenSizeY() - 10)
  ImageMoveAni:SetEndPosition(getScreenSizeX() - Panel_Window_Banner:GetSizeX() - 10, getScreenSizeY() - Panel_Window_Banner:GetSizeY() - 10)
  ImageMoveAni.IsChangeChild = true
end
function PaGloabl_Banner_HideAni()
  if nil == Panel_Window_Banner then
    return
  end
  local endAniTime = PaGlobal_Banner._endAniTime[PaGlobal_Banner._currentBanner]
  local ImageMoveAni = Panel_Window_Banner:addMoveAnimation(endAniTime._start, endAniTime._end, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
  ImageMoveAni:SetStartPosition(getScreenSizeX() - Panel_Window_Banner:GetSizeX() - 10, getScreenSizeY() - Panel_Window_Banner:GetSizeY() - 10)
  ImageMoveAni:SetEndPosition(getScreenSizeX() - Panel_Window_Banner:GetSizeX() + 10, getScreenSizeY() + 10)
  ImageMoveAni.IsChangeChild = true
  ImageMoveAni:SetHideAtEnd(false)
end
function PaGlobal_Banner_UpdatePerframe(deltaTime)
  if PaGlobal_Banner._eFrameState._bannerView == PaGlobal_Banner._currentFrame then
    PaGlobal_Banner:updatePerFrame_bannerView(deltaTime)
  elseif PaGlobal_Banner._eFrameState._bannerViewEnd == PaGlobal_Banner._currentFrame then
    PaGlobal_Banner:updateCheckBannerViewEnd()
  elseif PaGlobal_Banner._eFrameState._bannerCheck == PaGlobal_Banner._currentFrame then
    PaGlobal_Banner:updatePerFrame_bannerCheck(deltaTime)
  elseif PaGlobal_Banner._eFrameState._end == PaGlobal_Banner._currentFrame then
    PaGlobal_Banner:updatePerFrame_End(deltaTime)
  end
end
function PaGloabl_Banner_GetOnAirURL()
  local url = "http://dev-cashshop.pearlabyss.com/CashShop/Banner/BottomBanner"
  if CppEnums.CountryType.KOR_ALPHA == getGameServiceType() then
    url = "http://game-portal-qa.kr.playblackdesert.com/Banner/BottomBanner"
  elseif CppEnums.CountryType.KOR_REAL == getGameServiceType() then
    url = "http://game-portal.kr.playblackdesert.com/Banner/BottomBanner"
  elseif CppEnums.CountryType.TW_ALPHA == getGameServiceType() then
    url = "http://game-portal-qa.tw.playblackdesert.com/Banner/BottomBanner"
  elseif CppEnums.CountryType.TW_REAL == getGameServiceType() then
    url = "https://game-portal.tw.playblackdesert.com/Banner/BottomBanner"
  elseif CppEnums.CountryType.TR_ALPHA == getGameServiceType() then
    url = "http://game-portal-qa.tr.playblackdesert.com/Banner/BottomBanner"
  elseif CppEnums.CountryType.TR_REAL == getGameServiceType() then
    url = "https://game-portal.tr.playblackdesert.com/Banner/BottomBanner"
  elseif CppEnums.CountryType.TH_ALPHA == getGameServiceType() then
    url = "http://game-portal-qa.th.playblackdesert.com/Banner/BottomBanner"
  elseif CppEnums.CountryType.TH_REAL == getGameServiceType() then
    url = "https://game-portal.th.playblackdesert.com/Banner/BottomBanner"
  elseif CppEnums.CountryType.ID_ALPHA == getGameServiceType() then
    url = "http://game-portal-qa.sea.playblackdesert.com/Banner/BottomBanner"
  elseif CppEnums.CountryType.ID_REAL == getGameServiceType() then
    url = "https://game-portal.sea.playblackdesert.com/Banner/BottomBanner"
  elseif CppEnums.CountryType.RUS_ALPHA == getGameServiceType() then
    url = "http://game-portal-qa.ru.playblackdesert.com/Banner/BottomBanner"
  elseif CppEnums.CountryType.RUS_REAL == getGameServiceType() then
    url = "https://game-portal.ru.playblackdesert.com/Banner/BottomBanner"
  elseif CppEnums.CountryType.JPN_ALPHA == getGameServiceType() then
    url = "http://game-portal-qa.jp.playblackdesert.com/Banner/BottomBanner"
  elseif CppEnums.CountryType.JPN_REAL == getGameServiceType() then
    url = "https://game-portal.jp.playblackdesert.com/Banner/BottomBanner"
  else
    url = "http://dev-cashshop.pearlabyss.com/Banner/BottomBanner"
  end
  return url
end
function PaGloabl_Banner_GetBloodAltarURL()
  local url = ""
  if true == ToClient_IsDevelopment() then
    url = "http://dev-cashshop.pearlabyss.com/CashShop/Banner/BottomBanner"
  elseif isGameTypeKorea() then
    url = "http://dev-cashshop.pearlabyss.com/CashShop/Banner/BottomBanner"
  elseif CppEnums.CountryType.TW_ALPHA == getGameServiceType() then
    url = "http://game-portal-qa.tw.playblackdesert.com/CashShop/Banner/BottomBanner"
  elseif CppEnums.CountryType.TW_REAL == getGameServiceType() then
    url = "https://game-portal.tw.playblackdesert.com/CashShop/Banner/BottomBanner"
  elseif CppEnums.CountryType.TR_ALPHA == getGameServiceType() then
    url = "http://game-portal-qa.tr.playblackdesert.com/CashShop/Banner/BottomBanner"
  elseif CppEnums.CountryType.TR_REAL == getGameServiceType() then
    url = "https://game-portal.tr.playblackdesert.com/CashShop/Banner/BottomBanner"
  elseif CppEnums.CountryType.TH_ALPHA == getGameServiceType() then
    url = "http://game-portal-qa.th.playblackdesert.com/CashShop/Banner/BottomBanner"
  elseif CppEnums.CountryType.TH_REAL == getGameServiceType() then
    url = "https://game-portal.th.playblackdesert.com/CashShop/Banner/BottomBanner"
  elseif CppEnums.CountryType.ID_ALPHA == getGameServiceType() then
    url = "http://game-portal-qa.sea.playblackdesert.com/CashShop/Banner/BottomBanner"
  elseif CppEnums.CountryType.ID_REAL == getGameServiceType() then
    url = "https://game-portal.sea.playblackdesert.com/CashShop/Banner/BottomBanner"
  elseif CppEnums.CountryType.RUS_ALPHA == getGameServiceType() then
    url = "http://game-portal-qa.ru.playblackdesert.com/CashShop/Banner/BottomBanner"
  elseif CppEnums.CountryType.RUS_REAL == getGameServiceType() then
    url = "https://game-portal.ru.playblackdesert.com/CashShop/Banner/BottomBanner"
  end
  return url
end
function PaGlobal_Banner_GetEventPageMoveURL()
  local url
  if isGameTypeKorea() then
    url = "https://www.kr.playblackdesert.com/News/Notice?boardType=3"
  elseif CppEnums.CountryType.TW_REAL == getGameServiceType() or CppEnums.CountryType.TW_ALPHA == getGameServiceType() then
    url = "https://www.tw.playblackdesert.com/News/Notice?boardType=3"
  elseif CppEnums.CountryType.TR_REAL == getGameServiceType() or CppEnums.CountryType.TR_ALPHA == getGameServiceType() then
    url = "https://www.tr.playblackdesert.com/News/Notice?boardType=3"
  elseif CppEnums.CountryType.TH_REAL == getGameServiceType() or CppEnums.CountryType.TH_ALPHA == getGameServiceType() then
    url = "https://www.th.playblackdesert.com/News/Notice?boardType=3"
  elseif CppEnums.CountryType.ID_REAL == getGameServiceType() or CppEnums.CountryType.ID_ALPHA == getGameServiceType() then
    url = "https://www.sea.playblackdesert.com/News/Notice?boardType=3"
  elseif CppEnums.CountryType.RUS_REAL == getGameServiceType() or CppEnums.CountryType.RUS_ALPHA == getGameServiceType() then
    url = "https://www.ru.playblackdesert.com/News/Notice?boardType=3"
  elseif CppEnums.CountryType.SA_REAL == getGameServiceType() or CppEnums.CountryType.SA_ALPHA == getGameServiceType() then
    if __ePASRT_SP == getGameServiceResType() then
      url = "http://blackdesert-forums.playredfox.com/index.php?forums/eventos.178/"
    else
      url = "http://blackdesert-forums.playredfox.com/index.php?forums/eventos.179/"
    end
  elseif CppEnums.CountryType.NA_REAL == getGameServiceType() or CppEnums.CountryType.NA_ALPHA == getGameServiceType() then
    if __ePASRT_DE == getGameServiceResType() then
      url = "https://www.blackdesertonline.com/news/list/event?category=event&lang=DE"
    elseif __ePASRT_SP == getGameServiceResType() then
      url = "https://www.blackdesertonline.com/news/list/event?category=event&lang=ES"
    elseif __ePASRT_FR == getGameServiceResType() then
      url = "https://www.blackdesertonline.com/news/list/event?category=event&lang=FR"
    else
      url = "https://www.blackdesertonline.com/news/list/event"
    end
  elseif CppEnums.CountryType.JPN_REAL == getGameServiceType() or CppEnums.CountryType.JPN_ALPHA == getGameServiceType() then
    url = "https://www.jp.playblackdesert.com/News/Notice?boardType=3"
  else
    url = ""
  end
  return url
end
function PaGlobal_Banner_GetNewProductURL()
  local url = ""
  if CppEnums.CountryType.KOR_ALPHA == getGameServiceType() then
    url = "http://game-portal-qa.kr.playblackdesert.com/Cashshop/Banner/BottomBanner"
  elseif CppEnums.CountryType.KOR_REAL == getGameServiceType() then
    url = "https://game-portal.kr.playblackdesert.com/Cashshop/Banner/BottomBanner"
  elseif CppEnums.CountryType.TW_ALPHA == getGameServiceType() then
    url = "http://game-portal-qa.tw.playblackdesert.com/Cashshop/Banner/BottomBanner"
  elseif CppEnums.CountryType.TW_REAL == getGameServiceType() then
    url = "https://game-portal.tw.playblackdesert.com/Cashshop/Banner/BottomBanner"
  elseif CppEnums.CountryType.TR_ALPHA == getGameServiceType() then
    url = "http://game-portal-qa.tr.playblackdesert.com/CashShop/Banner/BottomBanner"
  elseif CppEnums.CountryType.TR_REAL == getGameServiceType() then
    url = "https://game-portal.tr.playblackdesert.com/CashShop/Banner/BottomBanner"
  elseif CppEnums.CountryType.TH_ALPHA == getGameServiceType() then
    url = "http://game-portal-qa.th.playblackdesert.com/CashShop/Banner/BottomBanner"
  elseif CppEnums.CountryType.TH_REAL == getGameServiceType() then
    url = "https://game-portal.th.playblackdesert.com/CashShop/Banner/BottomBanner"
  elseif CppEnums.CountryType.ID_ALPHA == getGameServiceType() then
    url = "http://game-portal-qa.sea.playblackdesert.com/CashShop/Banner/BottomBanner"
  elseif CppEnums.CountryType.ID_REAL == getGameServiceType() then
    url = "https://game-portal.sea.playblackdesert.com/CashShop/Banner/BottomBanner"
  elseif CppEnums.CountryType.RUS_ALPHA == getGameServiceType() then
    url = "http://game-portal-qa.ru.playblackdesert.com/CashShop/Banner/BottomBanner"
  elseif CppEnums.CountryType.RUS_REAL == getGameServiceType() then
    url = "https://game-portal.ru.playblackdesert.com/CashShop/Banner/BottomBanner"
  elseif CppEnums.CountryType.SA_REAL == getGameServiceType() or CppEnums.CountryType.SA_ALPHA == getGameServiceType() then
    if __ePASRT_ES == getGameServiceResType() or __ePASRT_SP == getGameServiceResType() then
      url = "https://blackdesert.playredfox.com/black_desert/gameweb/rb_banner?locale=es"
    elseif __ePASRT_PT == getGameServiceResType() then
      url = "https://blackdesert.playredfox.com/black_desert/gameweb/rb_banner?locale=pt"
    end
  elseif CppEnums.CountryType.NA_ALPHA == getGameServiceType() then
    if __ePASRT_EN == getGameServiceResType() then
      url = "https://test.blackdesertonline.com/ingame/popup?lang=en"
    elseif __ePASRT_DE == getGameServiceResType() then
      url = "https://test.blackdesertonline.com/ingame/popup?lang=de"
    elseif __ePASRT_FR == getGameServiceResType() then
      url = "https://test.blackdesertonline.com/ingame/popup?lang=fr"
    elseif __ePASRT_SP == getGameServiceResType() or __ePASRT_ES == getGameServiceResType() then
      url = "https://test.blackdesertonline.com/ingame/popup?lang=es"
    end
  elseif CppEnums.CountryType.NA_REAL == getGameServiceType() then
    if __ePASRT_EN == getGameServiceResType() then
      url = "https://www.blackdesertonline.com/ingame/popup?lang=en"
    elseif __ePASRT_DE == getGameServiceResType() then
      url = "https://www.blackdesertonline.com/ingame/popup?lang=de"
    elseif __ePASRT_FR == getGameServiceResType() then
      url = "https://www.blackdesertonline.com/ingame/popup?lang=fr"
    elseif __ePASRT_SP == getGameServiceResType() or __ePASRT_ES == getGameServiceResType() then
      url = "https://www.blackdesertonline.com/ingame/popup?lang=es"
    end
  elseif CppEnums.CountryType.JPN_ALPHA == getGameServiceType() then
    url = "http://game-portal-qa.jp.playblackdesert.com/Cashshop/Banner/BottomBanner"
  elseif CppEnums.CountryType.JPN_REAL == getGameServiceType() then
    url = "https://game-portal.jp.playblackdesert.com/CashShop/Banner/BottomBanner"
  end
  return url
end
function PaGlobal_Banner_Close()
  if false == Panel_Window_Banner:GetShow() then
    return
  end
  PaGlobal_Banner:updatePerSkipNextState()
end
function PaGlobal_Banner_GoToPearlShop()
  InGameShop_Open()
  InGameShop_TabEvent(1)
  InGameShop_Promotion_Close()
end
function PaGlobal_BottomBanner_CheckForDay()
  HandleEventMLUp_Banner_NotShowClose()
end
