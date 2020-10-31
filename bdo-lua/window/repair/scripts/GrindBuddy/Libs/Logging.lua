Log = {}
Log.buffer = {}
Log.logfile = "\\Logs\\[GrindBuddy]" .. os.date("%c"):gsub(" ", "_"):gsub(":", "_"):gsub("/", "") ..".log"
Log.debugLogfile = "\\Logs\\[GrindBuddy_DEBUG]" .. os.date("%c"):gsub(" ", "_"):gsub(":", "_"):gsub("/", "") ..".log"
-- "\\[Grinder]" ..  os.date("%c"):gsub(" ", "_"):gsub(":", "_"):gsub("/", "") ..".log"

function Log.debugLog(text)
    if Grinder and Grinder.settings and Grinder.settings.log_debug then
        Log.appendToDebugFile(os.date("%c"):gsub(" ", "_"):gsub(":", "_"):gsub("/", "") .. ": " .. text)
    end
end

function Log.log(text, forceOut)
    if (Grinder.settings.log_buffer and not forceOut) then
        table.insert(Log.buffer, text)
    else
        print("[GrindBuddy] " .. text)
        if Grinder.settings.log_to_file then
            Log.appendToFile(text)
        end
    end
end


function Log.onPulse()
    if (Grinder.settings.log_buffer) then
        if #Log.buffer == 0 then
            return
        end

        local text = "\n--------------------"
        for k, v in ipairs(Log.buffer) do
            text = text .. "\n" .. v
        end
        text = text .. "\n--------------------"
        if Grinder.settings.log_to_file then
            Log.appendToFile(text)
        end

        print("[GrindBuddy]: " .. text)
        --

        --Resetting buffer
        Log.buffer = {}
    end
end

Log.lastTimeCheckedLen = 0

function Log.appendToDebugFile(text)
    local logString = Infinity.FileSystem.ReadFile(Log.debugLogfile) .. "\n" .. text
    --If line is over 10k, make a new log file and only put new text in it
    if Log.lastTimeCheckedLen + 2000 < Cache.time then
        local lineCount = select(2, logString :gsub('\n', '\n')) - 1 --Line count without the new line
        if (lineCount > 2000) then
            Log.debugLogfile = "\\Logs\\[GrindBuddy_DEBUG]" .. os.date("%c"):gsub(" ", "_"):gsub(":", "_"):gsub("/", "") ..".log"
            logString = text
        end
        Log.lastTimeCheckedLen = Cache.time

        lineCount = nil
    end
    Infinity.FileSystem.WriteFile(Log.debugLogfile, logString)

    logString = nil
end

function Log.appendToFile(text)
    local logString = Infinity.FileSystem.ReadFile(Log.logfile) .. "\n" .. text
    local lineCount = select(2, logString :gsub('\n', '\n')) - 1 --Line count without the new line
    --If line is over 10k, make a new log file and only put new text in it
    if (lineCount > 10000) then
        Log.logfile = "\\Logs\\[GrindBuddy]" .. os.date("%c"):gsub(" ", "_"):gsub(":", "_"):gsub("/", "") ..".log"
        logString = text
    end
    Infinity.FileSystem.WriteFile(Log.logfile, logString)

    logString = nil
    lineCount = nil
end
