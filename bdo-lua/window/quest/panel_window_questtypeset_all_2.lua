function PaGlobalFunc_QuestTypeSet_All_Open()
  PaGlobal_QuestTypeSet_All:prepareOpen()
end
function PaGlobalFunc_QuestTypeSet_All_Close()
  PaGlobal_QuestTypeSet_All:prepareClose()
end
function HandlePadEventOn_QuestTypeSet_All_ShowDescription(selectType)
  if nil == selectType then
  end
  PaGlobal_QuestTypeSet_All._ui.txt_selectedTypeName:SetText(PaGlobal_QuestTypeSet_All._questTypeStr[selectType].title)
  PaGlobal_QuestTypeSet_All._ui.stc_selectedTypeDesc:SetText(PaGlobal_QuestTypeSet_All._questTypeStr[selectType].titleDesc)
end
function HandleEventLUp_QuestTypeSet_All_CheckButton(buttonIdx)
  if PaGlobal_QuestTypeSet_All._TYPE.STORY == buttonIdx then
    PaGlobal_QuestTypeSet_All:checkButtonAll()
  else
    ToClient_ToggleQuestSelectType(buttonIdx)
  end
  PaGlobal_QuestTypeSet_All:favorTypeUpdate()
end
function FromClient_Quest_All_LevelFifty_SetFavorType()
  if nil == getSelfPlayer() then
    return
  end
  if 50 ~= getSelfPlayer():get():getLevel() then
    return
  end
  if false == PaGlobal_QuestTypeSet_All._isConsole then
    return
  end
  if true == PaGlobal_QuestTypeSet_All._questTypeGroup[PaGlobal_QuestTypeSet_All._TYPE.ETC].check:IsCheck() then
    return
  end
  PaGlobal_QuestTypeSet_All._questTypeGroup[PaGlobal_QuestTypeSet_All._TYPE.ETC].icon:SetCheck(true)
  PaGlobal_QuestTypeSet_All._questTypeGroup[PaGlobal_QuestTypeSet_All._TYPE.ETC].check:SetCheck(true)
end
