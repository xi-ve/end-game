function PaGlobal_GreatSeaEvent:init()
  self._ui._progressBar = UI.getChildControl(Panel_Widget_GreatSeaEvent_ProgressBar, "Progress2_1")
  self._ui._stcText_Research = UI.getChildControl(Panel_Widget_GreatSeaEvent_ProgressBar, "StaticText_Research_Text")
  self._ui._resultBackGround = UI.getChildControl(Panel_Widget_GreatSeaEvent, "Static_ResurtBG")
  self._ui._txt_subTitle = UI.getChildControl(self._ui._resultBackGround, "StaticText_SubTitle")
  self._ui._resultImage = UI.getChildControl(self._ui._resultBackGround, "Static_ResurtImage")
  self._ui._txt_need = UI.getChildControl(self._ui._resultBackGround, "StaticText_Resource")
  self._ui._txt_result = UI.getChildControl(self._ui._resultBackGround, "StaticText_GetItem")
  self._ui._btn_ok = UI.getChildControl(self._ui._resultBackGround, "Button_Confirm")
  self._ui._txt_seafaringMainDesc = UI.getChildControl(Panel_Widget_SeafaringResearch, "StaticText_MainDesc")
  self._ui._txt_seafaringSubDesc = UI.getChildControl(Panel_Widget_SeafaringResearch, "StaticText_SubDesc")
  local textSizeX = self._ui._stcText_Research:GetTextSizeX()
  if textSizeX > self._ui._stcText_Research:GetSizeX() then
    self._ui._stcText_Research:SetSize(textSizeX + 20, self._ui._stcText_Research:GetSizeY())
    self._ui._stcText_Research:SetHorizonCenter()
  end
  self:clear()
  self:registEventHandler()
end
function PaGlobal_GreatSeaEvent:close()
  self:clear()
  audioPostEvent_SystemUi(26, 4)
  _AudioPostEvent_SystemUiForXBOX(26, 4)
  Panel_Widget_GreatSeaEvent:SetShow(false)
end
function PaGlobal_GreatSeaEvent:clear()
  self._updateCurrentTime = 0
  self._regionKey = 0
  self._isSearch = false
  self._currentSeafaringTime = 0
end
function PaGlobal_GreatSeaEvent:requestGreatSeaEvent(isSearch)
  local reamainCooltime = ToClient_getGrateSeaEventCooltime()
  if 0 < reamainCooltime then
    local minute = math.floor(reamainCooltime / 60)
    local second = math.floor(reamainCooltime % 60)
    if isSearch then
      Proc_ShowMessage_Ack(PAGetStringParam2(Defines.StringSheet_GAME, "LUA_EMPLOYEE_EXPLORE_COOLTIME", "minute", tostring(minute), "second", tostring(second)))
    else
      Proc_ShowMessage_Ack(PAGetStringParam2(Defines.StringSheet_GAME, "LUA_FOOD_SUPPLY_ISLAND_COOLTIME", "minute", tostring(minute), "second", tostring(second)))
    end
    return
  end
  audioPostEvent_SystemUi(26, 8)
  _AudioPostEvent_SystemUiForXBOX(26, 8)
  self:clear()
  self._isSearch = isSearch
  if isSearch then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_EMPLOYEE_EXPLORE"))
  else
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_FOOD_SUPPLY_ISLAND"))
  end
  Panel_Widget_GreatSeaEvent_ProgressBar:SetShow(true)
  Panel_Widget_GreatSeaEvent_ProgressBar:RegisterUpdateFunc("Update_GreatSeaEvent_ProgressBar")
  audioPostEvent_SystemUi(26, 3)
  _AudioPostEvent_SystemUiForXBOX(26, 3)
end
function PaGlobal_GreatSeaEvent:progressBarUpdateComplete()
  Panel_Widget_GreatSeaEvent_ProgressBar:SetShow(false)
  Panel_Widget_GreatSeaEvent_ProgressBar:ClearUpdateLuaFunc("Update_GreatSeaEvent_ProgressBar")
  if self._isSearch then
    audioPostEvent_SystemUi(26, 8)
    _AudioPostEvent_SystemUiForXBOX(26, 8)
  end
  ToClient_requestGreatSeaEvent(self._isSearch)
end
function PaGlobal_GreatSeaEvent:registEventHandler()
  self._ui._btn_ok:addInputEvent("Mouse_LUp", "PaGlobal_GreatSeaEvent:close()")
  Panel_Widget_SeafaringResearch:RegisterShowEventFunc(true, "PaGloabl_SeafaringResearch_ShowAni()")
  Panel_Widget_SeafaringResearch:RegisterShowEventFunc(false, "PaGloabl_SeafaringResearch_HideAni()")
  registerEvent("FromClient_GreatSeaEvent", "FromClient_GreatSeaEvent")
end
function PaGlobal_GreatSeaEvent:openSeafaringResearchPanel()
  self._currentSeafaringTime = 0
  Panel_Widget_SeafaringResearch:SetShow(true, true)
  Panel_Widget_SeafaringResearch:RegisterUpdateFunc("HandleEventUpdate_SeafaringResearch_UpdateFrame")
end
function PaGlobal_GreatSeaEvent:closeSeafaringResearchPanel()
  Panel_Widget_SeafaringResearch:SetShow(false, true)
  Panel_Widget_SeafaringResearch:ClearUpdateLuaFunc("HandleEventUpdate_SeafaringResearch_UpdateFrame")
end
