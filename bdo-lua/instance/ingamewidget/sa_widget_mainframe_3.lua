function PaGlobal_SA_MainFrame:updateEquipPool()
  local itemGradeColor
  for index = 1, #self._value_equip._itemSlot do
    if index < 0 or 12 < index then
      return
    end
    local itemWrapper = ToClient_getEquipmentItem(self._value_equip._itemSlot[index])
    local showTarget
    if 1 == index then
      showTarget = self._ui_equip.stc_weapon
    elseif 2 == index then
      showTarget = self._ui_equip.stc_subWeapon
    elseif 3 == index then
      showTarget = self._ui_equip.stc_armor
    elseif 4 == index then
      showTarget = self._ui_equip.stc_hands
    elseif 5 == index then
      showTarget = self._ui_equip.stc_shoes
    elseif 6 == index then
      showTarget = self._ui_equip.stc_head
    elseif 7 == index then
      showTarget = self._ui_equip.stc_neck
    elseif 8 == index then
      showTarget = self._ui_equip.stc_ring_1
    elseif 9 == index then
      showTarget = self._ui_equip.stc_ring_2
    elseif 10 == index then
      showTarget = self._ui_equip.stc_earing_1
    elseif 11 == index then
      showTarget = self._ui_equip.stc_earing_2
    elseif 12 == index then
      showTarget = self._ui_equip.stc_belt
    end
    if nil == itemWrapper and nil ~= showTarget then
      for equipIdx = 1, self._value_equip._itemGradeCnt do
        showTarget[equipIdx]:SetShow(false)
      end
    elseif nil ~= itemWrapper and nil ~= showTarget then
      for equipIdx = 1, self._value_equip._itemGradeCnt do
        showTarget[equipIdx]:SetShow(false)
        local itemSSW = itemWrapper:getStaticStatus()
        local itemGrade = itemSSW:getGradeType() + 1
        showTarget[itemGrade]:SetShow(true)
      end
    end
  end
  self:APDPShow()
end
function PaGlobal_SA_MainFrame:APDPShow()
  ToClient_updateAttackStat()
  local offenceValue = ToClient_getOffence()
  local defenceValue = ToClient_getDefence()
  if offenceValue > self._value_equip._preAp then
    self._ui_equip.txt_ap:AddEffect("UI_SkillButton01", false, 0, 0)
    self._value_equip._preAp = offenceValue
  end
  if defenceValue > self._value_equip._preDp then
    self._ui_equip.txt_dp:AddEffect("UI_SkillButton01", false, 0, 0)
    self._value_equip._preDp = defenceValue
  end
  local currentPlayerCount = ToClient_BattleRoyaleRemainPlayerCount()
  local blackSpiritLevel = 0
  local plusOffenceValue = 0
  local plusDefenceValue = 0
  if 1 <= currentPlayerCount then
    blackSpiritLevel = ToClient_GetBattleRoyaleGrowthLevel(currentPlayerCount)
    plusOffenceValue = ToClient_GetBattleRoyaleGrowthDD(blackSpiritLevel)
    plusDefenceValue = ToClient_GetBattleRoyaleGrowthPV(blackSpiritLevel)
  end
  if 0 < plusOffenceValue then
    self._ui_equip.txt_ap:SetText(offenceValue .. " <PAColor0xffe7d583>+" .. plusOffenceValue .. "<PAOldColor>")
  else
    self._ui_equip.txt_ap:SetText(offenceValue)
  end
  if 0 < plusDefenceValue then
    self._ui_equip.txt_dp:SetText(defenceValue .. " <PAColor0xffe7d583>+" .. plusDefenceValue .. "<PAOldColor>")
  else
    self._ui_equip.txt_dp:SetText(defenceValue)
  end
  PaGlobal_SA_Widget_Inventory_SetTopGroupInfo()
end
function FromClient_SA_MainFrame_UpdateEquipmentList()
  PaGlobal_SA_MainFrame:updateEquipPool()
end
function PaGlobalFunc_SA_MainFrame_APDPShow()
  PaGlobal_SA_MainFrame:APDPShow()
end
function PaGlobal_SA_MainFrame_GetCharacterInfoValue()
  return PaGlobal_SA_MainFrame._ui_equip.txt_ap:GetText(), PaGlobal_SA_MainFrame._ui_equip.txt_dp:GetText()
end
function FromClient_SA_MainFrame_EquipResizePanel()
  PaGlobal_SA_MainFrame._ui_equip.stc_equipBG:ComputePos()
  PaGlobal_SA_MainFrame._ui_equip.stc_equipTop:ComputePos()
  PaGlobal_SA_MainFrame._ui_equip.stc_partsHead:ComputePos()
  for index = 1, PaGlobal_SA_MainFrame._value_equip._itemGradeCnt do
    PaGlobal_SA_MainFrame._ui_equip.stc_head[index]:ComputePos()
  end
  PaGlobal_SA_MainFrame._ui_equip.stc_partsArmor:ComputePos()
  for index = 1, PaGlobal_SA_MainFrame._value_equip._itemGradeCnt do
    PaGlobal_SA_MainFrame._ui_equip.stc_armor[index]:ComputePos()
  end
  PaGlobal_SA_MainFrame._ui_equip.stc_partsHands:ComputePos()
  for index = 1, PaGlobal_SA_MainFrame._value_equip._itemGradeCnt do
    PaGlobal_SA_MainFrame._ui_equip.stc_hands[index]:ComputePos()
  end
  PaGlobal_SA_MainFrame._ui_equip.stc_partsShoes:ComputePos()
  for index = 1, PaGlobal_SA_MainFrame._value_equip._itemGradeCnt do
    PaGlobal_SA_MainFrame._ui_equip.stc_shoes[index]:ComputePos()
  end
  PaGlobal_SA_MainFrame._ui_equip.stc_accessoryNeck:ComputePos()
  for index = 1, PaGlobal_SA_MainFrame._value_equip._itemGradeCnt do
    PaGlobal_SA_MainFrame._ui_equip.stc_neck[index]:ComputePos()
  end
  PaGlobal_SA_MainFrame._ui_equip.stc_accessoryBelt:ComputePos()
  for index = 1, PaGlobal_SA_MainFrame._value_equip._itemGradeCnt do
    PaGlobal_SA_MainFrame._ui_equip.stc_belt[index]:ComputePos()
  end
  PaGlobal_SA_MainFrame._ui_equip.stc_accessoryEaring_1:ComputePos()
  for index = 1, PaGlobal_SA_MainFrame._value_equip._itemGradeCnt do
    PaGlobal_SA_MainFrame._ui_equip.stc_earing_1[index]:ComputePos()
  end
  PaGlobal_SA_MainFrame._ui_equip.stc_accessoryEaring_2:ComputePos()
  for index = 1, PaGlobal_SA_MainFrame._value_equip._itemGradeCnt do
    PaGlobal_SA_MainFrame._ui_equip.stc_earing_2[index]:ComputePos()
  end
  PaGlobal_SA_MainFrame._ui_equip.stc_accessoryRing_1:ComputePos()
  for index = 1, PaGlobal_SA_MainFrame._value_equip._itemGradeCnt do
    PaGlobal_SA_MainFrame._ui_equip.stc_ring_1[index]:ComputePos()
  end
  PaGlobal_SA_MainFrame._ui_equip.stc_accessoryRing_2:ComputePos()
  for index = 1, PaGlobal_SA_MainFrame._value_equip._itemGradeCnt do
    PaGlobal_SA_MainFrame._ui_equip.stc_ring_2[index]:ComputePos()
  end
  PaGlobal_SA_MainFrame._ui_equip.txt_weapon:ComputePos()
  for index = 1, PaGlobal_SA_MainFrame._value_equip._itemGradeCnt do
    PaGlobal_SA_MainFrame._ui_equip.stc_weapon[index]:ComputePos()
  end
  PaGlobal_SA_MainFrame._ui_equip.txt_ap:ComputePos()
  PaGlobal_SA_MainFrame._ui_equip.txt_subweapon:ComputePos()
  for index = 1, PaGlobal_SA_MainFrame._value_equip._itemGradeCnt do
    PaGlobal_SA_MainFrame._ui_equip.stc_subWeapon[index]:ComputePos()
  end
  PaGlobal_SA_MainFrame._ui_equip.txt_ap:ComputePos()
end
function PaGlobal_SA_MainFrame:equipInit()
  if nil == Panel_SA_MainFrame then
    return
  end
  local equipInfo = UI.getChildControl(Panel_SA_MainFrame, "Static_EquipInfo")
  self._ui_equip.stc_equipBG = UI.getChildControl(equipInfo, "Static_EquipBG")
  self._ui_equip.stc_equipTop = UI.getChildControl(self._ui_equip.stc_equipBG, "Static_Equip_Top")
  self._ui_equip.stc_partsHead = UI.getChildControl(self._ui_equip.stc_equipTop, "Static_Parts_Head")
  for index = 1, self._value_equip._itemGradeCnt do
    self._ui_equip.stc_head[index] = UI.getChildControl(self._ui_equip.stc_partsHead, "Static_Head_" .. index)
  end
  self._ui_equip.stc_partsArmor = UI.getChildControl(self._ui_equip.stc_equipTop, "Static_Parts_Armor")
  for index = 1, self._value_equip._itemGradeCnt do
    self._ui_equip.stc_armor[index] = UI.getChildControl(self._ui_equip.stc_partsArmor, "Static_Armor_" .. index)
  end
  self._ui_equip.stc_partsHands = UI.getChildControl(self._ui_equip.stc_equipTop, "Static_Parts_Hands")
  for index = 1, self._value_equip._itemGradeCnt do
    self._ui_equip.stc_hands[index] = UI.getChildControl(self._ui_equip.stc_partsHands, "Static_Hands_" .. index)
  end
  self._ui_equip.stc_partsShoes = UI.getChildControl(self._ui_equip.stc_equipTop, "Static_Parts_Shoes")
  for index = 1, self._value_equip._itemGradeCnt do
    self._ui_equip.stc_shoes[index] = UI.getChildControl(self._ui_equip.stc_partsShoes, "Static_Shoe_" .. index)
  end
  self._ui_equip.stc_accessoryNeck = UI.getChildControl(self._ui_equip.stc_equipBG, "Static_Accessory_Neck")
  for index = 1, self._value_equip._itemGradeCnt do
    self._ui_equip.stc_neck[index] = UI.getChildControl(self._ui_equip.stc_accessoryNeck, "Static_Neck_" .. index)
  end
  self._ui_equip.stc_accessoryBelt = UI.getChildControl(self._ui_equip.stc_equipBG, "Static_Accessory_Belt")
  for index = 1, self._value_equip._itemGradeCnt do
    self._ui_equip.stc_belt[index] = UI.getChildControl(self._ui_equip.stc_accessoryBelt, "Static_Belt_" .. index)
  end
  self._ui_equip.stc_accessoryEaring_1 = UI.getChildControl(self._ui_equip.stc_equipBG, "Static_Accessory_Earing_1")
  for index = 1, self._value_equip._itemGradeCnt do
    self._ui_equip.stc_earing_1[index] = UI.getChildControl(self._ui_equip.stc_accessoryEaring_1, "Static_Earing_" .. index)
  end
  self._ui_equip.stc_accessoryEaring_2 = UI.getChildControl(self._ui_equip.stc_equipBG, "Static_Accessory_Earing_2")
  for index = 1, self._value_equip._itemGradeCnt do
    self._ui_equip.stc_earing_2[index] = UI.getChildControl(self._ui_equip.stc_accessoryEaring_2, "Static_Earing_" .. index)
  end
  self._ui_equip.stc_accessoryRing_1 = UI.getChildControl(self._ui_equip.stc_equipBG, "Static_Accessory_Ring_1")
  for index = 1, self._value_equip._itemGradeCnt do
    self._ui_equip.stc_ring_1[index] = UI.getChildControl(self._ui_equip.stc_accessoryRing_1, "Static_Ring_" .. index)
  end
  self._ui_equip.stc_accessoryRing_2 = UI.getChildControl(self._ui_equip.stc_equipBG, "Static_Accessory_Ring_2")
  for index = 1, self._value_equip._itemGradeCnt do
    self._ui_equip.stc_ring_2[index] = UI.getChildControl(self._ui_equip.stc_accessoryRing_2, "Static_Ring_" .. index)
  end
  self._ui.stc_weaponBG = UI.getChildControl(self._ui_equip.stc_equipTop, "Static_Parts_Weapon")
  self._ui_equip.txt_weapon = UI.getChildControl(equipInfo, "StaticText_Weapon")
  for index = 1, self._value_equip._itemGradeCnt do
    self._ui_equip.stc_weapon[index] = UI.getChildControl(self._ui.stc_weaponBG, "Static_Weapon_" .. index)
  end
  self._ui_equip.txt_ap = UI.getChildControl(self._ui_equip.txt_weapon, "StaticText_AP")
  self._ui.stc_subWeaponBG = UI.getChildControl(self._ui_equip.stc_equipTop, "Static_Parts_SubWeapon")
  self._ui_equip.txt_subweapon = UI.getChildControl(equipInfo, "StaticText_SubWeapon")
  for index = 1, self._value_equip._itemGradeCnt do
    self._ui_equip.stc_subWeapon[index] = UI.getChildControl(self._ui.stc_subWeaponBG, "Static_SubWeapon_" .. index)
  end
  self._ui_equip.txt_dp = UI.getChildControl(self._ui_equip.txt_subweapon, "StaticText_DP")
end
function PaGlobal_SA_MainFrame:equipValidate()
  if nil == Panel_SA_MainFrame then
    return
  end
  self._ui_equip.stc_equipBG:isValidate()
  self._ui_equip.stc_equipTop:isValidate()
  self._ui_equip.stc_partsHead:isValidate()
  for index = 1, self._value_equip._itemGradeCnt do
    self._ui_equip.stc_head[index]:isValidate()
  end
  self._ui_equip.stc_partsArmor:isValidate()
  for index = 1, self._value_equip._itemGradeCnt do
    self._ui_equip.stc_armor[index]:isValidate()
  end
  self._ui_equip.stc_partsHands:isValidate()
  for index = 1, self._value_equip._itemGradeCnt do
    self._ui_equip.stc_hands[index]:isValidate()
  end
  self._ui_equip.stc_partsShoes:isValidate()
  for index = 1, self._value_equip._itemGradeCnt do
    self._ui_equip.stc_shoes[index]:isValidate()
  end
  self._ui_equip.stc_accessoryNeck:isValidate()
  for index = 1, self._value_equip._itemGradeCnt do
    self._ui_equip.stc_neck[index]:isValidate()
  end
  self._ui_equip.stc_accessoryBelt:isValidate()
  for index = 1, self._value_equip._itemGradeCnt do
    self._ui_equip.stc_belt[index]:isValidate()
  end
  self._ui_equip.stc_accessoryEaring_1:isValidate()
  for index = 1, self._value_equip._itemGradeCnt do
    self._ui_equip.stc_earing_1[index]:isValidate()
  end
  self._ui_equip.stc_accessoryEaring_2:isValidate()
  for index = 1, self._value_equip._itemGradeCnt do
    self._ui_equip.stc_earing_2[index]:isValidate()
  end
  self._ui_equip.stc_accessoryRing_1:isValidate()
  for index = 1, self._value_equip._itemGradeCnt do
    self._ui_equip.stc_ring_1[index]:isValidate()
  end
  self._ui_equip.stc_accessoryRing_2:isValidate()
  for index = 1, self._value_equip._itemGradeCnt do
    self._ui_equip.stc_ring_2[index]:isValidate()
  end
  self._ui_equip.txt_weapon:isValidate()
  for index = 1, self._value_equip._itemGradeCnt do
    self._ui_equip.stc_weapon[index]:isValidate()
  end
  self._ui_equip.txt_ap:isValidate()
  self._ui_equip.txt_subweapon:isValidate()
  for index = 1, self._value_equip._itemGradeCnt do
    self._ui_equip.stc_subWeapon[index]:isValidate()
  end
  self._ui_equip.txt_ap:isValidate()
end
