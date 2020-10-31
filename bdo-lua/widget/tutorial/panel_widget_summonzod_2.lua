function FromClient_SummonZod_ScreenResize()
  local scrX = getScreenSizeX()
  local scrY = getScreenSizeY()
  Panel_Widget_SummonZod:SetSize(scrX, scrY)
  Panel_Widget_SummonZod:SetPosX(0)
  Panel_Widget_SummonZod:SetPosY(0)
  for key, value in pairs(PaGlobal_SummonZod._ui) do
    value:ComputePos()
  end
end
function PaGloabl_SummonZod_ShowAni()
  if nil == Panel_Widget_SummonZod then
    return
  end
end
function PaGloabl_SummonZod_HideAni()
  if nil == Panel_Widget_SummonZod then
    return
  end
end
function PaGloabl_SummonZod_ActionChartZod()
  PaGlobal_SummonZod:startZod()
end
function PaGlobal_SummonZod_UpdatePerframe(deltaTime)
  PaGlobal_SummonZod:updatePerframe(deltaTime)
end
