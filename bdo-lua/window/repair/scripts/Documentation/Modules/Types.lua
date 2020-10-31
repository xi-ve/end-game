---A 3 dimensional Vector containing 3 floats as XYZ
---@class Vector3
local Vector3 = {}

---Creates a new Vector3 object
---@param x number
---@param y number
---@param z number
---@return Vector3 vec3
function Vector3(x, y, z)
end

---@type number
Vector3.X = 0
---@type number
Vector3.Y = 0
---@type number
Vector3.Z = 0

---Vector addition
---@return Vector3 newVector
function Vector3:Add(otherVector)
end
---Vector subtraction
---@return Vector3 newVector
function Vector3:Sub(otherVector)
end
---Vector multiplication with a float
---@return Vector3 newVector
function Vector3:Mult(scale)
end

function Vector3:Lerp(startVector, endVector, pct)
end

---Calculates the distance between two points
function Vector3:getDistance(pos)
end
---Calculates the 2d distance between two points, ignoring the y coordinate
function Vector3:getDistance2D(pos)
end
---Calculates the rotation towards the point
function Vector3:getRotationToFace(target)
end
---Calculates a direction vector towards the point
function Vector3:getDirectionVector(target)
end

---A 2 dimensional Vector containing 2 integers XY
---@class Vector2
local Vector2 = {}

---Creates a new Vector2 object
---@param x integer
---@param y integer
function Vector2(x, y)
end

---@type integer
Vector2.X = 0
---@type integer
Vector2.Y = 0

