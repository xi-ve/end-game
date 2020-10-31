function PaGlobal_TopIcon_Maid:initialize()
  if true == PaGlobal_TopIcon_Maid._initialize then
    return
  end
  PaGlobal_TopIcon_Maid._ui.stc_Icon = UI.getChildControl(Panel_Widget_MaidIcon_Renew, "Static_MaidIcon_Template")
  if 0 < getTotalMaidList() and 7 <= getSelfPlayer():get():getLevel() then
    Panel_Widget_MaidIcon_Renew:SetShow(true)
    PaGlobal_TopIcon_Maid:addEffect()
    PaGlobalFunc_TopIcon_UpdatePos()
  end
  PaGlobal_TopIcon_Maid:registEventHandler()
  PaGlobal_TopIcon_Maid:validate()
  PaGlobal_TopIcon_Maid:onScreenResize()
  PaGlobal_TopIcon_Maid._initialize = true
end
function PaGlobal_TopIcon_Maid:registEventHandler()
  if nil == Panel_Widget_MaidIcon_Renew then
    return
  end
  registerEvent("FromClient_RefreshMaidList", "PaGlobalFunc_TopIcon_Maid_Update")
  registerEvent("FromClient_UpdateMaidCoolTime", "PaGlobalFunc_TopIcon_Maid_Update")
  registerEvent("onScreenResize", "PaGlobalFunc_TopIcon_Maid_Resize")
end
function PaGlobal_TopIcon_Maid:prepareOpen()
  if nil == Panel_Widget_MaidIcon_Renew then
    return
  end
  PaGlobal_TopIcon_Maid:open()
end
function PaGlobal_TopIcon_Maid:open()
  if nil == Panel_Widget_MaidIcon_Renew then
    return
  end
  PaGlobalFunc_TopIcon_Show(TopWidgetIconType.Maid)
end
function PaGlobal_TopIcon_Maid:prepareClose()
  if nil == Panel_Widget_MaidIcon_Renew then
    return
  end
  PaGlobal_TopIcon_Maid:close()
end
function PaGlobal_TopIcon_Maid:close()
  if nil == Panel_Widget_MaidIcon_Renew then
    return
  end
  PaGlobalFunc_TopIcon_Exit(TopWidgetIconType.Maid)
end
function PaGlobal_TopIcon_Maid:update()
  if nil == Panel_Widget_MaidIcon_Renew then
    return
  end
  if isFlushedUI() then
    return
  end
  PaGlobal_TopIcon_Maid:prepareClose()
  if 0 < getTotalMaidList() and 7 <= getSelfPlayer():get():getLevel() then
    PaGlobal_TopIcon_Maid:prepareOpen()
    PaGlobal_TopIcon_Maid:addEffect()
    PaGlobalFunc_TopIcon_UpdatePos()
  end
end
function PaGlobal_TopIcon_Maid:addEffect()
  PaGlobal_TopIcon_Maid._ui.stc_Icon:EraseAllEffect()
  local allMaidInCool, someMaidInCool = PaGlobal_TopIcon_Maid:maidCoolTime()
  if allMaidInCool then
    PaGlobal_TopIcon_Maid._ui.stc_Icon:AddEffect("fUI_Maid_02A", true, 0, 0)
  elseif someMaidInCool then
    PaGlobal_TopIcon_Maid._ui.stc_Icon:AddEffect("fUI_Maid_01A", true, 0, 0)
  end
end
function PaGlobal_TopIcon_Maid:maidCoolTime()
  if nil == getSelfPlayer() then
    return
  end
  local count = getTotalMaidList()
  local allMaidInCool = true
  local someMaidInCool = false
  for index = 0, count - 1 do
    local maidInfoWrapper = getMaidDataByIndex(index)
    if nil ~= maidInfoWrapper then
      local coolTime = maidInfoWrapper:getCoolTime()
      if 0 < coolTime then
        someMaidInCool = true
      else
        allMaidInCool = false
      end
    end
  end
  return allMaidInCool, someMaidInCool
end
function PaGlobal_TopIcon_Maid:validate()
  if nil == Panel_Widget_MaidIcon_Renew then
    return
  end
  PaGlobal_TopIcon_Maid._ui.stc_Icon:isValidate()
end
function PaGlobal_TopIcon_Maid:onScreenResize()
  local posY = Panel_SelfPlayerExpGage:GetPosY() + Panel_SelfPlayerExpGage:GetSizeY() + 4
  Panel_Widget_MaidIcon_Renew:SetPosY(posY)
end
