ChannelUI = {}
local _ = nil

local okayImage = Infinity.Rendering.LoadTextureFromImageFile(Infinity.Scripting.CurrentScript.Directory .. "Images\\okay.png")
local notOkayImage = Infinity.Rendering.LoadTextureFromImageFile(Infinity.Scripting.CurrentScript.Directory .. "Images\\not_okay.png")

function ChannelUI.draw()


    ImGui.Columns(3)
    ImGui.SetColumnWidth(0, 300)
    ImGui.SetColumnWidth(1, 150)
    ImGui.SetColumnWidth(2, 150)

    ImGui.Text("Currently on: " .. Server.getCurrentChannelIndex() .. ") " .. Server.getCurrentChannelName())
    ImGui.NextColumn()
    ImGui.Text("Swap cooldown: " .. tostring(Server.getChannelCooldown()) .. "s")
    ImGui.NextColumn()
    if ImGui.Button("Refresh Channel") then
        Server.updateChannels()
    end
    ImGui.NextColumn()
    ImGui.Separator()

    ImGui.Text("Name:")
    ImGui.NextColumn()
    ImGui.Text("Can Access:")
    ImGui.NextColumn()
    ImGui.Text("Allow:")
    ImGui.NextColumn()
    ImGui.Separator()

    local channel_settings = Grinder.settings.switch_channel_settings

    for _, channel in pairs(Server.channel) do
        local name = channel.name
        ImGui.Text( channel.chIndex .. ") " .. name)
        ImGui.NextColumn()
        local image = nil
        if channel.isAccessable then
            image = okayImage
        else
            image = notOkayImage
        end
        ImGui.Image(image, ImVec2(25, 25), ImVec2(0, 0), ImVec2(1, 1), ImVec4(1, 1, 1, 1), ImVec4(0, 0, 0, 0))

        ImGui.NextColumn()

        if not channel_settings[name] or not channel.isAccessable then
            channel_settings[name] = false
        end

        _, channel_settings[name] = ImGui.Checkbox("##channel_enable_" .. channel.chIndex, channel_settings[name])

        ImGui.NextColumn()
    end

    ImGui.Columns(1)


end
