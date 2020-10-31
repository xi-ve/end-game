registerEvent("FromClient_luaLoadComplete", "FromClient_GameOption_All_LuaLoadComplete")
registerEvent("EventGameOptionInitDisplayModeList", "FromClient_GameOption_All_InitializeScreenResolution")
registerEvent("onScreenResize", "FromClient_GameOption_All_OnScreenResize")
registerEvent("EventGameOptionToggle", "FromClient_GameOption_All_TogglePanel")
registerEvent("FromClient_ChangeScreenMode", "FromClient_GameOption_All_ChangeScreenMode")
registerEvent("EventGameOptionInitGameOption", "FromClient_GameOption_All_InitializeOption")
registerEvent("FromClient_RefreshGameOption", "FromClient_GameOption_All_RefreshGameOption")
registerEvent("FromClient_CanChangeOptionAfterSec", "FromClient_GameOption_All_CanChangeOptionAfterSec")
registerEvent("FromClient_RefreshMaidOptionInfo", "FromClient_GameOption_All_RefreshMaidOptionInfo")
registerEvent("FromClient_OtherPlayeUpdate", "FromClient_GameOption_All_OtherPlayerUpdate")
function FromClient_GameOption_All_LuaLoadComplete()
  PaGlobal_GameOption_All:Init()
  ToClient_initGameOption()
  if true == isNeedGameOptionFromServer() then
    keyCustom_StartEdit()
  end
  PaGlobal_GameOption_All_InitCheckUIScale()
end
function PaGlobal_GameOption_All_InitCheckUIScale()
  if false == ToClient_isGamePlayProcessor() then
    return
  end
  local option = PaGlobal_GameOption_All:getOptionFromName("UIScale")
  if nil == option then
    return
  end
  local isView = ToClient_getGameUIManagerWrapper():getLuaCacheDataListBool(__eUiInterfaceSizeMessagePanel)
  if true == isView then
    return
  end
  local currentValue = PaGlobal_GameOption_All:FromSliderValueToRealValue(option._initValue, option._sliderValueMin, option._sliderValueMax)
  currentValue = math.floor(currentValue + 0.5)
  if 100 ~= currentValue then
    return
  end
  local sizeY = 860
  if true == _ContentsGroup_NewUI_CharInfo_All then
    sizeY = Panel_CharacterInfo_All:GetSizeY()
  end
  if sizeY > getResolutionSizeY() then
    PaGlobal_GameOption_All:optimizationUIScale()
  end
end
function PaGlobal_GameOption_All:Init()
  self:InitUi()
  self:ListInit()
  self:SetSearchData()
end
function PaGlobal_GameOption_All:InitUi()
  PaGlobal_GameOption_All:controlInit()
  PaGlobal_GameOption_All:registEventHandler()
  PaGlobal_GameOption_All:setTooltipData()
  PaGlobal_GameOption_All:setHomeTooltipData()
  PaGlobal_GameOption_All:setDefaultValue()
  PaGlobal_GameOption_All:setContentsOption()
  self:movePage(self.PAGE.Main)
end
function PaGlobal_GameOption_All:controlInit()
  local titleArea = UI.getChildControl(Panel_Window_GameOption_All, "Static_TitleArea")
  self._ui.btn_question = UI.getChildControl(titleArea, "Button_Question")
  self._ui.btn_close = UI.getChildControl(titleArea, "Button_Close")
  self._ui.stc_topAreaBG = UI.getChildControl(Panel_Window_GameOption_All, "Static_TopAreaBG")
  self._ui.btn_home = UI.getChildControl(self._ui.stc_topAreaBG, "Button_Home")
  self._ui.btn_saveSetting = UI.getChildControl(self._ui.stc_topAreaBG, "Button_SaveSetting")
  self._ui.btn_resetAll = UI.getChildControl(self._ui.stc_topAreaBG, "Button_ResetAll")
  self._ui.edit_search = UI.getChildControl(self._ui.stc_topAreaBG, "Edit_Search")
  self._ui.btn_search = UI.getChildControl(self._ui.edit_search, "Static_SearchIcon")
  self._ui.txt_keyGuideX = UI.getChildControl(self._ui.edit_search, "StaticText_X_ConsoleUI")
  self._ui.stc_mainAreaBG = UI.getChildControl(Panel_Window_GameOption_All, "Static_MainAreaBG")
  self._ui.list2_category = UI.getChildControl(self._ui.stc_mainAreaBG, "List2_Category")
  self._ui.stc_verticalLine = UI.getChildControl(self._ui.stc_mainAreaBG, "Static_VerticalLine")
  self._ui.stc_rightBG = UI.getChildControl(self._ui.stc_mainAreaBG, "Static_RightBG")
  self._ui.stc_firstBG = UI.getChildControl(self._ui.stc_rightBG, "Static_FirstArea")
  self._ui.stc_secondBG = UI.getChildControl(self._ui.stc_rightBG, "Static_SecondArea")
  self._ui.stc_thirdBG = UI.getChildControl(self._ui.stc_rightBG, "Static_ThridArea")
  self._ui.list2_search = UI.getChildControl(self._ui.stc_mainAreaBG, "List2_Search")
  self._ui.txt_noResult = UI.getChildControl(self._ui.list2_search, "StaticText_SearchNoResult")
  self._ui._frame = UI.getChildControl(Panel_Window_GameOption_All, "Frame_Option")
  self._ui._frameContent = UI.getChildControl(self._ui._frame, "Frame_1_Content")
  self._ui._frameScroll = UI.getChildControl(self._ui._frame, "Frame_1_VerticalScroll")
  self._ui.stc_pictureTooltip = UI.getChildControl(Panel_Window_GameOption_All, "Static_PictureTooltip")
  self._ui.stc_bottomBg = UI.getChildControl(Panel_Window_GameOption_All, "Static_BottomDescBG")
  self._ui.stc_gameGrade = UI.getChildControl(self._ui.stc_bottomBg, "Static_Age")
  self._ui.txt_optionDesc = UI.getChildControl(self._ui.stc_bottomBg, "StaticText_Desc")
  self._ui.btn_copyright = UI.getChildControl(self._ui.stc_bottomBg, "Button_Copyright")
  self._ui.stc_bottomAreaBG = UI.getChildControl(Panel_Window_GameOption_All, "Static_BottomAreaBG")
  self._ui.btn_resetCache = UI.getChildControl(self._ui.stc_bottomAreaBG, "Button_ResetCache")
  self._ui.btn_saveCustom1 = UI.getChildControl(self._ui.stc_bottomAreaBG, "Button_Save1")
  self._ui.btn_saveCustom2 = UI.getChildControl(self._ui.stc_bottomAreaBG, "Button_Save2")
  self._ui.btn_apply = UI.getChildControl(self._ui.stc_bottomAreaBG, "Button_Apply")
  self._ui.btn_cancel = UI.getChildControl(self._ui.stc_bottomAreaBG, "Button_Cancel")
  self._ui.btn_confirm = UI.getChildControl(self._ui.stc_bottomAreaBG, "Button_Admin")
  self._ui.stc_keyGuideBG = UI.getChildControl(Panel_Window_GameOption_All, "Static_KeyGuide_ConsoleUI")
  self._ui.txt_keyGuideA = UI.getChildControl(self._ui.stc_keyGuideBG, "StaticText_A_ConsoleUI")
  self._ui.txt_keyGuideB = UI.getChildControl(self._ui.stc_keyGuideBG, "StaticText_B_ConsoleUI")
  self._ui.btn_spec = {}
  self._ui.btn_war = {}
  for specindex = 1, 4 do
    self._ui.btn_spec[specindex] = UI.getChildControl(self._ui.stc_firstBG, "Button_Spec" .. specindex)
    self._ui.btn_war[specindex] = UI.getChildControl(self._ui.stc_secondBG, "Button_War" .. specindex)
  end
  self._ui.btn_uiScale = UI.getChildControl(self._ui.stc_thirdBG, "Button_UIScale")
  self._ui.btn_loadCustom1 = UI.getChildControl(self._ui.stc_thirdBG, "Button_Load1")
  self._ui.btn_loadCustom2 = UI.getChildControl(self._ui.stc_thirdBG, "Button_Load2")
end
function PaGlobal_GameOption_All:registEventHandler()
  Panel_Window_GameOption_All:RegisterUpdateFunc("PaGlobal_GameOption_All_PerFrameFPSTextUpdate")
  self._ui.list2_search:registEvent(__ePAUIList2EventType_LuaChangeContent, "PaGlobal_GameOption_All_SearchListUpdate")
  self._ui.list2_search:createChildContent(__ePAUIList2ElementManagerType_List)
  self._ui.btn_question:addInputEvent("Mouse_LUp", "Panel_WebHelper_ShowToggle( \"UIGameOption\" )")
  PaGlobal_Util_RegistHelpTooltipEvent(self._ui.btn_question, "\"UIGameOption\"")
  self._ui.btn_close:addInputEvent("Mouse_LUp", "PaGlobal_GameOption_All:Close()")
  self._ui.btn_home:addInputEvent("Mouse_LUp", "PaGlobal_GameOption_All:ClickedHomeButton()")
  self._ui.btn_home:addInputEvent("Mouse_On", "PaGlobal_GameOption_All_ShowTooltip( true , " .. "\"" .. "Home" .. "\"" .. ")")
  self._ui.btn_home:addInputEvent("Mouse_Out", "PaGlobal_GameOption_All_ShowTooltip( false , " .. "\"" .. "Home" .. "\"" .. ")")
  self._ui.btn_saveSetting:addInputEvent("Mouse_LUp", "PaGlobal_Panel_SaveSetting_Show(false)")
  self._ui.btn_saveSetting:addInputEvent("Mouse_On", "PaGlobal_GameOption_All_ShowTooltip( true , " .. "\"" .. "SaveSetting" .. "\"" .. ")")
  self._ui.btn_saveSetting:addInputEvent("Mouse_Out", "PaGlobal_GameOption_All_ShowTooltip( false , " .. "\"" .. "SaveSetting" .. "\"" .. ")")
  self._ui.btn_resetAll:addInputEvent("Mouse_LUp", "PaGlobal_GameOption_All:ClickedResetAllOption()")
  self._ui.btn_resetAll:addInputEvent("Mouse_On", "PaGlobal_GameOption_All_ShowTooltip( true , " .. "\"" .. "ResetAll" .. "\"" .. ")")
  self._ui.btn_resetAll:addInputEvent("Mouse_Out", "PaGlobal_GameOption_All_ShowTooltip( false , " .. "\"" .. "ResetAll" .. "\"" .. ")")
  self._ui.btn_resetCache:addInputEvent("Mouse_LUp", "PaGlobal_GameOption_All:ClickedCacheDeleteOption()")
  self._ui.btn_resetCache:addInputEvent("Mouse_On", "PaGlobal_GameOption_All_ShowTooltip( true , " .. "\"" .. "CacheDelete" .. "\"" .. ")")
  self._ui.btn_resetCache:addInputEvent("Mouse_Out", "PaGlobal_GameOption_All_ShowTooltip( false , " .. "\"" .. "CacheDelete" .. "\"" .. ")")
  self._ui.edit_search:addInputEvent("Mouse_LUp", "PaGlobal_GameOption_All:ClickedSearchEditControl()")
  self._ui.btn_search:addInputEvent("Mouse_LUp", "PaGlobal_GameOption_All:ClickedSearchOption()")
  self._ui.btn_saveCustom1:addInputEvent("Mouse_LUp", "PaGlobal_GameOption_All:SaveCutsomOption(1)")
  self._ui.btn_saveCustom1:addInputEvent("Mouse_On", "PaGlobal_GameOption_All_ShowTooltip( true , " .. "\"" .. "CustomSave1" .. "\"" .. ")")
  self._ui.btn_saveCustom1:addInputEvent("Mouse_Out", "PaGlobal_GameOption_All_ShowTooltip( false , " .. "\"" .. "CustomSave1" .. "\"" .. ")")
  self._ui.btn_saveCustom2:addInputEvent("Mouse_LUp", "PaGlobal_GameOption_All:SaveCutsomOption(2)")
  self._ui.btn_saveCustom2:addInputEvent("Mouse_On", "PaGlobal_GameOption_All_ShowTooltip( true , " .. "\"" .. "CustomSave2" .. "\"" .. ")")
  self._ui.btn_saveCustom2:addInputEvent("Mouse_Out", "PaGlobal_GameOption_All_ShowTooltip( false , " .. "\"" .. "CustomSave2" .. "\"" .. ")")
  self._ui.btn_apply:addInputEvent("Mouse_LUp", "PaGlobal_GameOption_All:ClickedApplyOption()")
  self._ui.btn_apply:addInputEvent("Mouse_On", "PaGlobal_GameOption_All_ShowTooltip( true , " .. "\"" .. "Apply" .. "\"" .. ")")
  self._ui.btn_apply:addInputEvent("Mouse_Out", "PaGlobal_GameOption_All_ShowTooltip( false , " .. "\"" .. "Apply" .. "\"" .. ")")
  self._ui.btn_cancel:addInputEvent("Mouse_LUp", "PaGlobal_GameOption_All:ClickedCancelOption()")
  self._ui.btn_cancel:addInputEvent("Mouse_On", "PaGlobal_GameOption_All_ShowTooltip( true , " .. "\"" .. "Cancel" .. "\"" .. ")")
  self._ui.btn_cancel:addInputEvent("Mouse_Out", "PaGlobal_GameOption_All_ShowTooltip( false , " .. "\"" .. "Cancel" .. "\"" .. ")")
  self._ui.btn_confirm:addInputEvent("Mouse_LUp", "PaGlobal_GameOption_All:ClickedConfirmOption()")
  self._ui.btn_confirm:addInputEvent("Mouse_On", "PaGlobal_GameOption_All_ShowTooltip( true , " .. "\"" .. "Confirm" .. "\"" .. ")")
  self._ui.btn_confirm:addInputEvent("Mouse_Out", "PaGlobal_GameOption_All_ShowTooltip( false , " .. "\"" .. "Confirm" .. "\"" .. ")")
  self._ui.btn_copyright:addInputEvent("Mouse_LUp", "PaGlobal_Copyright_ShowWindow()")
  for specindex = 1, 4 do
    self._ui.btn_spec[specindex]:addInputEvent("Mouse_LUp", "PaGlobal_GameOption_All:ClickedSpecSetting(" .. specindex .. ")")
    self._ui.btn_spec[specindex]:addInputEvent("Mouse_On", "PaGlobal_GameOption_All_ShowHomeTooltip(true, " .. "\"" .. "Spec" .. specindex .. "\"" .. ")")
    self._ui.btn_spec[specindex]:addInputEvent("Mouse_Out", "PaGlobal_GameOption_All_ShowHomeTooltip(false, " .. "\"" .. "Spec" .. specindex .. "\"" .. ")")
    self._ui.btn_war[specindex]:addInputEvent("Mouse_LUp", "PaGlobal_GameOption_All:ClickedSpecSetting(" .. specindex + 4 .. ")")
    self._ui.btn_war[specindex]:addInputEvent("Mouse_On", "PaGlobal_GameOption_All_ShowHomeTooltip(true, " .. "\"" .. "War" .. specindex .. "\"" .. ")")
    self._ui.btn_war[specindex]:addInputEvent("Mouse_Out", "PaGlobal_GameOption_All_ShowHomeTooltip(false, " .. "\"" .. "War" .. specindex .. "\"" .. ")")
  end
  self._ui.btn_uiScale:addInputEvent("Mouse_LUp", "PaGlobal_GameOption_All:optimizationUIScale()")
  self._ui.btn_uiScale:addInputEvent("Mouse_On", "PaGlobal_GameOption_All_ShowHomeTooltip(true, " .. "\"" .. "UiScale" .. "\"" .. ")")
  self._ui.btn_uiScale:addInputEvent("Mouse_Out", "PaGlobal_GameOption_All_ShowHomeTooltip(false, " .. "\"" .. "UiScale" .. "\"" .. ")")
  self._ui.btn_loadCustom1:addInputEvent("Mouse_LUp", "PaGlobal_GameOption_All:LoadCutsomOption(1)")
  self._ui.btn_loadCustom1:addInputEvent("Mouse_On", "PaGlobal_GameOption_All_ShowHomeTooltip(true, " .. "\"" .. "CustomLoad1" .. "\"" .. ")")
  self._ui.btn_loadCustom1:addInputEvent("Mouse_Out", "PaGlobal_GameOption_All_ShowHomeTooltip(false, " .. "\"" .. "CustomLoad1" .. "\"" .. ")")
  self._ui.btn_loadCustom2:addInputEvent("Mouse_LUp", "PaGlobal_GameOption_All:LoadCutsomOption(2)")
  self._ui.btn_loadCustom2:addInputEvent("Mouse_On", "PaGlobal_GameOption_All_ShowHomeTooltip(true, " .. "\"" .. "CustomLoad2" .. "\"" .. ")")
  self._ui.btn_loadCustom2:addInputEvent("Mouse_Out", "PaGlobal_GameOption_All_ShowHomeTooltip(false, " .. "\"" .. "CustomLoad2" .. "\"" .. ")")
  if true == ToClient_isUsePadSnapping() then
    Panel_Window_GameOption_All:registerPadEvent(__eConsoleUIPadEvent_Up_X, "PaGlobal_GameOption_All_SetSearchFocus()")
  end
end
function PaGlobal_GameOption_All:setDefaultValue()
  if false == isNeedGameOptionFromServer() then
    self._ui.btn_question:SetShow(false)
  end
  if true == isGameTypeKorea() then
    self._ui.stc_gameGrade:SetShow(true)
    self._ui.txt_optionDesc:ComputePos()
  else
    self._ui.stc_gameGrade:SetShow(false)
    self._ui.txt_optionDesc:SetSpanSize(self._ui.stc_gameGrade:GetSpanSize().x, self._ui.txt_optionDesc:GetSpanSize().y)
  end
  if not isGameTypeGT() and not isGameTypeKR2() then
    self._ui.btn_copyright:SetShow(true)
  else
    self._ui.btn_copyright:SetShow(false)
  end
  if isGameTypeGT() then
    self._ui.btn_saveSetting:SetShow(false)
  end
  if true == isGameServiceTypeConsole() then
    PaGlobal_GameOption_All._elements.TextureQuality._defaultValue = 0
    PaGlobal_GameOption_All._elements.ConsolePadKeyType._defaultValue = 2
  end
  if true == isGameTypeKR2() then
    PaGlobal_GameOption_All._elements.WatermarkService._defaultValue = 6
  end
  if true == _ContentsGroup_isConsolePadControl then
    self._ui.btn_home:SetShow(false)
    self._ui.btn_resetAll:SetShow(false)
    self._ui.btn_resetCache:SetShow(false)
    self._ui.btn_saveSetting:SetShow(false)
    self._ui.edit_search:SetShow(false)
  end
  if true == ToClient_isUsePadSnapping() then
    self._ui.btn_question:SetShow(false)
    self._ui.btn_close:SetShow(false)
    self._ui.txt_keyGuideX:SetShow(true)
    self._ui.stc_keyGuideBG:SetShow(true)
    PaGlobal_GameOption_All:setAlignKeyGuide()
  end
end
function PaGlobal_GameOption_All:setAlignKeyGuide()
  local keyGuides = {
    self._ui.txt_keyGuideA,
    self._ui.txt_keyGuideB
  }
  PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyGuides, self._ui.stc_keyGuideBG, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP)
end
function PaGlobal_GameOption_All:setContentsOption()
  if true == _ContentsGroup_AntiAliasing then
    self._elements.AntiAliasing._radioButtonMapping[1]._string = "PANEL_NEWGAMEOPTION_GRAPHIC_QUALITY_AntiAliasing_1"
    self._elements.AntiAliasing._radioButtonMapping._count = 3
  else
    self._elements.AntiAliasing._radioButtonMapping[1]._string = "PANEL_OPTION_ANTIALIASING_APPLY"
    self._elements.AntiAliasing._radioButtonMapping._count = 2
  end
  if true == ToClinet_isGraphicUltraAvailable() then
    self._elements.GraphicOption._radioButtonMapping[7] = {}
    self._elements.GraphicOption._radioButtonMapping[8] = {}
    self._elements.GraphicOption._radioButtonMapping[7]._string = "PANEL_NEWGAMEOPTION_GRAPHIC_QUALITY_GraphicUltraLow"
    self._elements.GraphicOption._radioButtonMapping[8]._string = "PANEL_NEWGAMEOPTION_GRAPHIC_QUALITY_GraphicUltraHigh"
    self._elements.GraphicOption._radioButtonMapping._count = 9
  end
  if false == _ContentsGroup_ExpirienceWiki and false == _ContentsGroup_ExpirienceWiki_KorVersion then
    self._elements.UiExpirienceWiki._isShow = false
  end
  local availablefontSize = isGameServiceTypeDev() or isGameTypeTaiwan() or isGameTypeKorea() or isGameTypeJapan()
  if false == availablefontSize then
    self._elements.UIFontSizeType._isShow = false
  end
  local availableUIFontType = isGameServiceTypeDev() or isGameTypeKorea()
  if false == availableUIFontType then
    self._elements.UIFontType._isShow = false
  end
  local availableExchangeRefuse = true == isGameServiceTypeDev() or true == isUsePcExchangeInLocalizingValue()
  if false == availableExchangeRefuse then
    self._elements.IsExchangeRefuse._isShow = false
  end
  if true == ToClient_isAvailableChangeServiceType() then
    if isGameTypeThisCountry(CppEnums.ContryCode.eContryCode_NA) or true == isGameTypeSA() or true == isGameTypeTH() or true == isGameTypeID() or CppEnums.GameServiceType.eGameServiceType_DEV == getGameServiceType() then
      self._elements.UseChattingFilter._isShow = true
    else
      setUseChattingFilter(true)
      self._elements.UseChattingFilter._isShow = false
    end
  elseif nil ~= self._frames.Function.Nation then
    self._elements.ServiceResourceType._isShow = false
    self._elements.UseChattingFilter._isShow = false
    self._elements.ChatChannelType._isShow = false
    if true == isGameTypeTH() then
      self._elements.UseChattingFilter._isShow = true
    end
  end
  if true == isGameTypeThisCountry(CppEnums.ContryCode.eContryCode_NA) or true == isGameTypeSA() or true == isGameTypeRussia() then
    self._elements.AudioResourceType._isShow = false
  end
  local radioMapAudioResource = self.GetRadioButtonMap()
  self._elements.AudioResourceType._radioButtonMapping._count = #radioMapAudioResource + 1
  for index = 0, #radioMapAudioResource do
    local serviceType = self:radioButtonMapping_AudioResourceType(index)
    local text
    if CppEnums.ServiceResourceType.eServiceResourceType_KR == serviceType then
      text = "LUA_GAMEOPTION_KOREAN"
    elseif CppEnums.ServiceResourceType.eServiceResourceType_EN == serviceType then
      text = "LUA_GAMEOPTION_ENGLISH"
    elseif CppEnums.ServiceResourceType.eServiceResourceType_JP == serviceType then
      text = "LUA_GAMEOPTION_JAPANESE"
    elseif CppEnums.ServiceResourceType.eServiceResourceType_TW == serviceType then
      text = "LUA_GAMEOPTION_TAIWAN"
    end
    self._elements.AudioResourceType._radioButtonMapping[index]._gameString = text
  end
  local radioMapServiceType = self.GetServiceTypeRadioButtonMap()
  self._elements.ServiceResourceType._radioButtonMapping._count = #radioMapServiceType + 1
  for index = 0, #radioMapServiceType do
    local serviceType = self:radioButtonMapping_ServiceResourceType(index)
    self._elements.ServiceResourceType._radioButtonMapping[index]._fixedString = self._isOnServiceResourceTypeTag[serviceType]
  end
  local radioMapChannelChat = self.GetChannelChatRadioButtonMap()
  self._elements.ChatChannelType._radioButtonMapping._count = #radioMapChannelChat + 1
  for index = 0, #radioMapChannelChat do
    local serviceType = self:radioButtonMapping_ChatChannelType(index)
    self._elements.ChatChannelType._radioButtonMapping[index]._gameString = text
    self._elements.ChatChannelType._radioButtonMapping[index]._fixedString = self._isOnServiceChatTypeTag[serviceType]
  end
  if true == UI.checkResolution4KForXBox() then
    self._elements.UIScale._initValue = 2
    self._elements.UIScale._isShow = false
  end
  if false == isNeedGameOptionFromServer() then
    if true == isGameTypeKR2() then
      self._elements.WatermarkAlpha._isShow = false
      self._elements.WatermarkScale._isShow = false
      self._elements.WatermarkPosition._isShow = false
      self._elements.WatermarkService._isShow = false
    end
    return
  end
  if _ContentsGroup_isConsoleTest then
    self._elements.AlertNormalTrade._isShow = false
    self._elements.AlertRoyalTrade._isShow = false
    self._elements.AlertOtherPlayerGetItem._isShow = false
    self._elements.AlertLifeLevelUp._isShow = false
    self._elements.AlertEnchantSuccess._isShow = false
    self._elements.AlertEnchantFail._isShow = false
    self._elements.AlertItemMarket._isShow = false
    self._elements.AlertOtherMarket._isShow = false
    self._elements.ShowRightBottomAlarm._isShow = false
    self._elements.AlertChangeRegion._isShow = false
    self._elements.AlertFitnessLevelUp._isShow = false
    self._elements.AlertTerritoryWar._isShow = false
    self._elements.AlertGuildWar._isShow = false
    self._elements.ShowCashAlert._isShow = false
    self._elements.AlertGuildQuestMessage._isShow = false
    self._elements.AlertNearMonster._isShow = false
    self._elements.EnableWhisperMusic._isShow = false
    self._elements.EnableTraySoundOnOff._isShow = false
    self._elements.EnableAroundPlayMusic._isShow = false
    self._elements.AudioResourceType._isShow = false
    self._elements.EnableAudioFairy._isShow = false
    self._elements.VolumeOtherPlayer._isShow = false
    self._elements.VolumeFairy._isShow = false
    self._elements.KeyCustomMode._isShow = false
    self._elements.PadFunction1._isShow = false
    self._elements.PadFunction2._isShow = false
    self._elements.GamePadEnable._isShow = false
    self._elements.IsPvpRefuse._isShow = false
    self._elements.IsExchangeRefuse._isShow = false
  else
    self._elements.HDRDisplayGamma._isShow = false
    self._elements.HDRDisplayMaxNits._isShow = false
    self._elements.UltraHighDefinition._isShow = false
  end
  if true == isGameTypeKR2() then
    self._elements.BloodEffect._isShow = false
    self._elements.LensBlood._isShow = false
    self._elements.UiProductionNote._isShow = false
    self._elements.UiGuildServant._isShow = false
    self._elements.UiBlackGift._isShow = false
    self._elements.AlertRoyalTrade._isShow = false
    self._elements.AlertItemMarket._isShow = false
    self._elements.AlertTerritoryWar._isShow = false
    self._elements.WatermarkAlpha._isShow = false
    self._elements.WatermarkScale._isShow = false
    self._elements.WatermarkPosition._isShow = false
    self._elements.WatermarkService._isShow = false
    self._elements.AudioResourceType._isShow = false
    self._elements.TentRender._isShow = false
    if false == _ContentsOption_CH_OptionUseAlchemyStone then
      self._elements.UiAlchemyStone._isShow = false
    end
  end
end
function PaGlobal_GameOption_All:setTooltipData()
  self._tooltip.Home = {
    control = self._ui.btn_home,
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_NEWGAMEOPTION_TOOLTIPDESC_HOME")
  }
  self._tooltip.SaveSetting = {
    control = self._ui.btn_saveSetting,
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_NEWGAMEOPTION_TOOLTIPDESC_SAVEFILE")
  }
  self._tooltip.ResetAll = {
    control = self._ui.btn_resetAll,
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_NEWGAMEOPTION_TOOLTIPDESC_RESETALL")
  }
  self._tooltip.CacheDelete = {
    control = self._ui.btn_resetCache,
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_NEWGAMEOPTION_TOOLTIPDESC_CACHEDELETE")
  }
  self._tooltip.CustomSave1 = {
    control = self._ui.btn_saveCustom1,
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_NEWGAMEOPTION_TOOLTIPDESC_CUSTOMSAVE")
  }
  self._tooltip.CustomSave2 = {
    control = self._ui.btn_saveCustom2,
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_NEWGAMEOPTION_TOOLTIPDESC_CUSTOMSAVE")
  }
  self._tooltip.Apply = {
    control = self._ui.btn_apply,
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_NEWGAMEOPTION_TOOLTIPDESC_ADJUST")
  }
  self._tooltip.Cancel = {
    control = self._ui.btn_cancel,
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_NEWGAMEOPTION_TOOLTIPDESC_ADJUSTBACK")
  }
  self._tooltip.Confirm = {
    control = self._ui.btn_confirm,
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_NEWGAMEOPTION_TOOLTIPDESC_ADMIN")
  }
end
function PaGlobal_GameOption_All:setHomeTooltipData()
  self._homeTooltip.Spec1 = {
    control = self._ui.btn_spec[1],
    name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_NEWGAMEOPTION_LOWNORMALDESC")
  }
  self._homeTooltip.Spec2 = {
    control = self._ui.btn_spec[2],
    name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_NEWGAMEOPTION_MIDNORMALDESC")
  }
  self._homeTooltip.Spec3 = {
    control = self._ui.btn_spec[3],
    name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_NEWGAMEOPTION_HIGHNORMALDESC")
  }
  self._homeTooltip.Spec4 = {
    control = self._ui.btn_spec[4],
    name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_NEWGAMEOPTION_HIGHESTNORMALDESC")
  }
  self._homeTooltip.War1 = {
    control = self._ui.btn_war[1],
    name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_NEWGAMEOPTION_LOWSIEGEDESC")
  }
  self._homeTooltip.War2 = {
    control = self._ui.btn_war[2],
    name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_NEWGAMEOPTION_MIDSIEGEDESC")
  }
  self._homeTooltip.War3 = {
    control = self._ui.btn_war[3],
    name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_NEWGAMEOPTION_HIGHSIEGEDESC")
  }
  self._homeTooltip.War4 = {
    control = self._ui.btn_war[4],
    name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_NEWGAMEOPTION_HIGHESTSIEGEDESC")
  }
  self._homeTooltip.UiScale = {
    control = self._ui.btn_uiScale,
    name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_GAMEOPTION_UISIZE_DESC")
  }
  self._homeTooltip.CustomLoad1 = {
    control = self._ui.btn_loadCustom1,
    name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_NEWGAMEOPTION_CUSTOM_1_DESC")
  }
  self._homeTooltip.CustomLoad2 = {
    control = self._ui.btn_loadCustom2,
    name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_NEWGAMEOPTION_CUSTOM_2_DESC")
  }
end
function PaGlobal_GameOption_All:SetSearchData()
  for category, details in pairs(self._frames) do
    for detail, values in pairs(self._frames[category]) do
      for index, value in pairs(values) do
        if nil ~= value._element and (true == value._contentsOption or nil == value._contentsOption) then
          local option = value._element
          if nil == option._category then
            option._category = {}
          end
          local categories = option._category
          local order = #option._category + 1
          option._category[order] = {}
          option._category[order]._find = category
          option._category[order]._string = PAGetString(Defines.StringSheet_GAME, "LUA_NEWGAMEOPTION_" .. category)
          if nil == option._detail then
            option._detail = {}
          end
          option._detail[order] = {}
          option._detail[order]._find = detail
          option._detail[order]._string = PAGetString(Defines.StringSheet_GAME, "LUA_NEWGAMEOPTION_" .. category .. "_" .. detail)
        end
      end
    end
  end
end
function PaGlobal_GameOption_All:ListInit()
  local tree2 = self._ui.list2_category
  tree2:changeAnimationSpeed(11)
  tree2:registEvent(__ePAUIList2EventType_LuaChangeContent, "PaGlobal_GameOption_All_CategoryListTreeUpdate")
  tree2:createChildContent(__ePAUIList2ElementManagerType_Tree)
  tree2:getElementManager():clearKey()
  local _frameOrder = {}
  local _detailOrder = {}
  if true == isNeedGameOptionFromServer() then
    if _ContentsGroup_isConsoleTest then
      _frameOrder = self._frameOrder.inGame.consoleTest.main
      _detailOrder = self._frameOrder.inGame.consoleTest.sub
    elseif true == isGameTypeKR2() then
      _frameOrder = self._frameOrder.inGame.china.main
      _detailOrder = self._frameOrder.inGame.china.sub
    else
      _frameOrder = self._frameOrder.inGame.default.main
      _detailOrder = self._frameOrder.inGame.default.sub
    end
  elseif _ContentsGroup_isConsoleTest then
    _frameOrder = self._frameOrder.login.consoleTest.main
    _detailOrder = self._frameOrder.login.consoleTest.sub
  elseif true == isGameTypeKR2() then
    _frameOrder = self._frameOrder.login.china.main
    _detailOrder = self._frameOrder.login.china.sub
  else
    _frameOrder = self._frameOrder.login.default.main
    _detailOrder = self._frameOrder.login.default.sub
  end
  local mainElement = tree2:getElementManager():getMainElement()
  local keyIndex = 1
  for index, category in ipairs(_frameOrder) do
    if true == self:CheckAvailableCategory(category) then
      local category = _frameOrder[index]
      self._list2._tree2IndexMap[keyIndex] = {
        _isMain = true,
        _category = category,
        _string = PAGetString(Defines.StringSheet_GAME, "LUA_NEWGAMEOPTION_" .. category),
        _iconUV = self._categoryIconUV[category]
      }
      local treeElement = mainElement:createChild(toInt64(0, keyIndex))
      treeElement:setIsOpen(false)
      keyIndex = keyIndex + 1
      local count = 0
      for i, table in pairs(self._frames[category]) do
        count = count + 1
      end
      if 1 <= count then
        for index2, frame in pairs(_detailOrder[index]) do
          local detail = _detailOrder[index][index2]
          if true == self:CheckAvailableDetail(category, detail) then
            self._list2._tree2IndexMap[keyIndex] = {
              _isMain = false,
              _category = category,
              _detail = detail,
              _string = PAGetString(Defines.StringSheet_GAME, "LUA_NEWGAMEOPTION_" .. category .. "_" .. detail)
            }
            local subTreeElement = treeElement:createChild(toInt64(0, keyIndex))
            keyIndex = keyIndex + 1
          end
        end
      end
    end
  end
end
function PaGlobal_GameOption_All:CheckAvailableCategory(category)
  local count = 0
  for detailName, detail in pairs(PaGlobal_GameOption_All._frames[category]) do
    if self:CheckAvailableDetail(category, detailName) then
      count = count + 1
    end
  end
  return 0 < count
end
function PaGlobal_GameOption_All:CheckAvailableDetail(category, detail)
  local count = 0
  for index, option in ipairs(PaGlobal_GameOption_All._frames[category][detail]) do
    if true == option._contentsOption or nil == option._contentsOption then
      count = count + 1
    end
  end
  return 0 < count
end
function PaGlobal_GameOption_All_CategoryListTreeUpdate(contents, key)
  local idx = Int64toInt32(key)
  local indexMap = PaGlobal_GameOption_All._list2._tree2IndexMap[idx]
  local categoryButton = UI.getChildControl(contents, "RadioButton_MenuName")
  local categorySubButton = UI.getChildControl(contents, "RadioButton_SubMenuName")
  local categoryIcon = UI.getChildControl(contents, "Static_Icon")
  categoryButton:SetShow(false)
  categoryButton:setNotImpactScrollEvent(true)
  categorySubButton:SetShow(false)
  categorySubButton:setNotImpactScrollEvent(true)
  if indexMap._isMain then
    categoryButton:SetShow(true)
    categoryButton:SetText(indexMap._string)
    categoryButton:addInputEvent("Mouse_LUp", "PaGlobal_GameOption_All:ClickedMainCategory(" .. idx .. ", " .. " \"" .. indexMap._category .. "\"" .. ")")
    categoryButton:SetCheck(PaGlobal_GameOption_All._list2._selectedKey == idx)
    categoryIcon:SetShow(true)
    categoryIcon:ChangeTextureInfoNameDefault("combine/etc/combine_etc_setting.dds")
    local x1, y1, x2, y2 = setTextureUV_Func(categoryIcon, indexMap._iconUV.x1, indexMap._iconUV.y1, indexMap._iconUV.x2, indexMap._iconUV.y2)
    categoryIcon:getBaseTexture():setUV(x1, y1, x2, y2)
    categoryIcon:setRenderTexture(categoryIcon:getBaseTexture())
  else
    categorySubButton:SetShow(true)
    categorySubButton:SetText(indexMap._string)
    categorySubButton:addInputEvent("Mouse_LUp", "PaGlobal_GameOption_All:ClickedSubCategory(" .. idx .. ", " .. "\"" .. indexMap._category .. "\"" .. ", " .. "\"" .. indexMap._detail .. "\"" .. ")")
    categorySubButton:SetCheck(PaGlobal_GameOption_All._list2._selectedSubKey == idx)
    categoryIcon:SetShow(false)
  end
end
function PaGlobal_GameOption_All_SearchListUpdate(content, key)
  local id = Int64toInt32(key)
  local content = UI.getChildControl(content, "StaticText_SearchElement")
  local findString = PaGlobal_GameOption_All._findStrings[id]
  content:SetShow(true)
  content:SetText(findString._category._string .. " > " .. findString._detail._string .. " > <PAColor0xfff5ba3a>" .. findString._elementString .. "<PAOldColor>")
  content:addInputEvent("Mouse_LUp", "PaGlobal_GameOption_All:ClickedFindElement(" .. "\"" .. findString._category._find .. "\"" .. ", " .. "\"" .. findString._detail._find .. "\"" .. " , \"" .. findString._elementName .. "\")")
end
runLua("UI_Data/Script/Window/Option/NewUI/Panel_Window_GameOption_Initialize_All_1.lua")
