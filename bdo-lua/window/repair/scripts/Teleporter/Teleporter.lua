Teleporter = { }
Teleporter.Running = false
Teleporter.Navigator = Navigator()

Teleporter.LastTick = 0

Teleporter.Delay = 150
Teleporter.AutoDelay = true

Teleporter.PacketStruct_Init = false

function Teleporter.Start()
  Teleporter.Running = true  
end

function Teleporter.Stop()
  Teleporter.Running = false  
end

function Teleporter.StopTeleportPath()
  MainWindow.teleport_begin = false         
end

function Teleporter.OnPulse()
  if Teleporter.Running == false then
    return
  end

  if MainWindow.CrossHair_AutoPort or Infinity.BDO.Input.IsKeyPressed(KeyCode_F7) then

    if MainWindow.CrossHair_AutoPort_PlayerDetection and Infinity.BDO.getLocalPlayer():getIsOtherPlayersNearby() then
      return
    end

    if MainWindow.CrossHair_AutoPort_LastTick + MainWindow.CrossHair_AutoPort_Delay > Infinity.Win32.GetTickCount() then
      return
    end

    MainWindow.CrossHair_AutoPort_LastTick = Infinity.Win32.GetTickCount()

    if MainWindow.CrossHair_AutoPort_AutoDelay then

      local dst = Infinity.BDO.getLocalPlayer():getCharacterControler():getPhysPos():getDistance(Infinity.BDO.getLocalPlayer():getCrossHairPosition())

      MainWindow.CrossHair_AutoPort_Delay = math.floor(dst * 0.3)
    end

    Infinity.BDO.getLocalPlayer():getCharacterControler():setPhysPos(Infinity.BDO.getLocalPlayer():getCrossHairPosition())
  end

  Teleporter.Navigator:OnPulse()

  if Teleporter.LastTick + Teleporter.Delay > Infinity.Win32.GetTickCount() then
  	return
  end

  Teleporter.LastTick = Infinity.Win32.GetTickCount()

  if MainWindow.teleport_begin then

    MainWindow.processNextNode()

  	MainWindow.teleportPathStep()
  end
end

function Teleporter.OnRenderD2D()
if Teleporter.Running == false then
    return
  end

	Teleporter.Navigator:OnRenderD2D()
end

function Teleporter.OnGuiDraw()
	MainWindow.DrawMainWindow()
	Teleporter.Navigator:OnGuiDraw()
end

function Teleporter.onStartActionNak(byteBuffer)
  if not MainWindow.teleport_begin then
    return
  end

  --MainWindow.nextPathStep()
  --print("next Step")
end

local isAutoGenActive = false

function Teleporter.tryInitPacketStruct(byteBuffer)
  isAutoGenActive = true
  print("Trying to Init Packet Struct")

  local currentTime = Infinity.Win32.GetTickCount()
  local minTime = currentTime - 5000
  local maxTime = currentTime + 5000

  local pLength = byteBuffer:_getShort(0)
  local opCode = byteBuffer:_getShort(3)

  local currentPos = Infinity.BDO.getLocalPlayer():getPosition()

  local offset_Time = 0
  local offsets_Pos = {}

  for iT = 5, pLength do
    local value = byteBuffer:_getLong(iT):getUnsafe()

    if value >= minTime and value <= maxTime then
      offset_Time = iT
      print("Offset_Time found at " .. iT)
      break
    end
  end

  for iP = 5, pLength do
    local value = byteBuffer:_getFloat(iP)

    if value == currentPos.X then
      print("Offset_Pos found at " .. iP)
      table.insert(offsets_Pos, iP)
    end
  end

  if offset_Time ~= 0 and table.length(offsets_Pos) == 10 then
    print("Packet Struct Offset Autogen Succeeded!")
    Teleporter.PacketStruct_Init = true

    MainWindow.offset_vectors = offsets_Pos
    MainWindow.offset_time = offset_Time
    MainWindow.opCode = opCode

    print("OpCode: " .. opCode)

    --MainWindow.initPacketData()
  else
    print("Packet Struct Offset Autogen Failed!")
  end

  isAutoGenActive = false
end

function Teleporter.OnPacketSend(byteBuffer, name) 
  local length = byteBuffer:getShort()
  byteBuffer:skip(1)
  local opCode = byteBuffer:getShort()

  if not Teleporter.PacketStruct_Init then

    if length >= 370 and length <= 450 and not isAutoGenActive then
      Teleporter.tryInitPacketStruct(byteBuffer)
    end
  end
end

function Teleporter.OnPacketReceive(byteBuffer)  
  byteBuffer:skip(3)
  local opCode = byteBuffer:getShort()
 
  local name = OpCodes.getAckName(opCode)

  if name == "StartActionNak" then
    Teleporter.onStartActionNak(byteBuffer)
  end
end