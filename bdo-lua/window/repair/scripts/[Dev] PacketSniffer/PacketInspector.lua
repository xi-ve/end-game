PacketInspector = { }
PacketInspector.__index = PacketInspector

setmetatable(PacketInspector, {
  __call = function (cls, ...)
    return cls.new(...)
  end,
})

function PacketInspector.new(snifferPacket)
  local self = setmetatable({}, PacketInspector)   
   
  self.snifferPacket = snifferPacket

  self.dataText = ""

  self:parsePacket()

  return self
end

function PacketInspector:parsePacket()

  local column = 0

  for i = 0, self.snifferPacket.data.size - 1 do
    
    local b = self.snifferPacket.data:get()

    self.dataText = self.dataText .. string.format("%02X", b) .. " "

    column = column + 1

    if column == 16 then

      self.dataText = self.dataText .. "\n"
      column = 0
    end
  end

  self.snifferPacket:resetBufferPositions()
end

function PacketInspector:getModifiedBuffer()
  self.snifferPacket:resetBufferPositions()

  for substring in self.dataText:gmatch("%S+") do
    
    if substring ~= "\n" then
      --print(c .. " - " .. tonumber(c, 16))
      self.snifferPacket.data:put(tonumber(substring, 16))
    end
  end
end

function PacketInspector:send()
  -- self:getModifiedBuffer()
  self.snifferPacket:send()
end

function PacketInspector:receive()
  -- self:getModifiedBuffer()
  self.snifferPacket:receive()
end

function PacketInspector:draw(index)
    ImGui.Begin(self.snifferPacket.Name .. "##" .. index)

    ImGui.SetWindowSize(ImVec2(500,500), ImGuiCond_FirstUseEver)
              
    if ImGui.Button("Close##close") then

      table.remove(MainWindow.PacketInspectors, index)
    end     
    
    ImGui.SameLine()

    if not self.snifferPacket.isIncoming then
      if ImGui.Button("Send##send") then
        self:send()
      end
    else

      if ImGui.Button("Receive##receive") then
        self:receive()
      end
    end
    
    if MainWindow.showNewHexEditor then
      ImGuiMemoryEditor.Draw(self.snifferPacket.data)
    else
      _, self.dataText = ImGui.InputTextMultiline("##hexout", self.dataText, 65536, ImVec2(350, 300), 0)
    end

    ImGui.Text("OpCode: " .. self.snifferPacket.opCode)
    ImGui.Text("Length: " .. self.snifferPacket.length .. " bytes")

    if ImGui.Button("Dump to File##dump") then
      
      self.snifferPacket:dumpToFile("\\PacketDumps\\")
    end 

    ImGui.End()
end