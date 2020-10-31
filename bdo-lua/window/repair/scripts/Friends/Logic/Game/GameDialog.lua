GameDialog = {}

function GameDialog.IsOpen()
    DebugManager.Trace("GameDialog.IsOpen()")

    return Infinity.BDO.Lua.Execute("return dialog_isTalking()")
end

function GameDialog.GetRequiredEnergyForMentalGame()
    local code = [[
        local dialogData = ToClient_GetCurrentDialogData()

        if dialogData == nil then
            return nil
        end

        for i = 0, dialogData:getFuncButtonCount() - 1 do
            local functionButton = dialogData:getFuncButtonAt(i)

            if tonumber(functionButton._param) == CppEnums.ContentsType.Contents_IntimacyGame then
                return functionButton:getNeedWp()
            end
        end

        return nil
    ]]

    return Infinity.BDO.Lua.Execute(code)
end