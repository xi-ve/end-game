PaGlobal_ExtractionCrystal = {
  _slotConfig = {
    createIcon = false,
    createBorder = true,
    createCount = true,
    createEnchant = true,
    createCash = true
  },
  _config = {socketSlotCount = 3, curSlotCount = 3},
  _uiControl = {
    staticEquipSocket = UI.getChildControl(Panel_Window_Extraction_Crystal, "Static_ExtractionEquip_Socket"),
    staticSocket = {
      [1] = UI.getChildControl(Panel_Window_Extraction_Crystal, "Static_Socket_1"),
      [2] = UI.getChildControl(Panel_Window_Extraction_Crystal, "Static_Socket_2"),
      [3] = UI.getChildControl(Panel_Window_Extraction_Crystal, "Static_Socket_3")
    },
    stc_SocketDescGroup = {
      [1] = UI.getChildControl(Panel_Window_Extraction_Crystal, "Static_DescGroup_1"),
      [2] = UI.getChildControl(Panel_Window_Extraction_Crystal, "Static_DescGroup_2"),
      [3] = UI.getChildControl(Panel_Window_Extraction_Crystal, "Static_DescGroup_3")
    },
    staticSocketName = {
      UI.getChildControl(Panel_Window_Extraction_Crystal, "StaticText_NameTag_1"),
      UI.getChildControl(Panel_Window_Extraction_Crystal, "StaticText_NameTag_2"),
      UI.getChildControl(Panel_Window_Extraction_Crystal, "StaticText_NameTag_3")
    },
    staticSocketBackground = {
      UI.getChildControl(Panel_Window_Extraction_Crystal, "Static_Socket_1_Background"),
      UI.getChildControl(Panel_Window_Extraction_Crystal, "Static_Socket_2_Background"),
      UI.getChildControl(Panel_Window_Extraction_Crystal, "Static_Socket_3_Background")
    },
    staticSocketExtractionButton = {
      UI.getChildControl(Panel_Window_Extraction_Crystal, "Button_Extraction_Socket_1"),
      UI.getChildControl(Panel_Window_Extraction_Crystal, "Button_Extraction_Socket_2"),
      UI.getChildControl(Panel_Window_Extraction_Crystal, "Button_Extraction_Socket_3")
    },
    staticStuffSlotBG = {
      UI.getChildControl(Panel_Window_Extraction_Crystal, "Static_StuffSlot_1_Background"),
      UI.getChildControl(Panel_Window_Extraction_Crystal, "Static_StuffSlot_2_Background"),
      UI.getChildControl(Panel_Window_Extraction_Crystal, "Static_StuffSlot_3_Background")
    },
    staticStuffSlot = {
      UI.getChildControl(Panel_Window_Extraction_Crystal, "Static_StuffSlot_1"),
      UI.getChildControl(Panel_Window_Extraction_Crystal, "Static_StuffSlot_2"),
      UI.getChildControl(Panel_Window_Extraction_Crystal, "Static_StuffSlot_3")
    },
    buttonQuestion = UI.getChildControl(Panel_Window_Extraction_Crystal, "Button_Question")
  },
  _onlySocketListBG = {
    [1] = UI.getChildControl(Panel_Window_Extraction_Crystal, "Static_SocketBG_0"),
    [2] = UI.getChildControl(Panel_Window_Extraction_Crystal, "Static_SocketBG_1"),
    [3] = UI.getChildControl(Panel_Window_Extraction_Crystal, "Static_SocketBG_2")
  },
  _text = {
    [1] = PAGetString(Defines.StringSheet_GAME, "LUA_SOCKET_EMPTYSLOT")
  },
  _desc = {
    [1] = PAGetString(Defines.StringSheet_GAME, "LUA_EXTRACTION_CRYSTAL_SLOT_EMPTY")
  },
  _onlySocketBg = UI.getChildControl(Panel_Window_Extraction_Crystal, "Static_SocketListBG"),
  _uiEquipMain = nil,
  _uiSlotSocket = Array.new(),
  _uiSlotExtractionMaterial = Array.new(),
  _indexSocket,
  _extractionType,
  _stuffInvenType,
  _stuffSlotNo,
  _extractionGuide = UI.getChildControl(Panel_Window_Extraction_Crystal, "Static_ExtractionGuide"),
  _enchantNumber = UI.getChildControl(Panel_Window_Extraction_Crystal, "StaticText_Enchant_value"),
  _useSlot = {
    [1] = false,
    [2] = false,
    [3] = false
  },
  _save_ExtractionMateria_Slot_status = 0,
  _crystalKeys = {}
}
registerEvent("FromClient_luaLoadComplete", "LoadComplete_ExtractionCrystal_Initialize")
function LoadComplete_ExtractionCrystal_Initialize()
  PaGlobal_ExtractionCrystal:initialize()
end
function PaGlobal_ExtractionCrystal:initialize()
  Panel_Window_Extraction_Crystal:SetShow(false, false)
  self._uiControl.staticSocketDesc = {
    [1] = {
      UI.getChildControl(self._uiControl.stc_SocketDescGroup[1], "StaticText_Desc_1"),
      UI.getChildControl(self._uiControl.stc_SocketDescGroup[1], "StaticText_Desc_2"),
      UI.getChildControl(self._uiControl.stc_SocketDescGroup[1], "StaticText_Desc_3")
    },
    [2] = {
      UI.getChildControl(self._uiControl.stc_SocketDescGroup[2], "StaticText_Desc_1"),
      UI.getChildControl(self._uiControl.stc_SocketDescGroup[2], "StaticText_Desc_2"),
      UI.getChildControl(self._uiControl.stc_SocketDescGroup[2], "StaticText_Desc_3")
    },
    [3] = {
      UI.getChildControl(self._uiControl.stc_SocketDescGroup[3], "StaticText_Desc_1"),
      UI.getChildControl(self._uiControl.stc_SocketDescGroup[3], "StaticText_Desc_2"),
      UI.getChildControl(self._uiControl.stc_SocketDescGroup[3], "StaticText_Desc_3")
    }
  }
  Panel_Window_Extraction_Crystal:setMaskingChild(true)
  Panel_Window_Extraction_Crystal:setGlassBackground(true)
  if false == _ContentsGroup_NewUI_ExtractionFunction_All then
    Panel_Window_Extraction_Crystal:RegisterShowEventFunc(true, "ExtractionShowAni()")
    Panel_Window_Extraction_Crystal:RegisterShowEventFunc(false, "ExtractionHideAni()")
  end
  PaGlobal_ExtractionCrystal._enchantNumber:SetShow(false)
  self._uiControl.buttonQuestion:addInputEvent("Mouse_LUp", "Panel_WebHelper_ShowToggle( \"PanelWindowExtractionCrystal\" )")
  PaGlobal_Util_RegistHelpTooltipEvent(self._uiControl.buttonQuestion, "\"PanelWindowExtractionCrystal\"")
  for loopIndex, loopValue in ipairs(self._uiControl.staticSocketName) do
    loopValue:SetTextMode(__eTextMode_Limit_AutoWrap)
  end
  self._extractionGuide:SetTextMode(__eTextMode_AutoWrap)
  self._extractionGuide:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_EXTRACTION_CRYSTAL_EXTRACTIONGUIDE"))
  PaGlobal_ExtractionCrystal:createControl()
end
function PaGlobal_ExtractionCrystal:show(isShow)
  if isShow then
    PaGlobal_ExtractionCrystal:clearData()
    Panel_Window_Extraction_Crystal:SetShow(true, true)
    Panel_Window_Extraction_Crystal:SetPosY(getScreenSizeY() - getScreenSizeY() / 2 - Panel_Window_Extraction_Crystal:GetSizeY() / 2 - 20)
    Panel_Window_Extraction_Crystal:SetPosX(getScreenSizeX() - getScreenSizeX() / 2 - Panel_Window_Extraction_Crystal:GetSizeX() / 2)
  else
    Socket_ExtractionCrystal_WindowClose()
  end
end
function PaGlobal_ExtractionCrystal:hide()
  Socket_ExtractionCrystal_WindowClose()
end
function Socket_ExtractionCrystal_WindowClose()
  Inventory_SetFunctor(nil)
  Panel_Window_Extraction_Crystal:SetShow(false, false)
  PaGlobal_ExtractionCrystal:clearData()
end
