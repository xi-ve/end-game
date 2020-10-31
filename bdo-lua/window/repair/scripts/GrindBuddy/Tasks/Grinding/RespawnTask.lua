RespawnTask = {}
RespawnTask.lastChecked = 0
local getTime = Infinity.Win32.GetTickCount

local respawnTypes = {
  [1] = "PaGlobal_DeadMessage_All._eRespawnType.respawnType_NearTown",
  [2] = "PaGlobal_DeadMessage_All._eRespawnType.respawnType_Exploration"
}
local canUseFairyRespawn = function()
  return Infinity.BDO.Lua.Execute("return ToClient_Fairy_CanRespawn()")
end

local respawnNormal = function()
  Infinity.BDO.Lua.Execute(
    [[
    deadMessage_Revival(]] .. respawnTypes[Grinder.settings.respawn_type].. [[, 255, 0, getSelfPlayer():getRegionKey(), false, toInt64(0, 0), false)
    SetUIMode(Defines.UIMode.eUIMode_Default)
    ]]
  )
end

local respawnByFairy = function()
  Infinity.BDO.Lua.Execute(
  [[
    deadMessage_Revival(PaGlobal_DeadMessage_All._eRespawnType.respawnType_Immediate, 255, 0, getSelfPlayer():getRegionKey(), false, toInt64(0, 0), true)  --last true is fairy revive
    SetUIMode(Defines.UIMode.eUIMode_Default)
  ]]
)
end

function RespawnTask.needToRun()
  --Log.debugLog("RespawnTask needToRun")
  if RespawnTask.lastChecked + 542 < Cache.time then
    if Infinity.BDO.Lua.Execute("return GetUIMode() == Defines.UIMode.eUIMode_DeadMessage") then
      return true
    end
  end
  return false
end

local respawnByFairyAt = nil
local fairyRespawnDelay = 10000
function RespawnTask.work()
  Log.debugLog("RespawnTask work")
  --Checking if we should stop the bot upon death and doing so if needed
  if Grinder.settings.stop_on_death then
    Log.log("Stopped bot because we died :((((")
    Grinder.stopBot()
    return
  end

  --Resetting nav fully (unsure if we even need the path = nil?)
  Grinder.currentProfile.nav.reset()
  Grinder.currentProfile.nav.path = nil
  Grinder.currentProfile.nav.stop()

  if Grinder.settings.respawn_by_fairy and canUseFairyRespawn() then
    if respawnByFairyAt == nil then
      Log.log("Respawning by fairy in " .. fairyRespawnDelay .. "ms!")
      respawnByFairyAt = getTime() + fairyRespawnDelay
    else
      if respawnByFairyAt < getTime() then
        Log.log("Respawning by fairy!")
        respawnByFairy()
        respawnByFairyAt = nil
      end
    end

    return
  end

  respawnByFairyAt = nil --We are not reviving by fairy, so let's be safe and reset the var

  if Grinder.settings.respawn_type == 1 or Grinder.settings.respawn_type == 2 then
    Log.log("Respawning to " .. respawnTypes[Grinder.settings.respawn_type])
    respawnNormal()
    return
  elseif Grinder.settings.respawn_type == 3 then
    --Waiting for fairy cd
    Grinder.wait(1000)
    return
  end
  Log.log("Respawning!")
end
