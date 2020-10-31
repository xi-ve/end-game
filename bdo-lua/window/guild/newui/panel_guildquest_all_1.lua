function PaGlobal_GuildQuest_All:initialize()
  if true == PaGlobal_GuildQuest_All._initialize then
    return
  end
  self._isConsole = _ContentsGroup_UsePadSnapping
  self._ui.stc_TopBG = UI.getChildControl(Panel_GuildQuest_All, "Static_TopArea")
  self._ui.txt_ProgressQuestTime = UI.getChildControl(self._ui.stc_TopBG, "StaticText_QuestTime")
  self._ui.txt_ProgressQuestName = UI.getChildControl(self._ui.stc_TopBG, "StaticText_QusetName")
  self._ui.txt_ProgressQuestCondition = UI.getChildControl(self._ui.stc_TopBG, "StaticText_QuestCondition")
  for i = 0, self._progressQuestConditionMaxCount - 1 do
    self._progressQuestCondition[i] = UI.createAndCopyBasePropertyControl(self._ui.stc_TopBG, "StaticText_QuestCondition", self._ui.stc_TopBG, "StaticText_QuestCondition_" .. i)
    self._progressQuestCondition[i]:SetPosY(self._progressQuestCondition[i]:GetPosY() + (self._progressQuestCondition[i]:GetSizeY() + 5) * i)
  end
  self._ui.btn_GiveUp = UI.getChildControl(self._ui.stc_TopBG, "Button_Giveup")
  self._ui.btn_Complete = UI.getChildControl(self._ui.stc_TopBG, "Button_Complete")
  self._ui.btn_ProgressingQuestInfo = UI.getChildControl(self._ui.stc_TopBG, "Button_QuestInfo")
  self._ui.stc_TitleTabBG = UI.getChildControl(Panel_GuildQuest_All, "Static_SubTab")
  self._ui.stc_SelectLine = UI.getChildControl(self._ui.stc_TitleTabBG, "Static_SelctLine")
  for i = 0, self._TabCount - 1 do
    self._rdo_Tab[i] = UI.getChildControl(self._ui.stc_TitleTabBG, "RadioButton_Tab" .. tostring(i))
  end
  UI.getChildControl(self._ui.stc_TitleTabBG, "Static_SelectLT_C"):SetShow(self._isConsole)
  UI.getChildControl(self._ui.stc_TitleTabBG, "Static_SelectRT_C"):SetShow(self._isConsole)
  self._ui.stc_MainArea = UI.getChildControl(Panel_GuildQuest_All, "Static_MainArea")
  self._ui.btn_LeftArrow = UI.getChildControl(self._ui.stc_MainArea, "Button_LeftArrow")
  self._ui.btn_RightArrow = UI.getChildControl(self._ui.stc_MainArea, "Button_RightArrow")
  self._ui.txt_PageCount = UI.getChildControl(self._ui.stc_MainArea, "StaticText_PageCount")
  self._ui.stc_QuestList_Templete = UI.getChildControl(self._ui.stc_MainArea, "Static_QuestList_Temp")
  self._ui.stc_MainArea:SetIgnore(false)
  self._ui.btn_Left_Templete = UI.getChildControl(self._ui.stc_QuestList_Templete, "Static_Main")
  self._ui.txt_QuestTitle_Templete = UI.getChildControl(self._ui.btn_Left_Templete, "StaticText_QuestTitle")
  self._ui.txt_QuestDesc_Templete = UI.getChildControl(self._ui.btn_Left_Templete, "StaticText_QuestDesc")
  self._ui.txt_QuestCondition_Templete = UI.getChildControl(self._ui.btn_Left_Templete, "StaticText_QuestCondition")
  self._ui.txt_QuestLimitTime_Templete = UI.getChildControl(self._ui.btn_Left_Templete, "StaticText_QuestLimitTime")
  self._ui.stc_QuestIcon_Templete = UI.getChildControl(self._ui.btn_Left_Templete, "Static_QuestIcon")
  self._ui.btn_Right_Templete = UI.getChildControl(self._ui.stc_QuestList_Templete, "Button_Sub")
  self._ui.txt_QuestAccept_Templete = UI.getChildControl(self._ui.btn_Right_Templete, "StaticText_QuestAccept")
  self._ui.txt_QuestFunds_Templete = UI.getChildControl(self._ui.btn_Right_Templete, "StaticText_QuestGuildFunds")
  self._ui.txt_GuildFunds = UI.getChildControl(Panel_GuildQuest_All, "StaticText_GuildFunds")
  self._ui.btn_GetGuildMoney = UI.getChildControl(Panel_GuildQuest_All, "Button_GetGuildMoney")
  for i = 0, self._qeustListMaxShowCount - 1 do
    local listBG = UI.createAndCopyBasePropertyControl(self._ui.stc_MainArea, "Static_QuestList_Temp", self._ui.stc_MainArea, "Static_QuestList_" .. i)
    local leftBtn = UI.createAndCopyBasePropertyControl(self._ui.stc_QuestList_Templete, "Static_Main", listBG, "Static_Main_" .. i)
    local title = UI.createAndCopyBasePropertyControl(self._ui.btn_Left_Templete, "StaticText_QuestTitle", leftBtn, "StaticText_QuestTitle_" .. i)
    local desc = UI.createAndCopyBasePropertyControl(self._ui.btn_Left_Templete, "StaticText_QuestDesc", leftBtn, "StaticText_QuestDesc_" .. i)
    local condition = UI.createAndCopyBasePropertyControl(self._ui.btn_Left_Templete, "StaticText_QuestCondition", leftBtn, "StaticText_QuestCondition_" .. i)
    local limitTime = UI.createAndCopyBasePropertyControl(self._ui.btn_Left_Templete, "StaticText_QuestLimitTime", leftBtn, "StaticText_QuestLimitTime_" .. i)
    local icon = UI.createAndCopyBasePropertyControl(self._ui.btn_Left_Templete, "Static_QuestIcon", leftBtn, "Static_QuestIcon_" .. i)
    local rightBtn = UI.createAndCopyBasePropertyControl(self._ui.stc_QuestList_Templete, "Button_Sub", listBG, "Button_Sub_" .. i)
    local accept = UI.createAndCopyBasePropertyControl(self._ui.btn_Right_Templete, "StaticText_QuestAccept", rightBtn, "StaticText_QuestAccept_" .. i)
    local funds = UI.createAndCopyBasePropertyControl(self._ui.btn_Right_Templete, "StaticText_QuestGuildFunds", rightBtn, "StaticText_QuestGuildFunds_" .. i)
    listBG:SetPosY(self._ui.stc_QuestList_Templete:GetPosY() + (self._ui.stc_QuestList_Templete:GetSizeY() + 5) * i)
    desc:SetSize(desc:GetSizeX(), desc:GetSizeY() * 2)
    desc:SetTextMode(__eTextMode_Limit_AutoWrap)
    desc:setLineCountByLimitAutoWrap(2)
    condition:SetShow(false)
    if self._isConsole then
      leftBtn:registerPadEvent(__eConsoleUIPadEvent_DpadLeft, "HandleEventLUp_GuildQuest_PageMove(true)")
      rightBtn:registerPadEvent(__eConsoleUIPadEvent_DpadRight, "HandleEventLUp_GuildQuest_PageMove(false)")
    else
      listBG:addInputEvent("Mouse_UpScroll", "HandleEventLUp_GuildQuest_PageMove(true)")
      listBG:addInputEvent("Mouse_DownScroll", "HandleEventLUp_GuildQuest_PageMove(false)")
      leftBtn:addInputEvent("Mouse_UpScroll", "HandleEventLUp_GuildQuest_PageMove(true)")
      leftBtn:addInputEvent("Mouse_DownScroll", "HandleEventLUp_GuildQuest_PageMove(false)")
      rightBtn:addInputEvent("Mouse_UpScroll", "HandleEventLUp_GuildQuest_PageMove(true)")
      rightBtn:addInputEvent("Mouse_DownScroll", "HandleEventLUp_GuildQuest_PageMove(false)")
    end
    self._questList[i] = {}
    self._questList[i].listBG = listBG
    self._questList[i].leftBtn = leftBtn
    self._questList[i].title = title
    self._questList[i].desc = desc
    self._questList[i].condition = condition
    self._questList[i].limitTime = limitTime
    self._questList[i].icon = icon
    self._questList[i].rightBtn = rightBtn
    self._questList[i].accept = accept
    self._questList[i].funds = funds
  end
  self._ui.stc_QuestList_Templete:SetShow(false)
  self._parentBG = PaGlobal_GuildMain_All._ui.stc_Quest_Bg
  PaGlobal_GuildQuest_All:validate()
  PaGlobal_GuildQuest_All:resizeButtons()
  PaGlobal_GuildQuest_All:registEventHandler(self._isConsole)
  PaGlobal_GuildQuest_All:swichPlatform(self._isConsole)
  PaGlobal_GuildQuest_All._initialize = true
end
function PaGlobal_GuildQuest_All:resizeButtons()
  local buttonSizeX = 0
  local alignBtns = {
    self._ui.btn_GiveUp,
    self._ui.btn_Complete,
    self._ui.btn_ProgressingQuestInfo
  }
  for _, control in pairs(alignBtns) do
    local textSizeX = control:GetTextSizeX()
    local sizeX = control:GetSizeX()
    if textSizeX > sizeX then
      buttonSizeX = math.max(textSizeX, buttonSizeX)
    end
  end
  if 0 ~= buttonSizeX then
    for _, control in pairs(alignBtns) do
      control:SetSize(buttonSizeX, control:GetSizeY())
      control:ComputePos()
    end
  end
end
function PaGlobal_GuildQuest_All:registEventHandler(isConsole)
  registerEvent("ResponseGuildQuestList", "FromClient_GuildQuest_All_Update")
  registerEvent("ResponseUpdateGuildQuest", "FromClient_GuildQuest_All_Update")
  registerEvent("ResponseAcceptGuildQuest", "PaGlobalFunc_Guild_Quest_All_FirstUpdate")
  registerEvent("ResponseUpdateGiveupGuildQuest", "PaGlobalFunc_Guild_Quest_All_FirstUpdate")
  registerEvent("ResponseCompleteGuildQuest", "PaGlobalFunc_Guild_Quest_All_FirstUpdate")
  registerEvent("FromClient_NotifyCompleteGuildQuestToWorld", "FromClient_GuildQuest_NotifyComplete_All")
  registerEvent("FromClient_UpdateGuildMemberBonus", "FromClient_GuildQuest_UpdateGuildMemberBonus")
  for i = 0, self._qeustListMaxShowCount - 1 do
    self._questList[i].leftBtn:addInputEvent("Mouse_LUp", "HandleEventLUp_GuildQuest_Open_QuestInfo_All(" .. i .. ")")
    self._questList[i].rightBtn:addInputEvent("Mouse_LUp", "HandleEventLUp_GuildQuest_AcceptQuest_All(" .. i .. ")")
  end
  self._ui.btn_GiveUp:addInputEvent("Mouse_LUp", "HandleEventLUp_GuildQuest_Giveup()")
  self._ui.btn_Complete:addInputEvent("Mouse_LUp", "HandleEventLUp_GuildQuest_Clear()")
  self._ui.btn_ProgressingQuestInfo:addInputEvent("Mouse_LUp", "HandleCliekedGuildQuestReward()")
  if isConsole then
    self._parentBG:registerPadEvent(__eConsoleUIPadEvent_LT, "HandleEvent_GuildQuest_TabMove(true)")
    self._parentBG:registerPadEvent(__eConsoleUIPadEvent_RT, "HandleEvent_GuildQuest_TabMove(false)")
    self._parentBG:registerPadEvent(__eConsoleUIPadEvent_X, "HandleEventLUp_GuildQuest_ReqestMemberBonus_All()")
  else
    self._ui.stc_MainArea:addInputEvent("Mouse_UpScroll", "HandleEventLUp_GuildQuest_PageMove(true)")
    self._ui.stc_MainArea:addInputEvent("Mouse_DownScroll", "HandleEventLUp_GuildQuest_PageMove(false)")
    self._ui.btn_GetGuildMoney:addInputEvent("Mouse_LUp", "HandleEventLUp_GuildQuest_ReqestMemberBonus_All()")
    self._ui.btn_LeftArrow:addInputEvent("Mouse_LUp", "HandleEventLUp_GuildQuest_PageMove(true)")
    self._ui.btn_RightArrow:addInputEvent("Mouse_LUp", "HandleEventLUp_GuildQuest_PageMove(false)")
    for i = 0, self._TabCount - 1 do
      self._rdo_Tab[i]:addInputEvent("Mouse_LUp", "HandleEventLUp_GuildQuest_SelectType(" .. i .. ")")
    end
  end
end
function PaGlobal_GuildQuest_All:swichPlatform(isConsole)
  self._ui.btn_GetGuildMoney:SetShow(not isConsole)
end
function PaGlobal_GuildQuest_All:validate()
  self._ui.stc_TopBG:isValidate()
  self._ui.txt_ProgressQuestTime:isValidate()
  self._ui.txt_ProgressQuestName:isValidate()
  self._ui.txt_ProgressQuestCondition:isValidate()
  self._ui.stc_TitleTabBG:isValidate()
  self._ui.stc_SelectLine:isValidate()
  for i = 0, self._TabCount - 1 do
    self._rdo_Tab[i]:isValidate()
  end
  self._ui.stc_MainArea:isValidate()
  self._ui.btn_LeftArrow:isValidate()
  self._ui.btn_RightArrow:isValidate()
  self._ui.txt_PageCount:isValidate()
  self._ui.stc_QuestList_Templete:isValidate()
  self._ui.btn_Left_Templete:isValidate()
  self._ui.txt_QuestTitle_Templete:isValidate()
  self._ui.txt_QuestDesc_Templete:isValidate()
  self._ui.txt_QuestCondition_Templete:isValidate()
  self._ui.txt_QuestLimitTime_Templete:isValidate()
  self._ui.stc_QuestIcon_Templete:isValidate()
  self._ui.btn_Right_Templete:isValidate()
  self._ui.txt_QuestFunds_Templete:isValidate()
  self._ui.txt_GuildFunds:isValidate()
  self._ui.btn_GetGuildMoney:isValidate()
  for i = 0, self._qeustListMaxShowCount - 1 do
    self._questList[i].listBG:isValidate()
    self._questList[i].leftBtn:isValidate()
    self._questList[i].title:isValidate()
    self._questList[i].desc:isValidate()
    self._questList[i].condition:isValidate()
    self._questList[i].limitTime:isValidate()
    self._questList[i].rightBtn:isValidate()
    self._questList[i].accept:isValidate()
    self._questList[i].funds:isValidate()
  end
end
function PaGlobal_GuildQuest_All:updateAll()
  if false == self._parentBG:GetShow() then
    return
  end
  local myGuildInfo = ToClient_GetMyGuildInfoWrapper()
  if nil == myGuildInfo then
    return
  end
  local businessFunds_s64 = myGuildInfo:getGuildBusinessFunds_s64()
  self._ui.txt_GuildFunds:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GUILD_QUEST_GUILDMONEY", "getGuildMoney", makeDotMoney(businessFunds_s64)))
  ToClient_RequestWarehouseInfo()
  self:updateProgressQuest()
  self:updateCurrentPage()
end
function PaGlobal_GuildQuest_All:updateProgressQuest()
  if false == self._parentBG:GetShow() then
    return
  end
  local myGuildInfo = ToClient_GetMyGuildInfoWrapper()
  local enableQuestCount = myGuildInfo:getAvaiableGuildQuestCount()
  local enableQuestCountStr = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_GUILD_QUEST_ENABLEQUESTCOUNT_NEW", "enableQuestCount", enableQuestCount, "maxAvailableQuestCount", __eMaxAvaiableGuildQuestCount)
  local isProgressing = ToClient_isProgressingGuildQuest()
  for i = 0, self._progressQuestConditionMaxCount - 1 do
    self._progressQuestCondition[i]:SetShow(false)
    self._progressQuestCondition[i]:SetText("")
    self._progressQuestCondition[i]:SetLineRender(false)
    self._progressQuestCondition[i]:SetFontColor(Defines.Color.C_FFC4BEBE)
  end
  local remainTime = ToClient_getCurrentGuildQuestRemainedTime()
  if isProgressing then
    local currentGuildQuestName = ToClient_getCurrentGuildQuestName()
    local requireGuildRank = ToClient_getCurrentGuildQuestGrade()
    local requireGuildRankStr = ""
    if 1 == requireGuildRank then
      requireGuildRankStr = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_QUEST_SMALL")
    elseif 2 == requireGuildRank then
      requireGuildRankStr = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_QUEST_MIDDLE")
    elseif 3 == requireGuildRank then
      requireGuildRankStr = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_QUEST_BIG")
    elseif 4 == requireGuildRank then
      requireGuildRankStr = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_QUEST_BIGGEST")
    end
    self._ui.txt_ProgressQuestName:SetText(PAGetStringParam2(Defines.StringSheet_GAME, "LUA_GUILD_QUEST_LIMIT", "currentGuildQuestName", currentGuildQuestName, "requireGuildRankStr", requireGuildRankStr) .. " " .. enableQuestCountStr)
    local strMinute = math.floor(remainTime / 60)
    if remainTime <= 0 then
      self._ui.txt_ProgressQuestTime:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_TEXT_TIMEOUT"))
    else
      self._ui.txt_ProgressQuestTime:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GUILD_TEXT_REMAINTIME", "time_minute", strMinute))
    end
    self._ui.txt_ProgressQuestTime:SetShow(true)
    self._ui.txt_ProgressQuestTime:SetColor(Defines.Color.C_FFFF0000)
    self._ui.txt_ProgressQuestTime:SetFontColor(Defines.Color.C_FFFF0000)
    local questConditionCount = ToClient_getCurrentGuildQuestConditionCount()
    for index = 0, self._progressQuestConditionMaxCount - 1 do
      if index < questConditionCount then
        local currentGuildQuestInfo = ToClient_getCurrentGuildQuestConditionAt(index)
        if nil ~= currentGuildQuestInfo then
          self._progressQuestCondition[index]:SetShow(true)
          self._progressQuestCondition[index]:SetText(currentGuildQuestInfo._desc .. " ( " .. currentGuildQuestInfo._currentCount .. " / " .. currentGuildQuestInfo._destCount .. " ) ")
          if currentGuildQuestInfo._destCount <= currentGuildQuestInfo._currentCount then
            self._progressQuestCondition[index]:SetLineRender(true)
            self._progressQuestCondition[index]:SetFontColor(Defines.Color.C_FF626262)
          else
            self._progressQuestCondition[index]:SetLineRender(false)
            self._progressQuestCondition[index]:SetFontColor(Defines.Color.C_FFC4BEBE)
          end
        else
          self._progressQuestCondition[index]:SetShow(false)
        end
      end
    end
    if getSelfPlayer():get():isGuildMaster() or getSelfPlayer():get():isGuildSubMaster() then
      self._ui.btn_GiveUp:SetShow(false == self._isConsole)
      self._parentBG:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandleCliekedGuildQuestReward()")
      self._parentBG:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "HandleEventLUp_GuildQuest_Giveup()")
      PaGlobal_GuildMain_All:setKeyguideTextWithShow(true, __eConsoleUIPadEvent_Y, PAGetString(Defines.StringSheet_RESOURCE, "PANEL_GUILD_QUEST_GIVEUP_BTN"))
    else
      self._ui.btn_GiveUp:SetShow(false)
      self._parentBG:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "")
      self._parentBG:registerPadEvent(__eConsoleUIPadEvent_Up_X, "")
    end
    if 0 >= ToClient_getCurrentGuildQuestBaseRewardCount() and 0 >= ToClient_getCurrentGuildQuestSelectRewardCount() then
      self._ui.btn_ProgressingQuestInfo:SetShow(false)
    else
      self._ui.btn_ProgressingQuestInfo:SetShow(true)
    end
  else
    self._ui.btn_ProgressingQuestInfo:SetShow(false)
    self._ui.btn_GiveUp:SetShow(false)
    self._ui.txt_ProgressQuestTime:SetShow(false)
    self._parentBG:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "")
    self._parentBG:registerPadEvent(__eConsoleUIPadEvent_Up_X, "")
    local temporaryWrapper = getTemporaryInformationWrapper()
    local worldNo = temporaryWrapper:getSelectedWorldServerNo()
    local channelName = getChannelName(worldNo, ToClient_getCurrentGuildQuestServerNo())
    if ToClient_isGuildQuestOtherServer() then
      if nil == channelName then
        self._ui.txt_ProgressQuestName:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_TEXT_PROGRESSNOQUEST_ANOTHER"))
      else
        self._ui.txt_ProgressQuestName:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GUILD_TEXT_PROGRESSNOQUEST_ANOTHERCHANNEL", "channel", channelName))
      end
      if getSelfPlayer():get():isGuildMaster() or getSelfPlayer():get():isGuildSubMaster() then
        self._ui.btn_GiveUp:SetShow(false == self._isConsole)
        self._parentBG:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandleCliekedGuildQuestReward()")
        self._parentBG:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "HandleEventLUp_GuildQuest_Giveup()")
        PaGlobal_GuildMain_All:setKeyguideTextWithShow(true, __eConsoleUIPadEvent_X, PAGetString(Defines.StringSheet_RESOURCE, "PANEL_GENERIC_KEYGUIDE_XBOX_DETAIL"))
        PaGlobal_GuildMain_All:setKeyguideTextWithShow(true, __eConsoleUIPadEvent_Y, PAGetString(Defines.StringSheet_RESOURCE, "PANEL_GUILD_QUEST_GIVEUP_BTN"))
      else
        self._ui.btn_GiveUp:SetShow(false)
      end
    else
      self._ui.txt_ProgressQuestName:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_TEXT_NOCURRENT"))
      self._progressQuestCondition[0]:SetShow(true)
      self._progressQuestCondition[0]:SetText(enableQuestCountStr)
    end
  end
  if true == ToClient_isSatisfyCurrentGuildQuest() then
    if getSelfPlayer():get():isGuildMaster() or getSelfPlayer():get():isGuildSubMaster() then
      if remainTime <= 0 then
        self._ui.txt_ProgressQuestTime:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_TEXT_TIMEOUT"))
        self._parentBG:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "HandleEventLUp_GuildQuest_Giveup()")
        PaGlobal_GuildMain_All:setKeyguideTextWithShow(true, __eConsoleUIPadEvent_Y, PAGetString(Defines.StringSheet_RESOURCE, "PANEL_GUILD_QUEST_GIVEUP_BTN"))
        self._ui.txt_ProgressQuestTime:SetShow(true)
      else
        self._parentBG:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "HandleEventLUp_GuildQuest_Clear()")
        PaGlobal_GuildMain_All:setKeyguideTextWithShow(true, __eConsoleUIPadEvent_Y, PAGetString(Defines.StringSheet_RESOURCE, "FRAME_GUILD_QUEST_COMPLETEQUEST"))
        self._ui.txt_ProgressQuestTime:SetShow(false)
      end
      self._ui.btn_Complete:SetShow(false == self._isConsole)
    else
      self._ui.btn_Complete:SetShow(false)
    end
  else
    self._ui.btn_Complete:SetShow(false)
  end
end
function PaGlobal_GuildQuest_All:updateCurrentPage()
  if false == self._parentBG:GetShow() then
    return
  end
  local myGuildInfo = ToClient_GetMyGuildInfoWrapper()
  if nil == myGuildInfo then
    return
  end
  local isProgressing = ToClient_isProgressingGuildQuest()
  local enableQuestCount = myGuildInfo:getAvaiableGuildQuestCount()
  local myGuildQuestListCount = ToClient_RequestGuildQuestCount()
  local questCount = 1
  self._currentQuestListData = {}
  for index = 0, myGuildQuestListCount - 1 do
    if index < myGuildQuestListCount then
      local quest = ToClient_RequestGuildQuestAt(index)
      if quest:getGuildQuestType() == self._guildQuestType then
        self._currentQuestListData[questCount] = quest
        questCount = questCount + 1
      end
    end
  end
  for index = 0, self._qeustListMaxShowCount - 1 do
    local questIndex = self._currentPage * self._qeustListMaxShowCount + index
    if questIndex < #self._currentQuestListData then
      local guildQuestList = self._currentQuestListData[questIndex + 1]
      if nil ~= guildQuestList then
        self._questList[index].funds:SetShow(false)
        self._questList[index].accept:SetFontColor(Defines.Color.C_FFDDC39E)
        if (getSelfPlayer():get():isGuildMaster() or getSelfPlayer():get():isGuildSubMaster()) and false == isProgressing then
          if 0 < enableQuestCount then
            self._questList[index].rightBtn:SetIgnore(false)
            self._questList[index].rightBtn:SetEnable(true)
            self._questList[index].rightBtn:SetMonoTone(false)
            if self._isConsole then
              self._questList[index].rightBtn:addInputEvent("Mouse_LUp", "HandleEventLUp_GuildQuest_AcceptQuest_All(" .. index .. ")")
            end
            self._questList[index].accept:SetFontColor(Defines.Color.C_FFFFFFFF)
          else
            self._questList[index].rightBtn:SetMonoTone(true)
            if self._isConsole then
              self._questList[index].rightBtn:addInputEvent("Mouse_LUp", "")
            else
              self._questList[index].rightBtn:SetIgnore(true)
              self._questList[index].rightBtn:SetEnable(false)
            end
          end
        else
          self._questList[index].rightBtn:SetMonoTone(true)
          if self._isConsole then
            self._questList[index].rightBtn:addInputEvent("Mouse_LUp", "")
          else
            self._questList[index].rightBtn:SetIgnore(true)
            self._questList[index].rightBtn:SetEnable(false)
          end
        end
        local requireGuildRank = guildQuestList:getGuildQuestGrade()
        local requireGuildRankStr = ""
        if 1 == requireGuildRank then
          requireGuildRankStr = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_QUEST_SMALL")
        elseif 2 == requireGuildRank then
          requireGuildRankStr = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_QUEST_MIDDLE")
        elseif 3 == requireGuildRank then
          requireGuildRankStr = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_QUEST_BIG")
        elseif 4 == requireGuildRank then
          requireGuildRankStr = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_QUEST_BIGGEST")
        end
        self._questList[index].title:SetText(PAGetStringParam2(Defines.StringSheet_GAME, "LUA_GUILD_QUEST_LIMIT", "currentGuildQuestName", guildQuestList:getTitle(), "requireGuildRankStr", requireGuildRankStr))
        self._questList[index].desc:SetText(guildQuestList:getDesc())
        self._questList[index].icon:ChangeTextureInfoName(guildQuestList:getIconPath())
        local remainTime = PaGlobal_GuildQuest_GetQuestTimeFormatString(guildQuestList:getLimitMinute())
        self._questList[index].limitTime:SetText(remainTime)
        self._questList[index].limitTime:SetColor(4293762204)
        self._questList[index].limitTime:SetIgnore(false)
      end
      self._questList[index].listBG:SetShow(true)
    else
      self._questList[index].listBG:SetShow(false)
    end
  end
  self._maxPageCount = math.ceil(#self._currentQuestListData / self._qeustListMaxShowCount)
  if 0 == self._maxPageCount then
    self._maxPageCount = 1
  end
  self._ui.txt_PageCount:SetText(self._currentPage + 1 .. "/" .. self._maxPageCount)
end
function PaGlobal_GuildQuest_All:selectTab(questType)
  if nil == questType then
    return
  end
  self._guildQuestType = questType
  local posX = self._rdo_Tab[questType]:GetPosX() + self._rdo_Tab[questType]:GetSizeX() / 2 - self._ui.stc_SelectLine:GetSizeX() / 2
  self._ui.stc_SelectLine:SetPosX(posX)
  for i = 0, self._TabCount - 1 do
    if i == questType then
      self._rdo_Tab[i]:SetCheck(true)
    else
      self._rdo_Tab[i]:SetCheck(false)
    end
  end
end
function PaGlobal_GuildQuest_All:resetPage()
  self._currentPage = 0
  self:updateCurrentPage()
end
