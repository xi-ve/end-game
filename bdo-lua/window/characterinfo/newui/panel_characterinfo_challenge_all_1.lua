function PaGlobal_CharInfoChallenge_All:initialize()
  if true == self._initialize then
    return
  end
  local stc_TabBg = UI.getChildControl(Panel_CharacterInfoChallenge_All, "Static_Category_Tap_ConsoleUI")
  self._ui.stc_KeyGuide_LT = UI.getChildControl(stc_TabBg, "Static_LT_ConsoleUI")
  self._ui.stc_KeyGuide_RT = UI.getChildControl(stc_TabBg, "Static_RT_ConsoleUI")
  self._ui.rdo_Object = UI.getChildControl(stc_TabBg, "RadioButton_Object")
  self._ui.rdo_Time = UI.getChildControl(stc_TabBg, "RadioButton_Time")
  self._ui.rdo_PCRoom = UI.getChildControl(stc_TabBg, "RadioButton_PC_Room")
  self._ui.rdo_Event = UI.getChildControl(stc_TabBg, "RadioButton_Event")
  self._ui.rdo_PreComplete = UI.getChildControl(stc_TabBg, "RadioButton_Pre_Complete")
  self._ui.rdo_Complete = UI.getChildControl(stc_TabBg, "RadioButton_Complete")
  self._ui.stc_selectLine = UI.getChildControl(stc_TabBg, "Static_SelectLine")
  local noticeBg = UI.getChildControl(Panel_CharacterInfoChallenge_All, "Static_NoticeBG")
  self._ui.txt_CompleteTask = UI.getChildControl(noticeBg, "StaticText_Complete")
  self._ui.txt_NotReceivedCount = UI.getChildControl(noticeBg, "StaticText_Waiting")
  self._ui.txt_PcroomTime = UI.getChildControl(noticeBg, "StaticText_PcroomTime")
  self._ui.stc_challBg = UI.getChildControl(Panel_CharacterInfoChallenge_All, "Static_ChallengeListBg")
  self._ui.stc_Challenge_Temp = UI.getChildControl(self._ui.stc_challBg, "Static_Challenge_Template")
  self._ui.stc_Scroll = UI.getChildControl(self._ui.stc_challBg, "Scroll_Challenge")
  self._ui.stc_Scroll_Up = UI.getChildControl(self._ui.stc_Scroll, "Scroll_1_UpButton")
  self._ui.stc_Scroll_Down = UI.getChildControl(self._ui.stc_Scroll, "Scroll_1_DownButton")
  self._ui.stc_Scroll_Ctrl = UI.getChildControl(self._ui.stc_Scroll, "Scroll_1_CtrlButton")
  self._ui.stc_KeyGuideBg = UI.getChildControl(Panel_CharacterInfoChallenge_All, "Static_KeyGuide_ConsoleUI")
  self._ui.stc_KeyGuide_X = UI.getChildControl(self._ui.stc_KeyGuideBg, "StaticText_XButton")
  self._ui.stc_KeyGuide_A = UI.getChildControl(self._ui.stc_KeyGuideBg, "StaticText_AButton")
  self._ui.stc_KeyGuide_B = UI.getChildControl(self._ui.stc_KeyGuideBg, "StaticText_BButton")
  local stc_rewardConsoleBg = UI.getChildControl(Panel_CharacterInfoChallenge_All, "Static_PopupBox_ConsoleUI")
  self._ui.stc_Console_RewardBg = UI.getChildControl(stc_rewardConsoleBg, "Static_RewardBox")
  self._ui.stc_Console_BasicItem = {}
  self._ui.stc_Console_SelectItem = {}
  self._isConsole = _ContentsGroup_UsePadSnapping
  self._selfPlayer = getSelfPlayer()
  UI.ASSERT_NAME(nil ~= self._selfPlayer, " Panel_CharacterInfo_FootPrint_All_1.lua / getSelfPlayer() is nil", "\234\185\128\234\183\188\236\154\176")
  if nil == self._selfPlayer then
    return
  end
  self._ui.stc_KeyGuideBg:SetShow(self._isConsole)
  self._ui.stc_Console_RewardBg:SetShow(self._isConsole)
  self._ui.stc_KeyGuide_LT:SetShow(self._isConsole)
  self._ui.stc_KeyGuide_RT:SetShow(self._isConsole)
  if true == self._isConsole then
    local keyguide = {
      self._ui.stc_KeyGuide_X,
      self._ui.stc_KeyGuide_A,
      self._ui.stc_KeyGuide_B
    }
    PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyguide, self._ui.stc_KeyGuideBg, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHT)
  end
  self._ui.rdo_Table[0] = self._ui.rdo_Object
  self._ui.rdo_Table[1] = self._ui.rdo_Time
  self._ui.rdo_Table[2] = self._ui.rdo_PCRoom
  self._ui.rdo_Table[3] = self._ui.rdo_Event
  self._ui.rdo_Table[4] = self._ui.rdo_PreComplete
  self._ui.rdo_Table[5] = self._ui.rdo_Complete
  self._ui.stc_Challenge_Temp:SetShow(false)
  PaGlobal_CharInfoChallenge_All:validate()
  PaGlobal_CharInfoChallenge_All:tabMenuSetting()
  PaGlobal_CharInfoChallenge_All:createRewardUI()
  PaGlobal_CharInfoChallenge_All:registEventHandler(self._isConsole)
  PaGlobal_CharInfoChallenge_All._initialize = true
end
function PaGlobal_CharInfoChallenge_All:registEventHandler(console)
  registerEvent("FromClient_ChallengeReward_UpdateText", "FromClient_CharInfoChallenge_All_Update")
  if true == console then
  else
    for idx = 0, #self._ui.rdo_Table do
      self._ui.rdo_Table[idx]:addInputEvent("Mouse_LUp", "HandleEventLUp_CharInfoChallenge_All_ChallengeTabClick(" .. idx .. ")")
    end
    UIScroll.InputEvent(self._ui.stc_Scroll, "HandleEventScroll_CharInfoChallenge_All_ScrollUpdate")
    self._ui.stc_challBg:addInputEvent("Mouse_UpScroll", "HandleEventScroll_CharInfoChallenge_All_ScrollUpdate(true)")
    self._ui.stc_challBg:addInputEvent("Mouse_DownScroll", "HandleEventScroll_CharInfoChallenge_All_ScrollUpdate(false)")
    self._ui.txt_PcroomTime:addInputEvent("Mouse_LUp", "HandleEventLUp_CharInfoChallenge_All_PcRoomTimeRefresh()")
    self._ui.txt_PcroomTime:addInputEvent("Mouse_On", "HandleEventOnOut_CharInfoChallenge_All_PcRoomTimeTooltip(true)")
    self._ui.txt_PcroomTime:addInputEvent("Mouse_Out", "HandleEventOnOut_CharInfoChallenge_All_PcRoomTimeTooltip(false)")
  end
end
function PaGlobal_CharInfoChallenge_All:tabMenuSetting()
  local countrySet = true
  if isGameTypeEnglish() or isGameTypeTaiwan() or isGameTypeSA() or isGameTypeKR2() or isGameTypeTR() or isGameTypeTH() or isGameTypeID() or self._isConsole then
    countrySet = false
  else
    countrySet = true
  end
  local arrangeTable = {}
  local uiCount = 0
  for idx = 0, self._MAXTABCOUNT - 1 do
    if idx == 2 then
      self._ui.rdo_Table[2]:SetShow(countrySet)
    end
    if true == self._ui.rdo_Table[idx]:GetShow() then
      arrangeTable[uiCount] = self._ui.rdo_Table[idx]
      uiCount = uiCount + 1
    end
  end
  local gap = 60
  local startPosX = -((uiCount - 1) * gap)
  for idx = 0, #arrangeTable do
    arrangeTable[idx]:SetSpanSize(startPosX + 120 * idx, self._ui.rdo_Table[idx]:GetSpanSize().y)
  end
end
function PaGlobal_CharInfoChallenge_All:createRewardUI()
  for idx = 0, self._MAXBGCOUNT - 1 do
    local rewardUI = {
      _bg = nil,
      _btn = nil,
      _title = nil,
      _desc = nil,
      _rewardArea = nil,
      _txt_Complete = nil,
      _receiveBtn = nil,
      _basicItem = {},
      _selectItem = {},
      _selectEffect = nil
    }
    rewardUI._bg = UI.cloneControl(self._ui.stc_Challenge_Temp, self._ui.stc_challBg, "Static_Challenge_" .. idx)
    rewardUI._title = UI.getChildControl(rewardUI._bg, "StaticText_Title")
    rewardUI._desc = UI.getChildControl(rewardUI._bg, "StaticText_Desc")
    rewardUI._rewardArea = UI.getChildControl(rewardUI._bg, "Static_RewardArea")
    rewardUI._btn = UI.getChildControl(rewardUI._bg, "Static_ButtonGroup")
    rewardUI._receiveBtn = UI.getChildControl(rewardUI._btn, "Button_Receive")
    rewardUI._txt_Complete = UI.getChildControl(rewardUI._btn, "StaticText_complete")
    rewardUI._selectEffect = UI.getChildControl(rewardUI._rewardArea, "Template_Static_SlotSelectBG")
    if false == self._isConsole then
      rewardUI._title:SetIgnore(false)
      rewardUI._title:addInputEvent("Mouse_DownScroll", "HandleEventScroll_CharInfoChallenge_All_ScrollUpdate(false)")
      rewardUI._title:addInputEvent("Mouse_UpScroll", "HandleEventScroll_CharInfoChallenge_All_ScrollUpdate(true)")
      rewardUI._desc:addInputEvent("Mouse_Out", "TooltipSimple_Hide()")
      rewardUI._desc:addInputEvent("Mouse_DownScroll", "HandleEventScroll_CharInfoChallenge_All_ScrollUpdate(false)")
      rewardUI._desc:addInputEvent("Mouse_UpScroll", "HandleEventScroll_CharInfoChallenge_All_ScrollUpdate(true)")
    end
    for mainIdx = 0, self._MAXBASESLOT - 1 do
      local baseUI = {_bg = nil, _slot = nil}
      baseUI._bg = UI.getChildControl(rewardUI._rewardArea, "Static_Basic_SlotBg" .. tostring(mainIdx))
      if false == self._isConsole then
        baseUI._bg:ChangeOnTextureInfoName("combine/frame/combine_frame_00.dds")
        local x1, y1, x2, y2 = setTextureUV_Func(baseUI._bg, 46, 99, 90, 143)
        baseUI._bg:getOnTexture():setUV(x1, y1, x2, y2)
      end
      local mainItem = {}
      SlotItem.new(mainItem, "Static_Challenge_" .. tostring(idx) .. "_rdo_MainSlot_" .. tostring(mainIdx), mainIdx, baseUI._bg, self._slotConfig)
      mainItem.icon:SetHorizonCenter()
      mainItem.icon:SetVerticalMiddle()
      mainItem:createChild()
      baseUI._slot = mainItem
      rewardUI._basicItem[mainIdx] = baseUI
      self._originBaseSlotSize = mainItem.icon:GetSizeY()
      self._originSpanSizeX[mainIdx] = rewardUI._basicItem[mainIdx]._bg:GetSpanSize().x
    end
    for subidx = 0, self._MAXSUBSLOT - 1 do
      local subUI = {_bg = nil, _slot = nil}
      subUI._bg = UI.getChildControl(rewardUI._rewardArea, "Radiobutton_Select_SlotBg" .. tostring(subidx))
      local subItem = {}
      SlotItem.new(subItem, "Static_Challenge_" .. tostring(idx) .. "_rdo_SubSlot_" .. tostring(subidx), subidx, subUI._bg, self._slotConfig)
      subItem:createChild()
      subItem.icon:SetPosX(0)
      subItem.icon:SetPosY(0)
      subItem.icon:SetSize(35, 35)
      subItem.border:SetSize(34, 34)
      subItem.border:SetPosX(1)
      subItem.border:SetPosY(1)
      subItem.count:SetPosX(-8)
      subItem.count:SetPosY(15)
      subItem.classEquipBG:SetHorizonRight()
      subItem.classEquipBG:SetVerticalBottom()
      subItem.classEquipBG:SetSpanSize(2, 2)
      subUI._slot = subItem
      rewardUI._selectItem[subidx] = subUI
    end
    rewardUI._txt_Complete:SetSize(math.min(125, rewardUI._txt_Complete:GetTextSizeX()))
    local iconSIze = UI.getChildControl(rewardUI._txt_Complete, "StaticText_1")
    if true == isGameTypeKorea() then
      rewardUI._txt_Complete:SetSpanSize(rewardUI._txt_Complete:GetSpanSize().x + rewardUI._txt_Complete:GetTextSizeX() * 0.5, rewardUI._txt_Complete:GetSpanSize().y)
    end
    if rewardUI._txt_Complete:GetTextSizeX() > rewardUI._txt_Complete:GetSizeX() + iconSIze:GetSizeX() + 5 then
      rewardUI._txt_Complete:SetIgnore(false)
      UI.setLimitTextAndAddTooltip(rewardUI._txt_Complete)
    end
    rewardUI._txt_Complete:ComputePos()
    rewardUI._bg:SetShow(true)
    rewardUI._bg:SetPosY(self._ui.stc_Challenge_Temp:GetPosY() + (self._ui.stc_Challenge_Temp:GetSizeY() + 5) * idx)
    rewardUI._bg:SetSpanSize(self._ui.stc_Challenge_Temp:GetSpanSize().x, self._ui.stc_Challenge_Temp:GetSpanSize().y + (self._ui.stc_Challenge_Temp:GetSizeY() + 5) * idx)
    rewardUI._rewardArea:addInputEvent("Mouse_On", "HandleEventLUp_CharInfoChallenge_All_SlotItemTooltip(false)")
    rewardUI._rewardArea:addInputEvent("Mouse_UpScroll", "HandleEventScroll_CharInfoChallenge_All_ScrollUpdate(true)")
    rewardUI._rewardArea:addInputEvent("Mouse_DownScroll", "HandleEventScroll_CharInfoChallenge_All_ScrollUpdate(false)")
    function rewardUI:clearSlotAll()
      rewardUI._bg:SetShow(false)
      rewardUI._receiveBtn:SetShow(false)
      rewardUI._receiveBtn:addInputEvent("Mouse_LUp", "")
      rewardUI._txt_Complete:SetShow(false)
      rewardUI._selectEffect:SetShow(false)
      for mainIdx = 0, 5 do
        rewardUI._basicItem[mainIdx]._slot:clearItem()
        rewardUI._basicItem[mainIdx]._slot.icon:addInputEvent("Mouse_On", "")
        rewardUI._basicItem[mainIdx]._slot.icon:addInputEvent("Mouse_Out", "")
        rewardUI._basicItem[mainIdx]._slot.icon:addInputEvent("Mouse_UpScroll", "HandleEventScroll_CharInfoChallenge_All_ScrollUpdate(true)")
        rewardUI._basicItem[mainIdx]._slot.icon:addInputEvent("Mouse_DownScroll", "HandleEventScroll_CharInfoChallenge_All_ScrollUpdate(false)")
      end
      for subidx = 0, 5 do
        rewardUI._selectItem[subidx]._slot:clearItem()
        rewardUI._selectItem[subidx]._slot.icon:addInputEvent("Mouse_On", "")
        rewardUI._selectItem[subidx]._slot.icon:addInputEvent("Mouse_Out", "")
        rewardUI._selectItem[subidx]._bg:SetCheck(false)
        rewardUI._selectItem[subidx]._slot.icon:addInputEvent("Mouse_UpScroll", "HandleEventScroll_CharInfoChallenge_All_ScrollUpdate(true)")
        rewardUI._selectItem[subidx]._slot.icon:addInputEvent("Mouse_DownScroll", "HandleEventScroll_CharInfoChallenge_All_ScrollUpdate(false)")
      end
    end
    function rewardUI:setBaseSlotShow(isShow, count)
      if count >= PaGlobal_CharInfoChallenge_All._MAXBASESLOT then
        count = PaGlobal_CharInfoChallenge_All._MAXBASESLOT - 1
      end
      for mainIdx = 0, PaGlobal_CharInfoChallenge_All._MAXBASESLOT - 1 do
        local originSize = PaGlobal_CharInfoChallenge_All._originBaseSlotSize * rewardUI._basicItem[mainIdx]._bg:GetScale().x
        rewardUI._basicItem[mainIdx]._bg:SetSize(originSize, originSize)
        rewardUI._basicItem[mainIdx]._slot.icon:SetSize(originSize, originSize)
        rewardUI._basicItem[mainIdx]._slot.border:SetSize(originSize, originSize)
        rewardUI._basicItem[mainIdx]._slot.count:SetSize(originSize, originSize)
        rewardUI._basicItem[mainIdx]._bg:SetSpanSize(PaGlobal_CharInfoChallenge_All._originSpanSizeX[mainIdx] * rewardUI._basicItem[mainIdx]._bg:GetScale().x, rewardUI._selectItem[mainIdx]._bg:GetSpanSize().y)
        if 3 < mainIdx then
          rewardUI._basicItem[mainIdx]._bg:SetShow(false)
        end
        rewardUI._basicItem[mainIdx]._bg:ComputePos()
      end
      local sizeX = 50
      for mainIdx = 0, count do
        rewardUI._basicItem[mainIdx]._bg:SetShow(isShow)
        if count == PaGlobal_CharInfoChallenge_All._MAXBASESLOT - 1 then
          rewardUI._basicItem[mainIdx]._bg:SetSize(rewardUI._selectItem[mainIdx]._bg:GetSizeX(), rewardUI._selectItem[mainIdx]._bg:GetSizeY())
          rewardUI._basicItem[mainIdx]._slot.icon:SetSize(rewardUI._selectItem[mainIdx]._bg:GetSizeX(), rewardUI._selectItem[mainIdx]._bg:GetSizeY())
          rewardUI._basicItem[mainIdx]._slot.border:SetSize(rewardUI._selectItem[mainIdx]._bg:GetSizeX(), rewardUI._selectItem[mainIdx]._bg:GetSizeY())
          rewardUI._basicItem[mainIdx]._slot.count:SetSize(rewardUI._selectItem[mainIdx]._bg:GetSizeX(), rewardUI._selectItem[mainIdx]._bg:GetSizeY())
          rewardUI._basicItem[mainIdx]._bg:SetSpanSize(rewardUI._selectItem[mainIdx]._bg:GetSpanSize().x, rewardUI._selectItem[mainIdx]._bg:GetSpanSize().y)
        elseif count == PaGlobal_CharInfoChallenge_All._MAXBASESLOT - 2 then
          local spanSizeX = rewardUI._basicItem[count]._bg:GetSpanSize().x - sizeX * rewardUI._basicItem[mainIdx]._bg:GetScale().x * (count - mainIdx)
          rewardUI._basicItem[mainIdx]._bg:SetSpanSize(spanSizeX, rewardUI._basicItem[mainIdx]._bg:GetSpanSize().y)
        end
        rewardUI._basicItem[mainIdx]._slot.icon:ComputePos()
        rewardUI._basicItem[mainIdx]._slot.border:ComputePos()
        rewardUI._basicItem[mainIdx]._slot.count:ComputePos()
        rewardUI._basicItem[mainIdx]._slot.icon:SetHorizonCenter()
        rewardUI._basicItem[mainIdx]._slot.icon:SetVerticalMiddle()
        rewardUI._basicItem[mainIdx]._slot.count:SetVerticalMiddle()
        rewardUI._basicItem[mainIdx]._slot.count:SetVerticalMiddle()
        rewardUI._basicItem[mainIdx]._slot.border:SetPosXY(1, 1)
      end
    end
    function rewardUI:setSubSlotShow(isShow, count)
      if count >= PaGlobal_CharInfoChallenge_All._MAXSUBSLOT - 1 then
        count = PaGlobal_CharInfoChallenge_All._MAXSUBSLOT - 1
      end
      for subIdx = 0, count do
        rewardUI._selectItem[subIdx]._bg:SetShow(isShow)
      end
    end
    function rewardUI:setRewardSlotWithTooltip(uiSlot, rewardTable, uiIdx, index, questType)
      local registEventControl
      if "main" == questType then
        registEventControl = rewardUI._basicItem[index]._bg
      elseif "sub" == questType then
        registEventControl = rewardUI._selectItem[index]._bg
      end
      if nil == registEventControl then
        return
      end
      if __eRewardExp == rewardTable._type then
        uiSlot.count:SetText("")
        uiSlot.icon:ChangeTextureInfoName("Icon/New_Icon/03_ETC/12_DoApplyDirectlyItem/EXP.dds")
        if false == PaGlobal_CharInfoChallenge_All._isConsole then
          uiSlot.icon:addInputEvent("Mouse_On", "ChallengeRewardTooltip( \"Exp\", true, \"" .. questType .. "\", " .. index .. ", " .. uiIdx .. " )")
          uiSlot.icon:addInputEvent("Mouse_Out", "ChallengeRewardTooltip( \"Exp\", false, \"" .. questType .. "\", " .. index .. ", " .. uiIdx .. " )")
        elseif false == _ContentsGroup_RenewUI_Tooltip then
          registEventControl:registerPadEvent(__eConsoleUIPadEvent_Up_X, "ChallengeRewardTooltip( \"Exp\", true, \"" .. questType .. "\", " .. index .. ", " .. uiIdx .. " )")
          registEventControl:addInputEvent("Mouse_Out", "ChallengeRewardTooltip( \"Exp\", false, \"" .. questType .. "\", " .. index .. ", " .. uiIdx .. " )")
        end
        uiSlot.icon:setTooltipEventRegistFunc("ChallengeRewardTooltip( \"Exp\", true, \"" .. questType .. "\", " .. index .. ", " .. uiIdx .. " )")
      elseif __eRewardSkillExp == rewardTable._type then
        uiSlot.count:SetText("")
        uiSlot.icon:ChangeTextureInfoName("Icon/New_Icon/03_ETC/12_DoApplyDirectlyItem/SkillExp.dds")
        if false == PaGlobal_CharInfoChallenge_All._isConsole then
          uiSlot.icon:addInputEvent("Mouse_On", "ChallengeRewardTooltip( \"SkillExp\", true, \"" .. questType .. "\", " .. index .. ", " .. uiIdx .. " )")
          uiSlot.icon:addInputEvent("Mouse_Out", "ChallengeRewardTooltip( \"SkillExp\", false, \"" .. questType .. "\", " .. index .. ", " .. uiIdx .. " )")
        elseif false == _ContentsGroup_RenewUI_Tooltip then
          registEventControl:registerPadEvent(__eConsoleUIPadEvent_Up_X, "ChallengeRewardTooltip( \"SkillExp\", true, \"" .. questType .. "\", " .. index .. ", " .. uiIdx .. " )")
          registEventControl:addInputEvent("Mouse_Out", "ChallengeRewardTooltip( \"SkillExp\", false, \"" .. questType .. "\", " .. index .. ", " .. uiIdx .. " )")
        end
        uiSlot.icon:setTooltipEventRegistFunc("ChallengeRewardTooltip( \"SkillExp\", true, \"" .. questType .. "\", " .. index .. ", " .. uiIdx .. " )")
      elseif __eRewardLifeExp == rewardTable._type then
        uiSlot.count:SetText("")
        uiSlot.icon:ChangeTextureInfoName("Icon/New_Icon/03_ETC/12_DoApplyDirectlyItem/EXP.dds")
        if false == PaGlobal_CharInfoChallenge_All._isConsole then
          uiSlot.icon:addInputEvent("Mouse_On", "ChallengeRewardTooltip( \"ProductExp\", true, \"" .. questType .. "\", " .. index .. ", " .. uiIdx .. " )")
          uiSlot.icon:addInputEvent("Mouse_Out", "ChallengeRewardTooltip( \"ProductExp\", false, \"" .. questType .. "\", " .. index .. ", " .. uiIdx .. " )")
        elseif false == _ContentsGroup_RenewUI_Tooltip then
          registEventControl:registerPadEvent(__eConsoleUIPadEvent_Up_X, "ChallengeRewardTooltip( \"ProductExp\", true, \"" .. questType .. "\", " .. index .. ", " .. uiIdx .. " )")
          registEventControl:addInputEvent("Mouse_Out", "ChallengeRewardTooltip( \"ProductExp\", false, \"" .. questType .. "\", " .. index .. ", " .. uiIdx .. " )")
        end
        uiSlot.icon:setTooltipEventRegistFunc("ChallengeRewardTooltip( \"ProductExp\", true, \"" .. questType .. "\", " .. index .. ", " .. uiIdx .. " )")
      elseif __eRewardItem == rewardTable._type then
        local itemStatic = getItemEnchantStaticStatus(ItemEnchantKey(rewardTable._item))
        uiSlot:setItemByStaticStatus(itemStatic, rewardTable._count)
        uiSlot._item = rewardTable._item
        if false == PaGlobal_CharInfoChallenge_All._isConsole then
          uiSlot.icon:SetIgnore(false)
          uiSlot.icon:addInputEvent("Mouse_On", "HandleEventLUp_CharInfoChallenge_All_SlotItemTooltip( true, " .. uiIdx .. ", " .. index .. ", \"" .. questType .. "\" )")
          uiSlot.icon:addInputEvent("Mouse_Out", "HandleEventLUp_CharInfoChallenge_All_SlotItemTooltip( false )")
          uiSlot.icon:setTooltipEventRegistFunc("HandleEventLUp_CharInfoChallenge_All_SlotItemTooltip( true, " .. uiIdx .. ", " .. index .. ", \"" .. questType .. "\" )")
          uiSlot.icon:addInputEvent("Mouse_UpScroll", "HandleEventScroll_CharInfoChallenge_All_ScrollUpdate(true)")
          uiSlot.icon:addInputEvent("Mouse_DownScroll", "HandleEventScroll_CharInfoChallenge_All_ScrollUpdate(false)")
        elseif false == _ContentsGroup_RenewUI_Tooltip then
          registEventControl:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandleEventLUp_CharInfoChallenge_All_SlotItemTooltip( true, " .. uiIdx .. ", " .. index .. ", \"" .. questType .. "\" )")
          registEventControl:addInputEvent("Mouse_Out", "HandleEventLUp_CharInfoChallenge_All_SlotItemTooltip( false )")
        end
        return rewardTable._isEquipable
      elseif __eRewardIntimacy == rewardTable._type then
        uiSlot.count:SetText("")
        uiSlot.icon:ChangeTextureInfoName("Icon/New_Icon/00000000_Special_Contributiveness.dds")
        if false == PaGlobal_CharInfoChallenge_All._isConsole then
          uiSlot.icon:SetIgnore(false)
          uiSlot.icon:addInputEvent("Mouse_On", "ChallengeRewardTooltip( \"Intimacy\", true, \"" .. questType .. "\", " .. index .. ", " .. uiIdx .. " )")
          uiSlot.icon:addInputEvent("Mouse_Out", "HandleEventLUp_CharInfoChallenge_All_SlotItemTooltip( false )")
          uiSlot.icon:setTooltipEventRegistFunc("ChallengeRewardTooltip( \"Intimacy\", true, \"" .. questType .. "\", " .. index .. ", " .. uiIdx .. " )")
        elseif false == _ContentsGroup_RenewUI_Tooltip then
          registEventControl:registerPadEvent(__eConsoleUIPadEvent_Up_X, "ChallengeRewardTooltip( \"Intimacy\", true, \"" .. questType .. "\", " .. index .. ", " .. uiIdx .. " )")
          registEventControl:addInputEvent("Mouse_Out", "HandleEventLUp_CharInfoChallenge_All_SlotItemTooltip( false )")
        end
      else
        uiSlot.icon:addInputEvent("Mouse_On", "")
        uiSlot.icon:addInputEvent("Mouse_Out", "")
      end
    end
    PaGlobal_CharInfoChallenge_All._ui.stc_RewardTable[idx] = rewardUI
  end
end
function PaGlobal_CharInfoChallenge_All:dataClear()
  self._currentSelected._challengeIdx = nil
  self._currentSelected._subItemIdx = nil
  PaGlobal_CharInfoChallenge_All._ui.stc_Scroll:SetControlTop()
  PaGlobal_CharInfoChallenge_All._scrollIdx = 0
  self._consoleUIIdx = 0
  for idx = 0, #self._ui.rdo_Table do
    self._ui.rdo_Table[idx]:SetCheck(false)
  end
end
function PaGlobal_CharInfoChallenge_All:update()
  local totalCompleteCount = ToClient_GetCompletedChallengeCount()
  local totalProgressCount = ToClient_GetProgressChallengeCount(1) + ToClient_GetProgressChallengeCount(2) + ToClient_GetProgressChallengeCount(3)
  local finishedTask_Count = totalCompleteCount .. " / " .. totalCompleteCount + totalProgressCount
  self._ui.txt_CompleteTask:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_CHARACTERINFO_CHALLENGE_CLEARCOUNTTEXT") .. "  " .. finishedTask_Count)
  local remainReward_Count = PaGlobal_CharInfoChallenge_All:getRemainReward()
  if remainReward_Count <= 0 then
    self._ui.txt_NotReceivedCount:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_CHALLENGE_REWARDCOUNTVALUE_EMPTY"))
    self._ui.txt_NotReceivedCount:SetFontColor(Defines.Color.C_FF888888)
  else
    self._ui.txt_NotReceivedCount:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_CHALLENGE_REWARDCOUNTVALUE_HAVE", "remainRewardCount", remainReward_Count))
    self._ui.txt_NotReceivedCount:SetFontColor(Defines.Color.C_FFFFFFFF)
  end
  self._ui.txt_PcroomTime:SetShow(_ContentsGroup_PCRoomCumulativeTime)
  if true == _ContentsGroup_PCRoomCumulativeTime then
    local pcRoomTime = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_CHALLANGE_ACCUMULATEPCROOMPLAYTIME", "time", convertStringFromDatetimeAll(ToClient_GetUserPcRoomPlayTime()))
    self._ui.txt_PcroomTime:SetText(pcRoomTime)
  end
  for idx = 0, self._MAXBGCOUNT - 1 do
    self._ui.stc_RewardTable[idx]:clearSlotAll()
  end
  local challengeType = 0
  local currentTab = self._currentSelected._tabIdx
  if currentTab == self._eTAB.COMPLETE then
    self._currentTaskCount = totalCompleteCount
    UIScroll.SetButtonSize(self._ui.stc_Scroll, self._MAXBGCOUNT - 1, self._currentTaskCount)
    self._ui.stc_Scroll:SetShow(self._currentTaskCount > 4)
    if 0 >= self._currentTaskCount then
      return
    end
    local uiCount = 0
    for idx = 0, self._MAXBGCOUNT - 1 do
      local dataIdx = idx + self._scrollIdx
      local taskInfo = ToClient_GetCompletedChallengeAt(idx + self._scrollIdx)
      if nil ~= taskInfo then
        self._ui.stc_RewardTable[uiCount]._bg:SetShow(true)
        self._ui.stc_RewardTable[uiCount]._title:SetText(taskInfo:getName())
        self._ui.stc_RewardTable[uiCount]._title:SetTextMode(__eTextMode_LimitText)
        self._ui.stc_RewardTable[uiCount]._title:SetText(self._ui.stc_RewardTable[uiCount]._title:GetText())
        self._ui.stc_RewardTable[uiCount]._desc:SetText(taskInfo:getDesc())
        self._ui.stc_RewardTable[uiCount]._txt_Complete:SetShow(true)
        PaGlobal_CharInfoChallenge_All:getRewardSlotInfo(taskInfo, dataIdx, uiCount)
        uiCount = uiCount + 1
      end
      if uiCount == self._MAXBGCOUNT then
        break
      end
    end
  elseif currentTab == self._eTAB.REWARD then
    self._currentTaskCount = PaGlobal_CharInfoChallenge_All:getRewardGroupCount()
    UIScroll.SetButtonSize(self._ui.stc_Scroll, self._MAXBGCOUNT - 1, self._currentTaskCount)
    self._ui.stc_Scroll:SetShow(self._currentTaskCount > 4)
    if 0 >= self._currentTaskCount then
      return
    end
    local uiCount = 0
    for idx = 0, self._MAXBGCOUNT - 1 do
      local dataIdx = PaGlobal_CharInfoChallenge_All:getRewardFirstIndex(idx + self._scrollIdx)
      local rewardWrapper = ToClient_GetChallengeRewardInfoWrapper(dataIdx)
      local isAcceptAbleReward = false
      if nil ~= rewardWrapper then
        self._ui.stc_RewardTable[uiCount]._bg:SetShow(true)
        UI.setLimitTextAndAddTooltip(self._ui.stc_RewardTable[uiCount]._title)
        self._ui.stc_RewardTable[uiCount]._title:SetText(rewardWrapper:getName())
        self._ui.stc_RewardTable[uiCount]._desc:SetText(rewardWrapper:getDesc())
        self._ui.stc_RewardTable[uiCount]._title:SetTextMode(__eTextMode_LimitText)
        self._ui.stc_RewardTable[uiCount]._title:SetText(self._ui.stc_RewardTable[uiCount]._title:GetText())
        local existRewardCount = 0
        if 0 == rewardWrapper:getOptionalType() then
          existRewardCount = rewardWrapper:getRewardCount()
        else
          existRewardCount = ToClient_GetChallengeRewardCountByOptionalType(rewardWrapper:getOptionalType())
        end
        if 0 < existRewardCount then
          self._ui.stc_RewardTable[uiCount]._receiveBtn:SetShow(true)
          self._ui.stc_RewardTable[uiCount]._receiveBtn:addInputEvent("Mouse_LUp", "PaGlobalFunc_CharInfoChallenge_All_ReciveAllReward_Try( " .. dataIdx .. "," .. existRewardCount .. ")")
          self._ui.stc_RewardTable[uiCount]._receiveBtn:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_CHALLENGE_BTNGETREWARD", "existRewardCount", existRewardCount))
          if true == self._isConsole then
            self._ui.stc_RewardTable[uiCount]._receiveBtn:registerPadEvent(__eConsoleUIPadEvent_DpadUp, "")
            self._ui.stc_RewardTable[uiCount]._receiveBtn:registerPadEvent(__eConsoleUIPadEvent_DpadDown, "")
            if 0 == uiCount then
              self._ui.stc_RewardTable[uiCount]._receiveBtn:registerPadEvent(__eConsoleUIPadEvent_DpadUp, "HandleEventScroll_CharInfoChallenge_All_ScrollUpdate(true)")
              self._ui.stc_RewardTable[uiCount]._btn:registerPadEvent(__eConsoleUIPadEvent_DpadUp, "HandleEventScroll_CharInfoChallenge_All_ScrollUpdate(true)")
            elseif 3 == uiCount then
              self._ui.stc_RewardTable[uiCount]._receiveBtn:registerPadEvent(__eConsoleUIPadEvent_DpadDown, "HandleEventScroll_CharInfoChallenge_All_ScrollUpdate(false)")
              self._ui.stc_RewardTable[uiCount]._btn:registerPadEvent(__eConsoleUIPadEvent_DpadDown, "HandleEventScroll_CharInfoChallenge_All_ScrollUpdate(false)")
            end
          else
            self._ui.stc_RewardTable[uiCount]._receiveBtn:addInputEvent("Mouse_UpScroll", "HandleEventScroll_CharInfoChallenge_All_ScrollUpdate(true)")
            self._ui.stc_RewardTable[uiCount]._receiveBtn:addInputEvent("Mouse_DownScroll", "HandleEventScroll_CharInfoChallenge_All_ScrollUpdate(false)")
          end
          isAcceptAbleReward = rewardWrapper:isAcceptAbleReward()
          self._ui.stc_RewardTable[uiCount]._receiveBtn:SetMonoTone(not isAcceptAbleReward, not isAcceptAbleReward)
        end
        PaGlobal_CharInfoChallenge_All:getRewardSlotInfo(rewardWrapper, dataIdx, uiCount, isAcceptAbleReward)
        uiCount = uiCount + 1
      end
      if uiCount == self._MAXBGCOUNT then
        break
      end
    end
  else
    if currentTab == self._eTAB.OBJECT then
      challengeType = 1
    elseif currentTab == self._eTAB.TIME then
      challengeType = 2
    elseif currentTab == self._eTAB.EVENT then
      challengeType = 3
    elseif currentTab == self._eTAB.PCROOM then
      if true == isGameTypeRussia() then
        challengeType = 7
      else
        challengeType = 4
      end
    end
    self._currentTaskCount = ToClient_GetProgressChallengeCount(challengeType)
    UIScroll.SetButtonSize(self._ui.stc_Scroll, self._MAXBGCOUNT - 1, self._currentTaskCount)
    self._ui.stc_Scroll:SetShow(self._currentTaskCount > 4)
    if 0 >= self._currentTaskCount then
      return
    end
    local uiCount = 0
    for idx = 0, self._MAXBGCOUNT - 1 do
      local dataIdx = idx + self._scrollIdx
      local taskInfo = ToClient_GetProgressChallengeAt(challengeType, dataIdx)
      if nil ~= taskInfo then
        self._ui.stc_RewardTable[uiCount]._bg:SetShow(true)
        self._ui.stc_RewardTable[uiCount]._title:SetText(taskInfo:getName())
        self._ui.stc_RewardTable[uiCount]._desc:SetText(taskInfo:getDesc())
        if self._ui.stc_RewardTable[uiCount]._title:GetTextSizeX() > self._ui.stc_RewardTable[uiCount]._title:GetSizeX() + self._ui.stc_RewardTable[uiCount]._receiveBtn:GetSizeX() then
          self._ui.stc_RewardTable[uiCount]._title:SetTextMode(__eTextMode_LimitText)
          self._ui.stc_RewardTable[uiCount]._title:SetText(self._ui.stc_RewardTable[uiCount]._title:GetText())
        end
        PaGlobal_CharInfoChallenge_All:getRewardSlotInfo(taskInfo, dataIdx, uiCount)
        uiCount = uiCount + 1
      end
      if uiCount == self._MAXBGCOUNT then
        break
      end
    end
  end
  self:updateDescTextLimit()
end
function PaGlobal_CharInfoChallenge_All:updateDescTextLimit()
  for idx = 0, self._MAXBGCOUNT - 1 do
    local title = self._ui.stc_RewardTable[idx]._title:GetText()
    local desc = self._ui.stc_RewardTable[idx]._desc:GetText()
    local isDescLimit = self._ui.stc_RewardTable[idx]._desc:IsLimitText()
    local isTitleLimit = self._ui.stc_RewardTable[idx]._title:IsLimitText()
    if false == _ContentsGroup_UsePadSnapping then
      UI.setLimitAutoWrapTextAndAddTooltip(self._ui.stc_RewardTable[idx]._desc, 4, title, desc)
      if true == isTitleLimit then
        self._ui.stc_RewardTable[idx]._title:addInputEvent("Mouse_On", "HandleEventOnOut_CharInfoChallenge_All_ChallengeTitleTooltip(" .. idx .. ")")
      end
      self._ui.stc_RewardTable[idx]._title:addInputEvent("Mouse_Out", "HandleEventOnOut_CharInfoChallenge_All_ChallengeTitleTooltip()")
    else
      self._ui.stc_RewardTable[idx]._receiveBtn:addInputEvent("Mouse_On", "")
      self._ui.stc_RewardTable[idx]._receiveBtn:addInputEvent("Mouse_Out", "")
      self._ui.stc_RewardTable[idx]._desc:SetTextMode(__eTextMode_Limit_AutoWrap)
      self._ui.stc_RewardTable[idx]._desc:setLineCountByLimitAutoWrap(4)
      self._ui.stc_RewardTable[idx]._desc:SetText(self._ui.stc_RewardTable[idx]._desc:GetText())
      if true == isDescLimit or true == isTitleLimit then
        self._ui.stc_RewardTable[idx]._receiveBtn:addInputEvent("Mouse_On", "PaGlobalFunc_ChracterInfo_All_ShowTooltip_Console( " .. idx .. " )")
        self._ui.stc_RewardTable[idx]._receiveBtn:addInputEvent("Mouse_Out", "PaGlobalFunc_ChracterInfo_All_ShowTooltip_Console()")
        self._ui.stc_RewardTable[idx]._rewardArea:addInputEvent("Mouse_On", "PaGlobalFunc_ChracterInfo_All_ShowTooltip_Console( " .. idx .. " )")
        self._ui.stc_RewardTable[idx]._rewardArea:addInputEvent("Mouse_Out", "PaGlobalFunc_ChracterInfo_All_ShowTooltip_Console()")
      end
      for mainIdx = 0, 5 do
        self._ui.stc_RewardTable[idx]._basicItem[mainIdx]._slot.icon:addInputEvent("Mouse_On", "")
        if true == isDescLimit or true == isTitleLimit then
          self._ui.stc_RewardTable[idx]._basicItem[mainIdx]._slot.icon:addInputEvent("Mouse_On", "PaGlobalFunc_ChracterInfo_All_ShowTooltip_Console( " .. idx .. " )")
        else
          self._ui.stc_RewardTable[idx]._basicItem[mainIdx]._slot.icon:addInputEvent("Mouse_On", "PaGlobalFunc_ChracterInfo_All_ShowTooltip_Console()")
        end
        self._ui.stc_RewardTable[idx]._basicItem[mainIdx]._slot.icon:addInputEvent("Mouse_Out", "PaGlobalFunc_ChracterInfo_All_ShowTooltip_Console()")
      end
      for subidx = 0, 5 do
        self._ui.stc_RewardTable[idx]._selectItem[subidx]._slot.icon:addInputEvent("Mouse_On", "")
        if true == isDescLimit or true == isTitleLimit then
          self._ui.stc_RewardTable[idx]._selectItem[subidx]._slot.icon:addInputEvent("Mouse_On", "PaGlobalFunc_ChracterInfo_All_ShowTooltip_Console( " .. idx .. " )")
        else
          self._ui.stc_RewardTable[idx]._selectItem[subidx]._slot.icon:addInputEvent("Mouse_On", "PaGlobalFunc_ChracterInfo_All_ShowTooltip_Console()")
        end
        self._ui.stc_RewardTable[idx]._selectItem[subidx]._slot.icon:addInputEvent("Mouse_Out", "PaGlobalFunc_ChracterInfo_All_ShowTooltip_Console()")
      end
    end
  end
end
function PaGlobal_CharInfoChallenge_All:getRewardSlotInfo(challengeWrapper, challengeIdx, uiIdx, isAcceptAbleReward)
  if nil == challengeWrapper then
    return
  end
  local baseRewardCount = challengeWrapper:getBaseRewardCount()
  local baseRewardData = {}
  for baseIdx = 1, baseRewardCount do
    local _baseData = {
      _type = nil,
      _exp = nil,
      _item = nil,
      _count = nil,
      _chracter = nil,
      _value = nil
    }
    local baseReward = challengeWrapper:getBaseRewardAt(baseIdx - 1)
    _baseData._type = baseReward._type
    if __eRewardExp == baseReward._type then
      _baseData._exp = baseReward._experience
    elseif __eRewardSkillExp == baseReward._type then
      _baseData._exp = baseReward._skillExperience
    elseif __eRewardLifeExp == baseReward._type then
      _baseData._exp = baseReward._productExperience
    elseif __eRewardItem == baseReward._type then
      _baseData._item = baseReward:getItemEnchantKey()
      _baseData._count = baseReward._itemCount
    elseif __eRewardIntimacy == baseReward._type then
      _baseData._character = baseReward:getIntimacyCharacter()
      _baseData._value = baseReward._intimacyValue
    end
    baseRewardData[baseIdx] = _baseData
  end
  local selectRewardCount = challengeWrapper:getSelectRewardCount()
  local subRewardData = {}
  if 0 < selectRewardCount then
    for subIdx = 1, selectRewardCount do
      local _subData = {
        _type = nil,
        _exp = nil,
        _item = nil,
        _count = nil,
        _chracter = nil,
        _value = nil,
        _isEquipable = nil,
        wrapper = nil
      }
      local selectReward = challengeWrapper:getSelectRewardAt(subIdx - 1)
      _subData._type = selectReward._type
      if __eRewardExp == selectReward._type then
        _subData._exp = selectReward._experience
      elseif __eRewardSkillExp == selectReward._type then
        _subData._exp = selectReward._skillExperience
      elseif __eRewardLifeExp == selectReward._type then
        _subData._exp = selectReward._productExperience
      elseif __eRewardItem == selectReward._type then
        _subData._item = selectReward:getItemEnchantKey()
        _subData._count = selectReward._itemCount
        local selfPlayer = getSelfPlayer()
        if nil ~= selfPlayer then
          local classType = selfPlayer:getClassType()
          _subData._isEquipable = selectReward:isEquipable(classType)
        end
      elseif __eRewardIntimacy == selectReward._type then
        _subData._character = selectReward:getIntimacyCharacter()
        _subData._value = selectReward._intimacyValue
      end
      subRewardData[subIdx] = _subData
    end
  end
  PaGlobal_CharInfoChallenge_All:setRewardSlotInfo(baseRewardData, subRewardData, challengeIdx, uiIdx, isAcceptAbleReward)
end
function PaGlobal_CharInfoChallenge_All:setRewardSlotInfo(baseReward, subReward, challengeIdx, uiIdx, isAcceptAbleReward)
  local baseRewardCount = #baseReward
  for idx = 0, self._MAXBASESLOT - 1 do
    if idx < baseRewardCount then
      self._ui.stc_RewardTable[uiIdx]._basicItem[idx]._bg:SetIgnore(false)
      self._ui.stc_RewardTable[uiIdx]:setBaseSlotShow(true, baseRewardCount)
      self._ui.stc_RewardTable[uiIdx]:setRewardSlotWithTooltip(self._ui.stc_RewardTable[uiIdx]._basicItem[idx]._slot, baseReward[idx + 1], uiIdx, idx, "main")
      if true == self._isConsole then
        if 0 == uiIdx then
          self._ui.stc_RewardTable[uiIdx]._basicItem[idx]._bg:registerPadEvent(__eConsoleUIPadEvent_DpadUp, "HandleEventScroll_CharInfoChallenge_All_ScrollUpdate(true)")
        elseif 3 == uiIdx then
          self._ui.stc_RewardTable[uiIdx]._basicItem[idx]._bg:registerPadEvent(__eConsoleUIPadEvent_DpadDown, "HandleEventScroll_CharInfoChallenge_All_ScrollUpdate(false)")
        else
          self._ui.stc_RewardTable[uiIdx]._basicItem[idx]._bg:registerPadEvent(__eConsoleUIPadEvent_DpadUp, "")
          self._ui.stc_RewardTable[uiIdx]._basicItem[idx]._bg:registerPadEvent(__eConsoleUIPadEvent_DpadDown, "")
        end
        if true == _ContentsGroup_RenewUI_Tooltip then
          self._ui.stc_RewardTable[uiIdx]._basicItem[idx]._bg:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandleEventPadPress_CharInfoChallenge_All_ShowItemTooltip(" .. uiIdx .. "," .. baseReward[idx + 1]._item .. "  )")
        end
      end
    else
      self._ui.stc_RewardTable[uiIdx]._basicItem[idx]._bg:SetIgnore(true)
    end
  end
  local selectRewardCount = #subReward
  for idx = 0, self._MAXSUBSLOT - 1 do
    self._ui.stc_RewardTable[uiIdx]._selectItem[idx]._slot.icon:addInputEvent("Mouse_LUp", "")
    self._ui.stc_RewardTable[uiIdx]._selectItem[idx]._slot.icon:SetIgnore(true)
    self._ui.stc_RewardTable[uiIdx]._selectItem[idx]._bg:SetIgnore(true)
    if idx < selectRewardCount then
      self._ui.stc_RewardTable[uiIdx]:setSubSlotShow(true, selectRewardCount)
      self._ui.stc_RewardTable[uiIdx]:setRewardSlotWithTooltip(self._ui.stc_RewardTable[uiIdx]._selectItem[idx]._slot, subReward[idx + 1], uiIdx, idx, "sub")
      if self._eTAB.REWARD == self._currentSelected._tabIdx and true == isAcceptAbleReward or true == self._isConsole then
        self._ui.stc_RewardTable[uiIdx]._selectItem[idx]._slot.icon:SetIgnore(false)
        self._ui.stc_RewardTable[uiIdx]._selectItem[idx]._bg:SetIgnore(false)
        self._ui.stc_RewardTable[uiIdx]._selectItem[idx]._slot.icon:addInputEvent("Mouse_LUp", "HandleEventLUp_CharInfoChallenge_All_SelectItemClick(" .. challengeIdx .. ", " .. uiIdx .. ", " .. idx .. ")")
      end
      if true == self._isConsole then
        if 0 == uiIdx then
          self._ui.stc_RewardTable[uiIdx]._selectItem[idx]._bg:registerPadEvent(__eConsoleUIPadEvent_DpadUp, "HandleEventScroll_CharInfoChallenge_All_ScrollUpdate(true)")
        elseif 3 == uiIdx then
          self._ui.stc_RewardTable[uiIdx]._selectItem[idx]._bg:registerPadEvent(__eConsoleUIPadEvent_DpadDown, "HandleEventScroll_CharInfoChallenge_All_ScrollUpdate(false)")
        else
          self._ui.stc_RewardTable[uiIdx]._selectItem[idx]._bg:registerPadEvent(__eConsoleUIPadEvent_DpadUp, "")
          self._ui.stc_RewardTable[uiIdx]._selectItem[idx]._bg:registerPadEvent(__eConsoleUIPadEvent_DpadDown, "")
        end
        if true == _ContentsGroup_RenewUI_Tooltip then
          self._ui.stc_RewardTable[uiIdx]._selectItem[idx]._bg:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandleEventPadPress_CharInfoChallenge_All_ShowItemTooltip(" .. uiIdx .. "," .. subReward[idx + 1]._item .. "  )")
        end
      end
    end
  end
end
function PaGlobal_CharInfoChallenge_All:getRemainReward()
  local remainRewardGroupCount = PaGlobal_CharInfoChallenge_All:getRewardGroupCount()
  local count = 0
  for index = 0, remainRewardGroupCount - 1 do
    local firstIndex = PaGlobal_CharInfoChallenge_All:getRewardFirstIndex(index)
    local rewardWrapper = ToClient_GetChallengeRewardInfoWrapper(firstIndex)
    if 0 == rewardWrapper:getOptionalType() then
      count = count + rewardWrapper:getRewardCount()
    else
      count = count + ToClient_GetChallengeRewardCountByOptionalType(rewardWrapper:getOptionalType())
    end
  end
  return count
end
function PaGlobal_CharInfoChallenge_All:getRewardGroupCount()
  local length = ToClient_GetChallengeRewardInfoCount()
  local count = 0
  local prevGroup = -1
  local optionalCount = 0
  for index = 0, length - 1 do
    local rewardWrapper = ToClient_GetChallengeRewardInfoWrapper(index)
    if nil ~= rewardWrapper and (prevGroup ~= rewardWrapper:getOptionalType() or 0 == rewardWrapper:getOptionalType()) then
      count = count + 1
      prevGroup = rewardWrapper:getOptionalType()
    end
  end
  return count
end
function PaGlobal_CharInfoChallenge_All:getRewardFirstIndex(groupIndex)
  local length = ToClient_GetChallengeRewardInfoCount()
  local count = -1
  local prevGroup = -1
  for index = 0, length - 1 do
    local rewardWrapper = ToClient_GetChallengeRewardInfoWrapper(index)
    if nil ~= rewardWrapper and (prevGroup ~= rewardWrapper:getOptionalType() or 0 == rewardWrapper:getOptionalType()) then
      count = count + 1
      prevGroup = rewardWrapper:getOptionalType()
    end
    if count == groupIndex then
      return index
    end
  end
  return -1
end
function PaGlobal_CharInfoChallenge_All:validate()
  self._ui.stc_KeyGuide_LT:isValidate()
  self._ui.stc_KeyGuide_RT:isValidate()
  self._ui.rdo_Object:isValidate()
  self._ui.rdo_Time:isValidate()
  self._ui.rdo_PCRoom:isValidate()
  self._ui.rdo_Event:isValidate()
  self._ui.rdo_PreComplete:isValidate()
  self._ui.rdo_Complete:isValidate()
  self._ui.stc_selectLine:isValidate()
  self._ui.txt_CompleteTask:isValidate()
  self._ui.txt_NotReceivedCount:isValidate()
  self._ui.txt_PcroomTime:isValidate()
  self._ui.stc_challBg:isValidate()
  self._ui.stc_Challenge_Temp:isValidate()
  self._ui.stc_Scroll:isValidate()
  self._ui.stc_Scroll_Up:isValidate()
  self._ui.stc_Scroll_Down:isValidate()
  self._ui.stc_Scroll_Ctrl:isValidate()
  self._ui.stc_KeyGuideBg:isValidate()
  self._ui.stc_KeyGuide_X:isValidate()
  self._ui.stc_KeyGuide_A:isValidate()
  self._ui.stc_KeyGuide_B:isValidate()
  self._ui.stc_Console_RewardBg:isValidate()
end
