PaGlobal_SeasonBanner = {
  _ui = {
    stc_blackBG = nil,
    stc_pageBG = {},
    stc_pageBG1 = nil,
    stc_pageBG2 = nil,
    stc_pageBG3 = nil,
    stc_pageBG = nil,
    btn_left = nil,
    btn_right = nil,
    stc_keyguideBG = nil
  },
  _pageCount = 3,
  _startPageNo = 1,
  _endPageNo = 3,
  _currentPageNo = 1,
  _isConsole = false,
  _initialize = false
}
runLua("UI_Data/Script/Window/Season/Panel_Window_SeasonBanner_1.lua")
runLua("UI_Data/Script/Window/Season/Panel_Window_SeasonBanner_2.lua")
function FromClient_SeasonBanner_Init()
  PaGlobal_SeasonBanner:initialize()
end
FromClient_SeasonBanner_Init()
