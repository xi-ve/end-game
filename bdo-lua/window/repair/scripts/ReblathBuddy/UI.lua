local UI = MagLib.UI

--[[
  local gameVersion = MagLib.BDO.getGameVersion()
  local isSupportedGameVersion = gameVersion <= ReblathBuddy.supportedGameVersion
----Unsuppored Popups
local unsupportedPopupOpen = false
local unsupportedPopupDraw = function(self)
  unsupportedPopupOpen = true
  UI.Text("ReblathBuddy is not part of the retail scripts just yet. \nIt is meant as a beta for MagLib while also supplying functionality we don't have yet.\nThis means this is not what you pay for, nor do we give compensation for it not being updated.")
  UI.Text("For now, think of this as a nice extra! :)", "FF7CFC00")


  UI.Button("Close", function()
    unsupportedPopupOpen = false
    self:close()
  end)
end

local stoppedDueToVersionPopupOpen = false
local stoppedDueToVersionDraw = function(self)
  if ReblathBuddy.running then
    stoppedDueToVersionPopupOpen = false
    self:close()
  end

  UI.Text("Please manually downgrade your reblaths and start the bot again.")
  UI.Text("This has to be done since ReblathBuddy is not updated for the current game version.")

  UI.Button("Close", function()
    stoppedDueToVersionPopupOpen = false
    self:close()
  end)

  ImGui.SameLine()
  UI.Button("Restart Bot and Close", function()
    ReblathBuddy.running = true
    stoppedDueToVersionPopupOpen = false
    self:close()
  end)
end

AddStoppedDueToVersionPopup = function() --global scope so it can be called from DowngradeState
  if not stoppedDueToVersionPopupOpen then
    stoppedDueToVersionPopupOpen = true
    MagLib.UI.Popups.new("Please downgrade manually!", stoppedDueToVersionDraw, 1 / 0)
  end
end
]]

local resetAmountExctractedButtonFunc = function()
	ReblathBuddy.FSExtractedCount = 0
end

-- UI Drawing
local drawUI = function()
	UI.newWindow("ReblathBuddy V1.1")

	local btnText = "Start"
	if ReblathBuddy.running then
		btnText = "Stop"
	end

	UI.Button(btnText, function()
		ReblathBuddy.running = not ReblathBuddy.running
		if not ReblathBuddy.running then
			-- Just stopped
			MagLib.BDO.Navigation.stop()
		end
	end)

	--[[
  if not isSupportedGameVersion then
    UI.Text("ReblathBuddy does not support build version " .. tostring(math.floor(gameVersion)) .. ".Downgrading will not work.", "FFFF0000")
    ImGui.SameLine()
   if UI.SimpleButton("Why is this?") then
      if not unsupportedPopupOpen then MagLib.UI.Popups.new("Why is ReblathBuddy not updated?", unsupportedPopupDraw, 1 / 0) end
    end
    UI.Text("The bot will stop upon needing to downgrade.", "FFFF0000")
  end
  ]]
	local settings = MagLib.Core.Settings.getSetting("ReblathBuddy")
	UI.Text("Amount of Failstacks extracted: " .. tostring(ReblathBuddy.FSExtractedCount))
	ImGui.SameLine()
	UI.Button("Reset", resetAmountExctractedButtonFunc)
	ImGui.SameLine()
	UI.Text("Current Failstacks:" .. MagLib.BDO.Enhance.getFailstackCount())

	UI.Separator()
	UI.Text("ReblathBuddy will use any of the selected item in your Inventory to failstack!")
	UI.Text("Select an item configuration, put any of that item you have in your inventory and enjoy!")
	settings.itemConfigSelectedIndex = UI.Combo("Item configuration: ", settings.itemConfigSelectedIndex,
                                            	ReblathBuddy.possibleConfigurationNames, true,
                                            	ReblathBuddy.loadItemConfiguration)
	UI.Separator()
	settings.amountOfItemsToStackOn = UI.SliderInt("Amount of items to upgrade simultaneously:",
                                               	settings.amountOfItemsToStackOn, 1, 10, true, nil)
	settings.extractAt = UI.SliderInt("Failstacks to extract at: ", settings.extractAt, 10, 50, true, nil)
	settings.extractionBookAmount = UI.SliderInt("Extraction books to buy at at once: ", settings.extractionBookAmount, 0,
                                             	20, true, nil)
	settings.enhanceSpeed = UI.SliderInt("Enhancement speed: ", settings.enhanceSpeed, 1, 10, true, nil)
	if settings.enhanceSpeed > 5 then
		UI.Text("With a high enhance speed ReblathBuddy might overshoot the wanted failstack amount.", "FFeb8f34")
		UI.Text("ReblathBuddy will then run to the Blacksmith and buy an appropriate extraction book.", "FFeb8f34")
		UI.Text("This might cost extra time. It will work as intended, though to increase speed after overshooting",
        		"FFeb8f34")
		UI.Text("It is recommended to keep some of the next tier extraction book in your Inventory.", "FFeb8f34")
	end

	UI.Text("ReblathBuddy will get Armor/Weapon Stones from your Velia Storage if there are none in your inventory")
	settings.stonesToKeep = UI.InputInt("Armor/Weapon Stone amount to transfere at once:", settings.stonesToKeep, 10, 100,
                                    	true, nil)
	settings.minStonesBeforeCheckingStorage = UI.InputInt("Minimum amounts of stones before starting to enhance",
                                                      	settings.minStonesBeforeCheckingStorage, 10, 100, true, nil)
	settings.stopAtExtractedAmount = UI.InputInt("Stop after extracting amount (0 for infinite):",
                                             	settings.stopAtExtractedAmount, 1, 10, true, nil)

	UI.Text("Main State Manager --> " .. tostring(ReblathBuddy.mainStateManager))
	UI.endWindow()
end

local draw = true
local onGuiDraw = function()
	if draw then
		MagLib.Core.Try(drawUI, function(error)
			print("Error in UI: " .. tostring(error))
			draw = false
		end)
	end
end

Infinity.Scripting.CurrentScript:RegisterCallback("Infinity.OnGUIDraw", function()
	onGuiDraw()
end)
