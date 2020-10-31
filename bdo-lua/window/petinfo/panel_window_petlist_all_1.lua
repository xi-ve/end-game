function PaGlobal_PetList_All:initialize()
  if true == PaGlobal_PetList_All._initialize then
    return
  end
  self._ui.stc_TitleBG = UI.getChildControl(Panel_Window_PetList_All, "Static_TitleBG")
  self._ui_pc.chk_Popup = UI.getChildControl(self._ui.stc_TitleBG, "CheckButton_PopUp")
  self._ui_pc.btn_Question = UI.getChildControl(self._ui.stc_TitleBG, "Button_Question")
  self._ui_pc.btn_Close = UI.getChildControl(self._ui.stc_TitleBG, "Button_Win_Close")
  self._ui.stc_InsideBG = UI.getChildControl(Panel_Window_PetList_All, "Static_InsideBg")
  self._ui.stc_Line = UI.getChildControl(self._ui.stc_InsideBG, "Static_Line_1")
  self._ui.list2_Pet = UI.getChildControl(Panel_Window_PetList_All, "List2_PetList")
  self._ui_pc.stc_DesBG = UI.getChildControl(Panel_Window_PetList_All, "Static_Bg_Des")
  self._ui_pc.txt_DesL = UI.getChildControl(self._ui_pc.stc_DesBG, "StaticText_Des_MouseL")
  self._ui_pc.txt_DesR = UI.getChildControl(self._ui_pc.stc_DesBG, "StaticText_Des_MouseR")
  self._ui_pc.txt_Des = UI.getChildControl(self._ui_pc.stc_DesBG, "StaticText_Des")
  self._ui_pc.stc_FindGroupBG = UI.getChildControl(Panel_Window_PetList_All, "Static_FindGroupBG")
  self._ui_pc.txt_FindGroupTitle = UI.getChildControl(self._ui_pc.stc_FindGroupBG, "StaticText_GroupTitle")
  for i = 1, self._GroupCount do
    self._ui_pc._btn_AllSeal_Group[i] = UI.getChildControl(self._ui_pc.stc_FindGroupBG, "Button_AllSeal_Group" .. i)
  end
  self._ui_pc.btn_ResetGroup = UI.getChildControl(self._ui_pc.stc_FindGroupBG, "Button_ClearGroup")
  self._ui_pc.stc_BtnGroup = UI.getChildControl(Panel_Window_PetList_All, "Static_ButtonBG_PCUI")
  self._ui_pc.btn_Exchange = UI.getChildControl(self._ui_pc.stc_BtnGroup, "Button_Compose")
  self._ui_pc.btn_AllFeeding = UI.getChildControl(self._ui_pc.stc_BtnGroup, "Button_FeedingAll")
  self._ui_pc.btn_AllSeal = UI.getChildControl(self._ui_pc.stc_BtnGroup, "Button_AllUnSeal")
  self._ui_pc.btn_Market = UI.getChildControl(self._ui_pc.stc_BtnGroup, "Button_Market")
  self._ui_console.stc_Bottom_KeyGuideBG = UI.getChildControl(Panel_Window_PetList_All, "Static_BottomBG_ConsoleUI")
  self._ui_console.stc_Bottom_KeyGuideLTA = UI.getChildControl(self._ui_console.stc_Bottom_KeyGuideBG, "StaticText_Command_ConsoleUI")
  self._ui_console.stc_Bottom_KeyGuideA = UI.getChildControl(self._ui_console.stc_Bottom_KeyGuideBG, "StaticText_Confirm_ConsoleUI")
  self._ui_console.stc_Bottom_KeyGuideB = UI.getChildControl(self._ui_console.stc_Bottom_KeyGuideBG, "StaticText_Close_ConsoleUI")
  self._ui_console.stc_Bottom_KeyGuideX = UI.getChildControl(self._ui_console.stc_Bottom_KeyGuideBG, "StaticText_FeedAll_ConsoleUI")
  self._ui_console.stc_Bottom_KeyGuideY = UI.getChildControl(self._ui_console.stc_Bottom_KeyGuideBG, "StaticText_SealAll_ConsoleUI")
  self._ui_pc.stc_FilterBG = UI.getChildControl(Panel_Window_PetList_All, "Static_FilterBg")
  self._ui_pc.rdo_All = UI.getChildControl(self._ui_pc.stc_FilterBG, "RadioButton_All")
  self._ui_pc.rdo_Normal = UI.getChildControl(self._ui_pc.stc_FilterBG, "RadioButton_Normal")
  self._ui_pc.rdo_PCRoom = UI.getChildControl(self._ui_pc.stc_FilterBG, "RadioButton_PCRoom")
  self._ui_pc.btn_RegistPCRoom = UI.getChildControl(Panel_Window_PetList_All, "Button_RegistPCRoom")
  self._ui.stc_SkillInfoBG = UI.getChildControl(Panel_Window_PetList_All, "Static_SkillInfoBg")
  self._ui.txt_SkillListDesc = UI.getChildControl(self._ui.stc_SkillInfoBG, "StaticText_SkillListDesc")
  self._ui.txt_BaseSkillTitle = UI.getChildControl(self._ui.stc_SkillInfoBG, "StaticText_BaseSkillListTitle")
  self._ui.txt_BaseSkill = UI.getChildControl(self._ui.stc_SkillInfoBG, "StaticText_BaseSkillList")
  self._ui.txt_SkillListTitle = UI.getChildControl(self._ui.stc_SkillInfoBG, "StaticText_SkillList_Title")
  self._ui.txt_SkillList = UI.getChildControl(self._ui.stc_SkillInfoBG, "StaticText_SkillList")
  self._ui.txt_TierSetListTitle = UI.getChildControl(self._ui.stc_SkillInfoBG, "StaticText_TierSet_Title")
  self._ui.txt_TierSetList = UI.getChildControl(self._ui.stc_SkillInfoBG, "StaticText_TierSetList")
  self._ui.stc_FeedingBG = UI.getChildControl(Panel_Window_PetList_All, "Static_FeedingBg")
  self._ui.stc_FeedingTitleBG = UI.getChildControl(self._ui.stc_FeedingBG, "Static_subframetitle")
  self._ui.txt_FeedingBGTitle = UI.getChildControl(self._ui.stc_FeedingBG, "StaticText_Feeding")
  self._ui.stc_FeedingIconSlot = UI.getChildControl(self._ui.stc_FeedingBG, "Static_IconBg")
  self._ui.stc_SelectedFeedingItemIcon = UI.getChildControl(self._ui.stc_FeedingBG, "Static_Selected_Item_Icon")
  self._ui_pc.btn_Feeding_FeedOne = UI.getChildControl(self._ui.stc_FeedingBG, "Button_FeedOne")
  self._ui_pc.btn_Feeding_FeedFull = UI.getChildControl(self._ui.stc_FeedingBG, "Button_FeedFull")
  self._ui_pc.btn_Feeding_Close = UI.getChildControl(self._ui.stc_FeedingBG, "Button_Close")
  self._ui_console.stc_Feeding_KeyGuideBG = UI.getChildControl(self._ui.stc_FeedingBG, "Static_FeedBottomBG_ConsoleUI")
  self._ui_console.stc_Feeding_KeyGuideA = UI.getChildControl(self._ui_console.stc_Feeding_KeyGuideBG, "StaticText_Feed_ConsoleUI")
  self._ui_console.stc_Feeding_KeyGuideX = UI.getChildControl(self._ui_console.stc_Feeding_KeyGuideBG, "StaticText_Detail_ConsoleUI")
  self._ui_console.stc_Feeding_KeyGuideY = UI.getChildControl(self._ui_console.stc_Feeding_KeyGuideBG, "StaticText_FeedAll_ConsoleUI")
  self._ui_console.stc_Feeding_KeyGuideB = UI.getChildControl(self._ui_console.stc_Feeding_KeyGuideBG, "StaticText_Cancel_ConsoleUI")
  self._ui_console.stc_PopupBG = UI.getChildControl(Panel_Window_PetList_All, "Static_FocusBg_ConsoleUI")
  self._ui_console.rdo_Unseals = {
    feed = UI.getChildControl(self._ui_console.stc_PopupBG, "RadioButton_Unseal_Feed"),
    order = UI.getChildControl(self._ui_console.stc_PopupBG, "RadioButton_Unseal_Order"),
    info = UI.getChildControl(self._ui_console.stc_PopupBG, "RadioButton_Unseal_Info"),
    seal = UI.getChildControl(self._ui_console.stc_PopupBG, "RadioButton_Unseal_Seal")
  }
  self._ui_console.rdo_Seals = {
    unseal = UI.getChildControl(self._ui_console.stc_PopupBG, "RadioButton_Seal_Unseal"),
    exchange = UI.getChildControl(self._ui_console.stc_PopupBG, "RadioButton_Seal_Compose")
  }
  self._ui_console.stc_Popup_KeyGuideA = UI.getChildControl(self._ui_console.stc_PopupBG, "StaticText_Confirm")
  PaGlobal_PetList_All:validate()
  self._isConsole = _ContentsGroup_UsePadSnapping
  PaGlobal_PetList_All:platformSetting()
  self._maxUnsealCount = ToClient_getPetUseMaxCount()
  Panel_Window_PetList_All:setGlassBackground(true)
  Panel_Window_PetList_All:ActiveMouseEventEffect(true)
  self._isPlayOpen = ToClient_IsContentsGroupOpen("256")
  self._UnSealDATACount = ToClient_getPetUnsealedList()
  self._SealDATACount = ToClient_getPetSealedList()
  self._popUpKeyGuideADefaultPosY = self._ui_console.stc_Popup_KeyGuideA:GetPosY()
  self._popUpKeyGuideAGapSizeY = self._ui_console.rdo_Seals.exchange:GetPosY() - self._ui_console.rdo_Seals.unseal:GetPosY()
  self._originPanelSizeY = Panel_Window_PetList_All:GetSizeY()
  self._originInsideBGSizeY = self._ui.stc_InsideBG:GetSizeY()
  self._originPetListSpanY = self._ui.list2_Pet:GetSpanSize().y
  self._originDesBGSpanY = self._ui_pc.stc_DesBG:GetSpanSize().y
  self._originFindGroupBGSpanY = self._ui_pc.stc_FindGroupBG:GetSpanSize().y
  self._originBtnGroupSpanY = self._ui_pc.stc_BtnGroup:GetSpanSize().y
  self._originSkillInfoBGSpanY = self._ui.stc_SkillInfoBG:GetSpanSize().y
  self._originBtnRegistPCRoomSpanY = self._ui_pc.btn_RegistPCRoom:GetSpanSize().y
  local temporaryInformation = getTemporaryInformationWrapper()
  if nil ~= temporaryInformation and true == temporaryInformation:isPremiumPcRoom() and true == _ContentsGroup_PcRoomPet then
    self._isPremiumPcRoom = true
    self._maxUnsealCount = self._maxUnsealCount + ToClient_getPetUseMaxCountPcRoom()
    PaGlobal_PetList_All:initPCRoomFilterUi()
  end
  if not self._isConsole then
    Panel_MyHouseNavi_Update(true)
  end
  self._ui.txt_SkillListDesc:SetTextMode(__eTextMode_AutoWrap)
  self._ui.txt_SkillListDesc:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_PETCOMPOSE_SKILLINHERIT_DESC"))
  self._ui.txt_BaseSkillTitle:SetPosY(self._ui.txt_SkillListDesc:GetPosY() + self._ui.txt_SkillListDesc:GetTextSizeY() + 20)
  self._ui.txt_BaseSkill:SetPosY(self._ui.txt_BaseSkillTitle:GetPosY() + 40)
  self._ui.txt_BaseSkill:SetTextMode(__eTextMode_AutoWrap)
  local desTextRightPosX = self._ui_pc.txt_Des:GetPosX() + self._ui_pc.txt_Des:GetTextSizeX()
  local desBGSizeX = self._ui_pc.stc_DesBG:GetSizeX() - desTextRightPosX
  local desTotalSizeX = self._ui_pc.txt_DesL:GetSizeX() + self._ui_pc.txt_DesL:GetTextSizeX() + self._ui_pc.txt_DesR:GetSizeX() + self._ui_pc.txt_DesR:GetTextSizeX()
  local desGapSizeX = (desBGSizeX - desTotalSizeX) / 3
  self._ui_pc.txt_DesL:SetPosX(desTextRightPosX + desGapSizeX)
  self._ui_pc.txt_DesR:SetPosX(self._ui_pc.txt_DesL:GetPosX() + self._ui_pc.txt_DesL:GetTextSizeX() + self._ui_pc.txt_DesL:GetSizeX() + desGapSizeX)
  local findGroupTitleRightPosX = self._ui_pc.txt_FindGroupTitle:GetPosX() + self._ui_pc.txt_FindGroupTitle:GetTextSizeX()
  if findGroupTitleRightPosX > self._ui_pc._btn_AllSeal_Group[1]:GetPosX() then
    local gapSizeX = findGroupTitleRightPosX - self._ui_pc._btn_AllSeal_Group[1]:GetPosX() + 5
    for _, control in pairs(self._ui_pc._btn_AllSeal_Group) do
      control:SetPosX(control:GetPosX() + gapSizeX)
    end
  end
  if true == ToClient_isConsole() then
    PaGlobalFunc_TopIcon_Pet_Update()
  else
    FGlobal_PetListNew_NoPet()
  end
  PaGlobal_PetList_All:initFeedUi()
  PaGlobal_PetList_All:showFeedUi(-1)
  PaGlobal_PetList_All:skillBGClose()
  PaGlobal_PetList_All:loadPetGroupList()
  PaGlobal_PetList_All:resize()
  PaGlobal_PetList_All:registEventHandler()
  PaGlobal_PetList_All._initialize = true
end
function PaGlobal_PetList_All:savePetGroupList()
  ToClient_clearPetGroupList()
  for ii = 1, self._GroupCount do
    for key, value in pairs(self._checkUnSealGroupList[ii]) do
      if true == value then
        ToClient_savePetGroupList(ii, key)
      end
    end
  end
end
function PaGlobal_PetList_All:loadPetGroupList()
  local size = ToClient_getSizePetGroupList()
  if 0 == size then
    return
  end
  for ii = 0, size do
    local petNo = ToClient_getPetNoInPetGroupByIndex(ii)
    local groupIdx = ToClient_getPetGroupIndexInPetGroupByIndex(ii)
    self._checkUnSealGroupList[groupIdx][Int64toInt32(petNo)] = true
  end
end
function PaGlobal_PetList_All:checkPetGroupList()
  for ii = 1, self._GroupCount do
    for key, value in pairs(self._checkUnSealGroupList[ii]) do
      local isRemain = false
      if true == value then
        for sealPetIndex = 0, ToClient_getPetSealedList() - 1 do
          local petData = ToClient_getPetSealedDataByIndex(sealPetIndex)
          if key == Int64toInt32(petData._petNo) then
            isRemain = true
          end
        end
        for sealPetIndex = 0, ToClient_getPetUnsealedList() - 1 do
          local petData = ToClient_getPetUnsealedDataByIndex(sealPetIndex)
          if key == Int64toInt32(petData:getPcPetNo()) then
            isRemain = true
          end
        end
      end
      self._checkUnSealGroupList[ii][key] = isRemain
    end
  end
end
function PaGlobal_PetList_All:initFeedUi()
  local originalSlot = self._ui.stc_FeedingIconSlot
  originalSlot:SetShow(false)
  local slotGap = originalSlot:GetSizeX() + 5
  for i = 0, self._feedStaticItemCount - 1 do
    local additionalSlot = UI.createAndCopyBasePropertyControl(self._ui.stc_FeedingBG, "Static_IconBg", self._ui.stc_FeedingBG, "Static_IconBg" .. tostring(i))
    additionalSlot:SetPosX(originalSlot:GetPosX() + slotGap * i)
    additionalSlot:SetShow(false)
    self._feedSlot[i] = {}
    SlotItem.new(self._feedSlot[i], "FeedItem_", i, additionalSlot, self._slotConfig)
    self._feedSlot[i]:createChild()
    self._feedSlot[i].border:SetSize(34, 34)
    self._feedSlot[i].icon:SetSize(34, 34)
    self._feedSlot[i].count:ComputePos()
    if self._isConsole then
      additionalSlot:registerPadEvent(__eConsoleUIPadEvent_DpadRight, "HandleEventDpadRight_PetList_All_FeedBlockSnapGroupMove()")
      additionalSlot:addInputEvent("Mouse_On", "HandleEventLUp_PetList_FeedItem_All(" .. i .. ")")
      if 0 == i then
        self._feedingFirstSlot = additionalSlot
      end
    end
  end
  if self._isConsole then
    self._ui.stc_SelectedFeedingItemIcon:SetIgnore(true)
    self._ui.stc_FeedingBG:SetSize(self._ui.stc_FeedingBG:GetSizeX(), self._ui.stc_FeedingBG:GetSizeY() - self._ui_pc.btn_Feeding_FeedOne:GetSizeY())
    self._ui_console.stc_Feeding_KeyGuideBG:SetPosY(self._ui.stc_FeedingBG:GetSizeY() - 5)
  end
end
function PaGlobal_PetList_All:initPCRoomFilterUi()
  self._ui_pc.btn_RegistPCRoom:addInputEvent("Mouse_LUp", "HandleEventLUp_PetList_RegistPCRoomPet_All()")
  self._ui_pc.btn_RegistPCRoom:addInputEvent("Mouse_On", "HandleEventMouseOn_PetList_Show_RegistPCRoomPetTooltip_All()")
  self._ui_pc.btn_RegistPCRoom:addInputEvent("Mouse_Out", "TooltipSimple_Hide()")
  local allPetButton = self._ui_pc.rdo_All
  allPetButton:addInputEvent("Mouse_LUp", "HandleEventLUp_PetList_ChangeFilter_All()")
  allPetButton:SetEnableArea(0, 0, allPetButton:GetSizeX() + allPetButton:GetTextSizeX(), allPetButton:GetSizeY())
  local normalPetButton = self._ui_pc.rdo_Normal
  normalPetButton:addInputEvent("Mouse_LUp", "HandleEventLUp_PetList_ChangeFilter_All()")
  normalPetButton:SetEnableArea(0, 0, normalPetButton:GetSizeX() + normalPetButton:GetTextSizeX(), normalPetButton:GetSizeY())
  local pcRoomPetButton = self._ui_pc.rdo_PCRoom
  pcRoomPetButton:addInputEvent("Mouse_LUp", "HandleEventLUp_PetList_ChangeFilter_All()")
  pcRoomPetButton:SetEnableArea(0, 0, pcRoomPetButton:GetSizeX() + pcRoomPetButton:GetTextSizeX(), pcRoomPetButton:GetSizeY())
  allPetButton:SetCheck(true)
  local addPosY = self._ui_pc.stc_FilterBG:GetSizeY()
  Panel_Window_PetList_All:SetSize(Panel_Window_PetList_All:GetSizeX(), self._originPanelSizeY + addPosY)
  self._ui.stc_InsideBG:SetSize(self._ui.stc_InsideBG:GetSizeX(), self._originInsideBGSizeY + addPosY)
  self._ui.list2_Pet:SetSpanSize(self._ui.list2_Pet:GetSpanSize().x, self._originPetListSpanY + addPosY)
  self._ui_pc.stc_DesBG:SetSpanSize(self._ui_pc.stc_DesBG:GetSpanSize().x, self._originDesBGSpanY + addPosY)
  self._ui_pc.stc_FindGroupBG:SetSpanSize(self._ui_pc.stc_FindGroupBG:GetSpanSize().x, self._originFindGroupBGSpanY + addPosY)
  self._ui_pc.stc_BtnGroup:SetSpanSize(self._ui_pc.stc_BtnGroup:GetSpanSize().x, self._originBtnGroupSpanY + addPosY)
  self._ui.stc_SkillInfoBG:SetSpanSize(self._ui.stc_SkillInfoBG:GetSpanSize().x, self._originSkillInfoBGSpanY + addPosY)
  self._ui_pc.btn_RegistPCRoom:SetPosY(self._originBtnRegistPCRoomSpanY + addPosY)
end
function PaGlobal_PetList_All:platformSetting()
  if nil == Panel_Window_PetList_All then
    return
  end
  for _, control in pairs(self._ui_pc) do
    if "table" ~= type(control) then
      control:SetShow(not self._isConsole)
    end
  end
  for _, control in pairs(self._ui_console) do
    if "table" ~= type(control) then
      control:SetShow(self._isConsole)
    end
  end
  if self._isConsole then
    local originSpanSize = Panel_Window_PetList_All:GetSpanSize()
    Panel_Window_PetList_All:SetSpanSize(originSpanSize.x, originSpanSize.y - 50)
    self:closePopUP()
    self._mainKeyGuides = {
      self._ui_console.stc_Bottom_KeyGuideLTA,
      self._ui_console.stc_Bottom_KeyGuideX,
      self._ui_console.stc_Bottom_KeyGuideY,
      self._ui_console.stc_Bottom_KeyGuideA,
      self._ui_console.stc_Bottom_KeyGuideB
    }
    self._feedKeyGuides = {
      self._ui_console.stc_Feeding_KeyGuideX,
      self._ui_console.stc_Feeding_KeyGuideY,
      self._ui_console.stc_Feeding_KeyGuideA,
      self._ui_console.stc_Feeding_KeyGuideB
    }
    self:updateConsoleKeyGuide(self._keyGuideAlignType.basic)
    local list2SizeY = self._ui.stc_InsideBG:GetSizeY() - 2
    self._ui.list2_Pet:SetSize(self._ui.list2_Pet:GetSizeX(), list2SizeY)
  end
  self._ui_pc.btn_Market:SetShow(false)
  self._ui_pc.chk_Popup:SetShow(false)
  self._ui_pc.stc_FilterBG:SetShow(false)
  self._ui_pc.btn_RegistPCRoom:SetShow(false)
end
function PaGlobal_PetList_All:resize()
  if nil == Panel_Window_PetList_All then
    return
  end
end
function PaGlobal_PetList_All:registEventHandler()
  if nil == Panel_Window_PetList_All then
    return
  end
  registerEvent("FromClient_PetAddSealedList", "FromClient_PetList_PetUpdate_All")
  registerEvent("FromClient_PetDelList", "FromClient_PetList_PetUpdate_All")
  registerEvent("FromClient_InputPetName", "FromClient_PetList_PetUpdate_All")
  registerEvent("FromClient_PetInfoChanged", "FromClient_PetList_PetUpdate_All")
  registerEvent("FromClient_PetDelSealedList", "FromClient_PetList_PetUpdate_All")
  registerEvent("FromClient_InventoryUpdate", "FromClient_PetList_UpdateFeedUi_All")
  registerEvent("FromClient_UpdateControlIconInfo", "PaGlobal_PetList_UpdateControlIconInfo_All")
  registerEvent("FromClient_PetSetStaticUpdate", "FromClient_PetList_PetUpdate_All")
  registerEvent("FromClient_RefreshPcRoomState", "FromClient_PetList_All_RefreshPcRoomState")
  ToClient_getPetInitLuaInfo()
  self._ui.list2_Pet:registEvent(__ePAUIList2EventType_LuaChangeContent, "PaGlobal_PetList_ListCreate_All")
  self._ui.list2_Pet:createChildContent(__ePAUIList2ElementManagerType_List)
  if self._isConsole then
    local unsealBtns = self._ui_console.rdo_Unseals
    local sealBtns = self._ui_console.rdo_Seals
    for _, control in pairs(unsealBtns) do
      control:registerPadEvent(__eConsoleUIPadEvent_DpadRight, "HandleEventDpadRight_PetList_All_PopUPBlockSnapGroupMove()")
    end
    for _, control in pairs(sealBtns) do
      control:registerPadEvent(__eConsoleUIPadEvent_DpadRight, "HandleEventDpadRight_PetList_All_PopUPBlockSnapGroupMove()")
    end
    unsealBtns.feed:addInputEvent("Mouse_On", "HandleEventMOn_PetList_All_SetKeyGuideA(0)")
    unsealBtns.order:addInputEvent("Mouse_On", "HandleEventMOn_PetList_All_SetKeyGuideA(1)")
    unsealBtns.info:addInputEvent("Mouse_On", "HandleEventMOn_PetList_All_SetKeyGuideA(2)")
    unsealBtns.seal:addInputEvent("Mouse_On", "HandleEventMOn_PetList_All_SetKeyGuideA(3)")
    sealBtns.unseal:addInputEvent("Mouse_On", "HandleEventMOn_PetList_All_SetKeyGuideA(0)")
    sealBtns.exchange:addInputEvent("Mouse_On", "HandleEventMOn_PetList_All_SetKeyGuideA(1)")
    Panel_Window_PetList_All:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandleEventPadX_PetList_All()")
    Panel_Window_PetList_All:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "HandleEventPadY_PetList_All()")
    Panel_Window_PetList_All:registerPadEvent(__eConsoleUIPadEvent_LTPress_A, "PaGlobal_PetCommand_All_Open()")
  else
    registerEvent("FromClient_PetAddSealedList", "FGlobal_PetListNew_NoPet")
    registerEvent("FromClient_PetInfoChanged", "FGlobal_PetListNew_NoPet")
    registerEvent("FromClient_PetAddList", "FGlobal_PetListNew_NoPet")
    self._ui_pc.btn_Close:addInputEvent("Mouse_LUp", "PaGlobal_PetList_Close_All()")
    self._ui_pc.btn_Exchange:addInputEvent("Mouse_LUp", "HandleEventLUp_PetList_Exchange_All()")
    self._ui_pc.btn_Exchange:addInputEvent("Mouse_On", "HandleEventMouseOn_PetList_Show_SimpleTooltip_All(true, 6)")
    self._ui_pc.btn_Exchange:addInputEvent("Mouse_Out", "HandleEventMouseOn_PetList_Show_SimpleTooltip_All(false)")
    self._ui_pc.btn_AllFeeding:addInputEvent("Mouse_LUp", "HandleEventLUp_PetList_FeedToAll_All()")
    self._ui_pc.btn_AllSeal:addInputEvent("Mouse_LUp", "HandleEventLUp_PetList_SealAllPet_All()")
    self._ui_pc.btn_AllSeal:addInputEvent("Mouse_On", "HandleEventMouseOn_PetList_Show_SimpleTooltip_All(true, 7)")
    self._ui_pc.btn_AllSeal:addInputEvent("Mouse_Out", "HandleEventMouseOn_PetList_Show_SimpleTooltip_All(false)")
    self._ui_pc.btn_AllSeal:setButtonShortcuts("PANEL_SIMPLESHORTCUT_PET_ALLGROUP")
    for i = 1, self._GroupCount do
      self._ui_pc._btn_AllSeal_Group[i]:addInputEvent("Mouse_LUp", "HandleEventLUp_PetList_GroupUnseal_All(" .. i .. ")")
      self._ui_pc._btn_AllSeal_Group[i]:addInputEvent("Mouse_On", "HandleEventMouseOn_PetList_Show_SimpleTooltip_All(true," .. i .. ")")
      self._ui_pc._btn_AllSeal_Group[i]:addInputEvent("Mouse_Out", "HandleEventMouseOn_PetList_Show_SimpleTooltip_All(false)")
      self._ui_pc._btn_AllSeal_Group[i]:setButtonShortcuts("PANEL_SIMPLESHORTCUT_PET_GROUP" .. i)
    end
    self._ui_pc.btn_ResetGroup:addInputEvent("Mouse_LUp", "HandleEventLUp_PetList_GroupClear_All()")
    self._ui_pc.btn_ResetGroup:addInputEvent("Mouse_On", "HandleEventMouseOn_PetList_Show_SimpleTooltip_All(true, 0)")
    self._ui_pc.btn_ResetGroup:addInputEvent("Mouse_Out", "HandleEventMouseOn_PetList_Show_SimpleTooltip_All(false)")
    self._ui_pc.btn_Question:addInputEvent("Mouse_LUp", "Panel_WebHelper_ShowToggle( \"Pet\" )")
    PaGlobal_Util_RegistHelpTooltipEvent(self._ui_pc.btn_Question, "\"Pet\"")
    self._ui_pc.btn_Feeding_Close:addInputEvent("Mouse_LUp", "HandleEventLUp_PetList_FeedUI_Close_All()")
  end
end
function PaGlobal_PetList_All:prepareOpen()
  if nil == Panel_Window_PetList_All then
    return
  end
  if true == _ContentsGroup_ForceShowWidgetIcon and (false == getTemporaryInformationWrapper():isPremiumPcRoom() or false == _ContentsGroup_KR_Transfer) then
    local petCount = ToClient_getPetUnsealedList() + ToClient_getPetSealedList()
    if petCount <= 0 then
      Panel_WebHelper_ShowToggle("Pet")
      return
    end
  end
  Panel_Window_PetList_All:ComputePos()
  self:showFeedUi(-1)
  if PaGlobal_PetFusion_GetShow_All() then
    PaGlobal_PetFusion_Close_All()
  end
  PaGlobal_PetList_All:updatePetList()
  PaGlobal_PetList_All:open()
end
function PaGlobal_PetList_All:open()
  if nil == Panel_Window_PetList_All then
    return
  end
  Panel_Window_PetList_All:SetShow(true)
  self._ui.list2_Pet:updateContentPos()
  self._ui.list2_Pet:moveTopIndex()
end
function PaGlobal_PetList_All:prepareClose()
  if nil == Panel_Window_PetList_All then
    return
  end
  if self._isConsole then
    if self._ui_console.stc_PopupBG:GetShow() then
      self:closePopUP()
      return
    end
    if self._ui.stc_FeedingBG:GetShow() then
      self:showFeedUi(-1)
      return
    end
    if Panel_Window_PetFusion_All:GetShow() then
      PaGlobal_PetFusion_Close_All()
      return
    end
  end
  audioPostEvent_SystemUi(1, 1)
  _AudioPostEvent_SystemUiForXBOX(1, 1)
  Panel_Window_PetList_All:CloseUISubApp()
  self._currentPetNo64 = nil
  self:showFeedUi(-1)
  self:setIgnoreAllSealBtns(false)
  self:close()
end
function PaGlobal_PetList_All:close()
  if nil == Panel_Window_PetList_All then
    return
  end
  Panel_Window_PetList_All:SetShow(false)
end
function PaGlobal_PetList_All:validate()
  if nil == Panel_Window_PetList_All then
    return
  end
  self._ui.stc_TitleBG:isValidate()
  self._ui.stc_InsideBG:isValidate()
  self._ui.stc_Line:isValidate()
  self._ui.stc_SkillInfoBG:isValidate()
  self._ui.txt_SkillListDesc:isValidate()
  self._ui.txt_BaseSkillTitle:isValidate()
  self._ui.txt_BaseSkill:isValidate()
  self._ui.txt_SkillListTitle:isValidate()
  self._ui.txt_SkillList:isValidate()
  self._ui.txt_TierSetListTitle:isValidate()
  self._ui.txt_TierSetList:isValidate()
  self._ui.list2_Pet:isValidate()
  self._ui.stc_FeedingBG:isValidate()
  self._ui.stc_FeedingTitleBG:isValidate()
  self._ui.txt_FeedingBGTitle:isValidate()
  self._ui.stc_FeedingIconSlot:isValidate()
  self._ui.stc_SelectedFeedingItemIcon:isValidate()
  self._ui_pc.chk_Popup:isValidate()
  self._ui_pc.btn_Question:isValidate()
  self._ui_pc.btn_Close:isValidate()
  self._ui_pc.stc_DesBG:isValidate()
  self._ui_pc.txt_DesL:isValidate()
  self._ui_pc.txt_DesR:isValidate()
  self._ui_pc.txt_Des:isValidate()
  self._ui_pc.stc_FindGroupBG:isValidate()
  for i = 1, self._GroupCount do
    self._ui_pc._btn_AllSeal_Group[i]:isValidate()
  end
  self._ui_pc.btn_ResetGroup:isValidate()
  self._ui_pc.stc_BtnGroup:isValidate()
  self._ui_pc.btn_Exchange:isValidate()
  self._ui_pc.btn_AllFeeding:isValidate()
  self._ui_pc.btn_AllSeal:isValidate()
  self._ui_pc.btn_Market:isValidate()
  self._ui_pc.btn_Feeding_FeedOne:isValidate()
  self._ui_pc.btn_Feeding_FeedFull:isValidate()
  self._ui_pc.btn_Feeding_Close:isValidate()
  self._ui_pc.stc_FilterBG:isValidate()
  self._ui_pc.rdo_All:isValidate()
  self._ui_pc.rdo_Normal:isValidate()
  self._ui_pc.rdo_PCRoom:isValidate()
  self._ui_pc.btn_RegistPCRoom:isValidate()
  self._ui_console.stc_Feeding_KeyGuideBG:isValidate()
  self._ui_console.stc_Feeding_KeyGuideA:isValidate()
  self._ui_console.stc_Feeding_KeyGuideX:isValidate()
  self._ui_console.stc_Feeding_KeyGuideY:isValidate()
  self._ui_console.stc_Feeding_KeyGuideB:isValidate()
  self._ui_console.stc_PopupBG:isValidate()
  self._ui_console.rdo_Unseals.feed:isValidate()
  self._ui_console.rdo_Unseals.order:isValidate()
  self._ui_console.rdo_Unseals.info:isValidate()
  self._ui_console.rdo_Unseals.seal:isValidate()
  self._ui_console.rdo_Seals.unseal:isValidate()
  self._ui_console.rdo_Seals.exchange:isValidate()
  self._ui_console.stc_Popup_KeyGuideA:isValidate()
  self._ui_console.stc_Bottom_KeyGuideBG:isValidate()
  self._ui_console.stc_Bottom_KeyGuideA:isValidate()
  self._ui_console.stc_Bottom_KeyGuideB:isValidate()
  self._ui_console.stc_Bottom_KeyGuideX:isValidate()
  self._ui_console.stc_Bottom_KeyGuideY:isValidate()
end
function PaGlobal_PetList_All:showFeedUi(targetPetIndex)
  if nil == Panel_Window_PetList_All then
    return
  end
  if self._feedingPetIndex == targetPetIndex then
    targetPetIndex = -1
  end
  self:clearSelect()
  local showFlag = 0 <= targetPetIndex
  self._ui.stc_FeedingBG:SetShow(showFlag)
  self._feedingPetIndex = targetPetIndex
  if showFlag then
    local petData = ToClient_getPetUnsealedDataByIndex(targetPetIndex)
    if not petData then
      return
    end
    local petNo = petData:getPcPetNo()
    local contents = self._ui.list2_Pet:GetContentByKey(petNo)
    local btnFeed = UI.getChildControl(contents, "Button_Feeding")
    self._ui.stc_FeedingBG:SetPosY(contents:GetPosY() + btnFeed:GetPosY())
    self._ui.stc_FeedingBG:SetPosX(contents:GetPosX() + btnFeed:GetPosX() + 50)
    self:updateFeedUi()
    local userFeedItemCount = ToClient_Pet_GetFeedItemCount()
    if 0 < userFeedItemCount then
      HandleEventLUp_PetList_FeedItem_All(0)
    end
  else
    self:updateConsoleKeyGuide(self._keyGuideAlignType.basic)
  end
end
function PaGlobal_PetList_All:showFeedAllUi(showFlag)
  if showFlag == self._ui.stc_FeedingBG:GetShow() then
    showFlag = false
  end
  local unsealPetCount = ToClient_getPetUnsealedList()
  if showFlag and 0 == unsealPetCount then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_PETLISTNEW_UNSEALALERT"))
    return
  end
  self._ui.stc_FeedingBG:SetShow(showFlag)
  self:clearSelect()
  if showFlag then
    if self._isConsole then
      self._ui.stc_FeedingBG:SetPosY(Panel_Window_PetList_All:GetSizeY() / 2 - self._ui.stc_FeedingBG:GetSizeY() / 2)
    else
      self._ui.stc_FeedingBG:SetPosX(Panel_Window_PetList_All:GetSizeX() + 10)
      self._ui.stc_FeedingBG:SetPosY(Panel_Window_PetList_All:GetSizeY() - self._ui.stc_FeedingBG:GetSizeY())
    end
    self:updateFeedUi(true)
    local userFeedItemCount = ToClient_Pet_GetFeedItemCount()
    if 0 < userFeedItemCount then
      HandleEventLUp_PetList_FeedItem_All(0)
    end
  else
    self:updateConsoleKeyGuide(self._keyGuideAlignType.basic)
  end
end
function PaGlobal_PetList_All:clearSelect()
  if nil == Panel_Window_PetList_All then
    return
  end
  self._selectItemIndex = -1
  self._ui.stc_SelectedFeedingItemIcon:SetShow(false)
end
function PaGlobal_PetList_All:updateFeedUi(isFeedToAll)
  if not self._ui.stc_FeedingBG:GetShow() then
    return
  end
  if nil == isFeedToAll then
    isFeedToAll = false
  end
  local userFeedItemCount = ToClient_Pet_GetFeedItemCount()
  self:updateUserFeedItemCount(userFeedItemCount)
  for i = 0, self._feedStaticItemCount - 1 do
    local targetSlot = UI.getChildControl(self._ui.stc_FeedingBG, "Static_IconBg" .. tostring(i))
    if i < userFeedItemCount then
      targetSlot:SetShow(true)
      local feedItem = ToClient_Pet_GetFeedItemByIndex(i)
      if not feedItem then
        return
      end
      self._feedSlot[i]:setItem(feedItem)
      if self._isConsole then
        if isFeedToAll then
          self._feedSlot[i].icon:addInputEvent("Mouse_LUp", "HandleEventLUp_PetList_UseFeedItemToAll_All()")
        else
          self._feedSlot[i].icon:addInputEvent("Mouse_LUp", "HandleEventLUp_PetList_UseFeedItem_One_All()")
        end
      else
        if isFeedToAll then
          self._feedSlot[i].icon:addInputEvent("Mouse_On", "HandleEventMouseOn_PetList_FeedItem_ShowTooltip(" .. i .. " , true )")
        else
          self._feedSlot[i].icon:addInputEvent("Mouse_On", "HandleEventMouseOn_PetList_FeedItem_ShowTooltip(" .. i .. " , false )")
        end
        self._feedSlot[i].icon:addInputEvent("Mouse_Out", "HandleEventMouseOn_PetList_FeedItem_HideTooltip()")
        self._feedSlot[i].icon:addInputEvent("Mouse_LUp", "HandleEventLUp_PetList_FeedItem_All(" .. i .. ")")
      end
    else
      targetSlot:SetShow(false)
      targetSlot:removeInputEvent("Mouse_LUp")
    end
  end
  if isFeedToAll then
    self._ui_pc.btn_Feeding_FeedOne:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_COMMON_CONFIRM"))
    self._ui_pc.btn_Feeding_FeedFull:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_COMMON_KEYGUIDE_CANCEL"))
    self._ui_pc.btn_Feeding_FeedOne:addInputEvent("Mouse_LUp", "HandleEventLUp_PetList_UseFeedItemToAll_All()")
    self._ui_pc.btn_Feeding_FeedFull:addInputEvent("Mouse_LUp", "HandleEventLUp_PetList_FeedUI_Close_All()")
    self._ui.txt_FeedingBGTitle:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_PETRESTOREALL_TITLE"))
  else
    self._ui_pc.btn_Feeding_FeedOne:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_PETLISTNEW_FEEDONEBTN"))
    self._ui_pc.btn_Feeding_FeedFull:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_PETLISTNEW_FEEDFULLBTN"))
    self._ui_pc.btn_Feeding_FeedOne:addInputEvent("Mouse_LUp", "HandleEventLUp_PetList_UseFeedItem_One_All()")
    self._ui_pc.btn_Feeding_FeedFull:addInputEvent("Mouse_LUp", "HandleEventLUp_PetList_UseFeedItem_Full_All()")
    self._ui.txt_FeedingBGTitle:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_PETLISTNEW_SELECTPETFOODTITLE"))
  end
  local minSizeX = self._ui.txt_FeedingBGTitle:GetTextSizeX() + self._ui.txt_FeedingBGTitle:GetPosX() * 2 + self._ui_pc.btn_Feeding_Close:GetSizeX()
  if 5 < userFeedItemCount then
    local targetSlot = UI.getChildControl(self._ui.stc_FeedingBG, "Static_IconBg" .. tostring(userFeedItemCount - 1))
    local sizeX = math.max(targetSlot:GetPosX() + targetSlot:GetSizeX() + 16, minSizeX)
    self._ui.stc_FeedingBG:SetSize(sizeX, self._ui.stc_FeedingBG:GetSizeY())
    self._ui.stc_FeedingTitleBG:SetSize(sizeX, self._ui.stc_FeedingTitleBG:GetSizeY())
  else
    local sizeX = math.max(255, minSizeX)
    self._ui.stc_FeedingBG:SetSize(sizeX, self._ui.stc_FeedingBG:GetSizeY())
    self._ui.stc_FeedingTitleBG:SetSize(sizeX, self._ui.stc_FeedingTitleBG:GetSizeY())
  end
  self._ui_pc.btn_Feeding_FeedOne:ComputePos()
  self._ui_pc.btn_Feeding_FeedFull:ComputePos()
  self._ui_pc.btn_Feeding_Close:ComputePos()
  if self._isConsole then
    self._ui.stc_FeedingBG:SetPosX(-self._ui.stc_FeedingBG:GetSizeX() - 10)
    self._ui_console.stc_Feeding_KeyGuideBG:SetSize(self._ui.stc_FeedingBG:GetSizeX(), self._ui_console.stc_Feeding_KeyGuideBG:GetSizeY())
    if isFeedToAll then
      self:updateConsoleKeyGuide(self._keyGuideAlignType.feedAll)
    else
      self:updateConsoleKeyGuide(self._keyGuideAlignType.feedOne)
    end
    ToClient_padSnapChangeToTarget(self._feedingFirstSlot)
  end
end
function PaGlobal_PetList_All:updateUserFeedItemCount(count)
  if not self._ui.stc_FeedingBG:GetShow() then
    return
  end
  if self._cachedUserFeedItemCount ~= count then
    self:clearSelect()
  end
  self._cachedUserFeedItemCount = count
end
function PaGlobal_PetList_All:setIgnoreAllSealBtns(value)
  if nil == Panel_Window_PetList_All then
    return
  end
  for i = 1, self._GroupCount do
    self._ui_pc._btn_AllSeal_Group[i]:SetIgnore(value)
    self._ui_pc._btn_AllSeal_Group[i]:SetMonoTone(value)
  end
  self._ui_pc.btn_ResetGroup:SetIgnore(value)
  self._ui_pc.btn_ResetGroup:SetMonoTone(value)
  self._ui_pc.btn_Exchange:SetIgnore(value)
  self._ui_pc.btn_Exchange:SetMonoTone(value)
  self._ui_pc.btn_AllFeeding:SetIgnore(value)
  self._ui_pc.btn_AllFeeding:SetMonoTone(value)
  self._ui_pc.btn_AllSeal:SetIgnore(value)
  self._ui_pc.btn_AllSeal:SetMonoTone(value)
  if value then
    self:updateConsoleKeyGuide(self._keyGuideAlignType.popup)
  else
    self:updateConsoleKeyGuide(self._keyGuideAlignType.basic)
  end
end
function PaGlobal_PetList_All:updatePetList()
  if true == ToClient_isButtonOnRegisteredPetForPcRoom() then
    self._ui_pc.btn_RegistPCRoom:SetShow(true)
    self._ui_pc.stc_FilterBG:SetShow(false)
  elseif self._isPremiumPcRoom then
    self._ui_pc.stc_FilterBG:SetShow(true)
    self._ui_pc.btn_RegistPCRoom:SetShow(false)
  end
  self:SetPetList()
end
function PaGlobal_PetList_All:SetPetList(noclearscroll)
  if nil == Panel_Window_PetList_All then
    return
  end
  local toIndex = 0
  local scrollvalue = 0
  local vscroll = self._ui.list2_Pet:GetVScroll()
  if noclearscroll then
    toIndex = self._ui.list2_Pet:getCurrenttoIndex()
    if true == vscroll:GetShow() then
      scrollvalue = vscroll:GetControlPos()
    else
      noclearscroll = false
    end
    if toIndex == self._ui.list2_Pet:getEndIndex() and 0 == self._UnSealDATACount and 4 < self._UnSealDATACount + self._SealDATACount then
      toIndex = toIndex - 1
    end
  end
  self._ui.list2_Pet:getElementManager():clearKey()
  self._UnSealDATACount = ToClient_getPetUnsealedList()
  self._SealDATACount = ToClient_getPetSealedList()
  self:skillTypeCountInit()
  self:amountPetSkillAttribute(self._UnSealDATACount)
  local petCount = self._UnSealDATACount + self._SealDATACount
  for index = 0, petCount do
    local petNo
    if 0 == index and 0 == self._UnSealDATACount then
      petNo = toInt64(0, -1)
    elseif index < self._UnSealDATACount then
      local petData = ToClient_getPetUnsealedDataByIndex(index)
      if nil ~= petData then
        if true == ToClient_isFilterOnPetForPcRoom() then
          if true == self._ui_pc.rdo_All:IsChecked() then
            petNo = petData:getPcPetNo()
          elseif true == self._ui_pc.rdo_Normal:IsChecked() then
            if false == petData:getPetStaticStatus():isOnlyPcRoom() then
              petNo = petData:getPcPetNo()
            end
          elseif true == self._ui_pc.rdo_PCRoom:IsChecked() and true == petData:getPetStaticStatus():isOnlyPcRoom() then
            petNo = petData:getPcPetNo()
          end
        elseif false == petData:getPetStaticStatus():isOnlyPcRoom() then
          petNo = petData:getPcPetNo()
        end
      end
    else
      index = index - self._UnSealDATACount
      if 0 == self._UnSealDATACount then
        index = index - 1
      end
      local petData = ToClient_getPetSealedDataByIndex(index)
      if nil ~= petData then
        if true == ToClient_isFilterOnPetForPcRoom() then
          if true == self._ui_pc.rdo_All:IsChecked() then
            petNo = petData._petNo
          elseif true == self._ui_pc.rdo_Normal:IsChecked() then
            if false == petData:getPetStaticStatus():isOnlyPcRoom() then
              petNo = petData._petNo
            end
          elseif true == self._ui_pc.rdo_PCRoom:IsChecked() and true == petData:getPetStaticStatus():isOnlyPcRoom() then
            petNo = petData._petNo
          end
        elseif false == petData:getPetStaticStatus():isOnlyPcRoom() then
          petNo = petData._petNo
        end
      end
    end
    if nil ~= petNo then
      self._ui.list2_Pet:getElementManager():pushKey(petNo)
    end
  end
  if noclearscroll then
    if 0 == self._UnSealDATACount and toIndex == self._ui.list2_Pet:getEndIndex() - 1 then
      toIndex = toIndex + 1
    end
    self._ui.list2_Pet:setCurrenttoIndex(toIndex)
    if false == self._ui.list2_Pet:IsIgnoreVerticalScroll() then
      vscroll:SetControlPos(scrollvalue)
    end
  end
  if self._isConsole and 0 >= ToClient_Pet_GetFeedItemCount() then
    self._ui.stc_FeedingBG:SetShow(false)
    self:clearSelect()
  end
end
function PaGlobal_PetList_All:skillBGClose()
  if nil == Panel_Window_PetList_All then
    return
  end
  self._ui.stc_SkillInfoBG:SetShow(false)
end
function PaGlobal_PetList_All:skillTypeCountInit()
  if nil == Panel_Window_PetList_All then
    return
  end
  for index = 0, self._maxskillTypeCount - 1 do
    self._skillInfo.plusCount[index] = 0
    self._skillInfo.skillTypeCount[index] = 0
  end
  PaGlobal_PetList_All:skillBGClose()
end
function PaGlobal_PetList_All:amountPetSkillAttribute(count)
  if nil == Panel_Window_PetList_All then
    return
  end
  if 0 == count then
    PaGlobal_PetList_All:skillBGClose()
    return
  end
  self._ui.stc_SkillInfoBG:SetShow(true)
  local baseSkillPoint = {}
  for initIndex = 1, #self._baseSkillTypeString do
    baseSkillPoint[initIndex] = 0
  end
  for index = 0, count - 1 do
    local PcPetData = ToClient_getPetUnsealedDataByIndex(index)
    if nil == PcPetData then
      return
    end
    local baseSkillIndex = PcPetData:getPetBaseSkillIndex()
    local unsealPetSkillStaticStatus = ToClient_getPetBaseSkillStaticStatus(baseSkillIndex)
    local groupNo = ToClient_getBaseSkillGroupNo(baseSkillIndex)
    local petStaticStatus = PcPetData:getPetStaticStatus()
    local petTier = petStaticStatus:getPetTier() + 1
    baseSkillPoint[groupNo] = baseSkillPoint[groupNo] + self._baseSkillMultiplePoint[groupNo] * petTier
    if 9 == groupNo then
      baseSkillPoint[groupNo + 1] = baseSkillPoint[groupNo + 1] + self._baseSkillMultiplePoint[groupNo + 1] * petTier
    elseif 12 == groupNo then
      baseSkillPoint[groupNo] = baseSkillPoint[groupNo] + 10
    end
  end
  local baseSkillString = ""
  for groupIndex = 1, #self._baseSkillTypeString do
    if 0 < baseSkillPoint[groupIndex] then
      if "" == baseSkillString then
        baseSkillString = "- " .. self._baseSkillTypeString[groupIndex] .. baseSkillPoint[groupIndex] .. self._baseSkillTypeUnit[groupIndex]
      else
        baseSkillString = baseSkillString .. [[

- ]] .. self._baseSkillTypeString[groupIndex] .. baseSkillPoint[groupIndex] .. self._baseSkillTypeUnit[groupIndex]
      end
    end
  end
  self._ui.txt_BaseSkill:SetText(baseSkillString)
  local textSizeY = self._ui.txt_BaseSkill:GetTextSizeY()
  local infoBgSizeY = self._ui.txt_BaseSkill:GetPosY() + textSizeY + 20
  local skillMaxCount = ToClient_getPetEquipSkillMax()
  for index = 0, count - 1 do
    local PcPetData = ToClient_getPetUnsealedDataByIndex(index)
    if nil == PcPetData then
      return
    end
    for skill_idx = 0, skillMaxCount - 1 do
      local skillStaticStatus = ToClient_getPetEquipSkillStaticStatus(skill_idx)
      local isLearn = PcPetData:isPetEquipSkillLearned(skill_idx)
      if true == isLearn and nil ~= skillStaticStatus then
        local skillTypeStaticWrapper = skillStaticStatus:getSkillTypeStaticStatusWrapper()
        if nil ~= skillTypeStaticWrapper then
          self:petSkillTypeCheck(skill_idx)
        end
      end
    end
  end
  local petSkillGrade = ""
  local petSkillGradeText = ""
  local hasSkill = false
  for skillTypeIndex = 0, self._maxskillTypeCount - 1 do
    if 0 < self._skillInfo.plusCount[skillTypeIndex] then
      if 12 <= skillTypeIndex and skillTypeIndex < 15 then
        petSkillGrade = PAGetString(Defines.StringSheet_GAME, "LUA_CHARACTERINFO_TEXT_POTENLEVEL")
      elseif 16 == skillTypeIndex then
        petSkillGrade = self._baseSkillTypeUnit[12]
      else
        petSkillGrade = "%"
      end
      if "" == petSkillGradeText then
        petSkillGradeText = self._skillTypeString[skillTypeIndex] .. self._skillInfo.plusCount[skillTypeIndex] .. petSkillGrade
      else
        petSkillGradeText = petSkillGradeText .. "\n" .. self._skillTypeString[skillTypeIndex] .. self._skillInfo.plusCount[skillTypeIndex] .. petSkillGrade
      end
      hasSkill = true
    end
  end
  if hasSkill then
    self._ui.txt_SkillListTitle:SetPosY(self._ui.txt_BaseSkill:GetPosY() + textSizeY + 25)
    self._ui.txt_SkillList:SetPosY(self._ui.txt_SkillListTitle:GetPosY() + 40)
    self._ui.txt_SkillList:SetText(petSkillGradeText)
    textSizeY = self._ui.txt_SkillList:GetTextSizeY()
    infoBgSizeY = self._ui.txt_SkillList:GetPosY() + textSizeY + 20
    self._ui.txt_SkillListTitle:SetShow(true)
    self._ui.txt_SkillList:SetShow(true)
  else
    self._ui.txt_SkillListTitle:SetShow(false)
    self._ui.txt_SkillList:SetShow(false)
  end
  if true == _ContentsGroup_PetSetStats then
    local tierSetString = ""
    if true == ToClient_isPetSetApplied() then
      local petSetParamMaxCount = ToClient_getPetSetMaxParamCount()
      for ii = 0, petSetParamMaxCount - 1 do
        local skillStaticStatus = ToClient_getPetSetSkill(ii)
        if nil ~= skillStaticStatus then
          local skillTypeStaticWrapper = skillStaticStatus:getSkillTypeStaticStatusWrapper()
          if nil ~= skillTypeStaticWrapper then
            if "" == tierSetString then
              tierSetString = "- " .. skillTypeStaticWrapper:getName()
            else
              tierSetString = tierSetString .. [[

- ]] .. skillTypeStaticWrapper:getName()
            end
          end
        end
      end
    end
    if "" ~= tierSetString then
      self._ui.txt_TierSetListTitle:SetPosY(self._ui.txt_SkillList:GetPosY() + textSizeY + 25)
      self._ui.txt_TierSetList:SetPosY(self._ui.txt_TierSetListTitle:GetPosY() + 40)
      self._ui.txt_TierSetList:SetText(tierSetString)
      textSizeY = self._ui.txt_TierSetList:GetTextSizeY()
      infoBgSizeY = self._ui.txt_TierSetList:GetPosY() + textSizeY + 20
      self._ui.txt_TierSetListTitle:SetShow(true)
      self._ui.txt_TierSetList:SetShow(true)
    else
      self._ui.txt_TierSetListTitle:SetShow(false)
      self._ui.txt_TierSetList:SetShow(false)
    end
  else
    self._ui.txt_TierSetListTitle:SetShow(false)
    self._ui.txt_TierSetList:SetShow(false)
  end
  self._ui.stc_SkillInfoBG:SetSize(self._ui.stc_SkillInfoBG:GetSizeX(), infoBgSizeY)
end
local maxPercentage = ToClient_MaxPetSkillRate() / 10000
local maxGrade = 5
function PaGlobal_PetList_All:petSkillTypeCheck(skillIndex)
  local skillType
  if 0 <= skillIndex and skillIndex < 3 then
    skillType = 0
    self._skillInfo.plusCount[skillType] = math.min(self._skillInfo.plusCount[skillType] + self._plusPoint[skillIndex], maxPercentage)
  elseif 3 <= skillIndex and skillIndex < 6 then
    skillType = 1
    self._skillInfo.plusCount[skillType] = math.min(self._skillInfo.plusCount[skillType] + self._plusPoint[skillIndex % 3], maxPercentage)
  elseif 6 <= skillIndex and skillIndex < 9 then
    skillType = 2
    self._skillInfo.plusCount[skillType] = math.min(self._skillInfo.plusCount[skillType] + self._plusPoint[skillIndex % 3], maxPercentage)
  elseif 12 == skillIndex then
    skillType = 3
    self._skillInfo.plusCount[skillType] = math.min(self._skillInfo.plusCount[skillType] + self._plusPoint[0], maxPercentage)
  elseif 13 == skillIndex then
    skillType = 3
    self._skillInfo.plusCount[skillType] = math.min(self._skillInfo.plusCount[skillType] + self._plusPoint[4], maxPercentage)
  elseif 14 <= skillIndex and skillIndex < 17 then
    skillType = 4
    self._skillInfo.plusCount[skillType] = math.min(self._skillInfo.plusCount[skillType] + self._plusPoint[(skillIndex + 1) % 3], maxPercentage)
  elseif 17 <= skillIndex and skillIndex < 20 then
    skillType = 5
    self._skillInfo.plusCount[skillType] = math.min(self._skillInfo.plusCount[skillType] + self._plusPoint[(skillIndex + 1) % 3], maxPercentage)
  elseif 20 <= skillIndex and skillIndex < 23 then
    skillType = 6
    self._skillInfo.plusCount[skillType] = math.min(self._skillInfo.plusCount[skillType] + self._plusPoint[(skillIndex + 1) % 3], maxPercentage)
  elseif 23 <= skillIndex and skillIndex < 26 then
    skillType = 7
    self._skillInfo.plusCount[skillType] = math.min(self._skillInfo.plusCount[skillType] + self._plusPoint[(skillIndex + 1) % 3], maxPercentage)
  elseif 26 <= skillIndex and skillIndex < 29 then
    skillType = 8
    self._skillInfo.plusCount[skillType] = math.min(self._skillInfo.plusCount[skillType] + self._plusPoint[(skillIndex + 1) % 3], maxPercentage)
  elseif 29 <= skillIndex and skillIndex < 32 then
    skillType = 9
    self._skillInfo.plusCount[skillType] = math.min(self._skillInfo.plusCount[skillType] + self._plusPoint[(skillIndex + 1) % 3], maxPercentage)
  elseif 32 <= skillIndex and skillIndex < 35 then
    skillType = 10
    self._skillInfo.plusCount[skillType] = math.min(self._skillInfo.plusCount[skillType] + self._plusPoint[(skillIndex + 1) % 3], maxPercentage)
  elseif 35 <= skillIndex and skillIndex < 38 then
    skillType = 11
    self._skillInfo.plusCount[skillType] = math.min(self._skillInfo.plusCount[skillType] + self._plusPoint[(skillIndex + 1) % 3], maxPercentage)
  elseif 9 == skillIndex then
    skillType = 12
    self._skillInfo.plusCount[skillType] = math.min(self._skillInfo.plusCount[skillType] + 1, maxGrade)
  elseif 10 == skillIndex then
    skillType = 13
    self._skillInfo.plusCount[skillType] = math.min(self._skillInfo.plusCount[skillType] + 1, maxGrade)
  elseif 11 == skillIndex then
    skillType = 14
    self._skillInfo.plusCount[skillType] = math.min(self._skillInfo.plusCount[skillType] + 1, maxGrade)
  elseif 38 == skillIndex then
    skillType = 15
    self._skillInfo.plusCount[skillType] = math.min(self._skillInfo.plusCount[skillType] + self._plusPoint[skillIndex % 3], maxPercentage)
  elseif 39 == skillIndex then
    skillType = 16
    self._skillInfo.plusCount[skillType] = self._skillInfo.plusCount[skillType] + 50
  elseif 40 == skillIndex then
    skillType = 17
    self._skillInfo.plusCount[skillType] = math.min(self._skillInfo.plusCount[skillType] + self._plusPoint[skillIndex % 3], maxPercentage)
  elseif 41 == skillIndex then
    skillType = 18
    self._skillInfo.plusCount[skillType] = math.min(self._skillInfo.plusCount[skillType] + self._plusPoint[skillIndex % 3], maxPercentage)
  elseif 42 == skillIndex then
    skillType = 19
    self._skillInfo.plusCount[skillType] = math.min(self._skillInfo.plusCount[skillType] + self._plusPoint[5], maxPercentage)
    skillType = 20
    self._skillInfo.plusCount[skillType] = math.min(self._skillInfo.plusCount[skillType] + self._plusPoint[4], maxPercentage)
  end
  self._skillInfo.skillTypeCount[skillType] = self._skillInfo.skillTypeCount[skillType] + 1
  return skillType
end
function PaGlobal_PetList_All:initUnsealPetOrderInfo(petNo64)
  for index = 0, ToClient_getPetUnsealedList() - 1 do
    local pcPetData = ToClient_getPetUnsealedDataByIndex(index)
    if nil ~= pcPetData and petNo64 == tostring(pcPetData:getPcPetNo()) then
      if nil ~= pcPetData:getSkillParam(1) then
        local isCheckTalent = pcPetData:getSkillParam(1):isPassiveSkill()
        self._petOrderList._find[tostring(petNo64)] = isCheckTalent
      else
        self._petOrderList._find[tostring(petNo64)] = false
      end
      self._petOrderList._follow[tostring(petNo64)] = true
      self._petOrderList._getItem[tostring(petNo64)] = true
    end
  end
end
function PaGlobal_PetList_All:initSealPetOrderInfo(petNo64)
  for index = 0, ToClient_getPetSealedList() - 1 do
    local pcPetData = ToClient_getPetSealedDataByIndex(index)
    if nil ~= pcPetData and petNo64 == pcPetData._petNo then
      if nil ~= pcPetData:getSkillParam(1) then
        local isCheckTalent = pcPetData:getSkillParam(1):isPassiveSkill()
        self._petOrderList._find[tostring(petNo64)] = isCheckTalent
      else
        self._petOrderList._find[tostring(petNo64)] = false
      end
      self._petOrderList._follow[tostring(petNo64)] = true
      self._petOrderList._getItem[tostring(petNo64)] = true
    end
  end
end
function PaGlobal_PetList_All:isCheckGroupBtnByPetNo(petNo_s64, groupIndex)
  local isCheck = self._checkUnSealGroupList[groupIndex][Int64toInt32(petNo_s64)]
  if nil == isCheck then
    isCheck = false
  end
  return isCheck
end
function PaGlobal_PetList_All:sealAllPet(noMessageShow, groupIndex)
  if PaGlobal_PetFusion_GetShow_All() then
    return
  end
  local sealCount = 0
  for index = 0, self._maxUnsealCount - 1 do
    local PetUnSealData = ToClient_getPetUnsealedDataByIndex(index)
    if nil ~= PetUnSealData then
      local unsealPetNo_s64 = PetUnSealData:getPcPetNo()
      if nil == groupIndex then
        if nil ~= unsealPetNo_s64 then
          PaGlobal_PetList_All:sealPet(tostring(unsealPetNo_s64), index)
          sealCount = sealCount + 1
        end
      elseif true ~= self._checkUnSealGroupList[groupIndex][Int64toInt32(unsealPetNo_s64)] then
        PaGlobal_PetList_All:sealPet(tostring(unsealPetNo_s64), index)
        sealCount = sealCount + 1
      end
    end
  end
  if true ~= noMessageShow and 0 ~= sealCount then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_PETCONTROL_ALLUNSEAL"))
  end
  if self._isConsole then
    if 0 < sealCount then
      self._ui.list2_Pet:moveTopIndex()
    end
  else
    self._ui.list2_Pet:moveTopIndex()
  end
  self:showFeedUi(-1)
end
function PaGlobal_PetList_All:sealPet(petNoStr, index)
  audioPostEvent_SystemUi(1, 40)
  _AudioPostEvent_SystemUiForXBOX(1, 40)
  local petNo_s64 = tonumber64(petNoStr)
  self:showFeedUi(-1)
  TooltipSimple_Hide()
  ToClient_requestPetSeal(petNo_s64)
end
function PaGlobal_PetList_All:orderPet(orderType, index)
  local petCount = ToClient_getPetUnsealedList()
  if petCount == 0 then
    return
  end
  local value
  local petNo = ToClient_getPetUnsealedDataByIndex(index):getPcPetNo()
  if 0 == orderType then
    value = not self._petOrderList._follow[tostring(petNo)]
    if value then
      ToClient_callHandlerToPetNo("handlePetFollowMaster", petNo)
    else
      ToClient_callHandlerToPetNo("handlePetWaitMaster", petNo)
    end
    self._petOrderList._follow[tostring(petNo)] = value
  elseif 1 == orderType then
    TooltipSimple_Hide()
    value = not self._petOrderList._find[tostring(petNo)]
    if value then
      ToClient_callHandlerToPetNo("handlePetFindThatOn", petNo)
    else
      ToClient_callHandlerToPetNo("handlePetFindThatOff", petNo)
    end
    self._petOrderList._find[tostring(petNo)] = value
  elseif 2 == orderType then
    TooltipSimple_Hide()
    value = not self._petOrderList._getItem[tostring(petNo)]
    if value then
      ToClient_callHandlerToPetNo("handlePetGetItemOn", petNo)
    else
      ToClient_callHandlerToPetNo("handlePetGetItemOff", petNo)
    end
    self._petOrderList._getItem[tostring(petNo)] = value
  end
  self._ui.list2_Pet:requestUpdateByKey(petNo)
end
function PaGlobal_PetList_All:simpleTooltip(tipType)
  local name, desc, control
  if 0 == tipType then
    name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WINDOW_PETLISTNEW_ALLCLEARSET")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_PETLISTNEW_ALLCLEAR_UNSET")
    control = self._ui_pc.btn_ResetGroup
  elseif 1 == tipType then
    name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WINDOW_PETLISTNEW_ALLSEAL")
    desc = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_PETLIST_ALLSEAL_MAX4_DESC", "count", self._maxUnsealCount) .. [[


]] .. PAGetString(Defines.StringSheet_GAME, "LUA_SHORTBUTTON_HOWTOUSE_TOOLTIP_DESC")
    control = self._ui_pc._btn_AllSeal_Group[1]
  elseif 2 == tipType then
    name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WINDOW_PETLISTNEW_ALLSEAL")
    desc = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_PETLIST_ALLSEAL_GROUP_SEAL2", "count", self._maxUnsealCount) .. [[


]] .. PAGetString(Defines.StringSheet_GAME, "LUA_SHORTBUTTON_HOWTOUSE_TOOLTIP_DESC")
    control = self._ui_pc._btn_AllSeal_Group[2]
  elseif 3 == tipType then
    name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WINDOW_PETLISTNEW_ALLSEAL")
    desc = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_PETLIST_ALLSEAL_GROUP_SEAL3", "count", self._maxUnsealCount) .. [[


]] .. PAGetString(Defines.StringSheet_GAME, "LUA_SHORTBUTTON_HOWTOUSE_TOOLTIP_DESC")
    control = self._ui_pc._btn_AllSeal_Group[3]
  elseif 4 == tipType then
    name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WINDOW_PETLISTNEW_ALLSEAL")
    desc = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_PETLIST_ALLSEAL_GROUP_SEAL4", "count", self._maxUnsealCount) .. [[


]] .. PAGetString(Defines.StringSheet_GAME, "LUA_SHORTBUTTON_HOWTOUSE_TOOLTIP_DESC")
    control = self._ui_pc._btn_AllSeal_Group[4]
  elseif 5 == tipType then
    name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WINDOW_PETLISTNEW_ALLSEAL")
    desc = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_PETLIST_ALLSEAL_GROUP_SEAL5", "count", self._maxUnsealCount) .. [[


]] .. PAGetString(Defines.StringSheet_GAME, "LUA_SHORTBUTTON_HOWTOUSE_TOOLTIP_DESC")
    control = self._ui_pc._btn_AllSeal_Group[5]
  elseif 6 == tipType then
    name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WINDOW_PETLISTNEW_COMPOSE")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_PETLIST_TOOLTIP_BTN_FUSION_DESC")
    control = self._ui_pc.btn_Exchange
  elseif 7 == tipType then
    name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_PETCONTROL_BTN_ALLSEAL")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_PETLIST_TOOLTIP_BTN_ALLSEAL_DESC") .. "\n" .. PAGetString(Defines.StringSheet_GAME, "LUA_SHORTBUTTON_HOWTOUSE_TOOLTIP_DESC")
    control = self._ui_pc.btn_AllSeal
  end
  TooltipSimple_Show(control, name, desc)
end
function PaGlobal_PetList_All:orderTooltip(orderType, index)
  local pcPetData = ToClient_getPetUnsealedDataByIndex(index)
  if nil == pcPetData then
    return
  end
  local key = pcPetData:getPcPetNo()
  local control = self._ui.list2_Pet
  local contents = control:GetContentByKey(key)
  local orderFollow = UI.getChildControl(contents, "CheckButton_Follow")
  local orderWait = UI.getChildControl(contents, "CheckButton_Wait")
  local orderFind = UI.getChildControl(contents, "CheckButton_Find")
  local orderGetItem = UI.getChildControl(contents, "CheckButton_GetItem")
  local orderPlay = UI.getChildControl(contents, "CheckButton_Play")
  local hungryProgress = UI.getChildControl(contents, "Template_Static_Progress_Hungry")
  local hungryPercentText = UI.getChildControl(contents, "StaticText_HungryPercent")
  local hungryIcon = UI.getChildControl(contents, "Template_Static_HungryIcon")
  local btnInfo = UI.getChildControl(contents, "Template_Button_Info")
  local btnSeal = UI.getChildControl(contents, "Template_Button_Seal")
  local btnFusion = UI.getChildControl(contents, "Template_Button_Fusion")
  local btnFeed = UI.getChildControl(contents, "Button_Feeding")
  local uiControl, name, desc
  if 0 == orderType then
    uiControl = orderFollow
    name = PAGetString(Defines.StringSheet_GAME, "LUA_PETCONTROL_TOOLTIP_FOLLOW_NAME")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_PETCONTROL_TOOLTIP_FOLLOW_DESC")
  elseif 1 == orderType then
    uiControl = orderWait
    name = PAGetString(Defines.StringSheet_GAME, "LUA_PETCONTROL_TOOLTIP_WAIT_NAME")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_PETCONTROL_TOOLTIP_WAIT_DESC")
  elseif 2 == orderType then
    uiControl = orderGetItem
    name = PAGetString(Defines.StringSheet_GAME, "LUA_PETCONTROL_TOOLTIP_FIND_NAME")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_PETCONTROL_TOOLTIP_FIND_DESC")
  elseif 3 == orderType then
    uiControl = orderFind
    name = PAGetString(Defines.StringSheet_GAME, "LUA_PETCONTROL_TOOLTIP_GETITEM_NAME")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_PETCONTROL_TOOLTIP_GETITEM_DESC")
  elseif 4 == orderType then
    local petLootingType = pcPetData:getPetLootingType()
    local lootingTypeString = ""
    if 0 == petLootingType then
      lootingTypeString = PAGetString(Defines.StringSheet_GAME, "LUA_IPETCONTROL_TOOLTIP_LOOTINGTYPE_0")
    elseif 1 == petLootingType then
      lootingTypeString = PAGetString(Defines.StringSheet_GAME, "LUA_IPETCONTROL_TOOLTIP_LOOTINGTYPE_1")
    elseif 2 == petLootingType then
      lootingTypeString = PAGetString(Defines.StringSheet_GAME, "LUA_IPETCONTROL_TOOLTIP_LOOTINGTYPE_2")
    end
    uiControl = orderPlay
    name = PAGetString(Defines.StringSheet_GAME, "LUA_PETCONTROL_TOOLTIP_PLAY_NAME") .. lootingTypeString
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_PETCONTROL_TOOLTIP_PLAY_DESC")
  elseif 5 == orderType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_PETLIST_TOOLTIP_BTN_HUNGRY_NAME")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_PETLIST_TOOLTIP_BTN_HUNGRY_DESC")
    uiControl = hungryProgress
  elseif 6 == orderType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_PETLIST_TOOLTIP_BTN_HUNGRY_NAME")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_PETLIST_TOOLTIP_BTN_HUNGRY_DESC")
    uiControl = hungryPercentText
  elseif 7 == orderType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_PETLIST_TOOLTIP_BTN_HUNGRY_NAME")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_PETLIST_TOOLTIP_BTN_HUNGRY_DESC")
    uiControl = hungryIcon
  elseif 8 == orderType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_PETLIST_TOOLTIP_BTN_INFO_NAME")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_PETLIST_TOOLTIP_BTN_INFO_DESC")
    uiControl = btnInfo
  elseif 9 == orderType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_PETLIST_TOOLTIP_BTN_SEAL_NAME")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_PETLIST_TOOLTIP_BTN_SEAL_DESC")
    uiControl = btnSeal
  elseif 10 == orderType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_PETLIST_TOOLTIP_BTN_FUSION_NAME")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_PETLIST_TOOLTIP_BTN_FUSION_DESC")
    uiControl = btnFusion
  elseif 11 == orderType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_PETLIST_TOOLTIP_BTN_FEED_NAME")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_PETLIST_TOOLTIP_BTN_FEED_DESC")
    uiControl = btnFeed
  end
  TooltipSimple_Show(uiControl, name, desc)
end
function PaGlobal_PetList_All:nameTooltip(isShow, index, isSealed)
  local name, desc, control, pcPetData, key
  if isSealed then
    pcPetData = ToClient_getPetUnsealedDataByIndex(index)
    key = pcPetData:getPcPetNo()
  else
    pcPetData = ToClient_getPetSealedDataByIndex(index)
    key = pcPetData._petNo
  end
  local petName = pcPetData:getName()
  local contents = self._ui.list2_Pet:GetContentByKey(key)
  local nameControl = UI.getChildControl(contents, "Template_StaticText_PetName")
  name = petName
  control = nameControl
  TooltipSimple_Show(control, name, desc)
end
function PaGlobal_PetList_All:simpleTooltipBTN(index, tipType)
  local name, desc, control
  local pcPetData = ToClient_getPetSealedDataByIndex(index)
  if nil == pcPetData then
    return
  end
  local key = pcPetData._petNo
  local contents = self._ui.list2_Pet:GetContentByKey(key)
  local btn_Unseal = UI.getChildControl(contents, "Template_Button_Unseal")
  local hungryProgress = UI.getChildControl(contents, "Template_Static_Progress_Hungry")
  local hungryPercentText = UI.getChildControl(contents, "StaticText_HungryPercent")
  local hungryIcon = UI.getChildControl(contents, "Template_Static_HungryIcon")
  local btnUp = UI.getChildControl(contents, "Button_Up")
  local btnDown = UI.getChildControl(contents, "Button_Down")
  local groupIndexBtn1 = UI.getChildControl(contents, "Template_Button_GroupIndex1")
  local groupIndexBtn2 = UI.getChildControl(contents, "Template_Button_GroupIndex2")
  local groupIndexBtn3 = UI.getChildControl(contents, "Template_Button_GroupIndex3")
  local groupIndexBtn4 = UI.getChildControl(contents, "Template_Button_GroupIndex4")
  local groupIndexBtn5 = UI.getChildControl(contents, "Template_Button_GroupIndex5")
  local btnFusion = UI.getChildControl(contents, "Template_Button_Fusion")
  if 0 == tipType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_PETLIST_TOOLTIP_BTN_UNSEAL_NAME")
    desc = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_PETLIST_TOOLTIP_BTN_UNSEAL_DESC", "count", self._maxUnsealCount)
    control = btn_Unseal
  elseif 1 == tipType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_PETLIST_TOOLTIP_BTN_HUNGRY_NAME")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_PETLIST_TOOLTIP_BTN_HUNGRY_DESC")
    control = hungryProgress
  elseif 2 == tipType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_PETLIST_TOOLTIP_BTN_HUNGRY_NAME")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_PETLIST_TOOLTIP_BTN_HUNGRY_DESC")
    control = hungryPercentText
  elseif 3 == tipType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_PETLIST_TOOLTIP_BTN_HUNGRY_NAME")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_PETLIST_TOOLTIP_BTN_HUNGRY_DESC")
    control = hungryIcon
  elseif 4 == tipType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_PETLIST_TOOLTIP_BTN_CHANGEORDER_UP_NAME")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_PETLIST_TOOLTIP_BTN_CHANGEORDER_UP_DESC")
    control = btnUp
  elseif 5 == tipType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_PETLIST_TOOLTIP_BTN_CHANGEORDER_DOWN_NAME")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_PETLIST_TOOLTIP_BTN_CHANGEORDER_DOWN_DESC")
    control = btnDown
  elseif 6 == tipType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_PETLIST_TOOLTIP_BTN_GROUP1_NAME")
    desc = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_PETLIST_TOOLTIP_BTN_GROUP1_DESC", "count", self._maxUnsealCount)
    control = groupIndexBtn1
  elseif 7 == tipType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_PETLIST_TOOLTIP_BTN_GROUP2_NAME")
    desc = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_PETLIST_TOOLTIP_BTN_GROUP2_DESC", "count", self._maxUnsealCount)
    control = groupIndexBtn2
  elseif 8 == tipType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_PETLIST_TOOLTIP_BTN_GROUP3_NAME")
    desc = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_PETLIST_TOOLTIP_BTN_GROUP3_DESC", "count", self._maxUnsealCount)
    control = groupIndexBtn3
  elseif 9 == tipType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_PETLIST_TOOLTIP_BTN_GROUP4_NAME")
    desc = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_PETLIST_TOOLTIP_BTN_GROUP4_DESC", "count", self._maxUnsealCount)
    control = groupIndexBtn4
  elseif 10 == tipType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_PETLIST_TOOLTIP_BTN_GROUP5_NAME")
    desc = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_PETLIST_TOOLTIP_BTN_GROUP5_DESC", "count", self._maxUnsealCount)
    control = groupIndexBtn5
  elseif 11 == tipType then
    name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WINDOW_PETLISTNEW_COMPOSE")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_PETLIST_TOOLTIP_BTN_FUSION_DESC")
    control = btnFusion
  end
  TooltipSimple_Show(control, name, desc)
end
function PaGlobal_PetList_All:unsealPet(petNoStr, isGroup)
  audioPostEvent_SystemUi(1, 40)
  _AudioPostEvent_SystemUiForXBOX(1, 40)
  local petNo_s64 = tonumber64(petNoStr)
  if self._maxUnsealCount <= self._UnSealDATACount and false == isGroup then
    Proc_ShowMessage_Ack_WithOut_ChattingMessage(PAGetString(Defines.StringSheet_GAME, "LUA_UNABLE_SUMMON_PET"))
    return
  end
  ToClient_requestPetUnseal(petNo_s64)
  self:showFeedUi(-1)
end
function PaGlobal_PetList_All:unsealPetGroup(groupIndex)
  PaGlobal_PetList_All:sealAllPet(true, groupIndex)
  local sealPetCount = ToClient_getPetSealedList()
  for i = 1, self._GroupCount do
    if groupIndex ~= i then
      local baseTexture = self._ui_pc._btn_AllSeal_Group[i]:getBaseTexture()
      self._ui_pc._btn_AllSeal_Group[i]:setRenderTexture(baseTexture)
    end
  end
  if 0 == sealPetCount then
    return
  end
  for petIndex = 0, sealPetCount - 1 do
    local isDuplication = false
    local petData = ToClient_getPetSealedDataByIndex(petIndex)
    local petNo_s64 = petData._petNo
    if self._checkUnSealGroupList[groupIndex][Int64toInt32(petNo_s64)] then
      for index = 0, self._maxUnsealCount - 1 do
        local unSealPetInfo = ToClient_getPetUnsealedList()
        local PetUnSealData = ToClient_getPetUnsealedDataByIndex(index)
        if nil ~= PetUnSealData then
          local unsealPetNo_s64 = PetUnSealData:getPcPetNo()
          if petNo_s64 == unsealPetNo_s64 then
            isDuplication = true
          end
        end
      end
      if false == isDuplication then
        Proc_ShowMessage_Ack(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_PETLIST_GROUPPET_SEAL", "index", groupIndex))
        self:unsealPet(tostring(petNo_s64), true)
      end
    end
  end
end
function PaGlobal_PetList_All:fusionButtonShowCheck(petNo_s64, petTier, petRace)
  if false == PaGlobal_PetFusion_GetShow_All() then
    return false
  end
  if true == PaGlobal_PetFusion_IsExist_All(petNo_s64) then
    return false
  end
  if false == PaGlobal_PetList_CheckFusionButtonPcRoomPet_All(petNo_s64) then
    return false
  end
  return true
end
function PaGlobal_PetList_All:unFusionButtonCheck(petNo_s64)
  if true == PaGlobal_PetFusion_IsExist_All(petNo_s64) then
    return true
  end
  return false
end
function PaGlobal_PetList_All:fusionButtonMonoToneCheck(petNo_s64, petTier, petRace)
  if false == PaGlobal_PetFusion_GetShow_All() then
    return false
  end
  if 100 <= PaGlobal_PetFusion_GetRate_All() then
    return true
  end
  if false == PaGlobal_PetFusion_IsMainPetSet_All() and 99 == petRace then
    return true
  end
  if 99 ~= petRace and false == PaGlobal_PetFusion_SetAbleByGrade_All(petNo_s64) then
    return true
  end
  if false == PaGlobal_PetFusion_SetAbleByTier_All(petTier) then
    return true
  end
  if true == PaGlobal_PetFusion_IsMainPetSet_All() and 99 == petRace and false == PaGlobal_PetFusion_GetIsJokerPetUse_All() then
    return true
  end
  if false == PaGlobal_PetList_CheckFusionButtonPcRoomPet_All(petNo_s64) then
    return true
  end
  return false
end
function PaGlobal_PetList_All:closePopUP()
  self._ui_console.stc_PopupBG:SetShow(false)
end
function PaGlobal_PetList_All:showPopUP(isUnseal, index)
  if isPadPressed(__eJoyPadInputType_LeftTrigger) then
    return
  end
  local pcPetData, key
  if isUnseal then
    pcPetData = ToClient_getPetUnsealedDataByIndex(index)
    key = pcPetData:getPcPetNo()
  else
    pcPetData = ToClient_getPetSealedDataByIndex(index)
    key = pcPetData._petNo
  end
  local selectedContents = self._ui.list2_Pet:GetContentByKey(key)
  if nil == selectedContents then
    return
  end
  local bgPosY = selectedContents:GetPosY() + self._ui.list2_Pet:GetPosY()
  if bgPosY < self._ui.list2_Pet:GetPosY() or bgPosY > self._ui.list2_Pet:GetPosY() + self._ui.list2_Pet:GetSizeY() then
    return
  end
  self._ui_console.stc_PopupBG:SetPosY(bgPosY)
  self._ui_console.stc_PopupBG:SetShow(true)
  self:updatePopUP(isUnseal, index, pcPetData)
  ToClient_padSnapResetControl()
  ToClient_padSnapSetTargetGroup(self._ui_console.stc_PopupBG)
  ToClient_padSnapIgnoreGroupMove()
end
function PaGlobal_PetList_All:updatePopUP(isUnseal, index, pcPetData)
  local unsealBtns = self._ui_console.rdo_Unseals
  local sealBtns = self._ui_console.rdo_Seals
  for _, control in pairs(unsealBtns) do
    control:SetShow(isUnseal)
  end
  for _, control in pairs(sealBtns) do
    control:SetShow(not isUnseal)
  end
  if isUnseal then
    local endPosY = unsealBtns.seal:GetPosY() + unsealBtns.seal:GetSizeY()
    self._ui_console.stc_PopupBG:SetSize(self._ui_console.stc_PopupBG:GetSizeX(), endPosY)
    local petNo_s64 = pcPetData:getPcPetNo()
    unsealBtns.feed:addInputEvent("Mouse_LUp", "HandleEventLUp_PetList_FeedUI_Show_All(" .. index .. ")")
    unsealBtns.order:addInputEvent("Mouse_LUp", "PaGlobal_PetCommand_All_Open(" .. index .. ")")
    unsealBtns.info:addInputEvent("Mouse_LUp", "HandleEventLUp_PetInfo_Open_All( \"" .. tostring(petNo_s64) .. "\" )")
    unsealBtns.seal:addInputEvent("Mouse_LUp", "HandleEventLUp_PetList_Seal_All( \"" .. tostring(petNo_s64) .. "\")")
  else
    local endPosY = sealBtns.exchange:GetPosY() + sealBtns.exchange:GetSizeY()
    self._ui_console.stc_PopupBG:SetSize(self._ui_console.stc_PopupBG:GetSizeX(), endPosY)
    local petNo_s64 = pcPetData._petNo
    sealBtns.unseal:addInputEvent("Mouse_LUp", "HandleEventLUp_PetList_Unseal_All( \"" .. tostring(petNo_s64) .. "\" , false )")
    sealBtns.exchange:addInputEvent("Mouse_LUp", "HandleEventLUp_PetList_All_ExchangeOpen_ForConsole(" .. index .. ")")
  end
end
function PaGlobal_PetList_All:updateConsoleKeyGuide(keyGuideAlignType)
  if false == self._isConsole then
    return
  end
  self._ui_console.stc_Bottom_KeyGuideLTA:SetShow(false)
  self._ui_console.stc_Bottom_KeyGuideX:SetShow(false)
  self._ui_console.stc_Bottom_KeyGuideY:SetShow(false)
  self._ui_console.stc_Bottom_KeyGuideA:SetShow(false)
  self._ui_console.stc_Bottom_KeyGuideB:SetShow(false)
  self._ui_console.stc_Feeding_KeyGuideX:SetShow(false)
  self._ui_console.stc_Feeding_KeyGuideY:SetShow(false)
  self._ui_console.stc_Feeding_KeyGuideA:SetShow(false)
  self._ui_console.stc_Feeding_KeyGuideB:SetShow(false)
  self._ui_console.stc_Bottom_KeyGuideBG:SetShow(false)
  self._ui_console.stc_Feeding_KeyGuideBG:SetShow(false)
  if self._keyGuideAlignType.none == keyGuideAlignType then
    return
  elseif self._keyGuideAlignType.basic == keyGuideAlignType then
    self._ui_console.stc_Bottom_KeyGuideBG:SetShow(true)
    self._ui_console.stc_Bottom_KeyGuideLTA:SetShow(true)
    self._ui_console.stc_Bottom_KeyGuideX:SetShow(true)
    self._ui_console.stc_Bottom_KeyGuideY:SetShow(true)
    self._ui_console.stc_Bottom_KeyGuideA:SetShow(true)
    self._ui_console.stc_Bottom_KeyGuideB:SetShow(true)
  elseif self._keyGuideAlignType.popup == keyGuideAlignType then
    self._ui_console.stc_Bottom_KeyGuideBG:SetShow(true)
    self._ui_console.stc_Bottom_KeyGuideA:SetShow(true)
    self._ui_console.stc_Bottom_KeyGuideB:SetShow(true)
  elseif self._keyGuideAlignType.feedOne == keyGuideAlignType then
    self._ui_console.stc_Feeding_KeyGuideBG:SetShow(true)
    self._ui_console.stc_Feeding_KeyGuideA:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_PETLISTNEW_FEEDONEBTN"))
    self._ui_console.stc_Feeding_KeyGuideX:SetShow(true)
    self._ui_console.stc_Feeding_KeyGuideY:SetShow(true)
    self._ui_console.stc_Feeding_KeyGuideA:SetShow(true)
    self._ui_console.stc_Feeding_KeyGuideB:SetShow(true)
  elseif self._keyGuideAlignType.feedAll == keyGuideAlignType then
    self._ui_console.stc_Feeding_KeyGuideBG:SetShow(true)
    self._ui_console.stc_Feeding_KeyGuideA:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_PETRESTOREALL_TITLE"))
    self._ui_console.stc_Feeding_KeyGuideX:SetShow(true)
    self._ui_console.stc_Feeding_KeyGuideA:SetShow(true)
    self._ui_console.stc_Feeding_KeyGuideB:SetShow(true)
  end
  PaGlobalFunc_ConsoleKeyGuide_SetAlign(self._mainKeyGuides, self._ui_console.stc_Bottom_KeyGuideBG, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_AUTO_WRAP_LEFT)
  self._ui_console.stc_Bottom_KeyGuideBG:SetSize(self._ui_console.stc_Bottom_KeyGuideBG:GetSizeX(), self._ui_console.stc_Bottom_KeyGuideB:GetPosY() + self._ui_console.stc_Bottom_KeyGuideB:GetSizeY() + 10)
  PaGlobalFunc_ConsoleKeyGuide_SetAlign(self._feedKeyGuides, self._ui_console.stc_Feeding_KeyGuideBG, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_AUTO_WRAP_LEFT)
  self._ui_console.stc_Feeding_KeyGuideBG:SetSize(self._ui_console.stc_Feeding_KeyGuideBG:GetSizeX(), self._ui_console.stc_Feeding_KeyGuideB:GetPosY() + self._ui_console.stc_Feeding_KeyGuideB:GetSizeY() + 10)
end
function PaGlobal_PetList_All:UpdateUIByChangedPcRoomState(isPcRoom)
  if true == isPcRoom then
    self._isPremiumPcRoom = true
    self._maxUnsealCount = ToClient_getPetUseMaxCount() + ToClient_getPetUseMaxCountPcRoom()
    self:initPCRoomFilterUi()
  else
    self._isPremiumPcRoom = false
    self._maxUnsealCount = ToClient_getPetUseMaxCount()
    Panel_Window_PetList_All:SetSize(Panel_Window_PetList_All:GetSizeX(), self._originPanelSizeY)
    self._ui.stc_InsideBG:SetSize(self._ui.stc_InsideBG:GetSizeX(), self._originInsideBGSizeY)
    self._ui.list2_Pet:SetSpanSize(self._ui.list2_Pet:GetSpanSize().x, self._originPetListSpanY)
    self._ui_pc.stc_DesBG:SetSpanSize(self._ui_pc.stc_DesBG:GetSpanSize().x, self._originDesBGSpanY)
    self._ui_pc.stc_FindGroupBG:SetSpanSize(self._ui_pc.stc_FindGroupBG:GetSpanSize().x, self._originFindGroupBGSpanY)
    self._ui_pc.stc_BtnGroup:SetSpanSize(self._ui_pc.stc_BtnGroup:GetSpanSize().x, self._originBtnGroupSpanY)
    self._ui.stc_SkillInfoBG:SetSpanSize(self._ui.stc_SkillInfoBG:GetSpanSize().x, self._originSkillInfoBGSpanY)
    self._ui_pc.btn_RegistPCRoom:SetPosY(self._originBtnRegistPCRoomSpanY)
  end
  self:updatePetList()
end
