---
-- @module MagLib.BDO.Group
local Group = {}
---Returns all group members name
-- @return table: A table containing the names of all group members as string
Group.getAllGroupMemberNames = function()
	local names = {}
	local partyMemberCount = Infinity.BDO.Lua.Execute("return RequestParty_getPartyMemberCount()")
	for pIndex = 0, partyMemberCount - 1 do
		local code = [[
    local index = ]] .. pIndex .. [[
    local memberData = RequestParty_getPartyMemberAt(index)
    if nil == memberData then
      return nil
    end

    if RequestParty_isSelfPlayer(index) then
      return nil
    end

    return memberData:name()
    ]]
		local pName = Infinity.BDO.Lua.Execute(code)
		if pName ~= nil then
			table.insert(names, pName)
		end
	end
	return names
end

MagLib.BDO.Group = Group
