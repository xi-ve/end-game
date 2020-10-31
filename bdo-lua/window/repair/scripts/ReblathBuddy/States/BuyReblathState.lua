local work = function(self)

  local reblathItemKey = settings.reblathItemKey
  local wantedReblathAmount = settings.reblathAmount
  local reblathAmount = MagLib.Game.Inventory.getItemCount(reblathItemKey)
  if reblathAmount >= wantedReblathAmount then
    return true
  end

  local reblathNeeded = wantedReblathAmount - reblathAmount
  if reblathNeeded > 0 then
    local npcData = MagLib.Navigation.Graph.Profiles.currentProfile.npcs["Repair"][1]
    local atNPC = MagLib.Navigation.activeMoveToNpc(npcData, 250)
    if atNPC then
      local npcActor = MagLib.Game.Actors.getActorWithId(40008, EActorType_Npc)
      RB.logger.info("Buying " .. reblathNeeded .. " reblath for upgrading")
      MagLib.Game.NPC.Shop.buy(npcActor, reblathItemKey, reblathNeeded, 0, false)
      --Wait a reasonable amount to allow it to buy everything
      local shopSettings = MagLib.Core.Settings.getSetting("MagLib_Shop")
      local delayTime = reblathNeeded * shopSettings.buyDelay + 1000
      --buyDelay is the amount of time it waits after every buy. So we can calculate an estimate time it will need + some buffer
      self.wait(delayTime)
    end
  end
  return false
end


BuyReblathState = MagLib.Run.States.State("BuyReblathState", work)
