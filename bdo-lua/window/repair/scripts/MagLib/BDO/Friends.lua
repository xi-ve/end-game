MagLib.BDO.Friends = {}
local friendsList = {}

local lastState = nil
MagLib.BDO.Friends.isFriendOnline = function(name)
	local code = [[
  local count = RequestFriends_getFriendGroupCount()
  local indexCnt = 0
  local groupIndexCnt = 0
  for groupIndex = 0, count - 1 do
    local friendGroup = RequestFriends_getFriendGroupAt(groupIndex)
    local friendCount = friendGroup:getFriendCount()
    for friendIndex = 0, friendCount - 1 do
      local friendInfo = friendGroup:getFriendAt(friendIndex)
      local friendName = friendInfo:getName()
      if friendName == "]] .. name .. [[" then
    return friendInfo:isOnline()
  end
end
end

return false
]]

	local online = Infinity.BDO.Lua.Execute(code)
	if online ~= lastState then
		print(name .. " new online state: " .. tostring(online))
		lastState = online
	end
	return online
end
