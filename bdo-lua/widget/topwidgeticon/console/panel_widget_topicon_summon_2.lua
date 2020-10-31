function PaGlobalFunc_TopIcon_Summon_Open()
  if nil == Panel_Widget_SummonIcon_Renew then
    return
  end
  PaGlobal_TopIcon_Summon:prepareOpen()
end
function PaGlobalFunc_TopIcon_Summon_Close()
  if nil == Panel_Widget_SummonIcon_Renew then
    return
  end
  PaGlobal_TopIcon_Summon:prepareClose()
end
function PaGlobalFunc_TopIcon_Summon_Update()
  if nil == Panel_Widget_SummonIcon_Renew then
    return
  end
  PaGlobal_TopIcon_Summon:update()
end
function PaGlobalFunc_TopIcon_Summon_Resize()
  if nil == Panel_Widget_SummonIcon_Renew then
    return
  end
  PaGlobal_TopIcon_Summon:onScreenResize()
end
