function PaGlobal_ServantSummonBoss:initialize()
  if true == PaGlobal_ServantSummonBoss._initialize then
    return
  end
  self._ui._stc_progressBG = UI.getChildControl(Panel_Widget_ServantSummonBoss, "Static_ProgressBG")
  self._ui._stc_progressBar = UI.getChildControl(self._ui._stc_progressBG, "Progress2_HP")
  self._ui._txt_hp = UI.getChildControl(self._ui._stc_progressBG, "StaticText_HP")
  self._ui._txt_hp:SetShow(false)
  self._ui._stc_commandBG = UI.getChildControl(Panel_Widget_ServantSummonBoss, "Static_CommandBG")
  self._ui._stc_moveTitle = UI.getChildControl(self._ui._stc_commandBG, "StaticText_MoveTitle")
  self._ui._stc_attackTitle = UI.getChildControl(self._ui._stc_commandBG, "StaticText_AttackTitle")
  self._ui._stc_stackGroup_crio = UI.getChildControl(Panel_Widget_ServantSummonBoss, "Static_StackGroup_Crio")
  for i = self._eStack.stack1, self._eStack.loopCount do
    self._ui._stc_stackIcon_crio[i] = UI.getChildControl(self._ui._stc_stackGroup_crio, "Static_StackIcon_Crio" .. i)
  end
  self._ui._stc_stackGroup_papu = UI.getChildControl(Panel_Widget_ServantSummonBoss, "Static_StackGroup_Papu")
  for i = self._eStack.stack1, self._eStack.loopCount do
    self._ui._stc_stackIcon_papu[i] = UI.getChildControl(self._ui._stc_stackGroup_papu, "Static_StackIcon_Papu" .. i)
  end
  for ii = 1, self._MAX_MOVE_COUNT do
    self._ui._moveList[ii] = UI.createAndCopyBasePropertyControl(self._ui._stc_commandBG, "StaticText_MoveBasic", self._ui._stc_commandBG, "StaticText_MoveBasic_" .. ii)
    self._ui._moveList[ii]:SetShow(false)
  end
  for ii = 1, self._MAX_ATTACK_COUNT do
    self._ui._attackList[ii] = UI.createAndCopyBasePropertyControl(self._ui._stc_commandBG, "StaticText_AttackBasic", self._ui._stc_commandBG, "StaticText_AttackBasic_" .. ii)
    self._ui._attackList[ii]:SetShow(false)
  end
  self._ui._stc_stackGroup_crio:SetShow(false)
  self._ui._stc_stackGroup_papu:SetShow(false)
  self:registEventHandler()
  self:validate()
  self._initialize = true
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  local selfProxy = getSelfPlayer():get()
  if nil == selfProxy then
    return
  end
  local actorKeyRaw = selfProxy:getRideVehicleActorKeyRaw()
  if nil == actorKeyRaw then
    return
  end
  local vehicleProxy = getVehicleActor(actorKeyRaw)
  if nil == vehicleProxy then
    return
  end
  local vehicleType = vehicleProxy:get():getVehicleType()
  if CppEnums.VehicleType.Type_BossMonster == vehicleType then
    PaGlobal_ServantSummonBoss_Open()
  end
end
function PaGlobal_ServantSummonBoss:registEventHandler()
  if nil == Panel_Widget_ServantSummonBoss then
    return
  end
  self._ui._stc_progressBG:addInputEvent("Mouse_On", "HandleEventOn_ServantSummonBoss_HpBar()")
  self._ui._stc_progressBG:addInputEvent("Mouse_Out", "HandleEventOut_ServantSummonBoss_HpBar()")
  registerEvent("EventSelfServantUpdate", "FromClient_ServantSummonBoss_EventSelfServantUpdate")
  registerEvent("EventSelfServantUpdateOnlyHp", "FromClient_ServantSummonBoss_EventSelfServantUpdate")
  registerEvent("EventSelfPlayerRideOff", "FromClient_ServantSummonBoss_EventSelfPlayerRideOff")
  registerEvent("EventSelfPlayerRideOn", "FromClient_ServantSummonBoss_EventSelfPlayerRideOn")
  registerEvent("EventSelfPlayerCarrierChanged", "FromClient_ServantSummonBoss_EventSelfPlayerCarrierChanged")
  registerEvent("FromClient_RenderModeChangeState", "FromClient_ServantSummonBoss_RenderModeChangeState")
  ActionChartEventBindFunction(551, FromAction_ServantSummonBoss_StackRemoveCrio)
  ActionChartEventBindFunction(552, FromAction_ServantSummonBoss_Stack1Crio)
  ActionChartEventBindFunction(553, FromAction_ServantSummonBoss_Stack2Crio)
  ActionChartEventBindFunction(554, FromAction_ServantSummonBoss_Stack3Crio)
  ActionChartEventBindFunction(555, FromAction_ServantSummonBoss_StackRemovePapu)
  ActionChartEventBindFunction(556, FromAction_ServantSummonBoss_Stack1Papu)
  ActionChartEventBindFunction(557, FromAction_ServantSummonBoss_Stack2Papu)
  ActionChartEventBindFunction(558, FromAction_ServantSummonBoss_Stack3Papu)
  ActionChartEventBindFunction(559, FromAction_ServantSummonBoss_CrioStackActive)
  ActionChartEventBindFunction(560, FromAction_ServantSummonBoss_CrioStackDisable)
  ActionChartEventBindFunction(561, FromAction_ServantSummonBoss_PapuStackActive)
  ActionChartEventBindFunction(562, FromAction_ServantSummonBoss_PapuStackDisable)
end
function PaGlobal_ServantSummonBoss:prepareOpen()
  if nil == Panel_Widget_ServantSummonBoss then
    return
  end
  if false == _ContentsGroup_ServantSummonMonster or false == _ContentsGroup_ServantSummonMonster_InWar then
    return
  end
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  local selfProxy = getSelfPlayer():get()
  if nil == selfProxy then
    return
  end
  local actorKeyRaw = selfProxy:getRideVehicleActorKeyRaw()
  if nil == actorKeyRaw then
    return
  end
  local vehicleProxy = getVehicleActor(actorKeyRaw)
  if nil == vehicleProxy then
    return
  end
  local vehicleType = vehicleProxy:get():getVehicleType()
  if CppEnums.VehicleType.Type_BossMonster ~= vehicleType then
    return
  end
  self._isShowSkillCommand = false
  if nil ~= Panel_SkillCommand and true == Panel_SkillCommand:GetShow() then
    self._isShowSkillCommand = true
    Panel_SkillCommand:SetShow(false)
  end
  self._ui._stc_commandBG:SetShow(false)
  self:commandTextSet()
  self:update()
  self:open()
end
function PaGlobal_ServantSummonBoss:open()
  if nil == Panel_Widget_ServantSummonBoss then
    return
  end
  Panel_Widget_ServantSummonBoss:SetShow(true)
end
function PaGlobal_ServantSummonBoss:prepareClose()
  if nil == Panel_Widget_ServantSummonBoss then
    return
  end
  if true == self._isShowSkillCommand and nil ~= Panel_SkillCommand then
    Panel_SkillCommand:SetShow(true)
  end
  for ii = 1, self._MAX_MOVE_COUNT do
    self._ui._moveList[ii]:SetShow(false)
  end
  for ii = 1, self._MAX_ATTACK_COUNT do
    self._ui._attackList[ii]:SetShow(false)
  end
  self._ui._stc_stackGroup_crio:SetShow(false)
  self._ui._stc_stackGroup_papu:SetShow(false)
  self:close()
end
function PaGlobal_ServantSummonBoss:close()
  if nil == Panel_Widget_ServantSummonBoss then
    return
  end
  Panel_Widget_ServantSummonBoss:SetShow(false)
end
function PaGlobal_ServantSummonBoss:update()
  if nil == Panel_Widget_ServantSummonBoss then
    return
  end
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  local selfProxy = getSelfPlayer():get()
  if nil == selfProxy then
    return
  end
  local actorKeyRaw = selfProxy:getRideVehicleActorKeyRaw()
  if nil == actorKeyRaw then
    return
  end
  local vehicleProxy = getVehicleActor(actorKeyRaw)
  if nil == vehicleProxy then
    return
  end
  local vehicleType = vehicleProxy:get():getVehicleType()
  self._ui._stc_progressBar:SetProgressRate(vehicleProxy:get():getHp() / vehicleProxy:get():getMaxHp() * 100)
  self._ui._txt_hp:SetText(PAGetStringParam2(Defines.StringSheet_GAME, "LUA_SERVANT_HPBAR_LIFE", "getHp", makeDotMoney(vehicleProxy:get():getHp()), "getMaxHp", makeDotMoney(vehicleProxy:get():getMaxHp())))
end
function PaGlobal_ServantSummonBoss:validate()
  if nil == Panel_Widget_ServantSummonBoss then
    return
  end
  self._ui._stc_progressBG:isValidate()
  self._ui._stc_progressBar:isValidate()
end
function PaGlobal_ServantSummonBoss:commandTextSet()
  if nil == Panel_Widget_ServantSummonBoss then
    return
  end
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  local selfProxy = getSelfPlayer():get()
  if nil == selfProxy then
    return
  end
  local actorKeyRaw = selfProxy:getRideVehicleActorKeyRaw()
  if nil == actorKeyRaw then
    return
  end
  local vehicleProxy = getVehicleActor(actorKeyRaw)
  if nil == vehicleProxy then
    return
  end
  local getBossKey = vehicleProxy:getCharacterKey()
  local bossIndex = 0
  local moveCnt = 0
  local attackCnt = 0
  for index = 1, #self._bossInfo do
    if self._bossInfo[index]._actorkey == getBossKey then
      bossIndex = index
      moveCnt = #self._bossInfo[index]._moveText
      attackCnt = #self._bossInfo[index]._attackText
    end
  end
  if 0 == bossIndex then
    return
  end
  self._ui._stc_attackTitle:SetText(self._attackTitleStr)
  for index = 1, #self._motionTitleMonsterKey do
    if self._motionTitleMonsterKey[index] == getBossKey then
      self._ui._stc_attackTitle:SetText(self._motionTitleStr)
      break
    end
  end
  local lastSpanY = self._ui._stc_moveTitle:GetSpanSize().y
  local maxSizeX = 0
  if 0 < moveCnt then
    self._ui._stc_moveTitle:SetShow(true)
    for ii = 1, moveCnt do
      self._ui._moveList[ii]:SetShow(true)
      self._ui._moveList[ii]:SetText(self._bossInfo[bossIndex]._moveText[ii])
      self._ui._moveList[ii]:SetSpanSize(self._ui._moveList[ii]:GetSpanSize().x, lastSpanY + 20)
      lastSpanY = self._ui._moveList[ii]:GetSpanSize().y
      if maxSizeX < self._ui._moveList[ii]:GetTextSizeX() then
        maxSizeX = self._ui._moveList[ii]:GetTextSizeX()
      end
    end
  else
    self._ui._stc_moveTitle:SetShow(false)
  end
  if 0 < attackCnt then
    self._ui._stc_attackTitle:SetShow(true)
    self._ui._stc_attackTitle:SetSpanSize(self._ui._stc_attackTitle:GetSpanSize().x, lastSpanY + 20)
    lastSpanY = lastSpanY + 20
    for ii = 1, attackCnt do
      self._ui._attackList[ii]:SetShow(true)
      self._ui._attackList[ii]:SetText(self._bossInfo[bossIndex]._attackText[ii])
      self._ui._attackList[ii]:SetSpanSize(self._ui._attackList[ii]:GetSpanSize().x, lastSpanY + 20)
      lastSpanY = self._ui._attackList[ii]:GetSpanSize().y
      if maxSizeX < self._ui._attackList[ii]:GetTextSizeX() then
        maxSizeX = self._ui._attackList[ii]:GetTextSizeX()
      end
    end
  else
    self._ui._stc_attackTitle:SetShow(false)
  end
  local titleSizeY = 20
  if true == self._ui._stc_moveTitle:GetShow() then
    titleSizeY = titleSizeY + self._ui._stc_moveTitle:GetTextSizeY()
  end
  if true == self._ui._stc_attackTitle:GetShow() then
    titleSizeY = titleSizeY + self._ui._stc_attackTitle:GetTextSizeY()
  end
  if moveCnt <= 0 and attackCnt <= 0 then
    self._ui._stc_commandBG:SetShow(false)
    return
  end
  self._ui._stc_commandBG:ComputePos()
  self._ui._stc_commandBG:SetShow(true)
  self._ui._stc_commandBG:SetSize(maxSizeX + 30, titleSizeY + (moveCnt + attackCnt) * 20)
end
function PaGlobal_ServantSummonBoss:updateCrioStack(eStack)
  self:updateDefalutCrioStack()
  if self._eStack.non == eStack then
    return
  end
  for i = self._eStack.stack1, eStack do
    local x1, y1, x2, y2 = setTextureUV_Func(self._ui._stc_stackIcon_crio[i], self._crio_active.x1, self._crio_active.y1, self._crio_active.x2, self._crio_active.y2)
    self._ui._stc_stackIcon_crio[i]:getBaseTexture():setUV(x1, y1, x2, y2)
    self._ui._stc_stackIcon_crio[i]:setRenderTexture(self._ui._stc_stackIcon_crio[i]:getBaseTexture())
  end
end
function PaGlobal_ServantSummonBoss:updatePapuStack(eStack)
  self:updateDefalutPapuStack()
  if self._eStack.non == eStack then
    return
  end
  for i = self._eStack.stack1, eStack do
    local x1, y1, x2, y2 = setTextureUV_Func(self._ui._stc_stackIcon_papu[i], self._papu_active.x1, self._papu_active.y1, self._papu_active.x2, self._papu_active.y2)
    self._ui._stc_stackIcon_papu[i]:getBaseTexture():setUV(x1, y1, x2, y2)
    self._ui._stc_stackIcon_papu[i]:setRenderTexture(self._ui._stc_stackIcon_papu[i]:getBaseTexture())
  end
end
function PaGlobal_ServantSummonBoss:updateDefalutCrioStack()
  for i = self._eStack.stack1, self._eStack.loopCount do
    local x1, y1, x2, y2 = setTextureUV_Func(self._ui._stc_stackIcon_crio[i], self._crio_disable.x1, self._crio_disable.y1, self._crio_disable.x2, self._crio_disable.y2)
    self._ui._stc_stackIcon_crio[i]:getBaseTexture():setUV(x1, y1, x2, y2)
    self._ui._stc_stackIcon_crio[i]:setRenderTexture(self._ui._stc_stackIcon_crio[i]:getBaseTexture())
  end
end
function PaGlobal_ServantSummonBoss:updateDefalutPapuStack()
  for i = self._eStack.stack1, self._eStack.loopCount do
    local x1, y1, x2, y2 = setTextureUV_Func(self._ui._stc_stackIcon_papu[i], self._papu_disable.x1, self._papu_disable.y1, self._papu_disable.x2, self._papu_disable.y2)
    self._ui._stc_stackIcon_papu[i]:getBaseTexture():setUV(x1, y1, x2, y2)
    self._ui._stc_stackIcon_papu[i]:setRenderTexture(self._ui._stc_stackIcon_papu[i]:getBaseTexture())
  end
end
