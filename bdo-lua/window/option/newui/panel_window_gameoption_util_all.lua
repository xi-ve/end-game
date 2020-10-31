function PaGlobal_GameOption_All:radioButtonMapping_TextureQuality(value, fromRadioButtonToCppEnum)
  local radioMap = {
    [0] = 2,
    [1] = 1,
    [2] = 0
  }
  return PaGlobal_GameOption_All:RadioButtonMapping(radioMap, value, fromRadioButtonToCppEnum)
end
function PaGlobal_GameOption_All:radioButtonMapping_GraphicOption(value, fromRadioButtonToCppEnum)
  local radioMap = {
    [0] = 5,
    [1] = 4,
    [2] = 3,
    [3] = 2,
    [4] = 1,
    [5] = 0,
    [6] = 6,
    [7] = 9,
    [8] = 8
  }
  return PaGlobal_GameOption_All:RadioButtonMapping(radioMap, value, fromRadioButtonToCppEnum)
end
PaGlobal_GameOption_All._isOnServiceResourceTypeTag = {
  [CppEnums.ServiceResourceType.eServiceResourceType_Dev] = PAGetString(Defines.StringSheet_GAME, "LUA_OPTION_TEXT_DEV"),
  [CppEnums.ServiceResourceType.eServiceResourceType_KR] = PAGetString(Defines.StringSheet_GAME, "LUA_OPTION_TEXT_KR"),
  [CppEnums.ServiceResourceType.eServiceResourceType_EN] = PAGetString(Defines.StringSheet_GAME, "LUA_OPTION_TEXT_EN"),
  [CppEnums.ServiceResourceType.eServiceResourceType_JP] = PAGetString(Defines.StringSheet_GAME, "LUA_OPTION_TEXT_JP"),
  [CppEnums.ServiceResourceType.eServiceResourceType_CN] = PAGetString(Defines.StringSheet_GAME, "LUA_OPTION_TEXT_CN"),
  [CppEnums.ServiceResourceType.eServiceResourceType_RU] = PAGetString(Defines.StringSheet_GAME, "LUA_OPTION_TEXT_RU"),
  [CppEnums.ServiceResourceType.eServiceResourceType_FR] = PAGetString(Defines.StringSheet_GAME, "LUA_OPTION_TEXT_FR"),
  [CppEnums.ServiceResourceType.eServiceResourceType_DE] = PAGetString(Defines.StringSheet_GAME, "LUA_OPTION_TEXT_DE"),
  [CppEnums.ServiceResourceType.eServiceResourceType_ES] = PAGetString(Defines.StringSheet_GAME, "LUA_OPTION_TEXT_ES"),
  [CppEnums.ServiceResourceType.eServiceResourceType_TW] = PAGetString(Defines.StringSheet_GAME, "LUA_OPTION_TEXT_TW"),
  [CppEnums.ServiceResourceType.eServiceResourceType_PT] = PAGetString(Defines.StringSheet_GAME, "LUA_OPTION_TEXT_PT"),
  [CppEnums.ServiceResourceType.eServiceResourceType_TH] = PAGetString(Defines.StringSheet_RESOURCE, "LUA_OPTION_TEXT_TH"),
  [CppEnums.ServiceResourceType.eServiceResourceType_ID] = PAGetString(Defines.StringSheet_RESOURCE, "LUA_OPTION_TEXT_ID"),
  [CppEnums.ServiceResourceType.eServiceResourceType_TR] = PAGetString(Defines.StringSheet_RESOURCE, "LUA_OPTION_TEXT_TR"),
  [CppEnums.ServiceResourceType.eServiceResourceType_SP] = PAGetString(Defines.StringSheet_GAME, "LUA_OPTION_TEXT_SP")
}
PaGlobal_GameOption_All._isOnServiceChatTypeTag = {
  [CppEnums.LangType.LangType_Dev] = PAGetString(Defines.StringSheet_GAME, "LUA_OPTION_TEXT_DEV"),
  [CppEnums.LangType.LangType_International] = PAGetString(Defines.StringSheet_RESOURCE, "LUA_OPTION_TEXT_INTERNATIONAL"),
  [CppEnums.LangType.LangType_English] = PAGetString(Defines.StringSheet_GAME, "LUA_OPTION_TEXT_EN"),
  [CppEnums.LangType.LangType_Jp] = PAGetString(Defines.StringSheet_GAME, "LUA_OPTION_TEXT_JP"),
  [CppEnums.LangType.LangType_Cn] = PAGetString(Defines.StringSheet_GAME, "LUA_OPTION_TEXT_CN"),
  [CppEnums.LangType.LangType_Ru] = PAGetString(Defines.StringSheet_GAME, "LUA_OPTION_TEXT_RU"),
  [CppEnums.LangType.LangType_French] = PAGetString(Defines.StringSheet_GAME, "LUA_OPTION_TEXT_FR"),
  [CppEnums.LangType.LangType_German] = PAGetString(Defines.StringSheet_GAME, "LUA_OPTION_TEXT_DE"),
  [CppEnums.LangType.LangType_Es] = PAGetString(Defines.StringSheet_GAME, "LUA_OPTION_TEXT_ES"),
  [CppEnums.LangType.LangType_Tw] = PAGetString(Defines.StringSheet_GAME, "LUA_OPTION_TEXT_TW"),
  [CppEnums.LangType.LangType_Pt] = PAGetString(Defines.StringSheet_GAME, "LUA_OPTION_TEXT_PT"),
  [CppEnums.LangType.LangType_TH] = PAGetString(Defines.StringSheet_RESOURCE, "LUA_OPTION_TEXT_TH"),
  [CppEnums.LangType.LangType_ID] = PAGetString(Defines.StringSheet_RESOURCE, "LUA_OPTION_TEXT_ID"),
  [CppEnums.LangType.LangType_TR] = PAGetString(Defines.StringSheet_RESOURCE, "LUA_OPTION_TEXT_TR"),
  [CppEnums.LangType.LangType_SP] = PAGetString(Defines.StringSheet_GAME, "LUA_OPTION_TEXT_SP"),
  [CppEnums.LangType.LangType_AE] = PAGetString(Defines.StringSheet_GAME, "LUA_OPTION_TEXT_AE")
}
function PaGlobal_GameOption_All:GetRadioButtonMap()
  local radioMap = {}
  if isGameTypeKorea() then
    radioMap = {
      [0] = CppEnums.ServiceResourceType.eServiceResourceType_KR,
      [1] = CppEnums.ServiceResourceType.eServiceResourceType_JP,
      [2] = CppEnums.ServiceResourceType.eServiceResourceType_EN
    }
  elseif isGameTypeJapan() then
    radioMap = {
      [0] = CppEnums.ServiceResourceType.eServiceResourceType_JP,
      [1] = CppEnums.ServiceResourceType.eServiceResourceType_KR,
      [2] = CppEnums.ServiceResourceType.eServiceResourceType_EN
    }
  elseif isGameTypeRussia() then
  elseif isGameTypeEnglish() then
    radioMap = {
      [0] = CppEnums.ServiceResourceType.eServiceResourceType_EN,
      [1] = CppEnums.ServiceResourceType.eServiceResourceType_JP,
      [2] = CppEnums.ServiceResourceType.eServiceResourceType_KR
    }
  elseif isGameTypeTaiwan() then
    radioMap = {
      [0] = CppEnums.ServiceResourceType.eServiceResourceType_TW,
      [1] = CppEnums.ServiceResourceType.eServiceResourceType_KR,
      [2] = CppEnums.ServiceResourceType.eServiceResourceType_JP,
      [3] = CppEnums.ServiceResourceType.eServiceResourceType_EN
    }
  elseif isGameTypeTR() then
    radioMap = {
      [0] = CppEnums.ServiceResourceType.eServiceResourceType_EN
    }
  elseif isGameTypeID() then
    radioMap = {
      [0] = CppEnums.ServiceResourceType.eServiceResourceType_EN
    }
  elseif isGameTypeTH() then
    radioMap = {
      [0] = CppEnums.ServiceResourceType.eServiceResourceType_EN
    }
  elseif isGameTypeGT() then
    radioMap = {
      [0] = CppEnums.ServiceResourceType.eServiceResourceType_EN,
      [1] = CppEnums.ServiceResourceType.eServiceResourceType_JP,
      [2] = CppEnums.ServiceResourceType.eServiceResourceType_KR,
      [3] = CppEnums.ServiceResourceType.eServiceResourceType_TW
    }
  end
  return radioMap
end
function PaGlobal_GameOption_All:GetServiceTypeRadioButtonMap()
  local radioMap = {
    [0] = CppEnums.ServiceResourceType.eServiceResourceType_EN,
    [1] = CppEnums.ServiceResourceType.eServiceResourceType_FR,
    [2] = CppEnums.ServiceResourceType.eServiceResourceType_ID,
    [3] = CppEnums.ServiceResourceType.eServiceResourceType_ES,
    [4] = CppEnums.ServiceResourceType.eServiceResourceType_SP
  }
  local resourceType = getGameServiceType()
  if CppEnums.GameServiceType.eGameServiceType_DEV == resourceType then
    radioMap = {
      [0] = CppEnums.ServiceResourceType.eServiceResourceType_EN,
      [1] = CppEnums.ServiceResourceType.eServiceResourceType_FR,
      [2] = CppEnums.ServiceResourceType.eServiceResourceType_ID,
      [3] = CppEnums.ServiceResourceType.eServiceResourceType_SP
    }
  elseif CppEnums.GameServiceType.eGameServiceType_NA_ALPHA == resourceType then
    radioMap = {
      [0] = CppEnums.ServiceResourceType.eServiceResourceType_EN,
      [1] = CppEnums.ServiceResourceType.eServiceResourceType_FR,
      [2] = CppEnums.ServiceResourceType.eServiceResourceType_DE,
      [3] = CppEnums.ServiceResourceType.eServiceResourceType_SP
    }
  elseif CppEnums.GameServiceType.eGameServiceType_NA_REAL == resourceType then
    radioMap = {
      [0] = CppEnums.ServiceResourceType.eServiceResourceType_EN,
      [1] = CppEnums.ServiceResourceType.eServiceResourceType_FR,
      [2] = CppEnums.ServiceResourceType.eServiceResourceType_DE,
      [3] = CppEnums.ServiceResourceType.eServiceResourceType_SP
    }
  elseif CppEnums.GameServiceType.eGameServiceType_SA_ALPHA == resourceType then
    radioMap = {
      [0] = CppEnums.ServiceResourceType.eServiceResourceType_PT,
      [1] = CppEnums.ServiceResourceType.eServiceResourceType_ES
    }
  elseif CppEnums.GameServiceType.eGameServiceType_SA_REAL == resourceType then
    radioMap = {
      [0] = CppEnums.ServiceResourceType.eServiceResourceType_PT,
      [1] = CppEnums.ServiceResourceType.eServiceResourceType_ES
    }
  elseif CppEnums.GameServiceType.eGameServiceType_ID_ALPHA == resourceType then
    radioMap = {
      [0] = CppEnums.ServiceResourceType.eServiceResourceType_ID,
      [1] = CppEnums.ServiceResourceType.eServiceResourceType_EN
    }
  elseif CppEnums.GameServiceType.eGameServiceType_ID_REAL == resourceType then
    radioMap = {
      [0] = CppEnums.ServiceResourceType.eServiceResourceType_ID,
      [1] = CppEnums.ServiceResourceType.eServiceResourceType_EN
    }
  elseif CppEnums.GameServiceType.eGameServiceType_TR_ALPHA == resourceType then
    radioMap = {
      [0] = CppEnums.ServiceResourceType.eServiceResourceType_TR,
      [1] = CppEnums.ServiceResourceType.eServiceResourceType_EN
    }
  elseif CppEnums.GameServiceType.eGameServiceType_TR_REAL == resourceType then
    radioMap = {
      [0] = CppEnums.ServiceResourceType.eServiceResourceType_TR,
      [1] = CppEnums.ServiceResourceType.eServiceResourceType_EN
    }
  elseif CppEnums.GameServiceType.eGameServiceType_GT_ALPHA == resourceType then
    radioMap = {
      [0] = CppEnums.ServiceResourceType.eServiceResourceType_TW,
      [1] = CppEnums.ServiceResourceType.eServiceResourceType_EN,
      [2] = CppEnums.ServiceResourceType.eServiceResourceType_KR
    }
  elseif CppEnums.GameServiceType.eGameServiceType_GT_REAL == resourceType then
    radioMap = {
      [0] = CppEnums.ServiceResourceType.eServiceResourceType_TW,
      [1] = CppEnums.ServiceResourceType.eServiceResourceType_EN,
      [2] = CppEnums.ServiceResourceType.eServiceResourceType_KR
    }
  end
  return radioMap
end
function PaGlobal_GameOption_All:GetChannelChatRadioButtonMap()
  local radioMap = {
    [0] = CppEnums.LangType.LangType_International,
    [1] = CppEnums.LangType.LangType_English,
    [2] = CppEnums.LangType.LangType_French,
    [3] = CppEnums.LangType.LangType_ID,
    [4] = CppEnums.LangType.LangType_SP
  }
  local resourceType = getGameServiceType()
  if CppEnums.GameServiceType.eGameServiceType_DEV == resourceType then
    radioMap = {
      [0] = CppEnums.LangType.LangType_International,
      [1] = CppEnums.LangType.LangType_English,
      [2] = CppEnums.LangType.LangType_French,
      [3] = CppEnums.LangType.LangType_ID,
      [4] = CppEnums.LangType.LangType_Es,
      [5] = CppEnums.LangType.LangType_AE
    }
  elseif CppEnums.GameServiceType.eGameServiceType_NA_ALPHA == resourceType then
    radioMap = {
      [0] = CppEnums.LangType.LangType_International,
      [1] = CppEnums.LangType.LangType_English,
      [2] = CppEnums.LangType.LangType_French,
      [3] = CppEnums.LangType.LangType_German,
      [4] = CppEnums.LangType.LangType_SP
    }
  elseif CppEnums.GameServiceType.eGameServiceType_NA_REAL == resourceType then
    radioMap = {
      [0] = CppEnums.LangType.LangType_International,
      [1] = CppEnums.LangType.LangType_English,
      [2] = CppEnums.LangType.LangType_French,
      [3] = CppEnums.LangType.LangType_German,
      [4] = CppEnums.LangType.LangType_SP
    }
  elseif CppEnums.GameServiceType.eGameServiceType_SA_ALPHA == resourceType then
    radioMap = {
      [0] = CppEnums.LangType.LangType_International,
      [1] = CppEnums.LangType.LangType_Pt,
      [2] = CppEnums.LangType.LangType_Es
    }
  elseif CppEnums.GameServiceType.eGameServiceType_SA_REAL == resourceType then
    radioMap = {
      [0] = CppEnums.LangType.LangType_International,
      [1] = CppEnums.LangType.LangType_Pt,
      [2] = CppEnums.LangType.LangType_Es
    }
  elseif CppEnums.GameServiceType.eGameServiceType_ID_ALPHA == resourceType then
    radioMap = {
      [0] = CppEnums.LangType.LangType_International,
      [1] = CppEnums.LangType.LangType_English,
      [2] = CppEnums.LangType.LangType_ID
    }
  elseif CppEnums.GameServiceType.eGameServiceType_ID_REAL == resourceType then
    radioMap = {
      [0] = CppEnums.LangType.LangType_International,
      [1] = CppEnums.LangType.LangType_ID,
      [2] = CppEnums.LangType.LangType_English
    }
  elseif CppEnums.GameServiceType.eGameServiceType_TR_ALPHA == resourceType then
    radioMap = {
      [0] = CppEnums.LangType.LangType_International,
      [1] = CppEnums.LangType.LangType_TR,
      [2] = CppEnums.LangType.LangType_English,
      [3] = CppEnums.LangType.LangType_AE
    }
  elseif CppEnums.GameServiceType.eGameServiceType_TR_REAL == resourceType then
    radioMap = {
      [0] = CppEnums.LangType.LangType_International,
      [1] = CppEnums.LangType.LangType_TR,
      [2] = CppEnums.LangType.LangType_English,
      [3] = CppEnums.LangType.LangType_AE
    }
  elseif CppEnums.GameServiceType.eGameServiceType_GT_REAL == resourceType or CppEnums.GameServiceType.eGameServiceType_GT_ALPHA == resourceType then
    radioMap = {
      [0] = CppEnums.LangType.LangType_International,
      [1] = CppEnums.LangType.LangType_English,
      [2] = CppEnums.LangType.LangType_Tw
    }
  end
  if _ContentsGroup_RenewUI then
    radioMap = {
      [0] = CppEnums.LangType.LangType_International,
      [1] = CppEnums.LangType.LangType_English,
      [2] = CppEnums.LangType.LangType_Jp,
      [3] = CppEnums.LangType.LangType_French,
      [4] = CppEnums.LangType.LangType_German,
      [5] = CppEnums.LangType.LangType_Es,
      [6] = CppEnums.LangType.LangType_Dev
    }
  end
  return radioMap
end
function PaGlobal_GameOption_All:radioButtonMapping_AudioResourceType(value, fromRadioButtonToCppEnum)
  local radioMap = self.GetRadioButtonMap()
  local val = PaGlobal_GameOption_All:RadioButtonMapping(radioMap, value, fromRadioButtonToCppEnum)
  if -1 == val then
    return 0
  end
  return val
end
function PaGlobal_GameOption_All:radioButtonMapping_ServiceResourceType(value, fromRadioButtonToCppEnum)
  local radioMap = self.GetServiceTypeRadioButtonMap()
  return PaGlobal_GameOption_All:RadioButtonMapping(radioMap, value, fromRadioButtonToCppEnum)
end
function PaGlobal_GameOption_All:radioButtonMapping_ChatChannelType(value, fromRadioButtonToCppEnum)
  local radioMap = self.GetChannelChatRadioButtonMap()
  return PaGlobal_GameOption_All:RadioButtonMapping(radioMap, value, fromRadioButtonToCppEnum)
end
function PaGlobal_GameOption_All:RadioButtonMapping(table, value, fromRadioButtonToCppEnum)
  if nil == fromRadioButtonToCppEnum or false == fromRadioButtonToCppEnum then
    return table[value]
  end
  for i, v in pairs(table) do
    if v == value then
      return i
    end
  end
  return -1
end
function PaGlobal_GameOption_All:GetControlTypeByControlName(controlName)
  local controlTypeEnum
  if "CheckButton" == controlName then
    controlTypeEnum = __ePAUIControl_CheckButton
  elseif "RadioButton" == controlName then
    controlTypeEnum = __ePAUIControl_RadioButton
  elseif "Slider" == controlName then
    controlTypeEnum = __ePAUIControl_Slider
  elseif "ComboBox" == controlName then
    controlTypeEnum = __ePAUIControl_ComboBox
  elseif "PageButton" == controlName then
    controlTypeEnum = __ePAUIControl_Button
  else
    controlTypeEnum = nil
  end
  return controlTypeEnum
end
function PaGlobal_GameOption_All:FromSliderValueToRealValue(value, min, max)
  function clamp(value, lower, upper)
    if upper < lower then
      lower, upper = upper, lower
    end
    return math.max(lower, math.min(upper, value))
  end
  value = clamp(value, 0, 1)
  local offset = max - min
  value = value * offset
  value = value + min
  return value
end
function PaGlobal_GameOption_All:FromRealValueToSliderValue(value, lower, upper)
  local offset = upper - lower
  value = value - lower
  value = value / offset
  return value
end
PaGlobal_GameOption_All._lutCaching = nil
function PaGlobal_GameOption_All:SetGraphicOption(value, isIncrease)
  local _SSAO = self._elements.SSAO
  local _AntiAliasing = self._elements.AntiAliasing
  local _Dof = self._elements.Dof
  local _Tessellation = self._elements.Tessellation
  local _LUT = self._elements.LUT
  if nil ~= _Tessellation._eventGroup then
    local button = UI.getChildControl(_Tessellation._eventGroup, "CheckButton_Template")
    local title = UI.getChildControl(_Tessellation._eventGroup, "StaticText_Title")
    local desc = UI.getChildControl(_Tessellation._eventGroup, "StaticText_Desc")
    if nil ~= button and nil ~= title and nil ~= desc then
      if self.GRAPHIC.VeryVeryLow == value or self.GRAPHIC.VeryLow == value or self.GRAPHIC.Low == value or self.GRAPHIC.Medium == value or self.GRAPHIC.High == value then
        button:SetIgnore(true)
        title:SetMonoTone(true)
        desc:SetMonoTone(true)
      elseif self.GRAPHIC.VeryHigh == value or self.GRAPHIC.VeryVeryHigh == value or self.GRAPHIC.UltraHigh == value or self.GRAPHIC.UltraLow == value then
        button:SetIgnore(false)
        title:SetMonoTone(false)
        desc:SetMonoTone(false)
      end
    end
  end
  if self.GRAPHIC.VeryVeryLow == value then
    _SSAO._curValue = false
    self:SetAntialiasingValue(0)
    _Dof._curValue = false
    _Tessellation._curValue = false
  elseif self.GRAPHIC.VeryLow == value then
    if true == isIncrease then
      _SSAO._curValue = true
      self:SetAntialiasingValue(1)
    elseif false == isIncrease then
      _Dof._curValue = false
      _Tessellation._curValue = false
    end
  elseif self.GRAPHIC.Low == value then
    if true == isIncrease then
      _SSAO._curValue = true
      self:SetAntialiasingValue(1)
    elseif false == isIncrease then
      _Dof._curValue = false
      _Tessellation._curValue = false
    end
  elseif self.GRAPHIC.Medium == value then
    if true == isIncrease then
      _SSAO._curValue = true
      self:SetAntialiasingValue(1)
    elseif false == isIncrease then
      _Dof._curValue = false
      _Tessellation._curValue = false
    end
  elseif self.GRAPHIC.High == value then
    if true == isIncrease then
      _SSAO._curValue = true
      self:SetAntialiasingValue(1)
      _Dof._curValue = true
      _Tessellation._curValue = false
    elseif false == isIncrease then
      _Tessellation._curValue = false
    end
  elseif self.GRAPHIC.VeryHigh == value then
    if true == isIncrease then
      _SSAO._curValue = true
      self:SetAntialiasingValue(1)
      _Dof._curValue = true
    end
  elseif (self.GRAPHIC.VeryVeryHigh == value or self.GRAPHIC.UltraHigh == value or self.GRAPHIC.UltraLow == value) and true == isIncrease then
    _SSAO._curValue = true
    self:SetAntialiasingValue(1)
    _Dof._curValue = true
  end
  if self.GRAPHIC.UltraHigh == value or self.GRAPHIC.UltraLow == value then
    if true == isIncrease then
      self._lutCaching = PaGlobal_GameOption_All:getOptionValue("LUT")
      _LUT._curValue = PaGlobal_GameOption_All:GetLUTIndex("NonContrast")
      self:SetAntialiasingValue(2)
    end
    self:SetAntiAliasingLevel2EnableSetting(true)
  else
    if nil ~= self._lutCaching then
      _LUT._curValue = self._lutCaching
    else
      local curGraphicOption = PaGlobal_GameOption_All:getOptionValue("GraphicOption")
      if self.GRAPHIC.UltraHigh == curGraphicOption or self.GRAPHIC.UltraLow == curGraphicOption then
        _LUT._curValue = PaGlobal_GameOption_All:GetLUTIndex("Vibrance")
      end
    end
    self:SetAntiAliasingLevel2EnableSetting(false)
  end
  if false == isIncrease and self.GRAPHIC.VeryVeryLow ~= value and self.GRAPHIC.UltraHigh ~= value and self.GRAPHIC.UltraLow ~= value then
    self:SetAntialiasingValue(1)
  end
  self:SetControlSetting(_SSAO, _SSAO._curValue)
  self:SetControlSetting(_AntiAliasing, _AntiAliasing._curValue)
  self:SetControlSetting(_Dof, _Dof._curValue)
  self:SetControlSetting(_Tessellation, _Tessellation._curValue)
  self:SetControlSetting(_LUT, _LUT._curValue)
end
function PaGlobal_GameOption_All:SetAntiAliasingLevel2EnableSetting(enable)
  if nil == self._elements.AntiAliasing then
    _PA_LOG("\237\155\132\236\167\132", "[SetControlSettingTable][ RETURN ] \235\157\188\235\148\148\236\152\164 \235\178\132\237\138\188 \236\187\168\237\138\184\235\161\164 (eventcontrol 1~x) \236\157\180 \236\160\149\236\131\129\236\160\129\236\156\188\235\161\156 \235\167\140\235\147\164\236\150\180\236\167\128\236\167\128 \236\149\138\236\149\152\236\138\181\235\139\136\235\139\164/ xml \235\157\188\235\148\148\236\152\164 \235\178\132\237\138\188 \236\133\139\237\140\133\236\157\132 \237\153\149\236\157\184\237\149\180\236\163\188\236\132\184\236\154\148 : " .. elementName)
    return
  end
  local option = self._elements.AntiAliasing
  for ii = 0, option._radioButtonMapping._count - 1 do
    if 2 == ii and nil ~= option._eventGroup then
      local radioButton = UI.getChildControl(option._eventGroup, "RadioButton_" .. tostring(ii))
      radioButton:SetIgnore(not enable)
      radioButton:SetMonoTone(not enable)
    end
  end
end
function PaGlobal_GameOption_All:SetAntialiasingValue(value)
  local _AntiAliasing = self._elements.AntiAliasing
  if 2 == value then
    if true == _ContentsGroup_AntiAliasing then
      _AntiAliasing._curValue = 2
    else
      _AntiAliasing._curValue = 1
    end
  else
    _AntiAliasing._curValue = value
  end
end
function PaGlobal_GameOption_All:SetSpecSetting(value)
  local PETRENDER = {
    ALL = 0,
    ONLYME = 1,
    NONE = 2
  }
  local options = self._elements
  if self.SPEC.LowNormal == value then
    options.GraphicOption._curValue = self.GRAPHIC.VeryLow
    self:SetGraphicOption(options.GraphicOption._curValue, false)
    options.TextureQuality._curValue = 0
    options.UseEffectFrameOptimization._curValue = true
    options.EffectFrameOptimization._curValue = 0.9
    options.UsePlayerEffectDistOptimization._curValue = true
    options.PlayerEffectDistOptimization._curValue = 0.9
    options.UseCharacterUpdateFrameOptimize._curValue = true
    options.UseOtherPlayerUpdate._curValue = true
    options.WorkerVisible._curValue = false
    options.PetRender._curValue = PETRENDER.NONE
  elseif self.SPEC.MidNormal == value then
    options.GraphicOption._curValue = self.GRAPHIC.Medium
    self:SetGraphicOption(options.GraphicOption._curValue, false)
    options.TextureQuality._curValue = 1
    options.UseEffectFrameOptimization._curValue = true
    options.EffectFrameOptimization._curValue = 0.6
    options.UsePlayerEffectDistOptimization._curValue = true
    options.PlayerEffectDistOptimization._curValue = 0.6
    options.UseCharacterUpdateFrameOptimize._curValue = true
    options.UseOtherPlayerUpdate._curValue = true
    options.WorkerVisible._curValue = false
    options.PetRender._curValue = PETRENDER.NONE
  elseif self.SPEC.HighNormal == value then
    options.GraphicOption._curValue = self.GRAPHIC.VeryHigh
    self:SetGraphicOption(options.GraphicOption._curValue, true)
    options.TextureQuality._curValue = 2
    options.UseEffectFrameOptimization._curValue = true
    options.EffectFrameOptimization._curValue = 0.3
    options.UsePlayerEffectDistOptimization._curValue = true
    options.PlayerEffectDistOptimization._curValue = 0.3
    options.UseCharacterUpdateFrameOptimize._curValue = true
    options.UseOtherPlayerUpdate._curValue = false
    options.WorkerVisible._curValue = false
    options.PetRender._curValue = PETRENDER.ONLYME
  elseif self.SPEC.HighestNormal == value then
    options.GraphicOption._curValue = self.GRAPHIC.VeryVeryHigh
    self:SetGraphicOption(options.GraphicOption._curValue, true)
    options.TextureQuality._curValue = 2
    options.UseEffectFrameOptimization._curValue = false
    options.UsePlayerEffectDistOptimization._curValue = false
    options.UseCharacterUpdateFrameOptimize._curValue = false
    options.UseOtherPlayerUpdate._curValue = false
    options.WorkerVisible._curValue = true
    options.PetRender._curValue = PETRENDER.ALL
  elseif self.SPEC.LowSiege == value then
    options.GraphicOption._curValue = self.GRAPHIC.VeryLow
    self:SetGraphicOption(options.GraphicOption._curValue, false)
    options.TextureQuality._curValue = 0
    options.UseEffectFrameOptimization._curValue = true
    options.EffectFrameOptimization._curValue = 1
    options.UsePlayerEffectDistOptimization._curValue = true
    options.PlayerEffectDistOptimization._curValue = 1
    options.UseCharacterUpdateFrameOptimize._curValue = true
    options.UseOtherPlayerUpdate._curValue = true
    options.WorkerVisible._curValue = false
    options.PetRender._curValue = PETRENDER.NONE
  elseif self.SPEC.MidSiege == value then
    options.GraphicOption._curValue = self.GRAPHIC.Medium
    self:SetGraphicOption(options.GraphicOption._curValue, false)
    options.TextureQuality._curValue = 1
    options.UseEffectFrameOptimization._curValue = true
    options.EffectFrameOptimization._curValue = 0.75
    options.UsePlayerEffectDistOptimization._curValue = true
    options.PlayerEffectDistOptimization._curValue = 0.75
    options.UseCharacterUpdateFrameOptimize._curValue = true
    options.UseOtherPlayerUpdate._curValue = true
    options.WorkerVisible._curValue = false
    options.PetRender._curValue = PETRENDER.NONE
  elseif self.SPEC.HighSiege == value then
    options.GraphicOption._curValue = self.GRAPHIC.VeryHigh
    self:SetGraphicOption(options.GraphicOption._curValue, true)
    options.TextureQuality._curValue = 2
    options.UseEffectFrameOptimization._curValue = true
    options.EffectFrameOptimization._curValue = 0.5
    options.UsePlayerEffectDistOptimization._curValue = true
    options.PlayerEffectDistOptimization._curValue = 0.5
    options.UseCharacterUpdateFrameOptimize._curValue = true
    options.UseOtherPlayerUpdate._curValue = true
    options.WorkerVisible._curValue = false
    options.PetRender._curValue = PETRENDER.ONLYME
  elseif self.SPEC.HighestSiege == value then
    options.GraphicOption._curValue = self.GRAPHIC.VeryVeryHigh
    self:SetGraphicOption(options.GraphicOption._curValue, true)
    options.TextureQuality._curValue = 2
    options.UseEffectFrameOptimization._curValue = true
    options.EffectFrameOptimization._curValue = 0.3
    options.UsePlayerEffectDistOptimization._curValue = true
    options.PlayerEffectDistOptimization._curValue = 0.3
    options.UseCharacterUpdateFrameOptimize._curValue = true
    options.UseOtherPlayerUpdate._curValue = false
    options.WorkerVisible._curValue = false
    options.PetRender._curValue = PETRENDER.ONLYME
  end
  self:ClickedConfirmOption()
  self:movePage(self.PAGE.Main)
end
function PaGlobal_GameOption_All:getWebLangTypeText()
  local UI_SERVICE_RESOURCE = CppEnums.ServiceResourceType
  local langType = "EN"
  if UI_SERVICE_RESOURCE.eServiceResourceType_EN == getGameServiceResType() then
    langType = "EN"
  elseif UI_SERVICE_RESOURCE.eServiceResourceType_FR == getGameServiceResType() then
    langType = "FR"
  elseif UI_SERVICE_RESOURCE.eServiceResourceType_DE == getGameServiceResType() then
    langType = "DE"
  elseif UI_SERVICE_RESOURCE.eServiceResourceType_ES == getGameServiceResType() then
    langType = "es"
  elseif UI_SERVICE_RESOURCE.eServiceResourceType_PT == getGameServiceResType() then
    langType = "pt"
  elseif UI_SERVICE_RESOURCE.eServiceResourceType_TR == getGameServiceResType() then
    langType = "TR"
  elseif UI_SERVICE_RESOURCE.eServiceResourceType_RU == getGameServiceResType() then
    langType = "RU"
  elseif UI_SERVICE_RESOURCE.eServiceResourceType_TH == getGameServiceResType() then
    langType = "TH"
  elseif UI_SERVICE_RESOURCE.eServiceResourceType_ID == getGameServiceResType() then
    langType = "ID"
  end
  return langType
end
local LUTRecommandation = -1
local LUTRecommandation2 = -1
local LUTRecommandationName = "Vibrance"
local LUTRecommandationName2 = "NonContrast"
function PaGlobal_GameOption_All:GetLUTIndex(str)
  for idx = 0, 30 do
    if getCameraLUTFilterName(idx) == str then
      return idx
    end
  end
  return nil
end
function PaGlobal_GameOption_All:SetRecommandationLUT()
  if LUTRecommandation == -1 then
    for idx = 0, 30 do
      if getCameraLUTFilterName(idx) == LUTRecommandationName then
        LUTRecommandation = idx
        LUTRecommandationName = nil
        break
      end
    end
  end
  local _contrastValue = 0.7
  if LUTRecommandation ~= -1 then
    self:setOptionValue("ContrastValue", _contrastValue)
    self:setOptionValue("LUT", LUTRecommandation)
    self._elements.LUT._curValue = LUTRecommandation
  end
end
function PaGlobal_GameOption_All:SetRecommandationLUT2()
  if LUTRecommandation2 == -1 then
    for idx = 0, 30 do
      if getCameraLUTFilterName(idx) == LUTRecommandationName2 then
        LUTRecommandation2 = idx
        LUTRecommandationName2 = nil
        break
      end
    end
  end
  local _contrastValue = 0.5
  if LUTRecommandation2 ~= -1 then
    self:setOptionValue("ContrastValue", _contrastValue)
    self:setOptionValue("LUT", LUTRecommandation2)
    self._elements.LUT._curValue = LUTRecommandation2
  end
end
