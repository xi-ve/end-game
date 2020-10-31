function PaGlobal_NpcNavi_Tooltip:initialize()
  if true == PaGlobal_NpcNavi_Tooltip._initialize then
    return
  end
  self._ui.txt_NpcName = UI.getChildControl(Panel_Tooltip_NpcNavigation_All, "Tooltip_NpcName")
  self._ui.txt_NpcDesc = UI.getChildControl(Panel_Tooltip_NpcNavigation_All, "Tooltip_NpcDescription")
  self._ui.txt_itemName = UI.getChildControl(Panel_Tooltip_NpcNavigation_All, "StaticText_ItemName")
  self._ui.stc_Icon = UI.getChildControl(Panel_Tooltip_NpcNavigation_All, "Static_Icon")
  self._ui.txt_NeedExplorePoint = UI.getChildControl(Panel_Tooltip_NpcNavigation_All, "StaticText_NeedExplorePoint")
  self._ui.txt_Description = UI.getChildControl(Panel_Tooltip_NpcNavigation_All, "StaticText_Description")
  self._ui.txt_NotFind = UI.getChildControl(Panel_Tooltip_NpcNavigation_All, "StaticText_NotFound")
  self._ui.stc_ProgressBG = UI.getChildControl(Panel_Tooltip_NpcNavigation_All, "Static_ProgressBG")
  self._ui.CircularProgress = UI.getChildControl(Panel_Tooltip_NpcNavigation_All, "CircularProgress_Current")
  self._ui.txt_FruitageValue = UI.getChildControl(Panel_Tooltip_NpcNavigation_All, "StaticText_Fruitage_Value")
  self._ui.stc_GiftIcon = UI.getChildControl(Panel_Tooltip_NpcNavigation_All, "Static_GiftIcon")
  self._ui.txt_Description:SetAutoResize(true)
  self._ui.txt_Description:SetTextMode(__eTextMode_AutoWrap)
  self._ui.txt_NotFind:SetTextMode(__eTextMode_AutoWrap)
  self._ui.txt_NpcDesc:SetTextMode(__eTextMode_AutoWrap)
  self._ui.txt_NeedExplorePoint:SetTextMode(__eTextMode_AutoWrap)
  self._ui.txt_itemName:SetTextMode(__eTextMode_AutoWrap)
  self._ui.txt_NotFind:SetText(self._ui.txt_NotFind:GetText())
  self._ui.txt_NpcDesc:SetText(self._ui.txt_NpcDesc:GetText())
  self._ui.txt_NeedExplorePoint:SetText(self._ui.txt_NeedExplorePoint:GetText())
  PaGlobal_NpcNavi_Tooltip:validate()
  PaGlobal_NpcNavi_Tooltip._initialize = true
end
function PaGlobal_NpcNavi_Tooltip:prepareOpen()
  if nil == Panel_Tooltip_NpcNavigation_All then
    return
  end
  Panel_Tooltip_NpcNavigation_All:SetPosX(Panel_NpcNavi_All:GetPosX() - Panel_Tooltip_NpcNavigation_All:GetSizeX() - 5)
  Panel_Tooltip_NpcNavigation_All:SetPosY(Panel_NpcNavi_All:GetPosY())
  PaGlobal_NpcNavi_Tooltip:open()
end
function PaGlobal_NpcNavi_Tooltip:open()
  if nil == Panel_Tooltip_NpcNavigation_All then
    return
  end
  Panel_Tooltip_NpcNavigation_All:SetShow(true)
end
function PaGlobal_NpcNavi_Tooltip:prepareClose()
  if nil == Panel_Tooltip_NpcNavigation_All then
    return
  end
  PaGlobal_NpcNavi_Tooltip:close()
end
function PaGlobal_NpcNavi_Tooltip:close()
  if nil == Panel_Tooltip_NpcNavigation_All then
    return
  end
  Panel_Tooltip_NpcNavigation_All:SetShow(false)
end
function PaGlobal_NpcNavi_Tooltip:validate()
  if nil == Panel_Tooltip_NpcNavigation_All then
    return
  end
  self._ui.txt_NpcName:isValidate()
  self._ui.txt_NpcDesc:isValidate()
  self._ui.txt_itemName:isValidate()
  self._ui.stc_Icon:isValidate()
  self._ui.txt_NeedExplorePoint:isValidate()
  self._ui.txt_Description:isValidate()
  self._ui.txt_NotFind:isValidate()
  self._ui.stc_ProgressBG:isValidate()
  self._ui.CircularProgress:isValidate()
  self._ui.txt_FruitageValue:isValidate()
  self._ui.stc_GiftIcon:isValidate()
end
function PaGlobal_NpcNavi_Tooltip:resetUI()
  if nil == Panel_Tooltip_NpcNavigation_All then
    return
  end
  for _, control in pairs(self._ui) do
    control:SetShow(false)
  end
end
