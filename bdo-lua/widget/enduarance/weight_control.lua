function FGlobal_Inventory_WeightCheck()
  local self = PaGlobalPlayerWeightList
  local selfPlayerWrapper = getSelfPlayer()
  if nil == selfPlayerWrapper then
    return
  end
  local selfPlayer = selfPlayerWrapper:get()
  local s64_allWeight = selfPlayer:getCurrentWeight_s64()
  local s64_maxWeight = selfPlayer:getPossessableWeight_s64()
  local allWeight = Int64toInt32(s64_allWeight) / 10000
  local maxWeight = Int64toInt32(s64_maxWeight) / 10000
  local sumtotalWeight = allWeight / maxWeight * 100
  local totalWeight = string.format("%.0f", sumtotalWeight)
  local decreaseFairyWeight = Int64toInt32(ToClient_getDecreaseWeightByFairy()) / 10000
  local weightText = 100 + decreaseFairyWeight
  if 90 <= sumtotalWeight - decreaseFairyWeight then
    self.panel:SetShow(true)
    self.weight:SetShow(true)
    self.weightText:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_WEIGHT_MAIN_DEFAULT_VISUAL_WITH_FAIRY", "weight", tostring(weightText)))
    self.weightText:SetShow(true)
    self.weight:SetAlpha(0.8)
    self.weight:SetText(totalWeight .. "%")
    if false == _ContentsGroup_RenewUI_Tutorial and false == _ContentsGroup_Tutorial_Renewal then
      local tutorialMenuShow = PaGlobal_TutorialMenu:checkShowCondition()
      PaGlobal_TutorialMenu:setShow(tutorialMenuShow, tutorialMenuShow)
    end
    if 100 <= sumtotalWeight then
      self.weight:SetFontColor(Defines.Color.C_FFF26A6A)
    elseif sumtotalWeight <= 99 then
      self.weight:SetFontColor(Defines.Color.C_FFC4BEBE)
    end
    self.weight:addInputEvent("Mouse_On", "PaGlobalPlayerWeightList_MouseOver(true," .. tostring(weightText) .. " )")
    self.weight:addInputEvent("Mouse_Out", "PaGlobalPlayerWeightList_MouseOver(false," .. tostring(weightText) .. " )")
  else
    self.weight:SetShow(false)
    self.weightText:SetShow(false)
    if false == _ContentsGroup_RenewUI_Tutorial and false == _ContentsGroup_Tutorial_Renewal then
      local tutorialMenuShow = PaGlobal_TutorialMenu:checkShowCondition()
      PaGlobal_TutorialMenu:setShow(tutorialMenuShow, tutorialMenuShow)
    end
    self.weight:addInputEvent("Mouse_On", "PaGlobalPlayerWeightList_MouseOver(true, 100)")
    self.weight:addInputEvent("Mouse_Out", "PaGlobalPlayerWeightList_MouseOver(false, 100)")
  end
  if 100 <= sumtotalWeight and false == isOnEffect then
    self.weight:EraseAllEffect()
    self.weight:AddEffect("fUI_Weight_03A", true, -0.5, -1.3)
    isOnEffect = true
  elseif sumtotalWeight < 100 then
    self.weight:EraseAllEffect()
    isOnEffect = false
  end
  FGlobal_Inventory_WeightCheck_Reposition()
end
function FGlobal_Inventory_WeightCheck_Reposition()
  local self = PaGlobalPlayerWeightList
  if self.repair_AutoNavi:GetShow() then
    self.weight:SetPosY(self.panel:GetSizeY() + 50)
  else
    self.weight:SetPosY(5)
  end
  if Panel_HorseEndurance:GetShow() or Panel_CarriageEndurance:GetShow() or Panel_ShipEndurance:GetShow() or Panel_SailShipEndurance:GetShow() then
    self.weight:SetPosY(self.panel:GetSizeY() + 50)
  end
  if true == _ContentsGroup_RenewUI_Main then
    self.weight:SetPosY(self.panel:GetSizeY() + 50)
  end
  self.weightText:SetPosX(self.weight:GetPosX() - self.weightText:GetTextSizeX() - 30)
  self.weightText:SetPosY(self.weight:GetPosY() - 4)
  PaGlobalFunc_Endurance_InvenSlot_All_SetPosY(self.weight:GetPosY() + self.weight:GetSizeY() + 30)
  if true == _ContentsGroup_AccesoryQuest and nil ~= Panel_Widget_AccesoryQuest then
    PaGlobalFunc_AccesoryQuest_resetPosition()
  end
end
registerEvent("FromClient_InventoryUpdate", "FGlobal_Inventory_WeightCheck")
registerEvent("FromClient_WeightPenaltyChanged", "FGlobal_Inventory_WeightCheck")
