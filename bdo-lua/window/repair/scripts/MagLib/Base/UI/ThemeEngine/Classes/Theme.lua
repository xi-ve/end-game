-- Theme class abstraction
-- This class represents an abstraction of a Theme in the graph.
-- It should implemented with additional functions when
-- writing a custom handler.
MagLib.UI.ThemeEngine.Theme = function(name)
	local Theme = {
		name = name,
		style = {
			color = {}, -- color as hex
			var = {
				number = {}, -- value as number
				imVec2 = {} -- value as imVec2
			}
		}
	}

	return Theme
end
