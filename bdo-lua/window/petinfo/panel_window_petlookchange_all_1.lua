function PaGlobal_PetLookChange_All:initialize()
  if true == PaGlobal_PetLookChange_All._initialize then
    return
  end
  self._ui.stc_TitleBG = UI.getChildControl(Panel_Window_PetLookChange_All, "Static_TitleBG")
  self._ui_pc.btn_Title_Close = UI.getChildControl(self._ui.stc_TitleBG, "Button_Win_Close")
  self._ui_pc.btn_Title_Question = UI.getChildControl(self._ui.stc_TitleBG, "Button_Question")
  self._ui.stc_PetIconBG = UI.getChildControl(Panel_Window_PetLookChange_All, "Static_IconPetBG")
  self._ui.stc_PetIcon = UI.getChildControl(self._ui.stc_PetIconBG, "Static_IconPet")
  self._ui.txt_LookIndex = UI.getChildControl(self._ui.stc_PetIconBG, "StaticText_LookIndex")
  self._ui_pc.btn_Left = UI.getChildControl(self._ui.stc_PetIconBG, "Button_Left")
  self._ui_pc.btn_Right = UI.getChildControl(self._ui.stc_PetIconBG, "Button_Right")
  self._ui_console.stc_KeyGuideLB = UI.getChildControl(self._ui.stc_PetIconBG, "Button_Left_ConsoleUI")
  self._ui_console.stc_KeyGuideRB = UI.getChildControl(self._ui.stc_PetIconBG, "Button_Right_ConsoleUI")
  self._ui.list2_Pet = UI.getChildControl(Panel_Window_PetLookChange_All, "List2_RightBG")
  self._ui_pc.btn_Bottom_Change = UI.getChildControl(Panel_Window_PetLookChange_All, "Button_Change")
  self._ui_pc.btn_Bottom_Close = UI.getChildControl(Panel_Window_PetLookChange_All, "Button_Close")
  self._ui_console.stc_KeyGuideGroup = UI.getChildControl(Panel_Window_PetLookChange_All, "Static_Bottom_ConsoleUI")
  self._ui_console.txt_KeyGuideY = UI.getChildControl(self._ui_console.stc_KeyGuideGroup, "StaticText_ButtonY")
  self._ui_console.txt_KeyGuideA = UI.getChildControl(self._ui_console.stc_KeyGuideGroup, "StaticText_ButtonA")
  self._ui_console.txt_KeyGuideB = UI.getChildControl(self._ui_console.stc_KeyGuideGroup, "StaticText_ButtonB")
  self._isConsole = _ContentsGroup_UsePadSnapping
  Panel_Window_PetLookChange_All:setGlassBackground(true)
  Panel_Window_PetLookChange_All:ActiveMouseEventEffect(true)
  PaGlobal_PetLookChange_All:platformSetting()
  PaGlobal_PetLookChange_All:reposition()
  PaGlobal_PetLookChange_All:registEventHandler()
  PaGlobal_PetLookChange_All:validate()
  PaGlobal_PetLookChange_All._initialize = true
end
function PaGlobal_PetLookChange_All:platformSetting()
  if nil == Panel_Window_PetLookChange_All then
    return
  end
  for _, control in pairs(self._ui_pc) do
    control:SetShow(not self._isConsole)
  end
  for _, control in pairs(self._ui_console) do
    control:SetShow(self._isConsole)
  end
  if self._isConsole then
    local keyGuides = {
      self._ui_console.txt_KeyGuideY,
      self._ui_console.txt_KeyGuideA,
      self._ui_console.txt_KeyGuideB
    }
    PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyGuides, self._ui_console.stc_KeyGuideGroup, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHT)
    Panel_Window_PetLookChange_All:ignorePadSnapMoveToOtherPanel()
  end
end
function PaGlobal_PetLookChange_All:reposition()
  if nil == Panel_Window_PetLookChange_All then
    return
  end
  Panel_Window_PetLookChange_All:SetPosX(getOriginScreenSizeX() / 2 - Panel_Window_PetLookChange_All:GetSizeX() - 100)
  Panel_Window_PetLookChange_All:SetPosY(getOriginScreenSizeY() / 2 - Panel_Window_PetLookChange_All:GetSizeY() / 2 - 50)
end
function PaGlobal_PetLookChange_All:registEventHandler()
  if nil == Panel_Window_PetLookChange_All then
    return
  end
  registerEvent("FromClient_PetChangeLook", "FromClient_PetLookChange_Open_All")
  registerEvent("FromClient_PetLookChanged", "FromClient_PetLookChange_LookChanged_All")
  registerEvent("FromClient_PetAddSealedList", "FromClient_PetLookChange_SealPetCountChange_All")
  registerEvent("FromClient_PetDelSealedList", "FromClient_PetLookChange_SealPetCountChange_All")
  self._ui.list2_Pet:registEvent(__ePAUIList2EventType_LuaChangeContent, "PaGlobal_PetLookChange_ListCreate_All")
  self._ui.list2_Pet:createChildContent(__ePAUIList2ElementManagerType_List)
  if self._isConsole then
  else
    self._ui_pc.btn_Title_Question:addInputEvent("Mouse_LUp", "Panel_WebHelper_ShowToggle( \"Pet\" )")
    PaGlobal_Util_RegistHelpTooltipEvent(self._ui_pc.btn_Title_Question, "\"Pet\"")
    self._ui_pc.btn_Title_Close:addInputEvent("Mouse_LUp", "PaGlobal_PetLookChange_Close_All()")
    self._ui_pc.btn_Bottom_Close:addInputEvent("Mouse_LUp", "PaGlobal_PetLookChange_Close_All()")
  end
end
function PaGlobal_PetLookChange_All:prepareOpen(whereType, slotNo)
  if nil == Panel_Window_PetLookChange_All then
    return
  end
  self._petCount = self:getPetLookChangeableCount()
  if self._petCount <= 0 then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_PETLOOKCHANGE_NOPET"))
    return
  end
  self._whereType = whereType
  self._slotNo = slotNo
  if not Panel_Window_PetLookChange_All:GetShow() then
    PaGlobal_PetLookChange_All:reposition()
  end
  self._selectedPetIndex = 0
  self._selectedLookIndex = 0
  PaGlobal_PetLookChange_All:open()
  self:updatePetList()
  self:selectPet(self._selectedPetIndex)
end
function PaGlobal_PetLookChange_All:open()
  if nil == Panel_Window_PetLookChange_All then
    return
  end
  Panel_Window_PetLookChange_All:SetShow(true)
end
function PaGlobal_PetLookChange_All:prepareClose()
  if nil == Panel_Window_PetLookChange_All then
    return
  end
  PaGlobal_PetLookChange_All:close()
end
function PaGlobal_PetLookChange_All:close()
  if nil == Panel_Window_PetLookChange_All then
    return
  end
  Panel_Window_PetLookChange_All:SetShow(false)
end
function PaGlobal_PetLookChange_All:validate()
  if nil == Panel_Window_PetLookChange_All then
    return
  end
  self._ui.stc_TitleBG:isValidate()
  self._ui_pc.btn_Title_Close:isValidate()
  self._ui_pc.btn_Title_Question:isValidate()
  self._ui.stc_PetIconBG:isValidate()
  self._ui.stc_PetIcon:isValidate()
  self._ui.txt_LookIndex:isValidate()
  self._ui_pc.btn_Left:isValidate()
  self._ui_pc.btn_Right:isValidate()
  self._ui_console.stc_KeyGuideLB:isValidate()
  self._ui_console.stc_KeyGuideRB:isValidate()
  self._ui.list2_Pet:isValidate()
  self._ui_pc.btn_Bottom_Change:isValidate()
  self._ui_pc.btn_Bottom_Close:isValidate()
  self._ui_console.stc_KeyGuideGroup:isValidate()
  self._ui_console.txt_KeyGuideY:isValidate()
  self._ui_console.txt_KeyGuideB:isValidate()
end
function PaGlobal_PetLookChange_All:getPetLookChangeableCount()
  self._changableIndex = {}
  local lookChangablePetCount = 0
  for index = 0, ToClient_getPetSealedList() - 1 do
    local petData = ToClient_getPetSealedDataByIndex(index)
    if nil ~= petData then
      local petStaticStatus = petData:getPetStaticStatus()
      local lookcount = ToClient_getPetChangeLookCount(petStaticStatus)
      if 1 < lookcount then
        self._changableIndex[lookChangablePetCount] = index
        lookChangablePetCount = lookChangablePetCount + 1
      end
    end
  end
  return lookChangablePetCount
end
function PaGlobal_PetLookChange_All:updatePetList()
  if not Panel_Window_PetLookChange_All:GetShow() then
    return
  end
  self._ui.list2_Pet:getElementManager():clearKey()
  for index = 0, self._petCount - 1 do
    if nil ~= self._changableIndex[index] then
      local petData = ToClient_getPetSealedDataByIndex(self._changableIndex[index])
      if nil ~= petData then
        self._ui.list2_Pet:getElementManager():pushKey(toInt64(0, index))
      end
    end
  end
end
function PaGlobal_PetLookChange_All:createListContents(contents, key)
  local index = Int64toInt32(key)
  local petData = ToClient_getPetSealedDataByIndex(self._changableIndex[index])
  local rdo_BG = UI.getChildControl(contents, "RadioButton_PetList")
  local petIconBG = UI.getChildControl(rdo_BG, "Static_IconBG")
  local petIcon = UI.getChildControl(petIconBG, "Static_PetIcon")
  local txt_PetName = UI.getChildControl(rdo_BG, "StaticText_PetName")
  local txt_PetLevel = UI.getChildControl(rdo_BG, "StaticText_PetLevel")
  local iconPath = petData:getIconPath()
  local petLevel = petData._level
  local petName = petData:getName()
  petIcon:ChangeTextureInfoName(iconPath)
  txt_PetLevel:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_LV") .. "." .. petLevel)
  txt_PetName:SetTextMode(__eTextMode_LimitText)
  txt_PetName:SetText(petName)
  if txt_PetName:IsLimitText() then
    txt_PetName:addInputEvent("Mouse_On", "HandleEventMouseOnPetLookChange_SimpleTooltip_All( true, " .. index .. ", " .. self._changableIndex[index] .. " )")
    txt_PetName:addInputEvent("Mouse_Out", "HandleEventMouseOnPetLookChange_SimpleTooltip_All( false, " .. index .. ", " .. self._changableIndex[index] .. " )")
  else
    txt_PetName:addInputEvent("Mouse_On", "")
    txt_PetName:addInputEvent("Mouse_Out", "")
  end
  txt_PetName:addInputEvent("Mouse_LUp", "HandleEventLUp_PetLookChange_SelectPet_All(" .. index .. ")")
  rdo_BG:addInputEvent("Mouse_LUp", "HandleEventLUp_PetLookChange_SelectPet_All(" .. index .. ")")
  rdo_BG:setNotImpactScrollEvent(true)
end
function PaGlobal_PetLookChange_All:selectPet(petIndex)
  local petData = ToClient_getPetSealedDataByIndex(self._changableIndex[petIndex])
  if nil == petData then
    return
  end
  self._selectedPetIndex = petIndex
  self._selectedLookIndex = 0
  self:iconChange(self._selectedPetIndex, self._selectedLookIndex)
end
function PaGlobal_PetLookChange_All:iconChange(petIndex, lookIndex)
  local petData = ToClient_getPetSealedDataByIndex(self._changableIndex[petIndex])
  if nil == petData then
    return
  end
  local petStaticStatus = petData:getPetStaticStatus()
  local count = ToClient_getPetChangeLookCount(petStaticStatus)
  if lookIndex < 0 or lookIndex >= count then
    return
  end
  self._selectedLookIndex = lookIndex
  local iconPath = ToClient_getPetChangeLook_IconPath(petStaticStatus, lookIndex)
  self._ui.stc_PetIcon:ChangeTextureInfoName(iconPath)
  self._ui.txt_LookIndex:SetText(self._selectedLookIndex + 1 .. " / " .. count)
  local actionIndex = ToClient_getPetChangeLook_ActionIndex(petStaticStatus, self._selectedLookIndex)
  if self._isConsole then
    Panel_Window_PetLookChange_All:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "PaGlobal_PetLookChange_Request_All(" .. petIndex .. "," .. actionIndex .. ")")
    Panel_Window_PetLookChange_All:registerPadEvent(__eConsoleUIPadEvent_LB, "HandleEventLUp_PetLookChange_SelectLook_All(" .. petIndex .. "," .. self._selectedLookIndex - 1 .. ")")
    Panel_Window_PetLookChange_All:registerPadEvent(__eConsoleUIPadEvent_RB, "HandleEventLUp_PetLookChange_SelectLook_All(" .. petIndex .. "," .. self._selectedLookIndex + 1 .. ")")
  else
    self._ui_pc.btn_Right:addInputEvent("Mouse_LUp", "HandleEventLUp_PetLookChange_SelectLook_All(" .. petIndex .. "," .. self._selectedLookIndex + 1 .. ")")
    self._ui_pc.btn_Left:addInputEvent("Mouse_LUp", "HandleEventLUp_PetLookChange_SelectLook_All(" .. petIndex .. "," .. self._selectedLookIndex - 1 .. ")")
    self._ui_pc.btn_Bottom_Change:addInputEvent("Mouse_LUp", "PaGlobal_PetLookChange_Request_All(" .. petIndex .. "," .. actionIndex .. ")")
  end
end
