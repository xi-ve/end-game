PaGlobal_PersonalMonsterMessage_All = {
  _ui = {
    stc_BossMsgBg = nil,
    txt_BossMsgTitle = nil,
    txt_BossMsgDesc = nil,
    stc_OpenedMsgBg = nil,
    stc_OpenedMsgTitle = nil,
    stc_OpenedMsgDesc = nil
  },
  _time = 0,
  _isAlram = false,
  _initialize = false,
  _BossMsgEndTime = 12,
  _OpenedMsgEndTime = 9
}
registerEvent("FromClient_luaLoadComplete", "FromClient_PersonalMonsterMessage_ALL_Init")
function FromClient_PersonalMonsterMessage_ALL_Init()
  PaGlobal_PersonalMonsterMessage_All:initialize()
end
function PaGlobal_PersonalMonsterMessage_All:initialize()
  if true == self._initialize then
    return
  end
  self._ui.stc_BossMsgBg = UI.getChildControl(Panel_PersonalMonsterMessage_All, "Static_MsgBG")
  self._ui.txt_BossMsgTitle = UI.getChildControl(self._ui.stc_BossMsgBg, "StaticText_Title")
  self._ui.txt_BossMsgDesc = UI.getChildControl(self._ui.stc_BossMsgBg, "StaticText_Desc")
  self._ui.stc_OpenedMsgBg = UI.getChildControl(Panel_PersonalMonsterMessage_All, "Static_ImageArea")
  self._ui.stc_OpenedMsgTitle = UI.getChildControl(self._ui.stc_OpenedMsgBg, "StaticText_Title")
  self._ui.stc_OpenedMsgDesc = UI.getChildControl(self._ui.stc_OpenedMsgBg, "StaticText_Desc")
  self._ui.txt_BossMsgTitle:SetTextMode(__eTextMode_AutoWrap)
  self._ui.txt_BossMsgDesc:SetTextMode(__eTextMode_AutoWrap)
  self._ui.txt_BossMsgDesc:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_PERSONALMONSTER_MESSAGE"))
  PaGlobal_PersonalMonsterMessage_All:validate()
  PaGlobal_PersonalMonsterMessage_All:registerEvent()
  self._initialize = true
end
function PaGlobal_PersonalMonsterMessage_All:validate()
  self._ui.stc_BossMsgBg:isValidate()
  self._ui.txt_BossMsgTitle:isValidate()
  self._ui.txt_BossMsgDesc:isValidate()
  self._ui.stc_OpenedMsgBg:isValidate()
  self._ui.stc_OpenedMsgTitle:isValidate()
  self._ui.stc_OpenedMsgDesc:isValidate()
end
function PaGlobal_PersonalMonsterMessage_All:registerEvent()
  if true == _ContentsGroup_UsePadSnapping then
    registerEvent("FromClient_notifyReservePersonalMonster", "FromClient_PersonalMonsterMessage_ALL_NotifyMonster")
  end
  registerEvent("FromClient_notifySpawnPersonalMonster", "FromClient_PersonalMonsterMessage_ALL_SpawnMonster")
  registerEvent("onScreenResize", "FromClient_PersonalMonsterMessage_ALL_OnScreenResize")
  Panel_PersonalMonsterMessage_All:RegisterShowEventFunc(true, "PaGlobal_PersonalMonsterMessage_All:setAni(true)")
end
function PaGlobal_PersonalMonsterMessage_All:prepareOpen()
  if true == Panel_PersonalMonsterMessage_All:GetShow() then
    return
  end
  self._ui.stc_BossMsgBg:SetShow(not self._isAlram)
  self._ui.stc_OpenedMsgBg:SetShow(self._isAlram)
  PaGlobal_PersonalMonsterMessage_All:open()
  FromClient_PersonalMonsterMessage_ALL_OnScreenResize()
  Panel_PersonalMonsterMessage_All:RegisterUpdateFunc("FromClient_PersonalMonsterMessage_ALL_UpdatePerFrame")
  PaGlobal_PersonalMonsterMessage_All:update()
end
function PaGlobal_PersonalMonsterMessage_All:open()
  Panel_PersonalMonsterMessage_All:SetShow(true)
end
function PaGlobal_PersonalMonsterMessage_All:update()
  if true == self._isAlram then
    local AlramIMG = self._ui.stc_OpenedMsgBg:addColorAnimation(0, 0.5, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
    AlramIMG:SetStartColor(Defines.Color.C_00000000)
    AlramIMG:SetEndColor(Defines.Color.C_FFFFFFFF)
    AlramIMG.IsChangeChild = true
    AlramIMG = self._ui.stc_OpenedMsgBg:addColorAnimation(5, 10, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
    AlramIMG:SetStartColor(Defines.Color.C_FFFFFFFF)
    AlramIMG:SetEndColor(Defines.Color.C_00000000)
    AlramIMG.IsChangeChild = true
    audioPostEvent_SystemUi(25, 0)
  else
    ToClient_ShakeCamera(0.1, 50, 0.5, 2)
    local personalMonsterMessage = self._ui.stc_BossMsgBg:addColorAnimation(0, 0.5, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
    personalMonsterMessage:SetStartColor(Defines.Color.C_00000000)
    personalMonsterMessage:SetEndColor(Defines.Color.C_FFFFFFFF)
    personalMonsterMessage.IsChangeChild = true
    local personalMonsterMessage2 = self._ui.stc_BossMsgBg:addColorAnimation(8, 30, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
    personalMonsterMessage2:SetStartColor(Defines.Color.C_FFFFFFFF)
    personalMonsterMessage2:SetEndColor(Defines.Color.C_00000000)
    personalMonsterMessage2.IsChangeChild = true
    audioPostEvent_SystemUi(25, 1)
    self._ui.stc_BossMsgBg:EraseAllEffect()
    self._ui.stc_BossMsgBg:AddEffect("fUI_Personal_Monster_Descovery_01A", true, 0, 0)
  end
end
function PaGlobal_PersonalMonsterMessage_All:prepareClose()
  if false == Panel_PersonalMonsterMessage_All:GetShow() then
    return
  end
  Panel_PersonalMonsterMessage_All:ClearUpdateLuaFunc()
  self._time = 0
  PaGlobal_PersonalMonsterMessage_All:close()
end
function PaGlobal_PersonalMonsterMessage_All:close()
  Panel_PersonalMonsterMessage_All:SetShow(false)
end
function FromClient_PersonalMonsterMessage_ALL_NotifyMonster()
  if true == Panel_PersonalMonsterMessage_All:GetShow() then
    return
  end
  if true == ToClient_IsInstanceFieldPlayerbyContentsType(__eInstanceContentsType_SavageDefence) then
    return
  end
  if 0 ~= ToClient_GetMyTeamNoLocalWar() then
    return
  end
  if ToClient_getPlayNowSavageDefence() then
    return
  end
  if ToClient_IsMyselfInArena() then
    return
  end
  PaGlobal_PersonalMonsterMessage_All._isAlram = true
  PaGlobal_PersonalMonsterMessage_All:prepareOpen()
end
function FromClient_PersonalMonsterMessage_ALL_SpawnMonster(notUse, notUse)
  if true == Panel_PersonalMonsterMessage_All:GetShow() then
    return
  end
  PaGlobal_PersonalMonsterMessage_All._isAlram = false
  PaGlobal_PersonalMonsterMessage_All:prepareOpen()
end
function FromClient_PersonalMonsterMessage_ALL_UpdatePerFrame(deltaTime)
  if false == Panel_PersonalMonsterMessage_All:GetShow() then
    return
  end
  local self = PaGlobal_PersonalMonsterMessage_All
  self._time = self._time + deltaTime
  if false == self._isAlram then
    if self._BossMsgEndTime < self._time then
      PaGlobal_PersonalMonsterMessage_All:prepareClose()
    end
  elseif self._OpenedMsgEndTime < self._time then
    PaGlobal_PersonalMonsterMessage_All:prepareClose()
  end
end
function FromClient_PersonalMonsterMessage_ALL_OnScreenResize()
  if false == Panel_PersonalMonsterMessage_All:GetShow() then
    return
  end
  local self = PaGlobal_PersonalMonsterMessage_All
  Panel_PersonalMonsterMessage_All:SetSize(getScreenSizeX(), getScreenSizeY())
  Panel_PersonalMonsterMessage_All:ComputePos()
  self._ui.stc_OpenedMsgBg:ComputePos()
  self._ui.stc_BossMsgBg:ComputePos()
  self._ui.stc_OpenedMsgBg:SetPosXY(getScreenSizeX() - (self._ui.stc_OpenedMsgBg:GetSizeX() + 30), getScreenSizeY() - (self._ui.stc_OpenedMsgBg:GetSizeY() + 100))
end
