BuyPotionsUI = {}

--This is on top of EVERY file to optimize performance
local _ = nil
local _Grinder = nil
local _Cache = nil

function BuyPotionsUI.init()
    _Grinder = Grinder
    _Cache = Cache
end


function BuyPotionsUI.draw(newWindow)
    if newWindow == nil then
        newWindow = true
    end
    if newWindow then
        ImGui.Begin("[Townrun] Potions")

        ImGui.PushStyleColor2(ImGuiCol_Text, RenderHelper.GetColorImVec4FromHexColorString("FFFFCC99"))
        ImGui.PushStyleColor2(ImGuiCol_Button, RenderHelper.GetColorImVec4FromHexColorString("FF990000"))
        ImGui.PushStyleColor2(ImGuiCol_CheckMark, RenderHelper.GetColorImVec4FromHexColorString("FF990000"))
    end

    _, _Grinder.settings.buy_hp_potion = ImGui.Checkbox("Buy HP Potions##enable_Hp_Buy", _Grinder.settings.buy_hp_potion)

    ImGui.Text("Amount of HP Potions:")
    ImGui.SameLine()
    ImGui.PushItemWidth(150)
    _, _Grinder.tempVars.buy_hp_potion_amount = ImGui.InputInt("##hp_Potion_Amount", _Grinder.settings.buy_hp_potion_amount, 0, 250)
    ImGui.PopItemWidth()

    ImGui.Text("Potion ID (Leave it as 0 for auto)")
    ImGui.SameLine()

    local hpIdText = ""
    if _Grinder.settings.buy_hp_potion_id then
        hpIdText = "" .. _Grinder.settings.buy_hp_potion_id
    else
        hpIdText = "0"
    end
    ImGui.PushItemWidth(150)
    _, _Grinder.tempVars.buy_hp_potion_id = ImGui.InputText("##hp_Potion_Id", hpIdText, 10, ImGuiInputTextFlags_CharsDecimal)
    hpIdText = nil
    ImGui.PopItemWidth()

    --MP Potions
    _, _Grinder.settings.buy_mp_potion = ImGui.Checkbox("Buy MP Potions##enable_Mp_Buy", _Grinder.settings.buy_mp_potion)

    ImGui.Text("Amount of MP Potions:")
    ImGui.SameLine()
    ImGui.PushItemWidth(150)
    _, _Grinder.tempVars.buy_mp_potion_amount = ImGui.InputInt("##mp_Potion_Amount", _Grinder.settings.buy_mp_potion_amount, 0, 250)
    ImGui.PopItemWidth()

    ImGui.Text("Potion ID (Leave it as 0 for auto)")
    ImGui.SameLine()
    local mpIdText = ""
    if _Grinder.settings.buy_mp_potion_id then
        mpIdText = "" .. _Grinder.settings.buy_mp_potion_id
    else
        mpIdText = "0"
    end
    ImGui.PushItemWidth(150)
    _, _Grinder.tempVars.buy_mp_potion_id = ImGui.InputText("##mp_Potion_Id", mpIdText, 10, ImGuiInputTextFlags_CharsDecimal)
    ImGui.PopItemWidth()

    if newWindow then
        ImGui.PopStyleColor(3)
        ImGui.End()
    end
end
