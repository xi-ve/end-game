function PaGlobal_TopIcon_Summon:initialize()
  if true == PaGlobal_TopIcon_Summon._initialize then
    return
  end
  PaGlobal_TopIcon_Summon._ui.stc_Icon = UI.getChildControl(Panel_Widget_SummonIcon_Renew, "Static_SummonIcon_Template")
  PaGlobal_TopIcon_Summon._ui.progress_Hp = UI.getChildControl(Panel_Widget_SummonIcon_Renew, "CircularProgress_Hp")
  PaGlobal_TopIcon_Summon._ui.progress_Mp = UI.getChildControl(Panel_Widget_SummonIcon_Renew, "CircularProgress_Mp")
  PaGlobal_TopIcon_Summon:registEventHandler()
  PaGlobal_TopIcon_Summon:validate()
  PaGlobal_TopIcon_Summon:onScreenResize()
  PaGlobal_TopIcon_Summon._initialize = true
end
function PaGlobal_TopIcon_Summon:registEventHandler()
  if nil == Panel_Widget_SummonIcon_Renew then
    return
  end
  registerEvent("EventSelfServantUpdate", "PaGlobalFunc_TopIcon_Summon_Update")
  registerEvent("FromClient_SummonChanged", "PaGlobalFunc_TopIcon_Summon_Update")
  registerEvent("FromClient_SummonAddList", "PaGlobalFunc_TopIcon_Summon_Update")
  registerEvent("FromClient_SummonDelList", "PaGlobalFunc_TopIcon_Summon_Update")
  registerEvent("onScreenResize", "PaGlobalFunc_TopIcon_Summon_Resize")
end
function PaGlobal_TopIcon_Summon:prepareOpen()
  if nil == Panel_Widget_SummonIcon_Renew then
    return
  end
  PaGlobal_TopIcon_Summon:update()
  PaGlobal_TopIcon_Summon:open()
end
function PaGlobal_TopIcon_Summon:open()
  if nil == Panel_Widget_SummonIcon_Renew then
    return
  end
  PaGlobalFunc_TopIcon_Show(TopWidgetIconType.Summon)
end
function PaGlobal_TopIcon_Summon:prepareClose()
  if nil == Panel_Widget_SummonIcon_Renew then
    return
  end
  PaGlobal_TopIcon_Summon:close()
end
function PaGlobal_TopIcon_Summon:close()
  if nil == Panel_Widget_SummonIcon_Renew then
    return
  end
  PaGlobalFunc_TopIcon_Exit(TopWidgetIconType.Summon)
end
function PaGlobal_TopIcon_Summon:update()
  if nil == Panel_Widget_SummonIcon_Renew then
    return
  end
  PaGlobal_TopIcon_Summon:close()
  local summonCount = getSelfPlayer():getSummonListCount()
  for summonIdx = 0, summonCount - 1 do
    local summonInfo = getSelfPlayer():getSummonDataByIndex(summonIdx)
    local characterKey = summonInfo:getCharacterKey()
    if 60028 <= characterKey and characterKey <= 60037 or 60068 == characterKey then
      local summonWrapper = summonInfo:getActor()
      local hpRate = 0
      local mpRate = 0
      if nil == summonWrapper then
        hpRate = 50
        mpRate = 50
      else
        local hp = summonWrapper:get():getHp()
        local maxHp = summonWrapper:get():getMaxHp()
        local mp = summonWrapper:get():getMp()
        local maxMp = summonWrapper:get():getMaxMp()
        if maxHp == 0 then
          hpRate = 50
        else
          hpRate = hp / maxHp * 50
        end
        if maxMp == 0 then
          mpRate = 50
        else
          mpRate = mp / maxMp * 50
        end
      end
      PaGlobal_TopIcon_Summon:open()
      PaGlobal_TopIcon_Summon._ui.progress_Hp:SetShow(true)
      PaGlobal_TopIcon_Summon._ui.progress_Mp:SetShow(true)
      PaGlobal_TopIcon_Summon._ui.progress_Hp:SetProgressRate(hpRate)
      PaGlobal_TopIcon_Summon._ui.progress_Mp:SetProgressRate(mpRate)
      break
    end
  end
  PaGlobalFunc_TopIcon_UpdatePos()
end
function PaGlobal_TopIcon_Summon:validate()
  if nil == Panel_Widget_SummonIcon_Renew then
    return
  end
  PaGlobal_TopIcon_Summon._ui.stc_Icon:isValidate()
end
function PaGlobal_TopIcon_Summon:onScreenResize()
  local posY = Panel_SelfPlayerExpGage:GetPosY() + Panel_SelfPlayerExpGage:GetSizeY() + 4
  Panel_Widget_SummonIcon_Renew:SetPosY(posY)
end
