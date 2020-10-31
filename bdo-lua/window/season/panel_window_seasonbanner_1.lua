function PaGlobal_SeasonBanner:initialize()
  if true == self._initialize then
    return
  end
  self._ui.stc_blackBG = UI.getChildControl(Panel_Window_SeasonBanner, "Static_BlackBG")
  for ii = self._startPageNo, self._endPageNo do
    self._ui.stc_page[ii] = {}
    self._ui.stc_page[ii].bg = UI.getChildControl(Panel_Window_SeasonBanner, "Static_Page_" .. tostring(ii))
    if self._endPageNo == ii then
      self._ui.stc_page[ii].button = UI.getChildControl(self._ui.stc_page[ii].bg, "Button_CreateBtn")
    else
      self._ui.stc_page[ii].button = UI.getChildControl(self._ui.stc_page[ii].bg, "Button_Next")
    end
    self._ui.stc_page[ii].title = UI.getChildControl(self._ui.stc_page[ii].bg, "StaticText_Title")
    if nil ~= self._ui.stc_page[ii].title then
      self._ui.stc_page[ii].title:SetTextMode(__eTextMode_AutoWrap)
      self._ui.stc_page[ii].title:SetText(self._ui.stc_page[ii].title:GetText())
    end
  end
  self._ui.stc_pageBG = UI.getChildControl(Panel_Window_SeasonBanner, "Static_PageBG")
  self._ui.btn_left = UI.getChildControl(self._ui.stc_pageBG, "Button_Left")
  self._ui.btn_right = UI.getChildControl(self._ui.stc_pageBG, "Button_Right")
  self._ui.stc_keyGuideBG = UI.getChildControl(self._ui.stc_pageBG, "Static_ButtonGuide_C")
  self._ui.stc_keyGuideDpad = UI.getChildControl(self._ui.stc_keyGuideBG, "Static_GuideDpad_C")
  self._ui.stc_keyGuideA = UI.getChildControl(self._ui.stc_keyGuideBG, "Static_GuideA_C")
  self._isConsole = ToClient_isConsole()
  self:validate()
  self:setConsoleUI()
  self:registEventHandler()
  self._initialize = true
end
function PaGlobal_SeasonBanner:setConsoleUI()
  if nil == Panel_Window_SeasonBanner then
    return
  end
  if true == self._isConsole then
    self._ui.stc_keyGuideBG:SetShow(true)
    self:alignKeyGuide()
    self._ui.btn_left:SetShow(false)
    self._ui.btn_right:SetShow(false)
    for ii = self._startPageNo, self._endPageNo do
      self._ui.stc_page[ii].button:SetShow(false)
    end
  else
    self._ui.stc_keyGuideBG:SetShow(false)
    self._ui.btn_left:SetShow(false)
    self._ui.btn_right:SetShow(true)
  end
end
function PaGlobal_SeasonBanner:registEventHandler()
  if nil == Panel_Window_SeasonBanner then
    return
  end
  self._ui.btn_left:addInputEvent("Mouse_LUp", "HandleEventLUp_SeasonBanner_ChangePage(false)")
  self._ui.btn_right:addInputEvent("Mouse_LUp", "HandleEventLUp_SeasonBanner_ChangePage(true)")
  for ii = self._startPageNo, self._endPageNo do
    if self._endPageNo == ii then
      self._ui.stc_page[ii].button:addInputEvent("Mouse_LUp", "HandleEventLUp_SeasonBanner_SetSeasonCharacter()")
    else
      self._ui.stc_page[ii].button:addInputEvent("Mouse_LUp", "HandleEventLUp_SeasonBanner_ChangePage(true)")
    end
  end
  registerEvent("onScreenResize", "PaGlobalFunc_SeasonBanner_OnScreenResize")
  if true == self._isConsole then
    Panel_Window_SeasonBanner:registerPadEvent(__eConsoleUIPadEvent_DpadLeft, "HandleEventLUp_SeasonBanner_ChangePage(false)")
    Panel_Window_SeasonBanner:registerPadEvent(__eConsoleUIPadEvent_DpadRight, "HandleEventLUp_SeasonBanner_ChangePage(true)")
  end
end
function PaGlobal_SeasonBanner:prepareOpen()
  if nil == Panel_Window_SeasonBanner then
    return
  end
  PaGlobalFunc_SeasonBanner_OnScreenResize()
  if true == self._isConsole then
    self:alignKeyGuide()
  end
  PaGlobal_SeasonBanner:open()
end
function PaGlobal_SeasonBanner:open()
  if nil == Panel_Window_SeasonBanner then
    return
  end
  Panel_Window_SeasonBanner:SetShow(true)
end
function PaGlobal_SeasonBanner:prepareClose()
  if nil == Panel_Window_SeasonBanner then
    return
  end
  PaGlobal_SeasonBanner:close()
end
function PaGlobal_SeasonBanner:close()
  if nil == Panel_Window_SeasonBanner then
    return
  end
  Panel_Window_SeasonBanner:SetShow(false)
end
function PaGlobal_SeasonBanner:changePage(nextPage)
  if nil == Panel_Window_SeasonBanner then
    return
  end
  local prevPageNo = self._currentPageNo
  if true == nextPage then
    if self._endPageNo <= self._currentPageNo then
      return
    end
    self._currentPageNo = self._currentPageNo + 1
  else
    if self._currentPageNo <= self._startPageNo then
      return
    end
    self._currentPageNo = self._currentPageNo - 1
  end
  local currentPageNo = self._currentPageNo
  if nil ~= self._ui.stc_page[prevPageNo].bg then
    self._ui.stc_page[prevPageNo].bg:SetShow(false)
  end
  if nil ~= self._ui.stc_page[currentPageNo].bg then
    self._ui.stc_page[currentPageNo].bg:SetShow(true)
  end
  if true == self._isConsole then
    if self._endPageNo == currentPageNo then
      Panel_Window_SeasonBanner:registerPadEvent(__eConsoleUIPadEvent_Up_A, "HandleEventLUp_SeasonBanner_SetSeasonCharacter()")
      self._ui.stc_keyGuideA:SetShow(true)
    else
      Panel_Window_SeasonBanner:registerPadEvent(__eConsoleUIPadEvent_Up_A, "")
      self._ui.stc_keyGuideA:SetShow(false)
    end
    self:alignKeyGuide()
  elseif self._endPageNo == currentPageNo then
    self._ui.btn_left:SetShow(true)
    self._ui.btn_right:SetShow(false)
  elseif self._startPageNo == currentPageNo then
    self._ui.btn_left:SetShow(false)
    self._ui.btn_right:SetShow(true)
  else
    self._ui.btn_left:SetShow(true)
    self._ui.btn_right:SetShow(true)
  end
end
function PaGlobal_SeasonBanner:alignKeyGuide()
  local keyGuides = {
    self._ui.stc_keyGuideDpad,
    self._ui.stc_keyGuideA
  }
  PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyGuides, self._ui.stc_keyGuideBG, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP)
end
function PaGlobal_SeasonBanner:validate()
  if nil == Panel_Window_SeasonBanner then
    return
  end
  self._ui.stc_blackBG:isValidate()
  for ii = self._startPageNo, self._endPageNo do
    self._ui.stc_page[ii].bg:isValidate()
    self._ui.stc_page[ii].button:isValidate()
  end
  self._ui.btn_left:isValidate()
  self._ui.btn_right:isValidate()
  self._ui.stc_keyGuideBG:isValidate()
  self._ui.stc_keyGuideDpad:isValidate()
  self._ui.stc_keyGuideA:isValidate()
end
