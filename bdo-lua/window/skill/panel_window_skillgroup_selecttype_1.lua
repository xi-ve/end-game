function PaGlobal_SkillGroup_SelectType:init()
  self._isConsole = _ContentsGroup_RenewUI
  self:controlInit_All()
  self:registEventHandler()
end
function PaGlobal_SkillGroup_SelectType:controlInit_All()
  self._panel = Panel_Window_SkillGroup_SelectType
  local ui = self._ui
  ui._stc_centerMainArea = UI.getChildControl(Panel_Window_SkillGroup_SelectType, "Static_CenterMainArea")
  ui._stc_bottomBG = UI.getChildControl(ui._stc_centerMainArea, "Static_BottomBG")
  ui._stc_bottomSkillArea = UI.getChildControl(ui._stc_centerMainArea, "Static_BottomSkillArea")
  ui._stc_bottomSkillAreaBg = UI.getChildControl(ui._stc_centerMainArea, "Static_BottomSkillAreaBgTextrue")
  ui._stc_bigCharacter = UI.getChildControl(ui._stc_centerMainArea, "Static_BigCharacter")
  ui._stc_skillTypeTop = UI.getChildControl(ui._stc_centerMainArea, "Static_SkillTypeTop")
  ui._stc_skillTypeBottom = UI.getChildControl(ui._stc_centerMainArea, "Static_SkillTypeBottom")
  ui._stc_skillTypeLine = UI.getChildControl(ui._stc_centerMainArea, "Static_SkillTypeLine")
  ui._txt_title = UI.getChildControl(ui._stc_skillTypeTop, "StaticText_Title")
  ui._txt_desc = UI.getChildControl(ui._stc_skillTypeTop, "StaticText_Desc")
  ui._stc_horizonLineTop = UI.getChildControl(ui._stc_skillTypeLine, "Static_HorizonLineTop")
  ui._stc_horizonLineBottom = UI.getChildControl(ui._stc_skillTypeLine, "Static_HorizonLineBottom")
  ui._stc_combatTypeTitle = UI.getChildControl(ui._stc_skillTypeBottom, "StaticText_CombatTypeTitle")
  ui._stc_Dot1 = UI.getChildControl(ui._stc_skillTypeBottom, "Static_Dot1")
  ui._stc_Dot2 = UI.getChildControl(ui._stc_skillTypeBottom, "Static_Dot2")
  ui._txt_weaponTypeTitle = UI.getChildControl(ui._stc_skillTypeBottom, "StaticText_WeaponTypeTitle")
  ui._txt_weaponTypeValue = UI.getChildControl(ui._stc_skillTypeBottom, "StaticText_WeaponTypeValue")
  ui._txt_combatTypeTitle = UI.getChildControl(ui._stc_skillTypeBottom, "StaticText_CombatTypeTitle")
  ui._txt_combatTypeValue = UI.getChildControl(ui._stc_skillTypeBottom, "StaticText_CombatTypeValue")
  ui._txt_skillName = UI.getChildControl(ui._stc_bottomSkillArea, "StaticText_SkillName")
  ui._txt_skillPoint = UI.getChildControl(ui._stc_bottomSkillArea, "StaticText_SkillPoint")
  ui._stc_skillSlotBg = UI.getChildControl(ui._stc_bottomSkillArea, "Static_SkillSlotBG")
  ui._stc_skillSlot = UI.getChildControl(ui._stc_skillSlotBg, "Static_Slot")
  ui._btn_confirm = UI.getChildControl(ui._stc_bottomBG, "Button_Confirm")
  ui._btn_cancel = UI.getChildControl(ui._stc_bottomBG, "Button_Cancel")
  ui._txt_learnSkill = UI.getChildControl(ui._stc_bottomSkillArea, "StaticText_FrontSkill")
  self._originBottomAreaPosY = ui._stc_bottomSkillArea:GetPosY()
  self._originBottomBgPosY = ui._stc_bottomBG:GetPosY()
  self._originCenterMainAreaSizeY = ui._stc_centerMainArea:GetSizeY()
end
function PaGlobal_SkillGroup_SelectType:registEventHandler()
  local ui = self._ui
  ui._btn_cancel:addInputEvent("Mouse_LUp", "PaGlobal_SkillGroup_SelectType:close()")
end
function PaGlobal_SkillGroup_SelectType:close()
  Panel_SkillTooltip_Hide()
  self._panel:SetShow(false)
end
function PaGlobal_SkillGroup_SelectType:show()
  self._panel:SetShow(true)
end
function PaGlobal_SkillGroup_SelectType:selectTree(selectTreeType)
  local selectedParam = PaGlobal_SkillGroup._selectedTree
  local function resetSkill()
    local playerSkillType = ToClient_GetCurrentPlayerSkillType()
    PaGlobal_SkillGroup._isChangingTree = selectedParam
    local selfPlayer = getSelfPlayer():get()
    if nil == selfPlayer then
      return
    end
    local skillPointInfo = ToClient_getSkillPointInfo(0)
    if nil == skillPointInfo then
      return
    end
    self._remainSkillPoint = skillPointInfo._remainPoint
    if skillPointInfo._remainPoint == skillPointInfo._acquirePoint and __eSkillTypeParam_Awaken == selectedParam and __eSkillTypeParam_Normal == playerSkillType then
      PaGlobal_SkillGroup:clearTree()
      PaGlobal_SkillGroup:selectTree(selectTreeType - 1)
    else
      ToClient_SkillWindow_ClearSkill(0)
    end
    PaGlobal_SkillGroup_SelectType:close()
  end
  local closePanel = function()
    PaGlobal_SkillGroup_SelectType:close()
  end
  if __eSkillTypeParam_Normal ~= selectedParam and selectTreeType ~= selectedParam then
    local messageBoxData = {
      content = "",
      functionYes = resetSkill,
      functionNo = closePanel,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    if __eSkillTypeParam_Inherit == selectedParam then
      messageBoxData.content = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_OTHER_SELECT", "type", PAGetString(Defines.StringSheet_GAME, "LUA_AWAKEN"))
    elseif __eSkillTypeParam_Awaken == selectedParam then
      messageBoxData.content = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_OTHER_SELECT", "type", PAGetString(Defines.StringSheet_GAME, "LUA_SUCCESSION"))
    end
    MessageBox.showMessageBox(messageBoxData)
  else
    PaGlobal_SkillGroup:selectTree(selectTreeType - 1)
    self:close()
  end
end
function PaGlobal_SkillGroup_SelectType:setType(selectTreeType)
  local ui = self._ui
  local currentData = self._treeTypeDataList[selectTreeType]
  ui._txt_title:SetText(PAGetString(Defines.StringSheet_RESOURCE, currentData._title))
  ui._txt_weaponTypeTitle:SetText(PAGetString(Defines.StringSheet_GAME, currentData._weaponType))
  ui._stc_skillTypeTop:ChangeTextureInfoName(self._texturePath)
  ui._stc_skillTypeBottom:ChangeTextureInfoName(self._texturePath)
  local x1, y1, x2, y2 = setTextureUV_Func(ui._stc_skillTypeTop, currentData._uv.x1, currentData._uv.y1, currentData._uv.x2, currentData._uv.y2)
  ui._stc_skillTypeTop:getBaseTexture():setUV(x1, y1, x2, y2)
  ui._stc_skillTypeTop:setRenderTexture(ui._stc_skillTypeTop:getBaseTexture())
  ui._stc_skillTypeTop:SetShow(true)
  local x1, y1, x2, y2 = setTextureUV_Func(ui._stc_skillTypeBottom, currentData._uv.x1, currentData._uv.y1, currentData._uv.x2, currentData._uv.y2)
  ui._stc_skillTypeBottom:getBaseTexture():setUV(x1, y1, x2, y2)
  ui._stc_skillTypeBottom:setRenderTexture(ui._stc_skillTypeBottom:getBaseTexture())
  ui._stc_skillTypeBottom:SetShow(true)
  ui._btn_confirm:SetText(PAGetString(Defines.StringSheet_RESOURCE, currentData._title))
  ui._btn_confirm:addInputEvent("Mouse_LUp", "PaGlobal_SkillGroup_SelectType:selectTree(" .. selectTreeType .. ")")
end
function PaGlobal_SkillGroup_SelectType:setClass(playerClassType, selectTreeType, skillNo)
  self:setType(selectTreeType)
  self:setSkill(skillNo)
  UI.ASSERT(nil ~= self._classDataList[playerClassType], "self._classDataList[" .. tostring(playerClassType) .. "]\236\157\180 \236\151\134\236\138\181\235\139\136\235\139\164. \236\139\160\234\183\156\236\186\144\235\166\173\237\132\176 \235\141\176\236\157\180\237\132\176\235\165\188 Panel_Window_SkillGroup_SelectType.lua\236\151\144 \236\182\148\234\176\128\237\149\180\236\163\188\236\132\184\236\154\148.")
  local currentData
  if nil == self._classDataList[playerClassType] then
    currentData = self._classDataList[__eClassType_Warrior][selectTreeType]
  else
    currentData = self._classDataList[playerClassType][selectTreeType]
  end
  local ui = self._ui
  self._panel:SetSize(getScreenSizeX(), getScreenSizeY())
  self._panel:SetPosX(0)
  self._panel:SetPosY(0)
  ui._txt_weaponTypeTitle:SetSize(ui._txt_weaponTypeTitle:GetTextSizeX(), ui._txt_weaponTypeTitle:GetTextSizeY())
  ui._txt_combatTypeTitle:SetSize(ui._txt_combatTypeTitle:GetTextSizeX(), ui._txt_combatTypeTitle:GetTextSizeY())
  ui._stc_bigCharacter:ChangeTextureInfoName(currentData._texture)
  ui._txt_weaponTypeValue:SetText(PAGetString(Defines.StringSheet_GAME, currentData._weaponType))
  ui._txt_combatTypeValue:SetText(PAGetString(Defines.StringSheet_GAME, currentData._combatType))
  ui._txt_weaponTypeValue:SetSize(ui._txt_weaponTypeValue:GetTextSizeX(), ui._txt_weaponTypeValue:GetTextSizeY())
  ui._txt_combatTypeValue:SetSize(ui._txt_combatTypeValue:GetTextSizeX(), ui._txt_combatTypeValue:GetTextSizeY())
  ui._txt_desc:SetTextMode(__eTextMode_AutoWrap)
  ui._txt_desc:SetText(PAGetString(Defines.StringSheet_GAME, currentData._desc))
  local height = ui._txt_desc:GetTextSizeY()
  ui._txt_desc:SetSize(ui._txt_desc:GetSizeX(), height)
  local posY = ui._txt_desc:GetPosY() + height + 10
  local posX = 0
  posX = ui._txt_weaponTypeTitle:GetPosX() + ui._txt_weaponTypeTitle:GetTextSizeX() + 10
  if posX < ui._txt_combatTypeTitle:GetPosX() + ui._txt_combatTypeTitle:GetTextSizeX() then
    posX = ui._txt_combatTypeTitle:GetPosX() + ui._txt_combatTypeTitle:GetTextSizeX() + 10
  end
  ui._txt_weaponTypeValue:SetPosX(posX)
  ui._txt_combatTypeValue:SetPosX(posX)
  ui._stc_horizonLineBottom:SetPosY(ui._stc_horizonLineTop:GetPosY() + posY)
  ui._stc_horizonLineTop:SetPosY(posY)
  posY = posY + ui._stc_horizonLineTop:GetSizeY()
  ui._stc_combatTypeTitle:SetPosY(posY)
  posY = posY + 13
  ui._stc_Dot1:SetPosY(posY + ui._txt_weaponTypeTitle:GetSizeY() / 2 - ui._stc_Dot1:GetSizeY() / 2 - 1)
  ui._txt_weaponTypeTitle:SetPosY(posY)
  ui._txt_weaponTypeValue:SetPosY(posY)
  posY = posY + ui._txt_weaponTypeTitle:GetSizeY() + 2
  ui._stc_Dot2:SetPosY(posY + ui._txt_weaponTypeTitle:GetSizeY() / 2 - ui._stc_Dot2:GetSizeY() / 2 - 1)
  ui._txt_combatTypeTitle:SetPosY(posY)
  ui._txt_combatTypeValue:SetPosY(posY)
  posY = posY + ui._txt_combatTypeTitle:GetSizeY() + 10
  ui._stc_horizonLineBottom:SetPosY(posY)
  posY = posY + ui._stc_horizonLineBottom:GetSizeY() + 50
  ui._txt_learnSkill:SetTextMode(__eTextMode_AutoWrap)
  ui._txt_learnSkill:SetText(ui._txt_learnSkill:GetText())
  ui._txt_learnSkill:SetSize(ui._txt_learnSkill:GetSizeX(), ui._txt_learnSkill:GetTextSizeY())
  ui._txt_learnSkill:SetVerticalMiddle()
  local movePos = 0
  if posY > self._originBottomAreaPosY then
    ui._stc_bottomSkillArea:SetPosY(posY)
    ui._stc_bottomSkillAreaBg:SetPosY(posY)
    posY = posY + ui._stc_bottomSkillAreaBg:GetSizeY() + 20
    ui._stc_bottomBG:SetPosY(posY)
    posY = posY + ui._stc_bottomBG:GetSizeY()
    ui._stc_centerMainArea:SetSize(ui._stc_centerMainArea:GetSizeX(), posY)
    ui._stc_centerMainArea:SetPosY(getScreenSizeY() / 2 - posY / 2)
    movePos = posY - self._originCenterMainAreaSizeY
  else
    ui._stc_bottomSkillArea:SetPosY(self._originBottomAreaPosY)
    ui._stc_bottomSkillAreaBg:SetPosY(self._originBottomAreaPosY)
    ui._stc_bottomBG:SetPosY(self._originBottomBgPosY)
    ui._stc_centerMainArea:SetSize(ui._stc_centerMainArea:GetSizeX(), self._originCenterMainAreaSizeY)
  end
  local x1, y1, x2, y2 = setTextureUV_Func(ui._stc_bigCharacter, 0, -movePos, ui._stc_bigCharacter:GetSizeX(), ui._stc_bigCharacter:GetSizeY())
  if 0 <= y1 then
    y1 = 0
  end
  ui._stc_bigCharacter:getBaseTexture():setUV(x1, y1, x2, y2)
  ui._stc_bigCharacter:setRenderTexture(ui._stc_bigCharacter:getBaseTexture())
  ui._stc_bigCharacter:SetHorizonCenter()
  ui._stc_bigCharacter:SetVerticalBottom()
  ui._stc_centerMainArea:SetVerticalMiddle()
end
function PaGlobal_SkillGroup_SelectType:setSkill(skillNo)
  local skillTypeSSW = getSkillTypeStaticStatus(skillNo)
  local skillSSW = getSkillStaticStatus(skillNo, 1)
  local ui = self._ui
  if nil == skillTypeSSW then
    return
  end
  local skillName = skillTypeSSW:getName()
  ui._txt_skillName:SetText(skillName)
  ui._txt_skillPoint:SetText(tostring(skillSSW:get()._needSkillPointForLearning))
  ui._stc_skillSlot:ChangeTextureInfoName("Icon/" .. skillTypeSSW:getIconPath())
  ui._stc_skillSlot:addInputEvent("Mouse_On", "HandleMOver_SkillWindow_ToolTipShow(" .. skillNo .. ", false, \"SelectTypeBox\")")
  ui._stc_skillSlot:addInputEvent("Mouse_Out", "HandleMOver_SkillWindow_ToolTipHide(" .. skillNo .. ", \"SelectTypeBox\")")
  local skillLevelInfo = getSkillLevelInfo(skillNo)
  local skillTypeStaticWrapper = getSkillTypeStaticStatus(skillNo)
  if false == skillLevelInfo._learnable and true == skillLevelInfo._usable and true == skillTypeStaticWrapper:get()._isSettableQuickSlot and __eSkillTypeParam_Awaken == PaGlobal_SkillGroup._selectedTree then
    ui._stc_skillSlot:addInputEvent("Mouse_PressMove", "HandleEventLUp_SkillGroup_SelectType_StartDrag(" .. skillNo .. ")")
    ui._stc_skillSlot:SetEnableDragAndDrop(true)
  else
    ui._stc_skillSlot:addInputEvent("Mouse_PressMove", "")
  end
end
