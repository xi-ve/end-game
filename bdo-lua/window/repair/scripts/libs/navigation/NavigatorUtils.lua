NavigatorUtils = {}

function NavigatorUtils.TableToVec3(table)
	return Vector3(table.X, table.Y, table.Z)
end

function NavigatorUtils.Vec3ToTable(vec3)
	return {X = vec3.X, Y = vec3.Y, Z = vec3.Z}
end

function NavigatorUtils.GetClosestCheckpoint(checkpoints, pos)
	local closest = nil

	for k,v in pairs(checkpoints) do
		
		if closest == nil then
			closest = {}

			closest.Index = k
			closest.Vec3 = v
		else

			local lastDist = closest.Vec3:getDistance2D(pos)
			local curDist = v:getDistance2D(pos)

			if curDist < lastDist then

				closest.Index = k
				closest.Vec3 = v
			end
		end		
	end

	return closest
end

function NavigatorUtils.GetClosestCheckpointByJSONTable(table, pos)
	local closest = nil

	for k,jsonEntry in pairs(table) do
		
		local v = NavigatorUtils.TableToVec3(jsonEntry)

		if closest == nil then
			closest = {}

			closest.Index = k
			closest.Vec3 = v
		else

			local lastDist = closest.Vec3:getDistance2D(pos)
			local curDist = v:getDistance2D(pos)

			if curDist < lastDist then

				closest.Index = k
				closest.Vec3 = v
			end
		end		
	end

	return closest
end

function NavigatorUtils.isNavMoving()
	local code = 
            [[
                return getSelfPlayer():isNavigationMoving()
            ]]

        return Infinity.BDO.Lua.Execute(code)
end

function NavigatorUtils.moveToAutoPath(destination)
	local code = string.format(
            [[
                ToClient_DeleteNaviGuideByGroup(0)
                local target = float3(%f, %f, %f)
                local key = ToClient_WorldMapNaviStart( target, NavigationGuideParam(), true, true )
                local selfPlayer = getSelfPlayer():get()
                selfPlayer:setNavigationMovePath(key)
                selfPlayer:checkNaviPathUI(key)
            ]], destination.X, destination.Y, destination.Z)

        Infinity.BDO.Lua.Execute(code)
end

function NavigatorUtils.hasNavPath()
	return Infinity.BDO.getWorldmapManager():hasNavPath()
end

function NavigatorUtils.getNavPath()
	return Infinity.BDO.getWorldmapManager():getNavPath()
end