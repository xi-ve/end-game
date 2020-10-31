---@Module MagLib.BDO.Villa
---@alias Villa
local Villa = {}

--- Helper Villa Buff class
local VillaBuff = Class({buffIndex = 0, buffKey = 0, name = "", duration = 0})
function VillaBuff:init(buffIndex, buffKey, name, duration)
	self.buffIndex = buffIndex
	self.buffKey = buffKey
	self.name = name
	self.duration = duration
end

--- List of all villa buffs
Villa.buffs = {}
Villa.buffs[0] = VillaBuff(0, 57240, "Turning Gates (90 min.)", 90)
Villa.buffs[1] = VillaBuff(1, 57241, "Skill and Experience (90 min.)", 90)
Villa.buffs[2] = VillaBuff(2, 57239, "Body Enhancement (90 min.)", 90)
Villa.buffs[3] = VillaBuff(3, 57243, "Turning Gates (180 min.)", 180)
Villa.buffs[4] = VillaBuff(4, 57244, "Skill and Experience (180 min.)", 180)
Villa.buffs[5] = VillaBuff(5, 57242, "Body Enhancement (180 min.)", 180)

--- helper sets of vilal buffs
local turningGateVillaBuffs = {Villa.buffs[0], Villa.buffs[3]}
local skillAndExpBuffs = {Villa.buffs[1], Villa.buffs[4]}
local bodyEnhancementBuffs = {Villa.buffs[2], Villa.buffs[5]}

--- Helper function to check if a buffKey is the key of a VilalBuff in a list of VillaBuff objects
local function isPartOfVillaBuffList(villaBuffList, buffKey)
	for _, villaBuff in pairs(villaBuffList) do
		if villaBuff.buffKey == buffKey then
			return true
		end
	end
	return false
end

--- Helper GameVilla class
local GameVilla = Class({name = "", inviteItemKeys = {}, accessibleBuffs = {}})
function GameVilla:init(name, inviteItemKeys, accessibleBuffs)
	self.name = name
	self.inviteItemKeys = inviteItemKeys
	self.accessibleBuffs = accessibleBuffs
end

---List of all villas in the game
Villa.villas = {
	GameVilla("Kunid's Villa", {1101, 1119}, skillAndExpBuffs),
 GameVilla("Karashu's Villa", {1102, 1120}, turningGateVillaBuffs),
 GameVilla("Amir's Villa", {1103, 1121}, skillAndExpBuffs),
 GameVilla("Shakatu's Villa", {1104, 1122}, turningGateVillaBuffs),
 GameVilla("Alsabi's Villa", {1105, 1123}, skillAndExpBuffs),
 GameVilla("Gahaz's Villa", {1106, 1124}, skillAndExpBuffs),
 GameVilla("Lohan's Villa", {1107, 1125}, bodyEnhancementBuffs),
 GameVilla("Tasaila's Villa", {1108, 1126}, skillAndExpBuffs),
 GameVilla("Kiyak's Villa", {1109, 1127}, turningGateVillaBuffs),
 GameVilla("Muna's Villa", {1110, 1128}, turningGateVillaBuffs),
 GameVilla("Shandi's Villa", {1111, 1129}, skillAndExpBuffs),
 GameVilla("Marzana's Villa", {1112, 1130}, turningGateVillaBuffs),
 GameVilla("Inaha's Villa", {1113, 1131}, skillAndExpBuffs),
 GameVilla("Talia's Villa", {1114, 1132}, turningGateVillaBuffs),
 GameVilla("Atosa's Villa", {1115, 1133}, bodyEnhancementBuffs),
 GameVilla("Dudora's Villa", {1116, 1134}, skillAndExpBuffs),
 GameVilla("Oberin's Villa", {1117, 1135}, skillAndExpBuffs), GameVilla("Naphart Camping Tent", {1118}, {})
}

--[[
Keeping an internal cache of villa invite keys for the specific buff indexes to reduce performance impact of
quering it for every hasVillaInviteForBuff call
]]
local buffInviteKeys = {}
buffInviteKeys[0] = {}
buffInviteKeys[1] = {}
buffInviteKeys[2] = {}
buffInviteKeys[3] = buffInviteKeys[0]
buffInviteKeys[4] = buffInviteKeys[1]
buffInviteKeys[5] = buffInviteKeys[2]

for _, villa in pairs(Villa.villas) do
	local keyListIndex = nil

	if villa.accessibleBuffs == turningGateVillaBuffs then
		keyListIndex = 0
	elseif villa.accessibleBuffs == skillAndExpBuffs then
		keyListIndex = 1
	elseif villa.accessibleBuffs == bodyEnhancementBuffs then
		keyListIndex = 2
	end

	if keyListIndex ~= nil then
		for _, inviteItemKey in pairs(villa.inviteItemKeys) do
			table.insert(buffInviteKeys[keyListIndex], inviteItemKey)
		end
	end
end

---Checks if there is a invite in your inventory that allows the purchase of the given villa buff from either the tent or the villa butler 
---@param index integer villa buff index of wanted buff
---@return boolean true if a qualifying invite is found, else false
function Villa.hasVillaInviteForBuffIndex(index)
	return MagLib.BDO.Inventory.hasAtLeastOneOf(buffInviteKeys[index])
end

---Returns true if any villa invite
---@return boolean true if got any villa invite
function Villa.hasAnyVillaInvite()
	for i = 0, 2 do
		if Villa.hasVillaInviteForBuffIndex(i) then
			return true
		end
	end

	return true
end

---Checks if there is a invite in your inventory that allows the purchase of the given buffKey from either the tent or the villa butler 
---@param buffKey integer key of the buff to check for
---@return boolean true if a qualifying invite is found, else false
function Villa.hasVillaInviteForBuff(buffKey)
	local keyListIndex = nil

	if isPartOfVillaBuffList(turningGateVillaBuffs, buffKey) then
		keyListIndex = 0
	elseif isPartOfVillaBuffList(skillAndExpBuffs, buffKey) then
		keyListIndex = 1
	elseif isPartOfVillaBuffList(bodyEnhancementBuffs, buffKey) then
		keyListIndex = 2
	end

	print(keyListIndex)
	if keyListIndex ~= nil then
		return Villa.hasVillaInviteForBuffIndex(keyListIndex)
	else
		return false
	end
end

MagLib.BDO.Villa = Villa
