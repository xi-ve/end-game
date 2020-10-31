function FromClient_BossSpawnUpdateStatus(key)
  local self = PaGlobal_GuildBossSpawn
  self:updateState(key)
end
function FromClient_BossSpawnClearCount()
  Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_NEW_GUILDRAID_SUMMON_RESET"))
end
function PaGlobal_GuildBossList_CreateControlList2(content, key)
  local self = PaGlobal_GuildBossSpawn
  local bossKey = BossSpawnKey(Int64toInt32(key))
  local level = 0
  local btn_main = UI.getChildControl(content, "Button_Template")
  local mainBg = UI.getChildControl(btn_main, "Static_BG")
  local txt_count = UI.getChildControl(btn_main, "StaticText_Count")
  local txt_bossName = UI.getChildControl(btn_main, "StaticText_BossName")
  local txt_cost = UI.getChildControl(btn_main, "StaticText_Stack")
  local rewardSlotBg = UI.getChildControl(btn_main, "Static_Reward")
  local rewardIcon = UI.getChildControl(rewardSlotBg, "Static_ItemIcon")
  local btn_findPos = UI.getChildControl(btn_main, "Button_FindPlace")
  local btn_summon = UI.getChildControl(btn_main, "Button_Summon")
  btn_findPos:addInputEvent("Mouse_LUp", "PaGlobal_GuildBossSpawn:requestFindPosition(" .. bossKey:get() .. ")")
  btn_summon:addInputEvent("Mouse_LUp", "PaGlobal_GuildBossSpawn:requestGuildBossSpawn(" .. bossKey:get() .. ")")
  local successImg = UI.getChildControl(btn_main, "Static_Success")
  local levelBg = UI.getChildControl(btn_main, "Static_DifficultyArea")
  local txt_level = UI.getChildControl(levelBg, "StaticText_DifficultyName")
  local btn_level_prev = UI.getChildControl(levelBg, "Button_Left")
  local btn_level_next = UI.getChildControl(levelBg, "Button_Right")
  btn_level_prev:SetShow(false)
  btn_level_next:SetShow(true)
  btn_level_prev:addInputEvent("Mouse_LUp", "PaGlobal_GuildBossSpawn:selectLevelPrev(" .. bossKey:get() .. ")")
  btn_level_next:addInputEvent("Mouse_LUp", "PaGlobal_GuildBossSpawn:selectLevelNext(" .. bossKey:get() .. ")")
  local txt_condition = UI.getChildControl(btn_main, "StaticText_Condition")
  local pos = ToClient_bossSpawnPosition(bossKey)
  local range = ToClient_bossSpawnRange(bossKey)
  local info = {
    x = 0,
    y = 0,
    z = 0,
    range = 0,
    state = self._state.StateMax,
    mainBg = nil,
    rewardIcon = nil,
    btn_findPos = nil,
    btn_summon = nil,
    txt_cost = nil,
    successImg = nil,
    levelBg = nil,
    txt_level = nil,
    btn_level_prev = nil,
    btn_level_next = nil,
    txt_condition = nil,
    rewardIcon = nil,
    txt_bossName = nil,
    txt_cost = nil,
    txt_count = nil
  }
  info.x = pos.x
  info.y = pos.y
  info.z = pos.z
  info.range = range
  info.mainBg = mainBg
  info.rewardIcon = rewardIcon
  info.btn_findPos = btn_findPos
  info.btn_summon = btn_summon
  info.txt_cost = txt_cost
  info.successImg = successImg
  info.levelBg = levelBg
  info.txt_level = txt_level
  info.level = level
  info.btn_level_prev = btn_level_prev
  info.btn_level_next = btn_level_next
  info.txt_condition = txt_condition
  info.rewardIcon = rewardIcon
  info.txt_bossName = txt_bossName
  info.txt_cost = txt_cost
  info.txt_count = txt_count
  self._bossSpawnInfoList[bossKey:get()] = info
  self:selectLevel(bossKey:get(), level)
  self:updateState(bossKey:get())
end
