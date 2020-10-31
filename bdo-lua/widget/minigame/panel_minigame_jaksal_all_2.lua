function PaGloabl_Jaksal_All_ShowAni()
  if nil == Panel_MiniGame_Jaksal_All then
    return
  end
end
function PaGloabl_Jaksal_All_HideAni()
  if nil == Panel_MiniGame_Jaksal_All then
    return
  end
end
function PaGloabl_Jaksal_All_Start()
  PaGlobal_Jaksal_All:prepareOpen()
end
function PaGloabl_Jaksal_All_End()
  PaGlobal_Jaksal_All:prepareClose()
end
function PaGlobal_Jaksal_All_UpdatePerframe(deltaTime)
  PaGlobal_Jaksal_All:updatePerFrame(deltaTime)
end
function PaGlobal_Jaksal_All_UpdateKeyPressCheck(keyType)
  PaGlobal_Jaksal_All:updateKeyPressCheck(keyType)
end
