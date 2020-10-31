function PaGlobalFunc_FairyIcon_Update()
  if nil == Panel_Widget_FairyIcon_Renew then
    return
  end
  PaGlobal_TopIcon_Fairy:update()
end
function FromClient_TopIcon_Fairy_Resize()
  if nil == Panel_Widget_FairyIcon_Renew then
    return
  end
  PaGlobal_TopIcon_Fairy:onScreenResize()
end
registerEvent("onScreenResize", "FromClient_TopIcon_Fairy_Resize")
