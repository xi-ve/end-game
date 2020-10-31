local Colors = {}
Colors.ImVecColorToHex = function(rgba)
	local hexColor = string.format("%02X", math.floor(rgba.w * 255)) .. string.format("%02X", math.floor(rgba.x * 255)) ..
                 		string.format("%02X", math.floor(rgba.y * 255)) .. string.format("%02X", math.floor(rgba.z * 255))
	return hexColor
end

Colors.randomImVecColor = function()
	return ImVec4(255, math.random(0, 255), math.random(0, 255), math.random(0, 255))
end
Colors.randomHexColor = function()
	return Colors.ImVecColorToHex({w = 255, x = math.random(0, 255), y = math.random(0, 255), z = math.random(0, 255)})
end

Colors.White = "FFFFFFFF"
Colors.Black = "FF000000"
Colors.Red = "FFFF0000"
Colors.Green = "FF00FF00"
Colors.Blue = "FF0000FF"
Colors.Yellow = "FFFBFF00"

MagLib.Utils.Colors = Colors
