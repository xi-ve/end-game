-- Node class abstraction

-- This class represents an abstraction of a Node in the graph.
-- It should be implemented with additional functions when
-- writing a custom handler.

-- See dijkstra.lua comment header
-- See custom handlers for reference (*_hander.lua).
function NodeConstructor()
  local class = ClassConstructor()

  local Node = class {distance = math.huge, cost = 0, pos = Vector3(0, 0, 0)}
  Node.__eq = function(a, b) return a.index == b.index end
  Node.__lt = function(a, b) return a.distance < b.distance end
  Node.__tostring = function(n) return n:toString() end

  return Node
end
