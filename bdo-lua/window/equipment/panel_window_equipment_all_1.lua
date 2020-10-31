function PaGlobal_Equipment_All:initialize()
  if nil == Panel_Window_Equipment_All or true == PaGlobal_Equipment_All._initialize then
    return
  end
  PaGlobal_Equipment_All:controlInit()
  PaGlobal_Equipment_All:setData()
  PaGlobal_Equipment_All:setSlot()
  PaGlobal_Equipment_All:registerEventHandler()
  PaGlobal_Equipment_All:validate()
  PaGlobal_Equipment_All._initialize = true
end
function PaGlobal_Equipment_All:controlInit()
  self._ui.txt_titleBG = UI.getChildControl(Panel_Window_Equipment_All, "StaticText_Title")
  self._ui.check_popup = UI.getChildControl(self._ui.txt_titleBG, "CheckButton_PopUp")
  self._ui.btn_question = UI.getChildControl(self._ui.txt_titleBG, "Button_Question")
  self._ui.btn_close = UI.getChildControl(self._ui.txt_titleBG, "Button_Close")
  self._ui.stc_circle = UI.getChildControl(Panel_Window_Equipment_All, "Static_MainCircle")
  self._ui.stc_abilityArea = UI.getChildControl(Panel_Window_Equipment_All, "Static_AbilityArea")
  self._ui.txt_attackText = UI.getChildControl(self._ui.stc_abilityArea, "StaticText_Attack")
  self._ui.txt_attackValue = UI.getChildControl(self._ui.stc_abilityArea, "StaticText_Attack_Value")
  self._ui.txt_defenceText = UI.getChildControl(self._ui.stc_abilityArea, "StaticText_Defence")
  self._ui.txt_defenceValue = UI.getChildControl(self._ui.stc_abilityArea, "StaticText_Defence_Value")
  self._ui.txt_awakenText = UI.getChildControl(self._ui.stc_abilityArea, "StaticText_AwakenAttack")
  self._ui.txt_awakenValue = UI.getChildControl(self._ui.stc_abilityArea, "StaticText_AwakenAttack_Value")
  self._ui.txt_shyStatText = UI.getChildControl(self._ui.stc_abilityArea, "StaticText_ShyStat1_Title")
  self._ui.txt_shyStatValue = UI.getChildControl(self._ui.stc_abilityArea, "StaticText_ShyStat1_Value")
  self._ui.stc_bottomButtonArea = UI.getChildControl(Panel_Window_Equipment_All, "Static_BottomButtonArea")
  self._ui.btn_servantInven = UI.getChildControl(self._ui.stc_bottomButtonArea, "Button_ServantInventory")
  self._ui.check_camouflage = UI.getChildControl(self._ui.stc_bottomButtonArea, "CheckButton_ShowNameWhenCamouflage")
  self._ui.check_underwear = UI.getChildControl(self._ui.stc_bottomButtonArea, "CheckButton_Underwear_Invisual")
  self._ui.btn_petList = UI.getChildControl(self._ui.stc_bottomButtonArea, "Button_PetInfo")
  self._ui.check_helmInvisual = UI.getChildControl(self._ui.stc_bottomButtonArea, "CheckButton_Helm_Invisual")
  self._ui.check_helmOpen = UI.getChildControl(self._ui.stc_bottomButtonArea, "CheckButton_HelmOpen")
  self._ui.check_cloak = UI.getChildControl(self._ui.stc_bottomButtonArea, "CheckButton_Cloak_Invisual")
  self._ui.stc_helmInvisualIcon = UI.getChildControl(self._ui.check_helmInvisual, "Static_Icon")
  self._ui.stc_helmOpenIcon = UI.getChildControl(self._ui.check_helmOpen, "Static_Icon")
  self._ui.btn_setEffect = UI.getChildControl(Panel_Window_Equipment_All, "Button_SetEffect")
  self._ui.btn_equipCrystal = UI.getChildControl(Panel_Window_Equipment_All, "Button_EquipCrystal")
  self._ui.stc_seasonBannerPass = UI.getChildControl(Panel_Window_Equipment_All, "Static_SeasonBanner")
  self._ui.stc_seasonBannerReward = UI.getChildControl(Panel_Window_Equipment_All, "Static_RewardList")
  self._ui.check_alchemyStone = UI.getChildControl(Panel_Window_Equipment_All, "CheckBox_AlchemyStone")
  self._ui.txt_alchemyStoneQuickKey = UI.getChildControl(Panel_Window_Equipment_All, "Static_Slot_AlchemyStone_Key")
  self._ui.tooltipTemplate = UI.getChildControl(Panel_Window_Equipment_All, "StaticText_Notice_1")
  self._ui.txt_blankSlotTooltip = UI.createControl(__ePAUIControl_StaticText, Panel_Window_Equipment_All, "toolTip_BlankSlot_For_Equipment")
  CopyBaseProperty(self._ui.tooltipTemplate, self._ui.txt_blankSlotTooltip)
end
function PaGlobal_Equipment_All:checkUsableSlot(index)
  if index == self._UnUsedEquipNo_01 or index == self._UnUsedEquipNo_02 or index == CppEnums.EquipSlotNo.equipSlotNoCount or index == CppEnums.EquipSlotNo.explorationBonus0 or index == CppEnums.EquipSlotNo.installation4 or index == CppEnums.EquipSlotNo.body or index == CppEnums.EquipSlotNo.avatarBody then
    return false
  end
  return true
end
function PaGlobal_Equipment_All:setSlot()
  if nil == getSelfPlayer() then
    return
  end
  local classType = getSelfPlayer():getClassType()
  for slotNo = self._EquipNoMin, self._EquipNoMax do
    if true == PaGlobal_Equipment_All:checkUsableSlot(slotNo) then
      local slotBG = UI.getChildControl(self._ui.stc_circle, self._slotNoId[slotNo] .. "_BG")
      slotBG:SetShow(false)
      self.slotBGs[slotNo] = slotBG
      local whereType = Inventory_GetCurrentInventoryType()
      if true == ToClient_EquipSlot_CheckItemLock(slotNo, whereType) then
        ToClient_Inventory_RemoveItemLock(slotNo)
      end
      if CppEnums.EquipSlotNo.awakenWeapon == slotNo then
        if __eClassType_ShyWaman == classType then
          self.slotBGs[slotNo]:ChangeTextureInfoName("combine/icon/combine_equip_icon_00.dds")
          local x1, y1, x2, y2 = setTextureUV_Func(self.slotBGs[slotNo], 283, 48, 329, 94)
          self.slotBGs[slotNo]:getBaseTexture():setUV(x1, y1, x2, y2)
          self.slotBGs[slotNo]:setRenderTexture(self.slotBGs[slotNo]:getBaseTexture())
        else
          self.slotBGs[slotNo]:ChangeTextureInfoName("combine/icon/combine_equip_icon_00.dds")
          local x1, y1, x2, y2 = setTextureUV_Func(self.slotBGs[slotNo], 95, 1, 141, 47)
          self.slotBGs[slotNo]:getBaseTexture():setUV(x1, y1, x2, y2)
          self.slotBGs[slotNo]:setRenderTexture(self.slotBGs[slotNo]:getBaseTexture())
        end
      end
      if CppEnums.EquipSlotNo.avatarAwakenWeapon == slotNo then
        if __eClassType_ShyWaman == classType then
          self.slotBGs[slotNo]:ChangeTextureInfoName("combine/icon/combine_equip_icon_00.dds")
          local x1, y1, x2, y2 = setTextureUV_Func(self.slotBGs[slotNo], 330, 48, 376, 94)
          self.slotBGs[slotNo]:getBaseTexture():setUV(x1, y1, x2, y2)
          self.slotBGs[slotNo]:setRenderTexture(self.slotBGs[slotNo]:getBaseTexture())
        else
          self.slotBGs[slotNo]:ChangeTextureInfoName("combine/icon/combine_equip_icon_00.dds")
          local x1, y1, x2, y2 = setTextureUV_Func(self.slotBGs[slotNo], 95, 95, 141, 141)
          self.slotBGs[slotNo]:getBaseTexture():setUV(x1, y1, x2, y2)
          self.slotBGs[slotNo]:setRenderTexture(self.slotBGs[slotNo]:getBaseTexture())
        end
      end
      local slot = {}
      slot.icon = UI.getChildControl(self._ui.stc_circle, self._slotNoId[slotNo])
      SlotItem.new(slot, "Equipment_" .. slotNo, slotNo, Panel_Equipment, self._slotConfig)
      slot:createChild()
      slot.icon:addInputEvent("Mouse_RUp", "HandleEventRUp_Equipment_All_EquipSlotRClick(" .. slotNo .. ")")
      slot.icon:addInputEvent("Mouse_LUp", "HandleEventLUp_Equipment_All_EquipSlotLClick(" .. slotNo .. ")")
      slot.icon:addInputEvent("Mouse_On", "HandleEventOnOut_Equipment_All_EquipmentTooltip(" .. slotNo .. ",true)")
      slot.icon:addInputEvent("Mouse_Out", "HandleEventOnOut_Equipment_All_EquipmentTooltip(" .. slotNo .. ",false)")
      Panel_Tooltip_Item_SetPosition(slotNo, slot, "equipment")
      self.slots[slotNo] = slot
      if nil ~= self._avataEquipSlotId[slotNo] then
        self.avataSlots[slotNo] = UI.getChildControl(self._ui.stc_circle, self._avataEquipSlotId[slotNo])
        self.avataSlots[slotNo]:SetShow(true)
        self.avataSlots[slotNo]:SetPosX(slot.icon:GetPosX() + slot.icon:GetSizeX() - 15)
        self.avataSlots[slotNo]:SetPosY(slot.icon:GetPosY() + slot.icon:GetSizeY() - 15)
        self.avataSlots[slotNo]:addInputEvent("Mouse_LUp", "HandleEventLUp_Equipment_All_AvatarShowToggle(" .. slotNo .. ")")
        if slotNo <= CppEnums.EquipSlotNo.avatarUnderWear or CppEnums.EquipSlotNo.avatarAwakenWeapon == slotNo then
          self.avataSlots[slotNo]:addInputEvent("Mouse_On", "HandleEventOnOut_Equipment_All_CostumeAccToolTip( true, 0, " .. slotNo .. " )")
          self.avataSlots[slotNo]:addInputEvent("Mouse_Out", "HandleEventOnOut_Equipment_All_CostumeAccToolTip( false, 0, " .. slotNo .. " )")
        else
          self.avataSlots[slotNo]:addInputEvent("Mouse_On", "HandleEventOnOut_Equipment_All_CostumeAccToolTip( true, 1, " .. slotNo .. " )")
          self.avataSlots[slotNo]:addInputEvent("Mouse_Out", "HandleEventOnOut_Equipment_All_CostumeAccToolTip( false, 1, " .. slotNo .. " )")
        end
        if CppEnums.EquipSlotNo.avatarAwakenWeapon == slotNo then
          if __eClassType_ShyWaman == classType then
            self.avataSlots[slotNo]:SetShow(false)
          else
            self.avataSlots[slotNo]:SetShow(self._awakenWeaponContentsOpen)
          end
        end
      end
    end
  end
  if __eClassType_ShyWaman == classType or false == self._awakenWeaponContentsOpen then
    local underwearSlot = CppEnums.EquipSlotNo.avatarUnderWear
    local spanX = self.slotBGs[CppEnums.EquipSlotNo.faceDecoration2]:GetSpanSize().x
    local spanY = self.slotBGs[underwearSlot]:GetSpanSize().y
    if nil ~= self.slotBGs[underwearSlot] then
      self.slotBGs[underwearSlot]:SetSpanSize(spanX, spanY)
      self.slotBGs[underwearSlot]:ComputePos()
    end
    if nil ~= self.slots[underwearSlot] then
      self.slots[underwearSlot].icon:SetSpanSize(spanX, spanY)
      self.slots[underwearSlot].icon:ComputePos()
    end
    if nil ~= self.avataSlots[underwearSlot] then
      local slotIcon = self.slots[underwearSlot].icon
      self.avataSlots[underwearSlot]:SetPosX(slotIcon:GetPosX() + slotIcon:GetSizeX() - 15)
      self.avataSlots[underwearSlot]:SetPosY(slotIcon:GetPosY() + slotIcon:GetSizeY() - 15)
    end
  end
end
function PaGlobal_Equipment_All:setData()
  self._isKR2ContentsEnable = isGameTypeKR2()
  self._isAlchemyStoneCheck = ToClient_getGameUIManagerWrapper():getLuaCacheDataListBool(__eAlchemyStone)
  self._awakenWeapon = {
    [__eClassType_Warrior] = ToClient_IsContentsGroupOpen("901"),
    [__eClassType_ElfRanger] = ToClient_IsContentsGroupOpen("902"),
    [__eClassType_Sorcerer] = ToClient_IsContentsGroupOpen("903"),
    [__eClassType_Giant] = ToClient_IsContentsGroupOpen("904"),
    [__eClassType_Tamer] = ToClient_IsContentsGroupOpen("905"),
    [__eClassType_BladeMaster] = ToClient_IsContentsGroupOpen("906"),
    [__eClassType_BladeMasterWoman] = ToClient_IsContentsGroupOpen("907"),
    [__eClassType_Valkyrie] = ToClient_IsContentsGroupOpen("908"),
    [__eClassType_WizardMan] = ToClient_IsContentsGroupOpen("909"),
    [__eClassType_WizardWoman] = ToClient_IsContentsGroupOpen("910"),
    [__eClassType_NinjaMan] = ToClient_IsContentsGroupOpen("911"),
    [__eClassType_Kunoichi] = ToClient_IsContentsGroupOpen("912"),
    [__eClassType_DarkElf] = ToClient_IsContentsGroupOpen("913"),
    [__eClassType_Combattant] = ToClient_IsContentsGroupOpen("914"),
    [__eClassType_Mystic] = ToClient_IsContentsGroupOpen("918"),
    [__eClassType_Lhan] = ToClient_IsContentsGroupOpen("916"),
    [__eClassType_RangerMan] = ToClient_IsContentsGroupOpen("942"),
    [__eClassType_ShyWaman] = ToClient_IsContentsGroupOpen("1366"),
    [__eClassType_Guardian] = ToClient_IsContentsGroupOpen("1317"),
    [__eClassType_Hashashin] = ToClient_IsContentsGroupOpen("1136")
  }
  local classType = getSelfPlayer():getClassType()
  self._awakenWeaponContentsOpen = self._awakenWeapon[classType]
  self._ui.check_popup:SetShow(_ContentsGroup_PopUp)
  self._ui.txt_attackText:SetEnableArea(0, 0, self._ui.txt_attackText:GetTextSizeX() + 30, self._ui.txt_attackText:GetSizeY())
  self._ui.txt_defenceText:SetEnableArea(0, 0, self._ui.txt_defenceText:GetTextSizeX() + 30, self._ui.txt_defenceText:GetSizeY())
  self._ui.txt_awakenText:SetEnableArea(0, 0, self._ui.txt_awakenText:GetTextSizeX() + 30, self._ui.txt_awakenText:GetSizeY())
  self._ui.txt_shyStatText:SetEnableArea(0, 0, self._ui.txt_shyStatText:GetTextSizeX() + 30, self._ui.txt_shyStatText:GetSizeY())
  if false == ToClient_isAdultUser() then
    self._ui.check_underwear:SetShow(false)
  else
    self._ui.check_underwear:SetShow(not self._isKR2ContentsEnable)
  end
  self._ui.btn_petList:SetShow(true)
  self._ui.check_camouflage:SetShow(true)
  self._ui.check_helmInvisual:SetShow(true)
  self._ui.check_helmOpen:SetShow(true)
  self._ui.check_cloak:SetShow(true)
  getSelfPlayer():get():setUnderwearModeInhouse(false)
  getSelfPlayer():get():setSwimmingSuitMode(false)
  self._ui.check_underwear:SetCheck(false)
  self._ui.check_camouflage:SetCheck(Toclient_setShowNameWhenCamouflage())
  selfPlayerShowHelmet(ToClient_IsShowHelm())
  selfPlayerShowBattleHelmet(ToClient_IsShowBattleHelm())
  self._ui.check_helmInvisual:SetCheck(not ToClient_IsShowHelm())
  self._ui.check_helmOpen:SetCheck(ToClient_IsShowBattleHelm())
  self._ui.check_cloak:SetCheck(not ToClient_IsShowCloak())
  PaGlobal_Equipment_All:updateHelmIcon()
  self._ui.check_alchemyStone:SetCheck(self._isAlchemyStoneCheck)
  local initSucceed = PaGlobal_EquipmentTooltip:initWithIcon(self._ui.btn_setEffect)
  self._ui.btn_setEffect:SetShow(initSucceed)
  self._ui.btn_setEffect:SetIgnore(not initSucceed)
  initSucceed = PaGlobalFunc_CrystalToolTip_InitWithIcon(self._ui.btn_equipCrystal)
  self._ui.btn_equipCrystal:SetShow(initSucceed)
  self._ui.btn_equipCrystal:SetIgnore(not initSucceed)
  self._ui.txt_blankSlotTooltip:SetColor(Defines.Color.C_FFFFFFFF)
  self._ui.txt_blankSlotTooltip:SetAlpha(1)
  self._ui.txt_blankSlotTooltip:SetFontColor(Defines.Color.C_FFC4BEBE)
  self._ui.txt_blankSlotTooltip:SetTextHorizonCenter()
  self._ui.txt_blankSlotTooltip:SetShow(false)
  self._ui.txt_blankSlotTooltip:SetIgnore(true)
  PaGlobalFunc_Equipment_All_OnScreenResize()
end
function PaGlobal_Equipment_All:registerEventHandler()
  if nil == Panel_Window_Equipment_All then
    return
  end
  self._ui.check_popup:addInputEvent("Mouse_LUp", "HandleEventLUp_Equipment_All_CheckPopupUI()")
  self._ui.check_popup:addInputEvent("Mouse_On", "HandleEventOnOut_Equipment_All_PopupUITooltip(true)")
  self._ui.check_popup:addInputEvent("Mouse_Out", "HandleEventOnOut_Equipment_All_PopupUITooltip(false)")
  if true == _ContentsGroup_SeasonContents then
    self._ui.stc_seasonBannerPass:addInputEvent("Mouse_LUp", "PaGlobal_BlackspiritPass_Open()")
    self._ui.stc_seasonBannerPass:addInputEvent("Mouse_On", "HandleEventOnOut_Equipment_All_BannerTooltip(true," .. self._bannerType.SEASONPASS .. ")")
    self._ui.stc_seasonBannerPass:addInputEvent("Mouse_Out", "HandleEventOnOut_Equipment_All_BannerTooltip(false," .. self._bannerType.SEASONPASS .. ")")
  end
  if true == _ContentsGroup_NewUI_TotalReward_All then
    self._ui.stc_seasonBannerReward:addInputEvent("Mouse_LUp", "PaGlobal_TotalReward_All_Open()")
    self._ui.stc_seasonBannerReward:addInputEvent("Mouse_On", "HandleEventOnOut_Equipment_All_BannerTooltip(true," .. self._bannerType.TOTALREWARD .. ")")
    self._ui.stc_seasonBannerReward:addInputEvent("Mouse_Out", "HandleEventOnOut_Equipment_All_BannerTooltip(false," .. self._bannerType.TOTALREWARD .. ")")
  end
  self._ui.btn_question:addInputEvent("Mouse_LUp", "Panel_WebHelper_ShowToggle( \"PanelWindowEquipment\" )")
  PaGlobal_Util_RegistHelpTooltipEvent(self._ui.btn_question, "\"PanelWindowEquipment\"")
  self._ui.btn_close:addInputEvent("Mouse_LUp", "PaGlobalFunc_Equipment_All_Close(true)")
  self._ui.txt_attackText:addInputEvent("Mouse_On", "HandleEventOnOut_Equipment_All_StatTooltip(true, 0)")
  self._ui.txt_attackText:addInputEvent("Mouse_Out", "HandleEventOnOut_Equipment_All_StatTooltip(false)")
  self._ui.txt_defenceText:addInputEvent("Mouse_On", "HandleEventOnOut_Equipment_All_StatTooltip(true, 1)")
  self._ui.txt_defenceText:addInputEvent("Mouse_Out", "HandleEventOnOut_Equipment_All_StatTooltip(false)")
  self._ui.txt_awakenText:addInputEvent("Mouse_On", "HandleEventOnOut_Equipment_All_StatTooltip(true, 2)")
  self._ui.txt_awakenText:addInputEvent("Mouse_Out", "HandleEventOnOut_Equipment_All_StatTooltip(false)")
  self._ui.txt_shyStatText:addInputEvent("Mouse_On", "HandleEventOnOut_Equipment_All_StatTooltip(true, 3)")
  self._ui.txt_shyStatText:addInputEvent("Mouse_Out", "HandleEventOnOut_Equipment_All_StatTooltip(false)")
  self._ui.btn_servantInven:addInputEvent("Mouse_On", "HandleEventOnOut_Equipment_All_ToggleButtonToolTip( true, 0 )")
  self._ui.btn_servantInven:addInputEvent("Mouse_Out", "HandleEventOnOut_Equipment_All_ToggleButtonToolTip( false, 0 )")
  self._ui.btn_servantInven:addInputEvent("Mouse_LUp", "HandleEventLUp_Equipment_All_ServantInventoryOpen()")
  self._ui.check_camouflage:addInputEvent("Mouse_On", "HandleEventOnOut_Equipment_All_ToggleButtonToolTip( true, 1 )")
  self._ui.check_camouflage:addInputEvent("Mouse_Out", "HandleEventOnOut_Equipment_All_ToggleButtonToolTip( false, 1 )")
  self._ui.check_camouflage:addInputEvent("Mouse_LUp", "HandleEventLUp_Equipment_All_ShowNameWhenCamouflage()")
  self._ui.check_underwear:addInputEvent("Mouse_On", "HandleEventOnOut_Equipment_All_ToggleButtonToolTip( true, 2 )")
  self._ui.check_underwear:addInputEvent("Mouse_Out", "HandleEventOnOut_Equipment_All_ToggleButtonToolTip( false, 2 )")
  self._ui.check_underwear:addInputEvent("Mouse_LUp", "HandleEventLUp_Equipment_All_ShowUnderWear()")
  self._ui.btn_petList:addInputEvent("Mouse_On", "HandleEventOnOut_Equipment_All_ToggleButtonToolTip( true, 3 )")
  self._ui.btn_petList:addInputEvent("Mouse_Out", "HandleEventOnOut_Equipment_All_ToggleButtonToolTip( false, 3 )")
  if true == _ContentsGroup_NewUI_Pet_All then
    self._ui.btn_petList:addInputEvent("Mouse_LUp", "PaGlobal_PetList_Toggle_All()")
  else
    self._ui.btn_petList:addInputEvent("Mouse_LUp", "FGlobal_PetListNew_Toggle()")
  end
  self._ui.check_helmInvisual:addInputEvent("Mouse_On", "HandleEventOnOut_Equipment_All_ToggleButtonToolTip( true, 4 )")
  self._ui.check_helmInvisual:addInputEvent("Mouse_Out", "HandleEventOnOut_Equipment_All_ToggleButtonToolTip( false, 4 )")
  self._ui.check_helmInvisual:addInputEvent("Mouse_LUp", "HandleEventLUp_Equipment_All_HelmInvisual()")
  self._ui.check_helmOpen:addInputEvent("Mouse_On", "HandleEventOnOut_Equipment_All_ToggleButtonToolTip( true, 5 )")
  self._ui.check_helmOpen:addInputEvent("Mouse_Out", "HandleEventOnOut_Equipment_All_ToggleButtonToolTip( false, 5 )")
  self._ui.check_helmOpen:addInputEvent("Mouse_LUp", "HandleEventLUp_Equipment_All_HelmOpen()")
  self._ui.check_cloak:addInputEvent("Mouse_On", "HandleEventOnOut_Equipment_All_ToggleButtonToolTip( true, 6 )")
  self._ui.check_cloak:addInputEvent("Mouse_Out", "HandleEventOnOut_Equipment_All_ToggleButtonToolTip( false, 6 )")
  self._ui.check_cloak:addInputEvent("Mouse_LUp", "HandleEventLUp_Equipment_All_ShowCloak()")
  self._ui.check_alchemyStone:addInputEvent("Mouse_On", "HandleEventOnOut_Equipment_All_AlchemyStoneToolTip(true)")
  self._ui.check_alchemyStone:addInputEvent("Mouse_Out", "HandleEventOnOut_Equipment_All_AlchemyStoneToolTip(false)")
  self._ui.check_alchemyStone:addInputEvent("Mouse_LUp", "HandleEventLUp_Equipment_All_AlchemyStoneCheckEvent()")
  Panel_Window_Equipment_All:RegisterShowEventFunc(true, "PaGlobalFunc_Equipment_All_ShowAni()")
  Panel_Window_Equipment_All:RegisterShowEventFunc(false, "PaGlobalFunc_Equipment_All_HideAni()")
  registerEvent("onScreenResize", "PaGlobalFunc_Equipment_All_OnScreenResize")
  registerEvent("EventEquipmentUpdate", "PaGlobalFunc_Equipment_All_UpdateSlotData")
  registerEvent("EventEquipItem", "FromClient_Equipment_All_EventEquipItem")
  registerEvent("EventPCEquipSetShow", "Equipment_SetShow")
  registerEvent("FromClient_UpdateFamilySkill", "PaGlobalFunc_Equipment_All_UpdateSlotData")
  registerEvent("FromClient_FamilySpeicalInfoChange", "FromClient_Equipment_All_FamilySpeicalInfoChange")
  registerEvent("FromClient_CharacterSpeicalInfoChange", "FromClient_Equipment_All_CharacterSpeicalInfoChange")
  registerEvent("FromClient_ChangeUnderwearModeInHouse", "FromClient_Equipment_All_ChangeUnderwearMode")
  registerEvent("FromClient_ChangeSwimmingSuitShowMode", "FromClient_Equipment_All_ChangeSwimmingSuitMode")
end
function PaGlobal_Equipment_All:validate()
  if nil == Panel_Window_Equipment_All then
    return
  end
  self._ui.txt_titleBG:isValidate()
  self._ui.check_popup:isValidate()
  self._ui.btn_question:isValidate()
  self._ui.btn_close:isValidate()
  self._ui.stc_circle:isValidate()
  self._ui.stc_abilityArea:isValidate()
  self._ui.txt_attackText:isValidate()
  self._ui.txt_attackValue:isValidate()
  self._ui.txt_defenceText:isValidate()
  self._ui.txt_defenceValue:isValidate()
  self._ui.txt_awakenText:isValidate()
  self._ui.txt_awakenValue:isValidate()
  self._ui.txt_shyStatText:isValidate()
  self._ui.txt_shyStatValue:isValidate()
  self._ui.stc_bottomButtonArea:isValidate()
  self._ui.btn_servantInven:isValidate()
  self._ui.check_camouflage:isValidate()
  self._ui.check_underwear:isValidate()
  self._ui.btn_petList:isValidate()
  self._ui.check_helmInvisual:isValidate()
  self._ui.check_helmOpen:isValidate()
  self._ui.check_cloak:isValidate()
  self._ui.btn_setEffect:isValidate()
  self._ui.btn_equipCrystal:isValidate()
  self._ui.check_alchemyStone:isValidate()
  self._ui.txt_alchemyStoneQuickKey:isValidate()
  self._ui.tooltipTemplate:isValidate()
  self._ui.txt_blankSlotTooltip:isValidate()
  self._ui.stc_seasonBannerPass:isValidate()
  self._ui.stc_seasonBannerReward:isValidate()
end
