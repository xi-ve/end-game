SellingUI = {}
SellingUI.inputItemIdSelling = 0
SellingUI.inputNameSelling = ""
SellingUI.selectedItemInputIndex = -1

SellingUI.inputItemIdNotSelling = 0
SellingUI.inputNameNotSelling = ""
SellingUI.notSelling_selectedItemInputIndex = -1


function SellingUI.draw(newWindow)
    if newWindow == nil then
        newWindow = true
    end
    if newWindow then
        ImGui.Begin("[Townrun]: Selling")
        ImGui.PushStyleColor2(ImGuiCol_Text, RenderHelper.GetColorImVec4FromHexColorString("FFFFCC99"))
        ImGui.PushStyleColor2(ImGuiCol_Button, RenderHelper.GetColorImVec4FromHexColorString("FF990000"))
        ImGui.PushStyleColor2(ImGuiCol_CheckMark, RenderHelper.GetColorImVec4FromHexColorString("FF990000"))
    end

    _, Grinder.settings.selling = ImGui.Checkbox("Selling##sellEnable", Grinder.settings.selling)
    ImGui.Separator()

    _, Grinder.settings.use_legacy_selling = ImGui.Checkbox("Use legacy Selling method##use_legacy_selling", Grinder.settings.use_legacy_selling)

    _, Grinder.settings.sell_white_items = ImGui.Checkbox("Sell white items##sellWhite", Grinder.settings.sell_white_items)
    _, Grinder.settings.sell_green_items = ImGui.Checkbox("Sell green items##sellGreen", Grinder.settings.sell_green_items)

    ImGui.Separator()

    if ImGui.CollapsingHeader("Sell") then

        ImGui.PushItemWidth(420)
        _, SellingUI.selectedItemInputIndex = ImGui.Combo("##id_inventory_items_selling", SellingUI.selectedItemInputIndex, Cache.inventoryItemsNames)
        ImGui.PopItemWidth()

        if ImGui.Button("Add") then
            --local shouldAdd = true
            if table.length(Cache.inventoryItemsNames) ~= 0 and SellingUI.selectedItemInputIndex > - 1 then
                local itemId = Cache.inventoryItemsIds[SellingUI.selectedItemInputIndex]
                local canAdd = true
                for k, v in pairs(Grinder.settings.sell_items) do
                    if v.itemId == itemId then
                        canAdd = false
                        break
                    end
                end

                if canAdd then
                    table.insert(Grinder.settings.sell_items, {name = Cache.inventoryItemsNames[SellingUI.selectedItemInputIndex], itemId = itemId, })
                end

                itemId = nil
                canAdd = nil
            end
        end
        ImGui.SameLine()
        ImGui.Text("Select Inventory Item and press the Add Button!")

        ImGui.Spacing()

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

        for k, v in pairs(Grinder.settings.sell_items) do
            ImGui.Text(math.floor(tostring(v.itemId)))
            ImGui.NextColumn()
            ImGui.Text(tostring(v.name))
            ImGui.NextColumn()

            if ImGui.Button("Delete##id_items_list_delete_" .. k) then
                table.remove(Grinder.settings.sell_items, k)
                break
            end

            ImGui.NextColumn()
        end

        ImGui.Columns(1)
        ImGui.Separator()

        ImGui.Text("Name:")
        ImGui.SameLine()
        _, SellingUI.inputNameSelling = ImGui.InputText("", SellingUI.inputNameSelling)
        ImGui.Text("Id:")
        ImGui.SameLine()
        _, SellingUI.inputItemIdSelling = ImGui.InputInt("##items_input_itemid", SellingUI.inputItemIdSelling, 0, 0, 0)
        ImGui.SameLine()
        if ImGui.Button("Add##items_add_itemid_selling") then
            if SellingUI.inputItemIdSelling > 0 and table.find(Grinder.settings.sell_items, SellingUI.inputItemIdSelling) == nil then
                table.insert(Grinder.settings.sell_items, {name = SellingUI.inputNameSelling, itemId = SellingUI.inputItemIdSelling})
                --Resetting
                SellingUI.inputItemIdSelling = 0
                SellingUI.inputNameSelling = ""
            end
        end
        ImGui.Spacing()
        ImGui.Spacing()
        ImGui.Spacing()
        ImGui.Spacing()
        ImGui.Spacing()
    end

    if ImGui.CollapsingHeader("Never sell") then

        ImGui.PushItemWidth(420)
        _, SellingUI.notSelling_selectedItemInputIndex = ImGui.Combo("##id_inventory_items_selling", SellingUI.notSelling_selectedItemInputIndex, Cache.inventoryItemsNames)
        ImGui.PopItemWidth()

        if ImGui.Button("Add") then
            --local shouldAdd = true
            if table.length(Cache.inventoryItemsNames) ~= 0 and SellingUI.notSelling_selectedItemInputIndex > - 1 then
                local itemId = Cache.inventoryItemsIds[SellingUI.notSelling_selectedItemInputIndex]
                local canAdd = true
                for k, v in pairs(Grinder.settings.doNotSell_items) do
                    if v.itemId == itemId then
                        canAdd = false
                        break
                    end
                end

                if canAdd then
                    table.insert(Grinder.settings.doNotSell_items, {name = Cache.inventoryItemsNames[SellingUI.notSelling_selectedItemInputIndex], itemId = itemId, })
                end

                itemId = nil
                canAdd = nil
            end
        end
        ImGui.SameLine()
        ImGui.Text("Select Inventory Item and press the Add Button!")

        ImGui.Spacing()

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

        for k, v in pairs(Grinder.settings.doNotSell_items) do
            ImGui.Text(math.floor(tostring(v.itemId)))
            ImGui.NextColumn()
            ImGui.Text(tostring(v.name))
            ImGui.NextColumn()

            if ImGui.Button("Delete##id_items_list_delete_" .. k) then
                table.remove(Grinder.settings.doNotSell_items, k)
                break
            end

            ImGui.NextColumn()
        end

        ImGui.Columns(1)
        ImGui.Separator()

        ImGui.Text("Name:")
        ImGui.SameLine()
        _, SellingUI.inputNameNotSelling = ImGui.InputText("", SellingUI.inputNameNotSelling)
        ImGui.Text("Id:")
        ImGui.SameLine()
        _, SellingUI.inputItemIdNotSelling = ImGui.InputInt("##items_input_itemid", SellingUI.inputItemIdNotSelling, 0, 0, 0)
        ImGui.SameLine()
        if ImGui.Button("Add##items_add_itemid_selling") then
            if SellingUI.inputItemIdNotSelling > 0 and table.find(Grinder.settings.doNotSell_items, SellingUI.inputItemIdNotSelling) == nil then
                table.insert(Grinder.settings.doNotSell_items, {name = SellingUI.inputNameNotSelling, itemId = SellingUI.inputItemIdNotSelling})
                --Resetting
                SellingUI.inputItemIdNotSelling = 0
                SellingUI.inputNameNotSelling = ""
            end
        end

    end


    if newWindow then
        ImGui.PopStyleColor(3)
        ImGui.End()
    end
end
