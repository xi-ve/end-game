-- Node class abstraction
-- This class represents an abstraction of a Node in the graph.
-- It should implemented with additional functions when
-- writing a custom handler.
MagLib.BDO.Navigation.Graph.Node = function(index)
	local Node = {distance = math.huge, cost = 0, pos = Vector3(0, 0, 0), index = index}

	function Node:initialize(index)
		self.index = index
	end
	function Node:toString()
		return ('Node: %s | Pos: %s, %s, %s'):format(self.index, tostring(self.pos.X), tostring(self.pos.Y),
                                             		tostring(self.pos.Z))
	end
	function Node:tostring()
		return self:toString()
	end
	function Node:isEqualTo(n)
		return self.index == n.index
	end

	setmetatable(Node, {
		__eq = function(a, b)
			return a.index == b.index
		end,
		__lt = function(a, b)
			return a.distance < b.distance
		end,
		__tostring = function(n)
			return n:tostring()
		end
	})

	return Node
end
