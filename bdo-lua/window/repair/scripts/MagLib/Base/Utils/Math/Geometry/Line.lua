local Line = Class()
function Line:init(from, to)
	self.from = from
	self.to = to
end

function Line:draw(color, thickness)
	RenderHelper.DrawWorldLine(self.from, self.to, color, thickness)
end

MagLib.Utils.Math.Geometry.Line = Line
