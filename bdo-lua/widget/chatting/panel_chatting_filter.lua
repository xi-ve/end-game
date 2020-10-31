local UI_color = Defines.Color
local UI_ANI_ADV = CppEnums.PAUI_ANIM_ADVANCE_TYPE
local IM = CppEnums.EProcessorInputMode
Panel_Chatting_Filter:RegisterShowEventFunc(true, "ChattingFilterList_ShowAni()")
Panel_Chatting_Filter:RegisterShowEventFunc(false, "ChattingFilterList_HideAni()")
Panel_Chatting_Filter:SetShow(false, false)
local ChattingFilter = {
  ui = {
    title_Area = UI.getChildControl(Panel_Chatting_Filter, "Static_TitleBg"),
    main_BG = UI.getChildControl(Panel_Chatting_Filter, "Static_MainBg"),
    btn_Close = nil,
    bg = UI.getChildControl(Panel_Chatting_Filter, "Static_BG"),
    edit_Filter = UI.getChildControl(Panel_Chatting_Filter, "Edit_Filter"),
    btn_Filter = UI.getChildControl(Panel_Chatting_Filter, "Button_Yes"),
    btn_Reset = UI.getChildControl(Panel_Chatting_Filter, "Button_Reset"),
    desc_stc = UI.getChildControl(Panel_Chatting_Filter, "Static_DescBG"),
    temp_FilterBG = UI.getChildControl(Panel_Chatting_Filter, "Static_SlotBG"),
    temp_Filter_ItemName = UI.getChildControl(Panel_Chatting_Filter, "StaticText_FilterName"),
    temp_Button_Delete = UI.getChildControl(Panel_Chatting_Filter, "Button_Delete"),
    scroll = UI.getChildControl(Panel_Chatting_Filter, "Scroll_List"),
    _keyGuideBG = nil,
    _keyGuideY = nil,
    _keyGuideB = nil,
    _keyGuideA = nil
  },
  config = {
    maxFilterCount = 8,
    totalFilterCount = 0,
    startIndex = 0
  },
  uiPool = {},
  _initialize = false
}
registerEvent("FromClient_luaLoadComplete", "FromClient_luaLoadComplete_ChattingFilter")
function FromClient_luaLoadComplete_ChattingFilter()
  ChattingFilter:Init()
end
function ChattingFilterList_ShowAni()
  local aniInfo1 = Panel_Chatting_Filter:addScaleAnimation(0, 0.08, UI_ANI_ADV.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfo1:SetStartScale(0.5)
  aniInfo1:SetEndScale(1.12)
  aniInfo1.AxisX = Panel_Chatting_Filter:GetSizeX() / 2
  aniInfo1.AxisY = Panel_Chatting_Filter:GetSizeY() / 2
  aniInfo1.ScaleType = 2
  aniInfo1.IsChangeChild = true
  local aniInfo2 = Panel_Chatting_Filter:addScaleAnimation(0.08, 0.15, UI_ANI_ADV.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfo2:SetStartScale(1.12)
  aniInfo2:SetEndScale(1)
  aniInfo2.AxisX = Panel_Chatting_Filter:GetSizeX() / 2
  aniInfo2.AxisY = Panel_Chatting_Filter:GetSizeY() / 2
  aniInfo2.ScaleType = 2
  aniInfo2.IsChangeChild = true
end
function ChattingFilterList_HideAni()
  audioPostEvent_SystemUi(1, 1)
  _AudioPostEvent_SystemUiForXBOX(1, 1)
  local aniInfo1 = Panel_Chatting_Filter:addColorAnimation(0, 0.1, UI_ANI_ADV.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
  aniInfo1:SetStartColor(UI_color.C_FFFFFFFF)
  aniInfo1:SetEndColor(UI_color.C_00FFFFFF)
  aniInfo1:SetStartIntensity(3)
  aniInfo1:SetEndIntensity(1)
  aniInfo1.IsChangeChild = true
  aniInfo1:SetHideAtEnd(true)
  aniInfo1:SetDisableWhileAni(true)
end
function ChattingFilter:Init()
  if true == self._initialize then
    return
  end
  for slotIdx = 0, self.config.maxFilterCount - 1 do
    self.uiPool[slotIdx] = {}
    local slot = self.uiPool[slotIdx]
    slot.FilterNameBG = UI.createAndCopyBasePropertyControl(Panel_Chatting_Filter, "Static_SlotBG", self.ui.bg, "ChattingFilter_BG_" .. slotIdx)
    slot.FilterName = UI.createAndCopyBasePropertyControl(Panel_Chatting_Filter, "StaticText_FilterName", slot.FilterNameBG, "ChattingFilter_FilterItemName_" .. slotIdx)
    slot.Delete = UI.createAndCopyBasePropertyControl(Panel_Chatting_Filter, "Button_Delete", slot.FilterNameBG, "ChattingFilter_FilterDeleteBtn_" .. slotIdx)
    slot.FilterNameBG:SetPosX(8)
    slot.FilterNameBG:SetPosY(5 + (slot.FilterNameBG:GetSizeY() + 5) * slotIdx)
    slot.FilterName:SetPosX(12)
    slot.FilterName:SetPosY(12)
    slot.Delete:SetPosX(340)
    slot.Delete:SetPosY(0)
    slot.FilterNameBG:SetShow(false)
    slot.FilterNameBG:addInputEvent("Mouse_UpScroll", "Scroll_ChattingFilterList( true )")
    slot.FilterNameBG:addInputEvent("Mouse_DownScroll", "Scroll_ChattingFilterList( false )")
    slot.FilterName:addInputEvent("Mouse_UpScroll", "Scroll_ChattingFilterList( true )")
    slot.FilterName:addInputEvent("Mouse_DownScroll", "Scroll_ChattingFilterList( false )")
    slot.Delete:addInputEvent("Mouse_UpScroll", "Scroll_ChattingFilterList( true )")
    slot.Delete:addInputEvent("Mouse_DownScroll", "Scroll_ChattingFilterList( false )")
    self.ui.temp_FilterBG:SetShow(false)
    self.ui.temp_Filter_ItemName:SetShow(false)
    self.ui.temp_Button_Delete:SetShow(false)
    self.ui.scroll:SetShow(false)
  end
  self.ui.title = UI.getChildControl(self.ui.title_Area, "StaticText_Title")
  self.ui.btn_Close = UI.getChildControl(self.ui.title_Area, "Button_Win_Close")
  self.ui.desc_Txt = UI.getChildControl(self.ui.desc_stc, "StaticText_Desc")
  self.ui._keyGuideBG = UI.getChildControl(Panel_Chatting_Filter, "Static_KeyGuide_ConsoleUI")
  self.ui._keyGuideY = UI.getChildControl(self.ui._keyGuideBG, "StaticText_Y_ConsoleUI")
  self.ui._keyGuideA = UI.getChildControl(self.ui._keyGuideBG, "StaticText_B_ConsoleUI")
  self.ui._keyGuideB = UI.getChildControl(self.ui._keyGuideBG, "StaticText_A_ConsoleUI")
  self:validate()
  self.ui.desc_Txt:SetTextMode(__eTextMode_AutoWrap)
  self.ui.desc_Txt:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_CHATTING_FILTER_DESC"))
  self.ui.edit_Filter:SetMaxInput(50)
  local descSizeY = self.ui.desc_Txt:GetTextSizeY() - self.ui.desc_Txt:GetSizeY() + 10
  if 0 < descSizeY then
    self.ui.desc_stc:SetSize(self.ui.desc_stc:GetSizeX(), self.ui.desc_stc:GetSizeY() + descSizeY)
    self.ui.main_BG:SetSize(self.ui.main_BG:GetSizeX(), self.ui.main_BG:GetSizeY() + descSizeY)
    self.ui.main_BG:ComputePos()
    Panel_Chatting_Filter:SetSize(Panel_Chatting_Filter:GetSizeX(), Panel_Chatting_Filter:GetSizeY() + descSizeY)
    self.ui.btn_Reset:ComputePos()
    self.ui.btn_Filter:ComputePos()
  end
  if true == _ContentsGroup_UsePadSnapping then
    local XIcon = UI.getChildControl(self.ui.edit_Filter, "StaticText_X_ConsoleUI")
    XIcon:SetShow(true)
    self.ui.btn_Reset:SetShow(false)
    self.ui.btn_Filter:SetShow(false)
    local buttonYSize = self.ui.btn_Filter:GetSizeY()
    Panel_Chatting_Filter:SetSize(Panel_Chatting_Filter:GetSizeX(), Panel_Chatting_Filter:GetSizeY() - buttonYSize)
    self.ui._keyGuideBG:SetShow(true)
    local keyGuideList = {
      self.ui._keyGuideY,
      self.ui._keyGuideA,
      self.ui._keyGuideB
    }
    PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyGuideList, self.ui._keyGuideBG, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHT)
  end
  ChattingFilter:registEventHandler()
  ChattingFilter:registMessageHandler()
  if true == ToClient_isTotalGameClient() then
    local chat = ToClient_getChattingPanel(0)
    if nil ~= chat then
      chat:setShowChatType(CppEnums.ChatType.Arsha, true)
    end
  end
  self._initialize = true
end
function ChattingFilter:validate()
  self.ui.title_Area:isValidate()
  self.ui.main_BG:isValidate()
  self.ui.bg:isValidate()
  self.ui.edit_Filter:isValidate()
  self.ui.btn_Filter:isValidate()
  self.ui.btn_Reset:isValidate()
  self.ui.desc_stc:isValidate()
  self.ui.temp_FilterBG:isValidate()
  self.ui.temp_Filter_ItemName:isValidate()
  self.ui.temp_Button_Delete:isValidate()
  self.ui.scroll:isValidate()
  self.ui._keyGuideBG:isValidate()
  self.ui._keyGuideY:isValidate()
  self.ui._keyGuideB:isValidate()
  self.ui._keyGuideA:isValidate()
end
function ChattingFilter:Update()
  for slotIdx = 0, self.config.maxFilterCount - 1 do
    local slot = self.uiPool[slotIdx]
    slot.FilterNameBG:SetShow(false)
    self.ui.scroll:SetShow(false)
    slot.Delete:addInputEvent("Mouse_LUp", "")
  end
  self.config.totalFilterCount = ToClient_getBlockStringListCount()
  if 0 >= self.config.totalFilterCount then
    return
  end
  if self.config.totalFilterCount <= self.config.maxFilterCount then
    self.config.startIndex = 0
    self.ui.scroll:SetControlPos(0)
  elseif self.config.totalFilterCount - self.config.startIndex < self.config.maxFilterCount then
    self.config.startIndex = self.config.totalFilterCount - self.config.maxFilterCount
  end
  if self.config.maxFilterCount < self.config.totalFilterCount then
    UIScroll.SetButtonSize(self.ui.scroll, self.config.maxFilterCount, self.config.totalFilterCount)
    self.ui.scroll:SetControlPos(self.config.startIndex / (self.config.totalFilterCount - self.config.maxFilterCount))
  else
    self.ui.scroll:SetShow(false)
  end
  local uiCount = 0
  for slotIdx = self.config.startIndex, self.config.totalFilterCount - 1 do
    if uiCount >= self.config.maxFilterCount then
      break
    end
    local slot = self.uiPool[uiCount]
    local filterStringGet = ToClient_getBlockStringListByIndex(slotIdx)
    slot.FilterNameBG:SetShow(true)
    slot.FilterName:SetTextMode(__eTextMode_LimitText)
    slot.FilterName:SetText(tostring(filterStringGet))
    slot.Delete:addInputEvent("Mouse_LUp", "HandleClicked_ChattingFilter_Delete(" .. slotIdx .. ")")
    uiCount = uiCount + 1
  end
end
function ChattingFilter:Open()
  Panel_Chatting_Filter:SetShow(true, true)
  local scrSizeX = getScreenSizeX()
  local scrSizeY = getScreenSizeY()
  local panelSizeX = Panel_Chatting_Filter:GetSizeX()
  local panelSizeY = Panel_Chatting_Filter:GetSizeY()
  Panel_Chatting_Filter:SetPosX(scrSizeX / 2 - panelSizeX / 2)
  Panel_Chatting_Filter:SetPosY(scrSizeY / 2 - panelSizeY / 2)
  self.ui.scroll:SetControlPos(0)
  self.config.startIndex = 0
  self.config.totalFilterCount = 0
  self:Update()
end
function ChattingFilter:Close()
  audioPostEvent_SystemUi(1, 1)
  _AudioPostEvent_SystemUiForXBOX(1, 1)
  Panel_Chatting_Filter:SetShow(false, false)
  self.ui.scroll:SetControlPos(0)
  self.config.startIndex = 0
  self.config.totalFilterCount = 0
end
function ChattingFilter_InsertFilterString()
  if true == _ContentsGroup_RenewUI then
    ClearFocusEdit()
  end
  local self = ChattingFilter
  local filterString = self.ui.edit_Filter:GetEditText()
  if false == ToClient_InsertBlockStringList(filterString) then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_CHATTING_FILTER_NOWORD_ACK"))
    self.ui.edit_Filter:SetEditText("", true)
    return
  end
  self.ui.edit_Filter:SetEditText("", true)
  self.config.totalFilterCount = ToClient_getBlockStringListCount()
  self.config.startIndex = math.max(self.config.totalFilterCount - self.config.maxFilterCount, 0)
  ChattingFilter:Update()
end
function ChattingFilter_ResetFilterString()
  ToClient_ClearBlockStringList()
  ChattingFilter:Update()
end
function Scroll_ChattingFilterList(isScrollUp)
  ChattingFilter.config.startIndex = UIScroll.ScrollEvent(ChattingFilter.ui.scroll, isScrollUp, ChattingFilter.config.maxFilterCount, ChattingFilter.config.totalFilterCount, ChattingFilter.config.startIndex, 1)
  ChattingFilter:Update()
end
function HandleClicked_ChattingFilter_EditName()
  ClearFocusEdit()
  SetFocusEdit(ChattingFilter.ui.edit_Filter)
  ChattingFilter.ui.edit_Filter:SetEditText("", true)
end
function FGlobal_ChattingFilter_ClearFocusEdit()
  ClearFocusEdit()
  CheckChattingInput()
end
function FGlobal_ChattingFilter_UiEdit(targetUI)
  return nil ~= targetUI and targetUI:GetKey() == ChattingFilter.ui.edit_Filter:GetKey()
end
function HandleClicked_ChattingFilter_Delete(index)
  ToClient_EraseBlockStringList(index)
  ChattingFilter:Update()
end
function HandleClicked_ChattingFilterList_Close()
  ChattingFilter:Close()
end
function FGlobal_ChattingFilterList_Open()
  ChattingFilter:Open()
end
function FGlobal_ChattingFilterList_Close()
  ChattingFilter:Close()
end
function ChattingFilter:registEventHandler()
  self.ui.btn_Close:addInputEvent("Mouse_LUp", "HandleClicked_ChattingFilterList_Close()")
  self.ui.bg:addInputEvent("Mouse_UpScroll", "Scroll_ChattingFilterList( true )")
  self.ui.bg:addInputEvent("Mouse_DownScroll", "Scroll_ChattingFilterList( false )")
  if true == _ContentsGroup_UsePadSnapping then
    Panel_Chatting_Filter:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "ChattingFilter_ResetFilterString()")
    self.ui.edit_Filter:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandleClicked_ChattingFilter_EditName()")
  else
    self.ui.btn_Filter:addInputEvent("Mouse_LUp", "ChattingFilter_InsertFilterString()")
    self.ui.btn_Reset:addInputEvent("Mouse_LUp", "ChattingFilter_ResetFilterString()")
    self.ui.edit_Filter:addInputEvent("Mouse_LUp", "HandleClicked_ChattingFilter_EditName()")
  end
  if true == _ContentsGroup_RenewUI then
    self.ui.edit_Filter:setXboxVirtualKeyBoardEndEvent("ChattingFilter_InsertFilterString")
  else
    self.ui.edit_Filter:RegistReturnKeyEvent("ChattingFilter_InsertFilterString()")
  end
  UIScroll.InputEvent(self.ui.scroll, "Scroll_ChattingFilterList")
end
function ChattingFilter:registMessageHandler()
end
