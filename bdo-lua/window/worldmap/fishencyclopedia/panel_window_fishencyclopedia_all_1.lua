function PaGlobal_FishEncyclopedia_All:initialize()
  if nil == Panel_Window_FishEncyclopedia_All or true == PaGlobal_FishEncyclopedia_All._initialize then
    return
  end
  PaGlobal_FishEncyclopedia_All._isConsole = _ContentsGroup_UsePadSnapping
  PaGlobal_FishEncyclopedia_All:controlInit()
  PaGlobal_FishEncyclopedia_All:setConsoleUI()
  HandleEventLUp_FishEncyclopedia_All_SelectTab(1)
  PaGlobal_FishEncyclopedia_All:registerEventHandler()
  PaGlobal_FishEncyclopedia_All:validate()
  PaGlobal_FishEncyclopedia_All._initialize = true
end
function PaGlobal_FishEncyclopedia_All:controlInit()
  PaGlobal_FishEncyclopedia_All._ui.stc_topBg = UI.getChildControl(Panel_Window_FishEncyclopedia_All, "Static_TopBg")
  PaGlobal_FishEncyclopedia_All._ui.btn_question = UI.getChildControl(PaGlobal_FishEncyclopedia_All._ui.stc_topBg, "Button_Question")
  PaGlobal_FishEncyclopedia_All._ui.btn_close = UI.getChildControl(PaGlobal_FishEncyclopedia_All._ui.stc_topBg, "Button_Close")
  PaGlobal_FishEncyclopedia_All._ui.stc_radioButtonBg_PC = UI.getChildControl(Panel_Window_FishEncyclopedia_All, "Static_RadioButtonBg_PCUI")
  PaGlobal_FishEncyclopedia_All._ui.stc_radioButtonBg_Console = UI.getChildControl(Panel_Window_FishEncyclopedia_All, "Static_RadioButtonBg_ConsoleUI")
  if true == PaGlobal_FishEncyclopedia_All._isConsole then
    for index = 1, PaGlobal_FishEncyclopedia_All._maxTabCount do
      PaGlobal_FishEncyclopedia_All._ui.radiobuttons_Console[index] = UI.getChildControl(PaGlobal_FishEncyclopedia_All._ui.stc_radioButtonBg_Console, "RadioButton_" .. index)
    end
    PaGlobal_FishEncyclopedia_All._ui.stc_LB_Console = UI.getChildControl(PaGlobal_FishEncyclopedia_All._ui.stc_radioButtonBg_Console, "Static_LB_ConsoleUI")
    PaGlobal_FishEncyclopedia_All._ui.stc_RB_Console = UI.getChildControl(PaGlobal_FishEncyclopedia_All._ui.stc_radioButtonBg_Console, "Static_RB_ConsoleUI")
    PaGlobal_FishEncyclopedia_All._ui.stc_selectLine_Console = UI.getChildControl(PaGlobal_FishEncyclopedia_All._ui.stc_radioButtonBg_Console, "Static_SelectLine")
  else
    for index = 1, PaGlobal_FishEncyclopedia_All._maxTabCount do
      PaGlobal_FishEncyclopedia_All._ui.radiobuttons_PC[index] = UI.getChildControl(PaGlobal_FishEncyclopedia_All._ui.stc_radioButtonBg_PC, "RadioButton_" .. index)
    end
    PaGlobal_FishEncyclopedia_All._ui.stc_selectLine_PC = UI.getChildControl(PaGlobal_FishEncyclopedia_All._ui.stc_radioButtonBg_PC, "Static_SelectLine")
  end
  PaGlobal_FishEncyclopedia_All._ui.stc_midBg = UI.getChildControl(Panel_Window_FishEncyclopedia_All, "Static_MidBg")
  PaGlobal_FishEncyclopedia_All._ui.stc_pageBtnBg = UI.getChildControl(Panel_Window_FishEncyclopedia_All, "Static_PageBtnBg")
  PaGlobal_FishEncyclopedia_All._ui.txt_achivementValue = UI.getChildControl(PaGlobal_FishEncyclopedia_All._ui.stc_pageBtnBg, "StaticText_ValuePercent")
  PaGlobal_FishEncyclopedia_All._ui.progress_achivementRate = UI.getChildControl(PaGlobal_FishEncyclopedia_All._ui.stc_pageBtnBg, "Progress2_1")
  PaGlobal_FishEncyclopedia_All._ui.txt_pageNumber = UI.getChildControl(PaGlobal_FishEncyclopedia_All._ui.stc_pageBtnBg, "StaticText_PageNumber")
  PaGlobal_FishEncyclopedia_All._ui.btn_leftPage_PC = UI.getChildControl(PaGlobal_FishEncyclopedia_All._ui.stc_pageBtnBg, "Button_LeftPage_PCUI")
  PaGlobal_FishEncyclopedia_All._ui.btn_rightPage_PC = UI.getChildControl(PaGlobal_FishEncyclopedia_All._ui.stc_pageBtnBg, "Button_RightPage_PCUI")
  PaGlobal_FishEncyclopedia_All._ui.stc_DpadLeft_Console = UI.getChildControl(PaGlobal_FishEncyclopedia_All._ui.stc_pageBtnBg, "Static_DpadLeft_ConsoleUI")
  PaGlobal_FishEncyclopedia_All._ui.stc_DpadRight_Console = UI.getChildControl(PaGlobal_FishEncyclopedia_All._ui.stc_pageBtnBg, "Static_DpadRight_ConsoleUI")
  local left = {}
  left.stc_BG = UI.getChildControl(Panel_Window_FishEncyclopedia_All, "Static_Left")
  left.txt_fishNameText = UI.getChildControl(left.stc_BG, "StaticText_FishNameValue")
  local icons = {}
  for ii = 1, PaGlobal_FishEncyclopedia_All._maxRateCount do
    icons[ii] = UI.getChildControl(left.stc_BG, "Static_RateIcon" .. ii)
  end
  left.stc_rareIcons = icons
  left.txt_fishDesc = UI.getChildControl(left.stc_BG, "StaticText_FishExplanation")
  left.txt_fishDesc:SetTextMode(__eTextMode_Limit_AutoWrap)
  left.txt_fishDesc:setLineCountByLimitAutoWrap(4)
  left.txt_fishArea = UI.getChildControl(left.stc_BG, "StaticText_PlaceValue")
  left.txt_fishCount = UI.getChildControl(left.stc_BG, "StaticText_NumberValue")
  left.txt_maximumSize = UI.getChildControl(left.stc_BG, "StaticText_MaximumSizeValue")
  left.stc_fishImage = UI.getChildControl(left.stc_BG, "Static_FishImage")
  left.stc_bottom = UI.getChildControl(left.stc_BG, "Static_Bottom")
  local sizeRank = {}
  local rankText = {}
  local characterText = {}
  local valueText = {}
  for ii = 1, PaGlobal_FishEncyclopedia_All._maxRankSlotCount do
    rankText[ii] = UI.getChildControl(left.stc_bottom, "StaticText_Ranking" .. ii)
    characterText[ii] = UI.getChildControl(left.stc_bottom, "StaticText_CharacterName" .. ii)
    valueText[ii] = UI.getChildControl(left.stc_bottom, "StaticText_Value" .. ii)
  end
  sizeRank.txt_rank = rankText
  sizeRank.txt_character = characterText
  sizeRank.txt_value = valueText
  left.stc_sizeRank = sizeRank
  left.txt_noCatch = UI.getChildControl(left.stc_bottom, "StaticText_NoCatch")
  left.txt_noCatch:SetTextMode(__eTextMode_AutoWrap)
  left.txt_noCatch:SetText(left.txt_noCatch:GetText())
  PaGlobal_FishEncyclopedia_All._ui.stc_pageLeft = left
  local right = {}
  right.stc_BG = UI.getChildControl(Panel_Window_FishEncyclopedia_All, "Static_Right")
  right.txt_fishNameText = UI.getChildControl(right.stc_BG, "StaticText_FishNameValue")
  local icons = {}
  for ii = 1, PaGlobal_FishEncyclopedia_All._maxRateCount do
    icons[ii] = UI.getChildControl(right.stc_BG, "Static_RateIcon" .. ii)
  end
  right.stc_rareIcons = icons
  right.txt_fishDesc = UI.getChildControl(right.stc_BG, "StaticText_FishExplanation")
  right.txt_fishDesc:SetTextMode(__eTextMode_Limit_AutoWrap)
  right.txt_fishDesc:setLineCountByLimitAutoWrap(4)
  right.txt_fishArea = UI.getChildControl(right.stc_BG, "StaticText_PlaceValue")
  right.txt_fishCount = UI.getChildControl(right.stc_BG, "StaticText_NumberValue")
  right.txt_maximumSize = UI.getChildControl(right.stc_BG, "StaticText_MaximumSizeValue")
  right.stc_fishImage = UI.getChildControl(right.stc_BG, "Static_FishImage")
  right.stc_bottom = UI.getChildControl(right.stc_BG, "Static_Bottom")
  local sizeRank = {}
  local rankText = {}
  local characterText = {}
  local valueText = {}
  for ii = 1, PaGlobal_FishEncyclopedia_All._maxRankSlotCount do
    rankText[ii] = UI.getChildControl(right.stc_bottom, "StaticText_Ranking" .. ii)
    characterText[ii] = UI.getChildControl(right.stc_bottom, "StaticText_CharacterName" .. ii)
    valueText[ii] = UI.getChildControl(right.stc_bottom, "StaticText_Value" .. ii)
  end
  sizeRank.txt_rank = rankText
  sizeRank.txt_character = characterText
  sizeRank.txt_value = valueText
  right.stc_sizeRank = sizeRank
  right.txt_noCatch = UI.getChildControl(right.stc_bottom, "StaticText_NoCatch")
  right.txt_noCatch:SetTextMode(__eTextMode_AutoWrap)
  right.txt_noCatch:SetText(right.txt_noCatch:GetText())
  PaGlobal_FishEncyclopedia_All._ui.stc_pageRight = right
  PaGlobal_FishEncyclopedia_All._ui.stc_bottomBg_Console = UI.getChildControl(Panel_Window_FishEncyclopedia_All, "Static_BottomBg_ConsoleUI")
  PaGlobal_FishEncyclopedia_All._ui.btn_close_console = UI.getChildControl(PaGlobal_FishEncyclopedia_All._ui.stc_bottomBg_Console, "Button_B_ConsoleUI")
  PaGlobal_FishEncyclopedia_All._ui.btn_detail_console = UI.getChildControl(PaGlobal_FishEncyclopedia_All._ui.stc_bottomBg_Console, "Button_X_ConsoleUI")
  PaGlobal_FishEncyclopedia_All._ui.stc_tooltip_left.bg = UI.getChildControl(left.stc_BG, "Static_SimpleTooltip")
  PaGlobal_FishEncyclopedia_All._ui.stc_tooltip_left.name = UI.getChildControl(PaGlobal_FishEncyclopedia_All._ui.stc_tooltip_left.bg, "Tooltip_Name")
  PaGlobal_FishEncyclopedia_All._ui.stc_tooltip_left.desc = UI.getChildControl(PaGlobal_FishEncyclopedia_All._ui.stc_tooltip_left.bg, "Tooltip_Description")
  PaGlobal_FishEncyclopedia_All._ui.stc_tooltip_right.bg = UI.getChildControl(right.stc_BG, "Static_SimpleTooltip")
  PaGlobal_FishEncyclopedia_All._ui.stc_tooltip_right.name = UI.getChildControl(PaGlobal_FishEncyclopedia_All._ui.stc_tooltip_right.bg, "Tooltip_Name")
  PaGlobal_FishEncyclopedia_All._ui.stc_tooltip_right.desc = UI.getChildControl(PaGlobal_FishEncyclopedia_All._ui.stc_tooltip_right.bg, "Tooltip_Description")
  PaGlobal_FishEncyclopedia_All._ui.stc_tooltip_left.name:SetTextMode(__eTextMode_AutoWrap)
  PaGlobal_FishEncyclopedia_All._ui.stc_tooltip_left.desc:SetTextMode(__eTextMode_AutoWrap)
  PaGlobal_FishEncyclopedia_All._ui.stc_tooltip_right.name:SetTextMode(__eTextMode_AutoWrap)
  PaGlobal_FishEncyclopedia_All._ui.stc_tooltip_right.desc:SetTextMode(__eTextMode_AutoWrap)
end
function PaGlobal_FishEncyclopedia_All:setConsoleUI()
  if true == PaGlobal_FishEncyclopedia_All._isConsole then
    PaGlobal_FishEncyclopedia_All._ui.stc_bottomBg_Console:SetShow(true)
    PaGlobal_FishEncyclopedia_All._ui.stc_radioButtonBg_PC:SetShow(false)
    PaGlobal_FishEncyclopedia_All._ui.stc_radioButtonBg_Console:SetShow(true)
    PaGlobal_FishEncyclopedia_All._ui.btn_leftPage_PC:SetShow(false)
    PaGlobal_FishEncyclopedia_All._ui.btn_rightPage_PC:SetShow(false)
    PaGlobal_FishEncyclopedia_All._ui.btn_close:SetShow(false)
    PaGlobal_FishEncyclopedia_All._ui.btn_question:SetShow(false)
    local keyGuides = {
      PaGlobal_FishEncyclopedia_All._ui.btn_detail_console,
      PaGlobal_FishEncyclopedia_All._ui.btn_close_console
    }
    PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyGuides, PaGlobal_FishEncyclopedia_All._ui.stc_bottomBg_Console, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHT)
  else
    PaGlobal_FishEncyclopedia_All._ui.stc_bottomBg_Console:SetShow(false)
    PaGlobal_FishEncyclopedia_All._ui.stc_radioButtonBg_PC:SetShow(true)
    PaGlobal_FishEncyclopedia_All._ui.stc_radioButtonBg_Console:SetShow(false)
    PaGlobal_FishEncyclopedia_All._ui.stc_DpadLeft_Console:SetShow(false)
    PaGlobal_FishEncyclopedia_All._ui.stc_DpadRight_Console:SetShow(false)
  end
end
function PaGlobal_FishEncyclopedia_All:registerEventHandler()
  if nil == Panel_Window_FishEncyclopedia_All then
    return
  end
  PaGlobal_FishEncyclopedia_All._ui.btn_close:addInputEvent("Mouse_LUp", "PaGlobalFunc_FishEncyclopedia_All_Close()")
  if true == PaGlobal_FishEncyclopedia_All._isConsole then
    Panel_Window_FishEncyclopedia_All:registerPadEvent(__eConsoleUIPadEvent_LB, "PaGlobalFunc_FishEncyclopedia_All_MoveTapByPad(true)")
    Panel_Window_FishEncyclopedia_All:registerPadEvent(__eConsoleUIPadEvent_RB, "PaGlobalFunc_FishEncyclopedia_All_MoveTapByPad(false)")
    Panel_Window_FishEncyclopedia_All:registerPadEvent(__eConsoleUIPadEvent_DpadLeft, "HandleEventLUp_FishEncyclopedia_All_PageMove(true)")
    Panel_Window_FishEncyclopedia_All:registerPadEvent(__eConsoleUIPadEvent_DpadRight, "HandleEventLUp_FishEncyclopedia_All_PageMove(false)")
  else
    for index = 1, PaGlobal_FishEncyclopedia_All._maxTabCount do
      PaGlobal_FishEncyclopedia_All._ui.radiobuttons_PC[index]:addInputEvent("Mouse_LUp", "HandleEventLUp_FishEncyclopedia_All_SelectTab(" .. index .. ")")
    end
    PaGlobal_FishEncyclopedia_All._ui.btn_leftPage_PC:addInputEvent("Mouse_LUp", "HandleEventLUp_FishEncyclopedia_All_PageMove(true)")
    PaGlobal_FishEncyclopedia_All._ui.btn_rightPage_PC:addInputEvent("Mouse_LUp", "HandleEventLUp_FishEncyclopedia_All_PageMove(false)")
    Panel_Window_FishEncyclopedia_All:addInputEvent("Mouse_UpScroll", "HandleEventLUp_FishEncyclopedia_All_PageMove(true)")
    Panel_Window_FishEncyclopedia_All:addInputEvent("Mouse_DownScroll", "HandleEventLUp_FishEncyclopedia_All_PageMove(false)")
    PaGlobal_FishEncyclopedia_All._ui.stc_pageBtnBg:addInputEvent("Mouse_UpScroll", "HandleEventLUp_FishEncyclopedia_All_PageMove(true)")
    PaGlobal_FishEncyclopedia_All._ui.stc_pageBtnBg:addInputEvent("Mouse_DownScroll", "HandleEventLUp_FishEncyclopedia_All_PageMove(false)")
    PaGlobal_FishEncyclopedia_All._ui.stc_pageLeft.stc_BG:addInputEvent("Mouse_UpScroll", "HandleEventLUp_FishEncyclopedia_All_PageMove(true)")
    PaGlobal_FishEncyclopedia_All._ui.stc_pageLeft.stc_BG:addInputEvent("Mouse_DownScroll", "HandleEventLUp_FishEncyclopedia_All_PageMove(false)")
    PaGlobal_FishEncyclopedia_All._ui.stc_pageRight.stc_BG:addInputEvent("Mouse_UpScroll", "HandleEventLUp_FishEncyclopedia_All_PageMove(true)")
    PaGlobal_FishEncyclopedia_All._ui.stc_pageRight.stc_BG:addInputEvent("Mouse_DownScroll", "HandleEventLUp_FishEncyclopedia_All_PageMove(false)")
    PaGlobal_FishEncyclopedia_All._ui.stc_pageLeft.txt_fishDesc:addInputEvent("Mouse_UpScroll", "HandleEventLUp_FishEncyclopedia_All_PageMove(true)")
    PaGlobal_FishEncyclopedia_All._ui.stc_pageLeft.txt_fishDesc:addInputEvent("Mouse_DownScroll", "HandleEventLUp_FishEncyclopedia_All_PageMove(false)")
    PaGlobal_FishEncyclopedia_All._ui.stc_pageRight.txt_fishDesc:addInputEvent("Mouse_UpScroll", "HandleEventLUp_FishEncyclopedia_All_PageMove(true)")
    PaGlobal_FishEncyclopedia_All._ui.stc_pageRight.txt_fishDesc:addInputEvent("Mouse_DownScroll", "HandleEventLUp_FishEncyclopedia_All_PageMove(false)")
  end
  registerEvent("onScreenResize", "FromClient_FishEncyclopedia_All_OnScreenSize")
  registerEvent("FromClient_ResponseFishTopRankingBody", "FromClient_FishEncyclopedia_All_ResponseFishTopRankingBody")
end
function PaGlobal_FishEncyclopedia_All:prepareOpen()
  if nil == Panel_Window_FishEncyclopedia_All then
    return
  end
  PaGlobal_FishEncyclopedia_All:update()
  PaGlobal_FishEncyclopedia_All:open()
end
function PaGlobal_FishEncyclopedia_All:open()
  if nil == Panel_Window_FishEncyclopedia_All or true == Panel_Window_FishEncyclopedia_All:GetShow() then
    return
  end
  Panel_Window_FishEncyclopedia_All:SetShow(true)
end
function PaGlobal_FishEncyclopedia_All:prepareClose()
  if nil == Panel_Window_FishEncyclopedia_All or false == Panel_Window_FishEncyclopedia_All:GetShow() then
    return
  end
  PaGlobal_FishEncyclopedia_All:close()
end
function PaGlobal_FishEncyclopedia_All:close()
  if nil == Panel_Window_FishEncyclopedia_All or false == Panel_Window_FishEncyclopedia_All:GetShow() then
    return
  end
  Panel_Window_FishEncyclopedia_All:SetShow(false)
end
function PaGlobal_FishEncyclopedia_All:update()
  PaGlobal_FishEncyclopedia_All:categoryParamIndexUpdate()
  PaGlobal_FishEncyclopedia_All:achivementUpdate()
  PaGlobal_FishEncyclopedia_All:pageUpdate()
  PaGlobal_FishEncyclopedia_All:contentsUpdate()
end
function PaGlobal_FishEncyclopedia_All:achivementUpdate()
  local totalFishCount = ToClient_GetTotalFishCount()
  local acquireFishCount = ToClient_GetAcquireFishCount()
  local rate = acquireFishCount / totalFishCount * 100
  PaGlobal_FishEncyclopedia_All._ui.progress_achivementRate:SetProgressRate(rate)
  local rateText = math.floor(rate)
  PaGlobal_FishEncyclopedia_All._ui.txt_achivementValue:SetText(rateText .. "%")
end
function PaGlobal_FishEncyclopedia_All:pageUpdate()
  local fishCount = ToClient_GetFishCountByCategory(PaGlobal_FishEncyclopedia_All._categoryParamIndex)
  local totalPage = math.ceil(fishCount / 2)
  if 0 == totalPage then
    totalPage = 1
  end
  if 1 > PaGlobal_FishEncyclopedia_All._currentPage then
    PaGlobal_FishEncyclopedia_All._currentPage = 1
  elseif totalPage < PaGlobal_FishEncyclopedia_All._currentPage then
    PaGlobal_FishEncyclopedia_All._currentPage = totalPage
  end
  if true == PaGlobal_FishEncyclopedia_All._isConsole then
    if 1 == PaGlobal_FishEncyclopedia_All._currentPage then
      PaGlobal_FishEncyclopedia_All._ui.stc_DpadLeft_Console:SetShow(false)
    else
      PaGlobal_FishEncyclopedia_All._ui.stc_DpadLeft_Console:SetShow(true)
    end
    if totalPage == PaGlobal_FishEncyclopedia_All._currentPage then
      PaGlobal_FishEncyclopedia_All._ui.stc_DpadRight_Console:SetShow(false)
    else
      PaGlobal_FishEncyclopedia_All._ui.stc_DpadRight_Console:SetShow(true)
    end
  else
    if 1 == PaGlobal_FishEncyclopedia_All._currentPage then
      PaGlobal_FishEncyclopedia_All._ui.btn_leftPage_PC:SetShow(false)
    else
      PaGlobal_FishEncyclopedia_All._ui.btn_leftPage_PC:SetShow(true)
    end
    if totalPage == PaGlobal_FishEncyclopedia_All._currentPage then
      PaGlobal_FishEncyclopedia_All._ui.btn_rightPage_PC:SetShow(false)
    else
      PaGlobal_FishEncyclopedia_All._ui.btn_rightPage_PC:SetShow(true)
    end
  end
  local pageStr = tostring(PaGlobal_FishEncyclopedia_All._currentPage) .. "/" .. tostring(totalPage)
  PaGlobal_FishEncyclopedia_All._ui.txt_pageNumber:SetText(pageStr)
end
function PaGlobal_FishEncyclopedia_All:contentsUpdate()
  local dataIndex = PaGlobal_FishEncyclopedia_All._currentPage * 2 - 2
  local fishInfoLeft = ToClient_GetFishAt(PaGlobal_FishEncyclopedia_All._categoryParamIndex, dataIndex)
  local fishInfoRight = ToClient_GetFishAt(PaGlobal_FishEncyclopedia_All._categoryParamIndex, dataIndex + 1)
  PaGlobal_FishEncyclopedia_All:fishUpdate(fishInfoLeft, dataIndex, true)
  PaGlobal_FishEncyclopedia_All:fishUpdate(fishInfoRight, dataIndex + 1, false)
  PaGlobalFunc_FishEncyclopedia_All_TooltipSimple_Hide(true)
  PaGlobalFunc_FishEncyclopedia_All_TooltipSimple_Hide(false)
  PaGlobal_FishEncyclopedia_All:setKeyGuide()
end
function PaGlobal_FishEncyclopedia_All:setKeyGuide()
  local isLimitLeft = PaGlobal_FishEncyclopedia_All._ui.stc_pageLeft.txt_fishDesc:IsLimitText()
  local isLimitRight = PaGlobal_FishEncyclopedia_All._ui.stc_pageRight.txt_fishDesc:IsLimitText()
  if isLimitLeft or isLimitRight then
    PaGlobal_FishEncyclopedia_All._ui.btn_detail_console:SetShow(true)
    Panel_Window_FishEncyclopedia_All:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandleEventXUp_FishEncyclopedia_All_ViewDetails()")
  else
    PaGlobal_FishEncyclopedia_All._ui.btn_detail_console:SetShow(false)
    Panel_Window_FishEncyclopedia_All:registerPadEvent(__eConsoleUIPadEvent_Up_X, "")
  end
end
function PaGlobal_FishEncyclopedia_All:categoryParamIndexUpdate()
  local index = PaGlobal_FishEncyclopedia_All._selectedTab
  if 1 == index then
    PaGlobal_FishEncyclopedia_All._categoryParamIndex = CppEnums.FishEncyclopediaCategory.eFishEncyclopediaCategory_FreshWaterFish
  elseif 2 == index then
    PaGlobal_FishEncyclopedia_All._categoryParamIndex = CppEnums.FishEncyclopediaCategory.eFishEncyclopediaCategory_SeaFish
  elseif 3 == index then
    PaGlobal_FishEncyclopedia_All._categoryParamIndex = CppEnums.FishEncyclopediaCategory.eFishEncyclopediaCategory_Crustacea
  elseif 4 == index then
    PaGlobal_FishEncyclopedia_All._categoryParamIndex = CppEnums.FishEncyclopediaCategory.eFishEncyclopediaCategory_Etc
  end
end
function PaGlobal_FishEncyclopedia_All:fishUpdate(fishInfo, dataIndex, isLeft)
  local fishSlot
  if true == isLeft then
    fishSlot = PaGlobal_FishEncyclopedia_All._ui.stc_pageLeft
  else
    fishSlot = PaGlobal_FishEncyclopedia_All._ui.stc_pageRight
  end
  if nil == fishInfo then
    fishSlot.stc_BG:SetShow(false)
    return
  end
  fishSlot.stc_BG:SetShow(true)
  if true == fishInfo:isAcquire() then
    fishSlot.txt_fishNameText:SetText(fishInfo:getName())
    fishSlot.stc_fishImage:ChangeTextureInfoName(fishInfo:getImagePath())
    local fishRareness = fishInfo:getRareness()
    for ii = 1, 5 do
      if ii <= fishRareness then
        fishSlot.stc_rareIcons[ii]:SetShow(true)
      else
        fishSlot.stc_rareIcons[ii]:SetShow(false)
      end
    end
    fishSlot.txt_fishArea:SetText("...")
    fishSlot.txt_fishCount:SetText(fishInfo:getCount())
    fishSlot.txt_maximumSize:SetText(fishInfo:getMaxValue())
    fishSlot.txt_fishDesc:SetText(fishInfo:getDesc())
    if true == fishSlot.txt_fishDesc:IsLimitText() then
      fishSlot.txt_fishDesc:SetIgnore(false)
      fishSlot.txt_fishDesc:addInputEvent("Mouse_On", "HandleEventOnOut_FishEncyclopedia_All_DescTooltip(" .. dataIndex .. "," .. tostring(isLeft) .. ", true)")
      fishSlot.txt_fishDesc:addInputEvent("Mouse_Out", "HandleEventOnOut_FishEncyclopedia_All_DescTooltip(" .. dataIndex .. "," .. tostring(isLeft) .. ", false)")
    else
      fishSlot.txt_fishDesc:SetIgnore(true)
      fishSlot.txt_fishDesc:addInputEvent("Mouse_On", "")
      fishSlot.txt_fishDesc:addInputEvent("Mouse_Out", "")
    end
    ToClient_RequestFishTopRankingBody(fishInfo:getKey())
    fishSlot.txt_noCatch:SetShow(false)
    PaGlobal_FishEncyclopedia_All:sizeRankUpdate(fishInfo:getKey(), isLeft)
  else
    fishSlot.txt_fishNameText:SetText("???")
    fishSlot.stc_fishImage:ChangeTextureInfoName("ui_artwork/encyclopedia/fish_undiscover.dds")
    for ii = 1, 5 do
      fishSlot.stc_rareIcons[ii]:SetShow(false)
    end
    fishSlot.txt_fishArea:SetText("...")
    fishSlot.txt_fishCount:SetText("...")
    fishSlot.txt_maximumSize:SetText("...")
    fishSlot.txt_fishDesc:SetText("???")
    fishSlot.txt_fishDesc:SetIgnore(true)
    fishSlot.txt_fishDesc:addInputEvent("Mouse_On", "")
    fishSlot.txt_fishDesc:addInputEvent("Mouse_Out", "")
    fishSlot.txt_noCatch:SetShow(true)
    PaGlobal_FishEncyclopedia_All:sizeRankUpdate(nil, isLeft)
  end
end
function PaGlobal_FishEncyclopedia_All:sizeRankUpdate(sizeRankKey, isLeft)
  local rankSlot
  if true == isLeft then
    rankSlot = PaGlobal_FishEncyclopedia_All._ui.stc_pageLeft.stc_sizeRank
  else
    rankSlot = PaGlobal_FishEncyclopedia_All._ui.stc_pageRight.stc_sizeRank
  end
  for rankIdx = 1, PaGlobal_FishEncyclopedia_All._maxRankSlotCount do
    rankSlot.txt_rank[rankIdx]:SetShow(false)
    rankSlot.txt_character[rankIdx]:SetShow(false)
    rankSlot.txt_value[rankIdx]:SetShow(false)
  end
  if nil == sizeRankKey then
    return
  end
  local selfPlayerNIckName = getSelfPlayer():getUserNickname()
  for rankIdx = 1, PaGlobal_FishEncyclopedia_All._maxRankSlotCount do
    local rankValue = ToClient_GetFishTopRankingValueInClient(sizeRankKey, rankIdx - 1)
    if nil ~= rankValue then
      local rankNickName = rankValue:getUserNickName()
      local rankName = rankValue:getCharacterName()
      local rankLength = rankValue.length
      if 0 ~= rankLength then
        rankSlot.txt_rank[rankIdx]:SetShow(true)
        rankSlot.txt_character[rankIdx]:SetShow(true)
        rankSlot.txt_value[rankIdx]:SetShow(true)
        rankSlot.txt_rank[rankIdx]:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_LIFERANKING_RANK", "listIdx", rankIdx))
        rankSlot.txt_character[rankIdx]:SetText(tostring(rankName .. " (" .. rankNickName .. ")"))
        rankSlot.txt_value[rankIdx]:SetText(tostring(rankLength))
        if selfPlayerNIckName == rankNickName then
          rankSlot.txt_rank[rankIdx]:SetFontColor(Defines.Color.C_FFF5BA3A)
          rankSlot.txt_character[rankIdx]:SetFontColor(Defines.Color.C_FFF5BA3A)
          rankSlot.txt_value[rankIdx]:SetFontColor(Defines.Color.C_FFF5BA3A)
        elseif 1 == rankIdx then
          rankSlot.txt_rank[rankIdx]:SetFontColor(Defines.Color.C_FFFFDD00)
          rankSlot.txt_character[rankIdx]:SetFontColor(Defines.Color.C_FFFFDD00)
          rankSlot.txt_value[rankIdx]:SetFontColor(Defines.Color.C_FFFFDD00)
        else
          rankSlot.txt_rank[rankIdx]:SetFontColor(Defines.Color.C_FFDDC39E)
          rankSlot.txt_character[rankIdx]:SetFontColor(Defines.Color.C_FFDDC39E)
          rankSlot.txt_value[rankIdx]:SetFontColor(Defines.Color.C_FFDDC39E)
        end
      end
    end
  end
end
function PaGlobal_FishEncyclopedia_All:validate()
  if nil == Panel_Window_FishEncyclopedia_All then
    return
  end
  PaGlobal_FishEncyclopedia_All._ui.stc_topBg:isValidate()
  PaGlobal_FishEncyclopedia_All._ui.btn_close:isValidate()
  if true == PaGlobal_FishEncyclopedia_All._isConsole then
    PaGlobal_FishEncyclopedia_All._ui.stc_radioButtonBg_Console:isValidate()
    PaGlobal_FishEncyclopedia_All._ui.stc_LB_Console:isValidate()
    PaGlobal_FishEncyclopedia_All._ui.stc_RB_Console:isValidate()
    PaGlobal_FishEncyclopedia_All._ui.stc_selectLine_Console:isValidate()
  else
    PaGlobal_FishEncyclopedia_All._ui.stc_radioButtonBg_PC:isValidate()
    PaGlobal_FishEncyclopedia_All._ui.stc_selectLine_PC:isValidate()
  end
  PaGlobal_FishEncyclopedia_All._ui.stc_midBg:isValidate()
  PaGlobal_FishEncyclopedia_All._ui.stc_pageBtnBg:isValidate()
  PaGlobal_FishEncyclopedia_All._ui.txt_achivementValue:isValidate()
  PaGlobal_FishEncyclopedia_All._ui.progress_achivementRate:isValidate()
  PaGlobal_FishEncyclopedia_All._ui.txt_pageNumber:isValidate()
  PaGlobal_FishEncyclopedia_All._ui.btn_leftPage_PC:isValidate()
  PaGlobal_FishEncyclopedia_All._ui.btn_rightPage_PC:isValidate()
  PaGlobal_FishEncyclopedia_All._ui.stc_DpadLeft_Console:isValidate()
  PaGlobal_FishEncyclopedia_All._ui.stc_DpadRight_Console:isValidate()
  PaGlobal_FishEncyclopedia_All._ui.stc_bottomBg_Console:isValidate()
end
