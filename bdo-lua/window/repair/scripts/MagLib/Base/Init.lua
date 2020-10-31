--- Init MagLib.
-- Initializes all the MagLib Modules and parts that need something done later than their own files load time (for example need some globals that are defined later in the load order).
-- This is the last file that will be loaded, hence all globals are registered.
if MagLib.Core.Settings then
	MagLib.Core.Settings.init()
	if MagLib.settings then
		MagLib.Core.Settings.addSettingsToHandler("MagLib", MagLib.settings)
	end
end

local message = "MagLib Version " .. MagLib.version .. " initialized!"
if MagLib.Core and MagLib.Core.Log then
	MagLib.logger = MagLib.Core.Log.newLogger("MagLib")
	MagLib.logger.info(message)
else
	print(message)
end

if MagLib.Events then
	MagLib.Events.triggerEvent("OnInit_Base")
	MagLib.Events.triggerEvent("AfterInit_Base")
	MagLib.Events.triggerEvent("AfterAfterInit_Base")
end

---Temp adapter for bitwise operations since retail uses lua5.3 and dev build is luajit
if not EnvIsLuaJit then
	-- We are on lua5.3 and not luajit
	local code = [[
    print("Initing bit operations since we are in Lua5.3 rather than LuaJit")
    bit = {}
    bit.band = function(x1, x2) return x1 & x2 end
    bit.bor = function(x1, x2) return x1 | x2 end
    bit.bxor = function(x1, x2) return x1 ~ x2 end
    bit.lshift = function(x, n) return x << n end
    bit.rshift = function(x, n) return x >> n end
    ]]
	local func, error = load(code)
	if error then
		print(error)
	else
		func()
	end
end
