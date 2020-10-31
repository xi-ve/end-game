---
-- @module MagLib
MagLib.Constants = {}

---Contains the relative path from the current script to the MagLib folder.
MagLib.Constants.magLibFolderPath = nil -- set in onInit

MagLib.Constants.scriptFolder = nil -- set in onInit

---Absolute path of the MagLib Ressource folder
MagLib.Constants.ressourceFolder = nil -- set in onInit

---KeyStrings
local keyStrings = {}
keyStrings[1] = "LButton"
keyStrings[2] = "RButton"
keyStrings[3] = "Cancel"
keyStrings[4] = "MButton"
keyStrings[8] = "BACK"
keyStrings[9] = "Tab"
keyStrings[17] = "Return"
keyStrings[18] = "Menu"
keyStrings[12] = "Clear"
keyStrings[13] = "Return"
keyStrings[16] = "Shift"
keyStrings[19] = "Pause"
keyStrings[20] = "Captial"
keyStrings[27] = "Escape"
keyStrings[32] = "Space"
keyStrings[33] = "PageUp"
keyStrings[34] = "PageDown"
keyStrings[35] = "End"
keyStrings[36] = "Home"
keyStrings[37] = "Left"
keyStrings[38] = "Up"
keyStrings[39] = "Right"
keyStrings[40] = "Down"
keyStrings[41] = "Select"
keyStrings[42] = "Print"
keyStrings[43] = "Execute"
keyStrings[44] = "Snapshot"
keyStrings[45] = "Insert"
keyStrings[46] = "Delete"
keyStrings[47] = "Help"
keyStrings[48] = "0"
keyStrings[49] = "1"
keyStrings[50] = "2"
keyStrings[51] = "3"
keyStrings[52] = "4"
keyStrings[53] = "5"
keyStrings[54] = "6"
keyStrings[55] = "7"
keyStrings[56] = "8"
keyStrings[57] = "9"
keyStrings[65] = "A"
keyStrings[66] = "B"
keyStrings[67] = "C"
keyStrings[68] = "D"
keyStrings[69] = "E"
keyStrings[70] = "F"
keyStrings[71] = "G"
keyStrings[72] = "H"
keyStrings[73] = "I"
keyStrings[74] = "J"
keyStrings[75] = "K"
keyStrings[76] = "L"
keyStrings[77] = "M"
keyStrings[78] = "N"
keyStrings[79] = "O"
keyStrings[80] = "P"
keyStrings[81] = "J"
keyStrings[82] = "R"
keyStrings[83] = "S"
keyStrings[84] = "T"
keyStrings[85] = "U"
keyStrings[86] = "V"
keyStrings[87] = "W"
keyStrings[88] = "X"
keyStrings[89] = "Y"
keyStrings[90] = "Z"
keyStrings[96] = "Numpad0"
keyStrings[97] = "Numpad1"
keyStrings[98] = "Numpad2"
keyStrings[99] = "Numpad3"
keyStrings[100] = "Numpad4"
keyStrings[101] = "Numpad5"
keyStrings[102] = "Numpad6"
keyStrings[103] = "Numpad7"
keyStrings[104] = "Numpad8"
keyStrings[105] = "Numpad9"
keyStrings[106] = "Multiply"
keyStrings[107] = "Add"
keyStrings[108] = "Separator"
keyStrings[109] = "Subtract"
keyStrings[110] = "Decimal"
keyStrings[111] = "Divide"
keyStrings[112] = "F1"
keyStrings[113] = "F2"
keyStrings[114] = "F3"
keyStrings[115] = "F4"
keyStrings[116] = "F5"
keyStrings[117] = "F6"
keyStrings[118] = "F7"
keyStrings[119] = "F8"
keyStrings[120] = "F9"
keyStrings[121] = "F10"
keyStrings[122] = "F11"
keyStrings[123] = "F12"
keyStrings[124] = "F13"
keyStrings[125] = "F14"
keyStrings[126] = "F15"
keyStrings[127] = "F16"
keyStrings[128] = "F17"
keyStrings[129] = "F18"
keyStrings[130] = "F19"
keyStrings[131] = "F20"
keyStrings[132] = "F21"
keyStrings[133] = "F22"
keyStrings[134] = "F23"
keyStrings[135] = "F24"
keyStrings[191] = "OEM2"
keyStrings[192] = "OEM3"
keyStrings[222] = "OEM7"
MagLib.Constants.keyStrings = keyStrings

local onInit = function()
    -- magLibFolderPath

    -- scriptFolder
    local tmp = MagLib.Utils.Strings.split(
                    Infinity.Scripting.CurrentScript.Directory, "\\")
    local lastEntry = "\\" .. tmp[#tmp] .. "\\"
    MagLib.Constants.scriptFolder = string.gsub(
                                        Infinity.Scripting.CurrentScript
                                            .Directory, lastEntry, "")

    MagLib.Constants.ressourceFolder = MagLib.Constants.scriptFolder ..
                                           "/Ressources"

    if MagLib.devVersion then
        MagLib.Constants.magLibFolderPath = "../dev__MagLib"
    else
        MagLib.Constants.magLibFolderPath = "../MagLib"
    end
end

MagLib.Events.addEventHandler("OnInit_Base", onInit)
