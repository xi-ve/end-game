local eLIFE = CppEnums.LifeExperienceType
function PaGlobal_CharInfoLife_All:initialize()
  if true == self._initialize then
    return
  end
  local subUIName_collect = {
    [1] = "Static_Water",
    [2] = "Static_Wood",
    [3] = "Static_Liquid",
    [4] = "Static_Hommy",
    [5] = "Static_Beef",
    [6] = "Static_Tanning",
    [7] = "Static_Mining"
  }
  local subUIName_Manufacture = {
    [1] = "Static_Shaking",
    [2] = "Static_Griding",
    [3] = "Static_Firewood",
    [4] = "Static_Drying",
    [5] = "Static_Thinout",
    [6] = "Static_Heating"
  }
  if false == _ContentsGroup_Barter then
    self._LIFETYPE_COUNT = self._LIFETYPE_COUNT - 1
    UI.getChildControl(Panel_CharacterInfoLife_All, "Static_Barter"):SetShow(false)
  end
  for idx = 0, self._LIFETYPE_COUNT - 1 do
    local lifeUI = {
      _parent = nil,
      _title = nil,
      _count = nil,
      _lv = nil,
      _lvExp = nil,
      _prog2 = nil,
      _subLifeType = nil
    }
    local parent
    if idx == eLIFE.gather then
      local stc_Gather = UI.getChildControl(Panel_CharacterInfoLife_All, "Static_Gather")
      local stc_Bg = UI.getChildControl(stc_Gather, "Static_BG")
      lifeUI._subLifeType = {}
      for subidx = 1, #subUIName_collect do
        local subUI = {
          _subParent = nil,
          subtitle = nil,
          _subLv = nil
        }
        subUI._subParent = UI.getChildControl(stc_Bg, subUIName_collect[subidx])
        subUI._subtitle = UI.getChildControl(subUI._subParent, "StaticText_SubTitle")
        subUI._subLv = UI.getChildControl(subUI._subParent, "StaticText_SubLevelCount")
        lifeUI._subLifeType[subidx] = subUI
      end
      parent = UI.getChildControl(stc_Gather, "Static_TopInfo")
    elseif idx == eLIFE.fishing then
      parent = UI.getChildControl(Panel_CharacterInfoLife_All, "Static_Fish")
    elseif idx == eLIFE.hunting then
      parent = UI.getChildControl(Panel_CharacterInfoLife_All, "Static_Hunting")
    elseif idx == eLIFE.cooking then
      parent = UI.getChildControl(Panel_CharacterInfoLife_All, "Static_Cook")
    elseif idx == eLIFE.alchemy then
      parent = UI.getChildControl(Panel_CharacterInfoLife_All, "Static_Alchemy")
    elseif idx == eLIFE.manufacture then
      local stc_Manufacter = UI.getChildControl(Panel_CharacterInfoLife_All, "Static_Manufacture")
      local stc_Bg = UI.getChildControl(stc_Manufacter, "Static_BG")
      lifeUI._subLifeType = {}
      for subidx = 1, #subUIName_Manufacture do
        local subUI = {
          _subParent = nil,
          _subtitle = nil,
          _subLv = nil
        }
        subUI._subParent = UI.getChildControl(stc_Bg, subUIName_Manufacture[subidx])
        subUI._subtitle = UI.getChildControl(subUI._subParent, "StaticText_SubTitle")
        subUI._subLv = UI.getChildControl(subUI._subParent, "StaticText_SubLevelCount")
        lifeUI._subLifeType[subidx] = subUI
      end
      parent = UI.getChildControl(stc_Manufacter, "Static_TopInfo")
    elseif idx == eLIFE.training then
      parent = UI.getChildControl(Panel_CharacterInfoLife_All, "Static_Horse")
    elseif idx == eLIFE.trade then
      parent = UI.getChildControl(Panel_CharacterInfoLife_All, "Static_Trade")
    elseif idx == eLIFE.growth then
      parent = UI.getChildControl(Panel_CharacterInfoLife_All, "Static_Growth")
    elseif idx == eLIFE.sail then
      parent = UI.getChildControl(Panel_CharacterInfoLife_All, "Static_Sail")
    elseif idx == eLIFE.barter and true == _ContentsGroup_Barter then
      parent = UI.getChildControl(Panel_CharacterInfoLife_All, "Static_Barter")
    end
    if nil ~= parent then
      lifeUI._parent = parent
      lifeUI._title = UI.getChildControl(parent, "StaticText_LifeTitle")
      lifeUI._count = UI.getChildControl(parent, "StaticText_LifeCount")
      lifeUI._lv = UI.getChildControl(parent, "StaticText_LifeLevel")
      lifeUI._lvExp = UI.getChildControl(parent, "StaticText_LifeLevelExp")
      lifeUI._prog2 = UI.getChildControl(parent, "Progress2_Exp")
      self._ui.stc_life[idx] = lifeUI
    end
  end
  self._ui.stc_BottomDesc = UI.getChildControl(Panel_CharacterInfoLife_All, "StaticText_BottomDesc")
  self._ui.stc_Console_KeyGuideBg = UI.getChildControl(Panel_CharacterInfoLife_All, "Static_Console_Buttons")
  self._ui.stc_KeyGuide_A = UI.getChildControl(self._ui.stc_Console_KeyGuideBg, "StaticText_A_ConsoleUI")
  self._ui.stc_KeyGuide_B = UI.getChildControl(self._ui.stc_Console_KeyGuideBg, "StaticText_B_ConsoleUI")
  self._ui.stc_KeyGuide_X = UI.getChildControl(self._ui.stc_Console_KeyGuideBg, "StaticText_X_ConsoleUI")
  self._ui.stc_KeyGuide_Y = UI.getChildControl(self._ui.stc_Console_KeyGuideBg, "StaticText_Y_ConsoleUI")
  self._isConsole = _ContentsGroup_UsePadSnapping
  self._selfPlayer = getSelfPlayer()
  UI.ASSERT_NAME(nil ~= self._selfPlayer, " Panel_CharacterInfo_Life_All_1.lua / getSelfPlayer() is nil", "\234\185\128\234\183\188\236\154\176")
  if nil == self._selfPlayer then
    return
  end
  self._ui.stc_Console_KeyGuideBg:SetShow(self._isConsole)
  self._ui.stc_KeyGuide_B:SetShow(self._isConsole)
  self._ui.stc_KeyGuide_X:SetShow(self._isConsole)
  self._ui.stc_KeyGuide_A:SetShow(false)
  self._ui.stc_KeyGuide_Y:SetShow(false)
  self._ui.stc_BottomDesc:SetTextMode(__eTextMode_AutoWrap)
  self._ui.stc_BottomDesc:SetText(self._ui.stc_BottomDesc:GetText())
  self._ui.stc_BottomDesc:SetShow(_ContentsGroup_EnhanceCollect)
  PaGlobal_CharInfoLife_All:validate()
  PaGlobal_CharInfoLife_All:registEventHandler(self._isConsole)
  PaGlobal_CharInfoLife_All:setUnChangedData()
  PaGlobal_CharInfoLife_All._initialize = true
end
function PaGlobal_CharInfoLife_All:registEventHandler(console)
  registerEvent("FromClient_UpdateSelfPlayerLifeExp", "PaGlobalFunc_CharInfoLife_All_Update")
end
function PaGlobal_CharInfoLife_All:setUnChangedData()
  for idx = 0, self._LIFETYPE_COUNT - 1 do
    if nil ~= self._ui.stc_life[idx] then
      self._ui.stc_life[idx]._title:SetText(CppEnums.LifeExperienceString[idx])
      self._ui.stc_life[idx]._parent:SetIgnore(false)
      if false == self._isConsole then
        self._ui.stc_life[idx]._parent:addInputEvent("Mouse_On", "HandleEventOnOut_CharInfoLife_All_LifeType_Tooltip(true," .. tostring(idx) .. ")")
        self._ui.stc_life[idx]._parent:addInputEvent("Mouse_Out", "HandleEventOnOut_CharInfoLife_All_LifeType_Tooltip(false)")
      elseif false == _ContentsGroup_RenewUI_Tooltip then
        self._ui.stc_life[idx]._parent:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandleEventOnOut_CharInfoLife_All_LifeType_Tooltip(true," .. tostring(idx) .. ")")
        self._ui.stc_life[idx]._parent:addInputEvent("Mouse_Out", "HandleEventOnOut_CharInfoLife_All_LifeType_Tooltip(false)")
      end
      if nil ~= self._ui.stc_life[idx]._subLifeType then
        for subidx = 1, #self._ui.stc_life[idx]._subLifeType do
          local stringTable
          if idx == eLIFE.gather then
            stringTable = self._SUBLIFE_COLLECT_STRING
          else
            stringTable = self._SUBLIFE_MANUFACTURE
          end
          if nil ~= stringTable then
            local sublifeType = self._ui.stc_life[idx]._subLifeType[subidx]
            sublifeType._subtitle:SetText(PAGetString(Defines.StringSheet_RESOURCE, stringTable[subidx]))
            if false == self._isConsole then
              self._ui.stc_life[idx]._subLifeType[subidx]._subtitle:SetIgnore(false)
              self._ui.stc_life[idx]._subLifeType[subidx]._subtitle:addInputEvent("Mouse_On", "HandleEventOnOut_CharInfoLife_All_LifeType_Tooltip(true," .. tostring(idx) .. "," .. tostring(subidx) .. ")")
              self._ui.stc_life[idx]._subLifeType[subidx]._subtitle:addInputEvent("Mouse_Out", "HandleEventOnOut_CharInfoLife_All_LifeType_Tooltip(false)")
            elseif false == _ContentsGroup_RenewUI_Tooltip then
              self._ui.stc_life[idx]._subLifeType[subidx]._subtitle:SetIgnore(true)
              self._ui.stc_life[idx]._subLifeType[subidx]._subParent:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandleEventOnOut_CharInfoLife_All_LifeType_Tooltip(true," .. tostring(idx) .. "," .. tostring(subidx) .. ")")
              self._ui.stc_life[idx]._subLifeType[subidx]._subParent:addInputEvent("Mouse_Out", "HandleEventOnOut_CharInfoLife_All_LifeType_Tooltip(false)")
            end
          end
        end
      end
    end
  end
end
function PaGlobal_CharInfoLife_All:update()
  for idx = 0, self._LIFETYPE_COUNT - 1 do
    if nil ~= self._ui.stc_life[idx] then
      local currentLevel = self._selfPlayer:get():getLifeExperienceLevel(idx)
      local currentExp64 = self._selfPlayer:get():getCurrLifeExperiencePoint(idx)
      local needExp64 = self._selfPlayer:get():getDemandLifeExperiencePoint(idx)
      local currentExpRate64 = currentExp64 * toInt64(0, 10000) / needExp64
      local currentExpRate = Int64toInt32(currentExpRate64)
      currentExpRate = currentExpRate / 100
      local currentExpRateString = string.format("%.2f", currentExpRate)
      local colorLifeLevel = PaGlobalFunc_Util_CraftLevelColorReplace(currentLevel)
      self._ui.stc_life[idx]._lv:SetText(colorLifeLevel)
      self._ui.stc_life[idx]._lvExp:SetText(currentExpRateString .. "%")
      self._ui.stc_life[idx]._prog2:SetProgressRate(currentExpRate)
      if true == _ContentsGroup_EnhanceCollect then
        if idx == eLIFE.gather or idx == eLIFE.manufacture then
          local commonPoint = ToClient_GetCommonLifeStat(idx)
          local commonPointString = PAGetString(Defines.StringSheet_GAME, "LUA_CHARINFO_COMMONLIFESTAT_SHORT") .. " " .. tostring(commonPoint)
          self._ui.stc_life[idx]._count:SetText(commonPointString)
        else
          local subPoint = self._selfPlayer:get():getLifeStat(idx, 1)
          local subPointString = PAGetString(Defines.StringSheet_GAME, "LUA_CHARINFO_COMMONLIFESTAT_SHORT") .. " " .. tostring(subPoint)
          self._ui.stc_life[idx]._count:SetText(subPointString)
        end
        if nil ~= self._ui.stc_life[idx]._subLifeType then
          for subidx = 1, #self._ui.stc_life[idx]._subLifeType do
            local subPoint = self._selfPlayer:get():getLifeStat(idx, subidx)
            self._ui.stc_life[idx]._subLifeType[subidx]._subLv:SetText(tostring(subPoint))
          end
        end
      else
        self._ui.stc_life[idx]._count:SetShow(false)
        if nil ~= self._ui.stc_life[idx]._subLifeType then
          for subidx = 1, #self._ui.stc_life[idx]._subLifeType do
            self._ui.stc_life[idx]._subLifeType[subidx]._subtitle:SetShow(false)
            self._ui.stc_life[idx]._subLifeType[subidx]._subLv:SetShow(false)
          end
        end
      end
    end
  end
end
function PaGlobal_CharInfoLife_All:validate()
  for idx = 0, self._LIFETYPE_COUNT - 1 do
    if nil ~= self._ui.stc_life[idx] then
      self._ui.stc_life[idx]._title:isValidate()
      self._ui.stc_life[idx]._count:isValidate()
      self._ui.stc_life[idx]._lv:isValidate()
      self._ui.stc_life[idx]._lvExp:isValidate()
      self._ui.stc_life[idx]._prog2:isValidate()
      if nil ~= self._ui.stc_life[idx]._subLifeType then
        for subidx = 1, #self._ui.stc_life[idx]._subLifeType do
          self._ui.stc_life[idx]._subLifeType[subidx]._subtitle:isValidate()
          self._ui.stc_life[idx]._subLifeType[subidx]._subLv:isValidate()
        end
      end
    end
  end
  self._ui.stc_BottomDesc:isValidate()
  self._ui.stc_Console_KeyGuideBg:isValidate()
  self._ui.stc_KeyGuide_A:isValidate()
  self._ui.stc_KeyGuide_B:isValidate()
  self._ui.stc_KeyGuide_X:isValidate()
  self._ui.stc_KeyGuide_Y:isValidate()
end
