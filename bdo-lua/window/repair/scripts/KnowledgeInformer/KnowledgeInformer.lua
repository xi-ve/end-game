KnowledgeInformer = { }
KnowledgeInformer.Running = false

KnowledgeInformer.Settings = Settings()

function KnowledgeInformer.Start()
	KnowledgeInformer.LoadSettings()

  	KnowledgeInformer.Running = true	    
end

function KnowledgeInformer.Stop()
  KnowledgeInformer.Running = false  

  KnowledgeInformer.SaveSettings()
end

function KnowledgeInformer.OnPulse()
  if KnowledgeInformer.Running == false then
    return
  end
end

function KnowledgeInformer.draw_StaticFilters()

  for k,v in pairs(MainWindow.ESP_StaticFilters) do
    
    RenderHelper.DrawWorldSquare(v.Pos, 100, "FFFF0000", 4, false)
    RenderHelper.DrawWorldText(v.Name, 30, "FFFFFFFF", v.Pos, 0, 0)
  end
end

function KnowledgeInformer.OnRenderD2D()
  KnowledgeInformer.draw_StaticFilters()
end

function KnowledgeInformer.OnGuiDraw()
	--MainWindow.DrawMainWindow()
  MainWindow.DrawMainWindowNew()
end

function KnowledgeInformer.SaveSettings()
    local json = JSON:new()
    Infinity.FileSystem.WriteFile("Settings.json", json:encode_pretty(KnowledgeInformer.Settings))
end

function KnowledgeInformer.LoadSettings()
    local json = JSON:new()
    KnowledgeInformer.Settings = Settings()
    
    table.merge(KnowledgeInformer.Settings, json:decode(Infinity.FileSystem.ReadFile("Settings.json")))    
end