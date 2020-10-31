function PaGlobal_SkillGroup_CoolTimeSlot:initialize()
  if true == PaGlobal_SkillGroup_CoolTimeSlot._initialize then
    return
  end
  PaGlobal_SkillGroup_CoolTimeSlot:initControlAll()
  PaGlobal_SkillGroup_CoolTimeSlot:registEventHandler()
  PaGlobal_SkillGroup_CoolTimeSlot:validate()
  PaGlobal_SkillGroup_CoolTimeSlot._initialize = true
end
function PaGlobal_SkillGroup_CoolTimeSlot:initControlAll()
  local panel = Panel_SkillGroup_CoolTimeSlot
  local ui = self._ui
  ui._stc_frameBG = UI.getChildControl(Panel_SkillGroup_CoolTimeSlot, "Static_FrameBG")
  ui._slide = UI.getChildControl(Panel_SkillGroup_CoolTimeSlot, "VerticalScroll")
  ui._btn_slide = UI.getChildControl(ui._slide, "VerticalScroll_CtrlButton")
  ui._btn_initAll = UI.getChildControl(Panel_SkillGroup_CoolTimeSlot, "BtnInit")
  ui._btn_uiSetting = UI.getChildControl(Panel_SkillGroup_CoolTimeSlot, "Button_UISetting")
  ui._stc_title = UI.getChildControl(Panel_SkillGroup_CoolTimeSlot, "StaticText_TitleBar")
  ui._txt_title = UI.getChildControl(ui._stc_title, "StaticText_Title")
  ui._btn_close = UI.getChildControl(ui._stc_title, "Button_Close")
  self._editSearch._editSearchButton = UI.getChildControl(self._editSearch._editSearchText, "BtnSearch")
  ui._stc_descBg = UI.getChildControl(Panel_SkillGroup_CoolTimeSlot, "Static_DescBG")
  ui._txt_desc = UI.getChildControl(ui._stc_descBg, "StaticText_BottomDesc")
  for index = 1, self._skillCoolTimeSlotList_MaxCount do
    self._uiData[index] = self:skillCoolTimeSlot_MakeControl(index)
  end
  if isGameTypeKorea() then
    self._editSearch._editSearchText:SetMaxInput(20)
  else
    self._editSearch._editSearchText:SetMaxInput(40)
  end
  self._editSearch._editSearchText:SetShow(true)
  self._editSearch._editSearchButton:SetShow(true)
  self._uiSize.descBgY = ui._stc_descBg:GetSizeY()
  self._uiSize.panelY = Panel_SkillGroup_CoolTimeSlot:GetSizeY()
  Panel_SkillGroup_CoolTimeSlot:RemoveControl(self._copyUI._base_SkillBG)
  self._copyUI._base_SkillBG = nil
  Panel_SkillGroup_CoolTimeSlot:RemoveControl(self._copyUI._base_SkillIcon)
  self._copyUI._base_SkillIcon = nil
  Panel_SkillGroup_CoolTimeSlot:RemoveControl(self._copyUI._base_SkillName)
  self._copyUI._base_SkillName = nil
  Panel_SkillGroup_CoolTimeSlot:RemoveControl(self._copyUI._base_ComboBox)
  self._copyUI._base_ComboBox = nil
  UIScroll.InputEvent(ui._slide, "PaGlobal_SkillGroup_CoolTimeSlot:scrollUpdate")
  self._editSearch._editSearchButton:addInputEvent("Mouse_LUp", "PaGlobal_SkillGroup_CoolTimeSlot:searchbuttonClick()")
  self._editSearch._editSearchText:addInputEvent("Mouse_LDown", "PaGlobal_SkillGroup_CoolTimeSlot:searchText_Click()")
  self._editSearch._editSearchText:addInputEvent("Mouse_LUp", "PaGlobal_SkillGroup_CoolTimeSlot:searchText_Click()")
  self._editSearch._editSearchText:RegistReturnKeyEvent("PaGlobal_SkillGroup_CoolTimeSlot:searchbuttonClick()")
  ui._stc_frameBG:addInputEvent("Mouse_UpScroll", "PaGlobal_SkillGroup_CoolTimeSlot:scrollUpdate( true )")
  ui._stc_frameBG:addInputEvent("Mouse_DownScroll", "PaGlobal_SkillGroup_CoolTimeSlot:scrollUpdate( false )")
  ui._btn_initAll:addInputEvent("Mouse_LUp", "PaGlobal_SkillGroup_CoolTimeSlot:allSkillClear()")
  ui._btn_uiSetting:addInputEvent("Mouse_LUp", "PaGlobal_SkillGroup_CoolTimeSlot:EnterUIEditMode()")
  ui._btn_close:addInputEvent("Mouse_LUp", "PaGlobalFunc_SkillGroup_CoolTimeSlot_Close()")
  self:bottomDesc_Setting()
  self:skillCoolTimeSlot_Setting()
  self:update()
  self._originbuttonSizeX = ui._btn_initAll:GetSizeX()
end
function PaGlobal_SkillGroup_CoolTimeSlot:EnterUIEditMode()
  if true == _ContentsGroup_UISkillGroupTreeLayOut then
    PaGlobal_SkillGroup:close()
  end
  FGlobal_UiSet_Open(false)
end
function PaGlobal_SkillGroup_CoolTimeSlot:open()
  if Panel_Window_SkillGroup:IsShow() == true then
    Panel_SkillGroup_CoolTimeSlot:SetShow(true, true)
    self._ui._slide:SetControlPos(0)
    self._slideIndex = 0
    self:skillCoolTimeSlot_Setting()
    ClearFocusEdit()
    if false == Panel_Window_BlackSpiritSkillLock_All:GetShow() then
      local screenY = getScreenSizeY()
      Panel_SkillGroup_CoolTimeSlot:SetPosX(75 + Panel_Window_BlackSpiritSkillLock_All:GetSizeX() + 10)
      Panel_SkillGroup_CoolTimeSlot:SetPosY((screenY - Panel_Window_BlackSpiritSkillLock_All:GetSizeY()) / 2 - 48)
    else
      local posX = Panel_Window_BlackSpiritSkillLock_All:GetPosX() + Panel_Window_BlackSpiritSkillLock_All:GetSizeX() + 10
      local posY = Panel_Window_BlackSpiritSkillLock_All:GetPosY()
      Panel_SkillGroup_CoolTimeSlot:SetPosX(posX)
      Panel_SkillGroup_CoolTimeSlot:SetPosY(posY)
    end
  else
    Panel_SkillGroup_CoolTimeSlot:SetShow(false, true)
  end
  if true == _ContentsGroup_UISkillGroupTreeLayOut and true == PaGlobal_SkillGroup._isDialog then
    self._ui._btn_uiSetting:SetShow(false)
    self._ui._btn_initAll:SetSize(self._originbuttonSizeX * 2 + 5, self._ui._btn_initAll:GetSizeY())
  else
    self._ui._btn_uiSetting:SetShow(true)
    self._ui._btn_initAll:SetSize(self._originbuttonSizeX, self._ui._btn_initAll:GetSizeY())
  end
  self._editSearch._editSearchText:SetEditText("", false)
  self:update()
end
function PaGlobal_SkillGroup_CoolTimeSlot:close()
  if nil == Panel_SkillGroup_CoolTimeSlot then
    return
  end
  self._editSearch._editSearchText:SetEditText("", false)
  Panel_SkillGroup_CoolTimeSlot:SetShow(false, true)
end
local sortSkillCoolTime = function(table1, table2)
  local arg1 = table1._coolTimeIndex
  local arg2 = table2._coolTimeIndex
  if arg1 < 0 then
    arg1 = PaGlobal_SkillGroup_CoolTimeSlot._usableSkillCount
  end
  if arg2 < 0 then
    arg2 = PaGlobal_SkillGroup_CoolTimeSlot._usableSkillCount
  end
  if arg1 < arg2 or arg1 == arg2 and table1._insertNo < table2._insertNo then
    return true
  end
end
function PaGlobal_SkillGroup_CoolTimeSlot:update()
  if nil == Panel_SkillGroup_CoolTimeSlot then
    return
  end
  local skillInfo = {}
  for ii = 0, #skillInfo do
    skillInfo = {
      _skillNo = nil,
      _skillName = nil,
      _coolTimeIndex = nil,
      _insertNo = nil
    }
  end
  local ui = self._ui
  skillInfo, self._panel_SkillCoolTimeSlot_Value_elementCount = self:searchSkill_Setting()
  if self._panel_SkillCoolTimeSlot_Value_elementCount <= self._skillCoolTimeSlotList_MaxCount then
    ui._slide:SetShow(false)
  else
    ui._slide:SetShow(true)
  end
  table.sort(skillInfo, sortSkillCoolTime)
  for index = 1, self._skillCoolTimeSlotList_MaxCount do
    if self._slideIndex + index < self._panel_SkillCoolTimeSlot_Value_elementCount then
      local skillTypeStaticWrapper = getSkillTypeStaticStatus(skillInfo[self._slideIndex + index]._skillNo)
      if skillTypeStaticWrapper:isValidLocalizing() then
        self._uiData[index]:SetData(skillTypeStaticWrapper, skillInfo[self._slideIndex + index]._skillNo, skillInfo[self._slideIndex + index]._skillName, index)
        self._uiData[index]._IconBG:SetShow(true)
        self._uiData[index]._skillIcon:SetShow(true)
        self._uiData[index]._skillName:SetShow(true)
        self._uiData[index]._ComboBox:SetText("")
        if false == self._uiData[index]._ComboBox:GetShow() then
          self._uiData[index]._ComboBox:SetShow(true)
        end
        local coolIdx = skillInfo[self._slideIndex + index]._coolTimeIndex + 1
        self._uiData[index]._ComboBox:SetText(self._comboBoxString[coolIdx])
        if self._uiData[index]._ComboBox:GetSelectIndex() ~= coolIdx then
          self._uiData[index]._ComboBox:SetSelectItemIndex(coolIdx)
          return
        end
      else
        self._uiData[index]._IconBG:SetShow(false)
        self._uiData[index]._skillIcon:SetShow(false)
        self._uiData[index]._skillName:SetShow(false)
        self._uiData[index]._ComboBox:SetShow(false)
      end
    else
      self._uiData[index]._IconBG:SetShow(false)
      self._uiData[index]._skillIcon:SetShow(false)
      self._uiData[index]._skillName:SetShow(false)
      self._uiData[index]._ComboBox:SetShow(false)
    end
  end
  UIScroll.SetButtonSize(ui._slide, self._skillCoolTimeSlotList_MaxCount, self._panel_SkillCoolTimeSlot_Value_elementCount - 1)
end
function PaGlobal_SkillGroup_CoolTimeSlot:skillUpdate()
  self._editSearch._editSearchText:SetEditText("", false)
  self:skillCoolTimeSlot_Setting()
  self:update()
  PaGlobal_SkillCoolTimeQuickSlot:updateQuickSlot()
end
function PaGlobal_SkillGroup_CoolTimeSlot:skillCoolTimeSlot_MakeControl(index)
  local ui = {}
  index = index - 1
  local addedPosY = (self._copyUI._base_SkillBG:GetSizeY() + 9) * index
  ui._IconBG = UI.cloneControl(self._copyUI._base_SkillBG, Panel_SkillGroup_CoolTimeSlot, "Static_SkillBG_" .. index)
  ui._IconBG:SetShow(false)
  ui._IconBG:SetIgnore(false)
  ui._IconBG:SetPosY(self._copyUI._base_SkillBG:GetPosY() + addedPosY)
  ui._skillIcon = UI.cloneControl(self._copyUI._base_SkillIcon, Panel_SkillGroup_CoolTimeSlot, "Static_SkillIcon_" .. index)
  ui._skillIcon:SetShow(false)
  ui._skillIcon:SetPosY(self._copyUI._base_SkillIcon:GetPosY() + addedPosY)
  ui._skillName = UI.cloneControl(self._copyUI._base_SkillName, Panel_SkillGroup_CoolTimeSlot, "StaticText_SkillName_" .. index)
  ui._skillName:SetShow(false)
  ui._skillName:SetIgnore(true)
  ui._skillName:SetPosY(self._copyUI._base_SkillName:GetPosY() + addedPosY)
  ui._skillName:SetTextMode(__eTextMode_Limit_AutoWrap)
  ui._ComboBox = UI.cloneControl(self._copyUI._base_ComboBox, Panel_SkillGroup_CoolTimeSlot, "Combobox_SkillCoolTimeQuickSlot_" .. index)
  ui._ComboBox:setListTextHorizonCenter()
  ui._ComboBox:SetShow(false)
  ui._ComboBox:SetPosY(self._copyUI._base_ComboBox:GetPosY() + addedPosY)
  ui._ComboBox:DeleteAllItem()
  for comboindex = 0, #self._comboBoxString do
    ui._ComboBox:AddItem(self._comboBoxString[comboindex])
  end
  function ui:SetData(skillTypeSSW, skillNo, skillName, index)
    self._skillIcon:ChangeTextureInfoName("Icon/" .. skillTypeSSW:getIconPath())
    self._skillName:SetText(skillName)
    self._skillIcon:addInputEvent("Mouse_On", "PaGlobal_SkillGroup_CoolTimeSlot:skillCoolTimeSlot_OverEvent(" .. skillNo .. ",false, \"MainStatusSkill\")")
    self._skillIcon:addInputEvent("Mouse_Out", "PaGlobal_SkillGroup_CoolTimeSlot:skillCoolTimeSlot_OverEventHide(" .. skillNo .. ",\"MainStatusSkill\")")
    self._ComboBox:addInputEvent("Mouse_LUp", "PaGlobal_SkillGroup_CoolTimeSlot:skillCoolTimeSlotComboBox_Show(" .. index .. " )")
    self._ComboBox:SetIgnore(false)
    self._ComboBox:GetListControl():AddSelectEvent("PaGlobal_SkillGroup_CoolTimeSlot:skillCoolTimeSlotComboBox_Set(" .. index .. ", " .. skillNo .. ")")
  end
  ui._IconBG:addInputEvent("Mouse_UpScroll", "PaGlobal_SkillGroup_CoolTimeSlot:scrollUpdate( true )")
  ui._IconBG:addInputEvent("Mouse_DownScroll", "PaGlobal_SkillGroup_CoolTimeSlot:scrollUpdate( false )")
  ui._skillIcon:addInputEvent("Mouse_UpScroll", "PaGlobal_SkillGroup_CoolTimeSlot:scrollUpdate( true )")
  ui._skillIcon:addInputEvent("Mouse_DownScroll", "PaGlobal_SkillGroup_CoolTimeSlot:scrollUpdate( false )")
  return ui
end
function PaGlobal_SkillGroup_CoolTimeSlot:bottomDesc_Setting()
  self._ui._txt_desc:SetTextMode(__eTextMode_AutoWrap)
  self._ui._txt_desc:SetText(self._ui._txt_desc:GetText())
  local textSizeY = self._ui._txt_desc:GetTextSizeY() + 5
  if textSizeY > self._uiSize.descBgY then
    local addSizeY = textSizeY - self._uiSize.descBgY
    Panel_SkillGroup_CoolTimeSlot:SetSize(Panel_SkillGroup_CoolTimeSlot:GetSizeX(), self._uiSize.panelY + addSizeY)
    self._ui._txt_desc:SetSize(self._ui._txt_desc:GetSizeX(), self._uiSize.descBgY + addSizeY)
    self._ui._txt_desc:SetText(self._ui._txt_desc:GetText())
    self._ui._stc_descBg:SetSize(self._ui._stc_descBg:GetSizeX(), self._uiSize.descBgY + addSizeY)
    self._ui._stc_descBg:ComputePos()
    self._ui._txt_desc:ComputePos()
    self._ui._btn_initAll:ComputePos()
    self._ui._btn_uiSetting:ComputePos()
  end
end
function PaGlobal_SkillGroup_CoolTimeSlot:scrollUpdate(isUp)
  local self = PaGlobal_SkillGroup_CoolTimeSlot
  self._slideIndex = UIScroll.ScrollEvent(self._ui._slide, isUp, self._skillCoolTimeSlotList_MaxCount, self._panel_SkillCoolTimeSlot_Value_elementCount - 1, self._slideIndex, 1)
  self:update()
end
function PaGlobal_SkillGroup_CoolTimeSlot:searchbuttonClick()
  local self = PaGlobal_SkillGroup_CoolTimeSlot
  if false == CheckChattingInput() then
    ClearFocusEdit()
  end
  self._slideIndex = 0
  self:update()
end
function PaGlobal_SkillGroup_CoolTimeSlot:searchText_Click()
  SetFocusEdit(self._editSearch._editSearchText)
  self._editSearch._editSearchText:SetEditText("", false)
end
function PaGlobal_SkillGroup_CoolTimeSlot:allSkillClear()
  ToClient_allClearSkillCoolTimeSlot()
  self._editSearch._editSearchText:SetEditText("", false)
  self:update()
  PaGlobal_SkillCoolTimeQuickSlot:updateQuickSlot()
end
function PaGlobal_SkillGroup_CoolTimeSlot:skillCoolTimeSlotComboBox_Show(index)
  self._uiData[index]._ComboBox:ToggleListbox()
  Panel_SkillGroup_CoolTimeSlot:SetChildIndex(self._uiData[index]._ComboBox, 9998)
end
function PaGlobal_SkillGroup_CoolTimeSlot:skillCoolTimeSlotComboBox_Set(index, skillNo)
  local slotNo = self._uiData[index]._ComboBox:GetSelectIndex() - 1
  if 0 <= slotNo then
    ToClient_setSkillCoolTimeSlot(slotNo, skillNo)
  else
    ToClient_clearSkillCoolTimeSlot(skillNo)
  end
  PaGlobal_SkillCoolTimeQuickSlot:updateQuickSlot()
  PaGlobal_SkillGroup_CoolTimeSlot:update()
end
function PaGlobal_SkillGroup_CoolTimeSlot:skillCoolTimeSlot_OverEvent(skillNo, isShowNextLevel, SlotType)
  if skillNoCache == skillNo and slotTypeCache == SlotType then
    tooltipcacheCount = tooltipcacheCount + 1
  else
    skillNoCache = skillNo
    slotTypeCache = SlotType
    tooltipcacheCount = 1
  end
  Panel_SkillTooltip_Show(skillNo, false, SlotType)
end
function PaGlobal_SkillGroup_CoolTimeSlot:skillCoolTimeSlot_OverEventHide(skillNo, SlotType)
  if skillNoCache == skillNo and slotTypeCache == SlotType then
    tooltipcacheCount = tooltipcacheCount - 1
  else
    tooltipcacheCount = 0
  end
  if tooltipcacheCount <= 0 then
    Panel_SkillTooltip_Hide()
  end
end
local stringMatching = function(filterText, editSkillName)
  return (stringSearch(filterText, editSkillName))
end
function PaGlobal_SkillGroup_CoolTimeSlot:searchSkill_Setting()
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  local filterText = self._editSearch._editSearchText:GetEditText()
  local skillTable = {}
  local editSkillCount = 1
  local isPush = false
  for ii = 1, self._usableSkillCount - 1 do
    if nil == filterText or 0 == filterText:len() then
      isPush = true
    elseif true == stringMatching(self._usableSkillTable[ii]._skillName, filterText) then
      isPush = true
    else
      isPush = false
    end
    if true == isPush then
      local coolTimeIndex = ToClient_getSkillCoolTimeSlotIndex(self._usableSkillTable[ii]._skillNo)
      skillTable[editSkillCount] = {
        _skillNo = self._usableSkillTable[ii]._skillNo,
        _skillName = self._usableSkillTable[ii]._skillName,
        _coolTimeIndex = coolTimeIndex,
        _insertNo = self._usableSkillTable[ii]._insertNo
      }
      editSkillCount = editSkillCount + 1
    end
  end
  return skillTable, editSkillCount
end
function PaGlobal_SkillGroup_CoolTimeSlot:usableskillTableInit(nums)
  self._usableSkillTable = {}
  for i = 1, nums do
    self._usableSkillTable[i] = {
      _skillName = nil,
      _skillNo = nil,
      _insertNo = nil
    }
  end
end
function PaGlobal_SkillGroup_CoolTimeSlot:skillCoolTimeSlot_SettingCell(cellTable, usableSkillCount)
  if nil == cellTable then
    _PA_LOG("\234\185\128\236\167\128\237\152\129", "cellTable is nil")
    return usableSkillCount
  end
  local cols = cellTable:sizeX()
  local rows = cellTable:sizeY()
  for row = 0, rows - 1 do
    for col = 0, cols - 1 do
      local cell = cellTable:atWrapper(col, row)
      local skillGroupNo = cell:getSkillGroupNo()
      local skillGroup
      if __eSkillGroupCellType_SkillGroup == cell:getType() then
        skillGroup = PaGlobal_SkillGroup:getSkillGroupBySkillGroupNo(skillGroupNo)
      end
      if nil ~= skillGroup then
        _PA_LOG("\234\185\128\236\167\128\237\152\129", "skillGroupNo : " .. tostring(skillGroupNo))
        for jj = 1, skillGroup._maxLevel do
          local skillKey = ToClient_getSkillKeyBySkillGroupNo(skillGroupNo, jj)
          local skillNo = skillKey:getSkillNo()
          local skillLevelInfo = getSkillLevelInfo(skillNo)
          local skillStaticWrapper = getSkillStaticStatus(skillNo, 1)
          local skillType = getSkillTypeStaticStatus(skillNo)
          if true == skillType:isValidLocalizing() and false == skillLevelInfo._learnable and true == skillLevelInfo._usable and 0 < skillStaticWrapper:get()._reuseCycle then
            local disPlaySkillNo = skillStaticWrapper:getExceptionSkillCoolTime()
            if 0 == disPlaySkillNo then
              self._usableSkillTable[usableSkillCount] = {
                _skillName = skillStaticWrapper:getName(),
                _skillNo = skillNo,
                _insertNo = usableSkillCount
              }
            else
              local disPlaySkill = getSkillStaticStatus(disPlaySkillNo, 1)
              self._usableSkillTable[usableSkillCount] = {
                _skillName = disPlaySkill:getName(),
                _skillNo = disPlaySkillNo,
                _insertNo = usableSkillCount
              }
            end
            usableSkillCount = usableSkillCount + 1
          end
        end
      end
    end
  end
  return usableSkillCount
end
function PaGlobal_SkillGroup_CoolTimeSlot:skillCoolTimeSlot_Setting()
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  ToClient_checkExceptionSkillSetting()
  local skillTable = {}
  self:usableskillTableInit(self._usableSkillCount)
  local usableSkillCount = 1
  local classType = selfPlayer:getClassType()
  if 0 <= classType then
    cellTable = ToClient_getSkillGroupCellTableWrapper(0, classType)
    usableSkillCount = self:skillCoolTimeSlot_SettingCell(cellTable, usableSkillCount)
    cellTable = ToClient_getSkillGroupCellTableWrapper(2, classType)
    usableSkillCount = self:skillCoolTimeSlot_SettingCell(cellTable, usableSkillCount)
    if PaGlobal_SuccessionSkill_IsCheckOpenContents() then
      cellTable = ToClient_getSkillGroupCellTableWrapper(1, classType)
      usableSkillCount = self:skillCoolTimeSlot_SettingCell(cellTable, usableSkillCount)
    end
  else
    return
  end
  _PA_LOG("\234\185\128\236\167\128\237\152\129", "usableSkillCount : " .. tostring(usableSkillCount))
  local isLearnFusionSkill = ToClient_isLearnFusionSkillLevel() and ToClient_getFusionSkillListCount(0) ~= 0
  if true == isLearnFusionSkill then
    local cellTable2 = getFusionSkillTree()
    local cols = cellTable2:capacityX()
    local rows = cellTable2:capacityY()
    local index = 0
    for row = 0, rows - 1 do
      for col = 0, cols - 1 do
        local cell = cellTable2:atPointer(col, row)
        if cell:isSkillType() then
          local skillNo = ToClient_getFusionLearnSkillNo(index)
          index = index + 1
          if 0 ~= skillNo and true == ToClient_isLearnedSkill(skillNo) then
            local skillStaticWrapper = getSkillStaticStatus(skillNo, 1)
            local skillType = getSkillTypeStaticStatus(skillNo)
            if true == skillType:isValidLocalizing() then
              local disPlaySkillNo = skillStaticWrapper:getExceptionSkillCoolTime()
              if 0 == disPlaySkillNo then
                self._usableSkillTable[usableSkillCount] = {
                  _skillName = skillStaticWrapper:getName(),
                  _skillNo = skillNo,
                  _insertNo = usableSkillCount
                }
              else
                local disPlaySkill = getSkillStaticStatus(disPlaySkillNo, 1)
                self._usableSkillTable[usableSkillCount] = {
                  _skillName = disPlaySkill:getName(),
                  _skillNo = disPlaySkillNo,
                  _insertNo = usableSkillCount
                }
              end
              usableSkillCount = usableSkillCount + 1
            end
          end
        end
      end
    end
  end
  self._usableSkillCount = usableSkillCount
end
function PaGlobal_SkillGroup_CoolTimeSlot:registEventHandler()
  if nil == Panel_SkillGroup_CoolTimeSlot then
    return
  end
  registerEvent("FromClient_SkillCoolTimeSlotUpdate", "FromClient_SkillGroupCoolTimeSlotUpdate")
end
function PaGlobal_SkillGroup_CoolTimeSlot:validate()
  if nil == Panel_SkillGroup_CoolTimeSlot then
    return
  end
end
