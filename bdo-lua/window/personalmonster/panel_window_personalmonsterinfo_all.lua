PaGlobal_PersonalMonsterInfo_All = {
  _ui = {
    txt_BossName = nil,
    txt_Desc = nil,
    stc_itemSlotBg = nil
  },
  _slotConfig = {createIcon = true, createBorder = true},
  _itemSlots = {},
  _MAXITEMSLOT = 8,
  _initialize = false
}
registerEvent("FromClient_luaLoadComplete", "FromClient_PersonalMonsterInfo_ALL_Init")
function FromClient_PersonalMonsterInfo_ALL_Init()
  PaGlobal_PersonalMonsterInfo_All:initialize()
end
function PaGlobal_PersonalMonsterInfo_All:initialize()
  if true == self._initialize then
    return
  end
  self._ui.txt_BossName = UI.getChildControl(Panel_PersonalMonsterInfo_All, "StaticText_Name")
  self._ui.txt_Desc = UI.getChildControl(Panel_PersonalMonsterInfo_All, "StaticText_Desc")
  self._ui.txt_Desc:SetTextMode(__eTextMode_AutoWrap)
  for idx = 0, self._MAXITEMSLOT - 1 do
    self._itemSlots[idx] = UI.createAndCopyBasePropertyControl(Panel_PersonalMonsterInfo_All, "Static_ItemSlotBg", Panel_PersonalMonsterInfo_All, "Boss_ItemSlotBg_" .. idx)
    self._itemSlots[idx]:SetPosX(20 + (self._itemSlots[idx]:GetSizeX() + 10) * idx)
    local itemSlot = {}
    SlotItem.new(itemSlot, "Static_BossItemSlot_WorldMap" .. tostring(idx), idx, self._itemSlots[idx], self._slotConfig)
    itemSlot:createChild()
  end
  PaGlobal_PersonalMonsterInfo_All:validate()
  PaGlobal_PersonalMonsterInfo_All:registerEvent()
  self._initialize = true
end
function PaGlobal_PersonalMonsterInfo_All:validate()
  self._ui.txt_BossName:isValidate()
  self._ui.txt_Desc:isValidate()
end
function PaGlobal_PersonalMonsterInfo_All:registerEvent()
  registerEvent("FromClient_OnWorldMapPersonalMonster", "FromClient_PersonalMonsterInfoAll_Show")
  registerEvent("FromClient_OutWorldMapPersonalMonster", "FromClient_PersonalMonsterInfoAll_Hide")
  registerEvent("FromClient_RClickedWorldMapPersonalMonster", "FromClient_PersonalMonsterInfoAll_Navigate")
end
function PaGlobal_PersonalMonsterInfo_All:prepareOpen(monsterKey)
  PaGlobal_PersonalMonsterInfo_All:open()
  PaGlobal_PersonalMonsterInfo_All:update(monsterKey)
end
function PaGlobal_PersonalMonsterInfo_All:open()
  Panel_PersonalMonsterInfo_All:SetShow(true)
end
function PaGlobal_PersonalMonsterInfo_All:update(monsterKey)
  local monsterStatusWrapper = ToClient_GetCharacterStaticStatusWrapper(monsterKey)
  local personalMonsterWrapper = ToClient_GetPersonalMonsterWrapper(monsterKey)
  if nil == monsterStatusWrapper or nil == personalMonsterWrapper then
    FromClient_PersonalMonsterInfoAll_Hide()
    return
  end
  self._ui.txt_BossName:SetText(monsterStatusWrapper:getName())
  self._ui.txt_Desc:SetText(personalMonsterWrapper:getDescription())
  local itemCount = personalMonsterWrapper:getDropItemCount()
  for index = 0, self._MAXITEMSLOT - 1 do
    self._itemSlots[index]:SetShow(false)
    if index < itemCount then
      local itemKey = personalMonsterWrapper:getDropItemKey(index)
      local itemSSW = getItemEnchantStaticStatus(ItemEnchantKey(itemKey))
      if nil ~= itemSSW and nil ~= self._itemSlots[index] then
        local tempIcon = {}
        SlotItem.reInclude(tempIcon, "Static_BossItemSlot_WorldMap" .. tostring(index), index, self._itemSlots[index], self._slotConfig)
        tempIcon:setItemByStaticStatus(itemSSW)
        self._itemSlots[index]:SetShow(true)
      end
    end
  end
end
function PaGlobal_PersonalMonsterInfo_All:prepareClose()
  if false == Panel_PersonalMonsterInfo_All:GetShow() then
    return
  end
  PaGlobal_PersonalMonsterInfo_All:close()
end
function PaGlobal_PersonalMonsterInfo_All:close()
  Panel_PersonalMonsterInfo_All:SetShow(false)
end
function PaGlobalFunc_PersonalMonsterInfo_All_Close()
  if false == Panel_PersonalMonsterInfo_All:GetShow() then
    return
  end
  PaGlobal_PersonalMonsterInfo_All:prepareClose()
end
function PaGlobal_PersonalMonsterInfo_All:SetPanelPos(posX, posY, sizeX, sizeY)
  local screenSizeX = getScreenSizeX()
  local screenSizeY = getScreenSizeY()
  if posX > screenSizeX / 2 then
    posX = posX - Panel_PersonalMonsterInfo_All:GetSizeX()
  else
    posX = posX + sizeX
  end
  if posY > screenSizeY / 2 then
    posY = posY - Panel_PersonalMonsterInfo_All:GetSizeY()
  end
  Panel_PersonalMonsterInfo_All:SetPosXY(posX, posY)
end
function FromClient_PersonalMonsterInfoAll_Show(personalMonsterBtn)
  if true == Panel_PersonalMonsterInfo_All:GetShow() then
    return
  end
  local key = personalMonsterBtn:getCharacterKey()
  local posX = personalMonsterBtn:GetPosX()
  local posY = personalMonsterBtn:GetPosY()
  local sizeX = personalMonsterBtn:GetSizeX()
  local sizeY = personalMonsterBtn:GetSizeY()
  PaGlobal_PersonalMonsterInfo_All:SetPanelPos(posX, posY, sizeX, sizeY)
  PaGlobal_PersonalMonsterInfo_All:prepareOpen(key)
end
function FromClient_PersonalMonsterInfoAll_Hide()
  PaGlobal_PersonalMonsterInfo_All:prepareClose()
end
function FromClient_PersonalMonsterInfoAll_Navigate(uiPersonalStatic)
  if nil == uiPersonalStatic then
    return
  end
  ToClient_DeleteNaviGuideByGroup(0)
  local getPos = uiPersonalStatic:getPosition()
  local position = float3(getPos.x, getPos.y, getPos.z)
  ToClient_WorldMapNaviStart(position, NavigationGuideParam(), false, true)
  audioPostEvent_SystemUi(0, 14)
  _AudioPostEvent_SystemUiForXBOX(0, 14)
end
