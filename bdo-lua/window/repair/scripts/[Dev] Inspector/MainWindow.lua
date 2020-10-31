MainWindow = { }
MainWindow.ActorTypes = {"All", "Player", "Monster", "Npc", "Vehicle", "Gate", "Alterego", "Collect", "Household", "Installation", "Deadbody", "Unknown0", "Unknown1", "Loot", "Unknown2"}

local Filter_StringTable_Name = ""
local Filter_Actors_Name = ""

local Filter_Datasheet_CharacterStaticStatus_Name = ""
local Filter_Datasheet_CharacterStaticStatus_ActorId = ""
local Filter_Datasheet_CharacterStaticStatus_MinLevel = 0
local Filter_Datasheet_CharacterStaticStatus_MaxLevel = 99

local Filter_SystemVars_Name = ""

local Filter_ActionPack_ActionBranch = ""

local PcPackageRaw_ActionBranches = {}
local Filter_PcPackageRaw_ActionBranches = ""

local PcPackageRaw_PackageMaps = {}
local Filter_PcPackageRaw_Search_ActionChart = ""
local PcPackageRaw_PackageMaps_Found_ActionCharts = {}

local BinaryDatasheetFiles = nil

local Cached_SectorScenes_All = nil
local Cached_SectorScenes_Nearby = nil
local Cached_SectorScenes_Loaded = nil

function MainWindow.sortActorTableByDistance(t)
    local tt = {}

    for k,v in pairs(t) do
        table.insert(tt, v)
    end

    table.sort(tt, function(a, b) return a:getPosition():getDistance(Infinity.BDO.getLocalPlayer():getPosition()) < b:getPosition():getDistance(Infinity.BDO.getLocalPlayer():getPosition()) end)

    return tt
end

function MainWindow.DrawMainWindow()
    ImGui.Begin("Inspector")
        
    ImGui.SetWindowSize(ImVec2(500,500), ImGuiCond_FirstUseEver)
        
    local lpPos = Infinity.BDO.getLocalPlayer():getPosition()

    if ImGui.CollapsingHeader("LocalPlayer##id_localplayer") then
    	ImGui.Text("Current Action: " .. Infinity.BDO.getLocalPlayer():getCharacterControler():getCurrentAnimation():getName())

        local nextAction = Infinity.BDO.getLocalPlayer():getCharacterControler():getNextAction()

        if nextAction ~= nil then            
    	   ImGui.Text("Next Action: " .. nextAction)
        else
            ImGui.Text("Next Action: None")
        end

        ImGui.Text("Position: (X: " .. lpPos.X .. " Y: " .. lpPos.Y .. " Z: " .. lpPos.Z .. ")")
        ImGui.Text("Rotation: " .. Infinity.BDO.getLocalPlayer():getCharacterControler():getCharacterScene():getRotation())

        local myVehicle = Infinity.BDO.getMyVehicle()

        if ImGui.TreeNode("Current ActionPack##localplayer_actionpack") then
          
          local actionPack = Infinity.BDO.getLocalPlayer():getCharacterControler():getCurrentActionPack()
          
          ImGui.InputText("Adr##actionpack_details_adr", string.format("0x%02X", actionPack.address:getUnsafe()))

          ---ImGui.Text("ActionHash: " .. actionPack:getActionHash())

          local aHash = actionPack:getActionHash()
          ImGui.InputText("ActionHash##actionpack_details_actionbranch_actionhash", aHash)

          _, Filter_ActionPack_ActionBranch = ImGui.InputText("Filter ActionBranch##actionpack_filter_actionbranch", Filter_ActionPack_ActionBranch)

          if ImGui.TreeNode("List Package0##actionpack_list_package0") then

            for kp,p in pairs(actionPack:getList_Package0()) do

              if ImGui.TreeNode(kp .. "##actionpack_list_package0_entry_" .. kp) then
                
                ImGui.InputText("Adr##actionpack_list_package0_entry_adr_" .. kp, string.format("0x%02X", p.address:getUnsafe()))

                if ImGui.TreeNode("List Values##actionpack_list_package0_list_values_" .. kp) then

                  for kv,vv in pairs(p:getValueList()) do

                    ImGui.Text(vv)
                  end

                  ImGui.TreePop()
                end

                if ImGui.TreeNode("List ActionBranches##actionpack_list_package0_list_actionbranches_" .. kp) then

                  for kab,ab in pairs(p:getActionBranches()) do

                    local shouldShow = true

                    if Filter_ActionPack_ActionBranch ~= "" and string.find(ab:getExecute():lower(), Filter_ActionPack_ActionBranch:lower()) == nil then

                      shouldShow = false
                    end

                    if shouldShow then

                      MainWindow.populateActionBranch(ab, kab)
                    end
                  end

                  ImGui.TreePop()
                end

                ImGui.TreePop()
              end
            end

            ImGui.TreePop()
          end

          if ImGui.TreeNode("List ActionBranches##actionpack_list_actionbranches") then

            for kab,ab in pairs(actionPack:getActionBranches()) do

              local shouldShow = true

                if Filter_ActionPack_ActionBranch ~= "" and string.find(ab:getExecute():lower(), Filter_ActionPack_ActionBranch:lower()) == nil then

                  shouldShow = false
                end

              if shouldShow then

                MainWindow.populateActionBranch(ab, kab)
              end
            end

            ImGui.TreePop()
          end

          if ImGui.TreeNode("ActionChart##actionpack_actionchart") then

            MainWindow.populateActionChart(actionPack:getActionChart(), "current_actionpackage_actionchart")

            ImGui.TreePop()
          end

          ImGui.TreePop()
        end

        if ImGui.TreeNode("PCPackageRaw##localplayer_pcpackageraw") then

          if ImGui.TreeNode("ActionBranches##localplayer_pcpackageraw_actionbranches") then

            if ImGui.SmallButton("Reload##pcpackageraw_actionbranches_reload") then
              PcPackageRaw_ActionBranches = Infinity.BDO.ActionBranchManager.getPCPackageRaw_ActionBranches()
            end

            _, Filter_PcPackageRaw_ActionBranches = ImGui.InputText("Filter##pcpackageraw_filter_actionbranch", Filter_PcPackageRaw_ActionBranches)

            for pprI,pprAB in pairs(PcPackageRaw_ActionBranches) do
              
              local shouldShow = true

              if Filter_PcPackageRaw_ActionBranches ~= "" and string.find(pprAB:getExecute():lower(), Filter_PcPackageRaw_ActionBranches:lower()) == nil then

                shouldShow = false
              end

              if shouldShow then

                MainWindow.populateActionBranch(pprAB, pprI)
              end              
            end

            ImGui.TreePop()
          end

          if ImGui.TreeNode("PackageMaps##localplayer_pcpackageraw_packagemaps") then

            if ImGui.TreeNode("Search ActionChart##localplayer_pcpackageraw_packagemaps_search_actionchart") then

              _, Filter_PcPackageRaw_Search_ActionChart = ImGui.InputText("Filter##pcpackageraw_filter_search_actionchart", Filter_PcPackageRaw_Search_ActionChart)

              if ImGui.SmallButton("Search by Name##search_actionchart_by_name") then
                
                PcPackageRaw_PackageMaps_Found_ActionCharts = MainWindow.getActionChartsByName(Filter_PcPackageRaw_Search_ActionChart)
              end

              ImGui.SameLine()

              if ImGui.SmallButton("Search by SkillId##search_actionchart_by_skillid") then
                
                PcPackageRaw_PackageMaps_Found_ActionCharts = MainWindow.getActionChartsBySkillId(Filter_PcPackageRaw_Search_ActionChart)
              end

              for faci,fActionChart in pairs(PcPackageRaw_PackageMaps_Found_ActionCharts) do
                
                MainWindow.populateActionChart(fActionChart, faci)
              end

              ImGui.TreePop()
            end
            
            if ImGui.SmallButton("Reload##pcpackageraw_packagemaps_reload") then
              PcPackageRaw_PackageMaps = Infinity.BDO.ActionBranchManager.getPCPackageRaw_PackageMaps()
            end

            for pmi,packagemap in pairs(PcPackageRaw_PackageMaps) do
              
              MainWindow.populatePackageMap(packagemap, pmi)
            end
            
            ImGui.TreePop()
          end
          ImGui.TreePop()
        end

        if ImGui.TreeNode("ActionScripts##localplayer_actionscripts") then

          for k,actionScript in pairs(Infinity.BDO.ActionScriptManager.getActionScripts()) do
            
            MainWindow.populateActionScript(actionScript, k)
          end

          ImGui.TreePop()
        end

        if myVehicle ~= nil then

            if ImGui.TreeNode("Current Vehicle##id_currentvehicle") then

                local cvPos = myVehicle:getPosition()

                ImGui.Text("AnimationName: ")
                ImGui.SameLine()
                ImGui.Text(myVehicle:getCharacterControler():getCurrentAnimation():getName()) 
        
                ImGui.Text("Position: (X: " .. cvPos.X .. " Y: " .. cvPos.Y .. " Z: " .. cvPos.Z .. ")")
                ImGui.Text("Rotation: " .. myVehicle:getCharacterControler():getCharacterScene():getRotation())

              ImGui.TreePop()
            end
        end        
   	end
    
    if ImGui.CollapsingHeader("UI##id_ui") then
        
        ImGui.Text("Name (Last Interaction): " .. Inspector.UIElement_Name_LastInteraction)
    end

    if ImGui.CollapsingHeader("Camera##id_camera") then
        
        local cameraManager = Infinity.BDO.getCameraManager()

        ImGui.Text("Roll: " .. cameraManager:getRoll())
        ImGui.Text("Pitch: " .. cameraManager:getPitch())
        ImGui.Text("Yaw: " .. cameraManager:getYaw())
    end

    if ImGui.CollapsingHeader("Actors##id_actors") then

        _, Filter_Actors_Name = ImGui.InputText("Filter by Name##filter_actors_name", Filter_Actors_Name)

    	for kT,vT in pairs(MainWindow.ActorTypes) do

    		if ImGui.TreeNode(vT .. "##id_actortype_" .. kT) then
                
                local aList = MainWindow.sortActorTableByDistance(Infinity.BDO.getActorList(kT - 2))
                
    			for kA,vA in pairs(aList) do
    				
                    local shouldShow = true

                    if not vA:isValid() then
                      shouldShow = false
                    else

                      if Filter_Actors_Name ~= "" and string.find(vA:getName(), Filter_Actors_Name) == nil then
                          shouldShow = false
                      end
                    end

                    if shouldShow then
                        local adr = string.format("0x%02X", vA.address:getUnsafe())
                        local css = Infinity.BDO.Datasheets.CharacterStaticStatusManager.getCharacterStaticStatus(vA:getActorId())
                        local cssAdr = ""

                        if css ~= nil then
                          cssAdr = string.format("0x%02X", css.address:getUnsafe())
                        end

    				            ImGui.Text(vA:getName() .. " ActorId: " .. vA:getActorId() .. " ActorKey: " .. vA:getActorKey() .. " Distance: " .. vA:getPosition():getDistance(lpPos)) -- .. " CharacterGrade: " .. vA:getCharacterGrade() .. " TribeType: " .. vA:getTribeType() .. " IsAttackable: " .. tostring(TargetHelper.isAttackable(vA)))

                        ImGui.SameLine()

                        if ImGui.TreeNode("Details##actor_details_" .. kA) then

                            local currentAction = vA:getCharacterControler():getCurrentAnimation():getName()

                            ImGui.Text("isValid: " .. tostring(vA:isValid()))
                            ImGui.Text("isAttackable: " .. tostring(TargetHelper.isAttackable(vA)))
                            ImGui.Text("Action: " .. currentAction)
                            ImGui.Text("HP: " .. vA:getHp())
                            ImGui.Text("MaxHP: " .. vA:getMaxHp())
                            ImGui.Text("MP: " .. vA:getMp())
                            ImGui.Text("MaxMP: " .. vA:getMaxMp())
                            ImGui.Text("isDead: " .. tostring(vA:getIsDead()))

                            ImGui.InputText("Adr##actor_adr_" .. kA, adr)
                            ImGui.InputText("CSSAdr##actor_cssadr_" .. kA, cssAdr)
                            
                            ImGui.TreePop()
                        end                        
                    end
    			end

          ImGui.TreePop()
    		end
    	end
    end	

    if ImGui.CollapsingHeader("DataSheets##id_datasheets") then

      if ImGui.TreeNode("CharacterStaticStatus##datasheets_CharacterStaticStatus") then

        _, Filter_Datasheet_CharacterStaticStatus_Name = ImGui.InputText("Filter Name##datasheets_CharacterStaticStatus_filter_name", Filter_Datasheet_CharacterStaticStatus_Name)
        _, Filter_Datasheet_CharacterStaticStatus_ActorId = ImGui.InputText("Filter ActorId##datasheets_CharacterStaticStatus_filter_actorid", Filter_Datasheet_CharacterStaticStatus_ActorId)
        _, Filter_Datasheet_CharacterStaticStatus_MinLevel = ImGui.SliderInt("Filter MinLvL##datasheets_CharacterStaticStatus_filter_minlvl", Filter_Datasheet_CharacterStaticStatus_MinLevel, 0, 99)
        _, Filter_Datasheet_CharacterStaticStatus_MaxLevel = ImGui.SliderInt("Filter MaxLvL##datasheets_CharacterStaticStatus_filter_maxlvl", Filter_Datasheet_CharacterStaticStatus_MaxLevel, 0, 99)

        for actorId, characterStaticStatus in pairs(Infinity.BDO.Datasheets.CharacterStaticStatusManager.getList_CharacterStaticStatus()) do
          
          local shouldShow = true

          if Filter_Datasheet_CharacterStaticStatus_Name ~= "" and string.find(characterStaticStatus:getName(), Filter_Datasheet_CharacterStaticStatus_Name) == nil then
            shouldShow = false
          end

          if Filter_Datasheet_CharacterStaticStatus_ActorId ~= "" and string.find(tostring(characterStaticStatus:getCharacterKey()), Filter_Datasheet_CharacterStaticStatus_ActorId) == nil then
            shouldShow = false
          end

          if characterStaticStatus:getLevel() < Filter_Datasheet_CharacterStaticStatus_MinLevel then
            shouldShow = false
          end

          if characterStaticStatus:getLevel() > Filter_Datasheet_CharacterStaticStatus_MaxLevel then
            shouldShow = false
          end

          if shouldShow then

            ImGui.Text(characterStaticStatus:getName() .. " (" .. characterStaticStatus:getCharacterKey() .. ")")
            
            ImGui.SameLine()

            if ImGui.TreeNode("Details##datasheets_CharacterStaticStatus_details_" .. actorId) then
             
              ImGui.InputText("Adr##datasheets_CharacterStaticStatus_details_" .. actorId, string.format("0x%02X", characterStaticStatus.address:getUnsafe()))
                      
              ImGui.Text("Level: " .. characterStaticStatus:getLevel())
              ImGui.Text("Karma: " .. characterStaticStatus:getKarma())
              ImGui.Text("ActionScript: " .. characterStaticStatus:getActionScript())
              ImGui.Text("ActiveCondtion: " .. characterStaticStatus:getActiveCondition())

              ImGui.TreePop()
            end     
          end
        end               
                            
        ImGui.TreePop()
      end         
    end 

    if ImGui.CollapsingHeader("BinaryDataManager##id_binarydatamanager") then

      if ImGui.TreeNode("Datasheets##binarydatamanager_datasheets") then      

      if Infinity.BDO.BinaryDataManager.isParsingMetaFile() then
        ImGui.Text("Parsing MetaFile...")
      else
       
        if BinaryDatasheetFiles == nil then
          BinaryDatasheetFiles = Infinity.BDO.BinaryDataManager.getBinaryDatasheetFiles()
        end

        for k,v in pairs(BinaryDatasheetFiles) do
          
          ImGui.Text(v:getFileName())
          ImGui.SameLine()

          if not v:getIsExtracted() then            

            if ImGui.SmallButton("Mem Load##b_file_mem_load_" .. k) then
              v:extract()
            end
          else

            if ImGui.SmallButton("Inspect##b_file_inspect_" .. k) then

              BinaryDataInspector.Data = v:getFileData()
              BinaryDataInspector.FileName = v:getFileName()
              BinaryDataInspector.Draw = true
            end
          end
        end
      end

      ImGui.TreePop()
      end
    end

    if ImGui.CollapsingHeader("ServerChannels##id_serverchannels") then

      local lastChannelNo = Infinity.BDO.getServerChannelManager():getLastChannelNo()
      local currentWorld = Infinity.BDO.getServerChannelManager():getCurrentWorld()

      ImGui.Text("LastChannelNo: " .. lastChannelNo)

      if ImGui.TreeNode(currentWorld:getName() .. "##world_" .. currentWorld:getName()) then                    
               
        ImGui.Text("WorldNo: " .. currentWorld:getWorldNo())

        local channels = currentWorld:getChannels();

        if ImGui.TreeNode("Channels##world_channels_" .. currentWorld:getName()) then                    
               
          for cIndex,channel in pairs(channels) do
            
            if ImGui.TreeNode(channel:getName() .. "##world_channels_channel_" .. cIndex) then      
              
              ImGui.InputText("Adr##world_channels_channel_adr_" .. cIndex, string.format("0x%02X", channel.address:getUnsafe()))

              ImGui.Text("ChannelNo: " .. channel:getChannelNo())
              ImGui.Text("WorldNo: " .. channel:getWorldNo())
              ImGui.Text("ServerGroupNo: " .. channel:getServerGroupNo())
              ImGui.Text("CharacterCount: " .. channel:getCharacterCount())
              ImGui.Text("DeleteCount: " .. channel:getDeleteCount())
              ImGui.Text("RestrictedServerNo: " .. channel:getRestrictedServerNo())
              ImGui.Text("BattleExp: " .. channel:getBattleExp())
              ImGui.Text("ItemDrop: " .. channel:getItemDrop())
              ImGui.Text("VehicleExp: " .. channel:getVehicleExp())
              ImGui.Text("SkillExp: " .. channel:getSkillExp())

              ImGui.Text("isCreatable: " .. tostring(channel:isCreatable()))
              ImGui.Text("isMain: " .. tostring(channel:isMain()))
              ImGui.Text("isSiegeBeing: " .. tostring(channel:isSiegeBeing()))
              ImGui.Text("isVillageSiege: " .. tostring(channel:isVillageSiege()))
              ImGui.Text("isSpeedChannel: " .. tostring(channel:isSpeedChannel()))
              ImGui.Text("isBalanceChannel: " .. tostring(channel:isBalanceChannel()))
              ImGui.Text("isPcRoomChannel: " .. tostring(channel:isPcRoomChannel()))
              ImGui.Text("isSteamChannel: " .. tostring(channel:isSteamChannel()))
              ImGui.Text("isPremiumChannel: " .. tostring(channel:isPremiumChannel()))
              ImGui.Text("isSiegeChannel: " .. tostring(channel:isSiegeChannel()))
              ImGui.Text("isInstanceChannel: " .. tostring(channel:isInstanceChannel()))
              ImGui.Text("isDontPcPTendencyDecrease: " .. tostring(channel:isDontPcPTendencyDecrease()))
              ImGui.Text("isAdultWorld: " .. tostring(channel:isAdultWorld()))
              ImGui.Text("isSeasonChannel: " .. tostring(channel:isSeasonChannel()))
              ImGui.Text("isClosed: " .. tostring(channel:isClosed()))

              ImGui.TreePop()
            end
          end

          ImGui.TreePop()
        end      

        ImGui.TreePop()
      end         
    end

    if ImGui.CollapsingHeader("SceneManager##id_scenemanager") then

      local sceneManager = Infinity.BDO.getSceneManager()
      
      local sectorX = sceneManager:getMapSectorX()
      local sectorY = sceneManager:getMapSectorY()
      local sectorZ = sceneManager:getMapSectorZ()

      ImGui.Text("Sector X: " .. sectorX .. " Y: " .. sectorY .. " Z: " .. sectorZ)

      if ImGui.TreeNode("Render Settings##scenemanager_render_settings") then

        __, Inspector.RenderSettings_Scenes_ShowBox = ImGui.Checkbox("Scene -> Show Box##settings_scene_showbox", Inspector.RenderSettings_Scenes_ShowBox) 
        __, Inspector.RenderSettings_Scenes_ShowMesh = ImGui.Checkbox("Scene -> Show Mesh##settings_scene_showmesh", Inspector.RenderSettings_Scenes_ShowMesh)
        __, Inspector.RenderSettings_Objects_DistanceLimit_Trigger = ImGui.Checkbox("Object -> Distance Limit##settings_object_distancelimit", Inspector.RenderSettings_Objects_DistanceLimit_Trigger)          
        __, Inspector.RenderSettings_Objects_DistanceLimit_Value = ImGui.SliderFloat("Dist##settings_object_distancelimit_value", Inspector.RenderSettings_Objects_DistanceLimit_Value, 50, 12800)

        ImGui.TreePop()
      end

      if ImGui.Button("Reset Render Triangles##reset_render_triangles") then

        Inspector.Rendering_SectorScene_Triangles = nil
        Inspector.Rendering_SectorScene_ShowVerticesLayers = false
        Inspector.Rendering_SectorScene_Layer = 0
        Inspector.Rendering_SectorScene_MapDataReal = nil
        Inspector.Rendering_SectorScene_Objects = nil
        Inspector.Rendering_Current_SectorScene_Triangles = false
        Inspector.Rendering_Current_SectorScene_CurrentTriangle = false

        Inspector.Rendering_SectorScene_SingleObject = nil
        Inspector.Rendering_SingleObject_LowPoly = false

        Inspector.Cached_Object_VertsPolys = {}
        Inspector.Cached_Scene_VertsPolys = {}
      end

      if ImGui.Button("Render Current SectorScene Triangles##render_current_sectorscene_triangles") then
        
        Inspector.Rendering_Current_SectorScene_Triangles = true
      end

      if ImGui.Button("Render Current SectorScene Current Triangle##render_current_sectorscene_current_triangle") then
        
        Inspector.Rendering_Current_SectorScene_CurrentTriangle = true
      end

      if ImGui.Button("Recache SectorScenes##recache_sectorscenes") then
        
        Cached_SectorScenes_All = nil
        Cached_SectorScenes_Nearby = nil
        Cached_SectorScenes_Loaded = nil
      end

      if Cached_SectorScenes_All == nil then
        Cached_SectorScenes_All= sceneManager:getAllSectorScenes()
      end

      if ImGui.TreeNode("All SectorScenes(" .. table.length(Cached_SectorScenes_All) .. ")##scenemanager_allsectorscenes") then

        for k,sectorScene in pairs(Cached_SectorScenes_All) do
          
          MainWindow.populateSectorScene(sectorScene, "sectorscenes_all_" .. k) 
        end

        ImGui.TreePop()
      end

      if Cached_SectorScenes_Nearby == nil then
        Cached_SectorScenes_Nearby= sceneManager:getSectorScenes()
      end

      if ImGui.TreeNode("Nearby SectorScenes(" .. table.length(Cached_SectorScenes_Nearby) .. ")##scenemanager_sectorscenes_1") then

        for k,sectorScene in pairs(Cached_SectorScenes_Nearby) do
          
          MainWindow.populateSectorScene(sectorScene, "sectorscenes_1_" .. k) 
        end

        ImGui.TreePop()
      end

      if Cached_SectorScenes_Loaded == nil then
        Cached_SectorScenes_Loaded= sceneManager:getSectorScenes2()
      end

      if ImGui.TreeNode("Loaded SectorScenes(" .. table.length(Cached_SectorScenes_Loaded) .. ")##scenemanager_sectorscenes_2") then

        for k,sectorScene in pairs(Cached_SectorScenes_Loaded) do
          
          MainWindow.populateSectorScene(sectorScene, "sectorscenes_2_" .. k)          
        end

        ImGui.TreePop()
      end
    end

    if ImGui.CollapsingHeader("SysVarManager##id_sysvarmanager") then

      local svManager = Infinity.BDO.getSysVarManager()

      if ImGui.TreeNode("SystemVars##sysvarmanager_sysvars") then

        _, Filter_SystemVars_Name = ImGui.InputText("Filter Name##sysvarmanager_sysvars_filter_name", Filter_SystemVars_Name)

        for svName,sv in pairs(svManager:getSysVars()) do
          
          local shouldShow = true  

          if Filter_SystemVars_Name ~= "" and string.find(svName:lower(), Filter_SystemVars_Name) == nil then
            shouldShow = false
          end

          if shouldShow then
            MainWindow.populateSystemVar(sv, svName)  
          end
        end

        ImGui.TreePop()
      end
    end

if ImGui.CollapsingHeader("Inventory##id_inventoryheader") then
      local invenUsableSize, freeCount, invenUsedSize = Inspector.getInventoryInfo()
      
      ImGui.Spacing()
      ImGui.SameLine()
      ImGui.Text("Slots (Used/Max):")
      ImGui.SameLine()
      ImGui.Text(tostring(math.floor(invenUsableSize)) .. "/" .. tostring(math.floor(invenUsedSize)) .. " (" .. tostring(math.floor(freeCount)) .. " free)")

      if ImGui.TreeNode("Inventory items##id_inventorytable") then

        ImGui.Columns(5)
        ImGui.TextDisabled("Slot");
        ImGui.NextColumn()
        ImGui.TextDisabled("itemId");
        ImGui.NextColumn()
        ImGui.TextDisabled("Name");
        ImGui.NextColumn()
        ImGui.TextDisabled("enchantKey");
        ImGui.NextColumn()
        ImGui.TextDisabled("Count");
        ImGui.NextColumn()

        for k, v in pairs(Inspector.getInventoryItems()) do
          local enchantKey = math.floor(v.enchantKey)
          local enchantLvl = Utils.getEnchantLevel(enchantKey)

          ImGui.Text(tostring(v.slot))
          ImGui.NextColumn()
          ImGui.Text(tostring(math.floor(v.itemId)))
          ImGui.NextColumn()          
          if enchantLvl == 0 then
            ImGui.Text(tostring(v.name))
          else
            ImGui.Text(tostring(v.name) .. " +" .. tostring(enchantLvl))
          end
          ImGui.NextColumn()
          ImGui.Text(tostring(enchantKey))
          ImGui.NextColumn()
          ImGui.Text(tostring(math.floor(v.count)))
          ImGui.NextColumn()
        end
        ImGui.Columns(1)
        ImGui.TreePop()
      end
      

      local equipMaxSize, equipfreeCount, equipUseSize = Inspector.getEquipInfo()
      ImGui.Spacing()
      ImGui.SameLine()
      ImGui.Text("Slots (Used/Max):")
      ImGui.SameLine()
      ImGui.Text(tostring(math.floor(equipUseSize)) .. "/" .. tostring(math.floor(equipMaxSize)) .. " (" .. tostring(math.floor(equipfreeCount)) .. " free)")


      if ImGui.TreeNode("Equipped items##id_equippedtable") then

        ImGui.Columns(5)
        ImGui.TextDisabled("Slot");
        ImGui.NextColumn()
        ImGui.TextDisabled("itemId");
        ImGui.NextColumn()
        ImGui.TextDisabled("Name");
        ImGui.NextColumn()
        ImGui.TextDisabled("enchantKey");
        ImGui.NextColumn()
        ImGui.TextDisabled("Count");
        ImGui.NextColumn()

        for k, v in pairs(Inspector.getEquippedItems()) do
          local enchantKey = math.floor(v.enchantKey)
          local enchantLvl = Utils.getEnchantLevel(enchantKey)

          ImGui.Text(tostring(v.slot))
          ImGui.NextColumn()
          ImGui.Text(tostring(math.floor(v.itemId)))
          ImGui.NextColumn()          
          if enchantLvl == 0 then
            ImGui.Text(tostring(v.name))
          else
            ImGui.Text(tostring(v.name) .. " +" .. tostring(enchantLvl))
          end
          ImGui.NextColumn()
          ImGui.Text(tostring(enchantKey))
          ImGui.NextColumn()
          ImGui.Text(tostring(math.floor(v.count)))
          ImGui.NextColumn()
        end

        ImGui.Columns(1)
        ImGui.TreePop()
      end
    end

    ImGui.End()
end

function MainWindow.getActionChartsByName(name)

  local buffer = {}

  for pmi,packagemap in pairs(Infinity.BDO.ActionBranchManager.getPCPackageRaw_PackageMaps()) do
    
    for aci,actionchart in pairs(packagemap:getActionCharts()) do
      
      if string.find(actionchart:getName():lower(), name:lower()) ~= nil then
        table.insert(buffer, actionchart)
      end
    end
  end

  return buffer
end

function MainWindow.getActionChartsBySkillId(skillId)

  local buffer = {}

  for pmi,packagemap in pairs(Infinity.BDO.ActionBranchManager.getPCPackageRaw_PackageMaps()) do
    
    for aci,actionchart in pairs(packagemap:getActionCharts()) do
      
      if actionchart:getActionChartData():getSkillId() == tonumber(skillId) then
        table.insert(buffer, actionchart)
      end
    end
  end

  return buffer
end

function MainWindow.populateFrameHeader(frameHeader, prefix)

  if ImGui.TreeNode("FrameHeader##actionbranch_entry_frameheader_" .. prefix) then

    ImGui.Text("ConditionSetHash NonValue: " .. frameHeader:getConditionSetHash_NonValue())
    ImGui.Text("ConditionSetHash Value: " .. frameHeader:getConditionSetHash_Value())
    
    if frameHeader:hasConditions_NonValue() then

      if ImGui.TreeNode("Conditions NonValue##actionbranch_entry_frameheader_conditions_nonvalue_" .. prefix) then

        for iCNV, cNV in pairs(frameHeader:getConditions_NonValue()) do
          
          ImGui.Text(cNV)
        end

        ImGui.TreePop()
      end
    end

    if frameHeader:hasConditions_Value() then

      if ImGui.TreeNode("Conditions Value##actionbranch_entry_frameheader_conditions_value_" .. prefix) then

        for cCV, vCV in pairs(frameHeader:getConditions_Value()) do
          
          ImGui.Text(cCV .. " -> " .. vCV)
        end

        ImGui.TreePop()
      end
    end

    ImGui.TreePop()
  end
end

function MainWindow.populateActionBranch(actionBranch, prefix)

  local name = actionBranch:getExecute()

  if ImGui.TreeNode(name .. "##actionbranch_entry_" .. name .. "_" .. prefix) then
    
    ImGui.InputText("Adr##actionbranch_entry_adr_" .. name .. "_" .. prefix, string.format("0x%02X", actionBranch.address:getUnsafe()))
    
    local aHash = actionBranch:getActionHash()
    ImGui.InputText("ActionHash##actionbranch_entry_actionhash_" .. name .. "_" .. prefix, aHash)

    MainWindow.populateFrameHeader(actionBranch:getFrameHeader(), name .. "_" .. prefix)

    ImGui.Text("Execute: " .. name)
    ImGui.Text("ActionFileName: " .. actionBranch:getActionFileName())

    if ImGui.SmallButton("setBranch##actionbranche_entry_set_branch_" .. actionBranch:getExecute() .. "_" .. prefix) then
                    
      Infinity.BDO.ActionBranchManager.queueNextAction(actionBranch)
    end

    ImGui.TreePop()
  end
end

function MainWindow.populateActionScript(actionScript, prefix)

  local name = actionScript:getScriptName()

  if ImGui.TreeNode(name .. "##actionscript_entry_" .. name .. "_" .. prefix) then
    
    ImGui.InputText("Adr##actionscript_entry_adr_" .. name .. "_" .. prefix, string.format("0x%02X", actionScript.address:getUnsafe()))    

    ImGui.TreePop()
  end
end

function MainWindow.populatePackageMap(packageMap, prefix)

  local name = packageMap:getPackageHash()

  if ImGui.TreeNode(name .. "##packagemap_entry_" .. name .. "_" .. prefix) then
    
    ImGui.InputText("Adr##packagemap_entry_adr_" .. name .. "_" .. prefix, string.format("0x%02X", packageMap.address:getUnsafe()))    

    for aci,actionchart in pairs(packageMap:getActionCharts()) do
      
      MainWindow.populateActionChart(actionchart, aci)
    end

    ImGui.TreePop()
  end
end

function MainWindow.populateActionChart(actionchart, prefix)

  local name = actionchart:getName()

  if ImGui.TreeNode(name .. "##actionchart_entry_" .. name .. "_" .. prefix) then
    
    ImGui.InputText("Adr##actionchart_entry_adr_" .. name .. "_" .. prefix, string.format("0x%02X", actionchart.address:getUnsafe()))    
    
    if actionchart:getParentPackageMap() ~= nil then
      if ImGui.TreeNode("Parent PackageMap##actionchart_entry_parent_packagemap" .. name .. "_" .. prefix) then
        MainWindow.populatePackageMap(actionchart:getParentPackageMap(), prefix .. "_parentpackagemap")

        ImGui.TreePop()
      end
    end

    if ImGui.TreeNode("ActionChartData##actionchart_actionchartdata_entry_" .. name .. "_" .. prefix) then

      local ad = actionchart:getActionChartData()

      ImGui.Text("TargetTypes: " .. ad:getTargetTypes())
      ImGui.Text("StartFrame: " .. ad:getStartFrame())
      ImGui.Text("EndFrame: " .. ad:getEndFrame())
      ImGui.Text("AnimationSpeed: " .. ad:getAnimationSpeed())
      ImGui.Text("SkillId: " .. ad:getSkillId())

      ImGui.TreePop()
    end

    ImGui.TreePop()
  end
end

function MainWindow.populateSystemVar(sysvar, prefix)

  local valueChanged = false
  local value = sysvar:getValue()
  local valueF = sysvar:getValueF()

  if ImGui.TreeNode(prefix .. "##sysvarmanager_sysvars_var_" .. prefix) then    

    if ImGui.SmallButton("Set Default##sysvarmanager_sysvars_var_default_" .. prefix) then

      Infinity.BDO.getSysVarManager():setSysVarDefault(prefix)
    end

    local svName = prefix
    _, svName = ImGui.InputText("Name##sysvarmanager_sysvars_name_" .. prefix, svName)

    if sysvar:getIsFloat() then

      valueChanged, valueF = ImGui.SliderFloat("Value##sysvarmanager_sysvars_var_value_" .. prefix, valueF, 0, 100000)

      if valueChanged then

        sysvar:setValueF(valueF)
      end
    else
      valueChanged, value = ImGui.SliderInt("Value##sysvarmanager_sysvars_var_value_" .. prefix, value, 0, 100000)

      if valueChanged then

        sysvar:setValue(value)
      end
    end

    ImGui.TreePop()
  end
end

function MainWindow.populateObjectScene(o, prefix)

  if ImGui.TreeNode(o:getFileName() .. "##objectscene_details_" .. prefix) then        

          local vertices = o:getVertices()
          local polygons = o:getPolygons()
        
          ImGui.InputText("Adr##objectscene_details_adr_" .. prefix, string.format("0x%02X", o.address:getUnsafe()), ImGuiInputTextFlags_ReadOnly)
          
          if ImGui.SmallButton("Show Object##render_objectscene_details_" .. prefix) then
            --Inspector.Rendering_SectorScene_SingleObject = o
            --Inspector.Rendering_SingleObject_LowPoly = false

            table.insert(Inspector.Cached_Object_VertsPolys, {Name = o:getFileName(), Object = o, Vertices = vertices, Polygons = polygons})
          end

          ImGui.SameLine()

          if ImGui.SmallButton("Show Object Low Poly##render_lowpoly_objectscene_details_" .. prefix) then
            --Inspector.Rendering_SectorScene_SingleObject = o
            --Inspector.Rendering_SingleObject_LowPoly = true

            table.insert(Inspector.Cached_Object_VertsPolys, {Name = o:getFileName(), Object = o, Vertices = o:getVertices(true), Polygons = o:getPolygons(true)})
          end

          ImGui.Text("IsVisible: " .. tostring(o:isVisible()))

          if ImGui.TreeNode("Vertices(" .. table.length(vertices) .. ")##objectscene_details_vertices_" .. prefix) then

            for kv,vertex in pairs(vertices) do                
              ImGui.Text(vertex.X .. ", " .. vertex.Y .. ", " .. vertex.Z)
            end

            ImGui.TreePop()
          end

          if ImGui.TreeNode("Polygons(" .. table.length(polygons) .. ")##objectscene_details_polygons_" .. prefix) then

            for kp,polygon in pairs(polygons) do                
              ImGui.Text(polygon.X .. ", " .. polygon.Y .. ", " .. polygon.Z)
            end

            ImGui.TreePop()
          end

          ImGui.TreePop()
        end
end

function MainWindow.populateTreeScene(treeScene, prefix)

  local baseTree = treeScene:getBaseTree()
  local treeSceneInfo = treeScene:getTreeSceneInfo()

  if ImGui.TreeNode(treeSceneInfo:getFileName() .. "##treescene_details_" .. prefix) then        

          local vertices = baseTree:getVertices()
          local polygons = baseTree:getPolygons()
        
          ImGui.InputText("Adr##treescene_details_adr_" .. prefix, string.format("0x%02X", treeScene.address:getUnsafe()), ImGuiInputTextFlags_ReadOnly)
                          
          local refPoint = treeSceneInfo:getRefPoint()

          ImGui.Text("RefPoint: " .. refPoint.X .. ", " .. refPoint.Y .. ", " .. refPoint.Z)

          if ImGui.TreeNode("Vertices(" .. table.length(vertices) .. ")##treescene_details_vertices_" .. prefix) then

            for kv,vertex in pairs(vertices) do                
              ImGui.Text(vertex.X .. ", " .. vertex.Y .. ", " .. vertex.Z)
            end

            ImGui.TreePop()
          end

          if ImGui.TreeNode("Polygons(" .. table.length(polygons) .. ")##treescene_details_polygons_" .. prefix) then

            for kp,polygon in pairs(polygons) do                
              ImGui.Text(polygon.X .. ", " .. polygon.Y .. ", " .. polygon.Z)
            end

            ImGui.TreePop()
          end

          ImGui.TreePop()
        end
end

function MainWindow.populateSectorScene(sectorScene, prefix)
  local mapSector = sectorScene:getSector()
  local mapDataReal = sectorScene:getMapDataReal()

  if ImGui.TreeNode(math.floor(mapSector.X) .. "_" .. math.floor(mapSector.Y) .. "_" .. math.floor(mapSector.Z) .. "##scenemanager_" .. prefix) then
    
    ImGui.InputText("Adr##scenemanager_adr_" .. prefix, string.format("0x%02X", sectorScene.address:getUnsafe()))
            
    if ImGui.SmallButton("Render Triangles##render_triangles_" .. prefix) then

      --Inspector.Rendering_SectorScene_Triangles = mapDataReal:getTriangles()
      table.insert(Inspector.Cached_Scene_VertsPolys, {Scene = sectorScene, Vertices = mapDataReal:getVertices(), Polygons = mapDataReal:getPolygons()})
    end
        
    ImGui.SameLine()

    if ImGui.SmallButton("Render Vertices Layers##render_vertices_layers_" .. prefix) then

     Inspector.Rendering_SectorScene_ShowVerticesLayers = true
     Inspector.Rendering_SectorScene_MapDataReal = sectorScene:getMapDataReal()
    end
    
    __, Inspector.Rendering_SectorScene_Layer = ImGui.SliderInt("Layer##render_vertices_layers_layer_" .. prefix, Inspector.Rendering_SectorScene_Layer, 0, 31)

    if ImGui.SmallButton("Render Objects##render_objects_" .. prefix) then

      --Inspector.Rendering_SectorScene_Objects = sectorScene:getAllObjects()      
      --Inspector.Rendering_SectorScene_Objects_LowPoly = false

      for k,o in pairs(sectorScene:getAllObjects()) do
        table.insert(Inspector.Cached_Object_VertsPolys, {Name = o:getFileName(), Object = o, Vertices = o:getVertices(), Polygons = o:getPolygons()})
      end      
    end

    ImGui.SameLine()

    if ImGui.SmallButton("Render Objects (Low Poly)##render_objects_lowpoly_" .. prefix) then

      --Inspector.Rendering_SectorScene_Objects = sectorScene:getAllObjects()
      --Inspector.Rendering_SectorScene_Objects_LowPoly = true

      for k,o in pairs(sectorScene:getAllObjects()) do
        table.insert(Inspector.Cached_Object_VertsPolys, {Name = o:getFileName(), Object = o, Vertices = o:getVertices(true), Polygons = o:getPolygons(true)})
      end  
    end

    if ImGui.SmallButton("Disable Rendering##render_disable_" .. prefix) then
      
      sectorScene:setRenderSurface(false)
    end

    ImGui.SameLine()

    if ImGui.SmallButton("Enable Rendering##render_enable_" .. prefix) then
      
      sectorScene:setRenderSurface(true)
    end

    local vertices = mapDataReal:getVertices()
    local polygons = mapDataReal:getPolygons()

    if ImGui.TreeNode("Vertices(" .. table.length(vertices) .. ")##scenemanager_vertices_" .. prefix) then

      for kv,vertex in pairs(vertices) do
                
        ImGui.Text(vertex.X .. ", " .. vertex.Y .. ", " .. vertex.Z)
      end

      ImGui.TreePop()
    end

    if ImGui.TreeNode("Polygons(" .. table.length(polygons) .. ")##scenemanager_polygons_" .. prefix) then

      for kp,polygon in pairs(polygons) do
                
        ImGui.Text(polygon.X .. ", " .. polygon.Y .. ", " .. polygon.Z)
      end

      ImGui.TreePop()
    end

    if ImGui.TreeNode("All Objects##scenemanager_objects_all_" .. prefix) then

    local allCombinedObjects = sectorScene:getAllObjects()
    local objects01 = sectorScene:getObjects01()
    local objects02 = sectorScene:getObjects02()
    local objects03 = sectorScene:getObjects03()
    local objects04 = sectorScene:getObjects04()
    local objects05 = sectorScene:getObjects05()
    local objects06 = sectorScene:getObjects06()

    local treeScenes = sectorScene:getTreeScenes()

    if ImGui.TreeNode("Tree Scenes(" .. table.length(treeScenes) .. ")##scenemanager_treescenes_" .. prefix) then

      for kp,treeScene in pairs(treeScenes) do
        
        MainWindow.populateTreeScene(treeScene, "treescene_" .. kp)        
      end

      ImGui.TreePop()
    end

    if ImGui.TreeNode("All Combined Objects(" .. table.length(allCombinedObjects) .. ")##scenemanager_allcombinedobjects_" .. prefix) then

      for kp,o in pairs(allCombinedObjects) do
        
        MainWindow.populateObjectScene(o, o:getFileName() .. "_all_" .. kp)        
      end

      ImGui.TreePop()
    end

    if ImGui.TreeNode("Objects01(" .. table.length(objects01) .. ")##scenemanager_objects01_" .. prefix) then

      for kp,o in pairs(objects01) do
        
        MainWindow.populateObjectScene(o, o:getFileName() .. "_" .. kp)        
      end

      ImGui.TreePop()
    end

    if ImGui.TreeNode("Objects02(" .. table.length(objects02) .. ")##scenemanager_objects02_" .. prefix) then

      for kp,o in pairs(objects02) do
        
        MainWindow.populateObjectScene(o, o:getFileName() .. "_" .. kp)        
      end

      ImGui.TreePop()
    end

    if ImGui.TreeNode("Objects03(" .. table.length(objects03) .. ")##scenemanager_objects03_" .. prefix) then

      for kp,o in pairs(objects03) do
        
        MainWindow.populateObjectScene(o, o:getFileName() .. "_" .. kp)        
      end

      ImGui.TreePop()
    end

    if ImGui.TreeNode("Objects04(" .. table.length(objects04) .. ")##scenemanager_objects04_" .. prefix) then

      for kp,o in pairs(objects04) do
        
        MainWindow.populateObjectScene(o, o:getFileName() .. "_" .. kp)        
      end

      ImGui.TreePop()
    end

    if ImGui.TreeNode("Objects05(" .. table.length(objects05) .. ")##scenemanager_objects05_" .. prefix) then

      for kp,o in pairs(objects05) do
        
        MainWindow.populateObjectScene(o, o:getFileName() .. "_" .. kp)        
      end

      ImGui.TreePop()
    end

    if ImGui.TreeNode("Objects06(" .. table.length(objects06) .. ")##scenemanager_objects06_" .. prefix) then

      for kp,o in pairs(objects06) do
        
        MainWindow.populateObjectScene(o, o:getFileName() .. "_" .. kp)        
      end

      ImGui.TreePop()
    end

    ImGui.TreePop()
  end
  ImGui.TreePop()
  end
end