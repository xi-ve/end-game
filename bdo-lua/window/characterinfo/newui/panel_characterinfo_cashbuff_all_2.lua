function PaGlobal_CharInfoCashBuff_All_Update()
  if false == PaGlobalFunc_ChracterInfo_All_GetBgShow(PaGlobal_CharInfo_All._TABINDEX._cashBuff) then
    return
  end
  PaGlobal_CharInfoCashBuff_All._currentToolTipType = nil
  PaGlobal_CharInfoCashBuff_All._ui.stc_PopupTooltip:SetShow(false)
  PaGlobal_CharInfoCashBuff_All:update()
end
function PaGlobal_CharInfoCashBuff_All_list2Update(content, key)
  local key32 = Int64toInt32(key)
  for ii = 1, PaGlobal_CharInfoCashBuff_All._columnCount do
    local btn = UI.getChildControl(content, "Button_ListObject" .. ii)
    local dataIndex = key32 + (ii - 1)
    if dataIndex <= #PaGlobal_CharInfoCashBuff_All._listShowBuff then
      btn:SetShow(true)
      local buffType = PaGlobal_CharInfoCashBuff_All._listShowBuff[dataIndex]
      local name, desc, uv, leftTime = PaGlobal_CharInfoCashBuff_All:getBuffDataByType(buffType)
      local stc_buffIcon = UI.getChildControl(btn, "Static_BuffIcon")
      local txt_name = UI.getChildControl(btn, "StaticText_Name")
      local txt_desc = UI.getChildControl(btn, "StaticText_Desc")
      local txt_leftTime = UI.getChildControl(btn, "StaticText_RemainTime")
      stc_buffIcon:ChangeTextureInfoName("Combine/Icon/Combine_Icon_Buff_00.dds")
      local x1, y1, x2, y2 = setTextureUV_Func(stc_buffIcon, uv[1], uv[2], uv[3], uv[4])
      stc_buffIcon:getBaseTexture():setUV(x1, y1, x2, y2)
      stc_buffIcon:setRenderTexture(stc_buffIcon:getBaseTexture())
      txt_name:SetTextMode(__eTextMode_Limit_AutoWrap)
      txt_name:setLineCountByLimitAutoWrap(2)
      txt_name:SetText(name)
      txt_desc:SetTextMode(__eTextMode_Limit_AutoWrap)
      txt_desc:setLineCountByLimitAutoWrap(3)
      txt_desc:SetText(desc)
      txt_leftTime:SetShow(false)
      if nil ~= leftTime and 0 ~= leftTime then
        if PaGlobal_CharInfoCashBuff_All._eBUFF_TYPE.FeverBuff == buffType then
          txt_leftTime:SetText(leftTime)
        else
          txt_leftTime:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_SELFPLAYEREXPGAGE_AILINBUFF_TIME", "getPremiumPackageTime", leftTime))
        end
        txt_leftTime:SetShow(true)
      else
        txt_leftTime:SetShow(false)
      end
      btn:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandleEventPadPress_CharInfoCashBuff_All_ShowTooltip(" .. buffType .. "," .. tostring(key) .. "," .. ii .. ")")
      btn:addInputEvent("Mouse_LUp", "HandleEventLUp_CharinfoCashBuff_All_SelectBuff(" .. buffType .. "," .. tostring(key) .. "," .. ii .. ")")
      btn:addInputEvent("Mouse_On", "HandleEventLOut_CharinfoCashBuff_All_TooltipOff(" .. buffType .. ")")
    else
      btn:SetShow(false)
    end
  end
end
function HandleEventLUp_CharinfoCashBuff_All_SelectBuff(buffType, key, uiIdx)
  if PaGlobal_CharInfoCashBuff_All._eBUFF_TYPE.FeverBuff == buffType then
    PaGlobalFunc_CharInfoCashBuff_All_FeverBuffToggle(buffType, key, uiIdx)
  end
end
function HandleEventLOut_CharinfoCashBuff_All_TooltipOff(type)
  PaGlobal_CharInfoCashBuff_All._ui.stc_KeyGuide_A:SetShow(type == PaGlobal_CharInfoCashBuff_All._eBUFF_TYPE.FeverBuff)
  local keyguide = {
    PaGlobal_CharInfoCashBuff_All._ui.stc_KeyGuide_A,
    PaGlobal_CharInfoCashBuff_All._ui.stc_KeyGuide_X,
    PaGlobal_CharInfoCashBuff_All._ui.stc_KeyGuide_B
  }
  PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyguide, PaGlobal_CharInfoCashBuff_All._ui.stc_Console_KeyGuideBg, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHT)
  if (PaGlobal_CharInfoCashBuff_All._currentToolTipType ~= type or nil == type) and nil ~= PaGlobal_CharInfoCashBuff_All._currentToolTipType then
    PaGlobal_CharInfoCashBuff_All._ui.stc_PopupTooltip:SetShow(false)
  end
end
function HandleEventPadPress_CharInfoCashBuff_All_ShowTooltip(type, key, uiIdx)
  if nil == type or true == PaGlobal_CharInfoCashBuff_All._ui.stc_PopupTooltip:GetShow() then
    PaGlobal_CharInfoCashBuff_All._ui.stc_PopupTooltip:SetShow(false)
    return
  end
  PaGlobal_CharInfoCashBuff_All._currentToolTipType = type
  local name, desc, uv, leftTime = PaGlobal_CharInfoCashBuff_All:getBuffDataByType(type)
  local content = PaGlobal_CharInfoCashBuff_All._ui.list2_buff:GetContentByKey(key)
  local btn = UI.getChildControl(content, "Button_ListObject" .. uiIdx)
  local padding = 50
  PaGlobal_CharInfoCashBuff_All._ui.stc_PopupTooltip:SetSize(PaGlobal_CharInfoCashBuff_All._oriDescSizeX, PaGlobal_CharInfoCashBuff_All._oriDescSizeY)
  PaGlobal_CharInfoCashBuff_All._ui.stc_PopupTooltipBg:SetSize(PaGlobal_CharInfoCashBuff_All._oriDescSizeX, PaGlobal_CharInfoCashBuff_All._oriDescSizeY - (PaGlobal_CharInfoCashBuff_All._ui.stc_PopupTooltipBG_Title:GetSizeY() + 10))
  PaGlobal_CharInfoCashBuff_All._ui.stc_PopupTooltipDesc:SetSize(PaGlobal_CharInfoCashBuff_All._ui.stc_PopupTooltipBg:GetSizeX() - padding, PaGlobal_CharInfoCashBuff_All._ui.stc_PopupTooltipDesc:GetSizeY())
  PaGlobal_CharInfoCashBuff_All._ui.stc_PopupTooltipTitle:SetSize(PaGlobal_CharInfoCashBuff_All._ui.stc_PopupTooltipBg:GetSizeX() - padding, PaGlobal_CharInfoCashBuff_All._ui.stc_PopupTooltipTitle:GetSizeY())
  PaGlobal_CharInfoCashBuff_All._ui.stc_PopupTooltip:SetPosX(0)
  PaGlobal_CharInfoCashBuff_All._ui.stc_PopupTooltip:SetPosY(0)
  PaGlobal_CharInfoCashBuff_All._ui.stc_PopupTooltipDesc:SetText(desc)
  PaGlobal_CharInfoCashBuff_All._ui.stc_PopupTooltipTitle:SetText(name)
  local sizeX = PaGlobal_CharInfoCashBuff_All._ui.stc_PopupTooltipDesc:GetTextSizeX()
  local sizeY = PaGlobal_CharInfoCashBuff_All._ui.stc_PopupTooltipDesc:GetTextSizeY()
  local titleY = PaGlobal_CharInfoCashBuff_All._ui.stc_PopupTooltipTitle:GetTextSizeY()
  local titleX = PaGlobal_CharInfoCashBuff_All._ui.stc_PopupTooltipTitle:GetTextSizeX()
  local bgTitleY = PaGlobal_CharInfoCashBuff_All._ui.stc_PopupTooltipBG_Title:GetSizeY()
  if 0 == sizeX or 0 == sizeY then
    PaGlobal_CharInfoCashBuff_All._ui.stc_PopupTooltip:SetSize(PaGlobal_CharInfoCashBuff_All._oriDescSizeX, PaGlobal_CharInfoCashBuff_All._oriDescSizeY)
    PaGlobal_CharInfoCashBuff_All._ui.stc_PopupTooltipBg:SetSize(PaGlobal_CharInfoCashBuff_All._oriDescSizeX, PaGlobal_CharInfoCashBuff_All._oriDescSizeY - (PaGlobal_CharInfoCashBuff_All._ui.stc_PopupTooltipBG_Title:GetSizeY() + 10))
  else
    PaGlobal_CharInfoCashBuff_All._ui.stc_PopupTooltipDesc:SetSize(sizeX + 10, sizeY + 10)
    PaGlobal_CharInfoCashBuff_All._ui.stc_PopupTooltipTitle:SetSize(titleX + 10, titleY + 10)
    PaGlobal_CharInfoCashBuff_All._ui.stc_PopupTooltip:SetSize(math.max(sizeX + padding, titleX + padding), titleY + sizeY + padding + bgTitleY)
    PaGlobal_CharInfoCashBuff_All._ui.stc_PopupTooltipBg:SetSize(math.max(sizeX + padding, titleX + padding), titleY + sizeY + padding)
  end
  PaGlobal_CharInfoCashBuff_All._ui.stc_PopupTooltip:SetPosX(btn:GetPosX())
  PaGlobal_CharInfoCashBuff_All._ui.stc_PopupTooltip:SetPosY(btn:GetPosY())
  PaGlobal_CharInfoCashBuff_All._ui.stc_PopupTooltipDesc:ComputePos()
  PaGlobal_CharInfoCashBuff_All._ui.stc_PopupTooltipTitle:ComputePos()
  PaGlobal_CharInfoCashBuff_All._ui.stc_PopupTooltip:SetShow(true)
end
function FromClient_CharInfoCashBuff_All_EventChangedExplorationNode(wayPointKey)
  PaGlobalFunc_CharInfoCashBuff_All_UpdateExplorationNode(wayPointKey)
end
function FromClient_CharInfoCashBuff_All_EventUpdateExplorationNode(wayPointKey)
  if PaGlobal_CharInfoCashBuff_All._saveWayPoint == wayPointKey then
    PaGlobalFunc_CharInfoCashBuff_All_UpdateExplorationNode(wayPointKey)
  end
end
function PaGlobalFunc_CharInfoCashBuff_All_UpdateExplorationNode(wayPointKey)
  local nodeLv = ToClient_GetNodeLevel(wayPointKey)
  local nodeName = ToClient_GetNodeNameByWaypointKey(wayPointKey)
  local nodeExp = ToClient_GetNodeExperience_s64(wayPointKey)
  PaGlobal_CharInfoCashBuff_All._localNodeName = nodeName
  PaGlobal_CharInfoCashBuff_All._saveWayPoint = wayPointKey
  if 0 < nodeLv and nodeExp >= toInt64(0, 0) then
    PaGlobal_CharInfoCashBuff_All._localNodeInvestment = true
    PaGlobal_CharInfoCashBuff_All._currentNodeLv = nodeLv
  else
    PaGlobal_CharInfoCashBuff_All._localNodeInvestment = false
    PaGlobal_CharInfoCashBuff_All._currentNodeLv = 0
  end
  if true == PaGlobalFunc_ChracterInfo_All_GetBgShow(PaGlobal_CharInfo_All._TABINDEX._cashBuff) then
    PaGlobal_CharInfoCashBuff_All:update()
    return
  end
end
function FromClient_CharInfoCashBuff_All_FeverSkillToggle(apply)
  if true == apply then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_USE_FEVERPOINT"))
  else
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_DONTUSE_FEVERPOINT"))
  end
end
function PaGlobalFunc_CharInfoCashBuff_All_FeverBuffToggle()
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  ToClient_FeverBuffOnOff()
end
function FromClient_CharInfoCashBuff_All_OnScreenResize()
  Panel_CharacterInfoCashBuff_All:ComputePos()
end
