MagLib.BDO.Net = {}

function MagLib.BDO.Net.packetToFile(packet, filePath)
	Infinity.FileSystem.WriteBinaryFile(filePath, packet.byteBuffer)
end
