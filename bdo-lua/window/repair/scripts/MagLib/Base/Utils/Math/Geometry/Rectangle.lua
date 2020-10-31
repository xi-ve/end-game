local Rect = {}

Rect.toTriangles = function(r)
	local t1 = {r[1], r[2], r[3]}
	local t2 = {r[3], r[4], r[2]}
	return t1, t2
end

MagLib.Utils.Math.Geometry.Rectangle = Rect
