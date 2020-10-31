EPulseTimingMode = Enum("EPulseTimingMode", true)

EPulseTimingMode:add("Beginning") -- Run at the beginning of the pulse
EPulseTimingMode:add("End") -- Run at the end of a pulse
  
MagLib.Run.EPulseTimingMode = EPulseTimingMode