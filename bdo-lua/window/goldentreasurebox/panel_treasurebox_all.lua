PaGlobal_GoldenBox_All = {
  _ui = {
    stc_TitleBg = nil,
    txt_Title = nil,
    btn_Close = nil,
    stc_BoxBody = nil,
    stc_BoxHead = nil,
    stc_OpenedBox = nil,
    rdo_CashKey = nil,
    rdo_Key = nil,
    stc_DescBg = nil,
    txt_Desc = nil,
    btn_Open = nil,
    stc_KeyGuide = nil,
    stc_KeyGuide_A = nil,
    stc_KeyGuide_B = nil
  },
  _keySlotNo = {
    [0] = nil,
    [1] = nil
  },
  _DRIGAN_BOX_ITEMKEY = 750041,
  _DRIGAN_KEY_ITEMKEY = 750042,
  _oriDescBgSizeY = 0,
  _oriDescBgPosY = 0,
  _whereType = nil,
  _slotNo = nil,
  _deltaT = 0,
  _REFRESH_TIME = 5,
  _isDriganBox = false,
  _hasKey = false,
  _hasCashKey = false,
  _initialize = false,
  _isConsole = false
}
registerEvent("FromClient_luaLoadComplete", "FromClient_GoldenBox_All_Init")
function FromClient_GoldenBox_All_Init()
  PaGlobal_GoldenBox_All:initialize()
end
function PaGlobal_GoldenBox_All:initialize()
  if nil == Panel_GoldenTreasureBox_All or true == self._initialize then
    return
  end
  self._ui.stc_TitleBg = UI.getChildControl(Panel_GoldenTreasureBox_All, "Static_TitleBG")
  self._ui.txt_Title = UI.getChildControl(self._ui.stc_TitleBg, "StaticText_Title")
  self._ui.btn_Close = UI.getChildControl(self._ui.stc_TitleBg, "Button_CloseIcon")
  self._ui.stc_BoxBody = UI.getChildControl(Panel_GoldenTreasureBox_All, "Static_CloseBox_Body")
  self._ui.stc_BoxHead = UI.getChildControl(Panel_GoldenTreasureBox_All, "Static_CloseBox_Head")
  self._ui.stc_OpenedBox = UI.getChildControl(Panel_GoldenTreasureBox_All, "Static_OpenBox")
  self._ui.rdo_CashKey = UI.getChildControl(Panel_GoldenTreasureBox_All, "RadioButton_GoldenCashKey")
  self._ui.rdo_Key = UI.getChildControl(Panel_GoldenTreasureBox_All, "RadioButton_GoldenKey")
  self._ui.stc_DescBg = UI.getChildControl(Panel_GoldenTreasureBox_All, "Static_DescBg")
  self._ui.txt_Desc = UI.getChildControl(self._ui.stc_DescBg, "StaticText_Desc")
  self._ui.btn_Open = UI.getChildControl(Panel_GoldenTreasureBox_All, "Button_Open")
  self._ui.stc_KeyGuide = UI.getChildControl(Panel_GoldenTreasureBox_All, "Static_KeyGuide_ConsoleUI")
  self._ui.stc_KeyGuide_A = UI.getChildControl(self._ui.stc_KeyGuide, "StaticText_A_ConsoleUI")
  self._ui.stc_KeyGuide_B = UI.getChildControl(self._ui.stc_KeyGuide, "StaticText_B_ConsoleUI")
  self._ui.txt_Desc:SetTextMode(__eTextMode_AutoWrap)
  self._ui.txt_Desc:SetText(self._ui.txt_Desc:GetText())
  self._oriDescBgSizeY = self._ui.stc_DescBg:GetSizeY()
  self._oriDescBgPosY = self._ui.stc_DescBg:GetPosY()
  self._ui.btn_Close:SetShow(not _ContentsGroup_UsePadSnapping)
  self._ui.stc_KeyGuide:SetShow(_ContentsGroup_UsePadSnapping)
  local keyguide = {
    self._ui.stc_KeyGuide_A,
    self._ui.stc_KeyGuide_B
  }
  PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyguide, self._ui.stc_KeyGuide, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHT)
  PaGlobal_GoldenBox_All:registerEventHandler()
  PaGlobal_GoldenBox_All:validate()
  self._initialize = true
end
function PaGlobal_GoldenBox_All:registerEventHandler()
  registerEvent("FromClient_RequestUseSealItemBox", "FromClient_GoldenBox_All_Open")
  registerEvent("FromClient_ResponseSealItemBox", "FromClient_GoldenBox_All_GotItem_Ack")
  registerEvent("onScreenResize", "FromClinet_GoldenBox_All_OnScreenResize")
  Panel_GoldenTreasureBox_All:RegisterShowEventFunc(true, "PaGlobalFunc_GoldenBox_All_ShowAni()")
  Panel_GoldenTreasureBox_All:RegisterShowEventFunc(false, "PaGlobalFunc_GoldenBox_All_HideAni()")
  self._ui.btn_Open:addInputEvent("Mouse_LUp", "HandleEventLUp_GlodenBox_All_ClickOpen()")
  self._ui.btn_Close:addInputEvent("Mouse_LUp", "PaGlobalFunc_GoldenBox_All_Close()")
end
function PaGlobal_GoldenBox_All:validate()
  self._ui.stc_TitleBg:isValidate()
  self._ui.txt_Title:isValidate()
  self._ui.btn_Close:isValidate()
  self._ui.stc_BoxBody:isValidate()
  self._ui.stc_BoxHead:isValidate()
  self._ui.stc_OpenedBox:isValidate()
  self._ui.rdo_CashKey:isValidate()
  self._ui.rdo_Key:isValidate()
  self._ui.stc_DescBg:isValidate()
  self._ui.txt_Desc:isValidate()
  self._ui.btn_Open:isValidate()
  self._ui.stc_KeyGuide:isValidate()
  self._ui.stc_KeyGuide_A:isValidate()
  self._ui.stc_KeyGuide_B:isValidate()
end
function PaGlobal_GoldenBox_All:dataClear()
  self._hasKey = false
  self._hasCashKey = false
  self._hasKey = false
  self._keySlotNo[0] = nil
  self._keySlotNo[1] = nil
  self._isDriganBox = false
end
function PaGlobal_GoldenBox_All:prepareOpen()
  PaGlobal_GoldenBox_All:open()
  FromClinet_GoldenBox_All_OnScreenResize()
  PaGlobal_GoldenBox_All:update()
end
function PaGlobal_GoldenBox_All:open()
  Panel_GoldenTreasureBox_All:SetShow(true)
end
function PaGlobal_GoldenBox_All:update()
  PaGlobal_GoldenBox_All:findGoldenKey()
  self._ui.btn_Open:SetIgnore(not PaGlobal_GoldenBox_All:checkBoxLeft())
  self._ui.btn_Open:SetMonoTone(not PaGlobal_GoldenBox_All:checkBoxLeft())
end
function PaGlobal_GoldenBox_All:prepareClose()
  PaGlobal_GoldenBox_All:close()
end
function PaGlobal_GoldenBox_All:close()
  Panel_GoldenTreasureBox_All:SetShow(false)
end
function PaGlobal_GoldenBox_All:isDriganBox(whereType, slotNo)
  local itemWrapper = getInventoryItemByType(whereType, slotNo)
  if nil == itemWrapper then
    UI.ASSERT(false, "itemWrapper is nil / Panel_TreasureBox_All where = " .. tostring(whereType) .. " slotNo " .. tostring(slotNo))
    return
  end
  local itemKey = itemWrapper:getStaticStatus():get()._key:getItemKey()
  if self._DRIGAN_BOX_ITEMKEY == itemKey then
    return true
  end
  return false
end
function PaGlobal_GoldenBox_All:findGoldenKey()
  local isDrigan = self._isDriganBox
  local curInven = Inventory_GetCurrentInventory()
  local maxSize = curInven:sizeXXX()
  local normalKey = 0
  local cashKey = 0
  if true == isDrigan then
    for idx = 1, maxSize - 1 do
      local itemWrapper = getInventoryItemByType(CppEnums.ItemWhereType.eInventory, idx)
      if nil ~= itemWrapper then
        local contentsEventType = itemWrapper:getStaticStatus():get():getContentsEventType()
        if CppEnums.ContentsEventType.ContentsType_SealItemBoxKey == contentsEventType then
          local itemKey = itemWrapper:getStaticStatus():get()._key:getItemKey()
          if self._DRIGAN_KEY_ITEMKEY == itemKey then
            local keyCount = Int64toInt32(itemWrapper:get():getCount_s64())
            normalKey = normalKey + keyCount
            if nil == self._keySlotNo[0] then
              self._keySlotNo[0] = idx
              break
            end
          end
        end
      end
    end
  else
    for idx = 1, maxSize - 1 do
      local itemWrapper = getInventoryItemByType(CppEnums.ItemWhereType.eInventory, idx)
      if nil ~= itemWrapper then
        local contentsEventType = itemWrapper:getStaticStatus():get():getContentsEventType()
        if CppEnums.ContentsEventType.ContentsType_SealItemBoxKey == contentsEventType then
          local itemKey = itemWrapper:getStaticStatus():get()._key:getItemKey()
          if self._DRIGAN_KEY_ITEMKEY ~= itemKey then
            local keyCount = Int64toInt32(itemWrapper:get():getCount_s64())
            normalKey = normalKey + keyCount
            if nil == self._keySlotNo[0] then
              self._keySlotNo[0] = idx
            end
          end
        end
      end
    end
    for idx = 1, maxSize - 1 do
      local cashItemWrapper = getInventoryItemByType(CppEnums.ItemWhereType.eCashInventory, idx)
      if nil ~= cashItemWrapper then
        local contentsEventType = cashItemWrapper:getStaticStatus():get():getContentsEventType()
        if CppEnums.ContentsEventType.ContentsType_SealItemBoxKey == contentsEventType then
          local keyCount = Int64toInt32(cashItemWrapper:get():getCount_s64())
          cashKey = cashKey + keyCount
          if nil == self._keySlotNo[1] then
            self._keySlotNo[1] = idx
          end
        end
      end
    end
  end
  self._hasKey = 0 < normalKey
  self._hasCashKey = 0 < cashKey
  if true == isDrigan then
    self._ui.rdo_CashKey:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_TREASUREBOX_DRIGANGOLDKEY", "count", normalKey))
  else
    self._ui.rdo_Key:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_TREASUREBOX_GOLDKEY", "count", normalKey))
    self._ui.rdo_CashKey:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_TREASUREBOX_GOLDENKEY", "count", cashKey))
  end
end
function PaGlobal_GoldenBox_All:ChangeUI(isDrigan)
  self._ui.rdo_Key:SetShow(not isDrigan)
  self._ui.rdo_Key:SetCheck(not isDrigan)
  self._ui.stc_DescBg:SetPosY(self._oriDescBgPosY)
  self._ui.rdo_CashKey:SetCheck(isDrigan)
  if true == isDrigan then
    self._ui.stc_DescBg:SetSize(self._ui.stc_DescBg:GetSizeX(), self._oriDescBgSizeY + self._ui.rdo_Key:GetSizeY())
    self._ui.stc_DescBg:SetPosY(self._ui.stc_DescBg:GetPosY() - self._ui.rdo_Key:GetSizeY())
    self._ui.txt_Title:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_TREASUREBOX_DRIGANTITLE"))
    self._ui.txt_Desc:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_TREASUREBOX_DRIGANDESC"))
  else
    self._ui.stc_DescBg:SetSize(self._ui.stc_DescBg:GetSizeX(), self._oriDescBgSizeY)
    self._ui.txt_Title:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_GOLDENTREASUREBOX_TITLE"))
    self._ui.txt_Desc:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_GOLDENTREASUREBOX_DESC"))
  end
end
function PaGlobal_GoldenBox_All:checkBoxLeft()
  local itemWrapper = getInventoryItemByType(self._whereType, self._slotNo)
  if nil == itemWrapper then
    return false
  else
    return true
  end
end
function PaGlobalFunc_GoldenBox_All_ShowAni()
  UIAni.fadeInSCR_Down(Panel_GoldenTreasureBox_All)
  local aniInfo1 = Panel_GoldenTreasureBox_All:addScaleAnimation(0, 0.08, UI_ANI_ADV.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfo1:SetStartScale(0.5)
  aniInfo1:SetEndScale(1.1)
  aniInfo1.AxisX = Panel_GoldenTreasureBox_All:GetSizeX() / 2
  aniInfo1.AxisY = Panel_GoldenTreasureBox_All:GetSizeY() / 2
  aniInfo1.ScaleType = 2
  aniInfo1.IsChangeChild = true
  local aniInfo2 = Panel_GoldenTreasureBox_All:addScaleAnimation(0.08, 0.15, UI_ANI_ADV.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfo2:SetStartScale(1.1)
  aniInfo2:SetEndScale(1)
  aniInfo2.AxisX = Panel_GoldenTreasureBox_All:GetSizeX() / 2
  aniInfo2.AxisY = Panel_GoldenTreasureBox_All:GetSizeY() / 2
  aniInfo2.ScaleType = 2
  aniInfo2.IsChangeChild = true
end
function PaGlobalFunc_GoldenBox_All_HideAni()
  Panel_GoldenTreasureBox_All:SetShowWithFade(UI_PSFT.PAUI_ANI_TYPE_FADE_OUT)
  local aniInfo1 = Panel_GoldenTreasureBox_All:addColorAnimation(0, 0.25, UI_ANI_ADV.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
  aniInfo1:SetStartColor(UI_color.C_FFFFFFFF)
  aniInfo1:SetEndColor(UI_color.C_00FFFFFF)
  aniInfo1:SetStartIntensity(3)
  aniInfo1:SetEndIntensity(1)
  aniInfo1.IsChangeChild = true
  aniInfo1:SetHideAtEnd(true)
  aniInfo1:SetDisableWhileAni(true)
end
function PaGlobalFunc_GoldenBox_All_GetPanelShow()
  if nil == Panel_GoldenTreasureBox_All then
    return false
  end
  return Panel_GoldenTreasureBox_All:GetShow()
end
function HandleEventLUp_GlodenBox_All_ClickOpen()
  local isUseNormal = PaGlobal_GoldenBox_All._ui.rdo_Key:IsCheck()
  local isDriganBox = PaGlobal_GoldenBox_All._isDriganBox
  local whereType = 0
  local keySlotNo
  if true == isDriganBox then
    if false == PaGlobal_GoldenBox_All._hasKey then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_TREASUREBOX_NEEDDRIGANGOLDKEY"))
      return
    end
    whereType = CppEnums.ItemWhereType.eInventory
    keySlotNo = PaGlobal_GoldenBox_All._keySlotNo[0]
  elseif true == isUseNormal then
    if false == PaGlobal_GoldenBox_All._hasKey then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_TREASUREBOX_NEEDGOLDKEY"))
      return
    end
    whereType = CppEnums.ItemWhereType.eInventory
    keySlotNo = PaGlobal_GoldenBox_All._keySlotNo[0]
  else
    if false == PaGlobal_GoldenBox_All._hasCashKey then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_TREASUREBOX_NEEDGOLDENKEY"))
      return
    end
    whereType = CppEnums.ItemWhereType.eCashInventory
    keySlotNo = PaGlobal_GoldenBox_All._keySlotNo[1]
  end
  if nil == keySlotNo then
    UI.ASSERT(false, "keySlotNo is nil")
  end
  PaGlobal_GoldenBox_All._ui.stc_BoxHead:SetShow(false)
  PaGlobal_GoldenBox_All._ui.stc_BoxBody:SetShow(false)
  PaGlobal_GoldenBox_All._ui.stc_OpenedBox:SetShow(true)
  PaGlobal_GoldenBox_All._ui.stc_OpenedBox:EraseAllEffect()
  PaGlobal_GoldenBox_All._ui.stc_OpenedBox:AddEffect("fCO_Egg_Random_01B", false, 0, 0)
  Panel_GoldenTreasureBox_All:RegisterUpdateFunc("PaGlobalFunc_GoldenBox_All_RefreshBox_ByDeltaT")
  ToClient_requestOpenSealItemBox(PaGlobal_GoldenBox_All._whereType, PaGlobal_GoldenBox_All._slotNo, whereType, keySlotNo)
  audioPostEvent_SystemUi(11, 14)
  _AudioPostEvent_SystemUiForXBOX(11, 14)
end
function PaGlobalFunc_GoldenBox_All_Close()
  PaGlobal_GoldenBox_All:prepareClose()
end
function PaGlobalFunc_GoldenBox_All_RefreshBox_ByDeltaT(deltaTime)
  PaGlobal_GoldenBox_All._deltaT = PaGlobal_GoldenBox_All._deltaT + deltaTime
  if PaGlobal_GoldenBox_All._REFRESH_TIME < PaGlobal_GoldenBox_All._deltaT then
    PaGlobal_GoldenBox_All._ui.stc_BoxBody:SetShow(true)
    PaGlobal_GoldenBox_All._ui.stc_BoxHead:SetShow(true)
    PaGlobal_GoldenBox_All._ui.stc_OpenedBox:SetShow(false)
    PaGlobal_GoldenBox_All._deltaT = 0
    audioPostEvent_SystemUi(11, 15)
    _AudioPostEvent_SystemUiForXBOX(11, 15)
    Panel_GoldenTreasureBox_All:ClearUpdateLuaFunc()
    if false == PaGlobal_GoldenBox_All:checkBoxLeft() then
      PaGlobal_GoldenBox_All:prepareClose()
    end
  end
end
function FromClient_GoldenBox_All_Open(whereType, slotNo)
  if nil == whereType or nil == slotNo then
    return
  end
  PaGlobal_GoldenBox_All:dataClear()
  PaGlobal_GoldenBox_All._whereType = whereType
  PaGlobal_GoldenBox_All._slotNo = slotNo
  PaGlobal_GoldenBox_All._isDriganBox = PaGlobal_GoldenBox_All:isDriganBox(whereType, slotNo)
  PaGlobal_GoldenBox_All:ChangeUI(PaGlobal_GoldenBox_All._isDriganBox)
  PaGlobal_GoldenBox_All:prepareOpen()
end
function FromClient_GoldenBox_All_GotItem_Ack(itemKey)
  if nil == itemKey then
    return
  end
  PaGlobal_GoldenBox_All:update()
  local itemESSW = getItemEnchantStaticStatus(ItemEnchantKey(itemKey))
  if nil == itemESSW then
    return
  end
  local sendMsg = {
    main = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GACHA_ROULETTE_GETITEM", "getName", itemESSW:getName()),
    sub = "",
    addMsg = ""
  }
  Proc_ShowMessage_Ack_WithOut_ChattingMessage_For_RewardSelect(sendMsg, 3.5, 17)
end
function FromClinet_GoldenBox_All_OnScreenResize()
  if false == PaGlobalFunc_GoldenBox_All_GetPanelShow() then
    return
  end
  Panel_GoldenTreasureBox_All:SetPosX(getScreenSizeX() * 0.5 - Panel_GoldenTreasureBox_All:GetSizeX() * 0.5)
  Panel_GoldenTreasureBox_All:SetPosY(getScreenSizeY() * 0.5 - Panel_GoldenTreasureBox_All:GetSizeY() * 0.5)
end
