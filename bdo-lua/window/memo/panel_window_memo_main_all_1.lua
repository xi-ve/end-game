function PaGlobal_Memo_All:initialize()
  if true == PaGlobal_Memo_All._initialize then
    return
  end
  PaGlobal_Memo_All._ui._stc_TitleBg = UI.getChildControl(Panel_Window_Memo_Main_All, "Static_TitleBG")
  PaGlobal_Memo_All._ui._btn_Close = UI.getChildControl(PaGlobal_Memo_All._ui._stc_TitleBg, "Button_Win_Close")
  PaGlobal_Memo_All._ui._btn_AddMemo = UI.getChildControl(Panel_Window_Memo_Main_All, "Button_AddMemo")
  PaGlobal_Memo_All._ui._btn_AllRemove = UI.getChildControl(Panel_Window_Memo_Main_All, "Button_AllDelete")
  PaGlobal_Memo_All._ui._List2 = UI.getChildControl(Panel_Window_Memo_Main_All, "List2_MemoList")
  PaGlobal_Memo_All._ui._Content = UI.getChildControl(PaGlobal_Memo_All._ui._List2, "List2_1_Content")
  PaGlobal_Memo_All._ui._scroll_List2Vertical = UI.getChildControl(PaGlobal_Memo_All._ui._List2, "List2_1_VerticalScroll")
  PaGlobal_Memo_All._ui._stcText_NoMemoAlert = UI.getChildControl(Panel_Window_Memo_Main_All, "StaticText_NoMemoAlert")
  Panel_Window_Memo_Main_All:SetShow(false)
  Panel_Window_Memo_Main_All:RegisterShowEventFunc(true, "PaGlobalFunc_Memo_Main_All_ShowAni()")
  Panel_Window_Memo_Main_All:RegisterShowEventFunc(false, "PaGlobalFunc_Memo_Main_All_HideAni()")
  local titleBG = UI.getChildControl(PaGlobal_Memo_All._ui._Content, "List2_Static_MemoList_TitleBG")
  local removeBtn = UI.getChildControl(PaGlobal_Memo_All._ui._Content, "List2_Button_MemoList_RemoveMemo")
  PaGlobal_Memo_All._memoTitleBG_OrgSizeX = titleBG:GetSizeX()
  PaGlobal_Memo_All._removeMemoBtn_OrgPosX = removeBtn:GetPosX()
  PaGlobal_Memo_All:registEventHandler()
  PaGlobal_Memo_All:validate()
  PaGlobal_Memo_All:DataInitialize()
  PaGlobal_Memo_All._initialize = true
end
function PaGlobal_Memo_All:registEventHandler()
  if nil == Panel_Window_Memo_Main_All then
    return
  end
  PaGlobal_Memo_All._ui._btn_AddMemo:addInputEvent("Mouse_LUp", "HandleEventLUp_Memo_Main_All_AddMemo()")
  PaGlobal_Memo_All._ui._btn_AllRemove:addInputEvent("Mouse_LUp", "HandleEventLUp_Memo_Main_All_MemoRemoveAll()")
  PaGlobal_Memo_All._ui._btn_Close:addInputEvent("Mouse_LUp", "HandleEventLUp_Memo_Main_All_ListClose()")
  PaGlobal_Memo_All._ui._List2:registEvent(__ePAUIList2EventType_LuaChangeContent, "PaGlobalFunc_Memo_List2EventControlCreate")
  PaGlobal_Memo_All._ui._List2:createChildContent(__ePAUIList2ElementManagerType_List)
end
function PaGlobal_Memo_All:prepareOpen()
  if nil == Panel_Window_Memo_Main_All then
    return
  end
  PaGlobal_Memo_All:open()
end
function PaGlobal_Memo_All:open()
  if nil == Panel_Window_Memo_Main_All then
    return
  end
  if false == Panel_Window_Memo_Main_All:IsShow() then
    Panel_Window_Memo_Main_All:SetShow(true, true)
    ToClient_refreshMemoUpdateTime()
    PaGlobal_Memo_All:ListUpdate()
  end
end
function PaGlobal_Memo_All:prepareClose()
  if nil == Panel_Window_Memo_Main_All then
    return
  end
  PaGlobal_Memo_All:close()
end
function PaGlobal_Memo_All:close()
  if nil == Panel_Window_Memo_Main_All then
    return
  end
  if true == Panel_Window_Memo_Main_All:IsShow() then
    Panel_Window_Memo_Main_All:SetShow(false, true)
  end
  TooltipSimple_Hide()
end
function PaGlobal_Memo_All:validate()
  if nil == Panel_Window_Memo_Main_All then
    return
  end
  PaGlobal_Memo_All._ui._stc_TitleBg:isValidate()
  PaGlobal_Memo_All._ui._btn_Close:isValidate()
  PaGlobal_Memo_All._ui._btn_AddMemo:isValidate()
  PaGlobal_Memo_All._ui._btn_AllRemove:isValidate()
  PaGlobal_Memo_All._ui._List2:isValidate()
  PaGlobal_Memo_All._ui._stcText_NoMemoAlert:isValidate()
end
function PaGlobal_Memo_All:AddMemo()
  if nil == Panel_Window_Memo_Main_All then
    return
  end
  local memoInfo = ToClient_addMemo()
  if nil == memoInfo then
    return
  end
  local newId = memoInfo:getId()
  PaGlobal_Memo_All._currentFocusId = newId
  PaGlobal_Memo_All._ui._List2:getElementManager():pushKey(toInt64(0, newId))
  PaGlobal_Memo_All:createStickyMemoWrapper(newId)
  if true == Panel_Window_Memo_Main_All:GetShow() then
    PaGlobal_Memo_All:StickySetDefaultPos(newId)
  end
  PaGlobal_Memo_All:ListUpdate()
end
function PaGlobal_Memo_All:Save(saveMode, inputId)
  if inputId ~= nil then
    PaGlobal_Memo_All._currentFocusId = inputId
  end
  local id = PaGlobal_Memo_All._currentFocusId
  local _saveMode = PaGlobal_Memo_All:ReCheckSaveMode(saveMode)
  if nil == _saveMode then
    return
  end
  local info = PaGlobal_Memo_All:getInfoByCurData(id)
  local result = ToClient_updateMemo(info, _saveMode)
  if false == result or _saveMode == PaGlobal_Memo_All._SaveMode.SETTING then
    return
  end
  PaGlobal_Memo_All:ListUpdate()
  PaGlobal_Memo_All:StickyClearFocus()
  PaGlobal_Memo_All:ComputeFrameContentSizeY(id)
end
function PaGlobal_Memo_All:memoRemove(id)
  local result = ToClient_removeMemo(id)
  if false == result then
    return
  end
  PaGlobal_Memo_All._ui._List2:getElementManager():removeKey(id)
  if nil ~= PaGlobal_Memo_All._stickyMemoList[id] then
    PaGlobal_Memo_All._stickyMemoList[id]:clear()
    PaGlobal_Memo_All._stickyMemoList[id] = nil
  end
  TooltipSimple_Hide()
  PaGlobal_Memo_All:ListUpdate()
  PaGlobal_Memo_All:StickyClearFocus()
end
function PaGlobal_Memo_All:MemoRemoveAll()
  if nil == Panel_Window_Memo_Main_All then
    return
  end
  local memoCount = ToClient_getMemoCount()
  if 0 == memoCount then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_MEMOLIST_NOMEMO"))
    return
  end
  local applyFunc = function()
    ToClient_removeAllMemo()
    for k in pairs(PaGlobal_Memo_All._id) do
      local id = PaGlobal_Memo_All._id[k]
      if nil ~= PaGlobal_Memo_All._stickyMemoList[id] then
        PaGlobal_Memo_All._stickyMemoList[id]:clear()
        PaGlobal_Memo_All._stickyMemoList[id] = nil
      end
      PaGlobal_Memo_All._ui._List2:getElementManager():removeKey(id)
    end
    PaGlobal_Memo_All:ListUpdate()
    PaGlobal_Memo_All:StickyClearFocus()
  end
  local _title = PAGetString(Defines.StringSheet_GAME, "LUA_MEMOLIST_DELETETITLE")
  local _content = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_MEMOLIST_DELETEDESC", "count", memoCount)
  local messageBoxData = {
    title = _title,
    content = _content,
    functionYes = applyFunc,
    functionNo = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageBoxData)
end
function PaGlobal_Memo_All:ListUpdate()
  if nil == Panel_Window_Memo_Main_All then
    return
  end
  if false == Panel_Window_Memo_Main_All:IsShow() then
    return
  end
  local memoCount = ToClient_getMemoCount()
  if memoCount == 0 then
    PaGlobal_Memo_All._ui._stcText_NoMemoAlert:SetShow(true)
    return false
  end
  PaGlobal_Memo_All._ui._stcText_NoMemoAlert:SetShow(false)
  for k in pairs(PaGlobal_Memo_All._id) do
    PaGlobal_Memo_All._id[k] = nil
  end
  for index = 0, memoCount - 1 do
    local reverse_index = memoCount - 1 - index
    PaGlobal_Memo_All._id[index] = ToClient_getMemoIdAt(reverse_index)
  end
  PaGlobal_Memo_All._ui._List2:getElementManager():clearKey()
  for index = 0, memoCount - 1 do
    PaGlobal_Memo_All._ui._List2:getElementManager():pushKey(toInt64(0, PaGlobal_Memo_All._id[index]))
    PaGlobal_Memo_All._ui._List2:requestUpdateByKey(toInt64(0, PaGlobal_Memo_All._id[index]))
  end
end
function PaGlobal_Memo_All:ListClose()
  if nil == Panel_Window_Memo_Main_All then
    return
  end
  if Panel_Window_Memo_Main_All:IsShow() then
    Panel_Window_Memo_Main_All:SetShow(false, true)
  end
  TooltipSimple_Hide()
end
function PaGlobalFunc_Memo_List2EventControlCreate(list_content, key)
  if nil == Panel_Window_Memo_Main_All then
    return
  end
  local id = Int64toInt32(key)
  local memoInfo = ToClient_getMemo(id)
  local _content = memoInfo:getContent()
  local bg = UI.getChildControl(list_content, "List2_Static_MemoList_TitleBG")
  local content = UI.getChildControl(list_content, "List2_StaticText_MemoList_Content")
  local toggleButton = UI.getChildControl(list_content, "List2_CheckButton_MemoList_ToggleShow")
  local removeButton = UI.getChildControl(list_content, "List2_Button_MemoList_RemoveMemo")
  local updatetime = UI.getChildControl(list_content, "List2_StaticText_MemoList_UpdateTime")
  content:SetShow(true)
  if "" == _content or "Content" == _content then
    _content = PAGetString(Defines.StringSheet_GAME, "LUA_MEMO_INSERTCONTENT")
  end
  content:SetText(_content)
  content:setLineCountByLimitAutoWrap(3)
  content:SetTextMode(__eTextMode_Limit_AutoWrap)
  updatetime:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_MEMO_LASTUPDATE", "time", memoInfo:getUpdateTime()))
  toggleButton:SetCheck(true == memoInfo:isOn())
  PaGlobal_Memo_All:Resize_MemoTitleList(bg, removeButton)
  function MemoList_SimpleTooltipShow(uiType)
    local uiControl, name
    if 0 == uiType then
      uiControl = toggleButton
      name = PAGetString(Defines.StringSheet_GAME, "LUA_MEMOLIST_TOGGLE")
    elseif 1 == uiType then
      uiControl = removeButton
      name = PAGetString(Defines.StringSheet_GAME, "LUA_MEMOLIST_DELETE")
    end
    TooltipSimple_Show(uiControl, name)
  end
  function MemoList_SimpleTooltipHide()
    TooltipSimple_Hide()
  end
  bg:addInputEvent("Mouse_LDClick", "HandleEventLDClick_Memo_Main_All_StickyToggleShow( " .. id .. ")")
  toggleButton:addInputEvent("Mouse_LUp", "HandleEventLUp_Memo_Main_All_StickyToggleShow( " .. id .. ")")
  toggleButton:addInputEvent("Mouse_On", "MemoList_SimpleTooltipShow(" .. 0 .. ")")
  toggleButton:addInputEvent("Mouse_Out", "MemoList_SimpleTooltipHide()")
  removeButton:addInputEvent("Mouse_LUp", "HandleEventLUp_Memo_Main_All_RemoveConfirmPopUp( " .. id .. " ) ")
  removeButton:addInputEvent("Mouse_On", "MemoList_SimpleTooltipShow(" .. 1 .. ")")
  removeButton:addInputEvent("Mouse_Out", "MemoList_SimpleTooltipHide()")
end
function PaGlobal_Memo_All:Resize_MemoTitleList(titleBG, removeBtn)
  if nil == Panel_Window_Memo_Main_All then
    return
  end
  local value = 20
  local isScrollShow = PaGlobal_Memo_All._ui._scroll_List2Vertical:GetShow()
  if false == isScrollShow then
    titleBG:SetSize(PaGlobal_Memo_All._memoTitleBG_OrgSizeX + value, titleBG:GetSizeY())
    removeBtn:SetPosX(PaGlobal_Memo_All._removeMemoBtn_OrgPosX + value)
  else
    titleBG:SetSize(PaGlobal_Memo_All._memoTitleBG_OrgSizeX, titleBG:GetSizeY())
    removeBtn:SetPosX(PaGlobal_Memo_All._removeMemoBtn_OrgPosX)
  end
end
function PaGlobal_Memo_All:RemoveConfirmPopUp(id)
  local function applyFunc()
    PaGlobal_Memo_All:memoRemove(id)
  end
  local _title = PAGetString(Defines.StringSheet_GAME, "LUA_MEMOLIST_CURRENTDELETEDTITLE")
  local _content = PAGetString(Defines.StringSheet_GAME, "LUA_MEMOLIST_CURRENTDELETEDESC")
  local messageBoxData = {
    title = _title,
    content = _content,
    functionYes = applyFunc,
    functionNo = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageBoxData)
end
function PaGlobal_Memo_All:StickyClearFocus()
  ClearFocusEdit()
  PaGlobal_Memo_All._currentFocusId = nil
  PaGlobal_Memo_All._currentFocusContent = nil
end
function PaGlobal_Memo_All:memo_List_ShowAni()
  if nil == Panel_Window_Memo_Main_All then
    return
  end
  audioPostEvent_SystemUi(1, 22)
  _AudioPostEvent_SystemUiForXBOX(1, 22)
  local aniInfo1 = Panel_Window_Memo_Main_All:addScaleAnimation(0, 0.08, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfo1:SetStartScale(0.5)
  aniInfo1:SetEndScale(1.12)
  aniInfo1.AxisX = Panel_Window_Memo_Main_All:GetSizeX() / 2
  aniInfo1.AxisY = Panel_Window_Memo_Main_All:GetSizeY() / 2
  aniInfo1.ScaleType = 2
  aniInfo1.IsChangeChild = true
  local aniInfo2 = Panel_Window_Memo_Main_All:addScaleAnimation(0.08, 0.15, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfo2:SetStartScale(1.12)
  aniInfo2:SetEndScale(1)
  aniInfo2.AxisX = Panel_Window_Memo_Main_All:GetSizeX() / 2
  aniInfo2.AxisY = Panel_Window_Memo_Main_All:GetSizeY() / 2
  aniInfo2.ScaleType = 2
  aniInfo2.IsChangeChild = true
end
function PaGlobal_Memo_All:memo_List_HideAni()
  if nil == Panel_Window_Memo_Main_All then
    return
  end
  audioPostEvent_SystemUi(1, 21)
  _AudioPostEvent_SystemUiForXBOX(1, 21)
  local aniInfo1 = Panel_Window_Memo_Main_All:addColorAnimation(0, 0.1, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
  aniInfo1:SetStartColor(Defines.Color.C_FFFFFFFF)
  aniInfo1:SetEndColor(Defines.Color.C_00FFFFFF)
  aniInfo1:SetStartIntensity(3)
  aniInfo1:SetEndIntensity(1)
  aniInfo1.IsChangeChild = true
  aniInfo1:SetHideAtEnd(true)
  aniInfo1:SetDisableWhileAni(true)
end
function PaGlobal_Memo_All:ReCheckSaveMode(saveMode)
  if nil == Panel_Window_Memo_Main_All then
    return
  end
  if saveMode ~= PaGlobal_Memo_All._SaveMode.SETTING then
    if nil == PaGlobal_Memo_All._currentFocusId then
      return nil
    end
    if saveMode == PaGlobal_Memo_All._SaveMode.ALL then
      return PaGlobal_Memo_All._SaveMode.ALL
    end
    if false == PaGlobal_Memo_All:IsChanged() then
      PaGlobal_Memo_All:StickyClearFocus()
      return nil
    end
    return PaGlobal_Memo_All._SaveMode.TEXT
  else
    return PaGlobal_Memo_All._SaveMode.SETTING
  end
end
function PaGlobal_Memo_All:IsChanged()
  if nil == Panel_Window_Memo_Main_All then
    return
  end
  if PaGlobal_Memo_All._currentFocusId == nil then
    return false
  end
  local stickyMemo = PaGlobal_Memo_All._stickyMemoList[PaGlobal_Memo_All._currentFocusId]
  if PaGlobal_Memo_All._currentFocusContent == stickyMemo._ui._MultiLineText:GetEditText() then
    return false
  end
  return true
end
function PaGlobal_Memo_All:getInfoByCurData(id)
  if nil == Panel_Window_Memo_Main_All then
    return
  end
  local stickyMemo = PaGlobal_Memo_All._stickyMemoList[id]
  local posX = stickyMemo._mainPanel:GetPosX()
  local posY = stickyMemo._mainPanel:GetPosY()
  if true == stickyMemo._isSubAppMode then
    local memoInfo = ToClient_getMemo(id)
    posX = memoInfo:getPositionX()
    posY = memoInfo:getPositionY()
  end
  local info = MemoInfo(id)
  info:setInfo(stickyMemo._ui._MultiLineText:GetEditText(), stickyMemo._isOn, int2(posX, posY), int2(stickyMemo._mainPanel:GetSizeX(), stickyMemo._mainPanel:GetSizeY()), stickyMemo._stickyMemoAlpha, stickyMemo._stickyMemoColor)
  return info
end
function PaGlobal_Memo_All:Tooltip_Show(uiType)
  if nil == Panel_Window_Memo_Main_All then
    return
  end
  local uiControl, name, desc
  if 0 == uiType then
    uiControl = stickyMemo._ui._btn_Close
    name = PAGetString(Defines.StringSheet_GAME, "LUA_MEMO_CLOSE")
  elseif 1 == uiType then
    uiControl = stickyMemo._ui._btn_SliderButton
    name = PAGetString(Defines.StringSheet_GAME, "LUA_MEMO_TRANSPARENCY")
  elseif 2 == uiType then
    uiControl = stickyMemo._ui._btn_AddMemo
    name = PAGetString(Defines.StringSheet_GAME, "LUA_MEMO_ADD")
  elseif 3 == uiType then
    uiControl = stickyMemo._ui._checkBox_Popup
    name = PAGetString(Defines.StringSheet_GAME, "LUA_POPUI_TOOLTIP_NAME")
    if stickyMemo._ui._checkBox_Popup:IsCheck() then
      desc = PAGetString(Defines.StringSheet_GAME, "LUA_POPUI_CHECK_TOOLTIP")
    else
      desc = PAGetString(Defines.StringSheet_GAME, "LUA_POPUI_NOCHECK_TOOLTIP")
    end
  elseif 4 == uiType then
    uiControl = stickyMemo._ui._btn_ColorChange
    name = PAGetString(Defines.StringSheet_GAME, "LUA_MEMO_COLORCHANGE")
  end
  TooltipSimple_Show(uiControl, name, desc)
end
function PaGlobal_Memo_All:Tooltip_Hide()
  if nil == Panel_Window_Memo_Main_All then
    return
  end
  TooltipSimple_Hide()
end
function PaGlobal_Memo_All:DataInitialize()
  if nil == Panel_Window_Memo_Main_All then
    return
  end
  local memoCount = ToClient_getMemoCount()
  if memoCount == 0 then
    return false
  end
  local elements = {}
  for index = 0, memoCount - 1 do
    elements[index] = ToClient_getMemoAt(index)
  end
  for index = 0, memoCount - 1 do
    local memoInfo = elements[index]
    local id = memoInfo:getId()
    local reverse_index = memoCount - 1 - index
    PaGlobal_Memo_All._id[reverse_index] = id
  end
  local list2 = PaGlobal_Memo_All._ui._List2
  for index = 0, memoCount - 1 do
    list2:getElementManager():pushKey(toInt64(0, PaGlobal_Memo_All._id[index]))
    list2:requestUpdateByKey(toInt64(0, PaGlobal_Memo_All._id[index]))
  end
  for index = 0, memoCount - 1 do
    local memoInfo = elements[index]
    if true == memoInfo:isOn() then
      PaGlobal_Memo_All:createStickyMemoWrapper(memoInfo:getId())
    end
  end
end
