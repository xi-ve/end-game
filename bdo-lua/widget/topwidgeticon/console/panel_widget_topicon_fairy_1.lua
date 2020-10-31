function PaGlobal_TopIcon_Fairy:initialize()
  if true == PaGlobal_TopIcon_Fairy._initialize then
    return
  end
  self._ui.stc_Icon = UI.getChildControl(Panel_Widget_FairyIcon_Renew, "Static_FairyIcon_Template")
  PaGlobal_TopIcon_Fairy:registEventHandler()
  if 0 < ToClient_getFairyUnsealedList() + ToClient_getFairySealedList() then
    Panel_Widget_FairyIcon_Renew:SetShow(true)
    PaGlobalFunc_TopIcon_UpdatePos()
  end
  PaGlobal_TopIcon_Fairy:onScreenResize()
  PaGlobal_TopIcon_Fairy._initialize = true
end
function PaGlobal_TopIcon_Fairy:registEventHandler()
  if nil == Panel_Widget_FairyIcon_Renew then
    return
  end
  registerEvent("FromClient_PetDelSealedList", "PaGlobalFunc_FairyIcon_Update()")
  registerEvent("FromClient_PetAddSealedList", "PaGlobalFunc_FairyIcon_Update()")
end
function PaGlobal_TopIcon_Fairy:prepareOpen()
  if nil == Panel_Widget_FairyIcon_Renew then
    return
  end
  PaGlobal_TopIcon_Fairy:update()
  PaGlobal_TopIcon_Fairy:open()
end
function PaGlobal_TopIcon_Fairy:open()
  if nil == Panel_Widget_FairyIcon_Renew then
    return
  end
  PaGlobalFunc_TopIcon_Show(TopWidgetIconType.Fairy)
end
function PaGlobal_TopIcon_Fairy:prepareClose()
  if nil == Panel_Widget_FairyIcon_Renew then
    return
  end
  PaGlobal_TopIcon_Fairy:close()
end
function PaGlobal_TopIcon_Fairy:close()
  if nil == Panel_Widget_FairyIcon_Renew then
    return
  end
  PaGlobalFunc_TopIcon_Exit(TopWidgetIconType.Fairy)
end
function PaGlobal_TopIcon_Fairy:update()
  if nil == Panel_Widget_FairyIcon_Renew then
    return
  end
  if false == _ContentsGroup_isFairy then
    self:close()
    return
  end
  if isFlushedUI() then
    self:close()
  end
  if 0 < ToClient_getFairyUnsealedList() + ToClient_getFairySealedList() then
    self:open()
  else
    self:close()
  end
  PaGlobalFunc_TopIcon_UpdatePos()
end
function PaGlobal_TopIcon_Fairy:validate()
  if nil == Panel_Widget_FairyIcon_Renew then
    return
  end
  self._ui.stc_Icon:isValidate()
end
function PaGlobal_TopIcon_Fairy:onScreenResize()
  local posY = Panel_SelfPlayerExpGage:GetPosY() + Panel_SelfPlayerExpGage:GetSizeY() + 4
  Panel_Widget_FairyIcon_Renew:SetPosY(posY)
end
