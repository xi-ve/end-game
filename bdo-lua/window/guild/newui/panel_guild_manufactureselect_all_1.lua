function PaGlobal_Guild_ManufactureSelect_All:initialize()
  if true == PaGlobal_Guild_ManufactureSelect_All._initialize or nil == Panel_Guild_ManufactureSelect_All then
    return
  end
  self._ui.stc_titleArea = UI.getChildControl(Panel_Guild_ManufactureSelect_All, "Static_TitleArea")
  self._ui.btn_close = UI.getChildControl(self._ui.stc_titleArea, "Button_Close")
  self._ui.stc_mainArea = UI.getChildControl(Panel_Guild_ManufactureSelect_All, "Static_MainArea")
  self._ui.btn_deposit = UI.getChildControl(Panel_Guild_ManufactureSelect_All, "Button_Deposit")
  self._ui.stc_descEdge = UI.getChildControl(Panel_Guild_ManufactureSelect_All, "Static_DescEdge")
  self._ui.stc_slotBG = UI.getChildControl(self._ui.stc_mainArea, "Static_SlotBG")
  self._ui.txt_desc = UI.getChildControl(self._ui.stc_descEdge, "StaticText_Desc")
  self._ui.stc_keyguideBG = UI.getChildControl(Panel_Guild_ManufactureSelect_All, "Static_KeyGuide_ConsoleUI")
  self._ui.txt_keyGuideA = UI.getChildControl(self._ui.stc_keyguideBG, "StaticText_A_ConsoleUI")
  self._ui.txt_keyGuideB = UI.getChildControl(self._ui.stc_keyguideBG, "StaticText_B_ConsoleUI")
  for ii = 1, #PaGlobal_Guild_ManufactureSelect_All._categoryList do
    PaGlobal_Guild_ManufactureSelect_All._category[ii] = {
      _title = nil,
      _slot = Array.new(),
      _slotCount = 0
    }
    local titleText = UI.getChildControl(PaGlobal_Guild_ManufactureSelect_All._ui.stc_mainArea, "StaticText_Category" .. ii)
    titleText:SetText(PaGlobal_Guild_ManufactureSelect_All._categoryList[ii])
    PaGlobal_Guild_ManufactureSelect_All._category[ii]._title = titleText
  end
  PaGlobal_Guild_ManufactureSelect_All._isConsole = _ContentsGroup_UsePadSnapping
  PaGlobal_Guild_ManufactureSelect_All:slotInit()
  PaGlobal_Guild_ManufactureSelect_All:setDefaultData()
  PaGlobal_Guild_ManufactureSelect_All:registEventHandler()
  PaGlobal_Guild_ManufactureSelect_All:switchPlatform()
  PaGlobal_Guild_ManufactureSelect_All:validate()
  PaGlobal_Guild_ManufactureSelect_All._initialize = true
end
function PaGlobal_Guild_ManufactureSelect_All:slotInit()
  if nil == Panel_Guild_ManufactureSelect_All then
    return
  end
  local productEnchantKeyList = ToClient_Guild_Manufacture_ProductItemEnchantKeyList()
  if nil == productEnchantKeyList then
    return
  end
  for ii = 0, #productEnchantKeyList do
    local itemEnchantKey = productEnchantKeyList[ii]
    local manufactureStatic = ToClient_GetGuildManufactureStaticStatusWrapper(itemEnchantKey)
    if nil ~= manufactureStatic then
      local slot = {}
      slot.bg = UI.createControl(__ePAUIControl_Static, self._ui.stc_mainArea, "ProductItemBG_" .. ii)
      CopyBaseProperty(self._ui.stc_slotBG, slot.bg)
      SlotItem.new(slot, "ProductItemIcon_" .. ii, ii, slot.bg, self._slotConfig)
      slot:createChild()
      slot.icon:SetShow(true)
      local itemWrapper = getItemEnchantStaticStatus(itemEnchantKey)
      slot:setItemByStaticStatus(itemWrapper)
      self._itemEnchantKey[ii + 1] = itemEnchantKey
      local categoryNo = manufactureStatic:getCategoryNo() + 1
      local slotCount = self._category[categoryNo]._slotCount
      self._category[categoryNo]._slot[slotCount] = slot
      self._category[categoryNo]._slotCount = slotCount + 1
      self._slotList[ii + 1] = slot
    end
  end
end
function PaGlobal_Guild_ManufactureSelect_All:registEventHandler()
  if nil == Panel_Guild_ManufactureSelect_All then
    return
  end
  self._ui.btn_close:addInputEvent("Mouse_LUp", "PaGlobalFunc_Guild_ManufactureSelect_All_Close()")
end
function PaGlobal_Guild_ManufactureSelect_All:setDefaultData()
  self._ui.stc_slotBG:SetShow(false)
  self._ui.btn_deposit:SetShow(false)
  self._ui.txt_desc:SetTextMode(__eTextMode_AutoWrap)
  self._ui.txt_desc:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_MANUFACTURE_NOTICE_INFORMATION"))
  local startPosY = 10
  local gap = 55
  for ii = 1, #self._categoryList do
    self._category[ii]._title:SetPosY(startPosY)
    startPosY = startPosY + self._category[ii]._title:GetSizeY() + 10
    local col = 0
    local row = 0
    for jj = 0, self._category[ii]._slotCount - 1 do
      local slot = self._category[ii]._slot[jj]
      if nil ~= slot then
        row = math.floor(jj / self._maxColumn)
        col = jj % self._maxColumn
        slot.bg:SetPosX(10 + gap * col)
        slot.bg:SetPosY(startPosY + gap * row)
        slot.bg:SetShow(true)
      end
    end
    startPosY = startPosY + gap * (row + 1) + 15
  end
  self._ui.stc_mainArea:SetSize(self._ui.stc_mainArea:GetSizeX(), startPosY)
  Panel_Guild_ManufactureSelect_All:SetSize(Panel_Guild_ManufactureSelect_All:GetSizeX(), self._ui.stc_titleArea:GetSizeY() + self._ui.stc_mainArea:GetSizeY() + self._ui.stc_descEdge:GetSizeY() + 20)
  self._ui.stc_descEdge:ComputePos()
end
function PaGlobal_Guild_ManufactureSelect_All:switchPlatform()
  if true == self._isConsole then
    self._ui.btn_close:SetShow(false)
    self._ui.stc_keyguideBG:ComputePos()
    local keyGuides = {
      self._ui.txt_keyGuideA,
      self._ui.txt_keyGuideB
    }
    PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyGuides, self._ui.stc_keyguideBG, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHT)
  end
end
function PaGlobal_Guild_ManufactureSelect_All:updateSlot()
  local productEnchantKeyList = ToClient_Guild_Manufacture_ProductItemEnchantKeyList()
  if nil == productEnchantKeyList then
    return
  end
  for ii = 0, #productEnchantKeyList do
    local itemEnchantKey = productEnchantKeyList[ii]
    local checkMakeflag = ToClient_CheckCanMakeGuildManufacture(itemEnchantKey)
    local slot = PaGlobal_Guild_ManufactureSelect_All._slotList[ii + 1]
    if true == checkMakeflag then
      slot.icon:addInputEvent("Mouse_LUp", "HandleEventLUp_Guild_ManufactureSelect_All_Select(" .. ii + 1 .. ")")
      slot.icon:SetMonoTone(false)
    else
      slot.icon:addInputEvent("Mouse_LUp", "")
      slot.icon:SetMonoTone(true)
    end
    slot.icon:addInputEvent("Mouse_On", "HandleEventOnOut_Guild_ManufactureSelect_All_ShowTooltip(true, " .. ii + 1 .. ")")
    slot.icon:addInputEvent("Mouse_Out", "HandleEventOnOut_Guild_ManufactureSelect_All_ShowTooltip(false, " .. ii + 1 .. ")")
  end
end
function PaGlobal_Guild_ManufactureSelect_All:prepareOpen(index)
  if nil == Panel_Guild_ManufactureSelect_All then
    return
  end
  if true == PaGlobalFunc_Guild_ManufactureSelect_All_GetShow() then
    return
  end
  PaGlobal_Guild_ManufactureSelect_All._index = index
  PaGlobal_Guild_ManufactureSelect_All:updateSlot()
  PaGlobal_Guild_ManufactureSelect_All:open()
end
function PaGlobal_Guild_ManufactureSelect_All:open()
  if nil == Panel_Guild_ManufactureSelect_All then
    return
  end
  Panel_Guild_ManufactureSelect_All:SetShow(true)
end
function PaGlobal_Guild_ManufactureSelect_All:prepareClose()
  if nil == Panel_Guild_ManufactureSelect_All then
    return
  end
  if false == PaGlobalFunc_Guild_ManufactureSelect_All_GetShow() then
    return
  end
  HandleEventOnOut_Guild_ManufactureSelect_All_ShowTooltip(false, PaGlobal_Guild_ManufactureSelect_All._index)
  PaGlobal_Guild_ManufactureSelect_All._index = -1
  PaGlobal_Guild_ManufactureSelect_All:close()
end
function PaGlobal_Guild_ManufactureSelect_All:close()
  if nil == Panel_Guild_ManufactureSelect_All then
    return
  end
  Panel_Guild_ManufactureSelect_All:SetShow(false)
end
function PaGlobal_Guild_ManufactureSelect_All:validate()
  if nil == Panel_Guild_ManufactureSelect_All then
    return
  end
  self._ui.stc_titleArea:isValidate()
  self._ui.btn_close:isValidate()
  self._ui.stc_mainArea:isValidate()
  self._ui.btn_deposit:isValidate()
  self._ui.stc_descEdge:isValidate()
  self._ui.stc_slotBG:isValidate()
  self._ui.txt_desc:isValidate()
end
