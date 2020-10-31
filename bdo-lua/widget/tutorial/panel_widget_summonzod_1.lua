function PaGlobal_SummonZod:initialize()
  if true == PaGlobal_SummonZod._initialize then
    return
  end
  self._ui._stc_faceLeft = UI.getChildControl(Panel_Widget_SummonZod, "Static_FacePicture_Left")
  self._ui._stc_faceRight = UI.getChildControl(Panel_Widget_SummonZod, "Static_FacePicture_Right")
  self._ui._stc_textBg = UI.getChildControl(Panel_Widget_SummonZod, "Static_TextBg")
  self._ui._txt_characterName = UI.getChildControl(self._ui._stc_textBg, "StaticText_CharacterName")
  self._ui._txt_script = UI.getChildControl(self._ui._stc_textBg, "StaticText_Script")
  self:initZodData()
  PaGlobal_SummonZod:registEventHandler()
  PaGlobal_SummonZod:validate()
  PaGlobal_SummonZod._initialize = true
end
function PaGlobal_SummonZod:registEventHandler()
  if nil == Panel_Widget_SummonZod then
    return
  end
  registerEvent("onScreenResize", "FromClient_SummonZod_ScreenResize")
  ActionChartEventBindFunction(self._actionType.zod, PaGloabl_SummonZod_ActionChartZod)
end
function PaGlobal_SummonZod:prepareOpen()
  if nil == Panel_Widget_SummonZod then
    return
  end
  self._currentStep = 0
  self._currentDeltaTime = 0
  self._isStartStory = true
  self._nextDeltaTime = self._data[self._currentAction][self._currentStep]._viewTime
  Panel_Widget_SummonZod:RegisterUpdateFunc("PaGlobal_SummonZod_UpdatePerframe")
  PaGlobal_SummonZod:open()
end
function PaGlobal_SummonZod:open()
  if nil == Panel_Widget_SummonZod then
    return
  end
  Panel_Widget_SummonZod:SetShow(true)
end
function PaGlobal_SummonZod:prepareClose()
  if nil == Panel_Widget_SummonZod then
    return
  end
  Panel_Widget_SummonZod:ClearUpdateLuaFunc()
  PaGlobal_SummonZod:close()
end
function PaGlobal_SummonZod:close()
  if nil == Panel_Widget_SummonZod then
    return
  end
  Panel_Widget_SummonZod:SetShow(false)
end
function PaGlobal_SummonZod:update()
  if nil == Panel_Widget_SummonZod then
    return
  end
end
function PaGlobal_SummonZod:validate()
  if nil == Panel_Widget_SummonZod then
    return
  end
end
function PaGlobal_SummonZod:initZodData()
  self._data[self._actionType.zod] = {
    [0] = {
      _path = {
        _x1 = 0,
        _y1 = 0,
        _x2 = 0,
        _y2 = 0
      },
      _isLeft = true,
      _name = "",
      _desc = "",
      _isView = false,
      _viewTime = 3
    },
    [1] = {
      _path = {
        _x1 = 308,
        _y1 = 1,
        _x2 = 678,
        _y2 = 251
      },
      _isLeft = true,
      _name = PAGetString(Defines.StringSheet_GAME, "LUA_SUMMONZOD_NAME_NPC1"),
      _desc = PAGetString(Defines.StringSheet_GAME, "LUA_SUMMONZOD_DESC_01"),
      _isView = true,
      _viewTime = 5
    },
    [2] = {
      _path = {
        _x1 = 0,
        _y1 = 0,
        _x2 = 0,
        _y2 = 0
      },
      _isLeft = true,
      _name = "",
      _desc = "",
      _isView = false,
      _viewTime = 0.2
    },
    [3] = {
      _path = {
        _x1 = 679,
        _y1 = 1,
        _x2 = 914,
        _y2 = 172
      },
      _isLeft = false,
      _name = PAGetString(Defines.StringSheet_GAME, "LUA_SUMMONZOD_NAME_NPC2"),
      _desc = PAGetString(Defines.StringSheet_GAME, "LUA_SUMMONZOD_DESC_02"),
      _isView = true,
      _viewTime = 5
    },
    [4] = {
      _path = {
        _x1 = 0,
        _y1 = 0,
        _x2 = 0,
        _y2 = 0
      },
      _isLeft = true,
      _name = "",
      _desc = "",
      _isView = false,
      _viewTime = 0.2
    },
    [5] = {
      _path = {
        _x1 = 308,
        _y1 = 1,
        _x2 = 678,
        _y2 = 251
      },
      _isLeft = true,
      _name = PAGetString(Defines.StringSheet_GAME, "LUA_SUMMONZOD_NAME_NPC1"),
      _desc = PAGetString(Defines.StringSheet_GAME, "LUA_SUMMONZOD_DESC_03"),
      _isView = true,
      _viewTime = 5
    },
    [6] = {
      _path = {
        _x1 = 0,
        _y1 = 0,
        _x2 = 0,
        _y2 = 0
      },
      _isLeft = true,
      _name = "",
      _desc = "",
      _isView = false,
      _viewTime = 0.2
    },
    [7] = {
      _path = {
        _x1 = 679,
        _y1 = 1,
        _x2 = 914,
        _y2 = 172
      },
      _isLeft = false,
      _name = PAGetString(Defines.StringSheet_GAME, "LUA_SUMMONZOD_NAME_NPC2"),
      _desc = PAGetString(Defines.StringSheet_GAME, "LUA_SUMMONZOD_DESC_04"),
      _isView = true,
      _viewTime = 5
    }
  }
end
function PaGlobal_SummonZod:startZod()
  if false == ToClient_IsDevelopment() and (true == isGameTypeGT() or true == isGameTypeKorea() or true == isGameTypeKR2()) then
    return
  end
  self._currentAction = self._actionType.zod
  self:prepareOpen()
end
function PaGlobal_SummonZod:updateData(data)
  if false == data._isView then
    self:setShowAll(false)
    return
  end
  self:setShowAll(true)
  self._ui._stc_faceLeft:SetShow(data._isLeft)
  self._ui._stc_faceRight:SetShow(not data._isLeft)
  if data._isLeft then
    local x1, y1, x2, y2 = setTextureUV_Func(self._ui._stc_faceLeft, data._path._x1, data._path._y1, data._path._x2, data._path._y2)
    self._ui._stc_faceLeft:getBaseTexture():setUV(x1, y1, x2, y2)
    self._ui._stc_faceLeft:setRenderTexture(self._ui._stc_faceLeft:getBaseTexture())
  else
    local x1, y1, x2, y2 = setTextureUV_Func(self._ui._stc_faceRight, data._path._x1, data._path._y1, data._path._x2, data._path._y2)
    self._ui._stc_faceRight:getBaseTexture():setUV(x1, y1, x2, y2)
    self._ui._stc_faceRight:setRenderTexture(self._ui._stc_faceRight:getBaseTexture())
  end
  self._ui._txt_characterName:SetText(data._name)
  self._ui._txt_script:SetText(data._desc)
end
function PaGlobal_SummonZod:updatePerframe(deltaTime)
  if false == self._isStartStory then
    self:prepareClose()
    return
  end
  if false == self:updateNextCheck(deltaTime) then
    return
  end
  self:updateData(self._data[self._currentAction][self._currentStep])
end
function PaGlobal_SummonZod:updateNextCheck(deltaTime)
  if nil == self._data[self._currentAction] then
    self._isStartStory = false
    return false
  end
  local currentStep = self._data[self._currentAction][self._currentStep]
  if nil == currentStep then
    self._isStartStory = false
    return false
  end
  self._currentDeltaTime = self._currentDeltaTime + deltaTime
  if self._nextDeltaTime < self._currentDeltaTime then
    self._currentStep = self._currentStep + 1
    local nextStep = self._data[self._currentAction][self._currentStep]
    if nil == nextStep then
      self._isStartStory = false
      return false
    end
    self._currentDeltaTime = 0
    self._nextDeltaTime = nextStep._viewTime
  end
  return true
end
function PaGlobal_SummonZod:setShowAll(isShow)
  for v, control in pairs(self._ui) do
    control:SetShow(isShow)
    control:ComputePos()
  end
end
