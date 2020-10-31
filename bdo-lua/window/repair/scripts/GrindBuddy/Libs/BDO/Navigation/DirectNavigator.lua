function NewDirectNav()
    local _Player = Player
    local _Grinder = Grinder
    local self = {}
    self.dest = nil
    self.arrived = false
    self.isNavigating = false

    self.stopDistance = 125


    self.moveTo = function(dest, navigate_directly)
        if (not self.dest) or VectorUtils.equal(dest, self.dest) == false then
            self.dest = dest
            self.arrived = false
            self.isNavigating = true
        end

        if navigate_directly then
            self.navigate()
        end
    end

    self.stop = function()
        self.isNavigating = false
        self.arrived = true
    end

    self.reset = function()
        self.dest = nil
        self.arrived = false
        self.isNavigating = false
    end

    self.navigate = function()
        Log.debugLog("DirectNav navigate")
        if self.dest == nil then
            return false
        end

        local pPos = Cache.playerPos

        if pPos:getDistance(self.dest) < self.stopDistance then
            self.stop()
            return true
        end

        self.direct_moveTo(self.dest)

        pPos = nil

        return true
    end


    self.direct_moveTo = function(dest, callOnMoveTo)
        if Teleport.isTpAllowed() then
            Teleport.tpTo(dest)
        else
            _Player.moveTo(dest)
            if callOnMoveTo then
                self.onMoveTo(dest)
            end
        end
    end

    self.onMoveTo = function(dest)
        if _Grinder.currentCombatScript and _Grinder.currentCombatScript.onMoveTo and _Grinder.lastJumpTime + 2000 < Cache.time then
            if not Raycast.twoPos(Cache.playerPos, dest) then
                _Grinder.currentCombatScript:onMoveTo(dest, false)
            end
        end
    end

    return self
end
