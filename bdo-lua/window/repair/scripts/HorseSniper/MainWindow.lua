MainWindow = { }

MainWindow.Horse_SkillNames = {}
MainWindow.Horse_SkillIndexies = {}
local selected_HorseSkillIndex = 1

MainWindow.Horse_TierNames = {"Any", "T1", "T2", "T3", "T4", "T5", "T6", "T7", "T8", "T9"}
MainWindow.Horse_TierIndexies = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9}
local selected_HorseTierIndex = 1

MainWindow.Horse_GenderNames = {"Any", "Female", "Male"}
MainWindow.Horse_GenderIndexies = {2, 1, 0}
local selected_HorseGenderIndex = 1

local newFilter_Skills = {}
local newFilter_onlyCourser = false

function MainWindow.DrawMainWindow() 
    local valueChanged = false

    ImGui.Begin("HorseSniper")
            
    ImGui.SetWindowSize(ImVec2(500,500), ImGuiCond_FirstUseEver)   
	
    local btnText = "Start"

    if HorseSniper.Running == true then
        btnText = "Stop"
    end

    if ImGui.Button(btnText) then
        if HorseSniper.Running == true then
            HorseSniper.StopBot()
        else
            HorseSniper.StartBot()
        end
    end
	    
    --[[if ImGui.Button("Test Load") then

    	if HorseSniper.Packet_GetAuctionGoods.init_PacketStruct then

    		local packet = GetAuctionGoodsReq(HorseSniper.Packet_GetAuctionGoods.size, HorseSniper.Packet_GetAuctionGoods.opCode, HorseSniper.Packet_GetAuctionGoods.o_auctionRegisterType, HorseSniper.Packet_GetAuctionGoods.o_skillFilter, HorseSniper.Packet_GetAuctionGoods.o_tierFilter, HorseSniper.Packet_GetAuctionGoods.o_pageIndex, HorseSniper.Packet_GetAuctionGoods.o_npcActorKey, HorseSniper.Packet_GetAuctionGoods.o_genderFilter)

    		packet:construct(Statics.Enums.EAuctionRegisterType.ServantMarket, 0, 3, 0, Utils.findNpc_StableShop():getActorKey(), 2).Packet:send()
    	end
    end]]--

    if ImGui.CollapsingHeader("New Filter##id_new_filter") then

        _, selected_HorseSkillIndex = ImGui.Combo("Horse Skills##id_horse_skills", selected_HorseSkillIndex, MainWindow.Horse_SkillNames)

        ImGui.SameLine()

        if ImGui.SmallButton("Add Skill") then

            local canAdd = true

            for k,v in pairs(newFilter_Skills) do
                
                if v.Index == MainWindow.Horse_SkillIndexies[selected_HorseSkillIndex] then

                    canAdd = false
                    break
                end
            end

            if canAdd then

                table.insert(newFilter_Skills, {Name = MainWindow.Horse_SkillNames[selected_HorseSkillIndex], Index = MainWindow.Horse_SkillIndexies[selected_HorseSkillIndex]})
            end
        end

        _, newFilter_onlyCourser = ImGui.Checkbox("only Courser##id_courser_only", newFilter_onlyCourser)

        for k,skill in pairs(newFilter_Skills) do
            
            if ImGui.SmallButton("X##skill_remove_" .. k) then

                table.remove(newFilter_Skills, k)
                break
            end

            ImGui.SameLine()

            ImGui.Text(skill.Name)
        end

        _, selected_HorseTierIndex = ImGui.Combo("Horse Tiers##id_horse_tiers", selected_HorseTierIndex, MainWindow.Horse_TierNames)
        _, selected_HorseGenderIndex = ImGui.Combo("Horse Genders##id_horse_genders", selected_HorseGenderIndex, MainWindow.Horse_GenderNames)

        if ImGui.Button("Create New Filter") then

            if table.length(newFilter_Skills) == 0 then
                newFilter_Skills[1] = {Name = "Any", Index = 0}
            end

            table.insert(HorseSniper.Settings.Filters, {TierName = MainWindow.Horse_TierNames[selected_HorseTierIndex], TierIndex = MainWindow.Horse_TierIndexies[selected_HorseTierIndex], GenderName = MainWindow.Horse_GenderNames[selected_HorseGenderIndex], GenderIndex = MainWindow.Horse_GenderIndexies[selected_HorseGenderIndex], Skills = newFilter_Skills, Courser = newFilter_onlyCourser})

            HorseSniper.Stop()

            newFilter_Skills = {}
            newFilter_onlyCourser = false
            selected_HorseGenderIndex = 1
            selected_HorseTierIndex = 1
            selected_HorseSkillIndex = 1
            valueChanged = true
        end
    end

    if ImGui.CollapsingHeader("Existing Filters##id_existing_filters") then

        for k,filter in pairs(HorseSniper.Settings.Filters) do
           
            if ImGui.SmallButton("X##filter_remove_" .. k) then

                table.remove(HorseSniper.Settings.Filters, k)
                valueChanged = true
                break
            end

            ImGui.SameLine()

            ImGui.Text("Tier: " .. filter.TierName .. " Gender: " .. filter.GenderName .. " OnlyCourser: " .. tostring(filter.Courser) .. " Skills: " .. MainWindow.skillTableToString(filter.Skills)) 
        end
    end

    if valueChanged == true then
        HorseSniper.SaveSettings()
    end

    ImGui.End()
end

function MainWindow.loadHorseSkills()
    MainWindow.Horse_SkillNames = GoodsAuction.getHorseMarketSkillsNames()
    MainWindow.Horse_SkillIndexies = GoodsAuction.getHorseMarketSkillsIndexies()
end

function MainWindow.skillTableToString(table)
    local s = ""

    for k,v in pairs(table) do
        if s:len() == 0 then
            s = v.Name
        else
            s = s .. ", " .. v.Name
        end
    end

    return s
end

MainWindow.loadHorseSkills()