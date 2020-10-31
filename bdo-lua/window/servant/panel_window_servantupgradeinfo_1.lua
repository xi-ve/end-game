function PaGlobal_ServantUpgradeInfo:init()
  self._ui._btn_close = UI.getChildControl(self._ui._titleBar, "Button_Close")
  self._ui._btn_close:addInputEvent("Mouse_LUp", "PaGlobal_ServantUpgradeInfo:close()")
  self._controlList[self._dataType.HP] = UI.getChildControl(self._ui._bg, "StaticText_HP_Value")
  self._controlList[self._dataType.FOOD] = UI.getChildControl(self._ui._bg, "StaticText_FOOD_Value")
  self._controlList[self._dataType.SPEED] = UI.getChildControl(self._ui._bg, "StaticText_Speed_Value")
  self._controlList[self._dataType.ACCEL] = UI.getChildControl(self._ui._bg, "StaticText_Accel_Value")
  self._controlList[self._dataType.CORNERING] = UI.getChildControl(self._ui._bg, "StaticText_Turning_Value")
  self._controlList[self._dataType.BRAKE] = UI.getChildControl(self._ui._bg, "StaticText_Break_Value")
  self._controlList[self._dataType.INVEN_COUNT] = UI.getChildControl(self._ui._bg, "StaticText_Bag_Value")
  self._controlList[self._dataType.WEIGHT] = UI.getChildControl(self._ui._bg, "StaticText_Weight_Value")
  self._controlList[self._dataType.COST] = UI.getChildControl(self._ui._bg, "StaticText_Cost_Value")
  self._controlList[self._dataType.CANNON_COUNT] = UI.getChildControl(self._ui._bg, "StaticText_CannonCount_Value")
  self._controlList[self._dataType.CANNON_RELOAD] = UI.getChildControl(self._ui._bg, "StaticText_CannonRload_Value")
  self._dataList = Array.new()
  for ii = 0, self._dataType.TypeCount - 1 do
    self._dataList[ii] = Array.new()
    for jj = 0, 1 do
      self._dataList[ii][jj] = 0
    end
  end
end
function PaGlobal_ServantUpgradeInfo:clear()
  for ii = 0, self._dataType.TypeCount - 1 do
    for jj = 0, 1 do
      self._dataList[ii][jj] = 0
    end
  end
end
function PaGlobal_ServantUpgradeInfo:makeString(to, from, unitStr, unitValue, dp)
  local diff = to - from
  local toStr = makeDotString(to, dp, unitValue)
  local diffStr = makeDotString(diff, dp, unitValue)
  if 0 < diff then
    return (string.format("%s%s(<PAColor0xff83a543>\226\150\178%s<PAOldColor>)", toStr, unitStr, diffStr))
  elseif diff < 0 then
    return (string.format("%s%s(<PAColor0xffd05d48>\226\150\188%s<PAOldColor>)", toStr, unitStr, diffStr))
  else
    return (string.format("%s%s", toStr, unitStr))
  end
  return ""
end
function PaGlobal_ServantUpgradeInfo:setServantInfo(characterKeyRaw, index)
  local servantWrapper = stable_getServantByCharacterKey(CharacterKey(characterKeyRaw), 1)
  if nil == servantWrapper then
    return false
  end
  local employeeShipWrapper = ToClient_EmployeeCharacterShipStaticStatusWrapper(characterKeyRaw)
  if nil == employeeShipWrapper then
    return false
  end
  self._dataList[self._dataType.HP][index] = servantWrapper:getMaxHp()
  self._dataList[self._dataType.FOOD][index] = servantWrapper:getMaxFood()
  self._dataList[self._dataType.SPEED][index] = servantWrapper:getStat(CppEnums.ServantStatType.Type_MaxMoveSpeed)
  self._dataList[self._dataType.ACCEL][index] = servantWrapper:getStat(CppEnums.ServantStatType.Type_Acceleration)
  self._dataList[self._dataType.CORNERING][index] = servantWrapper:getStat(CppEnums.ServantStatType.Type_CorneringSpeed)
  self._dataList[self._dataType.BRAKE][index] = servantWrapper:getStat(CppEnums.ServantStatType.Type_BrakeSpeed)
  self._dataList[self._dataType.INVEN_COUNT][index] = servantWrapper:getInventoryMax()
  self._dataList[self._dataType.WEIGHT][index] = Int64toInt32(servantWrapper:getMaxWeight_s64())
  self._dataList[self._dataType.COST][index] = servantWrapper:getEmployeeMaxCost()
  self._dataList[self._dataType.CANNON_COUNT][index] = employeeShipWrapper:getCannonCount()
  self._dataList[self._dataType.CANNON_RELOAD][index] = employeeShipWrapper:getCannonReloadSec()
  return true
end
function PaGlobal_ServantUpgradeInfo:open(fromCharacterKeyRaw, toCharacterKeyRaw)
  if true == self:setServantInfo(fromCharacterKeyRaw, 0) and true == self:setServantInfo(toCharacterKeyRaw, 1) then
    for ii = 0, self._dataType.TypeCount - 1 do
      local str = self:makeString(self._dataList[ii][1], self._dataList[ii][0], self._dataTypeUnit[ii].unitStr, self._dataTypeUnit[ii].unitValue, self._dataTypeUnit[ii].dp)
      self._controlList[ii]:SetText(str)
    end
    Panel_Window_ServantUpgradeInfo:SetShow(true)
    self:reposition()
  else
    Panel_Window_ServantUpgradeInfo:SetShow(false)
  end
end
function PaGlobal_ServantUpgradeInfo:close()
  Panel_Window_ServantUpgradeInfo:SetShow(false)
end
function PaGlobal_ServantUpgradeInfo:reposition()
  if nil == Panel_Window_ServantUpgrade or nil == Panel_Window_ServantUpgradeInfo then
    return
  end
  local posX = Panel_Window_ServantUpgrade:GetPosX() + Panel_Window_ServantUpgrade:GetSizeX()
  local posY = Panel_Window_ServantUpgrade:GetPosY()
  Panel_Window_ServantUpgradeInfo:SetPosXY(posX, posY)
end
