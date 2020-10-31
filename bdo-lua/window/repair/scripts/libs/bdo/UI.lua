UI = {}

function UI.getTitleText(panelName)
	local code = 
	[[
		local title = (UI.getChildControl)(]] .. panelName .. [[, "Static_Text_Title")

		return title:GetText()
	]]

	return Infinity.BDO.Lua.Execute(code)
end

function UI.getShow(panelName)
	local code = 
	[[
		return ]] .. panelName .. [[:GetShow()
	]]

	return Infinity.BDO.Lua.Execute(code)
end

function UI.setShow(panelName, value)
	local code = 
	[[
		]] .. panelName .. [[:SetShow(]] .. tostring(value) .. [[)
	]]

	Infinity.BDO.Lua.Execute(code)
end

function UI.getChecked(panel, controlName)
	local code = 
	[[
		local control = UI.getChildControl(]] .. panel .. [[, "]] .. controlName .. [[")

		if control == nil then
			return false
		end

		return control:IsCheck()
	]]

	return Infinity.BDO.Lua.Execute(code)
end

function UI.setChecked(panel, controlName, value)
	local code = 
	[[
		local control = UI.getChildControl(]] .. panel .. [[, "]] .. controlName .. [[")

		if control == nil then
			return
		end

		control:SetCheck(]] .. tostring(value) .. [[)
	]]

	Infinity.BDO.Lua.Execute(code)
end