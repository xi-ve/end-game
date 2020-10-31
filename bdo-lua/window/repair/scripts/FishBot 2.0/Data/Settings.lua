Settings = { }
Settings.__index = Settings

setmetatable(Settings, {
  __call = function (cls, ...)
    return cls.new(...)
  end,
})

function Settings.new()
  local self = setmetatable({}, Settings)
 
  self.Security = {}
  self.Security.NearbyPlayers_Crouch = true
  self.Security.EquipCamo_NearbyPlayers = true

  self.RenderSpot = false
 
  self.Paths = {}  
  self.Paths.Repair = ""
  self.Paths.Market = ""
  self.Paths.Storage = ""
  self.Paths.Trade = ""
  self.Paths.Vendor = ""

  self.TeleportDelay = 25
  self.AutoDelay = true
  self.UseCrouchWhileTeleport = true
  self.VerticalOffset = 0

  self.FishingSpot = {X = 0, Y = 0, Z = 0}
  self.FishingSpotDirection = 0.00

  self.PredictGrades = {}
  self.PredictGrades.White = {Enabled = false}
  self.PredictGrades.Green = {Enabled = true}
  self.PredictGrades.Blue = {Enabled = false}
  self.PredictGrades.Yellow = {Enabled = false}
  self.PredictGrades.Orange = {Enabled = false}

  self.CatchGrades = {}
  self.CatchGrades.White = {Enabled = false}
  self.CatchGrades.Green = {Enabled = true}
  self.CatchGrades.Blue = {Enabled = false}
  self.CatchGrades.Yellow = {Enabled = false}
  self.CatchGrades.Orange = {Enabled = false}

  self.Items = {}
  self.AllLoot = {Enabled = false}

  self.TradeList = {}
  self.MinTradeItemCount = 20

  self.VendorList = {}
  self.MinVendorItemCount = 20

  self.MarketList = {}
  self.MinMarketItemCount = 30
  self.OnlyMaids = false

  self.TransferContainer = {}
  self.TransferContainerMinCount = 10

  self.VendorWhileRepair = true
  self.UseInventorySilverToRepair = false
  self.InstallTent = false
  self.TentSpot = {X = 0, Y = 0, Z = 0}

  return self
end
