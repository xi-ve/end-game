function HandleEventLUp_GuildWarfare_IconToolTip_Show(iconNo, isOn)
  local mouse_posX = getMousePosX()
  local mouse_posY = getMousePosY()
  local panel_posX = PaGlobal_GuildMain_All._ui.stc_Warfare_Bg:GetParentPosX()
  local panel_posY = PaGlobal_GuildMain_All._ui.stc_Warfare_Bg:GetParentPosY()
  local _iconHelper = PaGlobal_GuildWarfare_All._ui.txt_IconHelper
  if iconNo == 1 then
    _iconHelper:SetShow(true)
    _iconHelper:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_TXT_WARFARE_HELP_COMMAND"))
  elseif iconNo == 2 then
    _iconHelper:SetShow(true)
    _iconHelper:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_TXT_WARFARE_HELP_TOWER"))
  elseif iconNo == 3 then
    _iconHelper:SetShow(true)
    _iconHelper:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_TXT_WARFARE_HELP_DOOR"))
  elseif iconNo == 4 then
    _iconHelper:SetShow(true)
    _iconHelper:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_TXT_WARFARE_HELP_SUMMON"))
  elseif iconNo == 5 then
    _iconHelper:SetShow(true)
    _iconHelper:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_TXT_WARFARE_HELP_OBJECT"))
  elseif iconNo == 6 then
    _iconHelper:SetShow(true)
    _iconHelper:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_TXT_WARFARE_HELP_MEMBER"))
  elseif iconNo == 7 then
    _iconHelper:SetShow(true)
    _iconHelper:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_TXT_WARFARE_HELP_DEATH"))
  elseif iconNo == 8 then
    _iconHelper:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_WARFARE_RIDEMACHINE_KILL"))
  end
  _iconHelper:SetSize(_iconHelper:GetTextSizeX() + 20, _iconHelper:GetSizeY())
  _iconHelper:SetPosX(mouse_posX - panel_posX)
  _iconHelper:SetPosY(mouse_posY - panel_posY + 15)
  _iconHelper:SetShow(isOn)
end
function HandleEventLUp_GuildWarfare_Select_SortType(sortType)
  PaGlobal_GuildWarfare_All:selectSortType(sortType)
end
function PaGlobalFunc_GuildWarfare_All_Update()
  PaGlobal_GuildWarfare_All:initGuildListSort()
  PaGlobal_GuildWarfare_All:update()
  ToClient_padSnapChangeToTarget(PaGlobal_GuildWarfare_All._ui.txt_CharName)
  PaGlobal_GuildWarfare_All_ResetScrollData()
end
function PaGlobal_GuildWarfare_CreateContents_All(contents, key)
  PaGlobal_GuildWarfare_All:createListContents(contents, key)
end
function PaGlobal_GuildWarfare_All_ResetScrollData()
  PaGlobal_GuildWarfare_All._scrollData._pos = nil
  PaGlobal_GuildWarfare_All._scrollData._idx = nil
end
function Panel_GuildWarfare_All_SaveScrollData()
  PaGlobal_GuildWarfare_All._scrollData._pos = PaGlobal_GuildWarfare_All._ui.list2_Warfare:GetVScroll():GetControlPos()
  PaGlobal_GuildWarfare_All._scrollData._idx = PaGlobal_GuildWarfare_All._ui.list2_Warfare:getCurrenttoIndex()
end
function PaGlobal_GuildWarfare_All_LoadScrollData()
  if nil == PaGlobal_GuildWarfare_All._scrollData._pos or nil == PaGlobal_GuildWarfare_All._scrollData._idx then
    return
  end
  PaGlobal_GuildWarfare_All._ui.list2_Warfare:GetVScroll():SetControlPos(PaGlobal_GuildWarfare_All._scrollData._pos)
  PaGlobal_GuildWarfare_All._ui.list2_Warfare:setCurrenttoIndex(PaGlobal_GuildWarfare_All._scrollData._idx)
end
