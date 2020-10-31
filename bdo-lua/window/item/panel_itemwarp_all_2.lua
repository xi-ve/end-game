function FromClient_Itemwarp_UseNotify(whereType, slotNo, regionKey)
  PaGlobal_Itemwarp:itemUseNotify(whereType, slotNo, regionKey)
end
function HandleEventLUp_Itemwarp_GotoSelectTown(regionKey)
  PaGlobal_Itemwarp:gotoSelectTown(regionKey)
end
function ItemWarp_SetectTown(regionIndex)
  PaGlobal_Itemwarp._selectTownKey = regionIndex
end
function PaGlobal_Itemwarp_TownListCreate(content, key)
  local townListBlueBg = UI.getChildControl(content, "Static_TownList_BlueBG")
  local townListName = UI.getChildControl(content, "List2_TownList_Desc")
  local _key = Int64toInt32(key)
  townListBlueBg:SetCheck(false)
  townListBlueBg:setNotImpactScrollEvent(true)
  local nearTownListCount = getSelfPlayer():get():getNearTownRegionInfoCount()
  local count = 0
  for index = 0, nearTownListCount - 1 do
    if _key == index then
      if PaGlobal_Itemwarp._selectTownKey == _key then
        townListBlueBg:SetCheck(true)
      end
      local regionInfo = getSelfPlayer():get():getNearTownRegionInfoAt(index)
      local areaName = PAGetString(Defines.StringSheet_GAME, "LUA_ITEMWARP_NEARESTTOWN_1")
      if regionInfo:get() ~= nil then
        areaName = regionInfo:getAreaName()
      end
      townListName:SetText(areaName)
    end
  end
  if true == PaGlobal_Itemwarp._isConsole then
    content:addInputEvent("Mouse_On", "ItemWarp_SetectTown(" .. _key .. ")")
  else
    townListBlueBg:addInputEvent("Mouse_LUp", "ItemWarp_SetectTown(" .. _key .. ")")
  end
end
function Panel_ItemWarp_All_Close()
  if false == Panel_ItemWarp_All:GetShow() then
    return
  end
  PaGlobal_Itemwarp:prepareClose()
end
function Panel_ItemWarp_All_ShowAni()
  Panel_ItemWarp_All:SetAlpha(0)
  UIAni.AlphaAnimation(1, Panel_ItemWarp_All, 0, 0.3)
end
function Panel_ItemWarp_All_HideAni()
  local ani1 = UIAni.AlphaAnimation(0, Panel_ItemWarp_All, 0, 0.2)
  ani1:SetHideAtEnd(true)
end
