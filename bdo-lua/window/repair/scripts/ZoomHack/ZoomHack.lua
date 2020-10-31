ZoomHack = { }
ZoomHack.Running = false

function ZoomHack.Start()
  ZoomHack.Running = true
	    
end

function ZoomHack.Stop()
  ZoomHack.Running = false  
end

function ZoomHack.OnPulse()
  if ZoomHack.Running == false then
    return
  end
end

function ZoomHack.OnRenderD2D()
end

function ZoomHack.OnGuiDraw()
	MainWindow.DrawMainWindow()
end

function ZoomHack.setZoom(value)	
	local code =
	[[
		characterCameraSetPosAndWheel(float2(0, 0), ]] .. value .. [[, 0)
	]]

	Infinity.BDO.Lua.Execute(code)
end

function ZoomHack.resetZoom()  
  local code =
  [[
    characterCameraReset()
  ]]

  Infinity.BDO.Lua.Execute(code)
end