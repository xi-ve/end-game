function PaGlobal_CharInfo_All:initialize()
  if true == self._initialize then
    return
  end
  self._ui.stc_TitleBg = UI.getChildControl(Panel_CharacterInfo_All, "StaticText_Title")
  self._ui.txt_Title = UI.getChildControl(self._ui.stc_TitleBg, "StaticText_TitleIcon")
  self._ui.btn_Close = UI.getChildControl(self._ui.stc_TitleBg, "Button_Close")
  self._ui.btn_Question = UI.getChildControl(self._ui.stc_TitleBg, "Button_Question")
  self._ui.btn_StickerUI = UI.getChildControl(self._ui.stc_TitleBg, "CheckButton_PopUp")
  self._ui.stc_TabBg = UI.getChildControl(Panel_CharacterInfo_All, "Static_TapBg")
  self._ui.rdo_BasicInfo = UI.getChildControl(self._ui.stc_TabBg, "RadioButton_Tab_Basic")
  self._ui.rdo_FamSkill = UI.getChildControl(self._ui.stc_TabBg, "RadioButton_FamilyStat")
  self._ui.rdo_Title = UI.getChildControl(self._ui.stc_TabBg, "RadioButton_Tab_Title")
  self._ui.rdo_History = UI.getChildControl(self._ui.stc_TabBg, "RadioButton_Tab_History")
  self._ui.rdo_Challenge = UI.getChildControl(self._ui.stc_TabBg, "RadioButton_Tab_Challenge")
  self._ui.rdo_footPrint = UI.getChildControl(self._ui.stc_TabBg, "RadioButton_Tab_Profile")
  self._ui.rdo_Life = UI.getChildControl(self._ui.stc_TabBg, "RadioButton_Tab_Life")
  self._ui.rdo_CashBuff = UI.getChildControl(self._ui.stc_TabBg, "RadioButton_Tab_CashBuff")
  self._ui.stc_KeyGuide_LB = UI.getChildControl(self._ui.stc_TabBg, "Static_LB_Console")
  self._ui.stc_KeyGuide_RB = UI.getChildControl(self._ui.stc_TabBg, "Static_RB_Console")
  self._ui.btn_Resize = UI.getChildControl(Panel_CharacterInfo_All, "Button_Resize_PCUI")
  self._ui.stc_BasicBg = UI.getChildControl(Panel_CharacterInfo_All, "Static_BasicBg")
  self._ui.stc_FamliyBg = UI.getChildControl(Panel_CharacterInfo_All, "Static_FamilyStatBg")
  self._ui.stc_TitleBg = UI.getChildControl(Panel_CharacterInfo_All, "Static_TitleBg")
  self._ui.stc_HistoryBg = UI.getChildControl(Panel_CharacterInfo_All, "Static_History")
  self._ui.stc_ChallengeBg = UI.getChildControl(Panel_CharacterInfo_All, "Static_ChallengeBg")
  self._ui.stc_FootPrintBg = UI.getChildControl(Panel_CharacterInfo_All, "Static_ProfileBg")
  self._ui.stc_LifeBg = UI.getChildControl(Panel_CharacterInfo_All, "Static_LifeBg")
  self._ui.stc_CashBuffBg = UI.getChildControl(Panel_CharacterInfo_All, "Static_CashBuffBg")
  self._ui.stc_selectLine = UI.getChildControl(self._ui.stc_TabBg, "Static_SelectLine")
  self._ui.stc_tooltip = UI.getChildControl(Panel_CharacterInfo_All, "Static_Common_Popup")
  self._ui.txt_tooltip = UI.getChildControl(self._ui.stc_tooltip, "StaticText_DescBox")
  self._ui.txt_tooltip:SetTextMode(__eTextMode_AutoWrap)
  self._ui.stc_SimpleTooltipBg = UI.getChildControl(Panel_CharacterInfo_All, "Static_TooltipBG")
  self._ui.txt_SimpleTooltipTitle = UI.getChildControl(self._ui.stc_SimpleTooltipBg, "StaticText_TooltipTitle")
  self._ui.txt_SimpleTooltipDesc = UI.getChildControl(self._ui.stc_SimpleTooltipBg, "StaticText_TooltipDesc")
  self._ui.txt_SimpleTooltipTitle:SetTextMode(__eTextMode_AutoWrap)
  self._ui.txt_SimpleTooltipTitle:SetText(self._ui.txt_SimpleTooltipTitle:GetText())
  self._ui.txt_SimpleTooltipDesc:SetTextMode(__eTextMode_AutoWrap)
  self._ui.txt_SimpleTooltipDesc:SetText(self._ui.txt_SimpleTooltipDesc:GetText())
  self._isConsole = _ContentsGroup_UsePadSnapping
  self._ui.rdo_tabTable[self._TABINDEX._basic] = self._ui.rdo_BasicInfo
  self._ui.rdo_tabTable[self._TABINDEX._title] = self._ui.rdo_Title
  self._ui.rdo_tabTable[self._TABINDEX._history] = self._ui.rdo_History
  self._ui.rdo_tabTable[self._TABINDEX._challenge] = self._ui.rdo_Challenge
  self._ui.rdo_tabTable[self._TABINDEX._footPrint] = self._ui.rdo_footPrint
  self._ui.rdo_tabTable[self._TABINDEX._life] = self._ui.rdo_Life
  self._ui.rdo_tabTable[self._TABINDEX._familySkill] = self._ui.rdo_FamSkill
  self._ui.rdo_tabTable[self._TABINDEX._cashBuff] = self._ui.rdo_CashBuff
  self._oriTabSize = self._ui.rdo_BasicInfo:GetSizeX()
  PaGlobal_CharInfo_All:validate()
  PaGlobal_CharInfo_All:switchPlatForm(self._isConsole)
  PaGlobal_CharInfo_All:registEventHandler(self._isConsole)
  Panel_CharacterInfo_All:setDynamicScalePanelIndex(__eDynamicScalePanel_CharacterInfo)
end
function PaGlobal_CharInfo_All:validate()
  self._ui.stc_TitleBg:isValidate()
  self._ui.txt_Title:isValidate()
  self._ui.btn_Close:isValidate()
  self._ui.btn_Question:isValidate()
  self._ui.btn_StickerUI:isValidate()
  self._ui.stc_TabBg:isValidate()
  self._ui.rdo_BasicInfo:isValidate()
  self._ui.rdo_FamSkill:isValidate()
  self._ui.rdo_Title:isValidate()
  self._ui.rdo_History:isValidate()
  self._ui.rdo_Challenge:isValidate()
  self._ui.rdo_footPrint:isValidate()
  self._ui.rdo_Life:isValidate()
  self._ui.rdo_CashBuff:isValidate()
  self._ui.stc_KeyGuide_LB:isValidate()
  self._ui.stc_KeyGuide_RB:isValidate()
  self._ui.btn_Resize:isValidate()
  self._ui.stc_BasicBg:isValidate()
  self._ui.stc_FamliyBg:isValidate()
  self._ui.stc_TitleBg:isValidate()
  self._ui.stc_HistoryBg:isValidate()
  self._ui.stc_ChallengeBg:isValidate()
  self._ui.stc_FootPrintBg:isValidate()
  self._ui.stc_LifeBg:isValidate()
  self._ui.stc_CashBuffBg:isValidate()
  self._ui.stc_tooltip:isValidate()
  self._ui.txt_tooltip:isValidate()
  self._ui.stc_SimpleTooltipBg:isValidate()
  self._ui.txt_SimpleTooltipTitle:isValidate()
  self._ui.txt_SimpleTooltipDesc:isValidate()
  self._ui.stc_selectLine:isValidate()
end
function PaGlobal_CharInfo_All:switchPlatForm(console)
  self._ui.stc_KeyGuide_RB:SetShow(console)
  self._ui.stc_KeyGuide_LB:SetShow(console)
  self._ui.rdo_CashBuff:SetShow(isGameServiceTypeConsole())
  self._ui.btn_Resize:SetShow(not console)
  self._ui.btn_Close:SetShow(not console)
  self._ui.btn_StickerUI:SetShow(_ContentsGroup_PopUp)
  self._ui.btn_Question:SetShow(not console)
  self._ui.btn_Resize:SetShow(not console)
  self._ui.rdo_History:SetShow(not isGameServiceTypeConsole())
  local footPrintOption = ToClient_IsContentsGroupOpen("271")
  self._ui.rdo_footPrint:SetShow(footPrintOption)
  self._ui.rdo_FamSkill:SetShow(true == _ContentsGroup_FamilySkill)
  self._ui.rdo_Life:SetShow(true == _ContentsGroup_EnhanceCollect)
  if true == console then
    Panel_CharacterInfo_All:SetHorizonCenter()
    Panel_CharacterInfo_All:SetSpanSize(0, 0)
    Panel_CharacterInfo_All:ComputePos()
  else
  end
  local uiCount = 0
  for idx = 0, self._TABINDEX._totalCount - 1 do
    if true == self._ui.rdo_tabTable[idx]:GetShow() then
      uiCount = uiCount + 1
      if true == self._isConsole then
        self._ui.rdo_tabTable[idx]:SetText("")
      end
    end
  end
  local uiCount = 0
  local buttonGap = 75
  local btnTable = {}
  local btnSize = self._oriTabSize
  for idx = 0, self._TABINDEX._totalCount - 1 do
    if true == self._ui.rdo_tabTable[idx]:GetShow() then
      btnTable[uiCount] = self._ui.rdo_tabTable[idx]
      self._consoleBtnTable[uiCount] = idx
      uiCount = uiCount + 1
    end
  end
  buttonGap = buttonGap - uiCount * 5
  local startPosX = (Panel_CharacterInfo_All:GetSizeX() - (btnSize * uiCount + buttonGap * (uiCount - 1))) / 2
  local posX = 0
  for index = 0, uiCount - 1 do
    posX = startPosX + (btnSize + buttonGap) * index
    btnTable[index]:SetSpanSize(posX, btnTable[index]:GetSpanSize().y)
    local textX = btnTable[index]:GetSizeX()
    if btnTable[index]:GetSizeX() < btnTable[index]:GetTextSizeX() then
      textX = btnTable[index]:GetSizeX() + (btnTable[index]:GetTextSizeX() - btnTable[index]:GetSizeX())
    end
    btnTable[index]:SetEnableArea(0, 0, textX, btnTable[index]:GetSizeY() + -btnTable[index]:GetTextSpan().y)
  end
  if true == self._ui.stc_KeyGuide_RB:GetShow() then
    self._ui.stc_KeyGuide_LB:SetSpanSize(startPosX - (self._ui.rdo_Life:GetSizeX() + self._ui.stc_KeyGuide_LB:GetSizeX() + 10), self._ui.stc_KeyGuide_LB:GetSpanSize().y)
    self._ui.stc_KeyGuide_RB:SetSpanSize(posX + btnSize + self._ui.stc_KeyGuide_RB:GetSizeX(), self._ui.stc_KeyGuide_RB:GetSpanSize().y)
  end
end
function PaGlobal_CharInfo_All:registEventHandler(console)
  registerEvent("onScreenResize", "PaGlobalFunc_ChracterInfo_All_OnScreenResize")
  if true == console then
    Panel_CharacterInfo_All:registerPadEvent(__eConsoleUIPadEvent_Up_LB, "HandleEventPadPress_CharacterInfo_All_ClickOtherTab_Console(false)")
    Panel_CharacterInfo_All:registerPadEvent(__eConsoleUIPadEvent_Up_RB, "HandleEventPadPress_CharacterInfo_All_ClickOtherTab_Console(true)")
  else
    self._ui.btn_Close:addInputEvent("Mouse_LUp", "HandleEventLUp_ChracterInfo_All_Close()")
    self._ui.btn_Question:addInputEvent("Mouse_LUp", "Panel_WebHelper_ShowToggle( \"SelfCharacterInfo\" )")
    PaGlobal_Util_RegistHelpTooltipEvent(self._ui.btn_Question, "\"SelfCharacterInfo\"")
    self._ui.btn_StickerUI:addInputEvent("Mouse_LUp", "HandleEventLUp_ChracterInfo_All_PopUpUI()")
    self._ui.btn_StickerUI:addInputEvent("Mouse_On", "HandleEventOnOut_ChracterInfo_All_PopUpUI_Tooltip(true)")
    self._ui.btn_StickerUI:addInputEvent("Mouse_Out", "HandleEventOnOut_ChracterInfo_All_PopUpUI_Tooltip(false)")
    self._ui.btn_Resize:addInputEvent("Mouse_LDown", "HandleEventLUp_ChracterInfo_All_ScaleResizeLDown()")
    self._ui.btn_Resize:addInputEvent("Mouse_LPress", "HandleEventLUp_ChracterInfo_All_ScaleResizeLPress()")
    self._ui.btn_Resize:addInputEvent("Mouse_LUp", "HandleEventLUp_ChracterInfo_All_ScaleResizeLUp()")
    Panel_CharacterInfo_All:SetDragEnable(true)
  end
end
function PaGlobal_CharInfo_All:prepareOpen()
  if false == self._initialize then
    local function setTabData(index, btn, panel, bg, updateFunc)
      if false == btn:GetShow() then
        return
      end
      UI.ASSERT_NAME(nil ~= index, "ChracterInfo_All_1.lua / index is nil", "\234\185\128\234\183\188\236\154\176")
      UI.ASSERT_NAME(nil ~= btn, "ChracterInfo_All_1.lua / btn is nil", "\234\185\128\234\183\188\236\154\176")
      UI.ASSERT_NAME(nil ~= panel, "ChracterInfo_All_1.lua / panel is nil", "\234\185\128\234\183\188\236\154\176")
      UI.ASSERT_NAME(nil ~= bg, "ChracterInfo_All_1.lua / bg is nil", "\234\185\128\234\183\188\236\154\176")
      UI.ASSERT_NAME(nil ~= self._tabData, "ChracterInfo_All_1.lua / table is nil", "\234\185\128\234\183\188\236\154\176")
      UI.ASSERT_NAME(nil ~= updateFunc, "ChracterInfo_All_1.lua / updateFunc is nil", "\234\185\128\234\183\188\236\154\176")
      if nil == index or nil == btn or nil == panel or nil == bg then
        return
      end
      local data = {
        btn = nil,
        panel = nil,
        bg = nil,
        updateFunc = nil
      }
      data.btn = btn
      data.panel = panel
      data.bg = bg
      data.updateFunc = updateFunc
      data.bg:MoveChilds(data.bg:GetID(), data.panel)
      deletePanel(data.panel:GetID())
      data.bg:ComputePos()
      data.btn:addInputEvent("Mouse_LUp", "HandleEventLUp_ChracterInfo_All_ClickOtherTab(" .. index .. ")")
      if false == self._isConsole then
        data.btn:addInputEvent("Mouse_On", "HandleEventOnOut_ChracterInfo_All_TabBtn_Tooltip(" .. index .. ")")
        data.btn:addInputEvent("Mouse_Out", "HandleEventOnOut_ChracterInfo_All_TabBtn_Tooltip()")
      end
      self._tabData[index] = data
    end
    setTabData(self._TABINDEX._basic, self._ui.rdo_BasicInfo, Panel_CharacterInfoBasic_All, self._ui.stc_BasicBg, PaGlobalFunc_CharInfoBasic_All_Update)
    if true == _ContentsGroup_EnhanceCollect then
      setTabData(self._TABINDEX._life, self._ui.rdo_Life, Panel_CharacterInfoLife_All, self._ui.stc_LifeBg, PaGlobalFunc_CharInfoLife_All_Update)
    end
    setTabData(self._TABINDEX._title, self._ui.rdo_Title, Panel_CharacterInfoTitle_All, self._ui.stc_TitleBg, PaGlobalFunc_CharInfoTitle_All_Update)
    setTabData(self._TABINDEX._history, self._ui.rdo_History, Panel_CharacterInfoHistory_All, self._ui.stc_HistoryBg, PaGlobalFunc_CharInfoHistory_All_Update)
    setTabData(self._TABINDEX._footPrint, self._ui.rdo_footPrint, Panel_CharacterInfoFootPrint_All, self._ui.stc_FootPrintBg, PaGlobalFunc_CharInfoFootPrint_All_Update)
    setTabData(self._TABINDEX._challenge, self._ui.rdo_Challenge, Panel_CharacterInfoChallenge_All, self._ui.stc_ChallengeBg, PaGlobalFunc_CharInfoChallenge_All_Update)
    setTabData(self._TABINDEX._cashBuff, self._ui.rdo_CashBuff, Panel_CharacterInfoCashBuff_All, self._ui.stc_CashBuffBg, PaGlobal_CharInfoCashBuff_All_Update)
    if true == _ContentsGroup_FamilySkill then
      setTabData(self._TABINDEX._familySkill, self._ui.rdo_FamSkill, Panel_CharacterInfoFamilySkill_All, self._ui.stc_FamliyBg, PaGlobalFunc_CharInfoFamilySkill_All_Update)
    end
    self._initialize = true
  end
  PaGlobal_CharInfo_All:dataClear()
  PaGlobal_CharInfo_All:open()
  PaGlobal_CharInfo_All:otherTabOpen(0)
  if Panel_CharacterInfo_All:GetScale().x < 1 or 1 > Panel_CharacterInfo_All:GetScale().y then
    HandleEventLUp_ChracterInfo_All_ScaleResizeLDown()
    HandleEventLUp_ChracterInfo_All_ScaleResizeLPress()
    HandleEventLUp_ChracterInfo_All_ScaleResizeLUp()
  end
end
function PaGlobal_CharInfo_All:otherTabOpen(idx)
  UI.ASSERT_NAME(nil ~= self._tabData[idx], "Panel_CharacterInfo_All_1.lua / self._tabData[idx] is nil ", "\234\185\128\234\183\188\236\154\176")
  PaGlobal_CharInfoBasic_All:setMenuPosition()
  if nil ~= self._currentTabIdx then
    self._tabData[self._currentTabIdx].btn:SetCheck(false)
    self._tabData[self._currentTabIdx].bg:SetShow(false)
  end
  self._currentTabIdx = idx
  local updateFunc = self._tabData[idx].updateFunc
  UI.ASSERT_NAME(nil ~= self._tabData[idx].updateFunc, "Panel_CharacterInfo_All_1.lua / idx =" .. tostring(idx) .. "\tupdateFunc is nil ", "\234\185\128\234\183\188\236\154\176")
  self._tabData[self._currentTabIdx].btn:SetCheck(true)
  self._tabData[self._currentTabIdx].bg:SetShow(true)
  updateFunc()
  self._ui.btn_Resize:SetShow(not Panel_CharacterInfo_All:IsUISubApp() and false == self._isConsole)
  local selectLinePosX = self._tabData[self._currentTabIdx].btn:GetSpanSize().x - (self._tabData[self._currentTabIdx].btn:GetSizeX() * 0.5 + 5 * self._tabData[self._currentTabIdx].btn:GetScale().x)
  self._ui.stc_selectLine:SetSpanSize(selectLinePosX, self._ui.stc_selectLine:GetSpanSize().y)
  if true == self._isConsole then
    self._ui.txt_Title:SetText(PAGetString(Defines.StringSheet_RESOURCE, "CHARACTERINFO_TEXT_TITLE"))
    self._ui.txt_Title:SetText(self._ui.txt_Title:GetText() .. "  -  " .. PAGetString(Defines.StringSheet_RESOURCE, PaGlobal_CharInfo_All._TABSTRING[idx]))
    for jj = 0, #PaGlobal_CharInfo_All._consoleBtnTable do
      if nil ~= PaGlobal_CharInfo_All._consoleBtnTable[jj] and PaGlobal_CharInfo_All._consoleBtnTable[jj] == idx then
        PaGlobal_CharInfo_All._consoleIdx = jj
        break
      end
    end
    if true == PaGlobal_CharInfo_All_GetConsoleDescShow() then
      PaGlobal_CharInfo_All_SetConsoleDescShow(false)
    end
    if idx == self._TABINDEX._challenge then
      Panel_CharacterInfo_All:registerPadEvent(__eConsoleUIPadEvent_Up_RT, "HandleEventPadPress_CharInfoChallenge_All_TabChange(true)")
      Panel_CharacterInfo_All:registerPadEvent(__eConsoleUIPadEvent_Up_LT, "HandleEventPadPress_CharInfoChallenge_All_TabChange(false)")
    else
      Panel_CharacterInfo_All:registerPadEvent(__eConsoleUIPadEvent_Up_RT, "")
      Panel_CharacterInfo_All:registerPadEvent(__eConsoleUIPadEvent_Up_LT, "")
    end
    PaGlobal_CharInfo_All:setKeyGuideAlign(idx)
  end
  ClearFocusEdit()
end
function PaGlobal_CharInfo_All:open()
  Panel_CharacterInfo_All:SetShow(true)
end
function PaGlobal_CharInfo_All:prepareClose()
  if true == self._isConsole and true == PaGlobal_CharInfo_All_GetConsoleDescShow() then
    PaGlobal_CharInfo_All_SetConsoleDescShow(false)
    return
  end
  if nil ~= self._currentTabIdx then
    self._tabData[self._currentTabIdx].btn:SetCheck(false)
    self._tabData[self._currentTabIdx].bg:SetShow(false)
  end
  PaGlobal_CharInfo_All:dataClear()
  self._ui.stc_tooltip:SetShow(false)
  UI.ClearFocusEdit()
  Panel_CharacterInfo_All:CloseUISubApp()
  self._ui.btn_StickerUI:SetCheck(false)
  HelpMessageQuestion_Out()
  Panel_Tooltip_Item_hideTooltip()
  TooltipSimple_Hide()
  PaGlobal_CharInfo_All:close()
end
function PaGlobal_CharInfo_All:close()
  Panel_CharacterInfo_All:SetShow(false)
end
function PaGlobal_CharInfo_All:dataClear()
  self._isFiltered = false
  self._checkLPress = false
  self._currentTabIdx = nil
  self._consoleIdx = 0
end
function PaGlobal_CharInfo_All:showServantInfo()
  local selfProxy = getSelfPlayer():get()
  if nil ~= selfProxy then
    local actorKeyRaw = selfProxy:getRideVehicleActorKeyRaw()
    local temporaryWrapper = getTemporaryInformationWrapper()
    local unsealCacheData = getServantInfoFromActorKey(actorKeyRaw)
    if nil ~= unsealCacheData then
      local inventory = unsealCacheData:getInventory()
      local invenSize = inventory:size()
      if 0 ~= actorKeyRaw then
        if true == isGameServiceTypeConsole() then
          return
        end
        if true == _ContentsGroup_UsePadSnapping then
          return
        end
        requestInformationFromServant()
        if true == _ContentsGroup_NewUI_ServantInfo_All then
          PaGlobal_VehicleInfo_All_Open(actorKeyRaw)
        else
          ServantInfo_BeforOpenByActorKeyRaw(actorKeyRaw)
        end
      end
    end
  end
end
function PaGlobal_CharInfo_All:setKeyGuideAlign(idx)
  if nil == idx or false == self._isConsole or nil == self._tabData[idx] then
    return
  end
  local keyguide = {}
  local bg = self._tabData[idx].bg
  if true == PaGlobalFunc_ChracterInfo_All_GetBgShow(PaGlobal_CharInfo_All._TABINDEX._basic) then
    keyguide = {
      PaGlobal_CharInfoBasic_All._ui.stc_KeyGuide_X,
      PaGlobal_CharInfoBasic_All._ui.stc_KeyGuide_Y,
      PaGlobal_CharInfoBasic_All._ui.stc_KeyGuide_B
    }
  elseif true == PaGlobalFunc_ChracterInfo_All_GetBgShow(PaGlobal_CharInfo_All._TABINDEX._familySkill) then
    if false == _ContentsGroup_FamilySkill then
      return
    end
    keyguide = {
      PaGlobal_CharInfoFamilySkill_All._ui.stc_KeyGuide_Y,
      PaGlobal_CharInfoFamilySkill_All._ui.stc_KeyGuide_X,
      PaGlobal_CharInfoFamilySkill_All._ui.stc_KeyGuide_X,
      PaGlobal_CharInfoFamilySkill_All._ui.stc_KeyGuide_A,
      PaGlobal_CharInfoFamilySkill_All._ui.stc_KeyGuide_B
    }
  elseif true == PaGlobalFunc_ChracterInfo_All_GetBgShow(PaGlobal_CharInfo_All._TABINDEX._title) then
    keyguide = {
      PaGlobal_CharInfoTitle_All._ui.stc_KeyGuide_Y,
      PaGlobal_CharInfoTitle_All._ui.stc_KeyGuide_A,
      PaGlobal_CharInfoTitle_All._ui.stc_KeyGuide_B
    }
  elseif true == PaGlobalFunc_ChracterInfo_All_GetBgShow(PaGlobal_CharInfo_All._TABINDEX._challenge) then
    keyguide = {
      PaGlobal_CharInfoChallenge_All._ui.stc_KeyGuide_X,
      PaGlobal_CharInfoChallenge_All._ui.stc_KeyGuide_A,
      PaGlobal_CharInfoChallenge_All._ui.stc_KeyGuide_B
    }
  elseif true == PaGlobalFunc_ChracterInfo_All_GetBgShow(PaGlobal_CharInfo_All._TABINDEX._cashBuff) then
    keyguide = {
      PaGlobal_CharInfoCashBuff_All._ui.stc_KeyGuide_X,
      PaGlobal_CharInfoCashBuff_All._ui.stc_KeyGuide_B
    }
  elseif true == PaGlobalFunc_ChracterInfo_All_GetBgShow(PaGlobal_CharInfo_All._TABINDEX._life) then
    keyguide = {
      PaGlobal_CharInfoLife_All._ui.stc_KeyGuide_Y,
      PaGlobal_CharInfoLife_All._ui.stc_KeyGuide_X,
      PaGlobal_CharInfoLife_All._ui.stc_KeyGuide_A,
      PaGlobal_CharInfoLife_All._ui.stc_KeyGuide_B
    }
  end
  PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyguide, bg, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHT)
end
