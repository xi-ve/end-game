UserMods = { }
UserMods.Running = false
UserMods.Settings = Settings()

UserMods.lastTick = 0

lPlayer = nil

function UserMods.Start()
 	UserMods.Running = true
	    
	UserMods.LoadSettings()	    
end

function UserMods.Stop()
  UserMods.Running = false  

  UserMods.SaveSettings()
end

function UserMods.modOther()

  --local addCritRate = UserMods.Settings.Others[1]
  local jumpHeight = UserMods.Settings.Others[1]

--[[   if addCritRate.Enabled then

    if lPlayer:getAdditionalCritrate() ~= math.floor(addCritRate.Value * 10000) then

      lPlayer:setAdditionalCritrate(math.floor(addCritRate.Value * 10000))
    end
  end ]]

  if jumpHeight.Enabled then

    if lPlayer:getCharacterControler():getJumpHeight() ~= jumpHeight.Value then

      lPlayer:getCharacterControler():setJumpHeight(jumpHeight.Value)
    end
  end
end

function UserMods.modProductions()

  for k,v in pairs(UserMods.Settings.Productions) do

    if v.Enabled then

      if lPlayer:getDecreaseTime(v.Type) ~= math.floor(v.Value * 50000) then

        lPlayer:setDecreaseTime(v.Type, math.floor(v.Value * 50000))
      end
    end
  end
end

function UserMods.modResistances()
  
  for k,v in pairs(UserMods.Settings.Resistances) do

    if v.Enabled then

      if lPlayer:getResistance(v.Type) ~= v.Value * 10000 then

        lPlayer:setResistance(v.Type, v.Value * 10000)
      end
    end
  end
end

function UserMods.modAbilities()

  for k,v in pairs(UserMods.Settings.Abilities) do

    if v.Enabled and v.Name == "Gathering" then

      if lPlayer:getAbilityStat(v.Type) ~= v.Value then

        lPlayer:setAbilityStat(v.Type, v.Value)
      end
    end
  end
end

function UserMods.OnPulse()
  if UserMods.Running == false then
    return
  end

  if UserMods.lastTick + 100 > Infinity.Win32.GetTickCount() then
    return
  end

  UserMods.lastTick = Infinity.Win32.GetTickCount()

  lPlayer = Infinity.BDO.getLocalPlayer()

  UserMods.modAbilities()
  --UserMods.modResistances()
  UserMods.modProductions()
  UserMods.modOther()
end

function UserMods.OnGuiDraw()
	MainWindow.DrawMainWindow()
end

function UserMods.onBreathGaugeStateChange(packet)
  packet:parse()  

  if not UserMods.Settings.Diving.UnlimitedBreath then
    return
  end

  if packet.Parsed.Type == 2 then

    BreathGaugeStateChangeAck():construct(Infinity.BDO.getLocalPlayer():getActorKey(),0,0).Packet:receive()
  end
end

function UserMods.OnPacketReceive(byteBuffer) 
  local packetLength = byteBuffer:getShort()
  local isEncrypted = byteBuffer:get()
  local opCode = byteBuffer:getShort()
  
  local name = OpCodes.getAckName(opCode)

  if name == "BreathGaugeStateChange" then
    UserMods.onBreathGaugeStateChange(BreathGaugeStateChangeAck(byteBuffer))  
  end
end

function UserMods.SaveSettings()
    local json = JSON:new()
    Infinity.FileSystem.WriteFile("Settings.json", json:encode_pretty(UserMods.Settings))
end

function UserMods.LoadSettings()
    local json = JSON:new()
    UserMods.Settings = Settings()
    
    table.merge(UserMods.Settings, json:decode(Infinity.FileSystem.ReadFile("Settings.json")))    
end