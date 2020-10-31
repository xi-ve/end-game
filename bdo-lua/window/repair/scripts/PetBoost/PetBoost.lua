PetBoost = { }
PetBoost.Running = false

function PetBoost.Start()
  PetBoost.Running = true
end

function PetBoost.Stop()
  PetBoost.Running = false  
end

function PetBoost.OnPulse()
	if not PetBoost.Running then
		return
	end
end

function PetBoost.onPetUseSkill(packet)
	packet:parse()	

	--print("Pet: " .. packet.Parsed.PetNo .. " Used Skill - " .. Infinity.Win32.GetTickCount())

	SealPetReq():construct(packet.Parsed.PetNo).Packet:send()
	UnsealPetReq():construct(packet.Parsed.PetNo).Packet:send()
	ChangePetSpeedReq():construct(packet.Parsed.PetNo, 2).Packet:send()
end

function PetBoost.OnPacketReceive(byteBuffer)		
	local packetLength = byteBuffer:getShort()
	local isEncrypted = byteBuffer:get()
	local opCode = byteBuffer:getShort()
	
	local name = OpCodes.getAckName(opCode)
	
	if name == "PetUseSkill" then
		PetBoost.onPetUseSkill(PetUseSkillAck(byteBuffer))	
	end
end

function PetBoost.OnGuiDraw()
end

function PetBoost.OnRenderD2D()
end