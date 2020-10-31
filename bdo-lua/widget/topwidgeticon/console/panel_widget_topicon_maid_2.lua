function PaGlobalFunc_TopIcon_Maid_Open()
  if nil == Panel_Widget_MaidIcon_Renew then
    return
  end
  PaGlobal_TopIcon_Maid:prepareOpen()
end
function PaGlobalFunc_TopIcon_Maid_Close()
  if nil == Panel_Widget_MaidIcon_Renew then
    return
  end
  PaGlobal_TopIcon_Maid:prepareClose()
end
function PaGlobalFunc_TopIcon_Maid_Update()
  if nil == Panel_Widget_MaidIcon_Renew then
    return
  end
  PaGlobal_TopIcon_Maid:update()
end
function PaGlobalFunc_TopIcon_Maid_Resize()
  if nil == Panel_Widget_MaidIcon_Renew then
    return
  end
  PaGlobal_TopIcon_Maid:onScreenResize()
end
