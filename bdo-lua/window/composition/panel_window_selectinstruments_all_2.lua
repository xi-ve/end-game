function PaGloabl_SelectInstruments_All_Open(musicIndex)
  if nil == Panel_Window_SelectInstruments_All then
    return
  end
  PaGlobal_SelectInstruments_All:prepareOpen(musicIndex)
end
function PaGloabl_SelectInstruments_All_Close(isConfirm)
  if nil == Panel_Window_SelectInstruments_All then
    return
  end
  if nil == isConfirm then
    isConfirm = false
  end
  PaGlobal_SelectInstruments_All:prepareClose(isConfirm)
end
function PaGloabl_SelectInstruments_All_SelectTrackIndex(trackIndex)
  PaGlobal_SelectInstruments_All:selectTrackIndex(trackIndex)
end
function PaGloabl_SelectInstruments_All_ConfirmBtn()
  PaGlobal_SelectInstruments_All:confirmBtn()
end
