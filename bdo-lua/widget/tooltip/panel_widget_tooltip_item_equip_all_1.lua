function PaGlobal_Tooltip_Item_Equip_All:initialize()
  if true == self._initialize then
    return
  end
  self._ui.txt_equippedTag = UI.getChildControl(Panel_Widget_Tooltip_Item_Equip_All, "Tooltip_Item_nowEquiped_tag")
  self._ui.txt_itemName = UI.getChildControl(Panel_Widget_Tooltip_Item_Equip_All, "Tooltip_Item_Name")
  self._ui.stc_itemIcon = UI.getChildControl(Panel_Widget_Tooltip_Item_Equip_All, "Tooltip_Item_Icon")
  self._ui.txt_enchantLevel = UI.getChildControl(Panel_Widget_Tooltip_Item_Equip_All, "Tooltip_Item_Enchant_value")
  self._ui.txt_itemType = UI.getChildControl(Panel_Widget_Tooltip_Item_Equip_All, "Tooltip_Item_Type")
  self._ui.txt_dying = UI.getChildControl(Panel_Widget_Tooltip_Item_Equip_All, "StaticText_Dying")
  self._ui.txt_isEnchantable = UI.getChildControl(Panel_Widget_Tooltip_Item_Equip_All, "Tooltip_Item_isEnchantable")
  self._ui.txt_isRepair = UI.getChildControl(Panel_Widget_Tooltip_Item_Equip_All, "Tooltip_Item_isRepair")
  self._ui.txt_isSealed = UI.getChildControl(Panel_Widget_Tooltip_Item_Equip_All, "Tooltip_Item_isSealed")
  self._ui.txt_bindType = UI.getChildControl(Panel_Widget_Tooltip_Item_Equip_All, "Tooltip_Item_BindType")
  self._ui.txt_balksExtraction = UI.getChildControl(Panel_Widget_Tooltip_Item_Equip_All, "Tooltip_Item_Balks")
  self._ui.txt_cronsExtraction = UI.getChildControl(Panel_Widget_Tooltip_Item_Equip_All, "Tooltip_Item_Cron")
  self._ui.txt_useDyeColorTitle = UI.getChildControl(Panel_Widget_Tooltip_Item_Equip_All, "StaticText_DyeColorInfo")
  self._ui.stc_useDyeColorIcon_part = {
    [0] = UI.getChildControl(Panel_Widget_Tooltip_Item_Equip_All, "Static_DyeColorIcon_Part1"),
    UI.getChildControl(Panel_Widget_Tooltip_Item_Equip_All, "Static_DyeColorIcon_Part2"),
    UI.getChildControl(Panel_Widget_Tooltip_Item_Equip_All, "Static_DyeColorIcon_Part3"),
    UI.getChildControl(Panel_Widget_Tooltip_Item_Equip_All, "Static_DyeColorIcon_Part4"),
    UI.getChildControl(Panel_Widget_Tooltip_Item_Equip_All, "Static_DyeColorIcon_Part5"),
    UI.getChildControl(Panel_Widget_Tooltip_Item_Equip_All, "Static_DyeColorIcon_Part6"),
    UI.getChildControl(Panel_Widget_Tooltip_Item_Equip_All, "Static_DyeColorIcon_Part7"),
    UI.getChildControl(Panel_Widget_Tooltip_Item_Equip_All, "Static_DyeColorIcon_Part8"),
    UI.getChildControl(Panel_Widget_Tooltip_Item_Equip_All, "Static_DyeColorIcon_Part9"),
    UI.getChildControl(Panel_Widget_Tooltip_Item_Equip_All, "Static_DyeColorIcon_Part10"),
    UI.getChildControl(Panel_Widget_Tooltip_Item_Equip_All, "Static_DyeColorIcon_Part11"),
    UI.getChildControl(Panel_Widget_Tooltip_Item_Equip_All, "Static_DyeColorIcon_Part12")
  }
  self._ui.txt_useLimit_category = UI.getChildControl(Panel_Widget_Tooltip_Item_Equip_All, "Tooltip_Item_UseLimit_category")
  self._ui.stc_useLimit_panel = UI.getChildControl(Panel_Widget_Tooltip_Item_Equip_All, "Tooltip_Item_UseLimit_panel")
  self._ui.txt_useLimit_level = UI.getChildControl(Panel_Widget_Tooltip_Item_Equip_All, "Tooltip_Item_UseLimit_level")
  self._ui.txt_useLimit_level_value = UI.getChildControl(Panel_Widget_Tooltip_Item_Equip_All, "Tooltip_Item_UseLimit_level_value")
  self._ui.txt_useLimit_extendedslot = UI.getChildControl(Panel_Widget_Tooltip_Item_Equip_All, "Tooltip_Item_UseLimit_extendedslot")
  self._ui.txt_useLimit_extendedslot_value = UI.getChildControl(Panel_Widget_Tooltip_Item_Equip_All, "Tooltip_Item_UseLimit_extendedslot_value")
  self._ui.txt_useLimit_class = UI.getChildControl(Panel_Widget_Tooltip_Item_Equip_All, "Tooltip_Item_UseLimit_class")
  self._ui.txt_useLimit_class_value = UI.getChildControl(Panel_Widget_Tooltip_Item_Equip_All, "Tooltip_Item_UseLimit_class_value")
  self._ui.txt_useLimit_exp = UI.getChildControl(Panel_Widget_Tooltip_Item_Equip_All, "Tooltip_Item_UseLimit_Exp")
  self._ui.stc_useLimit_exp_gage = UI.getChildControl(Panel_Widget_Tooltip_Item_Equip_All, "Tooltip_Item_UseLimit_Exp_gage")
  self._ui.progress_useLimit_exp = UI.getChildControl(Panel_Widget_Tooltip_Item_Equip_All, "Progress_UseLimit_Exp_gage_value")
  self._ui.txt_useLimit_exp_value = UI.getChildControl(Panel_Widget_Tooltip_Item_Equip_All, "Tooltip_Item_UseLimit_Exp_value")
  self._ui.txt_useLimit_endurance = UI.getChildControl(Panel_Widget_Tooltip_Item_Equip_All, "Tooltip_Item_UseLimit_endurance")
  self._ui.stc_useLimit_endurance_gage = UI.getChildControl(Panel_Widget_Tooltip_Item_Equip_All, "Tooltip_Item_UseLimit_endurance_gage")
  self._ui.progress_useLimit_endurance = UI.getChildControl(Panel_Widget_Tooltip_Item_Equip_All, "Progress_UseLimit_endurance_gage_value")
  self._ui.progress_useLimit_maxEurance = UI.getChildControl(Panel_Widget_Tooltip_Item_Equip_All, "Progress2_MaxEndurance")
  self._ui.txt_useLimit_endurance_value = UI.getChildControl(Panel_Widget_Tooltip_Item_Equip_All, "Tooltip_Item_UseLimit_endurance_value")
  self._ui.txt_remainTime = UI.getChildControl(Panel_Widget_Tooltip_Item_Equip_All, "Tooltip_Item_UseLimit_remainTime")
  self._ui.txt_remainTime_value = UI.getChildControl(Panel_Widget_Tooltip_Item_Equip_All, "Tooltip_Item_UseLimit_remainTime_value")
  self._ui.stc_expireIcon_white = UI.getChildControl(Panel_Widget_Tooltip_Item_Equip_All, "Static_Expire_Icon1")
  self._ui.stc_expireIcon_red = UI.getChildControl(Panel_Widget_Tooltip_Item_Equip_All, "Static_Expire_Icon2")
  self._ui.stc_expireIcon_end = UI.getChildControl(Panel_Widget_Tooltip_Item_Equip_All, "Static_Expire_Icon3")
  self._ui.txt_defaultEffect_category = UI.getChildControl(Panel_Widget_Tooltip_Item_Equip_All, "Tooltip_Item_DefaultEffect_category")
  self._ui.stc_defaultEffect_panel = UI.getChildControl(Panel_Widget_Tooltip_Item_Equip_All, "Tooltip_Item_DefaultEffect_panel")
  self._ui.txt_attack = UI.getChildControl(Panel_Widget_Tooltip_Item_Equip_All, "Tooltip_Item_DefaultEffect_attack")
  self._ui.txt_attack_value = UI.getChildControl(Panel_Widget_Tooltip_Item_Equip_All, "Tooltip_Item_DefaultEffect_attack_value")
  self._ui.txt_attack_diffValue = UI.getChildControl(Panel_Widget_Tooltip_Item_Equip_All, "Tooltip_Item_DefaultEffect_attackDiff_value")
  self._ui.txt_statExtraParam1 = UI.getChildControl(Panel_Widget_Tooltip_Item_Equip_All, "Tooltip_Item_DefaultEffect_shyStat1")
  self._ui.txt_statExtraParam1_value = UI.getChildControl(Panel_Widget_Tooltip_Item_Equip_All, "Tooltip_Item_DefaultEffect_shyStat1_value")
  self._ui.txt_statExtraParam1_diffValue = UI.getChildControl(Panel_Widget_Tooltip_Item_Equip_All, "Tooltip_Item_DefaultEffect_shyStat1Diff_value")
  self._ui.txt_statExtraParam2 = UI.getChildControl(Panel_Widget_Tooltip_Item_Equip_All, "Tooltip_Item_DefaultEffect_shyStat2")
  self._ui.txt_statExtraParam2_value = UI.getChildControl(Panel_Widget_Tooltip_Item_Equip_All, "Tooltip_Item_DefaultEffect_shyStat2_value")
  self._ui.txt_statExtraParam2_diffValue = UI.getChildControl(Panel_Widget_Tooltip_Item_Equip_All, "Tooltip_Item_DefaultEffect_shyStat2Diff_value")
  self._ui.txt_statExtraParam3 = UI.getChildControl(Panel_Widget_Tooltip_Item_Equip_All, "Tooltip_Item_DefaultEffect_shyStat3")
  self._ui.txt_statExtraParam3_value = UI.getChildControl(Panel_Widget_Tooltip_Item_Equip_All, "Tooltip_Item_DefaultEffect_shyStat3_value")
  self._ui.txt_statExtraParam3_diffValue = UI.getChildControl(Panel_Widget_Tooltip_Item_Equip_All, "Tooltip_Item_DefaultEffect_shyStat3Diff_value")
  self._ui.txt_defense = UI.getChildControl(Panel_Widget_Tooltip_Item_Equip_All, "Tooltip_Item_DefaultEffect_defense")
  self._ui.txt_defense_value = UI.getChildControl(Panel_Widget_Tooltip_Item_Equip_All, "Tooltip_Item_DefaultEffect_defense_value")
  self._ui.txt_weight = UI.getChildControl(Panel_Widget_Tooltip_Item_Equip_All, "Tooltip_Item_DefaultEffect_weight")
  self._ui.txt_weight_value = UI.getChildControl(Panel_Widget_Tooltip_Item_Equip_All, "Tooltip_Item_DefaultEffect_weight_value")
  self._ui.txt_hit = UI.getChildControl(Panel_Widget_Tooltip_Item_Equip_All, "Tooltip_Item_DefaultEffect_hit")
  self._ui.txt_hit_value = UI.getChildControl(Panel_Widget_Tooltip_Item_Equip_All, "Tooltip_Item_DefaultEffect_hit_value")
  self._ui.txt_dv = UI.getChildControl(Panel_Widget_Tooltip_Item_Equip_All, "Tooltip_Item_DefaultEffect_dv")
  self._ui.txt_dv_value = UI.getChildControl(Panel_Widget_Tooltip_Item_Equip_All, "Tooltip_Item_DefaultEffect_dv_value")
  self._ui.txt_pv = UI.getChildControl(Panel_Widget_Tooltip_Item_Equip_All, "Tooltip_Item_DefaultEffect_pv")
  self._ui.txt_pv_value = UI.getChildControl(Panel_Widget_Tooltip_Item_Equip_All, "Tooltip_Item_DefaultEffect_pv_value")
  self._ui.txt_maxEnchanter = UI.getChildControl(Panel_Widget_Tooltip_Item_Equip_All, "StaticText_MaxEnchantCharName")
  self._ui.stc_soketOption_panel = UI.getChildControl(Panel_Widget_Tooltip_Item_Equip_All, "Tooltip_Item_SoketOption_panel")
  self._ui.txt_itemProducedPlace = UI.getChildControl(Panel_Widget_Tooltip_Item_Equip_All, "Tooltip_Item_ProducedPlace")
  self._ui.txt_itemDescription = UI.getChildControl(Panel_Widget_Tooltip_Item_Equip_All, "Tooltip_Item_Description")
  self._ui.stc_itemPrice_panel = UI.getChildControl(Panel_Widget_Tooltip_Item_Equip_All, "Tooltip_Item_ItemPrice_panel")
  self._ui.txt_itemPrice_transportBuy = UI.getChildControl(Panel_Widget_Tooltip_Item_Equip_All, "Tooltip_Item_ItemPrice_transportBuy")
  self._ui.txt_itemPrice_transportBuy_value = UI.getChildControl(Panel_Widget_Tooltip_Item_Equip_All, "Tooltip_Item_ItemPrice_transportBuy_value")
  self._ui.txt_itemPrice_storeSell = UI.getChildControl(Panel_Widget_Tooltip_Item_Equip_All, "Tooltip_Item_ItemPrice_storeSell")
  self._ui.txt_itemPrice_storeSell_value = UI.getChildControl(Panel_Widget_Tooltip_Item_Equip_All, "Tooltip_Item_ItemPrice_storeSell_value")
  self._ui.stc_tradeInfo_panel = UI.getChildControl(Panel_Widget_Tooltip_Item_Equip_All, "Static_TradeInfoPanel")
  self._ui.txt_tradeInfo_title = UI.getChildControl(Panel_Widget_Tooltip_Item_Equip_All, "StaticText_TradePriceTitle")
  self._ui.txt_tradeInfo_value = UI.getChildControl(Panel_Widget_Tooltip_Item_Equip_All, "StaticText_TradePriceValue")
  self._ui.stc_tradeInfo_ani = UI.getChildControl(self._ui.txt_tradeInfo_value, "Static_Construction")
  self._ui.txt_equipSlotName = UI.getChildControl(Panel_Widget_Tooltip_Item_Equip_All, "StaticText_EquipTypeName")
  self._ui.txt_productNotify = UI.getChildControl(Panel_Widget_Tooltip_Item_Equip_All, "Static_ProductNotify")
  self._ui.txt_itemLockNotify = UI.getChildControl(Panel_Widget_Tooltip_Item_Equip_All, "Static_ItemLockNotify")
  self._ui.txt_isPersonalTrade = UI.getChildControl(Panel_Widget_Tooltip_Item_Equip_All, "StaticText_IsPersnalTrade")
  self._ui.txt_isItemLock = UI.getChildControl(Panel_Widget_Tooltip_Item_Equip_All, "StaticText_IsItemLock")
  self._ui.txt_exchangeTitle = UI.getChildControl(Panel_Widget_Tooltip_Item_Equip_All, "Tooltip_Item_ExchangeTitle")
  self._ui.txt_exchangeDesc = UI.getChildControl(Panel_Widget_Tooltip_Item_Equip_All, "Tooltip_Item_ExchangeDescription")
  self._ui.txt_recoveryDesc = UI.getChildControl(Panel_Widget_Tooltip_Item_Equip_All, "StaticText_ItemRecoveryDesc")
  self._ui.txt_cronStoneEnchant = UI.getChildControl(Panel_Widget_Tooltip_Item_Equip_All, "StaticText_CronEnchant")
  self._ui.txt_cronStoneValue = UI.getChildControl(Panel_Widget_Tooltip_Item_Equip_All, "StaticText_CronStackDesc")
  self._ui.txt_randomOptionTitle = UI.getChildControl(Panel_Widget_Tooltip_Item_Equip_All, "StaticText_RandomOptionTitle")
  self._ui.txt_randomOptionValue = {
    [0] = UI.getChildControl(Panel_Widget_Tooltip_Item_Equip_All, "StaticText_RandomOption1"),
    [1] = UI.getChildControl(Panel_Widget_Tooltip_Item_Equip_All, "StaticText_RandomOption2"),
    [2] = UI.getChildControl(Panel_Widget_Tooltip_Item_Equip_All, "StaticText_RandomOption3"),
    [3] = UI.getChildControl(Panel_Widget_Tooltip_Item_Equip_All, "StaticText_RandomOption4"),
    [4] = UI.getChildControl(Panel_Widget_Tooltip_Item_Equip_All, "StaticText_RandomOption5")
  }
  self._ui.txt_enchantDifficulty = UI.getChildControl(Panel_Widget_Tooltip_Item_Equip_All, "StaticText_EnchantDifficulty")
  self._ui.txt_soulCollector = UI.getChildControl(Panel_Widget_Tooltip_Item_Equip_All, "StaticText_SoulCollector")
  self._ui.txt_supplyValue = UI.getChildControl(Panel_Widget_Tooltip_Item_Equip_All, "StaticText_SupplyValue")
  for idx = 1, 6 do
    self._ui.stc_soketSlot[idx] = UI.getChildControl(Panel_Widget_Tooltip_Item_Equip_All, "Tooltip_Item_SoketOption_soketSlot" .. idx)
    self._ui.txt_soketName[idx] = UI.getChildControl(Panel_Widget_Tooltip_Item_Equip_All, "Tooltip_Item_SoketOption_soketName" .. idx)
    self._ui.txt_soketEffect[idx] = UI.getChildControl(Panel_Widget_Tooltip_Item_Equip_All, "Tooltip_Item_SoketOption_soketEffect" .. idx)
  end
  self._ui.stc_arrow = UI.getChildControl(Panel_Widget_Tooltip_Item_Equip_All, "Static_Arrow")
  self._ui.stc_arrow_L = UI.getChildControl(Panel_Widget_Tooltip_Item_Equip_All, "Static_Arrow_L")
  self._panelSize = Panel_Widget_Tooltip_Item_Equip_All:GetSizeY()
  self._grapeSize = self._ui.txt_useLimit_endurance_value:GetSizeY()
  self._socketSize = self._ui.stc_soketOption_panel:GetSizeY()
  PaGlobalFunc_Tooltip_Control_All_InitPanel(self._mainPanel, PaGlobal_Tooltip_Item_Equip_All)
  self:registEventHandler()
  self:validate()
  self._initialize = true
end
function PaGlobal_Tooltip_Item_Equip_All:registEventHandler()
  if nil == Panel_Widget_Tooltip_Item_Equip_All then
    return
  end
end
function PaGlobal_Tooltip_Item_Equip_All:prepareOpen()
  if nil == Panel_Widget_Tooltip_Item_Equip_All then
    return
  end
  self:open()
end
function PaGlobal_Tooltip_Item_Equip_All:open()
  if nil == Panel_Widget_Tooltip_Item_Equip_All then
    return
  end
  Panel_Widget_Tooltip_Item_Equip_All:SetShow(true)
end
function PaGlobal_Tooltip_Item_Equip_All:prepareClose()
  if nil == Panel_Widget_Tooltip_Item_Equip_All then
    return
  end
  self:close()
end
function PaGlobal_Tooltip_Item_Equip_All:close()
  if nil == Panel_Widget_Tooltip_Item_Equip_All then
    return
  end
  Panel_Widget_Tooltip_Item_Equip_All:SetShow(false)
end
function PaGlobal_Tooltip_Item_Equip_All:update()
  if nil == Panel_Widget_Tooltip_Item_Equip_All then
    return
  end
end
function PaGlobal_Tooltip_Item_Equip_All:validate()
  if nil == Panel_Widget_Tooltip_Item_Equip_All then
    return
  end
end
