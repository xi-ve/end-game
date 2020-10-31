local IM = CppEnums.EProcessorInputMode
local petNaming = UI.getChildControl(Panel_Window_PetRegister, "Edit_Naming")
local petRegister = UI.getChildControl(Panel_Window_PetRegister, "Button_Yes")
local petRegisterCancel = UI.getChildControl(Panel_Window_PetRegister, "Button_No")
local petIcon = UI.getChildControl(Panel_Window_PetRegister, "Static_Icon")
local _staticCreateServantNameBG = UI.getChildControl(Panel_Window_PetRegister, "Static_NamingPolicyBG")
local _staticCreateServantNameTitle = UI.getChildControl(Panel_Window_PetRegister, "StaticText_NamingPolicyTitle")
local _staticCreateServantName = UI.getChildControl(Panel_Window_PetRegister, "StaticText_NamingPolicy")
local _petRegisterBG = UI.getChildControl(Panel_Window_PetRegister, "Static_PetRegisterBG")
local _petRegisterDesc = UI.getChildControl(Panel_Window_PetRegister, "StaticText_Description")
local tempFromWhereType, tempFromSlotNo
function petRegister_init()
  petNaming:SetEditText(PAGetString(Defines.StringSheet_GAME, "LUA_STABLEINFO_EDITBOX_COMMENT"), true)
  if isGameTypeEnglish() or isGameTypeTaiwan() or isGameTypeTR() or isGameTypeTH() or isGameTypeID() then
    _staticCreateServantName:SetTextMode(__eTextMode_AutoWrap)
    _staticCreateServantName:SetShow(true)
    _staticCreateServantNameBG:SetShow(true)
    _staticCreateServantNameTitle:SetShow(true)
    _staticCreateServantName:SetText("\161\216 Allowed characters:\nA-Z, a-z, 0-9, _ (underscore)\n\n\161\216 Rules:\n1. Length: 3-16 characters\n2. You can't use a letter more than 2 times consecutively\n3. A maximum of 4 numbers are allowed at the end \nof your name\n4. Underscore (_) is allowed only once and can only occur \nbetween a minimum of 2 characters")
    _staticCreateServantName:SetTextMode(__eTextMode_AutoWrap)
  else
    _staticCreateServantName:SetShow(false)
    _staticCreateServantNameBG:SetShow(false)
    _staticCreateServantNameTitle:SetShow(false)
  end
  if isGameTypeEnglish() or isGameTypeTaiwan() then
    _staticCreateServantName:SetText(PAGetString(Defines.StringSheet_GAME, "COMMON_CHARACTERCREATEPOLICY_EN"))
  elseif isGameTypeTR() then
    _staticCreateServantName:SetText(PAGetString(Defines.StringSheet_GAME, "COMMON_CHARACTERCREATEPOLICY_TR"))
  elseif isGameTypeTH() then
    _staticCreateServantName:SetText(PAGetString(Defines.StringSheet_GAME, "COMMON_CHARACTERCREATEPOLICY_TH"))
  elseif isGameTypeID() then
    _staticCreateServantName:SetText(PAGetString(Defines.StringSheet_GAME, "COMMON_CHARACTERCREATEPOLICY_ID"))
  end
  _petRegisterDesc:SetTextMode(__eTextMode_AutoWrap)
end
function petRegister_Close()
  if not Panel_Window_PetRegister:GetShow() then
    return
  end
  ClearFocusEdit(petNaming)
  Panel_Window_PetRegister:SetShow(false)
end
function FromClient_InputPetName(fromWhereType, fromSlotNo)
  tempFromWhereType = fromWhereType
  tempFromSlotNo = fromSlotNo
  local petName = petNaming:GetEditText()
  local itemWrapper = getInventoryItemByType(fromWhereType, fromSlotNo)
  if nil == itemWrapper then
    return
  end
  characterKey = itemWrapper:getStaticStatus():get()._contentsEventParam1
  local petRegisterPSS = ToClient_getPetStaticStatus(characterKey)
  local petIconPath = petRegisterPSS:getIconPath()
  petIcon:ChangeTextureInfoName(petIconPath)
  petNaming:SetEditText("", true)
  petNaming:SetMaxInput(getGameServiceTypePetNameLength())
  local defaultDesc = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_PETREGISTER_DESC_PARAM", "min", tostring(getGameServiceTypeNameMinLength()), "max", tostring(getGameServiceTypePetNameLength()))
  _petRegisterDesc:SetText(defaultDesc)
  _petRegisterDesc:SetSize(_petRegisterDesc:GetSizeX(), _petRegisterDesc:GetTextSizeY() + 10)
  _petRegisterBG:SetSize(_petRegisterBG:GetSizeX(), _petRegisterDesc:GetTextSizeY() + petNaming:GetSizeY() + 50)
  Panel_Window_PetRegister:SetSize(Panel_Window_PetRegister:GetSizeX(), _petRegisterDesc:GetTextSizeY() + petNaming:GetSizeY() + petRegister:GetSizeY() + 110)
  petRegister:ComputePos()
  petRegisterCancel:ComputePos()
  HandleClicked_PetRegister_ClearEdit()
  Panel_Window_PetRegister:SetShow(true)
end
function HandleClicked_PetRegister_Register()
  local fromWhereType = tempFromWhereType
  local fromSlotNo = tempFromSlotNo
  local petName = petNaming:GetEditText()
  ToClient_requestPetRegister(petName, fromWhereType, fromSlotNo)
  petRegister_Close()
end
function FromClient_PetAddSealedList(petNo, reason, petType)
  if reason == nil then
    return
  end
  if reason == 1 then
    if petType == __ePetType_Normal then
      FGlobal_PetListNew_Open()
      FGlobal_PetInfoInit()
    elseif petType == __ePetType_Fairy then
      if true == _ContentsGroup_NewUI_Fairy_All then
        PaGlobal_FairyInfo_Open_All(false)
      else
        PaGlobal_FairyInfo_Open(false)
      end
      PaGlobal_Fairy_SetPosIcon()
    else
      return
    end
  end
end
function HandleClicked_PetRegister_Close()
  petRegister_Close()
end
function HandleClicked_PetRegister_ClearEdit()
  petNaming:SetEditText("", false)
  SetFocusEdit(petNaming)
end
function FGlobal_PetRegister_Close()
  Panel_Window_PetRegister:SetShow(false)
end
function petRegister_registEventHandler()
  petRegister:addInputEvent("Mouse_LUp", "HandleClicked_PetRegister_Register()")
  petRegisterCancel:addInputEvent("Mouse_LUp", "HandleClicked_PetRegister_Close()")
  petNaming:addInputEvent("Mouse_LUp", "HandleClicked_PetRegister_ClearEdit()")
  petNaming:RegistReturnKeyEvent("HandleClicked_PetRegister_Register()")
end
function petRegister_registMessageHandler()
  registerEvent("FromClient_InputPetName", "FromClient_InputPetName")
  registerEvent("FromClient_PetAddSealedList", "FromClient_PetAddSealedList")
end
function PaGlobalFunc_PetRegister_GetShow()
  return Panel_Window_PetRegister:GetShow()
end
petRegister_init()
petRegister_registEventHandler()
petRegister_registMessageHandler()
