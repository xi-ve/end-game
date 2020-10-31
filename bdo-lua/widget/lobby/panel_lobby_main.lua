local UI_color = Defines.Color
local ePcWorkingType = CppEnums.PcWorkType
local const_64 = Defines.s64_const
local isAwakenOpen = {
  [__eClassType_Warrior] = ToClient_IsContentsGroupOpen("901"),
  [__eClassType_ElfRanger] = ToClient_IsContentsGroupOpen("902"),
  [__eClassType_Sorcerer] = ToClient_IsContentsGroupOpen("903"),
  [__eClassType_Giant] = ToClient_IsContentsGroupOpen("904"),
  [__eClassType_Tamer] = ToClient_IsContentsGroupOpen("905"),
  [__eClassType_BladeMaster] = ToClient_IsContentsGroupOpen("906"),
  [__eClassType_BladeMasterWoman] = ToClient_IsContentsGroupOpen("907"),
  [__eClassType_Valkyrie] = ToClient_IsContentsGroupOpen("908"),
  [__eClassType_WizardMan] = ToClient_IsContentsGroupOpen("909"),
  [__eClassType_WizardWoman] = ToClient_IsContentsGroupOpen("910"),
  [__eClassType_NinjaMan] = ToClient_IsContentsGroupOpen("911"),
  [__eClassType_Kunoichi] = ToClient_IsContentsGroupOpen("912"),
  [__eClassType_DarkElf] = ToClient_IsContentsGroupOpen("913"),
  [__eClassType_Combattant] = ToClient_IsContentsGroupOpen("914"),
  [__eClassType_Mystic] = ToClient_IsContentsGroupOpen("918"),
  [__eClassType_Lhan] = ToClient_IsContentsGroupOpen("916"),
  [__eClassType_RangerMan] = ToClient_IsContentsGroupOpen("942"),
  [__eClassType_Sorcerer_Reserved1] = false,
  [__eClassType_ShyWaman] = ToClient_IsContentsGroupOpen("1366"),
  [__eClassType_ShyMan] = false,
  [__eClassType_BladeMaster_Reserved1] = false,
  [__eClassType_Hashashin] = ToClient_IsContentsGroupOpen("1136"),
  [__eClassType_Guardian] = ToClient_IsContentsGroupOpen("1317"),
  [__eClassType_Unknown2] = ToClient_IsContentsGroupOpen("1317"),
  [__eClassType_Sorcerer_Reserved0] = ToClient_IsContentsGroupOpen("1466"),
  [__eClassType_Warrior_Reserve2] = ToClient_IsContentsGroupOpen("1478")
}
if nil ~= Panel_CharacterSelect then
  Panel_CharacterSelect:SetShow(false, false)
end
local CCSC_Frame = UI.getChildControl(Panel_CharacterCreateSelectClass, "Frame_CharacterSelect")
local _frameContents = UI.getChildControl(CCSC_Frame, "Frame_1_Content")
local _frameScroll = UI.getChildControl(CCSC_Frame, "Frame_1_VerticalScroll")
local bottomFrame = UI.getChildControl(Panel_CharacterCreateSelectClass, "Frame_BottomDesc")
local _frameBottomDesc = UI.getChildControl(bottomFrame, "Frame_1_Content")
local tooltipDescSaved = PAGetString(Defines.StringSheet_GAME, "LUA_SELECTCLASS_AWAKENWEAPONDESC")
local tooltipNameSaved = PAGetString(Defines.StringSheet_GAME, "LUA_SELECTCLASS_AWAKENWEAPONTITLE")
local Panel_Lobby_ClassUI = {
  ClassButtons = {},
  ClassNames = {},
  ClassStatus = {}
}
local txt_BottomDesc = UI.getChildControl(_frameBottomDesc, "StaticText_Desc")
Panel_Lobby_ClassUI.ClassButtons[__eClassType_Warrior] = UI.getChildControl(_frameContents, "RadioButton_Select_Warrior")
Panel_Lobby_ClassUI.ClassButtons[__eClassType_ElfRanger] = UI.getChildControl(_frameContents, "RadioButton_Select_Ranger")
Panel_Lobby_ClassUI.ClassButtons[__eClassType_Sorcerer] = UI.getChildControl(_frameContents, "RadioButton_Select_Sorcer")
Panel_Lobby_ClassUI.ClassButtons[__eClassType_Giant] = UI.getChildControl(_frameContents, "RadioButton_Select_Giant")
Panel_Lobby_ClassUI.ClassButtons[__eClassType_Tamer] = UI.getChildControl(_frameContents, "RadioButton_Select_Tamer")
Panel_Lobby_ClassUI.ClassButtons[__eClassType_BladeMaster] = UI.getChildControl(_frameContents, "RadioButton_Select_BladeMaster")
Panel_Lobby_ClassUI.ClassButtons[__eClassType_BladeMasterWoman] = UI.getChildControl(_frameContents, "RadioButton_Select_BladeMasterWomen")
Panel_Lobby_ClassUI.ClassButtons[__eClassType_Valkyrie] = UI.getChildControl(_frameContents, "RadioButton_Select_Valkyrie")
Panel_Lobby_ClassUI.ClassButtons[__eClassType_WizardMan] = UI.getChildControl(_frameContents, "RadioButton_Select_Wizard")
Panel_Lobby_ClassUI.ClassButtons[__eClassType_WizardWoman] = UI.getChildControl(_frameContents, "RadioButton_Select_WizardWomen")
Panel_Lobby_ClassUI.ClassButtons[__eClassType_Kunoichi] = UI.getChildControl(_frameContents, "RadioButton_Select_NinjaWomen")
Panel_Lobby_ClassUI.ClassButtons[__eClassType_NinjaMan] = UI.getChildControl(_frameContents, "RadioButton_Select_Kunoichi")
Panel_Lobby_ClassUI.ClassButtons[__eClassType_ShyWaman] = UI.getChildControl(_frameContents, "RadioButton_Select_ShyWomen")
Panel_Lobby_ClassUI.ClassButtons[__eClassType_ShyMan] = UI.getChildControl(_frameContents, "RadioButton_Select_Shy")
Panel_Lobby_ClassUI.ClassButtons[__eClassType_BladeMaster_Reserved1] = UI.getChildControl(_frameContents, "RadioButton_Select_Temp")
Panel_Lobby_ClassUI.ClassButtons[__eClassType_DarkElf] = UI.getChildControl(_frameContents, "RadioButton_Select_DarkElf")
Panel_Lobby_ClassUI.ClassButtons[2] = UI.getChildControl(_frameContents, "RadioButton_Select_Temp1")
Panel_Lobby_ClassUI.ClassButtons[__eClassType_Sorcerer_Reserved1] = UI.getChildControl(_frameContents, "RadioButton_Select_Temp2")
Panel_Lobby_ClassUI.ClassButtons[__eClassType_Lhan] = UI.getChildControl(_frameContents, "RadioButton_Select_Angle")
Panel_Lobby_ClassUI.ClassButtons[__eClassType_Combattant] = UI.getChildControl(_frameContents, "RadioButton_Select_Combattant")
Panel_Lobby_ClassUI.ClassButtons[__eClassType_Mystic] = UI.getChildControl(_frameContents, "RadioButton_Select_CombattantWomen")
Panel_Lobby_ClassUI.ClassButtons[__eClassType_RangerMan] = UI.getChildControl(_frameContents, "RadioButton_Select_Orange")
Panel_Lobby_ClassUI.ClassButtons[__eClassType_Hashashin] = UI.getChildControl(_frameContents, "RadioButton_Select_SnowBucks")
Panel_Lobby_ClassUI.ClassButtons[__eClassType_Guardian] = UI.getChildControl(_frameContents, "RadioButton_Select_Unknown1")
Panel_Lobby_ClassUI.ClassButtons[__eClassType_Unknown2] = UI.getChildControl(_frameContents, "RadioButton_Select_Unknown2")
Panel_Lobby_ClassUI.ClassButtons[__eClassType_Sorcerer_Reserved0] = UI.getChildControl(_frameContents, "RadioButton_Select_Unknown3")
Panel_Lobby_ClassUI.ClassButtons[__eClassType_Warrior_Reserve2] = UI.getChildControl(_frameContents, "RadioButton_Select_Unknown4")
Panel_Lobby_ClassUI.ClassNames[__eClassType_Warrior] = UI.getChildControl(_frameContents, "StaticText_WarriorName")
Panel_Lobby_ClassUI.ClassNames[__eClassType_ElfRanger] = UI.getChildControl(_frameContents, "StaticText_RangerName")
Panel_Lobby_ClassUI.ClassNames[__eClassType_Sorcerer] = UI.getChildControl(_frameContents, "StaticText_SorcerName")
Panel_Lobby_ClassUI.ClassNames[__eClassType_Giant] = UI.getChildControl(_frameContents, "StaticText_GiantName")
Panel_Lobby_ClassUI.ClassNames[__eClassType_Tamer] = UI.getChildControl(_frameContents, "StaticText_TamerName")
Panel_Lobby_ClassUI.ClassNames[__eClassType_BladeMaster] = UI.getChildControl(_frameContents, "StaticText_BladeMasterName")
Panel_Lobby_ClassUI.ClassNames[__eClassType_BladeMasterWoman] = UI.getChildControl(_frameContents, "StaticText_BladeMasterWomenName")
Panel_Lobby_ClassUI.ClassNames[__eClassType_Valkyrie] = UI.getChildControl(_frameContents, "StaticText_ValkyrieName")
Panel_Lobby_ClassUI.ClassNames[__eClassType_WizardMan] = UI.getChildControl(_frameContents, "StaticText_WizardName")
Panel_Lobby_ClassUI.ClassNames[__eClassType_WizardWoman] = UI.getChildControl(_frameContents, "StaticText_WizardWomenName")
Panel_Lobby_ClassUI.ClassNames[__eClassType_Kunoichi] = UI.getChildControl(_frameContents, "StaticText_NinjaWomenName")
Panel_Lobby_ClassUI.ClassNames[__eClassType_NinjaMan] = UI.getChildControl(_frameContents, "StaticText_KunoichiName")
Panel_Lobby_ClassUI.ClassNames[__eClassType_ShyWaman] = UI.getChildControl(_frameContents, "StaticText_ShyWomenName")
Panel_Lobby_ClassUI.ClassNames[__eClassType_ShyMan] = UI.getChildControl(_frameContents, "StaticText_ShyName")
Panel_Lobby_ClassUI.ClassNames[__eClassType_BladeMaster_Reserved1] = UI.getChildControl(_frameContents, "StaticText_TempName")
Panel_Lobby_ClassUI.ClassNames[__eClassType_DarkElf] = UI.getChildControl(_frameContents, "StaticText_DarkElfName")
Panel_Lobby_ClassUI.ClassNames[2] = UI.getChildControl(_frameContents, "StaticText_Temp1Name")
Panel_Lobby_ClassUI.ClassNames[__eClassType_Sorcerer_Reserved1] = UI.getChildControl(_frameContents, "StaticText_Temp2Name")
Panel_Lobby_ClassUI.ClassNames[__eClassType_Lhan] = UI.getChildControl(_frameContents, "StaticText_AngleName")
Panel_Lobby_ClassUI.ClassNames[__eClassType_Combattant] = UI.getChildControl(_frameContents, "StaticText_CombattantName")
Panel_Lobby_ClassUI.ClassNames[__eClassType_Mystic] = UI.getChildControl(_frameContents, "StaticText_CombattantWomenName")
Panel_Lobby_ClassUI.ClassNames[__eClassType_RangerMan] = UI.getChildControl(_frameContents, "StaticText_OrangeName")
Panel_Lobby_ClassUI.ClassNames[__eClassType_Hashashin] = UI.getChildControl(_frameContents, "StaticText_SnowBucksName")
Panel_Lobby_ClassUI.ClassNames[__eClassType_Guardian] = UI.getChildControl(_frameContents, "StaticText_Unknown1Name")
Panel_Lobby_ClassUI.ClassNames[__eClassType_Unknown2] = UI.getChildControl(_frameContents, "StaticText_Unknown2Name")
Panel_Lobby_ClassUI.ClassNames[__eClassType_Sorcerer_Reserved0] = UI.getChildControl(_frameContents, "StaticText_Unknown3Name")
Panel_Lobby_ClassUI.ClassNames[__eClassType_Warrior_Reserve2] = UI.getChildControl(_frameContents, "StaticText_Unknown4Name")
Panel_Lobby_ClassUI.ClassStatus[__eClassType_Warrior] = UI.getChildControl(Panel_CharacterCreateSelectClass, "Static_Stat_Warrior")
Panel_Lobby_ClassUI.ClassStatus[__eClassType_ElfRanger] = UI.getChildControl(Panel_CharacterCreateSelectClass, "Static_Stat_Ranger")
Panel_Lobby_ClassUI.ClassStatus[__eClassType_Sorcerer] = UI.getChildControl(Panel_CharacterCreateSelectClass, "Static_Stat_Sorcerer")
Panel_Lobby_ClassUI.ClassStatus[__eClassType_Giant] = UI.getChildControl(Panel_CharacterCreateSelectClass, "Static_Stat_Giant")
Panel_Lobby_ClassUI.ClassStatus[__eClassType_Tamer] = UI.getChildControl(Panel_CharacterCreateSelectClass, "Static_Stat_BeastMaster")
Panel_Lobby_ClassUI.ClassStatus[__eClassType_BladeMaster] = UI.getChildControl(Panel_CharacterCreateSelectClass, "Static_Stat_BladerMaster")
Panel_Lobby_ClassUI.ClassStatus[__eClassType_BladeMasterWoman] = UI.getChildControl(Panel_CharacterCreateSelectClass, "Static_Stat_BladerMasterWomen")
Panel_Lobby_ClassUI.ClassStatus[__eClassType_Valkyrie] = UI.getChildControl(Panel_CharacterCreateSelectClass, "Static_Stat_Valkyrie")
Panel_Lobby_ClassUI.ClassStatus[__eClassType_WizardMan] = UI.getChildControl(Panel_CharacterCreateSelectClass, "Static_Stat_Wizard")
Panel_Lobby_ClassUI.ClassStatus[__eClassType_WizardWoman] = UI.getChildControl(Panel_CharacterCreateSelectClass, "Static_Stat_Wizard")
Panel_Lobby_ClassUI.ClassStatus[__eClassType_Kunoichi] = UI.getChildControl(Panel_CharacterCreateSelectClass, "Static_Stat_NinjaWomen")
Panel_Lobby_ClassUI.ClassStatus[__eClassType_NinjaMan] = UI.getChildControl(Panel_CharacterCreateSelectClass, "Static_Stat_NinjaWomen")
Panel_Lobby_ClassUI.ClassStatus[__eClassType_ShyWaman] = UI.getChildControl(Panel_CharacterCreateSelectClass, "Static_Stat_ShyWomen")
Panel_Lobby_ClassUI.ClassStatus[__eClassType_ShyMan] = UI.getChildControl(Panel_CharacterCreateSelectClass, "Static_Stat_NinjaWomen")
Panel_Lobby_ClassUI.ClassStatus[__eClassType_BladeMaster_Reserved1] = UI.getChildControl(Panel_CharacterCreateSelectClass, "Static_Stat_Temp")
Panel_Lobby_ClassUI.ClassStatus[__eClassType_DarkElf] = UI.getChildControl(Panel_CharacterCreateSelectClass, "Static_Stat_DarkElf")
Panel_Lobby_ClassUI.ClassStatus[__eClassType_Combattant] = UI.getChildControl(Panel_CharacterCreateSelectClass, "Static_Stat_Striker")
Panel_Lobby_ClassUI.ClassStatus[2] = UI.getChildControl(Panel_CharacterCreateSelectClass, "Static_Stat_Temp1")
Panel_Lobby_ClassUI.ClassStatus[__eClassType_Sorcerer_Reserved1] = UI.getChildControl(Panel_CharacterCreateSelectClass, "Static_Stat_Temp2")
Panel_Lobby_ClassUI.ClassStatus[__eClassType_Lhan] = UI.getChildControl(Panel_CharacterCreateSelectClass, "Static_Stat_Angle")
Panel_Lobby_ClassUI.ClassStatus[__eClassType_Mystic] = UI.getChildControl(Panel_CharacterCreateSelectClass, "Static_Stat_Temp5")
Panel_Lobby_ClassUI.ClassStatus[__eClassType_RangerMan] = UI.getChildControl(Panel_CharacterCreateSelectClass, "Static_Stat_Orange")
Panel_Lobby_ClassUI.ClassStatus[__eClassType_Hashashin] = UI.getChildControl(Panel_CharacterCreateSelectClass, "Static_Stat_SnowBucks")
Panel_Lobby_ClassUI.ClassStatus[__eClassType_Guardian] = UI.getChildControl(Panel_CharacterCreateSelectClass, "Static_Stat_Unknown1")
Panel_Lobby_ClassUI.ClassStatus[__eClassType_Unknown2] = UI.getChildControl(Panel_CharacterCreateSelectClass, "Static_Stat_Unknown2")
Panel_Lobby_ClassUI.ClassStatus[__eClassType_Sorcerer_Reserved0] = UI.getChildControl(Panel_CharacterCreateSelectClass, "Static_Stat_Unknown3")
Panel_Lobby_ClassUI.ClassStatus[__eClassType_Warrior_Reserve2] = UI.getChildControl(Panel_CharacterCreateSelectClass, "Static_Stat_Unknown4")
local Panel_Lobby_UI = {
  CC_CharacterCreateText = UI.getChildControl(Panel_CharacterCreate, "StaticText_CharacterCreate"),
  CC_CharacterNameEdit = UI.getChildControl(Panel_CharacterCreate, "Edit_CharacterName"),
  CC_CreateButton = UI.getChildControl(Panel_CharacterCreate, "Button_CharacterCreateStart"),
  CC_BackButton = UI.getChildControl(Panel_CharacterCreate, "Button_Back"),
  CC_DumiText1 = UI.getChildControl(Panel_CharacterCreate, "StaticText_1"),
  CC_characterCreateBG = UI.getChildControl(Panel_CharacterCreate, "Static_BG"),
  CC_DumiText3 = UI.getChildControl(Panel_CharacterCreate, "StaticText_3"),
  CC_DumiText4 = UI.getChildControl(Panel_CharacterCreate, "StaticText_4"),
  CC_FrameHead = UI.getChildControl(Panel_CharacterCreate, "Frame_Head"),
  CC_FrameHead_Content = nil,
  CC_FrameHead_Content_Image = nil,
  CC_FrameHead_Scroll = nil,
  CC_FrameHair = UI.getChildControl(Panel_CharacterCreate, "Frame_Hair"),
  CC_FrameHair_Content = nil,
  CC_FrameHair_Content_Image = nil,
  CC_FrameHair_Scroll = nil,
  CC_SelectClassButton = UI.getChildControl(Panel_CharacterCreate, "Button_SelectClass"),
  CC_CBTText = UI.getChildControl(Panel_CharacterCreate, "StaticText_CBT"),
  CCSC_CreateTitle = UI.getChildControl(Panel_CharacterCreateSelectClass, "StaticText_Title"),
  CCSC_ClassName = UI.getChildControl(Panel_CharacterCreateSelectClass, "StaticText_ClassName"),
  CCSC_PartLine = UI.getChildControl(Panel_CharacterCreateSelectClass, "Static_PartLine"),
  CCSC_ClassDescBG = UI.getChildControl(Panel_CharacterCreateSelectClass, "Static_Desc_BG"),
  CCSC_ClassDesc = UI.getChildControl(Panel_CharacterCreateSelectClass, "StaticText_Description"),
  CCSC_CreateButton = UI.getChildControl(Panel_CharacterCreateSelectClass, "Button_CharacterCreateStart"),
  CCSC_CreateBG = UI.getChildControl(Panel_CharacterCreateSelectClass, "Static_BG"),
  CCSC_RadioNormalMovie = UI.getChildControl(Panel_CharacterCreateSelectClass, "RadioButton_Normal"),
  CCSC_RadioAwakenMovie = UI.getChildControl(Panel_CharacterCreateSelectClass, "RadioButton_Awaken"),
  CCSC_ClassMovie = UI.createControl(__ePAUIControl_WebControl, Panel_CharacterCreateSelectClass, "Static_ClassMovie"),
  CCSC_BackButton = UI.getChildControl(Panel_CharacterCreateSelectClass, "Button_Back"),
  CCSC_SelectClassButton = UI.getChildControl(Panel_CharacterCreateSelectClass, "Button_SelectClass"),
  CCSC_NoMovie = UI.getChildControl(Panel_CharacterCreateSelectClass, "StaticText_NoMovie"),
  CCSC_LeaveConsole = UI.getChildControl(Panel_CharacterCreateSelectClass, "StaticText_Leave_ConsoleUI"),
  CCSC_SelectConsole = UI.getChildControl(Panel_CharacterCreateSelectClass, "StaticText_Select"),
  CM_Edit_CharacterName
}
if false == _ContentsGroup_RenewUI_Customization then
  Panel_Lobby_UI.CM_Edit_CharacterName = UI.getChildControl(Panel_CustomizationMain, "Edit_CharacterName")
end
local Character_Status = {
  _stat_Ctrl = UI.getChildControl(Panel_CharacterCreateSelectClass, "StaticText_Stat_Ctrl"),
  _stat_Att = UI.getChildControl(Panel_CharacterCreateSelectClass, "StaticText_Stat_Att"),
  _stat_Def = UI.getChildControl(Panel_CharacterCreateSelectClass, "StaticText_Stat_Def"),
  _stat_Evd = UI.getChildControl(Panel_CharacterCreateSelectClass, "StaticText_Stat_Evd"),
  _stat_Cmb = UI.getChildControl(Panel_CharacterCreateSelectClass, "StaticText_Stat_Cmb")
}
local Panel_Lobby_Global_Variable = {
  currentSelectedIdx = -1,
  UIList = {},
  UiMaker = nil,
  characterSelect = -1,
  notClearValueCharacterSelect = -1,
  characterSelectType = -1,
  selectRegionInfo = nil,
  isWaitLine = false,
  selectCharacterLevel = -1
}
local Panel_Lobby_Enum = {
  eRotate_Left = 0,
  eRotate_Right = 1,
  eDistance_Far = 2,
  eDistance_Near = 3,
  eArrow_Up = 4,
  eArrow_Down = 5,
  eArrow_Left = 6,
  eArrow_Right = 7,
  eCharacterCustomization_HeadMesh = 0,
  eCharacterCustomization_HairMesh = 1
}
local sortCharacterCount = 1
local columnCountByRaw = 4
local columnCount = 0
local rowCount = 0
local classNameStartX = 18
local classNameStartY = 120
local classNameGapX = 17
local classNameGapY = 130
local classButtonStartX = 15
local classButtonGapX = 10
local classButtonGapY = 5
local _CharInfo_BG = UI.getChildControl(Panel_CharacterSelect, "Static_CharInfo_BG")
_CharInfo_BG:setGlassBackground(false)
local Panel_CharacterDoing = {
  _CharInfo_Name = UI.getChildControl(Panel_CharacterSelect, "StaticText_CharInfo_Name"),
  _CharInfo_GaugeBG = UI.getChildControl(Panel_CharacterSelect, "Static_CharInfo_GaugeBG"),
  _CharInfo_Gauge = UI.getChildControl(Panel_CharacterSelect, "Progress2_CharInfo_Gauge"),
  _CharInfo_DoText = UI.getChildControl(Panel_CharacterSelect, "StaticText_CharInfo_Do"),
  _CharInfo_NowPos = UI.getChildControl(Panel_CharacterSelect, "StaticText_CharInfo_NowPos"),
  _CharInfo_WhereText = UI.getChildControl(Panel_CharacterSelect, "StaticText_CharInfo_Where"),
  _ticketNoByRegion = UI.getChildControl(Panel_CharacterSelect, "StaticText_TicketNoByRegion")
}
local characterSelect_DoWork = {
  _doWork_BG = UI.getChildControl(Panel_CharacterSelect, "Static_Work_BG"),
  _doWork_GaugeBG = UI.getChildControl(Panel_CharacterSelect, "Static_Work_GaugeBG"),
  _doWork_Gauge = UI.getChildControl(Panel_CharacterSelect, "Static_Work_Gauge"),
  _doWork_Icon = UI.getChildControl(Panel_CharacterSelect, "Static_Work_Icon")
}
local Panel_Customization = {
  group = {}
}
local Panel_Lobby_LDownCheck_ViewControl = {}
local _headContentImage = {}
local _hairContentImage = {}
local characterTicketAbleUI = {}
local TAB_TYPE = {NORMAL = 1, PREMIUM = 2}
local ClassUI_Pos = {
  posX = {},
  posY = {},
  nameX = {},
  nameY = {}
}
local isSpecialCharacter = false
function FGlobal_SetSpecialCharacter(isSC)
  isSpecialCharacter = isSC
end
function FGlobal_getIsSpecialCharacter()
  return isSpecialCharacter
end
local newCharacterList = {}
local lastCharacter_PosX = 0
local lastCharacter_PosY = 0
local newCharacterInfo = {
  {
    __eClassType_Hashashin,
    2020,
    12,
    31
  }
}
local function newCharacter()
  local saveCharType = -1
  if 0 == #newCharacterInfo then
    return
  end
  for idx = 1, #newCharacterInfo do
    if newCharacterInfo[idx][2] < ToClient_GetThisYear() then
    elseif newCharacterInfo[idx][2] == ToClient_GetThisYear() and newCharacterInfo[idx][3] < ToClient_GetThisMonth() then
    elseif newCharacterInfo[idx][2] == ToClient_GetThisYear() and newCharacterInfo[idx][3] == ToClient_GetThisMonth() and newCharacterInfo[idx][4] < ToClient_GetToday() then
    else
      local count = getPossibleClassCount()
      for ii = 0, count - 1 do
        local classType = getPossibleClassTypeFromIndex(ii)
        if nil ~= classType and classType == newCharacterInfo[idx][1] then
          saveCharType = ii
          break
        end
      end
      table.insert(newCharacterList, saveCharType)
    end
  end
end
local function Panel_Lobby_Function_Initialize()
  newCharacter()
  UI.ASSERT(nil ~= Panel_CharacterCreateSelectClass, "createCharacter_SelectClass\tnil")
  UI.ASSERT(nil ~= Panel_Lobby_UI.CCSC_ClassName, "CCSC_ClassName\t\t\t\tnil")
  UI.ASSERT(nil ~= Panel_Lobby_UI.CCSC_PartLine, "CCSC_PartLine\t\t\t\t\tnil")
  UI.ASSERT(nil ~= Panel_Lobby_UI.CCSC_ClassDescBG, "CCSC_ClassDescBG\t\t\t\tnil")
  UI.ASSERT(nil ~= Panel_Lobby_UI.CCSC_ClassDesc, "CCSC_ClassDesc\t\t\t\tnil")
  UI.ASSERT(nil ~= Panel_Lobby_UI.CCSC_CreateButton, "CCSC_CreateButton\t\t\t\tnil")
  UI.ASSERT(nil ~= Panel_Lobby_UI.CCSC_ClassMovie, "CCSC_ClassMovie\t\t\t\tnil")
  UI.ASSERT(nil ~= Panel_Lobby_UI.CCSC_BackButton, "CCSC_BackButton\t\t\t\tnil")
  UI.ASSERT(nil ~= Panel_Lobby_UI.CCSC_SelectClassButton, "CCSC_SelectClassButton\t\tnil")
  UI.ASSERT(nil ~= Panel_CharacterCreate, "createCharacter\t\t\tnil")
  UI.ASSERT(nil ~= Panel_Lobby_UI.CC_CharacterCreateText, "CC_CharacterCreateText\tnil")
  UI.ASSERT(nil ~= Panel_Lobby_UI.CC_CharacterNameEdit, "CC_CharacterNameEdit\t\tnil")
  UI.ASSERT(nil ~= Panel_Lobby_UI.CC_CreateButton, "CC_CreateButton\t\t\tnil")
  UI.ASSERT(nil ~= Panel_Lobby_UI.CC_BackButton, "CC_BackButton\t\t\t\tnil")
  UI.ASSERT(nil ~= Panel_Lobby_UI.CC_SelectClassButton, "CC_SelectClassButton\t\tnil")
  if isGameServiceTypeKor() then
    Panel_Lobby_UI.CC_CharacterNameEdit:SetMaxInput(15)
  elseif isGameServiceTypeDev() then
    Panel_Lobby_UI.CC_CharacterNameEdit:SetMaxInput(15)
  else
    Panel_Lobby_UI.CC_CharacterNameEdit:SetMaxInput(30)
  end
  Panel_Lobby_UI.CC_FrameHead_Content = UI.getChildControl(Panel_Lobby_UI.CC_FrameHead, "Frame_Head_Content")
  Panel_Lobby_UI.CC_FrameHead_Content_Image = UI.getChildControl(Panel_Lobby_UI.CC_FrameHead_Content, "Frame_Head_Content_Image")
  Panel_Lobby_UI.CC_FrameHead_Scroll = UI.getChildControl(Panel_Lobby_UI.CC_FrameHead, "Frame_Head_Scroll")
  Panel_Lobby_UI.CC_FrameHair_Content = UI.getChildControl(Panel_Lobby_UI.CC_FrameHair, "Frame_Hair_Content")
  Panel_Lobby_UI.CC_FrameHair_Content_Image = UI.getChildControl(Panel_Lobby_UI.CC_FrameHair_Content, "Frame_Hair_Content_Image")
  Panel_Lobby_UI.CC_FrameHair_Scroll = UI.getChildControl(Panel_Lobby_UI.CC_FrameHair, "Frame_Hair_Scroll")
  Panel_CharacterCreate:SetShow(false, false)
  Panel_CharacterCreateSelectClass:SetShow(false, false)
  Panel_Lobby_UI.CCSC_CreateBG:SetSize(450, getScreenSizeY())
  Panel_Lobby_UI.CC_characterCreateBG:setGlassBackground(true)
  Panel_Lobby_UI.CCSC_CreateBG:setGlassBackground(true)
  Panel_Lobby_UI.CCSC_ClassName:addInputEvent("Mouse_LUp", "")
  Panel_Lobby_UI.CCSC_PartLine:addInputEvent("Mouse_LUp", "")
  Panel_Lobby_UI.CCSC_ClassDescBG:addInputEvent("Mouse_LUp", "")
  Panel_Lobby_UI.CCSC_ClassDesc:addInputEvent("Mouse_LUp", "")
  Panel_Lobby_UI.CCSC_CreateButton:addInputEvent("Mouse_LUp", "changeCreateCharacterMode()")
  Panel_Lobby_UI.CCSC_BackButton:addInputEvent("Mouse_LUp", "Panel_CharacterCreateCancel()")
  Panel_Lobby_UI.CCSC_SelectClassButton:addInputEvent("Mouse_LUp", "")
  Panel_Lobby_ClassUI.ClassNames[__eClassType_Warrior]:SetTextMode(__eTextMode_AutoWrap)
  Panel_Lobby_ClassUI.ClassNames[__eClassType_ElfRanger]:SetTextMode(__eTextMode_AutoWrap)
  Panel_Lobby_ClassUI.ClassNames[__eClassType_Sorcerer]:SetTextMode(__eTextMode_AutoWrap)
  Panel_Lobby_ClassUI.ClassNames[__eClassType_Giant]:SetTextMode(__eTextMode_AutoWrap)
  Panel_Lobby_ClassUI.ClassNames[__eClassType_Tamer]:SetTextMode(__eTextMode_AutoWrap)
  Panel_Lobby_ClassUI.ClassNames[__eClassType_BladeMaster]:SetTextMode(__eTextMode_AutoWrap)
  Panel_Lobby_ClassUI.ClassNames[__eClassType_BladeMasterWoman]:SetTextMode(__eTextMode_AutoWrap)
  Panel_Lobby_ClassUI.ClassNames[__eClassType_Valkyrie]:SetTextMode(__eTextMode_AutoWrap)
  Panel_Lobby_ClassUI.ClassNames[__eClassType_WizardMan]:SetTextMode(__eTextMode_AutoWrap)
  Panel_Lobby_ClassUI.ClassNames[__eClassType_WizardWoman]:SetTextMode(__eTextMode_AutoWrap)
  Panel_Lobby_ClassUI.ClassNames[__eClassType_Kunoichi]:SetTextMode(__eTextMode_AutoWrap)
  Panel_Lobby_ClassUI.ClassNames[__eClassType_NinjaMan]:SetTextMode(__eTextMode_AutoWrap)
  Panel_Lobby_ClassUI.ClassNames[__eClassType_ShyWaman]:SetTextMode(__eTextMode_AutoWrap)
  Panel_Lobby_ClassUI.ClassNames[__eClassType_ShyMan]:SetTextMode(__eTextMode_AutoWrap)
  Panel_Lobby_ClassUI.ClassNames[__eClassType_BladeMaster_Reserved1]:SetTextMode(__eTextMode_AutoWrap)
  Panel_Lobby_ClassUI.ClassNames[__eClassType_DarkElf]:SetTextMode(__eTextMode_AutoWrap)
  Panel_Lobby_ClassUI.ClassNames[__eClassType_Combattant]:SetTextMode(__eTextMode_AutoWrap)
  Panel_Lobby_ClassUI.ClassNames[2]:SetTextMode(__eTextMode_AutoWrap)
  Panel_Lobby_ClassUI.ClassNames[__eClassType_Sorcerer_Reserved1]:SetTextMode(__eTextMode_AutoWrap)
  Panel_Lobby_ClassUI.ClassNames[__eClassType_Mystic]:SetTextMode(__eTextMode_AutoWrap)
  Panel_Lobby_ClassUI.ClassNames[__eClassType_Lhan]:SetTextMode(__eTextMode_AutoWrap)
  Panel_Lobby_ClassUI.ClassNames[__eClassType_RangerMan]:SetTextMode(__eTextMode_AutoWrap)
  Panel_Lobby_ClassUI.ClassNames[__eClassType_Hashashin]:SetTextMode(__eTextMode_AutoWrap)
  Panel_Lobby_ClassUI.ClassNames[__eClassType_Warrior]:SetText(PAGetString(Defines.StringSheet_RESOURCE, "UI_CHARACTERCREATE_SELECTCLASS_WARRIOR"))
  Panel_Lobby_ClassUI.ClassNames[__eClassType_ElfRanger]:SetText(PAGetString(Defines.StringSheet_RESOURCE, "UI_CHARACTERCREATE_SELECTCLASS_RANGER"))
  Panel_Lobby_ClassUI.ClassNames[__eClassType_Sorcerer]:SetText(PAGetString(Defines.StringSheet_RESOURCE, "UI_CHARACTERCREATE_SELECTCLASS_SOCERER"))
  Panel_Lobby_ClassUI.ClassNames[__eClassType_Giant]:SetText(PAGetString(Defines.StringSheet_RESOURCE, "UI_CHARACTERCREATE_SELECTCLASS_GIANT"))
  Panel_Lobby_ClassUI.ClassNames[__eClassType_Tamer]:SetText(PAGetString(Defines.StringSheet_RESOURCE, "UI_CHARACTERCREATE_SELECTCLASS_TAMER"))
  Panel_Lobby_ClassUI.ClassNames[__eClassType_BladeMaster]:SetText(PAGetString(Defines.StringSheet_RESOURCE, "UI_CHARACTERCREATE_SELECTCLASS_BLADERMASTER"))
  Panel_Lobby_ClassUI.ClassNames[__eClassType_BladeMasterWoman]:SetText(PAGetString(Defines.StringSheet_RESOURCE, "UI_CHARACTERCREATE_SELECTCLASS_BLADERMASTERWOMEN"))
  Panel_Lobby_ClassUI.ClassNames[__eClassType_Valkyrie]:SetText(PAGetString(Defines.StringSheet_RESOURCE, "UI_CHARACTERCREATE_SELECTCLASS_VALKYRIE"))
  Panel_Lobby_ClassUI.ClassNames[__eClassType_WizardMan]:SetText(PAGetString(Defines.StringSheet_RESOURCE, "UI_CHARACTERCREATE_SELECTCLASS_WIZARD"))
  Panel_Lobby_ClassUI.ClassNames[__eClassType_WizardWoman]:SetText(PAGetString(Defines.StringSheet_RESOURCE, "UI_CHARACTERCREATE_SELECTCLASS_WIZARDWOMEN"))
  Panel_Lobby_ClassUI.ClassNames[__eClassType_Kunoichi]:SetText(PAGetString(Defines.StringSheet_RESOURCE, "UI_CHARACTERCREATE_SELECTCLASS_KUNOICHI"))
  Panel_Lobby_ClassUI.ClassNames[__eClassType_NinjaMan]:SetText(PAGetString(Defines.StringSheet_RESOURCE, "UI_CHARACTERCREATE_SELECTCLASS_NINJA"))
  Panel_Lobby_ClassUI.ClassNames[__eClassType_ShyWaman]:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_GLOBAL_CLASSTYPE_SHYWOMEN"))
  Panel_Lobby_ClassUI.ClassNames[__eClassType_ShyMan]:SetText("\236\131\164\236\157\180 \235\130\168\236\158\144")
  Panel_Lobby_ClassUI.ClassNames[__eClassType_BladeMaster_Reserved1]:SetText("\236\158\132\236\139\156")
  Panel_Lobby_ClassUI.ClassNames[__eClassType_DarkElf]:SetText(PAGetString(Defines.StringSheet_RESOURCE, "UI_CHARACTERCREATE_SELECTCLASS_DARKELF"))
  Panel_Lobby_ClassUI.ClassNames[__eClassType_Combattant]:SetText(PAGetString(Defines.StringSheet_RESOURCE, "UI_CHARACTERCREATE_SELECTCLASS_STRIKER"))
  Panel_Lobby_ClassUI.ClassNames[2]:SetText("\236\158\132\236\139\1561")
  Panel_Lobby_ClassUI.ClassNames[__eClassType_Sorcerer_Reserved1]:SetText("\236\158\132\236\139\1562")
  Panel_Lobby_ClassUI.ClassNames[__eClassType_Mystic]:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_GLOBAL_CLASSTYPE_COMBATTANTWOMEN"))
  Panel_Lobby_ClassUI.ClassNames[__eClassType_Lhan]:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_GLOBAL_CLASSTYPE_RAN"))
  Panel_Lobby_ClassUI.ClassNames[__eClassType_RangerMan]:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_GLOBAL_CLASSTYPE_ORANGE"))
  Panel_Lobby_ClassUI.ClassNames[__eClassType_Hashashin]:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_GLOBAL_CLASSTYPE_SNOWBUCKS"))
  Panel_Lobby_ClassUI.ClassNames[__eClassType_Guardian]:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_GLOBAL_CLASSTYPE_UNKNOWN1"))
  Panel_Lobby_ClassUI.ClassNames[__eClassType_Sorcerer_Reserved0]:SetText("\236\182\148\236\154\180\236\151\172\235\166\132\235\141\148\236\154\180\234\178\168\236\154\184")
  Panel_Lobby_ClassUI.ClassNames[__eClassType_Warrior_Reserve2]:SetText("\237\149\180\234\176\128\235\147\156\235\138\148\235\130\160\237\142\188\236\185\156\236\154\176\236\130\176")
  for index = 0, __eClassType_Count - 1 do
    if Panel_Lobby_ClassUI.ClassButtons[index] ~= nil then
      Panel_Lobby_ClassUI.ClassButtons[index]:addInputEvent("Mouse_LUp", "Panel_Lobby_function_SelectClassType(" .. index .. ", true)")
      Panel_Lobby_ClassUI.ClassButtons[index]:addInputEvent("Mouse_On", "Panel_Lobby_SelectClass_MouseEvent(" .. index .. ", true)")
      Panel_Lobby_ClassUI.ClassButtons[index]:addInputEvent("Mouse_Out", "Panel_Lobby_SelectClass_MouseEvent(" .. index .. ", false)")
    end
  end
  local isSet = false
  local createCount = 0
  local count = getPossibleClassCount()
  for index = 0, count do
    if 0 < #newCharacterList then
      if nil ~= newCharacterList[index + 1] then
        index = newCharacterList[index + 1]
      else
        isSet = false
        index = index - #newCharacterList
        for ii = 1, #newCharacterList do
          if index == newCharacterList[ii] then
            isSet = true
            break
          end
        end
      end
    end
    local classType = getPossibleClassTypeFromIndex(index)
    local classButton = Panel_Lobby_ClassUI.ClassButtons[classType]
    local className = Panel_Lobby_ClassUI.ClassNames[classType]
    if false == isSet and classButton ~= nil and classButton:GetShow() then
      classButton:SetPosX(classButtonStartX + classButton:GetPosX() + (classButton:GetSizeX() + classButtonGapX) * columnCount)
      classButton:SetPosY(classButton:GetPosY() + (classButton:GetSizeY() + classButtonGapY) * rowCount)
      className:SetPosX(classNameStartX + className:GetPosX() + (className:GetSizeX() + classNameGapX) * columnCount)
      className:SetPosY(classButton:GetPosY() + classButton:GetSizeY() - className:GetTextSizeY() - 10)
      if 0 == sortCharacterCount % columnCountByRaw then
        columnCount = 0
        rowCount = rowCount + 1
      else
        columnCount = columnCount + 1
      end
      sortCharacterCount = sortCharacterCount + 1
      className:SetSize(88, Panel_Lobby_ClassUI.ClassNames[classType]:GetTextSizeY() + 5)
      ClassUI_Pos.posX[createCount] = classButton:GetPosX()
      ClassUI_Pos.posY[createCount] = classButton:GetPosY()
      ClassUI_Pos.nameX[createCount] = className:GetPosX()
      if className:GetTextSizeY() > 20 then
        ClassUI_Pos.nameY[createCount] = className:GetPosY() + (className:GetTextSizeY() - 20)
      else
        ClassUI_Pos.nameY[createCount] = className:GetPosY()
      end
      createCount = createCount + 1
    end
  end
  Panel_Lobby_UI.CC_SelectClassButton:addInputEvent("Mouse_LUp", "changeCreateCharacterMode_SelectClass()")
  Panel_Lobby_UI.CC_CreateButton:addInputEvent("Mouse_LUp", "Panel_CharacterCreateOk()")
  Panel_Lobby_UI.CC_BackButton:addInputEvent("Mouse_LUp", "Panel_CharacterCreateCancel()")
  if true == _ContentsGroup_UsePadSnapping then
    Panel_Lobby_UI.CCSC_ClassMovie:SetShow(false)
    Panel_Lobby_UI.CCSC_RadioNormalMovie:SetShow(false)
    Panel_Lobby_UI.CCSC_RadioAwakenMovie:SetShow(false)
    Panel_Lobby_UI.CCSC_ClassDesc:SetShow(false)
    txt_BottomDesc:SetShow(false)
    bottomFrame:SetShow(false)
    _frameBottomDesc:SetShow(false)
    Panel_Lobby_UI.CCSC_ClassDescBG:SetShow(false)
  else
    local scrX = getScreenSizeX()
    local scrY = getScreenSizeY()
    Panel_Lobby_UI.CCSC_ClassMovie:SetPosX(scrX - 441)
    Panel_Lobby_UI.CCSC_ClassMovie:SetPosY(scrY - 372)
    Panel_Lobby_UI.CCSC_ClassMovie:SetUrl(422, 237, "coui://UI_Data/UI_Html/Class_Movie.html")
    Panel_Lobby_UI.CCSC_ClassMovie:SetSize(422, 237)
    Panel_Lobby_UI.CCSC_ClassMovie:SetSpanSize(-1, 0)
    Panel_Lobby_UI.CCSC_ClassMovie:SetShow(true)
    local checkAgeType = ToClient_isAdultUser()
    if checkAgeType then
      Panel_Lobby_UI.CCSC_ClassMovie:SetMonoTone(false)
    else
      Panel_Lobby_UI.CCSC_ClassMovie:SetMonoTone(true)
    end
    Panel_Lobby_UI.CCSC_NoMovie:SetPosX(scrX - 441)
    Panel_Lobby_UI.CCSC_NoMovie:SetPosY(scrY - 372)
    Panel_Lobby_UI.CCSC_RadioNormalMovie:addInputEvent("Mouse_LUp", "Panel_Lobby_SetMovie()")
    Panel_Lobby_UI.CCSC_RadioNormalMovie:addInputEvent("Mouse_On", "Panel_Lobby_TooltipShow(" .. 0 .. ")")
    Panel_Lobby_UI.CCSC_RadioNormalMovie:addInputEvent("Mouse_Out", "Panel_Lobby_TooltipHide()")
    Panel_Lobby_UI.CCSC_RadioAwakenMovie:addInputEvent("Mouse_LUp", "Panel_Lobby_SetMovie()")
    Panel_Lobby_UI.CCSC_RadioAwakenMovie:addInputEvent("Mouse_On", "Panel_Lobby_TooltipShow(" .. 1 .. ")")
    Panel_Lobby_UI.CCSC_RadioAwakenMovie:addInputEvent("Mouse_Out", "Panel_Lobby_TooltipHide()")
  end
end
local function Panel_Lobby_function_StartUp_CreateCharacter_SelectClass()
  Panel_Lobby_Global_Variable.UiMaker = Panel_CharacterCreateSelectClass
  Panel_Lobby_Global_Variable.UiMaker:SetSize(getScreenSizeX(), getScreenSizeY())
  Panel_CharacterCreateSelectClass:SetShow(true, false)
  Panel_CharacterCreateSelectClass:SetSize(getScreenSizeX(), getScreenSizeY())
  _frameContents:ComputePos()
  for _, value in pairs(Character_Status) do
    value:ComputePos()
  end
  for _, value in pairs(Panel_Lobby_UI) do
    value:ComputePos()
  end
  bottomFrame:ComputePos()
  bottomFrame:GetVScroll():SetControlTop()
  bottomFrame:UpdateContentPos()
  bottomFrame:UpdateContentScroll()
  CCSC_Frame:ComputePos()
  CCSC_Frame:GetVScroll():SetControlTop()
  CCSC_Frame:UpdateContentPos()
  CCSC_Frame:UpdateContentScroll()
  local scrSizeY = getScreenSizeY()
  local sumSizeY
  if true == isGameTypeKR2() then
    sumSizeY = scrSizeY - (Panel_Lobby_UI.CCSC_ClassName:GetSizeY() + Panel_Lobby_UI.CCSC_ClassDescBG:GetSizeY() + 112 - Panel_Lobby_UI.CCSC_RadioNormalMovie:GetSizeY())
    CCSC_Frame:SetSize(_frameContents:GetSizeX(), sumSizeY)
  else
    sumSizeY = scrSizeY - (Panel_Lobby_UI.CCSC_ClassName:GetSizeY() + Panel_Lobby_UI.CCSC_ClassMovie:GetSizeY() + Panel_Lobby_UI.CCSC_ClassDescBG:GetSizeY() + 112)
    CCSC_Frame:SetSize(_frameContents:GetSizeX(), sumSizeY)
    Panel_Lobby_UI.CCSC_RadioNormalMovie:SetPosX(CCSC_Frame:GetPosX() + 17)
    Panel_Lobby_UI.CCSC_RadioNormalMovie:SetPosY(CCSC_Frame:GetPosY() + CCSC_Frame:GetSizeY() + 10)
    Panel_Lobby_UI.CCSC_RadioAwakenMovie:SetPosX(Panel_Lobby_UI.CCSC_RadioNormalMovie:GetPosX() + Panel_Lobby_UI.CCSC_RadioNormalMovie:GetSizeX() + 5)
    Panel_Lobby_UI.CCSC_RadioAwakenMovie:SetPosY(CCSC_Frame:GetPosY() + CCSC_Frame:GetSizeY() + 10)
  end
  if sumSizeY < _frameContents:GetSizeY() then
    _frameScroll:SetShow(true)
    _frameScroll:SetInterval(sumSizeY / 100 * 1.1)
  else
    _frameScroll:SetShow(false)
  end
  for classIndex = 0, __eClassType_Count - 1 do
    local classButton = Panel_Lobby_ClassUI.ClassButtons[classIndex]
    local className = Panel_Lobby_ClassUI.ClassNames[classIndex]
    local classStatus = Panel_Lobby_ClassUI.ClassStatus[classIndex]
    if classButton ~= nil then
      classButton:SetShow(false)
      classButton:ComputePos()
    end
    if className ~= nil then
      className:SetShow(false)
      className:ComputePos()
    end
    if classStatus ~= nil then
      classStatus:ComputePos()
    end
  end
  local function ClassBtn_Show(classIndex)
    local classButton = Panel_Lobby_ClassUI.ClassButtons[classIndex]
    local className = Panel_Lobby_ClassUI.ClassNames[classIndex]
    if classButton ~= nil then
      classButton:SetShow(true)
    end
    if className ~= nil then
      className:SetShow(true)
    end
  end
  local count = getPossibleClassCount()
  for index = 0, count - 1 do
    classType = getPossibleClassTypeFromIndex(index)
    ClassBtn_Show(classType)
  end
  local classType = PaGlobalFunc_CharacterSelect_FirstClass()
  local isPrimiumTab = 1
  if true == _ContentsGroup_NewUI_CharacterSelect_All then
    isPrimiumTab = TAB_TYPE.PREMIUM == PaGlobalFunc_CharacterSelect_All_GetCurrentTab()
  else
    isPrimiumTab = TAB_TYPE.PREMIUM == PaGlobal_CharacterSelect_GetTabState()
  end
  if isPrimiumTab and false == PaGlobalFunc_CharacterSelect_IsCheckSpecialCharacter(classType) then
    classType = __eClassType_Warrior
  end
  if nil == classType then
    Panel_Lobby_function_SelectClassType(__eClassType_Warrior)
  else
    Panel_Lobby_function_SelectClassType(classType)
  end
end
function Panel_Lobby_Function_showCharacterCreate_SelectClass()
  if true == _ContentsGroup_NewUI_CharacterSelect_All then
    PaGlobalFunc_CharacterSelect_All_Close()
  elseif true == _ContentsGroup_RenewUI then
    PaGlobal_CharacterSelect_Close()
  elseif true == _ContentsGroup_RemasterUI_Lobby then
    PaGlobalFunc_CharacterSelectRemaster_Close()
  else
    FGlobal_CharacterSelect_Close()
  end
  Panel_Lobby_Global_Variable.currentSelectedIdx = -1
  local isXbox = _ContentsGroup_UsePadSnapping
  Panel_Lobby_UI.CCSC_LeaveConsole:SetShow(isXbox)
  Panel_Lobby_UI.CCSC_SelectConsole:SetShow(isXbox)
  Panel_Lobby_UI.CCSC_BackButton:SetShow(not isXbox)
  Panel_Lobby_UI.CCSC_CreateButton:SetShow(not isXbox)
  Panel_Lobby_function_DeleteButton()
  Panel_Lobby_function_ClearData()
  Panel_Lobby_function_StartUp_CreateCharacter_SelectClass()
  Panel_CharacterCreateSelectClass:SetShow(true, false)
  if false == _ContentsGroup_RenewUI_Customization then
    Panel_CharacterCreate:SetShow(false, false)
    Panel_Customization_Control:SetShow(false, false)
    Panel_CustomizationMotion:SetShow(false, false)
    Panel_CustomizationExpression:SetShow(false, false)
    Panel_CustomizationCloth:SetShow(false, false)
    Panel_CustomizationTest:SetShow(false, false)
    Panel_CustomizationMesh:SetShow(false, false)
    Panel_CustomizationMain:SetShow(false, false)
    Panel_CustomizationStatic:SetShow(false, false)
    Panel_CustomizationMessage:SetShow(false, false)
    Panel_CustomizationFrame:SetShow(false, false)
  end
  Panel_CharacterCreateSelectClass:SetSize(getScreenSizeY(), getScreenSizeX())
  PaGlobalFunc_CharacterSelect_TabState()
end
function Panel_Lobby_Function_showCharacterCustomization(customizationData)
  Panel_Lobby_function_DeleteButton()
  Panel_CharacterCreateSelectClass:SetShow(false, false)
  resizeUIScale()
  if true == _ContentsGroup_RenewUI_Customization then
    PaGlobalFunc_Customization_SetClassType(index)
  else
    Panel_Lobby_UI.CM_Edit_CharacterName:SetEditText("")
    ShowCharacterCustomization(customizationData, Panel_Lobby_Global_Variable.characterSelectType, false)
  end
  viewCharacterCreateMode(Panel_Lobby_Global_Variable.characterSelectType)
end
function Panel_Lobby_function_ClearData()
  Panel_Lobby_Global_Variable.characterSelect = -1
  Panel_Lobby_Global_Variable.characterSelectType = -1
  Panel_Lobby_Global_Variable.selectRegionInfo = nil
end
local _index
function Panel_Lobby_function_SelectClassType(index, isOn)
  if index < __eClassType_Count then
    if false == ToClient_checkCreatePossibleClass(index, isSpecialCharacter) then
      return
    end
    if index == Panel_Lobby_Global_Variable.currentSelectedIdx then
      changeCreateCharacterMode()
      return
    else
      Panel_Lobby_Global_Variable.currentSelectedIdx = index
    end
    for key, value in pairs(Panel_Lobby_ClassUI.ClassButtons) do
      value:SetMonoTone(true)
      value:SetVertexAniRun("Ani_Color_Reset", true)
      value:EraseAllEffect()
    end
    Panel_Lobby_ClassUI.ClassButtons[index]:SetMonoTone(false)
    local effectName = "UI_CharactorSelcect_Line"
    local isPrimiumTab = 1
    if true == _ContentsGroup_NewUI_CharacterSelect_All then
      isPrimiumTab = TAB_TYPE.NORMAL == PaGlobalFunc_CharacterSelect_All_GetCurrentTab()
    else
      isPrimiumTab = TAB_TYPE.NORMAL == PaGlobal_CharacterSelect_GetTabState()
    end
    if isPrimiumTab and 0 < #newCharacterInfo then
      for idx = 1, #newCharacterInfo do
        if index == newCharacterInfo[idx][1] then
          effectName = "fUI_Lobby_SelectCharacter_01A"
          break
        end
      end
    end
    Panel_Lobby_ClassUI.ClassButtons[index]:AddEffect(effectName, true, 10, 4)
    if true == _ContentsGroup_UsePadSnapping then
      _index = index
      viewCharacterCreateSelectClassMode(index)
      Panel_Lobby_Global_Variable.characterSelectType = index
      Panel_Lobby_UI.CCSC_ClassName:SetText(getClassName(index, isSpecialCharacter))
    else
      if true == isGameTypeKR2() then
        Panel_Lobby_UI.CCSC_ClassMovie:SetShow(false)
        Panel_Lobby_UI.CCSC_RadioNormalMovie:SetShow(false)
        Panel_Lobby_UI.CCSC_RadioAwakenMovie:SetShow(false)
      else
        local movieName = getClassMovie(index, isSpecialCharacter)
        Panel_Lobby_UI.CCSC_RadioNormalMovie:SetCheck(false)
        Panel_Lobby_UI.CCSC_RadioAwakenMovie:SetCheck(true)
        if nil ~= movieName and "" ~= movieName then
          Panel_Lobby_UI.CCSC_ClassMovie:SetShow(true)
          Panel_Lobby_UI.CCSC_NoMovie:SetShow(false)
          if isAwakenOpen[index] and Panel_Lobby_UI.CCSC_RadioAwakenMovie:IsCheck() then
            movieName = string.gsub(movieName, ".webm", "_A.webm")
          end
          Panel_Lobby_UI.CCSC_ClassMovie:TriggerEvent("PlayMovie", "coui://" .. movieName)
        else
          Panel_Lobby_UI.CCSC_ClassMovie:SetShow(false)
          Panel_Lobby_UI.CCSC_NoMovie:SetShow(true)
        end
        Panel_Lobby_UI.CCSC_RadioNormalMovie:SetShow(true)
        Panel_Lobby_UI.CCSC_RadioAwakenMovie:SetShow(isAwakenOpen[index])
        if 29 == index then
          Panel_Lobby_UI.CCSC_RadioNormalMovie:SetShow(false)
          Panel_Lobby_UI.CCSC_RadioAwakenMovie:SetShow(false)
        end
      end
      _index = index
      viewCharacterCreateSelectClassMode(index)
      Panel_Lobby_Global_Variable.characterSelectType = index
      Panel_Lobby_UI.CCSC_ClassName:SetText(getClassName(index, isSpecialCharacter))
      Panel_Lobby_UI.CCSC_ClassDesc:SetTextMode(__eTextMode_AutoWrap)
      Panel_Lobby_UI.CCSC_ClassDesc:SetText(getClassDescription(index, isSpecialCharacter))
      Panel_Lobby_UI.CCSC_ClassDesc:SetShow(false)
      txt_BottomDesc:SetTextMode(__eTextMode_AutoWrap)
      txt_BottomDesc:SetText(getClassDescription(index, isSpecialCharacter))
    end
    _frameBottomDesc:SetSize(_frameBottomDesc:GetSizeX(), txt_BottomDesc:GetTextSizeY())
    if index == __eClassType_ShyWaman then
      tooltipDescSaved = PAGetString(Defines.StringSheet_GAME, "LUA_LOBBY_CHARACTERSELECT_CREATE_SHY_AWAKENWEAPON_TOOLTIP")
      tooltipNameSaved = PAGetString(Defines.StringSheet_GAME, "LUA_LOBBY_CHARACTERSELECT_CREATE_SHY_AWAKENWEAPON_TOOLTIP_NAME")
      Panel_Lobby_UI.CCSC_RadioAwakenMovie:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_EQUIPMENT_SHY_AWAKENWEAPON"))
    else
      tooltipNameSaved = PAGetString(Defines.StringSheet_GAME, "LUA_SELECTCLASS_AWAKENWEAPONTITLE")
      tooltipDescSaved = PAGetString(Defines.StringSheet_GAME, "LUA_SELECTCLASS_AWAKENWEAPONDESC")
      Panel_Lobby_UI.CCSC_RadioAwakenMovie:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SKILL_RELEASEWEAPONE"))
    end
    for _, value in pairs(Panel_Lobby_ClassUI.ClassStatus) do
      value:SetShow(false)
    end
    Panel_Lobby_ClassUI.ClassStatus[index]:SetShow(true)
  end
end
function Panel_Lobby_SetMovie()
  local movieName = getClassMovie(_index, isSpecialCharacter)
  if movieName ~= nil then
    if isAwakenOpen[_index] and Panel_Lobby_UI.CCSC_RadioAwakenMovie:IsCheck() then
      movieName = string.gsub(movieName, ".webm", "_A.webm")
    end
    Panel_Lobby_UI.CCSC_ClassMovie:TriggerEvent("PlayMovie", "coui://" .. movieName)
  end
end
function Panel_Lobby_SelectClass_MouseEvent(index, isOn)
  local classButton = Panel_Lobby_ClassUI.ClassButtons[index]
  if classButton ~= nil then
    if isOn == true then
      classButton:SetVertexAniRun("Ani_Color_Bright", true)
      if true == _ContentsGroup_UsePadSnapping then
        if index == Panel_Lobby_Global_Variable.currentSelectedIdx then
          Panel_Lobby_UI.CCSC_SelectConsole:SetText("Create")
        else
          Panel_Lobby_UI.CCSC_SelectConsole:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_DIALOG_MAIN_SELECT"))
        end
      end
    else
      classButton:ResetVertexAni()
    end
  end
end
function Panel_CharacterCreateOk()
  chracterCreate(Panel_Lobby_Global_Variable.characterSelectType, Panel_Lobby_UI.CC_CharacterNameEdit:GetEditText(), isSpecialCharacter)
end
function Panel_CharacterCreateOK_Renew(characterName)
  local _edit_CharacterName = characterName
  local function createCharacterFunc()
    chracterCreate(Panel_Lobby_Global_Variable.characterSelectType, _edit_CharacterName, isSpecialCharacter)
    PaGlobalFunc_Customization_InputName_Close()
  end
  local messageBoxTitle = PAGetString(Defines.StringSheet_GAME, "LUA_ALERT_DEFAULT_TITLE")
  local messageBoxMemo = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_LOBBY_MAIN_CHARACTERCREATE_RECONFIRM_CHARACTERNAME", "name", _edit_CharacterName)
  if isGameTypeKorea() or isGameTypeTaiwan() or isGameTypeTH() or isGameTypeRussia() or isGameTypeID() or isGameTypeTR() then
    messageBoxMemo = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_LOBBY_MAIN_CHARACTERCREATE_RECONFIRM_CHARACTERNAME", "name", _edit_CharacterName) .. [[


<PAColor0xFFF26A6A>]] .. PAGetString(Defines.StringSheet_GAME, "LUA_MAKENAME_WARNING") .. "<PAOldColor>"
  else
    messageBoxMemo = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_LOBBY_MAIN_CHARACTERCREATE_RECONFIRM_CHARACTERNAME", "name", _edit_CharacterName)
  end
  local messageBoxData = {
    title = messageBoxTitle,
    content = messageBoxMemo,
    functionYes = createCharacterFunc,
    functionNo = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageBoxData)
  ClearFocusEdit()
  closeExplorer()
  Panel_CustomizingAlbum:SetShow(false)
end
function Panel_CharacterCreateOK_NewCustomization()
  local _edit_CharacterName = Panel_Lobby_UI.CM_Edit_CharacterName:GetEditText()
  local function createCharacterFunc()
    if true == _ContentsGroup_SeasonContents or true == _ContentsGroup_PreSeason then
      if true == isSpecialCharacter then
        chracterCreate(Panel_Lobby_Global_Variable.characterSelectType, _edit_CharacterName, isSpecialCharacter, false)
      else
        chracterCreate(Panel_Lobby_Global_Variable.characterSelectType, _edit_CharacterName, isSpecialCharacter, PaGlobalFunc_Customization_IsSeasonBtnClick())
      end
    else
      chracterCreate(Panel_Lobby_Global_Variable.characterSelectType, _edit_CharacterName, isSpecialCharacter)
    end
  end
  if true == _ContentsGroup_SeasonContents or true == _ContentsGroup_PreSeason then
    _edit_CharacterName = PaGlobalFunc_Customization_GetEditName()
  end
  local messageBoxTitle = PAGetString(Defines.StringSheet_GAME, "LUA_ALERT_DEFAULT_TITLE")
  local messageBoxMemo = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_LOBBY_MAIN_CHARACTERCREATE_RECONFIRM_CHARACTERNAME", "name", _edit_CharacterName)
  if isGameTypeKorea() or isGameTypeTaiwan() or isGameTypeTH() or isGameTypeRussia() or isGameTypeID() or isGameTypeTR() then
    messageBoxMemo = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_LOBBY_MAIN_CHARACTERCREATE_RECONFIRM_CHARACTERNAME", "name", _edit_CharacterName) .. [[


<PAColor0xFFF26A6A>]] .. PAGetString(Defines.StringSheet_GAME, "LUA_MAKENAME_WARNING") .. "<PAOldColor>"
  else
    messageBoxMemo = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_LOBBY_MAIN_CHARACTERCREATE_RECONFIRM_CHARACTERNAME", "name", _edit_CharacterName)
  end
  local messageBoxData = {
    title = messageBoxTitle,
    content = messageBoxMemo,
    functionYes = createCharacterFunc,
    functionNo = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageBoxData)
  ClearFocusEdit()
  closeExplorer()
  Panel_CustomizingAlbum:SetShow(false)
  ToClient_DeleteCustomizationTempData()
end
function Panel_CharacterCreateCancel()
  if true == characterCreateIsOnLookAtCameraTimerRunning() then
    characterCreateCancelIntroAction()
    return
  end
  Panel_CharacterCreateSelectClass:SetShow(false)
  characterCreateCancel(FGlobal_getIsSpecialCharacter())
  TooltipSimple_Hide()
end
function Panel_Lobby_function_DeleteButton()
  if nil == Panel_Lobby_Global_Variable.UiMaker then
    return
  end
  for _, value in pairs(Panel_Lobby_Global_Variable.UIList) do
    UI.deleteControl(value)
  end
  Panel_Lobby_Global_Variable.UIList = {}
  Panel_Lobby_Global_Variable.UiMaker = nil
end
function Panel_Lobby_TooltipShow(buttonType)
  local uiControl, name, desc
  if 0 == buttonType then
    uiControl = Panel_Lobby_UI.CCSC_RadioNormalMovie
    name = PAGetString(Defines.StringSheet_GAME, "LUA_SELECTCLASS_MAINWEAPONTITLE")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_SELECTCLASS_MAINWEAPONDESC")
  elseif 1 == buttonType then
    uiControl = Panel_Lobby_UI.CCSC_RadioNormalMovie
    name = tooltipNameSaved
    desc = tooltipDescSaved
  end
  if nil ~= uiControl then
    TooltipSimple_Show(uiControl, name, desc)
  end
end
function Panel_Lobby_TooltipHide()
  TooltipSimple_Hide()
end
function PaGlobalFunc_CharacterSelect_TabState()
  local classTabState = 1
  if true == _ContentsGroup_NewUI_CharacterSelect_All then
    classTabState = PaGlobalFunc_CharacterSelect_All_GetCurrentTab()
  else
    classTabState = PaGlobal_CharacterSelect_GetTabState()
  end
  newCharacter()
  local newCharID = PaGlobalFunc_CharacterSelect_FirstClass()
  local count = getPossibleClassCount()
  local slotNum = 0
  local frameSizeY = 0
  local slotSizeY = 0
  for index = 0, count - 1 do
    local classType = getPossibleClassTypeFromIndex(index)
    local classButton = Panel_Lobby_ClassUI.ClassButtons[classType]
    local className = Panel_Lobby_ClassUI.ClassNames[classType]
    if classButton ~= nil and classButton:GetShow() then
      classButton:SetShow(false)
      className:SetShow(false)
    end
  end
  if TAB_TYPE.NORMAL == classTabState then
    if nil ~= newCharID then
      Panel_Lobby_ClassUI.ClassButtons[newCharID]:SetPosXY(ClassUI_Pos.posX[0], ClassUI_Pos.posY[0])
      Panel_Lobby_ClassUI.ClassNames[newCharID]:SetPosXY(ClassUI_Pos.nameX[0], ClassUI_Pos.nameY[0])
      slotNum = slotNum + 1
    end
    for index = 0, count - 1 do
      local classType = getPossibleClassTypeFromIndex(index)
      local classButton = Panel_Lobby_ClassUI.ClassButtons[classType]
      local className = Panel_Lobby_ClassUI.ClassNames[classType]
      if nil ~= classButton then
        if newCharID ~= classType then
          classButton:SetPosX(ClassUI_Pos.posX[slotNum])
          classButton:SetPosY(ClassUI_Pos.posY[slotNum])
          className:SetPosX(ClassUI_Pos.nameX[slotNum])
          if 20 < className:GetTextSizeY() then
            className:SetPosY(ClassUI_Pos.nameY[slotNum] - (className:GetTextSizeY() - 20))
          else
            className:SetPosY(ClassUI_Pos.nameY[slotNum])
          end
          slotNum = slotNum + 1
        end
        slotSizeY = classButton:GetSizeY()
        classButton:SetShow(true)
        className:SetShow(true)
      end
    end
  elseif TAB_TYPE.PREMIUM == classTabState then
    for idx = 0, getPossibleSpecialClassCount() - 1 do
      local specialType = getPossibleSpecialClassTypeFromIndex(idx)
      local classButton = Panel_Lobby_ClassUI.ClassButtons[specialType]
      local className = Panel_Lobby_ClassUI.ClassNames[specialType]
      if nil ~= classButton then
        classButton:SetPosX(ClassUI_Pos.posX[slotNum])
        classButton:SetPosY(ClassUI_Pos.posY[slotNum])
        classButton:SetShow(true)
        className:SetPosX(ClassUI_Pos.nameX[slotNum])
        if 20 < className:GetTextSizeY() then
          className:SetPosY(ClassUI_Pos.nameY[slotNum] - (className:GetTextSizeY() - 20))
        else
          className:SetPosY(ClassUI_Pos.nameY[slotNum])
        end
        className:SetShow(true)
        slotNum = slotNum + 1
        slotSizeY = classButton:GetSizeY()
      end
    end
  end
  local addRaw = 1
  if 0 == slotNum % columnCountByRaw then
    addRaw = 0
  end
  frameSizeY = (math.floor(slotNum / columnCountByRaw) + addRaw) * (slotSizeY + classButtonGapY) + classButtonGapY
  _frameContents:SetSize(_frameContents:GetSizeX(), frameSizeY)
end
function PaGlobalFunc_CharacterSelect_FirstClass()
  if ToClient_IsContentsGroupOpen("1135") then
    return __eClassType_Hashashin
  end
  return nil
end
function PaGlobalFunc_CharacterSelect_IsCheckSpecialCharacter(classType)
  for idx = 0, getPossibleSpecialClassCount() - 1 do
    if getPossibleSpecialClassTypeFromIndex(idx) == classType then
      return true
    end
  end
  return false
end
local applyButton = UI.getChildControl(Panel_CharacterCreateSelectClassTest, "Button_Apply")
local shadowClassEdit = UI.getChildControl(Panel_CharacterCreateSelectClassTest, "Edit_ShadowClassIndex")
Panel_CharacterCreateSelectClassTest:SetShow(false)
function PaGlobalFunc_SelectShadowCharacter_Toggle()
  if false == ToClient_IsDevelopment() then
    return
  end
  if false == Panel_CharacterCreateSelectClassTest:GetShow() then
    Panel_CharacterCreateSelectClassTest:SetShow(true)
    shadowClassEdit:SetMaxInput(15)
    applyButton:addInputEvent("Mouse_LUp", "PaGlobalFunc_SelectShadowCharacter_Apply()")
  else
    Panel_CharacterCreateSelectClassTest:SetShow(false)
  end
end
function PaGlobalFunc_SelectShadowCharacter_Apply()
  local shadowClass = shadowClassEdit:GetEditText()
  shadowClassEdit:SetEditText("")
  ToClient_SelectShadowCharacterShow(shadowClass)
end
Panel_Lobby_Function_Initialize()
registerEvent("EventChangeLobbyStageToCharacterCreate_SelectClass", "Panel_Lobby_Function_showCharacterCreate_SelectClass")
registerEvent("EventCharacterCustomizationInitUi", "Panel_Lobby_Function_showCharacterCustomization")
