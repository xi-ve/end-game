function Panel_NumberPad_Show(isShow, s64_moneyMaxNumber, param0, confirmFunction, isExchange, param1, isItemMarket, param2, s64_weightMaxNumber)
  local numberPad = PaGlobal_NumberPad_All._numberPad
  PaGlobal_NumberPad_All._isExchange = isExchange
  local maxLength = string.len(tostring(s64_moneyMaxNumber))
  PaGlobal_NumberPad_All._ui.edit_displayNumber:SetMaxInput(maxLength + 1)
  if false == isShow then
    Panel_NumberPad_Close()
    ClearFocusEdit()
  else
    numberPad.s64_moneyMaxNumber = s64_moneyMaxNumber
    numberPad.s64_weightMaxNumber = s64_weightMaxNumber
    if nil ~= s64_weightMaxNumber then
      PaGlobal_NumberPad_All._ui.btn_weightAllSelect:SetShow(true)
      PaGlobal_NumberPad_All._ui.btn_moneyAllSelect:SetShow(false)
    else
      numberPad.s64_weightMaxNumber = Defines.s64_const.s64_0
      PaGlobal_NumberPad_All._ui.btn_moneyAllSelect:SetShow(true)
      PaGlobal_NumberPad_All._ui.btn_weightAllSelect:SetShow(false)
    end
    if true == isItemMarket then
      numberPad.s64_inputNumber = s64_moneyMaxNumber
    elseif PaGlobal_NumberPad_All._ui.chk_maxCount:IsCheck() then
      numberPad.s64_inputNumber = s64_moneyMaxNumber
    else
      numberPad.s64_inputNumber = Defines.s64_const.s64_1
    end
    if Defines.s64_const.s64_1 == s64_moneyMaxNumber then
      PaGlobal_NumberPad_All:openSetting(param0, confirmFunction, false, param1, param2)
      HandleEventLUp_NumberPad_All_ConfirmButton_Click()
    else
      PaGlobal_NumberPad_All:openSetting(param0, confirmFunction, true, param1, param2)
      if false == PaGlobal_NumberPad_All._isConsole then
        SetFocusEdit(PaGlobal_NumberPad_All._ui.edit_displayNumber)
      else
        ClearFocusEdit()
      end
      if true == isItemMarket then
        PaGlobal_NumberPad_All._ui.edit_displayNumber:SetEditText(makeDotMoney(s64_moneyMaxNumber))
      elseif PaGlobal_NumberPad_All._ui.chk_maxCount:IsCheck() then
        if true == npcShop_isGuildShopContents() and true == Panel_NumberPad_IsType("NpcShop_BuySome") and toInt64(0, 1000) < numberPad.s64_moneyMaxNumber then
          numberPad.s64_moneyMaxNumber = toInt64(0, 1000)
        end
        PaGlobal_NumberPad_All._ui.edit_displayNumber:SetEditText(makeDotMoney(s64_moneyMaxNumber))
      else
        PaGlobal_NumberPad_All._ui.edit_displayNumber:SetEditText("1")
      end
    end
  end
  PaGlobal_NumberPad_All:checkButtonShow(true)
end
function Panel_NumberPad_Show_MaxCount(isShow, s64_maxNumber, param0, confirmFunction, isExchange, param1, isItemMarket)
  PaGlobal_NumberPad_All._isExchange = isExchange
  local maxLength = string.len(tostring(s64_maxNumber))
  PaGlobal_NumberPad_All._ui.edit_displayNumber:SetMaxInput(maxLength + 1)
  PaGlobal_NumberPad_All._ui.btn_moneyAllSelect:SetShow(true)
  PaGlobal_NumberPad_All._ui.btn_weightAllSelect:SetShow(false)
  if false == isShow then
    PaGlobal_NumberPad_All_Close()
    ClearFocusEdit()
  else
    local numberPad = PaGlobal_NumberPad_All._numberPad
    numberPad.s64_moneyMaxNumber = s64_maxNumber
    if PaGlobal_NumberPad_All._ui.chk_maxCount:IsCheck() then
      numberPad.s64_inputNumber = s64_maxNumber
    else
      numberPad.s64_inputNumber = Defines.s64_const.s64_1
    end
    if Defines.s64_const.s64_1 == s64_maxNumber then
      PaGlobal_NumberPad_All:openSetting(param0, confirmFunction, false, param1)
      HandleEventLUp_NumberPad_All_ConfirmButton_Click()
    else
      PaGlobal_NumberPad_All:openSetting(param0, confirmFunction, true, param1)
      if false == PaGlobal_NumberPad_All._isConsole then
        SetFocusEdit(PaGlobal_NumberPad_All._ui.edit_displayNumber)
      else
        ClearFocusEdit()
      end
      if PaGlobal_NumberPad_All._ui.chk_maxCount:IsCheck() then
        PaGlobal_NumberPad_All._ui.edit_displayNumber:SetEditText(makeDotMoney(s64_maxNumber))
      else
        PaGlobal_NumberPad_All._ui.edit_displayNumber:SetEditText("1")
      end
    end
  end
  PaGlobal_NumberPad_All:checkButtonShow(true)
end
function Panel_NumberPad_Close()
  if nil == Panel_Window_NumberPad_All then
    return
  end
  PaGlobal_NumberPad_All:prepareClose()
end
function PaGlobal_NumberPad_All_ShowAni()
  UIAni.fadeInSCR_Down(Panel_Window_NumberPad_All)
end
function PaGlobal_NumberPad_All_HideAni()
  Panel_Window_NumberPad_All:SetShowWithFade(CppEnums.PAUI_SHOW_FADE_TYPE.PAUI_ANI_TYPE_FADE_OUT)
  local aniInfo1 = Panel_Window_NumberPad_All:addColorAnimation(0, 0.22, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
  aniInfo1:SetStartColor(Defines.Color.C_FFFFFFFF)
  aniInfo1:SetEndColor(Defines.Color.C_00FFFFFF)
  aniInfo1:SetStartIntensity(3)
  aniInfo1:SetEndIntensity(1)
  aniInfo1.IsChangeChild = true
  aniInfo1:SetHideAtEnd(true)
  aniInfo1:SetDisableWhileAni(true)
end
function Panel_NumberPad_IsType(_type)
  return PaGlobal_NumberPad_All._numberPad._type == _type
end
function Panel_NumberPad_SetType(_type)
  PaGlobal_NumberPad_All._numberPad._type = _type
end
function Panel_NumberPad_IsPopUp()
  return Panel_Window_NumberPad_All:IsShow()
end
function PaGlobal_NumberPad_All_GetShow()
  if nil == Panel_Window_NumberPad_All then
    return false
  end
  return Panel_Window_NumberPad_All:GetShow()
end
function PaGlobal_NumberPad_All_NumberKey_Input()
  for idx, val in ipairs(PaGlobal_NumberPad_All._numberKeyCode) do
    if isKeyPressed(val) then
      HandleEventLUp_NumberPad_All_NumberButton_Click(nil)
    end
  end
  if isKeyDown_Once(CppEnums.VirtualKeyCode.KeyCode_BACK) or isKeyDown_Once(CppEnums.VirtualKeyCode.KeyCode_DELETE) then
    HandleEventLUp_NumberPad_All_BackSpaceButton_Click(true)
  end
end
function PaGlobal_NumberPad_All_CancleSetting(cancleFunction)
  PaGlobal_NumberPad_All:cancleSetting(cancleFunction)
end
function HandleEventScroll_NumberPad_All_ChangeCount(isUp)
  local curNumber = PaGlobal_NumberPad_All._numberPad.s64_inputNumber
  if true == isUp then
    if curNumber >= PaGlobal_NumberPad_All._numberPad.s64_moneyMaxNumber then
      return
    end
    curNumber = curNumber + toInt64(0, 1)
  elseif false == isUp then
    if 1 >= Int64toInt32(curNumber) then
      return
    end
    curNumber = curNumber - toInt64(0, 1)
  end
  PaGlobal_NumberPad_All._ui.edit_displayNumber:SetEditText(makeDotMoney(curNumber))
  PaGlobal_NumberPad_All._numberPad.s64_inputNumber = curNumber
  PaGlobal_NumberPad_All:updateConfirmButton()
end
function HandleEventLUp_NumberPad_All_NumberButton_Click(number)
  local curNumber = PaGlobal_NumberPad_All._ui.edit_displayNumber:GetEditText()
  if true == PaGlobal_NumberPad_All._numberPad.init_Number then
    PaGlobal_NumberPad_All._numberPad.init_Number = false
    if nil == number then
      curNumber = string.sub(curNumber, -1)
    else
      curNumber = tostring(number)
    end
  else
    if nil ~= number then
      curNumber = curNumber .. tostring(number)
    end
    curNumber = string.gsub(curNumber, ",", "")
  end
  local s64_newNumber = tonumber64(curNumber)
  local s64_MAX = PaGlobal_NumberPad_All._numberPad.s64_moneyMaxNumber
  if s64_newNumber > s64_MAX then
    PaGlobal_NumberPad_All._numberPad.s64_inputNumber = s64_MAX
  elseif 0 == string.len(curNumber) then
    PaGlobal_NumberPad_All._numberPad.s64_inputNumber = 0
  else
    PaGlobal_NumberPad_All._numberPad.s64_inputNumber = s64_newNumber
  end
  PaGlobal_NumberPad_All._ui.edit_displayNumber:SetEditText(makeDotMoney(PaGlobal_NumberPad_All._numberPad.s64_inputNumber))
  PaGlobal_NumberPad_All:updateConfirmButton(PaGlobal_NumberPad_All._isExchange)
end
function HandleEventLUp_NumberPad_All_ClearButton_Click()
  PaGlobal_NumberPad_All._numberPad.s64_inputNumber = Defines.s64_const.s64_0
  PaGlobal_NumberPad_All._ui.edit_displayNumber:SetEditText("0")
  PaGlobal_NumberPad_All:updateConfirmButton()
end
function HandleEventLUp_NumberPad_All_BackSpaceButton_Click(fromOnKey)
  local str = tostring(PaGlobal_NumberPad_All._numberPad.s64_inputNumber)
  local length = string.len(str)
  local numberPad = PaGlobal_NumberPad_All._numberPad
  if 1 < length then
    local newStr = string.sub(str, 1, length - 1)
    numberPad.s64_inputNumber = tonumber64(newStr)
  else
    numberPad.init_Number = true
    numberPad.s64_inputNumber = Defines.s64_const.s64_0
  end
  PaGlobal_NumberPad_All._ui.edit_displayNumber:SetEditText(makeDotMoney(numberPad.s64_inputNumber))
  PaGlobal_NumberPad_All:updateConfirmButton()
end
function HandleEventLUp_NumberPad_All_ConfirmButton_Click()
  if PaGlobal_NumberPad_All:checkConfirmEnable() or true == PaGlobal_NumberPad_All._isExchange then
    local numberPad = PaGlobal_NumberPad_All._numberPad
    if nil ~= numberPad.confirmFunction then
      numberPad.confirmFunction(numberPad.s64_inputNumber, numberPad.param0, numberPad.param1, numberPad.param2)
    end
    Panel_NumberPad_Show(false, Defines.s64_const.s64_0, 0, nil)
  end
end
function HandleEventLUp_NumberPad_All_CancelButton_Click()
  Panel_NumberPad_Show(false, Defines.s64_const.s64_0, 0, nil)
  local numberPad = PaGlobal_NumberPad_All._numberPad
  if nil ~= numberPad.cancleFunction then
    numberPad.cancleFunction()
  end
end
function HandleEventLUp_NumberPad_All_AllButton_Click(isType)
  local numberPad = PaGlobal_NumberPad_All._numberPad
  if true == npcShop_isGuildShopContents() and true == Panel_NumberPad_IsType("NpcShop_BuySome") and toInt64(0, 1000) < numberPad.s64_moneyMaxNumber then
    numberPad.s64_moneyMaxNumber = toInt64(0, 1000)
  end
  if 1 == isType then
    numberPad.s64_inputNumber = numberPad.s64_moneyMaxNumber
    if false == PaGlobal_NumberPad_All._isConsole then
      SetFocusEdit(PaGlobal_NumberPad_All._ui.edit_displayNumber)
    else
      ClearFocusEdit()
    end
    if false == PaGlobal_NumberPad_All._ui.chk_maxCount:IsCheck() then
      PaGlobal_NumberPad_All._ui.edit_displayNumber:SetEditText(tostring(Defines.s64_const.s64_1))
      numberPad.s64_inputNumber = Defines.s64_const.s64_1
    else
      PaGlobal_NumberPad_All._ui.edit_displayNumber:SetEditText(makeDotMoney(numberPad.s64_moneyMaxNumber))
      PaGlobal_NumberPad_All._numberPad.s64_inputNumber = numberPad.s64_moneyMaxNumber
    end
  elseif 0 == isType then
    numberPad.s64_inputNumber = numberPad.s64_moneyMaxNumber
    if Defines.s64_const.s64_1 == numberPad.s64_moneyMaxNumber then
      HandleEventLUp_NumberPad_All_ConfirmButton_Click()
    else
      if false == PaGlobal_NumberPad_All._isConsole then
        SetFocusEdit(PaGlobal_NumberPad_All._ui.edit_displayNumber)
      else
        ClearFocusEdit()
      end
      PaGlobal_NumberPad_All._ui.edit_displayNumber:SetEditText(makeDotMoney(numberPad.s64_moneyMaxNumber))
      PaGlobal_NumberPad_All._numberPad.s64_inputNumber = numberPad.s64_moneyMaxNumber
    end
  elseif 2 == isType then
    numberPad.s64_inputNumber = numberPad.s64_weightMaxNumber
    if Defines.s64_const.s64_1 == numberPad.s64_weightMaxNumber then
      HandleEventLUp_NumberPad_All_ConfirmButton_Click()
    else
      if false == PaGlobal_NumberPad_All._isConsole then
        SetFocusEdit(PaGlobal_NumberPad_All._ui.edit_displayNumber)
      else
        ClearFocusEdit()
      end
      PaGlobal_NumberPad_All._ui.edit_displayNumber:SetEditText(makeDotMoney(numberPad.s64_weightMaxNumber))
      PaGlobal_NumberPad_All._numberPad.s64_inputNumber = numberPad.s64_weightMaxNumber
    end
  end
  PaGlobal_NumberPad_All:updateConfirmButton()
end
