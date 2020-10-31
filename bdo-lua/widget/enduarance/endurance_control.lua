local awakenWeapon = {
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
function FromClient_EnduranceUpdate(enduranceType)
  if false == _ContentsGroup_NewUI_Servant_All then
    if nil ~= Panel_Window_StableList and true == Panel_Window_StableList:GetShow() or nil ~= Panel_Window_WharfList and true == Panel_Window_WharfList:GetShow() or nil ~= Panel_Window_Repair and true == Panel_Window_Repair:GetShow() or nil ~= Panel_Dialog_Repair_Function_All and true == Panel_Dialog_Repair_Function_All:GetShow() then
      if true == _ContentsGroup_NewUI_Camp_All then
        if false == PaGlobalFunc_Camp_All_GetIsCamping() then
          return
        end
      elseif nil ~= PaGlobal_Camp and false == PaGlobal_Camp:getIsCamping() then
        return
      end
    end
  elseif nil ~= Panel_Dialog_ServantList_All and true == Panel_Dialog_ServantList_All:GetShow() then
    if true == _ContentsGroup_NewUI_Camp_All then
      if false == PaGlobalFunc_Camp_All_GetIsCamping() then
        return
      end
    elseif nil ~= PaGlobal_Camp and false == PaGlobal_Camp:getIsCamping() then
      return
    end
  end
  local temporaryWrapper = getTemporaryInformationWrapper()
  local isNeedCheckEquip = false
  local self = PaGlobalPlayerEnduranceList
  if enduranceType == CppEnums.EnduranceType.eEnduranceType_Player then
    self = PaGlobalPlayerEnduranceList
    isNeedCheckEquip = true
  elseif enduranceType == CppEnums.EnduranceType.eEnduranceType_Horse then
    self = PaGlobalHorseEnduranceList
    local servantInfoWrapper = temporaryWrapper:getUnsealVehicle(CppEnums.ServantType.Type_Vehicle)
    if nil ~= servantInfoWrapper and false == PaGlobalFunc_Util_IsCarriage(servantInfoWrapper:getVehicleType()) then
      isNeedCheckEquip = true
    end
  elseif enduranceType == CppEnums.EnduranceType.eEnduranceType_Carriage then
    self = PaGlobalCarriageEnduranceList
    local servantInfoWrapper = temporaryWrapper:getUnsealVehicle(CppEnums.ServantType.Type_Vehicle)
    if nil ~= servantInfoWrapper and true == PaGlobalFunc_Util_IsCarriage(servantInfoWrapper:getVehicleType()) then
      isNeedCheckEquip = true
    end
  elseif enduranceType == CppEnums.EnduranceType.eEnduranceType_Ship then
    self = PaGlobalShipEnduranceList
    local servantInfoWrapper = temporaryWrapper:getUnsealVehicle(CppEnums.ServantType.Type_Ship)
    if nil ~= servantInfoWrapper and false == PaGlobalFunc_Util_IsBigShip(servantInfoWrapper:getVehicleType()) then
      isNeedCheckEquip = true
    end
  elseif enduranceType == CppEnums.EnduranceType.eEnduranceType_SailShip then
    self = PaGlobalSailShipEnduranceList
    local servantInfoWrapper = temporaryWrapper:getUnsealVehicle(CppEnums.ServantType.Type_Ship)
    if nil ~= servantInfoWrapper and true == PaGlobalFunc_Util_IsBigShip(servantInfoWrapper:getVehicleType()) then
      isNeedCheckEquip = true
    end
  end
  if not self:checkInit() then
    return
  end
  local isShow = false
  local isBrokenSubTool = false
  local isCantRepair = false
  local isPcRoomEquip = false
  local isUnusableBadEquip = false
  local enduranceCheck = 0
  if true == isNeedCheckEquip then
    for index = 0, CppEnums.EquipSlotNo.equipSlotNoCount - 1 do
      local enduranceLevel = -1
      isPcRoomEquip = false
      isUnusableBadEquip = false
      if enduranceType == CppEnums.EnduranceType.eEnduranceType_Player then
        enduranceLevel = ToClient_GetPlayerEquipmentEnduranceLevel(index)
        local equipItemWrapper = ToClient_getEquipmentItem(index)
        if nil ~= equipItemWrapper then
          if equipItemWrapper:needCheckPcRoom() then
            isPcRoomEquip = true
          end
          if equipItemWrapper:needCheckBad() then
            isUnusableBadEquip = true
          end
        end
        if false == isCantRepair then
          isCantRepair = ToClient_IsCantRepairPlayerEquipment(index)
        end
        if CppEnums.EquipSlotNo.subTool == index then
          isBrokenSubTool = (enduranceLevel == 0 or enduranceLevel == 1) and true == equipItemWrapper:checkToRepairItem()
        end
      elseif enduranceType == CppEnums.EnduranceType.eEnduranceType_Horse then
        enduranceLevel = ToClient_GetHorseEquipmentEnduranceLevel(index)
      elseif enduranceType == CppEnums.EnduranceType.eEnduranceType_Carriage then
        enduranceLevel = ToClient_GetCarriageEquipmentEnduranceLevel(index)
      elseif enduranceType == CppEnums.EnduranceType.eEnduranceType_Ship then
        enduranceLevel = ToClient_GetShipEquipmentEnduranceLevel(index)
      elseif enduranceType == CppEnums.EnduranceType.eEnduranceType_SailShip then
        enduranceLevel = ToClient_GetShipEquipmentEnduranceLevel(index)
      end
      if nil ~= self.enduranceInfo[index].control then
        self.enduranceInfo[index].control:ResetVertexAni()
        if enduranceLevel < 0 then
          self.enduranceInfo[index].itemEquiped = false
          self.enduranceInfo[index].color = Defines.Color.C_FF000000
          self.enduranceInfo[index].isBroken = false
        else
          self.enduranceInfo[index].itemEquiped = true
          if 1 < enduranceLevel then
            self.enduranceInfo[index].color = Defines.Color.C_FF444444
            self.enduranceInfo[index].isBroken = false
            if isPcRoomEquip or isUnusableBadEquip then
              Panel_Endurance_updateVertexAniRun(self.enduranceInfo[index].control, index, "Red")
              isShow = true
            end
          else
            if enduranceType == CppEnums.EnduranceType.eEnduranceType_Player then
              if enduranceLevel == 0 then
                Panel_Endurance_updateVertexAniRun(self.enduranceInfo[index].control, index, "Red")
              elseif enduranceLevel == 1 then
                if isPcRoomEquip or isUnusableBadEquip then
                  Panel_Endurance_updateVertexAniRun(self.enduranceInfo[index].control, index, "Red")
                else
                  Panel_Endurance_updateVertexAniRun(self.enduranceInfo[index].control, index, "Orange")
                end
              end
            elseif enduranceType == CppEnums.EnduranceType.eEnduranceType_Horse then
              if 0 == enduranceLevel then
                if 3 == index then
                  self.enduranceInfo[index].control:SetVertexAniRun("Ani_Color_Horse_Body_Red", true)
                elseif 4 == index then
                  self.enduranceInfo[index].control:SetVertexAniRun("Ani_Color_Horse_Saddle_Red", true)
                elseif 5 == index then
                  self.enduranceInfo[index].control:SetVertexAniRun("Ani_Color_Horse_RiderFoot_Red", true)
                elseif 6 == index then
                  self.enduranceInfo[index].control:SetVertexAniRun("Ani_Color_Horse_Head_Red", true)
                elseif 12 == index then
                  self.enduranceInfo[index].control:SetVertexAniRun("Ani_Color_Horse_HorseFoot_Red", true)
                end
              elseif 1 == enduranceLevel then
                if 3 == index then
                  self.enduranceInfo[index].control:SetVertexAniRun("Ani_Color_Horse_Body_Orange", true)
                elseif 4 == index then
                  self.enduranceInfo[index].control:SetVertexAniRun("Ani_Color_Horse_Saddle_Orange", true)
                elseif 5 == index then
                  self.enduranceInfo[index].control:SetVertexAniRun("Ani_Color_Horse_RiderFoot_Orange", true)
                elseif 6 == index then
                  self.enduranceInfo[index].control:SetVertexAniRun("Ani_Color_Horse_Head_Orange", true)
                elseif 12 == index then
                  self.enduranceInfo[index].control:SetVertexAniRun("Ani_Color_Horse_HorseFoot_Orange", true)
                end
              end
            elseif enduranceType == CppEnums.EnduranceType.eEnduranceType_Carriage then
              if 0 == enduranceLevel then
                if 4 == index then
                  self.enduranceInfo[index].control:SetVertexAniRun("Ani_Color_Carriage_Wheel_Red", true)
                elseif 5 == index then
                  self.enduranceInfo[index].control:SetVertexAniRun("Ani_Color_Carriage_Flag_Red", true)
                elseif 6 == index then
                  self.enduranceInfo[index].control:SetVertexAniRun("Ani_Color_Carriage_Curtain_Red", true)
                elseif 13 == index then
                  self.enduranceInfo[index].control:SetVertexAniRun("Ani_Color_Carriage_Lamp_Red", true)
                elseif 25 == index then
                  self.enduranceInfo[index].control:SetVertexAniRun("Ani_Color_Carriage_Cover_Red", true)
                end
              elseif 1 == enduranceLevel then
                if 4 == index then
                  self.enduranceInfo[index].control:SetVertexAniRun("Ani_Color_Carriage_Wheel_Orange", true)
                elseif 5 == index then
                  self.enduranceInfo[index].control:SetVertexAniRun("Ani_Color_Carriage_Flag_Orange", true)
                elseif 6 == index then
                  self.enduranceInfo[index].control:SetVertexAniRun("Ani_Color_Carriage_Curtain_Orange", true)
                elseif 13 == index then
                  self.enduranceInfo[index].control:SetVertexAniRun("Ani_Color_Carriage_Lamp_Orange", true)
                elseif 25 == index then
                  self.enduranceInfo[index].control:SetVertexAniRun("Ani_Color_Carriage_Cover_Orange", true)
                end
              end
            elseif enduranceType == CppEnums.EnduranceType.eEnduranceType_Ship then
              if 0 == enduranceLevel then
                if 3 == index then
                  self.enduranceInfo[index].control:SetVertexAniRun("Ani_Color_Ship_Main_Red", true)
                elseif 4 == index then
                  self.enduranceInfo[index].control:SetVertexAniRun("Ani_Color_Ship_Head_Red", true)
                elseif 5 == index then
                  self.enduranceInfo[index].control:SetVertexAniRun("Ani_Color_Ship_Goods_Red", true)
                elseif 25 == index then
                  self.enduranceInfo[index].control:SetVertexAniRun("Ani_Color_Ship_Deco_Red", true)
                end
              elseif 1 == enduranceLevel then
                if 3 == index then
                  self.enduranceInfo[index].control:SetVertexAniRun("Ani_Color_Ship_Main_Orange", true)
                elseif 4 == index then
                  self.enduranceInfo[index].control:SetVertexAniRun("Ani_Color_Ship_Head_Orange", true)
                elseif 5 == index then
                  self.enduranceInfo[index].control:SetVertexAniRun("Ani_Color_Ship_Goods_Orange", true)
                elseif 25 == index then
                  self.enduranceInfo[index].control:SetVertexAniRun("Ani_Color_Ship_Deco_Orange", true)
                end
              end
            elseif enduranceType == CppEnums.EnduranceType.eEnduranceType_SailShip then
              if 0 == enduranceLevel then
                if 3 == index then
                  self.enduranceInfo[index].control:SetVertexAniRun("Ani_Color_Ship_Goods_Red", true)
                elseif 4 == index then
                  self.enduranceInfo[index].control:SetVertexAniRun("Ani_Color_Ship_Head_Red", true)
                elseif 5 == index then
                  self.enduranceInfo[index].control:SetVertexAniRun("Ani_Color_Ship_Deco_Red", true)
                elseif 25 == index then
                  self.enduranceInfo[index].control:SetVertexAniRun("Ani_Color_Ship_Main_Red", true)
                end
              elseif 1 == enduranceLevel then
                if 3 == index then
                  self.enduranceInfo[index].control:SetVertexAniRun("Ani_Color_Ship_Goods_Orange", true)
                elseif 4 == index then
                  self.enduranceInfo[index].control:SetVertexAniRun("Ani_Color_Ship_Head_Orange", true)
                elseif 5 == index then
                  self.enduranceInfo[index].control:SetVertexAniRun("Ani_Color_Ship_Deco_Orange", true)
                elseif 25 == index then
                  self.enduranceInfo[index].control:SetVertexAniRun("Ani_Color_Ship_Main_Orange", true)
                end
              end
            end
            self.enduranceInfo[index].isBroken = true
            isShow = true
            enduranceCheck = enduranceCheck + 1
          end
        end
        self.enduranceInfo[index].control:SetColor(self.enduranceInfo[index].color)
      end
    end
  end
  if false == self.isBrokenSubTool and true == isBrokenSubTool and false == isShow then
    if enduranceType == CppEnums.EnduranceType.eEnduranceType_Player then
      PaGlobalFunc_Widget_Alert_Show_EndurancePc()
    elseif enduranceType == CppEnums.EnduranceType.eEnduranceType_Horse then
      PaGlobalFunc_Widget_Alert_Show_EnduranceHorse()
    elseif enduranceType == CppEnums.EnduranceType.eEnduranceType_Carriage then
      PaGlobalFunc_Widget_Alert_Show_EnduranceCarriage()
    elseif enduranceType == CppEnums.EnduranceType.eEnduranceType_Ship then
      PaGlobalFunc_Widget_Alert_Show_EnduranceShip()
    elseif enduranceType == CppEnums.EnduranceType.eEnduranceType_SailShip then
      PaGlobalFunc_Widget_Alert_Show_EnduranceShip()
    end
  end
  self.isBrokenSubTool = isBrokenSubTool
  if isShow then
    if true == _ContentsGroup_RemasterUI_Main_Alert and (false == self.panel:GetShow() or false == self.effectBG:IsEnable()) and false == self.isBrokenSubTool then
      if enduranceType == CppEnums.EnduranceType.eEnduranceType_Player then
        PaGlobalFunc_Widget_Alert_Show_EndurancePc()
      elseif enduranceType == CppEnums.EnduranceType.eEnduranceType_Horse then
        PaGlobalFunc_Widget_Alert_Show_EnduranceHorse()
      elseif enduranceType == CppEnums.EnduranceType.eEnduranceType_Carriage then
        PaGlobalFunc_Widget_Alert_Show_EnduranceCarriage()
      elseif enduranceType == CppEnums.EnduranceType.eEnduranceType_Ship then
        PaGlobalFunc_Widget_Alert_Show_EnduranceShip()
      elseif enduranceType == CppEnums.EnduranceType.eEnduranceType_SailShip then
        PaGlobalFunc_Widget_Alert_Show_EnduranceShip()
      end
    end
    for index = 0, CppEnums.EquipSlotNo.equipSlotNoCount - 1 do
      if nil ~= self.enduranceInfo[index].control then
        self.enduranceInfo[index].control:SetShow(true)
      end
    end
    if enduranceType == CppEnums.EnduranceType.eEnduranceType_Player then
      self.enduranceInfo[29].control:SetShow(awakenWeapon[classType])
    end
    self.effectBG:EraseAllEffect()
    if false == self.isEffectSound then
      self.isEffectSound = true
      audioPostEvent_SystemUi(8, 6)
    end
    if (4 == enduranceCheck or 1 == enduranceCheck) and true == isCantRepair then
      self.noticeEndurance:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_ENDURANCE_NOTICEENDURACNE1"))
    elseif true == isCantRepair then
      self.noticeEndurance:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_ENDURANCE_NOTICEENDURACNE2"))
    else
      self.noticeEndurance:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_ENDURANCE_NOTICEENDURACNE3"))
    end
    self.panel:SetShow(true)
    self.effectBG:SetEnable(true)
  else
    for index = 0, CppEnums.EquipSlotNo.equipSlotNoCount - 1 do
      if nil ~= self.enduranceInfo[index].control then
        self.enduranceInfo[index].control:SetShow(false)
        self.enduranceInfo[index].control:ResetVertexAni()
      end
    end
    self.isEffectSound = false
    self.effectBG:EraseAllEffect()
    self.noticeEndurance:SetShow(false)
    self.effectBG:SetEnable(false)
    if enduranceType == CppEnums.EnduranceType.eEnduranceType_Player then
    else
      self.panel:SetShow(false)
    end
  end
  local enduranceList = {
    PaGlobalPlayerEnduranceList,
    PaGlobalHorseEnduranceList,
    PaGlobalCarriageEnduranceList,
    PaGlobalShipEnduranceList,
    PaGlobalSailShipEnduranceList
  }
  local isRepairShow = false
  for key, value in pairs(enduranceList) do
    if value.effectBG:IsEnable() and false == isRepairShow then
      value.repair_AutoNavi:SetShow(true)
      value.repair_Navi:SetShow(true)
      isRepairShow = true
      if true == _ContentsGroup_RenewUI_Main then
        value.repair_AutoNavi:SetShow(false)
        value.repair_Navi:SetShow(false)
      end
    else
      value.repair_AutoNavi:SetShow(false)
      value.repair_Navi:SetShow(false)
    end
  end
  FGlobal_Inventory_WeightCheck_Reposition()
end
function Panel_Endurance_updateVertexAniRun(control, idx, color)
  if 0 == idx then
    control:SetVertexAniRun("Ani_Color_WeaponR_" .. color, true)
  elseif 1 == idx then
    control:SetVertexAniRun("Ani_Color_WeaponL_" .. color, true)
  elseif 3 == idx then
    control:SetVertexAniRun("Ani_Color_Armor_" .. color, true)
  elseif 4 == idx then
    control:SetVertexAniRun("Ani_Color_Glove_" .. color, true)
  elseif 5 == idx then
    control:SetVertexAniRun("Ani_Color_Boots_" .. color, true)
  elseif 6 == idx then
    control:SetVertexAniRun("Ani_Color_Helm_" .. color, true)
  elseif 7 == idx then
    control:SetVertexAniRun("Ani_Color_Necklace_" .. color, true)
  elseif 8 == idx then
    control:SetVertexAniRun("Ani_Color_Ring1_" .. color, true)
  elseif 9 == idx then
    control:SetVertexAniRun("Ani_Color_Ring2_" .. color, true)
  elseif 10 == idx then
    control:SetVertexAniRun("Ani_Color_Earing1_" .. color, true)
  elseif 11 == idx then
    control:SetVertexAniRun("Ani_Color_Earing2_" .. color, true)
  elseif 12 == idx then
    control:SetVertexAniRun("Ani_Color_Belt_" .. color, true)
  elseif 29 == idx then
    control:SetVertexAniRun("Ani_Color_AwakenWeapon_" .. color, true)
  end
end
function FromClient_PlayerEnduranceUpdate()
  FromClient_EnduranceUpdate(CppEnums.EnduranceType.eEnduranceType_Player)
end
function FromClient_ServantEnduranceUpdate()
  FromClient_EnduranceUpdate(CppEnums.EnduranceType.eEnduranceType_Horse)
  FromClient_EnduranceUpdate(CppEnums.EnduranceType.eEnduranceType_Carriage)
  FromClient_EnduranceUpdate(CppEnums.EnduranceType.eEnduranceType_Ship)
  FromClient_EnduranceUpdate(CppEnums.EnduranceType.eEnduranceType_SailShip)
  Panel_ShipEndurance_Position()
end
function Panel_Endurance_Update()
  FromClient_PlayerEnduranceUpdate()
  FromClient_ServantEnduranceUpdate()
end
function renderModeChange_Panel_Endurance_Update(prevRenderModeList, nextRenderModeList)
  if CheckRenderModebyGameMode(nextRenderModeList) == false then
    return
  end
  Panel_Endurance_Update()
end
registerEvent("FromClient_RenderModeChangeState", "renderModeChange_Panel_Endurance_Update")
registerEvent("FromClient_luaLoadComplete", "Panel_Endurance_Update")
registerEvent("FromClient_EquipEnduranceChanged", "FromClient_PlayerEnduranceUpdate")
registerEvent("EventEquipmentUpdate", "FromClient_PlayerEnduranceUpdate")
registerEvent("FromClient_SelfPlayerTendencyChanged", "FromClient_PlayerEnduranceUpdate")
registerEvent("EventServantEquipItem", "FromClient_ServantEnduranceUpdate")
registerEvent("EventServantEquipmentUpdate", "FromClient_ServantEnduranceUpdate")
registerEvent("FromClient_ServantEquipEnduranceChanged", "FromClient_ServantEnduranceUpdate")
registerEvent("FromClient_ServantUpdate", "FromClient_ServantEnduranceUpdate")
