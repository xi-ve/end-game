function FromClient_SA_Widget_Respon_Message_ReSizePanel()
  PaGlobal_SA_Widget_Respon_Message._ui.stc_responMessage:ComputePos()
  PaGlobal_SA_Widget_Respon_Message._ui.stc_icon:ComputePos()
  PaGlobal_SA_Widget_Respon_Message._ui.txt_responMessage:ComputePos()
end
function PaGlobal_SA_Widget_Respon_Message_ShowMessage(respawnTime)
  if nil == Panel_SA_Widget_Respon_Message then
    return
  end
  if nil == respawnTime then
    return
  end
  PaGlobal_SA_Widget_Respon_Message._respawnTime = respawnTime
  Panel_SA_Widget_Respon_Message:RegisterUpdateFunc("PaGlobal_SA_Widget_Respon_Message_Update")
  PaGlobal_SA_Widget_Respon_Message:prepareOpen()
end
function FromClient_SA_Widget_Respon_Message_HideMessage()
  if nil == Panel_SA_Widget_Respon_Message then
    return
  end
  PaGlobal_SA_Widget_Respon_Message._respawnTime = 10
  Panel_SA_Widget_Respon_Message:ClearUpdateLuaFunc()
  PaGlobal_SA_Widget_Respon_Message:prepareClose()
end
function PaGlobal_SA_Widget_Respon_Message_Update(deltaTime)
  if nil == Panel_SA_Widget_Respon_Message then
    return
  end
  if false == Panel_SA_Widget_Respon_Message:GetShow() then
    return
  end
  PaGlobal_SA_Widget_Respon_Message._respawnTime = PaGlobal_SA_Widget_Respon_Message._respawnTime - deltaTime
  if PaGlobal_SA_Widget_Respon_Message._respawnTime <= 0 then
    return
  end
  PaGlobal_SA_Widget_Respon_Message._updateCurrentTime = PaGlobal_SA_Widget_Respon_Message._updateCurrentTime + deltaTime
  if PaGlobal_SA_Widget_Respon_Message._updateCurrentTime >= 1 then
    local ceilRespawnTime = math.ceil(PaGlobal_SA_Widget_Respon_Message._respawnTime)
    PaGlobal_SA_Widget_Respon_Message._ui.txt_responMessage:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_SHADOWARENA_RESPON_MESSAGE", "second", ceilRespawnTime))
    PaGlobal_SA_Widget_Respon_Message._updateCurrentTime = 0
    return
  end
end
