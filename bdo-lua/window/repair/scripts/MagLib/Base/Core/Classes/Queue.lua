---Basic Queue implementation
-- @module MagLib.Core.Queue
-- @alias Queue
-- @usage
-- local queue = MagLib.Core.Queue()
-- queue.push("A")
-- queue.push("B")
-- queue.push("C")
--
-- print(queue.pop()) --Output: A
-- print(queue.pop()) --Output: B
-- print(queue.pop()) --Output: C
-- print(tostring(queue.pop())) --Output: nil
local Queue = Class()

function Queue:init(headTolerance, name)
	self.headTolerance = headTolerance or 50
	self.name = name or "Unnamed Queue"
	self.head = 1
	self.tail = 1
	self.data = {}
end

function Queue:push(v)
	self.data[self.tail] = v
	self.tail = self.tail + 1
end

function Queue:reorganize()
	-- If self.head is 1 then the list is already organized
	if self.head == 1 then
		return
	end

	-- We move the array to start at 1 again
	local moveCount = self.head
	for i = self.head, (self.tail - 1) do
		self.data[i - (self.head - 1)] = self.data[i]
		self.data[i] = nil
	end
end

function Queue:pop()
	-- If tail is 1, the list is empty, since tail always points to the next free entry
	if self.tail == 1 then
		return nil
	end

	-- We pop the entry that head points to and increment head
	local v = self.data[self.head]
	self.data[self.head] = nil
	self.head = self.head + 1

	-- If head == tail, then the list is empty and we can reset them
	if self.head == self.tail then
		self.head = 1
		self.tail = 1
	elseif self.head >= self.headTolerance then
		-- We move the whole array back.
		self:reorganize()
	end

	return v
end

function Queue:isEmpty()
	return self.tail == 1
end

function Queue:getSize()
	return (self.tail - self.head)
end

function Queue:print()
	self:reorganize()
	print(self.name .. " size: " .. self:getSize())
	table.print(self.data)
end

MagLib.Core.Queue = Queue
