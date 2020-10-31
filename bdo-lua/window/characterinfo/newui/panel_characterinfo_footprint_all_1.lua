function PaGlobal_CharInfoFootPrint_All:initialize()
  if true == self._initialize then
    return
  end
  local stc_TabBg = UI.getChildControl(Panel_CharacterInfoFootPrint_All, "Static_Category_Tap_ConsoleUI")
  self._ui.stc_KeyGuide_LT = UI.getChildControl(stc_TabBg, "Static_LT_ConsoleUI")
  self._ui.stc_KeyGuide_RT = UI.getChildControl(stc_TabBg, "Static_RT_ConsoleUI")
  self._ui.rdo_1day = UI.getChildControl(stc_TabBg, "RadioButton_1Day")
  self._ui.rdo_7day = UI.getChildControl(stc_TabBg, "RadioButton_7Day")
  self._ui.rdo_30day = UI.getChildControl(stc_TabBg, "RadioButton_30Day")
  self._ui.rdo_Allday = UI.getChildControl(stc_TabBg, "RadioButton_AllDay")
  self._ui.stc_selectLine = UI.getChildControl(stc_TabBg, "Static_SelectLine")
  local stc_NoticeBg = UI.getChildControl(Panel_CharacterInfoFootPrint_All, "Static_NoticeBG")
  self._ui.txt_PlayTime = UI.getChildControl(stc_NoticeBg, "StaticText_PlayTime")
  self._ui.txt_PlayTime:SetShow(false)
  self._ui.stc_PlayTiemIcon = UI.getChildControl(stc_NoticeBg, "CheckButton_PlayTime")
  self._playTimeString = ""
  local stc_BotKeyGuideBg = UI.getChildControl(Panel_CharacterInfoFootPrint_All, "Static_KeyGuide_ConsoleUI")
  self._ui.stc_KeyGuide_B = UI.getChildControl(stc_BotKeyGuideBg, "StaticText_BButton")
  local stc_MainBg = UI.getChildControl(Panel_CharacterInfoFootPrint_All, "Static_MainBG")
  local stc_boxUI = {
    [0] = "Static_Box_Monster",
    [1] = "Static_Box_Fishing",
    [2] = "Static_Box_Geather",
    [3] = "Static_Box_Weight"
  }
  for idx = 0, 3 do
    local boxUI = {
      txt_Time = nil,
      txt_Title = nil,
      txt_Value = nil,
      txt_Desc = nil
    }
    local parentUI = UI.getChildControl(stc_MainBg, stc_boxUI[idx])
    boxUI.txt_Time = UI.getChildControl(parentUI, "StaticText_Period_1")
    boxUI.txt_Title = UI.getChildControl(parentUI, "StaticText_BoxTitle")
    boxUI.txt_Value = UI.getChildControl(parentUI, "StaticText_Value")
    boxUI.txt_Desc = UI.getChildControl(parentUI, "StaticText_Desc")
    boxUI.txt_Time:SetTextMode(__eTextMode_AutoWrap)
    boxUI.txt_Title:SetTextMode(__eTextMode_AutoWrap)
    boxUI.txt_Value:SetTextMode(__eTextMode_AutoWrap)
    boxUI.txt_Desc:SetTextMode(__eTextMode_AutoWrap)
    boxUI.txt_Title:SetText(boxUI.txt_Title:GetText())
    boxUI.txt_Value:SetText(boxUI.txt_Value:GetText())
    boxUI.txt_Desc:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_ACHIVEMENT_DESC_" .. tostring(idx + 1)))
    function boxUI:isValidate()
      boxUI.txt_Time:isValidate()
      boxUI.txt_Title:isValidate()
      boxUI.txt_Value:isValidate()
      boxUI.txt_Desc:isValidate()
    end
    self._ui.stc_Box[idx] = boxUI
  end
  self._ui.btn_RadioTable[0] = self._ui.rdo_1day
  self._ui.btn_RadioTable[1] = self._ui.rdo_7day
  self._ui.btn_RadioTable[2] = self._ui.rdo_30day
  self._ui.btn_RadioTable[3] = self._ui.rdo_Allday
  self._isConsole = _ContentsGroup_UsePadSnapping
  self._ui.stc_KeyGuide_LT:SetShow(self._isConsole)
  self._ui.stc_KeyGuide_RT:SetShow(self._isConsole)
  self._ui.stc_KeyGuide_B:SetShow(self._isConsole)
  self._selfPlayer = getSelfPlayer()
  UI.ASSERT_NAME(nil ~= self._selfPlayer, " Panel_CharacterInfo_FootPrint_All_1.lua / getSelfPlayer() is nil", "\234\185\128\234\183\188\236\154\176")
  if nil == self._selfPlayer then
    return
  end
  PaGlobal_CharInfoFootPrint_All:validate()
  PaGlobal_CharInfoFootPrint_All:registEventHandler(self._isConsole)
  PaGlobal_CharInfoFootPrint_All._initialize = true
end
function PaGlobal_CharInfoFootPrint_All:registEventHandler(console)
  registerEvent("Profile_Updatelist", "PaGlobalFunc_CharInfoFootPrint_All_Update")
  if true == console then
  else
    for idx = 0, 3 do
      self._ui.btn_RadioTable[idx]:addInputEvent("Mouse_LUp", "HandleEventLUp_CharInfoFootPrint_RadioButton(" .. idx .. ")")
    end
    self._ui.stc_PlayTiemIcon:addInputEvent("Mouse_On", "HandleEventOnOut_CharInfoFootPrint_ShowPlayTime(true)")
    self._ui.stc_PlayTiemIcon:addInputEvent("Mouse_Out", "HandleEventOnOut_CharInfoFootPrint_ShowPlayTime(false)")
  end
end
function PaGlobal_CharInfoFootPrint_All:dataClear()
  self._currentTabIdx = 0
  for idx = 0, 3 do
    self._ui.btn_RadioTable[idx]:SetCheck(idx == self._currentTabIdx)
  end
end
function PaGlobal_CharInfoFootPrint_All:update()
  if false == PaGlobalFunc_ChracterInfo_All_GetBgShow(PaGlobal_CharInfo_All._TABINDEX._footPrint) then
    return
  end
  self._playTimeString = ""
  for idx = 0, 3 do
    local countProfileInfo = ToClient_GetProfileInfo(self._eDATE[self._currentTabIdx], idx)
    if countProfileInfo == -1 then
      return
    end
    local countText = ""
    local time = 0
    if CppEnums.ProfileIndex.eUserProfileValueType_MonsterKillCount == idx then
      countText = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_ACHIVEMENT_MONSTERCOUNT", "count", makeDotMoney(countProfileInfo))
    elseif CppEnums.ProfileIndex.eUserProfileValueType_FishingSuccessCount == idx then
      countText = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_ACHIVEMENT_ITEMCOUNT", "count", makeDotMoney(countProfileInfo))
    elseif CppEnums.ProfileIndex.eUserProfileValueType_ItemGainCount == idx then
      countText = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_ACHIVEMENT_ITEMCOUNT", "count", makeDotMoney(countProfileInfo))
    elseif CppEnums.ProfileIndex.eUserProfileValueType_ProductSuccessCount == idx then
      local weight = Int64toInt32(countProfileInfo / Defines.s64_const.s64_100) / 100
      countText = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_ACHIVEMENT_WEIGHT", "count", string.format("%.2f", weight))
    else
      countText = makeDotMoney(countProfileInfo)
    end
    self._ui.stc_Box[idx].txt_Value:SetText(countText)
    self._ui.stc_Box[idx].txt_Time:SetText(self._string_DATE[self._currentTabIdx])
  end
  local temporaryPCRoomWrapper = getTemporaryInformationWrapper()
  local isPremiumPcRoom = temporaryPCRoomWrapper:isPremiumPcRoom()
  local userPlayTime = Util.Time.timeFormatting(Int64toInt32(ToClient_GetUserPlayTimePerDay()))
  local totalPlayTime = Util.Time.timeFormatting_Minute(Int64toInt32(ToClient_GetCharacterPlayTime()))
  local playTimeText = PAGetString(Defines.StringSheet_GAME, "LUA_ACHIVEMENT_TODAYPLAYTIME") .. "<PAColor0xFFFFC730>" .. tostring(userPlayTime) .. "<PAOldColor> | " .. PAGetString(Defines.StringSheet_GAME, "LUA_CONTRACT_TIME_BLACKSPIRIT") .. "<PAColor0xFFFFC730> " .. totalPlayTime .. "<PAOldColor> "
  if true == isPremiumPcRoom and (isGameTypeKorea() or isGameTypeJapan()) then
    local pcPlayTime = PAGetString(Defines.StringSheet_GAME, "LUA_ACHIVEMENT_PCROOMPLAYTIME") .. PAGetStringParam1(Defines.StringSheet_GAME, "LUA_SELFCHARACTERINFO_PCROOMTIME", "getPcRoomPlayTime", convertStringFromDatetime(ToClient_GetPcRoomPlayTime()))
    playTimeText = playTimeText .. pcPlayTime
  end
  self._playTimeString = playTimeText
end
function PaGlobal_CharInfoFootPrint_All:validate()
  self._ui.stc_KeyGuide_LT:isValidate()
  self._ui.stc_KeyGuide_RT:isValidate()
  self._ui.rdo_1day:isValidate()
  self._ui.rdo_7day:isValidate()
  self._ui.rdo_30day:isValidate()
  self._ui.rdo_Allday:isValidate()
  self._ui.stc_selectLine:isValidate()
  self._ui.txt_PlayTime:isValidate()
  self._ui.stc_PlayTiemIcon:isValidate()
  self._ui.stc_KeyGuide_B:isValidate()
  for idx = 0, 3 do
    self._ui.stc_Box[idx]:isValidate()
  end
end
