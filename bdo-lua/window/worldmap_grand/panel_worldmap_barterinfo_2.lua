function FromClient_WorldMapBarterInfo(panel, regionKey, existNormal, existSpecial)
  if nil == panel then
    return
  end
  local self = PaGlobal_WorldMapBarterInfo
  if true == existNormal and true == existSpecial then
    self:showAllBg(panel, regionKey)
  elseif true == existNormal and false == existSpecial then
    self:showNormalBg(panel, regionKey)
  else
    if false == existNormal and true == existSpecial then
      self:showSpecialBg(panel, regionKey)
    else
    end
  end
end
function PaGlobalFunc_FindBarterRegionByItem(findToRegion, itemEnchantKeyRaw)
  local regionKey = ToClient_FindBarterRegionByItem(findToRegion, itemEnchantKeyRaw)
  local regionWrapper = getRegionInfoWrapper(regionKey:get())
  if nil == regionWrapper then
    return
  end
  ToCleint_gotoWorldmapPosition(regionWrapper:getPosition())
end
