local UI_BUFFTYPE = CppEnums.UserChargeType
local enValue = {MaxCharacterTypeList = 7, MaxEquipSlotCount = 18}
local enToggleIndex = {
  Underwear = 0,
  Avater = 1,
  Helmet = 2,
  AwakenWeapon = 3,
  FaceViewHair = 4,
  FaceGuard = 5,
  WarStance = 6,
  Cloak = 7
}
local dyeCombine = {
  _ui = {
    stc_buttonGroup = nil,
    toggleWarStance = nil,
    toggleShowUnderwear = nil,
    toggleHideAvatar = nil,
    toggleHideHair = nil,
    toggleHideHelmet = nil,
    toggleOpenFaceGuard = nil,
    toggleCloakInvisual = nil,
    toggleAwakenWeapon = nil,
    stc_radioGroup = nil,
    rdo_tring = nil,
    rdo_tutu = nil,
    rdo_tocong = nil,
    stc_partTargetBG = nil,
    txt_ampuleTargetTitle = nil,
    stc_ampluleTargetBG = nil,
    txt_endurance = nil,
    slider_endurance = nil,
    btn_doDye = nil
  },
  basicPanelSizeY = 0,
  basicPartTargetBGPosY = 0,
  basicAmpluleTitlePosY = 0,
  basicAmpluleBGPosY = 0,
  isInitialize = false
}
local dyePartString = {
  [0] = {
    [0] = PAGetString(Defines.StringSheet_GAME, "PANEL_TOOLTIP_EQUIP_MAINHAND"),
    [1] = PAGetString(Defines.StringSheet_GAME, "PANEL_TOOLTIP_EQUIP_SUBHAND"),
    [3] = PAGetString(Defines.StringSheet_GAME, "LUA_DYENEW_DYEPART_CHARACTER_ARMOR"),
    [4] = PAGetString(Defines.StringSheet_GAME, "PANEL_TOOLTIP_EQUIP_GLOVES"),
    [5] = PAGetString(Defines.StringSheet_GAME, "PANEL_TOOLTIP_EQUIP_BOOTS"),
    [6] = PAGetString(Defines.StringSheet_GAME, "PANEL_TOOLTIP_EQUIP_HELM"),
    [18] = PAGetString(Defines.StringSheet_GAME, "LUA_INGAMECASHSHOP_SETEQUIP_MAINHANDS"),
    [19] = PAGetString(Defines.StringSheet_GAME, "LUA_INGAMECASHSHOP_SETEQUIP_SUBHANDS"),
    [14] = PAGetString(Defines.StringSheet_GAME, "LUA_INGAMECASHSHOP_SETEQUIP_BODY"),
    [15] = PAGetString(Defines.StringSheet_GAME, "LUA_INGAMECASHSHOP_SETEQUIP_HANDS"),
    [16] = PAGetString(Defines.StringSheet_GAME, "LUA_INGAMECASHSHOP_SETEQUIP_BOOTS"),
    [17] = PAGetString(Defines.StringSheet_GAME, "LUA_INGAMECASHSHOP_SETEQUIP_HELM"),
    [20] = PAGetString(Defines.StringSheet_GAME, "LUA_INGAMECASHSHOP_SETEQUIP_UNDERWEAR"),
    [21] = PAGetString(Defines.StringSheet_GAME, "LUA_DYENEW_DYEPART_CHARACTER_ACC_0"),
    [22] = PAGetString(Defines.StringSheet_GAME, "LUA_DYENEW_DYEPART_CHARACTER_ACC_1"),
    [23] = PAGetString(Defines.StringSheet_GAME, "LUA_DYENEW_DYEPART_CHARACTER_ACC_2"),
    [29] = PAGetString(Defines.StringSheet_GAME, "Lua_EquipSlotNo_String_awakenWeapon"),
    [30] = PAGetString(Defines.StringSheet_GAME, "Lua_EquipSlotNo_String_avatarAwakenWeapon")
  },
  {
    [3] = PAGetString(Defines.StringSheet_GAME, "LUA_INGAMECASHSHOP_SETEQUIP_BARD"),
    [4] = PAGetString(Defines.StringSheet_GAME, "LUA_INGAMECASHSHOP_SETEQUIP_SADDLE"),
    [5] = PAGetString(Defines.StringSheet_GAME, "LUA_INGAMECASHSHOP_SETEQUIP_STIRRUP"),
    [6] = PAGetString(Defines.StringSheet_GAME, "LUA_INGAMECASHSHOP_SETEQUIP_HORSEHEAD"),
    [12] = PAGetString(Defines.StringSheet_GAME, "LUA_DYENEW_DYEPART_HORSE_FOOT"),
    [14] = PAGetString(Defines.StringSheet_GAME, "LUA_DYENEW_DYEPART_HORSE_AVATAR_ARMOR"),
    [15] = PAGetString(Defines.StringSheet_GAME, "LUA_DYENEW_DYEPART_HORSE_AVATAR_SADDLE"),
    [16] = PAGetString(Defines.StringSheet_GAME, "LUA_DYENEW_DYEPART_HORSE_AVATAR_STIRRUP"),
    [17] = PAGetString(Defines.StringSheet_GAME, "LUA_DYENEW_DYEPART_HORSE_AVATAR_FACE")
  },
  {
    [3] = PAGetString(Defines.StringSheet_GAME, "LUA_DYENEW_DYEPART_CARRIAGE_BODY"),
    [4] = PAGetString(Defines.StringSheet_GAME, "LUA_DYENEW_DYEPART_CARRIAGE_TIRE"),
    [5] = PAGetString(Defines.StringSheet_GAME, "LUA_DYENEW_DYEPART_CARRIAGE_FLAG"),
    [6] = PAGetString(Defines.StringSheet_GAME, "LUA_DYENEW_DYEPART_CARRIAGE_INSIGNIA"),
    [13] = PAGetString(Defines.StringSheet_GAME, "LUA_DYENEW_DYEPART_CARRIAGE_LAMP"),
    [25] = PAGetString(Defines.StringSheet_GAME, "LUA_DYENEW_DYEPART_CARRIAGE_CORVER"),
    [14] = PAGetString(Defines.StringSheet_GAME, "LUA_DYENEW_DYEPART_CARRIAGE_AVATAR_BODY"),
    [15] = PAGetString(Defines.StringSheet_GAME, "LUA_DYENEW_DYEPART_CARRIAGE_AVATAR_TIRE"),
    [16] = PAGetString(Defines.StringSheet_GAME, "LUA_DYENEW_DYEPART_CARRIAGE_AVATAR_FLAG"),
    [17] = PAGetString(Defines.StringSheet_GAME, "LUA_DYENEW_DYEPART_CARRIAGE_AVATAR_INSIGNIA"),
    [26] = PAGetString(Defines.StringSheet_GAME, "LUA_DYENEW_DYEPART_CARRIAGE_AVATAR_CORVER")
  },
  {
    [3] = PAGetString(Defines.StringSheet_GAME, "LUA_INGAMECASHSHOP_SETEQUIP_BARD"),
    [4] = PAGetString(Defines.StringSheet_GAME, "LUA_INGAMECASHSHOP_SETEQUIP_STIRRUP"),
    [5] = PAGetString(Defines.StringSheet_GAME, "LUA_INGAMECASHSHOP_SETEQUIP_SADDLE"),
    [6] = PAGetString(Defines.StringSheet_GAME, "LUA_INGAMECASHSHOP_SETEQUIP_HORSEHEAD"),
    [12] = PAGetString(Defines.StringSheet_GAME, "LUA_DYENEW_DYEPART_HORSE_FOOT"),
    [14] = PAGetString(Defines.StringSheet_GAME, "LUA_DYENEW_DYEPART_HORSE_AVATAR_ARMOR"),
    [15] = PAGetString(Defines.StringSheet_GAME, "LUA_DYENEW_DYEPART_HORSE_AVATAR_STIRRUP"),
    [16] = PAGetString(Defines.StringSheet_GAME, "LUA_DYENEW_DYEPART_HORSE_AVATAR_SADDLE"),
    [17] = PAGetString(Defines.StringSheet_GAME, "LUA_DYENEW_DYEPART_HORSE_AVATAR_FACE")
  },
  {
    [3] = PAGetString(Defines.StringSheet_GAME, "LUA_INGAMECASHSHOP_SETEQUIP_BARD"),
    [4] = PAGetString(Defines.StringSheet_GAME, "LUA_INGAMECASHSHOP_SETEQUIP_STIRRUP"),
    [5] = PAGetString(Defines.StringSheet_GAME, "LUA_INGAMECASHSHOP_SETEQUIP_SADDLE"),
    [6] = PAGetString(Defines.StringSheet_GAME, "LUA_INGAMECASHSHOP_SETEQUIP_HORSEHEAD"),
    [12] = PAGetString(Defines.StringSheet_GAME, "LUA_DYENEW_DYEPART_HORSE_FOOT"),
    [14] = PAGetString(Defines.StringSheet_GAME, "LUA_DYENEW_DYEPART_HORSE_AVATAR_ARMOR"),
    [15] = PAGetString(Defines.StringSheet_GAME, "LUA_DYENEW_DYEPART_HORSE_AVATAR_STIRRUP"),
    [16] = PAGetString(Defines.StringSheet_GAME, "LUA_DYENEW_DYEPART_HORSE_AVATAR_SADDLE"),
    [17] = PAGetString(Defines.StringSheet_GAME, "LUA_DYENEW_DYEPART_HORSE_AVATAR_FACE")
  },
  {
    [3] = PAGetString(Defines.StringSheet_GAME, "LUA_INGAMECASHSHOP_SETEQUIP_BARD"),
    [4] = PAGetString(Defines.StringSheet_GAME, "LUA_INGAMECASHSHOP_SETEQUIP_STIRRUP"),
    [5] = PAGetString(Defines.StringSheet_GAME, "LUA_INGAMECASHSHOP_SETEQUIP_SADDLE"),
    [6] = PAGetString(Defines.StringSheet_GAME, "LUA_INGAMECASHSHOP_SETEQUIP_HORSEHEAD"),
    [12] = PAGetString(Defines.StringSheet_GAME, "LUA_DYENEW_DYEPART_HORSE_FOOT"),
    [14] = PAGetString(Defines.StringSheet_GAME, "LUA_DYENEW_DYEPART_HORSE_AVATAR_ARMOR"),
    [15] = PAGetString(Defines.StringSheet_GAME, "LUA_DYENEW_DYEPART_HORSE_AVATAR_STIRRUP"),
    [16] = PAGetString(Defines.StringSheet_GAME, "LUA_DYENEW_DYEPART_HORSE_AVATAR_SADDLE"),
    [17] = PAGetString(Defines.StringSheet_GAME, "LUA_DYENEW_DYEPART_HORSE_AVATAR_FACE")
  },
  {
    [3] = PAGetString(Defines.StringSheet_GAME, "LUA_DYERENEW_DYEPART_CAMPTENT_WAREHOUSE"),
    [4] = PAGetString(Defines.StringSheet_GAME, "LUA_DYERENEW_DYEPART_CAMPTENT_REPAIRSHOP"),
    [5] = PAGetString(Defines.StringSheet_GAME, "LUA_DYERENEW_DYEPART_CAMPTENT_SHOP"),
    [6] = PAGetString(Defines.StringSheet_GAME, "LUA_DYERENEW_DYEPART_CAMPTENT_TENT"),
    [14] = PAGetString(Defines.StringSheet_GAME, "LUA_DYERENEW_DYEPART_CAMPTENT_WAREHOUSE"),
    [15] = PAGetString(Defines.StringSheet_GAME, "LUA_DYERENEW_DYEPART_CAMPTENT_REPAIRSHOP"),
    [16] = PAGetString(Defines.StringSheet_GAME, "LUA_DYERENEW_DYEPART_CAMPTENT_SHOP"),
    [17] = PAGetString(Defines.StringSheet_GAME, "LUA_DYERENEW_DYEPART_CAMPTENT_TENT")
  }
}
function PaGlobal_DyeReNew_ButtonHandler_Init()
  if true == dyeCombine.isInitialize then
    return
  end
  if nil == getSelfPlayer() then
    return
  end
  dyeCombine._ui.stc_buttonGroup = UI.getChildControl(Panel_Dye_ReNew, "Static_CheckButtonGroup")
  dyeCombine._ui.toggleWarStance = UI.getChildControl(dyeCombine._ui.stc_buttonGroup, "CheckButton_WarStance")
  dyeCombine._ui.toggleShowUnderwear = UI.getChildControl(dyeCombine._ui.stc_buttonGroup, "CheckButton_ShowUnderWear")
  dyeCombine._ui.toggleHideAvatar = UI.getChildControl(dyeCombine._ui.stc_buttonGroup, "CheckButton_HideAvatar")
  dyeCombine._ui.toggleHideHair = UI.getChildControl(dyeCombine._ui.stc_buttonGroup, "CheckButton_HideHair")
  dyeCombine._ui.toggleHideHelmet = UI.getChildControl(dyeCombine._ui.stc_buttonGroup, "CheckButton_HideHelmet")
  dyeCombine._ui.toggleOpenFaceGuard = UI.getChildControl(dyeCombine._ui.stc_buttonGroup, "CheckButton_OpenFaceGuard")
  dyeCombine._ui.toggleCloakInvisual = UI.getChildControl(dyeCombine._ui.stc_buttonGroup, "CheckButton_Cloak_Invisual")
  dyeCombine._ui.toggleAwakenWeapon = UI.getChildControl(dyeCombine._ui.stc_buttonGroup, "CheckButton_AwakenWeapon")
  dyeCombine._ui.stc_radioGroup = UI.getChildControl(Panel_Dye_ReNew, "Static_ShyWakenWeaponDyeArea")
  dyeCombine._ui.rdo_tring = UI.getChildControl(dyeCombine._ui.stc_radioGroup, "RadioButton_Tring")
  dyeCombine._ui.rdo_tutu = UI.getChildControl(dyeCombine._ui.stc_radioGroup, "RadioButton_Tutu")
  dyeCombine._ui.rdo_tocong = UI.getChildControl(dyeCombine._ui.stc_radioGroup, "RadioButton_Tocong")
  local UIStaticBG = UI.getChildControl(Panel_Dye_ReNew, "Static_BG")
  dyeCombine._ui.stc_partTargetBG = UI.getChildControl(UIStaticBG, "Static_PartTartget_BG")
  dyeCombine._ui.txt_ampuleTargetTitle = UI.getChildControl(UIStaticBG, "StaticText_AmpuleTarget_Title")
  dyeCombine._ui.stc_ampluleTargetBG = UI.getChildControl(UIStaticBG, "Static_AmpuleTartget_BG")
  dyeCombine._ui.txt_endurance = UI.getChildControl(Panel_Dye_ReNew, "StaticText_Endurance")
  dyeCombine._ui.slider_endurance = UI.getChildControl(Panel_Dye_ReNew, "Slider_Endurance")
  dyeCombine._ui.btn_doDye = UI.getChildControl(Panel_Dye_ReNew, "Button_DoDye")
  dyeCombine.basicPanelSizeY = Panel_Dye_ReNew:GetSizeY()
  dyeCombine.basicPartTargetBGPosY = dyeCombine._ui.stc_partTargetBG:GetPosY()
  dyeCombine.basicAmpluleTitlePosY = dyeCombine._ui.txt_ampuleTargetTitle:GetPosY()
  dyeCombine.basicAmpluleBGPosY = dyeCombine._ui.stc_ampluleTargetBG:GetPosY()
  local isClassType = getSelfPlayer():getClassType()
  if __eClassType_ShyWaman == isClassType then
    dyeCombine._ui.toggleAwakenWeapon:ChangeTextureInfoName("Renewal/PcRemaster/Remaster_Btn_01.dds")
    local x1, y1, x2, y2 = setTextureUV_Func(dyeCombine._ui.toggleAwakenWeapon, 263, 1, 295, 33)
    dyeCombine._ui.toggleAwakenWeapon:getBaseTexture():setUV(x1, y1, x2, y2)
    dyeCombine._ui.toggleAwakenWeapon:setRenderTexture(dyeCombine._ui.toggleAwakenWeapon:getBaseTexture())
    dyeCombine._ui.toggleAwakenWeapon:ChangeOnTextureInfoName("Renewal/PcRemaster/Remaster_Btn_01.dds")
    local x1, y1, x2, y2 = setTextureUV_Func(dyeCombine._ui.toggleAwakenWeapon, 296, 1, 328, 33)
    dyeCombine._ui.toggleAwakenWeapon:getOnTexture():setUV(x1, y1, x2, y2)
    dyeCombine._ui.toggleAwakenWeapon:setRenderTexture(dyeCombine._ui.toggleAwakenWeapon:getOnTexture())
    dyeCombine._ui.toggleAwakenWeapon:ChangeClickTextureInfoName("Renewal/PcRemaster/Remaster_Btn_01.dds")
    local x1, y1, x2, y2 = setTextureUV_Func(dyeCombine._ui.toggleAwakenWeapon, 329, 1, 361, 33)
    dyeCombine._ui.toggleAwakenWeapon:getClickTexture():setUV(x1, y1, x2, y2)
    dyeCombine._ui.toggleAwakenWeapon:setRenderTexture(dyeCombine._ui.toggleAwakenWeapon:getClickTexture())
    dyePartString[0][29] = PAGetString(Defines.StringSheet_GAME, "LUA_EQUIPMENT_SHY_AWAKENWEAPON")
    dyePartString[0][30] = PAGetString(Defines.StringSheet_GAME, "LUA_EQUIPMENT_SHY_AWAKENWEAPON_CASH")
  else
    dyeCombine._ui.toggleAwakenWeapon:ChangeTextureInfoName("Renewal/PcRemaster/Remaster_Btn_00.dds")
    local x1, y1, x2, y2 = setTextureUV_Func(dyeCombine._ui.toggleAwakenWeapon, 202, 242, 234, 274)
    dyeCombine._ui.toggleAwakenWeapon:getBaseTexture():setUV(x1, y1, x2, y2)
    dyeCombine._ui.toggleAwakenWeapon:setRenderTexture(dyeCombine._ui.toggleAwakenWeapon:getBaseTexture())
    dyeCombine._ui.toggleAwakenWeapon:ChangeOnTextureInfoName("Renewal/PcRemaster/Remaster_Btn_00.dds")
    local x1, y1, x2, y2 = setTextureUV_Func(dyeCombine._ui.toggleAwakenWeapon, 235, 242, 267, 274)
    dyeCombine._ui.toggleAwakenWeapon:getOnTexture():setUV(x1, y1, x2, y2)
    dyeCombine._ui.toggleAwakenWeapon:setRenderTexture(dyeCombine._ui.toggleAwakenWeapon:getOnTexture())
    dyeCombine._ui.toggleAwakenWeapon:ChangeClickTextureInfoName("Renewal/PcRemaster/Remaster_Btn_00.dds")
    local x1, y1, x2, y2 = setTextureUV_Func(dyeCombine._ui.toggleAwakenWeapon, 268, 242, 300, 274)
    dyeCombine._ui.toggleAwakenWeapon:getClickTexture():setUV(x1, y1, x2, y2)
    dyeCombine._ui.toggleAwakenWeapon:setRenderTexture(dyeCombine._ui.toggleAwakenWeapon:getClickTexture())
  end
  FGlobal_Panel_Dye_ReNew_AddEvent()
  dyeCombine.isInitialize = true
end
local _isCloakOn = false
function FGlobal_Panel_Dye_ReNew_Reset()
  for idx = 0, 6 do
    local static_BG = UI.getChildControl(Panel_Dye_ReNew, "Static_BG")
    local staticBG_CharacterType = UI.getChildControl(static_BG, "Static_SlotBG_CharacterType_" .. idx)
    local radioButton_CharacterType = UI.getChildControl(staticBG_CharacterType, "RadioButton_CharacterType_" .. idx)
    radioButton_CharacterType:SetCheck(false)
    if 0 == idx then
      radioButton_CharacterType:SetCheck(true)
    end
  end
  local txt_Endurance = UI.getChildControl(Panel_Dye_ReNew, "StaticText_Endurance")
  local slider_Endurance = UI.getChildControl(Panel_Dye_ReNew, "Slider_Endurance")
  _isCloakOn = true
  dyeCombine._ui.toggleWarStance:SetCheck(true)
  dyeCombine._ui.toggleShowUnderwear:SetCheck(false)
  dyeCombine._ui.toggleHideAvatar:SetCheck(false)
  dyeCombine._ui.toggleHideHair:SetCheck(false)
  dyeCombine._ui.toggleHideHelmet:SetCheck(false)
  dyeCombine._ui.toggleOpenFaceGuard:SetCheck(false)
  dyeCombine._ui.toggleCloakInvisual:SetCheck(_isCloakOn)
  dyeCombine._ui.toggleAwakenWeapon:SetCheck(false)
  slider_Endurance:SetControlPos(100)
  dyeCombine:resizeAndrepos(false)
end
function FGlobal_Panel_Dye_ReNew_AddEvent()
  local radioButton_CharacterType, staticBG_CharacterType
  local Static_BG = UI.getChildControl(Panel_Dye_ReNew, "Static_BG")
  for ii = 0, enValue.MaxCharacterTypeList - 1 do
    staticBG_CharacterType = UI.getChildControl(Static_BG, "Static_SlotBG_CharacterType_" .. ii)
    radioButton_CharacterType = UI.getChildControl(staticBG_CharacterType, "RadioButton_CharacterType_" .. ii)
    radioButton_CharacterType:addInputEvent("Mouse_LUp", "HandleClicked_DyeReNew_SelectCharacterType( " .. ii .. " )")
    if 3 == ii and false == FGlobal_DyeReNew_GetEnableCamel() then
      radioButton_CharacterType:SetShow(false)
    end
    if 6 == ii and false == FGlobal_DyeReNew_GetEnableTent() then
      radioButton_CharacterType:SetShow(false)
    end
    if 4 == ii and false == FGlobal_DyeReNew_GetEnableShip() then
      radioButton_CharacterType:SetShow(false)
    end
  end
  local buttonQuestion = UI.getChildControl(Panel_Dye_ReNew, "Button_Question")
  buttonQuestion:addInputEvent("Mouse_LUp", "Panel_WebHelper_ShowToggle( \"Dye\" )")
  PaGlobal_Util_RegistHelpTooltipEvent(buttonQuestion, "\"Dye\"")
  local slider_Endurance = UI.getChildControl(Panel_Dye_ReNew, "Slider_Endurance")
  local slider_EnduranceController = UI.getChildControl(slider_Endurance, "Slider_Endurance_Button")
  slider_Endurance:addInputEvent("Mouse_LUp", "HandleClicked_DyeReNew_SetEndurance()")
  slider_EnduranceController:addInputEvent("Mouse_LPress", "HandleClicked_DyeReNew_SetEndurance()")
  local txt_Endurance = UI.getChildControl(Panel_Dye_ReNew, "StaticText_Endurance")
  if true == FGlobal_DyeReNew_GetEnableKR2() then
    txt_Endurance:SetShow(false)
    slider_Endurance:SetShow(false)
  end
  dyeCombine._ui.toggleWarStance:addInputEvent("Mouse_LUp", "HandleClicked_DyeReNew_ToggleWarStance()")
  dyeCombine._ui.toggleWarStance:addInputEvent("Mouse_On", "HandleOver_DyeReNew_SimpleTooltipCheckbutton(true," .. enToggleIndex.WarStance .. ")")
  dyeCombine._ui.toggleWarStance:addInputEvent("Mouse_Out", "HandleOver_DyeReNew_SimpleTooltipCheckbutton(false," .. enToggleIndex.WarStance .. ")")
  dyeCombine._ui.toggleShowUnderwear:addInputEvent("Mouse_LUp", "HandleClicked_DyeReNew_SetShowUnderwear()")
  dyeCombine._ui.toggleShowUnderwear:addInputEvent("Mouse_On", "HandleOver_DyeReNew_SimpleTooltipCheckbutton(true," .. enToggleIndex.Underwear .. ")")
  dyeCombine._ui.toggleShowUnderwear:addInputEvent("Mouse_Out", "HandleOver_DyeReNew_SimpleTooltipCheckbutton(false," .. enToggleIndex.Underwear .. ")")
  if true == FGlobal_DyeReNew_GetEnableKR2() then
    dyeCombine._ui.toggleShowUnderwear:SetShow(false)
  end
  if false == ToClient_isAdultUser() then
    dyeCombine._ui.toggleShowUnderwear:SetShow(false)
    dyeCombine._ui.toggleShowUnderwear:SetIgnore(false)
  end
  dyeCombine._ui.toggleHideAvatar:addInputEvent("Mouse_LUp", "HandleClicked_DyeReNew_SetHideAvartar()")
  dyeCombine._ui.toggleHideAvatar:addInputEvent("Mouse_On", "HandleOver_DyeReNew_SimpleTooltipCheckbutton(true," .. enToggleIndex.Avater .. ")")
  dyeCombine._ui.toggleHideAvatar:addInputEvent("Mouse_Out", "HandleOver_DyeReNew_SimpleTooltipCheckbutton(false," .. enToggleIndex.Avater .. ")")
  dyeCombine._ui.toggleHideHair:addInputEvent("Mouse_LUp", "HandleClicked_DyeReNew_SetFaceViewHair()")
  dyeCombine._ui.toggleHideHair:addInputEvent("Mouse_On", "HandleOver_DyeReNew_SimpleTooltipCheckbutton(true," .. enToggleIndex.FaceViewHair .. ")")
  dyeCombine._ui.toggleHideHair:addInputEvent("Mouse_Out", "HandleOver_DyeReNew_SimpleTooltipCheckbutton(false," .. enToggleIndex.FaceViewHair .. ")")
  dyeCombine._ui.toggleHideHelmet:addInputEvent("Mouse_LUp", "HandleClicked_DyeReNew_SetHideHelmet()")
  dyeCombine._ui.toggleHideHelmet:addInputEvent("Mouse_On", "HandleOver_DyeReNew_SimpleTooltipCheckbutton(true," .. enToggleIndex.Helmet .. ")")
  dyeCombine._ui.toggleHideHelmet:addInputEvent("Mouse_Out", "HandleOver_DyeReNew_SimpleTooltipCheckbutton(false," .. enToggleIndex.Helmet .. ")")
  dyeCombine._ui.toggleOpenFaceGuard:addInputEvent("Mouse_LUp", "HandleClicked_DyeReNew_SetFaceGuard()")
  dyeCombine._ui.toggleOpenFaceGuard:addInputEvent("Mouse_On", "HandleOver_DyeReNew_SimpleTooltipCheckbutton(true," .. enToggleIndex.FaceGuard .. ")")
  dyeCombine._ui.toggleOpenFaceGuard:addInputEvent("Mouse_Out", "HandleOver_DyeReNew_SimpleTooltipCheckbutton(false," .. enToggleIndex.FaceGuard .. ")")
  dyeCombine._ui.toggleCloakInvisual:addInputEvent("Mouse_LUp", "HandleClicked_DyeReNew_SetCloakInvisual()")
  dyeCombine._ui.toggleCloakInvisual:addInputEvent("Mouse_On", "HandleOver_DyeReNew_SimpleTooltipCheckbutton(true," .. enToggleIndex.Cloak .. ")")
  dyeCombine._ui.toggleCloakInvisual:addInputEvent("Mouse_Out", "HandleOver_DyeReNew_SimpleTooltipCheckbutton(false," .. enToggleIndex.Cloak .. ")")
  dyeCombine._ui.toggleAwakenWeapon:addInputEvent("Mouse_LUp", "HandleClicked_DyeReNew_SetAwakenWeapon()")
  dyeCombine._ui.toggleAwakenWeapon:addInputEvent("Mouse_On", "HandleOver_DyeReNew_SimpleTooltipCheckbutton(true," .. enToggleIndex.AwakenWeapon .. ")")
  dyeCombine._ui.toggleAwakenWeapon:addInputEvent("Mouse_Out", "HandleOver_DyeReNew_SimpleTooltipCheckbutton(false," .. enToggleIndex.AwakenWeapon .. ")")
  dyeCombine._ui.toggleAwakenWeapon:SetShow(FGlobal_DyeReNew_GetEnableAwaken())
  local UIAmpuleTargetBG = UI.getChildControl(Static_BG, "Static_AmpuleTartget_BG")
  local RadioButton_Tab_ALL = UI.getChildControl(UIAmpuleTargetBG, "RadioButton_Tab_ALL")
  local RadioButton_Tab_My = UI.getChildControl(UIAmpuleTargetBG, "RadioButton_Tab_My")
  local RadioButton_Tab_Pearl = UI.getChildControl(UIAmpuleTargetBG, "RadioButton_Tab_Pearl")
  RadioButton_Tab_ALL:addInputEvent("Mouse_LUp", "HandleClicked_LUp_Ampule_SelectedType( true, false )")
  RadioButton_Tab_ALL:addInputEvent("Mouse_On", "HandleOnOut_DyeReNew_Palette_Category_Tooltip( true, " .. 8 .. ")")
  RadioButton_Tab_ALL:addInputEvent("Mouse_Out", "HandleOnOut_DyeReNew_Palette_Category_Tooltip( false, " .. 8 .. ")")
  RadioButton_Tab_ALL:SetTextMode(__eTextMode_LimitText)
  RadioButton_Tab_ALL:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_PALETTE_TAB_ALL"))
  RadioButton_Tab_My:addInputEvent("Mouse_LUp", "HandleClicked_LUp_Ampule_SelectedType( false, false )")
  RadioButton_Tab_My:addInputEvent("Mouse_On", "HandleOnOut_DyeReNew_Palette_Category_Tooltip( true, " .. 9 .. ")")
  RadioButton_Tab_My:addInputEvent("Mouse_Out", "HandleOnOut_DyeReNew_Palette_Category_Tooltip( false, " .. 9 .. ")")
  RadioButton_Tab_My:SetTextMode(__eTextMode_LimitText)
  RadioButton_Tab_My:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_PALETTE_TAB_MY"))
  RadioButton_Tab_Pearl:addInputEvent("Mouse_LUp", "HandleClicked_LUp_Ampule_SelectedType( true, true )")
  RadioButton_Tab_Pearl:addInputEvent("Mouse_On", "HandleOnOut_DyeReNew_Palette_Category_Tooltip( true, " .. 10 .. ")")
  RadioButton_Tab_Pearl:addInputEvent("Mouse_Out", "HandleOnOut_DyeReNew_Palette_Category_Tooltip( false, " .. 10 .. ")")
  RadioButton_Tab_Pearl:SetTextMode(__eTextMode_LimitText)
  RadioButton_Tab_Pearl:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_SELFPLAYEREXPGAUGE_DYEINGPACKEAGE_TITLE"))
  if false == FGlobal_DyeReNew_GetEnableDyePearl() then
    RadioButton_Tab_Pearl:SetShow(false)
  end
  for ii = 0, 7 do
    local UIMaterial = UI.getChildControl(UIAmpuleTargetBG, "RadioButton_Material_" .. ii)
    UIMaterial:addInputEvent("Mouse_LUp", "HandleClicked_LUp_Ampule_SelectCategory( " .. ii .. ")")
    UIMaterial:addInputEvent("Mouse_On", "HandleOnOut_DyeReNew_Palette_Category_Tooltip( true, " .. ii .. ")")
    UIMaterial:addInputEvent("Mouse_Out", "HandleOnOut_DyeReNew_Palette_Category_Tooltip( false, " .. ii .. ")")
    if 0 == ii then
      UIMaterial:SetCheck(true)
    end
  end
  dyeCombine._ui.btn_doDye:addInputEvent("Mouse_LUp", "HandleClicked_DeyReNew_DoDye()")
  dyeCombine._ui.rdo_tring:addInputEvent("Mouse_LUp", "HandleClicked_DyeReNew_SetAwakeWeaponAction(" .. __eDyeingAwakenBattleActionIndex_Lute .. ")")
  dyeCombine._ui.rdo_tutu:addInputEvent("Mouse_LUp", "HandleClicked_DyeReNew_SetAwakeWeaponAction(" .. __eDyeingAwakenBattleActionIndex_Flute .. ")")
  dyeCombine._ui.rdo_tocong:addInputEvent("Mouse_LUp", "HandleClicked_DyeReNew_SetAwakeWeaponAction(" .. __eDyeingAwakenBattleActionIndex_Djembe .. ")")
end
function HandleReset_DyeReNew_AmpuleTab_BySelectCharacterType()
  local Static_BG = UI.getChildControl(Panel_Dye_ReNew, "Static_BG")
  local UIAmpuleTargetBG = UI.getChildControl(Static_BG, "Static_AmpuleTartget_BG")
  local RadioButton_Tab_ALL = UI.getChildControl(UIAmpuleTargetBG, "RadioButton_Tab_ALL")
  local RadioButton_Tab_My = UI.getChildControl(UIAmpuleTargetBG, "RadioButton_Tab_My")
  local RadioButton_Tab_Pearl = UI.getChildControl(UIAmpuleTargetBG, "RadioButton_Tab_Pearl")
  RadioButton_Tab_ALL:SetCheck(false)
  RadioButton_Tab_My:SetCheck(true)
  RadioButton_Tab_Pearl:SetCheck(false)
end
function HandleClicked_DyeReNew_SelectCharacterType(idx)
  local self = FGlobal_DyeReNew_GetInstance()
  local oldSelectedCharacterType = self._selected_CharacterTarget
  local oldSelectEquipSlotNo = self._selected_EquipSlotNo
  if idx >= enValue.MaxCharacterTypeList or oldSelectedCharacterType == idx then
    return
  end
  self._selected_EquipSlotNo = -1
  local bChangeSelectedCharacterType = ToClient_RequestSetTargetType(idx)
  if bChangeSelectedCharacterType then
    self._selected_CharacterTarget = idx
    self._paletteShowAll = false
    self._isPearlPalette = false
    self._scrollStartIndex = 0
    self._AmpuleScroll:SetControlTop()
    Inventory_SetFunctor(FGlobal_Panel_DyeReNew_InventoryFilter, FGlobal_Panel_DyeReNew_Interaction_FromInventory, nil, nil)
    HandleReset_DyeReNew_AmpuleTab_BySelectCharacterType()
    self:Change_EquipIcon()
    self:Update_Part()
    self:Update_AmpuleList()
    self._selectedDyePart = {}
    self:Update_Position()
  else
    self._selected_EquipSlotNo = oldSelectEquipSlotNo
    local UIStaticBG = UI.getChildControl(Panel_Dye_ReNew, "Static_BG")
    local UIButtonBGOld = UI.getChildControl(UIStaticBG, "Static_SlotBG_CharacterType_" .. oldSelectedCharacterType)
    local UIRadioButtonOld = UI.getChildControl(UIButtonBGOld, "RadioButton_CharacterType_" .. oldSelectedCharacterType)
    local UIButtonBGNew, UIRadioButtonNew
    UIButtonBGNew = UI.getChildControl(UIStaticBG, "Static_SlotBG_CharacterType_" .. idx)
    UIRadioButtonNew = UI.getChildControl(UIButtonBGNew, "RadioButton_CharacterType_" .. idx)
    UIRadioButtonNew:SetCheck(false)
    UIRadioButtonOld:SetCheck(true)
  end
end
function HandleClicked_RUp_ClearEquipItemByEquipSlotNo(equipSlotNo, equipSlotIndex)
  local self = FGlobal_DyeReNew_GetInstance()
  Panel_Tooltip_Item_hideTooltip()
  ToClient_RequestClearDyeingTargetSlot(equipSlotNo)
  local removeCount = 0
  for key, value in pairs(self._selectedDyePart) do
    if value == equipSlotNo then
      removeCount = removeCount + 1
    end
  end
  for ii = 0, removeCount - 1 do
    table.remove(self._selectedDyePart, self._selectedDyePart[equipSlotNo])
  end
  self._arrEquipSlotItem[equipSlotIndex].icon:SetColor(4286019447)
  if equipSlotNo == self._selected_EquipSlotNo then
    self._selected_EquipSlotNo = -1
    self:Reset_Part(true)
  end
end
function HandleClicked_OnOut_ShowEquipItemToolTip(isShow, equipSlotNo, slotIdx)
  local self = FGlobal_DyeReNew_GetInstance()
  if true == isShow then
    local itemWrapper = ToClient_RequestGetDyeingTargetItemWrapper(equipSlotNo)
    local SlotIcon = self._arrEquipSlotItem[slotIdx].icon
    Panel_Tooltip_Item_Show(itemWrapper, SlotIcon, false, true, nil, nil, nil, nil, "Dye", equipSlotNo)
  else
    Panel_Tooltip_Item_hideTooltip()
  end
end
function HandleClicked_LUp_SelectEquipItem(equipSlotNo, equipSlotIndex)
  local self = FGlobal_DyeReNew_GetInstance()
  for ii = 0, enValue.MaxEquipSlotCount - 1 do
    if ii == equipSlotIndex then
      self._arrEquipSlotItem[ii].icon:SetColor(4294967295)
    else
      self._arrEquipSlotItem[ii].icon:SetColor(4286019447)
    end
  end
  local isClassType = getSelfPlayer():getClassType()
  if 29 == equipSlotNo and __eClassType_ShyWaman == isClassType then
    dyeCombine:resizeAndrepos(true)
    HandleClicked_DyeReNew_SetAwakeWeaponAction(__eDyeingAwakenBattleActionIndex_Base)
  else
    dyeCombine:resizeAndrepos(false)
  end
  self._selected_EquipSlotNo = equipSlotNo
  ToClient_RequestSelectedEquipItem(equipSlotNo)
  local isWeaponEquip = false
  if (6 == equipSlotNo or 17 == equipSlotNo) and false == PaGlobal_DyeReNew_GetHideHelmet() then
    HandleClicked_DyeReNew_SetHideHelmet()
    dyeCombine._ui.toggleHideHelmet:SetCheck(false)
  end
  if true == dyeCombine._ui.toggleShowUnderwear:GetShow() then
    if 20 == equipSlotNo then
      dyeCombine._ui.toggleShowUnderwear:SetCheck(true)
    else
      dyeCombine._ui.toggleShowUnderwear:SetCheck(false)
    end
  end
  if true == dyeCombine._ui.toggleHideAvatar:GetShow() then
    if 0 <= equipSlotNo and equipSlotNo <= 6 or 29 == equipSlotNo then
      dyeCombine._ui.toggleHideAvatar:SetCheck(true)
    elseif 14 <= equipSlotNo and equipSlotNo <= 23 or 30 == equipSlotNo then
      dyeCombine._ui.toggleHideAvatar:SetCheck(false)
    end
  end
  if true == dyeCombine._ui.toggleAwakenWeapon:GetShow() then
    if 0 == equipSlotNo or 1 == equipSlotNo or 18 == equipSlotNo or 19 == equipSlotNo then
      isWeaponEquip = true
      if true == PaGlobal_DyeReNew_GetAwakenWeapon() then
        HandleClicked_DyeReNew_SetAwakenWeapon()
        dyeCombine._ui.toggleAwakenWeapon:SetCheck(false)
      end
    elseif 29 == equipSlotNo or 30 == equipSlotNo then
      isWeaponEquip = true
      if false == PaGlobal_DyeReNew_GetAwakenWeapon() then
        HandleClicked_DyeReNew_SetAwakenWeapon()
        dyeCombine._ui.toggleAwakenWeapon:SetCheck(true)
      end
    else
      isWeaponEquip = false
    end
  end
  if true == isWeaponEquip then
    if false == PaGlobal_DyeReNew_GetToggleWarStance() then
      HandleClicked_DyeReNew_ToggleWarStance()
      dyeCombine._ui.toggleWarStance:SetCheck(true)
    end
  else
    if true == PaGlobal_DyeReNew_GetToggleWarStance() then
      HandleClicked_DyeReNew_ToggleWarStance()
      dyeCombine._ui.toggleWarStance:SetCheck(false)
    end
    if true == PaGlobal_DyeReNew_GetAwakenWeapon() then
      HandleClicked_DyeReNew_SetAwakenWeapon()
      dyeCombine._ui.toggleAwakenWeapon:SetCheck(false)
    end
  end
  self._nowClickPartId = -1
  self._nowClickPartSlotId = -1
  self:Reset_Part(true)
  self:Change_EquipIcon()
  self:Update_Part()
  HandleClicked_DyeReNew_SetEndurance()
end
function HandleClicked_LUp_EquipPartReset(equipSlotNo, partId, slotId, uiIdx)
  local self = FGlobal_DyeReNew_GetInstance()
  ToClient_RequestClearUsedDyeingPalette(equipSlotNo, partId, slotId)
  self._selectedDyePart[equipSlotNo] = false
  self:Update_Part()
  self:Update_AmpuleList()
end
function HandleClicked_LUp_SelectEquipPart(partID, slotID, UIidx)
  local self = FGlobal_DyeReNew_GetInstance()
  ToClient_RequestSelectedDyeingPartSlot(self._selected_EquipSlotNo, partID, slotID)
  self._nowClickPartId = partID
  self._nowClickPartSlotId = slotID
end
function HandleOnOut_DeyReNew_Ampule_Color(isShow, itemEnchantKey, UIIndex)
  local self = FGlobal_DyeReNew_GetInstance()
  local uiControl = self._arrAmpuleSlotBG[UIIndex]
  local itemEnchantSSW = getItemEnchantStaticStatus(ItemEnchantKey(itemEnchantKey))
  local itemEnchantSS = itemEnchantSSW:get()
  local itemName = getItemName(itemEnchantSS)
  local desc
  registTooltipControl(uiControl, Panel_Tooltip_SimpleText)
  if true == isShow then
    TooltipSimple_Show(uiControl, itemName, desc)
  else
    TooltipSimple_Hide()
  end
end
function HandleScroll_DyeReNew_Ampule_ScrollUpdate(isScrollUp)
  local self = FGlobal_DyeReNew_GetInstance()
  local movingValue = 2
  self._scrollStartIndex = UIScroll.ScrollEvent(self._AmpuleScroll, isScrollUp, movingValue, self._scrollMaxRow, self._scrollStartIndex, 1)
  self:Update_AmpuleList()
end
function HandleClicked_DyeReNew_PressAmpuleScroll()
  local self = FGlobal_DyeReNew_GetInstance()
  self._scrollStartIndex = math.ceil((self._scrollMaxRow - 2) * self._AmpuleScroll:GetControlPos())
  self:Update_AmpuleList()
end
function HandleClicked_LUp_Ampule_SelectCategory(categoryIdx)
  local self = FGlobal_DyeReNew_GetInstance()
  self._nowPaletteCategoryIndex = categoryIdx
  self._scrollStartIndex = 0
  UI.getChildControl(self._AmpuleScroll, "Scroll_CtrlButton"):SetPosY(self._scrollStartIndex)
  self:Update_AmpuleList()
end
function HandleOnOut_DyeReNew_Palette_Category_Tooltip(isOn, ButtonIndex)
  local name = ""
  local desc
  local Static_BG = UI.getChildControl(Panel_Dye_ReNew, "Static_BG")
  local UIAmpuleTargetBG = UI.getChildControl(Static_BG, "Static_AmpuleTartget_BG")
  if true == isOn then
    if 7 < ButtonIndex then
      local UICategory
      if 8 == ButtonIndex then
        UICategory = UI.getChildControl(UIAmpuleTargetBG, "RadioButton_Tab_ALL")
        name = PAGetString(Defines.StringSheet_GAME, "LUA_PALETTE_TAB_ALL")
      elseif 9 == ButtonIndex then
        UICategory = UI.getChildControl(UIAmpuleTargetBG, "RadioButton_Tab_My")
        name = PAGetString(Defines.StringSheet_GAME, "LUA_PALETTE_TAB_MY")
      elseif 10 == ButtonIndex then
        UICategory = UI.getChildControl(UIAmpuleTargetBG, "RadioButton_Tab_Pearl")
        name = PAGetString(Defines.StringSheet_GAME, "LUA_SELFPLAYEREXPGAUGE_DYEINGPACKEAGE_TITLE")
        desc = PAGetString(Defines.StringSheet_GAME, "LUA_PALETTE_TAB_MATERIAL_DESC_8")
      end
      registTooltipControl(UICategory, Panel_Tooltip_SimpleText)
      TooltipSimple_Show(UICategory, name, desc)
    else
      local UIMaterial = UI.getChildControl(UIAmpuleTargetBG, "RadioButton_Material_" .. ButtonIndex)
      name = PAGetString(Defines.StringSheet_GAME, "LUA_PALETTE_TAB_MATERIAL_" .. ButtonIndex)
      desc = PAGetString(Defines.StringSheet_GAME, "LUA_PALETTE_TAB_MATERIAL_DESC_" .. ButtonIndex)
      registTooltipControl(UIMaterial, Panel_Tooltip_SimpleText)
      TooltipSimple_Show(UIMaterial, name, desc)
    end
  else
    TooltipSimple_Hide()
  end
end
function HandleClicked_LUp_Ampule_SelectedType(isShowAll, isPearl)
  local self = FGlobal_DyeReNew_GetInstance()
  local selfPlayer = getSelfPlayer()
  if isShowAll and isPearl then
    local dyeingPackageTime = selfPlayer:get():isApplyChargeSkill(UI_BUFFTYPE.eUserChargeType_DyeingPackage)
    if not dyeingPackageTime then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_DYENEW_MUST_ACTIVE_PEARLCOLOR"))
      PaGlobal_EasyBuy:Open(48)
      return
    end
  end
  if isPearl ~= self._isPearlPalette then
    ToClient_RequestClearDyeingSlot(self._selected_EquipSlotNo)
    self._selectedDyePart = {}
    self._ampuleCountCheck = false
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_DYE_NEW_PALETTE_PREVIEW_ACK"))
  end
  self._paletteShowAll = isShowAll
  self._scrollStartIndex = 0
  self._selectedCategoryIdx = 0
  self._isPearlPalette = isPearl
  UI.getChildControl(self._AmpuleScroll, "Scroll_CtrlButton"):SetPosY(self._scrollStartIndex)
  self:Update_AmpuleList()
end
function HandleClicked_DeyReNew_Palette_SelectColor(dataIdx)
  local self = FGlobal_DyeReNew_GetInstance()
  if true == self._checkButtonDyeAll:IsCheck() then
    local infoCount = ToClient_getDyeingTargetInformationCount()
    if 0 == infoCount then
      return
    end
    for ii = 0, infoCount - 1 do
      self._nowPaletteDataIndex = dataIdx
      self._nowClickPartId = self._partDyeInfo[ii][1]
      self._nowClickPartSlotId = self._partDyeInfo[ii][2]
      if -1 == self._selected_EquipSlotNo or -1 == self._nowClickPartId then
        return
      end
      local DyeingPaletteCategoryInfo = ToClient_requestGetPaletteCategoryInfo(self._nowPaletteCategoryIndex, self._paletteShowAll)
      local isDyeUI = true
      local ampuleCount = DyeingPaletteCategoryInfo:getCount(self._nowPaletteDataIndex, isDyeUI)
      local convertCount = tostring(ampuleCount)
      convertCount = tonumber(convertCount)
      if 1 <= convertCount then
        self._ampuleCountCheck = false
      else
        self._ampuleCountCheck = true
        if true == self._isPearlPalette then
          self._ampuleCountCheck = false
        end
      end
      ToClient_RequestSelectedDyeingPalette(self._selected_EquipSlotNo, self._nowClickPartId, self._nowClickPartSlotId, self._nowPaletteCategoryIndex, self._nowPaletteDataIndex, self._paletteShowAll)
      if 0 < ToClient_RequestGetPartDyeingSlotCount(self._selected_EquipSlotNo, 0) then
        self._selectedDyePart[self._selected_EquipSlotNo] = true
      end
    end
  else
    self._nowPaletteDataIndex = dataIdx
    if -1 == self._selected_EquipSlotNo or -1 == self._nowClickPartId then
      return
    end
    local DyeingPaletteCategoryInfo = ToClient_requestGetPaletteCategoryInfo(self._nowPaletteCategoryIndex, self._paletteShowAll)
    local isDyeUI = true
    local ampuleCount = DyeingPaletteCategoryInfo:getCount(self._nowPaletteDataIndex, isDyeUI)
    local convertCount = tostring(ampuleCount)
    convertCount = tonumber(convertCount)
    if 1 <= convertCount then
      self._ampuleCountCheck = false
    else
      self._ampuleCountCheck = true
      if true == self._isPearlPalette then
        self._ampuleCountCheck = false
      end
    end
    ToClient_RequestSelectedDyeingPalette(self._selected_EquipSlotNo, self._nowClickPartId, self._nowClickPartSlotId, self._nowPaletteCategoryIndex, self._nowPaletteDataIndex, self._paletteShowAll)
    if 0 < ToClient_RequestGetPartDyeingSlotCount(self._selected_EquipSlotNo, 0) then
      self._selectedDyePart[self._selected_EquipSlotNo] = true
    end
  end
  Panel_Tooltip_Item_hideTooltip()
  self:Update_Part()
  self:Update_AmpuleList()
end
function HandleOpen_RadioButton_AmpuleReset()
  local Static_BG = UI.getChildControl(Panel_Dye_ReNew, "Static_BG")
  local UIAmpuleTargetBG = UI.getChildControl(Static_BG, "Static_AmpuleTartget_BG")
  local RadioButton_Tab_ALL = UI.getChildControl(UIAmpuleTargetBG, "RadioButton_Tab_ALL")
  local RadioButton_Tab_My = UI.getChildControl(UIAmpuleTargetBG, "RadioButton_Tab_My")
  local RadioButton_Tab_Pearl = UI.getChildControl(UIAmpuleTargetBG, "RadioButton_Tab_Pearl")
  RadioButton_Tab_ALL:SetCheck(false)
  RadioButton_Tab_My:SetCheck(true)
  RadioButton_Tab_Pearl:SetCheck(false)
end
function HandleClicked_DyeReNew_SetEndurance()
  local index = UI.getChildControl(Panel_Dye_ReNew, "Slider_Endurance"):GetSelectIndex()
  ToClient_RequestChangeEndurance(index)
end
function HandleClicked_DyeReNew_SetShowUnderwear()
  local self = FGlobal_DyeReNew_GetInstance()
  self._bShowUnderwear = not self._bShowUnderwear
  ToClient_RequestToggleShowUnderwear()
  HandleClicked_DyeReNew_SetEndurance()
  if true == self._bWarStance then
    ToClient_RequestSetBattleView(self._bWarStance)
  end
end
function HandleClicked_DyeReNew_SetHideAvartar()
  local self = FGlobal_DyeReNew_GetInstance()
  dyeCombine._ui.toggleShowUnderwear:SetCheck(false)
  ToClient_RequestToggleHideAvatar()
  self._selected_EquipSlotNo = -1
  self:Change_EquipIcon()
  self:Update_Part()
  self:Update_AmpuleList()
end
function HandleClicked_DyeReNew_SetFaceViewHair()
  local self = FGlobal_DyeReNew_GetInstance()
  self._bFaceVeiwHair = not self._bFaceVeiwHair
  ToClient_setFaceViewHair(self._bFaceVeiwHair)
end
function PaGlobal_DyeReNew_GetHideHelmet()
  local self = FGlobal_DyeReNew_GetInstance()
  return self._bHideHelmet
end
function HandleClicked_DyeReNew_SetHideHelmet()
  local self = FGlobal_DyeReNew_GetInstance()
  self._bHideHelmet = not self._bHideHelmet
  ToClient_RequestHideHelmet(self._bHideHelmet)
end
function HandleClicked_DyeReNew_SetFaceGuard()
  local self = FGlobal_DyeReNew_GetInstance()
  self._bOpenFaceGuard = not self._bOpenFaceGuard
  ToClient_RequestHideBattleHelmet(self._bOpenFaceGuard)
end
function HandleClicked_DyeReNew_SetCloakInvisual()
  _isCloakOn = not _isCloakOn
  ToClient_RequestHideCloak(_isCloakOn)
end
function PaGlobal_DyeReNew_GetToggleWarStance()
  local self = FGlobal_DyeReNew_GetInstance()
  return self._bWarStance
end
function HandleClicked_DyeReNew_ToggleWarStance()
  local self = FGlobal_DyeReNew_GetInstance()
  self._bWarStance = not self._bWarStance
  ToClient_RequestSetBattleView(self._bWarStance)
end
function HandleClicked_DyeReNew_ToggleWarStanceWithAwaken()
  local self = FGlobal_DyeReNew_GetInstance()
  HandleClicked_DyeReNew_ToggleWarStance()
  if true == self._bShowAwakenWeapon then
    HandleClicked_DyeReNew_SetAwakenWeapon()
    dyeCombine._ui.toggleAwakenWeapon:SetCheck(false)
  end
end
function PaGlobal_DyeReNew_GetAwakenWeapon()
  local self = FGlobal_DyeReNew_GetInstance()
  return self._bShowAwakenWeapon
end
function HandleClicked_DyeReNew_SetAwakenWeapon()
  local self = FGlobal_DyeReNew_GetInstance()
  self._bShowAwakenWeapon = not self._bShowAwakenWeapon
  ToClient_SetAwakenWeaponShow(self._bShowAwakenWeapon)
end
function HandleClicked_DyeReNew_SetAwakeWeaponAction(actionIndex)
  if actionIndex == ToClient_GetAwakenWeaponActionIndex() then
    return
  end
  ToClient_SetAwakenWeaponActionIndex(actionIndex)
end
function HandleClicked_DyeReNew_SetAwakenWeaponWithWarStance()
  HandleClicked_DyeReNew_SetAwakenWeapon()
  if false == PaGlobal_DyeReNew_GetToggleWarStance() then
    HandleClicked_DyeReNew_ToggleWarStance()
    dyeCombine._ui.toggleWarStance:SetCheck(true)
  end
end
function HandleOver_DyeReNew_SimpleTooltipCheckbutton(isShow, tipType)
  if nil == getSelfPlayer() then
    return
  end
  local isClassType = getSelfPlayer():getClassType()
  local name, desc, control
  if enToggleIndex.Underwear == tipType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_INGAMECASHSHOP_SETEQUIP_SHOWUNDERWEAR")
    control = UI.getChildControl(dyeCombine._ui.stc_buttonGroup, "CheckButton_ShowUnderWear")
  elseif enToggleIndex.Avater == tipType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_INGAMECASHSHOP_SETEQUIP_HIDEAVATAR")
    control = UI.getChildControl(dyeCombine._ui.stc_buttonGroup, "CheckButton_HideAvatar")
  elseif enToggleIndex.Helmet == tipType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_INGAMECASHSHOP_SETEQUIP_HIDEHELM")
    control = UI.getChildControl(dyeCombine._ui.stc_buttonGroup, "CheckButton_HideHelmet")
  elseif enToggleIndex.AwakenWeapon == tipType then
    if isClassType == __eClassType_ShyWaman then
      name = PAGetString(Defines.StringSheet_GAME, "LUA_INGAMECASHSHOP_SHY_AWAKENWEAPON_SHOW")
    else
      name = PAGetString(Defines.StringSheet_GAME, "LUA_INGAMECASHSHOP_SETEQUIP_AWAKENWEAPON")
    end
    control = UI.getChildControl(dyeCombine._ui.stc_buttonGroup, "CheckButton_AwakenWeapon")
  elseif enToggleIndex.FaceViewHair == tipType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_INGAMECASHSHOP_SETEQUIP_HIDHAIR")
    control = UI.getChildControl(dyeCombine._ui.stc_buttonGroup, "CheckButton_HideHair")
  elseif enToggleIndex.FaceGuard == tipType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_INGAMECASHSHOP_SETEQUIP_OPENHELM")
    control = UI.getChildControl(dyeCombine._ui.stc_buttonGroup, "CheckButton_OpenFaceGuard")
  elseif enToggleIndex.WarStance == tipType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_INGAMECASHSHOP_SETEQUIP_TOOLTIP_WARSTANCE")
    control = UI.getChildControl(dyeCombine._ui.stc_buttonGroup, "CheckButton_WarStance")
  elseif enToggleIndex.Cloak == tipType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_EQUIPMENT_TOOLTIP_CLOAK_NAME")
    control = UI.getChildControl(dyeCombine._ui.stc_buttonGroup, "CheckButton_Cloak_Invisual")
  end
  registTooltipControl(control, Panel_Tooltip_SimpleText)
  if isShow == true then
    TooltipSimple_Show(control, name, desc)
  else
    TooltipSimple_Hide()
  end
end
function HandleClicked_DeyReNew_DoDye()
  local self = FGlobal_DyeReNew_GetInstance()
  local _dyePartString = ""
  local equipSlotNo = self._selected_EquipSlotNo
  if -1 == self._nowPaletteDataIndex then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_DYE_NEW_FIRSTSELECTDYENOGETITEM"))
    return
  end
  if true == self._ampuleCountCheck then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_DYE_AMPULEALERT"))
    return
  end
  local noAction = function()
    return
  end
  local function doDye()
    ToClient_RequestDye(self._isPearlPalette)
    FGlobal_Panel_DyeReNew_Hide()
  end
  local function askDoDye()
    local messageBoxTitle = PAGetString(Defines.StringSheet_GAME, "LUA_ALERT_DEFAULT_TITLE")
    local messageBoxMemo = PAGetStringParam1(Defines.StringSheet_GAME, "PANEL_DYENEW_SURE_DYE_THIS_PART", "partString", _dyePartString)
    local messageBoxData = {
      title = messageBoxTitle,
      content = messageBoxMemo,
      functionYes = doDye,
      functionNo = noAction,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageBoxData)
    return
  end
  local function alreadyPearlDye()
    local messageBoxTitle = PAGetString(Defines.StringSheet_GAME, "LUA_ALERT_DEFAULT_TITLE")
    local messageBoxMemo = PAGetString(Defines.StringSheet_GAME, "LUA_DYENEW_ALREADY_PEARLCOLOR")
    local messageBoxData = {
      title = messageBoxTitle,
      content = messageBoxMemo,
      functionYes = askDoDye,
      functionNo = noAction,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageBoxData)
    return
  end
  for index, value in pairs(self._selectedDyePart) do
    if "" == _dyePartString and true == self._selectedDyePart[index] then
      _dyePartString = "<" .. dyePartString[self._selected_CharacterTarget][index] .. ">"
    elseif true == self._selectedDyePart[index] then
      _dyePartString = _dyePartString .. ", <" .. dyePartString[self._selected_CharacterTarget][index] .. ">"
    end
  end
  if false == PaGlobal_DyeReNew_IsSelectedEquipSlot() then
    if -1 == equipSlotNo then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_DYE_FAIL1"))
    elseif -1 == self._nowClickPartSlotId and false == self._checkButtonDyeAll:IsCheck() then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_DYE_FAIL2"))
    else
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_DYE_FAIL3"))
    end
    return
  end
  if self._isPearlPalette then
    local isAlreadyDye = ToClient_isAllreadyDyeing(equipSlotNo)
    if true == isAlreadyDye then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_DYENEW_ALREADY_NORMALCOLOR"))
      return
    elseif "" == _dyePartString then
      doDye()
    else
      askDoDye()
    end
  else
    local isAlreadyPearlDye = ToClient_isExpirationDyeing(equipSlotNo)
    if true == isAlreadyPearlDye then
      alreadyPearlDye()
    elseif "" == _dyePartString then
      doDye()
    else
      askDoDye()
    end
  end
end
function HandleClicked_DyeReNew_SetShowUI()
  if Panel_Dye_ReNew:GetShow() then
    Panel_Dye_ReNew:SetShow(false)
    if true == _ContentsGroup_NewUI_Inventory_All then
      Panel_Window_Inventory_All:SetShow(false)
    else
      Panel_Window_Inventory:SetShow(false)
    end
  else
    Panel_Dye_ReNew:SetShow(true)
    if true == _ContentsGroup_NewUI_Inventory_All then
      Panel_Window_Inventory_All:SetShow(true)
    else
      Panel_Window_Inventory:SetShow(true)
    end
  end
end
function dyeCombine:resizeAndrepos(isShy)
  local addTabSize = 0
  if isShy then
    addTabSize = dyeCombine._ui.stc_radioGroup:GetSizeY()
  end
  dyeCombine._ui.stc_radioGroup:SetShow(isShy)
  Panel_Dye_ReNew:SetSize(Panel_Dye_ReNew:GetSizeX(), dyeCombine.basicPanelSizeY + addTabSize)
  dyeCombine._ui.stc_partTargetBG:SetPosX(dyeCombine._ui.stc_partTargetBG:GetPosX())
  dyeCombine._ui.stc_partTargetBG:SetPosY(dyeCombine.basicPartTargetBGPosY + addTabSize)
  dyeCombine._ui.txt_ampuleTargetTitle:SetPosX(dyeCombine._ui.txt_ampuleTargetTitle:GetPosX())
  dyeCombine._ui.txt_ampuleTargetTitle:SetPosY(dyeCombine.basicAmpluleTitlePosY + addTabSize)
  dyeCombine._ui.stc_ampluleTargetBG:SetPosX(dyeCombine._ui.stc_ampluleTargetBG:GetPosX())
  dyeCombine._ui.stc_ampluleTargetBG:SetPosY(dyeCombine.basicAmpluleBGPosY + addTabSize)
  dyeCombine._ui.stc_buttonGroup:ComputePos()
  dyeCombine._ui.txt_endurance:ComputePos()
  dyeCombine._ui.slider_endurance:ComputePos()
  dyeCombine._ui.btn_doDye:ComputePos()
end
function PaGlobal_DyeReNew_IsSelectedEquipSlot()
  local self = FGlobal_DyeReNew_GetInstance()
  if nil == self._selectedDyePart then
    return false
  end
  for index, value in pairs(self._selectedDyePart) do
    if true == self._selectedDyePart[index] then
      return true
    end
  end
  return false
end
registerEvent("FromClient_luaLoadComplete", "PaGlobal_DyeReNew_ButtonHandler_Init")
