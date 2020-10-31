function PaGlobal_ColorMix:initialize()
  if true == PaGlobal_ColorMix._initialize then
    return
  end
  self._isConsole = _ContentsGroup_UsePadSnapping
  self._ui.stc_titleBG = UI.getChildControl(Panel_Window_ColorMix_All, "Static_TitleBG")
  self._ui_pc.btn_close = UI.getChildControl(self._ui.stc_titleBG, "Button_Close")
  self._ui.stc_mainBG = UI.getChildControl(Panel_Window_ColorMix_All, "Static_MainBg")
  self._ui.stc_descBG = UI.getChildControl(Panel_Window_ColorMix_All, "Static_DescBG")
  self._ui.txt_desc = UI.getChildControl(Panel_Window_ColorMix_All, "StaticText_Desc")
  self._ui.stc_Arrow = UI.getChildControl(Panel_Window_ColorMix_All, "Static_ColorArrow")
  self._ui_pc.btn_mixColor = UI.getChildControl(Panel_Window_ColorMix_All, "Button_StartMix")
  for index = 1, self._slotCount do
    local createdSlot = {}
    local bg = UI.getChildControl(Panel_Window_ColorMix_All, "Static_SlotBG_" .. tostring(index))
    SlotItem.new(createdSlot, "ItemIconSlot" .. index, 0, bg, self._slotConfig)
    createdSlot:createChild()
    bg:SetIgnore(not self._isConsole)
    bg:addInputEvent("Mouse_On", "InputMOn_ColorMix_All_SetKeyGuideX(" .. index .. ")")
    createdSlot.icon:addInputEvent("Mouse_RUp", "InputMRUp_ColorMix_All_SlotRClick(" .. index .. ")")
    createdSlot.icon:addInputEvent("Mouse_On", "InputMOn_ColorMix_All_ShowTooltip(" .. index .. ")")
    createdSlot.icon:addInputEvent("Mouse_Out", "InputMOut_ColorMix_All_HideTooltip()")
    if index ~= self._slotCount then
      createdSlot.icon:addInputEvent("Mouse_LUp", "InputMLUp_ColorMix_All_DropHandler(" .. index .. ")")
    end
    createdSlot.icon:SetVerticalMiddle()
    createdSlot.icon:SetHorizonCenter()
    self._slotList[index] = createdSlot
  end
  self._ui_console.stc_keyGuideBG = UI.getChildControl(Panel_Window_ColorMix_All, "Static_KeyGuide_ConsoleUI")
  self._ui_console.stc_keyGuideX = UI.getChildControl(self._ui_console.stc_keyGuideBG, "StaticText_X_ConsoleUI")
  self._ui_console.stc_keyGuideY = UI.getChildControl(self._ui_console.stc_keyGuideBG, "StaticText_Y_ConsoleUI")
  self._keyguides = {
    self._ui_console.stc_keyGuideX,
    self._ui_console.stc_keyGuideY
  }
  PaGlobal_ColorMix:registEventHandler()
  self._ui.txt_desc:SetTextMode(__eTextMode_AutoWrap)
  self._ui.txt_desc:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_DYE_COLORBAL_DESC"))
  local gapY = self._ui.txt_desc:GetTextSizeY() - self._ui.txt_desc:GetSizeY()
  self._ui.stc_descBG:SetSize(self._ui.stc_descBG:GetSizeX(), self._ui.stc_descBG:GetSizeY() + gapY)
  self._ui.stc_mainBG:SetSize(self._ui.stc_mainBG:GetSizeX(), self._ui.stc_mainBG:GetSizeY() + gapY)
  Panel_Window_ColorMix_All:SetSize(Panel_Window_ColorMix_All:GetSizeX(), Panel_Window_ColorMix_All:GetSizeY() + gapY)
  self._ui_pc.btn_mixColor:ComputePos()
  PaGlobal_ColorMix:validate()
  PaGlobal_ColorMix:changePlatform()
  PaGlobal_ColorMix:alignKeyguides()
  PaGlobal_ColorMix._initialize = true
end
function PaGlobal_ColorMix:changePlatform()
  for _, control in pairs(self._ui_pc) do
    control:SetShow(not self._isConsole)
  end
  for _, control in pairs(self._ui_console) do
    control:SetShow(self._isConsole)
  end
end
function PaGlobal_ColorMix:registEventHandler()
  if nil == Panel_Window_ColorMix_All then
    return
  end
  Panel_Window_ColorMix_All:setGlassBackground(true)
  Panel_Window_ColorMix_All:ActiveMouseEventEffect(true)
  Panel_Window_ColorMix_All:RegisterShowEventFunc(true, "PaGlobal_ColorMix_ShowAni()")
  Panel_Window_ColorMix_All:RegisterShowEventFunc(false, "PaGlobal_ColorMix_HideAni()")
  registerEvent("FromClient_RenderModeChangeState", "FromClient_ColorMix_All_RestoreFlush")
  registerEvent("FromClient_ColorBalance_SlotUpdate", "FromClient_ColorMix_All_SlotUpdate")
  if self._isConsole then
    Panel_Window_ColorMix_All:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "InputMLUp_ColorMix_All_MixColor()")
  else
    self._ui_pc.btn_close:addInputEvent("Mouse_LUp", "PaGlobal_ColorMix_All_Clsoe()")
    self._ui_pc.btn_mixColor:addInputEvent("Mouse_LUp", "InputMLUp_ColorMix_All_MixColor()")
  end
end
function PaGlobal_ColorMix:prepareOpen()
  if nil == Panel_Window_ColorMix_All then
    return
  end
  audioPostEvent_SystemUi(1, 24)
  _AudioPostEvent_SystemUiForXBOX(1, 24)
  Panel_Window_ColorMix_All:SetPosX(getOriginScreenSizeX() / 2 - Panel_Window_ColorMix_All:GetSizeX() / 2)
  Panel_Window_ColorMix_All:SetPosY(getOriginScreenSizeY() / 2 - Panel_Window_ColorMix_All:GetSizeY() / 2)
  Inventory_SetFunctor(PaGlobal_ColorMix_All_InvenFilter_IsDyeItem, InputMRUp_ColorMix_All_InvenRClick, PaGlobal_ColorMix_All_Clsoe, nil)
  self:clearSlots()
  PaGlobal_ColorMix:open()
  InventoryWindow_Show()
end
function PaGlobal_ColorMix:open()
  if nil == Panel_Window_ColorMix_All then
    return
  end
  Panel_Window_ColorMix_All:SetShow(true, true)
end
function PaGlobal_ColorMix:prepareClose()
  if nil == Panel_Window_ColorMix_All then
    return
  end
  Inventory_SetFunctor(nil, nil, nil, nil)
  InventoryWindow_Close()
  PaGlobal_ColorMix:close()
end
function PaGlobal_ColorMix:close()
  if nil == Panel_Window_ColorMix_All then
    return
  end
  Panel_Window_ColorMix_All:SetShow(false, false)
end
function PaGlobal_ColorMix:validate()
  if nil == Panel_Window_ColorMix_All then
    return
  end
  self._ui.stc_titleBG:isValidate()
  self._ui_pc.btn_close:isValidate()
  self._ui.stc_mainBG:isValidate()
  self._ui.stc_descBG:isValidate()
  self._ui.txt_desc:isValidate()
  self._ui.stc_Arrow:isValidate()
  self._ui_pc.btn_mixColor:isValidate()
end
function PaGlobal_ColorMix:clearSlots()
  if nil == Panel_Window_ColorMix_All then
    return
  end
  for index = 1, self._slotCount do
    self._slotList[index]:clearItem()
    self._slotList[index].icon:SetShow(false)
  end
  self._ui.stc_Arrow:SetColor(Defines.Color.C_FFFFFFFF)
end
function PaGlobal_ColorMix:alignKeyguides()
  PaGlobalFunc_ConsoleKeyGuide_SetAlign(self._keyguides, self._ui_console.stc_keyGuideBG, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHT)
end
