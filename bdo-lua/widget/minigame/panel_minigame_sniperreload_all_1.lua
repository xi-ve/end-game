function PaGlobal_MiniGame_SniperReload_All:initialize()
  if nil == Panel_MiniGame_SniperReload_All or true == PaGlobal_MiniGame_SniperReload_All._initialize then
    return
  end
  PaGlobal_MiniGame_SniperReload_All._ui.stc_BG = UI.getChildControl(Panel_MiniGame_SniperReload_All, "Static_BG")
  PaGlobal_MiniGame_SniperReload_All._ui.stc_reloadMark = UI.getChildControl(PaGlobal_MiniGame_SniperReload_All._ui.stc_BG, "Static_ReloadMark")
  PaGlobal_MiniGame_SniperReload_All._ui.stc_spaceBar = UI.getChildControl(Panel_MiniGame_SniperReload_All, "Static_SpaceBar")
  PaGlobal_MiniGame_SniperReload_All._ui.txt_leftTime = UI.getChildControl(Panel_MiniGame_SniperReload_All, "StaticText_LeftTime")
  PaGlobal_MiniGame_SniperReload_All._ui.txt_desc = UI.getChildControl(Panel_MiniGame_SniperReload_All, "StaticText_Desc")
  PaGlobal_MiniGame_SniperReload_All._ui.txt_desc:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_MINIGAME_SNIPERRELOAD_DESC"))
  PaGlobal_MiniGame_SniperReload_All:registerEventHandler()
  PaGlobal_MiniGame_SniperReload_All:validate()
  PaGlobal_MiniGame_SniperReload_All._initialize = true
end
function PaGlobal_MiniGame_SniperReload_All:registerEventHandler()
  if nil == Panel_MiniGame_SniperReload_All then
    return
  end
  registerEvent("onScreenResize", "FromClient_Minigame_Sniper_All_OnScreenSize")
end
function PaGlobal_MiniGame_SniperReload_All:prepareOpen()
  if nil == Panel_MiniGame_SniperReload_All then
    return
  end
  Panel_MiniGame_SniperReload_All:RegisterUpdateFunc("Panel_Minigame_UpdateFunc")
  FromClient_Minigame_Sniper_All_OnScreenSize()
  PaGlobal_MiniGame_SniperReload_All:calculateRemainTime()
  PaGlobal_MiniGame_SniperReload_All:open()
end
function PaGlobal_MiniGame_SniperReload_All:open()
  if nil == Panel_MiniGame_SniperReload_All or true == Panel_MiniGame_SniperReload_All:GetShow() then
    return
  end
  Panel_MiniGame_SniperReload_All:SetShow(true)
end
function PaGlobal_MiniGame_SniperReload_All:prepareClose()
  if nil == Panel_MiniGame_SniperReload_All or false == Panel_MiniGame_SniperReload_All:GetShow() then
    return
  end
  PaGlobal_MiniGame_SniperReload_All._theta = 0
  PaGlobal_MiniGame_SniperReload_All._remainTime = 5
  PaGlobal_MiniGame_SniperReload_All._ui.stc_reloadMark:ResetVertexAni()
  PaGlobal_MiniGame_SniperReload_All._ui.stc_reloadMark:SetColor(Defines.Color.C_FFFFFFFF)
  Panel_MiniGame_SniperReload_All:ClearUpdateLuaFunc()
  PaGlobal_MiniGame_SniperReload_All:close()
end
function PaGlobal_MiniGame_SniperReload_All:close()
  if nil == Panel_MiniGame_SniperReload_All or false == Panel_MiniGame_SniperReload_All:GetShow() then
    return
  end
  Panel_MiniGame_SniperReload_All:SetShow(false)
end
function PaGlobal_MiniGame_SniperReload_All:calculateRemainTime()
  local remainTimeRate = ToClient_SniperGame_GetReloadSpeedRate()
  PaGlobal_MiniGame_SniperReload_All._remainTime = 5 / remainTimeRate
end
function PaGlobal_MiniGame_SniperReload_All:validate()
  if nil == Panel_MiniGame_SniperReload_All then
    return
  end
  PaGlobal_MiniGame_SniperReload_All._ui.stc_BG:isValidate()
  PaGlobal_MiniGame_SniperReload_All._ui.stc_reloadMark:isValidate()
  PaGlobal_MiniGame_SniperReload_All._ui.stc_spaceBar:isValidate()
  PaGlobal_MiniGame_SniperReload_All._ui.txt_leftTime:isValidate()
  PaGlobal_MiniGame_SniperReload_All._ui.txt_desc:isValidate()
end
