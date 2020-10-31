function PaGlobal_FarmingTimerReport:initialize()
  if true == PaGlobal_FarmingTimerReport._initialize then
    return
  end
  self._ui.group_TitleGroup = UI.getChildControl(Panel_Widget_FarmingTimerReport_All, "Static_TitleGroup")
  self._ui.txt_Title = UI.getChildControl(self._ui.group_TitleGroup, "StaticText_Title")
  self._ui.btn_Close = UI.getChildControl(self._ui.group_TitleGroup, "Button_Close")
  self._ui.bg_BackImage = UI.getChildControl(self._ui.group_TitleGroup, "Static_BackImage")
  self._ui.bg_CharacterStatBg = UI.getChildControl(Panel_Widget_FarmingTimerReport_All, "Static_MainBg")
  self._ui.im_CharacterImage = UI.getChildControl(Panel_Widget_FarmingTimerReport_All, "Static_CharacterStatBg")
  self._ui.txt_BaseInfo = UI.getChildControl(self._ui.im_CharacterImage, "StaticText_BaseInfo")
  self._ui.txt_MoneyBg = UI.getChildControl(self._ui.im_CharacterImage, "Static_MoneyBg")
  self._ui.txt_Revenue = UI.getChildControl(self._ui.txt_MoneyBg, "StaticText_Revenue")
  self._ui.txt_PlayTime = UI.getChildControl(self._ui.txt_MoneyBg, "StaticText_PlayTime")
  self._ui.txt_Attack = UI.getChildControl(self._ui.im_CharacterImage, "StaticText_Attack")
  self._ui.txt_Awaken = UI.getChildControl(self._ui.im_CharacterImage, "StaticText_Awaken")
  self._ui.txt_Defence = UI.getChildControl(self._ui.im_CharacterImage, "StaticText_Defence")
  self._ui.group_ItemGroup = UI.getChildControl(Panel_Widget_FarmingTimerReport_All, "Static_ItemGroup")
  self._ui.btn_GetItemList = UI.getChildControl(self._ui.group_ItemGroup, "RadioButton_GetItemList")
  self._ui.btn_ConsumeItemList = UI.getChildControl(self._ui.group_ItemGroup, "RadioButton_ConsumeItemList")
  self._ui.btn_Experience = UI.getChildControl(self._ui.group_ItemGroup, "RadioButton_Exp")
  self._ui.bg_ItemListBg = UI.getChildControl(self._ui.group_ItemGroup, "Static_ItemListBg")
  self._ui.list2_Item = UI.getChildControl(self._ui.bg_ItemListBg, "List2_Item")
  self._ui.list2_1_VerticalScroll = UI.getChildControl(self._ui.list2_Item, "List2_1_VerticalScroll")
  self._ui.list2_1_VerticalScroll_UpButton = UI.getChildControl(self._ui.list2_1_VerticalScroll, "List2_1_VerticalScroll_UpButton")
  self._ui.list2_1_VerticalScroll_DownButton = UI.getChildControl(self._ui.list2_1_VerticalScroll, "List2_1_VerticalScroll_DownButton")
  self._ui.list2_1_VerticalScroll_CtrlButton = UI.getChildControl(self._ui.list2_1_VerticalScroll, "List2_1_VerticalScroll_CtrlButton")
  self._ui.list2_1_HorizontalScroll = UI.getChildControl(self._ui.list2_Item, "List2_1_HorizontalScroll")
  self._ui.list2_1_HorizontalScroll_UpButton = UI.getChildControl(self._ui.list2_1_HorizontalScroll, "List2_1_HorizontalScroll_UpButton")
  self._ui.list2_1_HorizontalScroll_DownButton = UI.getChildControl(self._ui.list2_1_HorizontalScroll, "List2_1_HorizontalScroll_DownButton")
  self._ui.list2_1_HorizontalScroll_CtrlButton = UI.getChildControl(self._ui.list2_1_HorizontalScroll, "List2_1_HorizontalScroll_CtrlButton")
  self._ui.bg_DescBg = UI.getChildControl(Panel_Widget_FarmingTimerReport_All, "Static_DescBg")
  self._ui.txt_Text_Desc = UI.getChildControl(self._ui.bg_DescBg, "StaticText_Desc")
  self._ui.stc_empty = UI.getChildControl(self._ui.bg_ItemListBg, "StaticText_Empty")
  self._defaultBgSize.x = self._ui.group_TitleGroup:GetSizeX()
  self._defaultBgSize.y = self._ui.group_TitleGroup:GetSizeY()
  self._defaultPanelSize.x = Panel_Widget_FarmingTimerReport_All:GetSizeX()
  self._defaultPanelSize.y = Panel_Widget_FarmingTimerReport_All:GetSizeY()
  self:validate()
  self:initialize_Title()
  self:registEventHandler()
  self._initialize = true
end
function PaGlobal_FarmingTimerReport:registEventHandler()
  if nil == Panel_Widget_FarmingTimerReport_All then
    return
  end
  Panel_Widget_FarmingTimerReport_All:SetShow(false)
  self._ui.btn_GetItemList:addInputEvent("Mouse_LUp", "PaGloabl_FarmingTimerReport_ChangeTab(__eFarmingReportTab_FarmingItemList)")
  self._ui.btn_ConsumeItemList:addInputEvent("Mouse_LUp", "PaGloabl_FarmingTimerReport_ChangeTab(__eFarmingReportTab_ConsumeItemList)")
  self._ui.btn_Experience:addInputEvent("Mouse_LUp", "PaGloabl_FarmingTimerReport_ChangeTab(__eFarmingReportTab_Experience)")
  self._ui.btn_Close:addInputEvent("Mouse_LUp", "PaGloabl_FarmingTimerReport_Close()")
  self._ui.list2_Item:registEvent(__ePAUIList2EventType_LuaChangeContent, "PaGloabl_FarmingTimerReport_FarmingListCreate")
  self._ui.list2_Item:createChildContent(__ePAUIList2ElementManagerType_List)
end
function PaGlobal_FarmingTimerReport:prepareOpen()
  if nil == Panel_Widget_FarmingTimerReport_All then
    return
  end
  self._selectTab = __eFarmingReportTab_FarmingItemList
  ToClient_setSelectFarmingListTab(self._selectTab)
  self._ui.btn_GetItemList:SetCheck(true)
  self._ui.btn_ConsumeItemList:SetCheck(false)
  self._ui.btn_Experience:SetCheck(false)
  self:initialize_Title()
  self:settingTimer()
  self:update()
  PaGlobal_FarmingTimerReport:open()
end
function PaGlobal_FarmingTimerReport:open()
  if nil == Panel_Widget_FarmingTimerReport_All then
    return
  end
  Panel_Widget_FarmingTimerReport_All:SetShow(true)
end
function PaGlobal_FarmingTimerReport:prepareClose()
  if nil == Panel_Widget_FarmingTimerReport_All then
    return
  end
  self:close()
end
function PaGlobal_FarmingTimerReport:close()
  if nil == Panel_Widget_FarmingTimerReport_All then
    return
  end
  Panel_Widget_FarmingTimerReport_All:SetShow(false)
end
function PaGlobal_FarmingTimerReport:update()
  if nil == Panel_Widget_FarmingTimerReport_All then
    return
  end
  self:updateList()
  self:calculationAllMarketPrice()
  self:settingTimer()
end
function PaGlobal_FarmingTimerReport:validate()
  if nil == Panel_Widget_FarmingTimerReport_All then
    return
  end
  self._ui.group_TitleGroup:isValidate()
  self._ui.txt_Title:isValidate()
  self._ui.btn_Close:isValidate()
  self._ui.bg_CharacterStatBg:isValidate()
  self._ui.im_CharacterImage:isValidate()
  self._ui.txt_BaseInfo:isValidate()
  self._ui.txt_MoneyBg:isValidate()
  self._ui.txt_Revenue:isValidate()
  self._ui.txt_PlayTime:isValidate()
  self._ui.txt_Attack:isValidate()
  self._ui.txt_Awaken:isValidate()
  self._ui.txt_Defence:isValidate()
  self._ui.group_ItemGroup:isValidate()
  self._ui.btn_GetItemList:isValidate()
  self._ui.btn_ConsumeItemList:isValidate()
  self._ui.bg_ItemListBg:isValidate()
  self._ui.list2_Item:isValidate()
  self._ui.list2_1_VerticalScroll:isValidate()
  self._ui.list2_1_VerticalScroll_UpButton:isValidate()
  self._ui.list2_1_VerticalScroll_DownButton:isValidate()
  self._ui.list2_1_VerticalScroll_CtrlButton:isValidate()
  self._ui.list2_1_HorizontalScroll:isValidate()
  self._ui.list2_1_HorizontalScroll_UpButton:isValidate()
  self._ui.list2_1_HorizontalScroll_DownButton:isValidate()
  self._ui.list2_1_HorizontalScroll_CtrlButton:isValidate()
  self._ui.bg_DescBg:isValidate()
  self._ui.txt_Text_Desc:isValidate()
end
function PaGlobal_FarmingTimerReport:initialize_Title()
  self._ui.bg_CharacterStatBg:SetShow(false)
  self:initializeBaseInfo()
  self:settingTimer()
end
function PaGlobal_FarmingTimerReport:initializeBaseInfo()
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  self._ui.bg_CharacterStatBg:SetShow(false)
  local FamiName = selfPlayer:getUserNickname()
  local ChaName = selfPlayer:getOriginalName()
  local Level = selfPlayer:get():getLevel()
  self._ui.txt_BaseInfo:SetTextMode(__eTextMode_AutoWrap)
  self._ui.txt_BaseInfo:SetText(PAGetStringParam2(Defines.StringSheet_GAME, "LUA_EXPEDITION_LEVEL_CHARACTERNAME", "level", tostring(Level), "name", tostring(ChaName)) .. "(" .. PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GUILDLIST_FAMILYNAME", "name", tostring(FamiName)) .. ")")
  local classType = selfPlayer:getClassType()
  local awakenWeaponContentsOpen = self._awakenWeapon[classType]
  local isSetAwakenWeapon = ToClient_getEquipmentItem(CppEnums.EquipSlotNo.awakenWeapon)
  local isShyWomen = __eClassType_ShyWaman == selfPlayer:getClassType() and awakenWeaponContentsOpen
  local attackValNew = ToClient_getOffence()
  local awakenAttackValNew = ToClient_getAwakenOffence()
  local defenceAttackValNew = ToClient_getDefence()
  self._ui.txt_Attack:SetText(tostring(ToClient_getOffence()))
  self._ui.txt_Defence:SetText(tostring(ToClient_getDefence()))
  if awakenWeaponContentsOpen and nil ~= isSetAwakenWeapon then
    self._ui.txt_Awaken:SetText(tostring(ToClient_getAwakenOffence()))
    self._ui.txt_Attack:SetSpanSize(-140, 45)
    self._ui.txt_Defence:SetSpanSize(100, 45)
    self._ui.txt_Awaken:SetShow(true)
  else
    self._ui.txt_Attack:SetSpanSize(-100, 45)
    self._ui.txt_Defence:SetSpanSize(50, 45)
    self._ui.txt_Awaken:SetShow(false)
  end
end
function PaGlobal_FarmingTimerReport:settingTimer()
  local tmpTime = PaGlobalFunc_FarmingTimer_GetTimer()
  local hours = math.floor(tmpTime / 3600)
  tmpTime = tmpTime % 3600
  local minutes = math.floor(tmpTime / 60)
  local seconds = tmpTime % 60
  local hoursText = ""
  local minutesText = ""
  local secondsText = ""
  if hours < 10 then
    hoursText = minutesText .. "0" .. tostring(hours)
  else
    hoursText = minutesText .. tostring(hours)
  end
  if minutes < 10 then
    minutesText = minutesText .. "0" .. tostring(minutes)
  else
    minutesText = minutesText .. tostring(minutes)
  end
  if seconds < 10 then
    secondsText = secondsText .. "0" .. tostring(seconds)
  else
    secondsText = secondsText .. tostring(seconds)
  end
  self._ui.txt_PlayTime:SetText(PAGetStringParam3(Defines.StringSheet_GAME, "LUA_COUNTING_TIME", "hour", tostring(hoursText), "minute", minutesText, "second", secondsText))
end
function PaGlobal_FarmingTimerReport:updateList()
  self._ui.list2_Item:getElementManager():clearKey()
  local itemListSize = 0
  if __eFarmingReportTab_FarmingItemList == self._selectTab then
    itemListSize = ToClient_getfarmingItemListSize()
    for i = 0, itemListSize - 1 do
      self._ui.list2_Item:getElementManager():pushKey(toInt64(0, i))
    end
  elseif __eFarmingReportTab_ConsumeItemList == self._selectTab then
    itemListSize = ToClient_getConsumeItemListSize()
    if 0 == ToClient_getConsumeWp() then
      for i = 0, itemListSize - 1 do
        self._ui.list2_Item:getElementManager():pushKey(toInt64(0, i))
      end
    else
      for i = 0, itemListSize do
        self._ui.list2_Item:getElementManager():pushKey(toInt64(0, i))
      end
    end
  elseif __eFarmingReportTab_Experience == self._selectTab then
    itemListSize = ToClient_getLifeExperienceListSize()
    if 0 ~= ToClient_getRemainedSkillPoint() then
      for i = 0, itemListSize + 1 do
        self._ui.list2_Item:getElementManager():pushKey(toInt64(0, i))
      end
    elseif Defines.s64_const.s64_0 ~= ToClient_getStackExperience() then
      for i = 0, itemListSize do
        self._ui.list2_Item:getElementManager():pushKey(toInt64(0, i))
      end
    else
      for i = 0, itemListSize - 1 do
        self._ui.list2_Item:getElementManager():pushKey(toInt64(0, i))
      end
    end
  end
  if 0 == itemListSize then
    self._ui.stc_empty:SetShow(true)
  else
    self._ui.stc_empty:SetShow(false)
  end
end
function PaGlobal_FarmingTimerReport:create(control, key64)
  local idx = Int64toInt32(key64)
  if __eFarmingReportTab_FarmingItemList == self._selectTab then
    PaGloabl_FarmingTimerReport_FarmingListCreateFarmingItem(control, idx)
  elseif __eFarmingReportTab_ConsumeItemList == self._selectTab then
    if 0 == ToClient_getConsumeWp() then
      PaGloabl_FarmingTimerReport_FarmingListCreateConsumeItem(control, idx)
    elseif 0 == idx then
      PaGloabl_FarmingTimerReport_FarmingListCreateWp(control)
    else
      PaGloabl_FarmingTimerReport_FarmingListCreateConsumeItem(control, idx - 1)
    end
  elseif __eFarmingReportTab_Experience == self._selectTab then
    PaGloabl_FarmingTimerReport_FarmingListCreateLifeExperience(control, idx)
    if 0 ~= ToClient_getRemainedSkillPoint() then
      if 0 == idx then
        PaGloabl_FarmingTimerReport_FarmingListCreateExperience(control)
      elseif 1 == idx then
        PaGloabl_FarmingTimerReport_FarmingListCreateRemainedSkillPoint(control)
      else
        PaGloabl_FarmingTimerReport_FarmingListCreateLifeExperience(control, idx - 2)
      end
    elseif Defines.s64_const.s64_0 ~= ToClient_getStackExperience() then
      if 0 == idx then
        PaGloabl_FarmingTimerReport_FarmingListCreateExperience(control)
      else
        PaGloabl_FarmingTimerReport_FarmingListCreateLifeExperience(control, idx - 1)
      end
    else
      PaGloabl_FarmingTimerReport_FarmingListCreateLifeExperience(control, idx)
    end
  end
end
function PaGlobal_FarmingTimerReport:listSetShowFalse(control)
  local stc_energyTitle = UI.getChildControl(control, "StaticText_EnergyTitle")
  local stc_energyValue = UI.getChildControl(control, "StaticText_EnergyValue")
  local stc_expTitle = UI.getChildControl(control, "StaticText_ExpTitle")
  local stc_expValue = UI.getChildControl(control, "StaticText_ExpValue")
  local stc_IconBG = UI.getChildControl(control, "Static_SlotBg")
  local stc_Icon = UI.getChildControl(control, "Static_ItemIcon")
  local txt_Name = UI.getChildControl(control, "StaticText_ItemName_Template")
  local txt_Price = UI.getChildControl(control, "StaticText_Price_Template")
  local txt_Exp = UI.getChildControl(control, "StaticText_EXP_Template")
  stc_energyTitle:SetShow(false)
  stc_energyValue:SetShow(false)
  stc_expTitle:SetShow(false)
  stc_expValue:SetShow(false)
  stc_IconBG:SetShow(false)
  stc_Icon:SetShow(false)
  txt_Name:SetShow(false)
  txt_Price:SetShow(false)
  txt_Exp:SetShow(false)
end
function PaGlobal_FarmingTimerReport:createExperience(control)
  PaGloabl_FarmingTimerReport_FarmingListSetShowFalse(control)
  local stc_expTitle = UI.getChildControl(control, "StaticText_ExpTitle")
  local stc_expValue = UI.getChildControl(control, "StaticText_ExpValue")
  stc_expTitle:SetShow(true)
  stc_expValue:SetShow(true)
  PaGloabl_FarmingTimerReport_ExperienceIconSetting(control, -1)
  local startExperience = string.format("%.2f", Int64toInt32(ToClient_getStartExperience()) / 1000)
  local stackExperience = string.format("%.2f", Int64toInt32(ToClient_getStackExperience()) / 1000)
  local startLv = tostring(ToClient_getStartLevel())
  local currLv = tostring(ToClient_getStackLevel())
  stc_expValue:SetText(PAGetStringParam4(Defines.StringSheet_RESOURCE, "LUA_FARMINGTIMER_EXPERIENCE", "startLevel", startLv, "startExperience", startExperience, "EndLevel", currLv, "EndExperience", stackExperience))
end
function PaGlobal_FarmingTimerReport:createRemainedSkillPoint(control)
  PaGloabl_FarmingTimerReport_FarmingListSetShowFalse(control)
  local txt_Name = UI.getChildControl(control, "StaticText_ItemName_Template")
  local txt_SkillPoint = UI.getChildControl(control, "StaticText_EXP_Template")
  txt_Name:SetShow(true)
  txt_SkillPoint:SetShow(true)
  txt_Name:SetFontColor(Defines.Color.C_FFFFEDD4)
  txt_SkillPoint:SetFontColor(Defines.Color.C_FFF5BA3A)
  PaGloabl_FarmingTimerReport_ExperienceIconSetting(control, -2)
  txt_Name:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_MAINSTATUS_SKILLPOINTICON_TITLE"))
  txt_SkillPoint:SetText(tostring(ToClient_getRemainedSkillPoint()))
end
function PaGlobal_FarmingTimerReport:createWp(control)
  PaGloabl_FarmingTimerReport_FarmingListSetShowFalse(control)
  local stc_IconBG = UI.getChildControl(control, "Static_SlotBg")
  local stc_energyTitle = UI.getChildControl(control, "StaticText_EnergyTitle")
  local stc_energyValue = UI.getChildControl(control, "StaticText_EnergyValue")
  stc_energyTitle:SetShow(true)
  stc_energyValue:SetShow(true)
  stc_energyValue:SetText(tostring(ToClient_getConsumeWp()))
end
function PaGlobal_FarmingTimerReport:createFarmingItem(control, idx)
  PaGloabl_FarmingTimerReport_FarmingListSetShowFalse(control)
  local itemkey = ToClient_getfarmingItemEnchantKey(idx)
  local itemCount = makeDotMoney(toInt64(0, ToClient_getfarmingListItemCount(idx)))
  if nil == itemkey then
    return
  end
  local itemSSW = getItemEnchantStaticStatus(itemkey)
  if nil == itemSSW then
    return
  end
  local stc_IconBG = UI.getChildControl(control, "Static_SlotBg")
  local stc_Icon = UI.getChildControl(control, "Static_ItemIcon")
  local txt_Name = UI.getChildControl(control, "StaticText_ItemName_Template")
  local txt_Price = UI.getChildControl(control, "StaticText_Price_Template")
  stc_IconBG:SetShow(true)
  stc_Icon:SetShow(true)
  txt_Name:SetShow(true)
  txt_Price:SetShow(true)
  stc_Icon:getBaseTexture():setUV(0, 0, 1, 1)
  stc_Icon:setRenderTexture(stc_Icon:getBaseTexture())
  stc_Icon:ChangeTextureInfoName("Icon/" .. itemSSW:getIconPath())
  local enchantLeveltxt = PaGloabl_FarmingTimerReport_ItemEnchantLevel(itemSSW)
  local fontColor = self._itemGradeColor[itemSSW:getGradeType()]
  if nil ~= fontColor then
    txt_Name:SetFontColor(fontColor)
  else
    txt_Name:SetFontColor(self._itemGradeColor[__eItemGradeNormal])
  end
  txt_Name:SetText(enchantLeveltxt .. " " .. itemSSW:getName() .. " X " .. tostring(itemCount))
  local isWorldMarketAble = requestIsRegisterItemForItemMarket(itemkey)
  if true == isWorldMarketAble then
    local price = ToClient_getFarmingListItemMarketPrice(idx)
    if price <= Defines.s64_const.s64_0 then
      txt_Price:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_MARKET_PLACE_NO_PRICE_INFO"))
    else
      txt_Price:SetText(makeDotMoney(price * toInt64(0, itemCount)))
    end
  elseif itemSSW:get()._sellPriceToNpc_s64 <= Defines.s64_const.s64_0 then
    if true == itemSSW:isMoney() then
      txt_Price:SetText(itemCount)
    else
      txt_Price:SetText("0")
    end
  else
    txt_Price:SetText(makeDotMoney(itemSSW:get()._sellPriceToNpc_s64 * toInt64(0, itemCount)))
  end
  self:calculationAllMarketPrice()
  self:settingTimer()
end
function PaGlobal_FarmingTimerReport:createConsumeItem(control, idx)
  PaGloabl_FarmingTimerReport_FarmingListSetShowFalse(control)
  local itemkey = ToClient_getConsumeItemEnchantKey(idx)
  local itemCount = makeDotMoney(toInt64(0, ToClient_getConsumeListItemCount(idx)))
  if nil == itemkey then
    return
  end
  local itemSSW = getItemEnchantStaticStatus(itemkey)
  if nil == itemSSW then
    return
  end
  local stc_IconBG = UI.getChildControl(control, "Static_SlotBg")
  local stc_Icon = UI.getChildControl(control, "Static_ItemIcon")
  local txt_Name = UI.getChildControl(control, "StaticText_ItemName_Template")
  stc_IconBG:SetShow(true)
  stc_Icon:SetShow(true)
  txt_Name:SetShow(true)
  stc_Icon:getBaseTexture():setUV(0, 0, 1, 1)
  stc_Icon:setRenderTexture(stc_Icon:getBaseTexture())
  stc_Icon:ChangeTextureInfoName("Icon/" .. itemSSW:getIconPath())
  local enchantLeveltxt = PaGloabl_FarmingTimerReport_ItemEnchantLevel(itemSSW)
  local fontColor = self._itemGradeColor[itemSSW:getGradeType()]
  if nil ~= fontColor then
    txt_Name:SetFontColor(fontColor)
  else
    txt_Name:SetFontColor(self._itemGradeColor[__eItemGradeNormal])
  end
  txt_Name:SetText(enchantLeveltxt .. " " .. itemSSW:getName() .. " X " .. tostring(itemCount))
  self:calculationAllMarketPrice()
  self:settingTimer()
end
function PaGlobal_FarmingTimerReport:createLifeExperience(control, idx)
  PaGloabl_FarmingTimerReport_FarmingListSetShowFalse(control)
  local txt_Name = UI.getChildControl(control, "StaticText_ItemName_Template")
  local txt_Exp = UI.getChildControl(control, "StaticText_EXP_Template")
  txt_Name:SetShow(true)
  txt_Exp:SetShow(true)
  txt_Name:SetFontColor(Defines.Color.C_FFFFEDD4)
  txt_Exp:SetFontColor(Defines.Color.C_FFF5BA3A)
  local experienceType = ToClient_getLifeExperienceType()
  txt_Name:SetText(CppEnums.LifeExperienceString[experienceType])
  PaGloabl_FarmingTimerReport_ExperienceIconSetting(control, experienceType)
  local startExperience = string.format("%.2f", Int64toInt32(ToClient_getLifeStartExperience(idx)) / 100)
  local stackExperience = string.format("%.2f", Int64toInt32(ToClient_getLifeStackExperience(idx)) / 100)
  local startLv = PaGlobalFunc_Util_CraftLevelReplace(ToClient_getLifeStartLevel(idx))
  local currLv = PaGlobalFunc_Util_CraftLevelReplace(ToClient_getLifeStackLevel(idx))
  txt_Exp:SetText(PAGetStringParam4(Defines.StringSheet_RESOURCE, "LUA_FARMINGTIMER_EXPERIENCE", "startLevel", startLv, "startExperience", startExperience, "EndLevel", currLv, "EndExperience", stackExperience))
end
function PaGlobal_FarmingTimerReport:add_Slot(idx, tab)
end
function PaGlobal_FarmingTimerReport:itemCountChange_Slot(idx, tab)
end
function PaGlobal_FarmingTimerReport:priceInfoUpdate(price, key)
end
function PaGlobal_FarmingTimerReport:calculationAllMarketPrice()
  local itemListSize = ToClient_getfarmingItemListSize()
  local allMarketPrice = Defines.s64_const.s64_0
  for i = 0, itemListSize - 1 do
    local isWorldMarketAble = requestIsRegisterItemForItemMarket(ToClient_getfarmingItemEnchantKey(i))
    if isWorldMarketAble then
      allMarketPrice = allMarketPrice + ToClient_getFarmingListItemMarketPrice(i) * toInt64(0, ToClient_getfarmingListItemCount(i))
    else
      local itemSSW = getItemEnchantStaticStatus(ToClient_getfarmingItemEnchantKey(i))
      if nil == itemSSW then
        return
      end
      if true == itemSSW:isMoney() then
        allMarketPrice = allMarketPrice + toInt64(0, ToClient_getfarmingListItemCount(i))
      else
        allMarketPrice = allMarketPrice + itemSSW:get()._sellPriceToNpc_s64 * toInt64(0, ToClient_getfarmingListItemCount(i))
      end
    end
  end
  local allMoney = allMarketPrice
  if allMoney < Defines.s64_const.s64_0 then
    self._allMoney = allMoney * Defines.s64_const.s64_m1
  else
    self._allMoney = allMoney
  end
  local txtMoney = makeDotMoney(self._allMoney)
  if allMoney < Defines.s64_const.s64_0 then
    txtMoney = "-" .. txtMoney
  end
  self._ui.txt_Revenue:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_REVENUE", "allmoney", txtMoney))
end
function PaGlobal_FarmingTimerReport:changeTab(idx)
  if 0 == idx then
    self._selectTab = __eFarmingReportTab_FarmingItemList
  elseif 1 == idx then
    self._selectTab = __eFarmingReportTab_ConsumeItemList
  elseif 2 == idx then
    self._selectTab = __eFarmingReportTab_Experience
  end
  ToClient_setSelectFarmingListTab(self._selectTab)
  self:updateList()
end
function PaGlobal_FarmingTimerReport:itemEnchantLevel(itemSSW)
  local printenchantLevel = ""
  if true == itemSSW:get():isCash() then
    return printenchantLevel
  end
  local enchantLevel = itemSSW:get()._key:getEnchantLevel()
  if 0 < ToClient_getSpecialEnchantDisplayLevel(itemSSW:get()._key) then
    enchantLevel = ToClient_getSpecialEnchantDisplayLevel(itemSSW:get()._key)
  end
  if CppEnums.ItemClassifyType.eItemClassify_Accessory == itemSSW:getItemClassify() and false == itemSSW:isSpecialEnchantItem() then
    printenchantLevel = PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_ENCHANTLEVEL_" .. tostring(enchantLevel))
  else
    if true == ToClient_IsSpecialEnchantItem(itemSSW:get()._key) and 0 < ToClient_getSpecialEnchantDisplayLevel(itemSSW:get()._key) then
      enchantLevel = ToClient_getSpecialEnchantDisplayLevel(itemSSW:get()._key)
    end
    if 0 < enchantLevel then
      if 0 < enchantLevel and enchantLevel < 16 then
        printenchantLevel = "+" .. tostring(enchantLevel)
      elseif 16 == enchantLevel then
        printenchantLevel = PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_ENCHANTLEVEL_1")
      elseif 17 == enchantLevel then
        printenchantLevel = PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_ENCHANTLEVEL_2")
      elseif 18 == enchantLevel then
        printenchantLevel = PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_ENCHANTLEVEL_3")
      elseif 19 == enchantLevel then
        printenchantLevel = PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_ENCHANTLEVEL_4")
      elseif 20 == enchantLevel then
        printenchantLevel = PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_ENCHANTLEVEL_5")
      end
    end
  end
  return printenchantLevel
end
function PaGlobal_FarmingTimerReport:experienceIconSetting(control, experienceType)
  local x1, y1, x2, y2 = 0, 0, 0, 0
  local stc_Icon = UI.getChildControl(control, "Static_ItemIcon")
  stc_Icon:SetShow(true)
  stc_Icon:ChangeTextureInfoName("Combine/Icon/Combine_Tab_Icon_00.dds")
  if -1 == experienceType then
    x1, y1, x2, y2 = setTextureUV_Func(stc_Icon, 181, 505, 216, 540)
  elseif -2 == experienceType then
    x1, y1, x2, y2 = setTextureUV_Func(stc_Icon, 145, 505, 180, 540)
  elseif 0 == experienceType then
    x1, y1, x2, y2 = setTextureUV_Func(stc_Icon, 1, 1, 36, 36)
  elseif 1 == experienceType then
    x1, y1, x2, y2 = setTextureUV_Func(stc_Icon, 37, 1, 72, 36)
  elseif 2 == experienceType then
    x1, y1, x2, y2 = setTextureUV_Func(stc_Icon, 73, 1, 108, 36)
  elseif 3 == experienceType then
    x1, y1, x2, y2 = setTextureUV_Func(stc_Icon, 109, 1, 144, 36)
  elseif 4 == experienceType then
    x1, y1, x2, y2 = setTextureUV_Func(stc_Icon, 145, 1, 180, 36)
  elseif 5 == experienceType then
    x1, y1, x2, y2 = setTextureUV_Func(stc_Icon, 181, 73, 216, 108)
  elseif 6 == experienceType then
    x1, y1, x2, y2 = setTextureUV_Func(stc_Icon, 217, 73, 252, 108)
  elseif 7 == experienceType then
    x1, y1, x2, y2 = setTextureUV_Func(stc_Icon, 253, 1, 288, 36)
  elseif 8 == experienceType then
    x1, y1, x2, y2 = setTextureUV_Func(stc_Icon, 289, 1, 324, 36)
  elseif 9 == experienceType then
    x1, y1, x2, y2 = setTextureUV_Func(stc_Icon, 325, 1, 360, 36)
  elseif 11 == experienceType then
    x1, y1, x2, y2 = setTextureUV_Func(stc_Icon, 109, 433, 144, 468)
  end
  stc_Icon:getBaseTexture():setUV(x1, y1, x2, y2)
  stc_Icon:setRenderTexture(stc_Icon:getBaseTexture())
end
function PaGlobal_FarmingTimerReport:lifeExperienceChange(idx, tab)
end
function PaGlobal_FarmingTimerReport:resetReport()
  self:update()
end
