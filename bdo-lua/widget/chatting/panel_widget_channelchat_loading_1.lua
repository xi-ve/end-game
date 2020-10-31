_PA_LOG("\236\167\128\235\175\188\237\152\129", "Loading_1")
function PaGlobal_ChannelChat_Loading:initialize()
  if true == PaGlobal_ChannelChat_Loading._initialize then
    return
  end
  PaGlobal_ChannelChat_Loading._ui._btn_Cancel = UI.getChildControl(Panel_Widget_ChannelChat_Loading, "Button_Cancel")
  PaGlobal_ChannelChat_Loading:registEventHandler()
  PaGlobal_ChannelChat_Loading:validate()
  PaGlobal_ChannelChat_Loading._initialize = true
end
function PaGlobal_ChannelChat_Loading:registEventHandler()
  if nil == Panel_Widget_ChannelChat_Loading then
    return
  end
  self._ui._btn_Cancel:addInputEvent("Mouse_LUp", "PaGlobalFunc_ChannelChat_Loading_Close()")
end
function PaGlobal_ChannelChat_Loading:prepareOpen()
  if nil == Panel_Widget_ChannelChat_Loading then
    return
  end
  PaGlobal_ChannelChat_Loading:open()
end
function PaGlobal_ChannelChat_Loading:open()
  if nil == Panel_Widget_ChannelChat_Loading then
    return
  end
  Panel_Widget_ChannelChat_Loading:SetShow(true)
end
function PaGlobal_ChannelChat_Loading:prepareClose()
  if nil == Panel_Widget_ChannelChat_Loading then
    return
  end
  PaGlobal_ChannelChat_Loading:close()
end
function PaGlobal_ChannelChat_Loading:close()
  if nil == Panel_Widget_ChannelChat_Loading then
    return
  end
  Panel_Widget_ChannelChat_Loading:SetShow(false)
end
function PaGlobal_ChannelChat_Loading:update()
  if nil == Panel_Widget_ChannelChat_Loading then
    return
  end
end
function PaGlobal_ChannelChat_Loading:validate()
  if nil == Panel_Widget_ChannelChat_Loading then
    return
  end
end
