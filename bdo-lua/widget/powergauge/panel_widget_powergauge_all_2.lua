function FromClient_PowerGauge_All_Resize()
  PaGlobal_PowerGauge_All:reposition()
end
function PaGloabl_PowerGauge_All_ShowAni()
  if nil == Panel_Widget_PowerGauge_All then
    return
  end
end
function PaGloabl_PowerGauge_All_HideAni()
  if nil == Panel_Widget_PowerGauge_All then
    return
  end
end
function PaGloabl_PowerGauge_All_startUpdateFrame()
  PaGlobal_PowerGauge_All:startUpdateFrame()
end
function PaGlobal_PowerGauge_All_Open()
  PaGlobal_PowerGauge_All:prepareOpen()
end
function PaGlobal_PowerGauge_All_Close()
  PaGlobal_PowerGauge_All:prepareClose()
end
function PaGlobal_PowerGauge_All_UpdatePerFrame(deltaTime)
  PaGlobal_PowerGauge_All:updatePerFrame(deltaTime)
end
