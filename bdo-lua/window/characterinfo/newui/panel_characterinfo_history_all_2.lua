function PaGlobalFunc_CharInfoHistory_All_Update()
  if false == PaGlobalFunc_ChracterInfo_All_GetBgShow(PaGlobal_CharInfo_All._TABINDEX._history) then
    return
  end
  PaGlobal_CharInfoHistory_All:dataClear()
  if true == PaGlobal_CharInfoHistory_All._firstOpenCheck then
    PaGlobal_CharInfoHistory_All._firstOpenCheck = false
    PaGlobal_CharInfoHistory_All:yearUpdate(ToClient_GetThisYear() - PaGlobal_CharInfoHistory_All._firstLogYearValue)
    PaGlobal_CharInfoHistory_All:monthUpdate(ToClient_GetThisMonth() - 1)
    PaGlobal_CharInfoHistory_All.haveInfoMonth = ToClient_GetThisMonth()
    return
  end
  local currentValue = PaGlobal_CharInfoHistory_All._currentValue
  ToClient_RequestJournalList(currentValue._year, currentValue._month, currentValue._myHistory)
end
function FromClient_CharInfoHistory_All_FrameUpdate()
  if false == PaGlobalFunc_ChracterInfo_All_GetBgShow(PaGlobal_CharInfo_All._TABINDEX._history) then
    return
  end
  PaGlobal_CharInfoHistory_All:updateFrame()
end
function HandleEventLUp_CharInfoHistory_All_YearCheck(index)
  if nil == index then
    return
  end
  PaGlobal_CharInfoHistory_All:yearUpdate(index)
end
function HandleEventLUp_CharInfoHistory_All_MonthCheck(index, audioFlag)
  if nil == index then
    return
  end
  PaGlobal_CharInfoHistory_All:monthUpdate(index, audioFlag)
end
