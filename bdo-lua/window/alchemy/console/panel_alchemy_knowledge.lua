local AlchemyKnowledge = {
  _panel = Panel_Widget_Knowledge,
  _ui = {
    image,
    title,
    desc,
    bottomGroup
  },
  defaultPanelSizeX = 400,
  defaultTitleSizeX = 280,
  defaultTitleSizeY = 30,
  defaultDescSizeX = 340
}
function AlchemyKnowledge:init()
  self._ui.image = UI.getChildControl(self._panel, "Static_KnowledgeImage")
  self._ui.title = UI.getChildControl(self._panel, "StaticText_Title")
  self._ui.title:SetTextMode(__eTextMode_AutoWrap)
  self._ui.desc = UI.getChildControl(self._panel, "StaticText_UserInfoDec")
  self._ui.desc:SetTextMode(__eTextMode_AutoWrap)
  self._ui.bottomGroup = UI.getChildControl(self._panel, "Static_BottomBg")
  self._ui.keyGuide = UI.getChildControl(self._ui.bottomGroup, "StaticText_B_ConsoleUI")
  self.keyGuidebtnGroup = {
    self._ui.keyGuide
  }
  self._panel:ignorePadSnapMoveToOtherPanel()
end
function PaGlobalFunc_AlchemyKnowledge_Init()
  AlchemyKnowledge:init()
end
function AlchemyKnowledge:checkShow()
  return self._panel:GetShow()
end
function PaGlobalFunc_AlchemyKnowledgeCheckShow()
  return AlchemyKnowledge:checkShow()
end
function AlchemyKnowledge:open(knowledge)
  if self:checkShow() then
    return
  end
  local learnFlag = isLearnMentalCardForAlchemy(knowledge:getKey())
  self._ui.image:ChangeTextureInfoName(knowledge:getImagePath())
  local x1, y1, x2, y2 = setTextureUV_Func(self._ui.image, 0, 0, 360, 360)
  self._ui.image:getBaseTexture():setUV(x1, y1, x2, y2)
  self._ui.image:setRenderTexture(self._ui.image:getBaseTexture())
  self._ui.title:SetTextMode(__eTextMode_None)
  if true == _ContentsGroup_NewUI_Manufacture_All then
    self._ui.title:SetText(knowledge:getName())
  else
    self._ui.title:SetText(learnFlag and knowledge:getName() or "???")
  end
  local tempSizeX = 0
  self._ui.title:SetSize(self.defaultTitleSizeX, self._ui.title:GetSizeY())
  self._ui.title:SetTextMode(__eTextMode_AutoWrap)
  self._ui.title:SetText(self._ui.title:GetText())
  if 2 <= self._ui.title:GetLineCount() then
    local gap = self._ui.title:GetTextSizeY() - self.defaultTitleSizeY
    self._ui.title:SetPosY(self._ui.image:GetPosY())
    self._ui.title:SetSize(self.defaultTitleSizeX, self.defaultTitleSizeY + gap)
    self._ui.desc:SetPosY(self._ui.title:GetPosY() + self._ui.title:GetSizeY())
  else
    self._ui.title:ComputePos()
    self._ui.title:SetSize(self.defaultTitleSizeX, self.defaultTitleSizeY)
    self._ui.desc:ComputePos()
  end
  self._panel:SetSize(self.defaultPanelSizeX + tempSizeX, self._panel:GetSizeY())
  self._ui.desc:SetSize(self.defaultDescSizeX + tempSizeX, self._ui.desc:GetSizeY())
  self._ui.title:SetText(self._ui.title:GetText())
  self._ui.desc:SetText(knowledge:getDesc())
  self._ui.desc:SetFontColor(learnFlag and Defines.Color.C_FF84FFF5 or Defines.Color.C_FF888888)
  self._ui.bottomGroup:SetPosY(self._ui.desc:GetPosY() + self._ui.desc:GetTextSizeY())
  self._panel:SetSize(self._panel:GetSizeX(), self._ui.bottomGroup:GetPosY() + self._ui.bottomGroup:GetSizeY())
  self._panel:SetPosX((getScreenSizeX() - self._panel:GetSizeX()) / 2)
  self._panel:SetPosY((getScreenSizeY() - self._panel:GetSizeY()) / 2)
  PaGlobalFunc_ConsoleKeyGuide_SetAlign(self.keyGuidebtnGroup, self._panel, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHT)
  self._panel:SetShow(true)
end
function PaGlobalFunc_AlchemyKnowledgeOpen(knowledge)
  AlchemyKnowledge:open(knowledge)
  TooltipSimple_Hide()
end
function AlchemyKnowledge:close()
  if not self:checkShow() then
    return
  end
  _AudioPostEvent_SystemUiForXBOX(50, 3)
  self._panel:SetShow(false)
  return true
end
function PaGlobalFunc_AlchemyKnowledgeClose()
  AlchemyKnowledge:close()
end
registerEvent("FromClient_luaLoadComplete", "PaGlobalFunc_AlchemyKnowledge_Init")
