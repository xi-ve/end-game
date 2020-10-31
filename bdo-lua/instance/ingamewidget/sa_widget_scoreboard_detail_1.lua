function PaGlobal_SA_Widget_ScoreBoard_Detail:initialize()
  if true == PaGlobal_SA_Widget_ScoreBoard_Detail._initialize then
    return
  end
  local battleResult = UI.getChildControl(Panel_SA_Widget_ScoreBoard_Detail, "Static_BattleResult")
  self._ui.txt_ResultTitle = UI.getChildControl(battleResult, "StaticText_BattleResultTile")
  local killEnemy = UI.getChildControl(battleResult, "StaticText_BattleLog_1")
  self._ui.txt_killEnemy = UI.getChildControl(killEnemy, "StaticText_BattleLog1_Value")
  local survivalTime = UI.getChildControl(battleResult, "StaticText_BattleLog_2")
  self._ui.txt_survivalTime = UI.getChildControl(survivalTime, "StaticText_BattleLog1_Value")
  local addDamage = UI.getChildControl(battleResult, "StaticText_BattleLog_3")
  self._ui.txt_addDamage = UI.getChildControl(addDamage, "StaticText_BattleLog1_Value")
  local receivedDamage = UI.getChildControl(battleResult, "StaticText_BattleLog_4")
  self._ui.txt_receivedDamage = UI.getChildControl(receivedDamage, "StaticText_BattleLog1_Value")
  local killMonster = UI.getChildControl(battleResult, "StaticText_BattleLog_5")
  self._ui.txt_killMonster = UI.getChildControl(killMonster, "StaticText_BattleLog1_Value")
  local totalScore = UI.getChildControl(battleResult, "StaticText_BattleLog_Total")
  self._ui.txt_totalScore = UI.getChildControl(totalScore, "StaticText_BattleLog1_Value")
  local battleSilver = UI.getChildControl(Panel_SA_Widget_ScoreBoard_Detail, "Static_BattleSilver")
  local survivalReward = UI.getChildControl(battleSilver, "StaticText_SurvivalReward")
  survivalReward:SetShow(false)
  self._ui.txt_rankBonus = UI.getChildControl(survivalReward, "StaticText_Survival_Value")
  local totalSilver = UI.getChildControl(battleSilver, "StaticText_SilverLog_Total")
  self._ui.txt_silver = UI.getChildControl(totalSilver, "StaticText_BattleLog1_Value")
  local sliverLog = UI.getChildControl(battleSilver, "StaticText_SilverLog")
  self._ui.txt_whiteCont = UI.getChildControl(sliverLog, "StaticText_GetItem_1")
  self._ui.txt_whiteSilver = UI.getChildControl(sliverLog, "StaticText_Silverl")
  self._ui.stc_whiteDecoLine = UI.getChildControl(sliverLog, "Static_DecoLine1")
  self._ui.txt_greenCont = UI.getChildControl(sliverLog, "StaticText_GetItem2")
  self._ui.txt_greenSilver = UI.getChildControl(sliverLog, "StaticText_Silver_2")
  self._ui.stc_greenDecoLine = UI.getChildControl(sliverLog, "Static_DecoLine2")
  self._ui.txt_blueCont = UI.getChildControl(sliverLog, "StaticText_GetItem3")
  self._ui.txt_blueSilver = UI.getChildControl(sliverLog, "StaticText_Silver_3")
  self._ui.stc_blueDecoLine = UI.getChildControl(sliverLog, "Static_DecoLine3")
  self._ui.txt_yellowCont = UI.getChildControl(sliverLog, "StaticText_GetItem4")
  self._ui.txt_yellowSilver = UI.getChildControl(sliverLog, "StaticText_Silver_4")
  self._ui.stc_yellowDecoLine = UI.getChildControl(sliverLog, "Static_DecoLine4")
  self._ui.txt_orangeCont = UI.getChildControl(sliverLog, "StaticText_GetItem5")
  self._ui.txt_orangeSilver = UI.getChildControl(sliverLog, "StaticText_Silver_5")
  self._ui.txt_notice = UI.getChildControl(battleSilver, "StaticText_Notice")
  self._ui.stc_bottomButtonBG = UI.getChildControl(Panel_SA_Widget_ScoreBoard_Detail, "Static_BottomButtonBG")
  self._ui.btn_watching = UI.getChildControl(self._ui.stc_bottomButtonBG, "Button_Watching")
  self._ui.btn_exit = UI.getChildControl(self._ui.stc_bottomButtonBG, "Button_Exit")
  self:registEventHandler()
  self:validate()
  self._initialize = true
end
function PaGlobal_SA_Widget_ScoreBoard_Detail:registEventHandler()
  if nil == Panel_SA_Widget_ScoreBoard_Detail then
    return
  end
  registerEvent("onScreenResize", "FromClient_SA_Widget_ScoreBoard_Detail_ReSizePanel")
  registerEvent("EventSelfPlayerDead", "PaGlobal_SA_Widget_ScoreBoard_Detail_PlayerDead")
  registerEvent("FromClient_BattleRoyaleWinner", "FromClient_SA_Widget_ScoreBoard_Detail_PlayEnd")
  registerEvent("FromClient_BattleRoyaleRecord", "FromClient_SA_Widget_ScoreBoard_Detail_Record")
  self._ui.btn_watching:addInputEvent("Mouse_LUp", "HandleEventLUp_SA_Widget_ScoreBoard_Detail_ObserverMode()")
  self._ui.btn_exit:addInputEvent("Mouse_LUp", "HandleEventLUp_SA_Widget_ScoreBoard_Detail_ExitButton()")
end
function PaGlobal_SA_Widget_ScoreBoard_Detail:prepareOpen()
  if nil == Panel_SA_Widget_ScoreBoard_Detail then
    return
  end
  PaGlobal_SA_Widget_ScoreBoard_Detail:open()
end
function PaGlobal_SA_Widget_ScoreBoard_Detail:open()
  if nil == Panel_SA_Widget_ScoreBoard_Detail then
    return
  end
  Panel_SA_Widget_ScoreBoard_Detail:SetShow(true)
end
function PaGlobal_SA_Widget_ScoreBoard_Detail:prepareClose()
  if nil == Panel_SA_Widget_ScoreBoard_Detail then
    return
  end
  PaGlobal_SA_Widget_ScoreBoard_Detail:close()
end
function PaGlobal_SA_Widget_ScoreBoard_Detail:close()
  if nil == Panel_SA_Widget_ScoreBoard_Detail then
    return
  end
  Panel_SA_Widget_ScoreBoard_Detail:SetShow(false)
end
function PaGlobal_SA_Widget_ScoreBoard_Detail:update()
  if nil == Panel_SA_Widget_ScoreBoard_Detail then
    return
  end
end
function PaGlobal_SA_Widget_ScoreBoard_Detail:validate()
  if nil == Panel_SA_Widget_ScoreBoard_Detail then
    return
  end
  self._ui.txt_ResultTitle:isValidate()
  self._ui.txt_killEnemy:isValidate()
  self._ui.txt_survivalTime:isValidate()
  self._ui.txt_addDamage:isValidate()
  self._ui.txt_receivedDamage:isValidate()
  self._ui.txt_killMonster:isValidate()
  self._ui.txt_totalScore:isValidate()
  self._ui.txt_rankBonus:isValidate()
  self._ui.txt_silver:isValidate()
  self._ui.txt_whiteCont:isValidate()
  self._ui.txt_whiteSilver:isValidate()
  self._ui.txt_greenCont:isValidate()
  self._ui.txt_greenSilver:isValidate()
  self._ui.txt_blueCont:isValidate()
  self._ui.txt_blueSilver:isValidate()
  self._ui.txt_yellowCont:isValidate()
  self._ui.txt_yellowSilver:isValidate()
  self._ui.txt_orangeCont:isValidate()
  self._ui.txt_orangeSilver:isValidate()
  self._ui.txt_notice:isValidate()
  self._ui.stc_bottomButtonBG:isValidate()
  self._ui.btn_watching:isValidate()
  self._ui.btn_exit:isValidate()
end
function PaGlobal_SA_Widget_ScoreBoard_Detail:updateMyData()
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  local gameStateString = "\236\164\145\234\176\132 \234\178\176\234\179\188"
  if true == self._isGameEnd then
    gameStateString = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SA_WIDGET_SCOREBOARD_RESURT")
  end
  self._ui.txt_ResultTitle:SetText(gameStateString)
  self._ui.txt_killEnemy:SetText(self._myData.pkCount)
  self._ui.txt_killMonster:SetText(self._myData.mkCount)
  self._ui.txt_addDamage:SetText(makeDotMoney(self._myData.hit))
  self._ui.txt_receivedDamage:SetText(makeDotMoney(self._myData.damage))
  self._ui.txt_totalScore:SetText(makeDotMoney(self._myData.score))
  local time = Int64toInt32(self._myData.servivalTime)
  local minute = math.floor(time / 60)
  local second = math.floor(time % 60)
  local surviveTimeString = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_BATTLEROYAL_RESULT_TIME", "minute", minute, "second", second)
  self._ui.txt_survivalTime:SetText(surviveTimeString)
  local rewardIndex
  local rewardItemKey = __eTItemEnchantKeyUndefined
  local isRewardable = ToClient_CheckToRewardBattleRoyale()
  local modeNo = ToClient_GetBattleRoyaleModeNo()
  if __eBattleRoyaleMode_PrivateSolo == modeNo or __eBattleRoyaleMode_PrivateTeam == modeNo then
    isRewardable = false
  end
  if true == isRewardable or 1 == self._myData.rank then
    rewardItemKey = ToClient_BattleRoyaleRankReward(__eBattleRoyaleRankReward_Normal, self._myData.rank)
  end
  local itemSS = getItemEnchantStaticStatus(ItemEnchantKey(rewardItemKey))
  if 720255 == rewardItemKey then
    rewardIndex = 4
  elseif 720254 == rewardItemKey then
    rewardIndex = 3
  elseif 720253 == rewardItemKey then
    rewardIndex = 2
  elseif 720252 == rewardItemKey then
    rewardIndex = 1
  elseif 720251 == rewardItemKey then
    rewardIndex = 0
  end
  if nil ~= itemSS then
    self._ui.txt_rankBonus:SetFontColor(ConvertFromItemGradeColor(rewardIndex))
    self._ui.txt_rankBonus:SetText(itemSS:getName())
  else
    self._ui.txt_rankBonus:SetFontColor(ConvertFromItemGradeColor(0))
    self._ui.txt_rankBonus:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_INSTANCE_RESULT_NOITEM"))
  end
  local normalItemCount = 0
  local magicItemCount = 0
  local rareItemCount = 0
  local uniqueItemCount = 0
  local epicItemCount = 0
  if false == ToClient_GetBattleRoyaleLeaveFlag() then
    normalItemCount = ToClient_GetDropItemCountOnBattleRoyale(__eItemGradeNormal)
    magicItemCount = ToClient_GetDropItemCountOnBattleRoyale(__eItemGradeMagic)
    rareItemCount = ToClient_GetDropItemCountOnBattleRoyale(__eItemGradeRare)
    uniqueItemCount = ToClient_GetDropItemCountOnBattleRoyale(__eItemGradeUnique)
    epicItemCount = ToClient_GetDropItemCountOnBattleRoyale(__eItemGradeEpic)
  end
  local showItemCnt = 0
  self:showItemControl(false)
  if 0 < normalItemCount then
    self._ui.txt_whiteCont:SetText(PAGetStringParam2(Defines.StringSheet_GAME, "LUA_BATTLEROYAL_RESULT_WHITEITEM", "price", self._whiteItemPrice, "count", normalItemCount))
    self._ui.txt_whiteSilver:SetText(makeDotMoney(normalItemCount * self._whiteItemPrice))
    self._ui.txt_whiteCont:SetShow(true)
    self._ui.txt_whiteSilver:SetShow(true)
    self._ui.stc_whiteDecoLine:SetShow(true)
    showItemCnt = showItemCnt + 1
  end
  if 0 < magicItemCount then
    self._ui.txt_greenCont:SetText(PAGetStringParam2(Defines.StringSheet_GAME, "LUA_BATTLEROYAL_RESULT_GREENITEM", "price", self._greenItemPrice, "count", magicItemCount))
    self._ui.txt_greenSilver:SetText(makeDotMoney(magicItemCount * self._greenItemPrice))
    showItemCnt = showItemCnt + 1
    PaGlobal_SA_Widget_ScoreBoard_Detail:itemControlSetSpanSize(self._ui.txt_greenCont, self._ui.txt_greenSilver, self._ui.stc_greenDecoLine, showItemCnt)
  end
  if 0 < rareItemCount then
    self._ui.txt_blueCont:SetText(PAGetStringParam2(Defines.StringSheet_GAME, "LUA_BATTLEROYAL_RESULT_BLUEITEM", "price", self._blueItemPrice, "count", rareItemCount))
    self._ui.txt_blueSilver:SetText(makeDotMoney(rareItemCount * self._blueItemPrice))
    showItemCnt = showItemCnt + 1
    PaGlobal_SA_Widget_ScoreBoard_Detail:itemControlSetSpanSize(self._ui.txt_blueCont, self._ui.txt_blueSilver, self._ui.stc_blueDecoLine, showItemCnt)
  end
  if 0 < uniqueItemCount then
    self._ui.txt_yellowCont:SetText(PAGetStringParam2(Defines.StringSheet_GAME, "LUA_BATTLEROYAL_RESULT_YELLOWITEM", "price", self._yellowItemPrice, "count", uniqueItemCount))
    self._ui.txt_yellowSilver:SetText(makeDotMoney(uniqueItemCount * self._yellowItemPrice))
    showItemCnt = showItemCnt + 1
    PaGlobal_SA_Widget_ScoreBoard_Detail:itemControlSetSpanSize(self._ui.txt_yellowCont, self._ui.txt_yellowSilver, self._ui.stc_yellowDecoLine, showItemCnt)
  end
  if 0 < epicItemCount then
  end
  local rewardGoldValue = normalItemCount * self._whiteItemPrice + magicItemCount * self._greenItemPrice + rareItemCount * self._blueItemPrice + uniqueItemCount * self._yellowItemPrice + epicItemCount * self._orangeItemPrice
  local strRewardGoldValue = makeDotMoney(rewardGoldValue)
  if 1 == self._myData.rank then
    strRewardGoldValue = strRewardGoldValue .. " + @"
  end
  self._ui.txt_silver:SetText(strRewardGoldValue)
end
function PaGlobal_SA_Widget_ScoreBoard_Detail:itemControlSetSpanSize(cntControl, silverControl, decoControl, idx)
  cntControl:SetShow(true)
  silverControl:SetShow(true)
  decoControl:SetShow(true)
  local linePadding = 25
  local controlPadding = 10
  local basicSpanY = 25
  local spanY = linePadding * idx + controlPadding * idx
  cntControl:SetSpanSize(cntControl:GetSpanSize().x, spanY)
  silverControl:SetSpanSize(silverControl:GetSpanSize().x, spanY)
  if nil == decoControl then
    return
  end
  decoControl:SetSpanSize(decoControl:GetSpanSize().x, spanY + linePadding)
end
function PaGlobal_SA_Widget_ScoreBoard_Detail:showItemControl(isShow)
  self._ui.txt_whiteCont:SetShow(isShow)
  self._ui.txt_whiteSilver:SetShow(isShow)
  self._ui.stc_whiteDecoLine:SetShow(isShow)
  self._ui.txt_greenCont:SetShow(isShow)
  self._ui.txt_greenSilver:SetShow(isShow)
  self._ui.stc_greenDecoLine:SetShow(isShow)
  self._ui.txt_blueCont:SetShow(isShow)
  self._ui.txt_blueSilver:SetShow(isShow)
  self._ui.stc_blueDecoLine:SetShow(isShow)
  self._ui.txt_yellowCont:SetShow(isShow)
  self._ui.txt_yellowSilver:SetShow(isShow)
  self._ui.stc_yellowDecoLine:SetShow(isShow)
  self._ui.txt_orangeCont:SetShow(isShow)
  self._ui.txt_orangeSilver:SetShow(isShow)
end
