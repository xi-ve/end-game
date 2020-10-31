function PaGlobal_Quest_Option_All_Open()
  PaGlobal_Quest_Option_All:prepareOpen()
end
function PaGlobal_Quest_Option_All_Close()
  PaGlobal_Quest_Option_All:prepareClose()
end
function PaGlobal_Quest_Option_All_GetShow()
  return Panel_Window_Quest_Option_All:GetShow()
end
function PaGlobal_Quest_Option_All_Confirm()
  PaGlobal_Quest_Option_All:confirm()
  if false == _ContentsGroup_RenewUI then
    if true == _ContentsGroup_NewUI_Quest_All then
      PaGlobalFunc_Quest_All_FavorTypeUpdate()
    else
      FGlobal_QuestWindow_favorTypeUpdate()
    end
  else
    FGlobal_CheckedQuestFaverTypeUpdate()
  end
  FGlobal_ChangeLatestQuestShowCount()
end
function PaGlobal_Quest_Option_All_GetLatestQuestShowCount()
  return PaGlobal_Quest_Option_All:getLatestQuestShowCount()
end
function PaGlobal_Quest_Option_All_GetSelectedWidgetType()
  return PaGlobal_Quest_Option_All:getQuestWidgetType()
end
function HandleEventLUp_Quest_Option_All_SelectQuestFavorType(selectType)
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  if 20 <= selfPlayer:get():getLevel() then
    if PaGlobal_Quest_Option_All._favorType.All == selectType then
      PaGlobal_Quest_Option_All:setFavorButtonCheckAll()
    else
      PaGlobal_Quest_Option_All:updateFavorButton()
    end
  else
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_CHECKEDQUEST_FAVORITETYPE_ALERT"))
    local checkButton = PaGlobal_Quest_Option_All._ui.favorCheckBoxButton[selectType]
    if nil ~= checkButton then
      checkButton:SetCheck(not checkButton:IsCheck())
    end
  end
end
function HandleEventOnOut_Quest_Option_All_ShowToolTip(isShow, index)
  if false == isShow or nil == index then
    TooltipSimple_Hide()
    return
  end
  local control = PaGlobal_Quest_Option_All._ui.favorCheckBoxButton[index]
  if nil == control then
    return
  end
  local name = ""
  local desc = ""
  local favorType = PaGlobal_Quest_Option_All._favorType
  if favorType.All == index then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_CHECKEDQUEST_TOOLTIP_QUESTTYPE_ALL_NAME")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_CHECKEDQUEST_TOOLTIP_QUESTTYPE_ALL_DESC")
  elseif favorType.Battle == index then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_CHECKEDQUEST_TOOLTIP_QUESTTYPE_COMBAT_NAME")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_CHECKEDQUEST_TOOLTIP_QUESTTYPE_COMBAT_DESC")
  elseif favorType.Life == index then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_CHECKEDQUEST_TOOLTIP_QUESTTYPE_LIFE_NAME")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_CHECKEDQUEST_TOOLTIP_QUESTTYPE_LIFE_DESC")
  elseif favorType.Fishing == index then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_CHECKEDQUEST_TOOLTIP_QUESTTYPE_FISH_NAME")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_CHECKEDQUEST_TOOLTIP_QUESTTYPE_FISH_DESC")
  elseif favorType.Trade == index then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_CHECKEDQUEST_TOOLTIP_QUESTTYPE_TRADE_NAME")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_CHECKEDQUEST_TOOLTIP_QUESTTYPE_TRADE_DESC")
  elseif favorType.Etc == index then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_CHECKEDQUEST_TOOLTIP_QUESTTYPE_ETC_NAME")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_CHECKEDQUEST_TOOLTIP_QUESTTYPE_ETC_DESC")
  end
  TooltipSimple_Show(control, name, desc)
end
function FromClient_Quest_Option_All_OnScreenResize()
  PaGlobal_Quest_Option_All:resize()
end
