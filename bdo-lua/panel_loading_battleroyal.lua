local _panel = Panel_Loading
local battleRoyalTipString = {
  [0] = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_BATTLEROYAL_GUIDE_TIP_1"),
  [1] = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_BATTLEROYAL_GUIDE_TIP_2"),
  [2] = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_BATTLEROYAL_GUIDE_TIP_3"),
  [3] = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_BATTLEROYAL_GUIDE_TIP_4"),
  [4] = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_BATTLEROYAL_GUIDE_TIP_5"),
  [5] = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_BATTLEROYAL_GUIDE_TIP_6"),
  [6] = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_BATTLEROYAL_GUIDE_TIP_7"),
  [7] = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_BATTLEROYAL_GUIDE_KEY_1"),
  [8] = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_BATTLEROYAL_GUIDE_KEY_2"),
  [9] = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_BATTLEROYAL_GUIDE_KEY_3"),
  [10] = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_BATTLEROYAL_GUIDE_KEY_4"),
  [11] = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_BATTLEROYAL_GUIDE_KEY_5"),
  [12] = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_BATTLEROYAL_GUIDE_KEY_6"),
  [13] = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_BATTLEROYAL_GUIDE_KEY_7"),
  [14] = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_BATTLEROYAL_GUIDE_KEY_8"),
  [15] = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_BATTLEROYAL_GUIDE_KEY_9"),
  [16] = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_BATTLEROYAL_GUIDE_KEY_10")
}
local loadingRandomGuideStrings = {
  [1] = PAGetString(Defines.StringSheet_RESOURCE, "SA_PANEL_LOADING_RANDOM_GUIDE_1"),
  [2] = PAGetString(Defines.StringSheet_RESOURCE, "SA_PANEL_LOADING_RANDOM_GUIDE_2"),
  [3] = PAGetString(Defines.StringSheet_RESOURCE, "SA_PANEL_LOADING_RANDOM_GUIDE_3"),
  [4] = PAGetString(Defines.StringSheet_RESOURCE, "SA_PANEL_LOADING_RANDOM_GUIDE_4"),
  [5] = PAGetString(Defines.StringSheet_RESOURCE, "SA_PANEL_LOADING_RANDOM_GUIDE_5"),
  [6] = PAGetString(Defines.StringSheet_RESOURCE, "SA_PANEL_LOADING_RANDOM_GUIDE_6"),
  [7] = PAGetString(Defines.StringSheet_RESOURCE, "SA_PANEL_LOADING_RANDOM_GUIDE_7"),
  [8] = PAGetString(Defines.StringSheet_RESOURCE, "SA_PANEL_LOADING_RANDOM_GUIDE_8"),
  [9] = PAGetString(Defines.StringSheet_RESOURCE, "SA_PANEL_LOADING_RANDOM_GUIDE_9"),
  [10] = PAGetString(Defines.StringSheet_RESOURCE, "SA_PANEL_LOADING_RANDOM_GUIDE_10"),
  [11] = PAGetString(Defines.StringSheet_RESOURCE, "SA_PANEL_LOADING_RANDOM_GUIDE_11"),
  [12] = PAGetString(Defines.StringSheet_RESOURCE, "SA_PANEL_LOADING_RANDOM_GUIDE_12"),
  [13] = PAGetString(Defines.StringSheet_RESOURCE, "SA_PANEL_LOADING_RANDOM_GUIDE_13"),
  [14] = PAGetString(Defines.StringSheet_RESOURCE, "SA_PANEL_LOADING_RANDOM_GUIDE_14")
}
local battleRoyalLoading = {
  _ui = {
    stc_loadingBackText = UI.getChildControl(Panel_Loading, "Static_BackImage"),
    progress_loading = UI.getChildControl(Panel_Loading, "Progress2_Loading"),
    txt_randomGuide = UI.getChildControl(Panel_Loading, "StaticText_RandomGuide")
  },
  _maxCount = 17,
  _elapsedTime = 0,
  _changeGuidTime = 6,
  _currentStringTip = 1
}
function battleRoyalLoading:init()
  _panel:SetShow(true, false)
  self:resizePanel()
  self:registEventHandler()
end
function battleRoyalLoading:resizePanel()
  Panel_Loading:SetSize(getScreenSizeX(), getScreenSizeY())
  Panel_Loading:ComputePosAllChild()
end
function battleRoyalLoading:registEventHandler()
  _panel:RegisterUpdateFunc("LoadingPanel_UpdatePerFrame")
end
function LoadingPanel_UpdatePerFrame(deltaTime)
  if true == ToClient_IsDevelopment() then
    return
  end
  battleRoyalLoading._elapsedTime = battleRoyalLoading._elapsedTime + deltaTime
  if battleRoyalLoading._changeGuidTime <= battleRoyalLoading._elapsedTime then
    battleRoyalLoading._elapsedTime = 0
    battleRoyalLoading._currentStringTip = battleRoyalLoading._currentStringTip + 1
    if #loadingRandomGuideStrings < battleRoyalLoading._currentStringTip then
      battleRoyalLoading._currentStringTip = 1
    end
    local guideString = loadingRandomGuideStrings[battleRoyalLoading._currentStringTip]
    battleRoyalLoading._ui.txt_randomGuide:SetText(guideString)
    battleRoyalLoading._ui.txt_randomGuide:ComputePos()
  end
end
function LoadingPanel_SetProgress(rate)
  if true == ToClient_IsDevelopment() then
    return
  end
  battleRoyalLoading._ui.progress_loading:SetProgressRate(rate)
end
function PaGlobalFunc_battleRoyalLoading_Init()
  local self = battleRoyalLoading
  if nil == self then
    return
  end
  self:init()
end
registerEvent("FromClient_luaLoadCompleteLateUdpate", "PaGlobalFunc_battleRoyalLoading_Init")
registerEvent("EventMapLoadProgress", "LoadingPanel_SetProgress")
