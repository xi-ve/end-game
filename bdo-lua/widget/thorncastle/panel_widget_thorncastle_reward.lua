PaGlobal_ThornCastle_Reward = {
  _ui = {
    {
      _backBG = nil,
      _teamNameText = nil,
      _itemIcon = {},
      _itemSlot = {},
      _itemText = {},
      _exitBtn = nil
    },
    {
      _backBG = nil,
      _teamNameText = nil,
      _itemIcon = {},
      _itemSlot = {},
      _itemText = {},
      _exitBtn = nil
    }
  },
  _index = 0,
  _initialize = false
}
runLua("UI_Data/Script/Widget/ThornCastle/Panel_Widget_ThornCastle_Reward_1.lua")
runLua("UI_Data/Script/Widget/ThornCastle/Panel_Widget_ThornCastle_Reward_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_ThornCastle_RewardInit")
function FromClient_ThornCastle_RewardInit()
  PaGlobal_ThornCastle_Reward:initialize()
end
