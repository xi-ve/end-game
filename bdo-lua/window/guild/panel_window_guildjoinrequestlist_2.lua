function PaGlobal_GuildJoinRequestList_CreateControlList2(content, index)
  local self = PaGlobal_GuildJoinRequestList
  local key = Int64toInt32(index)
  local applicantInfoWrapper = ToClient_getGuildApplicantInfoWrapper(key)
  if nil == applicantInfoWrapper then
    return
  end
  local txt_charName = UI.getChildControl(content, "StaticText_CharName")
  local txt_class = UI.getChildControl(content, "StaticText_Class")
  local txt_level = UI.getChildControl(content, "StaticText_Level")
  local txt_contributedTendency = UI.getChildControl(content, "StaticText_ContributedTendency")
  local txt_attack = UI.getChildControl(content, "StaticText_Attack")
  local txt_awakenAttack = UI.getChildControl(content, "StaticText_AwakenAttack")
  local txt_defence = UI.getChildControl(content, "StaticText_Defence")
  local btn_whisper = UI.getChildControl(content, "Button_Whisper")
  local btn_delete = UI.getChildControl(content, "Button_Delete")
  btn_whisper:addInputEvent("Mouse_LUp", "PaGlobal_GuildJoinRequestList:WhisperToPlayer(" .. key .. ")")
  btn_delete:addInputEvent("Mouse_LUp", "PaGlobal_GuildJoinRequestList:requestDeleteApplicant(" .. key .. ")")
  txt_charName:SetText(tostring(applicantInfoWrapper:getUserNickName() .. "(" .. applicantInfoWrapper:getCharacterName() .. ")"))
  txt_class:SetText(CppEnums.ClassType2String[applicantInfoWrapper:getClassType()])
  txt_level:SetText(tostring(applicantInfoWrapper:getLevel()))
  txt_contributedTendency:SetText(tostring(applicantInfoWrapper:getWp() .. " / " .. applicantInfoWrapper:getExplorationPoint()))
end
function FromClient_loadCompleteGuildApplicants()
  local self = PaGlobal_GuildJoinRequestList
  self.update()
end
function FromClient_deleteGuildApplicant_Guild()
  local self = PaGlobal_GuildJoinRequestList
  self.update()
end
