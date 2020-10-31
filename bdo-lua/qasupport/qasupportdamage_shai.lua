local Mindamage = 0
local Maxdamage = 0
local SumCountDamage = 0
function StartQAequipArmor()
  ToClient_qaDebugDamage(0, 1, 1)
end
function StartQASkillUse(SkillQaNumber)
  ToClient_qaDebugDamage(1, SkillQaNumber)
end
function StartQASkillUseShai(ST)
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  luaTimer_AddEvent(ShaiSkill, 0, false, 0, ST, 3841)
  luaTimer_AddEvent(ShaiSkill, 0, false, 0, ST, 3842)
  luaTimer_AddEvent(ShaiSkill, 0, false, 0, ST, 3843)
  luaTimer_AddEvent(ShaiSkill, 0, false, 0, ST, 3844)
  luaTimer_AddEvent(ShaiSkill, 0, false, 0, ST, 3845)
  luaTimer_AddEvent(ShaiSkill, 0, false, 0, ST, 3846)
  luaTimer_AddEvent(ShaiSkill, 0, false, 0, ST, 3847)
  luaTimer_AddEvent(ShaiSkill, 0, false, 0, ST, 3848)
  luaTimer_AddEvent(ShaiSkill, 0, false, 0, ST, 3849)
  luaTimer_AddEvent(ShaiSkill, 0, false, 0, ST, 3850)
  luaTimer_AddEvent(ShaiSkill, 0, false, 0, ST, 3851)
  luaTimer_AddEvent(ShaiSkill, 0, false, 0, ST, 3852)
  luaTimer_AddEvent(ShaiSkill, 0, false, 0, ST, 3853)
  luaTimer_AddEvent(ShaiSkill, 0, false, 0, ST, 3854)
  luaTimer_AddEvent(ShaiSkill, 0, false, 0, ST, 3862)
  luaTimer_AddEvent(ShaiSkill, 0, false, 0, ST, 3863)
  luaTimer_AddEvent(ShaiSkill, 0, false, 0, ST, 3864)
  luaTimer_AddEvent(ShaiSkill, 0, false, 0, ST, 3865)
  luaTimer_AddEvent(ShaiSkill, 0, false, 0, ST, 3866)
  luaTimer_AddEvent(ShaiSkill, 0, false, 0, ST, 3867)
  luaTimer_AddEvent(ShaiSkill, 0, false, 0, ST, 3868)
  luaTimer_AddEvent(ShaiSkill, 0, false, 0, ST, 3869)
  luaTimer_AddEvent(ShaiSkill, 0, false, 0, ST, 3870)
  luaTimer_AddEvent(ShaiSkill, 0, false, 0, ST, 3871)
  luaTimer_AddEvent(ShaiSkill, 0, false, 0, ST, 3872)
  luaTimer_AddEvent(ShaiSkill, 0, false, 0, ST, 3873)
  luaTimer_AddEvent(ShaiSkill, 0, false, 0, ST, 3874)
  luaTimer_AddEvent(ShaiSkill, 0, false, 0, ST, 3875)
  luaTimer_AddEvent(ShaiSkill, 0, false, 0, ST, 3876)
  luaTimer_AddEvent(ShaiSkill, 0, false, 0, ST, 3877)
  luaTimer_AddEvent(ShaiSkill, 0, false, 0, ST, 3878)
  luaTimer_AddEvent(ShaiSkill, 0, false, 0, ST, 3879)
  luaTimer_AddEvent(ShaiSkill, 0, false, 0, ST, 3880)
  luaTimer_AddEvent(ShaiSkill, 0, false, 0, ST, 3881)
  luaTimer_AddEvent(ShaiSkill, 0, false, 0, ST, 3882)
  luaTimer_AddEvent(ShaiSkill, 0, false, 0, ST, 3883)
  luaTimer_AddEvent(ShaiSkill, 0, false, 0, ST, 3884)
  luaTimer_AddEvent(ShaiSkill, 0, false, 0, ST, 3887)
  luaTimer_AddEvent(ShaiSkill, 0, false, 0, ST, 3888)
  luaTimer_AddEvent(ShaiSkill, 0, false, 0, ST, 3889)
  luaTimer_AddEvent(ShaiSkill, 0, false, 0, ST, 4101)
  luaTimer_AddEvent(ShaiSkill, 0, false, 0, ST, 4229)
  luaTimer_AddEvent(ShaiSkill, 0, false, 0, ST, 4100)
  chatting_sendMessage("", "Shai SkillTest End(PVP)", CppEnums.ChatType.Private)
end
function ShaiSkill(ST, SkillNo)
  if ST == 1 then
    ToClient_qaDebugDamage(1, SkillNo)
  elseif ST == 2 then
  end
end
