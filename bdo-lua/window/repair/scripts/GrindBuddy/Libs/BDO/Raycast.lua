Raycast = {}
Raycast.debugging = false
Raycast.raycastDebugTracking = {}

function Raycast.rVec(pos1, pos2)
    --Log.debugLog("Raycast rVec")
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

function Raycast.hasJumpable(from, to)
    Log.debugLog("Raycast hasJumpable")
    local y = from.Y
    to = Vector3(to.X, y, to.Z) --Only look on 2D

    local objectInWay = Raycast.twoPos(from, to, 80, 80)
    if objectInWay then
        local maxHeightAddition = 150
        for heightAddition = 50, maxHeightAddition, 10 do
            if not Raycast.twoPos(Vector3(from.X, y + heightAddition, from.Z), Vector3(to.X, y + heightAddition, to.Z), 80, 100) then
                Log.log("Jumpable Object detected! => Jumping!")

                return true
            end
        end
    end

    return false
end

function Raycast.twoPos(pos1, pos2, heightMod, distance)
    --Log.debugLog("Raycast twoPos")
    --Log.log("there")
    heightMod = heightMod or 100
    pos1 = Vector3(pos1.X, pos1.Y, pos1.Z)
    pos2 = Vector3(pos2.X, pos2.Y, pos2.Z)
    --Log.log("Raycast from " .. pos1.X .. "|" .. pos1.Y .. "|" .. pos1.Z .. " to " .. pos2.X .. "|" .. pos2.Y .. "|" .. pos2.Z)
    if Cache.playerPos:getDistance(pos1) > 4000 or Cache.playerPos:getDistance(pos2) > 4000 then
        return true, 0, nil
    end

    local pos1New = Vector3(pos1.X, pos1.Y + heightMod, pos1.Z)
    local pos2New = Vector3(pos2.X, pos2.Y + heightMod, pos2.Z)
    local rVec = Raycast.rVec(pos1, pos2)
    --Log.log("rVec: " .. VectorUtils.toString(rVec))
    distance = distance or pos1New:getDistance(pos2New)
    local rCast = Infinity.BDO.getSceneManager():CastRay(pos1New, rVec, distance, 1, 32) --1, 32?
    --Log.log("rCast: " .. tostring(rCast))


    if Raycast.debugging then
        table.insert(Raycast.raycastDebugTracking, {pos = pos1New, rVec = rVec, distance = distance, col = rCast, time = Cache.time})
    end

    pos1New = nil
    pos2New = nil


    if rCast == 0 then
        return false, rCast, rVec
    else
        return true, rCast, rVec
    end
end

function Raycast.safeTwoPos(pos1, pos2, heightMod, posMod, distance)
    --Log.debugLog("Raycast safeTwoPos")

    --pos1 = Vector3(pos1.X, pos1.Y, pos1.Z)
    --pos2 = Vector3(pos2.X, pos2.Y, pos2.Z)
    --Log.log("here")

    return Raycast.safeTwoPosOnce(pos1, pos2, heightMod, posMod, distance)

    --Make x strict raycasts (including tunnel for player) from 4 spots on the path to work around raycast bug
    --[[local amountOfChecks = 4
    local rVec = pos1:getDirectionVector(pos2)
    local rVecLength = math.sqrt(((rVec.X ^ 2) + (rVec.Y ^ 2) + (rVec.Z ^ 2)))
    local distanceBetweenPos = pos1:getDistance(pos2)


    local rVecAmountPossible = distanceBetweenPos / rVecLength
    local rVecMultiplier = math.floor(rVecAmountPossible / amountOfChecks)
    local rVecToAdd = Vector3((rVecMultiplier * rVec.X), (rVecMultiplier * rVec.Y), (rVecMultiplier * rVec.Z))
    for i = 0, amountOfChecks do
        local startPos = Vector3(pos1.X + (i * rVecToAdd.X), pos1.Y + (i * rVecToAdd.Y), pos1.Z + (i * rVecToAdd.Z))
        local collision, distance, returnedRVec = Raycast.safeTwoPosOnce(startPos, pos2, heightMod, posMod, distance)
        if collision and distance then
            return collision, distance, rVec
        end
    end
    return false, 0.0, rVec]]

end

function Raycast.safeTwoPosOnce(pos1, pos2, heightMod, posMod, distance)
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

    local c1, rCast1, rVec1 = Raycast.twoPos(pos1_1, pos2_1, heightMod, distance)
    local c2, rCast2, rVec2 = Raycast.twoPos(pos1_2, pos2_2, heightMod, distance)
    local c3, rCast3, rVec3 = Raycast.twoPos(pos1_3, pos2_3, heightMod, distance)
    local c4, rCast4, rVec4 = Raycast.twoPos(pos1_4, pos2_4, heightMod, distance)
    local c5, rCast5, rVec5 = Raycast.twoPos(pos1_5, pos2_5, heightMod, distance)
    local c6, rCast6, rVec6 = Raycast.twoPos(pos1_6, pos2_6, heightMod, distance)
    local c7, rCast7, rVec7 = Raycast.twoPos(pos1_7, pos2_7, heightMod, distance)
    local c8, rCast8, rVec8 = Raycast.twoPos(pos1_8, pos2_8, heightMod, distance)
    local c9, rCast9, rVec9 = Raycast.twoPos(pos1_9, pos2_9, heightMod, distance)
    local c10, rCast10, rVec10 = Raycast.twoPos(pos1_10, pos2_10, heightMod, distance)

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
                                            --Deadgod
                                            return false, rCast10, rVec10
                                        else
                                            return true, rCast10, rVec10
                                        end
                                    else
                                        return true, rCast9, rVec9
                                    end
                                else
                                    return true, rCast8, rVec8
                                end
                            else
                                return true, rCast7, rVec7
                            end
                        else
                            return true, rCast6, rVec6
                        end
                    else
                        return true, rCast5, rVec5
                    end
                else
                    return true, rCast4, rVec4
                end
            else
                return true, rCast3, rVec3
            end
        else
            return true, rCast2, rVec2
        end
    else
        return true, rCast1, rVec1
    end

    Log.log("ERROR: Raycast cast did not return anything.")
end
