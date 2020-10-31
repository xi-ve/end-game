function PaGlobalFunc_BlooaAltarRetry_RetryCheck(isRetry)
  if true == isRetry then
    if true == ToClient_HasInstanceSavageDefenceReGameItem() then
      ToClient_SetSubScriptReGameForInstanceField(true)
    else
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoItemNotExist"))
    end
  elseif false == isRetry then
    ToClient_SetSubScriptReGameForInstanceField(false)
  else
    _PA_LOG("\235\172\184\236\158\165\237\153\152", "PaGlobalFunc_BlooaAltarRetry_RetryCheck\236\151\144 \235\140\128\237\149\156 \236\158\152\235\170\187\235\144\156 \236\160\145\234\183\188\236\158\133\235\139\136\235\139\164.")
  end
end
