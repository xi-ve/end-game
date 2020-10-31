Queue = function()
    local self = { }
    self.stack = { }

    function self.push(e)
        table.insert(self.stack, e)
    end

    function self.front()
        return self.stack[1]
    end

    function self.front()
        return self.stack[#self.stack]
    end

    function self.pop()
        local e = self.stack[1]

        table.remove(self.stack, 1)

        return e
    end

    function self.count()
        return #self.stack
    end

    return self
end
