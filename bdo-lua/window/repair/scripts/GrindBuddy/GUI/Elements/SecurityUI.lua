SecurityUI = {}

local UI = MagLib.UI
function SecurityUI.draw()
	local _ = nil

	ImGui.Text("Whitelisted players will not trigger GrindBuddy security!")
	if ImGui.Button("Channel Swap Settings##swap_settings") then
		GUI.renderChannelUI = not GUI.renderChannelUI
	end

	-- Channel swapping on timer
	local changed = false
	changed, Grinder.settings.switch_channel_after_given_time =
		ImGui.Checkbox("Switch channel after ##switch_channel_after_given_time_checkbox",
               		Grinder.settings.switch_channel_after_given_time)
	if changed then
		StaySafeTask.resetTimerSwap()
	end

	ImGui.SameLine()
	ImGui.PushItemWidth(100)
	changed, Grinder.settings.switch_channel_after_min_minutes =
		ImGui.InputInt("##switch_channel_after_min_minutes", Grinder.settings.switch_channel_after_min_minutes, 5, 30)
	if changed then
		StaySafeTask.resetTimerSwap()
	end
	ImGui.PopItemWidth()

	ImGui.SameLine()
	UI.Text("to ")

	ImGui.SameLine()
	ImGui.PushItemWidth(100)
	changed, Grinder.settings.switch_channel_after_max_minutes =
		ImGui.InputInt("##switch_channel_after_max_minutes", Grinder.settings.switch_channel_after_max_minutes, 5, 30)
	if changed then
		StaySafeTask.resetTimerSwap()
	end

	if Grinder.settings.switch_channel_after_min_minutes < 15 then
		Grinder.settings.switch_channel_after_min_minutes = 15
	end

	if (Grinder.settings.switch_channel_after_max_minutes < Grinder.settings.switch_channel_after_min_minutes) then
		Grinder.settings.switch_channel_after_max_minutes = Grinder.settings.switch_channel_after_min_minutes
	end

	ImGui.PopItemWidth()

	ImGui.SameLine()
	UI.Text(" minutes")

	if Grinder.settings.switch_channel_after_given_time then
		ImGui.Indent(20)
		if Grinder.is_started and StaySafeTask.nextSwap ~= nil then
			local secondsUntilSwap = (StaySafeTask.nextSwap - Cache.time) / 1000
			if secondsUntilSwap > 60 then
				UI.Text("Swapping in " .. MagLib.Utils.Math.round(secondsUntilSwap / 60, 1) .. " minutes")
			else
				UI.Text("Swapping in " .. MagLib.Utils.Math.round(secondsUntilSwap, 1) .. " seconds")
			end
		end
		ImGui.Unindent(20)
	end

	-- Explanation Text
	UI.Text("Upon detecting a player GrindBuddy will swap channels!\n" ..
        		"If channel swap is on cooldown, it will go to channel select and wait there until it can swap channel.\n" ..
        		"If there is no possible channel to swap to it will exit the game!", "FFe9f542")

	ImGui.Text("Use security on Townrun: ")
	ImGui.SameLine()
	_, Grinder.settings.useSecurityOnTownrun = ImGui.Checkbox("##securityOnTownrun", Grinder.settings.useSecurityOnTownrun)
	ImGui.Separator()

	_, Grinder.settings.respondToPvP = ImGui.Checkbox("Attack Hostile Players##attack_hostile",
                                                  	Grinder.settings.respondToPvP)

	ImGui.Separator()
	_, Grinder.settings.use_tp = ImGui.Checkbox("Allow Teleport for Navigation if no Player is around: ##allow_tp",
                                            	Grinder.settings.use_tp)
	if Grinder.settings.use_tp then
		UI.Text("Use at your own risk!", "FFE9F542")
		_, Grinder.settings.no_tp_onTownrun = ImGui.Checkbox("Disallow tp on Townrun##no_tp_onTownrun",
                                                     		Grinder.settings.no_tp_onTownrun)
		ImGui.Separator()
		ImGui.Text("TP Delay: ")
		ImGui.SameLine()
		_, Grinder.settings.tp_delay = ImGui.SliderInt("##tp_delay_slider", Grinder.settings.tp_delay, 25, 500)

		ImGui.Text("TP Max Distance: ")
		ImGui.SameLine()
		_, Grinder.settings.tp_maxDistance = ImGui.SliderInt("##tp_maxDistance_slider", Grinder.settings.tp_maxDistance, 1,
                                                     		500)

		if not Grinder.settings.no_tp_onTownrun then
			ImGui.Text("")
			ImGui.SameLine()
			_, Grinder.settings.townrun_tp_different_speed = ImGui.Checkbox(
                                                 				"Use separate TP Settings for Townrun##townrun_tp_different_speed",
                                                 				Grinder.settings.townrun_tp_different_speed)
			if Grinder.settings.townrun_tp_different_speed then
				ImGui.Text("[Townrun] TP Delay: ")
				ImGui.SameLine()
				ImGui.PushItemWidth(273)
				_, Grinder.settings.townrun_tp_delay = ImGui.SliderInt("##townrun_tp_delay_slider",
                                                       				Grinder.settings.townrun_tp_delay, 25, 500)
				ImGui.PopItemWidth()

				ImGui.Text("[Townrun] TP Max Distance: ")
				ImGui.SameLine()
				ImGui.PushItemWidth(225)
				_, Grinder.settings.townrun_tp_maxDistance = ImGui.SliderInt("##townrun_tp_maxDistance_slider",
                                                             				Grinder.settings.townrun_tp_maxDistance, 1, 500)
				ImGui.PopItemWidth()
				_, Grinder.settings.use_townrun_tp_faraway_grindspot = ImGui.Checkbox(
                                                       					"Also use Townrun TP Settings if far away from Grindspots##use_townrun_tp_faraway_grindspot",
                                                       					Grinder.settings.use_townrun_tp_faraway_grindspot)
			end
		end

		ImGui.Text("TP Height Offset: ")
		ImGui.SameLine()
		_, Grinder.settings.tp_height_offset = ImGui.SliderInt("##tp_height_offset", Grinder.settings.tp_height_offset, 25,
                                                       		150)
	end
	ImGui.Separator()

	_, Grinder.settings.emulate_human_movement = ImGui.Checkbox("Emulate Human Navigation##emulate_human_nav",
                                                            	Grinder.settings.emulate_human_movement)

	ImGui.Separator()

	if not Grinder.settings.emulate_human_movement then
		_, Grinder.settings.skip_path_nodes = ImGui.Checkbox("Skip nodes in path##skip_path_nodes",
                                                     		Grinder.settings.skip_path_nodes)

		if Grinder.settings.skip_path_nodes then
			ImGui.Text("Don't skip nodes on townrun")
			ImGui.SameLine()
			_, Grinder.settings.disable_skip_path_nodes_onTownrun = ImGui.Checkbox("##disable_skip_path_nodes_onTownrun",
                                                                       			Grinder.settings
                                                                       				.disable_skip_path_nodes_onTownrun)
			--[[if Grinder.settings.disable_skip_path_nodes_onTownrun then
    ImGui.Text("Be careful: \n Bot will skip nodes when returning to grindspot \n IF 'Attack Mobs on way back from Towruns' is enabled. \n If not, then bot will also not skip nodes\n on the way back to the grindspots")
    end]]
		end
	else
		Grinder.settings.skip_path_nodes = false

		ImGui.Text("Path Interpolation: ")
		ImGui.SameLine()
		_, Grinder.settings.interpolation_path_smoothness = ImGui.SliderInt("##interpolation_path_smoothness",
                                                                    		Grinder.settings.interpolation_path_smoothness, 1,
                                                                    		10)

		ImGui.Text("Path Roundness: ")
		ImGui.SameLine()
		_, Grinder.settings.interpolation_movement_smoothness = ImGui.SliderInt("##interpolation_nav_smoothness",
                                                                        		Grinder.settings
                                                                        			.interpolation_movement_smoothness, 1, 5)
	end
end
