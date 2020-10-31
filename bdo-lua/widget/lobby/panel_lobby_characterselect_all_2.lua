function PaGlobalFunc_CharacterSelect_All_Open(charIdx)
  PaGlobal_CharacterSelect_All:prepareOpen(charIdx)
end
function PaGlobalFunc_CharacterSelect_All_Close()
  PaGlobal_CharacterSelect_All:prepareClose(charIdx)
end
function PaGlobalFunc_CharacterSelect_All_OnScreenResize()
  if true == PaGlobal_CharacterSelect_All._isUsePadSnapping then
    local resizedRatioY = getScreenSizeY() / Panel_CharacterSelect_All:GetSizeY()
    PaGlobal_CharacterSelect_All._ui.stc_KeyGuide_A:SetPosY(PaGlobal_CharacterSelect_All._ui.stc_KeyGuide_A:GetPosY() * resizedRatioY)
    PaGlobal_CharacterSelect_All._ui.stc_KeyGuide_B:SetPosY(PaGlobal_CharacterSelect_All._ui.stc_KeyGuide_B:GetPosY() * resizedRatioY)
    PaGlobal_CharacterSelect_All._ui.stc_KeyGuide_X:SetPosY(PaGlobal_CharacterSelect_All._ui.stc_KeyGuide_X:GetPosY() * resizedRatioY)
    PaGlobal_CharacterSelect_All._ui.stc_KeyGuide_Y:SetPosY(PaGlobal_CharacterSelect_All._ui.stc_KeyGuide_Y:GetPosY() * resizedRatioY)
    PaGlobal_CharacterSelect_All._ui.stc_KeyGuide_LBRB:SetPosY(PaGlobal_CharacterSelect_All._ui.stc_KeyGuide_LBRB:GetPosY() * resizedRatioY)
    PaGlobal_CharacterSelect_All._ui.txt_version:SetPosY(PaGlobal_CharacterSelect_All._ui.txt_version:GetPosY() * resizedRatioY)
    PaGlobal_CharacterSelect_All:keyguideAlign()
  end
  Panel_CharacterSelect_All:SetSize(getScreenSizeX(), getScreenSizeY())
  Panel_CharacterSelect_All:ComputePos()
  PaGlobal_CharacterSelect_All._ui.stc_Fade:SetSize(getScreenSizeX(), getScreenSizeY())
  local padding = 100
  local btnSize = PaGlobal_CharacterSelect_All._ui.btn_Delete:GetSizeY() * 2 + PaGlobal_CharacterSelect_All._ui.txt_Title:GetSizeY() + PaGlobal_CharacterSelect_All._ui.rdo_Normal:GetSizeY() + PaGlobal_CharacterSelect_All._ui.chk_Ghost:GetSizeY() + padding
  PaGlobal_CharacterSelect_All._ui.list2_Character:SetSize(PaGlobal_CharacterSelect_All._ui.list2_Character:GetSizeX(), getScreenSizeY() - btnSize)
  PaGlobal_CharacterSelect_All._ui.list2_Character:createChildContent(__ePAUIList2ElementManagerType_List)
  PaGlobal_CharacterSelect_All._ui.stc_BackGroundBg:SetSize(PaGlobal_CharacterSelect_All._ui.stc_BackGroundBg:GetSizeX(), getScreenSizeY())
  PaGlobal_CharacterSelect_All._ui.stc_RightBg:SetSize(PaGlobal_CharacterSelect_All._ui.stc_RightBg:GetSizeX(), getScreenSizeY())
  PaGlobal_CharacterSelect_All._ui.stc_RightBg:SetPosX(getScreenSizeX() - PaGlobal_CharacterSelect_All._ui.stc_RightBg:GetSizeX())
  PaGlobal_CharacterSelect_All._ui.stc_RightBg:ComputePos()
  PaGlobal_CharacterSelect_All._ui.stc_BackGroundBg:ComputePos()
  PaGlobal_CharacterSelect_All._ui.list2_Character:ComputePos()
  PaGlobal_CharacterSelect_All._ui.btn_Delete:ComputePos()
  PaGlobal_CharacterSelect_All._ui.btn_ChangePosition:ComputePos()
  PaGlobal_CharacterSelect_All._ui.btn_Exit:ComputePos()
  PaGlobal_CharacterSelect_All._ui.chk_Ghost:ComputePos()
  PaGlobal_CharacterSelect_All._ui.btn_BackToServer:ComputePos()
  PaGlobal_CharacterSelect_All._ui.stc_PrimiumBg:ComputePos()
  PaGlobal_CharacterSelect_All._ui.stc_SeasonBg:ComputePos()
end
function PaGlobalFunc_CharacterSelect_All_List2Update(content, key)
  local charIdx = Int64toInt32(key)
  local isPrimiumCharacter = PaGlobal_CharacterSelect_All._isPrimiumCharacter
  local isAnimationFinished = PaGlobal_CharacterSelect_All._allAnimationFinished
  local isShowAnimation = PaGlobal_CharacterSelect_All._listContentsShowAniFlag
  local haveCount = PaGlobal_CharacterSelect_All._playerData.haveCount
  PaGlobal_CharacterSelect_All._listContents[charIdx] = content
  if false == isAnimationFinished and false == isShowAnimation then
    PaGlobal_CharacterSelect_All._listContentsSlideTarget[charIdx] = PaGlobal_CharacterSelect_All._listContentsBaseX
    content:SetAlphaExtraChild(0)
  else
    PaGlobal_CharacterSelect_All._listContentsAlphaTarget[charIdx] = 1
    PaGlobal_CharacterSelect_All._listContentsAlphaFlag[charIdx] = true
  end
  local btnSlot = UI.getChildControl(content, "Button_CharacterSlot")
  local selectGradation = UI.getChildControl(btnSlot, "Static_SelectGradation")
  local btn_Enter = UI.getChildControl(btnSlot, "Button_Enter")
  local stc_ClassIcon = UI.getChildControl(content, "Static_ClassIcon")
  local stc_SeasonSlot = UI.getChildControl(content, "Static_SeasonSlot")
  local txt_lv = UI.getChildControl(content, "StaticText_Lv")
  local txt_Name = UI.getChildControl(content, "StaticText_Name")
  local txt_Region = UI.getChildControl(content, "StaticText_Region")
  local stc_Delete = UI.getChildControl(content, "StaticText_Delete")
  local stc_DeleteIcon = UI.getChildControl(stc_Delete, "StaticText_DeleteIcon")
  local stc_AddIcon = UI.getChildControl(content, "Static_AddIcon")
  local stc_LockIcon = UI.getChildControl(content, "Static_LockIcon")
  local btn_Up = UI.getChildControl(content, "Button_Up")
  local btn_Down = UI.getChildControl(content, "Button_Down")
  local stc_LandServant = UI.getChildControl(content, "Static_ServantView_Ground")
  local stc_SeaServant = UI.getChildControl(content, "Static_ServantView_Sea")
  local txt_SeasonDesc = UI.getChildControl(content, "StaticText_SeasonDesc")
  local btns = {
    _slot = btnSlot,
    _enter = btn_Enter,
    _delete = stc_Delete
  }
  PaGlobal_CharacterSelect_All._ui._btn_EnterTable[charIdx] = btns
  btnSlot:SetShow(false)
  btnSlot:addInputEvent("Mouse_On", "")
  btnSlot:addInputEvent("Mouse_LUp", "")
  btnSlot:registerPadEvent(__eConsoleUIPadEvent_Up_A, "")
  btnSlot:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "")
  btnSlot:SetIgnore(false)
  btnSlot:setNotImpactScrollEvent(true)
  selectGradation:SetShow(false)
  btn_Enter:SetShow(false)
  stc_ClassIcon:SetShow(false)
  txt_lv:SetShow(false)
  txt_Name:SetShow(false)
  txt_Region:SetShow(false)
  stc_Delete:SetShow(false)
  stc_AddIcon:SetShow(false)
  stc_LockIcon:SetShow(false)
  btn_Up:SetShow(false)
  btn_Down:SetShow(false)
  stc_LandServant:SetShow(false)
  stc_SeaServant:SetShow(false)
  stc_SeasonSlot:SetShow(false)
  txt_SeasonDesc:SetShow(false)
  txt_lv:SetText("")
  txt_Name:SetText("")
  txt_Region:SetText("")
  stc_Delete:SetSize(stc_Delete:GetTextSizeX(), stc_Delete:GetSizeY())
  stc_Delete:ComputePos()
  stc_DeleteIcon:SetSpanSize(stc_Delete:GetTextSizeX() + 5, stc_DeleteIcon:GetSpanSize().y)
  if true == PaGlobal_CharacterSelect_All._isUsePadSnapping then
    btnSlot:registerPadEvent(__eConsoleUIPadEvent_Up_A, "")
    btnSlot:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "")
    btnSlot:registerPadEvent(__eConsoleUIPadEvent_Up_X, "")
    btnSlot:registerPadEvent(__eConsoleUIPadEvent_Up_LB, "")
    btnSlot:registerPadEvent(__eConsoleUIPadEvent_Up_RB, "")
    btnSlot:registerPadEvent(__eConsoleUIPadEvent_Up_A, "")
  end
  if charIdx < haveCount then
    local charData = getCharacterDataByIndex(charIdx, isPrimiumCharacter)
    local regionInfo
    if nil ~= charData then
      local charName = getCharacterName(charData)
      local classType = getCharacterClassType(charData)
      local level = string.format("%d", charData._level)
      local pcDeliveryRegionKey = charData._arrivalRegionKey
      local serverUtc64 = getServerUtc64()
      local location = "-"
      if 0 ~= charData._currentPosition.x and 0 ~= charData._currentPosition.y and 0 ~= charData._currentPosition.z then
        if 0 ~= pcDeliveryRegionKey:get() and serverUtc64 > charData._arrivalTime then
          local regionInfoArrival = getRegionInfoByRegionKey(pcDeliveryRegionKey)
          regionInfo = regionInfoArrival
          location = regionInfoArrival:getAreaName()
        else
          regionInfo = getRegionInfoByPosition(charData._currentPosition)
          location = regionInfo:getAreaName()
        end
      end
      PaGlobal_CharacterSelect_All:setClassIcon(stc_ClassIcon, classType)
      txt_lv:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_LV") .. ". " .. level)
      txt_lv:SetSize(txt_lv:GetTextSizeX() + 5, txt_lv:GetSizeY())
      if false == isGameTypeKorea() then
        txt_Name:SetSpanSize(PaGlobal_CharacterSelect_All._ui._originNameSpanX + 5, txt_Name:GetSpanSize().y)
      else
        txt_Name:SetSpanSize(PaGlobal_CharacterSelect_All._ui._originNameSpanX, txt_Name:GetSpanSize().y)
      end
      txt_Name:SetText(charName)
      txt_Name:SetPosX(txt_lv:GetPosX() + txt_lv:GetTextSizeX() + 10)
      txt_Region:SetTextMode(__eTextMode_LimitText)
      txt_Region:SetText(location)
      local removeTime = getCharacterDataRemoveTime(charIdx, isPrimiumCharacter)
      local isMouseOverFlag = charIdx == PaGlobal_CharacterSelect_All._currentOveredCharIdx and false == PaGlobalFunc_CharacterSelect_All_IsPositionChangeClick()
      local mouseOverEffect = isMouseOverFlag and charIdx ~= PaGlobal_CharacterSelect_All._selectedCharIdx
      if true == PaGlobal_CharacterSelect_All._isUsePadSnapping then
        if PaGlobal_CharacterSelect_All._currentTab == PaGlobal_CharacterSelect_All._TABTYPE._NORMAL then
          btnSlot:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandleEventLUp_CharacterSelect_All_ClickChangePosition()")
        else
          btnSlot:registerPadEvent(__eConsoleUIPadEvent_Up_X, "")
        end
        btn_Enter:SetShow(false)
      else
        btn_Enter:SetShow(isMouseOverFlag and nil == removeTime)
        btnSlot:addInputEvent("Mouse_On", "HandleEventOn_CharacterSelect_All_CharacterOver(" .. charIdx .. ")")
      end
      btn_Enter:addInputEvent("Mouse_LUp", "")
      btnSlot:addInputEvent("Mouse_LUp", "HandleEventLUp_CharacterSelect_All_CharacterSelect(" .. charIdx .. ",false)")
      btnSlot:addInputEvent("Mouse_Out", "HandleEventOn_CharacterSelect_All_CharacterOut(" .. charIdx .. ")")
      if true == mouseOverEffect then
        PaGlobal_CharacterSelect_All._listContentsSlideFlag[charIdx] = true
        PaGlobal_CharacterSelect_All._listContentsSlideTarget[charIdx] = PaGlobal_CharacterSelect_All._listContentsBaseX - 10
      else
        PaGlobal_CharacterSelect_All._listContentsSlideFlag[charIdx] = true
        PaGlobal_CharacterSelect_All._listContentsSlideTarget[charIdx] = PaGlobal_CharacterSelect_All._listContentsBaseX
      end
      if nil ~= removeTime then
        if false == PaGlobal_CharacterSelect_All._isUsePadSnapping then
          stc_Delete:addInputEvent("Mouse_LUp", "HandleEventLUp_CharacterSelect_All_CancelDeleting(" .. charIdx .. ")")
        else
          btnSlot:addInputEvent("Mouse_On", "HandleEventLOn_CharacterSelect_All_KeyGuideChange(" .. charIdx .. ", " .. tostring(PaGlobal_CharacterSelect_All._eKeyGuideType.DELETING) .. ")")
          btnSlot:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "HandleEventLUp_CharacterSelect_All_CancelDeleting(" .. charIdx .. ")")
        end
      elseif true == PaGlobalFunc_CharacterSelect_All_IsPositionChangeClick() then
        btn_Up:SetShow(not PaGlobal_CharacterSelect_All._isUsePadSnapping)
        btn_Down:SetShow(not PaGlobal_CharacterSelect_All._isUsePadSnapping)
        if false == PaGlobal_CharacterSelect_All._isUsePadSnapping then
          btn_Up:addInputEvent("Mouse_LUp", "HandleEventLUp_CharacterSelect_All_ChangeSlotPosition(" .. charIdx .. ", true)")
          btn_Down:addInputEvent("Mouse_LUp", "HandleEventLUp_CharacterSelect_All_ChangeSlotPosition(" .. charIdx .. ",false )")
        else
          btnSlot:registerPadEvent(__eConsoleUIPadEvent_Up_LB, "HandleEventLUp_CharacterSelect_All_ChangeSlotPosition(" .. charIdx .. ", true)")
          btnSlot:registerPadEvent(__eConsoleUIPadEvent_Up_RB, "HandleEventLUp_CharacterSelect_All_ChangeSlotPosition(" .. charIdx .. ",false )")
          if charIdx == PaGlobal_CharacterSelect_All._selectedCharIdx then
            btnSlot:addInputEvent("Mouse_On", "HandleEventLOn_CharacterSelect_All_KeyGuideChange(" .. charIdx .. ", " .. tostring(PaGlobal_CharacterSelect_All._eKeyGuideType.CHANGEINGSLOT_SELECTED) .. ")")
          else
            btnSlot:addInputEvent("Mouse_On", "HandleEventLOn_CharacterSelect_All_KeyGuideChange(" .. charIdx .. ", " .. tostring(PaGlobal_CharacterSelect_All._eKeyGuideType.CHANGEINGSLOT_NOT_SELECTED) .. ")")
          end
        end
      else
        btn_Enter:addInputEvent("Mouse_LUp", "HandleEventLUp_CharacterSelect_All_PrepareEnterToField(" .. charIdx .. ")")
        if charIdx == PaGlobal_CharacterSelect_All._selectedCharIdx then
          selectGradation:SetShow(true)
          if true == PaGlobal_CharacterSelect_All._isUsePadSnapping then
            btnSlot:addInputEvent("Mouse_On", "HandleEventLOn_CharacterSelect_All_KeyGuideChange(" .. charIdx .. ", " .. tostring(PaGlobal_CharacterSelect_All._eKeyGuideType.SELECTED) .. ")")
            btnSlot:registerPadEvent(__eConsoleUIPadEvent_Up_A, "HandleEventLUp_CharacterSelect_All_PrepareEnterToField(" .. charIdx .. ")")
            btnSlot:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "HandleEventLUp_CharacterSelect_All_Deleting()")
          end
        elseif true == PaGlobal_CharacterSelect_All._isUsePadSnapping then
          btnSlot:addInputEvent("Mouse_On", "HandleEventLOn_CharacterSelect_All_KeyGuideChange(" .. charIdx .. ", " .. tostring(PaGlobal_CharacterSelect_All._eKeyGuideType.NOT_SELECT) .. ")")
        end
      end
      local SealedServantCount = 0
      local servantType = 0
      local servantControl
      for eServantIdx = 0, PaGlobal_CharacterSelect_All._eServantView.max do
        local briefServantInfo = ToClient_GetBriefServantInfoByCharacter(charData, eServantIdx)
        if nil ~= briefServantInfo then
          if 0 == eServantIdx then
            servantControl = stc_LandServant
            servantType = 0
          else
            servantControl = stc_SeaServant
            servantType = 1
          end
          SealedServantCount = SealedServantCount + 1
          if nil ~= servantControl then
            servantControl:SetShow(true)
            if false == PaGlobal_CharacterSelect_All._isUsePadSnapping then
              servantControl:addInputEvent("Mouse_On", "HandleEventOn_CharacterSelect_All_ServantIconTooltip(true, " .. charIdx .. ", " .. eServantIdx .. "," .. servantType .. ")")
              servantControl:addInputEvent("Mouse_Out", "HandleEventOn_CharacterSelect_All_ServantIconTooltip(false)")
            end
          end
        end
      end
      stc_Delete:SetEnableArea(0, 0, stc_Delete:GetTextSizeX() + stc_Delete:GetSizeX(), stc_Delete:GetSizeY())
      stc_Delete:SetShow(nil ~= removeTime)
      btnSlot:SetShow(true)
      stc_ClassIcon:SetShow(true)
      txt_Name:SetShow(true)
      txt_lv:SetShow(true)
      txt_Region:SetShow(true)
      if true == _ContentsGroup_SeasonContents or true == _ContentsGroup_PreSeason then
        stc_SeasonSlot:SetShow(charData._characterSeasonType == __eCharacterSeasonType_Season)
      end
    end
  elseif charIdx == haveCount then
    btnSlot:addInputEvent("Mouse_LUp", "HandleEventLUp_CharacterSelect_All_CreateNewCharacter()")
    btnSlot:addInputEvent("Mouse_On", "HandleEventLOn_CharacterSelect_All_KeyGuideChange(" .. charIdx .. ", " .. tostring(PaGlobal_CharacterSelect_All._eKeyGuideType.ADD_NEWCHARACTER) .. ")")
    btnSlot:SetIgnore(false)
    stc_AddIcon:SetShow(true)
    btnSlot:SetShow(true)
    if true == _ContentsGroup_SeasonContents or true == _ContentsGroup_PreSeason then
      if true == PaGlobal_CharacterSelect_All._canMakeSeason and false == isPrimiumCharacter then
        stc_AddIcon:SetSpanSize(stc_AddIcon:GetSpanSize().x, -10)
        txt_SeasonDesc:SetShow(true)
      else
        stc_AddIcon:SetSpanSize(stc_AddIcon:GetSpanSize().x, 5)
        txt_SeasonDesc:SetShow(false)
      end
    else
      txt_SeasonDesc:SetShow(false)
    end
  else
    btnSlot:SetIgnore(true)
    stc_LockIcon:SetShow(true)
    btnSlot:SetShow(true)
  end
end
function PaGlobalFunc_CharacterSelectAll_PerFrameUpdate(deltaT)
  luaTimer_UpdatePerFrame(deltaT)
  PaGlobal_CharacterSelect_All._updateDelay = PaGlobal_CharacterSelect_All._updateDelay + deltaT
  if PaGlobal_CharacterSelect_All._updateDelay > 1 and true == PaGlobal_CharacterSelect_All._allAnimationFinished then
    PaGlobal_CharacterSelect_All._updateDelay = 0
    for characterIdx = 0, PaGlobal_CharacterSelect_All._playerData.useAbleCount - 1 do
      PaGlobal_CharacterSelect_All._ui.list2_Character:requestUpdateByKey(toInt64(0, characterIdx))
    end
    if -1 ~= PaGlobal_CharacterSelect_All._selectedCharIdx then
      local removeTime = getCharacterDataRemoveTime(PaGlobal_CharacterSelect_All._selectedCharIdx, PaGlobal_CharacterSelect_All._isPrimiumCharacter)
      if nil ~= removeTime then
        PaGlobalFunc_CharacterSelect_All_UpdateChracterStatus(nil, removeTime)
      else
        local characterData = getCharacterDataByIndex(PaGlobal_CharacterSelect_All._selectedCharIdx, PaGlobal_CharacterSelect_All._isPrimiumCharacter)
        if nil ~= characterData then
          PaGlobalFunc_CharacterSelect_All_UpdateChracterStatus(characterData)
        end
      end
    end
  end
  if false == PaGlobal_CharacterSelect_All._animationPlayed then
    PaGlobal_CharacterSelect_All._timeElapsed = PaGlobal_CharacterSelect_All._timeElapsed + deltaT
    if PaGlobal_CharacterSelect_All._timeElapsed > PaGlobal_CharacterSelect_All._animationDelay and false == PaGlobal_CharacterSelect_All._listContentsShowAniFlag then
      PaGlobal_CharacterSelect_All._listContentsShowAniFlag = true
    end
    if 1 < PaGlobal_CharacterSelect_All._timeElapsed then
      PaGlobal_CharacterSelect_All._animationPlayed = true
      PaGlobal_CharacterSelect_All._allAnimationFinished = true
    end
  end
  if true == PaGlobal_CharacterSelect_All._listContentsShowAniFlag then
    PaGlobal_CharacterSelect_All:playListComponentsAni(deltaT)
  end
  for ii = 0, PaGlobal_CharacterSelect_All._listContentsCount do
    if true == PaGlobal_CharacterSelect_All._listContentsAlphaFlag[ii] then
      PaGlobal_CharacterSelect_All:animateListComponentsAlpha(deltaT, ii)
    end
    if true == PaGlobal_CharacterSelect_All._listContentsSlideFlag[ii] then
      PaGlobal_CharacterSelect_All:animateListComponentsSlide(deltaT, ii)
    end
  end
end
function PaGlobalFunc_CharacterSelect_All_ShowAni()
  if false == PaGlobal_CharacterSelect_All._allAnimationFinished then
    local ImageMoveAni = PaGlobal_CharacterSelect_All._ui.stc_RightBg:addMoveAnimation(0, 0.7, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
    ImageMoveAni:SetStartPosition(getScreenSizeX(), 0)
    ImageMoveAni:SetEndPosition(getScreenSizeX() - PaGlobal_CharacterSelect_All._ui.stc_RightBg:GetSizeX(), 0)
    ImageMoveAni.IsChangeChild = true
    PaGlobal_CharacterSelect_All._ui.stc_RightBg:CalcUIAniPos(ImageMoveAni)
  end
end
function PaGlobalFunc_CharacterSelect_All_FadeIn()
  if true == PaGlobal_CharacterSelect_All._isConsole then
    return
  end
  local fadeOutT = PaGlobal_CharacterSelect_All._enteringGameFadeOutTime
  local ImageAni = PaGlobal_CharacterSelect_All._ui.stc_Fade:addColorAnimation(0, fadeOutT, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_LINEAR)
  ImageAni:SetStartColor(Defines.Color.C_FF000000)
  ImageAni:SetEndColor(Defines.Color.C_00000000)
  ImageAni:SetHideAtEnd(true)
  PaGlobal_CharacterSelect_All._isBlockServerBack = false
end
function PaGlobalFunc_CharacterSelect_All_FadeOut()
  if true == PaGlobal_CharacterSelect_All._isConsole then
    return
  end
  local fadeOutT = PaGlobal_CharacterSelect_All._enteringGameFadeOutTime
  PaGlobal_CharacterSelect_All._ui.stc_Fade:SetShow(true)
  local ImageAni = PaGlobal_CharacterSelect_All._ui.stc_Fade:addColorAnimation(0, fadeOutT, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_LINEAR)
  ImageAni:SetStartColor(Defines.Color.C_00000000)
  ImageAni:SetEndColor(Defines.Color.C_FF000000)
  ImageAni:SetHideAtEnd(false)
  PaGlobal_CharacterSelect_All._isBlockServerBack = true
end
function HandleEventOn_CharacterSelect_All_OfflineModeTooltip(isShow)
  if false == isShow then
    TooltipSimple_Hide()
    return
  end
  local title = PAGetString(Defines.StringSheet_GAME, "LUA_ENTERTOFIELDMODE_OFFLINE")
  local desc = PAGetString(Defines.StringSheet_GAME, "LUA_CHARACTERSELECT_OFFLINE_TOOLTIP")
  TooltipSimple_Show(PaGlobal_CharacterSelect_All._ui.chk_Ghost, title, desc)
end
function HandleEventOn_CharacterSelect_All_ServantIconTooltip(isShow, charDataIdx, servantIdx, servantType)
  if false == isShow then
    TooltipSimple_Hide()
    return
  end
  local characterData = getCharacterDataByIndex(charDataIdx)
  if nil == characterData then
    return
  end
  local briefServantInfo = ToClient_GetBriefServantInfoByCharacter(characterData, servantIdx)
  if nil == briefServantInfo then
    return
  end
  local name = briefServantInfo:getName()
  local desc = HandleEventOn_CharacterSelect_All_GetServantTooltipText(briefServantInfo)
  local control
  if 0 == servantType then
    control = UI.getChildControl(PaGlobal_CharacterSelect_All._listContents[charDataIdx], "Static_ServantView_Ground")
  else
    control = UI.getChildControl(PaGlobal_CharacterSelect_All._listContents[charDataIdx], "Static_ServantView_Sea")
  end
  if nil ~= control then
    TooltipSimple_Show(control, name, desc)
  end
end
function HandleEventOn_CharacterSelect_All_GetServantTooltipText(briefServantInfo)
  if nil == briefServantInfo then
    return
  end
  local servantKind = briefServantInfo:getServantKind()
  local strKind = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTINFO_SERVANTKIND_" .. servantKind)
  if 31053 == briefServantInfo:getServantCharacterKeyRaw() then
    strKind = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTINFO_SERVANTKIND_15_1")
  end
  local strText = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_SERVANTINFO_TOOLTIP_KIND", "kind", strKind)
  local level = briefServantInfo:getLevel()
  if 0 < level then
    strText = strText .. "\n" .. PAGetStringParam1(Defines.StringSheet_GAME, "LUA_SERVANTINFO_TOOLTIP_LEVEL", "level", level)
  end
  if CppEnums.ServantKind.Type_Horse == servantKind then
    local tier = briefServantInfo:getTier()
    if 0 < tier then
      if 9 == tier then
        tier = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANT_TEXT_TIER9")
      end
      strText = strText .. "\n" .. PAGetStringParam1(Defines.StringSheet_GAME, "LUA_SERVANTINFO_TOOLTIP_TIER", "tier", tier)
    end
  end
  return strText
end
function HandleEventLUp_CharacterSelect_All_CreateNewCharacter()
  if MessageBoxGetShow() then
    return
  end
  local do_Create = function()
    local isPrimiumCharacter = PaGlobal_CharacterSelect_All._isPrimiumCharacter
    if true == PaGlobal_CharacterSelect_All._isConsole then
      local isChecked = PaGlobalFunc_CharacterSelect_All_IsPositionChangeClick()
      if true == isChecked then
        PaGlobal_CharacterSelect_All._ui.btn_ChangePosition:SetCheck(false)
        if PaGlobal_CharacterSelect_All._eKeyGuideType.CHANGEINGSLOT_SELECTED == PaGlobal_CharacterSelect_All._curKeyGuideIdx then
          PaGlobal_CharacterSelect_All:SetKeyGuideShow(PaGlobal_CharacterSelect_All._eKeyGuideType.SELECTED)
        else
          PaGlobal_CharacterSelect_All:SetKeyGuideShow(PaGlobal_CharacterSelect_All._eKeyGuideType.NOT_SELECT)
        end
        PaGlobal_CharacterSelect_All:update()
      end
    end
    if (true == _ContentsGroup_SeasonContents or true == _ContentsGroup_PreSeason) and nil ~= PaGlobalFunc_Customization_SetSeasonBtnShow then
      if false == isPrimiumCharacter and true == PaGlobal_CharacterSelect_All._canMakeSeason then
        PaGlobalFunc_Customization_SetSeasonBtnShow(true)
      else
        PaGlobalFunc_Customization_SetSeasonBtnShow(false)
      end
    end
    changeCreateCharacterMode_SelectClass(isPrimiumCharacter)
    FGlobal_SetSpecialCharacter(isPrimiumCharacter)
  end
  PaGlobal_CharacterSelect_All:SetMsgDataAndShow(PAGetString(Defines.StringSheet_GAME, "LUA_CHARACTERSELECT_CREATENEWCHARACTER_BTN"), PAGetString(Defines.StringSheet_GAME, "LUA_CHARACTERSELECT_CREATENEWCHARACTER_NOTIFY"), do_Create, MessageBox_Empty_function, nil, nil)
end
function HandleEventLOn_CharacterSelect_All_KeyGuideChange(charIdx, type)
  PaGlobal_CharacterSelect_All:SetKeyGuideShow(type)
  HandleEventOn_CharacterSelect_All_CharacterOver(charIdx)
end
function HandleEventOn_CharacterSelect_All_CharacterOver(charIdx)
  if false == PaGlobal_CharacterSelect_All._allAnimationFinished then
    return
  end
  TooltipSimple_Hide()
  if nil ~= PaGlobal_CharacterSelect_All._currentOveredCharIdx and nil ~= charIdx and charIdx ~= PaGlobal_CharacterSelect_All._currentOveredCharIdx then
    local prevIdx = PaGlobal_CharacterSelect_All._currentOveredCharIdx
    PaGlobal_CharacterSelect_All._currentOveredCharIdx = charIdx
    PaGlobal_CharacterSelect_All._ui.list2_Character:requestUpdateByKey(toInt64(0, prevIdx))
    PaGlobal_CharacterSelect_All._ui.list2_Character:requestUpdateByKey(toInt64(0, PaGlobal_CharacterSelect_All._currentOveredCharIdx))
  end
  HandleEventOnOut_CharacterSelect_All_LobbyCharacterCursor(false)
end
function HandleEventOn_CharacterSelect_All_CharacterOut()
  if false == PaGlobal_CharacterSelect_All._allAnimationFinished then
    return
  end
  if nil ~= PaGlobal_CharacterSelect_All._currentOveredCharIdx and nil ~= charIdx and charIdx == PaGlobal_CharacterSelect_All._currentOveredCharIdx then
    for ii = 1, PaGlobal_CharacterSelect_All._listContentsCount do
      PaGlobal_CharacterSelect_All._listContentsSlideTarget[ii] = PaGlobal_CharacterSelect_All._listContentsBaseX
      PaGlobal_CharacterSelect_All._listContentsSlideFlag[ii] = true
    end
  end
end
function HandleEventLUp_CharacterSelect_All_CharacterSelect(charIdx, initialSelect)
  local isPrimiumCharacter = PaGlobal_CharacterSelect_All._isPrimiumCharacter
  local charData = getCharacterDataByIndex(charIdx, isPrimiumCharacter)
  local prevIdx = PaGlobal_CharacterSelect_All._selectedCharIdx
  if nil ~= charData then
    local classType = getCharacterClassType(charData)
    local removeTime = getCharacterDataRemoveTime(charIdx, isPrimiumCharacter)
    local isDeleting = nil ~= removeTime
    local isSeasonCharacter = charData._characterSeasonType == __eCharacterSeasonType_Season
    if true == _ContentsGroup_SeasonContents then
      if false == isPrimiumCharacter then
        PaGlobal_CharacterSelect_All._ui.stc_SeasonBg:SetShow(isSeasonCharacter)
      end
    else
      PaGlobal_CharacterSelect_All._ui.stc_SeasonBg:SetShow(false)
    end
    PaGlobal_CharacterSelect_All._isSelectDeletingChar = isDeleting
    PaGlobal_CharacterSelect_All._ui.btn_Delete:SetEnable(not isDeleting)
    PaGlobal_CharacterSelect_All._ui.btn_Delete:SetMonoTone(isDeleting, isDeleting)
    if true == isDeleting then
      PaGlobalFunc_CharacterSelect_All_UpdateChracterStatus(nil, removeTime)
    else
      PaGlobalFunc_CharacterSelect_All_UpdateChracterStatus(charData, nil)
    end
    PaGlobal_CharacterSelect_All._prevSelectedCharIdx = PaGlobal_CharacterSelect_All._selectedCharIdx
    PaGlobal_CharacterSelect_All._selectedCharIdx = charIdx
    PaGlobal_CharacterSelect_All._ui.list2_Character:requestUpdateByKey(toInt64(0, PaGlobal_CharacterSelect_All._prevSelectedCharIdx))
    PaGlobal_CharacterSelect_All._ui.list2_Character:requestUpdateByKey(toInt64(0, PaGlobal_CharacterSelect_All._selectedCharIdx))
    if true == initialSelect or prevIdx ~= PaGlobal_CharacterSelect_All._selectedCharIdx then
      PaGlobal_CharacterSelect_All:setCharacterView(PaGlobal_CharacterSelect_All._selectedCharIdx, classType, isPrimiumCharacter, false)
      local charName = getCharacterName(charData)
      PaGlobal_CharacterSelect_All._ui.txt_CharacterName:SetText(charName)
    end
    _AudioPostEvent_SystemUiForXBOX(50, 1)
  else
    PaGlobal_CharacterSelect_All._ui.txt_CharacterName:SetText("")
  end
end
function PaGlobalFunc_CharacterSelect_All_UpdateChracterStatus(charData, removeTime)
  if nil == charData and nil ~= removeTime then
    PaGlobal_CharacterSelect_All._ui.txt_CharacterStatus:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_CHARACTER_DELETE") .. " ( " .. removeTime .. " )")
    PaGlobal_CharacterSelect_All._ui.txt_CharacterStatus:SetFontColor(Defines.Color.C_FFD05D48)
    return
  end
  local firstTicketNo = getFirstTicketNoByAll()
  local currentTicketN = getCurrentTicketNo()
  local ticketCountByRegion = charData._lastTicketNoByRegion
  local classType = getCharacterClassType(charData)
  local isPossibleClass = ToClient_IsCustomizeOnlyClass(classType)
  local text = ""
  PaGlobal_CharacterSelect_All._ui.txt_CharacterStatus:SetFontColor(Defines.Color.C_FFF5BA3A)
  if Defines.s64_const.s64_m1 ~= firstTicketNo or Defines.s64_const.s64_m1 ~= ticketCountByRegion then
    PaGlobal_CharacterSelect_All._ui.txt_CharacterStatus:SetFontColor(Defines.Color.C_FFD05D48)
    text = PAGetString(Defines.StringSheet_GAME, "LUA_GAMEEXIT_NOT_ENTER_TO_FIELD")
  elseif true == isPossibleClass then
    text = ""
  else
    text = PAGetString(Defines.StringSheet_GAME, "LUA_GAMEEXIT_ENTER_TO_FIELD")
  end
  local pcDeliveryRegionKey = charData._arrivalRegionKey
  local serverUtc64 = getServerUtc64()
  if 0 ~= pcDeliveryRegionKey:get() and serverUtc64 < charData._arrivalTime then
    local remainTime = charData._arrivalTime - serverUtc64
    local strTime = convertStringFromDatetime(remainTime)
    text = text .. "\n" .. PAGetString(Defines.StringSheet_GAME, "CHARACTER_WORKING_TEXT_DELIVERY") .. " : " .. strTime
  end
  PaGlobal_CharacterSelect_All._ui.txt_CharacterStatus:SetText(text)
end
function PaGlobalFunc_CharacterSelect_All_IsPositionChangeClick()
  return PaGlobal_CharacterSelect_All._ui.btn_ChangePosition:IsCheck()
end
function HandleEventLUp_CharacterSelect_All_Deleting()
  local isPrimiumCharacter = PaGlobal_CharacterSelect_All._isPrimiumCharacter
  local currentSelectIdx = PaGlobal_CharacterSelect_All._selectedCharIdx
  if -1 ~= currentSelectIdx then
    local charData = getCharacterDataByIndex(currentSelectIdx, isPrimiumCharacter)
    local removeTime = getCharacterDataRemoveTime(currentSelectIdx, isPrimiumCharacter)
    if nil ~= removeTime or nil == charData then
      return
    end
    local function do_Delete()
      _AudioPostEvent_SystemUiForXBOX(50, 1)
      deleteCharacter(currentSelectIdx, isPrimiumCharacter)
    end
    local removeTimeCheckLevel = getCharacterRemoveTimeCheckLevel()
    local removeTime
    if removeTimeCheckLevel > charData._level then
      removeTime = Int64toInt32(getLowLevelCharacterRemoveDate())
    else
      removeTime = Int64toInt32(getCharacterRemoveDate())
    end
    local characterNameRestoreTime = Int64toInt32(getNameRemoveDate())
    local remainTime = convertStringFromDatetime(toInt64(0, characterNameRestoreTime - removeTime))
    if (true == _ContentsGroup_SeasonContents or true == _ContentsGroup_PreSeason) and charData._characterSeasonType == __eCharacterSeasonType_Season then
      local seasonDeleteTime = getSeasonCharacterRemoveDate()
      removeTime = Int64toInt32(seasonDeleteTime)
      remainTime = convertStringFromDatetime(seasonDeleteTime)
    end
    local messageContent = PAGetStringParam3(Defines.StringSheet_GAME, "CHARACTER_LATER_DELETE_MESSAGEBOX_MEMO", "removeTime", convertStringFromDatetime(toInt64(0, removeTime)), "characterName", getCharacterName(charData), "remainTime", remainTime)
    if (true == _ContentsGroup_SeasonContents or true == _ContentsGroup_PreSeason) and charData._characterSeasonType == __eCharacterSeasonType_Season then
      messageContent = messageContent .. [[
 

 ]] .. PAGetString(Defines.StringSheet_GAME, "LUA_SEASONCONTENT_CHARACTER_DELETE")
    end
    PaGlobal_CharacterSelect_All:SetMsgDataAndShow(PAGetString(Defines.StringSheet_GAME, "CHARACTER_DELETE_MESSAGEBOX_TITLE"), messageContent, do_Delete, MessageBox_Empty_function, nil, nil)
  end
end
function HandleEventLUp_CharacterSelect_All_CancelDeleting(charIdx)
  if false == PaGlobal_CharacterSelect_All._allAnimationFinished or -1 == charIdx then
    return
  end
  if -1 == charIdx then
    return
  end
  if true == PaGlobalFunc_CharacterSelect_All_IsPositionChangeClick() then
    PaGlobal_CharacterSelect_All._ui.btn_ChangePosition:SetCheck(false)
  end
  local isPrimiumCharacter = PaGlobal_CharacterSelect_All._isPrimiumCharacter
  deleteCancelCharacter(charIdx, isPrimiumCharacter)
end
function HandleEventLUp_CharacterSelect_All_ClickChangePosition()
  if true == PaGlobal_CharacterSelect_All._isUsePadSnapping and false == PaGlobalFunc_CharacterSelect_All_IsPositionChangeClick() then
    PaGlobal_CharacterSelect_All._ui.btn_ChangePosition:SetCheck(true)
    if PaGlobal_CharacterSelect_All._eKeyGuideType.SELECTED == PaGlobal_CharacterSelect_All._curKeyGuideIdx then
      PaGlobal_CharacterSelect_All:SetKeyGuideShow(PaGlobal_CharacterSelect_All._eKeyGuideType.CHANGEINGSLOT_SELECTED)
    elseif PaGlobal_CharacterSelect_All._eKeyGuideType.NOT_SELECT == PaGlobal_CharacterSelect_All._curKeyGuideIdx then
      PaGlobal_CharacterSelect_All:SetKeyGuideShow(PaGlobal_CharacterSelect_All._eKeyGuideType.CHANGEINGSLOT_NOT_SELECTED)
    elseif PaGlobal_CharacterSelect_All._eKeyGuideType.ADD_NEWCHARACTER == PaGlobal_CharacterSelect_All._curKeyGuideIdx then
      PaGlobal_CharacterSelect_All:SetKeyGuideShow(PaGlobal_CharacterSelect_All._eKeyGuideType.ADD_NEWCHARACTER)
    end
  end
  PaGlobal_CharacterSelect_All:update()
end
function HandleEventLUp_CharacterSelect_All_ChangeSlotPosition(charIdx, isUp)
  if false == PaGlobal_CharacterSelect_All._allAnimationFinished then
    return
  end
  if nil == charIdx or nil == isUp then
    return
  end
  ToClient_ChangeCharacterListOrder(charIdx, isUp)
  ToClient_SaveClientCacheData()
  local curSelected = PaGlobal_CharacterSelect_All._selectedCharIdx
  local isPrimiumCharacter = PaGlobal_CharacterSelect_All._isPrimiumCharacter
  local characterData = getCharacterDataByIndex(curSelected, isPrimiumCharacter)
  local classType = getCharacterClassType(characterData)
  PaGlobal_CharacterSelect_All:setCharacterView(curSelected, classType, isPrimiumCharacter, false)
  PaGlobal_CharacterSelect_All._currentOveredCharIdx = PaGlobal_CharacterSelect_All._selectedCharIdx
  PaGlobal_CharacterSelect_All:update()
end
function HandleEventLUp_CharacterSelect_All_BackToServerSelect()
  if true == PaGlobal_CharacterSelect_All._isBlockServerBack then
    return
  end
  if true == PaGlobal_CharacterSelect_All._isUsePadSnapping then
    local isChecked = PaGlobalFunc_CharacterSelect_All_IsPositionChangeClick()
    if true == isChecked then
      PaGlobal_CharacterSelect_All._ui.btn_ChangePosition:SetCheck(false)
      if PaGlobal_CharacterSelect_All._eKeyGuideType.CHANGEINGSLOT_SELECTED == PaGlobal_CharacterSelect_All._curKeyGuideIdx then
        PaGlobal_CharacterSelect_All:SetKeyGuideShow(PaGlobal_CharacterSelect_All._eKeyGuideType.SELECTED)
      elseif PaGlobal_CharacterSelect_All._eKeyGuideType.CHANGEINGSLOT_NOT_SELECTED == PaGlobal_CharacterSelect_All._curKeyGuideIdx then
        PaGlobal_CharacterSelect_All:SetKeyGuideShow(PaGlobal_CharacterSelect_All._eKeyGuideType.NOT_SELECT)
      elseif PaGlobal_CharacterSelect_All._eKeyGuideType.ADD_NEWCHARACTER == PaGlobal_CharacterSelect_All._curKeyGuideIdx then
        PaGlobal_CharacterSelect_All:SetKeyGuideShow(PaGlobal_CharacterSelect_All._eKeyGuideType.ADD_NEWCHARACTER)
      end
      PaGlobal_CharacterSelect_All:update()
      return
    end
  end
  PaGlobal_CharacterSelect_All:prepareClose()
  backServerSelect()
end
function HandleEventLUp_CharacterSelect_All_PrepareEnterToField(charIdx)
  if false == PaGlobal_CharacterSelect_All._allAnimationFinished then
    return
  end
  if true == PaGlobal_CharacterSelect_All._isConsole and true == PaGlobal_CharacterSelect_All._isSelectDeletingChar then
    return
  end
  _AudioPostEvent_SystemUiForXBOX(50, 8)
  if ToClient_isDataDownloadStart() then
    local isComplete = ToClient_isDataDownloadComplete()
    local percent = ToClient_getDataDownloadProgress()
    if false == isComplete then
      PaGlobal_CharacterSelect_All:SetMsgDataAndShow(PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_ALERT_NOTIFICATIONS"), PAGetString(Defines.StringSheet_RESOURCE, "PANEL_MESSAGEBOX_XBOX_DATAINSTALLATION_DESC") .. tostring(percent), nil, nil, MessageBox_Empty_function, nil)
      return
    end
  end
  local isPrimiumCharacter = PaGlobal_CharacterSelect_All._isPrimiumCharacter
  local characterData = getCharacterDataByIndex(charIdx, isPrimiumCharacter)
  local classType = getCharacterClassType(characterData)
  if true == ToClient_IsCustomizeOnlyClass(classType) then
    local desc = PAGetString(Defines.StringSheet_GAME, "LUA_LOBBY_SELECTCHARACTER_NOTYET_1") .. PAGetString(Defines.StringSheet_GAME, "LUA_LOBBY_SELECTCHARACTER_NOTYET_2")
    PaGlobal_CharacterSelect_All:SetMsgDataAndShow(PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_ALERT_NOTIFICATIONS"), desc, nil, nil, MessageBox_Empty_function, nil)
    return
  end
  local enterFieldType = ToClient_CheckEnterToCharacter(charIdx, isPrimiumCharacter)
  if __eLobby_Count == enterFieldType then
    return
  end
  local characterData = getCharacterDataByIndex(charIdx, isPrimiumCharacter)
  local isSeasonCharacter = characterData._characterSeasonType == __eCharacterSeasonType_Season
  if nil == characterData then
    return
  end
  if true == _ContentsGroup_SeasonContents then
    local isSeasonChannel = ToClient_isSeasonChannel()
    if false == isSeasonCharacter and true == isSeasonChannel and false == ToClient_SelfPlayerIsGM() then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_SEASONCONTENT_CANNOT_ACCESS"))
      return
    end
  elseif true == _ContentsGroup_PreSeason and true == isSeasonCharacter then
    PaGlobal_CharacterSelect_All:SetMsgDataAndShow(PAGetString(Defines.StringSheet_GAME, "LUA_ALERT_DEFAULT_TITLE"), PAGetString(Defines.StringSheet_GAME, "LUA_SEASONCONTENT_CANNOT_PLAY"), nil, nil, MessageBox_Empty_function, nil)
    return
  end
  if __eLobby_NoEnterToField == enterFieldType then
    return
  else
    if __eLobby_FirstSpawnCharacterLogin == enterFieldType then
      PaGlobal_CharacterSelect_All._selectedCharIdx = charIdx
      FGlobal_FirstLogin_Open(charIdx)
    elseif __eLobby_CharacterState == enterFieldType then
      local function enterGame()
        PaGlobal_CharacterSelect_All._selectedCharIdx = charIdx
        PaGlobal_CharacterSelect_All:enableEnterBtn(false)
        PaGlobalFunc_CharacterSelect_All_EnterToField()
      end
      local contentString = ToClient_GetEnterGameMessage(charIdx, isPrimiumCharacter)
      PaGlobal_CharacterSelect_All:SetMsgDataAndShow(PAGetString(Defines.StringSheet_GAME, "LUA_ALERT_DEFAULT_TITLE"), contentString, enterGame, MessageBox_Empty_function, nil, nil)
    elseif __eLobby_EnterToField == enterFieldType then
      PaGlobalFunc_CharacterSelect_All_FadeOut()
      PaGlobal_CharacterSelect_All:enableEnterBtn(false)
      PaGlobal_CharacterSelect_All._selectedCharIdx = charIdx
      luaTimer_AddEvent(PaGlobalFunc_CharacterSelect_All_TryLogin, PaGlobal_CharacterSelect_All._enteringGameFadeOutTime * 1000, false, 0)
    end
    local temporaryWrapper = getTemporaryInformationWrapper()
    temporaryWrapper:setGhostMode(PaGlobal_CharacterSelect_All._ui.chk_Ghost:IsCheck())
  end
end
function PaGlobalFunc_CharacterSelect_All_TryLogin()
  if false == selectCharacter(PaGlobal_CharacterSelect_All._selectedCharIdx, PaGlobal_CharacterSelect_All._isPrimiumCharacter) then
    PaGlobal_CharacterSelect_All:enableEnterBtn(true)
    PaGlobalFunc_CharacterSelect_All_FadeIn()
  end
end
function PaGlobalFunc_CharacterSelect_All_EnterToField()
  if false == PaGlobal_CharacterSelect_All._allAnimationFinished then
    return
  end
  local isPrimiumCharacter = PaGlobal_CharacterSelect_All._isPrimiumCharacter
  local characterData = getCharacterDataByIndex(PaGlobal_CharacterSelect_All._selectedCharIdx, isPrimiumCharacter)
  local classType = getCharacterClassType(characterData)
  if nil ~= characterData then
    if true == ToClient_IsCustomizeOnlyClass(classType) then
      local desc = PAGetString(Defines.StringSheet_GAME, "LUA_LOBBY_SELECTCHARACTER_NOTYET_1") .. PAGetString(Defines.StringSheet_GAME, "LUA_LOBBY_SELECTCHARACTER_NOTYET_2")
      PaGlobal_CharacterSelect_All:SetMsgDataAndShow(PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_ALERT_NOTIFICATIONS"), desc, nil, nil, MessageBox_Empty_function, nil)
    else
      PaGlobal_CharacterSelect_All:enableEnterBtn(false)
      if true == PaGlobal_CharacterSelect_All._isConsole then
        Panel_GamerTag:ComputePos()
      end
      selectCharacter(PaGlobal_CharacterSelect_All._selectedCharIdx, isPrimiumCharacter)
    end
  end
end
function PaGlobalFunc_CharacterSelect_All_GetCurrentTab()
  return PaGlobal_CharacterSelect_All._currentTab
end
function HandleEventLUp_CharacterSelect_All_TabClick(idx)
  if false == PaGlobal_CharacterSelect_All._allAnimationFinished then
    return
  end
  if true == PaGlobalFunc_CharacterSelect_All_IsPositionChangeClick() then
    PaGlobal_CharacterSelect_All._ui.btn_ChangePosition:SetCheck(false)
  end
  PaGlobal_CharacterSelect_All._ui.txt_CharacterStatus:SetText("")
  if idx ~= PaGlobal_CharacterSelect_All._currentTab then
    if PaGlobal_CharacterSelect_All._isUsePadSnapping then
      PaGlobal_CharacterSelect_All._ui.rdo_Normal:SetCheck(PaGlobal_CharacterSelect_All._TABTYPE._NORMAL == idx)
      PaGlobal_CharacterSelect_All._ui.rdo_Special:SetCheck(PaGlobal_CharacterSelect_All._TABTYPE._PREMIUM == idx)
      PaGlobal_CharacterSelect_All._ui.stc_KeyGuide_X:SetShow(PaGlobal_CharacterSelect_All._TABTYPE._NORMAL == idx)
    end
    PaGlobal_CharacterSelect_All._isPrimiumCharacter = PaGlobal_CharacterSelect_All._ui.rdo_Special:IsCheck()
    PaGlobal_CharacterSelect_All._selectedCharIdx = 0
    PaGlobal_CharacterSelect_All._prevSelectedCharIdx = -1
    FGlobal_SetSpecialCharacter(PaGlobal_CharacterSelect_All._isPrimiumCharacter)
    local characterData = getCharacterDataByIndex(PaGlobal_CharacterSelect_All._selectedCharIdx, PaGlobal_CharacterSelect_All._isPrimiumCharacter)
    if nil ~= characterData then
      local classType = getCharacterClassType(characterData)
      PaGlobal_CharacterSelect_All:setCharacterView(PaGlobal_CharacterSelect_All._selectedCharIdx, classType, PaGlobal_CharacterSelect_All._isPrimiumCharacter, false)
      local charName = getCharacterName(characterData)
      PaGlobal_CharacterSelect_All._ui.txt_CharacterName:SetText(charName)
    else
      PaGlobal_CharacterSelect_All._selectedCharIdx = -1
      PaGlobal_CharacterSelect_All:setCharacterView(0, nil, PaGlobal_CharacterSelect_All._isPrimiumCharacter, false)
      PaGlobal_CharacterSelect_All._ui.txt_CharacterName:SetText("")
    end
    PaGlobal_CharacterSelect_All._currentTab = idx
    HandleEventLUp_CharacterSelect_All_CharacterSelect(PaGlobal_CharacterSelect_All._selectedCharIdx, false)
    PaGlobal_CharacterSelect_All:update()
    PaGlobal_CharacterSelect_All._ui.stc_SelectLine:SetSpanSize(PaGlobal_CharacterSelect_All._ui._rdoTables[idx]:GetSpanSize().x, PaGlobal_CharacterSelect_All._ui.stc_SelectLine:GetSpanSize().y)
  end
end
function HandleEventLBRB_CharacterSelect_All_TabChange(value)
  local idxToChange = PaGlobal_CharacterSelect_All._currentTab + value
  if idxToChange < PaGlobal_CharacterSelect_All._TABTYPE._NORMAL then
    idxToChange = PaGlobal_CharacterSelect_All._TABTYPE._PREMIUM
  elseif idxToChange > PaGlobal_CharacterSelect_All._TABTYPE._PREMIUM then
    idxToChange = PaGlobal_CharacterSelect_All._TABTYPE._NORMAL
  end
  HandleEventLUp_CharacterSelect_All_TabClick(idxToChange)
end
function HandleEventOnOut_CharacterSelect_All_LobbyCharacterCursor(isOn)
  ToClient_SetLobbyCharacterCursor(isOn)
end
function HandleEventLUp_CharacterSelect_All_ExitGame()
  local do_Exit = function()
    disConnectToGame()
    GlobalExitGameClient()
  end
  PaGlobal_CharacterSelect_All:SetMsgDataAndShow(PAGetString(Defines.StringSheet_GAME, "GAME_EXIT_MESSAGEBOX_TITLE"), PAGetString(Defines.StringSheet_GAME, "GAME_EXIT_MESSAGEBOX_MEMO"), do_Exit, MessageBox_Empty_function, nil, nil)
end
function FromClient_ChracterSelect_All_CancelEnterWating()
  if true == PaGlobal_CharacterSelect_All._playerData.isWaitLine then
    MessageBox_HideAni()
    PaGlobal_CharacterSelect_All._playerData.isWaitLine = false
  end
end
function FromClient_ChracterSelect_All_ReceiveWaiting()
  local isPrimiumCharacter = PaGlobal_CharacterSelect_All._isPrimiumCharacter
  PaGlobal_CharacterSelect_All._playerData.isWaitLine = true
  local characterData = getCharacterDataByIndex(PaGlobal_CharacterSelect_All._selectedCharIdx, isPrimiumCharacter)
  if nil == characterData then
    UI.ASSERT(false, "\236\186\144\235\166\173\237\132\176 \236\132\160\237\131\157 \236\160\149\235\179\180\234\176\128 \236\151\134\236\138\181\235\139\136\235\139\164!")
    return
  end
  PaGlobal_CharacterSelect_All._ui.txt_CharacterStatus:SetFontColor(Defines.Color.C_FFD05D48)
  PaGlobal_CharacterSelect_All._ui.txt_CharacterStatus:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_GAMEEXIT_NOT_ENTER_TO_FIELD"))
  local strWaitingMsg = PaGlobal_CharacterSelect_MakeWaitingUserMsg(characterData._lastTicketNoByRegion)
  local messageboxData = {
    title = PAGetString(Defines.StringSheet_GAME, "CHARACTER_ENTER_WAITING_TITLE"),
    content = strWaitingMsg,
    functionCancel = PaGlobalFunc_CharacterSelectRemaster_ClickCancel,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_1m,
    enablePriority = true
  }
  MessageBox.showMessageBox(messageboxData)
end
function FromClient_ChracterSelect_All_SetWaitingUserCount()
  if false == PaGlobal_CharacterSelect_All._playerData.isWaitLine then
    return
  end
  local strWaitingMsg = PaGlobalFunc_CharacterSelect_All_MakeWaitingUserMsg(-1)
  local messageboxData = {
    title = PAGetString(Defines.StringSheet_GAME, "CHARACTER_ENTER_WAITING_TITLE"),
    content = strWaitingMsg,
    functionCancel = PaGlobalFunc_CharacterSelectRemaster_ClickCancel,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_1m,
    enablePriority = true
  }
  if true == MessageBox.doHaveMessageBoxData(messageboxData.title) then
    setCurrentMessageData(messageboxData)
  else
    MessageBox.showMessageBox(messageboxData)
  end
end
function PaGlobalFunc_CharacterSelect_All_MakeWaitingUserMsg(receiveTicketNoMyRegion)
  local isPrimiumCharacter = PaGlobal_CharacterSelect_All._isPrimiumCharacter
  local ticketCountByRegion = receiveTicketNoMyRegion
  if -1 == ticketCountByRegion then
    local selectedCharacterData = getCharacterDataByIndex(PaGlobal_CharacterSelect_All._selectedCharIdx, isPrimiumCharacter)
    local regionInfo = getRegionInfoByPosition(selectedCharacterData._currentPosition)
    local regionGroupKey = 1
    if nil ~= regionInfo then
      regionGroupKey = regionInfo:getRegionGroupKey()
    end
    ticketCountByRegion = getTicketCountByRegion(regionGroupKey)
  end
  local currentTicketNo = getCurrentTicketNo()
  local firstTicketNoByAll = getFirstTicketNoByAll()
  local totalWaitingPlayerCount = getAllWaitingLine() - getAllCancelCount()
  local myRegionWaitingPlayerCount = getMyWaitingLine() - getCancelCount()
  if totalWaitingPlayerCount < 0 then
    totalWaitingPlayerCount = 0
  end
  if myRegionWaitingPlayerCount <= 0 then
    myRegionWaitingPlayerCount = 0
  end
  local waitMsg = PAGetString(Defines.StringSheet_GAME, "CHARACTER_WAIT_MESSAGE")
  local serverWaitStr = PAGetStringParam1(Defines.StringSheet_GAME, "CHARACTER_SERVER_WAIT_COUNT", "iCount", tostring(totalWaitingPlayerCount))
  local regionWaitStr = PAGetStringParam1(Defines.StringSheet_GAME, "CHARACTER_REGION_WAIT_COUNT", "iCount", tostring(myRegionWaitingPlayerCount))
  local emptyStr = PAGetString(Defines.StringSheet_GAME, "CHARACTER_WAITING_PLAYER_EMPTY")
  local taiwanMsg = ""
  if isGameTypeTaiwan() then
    taiwanMsg = "\n\n\233\187\145\232\137\178\230\178\153\230\188\160\231\130\186\229\150\174\228\184\128\228\184\150\231\149\140\229\133\168\228\188\186\230\156\141\229\153\168\229\133\177\233\128\154\239\188\140\229\156\168\233\129\138\230\136\178\230\153\130\229\143\175\229\156\168\229\144\132\233\160\187\233\129\147\233\150\147\232\135\170\231\148\177\231\167\187\229\139\149\239\188\140\232\171\139\233\129\184\230\147\135\233\128\178\232\161\140\232\188\131\233\160\134\229\136\169\231\154\132\233\160\187\233\129\147\231\153\187\229\133\165\233\129\138\230\136\178\229\141\179\229\143\175"
  end
  if Defines.s64_const.s64_m1 == firstTicketNoByAll and Defines.s64_const.s64_m1 ~= ticketCountByRegion then
    strWaitingMsg = waitMsg .. [[


]] .. regionWaitStr .. taiwanMsg
  elseif Defines.s64_const.s64_m1 == ticketCountByRegion and Defines.s64_const.s64_m1 ~= firstTicketNoByAll or Defines.s64_const.s64_m1 ~= ticketCountByRegion and 0 == myRegionWaitingPlayerCount then
    strWaitingMsg = waitMsg .. [[


]] .. serverWaitStr .. [[


]] .. PAGetString(Defines.StringSheet_GAME, "CHARACTER_REGION_WAIT_TEXT") .. emptyStr .. taiwanMsg
  else
    strWaitingMsg = waitMsg .. [[


]] .. serverWaitStr .. [[


]] .. regionWaitStr .. taiwanMsg
  end
  return strWaitingMsg
end
function PaGlobalFunc_CharacterSelect_All_CanMakeSeason()
  if nil == Panel_CharacterSelect_All then
    return false
  end
  return PaGlobal_CharacterSelect_All._canMakeSeason
end
