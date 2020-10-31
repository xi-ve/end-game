MainWindow = { }

MainWindow.Cards = {}

local onlyMissing = false
local showBlacklisted = false
local filterName = [[]]

local mainThemes = Infinity.BDO.Datasheets.MentalThemeStaticStatusManager.getMainMentalThemes()

MainWindow.ESP_StaticFilters = {}

function MainWindow.DrawMainWindowNew()
    ImGui.Begin("KnowledgeInformer")

    ImGui.SetWindowSize(ImVec2(1000,500), ImGuiCond_FirstUseEver)

    MainWindow.treeView_ChildThemes(mainThemes)
    
    ImGui.End()
end

function MainWindow.getCardLevelAsText(card)
    if card:getCardLevel() == 5 then
        return "S"
    elseif card:getCardLevel() == 4 then
        return "A+"
    elseif card:getCardLevel() == 3 then
        return "A"
    elseif card:getCardLevel() == 2 then
        return "B"
    elseif card:getCardLevel() == 1 then
        return "C"
    end
end

function MainWindow.getColorByCardLevel(card)
    local color_C = ImVec4(0.80, 0.80, 0.80, 1.00)
    local color_B = ImVec4(1.00, 1.00, 1.00, 1.00)
    local color_A = ImVec4(0.35, 0.65, 0.09, 1.00)
    local color_AA = ImVec4(0.90, 0.38, 0.00, 1.00)
    local color_S = ImVec4(0.90, 0.82, 0.00, 1.00)

    if card:getCardLevel() == 5 then
        return color_S
    elseif card:getCardLevel() == 4 then
        return color_AA
    elseif card:getCardLevel() == 3 then
        return color_A
    elseif card:getCardLevel() == 2 then
        return color_B
    elseif card:getCardLevel() == 1 then
        return color_C
    end
end

function MainWindow.functions_NavTo(pos)

    local code = string.format(
                [[
                ToClient_DeleteNaviGuideByGroup(0)
                local target = float3(%f, %f, %f)
                local key = ToClient_WorldMapNaviStart( target, NavigationGuideParam(), false, false )
                local selfPlayer = getSelfPlayer():get()
                selfPlayer:setNavigationMovePath(key)
                selfPlayer:checkNaviPathUI(key)
                ]], pos.X, pos.Y, pos.Z)

    Infinity.BDO.Lua.Execute(code)
end

function MainWindow.display_CardDetails(mentalObjectCard, mentalCardStaticStatus)

    if ImGui.TreeNodeEx(" ##card_details_" .. mentalCardStaticStatus:getName(), ImGuiTreeNodeFlags_Bullet) then

        --local adr = "0x" .. tostring(mentalCardStaticStatus.address)
        --ImGui.InputText("Adr##card_details_adr_" .. mentalCardStaticStatus:getName(), adr)

        local pos = nil

        if mentalCardStaticStatus:hasPosition() then
            pos = mentalCardStaticStatus:getPosition()
        end

        if pos ~= nil then

            ImGui.Text("X: " .. pos.X .. " Y: " .. pos.Y .. " Z: " .. pos.Z)
            ImGui.Text("Distance: " .. Infinity.BDO.getLocalPlayer():getPosition():getDistance(pos))
            
            if ImGui.SmallButton("NavTo##card_details_nav_to_" .. mentalCardStaticStatus:getName()) then

                MainWindow.functions_NavTo(pos)
            end

            if ImGui.SmallButton("add to ESP StaticFilter##card_details_esp_static_filter_" .. mentalCardStaticStatus:getName()) then

                table.insert(MainWindow.ESP_StaticFilters, {Name = mentalCardStaticStatus:getName(), Pos = pos})
            end
        end    

        ImGui.TreePop() 
    end
end

function MainWindow.display_Cards(cards, theme)

    for k, mentalCardStaticStatus in pairs(cards) do
                
        local mentalObjectCard = Infinity.BDO.getLocalPlayer():getMentalObjectCard(mentalCardStaticStatus:getCardId())
        
        if mentalObjectCard ~= nil and mentalObjectCard:hasCard() then

            ImGui.TextColored(MainWindow.getColorByCardLevel(mentalObjectCard), "[" .. MainWindow.getCardLevelAsText(mentalObjectCard) .. "] " .. mentalCardStaticStatus:getName())
        else

            ImGui.TextDisabled(mentalCardStaticStatus:getName())
        end

        ImGui.SameLine()

        MainWindow.display_CardDetails(mentalObjectCard, mentalCardStaticStatus)
    end
end

function MainWindow.getThemeCardProgress(theme)

    if theme:getCardsCount() <= 0 then
        return ""
    end

    local totalCards = theme:getCardsCount()
    local finishedCards = 0

    for k, mentalCardStaticStatus in pairs(theme:getCards()) do
        
        local mentalObjectCard = Infinity.BDO.getLocalPlayer():getMentalObjectCard(mentalCardStaticStatus:getCardId())

        if mentalObjectCard ~= nil and mentalObjectCard:hasCard() then

            finishedCards = finishedCards + 1
        end
    end

    return " " .. finishedCards .. "/" .. totalCards
end

function MainWindow.treeView_ChildThemes(themes)

    for k,theme in pairs(themes) do
        
        local cardProgress = MainWindow.getThemeCardProgress(theme)

        if theme:getChildThemesCount() > 0 or theme:getCardsCount() > 0 then

            if ImGui.TreeNode(theme:getName() .. cardProgress .. "##theme_" .. theme:getName() .. "_" .. k) then

                if theme:getChildThemesCount() > 0 then
                    MainWindow.treeView_ChildThemes(theme:getChildThemes())
                end

                if theme:getCardsCount() > 0 then                
                    MainWindow.display_Cards(theme:getCards(), theme)
                end

                ImGui.TreePop()
            end
        end
    end
end

function MainWindow.DrawMainWindow()
    local valueChanged = false

    ImGui.Begin("KnowledgeInformer")

    ImGui.SetWindowSize(ImVec2(1000,500), ImGuiCond_FirstUseEver)

    if ImGui.Button("Refresh") then
        MainWindow.loadKnowledgeTable()
    end

    _, onlyMissing = ImGui.Checkbox("only Missing##show_only_missing", onlyMissing)
    ImGui.SameLine()
    _, showBlacklisted = ImGui.Checkbox("Blacklisted##show_blacklisted", showBlacklisted)
    ImGui.SameLine()
    _, filterName = ImGui.InputText("Filter by Name##filter_name", filterName)

    ImGui.Columns(4)
    ImGui.SetColumnWidth(0,400)
    ImGui.SetColumnWidth(1,60)
    ImGui.SetColumnWidth(2,80)
    ImGui.SetColumnWidth(3,450)

    ImGui.Text("Name")
    ImGui.NextColumn()
    ImGui.Text("CardId")
    ImGui.NextColumn()
    ImGui.Text("MainTheme")
    ImGui.NextColumn()
    ImGui.Text("Position")
    ImGui.NextColumn()

    for k,card in pairs(MainWindow.Cards) do
        
        local canShow = true
        local isBlacklisted = MainWindow.isBlacklisted(card.CardId)

        if onlyMissing and card.HasCard then
            canShow = false
        end

        if filterName ~= "" and string.find(card.Name, filterName) == nil then
            canShow = false
        end

        if not showBlacklisted and isBlacklisted then
            canShow = false
        end

        if canShow then

            if isBlacklisted then
                ImGui.PushStyleColor2(ImGuiCol_Text, ImVec4(0.5, 0.1, 0, 1))
            end

            ImGui.Text(card.Name)
            ImGui.NextColumn()
            ImGui.Text(card.CardId)
            ImGui.NextColumn() 
            ImGui.Text(card.MainTheme)
            ImGui.NextColumn()

            ImGui.Text("Distance: " .. card.Distance)

            if isBlacklisted then
                ImGui.PopStyleColor(1)
            end

            ImGui.SameLine()

            if ImGui.SmallButton("Find##find_k_" .. k) then
                local code = string.format(
                [[
                ToClient_DeleteNaviGuideByGroup(0)
                local target = float3(%f, %f, %f)
                local key = ToClient_WorldMapNaviStart( target, NavigationGuideParam(), false, false )
                local selfPlayer = getSelfPlayer():get()
                selfPlayer:setNavigationMovePath(key)
                selfPlayer:checkNaviPathUI(key)
                ]], card.Position.X, card.Position.Y, card.Position.Z)

                Infinity.BDO.Lua.Execute(code)
            end

            ImGui.SameLine()

            if not isBlacklisted then
                if ImGui.SmallButton("Blacklist##blacklist_k_" .. k) then

                    table.insert(KnowledgeInformer.Settings.Blacklist, card.CardId)
                    valueChanged = true
                    break
                end
            else
                if ImGui.SmallButton("De-Blacklist##de-blacklist_k_" .. k) then

                    MainWindow.removeBlacklist(card.CardId)
                    valueChanged = true
                    break
                end
            end

            ImGui.NextColumn()         
        end
    end    

    ImGui.Columns(1)    

    ImGui.End()

    if valueChanged then
        KnowledgeInformer.SaveSettings()
    end
end

function MainWindow.removeBlacklist(cardId)
    for k,v in pairs(KnowledgeInformer.Settings.Blacklist) do
        if v == cardId then
            table.remove(KnowledgeInformer.Settings.Blacklist, k)
            break
        end
    end
end

function MainWindow.isBlacklisted(cardId)
    return table.find(KnowledgeInformer.Settings.Blacklist, cardId) ~= nil
end

function MainWindow.loadKnowledgeTable()
    local cards = {}

    for cardId, cardData in pairs(g_KnowledgeTable) do
        
        local hasCard = Knowledge.hasCard(cardId, cardData.MainTheme)

        if hasCard ~= nil then

            table.insert(cards, {CardId = cardId, MainTheme = cardData.MainTheme, HasCard = hasCard, Name = Knowledge.getCardName(cardId, cardData.MainTheme), Position = cardData.Position, Distance = cardData.Position:getDistance(Infinity.BDO.getLocalPlayer():getPosition())})
        end
    end

    table.sort(cards, function(a, b) return a.Distance < b.Distance end)

    MainWindow.Cards = cards
end

MainWindow.loadKnowledgeTable()