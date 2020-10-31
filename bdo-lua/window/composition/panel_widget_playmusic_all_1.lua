function PaGlobal_PlayMusic_All:setPos()
  local lastIcon = PaGlobalFunc_ServantIcon_GetLastIcon()
  if nil == lastIcon then
    return
  end
  Panel_Widget_PlayMusic_All:SetPosX(lastIcon:GetPosX() + PaGlobalFunc_ServantIcon_GetGapX())
  Panel_Widget_PlayMusic_All:SetPosY(PaGlobalFunc_ServantIcon_GetPanelPosY() + lastIcon:GetPosY())
end
function PaGlobal_PlayMusic_All:initialize()
  if true == PaGlobal_PlayMusic_All._initialize then
    return
  end
  Panel_Widget_PlayMusic_All:SetShow(false)
  Panel_Widget_PlayMusic_All:setGlassBackground(true)
  Panel_Widget_PlayMusic_All:ActiveMouseEventEffect(false)
  self._ui._btn_Close = UI.getChildControl(Panel_Widget_PlayMusic_All, "Button_PlayIcon")
  self._ui._static_bubbleBox = UI.getChildControl(Panel_Widget_PlayMusic_All, "StaticText_BubbleBox")
  PaGlobal_PlayMusic_All:registEventHandler()
  PaGlobal_PlayMusic_All:validate()
  PaGlobal_PlayMusic_All._initialize = true
end
function PaGlobal_PlayMusic_All:registEventHandler()
  if nil == Panel_Widget_PlayMusic_All then
    return
  end
  registerEvent("FromClient_PlayMusic_Stop", "FromClient_PlayMusic_Stop")
  registerEvent("FromClient_PlayMusic_Start", "FromClient_PlayMusic_Start")
  registerEvent("FromClient_PlayMusic_Close", "FromClient_PlayMusic_Close")
  registerEvent("FromClient_IncreaseExp", "FromClient_IncreaseExp")
  Panel_Widget_PlayMusic_All:RegisterShowEventFunc(true, "PaGlobal_PlayMusic_All_ShowAni()")
  Panel_Widget_PlayMusic_All:RegisterShowEventFunc(false, "PaGlobal_PlayMusic_All_HideAni()")
  self._ui._btn_Close:addInputEvent("Mouse_LUp", "PaGlobal_PlayMusic_All_StopMusic()")
  self._ui._btn_Close:addInputEvent("Mouse_On", "PaGlobal_PlayMusic_All_ShowBubbleBox()")
  self._ui._btn_Close:addInputEvent("Mouse_Out", "PaGlobal_PlayMusic_All_HideBubbleBox()")
end
function PaGlobal_PlayMusic_All:prepareOpen()
  if nil == Panel_Widget_PlayMusic_All then
    return
  end
  if not ToClient_IsPopUpToggle() then
    return
  end
  if isGameTypeKR2() then
    return
  end
  audioPostEvent_SystemUi(13, 6)
  _AudioPostEvent_SystemUiForXBOX(13, 6)
  self:resize()
  self:setPos()
  PaGlobal_PlayMusic_All:open()
end
function PaGlobal_PlayMusic_All:open()
  if nil == Panel_Widget_PlayMusic_All then
    return
  end
  Panel_Widget_PlayMusic_All:SetShow(true)
end
function PaGlobal_PlayMusic_All:prepareClose()
  if nil == Panel_Widget_PlayMusic_All then
    return
  end
  audioPostEvent_SystemUi(13, 5)
  _AudioPostEvent_SystemUiForXBOX(13, 5)
  PaGlobal_PlayMusic_All:close()
end
function PaGlobal_PlayMusic_All:close()
  if nil == Panel_Widget_PlayMusic_All then
    return
  end
  Panel_Widget_PlayMusic_All:SetShow(false)
end
function PaGlobal_PlayMusic_All:update()
  if nil == Panel_Widget_PlayMusic_All then
    return
  end
end
function PaGlobal_PlayMusic_All:validate()
  if nil == Panel_Widget_PlayMusic_All then
    return
  end
end
function PaGlobal_PlayMusic_All:resize()
  if nil == Panel_Widget_PlayMusic_All then
    return
  end
  Panel_Widget_PlayMusic_All:SetPosX(getScreenSizeX() * 0.5 - Panel_Widget_PlayMusic_All:GetSizeX() * 0.5)
  Panel_Widget_PlayMusic_All:SetPosY(getScreenSizeY() * 0.5 - Panel_Widget_PlayMusic_All:GetSizeY() * 0.5)
end
