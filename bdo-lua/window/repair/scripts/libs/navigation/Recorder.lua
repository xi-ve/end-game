Recorder = {}
Recorder.__index = Recorder

setmetatable(Recorder, {
  __call = function (cls, ...)
    return cls.new(...)
  end,
})

function Recorder.new()
  local self = setmetatable({}, Recorder)   
 
  self.IsRunning = false

  self.Paused = false

  self.CheckpointDistance = 500
  self.CheckpointHeightOffset = 0

  self.Checkpoints = {}

  self.LastCheckpoint = nil

  return self
end

function Recorder:OnPulse()
	if not self.IsRunning or self.Paused then
		return
	end

	if self.LastCheckpoint == nil then
		return
	end

	local currentPos = Infinity.BDO.getLocalPlayer():getPosition()
	currentPos = Vector3(currentPos.X, currentPos.Y + self.CheckpointHeightOffset, currentPos.Z)

	if currentPos:getDistance(self.LastCheckpoint) >= self.CheckpointDistance then

		self.LastCheckpoint = currentPos
		table.insert(self.Checkpoints, NavigatorUtils.Vec3ToTable(self.LastCheckpoint))
	end
end

function Recorder:Start()
	self.IsRunning = true

	self.LastCheckpoint = Infinity.BDO.getLocalPlayer():getPosition()

	table.insert(self.Checkpoints, NavigatorUtils.Vec3ToTable(self.LastCheckpoint))
end

function Recorder:Stop()
	self.IsRunning = false
end

function Recorder:Reset()
	self.IsRunning = false
	self.CheckpointDistance = 500
	self.Checkpoints = {}
	self.LastCheckpoint = nil
end