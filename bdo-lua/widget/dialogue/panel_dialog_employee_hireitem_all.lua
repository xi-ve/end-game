PaGlobal_EmployeeHireItem_All = {
  _ui = {},
  _initialize = false
}
runLua("UI_Data/Script/Widget/Dialogue/Panel_Dialog_Employee_HireItem_All_1.lua")
runLua("UI_Data/Script/Widget/Dialogue/Panel_Dialog_Employee_HireItem_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_EmployeeHireItem_luaLoadComplete")
function FromClient_EmployeeHireItem_luaLoadComplete()
  PaGlobal_EmployeeHireItem_All:initialize()
end
