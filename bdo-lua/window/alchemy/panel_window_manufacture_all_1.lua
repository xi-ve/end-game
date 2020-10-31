function PaGlobal_Manufacture_All:initialize()
  if nil == Panel_Window_Manufacture_All then
    return
  end
  if true == PaGlobal_Manufacture_All._initialize then
    return
  end
  PaGlobal_Manufacture_All._ui.stc_titleBG = UI.getChildControl(Panel_Window_Manufacture_All, "Static_TitleBG")
  PaGlobal_Manufacture_All._ui.btn_question = UI.getChildControl(PaGlobal_Manufacture_All._ui.stc_titleBG, "Button_Question")
  PaGlobal_Manufacture_All._ui.btn_close = UI.getChildControl(PaGlobal_Manufacture_All._ui.stc_titleBG, "Button_Close")
  PaGlobal_Manufacture_All._ui.stc_radioButtonGroup = UI.getChildControl(Panel_Window_Manufacture_All, "Static_RadioButtonGroup")
  PaGlobal_Manufacture_All._ui.stc_decoLine = UI.getChildControl(PaGlobal_Manufacture_All._ui.stc_radioButtonGroup, "Static_DecoLine")
  PaGlobal_Manufacture_All._ui.stc_selectLine = UI.getChildControl(PaGlobal_Manufacture_All._ui.stc_decoLine, "Static_SelectLine")
  PaGlobal_Manufacture_All._ui.stc_keyguideLB = UI.getChildControl(PaGlobal_Manufacture_All._ui.stc_radioButtonGroup, "Static_KeyGuide_Left_Console")
  PaGlobal_Manufacture_All._ui.stc_keyguideRB = UI.getChildControl(PaGlobal_Manufacture_All._ui.stc_radioButtonGroup, "Static_KeyGuide_Right_Console")
  PaGlobal_Manufacture_All._ui.stc_circle = UI.getChildControl(Panel_Window_Manufacture_All, "Static_Circle")
  PaGlobal_Manufacture_All._ui.txt_lifeStatTitle = UI.getChildControl(PaGlobal_Manufacture_All._ui.stc_circle, "StaticText_LifeStatTitle")
  PaGlobal_Manufacture_All._ui.txt_lifeStatValue = UI.getChildControl(PaGlobal_Manufacture_All._ui.stc_circle, "StaticText_LifeStat_Value")
  for ii = 0, PaGlobal_Manufacture_All._slotMaxCount - 1 do
    PaGlobal_Manufacture_All._ui._pointList[ii] = UI.getChildControl(PaGlobal_Manufacture_All._ui.stc_circle, "Static_Point_" .. ii + 1)
    PaGlobal_Manufacture_All._ui._pointList[ii]:SetShow(false)
  end
  for index = 0, PaGlobal_Manufacture_All._slotMaxCount - 1 do
    local createdSlot = {}
    SlotItem.new(createdSlot, "ItemIconSlot" .. index, 0, PaGlobal_Manufacture_All._ui._pointList[index], PaGlobal_Manufacture_All._slotConfig)
    createdSlot:createChild()
    createdSlot.iconBG = PaGlobal_Manufacture_All._ui._pointList[index]
    createdSlot.icon:SetPosX(3)
    createdSlot.icon:SetPosY(3)
    createdSlot.icon:SetIgnore(true)
    createdSlot.iconBG:addInputEvent("Mouse_RUp", "HandleEventRUp_Manufacture_All_ClearMaterial(" .. index .. ")")
    PaGlobal_Manufacture_All._ui._slotList[index] = createdSlot
  end
  PaGlobal_Manufacture_All._ui.stc_leftBG = UI.getChildControl(Panel_Window_Manufacture_All, "Static_LeftBG")
  PaGlobal_Manufacture_All._ui.chk_identicalItem = UI.getChildControl(PaGlobal_Manufacture_All._ui.stc_leftBG, "CheckButton_All")
  PaGlobal_Manufacture_All._ui.txt_manufactureName = UI.getChildControl(PaGlobal_Manufacture_All._ui.stc_leftBG, "StaticText_ManufactureName")
  PaGlobal_Manufacture_All._ui.txt_needKnowledge = UI.getChildControl(PaGlobal_Manufacture_All._ui.stc_leftBG, "StaticText_NeedKnowledge")
  PaGlobal_Manufacture_All._ui.btn_craftingNote = UI.getChildControl(PaGlobal_Manufacture_All._ui.stc_leftBG, "Button_Note")
  PaGlobal_Manufacture_All._ui.btn_manufacture = UI.getChildControl(PaGlobal_Manufacture_All._ui.stc_leftBG, "Button_Manufacture")
  PaGlobal_Manufacture_All._ui.btn_massManufacture = UI.getChildControl(PaGlobal_Manufacture_All._ui.stc_leftBG, "Button_MassManufacture")
  PaGlobal_Manufacture_All._ui.stc_listBG = UI.getChildControl(Panel_Window_Manufacture_All, "Static_FrameBG")
  PaGlobal_Manufacture_All._ui.txt_knowledgeCount = UI.getChildControl(PaGlobal_Manufacture_All._ui.stc_listBG, "StaticText_KnowledgeCount")
  PaGlobal_Manufacture_All._ui.list2_knowledgeList = UI.getChildControl(PaGlobal_Manufacture_All._ui.stc_listBG, "List2_Manufacture")
  PaGlobal_Manufacture_All._ui.txt_noList = UI.getChildControl(PaGlobal_Manufacture_All._ui.list2_knowledgeList, "StaticText_DefaultMSG1")
  PaGlobal_Manufacture_All._ui.stc_knowledgeDetailBG = UI.getChildControl(Panel_Window_Manufacture_All, "Static_KnowledgeDetailBG")
  PaGlobal_Manufacture_All._ui.frame_knowledgeDesc = UI.getChildControl(PaGlobal_Manufacture_All._ui.stc_knowledgeDetailBG, "Frame_ManufactureDesc")
  local frameContent = PaGlobal_Manufacture_All._ui.frame_knowledgeDesc:GetFrameContent()
  PaGlobal_Manufacture_All._ui.txt_knowledgeDesc = UI.getChildControl(frameContent, "StaticText_KnowledgeDesc")
  PaGlobal_Manufacture_All._ui.scroll_vertical = UI.getChildControl(PaGlobal_Manufacture_All._ui.frame_knowledgeDesc, "Frame_1_VerticalScroll")
  PaGlobal_Manufacture_All._ui.stc_keyGuideBg = UI.getChildControl(Panel_Window_Manufacture_All, "Static_KeyGuide_Console")
  PaGlobal_Manufacture_All._ui.stc_iconB = UI.getChildControl(PaGlobal_Manufacture_All._ui.stc_keyGuideBg, "StaticText_Close")
  PaGlobal_Manufacture_All._ui.stc_iconA = UI.getChildControl(PaGlobal_Manufacture_All._ui.stc_keyGuideBg, "StaticText_InventoryOpen")
  PaGlobal_Manufacture_All._ui.stc_iconX = UI.getChildControl(PaGlobal_Manufacture_All._ui.stc_keyGuideBg, "StaticText_ViewKnowledge")
  PaGlobal_Manufacture_All._isConsole = _ContentsGroup_UsePadSnapping
  PaGlobal_Manufacture_All:radioButtonInit()
  PaGlobal_Manufacture_All:setBasicSetting()
  PaGlobal_Manufacture_All:setConsoleUI()
  PaGlobal_Manufacture_All:registEventHandler()
  PaGlobal_Manufacture_All:validate()
  PaGlobal_Manufacture_All._initialize = true
end
function PaGlobal_Manufacture_All:radioButtonInit()
  local maxActionBtn = 0
  for ii = 0, PaGlobal_Manufacture_All._manufactureMaxCount - 1 do
    local manufactureData = {}
    manufactureData._actionName = PaGlobal_Manufacture_All.MANUFACTURE_INFO[ii].actionName
    manufactureData._radioBtn = UI.getChildControl(PaGlobal_Manufacture_All._ui.stc_radioButtonGroup, "RadioButton_Action" .. ii + 1)
    manufactureData._radioBtn:addInputEvent("Mouse_LUp", "PaGlobal_Manufacture_All_SelectManufactureAction(" .. ii .. ", true)")
    manufactureData._enable = true
    maxActionBtn = maxActionBtn + 1
    if PaGlobal_Manufacture_All.MANUFACTURE_TYPE.GUILDMANUFACTURE == ii then
      if false == _ContentsGroup_GuildManufacture then
        manufactureData._radioBtn:SetShow(false)
        manufactureData._enable = false
        maxActionBtn = maxActionBtn - 1
      end
    elseif PaGlobal_Manufacture_All.MANUFACTURE_TYPE.CRAFT == ii then
      local enableCraft = ToClient_IsContentsGroupOpen("285")
      if false == enableCraft then
        manufactureData._radioBtn:SetShow(false)
        manufactureData._enable = false
        maxActionBtn = maxActionBtn - 1
      end
    end
    PaGlobal_Manufacture_All._listAction[ii] = manufactureData
  end
  PaGlobal_Manufacture_All._maxActionBtn = maxActionBtn
end
function PaGlobal_Manufacture_All:setBasicSetting()
  Panel_Window_Manufacture_All:SetPosX((getScreenSizeX() - Panel_Window_Manufacture_All:GetSizeX()) / 2)
  Panel_Window_Manufacture_All:SetPosY((getScreenSizeY() - Panel_Window_Manufacture_All:GetSizeY()) / 2)
  Panel_Window_Manufacture_All:setGlassBackground(true)
  PaGlobal_Manufacture_All._usingInstallationType = CppEnums.InstallationType.TypeCount
  PaGlobal_Manufacture_All._ui.txt_needKnowledge:SetShow(false)
  PaGlobal_Manufacture_All._ui.txt_needKnowledge:SetTextMode(__eTextMode_AutoWrap)
  PaGlobal_Manufacture_All._ui.txt_needKnowledge:SetText(PaGlobal_Manufacture_All._ui.txt_needKnowledge:GetText())
  PaGlobal_Manufacture_All._ui.chk_identicalItem:SetShow(false)
  PaGlobal_Manufacture_All._ui.chk_identicalItem:SetCheck(false)
  PaGlobal_Manufacture_All._ui.chk_identicalItem:SetEnableArea(0, 0, PaGlobal_Manufacture_All._ui.chk_identicalItem:GetSizeX() + PaGlobal_Manufacture_All._ui.chk_identicalItem:GetTextSizeX() + 10, PaGlobal_Manufacture_All._ui.chk_identicalItem:GetSizeY())
  PaGlobal_Manufacture_All._ui.list2_knowledgeList:changeAnimationSpeed(10)
  PaGlobal_Manufacture_All._ui.list2_knowledgeList:registEvent(__ePAUIList2EventType_LuaChangeContent, "PaGlobal_Manufacture_All_KnowledgeList_ControlCreate")
  PaGlobal_Manufacture_All._ui.list2_knowledgeList:createChildContent(__ePAUIList2ElementManagerType_List)
  PaGlobal_Manufacture_All._ui.txt_noList:SetTextMode(__eTextMode_AutoWrap)
  PaGlobal_Manufacture_All._ui.txt_noList:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_MANUFACTURE_DEFAULT_MSG_1"))
  PaGlobal_Manufacture_All._ui.txt_noList:SetShow(false)
  PaGlobal_Manufacture_All._ui.btn_manufacture:SetText(PAGetString(Defines.StringSheet_GAME, "ALCHEMY_MANUFACTURE_BTN_MANUFACTURE"))
  if isGameTypeKR2() then
    PaGlobal_Manufacture_All._ui.btn_craftingNote:SetShow(false)
  end
end
function PaGlobal_Manufacture_All:setConsoleUI()
  if nil == Panel_Window_Manufacture_All then
    return
  end
  if true == PaGlobal_Manufacture_All._isConsole then
    PaGlobal_Manufacture_All._ui.btn_question:SetShow(false)
    PaGlobal_Manufacture_All._ui.btn_close:SetShow(false)
    PaGlobal_Manufacture_All._ui.stc_keyguideLB:SetShow(true)
    PaGlobal_Manufacture_All._ui.stc_keyguideRB:SetShow(true)
    PaGlobal_Manufacture_All._ui.btn_craftingNote:SetShow(false)
    PaGlobal_Manufacture_All._ui.btn_manufacture:SetShow(false)
    PaGlobal_Manufacture_All._ui.btn_massManufacture:SetShow(false)
    PaGlobal_Manufacture_All._ui.stc_knowledgeDetailBG:SetSpanSize(PaGlobal_Manufacture_All._ui.stc_knowledgeDetailBG:GetSpanSize().x, 10)
    PaGlobal_Manufacture_All._ui.stc_keyGuideBg:SetShow(true)
    PaGlobal_Manufacture_All._ui.stc_keyGuideBg:SetPosY(Panel_Window_Manufacture_All:GetSizeY())
  else
    PaGlobal_Manufacture_All._ui.btn_question:SetShow(true)
    PaGlobal_Manufacture_All._ui.btn_close:SetShow(true)
    PaGlobal_Manufacture_All._ui.stc_keyguideLB:SetShow(false)
    PaGlobal_Manufacture_All._ui.stc_keyguideRB:SetShow(false)
    PaGlobal_Manufacture_All._ui.stc_keyGuideBg:SetShow(false)
  end
end
function PaGlobal_Manufacture_All:registEventHandler()
  if nil == Panel_Window_Manufacture_All then
    return
  end
  Panel_Window_Manufacture_All:RegisterShowEventFunc(true, "PaGlobalFunc_Manufacture_All_ShowAni()")
  Panel_Window_Manufacture_All:RegisterShowEventFunc(false, "PaGlobalFunc_Manufacture_All_HideAni()")
  PaGlobal_Manufacture_All._ui.chk_identicalItem:addInputEvent("Mouse_LUp", "HandleEventLUp_Manufacture_All_CheckNoneStackItem()")
  registerEvent("Event_ManufactureUpdateSlot", "PaGlobal_Manufacture_All_ManufactureReOpen")
  registerEvent("EventShowManufactureWindow", "PaGlobalFunc_Manufacture_All_ToggleWindow")
  registerEvent("EventEquipmentUpdate", "FromClient_Manufacture_All_EventEquipmentUpdate")
  registerEvent("onScreenResize", "FromClient_Manufacture_All_OnScreenResize")
  if true == PaGlobal_Manufacture_All._isConsole then
    Panel_Window_Manufacture_All:registerPadEvent(__eConsoleUIPadEvent_Up_A, "PaGlobal_Manufacture_All_InventoryOpen()")
  else
    PaGlobal_Manufacture_All._ui.btn_question:addInputEvent("Mouse_LUp", "Panel_WebHelper_ShowToggle( \"PanelManufacture\" )")
    PaGlobal_Util_RegistHelpTooltipEvent(PaGlobal_Manufacture_All._ui.btn_question, "\"PanelManufacture\"")
    PaGlobal_Manufacture_All._ui.btn_close:addInputEvent("Mouse_LUp", "PaGlobalFunc_Manufacture_All_Close()")
    for i = 0, PaGlobal_Manufacture_All._maxActionBtn - 1 do
      PaGlobal_Manufacture_All._listAction[i]._radioBtn:addInputEvent("Mouse_On", "HandleEventOnOut_Manufacture_All_IconTooltip( true, " .. i .. " )")
      PaGlobal_Manufacture_All._listAction[i]._radioBtn:addInputEvent("Mouse_Out", "HandleEventOnOut_Manufacture_All_IconTooltip( false )")
    end
    PaGlobal_Manufacture_All._ui.btn_craftingNote:addInputEvent("Mouse_LUp", "HandleEventLUp_Manufacture_All_OpenCraftingNote()")
    PaGlobal_Manufacture_All._ui.btn_craftingNote:addInputEvent("Mouse_On", "HandleEventOn_Manufacture_All_ButtonMouseOverSound()")
    PaGlobal_Manufacture_All._ui.btn_manufacture:addInputEvent("Mouse_LUp", "HandleEventLUp_Manufacture_All_RepeatAction(false)")
    PaGlobal_Manufacture_All._ui.btn_manufacture:addInputEvent("Mouse_On", "HandleEventOn_Manufacture_All_ButtonMouseOverSound()")
    PaGlobal_Manufacture_All._ui.btn_massManufacture:addInputEvent("Mouse_LUp", "HandleEventLUp_Manufacture_All_RepeatAction(true)")
    PaGlobal_Manufacture_All._ui.btn_massManufacture:addInputEvent("Mouse_On", "HandleEventOn_Manufacture_All_ButtonMouseOverSound()")
  end
end
function PaGlobal_Manufacture_All:checkOpenPanel()
  if true == _ContentsGroup_NewUI_AlchemyFigureHead_All then
    if Panel_AlchemyFigureHead_All:GetShow() then
      PaGlobal_AlchemyFigureHead_All_Close()
    end
  elseif Panel_AlchemyFigureHead:GetShow() then
    FGlobal_AlchemyFigureHead_Close()
  end
  if true == _ContentsGroup_NewUI_AlchemyStone_All then
    if nil ~= Panel_Window_AlchemyStone_All and true == Panel_Window_AlchemyStone_All:GetShow() then
      PaGlobalFunc_AlchemyStone_All_Close()
    end
  elseif nil ~= Panel_AlchemyStone and true == Panel_AlchemyStone:GetShow() then
    FGlobal_AlchemyStone_Close()
  end
  if false == _ContentsGroup_UsePadSnapping then
    if _ContentsGroup_NewUI_Dye_All then
      if Panel_Window_Palette_All:GetShow() then
        PaGlobal_Palette_All_Close()
      end
    elseif Panel_DyePalette:GetShow() then
      FGlobal_DyePalette_Close()
    end
  elseif PaGlobalFunc_DyeingPalette_GetShow() then
    PaGlobalFunc_DyeingPalette_Close()
  end
  if false == _ContentsGroup_RenewUI_InventoryEquip then
    if true == _ContentsGroup_NewUI_Equipment_All then
      if Panel_Window_Equipment_All:GetShow() then
        PaGlobalFunc_Equipment_All_Close(false)
      end
    elseif Panel_Equipment:GetShow() then
      EquipmentWindow_Close()
    end
  end
  local isInvenOpen = false
  if true == _ContentsGroup_NewUI_Inventory_All then
    isInvenOpen = Panel_Window_Inventory_All:GetShow()
  else
    isInvenOpen = Panel_Window_Inventory:GetShow()
  end
  if false == _ContentsGroup_RenewUI_InventoryEquip and true == isInvenOpen then
    InventoryWindow_Close()
  end
  if true == Panel_Window_ItemMarket_RegistItem:GetShow() then
    FGlobal_ItemMarketRegistItem_Close()
  end
  if true == _ContentsGroup_NewUI_ClothInventory_All or true == _ContentsGroup_RenewUI_InventoryEquip then
    PaGlobalFunc_ClothInventory_All_Close()
  else
    ClothInventory_Close()
  end
end
function PaGlobal_Manufacture_All:prepareOpen()
  if nil == Panel_Window_Manufacture_All then
    return
  end
  if true == _ContentsGroup_isFairy and true == _ContentsGroup_NewUI_Fairy_All and (true == PaGlobal_FairyInfo_IsGetShow() or true == PaGlobal_FairyChangeSkill_IsGetShow()) then
    return
  end
  PaGlobal_Manufacture_All._ui.btn_craftingNote:setRenderTexture(PaGlobal_Manufacture_All._ui.btn_craftingNote:getBaseTexture())
  PaGlobal_Manufacture_All._ui.btn_manufacture:setRenderTexture(PaGlobal_Manufacture_All._ui.btn_manufacture:getBaseTexture())
  PaGlobal_Manufacture_All._ui.btn_massManufacture:setRenderTexture(PaGlobal_Manufacture_All._ui.btn_massManufacture:getBaseTexture())
  PaGlobal_Manufacture_All:open()
end
function PaGlobal_Manufacture_All:open()
  if nil == Panel_Window_Manufacture_All then
    return
  end
  Panel_Window_Manufacture_All:SetShow(true)
end
function PaGlobal_Manufacture_All:prepareClose()
  if nil == Panel_Window_Manufacture_All then
    return
  end
  PaGlobal_Manufacture_All._ui.list2_knowledgeList:getElementManager():clearKey()
  PaGlobal_Manufacture_All._selectIndex = -1
  PaGlobal_Manufacture_All._isFromWarehouse = false
  Panel_Window_Manufacture_All:CloseUISubApp()
  Inventory_SetFunctor(nil, nil, nil, nil)
  if _ContentsGroup_NewUI_WareHouse_All then
    PaGlobal_Warehouse_All_SetFunctor(nil, nil)
    if nil ~= Panel_Window_Warehouse and false == Panel_Window_Warehouse:GetShow() then
      PaGlobalFunc_DialogMain_All_SubPanelSetShow(true)
    end
  else
    Warehouse_SetFunctor(nil, nil)
  end
  if true == PaGlobal_Manufacture_All._invenShow then
    if true == _ContentsGroup_NewUI_Equipment_All then
      PaGlobalFunc_Equipment_All_Open()
    else
      Panel_Equipment:SetShow(true)
    end
    if true == _ContentsGroup_NewUI_Inventory_All then
      Panel_Window_Inventory_All:SetShow(true)
    else
      Panel_Window_Inventory:SetShow(true)
    end
    PaGlobal_Manufacture_All._invenShow = false
  else
    if true == _ContentsGroup_NewUI_Equipment_All then
      PaGlobalFunc_Equipment_All_Close(false)
    else
      EquipmentWindow_Close()
    end
    InventoryWindow_Close()
    if true == _ContentsGroup_NewUI_ClothInventory_All or true == _ContentsGroup_RenewUI then
      PaGlobalFunc_ClothInventory_All_Close()
    else
      ClothInventory_Close()
    end
    HelpMessageQuestion_Out()
  end
  TooltipSimple_Hide()
  audioPostEvent_SystemUi(1, 25)
  PaGlobal_Manufacture_All:close()
end
function PaGlobal_Manufacture_All:close()
  if nil == Panel_Window_Manufacture_All then
    return
  end
  Panel_Window_Manufacture_All:SetShow(false, false)
end
function PaGlobal_Manufacture_All:validate()
  if nil == Panel_Window_Manufacture_All then
    return
  end
  PaGlobal_Manufacture_All._ui.stc_titleBG:isValidate()
  PaGlobal_Manufacture_All._ui.btn_question:isValidate()
  PaGlobal_Manufacture_All._ui.btn_close:isValidate()
  PaGlobal_Manufacture_All._ui.stc_radioButtonGroup:isValidate()
  PaGlobal_Manufacture_All._ui.stc_decoLine:isValidate()
  PaGlobal_Manufacture_All._ui.stc_selectLine:isValidate()
  PaGlobal_Manufacture_All._ui.stc_keyguideLB:isValidate()
  PaGlobal_Manufacture_All._ui.stc_keyguideRB:isValidate()
  PaGlobal_Manufacture_All._ui.stc_circle:isValidate()
  PaGlobal_Manufacture_All._ui.txt_lifeStatTitle:isValidate()
  PaGlobal_Manufacture_All._ui.txt_lifeStatValue:isValidate()
  PaGlobal_Manufacture_All._ui.chk_identicalItem:isValidate()
  PaGlobal_Manufacture_All._ui.txt_manufactureName:isValidate()
  PaGlobal_Manufacture_All._ui.stc_listBG:isValidate()
  PaGlobal_Manufacture_All._ui.txt_knowledgeCount:isValidate()
  PaGlobal_Manufacture_All._ui.list2_knowledgeList:isValidate()
  PaGlobal_Manufacture_All._ui.txt_noList:isValidate()
  PaGlobal_Manufacture_All._ui.stc_knowledgeDetailBG:isValidate()
  PaGlobal_Manufacture_All._ui.txt_knowledgeDesc:isValidate()
  PaGlobal_Manufacture_All._ui.btn_craftingNote:isValidate()
  PaGlobal_Manufacture_All._ui.btn_manufacture:isValidate()
  PaGlobal_Manufacture_All._ui.btn_massManufacture:isValidate()
end
