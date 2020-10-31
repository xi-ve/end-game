function Update_GreatSeaEvent_ProgressBar(deltaTime)
  local self = PaGlobal_GreatSeaEvent
  if self._updateCompleteTime < self._updateCurrentTime then
    return
  end
  self._updateCurrentTime = self._updateCurrentTime + deltaTime
  self._ui._progressBar:SetProgressRate(100 * self._updateCurrentTime / self._updateCompleteTime)
  if self._updateCompleteTime < self._updateCurrentTime then
    self:progressBarUpdateComplete()
  end
end
function FromClient_GreatSeaEvent(type, param0_s64, param1_s64, groupKey, selectIndex, regionKey, groupEventType)
  local self = PaGlobal_GreatSeaEvent
  local txt_result = ""
  local txt_subTitle = ToClient_getGreatSeaEventResultString(groupKey, selectIndex)
  local txt_imagePath = ToClient_getGreatSeaEventImagePath(groupKey, selectIndex)
  self._regionKey = regionKey
  if __eGreatSeaEvent_Food == type then
    if 0 < Int64toInt32(param0_s64) then
      txt_result = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_SEARCHING_FOOD_INCREASE_MAIN", "count", makeDotMoney(Int64toInt32(param0_s64)))
      audioPostEvent_SystemUi(26, 5)
      _AudioPostEvent_SystemUiForXBOX(26, 5)
    else
      txt_result = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_SEARCHING_FOOD_DECREASE_MAIN", "count", makeDotMoney(Int64toInt32(param0_s64) * -1))
      audioPostEvent_SystemUi(26, 6)
      _AudioPostEvent_SystemUiForXBOX(26, 6)
    end
  elseif __eGreatSeaEvent_Loyalty == type then
    if 0 < Int64toInt32(param0_s64) then
      txt_result = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_SEARCHING_LOYALTY_INCREASE_MAIN", "count", makeDotMoney(param0_s64))
      audioPostEvent_SystemUi(26, 5)
      _AudioPostEvent_SystemUiForXBOX(26, 5)
    else
      txt_result = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_SEARCHING_LOYALTY_DECREASE_MAIN", "count", makeDotMoney(Int64toInt32(param0_s64) * -1))
      audioPostEvent_SystemUi(26, 6)
      _AudioPostEvent_SystemUiForXBOX(26, 6)
    end
  elseif __eGreatSeaEvent_Hp == type then
    if 0 < Int64toInt32(param0_s64) then
      txt_result = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_SEARCHING_HP_INCREASE_MAIN", "count", makeDotMoney(param0_s64))
      audioPostEvent_SystemUi(26, 5)
      _AudioPostEvent_SystemUiForXBOX(26, 5)
    else
      txt_result = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_SEARCHING_HP_DECREASE_MAIN", "count", makeDotMoney(Int64toInt32(param0_s64) * -1))
      audioPostEvent_SystemUi(26, 6)
      _AudioPostEvent_SystemUiForXBOX(26, 6)
    end
  elseif __eGreatSeaEvent_Item == type then
    local itemWrapper = getItemEnchantStaticStatus(ItemEnchantKey(Uint64toUint32(param0_s64)))
    if nil == itemWrapper then
      return
    end
    txt_result = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_SEARCHING_ITEM_MAIN", "itemName", itemWrapper:getName(), "count", makeDotMoney(param1_s64))
    audioPostEvent_SystemUi(26, 5)
    _AudioPostEvent_SystemUiForXBOX(26, 5)
  elseif __eGreatSeaEvent_Quest == type then
    local questWrapper = questList_getQuestStatic(Int64toInt32(param0_s64), Int64toInt32(param1_s64))
    if nil == questWrapper then
      return
    end
    txt_result = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_SEARCHING_QUEST_MAIN", "questTitle", questWrapper:getTitle())
    audioPostEvent_SystemUi(26, 5)
    _AudioPostEvent_SystemUiForXBOX(26, 5)
  else
    txt_subTitle = PAGetString(Defines.StringSheet_GAME, "LUA_SEARCHING_NONE_SUB")
    txt_result = PAGetString(Defines.StringSheet_GAME, "LUA_SEARCHING_NONE_MAIN")
    txt_imagePath = "icon/new_icon/11_employee/explore_0000.dds"
    audioPostEvent_SystemUi(26, 7)
    _AudioPostEvent_SystemUiForXBOX(26, 7)
  end
  if __eGreatSeaGroupEventType_Move == groupEventType then
    self._ui._txt_seafaringMainDesc:SetText(txt_subTitle)
    self._ui._txt_seafaringSubDesc:SetText(txt_result)
    self:openSeafaringResearchPanel()
    Panel_Widget_GreatSeaEvent:SetShow(false)
  else
    self._ui._txt_subTitle:SetTextMode(__eTextMode_AutoWrap)
    self._ui._txt_subTitle:SetText(txt_subTitle)
    self._ui._txt_result:SetTextMode(__eTextMode_AutoWrap)
    self._ui._txt_result:SetText(txt_result)
    self._ui._txt_need:SetText("")
    if nil ~= txt_imagePath and "" ~= txt_imagePath then
      self._ui._resultImage:ChangeTextureInfoName(txt_imagePath)
    end
    Panel_Widget_GreatSeaEvent:SetShow(true)
  end
  Proc_ShowMessage_Ack_With_ChatType(txt_result, nil, CppEnums.ChatType.System, CppEnums.ChatSystemType.Undefine)
end
function HandleEventUpdate_SeafaringResearch_UpdateFrame(deltaTime)
  PaGlobal_GreatSeaEvent._currentSeafaringTime = PaGlobal_GreatSeaEvent._currentSeafaringTime + deltaTime
  if PaGlobal_GreatSeaEvent._completeSeafaringTime < PaGlobal_GreatSeaEvent._currentSeafaringTime then
    PaGlobal_GreatSeaEvent:closeSeafaringResearchPanel()
  end
end
function PaGloabl_SeafaringResearch_ShowAni()
  if nil == Panel_Widget_SeafaringResearch or nil == Panel_MainStatus_Remaster then
    return
  end
  local ImageMoveAni = Panel_Widget_SeafaringResearch:addMoveAnimation(0, 1, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
  local posY = Panel_MainStatus_Remaster:GetPosY() + Panel_MainStatus_Remaster:GetSizeY() + 10
  ImageMoveAni:SetStartPosition(-Panel_Widget_SeafaringResearch:GetSizeX() - 10, posY)
  ImageMoveAni:SetEndPosition(0, posY)
  ImageMoveAni.IsChangeChild = true
  Panel_Widget_SeafaringResearch:CalcUIAniPos(ImageMoveAni)
  ImageMoveAni:SetDisableWhileAni(true)
end
function PaGloabl_SeafaringResearch_HideAni()
  if nil == Panel_Widget_SeafaringResearch or nil == Panel_MainStatus_Remaster then
    return
  end
  local ImageMoveAni = Panel_Widget_SeafaringResearch:addMoveAnimation(0, 1, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
  local posY = Panel_MainStatus_Remaster:GetPosY() + Panel_MainStatus_Remaster:GetSizeY() + 10
  ImageMoveAni:SetStartPosition(0, posY)
  ImageMoveAni:SetEndPosition(-Panel_Widget_SeafaringResearch:GetSizeX() - 10, posY)
  ImageMoveAni.IsChangeChild = true
  Panel_Widget_SeafaringResearch:CalcUIAniPos(ImageMoveAni)
  ImageMoveAni:SetDisableWhileAni(true)
  ImageMoveAni:SetHideAtEnd(true)
end
