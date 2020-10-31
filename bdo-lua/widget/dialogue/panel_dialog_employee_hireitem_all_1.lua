function PaGlobal_EmployeeHireItem_All:initialize()
  self._ui.hireItem_List = UI.getChildControl(Panel_Widget_EmployeeHireItem_All, "List2_Exchange_List")
  PaGlobal_EmployeeHireItem_All:registerEventHandler()
  PaGlobal_EmployeeHireItem_All:validate()
  PaGlobal_EmployeeHireItem_All._initialize = true
end
function PaGlobal_EmployeeHireItem_All:registerEventHandler()
  if nil == Panel_Widget_EmployeeHireItem_All then
    return
  end
  self._ui.hireItem_List:registEvent(__ePAUIList2EventType_LuaChangeContent, "PaGlobal_EmployeeHireItem_CreateListControl")
  self._ui.hireItem_List:createChildContent(__ePAUIList2ElementManagerType_List)
  registerEvent("onScreenResize", "PaGlobal_EmployeeHireItem_Resize")
end
function PaGlobal_EmployeeHireItem_All:update()
  local npcDialogData = ToClient_GetCurrentDialogData()
  if nil == npcDialogData then
    return
  end
  local displayExchangeWrapper = npcDialogData:getCurrentDisplayExchangeWrapper()
  if nil == displayExchangeWrapper then
    self:prepareClose()
    return
  end
  local size = displayExchangeWrapper:getItemExchangeByNpcListSize()
  self._hireItemList = {}
  local count = 0
  for index = 0, size - 1 do
    local itemWrapperLua = displayExchangeWrapper:getItemExchangeByNpcStaticStatusWrapperAtIndex(index)
    if nil ~= itemWrapperLua then
      local needItemWrapperLua = itemWrapperLua:getNeedItemStaticStatusWrapper()
      if nil ~= needItemWrapperLua then
        self._hireItemList[count] = {}
        self._hireItemList[count].exchangeIndex = index
        self._hireItemList[count].needCount = itemWrapperLua:getNeedItemCount_s64()
        self._hireItemList[count].colorGrade = needItemWrapperLua:getGradeType()
        self._hireItemList[count].name = needItemWrapperLua:getName()
        self._hireItemList[count].iconPath = needItemWrapperLua:getIconPath()
        count = count + 1
      end
    end
  end
  self._ui.hireItem_List:getElementManager():clearKey()
  for i = 0, count - 1 do
    self._ui.hireItem_List:getElementManager():pushKey(toInt64(0, i))
  end
  if 0 == count then
    self:prepareClose()
  end
end
function PaGlobal_EmployeeHireItem_Resize()
  PaGlobal_EmployeeHireItem_All:onScreenResize()
end
function PaGlobal_EmployeeHireItem_All:onScreenResize()
  Panel_Widget_EmployeeHireItem_All:ComputePos()
end
function PaGlobal_EmployeeHireItem_All:getGradeToColorString(grade)
  if 0 == grade then
    return "<PAColor0xffc4bebe>"
  elseif 1 == grade then
    return "<PAColor0xFF5DFF70>"
  elseif 2 == grade then
    return "<PAColor0xFF4B97FF>"
  elseif 3 == grade then
    return "<PAColor0xFFFFC832>"
  elseif 4 == grade then
    return "<PAColor0xFFFF6C00>"
  else
    return "<PAColor0xffc4bebe>"
  end
end
function PaGlobal_EmployeeHireItem_CreateListControl(control, key)
  if nil == Panel_Window_SailorManager_All then
    return
  end
  PaGlobal_EmployeeHireItem_All:listCreate(control, key)
end
function PaGlobal_EmployeeHireItem_All:listCreate(control, key)
  if nil == Panel_Widget_EmployeeHireItem_All then
    return
  end
  local index = Int64toInt32(key)
  local itemIcon = UI.getChildControl(control, "Static_ItemIcon")
  local itemName = UI.getChildControl(control, "StaticText_BeforeTemplete")
  local itemInfo = self._hireItemList[index]
  if nil == itemInfo then
    return
  end
  itemIcon:ChangeTextureInfoName("icon/" .. itemInfo.iconPath)
  itemName:SetText(self:getGradeToColorString(itemInfo.colorGrade) .. itemInfo.name .. "<PAOldColor> x" .. tostring(itemInfo.needCount))
  itemIcon:addInputEvent("Mouse_On", "PaGlobal_EmployeeHireItem_ShowToolTip( " .. index .. ")")
  itemIcon:addInputEvent("Mouse_Out", "PaGlobal_EmployeeHireItem_HideToolTip()")
end
function PaGlobal_EmployeeHireItem_All:prepareOpen()
  if nil == Panel_Widget_EmployeeHireItem_All then
    return
  end
  PaGlobal_EmployeeHireItem_All:onScreenResize()
  PaGlobal_EmployeeHireItem_All:update()
  PaGlobal_EmployeeHireItem_All:open()
end
function PaGlobal_EmployeeHireItem_All:open()
  if nil == Panel_Widget_EmployeeHireItem_All then
    return
  end
  Panel_Widget_EmployeeHireItem_All:SetShow(true)
end
function PaGlobal_EmployeeHireItem_All:prepareClose()
  if nil == Panel_Widget_EmployeeHireItem_All then
    return
  end
  PaGlobal_EmployeeHireItem_HideToolTip()
  PaGlobal_EmployeeHireItem_All:close()
end
function PaGlobal_EmployeeHireItem_All:close()
  if nil == Panel_Widget_EmployeeHireItem_All then
    return
  end
  Panel_Widget_EmployeeHireItem_All:SetShow(false)
end
function PaGlobal_EmployeeHireItem_All:validate()
  if nil == Panel_Widget_EmployeeHireItem_All then
    return
  end
end
