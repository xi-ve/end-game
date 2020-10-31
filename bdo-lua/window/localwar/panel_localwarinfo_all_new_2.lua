function PaGlobal_LocalWarInfo_All_New_Open()
  PaGlobal_LocalWarInfo_All_New:prepareOpen()
end
function PaGlobal_LocalWarInfo_All_New_Close()
  PaGlobal_LocalWarInfo_All_New:prepareClose()
end
function PaGlobal_LocalWarInfo_All_New_ShowAni()
  if nil == Panel_LocalWarInfo_All then
    return
  end
  Panel_LocalWarInfo_All:SetAlpha(0)
  UIAni.AlphaAnimation(1, Panel_LocalWarInfo_All, 0, 0.3)
end
function PaGlobal_LocalWarInfo_All_New_HideAni()
  if nil == Panel_LocalWarInfo_All then
    return
  end
  local hideAni = UIAni.AlphaAnimation(0, Panel_LocalWarInfo_All, 0, 0.2)
  hideAni:SetHideAtEnd(true)
end
function HandleEventLUp_LocalWarInfo_All_ClickMainTree(key)
  if nil == key then
    return
  end
  local treeData = PaGlobal_LocalWarInfo_All_New._treeMapTable[key]
  if nil == treeData then
    return
  end
  if false == treeData._isMain then
    return
  end
  PaGlobal_LocalWarInfo_All_New._ui._list2_serverList:getElementManager():toggle(toInt64(0, key))
  local heightIndex = PaGlobal_LocalWarInfo_All_New._ui._list2_serverList:getIndexByKey(toInt64(0, key))
  PaGlobal_LocalWarInfo_All_New._ui._list2_serverList:moveIndex(heightIndex)
  local tree2 = PaGlobal_LocalWarInfo_All_New._ui._list2_serverList
  for idx = 1, #PaGlobal_LocalWarInfo_All_New._treeMapTable do
    if nil ~= PaGlobal_LocalWarInfo_All_New._treeMapTable[idx] and true == PaGlobal_LocalWarInfo_All_New._treeMapTable[idx]._isMain then
      local keyElement = tree2:getElementManager():getByKey(toInt64(0, PaGlobal_LocalWarInfo_All_New._treeMapTable[idx]._keyIndex), false)
      local isOpen = keyElement:getIsOpen(false)
      local uiContent = PaGlobal_LocalWarInfo_All_New._ui._list2_serverList:GetContentByKey(toInt64(0, PaGlobal_LocalWarInfo_All_New._treeMapTable[idx]._keyIndex))
      if nil ~= uiContent then
        UI.getChildControl(uiContent, "StaticText_LocalWar_Rule"):SetCheck(isOpen)
      end
    end
  end
end
function HandleEventOnOut_LocalWarInfo_AllClickMainTree(isShow, type)
  if true == PaGlobal_LocalWarInfo_All_New._isConsole and true == PaGlobal_LocalWarInfo_All_New._ui._stc_picTooltip:GetShow() then
    PaGlobal_LocalWarInfo_All_New._ui._stc_picTooltip:SetShow(false)
    return
  end
  local posX = getMousePosX() - Panel_LocalWarInfo_All:GetPosX()
  local posY = getMousePosY() - Panel_LocalWarInfo_All:GetPosY()
  PaGlobal_LocalWarInfo_All_New._ui._stc_picTooltip:SetPosX(posX)
  PaGlobal_LocalWarInfo_All_New._ui._stc_picTooltip:SetPosY(posY)
  local textureName = ""
  if PaGlobal_LocalWarInfo_All_New._eMapKeyIndex._NORMAL == type then
    textureName = "new_ui_common_forlua/Window/LocalWarInfo/Map_Ruin.dds"
  elseif PaGlobal_LocalWarInfo_All_New._eMapKeyIndex._GAMOSNEST == type then
    textureName = "new_ui_common_forlua/Window/LocalWarInfo/Map_Nest.dds"
  end
  PaGlobal_LocalWarInfo_All_New._ui._stc_picTooltip:ChangeTextureInfoNameDefault(textureName)
  PaGlobal_LocalWarInfo_All_New._ui._stc_picTooltip:getBaseTexture():setUV(0, 0, 1, 1)
  PaGlobal_LocalWarInfo_All_New._ui._stc_picTooltip:setRenderTexture(PaGlobal_LocalWarInfo_All_New._ui._stc_picTooltip:getBaseTexture())
  PaGlobal_LocalWarInfo_All_New._ui._stc_picTooltip:SetShow(isShow)
end
function PaGlobal_LocalWarInfo_All_New_UpdateServerList(list_content, key)
  local id = Int64toInt32(key)
  local treeData = PaGlobal_LocalWarInfo_All_New._treeMapTable[id]
  if nil == treeData then
    return
  end
  local rdo_btn = UI.getChildControl(list_content, "StaticText_LocalWar_Rule")
  local stc_bg = UI.getChildControl(list_content, "Static_BG_1")
  local txt_channel = UI.getChildControl(stc_bg, "StaticText_Channel")
  local txt_joinMemberCount = UI.getChildControl(stc_bg, "StaticText_JoinMemberCount")
  local txt_remainTime = UI.getChildControl(stc_bg, "StaticText_RemainTime")
  local btn_join = UI.getChildControl(stc_bg, "Button_Join")
  local btn_seasonIcon = UI.getChildControl(stc_bg, "Static_Icon_Season")
  rdo_btn:addInputEvent("Mouse_LUp", "")
  rdo_btn:SetText("")
  rdo_btn:SetShow(false)
  stc_bg:SetShow(false)
  rdo_btn:setNotImpactScrollEvent(true)
  stc_bg:setNotImpactScrollEvent(true)
  if true == treeData._isMain then
    rdo_btn:SetShow(true)
    stc_bg:SetShow(false)
    rdo_btn:SetText(treeData._string)
    rdo_btn:addInputEvent("Mouse_LUp", "HandleEventLUp_LocalWarInfo_All_ClickMainTree(" .. id .. ")")
    if true == PaGlobal_LocalWarInfo_All_New._isConsole then
      rdo_btn:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "HandleEventOnOut_LocalWarInfo_AllClickMainTree(true," .. tostring(treeData._mapKey) .. ")")
    else
      rdo_btn:addInputEvent("Mouse_On", "HandleEventOnOut_LocalWarInfo_AllClickMainTree(true," .. tostring(treeData._mapKey) .. ")")
      rdo_btn:addInputEvent("Mouse_Out", "HandleEventOnOut_LocalWarInfo_AllClickMainTree(false," .. tostring(treeData._mapKey) .. ")")
    end
    return
  end
  rdo_btn:SetShow(false)
  stc_bg:SetShow(true)
  if nil == treeData._mapInfo then
    UI.ASSERT(false, "treeData._mapInfo \234\176\128 \236\151\134\236\150\180\236\132\156 \236\149\136\235\144\169\235\139\136\235\139\164.")
    return
  end
  local roomInfoWrapper = ToClient_InstanceFieldRoomInfoWrapperWithType(__eInstanceContentsType_LocalWar, treeData._mapInfo._index)
  if nil == roomInfoWrapper then
    return
  end
  stc_bg:SetShow(true)
  local getJoinMemberCount = roomInfoWrapper:getMatchedCount()
  local getCurrentState = roomInfoWrapper:getIsMatching()
  local channelName = roomInfoWrapper:getTitle()
  local getRemainTime = roomInfoWrapper:getLeftEnterTime()
  local warTimeMinute = math.floor(Int64toInt32(getRemainTime / toInt64(0, 60)))
  local warTimeSecond = Int64toInt32(getRemainTime) % 60
  local getFieldKey = roomInfoWrapper:getFieldMapKey()
  local fieldNameString = ToClient_getLocalWarRoomTypeString(getFieldKey)
  local getUniqueIndex = roomInfoWrapper:getUniqueIndex()
  local isSeasonOnly = ToClient_isSeasonLocalWar(getFieldKey)
  local warTime = ""
  if 0 == getCurrentState then
    warTime = PAGetString(Defines.StringSheet_GAME, "LUA_LOCALWARINFO_WAITING")
    btn_join:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_LOCALWARINFO_JOIN"))
    btn_join:SetIgnore(false)
  elseif 1 == getCurrentState then
    warTime = PAGetString(Defines.StringSheet_GAME, "LUA_LOCALWARINFO_JOIN_WAITING")
    btn_join:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_LOCALWARINFO_JOIN"))
    btn_join:SetIgnore(false)
  elseif 2 == getCurrentState then
    warTime = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_LOCALWARINFO_TIME", "warTimeMinute", warTimeMinute, "warTimeSecond", Int64toInt32(warTimeSecond))
    if 10 <= warTimeMinute then
      btn_join:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_LOCALWARINFO_JOIN"))
      btn_join:SetIgnore(false)
    else
      btn_join:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_LOCALWARINFO_CANTJOIN"))
      btn_join:SetIgnore(true)
    end
  else
    warTime = PAGetString(Defines.StringSheet_GAME, "LUA_LOCALWARINFO_CANTJOIN")
    btn_join:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_LOCALWARINFO_CANTJOIN"))
    btn_join:SetIgnore(true)
  end
  txt_channel:SetShow(true)
  txt_joinMemberCount:SetShow(true)
  txt_remainTime:SetShow(true)
  btn_join:SetShow(true)
  txt_channel:SetText(treeData._string .. " - " .. tostring(getUniqueIndex + 1))
  btn_seasonIcon:SetShow(isSeasonOnly)
  txt_joinMemberCount:SetText(getJoinMemberCount)
  txt_remainTime:SetText(warTime)
  btn_join:addInputEvent("Mouse_LUp", "HandleEventLUp_LocalWarInfo_All_New_JoinLocalWar(" .. tostring(treeData._mapInfo._index) .. "," .. tostring(isSeasonOnly) .. "," .. tostring(key) .. ")")
  if true == PaGlobal_LocalWarInfo_All_New._isConsole then
    btn_join:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "HandleEventOnOut_LocalWarInfo_AllClickMainTree(true," .. tostring(treeData._mapKey) .. ")")
  end
end
function PaGlobal_LocalWarInfo_All_New_InformationUpdate(deltaTime)
  if nil == Panel_LocalWarInfo_All or false == Panel_LocalWarInfo_All:GetShow() then
    return
  end
  local ruleControl = PaGlobal_LocalWarInfo_All_New._ui._rule
  local ruleMaxSize = PaGlobal_LocalWarInfo_All_New._maxRuleSize
  local rewardControl = PaGlobal_LocalWarInfo_All_New._ui._reward
  local rewardMaxSize = PaGlobal_LocalWarInfo_All_New._maxRewardSize
  local explanationControl = PaGlobal_LocalWarInfo_All_New._ui._explanation
  local explanationMaxSize = PaGlobal_LocalWarInfo_All_New._maxExplanationSize
  local frame = PaGlobal_LocalWarInfo_All_New._ui._frame_desc
  local vScroll = frame:GetVScroll()
  local content = frame:GetFrameContent()
  local SpeedTime = PaGlobal_LocalWarInfo_All_New._rule_ani_SpeedTime
  if ruleControl._txt_title:IsCheck() then
    local value = ruleControl._stc_background:GetSizeY() + (ruleMaxSize - ruleControl._stc_background:GetSizeY()) * deltaTime * SpeedTime
    if value < 10 then
      value = 10
    end
    vScroll:SetShow(frame:GetSizeY() < value + 170)
    content:SetSize(content:GetSizeX(), value + 170)
    ruleControl._stc_background:SetSize(ruleControl._stc_background:GetSizeX(), value)
    ruleControl._stc_background:SetShow(true)
  else
    local value = ruleControl._stc_background:GetSizeY() - (ruleMaxSize + ruleControl._stc_background:GetSizeY()) * deltaTime * SpeedTime
    if value < 10 then
      value = 10
    end
    ruleControl._stc_background:SetSize(ruleControl._stc_background:GetSizeX(), value)
    if ruleControl._stc_background:GetSizeY() <= 10 then
      ruleControl._stc_background:SetShow(false)
    end
  end
  if rewardControl._txt_title:IsCheck() then
    local value = rewardControl._stc_background:GetSizeY() + (rewardMaxSize - rewardControl._stc_background:GetSizeY()) * deltaTime * SpeedTime
    if value < 10 then
      value = 10
    end
    vScroll:SetShow(frame:GetSizeY() < value + 170)
    content:SetSize(content:GetSizeX(), value + 170)
    rewardControl._stc_background:SetSize(rewardControl._stc_background:GetSizeX(), value)
    rewardControl._stc_background:SetShow(true)
  else
    local value = rewardControl._stc_background:GetSizeY() - (rewardMaxSize + rewardControl._stc_background:GetSizeY()) * deltaTime * SpeedTime
    if value < 10 then
      value = 10
    end
    rewardControl._stc_background:SetSize(rewardControl._stc_background:GetSizeX(), value)
    if rewardControl._stc_background:GetSizeY() <= 10 then
      rewardControl._stc_background:SetShow(false)
    end
  end
  if explanationControl._txt_title:IsCheck() then
    local value = explanationControl._stc_background:GetSizeY() + (explanationMaxSize - explanationControl._stc_background:GetSizeY()) * deltaTime * SpeedTime
    if value < 10 then
      value = 10
    end
    vScroll:SetShow(frame:GetSizeY() < value + 170)
    content:SetSize(content:GetSizeX(), value + 170)
    explanationControl._stc_background:SetSize(explanationControl._stc_background:GetSizeX(), value)
    explanationControl._stc_background:SetShow(true)
  else
    local value = explanationControl._stc_background:GetSizeY() - (explanationMaxSize + explanationControl._stc_background:GetSizeY()) * deltaTime * SpeedTime
    if value < 10 then
      value = 10
    end
    explanationControl._stc_background:SetSize(explanationControl._stc_background:GetSizeX(), value)
    if explanationControl._stc_background:GetSizeY() <= 10 then
      explanationControl._stc_background:SetShow(false)
    end
  end
  ruleControl._stc_background:SetPosY(ruleControl._txt_title:GetPosY() + ruleControl._txt_title:GetSizeY())
  if ruleControl._stc_background:GetShow() then
    rewardControl._txt_title:SetPosY(ruleControl._stc_background:GetPosY() + ruleControl._stc_background:GetSizeY() + 10)
  else
    rewardControl._txt_title:SetPosY(ruleControl._txt_title:GetPosY() + ruleControl._txt_title:GetSizeY() + 5)
  end
  rewardControl._stc_background:SetPosY(rewardControl._txt_title:GetPosY() + rewardControl._txt_title:GetSizeY())
  if rewardControl._stc_background:GetShow() then
    explanationControl._txt_title:SetPosY(rewardControl._stc_background:GetPosY() + rewardControl._stc_background:GetSizeY() + 10)
  else
    explanationControl._txt_title:SetPosY(rewardControl._txt_title:GetPosY() + rewardControl._txt_title:GetSizeY() + 5)
  end
  explanationControl._stc_background:SetPosY(explanationControl._txt_title:GetPosY() + explanationControl._txt_title:GetSizeY())
  for _, control in pairs(ruleControl._txt_content) do
    control:SetShow(control:GetPosY() + control:GetSizeY() < ruleControl._stc_background:GetSizeY())
  end
  for _, control in pairs(rewardControl._txt_content) do
    control:SetShow(control:GetPosY() + control:GetSizeY() < rewardControl._stc_background:GetSizeY())
  end
  for _, control in pairs(explanationControl._txt_content) do
    control:SetShow(control:GetPosY() + control:GetSizeY() < explanationControl._stc_background:GetSizeY())
  end
end
function PaGlobal_LocalWarInfo_All_New_ESCMenuFunc()
  if nil == Panel_LocalWarInfo_All then
    return
  end
  if true == ToClient_IsInstanceRandomMatching() then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_BLOODALTAR_RANDOMMATCH_FAILACK"))
    return
  end
  local playerWrapper = getSelfPlayer()
  if nil == playerWrapper then
    return
  end
  local player = playerWrapper:get()
  if nil == player then
    return
  end
  local hp = player:getHp()
  local maxHp = player:getMaxHp()
  local isGameMaster = ToClient_SelfPlayerIsGM()
  if true == player:isCompetitionDefined() then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoCantDoAnythingAfterCompetitionStart"))
    return
  end
  if 0 == ToClient_GetMyTeamNoLocalWar() then
    if true == Panel_LocalWarInfo_All:GetShow() then
      PaGlobal_LocalWarInfo_All_New_Close()
    else
      PaGlobal_LocalWarInfo_All_New_Open()
    end
    return
  end
  local getOut = function()
    if false == IsSelfPlayerWaitAction() then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_LOCALWARINFO_WAITPOSITION_POSSIBLE"))
      return
    end
    ToClient_UnJoinInstanceFieldForAll()
    PaGlobal_LocalWarInfo_All_New_Close()
  end
  if hp == maxHp or isGameMaster then
    local messageBoxData = {
      title = PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_ALERT_NOTIFICATIONS"),
      content = PAGetString(Defines.StringSheet_GAME, "LUA_MENU_LOCALWAR_GETOUT_MEMO"),
      functionYes = getOut,
      functionNo = MessageBox_Empty_function,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageBoxData, "middle")
  else
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_CURRENTACTION_MAXHP_CHECK"))
  end
end
function HandleEventLUp_LocalWarInfo_All_DescriptionCheck(descType)
  local frame = PaGlobal_LocalWarInfo_All_New._ui._frame_desc
  local vScroll = frame:GetVScroll()
  vScroll:SetControlTop()
  frame:UpdateContentScroll()
  frame:UpdateContentPos()
  PaGlobal_LocalWarInfo_All_New._openDesc = descType
  if 0 == descType then
    PaGlobal_LocalWarInfo_All_New._ui._rule._stc_background:SetShow(true)
  elseif 1 == descType then
    PaGlobal_LocalWarInfo_All_New._ui._reward._stc_background:SetShow(true)
  elseif 2 == descType then
    PaGlobal_LocalWarInfo_All_New._ui._explanation._stc_background:SetShow(true)
  else
    PaGlobal_LocalWarInfo_All_New._openDesc = -1
  end
end
function HandleEventLUp_LocalWarInfo_All_New_JoinLocalWar(index, isSeasonOnly, uiKeyIndex)
  local roomCount = ToClient_requestGetInstancePrivateRoomCountWithType(__eInstanceContentsType_LocalWar)
  if nil == index or index > roomCount then
    return
  end
  local roomName = ""
  local uiContent = PaGlobal_LocalWarInfo_All_New._ui._list2_serverList:GetContentByKey(toInt64(0, uiKeyIndex))
  if nil ~= uiContent then
    local bg = UI.getChildControl(uiContent, "Static_BG_1")
    roomName = UI.getChildControl(bg, "StaticText_Channel"):GetText()
  end
  local function joinLocalWar()
    local playerWrapper = getSelfPlayer()
    if nil == playerWrapper then
      return
    end
    local player = playerWrapper:get()
    local hp = player:getHp()
    local maxHp = player:getMaxHp()
    local curChannelData = getCurrentChannelServerData()
    local isSeasonCharacter = player:isSeasonCharacter()
    if player:getLevel() < 50 then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_LOCALWARINFO_LEVELLIMIT"))
      return
    end
    _AudioPostEvent_SystemUiForXBOX(50, 1)
    if player:doRideMyVehicle() then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_LOCALWARINFO_NOT_RIDEHORSE"))
      return
    elseif ToClient_IsMyselfInArena() then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoCompetitionAlreadyIn"))
      return
    end
    if false == IsSelfPlayerWaitAction() then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_CURRENTACTION_NOT_LOCALWARINFO"))
      return
    end
    if true == isSeasonOnly and false == isSeasonCharacter then
      local messageBoxData = {
        title = PAGetString(Defines.StringSheet_GAME, "LUA_MESSAGEBOX_NOTIFY"),
        content = PAGetString(Defines.StringSheet_GAME, "LUA_INSATANCECONTENTS_SEASONONLY"),
        functionApply = MessageBox_Empty_function,
        priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
      }
      MessageBox.showMessageBox(messageBoxData)
      return
    end
    if hp == maxHp or true == ToClient_SelfPlayerIsGM() then
      ToClient_FindForJoinPrivateRoomForAll(__eInstanceContentsType_LocalWar, index)
      if true == _ContentsGroup_RenewUI then
        PaGlobal_LocalWarInfo_All_New_Close()
        local selfPlayer = getSelfPlayer()
        if nil == selfPlayer then
          return
        end
        if false == selfPlayer:isInstancePlayer() and false == getPvPMode() then
          local messageData = {
            title = PAGetString(Defines.StringSheet_GAME, "LUA_MESSAGEBOX_NOTIFY"),
            content = PAGetString(Defines.StringSheet_GAME, "GAME_MESSAGE_WAIT_PROCESS"),
            functionCancel = MessageBox_Empty_function,
            isLoading = true,
            priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_0
          }
          MessageBox.showMessageBox(messageData)
        end
      end
    else
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_CURRENTACTION_MAXHP_CHECK"))
    end
  end
  local messageBoxData = {
    title = PAGetString(Defines.StringSheet_GAME, "LUA_MESSAGEBOX_NOTIFY"),
    content = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_LOCALWARINFO_CHANNELMOVE", "channelName", roomName),
    functionYes = joinLocalWar,
    functionNo = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageBoxData)
end
function FromClient_LocalWarInfo_All_ResizePanel()
  if nil == Panel_LocalWarInfo_All then
    return
  end
  local screenSizeX = getScreenSizeX()
  local screenSizeY = getScreenSizeY()
  Panel_LocalWarInfo_All:SetPosX((screenSizeX - Panel_LocalWarInfo_All:GetSizeX()) / 2)
  Panel_LocalWarInfo_All:SetPosY((screenSizeY - Panel_LocalWarInfo_All:GetSizeY()) / 2)
end
function FromClient_LocalWarInfo_All_New_UpdateLocalWarStatus()
  if false == Panel_LocalWarInfo_All:GetShow() then
    return
  end
  PaGlobal_LocalWarInfo_All_New._ui._list2_serverList:requestUpdateVisible()
end
function FromClient_LocalWarInfo_All_New_UpdateInstanceRoom()
  local roomCount = ToClient_requestGetInstancePrivateRoomCountWithType(__eInstanceContentsType_LocalWar)
  if roomCount <= 0 then
    return
  end
  if false == PaGlobal_LocalWarInfo_All_New._initialize then
    PaGlobal_LocalWarInfo_All_New._initialize = true
    PaGlobal_LocalWarInfo_All_New:controlMapList_Init()
  else
    for index = 1, #PaGlobal_LocalWarInfo_All_New._treeMapTable do
      if nil ~= PaGlobal_LocalWarInfo_All_New._treeMapTable[index] then
        PaGlobal_LocalWarInfo_All_New._ui._list2_serverList:requestUpdateByKey(toInt64(0, index))
      end
    end
  end
end
