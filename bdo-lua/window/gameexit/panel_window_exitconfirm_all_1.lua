function PaGlobal_ExitConfirm_All:initialize()
  if true == PaGlobal_ExitConfirm_All._initialize then
    return
  end
  self._ui._stc_block = UI.getChildControl(Panel_ExitConfirm, "Static_Black")
  self._ui._stc_bg = UI.getChildControl(Panel_ExitConfirm, "Static_Bg")
  self._ui._txt_title = UI.getChildControl(Panel_ExitConfirm, "StaticText_Title")
  self._ui._btn_confirm = UI.getChildControl(Panel_ExitConfirm, "Button_Confirm")
  self._ui._btn_close = UI.getChildControl(Panel_ExitConfirm, "Button_Cancel")
  self._ui._txt_rewardDesc = UI.getChildControl(Panel_ExitConfirm, "StaticText_RewardDesc")
  self._ui._txt_gameExitDesc = UI.getChildControl(Panel_ExitConfirm, "StaticText_GameExit")
  local stc_slotBg0 = UI.getChildControl(Panel_ExitConfirm, "Static_SlotBg0")
  local stc_slotBg1 = UI.getChildControl(Panel_ExitConfirm, "Static_SlotBg1")
  local stc_slotBg2 = UI.getChildControl(Panel_ExitConfirm, "Static_SlotBg2")
  self._changeTexture = {
    stc_slotBg0,
    UI.getChildControl(stc_slotBg0, "Static_ItemBg"),
    stc_slotBg1,
    UI.getChildControl(stc_slotBg1, "Static_ItemBg"),
    stc_slotBg2,
    UI.getChildControl(stc_slotBg2, "Static_ItemBg")
  }
  self._changeItemText = {
    UI.getChildControl(stc_slotBg0, "StaticText_ItemName"),
    UI.getChildControl(stc_slotBg1, "StaticText_ItemName"),
    UI.getChildControl(stc_slotBg2, "StaticText_ItemName")
  }
  self._changeBaseText = {
    self._ui._txt_title,
    self._ui._txt_rewardDesc,
    self._ui._txt_gameExitDesc
  }
  self._changeBtnText = {
    self._ui._btn_confirm,
    self._ui._btn_close
  }
  self._ui._txt_title:SetText(PAGetString(Defines.StringSheet_GAME, "GAME_EXIT_MESSAGEBOX_TITLE"))
  self._ui._txt_gameExitDesc:SetText(PAGetString(Defines.StringSheet_GAME, "PANEL_GAMEEXIT_TRAY_ASK"))
  if _ContentsGroup_ExitConfirmHashashin then
    self._ui._txt_title:SetShow(false)
  end
  self:initNextReward()
  self:initBackground()
  PaGlobal_ExitConfirm_All:registEventHandler()
  PaGlobal_ExitConfirm_All:validate()
  PaGlobal_ExitConfirm_All._initialize = true
end
function PaGlobal_ExitConfirm_All:registEventHandler()
  if nil == Panel_ExitConfirm then
    return
  end
  self._ui._btn_confirm:addInputEvent("Mouse_LUp", "HandleEventLUp_ExitConfirm_All_ExitConfirm()")
  self._ui._btn_close:addInputEvent("Mouse_LUp", "HandleEventLUp_ExitConfirm_All_Close()")
end
function PaGlobal_ExitConfirm_All:prepareOpen()
  if nil == Panel_ExitConfirm then
    return
  end
  if true == Panel_ExitConfirm:GetShow() then
    return
  end
  local sizeX = getScreenSizeX() + 500
  local sizeY = getScreenSizeY() + 500
  self._ui._stc_block:SetSize(sizeX, sizeY)
  self._ui._stc_block:ComputePos()
  PaGlobal_ExitConfirm_All:open()
end
function PaGlobal_ExitConfirm_All:open()
  if nil == Panel_ExitConfirm then
    return
  end
  Panel_ExitConfirm:SetShow(true)
end
function PaGlobal_ExitConfirm_All:prepareClose()
  if nil == Panel_ExitConfirm then
    return
  end
  if false == Panel_ExitConfirm:GetShow() then
    return
  end
  Panel_Tooltip_Item_hideTooltip()
  PaGlobal_ExitConfirm_All:close()
end
function PaGlobal_ExitConfirm_All:close()
  if nil == Panel_ExitConfirm then
    return
  end
  Panel_ExitConfirm:SetShow(false)
end
function PaGlobal_ExitConfirm_All:update()
  if nil == Panel_ExitConfirm then
    return
  end
end
function PaGlobal_ExitConfirm_All:validate()
  if nil == Panel_ExitConfirm then
    return
  end
end
function PaGlobal_ExitConfirm_All:initNextReward()
  for index = 0, self._rewardCount - 1 do
    local temp = {}
    temp._dayControl = UI.getChildControl(Panel_ExitConfirm, "Static_SlotBg" .. index)
    temp._item = UI.getChildControl(temp._dayControl, "Static_ItemBg")
    temp._itemName = UI.getChildControl(temp._dayControl, "StaticText_ItemName")
    temp._initPosX = temp._dayControl:GetPosX()
    temp._initPosY = temp._dayControl:GetPosY()
    temp.slot = {}
    SlotItem.new(temp.slot, "Panel_GameExit_Reward_", index, temp._dayControl, self._dailyStampSlotConfig)
    temp.slot:createChild()
    if _ContentsGroup_ExitConfirmHashashin then
      temp.slot.icon:SetPosX(temp._item:GetPosX())
      temp.slot.icon:SetPosY(temp._item:GetPosY())
    else
      temp.slot.icon:SetPosX(6)
      temp.slot.icon:SetPosY(6)
    end
    self._dayControl[index] = temp
  end
end
function PaGlobal_ExitConfirm_All:setNextReward()
  local dailyStampKeys
  if true == _ContentsGroup_NewUI_DailyStamp_All then
    dailyStampKeys = PaGlobalFunc_DailyStamp_All_GetDailyStampKeys()
  else
    dailyStampKeys = FGlobal_DailyStamp_GetDailyStampKeys()
  end
  if nil == dailyStampKeys then
    _PA_LOG("\235\172\180\236\160\149", "\234\176\146\236\157\180 \236\151\134\236\156\188\235\169\180 \236\149\136 \235\144\152\235\138\148\235\141\176..")
    return
  end
  local slotIndex = 0
  for ii = 0, self._rewardCount - 1 do
    self._dayControl[ii]._dayControl:SetShow(false)
    self._dayControl[ii].slot.icon:addInputEvent("Mouse_On", "")
    self._dayControl[ii].slot.icon:addInputEvent("Mouse_Out", "")
    self._dayControl[ii]._dayControl:SetPosY(self._dayControl[ii]._initPosY)
    local daliystampIndex = ii + 1
    if nil ~= dailyStampKeys[daliystampIndex] then
      local attendanceKey = dailyStampKeys[daliystampIndex][1]:getKey()
      local totalDayCount = dailyStampKeys[daliystampIndex][1]:getRewardCount()
      local attantCount = ToClient_getAttendanceCount(attendanceKey)
      if totalDayCount > attantCount then
        local itemWrapper = dailyStampKeys[daliystampIndex][1]:getRewardItem(attantCount)
        if nil ~= itemWrapper then
          self._dayControl[slotIndex]._dayControl:SetShow(true)
          self._dayControl[slotIndex].slot:setItem(itemWrapper)
          self._dayControl[slotIndex]._itemName:SetText(itemWrapper:getStaticStatus():getName())
          self._dayControl[slotIndex].slot.icon:addInputEvent("Mouse_On", "HandleEventOn_ExitConfirm_All_Tooltip(" .. slotIndex .. "," .. attantCount .. "," .. daliystampIndex .. ")")
          self._dayControl[slotIndex].slot.icon:addInputEvent("Mouse_Out", "HandleEventOut_ExitConfirm_All_Tooltip()")
          slotIndex = slotIndex + 1
        end
      end
    end
  end
  if 0 == slotIndex then
    self._ui._txt_rewardDesc:SetShow(false)
  else
    self._ui._txt_rewardDesc:SetTextMode(__eTextMode_AutoWrap)
    self._ui._txt_rewardDesc:SetText(self._ui._txt_rewardDesc:GetText())
    self._ui._txt_rewardDesc:SetShow(true)
  end
  if 1 == slotIndex then
    self._dayControl[0]._dayControl:SetPosY(self._dayControl[1]._initPosY)
  elseif 2 == slotIndex then
    local posy1 = (self._dayControl[0]._initPosY + self._dayControl[1]._initPosY) * 0.5
    local posy2 = (self._dayControl[1]._initPosY + self._dayControl[2]._initPosY) * 0.5
    self._dayControl[0]._dayControl:SetPosY(posy1)
    self._dayControl[1]._dayControl:SetPosY(posy2)
  end
end
function PaGlobal_ExitConfirm_All:initBackground()
  if _ContentsGroup_ExitConfirmHashashin then
    return
  end
  local bgTextureName, btnTextureName, itemTextColor, titleTextColor, btnTextColor
  if true == ToClient_IsContentsGroupOpen("1315") then
    bgTextureName = "combine/etc/combine_etc_gameexitevent_00.dds"
    btnTextureName = "combine/etc/combine_etc_gameexitevent_01.dds"
    itemTextColor = Defines.Color.C_FFA997CD
    titleTextColor = Defines.Color.C_FFBBA6FF
    btnTextColor = Defines.Color.C_FFE7D4FF
  elseif true == ToClient_IsContentsGroupOpen("1042") then
    bgTextureName = "combine/etc/combine_etc_gameexitevent_02.dds"
    btnTextureName = "combine/etc/combine_etc_gameexitevent_03.dds"
    itemTextColor = Defines.Color.C_FFCEA057
    titleTextColor = Defines.Color.C_FFFFCE89
    btnTextColor = Defines.Color.C_FFFFF1B7
  end
  if nil == bgTextureName then
    return
  end
  self._ui._stc_bg:ChangeTextureInfoName(bgTextureName)
  for k, value in pairs(self._changeTexture) do
    value:ChangeTextureInfoName(btnTextureName)
  end
  for k, value in pairs(self._changeBtnText) do
    value:ChangeTextureInfoName(btnTextureName)
    local x1, y1, x2, y2 = setTextureUV_Func(value, 1, 1, 77, 44)
    value:getBaseTexture():setUV(x1, y1, x2, y2)
    value:ChangeOnTextureInfoName(btnTextureName)
    local x1, y1, x2, y2 = setTextureUV_Func(value, 1, 45, 77, 88)
    value:getOnTexture():setUV(x1, y1, x2, y2)
    value:ChangeClickTextureInfoName(btnTextureName)
    local x1, y1, x2, y2 = setTextureUV_Func(value, 1, 89, 77, 132)
    value:getClickTexture():setUV(x1, y1, x2, y2)
  end
  for k, value in pairs(self._changeItemText) do
    value:SetFontColor(itemTextColor)
  end
  for k, value in pairs(self._changeBaseText) do
    value:SetFontColor(titleTextColor)
  end
  for k, value in pairs(self._changeBtnText) do
    value:SetFontColor(btnTextColor)
    value:SetOverFontColor(btnTextColor)
    value:SetClickFontColor(btnTextColor)
  end
end
