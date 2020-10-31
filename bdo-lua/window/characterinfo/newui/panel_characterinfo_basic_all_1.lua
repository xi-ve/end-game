function PaGlobal_CharInfoBasic_All:initialize()
  if true == self._initialize then
    return
  end
  self._ui.photoBg = UI.getChildControl(Panel_CharacterInfoBasic_All, "Static_CharacterPhoto")
  self._ui.stc_CharPhoto = UI.getChildControl(self._ui.photoBg, "Static_CharPhoto")
  self._ui.btn_FacePhoto = UI.getChildControl(self._ui.photoBg, "Button_FacePhoto_PCUI")
  self._ui.stc_EnchantStackIcon = UI.getChildControl(self._ui.photoBg, "Static_EnchantStackIcon")
  self._ui.txt_EnchantStackIcon_Value = UI.getChildControl(self._ui.stc_EnchantStackIcon, "Static_EnchantStackValue")
  self._ui.txt_FamilyName = UI.getChildControl(self._ui.photoBg, "StaticText_FamilyName")
  self._ui.txt_PlayerName = UI.getChildControl(self._ui.photoBg, "StaticText_PlayerName_Value")
  self._ui.txt_PlayerLv = UI.getChildControl(self._ui.photoBg, "StaticText_PlayerLevel_Value")
  self._ui.stc_IntroduceBg = UI.getChildControl(Panel_CharacterInfoBasic_All, "Static_IntroduceBg")
  self._ui.stc_EditBoxIcon = UI.getChildControl(self._ui.stc_IntroduceBg, "Static_EditBoxIcon")
  self._ui.edit_multiEdit = UI.getChildControl(self._ui.stc_IntroduceBg, "MultilineEdit_IntroduceLine")
  self._ui.stc_KeyGuide_X = UI.getChildControl(self._ui.stc_IntroduceBg, "StaticText_X_ConsoleUI")
  self._ui.txt_HpTitle = UI.getChildControl(self._ui.photoBg, "StaticText_Health")
  self._ui.txt_HpVal = UI.getChildControl(self._ui.photoBg, "StaticText_Health_Val")
  self._ui.txt_MpTitle = UI.getChildControl(self._ui.photoBg, "StaticText_Mental")
  self._ui.txt_Mp_Val = UI.getChildControl(self._ui.photoBg, "StaticText_Mental_Val")
  self._ui.txt_LTTitle = UI.getChildControl(self._ui.photoBg, "StaticText_Weight")
  self._ui.txt_LTVal = UI.getChildControl(self._ui.photoBg, "StaticText_Weight_Val")
  self._ui.txt_SelfTimer = UI.getChildControl(self._ui.photoBg, "StaticText_SelfTimer")
  self._ui.stc_SelfTimer = UI.getChildControl(self._ui.photoBg, "Icon_SelfTimer")
  self._ui.txt_HpTitle:SetTextMode(__eTextMode_AutoWrap)
  self._ui.txt_HpTitle:SetText(self._ui.txt_HpTitle:GetText())
  self._ui.txt_MpTitle:SetTextMode(__eTextMode_AutoWrap)
  self._ui.txt_MpTitle:SetText(self._ui.txt_MpTitle:GetText())
  self._ui.txt_LTTitle:SetTextMode(__eTextMode_AutoWrap)
  self._ui.txt_LTTitle:SetText(self._ui.txt_LTTitle:GetText())
  local fameBg = UI.getChildControl(Panel_CharacterInfoBasic_All, "Static_FameBg")
  self._ui.txt_BattlePointTitle = UI.getChildControl(fameBg, "StaticText_Battle_Point")
  self._ui.txt_BattlePoint = UI.getChildControl(self._ui.txt_BattlePointTitle, "StaticText_Battle_Point_Val")
  self._ui.txt_LifePointTitle = UI.getChildControl(fameBg, "StaticText_Life_Point")
  self._ui.txt_LifePoint = UI.getChildControl(self._ui.txt_LifePointTitle, "StaticText_Life_Point_Val")
  self._ui.txt_SpecialPointTitle = UI.getChildControl(fameBg, "StaticText_Special_Point")
  self._ui.txt_SpecialPoint = UI.getChildControl(self._ui.txt_SpecialPointTitle, "StaticText_Special_Point_Val")
  self._ui.txt_FamilyPointTitle = UI.getChildControl(fameBg, "StaticText_Fam_Point")
  self._ui.txt_FamilyPoint = UI.getChildControl(self._ui.txt_FamilyPointTitle, "StaticText_Fam_Point_Val")
  self._ui.statBg = UI.getChildControl(Panel_CharacterInfoBasic_All, "Static_StatBg")
  self._ui.txt_Tendency = UI.getChildControl(self._ui.statBg, "StaticText_Style")
  self._ui.txt_Wp = UI.getChildControl(self._ui.statBg, "StaticText_Energy")
  self._ui.txt_Contribute = UI.getChildControl(self._ui.statBg, "StaticText_Contrib")
  self._ui.txt_SkillPoint = UI.getChildControl(self._ui.statBg, "StaticText_Skill_Point_Val")
  self._ui.txt_Star = UI.getChildControl(self._ui.statBg, "StaticText_Star")
  self._ui.txt_EnchantCount = UI.getChildControl(self._ui.statBg, "StaticText_Count_Val_ConsoleUI")
  self._ui.stc_Tendency = UI.getChildControl(self._ui.statBg, "StaticText_StyleTitle")
  self._ui.stc_Wp = UI.getChildControl(self._ui.statBg, "StaticText_EnergyTitle")
  self._ui.stc_Contribute = UI.getChildControl(self._ui.statBg, "StaticText_ContTitle")
  self._ui.stc_SkillPoint = UI.getChildControl(self._ui.statBg, "StaticText_Skill_Point_Title")
  self._ui.stc_Star = UI.getChildControl(self._ui.statBg, "StaticText_StarTitle")
  self._ui.stc_EnchantCount = UI.getChildControl(self._ui.statBg, "StaticText_Count_ConsoleUI")
  self._statusTable = Array.new()
  self._statusTable:push_back(self._ui.txt_Tendency)
  self._statusTable:push_back(self._ui.txt_Wp)
  self._statusTable:push_back(self._ui.txt_Contribute)
  self._statusTable:push_back(self._ui.txt_SkillPoint)
  self._statusTable:push_back(self._ui.txt_Star)
  self._ui.txt_MusicGradeTitle = UI.getChildControl(self._ui.statBg, "StaticText_MusicGradeTitle")
  self._ui.txt_MusicGradeValue = UI.getChildControl(self._ui.statBg, "StaticText_MusicGradeValue")
  if true == _ContentsGroup_InstrumentPerformance then
    self._ui.txt_MusicGradeValue:SetShow(true)
    self._ui.txt_MusicGradeTitle:SetShow(true)
  else
    self._ui.txt_MusicGradeValue:SetShow(false)
    self._ui.txt_MusicGradeTitle:SetShow(false)
  end
  self._ui.stc_RightBg = UI.getChildControl(Panel_CharacterInfoBasic_All, "Static_RightBG")
  self._ui.stc_RightTapBg = UI.getChildControl(self._ui.stc_RightBg, "Static_RightTap")
  self._ui.stc_KeyGuide_LT = UI.getChildControl(self._ui.stc_RightTapBg, "StaticText_LT_ConcoleUI")
  self._ui.stc_KeyGuide_RT = UI.getChildControl(self._ui.stc_RightTapBg, "StaticText_RT_ConcoleUI")
  self._ui.rdo_BattleInfo = UI.getChildControl(self._ui.stc_RightTapBg, "RadioButton_BattleInfo")
  self._ui.rdo_LifeInfo = UI.getChildControl(self._ui.stc_RightTapBg, "RadioButton_LifeInfo")
  self._ui.stc_TabSelectBar = UI.getChildControl(self._ui.stc_RightTapBg, "Static_SelectBar")
  self._ui.stc_RightInfoBg = UI.getChildControl(Panel_CharacterInfoBasic_All, "Static_RightInfoBg")
  self._ui.stc_BattleInfoBg = UI.getChildControl(self._ui.stc_RightInfoBg, "Static_BattleInfoBg")
  self._ui.stc_FitnessBg = UI.getChildControl(self._ui.stc_BattleInfoBg, "Static_FitnessBg")
  self._ui.txt_Breath = UI.getChildControl(self._ui.stc_FitnessBg, "StaticText_Breath")
  self._ui.txt_BreathLv = UI.getChildControl(self._ui.stc_FitnessBg, "StaticText_Breath_level")
  self._ui.prog_Breath = UI.getChildControl(self._ui.stc_FitnessBg, "Progress2_Breath")
  self._ui.txt_Power = UI.getChildControl(self._ui.stc_FitnessBg, "StaticText_Power")
  self._ui.txt_PowerLv = UI.getChildControl(self._ui.stc_FitnessBg, "StaticText_Power_level")
  self._ui.prog_Power = UI.getChildControl(self._ui.stc_FitnessBg, "Progress2_Power")
  self._ui.txt_Health = UI.getChildControl(self._ui.stc_FitnessBg, "StaticText_Health")
  self._ui.txt_HealthLv = UI.getChildControl(self._ui.stc_FitnessBg, "StaticText_Health_level")
  self._ui.prog_Health = UI.getChildControl(self._ui.stc_FitnessBg, "Progress2_Health")
  self._ui.stc_PotenBg = UI.getChildControl(self._ui.stc_BattleInfoBg, "Static_PotentialBg")
  self._ui.txt_AtkSpd = UI.getChildControl(self._ui.stc_PotenBg, "StaticText_Atk_Speed")
  self._ui.txt_AtkLv = UI.getChildControl(self._ui.stc_PotenBg, "StaticText_Atk_Speed_Level")
  self._ui.txt_MoveSpd = UI.getChildControl(self._ui.stc_PotenBg, "StaticText_Move_Speed")
  self._ui.txt_MoveLv = UI.getChildControl(self._ui.stc_PotenBg, "StaticText_Move_Speed_Level")
  self._ui.txt_Critical = UI.getChildControl(self._ui.stc_PotenBg, "StaticText_Cri")
  self._ui.txt_CriticalLv = UI.getChildControl(self._ui.stc_PotenBg, "StaticText_Cri_Level")
  self._ui.txt_Fish = UI.getChildControl(self._ui.stc_PotenBg, "StaticText_Fish")
  self._ui.txt_FishLv = UI.getChildControl(self._ui.stc_PotenBg, "StaticText_Fish_Level")
  self._ui.txt_Gather = UI.getChildControl(self._ui.stc_PotenBg, "StaticText_Gather")
  self._ui.txt_GatherLv = UI.getChildControl(self._ui.stc_PotenBg, "StaticText_Gather_Level")
  self._ui.txt_Luck = UI.getChildControl(self._ui.stc_PotenBg, "StaticText_Luck")
  self._ui.txt_LuckLv = UI.getChildControl(self._ui.stc_PotenBg, "StaticText_Luck_Level")
  self._ui.stc_CombatBg = UI.getChildControl(self._ui.stc_BattleInfoBg, "Static_BattleBg")
  self._ui.txt_AtkTitle = UI.getChildControl(self._ui.stc_CombatBg, "StaticText_Atk")
  self._ui.txt_AwakenTitle = UI.getChildControl(self._ui.stc_CombatBg, "StaticText_Atk_Awaken")
  self._ui.txt_DefTitle = UI.getChildControl(self._ui.stc_CombatBg, "StaticText_Def")
  self._ui.txt_StaminaTitle = UI.getChildControl(self._ui.stc_CombatBg, "StaticText_Stamina")
  self._ui.txt_StunRegistTitle = UI.getChildControl(self._ui.stc_CombatBg, "StaticText_Stun_Reg")
  self._ui.txt_GrabRegistTitle = UI.getChildControl(self._ui.stc_CombatBg, "StaticText_Grab_Reg")
  self._ui.txt_DownRegistTitle = UI.getChildControl(self._ui.stc_CombatBg, "StaticText_Down_Reg")
  self._ui.txt_AirRegistTitle = UI.getChildControl(self._ui.stc_CombatBg, "StaticText_Air_Reg")
  self._ui.txt_Atk = UI.getChildControl(self._ui.stc_CombatBg, "StaticText_Atk_Val")
  self._ui.txt_AwakenAtk = UI.getChildControl(self._ui.stc_CombatBg, "StaticText_Atk_Awaken_Val")
  self._ui.txt_Def = UI.getChildControl(self._ui.stc_CombatBg, "StaticText_Def_Val")
  self._ui.txt_Stamina = UI.getChildControl(self._ui.stc_CombatBg, "StaticText_Stamina_Val")
  self._ui.txt_StunRegist = UI.getChildControl(self._ui.stc_CombatBg, "StaticText_Stun_Reg_Val")
  self._ui.txt_GrabRegist = UI.getChildControl(self._ui.stc_CombatBg, "StaticText_Grab_Reg_Val")
  self._ui.txt_DownRegist = UI.getChildControl(self._ui.stc_CombatBg, "StaticText_Down_Reg_Val")
  self._ui.txt_AirRegist = UI.getChildControl(self._ui.stc_CombatBg, "StaticText_Air_Reg_Val")
  self._ui.stc_LifeBg = UI.getChildControl(self._ui.stc_RightInfoBg, "Static_LifeBg")
  for idx = 1, self._LIFEINFOCOUNT do
    local lifeBg = UI.getChildControl(self._ui.stc_LifeBg, "Static_Craft_" .. tostring(idx))
    local uiControl = {
      bg = nil,
      prog2 = nil,
      lv = 0,
      rate = 0,
      expVal = 0
    }
    uiControl.bg = UI.getChildControl(lifeBg, "Static_SLotBG")
    uiControl.rate = UI.getChildControl(lifeBg, "StaticText_Percent")
    uiControl.prog2 = UI.getChildControl(lifeBg, "Progress2_Gauge")
    uiControl.lv = UI.getChildControl(lifeBg, "StaticText_Level")
    uiControl.isShow = true
    uiControl.lifeBg = lifeBg
    if idx == 11 then
      local title = UI.getChildControl(lifeBg, "StaticText_Title")
      if false == _ContentsGroup_Barter then
        uiControl.bg:SetShow(false)
        uiControl.rate:SetShow(false)
        uiControl.prog2:SetShow(false)
        uiControl.lv:SetShow(false)
        title:SetShow(false)
        uiControl.isShow = false
      else
        title:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_SELFCHARACTERINFO_BARTER"))
      end
    end
    if idx == 3 and false == _ContentsGroup_Hunt then
      uiControl.isShow = false
    end
    if idx == 10 and false == _ContentsGroup_Sail then
      uiControl.isShow = false
    end
    if false == uiControl.isShow then
      lifeBg:SetShow(false)
    end
    self._ui.stc_LifeTable[idx] = uiControl
  end
  self._ui.btn_ShowDetail = UI.getChildControl(self._ui.stc_LifeBg, "Button_ShowDetail")
  self._ui.btn_LifeRanking = UI.getChildControl(self._ui.stc_LifeBg, "Button_Ranking")
  self._ui.stc_KeyGuide_Bg = UI.getChildControl(Panel_CharacterInfoBasic_All, "Static_KeyGuideBg_Console")
  self._ui.stc_KeyGuide_B = UI.getChildControl(self._ui.stc_KeyGuide_Bg, "StaticText_B_ConsoleUI")
  self._ui.stc_KeyGuide_Y = UI.getChildControl(self._ui.stc_KeyGuide_Bg, "StaticText_Y_ConsoleUI")
  self._ui.stc_KeyGuide_X = UI.getChildControl(self._ui.stc_KeyGuide_Bg, "StaticText_X_ConsoleUI")
  self._ui.txt_Health:SetTextMode(__eTextMode_LimitText)
  self._ui.txt_Health:SetText(self._ui.txt_Health:GetText())
  PaGlobal_CharInfoBasic_All:SetEnableAreaByTextSize(self._ui.txt_Tendency)
  PaGlobal_CharInfoBasic_All:SetEnableAreaByTextSize(self._ui.txt_Wp)
  PaGlobal_CharInfoBasic_All:SetEnableAreaByTextSize(self._ui.txt_Contribute)
  PaGlobal_CharInfoBasic_All:SetEnableAreaByTextSize(self._ui.txt_SkillPoint)
  PaGlobal_CharInfoBasic_All:SetEnableAreaByTextSize(self._ui.stc_EnchantCount)
  PaGlobal_CharInfoBasic_All:SetEnableAreaByTextSize(self._ui.txt_MusicGradeValue)
  self._isConsole = _ContentsGroup_UsePadSnapping
  self._selfPlayer = getSelfPlayer()
  UI.ASSERT_NAME(nil ~= self._selfPlayer, " Panel_CharacterInfoBasic_All_1.lua / getSelfPlayer() is nil", "\234\185\128\234\183\188\236\154\176")
  if nil == self._selfPlayer then
    return
  end
  local classType = self._selfPlayer:getClassType()
  self._isAwakenWeaponContentsOpen = PaGlobalFunc_Util_GetIsAwakenWeaponContentsOpen(classType)
  ToClient_RequestCharacterEnchantFailCount()
  PaGlobal_CharInfoBasic_All:validate()
  PaGlobal_CharInfoBasic_All:switchPlatForm(self._isConsole)
  PaGlobal_CharInfoBasic_All:registEventHandler(self._isConsole)
  PaGlobal_CharInfoBasic_All:setUnChangedData()
  PaGlobal_CharInfoBasic_All:setMenuPosition()
  PaGlobal_CharInfoBasic_All._initialize = true
end
function PaGlobal_CharInfoBasic_All:setMenuPosition()
  local defaultPosY = self._ui.stc_LifeTable[1].lifeBg:GetPosY()
  local defaultSizeY = self._ui.stc_LifeTable[1].lifeBg:GetSizeY()
  local curIdx = 0
  for index = 1, self._LIFEINFOCOUNT do
    if self._ui.stc_LifeTable[index].isShow then
      self._ui.stc_LifeTable[index].lifeBg:SetPosY(defaultPosY + (defaultSizeY + 5) * curIdx)
      curIdx = curIdx + 1
    end
  end
end
function PaGlobal_CharInfoBasic_All:switchPlatForm(console)
  self._ui.stc_KeyGuide_Bg:SetShow(console)
  self._ui.stc_KeyGuide_LT:SetShow(console)
  self._ui.stc_KeyGuide_RT:SetShow(console)
  self._ui.stc_KeyGuide_X:SetShow(console)
  self._ui.stc_KeyGuide_Y:SetShow(_ContentsGroup_Console_AccountLinking)
  self._ui.btn_ShowDetail:SetShow(_ContentsGroup_EnhanceCollect)
  if false == self._ui.btn_ShowDetail:GetShow() and self._ui.btn_LifeRanking:GetShow() then
    self._ui.btn_LifeRanking:SetSize(self._ui.stc_LifeTable[1].lifeBg:GetSizeX(), self._ui.btn_LifeRanking:GetSizeY())
    self._ui.btn_LifeRanking:SetPosX(self._ui.stc_LifeTable[1].lifeBg:GetPosX())
  end
  self._ui.stc_EditBoxIcon:SetShow(not console)
  self._ui.btn_FacePhoto:SetShow(not console)
  if true == console then
    local iconInfo = self._iconInfo.skill
    self._ui.stc_SkillPoint:ChangeTextureInfoName(iconInfo.name)
    local x1, y1, x2, y2 = setTextureUV_Func(self._ui.stc_SkillPoint, iconInfo.uv.x1, iconInfo.uv.y1, iconInfo.uv.x2, iconInfo.uv.y2)
    self._ui.stc_SkillPoint:getBaseTexture():setUV(x1, y1, x2, y2)
    self._ui.stc_SkillPoint:setRenderTexture(self._ui.stc_SkillPoint:getBaseTexture())
    self._ui.stc_SkillPoint:SetEnable(false)
    iconInfo = self._iconInfo.music
    self._ui.txt_MusicGradeTitle:ChangeTextureInfoName(iconInfo.name)
    local x1, y1, x2, y2 = setTextureUV_Func(self._ui.txt_MusicGradeTitle, iconInfo.uv.x1, iconInfo.uv.y1, iconInfo.uv.x2, iconInfo.uv.y2)
    self._ui.txt_MusicGradeTitle:getBaseTexture():setUV(x1, y1, x2, y2)
    self._ui.txt_MusicGradeTitle:setRenderTexture(self._ui.txt_MusicGradeTitle:getBaseTexture())
    self._ui.txt_MusicGradeTitle:SetEnable(false)
    iconInfo = self._iconInfo.enchant
    self._ui.stc_EnchantCount:ChangeTextureInfoName(iconInfo.name)
    local x1, y1, x2, y2 = setTextureUV_Func(self._ui.stc_EnchantCount, iconInfo.uv.x1, iconInfo.uv.y1, iconInfo.uv.x2, iconInfo.uv.y2)
    self._ui.stc_EnchantCount:getBaseTexture():setUV(x1, y1, x2, y2)
    self._ui.stc_EnchantCount:setRenderTexture(self._ui.stc_EnchantCount:getBaseTexture())
    self._ui.stc_EnchantCount:SetEnable(false)
    self._ui.stc_EnchantCount:SetColor(Defines.Color.C_FFA78E6A)
  end
end
function PaGlobal_CharInfoBasic_All:registEventHandler(console)
  registerEvent("FromClient_SelfPlayerTendencyChanged", "FromClient_CharInfoBasic_All_TendecyUpdate")
  registerEvent("FromClient_WpChanged", "FromClient_CharInfoBasic_All_MentalUpdate")
  registerEvent("FromClient_UpdateExplorePoint", "FromClient_CharInfoBasic_All_ContributeUpdate")
  registerEvent("FromClient_SelfPlayerExpChanged", "FromClient_CharInfoBasic_All_LevelUpdate")
  registerEvent("EventSelfPlayerLevelUp", "FromClient_CharInfoBasic_All_LevelUpdate")
  registerEvent("FromClient_SelfPlayerHpChanged", "FromClient_CharInfoBasic_All_HpUpdate")
  registerEvent("FromClient_SelfPlayerMpChanged", "FromClient_CharInfoBasic_All_MpUpdate")
  registerEvent("FromClient_InventoryUpdate", "FromClient_CharInfoBasic_All_WeightUpdate")
  registerEvent("FromClient_WeightChanged", "FromClient_CharInfoBasic_All_WeightUpdate")
  registerEvent("EventEquipmentUpdate", "FromClient_CharInfoBasic_All_AtkDefUpdate")
  registerEvent("EventStaminaUpdate", "FromClient_CharInfoBasic_All_StaminaUpdate")
  registerEvent("FromClient_SelfPlayerCombatSkillPointChanged", "FromClient_CharInfoBasic_All_SPUpdate")
  registerEvent("FromClient_SelfPlayerCombatSkillPointChanged", "FromClient_CharInfoBasic_All_FamliyFameUpdate")
  registerEvent("FromClient_UpdateTolerance", "FromClient_CharInfoBasic_All_ResistUpdate")
  registerEvent("FromClient_UpdateSelfPlayerLifeExp", "FromClient_CharInfoBasic_All_LifeUpdate")
  registerEvent("FromClient_UpdateSelfPlayerStatPoint", "FromClient_CharInfoBasic_All_PotentialUpdate")
  registerEvent("FromClientFitnessUp", "FromClient_CharInfoBasic_All_FitnesspUpdate")
  registerEvent("FromClient_ResponseEnchantFailCountOfMyCharacters", "FromClient_CharInfoBasic_All_EnchantStackUpdate")
  registerEvent("FromClient_IncreaseExp", "FromClient_CharInfoBasic_All_IncreaseMusicExp")
  self._ui.btn_LifeRanking:addInputEvent("Mouse_LUp", "HandleEventLUp_CharInfoBasic_All_ShowLifeRanking()")
  self._ui.btn_ShowDetail:addInputEvent("Mouse_LUp", "HandleEventLUp_ChracterInfo_All_ClickOtherTab(" .. PaGlobal_CharInfo_All._TABINDEX._life .. ")")
  if true == console then
    PaGlobal_CharInfoBasic_All:RegistPadEvent()
  else
    PaGlobal_CharInfoBasic_All:RegistInputEvent()
  end
end
function PaGlobal_CharInfoBasic_All:RegistPadEvent()
  self._ui.edit_multiEdit:setXboxVirtualKeyBoardEndEvent("HandleEventPadPress_CharInfoBasic_All_EndVirtualKeyBoard")
  PaGlobal_CharInfo_All._ui.stc_BasicBg:registerPadEvent(__eConsoleUIPadEvent_Up_LT, "HandleEventPadPress_CharInfoBasic_All_ClickOtherTab( false )")
  PaGlobal_CharInfo_All._ui.stc_BasicBg:registerPadEvent(__eConsoleUIPadEvent_Up_RT, "HandleEventPadPress_CharInfoBasic_All_ClickOtherTab( true )")
  self._ui.edit_multiEdit:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandleEventPadPress_CharInfoBasic_All_OpenVirtualKeyBoard()")
  if _ContentsGroup_Console_AccountLinking then
    PaGlobal_CharInfo_All._ui.stc_BasicBg:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "PaGlobalFunc_AccountLinking_Open()")
  end
  self._ui.photoBg:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandleEventPadPress_CharInfoBasic_All_ShowTooltip(1)")
  self._ui.statBg:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandleEventPadPress_CharInfoBasic_All_ShowTooltip(2)")
  self._ui.stc_FitnessBg:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandleEventPadPress_CharInfoBasic_All_ShowTooltip(3)")
  self._ui.stc_PotenBg:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandleEventPadPress_CharInfoBasic_All_ShowTooltip(4)")
  self._ui.stc_CombatBg:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandleEventPadPress_CharInfoBasic_All_ShowTooltip(5)")
  self._ui.txt_BattlePointTitle:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandleEventPadPress_CharInfoBasic_All_ShowTooltip(6,1)")
  self._ui.txt_LifePointTitle:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandleEventPadPress_CharInfoBasic_All_ShowTooltip(6,2)")
  self._ui.txt_SpecialPointTitle:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandleEventPadPress_CharInfoBasic_All_ShowTooltip(6,3)")
  self._ui.txt_FamilyPointTitle:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandleEventPadPress_CharInfoBasic_All_ShowTooltip(6,0)")
  self._ui.txt_BattlePointTitle:addInputEvent("Mouse_Out", "HandleEventOnOut_CharInfoBasic_All_Fame( false )")
  self._ui.txt_LifePointTitle:addInputEvent("Mouse_Out", "HandleEventOnOut_CharInfoBasic_All_Fame( false )")
  self._ui.txt_SpecialPointTitle:addInputEvent("Mouse_Out", "HandleEventOnOut_CharInfoBasic_All_Fame( false )")
  self._ui.txt_FamilyPointTitle:addInputEvent("Mouse_Out", "HandleEventOnOut_CharInfoBasic_All_Fame( false )")
end
function PaGlobal_CharInfoBasic_All:RegistInputEvent()
  self._ui.rdo_BattleInfo:addInputEvent("Mouse_LUp", "HandleEventLUp_CharInfoBasic_All_ClickOtherTab( 0 )")
  self._ui.rdo_LifeInfo:addInputEvent("Mouse_LUp", "HandleEventLUp_CharInfoBasic_All_ClickOtherTab( 1 )")
  self._ui.rdo_BattleInfo:addInputEvent("Mouse_On", "HandleEventOnOut_CharInfoBasic_All_SubTabTooltip( 0 )")
  self._ui.rdo_BattleInfo:addInputEvent("Mouse_Out", "HandleEventOnOut_CharInfoBasic_All_SubTabTooltip(  )")
  self._ui.rdo_LifeInfo:addInputEvent("Mouse_On", "HandleEventOnOut_CharInfoBasic_All_SubTabTooltip( 1 )")
  self._ui.rdo_LifeInfo:addInputEvent("Mouse_Out", "HandleEventOnOut_CharInfoBasic_All_SubTabTooltip(  )")
  self._ui.edit_multiEdit:addInputEvent("Mouse_LUp", "HandleEventLUp_CharInfoBasic_All_SetEditFocus()")
  self._ui.stc_EditBoxIcon:addInputEvent("Mouse_LUp", "HandleEventLUp_CharInfoBasic_All_SetIntroduceText()")
  local localFunc_disableIgnore_SetTextSize = function(control)
    if nil ~= control then
      control:SetIgnore(false)
      control:SetSize(control:GetTextSizeX(), control:GetSizeY())
      control:SetEnableArea(0, 0, control:GetTextSizeX(), control:GetSizeY())
      control:ComputePos()
    end
  end
  self._ui.btn_FacePhoto:SetIgnore(false)
  self._ui.btn_FacePhoto:addInputEvent("Mouse_LUp", "HandleEventLUp_CharInfoBasic_All_TakePhoto()")
  self._ui.btn_FacePhoto:addInputEvent("Mouse_On", "HandleEventOnOut_CharInfoBasic_All_FacePhoto(true)")
  self._ui.btn_FacePhoto:addInputEvent("Mouse_Out", "HandleEventOnOut_CharInfoBasic_All_FacePhoto(false)")
  self._ui.txt_EnchantCount:SetIgnore(false)
  self._ui.txt_EnchantCount:addInputEvent("Mouse_On", "HandleEventOnOut_CharInfoBasic_All_EnchantStack( true, false )")
  self._ui.txt_EnchantCount:addInputEvent("Mouse_Out", "HandleEventOnOut_CharInfoBasic_All_EnchantStack( false )")
  self._ui.stc_EnchantStackIcon:SetIgnore(false)
  self._ui.stc_EnchantStackIcon:addInputEvent("Mouse_On", "HandleEventOnOut_CharInfoBasic_All_EnchantStack( true, true  )")
  self._ui.stc_EnchantStackIcon:addInputEvent("Mouse_Out", "HandleEventOnOut_CharInfoBasic_All_EnchantStack( false )")
  self._ui.stc_EnchantCount:addInputEvent("Mouse_On", "HandleEventOnOut_CharInfoBasic_All_EnchantStack( true, true  )")
  self._ui.stc_EnchantCount:addInputEvent("Mouse_Out", "HandleEventOnOut_CharInfoBasic_All_EnchantStack( false )")
  self._ui.stc_SelfTimer:addInputEvent("Mouse_On", "HandleEventOnOut_CharInfoBasic_All_SelfTimerTooltip(true)")
  self._ui.stc_SelfTimer:addInputEvent("Mouse_Out", "HandleEventOnOut_CharInfoBasic_All_SelfTimerTooltip(false)")
  localFunc_disableIgnore_SetTextSize(self._ui.txt_FamilyPoint)
  localFunc_disableIgnore_SetTextSize(self._ui.txt_BattlePoint)
  localFunc_disableIgnore_SetTextSize(self._ui.txt_LifePoint)
  localFunc_disableIgnore_SetTextSize(self._ui.txt_SpecialPoint)
  self._ui.txt_FamilyPointTitle:addInputEvent("Mouse_On", "HandleEventOnOut_CharInfoBasic_All_Fame( true, 0 )")
  self._ui.txt_FamilyPointTitle:addInputEvent("Mouse_Out", "HandleEventOnOut_CharInfoBasic_All_Fame( false )")
  self._ui.txt_BattlePointTitle:addInputEvent("Mouse_On", "HandleEventOnOut_CharInfoBasic_All_Fame( true, 1 )")
  self._ui.txt_BattlePointTitle:addInputEvent("Mouse_Out", "HandleEventOnOut_CharInfoBasic_All_Fame( false )")
  self._ui.txt_LifePointTitle:addInputEvent("Mouse_On", "HandleEventOnOut_CharInfoBasic_All_Fame( true, 2 )")
  self._ui.txt_LifePointTitle:addInputEvent("Mouse_Out", "HandleEventOnOut_CharInfoBasic_All_Fame( false )")
  self._ui.txt_SpecialPointTitle:addInputEvent("Mouse_On", "HandleEventOnOut_CharInfoBasic_All_Fame( true, 3 )")
  self._ui.txt_SpecialPointTitle:addInputEvent("Mouse_Out", "HandleEventOnOut_CharInfoBasic_All_Fame( false )")
  localFunc_disableIgnore_SetTextSize(self._ui.txt_DownRegistTitle)
  localFunc_disableIgnore_SetTextSize(self._ui.txt_GrabRegistTitle)
  localFunc_disableIgnore_SetTextSize(self._ui.txt_AirRegistTitle)
  self._ui.txt_StunRegistTitle:SetIgnore(false)
  self._ui.txt_StunRegistTitle:SetSize(self._ui.stc_CombatBg:GetSizeX() - (self._ui.txt_StunRegist:GetTextSizeX() + self._ui.txt_StunRegistTitle:GetSizeX() * 2 + 20), self._ui.txt_StunRegistTitle:GetSizeY())
  UI.setLimitTextAndAddTooltip(self._ui.txt_StunRegistTitle)
  self._ui.txt_StunRegistTitle:addInputEvent("Mouse_On", "HandleEventOnOut_CharInfoBasic_All_Regist(true, 0)")
  self._ui.txt_DownRegistTitle:addInputEvent("Mouse_On", "HandleEventOnOut_CharInfoBasic_All_Regist(true, 1)")
  self._ui.txt_GrabRegistTitle:addInputEvent("Mouse_On", "HandleEventOnOut_CharInfoBasic_All_Regist(true, 2)")
  self._ui.txt_AirRegistTitle:addInputEvent("Mouse_On", "HandleEventOnOut_CharInfoBasic_All_Regist(true, 3)")
  self._ui.txt_StunRegistTitle:addInputEvent("Mouse_Out", "HandleEventOnOut_CharInfoBasic_All_Regist(false)")
  self._ui.txt_GrabRegistTitle:addInputEvent("Mouse_Out", "HandleEventOnOut_CharInfoBasic_All_Regist(false)")
  self._ui.txt_DownRegistTitle:addInputEvent("Mouse_Out", "HandleEventOnOut_CharInfoBasic_All_Regist(false)")
  self._ui.txt_AirRegistTitle:addInputEvent("Mouse_Out", "HandleEventOnOut_CharInfoBasic_All_Regist(false)")
  localFunc_disableIgnore_SetTextSize(self._ui.txt_Breath)
  localFunc_disableIgnore_SetTextSize(self._ui.txt_Power)
  self._ui.txt_Health:SetIgnore(false)
  self._ui.txt_Breath:addInputEvent("Mouse_On", "HandleEventOnOut_CharInfoBasic_All_Fitness(true, 0)")
  self._ui.txt_Power:addInputEvent("Mouse_On", "HandleEventOnOut_CharInfoBasic_All_Fitness(true, 1)")
  self._ui.txt_Health:addInputEvent("Mouse_On", "HandleEventOnOut_CharInfoBasic_All_Fitness(true, 2)")
  self._ui.txt_Breath:addInputEvent("Mouse_Out", "HandleEventOnOut_CharInfoBasic_All_Fitness(false)")
  self._ui.txt_Power:addInputEvent("Mouse_Out", "HandleEventOnOut_CharInfoBasic_All_Fitness(false)")
  self._ui.txt_Health:addInputEvent("Mouse_Out", "HandleEventOnOut_CharInfoBasic_All_Fitness(false)")
  localFunc_disableIgnore_SetTextSize(self._ui.txt_HpTitle)
  localFunc_disableIgnore_SetTextSize(self._ui.txt_MpTitle)
  localFunc_disableIgnore_SetTextSize(self._ui.txt_LTTitle)
  self._ui.txt_HpTitle:addInputEvent("Mouse_On", "HandleEventOnOut_CharInfoBasic_All_BasicStat(true , 0 )")
  self._ui.txt_MpTitle:addInputEvent("Mouse_On", "HandleEventOnOut_CharInfoBasic_All_BasicStat(true , 1 )")
  self._ui.txt_LTTitle:addInputEvent("Mouse_On", "HandleEventOnOut_CharInfoBasic_All_BasicStat(true , 2 )")
  self._ui.txt_HpTitle:addInputEvent("Mouse_Out", "HandleEventOnOut_CharInfoBasic_All_BasicStat(false)")
  self._ui.txt_MpTitle:addInputEvent("Mouse_Out", "HandleEventOnOut_CharInfoBasic_All_BasicStat(false)")
  self._ui.txt_LTTitle:addInputEvent("Mouse_Out", "HandleEventOnOut_CharInfoBasic_All_BasicStat(false)")
  for idx = 1, self._LIFEINFOCOUNT do
    if nil ~= self._ui.stc_LifeTable[idx] then
      self._ui.stc_LifeTable[idx].bg:SetIgnore(false)
      self._ui.stc_LifeTable[idx].bg:addInputEvent("Mouse_On", "HandleEventOnOut_CharInfoBasic_All_LifeGrade(true," .. idx .. ")")
      self._ui.stc_LifeTable[idx].bg:addInputEvent("Mouse_Out", "HandleEventOnOut_CharInfoBasic_All_LifeGrade(false)")
    end
  end
  if true == _ContentsGroup_InstrumentPerformance then
    self._ui.txt_MusicGradeValue:SetIgnore(false)
    self._ui.txt_MusicGradeTitle:SetIgnore(false)
    self._ui.txt_MusicGradeValue:addInputEvent("Mouse_On", "HandleEventOnOut_CharInfoBasic_All_MusicRank(true)")
    self._ui.txt_MusicGradeValue:addInputEvent("Mouse_Out", "HandleEventOnOut_CharInfoBasic_All_MusicRank(false)")
    self._ui.txt_MusicGradeTitle:addInputEvent("Mouse_On", "HandleEventOnOut_CharInfoBasic_All_MusicRank(true)")
    self._ui.txt_MusicGradeTitle:addInputEvent("Mouse_Out", "HandleEventOnOut_CharInfoBasic_All_MusicRank(false)")
  end
  self._ui.stc_Tendency:SetIgnore(false)
  self._ui.stc_Wp:SetIgnore(false)
  self._ui.stc_Contribute:SetIgnore(false)
  self._ui.stc_SkillPoint:SetIgnore(false)
  self._ui.stc_Star:SetIgnore(false)
  self._ui.stc_EnchantCount:SetIgnore(false)
  self._ui.stc_Tendency:addInputEvent("Mouse_On", "HandleEventOnOut_CharInfoBasic_All_StatusTooltip(1)")
  self._ui.stc_Tendency:addInputEvent("Mouse_Out", "HandleEventOnOut_CharInfoBasic_All_StatusTooltip()")
  self._ui.stc_Wp:addInputEvent("Mouse_On", "HandleEventOnOut_CharInfoBasic_All_StatusTooltip(2)")
  self._ui.stc_Wp:addInputEvent("Mouse_Out", "HandleEventOnOut_CharInfoBasic_All_StatusTooltip()")
  self._ui.stc_Contribute:addInputEvent("Mouse_On", "HandleEventOnOut_CharInfoBasic_All_StatusTooltip(3)")
  self._ui.stc_Contribute:addInputEvent("Mouse_Out", "HandleEventOnOut_CharInfoBasic_All_StatusTooltip()")
  self._ui.stc_SkillPoint:addInputEvent("Mouse_On", "HandleEventOnOut_CharInfoBasic_All_StatusTooltip(4)")
  self._ui.stc_SkillPoint:addInputEvent("Mouse_Out", "HandleEventOnOut_CharInfoBasic_All_StatusTooltip()")
  self._ui.stc_Star:addInputEvent("Mouse_On", "HandleEventOnOut_CharInfoBasic_All_StatusTooltip(5)")
  self._ui.stc_Star:addInputEvent("Mouse_Out", "HandleEventOnOut_CharInfoBasic_All_StatusTooltip()")
  self._ui.stc_SkillPoint:addInputEvent("Mouse_LUp", "HandleEventLUp_CharInfoBasic_All_OpenSkillWindow()")
  self._ui.txt_MusicGradeTitle:addInputEvent("Mouse_LUp", "HandleEventLUp_CharInfoBasic_All_OpenMusicAlbum()")
  self._ui.stc_EnchantCount:addInputEvent("Mouse_LUp", "HandleEventLUp_CharInfoBasic_All_OpenBlackSpiritEnchant()")
end
function PaGlobal_CharInfoBasic_All:setUnChangedData()
  self._ui.edit_multiEdit:SetMaxEditLine(6)
  self._ui.edit_multiEdit:SetMaxInput(120)
  local classType = self._selfPlayer:getClassType()
  local eClassType = CppEnums.ClassType
  self._asianFlag = isGameTypeKorea() or isGameTypeTaiwan() or isGameTypeJapan()
  for index = 0, 2 do
    local data = {
      _titleUI = nil,
      _prog2 = nil,
      _level = nil
    }
    if self._ENUM_FITNESS.BREATH == index then
      data._titleUI = self._ui.txt_Breath
      data._prog2 = self._ui.prog_Breath
      data._level = self._ui.txt_BreathLv
    elseif self._ENUM_FITNESS.POWER == index then
      data._titleUI = self._ui.txt_Power
      data._prog2 = self._ui.prog_Power
      data._level = self._ui.txt_PowerLv
    else
      data._titleUI = self._ui.txt_Health
      data._prog2 = self._ui.prog_Health
      data._level = self._ui.txt_HealthLv
    end
    self._fitnessData[index] = data
  end
  local POTEN_STRING = {
    [0] = "AttackSpeed_",
    [1] = "MoveSpeed_",
    [2] = "Critcal_",
    [3] = "Fishing_",
    [4] = "Collect_",
    [5] = "LUCK_"
  }
  local potenSlotBG_Temp = UI.getChildControl(self._ui.stc_PotenBg, "Static_SlotBg")
  local potenSlot_Temp = UI.getChildControl(self._ui.stc_PotenBg, "Static_Slot")
  for potenIdx = 0, #POTEN_STRING do
    local tempData = {
      title = nil,
      val = nil,
      slotBg = {},
      slot = {},
      toolTipDesc = ""
    }
    local battleSpeed = CppEnums.ClassType_BattleSpeed[classType]
    if self._ENUM_POTEN.ATKSPD == potenIdx then
      tempData.title = self._ui.txt_AtkSpd
      tempData.val = self._ui.txt_AtkLv
      local classString = PaGlobal_CharInfoBasic_All:getClassStringByAtkType(battleSpeed)
      tempData.toolTipDesc = classString
    elseif self._ENUM_POTEN.MOVESPD == potenIdx then
      tempData.title = self._ui.txt_MoveSpd
      tempData.val = self._ui.txt_MoveLv
      tempData.toolTipDesc = PAGetString(Defines.StringSheet_GAME, "LUA_CHARACTERINFO_TXT_DESC_2")
    elseif self._ENUM_POTEN.CRITICAL == potenIdx then
      tempData.title = self._ui.txt_Critical
      tempData.val = self._ui.txt_CriticalLv
      tempData.toolTipDesc = PAGetString(Defines.StringSheet_GAME, "LUA_CHARACTERINFO_TXT_DESC_3")
    elseif self._ENUM_POTEN.FISH == potenIdx then
      tempData.title = self._ui.txt_Fish
      tempData.val = self._ui.txt_FishLv
      tempData.toolTipDesc = PAGetString(Defines.StringSheet_GAME, "LUA_CHARACTERINFO_TXT_DESC_4")
    elseif self._ENUM_POTEN.COLLECT == potenIdx then
      tempData.title = self._ui.txt_Gather
      tempData.val = self._ui.txt_GatherLv
      tempData.toolTipDesc = PAGetString(Defines.StringSheet_GAME, "LUA_CHARACTERINFO_TXT_DESC_5")
    elseif self._ENUM_POTEN.LUCK == potenIdx then
      tempData.title = self._ui.txt_Luck
      tempData.val = self._ui.txt_LuckLv
      tempData.toolTipDesc = PAGetString(Defines.StringSheet_GAME, "LUA_CHARACTERINFO_TXT_DESC_6")
    end
    tempData.title:SetIgnore(false)
    tempData.title:SetSize(tempData.title:GetTextSizeX(), tempData.title:GetSizeY())
    tempData.title:addInputEvent("Mouse_On", "HandleEventOnOut_CharInfoBasic_All_Potential(true, " .. tostring(potenIdx) .. ")")
    tempData.title:addInputEvent("Mouse_Out", "HandleEventOnOut_CharInfoBasic_All_Potential(false)")
    local padding = 5
    for slotIdx = 0, self._MAX_POTENCIALSLOT do
      local slotBg = UI.createControl(__ePAUIControl_Static, self._ui.stc_PotenBg, "Static_" .. POTEN_STRING[potenIdx] .. "SlotBG_" .. slotIdx)
      local slot = UI.createControl(__ePAUIControl_Static, self._ui.stc_PotenBg, "Static_" .. POTEN_STRING[potenIdx] .. "Slot_" .. slotIdx)
      slot:SetShow(false)
      CopyBaseProperty(potenSlotBG_Temp, slotBg)
      CopyBaseProperty(potenSlot_Temp, slot)
      local sizeY = tempData.title:GetSizeY() + padding
      slotBg:SetSpanSize(tempData.title:GetSpanSize().x + (slotIdx * (slotBg:GetSizeX() + 7) + slotIdx * 5), tempData.val:GetSpanSize().y + sizeY)
      slot:SetSpanSize(tempData.title:GetSpanSize().x + (slotIdx * (slot:GetSizeX() + 7) + slotIdx * 5), tempData.val:GetSpanSize().y + sizeY)
      tempData.slotBg[slotIdx] = slotBg
      tempData.slot[slotIdx] = slot
    end
    self._potentialData[potenIdx] = tempData
  end
  if CppEnums.ClassType_BattleSpeed[classType] == CppEnums.BattleSpeedType.SpeedType_Attack then
    self._ui.txt_AtkSpd:SetText(PAGetString(Defines.StringSheet_RESOURCE, "CHARACTERINFO_TEXT_ATTACKSPEED"))
  else
    self._ui.txt_AtkSpd:SetText(PAGetString(Defines.StringSheet_RESOURCE, "CHARACTERINFO_TEXT_CASTSPEED"))
  end
  if __eClassType_ElfRanger == classType or __eClassType_RangerMan == classType then
    self._ui.txt_MpTitle:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_CHARACTERINFO_TEXT_EP"))
  elseif __eClassType_Warrior == classType or __eClassType_Giant == classType or __eClassType_BladeMaster == classType or __eClassType_BladeMasterWoman == classType or __eClassType_NinjaMan == classType or __eClassType_Kunoichi == classType or __eClassType_Combattant == classType or __eClassType_Lhan == classType or __eClassType_Mystic == classType or __eClassType_Guardian == classType then
    self._ui.txt_MpTitle:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_CHARACTERINFO_TEXT_FP"))
  elseif __eClassType_Sorcerer == classType or __eClassType_Tamer == classType or __eClassType_WizardMan == classType or __eClassType_WizardWoman == classType or __eClassType_Hashashin == classType then
    self._ui.txt_MpTitle:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_CHARACTERINFO_TEXT_MP"))
  elseif __eClassType_Valkyrie == classType then
    self._ui.txt_MpTitle:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_SELFCHARACTERINFO_BP"))
  elseif __eClassType_DarkElf == classType then
    self._ui.txt_MpTitle:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_CHARACTERINFO_TEXT_MP_DARKELF"))
  elseif __eClassType_ShyWaman == classType then
    self._ui.txt_MpTitle:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_CHARACTERINFO_TEXT_MP"))
  end
  self._ui.txt_FamilyName:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GUILDLIST_FAMILYNAME", "name", tostring(getFamilyName())))
  self._ui.txt_PlayerName:SetText(self._selfPlayer:getOriginalName())
  self._ui.txt_PlayerLv:SetText("( " .. PAGetStringParam1(Defines.StringSheet_GAME, "LUA_WORKERAUCTION_WORKERLEVEL", "level", tostring(self._selfPlayer:get():getLevel())) .. " )")
  PaGlobal_CharInfoBasic_All:setClassIcon(self._ui.txt_PlayerLv, classType)
  local zodiacWrapper = self._selfPlayer:getZodiacSignOrderStaticStatusWrapper()
  if nil ~= zodiacWrapper then
    local zodiacName = zodiacWrapper:getZodiacName()
    self._ui.txt_Star:SetText(zodiacName)
    PaGlobal_CharInfoBasic_All:SetEnableAreaByTextSize(self._ui.txt_Star)
  end
  local selfMsg = ToClient_GetUserIntroduction()
  if "" ~= selfMsg then
    self._ui.edit_multiEdit:SetEditText(selfMsg)
  else
    self._ui.edit_multiEdit:SetEditText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_CHARACTERINFO_MYINTRODUCE_INPUT"))
  end
  local BattileInfoTitleSpanY = 25
  local gap = 25
  local isSetAwakenWeapon = ToClient_getEquipmentItem(CppEnums.EquipSlotNo.awakenWeapon)
  local isShyWomen = __eClassType_ShyWaman == self._selfPlayer:getClassType()
  local flag = nil ~= isSetAwakenWeapon and self._isAwakenWeaponContentsOpen
  self._ui.txt_AwakenTitle:SetShow(flag)
  self._ui.txt_AwakenAtk:SetShow(flag)
  local statUI = {
    [1] = self._ui.txt_AtkTitle,
    [2] = nil,
    [3] = self._ui.txt_DefTitle,
    [4] = self._ui.txt_StaminaTitle,
    [5] = self._ui.txt_StunRegistTitle,
    [6] = self._ui.txt_GrabRegistTitle,
    [7] = self._ui.txt_DownRegistTitle,
    [8] = self._ui.txt_AirRegistTitle
  }
  if true == flag then
    statUI[2] = self._ui.txt_AwakenTitle
    self._ui.txt_AwakenTitle:SetText(true)
    if true == isShyWomen then
      self._ui.txt_AwakenTitle:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_COMMON_SHYSTAT_1"))
    else
      self._ui.txt_AwakenTitle:SetText(PAGetString(Defines.StringSheet_RESOURCE, "CHARACTERINFO_TEXT_AWAKENATTACK"))
    end
    self._ui.txt_AwakenAtk:SetText(tostring(ToClient_getAwakenOffence()))
  end
  local uiCount = 1
  for i = 1, 8 do
    if nil ~= statUI[i] then
      statUI[i]:SetSpanSize(statUI[i]:GetSpanSize().x, 0)
      statUI[i]:SetSpanSize(statUI[i]:GetSpanSize().x, BattileInfoTitleSpanY + statUI[i]:GetSpanSize().y + (gap * uiCount - 0))
      uiCount = uiCount + 1
    end
  end
  self._ui.txt_Atk:SetSpanSize(self._ui.txt_Atk:GetSpanSize().x, self._ui.txt_AtkTitle:GetSpanSize().y)
  self._ui.txt_AwakenAtk:SetSpanSize(self._ui.txt_AwakenAtk:GetSpanSize().x, self._ui.txt_AwakenTitle:GetSpanSize().y)
  self._ui.txt_Def:SetSpanSize(self._ui.txt_Def:GetSpanSize().x, self._ui.txt_DefTitle:GetSpanSize().y)
  self._ui.txt_Stamina:SetSpanSize(self._ui.txt_Stamina:GetSpanSize().x, self._ui.txt_StaminaTitle:GetSpanSize().y)
  self._ui.txt_StunRegist:SetSpanSize(self._ui.txt_StunRegist:GetSpanSize().x, self._ui.txt_StunRegistTitle:GetSpanSize().y)
  self._ui.txt_GrabRegist:SetSpanSize(self._ui.txt_GrabRegist:GetSpanSize().x, self._ui.txt_GrabRegistTitle:GetSpanSize().y)
  self._ui.txt_DownRegist:SetSpanSize(self._ui.txt_DownRegist:GetSpanSize().x, self._ui.txt_DownRegistTitle:GetSpanSize().y)
  self._ui.txt_AirRegist:SetSpanSize(self._ui.txt_AirRegist:GetSpanSize().x, self._ui.txt_AirRegistTitle:GetSpanSize().y)
  PaGlobal_CharInfoBasic_All:setConsoleTooltip()
end
function PaGlobal_CharInfoBasic_All:setConsoleTooltip()
  if false == self._isConsole then
    return
  end
  self._consoleTooltip = {}
  for idx = 1, 5 do
    local tooltipInfo = {_title = nil, _desc = nil}
    if 1 == idx then
      local totalPlayTime = Util.Time.timeFormatting_Minute(Int64toInt32(ToClient_GetCharacterPlayTime()))
      tooltipInfo._title = PAGetString(Defines.StringSheet_RESOURCE, "CHARACTERINFO_TEXT_SUBTITLE")
      tooltipInfo._desc = PAGetString(Defines.StringSheet_GAME, "LUA_CHARACTERINFO_TEXT_HPREGEN") .. " : " .. tostring(self._selfPlayer:get():getRegenHp()) .. " \n" .. PaGlobal_CharInfo_All:setMpTooltipByClass() .. " \n" .. PaGlobal_CharInfoBasic_All._ui.txt_LTTitle:GetText() .. " : " .. PAGetString(Defines.StringSheet_RESOURCE, "PANEL_CHARACTERINFO_WEIGHT_TOOLTIP") .. " \n" .. PAGetString(Defines.StringSheet_GAME, "LUA_CONTRACT_TIME_BLACKSPIRIT") .. " " .. totalPlayTime
    elseif 2 == idx then
      tooltipInfo._title = PAGetString(Defines.StringSheet_RESOURCE, "LUA_GUILDBATTLE_PLAYERSTATUS")
      tooltipInfo._desc = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_CHARACTERINFO_RENEW_TENDENCY_TITLE") .. " : " .. self._ui.txt_Tendency:GetText() .. " \n" .. PAGetString(Defines.StringSheet_RESOURCE, "CHARACTERINFO_TEXT_MENTAL") .. " : " .. self._ui.txt_Wp:GetText() .. " \n" .. PAGetString(Defines.StringSheet_RESOURCE, "CHARACTERINFO_TEXT_CONTRIBUTION") .. " : " .. self._ui.txt_Contribute:GetText() .. " \n" .. PAGetString(Defines.StringSheet_RESOURCE, "SKILL_TEXT_POINT") .. " : " .. self._ui.txt_SkillPoint:GetText() .. " \n" .. PAGetString(Defines.StringSheet_RESOURCE, "CHARACTERINFO_TEXT_ZODIA") .. " : " .. self._ui.txt_Star:GetText() .. " \n" .. PAGetString(Defines.StringSheet_GAME, "LUA_GAMEEXIT_NORMALSTACK_TOOLTIP_NAME") .. " : " .. self._ui.txt_EnchantCount:GetText()
    elseif 3 == idx then
      local staminaDesc = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_SELFCHARACTERINFO_FITNESS_STAMINA_MSG", "type", tostring(ToClient_GetFitnessLevelStatus(0)))
      local strengthDesc = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_SELFCHARACTERINFO_FITNESS_STRENGTH_MSG", "type", tostring(ToClient_GetFitnessLevelStatus(1) / 10000))
      local healthDesc = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_SELFCHARACTERINFO_FITNESS_HEALTH_MSG", "type", tostring(ToClient_GetFitnessLevelStatus(2, 0)))
      local _mentalType = self._selfPlayer:getCombatResourceType()
      local _mpName = {
        [CppEnums.CombatResourceType.CombatType_MP] = PAGetString(Defines.StringSheet_GAME, "LUA_CHARACTERINFO_TEXT_MP"),
        [CppEnums.CombatResourceType.CombatType_FP] = PAGetString(Defines.StringSheet_GAME, "LUA_CHARACTERINFO_TEXT_FP_NEW"),
        [CppEnums.CombatResourceType.CombatType_EP] = PAGetString(Defines.StringSheet_GAME, "LUA_CHARACTERINFO_TEXT_EP"),
        [CppEnums.CombatResourceType.CombatType_BP] = PAGetString(Defines.StringSheet_GAME, "LUA_SELFCHARACTERINFO_BP")
      }
      local mpTypeTitle = _mpName[_mentalType]
      healthDesc = PAGetStringParam3(Defines.StringSheet_GAME, "LUA_CHARACTERINFO_FITNESS_HEALTH_MSG_NEW", "hpIncrease", ToClient_GetFitnessLevelStatus(2, 0), "mpTypeName", mpTypeTitle, "mpIncrease", ToClient_GetFitnessLevelStatus(2, 1))
      tooltipInfo._title = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_CHARACTERINFO_FITNESS_TITLE")
      tooltipInfo._desc = "- " .. PAGetString(Defines.StringSheet_GAME, "LUA_CHARACTERINFO_FITNESS_STAMINA_TITLE_ONE") .. " : " .. staminaDesc .. [[
 

]] .. "- " .. PAGetString(Defines.StringSheet_GAME, "LUA_CHARACTERINFO_FITNESS_STRENGTH_TITLE_ONE") .. " : " .. strengthDesc .. [[
 

]] .. "- " .. PAGetString(Defines.StringSheet_GAME, "LUA_CHARACTERINFO_FITNESS_HEALTH_TITLE_ONE") .. " : " .. healthDesc
    elseif 4 == idx then
      tooltipInfo._title = PAGetString(Defines.StringSheet_RESOURCE, "CHARACTERINFO_TEXT_SUBTITLE_POTENTIAL")
      tooltipInfo._desc = "- " .. PaGlobal_CharInfoBasic_All._potentialData[0].title:GetText() .. " \n" .. PaGlobal_CharInfoBasic_All._potentialData[0].toolTipDesc .. [[
 

]] .. "- " .. PaGlobal_CharInfoBasic_All._potentialData[1].title:GetText() .. " \n" .. PaGlobal_CharInfoBasic_All._potentialData[1].toolTipDesc .. [[
 

]] .. "- " .. PaGlobal_CharInfoBasic_All._potentialData[2].title:GetText() .. " \n" .. PaGlobal_CharInfoBasic_All._potentialData[2].toolTipDesc .. [[
 

]] .. "- " .. PaGlobal_CharInfoBasic_All._potentialData[3].title:GetText() .. " \n" .. PaGlobal_CharInfoBasic_All._potentialData[3].toolTipDesc .. [[
 

]] .. "- " .. PaGlobal_CharInfoBasic_All._potentialData[4].title:GetText() .. " \n" .. PaGlobal_CharInfoBasic_All._potentialData[4].toolTipDesc .. [[
 

]] .. "- " .. PaGlobal_CharInfoBasic_All._potentialData[5].title:GetText() .. " \n" .. PaGlobal_CharInfoBasic_All._potentialData[5].toolTipDesc .. [[
 

]]
    elseif 5 == idx then
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
      tooltipInfo._title = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_CHARACTERINFO_BATTLESTAT")
      tooltipInfo._desc = "- " .. PAGetString(Defines.StringSheet_GAME, string[0][1]) .. [[
 : 
 ]] .. PAGetString(Defines.StringSheet_GAME, string[0][2]) .. [[
 

]] .. "- " .. PAGetString(Defines.StringSheet_GAME, string[1][1]) .. [[
 : 
 ]] .. PAGetString(Defines.StringSheet_GAME, string[1][2]) .. [[
 

]] .. "- " .. PAGetString(Defines.StringSheet_GAME, string[2][1]) .. [[
 : 
 ]] .. PAGetString(Defines.StringSheet_GAME, string[2][2]) .. [[
 

]] .. "- " .. PAGetString(Defines.StringSheet_GAME, string[3][1]) .. [[
 : 
 ]] .. PAGetString(Defines.StringSheet_GAME, string[3][2]) .. [[
 

]]
    end
    self._consoleTooltip[idx] = tooltipInfo
  end
end
function PaGlobal_CharInfoBasic_All:allDataUpdate()
  FromClient_CharInfoBasic_All_TendecyUpdate()
  FromClient_CharInfoBasic_All_MentalUpdate()
  FromClient_CharInfoBasic_All_ContributeUpdate()
  FromClient_CharInfoBasic_All_LevelUpdate()
  FromClient_CharInfoBasic_All_HpUpdate()
  FromClient_CharInfoBasic_All_MpUpdate()
  FromClient_CharInfoBasic_All_WeightUpdate()
  FromClient_CharInfoBasic_All_AtkDefUpdate()
  FromClient_CharInfoBasic_All_StaminaUpdate()
  FromClient_CharInfoBasic_All_SPUpdate()
  FromClient_CharInfoBasic_All_ResistUpdate()
  FromClient_CharInfoBasic_All_LifeUpdate()
  FromClient_CharInfoBasic_All_PotentialUpdate()
  FromClient_CharInfoBasic_All_FitnesspUpdate(0, 0, 0, 0)
  FromClient_CharInfoBasic_All_FamliyFameUpdate()
  FromClient_CharInfoBasic_All_EnchantStackUpdate()
  FromClient_CharInfoBasic_All_IncreaseMusicExp()
  PaGlobal_CharInfoBasic_All:setConsoleTooltip()
  local totalPlayTime = Util.Time.timeFormatting_Minute(Int64toInt32(ToClient_GetCharacterPlayTime()))
  self._ui.txt_SelfTimer:SetFontColor(Defines.Color.C_FFF5BA3A)
  self._ui.txt_SelfTimer:SetText(totalPlayTime)
  local selfMsg = ToClient_GetUserIntroduction()
  if "" ~= selfMsg then
    self._ui.edit_multiEdit:SetEditText(selfMsg)
  else
    self._ui.edit_multiEdit:SetEditText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_CHARACTERINFO_MYINTRODUCE_INPUT"))
  end
end
function PaGlobal_CharInfoBasic_All:update()
  local currentInfoTab = ToClient_getGameUIManagerWrapper():getLuaCacheDataListNumber(__eCharacterInfo)
  HandleEventLUp_CharInfoBasic_All_ClickOtherTab(currentInfoTab)
  PaGlobal_CharInfoBasic_All_UpdateCharPhoto()
  PaGlobal_CharInfoBasic_All:allDataUpdate()
end
function PaGlobal_CharInfoBasic_All:getClassStringByAtkType(classAttackType)
  local header = ""
  local classString = ""
  local appliedClassString = PAGetString(Defines.StringSheet_GAME, "LUA_CHARACTERINFO_TXT_DESC_APPLIEDCLASS")
  if classAttackType == CppEnums.BattleSpeedType.SpeedType_Attack then
    header = PAGetString(Defines.StringSheet_GAME, "LUA_CHARACTERINFO_TXT_DESC_NOCLASS_0")
  elseif classAttackType == CppEnums.BattleSpeedType.SpeedType_Cast then
    header = PAGetString(Defines.StringSheet_GAME, "LUA_CHARACTERINFO_TXT_DESC_NOCLASS_1")
  else
    UI.ASSERT_NAME(false, " wrong classAttackType = " .. tostring(classAttackType), "\234\185\128\234\183\188\236\154\176")
    local classType = self._selfPlayer:getClassType()
    header = PAGetString(Defines.StringSheet_GAME, "LUA_CHARACTERINFO_TXT_DESC_" .. tostring(classType))
  end
  local tempTable = {}
  local stringCount = 1
  for i = 1, getCharacterClassCount() do
    local classType = getCharacterClassTypeByIndex(i - 1)
    if CppEnums.ClassType_BattleSpeed[classType] == classAttackType then
      tempTable[stringCount] = CppEnums.ClassType2String[classType]
      stringCount = stringCount + 1
    end
  end
  for idx = 1, #tempTable do
    classString = classString .. tempTable[idx]
    if idx == #tempTable then
      classString = classString .. ""
    else
      classString = classString .. ", "
    end
  end
  classString = header .. " " .. [[

<PAColor0xFFFFF3AF>( ]] .. appliedClassString .. " : " .. classString .. " )<PAOldColor>"
  return classString
end
function PaGlobal_CharInfoBasic_All:setClassIcon(control, classType)
  if nil == control then
    return
  end
  control:ChangeTextureInfoName("renewal/ui_icon/console_classsymbol.dds")
  local x1, y1, x2, y2 = 0, 0, 0, 0
  if classType == __eClassType_Warrior then
    x1, y1, x2, y2 = setTextureUV_Func(control, 1, 172, 57, 228)
  elseif classType == __eClassType_ElfRanger then
    x1, y1, x2, y2 = setTextureUV_Func(control, 58, 172, 114, 228)
  elseif classType == __eClassType_Sorcerer then
    x1, y1, x2, y2 = setTextureUV_Func(control, 115, 172, 171, 228)
  elseif classType == __eClassType_Giant then
    x1, y1, x2, y2 = setTextureUV_Func(control, 172, 172, 228, 228)
  elseif classType == __eClassType_Tamer then
    x1, y1, x2, y2 = setTextureUV_Func(control, 229, 172, 285, 228)
  elseif classType == __eClassType_BladeMaster then
    x1, y1, x2, y2 = setTextureUV_Func(control, 286, 172, 342, 228)
  elseif classType == __eClassType_BladeMasterWoman then
    x1, y1, x2, y2 = setTextureUV_Func(control, 400, 172, 456, 228)
  elseif classType == __eClassType_Valkyrie then
    x1, y1, x2, y2 = setTextureUV_Func(control, 343, 172, 399, 228)
  elseif classType == __eClassType_WizardMan then
    x1, y1, x2, y2 = setTextureUV_Func(control, 1, 229, 57, 285)
  elseif classType == __eClassType_WizardWoman then
    x1, y1, x2, y2 = setTextureUV_Func(control, 58, 229, 114, 285)
  elseif classType == __eClassType_Kunoichi then
    x1, y1, x2, y2 = setTextureUV_Func(control, 115, 229, 171, 285)
  elseif classType == __eClassType_NinjaMan then
    x1, y1, x2, y2 = setTextureUV_Func(control, 172, 229, 228, 285)
  elseif classType == __eClassType_DarkElf then
    x1, y1, x2, y2 = setTextureUV_Func(control, 229, 229, 285, 285)
  elseif classType == __eClassType_Combattant then
    x1, y1, x2, y2 = setTextureUV_Func(control, 286, 229, 342, 285)
  elseif classType == __eClassType_Mystic then
    x1, y1, x2, y2 = setTextureUV_Func(control, 343, 229, 399, 285)
  elseif classType == __eClassType_Lhan then
    x1, y1, x2, y2 = setTextureUV_Func(control, 400, 229, 456, 285)
  elseif classType == __eClassType_RangerMan then
    x1, y1, x2, y2 = setTextureUV_Func(control, 1, 286, 57, 342)
  elseif classType == __eClassType_ShyWaman then
    x1, y1, x2, y2 = setTextureUV_Func(control, 58, 115, 114, 171)
  elseif classType == __eClassType_Hashashin then
    x1, y1, x2, y2 = setTextureUV_Func(control, 172, 286, 228, 342)
  elseif classType == __eClassType_Guardian then
    x1, y1, x2, y2 = setTextureUV_Func(control, 115, 115, 171, 171)
  end
  control:getBaseTexture():setUV(x1, y1, x2, y2)
  control:setRenderTexture(control:getBaseTexture())
end
function PaGlobal_CharInfoBasic_All:SetEnableAreaByTextSize(control)
  if nil == control then
    return
  end
  control:SetEnableArea(0, 0, control:GetTextSizeX(), control:GetTextSizeY())
end
function PaGlobal_CharInfo_All:setMpTooltipByClass()
  local selfPlayer = getSelfPlayer()
  local mentalType = selfPlayer:getCombatResourceType()
  if nil == mentalType then
    return ""
  elseif CppEnums.CombatResourceType.CombatType_MP == mentalType then
    return PAGetString(Defines.StringSheet_GAME, "LUA_CHARACTERINFO_TEXT_MPREGEN") .. " : " .. tostring(selfPlayer:get():getRegenMp())
  elseif CppEnums.CombatResourceType.CombatType_FP == mentalType then
    return PAGetString(Defines.StringSheet_GAME, "LUA_CHARACTERINFO_TEXT_FPREGEN") .. " : " .. tostring(selfPlayer:get():getRegenMp())
  elseif CppEnums.CombatResourceType.CombatType_EP == mentalType then
    return PAGetString(Defines.StringSheet_GAME, "LUA_CHARACTERINFO_TEXT_EPREGEN") .. " : " .. tostring(selfPlayer:get():getRegenMp())
  elseif CppEnums.CombatResourceType.CombatType_BP == mentalType then
    return PAGetString(Defines.StringSheet_GAME, "LUA_CHARACTERINFO_TEXT_BPREGEN") .. " : " .. tostring(selfPlayer:get():getRegenMp())
  end
end
function PaGlobal_CharInfo_All:getContributeString()
  local territoryKeyRaw = ToClient_getDefaultTerritoryKey()
  local contribution = ToClient_getExplorePointByTerritoryRaw(territoryKeyRaw)
  local curContri = contribution:getRemainedPoint()
  local maxContri = contribution:getAquiredPoint()
  local result = tostring(curContri) .. " / " .. tostring(maxContri)
  return result
end
function PaGlobal_CharInfoBasic_All:validate()
  self._ui.photoBg:isValidate()
  self._ui.stc_CharPhoto:isValidate()
  self._ui.btn_FacePhoto:isValidate()
  self._ui.stc_EnchantStackIcon:isValidate()
  self._ui.txt_EnchantStackIcon_Value:isValidate()
  self._ui.txt_FamilyName:isValidate()
  self._ui.txt_PlayerName:isValidate()
  self._ui.txt_PlayerLv:isValidate()
  self._ui.stc_IntroduceBg:isValidate()
  self._ui.stc_EditBoxIcon:isValidate()
  self._ui.edit_multiEdit:isValidate()
  self._ui.txt_HpTitle:isValidate()
  self._ui.txt_HpVal:isValidate()
  self._ui.txt_MpTitle:isValidate()
  self._ui.txt_Mp_Val:isValidate()
  self._ui.txt_LTTitle:isValidate()
  self._ui.txt_LTVal:isValidate()
  self._ui.txt_BattlePoint:isValidate()
  self._ui.txt_LifePoint:isValidate()
  self._ui.txt_SpecialPoint:isValidate()
  self._ui.txt_FamilyPoint:isValidate()
  self._ui.txt_BattlePointTitle:isValidate()
  self._ui.txt_LifePointTitle:isValidate()
  self._ui.txt_SpecialPointTitle:isValidate()
  self._ui.txt_FamilyPointTitle:isValidate()
  self._ui.txt_Tendency:isValidate()
  self._ui.txt_Wp:isValidate()
  self._ui.statBg:isValidate()
  self._ui.txt_Contribute:isValidate()
  self._ui.txt_SkillPoint:isValidate()
  self._ui.txt_Star:isValidate()
  self._ui.txt_EnchantCount:isValidate()
  self._ui.txt_SelfTimer:isValidate()
  self._ui.stc_RightBg:isValidate()
  self._ui.stc_RightTapBg:isValidate()
  self._ui.stc_KeyGuide_LT:isValidate()
  self._ui.stc_KeyGuide_RT:isValidate()
  self._ui.rdo_BattleInfo:isValidate()
  self._ui.rdo_LifeInfo:isValidate()
  self._ui.stc_TabSelectBar:isValidate()
  self._ui.stc_RightInfoBg:isValidate()
  self._ui.stc_BattleInfoBg:isValidate()
  self._ui.stc_FitnessBg:isValidate()
  self._ui.txt_Breath:isValidate()
  self._ui.txt_BreathLv:isValidate()
  self._ui.prog_Breath:isValidate()
  self._ui.txt_Power:isValidate()
  self._ui.txt_PowerLv:isValidate()
  self._ui.prog_Power:isValidate()
  self._ui.txt_Health:isValidate()
  self._ui.txt_HealthLv:isValidate()
  self._ui.prog_Health:isValidate()
  self._ui.stc_PotenBg:isValidate()
  self._ui.txt_AtkSpd:isValidate()
  self._ui.txt_AtkLv:isValidate()
  self._ui.txt_MoveSpd:isValidate()
  self._ui.txt_MoveLv:isValidate()
  self._ui.txt_Critical:isValidate()
  self._ui.txt_CriticalLv:isValidate()
  self._ui.txt_Fish:isValidate()
  self._ui.txt_FishLv:isValidate()
  self._ui.txt_Gather:isValidate()
  self._ui.txt_GatherLv:isValidate()
  self._ui.txt_Luck:isValidate()
  self._ui.txt_LuckLv:isValidate()
  self._ui.stc_CombatBg:isValidate()
  self._ui.txt_Atk:isValidate()
  self._ui.txt_AwakenAtk:isValidate()
  self._ui.txt_Def:isValidate()
  self._ui.txt_Stamina:isValidate()
  self._ui.txt_StunRegist:isValidate()
  self._ui.txt_GrabRegist:isValidate()
  self._ui.txt_DownRegist:isValidate()
  self._ui.txt_AirRegist:isValidate()
  self._ui.stc_LifeBg:isValidate()
  for idx = 1, self._LIFEINFOCOUNT do
    if nil ~= self._ui.stc_LifeTable[idx] then
      self._ui.stc_LifeTable[idx].rate:isValidate()
      self._ui.stc_LifeTable[idx].prog2:isValidate()
      self._ui.stc_LifeTable[idx].lv:isValidate()
    end
  end
  self._ui.btn_ShowDetail:isValidate()
  self._ui.btn_LifeRanking:isValidate()
  self._ui.stc_KeyGuide_Bg:isValidate()
  self._ui.stc_KeyGuide_B:isValidate()
  self._ui.stc_KeyGuide_X:isValidate()
  self._ui.stc_KeyGuide_Y:isValidate()
  self._ui.stc_Tendency:isValidate()
  self._ui.stc_Wp:isValidate()
  self._ui.stc_Contribute:isValidate()
  self._ui.stc_SkillPoint:isValidate()
  self._ui.stc_Star:isValidate()
  self._ui.stc_EnchantCount:isValidate()
  self._ui.stc_SelfTimer:isValidate()
end
