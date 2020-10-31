function PaGlobal_ThornCastle_Summon_Notify:initialize()
  if true == PaGlobal_ThornCastle_Summon_Notify._initialize then
    return
  end
  self._ui._textMain[ThornCastleSummonTeamType.FRIENDLY] = UI.getChildControl(Panel_Widget_ThornCastle_Nak_Sub_Friendly, "StaticText_MainText")
  self._ui._textSub[ThornCastleSummonTeamType.FRIENDLY] = UI.getChildControl(Panel_Widget_ThornCastle_Nak_Sub_Friendly, "StaticText_SubText")
  self._ui._smallIcon[ThornCastleSummonTeamType.FRIENDLY] = UI.getChildControl(Panel_Widget_ThornCastle_Nak_Sub_Friendly, "Static_Icon_SmallMonster")
  self._ui._mediumIcon[ThornCastleSummonTeamType.FRIENDLY] = UI.getChildControl(Panel_Widget_ThornCastle_Nak_Sub_Friendly, "Static_Icon_MidiumMonster")
  self._ui._largeIcon[ThornCastleSummonTeamType.FRIENDLY] = UI.getChildControl(Panel_Widget_ThornCastle_Nak_Sub_Friendly, "Static_Icon_BigMonster")
  self._ui._portalIcon[ThornCastleSummonTeamType.FRIENDLY] = UI.getChildControl(Panel_Widget_ThornCastle_Nak_Sub_Friendly, "Static_Icon_Portal")
  self._ui._textMain[ThornCastleSummonTeamType.ENEMY] = UI.getChildControl(Panel_Widget_ThornCastle_Nak_Sub_Enemy, "StaticText_MainText")
  self._ui._textSub[ThornCastleSummonTeamType.ENEMY] = UI.getChildControl(Panel_Widget_ThornCastle_Nak_Sub_Enemy, "StaticText_SubText")
  self._ui._smallIcon[ThornCastleSummonTeamType.ENEMY] = UI.getChildControl(Panel_Widget_ThornCastle_Nak_Sub_Enemy, "Static_Icon_SmallMonster")
  self._ui._mediumIcon[ThornCastleSummonTeamType.ENEMY] = UI.getChildControl(Panel_Widget_ThornCastle_Nak_Sub_Enemy, "Static_Icon_MidiumMonster")
  self._ui._largeIcon[ThornCastleSummonTeamType.ENEMY] = UI.getChildControl(Panel_Widget_ThornCastle_Nak_Sub_Enemy, "Static_Icon_BigMonster")
  self._ui._portalIcon[ThornCastleSummonTeamType.ENEMY] = UI.getChildControl(Panel_Widget_ThornCastle_Nak_Sub_Enemy, "Static_Icon_Portal")
  self._ui._smallTextMain[ThornCastleSummonTeamType.FRIENDLY] = "LUA_THORNCASTLE_NAK_00_MAIN"
  self._ui._smallTextSub[ThornCastleSummonTeamType.FRIENDLY] = "LUA_THORNCASTLE_NAK_00_SUB"
  self._ui._mediumTextMain[ThornCastleSummonTeamType.FRIENDLY] = "LUA_THORNCASTLE_NAK_01_MAIN"
  self._ui._mediumTextsub[ThornCastleSummonTeamType.FRIENDLY] = "LUA_THORNCASTLE_NAK_01_SUB"
  self._ui._largeTextMain[ThornCastleSummonTeamType.FRIENDLY] = "LUA_THORNCASTLE_NAK_02_MAIN"
  self._ui._largeTextsub[ThornCastleSummonTeamType.FRIENDLY] = "LUA_THORNCASTLE_NAK_02_SUB"
  self._ui._portalTextMain[ThornCastleSummonTeamType.FRIENDLY] = "LUA_THORNCASTLE_NAK_03_MAIN"
  self._ui._portalTextsub[ThornCastleSummonTeamType.FRIENDLY] = "LUA_THORNCASTLE_NAK_03_SUB"
  self._ui._smallTextMain[ThornCastleSummonTeamType.ENEMY] = "LUA_THORNCASTLE_NAK_00_MAIN_ENEMY"
  self._ui._smallTextSub[ThornCastleSummonTeamType.ENEMY] = "LUA_THORNCASTLE_NAK_00_SUB_ENEMY"
  self._ui._mediumTextMain[ThornCastleSummonTeamType.ENEMY] = "LUA_THORNCASTLE_NAK_01_MAIN_ENEMY"
  self._ui._mediumTextsub[ThornCastleSummonTeamType.ENEMY] = "LUA_THORNCASTLE_NAK_01_SUB_ENEMY"
  self._ui._largeTextMain[ThornCastleSummonTeamType.ENEMY] = "LUA_THORNCASTLE_NAK_02_MAIN_ENEMY"
  self._ui._largeTextsub[ThornCastleSummonTeamType.ENEMY] = "LUA_THORNCASTLE_NAK_02_SUB_ENEMY"
  self._ui._portalTextMain[ThornCastleSummonTeamType.ENEMY] = "LUA_THORNCASTLE_NAK_04_MAIN"
  self._ui._portalTextsub[ThornCastleSummonTeamType.ENEMY] = "LUA_THORNCASTLE_NAK_04_SUB"
  self._ui._bossIcon = UI.getChildControl(Panel_Widget_ThornCastle_Nak_Sub_Boss, "Static_Icon_SmallMonster")
  self._ui._bossTextMain = UI.getChildControl(Panel_Widget_ThornCastle_Nak_Sub_Boss, "StaticText_MainText")
  self._ui._pointText = UI.getChildControl(Panel_Widget_ThornCastle_Nak_Point, "StaticText_MainText")
  PaGlobal_ThornCastle_Summon_Notify:registEventHandler()
  PaGlobal_ThornCastle_Summon_Notify:validate()
  PaGlobal_ThornCastle_Summon_Notify._initialize = true
end
local MessageOpen = function(ShowPannel)
  local self = PaGlobal_ThornCastle_Summon_Notify
  if nil == self then
    return
  end
  local UI_ANI_ADV = CppEnums.PAUI_ANIM_ADVANCE_TYPE
  local UI_color = Defines.Color
  local axisY = 0
  ShowPannel:ResetAndClearVertexAni()
  if true == ToClient_isUsePadSnapping() then
    ShowPannel:SetSize(math.max(_text_Msg:GetTextSizeX() + 40, _defaultXSize), _text_Msg:GetTextSizeY() + 20)
  end
  local aniInfo = ShowPannel:addColorAnimation(0, 0.15, UI_ANI_ADV.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
  aniInfo:SetStartColor(UI_color.C_00FFFFFF)
  aniInfo:SetEndColor(UI_color.C_FFFFFFFF)
  aniInfo.IsChangeChild = true
  if false == ToClient_isUsePadSnapping() then
    local aniInfo1 = ShowPannel:addScaleAnimation(0, 3.15, UI_ANI_ADV.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
    aniInfo1:SetStartScale(0.85)
    aniInfo1:SetEndScale(1)
    aniInfo1.AxisY = axisY
    aniInfo1.ScaleType = 2
    aniInfo1.IsChangeChild = true
    local aniInfo2 = ShowPannel:addScaleAnimation(0.15, self._showTime - 0.15, UI_ANI_ADV.PAUI_ANIM_ADVANCE_SIN_PI)
    aniInfo2:SetStartScale(1)
    aniInfo2:SetEndScale(1)
    aniInfo2.AxisY = axisY
    aniInfo2.ScaleType = 2
    aniInfo2.IsChangeChild = true
  end
  local aniInfo3 = ShowPannel:addColorAnimation(self._showTime - 0.15, self._showTime, UI_ANI_ADV.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfo3:SetStartColor(UI_color.C_FFFFFFFF)
  aniInfo3:SetEndColor(UI_color.C_00FFFFFF)
  aniInfo3.IsChangeChild = true
  if false == ToClient_isUsePadSnapping() then
    local aniInfo4 = ShowPannel:addScaleAnimation(self._showTime - 0.15, self._showTime, UI_ANI_ADV.PAUI_ANIM_ADVANCE_COS_HALF_PI)
    aniInfo4:SetStartScale(1)
    aniInfo4:SetEndScale(0.7)
    aniInfo4.AxisY = axisY
    aniInfo4.ScaleType = 2
    aniInfo4.IsChangeChild = true
  end
end
function PaGlobal_ThornCastle_Summon_Notify:validate()
  if nil == Panel_Thorn_Nak_Sub_Friendly then
    return
  end
  if nil == Panel_Thorn_Nak_Sub_Enemy then
    return
  end
  for ii = 1, 2 do
    self._ui._textMain[ii]:isValid()
    self._ui._textSub[ii]:isValid()
    self._ui._smallIcon[ii]:isValid()
    self._ui._mediumIcon[ii]:isValid()
    self._ui._largeIcon[ii]:isValid()
    self._ui._portalIcon[ii]:isValid()
    self._ui._smallTextMain[ii]:isValid()
    self._ui._smallTextSub[ii]:isValid()
    self._ui._mediumTextMain[ii]:isValid()
    self._ui._mediumTextsub[ii]:isValid()
    self._ui._largeTextMain[ii]:isValid()
    self._ui._largeTextsub[ii]:isValid()
    self._ui._portalTextMain[ii]:isValid()
    self._ui._portalTextsub[ii]:isValid()
  end
  self._ui._bossIcon:isValid()
  self._ui._bossTextMain:isValid()
  self._ui._pointText:isValid()
end
function PaGlobal_ThornCastle_Summon_Notify:registEventHandler()
  if nil == Panel_Widget_ThornCastle_Nak_Sub_Friendly or nil == Panel_Widget_ThornCastle_Nak_Sub_Enemy or nil == Panel_Widget_ThornCastle_Nak_Sub_Boss or nil == Panel_Widget_ThornCastle_Nak_Point or nil == Panel_Widget_ThornCastle_Nak_Main then
    return
  end
  if nil == Panel_Widget_ThornCastle_Nak_Sub_Enemy then
    return
  end
  registerEvent("FromClient_ThornCastleNotifySummon", "FromClient_Widget_ThornCastle_Summon_Notify")
  registerEvent("FromClient_ThornCastleNotifyBossSummon", "FromClient_Widget_ThornCastle_Summon_Boss_Notify")
  registerEvent("FromClient_Widget_ThornCastle_Point_Notify", "FromClient_Widget_ThornCastle_Point_Notify")
  registerEvent("FromClient_Widget_ThornCastle_Start_Notify", "FromClient_Widget_ThornCastle_Start_Notify")
end
function PaGlobal_ThornCastle_Summon_Notify:SummonMonsterNotify(summonType, isFriendlyMonster)
  if nil == Panel_Widget_ThornCastle_Nak_Sub_Friendly then
    return
  end
  if nil == Panel_Widget_ThornCastle_Nak_Sub_Enemy then
    return
  end
  local friendlyIndex = 0
  if true == isFriendlyMonster then
    friendlyIndex = 1
  else
    friendlyIndex = 2
  end
  self._ui._textMain[friendlyIndex]:SetText("")
  self._ui._textSub[friendlyIndex]:SetText("")
  self._ui._smallIcon[friendlyIndex]:SetShow(false)
  self._ui._mediumIcon[friendlyIndex]:SetShow(false)
  self._ui._largeIcon[friendlyIndex]:SetShow(false)
  self._ui._portalIcon[friendlyIndex]:SetShow(false)
  if ThornCastleSummonType.SMALL == summonType then
    self._ui._textMain[friendlyIndex]:SetText(PAGetString(Defines.StringSheet_GAME, self._ui._smallTextMain[friendlyIndex]))
    self._ui._textSub[friendlyIndex]:SetText(PAGetString(Defines.StringSheet_GAME, self._ui._smallTextSub[friendlyIndex]))
    self._ui._smallIcon[friendlyIndex]:SetShow(true)
  elseif ThornCastleSummonType.MEDIUM == summonType then
    self._ui._textMain[friendlyIndex]:SetText(PAGetString(Defines.StringSheet_GAME, self._ui._mediumTextMain[friendlyIndex]))
    self._ui._textSub[friendlyIndex]:SetText(PAGetString(Defines.StringSheet_GAME, self._ui._mediumTextsub[friendlyIndex]))
    self._ui._mediumIcon[friendlyIndex]:SetShow(true)
  elseif ThornCastleSummonType.LARGE == summonType then
    self._ui._textMain[friendlyIndex]:SetText(PAGetString(Defines.StringSheet_GAME, self._ui._largeTextMain[friendlyIndex]))
    self._ui._textSub[friendlyIndex]:SetText(PAGetString(Defines.StringSheet_GAME, self._ui._largeTextsub[friendlyIndex]))
    self._ui._largeIcon[friendlyIndex]:SetShow(true)
  elseif ThornCastleSummonType.PORTAL == summonType then
    self._ui._textMain[friendlyIndex]:SetText(PAGetString(Defines.StringSheet_GAME, self._ui._portalTextMain[friendlyIndex]))
    self._ui._textSub[friendlyIndex]:SetText(PAGetString(Defines.StringSheet_GAME, self._ui._portalTextsub[friendlyIndex]))
    self._ui._portalIcon[friendlyIndex]:SetShow(true)
  end
  if true == isFriendlyMonster then
    MessageOpen(Panel_Widget_ThornCastle_Nak_Sub_Friendly)
    Panel_Widget_ThornCastle_Nak_Sub_Friendly:SetShow(true)
  else
    MessageOpen(Panel_Widget_ThornCastle_Nak_Sub_Enemy)
    Panel_Widget_ThornCastle_Nak_Sub_Enemy:SetShow(true)
  end
end
function PaGlobal_ThornCastle_Summon_Notify:SummonBossNotify(bossActorKey)
  if nil == Panel_Widget_ThornCastle_Nak_Sub_Boss then
    return
  end
  local staticStatusWrapper = getCharacterStaticStatusWarpper(bossActorKey)
  local bossName = "Boss"
  if nil ~= staticStatusWrapper then
    bossName = staticStatusWrapper:getName()
  end
  self._ui._bossTextMain:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_THORNCASTLE_BOSS_MAIN", "name", bossName))
  MessageOpen(Panel_Widget_ThornCastle_Nak_Sub_Boss)
  Panel_Widget_ThornCastle_Nak_Sub_Boss:SetShow(true)
end
function PaGlobal_ThornCastle_Summon_Notify:StartNotify()
  if nil == Panel_Widget_ThornCastle_Nak_Main then
    return
  end
  MessageOpen(Panel_Widget_ThornCastle_Nak_Main)
  Panel_Widget_ThornCastle_Nak_Main:SetShow(true)
end
function PaGlobal_ThornCastle_Summon_Notify:PointNotify(point)
  if nil == Panel_Widget_ThornCastle_Nak_Point then
    return
  end
  self._ui._pointText:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_THORNCASTLE_POINT", "point", point))
  MessageOpen(Panel_Widget_ThornCastle_Nak_Point)
  Panel_Widget_ThornCastle_Nak_Point:SetShow(true)
end
function PaGlobal_ThornCastle_Summon_Notify:MaxPointNotify()
  if nil == Panel_Widget_ThornCastle_Nak_Point then
    return
  end
  Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoMaxOthilitaPersonalPoint"))
end
function FromClient_Widget_ThornCastle_Summon_Notify(summonType, isFriendlyMonster)
  if false == PaGlobal_ThornCastle_Summon_Notify._initialize then
    return
  end
  PaGlobal_ThornCastle_Summon_Notify:SummonMonsterNotify(summonType, isFriendlyMonster)
end
function FromClient_Widget_ThornCastle_Summon_Boss_Notify(bossActorKey)
  if false == PaGlobal_ThornCastle_Summon_Notify._initialize then
    return
  end
  PaGlobal_ThornCastle_Summon_Notify:SummonBossNotify(bossActorKey)
end
function FromClient_Widget_ThornCastle_Point_Notify(point)
  if false == PaGlobal_ThornCastle_Summon_Notify._initialize then
    return
  end
  PaGlobal_ThornCastle_Summon_Notify:PointNotify(point)
end
function FromClient_Widget_ThornCastle_Start_Notify()
  if false == PaGlobal_ThornCastle_Summon_Notify._initialize then
    return
  end
  PaGlobal_ThornCastle_Summon_Notify:StartNotify()
end
function FromClient_Widget_ThornCastle_MaxPoint_Notify()
  if false == PaGlobal_ThornCastle_Summon_Notify._initialize then
    return
  end
  PaGlobal_ThornCastle_Summon_Notify:MaxPointNotify()
end
