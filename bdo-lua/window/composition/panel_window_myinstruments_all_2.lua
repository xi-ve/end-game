function PaGlobal_MyInstruments_All_Open()
  if nil == Panel_Window_MyInstruments_All then
    return
  end
  PaGlobal_MyInstruments_All:prepareOpen()
end
function PaGlobal_MyInstruments_All_Close()
  if nil == Panel_Window_MyInstruments_All then
    return
  end
  PaGlobal_MyInstruments_All:prepareClose()
end
function PaGlobal_MyInstruments_All_Update()
  PaGlobal_MyInstruments_All:update()
end
