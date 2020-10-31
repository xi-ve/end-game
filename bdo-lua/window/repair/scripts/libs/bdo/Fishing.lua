Fishing = {}
Fishing.FishGrades = {"White", "Green", "Blue", "Yellow", "Orange"}

function Fishing.getFishGrade()
	--local code =
	--[[
		return ((getSelfPlayer()):get()):getFishGrade()
	]]--
	
	--return Infinity.BDO.Lua.Execute(code)
	return Infinity.BDO.getLocalPlayer():getNextFishGrade()
end

function Fishing.getFishGradeAsText(fishGrade)
	if fishGrade == nil or fishGrade < 0 or fishGrade > 4 then
		return "None"
	end

	return Fishing.FishGrades[fishGrade + 1]
end