Infinity.Rendering = {}

---Actually takes two screen positions and draws a line between them. Use RenderHelper lib to convert from World position to screen position. Will be remade in the future.
---@param from Vector2
---@param to Vector2
---@param color ImVec4
---@param thickness number
function Infinity.Rendering.DrawWorldLine(from, to, color, thickness)
end

---Takes two positions and draws a line between them.
---@param from Vector2
---@param to Vector2
---@param color ImVec4
---@param thickness number
function Infinity.Rendering.DrawLine(from, to, color, thickness)
end

---Takes an array of screen Vector2 points and draws a circle. filled is false by default.
---@param pts table<integer, Vector2>
---@param radius number
---@param color ImVec4
---@param thickness number
---@param filled boolean
function Infinity.Rendering.DrawWorldCircle(pts, radius, color, thickness, filled)
end

---Takes an array of screen Vector2 points and draws a circle filled with a color and outlined with another.
---@param pts table<integer, Vector2>
---@param radius number
---@param colorOutline ImVec4
---@param colorFill ImVec4
---@param thickness number
function Infinity.Rendering.DrawWorldCircleFilledMulticolor(pts, radius, colorOutline, colorFill, thickness)
end

---Takes a position and draws a circle in it. filled is false by default.
---@param position Vector2
---@param radius number
---@param color ImVec4
---@param thickness number
---@param filled boolean
function Infinity.Rendering.DrawCircle(position, radius, color, thickness, filled)
end

---Takes an array of screen Vector2 points and draws a box in it. height is -1 by default.
---@param pts table<integer, Vector2>
---@param size number
---@param color ImVec4
---@param thickness number
---@param height number
function Infinity.Rendering.DrawWorldBox(pts, size, color, thickness, height)
end

---Takes an array of screen Vector2 points and draws a square in it. filled is false by default.
---@param pts table<integer, Vector2>
---@param size number
---@param color ImVec4
---@param thickness number
---@param filled boolean
function Infinity.Rendering.DrawWorldSquare(pts, size, color, thickness, filled)
end

---Takes a position and draws a square in it. filled is false by default.
---@param center Vector2
---@param size number
---@param color ImVec4
---@param thickness number
---@param filled boolean
function Infinity.Rendering.DrawSquare(center, size, color, thickness, filled)
end

---Takes two positions and draws a rectangle between them. filled is false by default.
---@param a ImVec2
---@param b ImVec2
---@param color ImVec4
---@param thickness number
---@param rounding number
---@param filled boolean
function Infinity.Rendering.DrawRect(a, b, color, thickness, rounding, filled)
end

---Takes three positions and draws a quad between them. filled is false by default.
---@param a ImVec2
---@param b ImVec2
---@param c ImVec2
---@param color ImVec4
---@param thickness number
---@param filled boolean
function Infinity.Rendering.DrawQuad(a, b, c, color, thickness, filled)
end

---Takes three positions and draws a triangle between them. filled is false by default.
---@param a ImVec2
---@param b ImVec2
---@param c ImVec2
---@param color ImVec4
---@param thickness number
---@param filled boolean
function Infinity.Rendering.DrawTriangle(a, b, c, color, thickness, filled)
end

---Takes a text string and a position and draws the text on it with the given size.
---@param text string
---@param pos Vector2
---@param size number
---@param color ImVec4
---@param center boolean
function Infinity.Rendering.DrawText(text, pos, size, color, center)
end

---Takes a image texture draws between the given positions.
---@param imTex LuaInt64
---@param a ImVec2
---@param b ImVec2
---@param uv_a ImVec2
---@param uv_b ImVec2
---@param color0 ImVec4
function Infinity.Rendering.DrawImage(imTex, a, b, uv_a, uv_b, color0)
end

---Loads a texture from an image file.
---@param filePath string
function Infinity.Rendering.LoadTextureFromImageFile(filePath)
end

---Loads a texture from a DDS file.---@param filePath wstring
function Infinity.Rendering.LoadTextureFromDDSFile(filePath)
end

---Converts a world position into a screen position.
---@param worldPos Vector3
function Infinity.Rendering.WorldToScreen(worldPos)
end
