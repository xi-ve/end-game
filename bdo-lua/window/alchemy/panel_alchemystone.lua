Panel_AlchemyStone:SetShow(false)
local AlchemyStone = {
  control = {
    txt_Title = UI.getChildControl(Panel_AlchemyStone, "StaticText_Title"),
    tab_Charge = UI.getChildControl(Panel_AlchemyStone, "RadioButton_Tab_Charge"),
    tab_Exp = UI.getChildControl(Panel_AlchemyStone, "RadioButton_Tab_Exp"),
    tab_Upgrade = UI.getChildControl(Panel_AlchemyStone, "RadioButton_Tab_Upgrade"),
    tab_RandomOption = UI.getChildControl(Panel_AlchemyStone, "RadioButton_Tab_RandomOption"),
    contentBG = UI.getChildControl(Panel_AlchemyStone, "Static_ContentTypeBG"),
    contentEffect = UI.getChildControl(Panel_AlchemyStone, "Static_ContentTypeEffect"),
    guideString = UI.getChildControl(Panel_AlchemyStone, "Static_GuideText"),
    btn_Doit = UI.getChildControl(Panel_AlchemyStone, "Button_Doit"),
    slotBg_1 = UI.getChildControl(Panel_AlchemyStone, "Static_SlotBg_1"),
    slotBg_2 = UI.getChildControl(Panel_AlchemyStone, "Static_SlotBg_2"),
    Slot_1 = UI.getChildControl(Panel_AlchemyStone, "Static_Slot_1"),
    Slot_2 = UI.getChildControl(Panel_AlchemyStone, "Static_Slot_2"),
    needCount = UI.getChildControl(Panel_AlchemyStone, "Static_NeedCountTitle"),
    count = UI.getChildControl(Panel_AlchemyStone, "StaticText_NeedCount"),
    expMaterial = UI.getChildControl(Panel_AlchemyStone, "StaticText_ExpMaterial"),
    expMaterial2 = UI.getChildControl(Panel_AlchemyStone, "StaticText_ExpMaterial2"),
    btn_Plus = UI.getChildControl(Panel_AlchemyStone, "Button_CountPlus"),
    btn_Minus = UI.getChildControl(Panel_AlchemyStone, "Button_CountMinus"),
    desc = UI.getChildControl(Panel_AlchemyStone, "StaticText_Desc"),
    progressBg_1 = UI.getChildControl(Panel_AlchemyStone, "Static_GaugeBG_1"),
    progressBg_2 = UI.getChildControl(Panel_AlchemyStone, "Static_GaugeBG_2"),
    resultSlot = UI.getChildControl(Panel_AlchemyStone, "Static_SlotBgTemplate"),
    resultSlotBg = UI.getChildControl(Panel_AlchemyStone, "Static_ResultSlotBg"),
    upgradeSlotBg = UI.getChildControl(Panel_AlchemyStone, "Static_UpgradeSlotBg"),
    chargeDesc = UI.getChildControl(Panel_AlchemyStone, "StaticText_Charge_Desc")
  },
  slotConfig = {
    createIcon = true,
    createBorder = true,
    createCount = true,
    createCash = true
  },
  Stuff_slot = {},
  Stone_slot = {},
  resultSlot = {},
  resultSlotBg = {},
  selectedTabIdx = 0,
  selectedStoneType = 0,
  selectedStoneItemKey = nil,
  fromWhereType = -1,
  fromSlotNo = -1,
  fromCount = toInt64(0, -1),
  fromMaxCount = toInt64(0, -1),
  toWhereType = -1,
  toSlotNo = -1,
  currentEndurance = 0,
  maxEndurance = 0,
  toLostEndurance = 0,
  recoverCount = 0,
  maxRecoverCount = 0,
  chargePoint = 0,
  isPushDoit = false,
  doItType = -1,
  startEffectPlay = false,
  contentEffectPlay = false,
  slotEffectPlay = false,
  effectEnd = false,
  resultMsg = {},
  upgradeItem = nil,
  resultItemKey = {},
  resultItemIndex = -1,
  randomSourceKey = 0
}
local AlchemyStoneTab = {
  Charge = 0,
  Exp = 1,
  Upgrade = 2,
  RandomOption = 3
}
local AlchemyStoneTabTexture = {
  [AlchemyStoneTab.Charge] = {
    bg = "New_UI_Common_forLua/Window/AlchemyStone/AlchemyStone_Charge_BG.dds",
    effect = "New_UI_Common_forLua/Window/ChangeItem/ChangeItem_Effect1.dds"
  },
  [AlchemyStoneTab.Exp] = {
    bg = "New_UI_Common_forLua/Window/AlchemyStone/AlchemyStone_Exp_BG.dds",
    effect = "New_UI_Common_forLua/Window/AlchemyStone/AlchemyStone_Exp_Effect.dds"
  },
  [AlchemyStoneTab.Upgrade] = {
    bg = "New_UI_Common_forLua/Window/AlchemyStone/AlchemyStone_Upgrade_BG.dds",
    effect = "New_UI_Common_forLua/Window/AlchemyStone/AlchemyStone_Upgrade_Effect.dds"
  },
  [AlchemyStoneTab.RandomOption] = {
    bg = "New_UI_Common_forLua/Window/AlchemyStone/AlchemyStone_Upgrade_BG.dds",
    effect = "New_UI_Common_forLua/Window/AlchemyStone/AlchemyStone_Upgrade_Effect.dds"
  }
}
local alchemyStoneDesc = {
  [AlchemyStoneTab.Charge] = PAGetString(Defines.StringSheet_GAME, "LUA_ALCHEMYSTONE_DESC_1"),
  [AlchemyStoneTab.Exp] = PAGetString(Defines.StringSheet_GAME, "LUA_ALCHEMYSTONE_DESC_2"),
  [AlchemyStoneTab.Upgrade] = PAGetString(Defines.StringSheet_GAME, "LUA_ALCHEMYSTONE_DESC_3"),
  [AlchemyStoneTab.RandomOption] = "\235\158\156\235\141\164\237\149\156 \236\152\181\236\133\152\236\157\180 \235\182\128\236\151\172\235\144\169\235\139\136\235\139\164."
}
local panelSizeY = Panel_AlchemyStone:GetSizeY()
local textSizeY = AlchemyStone.control.desc:GetTextSizeY()
AlchemyStone.control.desc:SetTextMode(__eTextMode_AutoWrap)
function AlchemyStone:Init()
  SlotItem.new(self.Stuff_slot, "AlchemyStone_Stuff", 0, self.control.Slot_1, self.slotConfig)
  self.Stuff_slot:createChild()
  self.Stuff_slot.Empty = true
  self.Stuff_slot.icon:addInputEvent("Mouse_RUp", "HandleClicked_AlchemyStone_UnSetSlot(" .. 1 .. ")")
  SlotItem.new(self.Stone_slot, "AlchemyStone_Stone", 0, self.control.Slot_2, self.slotConfig)
  self.Stone_slot:createChild()
  self.Stone_slot.Empty = true
  self.Stone_slot.icon:addInputEvent("Mouse_RUp", "HandleClicked_AlchemyStone_UnSetSlot(" .. 0 .. ")")
  self.control.btn_Close = UI.getChildControl(self.control.txt_Title, "Button_Win_Close")
  self.control._buttonQuestion = UI.getChildControl(self.control.txt_Title, "Button_Question")
  self.control.progress_1 = UI.getChildControl(self.control.progressBg_1, "Progress2_Exp_Gauge_1")
  self.control.progress_1_Pre = UI.getChildControl(self.control.progressBg_1, "Progress2_Exp_Gauge_1_PreView")
  self.control.progressText_1 = UI.getChildControl(self.control.progressBg_1, "StaticText_Count_1")
  self.control.progress_2 = UI.getChildControl(self.control.progressBg_2, "Progress2_Exp_Gauge_2")
  self.control.progressText_2 = UI.getChildControl(self.control.progressBg_2, "StaticText_Count_2")
  self.control._buttonQuestion:addInputEvent("Mouse_LUp", "Panel_WebHelper_ShowToggle( \"AlchemyStone\" )")
  PaGlobal_Util_RegistHelpTooltipEvent(self.control._buttonQuestion, "\"AlchemyStone\"")
  self.control.tab_Charge:SetCheck(true)
  self.control.tab_Exp:SetCheck(false)
  self.control.tab_Upgrade:SetCheck(false)
  self.control.tab_RandomOption:SetCheck(false)
  self.control.tab_RandomOption:SetShow(true == _ContentsGroup_ItemRandomOption)
  local btnChargeSizeX = self.control.tab_Charge:GetSizeX() + 23
  local btnChargeTextPosX = btnChargeSizeX - btnChargeSizeX / 2 - self.control.tab_Charge:GetTextSizeX() / 2
  local btnExpSizeX = self.control.tab_Exp:GetSizeX() + 23
  local btnExpTextPosX = btnExpSizeX - btnExpSizeX / 2 - self.control.tab_Exp:GetTextSizeX() / 2
  local btnUpgradeSizeX = self.control.tab_Upgrade:GetSizeX() + 23
  local btnUpgradeTextPosX = btnUpgradeSizeX - btnUpgradeSizeX / 2 - self.control.tab_Upgrade:GetTextSizeX() / 2
  local btnRandomOptionSizeX = self.control.tab_Upgrade:GetSizeX() + 23
  local btnRandomOptionTextPosX = btnRandomOptionSizeX - btnRandomOptionSizeX / 2 - self.control.tab_Upgrade:GetTextSizeX() / 2
  self.control.tab_Charge:SetTextSpan(btnChargeTextPosX, 5)
  self.control.tab_Exp:SetTextSpan(btnExpTextPosX, 5)
  self.control.tab_Upgrade:SetTextSpan(btnUpgradeTextPosX, 5)
  self.control.tab_RandomOption:SetTextSpan(btnRandomOptionTextPosX, 5)
  self.control.contentEffect:SetShow(false)
  local temp = {}
  for index = 0, 2 do
    temp[index] = UI.createControl(__ePAUIControl_Static, Panel_AlchemyStone, "AlchemyStone_SuccessResultSlot_" .. index)
    CopyBaseProperty(self.control.resultSlot, temp[index])
    self.resultSlotBg = temp
    self.resultSlot[index] = {}
    SlotItem.new(self.resultSlot[index], "AlchemyStone_ResultSlot_" .. index, 0, self.resultSlotBg[index], self.slotConfig)
    self.resultSlot[index]:createChild()
    self.resultSlot[index].Empty = true
    self.resultSlot[index].icon:SetPosX(5)
    self.resultSlot[index].icon:SetPosY(5)
  end
  if ToClient_IsContentsGroupOpen("5") and ToClient_IsContentsGroupOpen("35") then
    alchemyStoneDesc[0] = PAGetString(Defines.StringSheet_GAME, "LUA_ALCHEMYSTONE_DESC_4")
  else
    alchemyStoneDesc[0] = PAGetString(Defines.StringSheet_GAME, "LUA_ALCHEMYSTONE_DESC_1")
  end
  self.upgradeItem = nil
  self.control.chargeDesc:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_ALCHEMYSTONE_DESC_5", "needCountMin", 0))
end
function AlchemyStone:registEventHandler()
  self.control.tab_Charge:addInputEvent("Mouse_LUp", "HandleClicked_AlchemyStoneTab( " .. AlchemyStoneTab.Charge .. " )")
  self.control.tab_Exp:addInputEvent("Mouse_LUp", "HandleClicked_AlchemyStoneTab( " .. AlchemyStoneTab.Exp .. " )")
  self.control.tab_Upgrade:addInputEvent("Mouse_LUp", "HandleClicked_AlchemyStoneTab( " .. AlchemyStoneTab.Upgrade .. " )")
  self.control.tab_RandomOption:addInputEvent("Mouse_LUp", "HandleClicked_AlchemyStoneTab( " .. AlchemyStoneTab.RandomOption .. " )")
  self.control.tab_Charge:addInputEvent("Mouse_On", "HandleClicked_AlchemyStoneTab_Tooltip( true, " .. AlchemyStoneTab.Charge .. " )")
  self.control.tab_Charge:addInputEvent("Mouse_Out", "HandleClicked_AlchemyStoneTab_Tooltip( false, " .. AlchemyStoneTab.Charge .. " )")
  self.control.tab_Charge:setTooltipEventRegistFunc("HandleClicked_AlchemyStoneTab_Tooltip( true, " .. AlchemyStoneTab.Charge .. " )")
  self.control.tab_Exp:addInputEvent("Mouse_On", "HandleClicked_AlchemyStoneTab_Tooltip( true, " .. AlchemyStoneTab.Exp .. " )")
  self.control.tab_Exp:addInputEvent("Mouse_Out", "HandleClicked_AlchemyStoneTab_Tooltip( false, " .. AlchemyStoneTab.Exp .. " )")
  self.control.tab_Exp:setTooltipEventRegistFunc("HandleClicked_AlchemyStoneTab_Tooltip( true, " .. AlchemyStoneTab.Exp .. " )")
  self.control.tab_Upgrade:addInputEvent("Mouse_On", "HandleClicked_AlchemyStoneTab_Tooltip( true, " .. AlchemyStoneTab.Upgrade .. " )")
  self.control.tab_Upgrade:addInputEvent("Mouse_Out", "HandleClicked_AlchemyStoneTab_Tooltip( false, " .. AlchemyStoneTab.Upgrade .. " )")
  self.control.tab_Upgrade:setTooltipEventRegistFunc("HandleClicked_AlchemyStoneTab_Tooltip( true, " .. AlchemyStoneTab.Upgrade .. " )")
  self.control.tab_RandomOption:addInputEvent("Mouse_On", "HandleClicked_AlchemyStoneTab_Tooltip( true, " .. AlchemyStoneTab.RandomOption .. " )")
  self.control.tab_RandomOption:addInputEvent("Mouse_Out", "HandleClicked_AlchemyStoneTab_Tooltip( false, " .. AlchemyStoneTab.RandomOption .. " )")
  self.control.tab_RandomOption:setTooltipEventRegistFunc("HandleClicked_AlchemyStoneTab_Tooltip( true, " .. AlchemyStoneTab.RandomOption .. " )")
  self.control.btn_Plus:addInputEvent("Mouse_LUp", "HandleClicked_AlchemyStone_ChangeStuffCount( true )")
  self.control.btn_Minus:addInputEvent("Mouse_LUp", "HandleClicked_AlchemyStone_ChangeStuffCount( false )")
  self.control.btn_Doit:addInputEvent("Mouse_LUp", "HandleClicked_AlchemyStone_Doit()")
  self.control.btn_Close:addInputEvent("Mouse_LUp", "HandleClicked_AlchemyStone_Close()")
end
function AlchemyStone:registMessageHandler()
  registerEvent("onScreenResize", "AlchemyStone_onScreenResize")
  registerEvent("FromClient_ItemUpgrade", "FromClient_ItemUpgrade")
  registerEvent("FromClient_StoneChange", "FromClient_StoneChange")
  registerEvent("FromClient_StoneChangeFailedByDown", "FromClient_StoneChangeFailedByDown")
  registerEvent("FromClient_AlchemyEvolve", "FromClient_AlchemyEvolve")
  registerEvent("FromClient_AlchemyRepair", "FromClient_AlchemyRepair")
  Panel_AlchemyStone:RegisterUpdateFunc("Panel_AlchemyStone_updateTime")
end
function AlchemyStone:UpdateStone(whereType, slotNo)
  local itemWrapper = getInventoryItemByType(whereType, Int64toInt32(slotNo))
  self.currentEndurance = itemWrapper:get():getEndurance()
  self.maxEndurance = itemWrapper:get():getMaxEndurance()
  self.toLostEndurance = self.maxEndurance - self.currentEndurance
  local progressRate = self.currentEndurance / self.maxEndurance * 100
  AlchemyStone.control.progress_1:SetProgressRate(progressRate)
  local endurancePoint = self.currentEndurance .. " / " .. self.maxEndurance
  AlchemyStone.control.progressText_1:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_ALCHEMYSTONE_ENDURANCE", "endurance", endurancePoint))
end
function AlchemyStone:ClearData(isOpenStep, isStuffOnly)
  if true == isOpenStep then
    self.resultMsg = {}
  end
  if false == isStuffOnly then
    self.toWhereType = -1
    self.toSlotNo = -1
    self.selectedStoneType = -1
    self.selectedStoneItemKey = nil
    self.currentEndurance = 0
    self.maxEndurance = 0
    self.toLostEndurance = 0
    self.recoverCount = 0
    self.maxRecoverCount = 0
    self.randomSourceKey = 0
    self.Stone_slot:clearItem()
    self.Stone_slot.Empty = true
    self.control.progressBg_1:SetShow(false)
    self.control.progress_1:SetShow(false)
    self.control.progress_1_Pre:SetShow(false)
    self.control.progressText_1:SetShow(false)
    self.control.progress_1:SetProgressRate(0)
    self.control.progress_1_Pre:SetProgressRate(0)
  end
  self.fromWhereType = -1
  self.fromSlotNo = -1
  self.fromCount = toInt64(0, -1)
  self.fromMaxCount = toInt64(0, -1)
  self.chargePoint = 0
  self.isPushDoit = false
  self.startEffectPlay = false
  self.contentEffectPlay = false
  self.slotEffectPlay = false
  self.effectEnd = false
  self.Stuff_slot.icon:EraseAllEffect()
  self.control.contentEffect:EraseAllEffect()
  self.Stone_slot.icon:EraseAllEffect()
  self.control.btn_Doit:SetMonoTone(not self.isPushDoit)
  self.control.btn_Doit:SetEnable(self.isPushDoit)
  self.Stuff_slot:clearItem()
  self.Stuff_slot.Empty = true
  self.resultSlot[0]:clearItem()
  self.resultSlot[1]:clearItem()
  self.resultSlot[2]:clearItem()
  self.resultSlot[0].icon:addInputEvent("Mouse_On", "")
  self.resultSlot[0].icon:addInputEvent("Mouse_Out", "")
  self.resultSlot[1].icon:addInputEvent("Mouse_On", "")
  self.resultSlot[1].icon:addInputEvent("Mouse_Out", "")
  self.resultSlot[2].icon:addInputEvent("Mouse_On", "")
  self.resultSlot[2].icon:addInputEvent("Mouse_Out", "")
  self.control.progressBg_2:SetShow(false)
  self.control.progress_2:SetShow(false)
  self.control.progressText_2:SetShow(false)
  self.control.count:SetShow(false)
  self.control.expMaterial:SetShow(false)
  self.control.expMaterial2:SetShow(false)
  self.control.progress_2:SetProgressRate(0)
  self.control.contentEffect:SetShow(false)
  local guideKeyword = ""
  local guideText = ""
  if AlchemyStoneTab.Charge == self.selectedTabIdx then
    guideKeyword = PAGetString(Defines.StringSheet_GAME, "LUA_ALCHEMYSTONE_CHARGE")
    guideText = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_ALCHEMYSTONE_SELECT", "guideKeyword", guideKeyword)
  elseif AlchemyStoneTab.Exp == self.selectedTabIdx then
    guideKeyword = PAGetString(Defines.StringSheet_GAME, "LUA_ALCHEMYSTONE_EXP")
    guideText = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_ALCHEMYSTONE_SELECT", "guideKeyword", guideKeyword)
  elseif AlchemyStoneTab.Upgrade == self.selectedTabIdx then
    guideKeyword = PAGetString(Defines.StringSheet_GAME, "LUA_ALCHEMYSTONE_UPGRADE")
    guideText = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_ALCHEMYSTONE_SELECT", "guideKeyword", guideKeyword)
  elseif AlchemyStoneTab.RandomOption == self.selectedTabIdx then
    guideKeyword = "\235\182\128\236\151\172\237\149\160 \236\151\176\234\184\136\236\132\157"
    guideText = guideKeyword .. " \234\176\128\235\176\169\236\151\144\236\132\156 \236\162\128"
  end
  self.control.guideString:SetText(guideText)
  self.control.btn_Doit:SetText(guideKeyword)
  local btnDoitSizeX = self.control.btn_Doit:GetSizeX() + 23
  local btnDoitTextPosX = btnDoitSizeX - btnDoitSizeX / 2 - self.control.btn_Doit:GetTextSizeX() / 2
  self.control.btn_Doit:SetTextSpan(btnDoitTextPosX, 5)
  self.control.needCount:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_ALCHEMYSTONE_NEEDCOUNT"))
  AlchemyStone.control.count:SetShow(false)
  AlchemyStone.control.expMaterial:SetShow(false)
  AlchemyStone.control.expMaterial2:SetShow(false)
  AlchemyStone_TabButton_Enable(true)
  self.upgradeItem = nil
  self.resultItemKey = {}
  self.resultItemIndex = -1
end
function HandleClicked_AlchemyStoneTab(tabIdx)
  AlchemyStone.toWhereType = -1
  AlchemyStone.toSlotNo = -1
  AlchemyStone.fromWhereType = -1
  AlchemyStone.fromSlotNo = -1
  AlchemyStone.fromCount = toInt64(0, -1)
  AlchemyStone.fromMaxCount = toInt64(0, -1)
  AlchemyStone.selectedStoneType = -1
  AlchemyStone.selectedStoneItemKey = nil
  AlchemyStone.currentEndurance = 0
  AlchemyStone.maxEndurance = 0
  AlchemyStone.toLostEndurance = 0
  AlchemyStone.recoverCount = 0
  AlchemyStone.maxRecoverCount = 0
  AlchemyStone.chargePoint = 0
  AlchemyStone.randomSourceKey = 0
  AlchemyStone.Stone_slot:clearItem()
  AlchemyStone.Stuff_slot:clearItem()
  AlchemyStone.resultSlot[0]:clearItem()
  AlchemyStone.resultSlot[1]:clearItem()
  AlchemyStone.resultSlot[2]:clearItem()
  AlchemyStone.Stone_slot.Empty = true
  AlchemyStone.Stuff_slot.Empty = true
  AlchemyStone.resultSlot[0].Empty = true
  AlchemyStone.resultSlot[1].Empty = true
  AlchemyStone.resultSlot[2].Empty = true
  AlchemyStone.Stone_slot.icon:addInputEvent("Mouse_On", "")
  AlchemyStone.Stone_slot.icon:addInputEvent("Mouse_Out", "")
  AlchemyStone.Stuff_slot.icon:addInputEvent("Mouse_On", "")
  AlchemyStone.Stuff_slot.icon:addInputEvent("Mouse_Out", "")
  AlchemyStone.resultSlot[0].icon:addInputEvent("Mouse_On", "")
  AlchemyStone.resultSlot[0].icon:addInputEvent("Mouse_Out", "")
  AlchemyStone.resultSlot[1].icon:addInputEvent("Mouse_On", "")
  AlchemyStone.resultSlot[1].icon:addInputEvent("Mouse_Out", "")
  AlchemyStone.resultSlot[2].icon:addInputEvent("Mouse_On", "")
  AlchemyStone.resultSlot[2].icon:addInputEvent("Mouse_Out", "")
  AlchemyStone.selectedTabIdx = tabIdx
  doItType = -1
  AlchemyStone.isPushDoit = false
  AlchemyStone.Stuff_slot.icon:EraseAllEffect()
  AlchemyStone.control.contentEffect:EraseAllEffect()
  AlchemyStone.Stone_slot.icon:EraseAllEffect()
  Inventory_SetFunctor(AlchemyStone_StoneFilter, AlchemyStone_StoneRfunction, nil, nil)
  AlchemyStone.control.needCount:SetShow(false)
  AlchemyStone.control.btn_Plus:SetShow(false)
  AlchemyStone.control.btn_Minus:SetShow(false)
  AlchemyStone.control.chargeDesc:SetShow(false)
  AlchemyStone:initEffectPlayState()
  local guideKeyword = ""
  local guideText = ""
  if AlchemyStoneTab.Charge == tabIdx then
    guideKeyword = PAGetString(Defines.StringSheet_GAME, "LUA_ALCHEMYSTONE_CHARGE")
    guideText = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_ALCHEMYSTONE_SELECT", "guideKeyword", guideKeyword)
    AlchemyStone.control.needCount:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_ALCHEMYSTONE_NEEDCOUNT"))
    AlchemyStone.control.needCount:SetShow(true)
    AlchemyStone.control.btn_Plus:SetShow(true)
    AlchemyStone.control.btn_Minus:SetShow(true)
  elseif AlchemyStoneTab.Exp == tabIdx then
    guideKeyword = PAGetString(Defines.StringSheet_GAME, "LUA_ALCHEMYSTONE_EXP")
    guideText = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_ALCHEMYSTONE_SELECT", "guideKeyword", guideKeyword)
    AlchemyStone.control.needCount:SetShow(true)
    AlchemyStone.control.needCount:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_ALCHEMYSTONE_MATERIALNAME"))
  elseif AlchemyStoneTab.Upgrade == tabIdx then
    guideKeyword = PAGetString(Defines.StringSheet_GAME, "LUA_ALCHEMYSTONE_UPGRADE")
    guideText = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_ALCHEMYSTONE_SELECT", "guideKeyword", guideKeyword)
    AlchemyStone.control.needCount:SetShow(true)
    AlchemyStone.control.needCount:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_ALCHEMYSTONE_PENALTY"))
  elseif AlchemyStoneTab.RandomOption == tabIdx then
    guideKeyword = "\235\158\156\235\141\164 \236\152\181\236\133\152"
    guideText = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_ALCHEMYSTONE_SELECT", "guideKeyword", guideKeyword)
    AlchemyStone.control.needCount:SetShow(true)
    AlchemyStone.control.needCount:SetText("\235\158\156\235\141\164 \236\152\181\236\133\152 \236\158\172\235\163\140")
  end
  AlchemyStone.control.guideString:SetText(guideText)
  AlchemyStone.control.btn_Doit:SetText(guideKeyword)
  local btnDoitSizeX = AlchemyStone.control.btn_Doit:GetSizeX() + 23
  local btnDoitTextPosX = btnDoitSizeX - btnDoitSizeX / 2 - AlchemyStone.control.btn_Doit:GetTextSizeX() / 2
  AlchemyStone.control.btn_Doit:SetTextSpan(btnDoitTextPosX, 5)
  AlchemyStone.control.desc:SetText(alchemyStoneDesc[tabIdx])
  local _descTextSizeY = AlchemyStone.control.desc:GetTextSizeY()
  if 35 < _descTextSizeY then
    Panel_AlchemyStone:SetSize(Panel_AlchemyStone:GetSizeX(), panelSizeY + _descTextSizeY - 34)
  else
    Panel_AlchemyStone:SetSize(Panel_AlchemyStone:GetSizeX(), panelSizeY)
  end
  AlchemyStone.control.btn_Doit:ComputePos()
  if 0 == tabIdx or 1 == tabIdx or 3 == tabIdx then
    AlchemyStone.control.slotBg_1:SetPosX(50)
    AlchemyStone.control.slotBg_1:SetPosY(230)
    AlchemyStone.control.slotBg_2:SetPosX(380)
    AlchemyStone.control.slotBg_2:SetPosY(230)
    AlchemyStone.control.Slot_1:SetPosX(440)
    AlchemyStone.control.Slot_1:SetPosY(258)
    AlchemyStone.control.Slot_2:SetPosX(112)
    AlchemyStone.control.Slot_2:SetPosY(258)
    AlchemyStone.control.slotBg_1:SetShow(true)
    AlchemyStone.control.slotBg_2:SetShow(true)
    AlchemyStone.control.resultSlotBg:SetShow(false)
    AlchemyStone.resultSlotBg[0]:SetShow(false)
    AlchemyStone.resultSlotBg[1]:SetShow(false)
    AlchemyStone.resultSlotBg[2]:SetShow(false)
    AlchemyStone.control.resultSlot:SetShow(true)
    AlchemyStone.control.resultSlot:SetPosX(436)
    AlchemyStone.control.resultSlot:SetPosY(252)
    AlchemyStone.control.upgradeSlotBg:SetShow(false)
    AlchemyStone.control.btn_Plus:SetPosY(260)
    AlchemyStone.control.btn_Minus:SetPosY(AlchemyStone.control.btn_Plus:GetPosY() + 20)
  elseif 2 == tabIdx then
    AlchemyStone.control.slotBg_1:SetPosX(50)
    AlchemyStone.control.slotBg_1:SetPosY(150)
    AlchemyStone.control.slotBg_2:SetPosX(50)
    AlchemyStone.control.slotBg_2:SetPosY(255)
    AlchemyStone.control.Slot_1:SetPosX(118)
    AlchemyStone.control.Slot_1:SetPosY(330)
    AlchemyStone.control.Slot_2:SetPosX(118)
    AlchemyStone.control.Slot_2:SetPosY(197)
    AlchemyStone.control.resultSlotBg:SetSize(AlchemyStone.control.resultSlotBg:GetSizeX(), 98)
    AlchemyStone.control.slotBg_1:SetShow(false)
    AlchemyStone.control.slotBg_2:SetShow(false)
    AlchemyStone.control.resultSlotBg:SetShow(true)
    AlchemyStone.control.resultSlotBg:SetPosX(380)
    AlchemyStone.control.resultSlotBg:SetPosY(230)
    AlchemyStone.resultSlotBg[0]:SetShow(true)
    AlchemyStone.resultSlotBg[1]:SetShow(false)
    AlchemyStone.resultSlotBg[2]:SetShow(false)
    AlchemyStone.control.resultSlot:SetShow(false)
    AlchemyStone.resultSlotBg[0]:SetPosX(436)
    AlchemyStone.resultSlotBg[0]:SetPosY(252)
    AlchemyStone.control.upgradeSlotBg:SetShow(true)
  end
  AlchemyStone.control.progressBg_1:SetShow(false)
  AlchemyStone.control.progress_1:SetShow(false)
  AlchemyStone.control.progress_1_Pre:SetShow(false)
  AlchemyStone.control.progressText_1:SetShow(false)
  AlchemyStone.control.progressBg_2:SetShow(false)
  AlchemyStone.control.progress_2:SetShow(false)
  AlchemyStone.control.progressText_2:SetShow(false)
  AlchemyStone.control.count:SetShow(false)
  AlchemyStone.control.expMaterial:SetShow(false)
  AlchemyStone.control.expMaterial2:SetShow(false)
  AlchemyStone.control.progress_1:SetProgressRate(0)
  AlchemyStone.control.progress_1_Pre:SetProgressRate(0)
  AlchemyStone.control.progress_2:SetProgressRate(0)
  AlchemyStone.control.btn_Doit:SetMonoTone(true)
  AlchemyStone.control.btn_Doit:SetEnable(false)
  AlchemyStone.resultItemKey = {}
  AlchemyStone.resultItemIndex = -1
end
function HandleClicked_AlchemyStone_ChangeStuffCount(isUp)
  if AlchemyStone.fromCount < toInt64(0, 1) then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_ALCHEMYSTONE_NOTSETSTUFF"))
    return
  end
  if true == isUp then
    if toInt64(0, AlchemyStone.maxRecoverCount) <= AlchemyStone.fromCount then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_ALCHEMYSTONE_MAXCHARGECOUNT"))
      return
    elseif AlchemyStone.fromMaxCount <= AlchemyStone.fromCount then
      return
    end
    AlchemyStone.fromCount = AlchemyStone.fromCount + toInt64(0, 1)
  else
    if AlchemyStone.fromCount <= toInt64(0, 1) then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_ALCHEMYSTONE_MUSTMOREONE"))
      return
    end
    AlchemyStone.fromCount = AlchemyStone.fromCount - toInt64(0, 1)
  end
  AlchemyStone.Stuff_slot.count:SetText(tostring(AlchemyStone.fromCount))
  AlchemyStone:updateProgressBar()
end
function HandleClicked_AlchemyStoneTab_Tooltip(isOn, buttonType)
  if true == isOn then
    local control
    local name = ""
    local desc = ""
    if AlchemyStoneTab.Charge == buttonType then
      control = AlchemyStone.control.tab_Charge
      name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_ALCHEMYSTONE_BTN_CHARGE")
      desc = PAGetString(Defines.StringSheet_GAME, "LUA_ALCHEMYSTONE_RADIO_0_TOOLTIP_DESC")
    elseif AlchemyStoneTab.Exp == buttonType then
      control = AlchemyStone.control.tab_Exp
      name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_ALCHEMYSTONE_BTN_EXP")
      desc = PAGetString(Defines.StringSheet_GAME, "LUA_ALCHEMYSTONE_RADIO_1_TOOLTIP_DESC")
    elseif AlchemyStoneTab.Upgrade == buttonType then
      control = AlchemyStone.control.tab_Upgrade
      name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_ALCHEMYSTONE_BTN_UPGRADE")
      desc = PAGetString(Defines.StringSheet_GAME, "LUA_ALCHEMYSTONE_RADIO_2_TOOLTIP_DESC")
    elseif AlchemyStoneTab.RandomOption == buttonType then
      control = AlchemyStone.control.tab_RandomOption
      name = "\235\158\156\235\141\164 \236\152\181\236\133\152"
      desc = "\235\172\180\236\158\145\236\156\132\235\161\156 \236\151\176\234\184\136\236\132\157\236\151\144 \235\139\164\236\150\145\237\149\156 \236\152\181\236\133\152\236\157\180 \235\182\128\236\151\172\235\144\169\235\139\136\235\139\164."
    end
    registTooltipControl(control, Panel_Tooltip_SimpleText)
    TooltipSimple_Show(control, name, desc)
  else
    TooltipSimple_Hide()
  end
end
function HandleClicked_AlchemyStone_Doit()
  local function doUpgrade()
    AlchemyStone.isPushDoit = true
    Inventory_SetFunctor(AlchemyStone_MaterialFilterAllNot, nil, nil, nil)
  end
  local itemWrapper = getInventoryItemByType(AlchemyStone.toWhereType, AlchemyStone.toSlotNo)
  local itemSSW = itemWrapper:getStaticStatus()
  local itemGrade = itemSSW:getGradeType()
  local itemContentsParam2 = itemSSW:get()._contentsEventParam2
  local msgTitle = PAGetString(Defines.StringSheet_GAME, "LUA_ALCHEMYSTONE_MSGBOX_TITLE")
  local msgContent = ""
  if AlchemyStone.selectedTabIdx == AlchemyStoneTab.Upgrade then
    if 0 ~= checkToEvolveAlchemyStone() then
      return
    end
    if 3 == itemContentsParam2 or 4 == itemContentsParam2 then
      msgContent = PAGetString(Defines.StringSheet_GAME, "LUA_ALCHEMYSTONE_MSGBOX_CONTENT1")
    elseif 5 == itemContentsParam2 or 6 == itemContentsParam2 then
      msgContent = PAGetString(Defines.StringSheet_GAME, "LUA_ALCHEMYSTONE_MSGBOX_CONTENT2")
    elseif 7 == itemContentsParam2 then
      if itemGrade < 3 then
        msgContent = PAGetString(Defines.StringSheet_GAME, "LUA_ALCHEMYSTONE_MSGBOX_CONTENT2")
      end
    else
      AlchemyStone.isPushDoit = true
      Inventory_SetFunctor(AlchemyStone_MaterialFilterAllNot, nil, nil, nil)
    end
    if "" ~= msgContent then
      local messageBoxData = {
        title = msgTitle,
        content = msgContent,
        functionYes = doUpgrade,
        functionNo = MessageBox_Empty_function,
        priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
      }
      MessageBox.showMessageBox(messageBoxData, "middle")
    end
  elseif AlchemyStone.selectedTabIdx == AlchemyStoneTab.Charge then
    if itemContentsParam2 + 1 <= Int64toInt32(AlchemyStone.fromCount) then
      AlchemyStone.isPushDoit = true
      Inventory_SetFunctor(AlchemyStone_MaterialFilterAllNot, nil, nil, nil)
    else
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_ALCHEMYSTONE_WARN_2"))
    end
  elseif AlchemyStone.selectedTabIdx == AlchemyStoneTab.Exp then
    local alchemystoneExp = itemWrapper:getExperience() / 10000
    if 150 <= alchemystoneExp then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_ALCHEMYSTONE_EXPMAX_WARRING"))
      return
    end
    AlchemyStone.isPushDoit = true
    Inventory_SetFunctor(AlchemyStone_MaterialFilterAllNot, nil, nil, nil)
  else
    AlchemyStone.isPushDoit = true
    Inventory_SetFunctor(AlchemyStone_MaterialFilterAllNot, nil, nil, nil)
  end
  doItType = AlchemyStone.selectedTabIdx
  AlchemyStone.control.contentEffect:SetShow(true)
  AlchemyStone.control.btn_Doit:SetMonoTone(AlchemyStone.isPushDoit)
  AlchemyStone.control.btn_Doit:SetEnable(not AlchemyStone.isPushDoit)
  audioPostEvent_SystemUi(1, 43)
  _AudioPostEvent_SystemUiForXBOX(1, 43)
end
function HandleClicked_AlchemyStone_Close()
  Panel_AlchemyStone:SetShow(false)
  Panel_AlchemyStone:CloseUISubApp()
  AlchemyStone:ClearData(nil, false)
  doItType = -1
  local isInvenOpen = false
  if true == _ContentsGroup_NewUI_Inventory_All then
    isInvenOpen = Panel_Window_Inventory_All:GetShow()
  else
    isInvenOpen = Panel_Window_Inventory:GetShow()
  end
  if true == isInvenOpen then
    Inventory_SetFunctor(nil, nil, nil, nil)
    if true == _ContentsGroup_NewUI_Equipment_All then
      PaGlobalFunc_Equipment_All_SetShow(true)
    else
      Equipment_SetShow(true)
    end
  end
end
function HandleClicked_AlchemyStone_UnSetSlot(slotType)
  if 0 == slotType then
    if false == AlchemyStone.Stone_slot.Empty and false == AlchemyStone.isPushDoit then
      AlchemyStone.Stone_slot:clearItem()
      AlchemyStone.Stone_slot.Empty = true
      AlchemyStone.Stuff_slot:clearItem()
      AlchemyStone.Stuff_slot.Empty = true
      AlchemyStone.control.progressBg_1:SetShow(false)
      AlchemyStone.control.progress_1:SetShow(false)
      AlchemyStone.control.progress_1_Pre:SetShow(false)
      AlchemyStone.control.progressText_1:SetShow(false)
      AlchemyStone.control.progressBg_2:SetShow(false)
      AlchemyStone.control.progress_2:SetShow(false)
      AlchemyStone.control.progressText_2:SetShow(false)
      AlchemyStone.control.count:SetShow(false)
      AlchemyStone.control.expMaterial:SetShow(false)
      AlchemyStone.control.expMaterial2:SetShow(false)
      AlchemyStone.control.progress_1:SetProgressRate(0)
      AlchemyStone.control.progress_1_Pre:SetProgressRate(0)
      AlchemyStone.control.progress_2:SetProgressRate(0)
      AlchemyStone.control.chargeDesc:SetShow(false)
      AlchemyStone.control.chargeDesc:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_ALCHEMYSTONE_DESC_5", "needCountMin", 0))
      AlchemyStone.Stone_slot.icon:addInputEvent("Mouse_On", "")
      AlchemyStone.Stone_slot.icon:addInputEvent("Mouse_Out", "")
      AlchemyStone.Stuff_slot.icon:addInputEvent("Mouse_On", "")
      AlchemyStone.Stuff_slot.icon:addInputEvent("Mouse_Out", "")
      AlchemyStone.control.btn_Doit:SetMonoTone(true)
      AlchemyStone.control.btn_Doit:SetEnable(false)
      AlchemyStone.control.resultSlotBg:SetSize(AlchemyStone.control.resultSlotBg:GetSizeX(), 98)
      AlchemyStone.control.resultSlotBg:SetShow(false)
      AlchemyStone.control.resultSlotBg:SetPosX(380)
      AlchemyStone.control.resultSlotBg:SetPosY(230)
      AlchemyStone.resultSlotBg[0]:SetShow(false)
      AlchemyStone.resultSlotBg[0]:SetPosX(437)
      AlchemyStone.resultSlotBg[0]:SetPosY(253)
      AlchemyStone.resultSlotBg[1]:SetShow(false)
      AlchemyStone.resultSlotBg[2]:SetShow(false)
      AlchemyStone.resultSlot[0]:clearItem()
      AlchemyStone.resultSlot[0].Empty = true
      AlchemyStone.resultSlot[1]:clearItem()
      AlchemyStone.resultSlot[1].Empty = true
      AlchemyStone.resultSlot[2]:clearItem()
      AlchemyStone.resultSlot[2].Empty = true
      AlchemyStone.resultSlot[0].icon:addInputEvent("Mouse_On", "")
      AlchemyStone.resultSlot[0].icon:addInputEvent("Mouse_Out", "")
      AlchemyStone.resultSlot[1].icon:addInputEvent("Mouse_On", "")
      AlchemyStone.resultSlot[1].icon:addInputEvent("Mouse_Out", "")
      AlchemyStone.resultSlot[2].icon:addInputEvent("Mouse_On", "")
      AlchemyStone.resultSlot[2].icon:addInputEvent("Mouse_Out", "")
      Inventory_SetFunctor(AlchemyStone_StoneFilter, AlchemyStone_StoneRfunction, nil, nil)
      if Panel_NumberPad_IsPopUp() then
        if false == _ContentsGroup_NewUI_NumberPad_All then
          Panel_NumberPad_ButtonCancel_Mouse_Click()
        else
          HandleEventLUp_NumberPad_All_CancelButton_Click()
        end
      end
    end
  elseif false == AlchemyStone.Stuff_slot.Empty and false == AlchemyStone.isPushDoit then
    AlchemyStone.Stuff_slot:clearItem()
    AlchemyStone.Stuff_slot.Empty = true
    AlchemyStone.Stuff_slot.icon:addInputEvent("Mouse_On", "")
    AlchemyStone.Stuff_slot.icon:addInputEvent("Mouse_Out", "")
    AlchemyStone.control.btn_Doit:SetMonoTone(true)
    AlchemyStone.control.btn_Doit:SetEnable(false)
    AlchemyStone.control.count:SetShow(false)
    Inventory_SetFunctor(AlchemyStone_StuffFilter, AlchemyStone_StuffRfunction, nil, nil)
    AlchemyStone.fromCount = 0
    AlchemyStone:updateProgressBar()
  end
  if AlchemyStoneTab.Upgrade == AlchemyStone.selectedTabIdx then
    AlchemyStone.control.resultSlotBg:SetShow(true)
    AlchemyStone.resultSlotBg[0]:SetShow(true)
  end
  AlchemyStone.resultItemKey = {}
  AlchemyStone.resultItemIndex = -1
  if nil ~= Panel_Tooltip_Item_hideTooltip then
    Panel_Tooltip_Item_hideTooltip()
  end
end
function AlchemyStone_ItemToolTip(isShow, slotType)
  if true == isShow then
    local control, itemWrapper
    if 0 == slotType then
      control = AlchemyStone.Stone_slot.icon
      if -1 ~= AlchemyStone.toWhereType then
        itemWrapper = getInventoryItemByType(AlchemyStone.toWhereType, AlchemyStone.toSlotNo)
        Panel_Tooltip_Item_Show(itemWrapper, control, false, true, nil, nil, nil)
      else
        return
      end
    else
      control = AlchemyStone.Stuff_slot.icon
      if -1 ~= AlchemyStone.fromWhereType then
        itemWrapper = getInventoryItemByType(AlchemyStone.fromWhereType, AlchemyStone.fromSlotNo)
        Panel_Tooltip_Item_Show(itemWrapper, control, false, true, nil, nil, nil)
      else
        return
      end
    end
  else
    Panel_Tooltip_Item_hideTooltip()
  end
end
function AlchemyStone_ResultItemTooltip(isShow, index)
  if not isShow then
    Panel_Tooltip_Item_hideTooltip()
    return
  end
  local itemWrapper = getInventoryItemByType(AlchemyStone.toWhereType, AlchemyStone.toSlotNo)
  if nil ~= itemWrapper then
    local itemSSW = itemWrapper:getStaticStatus()
    local resultItemWrapper = getAlchemyEvolveItemStaticStatusWrapper(itemSSW:get()._key:getItemKey(), index)
    Panel_Tooltip_Item_Show(resultItemWrapper, AlchemyStone.resultSlot[index].icon, true, false, nil, nil, nil)
  end
end
function AlchemyStone_StoneFilter(slotNo, itemWrapper, count, inventoryType)
  local returnValue = true
  if nil == itemWrapper:getStaticStatus() then
    return returnValue
  end
  if 32 == itemWrapper:getStaticStatus():get():getContentsEventType() then
    local alchemyStoneType = itemWrapper:getStaticStatus():get()._contentsEventParam1
    local contentsEventParam2 = itemWrapper:getStaticStatus():get()._contentsEventParam2
    if AlchemyStone.control.tab_Upgrade:IsCheck() then
      if true == AlchemyStone:isAlchemyBellHeart(alchemyStoneType, contentsEventParam2) then
        return true
      end
      if 7 == contentsEventParam2 then
        returnValue = true
      else
        returnValue = false
      end
    elseif AlchemyStone.control.tab_Charge:IsCheck() then
      if itemWrapper:get():getEndurance() == itemWrapper:get():getMaxEndurance() then
        returnValue = true
      else
        returnValue = false
      end
    elseif AlchemyStone.control.tab_Exp:IsCheck() then
      if true == AlchemyStone:isAlchemyBellHeart(alchemyStoneType, contentsEventParam2) then
        return true
      end
      returnValue = false
    else
      if true == itemWrapper:isRandomOptionTarget() then
        return false
      end
      returnValue = true
    end
  end
  return returnValue
end
function AlchemyStone_MaterialFilterAllNot(slotNo, itemWrapper, count, inventoryType)
  return true
end
function AlchemyStone:isAlchemyBellHeart(alchemyStoneType, contentsEventParam2)
  if 6 == alchemyStoneType or 7 == alchemyStoneType then
    return true
  end
  return false
end
function AlchemyStone_StoneRfunction(slotNo, itemWrapper, count, inventoryType)
  AlchemyStone.toWhereType = inventoryType
  AlchemyStone.toSlotNo = slotNo
  AlchemyStone.selectedStoneType = itemWrapper:getStaticStatus():get()._contentsEventParam1
  AlchemyStone.selectedStoneItemKey = itemWrapper:get():getKey()
  AlchemyStone.recoverCount = itemWrapper:getStaticStatus():get():getAlchemyStoneGrade()
  AlchemyStone.randomSourceKey = 1
  AlchemyStone.Stone_slot:setItem(itemWrapper)
  AlchemyStone.Stone_slot.Empty = false
  local currentEndurance = itemWrapper:get():getEndurance()
  local maxEndurance = itemWrapper:get():getMaxEndurance()
  local alchemystoneExp = itemWrapper:getExperience() / 10000
  local itemSSW = itemWrapper:getStaticStatus()
  local itemContentsParam1 = itemSSW:get()._contentsEventParam1
  local itemContentsParam2 = itemSSW:get()._contentsEventParam2
  AlchemyStone.maxEndurance = maxEndurance
  AlchemyStone.currentEndurance = currentEndurance
  AlchemyStone.toLostEndurance = maxEndurance - currentEndurance
  AlchemyStone.Stone_slot.icon:addInputEvent("Mouse_On", "AlchemyStone_ItemToolTip( true, " .. 0 .. " )")
  AlchemyStone.Stone_slot.icon:addInputEvent("Mouse_Out", "AlchemyStone_ItemToolTip( false )")
  Inventory_SetFunctor(AlchemyStone_StuffFilter, AlchemyStone_StuffRfunction, nil, nil)
  AlchemyStone.control.count:SetShow(false)
  AlchemyStone.control.expMaterial:SetShow(false)
  AlchemyStone.control.expMaterial2:SetShow(false)
  local guideText = ""
  if AlchemyStoneTab.Charge == AlchemyStone.selectedTabIdx then
    guideText = PAGetString(Defines.StringSheet_GAME, "LUA_ALCHEMYSTONE_SELECT_CHARGE")
    AlchemyStone.control.progressBg_2:SetShow(false)
    AlchemyStone.control.progress_2:SetShow(false)
    AlchemyStone.control.progressText_2:SetShow(false)
    AlchemyStone.control.progressBg_1:SetShow(true)
    AlchemyStone.control.progress_1:SetShow(true)
    AlchemyStone.control.progress_1_Pre:SetShow(true)
    AlchemyStone.control.progressText_1:SetShow(true)
    AlchemyStone.control.chargeDesc:SetShow(true)
    AlchemyStone.control.progress_1:SetProgressRate(currentEndurance / maxEndurance * 100)
    AlchemyStone.control.progress_1_Pre:SetProgressRate(currentEndurance / maxEndurance * 100)
    local endurancePoint = currentEndurance .. " / " .. maxEndurance
    AlchemyStone.control.progressText_1:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_ALCHEMYSTONE_ENDURANCE", "endurance", endurancePoint))
    AlchemyStone.control.chargeDesc:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_ALCHEMYSTONE_DESC_5", "needCountMin", itemContentsParam2 + 1))
  elseif AlchemyStoneTab.Exp == AlchemyStone.selectedTabIdx then
    guideText = PAGetString(Defines.StringSheet_GAME, "LUA_ALCHEMYSTONE_SELECT_EXP")
    AlchemyStone.control.progressBg_1:SetShow(false)
    AlchemyStone.control.progress_1:SetShow(false)
    AlchemyStone.control.progress_1_Pre:SetShow(false)
    AlchemyStone.control.progressText_1:SetShow(false)
    AlchemyStone.control.progressBg_2:SetShow(true)
    AlchemyStone.control.progress_2:SetShow(true)
    AlchemyStone.control.progressText_2:SetShow(true)
    AlchemyStone.control.progress_2:SetProgressRate(alchemystoneExp)
    local _exp = string.format("%.2f", alchemystoneExp)
    AlchemyStone.control.progressText_2:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_ALCHEMYSTONE_EXPERIENCE", "exp", _exp))
    AlchemyStone.control.expMaterial:SetShow(true)
    AlchemyStone.control.expMaterial2:SetShow(true)
    if 0 == itemContentsParam1 then
      AlchemyStone.control.expMaterial:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_ALCHEMYSTONE_PURESTONE"))
      AlchemyStone.control.expMaterial2:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_ALCHEMYSTONE_PURESTONE2"))
    elseif 1 == itemContentsParam1 then
      AlchemyStone.control.expMaterial:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_ALCHEMYSTONE_HARDWOOD"))
      AlchemyStone.control.expMaterial2:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_ALCHEMYSTONE_HARDWOOD2"))
    elseif 2 == itemContentsParam1 then
      AlchemyStone.control.expMaterial:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_ALCHEMYSTONE_CHOICEGOOD"))
      AlchemyStone.control.expMaterial2:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_ALCHEMYSTONE_CHOICEGOOD2"))
    end
  elseif AlchemyStoneTab.Upgrade == AlchemyStone.selectedTabIdx then
    AlchemyStone.control.progressBg_1:SetShow(false)
    AlchemyStone.control.progress_1:SetShow(false)
    AlchemyStone.control.progress_1_Pre:SetShow(false)
    AlchemyStone.control.progressText_1:SetShow(false)
    AlchemyStone.control.progressBg_2:SetShow(false)
    AlchemyStone.control.progress_2:SetShow(false)
    AlchemyStone.control.progressText_2:SetShow(false)
    AlchemyStone.control.expMaterial:SetShow(true)
    AlchemyStone.control.expMaterial2:SetShow(false)
    local itemWrapper = getInventoryItemByType(AlchemyStone.toWhereType, AlchemyStone.toSlotNo)
    local itemSSW = itemWrapper:getStaticStatus()
    local itemGrade = itemSSW:getGradeType()
    local itemContentsParam1 = itemSSW:get()._contentsEventParam1
    local itemContentsParam2 = itemSSW:get()._contentsEventParam2
    local resultCount = getAlchemyEvolveItemSize(itemSSW:get()._key:getItemKey())
    local resultAlchemyStone = {}
    for index = 0, 2 do
      if index < resultCount then
        local resultItemWrapper = getAlchemyEvolveItemStaticStatusWrapper(itemSSW:get()._key:getItemKey(), index)
        AlchemyStone.resultSlot[index]:setItemByStaticStatus(resultItemWrapper, 1, nil, nil, nil)
        AlchemyStone.resultSlot[index].icon:addInputEvent("Mouse_On", "AlchemyStone_ResultItemTooltip(true, " .. index .. ")")
        AlchemyStone.resultSlot[index].icon:addInputEvent("Mouse_Out", "AlchemyStone_ResultItemTooltip(false, " .. index .. ")")
        AlchemyStone.resultSlotBg[index]:SetShow(true)
        AlchemyStone.resultItemKey[index] = resultItemWrapper:get()._key:getItemKey()
      else
        AlchemyStone.resultSlotBg[index]:SetShow(false)
      end
    end
    if itemContentsParam2 <= 2 then
      AlchemyStone.control.expMaterial:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_ALCHEMYSTONE_EXPDOWN"))
    elseif itemContentsParam2 <= 4 then
      AlchemyStone.control.expMaterial:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_ALCHEMYSTONE_EXPDOWN") .. "\n" .. PAGetString(Defines.StringSheet_GAME, "LUA_ALCHEMYSTONE_GRADEDOWN"))
    elseif itemContentsParam2 <= 6 then
      AlchemyStone.control.expMaterial:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_ALCHEMYSTONE_EXPDOWN") .. "\n" .. PAGetString(Defines.StringSheet_GAME, "LUA_ALCHEMYSTONE_STONEDESTROY"))
    end
    guideText = PAGetString(Defines.StringSheet_GAME, "LUA_ALCHEMYSTONE_SELECT_UPGRADE")
    if 1 == resultCount then
      AlchemyStone.control.resultSlotBg:SetSize(AlchemyStone.control.resultSlotBg:GetSizeX(), 98)
      AlchemyStone.control.resultSlotBg:SetPosX(380)
      AlchemyStone.control.resultSlotBg:SetPosY(230)
      AlchemyStone.resultSlotBg[0]:SetPosX(437)
      AlchemyStone.resultSlotBg[0]:SetPosY(253)
    elseif 2 == resultCount then
      AlchemyStone.control.resultSlotBg:SetSize(AlchemyStone.control.resultSlotBg:GetSizeX(), 158)
      AlchemyStone.control.resultSlotBg:SetPosX(380)
      AlchemyStone.control.resultSlotBg:SetPosY(207)
      AlchemyStone.resultSlotBg[0]:SetPosX(437)
      AlchemyStone.resultSlotBg[0]:SetPosY(230)
      AlchemyStone.resultSlotBg[1]:SetPosX(437)
      AlchemyStone.resultSlotBg[1]:SetPosY(290)
    else
      if 3 == resultCount then
        AlchemyStone.control.resultSlotBg:SetSize(AlchemyStone.control.resultSlotBg:GetSizeX(), 218)
        AlchemyStone.control.resultSlotBg:SetPosX(380)
        AlchemyStone.control.resultSlotBg:SetPosY(175)
        AlchemyStone.resultSlotBg[0]:SetPosX(437)
        AlchemyStone.resultSlotBg[0]:SetPosY(198)
        AlchemyStone.resultSlotBg[1]:SetPosX(437)
        AlchemyStone.resultSlotBg[1]:SetPosY(258)
        AlchemyStone.resultSlotBg[2]:SetPosX(437)
        AlchemyStone.resultSlotBg[2]:SetPosY(318)
      else
      end
    end
  elseif AlchemyStoneTab.RandomOption == AlchemyStone.selectedTabIdx then
    guideText = "\234\176\128\235\176\169\236\151\144\236\132\156 \235\158\156\235\141\164 \236\152\181\236\133\152 \236\158\172\235\163\140\235\165\188 \236\132\160\237\131\157\237\149\180 \236\163\188\236\132\184\236\154\148"
    AlchemyStone.control.progressBg_1:SetShow(false)
    AlchemyStone.control.progress_1:SetShow(false)
    AlchemyStone.control.progress_1_Pre:SetShow(false)
    AlchemyStone.control.progressText_1:SetShow(false)
    AlchemyStone.control.progressBg_2:SetShow(false)
    AlchemyStone.control.progress_2:SetShow(false)
    AlchemyStone.control.progressText_2:SetShow(false)
    AlchemyStone.control.progress_2:SetProgressRate(alchemystoneExp)
    local _exp = string.format("%.2f", alchemystoneExp)
    AlchemyStone.control.progressText_2:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_ALCHEMYSTONE_EXPERIENCE", "exp", _exp))
    AlchemyStone.control.expMaterial:SetShow(true)
    AlchemyStone.control.expMaterial2:SetShow(true)
    AlchemyStone.control.expMaterial:SetText("\236\185\184\236\157\152 \236\139\172\236\158\165 : \237\140\140\234\180\180")
    AlchemyStone.control.expMaterial2:SetText("\236\185\184\236\157\152 \236\139\172\236\158\165 : \236\136\152\237\152\184")
  end
  AlchemyStone.control.guideString:SetText(guideText)
end
function AlchemyStone_StuffFilter(slotNo, itemWrapper, count, inventoryType)
  local returnValue = true
  local staticStatus = itemWrapper:getStaticStatus()
  if nil == staticStatus or -1 == AlchemyStone.selectedStoneType then
    return returnValue
  end
  if AlchemyStoneTab.Charge == AlchemyStone.selectedTabIdx then
    if staticStatus:isAlchemyRepair(AlchemyStone.selectedStoneType) then
      returnValue = false
    end
  elseif AlchemyStoneTab.Exp == AlchemyStone.selectedTabIdx then
    if staticStatus:isAlchemyUpgradeItem(AlchemyStone.selectedStoneType) then
      returnValue = false
    end
  elseif AlchemyStoneTab.Upgrade == AlchemyStone.selectedTabIdx then
    local itemKey = itemWrapper:get():getKey()
    if staticStatus:isAlchemyUpgradeMaterial(AlchemyStone.selectedStoneItemKey) then
      returnValue = false
    end
  elseif AlchemyStoneTab.RandomOption == AlchemyStone.selectedTabIdx and true == itemWrapper:isRandomOptionMaterial(AlchemyStone.randomSourceKey) then
    returnValue = false
  end
  return returnValue
end
function AlchemyStone:updateProgressBar()
  local progressRate = 0
  local itemWrapper = getInventoryItemByType(AlchemyStone.toWhereType, AlchemyStone.toSlotNo)
  if nil == itemWrapper then
    return
  end
  local itemSSW = itemWrapper:getStaticStatus()
  local itemGradeNum = itemSSW:get()._contentsEventParam2 + 1
  local stuffCount = Int64toInt32(AlchemyStone.fromCount)
  if 0 < AlchemyStone.currentEndurance then
    progressRate = AlchemyStone.currentEndurance / AlchemyStone.maxEndurance * 100
  end
  if stuffCount >= AlchemyStone.maxRecoverCount then
    progressRate = 100
  else
    if 0 ~= stuffCount % itemGradeNum then
      stuffCount = math.floor(stuffCount / itemGradeNum) * itemGradeNum
    end
    progressRate = progressRate + AlchemyStone.toLostEndurance / AlchemyStone.maxEndurance / AlchemyStone.maxRecoverCount * stuffCount * 100
  end
  AlchemyStone.control.progress_1_Pre:SetProgressRate(progressRate)
end
function AlchemyStone_StuffRfunction(slotNo, itemWrapper, count, inventoryType)
  local itemSSW = itemWrapper:getStaticStatus()
  local itemKey = itemSSW:get()._key
  local guideText = ""
  if false == AlchemyStone.Stuff_slot.Empty then
    HandleClicked_AlchemyStone_UnSetSlot(1)
  end
  AlchemyStone.fromWhereType = inventoryType
  AlchemyStone.fromSlotNo = slotNo
  AlchemyStone.fromCount = toInt64(0, 0)
  AlchemyStone.fromMaxCount = count
  local function setStuffFunc(itemCount)
    AlchemyStone.fromCount = itemCount
    local itemSSW = getItemEnchantStaticStatus(itemKey)
    AlchemyStone.Stuff_slot:setItemByStaticStatus(itemSSW, AlchemyStone.fromCount, nil, nil, nil)
    AlchemyStone.Stuff_slot.Empty = false
    AlchemyStone.Stuff_slot.icon:addInputEvent("Mouse_On", "AlchemyStone_ItemToolTip( true, " .. 1 .. " )")
    AlchemyStone.Stuff_slot.icon:addInputEvent("Mouse_Out", "AlchemyStone_ItemToolTip( false )")
    AlchemyStone.control.btn_Doit:SetMonoTone(AlchemyStone.isPushDoit)
    AlchemyStone.control.btn_Doit:SetEnable(not AlchemyStone.isPushDoit)
    AlchemyStone.control.guideString:SetText(guideText)
    AlchemyStone:updateProgressBar()
  end
  AlchemyStone.control.count:SetShow(false)
  if AlchemyStoneTab.Charge == AlchemyStone.selectedTabIdx then
    guideText = PAGetString(Defines.StringSheet_GAME, "LUA_ALCHEMYSTONE_DOIT_CHARGE")
    AlchemyStone.chargePoint = ToClient_GetAlchmeyStoneChargePoint(AlchemyStone.toWhereType, AlchemyStone.toSlotNo, AlchemyStone.fromWhereType, AlchemyStone.fromSlotNo)
    AlchemyStone.maxRecoverCount = math.ceil(AlchemyStone.toLostEndurance / AlchemyStone.chargePoint) * AlchemyStone.recoverCount
    if 0 >= AlchemyStone.maxRecoverCount then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_ALCHEMYSTONE_WARN_1"))
      return
    end
    local string = PAGetStringParam3(Defines.StringSheet_GAME, "LUA_ALCHEMYSTONE_NEEDMAXCHARGECOUNT", "count1", AlchemyStone.maxRecoverCount, "count2", AlchemyStone.recoverCount, "count3", AlchemyStone.chargePoint)
    AlchemyStone.control.count:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_ALCHEMYSTONE_NEEDMATERIALCOUNT", "count", AlchemyStone.maxRecoverCount))
    AlchemyStone.control.count:SetShow(true)
  elseif AlchemyStoneTab.Exp == AlchemyStone.selectedTabIdx then
    guideText = PAGetString(Defines.StringSheet_GAME, "LUA_ALCHEMYSTONE_DOIT_EXP")
  elseif AlchemyStoneTab.Upgrade == AlchemyStone.selectedTabIdx then
    guideText = PAGetString(Defines.StringSheet_GAME, "LUA_ALCHEMYSTONE_DOIT_UPGRADE")
  elseif AlchemyStoneTab.RandomOption == AlchemyStone.selectedTabIdx then
    guideText = "\235\158\156\235\141\164 \236\152\181\236\133\152\236\157\132 \235\136\132\235\165\180\235\169\180 \236\152\181\236\133\152 \235\182\128\236\151\172\234\176\128 \236\139\156\236\158\145\235\144\169\235\139\136\235\139\164"
  end
  if count > toInt64(0, 1) then
    Panel_NumberPad_Show(true, count, nil, setStuffFunc, false, nil, nil)
  else
    setStuffFunc(toInt64(0, 1))
  end
end
function FGlobal_AlchemyStone_Open()
  local isAlchemyStoneEnble = ToClient_IsContentsGroupOpen("35")
  if not isAlchemyStoneEnble then
    return
  end
  if false == _ContentsGroup_NewUI_AlchemyFigureHead_All then
    if nil ~= Panel_AlchemyFigureHead and Panel_AlchemyFigureHead:GetShow() then
      FGlobal_AlchemyFigureHead_Close()
    end
  elseif nil ~= Panel_AlchemyFigureHead_All and Panel_AlchemyFigureHead_All:GetShow() then
    PaGlobal_AlchemyFigureHead_All_Close()
  end
  if not _ContentsGroup_RenewUI_Manufacture then
    if false == _ContentsGroup_NewUI_Manufacture_All then
      if true == Panel_Manufacture:GetShow() then
        Manufacture_Close()
      end
    elseif true == Panel_Window_Manufacture_All:GetShow() then
      PaGlobalFunc_Manufacture_All_Close()
    end
  end
  if Panel_DyePalette:GetShow() then
    FGlobal_DyePalette_Close()
  end
  if true == _ContentsGroup_NewUI_Inventory_All then
    PaGlobalFunc_Inventory_All_SetInventoryDragNoUse(Panel_AlchemyStone)
  else
    FGlobal_SetInventoryDragNoUse(Panel_AlchemyStone)
  end
  Panel_AlchemyStone:SetShow(true)
  AlchemyStone.control.tab_Charge:SetCheck(true)
  AlchemyStone.control.tab_Exp:SetCheck(false)
  AlchemyStone.control.tab_Upgrade:SetCheck(false)
  AlchemyStone.control.tab_RandomOption:SetCheck(false)
  AlchemyStone:ClearData(true, false)
  HandleClicked_AlchemyStoneTab(0)
  doItType = 0
  if true == _ContentsGroup_NewUI_Inventory_All then
    if Panel_Window_Inventory_All:IsUISubApp() then
      Panel_AlchemyStone:OpenUISubApp()
    end
  elseif Panel_Window_Inventory:IsUISubApp() then
    Panel_AlchemyStone:OpenUISubApp()
  end
  if not _ContentsGroup_RenewUI then
    if true == _ContentsGroup_NewUI_Equipment_All then
      if Panel_Window_Equipment_All:GetShow() then
        PaGlobalFunc_Equipment_All_Close(false)
      end
    elseif Panel_Equipment:GetShow() then
      EquipmentWindow_Close()
    end
    if true == _ContentsGroup_NewUI_ClothInventory_All then
      PaGlobalFunc_ClothInventory_All_Close()
    else
      ClothInventory_Close()
    end
  end
  InventoryWindow_Show()
  Inventory_SetFunctor(AlchemyStone_StoneFilter, AlchemyStone_StoneRfunction, nil, nil)
end
function FGlobal_AlchemyStone_Close()
  HandleClicked_AlchemyStone_Close()
end
function FGlobal_AlchemyStone_Use()
  local itemWrapper = ToClient_getEquipmentItem(CppEnums.EquipSlotNo.alchemyStone)
  if nil ~= itemWrapper and 0 < itemWrapper:get():getEndurance() then
    useAlchemyStone()
  end
end
local elapsTime = 0
local isUpgrade = false
function Panel_AlchemyStone_updateTime(deltaTime)
  if AlchemyStone.isPushDoit then
    elapsTime = elapsTime + deltaTime
    if 0 < elapsTime and false == AlchemyStone.startEffectPlay then
      AlchemyStone.control.btn_Doit:SetMonoTone(true)
      AlchemyStone.control.btn_Doit:SetEnable(false)
      AlchemyStone.Stuff_slot.icon:EraseAllEffect()
      AlchemyStone.Stuff_slot.icon:AddEffect("fUI_Alchemy_UpgradeStart01", false, 3, 0)
      AlchemyStone.startEffectPlay = true
      if AlchemyStoneTab.Charge == doItType or AlchemyStoneTab.Exp == doItType or AlchemyStoneTab.RandomOption == doItType then
        audioPostEvent_SystemUi(5, 80)
        _AudioPostEvent_SystemUiForXBOX(5, 80)
      elseif AlchemyStoneTab.Upgrade == doItType then
        audioPostEvent_SystemUi(5, 81)
        _AudioPostEvent_SystemUiForXBOX(5, 81)
      end
      if AlchemyStoneTab.Upgrade == doItType then
        AlchemyStone.control.upgradeSlotBg:AddEffect("fUI_Alchemy_Stone_Upgrade03", false)
      end
    end
    if 1 < elapsTime and false == AlchemyStone.contentEffectPlay and not AlchemyStone.control.tab_Upgrade:IsCheck() then
      if AlchemyStoneTab.Charge ~= doItType then
        AlchemyStone.Stuff_slot:clearItem()
        AlchemyStone.Stuff_slot.Empty = true
      end
      AlchemyStone.control.contentEffect:EraseAllEffect()
      local effectName = ""
      if AlchemyStoneTab.Upgrade == doItType then
        effectName = "fUI_Alchemy_Stone_Upgrade01"
      else
        effectName = "fUI_Alchemy_Stone01"
      end
      AlchemyStone.control.contentEffect:AddEffect(effectName, false, 0, -30)
      AlchemyStone.contentEffectPlay = true
    end
    if 2.5 < elapsTime and false == AlchemyStone.slotEffectPlay then
      AlchemyStone.Stone_slot.icon:EraseAllEffect()
      if AlchemyStoneTab.Upgrade == doItType then
        AlchemyStone.Stone_slot.icon:AddEffect("fUI_Alchemy_Stone_Upgrade02", false)
      else
        AlchemyStone.Stone_slot.icon:AddEffect("fUI_Alchemy_Stone02", false)
      end
      AlchemyStone.slotEffectPlay = true
      if AlchemyStone.control.tab_Upgrade:IsCheck() then
        AlchemyStone.Stuff_slot:clearItem()
        AlchemyStone.Stuff_slot.Empty = true
      end
    end
    if 3 < elapsTime and false == AlchemyStone.effectEnd then
      AlchemyStone.effectEnd = true
      AlchemyStone.resultSlotBg[0]:AddEffect("fUI_Alchemy_Stone02", false)
      AlchemyStone.resultSlotBg[1]:AddEffect("fUI_Alchemy_Stone02", false)
      AlchemyStone.resultSlotBg[2]:AddEffect("fUI_Alchemy_Stone02", false)
    end
    if 5 < elapsTime and elapsTime < 9 then
      if AlchemyStoneTab.Charge == doItType then
        alchemyRepair(AlchemyStone.toWhereType, AlchemyStone.toSlotNo, AlchemyStone.fromWhereType, AlchemyStone.fromSlotNo, AlchemyStone.fromCount)
        elapsTime = 0
      elseif AlchemyStoneTab.Exp == doItType then
        alchemyUpgrade(AlchemyStone.fromWhereType, AlchemyStone.fromSlotNo, AlchemyStone.fromCount, AlchemyStone.toWhereType, AlchemyStone.toSlotNo)
        elapsTime = 0
        AlchemyStone.isPushDoit = false
        Inventory_SetFunctor(AlchemyStone_StoneFilter, AlchemyStone_StoneRfunction, nil, nil)
      elseif AlchemyStoneTab.Upgrade == doItType then
        alchemyEvolve(AlchemyStone.fromWhereType, AlchemyStone.fromSlotNo, AlchemyStone.toWhereType, AlchemyStone.toSlotNo)
        elapsTime = 9
      elseif AlchemyStoneTab.RandomOption == doItType then
        requestRandomOption(AlchemyStone.fromWhereType, AlchemyStone.fromSlotNo, AlchemyStone.toWhereType, AlchemyStone.toSlotNo, AlchemyStone.randomSourceKey)
        elapsTime = 0
        AlchemyStone.isPushDoit = false
        Inventory_SetFunctor(AlchemyStone_StoneFilter, AlchemyStone_StoneRfunction, nil, nil)
      end
    end
    if 9.5 < elapsTime and not isUpgrade then
      if -1 < AlchemyStone.resultItemIndex then
        AlchemyStone.resultSlotBg[AlchemyStone.resultItemIndex]:AddEffect("fUI_Alchemy_Stone02", false)
      else
        AlchemyStone.Stone_slot.icon:AddEffect("fUI_Alchemy_Stone02", false)
      end
      isUpgrade = true
    end
    if 12 < elapsTime and isUpgrade then
      AlchemyStone:ClearData(nil, false)
      Inventory_SetFunctor(AlchemyStone_StoneFilter, AlchemyStone_StoneRfunction, nil, nil)
      isUpgrade = false
      elapsTime = 0
    end
  else
    elapsTime = 0
    isUpgrade = false
  end
end
function AlchemyStone_onScreenResize()
  Panel_AlchemyStone:ComputePos()
end
function FromClient_ItemUpgrade(itemwhereType, slotNo, exp)
  if not Panel_AlchemyStone:GetShow() then
    return
  end
  if -1 == doItType then
    return
  end
  local itemWrapper = getInventoryItemByType(itemwhereType, slotNo)
  if nil == itemWrapper then
    return
  end
  local itemName = itemWrapper:getStaticStatus():getName()
  local mainMsg = ""
  if -1 == doItType then
    return
  end
  if AlchemyStoneTab.Charge == doItType then
    mainMsg = itemName .. " " .. PAGetString(Defines.StringSheet_GAME, "LUA_ALCHEMYSTONE_DONE_CHARGE")
  elseif AlchemyStoneTab.Exp == doItType then
    mainMsg = itemName .. " " .. PAGetString(Defines.StringSheet_GAME, "LUA_ALCHEMYSTONE_DONE_EXP")
  elseif AlchemyStoneTab.Upgrade == doItType then
    mainMsg = itemName .. " " .. PAGetString(Defines.StringSheet_GAME, "LUA_ALCHEMYSTONE_DONE_UPGRADE")
  end
  AlchemyStone.resultMsg = {
    main = mainMsg,
    sub = PAGetString(Defines.StringSheet_GAME, "LUA_ALCHEMYSTONE_MSG_EXP") .. string.format("%.2f", itemWrapper:getExperience() / 10000) .. "%",
    addMsg = "Icon/" .. itemWrapper:getStaticStatus():getIconPath()
  }
  Proc_ShowMessage_Ack_For_RewardSelect(AlchemyStone.resultMsg, 2.5, 33)
  AlchemyStone.control.progress_2:SetProgressRate(itemWrapper:getExperience() / 10000)
  local _exp = string.format("%.2f", itemWrapper:getExperience() / 10000)
  AlchemyStone.control.progressText_2:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_ALCHEMYSTONE_EXPERIENCE", "exp", _exp))
  if AlchemyStoneTab.Charge == doItType then
    AlchemyStone:ClearData(nil, true)
    Inventory_SetFunctor(AlchemyStone_StoneFilter, AlchemyStone_StoneRfunction, nil, nil)
  elseif AlchemyStoneTab.Exp == doItType then
    Inventory_SetFunctor(AlchemyStone_StuffFilter, AlchemyStone_StuffRfunction, nil, nil)
    AlchemyStone:initEffectPlayState()
    AlchemyStone_TabButton_Enable(true)
  end
end
function FromClient_StoneChange(whereType, slotNo)
  if not Panel_AlchemyStone:GetShow() then
    return
  end
  if -1 == doItType then
    return
  end
  local itemWrapper = getInventoryItemByType(whereType, slotNo)
  if nil == itemWrapper then
    return
  end
  local itemSSW = itemWrapper:getStaticStatus()
  local itemName = itemSSW:getName()
  local itemKey = itemSSW:get()._key:getItemKey()
  msg = {
    main = PAGetString(Defines.StringSheet_GAME, "LUA_ALCHEMYSTONE_MSG_DONE"),
    sub = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_ALCHEMYSTONE_MSG_DONE2", "itemName", itemName),
    addMsg = "Icon/" .. itemWrapper:getStaticStatus():getIconPath()
  }
  Proc_ShowMessage_Ack_For_RewardSelect(msg, 2.5, 33)
  for index = 0, #AlchemyStone.resultItemKey do
    if itemKey == AlchemyStone.resultItemKey[index] then
      AlchemyStone.resultItemIndex = index
    end
  end
  audioPostEvent_SystemUi(5, 22)
  _AudioPostEvent_SystemUiForXBOX(5, 22)
end
function FromClient_StoneChangeFailedByDown(whereType, slotNo)
  if not Panel_AlchemyStone:GetShow() then
    return
  end
  if -1 == doItType then
    return
  end
  local itemWrapper = getInventoryItemByType(whereType, slotNo)
  if nil == itemWrapper then
    return
  end
  local itemName = itemWrapper:getStaticStatus():getName()
  msg = {
    main = PAGetString(Defines.StringSheet_GAME, "LUA_ALCHEMYSTONE_MSG_FAIL"),
    sub = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_ALCHEMYSTONE_MSG_FAIL2", "itemName", itemName),
    addMsg = "Icon/" .. itemWrapper:getStaticStatus():getIconPath()
  }
  Proc_ShowMessage_Ack_For_RewardSelect(msg, 2.5, 33)
  audioPostEvent_SystemUi(5, 23)
  _AudioPostEvent_SystemUiForXBOX(5, 23)
end
function FromClient_AlchemyEvolve(evolveType)
  if not Panel_AlchemyStone:GetShow() then
    return
  end
  if -1 == doItType then
    return
  end
  local guideString = ""
  if 0 == evolveType then
    guideString = PAGetString(Defines.StringSheet_GAME, "LUA_ALCHEMYSTONE_UPGRADERESULT_0")
  elseif 1 == evolveType then
    guideString = PAGetString(Defines.StringSheet_GAME, "LUA_ALCHEMYSTONE_UPGRADERESULT_1")
  elseif 2 == evolveType then
    guideString = PAGetString(Defines.StringSheet_GAME, "LUA_ALCHEMYSTONE_UPGRADERESULT_2")
  elseif 3 == evolveType then
    guideString = PAGetString(Defines.StringSheet_GAME, "LUA_ALCHEMYSTONE_UPGRADERESULT_3")
  end
  AlchemyStone.control.guideString:SetText(guideString)
  if evolveType < 3 then
    audioPostEvent_SystemUi(5, 23)
    _AudioPostEvent_SystemUiForXBOX(5, 23)
  else
    audioPostEvent_SystemUi(5, 22)
    _AudioPostEvent_SystemUiForXBOX(5, 22)
  end
end
function FromClient_AlchemyRepair(whereType, slotNo)
  local itemWrapper = getInventoryItemByType(whereType, Int64toInt32(slotNo))
  if nil ~= itemWrapper then
    local itemSSW = itemWrapper:getStaticStatus()
    local itemName = itemSSW:getName()
    Proc_ShowMessage_Ack(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_ALCHEMYSTONE_CHARGE_COMPLETE_ACK", "itemName", itemName))
    AlchemyStone:ClearData(nil, true)
    Inventory_SetFunctor(AlchemyStone_StuffFilter, AlchemyStone_StuffRfunction, nil, nil)
    AlchemyStone:UpdateStone(whereType, slotNo)
  end
end
function AlchemyStone_TabButton_Enable(isEnable)
  local self = AlchemyStone.control
  self.tab_Charge:SetEnable(isEnable)
  self.tab_Exp:SetEnable(isEnable)
  self.tab_Upgrade:SetEnable(isEnable)
  self.tab_RandomOption:SetEnable(isEnable)
end
function AlchemyStone:initEffectPlayState()
  AlchemyStone.isPushDoit = false
  AlchemyStone.startEffectPlay = false
  AlchemyStone.contentEffectPlay = false
  AlchemyStone.slotEffectPlay = false
  AlchemyStone.effectEnd = false
end
AlchemyStone:Init()
AlchemyStone:registEventHandler()
AlchemyStone:registMessageHandler()
