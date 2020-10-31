function PaGlobal_Achievement_BookShelf_All:initialize()
  if true == self._initialize then
    return
  end
  self:initControl()
  self:setShowControl()
  self:setBookShelf()
  self:update()
  self:registEventHandler()
  self:validate()
  self._initialize = true
end
function PaGlobal_Achievement_BookShelf_All:initControl()
  self._ui.stc_TopArea = UI.getChildControl(Panel_Window_Achievement_BookShelf_All, "Static_TopArea")
  self._ui.stc_CenterArea = UI.getChildControl(Panel_Window_Achievement_BookShelf_All, "Static_CenterArea")
  self._ui.stc_FamilyWidget = UI.getChildControl(Panel_Window_Achievement_BookShelf_All, "Static_FamilyStat_Widget")
  self._ui.stc_familyWidget_SubBG = UI.getChildControl(self._ui.stc_FamilyWidget, "Static_SubBG")
  self._ui.stc_LeftArea = UI.getChildControl(self._ui.stc_CenterArea, "Static_LeftArea")
  self._ui.stc_RightArea = UI.getChildControl(self._ui.stc_CenterArea, "Static_RightArea")
  self._ui.stc_BtnClose = UI.getChildControl(self._ui.stc_TopArea, "Static_Close")
  self._ui.stc_Chapter = UI.getChildControl(self._ui.stc_LeftArea, "Static_Chapter")
  self._ui.stc_ChapterSlot = UI.getChildControl(self._ui.stc_Chapter, "Static_Chapter_Template")
  self._ui.stc_ChapterTitle = UI.getChildControl(self._ui.stc_ChapterSlot, "StaticText_ChapterTitle")
  self._ui.txt_FamilyStatIcon = UI.getChildControl(self._ui.stc_LeftArea, "StaticText_FamilyStat")
  self._ui.txt_LeftTitle = UI.getChildControl(self._ui.stc_LeftArea, "StaticText_Left_Title")
  self._ui.txt_BookShelfDesc = UI.getChildControl(self._ui.stc_LeftArea, "StaticText_BookShelf_Desc")
  self._ui.txt_BookShelfDesc:SetTextMode(__eTextMode_AutoWrap)
  self._ui.txt_SelectedBookName = UI.getChildControl(self._ui.stc_LeftArea, "StaticText_BookShelf_SelectedBook")
  self._ui.frame_BookShelf = UI.getChildControl(self._ui.stc_RightArea, "Frame_BookShelf")
  self._ui.frame_BookShelfContent = UI.getChildControl(self._ui.frame_BookShelf, "Frame_1_Content")
  self._ui.btn_BookArea = UI.getChildControl(self._ui.frame_BookShelfContent, "RadioButton_BookArea")
  self._ui.txt_BookTitle = UI.getChildControl(self._ui.btn_BookArea, "StaticText_BookTitle")
  self._ui.stc_BookGroup = UI.getChildControl(self._ui.btn_BookArea, "Static_BookGroup")
  self._ui.stc_EmptyGroup_1 = UI.getChildControl(self._ui.btn_BookArea, "Static_EmptyGroup_1")
  self._ui.stc_EmptyGroup_1_object = UI.getChildControl(self._ui.stc_EmptyGroup_1, "Static_Watch")
  self._ui.stc_EmptyGroup_2 = UI.getChildControl(self._ui.btn_BookArea, "Static_EmptyGroup_2")
  self._ui.stc_EmptyGroup_2_object = UI.getChildControl(self._ui.stc_EmptyGroup_2, "Static_Vase")
  self._ui.stc_EmptyGroup_3 = UI.getChildControl(self._ui.btn_BookArea, "Static_EmptyGroup_3")
  self._ui.stc_EmptyGroup_3_object_1 = UI.getChildControl(self._ui.stc_EmptyGroup_3, "Static_CandleStick_1")
  self._ui.stc_EmptyGroup_3_object_2 = UI.getChildControl(self._ui.stc_EmptyGroup_3, "Static_CandleStick_2")
  self._ui.stc_EmptyGroup_4 = UI.getChildControl(self._ui.btn_BookArea, "Static_EmptyGroup_4")
  self._ui.stc_EmptyGroup_4_object_1 = UI.getChildControl(self._ui.stc_EmptyGroup_4, "Static_Teapot")
  self._ui.stc_EmptyGroup_4_object_2 = UI.getChildControl(self._ui.stc_EmptyGroup_4, "Static_Cup")
  self._ui.stc_BookImage = UI.getChildControl(self._ui.stc_BookGroup, "Static_BookImage")
  self._ui.stc_KeyGuide = UI.getChildControl(Panel_Window_Achievement_BookShelf_All, "Static_Console_Buttons")
  self._defaultFamilyWidgetSizeY = self._ui.stc_FamilyWidget:GetSizeY()
end
function PaGlobal_Achievement_BookShelf_All:setShowControl()
  self._ui.stc_FamilyWidget:SetShow(false)
  if _ContentsGroup_UsePadSnapping then
    self._ui.stc_KeyGuide:SetShow(true)
    self._ui.stc_BtnClose:SetShow(false)
  end
end
function PaGlobal_Achievement_BookShelf_All:setKeyGuide()
  local btn_Y = UI.getChildControl(self._ui.stc_KeyGuide, "Button_Y_ConsoleUI")
  local btn_B = UI.getChildControl(self._ui.stc_KeyGuide, "Button_B_ConsoleUI")
  local btn_A = UI.getChildControl(self._ui.stc_KeyGuide, "Button_A_ConsoleUI")
  local btn_X = UI.getChildControl(self._ui.stc_KeyGuide, "Button_X_ConsoleUI")
  local keyGuide = {
    btn_X,
    btn_Y,
    btn_A,
    btn_B
  }
  PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyGuide, self._ui.stc_KeyGuide, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHT)
end
function PaGlobal_Achievement_BookShelf_All:registEventHandler()
  if nil == Panel_Window_Achievement_BookShelf_All then
    return
  end
  Panel_Window_Achievement_BookShelf_All:registerPadEvent(__eConsoleUIPadEvent_Y, "PaGlobalFunc_Achievement_BookShelf_All_ShowToggleFamilyWidget()")
  self._ui.txt_FamilyStatIcon:addInputEvent("Mouse_LUp", "PaGlobalFunc_Achievement_BookShelf_All_ShowToggleFamilyWidget()")
  self._ui.stc_BtnClose:addInputEvent("Mouse_LUp", "PaGlobalFunc_Achievement_BookShelf_All_Close()")
  registerEvent("FromClient_UpdateQuestList", "FromClient_Achievement_BookShelf_All_UpdateQuestList")
end
function PaGlobal_Achievement_BookShelf_All:prepareOpen()
  if nil == Panel_Window_Achievement_BookShelf_All then
    return
  end
  self:update()
  self:open()
  audioPostEvent_SystemUi(1, 48)
  _AudioPostEvent_SystemUiForXBOX(1, 48)
end
function PaGlobal_Achievement_BookShelf_All:open()
  if nil == Panel_Window_Achievement_BookShelf_All then
    return
  end
  Panel_Window_Achievement_BookShelf_All:SetShow(true)
end
function PaGlobal_Achievement_BookShelf_All:prepareClose()
  if nil == Panel_Window_Achievement_BookShelf_All then
    return
  end
  PaGlobal_Achievement_BookShelf_All._ui.txt_SelectedBookName:SetText("")
  self:close()
end
function PaGlobal_Achievement_BookShelf_All:close()
  if nil == Panel_Window_Achievement_BookShelf_All then
    return
  end
  Panel_Window_Achievement_BookShelf_All:SetShow(false)
end
function PaGlobal_Achievement_BookShelf_All:update()
  if nil == Panel_Window_Achievement_BookShelf_All then
    return
  end
  self:setFamilyWidget()
  self:updateJournalList()
  self:selectJournal(self._selectedJournalGroup)
end
function PaGlobal_Achievement_BookShelf_All:returnBookTextureKey(textureKeyGroup, index)
  if nil == textureKeyGroup or nil == index or nil == textureKeyGroup._cntGroup then
    return
  end
  for ii = 1, #textureKeyGroup._cntGroup do
    if index <= textureKeyGroup._cntGroup[ii] then
      return ii
    end
  end
  return
end
function PaGlobal_Achievement_BookShelf_All:setBookShelfTexture(journalKey, chapterCnt)
  if nil == journalKey or nil == chapterCnt then
    return
  end
  local journalGroupIdx = self._journalGroupIndexList[journalKey]
  if nil == journalGroupIdx then
    return
  end
  local textureKey = ToClient_GetJournalShape(journalGroupIdx)
  if nil == textureKey then
    textureKey = journalGroupIdx
  end
  local textureKeyGroup = self._bookAreaTextureKeyGroup[textureKey]
  if nil == textureKeyGroup then
    textureKeyGroup = self._bookAreaTextureKeyGroup[1]
  end
  if nil == textureKeyGroup then
    return
  end
  local journalContent = self._journalControlList[journalKey]
  self._journalControlList[journalKey].chapterList = {}
  if nil == journalContent then
    return
  end
  local nextPosX = 0
  for ii = 1, textureKeyGroup._cnt do
    local textureKeyIndex = self:returnBookTextureKey(textureKeyGroup, ii)
    if nil == textureKeyIndex then
      textureKeyIndex = 1
    end
    local textureKey = textureKeyGroup._textureGroupKey[textureKeyIndex]
    if nil ~= textureKey then
      local bookTextureInfo = self._bookTextureGroup[textureKey]
      if nil == bookTextureInfo then
        bookTextureInfo = self._bookTextureGroup[1]
      end
      local stc_BookImg = UI.createAndCopyBasePropertyControl(self._ui.stc_BookGroup, "Static_BookImage", journalContent.stc_BookGroup, "Static_BookImage_" .. ii)
      if nil ~= stc_BookImg then
        stc_BookImg:SetIgnore(true)
        stc_BookImg:SetSize(bookTextureInfo.sizeX, bookTextureInfo.sizeY)
        stc_BookImg:ComputePos()
        local x1, y1, x2, y2 = setTextureUV_Func(stc_BookImg, bookTextureInfo.x1, bookTextureInfo.y1, bookTextureInfo.x2, bookTextureInfo.y2)
        stc_BookImg:getBaseTexture():setUV(x1, y1, x2, y2)
        stc_BookImg:setRenderTexture(stc_BookImg:getBaseTexture())
        stc_BookImg:SetPosX(nextPosX)
        stc_BookImg:SetPosY(stc_BookImg:GetPosY() + 5)
        nextPosX = nextPosX + bookTextureInfo.sizeX + 1
        stc_BookImg:SetShow(false)
        self._journalControlList[journalKey].chapterList[#self._journalControlList[journalKey].chapterList + 1] = stc_BookImg
      end
    end
  end
end
function PaGlobal_Achievement_BookShelf_All:returnProcessingChapterCnt(journalKey)
  local processingChapterCnt = 0
  if nil == Panel_Window_Achievement_BookShelf_All or false == _ContentsGroup_AchievementQuest then
    return nil
  end
  if nil == journalKey then
    return nil
  end
  local nowChapterCnt = ToClient_GetChapterCount(journalKey)
  if nil == nowChapterCnt or 0 == nowChapterCnt then
    return nil
  end
  for ii = 1, nowChapterCnt do
    local journalQuestCnt = ToClient_GetJournalQuestCount(journalKey, ii)
    local questNo = ToClient_GetJournalQuestNo(journalKey, ii, 0)
    if nil ~= questNo and (true == questList_isClearQuest(questNo._group, questNo._quest) or true == questList_hasProgressQuest(questNo._group, questNo._quest)) then
      processingChapterCnt = processingChapterCnt + 1
    end
  end
  return processingChapterCnt
end
function PaGlobal_Achievement_BookShelf_All:setBookShelf()
  if nil == Panel_Window_Achievement_BookShelf_All or false == _ContentsGroup_AchievementQuest then
    return
  end
  self._journalGroupCnt = 0
  local nowjournalGroupCnt = ToClient_GetJournalGroupCount()
  if nil == nowjournalGroupCnt or nowjournalGroupCnt < 1 then
    return
  end
  if nil ~= nowjournalGroupCnt and 0 < nowjournalGroupCnt then
    self._journalGroupCnt = nowjournalGroupCnt
  end
  local nowJournalMaxKey = math.ceil(self._journalGroupCnt / self._BOOK_AREA_CNT)
  local bookShelfTextureInfo = self._bookShelfTextureGroup[nowJournalMaxKey]
  if nil == bookShelfTextureInfo then
    bookShelfTextureInfo = self._bookShelfTextureGroup[#self._bookShelfTextureGroup]
  end
  if nil == bookShelfTextureInfo then
    return
  end
  Panel_Window_Achievement_BookShelf_All:SetSize(bookShelfTextureInfo.panelSize, Panel_Window_Achievement_BookShelf_All:GetSizeY())
  self._ui.stc_TopArea:SetSize(bookShelfTextureInfo.panelSize, self._ui.stc_TopArea:GetSizeY())
  self._ui.stc_CenterArea:SetSize(bookShelfTextureInfo.panelSize - 10, self._ui.stc_RightArea:GetSizeY())
  self._ui.stc_RightArea:SetSize(bookShelfTextureInfo.frameSize, self._ui.stc_RightArea:GetSizeY())
  self._ui.frame_BookShelf:SetSize(bookShelfTextureInfo.frameSize, self._ui.frame_BookShelf:GetSizeY())
  self._ui.frame_BookShelfContent:SetSize(bookShelfTextureInfo.frameSize, self._ui.frame_BookShelfContent:GetSizeY())
  self._ui.stc_KeyGuide:SetSize(bookShelfTextureInfo.panelSize, self._ui.stc_KeyGuide:GetSizeY())
  Panel_Window_Achievement_BookShelf_All:ComputePos()
  self._ui.stc_BtnClose:ComputePos()
  self._ui.stc_CenterArea:ComputePos()
  self._ui.stc_RightArea:ComputePos()
  self._ui.frame_BookShelf:ComputePos()
  self._ui.frame_BookShelfContent:ComputePos()
  local stc_BackImage = UI.getChildControl(self._ui.stc_TopArea, "Static_BackImage")
  stc_BackImage:ComputePos()
  self._ui.stc_KeyGuide:ComputePos()
  self._ui.frame_BookShelf:ChangeTextureInfoName(bookShelfTextureInfo.texture)
  local x1, y1, x2, y2 = setTextureUV_Func(self._ui.frame_BookShelf, bookShelfTextureInfo.x1, bookShelfTextureInfo.y1, bookShelfTextureInfo.x2, bookShelfTextureInfo.y2)
  self._ui.frame_BookShelf:getBaseTexture():setUV(x1, y1, x2, y2)
  self._ui.frame_BookShelf:setRenderTexture(self._ui.frame_BookShelf:getBaseTexture())
  self:setKeyGuide()
  local lastCalledIndex = 0
  local calledCnt = 0
  self._journalControlList = {}
  for index = 1, nowJournalMaxKey * self._BOOK_AREA_CNT do
    local stc_BookArea = UI.createAndCopyBasePropertyControl(self._ui.frame_BookShelfContent, "RadioButton_BookArea", self._ui.frame_BookShelfContent, "RadioButton_BookArea_" .. index)
    local txt_BookTitle = UI.createAndCopyBasePropertyControl(self._ui.btn_BookArea, "StaticText_BookTitle", stc_BookArea, "StaticText_BookTitle")
    local stc_BookGroup = UI.createAndCopyBasePropertyControl(self._ui.btn_BookArea, "Static_BookGroup", stc_BookArea, "Static_BookGroup")
    local txt_BookCondition = UI.createAndCopyBasePropertyControl(self._ui.btn_BookArea, "StaticText_BookCondition", stc_BookArea, "StaticText_BookCondition")
    local stc_EmptyControl_1 = UI.createAndCopyBasePropertyControl(self._ui.btn_BookArea, "Static_EmptyGroup_1", stc_BookArea, "Static_EmptyGroup_1")
    local stc_EmptyControl_1_object = UI.createAndCopyBasePropertyControl(self._ui.stc_EmptyGroup_1, "Static_Watch", stc_EmptyControl_1, "Static_Watch")
    local stc_EmptyControl_2 = UI.createAndCopyBasePropertyControl(self._ui.btn_BookArea, "Static_EmptyGroup_2", stc_BookArea, "Static_EmptyGroup_2")
    local stc_EmptyControl_2_object = UI.createAndCopyBasePropertyControl(self._ui.stc_EmptyGroup_2, "Static_Vase", stc_EmptyControl_2, "Static_Vase")
    local stc_EmptyControl_3 = UI.createAndCopyBasePropertyControl(self._ui.btn_BookArea, "Static_EmptyGroup_3", stc_BookArea, "Static_EmptyGroup_3")
    local stc_EmptyControl_3_object_1 = UI.createAndCopyBasePropertyControl(self._ui.stc_EmptyGroup_3, "Static_CandleStick_1", stc_EmptyControl_3, "Static_CandleStick_1")
    local stc_EmptyControl_3_object_2 = UI.createAndCopyBasePropertyControl(self._ui.stc_EmptyGroup_3, "Static_CandleStick_2", stc_EmptyControl_3, "Static_CandleStick_2")
    local stc_EmptyControl_4 = UI.createAndCopyBasePropertyControl(self._ui.btn_BookArea, "Static_EmptyGroup_4", stc_BookArea, "Static_EmptyGroup_4")
    local stc_EmptyControl_4_object_1 = UI.createAndCopyBasePropertyControl(self._ui.stc_EmptyGroup_4, "Static_Teapot", stc_EmptyControl_4, "Static_Teapot")
    local stc_EmptyControl_4_object_2 = UI.createAndCopyBasePropertyControl(self._ui.stc_EmptyGroup_4, "Static_Cup", stc_EmptyControl_4, "Static_Cup")
    local callIndex = lastCalledIndex + 1
    if index <= self._journalGroupCnt then
      while true do
        if nil ~= ToClient_GetJournalName(callIndex) or callIndex > self._MAX_CALLING_COUNT then
          break
        end
        callIndex = callIndex + 1
      end
    end
    local journalCondition = ToClient_GetJournalConditionDesc(callIndex)
    txt_BookCondition:SetTextMode(__eTextMode_AutoWrap)
    if nil == journalCondition then
      journalCondition = ""
    end
    txt_BookCondition:SetText(journalCondition)
    txt_BookTitle:SetShow(false)
    txt_BookTitle:SetIgnore(true)
    txt_BookCondition:SetShow(false)
    txt_BookCondition:SetIgnore(true)
    stc_BookGroup:SetShow(false)
    stc_BookGroup:SetIgnore(true)
    stc_EmptyControl_1:SetShow(false)
    stc_EmptyControl_2:SetShow(false)
    stc_EmptyControl_3:SetShow(false)
    stc_EmptyControl_4:SetShow(false)
    local tempPosX = 29 + self._BOOK_POS_X * math.floor((index - 1) / self._BOOK_AREA_CNT)
    local bookAreaPosX = tempPosX + stc_BookArea:GetSizeX() * math.floor((index - 1) / self._BOOK_AREA_CNT)
    local bookAreaPosY = self._BOOK_POS_Y[(index - 1) % self._BOOK_AREA_CNT] - 10
    if nil == bookAreaPosY then
      bookAreaPosY = 0
    end
    local journalContent = {}
    journalContent.stc_BookArea = stc_BookArea
    journalContent.txt_bookArea_title = txt_BookTitle
    journalContent.stc_BookGroup = stc_BookGroup
    journalContent.txt_BookCondition = txt_BookCondition
    self._journalControlList[index] = {}
    self._journalControlList[index] = journalContent
    stc_BookArea:SetPosX(bookAreaPosX)
    stc_BookArea:SetPosY(bookAreaPosY)
    if index <= self._journalGroupCnt then
      local titleText = ToClient_GetJournalName(callIndex)
      self._journalGroupIndexList[index] = callIndex
      lastCalledIndex = callIndex
      if nil ~= titleText then
        txt_BookTitle:SetShow(true)
        stc_BookGroup:SetShow(true)
        txt_BookTitle:SetText(titleText)
        local chapterCnt = ToClient_GetChapterCount(callIndex)
        self:setBookShelfTexture(index, chapterCnt)
      end
      stc_BookArea:SetIgnore(false)
      stc_BookArea:addInputEvent("Mouse_LUp", "HandleEventLUp_Achievement_BookShelf_All_SelectJournal(" .. callIndex .. ")")
    else
      stc_BookArea:SetIgnore(true)
      stc_BookArea:addInputEvent("Mouse_LUp", "")
      local emptyIndex = index % self._BOOK_AREA_CNT
      local emptyControl
      if 1 == emptyIndex then
        emptyControl = stc_EmptyControl_1
      elseif 2 == emptyIndex then
        emptyControl = stc_EmptyControl_2
      elseif 3 == emptyIndex then
        emptyControl = stc_EmptyControl_3
      elseif 0 == emptyIndex then
        emptyControl = stc_EmptyControl_1
      else
        emptyControl = stc_EmptyControl_4
      end
      if nil ~= emptyControl then
        emptyControl:SetShow(true)
      end
    end
  end
  self._chapterControlList = {}
  for index = 1, self._MAX_CALLING_COUNT do
    local stc_ChapterSlot = UI.createAndCopyBasePropertyControl(self._ui.stc_Chapter, "Static_Chapter_Template", self._ui.stc_Chapter, "Static_Chapter_Template" .. index)
    local stc_ChapterTitle = UI.createAndCopyBasePropertyControl(self._ui.stc_ChapterSlot, "StaticText_ChapterTitle", stc_ChapterSlot, "StaticText_ChapterTitle")
    stc_ChapterSlot:SetSize(self._ui.stc_ChapterSlot:GetSizeX(), self._ui.stc_ChapterSlot:GetSizeY())
    local chapterSizeX = stc_ChapterSlot:GetSizeX()
    local chapterSizeY = stc_ChapterSlot:GetSizeY()
    local chapterListCnt = math.ceil(index / self._CHAPTER_ICON_CNT) - 1
    stc_ChapterSlot:SetPosX(stc_ChapterSlot:GetPosX() + chapterSizeX * ((index - 1) % self._CHAPTER_ICON_CNT))
    stc_ChapterSlot:SetPosY(stc_ChapterSlot:GetPosY() + chapterSizeY * chapterListCnt + 15 + chapterListCnt)
    stc_ChapterSlot:ComputePos()
    stc_ChapterSlot:SetEnableArea(0, 0, 65, 101)
    self._chapterControlList[index] = {}
    self._chapterControlList[index].slot = stc_ChapterSlot
    self._chapterControlList[index].title = stc_ChapterTitle
    self._chapterControlList[index].slot:SetShow(false)
  end
end
function PaGlobal_Achievement_BookShelf_All:setChapterSlot()
  if nil == Panel_Window_Achievement_BookShelf_All or false == _ContentsGroup_AchievementQuest then
    return
  end
  for index = 1, self._journalChapterCnt do
    local chapterSlot = self._chapterControlList[index].slot
    local chapterTitle = self._chapterControlList[index].title
    chapterSlot:removeInputEvent("Mouse_On")
    chapterSlot:removeInputEvent("Mouse_Out")
    if self._journalChapterCnt > 0 then
      local journalQuestCnt = ToClient_GetJournalQuestCount(self._selectedJournalGroup, index)
      if nil == journalQuestCnt then
        return
      end
      local showFlag = false
      for ii = 1, journalQuestCnt do
        local questNo = ToClient_GetJournalQuestNo(self._selectedJournalGroup, index, ii - 1)
        if nil ~= questNo and (true == questList_isClearQuest(questNo._group, questNo._quest) or true == questList_hasProgressQuest(questNo._group, questNo._quest)) then
          showFlag = true
        end
      end
      PaGlobal_Achievement_BookShelf_All:SetBookTexture(self._selectedJournalGroup, chapterSlot, index)
      local titleText = index
      if false == showFlag then
        titleText = "?"
        chapterSlot:addInputEvent("Mouse_LUp", "")
        chapterSlot:SetMonoTone(true)
        chapterSlot:SetIgnore(true)
      else
        chapterSlot:SetMonoTone(false)
        chapterSlot:SetIgnore(false)
        chapterSlot:addInputEvent("Mouse_LUp", "HandleEventLUp_Achievement_BookShelf_All_SelectChapter(" .. index .. ")")
      end
      if 9 == self._selectedJournalGroup or 12 == self._selectedJournalGroup then
        titleText = ""
      end
      if 9 == self._selectedJournalGroup then
        chapterSlot:addInputEvent("Mouse_On", "HandleEventOnOut_Achievement_BookShelf_All_Show_EventJournal_Title(" .. index .. ")")
        chapterSlot:addInputEvent("Mouse_Out", "HandleEventOnOut_Achievement_BookShelf_All_Show_EventJournal_Title()")
      end
      chapterTitle:SetText(titleText)
      chapterSlot:SetShow(true)
    else
      chapterSlot:SetShow(false)
      chapterSlot:addInputEvent("Mouse_LUp", "")
    end
  end
end
function PaGlobal_Achievement_BookShelf_All:SetBookTexture(journalType, control, index)
  if nil == self._journalChapterCnt or nil == index then
    return
  end
  local baseX1, baseY1, baseX2, baseY2 = 0, 0, 0, 0
  local onX1, onY1, onX2, onY2 = 0, 0, 0, 0
  local clickX1, clickY1, clickX2, clickY2 = 0, 0, 0, 0
  control:ChangeTextureInfoName("Combine/Etc/Combine_Etc_Adventure_01.dds")
  control:ChangeOnTextureInfoName("Combine/Etc/Combine_Etc_Adventure_01.dds")
  control:ChangeClickTextureInfoName("Combine/Etc/Combine_Etc_Adventure_01.dds")
  if 1 == journalType then
    if nil ~= self._journalChapterCnt and index == self._journalChapterCnt then
      baseX1, baseY1, baseX2, baseY2 = setTextureUV_Func(control, 188, 241, 269, 342)
      onX1, onY1, onX2, onY2 = setTextureUV_Func(control, 106, 241, 187, 342)
      clickX1, clickY1, clickX2, clickY2 = setTextureUV_Func(control, 270, 241, 352, 342)
    else
      baseX1, baseY1, baseX2, baseY2 = setTextureUV_Func(control, 83, 1, 164, 102)
      onX1, onY1, onX2, onY2 = setTextureUV_Func(control, 1, 1, 82, 102)
      clickX1, clickY1, clickX2, clickY2 = setTextureUV_Func(control, 83, 103, 164, 204)
    end
  elseif 9 == journalType then
    if 1 == index then
      baseX1, baseY1, baseX2, baseY2 = setTextureUV_Func(control, 165, 1, 246, 102)
      onX1, onY1, onX2, onY2 = setTextureUV_Func(control, 247, 103, 328, 204)
      clickX1, clickY1, clickX2, clickY2 = setTextureUV_Func(control, 247, 1, 328, 102)
    elseif 2 == index then
      baseX1, baseY1, baseX2, baseY2 = setTextureUV_Func(control, 411, 103, 492, 204)
      onX1, onY1, onX2, onY2 = setTextureUV_Func(control, 411, 1, 492, 102)
      clickX1, clickY1, clickX2, clickY2 = setTextureUV_Func(control, 329, 1, 410, 102)
    end
  elseif 12 == journalType then
    control:ChangeTextureInfoName("Combine/Etc/Combine_Etc_Adventure_03.dds")
    control:ChangeOnTextureInfoName("Combine/Etc/Combine_Etc_Adventure_03.dds")
    control:ChangeClickTextureInfoName("Combine/Etc/Combine_Etc_Adventure_03.dds")
    baseX1, baseY1, baseX2, baseY2 = setTextureUV_Func(control, 844, 205, 925, 306)
    onX1, onY1, onX2, onY2 = setTextureUV_Func(control, 762, 205, 843, 306)
    clickX1, clickY1, clickX2, clickY2 = setTextureUV_Func(control, 844, 307, 925, 408)
  else
    baseX1, baseY1, baseX2, baseY2 = setTextureUV_Func(control, 83, 1, 164, 102)
    onX1, onY1, onX2, onY2 = setTextureUV_Func(control, 1, 1, 82, 102)
    clickX1, clickY1, clickX2, clickY2 = setTextureUV_Func(control, 83, 103, 164, 204)
  end
  control:getBaseTexture():setUV(baseX1, baseY1, baseX2, baseY2)
  control:getOnTexture():setUV(onX1, onY1, onX2, onY2)
  control:getClickTexture():setUV(clickX1, clickY1, clickX2, clickY2)
  control:setRenderTexture(control:getBaseTexture())
end
function PaGlobal_Achievement_BookShelf_All:updateJournalList()
  for index = 1, #self._journalControlList do
    local journalKey = self._journalGroupIndexList[index]
    if nil ~= journalKey then
      local processingChapterCnt = self:returnProcessingChapterCnt(journalKey)
      if nil ~= processingChapterCnt then
        if 0 == processingChapterCnt then
          self._journalControlList[index].txt_BookCondition:SetShow(true)
        else
          self._journalControlList[index].txt_BookCondition:SetShow(false)
        end
        local chapterList = self._journalControlList[index].chapterList
        if nil ~= chapterList then
          for ii = 1, #chapterList do
            if nil ~= chapterList[ii] then
              if ii <= processingChapterCnt then
                chapterList[ii]:SetShow(true)
              else
                chapterList[ii]:SetShow(false)
              end
            end
          end
        end
      end
    end
  end
end
function PaGlobal_Achievement_BookShelf_All:updateChapterList(index)
  if nil == index then
    index = self._selectedJournalGroup
  end
  if nil == self._selectedJournalGroup or self._selectedJournalGroup < 1 then
    return
  end
  local nowChapterCnt = ToClient_GetChapterCount(self._selectedJournalGroup)
  if nil ~= nowChapterCnt and 0 < nowChapterCnt then
    self._journalChapterCnt = nowChapterCnt
  end
  local leftTitle = ToClient_GetJournalName(self._selectedJournalGroup)
  local leftDesc = ToClient_GetJournalDesc(self._selectedJournalGroup)
  if nil == leftTitle or nil == leftDesc then
    return
  end
  local processingChapterCnt = self:returnProcessingChapterCnt(self._selectedJournalGroup)
  if nil == processingChapterCnt then
    processingChapterCnt = 0
  end
  self._ui.txt_LeftTitle:SetShow(true)
  leftTitle = PAGetStringParam3(Defines.StringSheet_GAME, "LUA_ACHIEVEMENT_BOOKSHELF_SUBTITLE", "title", leftTitle, "count1", processingChapterCnt, "countAll", self._journalChapterCnt)
  self._ui.txt_LeftTitle:SetText(leftTitle)
  self._ui.txt_BookShelfDesc:SetText(leftDesc)
  for index = 1, self._MAX_CALLING_COUNT do
    self._chapterControlList[index].slot:SetShow(false)
  end
  self:setChapterSlot()
end
function PaGlobal_Achievement_BookShelf_All:selectJournal(index)
  if nil ~= index then
    self._selectedJournalGroup = index
  else
    self._selectedJournalGroup = 1
  end
  PaGlobal_Achievement_BookShelf_All._ui.txt_SelectedBookName:SetText("")
  self:updateChapterList(index)
end
function PaGlobal_Achievement_BookShelf_All:selectChapter(index)
  if nil == index then
    return
  end
  local journalQuestCnt = ToClient_GetJournalQuestCount(self._selectedJournalGroup, index)
  if nil == journalQuestCnt or journalQuestCnt < 1 then
    return
  end
  local questNo = ToClient_GetJournalQuestNo(self._selectedJournalGroup, index, 0)
  if nil == questNo then
    return
  end
  if nil ~= PaGlobalFunc_Achievement_Open_From_BookShelf then
    self._selectedJournalChapter = index
    PaGlobalFunc_Achievement_Open_From_BookShelf(questNo._group)
  end
end
function PaGlobal_Achievement_BookShelf_All:setFamilyWidget()
  local specialInfo = ToClient_GetFamilySpecialInfo()
  if nil == specialInfo then
    return
  end
  local txt_FamilyName = UI.getChildControl(self._ui.stc_FamilyWidget, "StaticText_FamilyName")
  txt_FamilyName:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_ACHIEVEMENT_BOOKSHELF_FAMILYNAME", "familyname", getFamilyName()))
  local offence = specialInfo:getFamilySpecialOffence()
  local defence = specialInfo:getFamilySpecialDefence()
  local maxhp = specialInfo:getFamilySpecialMaxHp()
  local maxsp = specialInfo:getFamilySpecialMaxSp()
  local weight = specialInfo:getFamilySpecialWeight()
  if nil ~= weight then
    weight = weight / 10000
  end
  local inven = specialInfo:getFamilySpecialInven()
  local hit = specialInfo:getFamilySpecialHit()
  local dv = specialInfo:getFamilySpecialDv()
  local specialStack = specialInfo:getFamilySpecialStack()
  local valksLimitExceed = specialInfo:getFamilySpecialValksLimitExceed()
  local txt_offence = UI.getChildControl(self._ui.stc_FamilyWidget, "StaticText_Offence_Value")
  local txt_defence = UI.getChildControl(self._ui.stc_FamilyWidget, "StaticText_Defence_Value")
  local txt_maxHp = UI.getChildControl(self._ui.stc_FamilyWidget, "StaticText_MaxHP_Value")
  local txt_maxSp = UI.getChildControl(self._ui.stc_FamilyWidget, "StaticText_MaxSP_Value")
  local txt_weight = UI.getChildControl(self._ui.stc_FamilyWidget, "StaticText_Weight_Value")
  local txt_inven = UI.getChildControl(self._ui.stc_FamilyWidget, "StaticText_Inven_Value")
  local txt_hit = UI.getChildControl(self._ui.stc_FamilyWidget, "StaticText_Hit_Value")
  local txt_dv = UI.getChildControl(self._ui.stc_FamilyWidget, "StaticText_DV_Value")
  local txt_specialStack = UI.getChildControl(self._ui.stc_FamilyWidget, "StaticText_Special_Stack_Value")
  local txt_valksLimitExcced = UI.getChildControl(self._ui.stc_FamilyWidget, "StaticText_ValksLimitExceed_Value")
  if nil ~= offence then
    txt_offence:SetText(offence)
  end
  if nil ~= defence then
    txt_defence:SetText(defence)
  end
  if nil ~= maxhp then
    txt_maxHp:SetText(maxhp)
  end
  if nil ~= maxsp then
    txt_maxSp:SetText(maxsp)
  end
  if nil ~= weight then
    txt_weight:SetText(weight)
  end
  if nil ~= inven then
    txt_inven:SetText(inven)
  end
  if nil ~= hit then
    txt_hit:SetText(hit)
  end
  if nil ~= dv then
    txt_dv:SetText(dv)
  end
  if nil ~= specialStack then
    txt_specialStack:SetText(specialStack)
  end
  if nil ~= valksLimitExceed then
    txt_valksLimitExcced:SetText(valksLimitExceed)
  end
  if false == _ContentsGroup_RubinSpecial then
    local txt_valksLimitExceedTitle = UI.getChildControl(self._ui.stc_FamilyWidget, "StaticText_ValksLimitExceed")
    txt_valksLimitExceedTitle:SetShow(false)
    txt_valksLimitExcced:SetShow(false)
    self._ui.stc_FamilyWidget:SetSize(self._ui.stc_FamilyWidget:GetSizeX(), self._defaultFamilyWidgetSizeY - 30)
    self._ui.stc_familyWidget_SubBG:SetSize(self._ui.stc_familyWidget_SubBG:GetSizeX(), self._ui.stc_FamilyWidget:GetSizeY() - 50)
  end
end
function PaGlobal_Achievement_BookShelf_All:showToggleFamilyWidget()
  if nil == self._ui.stc_FamilyWidget then
    return
  end
  local isShow = not self._ui.stc_FamilyWidget:GetShow()
  self._ui.stc_FamilyWidget:SetShow(isShow)
  if true == isShow then
    self:setFamilyWidget()
  end
end
function PaGlobal_Achievement_BookShelf_All:validate()
  if nil == Panel_Window_Achievement_BookShelf_All then
    return
  end
  self._ui.stc_TopArea:isValidate()
  self._ui.stc_CenterArea:isValidate()
  self._ui.stc_FamilyWidget:isValidate()
  self._ui.stc_LeftArea:isValidate()
  self._ui.stc_RightArea:isValidate()
  self._ui.stc_BtnClose:isValidate()
  self._ui.stc_Chapter:isValidate()
  self._ui.stc_ChapterSlot:isValidate()
  self._ui.stc_ChapterTitle:isValidate()
  self._ui.txt_FamilyStatIcon:isValidate()
  self._ui.txt_LeftTitle:isValidate()
  self._ui.txt_BookShelfDesc:isValidate()
  self._ui.frame_BookShelf:isValidate()
  self._ui.frame_BookShelfContent:isValidate()
  self._ui.btn_BookArea:isValidate()
  self._ui.txt_BookTitle:isValidate()
  self._ui.stc_BookGroup:isValidate()
  self._ui.stc_EmptyGroup_1:isValidate()
  self._ui.stc_EmptyGroup_1_object:isValidate()
  self._ui.stc_EmptyGroup_2:isValidate()
  self._ui.stc_EmptyGroup_2_object:isValidate()
  self._ui.stc_EmptyGroup_3:isValidate()
  self._ui.stc_EmptyGroup_3_object_1:isValidate()
  self._ui.stc_EmptyGroup_3_object_2:isValidate()
  self._ui.stc_EmptyGroup_4:isValidate()
  self._ui.stc_EmptyGroup_4_object_1:isValidate()
  self._ui.stc_EmptyGroup_4_object_2:isValidate()
  self._ui.stc_BookImage:isValidate()
  self._ui.txt_SelectedBookName:isValidate()
end
function PaGlobal_Achievement_BookShelf_All:updateSetDirectJournalChapter(questGroup, questNo)
  for index = 1, #self._journalControlList do
    local journalKey = self._journalGroupIndexList[index]
    if nil ~= journalKey then
      local nowChapterCnt = ToClient_GetChapterCount(journalKey)
      if nil ~= nowChapterCnt and 0 ~= nowChapterCnt then
        for ii = 1, nowChapterCnt do
          local questNoData = ToClient_GetJournalQuestNo(journalKey, ii, 0)
          if nil ~= questNoData and questGroup == questNoData._group and questNo == questNoData._quest then
            self._selectedJournalGroup = journalKey
            self._selectedJournalChapter = ii
            break
          end
        end
      end
    end
  end
end
