local UI = MagLib.UI
local styleNames

local refreshNameTable = function(currentTheme)
	-- Resetting styleNames table
	styleNames = {color = {}, colorRealIds = {}, var = {number = {}, numberRealIds = {}, imVec2 = {}, imVec2RealIds = {}}}

	-- color
	for id, name in pairs(MagLib.UI.ThemeEngine.StyleSelectors.ColorSelectorNames) do
		if currentTheme.style.color[id] == nil then
			table.insert(styleNames.color, name)
			table.insert(styleNames.colorRealIds, id)
		end
	end
	-- var.number
	for id, name in pairs(MagLib.UI.ThemeEngine.StyleSelectors.Var.NumberSelectorNames) do
		if currentTheme.style.var.number[id] == nil then
			table.insert(styleNames.var.number, name)
			table.insert(styleNames.var.numberRealIds, id)
		end
	end
	-- var.imVec2
	for id, name in pairs(MagLib.UI.ThemeEngine.StyleSelectors.Var.ImVec2SelectorNames) do
		if currentTheme.style.var.imVec2[id] == nil then
			table.insert(styleNames.var.imVec2, name)
			table.insert(styleNames.var.imVec2RealIds, id)
		end
	end
end

local selectedColorVarIndex = 0
local drawColorVarEditor = function(currentTheme)
	selectedColorVarIndex = UI.Combo("New color variable:     ", selectedColorVarIndex, styleNames.color)
	UI.SameLine()
	if UI.SimpleButton("Add##color_add") then
		local realId = styleNames.colorRealIds[selectedColorVarIndex]
		if realId then
			currentTheme.style.color[realId] = "FFFF0000"
		end
	end

	UI.Columns(3, {200, 300, 75}, {"Variable Names", "Color", "Remove"})
	for id, value in pairs(currentTheme.style.color) do
		local colorName = MagLib.UI.ThemeEngine.StyleSelectors.ColorSelectorNames[id]
		if colorName ~= nil then
			UI.Text(colorName)
			UI.NextColumn()
			currentTheme.style.color[id] = UI.ColorPicker("##color_" .. colorName, value)
			UI.NextColumn()
			if UI.SimpleButton("X##remove_color_" .. colorName) then
				currentTheme.style.color[id] = nil
			end
			UI.NextColumn()
		end
	end

	UI.EndColumns()

end

local selectedNumberVarIndex = 0
local drawNumberVarEditor = function(currentTheme)
	selectedNumberVarIndex = UI.Combo("New Number variable:", selectedNumberVarIndex, styleNames.var.number)
	UI.SameLine()
	if UI.SimpleButton("Add##number_add") then
		local realId = styleNames.var.numberRealIds[selectedNumberVarIndex]
		if realId then
			currentTheme.style.var.number[realId] = 20
		end
	end

	UI.Columns(3, {200, 300, 75}, {"Variable Names", "Value", "Remove"})
	for id, value in pairs(currentTheme.style.var.number) do
		local variableName = MagLib.UI.ThemeEngine.StyleSelectors.Var.NumberSelectorNames[id]
		UI.Text(variableName)
		UI.NextColumn()
		currentTheme.style.var.number[id] = UI.InputFloat("##number_" .. variableName, value)
		UI.NextColumn()
		if UI.SimpleButton("X##remove_number_" .. variableName) then
			currentTheme.style.var.number[id] = nil
		end
		UI.NextColumn()
	end

	UI.EndColumns()
end

local selectedImVec2VarIndex = 0
local drawImVec2Editor = function(currentTheme)
	UI.Text("Every MagLib script can load themes for it's own windows as well.")
	UI.Text("ImVec2 Modifications only apply to these rather than Infinity wide Themes")
	selectedImVec2VarIndex = UI.Combo("New ImVec2 variable:", selectedImVec2VarIndex, styleNames.var.imVec2)
	UI.SameLine()
	if UI.SimpleButton("Add##imVec2_add") then
		local realId = styleNames.var.imVec2RealIds[selectedImVec2VarIndex]
		if realId then
			currentTheme.style.var.imVec2[realId] = ImVec2(0, 0)
		end
	end

	UI.Columns(3, {200, 300, 75}, {"Variable Names", "ImVec2", "Remove"})
	for id, imVec2 in pairs(currentTheme.style.var.imVec2) do
		local variableName = MagLib.UI.ThemeEngine.StyleSelectors.Var.ImVec2SelectorNames[id]
		UI.Text(variableName)
		UI.NextColumn()
		imVec2 = UI.ImVec2Editor("##iV2_" .. variableName, imVec2)
		UI.NextColumn()
		if UI.SimpleButton("X##remove_imVec_2" .. variableName) then
			currentTheme.style.var.imVec2[id] = nil
		end
		UI.NextColumn()
	end

	UI.EndColumns()
end

function DrawEditorUI()
	local currentTheme = MagLib.UI.ThemeEngine.currentTheme
	if currentTheme then
		refreshNameTable(currentTheme)

		if ImGui.CollapsingHeader("Colors") then
			drawColorVarEditor(currentTheme)
		end

		if ImGui.CollapsingHeader("Number Modifications") then
			drawNumberVarEditor(currentTheme)
		end
		if ImGui.CollapsingHeader("ImVec2 Modifications") then
			drawImVec2Editor(currentTheme)
		end
	else
		UI.Text("Select a theme first")
	end
end

