Panel_Window_PetMarket:SetShow(false, false)
Panel_Window_PetMarket:setMaskingChild(true)
Panel_Window_PetMarket:ActiveMouseEventEffect(true)
Panel_Window_PetMarket:setGlassBackground(true)
Panel_Window_PetMarket:RegisterShowEventFunc(true, "PetMarket_ShowAni()")
Panel_Window_PetMarket:RegisterShowEventFunc(false, "PetMarket_HideAni()")
local auctionInfo = RequestGetAuctionInfo()
function PetMarket_ShowAni()
end
function PetMarket_HideAni()
end
local PetMarket = {
  btnClose = UI.getChildControl(Panel_Window_PetMarket, "Button_Close"),
  btnQuestion = UI.getChildControl(Panel_Window_PetMarket, "Button_Question"),
  radioBtn_AllList = UI.getChildControl(Panel_Window_PetMarket, "RadioButton_List"),
  radioBtn_MyList = UI.getChildControl(Panel_Window_PetMarket, "RadioButton_ListMy"),
  mainBg = UI.getChildControl(Panel_Window_PetMarket, "Static_MainBG"),
  actionSlotBg = UI.getChildControl(Panel_Window_PetMarket, "Static_ActionSlotBg"),
  actionSlot = UI.getChildControl(Panel_Window_PetMarket, "Static_ActionSlot"),
  skillSlotBg = UI.getChildControl(Panel_Window_PetMarket, "Static_SkillSlotBg"),
  skillSlot = UI.getChildControl(Panel_Window_PetMarket, "Static_SkillSlot"),
  pageNo = UI.getChildControl(Panel_Window_PetMarket, "StaticText_PageNo"),
  btnPrev = UI.getChildControl(Panel_Window_PetMarket, "Button_Prev"),
  btnNext = UI.getChildControl(Panel_Window_PetMarket, "Button_Next"),
  radioBtn_Bag = UI.getChildControl(Panel_Window_PetMarket, "RadioButton_Icon_Money"),
  radioBtn_Warehouse = UI.getChildControl(Panel_Window_PetMarket, "RadioButton_Icon_Money2"),
  bagMoney = UI.getChildControl(Panel_Window_PetMarket, "Static_Text_Money"),
  warehouseMoney = UI.getChildControl(Panel_Window_PetMarket, "Static_Text_Money2"),
  _myPetList = {},
  _slots = Array.new(),
  _maxSlotCount = 4,
  _actionPosX = 395,
  _actionSizeX = 50,
  _tabIndex = 0,
  _myPetCurrentPage = 1,
  _myPetEndPage = 0,
  nextBtnShow = {},
  _myMoney = toInt64(0, 0),
  _myWarehouseMoney = toInt64(0, 0)
}
PetMarket.btnClose:addInputEvent("Mouse_LUp", "PetMarket_Close()")
PetMarket.btnQuestion:SetShow(false)
PetMarket.btnQuestion:addInputEvent("Mouse_LUp", "Panel_WebHelper_ShowToggle( \"Pet\" )")
PetMarket.btnQuestion:addInputEvent("Mouse_On", "HelpMessageQuestion_Show( \"Pet\", \"true\")")
PetMarket.btnQuestion:addInputEvent("Mouse_Out", "HelpMessageQuestion_Show( \"Pet\", \"false\")")
PetMarket.radioBtn_AllList:addInputEvent("Mouse_LUp", "Panel_PetAuctionAllList( 0 )")
PetMarket.radioBtn_MyList:addInputEvent("Mouse_LUp", "Panel_PetAuctionMyList( 1 )")
PetMarket.btnNext:addInputEvent("Mouse_LUp", "Panel_PetAuctionNextPage()")
PetMarket.btnPrev:addInputEvent("Mouse_LUp", "Panel_PetAuctionPrevPage()")
function Panel_PetAuctionAllList(tabIndex)
  PetMarket._tabIndex = tabIndex
  PetMarket.radioBtn_AllList:SetCheck(true)
  PetMarket.radioBtn_MyList:SetCheck(false)
  requestPetList()
end
function Panel_PetAuctionMyList(tabIndex)
  PetMarket._tabIndex = tabIndex
  PetMarket.radioBtn_AllList:SetCheck(false)
  PetMarket.radioBtn_MyList:SetCheck(true)
  PetMarket._myPetCurrentPage = 1
  requestMyPetList()
end
function Panel_PetAuctionNextPage()
  local self = PetMarket
  for index = 0, self._maxSlotCount - 1 do
    self.nextBtnShow[index] = false
    self._slots[index].prevPage:SetShow(false)
    self._slots[index].nextPage:SetShow(false)
  end
  if PetMarket.radioBtn_MyList:IsCheck() then
    if self._myPetCurrentPage < self._myPetEndPage then
      self._myPetCurrentPage = self._myPetCurrentPage + 1
      self:Update()
    end
  else
    RequestAuctionNextPage()
  end
end
function Panel_PetAuctionPrevPage()
  local self = PetMarket
  for index = 0, self._maxSlotCount - 1 do
    self.nextBtnShow[index] = false
    self._slots[index].prevPage:SetShow(false)
    self._slots[index].nextPage:SetShow(false)
  end
  if PetMarket.radioBtn_MyList:IsCheck() then
    if 1 < self._myPetCurrentPage then
      self._myPetCurrentPage = self._myPetCurrentPage - 1
      self:Update()
    end
  else
    RequestAuctionPrevPage()
  end
end
function PetMarket:Init()
  local actionMaxCount = 5
  for index = 0, self._maxSlotCount - 1 do
    local temp = {}
    temp.slotBg = UI.createAndCopyBasePropertyControl(Panel_Window_PetMarket, "Static_Slot", self.mainBg, "Static_SlotBg_" .. index)
    temp.iconBg = UI.createAndCopyBasePropertyControl(Panel_Window_PetMarket, "Static_IconBack", temp.slotBg, "Static_PetIconBg_" .. index)
    temp.icon = UI.createAndCopyBasePropertyControl(Panel_Window_PetMarket, "Static_Icon", temp.slotBg, "Static_PetIcon_" .. index)
    temp.statBg = UI.createAndCopyBasePropertyControl(Panel_Window_PetMarket, "Static_StatusBack", temp.slotBg, "Static_StatBg_" .. index)
    temp.tier = UI.createAndCopyBasePropertyControl(Panel_Window_PetMarket, "StaticText_Tier", temp.slotBg, "StaticText_PetTier_" .. index)
    temp.level = UI.createAndCopyBasePropertyControl(Panel_Window_PetMarket, "StaticText_Level", temp.slotBg, "StaticText_PetLevel_" .. index)
    temp.base = UI.createAndCopyBasePropertyControl(Panel_Window_PetMarket, "StaticText_Base", temp.slotBg, "StaticText_PetBase_" .. index)
    temp.special = UI.createAndCopyBasePropertyControl(Panel_Window_PetMarket, "StaticText_Special", temp.slotBg, "StaticText_PetSpecial_" .. index)
    temp.tierValue = UI.createAndCopyBasePropertyControl(Panel_Window_PetMarket, "StaticText_TierValue", temp.slotBg, "StaticText_PetTierValue_" .. index)
    temp.levelValue = UI.createAndCopyBasePropertyControl(Panel_Window_PetMarket, "StaticText_LevelValue", temp.slotBg, "StaticText_PetLevelValue_" .. index)
    temp.baseValue = UI.createAndCopyBasePropertyControl(Panel_Window_PetMarket, "StaticText_BaseValue", temp.slotBg, "StaticText_PetBaseValue_" .. index)
    temp.specialValue = UI.createAndCopyBasePropertyControl(Panel_Window_PetMarket, "StaticText_SpecialValue", temp.slotBg, "StaticText_PetSpecialValue_" .. index)
    temp.myPet = UI.createAndCopyBasePropertyControl(Panel_Window_PetMarket, "StaticText_IsMyPet", temp.slotBg, "StaticText_MyPet_" .. index)
    temp.actionTitle = UI.createAndCopyBasePropertyControl(Panel_Window_PetMarket, "StaticText_Action", temp.slotBg, "StaticText_ActionTitle_" .. index)
    temp.skillTitle = UI.createAndCopyBasePropertyControl(Panel_Window_PetMarket, "StaticText_Skill", temp.slotBg, "StaticText_SkillTitle_" .. index)
    temp.action = {}
    temp.skill = {}
    for ii = 0, actionMaxCount - 1 do
      local temp2 = {}
      local actionBg = UI.createControl(__ePAUIControl_Static, temp.slotBg, "Static_ActionIconBg_" .. ii)
      CopyBaseProperty(self.actionSlotBg, actionBg)
      actionBg:SetPosX(self._actionPosX + (self._actionSizeX + 5) * ii)
      actionBg:SetShow(true)
      temp2.actionSlot = UI.createControl(__ePAUIControl_Static, actionBg, "Static_ActionIcon_" .. ii)
      CopyBaseProperty(self.actionSlot, temp2.actionSlot)
      temp2.actionSlot:SetShow(true)
      local skillBg = UI.createControl(__ePAUIControl_Static, temp.slotBg, "Static_SkillIconBg_" .. ii)
      CopyBaseProperty(self.skillSlotBg, skillBg)
      skillBg:SetPosX(self._actionPosX + (self._actionSizeX + 5) * ii)
      skillBg:SetShow(true)
      temp2.skillSlot = UI.createControl(__ePAUIControl_Static, skillBg, "Static_SkillIcon_" .. ii)
      CopyBaseProperty(self.skillSlot, temp2.skillSlot)
      temp2.skillSlot:SetShow(true)
      temp.action[ii] = temp2.actionSlot
      temp.skill[ii] = temp2.skillSlot
    end
    temp.prevPage = UI.createAndCopyBasePropertyControl(Panel_Window_PetMarket, "Button_PrevActionPage", temp.slotBg, "Static_prevPage_" .. index)
    temp.nextPage = UI.createAndCopyBasePropertyControl(Panel_Window_PetMarket, "Button_NextActionPage", temp.slotBg, "Static_nextPage_" .. index)
    temp.prevPage:SetShow(false)
    temp.nextPage:SetShow(false)
    temp.priceBg = UI.createAndCopyBasePropertyControl(Panel_Window_PetMarket, "Static_CountBG", temp.slotBg, "StaticText_CountBG_" .. index)
    temp.price = UI.createAndCopyBasePropertyControl(Panel_Window_PetMarket, "StaticText_Price", temp.slotBg, "StaticText_Price_" .. index)
    temp.priceValue = UI.createAndCopyBasePropertyControl(Panel_Window_PetMarket, "StaticText_PriceValue", temp.slotBg, "StaticText_PriceValue_" .. index)
    temp.btnCancel = UI.createAndCopyBasePropertyControl(Panel_Window_PetMarket, "Button_Cancel", temp.slotBg, "Button_Cancel_" .. index)
    temp.btnBuy = UI.createAndCopyBasePropertyControl(Panel_Window_PetMarket, "Button_Buy", temp.slotBg, "Button_Buy_" .. index)
    temp.btnRecieve = UI.createAndCopyBasePropertyControl(Panel_Window_PetMarket, "Button_Receive", temp.slotBg, "Button_Receive_" .. index)
    temp.btnEnd = UI.createAndCopyBasePropertyControl(Panel_Window_PetMarket, "Button_End", temp.slotBg, "Button_End_" .. index)
    temp.slotBg:SetPosY(10 + index * (temp.slotBg:GetSizeY() + 10))
    self._slots[index] = temp
    self.nextBtnShow[index] = false
  end
end
function PetMarket:Update()
  if not Panel_Window_PetMarket:GetShow() then
    return
  end
  local petCount = auctionInfo:getPetAuctionCount()
  local actionMaxCount = ToClient_getPetActionMax()
  local skillMaxCount = ToClient_getPetEquipSkillMax()
  local maxActionSlotCount = 5
  local currentPage = auctionInfo:getCurrentPage() + 1
  for ii = 0, self._maxSlotCount - 1 do
    local slot = self._slots[ii]
    slot.slotBg:SetShow(false)
    for slotIndex = 0, 4 do
      slot.action[slotIndex]:ChangeTextureInfoName("")
      slot.skill[slotIndex]:ChangeTextureInfoName("")
    end
  end
  if 0 == petCount then
    if 0 < currentPage then
      RequestAuctionPrevPage()
    end
    return
  end
  local startIndex = 0
  if self.radioBtn_MyList:IsCheck() then
    startIndex = (self._myPetCurrentPage - 1) * 4
    self.pageNo:SetText(self._myPetCurrentPage)
    self._myPetEndPage = math.ceil(petCount / self._maxSlotCount)
  else
    self.pageNo:SetText(currentPage)
  end
  for index = 0, petCount - 1 do
    local slot = self._slots[index]
    local petAuctionData = auctionInfo:getPetAuctionAt(index + startIndex)
    if nil == petAuctionData then
      return
    end
    if slot.nextPage:GetShow() then
      self.nextBtnShow[index] = false
    end
    local uiIdx = 0
    local nextIndex = 0
    for action_idx = 0, actionMaxCount - 1 do
      local actionStaticStatus = ToClient_getPetActionStaticStatus(action_idx)
      local isLearn = petAuctionData:isPetActionLearned(action_idx)
      if true == isLearn and nil ~= actionStaticStatus then
        if not self.nextBtnShow[index] then
          slot.prevPage:SetShow(false)
          if maxActionSlotCount > uiIdx then
            slot.action[uiIdx]:SetShow(true)
            slot.action[uiIdx]:SetIgnore(false)
            slot.action[uiIdx]:ChangeTextureInfoName("Icon/" .. actionStaticStatus:getIconPath())
            slot.action[uiIdx]:addInputEvent("Mouse_On", "PetAuction_ShowActionToolTip( " .. action_idx .. ", " .. uiIdx .. ", " .. index .. " )")
            slot.action[uiIdx]:addInputEvent("Mouse_Out", "PetAuction_HideActionToolTip( " .. action_idx .. " )")
            uiIdx = uiIdx + 1
            slot.nextPage:SetShow(false)
          else
            self.nextBtnShow[index] = true
            slot.nextPage:SetShow(true)
            slot.nextPage:addInputEvent("Mouse_LUp", "PetMarket_NextAction_Show(" .. index .. ")")
            break
          end
        else
          uiIdx = uiIdx + 1
          if maxActionSlotCount < uiIdx then
            slot.action[nextIndex]:SetShow(true)
            slot.action[nextIndex]:SetIgnore(false)
            slot.action[nextIndex]:ChangeTextureInfoName("Icon/" .. actionStaticStatus:getIconPath())
            slot.action[nextIndex]:addInputEvent("Mouse_On", "PetAuction_ShowActionToolTip( " .. action_idx .. ", " .. nextIndex .. ", " .. index .. " )")
            slot.action[nextIndex]:addInputEvent("Mouse_Out", "PetAuction_HideActionToolTip( " .. action_idx .. " )")
            nextIndex = nextIndex + 1
          end
        end
      end
    end
    if maxActionSlotCount >= uiIdx then
      for actIdx = uiIdx, maxActionSlotCount - 1 do
        slot.action[actIdx]:SetIgnore(true)
      end
    else
    end
    uiIdx = 0
    for skill_idx = 0, skillMaxCount - 1 do
      local skillStaticStatus = ToClient_getPetEquipSkillStaticStatus(skill_idx)
      local isLearn = petAuctionData:isPetEquipSkillLearned(skill_idx)
      if true == isLearn and nil ~= skillStaticStatus then
        local skillTypeStaticWrapper = skillStaticStatus:getSkillTypeStaticStatusWrapper()
        if nil ~= skillTypeStaticWrapper then
          local skillNo = skillStaticStatus:getSkillNo()
          slot.skill[uiIdx]:SetShow(true)
          slot.skill[uiIdx]:SetIgnore(false)
          slot.skill[uiIdx]:ChangeTextureInfoName("Icon/" .. skillTypeStaticWrapper:getIconPath())
          slot.skill[uiIdx]:addInputEvent("Mouse_On", "PetMarket_ShowSkillToolTip( " .. skill_idx .. ", " .. uiIdx .. ", " .. index .. ")")
          slot.skill[uiIdx]:addInputEvent("Mouse_Out", "PetMarket_HideSkillToolTip()")
          Panel_SkillTooltip_SetPosition(skillNo, slot.skill[uiIdx], index)
        end
        uiIdx = uiIdx + 1
      end
    end
    if maxActionSlotCount >= uiIdx then
      for skillIdx = uiIdx, maxActionSlotCount - 1 do
        slot.skill[skillIdx]:SetIgnore(true)
      end
    end
    local function petSkillType(param)
      local skillParam = petAuctionData:getSkillParam(param)
      local paramText = ""
      if 1 == skillParam._type then
        paramText = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_PETINFO_PETSKILLTYPE_ITEMGETTIME", "itemGetTime", string.format("%.1f", skillParam:getParam(0) / 1000))
      elseif 2 == skillParam._type then
        paramText = PAGetString(Defines.StringSheet_GAME, "LUA_PETINFO_PETSKILLTYPE_FINDGATHER")
      elseif 3 == skillParam._type then
        paramText = PAGetString(Defines.StringSheet_GAME, "LUA_PETINFO_PETSKILLTYPE_FINDPK")
      elseif 4 == skillParam._type then
        paramText = PAGetString(Defines.StringSheet_GAME, "LUA_PETINFO_PETSKILLTYPE_FINDPLACE")
      elseif 5 == skillParam._type then
        paramText = PAGetString(Defines.StringSheet_GAME, "LUA_PETINFO_PETSKILLTYPE_MOBAGGRO")
      elseif 6 == skillParam._type then
        paramText = PAGetString(Defines.StringSheet_GAME, "LUA_PETINFO_PETSKILLTYPE_FINDRAREMONSTER")
      elseif 7 == skillParam._type then
        paramText = PAGetString(Defines.StringSheet_GAME, "LUA_PETINFO_PETSKILLTYPE_REDUCEAUTOFISHINGTIME")
      else
        if 0 == param then
          slot.baseValue:SetShow(false)
        elseif 1 == param then
          slot.specialValue:SetShow(false)
        end
        return
      end
      if 0 == param then
        slot.baseValue:SetShow(true)
        slot.baseValue:SetText(paramText)
      elseif 1 == param then
        slot.specialValue:SetShow(true)
        slot.specialValue:SetText(paramText)
      end
    end
    petSkillType(0)
    petSkillType(1)
    local petStaticStatus = petAuctionData:getPetStaticStatus()
    local iconPath = petAuctionData:getIconPath()
    local petTier = petStaticStatus:getPetTier() + 1
    slot.levelValue:SetText(tostring(petAuctionData:getLevel()))
    slot.priceValue:SetText(makeDotMoney(petAuctionData:getPetPrice()))
    slot.tierValue:SetText(petTier)
    slot.slotBg:SetShow(true)
    slot.btnBuy:SetShow(false)
    slot.btnRecieve:SetShow(false)
    slot.btnCancel:SetShow(false)
    slot.btnEnd:SetShow(false)
    if 0 == self._tabIndex then
      local auctionPetNo = petAuctionData:getPetNo()
      if isMyPet(auctionPetNo) then
        if petAuctionData:isAuctionEnd() then
          slot.myPet:SetShow(true)
          slot.btnRecieve:SetShow(true)
          slot.btnRecieve:addInputEvent("Mouse_LUp", "PetAuction_Recieve(" .. index .. ")")
        else
          slot.btnCancel:SetShow(true)
          slot.btnCancel:addInputEvent("Mouse_LUp", "PetAuction_Cancel(" .. index .. ")")
        end
        slot.myPet:SetShow(true)
      else
        slot.myPet:SetShow(false)
        slot.btnBuy:SetShow(true)
        slot.btnBuy:addInputEvent("Mouse_LUp", "PetAuction_Buy(" .. index .. ")")
      end
    elseif petAuctionData:isAuctionEnd() then
      slot.btnRecieve:SetShow(true)
      slot.btnRecieve:addInputEvent("Mouse_LUp", "PetAuction_Recieve(" .. index .. ")")
    else
      slot.btnCancel:SetShow(true)
      slot.btnCancel:addInputEvent("Mouse_LUp", "PetAuction_Cancel(" .. index .. ")")
    end
    slot.icon:ChangeTextureInfoName(iconPath)
  end
  self._myMoney = getSelfPlayer():get():getInventory():getMoney_s64()
  self.bagMoney:SetText(makeDotMoney(self._myMoney))
  local regionInfoWrapper = getRegionInfoByPosition(getSelfPlayer():get():getPosition())
  if nil == regionInfoWrapper then
    return
  end
  local myAffiliatedTownRegionKey = regionInfoWrapper:getAffiliatedTownRegionKey()
  self._myWarehouseMoney = warehouse_moneyFromRegionKey_s64(myAffiliatedTownRegionKey)
  self.warehouseMoney:SetText(makeDotMoney(self._myWarehouseMoney))
end
function PetMarket_NextAction_Show(slotIndex)
  local slot = PetMarket._slots[slotIndex]
  slot.nextPage:SetShow(false)
  slot.prevPage:SetShow(true)
  slot.prevPage:addInputEvent("Mouse_LUp", "HandleClicked_PrevAction_Show(" .. slotIndex .. ")")
  PetMarket:Update()
end
function HandleClicked_PrevAction_Show(slotIndex)
  local slot = PetMarket._slots[slotIndex]
  slot.nextPage:SetShow(true)
  slot.prevPage:SetShow(false)
  PetMarket:Update()
end
function isMyPet(petNo)
  local sealPetCount = ToClient_getPetSealedList()
  for petIndex = 0, sealPetCount - 1 do
    local petInfo = ToClient_getPetSealedDataByIndex(petIndex)
    if petNo == petInfo._petNo then
      return true
    end
  end
  return false
end
function PetAuction_Buy(index)
  if MessageBoxGetShow() then
    return
  end
  local self = PetMarket
  local petAuctionData = auctionInfo:getPetAuctionAt(index)
  if nil == petAuctionData then
    _PA_LOG("asdf", "petAuctionData nil")
  end
  local fromWhereType = CppEnums.ItemWhereType.eInventory
  if self.radioBtn_Warehouse:IsCheck() then
    fromWhereType = CppEnums.ItemWhereType.eWarehouse
  end
  local haveMoney
  if self.radioBtn_Warehouse:IsCheck() then
    haveMoney = self._myWarehouseMoney
  else
    haveMoney = self._myMoney
  end
  if haveMoney < petAuctionData:getPetPrice() then
    Proc_ShowMessage_Ack("\235\179\180\236\156\160 \234\184\136\236\149\161\236\157\180 \235\182\128\236\161\177\237\149\169\235\139\136\235\139\164.")
    return
  end
  local function buyConfirm()
    ToClient_buyPetInAuctionReq(petAuctionData:getPetNo(), fromWhereType)
  end
  local petPrice = petAuctionData:getPetPrice()
  local messageBoxMemo = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_PETMARKET_BUYCONTENT", "price", makeDotMoney(petPrice))
  local messageBoxData = {
    title = PAGetString(Defines.StringSheet_GAME, "LUA_PETMARKET_BUYTITLE"),
    content = messageBoxMemo,
    functionYes = buyConfirm,
    functionNo = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageBoxData)
end
function PetAuction_Cancel(index)
  if MessageBoxGetShow() then
    return
  end
  local petAuctionData = auctionInfo:getPetAuctionAt(index)
  if nil == petAuctionData then
    _PA_LOG("asdf", "petAuctionData nil")
  end
  local function cancelConfirm()
    ToClient_cancelRegisterPetInAuctionReq(petAuctionData:getPetNo())
  end
  local messageBoxMemo = PAGetString(Defines.StringSheet_GAME, "LUA_PETMARKET_CANCELCONTENT")
  local messageBoxData = {
    title = PAGetString(Defines.StringSheet_GAME, "LUA_PETMARKET_CANCELTITLE"),
    content = messageBoxMemo,
    functionYes = cancelConfirm,
    functionNo = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageBoxData)
end
function PetAuction_Recieve(index)
  if MessageBoxGetShow() then
    return
  end
  local petAuctionData = auctionInfo:getPetAuctionAt(index)
  if nil == petAuctionData then
    _PA_LOG("asdf", "petAuctionData nil")
  end
  local self = PetMarket
  local fromWhereType = CppEnums.ItemWhereType.eInventory
  if self.radioBtn_Warehouse:IsCheck() then
    fromWhereType = CppEnums.ItemWhereType.eWarehouse
  end
  ToClient_popPricePetInAuctionReq(petAuctionData:getPetNo(), fromWhereType)
  _PA_LOG("\236\157\180\235\172\184\236\162\133", "fromWhereType == " .. fromWhereType .. " / \236\176\189\234\179\160 \236\154\148\236\178\173")
end
function PetAuction_ShowActionToolTip(action_idx, uiIdx, index)
  local self = PetMarket
  local slot = self._slots[index]
  local actionStaticStatus = ToClient_getPetActionStaticStatus(action_idx)
  if nil == actionStaticStatus then
    return
  end
  local actionIconPath = actionStaticStatus:getIconPath()
  local actionName = actionStaticStatus:getName()
  local actionDesc = actionStaticStatus:getDescription()
  local uiBase = slot.action[uiIdx]
  if "" == actionDesc then
    actionDesc = nil
  end
  TooltipSimple_Show(uiBase, actionName, actionDesc)
end
function PetAuction_HideActionToolTip(action_idx)
  TooltipSimple_Hide()
end
function PetMarket_ShowSkillToolTip(skill_idx, uiIdx, index)
  local skillStaticStatus = ToClient_getPetEquipSkillStaticStatus(skill_idx)
  local skillTypeStaticWrapper = skillStaticStatus:getSkillTypeStaticStatusWrapper()
  local petSkillNo = skillStaticStatus:getSkillNo()
  Panel_SkillTooltip_Show(petSkillNo, false, index)
end
function PetMarket_HideSkillToolTip()
  Panel_SkillTooltip_Hide()
end
function PetAuction_Open()
  local self = PetMarket
  if not Panel_Window_PetMarket:GetShow() then
    Panel_Window_PetMarket:SetShow(true)
    self._tabIndex = 0
    self.radioBtn_AllList:SetCheck(true)
    self.radioBtn_MyList:SetCheck(false)
    self.radioBtn_Bag:SetCheck(true)
    self.radioBtn_Warehouse:SetCheck(false)
  end
  self:Update()
end
function PetAuction_Update()
  PetMarket:Update()
end
function PetMarket_Close()
  if Panel_Window_PetMarket:GetShow() then
    Panel_Window_PetMarket:SetShow(false)
  end
  if not Panel_Window_PetListNew:GetShow() then
    FGlobal_PetListNew_Open()
  end
end
function FromClient_PetInAuctionList()
  PetAuction_Update()
end
function FromClient_BuyPetInAuction()
  if PetMarket.radioBtn_AllList:IsCheck() then
    requestPetList()
  else
    requestMyPetList()
  end
  Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_PETMARKET_BUYCONFIRM"))
end
function FromClient_CanclePetInAuction()
  if PetMarket.radioBtn_AllList:IsCheck() then
    requestPetList()
  else
    requestMyPetList()
  end
  Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_PETMARKET_CANCELCONFIRM"))
end
function FromClient_PopSellPricePetInAuction()
  _PA_LOG("\236\157\180\235\172\184\236\162\133", "??????????????????")
  if PetMarket.radioBtn_AllList:IsCheck() then
    requestPetList()
  else
    requestMyPetList()
  end
  Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_PETMARKET_RECIEVECONFIRM"))
end
function PetMarket_Repos()
  Panel_Window_PetMarket:SetPosX(getScreenSizeX() / 2 - Panel_Window_PetMarket:GetSizeX() / 2)
  Panel_Window_PetMarket:SetPosY(getScreenSizeY() / 2 - Panel_Window_PetMarket:GetSizeY() / 2 - 20)
end
PetMarket:Init()
PetMarket_Repos()
registerEvent("onScreenResize", "PetMarket_Repos")
registerEvent("FromClient_PetInAuctionList", "FromClient_PetInAuctionList")
registerEvent("FromClient_BuyPetInAuction", "FromClient_BuyPetInAuction")
registerEvent("FromClient_CanclePetInAuction", "FromClient_CanclePetInAuction")
registerEvent("FromClient_PopSellPricePetInAuction", "FromClient_PopSellPricePetInAuction")
registerEvent("EventWarehouseUpdate", "FromClient_PetInAuctionList")
