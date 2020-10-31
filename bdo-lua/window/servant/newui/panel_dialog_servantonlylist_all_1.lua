function PaGlobal_ServantOnlyList_All:initialize()
  if nil == Panel_Dialog_ServantOnlyList_All or true == self._initailize then
    return
  end
  self._ui._txt_Title = UI.getChildControl(Panel_Dialog_ServantOnlyList_All, "Static_TitleBar")
  self._ui._txt_ServantListTitle = UI.getChildControl(Panel_Dialog_ServantOnlyList_All, "StaticText_ServantListTitle")
  self._ui._txt_ServantListValue = UI.getChildControl(Panel_Dialog_ServantOnlyList_All, "StaticText_ServantListValue")
  self._ui._list2_Servant = UI.getChildControl(Panel_Dialog_ServantOnlyList_All, "List2_Servant")
  self._ui._btn_Regist = UI.getChildControl(Panel_Dialog_ServantOnlyList_All, "Button_Regist")
  self._ui_stc_BlockBG = UI.getChildControl(Panel_Dialog_ServantOnlyList_All, "Static_BlockBG")
  self._ui._btn_Close = UI.getChildControl(Panel_Dialog_ServantOnlyList_All, "Button_Close")
  self._ui._stc_Bottom_ConsoleKeyGuide = UI.getChildControl(Panel_Dialog_ServantOnlyList_All, "Static_BottomBg_ConsoleUI")
  self._ui._stc_KeyGuide_A = UI.getChildControl(self._ui._stc_Bottom_ConsoleKeyGuide, "StaticText_A_ConsoleUI")
  self._ui._stc_KeyGuide_Y = UI.getChildControl(self._ui._stc_Bottom_ConsoleKeyGuide, "StaticText_Y_ConsoleUI")
  self._ui._stc_KeyGuide_B = UI.getChildControl(self._ui._stc_Bottom_ConsoleKeyGuide, "StaticText_B_ConsoleUI")
  local list2Content = UI.getChildControl(self._ui._list2_Servant, "List2_1_Content")
  self._ui._list2_locate_Temp = UI.getChildControl(list2Content, "StaticText_Locate")
  self._ui._list2_leftMating_Temp = UI.getChildControl(list2Content, "StaticText_State")
  self._isConsole = _ContentsGroup_UsePadSnapping
  PaGlobal_ServantOnlyList_All:validate()
  PaGlobal_ServantOnlyList_All:isConsoleUI(self._isConsole)
  PaGlobal_ServantOnlyList_All:registerEventHandler(self._isConsole)
end
function PaGlobal_ServantOnlyList_All:validate()
  if nil == Panel_Dialog_ServantOnlyList_All then
    return
  end
  self._ui._txt_Title:isValidate()
  self._ui._txt_ServantListTitle:isValidate()
  self._ui._txt_ServantListValue:isValidate()
  self._ui._list2_Servant:isValidate()
  self._ui._btn_Regist:isValidate()
  self._ui_stc_BlockBG:isValidate()
  self._ui._btn_Close:isValidate()
  self._ui._stc_Bottom_ConsoleKeyGuide:isValidate()
  self._ui._stc_KeyGuide_A:isValidate()
  self._initailize = true
end
function PaGlobal_ServantOnlyList_All:registerEventHandler(isConsole)
  if nil == Panel_Dialog_ServantOnlyList_All or false == self._initailize then
    return
  end
  registerEvent("onScreenResize", "FromClient_ServantOnlyList_All_OnScreenResize")
  self._ui._list2_Servant:registEvent(__ePAUIList2EventType_LuaChangeContent, "FromClient_ServantOnlyList_All_List2Update")
  self._ui._list2_Servant:createChildContent(__ePAUIList2ElementManagerType_List)
  self._ui._btn_Close:addInputEvent("Mouse_LUp", "PaGlobalFunc_ServantOnlyList_All_Close()")
  self._ui._btn_Regist:addInputEvent("Mouse_LUp", "PaGlobalFunc_ServantOnlyList_All_MatingStart()")
  if false == isConsole then
  else
    Panel_Dialog_ServantOnlyList_All:ignorePadSnapMoveToOtherPanel()
    Panel_Dialog_ServantOnlyList_All:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "PaGlobalFunc_ServantOnlyList_All_MatingStart()")
  end
end
function PaGlobal_ServantOnlyList_All:isConsoleUI(isConsole)
  if nil == Panel_Dialog_ServantOnlyList_All or false == self._initailize then
    return
  end
  self._ui._stc_Bottom_ConsoleKeyGuide:SetShow(isConsole)
  self._ui._btn_Regist:SetShow(not isConsole)
  self._ui._btn_Close:SetShow(not isConsole)
  if true == isConsole then
    local btnSize = self._ui._btn_Close:GetSizeY() + 10
    Panel_Dialog_ServantOnlyList_All:SetSize(Panel_Dialog_ServantOnlyList_All:GetSizeX(), Panel_Dialog_ServantOnlyList_All:GetSizeY() - btnSize)
    self._ui._stc_Bottom_ConsoleKeyGuide:SetPosY(Panel_Dialog_ServantOnlyList_All:GetSizeY())
    local keyGuide = {
      self._ui._stc_KeyGuide_Y,
      self._ui._stc_KeyGuide_A,
      self._ui._stc_KeyGuide_B
    }
    PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyGuide, self._ui._stc_Bottom_ConsoleKeyGuide, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP)
  end
end
function PaGlobal_ServantOnlyList_All:prepareOpen()
  if nil == Panel_Dialog_ServantOnlyList_All or true == Panel_Dialog_ServantOnlyList_All:GetShow() then
    return
  end
  Panel_Dialog_ServantOnlyList_All:SetHorizonCenter()
  Panel_Dialog_ServantOnlyList_All:SetVerticalMiddle()
  Panel_Dialog_ServantOnlyList_All:ComputePos()
  self._ui_stc_BlockBG:SetSize(getScreenSizeX(), getScreenSizeY())
  self._ui_stc_BlockBG:ComputePos()
  FromClient_ServantOnlyList_All_OnScreenResize()
  PaGlobal_ServantOnlyList_All:open()
  PaGlobal_ServantOnlyList_All:update()
end
function PaGlobal_ServantOnlyList_All:open()
  if nil == Panel_Dialog_ServantOnlyList_All or true == Panel_Dialog_ServantOnlyList_All:GetShow() then
    return
  end
  Panel_Dialog_ServantOnlyList_All:SetShow(true)
end
function PaGlobal_ServantOnlyList_All:update()
  if nil == Panel_Dialog_ServantOnlyList_All or false == Panel_Dialog_ServantOnlyList_All:GetShow() then
    return
  end
  if nil == getSelfPlayer then
    return
  end
  self._ui._list2_Servant:getElementManager():clearKey()
  if true == PaGlobalFunc_ServantFunction_All_GetIsGuild() then
    return
  end
  local servantCount = stable_count()
  if 0 == servantCount then
    return
  end
  local sealedCount = stable_currentSlotCount()
  local unsealedCount = stable_currentRegionSlotCountAll() - sealedCount + Int64toInt32(stable_currentRegionSlotCountOfOtherCharacter())
  self._ui._txt_ServantListValue:SetText(sealedCount + unsealedCount .. "/" .. stable_maxSlotCount())
  if unsealedCount < 0 then
    unsealedCount = math.abs(unsealedCount)
  end
  local regeionInfo = getRegionInfoByPosition(getSelfPlayer():get():getPosition())
  local regeionKey = regeionInfo:getRegionKey()
  self._servantTable = {}
  local otherServant = {}
  for ii = 0, servantCount - 1 do
    local servantInfo = stable_getServant(ii)
    if nil ~= servantInfo then
      local getState = servantInfo:getStateType()
      local servantRegeionKey = servantInfo:getRegionKeyRaw()
      local conditionCheck = {
        [0] = true,
        [1] = CppEnums.VehicleType.Type_Horse == servantInfo:getVehicleType() and false == servantInfo:isMale(),
        [2] = CppEnums.ServantStateType.Type_Rent ~= getState,
        [3] = not servantInfo:isChangingRegion(),
        [4] = CppEnums.ServantStateType.Type_StallionTraining ~= getState,
        [5] = CppEnums.ServantStateType.Type_SkillTraining ~= getState,
        [6] = not servantInfo:isPcroomOnly(),
        [7] = CppEnums.ServantStateType.Type_Coma ~= getState,
        [8] = CppEnums.ServantStateType.Type_RegisterMarket ~= getState,
        [9] = not servantInfo:isSeized(),
        [10] = not Defines.s64_const.s64_0 ~= servantInfo:getRentOwnerNo(),
        [11] = CppEnums.ServantStateType.Type_Mating ~= getState,
        [12] = 9 > servantInfo:getTier()
      }
      local isPassed = true
      for i = 0, #conditionCheck do
        if false == conditionCheck[i] then
          isPassed = false
          break
        end
      end
      local servantData = {
        servantNo = nil,
        isSameRegion = false,
        checkBtn = nil
      }
      if true == isPassed then
        servantData.servantNo = ii
        if regeionKey ~= servantRegeionKey then
          servantData.isSameRegion = false
          table.insert(otherServant, servantData)
        else
          servantData.isSameRegion = true
          table.insert(self._servantTable, servantData)
        end
      end
    end
  end
  local gotDiffRegion = false
  for i = 0, #otherServant do
    if nil ~= otherServant[i] then
      local servantData = otherServant[i]
      table.insert(self._servantTable, servantData)
    end
  end
  if nil ~= self._servantTable then
    for i = 1, #self._servantTable do
      if nil ~= self._servantTable[i] then
        self._ui._list2_Servant:getElementManager():pushKey(toInt64(0, i))
      end
    end
  end
end
function PaGlobal_ServantOnlyList_All:prepareClose()
  if nil == Panel_Dialog_ServantOnlyList_All or false == Panel_Dialog_ServantOnlyList_All:GetShow() then
    return
  end
  self._matingSlotIdx = nil
  self._currentSelectIdx = nil
  PaGlobal_ServantOnlyList_All:close()
end
function PaGlobal_ServantOnlyList_All:close()
  if nil == Panel_Dialog_ServantOnlyList_All or false == Panel_Dialog_ServantOnlyList_All:GetShow() then
    return
  end
  Panel_Dialog_ServantOnlyList_All:SetShow(false)
end
