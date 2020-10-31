function PaGloabl_SinGauge_All_ShowAni()
  if nil == Panel_MiniGame_SinGauge_All then
    return
  end
end
function PaGloabl_SinGauge_All_HideAni()
  if nil == Panel_MiniGame_SinGauge_All then
    return
  end
end
function PaGloabl_SinGauge_All_StartGame()
  PaGlobal_SinGauge_All:startGame()
end
function PaGloabl_SinGauge_All_EndGame()
  PaGlobal_SinGauge_All:endGame()
end
function PaGlobal_SinGauge_All_UpdateGauge()
  PaGlobal_SinGauge_All:updateGauge()
end
function PaGlobal_SinGauge_All_KeyPress(keyType)
  PaGlobal_SinGauge_All:keyPress(keyType)
end
