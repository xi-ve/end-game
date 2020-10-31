GrinderUI = {}

GrinderUI.mobsAround = {}
GrinderUI.mobsAroundSelectedIndex = 0

local respawnTypes = {
  [1] = "Nearest Town",
  [2] = "Nearest Node",
  [3] = "Wait for Fairy Cooldown"
}

function GrinderUI.updateMobsAround()
  local mobNames = {}
  local mobIds = {}

  local mobs = TargetHelper.getMonstersInRange(4000)
  for k, actor in pairs(mobs) do
    if actor and ActorUtils.isValidActor(actor) then
      local name = actor:getName()
      local actorId = actor:getActorId()
      if not table.find(mobIds, actorId) then
        local isBlacklistMob = false

        for _, v in pairs(Grinder.settings.blacklist_mob_ids) do
          if v.id == actorId then
            isBlacklistMob = true
            break
          end
        end

        if not isBlacklistMob then
          table.insert(mobIds, actorId)
          table.insert(mobNames, name)
        end
      end
    end
  end

  GrinderUI.mobsAroundIds = mobIds
  GrinderUI.mobsAroundName = mobNames
end

function GrinderUI.draw(newWindow)
  if newWindow == nil then
    newWindow = true
  end
  if newWindow then
    ImGui.Begin("[Grinder] Grinder Settings")

    ImGui.PushStyleColor2(ImGuiCol_Text, RenderHelper.GetColorImVec4FromHexColorString("FFFFCC99"))
    ImGui.PushStyleColor2(ImGuiCol_Button, RenderHelper.GetColorImVec4FromHexColorString("FF990000"))
    ImGui.PushStyleColor2(ImGuiCol_CheckMark, RenderHelper.GetColorImVec4FromHexColorString("FF990000"))
  end

  _, Grinder.settings.usePotions = ImGui.Checkbox("Use Potions", Grinder.settings.usePotions)
  if Grinder.settings.usePotions then
    ImGui.Text("Use Potions at:")
    ImGui.PushItemWidth(400)
    _, Grinder.settings.useHpPotAt = ImGui.SliderInt("% HP##slider_hpUse", Grinder.settings.useHpPotAt, 0, 100)
    _, Grinder.settings.useMpPotAt = ImGui.SliderInt("% MP##slider_MpUse", Grinder.settings.useMpPotAt, 0, 100)
    ImGui.PopItemWidth()
  end

  ImGui.Separator()

  _, Grinder.settings.attack_mobs_in_townrun =
    ImGui.Checkbox("Attack Mobs on townrun##attack_on_townrun", Grinder.settings.attack_mobs_in_townrun)
  _, Grinder.settings.attack_mobs_on_end_of_townrun =
    ImGui.Checkbox(
    "Attack Mobs on way back from Townruns##attack_on_back_to_spot",
    Grinder.settings.attack_mobs_on_end_of_townrun
  )

  ImGui.Separator()
  _, Grinder.settings.pickup_loot = ImGui.Checkbox("Pickup Loot##pickup_loot", Grinder.settings.pickup_loot)
  if Grinder.settings.pickup_loot then
    _, Grinder.settings.pickup_loot_move =
      ImGui.Checkbox("Move to loot##pickup_loot_move", Grinder.settings.pickup_loot_move)
    if Grinder.settings.pickup_loot_move then
      _, Grinder.settings.pickup_loot_move_range =
        ImGui.SliderInt("Range for looting##pickup_loot_move_range", Grinder.settings.pickup_loot_move_range, 300, 2500)
    end
  end

  ImGui.Separator()

  ImGui.Text("Timeout if no damage was dealt to a monster: (ms)")
  ImGui.SameLine()
  ImGui.PushItemWidth(100)
  _, Grinder.settings.timeoutTimeAttackMobsNoDamage =
    ImGui.InputInt("##timeoutMonster", Grinder.settings.timeoutTimeAttackMobsNoDamage, 100, 500)
  ImGui.PopItemWidth()

  ImGui.Text("When selecting enemies to attack, the maximum distance is:")
  --ImGui.Text("")

  -- Text always 175, input 275

  ImGui.PushItemWidth(175)
  ImGui.Text("To the player:      ")
  ImGui.PopItemWidth()

  ImGui.SameLine()

  ImGui.PushItemWidth(275)
  local valChange
  valChange, Grinder.settings.attack_mob_from_player_range =
    ImGui.InputInt("##bpt_grinder_mob_player_maxRange", Grinder.settings.attack_mob_from_player_range, 50, 100)
  ImGui.PopItemWidth()

  ImGui.Separator()

  ImGui.PushItemWidth(175)
  ImGui.Text("To a recorded node: ")
  ImGui.PopItemWidth()

  ImGui.SameLine()
  ImGui.PushItemWidth(275)
  valChange, Grinder.settings.attack_mob_from_path_range =
    ImGui.InputInt("##bpt_grinder_mob_path_maxRange", Grinder.settings.attack_mob_from_path_range, 25, 50)
  ImGui.PopItemWidth()

  ImGui.Text("or")

  ImGui.PushItemWidth(175)
  ImGui.Text("To a grindspot:     ")
  ImGui.PopItemWidth()

  ImGui.SameLine()

  ImGui.PushItemWidth(275)
  valChange, Grinder.settings.attack_mob_from_grindSpot_range =
    ImGui.InputInt("##bpt_grinder_mob_grindSpot_maxRange", Grinder.settings.attack_mob_from_grindSpot_range, 100, 200)
  ImGui.PopItemWidth()

  ImGui.Separator()

  if ImGui.CollapsingHeader("Blacklist Mobs ##blacklist_ids_header") then
    ImGui.Spacing()

    if ImGui.Button("Reload Mobs around##reload_mobs") then
      GrinderUI.updateMobsAround()
    end

    _, GrinderUI.mobsAroundSelectedIndex =
      ImGui.Combo("##blacklist_mobsAround_combo", GrinderUI.mobsAroundSelectedIndex, GrinderUI.mobsAroundName)
    if ImGui.Button("Add") then
      local index = GrinderUI.mobsAroundSelectedIndex
      table.insert(
        Grinder.settings.blacklist_mob_ids,
        {name = GrinderUI.mobsAroundName[index], id = GrinderUI.mobsAroundIds[index]}
      )
      index = nil
    end

    ImGui.SameLine()
    ImGui.Text("Select a Mob and press the Add Button!")

    ImGui.Text("Ignore mobs with following IDs:")
    ImGui.Columns(3)
    ImGui.SetColumnWidth(0, 60)
    ImGui.SetColumnWidth(1, 305)
    ImGui.SetColumnWidth(2, 85)
    ImGui.Text("Id")
    ImGui.NextColumn()
    ImGui.Text("Name")
    ImGui.NextColumn()
    ImGui.Text("")
    ImGui.NextColumn()
    ImGui.Separator()

    for k, v in pairs(Grinder.settings.blacklist_mob_ids) do
      ImGui.Text(tostring(v.id))
      ImGui.NextColumn()
      ImGui.Text(tostring(v.name))
      ImGui.NextColumn()

      if ImGui.Button("Delete##id_items_list_delete_" .. k) then
        table.remove(Grinder.settings.blacklist_mob_ids, k)
        break
      end

      ImGui.NextColumn()
    end
    ImGui.Columns(1)
    ImGui.Separator()
  end

  --TODO: Render Grindspots again

  ImGui.Text("Only attack Groups: (Currently costs a lot of FPS! Be careful!)")
  ImGui.SameLine()
  _, Grinder.settings.auto_blacklist_non_group_mobs =
    ImGui.Checkbox("##only_attack_groups", Grinder.settings.auto_blacklist_non_group_mobs)

  if Grinder.settings.auto_blacklist_non_group_mobs then
    ImGui.Indent(25)
    -----------------
    ImGui.Text("Group Minimum Size: ")
    ImGui.SameLine()

    ImGui.PushItemWidth(250)
    _, Grinder.settings.auto_blacklist_non_group_mobs_min_count =
      ImGui.SliderInt("##group_size", Grinder.settings.auto_blacklist_non_group_mobs_min_count, 2, 8)
    ImGui.PopItemWidth()

    ImGui.Text("Group Area:         ")
    ImGui.SameLine()

    ImGui.PushItemWidth(250)
    _, Grinder.settings.auto_blacklist_non_group_mobs_group_distance =
      ImGui.SliderInt("##group_area", Grinder.settings.auto_blacklist_non_group_mobs_group_distance, 250, 1500)
    ImGui.PopItemWidth()
    -----------------
    ImGui.Unindent(25)
  end

  ---
  ImGui.Separator()
  ImGui.Text("Enable Blackstone Extraction (Green and below only):")
  ImGui.SameLine()
  _, Grinder.settings.extract_blackstones =
    ImGui.Checkbox("##enable_blackstone_extraction", Grinder.settings.extract_blackstones)

  if Grinder.settings.extract_blackstones then
    ImGui.Text("Max Level to extract Blackstones from:")
    _, Grinder.settings.do_not_extract_over_level =
      ImGui.SliderInt("##do_not_extract_over_level", Grinder.settings.do_not_extract_over_level, 1, 15)
  end

  ---
  ImGui.Separator()
  ImGui.Text("Skip Grindspot if less than")
  ImGui.SameLine()
  ImGui.PushItemWidth(75)
  _, Grinder.settings.grindSpot_min_mob_amount =
    ImGui.InputInt("##grindSpot_min_mob_amount", Grinder.settings.grindSpot_min_mob_amount)
  ImGui.PopItemWidth()
  ImGui.SameLine()
  ImGui.Text(" mobs in it")
  ImGui.Text("(will still attack mobs in the grindspot, but might take shortcuts!)")

  ImGui.Separator()
  _, Grinder.settings.stop_on_death =
    ImGui.Checkbox("Stop upon death! (Prevents repeated dying)", Grinder.settings.stop_on_death)
  if not Grinder.settings.stop_on_death then
    ImGui.Text("Instantly respawn by fairy if possible: ")
    ImGui.SameLine()
    _, Grinder.settings.respawn_by_fairy = ImGui.Checkbox("##respawn_by_fairy", Grinder.settings.respawn_by_fairy)

    ImGui.Text("Respawn at: ")
    ImGui.SameLine()
    _, Grinder.settings.respawn_type = ImGui.Combo("##respawn_type_combo", Grinder.settings.respawn_type, respawnTypes)
    if Grinder.settings.respawn_type == 3 then
      ImGui.Text("Security will not trigger while you lay on the ground waiting for Fairy cd.")
    end
  end
  _, Grinder.settings.use_rage_buff =
    ImGui.Checkbox("Activate Rage Buff (Z) when possible!", Grinder.settings.use_rage_buff)

  if newWindow then
    ImGui.PopStyleColor(3)

    ImGui.End()
  end
end
