local _panel = Panel_Window_GuildWarfareDesc_Renew
local GuildWarfareDesc = {
  _ui = {
    stc_MainArea = nil,
    frame_Desc = nil,
    frame_contents = nil,
    frame_verticalScroll = nil,
    txt_Desc = nil,
    stc_Bottom = nil,
    txt_KeyGuide_B = nil
  }
}
function GuildWarfareDesc:init()
  self._ui.stc_MainArea = UI.getChildControl(_panel, "Static_MainBG")
  self._ui.frame_Desc = UI.getChildControl(self._ui.stc_MainArea, "Frame_GuildWarfare")
  self._ui.frame_contents = UI.getChildControl(self._ui.frame_Desc, "Frame_1_Content")
  self._ui.frame_verticalScroll = UI.getChildControl(self._ui.frame_Desc, "Frame_1_VerticalScroll")
  self._ui.txt_Desc = UI.getChildControl(self._ui.frame_contents, "StaticText_Desc")
  self._ui.txt_Desc:SetTextMode(__eTextMode_AutoWrap)
  self._ui.txt_Desc:SetText(self._ui.txt_Desc:GetText())
  self._ui.frame_contents:SetSize(self._ui.frame_contents:GetSizeX(), self._ui.txt_Desc:GetTextSizeY())
  self._ui.txt_Desc:SetPosY(0)
  self._ui.stc_Bottom = UI.getChildControl(_panel, "Static_Console_Buttons")
  self._ui.txt_KeyGuide_B = UI.getChildControl(self._ui.stc_Bottom, "Button_B_ConsoleUI")
  PaGlobalFunc_ConsoleKeyGuide_SetAlign({
    self._ui.txt_KeyGuide_B
  }, self._ui.stc_Bottom, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHT)
end
function PaGlobalFunc_GuildWarfareDesc_Init()
  local self = GuildWarfareDesc
  self:init()
end
function PaGlobal_GuildWarfareDesc_Close()
  _panel:SetShow(false)
end
function PaGlobal_GuildWarfareDesc_Open()
  TooltipSimple_Hide()
  local self = GuildWarfareDesc
  self._ui.frame_verticalScroll:SetControlPos(0)
  self._ui.frame_Desc:UpdateContentScroll()
  self._ui.frame_Desc:UpdateContentPos()
  _panel:SetShow(true)
end
registerEvent("FromClient_luaLoadComplete", "PaGlobalFunc_GuildWarfareDesc_Init")
