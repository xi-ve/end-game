function PaGlobalFunc_GuildAllianceList_All_Open()
  local myAllianceWrapper = ToClient_GetMyGuildAllianceWrapper()
  if nil == myAllianceWrapper then
    PaGlobal_GuildMain_All._ui.stc_AllianceList_Bg:SetShow(false)
    return
  end
  PaGlobal_GuildAllianceList_All._currentClickGuild = -1
  PaGlobal_GuildAllianceList_All:UpdateAliyNotice(myAllianceWrapper)
  PaGlobal_GuildAllianceList_All:update()
  HandleEventOn_GuildAlliance_All_ResetScrollPos()
end
function PaGlobalFunc_GuildAllianceList_All_ResetUrl()
  if true == _ContentsGroup_RenewUI then
    return
  end
  if nil ~= PaGlobal_GuildAllianceList_All._ui.stc_webControl then
    PaGlobal_GuildAllianceList_All._ui.stc_webControl:ResetUrl()
  end
end
function HandleEventLUp_GuildAllianceList_All_SetGuildMemberShow(index)
  if nil == index then
    return
  end
  local myAllianceWrapper = ToClient_GetMyGuildAllianceWrapper()
  if nil == myAllianceWrapper then
    return
  end
  if nil == PaGlobal_GuildAllianceList_All._ui._chkBox[index] then
    return
  end
  local btn = PaGlobal_GuildAllianceList_All._ui._chkBox[index]
  if PaGlobal_GuildAllianceList_All._currentClickGuild == index then
    btn:SetCheck(false)
    PaGlobal_GuildAllianceList_All._currentClickGuild = -1
    PaGlobal_GuildAllianceList_All:updateAllGuildMember()
    return
  else
    local guildWrapper = myAllianceWrapper:getMemberGuild(Int64toInt32(index))
    if nil ~= guildWrapper then
      PaGlobal_GuildAllianceList_All._currentClickGuild = index
      btn:SetCheck(true)
      PaGlobal_GuildAllianceList_All._ui.list2_Member:getElementManager():clearKey()
      local guildMembercount = guildWrapper:getMemberCount()
      for idx = 0, guildMembercount - 1 do
        local memberWrapper = guildWrapper:getMember(Int64toInt32(idx))
        if nil == memberWrapper then
          return
        end
        local nickName = memberWrapper:getName()
        local characterName = memberWrapper:getCharacterName()
        PaGlobal_GuildAllianceList_All._ui.list2_Member:getElementManager():pushKey(memberWrapper:getUserNo())
      end
    end
  end
end
function FromClient_GuildAlliance_All_List2GuildUpdate(content, key)
  if nil == key then
    return
  end
  local key32 = Int64toInt32(key)
  local btn = UI.getChildControl(content, "Button_Party")
  local masterIcon = UI.getChildControl(btn, "Static_MasterIcon")
  local guildName = UI.getChildControl(btn, "StaticText_GuildName")
  local memberCount = UI.getChildControl(btn, "StaticText_GuildMember")
  local curIdx = PaGlobal_GuildAllianceList_All._currentClickGuild
  btn:SetCheck(false)
  if key32 == curIdx then
    btn:SetCheck(true)
  end
  btn:SetShow(false)
  masterIcon:SetShow(false)
  local allianceWrapper = ToClient_GetMyGuildAllianceWrapper()
  if nil == allianceWrapper then
    return
  end
  local guildWrapper = allianceWrapper:getMemberGuild(key32)
  if nil == guildWrapper then
    return
  end
  local isAllianceChairman = guildWrapper:isAllianceChair()
  btn:SetShow(true)
  masterIcon:SetShow(isAllianceChairman)
  if true == isAllianceChairman then
    guildName:SetFontColor(Defines.Color.C_FFF5BA3A)
    memberCount:SetFontColor(Defines.Color.C_FFF5BA3A)
  else
    guildName:SetFontColor(Defines.Color.C_FFEFEFEF)
    memberCount:SetFontColor(Defines.Color.C_FFEFEFEF)
  end
  guildName:SetText(guildWrapper:getName())
  memberCount:SetText(guildWrapper:getMemberCount())
  btn:addInputEvent("Mouse_LUp", "HandleEventLUp_GuildAllianceList_All_SetGuildMemberShow(" .. key32 .. ")")
  PaGlobal_GuildAllianceList_All._ui._chkBox[key32] = btn
end
function FromClient_GuildAlliance_All_List2MemberUpdate(content, key)
  if nil == key then
    return
  end
  local key32 = Int64toInt32(key)
  local stc_tempList = UI.getChildControl(content, "Static_List_Temp")
  local stc_gradeIcon = UI.getChildControl(stc_tempList, "StaticText_C_Grade")
  local txt_level = UI.getChildControl(stc_tempList, "StaticText_C_Level")
  local txt_class = UI.getChildControl(stc_tempList, "StaticText_C_Class")
  local txt_famName = UI.getChildControl(stc_tempList, "StaticText_C_CharName")
  local txt_guildName = UI.getChildControl(stc_tempList, "StaticText_C_GuildName")
  stc_tempList:SetShow(false)
  stc_tempList:SetIgnore(false)
  stc_tempList:addInputEvent("Mouse_On", "HandleEventOn_GuildAlliance_All_SaveScrollPos()")
  local allianceWrapper = ToClient_GetMyGuildAllianceWrapper()
  if nil == allianceWrapper then
    return
  end
  local member = allianceWrapper:getMemberByUserNo(key)
  if nil == member then
    return
  end
  local guild = member:getGuildName()
  local grade = member:getGrade()
  local level = member:getLevel()
  local classType = CppEnums.ClassType2String[member:getClassType()]
  local nickName = member:getName()
  local isOnline = member:isOnline()
  local isGhostMode = member:isGhostMode()
  local isVacation = member:isVacation()
  local classString = "-"
  local levelString = "-"
  local charString = "-"
  local gradeTooltipType
  stc_tempList:SetShow(true)
  if true == isVacation then
    gradeTooltipType = -1
    stc_gradeIcon:SetMonoTone(true)
    txt_level:SetFontColor(Defines.Color.C_FF515151)
    txt_class:SetFontColor(Defines.Color.C_FF515151)
    txt_famName:SetFontColor(Defines.Color.C_FF515151)
    txt_guildName:SetFontColor(Defines.Color.C_FF515151)
  else
    stc_gradeIcon:SetMonoTone(false)
    txt_level:SetFontColor(Defines.Color.C_FFC4BEBE)
    txt_class:SetFontColor(Defines.Color.C_FFC4BEBE)
    txt_famName:SetFontColor(Defines.Color.C_FFC4BEBE)
    txt_guildName:SetFontColor(Defines.Color.C_FFC4BEBE)
  end
  if true == isOnline and false == isGhostMode then
    classString = classType
    levelString = level
  end
  txt_guildName:SetText(guild)
  txt_level:SetText(levelString)
  txt_class:SetText(classString)
  txt_famName:SetText(nickName)
  local x1, y1, x2, y2 = 0, 0, 0, 0
  stc_gradeIcon:ChangeTextureInfoName("new_ui_common_forlua/window/guild/guild_00.dds")
  stc_gradeIcon:SetIgnore(false)
  if __eGuildMemberGradeMaster == grade then
    x1, y1, x2, y2 = setTextureUV_Func(stc_gradeIcon, 424, 159, 467, 185)
    gradeTooltipType = 0
  elseif __eGuildMemberGradeSubMaster == grade then
    x1, y1, x2, y2 = setTextureUV_Func(stc_gradeIcon, 468, 159, 511, 185)
    gradeTooltipType = 1
  elseif __eGuildMemberGradeNormal == grade then
    x1, y1, x2, y2 = setTextureUV_Func(stc_gradeIcon, 468, 219, 511, 245)
    gradeTooltipType = 2
  elseif __eGuildMemberGradeSupplyOfficer == grade then
    x1, y1, x2, y2 = setTextureUV_Func(stc_gradeIcon, 424, 219, 467, 245)
    gradeTooltipType = 3
  elseif __eGuildMemberGradeJunior == grade then
    stc_gradeIcon:ChangeTextureInfoName("Renewal/PcRemaster/Remaster_ETC_Guild01.dds")
    x1, y1, x2, y2 = setTextureUV_Func(stc_gradeIcon, 1, 1, 44, 27)
    gradeTooltipType = 4
  else
    x1, y1, x2, y2 = setTextureUV_Func(stc_gradeIcon, 468, 219, 511, 245)
  end
  stc_gradeIcon:getBaseTexture():setUV(x1, y1, x2, y2)
  stc_gradeIcon:setRenderTexture(stc_gradeIcon:getBaseTexture())
  if nil == gradeTooltipType then
    stc_gradeIcon:addInputEvent("Mouse_On", "")
    stc_gradeIcon:addInputEvent("Mouse_Out", "")
  else
    stc_gradeIcon:addInputEvent("Mouse_On", "HandleEventOnOut_GuildAlliance_All_GradeTooltip(" .. key32 .. "," .. gradeTooltipType .. ")")
    stc_gradeIcon:addInputEvent("Mouse_Out", "HandleEventOnOut_GuildAlliance_All_GradeTooltip()")
  end
  PaGlobal_GuildAllianceList_All._ui._list2UI[key32] = stc_gradeIcon
end
function HandleEventOnOut_GuildAlliance_All_TerritortyTooltip(isShow)
  if false == isShow then
    TooltipSimple_Hide()
    return
  end
  local control, name
  control = PaGlobal_GuildAllianceList_All._ui.txt_Territory
  name = PaGlobal_GuildAllianceList_All._ui.txt_Territory:GetText()
  TooltipSimple_Show(control, name, nil)
end
function HandleEventOnOut_GuildAlliance_All_GradeTooltip(index, type)
  if nil == type or nil == index then
    TooltipSimple_Hide()
    return
  end
  local control, name
  control = PaGlobal_GuildAllianceList_All._ui._list2UI[index]
  if nil == control then
    TooltipSimple_Hide()
    return
  end
  name = PAGetString(Defines.StringSheet_GAME, PaGlobal_GuildAllianceList_All._gradeString[type])
  TooltipSimple_Show(control, name, nil)
end
function HandleEventOn_GuildAlliance_All_SaveScrollPos()
  PaGlobal_GuildAllianceList_All._scrollData._pos = PaGlobal_GuildAllianceList_All._ui.list2_Member:GetVScroll():GetControlPos()
  PaGlobal_GuildAllianceList_All._scrollData._idx = PaGlobal_GuildAllianceList_All._ui.list2_Member:getCurrenttoIndex()
end
function HandleEventOn_GuildAlliance_All_LoadScrollPos()
  if nil == PaGlobal_GuildAllianceList_All._scrollData._pos or nil == PaGlobal_GuildAllianceList_All._scrollData._idx then
    return
  end
  PaGlobal_GuildAllianceList_All._ui.list2_Member:GetVScroll():SetControlPos(PaGlobal_GuildAllianceList_All._scrollData._pos)
  PaGlobal_GuildAllianceList_All._ui.list2_Member:setCurrenttoIndex(PaGlobal_GuildAllianceList_All._scrollData._idx)
end
function HandleEventOn_GuildAlliance_All_ResetScrollPos()
  PaGlobal_GuildAllianceList_All._scrollData._pos = nil
  PaGlobal_GuildAllianceList_All._scrollData._idx = nil
end
