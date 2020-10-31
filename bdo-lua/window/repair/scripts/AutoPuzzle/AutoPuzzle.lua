AutoPuzzle = { }
AutoPuzzle.Running = false

AutoPuzzle.Settings = Settings()

local lastTick = 0

local ID_Relic = 40218
local ID_UnderwaterRelicRed = 40547
local ID_UnderwaterRelicBlack = 40548
local ID_Book = 40220
local ID_Scroll = 40228
local ID_Doll = 40383

local ID_Turkey1 = 16474
local ID_Turkey2 = 16475
local ID_Turkey3 = 16476
local patternTurkey = {2, 3, 4}

local ID_SONGPYON1 = 40272
local ID_SONGPYON2 = 40273
local ID_SONGPYON3 = 40274
local patternSONGPYON = {2, 3, 4}

local ID_Anniversary1 = 40444
local ID_Anniversary2 = 40445
local patternAnniversary = {2, 3}

local ID_MOONSTAR1 = 750099
local ID_MOONSTAR2 = 750100
local patternMoonStar = {2, 3}

function AutoPuzzle.OnAutoLoginAutoLoad()
    AutoPuzzle.StartBot()
end

function AutoPuzzle.Start()
    AutoPuzzle.LoadSettings()
end

function AutoPuzzle.StartBot()
    AutoPuzzle.Running = true
end

function AutoPuzzle.Stop()
    AutoPuzzle.SaveSettings()
end

function AutoPuzzle.StopBot()
    AutoPuzzle.Running = false
end

function AutoPuzzle.OnPulse()
    if AutoPuzzle.Running == false then
        return
    end

    if lastTick + 1000 > Infinity.Win32.GetTickCount() then
        return
    end

    lastTick = Infinity.Win32.GetTickCount()

    AutoPuzzle.doCombine()
end

function AutoPuzzle.OnGuiDraw()
    MainWindow.DrawMainWindow()
end

function AutoPuzzle.SaveSettings()
    local json = JSON:new()
    Infinity.FileSystem.WriteFile("Settings.json", json:encode_pretty(AutoPuzzle.Settings))
end

function AutoPuzzle.LoadSettings()
    local json = JSON:new()
    AutoPuzzle.Settings = Settings()

    table.merge(AutoPuzzle.Settings, json:decode(Infinity.FileSystem.ReadFile("Settings.json")))
end

function AutoPuzzle.combineRelics()
    Inventory.combinePuzzle(ID_Relic)
end

function AutoPuzzle.combineBooks()
    Inventory.combinePuzzle(ID_Book)
end

function AutoPuzzle.combineScrolls()
    Inventory.combinePuzzle(ID_Scroll)
end

function AutoPuzzle.combineDolls()
    Inventory.combinePuzzle(ID_Doll)
end

function AutoPuzzle.combineTurkeyEvent()

    local slotItemTurkey1 = Inventory.getItemSlotItemId(ID_Turkey1)
    local slotItemTurkey2 = Inventory.getItemSlotItemId(ID_Turkey2)
    local slotItemTurkey3 = Inventory.getItemSlotItemId(ID_Turkey3)

    if Inventory.hasPuzzleReady() then

        Inventory.makePuzzle()
        return
    end

    if slotItemTurkey1 ~= patternTurkey[1] then

        Inventory.swapItem(slotItemTurkey1, patternTurkey[1])
        return
    end

    if slotItemTurkey2 ~= patternTurkey[2] then

        Inventory.swapItem(slotItemTurkey2, patternTurkey[2])
        return
    end

    if slotItemTurkey3 ~= patternTurkey[3] then

        Inventory.swapItem(slotItemTurkey3, patternTurkey[3])
        return
    end

    if Inventory.hasPuzzleReady() then

        Inventory.makePuzzle()
        return
    end
end

function AutoPuzzle.combineUnderwaterRelic()

    local slotItemRedRelic = Inventory.getItemSlotItemId(ID_UnderwaterRelicRed)
    local slotItemBlackRelic = Inventory.getItemSlotItemId(ID_UnderwaterRelicBlack)

    if Inventory.hasPuzzleReady() then

        Inventory.makePuzzle()
        return
    end

    if slotItemRedRelic ~= patternAnniversary[1] then

        Inventory.swapItem(slotItemRedRelic, patternAnniversary[1])
        return
    end

    if slotItemBlackRelic ~= patternAnniversary[2] then

        Inventory.swapItem(slotItemBlackRelic, patternAnniversary[2])
        return
    end

    if Inventory.hasPuzzleReady() then

        Inventory.makePuzzle()
        return
    end
end

function AutoPuzzle.combineSONGPYONEvent()

    local slotItemSONGPYON1 = Inventory.getItemSlotItemId(ID_SONGPYON1)
    local slotItemSONGPYON2 = Inventory.getItemSlotItemId(ID_SONGPYON2)
    local slotItemSONGPYON3 = Inventory.getItemSlotItemId(ID_SONGPYON3)

    if Inventory.hasPuzzleReady() then

        Inventory.makePuzzle()
        return
    end

    if slotItemSONGPYON1 ~= patternSONGPYON[1] then

        Inventory.swapItem(slotItemSONGPYON1, patternSONGPYON[1])
        return
    end

    if slotItemSONGPYON2 ~= patternSONGPYON[2] then

        Inventory.swapItem(slotItemSONGPYON2, patternSONGPYON[2])
        return
    end

    if slotItemSONGPYON3 ~= patternSONGPYON[3] then

        Inventory.swapItem(slotItemSONGPYON3, patternSONGPYON[3])
        return
    end

    if Inventory.hasPuzzleReady() then

        Inventory.makePuzzle()
        return
    end
end

function AutoPuzzle.combineAnniversaryEvent()

    local slotItemAnniversary1 = Inventory.getItemSlotItemId(ID_Anniversary1)
    local slotItemAnniversary2 = Inventory.getItemSlotItemId(ID_Anniversary2)

    if Inventory.hasPuzzleReady() then

        Inventory.makePuzzle()
        return
    end

    if slotItemAnniversary1 ~= patternAnniversary[1] then

        Inventory.swapItem(slotItemAnniversary1, patternAnniversary[1])
        return
    end

    if slotItemAnniversary2 ~= patternAnniversary[2] then

        Inventory.swapItem(slotItemAnniversary2, patternAnniversary[2])
        return
    end

    if Inventory.hasPuzzleReady() then

        Inventory.makePuzzle()
        return
    end
end

function AutoPuzzle.combineMoonStarEvent()

    local slotItemMoonstar1 = Inventory.getItemSlotItemId(ID_MOONSTAR1)
    local slotItemMoonstar2 = Inventory.getItemSlotItemId(ID_MOONSTAR2)

    if Inventory.hasPuzzleReady() then

        Inventory.makePuzzle()
        return
    end

    if slotItemMoonstar1 ~= patternMoonStar[1] then

        Inventory.swapItem(slotItemMoonstar1, patternMoonStar[1])
        return
    end

    if slotItemMoonstar2 ~= patternMoonStar[2] then

        Inventory.swapItem(slotItemMoonstar2, patternMoonStar[2])
        return
    end

    if Inventory.hasPuzzleReady() then

        Inventory.makePuzzle()
        return
    end
end

function AutoPuzzle.doCombine()
    if Inventory.getItemCountByItemId(ID_Relic, 0) >= 5 then
        AutoPuzzle.combineRelics()
    end

    if Inventory.getItemCountByItemId(ID_Book, 0) >= 5 then
        AutoPuzzle.combineBooks()
    end

    if Inventory.getItemCountByItemId(ID_Scroll, 0) >= 5 then
        AutoPuzzle.combineScrolls()
    end

    if Inventory.getItemCountByItemId(ID_Doll, 0) >= 5 then
        AutoPuzzle.combineDolls()
    end

    if Inventory.getItemCountByItemId(ID_Turkey1, 0) >= 1 and Inventory.getItemCountByItemId(ID_Turkey2, 0) >= 1 and Inventory.getItemCountByItemId(ID_Turkey3, 0) >= 1 then
        AutoPuzzle.combineTurkeyEvent()
    end

    if Inventory.getItemCountByItemId(ID_UnderwaterRelicRed, 0) >= 1 and Inventory.getItemCountByItemId(ID_UnderwaterRelicBlack, 0) >= 1 then
        AutoPuzzle.combineUnderwaterRelic()
    end

    if Inventory.getItemCountByItemId(ID_SONGPYON1, 0) >= 1 and Inventory.getItemCountByItemId(ID_SONGPYON2, 0) >= 1 and Inventory.getItemCountByItemId(ID_SONGPYON3, 0) >= 1 then
        AutoPuzzle.combineSONGPYONEvent()
    end

    if Inventory.getItemCountByItemId(ID_Anniversary1, 0) >= 1 and Inventory.getItemCountByItemId(ID_Anniversary2, 0) >= 1 then
        AutoPuzzle.combineAnniversaryEvent()
    end

    if Inventory.getItemCountByItemId(ID_MOONSTAR1, 0) >= 1 and Inventory.getItemCountByItemId(ID_MOONSTAR2, 0) >= 1 then
        AutoPuzzle.combineMoonStarEvent()
    end

end
