function PaGlobal_BossAlert_SettingV2_All:initialize()
  if true == self._initialize then
    return
  end
  self._isConsole = _ContentsGroup_UsePadSnapping
  self:controlAll_Init()
  self:controlPc_Init()
  self:controlConsole_Init()
  self:SetUiSetting()
  self:registEventHandler()
  self:validate()
  self:setCurrentNation()
  self.bossRaidCount = #self.bossAlert[self.currentNation]._alertTime
  self:setNotice()
  self:setCheckUpdate()
  self._initialize = true
end
function PaGlobal_BossAlert_SettingV2_All:controlAll_Init()
  if nil == Panel_BossAlert_SettingV2_All then
    return
  end
  self._ui.stc_alertOnOffBG = UI.getChildControl(Panel_BossAlert_SettingV2_All, "Static_AlertOnOffBg")
  self._ui.btn_alertOn = UI.getChildControl(self._ui.stc_alertOnOffBG, "RadioButton_AlertOn")
  self._ui.btn_alertOff = UI.getChildControl(self._ui.stc_alertOnOffBG, "RadioButton_AlertOff")
  self._ui.stc_alertBG = UI.getChildControl(Panel_BossAlert_SettingV2_All, "Static_AlertBg")
  self._ui.btn_30Minutes = UI.getChildControl(self._ui.stc_alertBG, "Checkbox_30")
  self._ui.btn_15Minutes = UI.getChildControl(self._ui.stc_alertBG, "Checkbox_15")
  self._ui.btn_5Minutes = UI.getChildControl(self._ui.stc_alertBG, "Checkbox_5")
  self._ui.stc_alertKeepBG = UI.getChildControl(Panel_BossAlert_SettingV2_All, "Static_AlertKeep")
  self._ui.btn_alertKeep = UI.getChildControl(self._ui.stc_alertKeepBG, "RadioButton_AlertKeep")
  self._ui.btn_alertNone = UI.getChildControl(self._ui.stc_alertKeepBG, "RadioButton_AlertNone")
  self._ui.stc_bottomBG = UI.getChildControl(Panel_BossAlert_SettingV2_All, "Static_BottomBg")
  self._ui.txt_desc = UI.getChildControl(self._ui.stc_bottomBG, "StaticText_Desc")
end
function PaGlobal_BossAlert_SettingV2_All:controlPc_Init()
  if nil == Panel_BossAlert_SettingV2_All then
    return
  end
  local titleArea = UI.getChildControl(Panel_BossAlert_SettingV2_All, "StaticText_TitleArea")
  self._ui_pc.btn_close = UI.getChildControl(titleArea, "Button_CloseIcon")
  self._ui_pc.btn_setting = UI.getChildControl(Panel_BossAlert_SettingV2_All, "Button_Setting")
  self._ui_pc.btn_bossTime = UI.getChildControl(Panel_BossAlert_SettingV2_All, "Button_BossTime")
end
function PaGlobal_BossAlert_SettingV2_All:controlConsole_Init()
  if nil == Panel_BossAlert_SettingV2_All then
    return
  end
  self._ui_console.stc_bottomBG = UI.getChildControl(Panel_BossAlert_SettingV2_All, "Static_BottomBg_ConsoleUI")
  self._ui_console.stc_close = UI.getChildControl(self._ui_console.stc_bottomBG, "StaticText_Close")
  self._ui_console.stc_select = UI.getChildControl(self._ui_console.stc_bottomBG, "StaticText_Bid")
end
function PaGlobal_BossAlert_SettingV2_All:SetUiSetting()
  if nil == Panel_BossAlert_SettingV2_All then
    return
  end
  if false == self._isConsole then
    self._ui_console.stc_bottomBG:SetShow(false)
  else
    self._ui_console.stc_bottomBG:SetShow(false)
    local keyGuide = {
      self._ui_console.stc_close,
      self._ui_console.stc_select
    }
    PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyGuide, self._ui_console.stc_bottomBG, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHT)
  end
  FromClient_BossAlert_SettingV2_All_ReSizePanel()
end
function PaGlobal_BossAlert_SettingV2_All:registEventHandler()
  if nil == Panel_BossAlert_SettingV2_All then
    return
  end
  registerEvent("onScreenResize", "FromClient_BossAlert_SettingV2_All_ReSizePanel()")
  Panel_BossAlert_SettingV2_All:RegisterShowEventFunc(true, "PaGlobal_BossAlert_SettingV2_All_ShowAni()")
  Panel_BossAlert_SettingV2_All:RegisterShowEventFunc(false, "PaGlobal_BossAlert_SettingV2_All_HideAni()")
  if false == self._isConsole then
    self._ui_pc.btn_close:addInputEvent("Mouse_LUp", "PaGlobal_BossAlert_SettingV2_All_Close()")
    self._ui_pc.btn_bossTime:addInputEvent("Mouse_LUp", "Panel_WebHelper_ShowToggle( \"WorldBoss\" )")
    self._ui.btn_30Minutes:addInputEvent("Mouse_LUp", "HandleEventLUp_SettingV2_All_CheckMinutes()")
    self._ui.btn_15Minutes:addInputEvent("Mouse_LUp", "HandleEventLUp_SettingV2_All_CheckMinutes()")
    self._ui.btn_5Minutes:addInputEvent("Mouse_LUp", "HandleEventLUp_SettingV2_All_CheckMinutes()")
    self._ui_pc.btn_setting:addInputEvent("Mouse_LUp", "HandleEventLUp_SettingV2_All_SetSetting()")
  else
    self._ui_pc.btn_setting:registerPadEvent(__eConsoleUIPadEvent_Up_A, "HandleEventLUp_SettingV2_All_SetSetting()")
    self._ui_pc.btn_bossTime:registerPadEvent(__eConsoleUIPadEvent_Up_A, "Panel_WebHelper_ShowToggle( \"WorldBoss\" )")
  end
end
function PaGlobal_BossAlert_SettingV2_All:prepareOpen()
  if nil == Panel_BossAlert_SettingV2_All then
    return
  end
  self:setNotice()
  self:setCheckUpdate()
  PaGlobal_BossAlert_SettingV2_All:open()
end
function PaGlobal_BossAlert_SettingV2_All:open()
  if nil == Panel_BossAlert_SettingV2_All then
    return
  end
  Panel_BossAlert_SettingV2_All:SetShow(true)
end
function PaGlobal_BossAlert_SettingV2_All:prepareClose()
  if nil == Panel_BossAlert_SettingV2_All then
    return
  end
  PaGlobal_BossAlert_SettingV2_All:close()
end
function PaGlobal_BossAlert_SettingV2_All:close()
  if nil == Panel_BossAlert_SettingV2_All then
    return
  end
  Panel_BossAlert_SettingV2_All:SetShow(false)
end
function PaGlobal_BossAlert_SettingV2_All:setNotice()
  local padding = 20
  local panelSizeY = Panel_BossAlert_SettingV2_All:GetSizeY() - self._ui.stc_bottomBG:GetSizeY()
  self._ui.txt_desc:SetTextMode(__eTextMode_AutoWrap)
  self._ui.txt_desc:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_BOSSALERTSET_BOTTOMDESC"))
  self._ui.txt_desc:SetSize(self._ui.txt_desc:GetSizeX(), self._ui.txt_desc:GetTextSizeY())
  self._ui.stc_bottomBG:SetSize(self._ui.stc_bottomBG:GetSizeX(), self._ui.txt_desc:GetSizeY() + padding)
  panelSizeY = panelSizeY + self._ui.stc_bottomBG:GetSizeY()
  Panel_BossAlert_SettingV2_All:SetSize(Panel_BossAlert_SettingV2_All:GetSizeX(), panelSizeY)
  self._ui.stc_bottomBG:ComputePos()
  self._ui.txt_desc:ComputePos()
  self._ui_pc.btn_setting:ComputePos()
  self._ui_pc.btn_bossTime:ComputePos()
  if true == self._isConsole then
    self._ui_console.stc_bottomBG:ComputePos()
  end
end
function PaGlobal_BossAlert_SettingV2_All:setCheckUpdate()
  local isCheckCount = ToClient_getGameUIManagerWrapper():getLuaCacheDataListNumber(__eBossAlertTime)
  if 1110 == isCheckCount then
    self._ui.btn_30Minutes:SetCheck(true)
    self._ui.btn_15Minutes:SetCheck(true)
    self._ui.btn_5Minutes:SetCheck(true)
  elseif 1100 == isCheckCount then
    self._ui.btn_30Minutes:SetCheck(false)
    self._ui.btn_15Minutes:SetCheck(true)
    self._ui.btn_5Minutes:SetCheck(true)
  elseif 1010 == isCheckCount then
    self._ui.btn_30Minutes:SetCheck(true)
    self._ui.btn_15Minutes:SetCheck(false)
    self._ui.btn_5Minutes:SetCheck(true)
  elseif 110 == isCheckCount then
    self._ui.btn_30Minutes:SetCheck(true)
    self._ui.btn_15Minutes:SetCheck(true)
    self._ui.btn_5Minutes:SetCheck(false)
  else
    self._ui.btn_30Minutes:SetCheck(10 == isCheckCount)
    self._ui.btn_15Minutes:SetCheck(100 == isCheckCount)
    self._ui.btn_5Minutes:SetCheck(1000 == isCheckCount)
  end
  HandleEventLUp_SettingV2_All_CheckMinutes()
end
function PaGlobal_BossAlert_SettingV2_All:setCurrentNation()
  if isGameTypeJapan() then
    self.currentNation = self.nation._japan
  elseif isGameTypeRussia() then
    self.currentNation = self.nation._russia
  elseif isGameTypeEnglish() and 0 == getServiceNationType() then
    self.currentNation = self.nation._notrhAmerica
  elseif isGameTypeEnglish() and 1 == getServiceNationType() then
    self.currentNation = self.nation._europe
  elseif isGameTypeTaiwan() then
    self.currentNation = self.nation._taiwan
  elseif isGameTypeSA() then
    self.currentNation = self.nation._southAmerica
  elseif isGameTypeTH() then
    self.currentNation = self.nation._thailand
  elseif isGameTypeTR() then
    self.currentNation = self.nation._turkey
  elseif isGameTypeID() then
    self.currentNation = self.nation._southeastAsia
  elseif isGameTypeKorea() then
    self.currentNation = self.nation._korea
  elseif isGameTypeGT() then
    self.currentNation = self.nation._korea
  elseif _ContentsGroup_RenewUI then
    self.currentNation = self.nation._notrhAmerica
  else
    self.currentNation = self.nation._korea
  end
  local isAdult = ToClient_isAdultUser()
  if false == isAdult then
    self.currentNation = self.nation._koreaTeen
  end
  if self.currentNation ~= self.nation._korea and self.currentNation ~= self.nation._taiwan and self.currentNation ~= self.nation._thailand and self.currentNation ~= self.nation._turkey and self.currentNation ~= self.nation._southeastAsia and self.currentNation ~= self.nation._southAmerica and self.currentNation ~= self.nation._japan then
    self._ui_pc.btn_bossTime:SetShow(false)
  end
end
function PaGlobal_BossAlert_SettingV2_All:validate()
  if nil == Panel_BossAlert_SettingV2_All then
    return
  end
  self:allValidate()
  self:pcValidate()
  self:consoleValidate()
end
function PaGlobal_BossAlert_SettingV2_All:allValidate()
  if nil == Panel_BossAlert_SettingV2_All then
    return
  end
  self._ui.stc_alertOnOffBG:isValidate()
  self._ui.btn_alertOn:isValidate()
  self._ui.btn_alertOff:isValidate()
  self._ui.stc_alertBG:isValidate()
  self._ui.btn_30Minutes:isValidate()
  self._ui.btn_15Minutes:isValidate()
  self._ui.btn_5Minutes:isValidate()
  self._ui.stc_alertKeepBG:isValidate()
  self._ui.btn_alertKeep:isValidate()
  self._ui.btn_alertNone:isValidate()
  self._ui.stc_bottomBG:isValidate()
  self._ui.txt_desc:isValidate()
end
function PaGlobal_BossAlert_SettingV2_All:pcValidate()
  if nil == Panel_BossAlert_SettingV2_All then
    return
  end
  self._ui_pc.btn_close:isValidate()
  self._ui_pc.btn_setting:isValidate()
  self._ui_pc.btn_bossTime:isValidate()
end
function PaGlobal_BossAlert_SettingV2_All:consoleValidate()
  if nil == Panel_BossAlert_SettingV2_All then
    return
  end
end
