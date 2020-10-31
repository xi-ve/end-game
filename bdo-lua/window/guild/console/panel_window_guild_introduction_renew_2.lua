function InputYUp_GuildIntroduction_Regist()
  if nil == Panel_Window_Guild_Introduction_Renew then
    return
  end
  PaGlobal_GuildIntroduction:registIntroduction()
end
function InputAUp_GuildIntroduction_SetSalary()
  if nil == Panel_Window_Guild_Introduction_Renew then
    return
  end
  local maxDailyPay = tonumber(CppEnums.GuildBenefit.eMaxContractedBenefit)
  Panel_NumberPad_Show(true, toInt64(0, maxDailyPay), nil, PaGlobalFunc_GuildIntroduction_DailyPayComfirm, nil, nil, nil, nil, toInt64(0, maxDailyPay))
end
function PaGlobalFunc_GuildIntroduction_DailyPayComfirm(inputNumber)
  if nil == Panel_Window_Guild_Introduction_Renew then
    return
  end
  PaGlobal_GuildIntroduction._ui.txt_Salary:SetText(makeDotMoney(Int64toInt32(inputNumber)))
end
function PaGlobalFunc_GuildIntroduction_Open()
  if nil == Panel_Window_Guild_Introduction_Renew then
    return
  end
  PaGlobal_GuildIntroduction:prepareOpen()
end
function PaGlobalFunc_GuildIntroduction_Close()
  if nil == Panel_Window_Guild_Introduction_Renew then
    return
  end
  PaGlobal_GuildIntroduction:prepareClose()
end
