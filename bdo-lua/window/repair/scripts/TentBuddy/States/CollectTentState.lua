CollectTentState = MagLib.Run.States.State("CollectTentState")

local lastCollectReqSent = 0
function CollectTentState:work()
  local settings = MagLib.Core.Settings.getSetting("TentBuddy")

  if MagLib.BDO.Tent.isInstalled() then 
      if lastCollectReqSent + settings.tentCollectRetryDelay < MagLib.getTime() then  
        MagLib.BDO.Tent.collect()
        lastCollectReqSent = MagLib.getTime()
      end
      return false
  else
    MagLib.BDO.Tent.closeUI()
    return true
  end
end