function FromClient_SummonBelmorn_ScreenResize()
  local scrX = getScreenSizeX()
  local scrY = getScreenSizeY()
  Panel_Widget_SummonBelmorn:SetSize(scrX, scrY)
  Panel_Widget_SummonBelmorn:SetPosX(0)
  Panel_Widget_SummonBelmorn:SetPosY(0)
  for key, value in pairs(PaGlobal_SummonBelmorn._ui) do
    value:ComputePos()
  end
end
function PaGlobal_SummonBelmorn_UpdatePerframe(deltaTime)
  PaGlobal_SummonBelmorn:updatePerframe(deltaTime)
end
function PaGloabl_SummonBelmorn_ActionChartBelmorn0()
  PaGlobal_SummonBelmorn:prepareOpen(PaGlobal_SummonBelmorn._actionType.belmorn0)
end
function PaGloabl_SummonBelmorn_ActionChartBelmorn1()
  PaGlobal_SummonBelmorn:prepareOpen(PaGlobal_SummonBelmorn._actionType.belmorn1)
end
function PaGloabl_SummonBelmorn_ActionChartBelmorn2()
  PaGlobal_SummonBelmorn:prepareOpen(PaGlobal_SummonBelmorn._actionType.belmorn2)
end
function PaGloabl_SummonBelmorn_ActionChartBelmorn3()
  PaGlobal_SummonBelmorn:prepareOpen(PaGlobal_SummonBelmorn._actionType.belmorn3)
end
function PaGloabl_SummonBelmorn_ActionChartBelmorn4()
  PaGlobal_SummonBelmorn:prepareOpen(PaGlobal_SummonBelmorn._actionType.belmorn4)
end
function PaGloabl_SummonBelmorn_ActionChartBelmorn5()
  PaGlobal_SummonBelmorn:prepareOpen(PaGlobal_SummonBelmorn._actionType.belmorn5)
end
function PaGloabl_SummonBelmorn_ActionChartBelmorn6()
  PaGlobal_SummonBelmorn:prepareOpen(PaGlobal_SummonBelmorn._actionType.belmorn6)
end
