function PaGlobalFunc_CharInfoBasic_All_Update()
  PaGlobal_CharInfoBasic_All:update()
end
function HandleEventPadPress_CharInfoBasic_All_ClickOtherTab(isUp)
  if false == PaGlobal_CharInfo_All._isConsole then
    return
  end
  local curTab = PaGlobal_CharInfoBasic_All._currentTab
  if true == isUp then
    curTab = curTab + 1
    if 1 < curTab then
      curTab = 0
    end
  else
    curTab = curTab - 1
    if curTab < 0 then
      curTab = 1
    end
  end
  HandleEventLUp_CharInfoBasic_All_ClickOtherTab(curTab)
end
function HandleEventLUp_CharInfoBasic_All_ClickOtherTab(tabIdx)
  ToClient_getGameUIManagerWrapper():setLuaCacheDataListNumber(__eCharacterInfo, tabIdx, CppEnums.VariableStorageType.eVariableStorageType_User)
  PaGlobal_CharInfoBasic_All:setMenuPosition()
  local isBattleInfoOpen = 0 == tabIdx
  PaGlobal_CharInfoBasic_All._ui.stc_BattleInfoBg:SetShow(isBattleInfoOpen)
  PaGlobal_CharInfoBasic_All._ui.rdo_BattleInfo:SetCheck(isBattleInfoOpen)
  PaGlobal_CharInfoBasic_All._ui.stc_LifeBg:SetShow(not isBattleInfoOpen)
  PaGlobal_CharInfoBasic_All._ui.rdo_LifeInfo:SetCheck(not isBattleInfoOpen)
  local selectbarX = 0
  if true == isBattleInfoOpen then
    FromClient_CharInfoBasic_All_PotentialUpdate()
    FromClient_CharInfoBasic_All_FitnesspUpdate(0, 0, 0, 0)
    FromClient_CharInfoBasic_All_AtkDefUpdate()
    FromClient_CharInfoBasic_All_ResistUpdate()
    PaGlobal_CharInfoBasic_All._currentTab = 0
    selectbarX = PaGlobal_CharInfoBasic_All._ui.rdo_BattleInfo:GetSpanSize().x
  else
    PaGlobal_CharInfoBasic_All._currentTab = 1
    selectbarX = PaGlobal_CharInfoBasic_All._ui.rdo_LifeInfo:GetSpanSize().x
    FromClient_CharInfoBasic_All_LifeUpdate()
  end
  PaGlobal_CharInfoBasic_All._ui.stc_TabSelectBar:SetSpanSize(selectbarX, PaGlobal_CharInfoBasic_All._ui.stc_TabSelectBar:GetSpanSize().y)
  if 1 == tabIdx then
    HandleEventLUp_ChracterInfo_All_ScaleResizeLDown()
    HandleEventLUp_ChracterInfo_All_ScaleResizeLPress()
    HandleEventLUp_ChracterInfo_All_ScaleResizeLUp()
  end
  PaGlobal_CharInfo_All:setKeyGuideAlign(0)
end
function PaGlobal_CharInfoBasic_All_UpdateCharPhoto()
  local classType = PaGlobal_CharInfoBasic_All._selfPlayer:getClassType()
  local TextureName = ToClient_GetCharacterFaceTexturePath(PaGlobal_CharInfoBasic_All._selfPlayer:getCharacterNo_64())
  local isCaptureExist = PaGlobal_CharInfoBasic_All._ui.stc_CharPhoto:ChangeTextureInfoNameNotDDS(TextureName, classType, true)
  if isCaptureExist == true then
    PaGlobal_CharInfoBasic_All._ui.stc_CharPhoto:getBaseTexture():setUV(0, 0, 1, 1)
  else
    local DefaultFace = CppEnums.ClassType_DefaultFaceTexture[classType]
    PaGlobal_CharInfoBasic_All._ui.stc_CharPhoto:ChangeTextureInfoName(DefaultFace[1])
    local x1, y1, x2, y2 = setTextureUV_Func(PaGlobal_CharInfoBasic_All._ui.stc_CharPhoto, DefaultFace[2], DefaultFace[3], DefaultFace[4], DefaultFace[5])
    PaGlobal_CharInfoBasic_All._ui.stc_CharPhoto:getBaseTexture():setUV(x1, y1, x2, y2)
  end
  PaGlobal_CharInfoBasic_All._ui.stc_CharPhoto:setRenderTexture(PaGlobal_CharInfoBasic_All._ui.stc_CharPhoto:getBaseTexture())
end
function HandleEventLUp_CharInfoBasic_All_TakePhoto()
  if false == PaGlobalFunc_ChracterInfo_All_GetBgShow(PaGlobal_CharInfo_All._TABINDEX._basic) then
    return
  end
  HandleEventOnOut_CharInfoBasic_All_EnchantStack(false)
  FGlobal_InGameCustomize_SetCharacterInfo(true)
  IngameCustomize_Show()
end
function HandleEventLUp_CharInfoBasic_All_ShowLifeRanking()
  if false == PaGlobalFunc_ChracterInfo_All_GetBgShow(PaGlobal_CharInfo_All._TABINDEX._basic) then
    return
  end
  if false == _ContentsGroup_NewUI_LifeRanking_All then
    if nil ~= Panel_LifeRanking then
      FGlobal_LifeRanking_Open()
    end
  elseif nil ~= Panel_LifeRanking_All then
    PaGlobal_LifeRanking_Open_All()
  end
end
function HandleEventLUp_CharInfoBasic_All_SetEditFocus()
  if false == PaGlobalFunc_ChracterInfo_All_GetBgShow(PaGlobal_CharInfo_All._TABINDEX._basic) then
    return
  end
  local preIntroduceText = PaGlobal_CharInfoBasic_All._ui.edit_multiEdit:GetEditText()
  local originString = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_CHARACTERINFO_MYINTRODUCE_INPUT")
  if preIntroduceText == originString or "" == preIntroduceText then
    PaGlobal_CharInfoBasic_All._ui.edit_multiEdit:SetEditText("")
  end
end
function HandleEventLUp_CharInfoBasic_All_SetIntroduceText()
  if false == PaGlobalFunc_ChracterInfo_All_GetBgShow(PaGlobal_CharInfo_All._TABINDEX._basic) then
    return
  end
  local preIntroduceText = PaGlobal_CharInfoBasic_All._ui.edit_multiEdit:GetEditText()
  local originString = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_CHARACTERINFO_MYINTRODUCE_INPUT")
  if true == PaGlobalFunc_CharInfoBasic_All_GetFocusEdit() and preIntroduceText ~= originString then
    PaGlobal_CharInfoBasic_All._ui.edit_multiEdit:SetEditText(preIntroduceText)
    ToClient_RequestSetUserIntroduction(preIntroduceText)
    ClearFocusEdit()
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_SELFCHARACTERINFO_MYINTRODUCE_REGIST"))
  end
end
function HandleEventLUp_CharInfoBasic_All_OpenSkillWindow()
  if false == PaGlobalFunc_ChracterInfo_All_GetBgShow(PaGlobal_CharInfo_All._TABINDEX._basic) then
    return
  end
  if true == _ContentsGroup_UISkillGroupTreeLayOut then
    PaGlobalFunc_SkillGroup_HotKeyToggle()
  elseif nil ~= Panel_Window_Skill then
    PaGlobal_Skill:SkillWindow_Show()
  end
end
function HandleEventLUp_CharInfoBasic_All_OpenMusicAlbum()
  if false == PaGlobalFunc_ChracterInfo_All_GetBgShow(PaGlobal_CharInfo_All._TABINDEX._basic) then
    return
  end
  if true == _ContentsGroup_InstrumentPerformance then
    PaGlobal_MusicAlbum_All_Open()
  end
end
function HandleEventLUp_CharInfoBasic_All_OpenBlackSpiritEnchant()
  if false == PaGlobalFunc_ChracterInfo_All_GetBgShow(PaGlobal_CharInfo_All._TABINDEX._basic) then
    return
  end
  if false == IsSelfPlayerWaitAction() then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_CURRENTACTION_NOT_SUMMON_BLACKSPIRIT"))
    return
  end
  ToClient_AddBlackSpiritFlush(0, true, CppEnums.EFlush_BlackSpirit_Ui_Type.eFlush_BlackSpirit_Ui_ItemEnchant)
end
function HandleEventOnOut_CharInfoBasic_All_FacePhoto(isShow)
  if false == PaGlobalFunc_ChracterInfo_All_GetBgShow(PaGlobal_CharInfo_All._TABINDEX._basic) or false == isShow then
    TooltipSimple_Hide()
    return
  end
  local control, name, desc
  name = PAGetString(Defines.StringSheet_GAME, "LUA_GAMEEXIT_FACEPHOTO_TOOLTIP_NAME")
  desc = PAGetString(Defines.StringSheet_GAME, "LUA_GAMEEXIT_FACEPHOTO_TOOLTIP_DESC")
  control = PaGlobal_CharInfoBasic_All._ui.btn_FacePhoto
  if nil == control then
    UI.ASSERT_NAME(nil ~= control, " Panel_CharacterInfoBasic_All_2.lua / HandleEventOnOut_CharInfoBasic_All_FacePhoto() /  control is nil", "\234\185\128\234\183\188\236\154\176")
    return
  end
  TooltipSimple_Show(control, name, desc)
end
function HandleEventOnOut_CharInfoBasic_All_EnchantStack(isShow, isEnchatIcon)
  if false == PaGlobalFunc_ChracterInfo_All_GetBgShow(PaGlobal_CharInfo_All._TABINDEX._basic) or false == isShow then
    TooltipSimple_Hide()
    return
  end
  local control, name, desc, isValksItemCheck
  ToClient_RequestCharacterEnchantFailCount()
  local defaultCount = PaGlobal_CharInfoBasic_All._selfPlayer:get():getEnchantFailCount()
  local valksCount = PaGlobal_CharInfoBasic_All._selfPlayer:get():getEnchantValuePackCount()
  local familyCount = getEnchantInformation():ToClient_getBonusStackCount()
  local isValksItem = ToClient_IsContentsGroupOpen("47")
  if isValksItem == false then
    isValksItemCheck = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GAMEEXIT_ENCHANTCOUNT_TOOLTIP_ADDCOUNT_NONE", "defaultCount", tostring(defaultCount))
  else
    isValksItemCheck = PAGetStringParam3(Defines.StringSheet_GAME, "LUA_GAMEEXIT_ENCHANTCOUNT_TOOLTIP", "defaultCount", tostring(defaultCount), "valksCount", tostring(valksCount), "familyCount", tostring(familyCount))
  end
  name = PAGetString(Defines.StringSheet_GAME, "LUA_GAMEEXIT_NORMALSTACK_TOOLTIP_NAME")
  desc = PAGetString(Defines.StringSheet_GAME, "LUA_GAMEEXIT_NORMALSTACK_TOOLTIP_DESC") .. isValksItemCheck
  if false == isEnchatIcon then
    control = PaGlobal_CharInfoBasic_All._ui.txt_EnchantCount
  else
    control = PaGlobal_CharInfoBasic_All._ui.stc_EnchantStackIcon
  end
  if nil == control then
    UI.ASSERT_NAME(nil ~= control, " Panel_CharacterInfoBasic_All_2.lua / HandleEventOnOut_CharInfoBasic_All_EnchantStack() /  control is nil", "\234\185\128\234\183\188\236\154\176")
    return
  end
  TooltipSimple_Show(control, name, desc)
end
function HandleEventOnOut_CharInfoBasic_All_Fame(isShow, tipType)
  if false == PaGlobalFunc_ChracterInfo_All_GetBgShow(PaGlobal_CharInfo_All._TABINDEX._basic) or false == isShow or nil == tipType then
    TooltipSimple_Hide()
    return
  end
  local string = {
    [0] = {
      "LUA_FAMILYPOINTS_SUM_TOOLTIP_TITLE",
      "LUA_FAMILYPOINTS_SUM_TOOLTIP_DESC"
    },
    [1] = {
      "LUA_FAMILYPOINTS_COMBAT_TOOLTIP_TITLE",
      "LUA_FAMILYPOINTS_COMBAT_TOOLTIP_DESC"
    },
    [2] = {
      "LUA_FAMILYPOINTS_LIFE_TOOLTIP_TITLE",
      "LUA_FAMILYPOINTS_LIFE_TOOLTIP_DESC"
    },
    [3] = {
      "LUA_FAMILYPOINTS_ETC_TOOLTIP_TITLE",
      "LUA_FAMILYPOINTS_ETC_TOOLTIP_DESC"
    }
  }
  local string_console = {
    [0] = {
      "LUA_FAMILYPOINTS_SUM_TOOLTIP_TITLE",
      "LUA_FAMILYPOINTS_SUM_TOOLTIP_DESC"
    },
    [1] = {
      "LUA_FAMILYPOINTS_COMBAT_TOOLTIP_TITLE",
      "LUA_FAMILYPOINTS_COMBAT_TOOLTIP_DESC"
    },
    [2] = {
      "LUA_FAMILYPOINTS_LIFE_TOOLTIP_TITLE",
      "LUA_FAMILYPOINTS_LIFE_TOOLTIP_DESC"
    },
    [3] = {
      "LUA_FAMILYPOINTS_ETC_TOOLTIP_TITLE",
      "LUA_FAMILYPOINTS_ETC_TOOLTIP_DESC"
    }
  }
  local fameUI = {
    [0] = PaGlobal_CharInfoBasic_All._ui.txt_BattlePoint,
    [1] = PaGlobal_CharInfoBasic_All._ui.txt_LifePoint,
    [2] = PaGlobal_CharInfoBasic_All._ui.txt_SpecialPoint,
    [3] = PaGlobal_CharInfoBasic_All._ui.txt_FamilyPoint
  }
  local name, desc
  if false == PaGlobal_CharInfoBasic_All._isConsole then
    name = PAGetString(Defines.StringSheet_GAME, string[tipType][1])
    desc = PAGetString(Defines.StringSheet_GAME, string[tipType][2])
  else
    name = PAGetString(Defines.StringSheet_GAME, string_console[tipType][1])
    desc = PAGetString(Defines.StringSheet_GAME, string_console[tipType][2])
  end
  local control = fameUI[tipType]
  if nil == control or nil == name then
    UI.ASSERT_NAME(nil ~= control, " Panel_CharacterInfoBasic_All_2.lua / HandleEventOnOut_CharInfoBasic_All_FamliyPoints() /  control or name is nil", "\234\185\128\234\183\188\236\154\176")
    return
  end
  TooltipSimple_Show(control, name, desc)
  if 1 == tipType then
    local tooltipPosY = Panel_Tooltip_SimpleText:GetPosY()
    local tooltipPosX = Panel_Tooltip_SimpleText:GetPosX()
    local screenX = getScreenSizeX()
    local screenY = getScreenSizeY()
    if tooltipPosY < 0 then
      Panel_Tooltip_SimpleText:SetPosY(math.abs(tooltipPosY))
    elseif tooltipPosY > screenY then
      Panel_Tooltip_SimpleText:SetPosY(tooltipPosY - (screenY - tooltipPosY))
    end
    if tooltipPosX < 0 then
      Panel_Tooltip_SimpleText:SetPosX(math.abs(tooltipPosX))
    elseif tooltipPosX > screenX then
      Panel_Tooltip_SimpleText:SetPosX(tooltipPosX - (screenX - tooltipPosX))
    end
  end
end
function HandleEventOnOut_CharInfoBasic_All_Regist(isShow, tipType)
  if false == PaGlobalFunc_ChracterInfo_All_GetBgShow(PaGlobal_CharInfo_All._TABINDEX._basic) or false == isShow or nil == tipType then
    TooltipSimple_Hide()
    return
  end
  local string = {
    [0] = {
      "LUA_CHARACTERINFO_TXT_REGIST_STUN_TOOLTIP_NAME",
      "LUA_CHARACTERINFO_TXT_REGIST_STUN_TOOLTIP_DESC"
    },
    [1] = {
      "LUA_CHARACTERINFO_TXT_REGIST_DOWN_TOOLTIP_NAME",
      "LUA_CHARACTERINFO_TXT_REGIST_DOWN_TOOLTIP_DESC"
    },
    [2] = {
      "LUA_CHARACTERINFO_TXT_REGIST_CAPTURE_TOOLTIP_NAME",
      "LUA_CHARACTERINFO_TXT_REGIST_CAPTURE_TOOLTIP_DESC"
    },
    [3] = {
      "LUA_CHARACTERINFO_TXT_REGIST_KNOCKBACK_TOOLTIP_NAME",
      "LUA_CHARACTERINFO_TXT_REGIST_KNOCKBACK_TOOLTIP_DESC"
    }
  }
  local RegistUI = {
    [0] = PaGlobal_CharInfoBasic_All._ui.txt_StunRegistTitle,
    [1] = PaGlobal_CharInfoBasic_All._ui.txt_DownRegistTitle,
    [2] = PaGlobal_CharInfoBasic_All._ui.txt_GrabRegistTitle,
    [3] = PaGlobal_CharInfoBasic_All._ui.txt_AirRegistTitle
  }
  local name = PAGetString(Defines.StringSheet_GAME, string[tipType][1])
  local desc = PAGetString(Defines.StringSheet_GAME, string[tipType][2])
  local control = RegistUI[tipType]
  if nil == control then
    UI.ASSERT_NAME(nil ~= control, " Panel_CharacterInfoBasic_All_2.lua / HandleEventOnOut_CharInfoBasic_All_Regist() /  control is nil", "\234\185\128\234\183\188\236\154\176")
    return
  end
  TooltipSimple_Show(control, name, desc)
end
function HandleEventOnOut_CharInfoBasic_All_Fitness(isShow, tipType)
  if false == PaGlobalFunc_ChracterInfo_All_GetBgShow(PaGlobal_CharInfo_All._TABINDEX._basic) or false == isShow or nil == tipType then
    TooltipSimple_Hide()
    return
  end
  local control, name, desc
  if PaGlobal_CharInfoBasic_All._ENUM_FITNESS.BREATH == tipType then
    control = PaGlobal_CharInfoBasic_All._ui.txt_Breath
    name = PAGetString(Defines.StringSheet_GAME, "LUA_CHARACTERINFO_FITNESS_STAMINA_TITLE_ONE")
    desc = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_SELFCHARACTERINFO_FITNESS_STAMINA_MSG", "type", tostring(ToClient_GetFitnessLevelStatus(tipType)))
  elseif PaGlobal_CharInfoBasic_All._ENUM_FITNESS.POWER == tipType then
    control = PaGlobal_CharInfoBasic_All._ui.txt_Power
    name = PAGetString(Defines.StringSheet_GAME, "LUA_CHARACTERINFO_FITNESS_STRENGTH_TITLE_ONE")
    desc = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_SELFCHARACTERINFO_FITNESS_STRENGTH_MSG", "type", tostring(ToClient_GetFitnessLevelStatus(tipType) / 10000))
  else
    control = PaGlobal_CharInfoBasic_All._ui.txt_Health
    name = PAGetString(Defines.StringSheet_GAME, "LUA_CHARACTERINFO_FITNESS_HEALTH_TITLE_ONE")
    local _hpIncrease = tostring(ToClient_GetFitnessLevelStatus(tipType, 0))
    local _mpIncrease = tostring(ToClient_GetFitnessLevelStatus(tipType, 1))
    local _mentalType = PaGlobal_CharInfoBasic_All._selfPlayer:getCombatResourceType()
    local _mpName = {
      [CppEnums.CombatResourceType.CombatType_MP] = PAGetString(Defines.StringSheet_GAME, "LUA_CHARACTERINFO_TEXT_MP"),
      [CppEnums.CombatResourceType.CombatType_FP] = PAGetString(Defines.StringSheet_GAME, "LUA_CHARACTERINFO_TEXT_FP_NEW"),
      [CppEnums.CombatResourceType.CombatType_EP] = PAGetString(Defines.StringSheet_GAME, "LUA_CHARACTERINFO_TEXT_EP"),
      [CppEnums.CombatResourceType.CombatType_BP] = PAGetString(Defines.StringSheet_GAME, "LUA_SELFCHARACTERINFO_BP")
    }
    local mpTypeTitle = _mpName[_mentalType]
    if true == PaGlobal_CharInfoBasic_All._asianFlag then
      desc = PAGetStringParam3(Defines.StringSheet_GAME, "LUA_CHARACTERINFO_FITNESS_HEALTH_MSG_NEW", "hpIncrease", _hpIncrease, "mpTypeName", mpTypeTitle, "mpIncrease", _mpIncrease)
    else
      desc = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_SELFCHARACTERINFO_FITNESS_HEALTH_MSG", "type", _hpIncrease)
    end
  end
  if nil == control then
    UI.ASSERT_NAME(nil ~= control, " Panel_CharacterInfoBasic_All_2.lua / HandleEventOnOut_CharInfoBasic_All_Regist() /  control is nil", "\234\185\128\234\183\188\236\154\176")
    return
  end
  TooltipSimple_Show(control, name, desc)
end
function HandleEventOnOut_CharInfoBasic_All_Potential(isShow, tipType)
  if false == isShow or nil == tipType or false == PaGlobalFunc_ChracterInfo_All_GetBgShow(PaGlobal_CharInfo_All._TABINDEX._basic) then
    TooltipSimple_Hide()
    return
  end
  if nil == PaGlobal_CharInfoBasic_All._potentialData[tipType] then
    UI.ASSERT_NAME(nil ~= PaGlobal_CharInfoBasic_All._potentialData[tipType], " Panel_CharacterInfoBasic_All_2.lua / HandleEventOnOut_CharInfoBasic_All_Potential() /  PaGlobal_CharInfoBasic_All._potentialData[" .. tostring(tipType) .. "potenIdx'] is nil", "\234\185\128\234\183\188\236\154\176")
    TooltipSimple_Hide()
    return
  end
  local control, name, desc
  control = PaGlobal_CharInfoBasic_All._potentialData[tipType].title
  name = PaGlobal_CharInfoBasic_All._potentialData[tipType].title:GetText()
  desc = PaGlobal_CharInfoBasic_All._potentialData[tipType].toolTipDesc
  TooltipSimple_Show(control, name, desc)
end
function HandleEventOnOut_CharInfoBasic_All_BasicStat(isShow, tipType)
  if false == PaGlobalFunc_ChracterInfo_All_GetBgShow(PaGlobal_CharInfo_All._TABINDEX._basic) or false == isShow or nil == tipType then
    TooltipSimple_Hide()
    return
  end
  local control, name
  if 0 == tipType then
    control = PaGlobal_CharInfoBasic_All._ui.txt_HpTitle
    name = PAGetString(Defines.StringSheet_GAME, "LUA_CHARACTERINFO_TEXT_HPREGEN") .. " : " .. tostring(PaGlobal_CharInfoBasic_All._selfPlayer:get():getRegenHp())
  elseif 1 == tipType then
    control = PaGlobal_CharInfoBasic_All._ui.txt_MpTitle
    name = PaGlobal_CharInfo_All:setMpTooltipByClass()
  else
    control = PaGlobal_CharInfoBasic_All._ui.txt_LTTitle
    name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_CHARACTERINFO_WEIGHT_TOOLTIP")
  end
  if nil == control then
    UI.ASSERT_NAME(nil ~= control, " Panel_CharacterInfoBasic_All_2.lua / HandleEventOnOut_CharInfoBasic_All_Regist() /  control is nil", "\234\185\128\234\183\188\236\154\176")
    return
  end
  TooltipSimple_Show(control, name, "")
end
function HandleEventOnOut_CharInfoBasic_All_LifeGrade(isShow, lifeType)
  if false == PaGlobal_CharInfoBasic_All._ui.stc_LifeBg:GetShow() or false == isShow or nil == lifeType then
    TooltipSimple_Hide()
    return
  end
  local control, name, desc
  local exp = PaGlobal_CharInfoBasic_All._ui.stc_LifeTable[lifeType].expVal
  name = CppEnums.LifeExperienceString[lifeType - 1]
  desc = CppEnums.LifeExperienceTooltip[lifeType - 1]
  control = PaGlobal_CharInfoBasic_All._ui.stc_LifeTable[lifeType].bg
  if 11 == lifeType then
    local value = ToClient_discountPointByBarterLevel() / 10000
    local ceil = math.ceil(value * 1000 - 0.5) / 1000
    if ceil <= 0 then
      ceil = math.abs(ceil)
    end
    name = CppEnums.LifeExperienceString[lifeType]
    desc = PAGetStringParam1(Defines.StringSheet_GAME, CppEnums.LifeExperienceTooltip[lifeType], "value", string.format("%.2f", ceil))
  elseif 7 == lifeType then
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_CHARACTERINFO_CRAFT_DESC_3")
    if true == _ContentsGroup_EnhanceTraining then
      local trainingSKillStatStaticStatus = ToClient_getTrainingLevelSkillStatStaticStatus()
      local skillRate = 0
      local statRate = 0
      if nil == ToClient_GetServantMarketTaxPercent() then
        return
      end
      local discountRate = string.format("%.1f", ToClient_GetServantMarketTaxPercent() / 10000)
      if nil ~= trainingSKillStatStaticStatus then
        skillRate = string.format("%.1f", trainingSKillStatStaticStatus._addVehicleSkillOwnerRate / 10000)
        statRate = string.format("%.1f", trainingSKillStatStaticStatus._addServantStatRate / 10000)
      end
      desc = PAGetStringParam3(Defines.StringSheet_GAME, "LUA_CHARACTERINFO_LIFE_TRAINING_DESC_2", "rate1", tostring(skillRate), "rate2", tostring(statRate), "rate3", tostring(discountRate))
    end
    name = CppEnums.LifeExperienceString[lifeType - 1]
  end
  if nil == control then
    UI.ASSERT_NAME(nil ~= control, " Panel_CharacterInfoBasic_All_2.lua / HandleEventOnOut_CharInfoBasic_All_Regist() /  control is nil", "\234\185\128\234\183\188\236\154\176")
    return
  end
  TooltipSimple_Show(control, name, desc)
end
function HandleEventOnOut_CharInfoBasic_All_MusicRank(isShow)
  if false == PaGlobalFunc_ChracterInfo_All_GetBgShow(PaGlobal_CharInfo_All._TABINDEX._basic) or false == isShow then
    TooltipSimple_Hide()
    return
  end
  local control = PaGlobal_CharInfoBasic_All._ui.txt_MusicGradeValue
  local titleStr = PAGetString(Defines.StringSheet_GAME, "LUA_GAMEEXIT_MUSIC_TOOLTIP_NAME")
  local descStr = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_CHARACTERINFO_LIFE_MUSIC_DESC", "value", ToClient_GetMusicExpRate())
  TooltipSimple_Show(control, titleStr, descStr)
end
function HandleEventOnOut_CharInfoBasic_All_StatusTooltip(idx)
  if nil == PaGlobal_CharInfoBasic_All._statusTable or nil == idx then
    TooltipSimple_Hide()
    return
  end
  local control, name, desc
  control = PaGlobal_CharInfoBasic_All._statusTable[idx]
  if 1 == idx then
    name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_CHARACTERINFO_RENEW_TENDENCY_TITLE")
  elseif 2 == idx then
    name = PAGetString(Defines.StringSheet_RESOURCE, "CHARACTERINFO_TEXT_MENTAL")
  elseif 3 == idx then
    name = PAGetString(Defines.StringSheet_RESOURCE, "CHARACTERINFO_TEXT_CONTRIBUTION")
  elseif 4 == idx then
    name = PAGetString(Defines.StringSheet_RESOURCE, "SKILL_TEXT_POINT")
  elseif 5 == idx then
    name = PAGetString(Defines.StringSheet_RESOURCE, "CHARACTERINFO_TEXT_ZODIA")
  end
  TooltipSimple_Show(control, name, desc)
end
function HandleEventOnOut_CharInfoBasic_All_SubTabTooltip(idx)
  if nil == idx then
    TooltipSimple_Hide()
    return
  end
  local control, name, desc
  if 0 == idx then
    control = PaGlobal_CharInfoBasic_All._ui.rdo_BattleInfo
    name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_CHARACTERINFO_BATTLETITLE")
  else
    control = PaGlobal_CharInfoBasic_All._ui.rdo_LifeInfo
    name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_CHARACTERINFO_RENEW_LIFEINFO_TITLE")
  end
  if nil == control then
    return
  end
  TooltipSimple_Show(control, name, desc)
end
function PaGlobalFunc_CharInfoBasic_All_GetFocusEdit()
  return PaGlobal_CharInfoBasic_All._ui.edit_multiEdit:GetFocusEdit()
end
function HandleEventPadPress_CharInfoBasic_All_OpenVirtualKeyBoard()
  if true == ToClient_isPS4() and false == ToClient_isUserCreateContentsAllowed() then
    ToClient_SystemMsgDialogPS4(__ePS4SystemMsgDialogType_TRC_PSN_UGC_RESTRICTION)
    return
  end
  ClearFocusEdit()
  SetFocusEdit(PaGlobal_CharInfoBasic_All._ui.edit_multiEdit)
end
function HandleEventPadPress_CharInfoBasic_All_EndVirtualKeyBoard(str)
  if true == ToClient_isPS4() and false == ToClient_isUserCreateContentsAllowed() then
    ToClient_SystemMsgDialogPS4(__ePS4SystemMsgDialogType_TRC_PSN_UGC_RESTRICTION)
    return
  end
  PaGlobal_CharInfoBasic_All._ui.edit_multiEdit:SetEditText(str)
  HandleEventLUp_CharInfoBasic_All_SetIntroduceText()
end
function PaGlobalFunc_CharInfoBasic_All_CheckIntroduceEditing(targetUI)
  if false == PaGlobalFunc_ChracterInfo_All_GetBgShow(PaGlobal_CharInfo_All._TABINDEX._basic) then
    return
  end
  return nil ~= targetUI and targetUI:GetKey() == PaGlobal_CharInfoBasic_All._ui.edit_multiEdit:GetKey()
end
function HandleEventOnOut_CharInfoBasic_All_SelfTimerTooltip(show)
  if nil == show or false == show then
    TooltipSimple_Hide()
    return
  end
  local totalPlayTime = Util.Time.timeFormatting_Minute(Int64toInt32(ToClient_GetCharacterPlayTime()))
  local control, name, desc
  control = PaGlobal_CharInfoBasic_All._ui.stc_SelfTimer
  name = PAGetString(Defines.StringSheet_GAME, "LUA_CONTRACT_TIME_BLACKSPIRIT") .. " " .. totalPlayTime
  if nil == control then
    return
  end
  TooltipSimple_Show(control, name, desc)
end
function HandleEventPadPress_CharInfoBasic_All_ShowTooltip(idx, subIdx)
  if false == PaGlobal_CharInfoBasic_All._isConsole then
    return
  end
  if 6 == idx then
    if false == Panel_Tooltip_SimpleText:GetShow() then
      HandleEventOnOut_CharInfoBasic_All_Fame(true, subIdx)
    else
      TooltipSimple_Hide()
    end
    return
  end
  if nil == PaGlobal_CharInfoBasic_All._consoleTooltip or nil == PaGlobal_CharInfoBasic_All._consoleTooltip[idx] then
    return
  end
  TooltipSimple_Hide()
  local title = PaGlobal_CharInfoBasic_All._consoleTooltip[idx]._title
  local desc = PaGlobal_CharInfoBasic_All._consoleTooltip[idx]._desc
  PaGlobal_CharInfo_All_SetConsoleSimpleTooltip(title, desc)
  PaGlobal_CharInfo_All_SetConsoleDescShow(true)
end
