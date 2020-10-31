GUI = { }

function GUI.Draw()    
    ImGui.Begin("DPSMeter")
        
    ImGui.SetWindowSize(ImVec2(300,500))
      
    if ImGui.SmallButton("Reset") then
    	DPSMeter.ValueCache:reset()
    end

    DPSMeter.ValueCache:drawStats()
      
    DPSMeter.ValueCache:drawLog()

    ImGui.End()
end