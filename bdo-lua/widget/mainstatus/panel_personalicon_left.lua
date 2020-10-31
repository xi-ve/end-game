local UI_ANI_ADV = CppEnums.PAUI_ANIM_ADVANCE_TYPE
local UI_PSFT = CppEnums.PAUI_SHOW_FADE_TYPE
local UI_color = Defines.Color
local UI_BUFFTYPE = CppEnums.UserChargeType
Panel_PersonalIcon_Left:SetShow(true, false)
Panel_PersonalIcon_Left:SetIgnore(true)
Panel_PersonalIcon_Left:ActiveMouseEventEffect(false)
local _defaultEventExp = 1000000
local isBlackSpiritEnable = ToClient_IsContentsGroupOpen("1015")
local isRussiaArea = isGameTypeRussia()
local _btn_NewSkill = UI.getChildControl(Panel_PersonalIcon_Left, "Button_NewSkill")
local _txt_NewSkill = UI.getChildControl(Panel_PersonalIcon_Left, "StaticText_Number")
local _txt_NewSkillDesc = UI.getChildControl(Panel_PersonalIcon_Left, "StaticText_NewSkillHelp")
local _pcRoomIcon = UI.getChildControl(Panel_PersonalIcon_Left, "Static_PCRoom")
local _fixedChargeIcon = UI.getChildControl(Panel_PersonalIcon_Left, "Static_FixedCharge")
local _starterPackage = UI.getChildControl(Panel_PersonalIcon_Left, "Static_StarterPackageIcon")
local _premiumPackage = UI.getChildControl(Panel_PersonalIcon_Left, "Static_PremiumPackageIcon")
local _premiumAlert = UI.getChildControl(Panel_PersonalIcon_Left, "StaticText_BubbleAlert")
local _premiumAlertClose = UI.getChildControl(_premiumAlert, "Button_Close")
local _premiumText = UI.getChildControl(Panel_PersonalIcon_Left, "StaticText_NoticePremium")
local _btnCashShop = UI.getChildControl(Panel_PersonalIcon_Left, "Button_IngameCashShop")
local _btnAlertClose = UI.getChildControl(Panel_PersonalIcon_Left, "Button_TextClose")
local _NodeLvBuffIcon = UI.getChildControl(Panel_PersonalIcon_Left, "Static_NodeLvBuffIcon")
local _pearlPackage = UI.getChildControl(Panel_PersonalIcon_Left, "Static_PearlPackageIcon")
local _expEvent = UI.getChildControl(Panel_PersonalIcon_Left, "Static_ExpEvent")
local _dropEvent = UI.getChildControl(Panel_PersonalIcon_Left, "Static_DropEvent")
local _customize = UI.getChildControl(Panel_PersonalIcon_Left, "Static_CustomizeBuff")
local _pearlPallete = UI.getChildControl(Panel_PersonalIcon_Left, "Static_PearlPallete")
local _goldenBell = UI.getChildControl(Panel_PersonalIcon_Left, "Static_GoldenBell")
local _skillReset = UI.getChildControl(Panel_PersonalIcon_Left, "Static_SkillReset")
local _awakenSkillReset = UI.getChildControl(Panel_PersonalIcon_Left, "Static_AwakenSkillReset")
local _blackSpiritTraining = UI.getChildControl(Panel_PersonalIcon_Left, "Static_BlackSpiritTraining")
local _pcRoomUserHomeBuff = UI.getChildControl(Panel_PersonalIcon_Left, "Static_PcRoomBuff")
local _goldPremiumBuff = UI.getChildControl(Panel_PersonalIcon_Left, "Static_GoldPremiumBuff")
local _challengeReward = UI.getChildControl(Panel_PersonalIcon_Left, "Static_Challenge")
local _challengeNumber = UI.getChildControl(_challengeReward, "StaticText_ChallengeNumber")
local _blackSpiritSkillTraining = UI.getChildControl(Panel_PersonalIcon_Left, "Static_BlackSpiritSkillTraining")
local _memoryOfMaetsro = UI.getChildControl(Panel_PersonalIcon_Left, "Static_MaestroMemory")
local _arshaItemDropBuff = UI.getChildControl(Panel_PersonalIcon_Left, "Static_ArchaBuff")
local _gmDebuff = UI.getChildControl(Panel_PersonalIcon_Left, "Static_GMDebuff")
local _russiaKamasilv = UI.getChildControl(Panel_PersonalIcon_Left, "Static_RussiaKamasilv")
local _russiaPack3 = UI.getChildControl(Panel_PersonalIcon_Left, "Static_RussiaPack3")
local _currentNodeLv = 0
local function registEventHandler()
  if false == _ContentsGroup_RenewUI_Skill then
    _btn_NewSkill:addInputEvent("Mouse_LUp", "HandleMLUp_SkillWindow_OpenForLearn()")
  else
    _btn_NewSkill:addInputEvent("Mouse_LUp", "PaGlobalFunc_Skill_Open()")
  end
  _btn_NewSkill:addInputEvent("Mouse_RUp", "Panel_SelfPlayer_EnableSkillCheck_Close()")
  _btn_NewSkill:addInputEvent("Mouse_On", "BuffIcon_ShowSimpleToolTip( true, 0 )")
  _btn_NewSkill:addInputEvent("Mouse_Out", "BuffIcon_ShowSimpleToolTip( false )")
  _pcRoomIcon:addInputEvent("Mouse_On", "BuffIcon_ShowSimpleToolTip( true, 1 )")
  _pcRoomIcon:addInputEvent("Mouse_Out", "BuffIcon_ShowSimpleToolTip( false )")
  _fixedChargeIcon:addInputEvent("Mouse_On", "BuffIcon_ShowSimpleToolTip( true, 11 )")
  _fixedChargeIcon:addInputEvent("Mouse_Out", "BuffIcon_ShowSimpleToolTip( false )")
  _starterPackage:addInputEvent("Mouse_On", "BuffIcon_ShowSimpleToolTip( true, 2)")
  _starterPackage:addInputEvent("Mouse_Out", "BuffIcon_ShowSimpleToolTip( false )")
  _premiumPackage:addInputEvent("Mouse_On", "BuffIcon_ShowSimpleToolTip( true, 3)")
  _premiumPackage:addInputEvent("Mouse_Out", "BuffIcon_ShowSimpleToolTip( false )")
  _NodeLvBuffIcon:addInputEvent("Mouse_On", "BuffIcon_ShowSimpleToolTip( true, 5)")
  _NodeLvBuffIcon:addInputEvent("Mouse_Out", "BuffIcon_ShowSimpleToolTip( false )")
  _pearlPackage:addInputEvent("Mouse_On", "BuffIcon_ShowSimpleToolTip( true, 4)")
  _pearlPackage:addInputEvent("Mouse_Out", "BuffIcon_ShowSimpleToolTip( false )")
  _expEvent:addInputEvent("Mouse_On", "BuffIcon_ShowSimpleToolTip( true, 6 )")
  _expEvent:addInputEvent("Mouse_Out", "BuffIcon_ShowSimpleToolTip( false )")
  _dropEvent:addInputEvent("Mouse_On", "BuffIcon_ShowSimpleToolTip( true, 7 )")
  _dropEvent:addInputEvent("Mouse_Out", "BuffIcon_ShowSimpleToolTip( false )")
  _customize:addInputEvent("Mouse_On", "BuffIcon_ShowSimpleToolTip( true, 8 )")
  _customize:addInputEvent("Mouse_Out", "BuffIcon_ShowSimpleToolTip( false )")
  _pearlPallete:addInputEvent("Mouse_On", "BuffIcon_ShowSimpleToolTip( true, 9 )")
  _pearlPallete:addInputEvent("Mouse_Out", "BuffIcon_ShowSimpleToolTip( false )")
  _goldenBell:addInputEvent("Mouse_On", "BuffIcon_ShowSimpleToolTip( true, 12 )")
  _goldenBell:addInputEvent("Mouse_Out", "BuffIcon_ShowSimpleToolTip( false, 12 )")
  _skillReset:addInputEvent("Mouse_On", "BuffIcon_ShowSimpleToolTip( true, 13 )")
  _skillReset:addInputEvent("Mouse_Out", "BuffIcon_ShowSimpleToolTip( false, 13 )")
  _awakenSkillReset:addInputEvent("Mouse_On", "BuffIcon_ShowSimpleToolTip( true, 14 )")
  _awakenSkillReset:addInputEvent("Mouse_Out", "BuffIcon_ShowSimpleToolTip( false, 14 )")
  _blackSpiritTraining:addInputEvent("Mouse_On", "BuffIcon_ShowSimpleToolTip( true, 16 )")
  _blackSpiritTraining:addInputEvent("Mouse_Out", "BuffIcon_ShowSimpleToolTip( false, 16 )")
  _pcRoomUserHomeBuff:addInputEvent("Mouse_On", "BuffIcon_ShowSimpleToolTip( true, 18 )")
  _pcRoomUserHomeBuff:addInputEvent("Mouse_Out", "BuffIcon_ShowSimpleToolTip( false )")
  _goldPremiumBuff:addInputEvent("Mouse_On", "BuffIcon_ShowSimpleToolTip(true, 19)")
  _goldPremiumBuff:addInputEvent("Mouse_Out", "BuffIcon_ShowSimpleToolTip(false)")
  _challengeReward:addInputEvent("Mouse_On", "BuffIcon_ShowSimpleToolTip(true, 20)")
  _challengeReward:addInputEvent("Mouse_Out", "BuffIcon_ShowSimpleToolTip(false)")
  if false == _ContentsGroup_RemasterUI_Main_Alert then
    _challengeReward:addInputEvent("Mouse_LUp", "_challengeCall_byNewChallengeAlarm()")
  end
  _blackSpiritSkillTraining:addInputEvent("Mouse_On", "BuffIcon_ShowSimpleToolTip( true, 21 )")
  _blackSpiritSkillTraining:addInputEvent("Mouse_Out", "BuffIcon_ShowSimpleToolTip( false, 21 )")
  _memoryOfMaetsro:addInputEvent("Mouse_On", "BuffIcon_ShowSimpleToolTip( true, 22 )")
  _memoryOfMaetsro:addInputEvent("Mouse_Out", "BuffIcon_ShowSimpleToolTip( false, 22 )")
  _arshaItemDropBuff:addInputEvent("Mouse_On", "BuffIcon_ShowSimpleToolTip( true, 23 )")
  _arshaItemDropBuff:addInputEvent("Mouse_Out", "BuffIcon_ShowSimpleToolTip( false, 23 )")
  _gmDebuff:addInputEvent("Mouse_On", "BuffIcon_ShowSimpleToolTip(true, 24)")
  _gmDebuff:addInputEvent("Mouse_Out", "BuffIcon_ShowSimpleToolTip(false, 24)")
  _btnCashShop:addInputEvent("Mouse_LUp", "PearlShop_Open()")
  _btnAlertClose:addInputEvent("Mouse_LUp", "PremiumNotice_Close()")
  _russiaPack3:addInputEvent("Mouse_On", "BuffIcon_ShowSimpleToolTip( true, 15 )")
  _russiaPack3:addInputEvent("Mouse_Out", "BuffIcon_ShowSimpleToolTip( false, 15 )")
  _russiaKamasilv:addInputEvent("Mouse_On", "BuffIcon_ShowSimpleToolTip( true, 10 )")
  _russiaKamasilv:addInputEvent("Mouse_Out", "BuffIcon_ShowSimpleToolTip( false, 10 )")
  _premiumAlertClose:addInputEvent("Mouse_LUp", "_premiumAlert_HideAni()")
end
local _ExpFix
if not _ContentsGroup_RenewUI_Main then
  _ExpFix = UI.getChildControl(Panel_SelfPlayerExpGage, "CheckButton_ExpFix")
  _ExpFix:SetCheck(false)
  _ExpFix:SetShow(false)
end
_btn_NewSkill:ActiveMouseEventEffect(true)
local _buffIconPosX = 0
function PackageIconPosition()
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  local iconPosX = 0
  local iconPosY = 9
  local iconGapX = 5
  local iconBackPosX
  local player = selfPlayer:get()
  local goldenBellTime_s64 = player:getGoldenbellExpirationTime_s64()
  local remainRewardCount = ToClient_GetChallengeRewardInfoCount()
  local tmpTime = convertStringFromDatetime(goldenBellTime_s64)
  local starter = player:getUserChargeTime(UI_BUFFTYPE.eUserChargeType_StarterPackage)
  local premium = player:getUserChargeTime(UI_BUFFTYPE.eUserChargeType_PremiumPackage)
  local pearl = player:getUserChargeTime(UI_BUFFTYPE.eUserChargeType_PearlPackage)
  local customize = player:getUserChargeTime(UI_BUFFTYPE.eUserChargeType_CustomizationPackage)
  local dyeingPackage = player:getUserChargeTime(UI_BUFFTYPE.eUserChargeType_DyeingPackage)
  local russiaKamasilv = player:getUserChargeTime(UI_BUFFTYPE.eUserChargeType_Kamasilve)
  local skillResetTime = player:getUserChargeTime(UI_BUFFTYPE.eUserChargeType_UnlimitedSkillChange)
  local awakenSkillResetTime = player:getUserChargeTime(UI_BUFFTYPE.eUserChargeType_UnlimitedSkillAwakening)
  local russiaPack3Time = player:getUserChargeTime(UI_BUFFTYPE.eUserChargeType_RussiaPack3)
  local blackSpiritTrainingTime = player:getUserChargeTime(UI_BUFFTYPE.eUserChargeType_BlackSpritTraining)
  local pcRoomUserHomeBuff = player:getUserChargeTime(UI_BUFFTYPE.eUserChargeType_PcRoomUserHomeBuff)
  local premiumValueBuff = player:getUserChargeTime(UI_BUFFTYPE.eUserChargeType_PremiumValuePackageBuff)
  local blackSpiritSkillTrainingTime = player:getUserChargeTime(UI_BUFFTYPE.eUserChargeType_BlackSpritSkillTraining)
  local memoryOfMaestroTime = player:getUserChargeTime(UI_BUFFTYPE.eUserChargeType_GetItemDaily)
  local applyStarter = player:isApplyChargeSkill(UI_BUFFTYPE.eUserChargeType_StarterPackage)
  local applyPremium = player:isApplyChargeSkill(UI_BUFFTYPE.eUserChargeType_PremiumPackage)
  local applyPearl = player:isApplyChargeSkill(UI_BUFFTYPE.eUserChargeType_PearlPackage)
  local applyCustomize = player:isApplyChargeSkill(UI_BUFFTYPE.eUserChargeType_CustomizationPackage)
  local applyDyeingPackage = player:isApplyChargeSkill(UI_BUFFTYPE.eUserChargeType_DyeingPackage)
  local applyRussiaKamasilv = player:isApplyChargeSkill(UI_BUFFTYPE.eUserChargeType_Kamasilve)
  local applySkillReset = player:isApplyChargeSkill(UI_BUFFTYPE.eUserChargeType_UnlimitedSkillChange)
  local applyAwakenSkillReset = player:isApplyChargeSkill(UI_BUFFTYPE.eUserChargeType_UnlimitedSkillAwakening)
  local applyRussiaPack3 = player:isApplyChargeSkill(UI_BUFFTYPE.eUserChargeType_RussiaPack3)
  local applyBlackSpiritTraining = player:isApplyChargeSkill(UI_BUFFTYPE.eUserChargeType_BlackSpritTraining)
  local applyPcRoomUserHomeBuff = player:isApplyChargeSkill(UI_BUFFTYPE.eUserChargeType_PcRoomUserHomeBuff)
  local applyPremiumValueBuff = player:isApplyChargeSkill(UI_BUFFTYPE.eUserChargeType_PremiumValuePackageBuff)
  local applyBlackSpiritSkillTraining = player:isApplyChargeSkill(UI_BUFFTYPE.eUserChargeType_BlackSpritSkillTraining)
  local applyMemoryOfMaestro = player:isApplyChargeSkill(UI_BUFFTYPE.eUserChargeType_GetItemDaily)
  local applyArshaBuff = ToClient_isAbleArshaItemDropBuffRate()
  local applyGMDebuff = ToClient_IsCurse()
  if _pcRoomIcon:GetShow() then
    _pcRoomIcon:SetPosX(iconPosX)
    iconPosX = iconPosX + _pcRoomIcon:GetSizeX() + iconGapX
  end
  if _fixedChargeIcon:GetShow() then
    _fixedChargeIcon:SetPosX(iconPosX)
    iconPosX = iconPosX + _fixedChargeIcon:GetSizeX() + iconGapX
  end
  if applyStarter and 0 < starter then
    _starterPackage:SetPosX(iconPosX)
    _starterPackage:SetPosY(iconPosY)
    iconPosX = iconPosX + _starterPackage:GetSizeX() + iconGapX
  end
  if applyPremium and 0 < premium then
    _premiumPackage:SetPosX(iconPosX)
    _premiumPackage:SetPosY(iconPosY)
    iconPosX = iconPosX + _premiumPackage:GetSizeX() + iconGapX
    _premiumText:SetPosX(_premiumPackage:GetPosX())
    _premiumText:SetPosY(_premiumPackage:GetPosY() + _premiumPackage:GetSizeY())
    _btnCashShop:SetPosX(_premiumText:GetPosX() + _premiumText:GetTextSizeX() + 30)
    _btnCashShop:SetPosY(_premiumText:GetPosY() + 30)
    _btnAlertClose:SetPosX(_btnCashShop:GetPosX() + _btnCashShop:GetSizeX())
    _btnAlertClose:SetPosY(_btnCashShop:GetPosY())
  end
  if applyPearl and 0 < pearl then
    _pearlPackage:SetPosX(iconPosX)
    _pearlPackage:SetPosY(iconPosY)
    iconPosX = iconPosX + _pearlPackage:GetSizeX() + iconGapX
  end
  if _btn_NewSkill:GetShow() then
    _btn_NewSkill:SetPosX(iconPosX)
    _btn_NewSkill:SetPosY(iconPosY - 4)
    iconPosX = iconPosX + _btn_NewSkill:GetSizeX() + iconGapX
  end
  if _txt_NewSkill:GetShow() then
    _txt_NewSkill:SetPosX(_btn_NewSkill:GetPosX() + _btn_NewSkill:GetSizeX() - _txt_NewSkill:GetSizeX() + 2)
  end
  if Panel_NormalKnowledge:GetShow() then
    Panel_NormalKnowledge:SetPosX(iconPosX + Panel_SelfPlayerExpGage:GetPosX() + Panel_SelfPlayerExpGage:GetSizeX())
    iconPosX = iconPosX + Panel_NormalKnowledge:GetSizeX() + iconGapX
  end
  if Panel_ImportantKnowledge:GetShow() then
    Panel_ImportantKnowledge:SetPosX(iconPosX + Panel_SelfPlayerExpGage:GetPosX() + Panel_SelfPlayerExpGage:GetSizeX())
    iconPosX = iconPosX + Panel_ImportantKnowledge:GetSizeX() + iconGapX
  end
  if _NodeLvBuffIcon:GetShow() then
    _NodeLvBuffIcon:SetPosX(iconPosX)
    _NodeLvBuffIcon:SetPosY(iconPosY)
    iconPosX = iconPosX + _NodeLvBuffIcon:GetSizeX() + iconGapX
  end
  if _expEvent:GetShow() then
    _expEvent:SetPosX(iconPosX)
    _expEvent:SetPosY(iconPosY)
    iconPosX = iconPosX + _expEvent:GetSizeX() + iconGapX
  end
  if _dropEvent:GetShow() then
    _dropEvent:SetPosX(iconPosX)
    _dropEvent:SetPosY(iconPosY)
    iconPosX = iconPosX + _dropEvent:GetSizeX() + iconGapX
  end
  if applyCustomize then
    _customize:SetPosX(iconPosX)
    _customize:SetPosY(iconPosY)
    iconPosX = iconPosX + _customize:GetSizeX() + iconGapX
  end
  if applyDyeingPackage and 0 < dyeingPackage then
    _pearlPallete:SetPosX(iconPosX)
    _pearlPallete:SetPosY(iconPosY)
    iconPosX = iconPosX + _pearlPallete:GetSizeX() + iconGapX
  end
  if applyRussiaKamasilv and 0 < russiaKamasilv then
    _russiaKamasilv:SetPosX(iconPosX)
    _russiaKamasilv:SetPosY(iconPosY)
    iconPosX = iconPosX + _russiaKamasilv:GetSizeX() + iconGapX
  end
  if goldenBellTime_s64 > toInt64(0, 0) then
    _goldenBell:SetShow(true)
    _goldenBell:SetPosX(iconPosX)
    _goldenBell:SetPosY(iconPosY)
    iconPosX = iconPosX + _goldenBell:GetSizeX() + iconGapX
  else
    _goldenBell:SetShow(false)
  end
  if applySkillReset and 0 < skillResetTime then
    _skillReset:SetPosX(iconPosX)
    _skillReset:SetPosY(iconPosY)
    iconPosX = iconPosX + _skillReset:GetSizeX() + iconGapX
  end
  if applyAwakenSkillReset and 0 < awakenSkillResetTime then
    _awakenSkillReset:SetPosX(iconPosX)
    _awakenSkillReset:SetPosY(iconPosY)
    iconPosX = iconPosX + _awakenSkillReset:GetSizeX() + iconGapX
  end
  if applyRussiaPack3 and 0 < russiaPack3Time then
    _russiaPack3:SetPosX(iconPosX)
    _russiaPack3:SetPosY(iconPosY)
    iconPosX = iconPosX + _russiaPack3:GetSizeX() + iconGapX
  end
  if applyBlackSpiritTraining and 0 < blackSpiritTrainingTime then
    _blackSpiritTraining:SetPosX(iconPosX)
    _blackSpiritTraining:SetPosY(iconPosY)
    iconPosX = iconPosX + _blackSpiritTraining:GetSizeX() + iconGapX
  end
  if applyBlackSpiritSkillTraining and 0 < blackSpiritSkillTrainingTime then
    _blackSpiritSkillTraining:SetPosX(iconPosX)
    _blackSpiritSkillTraining:SetPosY(iconPosY)
    iconPosX = iconPosX + _blackSpiritSkillTraining:GetSizeX() + iconGapX
  end
  if applyMemoryOfMaestro and 0 < memoryOfMaestroTime then
    _memoryOfMaetsro:SetPosX(iconPosX)
    _memoryOfMaetsro:SetPosY(iconPosY)
    iconPosX = iconPosX + _memoryOfMaetsro:GetSizeX() + iconGapX
  end
  if 0 < remainRewardCount then
    _challengeReward:SetPosX(iconPosX)
    _challengeReward:SetPosY(iconPosY)
    iconPosX = iconPosX + _challengeReward:GetSizeX() + iconGapX
  end
  if _pcRoomIcon:GetShow() then
  elseif not applyPcRoomUserHomeBuff or 0 < pcRoomUserHomeBuff then
  end
  if applyPremiumValueBuff and 0 < premiumValueBuff then
    _goldPremiumBuff:SetPosX(iconPosX)
    _goldPremiumBuff:SetPosY(iconPosY)
    iconPosX = iconPosX + _goldPremiumBuff:GetSizeX() + iconGapX
  end
  if applyArshaBuff then
    _arshaItemDropBuff:SetPosX(iconPosX)
    _arshaItemDropBuff:SetPosY(iconPosY)
    iconPosX = iconPosX + _arshaItemDropBuff:GetSizeX() + iconGapX
  end
  if applyGMDebuff then
    _gmDebuff:SetPosX(iconPosX)
    _gmDebuff:SetPosY(iconPosY)
    iconPosX = iconPosX + _gmDebuff:GetSizeX() + iconGapX
  end
  Panel_PersonalIcon_Left:SetPosX(Panel_SelfPlayerExpGage:GetPosX() + Panel_SelfPlayerExpGage:GetSizeX())
  Panel_PersonalIcon_Left:SetPosY(5)
  Panel_PersonalIcon_Left:SetSize(iconPosX, Panel_PersonalIcon_Left:GetSizeY())
  _buffIconPosX = iconPosX
  Panel_PersonalIcon_Left:calculateAlertBox(applyStarter, applyPremium, applyDyeingPackage, starter, premium, dyeingPackage, applyRussiaPack3, russiaPack3Time, applyRussiaKamasilv, russiaKamasilv)
end
local _PremiumPackageToolTipOnce = true
function Panel_PersonalIcon_Left:calculateAlertBox(applyStarter, applyPremium, applyDyeingPackage, starter, premium, dyeingPackage, applyRussiaPack3, russiaPack3Time, applyRussiaKamasilv, russiaKamasilv)
  local CheckToday = ToClient_getGameUIManagerWrapper():getLuaCacheDataListNumber(__eValuePackage)
  if ToClient_GetToday() == CheckToday then
    return
  end
  local applyFlag = {
    applyStarter,
    applyPremium,
    applyDyeingPackage
  }
  local checkTime = {
    starter,
    premium,
    dyeingPackage
  }
  local controls = {
    _starterPackage,
    _premiumPackage,
    _pearlPallete
  }
  local msgKey = {
    "LUA_PERSONALICON_LEFT_STARTER",
    "LUA_PERSONALICON_LEFT_PREMIUM",
    "LUA_PERSONALICON_LEFT_PALLETE"
  }
  if isRussiaArea then
    applyFlag = {
      applyStarter,
      applyPremium,
      applyDyeingPackage,
      applyRussiaPack3,
      applyRussiaKamasilv
    }
    checkTime = {
      starter,
      premium,
      dyeingPackage,
      russiaPack3Time,
      russiaKamasilv
    }
    controls = {
      _starterPackage,
      _premiumPackage,
      _pearlPallete,
      _russiaPack3,
      _russiaKamasilv
    }
    msgKey = {
      "LUA_PERSONALICON_LEFT_PREMIUM1_RUS",
      "LUA_PERSONALICON_LEFT_PREMIUM2_RUS",
      "LUA_PERSONALICON_LEFT_PALLETE",
      "LUA_PERSONALICON_LEFT_PREMIUM3_RUS",
      "LUA_PERSONALICON_LEFT_STARTER"
    }
  else
    msgKey = {
      "LUA_PERSONALICON_LEFT_STARTER",
      "LUA_PERSONALICON_LEFT_PREMIUM",
      "LUA_PERSONALICON_LEFT_PALLETE"
    }
  end
  local msgs = {}
  local posFlag = false
  for k, v in ipairs(applyFlag) do
    if true == v and 0 < checkTime[k] then
      local leftHour = math.ceil(checkTime[k] / 60 / 60)
      if leftHour <= 72 then
        if 24 < leftHour then
          local day = math.floor(leftHour / 24)
          leftHour = leftHour - day * 24
          msgs[k] = PAGetStringParam2(Defines.StringSheet_GAME, msgKey[k] .. 2, "leftDay", day, "leftHour", leftHour)
        else
          msgs[k] = PAGetStringParam1(Defines.StringSheet_GAME, msgKey[k], "leftHour", leftHour)
        end
        if false == posFlag then
          _premiumAlert:SetPosX(controls[k]:GetPosX())
          _premiumAlert:SetPosY(controls[k]:GetPosY() + controls[k]:GetSizeY() + 10)
          posFlag = true
        end
      end
    end
  end
  for k, v in ipairs(controls) do
    controls[k]:EraseAllEffect()
  end
  if true == posFlag and (true == _PremiumPackageToolTipOnce or true == _premiumAlert:GetShow()) then
    if nil ~= msgs then
      local message = "<PAColor0xffe7d583>" .. PAGetString(Defines.StringSheet_GAME, "LUA_PERSONALICON_LEFT_ALERT_TITLE") .. "<PAOldColor>" .. "\n"
      for index, str in pairs(msgs) do
        message = message .. str .. "\n"
        controls[index]:AddEffect("fUI_PremiumPackage_01A", true, 0, 0)
      end
      _premiumAlert:SetText(string.sub(message, 1, string.len(message) - 1))
      _premiumAlert:SetSize(_premiumAlert:GetTextSizeX() + 18, _premiumAlert:GetTextSizeY() + 25)
      _premiumAlert:SetShow(true)
      _premiumAlertClose:ComputePos()
      _PremiumPackageToolTipOnce = false
    end
  else
    _premiumAlert:SetShow(false)
  end
end
local pcRoomNeedTime = ToClient_GetPcRoomUserHomeBuffLimitTime()
local needTime = Int64toInt32(pcRoomNeedTime)
local useTime = 0
function BuffIcon_ShowSimpleToolTip(isShow, iconType)
  if not isShow then
    TooltipSimple_Hide()
    return
  end
  local name, desc, uiControl
  local leftTime = 0
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
  local remainRewardCount = ToClient_GetChallengeRewardInfoCount()
  local starter = player:getUserChargeTime(UI_BUFFTYPE.eUserChargeType_StarterPackage)
  local premium = player:getUserChargeTime(UI_BUFFTYPE.eUserChargeType_PremiumPackage)
  local pearl = player:getUserChargeTime(UI_BUFFTYPE.eUserChargeType_PearlPackage)
  local customize = player:getUserChargeTime(UI_BUFFTYPE.eUserChargeType_CustomizationPackage)
  local dyeingPackage = player:getUserChargeTime(UI_BUFFTYPE.eUserChargeType_DyeingPackage)
  local russiaKamasilv = player:getUserChargeTime(UI_BUFFTYPE.eUserChargeType_Kamasilve)
  local skillResetTime = player:getUserChargeTime(UI_BUFFTYPE.eUserChargeType_UnlimitedSkillChange)
  local awakenSkillResetTime = player:getUserChargeTime(UI_BUFFTYPE.eUserChargeType_UnlimitedSkillAwakening)
  local russiaPack3Time = player:getUserChargeTime(UI_BUFFTYPE.eUserChargeType_RussiaPack3)
  local trainingTime = player:getUserChargeTime(UI_BUFFTYPE.eUserChargeType_BlackSpritTraining)
  local skilltrainingTime = player:getUserChargeTime(UI_BUFFTYPE.eUserChargeType_BlackSpritSkillTraining)
  local pcRoomHomeTime = player:getUserChargeTime(UI_BUFFTYPE.eUserChargeType_PcRoomUserHomeBuff)
  local premiumValueTime = player:getUserChargeTime(UI_BUFFTYPE.eUserChargeType_PremiumValuePackageBuff)
  local memoryOfMaestroTime = player:getUserChargeTime(UI_BUFFTYPE.eUserChargeType_GetItemDaily)
  local expEventPercent = getEventExpPercentByWorldNo(curChannelData._worldNo, curChannelData._serverNo)
  local expEventPercentShow = 0
  if expEventPercent > _defaultEventExp then
    expEventPercentShow = math.floor(expEventPercent / 10000 - 100)
  end
  local expVehiclePercent = lobby_getEventVehicleExpPercentByWorldNo(curChannelData._worldNo, curChannelData._serverNo)
  local expEventVehiclePercentShow = 0
  if expVehiclePercent > _defaultEventExp then
    expEventVehiclePercentShow = math.floor(expVehiclePercent / 10000 - 100)
  end
  local expNodePercent = _currentNodeLv * ToClient_getNodeIncreaseItemDropPercent() / 10000
  if iconType == 0 then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_SELFPLAYEREXPGAGE_NewSkillDesc")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_SELFPLAYEREXPGAGE_NEWSKILLPOINTS_TOOLTIP_DESC")
    uiControl = _btn_NewSkill
  elseif iconType == 1 then
    if isGameTypeEnglish() then
      name = PAGetString(Defines.StringSheet_GAME, "LUA_SELFPLAYEREXPGAGE_PCROOM_TITLE_NA")
      desc = PAGetString(Defines.StringSheet_GAME, "LUA_SELFPLAYEREXPGAGE_PCROOM_DESC_NA")
    elseif isBlackSpiritEnable then
      name = PAGetString(Defines.StringSheet_GAME, "LUA_SELFPLAYEREXPGAGE_PCROOM_TITLE")
      desc = PAGetString(Defines.StringSheet_GAME, "LUA_SELFPLAYEREXPGAGE_PCROOM_DESC")
    else
      name = PAGetString(Defines.StringSheet_GAME, "LUA_SELFPLAYEREXPGAGE_PCROOM_TITLE")
      desc = PAGetString(Defines.StringSheet_GAME, "LUA_SELFPLAYEREXPGAGE_PCROOM_DESC_NONEBLACKSPIRIT")
    end
    uiControl = _pcRoomIcon
  elseif iconType == 2 then
    leftTime = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_SELFPLAYEREXPGAGE_YAZBUFF_TIME", "getStarterPackageTime", convertStringFromDatetime(toInt64(0, starter)))
    if isRussiaArea then
      local s64_dayCycle = toInt64(0, 86400)
      local s64_day = toInt64(0, starter) / s64_dayCycle
      if s64_day < toInt64(0, 3650) then
        name = PAGetString(Defines.StringSheet_GAME, "LUA_SELFPLAYEREXPGAGE_YAZBUFF_TITLE_RUS")
        desc = leftTime .. "\n" .. PAGetString(Defines.StringSheet_GAME, "LUA_SELFPLAYEREXPGAGE_YAZBUFF_DESC")
      else
        name = PAGetString(Defines.StringSheet_GAME, "LUA_SELFPLAYEREXPGAGE_YAZBUFF_TITLE_RUS")
        desc = PAGetString(Defines.StringSheet_GAME, "LUA_SELFPLAYEREXPGAGE_YAZBUFF_DESC")
      end
    else
      name = PAGetString(Defines.StringSheet_GAME, "LUA_SELFPLAYEREXPGAGE_YAZBUFF_TITLE")
      desc = leftTime .. "\n" .. PAGetString(Defines.StringSheet_GAME, "LUA_SELFPLAYEREXPGAGE_YAZBUFF_DESC")
    end
    uiControl = _starterPackage
  elseif iconType == 3 then
    leftTime = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_SELFPLAYEREXPGAGE_AILINBUFF_TIME", "getPremiumPackageTime", convertStringFromDatetime(toInt64(0, premium)))
    if isGameTypeJapan() then
      name = PAGetString(Defines.StringSheet_GAME, "LUA_SELFPLAYEREXPGAGE_EILEENBUFF_TITLE")
      desc = leftTime .. "\n" .. PAGetString(Defines.StringSheet_GAME, "LUA_SELFPLAYEREXPGAGE_EILEENBUFF_DESC_JP")
    elseif isRussiaArea then
      local s64_dayCycle = toInt64(0, 86400)
      local s64_day = toInt64(0, premium) / s64_dayCycle
      if s64_day < toInt64(0, 3650) then
        name = PAGetString(Defines.StringSheet_GAME, "LUA_SELFPLAYEREXPGAGE_EILEENBUFF_TITLE_RUS")
        desc = leftTime .. "\n" .. PAGetString(Defines.StringSheet_GAME, "LUA_SELFPLAYEREXPGAGE_EILEENBUFF_DESC")
      else
        name = PAGetString(Defines.StringSheet_GAME, "LUA_SELFPLAYEREXPGAGE_EILEENBUFF_TITLE_RUS")
        desc = PAGetString(Defines.StringSheet_GAME, "LUA_SELFPLAYEREXPGAGE_EILEENBUFF_DESC")
      end
    elseif isGameTypeTaiwan() then
      name = PAGetString(Defines.StringSheet_GAME, "LUA_SELFPLAYEREXPGAGE_EILEENBUFF_TITLE_TW")
      desc = leftTime .. "\n" .. PAGetString(Defines.StringSheet_GAME, "LUA_SELFPLAYEREXPGAGE_EILEENBUFF_DESC_TW")
    elseif isGameTypeSA() then
      name = PAGetString(Defines.StringSheet_GAME, "LUA_SELFPLAYEREXPGAGE_EILEENBUFF_TITLE_SA")
      desc = leftTime .. "\n" .. PAGetString(Defines.StringSheet_GAME, "LUA_SELFPLAYEREXPGAGE_EILEENBUFF_DESC_SA")
    elseif isGameTypeKR2() then
      name = PAGetString(Defines.StringSheet_GAME, "LUA_SELFPLAYEREXPGAGE_EILEENBUFF_TITLE_KR2")
      desc = leftTime .. "\n" .. PAGetString(Defines.StringSheet_GAME, "LUA_SELFPLAYEREXPGAGE_EILEENBUFF_DESC_KR2")
    elseif isGameTypeTR() then
      name = PAGetString(Defines.StringSheet_GAME, "LUA_SELFPLAYEREXPGAGE_EILEENBUFF_TITLE_TR")
      desc = leftTime .. "\n" .. PAGetString(Defines.StringSheet_GAME, "LUA_SELFPLAYEREXPGAGE_EILEENBUFF_DESC_TR")
    elseif isGameTypeTH() then
      name = PAGetString(Defines.StringSheet_GAME, "LUA_SELFPLAYEREXPGAGE_EILEENBUFF_TITLE_TH")
      desc = leftTime .. "\n" .. PAGetString(Defines.StringSheet_GAME, "LUA_SELFPLAYEREXPGAGE_EILEENBUFF_DESC_TH")
    elseif isGameTypeID() then
      name = PAGetString(Defines.StringSheet_GAME, "LUA_SELFPLAYEREXPGAGE_EILEENBUFF_TITLE_ID")
      desc = leftTime .. "\n" .. PAGetString(Defines.StringSheet_GAME, "LUA_SELFPLAYEREXPGAGE_EILEENBUFF_DESC_ID")
    else
      name = PAGetString(Defines.StringSheet_GAME, "LUA_SELFPLAYEREXPGAGE_EILEENBUFF_TITLE")
      desc = leftTime .. "\n" .. PAGetString(Defines.StringSheet_GAME, "LUA_SELFPLAYEREXPGAGE_EILEENBUFF_DESC")
    end
    uiControl = _premiumPackage
  elseif iconType == 4 then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_SELFPLAYEREXPGAGE_PEARLBUFF_TITLE")
    leftTime = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_SELFPLAYEREXPGAGE_LIGHTPEARLBUFF_TIME", "getPearlPackageTime", convertStringFromDatetime(toInt64(0, pearl)))
    desc = leftTime .. "\n" .. PAGetString(Defines.StringSheet_GAME, "LUA_SELFPLAYEREXPGAGE_PEARLBUFF_DESC")
    uiControl = _pearlPackage
  elseif iconType == 5 and true == localNodeInvestment then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_SELFPLAYEREXPGAGE_NODELVBUFF_TITLE")
    if 0 < expNodePercent then
      desc = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_SELFPLAYEREXPGAGE_NODELVBUFF_DESC_WITH_BUFF", "nodeName", localNodeName, "percent", tostring(expNodePercent))
    else
      desc = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_SELFPLAYEREXPGAGE_NODELVBUFF_DESC", "nodeName", localNodeName)
    end
    uiControl = _NodeLvBuffIcon
  elseif iconType == 5 and false == localNodeInvestment then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_SELFPLAYEREXPGAGE_NODELVBUFF_TITLE")
    desc = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_SELFPLAYEREXPGAGE_NOTNODELVBUFF_DESC", "localNodeName", localNodeName)
    uiControl = _NodeLvBuffIcon
  elseif iconType == 6 then
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
    uiControl = _expEvent
  elseif iconType == 7 then
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
    uiControl = _dropEvent
  elseif iconType == 8 then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_SELFCHARACTER_BUFF_TOOLTIP_NAME")
    desc = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_CASH_CUSTOMIZATION_BUFFTOOLTIP_DESC", "customizationPackageTime", convertStringFromDatetime(toInt64(0, customize)))
    uiControl = _customize
  elseif iconType == 9 then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_SELFPLAYEREXPGAUGE_DYEINGPACKEAGE_TITLE")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_SELFPLAYEREXPGAUGE_DYEINGPACKEAGE_DESC") .. convertStringFromDatetime(toInt64(0, dyeingPackage))
    uiControl = _pearlPallete
  elseif iconType == 10 then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_SELFPLAYEREXPGAGE_YAZBUFF_TITLE")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_SELFPLAYEREXPGAGE_YAZBUFF_DESC") .. "\n" .. convertStringFromDatetime(toInt64(0, russiaKamasilv))
    uiControl = _russiaKamasilv
  elseif iconType == 11 then
  elseif iconType == 12 then
    local curChannelData = getCurrentChannelServerData()
    local channelName = getChannelName(curChannelData._worldNo, curChannelData._serverNo)
    name = PAGetString(Defines.StringSheet_GAME, "LUA_SELFPLAYEREXPGAGE_GOLDENBELL_TOOLTIP_NAME")
    if nil == goldenBellGuildName or "" == goldenBellGuildName or " " == goldenBellGuildName then
      desc = PAGetStringParam3(Defines.StringSheet_GAME, "LUA_SELFPLAYEREXPGAGE_GOLDENBELL_TOOLTIP_DESC_NOGUILD", "channelName", channelName, "name", goldenBellCharacterName, "percent", goldenBellPercentString) .. " <PAColor0xFFF26A6A>" .. goldenBellTime .. "<PAOldColor>"
    else
      desc = PAGetStringParam4(Defines.StringSheet_GAME, "LUA_SELFPLAYEREXPGAGE_GOLDENBELL_TOOLTIP_DESC_GUILD", "channelName", channelName, "guildName", goldenBellGuildName, "name", goldenBellCharacterName, "percent", goldenBellPercentString) .. " <PAColor0xFFF26A6A>" .. goldenBellTime .. "<PAOldColor>"
    end
    uiControl = _goldenBell
  elseif iconType == 13 then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_SELFPLAYEREXPGAGE_SKILLRESET_TOOLTIP_NAME")
    desc = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_SELFPLAYEREXPGAGE_SKILLRESET_TOOLTIP_DESC", "skillResetTime", convertStringFromDatetime(toInt64(0, skillResetTime)))
    uiControl = _skillReset
  elseif iconType == 14 then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_SELFPLAYEREXPGAGE_AWAKENSKILL_TOOLTIP_NAME")
    desc = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_SELFPLAYEREXPGAGE_AWAKENSKILL_TOOLTIP_DESC", "awakenSkillResetTime", convertStringFromDatetime(toInt64(0, awakenSkillResetTime)))
    uiControl = _awakenSkillReset
  elseif iconType == 15 then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_SELFPLAYEREXPGAGE_RUSSIAPACK3_TOOLTIP_NAME")
    desc = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_SELFPLAYEREXPGAGE_RUSSIAPACK3_TOOLTIP_DESC", "russiaPack3Time", convertStringFromDatetime(toInt64(0, russiaPack3Time)))
    uiControl = _russiaPack3
  elseif iconType == 16 then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_SELFPLAYEREXPGAGE_BLACKSPIRITTRAINING_TOOLTIP_NAME")
    desc = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_SELFPLAYEREXPGAGE_BLACKSPIRITTRAINING_TOOLTIP_DESC", "trainingTime", convertStringFromDatetime(toInt64(0, trainingTime)))
    uiControl = _blackSpiritTraining
  elseif iconType == 90 then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_SELFPLAYEREXPGAGE_TOOLTIP_FIXEXP_TITLE")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_SELFPLAYEREXPGAGE_TOOLTIP_FIXEXP_DESC")
    uiControl = _ExpFix
  elseif iconType == 18 then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_SELFPLAYEREXPGAGE_PCROOMUSERHOMEBUFF")
    uiControl = _pcRoomUserHomeBuff
    local temporaryPCRoomWrapper = getTemporaryInformationWrapper()
    local isPremiumPcRoom = temporaryPCRoomWrapper:isPremiumPcRoom()
    if true == isPremiumPcRoom then
      if true == isShow then
        TooltipSimple_PCRoomHomeBuff_Show(uiControl, name, "", false, needTime, useTime)
      else
        TooltipSimple_Hide()
      end
      return
    else
      desc = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_SELFPLAYEREXPGAGE_PCROOMUSERHOMEBUFF_TOOLTIP_DESC", "paPcRoomHomeTime", convertStringFromDatetime(toInt64(0, pcRoomHomeTime)))
    end
  elseif iconType == 19 then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_SELFPLAYEREXPGAGE_PREMIUMVALUE_TITLE")
    desc = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_SELFPLAYEREXPGAGE_PREMIUMVALUE_DESC", "time", convertStringFromDatetime(toInt64(0, premiumValueTime)))
    uiControl = _goldPremiumBuff
  elseif iconType == 20 then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_PERSONALICON_LEFT_CHALLENGEREWARD_TOOLTIP_NAME")
    desc = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_PERSONALICON_LEFT_CHALLENGEREWARD_TOOLTIP_DESC", "count", remainRewardCount)
    uiControl = _challengeReward
  elseif iconType == 21 then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_SELFPLAYEREXPGAGE_BLACKSPIRITSKILLTRAINING_TOOLTIP_NAME")
    desc = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_SELFPLAYEREXPGAGE_BLACKSPIRITSKILLTRAINING_TOOLTIP_DESC", "skilltrainingTime", convertStringFromDatetime(toInt64(0, skilltrainingTime)))
    uiControl = _blackSpiritSkillTraining
  elseif iconType == 22 then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_SELFPLAYEREXPGAUGE_MAESTROTITLE")
    desc = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_SELFPLAYEREXPGAUGE_MAESTRODESC", "time", convertStringFromDatetime(toInt64(0, memoryOfMaestroTime)))
    uiControl = _memoryOfMaetsro
  elseif iconType == 23 then
    local arshaItemDropBuffRate = ToClient_getArshaItemDropBuffRate() / 10000
    name = PAGetString(Defines.StringSheet_GAME, "LUA_ARSHA_ITEMDROPBUFF_NAME")
    desc = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_ARSHA_ITEMDROPBUFF_DESC", "dropRate", arshaItemDropBuffRate)
    uiControl = _arshaItemDropBuff
  elseif iconType == 24 then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_GMDEBUFF_TOOLTIP_TITLE")
    desc = Panel_PersonalIcon_Left:getGM_DebuffDesc()
    uiControl = _gmDebuff
  end
  if true == isShow then
    TooltipSimple_Show(uiControl, name, desc)
  else
    TooltipSimple_Hide()
  end
end
function Panel_PersonalIcon_Left:getGM_DebuffDesc()
  local desc = ""
  for i = __eCurseType_Mute, __eCurseType_Undefined - 1 do
    local curseTime_s64 = ToClient_GetCurseByIndex(i)
    if curseTime_s64 > toInt64(0, 0) then
      if "" ~= desc then
        desc = desc .. "\n"
      end
      local time = PATime(curseTime_s64)
      desc = desc .. PAGetStringParam2(Defines.StringSheet_GAME, "LUA_GMDEBUFF_TOOLTIP_DESC", "hour", time:GetHour(), "minute", time:GetMinute())
    end
  end
  return desc
end
function Panel_SelfPlayer_EnableSkillCheck_Func()
  LUA_SCOPED_PROFILE("Panel_SelfPlayer_EnableSkillCheck_Func")
  if true == _ContentsGroup_RenewUI_Skill then
    _btn_NewSkill:SetShow(false)
    _txt_NewSkill:SetShow(false)
    return
  end
  local isLearnable = SkillWindow_PlayerLearnableSkill()
  local skillCount = FGlobal_EnableSkillReturn()
  local isSkillIconShowCheck = ToClient_getGameUIManagerWrapper():getLuaCacheDataListBool(__eSkillIconCheck)
  if isLearnable and isSkillIconShowCheck then
    _btn_NewSkill:SetShow(true)
    _txt_NewSkill:SetShow(true)
    _txt_NewSkill:SetText(skillCount)
    _txt_NewSkill:SetPosX(_btn_NewSkill:GetPosX() + _btn_NewSkill:GetSizeX() - _txt_NewSkill:GetSizeX() + 2)
    _txt_NewSkill:SetPosY(_btn_NewSkill:GetPosY() + _btn_NewSkill:GetSizeY() - _txt_NewSkill:GetSizeY() + 2)
  else
    _btn_NewSkill:SetShow(false)
    _txt_NewSkill:SetShow(false)
  end
  FromClient_PackageIconUpdate()
  FromClient_ResponseChangeExpAndDropPercent()
  PaGlobal_SkillCombination:update()
end
function Panel_SelfPlayer_EnableSkillCheck_Close()
  ToClient_getGameUIManagerWrapper():setLuaCacheDataListBool(__eSkillIconCheck, false, CppEnums.VariableStorageType.eVariableStorageType_User)
  _btn_NewSkill:SetShow(false)
  _txt_NewSkill:SetShow(false)
  FromClient_PackageIconUpdate()
end
function PaGlobal_SelfPlayer_Expgage()
  _challengeReward:SetShow(false)
end
local valuePackCheck = false
function FromClient_PackageIconUpdate()
  local temporaryPCRoomWrapper = getTemporaryInformationWrapper()
  local isPremiumPcRoom = temporaryPCRoomWrapper:isPremiumPcRoom()
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  local player = selfPlayer:get()
  local starter = player:getUserChargeTime(UI_BUFFTYPE.eUserChargeType_StarterPackage)
  local premium = player:getUserChargeTime(UI_BUFFTYPE.eUserChargeType_PremiumPackage)
  local pearl = player:getUserChargeTime(UI_BUFFTYPE.eUserChargeType_PearlPackage)
  local customize = player:getUserChargeTime(UI_BUFFTYPE.eUserChargeType_CustomizationPackage)
  local dyeingPackage = player:getUserChargeTime(UI_BUFFTYPE.eUserChargeType_DyeingPackage)
  local russiaKamasilv = player:getUserChargeTime(UI_BUFFTYPE.eUserChargeType_Kamasilve)
  local remainRewardCount = ToClient_GetChallengeRewardInfoCount()
  local applyStarter = player:isApplyChargeSkill(UI_BUFFTYPE.eUserChargeType_StarterPackage)
  local applyPremium = player:isApplyChargeSkill(UI_BUFFTYPE.eUserChargeType_PremiumPackage)
  local applyPearl = player:isApplyChargeSkill(UI_BUFFTYPE.eUserChargeType_PearlPackage)
  local applyCustomize = player:isApplyChargeSkill(UI_BUFFTYPE.eUserChargeType_CustomizationPackage)
  local applyDyeingPackage = player:isApplyChargeSkill(UI_BUFFTYPE.eUserChargeType_DyeingPackage)
  local applyRussiaKamasilv = player:isApplyChargeSkill(UI_BUFFTYPE.eUserChargeType_Kamasilve)
  local applySkillReset = player:isApplyChargeSkill(UI_BUFFTYPE.eUserChargeType_UnlimitedSkillChange)
  local applyAwakenSkillReset = player:isApplyChargeSkill(UI_BUFFTYPE.eUserChargeType_UnlimitedSkillAwakening)
  local applyRussiaPack3 = player:isApplyChargeSkill(UI_BUFFTYPE.eUserChargeType_RussiaPack3)
  local blackSpiritTraining = player:isApplyChargeSkill(UI_BUFFTYPE.eUserChargeType_BlackSpritTraining)
  local pcRoomUserHomeBuff = player:isApplyChargeSkill(UI_BUFFTYPE.eUserChargeType_PcRoomUserHomeBuff)
  local premiumValueBuff = player:isApplyChargeSkill(UI_BUFFTYPE.eUserChargeType_PremiumValuePackageBuff)
  local blackSpiritSkillTraining = player:isApplyChargeSkill(UI_BUFFTYPE.eUserChargeType_BlackSpritSkillTraining)
  local memoryOfMaestro = player:isApplyChargeSkill(UI_BUFFTYPE.eUserChargeType_GetItemDaily)
  local applyArshaBuff = ToClient_isAbleArshaItemDropBuffRate()
  local applyGMDebuff = ToClient_IsCurse()
  _pcRoomIcon:SetShow(false)
  _fixedChargeIcon:SetShow(false)
  _starterPackage:SetShow(false)
  _premiumPackage:SetShow(false)
  _pearlPackage:SetShow(false)
  _customize:SetShow(false)
  _pearlPallete:SetShow(false)
  _russiaKamasilv:SetShow(false)
  _skillReset:SetShow(false)
  _awakenSkillReset:SetShow(false)
  _russiaPack3:SetShow(false)
  _goldPremiumBuff:SetShow(false)
  _challengeReward:SetShow(false)
  if true == _ContentsGroup_ForXBoxXR then
    _btn_NewSkill:SetShow(false)
    _NodeLvBuffIcon:SetShow(false)
    return
  end
  if valuePackCheck then
    valuePackCheck = false
    PremiumPackageBuyNotice()
    _premiumText:SetShow(false)
    _btnCashShop:SetShow(false)
    _btnAlertClose:SetShow(false)
  end
  if true == isPremiumPcRoom and not isRussiaArea and not isGameTypeEnglish() and not isGameTypeSA() and not isGameTypeKR2() and not isGameTypeTR() then
    _pcRoomIcon:SetShow(true)
  end
  if applyStarter then
    if 0 < starter then
      _starterPackage:SetShow(true)
    else
      _starterPackage:SetShow(false)
    end
  end
  if applyPremium then
    if 0 < premium then
      _premiumPackage:SetShow(true)
      valuePackCheck = true
    else
      _premiumPackage:SetShow(false)
      valuePackCheck = false
    end
  end
  if applyPearl then
    _pearlPackage:SetShow(true)
  end
  if applyCustomize then
    _customize:SetShow(true)
  end
  if applyDyeingPackage then
    _pearlPallete:SetShow(true)
  else
    _pearlPallete:SetShow(false)
  end
  if applyRussiaKamasilv then
    _russiaKamasilv:SetShow(true)
  end
  if applySkillReset then
    _skillReset:SetShow(true)
  else
    _skillReset:SetShow(false)
  end
  if applyAwakenSkillReset then
    _awakenSkillReset:SetShow(true)
  else
    _awakenSkillReset:SetShow(false)
  end
  if applyRussiaPack3 then
    _russiaPack3:SetShow(true)
  else
    _russiaPack3:SetShow(false)
  end
  if blackSpiritTraining then
    _blackSpiritTraining:SetShow(true)
  else
    _blackSpiritTraining:SetShow(false)
  end
  if blackSpiritSkillTraining then
    _blackSpiritSkillTraining:SetShow(true)
  else
    _blackSpiritSkillTraining:SetShow(false)
  end
  if memoryOfMaestro then
    _memoryOfMaetsro:SetShow(true)
  else
    _memoryOfMaetsro:SetShow(false)
  end
  if isPremiumPcRoom then
    _pcRoomUserHomeBuff:SetShow(false)
  elseif pcRoomUserHomeBuff then
    _pcRoomUserHomeBuff:SetShow(false)
  else
    _pcRoomUserHomeBuff:SetShow(false)
  end
  if premiumValueBuff then
    _goldPremiumBuff:SetShow(true)
  else
    _goldPremiumBuff:SetShow(false)
  end
  if 0 < remainRewardCount then
    if false == _ContentsGroup_RenewUI_Main then
      _challengeReward:SetShow(true)
    else
      _challengeReward:SetShow(false)
    end
    _challengeNumber:SetText(remainRewardCount)
  else
    _challengeReward:SetShow(false)
  end
  if applyArshaBuff then
    _arshaItemDropBuff:SetShow(true)
  else
    _arshaItemDropBuff:SetShow(false)
  end
  _gmDebuff:SetShow(applyGMDebuff)
  if false == _ContentsGroup_RemasterUI_Main_RightTop then
    FGlobal_PersonalIcon_ButtonPosUpdate()
  else
    FromClient_Widget_FunctionButton_Resize()
  end
  PackageIconPosition()
end
function FromClient_ResponseChangeExpAndDropPercent()
  local curChannelData = getCurrentChannelServerData()
  local expEventShow = IsWorldServerEventTypeByWorldNo(curChannelData._worldNo, curChannelData._serverNo, 0)
  local dropEventShow = IsWorldServerEventTypeByWorldNo(curChannelData._worldNo, curChannelData._serverNo, 1)
  local expEventPercent = getEventExpPercentByWorldNo(curChannelData._worldNo, curChannelData._serverNo)
  local expEventVehicle = lobby_getEventVehicleExpPercentByWorldNo(curChannelData._worldNo, curChannelData._serverNo)
  if expEventShow then
    _expEvent:SetShow(true)
  else
    _expEvent:SetShow(false)
  end
  if true == _ContentsGroup_RenewUI_Main then
    _expEvent:SetShow(false)
  end
  if dropEventShow then
    _dropEvent:SetShow(true)
  else
    _dropEvent:SetShow(false)
  end
  PackageIconPosition()
end
function _premiumAlert_HideAni()
  _starterPackage:EraseAllEffect()
  _premiumPackage:EraseAllEffect()
  _pearlPallete:EraseAllEffect()
  _russiaPack3:EraseAllEffect()
  _russiaKamasilv:EraseAllEffect()
  ToClient_getGameUIManagerWrapper():setLuaCacheDataListNumber(__eValuePackage, ToClient_GetToday(), CppEnums.VariableStorageType.eVariableStorageType_User)
  _premiumAlert:SetShow(false)
end
function _premiumAlert_ShowAni(control, showTime)
  control:SetShow(true)
  local closeAni = control:addColorAnimation(showTime, showTime + 0.55, UI_ANI_ADV.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
  closeAni:SetStartColor(UI_color.C_FFFFFFFF)
  closeAni:SetEndColor(UI_color.C_00FFFFFF)
  closeAni:SetStartIntensity(3)
  closeAni:SetEndIntensity(1)
  closeAni.IsChangeChild = true
  closeAni:SetHideAtEnd(true)
  closeAni:SetDisableWhileAni(true)
end
function PremiumPackageBuyNotice()
  if _premiumText:GetShow() then
    return
  end
  local msg = PAGetString(Defines.StringSheet_GAME, "LUA_SELFPLAYEREXPGAGE_BUFFTIME_BUYINCASH_MSG")
  _premiumText:SetText(msg)
  _premiumText:SetShow(true)
  _btnCashShop:SetShow(true)
  _btnAlertClose:SetShow(true)
end
function PearlShop_Open()
  PremiumNotice_Close()
  InGameShop_Open()
end
function PremiumNotice_Close()
  _premiumText:SetShow(false)
  _btnCashShop:SetShow(false)
  _btnAlertClose:SetShow(false)
end
function CharacterExpFix()
  if getSelfPlayer():get():getLevel() < 11 then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_SELFPLAYEREXPGAGE_NOTYETUSE"))
    _ExpFix:SetCheck(false)
    return
  end
  ToClient_SetAddedExperience(not _ExpFix:IsCheck())
end
local saveWayPoint
function eventChangedExplorationNode(wayPointKey)
  local nodeLv = ToClient_GetNodeLevel(wayPointKey)
  local nodeName = ToClient_GetNodeNameByWaypointKey(wayPointKey)
  local nodeExp = ToClient_GetNodeExperience_s64(wayPointKey)
  localNodeName = nodeName
  saveWayPoint = wayPointKey
  if 0 < nodeLv and nodeExp >= toInt64(0, 0) then
    _NodeLvBuffIcon:SetShow(true)
    _NodeLvBuffIcon:ChangeTextureInfoNameAsync("Icon/New_Icon/04_PC_Skill/03_Buff/Node_ItemDropRateUP.dds")
    local x1, y1, x2, y2 = setTextureUV_Func(_NodeLvBuffIcon, 1, 1, 32, 32)
    _NodeLvBuffIcon:getBaseTexture():setUV(x1, y1, x2, y2)
    _NodeLvBuffIcon:setRenderTexture(_NodeLvBuffIcon:getBaseTexture())
    PackageIconPosition()
    localNodeInvestment = true
    _currentNodeLv = nodeLv
  else
    _NodeLvBuffIcon:SetShow(true)
    _NodeLvBuffIcon:ChangeTextureInfoNameAsync("Icon/New_Icon/04_PC_Skill/03_Buff/Non_ItemDropRateUP.dds")
    local x1, y1, x2, y2 = setTextureUV_Func(_NodeLvBuffIcon, 1, 1, 32, 32)
    _NodeLvBuffIcon:getBaseTexture():setUV(x1, y1, x2, y2)
    _NodeLvBuffIcon:setRenderTexture(_NodeLvBuffIcon:getBaseTexture())
    PackageIconPosition()
    localNodeInvestment = false
    _currentNodeLv = 0
  end
  if true == _ContentsGroup_RenewUI_Main then
    _NodeLvBuffIcon:SetShow(false)
  end
end
function FGlobal_NodeLvBuffIcon_SetShow(isShow)
  _NodeLvBuffIcon:SetShow(isShow)
  if false == _ContentsGroup_ForXBoxXR then
    _NodeLvBuffIcon:SetShow(false)
  end
end
function eventChangedExplorationNodeCheck(wayPointKey)
  eventChangedExplorationNode(wayPointKey)
end
function eventChangeExplorationNode(wayPointKey)
  if saveWayPoint == wayPointKey then
    eventChangedExplorationNode(wayPointKey)
  end
end
function FromClient_ResponseGoldenbellItemInfo(goldenbellPercent, goldenbellExpirationTime_s64, goldenbellOwnerCharacterName, goldenbellOwnerGuildName)
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  _goldenBell:SetShow(false)
  if goldenbellExpirationTime_s64 <= toInt64(0, 0) then
    _goldenBell:SetShow(false)
    PackageIconPosition()
    return
  else
    _goldenBell:SetShow(true)
  end
  local curChannelData = getCurrentChannelServerData()
  local channelName = getChannelName(curChannelData._worldNo, curChannelData._serverNo)
  local goldenBellPercentString = tostring(math.floor(goldenbellPercent / 10000))
  local msg = {
    main = "",
    sub = "",
    addMsg = ""
  }
  if "" == goldenbellOwnerGuildName then
    msg = {
      main = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_SELFPLAYEREXPGAGE_GOLDENBELL_NAK_MAIN_NOGUILD", "name", goldenbellOwnerCharacterName),
      sub = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_SELFPLAYEREXPGAGE_GOLDENBELL_NAK_SUB_NOGUILD", "channelName", channelName, "percent", goldenBellPercentString),
      addMsg = ""
    }
  else
    msg = {
      main = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_SELFPLAYEREXPGAGE_GOLDENBELL_NAK_MAIN_GUILD", "guildName", goldenbellOwnerGuildName, "name", goldenbellOwnerCharacterName),
      sub = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_SELFPLAYEREXPGAGE_GOLDENBELL_NAK_MAIN_SUB", "channelName", channelName, "percent", goldenBellPercentString),
      addMsg = ""
    }
  end
  Proc_ShowMessage_Ack_For_RewardSelect(msg, 10, 54)
  PackageIconPosition()
end
function FGlobal_PackageIconUpdate()
  FromClient_PackageIconUpdate()
  FromClient_ResponseChangeExpAndDropPercent()
end
function PCRomm_UpdateTime()
  if needTime < useTime then
    return
  end
  local temporaryPCRoomWrapper = getTemporaryInformationWrapper()
  local isPremiumPcRoom = temporaryPCRoomWrapper:isPremiumPcRoom()
  if not isPremiumPcRoom then
    return
  end
  local pcRoomUseTime = ToClient_GetPcRoomPlayTime()
  useTime = Int64toInt32(pcRoomUseTime)
end
local registMessageHandler = function()
  registerEvent("FromClient_SelfPlayerCombatSkillPointChanged", "UserSkillPoint_Update")
  registerEvent("FromClient_SelfPlayerCombatSkillPointChanged", "Panel_SelfPlayer_EnableSkillCheck_Func")
  registerEvent("FromClient_EnableSkillCheck", "Panel_SelfPlayer_EnableSkillCheck_Func")
  registerEvent("FromClient_UpdateCharge", "FromClient_PackageIconUpdate")
  registerEvent("FromClient_LoadCompleteMsg", "FromClient_PackageIconUpdate")
  registerEvent("FromClient_ResponseGoldenbellItemInfo", "FromClient_ResponseGoldenbellItemInfo")
  registerEvent("FromClient_ResponseChangeExpAndDropPercent", "FromClient_ResponseChangeExpAndDropPercent")
  registerEvent("FromClint_EventChangedExplorationNode", "eventChangedExplorationNodeCheck")
  registerEvent("FromClint_EventUpdateExplorationNode", "eventChangeExplorationNode")
end
registEventHandler()
registMessageHandler()
Panel_PersonalIcon_Left:RegisterUpdateFunc("PCRomm_UpdateTime")
