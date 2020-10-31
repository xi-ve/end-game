Utils = {}

function Utils.getItemKeyRaw(itemId, enchantlevel)
	return tonumber(string.format("%02x00%02x",enchantlevel, itemId), 16)
end

function Utils.getEnchantLevel(itemKeyRaw)
	if itemKeyRaw == nil then
		return 0
	end

	return bit.rshift(itemKeyRaw,24)
end

function Utils.getItemId(itemKeyRaw)
	if itemKeyRaw == nil then
		return 0
	end
	
	return bit.band(itemKeyRaw, 0xFFFFF)
end

function Utils.findNpc_NormalShop()
	local actor = nil
	local lastDist = 10000000

	for k,v in pairs(Infinity.BDO.getActorList(EActorType_Npc)) do
		if table.find(Statics.Npc.NormalShop, v:getActorId()) then
			
			local dist = v:getPosition():getDistance(Infinity.BDO.getLocalPlayer():getPosition())

			if dist < lastDist then

				lastDist = dist
				actor = v
			end
		end
	end

	return actor
end

function Utils.findNpc_ItemMarket()
	local actor = nil

	for k,v in pairs(Infinity.BDO.getActorList(EActorType_Npc)) do
		if table.find(Statics.Npc.ItemMarket, v:getActorId()) then
			actor = v
			break
		end
	end

	return actor
end

function Utils.findNpc_Repair()
	local actor = nil

	for k,v in pairs(Infinity.BDO.getActorList(EActorType_Npc)) do
		if table.find(Statics.Npc.Repair, v:getActorId()) then
			actor = v
			break
		end
	end

	return actor
end

function Utils.findNpc_Trade()
	local actor = nil

	for k,v in pairs(Infinity.BDO.getActorList(EActorType_Npc)) do
		if table.find(Statics.Npc.TradeManager, v:getActorId()) then
			actor = v
			break
		end
	end

	return actor
end

function Utils.findNpc_Warehouse()
	local actor = nil

	for k,v in pairs(Infinity.BDO.getActorList(EActorType_Npc)) do
		if table.find(Statics.Npc.Warehouse, v:getActorId()) then
			actor = v
			break
		end
	end

	return actor
end

function Utils.findNpc_Stable()
	local actor = nil

	for k,v in pairs(Infinity.BDO.getActorList(EActorType_Npc)) do
		if table.find(Statics.Npc.Stable, v:getActorId()) then
			actor = v
			break
		end
	end

	return actor
end

function Utils.findNpc_StableShop()
	local actor = nil

	for k,v in pairs(Infinity.BDO.getActorList(EActorType_Npc)) do
		if table.find(Statics.Npc.StableShop, v:getActorId()) then
			actor = v
			break
		end
	end

	return actor
end

function Utils.findInstallation_Container()
	local actor = nil

	for k,v in pairs(Infinity.BDO.getActorList(EActorType_Installation)) do
		if v:getActorId() == 4001 then
			actor = v
			break
		end
	end

	return actor
end

function Utils.findVehicle_Campsite()
	local actor = nil

	for k,v in pairs(Infinity.BDO.getActorList(EActorType_Vehicle)) do
		if v:getActorId() == 9999 then
			actor = v
			break
		end
	end

	return actor
end

function Utils.numberCommaValue(amount)
  if not amount then
    return "?"
  end
  local formatted = amount
  while true do  
    formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1,%2')
    if (k==0) then
      break
    end
  end
  return formatted
end