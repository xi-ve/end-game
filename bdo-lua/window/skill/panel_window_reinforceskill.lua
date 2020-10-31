Panel_Window_ReinforceSkill:SetShow(false, false)
Panel_Window_ReinforceSkill:setMaskingChild(true)
Panel_Window_ReinforceSkill:setGlassBackground(true)
Panel_Window_ReinforceSkill:RegisterShowEventFunc(true, "Panel_Window_ReinforceSkill_ShowAni()")
Panel_Window_ReinforceSkill:RegisterShowEventFunc(false, "Panel_Window_ReinforceSkill_HideAni()")
local UI_ANI_ADV = CppEnums.PAUI_ANIM_ADVANCE_TYPE
local UI_PSFT = CppEnums.PAUI_SHOW_FADE_TYPE
local UI_color = Defines.Color
local isReinforceContentOpen = ToClient_IsContentsGroupOpen("203")
local normalReinforceSkillCount = 3
local awakenReinforceSkillCount = 3
local reinforceSkillViewCount = 6
local normalSkillreinforceableLv = {
  [0] = 50,
  52,
  54
}
local awakenSkillreinforceableLv = {
  [0] = 56,
  58,
  60
}
local reinforceSkillIndex = -1
local _count = 0
local reinforceSkillControl = {}
local fontColor_NormalSkill = 4293640023
local fontColor_AwakenSkill = 4280068804
local fontColor_NormalLevel = 4293640023
local fontColor_AwakenLevel = 4286636767
local fontColor_Disable = 4287993237
local btnClose = UI.getChildControl(Panel_Window_ReinforceSkill, "Button_Close")
local reinforceSkillBg = UI.getChildControl(Panel_Window_ReinforceSkill, "Static_AwakenSkill_BG")
local reinforceSkillSlot = UI.getChildControl(reinforceSkillBg, "Static_AwakenSkillSlot")
local reinforceSkillSlotBg = UI.getChildControl(reinforceSkillBg, "Static_AwakenSkillSlotBG")
local reinforceSkillName = UI.getChildControl(reinforceSkillBg, "StaticText_AwakenSkill_Name")
local reinforceSkillChangeButton = UI.getChildControl(reinforceSkillBg, "Button_AwakenSkill_Change")
local reinforceSkillDesc = UI.getChildControl(reinforceSkillBg, "StaticText_AwakenSkill_Desc")
local reinforceSkillAttrBg = UI.getChildControl(reinforceSkillBg, "Static_AttributeBg")
local reinforceSkillTitle = UI.getChildControl(reinforceSkillBg, "StaticText_AwakenSkill_AttributeTitle")
local reinforceSkillAttribute = UI.getChildControl(reinforceSkillBg, "Static_AwakenSkill_Attribute")
local reinforceSkillAttrDesc1 = UI.getChildControl(reinforceSkillBg, "StaticText_AwakenSkill_AttributeDesc_1")
local reinforceSkillAttrDesc2 = UI.getChildControl(reinforceSkillBg, "StaticText_AwakenSkill_AttributeDesc_2")
local reinforceSkillAttrChangeBtn = UI.getChildControl(reinforceSkillBg, "Button_AwakenSkill_AttributeChange")
local btnQuestion = UI.getChildControl(Panel_Window_ReinforceSkill, "Button_Question")
local reinforceSkillNoSetBg = UI.getChildControl(Panel_Window_ReinforceSkill, "Static_AwakenSkill_NoSetBg")
local reinforceSkillLimitLv = UI.getChildControl(reinforceSkillNoSetBg, "StaticText_LimitLv")
local reinforceNoSetTitle = UI.getChildControl(reinforceSkillNoSetBg, "StaticText_AwakenSkill_NoSetTitle")
local reinforceLockIcon = UI.getChildControl(reinforceSkillNoSetBg, "Static_LockIcon")
local reinforceUnlockIcon = UI.getChildControl(reinforceSkillNoSetBg, "Static_UnlockIcon")
local txt_noSkill = UI.getChildControl(Panel_Window_ReinforceSkill, "StaticText_NoSkill")
local txt_awakenSkillTitle = UI.getChildControl(Panel_Window_ReinforceSkill, "StaticText_Title_AwakenSkill")
btnClose:addInputEvent("Mouse_LUp", "Panel_Window_ReinforceSkill_Close()")
btnQuestion:SetShow(false)
btnQuestion:addInputEvent("Mouse_LUp", "Panel_WebHelper_ShowToggle( \"PanelSkillAwaken\" )")
PaGlobal_Util_RegistHelpTooltipEvent(btnQuestion, "\"PanelSkillAwaken\"")
if isGameServiceTypeDev() or isGameTypeEnglish() or isGameTypeRussia() then
  reinforceSkillAttrDesc1:SetIgnore(false)
  reinforceSkillAttrDesc1:SetTextMode(__eTextMode_LimitText)
  reinforceSkillAttrDesc2:SetIgnore(false)
  reinforceSkillAttrDesc2:SetTextMode(__eTextMode_LimitText)
end
function Panel_Window_ReinforceSkill_ShowAni()
  UIAni.fadeInSCR_Down(Panel_Window_ReinforceSkill)
  local aniInfo1 = Panel_Window_ReinforceSkill:addScaleAnimation(0, 0.08, UI_ANI_ADV.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfo1:SetStartScale(0.5)
  aniInfo1:SetEndScale(1.1)
  aniInfo1.AxisX = Panel_Window_ReinforceSkill:GetSizeX() / 2
  aniInfo1.AxisY = Panel_Window_ReinforceSkill:GetSizeY() / 2
  aniInfo1.ScaleType = 2
  aniInfo1.IsChangeChild = true
  local aniInfo2 = Panel_Window_ReinforceSkill:addScaleAnimation(0.08, 0.15, UI_ANI_ADV.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfo2:SetStartScale(1.1)
  aniInfo2:SetEndScale(1)
  aniInfo2.AxisX = Panel_Window_ReinforceSkill:GetSizeX() / 2
  aniInfo2.AxisY = Panel_Window_ReinforceSkill:GetSizeY() / 2
  aniInfo2.ScaleType = 2
  aniInfo2.IsChangeChild = true
end
function Panel_Window_ReinforceSkill_HideAni()
  Panel_Window_ReinforceSkill:SetShowWithFade(UI_PSFT.PAUI_ANI_TYPE_FADE_OUT)
  local aniInfo1 = Panel_Window_ReinforceSkill:addColorAnimation(0, 0.25, UI_ANI_ADV.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
  aniInfo1:SetStartColor(UI_color.C_FFFFFFFF)
  aniInfo1:SetEndColor(UI_color.C_00FFFFFF)
  aniInfo1:SetStartIntensity(3)
  aniInfo1:SetEndIntensity(1)
  aniInfo1.IsChangeChild = true
  aniInfo1:SetHideAtEnd(true)
  aniInfo1:SetDisableWhileAni(true)
end
function Panel_Window_ReinforceSkill_Show()
  Panel_Window_ReinforceSkill:SetShow(true, true)
  ReinforceSkill_SetData()
  TooltipSimple_Hide()
end
function Panel_Window_ReinforceSkill_Close()
  if nil == Panel_Window_ReinforceSkill or false == Panel_Window_ReinforceSkill:GetShow() then
    return
  end
  Panel_Window_ReinforceSkill:SetShow(false, true)
  TooltipSimple_Hide()
  if true == _ContentsGroup_NewUI_Dialog_All then
    PaGlobalFunc_DialogMain_All_SubPanelSetShow(true)
  end
end
local basePosY = reinforceSkillBg:GetPosY()
local bgSizeY = reinforceSkillBg:GetSizeY()
local gapY = 7
function ReinforceSkill_Init()
  if nil == getSelfPlayer() then
    return
  end
  local isClassType = getSelfPlayer():getClassType()
  for index = 0, reinforceSkillViewCount - 1 do
    local temp = {}
    temp._skillBg = UI.createControl(__ePAUIControl_Static, Panel_Window_ReinforceSkill, "ReinforceSkill_Bg_" .. index)
    CopyBaseProperty(reinforceSkillBg, temp._skillBg)
    temp._skillBg:SetPosY(basePosY + (bgSizeY + gapY) * index + math.floor(index / 3) * 35)
    temp._skillSlotBg = UI.createControl(__ePAUIControl_Static, temp._skillBg, "ReinforceSkill_SlotBg_" .. index)
    CopyBaseProperty(reinforceSkillSlotBg, temp._skillSlotBg)
    temp._skillSlot = UI.createControl(__ePAUIControl_Static, temp._skillBg, "ReinforceSkill_Slot_" .. index)
    CopyBaseProperty(reinforceSkillSlot, temp._skillSlot)
    temp._skillName = UI.createControl(__ePAUIControl_StaticText, temp._skillBg, "ReinforceSkill_Name_" .. index)
    CopyBaseProperty(reinforceSkillName, temp._skillName)
    temp._skillChangeButton = UI.createControl(__ePAUIControl_Button, temp._skillBg, "ReinforceSkill_ChangeButton_" .. index)
    CopyBaseProperty(reinforceSkillChangeButton, temp._skillChangeButton)
    temp._skillChangeButton:addInputEvent("Mouse_On", "ReinforceSkill_ButtonTooltip(" .. 0 .. ", " .. index .. ")")
    temp._skillChangeButton:addInputEvent("Mouse_Out", "ReinforceSkill_ButtonTooltip()")
    temp._skillDesc = UI.createControl(__ePAUIControl_StaticText, temp._skillBg, "ReinforceSkill_Desc_" .. index)
    CopyBaseProperty(reinforceSkillDesc, temp._skillDesc)
    temp._skillDesc:SetTextMode(__eTextMode_Limit_AutoWrap)
    temp._skillDesc:setLineCountByLimitAutoWrap(2)
    temp._skillAttrBg = UI.createControl(__ePAUIControl_Static, temp._skillBg, "ReinforceSkill_AttritubeBg_" .. index)
    CopyBaseProperty(reinforceSkillAttrBg, temp._skillAttrBg)
    temp._skillTitle = UI.createControl(__ePAUIControl_StaticText, temp._skillBg, "ReinforceSkill_Title_" .. index)
    CopyBaseProperty(reinforceSkillTitle, temp._skillTitle)
    temp._skillAttribute = UI.createControl(__ePAUIControl_Static, temp._skillBg, "ReinforceSkill_Attribute_" .. index)
    CopyBaseProperty(reinforceSkillAttribute, temp._skillAttribute)
    temp._skillAttrDesc1 = UI.createControl(__ePAUIControl_StaticText, temp._skillBg, "ReinforceSkill_AttrDesc1_" .. index)
    CopyBaseProperty(reinforceSkillAttrDesc1, temp._skillAttrDesc1)
    temp._skillAttrDesc2 = UI.createControl(__ePAUIControl_StaticText, temp._skillBg, "ReinforceSkill_AttrDesc2_" .. index)
    CopyBaseProperty(reinforceSkillAttrDesc2, temp._skillAttrDesc2)
    temp._skillAttrOptionChange = UI.createControl(__ePAUIControl_Button, temp._skillBg, "ReinforceSkill_AttrCahngeButton_" .. index)
    CopyBaseProperty(reinforceSkillAttrChangeBtn, temp._skillAttrOptionChange)
    temp._skillAttrOptionChange:addInputEvent("Mouse_On", "ReinforceSkill_ButtonTooltip(" .. 1 .. ", " .. index .. ")")
    temp._skillAttrOptionChange:addInputEvent("Mouse_Out", "ReinforceSkill_ButtonTooltip()")
    temp._skillNoSetBg = UI.createControl(__ePAUIControl_Static, Panel_Window_ReinforceSkill, "ReinforceSkill_NoSetBg_" .. index)
    CopyBaseProperty(reinforceSkillNoSetBg, temp._skillNoSetBg)
    temp._skillNoSetBg:SetPosY(basePosY + (bgSizeY + gapY) * index + math.floor(index / 3) * 35)
    temp._skillLimitLv = UI.createControl(__ePAUIControl_StaticText, temp._skillNoSetBg, "ReinforceSkill_LimitLv_" .. index)
    CopyBaseProperty(reinforceSkillLimitLv, temp._skillLimitLv)
    temp._skillNoSetTitle = UI.createControl(__ePAUIControl_StaticText, temp._skillNoSetBg, "ReinforceSkill_NoSetTitle_" .. index)
    CopyBaseProperty(reinforceNoSetTitle, temp._skillNoSetTitle)
    temp._skillLockIcon = UI.createControl(__ePAUIControl_Static, temp._skillNoSetBg, "ReinforceSkill_LockIcon_" .. index)
    CopyBaseProperty(reinforceLockIcon, temp._skillLockIcon)
    temp._skillUnlockIcon = UI.createControl(__ePAUIControl_Static, temp._skillNoSetBg, "ReinforceSkill_UnlockIcon_" .. index)
    CopyBaseProperty(reinforceUnlockIcon, temp._skillUnlockIcon)
    reinforceSkillControl[index] = temp
  end
  reinforceSkillBg:SetShow(false)
  reinforceSkillNoSetBg:SetShow(false)
  if isClassType == __eClassType_ShyWaman then
    txt_awakenSkillTitle:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_SKILLREINFORCE_AWAKEN_BYSHY"))
  else
    txt_awakenSkillTitle:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SKILLREINFORCE_AWAKEN"))
  end
end
ReinforceSkill_Init()
function ReinforceSkill_SetData()
  if nil == getSelfPlayer() then
    return
  end
  local selfPlayerLevel = getSelfPlayer():get():getLevel()
  local isClassType = getSelfPlayer():getClassType()
  local reinforcableSkillCount = 0
  if selfPlayerLevel < 50 then
    reinforcableSkillCount = 0
  elseif selfPlayerLevel < 52 then
    reinforcableSkillCount = 1
  elseif selfPlayerLevel < 54 then
    reinforcableSkillCount = 2
  elseif selfPlayerLevel < 56 then
    reinforcableSkillCount = 3
  elseif selfPlayerLevel < 58 then
    reinforcableSkillCount = 4
  elseif selfPlayerLevel < 60 then
    reinforcableSkillCount = 5
  else
    reinforcableSkillCount = 6
  end
  local skillTypeParam = ToClient_GetSelfPlayerSkillType()
  if __eSkillTypeParam_Inherit == skillTypeParam then
    txt_awakenSkillTitle:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SKILLREINFORCE_SUCCESSION"))
  elseif isClassType == __eClassType_ShyWaman then
    txt_awakenSkillTitle:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_SKILLREINFORCE_AWAKEN_BYSHY"))
  else
    txt_awakenSkillTitle:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SKILLREINFORCE_AWAKEN"))
  end
  local normalSkill_ReinforceCount = ToClient_GetSkillAwakeningCount()
  local awakenSkill_ReinforceCount = ToClient_GetWeaponSkillAwakeningCount()
  local successionSkill_ReinforceCount = ToClient_GetSuccessionSkillAwakeningCount()
  local normalSkillNoList = {
    [0] = 0,
    0,
    0
  }
  local normalSkill_ReinforceIndex, awakenSkill_ReinforceIndex = 0, 0
  local reinforceSkillIndex = -1
  for index = 0, reinforceSkillViewCount - 1 do
    local skillSlot = reinforceSkillControl[index]
    if index < normalReinforceSkillCount then
      if index < normalSkill_ReinforceCount then
        skillSlot._skillBg:SetShow(true)
        skillSlot._skillNoSetBg:SetShow(false)
        local reinforceSkillcount = ToClient_GetReAwakeningListCount()
        local skillSSW
        for sIndex = 0, reinforceSkillcount - 1 do
          skillSSW = ToClient_GetReAwakeningListAt(sIndex)
          local awakeningType = skillSSW:getSkillAwakenBranchType()
          if __eSkillTypeParam_Normal == awakeningType and sIndex > reinforceSkillIndex then
            reinforceSkillIndex = sIndex
            break
          end
        end
        if nil ~= skillSSW then
          local skillTypeSSW = skillSSW:getSkillTypeStaticStatusWrapper()
          skillSlot._skillName:SetText(skillSSW:getName())
          skillSlot._skillDesc:SetText(skillTypeSSW:getDescription())
          skillSlot._skillSlot:ChangeTextureInfoName("Icon/" .. skillTypeSSW:getIconPath())
          skillSlot._skillSlotBg:ChangeTextureInfoName("Renewal/PcRemaster/Remaster_Common_00.dds")
          local x1, y1, x2, y2 = setTextureUV_Func(skillSlot._skillSlotBg, 147, 293, 197, 343)
          skillSlot._skillSlotBg:getBaseTexture():setUV(x1, y1, x2, y2)
          skillSlot._skillSlotBg:setRenderTexture(skillSlot._skillSlotBg:getBaseTexture())
          local skillNo = skillSSW:getSkillNo()
          local optionCount = ToClient_GetAwakeningAbilityCount(skillNo)
          skillSlot._skillAttrOptionChange:SetShow(true)
          if 1 == optionCount then
            local optionIndex = ToClient_GetAwakeningAbilityIndex(skillNo, 0)
            skillSlot._skillAttrDesc1:SetText(skillSSW:getSkillAwakenDescription(optionIndex))
            skillSlot._skillAttrDesc1:addInputEvent("Mouse_On", "Panel_ReinforceSkill_DescTooltip(" .. reinforceSkillIndex .. ", " .. skillNo .. ", " .. 0 .. ", " .. index .. ")")
            skillSlot._skillAttrDesc1:addInputEvent("Mouse_Out", "Panel_ReinforceSkill_DescTooltip()")
            skillSlot._skillAttrDesc2:SetText("")
            skillSlot._skillAttrDesc2:addInputEvent("Mouse_On", "")
            skillSlot._skillAttrDesc2:addInputEvent("Mouse_Out", "")
            skillSlot._skillAttrOptionChange:addInputEvent("Mouse_LUp", "Panel_SkillReinforce_Show(" .. 0 .. ", " .. skillNo .. ", " .. reinforceSkillIndex .. ")")
          elseif 2 == optionCount then
            local optionIndex1 = ToClient_GetAwakeningAbilityIndex(skillNo, 0)
            local optionIndex2 = ToClient_GetAwakeningAbilityIndex(skillNo, 1)
            skillSlot._skillAttrDesc1:SetText(skillSSW:getSkillAwakenDescription(optionIndex1))
            skillSlot._skillAttrDesc1:addInputEvent("Mouse_On", "Panel_ReinforceSkill_DescTooltip(" .. reinforceSkillIndex .. ", " .. skillNo .. ", " .. 0 .. ", " .. index .. ")")
            skillSlot._skillAttrDesc1:addInputEvent("Mouse_Out", "Panel_ReinforceSkill_DescTooltip()")
            skillSlot._skillAttrDesc2:SetText(skillSSW:getSkillAwakenDescription(optionIndex2))
            skillSlot._skillAttrDesc2:addInputEvent("Mouse_On", "Panel_ReinforceSkill_DescTooltip(" .. reinforceSkillIndex .. ", " .. skillNo .. ", " .. 1 .. ", " .. index .. ")")
            skillSlot._skillAttrDesc2:addInputEvent("Mouse_Out", "Panel_ReinforceSkill_DescTooltip()")
            skillSlot._skillAttrOptionChange:addInputEvent("Mouse_LUp", "Panel_SkillReinforce_Show(" .. 0 .. ", " .. skillNo .. ", " .. reinforceSkillIndex .. ")")
          else
            skillSlot._skillAttrOptionChange:SetShow(false)
          end
          skillSlot._skillSlot:addInputEvent("Mouse_LUp", "Panel_SkillReinforce_Change(" .. 0 .. "," .. skillNo .. "," .. reinforceSkillIndex .. ")")
          skillSlot._skillSlotBg:addInputEvent("Mouse_LUp", "Panel_SkillReinforce_Change(" .. 0 .. "," .. skillNo .. "," .. reinforceSkillIndex .. ")")
          skillSlot._skillChangeButton:addInputEvent("Mouse_LUp", "Panel_SkillReinforce_Change(" .. 0 .. "," .. skillNo .. "," .. reinforceSkillIndex .. ")")
          skillSlot._skillBg:ChangeTextureInfoName("Renewal/PcRemaster/Remater_ETC_Skill_00.dds")
          local x1, y1, x2, y2 = setTextureUV_Func(skillSlot._skillBg, 1, 1, 772, 86)
          skillSlot._skillBg:getBaseTexture():setUV(x1, y1, x2, y2)
          skillSlot._skillBg:setRenderTexture(skillSlot._skillBg:getBaseTexture())
          normalSkillNoList[index] = skillNo
        end
      else
        skillSlot._skillBg:SetShow(false)
        skillSlot._skillNoSetBg:SetShow(true)
        skillSlot._skillLimitLv:SetText(normalSkillreinforceableLv[index] .. " " .. PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_LV"))
        skillSlot._skillNoSetTitle:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_SKILLREINFORCE_NORMAL_1"))
        if reinforcableSkillCount > index then
          skillSlot._skillNoSetBg:ChangeTextureInfoName("Renewal/PcRemaster/Remater_ETC_Skill_00.dds")
          local x1, y1, x2, y2 = setTextureUV_Func(skillSlot._skillNoSetBg, 1, 87, 772, 172)
          skillSlot._skillNoSetBg:getBaseTexture():setUV(x1, y1, x2, y2)
          skillSlot._skillNoSetBg:setRenderTexture(skillSlot._skillNoSetBg:getBaseTexture())
          skillSlot._skillNoSetBg:SetIgnore(true)
          skillSlot._skillNoSetBg:SetIgnore(false)
          skillSlot._skillLockIcon:SetShow(false)
          skillSlot._skillUnlockIcon:SetShow(false)
          skillSlot._skillLimitLv:SetFontColor(fontColor_NormalLevel)
          skillSlot._skillNoSetTitle:SetFontColor(fontColor_NormalSkill)
        else
          skillSlot._skillNoSetBg:ChangeTextureInfoName("Renewal/PcRemaster/Remater_ETC_Skill_00.dds")
          local x1, y1, x2, y2 = setTextureUV_Func(skillSlot._skillNoSetBg, 1, 345, 772, 430)
          skillSlot._skillNoSetBg:getBaseTexture():setUV(x1, y1, x2, y2)
          skillSlot._skillNoSetBg:setRenderTexture(skillSlot._skillNoSetBg:getBaseTexture())
          skillSlot._skillNoSetBg:SetIgnore(true)
          skillSlot._skillLockIcon:SetShow(false)
          skillSlot._skillUnlockIcon:SetShow(false)
          skillSlot._skillNoSetTitle:SetFontColor(fontColor_Disable)
          skillSlot._skillLimitLv:SetFontColor(fontColor_Disable)
        end
      end
      skillSlot._skillNoSetBg:addInputEvent("Mouse_LUp", "Panel_SkillReinforce_Show(" .. 0 .. ")")
      if index == normalReinforceSkillCount - 1 then
        reinforceSkillIndex = -1
      end
    elseif __eSkillTypeParam_Normal == skillTypeParam or __eSkillTypeParam_Awaken == skillTypeParam then
      if index < awakenSkill_ReinforceCount + 3 then
        skillSlot._skillBg:SetShow(true)
        skillSlot._skillNoSetBg:SetShow(false)
        local reinforceSkillcount = ToClient_GetReAwakeningListCount()
        local skillSSW
        for sIndex = 0, reinforceSkillcount - 1 do
          skillSSW = ToClient_GetReAwakeningListAt(sIndex)
          local awakeningType = skillSSW:getSkillAwakenBranchType()
          if __eSkillTypeParam_Awaken == awakeningType and sIndex > reinforceSkillIndex then
            reinforceSkillIndex = sIndex
            break
          end
        end
        if nil ~= skillSSW then
          local skillTypeSSW = skillSSW:getSkillTypeStaticStatusWrapper()
          skillSlot._skillName:SetText(skillSSW:getName())
          skillSlot._skillDesc:SetText(skillTypeSSW:getDescription())
          skillSlot._skillSlot:ChangeTextureInfoName("Icon/" .. skillTypeSSW:getIconPath())
          skillSlot._skillSlotBg:ChangeTextureInfoName("Renewal/PcRemaster/Remaster_Common_00.dds")
          local x1, y1, x2, y2 = setTextureUV_Func(skillSlot._skillSlotBg, 198, 293, 248, 343)
          skillSlot._skillSlotBg:getBaseTexture():setUV(x1, y1, x2, y2)
          skillSlot._skillSlotBg:setRenderTexture(skillSlot._skillSlotBg:getBaseTexture())
          local skillNo = skillSSW:getSkillNo()
          local optionCount = ToClient_GetAwakeningAbilityCount(skillNo)
          skillSlot._skillAttrOptionChange:SetShow(true)
          if 1 == optionCount then
            local optionIndex = ToClient_GetAwakeningAbilityIndex(skillNo, 0)
            skillSlot._skillAttrDesc1:SetText(skillSSW:getSkillAwakenDescription(optionIndex))
            skillSlot._skillAttrDesc1:addInputEvent("Mouse_On", "Panel_ReinforceSkill_DescTooltip(" .. reinforceSkillIndex .. ", " .. skillNo .. ", " .. 0 .. ", " .. index .. ")")
            skillSlot._skillAttrDesc1:addInputEvent("Mouse_Out", "Panel_ReinforceSkill_DescTooltip()")
            skillSlot._skillAttrDesc2:SetText("")
            skillSlot._skillAttrDesc2:addInputEvent("Mouse_On", "")
            skillSlot._skillAttrDesc2:addInputEvent("Mouse_Out", "")
            skillSlot._skillAttrOptionChange:addInputEvent("Mouse_LUp", "Panel_SkillReinforce_Show(" .. 1 .. ", " .. skillNo .. ", " .. reinforceSkillIndex .. ")")
          elseif 2 == optionCount then
            local optionIndex1 = ToClient_GetAwakeningAbilityIndex(skillNo, 0)
            local optionIndex2 = ToClient_GetAwakeningAbilityIndex(skillNo, 1)
            skillSlot._skillAttrDesc1:SetText(skillSSW:getSkillAwakenDescription(optionIndex1))
            skillSlot._skillAttrDesc1:addInputEvent("Mouse_On", "Panel_ReinforceSkill_DescTooltip(" .. reinforceSkillIndex .. ", " .. skillNo .. ", " .. 0 .. ", " .. index .. ")")
            skillSlot._skillAttrDesc1:addInputEvent("Mouse_Out", "Panel_ReinforceSkill_DescTooltip()")
            skillSlot._skillAttrDesc2:SetText(skillSSW:getSkillAwakenDescription(optionIndex2))
            skillSlot._skillAttrDesc2:addInputEvent("Mouse_On", "Panel_ReinforceSkill_DescTooltip(" .. reinforceSkillIndex .. ", " .. skillNo .. ", " .. 1 .. ", " .. index .. ")")
            skillSlot._skillAttrDesc2:addInputEvent("Mouse_Out", "Panel_ReinforceSkill_DescTooltip()")
            skillSlot._skillAttrOptionChange:addInputEvent("Mouse_LUp", "Panel_SkillReinforce_Show(" .. 1 .. ", " .. skillNo .. ", " .. reinforceSkillIndex .. ")")
          else
            skillSlot._skillAttrOptionChange:SetShow(false)
          end
          skillSlot._skillSlot:addInputEvent("Mouse_LUp", "Panel_SkillReinforce_Change(" .. 1 .. "," .. skillNo .. "," .. reinforceSkillIndex .. ")")
          skillSlot._skillSlotBg:addInputEvent("Mouse_LUp", "Panel_SkillReinforce_Change(" .. 1 .. "," .. skillNo .. "," .. reinforceSkillIndex .. ")")
          skillSlot._skillChangeButton:addInputEvent("Mouse_LUp", "Panel_SkillReinforce_Change(" .. 1 .. "," .. skillNo .. "," .. reinforceSkillIndex .. ")")
          skillSlot._skillBg:ChangeTextureInfoName("Renewal/PcRemaster/Remater_ETC_Skill_00.dds")
          local x1, y1, x2, y2 = setTextureUV_Func(skillSlot._skillBg, 1, 87, 772, 172)
          skillSlot._skillBg:getBaseTexture():setUV(x1, y1, x2, y2)
          skillSlot._skillBg:setRenderTexture(skillSlot._skillBg:getBaseTexture())
        end
      else
        skillSlot._skillBg:SetShow(false)
        skillSlot._skillNoSetBg:SetShow(false == (isClassType == __eClassType_ShyWaman))
        skillSlot._skillLimitLv:SetText(awakenSkillreinforceableLv[index - 3] .. " " .. PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_LV"))
        if isClassType == __eClassType_ShyWaman then
          txt_noSkill:SetShow(true)
        else
          txt_noSkill:SetShow(false)
        end
        skillSlot._skillNoSetTitle:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_SKILLREINFORCE_AWAKEN_1"))
        if reinforcableSkillCount > index then
          skillSlot._skillNoSetBg:ChangeTextureInfoName("Renewal/PcRemaster/Remater_ETC_Skill_00.dds")
          local x1, y1, x2, y2 = setTextureUV_Func(skillSlot._skillNoSetBg, 1, 87, 772, 172)
          skillSlot._skillNoSetBg:getBaseTexture():setUV(x1, y1, x2, y2)
          skillSlot._skillNoSetBg:setRenderTexture(skillSlot._skillNoSetBg:getBaseTexture())
          skillSlot._skillNoSetBg:SetIgnore(true)
          skillSlot._skillNoSetBg:SetIgnore(false)
          skillSlot._skillLockIcon:SetShow(false)
          skillSlot._skillUnlockIcon:SetShow(false)
          skillSlot._skillLimitLv:SetFontColor(fontColor_AwakenLevel)
          skillSlot._skillNoSetTitle:SetFontColor(fontColor_AwakenSkill)
        else
          skillSlot._skillNoSetBg:ChangeTextureInfoName("Renewal/PcRemaster/Remater_ETC_Skill_00.dds")
          local x1, y1, x2, y2 = setTextureUV_Func(skillSlot._skillNoSetBg, 1, 345, 772, 430)
          skillSlot._skillNoSetBg:getBaseTexture():setUV(x1, y1, x2, y2)
          skillSlot._skillNoSetBg:setRenderTexture(skillSlot._skillNoSetBg:getBaseTexture())
          skillSlot._skillNoSetBg:SetIgnore(true)
          skillSlot._skillLockIcon:SetShow(false)
          skillSlot._skillUnlockIcon:SetShow(false)
          skillSlot._skillLimitLv:SetFontColor(fontColor_Disable)
          skillSlot._skillNoSetTitle:SetFontColor(fontColor_Disable)
        end
      end
      skillSlot._skillNoSetBg:addInputEvent("Mouse_LUp", "Panel_SkillReinforce_Show(" .. 1 .. ")")
    else
      if index < successionSkill_ReinforceCount + 3 then
        skillSlot._skillBg:SetShow(true)
        skillSlot._skillNoSetBg:SetShow(false)
        local reinforceSkillcount = ToClient_GetReAwakeningListCount()
        local skillSSW
        local dupCounter = 0
        for sIndex = 0, reinforceSkillcount - 1 do
          skillSSW = ToClient_GetReAwakeningListAt(sIndex)
          if nil ~= skillSSW then
            local awakeningType = skillSSW:getSkillAwakenBranchType()
            local skillNo = skillSSW:getSkillNo()
            if __eSkillTypeParam_Normal == awakeningType then
              if normalSkill_ReinforceCount == dupCounter then
                if reinforceSkillIndex < sIndex then
                  reinforceSkillIndex = sIndex
                  break
                end
              else
                dupCounter = dupCounter + 1
              end
            elseif __eSkillTypeParam_Inherit == awakeningType and sIndex > reinforceSkillIndex then
              reinforceSkillIndex = sIndex
              break
            end
          end
        end
        if nil ~= skillSSW then
          local skillNo = skillSSW:getSkillNo()
          local skillTypeSSW = skillSSW:getSkillTypeStaticStatusWrapper()
          skillSlot._skillName:SetText(skillSSW:getName())
          skillSlot._skillDesc:SetText(skillTypeSSW:getDescription())
          skillSlot._skillSlot:ChangeTextureInfoName("Icon/" .. skillTypeSSW:getIconPath())
          skillSlot._skillSlotBg:ChangeTextureInfoName("Renewal/PcRemaster/Remaster_Common_00.dds")
          local x1, y1, x2, y2 = setTextureUV_Func(skillSlot._skillSlotBg, 198, 293, 248, 343)
          skillSlot._skillSlotBg:getBaseTexture():setUV(x1, y1, x2, y2)
          skillSlot._skillSlotBg:setRenderTexture(skillSlot._skillSlotBg:getBaseTexture())
          local optionCount = ToClient_GetAwakeningAbilityCount(skillNo)
          skillSlot._skillAttrOptionChange:SetShow(true)
          if 1 == optionCount then
            local optionIndex = ToClient_GetAwakeningAbilityIndex(skillNo, 0)
            skillSlot._skillAttrDesc1:SetText(skillSSW:getSkillAwakenDescription(optionIndex))
            skillSlot._skillAttrDesc1:addInputEvent("Mouse_On", "Panel_ReinforceSkill_DescTooltip(" .. reinforceSkillIndex .. ", " .. skillNo .. ", " .. 0 .. ", " .. index .. ")")
            skillSlot._skillAttrDesc1:addInputEvent("Mouse_Out", "Panel_ReinforceSkill_DescTooltip()")
            skillSlot._skillAttrDesc2:SetText("")
            skillSlot._skillAttrDesc2:addInputEvent("Mouse_On", "")
            skillSlot._skillAttrDesc2:addInputEvent("Mouse_Out", "")
            skillSlot._skillAttrOptionChange:addInputEvent("Mouse_LUp", "Panel_SkillReinforce_Show(" .. __eSkillTypeParam_Inherit .. ", " .. skillNo .. ", " .. reinforceSkillIndex .. ")")
          elseif 2 == optionCount then
            local optionIndex1 = ToClient_GetAwakeningAbilityIndex(skillNo, 0)
            local optionIndex2 = ToClient_GetAwakeningAbilityIndex(skillNo, 1)
            skillSlot._skillAttrDesc1:SetText(skillSSW:getSkillAwakenDescription(optionIndex1))
            skillSlot._skillAttrDesc1:addInputEvent("Mouse_On", "Panel_ReinforceSkill_DescTooltip(" .. reinforceSkillIndex .. ", " .. skillNo .. ", " .. 0 .. ", " .. index .. ")")
            skillSlot._skillAttrDesc1:addInputEvent("Mouse_Out", "Panel_ReinforceSkill_DescTooltip()")
            skillSlot._skillAttrDesc2:SetText(skillSSW:getSkillAwakenDescription(optionIndex2))
            skillSlot._skillAttrDesc2:addInputEvent("Mouse_On", "Panel_ReinforceSkill_DescTooltip(" .. reinforceSkillIndex .. ", " .. skillNo .. ", " .. 1 .. ", " .. index .. ")")
            skillSlot._skillAttrDesc2:addInputEvent("Mouse_Out", "Panel_ReinforceSkill_DescTooltip()")
            skillSlot._skillAttrOptionChange:addInputEvent("Mouse_LUp", "Panel_SkillReinforce_Show(" .. __eSkillTypeParam_Inherit .. ", " .. skillNo .. ", " .. reinforceSkillIndex .. ")")
          else
            skillSlot._skillAttrOptionChange:SetShow(false)
          end
          skillSlot._skillSlot:addInputEvent("Mouse_LUp", "Panel_SkillReinforce_Change(" .. __eSkillTypeParam_Inherit .. "," .. skillNo .. "," .. reinforceSkillIndex .. ")")
          skillSlot._skillSlotBg:addInputEvent("Mouse_LUp", "Panel_SkillReinforce_Change(" .. __eSkillTypeParam_Inherit .. "," .. skillNo .. "," .. reinforceSkillIndex .. ")")
          skillSlot._skillChangeButton:addInputEvent("Mouse_LUp", "Panel_SkillReinforce_Change(" .. __eSkillTypeParam_Inherit .. "," .. skillNo .. "," .. reinforceSkillIndex .. ")")
          skillSlot._skillBg:ChangeTextureInfoName("Renewal/PcRemaster/Remater_ETC_Skill_00.dds")
          local x1, y1, x2, y2 = setTextureUV_Func(skillSlot._skillBg, 1, 87, 772, 172)
          skillSlot._skillBg:getBaseTexture():setUV(x1, y1, x2, y2)
          skillSlot._skillBg:setRenderTexture(skillSlot._skillBg:getBaseTexture())
        end
      else
        skillSlot._skillBg:SetShow(false)
        skillSlot._skillNoSetBg:SetShow(false == (isClassType == __eClassType_ShyWaman))
        skillSlot._skillLimitLv:SetText(awakenSkillreinforceableLv[index - 3] .. " " .. PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_LV"))
        if isClassType == __eClassType_ShyWaman then
          txt_noSkill:SetShow(true)
        else
          txt_noSkill:SetShow(false)
        end
        skillSlot._skillNoSetTitle:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_SKILLREINFORCE_SUCCESSION_1"))
        if reinforcableSkillCount > index then
          skillSlot._skillNoSetBg:ChangeTextureInfoName("Renewal/PcRemaster/Remater_ETC_Skill_00.dds")
          local x1, y1, x2, y2 = setTextureUV_Func(skillSlot._skillNoSetBg, 1, 87, 772, 172)
          skillSlot._skillNoSetBg:getBaseTexture():setUV(x1, y1, x2, y2)
          skillSlot._skillNoSetBg:setRenderTexture(skillSlot._skillNoSetBg:getBaseTexture())
          skillSlot._skillNoSetBg:SetIgnore(true)
          skillSlot._skillNoSetBg:SetIgnore(false)
          skillSlot._skillLockIcon:SetShow(false)
          skillSlot._skillUnlockIcon:SetShow(false)
          skillSlot._skillLimitLv:SetFontColor(fontColor_AwakenLevel)
          skillSlot._skillNoSetTitle:SetFontColor(fontColor_AwakenSkill)
        else
          skillSlot._skillNoSetBg:ChangeTextureInfoName("Renewal/PcRemaster/Remater_ETC_Skill_00.dds")
          local x1, y1, x2, y2 = setTextureUV_Func(skillSlot._skillNoSetBg, 1, 345, 772, 430)
          skillSlot._skillNoSetBg:getBaseTexture():setUV(x1, y1, x2, y2)
          skillSlot._skillNoSetBg:setRenderTexture(skillSlot._skillNoSetBg:getBaseTexture())
          skillSlot._skillNoSetBg:SetIgnore(true)
          skillSlot._skillLockIcon:SetShow(false)
          skillSlot._skillUnlockIcon:SetShow(false)
          skillSlot._skillLimitLv:SetFontColor(fontColor_Disable)
          skillSlot._skillNoSetTitle:SetFontColor(fontColor_Disable)
        end
      end
      skillSlot._skillNoSetBg:addInputEvent("Mouse_LUp", "Panel_SkillReinforce_Show(" .. __eSkillTypeParam_Inherit .. ")")
    end
  end
end
function Panel_ReinforceSkill_Show()
  if not ToClient_IsContentsGroupOpen("203") then
    return
  end
  Panel_Window_ReinforceSkill:SetShow(true, true)
  ReinforceSkill_SetData()
end
function Panel_ReinforceSkill_DescTooltip(reinforceIndex, skillNo, uiIndex, index)
  if nil == index then
    TooltipSimple_Hide()
    return
  end
  local control
  local name = ""
  local optionIndex = ToClient_GetAwakeningAbilityIndex(skillNo, uiIndex)
  local skillSSW = ToClient_GetReAwakeningListAt(reinforceIndex)
  if nil ~= skillSSW then
    name = skillSSW:getSkillAwakenDescription(optionIndex)
  end
  if 0 == uiIndex then
    control = reinforceSkillControl[index]._skillAttrDesc1
  else
    control = reinforceSkillControl[index]._skillAttrDesc2
  end
  TooltipSimple_Show(control, name)
end
function ReinforceSkill_ButtonTooltip(btnType, index)
  if nil == btnType then
    TooltipSimple_Hide()
    return
  end
  local control, name
  if 0 == btnType then
    control = reinforceSkillControl[index]._skillChangeButton
    name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SKILLREINFORCE_CHANGESKILL")
  elseif 1 == btnType then
    control = reinforceSkillControl[index]._skillAttrOptionChange
    name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SKILLREINFORCE_CHANGEOPTION")
  end
  TooltipSimple_Show(control, name)
end
registerEvent("EventShowAwakenSkill", "Panel_ReinforceSkill_Show")
