function PaGlobal_CharInfoCashBuff_All:initialize()
  self._ui.list2_buff = UI.getChildControl(Panel_CharacterInfoCashBuff_All, "List2_CashBuff")
  self._ui.txt_NoBuff = UI.getChildControl(Panel_CharacterInfoCashBuff_All, "StaticText_NoBuff")
  self._ui.stc_PopupTooltip = UI.getChildControl(Panel_CharacterInfoCashBuff_All, "Static_Popup")
  self._ui.stc_PopupTooltipBG_Title = UI.getChildControl(self._ui.stc_PopupTooltip, "StaticText_PopupTitle")
  self._ui.stc_PopupTooltipBg = UI.getChildControl(self._ui.stc_PopupTooltip, "Static_PopupBoxBG")
  self._ui.stc_PopupTooltipDesc = UI.getChildControl(self._ui.stc_PopupTooltipBg, "StaticText_DescBox")
  self._ui.stc_PopupTooltipTitle = UI.getChildControl(self._ui.stc_PopupTooltipBg, "StaticText_DescTitle")
  self._ui.stc_Console_KeyGuideBg = UI.getChildControl(Panel_CharacterInfoCashBuff_All, "Static_KeyGuide_ConsoleUI")
  self._ui.stc_KeyGuide_X = UI.getChildControl(self._ui.stc_Console_KeyGuideBg, "StaticText_XButton")
  self._ui.stc_KeyGuide_B = UI.getChildControl(self._ui.stc_Console_KeyGuideBg, "StaticText_BButton")
  self._ui.stc_KeyGuide_A = UI.getChildControl(self._ui.stc_Console_KeyGuideBg, "StaticText_AButton")
  self._oriDescSizeX = self._ui.stc_PopupTooltip:GetSizeX()
  self._oriDescSizeY = self._ui.stc_PopupTooltip:GetSizeY()
  local keyguide = {
    self._ui.stc_KeyGuide_A,
    self._ui.stc_KeyGuide_X,
    self._ui.stc_KeyGuide_B
  }
  PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyguide, self._ui.stc_Console_KeyGuideBg, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHT)
  self._ui.stc_PopupTooltipDesc:SetTextMode(__eTextMode_AutoWrap)
  self._ui.stc_PopupTooltipDesc:SetText(self._ui.stc_PopupTooltipDesc:GetText())
  PaGlobal_CharInfoCashBuff_All:validate()
  PaGlobal_CharInfoCashBuff_All:registerEvent()
end
function PaGlobal_CharInfoCashBuff_All:registerEvent()
  self._ui.list2_buff:registEvent(__ePAUIlist2EventType_LuaChangeContent, "PaGlobal_CharInfoCashBuff_All_list2Update")
  self._ui.list2_buff:createChildContent(__ePAUIlist2ElementManagerType_List)
  registerEvent("onScreenResize", "FromClient_CharInfoCashBuff_All_OnScreenResize")
  registerEvent("FromClient_UpdateCharge", "FromClient_PackageIconUpdate")
  registerEvent("FromClient_LoadCompleteMsg", "FromClient_PackageIconUpdate")
  registerEvent("FromClient_ResponseGoldenbellItemInfo", "PaGlobal_CharInfoCashBuff_All_Update")
  registerEvent("FromClient_ResponseChangeExpAndDropPercent", "PaGlobal_CharInfoCashBuff_All_Update")
  registerEvent("FromClint_EventChangedExplorationNode", "FromClient_CharInfoCashBuff_All_EventChangedExplorationNode")
  registerEvent("FromClint_EventUpdateExplorationNode", "FromClient_CharInfoCashBuff_All_EventUpdateExplorationNode")
  registerEvent("FromClient_FeverSkillToggle", "FromClient_CharInfoCashBuff_All_FeverSkillToggle")
end
function PaGlobal_CharInfoCashBuff_All:update()
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  local temporaryWrapper = getTemporaryInformationWrapper()
  if nil == temporaryWrapper then
    return
  end
  local isPremiumPcRoom = temporaryWrapper:isPremiumPcRoom()
  local flags = {}
  local player = selfPlayer:get()
  local starter = player:getUserChargeTime(CppEnums.UserChargeType.eUserChargeType_StarterPackage)
  local premium = player:getUserChargeTime(CppEnums.UserChargeType.eUserChargeType_PremiumPackage)
  local pearl = player:getUserChargeTime(CppEnums.UserChargeType.eUserChargeType_PearlPackage)
  local customize = player:getUserChargeTime(CppEnums.UserChargeType.eUserChargeType_CustomizationPackage)
  local dyeingPackage = player:getUserChargeTime(CppEnums.UserChargeType.eUserChargeType_DyeingPackage)
  local russiaKamasilv = player:getUserChargeTime(CppEnums.UserChargeType.eUserChargeType_Kamasilve)
  local russiaPack3Time = player:getUserChargeTime(CppEnums.UserChargeType.eUserChargeType_RussiaPack3)
  local applyStarter = player:isApplyChargeSkill(CppEnums.UserChargeType.eUserChargeType_StarterPackage)
  local applyPremium = player:isApplyChargeSkill(CppEnums.UserChargeType.eUserChargeType_PremiumPackage)
  local applyPearl = player:isApplyChargeSkill(CppEnums.UserChargeType.eUserChargeType_PearlPackage)
  local applyCustomize = player:isApplyChargeSkill(CppEnums.UserChargeType.eUserChargeType_CustomizationPackage)
  local applyDyeingPackage = player:isApplyChargeSkill(CppEnums.UserChargeType.eUserChargeType_DyeingPackage)
  local applyRussiaKamasilv = player:isApplyChargeSkill(CppEnums.UserChargeType.eUserChargeType_Kamasilve)
  local applySkillReset = player:isApplyChargeSkill(CppEnums.UserChargeType.eUserChargeType_UnlimitedSkillChange)
  local applyAwakenSkillReset = player:isApplyChargeSkill(CppEnums.UserChargeType.eUserChargeType_UnlimitedSkillAwakening)
  local applyRussiaPack3 = player:isApplyChargeSkill(CppEnums.UserChargeType.eUserChargeType_RussiaPack3)
  local blackSpiritTraining = player:isApplyChargeSkill(CppEnums.UserChargeType.eUserChargeType_BlackSpritTraining)
  local pcRoomUserHomeBuff = player:isApplyChargeSkill(CppEnums.UserChargeType.eUserChargeType_PcRoomUserHomeBuff)
  local premiumValueBuff = player:isApplyChargeSkill(CppEnums.UserChargeType.eUserChargeType_PremiumValuePackageBuff)
  local blackSpiritSkillTraining = player:isApplyChargeSkill(CppEnums.UserChargeType.eUserChargeType_BlackSpritSkillTraining)
  local memoryOfMaestro = player:isApplyChargeSkill(CppEnums.UserChargeType.eUserChargeType_GetItemDaily)
  local bookOfCombat = player:isApplyChargeSkill(CppEnums.UserChargeType.eUserChargeType_BookOfCombat)
  local applyArshaBuff = ToClient_isAbleArshaItemDropBuffRate()
  local goldenBellTime_s64 = player:getGoldenbellExpirationTime_s64()
  local curChannelData = getCurrentChannelServerData()
  local expEventShow = IsWorldServerEventTypeByWorldNo(curChannelData._worldNo, curChannelData._serverNo, 0)
  local dropEventShow = IsWorldServerEventTypeByWorldNo(curChannelData._worldNo, curChannelData._serverNo, 1)
  local nodeLv = ToClient_GetNodeLevel(self._saveWayPoint)
  local nodeExp = ToClient_GetNodeExperience_s64(self._saveWayPoint)
  flags[self._eBUFF_TYPE.GuildWar] = self._localNodeInvestment
  flags[self._eBUFF_TYPE.RussiaMonthly] = false
  if applyStarter then
    local isVaild = 0 < starter
    flags[self._eBUFF_TYPE.Kamasylvia] = isVaild
  else
    flags[self._eBUFF_TYPE.Kamasylvia] = false
  end
  if applyPremium then
    local isVaild = 0 < premium
    flags[self._eBUFF_TYPE.ValuePack] = isVaild
  else
    flags[self._eBUFF_TYPE.ValuePack] = false
  end
  if true == _contentsGroup_BookOfCombat then
    flags[self._eBUFF_TYPE.BookOfCombat] = bookOfCombat
  end
  flags[self._eBUFF_TYPE.Pearl] = applyPearl
  flags[self._eBUFF_TYPE.Exchange] = applyCustomize
  flags[self._eBUFF_TYPE.Merv] = applyDyeingPackage
  flags[self._eBUFF_TYPE.KamasylviaForRussia] = applyRussiaKamasilv
  flags[self._eBUFF_TYPE.SkillChange] = applySkillReset
  flags[self._eBUFF_TYPE.AwakenChange] = applyAwakenSkillReset
  flags[self._eBUFF_TYPE.PremiumPackForRussia] = applyRussiaPack3
  flags[self._eBUFF_TYPE.BlackSpiritEXP] = blackSpiritTraining
  flags[self._eBUFF_TYPE.BlackSpiritSkill] = blackSpiritSkillTraining
  flags[self._eBUFF_TYPE.MemoryofArtisan] = memoryOfMaestro
  flags[self._eBUFF_TYPE.GoldenBell] = goldenBellTime_s64 >= toInt64(0, 0)
  flags[self._eBUFF_TYPE.EXP] = expEventShow
  flags[self._eBUFF_TYPE.Drop] = dropEventShow
  if true == isPremiumPcRoom then
    if not isGameTypeRussia() and not isGameTypeEnglish() and not isGameTypeSA() and not isGameTypeKR2() and not isGameTypeTR() then
      flags[self._eBUFF_TYPE.PCRoom] = true
    else
      flags[self._eBUFF_TYPE.PCRoom] = false
    end
  else
    flags[self._eBUFF_TYPE.PCRoom] = false
  end
  flags[self._eBUFF_TYPE.GoldValuePack] = premiumValueBuff
  flags[self._eBUFF_TYPE.ArshaServerBuff] = applyArshaBuff
  flags[self._eBUFF_TYPE.FeverBuff] = _ContentsGroup_FeverBuff
  self._buffData = {}
  self:updateBuffData()
  self._listShowBuff = {}
  local uiIndex = 1
  for k, v in pairs(flags) do
    if true == v then
      self._listShowBuff[#self._listShowBuff + 1] = k
    end
  end
  self._ui.list2_buff:getElementManager():clearKey()
  local isBuffAvaliable = 1 <= #self._listShowBuff
  self._ui.txt_NoBuff:SetShow(not isBuffAvaliable)
  self._ui.stc_KeyGuide_X:SetShow(isBuffAvaliable)
  if true == isBuffAvaliable then
    for ii = 1, #self._listShowBuff do
      if 1 == ii % self._columnCount then
        self._ui.list2_buff:getElementManager():pushKey(toInt64(0, ii))
      end
    end
  end
end
function PaGlobal_CharInfoCashBuff_All:updateBuffData()
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  local player = selfPlayer:get()
  local curChannelData = getCurrentChannelServerData()
  local goldenBellTime_s64 = player:getGoldenbellExpirationTime_s64()
  local goldenBellTime = convertStringFromDatetime(goldenBellTime_s64)
  local goldenBellPercent = player:getGoldenbellPercent()
  local goldenBellPercentString = tostring(math.floor(goldenBellPercent / 10000))
  local goldenBellCharacterName = player:getGoldenbellItemOwnerCharacterName()
  local goldenBellGuildName = player:getGoldenbellItemOwnerGuildName()
  local starter = player:getUserChargeTime(CppEnums.UserChargeType.eUserChargeType_StarterPackage)
  local premium = player:getUserChargeTime(CppEnums.UserChargeType.eUserChargeType_PremiumPackage)
  local pearl = player:getUserChargeTime(CppEnums.UserChargeType.eUserChargeType_PearlPackage)
  local customize = player:getUserChargeTime(CppEnums.UserChargeType.eUserChargeType_CustomizationPackage)
  local dyeingPackage = player:getUserChargeTime(CppEnums.UserChargeType.eUserChargeType_DyeingPackage)
  local russiaKamasilv = player:getUserChargeTime(CppEnums.UserChargeType.eUserChargeType_Kamasilve)
  local skillResetTime = player:getUserChargeTime(CppEnums.UserChargeType.eUserChargeType_UnlimitedSkillChange)
  local awakenSkillResetTime = player:getUserChargeTime(CppEnums.UserChargeType.eUserChargeType_UnlimitedSkillAwakening)
  local russiaPack3Time = player:getUserChargeTime(CppEnums.UserChargeType.eUserChargeType_RussiaPack3)
  local trainingTime = player:getUserChargeTime(CppEnums.UserChargeType.eUserChargeType_BlackSpritTraining)
  local skilltrainingTime = player:getUserChargeTime(CppEnums.UserChargeType.eUserChargeType_BlackSpritSkillTraining)
  local pcRoomHomeTime = player:getUserChargeTime(CppEnums.UserChargeType.eUserChargeType_PcRoomUserHomeBuff)
  local premiumValueTime = player:getUserChargeTime(CppEnums.UserChargeType.eUserChargeType_PremiumValuePackageBuff)
  local memoryOfMaestroTime = player:getUserChargeTime(CppEnums.UserChargeType.eUserChargeType_GetItemDaily)
  local bookOfCombatTime = player:getUserChargeTime(CppEnums.UserChargeType.eUserChargeType_BookOfCombat)
  local expEventPercent = getEventExpPercentByWorldNo(curChannelData._worldNo, curChannelData._serverNo)
  local expEventPercentShow = 0
  if expEventPercent > self._defaultEventExp then
    expEventPercentShow = math.floor(expEventPercent / 10000 - 100)
  end
  local expVehiclePercent = lobby_getEventVehicleExpPercentByWorldNo(curChannelData._worldNo, curChannelData._serverNo)
  local expEventVehiclePercentShow = 0
  if expVehiclePercent > self._defaultEventExp then
    expEventVehiclePercentShow = math.floor(expVehiclePercent / 10000 - 100)
  end
  local expNodePercent = self._currentNodeLv * ToClient_getNodeIncreaseItemDropPercent() / 10000
  local name, desc, uv, leftTime
  for buffType = 1, self._buffTypeCount do
    if buffType == self._eBUFF_TYPE.PCRoom then
      leftTime = nil
      if isGameTypeEnglish() then
        name = PAGetString(Defines.StringSheet_GAME, "LUA_SELFPLAYEREXPGAGE_PCROOM_TITLE_NA")
        desc = PAGetString(Defines.StringSheet_GAME, "LUA_SELFPLAYEREXPGAGE_PCROOM_DESC_NA")
      elseif isBlackSpiritEnable then
        name = PAGetString(Defines.StringSheet_GAME, "LUA_SELFPLAYEREXPGAGE_PCROOM_TITLE")
        desc = PAGetString(Defines.StringSheet_GAME, "LUA_CHARACTERINFO_CASHBUFF_VALUEPACKAGE_DESC")
      else
        name = PAGetString(Defines.StringSheet_GAME, "LUA_SELFPLAYEREXPGAGE_PCROOM_TITLE")
        desc = PAGetString(Defines.StringSheet_GAME, "LUA_CHARACTERINFO_CASHBUFF_VALUEPACKAGE_DESC")
      end
    elseif buffType == self._eBUFF_TYPE.Kamasylvia then
      leftTime = convertStringFromDatetime(toInt64(0, starter))
      if isGameTypeRussia() then
        local s64_dayCycle = toInt64(0, 86400)
        local s64_day = toInt64(0, starter) / s64_dayCycle
        if s64_day < toInt64(0, 3650) then
          name = PAGetString(Defines.StringSheet_GAME, "LUA_SELFPLAYEREXPGAGE_YAZBUFF_TITLE_RUS")
          desc = PAGetString(Defines.StringSheet_GAME, "LUA_SELFPLAYEREXPGAGE_YAZBUFF_DESC_RUS")
        else
          name = PAGetString(Defines.StringSheet_GAME, "LUA_SELFPLAYEREXPGAGE_YAZBUFF_TITLE_RUS")
          desc = PAGetString(Defines.StringSheet_GAME, "LUA_SELFPLAYEREXPGAGE_YAZBUFF_DESC_RUS_FOR_INFINITY")
        end
      else
        name = PAGetString(Defines.StringSheet_GAME, "LUA_SELFPLAYEREXPGAGE_YAZBUFF_TITLE")
        desc = PAGetString(Defines.StringSheet_GAME, "LUA_SELFPLAYEREXPGAGE_YAZBUFF_DESC_CONSOLE")
      end
    elseif buffType == self._eBUFF_TYPE.ValuePack then
      leftTime = convertStringFromDatetime(toInt64(0, premium))
      if isGameTypeJapan() then
        name = PAGetString(Defines.StringSheet_GAME, "LUA_SELFPLAYEREXPGAGE_EILEENBUFF_TITLE")
        desc = PAGetString(Defines.StringSheet_GAME, "LUA_SELFPLAYEREXPGAGE_EILEENBUFF_DESC_JP")
      elseif isGameTypeRussia() then
        local s64_dayCycle = toInt64(0, 86400)
        local s64_day = toInt64(0, premium) / s64_dayCycle
        if s64_day < toInt64(0, 3650) then
          name = PAGetString(Defines.StringSheet_GAME, "LUA_SELFPLAYEREXPGAGE_EILEENBUFF_TITLE_RUS")
          desc = PAGetString(Defines.StringSheet_GAME, "LUA_SELFPLAYEREXPGAGE_EILEENBUFF_DESC_RUS")
        else
          name = PAGetString(Defines.StringSheet_GAME, "LUA_SELFPLAYEREXPGAGE_EILEENBUFF_TITLE_RUS")
          desc = PAGetString(Defines.StringSheet_GAME, "LUA_SELFPLAYEREXPGAGE_EILEENBUFF_DESC_RUS_FOR_INFINITY")
        end
      elseif isGameTypeTaiwan() then
        name = PAGetString(Defines.StringSheet_GAME, "LUA_SELFPLAYEREXPGAGE_EILEENBUFF_TITLE_TW")
        desc = PAGetString(Defines.StringSheet_GAME, "LUA_SELFPLAYEREXPGAGE_EILEENBUFF_DESC_TW")
      elseif isGameTypeSA() then
        name = PAGetString(Defines.StringSheet_GAME, "LUA_SELFPLAYEREXPGAGE_EILEENBUFF_TITLE_SA")
        desc = PAGetString(Defines.StringSheet_GAME, "LUA_SELFPLAYEREXPGAGE_EILEENBUFF_DESC_SA")
      elseif isGameTypeKR2() then
        name = PAGetString(Defines.StringSheet_GAME, "LUA_SELFPLAYEREXPGAGE_EILEENBUFF_TITLE_KR2")
        desc = PAGetString(Defines.StringSheet_GAME, "LUA_SELFPLAYEREXPGAGE_EILEENBUFF_DESC_KR2")
      elseif isGameTypeTR() then
        name = PAGetString(Defines.StringSheet_GAME, "LUA_SELFPLAYEREXPGAGE_EILEENBUFF_TITLE_TR")
        desc = PAGetString(Defines.StringSheet_GAME, "LUA_SELFPLAYEREXPGAGE_EILEENBUFF_DESC_TR")
      elseif isGameTypeTH() then
        name = PAGetString(Defines.StringSheet_GAME, "LUA_SELFPLAYEREXPGAGE_EILEENBUFF_TITLE_TH")
        desc = PAGetString(Defines.StringSheet_GAME, "LUA_SELFPLAYEREXPGAGE_EILEENBUFF_DESC_TH")
      elseif isGameTypeID() then
        name = PAGetString(Defines.StringSheet_GAME, "LUA_SELFPLAYEREXPGAGE_EILEENBUFF_TITLE_ID")
        desc = PAGetString(Defines.StringSheet_GAME, "LUA_SELFPLAYEREXPGAGE_EILEENBUFF_DESC_ID")
      else
        name = PAGetString(Defines.StringSheet_GAME, "LUA_SELFPLAYEREXPGAGE_EILEENBUFF_TITLE")
        desc = PAGetString(Defines.StringSheet_GAME, "LUA_CHARACTERINFO_CASHBUFF_VALUEPACKAGE_DESC")
      end
    elseif buffType == self._eBUFF_TYPE.Pearl then
      name = PAGetString(Defines.StringSheet_GAME, "LUA_SELFPLAYEREXPGAGE_PEARLBUFF_TITLE")
      leftTime = convertStringFromDatetime(toInt64(0, pearl))
      desc = PAGetString(Defines.StringSheet_GAME, "LUA_SELFPLAYEREXPGAGE_PEARLBUFF_DESC")
    elseif buffType == self._eBUFF_TYPE.GuildWar and true == self._localNodeInvestment then
      leftTime = nil
      name = PAGetString(Defines.StringSheet_GAME, "LUA_SELFPLAYEREXPGAGE_NODELVBUFF_TITLE")
      if 0 < expNodePercent then
        desc = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_SELFPLAYEREXPGAGE_NODELVBUFF_DESC_WITH_BUFF", "nodeName", self._localNodeName, "percent", tostring(expNodePercent))
      else
        desc = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_SELFPLAYEREXPGAGE_NODELVBUFF_DESC", "nodeName", self._localNodeName)
      end
    elseif buffType == self._eBUFF_TYPE.EXP then
      leftTime = nil
      local expDesc = getBattleExpTooltipText(curChannelData)
      if "" == expDesc then
        local battleExp = curChannelData:getBattleExp()
        if battleExp > CppDefine.e100Percent then
          if "" ~= expDesc then
            expDesc = expDesc .. "\n"
          end
          expDesc = expDesc .. PAGetStringParam1(Defines.StringSheet_GAME, "EVENT_SYSTEM_ADD_EXP", "percent", tostring((battleExp - CppDefine.e100Percent) / CppDefine.e1Percent))
        end
        local skillExp = curChannelData:getSkillExp()
        if skillExp > CppDefine.e100Percent then
          if "" ~= expDesc then
            expDesc = expDesc .. "\n"
          end
          expDesc = expDesc .. PAGetStringParam1(Defines.StringSheet_GAME, "EVENT_SYSTEM_ADD_SKILL_EXP", "percent", tostring((skillExp - CppDefine.e100Percent) / CppDefine.e1Percent))
        end
        local vehicleExp = curChannelData:getVehicleExp()
        if vehicleExp > CppDefine.e100Percent then
          if "" ~= expDesc then
            expDesc = expDesc .. "\n"
          end
          expDesc = expDesc .. PAGetStringParam1(Defines.StringSheet_GAME, "EVENT_SYSTEM_ADD_VEHICLE_EXP", "percent", tostring((vehicleExp - CppDefine.e100Percent) / CppDefine.e1Percent))
        end
        for lifeIndex = 0, CppEnums.LifeExperienceType.Type_Count - 1 do
          local lifeExp = curChannelData:getLifeExp(lifeIndex)
          if lifeExp > CppDefine.e100Percent then
            if "" ~= expDesc then
              expDesc = expDesc .. "\n"
            end
            expDesc = expDesc .. PAGetStringParam2(Defines.StringSheet_GAME, "EVENT_SYSTEM_ADD_LIFE_EXP", "type", CppEnums.LifeExperienceString[lifeIndex], "percent", tostring((lifeExp - CppDefine.e100Percent) / CppDefine.e1Percent))
          end
        end
      end
      name = PAGetString(Defines.StringSheet_GAME, "LUA_SELFPLAYEREXPGAGE_EXPBUFF")
      if "" ~= expDesc then
        desc = "<PAColor0xFF66CC33>" .. expDesc .. "<PAOldColor>"
      else
        desc = ""
      end
    elseif buffType == self._eBUFF_TYPE.Drop then
      leftTime = nil
      local expDesc = getBattleExpTooltipText(curChannelData)
      if "" == expDesc then
        local addRate = curChannelData:getItemDrop()
        if addRate > CppDefine.e100Percent then
          expDesc = PAGetStringParam1(Defines.StringSheet_GAME, "EVENT_SYSTEM_ADD_DROP_ITEM_RATE", "percent", tostring((addRate - CppDefine.e100Percent) / CppDefine.e1Percent))
        end
      end
      name = PAGetString(Defines.StringSheet_GAME, "LUA_SELFPLAYEREXPGAGE_DROPBUFF")
      if "" ~= expDesc then
        desc = "<PAColor0xFF66CC33>" .. expDesc .. "<PAOldColor>"
      else
        desc = ""
      end
    elseif buffType == self._eBUFF_TYPE.Exchange then
      name = PAGetString(Defines.StringSheet_GAME, "LUA_SELFCHARACTER_BUFF_TOOLTIP_NAME")
      desc = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_CASH_CUSTOMIZATION_BUFFTOOLTIP_DESC", "customizationPackageTime", convertStringFromDatetime(toInt64(0, customize)))
      leftTime = convertStringFromDatetime(toInt64(0, customize))
    elseif buffType == self._eBUFF_TYPE.Merv then
      name = PAGetString(Defines.StringSheet_GAME, "LUA_SELFPLAYEREXPGAUGE_DYEINGPACKEAGE_TITLE")
      desc = PAGetString(Defines.StringSheet_GAME, "LUA_SELFPLAYEREXPGAUGE_DYEINGPACKEAGE_DESC") .. convertStringFromDatetime(toInt64(0, dyeingPackage))
      leftTime = convertStringFromDatetime(toInt64(0, dyeingPackage))
    elseif buffType == self._eBUFF_TYPE.KamasylviaForRussia then
      name = PAGetString(Defines.StringSheet_GAME, "LUA_SELFPLAYEREXPGAGE_YAZBUFF_TITLE")
      desc = PAGetString(Defines.StringSheet_GAME, "LUA_SELFPLAYEREXPGAGE_YAZBUFF_DESC") .. "\n" .. convertStringFromDatetime(toInt64(0, russiaKamasilv))
      leftTime = convertStringFromDatetime(toInt64(0, russiaKamasilv))
    elseif buffType == self._eBUFF_TYPE.GoldenBell then
      local curChannelData = getCurrentChannelServerData()
      local channelName = getChannelName(curChannelData._worldNo, curChannelData._serverNo)
      name = PAGetString(Defines.StringSheet_GAME, "LUA_SELFPLAYEREXPGAGE_GOLDENBELL_TOOLTIP_NAME")
      if nil == goldenBellGuildName or "" == goldenBellGuildName or " " == goldenBellGuildName then
        desc = PAGetStringParam3(Defines.StringSheet_GAME, "LUA_SELFPLAYEREXPGAGE_GOLDENBELL_TOOLTIP_DESC_NOGUILD", "channelName", channelName, "name", goldenBellCharacterName, "percent", goldenBellPercentString) .. " <PAColor0xFFF26A6A>" .. goldenBellTime .. "<PAOldColor>"
      else
        desc = PAGetStringParam4(Defines.StringSheet_GAME, "LUA_SELFPLAYEREXPGAGE_GOLDENBELL_TOOLTIP_DESC_GUILD", "channelName", channelName, "guildName", goldenBellGuildName, "name", goldenBellCharacterName, "percent", goldenBellPercentString) .. " <PAColor0xFFF26A6A>" .. goldenBellTime .. "<PAOldColor>"
      end
      leftTime = goldenBellTime
    elseif buffType == self._eBUFF_TYPE.SkillChange then
      name = PAGetString(Defines.StringSheet_GAME, "LUA_SELFPLAYEREXPGAGE_SKILLRESET_TOOLTIP_NAME")
      desc = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_SELFPLAYEREXPGAGE_SKILLRESET_TOOLTIP_DESC", "skillResetTime", convertStringFromDatetime(toInt64(0, skillResetTime)))
      leftTime = convertStringFromDatetime(toInt64(0, skillResetTime))
    elseif buffType == self._eBUFF_TYPE.AwakenChange then
      name = PAGetString(Defines.StringSheet_GAME, "LUA_SELFPLAYEREXPGAGE_AWAKENSKILL_TOOLTIP_NAME")
      desc = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_SELFPLAYEREXPGAGE_AWAKENSKILL_TOOLTIP_DESC", "awakenSkillResetTime", convertStringFromDatetime(toInt64(0, awakenSkillResetTime)))
      leftTime = convertStringFromDatetime(toInt64(0, awakenSkillResetTime))
    elseif buffType == self._eBUFF_TYPE.PremiumPackForRussia then
      name = PAGetString(Defines.StringSheet_GAME, "LUA_SELFPLAYEREXPGAGE_RUSSIAPACK3_TOOLTIP_NAME")
      desc = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_SELFPLAYEREXPGAGE_RUSSIAPACK3_TOOLTIP_DESC", "russiaPack3Time", convertStringFromDatetime(toInt64(0, russiaPack3Time)))
      leftTime = convertStringFromDatetime(toInt64(0, russiaPack3Time))
    elseif buffType == self._eBUFF_TYPE.BlackSpiritEXP then
      name = PAGetString(Defines.StringSheet_GAME, "LUA_SELFPLAYEREXPGAGE_BLACKSPIRITTRAINING_TOOLTIP_NAME")
      desc = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_SELFPLAYEREXPGAGE_BLACKSPIRITTRAINING_TOOLTIP_DESC", "trainingTime", convertStringFromDatetime(toInt64(0, trainingTime)))
      leftTime = convertStringFromDatetime(toInt64(0, trainingTime))
    elseif buffType == self._eBUFF_TYPE.GoldValuePack then
      name = PAGetString(Defines.StringSheet_GAME, "LUA_SELFPLAYEREXPGAGE_PREMIUMVALUE_TITLE")
      desc = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_SELFPLAYEREXPGAGE_PREMIUMVALUE_ONLY_XB_PS_DESC", "time", convertStringFromDatetime(toInt64(0, premiumValueTime)))
      leftTime = convertStringFromDatetime(toInt64(0, premiumValueTime))
    elseif buffType == self._eBUFF_TYPE.BlackSpiritSkill then
      name = PAGetString(Defines.StringSheet_GAME, "LUA_SELFPLAYEREXPGAGE_BLACKSPIRITSKILLTRAINING_TOOLTIP_NAME")
      desc = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_SELFPLAYEREXPGAGE_BLACKSPIRITSKILLTRAINING_TOOLTIP_DESC", "skilltrainingTime", convertStringFromDatetime(toInt64(0, skilltrainingTime)))
      leftTime = convertStringFromDatetime(toInt64(0, skilltrainingTime))
    elseif buffType == self._eBUFF_TYPE.MemoryofArtisan then
      name = PAGetString(Defines.StringSheet_GAME, "LUA_SELFPLAYEREXPGAUGE_MAESTROTITLE")
      desc = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_SELFPLAYEREXPGAUGE_MAESTRODESC", "time", convertStringFromDatetime(toInt64(0, memoryOfMaestroTime)))
      leftTime = convertStringFromDatetime(toInt64(0, memoryOfMaestroTime))
    elseif buffType == self._eBUFF_TYPE.ArshaServerBuff then
      local arshaItemDropBuffRate = ToClient_getArshaItemDropBuffRate() / 10000
      name = PAGetString(Defines.StringSheet_GAME, "LUA_ARSHA_ITEMDROPBUFF_NAME")
      desc = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_ARSHA_ITEMDROPBUFF_DESC", "dropRate", arshaItemDropBuffRate)
      leftTime = nil
    elseif buffType == self._eBUFF_TYPE.BookOfCombat then
      name = PAGetString(Defines.StringSheet_GAME, "LUA_ADVENTUREBOOKBUFF_TITLE")
      desc = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_SELFPLAYEREXPGAUGE_DYEINGPACKEAGE_TIME", "dyeingpackageTime", convertStringFromDatetime(toInt64(0, bookOfCombatTime))) .. "\n" .. PAGetString(Defines.StringSheet_GAME, "LUA_ADVENTUREBOOKBUFF_INFO")
      leftTime = convertStringFromDatetime(toInt64(0, bookOfCombatTime))
    elseif buffType == self._eBUFF_TYPE.FeverBuff then
      local feverPoint = player:getFeverPoint()
      local maxFeverPoint = player:getMaxFeverPoint()
      local addFeverPoint = player:getAddFeverPoint()
      local feverDropRate = player:getUseFeverSkillDropDesc()
      feverDropRate = feverDropRate / 10000
      name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_FEVERPOINT_TITLE")
      desc = PAGetStringParam3(Defines.StringSheet_GAME, "LUA_AGRISSPOINT_ICON_TOOLTIP_CONSOLE", "addFeverPoint", addFeverPoint, "maxFeverPoint", maxFeverPoint, "feverDropRate", feverDropRate)
      if 0 < feverPoint then
        self._iconUV[buffType] = self._feverIconUV.on
        leftTime = feverPoint .. "/" .. maxFeverPoint
      else
        self._iconUV[buffType] = self._feverIconUV.off
        leftTime = nil
      end
    end
    uv = self._iconUV[buffType]
    self._buffData[buffType] = {}
    self._buffData[buffType].name = name
    self._buffData[buffType].desc = desc
    self._buffData[buffType].uv = uv
    self._buffData[buffType].leftTime = leftTime
  end
end
function PaGlobal_CharInfoCashBuff_All:getBuffDataByType(type)
  if nil == self._buffData[type] then
    UI.ASSERT(false, "self._buffData[type] is nil = " .. tostring(type))
    return
  end
  return self._buffData[type].name, self._buffData[type].desc, self._buffData[type].uv, self._buffData[type].leftTime
end
function PaGlobal_CharInfoCashBuff_All:validate()
  self._ui.list2_buff:isValidate()
  self._ui.txt_NoBuff:isValidate()
  self._ui.stc_PopupTooltip:isValidate()
  self._ui.stc_PopupTooltipBG_Title:isValidate()
  self._ui.stc_PopupTooltipBg:isValidate()
  self._ui.stc_PopupTooltipDesc:isValidate()
  self._ui.stc_PopupTooltipTitle:isValidate()
  self._ui.stc_Console_KeyGuideBg:isValidate()
  self._ui.stc_KeyGuide_X:isValidate()
  self._ui.stc_KeyGuide_B:isValidate()
end
