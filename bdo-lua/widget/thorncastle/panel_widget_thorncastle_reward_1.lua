function PaGlobal_ThornCastle_Reward:initialize()
  if true == PaGlobal_ThornCastle_Reward._initialize then
    return
  end
  local staticTitle = UI.getChildControl(Panel_Widget_ThornCastle_Reward_Win, "Static_Title")
  self._ui[1]._backBG = UI.getChildControl(Panel_Widget_ThornCastle_Reward_Win, "Static_BG")
  self._ui[1]._exitBtn = UI.getChildControl(Panel_Widget_ThornCastle_Reward_Win, "Button_EXIT")
  self._ui[1]._teamNameText = UI.getChildControl(staticTitle, "StaticText_SubText")
  local staticReward = UI.getChildControl(Panel_Widget_ThornCastle_Reward_Win, "Static_Reward")
  for ii = 1, 3 do
    self._ui[1]._itemSlot[ii] = UI.getChildControl(staticReward, "Static_ItemSlot_" .. tostring(ii))
    self._ui[1]._itemIcon[ii] = UI.getChildControl(self._ui[1]._itemSlot[ii], "Static_ItemIcon")
    self._ui[1]._itemText[ii] = UI.getChildControl(self._ui[1]._itemSlot[ii], "StaticText_ItemName")
  end
  staticTitle = UI.getChildControl(Panel_Widget_ThornCastle_Reward_Lose, "Static_Title")
  self._ui[2]._backBG = UI.getChildControl(Panel_Widget_ThornCastle_Reward_Lose, "Static_BG")
  self._ui[2]._exitBtn = UI.getChildControl(Panel_Widget_ThornCastle_Reward_Lose, "Button_EXIT")
  self._ui[2]._teamNameText = UI.getChildControl(staticTitle, "StaticText_SubText")
  staticReward = UI.getChildControl(Panel_Widget_ThornCastle_Reward_Lose, "Static_Reward")
  for ii = 1, 3 do
    self._ui[2]._itemSlot[ii] = UI.getChildControl(staticReward, "Static_ItemSlot_" .. tostring(ii))
    self._ui[2]._itemIcon[ii] = UI.getChildControl(self._ui[2]._itemSlot[ii], "Static_ItemIcon")
    self._ui[2]._itemText[ii] = UI.getChildControl(self._ui[2]._itemSlot[ii], "StaticText_ItemName")
  end
  self:registEventHandler()
  self:validate()
  self._initialize = true
  Panel_Widget_ThornCastle_Reward_Win:SetShow(false)
  Panel_Widget_ThornCastle_Reward_Lose:SetShow(false)
end
function PaGlobal_ThornCastle_Reward:prepareOpen(isWin)
  if nil == PaGlobal_ThornCastle_Reward then
    return
  end
  if true == isWin then
    self._index = 1
  else
    self._index = 2
  end
  local rewardCount = ToClient_GetOthilitaRewardCount(isWin)
  local myTeamNo = ToClient_GetOthilitaTeamNo()
  if 0 == myTeamNo then
    self._ui[self._index]._teamNameText:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_THORNCASTLE_TEAMNAME_BLUE"))
  else
    self._ui[self._index]._teamNameText:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_THORNCASTLE_TEAMNAME_RED"))
  end
  self._ui[self._index]._backBG:SetSize(getScreenSizeX(), getScreenSizeY())
  self._ui[self._index]._backBG:ComputePos()
  for ii = 1, 3 do
    self._ui[self._index]._itemSlot[ii]:SetShow(false)
  end
  for ii = 1, rewardCount do
    local itemWrapper = ToClient_GetOthilitaRewardItemByIndex(ii - 1, isWin)
    if nil == itemWrapper then
      self._ui[self._index]._itemSlot[ii]:SetShow(false)
    else
      local itemSS = itemWrapper:getStaticStatus()
      if nil == itemSS then
        self._ui[self._index]._itemSlot[ii]:SetShow(false)
      else
        self._ui[self._index]._itemIcon[ii]:ChangeTextureInfoName("Icon/" .. itemSS:getIconPath())
        self._ui[self._index]._itemText[ii]:SetText(itemSS:getName() .. " \239\188\184 " .. tostring(Int64toInt32(itemWrapper:getCount())))
        self._ui[self._index]._itemSlot[ii]:SetShow(true)
      end
    end
  end
  PaGlobal_ThornCastle_Reward:open(isWin)
end
function PaGlobal_ThornCastle_Reward:open(isWin)
  if nil == Panel_Widget_ThornCastle_Reward_Win or nil == Panel_Widget_ThornCastle_Reward_Lose then
    return
  end
  if true == isWin then
    Panel_Widget_ThornCastle_Reward_Win:SetShow(true)
  else
    Panel_Widget_ThornCastle_Reward_Lose:SetShow(true)
  end
end
function PaGlobal_ThornCastle_Reward:prepareClose()
  if nil == Panel_Widget_ThornCastle_Reward_Win or nil == Panel_Widget_ThornCastle_Reward_Lose then
    return
  end
  PaGlobal_ThornCastle_Reward:close()
end
function PaGlobal_ThornCastle_Reward:close()
  if nil == Panel_Widget_ThornCastle_Reward_Win or nil == Panel_Widget_ThornCastle_Reward_Lose then
    return
  end
  Panel_Widget_ThornCastle_Reward_Win:SetShow(true)
  Panel_Widget_ThornCastle_Reward_Lose:SetShow(true)
end
function PaGlobal_ThornCastle_Reward:validate()
  if nil == Panel_Widget_ThornCastle_Reward_Win or nil == Panel_Widget_ThornCastle_Reward_Lose then
    return
  end
  self._ui[1]._backBG:isValidate()
  self._ui[1]._exitBtn:isValidate()
  self._ui[1]._teamNameText:isValidate()
  local count = ToClient_GetOthilitaRewardCount(true)
  for ii = 1, count do
    self._ui[1]._itemIcon[ii]:isValidate()
    self._ui[1]._itemText[ii]:isValidate()
  end
  self._ui[2]._backBG:isValidate()
  self._ui[2]._exitBtn:isValidate()
  self._ui[2]._teamNameText:isValidate()
  count = ToClient_GetOthilitaRewardCount(false)
  for ii = 1, count do
    self._ui[2]._itemIcon[ii]:isValidate()
    self._ui[2]._itemText[ii]:isValidate()
  end
end
function PaGlobal_ThornCastle_Reward:registEventHandler()
  if nil == Panel_Widget_ThornCastle_Reward_Win or nil == Panel_Widget_ThornCastle_Reward_Lose then
    return
  end
  registerEvent("FromClient_Widget_ThornCastle_End_Notify", "PaGlobal_ThornCastle_Reward_SetEndGame")
  self._ui[1]._exitBtn:addInputEvent("Mouse_LUp", "HandleEventLUp_Widget_ThornCastle_Reward_Exit_Game()")
  self._ui[2]._exitBtn:addInputEvent("Mouse_LUp", "HandleEventLUp_Widget_ThornCastle_Reward_Exit_Game()")
end
