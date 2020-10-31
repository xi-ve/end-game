MainWindow = {}
MainWindow.renderedOnce = false

MainWindow.newConditionPopupShow = false
MainWindow.newConditionAddToSkill = nil
MainWindow.newConditionComboIndex = 1

MainWindow.loadWindow = false

MainWindow.newSkillPopupShow = false
MainWindow.newSkillName = ""

function MainWindow.OnGUIDraw()
    --MainWindow.renderedOnce = true

    ---UI
    ImGui.Begin("Combatscript Creator " .. CCreator.version)
    ImGui.SetWindowSize(ImVec2(800, 600))
    ImGui.Text("Configure a combatscript below and press \"Create\" to create a combatscript! (Combascripts are for GrindBuddy only!)")

    --Name
    ImGui.Text("Name: ")
    ImGui.SameLine()
    _, CCreator.script.combatScriptName = ImGui.InputText("##combatscript_name", CCreator.script.combatScriptName)

    --isAwakening
    ImGui.SameLine()
    ImGui.Text("Awakening")
    ImGui.SameLine()
    _, CCreator.script.combatScriptAwakening = ImGui.Checkbox("##combatscript_isAwakening", CCreator.script.combatScriptAwakening)
    ImGui.SameLine()
    ImGui.Text("|")
    --Create
    ImGui.SameLine()
    if ImGui.Button("Create/Save") then
        CCreator.createCombatscript()
        CCreator.saveCurrentScript()
    end

    ImGui.Text("Autoattack Range:")
    ImGui.SameLine()
    _, CCreator.script.autoAttackRange = ImGui.InputInt("##combatrange_autoRange", CCreator.script.autoAttackRange)

    ImGui.SameLine()
    if ImGui.Button("Load old scripts") then
        MainWindow.refreshAvaibleScripts()
        MainWindow.loadWindow = not MainWindow.loadWindow
    end

    --Skills
    MainWindow.drawSkillTab()
    ----------
    ImGui.End()

    --Load popup
    if MainWindow.loadWindow then
        MainWindow.drawLoadingWindow()
    end

    --New condition popup
    if MainWindow.newConditionPopupShow then
        --MainWindow.renderedOnce = true
        ImGui.Begin("New Condition for Skill " .. MainWindow.newConditionAddToSkill.name .. "##new_condition_popup")
        ImGui.SetWindowSize(ImVec2(500, 85))
        ImGui.Text("Select a condition:")
        ImGui.SameLine()
        _, MainWindow.newConditionComboIndex = ImGui.Combo("##new_condition_popup_combo", MainWindow.newConditionComboIndex, CCreator.conditionNames)

        ImGui.Indent(220)
        if ImGui.Button("Add") then
            table.insert(MainWindow.newConditionAddToSkill.conditions, {conditionTable = CCreator.conditions[MainWindow.newConditionComboIndex], value = "0"})
            MainWindow.newConditionPopupShow = false
        end
        ImGui.Unindent(220)
        ImGui.End()
    end

    --New skill popup
    if MainWindow.newSkillPopupShow then
        ImGui.Begin("New Skill##new_skill_popup")
        ImGui.SetWindowSize(ImVec2(250, 85))
        ImGui.Text("Name:")
        ImGui.SameLine()
        _, MainWindow.newSkillName = ImGui.InputText("##new_skill_name_input", MainWindow.newSkillName)

        ImGui.Indent(95)
        if ImGui.Button("Add") then
            local newSkill = {
                name = MainWindow.newSkillName,
                nameLua = MainWindow.newSkillName:gsub("%s+", "_"):gsub("-", "_"):gsub(":", "_"),
                tempName = MainWindow.newSkillName,
                forceCd = false,
                forceCdMs = 1000,
                ids = {},
                range = 500,
                keys = {},
                conditions = {}
            }
            table.insert(CCreator.script.skills, newSkill)
            MainWindow.newSkillPopupShow = false
            MainWindow.newSkillName = ""
        end

        ImGui.Unindent(95)
        ImGui.End()
    end

    if CCreator.created then
        local createdWindowTitle = "Created Combatscript " .. CCreator.script.combatScriptName .."!"
        if CCreator.createdError then
            createWindowTitle = "ERROR!"
        end

        ImGui.Begin(createdWindowTitle .. "##created_popup")
        ImGui.SetWindowSize(ImVec2(250, 85))

        ImGui.Text(CCreator.msg)

        ImGui.Indent(95)
        if ImGui.Button("OK!##created_popup_close") then
            CCreator.msg = ""
            CCreator.createdError = false
            CCreator.created = false
        end
        ImGui.Unindent(95)

        ImGui.End()
    end
end

MainWindow.avaibleScripts = {}
MainWindow.avaibleScriptsListIndex = 0
function MainWindow.refreshAvaibleScripts()
    MainWindow.avaibleScripts = {}
    local _scripts_dir = "\\SavedCombatscripts\\*.json"
    local _scripts = Infinity.FileSystem.GetFiles(_scripts_dir)
    for _, name in ipairs(_scripts) do
        table.insert(MainWindow.avaibleScripts, name:sub(1, name:len() - 5))
    end
end

function MainWindow.drawLoadingWindow()
    ImGui.Begin("Load Previously Created Combatscripts")
    ImGui.Text("Select script:")
    ImGui.SameLine()
    changed, MainWindow.avaibleScriptsListIndex = ImGui.Combo("##csList", MainWindow.avaibleScriptsListIndex, MainWindow.avaibleScripts)

    if changed then
        CCreator.loadScript(MainWindow.avaibleScripts[MainWindow.avaibleScriptsListIndex])
    end

    if ImGui.Button("Close") then
        MainWindow.loadWindow = false
    end

    ImGui.End()
end


function MainWindow.drawSkillTab()
    ImGui.Separator()
    ImGui.Text("Skills:")
    ImGui.Separator()
    for k, skill in ipairs(CCreator.script.skills) do
        --Change skill Index buttons
        if ImGui.CollapsingHeader("Skill " .. skill.name .. "##skill_" .. k .. "_collapsingHeader") then
            if ImGui.Button("Up##skill_up_" .. k, ImVec2(40, 20)) then
                MainWindow.changeTwoSkillsIndex(k, k - 1)
            end
            ImGui.SameLine()
            if ImGui.Button("Down##skill_up_" .. k, ImVec2(40, 20)) then
                MainWindow.changeTwoSkillsIndex(k, k + 1)
            end
            --Name
            ImGui.SameLine()
            ImGui.Text("Name:")
            ImGui.SameLine()
            ImGui.PushItemWidth(450)
            local enterPressed = false
            enterPressed, skill.tempName = ImGui.InputText("##skill_" .. k .. "_name", skill.tempName, 30, ImGuiInputTextFlags_EnterReturnsTrue)
            if enterPressed then
                skill.name = skill.tempName
                skill.nameLua = skill.name:gsub("%s+", "_"):gsub("-", "_"):gsub(":", "_")
            end

            ImGui.SameLine()
            ImGui.Text("(Enter to save)")
            ImGui.SameLine()
            if ImGui.Button("Delete##skill_" .. k .. "_delete") then
                table.remove(CCreator.script.skills, k)
            end
            ImGui.PopItemWidth()

            ImGui.Indent(10)


            --Everything under this we Indent a bit to make it clear that it is not the same "level" as the skill collapsing headers, but rather inside them

            --Force cd

            ImGui.Text("Force CD:")
            ImGui.SameLine()
            _, skill.forceCd = ImGui.Checkbox("##skill_" .. k .. "_forceCd", skill.forceCd)

            if skill.forceCd then
                ImGui.SameLine()
                ImGui.Text("   Cooldown: ")
                ImGui.SameLine()
                _, skill.forceCdMs = ImGui.InputInt("##skill_" .. k .. "_forceCdMs", skill.forceCdMs)
            end

            --Range
            ImGui.Text("Range:")
            ImGui.SameLine()
            _, skill.range = ImGui.InputInt("##skill_" .. k .. "_range", skill.range)

            --IDs
            if ImGui.CollapsingHeader("IDs##skill_"..k.."_ids_collapsingHeader") then
                ImGui.Indent(10)
                for idIndex, id in pairs(skill.ids) do
                    ImGui.Text("Id:")
                    ImGui.SameLine()
                    _, skill.ids[idIndex] = ImGui.InputInt("##skill_"..k.."_ids_input_"..idIndex, id)
                    ImGui.SameLine()
                    if ImGui.Button("Delete##skill_"..k.."_ids_delete_"..idIndex) then
                        table.remove(skill.ids, idIndex)
                    end
                end
                if ImGui.Button("Add new Id##skill_"..k.."_ids_add") then
                    table.insert(skill.ids, 0)
                end
                ImGui.Unindent(10)
            end


            --Skills
            if ImGui.CollapsingHeader("Keys##skill_"..k.."_keys_collapsingHeader") then
                ImGui.Indent(10)
                --We only give 2 keys to configure
                for keyIndex, key in ipairs(skill.keys) do
                    ImGui.Text("Key: " .. key.keyName)
                    ImGui.SameLine()
                    local recordingButtonText = "Record"
                    if key.recording then
                        recordingButtonText = "..."
                    end
                    if ImGui.Button(recordingButtonText .. "##skill_"..k.."_keys_"..keyIndex.."_record") then
                        --check if any other key is recording (we do this to prevent double recording due to the recording time delay), if no, set key.recording to true and set CCreator.recordingStartedTime. We still in theory allow other skill keys to record, but if u manage to unintentially fuck something up there, it is ur god damn fault...
                        local anotherKeyIsRecording = false
                        for keyIndex, otherKey in ipairs(skill.keys) do
                            if otherKey.recording then
                                anotherKeyIsRecording = true
                            end
                        end
                        if not anotherKeyIsRecording then
                            --Start recording
                            Infinity.BDO.Input.clearQueue()
                            Infinity.BDO.getUIManager():setIsCursorActive(false)
                            key.recording = true
                            CCreator.recordingStartedTime = CCreator.time
                        end
                    end
                    ImGui.SameLine()
                    if ImGui.Button("Delete##skill_"..k.."_ids_key_"..keyIndex) then
                        table.remove(skill.keys, idIndex)
                    end

                    if key.recording then
                        ImGui.SameLine()
                        local timeUntilRecording = (CCreator.recordingStartedTime + 500) - CCreator.time
                        local timeUntilText = "Press a button the skill needs..."
                        if timeUntilRecording > 0 then
                            timeUntilText = "Ready in " .. timeUntilRecording .. "ms"
                        end
                        ImGui.Text(timeUntilText)
                        ImGui.Text("Please click outside of Infinity windows inside the game to set mouse buttons")
                    end
                end
                if ImGui.Button("Add new key##skill_"..k.."_keys_add") then
                    table.insert(skill.keys, {key = 0, keyName = "", recording = false})
                end
                ImGui.Unindent(10)
            end

            --Conditions
            if ImGui.CollapsingHeader("Conditions##skill_"..k.."_conditions_collapsingHeader") then
                ImGui.Indent(10)
                for conditionIndex, condition in pairs(skill.conditions) do
                    --For every condition
                    local conditionTable = condition.conditionTable
                    if ImGui.Button("x##skill_"..k.."_conditions_" .. conditionIndex) then
                        table.remove(skill.conditions, conditionIndex)
                    end
                    ImGui.SameLine()
                    ImGui.Text(conditionTable.text)

                    if conditionTable.hasValue then
                        ImGui.SameLine()
                        if conditionTable.valueIsString then
                            _, condition.value = ImGui.InputText("##skill_"..k.."_conditions_" .. conditionIndex .. "_valueInputString", condition.value)
                        else
                            _, condition.value = ImGui.InputInt("##skill_"..k.."_conditions_" .. conditionIndex .. "_valueInputInt", condition.value)
                        end
                    end
                end
                if ImGui.Button("New Condition##skill_"..k.."_conditions_newCondition") then
                    MainWindow.newConditionPopupShow = true
                    MainWindow.newConditionAddToSkill = skill
                end
                ImGui.Unindent(10)
            end

            --Resetting Indent
            ImGui.Unindent(10)

            --Little hack to make spacing
            ImGui.Spacing()
            ImGui.Text("")
            ImGui.Spacing()
        end
        ImGui.Separator()

    end

    --New Skill
    if ImGui.Button("New Skill##new_skill_button") then
        MainWindow.newSkillPopupShow = true
    end

end

function MainWindow.changeTwoSkillsIndex(firstId, secondId)
    --Switch those two skills position in the table if the ids are valid
    --print(firstId .. "|" .. secondId)
    if firstId < 1 or secondId < 1 or firstId > #CCreator.script.skills or secondId > #CCreator.script.skills then
        --print("this")
        return
    end
    local tempSkill1 = CCreator.script.skills[firstId]
    local tempSkill2 = CCreator.script.skills[secondId]
    CCreator.script.skills[firstId] = tempSkill2
    CCreator.script.skills[secondId] = tempSkill1
end
