function PaGlobal_PersonalMonster_ALL:initialize()
  if true == PaGlobal_PersonalMonster_ALL._initialize then
    return
  end
  self._ui.stc_Title = UI.getChildControl(Panel_PersonalMonster_All, "StaticText_TitleArea")
  self._ui.btn_Close = UI.getChildControl(self._ui.stc_Title, "Button_Win_Close")
  self._ui.stc_MainBg = UI.getChildControl(Panel_PersonalMonster_All, "Static_MainBG")
  self._ui.list2_Monster = UI.getChildControl(Panel_PersonalMonster_All, "List2_MonsterList")
  self._ui.stc_Desc = UI.getChildControl(Panel_PersonalMonster_All, "Static_Desc")
  self._ui.txt_Desc = UI.getChildControl(self._ui.stc_Desc, "StaticText_Desc")
  self._ui.txt_ClosedMsg = UI.getChildControl(Panel_PersonalMonster_All, "StaticText_CloseMessage")
  self._ui.stc_SearchMsg = UI.getChildControl(Panel_PersonalMonster_All, "Static_SearchIcon")
  self._ui.txt_Search = UI.getChildControl(self._ui.stc_SearchMsg, "StaticText_Search")
  self._ui.txt_SearchInfo = UI.getChildControl(self._ui.stc_SearchMsg, "StaticText_Information")
  self._ui.stc_ConsoleItemList = UI.getChildControl(Panel_PersonalMonster_All, "Static_ConsoleItemListArea")
  self._ui.txt_ConsoleBossName = UI.getChildControl(self._ui.stc_ConsoleItemList, "StaticText_Title")
  self._ui.stc_ItemListBg = UI.getChildControl(self._ui.stc_ConsoleItemList, "Static_ItemListBG")
  self._ui.btn_ItemBg = UI.getChildControl(self._ui.stc_ItemListBg, "Button_ItemBG")
  self._ui.stc_ItemSlotBg = UI.getChildControl(self._ui.btn_ItemBg, "Static_SlotBG")
  self._ui.stc_ItemIcon = UI.getChildControl(self._ui.stc_ItemSlotBg, "Static_ItemSlot")
  self._ui.txt_ItemName = UI.getChildControl(self._ui.btn_ItemBg, "StaticText_ItemName")
  self._ui.stc_Console_KeyGuides = UI.getChildControl(Panel_PersonalMonster_All, "Static_ConsoleKey")
  self._ui.stc_KeyGuide_A = UI.getChildControl(self._ui.stc_Console_KeyGuides, "StaticText_A_ConsoleUI")
  self._ui.stc_KeyGuide_Y = UI.getChildControl(self._ui.stc_Console_KeyGuides, "StaticText_Y_ConsoleUI")
  self._ui.stc_KeyGuide_B = UI.getChildControl(self._ui.stc_Console_KeyGuides, "StaticText_B_ConsoleUI")
  self._isConsole = _ContentsGroup_UsePadSnapping
  self._ui.txt_Desc:SetTextMode(__eTextMode_AutoWrap)
  self._ui.txt_Desc:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_PERSONALMONSTER_DESC"))
  self._originPanelSizeY = Panel_PersonalMonster_All:GetSizeY()
  self._originList2SizeY = self._ui.list2_Monster:GetSizeY()
  self._originMainBgSizeY = self._ui.stc_MainBg:GetSizeY()
  self._originPanelSpanY = Panel_PersonalMonster_All:GetSpanSize().y
  local list2Content = UI.getChildControl(self._ui.list2_Monster, "List2_1_Content")
  self._list2ContentSizeY = list2Content:GetSizeY()
  for idx = 0, self._pcRewardSlotCount - 1 do
    local list2Slot = UI.getChildControl(list2Content, "Static_SlotBg_" .. tostring(idx))
    local itemSlot = {}
    SlotItem.new(itemSlot, "rewardSlot_" .. tostring(idx), idx, list2Slot, self._slotConfig)
    itemSlot:createChild()
    itemSlot.icon:SetSize(40, 40)
    itemSlot.border:SetSize(40, 40)
    itemSlot.border:SetHorizonCenter()
    itemSlot.border:SetVerticalMiddle()
    itemSlot.icon:SetSpanSize(2, 1)
    itemSlot.border:SetSpanSize(1, 1)
  end
  PaGlobal_PersonalMonster_ALL:validate()
  PaGlobal_PersonalMonster_ALL:switchPlatform(self._isConsole)
  PaGlobal_PersonalMonster_ALL:registEventHandler(self._isConsole)
  if false == self._isConsole and nil ~= Panel_UIMain then
    FromClient_PersonalMonsterAll_UpdateMonsterList()
  end
  PaGlobal_PersonalMonster_ALL._initialize = true
end
function PaGlobal_PersonalMonster_ALL:switchPlatform(isConsole)
  self._ui.stc_Console_KeyGuides:SetShow(isConsole)
  self._ui.stc_ConsoleItemList:SetShow(isConsole)
  self._ui.btn_Close:SetShow(not isConsole)
  if true == isConsole then
    local keyguide = {
      self._ui.stc_KeyGuide_A,
      self._ui.stc_KeyGuide_Y,
      self._ui.stc_KeyGuide_B
    }
    Panel_PersonalMonster_All:SetHorizonCenter()
    Panel_PersonalMonster_All:SetVerticalMiddle()
    Panel_PersonalMonster_All:SetPosXY(Panel_PersonalMonster_All:GetPosX(), Panel_PersonalMonster_All:GetPosY() - Panel_PersonalMonster_All:GetSizeY())
    Panel_PersonalMonster_All:ComputePos()
    self._ui.stc_Console_KeyGuides:ComputePos()
    PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyguide, self._ui.stc_Console_KeyGuides, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHT)
    for idx = 0, self._pcRewardSlotCount - 1 do
      local tempTable = {
        btn = nil,
        slotIcon = nil,
        name = nil
      }
      tempTable.btn = UI.cloneControl(self._ui.btn_ItemBg, self._ui.stc_ItemListBg, "Button_ItemBG_Console" .. idx)
      tempTable.btn:SetPosY((tempTable.btn:GetSizeY() + 5) * idx)
      local slotBg = UI.getChildControl(tempTable.btn, "Static_SlotBG")
      local bossName = UI.getChildControl(tempTable.btn, "StaticText_ItemName")
      local itemSlot = {}
      SlotItem.new(itemSlot, "Console_RewardSlot_" .. tostring(idx), idx, slotBg, self._slotConfig)
      itemSlot:createChild()
      tempTable.btn:SetShow(false)
      tempTable.slotIcon = itemSlot
      tempTable.name = bossName
      self._consoleRewardSlot[idx] = tempTable
    end
    self._ui.btn_ItemBg:SetShow(false)
  end
end
function PaGlobal_PersonalMonster_ALL:registEventHandler(isConsole)
  if false == isConsole then
    registerEvent("FromClient_updatePersonalMonsterList", "FromClient_PersonalMonsterAll_UpdateMonsterList()")
    self._ui.btn_Close:addInputEvent("Mouse_LUp", "HandleEventLUp_PersonalMonster_All_Close()")
  end
  registerEvent("onScreenResize", "PaGlobal_PersonalMonster_ALL_OnScreenResize")
  self._ui.list2_Monster:registEvent(__ePAUIList2EventType_LuaChangeContent, "FromClient_PersonalMonster_All_UpdateList2")
  self._ui.list2_Monster:createChildContent(__ePAUIList2ElementManagerType_List)
end
function PaGlobal_PersonalMonster_ALL:prepareOpen()
  if true == Panel_PersonalMonster_All:GetShow() then
    return
  end
  if false == self._isConsole and nil ~= Panel_UIMain then
    PaGlobalFunc_PersonalMonster_EffectHide()
  end
  PaGlobal_PersonalMonster_ALL:open()
  PaGlobal_PersonalMonster_ALL:update()
  PaGlobal_PersonalMonster_ALL_OnScreenResize()
  PaGlobal_PersonalMonster_ALL._ui.stc_Console_KeyGuides:SetShow(self._isConsole)
end
function PaGlobal_PersonalMonster_ALL:open()
  if nil == Panel_PersonalMonster_All then
    return
  end
  Panel_PersonalMonster_All:SetShow(true)
end
function PaGlobal_PersonalMonster_ALL:prepareClose()
  if false == Panel_PersonalMonster_All:GetShow() then
    return
  end
  if true == _ContentsGroup_NewUI_Tooltip_All then
    if nil ~= Panel_Widget_Tooltip_Item_All then
      Panel_Tooltip_Item_hideTooltip()
    end
  elseif nil ~= Panel_Tooltip_Item then
    Panel_Tooltip_Item_hideTooltip()
  end
  PaGlobal_PersonalMonster_ALL:close()
end
function PaGlobal_PersonalMonster_ALL:close()
  if nil == Panel_PersonalMonster_All then
    return
  end
  Panel_PersonalMonster_All:SetShow(false)
end
function PaGlobal_PersonalMonster_ALL:update()
  if true == self._ui.stc_ConsoleItemList:GetShow() and true == self._isConsole then
    self._ui.stc_ConsoleItemList:SetShow(false)
  end
  local monsterCount = ToClient_GetReservePersonalMonsterListCount()
  PaGlobal_PersonalMonster_ALL:NoMonsterAvaliable(monsterCount)
  if 0 < monsterCount then
    self._ui.list2_Monster:getElementManager():clearKey()
    for ii = 0, monsterCount - 1 do
      local monsterKey = ToClient_GetReservePersonalMonsterKey(ii)
      if 0 ~= monsterKey and nil ~= monsterKey then
        self._ui.list2_Monster:getElementManager():pushKey(ii)
      end
    end
  end
end
function PaGlobal_PersonalMonster_ALL:NoMonsterAvaliable(monsterCount)
  self._ui.stc_SearchMsg:SetShow(false)
  self._ui.list2_Monster:SetShow(false)
  self._ui.txt_ClosedMsg:SetShow(false)
  if true == PaGlobal_PersonalMonster_ALL:FamliyLevelCheck() then
    if monsterCount <= 0 then
      Panel_PersonalMonster_All:SetSize(Panel_PersonalMonster_All:GetSizeX(), 320)
      self._ui.stc_MainBg:SetSize(self._ui.stc_MainBg:GetSizeX(), Panel_PersonalMonster_All:GetSizeY() - self._ui.stc_Title:GetSizeY())
      self._ui.stc_SearchMsg:SetShow(true)
    else
      self._ui.list2_Monster:SetShow(true)
      if 4 <= monsterCount then
        Panel_PersonalMonster_All:SetSize(Panel_PersonalMonster_All:GetSizeX(), self._originPanelSizeY)
        self._ui.list2_Monster:SetSize(self._ui.list2_Monster:GetSizeX(), self._originList2SizeY)
        self._ui.stc_MainBg:SetSize(self._ui.stc_MainBg:GetSizeX(), self._originMainBgSizeY)
      else
        self._ui.list2_Monster:SetSize(self._ui.list2_Monster:GetSizeX(), (self._list2ContentSizeY + 5) * monsterCount)
        Panel_PersonalMonster_All:SetSize(Panel_PersonalMonster_All:GetSizeX(), self._ui.stc_Desc:GetSizeY() + 30 + self._ui.list2_Monster:GetSizeY() + self._ui.stc_Title:GetSizeY())
        self._ui.stc_MainBg:SetSize(self._ui.stc_MainBg:GetSizeX(), Panel_PersonalMonster_All:GetSizeY() - self._ui.stc_Title:GetSizeY())
      end
    end
  else
    self._ui.txt_ClosedMsg:SetShow(true)
    self._ui.txt_ClosedMsg:SetTextMode(__eTextMode_AutoWrap)
    self._ui.txt_ClosedMsg:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_PERSONALMONSTER_CLOSE_NEEDAWAKENSTATE"))
    Panel_PersonalMonster_All:SetSize(Panel_PersonalMonster_All:GetSizeX(), 260)
    self._ui.stc_MainBg:SetSize(self._ui.stc_MainBg:GetSizeX(), Panel_PersonalMonster_All:GetSizeY() - self._ui.stc_Title:GetSizeY())
  end
end
function PaGlobal_PersonalMonster_ALL:FamliyLevelCheck()
  for idx = 0, getCharacterDataCount() - 1 do
    local characterData = getCharacterDataByIndex(idx)
    if nil ~= characterData and 56 <= characterData._level then
      return true
    end
  end
  return false
end
function PaGlobal_PersonalMonster_ALL:updateList2Control(content, key)
  local key32 = Int64toInt32(key)
  local monsterKey = ToClient_GetReservePersonalMonsterKey(key32)
  local monsterStatusWrapper = ToClient_GetCharacterStaticStatusWrapper(monsterKey)
  local personalMonsterWrapper = ToClient_GetPersonalMonsterWrapper(monsterKey)
  local personalMonsterInfoWrapper = ToClient_FindReservedPersonalMonsterInfoWrapper(monsterKey)
  if nil == monsterStatusWrapper or 0 == monsterKey then
    return
  end
  if nil == personalMonsterWrapper then
    return
  end
  if nil == personalMonsterInfoWrapper then
    return
  end
  local stc_difficultyIconBg = UI.getChildControl(content, "Static_DifficultyIconBG")
  local stc_difficultyIcon = UI.getChildControl(content, "Static_DifficultyIcon")
  local stc_specialBg = UI.getChildControl(content, "Static_Bg_Special")
  local stc_difficultyIconSpecialBg = UI.getChildControl(content, "Static_DifficultyIconBG_Special")
  local txt_BossName = UI.getChildControl(content, "StaticText_Name")
  local txt_BossDesc = UI.getChildControl(content, "StaticText_Desc")
  local txt_difficulty = UI.getChildControl(content, "StaticText_DifficultyValue")
  local btn_Navi = UI.getChildControl(content, "Button_Navi")
  local txt_level = UI.getChildControl(content, "StaticText_Level")
  local txt_dropItemTitle = UI.getChildControl(content, "StaticText_DropItemTitle")
  local iconSlots = {}
  for idx = 0, self._pcRewardSlotCount - 1 do
    local slotIcon = UI.getChildControl(content, "Static_SlotBg_" .. tostring(idx))
    slotIcon:SetShow(false)
  end
  local dropCount = personalMonsterWrapper:getDropItemCount()
  for idx = 0, dropCount do
    local itemKey = personalMonsterWrapper:getDropItemKey(idx)
    local itemSSW = getItemEnchantStaticStatus(ItemEnchantKey(itemKey))
    if idx < self._pcRewardSlotCount then
      local slotIcon = UI.getChildControl(content, "Static_SlotBg_" .. tostring(idx))
      if nil ~= itemSSW then
        local tempIcon = {}
        SlotItem.reInclude(tempIcon, "rewardSlot_" .. tostring(idx), idx, slotIcon, self._slotConfig)
        iconSlots[idx] = tempIcon
        iconSlots[idx]:setItemByStaticStatus(itemSSW)
        if false == self._isConsole then
          iconSlots[idx].icon:addInputEvent("Mouse_On", "PaGlobalFunc_PersonalMonster_All_ShowToolTip(" .. itemKey .. ")")
          iconSlots[idx].icon:addInputEvent("Mouse_Out", "Panel_Tooltip_Item_hideTooltip()")
        end
        slotIcon:SetShow(true)
      end
    end
  end
  txt_BossName:SetText(monsterStatusWrapper:getName())
  txt_BossDesc:SetTextMode(__eTextMode_AutoWrap)
  txt_BossDesc:SetText(personalMonsterWrapper:getDescription())
  txt_dropItemTitle:SetTextMode(__eTextMode_AutoWrap)
  txt_dropItemTitle:SetText(txt_dropItemTitle:GetText())
  local difficulty = personalMonsterWrapper:getDifficult()
  local monsterLevel = personalMonsterInfoWrapper:getLevel()
  txt_difficulty:SetText(self._difficultyText[difficulty])
  if nil ~= self._difficultyRoma[monsterLevel] then
    txt_level:SetText(self._difficultyRoma[monsterLevel])
  else
    txt_level:SetText(self._difficultyRoma[0])
  end
  if 3 == difficulty then
    stc_specialBg:SetShow(true)
    stc_difficultyIconSpecialBg:SetShow(true)
  else
    stc_specialBg:SetShow(false)
    stc_difficultyIconSpecialBg:SetShow(false)
  end
  local x1, y1, x2, y2 = 0, 0, 0, 0
  if nil ~= self._difficultyIcon[monsterLevel] then
    stc_difficultyIcon:ChangeTextureInfoNameAsync("renewal/pcremaster/remaster_icon_worldmap_autoboss_all.dds")
    x1, y1, x2, y2 = setTextureUV_Func(stc_difficultyIcon, self._difficultyIcon[monsterLevel].x1, self._difficultyIcon[monsterLevel].y1, self._difficultyIcon[monsterLevel].x2, self._difficultyIcon[monsterLevel].y2)
    stc_difficultyIcon:getBaseTexture():setUV(x1, y1, x2, y2)
    stc_difficultyIcon:setRenderTexture(stc_difficultyIcon:getBaseTexture())
  end
  if nil ~= self._difficultyIconBG[difficulty] then
    stc_difficultyIconBg:ChangeTextureInfoNameAsync("renewal/pcremaster/remaster_icon_worldmap_autoboss_all.dds")
    x1, y1, x2, y2 = setTextureUV_Func(stc_difficultyIconBg, self._difficultyIconBG[difficulty].x1, self._difficultyIconBG[difficulty].y1, self._difficultyIconBG[difficulty].x2, self._difficultyIconBG[difficulty].y2)
    stc_difficultyIconBg:getBaseTexture():setUV(x1, y1, x2, y2)
    stc_difficultyIconBg:setRenderTexture(stc_difficultyIconBg:getBaseTexture())
  end
  btn_Navi:SetPosX(txt_BossName:GetPosX() + txt_BossName:GetTextSizeX() + 20)
  if false == self._isConsole then
    btn_Navi:addInputEvent("Mouse_LUp", "HandleEventLUp_PersonalMonster_All_NavigateToMonster(" .. key32 .. ")")
    btn_Navi:addInputEvent("Mouse_On", "PaGlobal_PersonalMonster_All_TooltipShow( true )")
    btn_Navi:addInputEvent("Mouse_Out", "PaGlobal_PersonalMonster_All_TooltipShow( false )")
  else
    content:registerPadEvent(__eConsoleUIPadEvent_A, "HandleEventLUp_PersonalMonster_All_NavigateToMonster(" .. key32 .. ")")
    btn_Navi:addInputEvent("Mouse_LUp", "HandleEventPadUp_PersonalMonster_All_ShowRewardItem(" .. key32 .. ")")
    content:registerPadEvent(__eConsoleUIPadEvent_Y, "HandleEventPadUp_PersonalMonster_All_ShowRewardItem(" .. key32 .. ")")
  end
  function PaGlobalFunc_PersonalMonster_All_ShowToolTip(itemKey)
    local itemSSW = getItemEnchantStaticStatus(ItemEnchantKey(itemKey))
    Panel_Tooltip_Item_Show(itemSSW, Panel_PersonalMonster_All, true)
  end
  function PaGlobal_PersonalMonster_All_TooltipShow(isShow)
    if nil == isShow or false == isShow then
      TooltipSimple_Hide()
      return
    end
    local name, desc, control
    if true == isShow then
      name = PAGetString(Defines.StringSheet_GAME, "LUA_WINDOW_PERSONALMONSTER_NAVITOOLTIPTITLE")
      desc = PAGetString(Defines.StringSheet_GAME, "LUA_WINDOW_PERSONALMONSTER_NAVITOOLTIPDESC")
      control = btn_Navi
      TooltipSimple_Show(control, name, desc)
    end
  end
end
function PaGlobal_PersonalMonster_ALL:convertTextToItemGradeColor(itemSSW, control)
  if nil == itemSSW then
    return
  end
  local UI_color = Defines.Color
  local nameColorGrade = itemSSW:getGradeType()
  if 0 == nameColorGrade then
    control:SetFontColor(UI_color.C_FFC4C4C4)
  elseif 1 == nameColorGrade then
    control:SetFontColor(UI_color.C_FF83A543)
  elseif 2 == nameColorGrade then
    control:SetFontColor(UI_color.C_FF438DCC)
  elseif 3 == nameColorGrade then
    control:SetFontColor(UI_color.C_FFF5BA3A)
  elseif 4 == nameColorGrade then
    control:SetFontColor(UI_color.C_FFD05D48)
  else
    control:SetFontColor(UI_color.C_FFC4C4C4)
  end
end
function PaGlobal_PersonalMonster_ALL:validate()
  if nil == Panel_PersonalMonster_All then
    return
  end
  self._ui.stc_Title:isValidate()
  self._ui.btn_Close:isValidate()
  self._ui.stc_MainBg:isValidate()
  self._ui.list2_Monster:isValidate()
  self._ui.stc_Desc:isValidate()
  self._ui.txt_Desc:isValidate()
  self._ui.txt_ClosedMsg:isValidate()
  self._ui.stc_SearchMsg:isValidate()
  self._ui.txt_Search:isValidate()
  self._ui.txt_SearchInfo:isValidate()
  self._ui.stc_ConsoleItemList:isValidate()
  self._ui.txt_ConsoleBossName:isValidate()
  self._ui.stc_ItemListBg:isValidate()
  self._ui.btn_ItemBg:isValidate()
  self._ui.stc_ItemSlotBg:isValidate()
  self._ui.stc_ItemIcon:isValidate()
  self._ui.txt_ItemName:isValidate()
  self._ui.stc_Console_KeyGuides:isValidate()
  self._ui.stc_KeyGuide_A:isValidate()
  self._ui.stc_KeyGuide_Y:isValidate()
  self._ui.stc_KeyGuide_B:isValidate()
end
