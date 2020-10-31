function PaGlobal_InterestKnowledge_All:initialize()
  if true == PaGlobal_InterestKnowledge_All._initialize then
    return
  end
  self._isConsole = _ContentsGroup_UsePadSnapping
  self._ui.stc_subBg = UI.getChildControl(Panel_Interest_Knowledge_All, "Static_SubBg")
  self._ui.stc_needKnowledge = UI.getChildControl(Panel_Interest_Knowledge_All, "StaticText_Need_Knowledge")
  self._ui.list2 = UI.getChildControl(Panel_Interest_Knowledge_All, "List2_Knowledge")
  self._ui_pc.btn_question = UI.getChildControl(Panel_Interest_Knowledge_All, "Button_Question_PCUI")
  self._ui_console.stc_guideBg = UI.getChildControl(Panel_Interest_Knowledge_All, "Static_KeyGuideBg_ConsoleUI")
  self._ui_console.stc_guideIconRS = UI.getChildControl(self._ui_console.stc_guideBg, "Button_Scroll")
  self._baseNeedKnowledgeSizeY = self._ui.stc_needKnowledge:GetSizeY()
  self._baseSubBgSizeY = self._ui.stc_subBg:GetSizeY()
  self._basePanelSizeY = Panel_Interest_Knowledge_All:GetSizeY()
  self:controlSetShow()
  PaGlobal_InterestKnowledge_All:registEventHandler()
  PaGlobal_InterestKnowledge_All:validate()
  PaGlobal_InterestKnowledge_All._initialize = true
end
function PaGlobal_InterestKnowledge_All:controlSetShow()
  if false == self._isConsole then
    self._ui_pc.btn_question:SetShow(true)
    self._ui_console.stc_guideBg:SetShow(false)
  else
    self._ui_pc.btn_question:SetShow(false)
    self._ui_console.stc_guideBg:SetShow(true)
    local tempBtnGroup = {
      self._ui_console.stc_guideIconRS
    }
    PaGlobalFunc_ConsoleKeyGuide_SetAlign(tempBtnGroup, self._ui_console.stc_guideBg, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP)
  end
end
function PaGlobal_InterestKnowledge_All:registEventHandler()
  if nil == Panel_Interest_Knowledge_All then
    return
  end
  if false == self._isConsole then
    self._ui_pc.btn_question:addInputEvent("Mouse_LUp", "Panel_WebHelper_ShowToggle( \"PanelImportantKnowledge\" )")
    PaGlobal_Util_RegistHelpTooltipEvent(self._ui_pc.btn_question, "\"PanelImportantKnowledge\"")
  end
  self._ui.list2:registEvent(__ePAUIList2EventType_LuaChangeContent, "PaGlobalFunc_InterestKnowledge_All_ListControlCreate")
  self._ui.list2:createChildContent(__ePAUIList2ElementManagerType_List)
  self._ui.list2:getElementManager():clearKey()
end
function PaGlobal_InterestKnowledge_All:resize()
  if nil == Panel_Interest_Knowledge_All then
    return
  end
  Panel_Interest_Knowledge_All:ComputePosAllChild()
  if true == _ContentsGroup_RenewUI then
    Panel_Interest_Knowledge_All:SetPosY(Panel_Npc_Dialog_All:GetPosY() - Panel_Interest_Knowledge_All:GetSizeY() - self._ui_console.stc_guideBg:GetSizeY() - PaGlobalFunc_DialogMain_All_GetContentSizeY() - 30)
  end
end
function PaGlobal_InterestKnowledge_All:prepareOpen()
  if nil == Panel_Interest_Knowledge_All then
    return
  end
  local talker = dialog_getTalker()
  if nil == talker then
    return
  end
  local actorKeyRaw = talker:getActorKey()
  local npcActorProxyWrapper = getNpcActor(actorKeyRaw)
  local knowledge = getSelfPlayer():get():getMentalKnowledge()
  local mentalObject = knowledge:getThemeByKeyRaw(npcActorProxyWrapper:getNpcThemeKey())
  if nil == mentalObject then
    PaGlobalFunc_InterestKnowledge_All_Close()
    return
  end
  PaGlobal_InterestKnowledge_All:update(mentalObject, npcActorProxyWrapper)
  PaGlobal_InterestKnowledge_All:resize()
  PaGlobal_InterestKnowledge_All:open()
end
function PaGlobal_InterestKnowledge_All:open()
  if nil == Panel_Interest_Knowledge_All then
    return
  end
  Panel_Interest_Knowledge_All:SetShow(true)
end
function PaGlobal_InterestKnowledge_All:prepareClose()
  if nil == Panel_Interest_Knowledge_All then
    return
  end
  PaGlobal_InterestKnowledge_All:close()
end
function PaGlobal_InterestKnowledge_All:close()
  if nil == Panel_Interest_Knowledge_All then
    return
  end
  Panel_Interest_Knowledge_All:SetShow(false)
end
function PaGlobal_InterestKnowledge_All:update(theme, npcActorProxyWrapper)
  if nil == Panel_Interest_Knowledge_All then
    return
  end
  if nil == theme or nil == npcActorProxyWrapper then
    return
  end
  local _needKnowledge = npcActorProxyWrapper:getNpcTheme()
  local _needCount = npcActorProxyWrapper:getNeedCount()
  local _currCount = getKnowledgeCountMatchTheme(npcActorProxyWrapper:getNpcThemeKey())
  local _currentKnowledge = ""
  self:reset()
  self._ui.stc_needKnowledge:SetTextMode(__eTextMode_AutoWrap)
  self._ui.stc_needKnowledge:SetText(_needKnowledge .. " ( " .. _currCount .. "/" .. theme:getChildCardCount() .. " ) ")
  local gabX = 3
  if true == self._ui.stc_needKnowledge:IsAutoWrapText() then
    local addSizeY = self._ui.stc_needKnowledge:GetTextSizeY() + gabX - self._baseNeedKnowledgeSizeY
    self._ui.stc_needKnowledge:SetSize(self._ui.stc_needKnowledge:GetSizeX(), self._baseNeedKnowledgeSizeY + addSizeY)
    self._ui.stc_subBg:SetSize(self._ui.stc_subBg:GetSizeX(), self._baseSubBgSizeY + addSizeY)
    Panel_Interest_Knowledge_All:SetSize(Panel_Interest_Knowledge_All:GetSizeX(), self._basePanelSizeY + addSizeY)
  end
  self._uiText = {}
  self._ui.list2:getElementManager():clearKey()
  local ii = 1
  local cardCount = theme:getChildCardCount()
  for index = 0, cardCount - 1 do
    local _childCard = theme:getChildCardByIndex(index)
    if nil ~= _childCard then
      self._uiText[ii] = _childCard:getName()
      self._ui.list2:getElementManager():pushKey(toInt64(0, ii))
      ii = ii + 1
    end
  end
end
function PaGlobal_InterestKnowledge_All:reset()
  if nil == Panel_Interest_Knowledge_All then
    return
  end
  self._ui.stc_needKnowledge:SetSize(self._ui.stc_needKnowledge:GetSizeX(), self._baseNeedKnowledgeSizeY)
  self._ui.stc_subBg:SetSize(self._ui.stc_subBg:GetSizeX(), self._baseSubBgSizeY)
  Panel_Interest_Knowledge_All:SetSize(Panel_Interest_Knowledge_All:GetSizeX(), self._basePanelSizeY)
end
function PaGlobal_InterestKnowledge_All:validate()
  if nil == Panel_Interest_Knowledge_All then
    return
  end
  self._ui.stc_needKnowledge:isValidate()
  self._ui.list2:isValidate()
  self._ui_pc.btn_question:isValidate()
  self._ui_console.stc_guideBg:isValidate()
  self._ui_console.stc_guideIconRS:isValidate()
end
function PaGlobalFunc_InterestKnowledge_All_ListControlCreate(content, key)
  local key32 = Int64toInt32(key)
  local _text = UI.getChildControl(content, "StaticText_Knowledge_List")
  _text:SetText(PaGlobal_InterestKnowledge_All._uiText[key32])
end
