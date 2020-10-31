local UI_ANI_ADV = CppEnums.PAUI_ANIM_ADVANCE_TYPE
local UI_PP = CppEnums.PAUIMB_PRIORITY
local UI_PSFT = CppEnums.PAUI_SHOW_FADE_TYPE
local UI_color = Defines.Color
PaGlobal_AskKnowledge = {
  _ui = {
    list2_Knowledge = nil,
    stc_BottomBG = nil,
    txt_KeyGuideA = nil,
    txt_KeyGuideB = nil
  }
}
function PaGlobal_AskKnowledge:initialize()
  self._ui.list2_Knowledge = UI.getChildControl(Panel_AskKnowledge, "List2_Knowledge")
  self._ui.stc_BottomBG = UI.getChildControl(Panel_AskKnowledge, "Static_KeyGuideBG")
  self._ui.txt_KeyGuideA = UI.getChildControl(self._ui.stc_BottomBG, "StaticText_A_ConsoleUI")
  self._ui.txt_KeyGuideB = UI.getChildControl(self._ui.stc_BottomBG, "StaticText_B_ConsoleUI")
  local keyGuides = {
    self._ui.txt_KeyGuideA,
    self._ui.txt_KeyGuideB
  }
  PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyGuides, self._ui.stc_BottomBG, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHT)
end
function PaGlobal_AskKnowledge:registEvent()
  Panel_AskKnowledge:SetShow(false, false)
  Panel_AskKnowledge:setMaskingChild(true)
  Panel_AskKnowledge:ActiveMouseEventEffect(true)
  Panel_AskKnowledge:setGlassBackground(true)
  Panel_AskKnowledge:ignorePadSnapMoveToOtherPanel()
  Panel_AskKnowledge:RegisterShowEventFunc(true, "AskKnowledgeShowAni()")
  Panel_AskKnowledge:RegisterShowEventFunc(false, "AskKnowledgeHideAni()")
  self._ui.list2_Knowledge:registEvent(__ePAUIList2EventType_LuaChangeContent, "PaGlobal_AskKnowledge_CreateContents")
  self._ui.list2_Knowledge:createChildContent(__ePAUIList2ElementManagerType_List)
  registerEvent("FromClient_AskKnowledge", "FromClient_AskKnowledge")
end
function PaGlobal_AskKnowledge:open()
  Panel_AskKnowledge:SetShow(true, true)
end
function PaGlobal_AskKnowledge:close()
  Panel_AskKnowledge:SetShow(false, false)
end
function PaGlobal_AskKnowledge:update()
  local count = ToClient_GetKnowledgeSize()
  self._ui.list2_Knowledge:getElementManager():clearKey()
  for index = 0, count do
    self._ui.list2_Knowledge:getElementManager():pushKey(toInt64(0, index))
  end
end
function FromClient_AskKnowledge()
  PaGlobal_AskKnowledge:open()
  PaGlobal_AskKnowledge:update()
end
function PaGlobal_AskKnowledge_CreateContents(contents, key)
  local index = Int64toInt32(key)
  local button = UI.getChildControl(contents, "Style_Button")
  local data = ToClient_GetKnowledgeStatus(index)
  if nil == data then
    PaGlobal_AskKnowledge._ui.list2_Knowledge:getElementManager():removeKey(key)
  end
  button:SetText(data:getName())
  button:addInputEvent("Mouse_LUp", "HandleEventLUp_AskKnowledge_Ask(" .. index .. ")")
end
function HandleEventLUp_AskKnowledge_Ask(index)
  PaGlobal_AskKnowledge:close()
  local clickedKnowledge = ToClient_GetKnowledgeStatus(index)
  local pos = clickedKnowledge:getPosition()
  setShowNpcDialog(false)
  if _ContentsGroup_RenewUI then
    if true == _ContentsGroup_NewUI_Dialog_All then
      PaGlobalFunc_DialogMain_All_Close()
    else
      PaGlobalFunc_MainDialog_Hide()
    end
    PaGlobalFunc_WorldMap_Open()
    FromClient_RClickWorldmapPanel(pos, true, false)
  else
    FGlobal_PushOpenWorldMap()
    FromClient_KnowledgeWorldMapPath(float3(pos.x, 0, pos.z))
  end
end
function AskKnowledgeShowAni()
  UIAni.fadeInSCR_Down(Panel_AskKnowledge)
  audioPostEvent_SystemUi(1, 0)
  _AudioPostEvent_SystemUiForXBOX(1, 0)
end
function AskKnowledgeHideAni()
  Panel_AskKnowledge:SetShowWithFade(CppEnums.PAUI_SHOW_FADE_TYPE.PAUI_ANI_TYPE_FADE_OUT)
  local aniInfo1 = Panel_AskKnowledge:addColorAnimation(0, 0.22, UI_ANI_ADV.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
  aniInfo1:SetStartColor(Defines.Color.C_FFFFFFFF)
  aniInfo1:SetEndColor(Defines.Color.C_00FFFFFF)
  aniInfo1:SetStartIntensity(3)
  aniInfo1:SetEndIntensity(1)
  aniInfo1.IsChangeChild = true
  aniInfo1:SetHideAtEnd(true)
  aniInfo1:SetDisableWhileAni(true)
  audioPostEvent_SystemUi(1, 1)
  _AudioPostEvent_SystemUiForXBOX(1, 1)
end
function PaGlobal_AskKnowledge_Init()
  PaGlobal_AskKnowledge:initialize()
  PaGlobal_AskKnowledge:registEvent()
end
registerEvent("FromClient_luaLoadComplete", "PaGlobal_AskKnowledge_Init")
