function PaGlobal_ServantLookChange_All:initialize()
  if nil == Panel_Dialog_ServantLookChange_All or true == self.initialize then
    return
  end
  self._ui._stc_Title = UI.getChildControl(Panel_Dialog_ServantLookChange_All, "StaticText_Title")
  self._ui._stc_Bg = UI.getChildControl(Panel_Dialog_ServantLookChange_All, "Static_Bg")
  self._ui._comboBox_TierSelect_PC = UI.getChildControl(Panel_Dialog_ServantLookChange_All, "Combobox_TierSelect")
  self._ui._comboBox_TierList_PC = UI.getChildControl(self._ui._comboBox_TierSelect_PC, "Combobox_1_List")
  self._ui._comboBox_TierSelectScroll_PC = UI.getChildControl(self._ui._comboBox_TierList_PC, "Combobox_1_List_Scroll")
  self._ui._comboBox_TierSelectScroll_Up_PC = UI.getChildControl(self._ui._comboBox_TierSelectScroll_PC, "Combobox_1_List_Scroll_UpButton")
  self._ui._comboBox_TierSelectScroll_Down_PC = UI.getChildControl(self._ui._comboBox_TierSelectScroll_PC, "Combobox_1_List_Scroll_DownButton")
  self._ui._comboBox_TierSelectScroll_Ctrl_PC = UI.getChildControl(self._ui._comboBox_TierSelectScroll_PC, "Combobox_1_List_Scroll_CtrlButton")
  self._ui._comboBox_TierListBackBg_PC = UI.getChildControl(self._ui._comboBox_TierList_PC, "Combobox_1_List_BackStatic")
  self._ui._comboBox_TierSelect_Console = UI.getChildControl(Panel_Dialog_ServantLookChange_All, "Static_ComboBoxListBg_ConsoleUI")
  self._ui._comboBox_TierSelect_Button_Console = UI.getChildControl(self._ui._comboBox_TierSelect_Console, "Button_LookList_Template")
  self._ui._list2_Look = UI.getChildControl(Panel_Dialog_ServantLookChange_All, "List2_Look")
  self._ui._list2_Content = UI.getChildControl(self._ui._list2_Look, "List2_1_Content")
  self._ui._list2_Btn_Left = UI.getChildControl(self._ui._list2_Content, "Button_Left")
  self._ui._list2_Btn_Left_Img = UI.getChildControl(self._ui._list2_Btn_Left, "Static_Image")
  self._ui._list2_Btn_Right = UI.getChildControl(self._ui._list2_Content, "Button_Right")
  self._ui._list2_Btn_Right_Img = UI.getChildControl(self._ui._list2_Btn_Right, "Static_Image")
  self._ui._list2_VertiScroll = UI.getChildControl(self._ui._list2_Look, "List2_1_VerticalScroll")
  self._ui._list2_VertiScroll_Up = UI.getChildControl(self._ui._list2_VertiScroll, "List2_1_VerticalScroll_UpButton")
  self._ui._list2_VertiScroll_Down = UI.getChildControl(self._ui._list2_VertiScroll, "List2_1_VerticalScroll_DownButton")
  self._ui._list2_VertiScroll_Ctrl = UI.getChildControl(self._ui._list2_VertiScroll, "List2_1_VerticalScroll_CtrlButton")
  self._ui._list2_HoriScroll = UI.getChildControl(self._ui._list2_Look, "List2_1_HorizontalScroll")
  self._ui._list2_HoriScroll_Up = UI.getChildControl(self._ui._list2_HoriScroll, "List2_1_HorizontalScroll_UpButton")
  self._ui._list2_HoriScroll_Down = UI.getChildControl(self._ui._list2_HoriScroll, "List2_1_HorizontalScroll_DownButton")
  self._ui._list2_HoriScroll_Ctrl = UI.getChildControl(self._ui._list2_HoriScroll, "List2_1_HorizontalScroll_CtrlButton")
  self._ui._btn_ChangeLook = UI.getChildControl(Panel_Dialog_ServantLookChange_All, "Button_ChangeLook")
  self._ui._btn_ChangeSpecialLook = UI.getChildControl(Panel_Dialog_ServantLookChange_All, "Button_ChangeSpecialLook")
  self._ui._comboBox_TierSelect_Console:SetShow(false)
  self._isConsole = _ContentsGroup_UsePadSnapping
  PaGlobal_ServantLookChange_All:validate()
  PaGlobal_ServantLookChange_All:registerEventHandler(self._isConsole)
end
function PaGlobal_ServantLookChange_All:registerEventHandler(isConsole)
  if nil == Panel_Dialog_ServantLookChange_All or false == self._initialize then
    return
  end
  registerEvent("onScreenResize", "PaGlobalFunc_ServantLookChange_All_OnScreenReSize")
  self._ui._list2_Look:registEvent(__ePAUIList2EventType_LuaChangeContent, "FromClient_ServantLookChange_All_list2Update")
  self._ui._list2_Look:createChildContent(__ePAUIList2ElementManagerType_List)
  self._ui._comboBox_TierSelect_PC:GetListControl():AddSelectEvent("HandleEventLUp_ServantLookChange_All_SelectComboBox()")
  self._ui._comboBox_TierSelect_PC:addInputEvent("Mouse_LUp", "HandleEventLUp_ServantLookChange_All_OpenComboBox()")
  self._ui._comboBox_TierSelect_PC:setListTextHorizonCenter()
  self._ui._btn_ChangeLook:addInputEvent("Mouse_LUp", "HandleEventLUp_ServantLookChange_All_ChangeLook( false )")
  self._ui._btn_ChangeSpecialLook:addInputEvent("Mouse_LUp", "HandleEventLUp_ServantLookChange_All_ChangeLook( true )")
  Panel_Dialog_ServantLookChange_All:ignorePadSnapMoveToOtherPanel()
end
function PaGlobal_ServantLookChange_All:addComboBoxItem()
  if nil == PaGlobal_ServantLookChange_All._currentServantNo then
    return
  end
  local servantInfo = stable_getServant(PaGlobal_ServantLookChange_All._currentServantNo)
  if nil == servantInfo then
    return
  end
  local uiCount = 1
  local servantTier = servantInfo:getTier()
  PaGlobal_ServantLookChange_All._ui._comboBox_TierSelect_PC:DeleteAllItem()
  local specialTier = PaGlobal_ServantLookChange_All._ui._comboBox_TierSelect_PC:AddItem(PAGetString(Defines.StringSheet_GAME, "LUA_STABLELIST_LOOKCHANGE_SPECIAL"))
  if 1 < servantTier then
    for tierIndex = 1, servantTier - 1 do
      uiCount = uiCount + 1
      local tier = PaGlobal_ServantLookChange_All._ui._comboBox_TierSelect_PC:AddItem(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_STABLELIST_LOOKCHANGE_SPECIAL_TIER", "tierIndex", tierIndex))
    end
  end
  local comboBoxSizeX = PaGlobal_ServantLookChange_All._ui._comboBox_TierSelect_PC:GetSizeX()
  local listControlSizeY = PaGlobal_ServantLookChange_All._ui._comboBox_TierListBackBg_PC:GetSizeY()
  PaGlobal_ServantLookChange_All._ui._comboBox_TierSelect_PC:GetListControl():SetSize(comboBoxSizeX, listControlSizeY * uiCount)
end
function PaGlobal_ServantLookChange_All:prepareOpen()
  if nil == Panel_Dialog_ServantLookChange_All or true == Panel_Dialog_ServantLookChange_All:GetShow() then
    return
  end
  if 0 == PaGlobalFunc_ServantFunction_All_Get_NpcType() then
    self._ui._comboBox_TierSelect_PC:SetShow(true)
    self._ui._stc_Title:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WINDOW_HORSELOOKCHANGE_TITLE"))
    self._ui._btn_ChangeLook:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WINDOW_HORSELOOKCHANGE_TITLE"))
    self._ui._btn_ChangeSpecialLook:SetShow(true)
  elseif 2 == PaGlobalFunc_ServantFunction_All_Get_NpcType() then
    self._ui._comboBox_TierSelect_PC:SetShow(false)
    self._ui._stc_Title:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WINDOW_WHARFFUNCTION_EXTENSION"))
    self._ui._btn_ChangeLook:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WINDOW_WHARFFUNCTION_EXTENSION"))
    self._ui._btn_ChangeSpecialLook:SetShow(false)
  else
    return
  end
  PaGlobal_ServantLookChange_All:addComboBoxItem()
  PaGlobal_ServantLookChange_All:open()
  PaGlobal_ServantLookChange_All:update()
end
function PaGlobal_ServantLookChange_All:open()
  if nil == Panel_Dialog_ServantLookChange_All or true == Panel_Dialog_ServantLookChange_All:GetShow() then
    return
  end
  Panel_Dialog_ServantLookChange_All:SetShow(true)
end
function PaGlobal_ServantLookChange_All:update()
  if nil == Panel_Dialog_ServantLookChange_All or nil == self._currentServantNo or -1 == self._currentServantNo then
    return
  end
  if nil == self._currentServantNo then
    return
  end
  HandleEventLUp_ServantLookChange_All_SelectComboBox()
end
function PaGlobal_ServantLookChange_All:updateHorseLook()
  local servantInfo = stable_getServant(self._currentServantNo)
  local formManager
  local lookCount = 1
  if 0 == PaGlobalFunc_ServantFunction_All_Get_NpcType() then
    formManager = getServantFormManager()
    local tierIndex = self._ui._comboBox_TierSelect_PC:GetSelectIndex()
    if 0 < tierIndex then
      lookCount = formManager:getFormTierSize(tierIndex)
    else
      lookCount = formManager:getFormTierSize(0) + 1
    end
  elseif 2 == PaGlobalFunc_ServantFunction_All_Get_NpcType() then
    formManager = getServantTransformManager()
    local fromCharacterKey = servantInfo:getCharacterKeyRaw()
    lookCount = formManager:getFormListSize(fromCharacterKey)
  end
  if nil == formManager then
    return
  end
  self._totalFormCount = lookCount
  self._ui._list2_Look:getElementManager():clearKey()
  if 0 < lookCount then
    for idx = 0, lookCount do
      if 0 == idx % 2 or 0 == idx then
        self._ui._list2_Look:getElementManager():pushKey(toInt64(0, idx))
      end
    end
  end
  self._currentLookIndex = nil
end
function PaGlobal_ServantLookChange_All:list2UpdateHorseLook(content, key)
  if nil == key then
    return
  end
  local servantInfo = stable_getServant(self._currentServantNo)
  if nil == servantInfo then
    return
  end
  local key32 = Int64toInt32(key)
  local btn_Left = UI.getChildControl(content, "Button_Left")
  local btn_Right = UI.getChildControl(content, "Button_Right")
  local btn_Left_Img = UI.getChildControl(btn_Left, "Static_Image")
  local btn_Right_Img = UI.getChildControl(btn_Right, "Static_Image")
  local tierIndex = self._ui._comboBox_TierSelect_PC:GetSelectIndex()
  btn_Left:SetShow(false)
  btn_Right:SetShow(false)
  btn_Left:setNotImpactScrollEvent(true)
  btn_Right:setNotImpactScrollEvent(true)
  btn_Left_Img:ReleaseTexture()
  btn_Right_Img:ReleaseTexture()
  if 0 == PaGlobalFunc_ServantFunction_All_Get_NpcType() then
    if tierIndex <= 0 then
      tierIndex = 0
    end
    local formManager = getServantFormManager()
    local formInfoLeft, formInfoRight
    if 0 < tierIndex then
      formInfoLeft = formManager:getFormTierStaticWrapper(tierIndex, key32)
      if nil ~= formInfoLeft then
        btn_Left_Img:ChangeTextureInfoName(formInfoLeft:getIcon1())
        btn_Left:SetShow(true)
        btn_Left:addInputEvent("Mouse_LUp", "HandleEventLUp_ServantLookChange_All_SelectTier(" .. key32 .. ")")
      end
      local rightIndex = key32 + 1
      formInfoRight = formManager:getFormTierStaticWrapper(tierIndex, rightIndex)
      if nil ~= formInfoRight then
        btn_Right_Img:ChangeTextureInfoName(formInfoRight:getIcon1())
        btn_Right:SetShow(true)
        btn_Right:addInputEvent("Mouse_LUp", "HandleEventLUp_ServantLookChange_All_SelectTier(" .. rightIndex .. ")")
      end
      self:updateButtonCheck(btn_Left, btn_Right, key32, rightIndex)
    else
      formInfoLeft = formManager:getFormTierStaticWrapper(0, key32)
      local rightIndex = key32 + 1
      if nil == formInfoLeft then
        btn_Left_Img:ChangeTextureInfoName(servantInfo:getBaseIconPath1())
        btn_Left:SetShow(true)
        btn_Left:addInputEvent("Mouse_LUp", "HandleEventLUp_ServantLookChange_All_SelectTier(" .. key32 .. ")")
      else
        btn_Left_Img:ChangeTextureInfoName(formInfoLeft:getIcon1())
        btn_Left:SetShow(true)
        btn_Left:addInputEvent("Mouse_LUp", "HandleEventLUp_ServantLookChange_All_SelectTier(" .. key32 .. ")")
        formInfoRight = formManager:getFormTierStaticWrapper(0, rightIndex)
        if nil ~= formInfoRight then
          btn_Right_Img:ChangeTextureInfoName(formInfoRight:getIcon1())
          btn_Right:SetShow(true)
          btn_Right:addInputEvent("Mouse_LUp", "HandleEventLUp_ServantLookChange_All_SelectTier(" .. rightIndex .. ")")
        end
      end
      self:updateButtonCheck(btn_Left, btn_Right, key32, rightIndex)
    end
  elseif 2 == PaGlobalFunc_ServantFunction_All_Get_NpcType() then
    local formManager = getServantTransformManager()
    local fromCharacterKey = servantInfo:getCharacterKeyRaw()
    local formInfoLeft, formInfoRight
    formInfoLeft = formManager:getFormStaticWrapper(fromCharacterKey, key32)
    formInfoLeft:getTransformCharacterKey()
    if nil ~= formInfoLeft then
      btn_Left_Img:ChangeTextureInfoName(formInfoLeft:getIcon1())
      btn_Left:SetShow(true)
      btn_Left:addInputEvent("Mouse_LUp", "HandleEventLUp_ServantLookChange_All_ShipLookChange(" .. key32 .. ")")
    end
    local rightIndex = key32 + 1
    formInfoRight = formManager:getFormStaticWrapper(fromCharacterKey, rightIndex)
    if nil ~= formInfoRight then
      btn_Right_Img:ChangeTextureInfoName(formInfoRight:getIcon1())
      btn_Right:SetShow(true)
      btn_Right:addInputEvent("Mouse_LUp", "HandleEventLUp_ServantLookChange_All_ShipLookChange(" .. rightIndex .. ")")
    end
    self:updateButtonCheck(btn_Left, btn_Right, key32, rightIndex)
  end
end
function PaGlobal_ServantLookChange_All:updateButtonCheck(btn_Left, btn_Right, key32, rightIndex)
  if key32 == self._currentLookIndex then
    self:ButtonSetCheck(btn_Left, true)
    self:ButtonSetCheck(btn_Right, false)
  elseif rightIndex == self._currentLookIndex then
    self:ButtonSetCheck(btn_Left, false)
    self:ButtonSetCheck(btn_Right, true)
  else
    self:ButtonSetCheck(btn_Left, false)
    self:ButtonSetCheck(btn_Right, false)
  end
end
function PaGlobal_ServantLookChange_All:ButtonSetCheck(btn, isShow)
  if nil == btn then
    return
  end
  btn:SetCheck(isShow)
end
function PaGlobal_ServantLookChange_All:prepareClose()
  if nil == Panel_Dialog_ServantLookChange_All or false == Panel_Dialog_ServantLookChange_All:GetShow() then
    return
  end
  if -1 ~= self._beforeSceneIndex then
    PaGlobalFunc_ServantFunction_All_Servant_ScenePopObject(self._beforeSceneIndex)
  end
  self._currentLookIndex = nil
  self._beforeSceneIndex = -1
  PaGlobal_ServantLookChange_All:close()
end
function PaGlobal_ServantLookChange_All:close()
  if nil == Panel_Dialog_ServantLookChange_All or false == Panel_Dialog_ServantLookChange_All:GetShow() then
    return
  end
  Panel_Dialog_ServantLookChange_All:SetShow(false)
end
function PaGlobal_ServantLookChange_All:validate()
  if nil == Panel_Dialog_ServantLookChange_All then
    return
  end
  self._ui._stc_Title:isValidate()
  self._ui._stc_Bg:isValidate()
  self._ui._comboBox_TierSelect_PC:isValidate()
  self._ui._comboBox_TierList_PC:isValidate()
  self._ui._comboBox_TierSelectScroll_PC:isValidate()
  self._ui._comboBox_TierSelectScroll_Up_PC:isValidate()
  self._ui._comboBox_TierSelectScroll_Down_PC:isValidate()
  self._ui._comboBox_TierSelectScroll_Ctrl_PC:isValidate()
  self._ui._comboBox_TierListBackBg_PC:isValidate()
  self._ui._comboBox_TierSelect_Console:isValidate()
  self._ui._comboBox_TierSelect_Button_Console:isValidate()
  self._ui._list2_Look:isValidate()
  self._ui._list2_Content:isValidate()
  self._ui._list2_Btn_Left:isValidate()
  self._ui._list2_Btn_Left_Img:isValidate()
  self._ui._list2_Btn_Right_Img:isValidate()
  self._ui._list2_Btn_Right:isValidate()
  self._ui._list2_VertiScroll:isValidate()
  self._ui._list2_VertiScroll_Up:isValidate()
  self._ui._list2_VertiScroll_Down:isValidate()
  self._ui._list2_VertiScroll_Ctrl:isValidate()
  self._ui._list2_HoriScroll:isValidate()
  self._ui._list2_HoriScroll_Up:isValidate()
  self._ui._list2_HoriScroll_Down:isValidate()
  self._ui._list2_HoriScroll_Ctrl:isValidate()
  self._ui._btn_ChangeLook:isValidate()
  self._ui._btn_ChangeSpecialLook:isValidate()
  self._initialize = true
end
