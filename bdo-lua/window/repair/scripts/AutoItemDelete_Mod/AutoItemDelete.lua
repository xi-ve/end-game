AutoItemDelete = { }
AutoItemDelete.Running = false

AutoItemDelete.Settings = Settings()
AutoItemDelete.CurrentProfile = ProfileSettings()

function AutoItemDelete.OnAutoLoginAutoLoad()
  AutoItemDelete.StartBot()
end

function AutoItemDelete.Start()
  AutoItemDelete.LoadSettings()

  if AutoItemDelete.Settings.LastProfile ~= "" then
    print("Loading Last Profile")
    AutoItemDelete.LoadLastProfile()
  end
end

function AutoItemDelete.StartBot()
  if AutoItemDelete.CurrentProfile.Name == "" then
    print("No Profile Selected")
    return
  end

  AutoItemDelete.Cleanup()

  AutoItemDelete.Running = true
end

function AutoItemDelete.Stop()

  AutoItemDelete.SaveCurrentProfile()
  AutoItemDelete.SaveSettings()
end

function AutoItemDelete.StopBot()
  AutoItemDelete.Running = false
end

function AutoItemDelete.OnGuiDraw()
  MainWindow.DrawMainWindow()
end

function AutoItemDelete.SaveSettings()
  local json = JSON:new()
  Infinity.FileSystem.WriteFile("Settings.json", json:encode_pretty(AutoItemDelete.Settings))
end

function AutoItemDelete.SaveCurrentProfile()
  if AutoItemDelete.CurrentProfile.Name == "" then
    return
  end

  local json = JSON:new()
  Infinity.FileSystem.WriteFile("Profiles\\" .. AutoItemDelete.CurrentProfile.Name .. ".json", json:encode_pretty(AutoItemDelete.CurrentProfile))
end

function AutoItemDelete.LoadLastProfile()
  local json = JSON:new()
  AutoItemDelete.CurrentProfile = ProfileSettings()

  table.merge(AutoItemDelete.CurrentProfile, json:decode(Infinity.FileSystem.ReadFile("Profiles\\" .. AutoItemDelete.Settings.LastProfile)))
end

function AutoItemDelete.LoadSettings()
  local json = JSON:new()
  AutoItemDelete.Settings = Settings()

  table.merge(AutoItemDelete.Settings, json:decode(Infinity.FileSystem.ReadFile("Settings.json")))
end

local lastTimeCleaned = 0
function AutoItemDelete.OnPulse()
  if not AutoItemDelete.Running then
    return
  end

  if lastTimeCleaned + AutoItemDelete.CurrentProfile.CleanupTimeInterval < Infinity.Win32:GetTickCount() then
    AutoItemDelete.Cleanup()
  end
end

function AutoItemDelete.Cleanup()
  local invenMaxSize = Inventory.getMaxSize()

  for i = 0, invenMaxSize - 1 do
    if Inventory.hasItemWrapper(i) then
      local name
      local itemId
      local count
      local enchantKey

      name, itemId, count, enchantKey = Inventory.getItemData(i)

      if name ~= nil and itemId ~= nil then

        if AutoItemDelete.shouldNotLoot(enchantKey) then

          print("Delete item on slot " .. i)
          Inventory.deleteItem(i)
        end
      end
    end
  end

  lastTimeCleaned = Infinity.Win32:GetTickCount()
end

function AutoItemDelete.shouldNotLoot(itemId)
  for k, v in pairs(AutoItemDelete.CurrentProfile.BlackList) do

    if v.ItemId == itemId then

      return true
    end
  end

  return false
end
