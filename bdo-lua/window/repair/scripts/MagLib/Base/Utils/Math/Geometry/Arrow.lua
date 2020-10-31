local Arrow = {}
local Vector = MagLib.Utils.Vector
local Math = MagLib.Utils.Math
local Line = MagLib.Utils.Math.Geometry.Line

local HorizontalArrow = Class()
function HorizontalArrow:init(from, towards, length)
	self.from = from
	self.towards = towards
	self.length = length
	self.lines = {}
	-- Getting the vector that is the main line of the arrow
	local rVec = Vector.rVec(from, towards)
	local stretchedRVec = Vector.mult(rVec, length)
	-- stretchedRVec is now the main line of the arrow, calculating arrow head pos

	local arrowHeadPos = Vector.add(from, stretchedRVec)

	table.insert(self.lines, Line(from, arrowHeadPos))

	local headLength = (length / 3)
	-- First arrow head line
	local firstArrowHeadVec = Vector.modifyLength(Vector.rotateHorizontal(rVec, 160), headLength)
	-- Making sure the arrows y change is proper and not going in the wrong direction up/down
	firstArrowHeadVec.Y = -rVec.Y
	local firstArrowHeadEndPos = Vector.addition(arrowHeadPos, firstArrowHeadVec)
	table.insert(self.lines, Line(arrowHeadPos, firstArrowHeadEndPos))

	-- Second arrow head line
	local secondArrowHeadRVec = Vector.modifyLength(Vector.rotateHorizontal(rVec, -160), headLength)
	-- Making sure the arrows y change is proper and not going in the wrong direction up/down
	secondArrowHeadRVec.Y = -rVec.Y
	local secondArrowHeadEndPos = Vector.addition(arrowHeadPos, secondArrowHeadRVec)
	table.insert(self.lines, Line(arrowHeadPos, secondArrowHeadEndPos))
end

function HorizontalArrow:draw(color, thickness)
	for _, line in pairs(self.lines) do
		line:draw(color, thickness)
	end
end

-- Adding classes to Arrow table
Arrow.HorizontalArrow = HorizontalArrow
-- Assinging global var
MagLib.Utils.Math.Geometry.Arrow = Arrow
