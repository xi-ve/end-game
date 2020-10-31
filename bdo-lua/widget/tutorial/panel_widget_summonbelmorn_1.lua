function PaGlobal_SummonBelmorn:initialize()
  if true == PaGlobal_SummonBelmorn._initialize then
    return
  end
  self._ui._stc_faceLeft = UI.getChildControl(Panel_Widget_SummonBelmorn, "Static_FacePicture_Left")
  self._ui._stc_textBg = UI.getChildControl(Panel_Widget_SummonBelmorn, "Static_TextBg")
  self._ui._txt_characterName = UI.getChildControl(self._ui._stc_textBg, "StaticText_CharacterName")
  self._ui._txt_script = UI.getChildControl(self._ui._stc_textBg, "StaticText_Script")
  self._ui._txt_characterName:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_GMEVENT_NAME_NPC1"))
  self._ui._txt_script:SetTextMode(__eTextMode_AutoWrap)
  self:initBelmornData()
  PaGlobal_SummonBelmorn:registEventHandler()
  PaGlobal_SummonBelmorn:validate()
  PaGlobal_SummonBelmorn._initialize = true
end
function PaGlobal_SummonBelmorn:registEventHandler()
  if nil == Panel_Widget_SummonBelmorn then
    return
  end
  registerEvent("onScreenResize", "FromClient_SummonBelmorn_ScreenResize")
  ActionChartEventBindFunction(self._actionType.belmorn0, PaGloabl_SummonBelmorn_ActionChartBelmorn0)
  ActionChartEventBindFunction(self._actionType.belmorn1, PaGloabl_SummonBelmorn_ActionChartBelmorn1)
  ActionChartEventBindFunction(self._actionType.belmorn2, PaGloabl_SummonBelmorn_ActionChartBelmorn2)
  ActionChartEventBindFunction(self._actionType.belmorn3, PaGloabl_SummonBelmorn_ActionChartBelmorn3)
  ActionChartEventBindFunction(self._actionType.belmorn4, PaGloabl_SummonBelmorn_ActionChartBelmorn4)
  ActionChartEventBindFunction(self._actionType.belmorn5, PaGloabl_SummonBelmorn_ActionChartBelmorn5)
  ActionChartEventBindFunction(self._actionType.belmorn6, PaGloabl_SummonBelmorn_ActionChartBelmorn6)
end
function PaGlobal_SummonBelmorn:prepareOpen(currentAction)
  if nil == Panel_Widget_SummonBelmorn or nil == currentAction then
    return
  end
  self._currentStep = 0
  self._currentAction = currentAction
  self._currentDeltaTime = 0
  self._isStartStory = true
  self._nextDeltaTime = self._data[self._currentAction][self._currentStep]._viewTime
  Panel_Widget_SummonBelmorn:RegisterUpdateFunc("PaGlobal_SummonBelmorn_UpdatePerframe")
  PaGlobal_SummonBelmorn:open()
end
function PaGlobal_SummonBelmorn:open()
  if nil == Panel_Widget_SummonBelmorn then
    return
  end
  Panel_Widget_SummonBelmorn:SetShow(true)
end
function PaGlobal_SummonBelmorn:prepareClose()
  if nil == Panel_Widget_SummonBelmorn then
    return
  end
  Panel_Widget_SummonBelmorn:ClearUpdateLuaFunc()
  PaGlobal_SummonBelmorn:close()
end
function PaGlobal_SummonBelmorn:close()
  if nil == Panel_Widget_SummonBelmorn then
    return
  end
  Panel_Widget_SummonBelmorn:SetShow(false)
end
function PaGlobal_SummonBelmorn:update()
  if nil == Panel_Widget_SummonBelmorn then
    return
  end
end
function PaGlobal_SummonBelmorn:validate()
  if nil == Panel_Widget_SummonBelmorn then
    return
  end
end
function PaGlobal_SummonBelmorn:initBelmornData()
  self._data[self._actionType.belmorn0] = {
    [0] = {
      _desc = "",
      _isView = false,
      _viewTime = 3
    },
    [1] = {
      _desc = PAGetString(Defines.StringSheet_GAME, "LUA_GMEVENT_DESC_00_01"),
      _isView = true,
      _viewTime = 5
    },
    [2] = {
      _desc = "",
      _isView = false,
      _viewTime = 0.2
    },
    [3] = {
      _desc = PAGetString(Defines.StringSheet_GAME, "LUA_GMEVENT_DESC_00_02"),
      _isView = true,
      _viewTime = 5
    },
    [4] = {
      _desc = "",
      _isView = false,
      _viewTime = 0.2
    },
    [5] = {
      _desc = PAGetString(Defines.StringSheet_GAME, "LUA_GMEVENT_DESC_00_03"),
      _isView = true,
      _viewTime = 5
    },
    [6] = {
      _desc = "",
      _isView = false,
      _viewTime = 0.2
    },
    [7] = {
      _desc = PAGetString(Defines.StringSheet_GAME, "LUA_GMEVENT_DESC_00_04"),
      _isView = true,
      _viewTime = 5
    }
  }
  self._data[self._actionType.belmorn1] = {
    [0] = {
      _desc = "",
      _isView = false,
      _viewTime = 3
    },
    [1] = {
      _desc = PAGetString(Defines.StringSheet_GAME, "LUA_GMEVENT_DESC_01_01"),
      _isView = true,
      _viewTime = 5
    },
    [2] = {
      _desc = "",
      _isView = false,
      _viewTime = 0.2
    },
    [3] = {
      _desc = PAGetString(Defines.StringSheet_GAME, "LUA_GMEVENT_DESC_01_02"),
      _isView = true,
      _viewTime = 5
    },
    [4] = {
      _desc = "",
      _isView = false,
      _viewTime = 0.2
    },
    [5] = {
      _desc = PAGetString(Defines.StringSheet_GAME, "LUA_GMEVENT_DESC_01_03"),
      _isView = true,
      _viewTime = 5
    }
  }
  self._data[self._actionType.belmorn2] = {
    [0] = {
      _desc = "",
      _isView = false,
      _viewTime = 3
    },
    [1] = {
      _desc = PAGetString(Defines.StringSheet_GAME, "LUA_GMEVENT_DESC_02_01"),
      _isView = true,
      _viewTime = 5
    },
    [2] = {
      _desc = "",
      _isView = false,
      _viewTime = 0.2
    },
    [3] = {
      _desc = PAGetString(Defines.StringSheet_GAME, "LUA_GMEVENT_DESC_02_02"),
      _isView = true,
      _viewTime = 5
    }
  }
  self._data[self._actionType.belmorn3] = {
    [0] = {
      _desc = "",
      _isView = false,
      _viewTime = 3
    },
    [1] = {
      _desc = PAGetString(Defines.StringSheet_GAME, "LUA_GMEVENT_DESC_03_01"),
      _isView = true,
      _viewTime = 5
    },
    [2] = {
      _desc = "",
      _isView = false,
      _viewTime = 0.2
    },
    [3] = {
      _desc = PAGetString(Defines.StringSheet_GAME, "LUA_GMEVENT_DESC_03_02"),
      _isView = true,
      _viewTime = 5
    }
  }
  self._data[self._actionType.belmorn4] = {
    [0] = {
      _desc = "",
      _isView = false,
      _viewTime = 3
    },
    [1] = {
      _desc = PAGetString(Defines.StringSheet_GAME, "LUA_GMEVENT_DESC_04_01"),
      _isView = true,
      _viewTime = 5
    },
    [2] = {
      _desc = "",
      _isView = false,
      _viewTime = 0.2
    },
    [3] = {
      _desc = PAGetString(Defines.StringSheet_GAME, "LUA_GMEVENT_DESC_04_02"),
      _isView = true,
      _viewTime = 5
    }
  }
  self._data[self._actionType.belmorn5] = {
    [0] = {
      _desc = "",
      _isView = false,
      _viewTime = 3
    },
    [1] = {
      _desc = PAGetString(Defines.StringSheet_GAME, "LUA_GMEVENT_DESC_05_01"),
      _isView = true,
      _viewTime = 5
    },
    [2] = {
      _desc = "",
      _isView = false,
      _viewTime = 0.2
    },
    [3] = {
      _desc = PAGetString(Defines.StringSheet_GAME, "LUA_GMEVENT_DESC_05_02"),
      _isView = true,
      _viewTime = 5
    }
  }
  self._data[self._actionType.belmorn6] = {
    [0] = {
      _desc = "",
      _isView = false,
      _viewTime = 3
    },
    [1] = {
      _desc = PAGetString(Defines.StringSheet_GAME, "LUA_GMEVENT_DESC_06_01"),
      _isView = true,
      _viewTime = 5
    },
    [2] = {
      _desc = "",
      _isView = false,
      _viewTime = 0.2
    },
    [3] = {
      _desc = PAGetString(Defines.StringSheet_GAME, "LUA_GMEVENT_DESC_06_02"),
      _isView = true,
      _viewTime = 5
    },
    [4] = {
      _desc = "",
      _isView = false,
      _viewTime = 0.2
    },
    [5] = {
      _desc = PAGetString(Defines.StringSheet_GAME, "LUA_GMEVENT_DESC_06_03"),
      _isView = true,
      _viewTime = 5
    }
  }
end
function PaGlobal_SummonBelmorn:updateData(data)
  if false == data._isView then
    self:setShowAll(false)
    return
  end
  self:setShowAll(true)
  self._ui._txt_script:SetText(data._desc)
end
function PaGlobal_SummonBelmorn:updatePerframe(deltaTime)
  if false == self._isStartStory then
    self:prepareClose()
    return
  end
  if false == self:updateNextCheck(deltaTime) then
    return
  end
  self:updateData(self._data[self._currentAction][self._currentStep])
end
function PaGlobal_SummonBelmorn:updateNextCheck(deltaTime)
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
function PaGlobal_SummonBelmorn:setShowAll(isShow)
  for v, control in pairs(self._ui) do
    control:SetShow(isShow)
    control:ComputePos()
  end
end
