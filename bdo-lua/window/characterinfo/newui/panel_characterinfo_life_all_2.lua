function PaGlobalFunc_CharInfoLife_All_Update()
  if false == PaGlobalFunc_ChracterInfo_All_GetBgShow(PaGlobal_CharInfo_All._TABINDEX._life) then
    return
  end
  PaGlobal_CharInfoLife_All:update()
end
function HandleEventOnOut_CharInfoLife_All_LifeType_Tooltip(isShow, lifeType, subType)
  if true == _ContentsGroup_RenewUI_Tooltip then
    return
  end
  if false == PaGlobalFunc_ChracterInfo_All_GetBgShow(PaGlobal_CharInfo_All._TABINDEX._life) or false == isShow or nil == lifeType then
    TooltipSimple_Hide()
    return
  end
  local eLIFE = CppEnums.LifeExperienceType
  local name, desc, control
  if true == isShow then
    if lifeType == eLIFE.gather then
      if nil ~= subType then
        if nil ~= PaGlobal_CharInfoLife_All._ui.stc_life[lifeType]._subLifeType then
          local characterCollectRate = ToClient_getSelfPlayerCollectRate()
          local count = ToClient_LoadCollectingStatData(subType)
          local tempString = {}
          for ii = 0, count - 2 do
            local dropRate = ToClient_getCollectingStatAddDropRate(ii)
            local dropCountRate = ToClient_getCollectingStatAddDropCountRate(ii)
            if 800000 <= characterCollectRate then
              dropRate = 0
            end
            dropRate = dropRate / 1000
            dropRate = math.floor(dropRate) / 10
            dropCountRate = dropCountRate / 1000
            dropCountRate = math.floor(dropCountRate) / 10
            local stringFormatKey = string.format("LUA_COLLECTING_POWER_DESC_%d", ii + 1)
            tempString[ii] = PAGetStringParam2(Defines.StringSheet_GAME, stringFormatKey, "rate1", tostring(dropRate), "rate2", tostring(dropCountRate))
          end
          characterCollectRate = characterCollectRate / 1000
          characterCollectRate = math.floor(characterCollectRate) / 10
          local subStringName = string.format("LUA_COLLECTING_POWER_DESC_SUB_%d", subType)
          desc = string.format([[
%s
%s%s%s
%s

%s]], PAGetString(Defines.StringSheet_GAME, "LUA_COLLECTING_POWER_DESC_MAIN"), tempString[0], tempString[1], tempString[2], PAGetStringParam1(Defines.StringSheet_GAME, "LUA_COLLECTING_POWER_DESC_4", "charRate", tostring(characterCollectRate)), PAGetString(Defines.StringSheet_GAME, tostring(subStringName)))
          local subTypeUI = PaGlobal_CharInfoLife_All._ui.stc_life[lifeType]._subLifeType[subType]
          name = subTypeUI._subtitle:GetText()
          control = subTypeUI._subtitle
        end
      else
        name = PaGlobal_CharInfoLife_All._ui.stc_life[lifeType]._title:GetText()
        desc = PAGetString(Defines.StringSheet_GAME, "LUA_CHARACTERINFO_CRAFT_DESC_1") .. PAGetString(Defines.StringSheet_GAME, "LUA_CHARACTERINFO_CRAFT_SUBDESC")
        control = PaGlobal_CharInfoLife_All._ui.stc_life[lifeType]._parent
      end
    elseif lifeType == eLIFE.fishing then
      local fishingStatStaticStatus = ToClient_getFishingStatStaticStatus()
      local addRate = 0
      if nil ~= fishingStatStaticStatus then
        addRate = string.format("%.1f", fishingStatStaticStatus._rate / 10000)
      end
      desc = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_CHARACTERINFO_LIFE_FISHINGSTAT_DESC", "rate", tostring(addRate))
      name = PaGlobal_CharInfoLife_All._ui.stc_life[lifeType]._title:GetText()
      control = PaGlobal_CharInfoLife_All._ui.stc_life[lifeType]._parent
    elseif lifeType == eLIFE.hunting then
      local dropRate = ToClient_getHuntingRate()
      if 0 < dropRate then
        dropRate = dropRate / 1000
        dropRate = math.floor(dropRate) / 10
      end
      desc = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_CHARACTERINFO_LIFE_HUNTING_DESC", "rate", dropRate)
      name = PaGlobal_CharInfoLife_All._ui.stc_life[lifeType]._title:GetText()
      control = PaGlobal_CharInfoLife_All._ui.stc_life[lifeType]._parent
    elseif lifeType == eLIFE.cooking then
      local cookingStatStaticStatus = ToClient_getCookingStatStaticStatus()
      local speedCookRate = 0
      local basicMaxDropRate = 0
      local addCriticalDropRate = 0
      local addCriticalMaxDropRate = 0
      local addRoyalTradeBonus = 0
      if nil ~= cookingStatStaticStatus then
        speedCookRate = string.format("%.1f", cookingStatStaticStatus._speedCookRate / 10000)
        basicMaxDropRate = string.format("%.1f", cookingStatStaticStatus._basicMaxDropRate / 10000)
        addCriticalDropRate = string.format("%.1f", cookingStatStaticStatus._addCriticalDropRate / 10000)
        addCriticalMaxDropRate = string.format("%.1f", cookingStatStaticStatus._addCriticalMaxDropRate / 10000)
        addRoyalTradeBonus = string.format("%.1f", cookingStatStaticStatus._addRoyalTradeBonus / 10000)
      end
      desc = string.format("%s%s", PAGetStringParam4(Defines.StringSheet_GAME, "LUA_CHARACTERINFO_LIFE_COOK_DESC_1", "rate1", tostring(speedCookRate), "rate2", tostring(basicMaxDropRate), "rate3", tostring(addCriticalDropRate), "rate4", tostring(addCriticalMaxDropRate)), PAGetStringParam1(Defines.StringSheet_GAME, "LUA_CHARACTERINFO_LIFE_COOK_DESC_2", "rate1", tostring(addRoyalTradeBonus)))
      name = PaGlobal_CharInfoLife_All._ui.stc_life[lifeType]._title:GetText()
      control = PaGlobal_CharInfoLife_All._ui.stc_life[lifeType]._parent
    elseif lifeType == eLIFE.alchemy then
      local alchemySSW = ToClient_getAlchemyStatStaticStatus()
      if nil == alchemySSW then
        local tempdesc1 = PAGetStringParam4(Defines.StringSheet_GAME, "LUA_CHARACTERINFO_LIFE_ALCHEMY_DESC_1", "rate1", 0, "rate2", 0, "rate3", 0, "rate4", 0)
        local tempdesc2 = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_CHARACTERINFO_LIFE_ALCHEMY_DESC_2", "rate1", 0)
        desc = string.format([[
%s
%s]], tempdesc1, tempdesc2)
      else
        local rate1 = string.format("%.1f", alchemySSW._basicMaxDropRate / 10000)
        local eventDropRate = alchemySSW._eventDropRate / 1000000
        local dropRate1 = alchemySSW:getEventDropRateForTooltip(0) / 1000000
        local dropRate2 = alchemySSW:getEventDropRateForTooltip(1) / 1000000
        local dropRate3 = alchemySSW:getEventDropRateForTooltip(2) / 1000000
        local basicRate = eventDropRate * (1 - dropRate3) * (1 - dropRate2)
        local specialRate = eventDropRate * (1 - dropRate3) * dropRate2
        local uniqueRate = eventDropRate * dropRate3
        local tempdesc1 = PAGetStringParam4(Defines.StringSheet_GAME, "LUA_CHARACTERINFO_LIFE_ALCHEMY_DESC_1", "rate1", rate1, "rate2", string.format("%.2f", basicRate * 100), "rate3", string.format("%.2f", specialRate * 100), "rate4", string.format("%.2f", uniqueRate * 100))
        local royalBonus = string.format("%.1f", alchemySSW._addRoyalTradeBonus / 10000)
        local tempdesc2 = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_CHARACTERINFO_LIFE_ALCHEMY_DESC_2", "rate1", royalBonus)
        desc = string.format([[
%s
%s]], tempdesc1, tempdesc2)
      end
      name = PaGlobal_CharInfoLife_All._ui.stc_life[lifeType]._title:GetText()
      control = PaGlobal_CharInfoLife_All._ui.stc_life[lifeType]._parent
    elseif lifeType == eLIFE.manufacture then
      if nil ~= subType then
        if nil ~= PaGlobal_CharInfoLife_All._ui.stc_life[lifeType]._subLifeType then
          local countRate = ToClient_getManufacturingStatCountRate(subType)
          desc = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_MANUFACTURING_POWER_TOOLTIP_DESC", "data2", tostring(countRate))
          local subTypeUI = PaGlobal_CharInfoLife_All._ui.stc_life[lifeType]._subLifeType[subType]
          name = subTypeUI._subtitle:GetText()
          control = subTypeUI._subtitle
        end
      else
        name = PaGlobal_CharInfoLife_All._ui.stc_life[lifeType]._title:GetText()
        desc = PAGetString(Defines.StringSheet_GAME, "LUA_CHARACTERINFO_CRAFT_DESC_2") .. PAGetString(Defines.StringSheet_GAME, "LUA_CHARACTERINFO_CRAFT_SUBDESC")
        control = PaGlobal_CharInfoLife_All._ui.stc_life[lifeType]._parent
      end
    elseif lifeType == eLIFE.training then
      local trainingStatStaticStatus = ToClient_getTrainingStatStaticStatus()
      local captureRate = 0
      local expRate = 0
      local matingRate = 0
      if nil ~= trainingStatStaticStatus then
        captureRate = string.format("%.1f", trainingStatStaticStatus._addHorseCaptureRate / 10000)
        expRate = string.format("%.1f", trainingStatStaticStatus._addVehicleExperienceRate / 10000)
        matingRate = string.format("%.1f", trainingStatStaticStatus._addMatingRate / 10000)
      end
      desc = PAGetStringParam3(Defines.StringSheet_GAME, "LUA_CHARACTERINFO_LIFE_TRAINING_DESC_1", "rate1", tostring(captureRate), "rate2", tostring(expRate), "rate3", tostring(matingRate))
      name = PaGlobal_CharInfoLife_All._ui.stc_life[lifeType]._title:GetText()
      control = PaGlobal_CharInfoLife_All._ui.stc_life[lifeType]._parent
    elseif lifeType == eLIFE.trade then
      name = PaGlobal_CharInfoLife_All._ui.stc_life[lifeType]._title:GetText()
      desc = PAGetString(Defines.StringSheet_GAME, "LUA_CHARACTERINFO_CRAFT_DESC_4")
      control = PaGlobal_CharInfoLife_All._ui.stc_life[lifeType]._parent
    elseif lifeType == eLIFE.growth then
      name = PaGlobal_CharInfoLife_All._ui.stc_life[lifeType]._title:GetText()
      desc = PAGetString(Defines.StringSheet_GAME, "LUA_CHARACTERINFO_CRAFT_DESC_7")
      control = PaGlobal_CharInfoLife_All._ui.stc_life[lifeType]._parent
    elseif lifeType == eLIFE.sail then
      local sailStatStaticStatus = ToClient_getSailStatStaticStatus()
      local acc = 0
      local spd = 0
      local cor = 0
      local brk = 0
      if nil ~= sailStatStaticStatus then
        acc = string.format("%.1f", sailStatStaticStatus:getVariedStatByIndex(0) / 10000)
        spd = string.format("%.1f", sailStatStaticStatus:getVariedStatByIndex(1) / 10000)
        cor = string.format("%.1f", sailStatStaticStatus:getVariedStatByIndex(2) / 10000)
        brk = string.format("%.1f", sailStatStaticStatus:getVariedStatByIndex(3) / 10000)
      end
      local desc1 = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_CHARACTERINFO_LIFE_SAILSTAT_DESC_1", "rate2", tostring(acc))
      local desc2 = PAGetStringParam3(Defines.StringSheet_GAME, "LUA_CHARACTERINFO_LIFE_SAILSTAT_DESC_2", "rate1", tostring(spd), "rate2", tostring(cor), "rate3", tostring(brk))
      desc = string.format([[
%s
%s]], desc1, desc2)
      name = PaGlobal_CharInfoLife_All._ui.stc_life[lifeType]._title:GetText()
      control = PaGlobal_CharInfoLife_All._ui.stc_life[lifeType]._parent
    elseif lifeType == eLIFE.barter then
      if false == _ContentsGroup_Barter then
        return
      end
      local value = ToClient_discountPointByBarterLevel() / 10000
      local ceil = math.ceil(value * 1000 - 0.5) / 1000
      if ceil <= 0 then
        ceil = math.abs(ceil)
      end
      name = PaGlobal_CharInfoLife_All._ui.stc_life[lifeType]._title:GetText()
      desc = PAGetStringParam1(Defines.StringSheet_GAME, CppEnums.LifeExperienceTooltip[lifeType], "value", string.format("%.2f", ceil))
      control = PaGlobal_CharInfoLife_All._ui.stc_life[lifeType]._parent
    end
    if nil == control then
      UI.ASSERT_NAME(nil ~= control, " Panel_CharacterInfo_Life_ALL_2.lua / HandleEventOnOut_CharInfoLife_All_LifeType_Tooltip() /  control is nil", "\234\185\128\234\183\188\236\154\176")
      return
    end
    TooltipSimple_Show(control, name, desc)
  end
end
