------------------------------------------------------------------------------
-- Version .2 by Triplany 2016-03-28
-- Increased buffer size to 1mb
-----------------------------------------------------------------------------


------------------------------------------------------------------------------
-- Variables
-----------------------------------------------------------------------------

LuaMainWindow = { }
local InputBuffer = '-- Return values in BDO are currently limited to strings, numbers, bools\r\n\r\n' ..
'print("This will Display In Infinity Console if Run in Infinity")\r\n\r\n' ..
'return ("This will display in Lua Consoles lower Panel")'
local OutputBuffer = ""

------------------------------------------------------------------------------
-- Internal variables (Don't touch this if you don't know what you are doing !)
-----------------------------------------------------------------------------

-----------------------------------------------------------------------------
-- LuaMainWindow Functions
-----------------------------------------------------------------------------

function LuaMainWindow.DrawMainWindow()
    local valueChanged = false

        ImGui.Begin("Lua Console")
   
        ImGui.SetWindowSize(ImVec2(500,500), ImGuiCond_FirstUseEver)
   
        local winSize = ImGui.GetWindowSize()
        
        local conSize = ImGui.GetContentRegionAvail()

        local luaInputSize = ImVec2(conSize.x,(conSize.y * 0.75) -15)
        local luaOutputSize = ImVec2(conSize.x,(conSize.y * 0.25) -15)

        __, InputBuffer = ImGui.InputTextMultiline("Lua_Input", InputBuffer, 1024000, luaInputSize, 0)
        ImGui.InputTextMultiline("Lua_Output", OutputBuffer, 1024000, luaOutputSize, 0)
        ImGui.Columns(5,"lua_console_buttons",false)

        if ImGui.Button("Run in Infinity##Lua_Infinity", ImVec2(ImGui.GetColumnWidth(), 20)) then
            OutputBuffer = LuaMainWindow.ExecuteLocalLua(InputBuffer)
            OutputBuffer = "Local Execute:\r\n"..OutputBuffer
        end

        ImGui.NextColumn()

        if ImGui.Button("Run in Bdo##Lua_Bdo", ImVec2(ImGui.GetColumnWidth(), 20)) then
            OutputBuffer = LuaMainWindow.ExecuteBDOLua(InputBuffer)
            OutputBuffer = "BDO Execute:\r\n"..OutputBuffer
        end

        ImGui.NextColumn()

        if ImGui.Button("BDO Globals##Lua_Bdo_globals", ImVec2(ImGui.GetColumnWidth(), 20)) then
            OutputBuffer = LuaMainWindow.getBDOLuaGlobals()
        end

        ImGui.NextColumn()

        if ImGui.Button("Cached Globals##Lua_cached_globals", ImVec2(ImGui.GetColumnWidth(), 20)) then
            OutputBuffer = LuaMainWindow.getCachedGlobalFunctions()
        end

        ImGui.NextColumn()

        if ImGui.Button("Clear All##Lua_Clear", ImVec2(ImGui.GetColumnWidth(), 20)) then
            InputBuffer = ""
            OutputBuffer = ""
        end

        ImGui.End()
    
end

function LuaMainWindow.getCachedGlobalFunctions()
    local outS = ""

    for k,v in pairs(Infinity.BDO.getCachedGlobalFunctions()) do
        
        outS = outS .. tostring(k) .. " -> " .. v .. "\n"
    end

    Infinity.FileSystem.WriteFile("\\infinity_cached_globals.txt", outS)

    return "stored output in infinity_cached_globals.txt"
end

function LuaMainWindow.getBDOLuaGlobals()
    local code =
    [[
        local outBuffer = ""
        
        local nObj = nil
        local tObj = nil
        local iObj = nil

        for n,v in pairs(_G) do
            nObj = n
            tObj = type(v)
                        
            outBuffer = outBuffer .. "Name: " .. nObj .. "\n"            
            outBuffer = outBuffer .. "Type: " .. tObj .. "\n"

            if tObj == "function" then

                iObj = debug.getinfo(v)

                outBuffer = outBuffer .. "\t func - " .. tostring(iObj.func) .. "\n"
                --outBuffer = outBuffer .. "\t nups - " .. tostring(iObj.nups) .. "\n"
                --outBuffer = outBuffer .. "\t namewhat - " .. tostring(iObj.namewhat) .. "\n"
                --outBuffer = outBuffer .. "\t name - " .. tostring(iObj.name) .. "\n"
                --outBuffer = outBuffer .. "\t linedefined - " .. tostring(iObj.linedefined) .. "\n"
                --outBuffer = outBuffer .. "\t short_src - " .. tostring(iObj.short_src) .. "\n"
                --outBuffer = outBuffer .. "\t source - " .. tostring(iObj.source) .. "\n"
                --outBuffer = outBuffer .. "\t what - " .. tostring(iObj.what) .. "\n"
            end

            outBuffer = outBuffer .. "\n"
        end
        
        return outBuffer
    ]]

    local ret = Infinity.BDO.Lua.Execute(code)

    Infinity.FileSystem.WriteFile("\\bdo_lua_globals.txt", ret)

    return "stored output in bdo_lua_globals.txt"
end

function LuaMainWindow.ExecuteLocalLua(script)
    if type(script) ~= "string" then
        return("Unknown script type. Must be String")
    end
    local execString, errorMsg = load(script)
    if execString == nil then
        return errorMsg
    else

        local retBuffer = execString()
        if retBuffer ~= nil then
            if type(retBuffer) == "string" or type(retBuffer) == 'number' then
                return retBuffer
            elseif type(retBuffer) == "boolean" then
                return tostring(retBuffer)
            else
                return "Type Returned: " .. type(retBuffer)
            end
        else
            return "Executing returned nil"
        end
    end

end


function LuaMainWindow.ExecuteBDOLua(script)
    if type(script) ~= "string" then
        return("Unknown script type. Must be String")
    end
    

        local retBuffer = Infinity.BDO.Lua.Execute(script)

        if retBuffer ~= nil then
            if type(retBuffer) == "string" or type(retBuffer) == 'number' then
                return retBuffer
            elseif type(retBuffer) == "boolean" then
                return tostring(retBuffer)
            else
                return "Type Returned: " .. type(retBuffer)
            end
        else
            return "Executing returned nil"
        end
    

end


function LuaMainWindow.OnDrawGuiCallback()
    LuaMainWindow.DrawMainWindow()
end

