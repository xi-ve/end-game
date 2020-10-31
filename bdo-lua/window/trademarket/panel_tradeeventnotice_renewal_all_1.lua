function PaGlobal_TradeEventNotice_All:initialize()
  if true == PaGlobal_TradeEventNotice_All._initialize then
    return
  end
  PaGlobal_TradeEventNotice_All._isConsole = _ContentsGroup_UsePadSnapping
  PaGlobal_TradeEventNotice_All._ui._stc_TitleBG = UI.getChildControl(Panel_Window_TradeEventNotice_Renewal_All, "Static_TitleBG")
  PaGlobal_TradeEventNotice_All._ui._stcText_TitleIcon = UI.getChildControl(PaGlobal_TradeEventNotice_All._ui._stc_TitleBG, "StaticText_TitleIcon")
  PaGlobal_TradeEventNotice_All._ui._stc_BackImage = UI.getChildControl(PaGlobal_TradeEventNotice_All._ui._stc_TitleBG, "Static_BackImage")
  PaGlobal_TradeEventNotice_All._ui._btn_Close = UI.getChildControl(PaGlobal_TradeEventNotice_All._ui._stc_TitleBG, "Button_Close")
  PaGlobal_TradeEventNotice_All._ui._chk_PopUp = UI.getChildControl(PaGlobal_TradeEventNotice_All._ui._stc_TitleBG, "CheckButton_PopUp")
  PaGlobal_TradeEventNotice_All._ui._stcText_TradeEvent = UI.getChildControl(Panel_Window_TradeEventNotice_Renewal_All, "StaticText_TradeEvent")
  PaGlobal_TradeEventNotice_All._ui._btn_TradeEvent_Navi = UI.getChildControl(Panel_Window_TradeEventNotice_Renewal_All, "Button_TradeEvent_Navi")
  local btnNaviPosX = PaGlobal_TradeEventNotice_All._ui._stcText_TradeEvent:GetPosX() + PaGlobal_TradeEventNotice_All._ui._stcText_TradeEvent:GetTextSizeX() + 5
  PaGlobal_TradeEventNotice_All._ui._btn_TradeEvent_Navi:SetPosX(btnNaviPosX)
  PaGlobal_TradeEventNotice_All._ui._stc_TradeEventDescBG = UI.getChildControl(Panel_Window_TradeEventNotice_Renewal_All, "Static_TradeEventDescBG")
  PaGlobal_TradeEventNotice_All._ui._stcText_TradeEventDesc = UI.getChildControl(PaGlobal_TradeEventNotice_All._ui._stc_TradeEventDescBG, "StaticText_TradeEventDesc")
  PaGlobal_TradeEventNotice_All._ui._stc_TradeEventDown = UI.getChildControl(Panel_Window_TradeEventNotice_Renewal_All, "Static_TradeEventDown")
  PaGlobal_TradeEventNotice_All._ui._stc_ListBG = UI.getChildControl(PaGlobal_TradeEventNotice_All._ui._stc_TradeEventDown, "Static_ListBG")
  PaGlobal_TradeEventNotice_All._ui._rdo_ShowIcon = UI.getChildControl(PaGlobal_TradeEventNotice_All._ui._stc_TradeEventDown, "RadioButton_ShowIcon")
  PaGlobal_TradeEventNotice_All._ui._rdo_ShowName = UI.getChildControl(PaGlobal_TradeEventNotice_All._ui._stc_TradeEventDown, "RadioButton_ShowName")
  PaGlobal_TradeEventNotice_All._ui._stcText_TerritorySupply = UI.getChildControl(PaGlobal_TradeEventNotice_All._ui._stc_TradeEventDown, "StaticText_TerritorySupply")
  PaGlobal_TradeEventNotice_All._ui._stc_TerritorySupplyBG1 = UI.getChildControl(PaGlobal_TradeEventNotice_All._ui._stc_TradeEventDown, "Static_TerritorySupplyBG1")
  PaGlobal_TradeEventNotice_All._ui._stcText_TerritorySupply_Town = UI.getChildControl(PaGlobal_TradeEventNotice_All._ui._stc_TerritorySupplyBG1, "StaticText_TerritorySupply_Town")
  PaGlobal_TradeEventNotice_All._ui._stc_ItemSlotBG = UI.getChildControl(PaGlobal_TradeEventNotice_All._ui._stc_TerritorySupplyBG1, "Static_ItemSlotBG")
  PaGlobal_TradeEventNotice_All._ui._stc_ItemSlot = UI.getChildControl(PaGlobal_TradeEventNotice_All._ui._stc_ItemSlotBG, "Static_ItemSlot")
  PaGlobal_TradeEventNotice_All._ui._stcText_TerritorySupplyAlert = UI.getChildControl(PaGlobal_TradeEventNotice_All._ui._stc_TradeEventDown, "StaticText_TerritorySupplyAlert")
  PaGlobal_TradeEventNotice_All._ui._stcText_TerritorySupply_ItemName = UI.getChildControl(PaGlobal_TradeEventNotice_All._ui._stc_TerritorySupplyBG1, "StaticText_TerritorySupply_ItemName")
  PaGlobal_TradeEventNotice_All._ui._btn_Navi = UI.getChildControl(PaGlobal_TradeEventNotice_All._ui._stc_TerritorySupplyBG1, "Button_Navi")
  PaGlobal_TradeEventNotice_All._ui._stc_ConsoleGuide = UI.getChildControl(Panel_Window_TradeEventNotice_Renewal_All, "Static_ConsoleGuide")
  PaGlobal_TradeEventNotice_All._ui._stcText_Detail = UI.getChildControl(PaGlobal_TradeEventNotice_All._ui._stc_ConsoleGuide, "StaticText_Detail")
  PaGlobal_TradeEventNotice_All._ui._stcText_Navi = UI.getChildControl(PaGlobal_TradeEventNotice_All._ui._stc_ConsoleGuide, "StaticText_Navi")
  PaGlobal_TradeEventNotice_All._ui._stcText_Close = UI.getChildControl(PaGlobal_TradeEventNotice_All._ui._stc_ConsoleGuide, "StaticText_Close")
  PaGlobal_TradeEventNotice_All._keyGuide = {
    PaGlobal_TradeEventNotice_All._ui._stcText_Detail,
    PaGlobal_TradeEventNotice_All._ui._stcText_Navi,
    PaGlobal_TradeEventNotice_All._ui._stcText_Close
  }
  PaGlobal_TradeEventNotice_All._ui._rdo_ShowIcon:SetCheck(true)
  PaGlobal_TradeEventNotice_All._ui._rdo_ShowName:SetCheck(false)
  PaGlobal_TradeEventNotice_All._ui._stc_TerritorySupplyBG1:SetShow(false)
  PaGlobal_TradeEventNotice_All._ui._chk_PopUp:SetShow(ToClient_IsContentsGroupOpen("240"))
  PaGlobal_TradeEventNotice_All._ui._stcText_TradeEventDesc:SetTextMode(__eTextMode_AutoWrap)
  PaGlobal_TradeEventNotice_All._ui._stcText_TerritorySupply_ItemName:SetSize((PaGlobal_TradeEventNotice_All._ui._stc_TerritorySupplyBG1:GetSizeX() - 40) / PaGlobal_TradeEventNotice_All._nameColumnNum, PaGlobal_TradeEventNotice_All._ui._stcText_TerritorySupply_ItemName:GetSizeY())
  PaGlobal_TradeEventNotice_All._ui._stcText_TerritorySupply_ItemName:setLineCountByLimitAutoWrap(1)
  PaGlobal_TradeEventNotice_All._ui._stcText_TerritorySupply_ItemName:SetTextMode(__eTextMode_Limit_AutoWrap)
  PaGlobal_TradeEventNotice_All._supplyNpcRegionKey = {
    [PaGlobal_TradeEventNotice_All._ETerritory._balenos] = 5,
    [PaGlobal_TradeEventNotice_All._ETerritory._serendia] = 32,
    [PaGlobal_TradeEventNotice_All._ETerritory._calpheon] = 310,
    [PaGlobal_TradeEventNotice_All._ETerritory._media] = 202,
    [PaGlobal_TradeEventNotice_All._ETerritory._valencia] = 229,
    [PaGlobal_TradeEventNotice_All._ETerritory._margoria] = 821,
    [PaGlobal_TradeEventNotice_All._ETerritory._kamasylvia] = 735,
    [PaGlobal_TradeEventNotice_All._ETerritory._drigan] = 873
  }
  PaGlobal_TradeEventNotice_All._territoryName = {
    [PaGlobal_TradeEventNotice_All._ETerritory._balenos] = PAGetString(Defines.StringSheet_GAME, "LUA_TRADEEVENTINFO_1"),
    [PaGlobal_TradeEventNotice_All._ETerritory._serendia] = PAGetString(Defines.StringSheet_GAME, "LUA_TRADEEVENTINFO_2"),
    [PaGlobal_TradeEventNotice_All._ETerritory._calpheon] = PAGetString(Defines.StringSheet_GAME, "LUA_TRADEEVENTINFO_3"),
    [PaGlobal_TradeEventNotice_All._ETerritory._media] = PAGetString(Defines.StringSheet_GAME, "LUA_TRADEEVENTINFO_4"),
    [PaGlobal_TradeEventNotice_All._ETerritory._valencia] = PAGetString(Defines.StringSheet_GAME, "LUA_TRADEEVENTINFO_5"),
    [PaGlobal_TradeEventNotice_All._ETerritory._margoria] = PAGetString(Defines.StringSheet_GAME, "LUA_TRADEEVENTINFO_ROTPORT"),
    [PaGlobal_TradeEventNotice_All._ETerritory._kamasylvia] = PAGetString(Defines.StringSheet_GAME, "LUA_TRADEEVENTINFO_KAMASYLVIA"),
    [PaGlobal_TradeEventNotice_All._ETerritory._drigan] = PAGetString(Defines.StringSheet_GAME, "LUA_TRADEEVENTINFO_DRIGAN")
  }
  if false == PaGlobal_TradeEventNotice_All._isConsole then
    PaGlobal_TradeEventNotice_All._ui._btn_TradeEvent_Navi:SetShow(true)
    PaGlobal_TradeEventNotice_All._ui._btn_Navi:SetShow(true)
    PaGlobal_TradeEventNotice_All._ui._rdo_ShowIcon:SetShow(true)
    PaGlobal_TradeEventNotice_All._ui._rdo_ShowName:SetShow(true)
    PaGlobal_TradeEventNotice_All._ui._btn_Close:SetShow(true)
    PaGlobal_TradeEventNotice_All._ui._stc_ConsoleGuide:SetShow(false)
    PaGlobal_TradeEventNotice_All._ui._stcText_Detail:SetShow(false)
    PaGlobal_TradeEventNotice_All._ui._stcText_Navi:SetShow(false)
    PaGlobal_TradeEventNotice_All._ui._stcText_Close:SetShow(false)
    PaGlobal_TradeEventNotice_All._ui._stc_TradeEventDescBG:SetIgnore(true)
    PaGlobal_TradeEventNotice_All._ui._stcText_TradeEventDesc:SetIgnore(true)
    PaGlobal_TradeEventNotice_All._ui._stc_TerritorySupplyBG1:SetIgnore(true)
    PaGlobal_TradeEventNotice_All._ui._stc_ItemSlotBG:SetIgnore(true)
  else
    PaGlobal_TradeEventNotice_All._ui._btn_TradeEvent_Navi:SetShow(false)
    PaGlobal_TradeEventNotice_All._ui._btn_Navi:SetShow(false)
    PaGlobal_TradeEventNotice_All._ui._rdo_ShowIcon:SetShow(false)
    PaGlobal_TradeEventNotice_All._ui._rdo_ShowName:SetShow(false)
    PaGlobal_TradeEventNotice_All._ui._btn_Close:SetShow(false)
    PaGlobal_TradeEventNotice_All._ui._stc_ConsoleGuide:SetShow(true)
    PaGlobal_TradeEventNotice_All._ui._stcText_Detail:SetShow(true)
    PaGlobal_TradeEventNotice_All._ui._stcText_Navi:SetShow(true)
    PaGlobal_TradeEventNotice_All._ui._stcText_Close:SetShow(true)
    PaGlobal_TradeEventNotice_All._ui._stc_TradeEventDescBG:SetIgnore(false)
    PaGlobal_TradeEventNotice_All._ui._stcText_TradeEventDesc:SetIgnore(false)
    PaGlobal_TradeEventNotice_All._ui._stc_TerritorySupplyBG1:SetIgnore(false)
    PaGlobal_TradeEventNotice_All._ui._stc_ItemSlotBG:SetIgnore(false)
  end
  PaGlobal_TradeEventNotice_All._prevTab = PaGlobal_TradeEventNotice_All._ETabState._icon
  PaGlobal_TradeEventNotice_All:SetTerritoryCount()
  PaGlobal_TradeEventNotice_All:registEventHandler()
  PaGlobal_TradeEventNotice_All:validate()
  PaGlobal_TradeEventNotice_All:InitializeCreateUI()
  if true == PaGlobal_TradeEventNotice_All._isConsole then
    PaGlobal_TradeEventNotice_All:keyAlign()
  end
  PaGlobal_TradeEventNotice_All._initialize = true
end
function PaGlobal_TradeEventNotice_All:InitializeCreateUI()
  if nil == Panel_Window_TradeEventNotice_Renewal_All then
    return
  end
  local lineNum
  PaGlobal_TradeEventNotice_All._lineGapY = PaGlobal_TradeEventNotice_All._ui._stc_TerritorySupplyBG1:GetSizeY() + 5
  local itemGapX = PaGlobal_TradeEventNotice_All._ui._stc_ItemSlotBG:GetSizeX() + 10
  local nameGapY = PaGlobal_TradeEventNotice_All._ui._stcText_TerritorySupply_ItemName:GetTextSizeY() - 5
  for terrIndex = 0, PaGlobal_TradeEventNotice_All._territoryCount - 1 do
    PaGlobal_TradeEventNotice_All._supplyItemKeyList[terrIndex] = {}
    PaGlobal_TradeEventNotice_All._ui._staticSupplyBGList[terrIndex] = UI.createControl(__ePAUIControl_Static, PaGlobal_TradeEventNotice_All._ui._stc_TradeEventDown, "Static_TerritorySupplyTownBG_" .. terrIndex)
    PaGlobal_TradeEventNotice_All._ui._staticTextSupplyTownList[terrIndex] = UI.createControl(__ePAUIControl_StaticText, PaGlobal_TradeEventNotice_All._ui._staticSupplyBGList[terrIndex], "StaticText_TerritorySupplyTown_" .. terrIndex)
    CopyBaseProperty(PaGlobal_TradeEventNotice_All._ui._stcText_TerritorySupply_Town, PaGlobal_TradeEventNotice_All._ui._staticTextSupplyTownList[terrIndex])
    CopyBaseProperty(PaGlobal_TradeEventNotice_All._ui._stc_TerritorySupplyBG1, PaGlobal_TradeEventNotice_All._ui._staticSupplyBGList[terrIndex])
    local territoryName = PaGlobal_TradeEventNotice_All._territoryName[terrIndex]
    local npcName = PaGlobal_TradeEventNotice_All:GetTerritorySupplyNpcName(terrIndex)
    PaGlobal_TradeEventNotice_All._ui._stcText_TerritorySupply_Town:SetTextMode(__eTextMode_None)
    PaGlobal_TradeEventNotice_All._ui._staticTextSupplyTownList[terrIndex]:SetText(territoryName .. npcName)
    PaGlobal_TradeEventNotice_All._ui._staticTextSupplyTownList[terrIndex]:SetPosY(PaGlobal_TradeEventNotice_All._ui._staticTextSupplyTownList[terrIndex]:GetPosY() + 2)
    if false == PaGlobal_TradeEventNotice_All._isConsole then
      local textSizeX = PaGlobal_TradeEventNotice_All._ui._staticTextSupplyTownList[terrIndex]:GetTextSizeX()
      if textSizeX > PaGlobal_TradeEventNotice_All._ui._staticTextSupplyTownList[terrIndex]:GetSizeX() then
        PaGlobal_TradeEventNotice_All._ui._staticTextSupplyTownList[terrIndex]:SetTextMode(__eTextMode_LimitText)
        PaGlobal_TradeEventNotice_All._ui._staticTextSupplyTownList[terrIndex]:SetText(territoryName .. npcName)
        PaGlobal_TradeEventNotice_All._ui._staticTextSupplyTownList[terrIndex]:addInputEvent("Mouse_On", "HandleEventOn_TradeEventNotice_Renewal_All_ShowTooltipName(" .. terrIndex .. ")")
        PaGlobal_TradeEventNotice_All._ui._staticTextSupplyTownList[terrIndex]:addInputEvent("Mouse_Out", "TooltipSimple_Hide()")
      end
      PaGlobal_TradeEventNotice_All._ui._btnSupplyNaviList[terrIndex] = UI.createControl(__ePAUIControl_Button, PaGlobal_TradeEventNotice_All._ui._staticSupplyBGList[terrIndex], "Button_TerritorySupplyNavi_" .. terrIndex)
      CopyBaseProperty(PaGlobal_TradeEventNotice_All._ui._btn_TradeEvent_Navi, PaGlobal_TradeEventNotice_All._ui._btnSupplyNaviList[terrIndex])
      PaGlobal_TradeEventNotice_All._ui._btnSupplyNaviList[terrIndex]:SetPosX(PaGlobal_TradeEventNotice_All._ui._staticTextSupplyTownList[terrIndex]:GetPosX() + PaGlobal_TradeEventNotice_All._ui._staticTextSupplyTownList[terrIndex]:GetTextSizeX() + 5)
      PaGlobal_TradeEventNotice_All._ui._btnSupplyNaviList[terrIndex]:SetPosY(PaGlobal_TradeEventNotice_All._ui._staticTextSupplyTownList[terrIndex]:GetPosY())
      PaGlobal_TradeEventNotice_All._ui._btnSupplyNaviList[terrIndex]:addInputEvent("Mouse_LUp", "HandleEventLUp_TradeEventNotice_Renewal_All_SupplyNPCNaviStart(" .. terrIndex .. ")")
    else
      PaGlobal_TradeEventNotice_All._ui._staticTextSupplyTownList[terrIndex]:SetText(territoryName)
    end
    local addPosX = PaGlobal_TradeEventNotice_All._ui._stc_TerritorySupplyBG1:GetSizeX() + 5
    addPosX = terrIndex % PaGlobal_TradeEventNotice_All._columnNum * addPosX
    lineNum = math.floor(terrIndex / PaGlobal_TradeEventNotice_All._columnNum)
    PaGlobal_TradeEventNotice_All._ui._staticSupplyBGList[terrIndex]:SetPosX(PaGlobal_TradeEventNotice_All._ui._staticSupplyBGList[terrIndex]:GetPosX() + addPosX)
    PaGlobal_TradeEventNotice_All._ui._staticSupplyBGList[terrIndex]:SetPosY(PaGlobal_TradeEventNotice_All._ui._staticSupplyBGList[terrIndex]:GetPosY() + PaGlobal_TradeEventNotice_All._lineGapY * lineNum)
    PaGlobal_TradeEventNotice_All._ui._staticSupplyItemBGList[terrIndex] = {}
    PaGlobal_TradeEventNotice_All._ui._staticTextSupplyItemNameList[terrIndex] = {}
    PaGlobal_TradeEventNotice_All._ui._staticSupplyItemList[terrIndex] = {}
    for itemIndex = 0, PaGlobal_TradeEventNotice_All._maxItemCount - 1 do
      PaGlobal_TradeEventNotice_All._ui._staticSupplyItemBGList[terrIndex][itemIndex] = UI.createControl(__ePAUIControl_Static, PaGlobal_TradeEventNotice_All._ui._staticSupplyBGList[terrIndex], "Static_TerritorySupplyItemBG_" .. terrIndex .. "_" .. itemIndex)
      PaGlobal_TradeEventNotice_All._ui._staticTextSupplyItemNameList[terrIndex][itemIndex] = UI.createControl(__ePAUIControl_StaticText, PaGlobal_TradeEventNotice_All._ui._staticSupplyBGList[terrIndex], "Static_TerritorySupplyItemName_" .. terrIndex .. "_" .. itemIndex)
      local itemSlot = UI.createControl(__ePAUIControl_Static, PaGlobal_TradeEventNotice_All._ui._staticSupplyItemBGList[terrIndex][itemIndex], "Static_TerritorySupplyItem_" .. terrIndex .. "_" .. itemIndex)
      CopyBaseProperty(PaGlobal_TradeEventNotice_All._ui._stc_ItemSlotBG, PaGlobal_TradeEventNotice_All._ui._staticSupplyItemBGList[terrIndex][itemIndex])
      CopyBaseProperty(PaGlobal_TradeEventNotice_All._ui._stcText_TerritorySupply_ItemName, PaGlobal_TradeEventNotice_All._ui._staticTextSupplyItemNameList[terrIndex][itemIndex])
      CopyBaseProperty(PaGlobal_TradeEventNotice_All._ui._stc_ItemSlot, itemSlot)
      local slotNo = terrIndex * PaGlobal_TradeEventNotice_All._maxItemCount + itemIndex
      PaGlobal_TradeEventNotice_All._ui._staticSupplyItemList[terrIndex][itemIndex] = SlotItem.new(nil, "TradeSupply_Icon_" .. slotNo, slotNo, itemSlot, PaGlobal_TradeEventNotice_All._itemSlotConfig)
      PaGlobal_TradeEventNotice_All._ui._staticSupplyItemList[terrIndex][itemIndex].icon:SetPosX(1)
      PaGlobal_TradeEventNotice_All._ui._staticSupplyItemList[terrIndex][itemIndex].icon:SetPosY(1)
      PaGlobal_TradeEventNotice_All._ui._staticSupplyItemBGList[terrIndex][itemIndex]:SetPosX(PaGlobal_TradeEventNotice_All._ui._staticSupplyItemBGList[terrIndex][itemIndex]:GetPosX() + itemGapX * itemIndex)
      PaGlobal_TradeEventNotice_All._ui._staticTextSupplyItemNameList[terrIndex][itemIndex]:SetPosX(PaGlobal_TradeEventNotice_All._ui._staticTextSupplyItemNameList[terrIndex][itemIndex]:GetPosX() + PaGlobal_TradeEventNotice_All._ui._stc_TerritorySupplyBG1:GetSizeX() / PaGlobal_TradeEventNotice_All._nameColumnNum * (itemIndex % PaGlobal_TradeEventNotice_All._nameColumnNum))
      PaGlobal_TradeEventNotice_All._ui._staticTextSupplyItemNameList[terrIndex][itemIndex]:SetPosY(PaGlobal_TradeEventNotice_All._ui._staticTextSupplyItemNameList[terrIndex][itemIndex]:GetPosY() + math.floor(itemIndex / PaGlobal_TradeEventNotice_All._nameColumnNum) * nameGapY)
      if false == PaGlobal_TradeEventNotice_All._isConsole then
        PaGlobal_TradeEventNotice_All._ui._staticSupplyItemList[terrIndex][itemIndex].icon:addInputEvent("Mouse_On", "HandleEventOn_TradeEventNotice_Renewal_All_ShowSimpleToolTip(" .. terrIndex .. " , " .. itemIndex .. ", " .. PaGlobal_TradeEventNotice_All._ETabState._icon .. ")")
        PaGlobal_TradeEventNotice_All._ui._staticSupplyItemList[terrIndex][itemIndex].icon:addInputEvent("Mouse_Out", "Panel_Tooltip_Item_hideTooltip()")
        PaGlobal_TradeEventNotice_All._ui._staticTextSupplyItemNameList[terrIndex][itemIndex]:addInputEvent("Mouse_On", "HandleEventOn_TradeEventNotice_Renewal_All_ShowSimpleToolTip(" .. terrIndex .. " , " .. itemIndex .. ", " .. PaGlobal_TradeEventNotice_All._ETabState._name .. ")")
        PaGlobal_TradeEventNotice_All._ui._staticTextSupplyItemNameList[terrIndex][itemIndex]:addInputEvent("Mouse_Out", "Panel_Tooltip_Item_hideTooltip()")
      else
        if PaGlobal_TradeEventNotice_All._ETerritory._margoria ~= terrIndex then
          PaGlobal_TradeEventNotice_All._ui._staticSupplyItemBGList[terrIndex][itemIndex]:registerPadEvent(__eConsoleUIPadEvent_Up_A, "HandleEventLUp_TradeEventNotice_Renewal_All_SupplyNPCNaviStart(" .. terrIndex .. ")")
        end
        PaGlobal_TradeEventNotice_All._ui._staticSupplyItemBGList[terrIndex][itemIndex]:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandleEventOn_TradeEventNotice_Renewal_All_ShowSimpleToolTip(" .. terrIndex .. " , " .. itemIndex .. ", " .. PaGlobal_TradeEventNotice_All._ETabState._icon .. ")")
        PaGlobal_TradeEventNotice_All._ui._staticSupplyItemBGList[terrIndex][itemIndex]:addInputEvent("Mouse_On", "HandleEventOn_TradeEventNotice_Renewal_All_SetShowKeyGuide(" .. terrIndex .. ")")
        PaGlobal_TradeEventNotice_All._ui._staticSupplyItemBGList[terrIndex][itemIndex]:addInputEvent("Mouse_Out", "Panel_Tooltip_Item_hideTooltip()")
        local x1, y1, x2, y2 = setTextureUV_Func(PaGlobal_TradeEventNotice_All._ui._staticSupplyItemBGList[terrIndex][itemIndex], 46, 99, 90, 143)
        PaGlobal_TradeEventNotice_All._ui._staticSupplyItemBGList[terrIndex][itemIndex]:getOnTexture():setUV(x1, y1, x2, y2)
        local x1, y1, x2, y2 = setTextureUV_Func(PaGlobal_TradeEventNotice_All._ui._staticSupplyItemBGList[terrIndex][itemIndex], 46, 99, 90, 143)
        PaGlobal_TradeEventNotice_All._ui._staticSupplyItemBGList[terrIndex][itemIndex]:getClickTexture():setUV(x1, y1, x2, y2)
      end
    end
  end
  PaGlobal_TradeEventNotice_All._ui._stc_ListBG:SetSize(PaGlobal_TradeEventNotice_All._ui._stc_ListBG:GetSizeX(), PaGlobal_TradeEventNotice_All._lineGapY * (lineNum + 1) + 5)
  PaGlobal_TradeEventNotice_All._stc_ListBG_OriginSizeY = PaGlobal_TradeEventNotice_All._ui._stc_ListBG:GetSizeY()
  PaGlobal_TradeEventNotice_All._ui._stc_ItemSlot:SetShow(false)
  PaGlobal_TradeEventNotice_All._ui._stcText_TerritorySupply_Town:SetShow(false)
end
function PaGlobal_TradeEventNotice_All:keyAlign()
  if nil == Panel_Window_TradeEventNotice_Renewal_All then
    return
  end
  if false == PaGlobal_TradeEventNotice_All._isConsole then
    return
  end
  PaGlobalFunc_ConsoleKeyGuide_SetAlign(PaGlobal_TradeEventNotice_All._keyGuide, PaGlobal_TradeEventNotice_All._ui._stc_ConsoleGuide, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP)
end
function PaGlobal_TradeEventNotice_All:ShowTooltipName(terrIndex)
  if nil == Panel_Window_TradeEventNotice_Renewal_All then
    return
  end
  local territoryName = PaGlobal_TradeEventNotice_All._territoryName[terrIndex]
  local npcName = PaGlobal_TradeEventNotice_All:GetTerritorySupplyNpcName(terrIndex)
  local name = territoryName .. npcName
  TooltipSimple_Show(PaGlobal_TradeEventNotice_All._ui._staticTextSupplyTownList[terrIndex], name, nil)
end
function PaGlobal_TradeEventNotice_All:registEventHandler()
  if nil == Panel_Window_TradeEventNotice_Renewal_All then
    return
  end
  PaGlobal_TradeEventNotice_All._ui._btn_Close:addInputEvent("Mouse_LUp", "PaGlobalFunc_TradeEventNotice_Renewal_All_Close()")
  PaGlobal_TradeEventNotice_All._ui._chk_PopUp:addInputEvent("Mouse_LUp", "HandleEventLUp_TradeEventNotice_Renewal_All_PopUp()")
  PaGlobal_TradeEventNotice_All._ui._chk_PopUp:addInputEvent("Mouse_On", "HandleEventOn_TradeEventNotice_Renewal_All_ShowPopUpToolTip()")
  PaGlobal_TradeEventNotice_All._ui._chk_PopUp:addInputEvent("Mouse_Out", "TooltipSimple_Hide()")
  PaGlobal_TradeEventNotice_All._ui._rdo_ShowIcon:addInputEvent("Mouse_LUp", "HandleEventLUp_TradeEventNotice_Renewal_All_ShowPopUpToolTip(" .. PaGlobal_TradeEventNotice_All._ETabState._icon .. ")")
  PaGlobal_TradeEventNotice_All._ui._rdo_ShowName:addInputEvent("Mouse_LUp", "HandleEventLUp_TradeEventNotice_Renewal_All_ShowPopUpToolTip(" .. PaGlobal_TradeEventNotice_All._ETabState._name .. ")")
  PaGlobal_TradeEventNotice_All._ui._rdo_ShowIcon:addInputEvent("Mouse_On", "HandleEventOn_TradeEventNotice_Renewal_All_ShowRadioButtonSimpleToolTip(" .. PaGlobal_TradeEventNotice_All._ETabState._icon .. ")")
  PaGlobal_TradeEventNotice_All._ui._rdo_ShowName:addInputEvent("Mouse_On", "HandleEventOn_TradeEventNotice_Renewal_All_ShowRadioButtonSimpleToolTip(" .. PaGlobal_TradeEventNotice_All._ETabState._name .. ")")
  PaGlobal_TradeEventNotice_All._ui._rdo_ShowIcon:addInputEvent("Mouse_Out", "TooltipSimple_Hide()")
  PaGlobal_TradeEventNotice_All._ui._rdo_ShowName:addInputEvent("Mouse_Out", "TooltipSimple_Hide()")
  if false == PaGlobal_TradeEventNotice_All._isConsole then
    PaGlobal_TradeEventNotice_All._ui._btn_TradeEvent_Navi:addInputEvent("Mouse_LUp", "HandleEventLUp_TradeEventNotice_Renewal_All_TradeEventNPCNaviStart()")
  else
    PaGlobal_TradeEventNotice_All._ui._stcText_TradeEventDesc:registerPadEvent(__eConsoleUIPadEvent_Up_A, "HandleEventLUp_TradeEventNotice_Renewal_All_TradeEventNPCNaviStart()")
  end
  Panel_Window_TradeEventNotice_Renewal_All:RegisterShowEventFunc(true, "PaGloabl_TradeEventNotice_Renewal_ShowAni()")
  Panel_Window_TradeEventNotice_Renewal_All:RegisterShowEventFunc(false, "PaGloabl_TradeEventNotice_Renewal_HideAni()")
  registerEvent("FromClient_NotifyVariableTradeItemMsg", "FromClient_TradeEventNotice_Renewal_All_UpdateTradeEventInfo")
  registerEvent("FromClientNotifySupplyTradeStart", "FromClient_TradeEventNotice_Renewal_All_UpdateSupplyInfo")
  registerEvent("onScreenResize", "FromClient_TradeEventNotice_Renewal_All_Resize")
end
function PaGlobal_TradeEventNotice_All:prepareOpen()
  if nil == Panel_Window_TradeEventNotice_Renewal_All then
    return
  end
  if false == ToClient_IsGrowStepOpen(__eGrowStep_trade) then
    return
  end
  if true == Panel_Window_TradeEventNotice_Renewal_All:GetShow() then
    PaGlobal_TradeEventNotice_All:close()
    Panel_Tooltip_Item_hideTooltip()
    return
  end
  Panel_Window_TradeEventNotice_Renewal_All:SetShow(true, true)
  if PaGlobal_TradeEventNotice_All._needTradeEventUpdate then
    PaGlobal_TradeEventNotice_All:UpdateTradeEventInfo()
  end
  if PaGlobal_TradeEventNotice_All._needSupplyUpdate then
    PaGlobal_TradeEventNotice_All:UpdateSupplyInfo()
  end
  PaGlobal_TradeEventNotice_All:Resize()
  audioPostEvent_SystemUi(1, 8)
  _AudioPostEvent_SystemUiForXBOX(1, 18)
  PaGlobal_TradeEventNotice_All:open()
end
function PaGlobal_TradeEventNotice_All:open()
  if nil == Panel_Window_TradeEventNotice_Renewal_All then
    return
  end
  Panel_Window_TradeEventNotice_Renewal_All:SetShow(true)
end
function PaGlobal_TradeEventNotice_All:prepareClose()
  if nil == Panel_Window_TradeEventNotice_Renewal_All then
    return
  end
  if PaGlobal_TradeEventNotice_All._ui._chk_PopUp:IsCheck() then
    PaGlobal_TradeEventNotice_All._ui._chk_PopUp:SetCheck(false)
    Panel_Window_TradeEventNotice_Renewal_All:CloseUISubApp()
    Panel_Window_TradeEventNotice_Renewal_All:SetShow(false, false)
  else
    Panel_Window_TradeEventNotice_Renewal_All:SetShow(false, true)
  end
  Panel_Tooltip_Item_hideTooltip()
  audioPostEvent_SystemUi(1, 1)
  _AudioPostEvent_SystemUiForXBOX(1, 1)
  PaGlobal_TradeEventNotice_All:close()
end
function PaGlobal_TradeEventNotice_All:close()
  if nil == Panel_Window_TradeEventNotice_Renewal_All then
    return
  end
  Panel_Window_TradeEventNotice_Renewal_All:SetShow(false)
end
function PaGlobal_TradeEventNotice_All:validate()
  if nil == Panel_Window_TradeEventNotice_Renewal_All then
    return
  end
  PaGlobal_TradeEventNotice_All._ui._stc_TitleBG:isValidate()
  PaGlobal_TradeEventNotice_All._ui._stc_BackImage:isValidate()
  PaGlobal_TradeEventNotice_All._ui._btn_Close:isValidate()
  PaGlobal_TradeEventNotice_All._ui._chk_PopUp:isValidate()
  PaGlobal_TradeEventNotice_All._ui._stcText_TradeEvent:isValidate()
  PaGlobal_TradeEventNotice_All._ui._btn_TradeEvent_Navi:isValidate()
  PaGlobal_TradeEventNotice_All._ui._stc_TradeEventDescBG:isValidate()
  PaGlobal_TradeEventNotice_All._ui._stc_TradeEventDown:isValidate()
  PaGlobal_TradeEventNotice_All._ui._rdo_ShowIcon:isValidate()
  PaGlobal_TradeEventNotice_All._ui._rdo_ShowName:isValidate()
  PaGlobal_TradeEventNotice_All._ui._stcText_TerritorySupply:isValidate()
  PaGlobal_TradeEventNotice_All._ui._stc_TerritorySupplyBG1:isValidate()
  PaGlobal_TradeEventNotice_All._ui._stcText_TerritorySupply_Town:isValidate()
  PaGlobal_TradeEventNotice_All._ui._stc_ItemSlotBG:isValidate()
  PaGlobal_TradeEventNotice_All._ui._stcText_TerritorySupplyAlert:isValidate()
  PaGlobal_TradeEventNotice_All._ui._stcText_TerritorySupply_ItemName:isValidate()
  PaGlobal_TradeEventNotice_All._ui._btn_Navi:isValidate()
  PaGlobal_TradeEventNotice_All._ui._stc_ConsoleGuide:isValidate()
  PaGlobal_TradeEventNotice_All._ui._stcText_Navi:isValidate()
  PaGlobal_TradeEventNotice_All._ui._stcText_Close:isValidate()
end
function PaGlobal_TradeEventNotice_All:UpdateSupplyInfo()
  if nil == Panel_Window_TradeEventNotice_Renewal_All then
    return
  end
  if false == PaGlobal_TradeEventNotice_All._needSupplyUpdate then
    return
  end
  PaGlobal_TradeEventNotice_All._needSupplyUpdate = false
  local supplyStart = false
  for terrIndex = 0, PaGlobal_TradeEventNotice_All._territoryCount - 1 do
    PaGlobal_TradeEventNotice_All._ui._staticSupplyBGList[terrIndex]:SetShow(false)
    PaGlobal_TradeEventNotice_All._supplyItemCount[terrIndex] = ToClient_worldmap_getTradeSupplyCount(terrIndex)
    if 0 < PaGlobal_TradeEventNotice_All._supplyItemCount[terrIndex] then
      PaGlobal_TradeEventNotice_All._ui._staticSupplyBGList[terrIndex]:SetShow(true)
      if false == PaGlobal_TradeEventNotice_All._isConsole and PaGlobal_TradeEventNotice_All._ETerritory._margoria == terrIndex then
        PaGlobal_TradeEventNotice_All._ui._btnSupplyNaviList[terrIndex]:SetShow(false)
      end
      for itemIndex = 0, PaGlobal_TradeEventNotice_All._maxItemCount - 1 do
        if itemIndex < PaGlobal_TradeEventNotice_All._supplyItemCount[terrIndex] then
          if PaGlobal_TradeEventNotice_All._ui._rdo_ShowName:IsChecked() then
            PaGlobal_TradeEventNotice_All._ui._staticTextSupplyItemNameList[terrIndex][itemIndex]:SetShow(true)
            PaGlobal_TradeEventNotice_All._ui._staticSupplyItemBGList[terrIndex][itemIndex]:SetShow(false)
          else
            PaGlobal_TradeEventNotice_All._ui._staticSupplyItemBGList[terrIndex][itemIndex]:SetShow(true)
            PaGlobal_TradeEventNotice_All._ui._staticTextSupplyItemNameList[terrIndex][itemIndex]:SetShow(false)
          end
          PaGlobal_TradeEventNotice_All:SetItem(terrIndex, itemIndex)
        else
          PaGlobal_TradeEventNotice_All._ui._staticTextSupplyItemNameList[terrIndex][itemIndex]:SetShow(false)
          PaGlobal_TradeEventNotice_All._ui._staticSupplyItemBGList[terrIndex][itemIndex]:SetShow(false)
        end
        supplyStart = true
      end
    end
  end
  local tempSizeY = 30
  if supplyStart then
    PaGlobal_TradeEventNotice_All._ui._stcText_TerritorySupplyAlert:SetShow(false)
    PaGlobal_TradeEventNotice_All._ui._stc_TradeEventDown:SetSize(PaGlobal_TradeEventNotice_All._ui._stc_TradeEventDown:GetSizeX(), PaGlobal_TradeEventNotice_All._ui._stcText_TerritorySupply:GetSizeY() + PaGlobal_TradeEventNotice_All._lineGapY * (math.floor((PaGlobal_TradeEventNotice_All._territoryCount - 1) / PaGlobal_TradeEventNotice_All._columnNum) + 1) + tempSizeY)
    PaGlobal_TradeEventNotice_All._ui._stc_ListBG:SetSize(PaGlobal_TradeEventNotice_All._ui._stc_ListBG:GetSizeX(), PaGlobal_TradeEventNotice_All._stc_ListBG_OriginSizeY)
  else
    PaGlobal_TradeEventNotice_All._ui._stcText_TerritorySupplyAlert:SetShow(true)
    PaGlobal_TradeEventNotice_All._ui._stc_TradeEventDown:SetSize(PaGlobal_TradeEventNotice_All._ui._stc_TradeEventDown:GetSizeX(), PaGlobal_TradeEventNotice_All._ui._stcText_TerritorySupply:GetSizeY() + PaGlobal_TradeEventNotice_All._ui._stc_TerritorySupplyBG1:GetSizeY() + tempSizeY)
    PaGlobal_TradeEventNotice_All._ui._stc_ListBG:SetSize(PaGlobal_TradeEventNotice_All._ui._stc_ListBG:GetSizeX(), PaGlobal_TradeEventNotice_All._ui._stc_TradeEventDown:GetSizeY() - 40)
  end
  Panel_Window_TradeEventNotice_Renewal_All:SetSize(Panel_Window_TradeEventNotice_Renewal_All:GetSizeX(), PaGlobal_TradeEventNotice_All._ui._stc_TradeEventDown:GetPosY() + PaGlobal_TradeEventNotice_All._ui._stc_TradeEventDown:GetSizeY())
  PaGlobal_TradeEventNotice_All._ui._stc_ConsoleGuide:ComputePos()
end
function PaGlobal_TradeEventNotice_All:SetItem(terrIndex, itemIndex)
  if nil == Panel_Window_TradeEventNotice_Renewal_All then
    return
  end
  local supplyItemWrapper = ToClient_worldmap_getTradeSupplyItem(terrIndex, itemIndex)
  if nil ~= supplyItemWrapper then
    local supplyItemSSW = supplyItemWrapper:getStaticStatus()
    PaGlobal_TradeEventNotice_All._ui._staticSupplyItemList[terrIndex][itemIndex]:setItemByStaticStatus(supplyItemSSW)
    PaGlobal_TradeEventNotice_All._ui._staticTextSupplyItemNameList[terrIndex][itemIndex]:SetText(supplyItemSSW:getName())
    PaGlobal_TradeEventNotice_All._supplyItemKeyList[terrIndex][itemIndex] = supplyItemSSW:get()._key:get()
  else
    PaGlobal_TradeEventNotice_All._supplyItemKeyList[terrIndex][itemIndex] = nil
  end
end
function PaGlobal_TradeEventNotice_All:SetTerritoryCount()
  if nil == Panel_Window_TradeEventNotice_Renewal_All then
    return
  end
  if ToClient_IsContentsGroupOpen("6") then
    PaGlobal_TradeEventNotice_All._territoryCount = 8
  elseif ToClient_IsContentsGroupOpen("260") then
    PaGlobal_TradeEventNotice_All._territoryCount = 7
  elseif ToClient_IsContentsGroupOpen("83") then
    PaGlobal_TradeEventNotice_All._territoryCount = 6
  elseif ToClient_IsContentsGroupOpen("4") then
    PaGlobal_TradeEventNotice_All._territoryCount = 5
  elseif ToClient_IsContentsGroupOpen("3") then
    PaGlobal_TradeEventNotice_All._territoryCount = 4
  elseif ToClient_IsContentsGroupOpen("2") then
    PaGlobal_TradeEventNotice_All._territoryCount = 3
  else
    PaGlobal_TradeEventNotice_All._territoryCount = 2
  end
end
function PaGlobal_TradeEventNotice_All:PopUp()
  if nil == Panel_Window_TradeEventNotice_Renewal_All then
    return
  end
  if PaGlobal_TradeEventNotice_All._ui._chk_PopUp:IsCheck() then
    Panel_Window_TradeEventNotice_Renewal_All:OpenUISubApp()
  else
    Panel_Window_TradeEventNotice_Renewal_All:CloseUISubApp()
  end
  TooltipSimple_Hide()
end
function PaGlobal_TradeEventNotice_All:ShowPopUpToolTip()
  if nil == Panel_Window_TradeEventNotice_Renewal_All then
    return
  end
  local name = PAGetString(Defines.StringSheet_GAME, "LUA_POPUI_TOOLTIP_NAME")
  local desc = ""
  if PaGlobal_TradeEventNotice_All._ui._chk_PopUp:IsCheck() then
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_POPUI_CHECK_TOOLTIP")
  else
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_POPUI_NOCHECK_TOOLTIP")
  end
  TooltipSimple_Show(PaGlobal_TradeEventNotice_All._ui._chk_PopUp, name, desc)
end
function PaGlobal_TradeEventNotice_All:HandleClicked_Tab(tabState)
  if nil == Panel_Window_TradeEventNotice_Renewal_All then
    return
  end
  if PaGlobal_TradeEventNotice_All._ETabState._icon == tabState and PaGlobal_TradeEventNotice_All._ETabState._icon ~= PaGlobal_TradeEventNotice_All._prevTab then
    PaGlobal_TradeEventNotice_All._prevTab = PaGlobal_TradeEventNotice_All._ETabState._icon
    for terrIndex = 0, PaGlobal_TradeEventNotice_All._territoryCount - 1 do
      for itemIndex = 0, PaGlobal_TradeEventNotice_All._maxItemCount - 1 do
        PaGlobal_TradeEventNotice_All._ui._staticTextSupplyItemNameList[terrIndex][itemIndex]:SetShow(false)
        if itemIndex < PaGlobal_TradeEventNotice_All._supplyItemCount[terrIndex] then
          PaGlobal_TradeEventNotice_All._ui._staticSupplyItemBGList[terrIndex][itemIndex]:SetShow(true)
        end
      end
    end
  elseif PaGlobal_TradeEventNotice_All._ETabState._name == tabState and PaGlobal_TradeEventNotice_All._ETabState._name ~= PaGlobal_TradeEventNotice_All._prevTab then
    PaGlobal_TradeEventNotice_All._prevTab = PaGlobal_TradeEventNotice_All._ETabState._name
    for terrIndex = 0, PaGlobal_TradeEventNotice_All._territoryCount - 1 do
      for itemIndex = 0, PaGlobal_TradeEventNotice_All._maxItemCount - 1 do
        PaGlobal_TradeEventNotice_All._ui._staticSupplyItemBGList[terrIndex][itemIndex]:SetShow(false)
        if itemIndex < PaGlobal_TradeEventNotice_All._supplyItemCount[terrIndex] then
          PaGlobal_TradeEventNotice_All._ui._staticTextSupplyItemNameList[terrIndex][itemIndex]:SetShow(true)
        end
      end
    end
  end
end
function PaGlobal_TradeEventNotice_All:GetTerritorySupplyNpcName(territory)
  if nil == Panel_Window_TradeEventNotice_Renewal_All then
    return
  end
  local npcData = ToClient_getNpcInfoByRegionAndType(PaGlobal_TradeEventNotice_All._supplyNpcRegionKey[territory], PaGlobal_TradeEventNotice_All._supplySpawnType)
  if nil ~= npcData then
    return " " .. PAGetStringParam1(Defines.StringSheet_GAME, "LUA_TRADEEVENTINFO_NPC", "npcName", npcData:getName())
  else
    return ""
  end
end
function PaGlobal_TradeEventNotice_All:ShowRadioButtonSimpleToolTip(tabState)
  if nil == Panel_Window_TradeEventNotice_Renewal_All then
    return
  end
  local name = ""
  if PaGlobal_TradeEventNotice_All._ETabState._icon == tabState then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_TRADEEVENTINFO_TOOLTIP_ICON_SHOW_NAME")
    TooltipSimple_Show(PaGlobal_TradeEventNotice_All._ui._rdo_ShowIcon, name, nil)
  elseif PaGlobal_TradeEventNotice_All._ETabState._name == tabState then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_TRADEEVENTINFO_TOOLTIP_NAME_SHOW_NAME")
    TooltipSimple_Show(PaGlobal_TradeEventNotice_All._ui._rdo_ShowName, name, nil)
  end
end
function PaGlobal_TradeEventNotice_All:TradeEventNPCNaviStart()
  if nil == Panel_Window_TradeEventNotice_Renewal_All then
    return
  end
  local npcKey = FGlobal_TradeEvent_Npckey_Return()
  local npcData = ToClient_getNpcInfoByRegionAndKey(PaGlobal_TradeEventNotice_All._tradeEventNpcRegionKey[npcKey], npcKey)
  if nil ~= npcData then
    if ToClient_IsShowNaviGuideGroup(0) then
      ToClient_DeleteNaviGuideByGroup(0)
    end
    ToClient_WorldMapNaviStart(npcData:getPosition(), NavigationGuideParam(), false, false)
    audioPostEvent_SystemUi(0, 14)
    _AudioPostEvent_SystemUiForXBOX(0, 14)
  end
end
function PaGlobal_TradeEventNotice_All:SupplyNPCNaviStart(territory)
  if nil == Panel_Window_TradeEventNotice_Renewal_All then
    return
  end
  local npcData = ToClient_getNpcInfoByRegionAndType(PaGlobal_TradeEventNotice_All._supplyNpcRegionKey[territory], PaGlobal_TradeEventNotice_All._supplySpawnType)
  if nil ~= npcData then
    if ToClient_IsShowNaviGuideGroup(0) then
      ToClient_DeleteNaviGuideByGroup(0)
    end
    ToClient_WorldMapNaviStart(npcData:getPosition(), NavigationGuideParam(), false, false)
    audioPostEvent_SystemUi(0, 14)
    _AudioPostEvent_SystemUiForXBOX(0, 14)
  end
end
function PaGlobal_TradeEventNotice_All:ShowItemToolTip(terrIndex, itemIndex, tabState)
  if nil == Panel_Window_TradeEventNotice_Renewal_All then
    return
  end
  local supplyItemWrapper = ToClient_worldmap_getTradeSupplyItem(terrIndex, itemIndex)
  if nil ~= supplyItemWrapper then
    local supplyItemSSW = supplyItemWrapper:getStaticStatus()
    if nil ~= supplyItemSSW then
      if true == _ContentsGroup_RenewUI_Tooltip then
        if true == PaGlobalFunc_TooltipInfo_GetShow() then
          PaGlobalFunc_TooltipInfo_Close()
          return
        elseif PaGlobal_TradeEventNotice_All._ETabState._icon == tabState then
          PaGlobalFunc_TooltipInfo_Open(Defines.TooltipDataType.ItemSSWrapper, supplyItemSSW, Defines.TooltipTargetType.Item, nil)
        end
      elseif PaGlobal_TradeEventNotice_All._ETabState._icon == tabState then
        Panel_Tooltip_Item_Show(supplyItemSSW, PaGlobal_TradeEventNotice_All._ui._staticSupplyItemList[terrIndex][itemIndex].icon, true, false)
      elseif PaGlobal_TradeEventNotice_All._ETabState._name == tabState then
        Panel_Tooltip_Item_Show(supplyItemSSW, PaGlobal_TradeEventNotice_All._ui._staticTextSupplyItemNameList[terrIndex][itemIndex], true, false)
      end
    end
  end
end
function PaGlobal_TradeEventNotice_All:UpdateTradeEventInfo()
  if nil == Panel_Window_TradeEventNotice_Renewal_All then
    return
  end
  if false == PaGlobal_TradeEventNotice_All._needTradeEventUpdate then
    return
  end
  PaGlobal_TradeEventNotice_All._needTradeEventUpdate = false
  local eventInfo = FGlobal_TradeEventInfo()
  if nil == eventInfo then
    PaGlobal_TradeEventNotice_All._ui._stcText_TradeEventDesc:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_TRADEEVENTINFO_6") .. "\n" .. PAGetString(Defines.StringSheet_GAME, "LUA_TRADEEVENTINFO_7") .. "\n" .. PAGetString(Defines.StringSheet_GAME, "LUA_TRADEEVENTINFO_8"))
    if false == PaGlobal_TradeEventNotice_All._isConsole then
      PaGlobal_TradeEventNotice_All._ui._btn_TradeEvent_Navi:SetShow(false)
    else
      PaGlobal_TradeEventNotice_All._ui._stc_TradeEventDescBG:SetIgnore(true)
      PaGlobal_TradeEventNotice_All._ui._stcText_TradeEventDesc:SetIgnore(true)
    end
  else
    PaGlobal_TradeEventNotice_All._ui._stcText_TradeEventDesc:SetText(eventInfo .. "\n" .. PAGetString(Defines.StringSheet_GAME, "LUA_TRADEEVENTINFO_7"))
    if false == PaGlobal_TradeEventNotice_All._isConsole then
      PaGlobal_TradeEventNotice_All._ui._btn_TradeEvent_Navi:SetShow(true)
    else
      PaGlobal_TradeEventNotice_All._ui._stc_TradeEventDescBG:SetIgnore(false)
      PaGlobal_TradeEventNotice_All._ui._stcText_TradeEventDesc:SetIgnore(false)
    end
  end
  local changedEventBGSizeY = PaGlobal_TradeEventNotice_All._ui._stcText_TradeEventDesc:GetTextSizeY()
  local addPosY = changedEventBGSizeY - PaGlobal_TradeEventNotice_All._ui._stcText_TradeEventDesc:GetSizeY()
  PaGlobal_TradeEventNotice_All._ui._stcText_TradeEventDesc:SetSize(PaGlobal_TradeEventNotice_All._ui._stcText_TradeEventDesc:GetSizeX(), changedEventBGSizeY)
  PaGlobal_TradeEventNotice_All._ui._stc_TradeEventDown:SetPosY(PaGlobal_TradeEventNotice_All._ui._stc_TradeEventDown:GetPosY() + addPosY)
  PaGlobal_TradeEventNotice_All._ui._stc_TradeEventDescBG:SetSize(PaGlobal_TradeEventNotice_All._ui._stc_TradeEventDescBG:GetSizeX(), PaGlobal_TradeEventNotice_All._ui._stcText_TradeEventDesc:GetSizeY() + PaGlobal_TradeEventNotice_All._ui._stcText_TradeEventDesc:GetSpanSize().x * 2)
  Panel_Window_TradeEventNotice_Renewal_All:SetSize(Panel_Window_TradeEventNotice_Renewal_All:GetSizeX(), PaGlobal_TradeEventNotice_All._ui._stc_TradeEventDown:GetPosY() + PaGlobal_TradeEventNotice_All._ui._stc_TradeEventDown:GetSizeY())
  PaGlobal_TradeEventNotice_All._ui._stc_ConsoleGuide:ComputePos()
end
function PaGlobal_TradeEventNotice_All:ShowAni()
  if nil == Panel_Window_TradeEventNotice_Renewal_All then
    return
  end
  Panel_Window_TradeEventNotice_Renewal_All:SetAlpha(0)
  UIAni.AlphaAnimation(1, Panel_Window_TradeEventNotice_Renewal_All, 0, 0.3)
end
function PaGlobal_TradeEventNotice_All:HideAni()
  if nil == Panel_Window_TradeEventNotice_Renewal_All then
    return
  end
  local ani = UIAni.AlphaAnimation(0, Panel_Window_TradeEventNotice_Renewal_All, 0, 0.2)
  ani:SetHideAtEnd(true)
end
function PaGlobal_TradeEventNotice_All:Resize()
  if nil == Panel_Window_TradeEventNotice_Renewal_All then
    return
  end
  Panel_Window_TradeEventNotice_Renewal_All:SetPosX(getOriginScreenSizeX() / 2 - Panel_Window_TradeEventNotice_Renewal_All:GetSizeX() / 2)
  Panel_Window_TradeEventNotice_Renewal_All:SetPosY(getOriginScreenSizeY() / 2 - Panel_Window_TradeEventNotice_Renewal_All:GetSizeY() / 2)
end
function PaGlobal_TradeEventNotice_All:GetTerritorySupplyIndex(itemKey)
  if PaGlobal_TradeEventNotice_All._needSupplyUpdate then
    PaGlobal_TradeEventNotice_All:UpdateSupplyInfo()
  end
  for terrIndex = 0, PaGlobal_TradeEventNotice_All._territoryCount - 1 do
    for itemIndex = 0, PaGlobal_TradeEventNotice_All._maxItemCount - 1 do
      if PaGlobal_TradeEventNotice_All._supplyItemKeyList[terrIndex][itemIndex] == itemKey then
        return terrIndex
      end
    end
  end
  return nil
end
