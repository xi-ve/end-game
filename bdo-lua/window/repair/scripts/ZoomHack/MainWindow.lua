MainWindow = { }

local zoomValue = 800.0

function MainWindow.DrawMainWindow()
	local valueChanged = false

    ImGui.Begin("ZoomHack")
            
    ImGui.SetWindowSize(ImVec2(400,150), ImGuiCond_FirstUseEver)

    if ImGui.Button("Reset") then
        ZoomHack.resetZoom()
        zoomValue = 800.0
    end

    valueChanged, zoomValue = ImGui.SliderFloat("Zoom Value##zoom_value", zoomValue, 0.0, 20000)

    if valueChanged then
    	ZoomHack.setZoom(zoomValue)
    end

    ImGui.End()
end