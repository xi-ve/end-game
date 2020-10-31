Knowledge = {}

function Knowledge.getMainThemes()
	local code = 
	[[
		local mainThemes = {}

		local knowledge = getSelfPlayer():get():getMentalKnowledge()
  		local childCount = knowledge:getMainKnowledgeCount()

  		for index = 0, childCount - 1 do

  			local mentalCardKeyRaw = knowledge:getMainKnowledgeKeyByIndex(index)
      		local mentalObject = knowledge:getThemeByKeyRaw(mentalCardKeyRaw)

      		mainThemes[index + 1] = mentalObject:getName()
  		end

		return unpack(mainThemes)
	]]

	return {Infinity.BDO.Lua.Execute(code)}
end

function Knowledge.getMainThemesCount()
	local code = 
	[[		
		local knowledge = getSelfPlayer():get():getMentalKnowledge()
  		return knowledge:getMainKnowledgeCount()
	]]

	return Infinity.BDO.Lua.Execute(code)
end

function Knowledge.getMainThemeKeyByIndex(index)
	local code = 
	[[		
		local knowledge = getSelfPlayer():get():getMentalKnowledge()
  		return knowledge:getMainKnowledgeKeyByIndex(]] .. index .. [[)
	]]

	return Infinity.BDO.Lua.Execute(code)
end

function Knowledge.getMainThemeNameByIndex(index)
	local code = 
	[[		
		local knowledge = getSelfPlayer():get():getMentalKnowledge()
  		local mentalCardKeyRaw = knowledge:getMainKnowledgeKeyByIndex(]] .. index .. [[)

  		return knowledge:getThemeByKeyRaw(mentalCardKeyRaw):getName()
	]]

	return Infinity.BDO.Lua.Execute(code)
end

function Knowledge.hasCard(cardId, mainTheme)
	local code =
	[[
		local knowledge = getSelfPlayer():get():getMentalKnowledge()

		if knowledge == nil then
			return nil
		end

		local mentalObject = knowledge:getThemeByKeyRaw(]] .. mainTheme .. [[)

		for i=0, mentalObject:getChildCardCount() do
			local card = mentalObject:getChildCardByIndex(i)

			if card:getKey() == ]] .. cardId .. [[ then
				return card:hasCard()
			end
		end	

		return nil
	]]

	return Infinity.BDO.Lua.Execute(code)
end

function Knowledge.getCardName(cardId, mainTheme)
	local code =
	[[
		local knowledge = getSelfPlayer():get():getMentalKnowledge()

		if knowledge == nil then
			return "nA."
		end

		local mentalObject = knowledge:getThemeByKeyRaw(]] .. mainTheme .. [[)

		for i=0, mentalObject:getChildCardCount() do
			local card = mentalObject:getChildCardByIndex(i)

			if card:getKey() == ]] .. cardId .. [[ then
				local name = card:getName() --card:getKeyword()

				if string.find(name, "?") ~= nil then
					name = card:getKeyword()
				end

				return name
			end
		end	

		return "nA."
	]]

	return Infinity.BDO.Lua.Execute(code)
end