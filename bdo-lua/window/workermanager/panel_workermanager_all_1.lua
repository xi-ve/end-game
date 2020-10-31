function PaGlobal_WorkerManager_All:initialize()
  if true == PaGlobal_WorkerManager_All._initialize then
    return
  end
  PaGlobal_WorkerManager_All._isConsole = _ContentsGroup_RenewUI
  PaGlobal_WorkerManager_All._isPadSnap = _ContentsGroup_UsePadSnapping
  PaGlobal_WorkerManager_All:ControlAll_Init()
  PaGlobal_WorkerManager_All:ControlPc_Init()
  PaGlobal_WorkerManager_All:ControlConsole_Init()
  PaGlobal_WorkerManager_All:ControlSetShow()
  PaGlobal_WorkerManager_All:registEventHandler()
  PaGlobal_WorkerManager_All:validate()
  PaGlobal_WorkerManager_All._initialize = true
end
function PaGlobal_WorkerManager_All:ControlAll_Init()
  if nil == Panel_Window_WorkerManager_All then
    return
  end
  self._ui.stc_titleBg = UI.getChildControl(Panel_Window_WorkerManager_All, "Title_BG")
  self._ui.txt_title = UI.getChildControl(self._ui.stc_titleBg, "StaticText_TitleIcon")
  self._ui.stc_radioBg = UI.getChildControl(Panel_Window_WorkerManager_All, "Static_RadioButtons")
  self._ui.radio_worker = UI.getChildControl(self._ui.stc_radioBg, "RadioButton_WorkerList")
  self._ui.radio_advence = UI.getChildControl(self._ui.stc_radioBg, "RadioButton_Advence")
  self._ui.stc_selectBar = UI.getChildControl(self._ui.stc_radioBg, "Static_SelctLine")
  self._radioTab[1] = self._ui.radio_worker
  self._radioTab[2] = self._ui.radio_advence
  self._ui.radio_worker:SetTextMode(__eTextMode_AutoWrap)
  self._ui.radio_worker:SetText(self._ui.radio_worker:GetText())
  self._ui.radio_advence:SetTextMode(__eTextMode_AutoWrap)
  self._ui.radio_advence:SetText(self._ui.radio_advence:GetText())
  self._ui.combo_town = UI.getChildControl(Panel_Window_WorkerManager_All, "Combobox_Town")
  self._ui.combo_townlist = UI.getChildControl(self._ui.combo_town, "Combobox_List")
  self._ui.combo_grade = UI.getChildControl(Panel_Window_WorkerManager_All, "Combobox_Grade")
  self._ui.combo_gradelist = UI.getChildControl(self._ui.combo_grade, "Combobox_List")
  self._ui.stc_restoreGroup = UI.getChildControl(Panel_Window_WorkerManager_All, "Static_RestoreGroup")
  self._ui.txt_restoreGuide = UI.getChildControl(self._ui.stc_restoreGroup, "StaticText_Guide_RestoreAll")
  self._ui.stc_restoreIconBg = UI.getChildControl(self._ui.stc_restoreGroup, "Static_Restore_Item_Icone_BG")
  self._ui.stc_restoreIcon = UI.getChildControl(self._ui.stc_restoreIconBg, "Static_Restore_Item_Icone")
  self._ui.slider_Bg = UI.getChildControl(self._ui.stc_restoreGroup, "Slider_Restore_Item")
  self._ui.slider_btn = UI.getChildControl(self._ui.slider_Bg, "Slider_Restore_Item_Button")
  self._ui.txt_itemCnt = UI.getChildControl(self._ui.stc_restoreIconBg, "StaticText_Item_Count")
  self._ui.txt_itemVal = UI.getChildControl(self._ui.stc_restoreIconBg, "StaticText_Item_Restore_Value")
  self._ui.stc_restoreDesc = UI.getChildControl(self._ui.stc_restoreGroup, "StaticText_Guide_Restore")
  self._ui.stc_workerListGroup = UI.getChildControl(Panel_Window_WorkerManager_All, "Static_WorkerListGroup")
  self._ui.list2_worker = UI.getChildControl(self._ui.stc_workerListGroup, "List2_1")
  self._ui.stc_workerAdvenceGroup = UI.getChildControl(Panel_Window_WorkerManager_All, "Static_WorkerAdvenceGroup")
  self._ui.stc_selectedWorkerSlot = UI.getChildControl(self._ui.stc_workerAdvenceGroup, "Static_SelectedWorkerSlot")
  self._ui.list2_advence = UI.getChildControl(self._ui.stc_workerAdvenceGroup, "List2_1")
  self._ui.stc_noticeBox = UI.getChildControl(self._ui.stc_selectedWorkerSlot, "StaticText_NoticeBOX")
  self._ui.txt_normal = UI.getChildControl(self._ui.stc_noticeBox, "StaticText_NormalNotice")
  self._ui.txt_nobody = UI.getChildControl(self._ui.stc_noticeBox, "StaticText_Nobody")
  self._ui.txt_result = UI.getChildControl(self._ui.stc_noticeBox, "StaticText_AdvenceResurt")
  self._ui.stc_selectedBox = UI.getChildControl(self._ui.stc_selectedWorkerSlot, "Static_SelectedWorkerBG")
  self._ui.stc_border_normal = UI.getChildControl(self._ui.stc_selectedBox, "Static_WorkerImage_Slot_Normal")
  self._ui.stc_border_green = UI.getChildControl(self._ui.stc_selectedBox, "Static_WorkerImage_Slot_Green")
  self._ui.stc_border_blue = UI.getChildControl(self._ui.stc_selectedBox, "Static_WorkerImage_Slot_Blue")
  self._ui.stc_border_yellow = UI.getChildControl(self._ui.stc_selectedBox, "Static_WorkerImage_Slot_Yellow")
  self._ui.stc_border_orange = UI.getChildControl(self._ui.stc_selectedBox, "Static_WorkerImage_Slot_Orenge")
  self._ui.stc_image = UI.getChildControl(self._ui.stc_selectedBox, "Static_WorlerImage")
  self._ui.stc_expBg = UI.getChildControl(self._ui.stc_selectedBox, "Static_WorkerEXPProgress_BG")
  self._ui.progress_exp = UI.getChildControl(self._ui.stc_selectedBox, "Progress2_WorkerEXPProgress")
  self._ui.txt_workCnt = UI.getChildControl(self._ui.stc_selectedBox, "StaticText_WorkCount")
  self._ui.txt_workerInfo = UI.getChildControl(self._ui.stc_selectedBox, "StaticText_WorkerLevelName")
  self._ui.txt_workerTown = UI.getChildControl(self._ui.stc_selectedBox, "StaticText_BelongTown")
  self._ui.stc_advenceBg = UI.getChildControl(self._ui.stc_selectedBox, "Static_AdvenceProgress_BG")
  self._ui.progress_advence = UI.getChildControl(self._ui.stc_selectedBox, "Progress2_AdvenceProgress")
  self._ui.txt_advence_state = UI.getChildControl(self._ui.stc_selectedBox, "StaticText_AdvenceStatus")
  self._ui.btn_advence_stop = UI.getChildControl(self._ui.stc_selectedBox, "Button_AdvenceStop")
  self._ui.stc_advence_stopIcon = UI.getChildControl(self._ui.stc_selectedBox, "Static_Stop_Icon")
  self._ui.btn_advence_Done = UI.getChildControl(self._ui.stc_selectedBox, "Button_InstanceDone")
  self._ui.btn_advence_Done:SetTextMode(__eTextMode_AutoWrap)
  self._ui.btn_advence_Done:SetText(self._ui.btn_advence_Done:GetText())
  if self._ui.txt_normal:GetSizeX() < self._ui.txt_normal:GetTextSizeX() then
    self._ui.txt_normal:SetTextMode(__eTextMode_AutoWrap)
    self._ui.txt_normal:SetText(self._ui.txt_normal:GetText())
    self._ui.txt_nobody:SetPosY(self._ui.txt_normal:GetPosY() + self._ui.txt_normal:GetSizeY() + 15)
  end
  self._ui.stc_desc = UI.getChildControl(Panel_Window_WorkerManager_All, "Static_GuideIcon")
  self._ui.txt_restoreGuide:SetTextMode(__eTextMode_AutoWrap)
  self._ui.txt_restoreGuide:SetText(self._ui.txt_restoreGuide:GetText())
  local gabX = 5
  for resIdx = 0, self._restoreItemMaxCount - 1 do
    local tempItemSlot = {}
    tempItemSlot.slotBG = UI.createAndCopyBasePropertyControl(self._ui.stc_restoreGroup, "Static_Restore_Item_Icone_BG", self._ui.stc_restoreGroup, "workerManager_restoreSlotBG_" .. resIdx)
    tempItemSlot.slotIcon = UI.createAndCopyBasePropertyControl(self._ui.stc_restoreIconBg, "Static_Restore_Item_Icone", tempItemSlot.slotBG, "workerManager_restoreSlot_" .. resIdx)
    tempItemSlot.itemCount = UI.createAndCopyBasePropertyControl(self._ui.stc_restoreIconBg, "StaticText_Item_Count", tempItemSlot.slotBG, "workerManager_restoreItemCount_" .. resIdx)
    tempItemSlot.restorePoint = UI.createAndCopyBasePropertyControl(self._ui.stc_restoreIconBg, "StaticText_Item_Restore_Value", tempItemSlot.slotBG, "workerManager_restorePoint_" .. resIdx)
    tempItemSlot.slotBG:SetPosX(10 + tempItemSlot.slotBG:GetSizeX() * resIdx + gabX * resIdx)
    tempItemSlot.slotBG:SetPosY(self._ui.txt_restoreGuide:GetTextSizeY() + 10)
    tempItemSlot.slotIcon:ComputePos()
    tempItemSlot.itemCount:ComputePos()
    tempItemSlot.restorePoint:ComputePos()
    if true == self._isPadSnap then
      tempItemSlot.slotBG:SetIgnore(false)
      tempItemSlot.slotIcon:SetIgnore(true)
    else
      tempItemSlot.slotBG:SetIgnore(true)
      tempItemSlot.slotIcon:SetIgnore(false)
    end
    self._restoreItemSlot[resIdx] = tempItemSlot
  end
  self._ui.stc_restoreDesc:SetPosY(self._restoreItemSlot[0].slotBG:GetPosY() + self._restoreItemSlot[0].slotBG:GetSizeY() + 5)
  self._ui.stc_restoreDesc:SetTextMode(__eTextMode_AutoWrap)
  self._ui.stc_restoreDesc:SetText(self._ui.stc_restoreDesc:GetText())
  local restoreGroupSizeY = self._ui.txt_restoreGuide:GetTextSizeY() + self._restoreItemSlot[0].slotBG:GetSizeY() + self._ui.stc_restoreDesc:GetTextSizeY() + self._ui.slider_Bg:GetSizeY() + 20
  self._ui.stc_restoreGroup:SetSize(self._ui.stc_restoreGroup:GetSizeX(), restoreGroupSizeY)
end
function PaGlobal_WorkerManager_All:ControlPc_Init()
  if nil == Panel_Window_WorkerManager_All then
    return
  end
  self._ui_pc.btn_question = UI.getChildControl(self._ui.stc_titleBg, "Button_Question")
  self._ui_pc.btn_close = UI.getChildControl(self._ui.stc_titleBg, "Button_Close")
  self._ui_pc.chk_popUp = UI.getChildControl(self._ui.stc_titleBg, "CheckButton_PopUp")
  self._ui_pc.btn_restoreClose = UI.getChildControl(self._ui.stc_restoreGroup, "Button_Close_Item")
  self._ui_pc.btn_restoreAll = UI.getChildControl(Panel_Window_WorkerManager_All, "Button_Restore_All")
  self._ui_pc.btn_repeatAll = UI.getChildControl(Panel_Window_WorkerManager_All, "Button_ReDo_All")
  self._ui_pc.btn_restoreAll:ComputePos()
  self._ui_pc.btn_repeatAll:ComputePos()
end
function PaGlobal_WorkerManager_All:ControlConsole_Init()
  if nil == Panel_Window_WorkerManager_All then
    return
  end
  self._ui_console.stc_radioLB = UI.getChildControl(self._ui.stc_radioBg, "Static_SelectLB_C")
  self._ui_console.stc_radioRB = UI.getChildControl(self._ui.stc_radioBg, "Static_SelectRB_C")
  self._ui_console.stc_guideBg_normal = UI.getChildControl(Panel_Window_WorkerManager_All, "Static_ConsoleKeyGuide_Advence")
  self._ui_console.stc_normal_restore = UI.getChildControl(self._ui_console.stc_guideBg_normal, "StaticText_RestoreAll")
  self._ui_console.stc_normal_repeat = UI.getChildControl(self._ui_console.stc_guideBg_normal, "StaticText_RepeatAll")
  self._ui_console.stc_normal_detail = UI.getChildControl(self._ui_console.stc_guideBg_normal, "StaticText_DetaileMenu")
  self._ui_console.stc_normal_close = UI.getChildControl(self._ui_console.stc_guideBg_normal, "StaticText_Close")
  self._ui_console.stc_detailMenu = UI.getChildControl(Panel_Window_WorkerManager_All, "Static_ConsoleDetailMenu")
  self._ui_console.txt_detailMenuTitle = UI.getChildControl(self._ui_console.stc_detailMenu, "StaticText_DetailMenuTitle")
  self._ui_console.stc_menuBg = UI.getChildControl(self._ui_console.stc_detailMenu, "Static_MainBG")
  self._ui_console.btn_restore = UI.getChildControl(self._ui_console.stc_menuBg, "Button_Restore")
  self._ui_console.btn_repeatReset = UI.getChildControl(self._ui_console.stc_menuBg, "Button_CancelRepeat")
  self._ui_console.btn_workCancle = UI.getChildControl(self._ui_console.stc_menuBg, "Button_WorkCancel")
  self._ui_console.btn_changeSkill = UI.getChildControl(self._ui_console.stc_menuBg, "Button_ChangeSkill")
  self._ui_console.btn_fire = UI.getChildControl(self._ui_console.stc_menuBg, "Button_Fire")
  self._detailBtnlist[1] = self._ui_console.btn_restore
  self._detailBtnlist[2] = self._ui_console.btn_repeatReset
  self._detailBtnlist[3] = self._ui_console.btn_workCancle
  self._detailBtnlist[4] = self._ui_console.btn_changeSkill
  self._detailBtnlist[5] = self._ui_console.btn_fire
  self._ui_console.stc_guideBg_menu = UI.getChildControl(self._ui_console.stc_detailMenu, "Static_ConsoleKeyGuide_DatailMenu")
  self._ui_console.stc_menu_select = UI.getChildControl(self._ui_console.stc_guideBg_menu, "StaticText_Select")
  self._ui_console.stc_menu_close = UI.getChildControl(self._ui_console.stc_guideBg_menu, "StaticText_Close")
  self._ui_console.stc_normal_detail:SetText(self._keyGuideA.DETAIL)
end
function PaGlobal_WorkerManager_All:ControlSetShow()
  if nil == Panel_Window_WorkerManager_All then
    return
  end
  self._ui_pc.btn_question:SetShow(false)
  self._ui_console.stc_detailMenu:SetShow(false)
  self._ui_console.stc_normal_detail:SetShow(false)
  if true == self._isPadSnap then
    self._ui_pc.btn_close:SetShow(false)
    self._ui_pc.chk_popUp:SetShow(false)
    self._ui_pc.btn_restoreClose:SetShow(false)
    self._ui_pc.btn_restoreAll:SetShow(false)
    self._ui_pc.btn_repeatAll:SetShow(false)
    self._ui_console.stc_radioLB:SetShow(true)
    self._ui_console.stc_radioRB:SetShow(true)
    self._ui_console.stc_guideBg_normal:SetShow(true)
    self._ui_console.stc_guideBg_menu:SetShow(true)
    Panel_Window_WorkerManager_All:SetSize(Panel_Window_WorkerManager_All:GetSizeX(), Panel_Window_WorkerManager_All:GetSizeY() - self._ui_pc.btn_restoreAll:GetSizeY() - 10)
    self._ui.stc_desc:SetShow(false)
    self._ui.combo_town:SetSize(250, self._ui.combo_town:GetSizeY())
    self._ui.combo_grade:SetSize(250, self._ui.combo_grade:GetSizeY())
    self._ui.combo_town:SetSpanSize(15, self._ui.combo_town:GetSpanSize().y)
    self._ui.combo_grade:SetSpanSize(15, self._ui.combo_town:GetSpanSize().y)
  else
    self._ui_pc.btn_close:SetShow(true)
    self._ui_pc.chk_popUp:SetShow(_ContentsGroup_PopUp)
    self._ui_pc.btn_restoreClose:SetShow(true)
    self._ui_pc.btn_restoreAll:SetShow(true)
    self._ui_pc.btn_repeatAll:SetShow(true)
    self._ui_console.stc_radioLB:SetShow(false)
    self._ui_console.stc_radioRB:SetShow(false)
    self._ui_console.stc_guideBg_normal:SetShow(false)
    self._ui_console.stc_guideBg_menu:SetShow(false)
    self._ui.stc_desc:SetShow(true)
  end
end
function PaGlobal_WorkerManager_All:prepareOpen()
  if nil == Panel_Window_WorkerManager_All then
    return
  end
  if true == workerManager_CheckWorkingOtherChannel() then
    local workingServerNo = getSelfPlayer():get():getWorkerWorkingServerNo()
    local temporaryWrapper = getTemporaryInformationWrapper()
    local worldNo = temporaryWrapper:getSelectedWorldServerNo()
    local channelName = getChannelName(worldNo, workingServerNo)
    Proc_ShowMessage_Ack(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_WORKERMANAGER_WORKERWORKINGOTHERCHANNEL", "channelName", channelName), nil, CppEnums.ChatType.System, CppEnums.ChatSystemType.Undefine)
    return
  end
  if false == ToClient_IsGrowStepOpen(__eGrowStep_worker) then
    return
  end
  self._ui.list2_worker:moveTopIndex()
  self._ui.list2_advence:moveTopIndex()
  HandleEventLUp_WorkerManager_All_RestoreGroupClose()
  HandleEventLUp_WorkerManager_All_SelectTabMenu(self._TAB.WORKER)
  PaGlobalFunc_WorkerManager_All_PreClose()
  self._ui_console.stc_detailMenu:SetShow(false)
  self._ui_pc.chk_popUp:SetCheck(false)
  PaGlobalFunc_WorkerManager_All_ComboBoxResetAdd()
  Panel_Window_WorkerManager_All:RegisterUpdateFunc("PaGlobalFunc_WorkerManagerRestore_All_FrameUpdate")
  PaGlobal_WorkerManager_All:open()
  PaGlobal_WorkerManager_All:resize()
  if true == ToClient_WorldMapIsShow() then
    WorldMapPopupManager:increaseLayer(true)
    WorldMapPopupManager:push(Panel_Window_WorkerManager_All, true, nil, PaGlobalFunc_WorkerManager_All_Close)
  end
end
function PaGlobal_WorkerManager_All:open()
  if nil == Panel_Window_WorkerManager_All then
    return
  end
  PaGlobalFunc_WorkerManager_All_Audio(1, 28)
  Panel_Window_WorkerManager_All:SetShow(true, true)
end
function PaGlobal_WorkerManager_All:prepareClose()
  if nil == Panel_Window_WorkerManager_All then
    return
  end
  HandleEventLUp_WorkerManager_All_RestoreGroupClose()
  PaGlobalFunc_WorkerManagerChangeSkill_All_Close()
  PaGlobalFunc_WorkerManagerRestore_All_Close()
  PaGlobalFunc_WorkerManagerTooltip_All_Close()
  PaGlobalFunc_WorkerManagerTooltip_All_Clear()
  self._elapsedTime = 0
  self._plantKey = nil
  Panel_Window_WorkerManager_All:ClearUpdateLuaFunc()
  if true == Panel_Window_WorkerManager_All:IsUISubApp() then
    Panel_Window_WorkerManager_All:CloseUISubApp()
    PaGlobal_WorkerManager_All:close(true)
  else
    PaGlobal_WorkerManager_All:close(false)
  end
end
function PaGlobal_WorkerManager_All:close(isSubApp)
  if nil == Panel_Window_WorkerManager_All then
    return
  end
  PaGlobalFunc_WorkerManager_All_Audio(1, 1)
  if true == ToClient_WorldMapIsShow() and true == Panel_Window_WorkerManager_All:GetShow() then
    WorldMapPopupManager:pop()
    return
  end
  if true == isSubApp then
    Panel_Window_WorkerManager_All:SetShow(false)
  else
    Panel_Window_WorkerManager_All:SetShow(false, true)
  end
end
function PaGlobal_WorkerManager_All:update()
  if nil == Panel_Window_WorkerManager_All then
    return
  end
  if false == self._initialize then
    return
  end
  self:updateMainData()
  self:showOpenTab()
  self:updateFilterData()
  self:updateListData()
  self:updateUpgradeData()
  if true == self._ui.stc_restoreGroup:GetShow() then
    self:restoreItemUpdate()
  end
end
function PaGlobal_WorkerManager_All:frameUpdate(deltaTime)
  self._elapsedTime = self._elapsedTime + deltaTime
  if self._elapsedTime > 1 then
    PaGlobal_WorkerManager_All:update()
    self._elapsedTime = 0
  end
end
function PaGlobal_WorkerManager_All:updateAll()
  if nil == Panel_Window_WorkerManager_All then
    return
  end
  if false == self._initialize then
    return
  end
  self:update()
  if true == PaGlobalFunc_WorkerManagerRestore_All_GetShow() then
    PaGlobalFunc_WorkerManagerRestore_All_Update()
  end
end
function PaGlobal_WorkerManager_All:registEventHandler()
  if nil == Panel_Window_WorkerManager_All then
    return
  end
  Panel_Window_WorkerManager_All:setGlassBackground(true)
  Panel_Window_WorkerManager_All:RegisterShowEventFunc(true, "PaGlobalFunc_WorkerManager_All_ShowAni()")
  Panel_Window_WorkerManager_All:RegisterShowEventFunc(false, "PaGlobalFunc_WorkerManager_All_HideAni()")
  registerEvent("onScreenResize", "FromClient_WorkerManager_All_onScreenResize")
  registerEvent("FromClient_RenderModeChangeState", "FromClient_WorkerManager_All_RenderModeChangeState")
  registerEvent("WorldMap_StopWorkerWorking", "FromClient_WorkerManager_All_StopWorkerWorking")
  registerEvent("WorldMap_WorkerDataUpdate", "FromClient_WorkerManager_All_WorkerDataUpdate")
  registerEvent("WorldMap_WorkerDataUpdate", "FromClient_WorkerManager_All_WorkerDataUpdateByPlant")
  registerEvent("WorldMap_WorkerDataUpdateByHouse", "FromClient_WorkerManager_All_WorkerDataUpdateByHouse")
  registerEvent("WorldMap_WorkerDataUpdateByBuilding", "FromClient_WorkerManager_All_WorkerDataUpdateByBuilding")
  registerEvent("WorldMap_WorkerDataUpdateByRegionManaging", "FromClient_WorkerManager_All_WorkerDataUpdateByRegionManaging")
  registerEvent("FromClient_UpdateLastestWorkingResult", "FromClient_WorkerManager_All_UpdateLastestWorkingResult")
  registerEvent("FromClient_AppliedChangeUseType", "FromClient_WorkerManager_All_AppliedChangeUseType")
  registerEvent("FromClient_ReceiveReturnHouse", "FromClient_WorkerManager_All_ReceiveReturnHouse")
  self._ui.combo_town:addInputEvent("Mouse_LUp", "HandleEventLUp_WorkerManager_All_ComboTown()")
  self._ui.combo_town:GetListControl():SetIgnore(false)
  self._ui.combo_town:GetListControl():AddSelectEvent("HandleEventLUp_WorkerManager_All_SetComboTown()")
  self._ui.combo_grade:addInputEvent("Mouse_LUp", "HandleEventLUp_WorkerManager_All_ComboGrade()")
  self._ui.combo_grade:GetListControl():SetIgnore(false)
  self._ui.combo_grade:GetListControl():AddSelectEvent("HandleEventLUp_WorkerManager_All_SetComboGrade()")
  Panel_Window_WorkerManager_All:SetChildIndex(self._ui.combo_town, 9999)
  Panel_Window_WorkerManager_All:SetChildIndex(self._ui.combo_grade, 9999)
  self._ui.list2_worker:registEvent(__ePAUIList2EventType_LuaChangeContent, "PaGlobalFunc_WorkerManager_All_listCreate")
  self._ui.list2_worker:createChildContent(__ePAUIList2ElementManagerType_List)
  self._ui.list2_worker:addInputEvent("Mouse_UpScroll", "HandleEventLUp_WorkerManager_All_RestoreGroupClose()")
  self._ui.list2_worker:addInputEvent("Mouse_DownScroll", "HandleEventLUp_WorkerManager_All_RestoreGroupClose()")
  self._ui.list2_worker:GetVScroll():GetControlButton():addInputEvent("Mouse_LDown", "HandleEventLUp_WorkerManager_All_RestoreGroupClose()")
  self._ui.list2_advence:registEvent(__ePAUIList2EventType_LuaChangeContent, "PaGlobalFunc_WorkerManager_All_listCreate")
  self._ui.list2_advence:createChildContent(__ePAUIList2ElementManagerType_List)
  self._ui.stc_restoreGroup:addInputEvent("Mouse_UpScroll", "HandleEventScroll_WorkerManager_All_RestoreSliderScroll(true)")
  self._ui.stc_restoreGroup:addInputEvent("Mouse_DownScroll", "HandleEventScroll_WorkerManager_All_RestoreSliderScroll(false)")
  if false == self._isPadSnap then
    self._ui_pc.btn_close:addInputEvent("Mouse_LUp", "HandleEventLUp_WorkerManager_All_Close()")
    self._ui_pc.btn_restoreClose:addInputEvent("Mouse_LUp", "HandleEventLUp_WorkerManager_All_RestoreGroupClose()")
    self._ui_pc.chk_popUp:addInputEvent("Mouse_LUp", "HandleEventLUp_WorkerManager_All_PopUpMode()")
    self._ui_pc.chk_popUp:addInputEvent("Mouse_On", "HandleEventOnOut_WorkerManager_PopUpIconTooltip(true)")
    self._ui_pc.chk_popUp:addInputEvent("Mouse_Out", "HandleEventOnOut_WorkerManager_PopUpIconTooltip(false)")
    self._radioTab[1]:addInputEvent("Mouse_LUp", "HandleEventLUp_WorkerManager_All_SelectTabMenu(" .. self._TAB.WORKER .. ")")
    self._radioTab[2]:addInputEvent("Mouse_LUp", "HandleEventLUp_WorkerManager_All_SelectTabMenu(" .. self._TAB.UPGRADE .. ")")
    self._ui_pc.btn_restoreAll:addInputEvent("Mouse_LUp", "HandleEventLUp_WorkerManager_All_RestoreAll()")
    self._ui_pc.btn_repeatAll:addInputEvent("Mouse_LUp", "HandleEventLUp_WorkerManager_All_RepeatAll()")
    self._ui.stc_desc:addInputEvent("Mouse_On", "HandleEventOnOut_WorkerManager_GuideDesc(true)")
    self._ui.stc_desc:addInputEvent("Mouse_Out", "HandleEventOnOut_WorkerManager_GuideDesc(false)")
  else
    Panel_Window_WorkerManager_All:registerPadEvent(__eConsoleUIPadEvent_LB, "HandlePadEventLBRB_WorkerManager_All_ChangeTab(-1)")
    Panel_Window_WorkerManager_All:registerPadEvent(__eConsoleUIPadEvent_RB, "HandlePadEventLBRB_WorkerManager_All_ChangeTab(1)")
    Panel_Window_WorkerManager_All:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandlePadEventX_WorkerManager_All_RecoverAll()")
    Panel_Window_WorkerManager_All:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "HandlePadEventY_WorkerManager_All_RepeatAll()")
  end
end
function PaGlobal_WorkerManager_All:validate()
  if nil == Panel_Window_WorkerManager_All then
    return
  end
  self._ui.stc_titleBg:isValidate()
  self._ui.txt_title:isValidate()
  self._ui.stc_radioBg:isValidate()
  self._ui.radio_worker:isValidate()
  self._ui.radio_advence:isValidate()
  self._ui.stc_selectBar:isValidate()
  self._ui.combo_town:isValidate()
  self._ui.combo_townlist:isValidate()
  self._ui.combo_grade:isValidate()
  self._ui.combo_gradelist:isValidate()
  self._ui.stc_restoreGroup:isValidate()
  self._ui.txt_restoreGuide:isValidate()
  self._ui.stc_restoreIconBg:isValidate()
  self._ui.stc_restoreIcon:isValidate()
  self._ui.slider_Bg:isValidate()
  self._ui.slider_btn:isValidate()
  self._ui.txt_itemCnt:isValidate()
  self._ui.txt_itemVal:isValidate()
  self._ui.stc_restoreDesc:isValidate()
  self._ui.stc_workerListGroup:isValidate()
  self._ui.list2_worker:isValidate()
  self._ui.stc_workerAdvenceGroup:isValidate()
  self._ui.stc_selectedWorkerSlot:isValidate()
  self._ui.list2_advence:isValidate()
  self._ui.stc_noticeBox:isValidate()
  self._ui.txt_normal:isValidate()
  self._ui.txt_nobody:isValidate()
  self._ui.txt_result:isValidate()
  self._ui.stc_selectedBox:isValidate()
  self._ui.stc_border_normal:isValidate()
  self._ui.stc_border_green:isValidate()
  self._ui.stc_border_blue:isValidate()
  self._ui.stc_border_yellow:isValidate()
  self._ui.stc_border_orange:isValidate()
  self._ui.stc_image:isValidate()
  self._ui.stc_expBg:isValidate()
  self._ui.progress_exp:isValidate()
  self._ui.txt_workCnt:isValidate()
  self._ui.txt_workerInfo:isValidate()
  self._ui.txt_workerTown:isValidate()
  self._ui.stc_advenceBg:isValidate()
  self._ui.progress_advence:isValidate()
  self._ui.txt_advence_state:isValidate()
  self._ui.btn_advence_stop:isValidate()
  self._ui.stc_advence_stopIcon:isValidate()
  self._ui.btn_advence_Done:isValidate()
  self._ui_pc.btn_question:isValidate()
  self._ui_pc.btn_close:isValidate()
  self._ui_pc.chk_popUp:isValidate()
  self._ui_pc.btn_restoreClose:isValidate()
  self._ui_pc.btn_restoreAll:isValidate()
  self._ui_pc.btn_repeatAll:isValidate()
  self._ui_console.stc_radioLB:isValidate()
  self._ui_console.stc_radioRB:isValidate()
  self._ui_console.stc_guideBg_normal:isValidate()
  self._ui_console.stc_normal_restore:isValidate()
  self._ui_console.stc_normal_repeat:isValidate()
  self._ui_console.stc_normal_detail:isValidate()
  self._ui_console.stc_normal_close:isValidate()
  self._ui_console.stc_detailMenu:isValidate()
  self._ui_console.txt_detailMenuTitle:isValidate()
  self._ui_console.stc_menuBg:isValidate()
  self._ui_console.btn_restore:isValidate()
  self._ui_console.btn_repeatReset:isValidate()
  self._ui_console.btn_workCancle:isValidate()
  self._ui_console.btn_changeSkill:isValidate()
  self._ui_console.btn_fire:isValidate()
  self._ui_console.stc_guideBg_menu:isValidate()
  self._ui_console.stc_menu_select:isValidate()
  self._ui_console.stc_menu_close:isValidate()
end
function PaGlobal_WorkerManager_All:resize()
  if nil == Panel_Window_WorkerManager_All then
    return
  end
  Panel_Window_WorkerManager_All:ComputePos()
  self._ui_console.stc_guideBg_normal:ComputePos()
  self._ui.combo_town:ComputePos()
  self._ui.combo_grade:ComputePos()
  self:consoleKeyAlign()
end
function PaGlobal_WorkerManager_All:consoleKeyAlign()
  if true ~= self._isPadSnap then
    return
  end
  local keyGuidelist = {
    self._ui_console.stc_normal_restore,
    self._ui_console.stc_normal_repeat,
    self._ui_console.stc_normal_detail,
    self._ui_console.stc_normal_close
  }
  PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyGuidelist, self._ui_console.stc_guideBg_normal, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP)
  local keyGuidelist = {
    self._ui_console.stc_menu_select,
    self._ui_console.stc_menu_close
  }
  PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyGuidelist, self._ui_console.stc_guideBg_menu, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP)
end
function PaGlobal_WorkerManager_All:getCurrentListControl()
  if self._TAB.WORKER == self._selectTabIdx then
    return self._ui.list2_worker
  elseif self._TAB.UPGRADE == self._selectTabIdx then
    return self._ui.list2_advence
  end
end
function PaGlobal_WorkerManager_All:showOpenTab()
  if nil == Panel_Window_WorkerManager_All then
    return
  end
  if self._TAB.WORKER == self._selectTabIdx then
    self._ui.stc_workerListGroup:SetShow(true)
    self._ui.stc_workerAdvenceGroup:SetShow(false)
  else
    self._ui.stc_workerListGroup:SetShow(false)
    self._ui.stc_workerAdvenceGroup:SetShow(true)
  end
  PaGlobal_WorkerManager_All:consoleKeyAlign()
end
function PaGlobal_WorkerManager_All:updateMainData()
  if nil == Panel_Window_WorkerManager_All then
    return
  end
  self._plantArray = Array.new()
  self._workerArray = Array.new()
  local plantSort_do = function(a, b)
    return a:get() < b:get()
  end
  local gradeSort_do = function(a, b)
    return a < b
  end
  local tableInsert = function(list, target)
    if nil == list[1] then
      table.insert(list, target)
    else
      local townCheck = true
      for n = 1, #list do
        if target == list[n] then
          townCheck = false
        end
      end
      if true == townCheck then
        table.insert(list, target)
      end
    end
  end
  if nil ~= self._plantKey then
    self._plantArray:push_back(self._plantKey)
  else
    local plantConut = ToCleint_getHomePlantKeyListCount()
    local plantKeyRaw
    for index = 0, plantConut - 1 do
      plantKeyRaw = ToCleint_getHomePlantKeyListByIndex(index)
      local plantKey = PlantKey()
      if nil ~= plantKeyRaw and nil ~= plantKey then
        plantKey:setRaw(plantKeyRaw)
        self._plantArray:push_back(plantKey)
      end
    end
  end
  table.sort(self._plantArray, plantSort_do)
  self._totalWorkerCount = 0
  self._totalWorkerCapacity = 0
  for plantRawIdx = 1, #self._plantArray do
    local plantKey = self._plantArray[plantRawIdx]
    local plantWorkerCount = ToClient_getPlantWaitWorkerListCount(plantKey, 0)
    local workerHouseCount = ToClient_getTownWorkerMaxCapacity(plantKey)
    if plantWorkerCount > workerHouseCount then
      plantWorkerCount = workerHouseCount
    end
    for workerIdx = 0, plantWorkerCount - 1 do
      local workerNoRaw = ToClient_getPlantWaitWorkerNoRawByIndex(plantKey, workerIdx)
      self._workerArray:push_back(workerNoRaw)
    end
    self._totalWorkerCapacity = self._totalWorkerCapacity + workerHouseCount
    self._totalWorkerCount = self._totalWorkerCount + plantWorkerCount
  end
  local title = ""
  if nil ~= self._plantKey then
    title = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_WORKERMANAGER_WORKERCOUNT", "Count", self._totalWorkerCount .. "/" .. self._totalWorkerCapacity)
  else
    title = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_WORKERMANAGER_ALLWORKERCOUNT", "Count", self._totalWorkerCount)
  end
  self._ui.txt_title:SetColor(Defines.Color.C_FFFFEDD4)
  self._ui.txt_title:SetText(title)
  self._townList[0] = self._filterAllStr
  self._gradeList[0] = self._filterAllStr
  local hasUpgradeWorker = false
  for index = 1, #self._workerArray do
    local workerWrapper = getWorkerWrapper(self._workerArray[index], false)
    if nil ~= workerWrapper then
      if CppEnums.NpcWorkingType.eNpcWorkingType_Upgrade == workerWrapper:getWorkingType() then
        hasUpgradeWorker = true
        self._upgradingWorkerNoRaw = self._workerArray[index]
      end
      local workerTown = workerWrapper:getHomeWaypoint()
      tableInsert(self._townList, workerTown)
      local workerGrade = workerWrapper:getGrade()
      tableInsert(self._gradeList, workerGrade)
    end
  end
  table.sort(self._gradeList, gradeSort_do)
end
function PaGlobal_WorkerManager_All:updateFilterData()
  if nil == Panel_Window_WorkerManager_All then
    return
  end
  self._listCnt = 0
  self._filteredArray = {}
  for worker_index = 1, #self._workerArray do
    local workerWrapper = getWorkerWrapper(self._workerArray[worker_index], false)
    if nil ~= workerWrapper then
      if 0 < self._selectFilterTown then
        if workerWrapper:getHomeWaypoint() == self._townList[self._selectFilterTown] then
          if 0 <= self._selectFilterGrade then
            if workerWrapper:getGrade() == self._selectFilterGrade then
              self._listCnt = self._listCnt + 1
              self._filteredArray[self._listCnt] = self._workerArray[worker_index]
            end
          else
            self._listCnt = self._listCnt + 1
            self._filteredArray[self._listCnt] = self._workerArray[worker_index]
          end
        end
      elseif 0 <= self._selectFilterGrade then
        if workerWrapper:getGrade() == self._selectFilterGrade then
          self._listCnt = self._listCnt + 1
          self._filteredArray[self._listCnt] = self._workerArray[worker_index]
        end
      else
        self._listCnt = self._listCnt + 1
        self._filteredArray[self._listCnt] = self._workerArray[worker_index]
      end
    end
  end
end
function PaGlobal_WorkerManager_All:updateUpgradeData()
  if nil == Panel_Window_WorkerManager_All then
    return
  end
  if -1 == self._upgradingWorkerNoRaw then
    self._ui.stc_noticeBox:SetShow(true)
    self._ui.stc_selectedBox:SetShow(false)
    return
  end
  local workerWrapperLua = getWorkerWrapper(self._upgradingWorkerNoRaw)
  if nil == workerWrapperLua then
    self._ui.stc_noticeBox:SetShow(true)
    self._ui.stc_selectedBox:SetShow(false)
    return
  end
  local enum_grade = CppEnums.CharacterGradeType
  local stc_slotGrade = {}
  stc_slotGrade[enum_grade.CharacterGradeType_Normal] = self._ui.stc_border_normal
  stc_slotGrade[enum_grade.CharacterGradeType_Elite] = self._ui.stc_border_green
  stc_slotGrade[enum_grade.CharacterGradeType_Hero] = self._ui.stc_border_blue
  stc_slotGrade[enum_grade.CharacterGradeType_Legend] = self._ui.stc_border_yellow
  stc_slotGrade[enum_grade.CharacterGradeType_Boss] = self._ui.stc_border_orange
  stc_slotGrade[enum_grade.CharacterGradeType_Normal]:SetShow(false)
  stc_slotGrade[enum_grade.CharacterGradeType_Elite]:SetShow(false)
  stc_slotGrade[enum_grade.CharacterGradeType_Hero]:SetShow(false)
  stc_slotGrade[enum_grade.CharacterGradeType_Legend]:SetShow(false)
  stc_slotGrade[enum_grade.CharacterGradeType_Boss]:SetShow(false)
  self._ui.stc_noticeBox:SetShow(false)
  self._ui.stc_selectedBox:SetShow(true)
  self._ui.btn_advence_stop:SetShow(false)
  self._ui.stc_advence_stopIcon:SetShow(false)
  self._ui.progress_advence:SetProgressRate(0)
  self._ui.progress_exp:SetProgressRate(0)
  local workerLv = "<PAColor0xffffedd4>" .. PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_LV") .. "." .. workerWrapperLua:getLevel() .. "<PAOldColor>"
  local workerName = workerWrapperLua:getGradeToColorString() .. workerWrapperLua:getName() .. "<PAOldColor>"
  self._ui.txt_workerInfo:SetText(workerLv .. " " .. workerName)
  UI.setLimitTextAndAddTooltip(self._ui.txt_workerInfo)
  local workerGrade = workerWrapperLua:getGrade()
  if nil ~= stc_slotGrade[workerGrade] then
    stc_slotGrade[workerGrade]:SetShow(true)
  end
  self._ui.stc_image:ChangeTextureInfoName(workerWrapperLua:getWorkerIcon())
  self._ui.stc_image:addInputEvent("Mouse_On", "HandleEventOnOut_WorkerManager_WorkerInfoTooltipByUpgrade(true)")
  self._ui.stc_image:addInputEvent("Mouse_Out", "HandleEventOnOut_WorkerManager_WorkerInfoTooltipByUpgrade(false)")
  self._ui.txt_workerTown:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_WORKERLUAWRAPPER_WORKER_UPGRADE"))
  local isWorking = workerWrapperLua:isWorking()
  local workName = workerWrapperLua:getWorkString()
  if true == isWorking then
    local workingLeftPercent = workerWrapperLua:currentProgressPercents()
    self._ui.progress_advence:SetProgressRate(workingLeftPercent)
    local working_LeftTime = workerWrapperLua:getLeftWorkingTimeXXX(getServerUtc64())
    self._ui.txt_advence_state:SetText(Util.Time.timeFormatting(math.ceil(working_LeftTime / 1000)))
  else
    self._ui.txt_advence_state:SetText("")
    self._ui.stc_noticeBox:SetShow(true)
    self._ui.stc_selectedBox:SetShow(false)
    self._upgradingWorkerNoRaw = -1
    return
  end
  UI.setLimitTextAndAddTooltip(self._ui.txt_advence_state)
  local actionPoint_Per = workerWrapperLua:getActionPointPercents()
  local actionPoint = workerWrapperLua:getActionPointXXX()
  local actionPoint_Max = workerWrapperLua:getMaxActionPoint()
  local currentActionPoint = workerWrapperLua:getActionPoint()
  self._ui.progress_exp:SetProgressRate(actionPoint_Per)
  self._ui.txt_workCnt:SetText(tostring(actionPoint) .. "/" .. tostring(actionPoint_Max))
  self._ui.btn_advence_Done:addInputEvent("Mouse_LUp", "HandleEventLUp_WorkerManager_All_UpgradeNow()")
  if true == self._isPadSnap then
    self._ui.stc_noticeBox:SetIgnore(false)
    self._ui.stc_selectedBox:addInputEvent("Mouse_On", "HandleEventOnOut_WorkerManager_All_KeyGuideCompleteNow(true)")
    self._ui.stc_selectedBox:addInputEvent("Mouse_Out", "HandleEventOnOut_WorkerManager_All_KeyGuideCompleteNow(false)")
    self._ui.stc_selectedBox:registerPadEvent(__eConsoleUIPadEvent_Up_A, "HandleEventLUp_WorkerManager_All_UpgradeNow()")
  else
    self._ui.stc_noticeBox:SetIgnore(true)
  end
end
function PaGlobal_WorkerManager_All:restoreWorkerOpen(key)
  if nil == Panel_Window_WorkerManager_All then
    return
  end
  local index = PaGlobal_WorkerManager_All._filteredArray[key]
  local workerWrapperLua = getWorkerWrapper(index)
  if nil == workerWrapperLua then
    return
  end
  self._selectedRestoreWorkerIdx = key
  self._restoreItemHasCount = ToClient_getNpcRecoveryItemList()
  local actionPointPer = workerWrapperLua:getActionPointPercents()
  if self._restoreItemHasCount <= 0 then
    Proc_ShowMessage_Ack_With_ChatType(PAGetString(Defines.StringSheet_GAME, "LUA_WORLD_MAP_TOWN_WORKER_NOITEM"), nil, CppEnums.ChatType.System, CppEnums.ChatSystemType.Undefine)
    return
  elseif 100 == actionPointPer then
    Proc_ShowMessage_Ack_With_ChatType(PAGetString(Defines.StringSheet_GAME, "LUA_WORLD_MAP_TOWN_WORKER_RESTORE_MAX"), nil, CppEnums.ChatType.System, CppEnums.ChatSystemType.Undefine)
    return
  end
  self._sliderStartIdx = 0
  self._ui.slider_Bg:SetControlPos(self._sliderStartIdx)
  self._ui.stc_restoreGroup:SetShow(true)
  self:restoreItemUpdate()
end
function PaGlobal_WorkerManager_All:restoreItemUpdate()
  for itemIdx = 0, self._restoreItemMaxCount - 1 do
    self._restoreItemSlot[itemIdx].slotBG:SetShow(false)
    self._restoreItemSlot[itemIdx].slotIcon:addInputEvent("Mouse_RUp", "")
  end
  self._restoreItemHasCount = ToClient_getNpcRecoveryItemList()
  if 0 == self._restoreItemHasCount then
    if true == PaGlobal_WorkerManager_All._ui.stc_restoreGroup:GetShow() then
      HandleEventLUp_WorkerManager_All_RestoreGroupClose()
    end
    return
  end
  local itemCnt = 0
  for itemIdx = self._sliderStartIdx, self._restoreItemHasCount - 1 do
    if itemCnt >= self._restoreItemMaxCount then
      break
    end
    local recoveryItem = ToClient_getNpcRecoveryItemByIndex(itemIdx)
    local itemStatic = recoveryItem:getItemStaticStatus()
    self._restoreItemSlot[itemCnt].slotBG:SetShow(true)
    self._restoreItemSlot[itemCnt].slotIcon:ChangeTextureInfoName("icon/" .. getItemIconPath(itemStatic))
    self._restoreItemSlot[itemCnt].itemCount:SetText(tostring(recoveryItem._itemCount_s64))
    self._restoreItemSlot[itemCnt].restorePoint:SetText("+" .. tostring(recoveryItem._contentsEventParam1))
    self._restoreItemSlot[itemCnt].slotIcon:addInputEvent("Mouse_RUp", "HandleEventRUp_WorkerManager_RestoreItemUse(" .. itemIdx .. ")")
    self._restoreItemSlot[itemCnt].slotIcon:addInputEvent("Mouse_UpScroll", "HandleEventScroll_WorkerManager_All_RestoreSliderScroll(true)")
    self._restoreItemSlot[itemCnt].slotIcon:addInputEvent("Mouse_DownScroll", "HandleEventScroll_WorkerManager_All_RestoreSliderScroll(false)")
    itemCnt = itemCnt + 1
  end
  self._ui.stc_restoreDesc:SetTextMode(__eTextMode_AutoWrap)
  self._ui.stc_restoreDesc:SetText(self._ui.stc_restoreDesc:GetText())
  local bgSizeX = self._ui.stc_restoreGroup:GetSizeX()
  local textSizeX = self._ui.txt_restoreGuide:GetSizeX() + 20
  if bgSizeX < textSizeX then
    self._ui.stc_restoreGroup:SetSize(self._ui.stc_restoreGroup:GetSizeX() + (textSizeX - bgSizeX), self._ui.stc_restoreGroup:GetSizeY())
    self._ui_pc.btn_restoreClose:ComputePos()
  end
  if false == self._ui.stc_restoreGroup:GetShow() then
    return
  end
  local list2 = self:getCurrentListControl()
  local key64 = toInt64(0, self._selectedRestoreWorkerIdx)
  local content = list2:GetContentByKey(key64)
  local stc_btnBg = UI.getChildControl(content, "Static_ListBG")
  local btn_restore = UI.getChildControl(stc_btnBg, "Button_WorkRestore")
  local restoreGroupPosX = btn_restore:GetPosX() + btn_restore:GetSizeX() + 20
  local restoreGroupPosY = content:GetPosY() + content:GetSizeY() * 1.75 + 45
  self._ui.stc_restoreGroup:SetPosX(restoreGroupPosX - self._ui.stc_restoreGroup:GetSizeX())
  self._ui.stc_restoreGroup:SetPosY(restoreGroupPosY)
  if self._restoreItemMaxCount < self._restoreItemHasCount then
    self._ui.slider_Bg:SetShow(true)
    local sliderSize = self._ui.slider_Bg:GetSizeX()
    local targetPercent = self._restoreItemMaxCount / self._restoreItemHasCount * 100
    local sliderBtnSize = sliderSize * (targetPercent / 100)
    self._ui.slider_btn:SetSize(sliderBtnSize, self._ui.slider_btn:GetSizeY())
    self._ui.slider_Bg:SetInterval(self._restoreItemHasCount - self._restoreItemMaxCount)
    self._ui.slider_Bg:addInputEvent("Mouse_LUp", "HandleEventLPress_WorkerManager_All_RrestoreSliderScroll()")
    self._ui.slider_btn:addInputEvent("Mouse_LPress", "HandleEventLPress_WorkerManager_All_RrestoreSliderScroll()")
  else
    self._ui.slider_Bg:SetShow(false)
  end
end
function PaGlobal_WorkerManager_All:restoreItemUse(itemIdx)
  if nil == Panel_Window_WorkerManager_All then
    return
  end
  local workerWrapperLua = getWorkerWrapper(self._filteredArray[self._selectedRestoreWorkerIdx], false)
  if nil == workerWrapperLua then
    return
  end
  local workerNo = self._filteredArray[self._selectedRestoreWorkerIdx]
  local recoveryItem = ToClient_getNpcRecoveryItemByIndex(itemIdx)
  local recoveryItemCount = Int64toInt32(recoveryItem._itemCount_s64)
  local slotNo = recoveryItem._slotNo
  local restorePoint = recoveryItem._contentsEventParam1
  local maxPoint = workerWrapperLua:getMaxActionPoint()
  local currentPoint = workerWrapperLua:getActionPoint()
  local actionPointPer = workerWrapperLua:getActionPointPercents()
  if 100 <= actionPointPer then
    Proc_ShowMessage_Ack_With_ChatType(PAGetString(Defines.StringSheet_GAME, "LUA_WORLD_MAP_TOWN_WORKER_RESTORE_MAX"), nil, CppEnums.ChatType.System, CppEnums.ChatSystemType.Undefine)
    return
  end
  if isKeyPressed(CppEnums.VirtualKeyCode.KeyCode_SHIFT) then
    local restoreItemCount = ToClient_getNpcRecoveryItemList()
    local restoreActionPoint = maxPoint - currentPoint
    local itemNeedCount = math.floor(restoreActionPoint / restorePoint)
    local currentItemCount = recoveryItemCount
    if itemNeedCount > currentItemCount then
      itemNeedCount = currentItemCount
    end
    if 1 <= itemNeedCount then
      requestRecoveryWorker(WorkerNo(workerNo), slotNo, itemNeedCount)
    else
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoNpcWorkerActionPointIsOver"))
    end
    return
  end
  self._restoreWorkerNo = workerNo
  requestRecoveryWorker(WorkerNo(workerNo), slotNo, 1)
end
function PaGlobal_WorkerManager_All:resetRepeatWork(workerIdx)
  local workerNoRaw = self._filteredArray[workerIdx]
  local function doUnRepeatWork()
    ToClient_requestEraseRepeat(WorkerNo(workerNoRaw))
    PaGlobal_WorkerManager_All:update()
  end
  local messageboxData = {
    title = PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_ALERT_NOTIFICATIONS"),
    content = PAGetString(Defines.StringSheet_GAME, "LUA_WORKERMANAGER_MESSAGEBOX_UNREPEATCONFIRM"),
    functionYes = doUnRepeatWork,
    functionCancel = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageboxData)
end
function PaGlobal_WorkerManager_All:stopWorking(workerIdx)
  local workerWrapperLua = getWorkerWrapper(self._filteredArray[workerIdx], false)
  local workerNoRaw = self._filteredArray[workerIdx]
  if nil == workerWrapperLua then
    return
  end
  local workerNo = workerNoRaw
  local leftWorkCount = workerWrapperLua:getWorkingCount()
  local workingState = workerWrapperLua:getWorkingStateXXX()
  if CppEnums.NpcWorkingState.eNpcWorkingState_HarvestWorking_Working == workingState then
    ToClient_requestChangeWorkingState(WorkerNo(workerNo), CppEnums.NpcWorkingState.eNpcWorkingState_HarvestWorking_Return)
    FGlobal_HarvestList_Update()
    return
  elseif CppEnums.NpcWorkingState.eNpcWorkingState_HarvestWorking_Return == workingState then
    Proc_ShowMessage_Ack_With_ChatType(PAGetString(Defines.StringSheet_GAME, "LUA_WORKERMANAGER_MESSAGE_GOHOME"), nil, CppEnums.ChatType.System, CppEnums.ChatSystemType.Undefine)
    return
  end
  if leftWorkCount < 1 then
    Proc_ShowMessage_Ack_With_ChatType(PAGetString(Defines.StringSheet_GAME, "LUA_NEW_HOUSECONTROL_ONLYONEWORK"), nil, CppEnums.ChatType.System, CppEnums.ChatSystemType.Undefine)
    return
  else
    local function cancelDoWork()
      ToClient_requestCancelNextWorking(WorkerNo(workerNo))
    end
    local workName = workerWrapperLua:getWorkString()
    local cancelWorkContent = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_LARGECRAFT_WORKMANAGER_CANCELWORK_CONTENT", "workName", workName)
    local messageboxData = {
      title = PAGetString(Defines.StringSheet_GAME, "LUA_WORKINGPROGRESS_CANCELWORK_TITLE"),
      content = cancelWorkContent,
      functionYes = cancelDoWork,
      functionCancel = MessageBox_Empty_function,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageboxData, "top")
  end
end
function PaGlobal_WorkerManager_All:repeatWorking(workerIdx)
  local workerWrapperLua = getWorkerWrapper(self._filteredArray[workerIdx], false)
  local workerNoRaw = self._filteredArray[workerIdx]
  local currentActionPoint = workerWrapperLua:getActionPoint()
  local workerWorkingPrimitiveWrapper = workerWrapperLua:getWorkerRepeatableWorkingWrapper()
  if nil == workerWorkingPrimitiveWrapper then
    return
  end
  if workerWrapperLua:isWorkerRepeatable() then
    if CppEnums.NpcWorkingType.eNpcWorkingType_Upgrade == workerWorkingPrimitiveWrapper:getType() then
      return
    elseif CppEnums.NpcWorkingType.eNpcWorkingType_HarvestWorking == workerWorkingPrimitiveWrapper:getType() then
      ToClient_requestRepeatWork(WorkerNo(workerNoRaw), 1)
      if true ~= self._isPadSnap then
        FGlobal_HarvestList_Update()
      end
    elseif 0 < currentActionPoint then
      ToClient_requestRepeatWork(WorkerNo(workerNoRaw), currentActionPoint)
    end
  end
end
function PaGlobal_WorkerManager_All:fireWorker(workerIdx)
  if nil == Panel_Window_WorkerManager_All then
    return
  end
  if true == PaGlobal_WorkerManager_All._ui.stc_restoreGroup:GetShow() then
    HandleEventLUp_WorkerManager_All_RestoreGroupClose()
  end
  if true == PaGlobalFunc_WorkerManagerRestore_All_GetShow() then
    PaGlobalFunc_WorkerManagerRestore_All_Close()
  end
  if true == PaGlobalFunc_WorkerManagerChangeSkill_All_GetShow() then
    PaGlobalFunc_WorkerManagerChangeSkill_All_Close()
  end
  local workerNoRaw = self._filteredArray[workerIdx]
  local workerWrapperLua = getWorkerWrapper(workerNoRaw)
  if nil == workerWrapperLua then
    return
  end
  local function fireThisWorker()
    ToClient_requestDeleteMyWorker(WorkerNo(workerNoRaw))
  end
  local workerLv = "<PAColor0xffffedd4>" .. PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_LV") .. "." .. workerWrapperLua:getLevel() .. "<PAOldColor>"
  local workerName = workerWrapperLua:getGradeToColorString() .. workerWrapperLua:getName() .. "<PAOldColor>"
  local messageTitle = PAGetString(Defines.StringSheet_GAME, "LUA_ALERT_DEFAULT_TITLE")
  local messageContent = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_WORKERMANAGER_FIREWORKER_DESC", "workerLv", workerLv, "workerName", workerName)
  local messageboxData = {
    title = messageTitle,
    content = messageContent,
    functionYes = fireThisWorker,
    functionCancel = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  if true == self._isPadSnap then
    MessageBox.showMessageBox(messageboxData, "middle")
  else
    MessageBox.showMessageBox(messageboxData, "middle", nil, false)
  end
end
function PaGlobal_WorkerManager_All:upgradeWorker(workerIdx)
  local workerWrapperLua = getWorkerWrapper(self._filteredArray[workerIdx], false)
  local function do_Upgrade_Worker()
    workerWrapperLua:requestUpgrade()
    self:update()
  end
  local workerName = workerWrapperLua:getName()
  local workingTime = workerWrapperLua:getLeftWorkingTime()
  local messageTitle = PAGetString(Defines.StringSheet_GAME, "LUA_ALERT_DEFAULT_TITLE")
  local messageContent = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_WORKERMANAGER_UPGRADEDESC", "name", workerName)
  local messageboxData = {
    title = messageTitle,
    content = messageContent,
    functionYes = do_Upgrade_Worker,
    functionCancel = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageboxData, "top")
end
function PaGlobal_WorkerManager_All:upgradeWorkerNow()
  local workerNoRaw = self._upgradingWorkerNoRaw
  local remainTimeInt = ToClient_getWorkingTime(self._upgradingWorkerNoRaw)
  local needPearl = ToClient_GetUsingPearlByRemainingPearl(CppEnums.InstantCashType.eInstant_CompleteNpcWorkerUpgrade, remainTimeInt)
  local function doUpgradeNow()
    ToClient_requestQuickComplete(WorkerNo(workerNoRaw), needPearl)
    self._upgradingWorkerNoRaw = -1
  end
  local messageboxTitle = PAGetString(Defines.StringSheet_GAME, "LUA_HOUSECONTROL_IMMEDIATELYCOMPLETE_MSGBOX_TITLE")
  local messageBoxMemo = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_WORKERMANAGER_UPGRADENOW_CONFIRM", "pearl", tostring(needPearl))
  local messageboxData = {
    title = messageboxTitle,
    content = messageBoxMemo,
    functionYes = doUpgradeNow,
    functionCancel = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageboxData, "middle")
end
function PaGlobal_WorkerManager_All:pushWorkStartMsg(workerNo, _workType, buildingInfoSS)
  if self._WORKTYPE.HouseCraft == _workType then
    local esSSW = ToClient_getItemExchangeSourceStaticStatusWrapperByWorker(workerNo)
    if esSSW:isSet() then
      local workName = esSSW:getDescription()
      Proc_ShowMessage_Ack_With_ChatType(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_WORLD_MAP_TOWN_WORKER_START_CRAFT", "workName", workName), nil, CppEnums.ChatType.System, CppEnums.ChatSystemType.Worker)
    end
  elseif self._WORKTYPE.LargeCraft == _workType then
    local esSSW = ToClient_getItemExchangeSourceStaticStatusWrapperByWorker(workerNo)
    if esSSW:isSet() then
      local workName = esSSW:getDescription()
      local esSS = esSSW:get()
      local eSSCount = getExchangeSourceNeedItemList(esSS, true)
      local resourceIndex = ToClient_getLargeCraftWorkIndexByWorker(workerNo)
      local itemStaticInfomationWrapper = getExchangeSourceNeedItemByIndex(resourceIndex)
      local itemStaticWrapper = itemStaticInfomationWrapper:getStaticStatus()
      local itemStatic = itemStaticWrapper:get()
      local subWorkName = tostring(getItemName(itemStatic))
      Proc_ShowMessage_Ack_With_ChatType(PAGetStringParam2(Defines.StringSheet_GAME, "LUA_WORLD_MAP_TOWN_WORKER_START_LARGECRAFT", "workName", workName, "subWorkName", subWorkName), nil, CppEnums.ChatType.System, CppEnums.ChatSystemType.Worker)
    end
  elseif self._WORKTYPE.PlantWork == _workType then
    local esSSW = ToClient_getItemExchangeSourceStaticStatusWrapperByWorker(workerNo)
    if nil ~= esSSW and esSSW:isSet() then
      local workName = esSSW:getDescription()
      Proc_ShowMessage_Ack_With_ChatType(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_WORLD_MAP_TOWN_WORKER_START_PLANTWORK", "workName", workName), nil, CppEnums.ChatType.System, CppEnums.ChatSystemType.Worker)
    end
  elseif self._WORKTYPE.Building == _workType then
    if nil == buildingInfoSS then
      return
    end
    local workName = ToClient_getBuildingName(buildingInfoSS)
    local subWorkIndex = ToClient_getBuildingWorkingIndex(workerNo)
    local workCount = ToClient_getBuildingWorkableListCount(buildingInfoSS)
    local buildingStaticStatus = ToClient_getBuildingWorkableBuildingSourceUnitByIndex(buildingInfoSS, subWorkIndex)
    local itemStatic = buildingStaticStatus:getItemStaticStatus()
    local subWorkName = getItemName(itemStatic)
    Proc_ShowMessage_Ack_With_ChatType(PAGetStringParam2(Defines.StringSheet_GAME, "LUA_WORLD_MAP_TOWN_WORKER_START_BUILDING", "workName", workName, "subWorkName", subWorkName), nil, CppEnums.ChatType.System, CppEnums.ChatSystemType.Worker)
  elseif self._WORKTYPE.Upgrade == _workType then
  elseif self._WORKTYPE.RegionWork == _workType then
  elseif self._WORKTYPE.Harvest == _workType then
  end
end
function PaGlobal_WorkerManager_All:updateListData()
  if nil == Panel_Window_WorkerManager_All then
    return
  end
  if false == self._initialize then
    return
  end
  local list2 = self:getCurrentListControl()
  if nil == list2 or nil == list2:getElementManager() then
    return
  end
  local toIndex = list2:getCurrenttoIndex()
  local scrollvalue = 0
  if 0 ~= toIndex then
    self._lastTopIndex = toIndex
    scrollvalue = list2:GetVScroll():GetControlPos()
  end
  list2:getElementManager():clearKey()
  for index = 1, #self._filteredArray do
    list2:getElementManager():pushKey(index)
  end
  if 0 ~= self._lastTopIndex then
    list2:setCurrenttoIndex(self._lastTopIndex)
    list2:GetVScroll():SetControlPos(scrollvalue)
    self._lastTopIndex = 0
  end
end
function PaGlobal_WorkerManager_All:listCreate(content, key)
  if self._TAB.WORKER == self._selectTabIdx then
    self:workerlistCreate(content, key)
  elseif self._TAB.UPGRADE == self._selectTabIdx then
    self:upgradelistCreate(content, key)
  end
end
function PaGlobal_WorkerManager_All:workerlistCreate(content, key)
  if nil == Panel_Window_WorkerManager_All then
    return
  end
  local key32 = Int64toInt32(key)
  local index = self._filteredArray[key32]
  local workerWrapperLua = getWorkerWrapper(index)
  if nil == workerWrapperLua then
    return
  end
  local enum_grade = CppEnums.CharacterGradeType
  local stc_btnBg = UI.getChildControl(content, "Static_ListBG")
  local stc_slotGrade = {}
  stc_slotGrade[enum_grade.CharacterGradeType_Normal] = UI.getChildControl(stc_btnBg, "Static_WorkerImage_Slot_Normal")
  stc_slotGrade[enum_grade.CharacterGradeType_Elite] = UI.getChildControl(stc_btnBg, "Static_WorkerImage_Slot_Green")
  stc_slotGrade[enum_grade.CharacterGradeType_Hero] = UI.getChildControl(stc_btnBg, "Static_WorkerImage_Slot_Blue")
  stc_slotGrade[enum_grade.CharacterGradeType_Legend] = UI.getChildControl(stc_btnBg, "Static_WorkerImage_Slot_Yellow")
  stc_slotGrade[enum_grade.CharacterGradeType_Boss] = UI.getChildControl(stc_btnBg, "Static_WorkerImage_Slot_Orenge")
  local stc_image = UI.getChildControl(stc_btnBg, "Static_WorlerImage")
  local stc_expBg = UI.getChildControl(stc_btnBg, "Static_WorkerEXPProgress_BG")
  local progress_exp = UI.getChildControl(stc_btnBg, "Progress2_WorkerEXPProgress")
  local txt_workCtn = UI.getChildControl(stc_btnBg, "StaticText_WorkCount")
  local txt_name = UI.getChildControl(stc_btnBg, "StaticText_WorkerLevelName")
  local stc_mark_lvup = UI.getChildControl(stc_btnBg, "StaticText_LvupMark")
  local stc_mark_skil = UI.getChildControl(stc_btnBg, "StaticText_NewSkillMark")
  local txt_town = UI.getChildControl(stc_btnBg, "StaticText_BelongTown")
  local stc_workingBg = UI.getChildControl(stc_btnBg, "Static_WorkingProgress_BG")
  local progress_working = UI.getChildControl(stc_btnBg, "Progress2_WorkingProgress")
  local txt_working = UI.getChildControl(stc_btnBg, "StaticText_WorkingStatus")
  local stc_repeat = {
    btn = UI.getChildControl(stc_btnBg, "Button_WorkStop"),
    icon = UI.getChildControl(stc_btnBg, "Static_Repeat_Icon")
  }
  local stc_stop = {
    btn = UI.getChildControl(stc_btnBg, "Button_WorkStop"),
    icon = UI.getChildControl(stc_btnBg, "Static_Stop_Icon")
  }
  local stc_restore = {
    btn = UI.getChildControl(stc_btnBg, "Button_WorkRestore"),
    icon = UI.getChildControl(stc_btnBg, "Static_Icon_WorkRestore")
  }
  local stc_fire = {
    btn = UI.getChildControl(stc_btnBg, "Button_WorkerFire"),
    icon = UI.getChildControl(stc_btnBg, "Static_Icon_WorkerFire")
  }
  local stc_cancle = {
    btn = UI.getChildControl(stc_btnBg, "Button_CancelWorkerRepeat"),
    icon = UI.getChildControl(stc_btnBg, "Static_Icon_CancelWorkerRepeat")
  }
  local stc_changeSkill = {
    btn = UI.getChildControl(stc_btnBg, "Button_ChangeWorkerSkill"),
    icon = UI.getChildControl(stc_btnBg, "Static_Icon_ChangeWorkerSkill")
  }
  stc_btnBg:SetIgnore(true)
  stc_mark_lvup:SetShow(false)
  stc_mark_skil:SetShow(false)
  stc_stop.btn:SetShow(false)
  stc_stop.icon:SetShow(false)
  stc_repeat.btn:SetShow(false)
  stc_repeat.icon:SetShow(false)
  progress_exp:SetProgressRate(0)
  progress_working:SetProgressRate(0)
  stc_slotGrade[enum_grade.CharacterGradeType_Normal]:SetShow(false)
  stc_slotGrade[enum_grade.CharacterGradeType_Elite]:SetShow(false)
  stc_slotGrade[enum_grade.CharacterGradeType_Hero]:SetShow(false)
  stc_slotGrade[enum_grade.CharacterGradeType_Legend]:SetShow(false)
  stc_slotGrade[enum_grade.CharacterGradeType_Boss]:SetShow(false)
  stc_restore.btn:SetMonoTone(false, true)
  stc_restore.icon:SetMonoTone(false, true)
  stc_cancle.btn:SetMonoTone(true, true)
  stc_cancle.icon:SetMonoTone(true, true)
  stc_changeSkill.btn:SetMonoTone(true, true)
  stc_changeSkill.icon:SetMonoTone(true, true)
  stc_restore.btn:addInputEvent("Mouse_On", "HandleEventOnOut_WorkerManager_ButtonSimpleTooltip(true," .. tostring(key32) .. "," .. self._BUTTON.RESTORE .. " )")
  stc_restore.btn:addInputEvent("Mouse_Out", "HandleEventOnOut_WorkerManager_ButtonSimpleTooltip(false," .. tostring(key32) .. "," .. self._BUTTON.RESTORE .. " )")
  stc_fire.btn:addInputEvent("Mouse_On", "HandleEventOnOut_WorkerManager_ButtonSimpleTooltip(true," .. tostring(key32) .. "," .. self._BUTTON.FIRE .. " )")
  stc_fire.btn:addInputEvent("Mouse_Out", "HandleEventOnOut_WorkerManager_ButtonSimpleTooltip(false," .. tostring(key32) .. "," .. self._BUTTON.FIRE .. " )")
  stc_cancle.btn:addInputEvent("Mouse_On", "HandleEventOnOut_WorkerManager_ButtonSimpleTooltip(true," .. tostring(key32) .. "," .. self._BUTTON.CANCLE .. " )")
  stc_cancle.btn:addInputEvent("Mouse_Out", "HandleEventOnOut_WorkerManager_ButtonSimpleTooltip(false," .. tostring(key32) .. "," .. self._BUTTON.CANCLE .. " )")
  stc_changeSkill.btn:addInputEvent("Mouse_On", "HandleEventOnOut_WorkerManager_ButtonSimpleTooltip(true," .. tostring(key32) .. "," .. self._BUTTON.SKILL .. " )")
  stc_changeSkill.btn:addInputEvent("Mouse_Out", "HandleEventOnOut_WorkerManager_ButtonSimpleTooltip(false," .. tostring(key32) .. "," .. self._BUTTON.SKILL .. " )")
  stc_image:addInputEvent("Mouse_On", "HandleEventOnOut_WorkerManager_WorkerInfoTooltip(true," .. tostring(key32) .. ")")
  stc_image:addInputEvent("Mouse_Out", "HandleEventOnOut_WorkerManager_WorkerInfoTooltip(false," .. tostring(key32) .. ")")
  stc_restore.btn:addInputEvent("Mouse_LUp", "HandleEventLUp_WorkerManager_All_RestoreWorkerOpen(" .. tostring(key32) .. ")")
  stc_fire.btn:addInputEvent("Mouse_LUp", "HandleEventLUp_WorkerManager_All_FireWorker(" .. tostring(key32) .. ")")
  stc_stop.btn:addInputEvent("Mouse_LUp", "")
  stc_repeat.btn:addInputEvent("Mouse_LUp", "")
  stc_cancle.btn:addInputEvent("Mouse_LUp", "")
  stc_changeSkill.btn:addInputEvent("Mouse_LUp", "")
  local workerLv = "<PAColor0xffffedd4>" .. PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_LV") .. "." .. workerWrapperLua:getLevel() .. "<PAOldColor>"
  local workerName = workerWrapperLua:getGradeToColorString() .. workerWrapperLua:getName() .. "<PAOldColor>"
  txt_name:SetText(workerLv .. " " .. workerName)
  local workerGrade = workerWrapperLua:getGrade()
  if nil ~= stc_slotGrade[workerGrade] then
    stc_slotGrade[workerGrade]:SetShow(true)
  end
  stc_image:ChangeTextureInfoName(workerWrapperLua:getWorkerIcon())
  local nodeDesc = workerWrapperLua:getWorkingNodeDesc()
  local workName = workerWrapperLua:getWorkString()
  if "" == nodeDesc then
    txt_town:SetText(nodeDesc .. workName)
  else
    txt_town:SetText(nodeDesc)
  end
  if index == self._upgradingWorkerNoRaw then
    txt_town:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_WORKERLUAWRAPPER_WORKER_UPGRADE"))
  end
  local isWorking = workerWrapperLua:isWorking()
  if true == isWorking then
    local workingLeftPercent = workerWrapperLua:currentProgressPercents()
    progress_working:SetProgressRate(workingLeftPercent)
    if index == self._upgradingWorkerNoRaw then
      local working_LeftTime = workerWrapperLua:getLeftWorkingTimeXXX(getServerUtc64())
      txt_working:SetText(Util.Time.timeFormatting(math.ceil(working_LeftTime / 1000)))
    else
      txt_working:SetText(workName)
    end
    local workerWorkingPrimitiveWrapper = workerWrapperLua:getWorkerRepeatableWorkingWrapper()
    if nil ~= workerWorkingPrimitiveWrapper and CppEnums.NpcWorkingType.eNpcWorkingType_Upgrade ~= workerWorkingPrimitiveWrapper:getType() then
      stc_stop.btn:addInputEvent("Mouse_LUp", "HandleEventLUp_WorkerManager_All_StopWorking(" .. tostring(key32) .. ")")
      stc_stop.btn:SetShow(true)
      stc_stop.icon:SetShow(true)
    end
  else
    txt_working:SetText("")
    if true == workerWrapperLua:isWorkerRepeatable() then
      local workerWorkingPrimitiveWrapper = workerWrapperLua:getWorkerRepeatableWorkingWrapper()
      if nil ~= workerWorkingPrimitiveWrapper and CppEnums.NpcWorkingType.eNpcWorkingType_Upgrade ~= workerWorkingPrimitiveWrapper:getType() then
        stc_repeat.btn:SetShow(true)
        stc_repeat.icon:SetShow(true)
        stc_repeat.btn:addInputEvent("Mouse_LUp", "HandleEventLUp_WorkerManager_All_RepeatWorking(" .. tostring(key32) .. ")")
      end
    end
  end
  local actionPoint_Per = workerWrapperLua:getActionPointPercents()
  local actionPoint = workerWrapperLua:getActionPointXXX()
  local actionPoint_Max = workerWrapperLua:getMaxActionPoint()
  progress_exp:SetProgressRate(actionPoint_Per)
  txt_workCtn:SetText(tostring(actionPoint) .. "/" .. tostring(actionPoint_Max))
  if actionPoint >= actionPoint_Max then
    stc_restore.btn:addInputEvent("Mouse_LUp", "")
    stc_restore.btn:SetMonoTone(true, true)
    stc_restore.icon:SetMonoTone(true, true)
  end
  local currentActionPoint = workerWrapperLua:getActionPoint()
  if false == isWorking then
    if true == workerWrapperLua:isWorkerRepeatable() and 0 < currentActionPoint then
      stc_cancle.btn:addInputEvent("Mouse_LUp", "HandleEventLUp_WorkerManager_All_ResetRepeatWork(" .. tostring(key32) .. ")")
      stc_cancle.btn:SetMonoTone(false, true)
      stc_cancle.icon:SetMonoTone(false, true)
    else
      stc_repeat.btn:SetShow(false)
      stc_repeat.icon:SetShow(false)
    end
  end
  if true == workerWrapperLua:checkPossibleChangesSkillKey() then
    stc_changeSkill.btn:addInputEvent("Mouse_LUp", "HandleEventLUp_WorkerManager_All_ChangeSkillOpen(" .. tostring(key32) .. ")")
    stc_changeSkill.btn:SetMonoTone(false, true)
    stc_changeSkill.icon:SetMonoTone(false, true)
  end
  local isAuction = workerWrapperLua:getIsAuctionInsert()
  if true == isAuction then
    stc_repeat.btn:SetShow(false)
    stc_repeat.icon:SetShow(false)
    stc_stop.btn:SetShow(false)
    stc_stop.icon:SetShow(false)
    stc_restore.btn:SetMonoTone(true, true)
    stc_restore.icon:SetMonoTone(true, true)
    stc_restore.btn:addInputEvent("Mouse_LUp", "")
    stc_cancle.btn:SetMonoTone(true, true)
    stc_cancle.icon:SetMonoTone(true, true)
    stc_cancle.btn:addInputEvent("Mouse_LUp", "")
  end
  if true == stc_stop.icon:GetShow() then
    stc_stop.btn:addInputEvent("Mouse_On", "HandleEventOnOut_WorkerManager_ButtonSimpleTooltip(true," .. tostring(key32) .. "," .. self._BUTTON.STOP .. " )")
    stc_stop.btn:addInputEvent("Mouse_Out", "HandleEventOnOut_WorkerManager_ButtonSimpleTooltip(false," .. tostring(key32) .. "," .. self._BUTTON.STOP .. " )")
  elseif true == stc_repeat.icon:GetShow() then
    stc_repeat.btn:addInputEvent("Mouse_On", "HandleEventOnOut_WorkerManager_ButtonSimpleTooltip(true," .. tostring(key32) .. "," .. self._BUTTON.REPEAT .. " )")
    stc_repeat.btn:addInputEvent("Mouse_Out", "HandleEventOnOut_WorkerManager_ButtonSimpleTooltip(false," .. tostring(key32) .. "," .. self._BUTTON.REPEAT .. " )")
  end
  if true == self._isPadSnap then
    stc_repeat.btn:SetShow(false)
    stc_repeat.icon:SetShow(false)
    stc_stop.btn:SetShow(false)
    stc_stop.icon:SetShow(false)
    stc_btnBg:SetIgnore(false)
    stc_image:SetIgnore(false)
    stc_restore.btn:SetShow(false)
    stc_fire.btn:SetShow(false)
    stc_cancle.btn:SetShow(false)
    stc_changeSkill.btn:SetShow(false)
    txt_name:SetTextMode(__eTextMode_LimitText)
    txt_name:SetText(txt_name:GetText())
    txt_town:SetTextMode(__eTextMode_LimitText)
    txt_town:SetText(txt_town:GetText())
    txt_working:SetTextMode(__eTextMode_LimitText)
    txt_working:SetText(txt_working:GetText())
    stc_btnBg:addInputEvent("Mouse_On", "HandleEventOnOut_WorkerManager_All_ShowDetailMenuGuide(true)")
    stc_btnBg:addInputEvent("Mouse_Out", "HandleEventOnOut_WorkerManager_All_ShowDetailMenuGuide(false)")
    stc_btnBg:registerPadEvent(__eConsoleUIPadEvent_Up_A, "HandlePadEventA_WorkerManager_All_ToggleDetailMenu(" .. tostring(key32) .. ")")
    stc_btnBg:registerPadEvent(__eConsoleUIPadEvent_DpadUp, "HandlePadEventDpad_WorkerManager_All_CloseDetailMenu()")
    stc_btnBg:registerPadEvent(__eConsoleUIPadEvent_DpadDown, "HandlePadEventDpad_WorkerManager_All_CloseDetailMenu()")
  else
    UI.setLimitTextAndAddTooltip(txt_name)
    UI.setLimitTextAndAddTooltip(txt_town)
    UI.setLimitTextAndAddTooltip(txt_working)
    stc_btnBg:SetIgnore(true)
  end
end
function PaGlobal_WorkerManager_All:upgradelistCreate(content, key)
  if nil == Panel_Window_WorkerManager_All then
    return
  end
  local key32 = Int64toInt32(key)
  local index = self._filteredArray[key32]
  local workerWrapperLua = getWorkerWrapper(index)
  if nil == workerWrapperLua then
    return
  end
  local enum_grade = CppEnums.CharacterGradeType
  local stc_btnBg = UI.getChildControl(content, "Static_ListBG")
  local stc_slotGrade = {}
  stc_slotGrade[enum_grade.CharacterGradeType_Normal] = UI.getChildControl(stc_btnBg, "Static_WorkerImage_Slot_Normal")
  stc_slotGrade[enum_grade.CharacterGradeType_Elite] = UI.getChildControl(stc_btnBg, "Static_WorkerImage_Slot_Green")
  stc_slotGrade[enum_grade.CharacterGradeType_Hero] = UI.getChildControl(stc_btnBg, "Static_WorkerImage_Slot_Blue")
  stc_slotGrade[enum_grade.CharacterGradeType_Legend] = UI.getChildControl(stc_btnBg, "Static_WorkerImage_Slot_Yellow")
  stc_slotGrade[enum_grade.CharacterGradeType_Boss] = UI.getChildControl(stc_btnBg, "Static_WorkerImage_Slot_Orenge")
  local stc_image = UI.getChildControl(stc_btnBg, "Static_WorlerImage")
  local stc_expBg = UI.getChildControl(stc_btnBg, "Static_WorkerEXPProgress_BG")
  local progress_exp = UI.getChildControl(stc_btnBg, "Progress2_WorkerEXPProgress")
  local txt_workCtn = UI.getChildControl(stc_btnBg, "StaticText_WorkCount")
  local txt_name = UI.getChildControl(stc_btnBg, "StaticText_WorkerLevelName")
  local txt_town = UI.getChildControl(stc_btnBg, "StaticText_BelongTown")
  local stc_workingBg = UI.getChildControl(stc_btnBg, "Static_WorkingProgress_BG")
  local progress_working = UI.getChildControl(stc_btnBg, "Progress2_WorkingProgress")
  local txt_working = UI.getChildControl(stc_btnBg, "StaticText_WorkingStatus")
  local btn_advence = UI.getChildControl(stc_btnBg, "Button_Advence")
  local stc_advenceCount = UI.getChildControl(stc_btnBg, "StaticText_AdvenceCount")
  local stc_stop = {
    btn = UI.getChildControl(stc_btnBg, "Button_WorkStop"),
    icon = UI.getChildControl(stc_btnBg, "Static_Stop_Icon")
  }
  stc_stop.btn:SetShow(false)
  stc_stop.icon:SetShow(false)
  progress_exp:SetProgressRate(0)
  progress_working:SetProgressRate(0)
  stc_slotGrade[enum_grade.CharacterGradeType_Normal]:SetShow(false)
  stc_slotGrade[enum_grade.CharacterGradeType_Elite]:SetShow(false)
  stc_slotGrade[enum_grade.CharacterGradeType_Hero]:SetShow(false)
  stc_slotGrade[enum_grade.CharacterGradeType_Legend]:SetShow(false)
  stc_slotGrade[enum_grade.CharacterGradeType_Boss]:SetShow(false)
  btn_advence:SetTextMode(__eTextMode_AutoWrap)
  btn_advence:SetText(btn_advence:GetText())
  stc_stop.btn:addInputEvent("Mouse_LUp", "")
  stc_image:addInputEvent("Mouse_On", "HandleEventOnOut_WorkerManager_WorkerInfoTooltip(true," .. tostring(key32) .. ")")
  stc_image:addInputEvent("Mouse_Out", "HandleEventOnOut_WorkerManager_WorkerInfoTooltip(false," .. tostring(key32) .. ")")
  btn_advence:addInputEvent("Mouse_On", "HandleEventOnOut_WorkerManager_ButtonSimpleTooltip(true," .. tostring(key32) .. "," .. self._BUTTON.UPGRADE .. " )")
  btn_advence:addInputEvent("Mouse_Out", "HandleEventOnOut_WorkerManager_ButtonSimpleTooltip(false," .. tostring(key32) .. "," .. self._BUTTON.UPGRADE .. " )")
  local workerLv = "<PAColor0xffffedd4>" .. PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_LV") .. "." .. workerWrapperLua:getLevel() .. "<PAOldColor>"
  local workerName = workerWrapperLua:getGradeToColorString() .. workerWrapperLua:getName() .. "<PAOldColor>"
  txt_name:SetText(workerLv .. " " .. workerName)
  local workerGrade = workerWrapperLua:getGrade()
  if nil ~= stc_slotGrade[workerGrade] then
    stc_slotGrade[workerGrade]:SetShow(true)
  end
  stc_image:ChangeTextureInfoName(workerWrapperLua:getWorkerIcon())
  local nodeDesc = workerWrapperLua:getWorkingNodeDesc()
  local workName = workerWrapperLua:getWorkString()
  if "" == nodeDesc then
    txt_town:SetText(nodeDesc .. workName)
  else
    txt_town:SetText(nodeDesc)
  end
  if index == self._upgradingWorkerNoRaw then
    txt_town:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_WORKERLUAWRAPPER_WORKER_UPGRADE"))
  end
  local actionPoint_Per = workerWrapperLua:getActionPointPercents()
  local actionPoint = workerWrapperLua:getActionPointXXX()
  local actionPoint_Max = workerWrapperLua:getMaxActionPoint()
  local currentActionPoint = workerWrapperLua:getActionPoint()
  progress_exp:SetProgressRate(actionPoint_Per)
  txt_workCtn:SetText(tostring(actionPoint) .. "/" .. tostring(actionPoint_Max))
  local isWorking = workerWrapperLua:isWorking()
  if true == isWorking then
    local workingLeftPercent = workerWrapperLua:currentProgressPercents()
    progress_working:SetProgressRate(workingLeftPercent)
    if index == self._upgradingWorkerNoRaw then
      local working_LeftTime = workerWrapperLua:getLeftWorkingTimeXXX(getServerUtc64())
      txt_working:SetText(Util.Time.timeFormatting(math.ceil(working_LeftTime / 1000)))
    else
      txt_working:SetText(workName)
    end
    local workerWorkingPrimitiveWrapper = workerWrapperLua:getWorkerRepeatableWorkingWrapper()
    if nil ~= workerWorkingPrimitiveWrapper and CppEnums.NpcWorkingType.eNpcWorkingType_Upgrade ~= workerWorkingPrimitiveWrapper:getType() then
      stc_stop.btn:addInputEvent("Mouse_LUp", "HandleEventLUp_WorkerManager_All_StopWorking(" .. tostring(key32) .. ")")
      stc_stop.btn:SetShow(true)
      stc_stop.icon:SetShow(true)
    end
  else
    txt_working:SetText("")
  end
  local workerUpgradeCount = workerWrapperLua:getUpgradePoint()
  local isAuction = workerWrapperLua:getIsAuctionInsert()
  local isUpgradable = false
  stc_advenceCount:SetShow(true)
  stc_advenceCount:SetColor(Defines.Color.C_FFDDC39E)
  stc_advenceCount:SetText(workerUpgradeCount)
  if -1 == self._upgradingWorkerNoRaw and 0 < workerUpgradeCount and true == workerWrapperLua:isUpgradable() then
    if true ~= isWorking then
      isUpgradable = true
    else
      isUpgradable = false
    end
  else
    if true == isAuction then
      isUpgradable = false
    end
    if false == workerWrapperLua:isUpgradable() then
      stc_advenceCount:SetText(0)
    end
  end
  if 30 == workerLv and 0 == workerUpgradeCount or nil ~= workerWrapperLua:getWorkerDefaultSkillStaticStatus() or CppEnums.CharacterGradeType.CharacterGradeType_Boss == workerWrapperLua:getGrade() then
    isUpgradable = false
    stc_advenceCount:SetShow(false)
  end
  if true == self._isPadSnap then
    stc_stop.btn:SetShow(false)
    stc_stop.icon:SetShow(false)
    stc_btnBg:SetIgnore(false)
    stc_image:SetIgnore(false)
    btn_advence:SetIgnore(true)
    txt_name:SetTextMode(__eTextMode_LimitText)
    txt_name:SetText(txt_name:GetText())
    txt_town:SetTextMode(__eTextMode_LimitText)
    txt_town:SetText(txt_town:GetText())
    txt_working:SetTextMode(__eTextMode_LimitText)
    txt_working:SetText(txt_working:GetText())
    if true == isUpgradable then
      btn_advence:SetMonoTone(false, true)
      stc_btnBg:registerPadEvent(__eConsoleUIPadEvent_Up_A, "HandleEventLUp_WorkerManager_All_UpgradeWorker(" .. tostring(key32) .. ")")
      stc_btnBg:addInputEvent("Mouse_On", "HandleEventOnOut_WorkerManager_ShowPromoteKeyGuide(true, true)")
      stc_btnBg:addInputEvent("Mouse_Out", "HandleEventOnOut_WorkerManager_ShowPromoteKeyGuide(false, true)")
    else
      btn_advence:SetMonoTone(true, true)
      stc_btnBg:registerPadEvent(__eConsoleUIPadEvent_Up_A, "")
      stc_btnBg:addInputEvent("Mouse_On", "HandleEventOnOut_WorkerManager_ShowPromoteKeyGuide(true, false)")
      stc_btnBg:addInputEvent("Mouse_Out", "HandleEventOnOut_WorkerManager_ShowPromoteKeyGuide(false, false)")
    end
  else
    UI.setLimitTextAndAddTooltip(txt_name)
    UI.setLimitTextAndAddTooltip(txt_town)
    UI.setLimitTextAndAddTooltip(txt_working)
    stc_btnBg:SetIgnore(true)
    if true == isUpgradable then
      btn_advence:SetMonoTone(false, true)
      btn_advence:addInputEvent("Mouse_LUp", "HandleEventLUp_WorkerManager_All_UpgradeWorker(" .. tostring(key32) .. ")")
    else
      btn_advence:SetMonoTone(true, true)
      btn_advence:addInputEvent("Mouse_LUp", "")
    end
  end
end
function PaGlobal_WorkerManager_All:detailMenuSet(workerIdx)
  local workerWrapperLua = getWorkerWrapper(self._filteredArray[workerIdx], false)
  local workerNoRaw = self._filteredArray[workerIdx]
  for index = 1, #self._detailBtnlist do
    self._detailBtnlist[index]:SetShow(false)
  end
  local isWorking = workerWrapperLua:isWorking()
  if true == isWorking then
    self._ui_console.btn_workCancle:SetShow(true)
    self._ui_console.btn_workCancle:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_WORKERMANAGER_TOOLTIP_STOP_NAME"))
    self._ui_console.btn_workCancle:registerPadEvent(__eConsoleUIPadEvent_Up_A, "HandleEventLUp_WorkerManager_All_StopWorking(" .. tostring(workerIdx) .. ")")
  else
    self._ui_console.btn_workCancle:SetShow(true)
    self._ui_console.btn_workCancle:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_WORKERMANAGER_TOOLTIP_REPEAT_NAME"))
    self._ui_console.btn_workCancle:registerPadEvent(__eConsoleUIPadEvent_Up_A, "HandleEventLUp_WorkerManager_All_RepeatWorking(" .. tostring(workerIdx) .. ")")
  end
  local currentActionPoint = workerWrapperLua:getActionPoint()
  if false == isWorking then
    if true == workerWrapperLua:isWorkerRepeatable() and 0 < currentActionPoint then
      local workerWorkingPrimitiveWrapper = workerWrapperLua:getWorkerRepeatableWorkingWrapper()
      if CppEnums.NpcWorkingType.eNpcWorkingType_Upgrade ~= workerWorkingPrimitiveWrapper:getType() then
        self._ui_console.btn_repeatReset:SetShow(true)
        self._ui_console.btn_repeatReset:registerPadEvent(__eConsoleUIPadEvent_Up_A, "HandleEventLUp_WorkerManager_All_ResetRepeatWork(" .. tostring(workerIdx) .. ")")
      else
        self._ui_console.btn_workCancle:SetShow(false)
        self._ui_console.btn_workCancle:registerPadEvent(__eConsoleUIPadEvent_Up_A, "")
      end
    else
      self._ui_console.btn_workCancle:SetShow(false)
      self._ui_console.btn_workCancle:registerPadEvent(__eConsoleUIPadEvent_Up_A, "")
    end
  end
  local actionPoint = workerWrapperLua:getActionPointXXX()
  local actionPoint_Max = workerWrapperLua:getMaxActionPoint()
  if actionPoint >= actionPoint_Max then
    self._ui_console.btn_restore:SetShow(false)
    self._ui_console.btn_restore:registerPadEvent(__eConsoleUIPadEvent_Up_A, "")
  else
    self._ui_console.btn_restore:SetShow(true)
    self._ui_console.btn_restore:registerPadEvent(__eConsoleUIPadEvent_Up_A, "HandlePadEventA_WorkerManager_All_RestoreWorkerOpen(" .. tostring(workerIdx) .. ")")
  end
  if true == workerWrapperLua:checkPossibleChangesSkillKey() then
    self._ui_console.btn_changeSkill:SetShow(true)
    self._ui_console.btn_changeSkill:registerPadEvent(__eConsoleUIPadEvent_Up_A, "HandleEventLUp_WorkerManager_All_ChangeSkillOpen(" .. tostring(workerIdx) .. ")")
  else
    self._ui_console.btn_changeSkill:SetShow(false)
    self._ui_console.btn_changeSkill:registerPadEvent(__eConsoleUIPadEvent_Up_A, "")
  end
  self._ui_console.btn_fire:SetShow(true)
  self._ui_console.btn_fire:registerPadEvent(__eConsoleUIPadEvent_Up_A, "HandleEventLUp_WorkerManager_All_FireWorker(" .. tostring(workerIdx) .. ")")
  local isAuction = workerWrapperLua:getIsAuctionInsert()
  if true == isAuction then
    self._ui_console.btn_repeatReset:SetShow(false)
    self._ui_console.btn_repeatReset:registerPadEvent(__eConsoleUIPadEvent_Up_A, "")
    self._ui_console.btn_workCancle:SetShow(false)
    self._ui_console.btn_workCancle:registerPadEvent(__eConsoleUIPadEvent_Up_A, "")
  end
  local gabY = 10
  local btnShowCnt = 0
  local startPosY = self._ui_console.stc_detailMenu:GetPosY() + 60
  local btnSizeY = self._ui_console.btn_restore:GetSizeY() + gabY
  for index = 1, #self._detailBtnlist do
    if true == self._detailBtnlist[index]:GetShow() then
      btnShowCnt = btnShowCnt + 1
      self._detailBtnlist[index]:SetPosY(btnSizeY * (btnShowCnt - 1))
    end
  end
  local detailMenuSizeY = (self._ui_console.btn_workCancle:GetSizeY() + gabY) * btnShowCnt + 50
  self._ui_console.stc_menuBg:SetSize(self._ui_console.stc_menuBg:GetSizeX(), detailMenuSizeY - 50)
  self._ui_console.stc_detailMenu:SetSize(self._ui_console.stc_detailMenu:GetSizeX(), detailMenuSizeY)
  self._ui_console.stc_menuBg:ComputePos()
  self._ui_console.stc_guideBg_menu:ComputePos()
end
