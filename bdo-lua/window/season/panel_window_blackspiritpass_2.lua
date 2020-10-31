function PaGlobal_BlackspiritPass_Open()
  if nil == Panel_Window_BlackspiritPass then
    return
  end
  PaGlobal_BlackspiritPass:prepareOpen()
end
function PaGlobal_BlackspiritPass_Close()
  if nil == Panel_Window_BlackspiritPass then
    return
  end
  Panel_Window_BlackspiritPass:CloseUISubApp()
  PaGlobal_BlackspiritPass:prepareClose()
end
function PaGlobal_BlackspiritPass_ShowAni()
  if nil == Panel_Window_BlackspiritPass then
    return
  end
end
function PaGlobal_BlackspiritPass_HideAni()
  if nil == Panel_Window_BlackspiritPass then
    return
  end
end
function PaGlobal_BlackspiritPass_UpdateListContent(content, key)
  if nil == Panel_Window_BlackspiritPass then
    return
  end
  PaGlobal_BlackspiritPass:updateListContent(content, key)
end
function PaGlobal_BlackspiritPass_IsThereAnyReward()
  if nil == Panel_Window_BlackspiritPass then
    return
  end
  local questCount = ToClient_SeasonPassQuestCount()
  local hasItemState = PaGlobal_BlackspiritPass._state.clear
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  PaGlobal_BlackspiritPass._hasSeasonPass = selfPlayer:get():isSeasonPass()
  for index = 0, questCount - 1 do
    local questInfo = PaGlobal_BlackspiritPass._questInfo[index]
    if nil ~= questInfo and (hasItemState == questInfo.normalQuestState or true == PaGlobal_BlackspiritPass._hasSeasonPass and hasItemState == questInfo.premiumQuestState) then
      return true
    end
  end
  return false
end
function PaGlobal_BlackspiritPass_OpenToIndex(listIdx, moveIndex)
  if nil == Panel_Window_BlackspiritPass then
    return
  end
  if nil == moveIndex then
    moveIndex = listIdx
  end
  PaGlobal_BlackspiritPass_Open()
  PaGlobal_BlackspiritPass._ui._list_quest:moveIndex(moveIndex)
  PaGlobal_BlackspiritPass._animListIdx = listIdx
  Panel_Window_BlackspiritPass:ClearUpdateLuaFunc()
  Panel_Window_BlackspiritPass:RegisterUpdateFunc("PaGlobal_BlackspiritPass_StampAnimation")
end
function PaGlobal_BlackspiritPass_StampAnimation(deltaTime)
  if nil == Panel_Window_BlackspiritPass then
    return
  end
  local startIndex = PaGlobal_BlackspiritPass._ui._list_quest:getCurrenttoIndex()
  local visibleContentCount = PaGlobal_BlackspiritPass._ui._list_quest:getChildContentListSize()
  local listIdx = PaGlobal_BlackspiritPass._animListIdx
  if startIndex <= listIdx and listIdx <= startIndex + visibleContentCount then
    local content = PaGlobal_BlackspiritPass._ui._list_quest:GetContentByKey(listIdx)
    if nil == content then
      return
    end
    local stc_missionStamp = UI.getChildControl(content, "Static_CompleteStamp")
    stc_missionStamp:SetShow(true)
    stc_missionStamp:ResetVertexAni()
    stc_missionStamp:SetVertexAniRun("Ani_Move_Pos_New", true)
    stc_missionStamp:SetVertexAniRun("Ani_Scale_New", true)
    Panel_Window_BlackspiritPass:ClearUpdateLuaFunc()
  end
end
function HandleEventOnOut_BlackspiritPass_ShowSeasonIconTooltip(isShow, index)
  if nil == Panel_Window_BlackspiritPass then
    return
  end
  if false == isShow then
    TooltipBlackSpiritPass_Hide()
    return
  end
  local title = PaGlobal_BlackspiritPass._seasonIconString[index]._title
  local desc = PaGlobal_BlackspiritPass._seasonIconString[index]._desc
  local showExpIcon = index == 1
  if 3 == index then
    local getRewardListStr = PaGlobalFunc_BlackSpiritPass_GetRewardTooltipString()
    if "" ~= getRewardListStr then
      desc = getRewardListStr
    end
  end
  TooltipBlackSpiritPass_Show(title, desc, showExpIcon)
end
function PaGlobalFunc_BlackSpiritPass_GetRewardTooltipString()
  local desc = PAGetString(Defines.StringSheet_GAME, "LUA_SEASON_REWARD_DESC_ETC")
  return desc
end
function HandleEventOnOut_BlackspiritPass_ShowItemTooltip(isShow, listIdx, isPremium, itemKey)
  if nil == Panel_Window_BlackspiritPass then
    return
  end
  if false == isShow then
    Panel_Tooltip_Item_hideTooltip()
    return
  end
  local itemSSW = getItemEnchantStaticStatus(ItemEnchantKey(itemKey))
  if nil ~= itemSSW then
    local content = PaGlobal_BlackspiritPass._ui._list_quest:GetContentByKey(listIdx)
    if nil == content then
      return
    end
    local control
    if false == isPremium then
      control = UI.getChildControl(content, "Static_NormalSlotBG")
    else
      control = UI.getChildControl(content, "Static_PremiumSlotBG")
    end
    Panel_Tooltip_Item_Show(itemSSW, control, true)
  end
end
function HandleEventLUp_BlackspiritPass_GetRewardItem(listIdx, isPremium)
  if nil == Panel_Window_BlackspiritPass then
    return
  end
  local questType
  if false == isPremium then
    questType = __eSeasonPassQuest_Normal
  else
    questType = __eSeasonPassQuest_SeasonPass
  end
  ToClient_RequestCompleteSeasonPassQuest(listIdx, questType)
  local content = PaGlobal_BlackspiritPass._ui._list_quest:GetContentByKey(listIdx)
  if nil == content then
    return
  end
  local rewardSlotBG
  if false == isPremium then
    rewardSlotBG = UI.getChildControl(content, "Static_NormalSlotBG")
  else
    rewardSlotBG = UI.getChildControl(content, "Static_PremiumSlotBG")
  end
  local slotIcon = UI.getChildControl(rewardSlotBG, "Static_Slot")
  local slotGet = UI.getChildControl(rewardSlotBG, "Static_Get")
  slotGet:SetShow(true)
  slotGet:SetAlpha(0)
  local ImageAni = slotGet:addColorAnimation(0.2, 0.4, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_LINEAR)
  ImageAni:SetStartColor(Defines.Color.C_00000000)
  ImageAni:SetEndColor(Defines.Color.C_FFFFFFFF)
  slotGet:EraseAllEffect()
  slotGet:AddEffect("fUI_BlackSpirit_Pass_Check_01A", false, 0, -1)
  slotGet:AddEffect("UI_Check_02A", false, 0, -1)
  slotIcon:SetMonoTone(true)
  slotIcon:addInputEvent("Mouse_LUp", "HandleEventLUp_BlackspiritPass_AlreadyGetReward()")
  slotIcon:EraseAllEffect()
  if false == isPremium then
    PaGlobal_BlackspiritPass._questInfo[listIdx].normalQuestState = PaGlobal_BlackspiritPass._state.clickedReward
  else
    PaGlobal_BlackspiritPass._questInfo[listIdx].premiumQuestState = PaGlobal_BlackspiritPass._state.clickedReward
  end
  PaGlobalFunc_Widget_FunctionButton_HandleUpdate(Widget_Function_Type.BlackSpiritPass)
  local questInfo = PaGlobal_BlackspiritPass._questInfo[listIdx]
  if nil ~= questInfo then
    local questNo = questInfo.normalQuestNo
    if PaGlobal_BlackspiritPass:isRepeatQuestion(questNo) and false == isPremium and true == PaGlobal_BlackspiritPass._hasSeasonPass then
      local premiumSlotBG = UI.getChildControl(content, "Static_PremiumSlotBG")
      local premiumSlotIcon = UI.getChildControl(premiumSlotBG, "Static_Slot")
      local premiumSlotGet = UI.getChildControl(premiumSlotBG, "Static_Get")
      premiumSlotIcon:SetMonoTone(false)
      premiumSlotGet:SetShow(false)
      premiumSlotIcon:addInputEvent("Mouse_LUp", "HandleEventLUp_BlackspiritPass_GetRewardItem( " .. listIdx .. ", true )")
      premiumSlotIcon:AddEffect("fUI_Tuto_ItemHp_01A", true, 0, 0)
    end
  end
end
function HandleEventLUp_BlackspiritPass_AlreadyGetReward()
  if nil == Panel_Window_BlackspiritPass then
    return
  end
  local msg = PAGetString(Defines.StringSheet_GAME, "LUA_SEASON_ALREADY_GET_REWARD")
  Proc_ShowMessage_Ack(msg)
end
function HandleEventLUp_BlackspiritPass_ShowEasyPayment()
  if nil == Panel_Window_BlackspiritPass then
    return
  end
  PaGlobal_EasyBuy:Open(80)
end
function FromClient_BlackspiritPass_ResizePanel()
  if nil == Panel_Window_BlackspiritPass then
    return
  end
  Panel_Window_BlackspiritPass:ComputePosAllChild()
  local screenSizeX = getScreenSizeX()
  local screenSizeY = getScreenSizeY()
  Panel_Window_BlackspiritPass:SetPosX((screenSizeX - Panel_Window_BlackspiritPass:GetSizeX()) / 2)
  Panel_Window_BlackspiritPass:SetPosY((screenSizeY - Panel_Window_BlackspiritPass:GetSizeY()) / 2)
  PaGlobal_BlackspiritPass:updateQuestListControl()
end
function FromClient_BlackspiritPass_UpdateSeasonPassQuest(questNoRaw)
  if nil == Panel_Window_BlackspiritPass then
    return
  end
  local questWrapper = questList_getQuestInfo(questNoRaw)
  if nil ~= questWrapper then
    local questNo = questWrapper:getQuestNo()
    local listIdx = PaGlobal_BlackspiritPass:getListIndex(questNo)
    if -1 ~= listIdx then
      PaGlobal_BlackspiritPass:updateQuestInfo(listIdx)
      local content = PaGlobal_BlackspiritPass._ui._list_quest:GetContentByKey(listIdx)
      if nil ~= content then
        local key = toInt64(0, listIdx)
        PaGlobal_BlackspiritPass:updateListContent(content, key)
      end
    end
    local state = PaGlobal_BlackspiritPass:getQuestState(questNo)
    if PaGlobal_BlackspiritPass._normalQuestIdx == questNo._quest then
      local demand
      local questInfo = ToClient_GetQuestInfo(questNo._group, questNo._quest)
      if nil ~= questInfo then
        demand = questInfo:getDemandAt(0)
      else
        local questStaticInfo = questList_getQuestStatic(questNo._group, questNo._quest)
        demand = questStaticInfo:getDemandAt(0)
      end
      if nil ~= demand then
        AcquireQuestDirect_UpdateQuestDemand(nil, demand, true)
      end
      if PaGlobal_BlackspiritPass._state.clear == state then
        if 3 <= listIdx then
          local moveIndex = listIdx - 2
          PaGlobal_BlackspiritPass_OpenToIndex(listIdx, moveIndex)
        else
          PaGlobal_BlackspiritPass_OpenToIndex(listIdx)
        end
      end
    end
  end
  PaGlobalFunc_Widget_FunctionButton_HandleUpdate(Widget_Function_Type.BlackSpiritPass)
end
function FromClient_BlackspiritPass_NotifyGetSeasonPass(isSuccess)
  if nil == Panel_Window_BlackspiritPass then
    return
  end
  PaGlobal_BlackspiritPass:updateSeasonPassLockState()
  PaGlobal_BlackspiritPass:updateTotalQuestInfo()
  PaGlobal_BlackspiritPass:updateQuestListControl()
  PaGlobalFunc_Widget_FunctionButton_HandleUpdate(Widget_Function_Type.BlackSpiritPass)
end
