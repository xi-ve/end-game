function PaGlobal_Command_All:initialize()
  if true == PaGlobal_Command_All._initialize then
    return
  end
  self._ui._stc_commandEffectBg = UI.getChildControl(Panel_MiniGame_Command_All, "Static_CommandEffect")
  self._ui._stc_resultPerfect = UI.getChildControl(Panel_MiniGame_Command_All, "Static_Result_Perfect")
  self._ui._stc_resultBad = UI.getChildControl(Panel_MiniGame_Command_All, "Static_Result_Bad")
  self._ui._stc_currectEffect0 = UI.getChildControl(Panel_MiniGame_Command_All, "Static_Eff_Currect_Eff0")
  self._ui._stc_timerBg = UI.getChildControl(Panel_MiniGame_Command_All, "Static_TimerGaugeBG")
  self._ui._stc_timerBar = UI.getChildControl(Panel_MiniGame_Command_All, "Progress2_Timer")
  self._ui._stc_resultSuccess = UI.getChildControl(Panel_MiniGame_Command_All, "Static_Result_Success")
  self._ui._stc_resultFailed = UI.getChildControl(Panel_MiniGame_Command_All, "Static_Result_Failed")
  self._ui._txt_fishGrade = UI.getChildControl(Panel_MiniGame_Command_All, "StaticText_FishGrade")
  self._ui._stc_commandBg = UI.getChildControl(Panel_MiniGame_Command_All, "StaticText_Title")
  for i = self._commandStartIndex, self._commandEndIndex do
    self._ui._txt_command[i] = UI.getChildControl(Panel_MiniGame_Command_All, "StaticText_Command_" .. i - 1)
  end
  self._commandInterval.x = math.floor(self._ui._stc_commandEffectBg:GetSizeX() / self._commandEndIndex)
  self._commandInterval.y = math.floor(self._ui._stc_commandEffectBg:GetSizeY() * 0.5)
  self._keyCommandSize.x = self._ui._txt_command[self._commandStartIndex]:GetSizeX()
  self._keyCommandSize.y = self._ui._txt_command[self._commandStartIndex]:GetSizeY()
  self._isConsole = _ContentsGroup_UsePadSnapping
  PaGlobal_Command_All:registEventHandler()
  PaGlobal_Command_All:validate()
  PaGlobal_Command_All._initialize = true
end
function PaGlobal_Command_All:registEventHandler()
  if nil == Panel_MiniGame_Command_All then
    return
  end
  if true == self._isConsole then
    registerEvent("EventActionMiniGamePadDownOnce", "PaGlobal_Command_All_CommandInputByPad")
  end
end
function PaGlobal_Command_All:prepareOpen()
  if nil == Panel_MiniGame_Command_All then
    return
  end
  if true == self._isConsole then
    ToClient_setAvailableInputWidget(false)
    PaGlobal_ConsoleQuickMenu:widgetClose()
  end
  PaGlobal_Command_All:open()
end
function PaGlobal_Command_All:open()
  if nil == Panel_MiniGame_Command_All then
    return
  end
  Panel_MiniGame_Command_All:SetShow(true)
end
function PaGlobal_Command_All:prepareClose()
  if nil == Panel_MiniGame_Command_All then
    return
  end
  PaGlobal_Command_All:close()
end
function PaGlobal_Command_All:close()
  if nil == Panel_MiniGame_Command_All then
    return
  end
  Panel_MiniGame_Command_All:SetShow(false)
end
function PaGlobal_Command_All:update()
  if nil == Panel_MiniGame_Command_All then
    return
  end
end
function PaGlobal_Command_All:validate()
  if nil == Panel_MiniGame_Command_All then
    return
  end
  self._ui._stc_commandEffectBg:isValidate()
  self._ui._stc_resultPerfect:isValidate()
  self._ui._stc_resultBad:isValidate()
  self._ui._stc_currectEffect0:isValidate()
  self._ui._stc_timerBg:isValidate()
  self._ui._stc_timerBar:isValidate()
  self._ui._stc_resultSuccess:isValidate()
  self._ui._stc_resultFailed:isValidate()
  self._ui._txt_fishGrade:isValidate()
  for i = self._commandStartIndex, self._commandEndIndex do
    self._ui._txt_command[i]:isValidate()
  end
end
function PaGlobal_Command_All:startGame()
  self:reposition()
  PaGlobal_Fishing_All_FishingCheck()
  self._fishCount = self:getFishCount()
  self._isCommandFinished = false
  self._ui._txt_fishGrade:SetShow(true)
  if self._fishCount > 0 and self._fishCount <= 2 then
    self._ui._txt_fishGrade:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_MINIGAME_FishGrade1"))
  elseif self._fishCount >= 3 and self._fishCount <= 4 then
    self._ui._txt_fishGrade:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_MINIGAME_FishGrade2"))
  elseif self._fishCount >= 5 and self._fishCount <= 7 then
    self._ui._txt_fishGrade:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_MINIGAME_FishGrade3"))
  elseif self._fishCount >= 8 and self._fishCount <= 9 then
    self._ui._txt_fishGrade:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_MINIGAME_FishGrade4"))
  elseif self._fishCount == 10 then
    self._ui._txt_fishGrade:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_MINIGAME_FishGrade5"))
  end
  self._ui._stc_resultFailed:ResetVertexAni()
  self._ui._stc_resultFailed:SetShow(false)
  self._ui._stc_resultFailed:SetAlpha(0)
  self._ui._stc_resultSuccess:ResetVertexAni()
  self._ui._stc_resultSuccess:SetShow(false)
  self._ui._stc_resultSuccess:SetAlpha(0)
  self._ui._stc_currectEffect0:ResetVertexAni()
  self._ui._stc_currectEffect0:SetShow(false)
  self._ui._stc_currectEffect0:SetAlpha(0)
  if true == self._isConsole then
    math.randomseed(getTickCount32())
  else
    math.randomseed(os.time())
  end
  self:createRandomText()
  self._currentCommandIndex = 1
  Panel_MiniGame_Command_All:RegisterUpdateFunc("Panel_Minigame_UpdateFunc")
  self._passedTimePerNext = 0
  self._ui._stc_resultBad:SetShow(false)
  self._ui._stc_resultPerfect:SetShow(false)
  local colorNo = math.random(0, 108)
  local randomAlpha = string.format("%.2f", math.random(75, 100) * 0.01)
  for index = self._commandStartIndex, self._commandEndIndex do
    local color = self._commandColor[colorNo]
    self._ui._txt_command[index]:SetShow(index <= self._fishCount)
    self._ui._txt_command[index]:SetFontColor(color)
    self._ui._txt_command[index]:SetColor(color)
    self._ui._txt_command[index]:SetFontAlpha(randomAlpha)
  end
  self:prepareOpen()
end
function PaGlobal_Command_All:endGame()
  self._ui._stc_commandEffectBg:EraseAllEffect()
  self._isCommandFinished = true
  Panel_MiniGame_Command_All:ClearUpdateLuaFunc()
  self:prepareClose()
end
function PaGlobal_Command_All:getFishCount()
  local fishCount = 0
  local fishGrade = getSelfPlayer():get():getFishGrade()
  local discountCommand = 0
  local fishLevel = getSelfPlayer():get():getLifeExperienceLevel(1)
  if 30 < fishLevel then
    local dice100 = math.random(0, 100)
    if fishLevel < 41 and dice100 < 10 then
      discountCommand = 1
    elseif 40 < fishLevel and fishLevel < 51 and dice100 < 15 then
      discountCommand = 2
    elseif 50 < fishLevel and fishLevel < 81 and dice100 < 20 then
      discountCommand = 3
    elseif 80 < fishLevel and dice100 < 25 then
      discountCommand = 4
    end
  end
  if fishGrade < 5 then
    local currCount = self._fishCommandCount[fishGrade]
    local minCount = currCount.min - discountCommand
    local maxCount = currCount.max - discountCommand
    minCount = math.max(2, minCount)
    maxCount = math.max(2, maxCount)
    fishCount = math.random(minCount, maxCount)
  else
    UI.ASSERT(false, "\234\183\184\235\160\136\236\157\180\235\147\156\234\176\128 \236\158\152\235\170\187 \235\147\164\236\150\180\236\153\148\236\138\181\235\139\136\235\139\164. \235\163\168\236\149\132\236\151\144\235\143\132 \235\172\188\234\179\160\234\184\176 \234\183\184\235\160\136\236\157\180\235\147\156\235\165\188 \235\176\148\234\191\148\236\163\188\236\132\184\236\154\148.")
  end
  return fishCount
end
function PaGlobal_Command_All:createRandomText()
  if getGamePadEnable() then
    self:createRandomText_pad()
  else
    self:createRandomText_key()
  end
end
function PaGlobal_Command_All:createRandomText_key()
  self._commands = {}
  local cmd, cmdText, textControl
  for index = self._commandStartIndex, self._fishCount do
    cmd = math.random(CppEnums.MiniGameKeyType.MiniGameKeyType_W, CppEnums.MiniGameKeyType.MiniGameKeyType_D)
    textControl = self._ui._txt_command[index]
    textControl:SetSize(self._keyCommandSize.x, self._keyCommandSize.y)
    textControl:ChangeTextureInfoName("New_UI_Common_forLua/widget/instance/MiniGame_00.dds")
    if CppEnums.MiniGameKeyType.MiniGameKeyType_W == cmd then
      cmdText = keyCustom_GetString_ActionKey(self._gameOptionActionKey.Forward)
      local x1, y1, x2, y2 = setTextureUV_Func(textControl, 400, 1, 426, 27)
      textControl:getBaseTexture():setUV(x1, y1, x2, y2)
      textControl:setRenderTexture(textControl:getBaseTexture())
    elseif CppEnums.MiniGameKeyType.MiniGameKeyType_S == cmd then
      cmdText = keyCustom_GetString_ActionKey(self._gameOptionActionKey.Back)
      local x1, y1, x2, y2 = setTextureUV_Func(textControl, 400, 28, 426, 54)
      textControl:getBaseTexture():setUV(x1, y1, x2, y2)
      textControl:setRenderTexture(textControl:getBaseTexture())
    elseif CppEnums.MiniGameKeyType.MiniGameKeyType_A == cmd then
      cmdText = keyCustom_GetString_ActionKey(self._gameOptionActionKey.Left)
      local x1, y1, x2, y2 = setTextureUV_Func(textControl, 373, 1, 399, 27)
      textControl:getBaseTexture():setUV(x1, y1, x2, y2)
      textControl:setRenderTexture(textControl:getBaseTexture())
    else
      cmdText = keyCustom_GetString_ActionKey(self._gameOptionActionKey.Right)
      local x1, y1, x2, y2 = setTextureUV_Func(textControl, 373, 28, 399, 54)
      textControl:getBaseTexture():setUV(x1, y1, x2, y2)
      textControl:setRenderTexture(textControl:getBaseTexture())
      cmd = CppEnums.MiniGameKeyType.MiniGameKeyType_D
    end
    textControl:SetText(cmdText)
    textControl:SetColor(Defines.Color.C_FFEFEFEF)
    textControl:SetFontColor(Defines.Color.C_FFEFEFEF)
    local gap = (self._commandInterval.x - textControl:GetSizeX()) * 0.5
    textControl:SetPosX((index - 1) * self._commandInterval.x + gap + 1)
    textControl:SetPosY(self._commandInterval.y)
    textControl:SetShow(true)
    self._commands[index] = cmd
  end
end
function PaGlobal_Command_All:createRandomText_pad()
  self._commands = {}
  local cmd, textControl
  for index = self._commandStartIndex, self._fishCount do
    cmd = math.random(CppEnums.MiniGameKeyType.MiniGameKeyType_W, CppEnums.MiniGameKeyType.MiniGameKeyType_D)
    textControl = self._ui._txt_command[index]
    textControl:SetSize(self._padCommandSize.x, self._padCommandSize.y)
    textControl:ChangeTextureInfoName("renewal/etc/minigame/console_etc_minigame_00.dds")
    textControl:SetText("")
    if CppEnums.MiniGameKeyType.MiniGameKeyType_W == cmd then
      local x1, y1, x2, y2 = setTextureUV_Func(textControl, 96, 417, 139, 460)
      textControl:getBaseTexture():setUV(x1, y1, x2, y2)
      textControl:setRenderTexture(textControl:getBaseTexture())
    elseif CppEnums.MiniGameKeyType.MiniGameKeyType_S == cmd then
      local x1, y1, x2, y2 = setTextureUV_Func(textControl, 140, 417, 183, 460)
      textControl:getBaseTexture():setUV(x1, y1, x2, y2)
      textControl:setRenderTexture(textControl:getBaseTexture())
    elseif CppEnums.MiniGameKeyType.MiniGameKeyType_A == cmd then
      local x1, y1, x2, y2 = setTextureUV_Func(textControl, 96, 461, 139, 504)
      textControl:getBaseTexture():setUV(x1, y1, x2, y2)
      textControl:setRenderTexture(textControl:getBaseTexture())
    else
      local x1, y1, x2, y2 = setTextureUV_Func(textControl, 140, 461, 183, 504)
      textControl:getBaseTexture():setUV(x1, y1, x2, y2)
      textControl:setRenderTexture(textControl:getBaseTexture())
      cmd = CppEnums.MiniGameKeyType.MiniGameKeyType_D
    end
    textControl:SetPosX(1 + index * self._commandInterval.x - (self._commandInterval.x + self._padCommandSize.x) * 0.5)
    textControl:SetPosY((self._ui._stc_commandBg:GetSizeY() - self._padCommandSize.y) * 0.5)
    textControl:SetShow(true)
    self._commands[index] = cmd
  end
end
function PaGlobal_Command_All:gameSuccess()
  audioPostEvent_SystemUi(11, 13)
  getSelfPlayer():get():SetMiniGameResult(2)
  self._isCommandFinished = true
  self._ui._stc_resultPerfect:ResetVertexAni()
  self._ui._stc_resultPerfect:SetVertexAniRun("Perfect_Ani", true)
  self._ui._stc_resultPerfect:SetVertexAniRun("Perfect_ScaleAni", true)
  self._ui._stc_resultPerfect:SetVertexAniRun("Perfect_AniEnd", true)
  self._ui._stc_resultFailed:ResetVertexAni()
  self._ui._stc_resultFailed:SetShow(false)
  self._ui._stc_resultSuccess:ResetVertexAni()
  self._ui._stc_resultSuccess:SetShow(true)
  self._ui._stc_resultSuccess:SetVertexAniRun("Ani_Scale_Result_Success_empty", true)
  self._ui._stc_resultSuccess:SetVertexAniRun("Ani_Scale_Result_Success", true)
  self._ui._stc_resultSuccess:SetVertexAniRun("Ani_Color_Result_Success_empty", true)
  self._ui._stc_resultSuccess:SetVertexAniRun("Ani_Color_Result_Success", true)
  self:endGame()
end
function PaGlobal_Command_All:gameFailed()
  audioPostEvent_SystemUi(11, 7)
  local textControl = self._ui._txt_command[self._currentCommandIndex]
  getSelfPlayer():get():SetMiniGameResult(0)
  self._isCommandFinished = true
  textControl:SetColor(Defines.Color.C_FFFF0000)
  textControl:SetFontColor(Defines.Color.C_FFFF0000)
  self._ui._stc_resultBad:ResetVertexAni()
  self._ui._stc_resultBad:SetVertexAniRun("Bad_Ani", true)
  self._ui._stc_resultBad:SetVertexAniRun("Bad_ScaleAni", true)
  self._ui._stc_resultBad:SetVertexAniRun("Bad_AniEnd", true)
  self._ui._stc_resultSuccess:ResetVertexAni()
  self._ui._stc_resultSuccess:SetShow(false)
  self._ui._stc_resultFailed:ResetVertexAni()
  self._ui._stc_resultFailed:SetShow(true)
  self._ui._stc_resultFailed:SetVertexAniRun("Ani_Scale_Result_Failed_empty", true)
  self._ui._stc_resultFailed:SetVertexAniRun("Ani_Scale_Result_Failed", true)
  self._ui._stc_resultFailed:SetVertexAniRun("Ani_Color_Result_Failed_empty", true)
  self._ui._stc_resultFailed:SetVertexAniRun("Ani_Color_Result_Failed", true)
end
function PaGlobal_Command_All:reposition()
  local pullRandomPos = function()
    local randomPos = math.random(0, 12)
    local randomPosMinus = math.random(0, 1)
    local setRandomPos
    if 0 == randomPosMinus then
      setRandomPos = randomPos
    else
      setRandomPos = randomPos * -1
    end
    return setRandomPos
  end
  Panel_MiniGame_Command_All:SetPosX(getOriginScreenSizeX() * 0.5 - Panel_MiniGame_Command_All:GetSizeX() * 0.5 + pullRandomPos())
  Panel_MiniGame_Command_All:SetPosY(350 + pullRandomPos())
end
function PaGlobal_Command_All:commandInput(keyType)
  if true == self._isCommandFinished then
    return
  end
  local textControl = self._ui._txt_command[self._currentCommandIndex]
  if keyType < CppEnums.MiniGameKeyType.MiniGameKeyType_W or keyType > CppEnums.MiniGameKeyType.MiniGameKeyType_D then
    return
  end
  if self._commands[self._currentCommandIndex] == keyType then
    audioPostEvent_SystemUi(11, 0)
    textControl:SetColor(Defines.Color.C_FF88DF00)
    textControl:SetFontColor(Defines.Color.C_FF88DF00)
    self._currentCommandIndex = self._currentCommandIndex + 1
    self._ui._stc_currectEffect0:SetShow(true)
    self._ui._stc_currectEffect0:EraseAllEffect()
    self._ui._stc_currectEffect0:AddEffect("UI_LevelUP_Skill", false, 0, -8)
    self._ui._stc_currectEffect0:AddEffect("fUI_LevelUP_Skill02", false, 0, -8)
    self._ui._stc_currectEffect0:SetPosX(textControl:GetPosX() - 23)
    self._ui._stc_currectEffect0:SetPosY(textControl:GetPosY() / 2 - 12)
    if self._fishCount < self._currentCommandIndex then
      self:gameSuccess()
    end
  else
    self:gameFailed()
  end
end
function PaGlobal_Command_All:updateText(deltaTime)
  if true == self._isCommandFinished then
    return
  end
  self._passedTimePerNext = self._passedTimePerNext + deltaTime
  local rate = self._passedTimePerNext * 0.18
  if 1 < rate then
    rate = 1
  end
  local progressValue = (1 - rate) * 100
  self._ui._stc_timerBar:SetProgressRate(progressValue)
  if 1 <= rate then
    self:gameFailed()
  end
end
