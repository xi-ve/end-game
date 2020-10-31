function PaGlobalFunc_ServantNameRegist_All_OpenByEventType(openType)
  if nil == Panel_Dialog_ServantNameRegist_All or true == Panel_Dialog_ServantNameRegist_All:GetShow() or nil == openType then
    return
  end
  local ENUM_OPENTYPE = PaGlobal_ServantNameRegist_All._ENUM_OPENTYPE
  if ENUM_OPENTYPE._TAMING ~= openType then
    local sortedServantNo
    if nil ~= Panel_Dialog_ServantList_All then
      sortedServantNo = PaGlobalFunc_ServantList_All_Get_SortedServantNo()
    end
    if nil == sortedServantNo then
      return
    end
    PaGlobal_ServantNameRegist_All._currentServantNo = sortedServantNo
    local servantInfo = stable_getServant(sortedServantNo)
    if nil == servantInfo then
      return
    end
  end
  PaGlobal_ServantNameRegist_All._registerType = openType
  Panel_Dialog_ServantNameRegist_All:SetSize(Panel_Dialog_ServantNameRegist_All:GetSizeX(), PaGlobal_ServantNameRegist_All._ORIGIN_PANELSIZE_Y)
  PaGlobal_ServantNameRegist_All._ui._stc_MainBg:SetSize(Panel_Dialog_ServantNameRegist_All:GetSizeX(), PaGlobal_ServantNameRegist_All._ORIGIN_MAINBGSIZE_Y)
  PaGlobal_ServantNameRegist_All._ui._btn_Confirm:SetPosY(PaGlobal_ServantNameRegist_All._ORIGIN_BUTTONPOS_Y)
  PaGlobal_ServantNameRegist_All._ui._btn_Cancel:SetPosY(PaGlobal_ServantNameRegist_All._ORIGIN_BUTTONPOS_Y)
  PaGlobal_ServantNameRegist_All._ui._stc_Console_KeyGuides:SetPosY(Panel_Dialog_ServantNameRegist_All:GetSizeY())
  PaGlobal_ServantNameRegist_All._ui._stc_PriceBg:SetShow(false)
  PaGlobal_ServantNameRegist_All._ui._stc_EditNaming:SetShow(false)
  PaGlobal_ServantNameRegist_All._ui._stc_EditRentalName:SetShow(false)
  PaGlobal_ServantNameRegist_All._minPrice = nil
  PaGlobal_ServantNameRegist_All._maxPrice = nil
  local keyGuideX_Flag = PaGlobal_ServantNameRegist_All._isConsole and ENUM_OPENTYPE._REGISTER_MATING ~= openType and ENUM_OPENTYPE._REGISTER_MARKET ~= openType
  PaGlobal_ServantNameRegist_All._ui._stc_KeyGuide_X:SetShow(keyGuideX_Flag)
  if ENUM_OPENTYPE._REGISTER_MATING == openType or ENUM_OPENTYPE._REGISTER_MARKET == openType then
    if ENUM_OPENTYPE._REGISTER_MATING == openType then
      PaGlobal_ServantNameRegist_All._minPrice = servantInfo:getMinRegisterMatingPrice_s64()
      PaGlobal_ServantNameRegist_All._maxPrice = servantInfo:getMaxRegisterMatingPrice_s64()
      PaGlobal_ServantNameRegist_All._ui._rdo_Mine:SetCheck(false)
      PaGlobal_ServantNameRegist_All._ui._rdo_Mine:SetShow(true)
      PaGlobal_ServantNameRegist_All._ui._rdo_All:SetCheck(true)
      PaGlobal_ServantNameRegist_All._ui._rdo_All:SetShow(true)
      PaGlobal_ServantNameRegist_All._ui._stc_KeyGuide_X:SetShow(false)
    else
      PaGlobal_ServantNameRegist_All._minPrice = servantInfo:getMinRegisterMarketPrice_s64()
      PaGlobal_ServantNameRegist_All._maxPrice = servantInfo:getMaxRegisterMarketPrice_s64()
    end
    PaGlobal_ServantNameRegist_All._ui._stc_PriceBg:SetShow(true)
    PaGlobal_ServantNameRegist_All._ui._stc_Title:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SERVANT_MARKET_INPUT_TITLE"))
  elseif ENUM_OPENTYPE._TAMING == openType then
    PaGlobal_ServantNameRegist_All._ui._stc_EditNaming:SetShow(true)
    PaGlobal_ServantNameRegist_All._ui._stc_Title:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SERVANTREGIST_BASETITLE"))
  elseif ENUM_OPENTYPE._CHANGENAME == openType then
    PaGlobal_ServantNameRegist_All._ui._stc_EditNaming:SetShow(true)
    PaGlobal_ServantNameRegist_All._ui._stc_Title:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_COMMON_CHANGENAME"))
  elseif ENUM_OPENTYPE._REGISTER_RENTAL == openType then
    PaGlobal_ServantNameRegist_All._ui._stc_EditRentalName:SetShow(true)
    PaGlobal_ServantNameRegist_All._ui._stc_Title:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WINDOW_STABLE_PROMOTEAUTH_TITLE"))
    PaGlobal_ServantNameRegist_All._ui._stc_EditRentalName:SetEditText(PAGetString(Defines.StringSheet_GAME, "LUA_STABLE_PROMOTEAUTH_EDITBOXDESC"), true)
  else
    PaGlobal_ServantNameRegist_All._ui._stc_EditNaming:SetShow(true)
    PaGlobal_ServantNameRegist_All._ui._stc_Title:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SERVANT_NAMING_INPUT_TITLE"))
  end
  if ENUM_OPENTYPE._REGISTER_MATING ~= openType then
    PaGlobal_ServantNameRegist_All._ui._rdo_Mine:SetShow(false)
    PaGlobal_ServantNameRegist_All._ui._rdo_All:SetShow(false)
    local adjustButtonPosY = PaGlobal_ServantNameRegist_All._ui._rdo_All:GetPosY() + 3
    PaGlobal_ServantNameRegist_All._ui._btn_Confirm:SetPosY(adjustButtonPosY)
    PaGlobal_ServantNameRegist_All._ui._btn_Cancel:SetPosY(adjustButtonPosY)
    local btnSize = PaGlobal_ServantNameRegist_All._ui._rdo_Mine:GetSizeY()
    local adjustPanelSizeY = Panel_Dialog_ServantNameRegist_All:GetSizeY() - btnSize
    local adjustMainBgSizeY = PaGlobal_ServantNameRegist_All._ui._stc_MainBg:GetSizeY() - btnSize
    Panel_Dialog_ServantNameRegist_All:SetSize(Panel_Dialog_ServantNameRegist_All:GetSizeX(), adjustPanelSizeY)
    PaGlobal_ServantNameRegist_All._ui._stc_MainBg:SetSize(PaGlobal_ServantNameRegist_All._ui._stc_MainBg:GetSizeX(), adjustMainBgSizeY)
    PaGlobal_ServantNameRegist_All._ui._stc_Console_KeyGuides:SetPosY(Panel_Dialog_ServantNameRegist_All:GetSizeY())
  end
  PaGlobal_ServantNameRegist_All:prepareOpen()
end
function PaGlobalFunc_ServantNameRegist_All_OpenByMating(characterKey)
  if nil == Panel_Dialog_ServantNameRegist_All or true == Panel_Dialog_ServantNameRegist_All:GetShow() then
    return
  end
  if CppEnums.ServantType.Type_Vehicle ~= stable_getServantType() or nil == characterKey then
    return
  end
  PaGlobal_ServantNameRegist_All._registerType = CppEnums.ServantRegist.eEventType_Mating
  PaGlobal_ServantNameRegist_All._characterKey = characterKey
  PaGlobal_ServantNameRegist_All._level = 1
  PaGlobal_ServantNameRegist_All._minPrice = nil
  PaGlobal_ServantNameRegist_All._maxPrice = nil
  PaGlobalFunc_ServantNameRegist_All_OpenByEventType(PaGlobal_ServantNameRegist_All._registerType)
end
function PaGlobalFunc_ServantNameRegist_All_OpenByTaming()
  if nil == Panel_Dialog_ServantNameRegist_All or true == Panel_Dialog_ServantNameRegist_All:GetShow() then
    return
  end
  local characterKey = stable_getTamingServantCharacterKey()
  if nil == characterKey then
    return
  end
  PaGlobal_ServantNameRegist_All._registerType = CppEnums.ServantRegist.eEventType_Taming
  PaGlobal_ServantNameRegist_All._characterKey = characterKey
  PaGlobal_ServantNameRegist_All._level = 1
  PaGlobal_ServantNameRegist_All._minPrice = nil
  PaGlobal_ServantNameRegist_All._maxPrice = nil
  PaGlobalFunc_ServantNameRegist_All_OpenByEventType(PaGlobal_ServantNameRegist_All._registerType)
end
function HandleEventLUp_ServantNameRegist_All_ClickRadioButton(tab)
  if nil == Panel_Dialog_ServantNameRegist_All or false == Panel_Dialog_ServantNameRegist_All:GetShow() then
    return
  end
  local ENUM_OPENTYPE = PaGlobal_ServantNameRegist_All._ENUM_OPENTYPE
  local openType = PaGlobal_ServantNameRegist_All._registerType
  if ENUM_OPENTYPE._REGISTER_MATING == openType then
    PaGlobal_ServantNameRegist_All._ui._stc_EditNaming:SetShow(false)
    PaGlobal_ServantNameRegist_All._ui._stc_EditRentalName:SetShow(false)
    PaGlobal_ServantNameRegist_All._ui._stc_PriceBg:SetShow(true)
    if CppEnums.TransferType.TransferType_Normal == tab then
      PaGlobal_ServantNameRegist_All._registerMatingType = CppEnums.TransferType.TransferType_Normal
      if nil ~= PaGlobal_ServantNameRegist_All._minPrice then
        PaGlobal_ServantNameRegist_All._ui._txt_Price:SetText(makeDotMoney(PaGlobal_ServantNameRegist_All._minPrice))
      end
      if true == PaGlobal_ServantNameRegist_All._isConsole then
        PaGlobal_ServantNameRegist_All._ui._rdo_All:SetCheck(true)
        PaGlobal_ServantNameRegist_All._ui._rdo_Mine:SetCheck(false)
      end
    else
      PaGlobal_ServantNameRegist_All._registerMatingType = CppEnums.TransferType.TransferType_Self
      PaGlobal_ServantNameRegist_All._ui._txt_Price:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_STABLEREGISTER_MATING_PRICE", "matingPrice", tostring(getServantSelfMatingPrice())))
      if true == PaGlobal_ServantNameRegist_All._isConsole then
        PaGlobal_ServantNameRegist_All._ui._rdo_All:SetCheck(false)
        PaGlobal_ServantNameRegist_All._ui._rdo_Mine:SetCheck(true)
      end
    end
  end
end
function PaGlobalFunc_ServantNameRegist_All_Close()
  if nil == Panel_Dialog_ServantNameRegist_All or false == Panel_Dialog_ServantNameRegist_All:GetShow() then
    return
  end
  PaGlobal_ServantNameRegist_All:prepareClose()
end
function FromClient_ServantNameRegist_All_OnScreenResize()
  if nil == Panel_Dialog_ServantNameRegist_All or false == Panel_Dialog_ServantNameRegist_All:GetShow() then
    return
  end
  Panel_Dialog_ServantNameRegist_All:ComputePos()
end
function HandleEventLUp_ServantNameRegist_All_ClearEdit()
  if nil == Panel_Dialog_ServantNameRegist_All or false == Panel_Dialog_ServantNameRegist_All:GetShow() then
    return
  end
  local registerType = PaGlobal_ServantNameRegist_All._registerType
  local ENUM_OPENTYPE = PaGlobal_ServantNameRegist_All._ENUM_OPENTYPE
  if registerType == ENUM_OPENTYPE._REGISTER_MATING or registerType == ENUM_OPENTYPE._REGISTER_MARKET then
    return
  end
  if true == PaGlobal_ServantNameRegist_All._ui._stc_EditNaming:GetShow() then
    PaGlobal_ServantNameRegist_All._ui._stc_EditNaming:SetEditText("", true)
    SetFocusEdit(PaGlobal_ServantNameRegist_All._ui._stc_EditNaming)
  else
    PaGlobal_ServantNameRegist_All._ui._stc_EditRentalName:SetEditText("", true)
    SetFocusEdit(PaGlobal_ServantNameRegist_All._ui._stc_EditRentalName)
  end
end
function PaGlobalFunc_ServantNameRegist_All_ServantRegister(str)
  if nil == Panel_Dialog_ServantNameRegist_All or false == Panel_Dialog_ServantNameRegist_All:GetShow() then
    return
  end
  audioPostEvent_SystemUi(0, 0)
  ClearFocusEdit()
  local editNameControl
  if true == PaGlobal_ServantNameRegist_All._ui._stc_EditNaming:GetShow() then
    editNameControl = PaGlobal_ServantNameRegist_All._ui._stc_EditNaming
  else
    editNameControl = PaGlobal_ServantNameRegist_All._ui._stc_EditRentalName
  end
  if nil ~= str then
    editNameControl:SetEditText(str)
  end
  local name = editNameControl:GetEditText()
  local registerType = PaGlobal_ServantNameRegist_All._registerType
  local ENUM_OPENTYPE = PaGlobal_ServantNameRegist_All._ENUM_OPENTYPE
  local function do_regist()
    if ENUM_OPENTYPE._MATING == registerType then
      if nil == PaGlobal_ServantNameRegist_All._currentServantNo then
        return
      end
      local currentServantNo = PaGlobal_ServantNameRegist_All._currentServantNo
      stable_receiveServantMatingChild(currentServantNo, name)
      editNameControl:SetEditText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_ServantNameRegist_EDITDESC"), true)
    elseif ENUM_OPENTYPE._TAMING == registerType then
      if nil ~= Panel_Widget_ServantIcon then
        ServantIcon_TamingServant_Registed()
      end
      stable_register(name)
      editNameControl:SetEditText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_ServantNameRegist_EDITDESC"), true)
    elseif ENUM_OPENTYPE._CHANGENAME == registerType then
      if nil == PaGlobal_ServantNameRegist_All._currentServantNo then
        return
      end
      local currentServantNo = PaGlobal_ServantNameRegist_All._currentServantNo
      stable_changeName(currentServantNo, name)
      editNameControl:SetEditText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_ServantNameRegist_EDITDESC"), true)
    elseif ENUM_OPENTYPE._REGISTER_MARKET == registerType then
      if nil == PaGlobal_ServantNameRegist_All._currentServantNo then
        return
      end
      local currentServantNo = PaGlobal_ServantNameRegist_All._currentServantNo
      local price = PaGlobal_ServantNameRegist_All._minPrice
      if nil == price then
        return
      end
      stable_registerServantToSomeWhereElse(currentServantNo, CppEnums.AuctionType.AuctionGoods_ServantMarket, CppEnums.TransferType.TransferType_Normal, price)
    elseif ENUM_OPENTYPE._REGISTER_MATING == registerType then
      if nil == PaGlobal_ServantNameRegist_All._currentServantNo then
        return
      end
      local currentServantNo = PaGlobal_ServantNameRegist_All._currentServantNo
      local price = PaGlobal_ServantNameRegist_All._minPrice
      if CppEnums.TransferType.TransferType_Self == PaGlobal_ServantNameRegist_All._registerMatingType then
        price = getServantSelfMatingPrice()
      end
      if nil == price then
        return
      end
      stable_registerServantToSomeWhereElse(currentServantNo, CppEnums.AuctionType.AuctionGoods_ServantMating, PaGlobal_ServantNameRegist_All._registerMatingType, price)
    elseif ENUM_OPENTYPE._REGISTER_RENTAL == registerType then
      if nil == PaGlobal_ServantNameRegist_All._currentServantNo then
        return
      end
      local currentServantNo = PaGlobal_ServantNameRegist_All._currentServantNo
      local servantInfo = stable_getServant(currentServantNo)
      if nil == servantInfo then
        return
      end
      local servantNo = servantInfo:getServantNo()
      editNameControl:SetEditText(PAGetString(Defines.StringSheet_GAME, "LUA_STABLE_PROMOTEAUTH_EDITBOXDESC"), true)
      ToClient_RegisterServantForRent(servantNo, name)
    else
      UI.ASSERT(false, "Panel_Dialog_ServantNameRegist_All / PaGlobalFunc_ServantNameRegist_All_ServantRegister() ")
    end
    PaGlobalFunc_ServantNameRegist_All_Close()
  end
  if ENUM_OPENTYPE._TAMING == registerType or ENUM_OPENTYPE._CHANGENAME == registerType or ENUM_OPENTYPE._MATING == registerType then
    ClearFocusEdit()
    local _title = PAGetString(Defines.StringSheet_GAME, "LUA_MESSAGEBOX_NOTIFY")
    local _desc = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_STABLEREGISTER_THISNAMEREGISTER", "name", name)
    local _confirmFunction = do_regist
    local _cancel = MessageBox_Empty_function
    local _priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    local messageboxData = {
      title = _title,
      content = _desc,
      functionYes = _confirmFunction,
      functionNo = _cancel,
      priority = _priority
    }
    MessageBox.showMessageBox(messageboxData)
  else
    do_regist()
  end
end
function PaGlobalFunc_ServantNameRegist_All_SetPreServantCount()
  if nil == Panel_Dialog_ServantNameRegist_All or false == Panel_Dialog_ServantNameRegist_All:GetShow() then
    return
  end
  PaGlobal_ServantNameRegist_All._preServantCount = ToClient_getStableCountEx(false)
end
function PaGlobalFunc_ServantNameRegist_All_SetCurrentServantCount()
  if nil == Panel_Dialog_ServantNameRegist_All or false == Panel_Dialog_ServantNameRegist_All:GetShow() then
    return
  end
  PaGlobal_ServantNameRegist_All._currentServantCount = ToClient_getStableCountEx(false)
end
function PaGlobalFunc_ServantNameRegist_All_BeginnerMessage()
  if 0 == PaGlobal_ServantNameRegist_All._prevServantCount and 1 == PaGlobal_ServantNameRegist_All._currentServantCount then
    PaGlobal_ServantIcon_ShowBuubbleMessage()
  end
end
