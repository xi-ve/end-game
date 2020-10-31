local ClassType_Valkiry = 24
local spiritClass = {
  [0] = 0,
  12,
  19,
  20,
  21,
  23,
  26,
  30,
  11,
  25
}
local fairyMainPotionData = {
  [0] = {
    502,
    513,
    514,
    517,
    518,
    519,
    524,
    525,
    528,
    529,
    530,
    538,
    551,
    552,
    553,
    554,
    555,
    17568,
    17569,
    19932,
    19933,
    19934,
    19935,
    566,
    567,
    568,
    578,
    17679,
    17684,
    580,
    583,
    18853,
    56090,
    56093,
    17681,
    17682,
    17683
  }
}
local fairySubPotionData = {
  [1] = {
    [0] = 503,
    520,
    521,
    522,
    526,
    527,
    515,
    516,
    531,
    532,
    533,
    17570,
    17571,
    17680,
    17685,
    17686,
    17687,
    17688,
    18854,
    19936,
    19937,
    19938,
    569,
    570,
    571,
    582,
    561,
    562,
    563,
    564,
    565,
    18857,
    579,
    56092,
    56091,
    56094,
    581,
    584
  },
  [2] = {
    [0] = 591,
    592,
    593,
    594,
    827,
    828,
    829,
    830,
    17707,
    17708,
    17709,
    17710,
    569,
    570,
    571,
    582,
    18857,
    579,
    56092
  },
  [3] = {
    [0] = 595,
    596,
    597,
    598,
    831,
    832,
    833,
    834,
    17711,
    17712,
    17713,
    17714,
    569,
    570,
    571,
    582,
    18857,
    579,
    56092
  }
}
function PaGlobal_FairySetting_All:initialize()
  if true == PaGlobal_FairySetting_All._initialize then
    return
  end
  self._ui.stc_TitleBG = UI.getChildControl(Panel_Window_FairySetting_All, "Static_TitleBG")
  self._ui_pc.btn_Close_pc = UI.getChildControl(self._ui.stc_TitleBG, "Button_Win_Close_PC")
  self._ui.stc_InsideBG = UI.getChildControl(Panel_Window_FairySetting_All, "Static_InsideBg")
  self._ui.stc_MainBG = UI.getChildControl(Panel_Window_FairySetting_All, "Static_SettingMainBG")
  self._ui.stc_HPItemSlotBG = UI.getChildControl(self._ui.stc_MainBG, "Static_HPItemSlotBGBig")
  self._ui.stc_QuestionMarkHP = UI.getChildControl(self._ui.stc_HPItemSlotBG, "Static_QuestionMark")
  self._ui.stc_HPItemSlot = UI.getChildControl(self._ui.stc_HPItemSlotBG, "Static_HPItemSlot")
  self._ui.txt_currentHPValue = UI.getChildControl(self._ui.stc_MainBG, "HpSlider_CurrentValue")
  self._ui.progress2_Hp = UI.getChildControl(self._ui.stc_MainBG, "Progress2_Hp")
  self._ui.slider_HP = UI.getChildControl(self._ui.stc_MainBG, "Slider_HpSlider")
  self._ui.btn_HPSLider = UI.getChildControl(self._ui.slider_HP, "Slider_Hp_Button")
  self._ui.stc_MPItemSlotBG = UI.getChildControl(self._ui.stc_MainBG, "Static_MPItemSlotBGBig")
  self._ui.stc_QuestionMarkMP = UI.getChildControl(self._ui.stc_MPItemSlotBG, "Static_QuestionMark")
  self._ui.stc_MPItemSlot = UI.getChildControl(self._ui.stc_MPItemSlotBG, "Static_MPItemSlot")
  self._ui.txt_currentMPValue = UI.getChildControl(self._ui.stc_MainBG, "MpSlider_CurrentValue")
  self._ui.progress2_Mp = UI.getChildControl(self._ui.stc_MainBG, "Progress2_Mp")
  self._ui.slider_MP = UI.getChildControl(self._ui.stc_MainBG, "Slider_MpSlider")
  self._ui.btn_MPSLider = UI.getChildControl(self._ui.slider_MP, "Slider_Mp_Button")
  self._ui.stc_DescBG = UI.getChildControl(Panel_Window_FairySetting_All, "Static_SkillListBG2")
  self._ui.txt_Desc = UI.getChildControl(self._ui.stc_DescBG, "StaticText_SkillListDesc")
  self._ui.stc_BottomButtonBG = UI.getChildControl(Panel_Window_FairySetting_All, "Static_BottomBTNGroup")
  self._ui_pc.btn_Yes_pc = UI.getChildControl(self._ui.stc_BottomButtonBG, "Button_Yes_PC")
  self._ui_pc.btn_No_pc = UI.getChildControl(self._ui.stc_BottomButtonBG, "Button_No_PC")
  self._ui.list2_Potion = UI.getChildControl(Panel_Window_FairySetting_All, "List2_PotionList")
  self._ui.txt_NoPotion = UI.getChildControl(self._ui.list2_Potion, "StaticText_NoPotion")
  self._ui.stc_BottomKeyGuide = UI.getChildControl(Panel_Window_FairySetting_All, "Static_KeyGuide_Console")
  self._ui_console.stc_KeyGuide_X = UI.getChildControl(self._ui.stc_BottomKeyGuide, "StaticText_Detail")
  self._ui_console.stc_KeyGuide_Y = UI.getChildControl(self._ui.stc_BottomKeyGuide, "StaticText_Confirm_Console")
  self._ui_console.stc_KeyGuide_A = UI.getChildControl(self._ui.stc_BottomKeyGuide, "StaticText_Select")
  self._ui_console.stc_KeyGuide_B = UI.getChildControl(self._ui.stc_BottomKeyGuide, "StaticText_Cancle")
  self._keyguide = {
    self._ui_console.stc_KeyGuide_X,
    self._ui_console.stc_KeyGuide_Y,
    self._ui_console.stc_KeyGuide_A,
    self._ui_console.stc_KeyGuide_B
  }
  self._currentFairyNoStr = nil
  self._currentHpKey = nil
  self._currentHpRate = 0
  self._currentMpKey = nil
  self._currentMpRate = 0
  self._currentTier = 0
  self._ui.txt_Desc:SetTextMode(__eTextMode_AutoWrap)
  self._ui.txt_Desc:SetText(PAGetString(Defines.StringSheet_GAME, "PANEL_FAIRY_SETTING_BOTTOM_DESC_All"))
  self._ui.txt_NoPotion:SetTextMode(__eTextMode_AutoWrap)
  self._ui.txt_NoPotion:SetText(self._ui.txt_NoPotion:GetText())
  PaGlobal_FairySetting_All:AdjustPanelSize()
  PaGlobal_FairySetting_All:SetUiSetting()
  PaGlobal_FairySetting_All:AlignKeyGuide()
  PaGlobal_FairySetting_All:registEventHandler()
  PaGlobal_FairySetting_All:validate()
  PaGlobal_FairySetting_All._initialize = true
end
function PaGlobal_FairySetting_All:AdjustPanelSize()
  if nil == Panel_Window_FairySetting_All then
    return
  end
  local originSizeY = self._ui.txt_Desc:GetSizeY()
  local textSizeY = self._ui.txt_Desc:GetTextSizeY()
  if originSizeY > textSizeY then
    return
  end
  local addSizeY = textSizeY + 10 - self._ui.stc_DescBG:GetSizeY()
  Panel_Window_FairySetting_All:SetSize(Panel_Window_FairySetting_All:GetSizeX(), Panel_Window_FairySetting_All:GetSizeY() + addSizeY)
  self._ui.stc_InsideBG:SetSize(self._ui.stc_InsideBG:GetSizeX(), self._ui.stc_InsideBG:GetSizeY() + addSizeY)
  self._ui.list2_Potion:SetSize(self._ui.list2_Potion:GetSizeX(), self._ui.list2_Potion:GetSizeY() + addSizeY)
  if _ContentsGroup_UsePadSnapping then
    self._ui.stc_DescBG:SetSize(self._ui.stc_DescBG:GetSizeX(), self._ui.stc_DescBG:GetSizeY() + addSizeY + self._ui.stc_BottomButtonBG:GetSizeY())
  else
    self._ui.stc_DescBG:SetSize(self._ui.stc_DescBG:GetSizeX(), self._ui.stc_DescBG:GetSizeY() + addSizeY)
  end
  self._ui.txt_Desc:SetSize(self._ui.txt_Desc:GetSizeX(), textSizeY)
  self._ui.txt_Desc:SetText(self._ui.txt_Desc:GetText())
  Panel_Window_FairySetting_All:ComputePosAllChild()
end
function PaGlobal_FairySetting_All:SetUiSetting()
  if nil == Panel_Window_FairySetting_All then
    return
  end
  for _, value in pairs(self._ui_pc) do
    value:SetShow(not _ContentsGroup_UsePadSnapping)
  end
  for _, value in pairs(self._ui_console) do
    value:SetShow(_ContentsGroup_UsePadSnapping)
  end
  self._ui.stc_BottomButtonBG:SetShow(not _ContentsGroup_UsePadSnapping)
  self._ui.stc_BottomKeyGuide:SetShow(_ContentsGroup_UsePadSnapping)
end
function PaGlobal_FairySetting_All:AlignKeyGuide()
  if nil == Panel_Window_FairySetting_All or false == _ContentsGroup_UsePadSnapping then
    return
  end
  PaGlobalFunc_ConsoleKeyGuide_SetAlign(self._keyguide, self._ui.stc_BottomKeyGuide, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHT)
end
function PaGlobal_FairySetting_All:registEventHandler()
  if nil == Panel_Window_FairySetting_All then
    return
  end
  self._ui_pc.btn_Close_pc:addInputEvent("Mouse_LUp", "PaGlobal_FairySetting_Close_All()")
  self._ui_pc.btn_Yes_pc:addInputEvent("Mouse_LUp", "InputMLUp_FairySetting_Request_All()")
  self._ui_pc.btn_No_pc:addInputEvent("Mouse_LUp", "PaGlobal_FairySetting_Close_All()")
  self._ui.list2_Potion:registEvent(__ePAUIList2EventType_LuaChangeContent, "PaGlobal_FairySetting_All_CreatePotionList")
  self._ui.list2_Potion:createChildContent(__ePAUIList2ElementManagerType_List)
  self._ui.slider_HP:addInputEvent("Mouse_LPress", "InputMLPress_FairySetting_UpdateHpSlider()")
  self._ui.slider_MP:addInputEvent("Mouse_LPress", "InputMLPress_FairySetting_UpdateMpSlider()")
  self._ui.slider_HP:registerPadEvent(__eConsoleUIPadEvent_DpadRight, "InputDpadLeft_FairySetting_MoveSnapToRight_All()")
  self._ui.slider_MP:registerPadEvent(__eConsoleUIPadEvent_DpadRight, "InputDpadLeft_FairySetting_MoveSnapToRight_All()")
  self._ui.btn_HPSLider:addInputEvent("Mouse_LPress", "InputMLPress_FairySetting_UpdateHpSlider()")
  self._ui.btn_MPSLider:addInputEvent("Mouse_LPress", "InputMLPress_FairySetting_UpdateMpSlider()")
  self._ui.stc_HPItemSlot:addInputEvent("Mouse_RUp", "InputMLUp_FairySetting_ClearHP_All()")
  self._ui.stc_MPItemSlot:addInputEvent("Mouse_RUp", "InputMLUp_FairySetting_ClearMP_All()")
  Panel_Window_FairySetting_All:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "InputMLUp_FairySetting_Request_All()")
end
function PaGlobal_FairySetting_All:prepareOpen(petNoStr)
  if nil == Panel_Window_FairySetting_All then
    return
  end
  if not Panel_FairyInfo_All:GetShow() then
    return
  end
  PaGlobal_FairyPanel_ALL_Close()
  if nil == petNoStr then
    return
  end
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  local classType = selfPlayer:getClassType()
  self._currentClassType = 1
  for ii = 0, #spiritClass do
    if classType == spiritClass[ii] then
      self._currentClassType = 2
    end
  end
  if ClassType_Valkiry == classType then
    self._currentClassType = 3
  end
  self._currentFairyNoStr = petNoStr
  self:Clear()
  self:SetPos()
  audioPostEvent_SystemUi(1, 40)
  _AudioPostEvent_SystemUiForXBOX(1, 40)
  self:update(true)
  PaGlobal_FairySetting_All:open()
end
function PaGlobal_FairySetting_All:open()
  if nil == Panel_Window_FairySetting_All then
    return
  end
  Panel_Window_FairySetting_All:SetShow(true)
end
function PaGlobal_FairySetting_All:prepareClose()
  if nil == Panel_Window_FairySetting_All then
    return
  end
  if false == _ContentsGroup_UsePadSnapping then
    if nil ~= self._currentMpKey then
      InputMLUp_FairySetting_ClearMP_All()
    end
    if nil ~= self._currentHpKey then
      InputMLUp_FairySetting_ClearHP_All()
    end
  else
    if nil ~= self._currentMpKey then
      InputMLUp_FairySetting_ClearMP_All()
      return
    end
    if nil ~= self._currentHpKey then
      InputMLUp_FairySetting_ClearHP_All()
      return
    end
  end
  if false == _ContentsGroup_RenewUI then
    Panel_Tooltip_Item_hideTooltip()
  else
    PaGlobalFunc_TooltipInfo_Close()
  end
  TooltipSimple_Hide()
  self._currentFairyNoStr = nil
  self._prevSnappedControl = nil
  PaGlobal_FairySetting_All:close()
end
function PaGlobal_FairySetting_All:close()
  if nil == Panel_Window_FairySetting_All then
    return
  end
  Panel_Window_FairySetting_All:SetShow(false)
end
function PaGlobal_FairySetting_All:update(updateData)
  if nil == Panel_Window_FairySetting_All then
    return
  end
  self:updatePotionSetting(updateData)
  self:updatePotionList()
end
function PaGlobal_FairySetting_All:updatePotionSetting(updateData)
  if nil == Panel_Window_FairySetting_All then
    return
  end
  if nil == self._currentFairyNoStr then
    return
  end
  local fairyNo_s64 = tonumber64(self._currentFairyNoStr)
  local settingData = ToClient_getFairySettingData(fairyNo_s64)
  if nil ~= settingData and true == updateData then
    self._currentHpKey = settingData._hpItemKey
    self._currentMpKey = settingData._mpItemKey
    self._currentHpRate = settingData._hpMinRate
    self._currentMpRate = settingData._mpMinRate
  end
  local ItemHpSSW, ItemMpSSW
  if nil ~= self._currentHpKey then
    ItemHpSSW = getItemEnchantStaticStatus(self._currentHpKey)
  end
  if nil ~= ItemHpSSW then
    self._ui.stc_HPItemSlot:ChangeTextureInfoName("Icon/" .. ItemHpSSW:getIconPath())
    self._ui.stc_HPItemSlot:SetShow(true)
    self._ui.stc_QuestionMarkHP:SetShow(false)
  else
    self._currentHpKey = nil
    self._ui.stc_HPItemSlot:SetShow(false)
    self._ui.stc_QuestionMarkHP:SetShow(true)
  end
  if nil ~= self._currentMpKey then
    ItemMpSSW = getItemEnchantStaticStatus(self._currentMpKey)
  end
  if nil ~= ItemMpSSW then
    self._ui.stc_MPItemSlot:ChangeTextureInfoName("Icon/" .. ItemMpSSW:getIconPath())
    self._ui.stc_MPItemSlot:SetShow(true)
    self._ui.stc_QuestionMarkMP:SetShow(false)
  else
    self._currentMpKey = nil
    self._ui.stc_MPItemSlot:SetShow(false)
    self._ui.stc_QuestionMarkMP:SetShow(true)
  end
  local hpValue = 0
  local mpValue = 0
  if nil == self._currentHpRate then
    hpValue = 0
    self._currentHpRate = 0
  end
  if nil == self._currentMpRate then
    mpValue = 0
    self._currentMpRate = 0
  end
  if self._currentHpRate >= 0 and self._currentHpRate <= 100 then
    hpValue = self._currentHpRate .. "%"
    self:SetHpSlider(self._currentHpRate)
  end
  if 0 == self._currentHpRate then
    hpValue = PAGetString(Defines.StringSheet_GAME, "LUA_FAIRYSETTING_NO_USE")
    self:SetHpSlider(0)
  end
  if 100 == self._currentHpRate then
    hpValue = PAGetString(Defines.StringSheet_GAME, "LUA_FAIRYSETTING_ONLY_USE")
  end
  if self._currentMpRate >= 0 and self._currentMpRate <= 100 then
    mpValue = self._currentMpRate .. "%"
    self:SetMpSlider(self._currentMpRate)
  end
  if 0 == self._currentMpRate then
    mpValue = PAGetString(Defines.StringSheet_GAME, "LUA_FAIRYSETTING_NO_USE")
    self:SetMpSlider(0)
  end
  if 100 == self._currentMpRate then
    mpValue = PAGetString(Defines.StringSheet_GAME, "LUA_FAIRYSETTING_ONLY_USE")
  end
  self:UpdateHpSlider()
  self:UpdateMpSlider()
end
function PaGlobal_FairySetting_All:updatePotionList()
  if nil == Panel_Window_FairySetting_All then
    return
  end
  local selfPlayer = getSelfPlayer():get()
  local invenSize = selfPlayer:getInventorySlotCount(false)
  self._ui.list2_Potion:getElementManager():clearKey()
  self._potionList = {}
  self._potionListCount = 0
  for invenIdx = 0, invenSize - 1 do
    local itemWrapper = getInventoryItemByType(CppEnums.ItemWhereType.eInventory, invenIdx)
    if nil ~= itemWrapper and false == self:FileterForSetting(invenIdx, false, CppEnums.ItemWhereType.eInventory) then
      local itemSSW = itemWrapper:getStaticStatus()
      local itemKey = itemWrapper:get():getKey()
      if nil ~= itemSSW and nil ~= itemKey then
        self._potionListCount = self._potionListCount + 1
        self._potionList[self._potionListCount] = {}
        self._potionList[self._potionListCount]._slotNo = invenIdx
        self._potionList[self._potionListCount]._itemKey = itemKey
        self._ui.list2_Potion:getElementManager():pushKey(toInt64(0, self._potionListCount))
      end
    end
  end
  if 0 == self._potionListCount then
    self._ui.txt_NoPotion:SetShow(true)
  else
    self._ui.txt_NoPotion:SetShow(false)
  end
end
function PaGlobal_FairySetting_All:validate()
  if nil == Panel_Window_FairySetting_All then
    return
  end
  self._ui.stc_TitleBG:isValidate()
  self._ui_pc.btn_Close_pc:isValidate()
  self._ui.stc_MainBG:isValidate()
  self._ui.stc_HPItemSlotBG:isValidate()
  self._ui.stc_QuestionMarkHP:isValidate()
  self._ui.stc_HPItemSlot:isValidate()
  self._ui.txt_currentHPValue:isValidate()
  self._ui.progress2_Hp:isValidate()
  self._ui.slider_HP:isValidate()
  self._ui.btn_HPSLider:isValidate()
  self._ui.stc_MPItemSlotBG:isValidate()
  self._ui.stc_QuestionMarkMP:isValidate()
  self._ui.stc_MPItemSlot:isValidate()
  self._ui.txt_currentMPValue:isValidate()
  self._ui.progress2_Mp:isValidate()
  self._ui.slider_MP:isValidate()
  self._ui.btn_MPSLider:isValidate()
  self._ui.stc_DescBG:isValidate()
  self._ui.txt_Desc:isValidate()
  self._ui.stc_BottomButtonBG:isValidate()
  self._ui_pc.btn_Yes_pc:isValidate()
  self._ui_pc.btn_No_pc:isValidate()
  self._ui.list2_Potion:isValidate()
  self._ui.txt_NoPotion:isValidate()
  self._ui.stc_BottomKeyGuide:isValidate()
  self._ui_console.stc_KeyGuide_X:isValidate()
  self._ui_console.stc_KeyGuide_Y:isValidate()
  self._ui_console.stc_KeyGuide_A:isValidate()
  self._ui_console.stc_KeyGuide_B:isValidate()
end
function PaGlobal_FairySetting_All:clearHP()
  if nil == Panel_Window_FairySetting_All then
    return
  end
  self._currentHpKey = nil
  self._currentHpRate = 0
  self._ui.stc_HPItemSlot:SetShow(false)
  self:updatePotionSetting(false)
  self._ui.stc_QuestionMarkHP:SetShow(true)
  Panel_Tooltip_Item_hideTooltip()
end
function PaGlobal_FairySetting_All:clearMP()
  if nil == Panel_Window_FairySetting_All then
    return
  end
  self._currentMpKey = nil
  self._currentMpRate = 0
  self._ui.stc_MPItemSlot:SetShow(false)
  self:updatePotionSetting(false)
  self._ui.stc_QuestionMarkMP:SetShow(true)
  Panel_Tooltip_Item_hideTooltip()
end
function PaGlobal_FairySetting_All:Clear()
  if nil == Panel_Window_FairySetting_All then
    return
  end
  self._ui.list2_Potion:getElementManager():clearKey()
  self._potionList = {}
  self._potionListCount = 0
  self._currentHpKey = nil
  self._currentHpRate = nil
  self._currentMpKey = nil
  self._currentMpRate = nil
end
function PaGlobal_FairySetting_All:SetPos()
  if nil == Panel_Window_FairySetting_All then
    return
  end
  Panel_Window_FairySetting_All:ComputePos()
end
function PaGlobal_FairySetting_All:Request()
  if nil == Panel_Window_FairySetting_All then
    return
  end
  if nil == self._currentHpKey then
    self._currentHpKey = ItemEnchantKey(0, 0)
    self._cacheSetting._hpRate = 0
  end
  if nil == self._currentMpKey then
    self._currentMpKey = ItemEnchantKey(0, 0)
    self._cacheSetting._mpRate = 0
  end
  if nil == self._currentFairyNoStr then
    return
  end
  ToClient_setFairySettingData(tonumber64(self._currentFairyNoStr), self._currentHpKey, self._currentHpRate, self._currentMpKey, self._currentMpRate)
  self._currentFairyNoStr = nil
  self:close()
  PaGlobal_FairyInfo_Update_All()
end
function PaGlobal_FairySetting_All:FileterForSetting(slotNo, notUse_itemWrappers, whereType)
  if nil == Panel_Window_FairySetting_All then
    return
  end
  local itemWrapper = getInventoryItemByType(whereType, slotNo)
  if nil == itemWrapper then
    return true
  end
  local itemKey = itemWrapper:get():getKey()
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  local classType = selfPlayer:getClassType()
  if true == ToClient_checkUsableFairyPotion(itemKey, classType) then
    return false
  end
  return true
end
function PaGlobal_FairySetting_All:SetPotion(key)
  if nil == Panel_Window_FairySetting_All then
    return
  end
  local itemKey = self._potionList[key]._itemKey
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  local classType = selfPlayer:getClassType()
  if -1 == ToClient_getFairyPotionType(itemKey, classType) then
    Proc_ShowMessage_Ack_WithOut_ChattingMessage(PAGetString(Defines.StringSheet_GAME, "LUA_FAIRYSETTING_NOT_ITEM"))
    return
  elseif 0 == ToClient_getFairyPotionType(itemKey, classType) then
    self._currentHpKey = itemKey
    self._ui.stc_QuestionMarkHP:SetShow(false)
  else
    self._currentMpKey = itemKey
    self._ui.stc_QuestionMarkMP:SetShow(false)
  end
  self:updatePotionSetting(false)
end
function PaGlobal_FairySetting_All:isMP(itemKey)
  if nil == Panel_Window_FairySetting_All then
    return
  end
  local key = tonumber(mpKeyStr)
  for idx, value in pairs(fairySubPotionData[self._currentClassType]) do
    if key == value then
      return true
    end
  end
  return false
end
function PaGlobal_FairySetting_All:isHP(itemKey)
  if nil == Panel_Window_FairySetting_All then
    return
  end
  local key = tonumber(hpKeyStr)
  for idx, value in pairs(fairyMainPotionData[0]) do
    if key == value then
      return true
    end
  end
  return false
end
function PaGlobal_FairySetting_All:ShowToolTip(index, isShow)
  if nil == Panel_Window_FairySetting_All then
    return
  end
  local itemWrapper, itemSSW, whereType, slotNo
  if nil ~= self._potionList[index] then
    whereType = CppEnums.ItemWhereType.eInventory
    slotNo = self._potionList[index]._slotNo
    itemWrapper = getInventoryItemByType(whereType, slotNo)
  end
  if nil == itemWrapper then
    return
  end
  itemSSW = itemWrapper:getStaticStatus()
  if nil == itemSSW then
    return
  end
  if true == isShow then
    Panel_Tooltip_Item_Show(itemSSW, Panel_Window_FairySetting_All, true)
  else
    Panel_Tooltip_Item_hideTooltip()
  end
end
function PaGlobal_FairySetting_All:showLimitTextToolTip(index, isShow)
  if false == isShow then
    TooltipSimple_Hide()
    return
  end
  if nil == PaGlobal_FairySetting_All._potionList[index] then
    return
  end
  local control = UI.getChildControl(PaGlobal_FairySetting_All._potionList[index]._control, "StaticText_ItemName")
  TooltipSimple_Show(PaGlobal_FairySetting_All._potionList[index]._control, control:GetText())
end
function PaGlobal_FairySetting_All:UpdateHpSlider()
  if nil == Panel_Window_FairySetting_All then
    return
  end
  local fValue = self._ui.btn_HPSLider:GetPosX() / (self._ui.slider_HP:GetSizeX() - self._ui.btn_HPSLider:GetSizeX())
  local fValueTest = self._ui.slider_HP:GetInterval()
  self._currentHpRate = math.floor(fValue * 100)
  local hpValue = 0
  if self._currentHpRate >= 0 and self._currentHpRate <= 100 then
    hpValue = self._currentHpRate .. "%"
  end
  if 100 == self._currentHpRate then
    hpValue = PAGetString(Defines.StringSheet_GAME, "LUA_FAIRYSETTING_ONLY_USE")
  end
  if 0 == self._currentHpRate then
    hpValue = PAGetString(Defines.StringSheet_GAME, "LUA_FAIRYSETTING_NO_USE")
  end
  self._ui.txt_currentHPValue:SetText(tostring(hpValue))
  self:alignValueText(self._ui.txt_currentHPValue, self._ui.progress2_Hp)
  self._ui.progress2_Hp:SetProgressRate(self._currentHpRate)
end
function PaGlobal_FairySetting_All:SetHpSlider(fValue)
  if nil == Panel_Window_FairySetting_All then
    return
  end
  self._ui.slider_HP:SetControlPos(fValue)
  self._ui.progress2_Hp:SetProgressRate(fValue)
end
function PaGlobal_FairySetting_All:SetMpSlider(fValue)
  if nil == Panel_Window_FairySetting_All then
    return
  end
  self._ui.slider_MP:SetControlPos(fValue)
  self._ui.progress2_Mp:SetProgressRate(fValue)
end
function PaGlobal_FairySetting_All:UpdateMpSlider()
  if nil == Panel_Window_FairySetting_All then
    return
  end
  local fValue = self._ui.btn_MPSLider:GetPosX() / (self._ui.slider_MP:GetSizeX() - self._ui.btn_MPSLider:GetSizeX())
  self._currentMpRate = math.floor(fValue * 100)
  local mpValue = 0
  if self._currentMpRate >= 0 and self._currentMpRate <= 100 then
    mpValue = self._currentMpRate .. "%"
  end
  if 100 == self._currentMpRate then
    mpValue = PAGetString(Defines.StringSheet_GAME, "LUA_FAIRYSETTING_ONLY_USE")
  end
  if 0 == self._currentMpRate then
    mpValue = PAGetString(Defines.StringSheet_GAME, "LUA_FAIRYSETTING_NO_USE")
  end
  self._ui.txt_currentMPValue:SetText(tostring(mpValue))
  self:alignValueText(self._ui.txt_currentMPValue, self._ui.progress2_Mp)
  self._ui.progress2_Mp:SetProgressRate(self._currentMpRate)
end
function PaGlobal_FairySetting_All:createPotionList(control, key64)
  if nil == Panel_Window_FairySetting_All then
    return
  end
  local key = Int64toInt32(key64)
  if nil == self._potionList[key] then
    return
  end
  local slotNo = self._potionList[key]._slotNo
  local itemWrapper = getInventoryItemByType(CppEnums.ItemWhereType.eInventory, slotNo)
  if nil == itemWrapper then
    return
  end
  local itemSSW = itemWrapper:getStaticStatus()
  local itemKey = itemWrapper:get():getKey()
  if nil == itemKey or nil == itemSSW then
    return
  end
  local itemName = itemSSW:getName()
  local icnoPath = itemSSW:getIconPath()
  local chk_Potion = UI.getChildControl(control, "CheckButton_ItemList")
  local stc_Icon = UI.getChildControl(chk_Potion, "Static_ItemIcon")
  local txt_ItemName = UI.getChildControl(chk_Potion, "StaticText_ItemName")
  self._potionList[key]._control = chk_Potion
  stc_Icon:ChangeTextureInfoName("Icon/" .. itemSSW:getIconPath())
  txt_ItemName:SetTextMode(__eTextMode_LimitText)
  txt_ItemName:SetText(itemName)
  chk_Potion:addInputEvent("Mouse_LUp", "InputMLUp_FairySetting_SetPotion_All(" .. key .. ")")
  if false == _ContentsGroup_UsePadSnapping then
    chk_Potion:addInputEvent("Mouse_On", "InputMOn_FairySetting_ShowToolTip(" .. key .. ", true)")
    chk_Potion:addInputEvent("Mouse_Out", "InputMOn_FairySetting_ShowToolTip(" .. key .. ", false)")
    stc_Icon:SetIgnore(true)
  elseif false == _ContentsGroup_RenewUI_Tooltip then
    chk_Potion:registerPadEvent(__eConsoleUIPadEvent_Up_X, "InputMOn_FairySetting_ShowToolTip(" .. key .. ", true)")
    chk_Potion:registerPadEvent(__eConsoleUIPadEvent_DpadLeft, "InputDpadLeft_FairySetting_MoveSnapToLeft_All()")
    chk_Potion:addInputEvent("Mouse_Out", "InputMOn_FairySetting_ShowToolTip(" .. key .. ", false)")
    if txt_ItemName:IsLimitText() then
      chk_Potion:addInputEvent("Mouse_On", "InputMOn_FairySetting_ShowLimitTextToolTip(" .. key .. ", true)")
    end
  else
    chk_Potion:registerPadEvent(__eConsoleUIPadEvent_Up_X, "InputXUp_FairySetting_ShowPotionToopTip(" .. key .. ", true)")
    chk_Potion:registerPadEvent(__eConsoleUIPadEvent_DpadLeft, "InputDpadLeft_FairySetting_MoveSnapToLeft_All()")
    chk_Potion:addInputEvent("Mouse_Out", "InputXUp_FairySetting_ShowPotionToopTip(" .. key .. ", false)")
    if txt_ItemName:IsLimitText() then
      chk_Potion:addInputEvent("Mouse_On", "InputMOn_FairySetting_ShowLimitTextToolTip(" .. key .. ", true)")
    end
  end
end
function PaGlobal_FairySetting_All:moveSnapToLeft()
  if nil == Panel_Window_FairySetting_All then
    return
  end
  local currentControl = ToClient_getSnappedControl()
  if nil ~= currentControl then
    self._prevSnappedControl = currentControl
    local parentControl = currentControl:getParent()
    if nil ~= parentControl then
      local parentCenterPosY = parentControl:GetPosY() + parentControl:GetSizeY() / 2
      if parentCenterPosY > self._ui.stc_MPItemSlotBG:GetPosY() then
        ToClient_padSnapChangeToTarget(self._ui.slider_MP)
      else
        ToClient_padSnapChangeToTarget(self._ui.slider_HP)
      end
    end
  end
end
function PaGlobal_FairySetting_All:moveSnapToRight()
  if nil == Panel_Window_FairySetting_All or nil == self._prevSnappedControl then
    return
  end
  ToClient_padSnapChangeToTarget(self._prevSnappedControl)
  self._prevSnappedControl = nil
end
function PaGlobal_FairySetting_All:ShowPotionTooltip(key, isShow)
  if nil == Panel_Window_FairySetting_All or false == _ContentsGroup_RenewUI then
    return
  end
  if isShow then
    _AudioPostEvent_SystemUiForXBOX(50, 0)
    PaGlobalFunc_FloatingTooltip_Close()
    if true == PaGlobalFunc_TooltipInfo_GetShow() then
      PaGlobalFunc_TooltipInfo_Close()
      return
    end
    PaGlobalFunc_TooltipInfo_Open(Defines.TooltipDataType.ItemWrapper, getInventoryItemByType(CppEnums.ItemWhereType.eInventory, self._potionList[key]._slotNo), Defines.TooltipTargetType.Item, 0)
  else
    TooltipSimple_Hide()
    PaGlobalFunc_TooltipInfo_Close()
  end
end
function PaGlobal_FairySetting_All:alignValueText(textControl, progressControl)
  local halfTextSizeX = textControl:GetTextSizeX() / 2
  local centerPosX = textControl:GetPosX() + textControl:GetSizeX() / 2
  local rightPosX = centerPosX + halfTextSizeX
  local progressRightPosX = progressControl:GetPosX() + progressControl:GetSizeX()
  local defaultPosX = progressRightPosX - textControl:GetSizeX()
  local defaultRightPosX = defaultPosX + textControl:GetSizeX() / 2 + halfTextSizeX
  if defaultRightPosX > self._ui.stc_MainBG:GetSizeX() then
    local diffSizeX = rightPosX - self._ui.stc_MainBG:GetSizeX()
    textControl:SetPosX(textControl:GetPosX() - diffSizeX)
  else
    textControl:SetPosX(defaultPosX)
  end
end
