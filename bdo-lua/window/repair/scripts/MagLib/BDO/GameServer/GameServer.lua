local Server = {}
local settings = {switch_channel_settings = {}}
MagLib.Core.Settings.addSettingsToHandler("MagLib_GameServer", settings)
Server.channel = {}

function Server.cleanSettings()

	for channelName, allowed in pairs(settings.switch_channel_settings) do
		local _ = nil

		-- Checking that the channel exists in current channel list
		local isValid = false
		for _, channelData in ipairs(Server.channel) do
			if channelData.name == channelName then
				isValid = true
			end
		end

		if (not isValid) then
			print(channelName .. " is not a valid channel! Removing it from your config!")
			settings.switch_channel_settings[channelName] = nil
			_ = nil
		end
	end
end

function Server.getCurrentChannelName()

	local code = [[
      local curChannelData = getCurrentChannelServerData()

      if nil == curChannelData then
          return nil
      end

      local channelName = getChannelName(curChannelData._worldNo, curChannelData._serverNo)
      return channelName
      ]]

	return Infinity.BDO.Lua.Execute(code)
end

function Server.getCurrentChannelIndex()
	local currentChannelName = Server.getCurrentChannelName()
	local channelCount = Server.getChannelCount()

	for chIndex = 0, channelCount - 1 do
		if currentChannelName == Server.getName(chIndex) then
			return chIndex
		end
	end

	return nil
end

function Server.getChannelCount()
	local code = [[
    local curChannelData = getCurrentChannelServerData()
    if nil == curChannelData then
        return nil
    end

    local curWorldData = getGameWorldServerDataByWorldNo(curChannelData._worldNo)
    local channelCount = getGameChannelServerDataCount(curWorldData._worldNo)
    return channelCount
    ]]

	return Infinity.BDO.Lua.Execute(code)
end

function Server.getChannelCooldown()
	local code = [[

    local curChannelData = getCurrentChannelServerData()
    if nil == curChannelData then
        return nil
    end

    local changeChannelTime = getChannelMoveableRemainTime(curChannelData._worldNo)

    return Int64toInt32(changeChannelTime)
  ]]
	local difToChangeTime = Infinity.BDO.Lua.Execute(code)
	if difToChangeTime < 0 then
		difToChangeTime = 0
	end
	return difToChangeTime
end

function Server.getSeasonChannelCooldown()
	local code = [[

    local curChannelData = getCurrentChannelServerData()
    if nil == curChannelData then
        return nil
    end

    local changeChannelTime = getSpecialChannelMoveableRemainTime(curChannelData._worldNo)

    return Int64toInt32(changeChannelTime)
  ]]
	local difToChangeTime = Infinity.BDO.Lua.Execute(code)
	if difToChangeTime < 0 then
		difToChangeTime = 0
	end
	return difToChangeTime
end

function Server.isSeasonChannel(chIndex)
	local code = [[
    local curChannelData = getCurrentChannelServerData()
    if nil == curChannelData then
        return nil
    end

    local curWorldData = getGameWorldServerDataByWorldNo(curChannelData._worldNo)
    local channelCount = getGameChannelServerDataCount(curWorldData._worldNo)

    local _serverData = getGameChannelServerDataByWorldNo(curChannelData._worldNo, ]] .. chIndex .. [[)
  
    return _serverData._isSeasonChannel
  ]]
	return Infinity.BDO.Lua.Execute(code)
end

function Server.isSpeedChannel(chIndex)
	local code = [[
    local curChannelData = getCurrentChannelServerData()
    if nil == curChannelData then
        return nil
    end

    local curWorldData = getGameWorldServerDataByWorldNo(curChannelData._worldNo)
    local channelCount = getGameChannelServerDataCount(curWorldData._worldNo)

    local _serverData = getGameChannelServerDataByWorldNo(curChannelData._worldNo, ]] .. chIndex .. [[)
  if _serverData._isSpeedChannel then
    return true
  elseif false == _serverData._isInstanceChannel then
    return false
  end
  ]]
	return Infinity.BDO.Lua.Execute(code)
end

function Server.isWar(chIndex)
	local code = [[

    local curChannelData = getCurrentChannelServerData()
    if nil == curChannelData then
        return nil
    end

    local curWorldData = getGameWorldServerDataByWorldNo(curChannelData._worldNo)
    local tempChannel = getGameChannelServerDataByWorldNo(curChannelData._worldNo,]] .. chIndex .. [[)
  local isBeingWar = tempChannel._isSiegeBeing
  local isVillage = tempChannel._isVillageSiege

  return (isBeingWar or isVillage)
  ]]
	return Infinity.BDO.Lua.Execute(code)
end

function Server.canAccess(chIndex)
	local code = [[
    local curChannelData = getCurrentChannelServerData()
    if nil == curChannelData then
        return nil
    end

    local curWorldData = getGameWorldServerDataByWorldNo(curChannelData._worldNo)
    local _serverData = getGameChannelServerDataByWorldNo(curChannelData._worldNo, ]] .. chIndex .. [[)
  local temporaryWrapper = getTemporaryInformationWrapper()

  if _serverData._isBalanceChannel and not ToClient_isAccessableBalanceChannel() then
    return false
  end
  if _serverData._isPremiumChannel and not temporaryWrapper:isPremiumChannelPermission() then
    return false
  end
  if _serverData._isSpeedChannel and not (temporaryWrapper:getMyAdmissionToSpeedServer() ~= 0) then
    return false
  end
  if _serverData._isSteamChannel and not isSteamClient() then
    return false
  end

  return true
  ]]
	return Infinity.BDO.Lua.Execute(code)
end

function Server.getName(chIndex)
	local code = [[
    local curChannelData = getCurrentChannelServerData()
    if nil == curChannelData then
        return nil
    end
    local curWorldData = getGameWorldServerDataByWorldNo(curChannelData._worldNo)
    local tempChannel = getGameChannelServerDataByWorldNo(curChannelData._worldNo, ]] .. chIndex .. [[)
  local channelName = getChannelName(tempChannel._worldNo, tempChannel._serverNo)

  return channelName
  ]]

	return Infinity.BDO.Lua.Execute(code)
end

function Server.updateChannels()
	Server.channel = {}
	local channelCount = Server.getChannelCount()

	for chIndex = 0, channelCount - 1 do
		local isSpeedServer = Server.isSpeedChannel(chIndex)
		local isWar = Server.isWar(chIndex)
		local isAccessable = Server.canAccess(chIndex)
		local name = Server.getName(chIndex)

		table.insert(Server.channel, {
			chIndex = chIndex,
			isSpeedServer = isSpeedServer,
			isWar = isWar,
			isAccessable = isAccessable,
			name = name
		})
	end

	Server.cleanSettings()
end

function Server.getChIndexByName(chName)
	local channelCount = Server.getChannelCount()
	for chIndex = 0, channelCount - 1 do
		local name = Server.getName(chIndex)
		if name == chName then
			return chIndex
		end
	end
	return nil
end

function Server.changeToChannel(chIndex)
	MagLib.logger.info("Switching to channel " .. Server.getName(chIndex))
	-- Checking if we can even change first
	if Server.isSeasonChannel(chIndex) then
		if Server.getSeasonChannelCooldown() > 0.0 then
			return false
		end
	else
		if Server.getChannelCooldown() > 0.0 then
			return false
		end
	end

	-- Changing
	local code = [[
    local curChannelData = getCurrentChannelServerData()
    local curWorldData = getGameWorldServerDataByWorldNo(curChannelData._worldNo)
    local channelCount = getGameChannelServerDataCount(curWorldData._worldNo)

    local tempChannel = getGameChannelServerDataByWorldNo(curChannelData._worldNo, ]] .. chIndex .. [[)
  local isSiegeBeing = deadMessage_isSiegeBeingMyChannel()
  local isInSiegeBattle = deadMessage_isInSiegeBattle()

  if nil ~= tempChannel then
    local busyState = tempChannel._busyState
    local isSpecialCharacter = getTemporaryInformationWrapper():isSpecialCharacter()
    if busyState == 0 then
      return false
    elseif true == getSelfPlayer():get():isBattleGroundDefine() and true == tempChannel._isSiegeChannel or true == tempChannel._isSiegeChannel and isSpecialCharacter then
      return false
    end
  end

  --We are gonna change serverSave Data before leaving so changes to quickslot etc. won't be gone.
  getSelfPlayer():updateNavigationInformation(getSelfPlayer():get():getUserMemo())
  getSelfPlayer():saveCurrentDataForGameExit()
  ToClient_SaveUiInfo(false)

  gameExit_MoveChannel(]] .. chIndex .. [[)
  return true
  ]]

	--------------------
	return Infinity.BDO.Lua.Execute(code)
end

MagLib.BDO.GameServer = Server
