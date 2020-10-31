local _panel = Panel_Window_PreOrder
local preOrder = {}
function PaGlobalFunc_PreOrder_Open(parentPanel)
  preOrder:open(parentPanel)
end
function preOrder:open(parentPanel)
  if nil ~= parentPanel then
    local playTimeMin = ToClient_GetUserPlayMinute()
    local timeLimit = 300
    if playTimeMin > timeLimit and false == ToClient_GetIsBuyBundle() then
      parentPanel:registerPadEvent(__eConsoleUIPadEvent_RTPress_X, "PaGlobalFunc_PreOrder_OpenBundlePage()")
      _panel:ChangeTextureInfoName("Renewal/CommonIcon/Console_PreorderBanner_00.dds")
      local x1, y1, x2, y2 = setTextureUV_Func(_panel, 0, 0, 199, 364)
      _panel:getBaseTexture():setUV(x1, y1, x2, y2)
      _panel:setRenderTexture(_panel:getBaseTexture())
    else
      parentPanel:registerPadEvent(__eConsoleUIPadEvent_RTPress_X, "PaGlobalFunc_PreOrder_OpenPearlShop()")
    end
    local posX = parentPanel:GetPosX() - _panel:GetSizeX() - 5
    local posY = parentPanel:GetPosY() + 5
    _panel:SetPosX(posX)
    _panel:SetPosY(posY)
  end
  _panel:SetShow(true)
end
function PaGlobalFunc_PreOrder_Close(parentPanel, isShow)
  preOrder:close(parentPanel, isShow)
end
function preOrder:close(parentPanel, isShow)
  if nil ~= parentPanel then
    parentPanel:registerPadEvent(__eConsoleUIPadEvent_RTPress_X, "")
  end
  if not isShow then
    _panel:SetShow(false)
  end
end
function PaGlobalFunc_PreOrder_OpenPearlShop()
  if true == _ContentsGroup_NewUI_Inventory_All then
    if false == Panel_Window_Inventory_All:GetShow() then
      return
    end
  elseif false == Panel_Window_Inventory:GetShow() then
    return
  end
  if (true == _ContentsGroup_NewUI_XXX or true == _ContentsGroup_NewUI_Integration_All) and nil ~= Panel_Dialog_NPCShop_All and true == Panel_Dialog_NPCShop_All:GetShow() then
    return
  end
  if true == _ContentsGroup_NewUI_AlchemyStone_All and nil ~= Panel_Window_AlchemyStone_All and true == Panel_Window_AlchemyStone_All:GetShow() then
    return
  end
  if true == _ContentsGroup_NewUI_MiniGame_Find_All and nil ~= Panel_MiniGame_Find_All and true == Panel_MiniGame_Find_All:GetShow() then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_MINIGAMING_DO_NOT_USE"))
    return
  end
  PaGlobalFunc_InventoryInfo_Close()
  GlobalKeyBinder_MouseKeyMap(__eUiInputType_CashShop)
end
function PaGlobalFunc_PreOrder_OpenPage()
  if ToClient_isPS4() then
    ToClient_openPS4OBTStore()
  else
    ToClient_ShowPreOrderPage()
  end
end
function PaGlobalFunc_PreOrder_OpenBundlePage()
  if true == _ContentsGroup_NewUI_Inventory_All then
    if false == Panel_Window_Inventory_All:GetShow() then
      return
    end
  elseif false == Panel_Window_Inventory:GetShow() then
    return
  end
  if (true == _ContentsGroup_NewUI_XXX or true == _ContentsGroup_NewUI_Integration_All) and nil ~= Panel_Dialog_NPCShop_All and true == Panel_Dialog_NPCShop_All:GetShow() then
    return
  end
  if true == _ContentsGroup_NewUI_AlchemyStone_All and nil ~= Panel_Window_AlchemyStone_All and true == Panel_Window_AlchemyStone_All:GetShow() then
    return
  end
  if true == _ContentsGroup_NewUI_MiniGame_Find_All and nil ~= Panel_MiniGame_Find_All and true == Panel_MiniGame_Find_All:GetShow() then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_MINIGAMING_DO_NOT_USE"))
    return
  end
  if true == ToClient_isPS4() then
    ToClient_openPS4Store()
  else
    ToClient_openXBBundlePage()
  end
end
