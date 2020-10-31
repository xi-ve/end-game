MagLib.BDO.Raycast = {}
MagLib.BDO.Raycast.debugging = false
MagLib.BDO.Raycast.raycastDebugTracking = {}

local getPPos = MagLib.BDO.Actors.LocalPlayer.getPos

function MagLib.BDO.Raycast.rVec(pos1, pos2)
	local rVec = Vector3(pos2.X - pos1.X, pos2.Y - pos1.Y, pos2.Z - pos1.Z)
	if rVec.X == 0 and rVec.Y == 0 and rVec.Z == 0 then
		return Vector3(0, 0, 0)
	end
	local rVecLength = math.sqrt(((rVec.X ^ 2) + (rVec.Y ^ 2) + (rVec.Z ^ 2)))
	local rVecMultiplier = 1 / rVecLength
	local normedRVec = Vector3(rVec.X * rVecMultiplier, rVec.Y * rVecMultiplier, rVec.Z * rVecMultiplier)

	rVec = nil
	rVecLength = nil
	rVecMultiplier = nil

	return normedRVec
end

function MagLib.BDO.Raycast.hasJumpable(from, to)
	local y = from.Y
	to = Vector3(to.X, y, to.Z) -- Only look on 2D
	--[[local objectInWay = false

    for heightAddition = 30, 60, 10 do
        if MagLib.BDO.Raycast.twoPos(from, Vector3(to.X, to.Y + heightAddition, to.Z), 50, 40) then
            objectInWay = true
        end
    end]]

	local objectInWay = MagLib.BDO.Raycast.twoPos(from, to, 80, 80)
	-- print("Object in the way: " .. tostring(objectInWay))
	if objectInWay then
		local maxHeightAddition = 150
		for heightAddition = 50, maxHeightAddition, 10 do
			if not MagLib.BDO.Raycast.twoPos(Vector3(from.X, y + heightAddition, from.Z),
                                  			Vector3(to.X, y + heightAddition, to.Z), 80, 100) then
				maxHeightAddition = nil
				y = nil
				objectInWay = nil

				return true
			end
		end

		maxHeightAddition = nil
	end

	y = nil
	objectInWay = nil

	return false
end

function MagLib.BDO.Raycast.twoPos(pos1, pos2, heightMod, distance)
	-- Log.debugLog("Raycast twoPos")
	-- Log.log("there")
	heightMod = heightMod or 100
	pos1 = Vector3(pos1.X, pos1.Y, pos1.Z)
	pos2 = Vector3(pos2.X, pos2.Y, pos2.Z)
	local pPos = getPPos()

	if pPos:getDistance(pos1) > 4000 or pPos:getDistance(pos2) > 4000 then
		return true, 0, nil
	end

	local pos1New = Vector3(pos1.X, pos1.Y + heightMod, pos1.Z)
	local pos2New = Vector3(pos2.X, pos2.Y + heightMod, pos2.Z)
	local rVec = MagLib.BDO.Raycast.rVec(pos1, pos2)
	distance = distance or pos1New:getDistance(pos2New)
	local rCast = Infinity.BDO.getSceneManager():CastRay(pos1New, rVec, distance, 1, 32) -- 1, 32?

	if MagLib.BDO.Raycast.debugging then
		table.insert(MagLib.BDO.Raycast.raycastDebugTracking,
             		{pos = pos1New, rVec = rVec, distance = distance, col = rCast, time = MagLib.getTime()})
	end

	pos1New = nil
	pos2New = nil

	if rCast == 0 then
		return false, rCast, rVec
	else
		return true, rCast, rVec
	end
end

function MagLib.BDO.Raycast.safeTwoPos(pos1, pos2, heightMod, posMod, distance)
	return MagLib.BDO.Raycast.safeTwoPosOnce(pos1, pos2, heightMod, posMod, distance)
end

function MagLib.BDO.Raycast.safeTwoPosOnce(pos1, pos2, heightMod, posMod, distance)
	heightMod = heightMod or 75
	posMod = posMod or 40

	local pos1_1 = Vector3(pos1.X, pos1.Y, pos1.Z)
	local pos1_2 = Vector3(pos1.X + posMod, pos1.Y, pos1.Z)
	local pos1_3 = Vector3(pos1.X + posMod, pos1.Y, pos1.Z + posMod)
	local pos1_4 = Vector3(pos1.X, pos1.Y, pos1.Z + posMod)
	local pos1_5 = Vector3(pos1.X - posMod, pos1.Y, pos1.Z)
	local pos1_6 = Vector3(pos1.X - posMod, pos1.Y, pos1.Z - posMod)
	local pos1_7 = Vector3(pos1.X, pos1.Y, pos1.Z - posMod)
	local pos1_8 = Vector3(pos1.X - posMod, pos1.Y, pos1.Z)
	local pos1_9 = Vector3(pos1.X - posMod, pos1.Y, pos1.Z + posMod)
	local pos1_10 = Vector3(pos1.X + posMod, pos1.Y, pos1.Z - posMod)

	local pos2_1 = Vector3(pos2.X, pos2.Y, pos2.Z)
	local pos2_2 = Vector3(pos2.X + posMod, pos2.Y, pos2.Z)
	local pos2_3 = Vector3(pos2.X + posMod, pos2.Y, pos2.Z + posMod)
	local pos2_4 = Vector3(pos2.X, pos2.Y, pos2.Z + posMod)
	local pos2_5 = Vector3(pos2.X - posMod, pos2.Y, pos2.Z)
	local pos2_6 = Vector3(pos2.X - posMod, pos2.Y, pos2.Z - posMod)
	local pos2_7 = Vector3(pos2.X, pos2.Y, pos2.Z - posMod)
	local pos2_8 = Vector3(pos2.X - posMod, pos2.Y, pos2.Z)
	local pos2_9 = Vector3(pos2.X - posMod, pos2.Y, pos2.Z + posMod)
	local pos2_10 = Vector3(pos2.X + posMod, pos2.Y, pos2.Z - posMod)

	local c1, rCast1, rVec1 = MagLib.BDO.Raycast.twoPos(pos1_1, pos2_1, heightMod, distance)
	local c2, rCast2, rVec2 = MagLib.BDO.Raycast.twoPos(pos1_2, pos2_2, heightMod, distance)
	local c3, rCast3, rVec3 = MagLib.BDO.Raycast.twoPos(pos1_3, pos2_3, heightMod, distance)
	local c4, rCast4, rVec4 = MagLib.BDO.Raycast.twoPos(pos1_4, pos2_4, heightMod, distance)
	local c5, rCast5, rVec5 = MagLib.BDO.Raycast.twoPos(pos1_5, pos2_5, heightMod, distance)
	local c6, rCast6, rVec6 = MagLib.BDO.Raycast.twoPos(pos1_6, pos2_6, heightMod, distance)
	local c7, rCast7, rVec7 = MagLib.BDO.Raycast.twoPos(pos1_7, pos2_7, heightMod, distance)
	local c8, rCast8, rVec8 = MagLib.BDO.Raycast.twoPos(pos1_8, pos2_8, heightMod, distance)
	local c9, rCast9, rVec9 = MagLib.BDO.Raycast.twoPos(pos1_9, pos2_9, heightMod, distance)
	local c10, rCast10, rVec10 = MagLib.BDO.Raycast.twoPos(pos1_10, pos2_10, heightMod, distance)

	pos1_1 = nil
	pos1_2 = nil
	pos1_3 = nil
	pos1_4 = nil
	pos1_5 = nil
	pos1_6 = nil
	pos1_7 = nil
	pos1_8 = nil
	pos1_9 = nil
	pos1_10 = nil

	if not c1 then
		if not c2 then
			if not c3 then
				if not c4 then
					if not c5 then
						if not c6 then
							if not c7 then
								if not c8 then
									if not c9 then
										if not c10 then
											c1 = nil
											c2 = nil
											c3 = nil
											c4 = nil
											c5 = nil
											c6 = nil
											c7 = nil
											c8 = nil
											c9 = nil
											c10 = nil
											return false, rCast10, rVec10
										else
											c1 = nil
											c2 = nil
											c3 = nil
											c4 = nil
											c5 = nil
											c6 = nil
											c7 = nil
											c8 = nil
											c9 = nil
											c10 = nil
											return true, rCast10, rVec10
										end
									else
										c1 = nil
										c2 = nil
										c3 = nil
										c4 = nil
										c5 = nil
										c6 = nil
										c7 = nil
										c8 = nil
										c9 = nil
										c10 = nil
										return true, rCast9, rVec9
									end
								else
									c1 = nil
									c2 = nil
									c3 = nil
									c4 = nil
									c5 = nil
									c6 = nil
									c7 = nil
									c8 = nil
									c9 = nil
									c10 = nil
									return true, rCast8, rVec8
								end
							else
								c1 = nil
								c2 = nil
								c3 = nil
								c4 = nil
								c5 = nil
								c6 = nil
								c7 = nil
								c8 = nil
								c9 = nil
								c10 = nil
								return true, rCast7, rVec7
							end
						else
							c1 = nil
							c2 = nil
							c3 = nil
							c4 = nil
							c5 = nil
							c6 = nil
							c7 = nil
							c8 = nil
							c9 = nil
							c10 = nil
							return true, rCast6, rVec6
						end
					else
						c1 = nil
						c2 = nil
						c3 = nil
						c4 = nil
						c5 = nil
						c6 = nil
						c7 = nil
						c8 = nil
						c9 = nil
						c10 = nil
						return true, rCast5, rVec5
					end
				else
					c1 = nil
					c2 = nil
					c3 = nil
					c4 = nil
					c5 = nil
					c6 = nil
					c7 = nil
					c8 = nil
					c9 = nil
					c10 = nil
					return true, rCast4, rVec4
				end
			else
				c1 = nil
				c2 = nil
				c3 = nil
				c4 = nil
				c5 = nil
				c6 = nil
				c7 = nil
				c8 = nil
				c9 = nil
				c10 = nil
				return true, rCast3, rVec3
			end
		else
			c1 = nil
			c2 = nil
			c3 = nil
			c4 = nil
			c5 = nil
			c6 = nil
			c7 = nil
			c8 = nil
			c9 = nil
			c10 = nil
			return true, rCast2, rVec2
		end
	else
		c1 = nil
		c2 = nil
		c3 = nil
		c4 = nil
		c5 = nil
		c6 = nil
		c7 = nil
		c8 = nil
		c9 = nil
		c10 = nil
		return true, rCast1, rVec1
	end

	MagLib.logger.info("ERROR: Raycast cast did not return anything.")
end
