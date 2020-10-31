PaGlobal_GuildChangeMark_All = {
  _ui = {
    stc_MainBg = nil,
    stc_TopBg = nil,
    stc_IconBg = nil,
    stc_MarkBg = nil,
    stc_BgTable = {},
    stc_CurBgEffect = nil,
    stc_CurIconEffect = nil,
    txt_GuildName = nil,
    stc_IconTable = {},
    stc_CurrentBg = nil,
    stc_CurrentMark = nil,
    stc_Bottom_KeyGuide = nil,
    stc_KeyGuides_A = nil,
    stc_KeyGuides_B = nil,
    stc_KeyGuides_Y = nil
  },
  _markBgUV = {
    [0] = {
      x1 = 0,
      y1 = 0,
      x2 = 1,
      y2 = 1
    },
    {
      x1 = 1,
      y1 = 1,
      x2 = 98,
      y2 = 98
    },
    {
      x1 = 99,
      y1 = 1,
      x2 = 196,
      y2 = 98
    },
    {
      x1 = 197,
      y1 = 1,
      x2 = 294,
      y2 = 98
    },
    {
      x1 = 295,
      y1 = 1,
      x2 = 392,
      y2 = 98
    },
    {
      x1 = 393,
      y1 = 1,
      x2 = 490,
      y2 = 98
    },
    {
      x1 = 1,
      y1 = 99,
      x2 = 98,
      y2 = 196
    },
    {
      x1 = 99,
      y1 = 99,
      x2 = 196,
      y2 = 196
    },
    {
      x1 = 197,
      y1 = 99,
      x2 = 294,
      y2 = 196
    },
    {
      x1 = 295,
      y1 = 99,
      x2 = 392,
      y2 = 196
    }
  },
  _markIconUV = {
    [0] = {
      x1 = 0,
      y1 = 0,
      x2 = 1,
      y2 = 1
    },
    {
      x1 = 1,
      y1 = 197,
      x2 = 98,
      y2 = 294
    },
    {
      x1 = 99,
      y1 = 197,
      x2 = 196,
      y2 = 294
    },
    {
      x1 = 197,
      y1 = 197,
      x2 = 294,
      y2 = 294
    },
    {
      x1 = 295,
      y1 = 197,
      x2 = 392,
      y2 = 294
    },
    {
      x1 = 393,
      y1 = 197,
      x2 = 490,
      y2 = 294
    },
    {
      x1 = 1,
      y1 = 295,
      x2 = 98,
      y2 = 392
    },
    {
      x1 = 99,
      y1 = 295,
      x2 = 196,
      y2 = 392
    },
    {
      x1 = 197,
      y1 = 295,
      x2 = 294,
      y2 = 392
    },
    {
      x1 = 295,
      y1 = 295,
      x2 = 392,
      y2 = 392
    }
  },
  _selectableCount = 9,
  _currentBgIdx = nil,
  _currentIconIdx = nil,
  _prevIconIdx = nil,
  _prevBgIdx = nil,
  _initialize = false
}
registerEvent("FromClient_luaLoadComplete", "FromClient_GuildChangeMark_All_Init")
function FromClient_GuildChangeMark_All_Init()
  PaGlobal_GuildChangeMark_All:initialize()
end
function PaGlobal_GuildChangeMark_All:initialize()
  if nil == Panel_GuildInfo_All or nil == Panel_GuildChangeMark_All then
    return
  end
  self._ui.stc_MainBg = UI.getChildControl(Panel_GuildChangeMark_All, "Static_CenterBg")
  self._ui.stc_TopBg = UI.getChildControl(self._ui.stc_MainBg, "Static_BG")
  self._ui.txt_GuildName = UI.getChildControl(self._ui.stc_MainBg, "StaticText_GuildName")
  self._ui.stc_IconBg = UI.getChildControl(self._ui.stc_MainBg, "Static_IconBg")
  self._ui.stc_CurIconEffect = UI.getChildControl(self._ui.stc_IconBg, "Static_FocusBg")
  for idx = 1, self._selectableCount do
    self._ui.stc_IconTable[idx] = UI.getChildControl(self._ui.stc_IconBg, "Static_Bg" .. tostring(idx))
  end
  self._ui.stc_MarkBg = UI.getChildControl(self._ui.stc_MainBg, "Static_BackgroundBg")
  self._ui.stc_CurBgEffect = UI.getChildControl(self._ui.stc_MarkBg, "Static_FocusBg")
  for idx = 1, self._selectableCount do
    self._ui.stc_BgTable[idx] = UI.getChildControl(self._ui.stc_MarkBg, "Static_Bg" .. tostring(idx))
  end
  self._ui.stc_CurrentBg = UI.getChildControl(self._ui.stc_MainBg, "Static_CurrentBg")
  self._ui.stc_CurrentMark = UI.getChildControl(self._ui.stc_MainBg, "Static_CurrentIcon")
  self._ui.stc_Bottom_KeyGuide = UI.getChildControl(Panel_GuildChangeMark_All, "Static_BottomBg")
  self._ui.stc_KeyGuides_A = UI.getChildControl(self._ui.stc_Bottom_KeyGuide, "StaticText_A_ConsoleUI")
  self._ui.stc_KeyGuides_B = UI.getChildControl(self._ui.stc_Bottom_KeyGuide, "StaticText_B_ConsoleUI")
  self._ui.stc_KeyGuides_Y = UI.getChildControl(self._ui.stc_Bottom_KeyGuide, "StaticText_Y_ConsoleUI")
  PaGlobal_GuildChangeMark_All:registerEvent()
  self._keyguide = {
    self._ui.stc_KeyGuides_Y,
    self._ui.stc_KeyGuides_A,
    self._ui.stc_KeyGuides_B
  }
  PaGlobalFunc_ConsoleKeyGuide_SetAlign(self._keyguide, self._ui.stc_Bottom_KeyGuide, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHT)
end
function PaGlobal_GuildChangeMark_All:validate()
  self._ui.stc_MainBg:isValidate()
  self._ui.stc_TopBg:isValidate()
  self._ui.stc_IconBg:isValidate()
  self._ui.stc_MarkBg:isValidate()
  self._ui.txt_GuildName:isValidate()
  self._ui.stc_CurrentBg:isValidate()
  self._ui.stc_CurrentMark:isValidate()
  self._ui.stc_Bottom_KeyGuide:isValidate()
  self._ui.stc_KeyGuides_A:isValidate()
  self._ui.stc_KeyGuides_B:isValidate()
  self._ui.stc_KeyGuides_Y:isValidate()
  self._ui.stc_CurIconEffect:isValidate()
  self._ui.stc_CurBgEffect:isValidate()
  for idx = 1, self._selectableCount do
    self._ui.stc_IconTable[idx]:isValidate()
    self._ui.stc_BgTable[idx]:isValidate()
  end
end
function PaGlobal_GuildChangeMark_All:registerEvent()
  PaGlobal_registerPanelOnBlackBackground(Panel_GuildChangeMark_All)
  for idx = 1, self._selectableCount do
    self._ui.stc_BgTable[idx]:registerPadEvent(__eConsoleUIPadEvent_A, "HandleEventPadPress_GuildChangeMark_All_SelectBg( " .. idx .. " )")
    self._ui.stc_IconTable[idx]:registerPadEvent(__eConsoleUIPadEvent_A, "HandleEventPadPress_GuildChangeMark_All_SelectIcon( " .. idx .. " )")
  end
end
function PaGlobal_GuildChangeMark_All:prepareOpen()
  PaGlobal_GuildChangeMark_All:open()
  PaGlobal_GuildChangeMark_All:update()
end
function PaGlobal_GuildChangeMark_All:update()
  local guildWrapper = ToClient_GetMyGuildInfoWrapper()
  if nil == guildWrapper then
    PaGlobal_GuildChangeMark_All:close()
    return
  end
  local data = getGuildMarkIndexByGuildNoForXBox(guildWrapper:getGuildNo_s64())
  self._currentIconIdx = data:getIconIdx()
  self._currentBgIdx = data:getBackGroundIdx()
  self._prevIconIdx = data:getIconIdx()
  self._prevBgIdx = data:getBackGroundIdx()
  HandleEventPadPress_GuildChangeMark_All_SelectBg(self._currentBgIdx)
  HandleEventPadPress_GuildChangeMark_All_SelectIcon(self._currentIconIdx)
  self._ui.txt_GuildName:SetText(guildWrapper:getName())
end
function PaGlobal_GuildChangeMark_All:open()
  Panel_GuildChangeMark_All:SetShow(true)
end
function PaGlobal_GuildChangeMark_All:prepareClose()
  PaGlobal_GuildChangeMark_All:close()
end
function PaGlobal_GuildChangeMark_All:close()
  Panel_GuildChangeMark_All:SetShow(false)
end
function PaGlobal_GuildChangeMark_All:isCanRegistMark()
  if self._prevBgIdx == self._currentBgIdx and self._prevIconIdx == self._currentIconIdx then
    Panel_GuildChangeMark_All:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "")
    self._ui.stc_KeyGuides_Y:SetShow(false)
  else
    Panel_GuildChangeMark_All:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "HandleEventPadPress_GuildChangeMark_All_MarkConfirm()")
    self._ui.stc_KeyGuides_Y:SetShow(true)
  end
  PaGlobalFunc_ConsoleKeyGuide_SetAlign(self._keyguide, self._ui.stc_Bottom_KeyGuide, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHT)
end
function PaGlobalFunc_GuildChangeMark_All_Open()
  PaGlobal_GuildChangeMark_All:prepareOpen()
end
function PaGlobalFunc_GuildChangeMark_All_Close()
  PaGlobal_GuildChangeMark_All:prepareClose()
end
function PaGlobalFunc_GuildMark_GetBackGroundUV(idx)
  if nil == PaGlobal_GuildChangeMark_All._markBgUV[idx] then
    return 0, 0, 0, 0
  end
  return PaGlobal_GuildChangeMark_All._markBgUV[idx].x1, PaGlobal_GuildChangeMark_All._markBgUV[idx].y1, PaGlobal_GuildChangeMark_All._markBgUV[idx].x2, PaGlobal_GuildChangeMark_All._markBgUV[idx].y2
end
function PaGlobalFunc_GuildMark_GetIconUV(idx)
  if nil == PaGlobal_GuildChangeMark_All._markIconUV[idx] then
    return 0, 0, 0, 0
  end
  return PaGlobal_GuildChangeMark_All._markIconUV[idx].x1, PaGlobal_GuildChangeMark_All._markIconUV[idx].y1, PaGlobal_GuildChangeMark_All._markIconUV[idx].x2, PaGlobal_GuildChangeMark_All._markIconUV[idx].y2
end
function PaGlobalFunc_GuildMark_SetGuildMarkControl(bgControl, iconControl, actorKey)
  if nil == actorKey then
    return
  end
  local iconIdx = 0
  local bgIdx = 0
  local idxData = getGuildMarkIndexByActorKeyForXBox(actorKey)
  if nil == idxData then
    return
  end
  iconIdx = idxData:getIconIdx()
  bgIdx = idxData:getBackGroundIdx()
  local markBgUV = PaGlobal_GuildChangeMark_All
  if nil ~= bgControl and 0 <= bgIdx and bgIdx <= PaGlobal_GuildChangeMark_All._selectableCount then
    bgControl:ChangeTextureInfoNameAsync("renewal/commonicon/guildmark/console_icon_guildmark_00.dds")
    local x1, y1, x2, y2 = setTextureUV_Func(bgControl, markBgUV._markBgUV[bgIdx].x1, markBgUV._markBgUV[bgIdx].y1, markBgUV._markBgUV[bgIdx].x2, markBgUV._markBgUV[bgIdx].y2)
    bgControl:getBaseTexture():setUV(x1, y1, x2, y2)
    bgControl:setRenderTexture(bgControl:getBaseTexture())
  end
  if nil ~= iconControl and 0 <= iconIdx and iconIdx <= PaGlobal_GuildChangeMark_All._selectableCount then
    iconControl:ChangeTextureInfoNameAsync("renewal/commonicon/guildmark/console_icon_guildmark_00.dds")
    local x1, y1, x2, y2 = setTextureUV_Func(iconControl, markBgUV._markIconUV[iconIdx].x1, markBgUV._markIconUV[iconIdx].y1, markBgUV._markIconUV[iconIdx].x2, markBgUV._markIconUV[iconIdx].y2)
    iconControl:getBaseTexture():setUV(x1, y1, x2, y2)
    iconControl:setRenderTexture(iconControl:getBaseTexture())
  end
end
function HandleEventPadPress_GuildChangeMark_All_SelectBg(idx)
  if nil == PaGlobal_GuildChangeMark_All._ui.stc_BgTable[idx] or nil == idx then
    return
  end
  PaGlobal_GuildChangeMark_All._ui.stc_CurBgEffect:SetShow(idx ~= 0)
  PaGlobal_GuildChangeMark_All._currentBgIdx = idx
  local curBg = PaGlobal_GuildChangeMark_All._ui.stc_BgTable[idx]
  PaGlobal_GuildChangeMark_All._ui.stc_CurBgEffect:SetSpanSize(curBg:GetSpanSize().x, curBg:GetSpanSize().y - 5)
  PaGlobal_GuildChangeMark_All._ui.stc_CurrentBg:ChangeTextureInfoName("renewal/commonicon/guildmark/console_icon_guildmark_00.dds")
  local markBgUV = PaGlobal_GuildChangeMark_All._markBgUV[idx]
  local x1, y1, x2, y2 = setTextureUV_Func(PaGlobal_GuildChangeMark_All._ui.stc_CurrentBg, markBgUV.x1, markBgUV.y1, markBgUV.x2, markBgUV.y2)
  PaGlobal_GuildChangeMark_All._ui.stc_CurrentBg:getBaseTexture():setUV(x1, y1, x2, y2)
  PaGlobal_GuildChangeMark_All._ui.stc_CurrentBg:setRenderTexture(PaGlobal_GuildChangeMark_All._ui.stc_CurrentBg:getBaseTexture())
  PaGlobal_GuildChangeMark_All:isCanRegistMark()
end
function HandleEventPadPress_GuildChangeMark_All_SelectIcon(idx)
  if nil == idx or nil == PaGlobal_GuildChangeMark_All._ui.stc_IconTable[idx] then
    return
  end
  PaGlobal_GuildChangeMark_All._ui.stc_CurIconEffect:SetShow(idx ~= 0)
  PaGlobal_GuildChangeMark_All._currentIconIdx = idx
  local curBg = PaGlobal_GuildChangeMark_All._ui.stc_IconTable[idx]
  PaGlobal_GuildChangeMark_All._ui.stc_CurIconEffect:SetSpanSize(curBg:GetSpanSize().x, curBg:GetSpanSize().y - 5)
  PaGlobal_GuildChangeMark_All._ui.stc_CurrentMark:ChangeTextureInfoName("renewal/commonicon/guildmark/console_icon_guildmark_00.dds")
  local markIconUV = PaGlobal_GuildChangeMark_All._markIconUV[idx]
  local x1, y1, x2, y2 = setTextureUV_Func(PaGlobal_GuildChangeMark_All._ui.stc_CurrentMark, markIconUV.x1, markIconUV.y1, markIconUV.x2, markIconUV.y2)
  PaGlobal_GuildChangeMark_All._ui.stc_CurrentMark:getBaseTexture():setUV(x1, y1, x2, y2)
  PaGlobal_GuildChangeMark_All._ui.stc_CurrentMark:setRenderTexture(PaGlobal_GuildChangeMark_All._ui.stc_CurrentMark:getBaseTexture())
  PaGlobal_GuildChangeMark_All:isCanRegistMark()
end
function HandleEventPadPress_GuildChangeMark_All_MarkConfirm()
  if PaGlobal_GuildChangeMark_All._currentBgIdx < 1 or 1 > PaGlobal_GuildChangeMark_All._currentIconIdx then
    local text = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_GUILDMARK_SELECTCORRECTMARK")
    Proc_ShowMessage_Ack(text)
    return
  end
  if PaGlobal_GuildChangeMark_All._prevBgIdx == PaGlobal_GuildChangeMark_All._currentBgIdx and PaGlobal_GuildChangeMark_All._prevIconIdx == PaGlobal_GuildChangeMark_All._currentIconIdx then
    return
  end
  local MarkConfirm = function()
    _AudioPostEvent_SystemUiForXBOX(50, 1)
    if true == PaGlobalFunc_GuildMain_All_GetBgShow(PaGlobal_GuildMain_All._eTABINDEX._ALLIANCE) then
      guildMarkUpdateForXBox(PaGlobal_GuildChangeMark_All._currentBgIdx, PaGlobal_GuildChangeMark_All._currentIconIdx, true)
    elseif true == PaGlobalFunc_GuildMain_All_GetBgShow(PaGlobal_GuildMain_All._eTABINDEX._BASIC) then
      guildMarkUpdateForXBox(PaGlobal_GuildChangeMark_All._currentBgIdx, PaGlobal_GuildChangeMark_All._currentIconIdx, false)
    end
    PaGlobal_GuildChangeMark_All:prepareClose()
  end
  PaGlobal_GuildMain_All:SetMsgDataAndShow(PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_ADDMARK_MESSAGEBOX_TITLE"), PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_ADDMARK_MESSAGEBOX_TEXT2"), MarkConfirm, MessageBox_Empty_function, nil, nil)
end
