function PaGlobalFunc_Achievement_BookShelf_All_Open()
  if nil == Panel_Window_Achievement_BookShelf_All or false == _ContentsGroup_AchievementQuest then
    return
  end
  PaGlobal_Achievement_BookShelf_All:prepareOpen()
end
function PaGlobalFunc_Achievement_BookShelf_All_Close()
  if nil == Panel_Window_Achievement_BookShelf_All then
    return
  end
  PaGlobal_Achievement_BookShelf_All:prepareClose()
end
function PaGlobalFunc_Achievement_BookShelf_All_ShowToggle()
  if nil == Panel_Window_Achievement_BookShelf_All or false == _ContentsGroup_AchievementQuest then
    return
  end
  if Panel_Window_Achievement_BookShelf_All:GetShow() then
    PaGlobal_Achievement_BookShelf_All:prepareClose()
  else
    PaGlobal_Achievement_BookShelf_All:prepareOpen()
  end
end
function PaGlobalFunc_Achievement_BookShelf_All_ShowToggleFamilyWidget()
  if nil == Panel_Window_Achievement_BookShelf_All then
    return
  end
  PaGlobal_Achievement_BookShelf_All:showToggleFamilyWidget()
end
function HandleEventLUp_Achievement_BookShelf_All_SelectJournal(index)
  if nil == Panel_Window_Achievement_BookShelf_All then
    return
  end
  PaGlobal_Achievement_BookShelf_All:selectJournal(index)
end
function HandleEventLUp_Achievement_BookShelf_All_SelectChapter(index)
  if nil == Panel_Window_Achievement_BookShelf_All then
    return
  end
  PaGlobal_Achievement_BookShelf_All:selectChapter(index)
end
function PaGlobalFunc_Achievement_BookShelf_All_GetBookInfoForBookmark()
  if nil == Panel_Window_Achievement_BookShelf_All then
    return
  end
  return PaGlobal_Achievement_BookShelf_All._selectedJournalGroup, PaGlobal_Achievement_BookShelf_All._selectedJournalChapter
end
function FromClient_Achievement_BookShelf_All_UpdateQuestList()
  if nil == Panel_Window_Achievement_BookShelf_All then
    return
  end
  PaGlobal_Achievement_BookShelf_All:update()
end
function PaGlobal_Achievement_BookShelf_All_UpdateSetDirectJournalChapter(questGroup, questNo)
  PaGlobal_Achievement_BookShelf_All:updateSetDirectJournalChapter(questGroup, questNo)
end
function HandleEventOnOut_Achievement_BookShelf_All_Show_EventJournal_Title(idx)
  if nil == idx or 9 ~= PaGlobal_Achievement_BookShelf_All._selectedJournalGroup then
    PaGlobal_Achievement_BookShelf_All._ui.txt_SelectedBookName:SetText("")
    return
  end
  if nil == PaGlobal_Achievement_BookShelf_All._eventJournalTitle[idx] then
    return
  end
  local bookTitle = PaGlobal_Achievement_BookShelf_All._eventJournalTitle[idx]
  PaGlobal_Achievement_BookShelf_All._ui.txt_SelectedBookName:SetText(bookTitle)
end
