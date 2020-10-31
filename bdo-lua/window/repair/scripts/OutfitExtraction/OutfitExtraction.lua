OutfitExtraction = { }
OutfitExtraction.Running = false

function OutfitExtraction.Start()
  OutfitExtraction.Running = true
	    
end

function OutfitExtraction.Stop()
  OutfitExtraction.Running = false  
end

function OutfitExtraction.OnPulse()
  if OutfitExtraction.Running == false then
    return
  end
end

function OutfitExtraction.OnRenderD2D()
end

function OutfitExtraction.OnGuiDraw()
	MainWindow.DrawMainWindow()
end

function OutfitExtraction.extract_allCronStones()
	for i = 2, 193 do
        if CashInventory.hasItemWrapper(i) and not CashInventory.getIsBound(i) then
            if CashInventory.getExtraction_CronCount(i) > 0 then
              Infinity.BDO.Lua.Execute("ToClient_RequestExtracItemFromExtractionCount(17, " .. i .. ", false)")
            end
        end
    end
end