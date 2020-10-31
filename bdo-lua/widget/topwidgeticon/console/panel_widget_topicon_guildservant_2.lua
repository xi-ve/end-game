function FromClient_TopIcon_GuildServant_Update()
  if nil == Panel_Widget_GuildServantIcon_Renew then
    return
  end
  PaGlobal_TopIcon_GuildServant:checkCondition()
end
function FromClient_TopIcon_GuildServant_Resize()
  if nil == Panel_Widget_GuildServantIcon_Renew then
    return
  end
  PaGlobal_TopIcon_GuildServant:onScreenResize()
end
