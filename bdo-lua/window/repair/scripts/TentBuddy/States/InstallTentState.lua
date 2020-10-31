InstallTentState = MagLib.Run.States.State("InstallTentState")

local lastInstallReqSent = 0
function InstallTentState:work()
  local settings = MagLib.Core.Settings.getSetting("TentBuddy")

  if not MagLib.BDO.Tent.isInstalled() then
    --Sending tent install request but not spamming it
    if lastInstallReqSent + settings.tentInstallRetryDelay < MagLib.getTime() then
      MagLib.BDO.Tent.install(TentID)
      lastInstallReqSent = MagLib.getTime()
    end

    return false
  else
    --We installed the tent
    return true
  end
end