function PaGlobal_BuildingBuff_All:initialize()
  if true == PaGlobal_BuildingBuff_All._initialize then
    return
  end
  self._ui._stc_Title = UI.getChildControl(Panel_Window_BuildingBuff_All, "StaticText_Title")
  self._ui._btn_Close = UI.getChildControl(self._ui._stc_Title, "Button_Win_Close_PC")
  self._ui._stc_SubFrame = UI.getChildControl(Panel_Window_BuildingBuff_All, "Static_SubFrameBg")
  self._ui._list2 = UI.getChildControl(self._ui._stc_SubFrame, "List2_BuffList")
  self._ui._stc_BottomGroup = UI.getChildControl(Panel_Window_BuildingBuff_All, "Static_BottomGroup")
  self._ui._txt_DescBG = UI.getChildControl(self._ui._stc_BottomGroup, "StaticText_BottomDesc")
  self._ui._rdo_Money = UI.getChildControl(self._ui._stc_BottomGroup, "RadioButton_Money")
  self._ui._rdo_Money2 = UI.getChildControl(self._ui._stc_BottomGroup, "RadioButton_Money2")
  self._ui._txt_Money = UI.getChildControl(self._ui._stc_BottomGroup, "StaticText_Money")
  self._ui._txt_Money2 = UI.getChildControl(self._ui._stc_BottomGroup, "StaticText_Money2")
  self._ui._stc_KeyGuide = UI.getChildControl(Panel_Window_BuildingBuff_All, "Static_ConsoleKeyGuide")
  self._maxPriceKey = ToClient_GetBuildingBuffCount()
  PaGlobal_BuildingBuff_All:setPos()
  self._ui._txt_DescBG:SetTextMode(__eTextMode_AutoWrap)
  self._ui._txt_DescBG:setPadding(CppEnums.Padding.ePadding_Left, 20)
  self._ui._txt_DescBG:setPadding(CppEnums.Padding.ePadding_Top, 20)
  self._ui._txt_DescBG:setPadding(CppEnums.Padding.ePadding_Right, 20)
  self._ui._txt_DescBG:setPadding(CppEnums.Padding.ePadding_Bottom, 20)
  self._ui._txt_DescBG:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_BUILDINGBUFF_BOTTOMDESC"))
  self._ui._rdo_Money:SetEnableArea(0, 0, self._ui._txt_Money:GetPosX() + self._ui._txt_Money:GetSizeX(), 30)
  self._ui._rdo_Money2:SetEnableArea(0, 0, self._ui._txt_Money2:GetPosX() + self._ui._txt_Money2:GetSizeX(), 30)
  self._ui._rdo_Money:SetCheck(true)
  self._ui._rdo_Money2:SetCheck(false)
  self._ui._txt_DescBG:ComputePos()
  local stc_RankListTitleBG = UI.getChildControl(self._ui._stc_SubFrame, "Static_RankListTitleBG")
  local stc_RankTitle = UI.getChildControl(stc_RankListTitleBG, "StaticText_RankTitle")
  stc_RankTitle:SetText(PAGetString(Defines.StringSheet_GAME, "INTIMACYINFORMATION_TYPE_BUFF"))
  self.originPanelSizeY = Panel_Window_BuildingBuff_All:GetSizeY()
  self.originDescSizeY = self._ui._txt_DescBG:GetSizeY()
  self.originBottomBGSizeY = self._ui._stc_BottomGroup:GetSizeY()
  self.originKeyGuidePosY = self._ui._stc_KeyGuide:GetPosY()
  PaGlobal_BuildingBuff_All:initControlConsole()
  PaGlobal_BuildingBuff_All:resizePanel()
  PaGlobal_BuildingBuff_All:setAlignKeyGuide()
  PaGlobal_BuildingBuff_All:registEventHandler()
  PaGlobal_BuildingBuff_All:validate()
  PaGlobal_BuildingBuff_All._initialize = true
end
function PaGlobal_BuildingBuff_All:setAlignKeyGuide()
  local selectKeyGuide = UI.getChildControl(self._ui._stc_KeyGuide, "StaticText_Select")
  local closeKeyGuide = UI.getChildControl(self._ui._stc_KeyGuide, "StaticText_Close")
  selectKeyGuide:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_GENERIC_KEYGUIDE_XBOX_SELECT"))
  closeKeyGuide:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_COMMON_CLOSE"))
  local keyGuide = {selectKeyGuide, closeKeyGuide}
  PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyGuide, self._ui._stc_KeyGuide, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHT)
end
function PaGlobal_BuildingBuff_All:initControlConsole()
  if false == _ContentsGroup_UsePadSnapping then
    return
  end
  self._ui._stc_KeyGuide:SetShow(true)
end
function PaGlobal_BuildingBuff_All:registEventHandler()
  if nil == Panel_Window_BuildingBuff_All then
    return
  end
  PaGlobal_BuildingBuff_All._ui._list2:registEvent(__ePAUIList2EventType_LuaChangeContent, "PaGlobalFunc_BuildingBuff_All_ListControlCreate")
  PaGlobal_BuildingBuff_All._ui._list2:createChildContent(__ePAUIList2ElementManagerType_List)
  PaGlobal_BuildingBuff_All._ui._btn_Close:addInputEvent("Mouse_LUp", "PaGlobalFunc_BuildingBuff_All_Close()")
  registerEvent("FromClient_InventoryUpdate", "PaGlobalFunc_BuildingBuff_All_UpdateMoney")
  registerEvent("EventWarehouseUpdate", "PaGlobalFunc_BuildingBuff_All_UpdateMoney")
end
function PaGlobal_BuildingBuff_All:prepareOpen()
  if nil == Panel_Window_BuildingBuff_All then
    return
  end
  do
    local selfPlayer = getSelfPlayer():get()
    local regionInfo = getRegionInfoByPosition(selfPlayer:getPosition())
    if nil == regionInfo then
      return
    end
    local regionInfoWrapper = getRegionInfoWrapper(regionInfo:getAffiliatedTownRegionKey())
    local wayKey = regionInfoWrapper:getPlantKeyByWaypointKey():getWaypointKey()
    if true == ToClient_IsAccessibleRegionKey(regionInfo:getAffiliatedTownRegionKey()) then
      warehouse_requestInfo(regionInfoWrapper:get()._waypointKey)
    else
      local plantWayKey = ToClient_GetOtherRegionKey_NeerByTownRegionKey()
      local newRegionInfo = ToClient_getRegionInfoWrapperByWaypoint(plantWayKey)
      if nil == newRegionInfo then
        return
      end
      warehouse_requestInfo(newRegionInfo:get()._waypointKey)
    end
  end
  ToClient_RequestCurrentMainTownRegionWarehouseInfo()
  PaGlobal_BuildingBuff_All:updateMoney()
  PaGlobal_BuildingBuff_All:open()
  self._ui._list2:getElementManager():clearKey()
  self._buffInfo = {}
  local buffCount = 0
  for index = 0, self._maxPriceKey - 1 do
    local buffMaxCount = ToClient_GetCountPerBuffKeyCount(index)
    for buffIndex = 0, buffMaxCount - 1 do
      self._keyCount[buffCount] = index
      self._buffCount[buffCount] = buffIndex
      buffCount = buffCount + 1
    end
  end
  for index = 0, buffCount - 1 do
    self._ui._list2:getElementManager():pushKey(toInt64(0, index))
  end
end
function PaGlobal_BuildingBuff_All:open()
  if nil == Panel_Window_BuildingBuff_All then
    return
  end
  Panel_Window_BuildingBuff_All:SetShow(true)
end
function PaGlobal_BuildingBuff_All:prepareClose()
  if nil == Panel_Window_BuildingBuff_All then
    return
  end
  PaGlobal_BuildingBuff_All:close()
end
function PaGlobal_BuildingBuff_All:close()
  if nil == Panel_Window_BuildingBuff_All then
    return
  end
  Panel_Window_BuildingBuff_All:SetShow(false)
end
function PaGlobal_BuildingBuff_All:update()
  if nil == Panel_Window_BuildingBuff_All then
    return
  end
end
function PaGlobal_BuildingBuff_All:setPos()
  Panel_Window_BuildingBuff_All:SetPosX(getScreenSizeX() / 2 - Panel_Window_BuildingBuff_All:GetSizeX() / 2)
  Panel_Window_BuildingBuff_All:SetPosY(getScreenSizeY() / 2 - Panel_Window_BuildingBuff_All:GetSizeY() / 2)
end
function PaGlobal_BuildingBuff_All:resizePanel()
  local descSizeY = PaGlobal_BuildingBuff_All._ui._txt_DescBG:GetTextSizeY()
  local extraSizeY = descSizeY - self.originDescSizeY
  if 0 < extraSizeY then
    Panel_Window_BuildingBuff_All:SetSize(Panel_Window_BuildingBuff_All:GetSizeX(), self.originPanelSizeY + extraSizeY)
    PaGlobal_BuildingBuff_All._ui._stc_BottomGroup:SetSize(PaGlobal_BuildingBuff_All._ui._txt_DescBG:GetSizeX(), self.originBottomBGSizeY + extraSizeY)
    PaGlobal_BuildingBuff_All._ui._txt_DescBG:SetSize(PaGlobal_BuildingBuff_All._ui._txt_DescBG:GetSizeX(), self.originDescSizeY + extraSizeY)
    PaGlobal_BuildingBuff_All._ui._stc_KeyGuide:SetPosY(PaGlobal_BuildingBuff_All.originKeyGuidePosY + extraSizeY)
  end
end
function PaGlobal_BuildingBuff_All:listControlCreate(content, key)
  local index = Int64toInt32(key)
  local slot = UI.getChildControl(content, "Radiobutton_List2_BG")
  local keyText = UI.getChildControl(content, "StaticText_KeyCount1")
  local buff = UI.getChildControl(content, "StaticText_BuffDesc1")
  local applyBtn = UI.getChildControl(content, "Static_ApplyButton1_PC")
  local price = UI.getChildControl(content, "StaticText_Price1")
  local keyCount = PaGlobal_BuildingBuff_All._keyCount[index]
  local buffIndex = PaGlobal_BuildingBuff_All._buffCount[index]
  keyText:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_HOUSE_INSTALLATIONMODE_INNEROBJECTMAXCOUNT", "count", tostring(self._keyCount[index] + 1)))
  local skillNo = ToClient_GetBuildingBuff(keyCount, buffIndex)
  if 0 ~= skillNo then
    local skillWrapper = getSkillTypeStaticStatus(skillNo)
    local buffPrice = ToClient_GetBuildingBuffCost(keyCount, buffIndex)
    buffPrice = makeDotMoney(buffPrice)
    buff:SetTextMode(__eTextMode_Limit_AutoWrap)
    buff:SetText(tostring(skillWrapper:getName()))
    PaGlobal_BuildingBuff_All._limitControlName[index] = skillWrapper:getName()
    PaGlobal_BuildingBuff_All._limitControlDesc[index] = skillWrapper:getDescription()
    PaGlobal_BuildingBuff_All._limitControl[index] = buff
    slot:addInputEvent("Mouse_On", "PaGlobal_BuildingBuff_All_LimitTextTooltip(true, " .. index .. " )")
    slot:addInputEvent("Mouse_Out", "PaGlobal_BuildingBuff_All_LimitTextTooltip(false, " .. index .. " )")
    price:SetText(tostring(buffPrice))
    slot:addInputEvent("Mouse_LUp", "HandleEventLUp_BuildingBuff_All_ApplyBuff(" .. keyCount .. "," .. buffIndex .. ", " .. index .. ")")
  end
end
function PaGlobal_BuildingBuff_All:updateMoney()
  if nil == getSelfPlayer() then
    return
  end
  local wareHouseMoney = warehouse_moneyByCurrentRegionMainTown_s64()
  warehouse_moneyFromNpcShop_s64()
  PaGlobal_BuildingBuff_All._ui._txt_Money:SetText(makeDotMoney(getSelfPlayer():get():getInventory():getMoney_s64()))
  PaGlobal_BuildingBuff_All._ui._txt_Money2:SetText(makeDotMoney(wareHouseMoney))
end
function PaGlobal_BuildingBuff_All:limitTextTooltip(isShow, index, skillWrapper)
  if false == isShow then
    TooltipSimple_Hide()
    return
  end
  name = self._limitControlName[index]
  desc = self._limitControlDesc[index]
  TooltipSimple_Show(self._limitControl[index], name, desc)
end
function PaGlobal_BuildingBuff_All:applyBuff(keyCount, buffIndex, index)
  local function apply()
    ToClient_ApplyBuildingBuff(keyCount, buffIndex, self._ui._rdo_Money:IsCheck())
  end
  local messageBoxMemo = self._limitControl[index]:GetText() .. " " .. PAGetString(Defines.StringSheet_GAME, "LUA_CAMP_BUILDINGBUFF_MESSAGEBOX_DESC")
  local messageBoxData = {
    title = PAGetString(Defines.StringSheet_GAME, "LUA_MESSAGEBOX_NOTIFY"),
    content = messageBoxMemo,
    functionYes = apply,
    functionNo = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageBoxData)
end
function PaGlobal_BuildingBuff_All:validate()
  if nil == Panel_Window_BuildingBuff_All then
    return
  end
end
