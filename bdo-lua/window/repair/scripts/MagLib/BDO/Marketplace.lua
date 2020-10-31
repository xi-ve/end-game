---Marketplace
-- @module MagLib.BDO.Marketplace
-- @alias Marketplace
local Marketplace = {}
local settings = {buyDelay = 1500, marketNPCTalkDistance = 250}
MagLib.Core.Settings.addSettingsToHandler("MagLib_Marketplace", settings)

local getPPos = MagLib.BDO.Actors.LocalPlayer.getPos

-------Open-------------
---Opens Marketplace
Marketplace.open = function()
    Infinity.BDO.Lua.Execute("PaGlobalFunc_MarketPlace_Get():open()")
end
---Opens Marketplace in Maid mode
Marketplace.open_fromMaid = function()
    Infinity.BDO.Lua.Execute("PaGlobalFunc_MarketPlace_OpenByMaid()")
end
---Opens Marketplace over Worldmap
Marketplace.open_fromWorldmap = function()
    Infinity.BDO.Lua.Execute(
        "PaGlobalFunc_MarketPlace_OpenForWorldMap(ToClient_getDefaultTerritoryKey(), false)")
end
---Opens Marketplace over NPC Dialog
Marketplace.open_fromDialog = function()
    Infinity.BDO.Lua.Execute("PaGlobalFunc_MarketPlace_OpenFromDialog()")
end

----Close--------------
---Closes Marketplace
Marketplace.close = function()
    Infinity.BDO.Lua.Execute("PaGlobalFunc_MarketPlace_Close()")
end

----Others------
local openBuyUi = function(itemKey, enhanceLevel)
    local itemEnchantKey = Utils.getItemKeyRaw(itemKey, enhanceLevel)
    local code = [[
  local itemKey = ItemEnchantKey(]] .. itemEnchantKey .. [[)
  ToClient_requestGetBiddingList(itemKey, true, false)
  ]]
    Infinity.BDO.Lua.Execute(code)
end

---Opens the marketplace UI window for a specific item and enhance level. (Loading item data -> figure out right parameters and request open UI -> waiting for updated item data to get received from the server -> UI opens)
-- It will spawn a task that takes several pulses to complete.
---@param itemKey The Item key/id of the wanted item
---@param enhanceLevel the wanted enhance level. You do not need to figure out which level group your enhance level corresponds to (like 0-7, 8-10, etc.). This will be done inside this function automatically.
---@param funcToExecuteOnFinish (optional) this function gets executed once the UI is open. You can use this to open your mutex (that you should have so you do not do other stuff while this tries to open the UI).
Marketplace.openItem = function(itemKey, enhanceLevel, funcToExecuteOnFinish)
    Marketplace.close()
    local requestCode = [[
  ToClient_requestDetailListByWorldMarketByItemKey( ]] .. itemKey .. [[)
  ]]

    local dataLoaded = false
    local runFunc = function(self)
        if not dataLoaded then
            local itemLevelGroups = Infinity.BDO.ItemMarket.getItemLevelGroups()
            for k, v in ipairs(itemLevelGroups) do
                if v:getItemKey() == itemKey then
                    -- we found it
                    -- MagLib.logger.debug("Item found")
                    dataLoaded = true
                    return false
                end
            end
            -- Data not loaded yet
            Infinity.BDO.Lua.Execute(requestCode)
            -- MagLib.logger.debug("Requesting Item Data")
            self:wait(250)
            return false
        elseif not UI.getShow("Panel_Window_MarketPlace_BuyManagement") then
            -- Get proper minLevel and use it to open the buy ui
            local itemLevelGroups = Infinity.BDO.ItemMarket.getItemLevelGroups()
            for k, v in ipairs(itemLevelGroups) do
                if v:getMaxLevel() >= enhanceLevel and v:getMinLevel() <=
                    enhanceLevel then
                    MagLib.logger.trace("Open item UI")
                    openBuyUi(itemKey, v:getMinLevel())
                    self:wait(10)
                end
            end
        else
            if funcToExecuteOnFinish then funcToExecuteOnFinish() end
            MagLib.logger.trace("CM with item open")
            return true
        end
    end
    -- This might take a while to open since we need commands to be executed in different pulses for it to work. Hence we make a task out of it and add the possiblity to execute a function on finish
    local task = MagLib.Run.Tasks.new("RequestItemData Task", 2500, runFunc)
    task.pulseTimingMode = MagLib.Run.EPulseTimingMode.End
end

-----Buy-------
local buyFunc = function(itemKey, enhanceLevel, amount, maxPrice)
    local itemMinLevel = enhanceLevel

    local itemLevelGroups = Infinity.BDO.ItemMarket.getItemLevelGroups()
    for k, v in ipairs(itemLevelGroups) do
        if v:getMaxLevel() >= enhanceLevel and v:getMinLevel() <= enhanceLevel then
            itemMinLevel = v:getMinLevel()
        end
    end

    MagLib.logger.info(
        "Buying item " .. itemKey .. "+" .. enhanceLevel .. " " .. amount ..
            " times for a maximum of " .. maxPrice)
    Infinity.BDO.Lua.Execute(
        "ToClient_requestBuyItemToWorldMarket(" .. itemKey .. ", " ..
            itemMinLevel .. ", " .. amount .. ", " .. maxPrice .. ", " ..
            enhanceLevel .. ")")
end

local isUIOpened = false
local isOpeningUIStarted = false

local currentlyBuying = false
---Opens the UI and buys an item from the Marketplace, then closes UI.
-- It will spawn a task that takes several pulses to complete.
---@param itemKey itemKey of wanted item
---@param enhanceLevel enhanceLevel of wanted item
---@param amount amount to buy
---@param maxPrice max price to buy at
---@param funcToExecuteOnFinish (optional) function to execute after the purchase is done. Use this to reset your mutex (that you should have to block your scripts execution until this finishes)
Marketplace.buy = function(itemKey, enhanceLevel, amount, maxPrice,
                           funcToExecuteOnFinish)
    if currentlyBuying then
        MagLib.logger.error("Buying still in process!")
        return
    end

    currentlyBuying = true

    local taskFunc = function()
        local onFinished = function() isUIOpened = true end

        if not isOpeningUIStarted then -- So we only start it once
            isOpeningUIStarted = true
            isUIOpened = false
            -- We open the UI, this way we can be sure that the item has been loaded successfully
            Marketplace.openItem(itemKey, enhanceLevel, onFinished)
        end

        if isUIOpened == true then
            -- We finished opening the UI
            isOpeningUIStarted = false

            buyFunc(itemKey, enhanceLevel, amount, maxPrice)
            if funcToExecuteOnFinish then funcToExecuteOnFinish() end

            MagLib.BDO.Marketplace.close()
            currentlyBuying = false
            return true
        end

        -- We have not yet finished opening the UI
        return false
    end

    local task = MagLib.Run.Tasks.new("Buy Task", 1000 + settings.buyDelay,
                                      taskFunc)
    task.pulseTimingMode = EPulseTimingMode.End
end

--[[
  Test code:
  local marketNPC = Utils.findNpc_ItemMarket()
  MagLib.BDO.Marketplace.buyAndTransfer(marketNPC, 16002, 0, 1, 198000, function() MagLib.logger.info("Done") end)


]]
-------Buying and transfering-----------

-- TODO:
-- Gets all items that fit the description from the warhouse, then buying the rest that are still needed.
-- Waits until it got all
Marketplace.get = function(marketNPC, itemKey, enhanceLevel, wantedAmount,
                           maxPrice, funcToExecuteOnFinish)
    local runLock = false

    -- Checking how many we got in the Inventory
    -- TODO:
end

BuyAndTransfer_running = false

---Opens the UI and buys an item from the market and then transfers it from the marketplace warehouse to the players inventory over a given marketplace npc.
-- It will spawn a task that takes several pulses to complete.
---@param marketNPC Actor object of the marketplace npc
---@param itemKey itemKey of wanted item
---@param enhanceLevel enhanceLevel of wanted item
---@param amount amount to buy
---@param maxPrice max price to buy at
---@param funcToExecuteOnFinish (optional) function to execute after the purchase is done. Use this to reset your mutex (that you should have to block your scripts execution until this finishes)
Marketplace.buyAndTransfer = function(marketNPC, itemKey, enhanceLevel, amount,
                                      maxPrice, funcToExecuteOnFinish)
    -- TODO: Check if we can actually buy the amount of items for the wanted price, if not return some code to make that clear
    if BuyAndTransfer_running then
        MagLib.logger.error(
            "BuyAndTransfer still in process. Wait for one to finish before starting another process!")
        return
    end

    BuyAndTransfer_running = true
    local bought
    local boughtTime

    local runFunc = function(self)
        -- Buying
        if not bought then
            bought = true
            Marketplace.buy(itemKey, enhanceLevel, amount, maxPrice,
                            function() boughtTime = MagLib.getTime() end)
            return false
        end
        -- Not yet bought
        if not boughtTime then return end

        if boughtTime + settings.buyDelay < MagLib.getTime() then
            -- Not yet transfered, but bought and waited
            Marketplace.Warehouse.transferToInventory_fromNpc(marketNPC,
                                                              itemKey,
                                                              enhanceLevel,
                                                              amount,
                                                              funcToExecuteOnFinish)
            BuyAndTransfer_running = false
            return true
        end
        -- Not yet transfered
        return false
    end

    local task = MagLib.Run.Tasks.new("BuyAndTransferTask", 1 / 0, runFunc)
    task.pulseTimingMode = EPulseTimingMode.End
end

----------Warehouse Stuff---------

local Warehouse = {}

Warehouse.getItemInfo = function(itemKey, enhanceLevel)
    local itemEnchantKey = Utils.getItemKeyRaw(itemKey, enhanceLevel)
    local wItems = Infinity.BDO.ItemMarket.getWarehouseItems()
    for k, item in pairs(wItems) do
        if item:getItemEnchantKey() == itemEnchantKey then return item end
    end
    return nil
end

local transferWalletToInventory =
    function(itemKey, enhanceLevel, amount, byMaid)
        local itemEnchantKey = Utils.getItemKeyRaw(itemKey, enhanceLevel)
        local code = [[
    local itemEnchantKey = ItemEnchantKey(]] .. itemEnchantKey .. [[)
  local amount = ]] .. amount .. [[
  local byMaid = ]] .. tostring(byMaid) .. [[
  requestMoveItemWalletToInventory(itemEnchantKey, amount, false, CppEnums.ItemWhereType.eInventory, byMaid)
  ]]

        Infinity.BDO.Lua.Execute(code)
    end

---Transfer----

---Transfers an item from the marketplace warehouse to inventory over a marketplace npc.
---@param marketNPC Actor object of the marketplace npc
---@param itemKey itemKey of wanted item
---@param enhanceLevel enhanceLevel of wanted item
---@param amount amount to transfer
---@param funcToExecuteOnFinish (optional) function to execute after the purchase is done. Use this to reset your mutex (that you should have to block your scripts execution until this finishes)
-- @return int: 0 if successfully started, -1 is not close enough to NPC and -2 if not enough items in warehouse
Warehouse.transferToInventory_fromNpc = function(marketNPC, itemKey,
                                                 enhanceLevel, amount,
                                                 funcToExecuteOnFinish)
    -- Checking Conditions
    local wItemInfo = Warehouse.getItemInfo(itemKey, enhanceLevel)
    if wItemInfo == nil then
        MagLib.logger.error(
            "Not enough items in warehouse. Wanted " .. itemKey .. " " .. amount ..
                "x but we have none!")

        if funcToExecuteOnFinish then funcToExecuteOnFinish() end

        return -2
    elseif wItemInfo:getCount():getUnsafe() < amount then
        MagLib.logger.error(
            "Not enough items in warehouse. Wanted " .. itemKey .. " " .. amount ..
                "x but we only have " .. tostring(wItemInfo:getCount()) .. "!")

        if funcToExecuteOnFinish then funcToExecuteOnFinish() end
        return -2
    end

    if marketNPC:getPosition():getDistance(getPPos()) >
        settings.marketNPCTalkDistance then
        MagLib.logger.trace("Not close enough to NPC!")

        if funcToExecuteOnFinish then funcToExecuteOnFinish() end

        return -1
    end

    -- Starting Task
    local taskFunc = function(self)
        -- Open Marketplace NPC dialog
        local rotFaceTarget = marketNPC:getPosition():getRotationToFace(
                                  Infinity.BDO.getLocalPlayer():getPosition())
        Infinity.BDO.getLocalPlayer():getCharacterControler()
            :getCharacterScene():setRotation(rotFaceTarget)

        if Infinity.BDO.Selection.getTarget() ~= marketNPC:getActorKey() then
            Infinity.BDO.Selection.setTarget(marketNPC:getActorKey())
            MagLib.logger.trace("Setting Target for interaction")
            return false
        else
            if Interaction.hasInteractable() and Interaction.getTalkNpcKey() ==
                0 then
                Infinity.BDO.getUIManager():setIsCursorActive(false)
                MagLib.logger.trace("Interacting with NPC")
                Interaction.interact(4)
                self:wait(10)
                return false
            end
        end

        -- If we reach this we are now talking with the NPC
        -- Move items
        MagLib.logger.info("Moving the item " .. itemKey .. " + " ..
                               enhanceLevel .. " " .. amount ..
                               "x to the Inventory!")
        transferWalletToInventory(itemKey, enhanceLevel, amount, false)

        -- Closing UI
        MagLib.BDO.Marketplace.close()
        MagLib.BDO.NPC.closeDialog()

        if funcToExecuteOnFinish then funcToExecuteOnFinish() end

        return true
    end
    local task = MagLib.Run.Tasks.new("BuyAndTransferTask", 2500, taskFunc)
    task.pulseTimingMode = EPulseTimingMode.End

    return 0
end

Marketplace.Warehouse = Warehouse

MagLib.BDO.Marketplace = Marketplace
