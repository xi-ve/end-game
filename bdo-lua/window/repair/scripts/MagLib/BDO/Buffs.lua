local Buff = Class({
	key = -1,
	endTime = -1,
	isDebuff = false,
	iconName = "",
	isAlchemyBuff = false,
	-- name = "",
	description = "",
	existing = true
})

function Buff:_initFromIndex(index, isDebuff)
	local code = [[
    local appliedBuff = getSelfPlayer():getAppliedBuffByIndex( ]] .. index .. [[,]] .. tostring(isDebuff) .. [[)
    if appliedBuff == nil then 
      return nil
    end

    local iconName = appliedBuff:getIconName()
    local desc = appliedBuff:getBuffDesc()
    local secondsLeft = Int64toInt32(appliedBuff:getRemainedTime_u64() / Defines.u64_const.u64_1000)
    local key = appliedBuff:getBuffKey()

    return iconName, desc, secondsLeft, key
  ]]
	local secondsLeft
	self.iconName, self.desc, secondsLeft, self.key = Infinity.BDO.Lua.Execute(code)
	if self.iconName == nil then
		self.existing = false
	else
		self.endTime = MagLib.getTime() + (secondsLeft * 1000)
	end
end

function Buff:_initFromNext(isDebuff)
	local code = [[
    local appliedBuff
    if g_buffIteratorStarted then
      appliedBuff = getSelfPlayer():getAppliedBuffNext(]] .. tostring(isDebuff) .. [[)
    else
      appliedBuff = getSelfPlayer():getAppliedBuffBegin(]] .. tostring(isDebuff) .. [[)
      g_buffIteratorStarted = true
    end

    if appliedBuff == nil then 
      return nil
    end

    local iconName = appliedBuff:getIconName()
    local desc = appliedBuff:getBuffDesc()
    local secondsLeft = Int64toInt32(appliedBuff:getRemainedTime_u64() / Defines.u64_const.u64_1000)
    local key = appliedBuff:getBuffKey()

    return iconName, desc, secondsLeft, key
  ]]
	local secondsLeft
	self.iconName, self.desc, secondsLeft, self.key = Infinity.BDO.Lua.Execute(code)
	if self.iconName == nil then
		self.existing = false
	else
		self.endTime = MagLib.getTime() + (secondsLeft * 1000)
	end
end

function Buff:init(perIterator, isDebuff, index)
	if not perIterator then
		self:_initFromIndex(index, isDebuff)
	else
		self:_initFromNext(isDebuff)
	end
end

local Buffs = {}
Buffs.Buff = Buff

local resetBuffIterator = function(isDebuff)
	Infinity.BDO.Lua.Execute("g_buffIteratorStarted = nil0")
end

---Returns a table with all positiven buffs
---@return table table with Buff objects of all positive buffs the player has
function Buffs.getAllPositiveBuffs()
	local buffs = {}
	while (true) do
		local buff = Buff(true, false)
		if buff.existing then
			table.insert(buffs, buff)
		else
			break
		end
	end
	resetBuffIterator()

	return buffs
end

---Returns a table with all debuffs
---@return table table with debuff objects of all debuffs the player has
function Buffs.getAllDebuffs()
	local buffs = {}
	while (true) do
		local buff = Buff(true, true)
		if buff.existing then
			table.insert(buffs, buff)
		else
			break
		end
	end
	resetBuffIterator()

	return buffs
end

---Returns a table with all buffs
---@return table table with Buff objects of all buffs the player has
function Buffs.getAllBuffs()
	local buffs = Buffs.getAllPositiveBuffs()
	for _, db in pairs(Buffs.getAllDebuffs()) do
		table.insert(buffs, db)
	end

	return buffs;
end

---Checks if player has a given buff
---@param key key of the buff to check
---@return boolean true if the player has a buff with the given key
function Buffs.hasBuff(key)
	for _, buff in pairs(Buffs.getAllBuffs()) do
		if buff.key == key then
			return true
		end
	end

	return false
end

function Buffs.printBuffKeys()
	for _, buff in pairs(Buffs.getAllBuffs()) do
		print(buff.iconName .. " => " .. buff.key)
	end
end

---Checks if the player has any buff that "collides" with the buff the given key represents
---@param key key of the buff to check
---@return boolean true if the player has a buff that "collides" with the given buffkey
function Buffs.hasCollidingBuff(key)
	local collidingBuffKeys = Buffs.getCollidingBuffs(key)
	local buffs = Buffs.getAllBuffs()

	for _, buff in pairs(buffs) do
		if table.find(collidingBuffKeys, buff.key) then
			return true
		end
	end

	return false
end

local collidingBuffs = {}
-- Villa Buffs
collidingBuffs[57240] = {57240, 57241, 57239, 57243, 57244, 57242, 57456} -- Villa buffs + confidence buff
collidingBuffs[57241] = collidingBuffs[57240] -- Villa buffs + confidence buff
collidingBuffs[57239] = collidingBuffs[57240] -- Villa buffs + confidence buff
collidingBuffs[57243] = collidingBuffs[57240] -- Villa buffs + confidence buff
collidingBuffs[57244] = collidingBuffs[57240] -- Villa buffs + confidence buff
collidingBuffs[57242] = collidingBuffs[57240] -- Villa buffs + confidence buff
-- Confidence Buff
collidingBuffs[57456] = collidingBuffs[57240] -- Villa buffs + itself

---Adventurers Luck
collidingBuffs[57484] = {57484, 57485, 57486, 57487, 57488} -- Each other
collidingBuffs[57485] = collidingBuffs[57484]
collidingBuffs[57486] = collidingBuffs[57484]
collidingBuffs[57487] = collidingBuffs[57484]
collidingBuffs[57488] = collidingBuffs[57484]
--
---Returns a list of buffKeys from buffs that collide to the given buff (bring the same bonus, override each other, etc.)
function Buffs.getCollidingBuffs(buffKey)
	local buffs = collidingBuffs[buffKey] or {}
	table.insert(buffs, buffKey) -- Worst case buffKey is inside two times, but that is fine
	return buffs
end

MagLib.BDO.Buffs = Buffs
