function PaGlobal_LetterScroll_All:initialize()
  if true == PaGlobal_LetterScroll_All._initialize then
    return
  end
  self._ui.btn_Close = UI.getChildControl(Panel_Window_LetterScroll_All, "Button_Close")
  self._ui.txt_Contents = UI.getChildControl(Panel_Window_LetterScroll_All, "StaticText_Contents")
  self._ui.stc_DecoSeal = UI.getChildControl(Panel_Window_LetterScroll_All, "Static_Deco_Seal")
  self._ui.txt_Contents:SetTextMode(__eTextMode_AutoWrap)
  self._contentsSpanY = self._ui.txt_Contents:GetSpanSize().y
  PaGlobal_LetterScroll_All:registEventHandler()
  PaGlobal_LetterScroll_All:validate()
  PaGlobal_LetterScroll_All._initialize = true
end
function PaGlobal_LetterScroll_All:registEventHandler()
  if nil == Panel_Window_LetterScroll_All then
    return
  end
  self._ui.btn_Close:addInputEvent("Mouse_LUp", "PaGlobal_LetterScroll_All_Close()")
end
function PaGlobal_LetterScroll_All:prepareOpen(eType)
  if nil == Panel_Window_LetterScroll_All then
    return
  end
  self:initTexture(eType)
  self:initTextDesc(eType)
  PaGlobal_LetterScroll_All:open()
end
function PaGlobal_LetterScroll_All:open()
  if nil == Panel_Window_LetterScroll_All then
    return
  end
  Panel_Window_LetterScroll_All:SetShow(true)
end
function PaGlobal_LetterScroll_All:prepareClose()
  if nil == Panel_Window_LetterScroll_All then
    return
  end
  PaGlobal_LetterScroll_All:close()
end
function PaGlobal_LetterScroll_All:close()
  if nil == Panel_Window_LetterScroll_All then
    return
  end
  Panel_Window_LetterScroll_All:SetShow(false)
end
function PaGlobal_LetterScroll_All:update()
  if nil == Panel_Window_LetterScroll_All then
    return
  end
end
function PaGlobal_LetterScroll_All:validate()
  if nil == Panel_Window_LetterScroll_All then
    return
  end
  self._ui.btn_Close:isValidate()
  self._ui.txt_Contents:isValidate()
end
function PaGlobal_LetterScroll_All:initTexture(eType)
  local texturePath = "combine/etc/combine_etc_letter.dds"
  local _x1, _y1, _x2, _y2 = 0, 0, 470, 630
  if self._eType.jLetter == eType then
    self._ui.stc_DecoSeal:SetShow(true)
  elseif self._eType.crape == eType then
    self._ui.stc_DecoSeal:SetShow(true)
  elseif self._eType.graduation == eType then
    _x1, _y1, _x2, _y2 = 471, 167, 941, 797
    self._ui.stc_DecoSeal:SetShow(false)
  elseif self._eType.season2graduation == eType then
    _x1, _y1, _x2, _y2 = 471, 167, 941, 797
    self._ui.stc_DecoSeal:SetShow(true)
  end
  Panel_Window_LetterScroll_All:ChangeTextureInfoName(texturePath)
  local x1, y1, x2, y2 = setTextureUV_Func(Panel_Window_LetterScroll_All, _x1, _y1, _x2, _y2)
  Panel_Window_LetterScroll_All:getBaseTexture():setUV(x1, y1, x2, y2)
  Panel_Window_LetterScroll_All:setRenderTexture(Panel_Window_LetterScroll_All:getBaseTexture())
end
function PaGlobal_LetterScroll_All:initTextDesc(eType)
  local spanY = self._contentsSpanY
  if self._eType.jLetter == eType then
    self._ui.txt_Contents:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_LETTER_2019"))
  elseif self._eType.crape == eType then
    self._ui.txt_Contents:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_J_LETTER_AWARD_DESC"))
  elseif self._eType.graduation == eType then
    spanY = spanY + 50
    self._ui.txt_Contents:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_LETTER_SEASON_FINISH_DESC"))
  elseif self._eType.season2graduation == eType then
    spanY = spanY + 50
    self._ui.txt_Contents:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_LETTER_SEASON_FINISH_DESC2"))
  end
  self._ui.txt_Contents:SetSpanSize(self._ui.txt_Contents:GetSpanSize().x, spanY)
end
