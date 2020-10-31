--- Binary Heap data structure implementation.
-- Adapted from: https://github.com/Yonaba/Binary-Heaps.
-- It itself is a function call, a pseudo constructor that returns a table with custom metatable and functions that are a useable binary heap.
-- The binary heap is alraedy initialized. You do not need to call :initialize in most cases.
-- All functions of the Bheap are designed to be called with : instead of .
-- @module MagLib.Core.Bheap
-- @alias bheap
-- @usage
-- local bheap = MagLib.Core.Bheap()
-- bHeap._sort = function(a,b) return a < b end --Make custom sort function to always get smallest/biggest/fastest/oldest/whatever you need.
--
-- bheap.push("A")
-- bHeap.push("B")
--
-- local bestItem = bHeap.pop()
--
function Bheap()

	-- Looks for item in an array
	local function findIndex(array, item)
		for k = 1, #array do
			local v = array[k]
			if v == item then
				return k
			end
		end
	end

	-- Percolates up to restore heap property
	local function sift_up(bheap, index)
		if index == 1 then
			return
		end
		local pIndex
		if index <= 1 then
			return
		end
		if index % 2 == 0 then
			pIndex = index / 2
		else
			pIndex = (index - 1) / 2
		end

		if not bheap._sort(bheap._heap[pIndex], bheap._heap[index]) then
			bheap._heap[pIndex], bheap._heap[index] = bheap._heap[index], bheap._heap[pIndex]
			sift_up(bheap, pIndex)
		end

		pIndex = nil
		index = nil
	end

	-- Percolates down to restore heap property
	local function sift_down(bheap, index)
		local lfIndex, rtIndex, minIndex
		lfIndex = 2 * index
		rtIndex = lfIndex + 1
		if rtIndex > bheap.size then
			if lfIndex > bheap.size then
				return
			else
				minIndex = lfIndex
			end
		else
			if bheap._sort(bheap._heap[lfIndex], bheap._heap[rtIndex]) then
				minIndex = lfIndex
			else
				minIndex = rtIndex
			end
		end
		if not bheap._sort(bheap._heap[index], bheap._heap[minIndex]) then
			bheap._heap[index], bheap._heap[minIndex] = bheap._heap[minIndex], bheap._heap[index]
			sift_down(bheap, minIndex)
		end

		lfIndex = nil
		rtIndex = nil
		minIndex = nil
		index = nil
	end

	--- Binary heap class.
	-- Instantiates minHeaps by default
	local bheap = {}

	---Initializes the BHeap.
	-- Sets size to zero, resets sort function and heap.
	function bheap:initialize()
		self.size = 0
		self._sort = function(a, b)
			return a < b
		end
		self._heap = {}
	end

	--- Clears the heap and sets size to 0.
	function bheap:clear()
		self._heap = {}
		self.size = 0
	end

	--- Checks if the heap is empty
	-- @return bool: true is size == 0, else false.
	function bheap:isEmpty()
		return (self.size == 0)
	end

	--- Pushes a new item into the heap
	---@param item Item to push into the heap
	function bheap:push(item)
		self.size = self.size + 1
		self._heap[self.size] = item
		sift_up(self, self.size)
	end

	--- Pops the lowest (or highest) best item out of the heap.
	-- @return item: lowest (or highest) item in the heap.
	function bheap:pop()
		local root
		if self.size > 0 then
			root = self._heap[1]
			self._heap[1] = self._heap[self.size]
			self._heap[self.size] = nil
			self.size = self.size - 1
			if self.size > 1 then
				sift_down(self, 1)
			end
		end
		return root
	end

	--- Sorts a specific item in the heap
	---@param item to be sorted.
	function bheap:sort(item)
		if self.size <= 1 then
			return
		end
		local i = findIndex(self._heap, item)
		if i then
			sift_up(self, i)
		end
	end

	bheap:initialize()

	return bheap
end

MagLib.Core.Bheap = Bheap
