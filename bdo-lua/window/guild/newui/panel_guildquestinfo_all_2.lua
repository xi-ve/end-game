function HandleCliekedGuildQuestReward()
  PaGlobal_GuildQuestInfo_All._isProgressingQuest = true
  PaGlobal_GuildQuestInfo_All:prepareOpen()
end
function HandlePadEventX_GuildQuestInfo_All_ItemTooltip(itemKey)
  if true == PaGlobalFunc_TooltipInfo_GetShow() then
    PaGlobalFunc_TooltipInfo_Close()
    return
  end
  local itemStatic = getItemEnchantStaticStatus(ItemEnchantKey(itemKey))
  if nil == itemStatic then
    return
  end
  PaGlobalFunc_TooltipInfo_Open(Defines.TooltipDataType.ItemSSWrapper, itemStatic, Defines.TooltipTargetType.Item, 0)
end
function HandleEventLUp_GuildQuestInfo_AcceptQuest_All()
  local AcceptGuildQuest = function()
    ToClient_RequestGuildQuestAccept(PaGlobal_GuildQuestInfo_All._acceptQuestIndex)
    if Panel_GuildQuestInfo_All:GetShow() then
      PaGlobal_GuildQuestInfo_All:updateProgressingQuest()
    end
  end
  local messageboxData = {
    title = "",
    content = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_TEXT_QUESTACCEPT"),
    functionYes = AcceptGuildQuest,
    functionCancel = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageboxData)
end
function FromClient_GuildQuestInfo_UpdateProgressingQuest_All()
  if false == Panel_GuildQuestInfo_All:GetShow() then
    return
  end
  PaGlobal_GuildQuestInfo_All:updateProgressingQuest()
end
function PaGlobal_GuildQuestInfo_NonProgressingQuest_Open_All(index)
  PaGlobal_GuildQuestInfo_All._isProgressingQuest = false
  PaGlobal_GuildQuestInfo_All._currentQuestIndex = index
  PaGlobal_GuildQuestInfo_All:prepareOpen()
end
function PaGlobal_GuildQuestInfo_Close_All()
  PaGlobal_GuildQuestInfo_All:prepareClose()
end
