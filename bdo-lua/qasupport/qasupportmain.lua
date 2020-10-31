function testCreate()
  ToClient_qaCreateItem(10010, 15, 1)
end
function jtg()
  _PA_LOG("\236\160\149\237\131\156\234\179\164", "ToClient_CheckCameraSet() : " .. ToClient_CheckCameraSet())
end
function workerready(level)
  ToClient_qaCreateItem(64204, 0, 1)
  ToClient_qaCreateItem(64205, 0, 1)
  ToClient_qaCreateItem(64206, 0, 1)
  ToClient_qaCreateItem(64214, 0, 1)
  ToClient_qaCreateItem(64215, 0, 1)
  ToClient_qaCreateItem(64216, 0, 1)
  ToClient_qaCreateItem(64234, 0, 1)
  ToClient_qaCreateItem(64235, 0, 1)
  ToClient_qaCreateItem(64236, 0, 1)
  ToClient_qaCreateItem(64264, 0, 1)
  ToClient_qaCreateItem(64265, 0, 1)
  ToClient_qaCreateItem(64266, 0, 1)
  ToClient_qaCreateItem(64320, 0, 1)
  ToClient_qaCreateItem(64321, 0, 1)
  ToClient_qaCreateItem(64322, 0, 1)
  ToClient_qaCreateItem(64304, 0, 1)
  ToClient_qaCreateItem(64305, 0, 1)
  ToClient_qaCreateItem(64306, 0, 1)
  ToClient_qaLevelUpAllWorker(level)
  ToClient_qaCreateItem(9213, 0, 1000)
  ToClient_qaCreateItem(9283, 0, 500)
end
function unlimit1()
  chatting_sendMessage("", "/setallgrowstep 1", CppEnums.ChatType.Public, CppEnums.ChatSystemType.Undefine)
  Proc_ShowMessage_Ack("<PAColor0xFFF26A6A>\234\183\184\235\158\152\235\143\132 \236\139\156\236\149\188\234\176\129/\236\185\180\235\169\148\235\157\188 \236\161\176\236\160\136 \236\149\136\235\144\152\235\169\180 \234\178\140\236\158\132\236\132\164\236\160\149(\236\132\177\235\138\165->\236\185\180\235\169\148\235\157\188\236\151\144\236\132\156 \236\161\176\236\160\136)<PAOldColor>")
  ToClient_qaCompleteQuest(21001, 1)
  Proc_ShowMessage_Ack("\235\172\180\236\151\173 \236\152\164\237\148\136 21001, 1 \236\151\144 \237\149\180\235\139\185\237\149\152\235\138\148 \237\128\152\236\138\164\237\138\184\234\176\128 \236\153\132\235\163\140\235\144\152\236\151\136\236\138\181\235\139\136\235\139\164.")
  ToClient_qaCompleteQuest(653, 6)
  Proc_ShowMessage_Ack("\236\158\160\236\158\172\235\160\165 \235\143\140\237\140\140\235\165\188 \236\130\172\236\154\169\237\149\160 \236\136\152 \236\158\136\234\178\140\235\144\152\236\151\136\236\138\181\235\139\136\235\139\164.")
end
function runAutoFrameCheck()
  FGlobal_AutoFrameCheck_setMinFrame(25)
  FGlobal_setAutoFrameCheckRepeat(true)
  FGlobal_AutoFrameCheck_addPositionList(100, 100, 100)
  FGlobal_AutoFrameCheck_Start()
end
function behero()
  ToClient_qaCreateItem(9693, 0, 10)
  ToClient_qaCreateItem(793, 0, 20)
  ToClient_qaCreateItem(45220, 0, 1)
  ToClient_qaCreateItem(45252, 0, 1)
  ToClient_qaCreateItem(45284, 0, 1)
  ToClient_qaCreateItem(65475, 0, 10)
  ToClient_qaCreateItem(65476, 0, 10)
  ToClient_qaCreateItem(65477, 0, 10)
  ToClient_qaCreateItem(65478, 0, 10)
  ToClient_qaCreateItem(65479, 0, 10)
  ToClient_qaCreateItem(65480, 0, 10)
  ToClient_qaCreateItem(65481, 0, 10)
  ToClient_qaCreateItem(65482, 0, 10)
  ToClient_qaCreateItem(43706, 0, 1)
  ToClient_qaCreateItem(65492, 0, 1)
  ToClient_qaCreateItem(65493, 0, 1)
  ToClient_qaCreateItem(65494, 0, 1)
end
function createSkillPoint(sp)
  local skillPointInfo = ToClient_getSkillPointInfo(0)
  if -1 == skillPointInfo then
    return
  end
  self._acquireSkillPoint = skillPointInfo._acquirePoint
  if self._acquireSkillPoint > 5000 then
    Proc_ShowMessage_Ack("\236\138\164\237\130\172 \237\143\172\236\157\184\237\138\184 \235\179\180\236\156\160\235\159\137\236\157\180 \235\132\136\235\172\180 \235\167\142\236\149\132 \236\131\157\236\132\177\236\157\180 \236\160\156\237\149\156\235\144\169\235\139\136\235\139\164.")
    return
  else
    ToClient_qaCreateItem(60, 0, sp / 10)
  end
end
function warready(enchantLevel)
  ToClient_qaCreateItem(65488, 0, 2)
  ToClient_qaLevelUp(60)
  createBossWeapon(enchantLevel)
  awakening(enchantLevel)
  createBossArmor(enchantLevel)
  createAccessory(enchantLevel)
  createSkillPoint(3000)
  luaTimer_AddEvent(equipAllItems, 2000, false, 0, enchantLevel)
  luaTimer_AddEvent(equipAccessory, 1000, false, 0, enchantLevel)
end
function awakening()
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  local isClassType = selfPlayer:getClassType()
  if isClassType == __eClassType_Warrior then
    ToClient_qaCompleteQuest(285, 4)
    ToClient_qaCreateItem(142, 0, 1)
    ToClient_qaCreateItem(143, 0, 2)
    ToClient_qaCreateItem(144, 0, 3)
    ToClient_qaCreateItem(191, 0, 1)
  elseif isClassType == __eClassType_ElfRanger then
    ToClient_qaCompleteQuest(293, 4)
    ToClient_qaCreateItem(151, 0, 1)
    ToClient_qaCreateItem(152, 0, 1)
    ToClient_qaCreateItem(153, 0, 1)
    ToClient_qaCreateItem(193, 0, 1)
  elseif isClassType == __eClassType_Sorcerer then
    ToClient_qaCompleteQuest(287, 4)
    ToClient_qaCreateItem(145, 0, 1)
    ToClient_qaCreateItem(146, 0, 1)
    ToClient_qaCreateItem(147, 0, 1)
    ToClient_qaCreateItem(196, 0, 1)
  elseif isClassType == __eClassType_Giant then
    ToClient_qaCompleteQuest(290, 4)
    ToClient_qaCreateItem(148, 0, 1)
    ToClient_qaCreateItem(149, 0, 1)
    ToClient_qaCreateItem(150, 0, 1)
    ToClient_qaCreateItem(724004, 0, 1)
  elseif isClassType == __eClassType_Tamer then
    ToClient_qaCompleteQuest(296, 4)
    ToClient_qaCreateItem(154, 0, 1)
    ToClient_qaCreateItem(155, 0, 1)
    ToClient_qaCreateItem(156, 0, 1)
    ToClient_qaCreateItem(197, 0, 1)
  elseif isClassType == __eClassType_BladeMaster then
    ToClient_qaCompleteQuest(319, 4)
    ToClient_qaCreateItem(160, 0, 1)
    ToClient_qaCreateItem(161, 0, 1)
    ToClient_qaCreateItem(162, 0, 1)
    ToClient_qaCreateItem(724001, 0, 1)
  elseif isClassType == __eClassType_Valkyrie then
    ToClient_qaCompleteQuest(298, 4)
    ToClient_qaCreateItem(157, 0, 1)
    ToClient_qaCreateItem(158, 0, 1)
    ToClient_qaCreateItem(159, 0, 1)
    ToClient_qaCreateItem(194, 0, 1)
  elseif isClassType == __eClassType_BladeMasterWoman then
    ToClient_qaCompleteQuest(321, 4)
    ToClient_qaCreateItem(163, 0, 1)
    ToClient_qaCreateItem(164, 0, 1)
    ToClient_qaCreateItem(165, 0, 1)
    ToClient_qaCreateItem(198, 0, 1)
  elseif isClassType == __eClassType_Kunoichi then
    ToClient_qaCompleteQuest(327, 4)
    ToClient_qaCreateItem(169, 0, 1)
    ToClient_qaCreateItem(170, 0, 1)
    ToClient_qaCreateItem(171, 0, 1)
    ToClient_qaCreateItem(724002, 0, 1)
  elseif isClassType == __eClassType_NinjaMan then
    ToClient_qaCompleteQuest(325, 4)
    ToClient_qaCreateItem(166, 0, 1)
    ToClient_qaCreateItem(167, 0, 1)
    ToClient_qaCreateItem(168, 0, 1)
    ToClient_qaCreateItem(724003, 0, 1)
  elseif isClassType == __eClassType_WizardWoman then
    ToClient_qaCompleteQuest(334, 5)
    ToClient_qaCreateItem(172, 0, 1)
    ToClient_qaCreateItem(173, 0, 1)
    ToClient_qaCreateItem(174, 0, 1)
    ToClient_qaCreateItem(724005, 0, 1)
  elseif isClassType == __eClassType_WizardMan then
    ToClient_qaCompleteQuest(336, 5)
    ToClient_qaCreateItem(175, 0, 1)
    ToClient_qaCreateItem(176, 0, 1)
    ToClient_qaCreateItem(177, 0, 1)
    ToClient_qaCreateItem(724006, 0, 1)
  elseif isClassType == __eClassType_DarkElf then
    ToClient_qaCompleteQuest(338, 5)
    ToClient_qaCreateItem(178, 0, 1)
    ToClient_qaCreateItem(179, 0, 1)
    ToClient_qaCreateItem(180, 0, 1)
    ToClient_qaCreateItem(199, 0, 1)
  elseif isClassType == __eClassType_Combattant then
    ToClient_qaCompleteQuest(342, 7)
    ToClient_qaCreateItem(181, 0, 1)
    ToClient_qaCreateItem(182, 0, 1)
    ToClient_qaCreateItem(183, 0, 1)
    ToClient_qaCreateItem(724008, 0, 1)
  elseif isClassType == __eClassType_Mystic then
    ToClient_qaCompleteQuest(343, 5)
    ToClient_qaCreateItem(184, 0, 1)
    ToClient_qaCreateItem(185, 0, 1)
    ToClient_qaCreateItem(186, 0, 1)
    ToClient_qaCreateItem(724009, 0, 1)
  elseif isClassType == __eClassType_Lhan then
    ToClient_qaCompleteQuest(345, 5)
    ToClient_qaCreateItem(187, 0, 1)
    ToClient_qaCreateItem(188, 0, 1)
    ToClient_qaCreateItem(189, 0, 1)
    ToClient_qaCreateItem(724007, 0, 1)
  elseif isClassType == __eClassType_RangerMan then
    ToClient_qaCreateItem(190, 0, 1)
  elseif isClassType == __eClassType_ShyWaman then
    ToClient_qaCompleteQuest(348, 12)
    ToClient_qaCompleteQuest(348, 17)
    ToClient_qaCompleteQuest(348, 21)
    ToClient_qaCompleteQuest(348, 24)
    ToClient_qaCreateItem(192, 0, 1)
  elseif isClassType == __eClassType_Guardian then
    ToClient_qaCompleteQuest(363, 8)
    ToClient_qaCreateItem(724010, 0, 1)
    ToClient_qaCreateItem(724011, 0, 1)
    ToClient_qaCreateItem(724012, 0, 1)
    ToClient_qaCreateItem(724013, 0, 1)
  elseif isClassType == __eClassType_Hashashin then
    ToClient_qaCreateItem(724014, 0, 1)
    ToClient_qaCompleteQuest(366, 8)
    ToClient_qaCreateItem(724015, 0, 1)
  end
end
function createBuffItem()
  ToClient_qaCreateItem(9692, 0, 10)
  ToClient_qaCreateItem(9693, 0, 10)
  ToClient_qaCreateItem(9694, 0, 10)
  ToClient_qaCreateItem(9635, 0, 10)
  ToClient_qaCreateItem(9464, 0, 10)
  ToClient_qaCreateItem(9609, 0, 10)
  ToClient_qaCreateItem(9603, 0, 10)
  ToClient_qaCreateItem(9634, 0, 10)
  ToClient_qaCreateItem(792, 0, 20)
  ToClient_qaCreateItem(793, 0, 20)
  ToClient_qaCreateItem(794, 0, 20)
  ToClient_qaCreateItem(795, 0, 20)
  ToClient_qaCreateItem(781, 0, 20)
  ToClient_qaCreateItem(734, 0, 20)
  ToClient_qaCreateItem(733, 0, 20)
  ToClient_qaCreateItem(17572, 0, 10)
  ToClient_qaCreateItem(18408, 0, 20)
  ToClient_qaCreateItem(17700, 0, 1)
  ToClient_qaCreateItem(17701, 0, 1)
end
function createPotion()
  ToClient_qaCreateItem(40712, 0, 1)
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  local isClassType = selfPlayer:getClassType()
  if isClassType == __eClassType_Warrior then
    ToClient_qaCreateItem(40713, 0, 1)
  elseif isClassType == __eClassType_ElfRanger then
    ToClient_qaCreateItem(532, 0, 300)
  elseif isClassType == __eClassType_Sorcerer then
    ToClient_qaCreateItem(532, 0, 300)
  elseif isClassType == __eClassType_Giant then
    ToClient_qaCreateItem(40713, 0, 1)
  elseif isClassType == __eClassType_Tamer then
    ToClient_qaCreateItem(532, 0, 300)
  elseif isClassType == __eClassType_BladeMaster then
    ToClient_qaCreateItem(40713, 0, 1)
  elseif isClassType == __eClassType_Valkyrie then
    ToClient_qaCreateItem(40713, 0, 1)
  elseif isClassType == __eClassType_BladeMasterWoman then
    ToClient_qaCreateItem(40713, 0, 1)
  elseif isClassType == __eClassType_Kunoichi then
    ToClient_qaCreateItem(40713, 0, 1)
  elseif isClassType == __eClassType_NinjaMan then
    ToClient_qaCreateItem(40713, 0, 1)
  elseif isClassType == __eClassType_WizardWoman then
    ToClient_qaCreateItem(532, 0, 300)
  elseif isClassType == __eClassType_WizardMan then
    ToClient_qaCreateItem(532, 0, 300)
  elseif isClassType == __eClassType_DarkElf then
    ToClient_qaCreateItem(532, 0, 300)
  elseif isClassType == __eClassType_Combattant then
    ToClient_qaCreateItem(40713, 0, 1)
  elseif isClassType == __eClassType_Mystic then
    ToClient_qaCreateItem(40713, 0, 1)
  elseif isClassType == __eClassType_Lhan then
    ToClient_qaCreateItem(40713, 0, 1)
  elseif isClassType == __eClassType_RangerMan then
    ToClient_qaCreateItem(532, 0, 300)
  elseif isClassType == __eClassType_ShyWaman then
    ToClient_qaCreateItem(532, 0, 300)
  elseif isClassType == __eClassType_Guardian then
    ToClient_qaCreateItem(40713, 0, 1)
  elseif isClassType == __eClassType_Hashashin then
    ToClient_qaCreateItem(532, 0, 300)
  end
  ToClient_qaCreateItem(576, 0, 10)
  ToClient_qaCreateItem(19923, 0, 10)
end
function item(enchantLeve1)
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  local isClassType = selfPlayer:getClassType()
  if isClassType == __eClassType_Warrior then
    ToClient_qaCreateItem(10010, enchantLeve1, 1)
    ToClient_qaCreateItem(10138, enchantLeve1, 1)
    ToClient_qaCreateItem(10140, enchantLeve1, 1)
    ToClient_qaCreateItem(14702, enchantLeve1, 1)
    ToClient_qaLevelUp(60)
    ToClient_qaConditionCompleteQuest()
    ToClient_qaCompleteQuest(285, 4)
    ToClient_qaCompleteQuest(653, 6)
    ToClient_qaCreateItem(142, 0, 1)
    ToClient_qaCreateItem(143, 0, 2)
    ToClient_qaCreateItem(144, 0, 3)
    ToClient_qaCreateItem(191, 0, 1)
    ToClient_qaCreateItem(594, 0, 200)
  elseif isClassType == __eClassType_ElfRanger then
    ToClient_qaCreateItem(10210, enchantLeve1, 1)
    ToClient_qaCreateItem(10338, enchantLeve1, 1)
    ToClient_qaCreateItem(10340, enchantLeve1, 1)
    ToClient_qaCreateItem(14732, enchantLeve1, 1)
    ToClient_qaLevelUp(60)
    ToClient_qaConditionCompleteQuest()
    ToClient_qaCompleteQuest(293, 4)
    ToClient_qaCompleteQuest(653, 6)
    ToClient_qaCreateItem(151, 0, 1)
    ToClient_qaCreateItem(152, 0, 1)
    ToClient_qaCreateItem(153, 0, 1)
    ToClient_qaCreateItem(532, 0, 200)
  elseif isClassType == __eClassType_Sorcerer then
    ToClient_qaCreateItem(10410, enchantLeve1, 1)
    ToClient_qaCreateItem(10538, enchantLeve1, 1)
    ToClient_qaCreateItem(10540, enchantLeve1, 1)
    ToClient_qaCreateItem(14712, enchantLeve1, 1)
    ToClient_qaLevelUp(60)
    ToClient_qaConditionCompleteQuest()
    ToClient_qaCompleteQuest(287, 4)
    ToClient_qaCompleteQuest(653, 6)
    ToClient_qaCreateItem(145, 0, 1)
    ToClient_qaCreateItem(146, 0, 1)
    ToClient_qaCreateItem(147, 0, 1)
    ToClient_qaCreateItem(532, 0, 200)
  elseif isClassType == __eClassType_Giant then
    ToClient_qaCreateItem(10610, enchantLeve1, 1)
    ToClient_qaCreateItem(10738, enchantLeve1, 1)
    ToClient_qaCreateItem(10740, enchantLeve1, 1)
    ToClient_qaCreateItem(14722, enchantLeve1, 1)
    ToClient_qaLevelUp(60)
    ToClient_qaConditionCompleteQuest()
    ToClient_qaCompleteQuest(290, 4)
    ToClient_qaCompleteQuest(653, 6)
    ToClient_qaCreateItem(148, 0, 1)
    ToClient_qaCreateItem(149, 0, 1)
    ToClient_qaCreateItem(150, 0, 1)
    ToClient_qaCreateItem(594, 0, 200)
  elseif isClassType == __eClassType_Tamer then
    ToClient_qaCreateItem(13210, enchantLeve1, 1)
    ToClient_qaCreateItem(13038, enchantLeve1, 1)
    ToClient_qaCreateItem(13040, enchantLeve1, 1)
    ToClient_qaCreateItem(14742, enchantLeve1, 1)
    ToClient_qaLevelUp(60)
    ToClient_qaConditionCompleteQuest()
    ToClient_qaCompleteQuest(296, 4)
    ToClient_qaCompleteQuest(653, 6)
    ToClient_qaCreateItem(154, 0, 1)
    ToClient_qaCreateItem(155, 0, 1)
    ToClient_qaCreateItem(156, 0, 1)
    ToClient_qaCreateItem(532, 0, 200)
  elseif isClassType == __eClassType_BladeMaster then
    ToClient_qaCreateItem(13310, enchantLeve1, 1)
    ToClient_qaCreateItem(13138, enchantLeve1, 1)
    ToClient_qaCreateItem(13140, enchantLeve1, 1)
    ToClient_qaCreateItem(14762, enchantLeve1, 1)
    ToClient_qaLevelUp(60)
    ToClient_qaConditionCompleteQuest()
    ToClient_qaCompleteQuest(319, 4)
    ToClient_qaCompleteQuest(653, 6)
    ToClient_qaCreateItem(160, 0, 1)
    ToClient_qaCreateItem(161, 0, 1)
    ToClient_qaCreateItem(162, 0, 1)
    ToClient_qaCreateItem(594, 0, 200)
  elseif isClassType == __eClassType_Valkyrie then
    ToClient_qaCreateItem(10010, enchantLeve1, 1)
    ToClient_qaCreateItem(10138, enchantLeve1, 1)
    ToClient_qaCreateItem(10140, enchantLeve1, 1)
    ToClient_qaCreateItem(14752, enchantLeve1, 1)
    ToClient_qaLevelUp(60)
    ToClient_qaConditionCompleteQuest()
    ToClient_qaCompleteQuest(298, 4)
    ToClient_qaCompleteQuest(653, 6)
    ToClient_qaCreateItem(157, 0, 1)
    ToClient_qaCreateItem(158, 0, 1)
    ToClient_qaCreateItem(159, 0, 1)
    ToClient_qaCreateItem(598, 0, 200)
  elseif isClassType == __eClassType_BladeMasterWoman then
    ToClient_qaCreateItem(13310, enchantLeve1, 1)
    ToClient_qaCreateItem(13138, enchantLeve1, 1)
    ToClient_qaCreateItem(13140, enchantLeve1, 1)
    ToClient_qaCreateItem(14772, enchantLeve1, 1)
    ToClient_qaLevelUp(60)
    ToClient_qaConditionCompleteQuest()
    ToClient_qaCompleteQuest(321, 4)
    ToClient_qaCompleteQuest(653, 6)
    ToClient_qaCreateItem(163, 0, 1)
    ToClient_qaCreateItem(164, 0, 1)
    ToClient_qaCreateItem(165, 0, 1)
    ToClient_qaCreateItem(594, 0, 200)
  elseif isClassType == __eClassType_Kunoichi then
    ToClient_qaCreateItem(13210, enchantLeve1, 1)
    ToClient_qaCreateItem(14538, enchantLeve1, 1)
    ToClient_qaCreateItem(14540, enchantLeve1, 1)
    ToClient_qaCreateItem(14792, enchantLeve1, 1)
    ToClient_qaLevelUp(60)
    ToClient_qaConditionCompleteQuest()
    ToClient_qaCompleteQuest(327, 4)
    ToClient_qaCompleteQuest(653, 6)
    ToClient_qaCreateItem(169, 0, 1)
    ToClient_qaCreateItem(170, 0, 1)
    ToClient_qaCreateItem(171, 0, 1)
    ToClient_qaCreateItem(594, 0, 200)
  elseif isClassType == __eClassType_NinjaMan then
    ToClient_qaCreateItem(13210, enchantLeve1, 1)
    ToClient_qaCreateItem(14638, enchantLeve1, 1)
    ToClient_qaCreateItem(14640, enchantLeve1, 1)
    ToClient_qaCreateItem(14782, enchantLeve1, 1)
    ToClient_qaLevelUp(60)
    ToClient_qaConditionCompleteQuest()
    ToClient_qaCompleteQuest(325, 4)
    ToClient_qaCompleteQuest(653, 6)
    ToClient_qaCreateItem(166, 0, 1)
    ToClient_qaCreateItem(167, 0, 1)
    ToClient_qaCreateItem(168, 0, 1)
    ToClient_qaCreateItem(594, 0, 200)
  elseif isClassType == __eClassType_WizardWoman then
    ToClient_qaCreateItem(14410, enchantLeve1, 1)
    ToClient_qaCreateItem(10338, enchantLeve1, 1)
    ToClient_qaCreateItem(10340, enchantLeve1, 1)
    ToClient_qaCreateItem(14802, enchantLeve1, 1)
    ToClient_qaLevelUp(60)
    ToClient_qaConditionCompleteQuest()
    ToClient_qaCompleteQuest(334, 5)
    ToClient_qaCompleteQuest(653, 6)
    ToClient_qaCreateItem(172, 0, 1)
    ToClient_qaCreateItem(173, 0, 1)
    ToClient_qaCreateItem(174, 0, 1)
    ToClient_qaCreateItem(532, 0, 200)
  elseif isClassType == __eClassType_WizardMan then
    ToClient_qaCreateItem(14410, enchantLeve1, 1)
    ToClient_qaCreateItem(10338, enchantLeve1, 1)
    ToClient_qaCreateItem(10340, enchantLeve1, 1)
    ToClient_qaCreateItem(14812, enchantLeve1, 1)
    ToClient_qaLevelUp(60)
    ToClient_qaConditionCompleteQuest()
    ToClient_qaCompleteQuest(336, 5)
    ToClient_qaCompleteQuest(653, 6)
    ToClient_qaCreateItem(175, 0, 1)
    ToClient_qaCreateItem(176, 0, 1)
    ToClient_qaCreateItem(177, 0, 1)
    ToClient_qaCreateItem(532, 0, 200)
  elseif isClassType == __eClassType_DarkElf then
    ToClient_qaCreateItem(11360, enchantLeve1, 1)
    ToClient_qaCreateItem(10738, enchantLeve1, 1)
    ToClient_qaCreateItem(10740, enchantLeve1, 1)
    ToClient_qaCreateItem(14817, enchantLeve1, 1)
    ToClient_qaLevelUp(60)
    ToClient_qaConditionCompleteQuest()
    ToClient_qaCompleteQuest(338, 5)
    ToClient_qaCompleteQuest(653, 6)
    ToClient_qaCreateItem(178, 0, 1)
    ToClient_qaCreateItem(179, 0, 1)
    ToClient_qaCreateItem(180, 0, 1)
    ToClient_qaCreateItem(532, 0, 200)
  elseif isClassType == __eClassType_Combattant then
    ToClient_qaCreateItem(11210, enchantLeve1, 1)
    ToClient_qaCreateItem(11338, enchantLeve1, 1)
    ToClient_qaCreateItem(11340, enchantLeve1, 1)
    ToClient_qaCreateItem(14822, enchantLeve1, 1)
    ToClient_qaLevelUp(60)
    ToClient_qaConditionCompleteQuest()
    ToClient_qaCompleteQuest(342, 7)
    ToClient_qaCompleteQuest(653, 6)
    ToClient_qaCreateItem(181, 0, 1)
    ToClient_qaCreateItem(182, 0, 1)
    ToClient_qaCreateItem(183, 0, 1)
    ToClient_qaCreateItem(594, 0, 200)
  elseif isClassType == __eClassType_Mystic then
    ToClient_qaCreateItem(11210, enchantLeve1, 1)
    ToClient_qaCreateItem(11338, enchantLeve1, 1)
    ToClient_qaCreateItem(11340, enchantLeve1, 1)
    ToClient_qaCreateItem(14830, enchantLeve1, 1)
    ToClient_qaLevelUp(60)
    ToClient_qaConditionCompleteQuest()
    ToClient_qaCompleteQuest(343, 5)
    ToClient_qaCompleteQuest(653, 6)
    ToClient_qaCreateItem(184, 0, 1)
    ToClient_qaCreateItem(185, 0, 1)
    ToClient_qaCreateItem(186, 0, 1)
    ToClient_qaCreateItem(594, 0, 200)
  elseif isClassType == __eClassType_Lhan then
    ToClient_qaCreateItem(13410, enchantLeve1, 1)
    ToClient_qaCreateItem(13538, enchantLeve1, 1)
    ToClient_qaCreateItem(13540, enchantLeve1, 1)
    ToClient_qaCreateItem(550502, enchantLeve1, 1)
    ToClient_qaLevelUp(60)
    ToClient_qaConditionCompleteQuest()
    ToClient_qaCompleteQuest(345, 5)
    ToClient_qaCompleteQuest(653, 6)
    ToClient_qaCreateItem(187, 0, 1)
    ToClient_qaCreateItem(188, 0, 1)
    ToClient_qaCreateItem(189, 0, 1)
    ToClient_qaCreateItem(594, 0, 200)
  elseif isClassType == __eClassType_RangerMan then
    ToClient_qaCreateItem(13710, enchantLeve1, 1)
    ToClient_qaCreateItem(13838, enchantLeve1, 1)
    ToClient_qaCreateItem(13840, enchantLeve1, 1)
    ToClient_qaCreateItem(13903, enchantLeve1, 1)
    ToClient_qaLevelUp(60)
    ToClient_qaConditionCompleteQuest()
    ToClient_qaCompleteQuest(653, 6)
    ToClient_qaCreateItem(190, 0, 1)
    ToClient_qaCreateItem(532, 0, 200)
  elseif isClassType == __eClassType_ShyWaman then
    ToClient_qaCreateItem(718510, enchantLeve1, 1)
    ToClient_qaCreateItem(719038, enchantLeve1, 1)
    ToClient_qaCreateItem(719040, enchantLeve1, 1)
    ToClient_qaCreateItem(690004, enchantLeve1, 1)
    ToClient_qaLevelUp(60)
    ToClient_qaConditionCompleteQuest()
    ToClient_qaCompleteQuest(653, 6)
    ToClient_qaCreateItem(532, 0, 200)
  elseif isClassType == __eClassType_Guardian then
    ToClient_qaCreateItem(690513, enchantLeve1, 1)
    ToClient_qaCreateItem(10138, enchantLeve1, 1)
    ToClient_qaCreateItem(10140, enchantLeve1, 1)
  end
end
function createBossArmor(enchantLevel)
  ToClient_qaCreateItem(11101, enchantLevel, 1)
  ToClient_qaCreateItem(11015, enchantLevel, 1)
  ToClient_qaCreateItem(11103, enchantLevel, 1)
  ToClient_qaCreateItem(11017, enchantLevel, 1)
end
function createAccessory(enchantLeve1)
  if enchantLeve1 < 15 then
    enchantLeve1 = 15
  end
  ToClient_qaCreateItem(12230, enchantLeve1 - 15, 1)
  ToClient_qaCreateItem(12237, enchantLeve1 - 15, 1)
  ToClient_qaCreateItem(12251, enchantLeve1 - 15, 1)
  ToClient_qaCreateItem(12031, enchantLeve1 - 15, 2)
  ToClient_qaCreateItem(12061, enchantLeve1 - 15, 2)
  ToClient_qaCreateItem(11828, enchantLeve1 - 15, 2)
  ToClient_qaCreateItem(11834, enchantLeve1 - 15, 2)
  ToClient_qaCreateItem(11607, enchantLeve1 - 15, 1)
  ToClient_qaCreateItem(45220, 0, 1)
  ToClient_qaCreateItem(45252, 0, 1)
  ToClient_qaCreateItem(45332, 0, 1)
end
function createCrystal1()
  ToClient_qaCreateItem(15801, 0, 2)
  ToClient_qaCreateItem(15852, 0, 2)
  ToClient_qaCreateItem(15807, 0, 2)
  ToClient_qaCreateItem(15211, 0, 2)
  ToClient_qaCreateItem(15616, 0, 2)
  ToClient_qaCreateItem(15674, 0, 2)
  ToClient_qaCreateItem(15667, 0, 4)
  ToClient_qaCreateItem(15666, 0, 4)
  ToClient_qaCreateItem(15654, 0, 2)
end
function createCrystal2()
  ToClient_qaCreateItem(15813, 0, 2)
  ToClient_qaCreateItem(15816, 0, 2)
  ToClient_qaCreateItem(15674, 0, 2)
  ToClient_qaCreateItem(15675, 0, 2)
  ToClient_qaCreateItem(15676, 0, 2)
  ToClient_qaCreateItem(15801, 0, 2)
  ToClient_qaCreateItem(15622, 0, 2)
  ToClient_qaCreateItem(15804, 0, 2)
  ToClient_qaCreateItem(15136, 0, 2)
  ToClient_qaCreateItem(15670, 0, 2)
  ToClient_qaCreateItem(15807, 0, 2)
  ToClient_qaCreateItem(15669, 0, 2)
  ToClient_qaCreateItem(15810, 0, 2)
  ToClient_qaCreateItem(15640, 0, 2)
  ToClient_qaCreateItem(15667, 0, 4)
  ToClient_qaCreateItem(15666, 0, 4)
  ToClient_qaCreateItem(15672, 0, 2)
  ToClient_qaCreateItem(15654, 0, 2)
end
function pvetest()
  ToClient_qaLevelUp(63)
  ToClient_qaCreateItem(65488, 0, 2)
  ToClient_qaCreateItem(65487, 0, 1)
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  local isClassType = selfPlayer:getClassType()
  if isClassType == __eClassType_Warrior then
    ToClient_qaCreateItem(715001, 19, 1)
    ToClient_qaCreateItem(10010, 20, 1)
    ToClient_qaCreateItem(10140, 20, 1)
    ToClient_qaCreateItem(14702, 20, 1)
  elseif isClassType == __eClassType_ElfRanger then
    ToClient_qaCreateItem(715003, 19, 1)
    ToClient_qaCreateItem(10210, 20, 1)
    ToClient_qaCreateItem(10340, 20, 1)
    ToClient_qaCreateItem(14732, 20, 1)
  elseif isClassType == __eClassType_Sorcerer then
    ToClient_qaCreateItem(715005, 19, 1)
    ToClient_qaCreateItem(10410, 20, 1)
    ToClient_qaCreateItem(10540, 20, 1)
    ToClient_qaCreateItem(14712, 20, 1)
  elseif isClassType == __eClassType_Giant then
    ToClient_qaCreateItem(715007, 19, 1)
    ToClient_qaCreateItem(10610, 20, 1)
    ToClient_qaCreateItem(10740, 20, 1)
    ToClient_qaCreateItem(14722, 20, 1)
  elseif isClassType == __eClassType_Tamer then
    ToClient_qaCreateItem(715009, 19, 1)
    ToClient_qaCreateItem(13210, 20, 1)
    ToClient_qaCreateItem(13040, 20, 1)
    ToClient_qaCreateItem(14742, 20, 1)
  elseif isClassType == __eClassType_BladeMaster then
    ToClient_qaCreateItem(715011, 19, 1)
    ToClient_qaCreateItem(13310, 20, 1)
    ToClient_qaCreateItem(13140, 20, 1)
    ToClient_qaCreateItem(14762, 20, 1)
  elseif isClassType == __eClassType_Valkyrie then
    ToClient_qaCreateItem(715001, 19, 1)
    ToClient_qaCreateItem(10010, 20, 1)
    ToClient_qaCreateItem(10140, 20, 1)
    ToClient_qaCreateItem(14752, 20, 1)
  elseif isClassType == __eClassType_BladeMasterWoman then
    ToClient_qaCreateItem(715011, 19, 1)
    ToClient_qaCreateItem(13310, 20, 1)
    ToClient_qaCreateItem(13140, 20, 1)
    ToClient_qaCreateItem(14772, 20, 1)
  elseif isClassType == __eClassType_Kunoichi then
    ToClient_qaCreateItem(715009, 19, 1)
    ToClient_qaCreateItem(13210, 20, 1)
    ToClient_qaCreateItem(14540, 20, 1)
    ToClient_qaCreateItem(14792, 20, 1)
  elseif isClassType == __eClassType_NinjaMan then
    ToClient_qaCreateItem(715009, 19, 1)
    ToClient_qaCreateItem(13210, 20, 1)
    ToClient_qaCreateItem(14640, 20, 1)
    ToClient_qaCreateItem(14782, 20, 1)
  elseif isClassType == __eClassType_WizardWoman then
    ToClient_qaCreateItem(715013, 19, 1)
    ToClient_qaCreateItem(14410, 20, 1)
    ToClient_qaCreateItem(10340, 20, 1)
    ToClient_qaCreateItem(14802, 20, 1)
  elseif isClassType == __eClassType_WizardMan then
    ToClient_qaCreateItem(715013, 19, 1)
    ToClient_qaCreateItem(14410, 20, 1)
    ToClient_qaCreateItem(10340, 20, 1)
    ToClient_qaCreateItem(14812, 20, 1)
  elseif isClassType == __eClassType_DarkElf then
    ToClient_qaCreateItem(715016, 19, 1)
    ToClient_qaCreateItem(11360, 20, 1)
    ToClient_qaCreateItem(10740, 20, 1)
    ToClient_qaCreateItem(14817, 20, 1)
  elseif isClassType == __eClassType_Combattant then
    ToClient_qaCreateItem(715017, 19, 1)
    ToClient_qaCreateItem(11210, 20, 1)
    ToClient_qaCreateItem(11340, 20, 1)
    ToClient_qaCreateItem(14822, 20, 1)
  elseif isClassType == __eClassType_Mystic then
    ToClient_qaCreateItem(715017, 19, 1)
    ToClient_qaCreateItem(11210, 20, 1)
    ToClient_qaCreateItem(11340, 20, 1)
    ToClient_qaCreateItem(14830, 20, 1)
  elseif isClassType == __eClassType_Lhan then
    ToClient_qaCreateItem(715019, 19, 1)
    ToClient_qaCreateItem(13410, 20, 1)
    ToClient_qaCreateItem(13540, 20, 1)
    ToClient_qaCreateItem(550502, 20, 1)
  elseif isClassType == __eClassType_RangerMan then
    ToClient_qaCreateItem(715021, 19, 1)
    ToClient_qaCreateItem(13710, 20, 1)
    ToClient_qaCreateItem(13840, 20, 1)
    ToClient_qaCreateItem(13903, 20, 1)
  elseif isClassType == __eClassType_ShyWaman then
    ToClient_qaCreateItem(718616, 19, 1)
    ToClient_qaCreateItem(718510, 20, 1)
    ToClient_qaCreateItem(719040, 20, 1)
    ToClient_qaCreateItem(690004, 20, 1)
  elseif isClassType == __eClassType_Guardian then
    ToClient_qaCreateItem(690563, 19, 1)
    ToClient_qaCreateItem(690513, 20, 1)
    ToClient_qaCreateItem(10140, 20, 1)
    ToClient_qaCreateItem(691503, 20, 1)
  elseif isClassType == __eClassType_Hashashin then
    ToClient_qaCreateItem(692045, 19, 1)
    ToClient_qaCreateItem(692011, 20, 1)
    ToClient_qaCreateItem(692516, 20, 1)
    ToClient_qaCreateItem(692802, 20, 1)
  end
  chatting_sendMessage("", "/create item 11101 1 20 13", CppEnums.ChatType.Private)
  chatting_sendMessage("", "/create item 11015 1 20 10", CppEnums.ChatType.Private)
  chatting_sendMessage("", "/create item 11103 1 20 10", CppEnums.ChatType.Private)
  chatting_sendMessage("", "/create item 11017 1 20 10", CppEnums.ChatType.Private)
  ToClient_qaCreateItem(12061, 4, 2)
  ToClient_qaCreateItem(11828, 4, 2)
  ToClient_qaCreateItem(12237, 4, 1)
  ToClient_qaCreateItem(11607, 5, 1)
  ToClient_qaCreateItem(45332, 0, 1)
  ToClient_qaCreateItem(9771, 0, 2)
  ToClient_qaCreateItem(44980, 0, 1)
  awakening()
  ToClient_qaCreateItem(721003, 0, 100000)
end
function pvptest()
  ToClient_qaLevelUp(63)
  ToClient_qaCreateItem(65488, 0, 2)
  ToClient_qaCreateItem(65487, 0, 1)
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  local isClassType = selfPlayer:getClassType()
  if isClassType == __eClassType_Warrior then
    ToClient_qaCreateItem(715001, 19, 1)
    chatting_sendMessage("", "/create item 10010 1 20", CppEnums.ChatType.Private)
    ToClient_qaCreateItem(10138, 20, 1)
    ToClient_qaCreateItem(10140, 20, 1)
    chatting_sendMessage("", "/create item 14702 1 20", CppEnums.ChatType.Private)
  elseif isClassType == __eClassType_ElfRanger then
    ToClient_qaCreateItem(715003, 19, 1)
    chatting_sendMessage("", "/create item 10210 1 20", CppEnums.ChatType.Private)
    ToClient_qaCreateItem(10338, 20, 1)
    ToClient_qaCreateItem(10340, 20, 1)
    chatting_sendMessage("", "/create item 14732 1 20", CppEnums.ChatType.Private)
  elseif isClassType == __eClassType_Sorcerer then
    ToClient_qaCreateItem(715005, 19, 1)
    chatting_sendMessage("", "/create item 10410 1 20", CppEnums.ChatType.Private)
    ToClient_qaCreateItem(10538, 20, 1)
    ToClient_qaCreateItem(10540, 20, 1)
    chatting_sendMessage("", "/create item 14712 1 20", CppEnums.ChatType.Private)
  elseif isClassType == __eClassType_Giant then
    ToClient_qaCreateItem(715007, 19, 1)
    chatting_sendMessage("", "/create item 10610 1 20", CppEnums.ChatType.Private)
    ToClient_qaCreateItem(10738, 20, 1)
    ToClient_qaCreateItem(10740, 20, 1)
    chatting_sendMessage("", "/create item 14722 1 20", CppEnums.ChatType.Private)
  elseif isClassType == __eClassType_Tamer then
    ToClient_qaCreateItem(715009, 19, 1)
    ToClient_qaCreateItem(13210, 20, 1)
    chatting_sendMessage("", "/create item 13210 1 20", CppEnums.ChatType.Private)
    ToClient_qaCreateItem(13038, 20, 1)
    ToClient_qaCreateItem(13040, 20, 1)
    chatting_sendMessage("", "/create item 14742 1 20", CppEnums.ChatType.Private)
  elseif isClassType == __eClassType_BladeMaster then
    ToClient_qaCreateItem(715011, 19, 1)
    chatting_sendMessage("", "/create item 13310 1 20", CppEnums.ChatType.Private)
    ToClient_qaCreateItem(13138, 20, 1)
    ToClient_qaCreateItem(13140, 20, 1)
    chatting_sendMessage("", "/create item 14762 1 20", CppEnums.ChatType.Private)
  elseif isClassType == __eClassType_Valkyrie then
    ToClient_qaCreateItem(715001, 19, 1)
    chatting_sendMessage("", "/create item 10010 1 20", CppEnums.ChatType.Private)
    ToClient_qaCreateItem(10138, 20, 1)
    ToClient_qaCreateItem(10140, 20, 1)
    chatting_sendMessage("", "/create item 14752 1 20", CppEnums.ChatType.Private)
  elseif isClassType == __eClassType_BladeMasterWoman then
    ToClient_qaCreateItem(715011, 19, 1)
    chatting_sendMessage("", "/create item 13310 1 20", CppEnums.ChatType.Private)
    ToClient_qaCreateItem(13138, 20, 1)
    ToClient_qaCreateItem(13140, 20, 1)
    chatting_sendMessage("", "/create item 14772 1 20", CppEnums.ChatType.Private)
  elseif isClassType == __eClassType_Kunoichi then
    ToClient_qaCreateItem(715009, 19, 1)
    chatting_sendMessage("", "/create item 13210 1 20", CppEnums.ChatType.Private)
    ToClient_qaCreateItem(14538, 20, 1)
    ToClient_qaCreateItem(14540, 20, 1)
    chatting_sendMessage("", "/create item 14792 1 20", CppEnums.ChatType.Private)
  elseif isClassType == __eClassType_NinjaMan then
    ToClient_qaCreateItem(715009, 19, 1)
    chatting_sendMessage("", "/create item 13210 1 20", CppEnums.ChatType.Private)
    ToClient_qaCreateItem(14638, 20, 1)
    ToClient_qaCreateItem(14640, 20, 1)
    chatting_sendMessage("", "/create item 14782 1 20", CppEnums.ChatType.Private)
  elseif isClassType == __eClassType_WizardWoman then
    ToClient_qaCreateItem(715013, 19, 1)
    chatting_sendMessage("", "/create item 14410 1 20", CppEnums.ChatType.Private)
    ToClient_qaCreateItem(10338, 20, 1)
    ToClient_qaCreateItem(10340, 20, 1)
    chatting_sendMessage("", "/create item 14802 1 20", CppEnums.ChatType.Private)
  elseif isClassType == __eClassType_WizardMan then
    ToClient_qaCreateItem(715013, 19, 1)
    chatting_sendMessage("", "/create item 14410 1 20", CppEnums.ChatType.Private)
    ToClient_qaCreateItem(10338, 20, 1)
    ToClient_qaCreateItem(10340, 20, 1)
    chatting_sendMessage("", "/create item 14812 1 20", CppEnums.ChatType.Private)
  elseif isClassType == __eClassType_DarkElf then
    ToClient_qaCreateItem(715016, 19, 1)
    chatting_sendMessage("", "/create item 11360 1 20", CppEnums.ChatType.Private)
    ToClient_qaCreateItem(10738, 20, 1)
    ToClient_qaCreateItem(10740, 20, 1)
    chatting_sendMessage("", "/create item 14817 1 20", CppEnums.ChatType.Private)
  elseif isClassType == __eClassType_Combattant then
    ToClient_qaCreateItem(715017, 19, 1)
    chatting_sendMessage("", "/create item 11210 1 20", CppEnums.ChatType.Private)
    ToClient_qaCreateItem(11338, 20, 1)
    ToClient_qaCreateItem(11340, 20, 1)
    chatting_sendMessage("", "/create item 14822 1 20", CppEnums.ChatType.Private)
  elseif isClassType == __eClassType_Mystic then
    ToClient_qaCreateItem(715017, 19, 1)
    chatting_sendMessage("", "/create item 11210 1 20", CppEnums.ChatType.Private)
    ToClient_qaCreateItem(11338, 20, 1)
    ToClient_qaCreateItem(11340, 20, 1)
    chatting_sendMessage("", "/create item 14830 1 20", CppEnums.ChatType.Private)
  elseif isClassType == __eClassType_Lhan then
    ToClient_qaCreateItem(715019, 19, 1)
    chatting_sendMessage("", "/create item 13410 1 20", CppEnums.ChatType.Private)
    ToClient_qaCreateItem(13538, 20, 1)
    ToClient_qaCreateItem(13540, 20, 1)
    chatting_sendMessage("", "/create item 550502 1 20", CppEnums.ChatType.Private)
  elseif isClassType == __eClassType_RangerMan then
    ToClient_qaCreateItem(715021, 19, 1)
    chatting_sendMessage("", "/create item 13710 1 20", CppEnums.ChatType.Private)
    ToClient_qaCreateItem(13838, 20, 1)
    ToClient_qaCreateItem(13840, 20, 1)
    chatting_sendMessage("", "/create item 13903 1 20", CppEnums.ChatType.Private)
  elseif isClassType == __eClassType_ShyWaman then
    ToClient_qaCreateItem(718616, 19, 1)
    chatting_sendMessage("", "/create item 718510 1 20", CppEnums.ChatType.Private)
    ToClient_qaCreateItem(719040, 20, 1)
    ToClient_qaCreateItem(719038, 20, 1)
    ToClient_qaCreateItem(690004, 20, 1)
  elseif isClassType == __eClassType_Guardian then
    ToClient_qaCreateItem(690563, 19, 1)
    chatting_sendMessage("", "/create item 690513 1 20", CppEnums.ChatType.Private)
    ToClient_qaCreateItem(10138, 20, 1)
    ToClient_qaCreateItem(10140, 20, 1)
    ToClient_qaCreateItem(691503, 20, 1)
  elseif isClassType == __eClassType_Hashashin then
    ToClient_qaCreateItem(692045, 19, 1)
    ToClient_qaCreateItem(692011, 20, 1)
    ToClient_qaCreateItem(692514, 20, 1)
    ToClient_qaCreateItem(692516, 20, 1)
    ToClient_qaCreateItem(692802, 20, 1)
  end
  chatting_sendMessage("", "/create item 11101 1 20 13", CppEnums.ChatType.Private)
  chatting_sendMessage("", "/create item 11015 1 20 10", CppEnums.ChatType.Private)
  chatting_sendMessage("", "/create item 11103 1 20 10", CppEnums.ChatType.Private)
  chatting_sendMessage("", "/create item 11017 1 20 10", CppEnums.ChatType.Private)
  chatting_sendMessage("", "/create item 11046 1 20 20", CppEnums.ChatType.Private)
  chatting_sendMessage("", "/create item 11102 1 20 10", CppEnums.ChatType.Private)
  chatting_sendMessage("", "/create item 11016 1 20 10", CppEnums.ChatType.Private)
  ToClient_qaCreateItem(12031, 5, 2)
  ToClient_qaCreateItem(11828, 5, 2)
  ToClient_qaCreateItem(12237, 5, 1)
  ToClient_qaCreateItem(11607, 5, 1)
  ToClient_qaCreateItem(45332, 0, 1)
  ToClient_qaCreateItem(9771, 0, 3)
  ToClient_qaCreateItem(44980, 0, 1)
  ToClient_qaCreateItem(721003, 0, 100000)
  awakening()
  createCrystal()
end
function createCrystal()
  ToClient_qaCreateItem(15807, 0, 2)
  ToClient_qaCreateItem(15810, 0, 2)
  ToClient_qaCreateItem(15654, 0, 2)
  ToClient_qaCreateItem(15674, 0, 2)
  ToClient_qaCreateItem(15675, 0, 2)
  ToClient_qaCreateItem(15676, 0, 2)
  ToClient_qaCreateItem(15667, 0, 4)
end
function balancetest()
  ToClient_qaLevelUp(63)
  ToClient_qaCreateItem(65488, 0, 2)
  ToClient_qaCreateItem(65487, 0, 1)
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  local isClassType = selfPlayer:getClassType()
  if isClassType == __eClassType_Warrior then
    ToClient_qaCreateItem(715001, 19, 1)
    chatting_sendMessage("", "/create item 10010 1 20", CppEnums.ChatType.Private)
    ToClient_qaCreateItem(10138, 20, 1)
    ToClient_qaCreateItem(10140, 20, 1)
    chatting_sendMessage("", "/create item 14702 1 20", CppEnums.ChatType.Private)
  elseif isClassType == __eClassType_ElfRanger then
    ToClient_qaCreateItem(715003, 19, 1)
    chatting_sendMessage("", "/create item 10210 1 20", CppEnums.ChatType.Private)
    ToClient_qaCreateItem(10338, 20, 1)
    ToClient_qaCreateItem(10340, 20, 1)
    chatting_sendMessage("", "/create item 14732 1 20", CppEnums.ChatType.Private)
  elseif isClassType == __eClassType_Sorcerer then
    ToClient_qaCreateItem(715005, 19, 1)
    chatting_sendMessage("", "/create item 10410 1 20", CppEnums.ChatType.Private)
    ToClient_qaCreateItem(10538, 20, 1)
    ToClient_qaCreateItem(10540, 20, 1)
    chatting_sendMessage("", "/create item 14712 1 20", CppEnums.ChatType.Private)
  elseif isClassType == __eClassType_Giant then
    ToClient_qaCreateItem(715007, 19, 1)
    chatting_sendMessage("", "/create item 10610 1 20", CppEnums.ChatType.Private)
    ToClient_qaCreateItem(10738, 20, 1)
    ToClient_qaCreateItem(10740, 20, 1)
    chatting_sendMessage("", "/create item 14722 1 20", CppEnums.ChatType.Private)
  elseif isClassType == __eClassType_Tamer then
    ToClient_qaCreateItem(715009, 19, 1)
    ToClient_qaCreateItem(13210, 20, 1)
    chatting_sendMessage("", "/create item 13210 1 20", CppEnums.ChatType.Private)
    ToClient_qaCreateItem(13038, 20, 1)
    ToClient_qaCreateItem(13040, 20, 1)
    chatting_sendMessage("", "/create item 14742 1 20", CppEnums.ChatType.Private)
  elseif isClassType == __eClassType_BladeMaster then
    ToClient_qaCreateItem(715011, 19, 1)
    chatting_sendMessage("", "/create item 13310 1 20", CppEnums.ChatType.Private)
    ToClient_qaCreateItem(13138, 20, 1)
    ToClient_qaCreateItem(13140, 20, 1)
    chatting_sendMessage("", "/create item 14762 1 20", CppEnums.ChatType.Private)
  elseif isClassType == __eClassType_Valkyrie then
    ToClient_qaCreateItem(715001, 19, 1)
    chatting_sendMessage("", "/create item 10010 1 20", CppEnums.ChatType.Private)
    ToClient_qaCreateItem(10138, 20, 1)
    ToClient_qaCreateItem(10140, 20, 1)
    chatting_sendMessage("", "/create item 14752 1 20", CppEnums.ChatType.Private)
  elseif isClassType == __eClassType_BladeMasterWoman then
    ToClient_qaCreateItem(715011, 19, 1)
    chatting_sendMessage("", "/create item 13310 1 20", CppEnums.ChatType.Private)
    ToClient_qaCreateItem(13138, 20, 1)
    ToClient_qaCreateItem(13140, 20, 1)
    chatting_sendMessage("", "/create item 14772 1 20", CppEnums.ChatType.Private)
  elseif isClassType == __eClassType_Kunoichi then
    ToClient_qaCreateItem(715009, 19, 1)
    chatting_sendMessage("", "/create item 13210 1 20", CppEnums.ChatType.Private)
    ToClient_qaCreateItem(14538, 20, 1)
    ToClient_qaCreateItem(14540, 20, 1)
    chatting_sendMessage("", "/create item 14792 1 20", CppEnums.ChatType.Private)
  elseif isClassType == __eClassType_NinjaMan then
    ToClient_qaCreateItem(715009, 19, 1)
    chatting_sendMessage("", "/create item 13210 1 20", CppEnums.ChatType.Private)
    ToClient_qaCreateItem(14638, 20, 1)
    ToClient_qaCreateItem(14640, 20, 1)
    chatting_sendMessage("", "/create item 14782 1 20", CppEnums.ChatType.Private)
  elseif isClassType == __eClassType_WizardWoman then
    ToClient_qaCreateItem(715013, 19, 1)
    chatting_sendMessage("", "/create item 14410 1 20", CppEnums.ChatType.Private)
    ToClient_qaCreateItem(10338, 20, 1)
    ToClient_qaCreateItem(10340, 20, 1)
    chatting_sendMessage("", "/create item 14802 1 20", CppEnums.ChatType.Private)
  elseif isClassType == __eClassType_WizardMan then
    ToClient_qaCreateItem(715013, 19, 1)
    chatting_sendMessage("", "/create item 14410 1 20", CppEnums.ChatType.Private)
    ToClient_qaCreateItem(10338, 20, 1)
    ToClient_qaCreateItem(10340, 20, 1)
    chatting_sendMessage("", "/create item 14812 1 20", CppEnums.ChatType.Private)
  elseif isClassType == __eClassType_DarkElf then
    ToClient_qaCreateItem(715016, 19, 1)
    chatting_sendMessage("", "/create item 11360 1 20", CppEnums.ChatType.Private)
    ToClient_qaCreateItem(10738, 20, 1)
    ToClient_qaCreateItem(10740, 20, 1)
    chatting_sendMessage("", "/create item 14817 1 20", CppEnums.ChatType.Private)
  elseif isClassType == __eClassType_Combattant then
    ToClient_qaCreateItem(715017, 19, 1)
    chatting_sendMessage("", "/create item 11210 1 20", CppEnums.ChatType.Private)
    ToClient_qaCreateItem(11338, 20, 1)
    ToClient_qaCreateItem(11340, 20, 1)
    chatting_sendMessage("", "/create item 14822 1 20", CppEnums.ChatType.Private)
  elseif isClassType == __eClassType_Mystic then
    ToClient_qaCreateItem(715017, 19, 1)
    chatting_sendMessage("", "/create item 11210 1 20", CppEnums.ChatType.Private)
    ToClient_qaCreateItem(11338, 20, 1)
    ToClient_qaCreateItem(11340, 20, 1)
    chatting_sendMessage("", "/create item 14830 1 20", CppEnums.ChatType.Private)
  elseif isClassType == __eClassType_Lhan then
    ToClient_qaCreateItem(715019, 19, 1)
    chatting_sendMessage("", "/create item 13410 1 20", CppEnums.ChatType.Private)
    ToClient_qaCreateItem(13538, 20, 1)
    ToClient_qaCreateItem(13540, 20, 1)
    chatting_sendMessage("", "/create item 550502 1 20", CppEnums.ChatType.Private)
  elseif isClassType == __eClassType_RangerMan then
    ToClient_qaCreateItem(715021, 19, 1)
    chatting_sendMessage("", "/create item 13710 1 20", CppEnums.ChatType.Private)
    ToClient_qaCreateItem(13838, 20, 1)
    ToClient_qaCreateItem(13840, 20, 1)
    chatting_sendMessage("", "/create item 13903 1 20", CppEnums.ChatType.Private)
  elseif isClassType == __eClassType_ShyWaman then
    ToClient_qaCreateItem(718616, 19, 1)
    chatting_sendMessage("", "/create item 718510 1 20", CppEnums.ChatType.Private)
    ToClient_qaCreateItem(719040, 20, 1)
    ToClient_qaCreateItem(719038, 20, 1)
    ToClient_qaCreateItem(690004, 20, 1)
  elseif isClassType == __eClassType_Guardian then
    ToClient_qaCreateItem(690563, 19, 1)
    chatting_sendMessage("", "/create item 690513 1 20", CppEnums.ChatType.Private)
    ToClient_qaCreateItem(10138, 20, 1)
    ToClient_qaCreateItem(10140, 20, 1)
    ToClient_qaCreateItem(691503, 20, 1)
  elseif isClassType == __eClassType_Hashashin then
    ToClient_qaCreateItem(692045, 19, 1)
    ToClient_qaCreateItem(692011, 20, 1)
    ToClient_qaCreateItem(692514, 20, 1)
    ToClient_qaCreateItem(692516, 20, 1)
    ToClient_qaCreateItem(692802, 20, 1)
  end
  chatting_sendMessage("", "/create item 11101 1 20 13", CppEnums.ChatType.Private)
  chatting_sendMessage("", "/create item 11015 1 20 10", CppEnums.ChatType.Private)
  chatting_sendMessage("", "/create item 11103 1 20 10", CppEnums.ChatType.Private)
  chatting_sendMessage("", "/create item 11017 1 20 10", CppEnums.ChatType.Private)
  chatting_sendMessage("", "/create item 11046 1 20 20", CppEnums.ChatType.Private)
  chatting_sendMessage("", "/create item 11102 1 20 10", CppEnums.ChatType.Private)
  chatting_sendMessage("", "/create item 11016 1 20 10", CppEnums.ChatType.Private)
  ToClient_qaCreateItem(12031, 5, 2)
  ToClient_qaCreateItem(11828, 5, 2)
  ToClient_qaCreateItem(12237, 5, 1)
  ToClient_qaCreateItem(12061, 5, 2)
  ToClient_qaCreateItem(11607, 5, 1)
  ToClient_qaCreateItem(12257, 5, 1)
  ToClient_qaCreateItem(11855, 5, 2)
  ToClient_qaCreateItem(11853, 5, 2)
  ToClient_qaCreateItem(45332, 0, 1)
  ToClient_qaCreateItem(9771, 0, 3)
  ToClient_qaCreateItem(44980, 0, 1)
  ToClient_qaCreateItem(721003, 0, 100000)
  awakening()
end
function seasonitem()
  ToClient_qaCreateItem(65488, 0, 2)
  ToClient_qaCreateItem(65487, 0, 1)
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  local isClassType = selfPlayer:getClassType()
  if isClassType == __eClassType_Warrior then
    ToClient_qaCreateItem(694113, 20, 1)
    ToClient_qaCreateItem(694126, 20, 1)
    ToClient_qaCreateItem(694138, 20, 1)
  elseif isClassType == __eClassType_ElfRanger then
    ToClient_qaCreateItem(694114, 20, 1)
    ToClient_qaCreateItem(694127, 20, 1)
    ToClient_qaCreateItem(694141, 20, 1)
  elseif isClassType == __eClassType_Sorcerer then
    ToClient_qaCreateItem(694115, 20, 1)
    ToClient_qaCreateItem(694128, 20, 1)
    ToClient_qaCreateItem(694139, 20, 1)
  elseif isClassType == __eClassType_Giant then
    ToClient_qaCreateItem(694116, 20, 1)
    ToClient_qaCreateItem(694129, 20, 1)
    ToClient_qaCreateItem(694140, 20, 1)
  elseif isClassType == __eClassType_Tamer then
    ToClient_qaCreateItem(694117, 20, 1)
    ToClient_qaCreateItem(694130, 20, 1)
    ToClient_qaCreateItem(694142, 20, 1)
  elseif isClassType == __eClassType_BladeMaster then
    ToClient_qaCreateItem(694118, 20, 1)
    ToClient_qaCreateItem(694131, 20, 1)
    ToClient_qaCreateItem(694144, 20, 1)
  elseif isClassType == __eClassType_Valkyrie then
    ToClient_qaCreateItem(694113, 20, 1)
    ToClient_qaCreateItem(694126, 20, 1)
    ToClient_qaCreateItem(694143, 20, 1)
  elseif isClassType == __eClassType_BladeMasterWoman then
    ToClient_qaCreateItem(694118, 20, 1)
    ToClient_qaCreateItem(694131, 20, 1)
    ToClient_qaCreateItem(694145, 20, 1)
  elseif isClassType == __eClassType_Kunoichi then
    ToClient_qaCreateItem(694117, 20, 1)
    ToClient_qaCreateItem(694132, 20, 1)
    ToClient_qaCreateItem(694133, 20, 1)
    ToClient_qaCreateItem(694147, 20, 1)
  elseif isClassType == __eClassType_NinjaMan then
    ToClient_qaCreateItem(694117, 20, 1)
    ToClient_qaCreateItem(694132, 20, 1)
    ToClient_qaCreateItem(694133, 20, 1)
    ToClient_qaCreateItem(694146, 20, 1)
  elseif isClassType == __eClassType_WizardWoman then
    ToClient_qaCreateItem(694119, 20, 1)
    ToClient_qaCreateItem(694127, 20, 1)
    ToClient_qaCreateItem(694148, 20, 1)
  elseif isClassType == __eClassType_WizardMan then
    ToClient_qaCreateItem(694119, 20, 1)
    ToClient_qaCreateItem(694127, 20, 1)
    ToClient_qaCreateItem(694149, 20, 1)
  elseif isClassType == __eClassType_DarkElf then
    ToClient_qaCreateItem(694120, 20, 1)
    ToClient_qaCreateItem(694129, 20, 1)
    ToClient_qaCreateItem(694150, 20, 1)
  elseif isClassType == __eClassType_Combattant then
    ToClient_qaCreateItem(694121, 20, 1)
    ToClient_qaCreateItem(694134, 20, 1)
    ToClient_qaCreateItem(694151, 20, 1)
  elseif isClassType == __eClassType_Mystic then
    ToClient_qaCreateItem(694121, 20, 1)
    ToClient_qaCreateItem(694134, 20, 1)
    ToClient_qaCreateItem(694152, 20, 1)
  elseif isClassType == __eClassType_Lhan then
    ToClient_qaCreateItem(694122, 20, 1)
    ToClient_qaCreateItem(694135, 20, 1)
    ToClient_qaCreateItem(694153, 20, 1)
  elseif isClassType == __eClassType_RangerMan then
    ToClient_qaCreateItem(694123, 20, 1)
    ToClient_qaCreateItem(694136, 20, 1)
    ToClient_qaCreateItem(694154, 20, 1)
  elseif isClassType == __eClassType_ShyWaman then
    ToClient_qaCreateItem(694124, 20, 1)
    ToClient_qaCreateItem(694137, 20, 1)
    ToClient_qaCreateItem(694155, 20, 1)
  elseif isClassType == __eClassType_Guardian then
    ToClient_qaCreateItem(694125, 20, 1)
    ToClient_qaCreateItem(694126, 20, 1)
    ToClient_qaCreateItem(694156, 20, 1)
  elseif isClassType == __eClassType_Hashashin then
    ToClient_qaCreateItem(692097, 20, 1)
    ToClient_qaCreateItem(692560, 20, 1)
  end
  ToClient_qaCreateItem(694105, 20, 1)
  ToClient_qaCreateItem(694106, 20, 1)
  ToClient_qaCreateItem(694107, 20, 1)
  ToClient_qaCreateItem(694108, 20, 1)
  ToClient_qaCreateItem(694109, 5, 1)
  ToClient_qaCreateItem(694110, 5, 2)
  ToClient_qaCreateItem(694111, 5, 2)
  ToClient_qaCreateItem(694112, 5, 1)
  ToClient_qaCreateItem(44980, 0, 1)
  ToClient_qaCreateItem(750524, 0, 1)
  awakening()
end
function cjready()
  ToClient_qaCreateItem(65487, 0, 2)
  ToClient_qaCreateItem(65488, 0, 2)
  ToClient_qaCreateItem(65126, 0, 1)
  ToClient_qaCreateItem(50118, 0, 1)
  ToClient_qaCreateItem(21016, 0, 1)
  ToClient_qaCreateItem(1, 0, 1000000)
  ToClient_qaCreateItem(18422, 0, 1)
  ToClient_qaCreateItem(17974, 0, 1)
  ToClient_qaCreateItem(17904, 0, 1)
  ToClient_qaCreateItem(17953, 0, 1)
  ToClient_qaCreateItem(17975, 0, 1)
  ToClient_qaCreateItem(529, 0, 200)
  ToClient_qaCreateItem(17567, 0, 100)
  ToClient_qaCreateItem(65489, 0, 1)
  ToClient_qaCreateItem(65490, 0, 1)
  ToClient_qaCreateItem(65491, 0, 1)
  ToClient_qaCreateItem(60, 0, 250)
  LearnSkill()
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  local isClassType = selfPlayer:getClassType()
  if isClassType == __eClassType_Warrior then
    ToClient_qaLevelUp(60)
    ToClient_qaConditionCompleteQuest()
    ToClient_qaCompleteQuest(285, 4)
    ToClient_qaCompleteQuest(653, 6)
    ToClient_qaCreateItem(142, 0, 1)
    ToClient_qaCreateItem(143, 0, 1)
    ToClient_qaCreateItem(144, 0, 1)
    ToClient_qaCreateItem(191, 0, 1)
    ToClient_qaCreateItem(21629, 0, 1)
    ToClient_qaCreateItem(594, 0, 200)
  elseif isClassType == __eClassType_ElfRanger then
    ToClient_qaLevelUp(60)
    ToClient_qaConditionCompleteQuest()
    ToClient_qaCompleteQuest(293, 4)
    ToClient_qaCompleteQuest(653, 6)
    ToClient_qaCreateItem(151, 0, 1)
    ToClient_qaCreateItem(152, 0, 1)
    ToClient_qaCreateItem(153, 0, 1)
    ToClient_qaCreateItem(21699, 0, 1)
    ToClient_qaCreateItem(532, 0, 200)
  elseif isClassType == __eClassType_Sorcerer then
    ToClient_qaLevelUp(60)
    ToClient_qaConditionCompleteQuest()
    ToClient_qaCompleteQuest(287, 4)
    ToClient_qaCompleteQuest(653, 6)
    ToClient_qaCreateItem(145, 0, 1)
    ToClient_qaCreateItem(146, 0, 1)
    ToClient_qaCreateItem(147, 0, 1)
    ToClient_qaCreateItem(21637, 0, 1)
    ToClient_qaCreateItem(532, 0, 200)
  elseif isClassType == __eClassType_Giant then
    ToClient_qaLevelUp(60)
    ToClient_qaConditionCompleteQuest()
    ToClient_qaCompleteQuest(290, 4)
    ToClient_qaCompleteQuest(653, 6)
    ToClient_qaCreateItem(148, 0, 1)
    ToClient_qaCreateItem(149, 0, 1)
    ToClient_qaCreateItem(150, 0, 1)
    ToClient_qaCreateItem(21671, 0, 1)
    ToClient_qaCreateItem(594, 0, 200)
  elseif isClassType == __eClassType_Tamer then
    ToClient_qaLevelUp(60)
    ToClient_qaConditionCompleteQuest()
    ToClient_qaCompleteQuest(296, 4)
    ToClient_qaCompleteQuest(653, 6)
    ToClient_qaCreateItem(154, 0, 1)
    ToClient_qaCreateItem(155, 0, 1)
    ToClient_qaCreateItem(156, 0, 1)
    ToClient_qaCreateItem(21264, 0, 1)
    ToClient_qaCreateItem(532, 0, 200)
  elseif isClassType == __eClassType_BladeMaster then
    ToClient_qaLevelUp(60)
    ToClient_qaConditionCompleteQuest()
    ToClient_qaCompleteQuest(319, 4)
    ToClient_qaCompleteQuest(653, 6)
    ToClient_qaCreateItem(160, 0, 1)
    ToClient_qaCreateItem(161, 0, 1)
    ToClient_qaCreateItem(162, 0, 1)
    ToClient_qaCreateItem(21257, 0, 1)
    ToClient_qaCreateItem(594, 0, 200)
  elseif isClassType == __eClassType_Valkyrie then
    ToClient_qaLevelUp(60)
    ToClient_qaConditionCompleteQuest()
    ToClient_qaCompleteQuest(298, 4)
    ToClient_qaCompleteQuest(653, 6)
    ToClient_qaCreateItem(157, 0, 1)
    ToClient_qaCreateItem(158, 0, 1)
    ToClient_qaCreateItem(159, 0, 1)
    ToClient_qaCreateItem(21275, 0, 1)
    ToClient_qaCreateItem(598, 0, 200)
  elseif isClassType == __eClassType_BladeMasterWoman then
    ToClient_qaLevelUp(60)
    ToClient_qaConditionCompleteQuest()
    ToClient_qaCompleteQuest(321, 4)
    ToClient_qaCompleteQuest(653, 6)
    ToClient_qaCreateItem(163, 0, 1)
    ToClient_qaCreateItem(164, 0, 1)
    ToClient_qaCreateItem(165, 0, 1)
    ToClient_qaCreateItem(21196, 0, 1)
    ToClient_qaCreateItem(594, 0, 200)
  elseif isClassType == __eClassType_Kunoichi then
    ToClient_qaLevelUp(60)
    ToClient_qaConditionCompleteQuest()
    ToClient_qaCompleteQuest(327, 4)
    ToClient_qaCompleteQuest(653, 6)
    ToClient_qaCreateItem(169, 0, 1)
    ToClient_qaCreateItem(170, 0, 1)
    ToClient_qaCreateItem(171, 0, 1)
    ToClient_qaCreateItem(21366, 0, 1)
    ToClient_qaCreateItem(594, 0, 200)
  elseif isClassType == __eClassType_NinjaMan then
    ToClient_qaLevelUp(60)
    ToClient_qaConditionCompleteQuest()
    ToClient_qaCompleteQuest(325, 4)
    ToClient_qaCompleteQuest(653, 6)
    ToClient_qaCreateItem(166, 0, 1)
    ToClient_qaCreateItem(167, 0, 1)
    ToClient_qaCreateItem(168, 0, 1)
    ToClient_qaCreateItem(21371, 0, 1)
    ToClient_qaCreateItem(594, 0, 200)
  elseif isClassType == __eClassType_WizardWoman then
    ToClient_qaLevelUp(60)
    ToClient_qaConditionCompleteQuest()
    ToClient_qaCompleteQuest(334, 5)
    ToClient_qaCompleteQuest(653, 6)
    ToClient_qaCreateItem(172, 0, 1)
    ToClient_qaCreateItem(173, 0, 1)
    ToClient_qaCreateItem(174, 0, 1)
    ToClient_qaCreateItem(21309, 0, 1)
    ToClient_qaCreateItem(532, 0, 200)
  elseif isClassType == __eClassType_WizardMan then
    ToClient_qaLevelUp(60)
    ToClient_qaConditionCompleteQuest()
    ToClient_qaCompleteQuest(336, 5)
    ToClient_qaCompleteQuest(653, 6)
    ToClient_qaCreateItem(175, 0, 1)
    ToClient_qaCreateItem(176, 0, 1)
    ToClient_qaCreateItem(177, 0, 1)
    ToClient_qaCreateItem(21925, 0, 1)
    ToClient_qaCreateItem(532, 0, 200)
  elseif isClassType == __eClassType_DarkElf then
    ToClient_qaLevelUp(60)
    ToClient_qaConditionCompleteQuest()
    ToClient_qaCompleteQuest(338, 5)
    ToClient_qaCompleteQuest(653, 6)
    ToClient_qaCreateItem(178, 0, 1)
    ToClient_qaCreateItem(179, 0, 1)
    ToClient_qaCreateItem(180, 0, 1)
    ToClient_qaCreateItem(54405, 0, 1)
    ToClient_qaCreateItem(532, 0, 200)
  elseif isClassType == __eClassType_Combattant then
    ToClient_qaLevelUp(60)
    ToClient_qaConditionCompleteQuest()
    ToClient_qaCompleteQuest(342, 7)
    ToClient_qaCompleteQuest(653, 6)
    ToClient_qaCreateItem(181, 0, 1)
    ToClient_qaCreateItem(182, 0, 1)
    ToClient_qaCreateItem(183, 0, 1)
    ToClient_qaCreateItem(57043, 0, 1)
    ToClient_qaCreateItem(594, 0, 200)
  elseif isClassType == __eClassType_Mystic then
    ToClient_qaLevelUp(60)
    ToClient_qaConditionCompleteQuest()
    ToClient_qaCompleteQuest(343, 5)
    ToClient_qaCompleteQuest(653, 6)
    ToClient_qaCreateItem(184, 0, 1)
    ToClient_qaCreateItem(185, 0, 1)
    ToClient_qaCreateItem(186, 0, 1)
    ToClient_qaCreateItem(26054, 0, 1)
    ToClient_qaCreateItem(594, 0, 200)
  elseif isClassType == __eClassType_Lhan then
    ToClient_qaLevelUp(60)
    ToClient_qaConditionCompleteQuest()
    ToClient_qaCompleteQuest(345, 5)
    ToClient_qaCompleteQuest(653, 6)
    ToClient_qaCreateItem(187, 0, 1)
    ToClient_qaCreateItem(188, 0, 1)
    ToClient_qaCreateItem(189, 0, 1)
    ToClient_qaCreateItem(551061, 0, 1)
    ToClient_qaCreateItem(594, 0, 200)
  end
end
function LearnSkill()
  for i = 1, 13 do
    luaTimer_AddEvent(SkillQaLearn, 900 * i, false, 0)
    luaTimer_AddEvent(SkillQaLearn, 1100 * i, false, 0)
  end
end
function SkillQaLearn()
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  local isClassType = selfPlayer:getClassType()
  if isClassType == __eClassType_Warrior then
    ToClient_qaLearnSkill(175)
    ToClient_qaLearnSkill(173)
    ToClient_qaLearnSkill(174)
    ToClient_qaLearnSkill(1017)
    ToClient_qaLearnSkill(1019)
    ToClient_qaLearnSkill(1020)
    ToClient_qaLearnSkill(1083)
    ToClient_qaLearnSkill(1084)
    ToClient_qaLearnSkill(1085)
    ToClient_qaLearnSkill(580)
    ToClient_qaLearnSkill(1021)
    ToClient_qaLearnSkill(1127)
    ToClient_qaLearnSkill(1128)
    ToClient_qaLearnSkill(1129)
    ToClient_qaLearnSkill(1022)
    ToClient_qaLearnSkill(1130)
    ToClient_qaLearnSkill(1131)
    ToClient_qaLearnSkill(1132)
    ToClient_qaLearnSkill(1023)
    ToClient_qaLearnSkill(1133)
    ToClient_qaLearnSkill(1134)
    ToClient_qaLearnSkill(1135)
    ToClient_qaLearnSkill(577)
    ToClient_qaLearnSkill(1024)
    ToClient_qaLearnSkill(1078)
    ToClient_qaLearnSkill(1079)
    ToClient_qaLearnSkill(1025)
    ToClient_qaLearnSkill(1139)
    ToClient_qaLearnSkill(1140)
    ToClient_qaLearnSkill(1141)
    ToClient_qaLearnSkill(1026)
    ToClient_qaLearnSkill(1142)
    ToClient_qaLearnSkill(1143)
    ToClient_qaLearnSkill(1027)
    ToClient_qaLearnSkill(1136)
    ToClient_qaLearnSkill(1137)
    ToClient_qaLearnSkill(1138)
    ToClient_qaLearnSkill(1028)
    ToClient_qaLearnSkill(1080)
    ToClient_qaLearnSkill(1081)
    ToClient_qaLearnSkill(1082)
    ToClient_qaLearnSkill(1018)
    ToClient_qaLearnSkill(1212)
    ToClient_qaLearnSkill(1213)
    ToClient_qaLearnSkill(1331)
    ToClient_qaLearnSkill(1030)
    ToClient_qaLearnSkill(1144)
    ToClient_qaLearnSkill(1145)
    ToClient_qaLearnSkill(1146)
    ToClient_qaLearnSkill(1147)
    ToClient_qaLearnSkill(1148)
    ToClient_qaLearnSkill(1000)
    ToClient_qaLearnSkill(1330)
    ToClient_qaLearnSkill(611)
    ToClient_qaLearnSkill(612)
    ToClient_qaLearnSkill(613)
    ToClient_qaLearnSkill(614)
    ToClient_qaLearnSkill(615)
    ToClient_qaLearnSkill(616)
    ToClient_qaLearnSkill(617)
    ToClient_qaLearnSkill(618)
    ToClient_qaLearnSkill(619)
    ToClient_qaLearnSkill(620)
    ToClient_qaLearnSkill(621)
    ToClient_qaLearnSkill(622)
    ToClient_qaLearnSkill(623)
    ToClient_qaLearnSkill(624)
    ToClient_qaLearnSkill(625)
    ToClient_qaLearnSkill(626)
    ToClient_qaLearnSkill(627)
    ToClient_qaLearnSkill(628)
    ToClient_qaLearnSkill(629)
    ToClient_qaLearnSkill(630)
    ToClient_qaLearnSkill(591)
    ToClient_qaLearnSkill(592)
    ToClient_qaLearnSkill(593)
    ToClient_qaLearnSkill(594)
    ToClient_qaLearnSkill(595)
    ToClient_qaLearnSkill(596)
    ToClient_qaLearnSkill(597)
    ToClient_qaLearnSkill(598)
    ToClient_qaLearnSkill(599)
    ToClient_qaLearnSkill(600)
    ToClient_qaLearnSkill(601)
    ToClient_qaLearnSkill(602)
    ToClient_qaLearnSkill(603)
    ToClient_qaLearnSkill(604)
    ToClient_qaLearnSkill(605)
    ToClient_qaLearnSkill(606)
    ToClient_qaLearnSkill(607)
    ToClient_qaLearnSkill(608)
    ToClient_qaLearnSkill(609)
    ToClient_qaLearnSkill(610)
    ToClient_qaLearnSkill(706)
    ToClient_qaLearnSkill(707)
    ToClient_qaLearnSkill(708)
    ToClient_qaLearnSkill(709)
    ToClient_qaLearnSkill(710)
    ToClient_qaLearnSkill(711)
    ToClient_qaLearnSkill(712)
    ToClient_qaLearnSkill(713)
    ToClient_qaLearnSkill(714)
    ToClient_qaLearnSkill(715)
    ToClient_qaLearnSkill(195)
    ToClient_qaLearnSkill(196)
    ToClient_qaLearnSkill(197)
    ToClient_qaLearnSkill(198)
    ToClient_qaLearnSkill(286)
    ToClient_qaLearnSkill(293)
    ToClient_qaLearnSkill(305)
    ToClient_qaLearnSkill(306)
    ToClient_qaLearnSkill(313)
    ToClient_qaLearnSkill(590)
    ToClient_qaLearnSkill(716)
    ToClient_qaLearnSkill(589)
    ToClient_qaLearnSkill(349)
    ToClient_qaLearnSkill(350)
    ToClient_qaLearnSkill(351)
    ToClient_qaLearnSkill(705)
    ToClient_qaLearnSkill(352)
    ToClient_qaLearnSkill(353)
    ToClient_qaLearnSkill(579)
    ToClient_qaLearnSkill(355)
    ToClient_qaLearnSkill(356)
    ToClient_qaLearnSkill(578)
    ToClient_qaLearnSkill(357)
    ToClient_qaLearnSkill(993)
    ToClient_qaLearnSkill(994)
    ToClient_qaLearnSkill(995)
    ToClient_qaLearnSkill(369)
    ToClient_qaLearnSkill(370)
    ToClient_qaLearnSkill(376)
    ToClient_qaLearnSkill(377)
    ToClient_qaLearnSkill(385)
    ToClient_qaLearnSkill(387)
    ToClient_qaLearnSkill(388)
    ToClient_qaLearnSkill(1440)
    ToClient_qaLearnSkill(1441)
    ToClient_qaLearnSkill(1442)
    ToClient_qaLearnSkill(1443)
    ToClient_qaLearnSkill(1444)
    ToClient_qaLearnSkill(96)
    ToClient_qaLearnSkill(108)
    ToClient_qaLearnSkill(109)
    ToClient_qaLearnSkill(110)
    ToClient_qaLearnSkill(111)
    ToClient_qaLearnSkill(112)
    ToClient_qaLearnSkill(113)
    ToClient_qaLearnSkill(216)
    ToClient_qaLearnSkill(217)
    ToClient_qaLearnSkill(218)
    ToClient_qaLearnSkill(219)
    ToClient_qaLearnSkill(1458)
    ToClient_qaLearnSkill(1712)
    ToClient_qaLearnSkill(1713)
    ToClient_qaLearnSkill(1714)
    ToClient_qaLearnSkill(1715)
    ToClient_qaLearnSkill(1716)
    ToClient_qaLearnSkill(1717)
    ToClient_qaLearnSkill(1718)
    ToClient_qaLearnSkill(1719)
    ToClient_qaLearnSkill(1720)
    ToClient_qaLearnSkill(1721)
    ToClient_qaLearnSkill(1722)
    ToClient_qaLearnSkill(1723)
    ToClient_qaLearnSkill(1724)
    ToClient_qaLearnSkill(1725)
    ToClient_qaLearnSkill(1726)
    ToClient_qaLearnSkill(1727)
    ToClient_qaLearnSkill(1728)
    ToClient_qaLearnSkill(1729)
    ToClient_qaLearnSkill(1730)
    ToClient_qaLearnSkill(1733)
    ToClient_qaLearnSkill(1734)
    ToClient_qaLearnSkill(1735)
    ToClient_qaLearnSkill(1736)
    ToClient_qaLearnSkill(1737)
    ToClient_qaLearnSkill(1738)
    ToClient_qaLearnSkill(1744)
    ToClient_qaLearnSkill(1748)
    ToClient_qaLearnSkill(1751)
    ToClient_qaLearnSkill(1752)
    ToClient_qaLearnSkill(1753)
    ToClient_qaLearnSkill(1754)
    ToClient_qaLearnSkill(1755)
    ToClient_qaLearnSkill(1758)
    ToClient_qaLearnSkill(1759)
    ToClient_qaLearnSkill(1760)
    ToClient_qaLearnSkill(1761)
    ToClient_qaLearnSkill(1762)
    ToClient_qaLearnSkill(1763)
    ToClient_qaLearnSkill(1764)
    ToClient_qaLearnSkill(1765)
    ToClient_qaLearnSkill(1766)
    ToClient_qaLearnSkill(1767)
    ToClient_qaLearnSkill(1768)
    ToClient_qaLearnSkill(2831)
    ToClient_qaLearnSkill(2832)
    ToClient_qaLearnSkill(2833)
    ToClient_qaLearnSkill(2834)
    ToClient_qaLearnSkill(2835)
    ToClient_qaLearnSkill(2836)
    ToClient_qaLearnSkill(2837)
    ToClient_qaLearnSkill(2838)
    ToClient_qaLearnSkill(2839)
    ToClient_qaLearnSkill(2840)
    ToClient_qaLearnSkill(2841)
    ToClient_qaLearnSkill(2842)
    ToClient_qaLearnSkill(2843)
    ToClient_qaLearnSkill(2844)
    ToClient_qaLearnSkill(2845)
    ToClient_qaLearnSkill(2846)
    ToClient_qaLearnSkill(2847)
    ToClient_qaLearnSkill(2848)
    ToClient_qaLearnSkill(2849)
    ToClient_qaLearnSkill(2850)
    ToClient_qaLearnSkill(2851)
    ToClient_qaLearnSkill(2852)
    ToClient_qaLearnSkill(1702)
    ToClient_qaLearnSkill(1703)
    ToClient_qaLearnSkill(1704)
    ToClient_qaLearnSkill(1705)
    ToClient_qaLearnSkill(1706)
    ToClient_qaLearnSkill(1707)
    ToClient_qaLearnSkill(2072)
    ToClient_qaLearnSkill(2073)
    ToClient_qaLearnSkill(2074)
    ToClient_qaLearnSkill(2075)
    ToClient_qaLearnSkill(2076)
  elseif isClassType == __eClassType_Sorcerer then
    ToClient_qaLearnSkill(64)
    ToClient_qaLearnSkill(65)
    ToClient_qaLearnSkill(66)
    ToClient_qaLearnSkill(67)
    ToClient_qaLearnSkill(68)
    ToClient_qaLearnSkill(69)
    ToClient_qaLearnSkill(70)
    ToClient_qaLearnSkill(71)
    ToClient_qaLearnSkill(72)
    ToClient_qaLearnSkill(73)
    ToClient_qaLearnSkill(74)
    ToClient_qaLearnSkill(75)
    ToClient_qaLearnSkill(76)
    ToClient_qaLearnSkill(77)
    ToClient_qaLearnSkill(78)
    ToClient_qaLearnSkill(79)
    ToClient_qaLearnSkill(80)
    ToClient_qaLearnSkill(81)
    ToClient_qaLearnSkill(82)
    ToClient_qaLearnSkill(83)
    ToClient_qaLearnSkill(44)
    ToClient_qaLearnSkill(45)
    ToClient_qaLearnSkill(46)
    ToClient_qaLearnSkill(47)
    ToClient_qaLearnSkill(48)
    ToClient_qaLearnSkill(49)
    ToClient_qaLearnSkill(50)
    ToClient_qaLearnSkill(51)
    ToClient_qaLearnSkill(52)
    ToClient_qaLearnSkill(53)
    ToClient_qaLearnSkill(54)
    ToClient_qaLearnSkill(55)
    ToClient_qaLearnSkill(56)
    ToClient_qaLearnSkill(57)
    ToClient_qaLearnSkill(58)
    ToClient_qaLearnSkill(59)
    ToClient_qaLearnSkill(60)
    ToClient_qaLearnSkill(61)
    ToClient_qaLearnSkill(62)
    ToClient_qaLearnSkill(63)
    ToClient_qaLearnSkill(1046)
    ToClient_qaLearnSkill(1047)
    ToClient_qaLearnSkill(1182)
    ToClient_qaLearnSkill(1048)
    ToClient_qaLearnSkill(1183)
    ToClient_qaLearnSkill(1184)
    ToClient_qaLearnSkill(1049)
    ToClient_qaLearnSkill(1185)
    ToClient_qaLearnSkill(1186)
    ToClient_qaLearnSkill(1187)
    ToClient_qaLearnSkill(1050)
    ToClient_qaLearnSkill(1188)
    ToClient_qaLearnSkill(1189)
    ToClient_qaLearnSkill(1190)
    ToClient_qaLearnSkill(1051)
    ToClient_qaLearnSkill(1191)
    ToClient_qaLearnSkill(1192)
    ToClient_qaLearnSkill(1193)
    ToClient_qaLearnSkill(1194)
    ToClient_qaLearnSkill(1052)
    ToClient_qaLearnSkill(1195)
    ToClient_qaLearnSkill(93)
    ToClient_qaLearnSkill(1053)
    ToClient_qaLearnSkill(1196)
    ToClient_qaLearnSkill(1197)
    ToClient_qaLearnSkill(1198)
    ToClient_qaLearnSkill(581)
    ToClient_qaLearnSkill(1054)
    ToClient_qaLearnSkill(1199)
    ToClient_qaLearnSkill(1200)
    ToClient_qaLearnSkill(1055)
    ToClient_qaLearnSkill(1201)
    ToClient_qaLearnSkill(1060)
    ToClient_qaLearnSkill(582)
    ToClient_qaLearnSkill(1056)
    ToClient_qaLearnSkill(1202)
    ToClient_qaLearnSkill(1203)
    ToClient_qaLearnSkill(583)
    ToClient_qaLearnSkill(1204)
    ToClient_qaLearnSkill(1205)
    ToClient_qaLearnSkill(1059)
    ToClient_qaLearnSkill(1206)
    ToClient_qaLearnSkill(1207)
    ToClient_qaLearnSkill(1061)
    ToClient_qaLearnSkill(1208)
    ToClient_qaLearnSkill(1209)
    ToClient_qaLearnSkill(1210)
    ToClient_qaLearnSkill(1356)
    ToClient_qaLearnSkill(1357)
    ToClient_qaLearnSkill(1358)
    ToClient_qaLearnSkill(1359)
    ToClient_qaLearnSkill(1360)
    ToClient_qaLearnSkill(1361)
    ToClient_qaLearnSkill(1362)
    ToClient_qaLearnSkill(199)
    ToClient_qaLearnSkill(200)
    ToClient_qaLearnSkill(160)
    ToClient_qaLearnSkill(161)
    ToClient_qaLearnSkill(162)
    ToClient_qaLearnSkill(163)
    ToClient_qaLearnSkill(164)
    ToClient_qaLearnSkill(165)
    ToClient_qaLearnSkill(166)
    ToClient_qaLearnSkill(167)
    ToClient_qaLearnSkill(168)
    ToClient_qaLearnSkill(1411)
    ToClient_qaLearnSkill(1412)
    ToClient_qaLearnSkill(169)
    ToClient_qaLearnSkill(1413)
    ToClient_qaLearnSkill(170)
    ToClient_qaLearnSkill(171)
    ToClient_qaLearnSkill(172)
    ToClient_qaLearnSkill(584)
    ToClient_qaLearnSkill(310)
    ToClient_qaLearnSkill(311)
    ToClient_qaLearnSkill(312)
    ToClient_qaLearnSkill(1414)
    ToClient_qaLearnSkill(1415)
    ToClient_qaLearnSkill(346)
    ToClient_qaLearnSkill(347)
    ToClient_qaLearnSkill(348)
    ToClient_qaLearnSkill(1417)
    ToClient_qaLearnSkill(1418)
    ToClient_qaLearnSkill(1430)
    ToClient_qaLearnSkill(1431)
    ToClient_qaLearnSkill(378)
    ToClient_qaLearnSkill(379)
    ToClient_qaLearnSkill(380)
    ToClient_qaLearnSkill(94)
    ToClient_qaLearnSkill(95)
    ToClient_qaLearnSkill(1500)
    ToClient_qaLearnSkill(114)
    ToClient_qaLearnSkill(115)
    ToClient_qaLearnSkill(116)
    ToClient_qaLearnSkill(117)
    ToClient_qaLearnSkill(118)
    ToClient_qaLearnSkill(119)
    ToClient_qaLearnSkill(120)
    ToClient_qaLearnSkill(1353)
    ToClient_qaLearnSkill(1354)
    ToClient_qaLearnSkill(1355)
    ToClient_qaLearnSkill(585)
    ToClient_qaLearnSkill(586)
    ToClient_qaLearnSkill(587)
    ToClient_qaLearnSkill(588)
    ToClient_qaLearnSkill(1432)
    ToClient_qaLearnSkill(1769)
    ToClient_qaLearnSkill(1770)
    ToClient_qaLearnSkill(1771)
    ToClient_qaLearnSkill(1772)
    ToClient_qaLearnSkill(1773)
    ToClient_qaLearnSkill(1774)
    ToClient_qaLearnSkill(1775)
    ToClient_qaLearnSkill(1776)
    ToClient_qaLearnSkill(1777)
    ToClient_qaLearnSkill(1778)
    ToClient_qaLearnSkill(1779)
    ToClient_qaLearnSkill(1780)
    ToClient_qaLearnSkill(1781)
    ToClient_qaLearnSkill(1782)
    ToClient_qaLearnSkill(1783)
    ToClient_qaLearnSkill(1784)
    ToClient_qaLearnSkill(1785)
    ToClient_qaLearnSkill(1786)
    ToClient_qaLearnSkill(1787)
    ToClient_qaLearnSkill(1788)
    ToClient_qaLearnSkill(1789)
    ToClient_qaLearnSkill(1790)
    ToClient_qaLearnSkill(1791)
    ToClient_qaLearnSkill(1792)
    ToClient_qaLearnSkill(1793)
    ToClient_qaLearnSkill(1794)
    ToClient_qaLearnSkill(1795)
    ToClient_qaLearnSkill(1796)
    ToClient_qaLearnSkill(1797)
    ToClient_qaLearnSkill(1798)
    ToClient_qaLearnSkill(1799)
    ToClient_qaLearnSkill(1800)
    ToClient_qaLearnSkill(1801)
    ToClient_qaLearnSkill(1802)
    ToClient_qaLearnSkill(1803)
    ToClient_qaLearnSkill(1804)
    ToClient_qaLearnSkill(1805)
    ToClient_qaLearnSkill(1806)
    ToClient_qaLearnSkill(1807)
    ToClient_qaLearnSkill(1808)
    ToClient_qaLearnSkill(1809)
    ToClient_qaLearnSkill(1810)
    ToClient_qaLearnSkill(1811)
    ToClient_qaLearnSkill(2870)
    ToClient_qaLearnSkill(2871)
    ToClient_qaLearnSkill(2872)
    ToClient_qaLearnSkill(2873)
    ToClient_qaLearnSkill(2874)
    ToClient_qaLearnSkill(2875)
    ToClient_qaLearnSkill(2876)
    ToClient_qaLearnSkill(2877)
    ToClient_qaLearnSkill(2878)
    ToClient_qaLearnSkill(2879)
    ToClient_qaLearnSkill(2880)
    ToClient_qaLearnSkill(2881)
    ToClient_qaLearnSkill(2882)
    ToClient_qaLearnSkill(2883)
    ToClient_qaLearnSkill(2884)
    ToClient_qaLearnSkill(2885)
    ToClient_qaLearnSkill(2886)
    ToClient_qaLearnSkill(2887)
    ToClient_qaLearnSkill(2888)
    ToClient_qaLearnSkill(2869)
    ToClient_qaLearnSkill(1702)
    ToClient_qaLearnSkill(1703)
    ToClient_qaLearnSkill(1704)
    ToClient_qaLearnSkill(1705)
    ToClient_qaLearnSkill(1706)
    ToClient_qaLearnSkill(1707)
    ToClient_qaLearnSkill(2072)
    ToClient_qaLearnSkill(2073)
    ToClient_qaLearnSkill(2074)
    ToClient_qaLearnSkill(2075)
    ToClient_qaLearnSkill(2076)
  elseif isClassType == __eClassType_ElfRanger then
    ToClient_qaLearnSkill(97)
    ToClient_qaLearnSkill(98)
    ToClient_qaLearnSkill(99)
    ToClient_qaLearnSkill(100)
    ToClient_qaLearnSkill(101)
    ToClient_qaLearnSkill(138)
    ToClient_qaLearnSkill(139)
    ToClient_qaLearnSkill(140)
    ToClient_qaLearnSkill(141)
    ToClient_qaLearnSkill(142)
    ToClient_qaLearnSkill(143)
    ToClient_qaLearnSkill(144)
    ToClient_qaLearnSkill(145)
    ToClient_qaLearnSkill(146)
    ToClient_qaLearnSkill(147)
    ToClient_qaLearnSkill(148)
    ToClient_qaLearnSkill(149)
    ToClient_qaLearnSkill(150)
    ToClient_qaLearnSkill(151)
    ToClient_qaLearnSkill(152)
    ToClient_qaLearnSkill(153)
    ToClient_qaLearnSkill(154)
    ToClient_qaLearnSkill(155)
    ToClient_qaLearnSkill(156)
    ToClient_qaLearnSkill(157)
    ToClient_qaLearnSkill(176)
    ToClient_qaLearnSkill(177)
    ToClient_qaLearnSkill(178)
    ToClient_qaLearnSkill(179)
    ToClient_qaLearnSkill(180)
    ToClient_qaLearnSkill(181)
    ToClient_qaLearnSkill(182)
    ToClient_qaLearnSkill(183)
    ToClient_qaLearnSkill(184)
    ToClient_qaLearnSkill(185)
    ToClient_qaLearnSkill(186)
    ToClient_qaLearnSkill(187)
    ToClient_qaLearnSkill(188)
    ToClient_qaLearnSkill(189)
    ToClient_qaLearnSkill(190)
    ToClient_qaLearnSkill(191)
    ToClient_qaLearnSkill(192)
    ToClient_qaLearnSkill(193)
    ToClient_qaLearnSkill(194)
    ToClient_qaLearnSkill(307)
    ToClient_qaLearnSkill(308)
    ToClient_qaLearnSkill(309)
    ToClient_qaLearnSkill(318)
    ToClient_qaLearnSkill(319)
    ToClient_qaLearnSkill(320)
    ToClient_qaLearnSkill(321)
    ToClient_qaLearnSkill(322)
    ToClient_qaLearnSkill(323)
    ToClient_qaLearnSkill(324)
    ToClient_qaLearnSkill(344)
    ToClient_qaLearnSkill(374)
    ToClient_qaLearnSkill(375)
    ToClient_qaLearnSkill(381)
    ToClient_qaLearnSkill(382)
    ToClient_qaLearnSkill(383)
    ToClient_qaLearnSkill(384)
    ToClient_qaLearnSkill(1001)
    ToClient_qaLearnSkill(1002)
    ToClient_qaLearnSkill(1003)
    ToClient_qaLearnSkill(1004)
    ToClient_qaLearnSkill(1005)
    ToClient_qaLearnSkill(1006)
    ToClient_qaLearnSkill(1007)
    ToClient_qaLearnSkill(1008)
    ToClient_qaLearnSkill(1009)
    ToClient_qaLearnSkill(1011)
    ToClient_qaLearnSkill(1012)
    ToClient_qaLearnSkill(1013)
    ToClient_qaLearnSkill(1015)
    ToClient_qaLearnSkill(1016)
    ToClient_qaLearnSkill(1029)
    ToClient_qaLearnSkill(1077)
    ToClient_qaLearnSkill(1086)
    ToClient_qaLearnSkill(1087)
    ToClient_qaLearnSkill(1088)
    ToClient_qaLearnSkill(1090)
    ToClient_qaLearnSkill(1091)
    ToClient_qaLearnSkill(1092)
    ToClient_qaLearnSkill(1093)
    ToClient_qaLearnSkill(1095)
    ToClient_qaLearnSkill(1096)
    ToClient_qaLearnSkill(1097)
    ToClient_qaLearnSkill(1098)
    ToClient_qaLearnSkill(1099)
    ToClient_qaLearnSkill(1100)
    ToClient_qaLearnSkill(1101)
    ToClient_qaLearnSkill(1102)
    ToClient_qaLearnSkill(1103)
    ToClient_qaLearnSkill(1104)
    ToClient_qaLearnSkill(1105)
    ToClient_qaLearnSkill(1107)
    ToClient_qaLearnSkill(1110)
    ToClient_qaLearnSkill(1112)
    ToClient_qaLearnSkill(1113)
    ToClient_qaLearnSkill(1114)
    ToClient_qaLearnSkill(1115)
    ToClient_qaLearnSkill(1116)
    ToClient_qaLearnSkill(1119)
    ToClient_qaLearnSkill(1125)
    ToClient_qaLearnSkill(1126)
    ToClient_qaLearnSkill(1211)
    ToClient_qaLearnSkill(1250)
    ToClient_qaLearnSkill(1251)
    ToClient_qaLearnSkill(1252)
    ToClient_qaLearnSkill(1253)
    ToClient_qaLearnSkill(1254)
    ToClient_qaLearnSkill(1255)
    ToClient_qaLearnSkill(1257)
    ToClient_qaLearnSkill(1332)
    ToClient_qaLearnSkill(1333)
    ToClient_qaLearnSkill(1334)
    ToClient_qaLearnSkill(1335)
    ToClient_qaLearnSkill(1336)
    ToClient_qaLearnSkill(1337)
    ToClient_qaLearnSkill(1363)
    ToClient_qaLearnSkill(1364)
    ToClient_qaLearnSkill(1365)
    ToClient_qaLearnSkill(1366)
    ToClient_qaLearnSkill(1367)
    ToClient_qaLearnSkill(1368)
    ToClient_qaLearnSkill(1369)
    ToClient_qaLearnSkill(1370)
    ToClient_qaLearnSkill(1371)
    ToClient_qaLearnSkill(1372)
    ToClient_qaLearnSkill(1373)
    ToClient_qaLearnSkill(1374)
    ToClient_qaLearnSkill(1375)
    ToClient_qaLearnSkill(1376)
    ToClient_qaLearnSkill(1377)
    ToClient_qaLearnSkill(1388)
    ToClient_qaLearnSkill(1389)
    ToClient_qaLearnSkill(1390)
    ToClient_qaLearnSkill(1401)
    ToClient_qaLearnSkill(1402)
    ToClient_qaLearnSkill(1403)
    ToClient_qaLearnSkill(1404)
    ToClient_qaLearnSkill(1405)
    ToClient_qaLearnSkill(1406)
    ToClient_qaLearnSkill(1407)
    ToClient_qaLearnSkill(1408)
    ToClient_qaLearnSkill(1409)
    ToClient_qaLearnSkill(1410)
    ToClient_qaLearnSkill(1416)
    ToClient_qaLearnSkill(1428)
    ToClient_qaLearnSkill(1429)
    ToClient_qaLearnSkill(1435)
    ToClient_qaLearnSkill(1436)
    ToClient_qaLearnSkill(1438)
    ToClient_qaLearnSkill(1439)
    ToClient_qaLearnSkill(1448)
    ToClient_qaLearnSkill(1449)
    ToClient_qaLearnSkill(1702)
    ToClient_qaLearnSkill(1703)
    ToClient_qaLearnSkill(1704)
    ToClient_qaLearnSkill(1705)
    ToClient_qaLearnSkill(1706)
    ToClient_qaLearnSkill(1707)
    ToClient_qaLearnSkill(2072)
    ToClient_qaLearnSkill(2073)
    ToClient_qaLearnSkill(2074)
    ToClient_qaLearnSkill(2075)
    ToClient_qaLearnSkill(2076)
    ToClient_qaLearnSkill(1855)
    ToClient_qaLearnSkill(1856)
    ToClient_qaLearnSkill(1857)
    ToClient_qaLearnSkill(1858)
    ToClient_qaLearnSkill(1859)
    ToClient_qaLearnSkill(1860)
    ToClient_qaLearnSkill(1861)
    ToClient_qaLearnSkill(1862)
    ToClient_qaLearnSkill(1863)
    ToClient_qaLearnSkill(1864)
    ToClient_qaLearnSkill(1865)
    ToClient_qaLearnSkill(1866)
    ToClient_qaLearnSkill(1867)
    ToClient_qaLearnSkill(1868)
    ToClient_qaLearnSkill(1869)
    ToClient_qaLearnSkill(1870)
    ToClient_qaLearnSkill(1871)
    ToClient_qaLearnSkill(1872)
    ToClient_qaLearnSkill(1873)
    ToClient_qaLearnSkill(1874)
    ToClient_qaLearnSkill(1875)
    ToClient_qaLearnSkill(1876)
    ToClient_qaLearnSkill(1877)
    ToClient_qaLearnSkill(1878)
    ToClient_qaLearnSkill(1879)
    ToClient_qaLearnSkill(1880)
    ToClient_qaLearnSkill(1881)
    ToClient_qaLearnSkill(1882)
    ToClient_qaLearnSkill(1883)
    ToClient_qaLearnSkill(1884)
    ToClient_qaLearnSkill(1885)
    ToClient_qaLearnSkill(1886)
    ToClient_qaLearnSkill(1887)
    ToClient_qaLearnSkill(1888)
    ToClient_qaLearnSkill(1889)
    ToClient_qaLearnSkill(1890)
    ToClient_qaLearnSkill(1891)
    ToClient_qaLearnSkill(1892)
    ToClient_qaLearnSkill(1893)
    ToClient_qaLearnSkill(1894)
    ToClient_qaLearnSkill(1895)
    ToClient_qaLearnSkill(1896)
    ToClient_qaLearnSkill(1897)
    ToClient_qaLearnSkill(2737)
    ToClient_qaLearnSkill(2738)
  elseif isClassType == __eClassType_Giant then
    ToClient_qaLearnSkill(102)
    ToClient_qaLearnSkill(103)
    ToClient_qaLearnSkill(104)
    ToClient_qaLearnSkill(105)
    ToClient_qaLearnSkill(106)
    ToClient_qaLearnSkill(107)
    ToClient_qaLearnSkill(121)
    ToClient_qaLearnSkill(213)
    ToClient_qaLearnSkill(214)
    ToClient_qaLearnSkill(215)
    ToClient_qaLearnSkill(243)
    ToClient_qaLearnSkill(248)
    ToClient_qaLearnSkill(249)
    ToClient_qaLearnSkill(250)
    ToClient_qaLearnSkill(251)
    ToClient_qaLearnSkill(252)
    ToClient_qaLearnSkill(253)
    ToClient_qaLearnSkill(254)
    ToClient_qaLearnSkill(255)
    ToClient_qaLearnSkill(256)
    ToClient_qaLearnSkill(257)
    ToClient_qaLearnSkill(258)
    ToClient_qaLearnSkill(259)
    ToClient_qaLearnSkill(260)
    ToClient_qaLearnSkill(261)
    ToClient_qaLearnSkill(262)
    ToClient_qaLearnSkill(263)
    ToClient_qaLearnSkill(264)
    ToClient_qaLearnSkill(265)
    ToClient_qaLearnSkill(266)
    ToClient_qaLearnSkill(267)
    ToClient_qaLearnSkill(268)
    ToClient_qaLearnSkill(269)
    ToClient_qaLearnSkill(270)
    ToClient_qaLearnSkill(271)
    ToClient_qaLearnSkill(272)
    ToClient_qaLearnSkill(273)
    ToClient_qaLearnSkill(274)
    ToClient_qaLearnSkill(275)
    ToClient_qaLearnSkill(276)
    ToClient_qaLearnSkill(277)
    ToClient_qaLearnSkill(278)
    ToClient_qaLearnSkill(279)
    ToClient_qaLearnSkill(280)
    ToClient_qaLearnSkill(281)
    ToClient_qaLearnSkill(282)
    ToClient_qaLearnSkill(283)
    ToClient_qaLearnSkill(284)
    ToClient_qaLearnSkill(285)
    ToClient_qaLearnSkill(287)
    ToClient_qaLearnSkill(288)
    ToClient_qaLearnSkill(289)
    ToClient_qaLearnSkill(290)
    ToClient_qaLearnSkill(291)
    ToClient_qaLearnSkill(292)
    ToClient_qaLearnSkill(295)
    ToClient_qaLearnSkill(296)
    ToClient_qaLearnSkill(297)
    ToClient_qaLearnSkill(298)
    ToClient_qaLearnSkill(299)
    ToClient_qaLearnSkill(300)
    ToClient_qaLearnSkill(301)
    ToClient_qaLearnSkill(302)
    ToClient_qaLearnSkill(314)
    ToClient_qaLearnSkill(315)
    ToClient_qaLearnSkill(316)
    ToClient_qaLearnSkill(317)
    ToClient_qaLearnSkill(325)
    ToClient_qaLearnSkill(326)
    ToClient_qaLearnSkill(327)
    ToClient_qaLearnSkill(328)
    ToClient_qaLearnSkill(329)
    ToClient_qaLearnSkill(330)
    ToClient_qaLearnSkill(331)
    ToClient_qaLearnSkill(332)
    ToClient_qaLearnSkill(333)
    ToClient_qaLearnSkill(334)
    ToClient_qaLearnSkill(335)
    ToClient_qaLearnSkill(336)
    ToClient_qaLearnSkill(337)
    ToClient_qaLearnSkill(338)
    ToClient_qaLearnSkill(339)
    ToClient_qaLearnSkill(345)
    ToClient_qaLearnSkill(354)
    ToClient_qaLearnSkill(368)
    ToClient_qaLearnSkill(371)
    ToClient_qaLearnSkill(372)
    ToClient_qaLearnSkill(373)
    ToClient_qaLearnSkill(389)
    ToClient_qaLearnSkill(390)
    ToClient_qaLearnSkill(391)
    ToClient_qaLearnSkill(1031)
    ToClient_qaLearnSkill(1032)
    ToClient_qaLearnSkill(1033)
    ToClient_qaLearnSkill(1034)
    ToClient_qaLearnSkill(1036)
    ToClient_qaLearnSkill(1038)
    ToClient_qaLearnSkill(1039)
    ToClient_qaLearnSkill(1040)
    ToClient_qaLearnSkill(1041)
    ToClient_qaLearnSkill(1042)
    ToClient_qaLearnSkill(1043)
    ToClient_qaLearnSkill(1044)
    ToClient_qaLearnSkill(1045)
    ToClient_qaLearnSkill(1057)
    ToClient_qaLearnSkill(1058)
    ToClient_qaLearnSkill(1149)
    ToClient_qaLearnSkill(1150)
    ToClient_qaLearnSkill(1151)
    ToClient_qaLearnSkill(1152)
    ToClient_qaLearnSkill(1153)
    ToClient_qaLearnSkill(1154)
    ToClient_qaLearnSkill(1155)
    ToClient_qaLearnSkill(1157)
    ToClient_qaLearnSkill(1158)
    ToClient_qaLearnSkill(1159)
    ToClient_qaLearnSkill(1160)
    ToClient_qaLearnSkill(1161)
    ToClient_qaLearnSkill(1162)
    ToClient_qaLearnSkill(1163)
    ToClient_qaLearnSkill(1164)
    ToClient_qaLearnSkill(1165)
    ToClient_qaLearnSkill(1166)
    ToClient_qaLearnSkill(1167)
    ToClient_qaLearnSkill(1168)
    ToClient_qaLearnSkill(1169)
    ToClient_qaLearnSkill(1170)
    ToClient_qaLearnSkill(1171)
    ToClient_qaLearnSkill(1172)
    ToClient_qaLearnSkill(1173)
    ToClient_qaLearnSkill(1174)
    ToClient_qaLearnSkill(1175)
    ToClient_qaLearnSkill(1176)
    ToClient_qaLearnSkill(1177)
    ToClient_qaLearnSkill(1178)
    ToClient_qaLearnSkill(1179)
    ToClient_qaLearnSkill(1180)
    ToClient_qaLearnSkill(1181)
    ToClient_qaLearnSkill(1290)
    ToClient_qaLearnSkill(1291)
    ToClient_qaLearnSkill(1292)
    ToClient_qaLearnSkill(1293)
    ToClient_qaLearnSkill(1294)
    ToClient_qaLearnSkill(1391)
    ToClient_qaLearnSkill(1392)
    ToClient_qaLearnSkill(1393)
    ToClient_qaLearnSkill(1394)
    ToClient_qaLearnSkill(1395)
    ToClient_qaLearnSkill(1396)
    ToClient_qaLearnSkill(1397)
    ToClient_qaLearnSkill(1398)
    ToClient_qaLearnSkill(1399)
    ToClient_qaLearnSkill(1400)
    ToClient_qaLearnSkill(1419)
    ToClient_qaLearnSkill(1420)
    ToClient_qaLearnSkill(1421)
    ToClient_qaLearnSkill(1422)
    ToClient_qaLearnSkill(1423)
    ToClient_qaLearnSkill(1424)
    ToClient_qaLearnSkill(1425)
    ToClient_qaLearnSkill(1426)
    ToClient_qaLearnSkill(1427)
    ToClient_qaLearnSkill(1702)
    ToClient_qaLearnSkill(1703)
    ToClient_qaLearnSkill(1704)
    ToClient_qaLearnSkill(1705)
    ToClient_qaLearnSkill(1706)
    ToClient_qaLearnSkill(1707)
    ToClient_qaLearnSkill(2072)
    ToClient_qaLearnSkill(2073)
    ToClient_qaLearnSkill(2074)
    ToClient_qaLearnSkill(2075)
    ToClient_qaLearnSkill(2076)
    ToClient_qaLearnSkill(1812)
    ToClient_qaLearnSkill(1813)
    ToClient_qaLearnSkill(1814)
    ToClient_qaLearnSkill(1815)
    ToClient_qaLearnSkill(1816)
    ToClient_qaLearnSkill(1817)
    ToClient_qaLearnSkill(1818)
    ToClient_qaLearnSkill(1819)
    ToClient_qaLearnSkill(1820)
    ToClient_qaLearnSkill(1821)
    ToClient_qaLearnSkill(1822)
    ToClient_qaLearnSkill(1823)
    ToClient_qaLearnSkill(1824)
    ToClient_qaLearnSkill(1825)
    ToClient_qaLearnSkill(1826)
    ToClient_qaLearnSkill(1827)
    ToClient_qaLearnSkill(1828)
    ToClient_qaLearnSkill(1829)
    ToClient_qaLearnSkill(1830)
    ToClient_qaLearnSkill(1831)
    ToClient_qaLearnSkill(1832)
    ToClient_qaLearnSkill(1833)
    ToClient_qaLearnSkill(1834)
    ToClient_qaLearnSkill(1835)
    ToClient_qaLearnSkill(1836)
    ToClient_qaLearnSkill(1837)
    ToClient_qaLearnSkill(1838)
    ToClient_qaLearnSkill(1839)
    ToClient_qaLearnSkill(1840)
    ToClient_qaLearnSkill(1841)
    ToClient_qaLearnSkill(1842)
    ToClient_qaLearnSkill(1843)
    ToClient_qaLearnSkill(1844)
    ToClient_qaLearnSkill(1845)
    ToClient_qaLearnSkill(1846)
    ToClient_qaLearnSkill(1847)
    ToClient_qaLearnSkill(1848)
    ToClient_qaLearnSkill(1849)
    ToClient_qaLearnSkill(1850)
    ToClient_qaLearnSkill(1851)
    ToClient_qaLearnSkill(1852)
    ToClient_qaLearnSkill(1853)
    ToClient_qaLearnSkill(1854)
    ToClient_qaLearnSkill(2739)
    ToClient_qaLearnSkill(2740)
  elseif isClassType == __eClassType_Tamer then
    ToClient_qaLearnSkill(11)
    ToClient_qaLearnSkill(12)
    ToClient_qaLearnSkill(13)
    ToClient_qaLearnSkill(14)
    ToClient_qaLearnSkill(15)
    ToClient_qaLearnSkill(16)
    ToClient_qaLearnSkill(17)
    ToClient_qaLearnSkill(18)
    ToClient_qaLearnSkill(19)
    ToClient_qaLearnSkill(20)
    ToClient_qaLearnSkill(31)
    ToClient_qaLearnSkill(32)
    ToClient_qaLearnSkill(33)
    ToClient_qaLearnSkill(34)
    ToClient_qaLearnSkill(35)
    ToClient_qaLearnSkill(36)
    ToClient_qaLearnSkill(37)
    ToClient_qaLearnSkill(38)
    ToClient_qaLearnSkill(39)
    ToClient_qaLearnSkill(40)
    ToClient_qaLearnSkill(41)
    ToClient_qaLearnSkill(42)
    ToClient_qaLearnSkill(43)
    ToClient_qaLearnSkill(84)
    ToClient_qaLearnSkill(85)
    ToClient_qaLearnSkill(86)
    ToClient_qaLearnSkill(87)
    ToClient_qaLearnSkill(122)
    ToClient_qaLearnSkill(123)
    ToClient_qaLearnSkill(124)
    ToClient_qaLearnSkill(125)
    ToClient_qaLearnSkill(126)
    ToClient_qaLearnSkill(127)
    ToClient_qaLearnSkill(128)
    ToClient_qaLearnSkill(129)
    ToClient_qaLearnSkill(130)
    ToClient_qaLearnSkill(131)
    ToClient_qaLearnSkill(132)
    ToClient_qaLearnSkill(133)
    ToClient_qaLearnSkill(134)
    ToClient_qaLearnSkill(135)
    ToClient_qaLearnSkill(204)
    ToClient_qaLearnSkill(205)
    ToClient_qaLearnSkill(208)
    ToClient_qaLearnSkill(209)
    ToClient_qaLearnSkill(210)
    ToClient_qaLearnSkill(211)
    ToClient_qaLearnSkill(212)
    ToClient_qaLearnSkill(223)
    ToClient_qaLearnSkill(224)
    ToClient_qaLearnSkill(225)
    ToClient_qaLearnSkill(226)
    ToClient_qaLearnSkill(227)
    ToClient_qaLearnSkill(228)
    ToClient_qaLearnSkill(229)
    ToClient_qaLearnSkill(230)
    ToClient_qaLearnSkill(231)
    ToClient_qaLearnSkill(232)
    ToClient_qaLearnSkill(233)
    ToClient_qaLearnSkill(234)
    ToClient_qaLearnSkill(235)
    ToClient_qaLearnSkill(236)
    ToClient_qaLearnSkill(237)
    ToClient_qaLearnSkill(238)
    ToClient_qaLearnSkill(239)
    ToClient_qaLearnSkill(240)
    ToClient_qaLearnSkill(241)
    ToClient_qaLearnSkill(242)
    ToClient_qaLearnSkill(244)
    ToClient_qaLearnSkill(358)
    ToClient_qaLearnSkill(359)
    ToClient_qaLearnSkill(360)
    ToClient_qaLearnSkill(361)
    ToClient_qaLearnSkill(362)
    ToClient_qaLearnSkill(363)
    ToClient_qaLearnSkill(364)
    ToClient_qaLearnSkill(365)
    ToClient_qaLearnSkill(366)
    ToClient_qaLearnSkill(367)
    ToClient_qaLearnSkill(1062)
    ToClient_qaLearnSkill(1063)
    ToClient_qaLearnSkill(1064)
    ToClient_qaLearnSkill(1065)
    ToClient_qaLearnSkill(1066)
    ToClient_qaLearnSkill(1067)
    ToClient_qaLearnSkill(1068)
    ToClient_qaLearnSkill(1069)
    ToClient_qaLearnSkill(1070)
    ToClient_qaLearnSkill(1071)
    ToClient_qaLearnSkill(1072)
    ToClient_qaLearnSkill(1073)
    ToClient_qaLearnSkill(1074)
    ToClient_qaLearnSkill(1075)
    ToClient_qaLearnSkill(1076)
    ToClient_qaLearnSkill(1215)
    ToClient_qaLearnSkill(1216)
    ToClient_qaLearnSkill(1217)
    ToClient_qaLearnSkill(1218)
    ToClient_qaLearnSkill(1219)
    ToClient_qaLearnSkill(1220)
    ToClient_qaLearnSkill(1221)
    ToClient_qaLearnSkill(1222)
    ToClient_qaLearnSkill(1223)
    ToClient_qaLearnSkill(1224)
    ToClient_qaLearnSkill(1225)
    ToClient_qaLearnSkill(1226)
    ToClient_qaLearnSkill(1227)
    ToClient_qaLearnSkill(1228)
    ToClient_qaLearnSkill(1229)
    ToClient_qaLearnSkill(1230)
    ToClient_qaLearnSkill(1231)
    ToClient_qaLearnSkill(1232)
    ToClient_qaLearnSkill(1233)
    ToClient_qaLearnSkill(1234)
    ToClient_qaLearnSkill(1235)
    ToClient_qaLearnSkill(1236)
    ToClient_qaLearnSkill(1237)
    ToClient_qaLearnSkill(1238)
    ToClient_qaLearnSkill(1239)
    ToClient_qaLearnSkill(1240)
    ToClient_qaLearnSkill(1241)
    ToClient_qaLearnSkill(1242)
    ToClient_qaLearnSkill(1243)
    ToClient_qaLearnSkill(1244)
    ToClient_qaLearnSkill(1245)
    ToClient_qaLearnSkill(1246)
    ToClient_qaLearnSkill(1247)
    ToClient_qaLearnSkill(1248)
    ToClient_qaLearnSkill(1249)
    ToClient_qaLearnSkill(1295)
    ToClient_qaLearnSkill(1301)
    ToClient_qaLearnSkill(1302)
    ToClient_qaLearnSkill(1303)
    ToClient_qaLearnSkill(1304)
    ToClient_qaLearnSkill(1305)
    ToClient_qaLearnSkill(1306)
    ToClient_qaLearnSkill(1307)
    ToClient_qaLearnSkill(1308)
    ToClient_qaLearnSkill(1309)
    ToClient_qaLearnSkill(1310)
    ToClient_qaLearnSkill(1311)
    ToClient_qaLearnSkill(1338)
    ToClient_qaLearnSkill(1339)
    ToClient_qaLearnSkill(1340)
    ToClient_qaLearnSkill(1341)
    ToClient_qaLearnSkill(1342)
    ToClient_qaLearnSkill(1343)
    ToClient_qaLearnSkill(1344)
    ToClient_qaLearnSkill(1345)
    ToClient_qaLearnSkill(1346)
    ToClient_qaLearnSkill(1347)
    ToClient_qaLearnSkill(1702)
    ToClient_qaLearnSkill(1703)
    ToClient_qaLearnSkill(1704)
    ToClient_qaLearnSkill(1705)
    ToClient_qaLearnSkill(1706)
    ToClient_qaLearnSkill(1707)
    ToClient_qaLearnSkill(2072)
    ToClient_qaLearnSkill(2073)
    ToClient_qaLearnSkill(2074)
    ToClient_qaLearnSkill(2075)
    ToClient_qaLearnSkill(2076)
    ToClient_qaLearnSkill(1898)
    ToClient_qaLearnSkill(1899)
    ToClient_qaLearnSkill(1900)
    ToClient_qaLearnSkill(1901)
    ToClient_qaLearnSkill(1902)
    ToClient_qaLearnSkill(1903)
    ToClient_qaLearnSkill(1904)
    ToClient_qaLearnSkill(1905)
    ToClient_qaLearnSkill(1906)
    ToClient_qaLearnSkill(1907)
    ToClient_qaLearnSkill(1908)
    ToClient_qaLearnSkill(1909)
    ToClient_qaLearnSkill(1910)
    ToClient_qaLearnSkill(1911)
    ToClient_qaLearnSkill(1912)
    ToClient_qaLearnSkill(1913)
    ToClient_qaLearnSkill(1914)
    ToClient_qaLearnSkill(1915)
    ToClient_qaLearnSkill(1916)
    ToClient_qaLearnSkill(1917)
    ToClient_qaLearnSkill(1918)
    ToClient_qaLearnSkill(1919)
    ToClient_qaLearnSkill(1920)
    ToClient_qaLearnSkill(1921)
    ToClient_qaLearnSkill(1927)
    ToClient_qaLearnSkill(1923)
    ToClient_qaLearnSkill(1924)
    ToClient_qaLearnSkill(1925)
    ToClient_qaLearnSkill(1926)
    ToClient_qaLearnSkill(1922)
    ToClient_qaLearnSkill(1928)
    ToClient_qaLearnSkill(1929)
    ToClient_qaLearnSkill(1930)
    ToClient_qaLearnSkill(1931)
    ToClient_qaLearnSkill(1932)
    ToClient_qaLearnSkill(1933)
    ToClient_qaLearnSkill(1934)
    ToClient_qaLearnSkill(1935)
    ToClient_qaLearnSkill(1936)
    ToClient_qaLearnSkill(1937)
    ToClient_qaLearnSkill(1938)
    ToClient_qaLearnSkill(1939)
    ToClient_qaLearnSkill(1940)
    ToClient_qaLearnSkill(1941)
    ToClient_qaLearnSkill(1942)
    ToClient_qaLearnSkill(2555)
    ToClient_qaLearnSkill(2741)
    ToClient_qaLearnSkill(2742)
  elseif isClassType == __eClassType_WizardWoman then
    ToClient_qaLearnSkill(786)
    ToClient_qaLearnSkill(787)
    ToClient_qaLearnSkill(788)
    ToClient_qaLearnSkill(789)
    ToClient_qaLearnSkill(790)
    ToClient_qaLearnSkill(791)
    ToClient_qaLearnSkill(792)
    ToClient_qaLearnSkill(793)
    ToClient_qaLearnSkill(794)
    ToClient_qaLearnSkill(795)
    ToClient_qaLearnSkill(796)
    ToClient_qaLearnSkill(797)
    ToClient_qaLearnSkill(798)
    ToClient_qaLearnSkill(799)
    ToClient_qaLearnSkill(800)
    ToClient_qaLearnSkill(801)
    ToClient_qaLearnSkill(802)
    ToClient_qaLearnSkill(803)
    ToClient_qaLearnSkill(804)
    ToClient_qaLearnSkill(805)
    ToClient_qaLearnSkill(806)
    ToClient_qaLearnSkill(807)
    ToClient_qaLearnSkill(808)
    ToClient_qaLearnSkill(809)
    ToClient_qaLearnSkill(810)
    ToClient_qaLearnSkill(811)
    ToClient_qaLearnSkill(812)
    ToClient_qaLearnSkill(813)
    ToClient_qaLearnSkill(814)
    ToClient_qaLearnSkill(815)
    ToClient_qaLearnSkill(816)
    ToClient_qaLearnSkill(817)
    ToClient_qaLearnSkill(818)
    ToClient_qaLearnSkill(819)
    ToClient_qaLearnSkill(820)
    ToClient_qaLearnSkill(821)
    ToClient_qaLearnSkill(822)
    ToClient_qaLearnSkill(823)
    ToClient_qaLearnSkill(824)
    ToClient_qaLearnSkill(825)
    ToClient_qaLearnSkill(826)
    ToClient_qaLearnSkill(827)
    ToClient_qaLearnSkill(828)
    ToClient_qaLearnSkill(829)
    ToClient_qaLearnSkill(830)
    ToClient_qaLearnSkill(831)
    ToClient_qaLearnSkill(832)
    ToClient_qaLearnSkill(833)
    ToClient_qaLearnSkill(834)
    ToClient_qaLearnSkill(835)
    ToClient_qaLearnSkill(836)
    ToClient_qaLearnSkill(837)
    ToClient_qaLearnSkill(838)
    ToClient_qaLearnSkill(839)
    ToClient_qaLearnSkill(840)
    ToClient_qaLearnSkill(841)
    ToClient_qaLearnSkill(842)
    ToClient_qaLearnSkill(843)
    ToClient_qaLearnSkill(844)
    ToClient_qaLearnSkill(845)
    ToClient_qaLearnSkill(846)
    ToClient_qaLearnSkill(847)
    ToClient_qaLearnSkill(848)
    ToClient_qaLearnSkill(849)
    ToClient_qaLearnSkill(850)
    ToClient_qaLearnSkill(851)
    ToClient_qaLearnSkill(852)
    ToClient_qaLearnSkill(853)
    ToClient_qaLearnSkill(854)
    ToClient_qaLearnSkill(855)
    ToClient_qaLearnSkill(856)
    ToClient_qaLearnSkill(857)
    ToClient_qaLearnSkill(858)
    ToClient_qaLearnSkill(859)
    ToClient_qaLearnSkill(860)
    ToClient_qaLearnSkill(861)
    ToClient_qaLearnSkill(862)
    ToClient_qaLearnSkill(863)
    ToClient_qaLearnSkill(864)
    ToClient_qaLearnSkill(865)
    ToClient_qaLearnSkill(866)
    ToClient_qaLearnSkill(867)
    ToClient_qaLearnSkill(868)
    ToClient_qaLearnSkill(869)
    ToClient_qaLearnSkill(870)
    ToClient_qaLearnSkill(871)
    ToClient_qaLearnSkill(872)
    ToClient_qaLearnSkill(873)
    ToClient_qaLearnSkill(874)
    ToClient_qaLearnSkill(875)
    ToClient_qaLearnSkill(876)
    ToClient_qaLearnSkill(877)
    ToClient_qaLearnSkill(878)
    ToClient_qaLearnSkill(879)
    ToClient_qaLearnSkill(880)
    ToClient_qaLearnSkill(881)
    ToClient_qaLearnSkill(882)
    ToClient_qaLearnSkill(883)
    ToClient_qaLearnSkill(884)
    ToClient_qaLearnSkill(885)
    ToClient_qaLearnSkill(886)
    ToClient_qaLearnSkill(887)
    ToClient_qaLearnSkill(888)
    ToClient_qaLearnSkill(889)
    ToClient_qaLearnSkill(890)
    ToClient_qaLearnSkill(891)
    ToClient_qaLearnSkill(892)
    ToClient_qaLearnSkill(893)
    ToClient_qaLearnSkill(894)
    ToClient_qaLearnSkill(895)
    ToClient_qaLearnSkill(896)
    ToClient_qaLearnSkill(897)
    ToClient_qaLearnSkill(898)
    ToClient_qaLearnSkill(899)
    ToClient_qaLearnSkill(900)
    ToClient_qaLearnSkill(901)
    ToClient_qaLearnSkill(902)
    ToClient_qaLearnSkill(903)
    ToClient_qaLearnSkill(904)
    ToClient_qaLearnSkill(905)
    ToClient_qaLearnSkill(906)
    ToClient_qaLearnSkill(907)
    ToClient_qaLearnSkill(908)
    ToClient_qaLearnSkill(909)
    ToClient_qaLearnSkill(910)
    ToClient_qaLearnSkill(911)
    ToClient_qaLearnSkill(912)
    ToClient_qaLearnSkill(913)
    ToClient_qaLearnSkill(914)
    ToClient_qaLearnSkill(1120)
    ToClient_qaLearnSkill(1121)
    ToClient_qaLearnSkill(1122)
    ToClient_qaLearnSkill(1620)
    ToClient_qaLearnSkill(1621)
    ToClient_qaLearnSkill(1622)
    ToClient_qaLearnSkill(2208)
    ToClient_qaLearnSkill(1702)
    ToClient_qaLearnSkill(1703)
    ToClient_qaLearnSkill(1704)
    ToClient_qaLearnSkill(1705)
    ToClient_qaLearnSkill(1706)
    ToClient_qaLearnSkill(1707)
    ToClient_qaLearnSkill(2072)
    ToClient_qaLearnSkill(2073)
    ToClient_qaLearnSkill(2074)
    ToClient_qaLearnSkill(2075)
    ToClient_qaLearnSkill(2076)
    ToClient_qaLearnSkill(2163)
    ToClient_qaLearnSkill(2164)
    ToClient_qaLearnSkill(2165)
    ToClient_qaLearnSkill(2166)
    ToClient_qaLearnSkill(2167)
    ToClient_qaLearnSkill(2168)
    ToClient_qaLearnSkill(2169)
    ToClient_qaLearnSkill(2170)
    ToClient_qaLearnSkill(2171)
    ToClient_qaLearnSkill(2172)
    ToClient_qaLearnSkill(2173)
    ToClient_qaLearnSkill(2174)
    ToClient_qaLearnSkill(2175)
    ToClient_qaLearnSkill(2176)
    ToClient_qaLearnSkill(2177)
    ToClient_qaLearnSkill(2178)
    ToClient_qaLearnSkill(2179)
    ToClient_qaLearnSkill(2180)
    ToClient_qaLearnSkill(2181)
    ToClient_qaLearnSkill(2182)
    ToClient_qaLearnSkill(2183)
    ToClient_qaLearnSkill(2184)
    ToClient_qaLearnSkill(2185)
    ToClient_qaLearnSkill(2186)
    ToClient_qaLearnSkill(2187)
    ToClient_qaLearnSkill(2188)
    ToClient_qaLearnSkill(2189)
    ToClient_qaLearnSkill(2190)
    ToClient_qaLearnSkill(2191)
    ToClient_qaLearnSkill(2192)
    ToClient_qaLearnSkill(2193)
    ToClient_qaLearnSkill(2194)
    ToClient_qaLearnSkill(2195)
    ToClient_qaLearnSkill(2196)
    ToClient_qaLearnSkill(2197)
    ToClient_qaLearnSkill(2198)
    ToClient_qaLearnSkill(2199)
    ToClient_qaLearnSkill(2200)
    ToClient_qaLearnSkill(2201)
    ToClient_qaLearnSkill(2202)
    ToClient_qaLearnSkill(2203)
    ToClient_qaLearnSkill(2204)
    ToClient_qaLearnSkill(2205)
    ToClient_qaLearnSkill(2206)
    ToClient_qaLearnSkill(2207)
    ToClient_qaLearnSkill(2751)
    ToClient_qaLearnSkill(2752)
  elseif isClassType == __eClassType_WizardMan then
    ToClient_qaLearnSkill(786)
    ToClient_qaLearnSkill(787)
    ToClient_qaLearnSkill(788)
    ToClient_qaLearnSkill(789)
    ToClient_qaLearnSkill(790)
    ToClient_qaLearnSkill(791)
    ToClient_qaLearnSkill(792)
    ToClient_qaLearnSkill(793)
    ToClient_qaLearnSkill(794)
    ToClient_qaLearnSkill(795)
    ToClient_qaLearnSkill(796)
    ToClient_qaLearnSkill(797)
    ToClient_qaLearnSkill(798)
    ToClient_qaLearnSkill(799)
    ToClient_qaLearnSkill(800)
    ToClient_qaLearnSkill(801)
    ToClient_qaLearnSkill(802)
    ToClient_qaLearnSkill(803)
    ToClient_qaLearnSkill(804)
    ToClient_qaLearnSkill(805)
    ToClient_qaLearnSkill(806)
    ToClient_qaLearnSkill(807)
    ToClient_qaLearnSkill(808)
    ToClient_qaLearnSkill(809)
    ToClient_qaLearnSkill(810)
    ToClient_qaLearnSkill(811)
    ToClient_qaLearnSkill(812)
    ToClient_qaLearnSkill(813)
    ToClient_qaLearnSkill(814)
    ToClient_qaLearnSkill(815)
    ToClient_qaLearnSkill(816)
    ToClient_qaLearnSkill(817)
    ToClient_qaLearnSkill(818)
    ToClient_qaLearnSkill(819)
    ToClient_qaLearnSkill(820)
    ToClient_qaLearnSkill(821)
    ToClient_qaLearnSkill(822)
    ToClient_qaLearnSkill(823)
    ToClient_qaLearnSkill(824)
    ToClient_qaLearnSkill(825)
    ToClient_qaLearnSkill(826)
    ToClient_qaLearnSkill(827)
    ToClient_qaLearnSkill(828)
    ToClient_qaLearnSkill(829)
    ToClient_qaLearnSkill(830)
    ToClient_qaLearnSkill(831)
    ToClient_qaLearnSkill(832)
    ToClient_qaLearnSkill(833)
    ToClient_qaLearnSkill(834)
    ToClient_qaLearnSkill(835)
    ToClient_qaLearnSkill(836)
    ToClient_qaLearnSkill(837)
    ToClient_qaLearnSkill(838)
    ToClient_qaLearnSkill(839)
    ToClient_qaLearnSkill(840)
    ToClient_qaLearnSkill(841)
    ToClient_qaLearnSkill(842)
    ToClient_qaLearnSkill(843)
    ToClient_qaLearnSkill(844)
    ToClient_qaLearnSkill(845)
    ToClient_qaLearnSkill(846)
    ToClient_qaLearnSkill(847)
    ToClient_qaLearnSkill(848)
    ToClient_qaLearnSkill(849)
    ToClient_qaLearnSkill(850)
    ToClient_qaLearnSkill(851)
    ToClient_qaLearnSkill(852)
    ToClient_qaLearnSkill(853)
    ToClient_qaLearnSkill(854)
    ToClient_qaLearnSkill(855)
    ToClient_qaLearnSkill(856)
    ToClient_qaLearnSkill(857)
    ToClient_qaLearnSkill(858)
    ToClient_qaLearnSkill(859)
    ToClient_qaLearnSkill(860)
    ToClient_qaLearnSkill(861)
    ToClient_qaLearnSkill(862)
    ToClient_qaLearnSkill(863)
    ToClient_qaLearnSkill(864)
    ToClient_qaLearnSkill(865)
    ToClient_qaLearnSkill(866)
    ToClient_qaLearnSkill(867)
    ToClient_qaLearnSkill(868)
    ToClient_qaLearnSkill(869)
    ToClient_qaLearnSkill(870)
    ToClient_qaLearnSkill(871)
    ToClient_qaLearnSkill(872)
    ToClient_qaLearnSkill(873)
    ToClient_qaLearnSkill(874)
    ToClient_qaLearnSkill(875)
    ToClient_qaLearnSkill(876)
    ToClient_qaLearnSkill(877)
    ToClient_qaLearnSkill(878)
    ToClient_qaLearnSkill(879)
    ToClient_qaLearnSkill(880)
    ToClient_qaLearnSkill(881)
    ToClient_qaLearnSkill(882)
    ToClient_qaLearnSkill(883)
    ToClient_qaLearnSkill(884)
    ToClient_qaLearnSkill(885)
    ToClient_qaLearnSkill(886)
    ToClient_qaLearnSkill(887)
    ToClient_qaLearnSkill(888)
    ToClient_qaLearnSkill(889)
    ToClient_qaLearnSkill(890)
    ToClient_qaLearnSkill(891)
    ToClient_qaLearnSkill(892)
    ToClient_qaLearnSkill(893)
    ToClient_qaLearnSkill(894)
    ToClient_qaLearnSkill(895)
    ToClient_qaLearnSkill(896)
    ToClient_qaLearnSkill(897)
    ToClient_qaLearnSkill(898)
    ToClient_qaLearnSkill(899)
    ToClient_qaLearnSkill(900)
    ToClient_qaLearnSkill(901)
    ToClient_qaLearnSkill(902)
    ToClient_qaLearnSkill(903)
    ToClient_qaLearnSkill(904)
    ToClient_qaLearnSkill(905)
    ToClient_qaLearnSkill(906)
    ToClient_qaLearnSkill(907)
    ToClient_qaLearnSkill(908)
    ToClient_qaLearnSkill(909)
    ToClient_qaLearnSkill(910)
    ToClient_qaLearnSkill(911)
    ToClient_qaLearnSkill(912)
    ToClient_qaLearnSkill(913)
    ToClient_qaLearnSkill(914)
    ToClient_qaLearnSkill(1120)
    ToClient_qaLearnSkill(1121)
    ToClient_qaLearnSkill(1122)
    ToClient_qaLearnSkill(1620)
    ToClient_qaLearnSkill(1621)
    ToClient_qaLearnSkill(1622)
    ToClient_qaLearnSkill(2208)
    ToClient_qaLearnSkill(1702)
    ToClient_qaLearnSkill(1703)
    ToClient_qaLearnSkill(1704)
    ToClient_qaLearnSkill(1705)
    ToClient_qaLearnSkill(1706)
    ToClient_qaLearnSkill(1707)
    ToClient_qaLearnSkill(2072)
    ToClient_qaLearnSkill(2073)
    ToClient_qaLearnSkill(2074)
    ToClient_qaLearnSkill(2075)
    ToClient_qaLearnSkill(2076)
    ToClient_qaLearnSkill(2208)
    ToClient_qaLearnSkill(2209)
    ToClient_qaLearnSkill(2210)
    ToClient_qaLearnSkill(2211)
    ToClient_qaLearnSkill(2212)
    ToClient_qaLearnSkill(2213)
    ToClient_qaLearnSkill(2214)
    ToClient_qaLearnSkill(2215)
    ToClient_qaLearnSkill(2216)
    ToClient_qaLearnSkill(2217)
    ToClient_qaLearnSkill(2218)
    ToClient_qaLearnSkill(2219)
    ToClient_qaLearnSkill(2220)
    ToClient_qaLearnSkill(2221)
    ToClient_qaLearnSkill(2222)
    ToClient_qaLearnSkill(2223)
    ToClient_qaLearnSkill(2224)
    ToClient_qaLearnSkill(2225)
    ToClient_qaLearnSkill(2226)
    ToClient_qaLearnSkill(2227)
    ToClient_qaLearnSkill(2228)
    ToClient_qaLearnSkill(2229)
    ToClient_qaLearnSkill(2230)
    ToClient_qaLearnSkill(2231)
    ToClient_qaLearnSkill(2232)
    ToClient_qaLearnSkill(2233)
    ToClient_qaLearnSkill(2234)
    ToClient_qaLearnSkill(2235)
    ToClient_qaLearnSkill(2236)
    ToClient_qaLearnSkill(2237)
    ToClient_qaLearnSkill(2238)
    ToClient_qaLearnSkill(2239)
    ToClient_qaLearnSkill(2240)
    ToClient_qaLearnSkill(2241)
    ToClient_qaLearnSkill(2242)
    ToClient_qaLearnSkill(2243)
    ToClient_qaLearnSkill(2244)
    ToClient_qaLearnSkill(2245)
    ToClient_qaLearnSkill(2246)
    ToClient_qaLearnSkill(2247)
    ToClient_qaLearnSkill(2248)
    ToClient_qaLearnSkill(2249)
    ToClient_qaLearnSkill(2250)
    ToClient_qaLearnSkill(2251)
    ToClient_qaLearnSkill(2252)
    ToClient_qaLearnSkill(2253)
    ToClient_qaLearnSkill(2749)
    ToClient_qaLearnSkill(2750)
  elseif isClassType == __eClassType_BladeMaster then
    ToClient_qaLearnSkill(1)
    ToClient_qaLearnSkill(2)
    ToClient_qaLearnSkill(3)
    ToClient_qaLearnSkill(4)
    ToClient_qaLearnSkill(5)
    ToClient_qaLearnSkill(6)
    ToClient_qaLearnSkill(7)
    ToClient_qaLearnSkill(8)
    ToClient_qaLearnSkill(9)
    ToClient_qaLearnSkill(10)
    ToClient_qaLearnSkill(21)
    ToClient_qaLearnSkill(22)
    ToClient_qaLearnSkill(23)
    ToClient_qaLearnSkill(24)
    ToClient_qaLearnSkill(25)
    ToClient_qaLearnSkill(26)
    ToClient_qaLearnSkill(27)
    ToClient_qaLearnSkill(28)
    ToClient_qaLearnSkill(29)
    ToClient_qaLearnSkill(30)
    ToClient_qaLearnSkill(159)
    ToClient_qaLearnSkill(201)
    ToClient_qaLearnSkill(202)
    ToClient_qaLearnSkill(392)
    ToClient_qaLearnSkill(393)
    ToClient_qaLearnSkill(394)
    ToClient_qaLearnSkill(395)
    ToClient_qaLearnSkill(396)
    ToClient_qaLearnSkill(397)
    ToClient_qaLearnSkill(398)
    ToClient_qaLearnSkill(399)
    ToClient_qaLearnSkill(400)
    ToClient_qaLearnSkill(401)
    ToClient_qaLearnSkill(402)
    ToClient_qaLearnSkill(403)
    ToClient_qaLearnSkill(404)
    ToClient_qaLearnSkill(405)
    ToClient_qaLearnSkill(406)
    ToClient_qaLearnSkill(407)
    ToClient_qaLearnSkill(408)
    ToClient_qaLearnSkill(409)
    ToClient_qaLearnSkill(410)
    ToClient_qaLearnSkill(411)
    ToClient_qaLearnSkill(412)
    ToClient_qaLearnSkill(413)
    ToClient_qaLearnSkill(414)
    ToClient_qaLearnSkill(415)
    ToClient_qaLearnSkill(416)
    ToClient_qaLearnSkill(418)
    ToClient_qaLearnSkill(419)
    ToClient_qaLearnSkill(420)
    ToClient_qaLearnSkill(421)
    ToClient_qaLearnSkill(422)
    ToClient_qaLearnSkill(423)
    ToClient_qaLearnSkill(424)
    ToClient_qaLearnSkill(425)
    ToClient_qaLearnSkill(1258)
    ToClient_qaLearnSkill(1259)
    ToClient_qaLearnSkill(1260)
    ToClient_qaLearnSkill(1261)
    ToClient_qaLearnSkill(1262)
    ToClient_qaLearnSkill(1263)
    ToClient_qaLearnSkill(1264)
    ToClient_qaLearnSkill(1265)
    ToClient_qaLearnSkill(1266)
    ToClient_qaLearnSkill(1267)
    ToClient_qaLearnSkill(1268)
    ToClient_qaLearnSkill(1269)
    ToClient_qaLearnSkill(1270)
    ToClient_qaLearnSkill(1271)
    ToClient_qaLearnSkill(1272)
    ToClient_qaLearnSkill(1273)
    ToClient_qaLearnSkill(1274)
    ToClient_qaLearnSkill(1275)
    ToClient_qaLearnSkill(1276)
    ToClient_qaLearnSkill(1277)
    ToClient_qaLearnSkill(1278)
    ToClient_qaLearnSkill(1279)
    ToClient_qaLearnSkill(1280)
    ToClient_qaLearnSkill(1281)
    ToClient_qaLearnSkill(1282)
    ToClient_qaLearnSkill(1283)
    ToClient_qaLearnSkill(1284)
    ToClient_qaLearnSkill(1285)
    ToClient_qaLearnSkill(1286)
    ToClient_qaLearnSkill(1287)
    ToClient_qaLearnSkill(1288)
    ToClient_qaLearnSkill(1289)
    ToClient_qaLearnSkill(1296)
    ToClient_qaLearnSkill(1297)
    ToClient_qaLearnSkill(1298)
    ToClient_qaLearnSkill(1299)
    ToClient_qaLearnSkill(1300)
    ToClient_qaLearnSkill(1314)
    ToClient_qaLearnSkill(1317)
    ToClient_qaLearnSkill(1318)
    ToClient_qaLearnSkill(1319)
    ToClient_qaLearnSkill(1320)
    ToClient_qaLearnSkill(1321)
    ToClient_qaLearnSkill(1322)
    ToClient_qaLearnSkill(1323)
    ToClient_qaLearnSkill(1324)
    ToClient_qaLearnSkill(1325)
    ToClient_qaLearnSkill(1326)
    ToClient_qaLearnSkill(1327)
    ToClient_qaLearnSkill(1437)
    ToClient_qaLearnSkill(1445)
    ToClient_qaLearnSkill(1446)
    ToClient_qaLearnSkill(1447)
    ToClient_qaLearnSkill(1450)
    ToClient_qaLearnSkill(1451)
    ToClient_qaLearnSkill(1453)
    ToClient_qaLearnSkill(1454)
    ToClient_qaLearnSkill(1455)
    ToClient_qaLearnSkill(1456)
    ToClient_qaLearnSkill(1457)
    ToClient_qaLearnSkill(1459)
    ToClient_qaLearnSkill(1460)
    ToClient_qaLearnSkill(1461)
    ToClient_qaLearnSkill(1462)
    ToClient_qaLearnSkill(1463)
    ToClient_qaLearnSkill(1464)
    ToClient_qaLearnSkill(1465)
    ToClient_qaLearnSkill(1702)
    ToClient_qaLearnSkill(1703)
    ToClient_qaLearnSkill(1704)
    ToClient_qaLearnSkill(1705)
    ToClient_qaLearnSkill(1706)
    ToClient_qaLearnSkill(1707)
    ToClient_qaLearnSkill(2072)
    ToClient_qaLearnSkill(2073)
    ToClient_qaLearnSkill(2074)
    ToClient_qaLearnSkill(2075)
    ToClient_qaLearnSkill(2076)
    ToClient_qaLearnSkill(1986)
    ToClient_qaLearnSkill(1987)
    ToClient_qaLearnSkill(1988)
    ToClient_qaLearnSkill(1989)
    ToClient_qaLearnSkill(1990)
    ToClient_qaLearnSkill(1991)
    ToClient_qaLearnSkill(1992)
    ToClient_qaLearnSkill(1993)
    ToClient_qaLearnSkill(1994)
    ToClient_qaLearnSkill(1995)
    ToClient_qaLearnSkill(1996)
    ToClient_qaLearnSkill(1997)
    ToClient_qaLearnSkill(1998)
    ToClient_qaLearnSkill(1999)
    ToClient_qaLearnSkill(2000)
    ToClient_qaLearnSkill(2001)
    ToClient_qaLearnSkill(2002)
    ToClient_qaLearnSkill(2003)
    ToClient_qaLearnSkill(2004)
    ToClient_qaLearnSkill(2005)
    ToClient_qaLearnSkill(2006)
    ToClient_qaLearnSkill(2007)
    ToClient_qaLearnSkill(2008)
    ToClient_qaLearnSkill(2009)
    ToClient_qaLearnSkill(2010)
    ToClient_qaLearnSkill(2011)
    ToClient_qaLearnSkill(2012)
    ToClient_qaLearnSkill(2013)
    ToClient_qaLearnSkill(2014)
    ToClient_qaLearnSkill(2015)
    ToClient_qaLearnSkill(2016)
    ToClient_qaLearnSkill(2017)
    ToClient_qaLearnSkill(2018)
    ToClient_qaLearnSkill(2019)
    ToClient_qaLearnSkill(2020)
    ToClient_qaLearnSkill(2021)
    ToClient_qaLearnSkill(2022)
    ToClient_qaLearnSkill(2023)
    ToClient_qaLearnSkill(2024)
    ToClient_qaLearnSkill(2025)
    ToClient_qaLearnSkill(2026)
    ToClient_qaLearnSkill(2027)
    ToClient_qaLearnSkill(2028)
    ToClient_qaLearnSkill(2743)
    ToClient_qaLearnSkill(2744)
  elseif isClassType == __eClassType_BladeMasterWoman then
    ToClient_qaLearnSkill(1501)
    ToClient_qaLearnSkill(1502)
    ToClient_qaLearnSkill(1503)
    ToClient_qaLearnSkill(1504)
    ToClient_qaLearnSkill(1505)
    ToClient_qaLearnSkill(1506)
    ToClient_qaLearnSkill(1507)
    ToClient_qaLearnSkill(1508)
    ToClient_qaLearnSkill(1509)
    ToClient_qaLearnSkill(1510)
    ToClient_qaLearnSkill(1511)
    ToClient_qaLearnSkill(1512)
    ToClient_qaLearnSkill(1513)
    ToClient_qaLearnSkill(1514)
    ToClient_qaLearnSkill(1515)
    ToClient_qaLearnSkill(1516)
    ToClient_qaLearnSkill(1517)
    ToClient_qaLearnSkill(1518)
    ToClient_qaLearnSkill(1519)
    ToClient_qaLearnSkill(1520)
    ToClient_qaLearnSkill(1521)
    ToClient_qaLearnSkill(1522)
    ToClient_qaLearnSkill(1523)
    ToClient_qaLearnSkill(1524)
    ToClient_qaLearnSkill(1525)
    ToClient_qaLearnSkill(1526)
    ToClient_qaLearnSkill(1527)
    ToClient_qaLearnSkill(1528)
    ToClient_qaLearnSkill(1529)
    ToClient_qaLearnSkill(1530)
    ToClient_qaLearnSkill(1531)
    ToClient_qaLearnSkill(1532)
    ToClient_qaLearnSkill(1533)
    ToClient_qaLearnSkill(1534)
    ToClient_qaLearnSkill(1535)
    ToClient_qaLearnSkill(1536)
    ToClient_qaLearnSkill(1537)
    ToClient_qaLearnSkill(1538)
    ToClient_qaLearnSkill(1539)
    ToClient_qaLearnSkill(1540)
    ToClient_qaLearnSkill(1541)
    ToClient_qaLearnSkill(1542)
    ToClient_qaLearnSkill(1543)
    ToClient_qaLearnSkill(1544)
    ToClient_qaLearnSkill(1545)
    ToClient_qaLearnSkill(1546)
    ToClient_qaLearnSkill(1547)
    ToClient_qaLearnSkill(1548)
    ToClient_qaLearnSkill(1549)
    ToClient_qaLearnSkill(1550)
    ToClient_qaLearnSkill(1551)
    ToClient_qaLearnSkill(1552)
    ToClient_qaLearnSkill(1553)
    ToClient_qaLearnSkill(1554)
    ToClient_qaLearnSkill(1555)
    ToClient_qaLearnSkill(1556)
    ToClient_qaLearnSkill(1557)
    ToClient_qaLearnSkill(1558)
    ToClient_qaLearnSkill(1559)
    ToClient_qaLearnSkill(1560)
    ToClient_qaLearnSkill(1561)
    ToClient_qaLearnSkill(1562)
    ToClient_qaLearnSkill(1563)
    ToClient_qaLearnSkill(1564)
    ToClient_qaLearnSkill(1565)
    ToClient_qaLearnSkill(1566)
    ToClient_qaLearnSkill(1567)
    ToClient_qaLearnSkill(1568)
    ToClient_qaLearnSkill(1569)
    ToClient_qaLearnSkill(1570)
    ToClient_qaLearnSkill(1571)
    ToClient_qaLearnSkill(1572)
    ToClient_qaLearnSkill(1573)
    ToClient_qaLearnSkill(1574)
    ToClient_qaLearnSkill(1575)
    ToClient_qaLearnSkill(1576)
    ToClient_qaLearnSkill(1577)
    ToClient_qaLearnSkill(1578)
    ToClient_qaLearnSkill(1579)
    ToClient_qaLearnSkill(1580)
    ToClient_qaLearnSkill(1581)
    ToClient_qaLearnSkill(1582)
    ToClient_qaLearnSkill(1583)
    ToClient_qaLearnSkill(1584)
    ToClient_qaLearnSkill(1585)
    ToClient_qaLearnSkill(1586)
    ToClient_qaLearnSkill(1587)
    ToClient_qaLearnSkill(1588)
    ToClient_qaLearnSkill(1589)
    ToClient_qaLearnSkill(1590)
    ToClient_qaLearnSkill(1591)
    ToClient_qaLearnSkill(1592)
    ToClient_qaLearnSkill(1593)
    ToClient_qaLearnSkill(1594)
    ToClient_qaLearnSkill(1595)
    ToClient_qaLearnSkill(1596)
    ToClient_qaLearnSkill(1597)
    ToClient_qaLearnSkill(1598)
    ToClient_qaLearnSkill(1599)
    ToClient_qaLearnSkill(1600)
    ToClient_qaLearnSkill(1601)
    ToClient_qaLearnSkill(1602)
    ToClient_qaLearnSkill(1603)
    ToClient_qaLearnSkill(1604)
    ToClient_qaLearnSkill(1605)
    ToClient_qaLearnSkill(1606)
    ToClient_qaLearnSkill(1607)
    ToClient_qaLearnSkill(1608)
    ToClient_qaLearnSkill(1609)
    ToClient_qaLearnSkill(1610)
    ToClient_qaLearnSkill(1611)
    ToClient_qaLearnSkill(1612)
    ToClient_qaLearnSkill(1613)
    ToClient_qaLearnSkill(1614)
    ToClient_qaLearnSkill(1615)
    ToClient_qaLearnSkill(1616)
    ToClient_qaLearnSkill(1617)
    ToClient_qaLearnSkill(1618)
    ToClient_qaLearnSkill(1619)
    ToClient_qaLearnSkill(1702)
    ToClient_qaLearnSkill(1703)
    ToClient_qaLearnSkill(1704)
    ToClient_qaLearnSkill(1705)
    ToClient_qaLearnSkill(1706)
    ToClient_qaLearnSkill(1707)
    ToClient_qaLearnSkill(2072)
    ToClient_qaLearnSkill(2073)
    ToClient_qaLearnSkill(2074)
    ToClient_qaLearnSkill(2075)
    ToClient_qaLearnSkill(2076)
    ToClient_qaLearnSkill(2029)
    ToClient_qaLearnSkill(2030)
    ToClient_qaLearnSkill(2031)
    ToClient_qaLearnSkill(2032)
    ToClient_qaLearnSkill(2033)
    ToClient_qaLearnSkill(2034)
    ToClient_qaLearnSkill(2035)
    ToClient_qaLearnSkill(2036)
    ToClient_qaLearnSkill(2037)
    ToClient_qaLearnSkill(2038)
    ToClient_qaLearnSkill(2039)
    ToClient_qaLearnSkill(2040)
    ToClient_qaLearnSkill(2041)
    ToClient_qaLearnSkill(2042)
    ToClient_qaLearnSkill(2043)
    ToClient_qaLearnSkill(2044)
    ToClient_qaLearnSkill(2045)
    ToClient_qaLearnSkill(2046)
    ToClient_qaLearnSkill(2047)
    ToClient_qaLearnSkill(2048)
    ToClient_qaLearnSkill(2049)
    ToClient_qaLearnSkill(2050)
    ToClient_qaLearnSkill(2051)
    ToClient_qaLearnSkill(2052)
    ToClient_qaLearnSkill(2053)
    ToClient_qaLearnSkill(2054)
    ToClient_qaLearnSkill(2055)
    ToClient_qaLearnSkill(2056)
    ToClient_qaLearnSkill(2057)
    ToClient_qaLearnSkill(2058)
    ToClient_qaLearnSkill(2059)
    ToClient_qaLearnSkill(2060)
    ToClient_qaLearnSkill(2061)
    ToClient_qaLearnSkill(2062)
    ToClient_qaLearnSkill(2063)
    ToClient_qaLearnSkill(2064)
    ToClient_qaLearnSkill(2065)
    ToClient_qaLearnSkill(2066)
    ToClient_qaLearnSkill(2067)
    ToClient_qaLearnSkill(2068)
    ToClient_qaLearnSkill(2069)
    ToClient_qaLearnSkill(2070)
    ToClient_qaLearnSkill(2071)
    ToClient_qaLearnSkill(2745)
    ToClient_qaLearnSkill(2746)
  elseif isClassType == __eClassType_Valkyrie then
    ToClient_qaLearnSkill(717)
    ToClient_qaLearnSkill(718)
    ToClient_qaLearnSkill(719)
    ToClient_qaLearnSkill(720)
    ToClient_qaLearnSkill(721)
    ToClient_qaLearnSkill(722)
    ToClient_qaLearnSkill(723)
    ToClient_qaLearnSkill(724)
    ToClient_qaLearnSkill(725)
    ToClient_qaLearnSkill(726)
    ToClient_qaLearnSkill(727)
    ToClient_qaLearnSkill(728)
    ToClient_qaLearnSkill(729)
    ToClient_qaLearnSkill(730)
    ToClient_qaLearnSkill(731)
    ToClient_qaLearnSkill(732)
    ToClient_qaLearnSkill(733)
    ToClient_qaLearnSkill(734)
    ToClient_qaLearnSkill(735)
    ToClient_qaLearnSkill(736)
    ToClient_qaLearnSkill(737)
    ToClient_qaLearnSkill(738)
    ToClient_qaLearnSkill(739)
    ToClient_qaLearnSkill(740)
    ToClient_qaLearnSkill(741)
    ToClient_qaLearnSkill(742)
    ToClient_qaLearnSkill(743)
    ToClient_qaLearnSkill(744)
    ToClient_qaLearnSkill(745)
    ToClient_qaLearnSkill(746)
    ToClient_qaLearnSkill(747)
    ToClient_qaLearnSkill(748)
    ToClient_qaLearnSkill(749)
    ToClient_qaLearnSkill(750)
    ToClient_qaLearnSkill(751)
    ToClient_qaLearnSkill(752)
    ToClient_qaLearnSkill(753)
    ToClient_qaLearnSkill(754)
    ToClient_qaLearnSkill(755)
    ToClient_qaLearnSkill(756)
    ToClient_qaLearnSkill(757)
    ToClient_qaLearnSkill(758)
    ToClient_qaLearnSkill(759)
    ToClient_qaLearnSkill(760)
    ToClient_qaLearnSkill(761)
    ToClient_qaLearnSkill(762)
    ToClient_qaLearnSkill(763)
    ToClient_qaLearnSkill(764)
    ToClient_qaLearnSkill(765)
    ToClient_qaLearnSkill(766)
    ToClient_qaLearnSkill(767)
    ToClient_qaLearnSkill(768)
    ToClient_qaLearnSkill(769)
    ToClient_qaLearnSkill(770)
    ToClient_qaLearnSkill(771)
    ToClient_qaLearnSkill(772)
    ToClient_qaLearnSkill(773)
    ToClient_qaLearnSkill(774)
    ToClient_qaLearnSkill(775)
    ToClient_qaLearnSkill(776)
    ToClient_qaLearnSkill(777)
    ToClient_qaLearnSkill(778)
    ToClient_qaLearnSkill(779)
    ToClient_qaLearnSkill(780)
    ToClient_qaLearnSkill(781)
    ToClient_qaLearnSkill(782)
    ToClient_qaLearnSkill(783)
    ToClient_qaLearnSkill(784)
    ToClient_qaLearnSkill(785)
    ToClient_qaLearnSkill(1466)
    ToClient_qaLearnSkill(1467)
    ToClient_qaLearnSkill(1468)
    ToClient_qaLearnSkill(1469)
    ToClient_qaLearnSkill(1470)
    ToClient_qaLearnSkill(1471)
    ToClient_qaLearnSkill(1472)
    ToClient_qaLearnSkill(1473)
    ToClient_qaLearnSkill(1474)
    ToClient_qaLearnSkill(1475)
    ToClient_qaLearnSkill(1476)
    ToClient_qaLearnSkill(1477)
    ToClient_qaLearnSkill(1478)
    ToClient_qaLearnSkill(1479)
    ToClient_qaLearnSkill(1480)
    ToClient_qaLearnSkill(1481)
    ToClient_qaLearnSkill(1482)
    ToClient_qaLearnSkill(1483)
    ToClient_qaLearnSkill(1484)
    ToClient_qaLearnSkill(1485)
    ToClient_qaLearnSkill(1486)
    ToClient_qaLearnSkill(1487)
    ToClient_qaLearnSkill(1488)
    ToClient_qaLearnSkill(1489)
    ToClient_qaLearnSkill(1490)
    ToClient_qaLearnSkill(1491)
    ToClient_qaLearnSkill(1492)
    ToClient_qaLearnSkill(1493)
    ToClient_qaLearnSkill(1494)
    ToClient_qaLearnSkill(1495)
    ToClient_qaLearnSkill(1496)
    ToClient_qaLearnSkill(1497)
    ToClient_qaLearnSkill(1498)
    ToClient_qaLearnSkill(1499)
    ToClient_qaLearnSkill(1702)
    ToClient_qaLearnSkill(1703)
    ToClient_qaLearnSkill(1704)
    ToClient_qaLearnSkill(1705)
    ToClient_qaLearnSkill(1706)
    ToClient_qaLearnSkill(1707)
    ToClient_qaLearnSkill(2072)
    ToClient_qaLearnSkill(2073)
    ToClient_qaLearnSkill(2074)
    ToClient_qaLearnSkill(2075)
    ToClient_qaLearnSkill(2076)
    ToClient_qaLearnSkill(1943)
    ToClient_qaLearnSkill(1944)
    ToClient_qaLearnSkill(1945)
    ToClient_qaLearnSkill(1946)
    ToClient_qaLearnSkill(1947)
    ToClient_qaLearnSkill(1948)
    ToClient_qaLearnSkill(1949)
    ToClient_qaLearnSkill(1950)
    ToClient_qaLearnSkill(1951)
    ToClient_qaLearnSkill(1952)
    ToClient_qaLearnSkill(1953)
    ToClient_qaLearnSkill(1954)
    ToClient_qaLearnSkill(1955)
    ToClient_qaLearnSkill(1956)
    ToClient_qaLearnSkill(1957)
    ToClient_qaLearnSkill(1958)
    ToClient_qaLearnSkill(1959)
    ToClient_qaLearnSkill(1960)
    ToClient_qaLearnSkill(1961)
    ToClient_qaLearnSkill(1962)
    ToClient_qaLearnSkill(1963)
    ToClient_qaLearnSkill(1964)
    ToClient_qaLearnSkill(1965)
    ToClient_qaLearnSkill(1966)
    ToClient_qaLearnSkill(1967)
    ToClient_qaLearnSkill(1968)
    ToClient_qaLearnSkill(1969)
    ToClient_qaLearnSkill(1970)
    ToClient_qaLearnSkill(1971)
    ToClient_qaLearnSkill(1972)
    ToClient_qaLearnSkill(1973)
    ToClient_qaLearnSkill(1974)
    ToClient_qaLearnSkill(1975)
    ToClient_qaLearnSkill(1976)
    ToClient_qaLearnSkill(1977)
    ToClient_qaLearnSkill(1978)
    ToClient_qaLearnSkill(1979)
    ToClient_qaLearnSkill(1980)
    ToClient_qaLearnSkill(1981)
    ToClient_qaLearnSkill(1982)
    ToClient_qaLearnSkill(1983)
    ToClient_qaLearnSkill(1984)
    ToClient_qaLearnSkill(1985)
    ToClient_qaLearnSkill(2747)
    ToClient_qaLearnSkill(2748)
  elseif isClassType == __eClassType_Kunoichi then
    ToClient_qaLearnSkill(690)
    ToClient_qaLearnSkill(691)
    ToClient_qaLearnSkill(692)
    ToClient_qaLearnSkill(693)
    ToClient_qaLearnSkill(694)
    ToClient_qaLearnSkill(695)
    ToClient_qaLearnSkill(696)
    ToClient_qaLearnSkill(697)
    ToClient_qaLearnSkill(698)
    ToClient_qaLearnSkill(699)
    ToClient_qaLearnSkill(700)
    ToClient_qaLearnSkill(701)
    ToClient_qaLearnSkill(702)
    ToClient_qaLearnSkill(703)
    ToClient_qaLearnSkill(704)
    ToClient_qaLearnSkill(915)
    ToClient_qaLearnSkill(916)
    ToClient_qaLearnSkill(917)
    ToClient_qaLearnSkill(918)
    ToClient_qaLearnSkill(919)
    ToClient_qaLearnSkill(920)
    ToClient_qaLearnSkill(921)
    ToClient_qaLearnSkill(922)
    ToClient_qaLearnSkill(923)
    ToClient_qaLearnSkill(924)
    ToClient_qaLearnSkill(925)
    ToClient_qaLearnSkill(926)
    ToClient_qaLearnSkill(927)
    ToClient_qaLearnSkill(928)
    ToClient_qaLearnSkill(929)
    ToClient_qaLearnSkill(930)
    ToClient_qaLearnSkill(931)
    ToClient_qaLearnSkill(932)
    ToClient_qaLearnSkill(933)
    ToClient_qaLearnSkill(934)
    ToClient_qaLearnSkill(935)
    ToClient_qaLearnSkill(936)
    ToClient_qaLearnSkill(937)
    ToClient_qaLearnSkill(938)
    ToClient_qaLearnSkill(939)
    ToClient_qaLearnSkill(940)
    ToClient_qaLearnSkill(941)
    ToClient_qaLearnSkill(942)
    ToClient_qaLearnSkill(943)
    ToClient_qaLearnSkill(944)
    ToClient_qaLearnSkill(945)
    ToClient_qaLearnSkill(946)
    ToClient_qaLearnSkill(947)
    ToClient_qaLearnSkill(948)
    ToClient_qaLearnSkill(949)
    ToClient_qaLearnSkill(950)
    ToClient_qaLearnSkill(951)
    ToClient_qaLearnSkill(952)
    ToClient_qaLearnSkill(953)
    ToClient_qaLearnSkill(954)
    ToClient_qaLearnSkill(955)
    ToClient_qaLearnSkill(956)
    ToClient_qaLearnSkill(957)
    ToClient_qaLearnSkill(958)
    ToClient_qaLearnSkill(959)
    ToClient_qaLearnSkill(960)
    ToClient_qaLearnSkill(961)
    ToClient_qaLearnSkill(962)
    ToClient_qaLearnSkill(963)
    ToClient_qaLearnSkill(964)
    ToClient_qaLearnSkill(965)
    ToClient_qaLearnSkill(966)
    ToClient_qaLearnSkill(967)
    ToClient_qaLearnSkill(968)
    ToClient_qaLearnSkill(969)
    ToClient_qaLearnSkill(970)
    ToClient_qaLearnSkill(971)
    ToClient_qaLearnSkill(972)
    ToClient_qaLearnSkill(973)
    ToClient_qaLearnSkill(974)
    ToClient_qaLearnSkill(975)
    ToClient_qaLearnSkill(976)
    ToClient_qaLearnSkill(977)
    ToClient_qaLearnSkill(978)
    ToClient_qaLearnSkill(979)
    ToClient_qaLearnSkill(980)
    ToClient_qaLearnSkill(981)
    ToClient_qaLearnSkill(982)
    ToClient_qaLearnSkill(983)
    ToClient_qaLearnSkill(984)
    ToClient_qaLearnSkill(985)
    ToClient_qaLearnSkill(986)
    ToClient_qaLearnSkill(987)
    ToClient_qaLearnSkill(988)
    ToClient_qaLearnSkill(989)
    ToClient_qaLearnSkill(990)
    ToClient_qaLearnSkill(991)
    ToClient_qaLearnSkill(992)
    ToClient_qaLearnSkill(998)
    ToClient_qaLearnSkill(999)
    ToClient_qaLearnSkill(1624)
    ToClient_qaLearnSkill(1625)
    ToClient_qaLearnSkill(1626)
    ToClient_qaLearnSkill(1627)
    ToClient_qaLearnSkill(1628)
    ToClient_qaLearnSkill(1629)
    ToClient_qaLearnSkill(1630)
    ToClient_qaLearnSkill(1631)
    ToClient_qaLearnSkill(1632)
    ToClient_qaLearnSkill(1633)
    ToClient_qaLearnSkill(1634)
    ToClient_qaLearnSkill(1635)
    ToClient_qaLearnSkill(1636)
    ToClient_qaLearnSkill(1637)
    ToClient_qaLearnSkill(1638)
    ToClient_qaLearnSkill(1639)
    ToClient_qaLearnSkill(1640)
    ToClient_qaLearnSkill(1641)
    ToClient_qaLearnSkill(1642)
    ToClient_qaLearnSkill(1643)
    ToClient_qaLearnSkill(1644)
    ToClient_qaLearnSkill(1645)
    ToClient_qaLearnSkill(1646)
    ToClient_qaLearnSkill(1647)
    ToClient_qaLearnSkill(1648)
    ToClient_qaLearnSkill(1649)
    ToClient_qaLearnSkill(1650)
    ToClient_qaLearnSkill(1651)
    ToClient_qaLearnSkill(1652)
    ToClient_qaLearnSkill(1653)
    ToClient_qaLearnSkill(1654)
    ToClient_qaLearnSkill(1655)
    ToClient_qaLearnSkill(1656)
    ToClient_qaLearnSkill(1657)
    ToClient_qaLearnSkill(1658)
    ToClient_qaLearnSkill(1659)
    ToClient_qaLearnSkill(1660)
    ToClient_qaLearnSkill(1661)
    ToClient_qaLearnSkill(1662)
    ToClient_qaLearnSkill(1663)
    ToClient_qaLearnSkill(1664)
    ToClient_qaLearnSkill(1665)
    ToClient_qaLearnSkill(1666)
    ToClient_qaLearnSkill(1667)
    ToClient_qaLearnSkill(1668)
    ToClient_qaLearnSkill(1669)
    ToClient_qaLearnSkill(1670)
    ToClient_qaLearnSkill(1702)
    ToClient_qaLearnSkill(1703)
    ToClient_qaLearnSkill(1704)
    ToClient_qaLearnSkill(1705)
    ToClient_qaLearnSkill(1706)
    ToClient_qaLearnSkill(1707)
    ToClient_qaLearnSkill(2072)
    ToClient_qaLearnSkill(2073)
    ToClient_qaLearnSkill(2074)
    ToClient_qaLearnSkill(2075)
    ToClient_qaLearnSkill(2076)
    ToClient_qaLearnSkill(1675)
    ToClient_qaLearnSkill(1676)
    ToClient_qaLearnSkill(1677)
    ToClient_qaLearnSkill(1678)
    ToClient_qaLearnSkill(1679)
    ToClient_qaLearnSkill(1680)
    ToClient_qaLearnSkill(1681)
    ToClient_qaLearnSkill(1682)
    ToClient_qaLearnSkill(1683)
    ToClient_qaLearnSkill(1684)
    ToClient_qaLearnSkill(1685)
    ToClient_qaLearnSkill(1686)
    ToClient_qaLearnSkill(1687)
    ToClient_qaLearnSkill(1688)
    ToClient_qaLearnSkill(1689)
    ToClient_qaLearnSkill(1690)
    ToClient_qaLearnSkill(1691)
    ToClient_qaLearnSkill(1692)
    ToClient_qaLearnSkill(1693)
    ToClient_qaLearnSkill(1694)
    ToClient_qaLearnSkill(1695)
    ToClient_qaLearnSkill(1696)
    ToClient_qaLearnSkill(1697)
    ToClient_qaLearnSkill(1698)
    ToClient_qaLearnSkill(1699)
    ToClient_qaLearnSkill(1700)
    ToClient_qaLearnSkill(1701)
    ToClient_qaLearnSkill(1708)
    ToClient_qaLearnSkill(1709)
    ToClient_qaLearnSkill(1710)
    ToClient_qaLearnSkill(1711)
    ToClient_qaLearnSkill(2077)
    ToClient_qaLearnSkill(2078)
    ToClient_qaLearnSkill(2079)
    ToClient_qaLearnSkill(2080)
    ToClient_qaLearnSkill(2081)
    ToClient_qaLearnSkill(2082)
    ToClient_qaLearnSkill(2083)
    ToClient_qaLearnSkill(2084)
    ToClient_qaLearnSkill(2085)
    ToClient_qaLearnSkill(2086)
    ToClient_qaLearnSkill(2087)
    ToClient_qaLearnSkill(2088)
    ToClient_qaLearnSkill(2089)
    ToClient_qaLearnSkill(2090)
    ToClient_qaLearnSkill(2091)
    ToClient_qaLearnSkill(2092)
    ToClient_qaLearnSkill(2093)
    ToClient_qaLearnSkill(2094)
    ToClient_qaLearnSkill(2095)
    ToClient_qaLearnSkill(2096)
    ToClient_qaLearnSkill(2097)
    ToClient_qaLearnSkill(2098)
    ToClient_qaLearnSkill(2099)
    ToClient_qaLearnSkill(2100)
    ToClient_qaLearnSkill(2101)
    ToClient_qaLearnSkill(2102)
    ToClient_qaLearnSkill(2103)
    ToClient_qaLearnSkill(2104)
    ToClient_qaLearnSkill(2105)
    ToClient_qaLearnSkill(2106)
    ToClient_qaLearnSkill(2107)
    ToClient_qaLearnSkill(2108)
    ToClient_qaLearnSkill(2109)
    ToClient_qaLearnSkill(2110)
    ToClient_qaLearnSkill(2111)
    ToClient_qaLearnSkill(2112)
    ToClient_qaLearnSkill(2113)
    ToClient_qaLearnSkill(2114)
    ToClient_qaLearnSkill(2115)
    ToClient_qaLearnSkill(2116)
    ToClient_qaLearnSkill(2117)
    ToClient_qaLearnSkill(2118)
    ToClient_qaLearnSkill(2119)
    ToClient_qaLearnSkill(2120)
    ToClient_qaLearnSkill(2121)
    ToClient_qaLearnSkill(2122)
    ToClient_qaLearnSkill(2123)
    ToClient_qaLearnSkill(2124)
    ToClient_qaLearnSkill(2125)
    ToClient_qaLearnSkill(2126)
    ToClient_qaLearnSkill(2127)
    ToClient_qaLearnSkill(2128)
    ToClient_qaLearnSkill(2129)
    ToClient_qaLearnSkill(2130)
    ToClient_qaLearnSkill(2131)
    ToClient_qaLearnSkill(2132)
    ToClient_qaLearnSkill(2133)
    ToClient_qaLearnSkill(2134)
    ToClient_qaLearnSkill(2135)
    ToClient_qaLearnSkill(2136)
    ToClient_qaLearnSkill(2137)
    ToClient_qaLearnSkill(2138)
    ToClient_qaLearnSkill(2139)
    ToClient_qaLearnSkill(2140)
    ToClient_qaLearnSkill(2141)
    ToClient_qaLearnSkill(2142)
    ToClient_qaLearnSkill(2143)
    ToClient_qaLearnSkill(2144)
    ToClient_qaLearnSkill(2145)
    ToClient_qaLearnSkill(2146)
    ToClient_qaLearnSkill(2147)
    ToClient_qaLearnSkill(2148)
    ToClient_qaLearnSkill(2149)
    ToClient_qaLearnSkill(2150)
    ToClient_qaLearnSkill(2151)
    ToClient_qaLearnSkill(2152)
    ToClient_qaLearnSkill(2153)
    ToClient_qaLearnSkill(2154)
    ToClient_qaLearnSkill(2155)
    ToClient_qaLearnSkill(2156)
    ToClient_qaLearnSkill(2157)
    ToClient_qaLearnSkill(2158)
    ToClient_qaLearnSkill(2159)
    ToClient_qaLearnSkill(2160)
    ToClient_qaLearnSkill(2161)
    ToClient_qaLearnSkill(2162)
    ToClient_qaLearnSkill(2753)
    ToClient_qaLearnSkill(2754)
  elseif isClassType == __eClassType_NinjaMan then
    ToClient_qaLearnSkill(690)
    ToClient_qaLearnSkill(691)
    ToClient_qaLearnSkill(692)
    ToClient_qaLearnSkill(693)
    ToClient_qaLearnSkill(694)
    ToClient_qaLearnSkill(695)
    ToClient_qaLearnSkill(696)
    ToClient_qaLearnSkill(697)
    ToClient_qaLearnSkill(698)
    ToClient_qaLearnSkill(699)
    ToClient_qaLearnSkill(700)
    ToClient_qaLearnSkill(701)
    ToClient_qaLearnSkill(702)
    ToClient_qaLearnSkill(703)
    ToClient_qaLearnSkill(704)
    ToClient_qaLearnSkill(915)
    ToClient_qaLearnSkill(916)
    ToClient_qaLearnSkill(917)
    ToClient_qaLearnSkill(918)
    ToClient_qaLearnSkill(919)
    ToClient_qaLearnSkill(920)
    ToClient_qaLearnSkill(921)
    ToClient_qaLearnSkill(922)
    ToClient_qaLearnSkill(923)
    ToClient_qaLearnSkill(924)
    ToClient_qaLearnSkill(925)
    ToClient_qaLearnSkill(926)
    ToClient_qaLearnSkill(927)
    ToClient_qaLearnSkill(928)
    ToClient_qaLearnSkill(929)
    ToClient_qaLearnSkill(930)
    ToClient_qaLearnSkill(931)
    ToClient_qaLearnSkill(932)
    ToClient_qaLearnSkill(933)
    ToClient_qaLearnSkill(934)
    ToClient_qaLearnSkill(935)
    ToClient_qaLearnSkill(936)
    ToClient_qaLearnSkill(937)
    ToClient_qaLearnSkill(938)
    ToClient_qaLearnSkill(939)
    ToClient_qaLearnSkill(940)
    ToClient_qaLearnSkill(941)
    ToClient_qaLearnSkill(942)
    ToClient_qaLearnSkill(943)
    ToClient_qaLearnSkill(944)
    ToClient_qaLearnSkill(945)
    ToClient_qaLearnSkill(946)
    ToClient_qaLearnSkill(947)
    ToClient_qaLearnSkill(948)
    ToClient_qaLearnSkill(949)
    ToClient_qaLearnSkill(950)
    ToClient_qaLearnSkill(951)
    ToClient_qaLearnSkill(952)
    ToClient_qaLearnSkill(953)
    ToClient_qaLearnSkill(954)
    ToClient_qaLearnSkill(955)
    ToClient_qaLearnSkill(956)
    ToClient_qaLearnSkill(957)
    ToClient_qaLearnSkill(958)
    ToClient_qaLearnSkill(959)
    ToClient_qaLearnSkill(960)
    ToClient_qaLearnSkill(961)
    ToClient_qaLearnSkill(962)
    ToClient_qaLearnSkill(963)
    ToClient_qaLearnSkill(964)
    ToClient_qaLearnSkill(965)
    ToClient_qaLearnSkill(966)
    ToClient_qaLearnSkill(967)
    ToClient_qaLearnSkill(968)
    ToClient_qaLearnSkill(969)
    ToClient_qaLearnSkill(970)
    ToClient_qaLearnSkill(971)
    ToClient_qaLearnSkill(972)
    ToClient_qaLearnSkill(973)
    ToClient_qaLearnSkill(974)
    ToClient_qaLearnSkill(975)
    ToClient_qaLearnSkill(976)
    ToClient_qaLearnSkill(977)
    ToClient_qaLearnSkill(978)
    ToClient_qaLearnSkill(979)
    ToClient_qaLearnSkill(980)
    ToClient_qaLearnSkill(981)
    ToClient_qaLearnSkill(982)
    ToClient_qaLearnSkill(983)
    ToClient_qaLearnSkill(984)
    ToClient_qaLearnSkill(985)
    ToClient_qaLearnSkill(986)
    ToClient_qaLearnSkill(987)
    ToClient_qaLearnSkill(988)
    ToClient_qaLearnSkill(989)
    ToClient_qaLearnSkill(990)
    ToClient_qaLearnSkill(991)
    ToClient_qaLearnSkill(992)
    ToClient_qaLearnSkill(998)
    ToClient_qaLearnSkill(999)
    ToClient_qaLearnSkill(1624)
    ToClient_qaLearnSkill(1625)
    ToClient_qaLearnSkill(1626)
    ToClient_qaLearnSkill(1627)
    ToClient_qaLearnSkill(1628)
    ToClient_qaLearnSkill(1629)
    ToClient_qaLearnSkill(1630)
    ToClient_qaLearnSkill(1631)
    ToClient_qaLearnSkill(1632)
    ToClient_qaLearnSkill(1633)
    ToClient_qaLearnSkill(1634)
    ToClient_qaLearnSkill(1635)
    ToClient_qaLearnSkill(1636)
    ToClient_qaLearnSkill(1637)
    ToClient_qaLearnSkill(1638)
    ToClient_qaLearnSkill(1639)
    ToClient_qaLearnSkill(1640)
    ToClient_qaLearnSkill(1641)
    ToClient_qaLearnSkill(1642)
    ToClient_qaLearnSkill(1643)
    ToClient_qaLearnSkill(1644)
    ToClient_qaLearnSkill(1645)
    ToClient_qaLearnSkill(1646)
    ToClient_qaLearnSkill(1647)
    ToClient_qaLearnSkill(1648)
    ToClient_qaLearnSkill(1649)
    ToClient_qaLearnSkill(1650)
    ToClient_qaLearnSkill(1651)
    ToClient_qaLearnSkill(1652)
    ToClient_qaLearnSkill(1653)
    ToClient_qaLearnSkill(1654)
    ToClient_qaLearnSkill(1655)
    ToClient_qaLearnSkill(1656)
    ToClient_qaLearnSkill(1657)
    ToClient_qaLearnSkill(1658)
    ToClient_qaLearnSkill(1659)
    ToClient_qaLearnSkill(1660)
    ToClient_qaLearnSkill(1661)
    ToClient_qaLearnSkill(1662)
    ToClient_qaLearnSkill(1663)
    ToClient_qaLearnSkill(1664)
    ToClient_qaLearnSkill(1665)
    ToClient_qaLearnSkill(1666)
    ToClient_qaLearnSkill(1667)
    ToClient_qaLearnSkill(1668)
    ToClient_qaLearnSkill(1669)
    ToClient_qaLearnSkill(1670)
    ToClient_qaLearnSkill(1702)
    ToClient_qaLearnSkill(1703)
    ToClient_qaLearnSkill(1704)
    ToClient_qaLearnSkill(1705)
    ToClient_qaLearnSkill(1706)
    ToClient_qaLearnSkill(1707)
    ToClient_qaLearnSkill(2072)
    ToClient_qaLearnSkill(2073)
    ToClient_qaLearnSkill(2074)
    ToClient_qaLearnSkill(2075)
    ToClient_qaLearnSkill(2076)
    ToClient_qaLearnSkill(1675)
    ToClient_qaLearnSkill(1676)
    ToClient_qaLearnSkill(1677)
    ToClient_qaLearnSkill(1678)
    ToClient_qaLearnSkill(1679)
    ToClient_qaLearnSkill(1680)
    ToClient_qaLearnSkill(1681)
    ToClient_qaLearnSkill(1682)
    ToClient_qaLearnSkill(1683)
    ToClient_qaLearnSkill(1684)
    ToClient_qaLearnSkill(1685)
    ToClient_qaLearnSkill(1686)
    ToClient_qaLearnSkill(1687)
    ToClient_qaLearnSkill(1688)
    ToClient_qaLearnSkill(1689)
    ToClient_qaLearnSkill(1690)
    ToClient_qaLearnSkill(1691)
    ToClient_qaLearnSkill(1692)
    ToClient_qaLearnSkill(1693)
    ToClient_qaLearnSkill(1694)
    ToClient_qaLearnSkill(1695)
    ToClient_qaLearnSkill(1696)
    ToClient_qaLearnSkill(1697)
    ToClient_qaLearnSkill(1698)
    ToClient_qaLearnSkill(1699)
    ToClient_qaLearnSkill(1700)
    ToClient_qaLearnSkill(1701)
    ToClient_qaLearnSkill(1708)
    ToClient_qaLearnSkill(1709)
    ToClient_qaLearnSkill(1710)
    ToClient_qaLearnSkill(1711)
    ToClient_qaLearnSkill(2077)
    ToClient_qaLearnSkill(2078)
    ToClient_qaLearnSkill(2079)
    ToClient_qaLearnSkill(2080)
    ToClient_qaLearnSkill(2081)
    ToClient_qaLearnSkill(2082)
    ToClient_qaLearnSkill(2083)
    ToClient_qaLearnSkill(2084)
    ToClient_qaLearnSkill(2085)
    ToClient_qaLearnSkill(2086)
    ToClient_qaLearnSkill(2087)
    ToClient_qaLearnSkill(2088)
    ToClient_qaLearnSkill(2089)
    ToClient_qaLearnSkill(2090)
    ToClient_qaLearnSkill(2091)
    ToClient_qaLearnSkill(2092)
    ToClient_qaLearnSkill(2093)
    ToClient_qaLearnSkill(2094)
    ToClient_qaLearnSkill(2095)
    ToClient_qaLearnSkill(2096)
    ToClient_qaLearnSkill(2097)
    ToClient_qaLearnSkill(2098)
    ToClient_qaLearnSkill(2099)
    ToClient_qaLearnSkill(2100)
    ToClient_qaLearnSkill(2101)
    ToClient_qaLearnSkill(2102)
    ToClient_qaLearnSkill(2103)
    ToClient_qaLearnSkill(2104)
    ToClient_qaLearnSkill(2105)
    ToClient_qaLearnSkill(2106)
    ToClient_qaLearnSkill(2107)
    ToClient_qaLearnSkill(2108)
    ToClient_qaLearnSkill(2109)
    ToClient_qaLearnSkill(2110)
    ToClient_qaLearnSkill(2111)
    ToClient_qaLearnSkill(2112)
    ToClient_qaLearnSkill(2113)
    ToClient_qaLearnSkill(2114)
    ToClient_qaLearnSkill(2115)
    ToClient_qaLearnSkill(2116)
    ToClient_qaLearnSkill(2117)
    ToClient_qaLearnSkill(2118)
    ToClient_qaLearnSkill(2119)
    ToClient_qaLearnSkill(2077)
    ToClient_qaLearnSkill(2078)
    ToClient_qaLearnSkill(2079)
    ToClient_qaLearnSkill(2080)
    ToClient_qaLearnSkill(2081)
    ToClient_qaLearnSkill(2082)
    ToClient_qaLearnSkill(2083)
    ToClient_qaLearnSkill(2084)
    ToClient_qaLearnSkill(2085)
    ToClient_qaLearnSkill(2086)
    ToClient_qaLearnSkill(2087)
    ToClient_qaLearnSkill(2088)
    ToClient_qaLearnSkill(2089)
    ToClient_qaLearnSkill(2090)
    ToClient_qaLearnSkill(2091)
    ToClient_qaLearnSkill(2092)
    ToClient_qaLearnSkill(2093)
    ToClient_qaLearnSkill(2094)
    ToClient_qaLearnSkill(2095)
    ToClient_qaLearnSkill(2096)
    ToClient_qaLearnSkill(2097)
    ToClient_qaLearnSkill(2098)
    ToClient_qaLearnSkill(2099)
    ToClient_qaLearnSkill(2100)
    ToClient_qaLearnSkill(2101)
    ToClient_qaLearnSkill(2102)
    ToClient_qaLearnSkill(2103)
    ToClient_qaLearnSkill(2104)
    ToClient_qaLearnSkill(2105)
    ToClient_qaLearnSkill(2106)
    ToClient_qaLearnSkill(2107)
    ToClient_qaLearnSkill(2108)
    ToClient_qaLearnSkill(2109)
    ToClient_qaLearnSkill(2110)
    ToClient_qaLearnSkill(2111)
    ToClient_qaLearnSkill(2112)
    ToClient_qaLearnSkill(2113)
    ToClient_qaLearnSkill(2114)
    ToClient_qaLearnSkill(2115)
    ToClient_qaLearnSkill(2116)
    ToClient_qaLearnSkill(2117)
    ToClient_qaLearnSkill(2118)
    ToClient_qaLearnSkill(2119)
    ToClient_qaLearnSkill(2755)
    ToClient_qaLearnSkill(2756)
  elseif isClassType == __eClassType_Combattant then
    ToClient_qaLearnSkill(2423)
    ToClient_qaLearnSkill(2424)
    ToClient_qaLearnSkill(2425)
    ToClient_qaLearnSkill(2426)
    ToClient_qaLearnSkill(2427)
    ToClient_qaLearnSkill(2428)
    ToClient_qaLearnSkill(2429)
    ToClient_qaLearnSkill(2430)
    ToClient_qaLearnSkill(2431)
    ToClient_qaLearnSkill(2432)
    ToClient_qaLearnSkill(2433)
    ToClient_qaLearnSkill(2434)
    ToClient_qaLearnSkill(2435)
    ToClient_qaLearnSkill(2436)
    ToClient_qaLearnSkill(2437)
    ToClient_qaLearnSkill(2438)
    ToClient_qaLearnSkill(2439)
    ToClient_qaLearnSkill(2440)
    ToClient_qaLearnSkill(2441)
    ToClient_qaLearnSkill(2442)
    ToClient_qaLearnSkill(2443)
    ToClient_qaLearnSkill(2444)
    ToClient_qaLearnSkill(2445)
    ToClient_qaLearnSkill(2446)
    ToClient_qaLearnSkill(2447)
    ToClient_qaLearnSkill(2448)
    ToClient_qaLearnSkill(2449)
    ToClient_qaLearnSkill(2450)
    ToClient_qaLearnSkill(2451)
    ToClient_qaLearnSkill(2452)
    ToClient_qaLearnSkill(2453)
    ToClient_qaLearnSkill(2454)
    ToClient_qaLearnSkill(2455)
    ToClient_qaLearnSkill(2456)
    ToClient_qaLearnSkill(2457)
    ToClient_qaLearnSkill(2458)
    ToClient_qaLearnSkill(2459)
    ToClient_qaLearnSkill(2460)
    ToClient_qaLearnSkill(2461)
    ToClient_qaLearnSkill(2462)
    ToClient_qaLearnSkill(2463)
    ToClient_qaLearnSkill(2464)
    ToClient_qaLearnSkill(2465)
    ToClient_qaLearnSkill(2466)
    ToClient_qaLearnSkill(2467)
    ToClient_qaLearnSkill(2468)
    ToClient_qaLearnSkill(2469)
    ToClient_qaLearnSkill(2470)
    ToClient_qaLearnSkill(2471)
    ToClient_qaLearnSkill(2472)
    ToClient_qaLearnSkill(2473)
    ToClient_qaLearnSkill(2474)
    ToClient_qaLearnSkill(2475)
    ToClient_qaLearnSkill(2476)
    ToClient_qaLearnSkill(2477)
    ToClient_qaLearnSkill(2478)
    ToClient_qaLearnSkill(2479)
    ToClient_qaLearnSkill(2480)
    ToClient_qaLearnSkill(2481)
    ToClient_qaLearnSkill(2482)
    ToClient_qaLearnSkill(2483)
    ToClient_qaLearnSkill(2484)
    ToClient_qaLearnSkill(2485)
    ToClient_qaLearnSkill(2486)
    ToClient_qaLearnSkill(2487)
    ToClient_qaLearnSkill(2488)
    ToClient_qaLearnSkill(2489)
    ToClient_qaLearnSkill(2490)
    ToClient_qaLearnSkill(2491)
    ToClient_qaLearnSkill(2492)
    ToClient_qaLearnSkill(2493)
    ToClient_qaLearnSkill(2494)
    ToClient_qaLearnSkill(2495)
    ToClient_qaLearnSkill(2496)
    ToClient_qaLearnSkill(2497)
    ToClient_qaLearnSkill(2498)
    ToClient_qaLearnSkill(2499)
    ToClient_qaLearnSkill(2500)
    ToClient_qaLearnSkill(2501)
    ToClient_qaLearnSkill(2502)
    ToClient_qaLearnSkill(2503)
    ToClient_qaLearnSkill(2504)
    ToClient_qaLearnSkill(2505)
    ToClient_qaLearnSkill(2506)
    ToClient_qaLearnSkill(2507)
    ToClient_qaLearnSkill(2508)
    ToClient_qaLearnSkill(2509)
    ToClient_qaLearnSkill(2510)
    ToClient_qaLearnSkill(2511)
    ToClient_qaLearnSkill(2512)
    ToClient_qaLearnSkill(2513)
    ToClient_qaLearnSkill(2514)
    ToClient_qaLearnSkill(2515)
    ToClient_qaLearnSkill(2516)
    ToClient_qaLearnSkill(2517)
    ToClient_qaLearnSkill(2518)
    ToClient_qaLearnSkill(2519)
    ToClient_qaLearnSkill(2520)
    ToClient_qaLearnSkill(2521)
    ToClient_qaLearnSkill(2522)
    ToClient_qaLearnSkill(2523)
    ToClient_qaLearnSkill(2524)
    ToClient_qaLearnSkill(2525)
    ToClient_qaLearnSkill(2526)
    ToClient_qaLearnSkill(2527)
    ToClient_qaLearnSkill(2528)
    ToClient_qaLearnSkill(2529)
    ToClient_qaLearnSkill(2530)
    ToClient_qaLearnSkill(2531)
    ToClient_qaLearnSkill(2532)
    ToClient_qaLearnSkill(2533)
    ToClient_qaLearnSkill(2534)
    ToClient_qaLearnSkill(2535)
    ToClient_qaLearnSkill(2536)
    ToClient_qaLearnSkill(2537)
    ToClient_qaLearnSkill(2538)
    ToClient_qaLearnSkill(2539)
    ToClient_qaLearnSkill(2540)
    ToClient_qaLearnSkill(2541)
    ToClient_qaLearnSkill(2542)
    ToClient_qaLearnSkill(2543)
    ToClient_qaLearnSkill(2544)
    ToClient_qaLearnSkill(2545)
    ToClient_qaLearnSkill(2546)
    ToClient_qaLearnSkill(2547)
    ToClient_qaLearnSkill(2548)
    ToClient_qaLearnSkill(2549)
    ToClient_qaLearnSkill(2550)
    ToClient_qaLearnSkill(2551)
    ToClient_qaLearnSkill(2552)
    ToClient_qaLearnSkill(2553)
    ToClient_qaLearnSkill(2554)
    ToClient_qaLearnSkill(2556)
    ToClient_qaLearnSkill(2557)
    ToClient_qaLearnSkill(2558)
    ToClient_qaLearnSkill(2559)
    ToClient_qaLearnSkill(2560)
    ToClient_qaLearnSkill(2561)
    ToClient_qaLearnSkill(2562)
    ToClient_qaLearnSkill(2563)
    ToClient_qaLearnSkill(2564)
    ToClient_qaLearnSkill(2565)
    ToClient_qaLearnSkill(2566)
    ToClient_qaLearnSkill(2567)
    ToClient_qaLearnSkill(2568)
    ToClient_qaLearnSkill(2569)
    ToClient_qaLearnSkill(2570)
    ToClient_qaLearnSkill(2571)
    ToClient_qaLearnSkill(2572)
    ToClient_qaLearnSkill(2573)
    ToClient_qaLearnSkill(2574)
    ToClient_qaLearnSkill(2575)
    ToClient_qaLearnSkill(2576)
    ToClient_qaLearnSkill(2577)
    ToClient_qaLearnSkill(2578)
    ToClient_qaLearnSkill(2579)
    ToClient_qaLearnSkill(2580)
    ToClient_qaLearnSkill(2581)
    ToClient_qaLearnSkill(2582)
    ToClient_qaLearnSkill(2583)
    ToClient_qaLearnSkill(2584)
    ToClient_qaLearnSkill(2585)
    ToClient_qaLearnSkill(2586)
    ToClient_qaLearnSkill(2587)
    ToClient_qaLearnSkill(2588)
    ToClient_qaLearnSkill(2589)
    ToClient_qaLearnSkill(2640)
    ToClient_qaLearnSkill(2641)
    ToClient_qaLearnSkill(2642)
    ToClient_qaLearnSkill(2643)
    ToClient_qaLearnSkill(2644)
    ToClient_qaLearnSkill(2645)
    ToClient_qaLearnSkill(2646)
    ToClient_qaLearnSkill(2647)
    ToClient_qaLearnSkill(2648)
    ToClient_qaLearnSkill(2649)
    ToClient_qaLearnSkill(2650)
    ToClient_qaLearnSkill(3030)
    ToClient_qaLearnSkill(3031)
    ToClient_qaLearnSkill(3032)
    ToClient_qaLearnSkill(3033)
    ToClient_qaLearnSkill(3034)
    ToClient_qaLearnSkill(3035)
    ToClient_qaLearnSkill(3036)
    ToClient_qaLearnSkill(3037)
    ToClient_qaLearnSkill(3038)
    ToClient_qaLearnSkill(3039)
    ToClient_qaLearnSkill(3040)
    ToClient_qaLearnSkill(3041)
    ToClient_qaLearnSkill(3042)
    ToClient_qaLearnSkill(3043)
    ToClient_qaLearnSkill(3044)
    ToClient_qaLearnSkill(3045)
    ToClient_qaLearnSkill(3046)
    ToClient_qaLearnSkill(3047)
    ToClient_qaLearnSkill(3048)
    ToClient_qaLearnSkill(3049)
    ToClient_qaLearnSkill(3050)
    ToClient_qaLearnSkill(3051)
    ToClient_qaLearnSkill(3052)
    ToClient_qaLearnSkill(3094)
    ToClient_qaLearnSkill(1702)
    ToClient_qaLearnSkill(1703)
    ToClient_qaLearnSkill(1704)
    ToClient_qaLearnSkill(1705)
    ToClient_qaLearnSkill(1706)
    ToClient_qaLearnSkill(1707)
    ToClient_qaLearnSkill(2072)
    ToClient_qaLearnSkill(2073)
    ToClient_qaLearnSkill(2074)
    ToClient_qaLearnSkill(2075)
    ToClient_qaLearnSkill(2076)
  elseif isClassType == __eClassType_DarkElf then
    ToClient_qaLearnSkill(2254)
    ToClient_qaLearnSkill(2255)
    ToClient_qaLearnSkill(2256)
    ToClient_qaLearnSkill(2257)
    ToClient_qaLearnSkill(2258)
    ToClient_qaLearnSkill(2259)
    ToClient_qaLearnSkill(2260)
    ToClient_qaLearnSkill(2261)
    ToClient_qaLearnSkill(2262)
    ToClient_qaLearnSkill(2263)
    ToClient_qaLearnSkill(2264)
    ToClient_qaLearnSkill(2265)
    ToClient_qaLearnSkill(2266)
    ToClient_qaLearnSkill(2267)
    ToClient_qaLearnSkill(2268)
    ToClient_qaLearnSkill(2269)
    ToClient_qaLearnSkill(2270)
    ToClient_qaLearnSkill(2271)
    ToClient_qaLearnSkill(2272)
    ToClient_qaLearnSkill(2273)
    ToClient_qaLearnSkill(2274)
    ToClient_qaLearnSkill(2275)
    ToClient_qaLearnSkill(2276)
    ToClient_qaLearnSkill(2277)
    ToClient_qaLearnSkill(2278)
    ToClient_qaLearnSkill(2279)
    ToClient_qaLearnSkill(2280)
    ToClient_qaLearnSkill(2281)
    ToClient_qaLearnSkill(2282)
    ToClient_qaLearnSkill(2283)
    ToClient_qaLearnSkill(2284)
    ToClient_qaLearnSkill(2285)
    ToClient_qaLearnSkill(2286)
    ToClient_qaLearnSkill(2287)
    ToClient_qaLearnSkill(2288)
    ToClient_qaLearnSkill(2289)
    ToClient_qaLearnSkill(2290)
    ToClient_qaLearnSkill(2291)
    ToClient_qaLearnSkill(2292)
    ToClient_qaLearnSkill(2293)
    ToClient_qaLearnSkill(2294)
    ToClient_qaLearnSkill(2295)
    ToClient_qaLearnSkill(2296)
    ToClient_qaLearnSkill(2297)
    ToClient_qaLearnSkill(2298)
    ToClient_qaLearnSkill(2299)
    ToClient_qaLearnSkill(2300)
    ToClient_qaLearnSkill(2301)
    ToClient_qaLearnSkill(2302)
    ToClient_qaLearnSkill(2303)
    ToClient_qaLearnSkill(2304)
    ToClient_qaLearnSkill(2305)
    ToClient_qaLearnSkill(2306)
    ToClient_qaLearnSkill(2307)
    ToClient_qaLearnSkill(2308)
    ToClient_qaLearnSkill(2309)
    ToClient_qaLearnSkill(2310)
    ToClient_qaLearnSkill(2311)
    ToClient_qaLearnSkill(2312)
    ToClient_qaLearnSkill(2313)
    ToClient_qaLearnSkill(2314)
    ToClient_qaLearnSkill(2315)
    ToClient_qaLearnSkill(2316)
    ToClient_qaLearnSkill(2317)
    ToClient_qaLearnSkill(2318)
    ToClient_qaLearnSkill(2319)
    ToClient_qaLearnSkill(2320)
    ToClient_qaLearnSkill(2321)
    ToClient_qaLearnSkill(2322)
    ToClient_qaLearnSkill(2323)
    ToClient_qaLearnSkill(2324)
    ToClient_qaLearnSkill(2325)
    ToClient_qaLearnSkill(2326)
    ToClient_qaLearnSkill(2327)
    ToClient_qaLearnSkill(2328)
    ToClient_qaLearnSkill(2329)
    ToClient_qaLearnSkill(2330)
    ToClient_qaLearnSkill(2331)
    ToClient_qaLearnSkill(2332)
    ToClient_qaLearnSkill(2333)
    ToClient_qaLearnSkill(2334)
    ToClient_qaLearnSkill(2335)
    ToClient_qaLearnSkill(2336)
    ToClient_qaLearnSkill(2337)
    ToClient_qaLearnSkill(2338)
    ToClient_qaLearnSkill(2339)
    ToClient_qaLearnSkill(2340)
    ToClient_qaLearnSkill(2341)
    ToClient_qaLearnSkill(2342)
    ToClient_qaLearnSkill(2343)
    ToClient_qaLearnSkill(2344)
    ToClient_qaLearnSkill(2345)
    ToClient_qaLearnSkill(2346)
    ToClient_qaLearnSkill(2347)
    ToClient_qaLearnSkill(2348)
    ToClient_qaLearnSkill(2349)
    ToClient_qaLearnSkill(2350)
    ToClient_qaLearnSkill(2351)
    ToClient_qaLearnSkill(2352)
    ToClient_qaLearnSkill(2353)
    ToClient_qaLearnSkill(2354)
    ToClient_qaLearnSkill(2355)
    ToClient_qaLearnSkill(2356)
    ToClient_qaLearnSkill(2357)
    ToClient_qaLearnSkill(2358)
    ToClient_qaLearnSkill(2359)
    ToClient_qaLearnSkill(2360)
    ToClient_qaLearnSkill(2361)
    ToClient_qaLearnSkill(2362)
    ToClient_qaLearnSkill(2363)
    ToClient_qaLearnSkill(2364)
    ToClient_qaLearnSkill(2365)
    ToClient_qaLearnSkill(2366)
    ToClient_qaLearnSkill(2367)
    ToClient_qaLearnSkill(2368)
    ToClient_qaLearnSkill(2369)
    ToClient_qaLearnSkill(2370)
    ToClient_qaLearnSkill(2371)
    ToClient_qaLearnSkill(2372)
    ToClient_qaLearnSkill(2373)
    ToClient_qaLearnSkill(2374)
    ToClient_qaLearnSkill(2375)
    ToClient_qaLearnSkill(2376)
    ToClient_qaLearnSkill(2377)
    ToClient_qaLearnSkill(2378)
    ToClient_qaLearnSkill(2379)
    ToClient_qaLearnSkill(1702)
    ToClient_qaLearnSkill(1703)
    ToClient_qaLearnSkill(1704)
    ToClient_qaLearnSkill(1705)
    ToClient_qaLearnSkill(1706)
    ToClient_qaLearnSkill(1707)
    ToClient_qaLearnSkill(2072)
    ToClient_qaLearnSkill(2073)
    ToClient_qaLearnSkill(2074)
    ToClient_qaLearnSkill(2075)
    ToClient_qaLearnSkill(2076)
    ToClient_qaLearnSkill(2380)
    ToClient_qaLearnSkill(2381)
    ToClient_qaLearnSkill(2382)
    ToClient_qaLearnSkill(2383)
    ToClient_qaLearnSkill(2384)
    ToClient_qaLearnSkill(2385)
    ToClient_qaLearnSkill(2386)
    ToClient_qaLearnSkill(2387)
    ToClient_qaLearnSkill(2388)
    ToClient_qaLearnSkill(2389)
    ToClient_qaLearnSkill(2390)
    ToClient_qaLearnSkill(2391)
    ToClient_qaLearnSkill(2392)
    ToClient_qaLearnSkill(2393)
    ToClient_qaLearnSkill(2394)
    ToClient_qaLearnSkill(2395)
    ToClient_qaLearnSkill(2396)
    ToClient_qaLearnSkill(2397)
    ToClient_qaLearnSkill(2398)
    ToClient_qaLearnSkill(2399)
    ToClient_qaLearnSkill(2400)
    ToClient_qaLearnSkill(2401)
    ToClient_qaLearnSkill(2402)
    ToClient_qaLearnSkill(2403)
    ToClient_qaLearnSkill(2404)
    ToClient_qaLearnSkill(2405)
    ToClient_qaLearnSkill(2406)
    ToClient_qaLearnSkill(2407)
    ToClient_qaLearnSkill(2408)
    ToClient_qaLearnSkill(2409)
    ToClient_qaLearnSkill(2410)
    ToClient_qaLearnSkill(2411)
    ToClient_qaLearnSkill(2412)
    ToClient_qaLearnSkill(2413)
    ToClient_qaLearnSkill(2414)
    ToClient_qaLearnSkill(2415)
    ToClient_qaLearnSkill(2416)
    ToClient_qaLearnSkill(2417)
    ToClient_qaLearnSkill(2418)
    ToClient_qaLearnSkill(2419)
    ToClient_qaLearnSkill(2420)
    ToClient_qaLearnSkill(2421)
    ToClient_qaLearnSkill(2422)
    ToClient_qaLearnSkill(2757)
    ToClient_qaLearnSkill(2758)
  elseif isClassType == __eClassType_Mystic then
    ToClient_qaLearnSkill(2591)
    ToClient_qaLearnSkill(2592)
    ToClient_qaLearnSkill(2593)
    ToClient_qaLearnSkill(2594)
    ToClient_qaLearnSkill(2595)
    ToClient_qaLearnSkill(2596)
    ToClient_qaLearnSkill(2597)
    ToClient_qaLearnSkill(2598)
    ToClient_qaLearnSkill(2599)
    ToClient_qaLearnSkill(2600)
    ToClient_qaLearnSkill(2601)
    ToClient_qaLearnSkill(2602)
    ToClient_qaLearnSkill(2603)
    ToClient_qaLearnSkill(2604)
    ToClient_qaLearnSkill(2605)
    ToClient_qaLearnSkill(2606)
    ToClient_qaLearnSkill(2607)
    ToClient_qaLearnSkill(2608)
    ToClient_qaLearnSkill(2609)
    ToClient_qaLearnSkill(2610)
    ToClient_qaLearnSkill(2611)
    ToClient_qaLearnSkill(2612)
    ToClient_qaLearnSkill(2613)
    ToClient_qaLearnSkill(2614)
    ToClient_qaLearnSkill(2615)
    ToClient_qaLearnSkill(2616)
    ToClient_qaLearnSkill(2617)
    ToClient_qaLearnSkill(2618)
    ToClient_qaLearnSkill(2619)
    ToClient_qaLearnSkill(2620)
    ToClient_qaLearnSkill(2621)
    ToClient_qaLearnSkill(3053)
    ToClient_qaLearnSkill(2622)
    ToClient_qaLearnSkill(2623)
    ToClient_qaLearnSkill(2624)
    ToClient_qaLearnSkill(2625)
    ToClient_qaLearnSkill(3054)
    ToClient_qaLearnSkill(2626)
    ToClient_qaLearnSkill(2627)
    ToClient_qaLearnSkill(2628)
    ToClient_qaLearnSkill(2629)
    ToClient_qaLearnSkill(2630)
    ToClient_qaLearnSkill(3055)
    ToClient_qaLearnSkill(2631)
    ToClient_qaLearnSkill(2632)
    ToClient_qaLearnSkill(2633)
    ToClient_qaLearnSkill(2634)
    ToClient_qaLearnSkill(2635)
    ToClient_qaLearnSkill(2636)
    ToClient_qaLearnSkill(2637)
    ToClient_qaLearnSkill(2638)
    ToClient_qaLearnSkill(2639)
    ToClient_qaLearnSkill(3056)
    ToClient_qaLearnSkill(2651)
    ToClient_qaLearnSkill(3258)
    ToClient_qaLearnSkill(2652)
    ToClient_qaLearnSkill(2653)
    ToClient_qaLearnSkill(2654)
    ToClient_qaLearnSkill(2655)
    ToClient_qaLearnSkill(3057)
    ToClient_qaLearnSkill(2656)
    ToClient_qaLearnSkill(2657)
    ToClient_qaLearnSkill(2658)
    ToClient_qaLearnSkill(3058)
    ToClient_qaLearnSkill(2679)
    ToClient_qaLearnSkill(2761)
    ToClient_qaLearnSkill(2659)
    ToClient_qaLearnSkill(2660)
    ToClient_qaLearnSkill(2661)
    ToClient_qaLearnSkill(3059)
    ToClient_qaLearnSkill(2662)
    ToClient_qaLearnSkill(2663)
    ToClient_qaLearnSkill(2664)
    ToClient_qaLearnSkill(3060)
    ToClient_qaLearnSkill(2665)
    ToClient_qaLearnSkill(2666)
    ToClient_qaLearnSkill(2667)
    ToClient_qaLearnSkill(2668)
    ToClient_qaLearnSkill(2669)
    ToClient_qaLearnSkill(3061)
    ToClient_qaLearnSkill(2670)
    ToClient_qaLearnSkill(2671)
    ToClient_qaLearnSkill(2672)
    ToClient_qaLearnSkill(2673)
    ToClient_qaLearnSkill(2674)
    ToClient_qaLearnSkill(2675)
    ToClient_qaLearnSkill(2676)
    ToClient_qaLearnSkill(2677)
    ToClient_qaLearnSkill(3062)
    ToClient_qaLearnSkill(2683)
    ToClient_qaLearnSkill(2684)
    ToClient_qaLearnSkill(2685)
    ToClient_qaLearnSkill(2686)
    ToClient_qaLearnSkill(2687)
    ToClient_qaLearnSkill(2688)
    ToClient_qaLearnSkill(3063)
    ToClient_qaLearnSkill(2689)
    ToClient_qaLearnSkill(2690)
    ToClient_qaLearnSkill(2691)
    ToClient_qaLearnSkill(2692)
    ToClient_qaLearnSkill(2693)
    ToClient_qaLearnSkill(3064)
    ToClient_qaLearnSkill(2694)
    ToClient_qaLearnSkill(2695)
    ToClient_qaLearnSkill(2696)
    ToClient_qaLearnSkill(3065)
    ToClient_qaLearnSkill(2697)
    ToClient_qaLearnSkill(2698)
    ToClient_qaLearnSkill(2699)
    ToClient_qaLearnSkill(3066)
    ToClient_qaLearnSkill(2700)
    ToClient_qaLearnSkill(3261)
    ToClient_qaLearnSkill(2701)
    ToClient_qaLearnSkill(2702)
    ToClient_qaLearnSkill(2703)
    ToClient_qaLearnSkill(2704)
    ToClient_qaLearnSkill(3067)
    ToClient_qaLearnSkill(2705)
    ToClient_qaLearnSkill(2706)
    ToClient_qaLearnSkill(2707)
    ToClient_qaLearnSkill(2708)
    ToClient_qaLearnSkill(2709)
    ToClient_qaLearnSkill(3068)
    ToClient_qaLearnSkill(2710)
    ToClient_qaLearnSkill(2711)
    ToClient_qaLearnSkill(2712)
    ToClient_qaLearnSkill(2713)
    ToClient_qaLearnSkill(2714)
    ToClient_qaLearnSkill(2715)
    ToClient_qaLearnSkill(2716)
    ToClient_qaLearnSkill(2717)
    ToClient_qaLearnSkill(2718)
    ToClient_qaLearnSkill(2719)
    ToClient_qaLearnSkill(2720)
    ToClient_qaLearnSkill(2721)
    ToClient_qaLearnSkill(2722)
    ToClient_qaLearnSkill(3069)
    ToClient_qaLearnSkill(2723)
    ToClient_qaLearnSkill(2724)
    ToClient_qaLearnSkill(2725)
    ToClient_qaLearnSkill(2726)
    ToClient_qaLearnSkill(2727)
    ToClient_qaLearnSkill(3070)
    ToClient_qaLearnSkill(2728)
    ToClient_qaLearnSkill(2729)
    ToClient_qaLearnSkill(2730)
    ToClient_qaLearnSkill(2731)
    ToClient_qaLearnSkill(3071)
    ToClient_qaLearnSkill(2732)
    ToClient_qaLearnSkill(2768)
    ToClient_qaLearnSkill(2769)
    ToClient_qaLearnSkill(2770)
    ToClient_qaLearnSkill(2771)
    ToClient_qaLearnSkill(2772)
    ToClient_qaLearnSkill(2773)
    ToClient_qaLearnSkill(2776)
    ToClient_qaLearnSkill(2777)
    ToClient_qaLearnSkill(2778)
    ToClient_qaLearnSkill(2779)
    ToClient_qaLearnSkill(2780)
    ToClient_qaLearnSkill(2781)
    ToClient_qaLearnSkill(2782)
    ToClient_qaLearnSkill(2783)
    ToClient_qaLearnSkill(2791)
    ToClient_qaLearnSkill(2784)
    ToClient_qaLearnSkill(2785)
    ToClient_qaLearnSkill(2786)
    ToClient_qaLearnSkill(2787)
    ToClient_qaLearnSkill(2788)
    ToClient_qaLearnSkill(2789)
    ToClient_qaLearnSkill(2790)
    ToClient_qaLearnSkill(2792)
    ToClient_qaLearnSkill(2793)
    ToClient_qaLearnSkill(2794)
    ToClient_qaLearnSkill(2795)
    ToClient_qaLearnSkill(2796)
    ToClient_qaLearnSkill(2797)
    ToClient_qaLearnSkill(2798)
    ToClient_qaLearnSkill(2799)
    ToClient_qaLearnSkill(2800)
    ToClient_qaLearnSkill(2801)
    ToClient_qaLearnSkill(2802)
    ToClient_qaLearnSkill(2803)
    ToClient_qaLearnSkill(2804)
    ToClient_qaLearnSkill(2805)
    ToClient_qaLearnSkill(2806)
    ToClient_qaLearnSkill(1702)
    ToClient_qaLearnSkill(1703)
    ToClient_qaLearnSkill(1704)
    ToClient_qaLearnSkill(1705)
    ToClient_qaLearnSkill(1706)
    ToClient_qaLearnSkill(1707)
    ToClient_qaLearnSkill(2072)
    ToClient_qaLearnSkill(2073)
    ToClient_qaLearnSkill(2074)
    ToClient_qaLearnSkill(2075)
    ToClient_qaLearnSkill(2076)
  elseif isClassType == __eClassType_Lhan then
    ToClient_qaLearnSkill(2937)
    ToClient_qaLearnSkill(2938)
    ToClient_qaLearnSkill(2939)
    ToClient_qaLearnSkill(2940)
    ToClient_qaLearnSkill(2941)
    ToClient_qaLearnSkill(2942)
    ToClient_qaLearnSkill(2943)
    ToClient_qaLearnSkill(2944)
    ToClient_qaLearnSkill(2945)
    ToClient_qaLearnSkill(2946)
    ToClient_qaLearnSkill(2947)
    ToClient_qaLearnSkill(2948)
    ToClient_qaLearnSkill(2949)
    ToClient_qaLearnSkill(2950)
    ToClient_qaLearnSkill(2951)
    ToClient_qaLearnSkill(2952)
    ToClient_qaLearnSkill(2953)
    ToClient_qaLearnSkill(2954)
    ToClient_qaLearnSkill(2955)
    ToClient_qaLearnSkill(2956)
    ToClient_qaLearnSkill(2957)
    ToClient_qaLearnSkill(2958)
    ToClient_qaLearnSkill(2959)
    ToClient_qaLearnSkill(2960)
    ToClient_qaLearnSkill(2961)
    ToClient_qaLearnSkill(2962)
    ToClient_qaLearnSkill(2963)
    ToClient_qaLearnSkill(2964)
    ToClient_qaLearnSkill(2965)
    ToClient_qaLearnSkill(2966)
    ToClient_qaLearnSkill(2967)
    ToClient_qaLearnSkill(2969)
    ToClient_qaLearnSkill(2970)
    ToClient_qaLearnSkill(2971)
    ToClient_qaLearnSkill(2972)
    ToClient_qaLearnSkill(2973)
    ToClient_qaLearnSkill(2974)
    ToClient_qaLearnSkill(2975)
    ToClient_qaLearnSkill(2976)
    ToClient_qaLearnSkill(2977)
    ToClient_qaLearnSkill(2978)
    ToClient_qaLearnSkill(2979)
    ToClient_qaLearnSkill(2980)
    ToClient_qaLearnSkill(2981)
    ToClient_qaLearnSkill(2982)
    ToClient_qaLearnSkill(2983)
    ToClient_qaLearnSkill(2984)
    ToClient_qaLearnSkill(2985)
    ToClient_qaLearnSkill(2986)
    ToClient_qaLearnSkill(2987)
    ToClient_qaLearnSkill(2988)
    ToClient_qaLearnSkill(2989)
    ToClient_qaLearnSkill(2990)
    ToClient_qaLearnSkill(2991)
    ToClient_qaLearnSkill(2992)
    ToClient_qaLearnSkill(2993)
    ToClient_qaLearnSkill(2994)
    ToClient_qaLearnSkill(2995)
    ToClient_qaLearnSkill(2996)
    ToClient_qaLearnSkill(2997)
    ToClient_qaLearnSkill(2998)
    ToClient_qaLearnSkill(2999)
    ToClient_qaLearnSkill(3000)
    ToClient_qaLearnSkill(3001)
    ToClient_qaLearnSkill(3002)
    ToClient_qaLearnSkill(3003)
    ToClient_qaLearnSkill(3004)
    ToClient_qaLearnSkill(3005)
    ToClient_qaLearnSkill(3006)
    ToClient_qaLearnSkill(3007)
    ToClient_qaLearnSkill(3008)
    ToClient_qaLearnSkill(3009)
    ToClient_qaLearnSkill(3010)
    ToClient_qaLearnSkill(3011)
    ToClient_qaLearnSkill(3012)
    ToClient_qaLearnSkill(3013)
    ToClient_qaLearnSkill(3014)
    ToClient_qaLearnSkill(3015)
    ToClient_qaLearnSkill(3016)
    ToClient_qaLearnSkill(3017)
    ToClient_qaLearnSkill(3018)
    ToClient_qaLearnSkill(3019)
    ToClient_qaLearnSkill(3020)
    ToClient_qaLearnSkill(3021)
    ToClient_qaLearnSkill(3022)
    ToClient_qaLearnSkill(3023)
    ToClient_qaLearnSkill(3024)
    ToClient_qaLearnSkill(3025)
    ToClient_qaLearnSkill(3026)
    ToClient_qaLearnSkill(3027)
    ToClient_qaLearnSkill(3028)
    ToClient_qaLearnSkill(3029)
    ToClient_qaLearnSkill(3147)
    ToClient_qaLearnSkill(3148)
    ToClient_qaLearnSkill(3149)
    ToClient_qaLearnSkill(3150)
    ToClient_qaLearnSkill(3152)
    ToClient_qaLearnSkill(3221)
    ToClient_qaLearnSkill(3222)
    ToClient_qaLearnSkill(3223)
    ToClient_qaLearnSkill(3224)
    ToClient_qaLearnSkill(3225)
    ToClient_qaLearnSkill(3226)
    ToClient_qaLearnSkill(3227)
    ToClient_qaLearnSkill(3234)
    ToClient_qaLearnSkill(3235)
    ToClient_qaLearnSkill(3236)
    ToClient_qaLearnSkill(3237)
    ToClient_qaLearnSkill(3238)
    ToClient_qaLearnSkill(3239)
    ToClient_qaLearnSkill(3240)
    ToClient_qaLearnSkill(3241)
    ToClient_qaLearnSkill(3242)
    ToClient_qaLearnSkill(3243)
    ToClient_qaLearnSkill(3244)
    ToClient_qaLearnSkill(3245)
    ToClient_qaLearnSkill(3246)
    ToClient_qaLearnSkill(3247)
    ToClient_qaLearnSkill(3248)
    ToClient_qaLearnSkill(3249)
    ToClient_qaLearnSkill(3250)
    ToClient_qaLearnSkill(3251)
    ToClient_qaLearnSkill(3252)
    ToClient_qaLearnSkill(3253)
    ToClient_qaLearnSkill(3254)
    ToClient_qaLearnSkill(3255)
    ToClient_qaLearnSkill(3262)
    ToClient_qaLearnSkill(3263)
    ToClient_qaLearnSkill(3264)
    ToClient_qaLearnSkill(3265)
    ToClient_qaLearnSkill(3266)
    ToClient_qaLearnSkill(3267)
    ToClient_qaLearnSkill(3268)
    ToClient_qaLearnSkill(3269)
    ToClient_qaLearnSkill(3270)
    ToClient_qaLearnSkill(3271)
    ToClient_qaLearnSkill(3272)
    ToClient_qaLearnSkill(3273)
    ToClient_qaLearnSkill(3274)
    ToClient_qaLearnSkill(3275)
    ToClient_qaLearnSkill(3276)
    ToClient_qaLearnSkill(3277)
    ToClient_qaLearnSkill(3278)
    ToClient_qaLearnSkill(3279)
    ToClient_qaLearnSkill(3280)
    ToClient_qaLearnSkill(3281)
    ToClient_qaLearnSkill(3282)
    ToClient_qaLearnSkill(3283)
    ToClient_qaLearnSkill(3284)
    ToClient_qaLearnSkill(3285)
    ToClient_qaLearnSkill(3286)
    ToClient_qaLearnSkill(3287)
    ToClient_qaLearnSkill(3288)
    ToClient_qaLearnSkill(3289)
    ToClient_qaLearnSkill(3290)
    ToClient_qaLearnSkill(3291)
    ToClient_qaLearnSkill(3292)
    ToClient_qaLearnSkill(3293)
    ToClient_qaLearnSkill(3294)
    ToClient_qaLearnSkill(3295)
    ToClient_qaLearnSkill(3296)
    ToClient_qaLearnSkill(3297)
    ToClient_qaLearnSkill(3298)
    ToClient_qaLearnSkill(3323)
    ToClient_qaLearnSkill(3300)
    ToClient_qaLearnSkill(3301)
    ToClient_qaLearnSkill(3302)
    ToClient_qaLearnSkill(3303)
    ToClient_qaLearnSkill(3304)
    ToClient_qaLearnSkill(3305)
    ToClient_qaLearnSkill(3306)
    ToClient_qaLearnSkill(3307)
    ToClient_qaLearnSkill(3308)
    ToClient_qaLearnSkill(3309)
    ToClient_qaLearnSkill(3310)
    ToClient_qaLearnSkill(3311)
    ToClient_qaLearnSkill(3312)
    ToClient_qaLearnSkill(3313)
    ToClient_qaLearnSkill(3314)
    ToClient_qaLearnSkill(3315)
    ToClient_qaLearnSkill(3316)
    ToClient_qaLearnSkill(3317)
    ToClient_qaLearnSkill(3318)
    ToClient_qaLearnSkill(3319)
    ToClient_qaLearnSkill(3320)
    ToClient_qaLearnSkill(3321)
    ToClient_qaLearnSkill(3322)
    ToClient_qaLearnSkill(1702)
    ToClient_qaLearnSkill(1703)
    ToClient_qaLearnSkill(1704)
    ToClient_qaLearnSkill(1705)
    ToClient_qaLearnSkill(1706)
    ToClient_qaLearnSkill(1707)
    ToClient_qaLearnSkill(2072)
    ToClient_qaLearnSkill(2073)
    ToClient_qaLearnSkill(2074)
    ToClient_qaLearnSkill(2075)
    ToClient_qaLearnSkill(2076)
  end
end
function ReLocation()
  ToClient_qaTeleport(-411596, -1318, -433611)
end
function QAHuntPlaceTeleport(huntType)
  if nil == huntType then
    return
  end
  if 0 == huntType then
    ToClient_qaTeleport(1038052, -2803, -16098)
  elseif 1 == huntType then
    ToClient_qaTeleport(676679, 7353, 134956)
  elseif 2 == huntType then
    ToClient_qaTeleport(114377, -35512, 424727)
  end
end
function QAAutoCollect(inPutcollectCnt, qaEndurance)
  currnetCollectCnt = 0
  maxCollectCnt = inPutcollectCnt
  itemCngCnt = 0
  quickSlotCnt = 0
  qaEnduranceCnt = qaEndurance
  QAInteraction()
end
function QAInteraction()
  if currnetCollectCnt > maxCollectCnt then
    return
  end
  if itemCngCnt == qaEnduranceCnt * quickSlotCnt then
    QAchangeitem()
    return
  end
  Interaction_ExecuteByKeyMapping(CppEnums.ActionInputType.ActionInputType_Interaction)
  luaTimer_AddEvent(QAlootitem, 3000, false, 0)
  currnetCollectCnt = currnetCollectCnt + 1
  itemCngCnt = itemCngCnt + 1
end
function QAlootitem()
  if true == _ContentsGroup_NewUI_Looting then
    if nil ~= HandleEventLUp_Looting_All_LootAll then
      HandleEventLUp_Looting_All_LootAll(true)
    end
  elseif nil ~= Panel_Looting_buttonLootAll_Mouse_Click then
    Panel_Looting_buttonLootAll_Mouse_Click(true)
  end
  luaTimer_AddEvent(QAInteraction, 500, false, 0)
end
function QAchangeitem()
  quickSlot_UseSlot(quickSlotCnt)
  quickSlotCnt = quickSlotCnt + 1
  chatting_sendMessage("", "/mentalup 500", CppEnums.ChatType.Private)
  luaTimer_AddEvent(QAInteraction, 500, false, 0)
end
function setCameraCave()
  setYaw(4.027)
  setPitch(-0.132)
end
function setCameraVelia()
  setYaw(5.133)
  setPitch(-0.155)
end
function setCameraSwamp()
  setYaw(1.715)
  setPitch(-0.155)
end
function setCameraDesert()
  setYaw(3.88)
  setPitch(-0.205)
end
function teleporttocave()
  ToClient_qaTeleport(998041.3125, -4423.40332, 9660.620117)
  setFov(70)
  pa_sendMessage("/channelspawn 1")
  pa_sendMessage("/notify 1 \234\183\184\235\158\152\237\148\189 \237\133\140\236\138\164\237\138\184 \234\180\128\234\179\132\235\161\156 \236\158\160\236\139\156\235\143\153\236\149\136 \235\170\172\236\138\164\237\132\176 \236\138\164\237\143\176\236\157\132 \234\184\136\236\167\128\237\149\169\235\139\136\235\139\164.")
  setScreenResolution(1920, 1080)
  setWatermarkService(6)
  setScreenMode(1)
  setFov(70)
  setIsOnScreenSaver(False)
  setGraphicMedium1()
  setTextureHigh()
end
function teleporttoswamp()
  ToClient_qaTeleport(26554.455078, -2191.066406, -130726.859375)
end
function teleporttodesert()
  ToClient_qaTeleport(1137384.25, 9872.613281, 163545.921875)
  pa_sendMessage("/channelspawn 0")
  pa_sendMessage("/notify 1 \235\170\172\236\138\164\237\132\176 \236\138\164\237\143\176 \235\144\169\235\139\136\235\139\164")
  setGraphicVeryLow()
  setTextureHigh()
  setDofOff()
end
function teleporttovelia()
  ToClient_qaTeleport(4003.957031, -8217.459961, 85052.304688)
  setGraphicVeryLow()
  setTextureLow()
end
function setTextureLow()
  setTextureQuality(2)
end
function setTextureMedium()
  setTextureQuality(1)
end
function setTextureHigh()
  setTextureQuality(0)
end
function setGraphicVeryLow()
  setGraphicOption(6)
end
function setGraphicLow1()
  setGraphicOption(5)
end
function setGraphicMedium1()
  setGraphicOption(3)
end
function setGraphicHigh0()
  setGraphicOption(0)
end
function setDofOff()
  setDof(false)
end
function setDayTime()
  pa_sendMessage("/setgametime 13 00")
end
function setNightTime()
  pa_sendMessage("/setgametime 22 00")
end
function rainyWeather()
  pa_sendMessage("/weather create 0.5 0.5 10000 1")
end
function lowTemperature()
  pa_sendMessage("/weather change temperature -100 1")
end
function weatherClear()
  pa_sendMessage("/weather clear 1")
  pa_sendMessage("/weather change temperature 20 1")
end
function useQuickSlot1()
  quickSlot_UseSlot(0)
end
function useQuickSlot2()
  quickSlot_UseSlot(1)
end
function captureCave(value)
  local iwt = 0
  if nil == value then
    iwt = 0
  else
    iwt = value * 1000
  end
  local wt = iwt
  setScreenResolution(1920, 1080)
  setWatermarkService(6)
  setScreenMode(1)
  setFov(70)
  setIsOnScreenSaver(False)
  setGraphicMedium1()
  setTextureHigh()
  photoMode_On()
  setDofOff()
  luaTimer_AddEvent(setCameraCave, wt, false, 0)
  luaTimer_AddEvent(setDayTime, wt, false, 0)
  luaTimer_AddEvent(captureScreenShot, wt + 500, false, 0)
  luaTimer_AddEvent(setGraphicHigh0, wt + 1000, false, 0)
  luaTimer_AddEvent(setTextureLow, wt + 1000, false, 0)
  wt = iwt + wt + 1000
  luaTimer_AddEvent(setCameraCave, wt, false, 0)
  luaTimer_AddEvent(setNightTime, wt, false, 0)
  luaTimer_AddEvent(captureScreenShot, wt + 500, false, 0)
  luaTimer_AddEvent(teleporttoswamp, wt + 1000, false, 0)
end
function captureSwamp(value)
  local iwt = 0
  if nil == value then
    iwt = 0
  else
    iwt = value * 1000
  end
  local wt = iwt
  setScreenResolution(1920, 1080)
  setWatermarkService(6)
  setScreenMode(1)
  setFov(70)
  setIsOnScreenSaver(False)
  setGraphicHigh0()
  setTextureLow()
  photoMode_On()
  setDofOff()
  luaTimer_AddEvent(setCameraSwamp, wt, false, 0)
  luaTimer_AddEvent(setNightTime, wt, false, 0)
  luaTimer_AddEvent(captureScreenShot, wt + 500, false, 0)
  luaTimer_AddEvent(setGraphicLow1, wt + 1000, false, 0)
  luaTimer_AddEvent(setTextureHigh, wt + 1000, false, 0)
  wt = iwt + wt + 1000
  luaTimer_AddEvent(setCameraSwamp, wt, false, 0)
  luaTimer_AddEvent(setDayTime, wt, false, 0)
  luaTimer_AddEvent(captureScreenShot, wt + 500, false, 0)
  luaTimer_AddEvent(teleporttodesert, wt + 1000, false, 0)
end
function captureDesert(value)
  local iwt = 0
  if nil == value then
    iwt = 0
  else
    iwt = value * 1000
  end
  local wt = iwt
  setScreenResolution(1920, 1080)
  setWatermarkService(6)
  setScreenMode(1)
  setFov(70)
  setIsOnScreenSaver(False)
  setGraphicVeryLow()
  setTextureHigh()
  photoMode_On()
  setDofOff()
  luaTimer_AddEvent(setCameraDesert, wt, false, 0)
  luaTimer_AddEvent(setNightTime, wt, false, 0)
  luaTimer_AddEvent(captureScreenShot, wt + 500, false, 0)
  luaTimer_AddEvent(setGraphicMedium1, wt + 1000, false, 0)
  luaTimer_AddEvent(setTextureLow, wt + 1000, false, 0)
  wt = iwt + wt + 1000
  luaTimer_AddEvent(setCameraDesert, wt, false, 0)
  luaTimer_AddEvent(setDayTime, wt, false, 0)
  luaTimer_AddEvent(captureScreenShot, wt + 2000, false, 0)
  luaTimer_AddEvent(teleporttovelia, wt + 2500, false, 0)
end
function captureVelia(value)
  local iwt = 0
  if nil == value then
    iwt = 0
  else
    iwt = value * 1000
  end
  local wt = iwt
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  local isClassType = selfPlayer:getClassType()
  if isClassType == __eClassType_WizardWoman then
    setScreenResolution(1920, 1080)
    setWatermarkService(6)
    setScreenMode(1)
    setFov(70)
    setIsOnScreenSaver(False)
    setGraphicVeryLow()
    setTextureLow()
    photoMode_On()
    setDofOff()
    luaTimer_AddEvent(setCameraVelia, wt, false, 0)
    luaTimer_AddEvent(setNightTime, wt, false, 0)
    luaTimer_AddEvent(captureScreenShot, wt + 500, false, 0)
    luaTimer_AddEvent(useQuickSlot1, wt + 1000, false, 0)
    luaTimer_AddEvent(useQuickSlot2, wt + 3000, false, 0)
    luaTimer_AddEvent(captureScreenShot, wt + 6500, false, 0)
    luaTimer_AddEvent(setDayTime, wt + 18000, false, 0)
    luaTimer_AddEvent(captureScreenShot, wt + 18500, false, 0)
    luaTimer_AddEvent(useQuickSlot2, wt + 19000, false, 0)
    luaTimer_AddEvent(captureScreenShot, wt + 22500, false, 0)
    luaTimer_AddEvent(setGraphicLow1, wt + 23000, false, 0)
    luaTimer_AddEvent(setTextureHigh, wt + 23000, false, 0)
    wt = iwt + wt + 23000
    luaTimer_AddEvent(setCameraVelia, wt, false, 0)
    luaTimer_AddEvent(setNightTime, wt, false, 0)
    luaTimer_AddEvent(captureScreenShot, wt + 500, false, 0)
    luaTimer_AddEvent(setDayTime, wt + 1000, false, 0)
    luaTimer_AddEvent(captureScreenShot, wt + 1500, false, 0)
    luaTimer_AddEvent(setGraphicMedium1, wt + 2000, false, 0)
    wt = iwt + wt + 2000
    luaTimer_AddEvent(setCameraVelia, wt, false, 0)
    luaTimer_AddEvent(setNightTime, wt, false, 0)
    luaTimer_AddEvent(captureScreenShot, wt + 500, false, 0)
    luaTimer_AddEvent(setDayTime, wt + 1000, false, 0)
    luaTimer_AddEvent(captureScreenShot, wt + 1500, false, 0)
    luaTimer_AddEvent(setGraphicHigh0, wt + 2000, false, 0)
    luaTimer_AddEvent(setDofOff, wt + 2000, false, 0)
    wt = iwt + wt + 2000
    luaTimer_AddEvent(setCameraVelia, wt, false, 0)
    luaTimer_AddEvent(setNightTime, wt, false, 0)
    luaTimer_AddEvent(captureScreenShot, wt + 500, false, 0)
    luaTimer_AddEvent(useQuickSlot2, wt + 1000, false, 0)
    luaTimer_AddEvent(captureScreenShot, wt + 4500, false, 0)
    luaTimer_AddEvent(setDayTime, wt + 16000, false, 0)
    luaTimer_AddEvent(captureScreenShot, wt + 16500, false, 0)
    luaTimer_AddEvent(useQuickSlot2, wt + 17000, false, 0)
    luaTimer_AddEvent(captureScreenShot, wt + 20500, false, 0)
    luaTimer_AddEvent(rainyWeather, wt + 21000, false, 0)
    luaTimer_AddEvent(setDayTime, wt + 201000, false, 0)
    luaTimer_AddEvent(setCameraVelia, wt + 201000, false, 0)
    luaTimer_AddEvent(captureScreenShot, wt + 201500, false, 0)
    luaTimer_AddEvent(setGraphicVeryLow, wt + 202000, false, 0)
    luaTimer_AddEvent(setTextureLow, wt + 202000, false, 0)
    luaTimer_AddEvent(setDofOff, wt + 202000, false, 0)
    wt = iwt + wt + 202000
    luaTimer_AddEvent(setCameraVelia, wt, false, 0)
    luaTimer_AddEvent(setDayTime, wt, false, 0)
    luaTimer_AddEvent(captureScreenShot, wt + 500, false, 0)
    luaTimer_AddEvent(lowTemperature, wt + 1000, false, 0)
    luaTimer_AddEvent(setCameraVelia, wt + 181000, false, 0)
    luaTimer_AddEvent(setDayTime, wt + 181000, false, 0)
    luaTimer_AddEvent(captureScreenShot, wt + 181500, false, 0)
    luaTimer_AddEvent(setGraphicHigh0, wt + 182000, false, 0)
    luaTimer_AddEvent(setTextureHigh, wt + 182000, false, 0)
    luaTimer_AddEvent(setDofOff, wt + 182000, false, 0)
    wt = iwt + wt + 182000
    luaTimer_AddEvent(setCameraVelia, wt, false, 0)
    luaTimer_AddEvent(setDayTime, wt, false, 0)
    luaTimer_AddEvent(captureScreenShot, wt + 500, false, 0)
    luaTimer_AddEvent(photoMode_On, wt + 1000, false, 0)
    luaTimer_AddEvent(weatherClear, wt + 1000, false, 0)
  else
    Proc_ShowMessage_Ack("\236\156\132\236\185\152 \236\186\144\235\166\173\237\132\176\235\161\156 \236\160\145\236\134\141\237\149\180\236\149\188 \237\149\169\235\139\136\235\139\164.")
  end
end
function setremastered()
  FGlobal_Option_ResetAllOption()
  setGraphicOption(9)
  setTextureQuality(0)
  setAutoOptimization(false)
  setUseOptimizationEffectFrame(false)
  setUpscaleEnable(false)
  setUsePlayerOptimizationEffectFrame(false)
  setUseCharacterDistUpdate(false)
  setPresentLock(false)
  setTessellation(true)
  setRepresentative(true)
  setScreenResolution(1920, 1200)
  setScreenMode(2)
  setFov(50)
  setIsOnScreenSaver(False)
end
function createBossWeapon(enchantLevelA)
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  local isClassType = selfPlayer:getClassType()
  if isClassType == __eClassType_Warrior then
    ToClient_qaCreateItem(10010, enchantLevelA, 1)
    ToClient_qaCreateItem(715001, enchantLevelA, 1)
    ToClient_qaCreateItem(10138, enchantLevelA, 1)
    ToClient_qaCreateItem(10140, enchantLevelA, 1)
    ToClient_qaCreateItem(701081, enchantLevelA, 1)
    ToClient_qaCreateItem(701082, enchantLevelA, 1)
    ToClient_qaCreateItem(14702, enchantLevelA, 1)
    ToClient_qaCreateItem(550033, 0, 1)
  elseif isClassType == __eClassType_ElfRanger then
    ToClient_qaCreateItem(10210, enchantLevelA, 1)
    ToClient_qaCreateItem(715003, enchantLevelA, 1)
    ToClient_qaCreateItem(10338, enchantLevelA, 1)
    ToClient_qaCreateItem(10340, enchantLevelA, 1)
    ToClient_qaCreateItem(701083, enchantLevelA, 1)
    ToClient_qaCreateItem(701084, enchantLevelA, 1)
    ToClient_qaCreateItem(14732, enchantLevelA, 1)
    ToClient_qaCreateItem(550036, 0, 1)
  elseif isClassType == __eClassType_Sorcerer then
    ToClient_qaCreateItem(10410, enchantLevelA, 1)
    ToClient_qaCreateItem(715005, enchantLevelA, 1)
    ToClient_qaCreateItem(10538, enchantLevelA, 1)
    ToClient_qaCreateItem(10540, enchantLevelA, 1)
    ToClient_qaCreateItem(701085, enchantLevelA, 1)
    ToClient_qaCreateItem(701086, enchantLevelA, 1)
    ToClient_qaCreateItem(14712, enchantLevelA, 1)
    ToClient_qaCreateItem(550034, 0, 1)
  elseif isClassType == __eClassType_Giant then
    ToClient_qaCreateItem(10610, enchantLevelA, 1)
    ToClient_qaCreateItem(715007, enchantLevelA, 1)
    ToClient_qaCreateItem(10738, enchantLevelA, 1)
    ToClient_qaCreateItem(10740, enchantLevelA, 1)
    ToClient_qaCreateItem(701087, enchantLevelA, 1)
    ToClient_qaCreateItem(701088, enchantLevelA, 1)
    ToClient_qaCreateItem(14722, enchantLevelA, 1)
    ToClient_qaCreateItem(550035, 0, 1)
  elseif isClassType == __eClassType_Tamer then
    ToClient_qaCreateItem(13210, enchantLevelA, 1)
    ToClient_qaCreateItem(715009, enchantLevelA, 1)
    ToClient_qaCreateItem(13038, enchantLevelA, 1)
    ToClient_qaCreateItem(13040, enchantLevelA, 1)
    ToClient_qaCreateItem(701089, enchantLevelA, 1)
    ToClient_qaCreateItem(701090, enchantLevelA, 1)
    ToClient_qaCreateItem(14742, enchantLevelA, 1)
    ToClient_qaCreateItem(550037, 0, 1)
  elseif isClassType == __eClassType_BladeMaster then
    ToClient_qaCreateItem(13310, enchantLevelA, 1)
    ToClient_qaCreateItem(715011, enchantLevelA, 1)
    ToClient_qaCreateItem(13138, enchantLevelA, 1)
    ToClient_qaCreateItem(13140, enchantLevelA, 1)
    ToClient_qaCreateItem(701091, enchantLevelA, 1)
    ToClient_qaCreateItem(701092, enchantLevelA, 1)
    ToClient_qaCreateItem(14762, enchantLevelA, 1)
    ToClient_qaCreateItem(550039, 0, 1)
  elseif isClassType == __eClassType_Valkyrie then
    ToClient_qaCreateItem(10010, enchantLevelA, 1)
    ToClient_qaCreateItem(715001, enchantLevelA, 1)
    ToClient_qaCreateItem(10138, enchantLevelA, 1)
    ToClient_qaCreateItem(10140, enchantLevelA, 1)
    ToClient_qaCreateItem(701081, enchantLevelA, 1)
    ToClient_qaCreateItem(701082, enchantLevelA, 1)
    ToClient_qaCreateItem(14752, enchantLevelA, 1)
    ToClient_qaCreateItem(550038, 0, 1)
  elseif isClassType == __eClassType_BladeMasterWoman then
    ToClient_qaCreateItem(13310, enchantLevelA, 1)
    ToClient_qaCreateItem(715011, enchantLevelA, 1)
    ToClient_qaCreateItem(13138, enchantLevelA, 1)
    ToClient_qaCreateItem(13140, enchantLevelA, 1)
    ToClient_qaCreateItem(701091, enchantLevelA, 1)
    ToClient_qaCreateItem(701092, enchantLevelA, 1)
    ToClient_qaCreateItem(14772, enchantLevelA, 1)
    ToClient_qaCreateItem(550040, 0, 1)
  elseif isClassType == __eClassType_Kunoichi then
    ToClient_qaCreateItem(13210, enchantLevelA, 1)
    ToClient_qaCreateItem(715009, enchantLevelA, 1)
    ToClient_qaCreateItem(14538, enchantLevelA, 1)
    ToClient_qaCreateItem(14540, enchantLevelA, 1)
    ToClient_qaCreateItem(701093, enchantLevelA, 1)
    ToClient_qaCreateItem(701094, enchantLevelA, 1)
    ToClient_qaCreateItem(14792, enchantLevelA, 1)
    ToClient_qaCreateItem(550042, 0, 1)
  elseif isClassType == __eClassType_NinjaMan then
    ToClient_qaCreateItem(13210, enchantLevelA, 1)
    ToClient_qaCreateItem(715009, enchantLevelA, 1)
    ToClient_qaCreateItem(14638, enchantLevelA, 1)
    ToClient_qaCreateItem(14640, enchantLevelA, 1)
    ToClient_qaCreateItem(701095, enchantLevelA, 1)
    ToClient_qaCreateItem(701096, enchantLevelA, 1)
    ToClient_qaCreateItem(14782, enchantLevelA, 1)
    ToClient_qaCreateItem(550041, 0, 1)
  elseif isClassType == __eClassType_WizardWoman then
    ToClient_qaCreateItem(14410, enchantLevelA, 1)
    ToClient_qaCreateItem(715013, enchantLevelA, 1)
    ToClient_qaCreateItem(10338, enchantLevelA, 1)
    ToClient_qaCreateItem(10340, enchantLevelA, 1)
    ToClient_qaCreateItem(701083, enchantLevelA, 1)
    ToClient_qaCreateItem(701084, enchantLevelA, 1)
    ToClient_qaCreateItem(14802, enchantLevelA, 1)
    ToClient_qaCreateItem(550043, 0, 1)
  elseif isClassType == __eClassType_WizardMan then
    ToClient_qaCreateItem(14410, enchantLevelA, 1)
    ToClient_qaCreateItem(715013, enchantLevelA, 1)
    ToClient_qaCreateItem(10338, enchantLevelA, 1)
    ToClient_qaCreateItem(10340, enchantLevelA, 1)
    ToClient_qaCreateItem(701083, enchantLevelA, 1)
    ToClient_qaCreateItem(701084, enchantLevelA, 1)
    ToClient_qaCreateItem(14812, enchantLevelA, 1)
    ToClient_qaCreateItem(550044, 0, 1)
  elseif isClassType == __eClassType_DarkElf then
    ToClient_qaCreateItem(11360, enchantLevelA, 1)
    ToClient_qaCreateItem(715016, enchantLevelA, 1)
    ToClient_qaCreateItem(10738, enchantLevelA, 1)
    ToClient_qaCreateItem(10740, enchantLevelA, 1)
    ToClient_qaCreateItem(701087, enchantLevelA, 1)
    ToClient_qaCreateItem(701088, enchantLevelA, 1)
    ToClient_qaCreateItem(14817, enchantLevelA, 1)
    ToClient_qaCreateItem(550045, 0, 1)
  elseif isClassType == __eClassType_Combattant then
    ToClient_qaCreateItem(11210, enchantLevelA, 1)
    ToClient_qaCreateItem(715017, enchantLevelA, 1)
    ToClient_qaCreateItem(11338, enchantLevelA, 1)
    ToClient_qaCreateItem(11340, enchantLevelA, 1)
    ToClient_qaCreateItem(701097, enchantLevelA, 1)
    ToClient_qaCreateItem(701098, enchantLevelA, 1)
    ToClient_qaCreateItem(14822, enchantLevelA, 1)
    ToClient_qaCreateItem(550046, 0, 1)
  elseif isClassType == __eClassType_Mystic then
    ToClient_qaCreateItem(11210, enchantLevelA, 1)
    ToClient_qaCreateItem(715017, enchantLevelA, 1)
    ToClient_qaCreateItem(11338, enchantLevelA, 1)
    ToClient_qaCreateItem(11340, enchantLevelA, 1)
    ToClient_qaCreateItem(701097, enchantLevelA, 1)
    ToClient_qaCreateItem(701098, enchantLevelA, 1)
    ToClient_qaCreateItem(14830, enchantLevelA, 1)
    ToClient_qaCreateItem(550047, 0, 1)
  elseif isClassType == __eClassType_Lhan then
    ToClient_qaCreateItem(13410, enchantLevelA, 1)
    ToClient_qaCreateItem(715019, enchantLevelA, 1)
    ToClient_qaCreateItem(13538, enchantLevelA, 1)
    ToClient_qaCreateItem(13540, enchantLevelA, 1)
    ToClient_qaCreateItem(701099, enchantLevelA, 1)
    ToClient_qaCreateItem(701100, enchantLevelA, 1)
    ToClient_qaCreateItem(550502, enchantLevelA, 1)
    ToClient_qaCreateItem(550048, 0, 1)
  elseif isClassType == __eClassType_RangerMan then
    ToClient_qaCreateItem(13710, enchantLevelA, 1)
    ToClient_qaCreateItem(715021, enchantLevelA, 1)
    ToClient_qaCreateItem(13838, enchantLevelA, 1)
    ToClient_qaCreateItem(13840, enchantLevelA, 1)
    ToClient_qaCreateItem(701101, enchantLevelA, 1)
    ToClient_qaCreateItem(701102, enchantLevelA, 1)
    ToClient_qaCreateItem(13903, enchantLevelA, 1)
    ToClient_qaCreateItem(550049, 0, 1)
  elseif isClassType == __eClassType_ShyWaman then
    ToClient_qaCreateItem(718510, enchantLevelA, 1)
    ToClient_qaCreateItem(718616, enchantLevelA, 1)
    ToClient_qaCreateItem(719038, enchantLevelA, 1)
    ToClient_qaCreateItem(719040, enchantLevelA, 1)
    ToClient_qaCreateItem(719055, enchantLevelA, 1)
    ToClient_qaCreateItem(719056, enchantLevelA, 1)
    ToClient_qaCreateItem(690004, enchantLevelA, 1)
  elseif isClassType == __eClassType_Guardian then
    ToClient_qaCreateItem(690513, enchantLevelA, 1)
    ToClient_qaCreateItem(690563, enchantLevelA, 1)
    ToClient_qaCreateItem(10138, enchantLevelA, 1)
    ToClient_qaCreateItem(10140, enchantLevelA, 1)
    ToClient_qaCreateItem(701081, enchantLevelA, 1)
    ToClient_qaCreateItem(701082, enchantLevelA, 1)
    ToClient_qaCreateItem(691503, 20, 1)
  end
end
function equipAllItems(enchantLevel)
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  local isClassType = selfPlayer:getClassType()
  if isClassType == __eClassType_Warrior then
    ToClient_qaUseInventoryItem(10010, enchantLevel)
    ToClient_qaUseInventoryItem(10138, enchantLevel)
    ToClient_qaUseInventoryItem(14702, enchantLevel)
  elseif isClassType == __eClassType_ElfRanger then
    ToClient_qaUseInventoryItem(10210, enchantLevel)
    ToClient_qaUseInventoryItem(10338, enchantLevel)
    ToClient_qaUseInventoryItem(14732, enchantLevel)
  elseif isClassType == __eClassType_Sorcerer then
    ToClient_qaUseInventoryItem(10410, enchantLevel)
    ToClient_qaUseInventoryItem(10538, enchantLevel)
    ToClient_qaUseInventoryItem(14712, enchantLevel)
  elseif isClassType == __eClassType_Giant then
    ToClient_qaUseInventoryItem(10610, enchantLevel)
    ToClient_qaUseInventoryItem(10738, enchantLevel)
    ToClient_qaUseInventoryItem(14722, enchantLevel)
  elseif isClassType == __eClassType_Tamer then
    ToClient_qaUseInventoryItem(13210, enchantLevel)
    ToClient_qaUseInventoryItem(13038, enchantLevel)
    ToClient_qaUseInventoryItem(14742, enchantLevel)
  elseif isClassType == __eClassType_BladeMaster then
    ToClient_qaUseInventoryItem(13310, enchantLevel)
    ToClient_qaUseInventoryItem(13138, enchantLevel)
    ToClient_qaUseInventoryItem(14762, enchantLevel)
  elseif isClassType == __eClassType_Valkyrie then
    ToClient_qaUseInventoryItem(10010, enchantLevel)
    ToClient_qaUseInventoryItem(10138, enchantLevel)
    ToClient_qaUseInventoryItem(14752, enchantLevel)
  elseif isClassType == __eClassType_BladeMasterWoman then
    ToClient_qaUseInventoryItem(13310, enchantLevel)
    ToClient_qaUseInventoryItem(13138, enchantLevel)
    ToClient_qaUseInventoryItem(14772, enchantLevel)
  elseif isClassType == __eClassType_Kunoichi then
    ToClient_qaUseInventoryItem(13210, enchantLevel)
    ToClient_qaUseInventoryItem(14538, enchantLevel)
    ToClient_qaUseInventoryItem(14792, enchantLevel)
  elseif isClassType == __eClassType_NinjaMan then
    ToClient_qaUseInventoryItem(13210, enchantLevel)
    ToClient_qaUseInventoryItem(14638, enchantLevel)
    ToClient_qaUseInventoryItem(14782, enchantLevel)
  elseif isClassType == __eClassType_WizardWoman then
    ToClient_qaUseInventoryItem(14410, enchantLevel)
    ToClient_qaUseInventoryItem(10338, enchantLevel)
    ToClient_qaUseInventoryItem(14802, enchantLevel)
  elseif isClassType == __eClassType_WizardMan then
    ToClient_qaUseInventoryItem(14410, enchantLevel)
    ToClient_qaUseInventoryItem(10338, enchantLevel)
    ToClient_qaUseInventoryItem(14812, enchantLevel)
  elseif isClassType == __eClassType_DarkElf then
    ToClient_qaUseInventoryItem(11360, enchantLevel)
    ToClient_qaUseInventoryItem(10738, enchantLevel)
    ToClient_qaUseInventoryItem(14817, enchantLevel)
  elseif isClassType == __eClassType_Combattant then
    ToClient_qaUseInventoryItem(11210, enchantLevel)
    ToClient_qaUseInventoryItem(11338, enchantLevel)
    ToClient_qaUseInventoryItem(14822, enchantLevel)
  elseif isClassType == __eClassType_Mystic then
    ToClient_qaUseInventoryItem(11210, enchantLevel)
    ToClient_qaUseInventoryItem(11338, enchantLevel)
    ToClient_qaUseInventoryItem(14830, enchantLevel)
  elseif isClassType == __eClassType_Lhan then
    ToClient_qaUseInventoryItem(13410, enchantLevel)
    ToClient_qaUseInventoryItem(13538, enchantLevel)
    ToClient_qaUseInventoryItem(550502, enchantLevel)
  elseif isClassType == __eClassType_RangerMan then
    ToClient_qaUseInventoryItem(13710, enchantLevel)
    ToClient_qaUseInventoryItem(13838, enchantLevel)
    ToClient_qaUseInventoryItem(13903, enchantLevel)
  elseif isClassType == __eClassType_ShyWaman then
    ToClient_qaUseInventoryItem(718510, enchantLevel)
    ToClient_qaUseInventoryItem(719038, enchantLevel)
  elseif isClassType == __eClassType_Guardian then
    ToClient_qaUseInventoryItem(690513, enchantLevel)
    ToClient_qaUseInventoryItem(10138, enchantLevel)
    ToClient_qaUseInventoryItem(691503, enchantLevel)
  end
  ToClient_qaUseInventoryItem(11101, enchantLevel)
  ToClient_qaUseInventoryItem(11015, enchantLevel)
  ToClient_qaUseInventoryItem(11103, enchantLevel)
  ToClient_qaUseInventoryItem(11017, enchantLevel)
end
function equipAccessory(enchantLevel)
  if enchantLevel < 15 then
    enchantLevel = 15
  end
  luaTimer_AddEvent(ToClient_qaUseInventoryItem, 1000, false, 0, 11828, enchantLevel - 15)
  luaTimer_AddEvent(ToClient_qaUseInventoryItem, 1200, false, 0, 12031, enchantLevel - 15)
  luaTimer_AddEvent(ToClient_qaUseInventoryItem, 1400, false, 0, 12230, enchantLevel - 15)
  luaTimer_AddEvent(ToClient_qaUseInventoryItem, 1600, false, 0, 11607, enchantLevel - 15)
  luaTimer_AddEvent(ToClient_qaUseInventoryItem, 1800, false, 0, 11828, enchantLevel - 15)
  luaTimer_AddEvent(ToClient_qaUseInventoryItem, 2000, false, 0, 12031, enchantLevel - 15)
  luaTimer_AddEvent(ToClient_qaUseInventoryItem, 0, false, 0, 45332, 0)
end
function siegeready(siegetype)
  if siegetype == nil then
    Proc_ShowMessage_Ack("()\236\149\136\236\151\144 \234\179\181\236\132\177\236\160\132 \237\131\128\236\158\133\236\157\132 \236\158\133\235\160\165\237\149\180\236\163\188\236\132\184\236\154\148 \236\160\144\235\160\185:0 \234\177\176\236\160\144:1, 2, 3, 4 ")
    return
  elseif siegetype == 4 then
    EncreaseWeightBag()
    ToClient_qaCreateItem(56711, 0, 1)
    ToClient_qaCreateItem(56715, 0, 1)
    ToClient_qaCreateItem(51720, 0, 1)
    ToClient_qaCreateItem(56725, 0, 1)
    ToClient_qaCreateItem(56730, 0, 1)
    ToClient_qaCreateItem(56735, 0, 1)
    ToClient_qaCreateItem(56740, 0, 1)
    ToClient_qaCreateItem(56745, 0, 1)
    ToClient_qaCreateItem(56756, 0, 1)
    ToClient_qaCreateItem(56761, 0, 1)
    ToClient_qaCreateItem(56766, 0, 1)
  elseif siegetype == 3 then
    EncreaseWeightBag()
    ToClient_qaCreateItem(56710, 0, 1)
    ToClient_qaCreateItem(56714, 0, 1)
    ToClient_qaCreateItem(51719, 0, 1)
    ToClient_qaCreateItem(56724, 0, 1)
    ToClient_qaCreateItem(56729, 0, 1)
    ToClient_qaCreateItem(56734, 0, 1)
    ToClient_qaCreateItem(56739, 0, 1)
    ToClient_qaCreateItem(56744, 0, 1)
    ToClient_qaCreateItem(56755, 0, 1)
    ToClient_qaCreateItem(56760, 0, 1)
    ToClient_qaCreateItem(56765, 0, 1)
  elseif siegetype == 2 then
    EncreaseWeightBag()
    ToClient_qaCreateItem(56709, 0, 1)
    ToClient_qaCreateItem(56713, 0, 1)
    ToClient_qaCreateItem(51718, 0, 1)
    ToClient_qaCreateItem(56723, 0, 1)
    ToClient_qaCreateItem(56728, 0, 1)
    ToClient_qaCreateItem(56733, 0, 1)
    ToClient_qaCreateItem(56738, 0, 1)
    ToClient_qaCreateItem(56743, 0, 1)
    ToClient_qaCreateItem(56754, 0, 1)
    ToClient_qaCreateItem(56759, 0, 1)
    ToClient_qaCreateItem(56764, 0, 1)
  elseif siegetype == 1 then
    EncreaseWeightBag()
    ToClient_qaCreateItem(56708, 0, 1)
    ToClient_qaCreateItem(56712, 0, 1)
    ToClient_qaCreateItem(51717, 0, 1)
    ToClient_qaCreateItem(56722, 0, 1)
    ToClient_qaCreateItem(56727, 0, 1)
    ToClient_qaCreateItem(56732, 0, 1)
    ToClient_qaCreateItem(56737, 0, 1)
    ToClient_qaCreateItem(56742, 0, 1)
    ToClient_qaCreateItem(56753, 0, 1)
    ToClient_qaCreateItem(56758, 0, 1)
    ToClient_qaCreateItem(56763, 0, 1)
  elseif siegetype == 0 then
    EncreaseWeightBag()
    ToClient_qaCreateItem(56773, 0, 1)
    ToClient_qaCreateItem(56774, 0, 1)
    ToClient_qaCreateItem(56775, 0, 1)
    ToClient_qaCreateItem(56776, 0, 1)
    ToClient_qaCreateItem(56777, 0, 1)
    ToClient_qaCreateItem(56038, 0, 1)
    ToClient_qaCreateItem(56071, 0, 1)
    ToClient_qaCreateItem(56076, 0, 1)
    ToClient_qaCreateItem(56077, 0, 1)
    ToClient_qaCreateItem(51716, 0, 1)
    ToClient_qaCreateItem(56726, 0, 1)
    ToClient_qaCreateItem(56731, 0, 1)
    ToClient_qaCreateItem(56736, 0, 1)
    ToClient_qaCreateItem(56741, 0, 1)
    ToClient_qaCreateItem(56752, 0, 1)
    ToClient_qaCreateItem(56757, 0, 1)
    ToClient_qaCreateItem(56762, 0, 1)
    ToClient_qaCreateItem(56767, 0, 1)
    ToClient_qaCreateItem(56122, 0, 10)
    ToClient_qaCreateItem(56123, 0, 1)
    ToClient_qaCreateItem(56171, 0, 1)
    ToClient_qaCreateItem(56173, 0, 1)
  end
  ToClient_qaCreateItem(56003, 0, 10)
  ToClient_qaCreateItem(56051, 0, 10)
  ToClient_qaCreateItem(56052, 0, 10)
  ToClient_qaCreateItem(4077, 0, 200)
  ToClient_qaCreateItem(4257, 0, 200)
  ToClient_qaCreateItem(56067, 0, 10)
  ToClient_qaCreateItem(56068, 0, 10)
  ToClient_qaCreateItem(4052, 0, 200)
  ToClient_qaCreateItem(4057, 0, 200)
end
function PushJewelToItem(targetItemKey, jewelItemKey, enchantLevel)
  getSocketInformation():clearData()
  local itemWhereType = CppEnums.ItemWhereType.eInventory
  local itemSlotNo = CppEnums.TInventorySlotNoUndefined
  local jewelSlotNo = CppEnums.TInventorySlotNoUndefined
  local inventory = getSelfPlayer():get():getInventoryByType(itemWhereType)
  local findItemWrapper = function(itemWhereType, targetItemKey, targetEnchantLevel)
    local inventory = getSelfPlayer():get():getInventoryByType(itemWhereType)
    if nil == inventory then
      return false
    end
    local invenMaxSize = inventory:sizeXXX()
    for ii = 0, invenMaxSize - 1 do
      local itemWrapper = getInventoryItemByType(itemWhereType, ii)
      if nil ~= itemWrapper then
        local itemKey = itemWrapper:get():getKey():getItemKey()
        local enchantLevel = itemWrapper:get():getKey():getEnchantLevel()
        if itemKey == targetItemKey then
          if nil == targetEnchantLevel then
            return itemWrapper
          elseif nil ~= targetEnchantLevel and enchantLevel == targetEnchantLevel then
            return itemWrapper
          end
        end
      end
    end
    return nil
  end
  local itemWrapper1 = findItemWrapper(itemWhereType, targetItemKey)
  _PA_LOG("\234\185\128\235\179\145\237\152\184", "itemWrapper1 : " .. tostring(itemWrapper1))
  if nil ~= itemWrapper1 then
    itemSlotNo = inventory:getSlot(itemWrapper1:get():getKey())
    _PA_LOG("\234\185\128\235\179\145\237\152\184", "itemSlotNo : " .. tostring(itemSlotNo))
  end
  local itemWrapper2 = findItemWrapper(itemWhereType, jewelItemKey)
  if nil ~= itemWrapper2 then
    jewelSlotNo = inventory:getSlot(itemWrapper2:get():getKey())
    _PA_LOG("\234\185\128\235\179\145\237\152\184", "jewelSlotNo : " .. tostring(jewelSlotNo))
  end
  if itemSlotNo == CppEnums.TInventorySlotNoUndefined or jewelSlotNo == CppEnums.TInventorySlotNoUndefined then
    Proc_ShowMessage_Ack("\236\149\132\236\157\180\237\133\156\236\157\132 \236\176\190\236\157\132 \236\136\152 \236\151\134\236\138\181\235\139\136\235\139\164.")
    return
  end
  local rv = ToClient_PushJewelToItemForDev(itemWhereType, itemSlotNo, itemWhereType, jewelSlotNo)
  _PA_LOG("\234\185\128\235\179\145\237\152\184", "Error : " .. tostring(rv))
end
function maidtest()
  ToClient_qaCreateItem(149002, 0, 5)
  ToClient_qaCreateItem(149003, 0, 5)
  for i = 1, 5 do
    luaTimer_AddEvent(ToClient_qaUseInventoryItem, 5000 + i * 500, false, 0, 149002, 0)
    luaTimer_AddEvent(ToClient_qaUseInventoryItem, 5000 + i * 500, false, 0, 149003, 0)
  end
end
function dyingtest()
  ToClient_qaCreateItem(17116, 0, 1)
  ToClient_qaCreateItem(46054, 0, 1)
  ToClient_qaCreateItem(46203, 0, 1)
  ToClient_qaCreateItem(46358, 0, 1)
  ToClient_qaCreateItem(46461, 0, 1)
  ToClient_qaCreateItem(46520, 0, 1)
  ToClient_qaCreateItem(46710, 0, 1)
  ToClient_qaCreateItem(46854, 0, 1)
  ToClient_qaCreateItem(17318, 0, 10)
  ToClient_qaCreateItem(17319, 0, 1)
end
function enhancingtest()
  createBossWeapon(0)
  createBossWeapon(15)
  createBossWeapon(19)
  createBossArmor(0)
  createBossArmor(15)
  createBossArmor(19)
  ToClient_qaCreateItem(10069, 0, 1)
  ToClient_qaCreateItem(10069, 15, 1)
  ToClient_qaCreateItem(10069, 19, 1)
  ToClient_qaCreateItem(10961, 0, 1)
  ToClient_qaCreateItem(10961, 15, 1)
  ToClient_qaCreateItem(10961, 19, 1)
  ToClient_qaCreateItem(12031, 3, 1)
  ToClient_qaCreateItem(12031, 0, 2)
  ToClient_qaCreateItem(11607, 3, 1)
  ToClient_qaCreateItem(11607, 0, 2)
  ToClient_qaCreateItem(16001, 0, 100)
  ToClient_qaCreateItem(16002, 0, 100)
  ToClient_qaCreateItem(16004, 0, 100)
  ToClient_qaCreateItem(16005, 0, 100)
  ToClient_qaCreateItem(5000, 0, 100)
  ToClient_qaCreateItem(4987, 0, 100)
  ToClient_qaCreateItem(752021, 0, 100)
  ToClient_qaCreateItem(16080, 0, 20000)
  ToClient_qaCreateItem(721003, 0, 100000)
  ToClient_qaCreateItem(4906, 0, 1)
  ToClient_qaCreateItem(4907, 0, 1)
  ToClient_qaCreateItem(4912, 0, 1)
  ToClient_qaCreateItem(4913, 0, 1)
  ToClient_qaCreateItem(4929, 0, 2)
  ToClient_qaCreateItem(320060, 0, 2)
  ToClient_qaCreateItem(17000, 0, 100)
  ToClient_qaCreateItem(15801, 0, 2)
  ToClient_qaCreateItem(15813, 0, 2)
  ToClient_qaCreateItem(44195, 0, 100)
  ToClient_qaCreateItem(17598, 0, 100)
  ToClient_qaCreateItem(289200, 0, 100)
  ToClient_qaCreateItem(17900, 0, 100)
  ToClient_qaCreateItem(289907, 0, 100)
  ToClient_qaCreateItem(16000, 0, 5)
end
function fishingtest()
  pa_sendMessage("/lifelvup 81 1")
  ToClient_qaCreateItem(65488, 0, 1)
  ToClient_qaCreateItem(16153, 0, 1)
  ToClient_qaCreateItem(16162, 10, 1)
  ToClient_qaCreateItem(16164, 10, 1)
  ToClient_qaCreateItem(16165, 10, 1)
  ToClient_qaCreateItem(16441, 1, 1)
  ToClient_qaCreateItem(16167, 10, 1)
  ToClient_qaCreateItem(16168, 10, 1)
  ToClient_qaCreateItem(14020, 0, 1)
  ToClient_qaCreateItem(14020, 1, 1)
  ToClient_qaCreateItem(14020, 2, 1)
  ToClient_qaCreateItem(14020, 3, 1)
  ToClient_qaCreateItem(14020, 4, 1)
  ToClient_qaCreateItem(14020, 5, 1)
  ToClient_qaCreateItem(17555, 0, 10)
  ToClient_qaCreateItem(705052, 15, 1)
  ToClient_qaCreateItem(705052, 16, 1)
  ToClient_qaCreateItem(705052, 17, 1)
  ToClient_qaCreateItem(705052, 18, 1)
  ToClient_qaCreateItem(705052, 19, 1)
  ToClient_qaCreateItem(705052, 20, 1)
  ToClient_qaCreateItem(65424, 0, 100)
  ToClient_qaCreateItem(12831, 0, 1)
  ToClient_qaCreateItem(44940, 0, 1)
end
function harvesttest()
  chatting_sendMessage("", "/lifelvup 51 8", CppEnums.ChatType.Public)
  ToClient_qaCreateItem(58001, 0, 1)
  ToClient_qaCreateItem(58002, 0, 1)
  ToClient_qaCreateItem(58012, 0, 1)
  local seedRanNum1 = math.random(1, 23)
  ToClient_qaCreateItem(6700 + seedRanNum1, 0, 10)
  ToClient_qaCreateItem(6800 + seedRanNum1, 0, 10)
  ToClient_qaCreateItem(6750 + seedRanNum1, 0, 2)
  ToClient_qaCreateItem(65425, 0, 3)
  local seedRanNum2 = math.random(1, 3)
  ToClient_qaCreateItem(7022 + seedRanNum2, 0, 10)
  ToClient_qaCreateItem(6656, 0, 10)
  for i = 1, 3 do
    ToClient_qaCreateItem(16900 + i, 0, 5)
  end
  ToClient_qaCreateItem(16910, 0, 1)
  ToClient_qaCreateItem(16911, 0, 1)
  ToClient_qaCreateItem(4605, 0, 100)
  local fenceRanNum = math.random(1, 2)
  if fenceRanNum == 1 then
    ToClient_qaTeleport(9233, -6049, 70372)
  elseif fenceRanNum == 2 then
    ToClient_qaTeleport(16904, -790, -105316)
  end
end
function questtest()
  ToClient_qaCompleteQuest(677, 1)
  ToClient_qaCreateItem(44192, 0, 10)
  ToClient_qaCreateItem(11813, 0, 1)
  ToClient_qaAcceptQuest(3510, 94)
  ToClient_qaCompleteQuest(663, 9)
end
function gatheringtest()
  ToClient_qaCreateItem(14022, 5, 1)
  ToClient_qaCreateItem(705517, 16, 1)
  ToClient_qaCreateItem(705517, 17, 1)
  ToClient_qaCreateItem(705517, 18, 1)
  ToClient_qaCreateItem(705517, 19, 1)
  ToClient_qaCreateItem(705517, 20, 1)
  ToClient_qaCreateItem(16479, 19, 1)
  ToClient_qaCreateItem(16481, 19, 1)
  ToClient_qaCreateItem(16482, 19, 1)
  ToClient_qaCreateItem(16486, 19, 1)
  ToClient_qaCreateItem(16487, 19, 1)
  ToClient_qaCreateItem(16847, 19, 1)
  ToClient_qaCreateItem(16829, 0, 1)
  ToClient_qaCreateItem(16830, 0, 1)
  ToClient_qaCreateItem(16831, 0, 1)
  ToClient_qaCreateItem(16832, 0, 1)
  ToClient_qaCreateItem(16833, 0, 1)
  ToClient_qaCreateItem(16834, 0, 1)
  pa_sendMessage("/lifelvup 51 0")
end
function alchemytest(number)
  if nil == number then
    number = 1
  end
  ToClient_qaCreateItem(3744, 0, 2)
  ToClient_qaCreateItem(14025, 5, 1)
  ToClient_qaCreateItem(705047, 16, 1)
  ToClient_qaCreateItem(705047, 17, 1)
  ToClient_qaCreateItem(705047, 18, 1)
  ToClient_qaCreateItem(705047, 19, 1)
  ToClient_qaCreateItem(705047, 20, 1)
  ToClient_qaCreateItem(45802, 0, 1)
  local alchemyRanNum = math.random(1, 4)
  if alchemyRanNum == 1 then
    ToClient_qaCreateItem(5005, 0, 1 * number)
    ToClient_qaCreateItem(4802, 0, 1 * number)
    ToClient_qaCreateItem(5301, 0, 1 * number)
    ToClient_qaCreateItem(6201, 0, 2 * number)
    Proc_ShowMessage_Ack("'\236\163\132\236\157\184\236\157\152 \237\152\136\236\149\161'\236\157\132 \235\167\140\235\147\164\236\150\180 \236\163\188\236\132\184\236\154\148.")
  elseif alchemyRanNum == 2 then
    ToClient_qaCreateItem(6355, 0, 1 * number)
    ToClient_qaCreateItem(4805, 0, 2 * number)
    ToClient_qaCreateItem(5403, 0, 6 * number)
    ToClient_qaCreateItem(5002, 0, 5 * number)
    Proc_ShowMessage_Ack("'\236\132\184\236\155\148\236\157\152 \235\185\132\236\149\189'\236\157\132 \235\167\140\235\147\164\236\150\180 \236\163\188\236\132\184\236\154\148.")
  elseif alchemyRanNum == 3 then
    ToClient_qaCreateItem(6603, 0, 1 * number)
    ToClient_qaCreateItem(5302, 0, 6 * number)
    ToClient_qaCreateItem(5411, 0, 4 * number)
    ToClient_qaCreateItem(5007, 0, 3 * number)
    ToClient_qaCreateItem(5957, 0, 3 * number)
    Proc_ShowMessage_Ack("'\236\130\172\236\139\160\236\157\152 \235\185\132\236\149\189'\236\157\132 \235\167\140\235\147\164\236\150\180 \236\163\188\236\132\184\236\154\148.")
  elseif alchemyRanNum == 4 then
    ToClient_qaCreateItem(5439, 0, 1 * number)
    ToClient_qaCreateItem(5401, 0, 1 * number)
    ToClient_qaCreateItem(9001, 0, 1 * number)
    ToClient_qaCreateItem(6656, 0, 1 * number)
    Proc_ShowMessage_Ack("'\235\167\145\236\157\128 \236\149\161\236\178\180 \236\139\156\236\149\189'\236\157\132 \235\167\140\235\147\164\236\150\180 \236\163\188\236\132\184\236\154\148.")
  end
end
function huntingtest()
  ToClient_qaCreateItem(16157, 0, 1)
  ToClient_qaCreateItem(16161, 10, 1)
  ToClient_qaCreateItem(56133, 10, 1)
  ToClient_qaCreateItem(705022, 15, 1)
  ToClient_qaCreateItem(705022, 16, 1)
  ToClient_qaCreateItem(705022, 17, 1)
  ToClient_qaCreateItem(705022, 18, 1)
  ToClient_qaCreateItem(705022, 19, 1)
  ToClient_qaCreateItem(705022, 20, 1)
  ToClient_qaCreateItem(16487, 19, 1)
  ToClient_qaCreateItem(16831, 0, 1)
  ToClient_qaCreateItem(65410, 0, 1)
  ToClient_qaCreateItem(44944, 0, 1)
  chatting_sendMessage("", "/lifelvup 80 2", CppEnums.ChatType.Public)
end
function processingtest()
  chatting_sendMessage("", "/lifelvup 100 7", CppEnums.ChatType.Public)
  chatting_sendMessage("", "/create item 36554~36567 1", CppEnums.ChatType.Public)
  ToClient_qaCreateItem(705518, 20, 1)
  ToClient_qaCreateItem(14026, 5, 1)
  ToClient_qaCreateItem(44943, 0, 1)
  ToClient_qaCreateItem(720501, 20, 1)
  ToClient_qaCreateItem(720502, 20, 1)
  ToClient_qaCreateItem(720503, 20, 1)
  ToClient_qaCreateItem(720504, 20, 1)
  ToClient_qaCreateItem(720505, 20, 1)
  ToClient_qaCreateItem(720506, 20, 1)
  local pRanNum = math.random(1, 4)
  if pRanNum == 1 then
    ToClient_qaCreateItem(9061, 0, 1000)
    ToClient_qaCreateItem(9001, 0, 1000)
    Proc_ShowMessage_Ack("\235\178\132\237\132\176 \234\176\128\234\179\181 : \237\129\172\235\166\188, \236\134\140\234\184\136\236\156\188\235\161\156 \237\157\148\235\147\164\236\150\180 \236\132\158\234\184\176")
    luaTimer_AddEvent(ToClient_qaUseInventoryItem, 1000, false, 0, 11828, enchantLevel - 15)
  elseif pRanNum == 2 then
    ToClient_qaCreateItem(16001, 0, 1000)
    Proc_ShowMessage_Ack("\235\184\148\235\158\153\236\138\164\237\134\164 \234\176\128\235\163\168 \234\176\128\234\179\181 : \235\184\148\235\158\153\236\138\164\237\134\164(\235\172\180\234\184\176) \235\185\187\234\184\176.")
  elseif pRanNum == 3 then
    ToClient_qaCreateItem(4605, 0, 1000)
    Proc_ShowMessage_Ack("\236\147\184\235\167\140\237\149\156 \234\176\129\235\170\169 \234\176\128\234\179\181 : \237\134\181\235\130\152\235\172\180 \236\158\165\236\158\145\237\140\168\234\184\176.")
  elseif pRanNum == 4 then
    ToClient_qaCreateItem(5802, 0, 1000)
    Proc_ShowMessage_Ack("\236\149\132\235\167\136\236\139\164 \234\176\128\234\179\181 : \236\149\132\235\167\136 \234\176\128\236\151\180\237\149\152\234\184\176.")
  end
end
function cooktest(number)
  if nil == number then
    number = 1
  end
  ToClient_qaCreateItem(3743, 0, 3)
  ToClient_qaCreateItem(14019, 5, 1)
  ToClient_qaCreateItem(705037, 16, 1)
  ToClient_qaCreateItem(705037, 17, 1)
  ToClient_qaCreateItem(705037, 18, 1)
  ToClient_qaCreateItem(705037, 19, 1)
  ToClient_qaCreateItem(705037, 20, 1)
  local cookRanNum = math.random(1, 10)
  if cookRanNum == 1 then
    ToClient_qaCreateItem(7005, 0, 5 * number)
    ToClient_qaCreateItem(9059, 0, 6 * number)
    ToClient_qaCreateItem(9002, 0, 1 * number)
    ToClient_qaCreateItem(9005, 0, 2 * number)
    Proc_ShowMessage_Ack("'\235\167\165\236\163\188'\235\165\188 " .. tostring(number) .. "\234\176\156 \235\167\140\235\147\164\236\150\180 \236\163\188\236\132\184\236\154\148.")
  elseif cookRanNum == 2 then
    ToClient_qaCreateItem(9270, 0, 2 * number)
    ToClient_qaCreateItem(7105, 0, 2 * number)
    ToClient_qaCreateItem(9065, 0, 3 * number)
    ToClient_qaCreateItem(7702, 0, 3 * number)
    Proc_ShowMessage_Ack("'\235\176\128\237\129\172\237\139\176'\235\165\188 " .. tostring(number) .. "\234\176\156 \235\167\140\235\147\164\236\150\180 \236\163\188\236\132\184\236\154\148.")
  elseif cookRanNum == 3 then
    ToClient_qaCreateItem(7026, 0, 3 * number)
    ToClient_qaCreateItem(9064, 0, 2 * number)
    ToClient_qaCreateItem(9016, 0, 4 * number)
    ToClient_qaCreateItem(7205, 0, 3 * number)
    ToClient_qaCreateItem(8201, 0, 1 * number)
    Proc_ShowMessage_Ack("'\236\189\148\236\189\148\235\132\155 \236\131\157\236\132\160 \237\138\128\234\185\128'\236\157\132 " .. tostring(number) .. "\234\176\156 \235\167\140\235\147\164\236\150\180 \236\163\188\236\132\184\236\154\148.")
  elseif cookRanNum == 4 then
    ToClient_qaCreateItem(7906, 0, 5 * number)
    ToClient_qaCreateItem(7105, 0, 2 * number)
    ToClient_qaCreateItem(9017, 0, 2 * number)
    ToClient_qaCreateItem(9059, 0, 3 * number)
    Proc_ShowMessage_Ack("'\235\175\184\237\138\184 \236\138\164\237\138\156'\235\165\188 " .. tostring(number) .. "\234\176\156 \235\167\140\235\147\164\236\150\180 \236\163\188\236\132\184\236\154\148.")
  elseif cookRanNum == 5 then
    ToClient_qaCreateItem(9203, 0, 1 * number)
    ToClient_qaCreateItem(9404, 0, 1 * number)
    ToClient_qaCreateItem(9417, 0, 1 * number)
    ToClient_qaCreateItem(9241, 0, 2 * number)
    ToClient_qaCreateItem(9213, 0, 2 * number)
    Proc_ShowMessage_Ack("'\235\176\156\235\160\136\235\133\184\236\138\164 \236\160\149\236\139\157'\236\157\132 " .. tostring(number) .. "\234\176\156 \235\167\140\235\147\164\236\150\180 \236\163\188\236\132\184\236\154\148.")
  elseif cookRanNum == 6 then
    ToClient_qaCreateItem(7923, 0, 4 * number)
    ToClient_qaCreateItem(9202, 0, 2 * number)
    ToClient_qaCreateItem(9214, 0, 4 * number)
    ToClient_qaCreateItem(7020, 0, 3 * number)
    Proc_ShowMessage_Ack("'\236\160\149\234\184\128\236\157\152 \236\153\149 \237\150\132\235\178\132\234\183\184'\235\165\188 " .. tostring(number) .. "\234\176\156 \235\167\140\235\147\164\236\150\180 \236\163\188\236\132\184\236\154\148.")
  elseif cookRanNum == 7 then
    ToClient_qaCreateItem(9422, 0, 1 * number)
    ToClient_qaCreateItem(9261, 0, 1 * number)
    ToClient_qaCreateItem(9427, 0, 2 * number)
    ToClient_qaCreateItem(9425, 0, 1 * number)
    ToClient_qaCreateItem(9262, 0, 2 * number)
    Proc_ShowMessage_Ack("'\235\169\148\235\148\148\236\149\132 \236\160\149\236\139\157'\236\157\132 " .. tostring(number) .. "\234\176\156 \235\167\140\235\147\164\236\150\180 \236\163\188\236\132\184\236\154\148.")
  elseif cookRanNum == 8 then
    ToClient_qaCreateItem(7906, 0, 6 * number)
    ToClient_qaCreateItem(8201, 0, 1 * number)
    ToClient_qaCreateItem(9059, 0, 3 * number)
    ToClient_qaCreateItem(7105, 0, 4 * number)
    Proc_ShowMessage_Ack("'\236\162\139\236\157\128 \236\130\172\235\163\140'\235\165\188 " .. tostring(number) .. "\234\176\156 \235\167\140\235\147\164\236\150\180 \236\163\188\236\132\184\236\154\148.")
  elseif cookRanNum == 9 then
    ToClient_qaCreateItem(7908, 0, 6 * number)
    ToClient_qaCreateItem(7205, 0, 6 * number)
    ToClient_qaCreateItem(7348, 0, 1 * number)
    ToClient_qaCreateItem(9015, 0, 2 * number)
    Proc_ShowMessage_Ack("'\236\130\172\235\167\137 \235\167\140\235\145\144'\235\165\188 " .. tostring(number) .. "\234\176\156 \235\167\140\235\147\164\236\150\180 \236\163\188\236\132\184\236\154\148.")
  elseif cookRanNum == 10 then
    ToClient_qaCreateItem(7105, 0, 1 * number)
    ToClient_qaCreateItem(7313, 0, 1 * number)
    ToClient_qaCreateItem(9005, 0, 1 * number)
    Proc_ShowMessage_Ack("'\236\136\160\236\157\152 \236\160\149\236\136\152'\235\165\188 " .. tostring(number) .. "\234\176\156 \235\167\140\235\147\164\236\150\180 \236\163\188\236\132\184\236\154\148.")
  end
end
function tradetest()
  ToClient_qaCompleteQuest(21001, 1)
  ToClient_qaCompleteQuest(5801, 4)
  chatting_sendMessage("", "/lifelvup 52 7", CppEnums.ChatType.Public)
  ToClient_qaCreateItem(55158, 0, 1)
  chatting_sendMessage("", "/teleport 40010 1", CppEnums.ChatType.Public)
end
function illegalTradeTest()
  chatting_sendMessage("", "\235\176\128\235\172\180\236\151\173 \237\133\140\236\138\164\237\138\184\235\161\156 \234\178\140\236\158\132\236\139\156\234\176\132 \235\176\164\236\156\188\235\161\156 \235\179\128\234\178\189\237\149\152\234\178\160\236\138\181\235\139\136\235\139\164.", CppEnums.ChatType.World)
  chatting_sendMessage("", "/setgametime 22 0", CppEnums.ChatType.Public)
  chatting_sendMessage("", "/lifelvup 52 7", CppEnums.ChatType.Public)
  chatting_sendMessage("", "/teleport 45204 1", CppEnums.ChatType.Public)
end
function imperialTradeTest()
  ToClient_qaCreateItem(55201, 0, 1)
  ToClient_qaCreateItem(9801, 0, 3)
  chatting_sendMessage("", "/teleport 41120 1", CppEnums.ChatType.Public)
end
function PaGlobalFunc_QaCreateAndEquip(enchantLeve1)
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  UnEquipAllQATEST()
  luaTimer_AddEvent(equipAutoAllItem, 5000, false, 0, enchantLeve1)
end
function PaGlobalFunc_QaEquipBossWeapon(enchantLeve1)
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  local isClassType = selfPlayer:getClassType()
  if isClassType == __eClassType_Warrior then
    ToClient_qaUseInventoryItem(10010, enchantLeve1)
    ToClient_qaUseInventoryItem(10138, enchantLeve1)
    ToClient_qaUseInventoryItem(14702, enchantLeve1)
  elseif isClassType == __eClassType_ElfRanger then
    ToClient_qaUseInventoryItem(10210, enchantLeve1)
    ToClient_qaUseInventoryItem(10338, enchantLeve1)
    ToClient_qaUseInventoryItem(14732, enchantLeve1)
  elseif isClassType == __eClassType_Sorcerer then
    ToClient_qaUseInventoryItem(10410, enchantLeve1)
    ToClient_qaUseInventoryItem(10538, enchantLeve1)
    ToClient_qaUseInventoryItem(14712, enchantLeve1)
  elseif isClassType == __eClassType_Giant then
    ToClient_qaUseInventoryItem(10610, enchantLeve1)
    ToClient_qaUseInventoryItem(10738, enchantLeve1)
    ToClient_qaUseInventoryItem(14722, enchantLeve1)
  elseif isClassType == __eClassType_Tamer then
    ToClient_qaUseInventoryItem(13210, enchantLeve1)
    ToClient_qaUseInventoryItem(13038, enchantLeve1)
    ToClient_qaUseInventoryItem(14742, enchantLeve1)
  elseif isClassType == __eClassType_BladeMaster then
    ToClient_qaUseInventoryItem(13310, enchantLeve1)
    ToClient_qaUseInventoryItem(13138, enchantLeve1)
    ToClient_qaUseInventoryItem(14762, enchantLeve1)
  elseif isClassType == __eClassType_Valkyrie then
    ToClient_qaUseInventoryItem(10010, enchantLeve1)
    ToClient_qaUseInventoryItem(10138, enchantLeve1)
    ToClient_qaUseInventoryItem(14752, enchantLeve1)
  elseif isClassType == __eClassType_BladeMasterWoman then
    ToClient_qaUseInventoryItem(13310, enchantLeve1)
    ToClient_qaUseInventoryItem(13138, enchantLeve1)
    ToClient_qaUseInventoryItem(14772, enchantLeve1)
  elseif isClassType == __eClassType_Kunoichi then
    ToClient_qaUseInventoryItem(13210, enchantLeve1)
    ToClient_qaUseInventoryItem(14538, enchantLeve1)
    ToClient_qaUseInventoryItem(14792, enchantLeve1)
  elseif isClassType == __eClassType_NinjaMan then
    ToClient_qaUseInventoryItem(13210, enchantLeve1)
    ToClient_qaUseInventoryItem(14638, enchantLeve1)
    ToClient_qaUseInventoryItem(14782, enchantLeve1)
  elseif isClassType == __eClassType_WizardWoman then
    ToClient_qaUseInventoryItem(14410, enchantLeve1)
    ToClient_qaUseInventoryItem(10338, enchantLeve1)
    ToClient_qaUseInventoryItem(14802, enchantLeve1)
  elseif isClassType == __eClassType_WizardMan then
    ToClient_qaUseInventoryItem(14410, enchantLeve1)
    ToClient_qaUseInventoryItem(10338, enchantLeve1)
    ToClient_qaUseInventoryItem(14812, enchantLeve1)
  elseif isClassType == __eClassType_DarkElf then
    ToClient_qaUseInventoryItem(11360, enchantLeve1)
    ToClient_qaUseInventoryItem(10738, enchantLeve1)
    ToClient_qaUseInventoryItem(14817, enchantLeve1)
  elseif isClassType == __eClassType_Combattant then
    ToClient_qaUseInventoryItem(11210, enchantLeve1)
    ToClient_qaUseInventoryItem(11338, enchantLeve1)
    ToClient_qaUseInventoryItem(14822, enchantLeve1)
  elseif isClassType == __eClassType_Mystic then
    ToClient_qaUseInventoryItem(11210, enchantLeve1)
    ToClient_qaUseInventoryItem(11338, enchantLeve1)
    ToClient_qaUseInventoryItem(14830, enchantLeve1)
  elseif isClassType == __eClassType_Lhan then
    ToClient_qaUseInventoryItem(13410, enchantLeve1)
    ToClient_qaUseInventoryItem(13538, enchantLeve1)
    ToClient_qaUseInventoryItem(550502, enchantLeve1)
  elseif isClassType == __eClassType_RangerMan then
    ToClient_qaUseInventoryItem(13710, enchantLeve1)
    ToClient_qaUseInventoryItem(13838, enchantLeve1)
    ToClient_qaUseInventoryItem(13903, enchantLeve1)
  end
end
function PaGlobalFunc_QaEquipBossArmor(enchantLeve1)
  ToClient_qaUseInventoryItem(11015, enchantLeve1)
  ToClient_qaUseInventoryItem(11017, enchantLeve1)
  ToClient_qaUseInventoryItem(11101, enchantLeve1)
  ToClient_qaUseInventoryItem(11103, enchantLeve1)
end
function PaGlobalFunc_QaEquipAccessory1(enchantLeve1)
  local castAccessoryEnchant = enchantLeve1 - 15
  ToClient_qaUseInventoryItem(12230, castAccessoryEnchant)
  ToClient_qaUseInventoryItem(11607, castAccessoryEnchant)
end
function PaGlobalFunc_QaEquipAccessory2(enchantLeve1)
  local castAccessoryEnchant = enchantLeve1 - 15
  ToClient_qaUseInventoryItem(12031, castAccessoryEnchant)
  ToClient_qaUseInventoryItem(11828, castAccessoryEnchant)
end
function setYaw(value)
  selfPlayerSetCameraYaw(value)
end
function setPitch(value)
  selfPlayerSetCameraPich(value)
end
function setRoll(value)
  selfPlayerSetCameraRoll(value)
end
function captureScreenShot()
  ToClient_CaptureByFrameCheck()
end
function photoMode_On()
  ToClient_InputPhotoModeFromLua()
end
function pa_sendMessage(message)
  local memoryChatType = 1
  local target = ""
  chatting_sendMessage(target, message, memoryChatType)
  chatting_saveMessageHistory(target, message)
end
function pa_useQuickSlot(num)
  QuickSlot_DropHandler(num)
end
function joinBR(mode)
  ToClient_JoinBattleRoyaleMode(mode)
end
function joinbroc()
  ToClient_RequestBattleRoyaleJoinToAnotherChannel()
end
function exitbroc()
  ToClient_RequestBattleRoyaleExitToBeforeServer()
end
function brchange(no, findex, state)
  ToClient_BattleRoyaleStateChange(no, findex, state)
end
QASupportDamageWriter2 = {}
local filePath = "D:\\Trunk\\UI_Data\\Script\\QASupport\\LogQASupportDamageWriter\\"
local file
local fileNum = 0
local fileText = "test.txt"
local Mindamage = 0
local Maxdamage = 0
SumCountDamage = 0
local QAtargetPV = 0
local QAtargetDV = 0
local QAtargetMaxHp = 0
function QASupportDamageWriter2:write(text)
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  local isClassType = selfPlayer:getClassType()
  if isClassType == __eClassType_Warrior then
    fileText = "Warrior.txt"
  elseif isClassType == __eClassType_ElfRanger then
    fileText = "ElfRanger.txt"
  elseif isClassType == __eClassType_Sorcerer then
    fileText = "Sorcerer.txt"
  elseif isClassType == __eClassType_Giant then
    fileText = "Giant.txt"
  elseif isClassType == __eClassType_Tamer then
    fileText = "Tamer.txt"
  elseif isClassType == __eClassType_BladeMaster then
    fileText = "Musa.txt"
  elseif isClassType == __eClassType_Valkyrie then
    fileText = "Valkiry.txt"
  elseif isClassType == __eClassType_BladeMasterWoman then
    fileText = "Maehwa.txt"
  elseif isClassType == __eClassType_Kunoichi then
    fileText = "Kunoich.txt"
  elseif isClassType == __eClassType_NinjaMan then
    fileText = "Ninja.txt"
  elseif isClassType == __eClassType_WizardWoman then
    fileText = "Witch.txt"
  elseif isClassType == __eClassType_WizardMan then
    fileText = "Wizard.txt"
  elseif isClassType == __eClassType_DarkElf then
    fileText = "DarkKnight.txt"
  elseif isClassType == __eClassType_Combattant then
    fileText = "Combattant.txt"
  elseif isClassType == __eClassType_Mystic then
    fileText = "Mistic.txt"
  elseif isClassType == __eClassType_Lhan then
    fileText = "Lhan.txt"
  elseif isClassType == __eClassType_RangerMan then
    fileText = "Archer.txt"
  elseif isClassType == __eClassType_ShyWaman then
    fileText = "Shai.txt"
  elseif isClassType == __eClassType_Guardian then
    fileText = "Guardian.txt"
  end
  file = io.open(filePath .. fileText, "a")
  file:write(text)
  file:close()
end
local QASkillname = 0
local QABuffname = 0
local QAMaxMindamage1 = 0
local QAMaxMindamage2 = 0
local QASumCountDamage = 0
function FromClient_QADebugSkillName(Skillname, Buffname)
  QASupportDamageWriter2:write(tostring(Skillname) .. "\t")
  QASupportDamageWriter2:write(tostring(Buffname) .. [[


]])
end
function FromClient_QADebugMinMaxDamage(MaxMinindex, MaxMindamage)
  if MaxMinindex < 1 then
    MaxMindamage = MaxMindamage * 100
    MaxMindamage = math.floor(MaxMindamage + 0.5)
    MaxMindamage = MaxMindamage * 0.01
    QASupportDamageWriter2:write(tostring(MaxMindamage) .. "\t")
  else
    MaxMindamage = MaxMindamage * 100
    MaxMindamage = math.floor(MaxMindamage + 0.5)
    MaxMindamage = MaxMindamage * 0.01
    QASupportDamageWriter2:write(tostring(MaxMindamage) .. "\t")
  end
end
function FromClient_QADebugCountDamage(Countindex, CountDamage)
  SumCountDamage = SumCountDamage + CountDamage
  if Countindex == 9 then
    SumCountDamage = SumCountDamage * 0.1
    SumCountDamage = SumCountDamage * 100
    SumCountDamage = math.floor(SumCountDamage + 0.5)
    SumCountDamage = SumCountDamage * 0.01
    QASupportDamageWriter2:write(tostring(SumCountDamage) .. "\t")
    SumCountDamage = 0
  end
end
function QASupportDamagetest(ST)
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  local isClassType = selfPlayer:getClassType()
  if isClassType == __eClassType_Warrior then
    StartQASkillUseWarrior(ST)
  elseif isClassType == __eClassType_ElfRanger then
    StartQASkillUseRanger(ST)
  elseif isClassType == __eClassType_Sorcerer then
    StartQASkillUseSorcerer(ST)
  elseif isClassType == __eClassType_Giant then
    StartQASkillUseGiant(ST)
  elseif isClassType == __eClassType_Tamer then
    StartQASkillUseTamer(ST)
  elseif isClassType == __eClassType_BladeMaster then
    StartQASkillUseMusa(ST)
  elseif isClassType == __eClassType_Valkyrie then
    StartQASkillUseValkiry(ST)
  elseif isClassType == __eClassType_BladeMasterWoman then
    StartQASkillUseMaewhwa(ST)
  elseif isClassType == __eClassType_Kunoichi then
    StartQASkillUseKunoich(ST)
  elseif isClassType == __eClassType_NinjaMan then
    StartQASkillUseNinja(ST)
  elseif isClassType == __eClassType_WizardWoman then
    StartQASkillUseWitch(ST)
  elseif isClassType == __eClassType_WizardMan then
    StartQASkillUseWizard(ST)
  elseif isClassType == __eClassType_DarkElf then
    StartQASkillUseDarkKnight(ST)
  elseif isClassType == __eClassType_Combattant then
    StartQASkillUseCombattant(ST)
  elseif isClassType == __eClassType_Mystic then
    StartQASkillUseMistic(ST)
  elseif isClassType == __eClassType_Lhan then
    StartQASkillUseLahn(ST)
  elseif isClassType == __eClassType_RangerMan then
    StartQASkillUseArcher(ST)
  elseif isClassType == __eClassType_ShyWaman then
    StartQASkillUseShai(ST)
  elseif isClassType == __eClassType_Guardian then
    StartQASkillUseGuardian(ST)
  end
end
function WriteQADamage()
  QASupportDamageWriter2:write("\236\131\129\235\140\128\234\179\181\234\178\169\235\160\165 : " .. tostring(QAtargetPV) .. " \236\131\129\235\140\128\235\176\169\236\150\180\235\160\165 : " .. tostring(QAtargetDV) .. " \236\131\129\235\140\128\236\181\156\235\140\128\236\178\180\235\160\165 : " .. tostring(QAtargetMaxHp) .. "\n")
end
function createAutoWeapon(enchantLevelA)
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  local isClassType = selfPlayer:getClassType()
  if isClassType == __eClassType_Warrior then
    ToClient_qaCreateItem(10010, enchantLevelA + 15, 1)
    ToClient_qaCreateItem(10138, enchantLevelA + 15, 1)
    ToClient_qaCreateItem(10140, enchantLevelA + 15, 1)
    ToClient_qaCreateItem(14702, enchantLevelA + 15, 1)
  elseif isClassType == __eClassType_ElfRanger then
    ToClient_qaCreateItem(10210, enchantLevelA + 15, 1)
    ToClient_qaCreateItem(10338, enchantLevelA + 15, 1)
    ToClient_qaCreateItem(10340, enchantLevelA + 15, 1)
    ToClient_qaCreateItem(14732, enchantLevelA + 15, 1)
    ToClient_qaCreateItem(10317, enchantLevelA + 15, 1)
  elseif isClassType == __eClassType_Sorcerer then
    ToClient_qaCreateItem(10410, enchantLevelA + 15, 1)
    ToClient_qaCreateItem(10538, enchantLevelA + 15, 1)
    ToClient_qaCreateItem(10540, enchantLevelA + 15, 1)
    ToClient_qaCreateItem(14712, enchantLevelA + 15, 1)
    ToClient_qaCreateItem(10517, enchantLevelA + 15, 1)
  elseif isClassType == __eClassType_Giant then
    ToClient_qaCreateItem(10610, enchantLevelA + 15, 1)
    ToClient_qaCreateItem(10738, enchantLevelA + 15, 1)
    ToClient_qaCreateItem(10740, enchantLevelA + 15, 1)
    ToClient_qaCreateItem(14722, enchantLevelA + 15, 1)
    ToClient_qaCreateItem(10517, enchantLevelA + 15, 1)
  elseif isClassType == __eClassType_Tamer then
    ToClient_qaCreateItem(13210, enchantLevelA + 15, 1)
    ToClient_qaCreateItem(13038, enchantLevelA + 15, 1)
    ToClient_qaCreateItem(13040, enchantLevelA + 15, 1)
    ToClient_qaCreateItem(14742, enchantLevelA + 15, 1)
    ToClient_qaCreateItem(13017, enchantLevelA + 15, 1)
  elseif isClassType == __eClassType_BladeMaster then
    ToClient_qaCreateItem(13310, enchantLevelA + 15, 1)
    ToClient_qaCreateItem(13138, enchantLevelA + 15, 1)
    ToClient_qaCreateItem(13140, enchantLevelA + 15, 1)
    ToClient_qaCreateItem(14762, enchantLevelA + 15, 1)
    ToClient_qaCreateItem(13117, enchantLevelA + 15, 1)
  elseif isClassType == __eClassType_Valkyrie then
    ToClient_qaCreateItem(10010, enchantLevelA + 15, 1)
    ToClient_qaCreateItem(10138, enchantLevelA + 15, 1)
    ToClient_qaCreateItem(10140, enchantLevelA + 15, 1)
    ToClient_qaCreateItem(14752, enchantLevelA + 15, 1)
  elseif isClassType == __eClassType_BladeMasterWoman then
    ToClient_qaCreateItem(13310, enchantLevelA + 15, 1)
    ToClient_qaCreateItem(13138, enchantLevelA + 15, 1)
    ToClient_qaCreateItem(13140, enchantLevelA + 15, 1)
    ToClient_qaCreateItem(14772, enchantLevelA + 15, 1)
    ToClient_qaCreateItem(13117, enchantLevelA + 15, 1)
  elseif isClassType == __eClassType_Kunoichi then
    ToClient_qaCreateItem(13210, enchantLevelA + 15, 1)
    ToClient_qaCreateItem(14538, enchantLevelA + 15, 1)
    ToClient_qaCreateItem(14540, enchantLevelA + 15, 1)
    ToClient_qaCreateItem(14792, enchantLevelA + 15, 1)
    ToClient_qaCreateItem(14517, enchantLevelA + 15, 1)
  elseif isClassType == __eClassType_NinjaMan then
    ToClient_qaCreateItem(13210, enchantLevelA + 15, 1)
    ToClient_qaCreateItem(14638, enchantLevelA + 15, 1)
    ToClient_qaCreateItem(14640, enchantLevelA + 15, 1)
    ToClient_qaCreateItem(14782, enchantLevelA + 15, 1)
    ToClient_qaCreateItem(14517, enchantLevelA + 15, 1)
  elseif isClassType == __eClassType_WizardWoman then
    ToClient_qaCreateItem(14410, enchantLevelA + 15, 1)
    ToClient_qaCreateItem(10338, enchantLevelA + 15, 1)
    ToClient_qaCreateItem(10340, enchantLevelA + 15, 1)
    ToClient_qaCreateItem(14802, enchantLevelA + 15, 1)
  elseif isClassType == __eClassType_WizardMan then
    ToClient_qaCreateItem(14410, enchantLevelA + 15, 1)
    ToClient_qaCreateItem(10338, enchantLevelA + 15, 1)
    ToClient_qaCreateItem(10340, enchantLevelA + 15, 1)
    ToClient_qaCreateItem(14812, enchantLevelA + 15, 1)
  elseif isClassType == __eClassType_DarkElf then
    ToClient_qaCreateItem(11360, enchantLevelA + 15, 1)
    ToClient_qaCreateItem(10738, enchantLevelA + 15, 1)
    ToClient_qaCreateItem(10740, enchantLevelA + 15, 1)
    ToClient_qaCreateItem(14817, enchantLevelA + 15, 1)
  elseif isClassType == __eClassType_Combattant then
    ToClient_qaCreateItem(11210, enchantLevelA + 15, 1)
    ToClient_qaCreateItem(11338, enchantLevelA + 15, 1)
    ToClient_qaCreateItem(11340, enchantLevelA + 15, 1)
    ToClient_qaCreateItem(14822, enchantLevelA + 15, 1)
  elseif isClassType == __eClassType_Mystic then
    ToClient_qaCreateItem(11210, enchantLevelA + 15, 1)
    ToClient_qaCreateItem(11338, enchantLevelA + 15, 1)
    ToClient_qaCreateItem(11340, enchantLevelA + 15, 1)
    ToClient_qaCreateItem(14830, enchantLevelA + 15, 1)
  elseif isClassType == __eClassType_Lhan then
    ToClient_qaCreateItem(13410, enchantLevelA + 15, 1)
    ToClient_qaCreateItem(13538, enchantLevelA + 15, 1)
    ToClient_qaCreateItem(13540, enchantLevelA + 15, 1)
    ToClient_qaCreateItem(550502, enchantLevelA + 15, 1)
  elseif isClassType == __eClassType_RangerMan then
    ToClient_qaCreateItem(13710, enchantLevelA + 15, 1)
    ToClient_qaCreateItem(13838, enchantLevelA + 15, 1)
    ToClient_qaCreateItem(13840, enchantLevelA + 15, 1)
    ToClient_qaCreateItem(13903, enchantLevelA + 15, 1)
    ToClient_qaCreateItem(13817, enchantLevelA + 15, 1)
  elseif isClassType == __eClassType_Guardian then
    ToClient_qaCreateItem(690513, enchantLevelA + 15, 1)
    ToClient_qaCreateItem(10138, enchantLevelA + 15, 1)
    ToClient_qaCreateItem(10140, enchantLevelA + 15, 1)
    ToClient_qaCreateItem(691503, enchantLevelA + 15, 1)
  end
end
function equipAutoWeaponMain(enchantLeve1)
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  local isClassType = selfPlayer:getClassType()
  local WeaponItem1 = 1
  local WeaponItem2 = 1
  local WeaponItem3 = 1
  local WeaponItem4 = 1
  if isClassType == __eClassType_Warrior then
    WeaponItem1 = 10010
    WeaponItem2 = 10138
    WeaponItem3 = 14702
    WeaponItem4 = 10140
  elseif isClassType == __eClassType_ElfRanger then
    WeaponItem1 = 10210
    WeaponItem2 = 10338
    WeaponItem3 = 14732
    WeaponItem4 = 10317
  elseif isClassType == __eClassType_Sorcerer then
    WeaponItem1 = 10410
    WeaponItem2 = 10538
    WeaponItem3 = 14712
    WeaponItem4 = 10517
  elseif isClassType == __eClassType_Giant then
    WeaponItem1 = 10610
    WeaponItem2 = 10738
    WeaponItem3 = 14722
    WeaponItem4 = 10740
  elseif isClassType == __eClassType_Tamer then
    WeaponItem1 = 13210
    WeaponItem2 = 13038
    WeaponItem3 = 14742
    WeaponItem4 = 13017
  elseif isClassType == __eClassType_BladeMaster then
    WeaponItem1 = 13310
    WeaponItem2 = 13138
    WeaponItem3 = 14762
    WeaponItem4 = 13117
  elseif isClassType == __eClassType_Valkyrie then
    WeaponItem1 = 10010
    WeaponItem2 = 10138
    WeaponItem3 = 14752
    WeaponItem4 = 10140
  elseif isClassType == __eClassType_BladeMasterWoman then
    WeaponItem1 = 13310
    WeaponItem2 = 13138
    WeaponItem3 = 14772
    WeaponItem4 = 13117
  elseif isClassType == __eClassType_Kunoichi then
    WeaponItem1 = 13210
    WeaponItem2 = 14538
    WeaponItem3 = 14792
    WeaponItem4 = 14517
  elseif isClassType == __eClassType_NinjaMan then
    WeaponItem1 = 13210
    WeaponItem2 = 14638
    WeaponItem3 = 14782
    WeaponItem4 = 14517
  elseif isClassType == __eClassType_WizardWoman then
    WeaponItem1 = 14410
    WeaponItem2 = 10338
    WeaponItem3 = 14802
    WeaponItem4 = 10317
  elseif isClassType == __eClassType_WizardMan then
    WeaponItem1 = 14410
    WeaponItem2 = 10338
    WeaponItem3 = 14812
    WeaponItem4 = 10317
  elseif isClassType == __eClassType_DarkElf then
    WeaponItem1 = 11360
    WeaponItem2 = 10738
    WeaponItem3 = 14817
    WeaponItem4 = 10740
  elseif isClassType == __eClassType_Combattant then
    WeaponItem1 = 11210
    WeaponItem2 = 11338
    WeaponItem3 = 14822
    WeaponItem4 = 11340
  elseif isClassType == __eClassType_Mystic then
    WeaponItem1 = 11210
    WeaponItem2 = 11338
    WeaponItem3 = 14830
    WeaponItem4 = 11340
  elseif isClassType == __eClassType_Lhan then
    WeaponItem1 = 13410
    WeaponItem2 = 13538
    WeaponItem3 = 550502
    WeaponItem4 = 13540
  elseif isClassType == __eClassType_RangerMan then
    WeaponItem1 = 13710
    WeaponItem2 = 13838
    WeaponItem3 = 13903
    WeaponItem4 = 13817
  elseif isClassType == __eClassType_Guardian then
    WeaponItem1 = 690513
    WeaponItem2 = 10138
    WeaponItem3 = 691503
  end
  equipAutoweaponSub(enchantLeve1, WeaponItem1, WeaponItem2, WeaponItem3, WeaponItem4)
end
function equipAutoAllItem(enchantLeve1)
  luaTimer_AddEvent(equipAutoWeaponMain, 1000, false, 0, enchantLeve1)
  luaTimer_AddEvent(equipAutoWeaponMain, 2000, false, 0, enchantLeve1)
  luaTimer_AddEvent(equipAutoWeaponMain, 3000, false, 0, enchantLeve1)
  luaTimer_AddEvent(equipAutoArmor, 700, false, 0, enchantLeve1)
  luaTimer_AddEvent(equipAutoArmor, 1700, false, 0, enchantLeve1)
  luaTimer_AddEvent(equipAutoArmor, 2700, false, 0, enchantLeve1)
  luaTimer_AddEvent(equipAutoArmor, 3700, false, 0, enchantLeve1)
  luaTimer_AddEvent(equipAutoAcc, 1500, false, 0, enchantLeve1)
  luaTimer_AddEvent(equipAutoAcc, 2500, false, 0, enchantLeve1)
  luaTimer_AddEvent(equipAutoAcc, 3500, false, 0, enchantLeve1)
  luaTimer_AddEvent(equipAutoAcc, 4500, false, 0, enchantLeve1)
  luaTimer_AddEvent(equipAutoAcc, 5500, false, 0, enchantLeve1)
  luaTimer_AddEvent(equipAutoAcc, 6500, false, 0, enchantLeve1)
end
function equipAutoweaponSub(enchantLeve1, WeaponItem1, WeaponItem2, WeaponItem3, WeaponItem4)
  if enchantLeve1 == 1 or enchantLeve1 == 2 then
    ToClient_qaUseInventoryItem(WeaponItem1, 18)
  elseif enchantLeve1 == 3 or enchantLeve1 == 4 or enchantLeve1 == 11 or enchantLeve1 == 12 or enchantLeve1 == 21 or enchantLeve1 == 22 then
    ToClient_qaUseInventoryItem(WeaponItem1, 19)
  elseif enchantLeve1 == 5 or enchantLeve1 == 13 or enchantLeve1 == 23 then
    ToClient_qaUseInventoryItem(WeaponItem1, 20)
  else
    return
  end
  if enchantLeve1 == 1 or enchantLeve1 == 2 then
    ToClient_qaUseInventoryItem(WeaponItem2, 18)
  elseif enchantLeve1 == 3 or enchantLeve1 == 4 then
    ToClient_qaUseInventoryItem(WeaponItem2, 19)
  elseif enchantLeve1 == 5 then
    ToClient_qaUseInventoryItem(WeaponItem2, 20)
  else
    return
  end
  if enchantLeve1 == 1 or enchantLeve1 == 2 then
    ToClient_qaUseInventoryItem(WeaponItem3, 18)
  elseif enchantLeve1 == 3 or enchantLeve1 == 4 or enchantLeve1 == 11 or enchantLeve1 == 12 or enchantLeve1 == 21 or enchantLeve1 == 22 then
    ToClient_qaUseInventoryItem(WeaponItem3, 19)
  elseif enchantLeve1 == 5 or enchantLeve1 == 13 or enchantLeve1 == 23 then
    ToClient_qaUseInventoryItem(WeaponItem3, 20)
  else
    return
  end
  if enchantLeve1 == 11 or enchantLeve1 == 12 or enchantLeve1 == 21 or enchantLeve1 == 22 then
    ToClient_qaUseInventoryItem(WeaponItem4, 19)
  elseif enchantLeve1 == 13 or enchantLeve1 == 23 then
    ToClient_qaUseInventoryItem(WeaponItem4, 20)
  else
    return
  end
end
function createAutoArmor(enchantLevelA, enchantLeve1)
  ToClient_qaCreateItem(11101, enchantLevelA + 15, 1)
  ToClient_qaCreateItem(11015, enchantLevelA + 15, 1)
  ToClient_qaCreateItem(11103, enchantLevelA + 15, 1)
  ToClient_qaCreateItem(11017, enchantLevelA + 15, 1)
  ToClient_qaCreateItem(10985, enchantLevelA + 15, 1)
  ToClient_qaCreateItem(10987, enchantLevelA + 15, 1)
end
function equipAutoArmor(enchantLeve1)
  if enchantLeve1 == 1 or enchantLeve1 == 2 then
    ToClient_qaUseInventoryItem(11101, 18)
    ToClient_qaUseInventoryItem(11015, 18)
    ToClient_qaUseInventoryItem(11103, 18)
    ToClient_qaUseInventoryItem(11017, 18)
  elseif enchantLeve1 == 3 then
    ToClient_qaUseInventoryItem(11101, 19)
    ToClient_qaUseInventoryItem(11015, 19)
    ToClient_qaUseInventoryItem(11103, 19)
    ToClient_qaUseInventoryItem(11017, 19)
  elseif enchantLeve1 == 4 or enchantLeve1 == 5 then
    ToClient_qaUseInventoryItem(11101, 20)
    ToClient_qaUseInventoryItem(11015, 20)
    ToClient_qaUseInventoryItem(11103, 20)
    ToClient_qaUseInventoryItem(11017, 20)
  elseif enchantLeve1 == 11 or enchantLeve1 == 21 then
    ToClient_qaUseInventoryItem(11101, 19)
    ToClient_qaUseInventoryItem(11015, 19)
    ToClient_qaUseInventoryItem(11103, 19)
    ToClient_qaUseInventoryItem(11017, 19)
  elseif enchantLeve1 == 12 or enchantLeve1 == 13 or enchantLeve1 == 22 or enchantLeve1 == 23 then
    ToClient_qaUseInventoryItem(11101, 20)
    ToClient_qaUseInventoryItem(11015, 20)
    ToClient_qaUseInventoryItem(11103, 20)
    ToClient_qaUseInventoryItem(11017, 20)
  else
    return
  end
end
function createAutoAcc(enchantLevelA)
  ToClient_qaCreateItem(12230, enchantLevelA, 1)
  ToClient_qaCreateItem(12229, enchantLevelA, 1)
  ToClient_qaCreateItem(12251, enchantLevelA, 1)
  ToClient_qaCreateItem(12237, enchantLevelA, 1)
  ToClient_qaCreateItem(12031, enchantLevelA, 2)
  ToClient_qaCreateItem(12007, enchantLevelA, 2)
  ToClient_qaCreateItem(12061, enchantLevelA, 2)
  ToClient_qaCreateItem(12032, enchantLevelA, 2)
  ToClient_qaCreateItem(11828, enchantLevelA, 2)
  ToClient_qaCreateItem(11926, enchantLevelA, 2)
  ToClient_qaCreateItem(11808, enchantLevelA, 2)
  ToClient_qaCreateItem(11814, enchantLevelA, 2)
  ToClient_qaCreateItem(11607, enchantLevelA, 1)
  ToClient_qaCreateItem(11625, enchantLevelA, 1)
  ToClient_qaCreateItem(11611, enchantLevelA, 1)
end
function equipAutoAcc(enchantLeve1)
  if enchantLeve1 == 1 then
    ToClient_qaUseInventoryItem(11808, 3)
    ToClient_qaUseInventoryItem(12007, 3)
    ToClient_qaUseInventoryItem(11607, 1)
    ToClient_qaUseInventoryItem(12230, 1)
  elseif enchantLeve1 == 2 then
    ToClient_qaUseInventoryItem(11808, 3)
    ToClient_qaUseInventoryItem(12031, 3)
    ToClient_qaUseInventoryItem(11607, 3)
    ToClient_qaUseInventoryItem(12230, 3)
  elseif enchantLeve1 == 3 then
    ToClient_qaUseInventoryItem(11828, 3)
    ToClient_qaUseInventoryItem(12031, 3)
    ToClient_qaUseInventoryItem(11607, 3)
    ToClient_qaUseInventoryItem(12230, 3)
  elseif enchantLeve1 == 4 then
    ToClient_qaUseInventoryItem(11828, 4)
    ToClient_qaUseInventoryItem(12031, 4)
    ToClient_qaUseInventoryItem(11607, 4)
    ToClient_qaUseInventoryItem(12230, 4)
  elseif enchantLeve1 == 5 then
    ToClient_qaUseInventoryItem(11828, 5)
    ToClient_qaUseInventoryItem(12061, 4)
    ToClient_qaUseInventoryItem(11607, 5)
    ToClient_qaUseInventoryItem(12251, 4)
  elseif enchantLeve1 == 11 then
    ToClient_qaUseInventoryItem(11814, 4)
    ToClient_qaUseInventoryItem(12031, 3)
    ToClient_qaUseInventoryItem(11625, 4)
    ToClient_qaUseInventoryItem(12251, 3)
  elseif enchantLeve1 == 12 then
    ToClient_qaUseInventoryItem(11828, 4)
    ToClient_qaUseInventoryItem(12031, 4)
    ToClient_qaUseInventoryItem(11607, 4)
    ToClient_qaUseInventoryItem(12251, 4)
  elseif enchantLeve1 == 13 then
    ToClient_qaUseInventoryItem(11814, 5)
    ToClient_qaUseInventoryItem(12061, 4)
    ToClient_qaUseInventoryItem(11607, 5)
    ToClient_qaUseInventoryItem(12251, 4)
  elseif enchantLeve1 == 21 then
    ToClient_qaUseInventoryItem(11926, 3)
    ToClient_qaUseInventoryItem(12032, 3)
    ToClient_qaUseInventoryItem(11611, 4)
    ToClient_qaUseInventoryItem(12229, 4)
  elseif enchantLeve1 == 22 then
    ToClient_qaUseInventoryItem(11926, 4)
    ToClient_qaUseInventoryItem(12032, 4)
    ToClient_qaUseInventoryItem(11611, 5)
    ToClient_qaUseInventoryItem(12229, 4)
  elseif enchantLeve1 == 23 then
    ToClient_qaUseInventoryItem(11926, 5)
    ToClient_qaUseInventoryItem(12032, 4)
    ToClient_qaUseInventoryItem(11611, 5)
    ToClient_qaUseInventoryItem(12229, 5)
  else
    return
  end
end
function createAllitem()
  for createcount = 1, 5 do
    luaTimer_AddEvent(createAutoArmor, 1000 * createcount, false, 0, createcount)
    luaTimer_AddEvent(createAutoAcc, 1000 * createcount, false, 0, createcount)
    luaTimer_AddEvent(createAutoWeapon, 1000 * createcount, false, 0, createcount)
  end
end
function createAutofullset()
  ToClient_qaClearInventory()
  LearnSkill()
  createAutostate()
  createAllitem()
end
function createAutostate()
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  local isClassType = selfPlayer:getClassType()
  if isClassType == __eClassType_Warrior then
    ToClient_qaLevelUp(60)
    ToClient_qaConditionCompleteQuest()
    ToClient_qaCompleteQuest(285, 4)
    ToClient_qaCompleteQuest(653, 6)
    ToClient_qaCreateItem(142, 0, 1)
    ToClient_qaCreateItem(143, 0, 2)
    ToClient_qaCreateItem(144, 0, 3)
    ToClient_qaCreateItem(191, 0, 1)
  elseif isClassType == __eClassType_ElfRanger then
    ToClient_qaLevelUp(60)
    ToClient_qaConditionCompleteQuest()
    ToClient_qaCompleteQuest(293, 4)
    ToClient_qaCompleteQuest(653, 6)
    ToClient_qaCreateItem(151, 0, 1)
    ToClient_qaCreateItem(152, 0, 1)
    ToClient_qaCreateItem(153, 0, 1)
  elseif isClassType == __eClassType_Sorcerer then
    ToClient_qaLevelUp(60)
    ToClient_qaConditionCompleteQuest()
    ToClient_qaCompleteQuest(287, 4)
    ToClient_qaCompleteQuest(653, 6)
    ToClient_qaCreateItem(145, 0, 1)
    ToClient_qaCreateItem(146, 0, 1)
    ToClient_qaCreateItem(147, 0, 1)
  elseif isClassType == __eClassType_Giant then
    ToClient_qaLevelUp(60)
    ToClient_qaConditionCompleteQuest()
    ToClient_qaCompleteQuest(290, 4)
    ToClient_qaCompleteQuest(653, 6)
    ToClient_qaCreateItem(148, 0, 1)
    ToClient_qaCreateItem(149, 0, 1)
    ToClient_qaCreateItem(150, 0, 1)
  elseif isClassType == __eClassType_Tamer then
    ToClient_qaLevelUp(60)
    ToClient_qaConditionCompleteQuest()
    ToClient_qaCompleteQuest(296, 4)
    ToClient_qaCompleteQuest(653, 6)
    ToClient_qaCreateItem(154, 0, 1)
    ToClient_qaCreateItem(155, 0, 1)
    ToClient_qaCreateItem(156, 0, 1)
  elseif isClassType == __eClassType_BladeMaster then
    ToClient_qaLevelUp(60)
    ToClient_qaConditionCompleteQuest()
    ToClient_qaCompleteQuest(319, 4)
    ToClient_qaCompleteQuest(653, 6)
    ToClient_qaCreateItem(160, 0, 1)
    ToClient_qaCreateItem(161, 0, 1)
    ToClient_qaCreateItem(162, 0, 1)
  elseif isClassType == __eClassType_Valkyrie then
    ToClient_qaLevelUp(60)
    ToClient_qaConditionCompleteQuest()
    ToClient_qaCompleteQuest(298, 4)
    ToClient_qaCompleteQuest(653, 6)
    ToClient_qaCreateItem(157, 0, 1)
    ToClient_qaCreateItem(158, 0, 1)
    ToClient_qaCreateItem(159, 0, 1)
  elseif isClassType == __eClassType_BladeMasterWoman then
    ToClient_qaLevelUp(60)
    ToClient_qaConditionCompleteQuest()
    ToClient_qaCompleteQuest(321, 4)
    ToClient_qaCompleteQuest(653, 6)
    ToClient_qaCreateItem(163, 0, 1)
    ToClient_qaCreateItem(164, 0, 1)
    ToClient_qaCreateItem(165, 0, 1)
  elseif isClassType == __eClassType_Kunoichi then
    ToClient_qaLevelUp(60)
    ToClient_qaConditionCompleteQuest()
    ToClient_qaCompleteQuest(327, 4)
    ToClient_qaCompleteQuest(653, 6)
    ToClient_qaCreateItem(169, 0, 1)
    ToClient_qaCreateItem(170, 0, 1)
    ToClient_qaCreateItem(171, 0, 1)
  elseif isClassType == __eClassType_NinjaMan then
    ToClient_qaLevelUp(60)
    ToClient_qaConditionCompleteQuest()
    ToClient_qaCompleteQuest(325, 4)
    ToClient_qaCompleteQuest(653, 6)
    ToClient_qaCreateItem(166, 0, 1)
    ToClient_qaCreateItem(167, 0, 1)
    ToClient_qaCreateItem(168, 0, 1)
  elseif isClassType == __eClassType_WizardWoman then
    ToClient_qaLevelUp(60)
    ToClient_qaConditionCompleteQuest()
    ToClient_qaCompleteQuest(334, 5)
    ToClient_qaCompleteQuest(653, 6)
    ToClient_qaCreateItem(172, 0, 1)
    ToClient_qaCreateItem(173, 0, 1)
    ToClient_qaCreateItem(174, 0, 1)
  elseif isClassType == __eClassType_WizardMan then
    ToClient_qaLevelUp(60)
    ToClient_qaConditionCompleteQuest()
    ToClient_qaCompleteQuest(336, 5)
    ToClient_qaCompleteQuest(653, 6)
    ToClient_qaCreateItem(175, 0, 1)
    ToClient_qaCreateItem(176, 0, 1)
    ToClient_qaCreateItem(177, 0, 1)
  elseif isClassType == __eClassType_DarkElf then
    ToClient_qaLevelUp(60)
    ToClient_qaConditionCompleteQuest()
    ToClient_qaCompleteQuest(338, 5)
    ToClient_qaCompleteQuest(653, 6)
    ToClient_qaCreateItem(178, 0, 1)
    ToClient_qaCreateItem(179, 0, 1)
    ToClient_qaCreateItem(180, 0, 1)
  elseif isClassType == __eClassType_Combattant then
    ToClient_qaLevelUp(60)
    ToClient_qaConditionCompleteQuest()
    ToClient_qaCompleteQuest(342, 7)
    ToClient_qaCompleteQuest(653, 6)
    ToClient_qaCreateItem(181, 0, 1)
    ToClient_qaCreateItem(182, 0, 1)
    ToClient_qaCreateItem(183, 0, 1)
  elseif isClassType == __eClassType_Mystic then
    ToClient_qaLevelUp(60)
    ToClient_qaConditionCompleteQuest()
    ToClient_qaCompleteQuest(343, 5)
    ToClient_qaCompleteQuest(653, 6)
    ToClient_qaCreateItem(184, 0, 1)
    ToClient_qaCreateItem(185, 0, 1)
    ToClient_qaCreateItem(186, 0, 1)
  elseif isClassType == __eClassType_Lhan then
    ToClient_qaLevelUp(60)
    ToClient_qaConditionCompleteQuest()
    ToClient_qaCompleteQuest(345, 5)
    ToClient_qaCompleteQuest(653, 6)
    ToClient_qaCreateItem(187, 0, 1)
    ToClient_qaCreateItem(188, 0, 1)
    ToClient_qaCreateItem(189, 0, 1)
  elseif isClassType == __eClassType_Hashashin then
  end
  ToClient_qaCreateItem(65487, 0, 3)
  ToClient_qaCreateItem(65489, 0, 1)
  ToClient_qaCreateItem(65490, 0, 1)
  ToClient_qaCreateItem(65488, 0, 2)
  ToClient_qaCreateItem(65491, 0, 1)
  ToClient_qaCreateItem(9693, 0, 100)
  ToClient_qaCreateItem(9635, 0, 100)
  ToClient_qaCreateItem(9464, 0, 100)
  ToClient_qaCreateItem(9609, 0, 100)
  ToClient_qaCreateItem(9603, 0, 100)
  ToClient_qaCreateItem(9634, 0, 100)
  ToClient_qaCreateItem(791, 0, 100)
  ToClient_qaCreateItem(792, 0, 100)
  ToClient_qaCreateItem(793, 0, 100)
  ToClient_qaCreateItem(794, 0, 100)
  ToClient_qaCreateItem(795, 0, 100)
end
function UnEquipAll()
  for ii = CppEnums.EquipSlotNo.equipSlotNoCount - 1, 0, -1 do
    UnEquipItemForQA(ii)
  end
end
function UnEquipAllQATEST()
  UnEquipAll()
  UnEquipAll()
  luaTimer_AddEvent(UnEquipAll, 1500, false, 0)
  luaTimer_AddEvent(UnEquipAll, 2000, false, 0)
end
local MyEquiplist = 1
local TargetEquiplist = 1
function QaAutoDamageTest(ST)
  if ST == 1 then
    if 3 < MyEquiplist then
      return
    end
    QASupportDamageWriter2:write("------------------------------------------------------------------------------------" .. "\n")
    QASupportDamageWriter2:write("------------------------------------------------------------------------------------" .. "\n")
    QASupportDamageWriter2:write("------------------------------------------------------------------------------------" .. "\n")
    chatting_sendMessage("", "\235\130\180\236\158\165\235\185\132 :" .. tostring(MyEquiplist) .. " / \236\131\129\235\140\128\236\158\165\235\185\132 : " .. tostring(TargetEquiplist) .. "", CppEnums.ChatType.Private)
    QASupportDamageWriter2:write("\235\130\180\236\158\165\235\185\132 : " .. tostring(MyEquiplist) .. "\n")
    QASupportDamageWriter2:write("\236\131\129\235\140\128\236\158\165\235\185\132 : " .. tostring(TargetEquiplist) .. "\n")
    luaTimer_AddEvent(ToClient_qaDebugDamage, 1000, false, 0, 0, MyEquiplist, TargetEquiplist)
    luaTimer_AddEvent(QASupportDamagetest, 11000, false, 0, ST)
    luaTimer_AddEvent(QaAutoDamageTest2, 14000, false, 0, ST)
    if 10 < TargetEquiplist then
      MyEquiplist = MyEquiplist + 1
      TargetEquiplist = 0
    end
    TargetEquiplist = TargetEquiplist + 1
  else
    return
  end
end
function QaAutoDamageTest2(ST)
  if ST == 1 then
    if 3 < MyEquiplist then
      return
    end
    QASupportDamageWriter2:write("------------------------------------------------------------------------------------" .. "\n")
    QASupportDamageWriter2:write("------------------------------------------------------------------------------------" .. "\n")
    QASupportDamageWriter2:write("------------------------------------------------------------------------------------" .. "\n")
    chatting_sendMessage("", "\235\130\180\236\158\165\235\185\132 :" .. tostring(MyEquiplist) .. " / \236\131\129\235\140\128\236\158\165\235\185\132 : " .. tostring(TargetEquiplist) .. "", CppEnums.ChatType.Private)
    QASupportDamageWriter2:write("\235\130\180\236\158\165\235\185\132 : " .. tostring(MyEquiplist) .. "\n")
    QASupportDamageWriter2:write("\236\131\129\235\140\128\236\158\165\235\185\132 : " .. tostring(TargetEquiplist) .. "\n")
    luaTimer_AddEvent(ToClient_qaDebugDamage, 1000, false, 0, 0, MyEquiplist, TargetEquiplist)
    luaTimer_AddEvent(QASupportDamagetest, 11000, false, 0, ST)
    luaTimer_AddEvent(QaAutoDamageTest, 14000, false, 0, ST)
    if 10 < TargetEquiplist then
      MyEquiplist = MyEquiplist + 1
      TargetEquiplist = 0
    end
    TargetEquiplist = TargetEquiplist + 1
  else
    return
  end
end
function QAXboxSet(Armtype)
  QAXboxbaseItem1()
  QAXboxbaseItem2()
  if Armtype == 1 then
    QAXboxset1()
  elseif Armtype == 2 then
    QAXboxset2()
  elseif Armtype == 3 then
    QAXboxset3()
  else
    return
  end
end
function QAXboxbaseItem1()
  ToClient_qaLevelUp(50)
  ToClient_qaCreateItem(60, 0, 200)
  ToClient_qaCreateItem(65487, 0, 3)
  ToClient_qaCreateItem(65489, 0, 1)
  ToClient_qaCreateItem(65490, 0, 1)
  ToClient_qaCreateItem(65488, 0, 2)
  ToClient_qaCreateItem(65491, 0, 1)
  ToClient_qaCreateItem(1, 0, 1000000)
  luaTimer_AddEvent(LearnSkill, 1000, false, 0)
end
function QAXboxbaseItem2()
  ToClient_qaCreateItem(44906, 0, 1)
  ToClient_qaCreateItem(44937, 0, 1)
  ToClient_qaCreateItem(10993, 0, 1)
  ToClient_qaCreateItem(10994, 0, 1)
  ToClient_qaCreateItem(10995, 0, 1)
  ToClient_qaCreateItem(10996, 0, 1)
  ToClient_qaCreateItem(11645, 0, 1)
  ToClient_qaCreateItem(11843, 0, 2)
  ToClient_qaCreateItem(12049, 0, 2)
  ToClient_qaCreateItem(12242, 0, 1)
end
function QAXboxset1()
  ToClient_qaCreateItem(17569, 0, 1000)
  ToClient_qaCreateItem(17571, 0, 1000)
  ToClient_qaCreateItem(593, 0, 1000)
  ToClient_qaCreateItem(17974, 0, 1)
  ToClient_qaCreateItem(54018, 0, 300)
  ToClient_qaCreateItem(41557, 0, 500)
  ToClient_qaCreateItem(17566, 0, 500)
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  local isClassType = selfPlayer:getClassType()
  if isClassType == __eClassType_Warrior then
    ToClient_qaCreateItem(21021, 0, 1)
  elseif isClassType == __eClassType_ElfRanger then
    ToClient_qaCreateItem(21050, 0, 1)
  elseif isClassType == __eClassType_Sorcerer then
    ToClient_qaCreateItem(21062, 0, 1)
  elseif isClassType == __eClassType_Giant then
    ToClient_qaCreateItem(21081, 0, 1)
  elseif isClassType == __eClassType_WizardWoman then
    ToClient_qaCreateItem(21205, 0, 1)
  elseif isClassType == __eClassType_WizardMan then
    ToClient_qaCreateItem(21185, 0, 1)
  end
  luaTimer_AddEvent(TeleportHexe, 20000, false, 0)
end
function QAXboxset2()
  ToClient_qaCreateItem(58001, 0, 10)
  ToClient_qaCreateItem(6701, 0, 5)
  ToClient_qaCreateItem(6702, 0, 5)
  ToClient_qaCreateItem(6703, 0, 5)
  ToClient_qaCreateItem(6704, 0, 5)
  ToClient_qaCreateItem(6705, 0, 5)
  ToClient_qaCreateItem(6706, 0, 5)
  ToClient_qaCreateItem(6707, 0, 5)
  ToClient_qaCreateItem(6801, 0, 5)
  ToClient_qaCreateItem(6802, 0, 5)
  ToClient_qaCreateItem(6803, 0, 5)
  ToClient_qaCreateItem(6804, 0, 5)
  ToClient_qaCreateItem(6805, 0, 5)
  ToClient_qaCreateItem(6806, 0, 5)
  ToClient_qaCreateItem(6807, 0, 5)
  ToClient_qaCreateItem(6808, 0, 5)
  ToClient_qaCreateItem(6809, 0, 5)
  ToClient_qaCreateItem(16910, 0, 5)
  ToClient_qaCreateItem(16911, 0, 5)
  luaTimer_AddEvent(TeleportBelia2, 20000, false, 0)
  ToClient_qaCreateItem(590, 0, 20)
end
function QAXboxset3()
  ToClient_qaCreateItem(368, 0, 2)
  ToClient_qaCreateItem(16141, 0, 3)
  ToClient_qaCreateItem(16153, 0, 3)
  ToClient_qaCreateItem(16167, 0, 1)
  ToClient_qaCreateItem(16168, 0, 1)
  ToClient_qaCreateItem(16169, 0, 1)
  ToClient_qaCreateItem(16170, 0, 1)
  ToClient_qaCreateItem(12831, 0, 3)
  ToClient_qaCreateItem(65424, 0, 100)
  luaTimer_AddEvent(TeleportBelia1, 20000, false, 0)
  ToClient_qaCreateItem(44940, 0, 1)
end
function TeleportBelia1()
  ToClient_qaTeleport(7469, -7815, 83716)
end
function TeleportBelia2()
  ToClient_qaTeleport(24271, -6276, 73371)
end
function TeleportHexe()
  ToClient_qaTeleport(-263232, 5841, -230563)
end
function NationSiegeWorldMapLimitCount(count)
  ToClient_DeadPlayerQueueLimitCount(count)
end
function QACallMonsterRideVehicle()
  servant_callGuildMonsterRideVehicle()
end
function AutoKillLoot(monsterkey, quantity, number)
  if 50 < number then
    Proc_ShowMessage_Ack("\235\176\152\235\179\181\237\154\159\236\136\152\234\176\128 \235\132\136\235\172\180 \235\134\146\234\178\140 \236\132\164\236\160\149\235\144\152\236\151\136\236\138\181\235\139\136\235\139\164.")
    return
  end
  for i = 0, number - 1 do
    luaTimer_AddEvent(ToClient_qaCreateMonster, 2500 * i, false, 0, monsterkey, quantity)
    luaTimer_AddEvent(pa_sendMessage, 2500 * i + 500, false, 0, "/killnearallmonster")
    luaTimer_AddEvent(pa_sendMessage, 2500 * i + 2000, false, 0, "/lootnearall")
  end
  luaTimer_AddEvent(Proc_ShowMessage_Ack, 2500 * number + 10000, false, 0, tostring(monsterkey) .. " \235\170\172\236\138\164\237\132\176\234\176\128 " .. tostring(quantity) .. "\235\167\136\235\166\172 \236\148\169 " .. tostring(number) .. "\237\154\140\236\151\144 \234\177\184\236\179\144 \235\163\168\237\140\133\235\144\152\236\151\136\236\138\181\235\139\136\235\139\164.")
end
function chatUpdateTickCount()
  chatting_sendMessage("", "/MarketCommand UpdateTickCount", CppEnums.ChatType.Private)
end
function AutoUpdateMarket(count)
  if count == nil then
    Proc_ShowMessage_Ack("\236\139\164\237\150\137\237\154\159\236\136\152 \236\158\133\235\160\165\235\144\152\236\167\128 \236\149\138\236\157\140")
    return
  else
    for ii = 0, count - 1 do
      luaTimer_AddEvent(chatUpdateTickCount, 30000 * ii, false, 0)
      luaTimer_AddEvent(chatting_sendMessage, 30000 * ii + 200, false, 0, "", tostring(ii + 1) .. "\235\178\136 \236\158\133\235\160\165\235\144\168", CppEnums.ChatType.Private)
      if ii == count - 1 then
        luaTimer_AddEvent(Proc_ShowMessage_Ack, 30000 * ii + 1000, false, 0, "\234\177\176\235\158\152\236\134\140 \236\139\156\236\132\184\234\176\128 \235\179\128\235\143\153\235\144\152\236\151\136\236\138\181\235\139\136\235\139\164.")
      end
    end
  end
end
function camXY()
  setFov(40)
  local float2 = characterCameraAdditionalTranslation()
  local float = characterCameraDistanceFromCharacter()
  _PA_LOG("Camera_Location", tostring(float2.x) .. ", " .. tostring(float2.y))
  _PA_LOG("Camera_Location", tostring(float))
  chatting_sendMessage("", "x = " .. tostring(float2.x) .. " , y = " .. tostring(float2.y), CppEnums.ChatType.System)
  chatting_sendMessage("", "wheel = " .. tostring(float), CppEnums.ChatType.System)
end
function rec(awaken)
  setFov(40)
  setTextureQuality(0)
  setGraphicOption(9)
  setTessellation(true)
  setRepresentative(true)
  setAutoOptimization(false)
  setPresentLock(false)
  setRenderHitEffect(false)
  setUseOptimizationEffectFrame(false)
  setUsePlayerOptimizationEffectFrame(false)
  setScreenMode(2)
  setScreenResolution(1920, 1080)
  setLensBlood(false)
  setCameraLUTFilter(1)
  setGammaValue(0.5)
  setContrastValue(0.5)
  setEnableSoundMusic(false)
  setEnableSoundFx(true)
  setEnableSoundEnv(false)
  setEnableSoundWhisper(false)
  setEnableSoundTray(false)
  setIsOnScreenSaver(false)
  if true == _ContentsGroup_NewUI_GameOption_All then
    ToClient_SetMessageFilter(PaGlobal_GameOption_All.ALERT.NormalTrade, true)
    ToClient_SetMessageFilter(PaGlobal_GameOption_All.ALERT.RoyalTrade, true)
    ToClient_SetMessageFilter(PaGlobal_GameOption_All.ALERT.OtherPlayerGetItem, true)
    ToClient_SetMessageFilter(PaGlobal_GameOption_All.ALERT.LifeLevelUp, true)
    ToClient_SetMessageFilter(PaGlobal_GameOption_All.ALERT.EnchantSuccess, true)
    ToClient_SetMessageFilter(PaGlobal_GameOption_All.ALERT.EnchantFail, true)
    ToClient_SetMessageFilter(PaGlobal_GameOption_All.ALERT.ItemMarket, true)
    ToClient_SetMessageFilter(PaGlobal_GameOption_All.ALERT.OtherMarket, true)
    ToClient_SetMessageFilter(PaGlobal_GameOption_All.ALERT.ChangeRegion, true)
    ToClient_SetMessageFilter(PaGlobal_GameOption_All.ALERT.FitnessLevelUp, true)
    ToClient_SetMessageFilter(PaGlobal_GameOption_All.ALERT.TerritoryWar, true)
    ToClient_SetMessageFilter(PaGlobal_GameOption_All.ALERT.GuildWar, true)
    ToClient_SetMessageFilter(PaGlobal_GameOption_All.ALERT.GuildQuestMessage, true)
    ToClient_SetMessageFilter(PaGlobal_GameOption_All.ALERT.NearMonster, true)
  else
    ToClient_SetMessageFilter(PaGlobal_Option.ALERT.NormalTrade, true)
    ToClient_SetMessageFilter(PaGlobal_Option.ALERT.RoyalTrade, true)
    ToClient_SetMessageFilter(PaGlobal_Option.ALERT.OtherPlayerGetItem, true)
    ToClient_SetMessageFilter(PaGlobal_Option.ALERT.LifeLevelUp, true)
    ToClient_SetMessageFilter(PaGlobal_Option.ALERT.EnchantSuccess, true)
    ToClient_SetMessageFilter(PaGlobal_Option.ALERT.EnchantFail, true)
    ToClient_SetMessageFilter(PaGlobal_Option.ALERT.ItemMarket, true)
    ToClient_SetMessageFilter(PaGlobal_Option.ALERT.OtherMarket, true)
    ToClient_SetMessageFilter(PaGlobal_Option.ALERT.ChangeRegion, true)
    ToClient_SetMessageFilter(PaGlobal_Option.ALERT.FitnessLevelUp, true)
    ToClient_SetMessageFilter(PaGlobal_Option.ALERT.TerritoryWar, true)
    ToClient_SetMessageFilter(PaGlobal_Option.ALERT.GuildWar, true)
    ToClient_SetMessageFilter(PaGlobal_Option.ALERT.GuildQuestMessage, true)
    ToClient_SetMessageFilter(PaGlobal_Option.ALERT.NearMonster, true)
  end
  local selfPlayer = getSelfPlayer()
  local x, y, wheel, distance
  if nil == selfPlayer then
    return
  end
  if awaken == 0 or awaken == nil then
    local isClassType = selfPlayer:getClassType()
    if isClassType == __eClassType_Warrior then
      x = 165.455139
      y = -17.076027
      wheel = 583.200806
      distance = 800
      setCameraMasterPower(0.7)
      setCameraShakePower(0.3)
      setMotionBlurPower(0.1)
      setCameraTranslatePower(0.3)
      setCameraFovPower(0.5)
    elseif isClassType == __eClassType_ElfRanger then
      x = 172.839355
      y = -16.843063354492
      wheel = 612.000549
      distance = 800
      setCameraMasterPower(0.75)
      setCameraShakePower(0.7)
      setMotionBlurPower(0.1)
      setCameraTranslatePower(0.2)
      setCameraFovPower(0.3)
    elseif isClassType == __eClassType_Sorcerer then
      x = 127.0911026001
      y = -14.914710998535
      wheel = 453.96594238281
      distance = 800
      setCameraMasterPower(0.65)
      setCameraShakePower(0.3)
      setMotionBlurPower(0.65)
      setCameraTranslatePower(0.5)
      setCameraFovPower(0.2)
    elseif isClassType == __eClassType_Giant then
      x = 171.2507
      y = -17.1269
      wheel = 756.0003
      distance = 800
      setCameraMasterPower(0.75)
      setCameraShakePower(0.5)
      setMotionBlurPower(0.4)
      setCameraTranslatePower(0.6)
      setCameraFovPower(0.5)
    elseif isClassType == __eClassType_Tamer then
      x = 87.338066
      y = -46.572147
      wheel = 496.800598
      distance = 800
      setCameraMasterPower(0.73)
      setCameraShakePower(0.41)
      setMotionBlurPower(0.25)
      setCameraTranslatePower(0.2)
      setCameraFovPower(0.25)
    elseif isClassType == __eClassType_BladeMaster then
      x = 138.3723
      y = -36.11036
      wheel = 644.02386
      distance = 800
      setCameraMasterPower(0.65)
      setCameraShakePower(0.35)
      setMotionBlurPower(0.5)
      setCameraTranslatePower(0.7)
      setCameraFovPower(0.4)
    elseif isClassType == __eClassType_Valkyrie then
      x = 163.572556
      y = -26.268225
      wheel = 640.800659
      distance = 800
      setCameraMasterPower(0.7)
      setCameraShakePower(0.3)
      setMotionBlurPower(0.1)
      setCameraTranslatePower(0.3)
      setCameraFovPower(0.45)
    elseif isClassType == __eClassType_BladeMasterWoman then
      x = 155.2201
      y = -23.6086
      wheel = 595.40069
      distance = 800
      setCameraMasterPower(0.8)
      setCameraShakePower(0.4)
      setMotionBlurPower(0.3)
      setCameraTranslatePower(0.6)
      setCameraFovPower(0.5)
    elseif isClassType == __eClassType_Kunoichi then
      x = 116.451134
      y = -55.236767
      wheel = 468.924469
      distance = 800
      setCameraMasterPower(0.7)
      setCameraShakePower(0.45)
      setMotionBlurPower(0.25)
      setCameraTranslatePower(0.5)
      setCameraFovPower(0.4)
    elseif isClassType == __eClassType_NinjaMan then
      x = 99.603722
      y = -2.690758
      wheel = 496.223083
      distance = 800
      setCameraMasterPower(0.72)
      setCameraShakePower(0.34)
      setMotionBlurPower(0.25)
      setCameraTranslatePower(0.2)
      setCameraFovPower(0.25)
    elseif isClassType == __eClassType_WizardWoman then
      x = -105
      y = -19
      wheel = 407.600433
      distance = 800
    elseif isClassType == __eClassType_WizardMan then
      x = -105
      y = -19
      wheel = 407.600433
      distance = 800
    elseif isClassType == __eClassType_DarkElf then
      x = 118.37773132324
      y = -40.602214813232
      wheel = 487.74142456055
      distance = 800
      setCameraMasterPower(0.7)
      setCameraShakePower(0.4)
      setMotionBlurPower(0.5)
      setCameraTranslatePower(0.4)
      setCameraFovPower(0.5)
    elseif isClassType == __eClassType_Combattant then
      x = -105
      y = -19
      wheel = 407.600433
      distance = 800
    elseif isClassType == __eClassType_Mystic then
      x = 115.175598
      y = -1.510609
      wheel = 468.959442
      distance = 800
      setCameraMasterPower(0.7)
      setCameraShakePower(0.6)
      setMotionBlurPower(0.1)
      setCameraTranslatePower(0.4)
      setCameraFovPower(0.4)
    elseif isClassType == __eClassType_Lhan then
      x = 84.790969848633
      y = -41.422325134277
      wheel = 448.8000793457
      distance = 800
      setCameraMasterPower(0.65)
      setCameraShakePower(0.3)
      setMotionBlurPower(0.55)
      setCameraTranslatePower(0.6)
      setCameraFovPower(0.35)
    elseif isClassType == __eClassType_RangerMan then
      x = -105
      y = -19
      wheel = 407.600433
      distance = 800
    elseif isClassType == __eClassType_ShyWaman then
      x = -105
      y = -19
      wheel = 407.600433
      distance = 800
    elseif isClassType == __eClassType_Guardian then
      x = 113.84637
      y = -8.8699
      wheel = 566.7192
      distance = 800
      setCameraMasterPower(0.7)
      setCameraShakePower(0.4)
      setMotionBlurPower(0.5)
      setCameraTranslatePower(0.6)
      setCameraFovPower(0.6)
    elseif isClassType == __eClassType_Hashashin then
      x = 43.23
      y = 15.85
      wheel = 608.799
      distance = 800
      setCameraMasterPower(0.7)
      setCameraShakePower(0.4)
      setMotionBlurPower(0.5)
      setCameraTranslatePower(0.6)
      setCameraFovPower(0.6)
    end
  elseif awaken == 1 then
    local isClassType = selfPlayer:getClassType()
    if isClassType == __eClassType_Warrior then
      x = -105
      y = -19
      wheel = 407.600433
      distance = 800
    elseif isClassType == __eClassType_ElfRanger then
      x = -105
      y = -19
      wheel = 407.600433
      distance = 800
    elseif isClassType == __eClassType_Sorcerer then
      x = -105
      y = -19
      wheel = 407.600433
      distance = 800
    elseif isClassType == __eClassType_Giant then
      x = -105
      y = -19
      wheel = 407.600433
      distance = 800
    elseif isClassType == __eClassType_Tamer then
      x = 83.158081
      y = -29.185553
      wheel = 496.800415
      distance = 800
      setCameraMasterPower(0.73)
      setCameraShakePower(0.41)
      setMotionBlurPower(0.25)
      setCameraTranslatePower(0.2)
      setCameraFovPower(0.25)
    elseif isClassType == __eClassType_BladeMaster then
      x = -105
      y = -19
      wheel = 407.600433
      distance = 800
    elseif isClassType == __eClassType_Valkyrie then
      x = -105
      y = -19
      wheel = 407.600433
      distance = 800
    elseif isClassType == __eClassType_BladeMasterWoman then
      x = 151.81631
      y = -23.6354
      wheel = 565.6013183
      distance = 800
      setCameraMasterPower(0.8)
      setCameraShakePower(0.35)
      setMotionBlurPower(0.5)
      setCameraTranslatePower(0.4)
      setCameraFovPower(0.55)
    elseif isClassType == __eClassType_Kunoichi then
      x = 116.451134
      y = -55.236767
      wheel = 468.924469
      distance = 800
      setCameraMasterPower(0.7)
      setCameraShakePower(0.45)
      setMotionBlurPower(0.25)
      setCameraTranslatePower(0.5)
      setCameraFovPower(0.4)
    elseif isClassType == __eClassType_NinjaMan then
      x = 98.83876
      y = -7.596272
      wheel = 507.517852
      distance = 800
      setCameraMasterPower(0.75)
      setCameraShakePower(0.3)
      setMotionBlurPower(0.2)
      setCameraTranslatePower(0.2)
      setCameraFovPower(0.2)
    elseif isClassType == __eClassType_WizardWoman then
      x = -105
      y = -19
      wheel = 407.600433
      distance = 800
    elseif isClassType == __eClassType_WizardMan then
      x = -105
      y = -19
      wheel = 407.600433
      distance = 800
    elseif isClassType == __eClassType_DarkElf then
      x = -105
      y = -19
      wheel = 407.600433
      distance = 800
    elseif isClassType == __eClassType_Combattant then
      x = 112.180626
      y = -40.820633
      wheel = 496.800964
      distance = 800
      setCameraMasterPower(0.85)
      setCameraShakePower(0.65)
      setMotionBlurPower(0.35)
      setCameraTranslatePower(0.4)
      setCameraFovPower(0.4)
    elseif isClassType == __eClassType_Mystic then
      x = 115.175598
      y = -1.510609
      wheel = 468.959442
      distance = 800
      setCameraMasterPower(0.8)
      setCameraShakePower(0.65)
      setMotionBlurPower(0.15)
      setCameraTranslatePower(0.4)
      setCameraFovPower(0.4)
    elseif isClassType == __eClassType_Lhan then
      x = -105
      y = -19
      wheel = 407.600433
      distance = 800
    elseif isClassType == __eClassType_RangerMan then
      x = -105
      y = -19
      wheel = 407.600433
      distance = 800
    elseif isClassType == __eClassType_ShyWaman then
      x = -105
      y = -19
      wheel = 407.600433
      distance = 800
    elseif isClassType == __eClassType_Guardian then
      x = 113.84
      y = -8.87
      wheel = 566.7192
      distance = 800
      setCameraMasterPower(0.7)
      setCameraShakePower(0.4)
      setMotionBlurPower(0.5)
      setCameraTranslatePower(0.6)
      setCameraFovPower(0.6)
    elseif isClassType == __eClassType_Hashashin then
      x = 43.23
      y = 15.85
      wheel = 608.799
      distance = 800
      setCameraMasterPower(0.7)
      setCameraShakePower(0.4)
      setMotionBlurPower(0.5)
      setCameraTranslatePower(0.6)
      setCameraFovPower(0.6)
    end
  else
    Proc_ShowMessage_Ack("\235\185\132\234\176\129\236\132\177 : 0, \234\176\129\236\132\177 : 1")
    return
  end
  characterCameraSetPosAndWheel(float2(x, y), wheel, distance)
end
function UnEquipItemForQA(slotNo)
  local itemWrapper = ToClient_getEquipmentItem(slotNo)
  if nil ~= itemWrapper then
    equipmentDoUnequip(slotNo)
  end
end
function UnEquipAllGstar()
  for ii = 13, 0, -1 do
    UnEquipItemForQA(ii)
  end
  UnEquipItemForQA(29)
end
function createPotionGstar()
  ToClient_qaCreateItem(524, 0, 300)
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  local isClassType = selfPlayer:getClassType()
  if isClassType == __eClassType_Warrior then
    ToClient_qaCreateItem(594, 0, 100)
  elseif isClassType == __eClassType_ElfRanger then
    ToClient_qaCreateItem(526, 0, 100)
  elseif isClassType == __eClassType_Sorcerer then
    ToClient_qaCreateItem(526, 0, 100)
  elseif isClassType == __eClassType_Giant then
    ToClient_qaCreateItem(594, 0, 100)
  elseif isClassType == __eClassType_Tamer then
    ToClient_qaCreateItem(526, 0, 100)
  elseif isClassType == __eClassType_BladeMaster then
    ToClient_qaCreateItem(594, 0, 100)
  elseif isClassType == __eClassType_NinjaMan then
    ToClient_qaCreateItem(594, 0, 100)
  elseif isClassType == __eClassType_WizardWoman then
    ToClient_qaCreateItem(526, 0, 100)
  elseif isClassType == __eClassType_WizardMan then
    ToClient_qaCreateItem(526, 0, 100)
  elseif isClassType == __eClassType_DarkElf then
    ToClient_qaCreateItem(526, 0, 100)
  elseif isClassType == __eClassType_Combattant then
    ToClient_qaCreateItem(594, 0, 100)
  elseif isClassType == __eClassType_Mystic then
    ToClient_qaCreateItem(594, 0, 100)
  elseif isClassType == __eClassType_Lhan then
    ToClient_qaCreateItem(594, 0, 100)
  elseif isClassType == __eClassType_RangerMan then
    ToClient_qaCreateItem(526, 0, 100)
  elseif isClassType == __eClassType_ShyWaman then
    ToClient_qaCreateItem(526, 0, 100)
  end
  ToClient_qaCreateItem(17567, 0, 500)
  ToClient_qaCreateItem(721012, 0, 100)
  ToClient_qaCreateItem(18409, 0, 500)
end
function setps(delay)
  local delaySec
  if delay == nil then
    delaySec = 0
  else
    delaySec = delay * 1000
  end
  ToClient_qaLevelUp(61)
  ToClient_qaRegisterTimerForQA(1000 + delaySec, "UnEquipAllGstar()")
  ToClient_qaRegisterTimerForQA(1000 + delaySec, "UnEquipAllGstar()")
  ToClient_qaRegisterTimerForQA(1000 + delaySec, "ToClient_qaClearInventory()")
  ToClient_qaRegisterTimerForQA(5000 + delaySec, "createPSGstar()")
  ToClient_qaRegisterTimerForQA(1000 + delaySec, "equipAllItemsPSGstar(17)")
  ToClient_qaRegisterTimerForQA(1000 + delaySec, "equipAccessoryPSGstar(18)")
  ToClient_qaRegisterTimerForQA(10000 + delaySec, "telps()")
end
function telps()
  ToClient_qaLevelUp(60)
  ToClient_qaTeleport(473829.3125, -427.214874, 133719.609375)
end
function createPSGstar()
  ToClient_qaCreateItem(44980, 0, 1)
  ToClient_qaCreateItem(41593, 0, 500)
  createPotionGstar()
  chatting_sendMessage("", "/mentalup 400", CppEnums.ChatType.Public)
  ToClient_qaCreateItem(11013, 17, 1)
  ToClient_qaCreateItem(11014, 17, 1)
  ToClient_qaCreateItem(11015, 17, 1)
  ToClient_qaCreateItem(11016, 17, 1)
  ToClient_qaCreateItem(12032, 3, 2)
  ToClient_qaCreateItem(11814, 3, 2)
  ToClient_qaCreateItem(11625, 3, 1)
  ToClient_qaCreateItem(12229, 3, 1)
  createBossWeaponPSGstar(17)
end
function createBossWeaponPSGstar(enchantLevelA)
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  local isClassType = selfPlayer:getClassType()
  if isClassType == __eClassType_Warrior then
    ToClient_qaCreateItem(10010, enchantLevelA, 1)
    ToClient_qaCreateItem(10140, enchantLevelA, 1)
    ToClient_qaCreateItem(14701, enchantLevelA, 1)
  elseif isClassType == __eClassType_ElfRanger then
    ToClient_qaCreateItem(10210, enchantLevelA, 1)
    ToClient_qaCreateItem(10340, enchantLevelA, 1)
    ToClient_qaCreateItem(14731, enchantLevelA, 1)
  elseif isClassType == __eClassType_Sorcerer then
    ToClient_qaCreateItem(10410, enchantLevelA, 1)
    ToClient_qaCreateItem(10540, enchantLevelA, 1)
    ToClient_qaCreateItem(14711, enchantLevelA, 1)
  elseif isClassType == __eClassType_Giant then
    ToClient_qaCreateItem(10610, enchantLevelA, 1)
    ToClient_qaCreateItem(10740, enchantLevelA, 1)
    ToClient_qaCreateItem(14721, enchantLevelA, 1)
  elseif isClassType == __eClassType_BladeMaster then
    ToClient_qaCreateItem(13310, enchantLevelA, 1)
    ToClient_qaCreateItem(13140, enchantLevelA, 1)
    ToClient_qaCreateItem(14761, enchantLevelA, 1)
  elseif isClassType == __eClassType_NinjaMan then
    ToClient_qaCreateItem(13210, enchantLevelA, 1)
    ToClient_qaCreateItem(14640, enchantLevelA, 1)
    ToClient_qaCreateItem(14781, enchantLevelA, 1)
  elseif isClassType == __eClassType_WizardWoman then
    ToClient_qaCreateItem(14410, enchantLevelA, 1)
    ToClient_qaCreateItem(10340, enchantLevelA, 1)
    ToClient_qaCreateItem(14801, enchantLevelA, 1)
  elseif isClassType == __eClassType_WizardMan then
    ToClient_qaCreateItem(14410, enchantLevelA, 1)
    ToClient_qaCreateItem(10340, enchantLevelA, 1)
    ToClient_qaCreateItem(14811, enchantLevelA, 1)
  elseif isClassType == __eClassType_DarkElf then
    ToClient_qaCreateItem(11360, enchantLevelA, 1)
    ToClient_qaCreateItem(10740, enchantLevelA, 1)
    ToClient_qaCreateItem(14816, enchantLevelA, 1)
  elseif isClassType == __eClassType_Lhan then
    ToClient_qaCreateItem(13410, enchantLevelA, 1)
    ToClient_qaCreateItem(13540, enchantLevelA, 1)
    ToClient_qaCreateItem(550501, enchantLevelA, 1)
  end
end
function equipAllItemsPSGstar(enchantLevel)
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  local isClassType = selfPlayer:getClassType()
  if isClassType == __eClassType_Warrior then
    ToClient_qaUseInventoryItem(10010, enchantLevel)
    ToClient_qaUseInventoryItem(10140, enchantLevel)
    ToClient_qaUseInventoryItem(14701, enchantLevel)
  elseif isClassType == __eClassType_ElfRanger then
    ToClient_qaUseInventoryItem(10210, enchantLevel)
    ToClient_qaUseInventoryItem(10340, enchantLevel)
    ToClient_qaUseInventoryItem(14731, enchantLevel)
  elseif isClassType == __eClassType_Sorcerer then
    ToClient_qaUseInventoryItem(10410, enchantLevel)
    ToClient_qaUseInventoryItem(10540, enchantLevel)
    ToClient_qaUseInventoryItem(14711, enchantLevel)
  elseif isClassType == __eClassType_Giant then
    ToClient_qaUseInventoryItem(10610, enchantLevel)
    ToClient_qaUseInventoryItem(10740, enchantLevel)
    ToClient_qaUseInventoryItem(14721, enchantLevel)
  elseif isClassType == __eClassType_BladeMaster then
    ToClient_qaUseInventoryItem(13310, enchantLevel)
    ToClient_qaUseInventoryItem(13140, enchantLevel)
    ToClient_qaUseInventoryItem(14761, enchantLevel)
  elseif isClassType == __eClassType_NinjaMan then
    ToClient_qaUseInventoryItem(13210, enchantLevel)
    ToClient_qaUseInventoryItem(14640, enchantLevel)
    ToClient_qaUseInventoryItem(14781, enchantLevel)
  elseif isClassType == __eClassType_WizardWoman then
    ToClient_qaUseInventoryItem(14410, enchantLevel)
    ToClient_qaUseInventoryItem(10340, enchantLevel)
    ToClient_qaUseInventoryItem(14801, enchantLevel)
  elseif isClassType == __eClassType_WizardMan then
    ToClient_qaUseInventoryItem(14410, enchantLevel)
    ToClient_qaUseInventoryItem(10340, enchantLevel)
    ToClient_qaUseInventoryItem(14811, enchantLevel)
  elseif isClassType == __eClassType_DarkElf then
    ToClient_qaUseInventoryItem(11360, enchantLevel)
    ToClient_qaUseInventoryItem(10740, enchantLevel)
    ToClient_qaUseInventoryItem(14816, enchantLevel)
  elseif isClassType == __eClassType_Lhan then
    ToClient_qaUseInventoryItem(13410, enchantLevel)
    ToClient_qaUseInventoryItem(13540, enchantLevel)
    ToClient_qaUseInventoryItem(550501, enchantLevel)
  end
  ToClient_qaUseInventoryItem(11013, enchantLevel)
  ToClient_qaUseInventoryItem(11014, enchantLevel)
  ToClient_qaUseInventoryItem(11015, enchantLevel)
  ToClient_qaUseInventoryItem(11016, enchantLevel)
end
function equipAccessoryPSGstar(enchantLevel)
  if enchantLevel < 15 then
    enchantLevel = 15
  end
  luaTimer_AddEvent(ToClient_qaUseInventoryItem, 1000, false, 0, 11814, enchantLevel - 15)
  luaTimer_AddEvent(ToClient_qaUseInventoryItem, 1200, false, 0, 12032, enchantLevel - 15)
  luaTimer_AddEvent(ToClient_qaUseInventoryItem, 1400, false, 0, 12229, enchantLevel - 15)
  luaTimer_AddEvent(ToClient_qaUseInventoryItem, 1600, false, 0, 11625, enchantLevel - 15)
  luaTimer_AddEvent(ToClient_qaUseInventoryItem, 1800, false, 0, 11814, enchantLevel - 15)
  luaTimer_AddEvent(ToClient_qaUseInventoryItem, 2000, false, 0, 12032, enchantLevel - 15)
end
function setxb(delay)
  local delaySec
  if delay == nil then
    delaySec = 0
  else
    delaySec = delay * 1000
  end
  ToClient_qaLevelUp(61)
  ToClient_qaRegisterTimerForQA(1000 + delaySec, "UnEquipAllGstar()")
  ToClient_qaRegisterTimerForQA(1000 + delaySec, "UnEquipAllGstar()")
  ToClient_qaRegisterTimerForQA(1000 + delaySec, "ToClient_qaClearInventory()")
  ToClient_qaRegisterTimerForQA(5000 + delaySec, "createXboxGstar()")
  ToClient_qaRegisterTimerForQA(1000 + delaySec, "equipAllItemsXboxGstar(19)")
  ToClient_qaRegisterTimerForQA(1000 + delaySec, "equipAccessoryXboxGstar(19)")
  ToClient_qaRegisterTimerForQA(10000 + delaySec, "telxb()")
end
function telxb()
  ToClient_qaLevelUp(60)
  ToClient_qaTeleport(-385898.46875, 9576.633789, -357725.1875)
end
function createXboxGstar()
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  local isClassType = selfPlayer:getClassType()
  if isClassType == __eClassType_ShyWaman then
    ToClient_qaCreateItem(580001, 0, 1)
  elseif isClassType == __eClassType_Mystic then
    ToClient_qaCreateItem(26033, 0, 1)
  else
    ToClient_qaCreateItem(44980, 0, 1)
  end
  ToClient_qaCreateItem(41614, 0, 500)
  createPotionGstar()
  chatting_sendMessage("", "/mentalup 400", CppEnums.ChatType.Public)
  ToClient_qaCreateItem(11013, 19, 1)
  ToClient_qaCreateItem(11014, 19, 1)
  ToClient_qaCreateItem(11015, 19, 1)
  ToClient_qaCreateItem(11016, 19, 1)
  ToClient_qaCreateItem(12042, 4, 2)
  ToClient_qaCreateItem(11834, 4, 2)
  ToClient_qaCreateItem(11607, 4, 1)
  ToClient_qaCreateItem(12230, 4, 1)
  createBossWeaponXboxGstar(19)
end
function createBossWeaponXboxGstar(enchantLevelA)
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  local isClassType = selfPlayer:getClassType()
  if isClassType == __eClassType_Warrior then
    ToClient_qaCreateItem(10010, enchantLevelA, 1)
    ToClient_qaCreateItem(10140, enchantLevelA, 1)
    ToClient_qaCreateItem(14702, enchantLevelA, 1)
  elseif isClassType == __eClassType_ElfRanger then
    ToClient_qaCreateItem(10210, enchantLevelA, 1)
    ToClient_qaCreateItem(10340, enchantLevelA, 1)
    ToClient_qaCreateItem(14732, enchantLevelA, 1)
  elseif isClassType == __eClassType_Sorcerer then
    ToClient_qaCreateItem(10410, enchantLevelA, 1)
    ToClient_qaCreateItem(10540, enchantLevelA, 1)
    ToClient_qaCreateItem(14712, enchantLevelA, 1)
  elseif isClassType == __eClassType_Giant then
    ToClient_qaCreateItem(10610, enchantLevelA, 1)
    ToClient_qaCreateItem(10740, enchantLevelA, 1)
    ToClient_qaCreateItem(14722, enchantLevelA, 1)
  elseif isClassType == __eClassType_Tamer then
    ToClient_qaCreateItem(13210, enchantLevelA, 1)
    ToClient_qaCreateItem(13040, enchantLevelA, 1)
    ToClient_qaCreateItem(14742, enchantLevelA, 1)
  elseif isClassType == __eClassType_BladeMaster then
    ToClient_qaCreateItem(13310, enchantLevelA, 1)
    ToClient_qaCreateItem(13140, enchantLevelA, 1)
    ToClient_qaCreateItem(14762, enchantLevelA, 1)
  elseif isClassType == __eClassType_NinjaMan then
    ToClient_qaCreateItem(13210, enchantLevelA, 1)
    ToClient_qaCreateItem(14640, enchantLevelA, 1)
    ToClient_qaCreateItem(14782, enchantLevelA, 1)
  elseif isClassType == __eClassType_WizardWoman then
    ToClient_qaCreateItem(14410, enchantLevelA, 1)
    ToClient_qaCreateItem(10340, enchantLevelA, 1)
    ToClient_qaCreateItem(14802, enchantLevelA, 1)
  elseif isClassType == __eClassType_WizardMan then
    ToClient_qaCreateItem(14410, enchantLevelA, 1)
    ToClient_qaCreateItem(10340, enchantLevelA, 1)
    ToClient_qaCreateItem(14812, enchantLevelA, 1)
  elseif isClassType == __eClassType_DarkElf then
    ToClient_qaCreateItem(11360, enchantLevelA, 1)
    ToClient_qaCreateItem(10740, enchantLevelA, 1)
    ToClient_qaCreateItem(14817, enchantLevelA, 1)
  elseif isClassType == __eClassType_Combattant then
    ToClient_qaCreateItem(11210, enchantLevelA, 1)
    ToClient_qaCreateItem(11340, enchantLevelA, 1)
    ToClient_qaCreateItem(14822, enchantLevelA, 1)
  elseif isClassType == __eClassType_Mystic then
    ToClient_qaCreateItem(11210, enchantLevelA, 1)
    ToClient_qaCreateItem(11340, enchantLevelA, 1)
  elseif isClassType == __eClassType_Lhan then
    ToClient_qaCreateItem(13410, enchantLevelA, 1)
    ToClient_qaCreateItem(13540, enchantLevelA, 1)
    ToClient_qaCreateItem(550502, enchantLevelA, 1)
  elseif isClassType == __eClassType_RangerMan then
    ToClient_qaCreateItem(13710, enchantLevelA, 1)
    ToClient_qaCreateItem(13840, enchantLevelA, 1)
    ToClient_qaCreateItem(13903, enchantLevelA, 1)
  elseif isClassType == __eClassType_ShyWaman then
    ToClient_qaCreateItem(718510, enchantLevelA, 1)
    ToClient_qaCreateItem(719040, enchantLevelA, 1)
    ToClient_qaCreateItem(690004, enchantLevelA, 1)
  end
end
function equipAllItemsXboxGstar(enchantLevel)
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  local isClassType = selfPlayer:getClassType()
  if isClassType == __eClassType_Warrior then
    ToClient_qaUseInventoryItem(10010, enchantLevel)
    ToClient_qaUseInventoryItem(10140, enchantLevel)
    ToClient_qaUseInventoryItem(14702, enchantLevel)
  elseif isClassType == __eClassType_ElfRanger then
    ToClient_qaUseInventoryItem(10210, enchantLevel)
    ToClient_qaUseInventoryItem(10340, enchantLevel)
    ToClient_qaUseInventoryItem(14732, enchantLevel)
  elseif isClassType == __eClassType_Sorcerer then
    ToClient_qaUseInventoryItem(10410, enchantLevel)
    ToClient_qaUseInventoryItem(10540, enchantLevel)
    ToClient_qaUseInventoryItem(14712, enchantLevel)
  elseif isClassType == __eClassType_Giant then
    ToClient_qaUseInventoryItem(10610, enchantLevel)
    ToClient_qaUseInventoryItem(10740, enchantLevel)
    ToClient_qaUseInventoryItem(14722, enchantLevel)
  elseif isClassType == __eClassType_Tamer then
    ToClient_qaUseInventoryItem(13210, enchantLevel)
    ToClient_qaUseInventoryItem(13040, enchantLevel)
    ToClient_qaUseInventoryItem(14742, enchantLevel)
  elseif isClassType == __eClassType_BladeMaster then
    ToClient_qaUseInventoryItem(13310, enchantLevel)
    ToClient_qaUseInventoryItem(13140, enchantLevel)
    ToClient_qaUseInventoryItem(14762, enchantLevel)
  elseif isClassType == __eClassType_NinjaMan then
    ToClient_qaUseInventoryItem(13210, enchantLevel)
    ToClient_qaUseInventoryItem(14640, enchantLevel)
    ToClient_qaUseInventoryItem(14782, enchantLevel)
  elseif isClassType == __eClassType_WizardWoman then
    ToClient_qaUseInventoryItem(14410, enchantLevel)
    ToClient_qaUseInventoryItem(10340, enchantLevel)
    ToClient_qaUseInventoryItem(14802, enchantLevel)
  elseif isClassType == __eClassType_WizardMan then
    ToClient_qaUseInventoryItem(14410, enchantLevel)
    ToClient_qaUseInventoryItem(10340, enchantLevel)
    ToClient_qaUseInventoryItem(14812, enchantLevel)
  elseif isClassType == __eClassType_DarkElf then
    ToClient_qaUseInventoryItem(11360, enchantLevel)
    ToClient_qaUseInventoryItem(10740, enchantLevel)
    ToClient_qaUseInventoryItem(14817, enchantLevel)
  elseif isClassType == __eClassType_Combattant then
    ToClient_qaUseInventoryItem(11210, enchantLevel)
    ToClient_qaUseInventoryItem(11340, enchantLevel)
    ToClient_qaUseInventoryItem(14822, enchantLevel)
  elseif isClassType == __eClassType_Mystic then
    ToClient_qaUseInventoryItem(11210, enchantLevel)
    ToClient_qaUseInventoryItem(11340, enchantLevel)
    ToClient_qaUseInventoryItem(14830, enchantLevel)
  elseif isClassType == __eClassType_Lhan then
    ToClient_qaUseInventoryItem(13410, enchantLevel)
    ToClient_qaUseInventoryItem(13540, enchantLevel)
    ToClient_qaUseInventoryItem(550502, enchantLevel)
  elseif isClassType == __eClassType_RangerMan then
    ToClient_qaUseInventoryItem(13710, enchantLevel)
    ToClient_qaUseInventoryItem(13840, enchantLevel)
    ToClient_qaUseInventoryItem(13903, enchantLevel)
  elseif isClassType == __eClassType_ShyWaman then
    ToClient_qaUseInventoryItem(718510, enchantLevel)
    ToClient_qaUseInventoryItem(719040, enchantLevel)
    ToClient_qaUseInventoryItem(690004, enchantLevel)
  end
  ToClient_qaUseInventoryItem(11013, enchantLevel)
  ToClient_qaUseInventoryItem(11014, enchantLevel)
  ToClient_qaUseInventoryItem(11015, enchantLevel)
  ToClient_qaUseInventoryItem(11016, enchantLevel)
end
function equipAccessoryXboxGstar(enchantLevel)
  if enchantLevel < 15 then
    enchantLevel = 15
  end
  luaTimer_AddEvent(ToClient_qaUseInventoryItem, 1000, false, 0, 11834, enchantLevel - 15)
  luaTimer_AddEvent(ToClient_qaUseInventoryItem, 1200, false, 0, 12042, enchantLevel - 15)
  luaTimer_AddEvent(ToClient_qaUseInventoryItem, 1400, false, 0, 12230, enchantLevel - 15)
  luaTimer_AddEvent(ToClient_qaUseInventoryItem, 1600, false, 0, 11607, enchantLevel - 15)
  luaTimer_AddEvent(ToClient_qaUseInventoryItem, 1800, false, 0, 11834, enchantLevel - 15)
  luaTimer_AddEvent(ToClient_qaUseInventoryItem, 2000, false, 0, 12042, enchantLevel - 15)
end
function intimacy(value)
  local interactableActor = interaction_getInteractable()
  local characterKey
  if interactableActor ~= nil then
    characterKeyRaw = interactableActor:getCharacterKeyRaw()
    ToClient_qaUpIntimacy(characterKeyRaw, value)
  else
    return
  end
end
registerEvent("FromClient_QADebugSkillName", "FromClient_QADebugSkillName")
registerEvent("FromClient_QACreateItemAndEquip", "PaGlobalFunc_QaCreateAndEquip")
registerEvent("FromClient_QADebugCountDamage", "FromClient_QADebugCountDamage")
registerEvent("FromClient_QADebugMinMaxDamage", "FromClient_QADebugMinMaxDamage")
function petControl_AllSeal_ForQA()
  local sealPetCount = ToClient_getPetSealedList()
  local unSealPetCount = ToClient_getPetUnsealedList()
  local enableUnSealCount = 5 - unSealPetCount
  if 0 == sealPetCount then
    return
  end
  for petIndex = 0, enableUnSealCount - 1 do
    local petData = ToClient_getPetSealedDataByIndex(petIndex)
    local petNo_s64 = petData._petNo
    petListNew_UnSeal(tostring(petNo_s64), true)
  end
end
function petControl_ReverseAllSeal_ForQA()
  local sealPetCount = ToClient_getPetSealedList()
  local unSealPetCount = ToClient_getPetUnsealedList()
  local enableUnSealCount = 5 - unSealPetCount
  if 0 == sealPetCount then
    return
  end
  for petIndex = 0, enableUnSealCount - 1 do
    local petLastIndex = sealPetCount - 1 - petIndex
    local petData = ToClient_getPetSealedDataByIndex(petLastIndex)
    local petNo_s64 = petData._petNo
    petListNew_UnSeal(tostring(petNo_s64), true)
  end
end
PaGlobalQASupport = {
  _WarriorSkillList_0 = {
    2831,
    1083,
    706,
    1084,
    1085,
    195,
    357,
    173,
    174,
    712,
    1145,
    377,
    2841,
    2842,
    1136,
    1137,
    286,
    709,
    1138,
    590,
    2845,
    589,
    2846,
    385,
    350,
    351,
    705,
    376,
    707,
    1139,
    1140,
    1141,
    2838,
    352,
    353,
    579,
    1127,
    1128,
    1129,
    196,
    96,
    710,
    1080,
    1081,
    1082,
    715,
    1146,
    1147,
    1330,
    1148,
    2832,
    1000,
    305,
    198,
    306,
    355,
    387,
    2844,
    708,
    1142,
    1143,
    2839,
    713,
    714,
    711,
    1078,
    1079,
    388,
    2837,
    197,
    369,
    370,
    1130,
    1131,
    1132,
    2835,
    356,
    578,
    994,
    995,
    217,
    218,
    219,
    2851,
    1133,
    1134,
    1135,
    577,
    1441,
    1442,
    1443,
    1444,
    2850,
    591,
    592,
    593,
    594,
    595,
    596,
    597,
    598,
    599,
    600,
    601,
    602,
    603,
    604,
    605,
    606,
    607,
    608,
    609,
    610,
    4856,
    1702,
    1703,
    1704,
    1705,
    1706,
    1707,
    2072,
    2073,
    2074,
    2075,
    2076
  },
  _WarriorSkillList_1 = {
    4062,
    4066,
    4081,
    4071,
    4072,
    4073,
    4074,
    4075,
    4080,
    4086,
    4087,
    4088,
    4067,
    4089,
    4090,
    4091,
    4064,
    4082,
    4083,
    4084,
    4063,
    4127,
    4128,
    4124,
    4125,
    4126,
    4065,
    4092,
    4093,
    4077,
    4070,
    4068,
    4069,
    4078,
    4079
  },
  _WarriorSkillList_2 = {
    1733,
    1734,
    1735,
    1736,
    1766,
    1767,
    1768,
    1759,
    1760,
    1761,
    1762,
    4837,
    4838,
    4839,
    1727,
    1728,
    1751,
    1752,
    1753,
    1748,
    1730,
    1729,
    1737,
    1754,
    1758,
    1755,
    1738,
    580,
    2833,
    2840,
    2848,
    2847,
    2843,
    2834,
    313,
    2852,
    2836,
    2849
  },
  _ElfRangerSkillList_0 = {
    2853,
    308,
    309,
    2867,
    1389,
    1390,
    1401,
    1091,
    1092,
    1093,
    375,
    1102,
    1110,
    1254,
    1255,
    2861,
    1113,
    1114,
    1115,
    318,
    1112,
    323,
    324,
    2868,
    1090,
    1088,
    2854,
    1253,
    374,
    2860,
    1116,
    1257,
    1428,
    319,
    320,
    321,
    1119,
    1250,
    1251,
    2864,
    1099,
    1100,
    1101,
    1125,
    1126,
    1448,
    1095,
    1096,
    1097,
    1098,
    2857,
    1103,
    1104,
    1105,
    1364,
    1365,
    1366,
    1367,
    1449,
    176,
    177,
    178,
    179,
    180,
    181,
    182,
    183,
    184,
    185,
    186,
    187,
    188,
    189,
    190,
    191,
    192,
    193,
    194,
    4854,
    1369,
    1370,
    1371,
    1372,
    1373,
    1374,
    1375,
    1376,
    1377,
    383,
    1402,
    1403,
    384,
    1404,
    1405,
    1406,
    1408,
    1438,
    1439,
    1416,
    1407,
    381,
    382,
    1409,
    1410,
    1702,
    1703,
    1704,
    1705,
    1706,
    1707,
    2072,
    2073,
    2074,
    2075,
    2076
  },
  _ElfRangerSkillList_1 = {
    4107,
    4114,
    4108,
    4109,
    4110,
    4111,
    4112,
    4113,
    4119,
    4191,
    4192,
    4193,
    4121,
    4194,
    4195,
    4196,
    4122,
    4197,
    4198,
    4199,
    4116,
    4169,
    4186,
    4115,
    4120,
    4187,
    4123,
    4189,
    4190,
    4117,
    4118,
    4188,
    4134,
    4235,
    4236
  },
  _ElfRangerSkillList_2 = {
    1876,
    1877,
    1878,
    1857,
    1858,
    1859,
    1860,
    1879,
    1880,
    1881,
    1882,
    1884,
    1885,
    1886,
    1887,
    1888,
    1890,
    1891,
    1892,
    1873,
    1893,
    1861,
    1889,
    1894,
    1895,
    1896,
    1897,
    2855,
    2856,
    2862,
    2863,
    2858,
    2865,
    2859,
    2866
  },
  _SorcererSkillList_0 = {
    2878,
    1413,
    1360,
    1361,
    1362,
    2880,
    162,
    163,
    1208,
    2879,
    310,
    171,
    172,
    378,
    311,
    584,
    312,
    1196,
    1197,
    1198,
    581,
    2874,
    1430,
    1431,
    1432,
    2888,
    585,
    586,
    587,
    588,
    1415,
    1354,
    1355,
    1417,
    1418,
    348,
    1183,
    1184,
    347,
    1357,
    1358,
    1210,
    160,
    161,
    1202,
    1203,
    583,
    1204,
    1205,
    94,
    1182,
    199,
    200,
    2881,
    169,
    2884,
    1185,
    1186,
    1187,
    2870,
    1201,
    379,
    170,
    1060,
    582,
    165,
    166,
    95,
    167,
    168,
    2883,
    1191,
    1192,
    1193,
    1194,
    2872,
    1188,
    1189,
    1190,
    1500,
    1199,
    1200,
    1195,
    93,
    1209,
    44,
    45,
    46,
    47,
    48,
    49,
    50,
    51,
    52,
    53,
    4855,
    54,
    55,
    56,
    57,
    58,
    59,
    60,
    61,
    62,
    63,
    1702,
    1703,
    1704,
    1705,
    1706,
    1707,
    2072,
    2073,
    2074,
    2075,
    2076
  },
  _SorcererSkillList_1 = {
    4563,
    4564,
    4591,
    4586,
    4587,
    4588,
    4589,
    4590,
    4573,
    4574,
    4575,
    4576,
    4565,
    4566,
    4567,
    4568,
    4569,
    4570,
    4571,
    4572,
    4583,
    4584,
    4585,
    4580,
    4581,
    4582,
    4577,
    4578,
    4579,
    4592,
    4595,
    4594,
    4593,
    4596,
    4597
  },
  _SorcererSkillList_2 = {
    1790,
    1786,
    1787,
    1788,
    1802,
    1803,
    1804,
    1805,
    1806,
    1793,
    1794,
    1795,
    1796,
    1780,
    1781,
    1782,
    1784,
    1791,
    1797,
    1807,
    1808,
    1809,
    1810,
    1798,
    1799,
    1800,
    1801,
    1811,
    2885,
    2869,
    2887,
    2886,
    2876,
    2877,
    2882,
    2871,
    2875,
    2873
  },
  _GiantSkillList_0 = {
    243,
    2899,
    1159,
    1291,
    1292,
    373,
    2893,
    390,
    1153,
    1154,
    1155,
    2891,
    1151,
    1152,
    372,
    301,
    302,
    2903,
    1157,
    1158,
    2892,
    1162,
    1293,
    1294,
    1160,
    1161,
    1391,
    288,
    289,
    2900,
    1393,
    1394,
    291,
    292,
    2901,
    1395,
    298,
    299,
    300,
    2902,
    1397,
    315,
    316,
    317,
    368,
    391,
    295,
    1163,
    1164,
    1165,
    1166,
    296,
    325,
    326,
    327,
    328,
    329,
    1167,
    1168,
    1169,
    1170,
    1171,
    389,
    121,
    1172,
    1173,
    1174,
    1175,
    1176,
    1177,
    1178,
    1179,
    1149,
    1150,
    1425,
    1426,
    1427,
    2907,
    213,
    214,
    215,
    1419,
    1420,
    1421,
    2905,
    1422,
    1423,
    1424,
    2906,
    1058,
    267,
    268,
    269,
    270,
    271,
    272,
    273,
    274,
    275,
    276,
    277,
    278,
    279,
    280,
    281,
    282,
    283,
    284,
    285,
    4852,
    1702,
    1703,
    1704,
    1705,
    1706,
    1707,
    2072,
    2073,
    2074,
    2075,
    2076,
    1392,
    1396,
    1398,
    1399,
    1400
  },
  _GiantSkillList_1 = {
    5410,
    5411,
    5412,
    5413,
    5414,
    5415,
    5416,
    5417,
    5422,
    5423,
    5424,
    5425,
    5418,
    5419,
    5420,
    5421,
    5426,
    5427,
    5428,
    5429,
    5436,
    5437,
    5438,
    5430,
    5431,
    5432,
    5433,
    5434,
    5435,
    5439,
    5440,
    5441,
    5442,
    5443,
    5444
  },
  _GiantSkillList_2 = {
    1824,
    1825,
    1826,
    1841,
    1842,
    1843,
    1831,
    1832,
    1833,
    1827,
    1828,
    1829,
    1837,
    1838,
    1839,
    1840,
    1834,
    1835,
    1836,
    1852,
    1854,
    1846,
    1848,
    1849,
    1850,
    1853,
    1851,
    2890,
    2894,
    2904,
    2895,
    2896,
    2897,
    2898,
    2889
  },
  _TamerSkillList_0 = {
    2914,
    134,
    135,
    2920,
    362,
    363,
    1222,
    1223,
    2919,
    1220,
    1221,
    2918,
    84,
    228,
    1217,
    1218,
    1219,
    2917,
    240,
    241,
    2934,
    1338,
    1339,
    1340,
    1341,
    1342,
    1343,
    1344,
    1345,
    1346,
    1347,
    34,
    35,
    36,
    229,
    230,
    231,
    1224,
    1225,
    1226,
    2921,
    85,
    86,
    87,
    2922,
    41,
    42,
    2923,
    37,
    358,
    359,
    360,
    361,
    38,
    12,
    13,
    14,
    18,
    15,
    16,
    17,
    19,
    223,
    224,
    130,
    131,
    132,
    205,
    1227,
    1228,
    1229,
    227,
    204,
    1235,
    1236,
    1230,
    1231,
    1309,
    1310,
    1311,
    1246,
    1247,
    1248,
    1249,
    1295,
    236,
    237,
    238,
    239,
    1076,
    2933,
    209,
    210,
    211,
    212,
    1232,
    1233,
    1234,
    2926,
    1241,
    1242,
    1243,
    1244,
    1245,
    4863,
    4864,
    4865,
    4866,
    4867,
    4868,
    4869,
    4870,
    4871,
    4872,
    4873,
    4874,
    4875,
    4876,
    4877,
    4878,
    4879,
    4880,
    4881,
    4882,
    4883,
    1702,
    1703,
    1704,
    1705,
    1706,
    1707,
    2072,
    2073,
    2074,
    2075,
    2076,
    40,
    43,
    225,
    226
  },
  _TamerSkillList_1 = {
    4475,
    4476,
    4477,
    4478,
    4479,
    4480,
    4481,
    4482,
    4483,
    4484,
    4485,
    4486,
    4487,
    4488,
    4489,
    4490,
    4491,
    4492,
    4493,
    4494,
    4498,
    4499,
    4500,
    4495,
    4496,
    4497,
    4501,
    4502,
    4503,
    4504,
    4505,
    4506,
    4507,
    4778,
    4779
  },
  _TamerSkillList_2 = {
    1927,
    1914,
    1915,
    1916,
    1910,
    1911,
    1912,
    1935,
    1934,
    1936,
    1933,
    1923,
    1924,
    1925,
    1926,
    1930,
    1931,
    1932,
    1937,
    1940,
    1918,
    1919,
    1920,
    1921,
    1922,
    1928,
    1929,
    1939,
    1938,
    2555,
    2915,
    2916,
    2930,
    2924,
    2927,
    2925,
    2932,
    2929,
    2931,
    2928
  },
  _BladeMasterSkillList_0 = {
    3153,
    1262,
    1460,
    1461,
    1269,
    159,
    1270,
    1286,
    1287,
    1288,
    425,
    420,
    421,
    1320,
    1321,
    3165,
    1322,
    1450,
    1451,
    3166,
    399,
    400,
    1459,
    1456,
    1457,
    1264,
    1265,
    418,
    201,
    3154,
    1266,
    202,
    392,
    3156,
    1272,
    393,
    3157,
    1276,
    1277,
    1278,
    1273,
    394,
    3158,
    1274,
    395,
    3159,
    402,
    403,
    415,
    416,
    423,
    405,
    1297,
    1298,
    406,
    1299,
    1300,
    3164,
    3173,
    1324,
    3168,
    1314,
    1446,
    1447,
    396,
    1323,
    397,
    398,
    1465,
    1289,
    1280,
    1281,
    1282,
    3161,
    1325,
    1326,
    1454,
    1327,
    1283,
    1453,
    1284,
    3230,
    1462,
    1463,
    1464,
    1,
    2,
    3,
    4,
    5,
    6,
    7,
    8,
    9,
    10,
    4844,
    21,
    22,
    23,
    24,
    25,
    26,
    27,
    28,
    29,
    30,
    1702,
    1703,
    1704,
    1705,
    1706,
    1707,
    2072,
    2073,
    2074,
    2075,
    2076
  },
  _BladeMasterSkillList_1 = {
    4734,
    4766,
    4740,
    4735,
    4736,
    4737,
    4738,
    4739,
    4741,
    4742,
    4743,
    4744,
    4745,
    4746,
    4747,
    4748,
    4749,
    4750,
    4751,
    4752,
    4760,
    4761,
    4762,
    4763,
    4764,
    4765,
    4753,
    4754,
    4755,
    4759,
    4757,
    4756,
    4758,
    4768,
    4767
  },
  _BladeMasterSkillList_2 = {
    1987,
    2001,
    2002,
    2003,
    2012,
    2013,
    2014,
    2021,
    2022,
    2028,
    2023,
    2005,
    2006,
    2007,
    2015,
    2016,
    2017,
    2025,
    2026,
    2008,
    2009,
    2010,
    2011,
    2018,
    2019,
    2020,
    2027,
    2024,
    3155,
    3162,
    3171,
    3174,
    3160,
    3172,
    3163,
    3169,
    3170,
    3167
  },
  _ValkyrieSkillList_0 = {
    3196,
    1477,
    1478,
    3197,
    782,
    748,
    749,
    3198,
    783,
    1488,
    1489,
    3199,
    1480,
    1481,
    1482,
    1483,
    3200,
    763,
    764,
    3201,
    733,
    734,
    735,
    770,
    731,
    1498,
    1499,
    3203,
    719,
    730,
    769,
    1485,
    1486,
    784,
    737,
    738,
    772,
    720,
    721,
    722,
    785,
    773,
    754,
    755,
    756,
    3206,
    774,
    1495,
    1496,
    1491,
    1492,
    1493,
    771,
    3209,
    724,
    725,
    726,
    3210,
    728,
    729,
    3211,
    3212,
    777,
    778,
    779,
    780,
    3213,
    740,
    741,
    742,
    743,
    745,
    746,
    3215,
    751,
    752,
    753,
    3220,
    758,
    759,
    760,
    761,
    766,
    767,
    768,
    775,
    591,
    592,
    593,
    594,
    595,
    596,
    597,
    598,
    599,
    600,
    601,
    602,
    603,
    604,
    605,
    606,
    607,
    608,
    609,
    610,
    4856,
    1702,
    1703,
    1704,
    1705,
    1706,
    1707,
    2072,
    2073,
    2074,
    2075,
    2076
  },
  _ValkyrieSkillList_1 = {
    4135,
    4142,
    4141,
    4136,
    4137,
    4138,
    4139,
    4140,
    4147,
    4218,
    4219,
    4220,
    4146,
    4212,
    4213,
    4223,
    4151,
    4224,
    4225,
    4226,
    4150,
    4216,
    4217,
    4149,
    4221,
    4222,
    4148,
    4214,
    4215,
    4145,
    4143,
    4144,
    4211,
    4152,
    4153
  },
  _ValkyrieSkillList_2 = {
    1964,
    1965,
    1966,
    1955,
    1956,
    1957,
    1981,
    1967,
    1985,
    1982,
    1958,
    1959,
    1960,
    1961,
    1972,
    1973,
    1974,
    1978,
    1979,
    1968,
    1969,
    1970,
    1971,
    1975,
    1976,
    1977,
    1984,
    1983,
    3202,
    3219,
    3204,
    3205,
    3207,
    3208,
    3214,
    3217,
    3218
  },
  _BladeMasterWomanSkillList_0 = {
    3175,
    1505,
    1513,
    1514,
    1524,
    1525,
    1526,
    3177,
    1550,
    1551,
    1552,
    1553,
    1595,
    1596,
    3195,
    1562,
    1563,
    1619,
    1564,
    1565,
    1566,
    3188,
    1579,
    1580,
    1581,
    1589,
    1590,
    3229,
    1592,
    1593,
    1516,
    1517,
    1518,
    1520,
    1519,
    1521,
    1536,
    1537,
    1538,
    1531,
    3178,
    1528,
    1532,
    3179,
    1529,
    1533,
    3180,
    1530,
    1534,
    3181,
    1583,
    1584,
    1585,
    1586,
    1587,
    1556,
    1557,
    1558,
    1559,
    3186,
    1568,
    3190,
    1560,
    1567,
    1554,
    1573,
    1574,
    1575,
    1576,
    1577,
    1578,
    3192,
    1540,
    1541,
    1542,
    3183,
    1569,
    1570,
    1571,
    1543,
    1545,
    1544,
    1546,
    1547,
    1548,
    1618,
    1597,
    1598,
    1599,
    1600,
    1601,
    1602,
    1603,
    1604,
    1605,
    1606,
    4845,
    1607,
    1608,
    1609,
    1610,
    1611,
    1612,
    1613,
    1614,
    1615,
    1616,
    1702,
    1703,
    1704,
    1705,
    1706,
    1707,
    2072,
    2073,
    2074,
    2075,
    2076
  },
  _BladeMasterWomanSkillList_1 = {
    4170,
    4243,
    4176,
    4171,
    4172,
    4173,
    4174,
    4175,
    4179,
    4675,
    4676,
    4677,
    4180,
    4678,
    4679,
    4680,
    4184,
    4685,
    4686,
    4687,
    4182,
    4681,
    4682,
    4178,
    4673,
    4674,
    4183,
    4683,
    4684,
    4177,
    4185,
    4181,
    4244,
    4688,
    4689
  },
  _BladeMasterWomanSkillList_2 = {
    2066,
    2048,
    2041,
    2042,
    2043,
    2050,
    2051,
    2052,
    2053,
    2044,
    2045,
    2046,
    2047,
    2058,
    2059,
    2060,
    2054,
    2055,
    2056,
    2061,
    2062,
    2063,
    2067,
    2049,
    2064,
    2071,
    2069,
    2057,
    2070,
    2068,
    3184,
    3187,
    3193,
    3176,
    3182,
    3194,
    3185,
    3191,
    3189,
    3231
  },
  _KunoichiSkillList_0 = {
    3101,
    1650,
    1651,
    1652,
    1653,
    1668,
    1669,
    1670,
    919,
    920,
    916,
    917,
    950,
    951,
    1624,
    1625,
    975,
    976,
    952,
    1660,
    1661,
    3122,
    973,
    974,
    942,
    3105,
    943,
    944,
    3106,
    945,
    934,
    935,
    3103,
    693,
    694,
    695,
    938,
    939,
    3104,
    690,
    691,
    692,
    1663,
    1664,
    1665,
    1666,
    3123,
    981,
    982,
    983,
    984,
    922,
    977,
    978,
    979,
    3114,
    947,
    948,
    3107,
    967,
    968,
    969,
    970,
    992,
    998,
    3117,
    959,
    960,
    961,
    963,
    964,
    965,
    988,
    989,
    990,
    986,
    987,
    702,
    703,
    704,
    1627,
    1628,
    3120,
    697,
    698,
    699,
    3118,
    999,
    1655,
    1656,
    1657,
    1658,
    3121,
    954,
    955,
    956,
    957,
    1629,
    1630,
    1631,
    1632,
    1633,
    1634,
    1635,
    1636,
    1637,
    1638,
    1639,
    1640,
    1641,
    1642,
    1643,
    1644,
    1645,
    1646,
    1647,
    1648,
    4853,
    1702,
    1703,
    1704,
    1705,
    1706,
    1707,
    2072,
    2073,
    2074,
    2075,
    2076
  },
  _KunoichiSkillList_1 = {
    4629,
    4630,
    4632,
    4633,
    4634,
    4635,
    4636,
    4637,
    4647,
    4648,
    4649,
    4650,
    4651,
    4652,
    4653,
    4654,
    4655,
    4656,
    4657,
    4658,
    4641,
    4642,
    4643,
    4638,
    4639,
    4640,
    4644,
    4645,
    4646,
    4659,
    4660,
    4661,
    4662,
    4663,
    4664
  },
  _KunoichiSkillList_2 = {
    2128,
    2121,
    2122,
    2123,
    2124,
    2155,
    2156,
    2157,
    2145,
    2146,
    2147,
    2148,
    2140,
    2141,
    2142,
    2160,
    2161,
    2162,
    2125,
    2126,
    2127,
    2144,
    2143,
    2152,
    2153,
    2158,
    2151,
    2159,
    2149,
    3108,
    3113,
    3112,
    3110,
    3111,
    3116,
    3115,
    3119,
    3127,
    3109
  },
  _NinjaManSkillList_0 = {
    3102,
    1708,
    1709,
    1710,
    1711,
    1668,
    1669,
    1670,
    919,
    920,
    916,
    917,
    950,
    951,
    1624,
    1625,
    952,
    1660,
    1661,
    3122,
    973,
    974,
    3113,
    1682,
    1683,
    1684,
    942,
    3105,
    943,
    944,
    3106,
    945,
    934,
    935,
    3103,
    693,
    694,
    695,
    938,
    939,
    3104,
    1675,
    1676,
    1677,
    1678,
    1679,
    1680,
    1663,
    1664,
    1665,
    1666,
    981,
    982,
    983,
    984,
    1701,
    977,
    978,
    979,
    3114,
    947,
    948,
    3107,
    967,
    968,
    969,
    970,
    3112,
    992,
    998,
    3117,
    959,
    960,
    961,
    963,
    964,
    965,
    3111,
    988,
    989,
    990,
    3116,
    1686,
    1687,
    3129,
    702,
    703,
    704,
    3119,
    697,
    698,
    699,
    3118,
    1681,
    1655,
    1656,
    1657,
    1658,
    1699,
    1700,
    1629,
    1630,
    1631,
    1632,
    1633,
    1634,
    1635,
    1636,
    1637,
    1638,
    1639,
    1640,
    1641,
    1642,
    1643,
    1644,
    1645,
    1646,
    1647,
    1648,
    4853,
    1702,
    1703,
    1704,
    1705,
    1706,
    1707,
    2072,
    2073,
    2074,
    2075,
    2076
  },
  _NinjaManSkillList_1 = {
    4690,
    4691,
    4693,
    4694,
    4695,
    4696,
    4697,
    4698,
    4708,
    4709,
    4710,
    4711,
    4712,
    4713,
    4714,
    4715,
    4716,
    4717,
    4718,
    4719,
    4699,
    4700,
    4701,
    4702,
    4703,
    4704,
    4705,
    4706,
    4707,
    4723,
    4721,
    4722,
    4720,
    4724,
    4725
  },
  _NinjaManSkillList_2 = {
    2095,
    2100,
    2105,
    2106,
    2107,
    2088,
    2089,
    2090,
    2091,
    2110,
    2111,
    2112,
    2113,
    2098,
    2099,
    2117,
    2118,
    2119,
    2092,
    2093,
    2094,
    2096,
    2101,
    2102,
    2108,
    2103,
    2115,
    2114,
    2116,
    3108,
    3124,
    3125,
    3123,
    3110,
    3128,
    3121,
    3126
  },
  _WizardWomanSkillList_0 = {
    787,
    788,
    789,
    791,
    792,
    794,
    795,
    796,
    797,
    798,
    799,
    800,
    801,
    802,
    803,
    804,
    805,
    806,
    807,
    808,
    809,
    810,
    811,
    812,
    813,
    814,
    815,
    816,
    819,
    820,
    821,
    823,
    824,
    825,
    826,
    828,
    829,
    830,
    831,
    832,
    833,
    835,
    836,
    837,
    838,
    839,
    840,
    841,
    842,
    843,
    844,
    845,
    846,
    847,
    848,
    849,
    851,
    852,
    853,
    854,
    855,
    856,
    857,
    858,
    859,
    861,
    862,
    863,
    864,
    866,
    867,
    869,
    870,
    871,
    873,
    874,
    875,
    876,
    887,
    888,
    889,
    891,
    892,
    894,
    895,
    896,
    897,
    898,
    900,
    901,
    902,
    903,
    905,
    906,
    907,
    908,
    909,
    910,
    911,
    913,
    914,
    1120,
    1121,
    1122,
    1621,
    1622,
    2208,
    4847,
    3232,
    1702,
    1703,
    1704,
    1705,
    1706,
    1707,
    2072,
    2073,
    2074,
    2075,
    2076
  },
  _WizardWomanSkillList_1 = {
    4933,
    4934,
    4936,
    4937,
    4938,
    4939,
    4935,
    4978,
    4941,
    4990,
    4991,
    4956,
    5313,
    5314,
    4951,
    5307,
    5308,
    4946,
    5301,
    5302
  },
  _WizardWomanSkillList_2 = {
    2164,
    2166,
    2180,
    2181,
    2182,
    2183,
    2184,
    2185,
    2187,
    2188,
    2189,
    2190,
    2191,
    2192,
    2193,
    2194,
    2195,
    2196,
    2197,
    2198,
    2199,
    2201,
    2202,
    2203,
    2205,
    2206,
    2207
  },
  _WizardManSkillList_0 = {
    787,
    788,
    789,
    791,
    792,
    794,
    795,
    796,
    797,
    798,
    799,
    800,
    801,
    802,
    803,
    804,
    805,
    806,
    807,
    808,
    809,
    810,
    811,
    812,
    813,
    814,
    815,
    816,
    819,
    820,
    821,
    823,
    824,
    825,
    826,
    828,
    829,
    830,
    831,
    832,
    833,
    835,
    836,
    837,
    838,
    839,
    840,
    841,
    842,
    843,
    844,
    845,
    846,
    847,
    848,
    849,
    851,
    852,
    853,
    854,
    855,
    856,
    857,
    858,
    859,
    861,
    862,
    863,
    864,
    866,
    867,
    869,
    870,
    871,
    873,
    874,
    875,
    876,
    887,
    888,
    889,
    891,
    892,
    894,
    895,
    896,
    897,
    898,
    900,
    901,
    902,
    903,
    905,
    906,
    907,
    908,
    909,
    910,
    911,
    913,
    914,
    1120,
    1121,
    1122,
    1621,
    1622,
    2208,
    4847,
    3232,
    1702,
    1703,
    1704,
    1705,
    1706,
    1707,
    2072,
    2073,
    2074,
    2075,
    2076
  },
  _WizardManSkillList_1 = {
    4933,
    4934,
    4982,
    4983,
    4984,
    4985,
    4981,
    4972,
    4941,
    4990,
    4991,
    4956,
    5313,
    5314,
    4951,
    5307,
    5308,
    4946,
    5301,
    5302
  },
  _WizardManSkillList_2 = {
    2210,
    2212,
    2226,
    2227,
    2228,
    2229,
    2230,
    2231,
    2232,
    2233,
    2234,
    2235,
    2236,
    2237,
    2238,
    2240,
    2241,
    2242,
    2243,
    2244,
    2245,
    2247,
    2248,
    2249,
    2251,
    2252,
    2253
  },
  _DarkElfSkillList_0 = {
    2255,
    2256,
    2260,
    2261,
    2264,
    2265,
    2266,
    2267,
    2270,
    2271,
    2272,
    2273,
    2278,
    2279,
    2294,
    2295,
    2297,
    2300,
    2301,
    2303,
    2304,
    2305,
    2306,
    2307,
    2308,
    2309,
    2310,
    2311,
    2312,
    2313,
    2314,
    2315,
    2316,
    2317,
    2318,
    2319,
    2320,
    2321,
    2322,
    2323,
    2324,
    2325,
    2330,
    2331,
    2332,
    2333,
    2334,
    2335,
    2337,
    2338,
    2340,
    2342,
    2344,
    2345,
    2346,
    2347,
    2348,
    2350,
    2351,
    2353,
    2354,
    2355,
    2356,
    2357,
    2358,
    2361,
    2362,
    2339,
    2363,
    2341,
    2364,
    2280,
    2365,
    2366,
    2367,
    2368,
    2369,
    2370,
    2371,
    2372,
    2373,
    2374,
    2376,
    2377,
    2378,
    2379,
    4846,
    3072,
    3087,
    3073,
    3074,
    3075,
    3076,
    3078,
    3077,
    3084,
    3085,
    3091,
    1702,
    1703,
    1704,
    1705,
    1706,
    1707,
    2072,
    2073,
    2074,
    2075,
    2076
  },
  _DarkElfSkillList_1 = {
    4780,
    4781,
    4782,
    4783,
    4784,
    4785,
    4786,
    4787,
    4788,
    4789,
    4790,
    4791,
    4792,
    4793,
    4794,
    4795,
    4796,
    4797,
    4798,
    4799,
    4800,
    4801,
    4802,
    4803,
    4804,
    4805,
    4806,
    4807,
    4808,
    4809,
    4810,
    4811,
    4812,
    4820,
    4821
  },
  _DarkElfSkillList_2 = {
    2392,
    2393,
    2394,
    2395,
    2396,
    2397,
    2398,
    2399,
    2400,
    2401,
    2403,
    2404,
    2405,
    2406,
    2407,
    2408,
    2409,
    2410,
    2411,
    2402,
    2412,
    2413,
    2414,
    2415,
    2416,
    2417,
    2418,
    2419,
    2420,
    2421,
    3079,
    3081,
    3082,
    3083,
    3092,
    3086,
    3088,
    3080,
    3089,
    3090
  },
  _CombattantSkillList_0 = {
    3030,
    2444,
    2445,
    2447,
    2448,
    2436,
    2437,
    3031,
    2484,
    2485,
    3037,
    2439,
    2440,
    2441,
    2442,
    3032,
    2482,
    2450,
    2451,
    3034,
    2476,
    2477,
    3035,
    2479,
    2480,
    3036,
    2506,
    2507,
    2487,
    2488,
    2489,
    2490,
    3042,
    2544,
    2545,
    2546,
    2551,
    2548,
    3052,
    2550,
    2553,
    2554,
    2538,
    2539,
    2540,
    2541,
    2520,
    2521,
    3094,
    2523,
    2524,
    3045,
    2526,
    2527,
    3046,
    2502,
    2503,
    2504,
    2557,
    2509,
    2510,
    2511,
    2542,
    2513,
    2514,
    2515,
    2517,
    2518,
    2529,
    2530,
    2531,
    3047,
    2533,
    2534,
    2535,
    2536,
    2497,
    2498,
    2499,
    2500,
    2492,
    2493,
    2494,
    2495,
    1702,
    1703,
    1704,
    1705,
    1706,
    1707,
    2072,
    2073,
    2074,
    2075,
    2076,
    2453,
    2454,
    2455,
    2456,
    2457,
    2458,
    2459,
    2460,
    2461,
    2462,
    2463,
    2464,
    2465,
    2466,
    2467,
    2468,
    2469,
    2470,
    2471,
    2472,
    4849
  },
  _CombattantSkillList_1 = {
    5328,
    5329,
    5330,
    5331,
    5332,
    5333,
    5334,
    5335,
    5336,
    5337,
    5338,
    5339,
    5340,
    5341,
    5342,
    5343,
    5344,
    5345,
    5346,
    5347,
    5348,
    5349,
    5350,
    5351,
    5352,
    5353,
    5354,
    5355,
    5356,
    5357,
    5358,
    5359,
    5360,
    5361,
    5362
  },
  _CombattantSkillList_2 = {
    2560,
    2561,
    2563,
    2564,
    2565,
    2574,
    2575,
    2576,
    2566,
    2567,
    2568,
    2569,
    2577,
    2578,
    2579,
    2570,
    2571,
    2572,
    2573,
    2580,
    2581,
    2582,
    2643,
    2646,
    2645,
    2644,
    2647,
    2648,
    2649,
    2650,
    3033,
    3038,
    3051,
    3049,
    3050,
    3044,
    3041,
    3043,
    3048,
    3040,
    3039
  },
  _MysticSkillList_0 = {
    2592,
    2593,
    2594,
    2595,
    2596,
    2597,
    2598,
    2599,
    2600,
    2601,
    2602,
    2603,
    2604,
    2605,
    2606,
    2607,
    2608,
    2609,
    2610,
    2611,
    2624,
    2625,
    2627,
    2628,
    2629,
    2630,
    2632,
    2633,
    2635,
    2636,
    2638,
    2639,
    2653,
    2654,
    2655,
    2657,
    2658,
    2660,
    2661,
    2663,
    2664,
    2667,
    2668,
    2669,
    2670,
    2671,
    2673,
    2675,
    2676,
    2677,
    2683,
    2684,
    2685,
    2686,
    2688,
    2690,
    2692,
    2693,
    2695,
    2696,
    2698,
    2699,
    2700,
    2702,
    2703,
    2704,
    2705,
    2707,
    2708,
    2709,
    2711,
    2712,
    2713,
    2715,
    2716,
    2717,
    2719,
    2720,
    2721,
    2722,
    2724,
    2725,
    2726,
    2727,
    2729,
    2730,
    2731,
    2732,
    4850,
    3053,
    3054,
    2679,
    3055,
    3261,
    3056,
    3258,
    3059,
    3060,
    3063,
    3064,
    3065,
    3068,
    1702,
    1703,
    1704,
    1705,
    1706,
    1707,
    2072,
    2073,
    2074,
    2075,
    2076
  },
  _MysticSkillList_1 = {
    5373,
    5374,
    5376,
    5377,
    5378,
    5379,
    5380,
    5381,
    5382,
    5383,
    5384,
    5385,
    5386,
    5387,
    5388,
    5389,
    5390,
    5391,
    5392,
    5393,
    5394,
    5395,
    5396,
    5397,
    5398,
    5399,
    5400,
    5401,
    5402,
    5403,
    5404,
    5405,
    5406,
    5407,
    5408
  },
  _MysticSkillList_2 = {
    2806,
    2805,
    2777,
    2778,
    2779,
    2793,
    2794,
    2795,
    2781,
    2782,
    2783,
    2791,
    2788,
    2789,
    2790,
    2799,
    2800,
    2801,
    2802,
    2784,
    2785,
    2786,
    2798,
    2780,
    2803,
    2796,
    2797,
    2792,
    2804,
    2787
  },
  _LhanSkillList_0 = {
    3323,
    3222,
    3223,
    3224,
    3300,
    3013,
    3014,
    3015,
    3016,
    3007,
    3008,
    3009,
    3010,
    2965,
    3017,
    3018,
    3019,
    3317,
    3020,
    3021,
    3318,
    3028,
    3005,
    3006,
    3226,
    3227,
    2975,
    2976,
    2949,
    2977,
    3302,
    3011,
    3012,
    3315,
    2998,
    2999,
    2961,
    3152,
    3322,
    3000,
    3001,
    3002,
    3312,
    3003,
    3004,
    2959,
    2990,
    2991,
    3310,
    2996,
    2997,
    3309,
    2995,
    3308,
    2956,
    3148,
    3149,
    3150,
    2987,
    2988,
    2989,
    3306,
    2978,
    2979,
    2980,
    2981,
    2992,
    2993,
    2994,
    3304,
    2982,
    2983,
    2984,
    2985,
    2986,
    3022,
    3023,
    3024,
    3319,
    3025,
    3026,
    3320,
    3234,
    3236,
    3238,
    3240,
    3242,
    3244,
    3246,
    3248,
    3250,
    3252,
    4848,
    3235,
    3237,
    3239,
    3241,
    3243,
    3245,
    3247,
    3249,
    3251,
    3253,
    3029,
    1702,
    1703,
    1704,
    1705,
    1706,
    1707,
    2072,
    2073,
    2074,
    2075,
    2076
  },
  _LhanSkillList_1 = {
    4884,
    4885,
    4887,
    4888,
    4889,
    4890,
    4891,
    4892,
    4902,
    4903,
    4904,
    4905,
    4906,
    4907,
    4908,
    4909,
    4910,
    4911,
    4912,
    4913,
    4893,
    4894,
    4895,
    4896,
    4897,
    4898,
    4899,
    4900,
    4901,
    4914,
    4915,
    4916,
    4917,
    4918,
    4919
  },
  _LhanSkillList_2 = {
    3292,
    3291,
    3268,
    3269,
    3270,
    3271,
    3272,
    3273,
    3274,
    3276,
    3277,
    3278,
    3279,
    3281,
    3282,
    3283,
    3284,
    3285,
    3286,
    3287,
    3288,
    3289,
    3298,
    3294,
    3275,
    3295,
    3296,
    3297,
    3280,
    3290,
    3316,
    3314,
    3029,
    3313,
    3301,
    3311,
    3307,
    3321,
    3303,
    3305
  },
  _RangerManSkillList_0 = {
    3338,
    3415,
    3416,
    3455,
    3456,
    3457,
    3344,
    3345,
    3346,
    3378,
    3379,
    3380,
    3374,
    3375,
    3376,
    3430,
    3429,
    3428,
    3406,
    3407,
    3408,
    3409,
    3411,
    3412,
    3413,
    3350,
    3351,
    3352,
    3353,
    3354,
    3355,
    3356,
    3438,
    3439,
    3440,
    3365,
    3366,
    3340,
    3341,
    3342,
    3443,
    3444,
    3445,
    3446,
    3447,
    3449,
    3450,
    3451,
    3452,
    3453,
    3424,
    3425,
    3426,
    3433,
    3434,
    3435,
    3436,
    3437,
    3368,
    3369,
    3370,
    3371,
    3372,
    3418,
    3419,
    3420,
    3421,
    3422,
    3358,
    3359,
    3360,
    3361,
    3362,
    3363,
    3381,
    3382,
    3383,
    3384,
    3385,
    3386,
    3387,
    3388,
    3389,
    3390,
    3391,
    3392,
    3393,
    3394,
    3395,
    3396,
    3397,
    3398,
    3399,
    3400,
    4851,
    1702,
    1703,
    1704,
    1705,
    1706,
    1707,
    2072,
    2073,
    2074,
    2075,
    2076
  },
  _RangerManSkillList_1 = {},
  _RangerManSkillList_2 = {
    3923,
    3914,
    3935,
    3936,
    3937,
    3917,
    3918,
    3919,
    3930,
    3931,
    3932,
    3945,
    3946,
    3925,
    3926,
    3939,
    3940,
    3941,
    3927,
    3948,
    3933,
    3938,
    3943,
    3922,
    3947
  },
  _ShyWamanSkillList_0 = {
    3892,
    3893,
    3859,
    3888,
    3889,
    3860,
    3856,
    3857,
    3858,
    3852,
    3853,
    3854,
    4628,
    3863,
    3864,
    3865,
    3866,
    4204,
    3868,
    3869,
    3871,
    3872,
    3873,
    3874,
    3876,
    3877,
    3878,
    3880,
    3881,
    3882,
    3883,
    3884,
    3886,
    3890,
    3861,
    4154,
    4155,
    4156,
    4157,
    4158,
    4159,
    4160,
    4161,
    4162,
    4163,
    4607,
    4608,
    1702,
    1703,
    1704,
    1705,
    1706,
    1707,
    2072,
    2073,
    2074,
    2075,
    2076
  },
  _ShyWamanSkillList_1 = {},
  _ShyWamanSkillList_2 = {
    4097,
    4098,
    4609,
    4610,
    4099,
    4611,
    4612,
    4230,
    4231,
    4232,
    4102,
    4621,
    4623,
    4625,
    4617,
    4622,
    4101,
    4229,
    4100
  },
  _GuardianSkillList_0 = {
    5012,
    5013,
    5015,
    5016,
    5017,
    5018,
    5019,
    5020,
    5021,
    5022,
    5023,
    5024,
    5025,
    5026,
    5027,
    5028,
    5029,
    5030,
    5031,
    5032,
    5033,
    5034,
    5035,
    5036,
    5038,
    5039,
    5042,
    5043,
    5046,
    5047,
    5048,
    5049,
    5055,
    5056,
    5057,
    5058,
    5060,
    5061,
    5063,
    5065,
    5066,
    5069,
    5070,
    5071,
    5074,
    5075,
    5076,
    5079,
    5080,
    5083,
    5084,
    5085,
    5088,
    5089,
    5090,
    5095,
    5096,
    5098,
    5099,
    5101,
    5103,
    5106,
    5107,
    5109,
    5111,
    5112,
    5115,
    5116,
    5121,
    5122,
    5125,
    5127,
    5128,
    5129,
    5140,
    5141,
    5142,
    5143,
    5144,
    5010,
    5014,
    5040,
    5044,
    5059,
    5062,
    5077,
    5102,
    5108,
    5145,
    1702,
    1703,
    1704,
    1705,
    1706,
    1707,
    2072,
    2073,
    2074,
    2075,
    2076
  },
  _GuardianSkillList_1 = {
    5187,
    5221,
    5213,
    5216,
    5217,
    5218,
    5219,
    5220,
    5201,
    5202,
    5203,
    5204,
    5194,
    5195,
    5196,
    5197,
    5205,
    5206,
    5207,
    5208,
    5191,
    5192,
    5193,
    5198,
    5199,
    5200,
    5188,
    8189,
    5190,
    5209,
    5210,
    5211,
    5212,
    5214,
    5215
  },
  _GuardianSkillList_2 = {
    5155,
    5156,
    5157,
    5153,
    5178,
    5158,
    5159,
    5160,
    5161,
    5169,
    5170,
    5171,
    5172,
    5162,
    5163,
    5164,
    5165,
    5166,
    5167,
    5175,
    5176,
    5177,
    5168,
    5174,
    5173,
    5179,
    5180,
    5181,
    5183,
    5182,
    5091,
    5072,
    5081,
    5086,
    5050,
    5123,
    5117,
    5113,
    5130,
    5067
  },
  _HashashinSkillList_0 = {
    5613,
    5614,
    5520,
    5521,
    5522,
    5502,
    5503,
    5530,
    5531,
    5506,
    5507,
    5508,
    5509,
    5510,
    5525,
    5526,
    5527,
    5495,
    5496,
    5497,
    5498,
    5600,
    5601,
    5602,
    5535,
    5536,
    5537,
    5538,
    5489,
    5490,
    5491,
    5492,
    5544,
    5545,
    5546,
    5547,
    5518,
    5596,
    5597,
    5541,
    5542,
    5566,
    5567,
    5582,
    5585,
    5586,
    5587,
    5588,
    5610,
    5611,
    5513,
    5514,
    5515,
    5604,
    5606,
    5607,
    5608,
    5482,
    5483,
    5484,
    5485,
    5533,
    5549,
    5550,
    5551,
    5552,
    5553,
    5554,
    5555,
    5556,
    5557,
    5558,
    5590,
    5569,
    5570,
    5571,
    5572,
    5573,
    5574,
    5575,
    5576,
    5577,
    5578,
    1702,
    1703,
    1704,
    1705,
    1706,
    1707,
    2072,
    2073,
    2074,
    2075,
    2076
  },
  _HashashinSkillList_1 = {},
  _HashashinSkillList_2 = {}
}
function LearnSkillForQA()
  ToClient_qaLevelUp(63)
  awakening()
  createSkillPoint(3000)
  ToClient_qaCreateItem(17697, 0, 1)
  luaTimer_AddEvent(ToClient_qaUseInventoryItem, 10000, false, 0, 17697, 0)
  luaTimer_AddEvent(LearnAllSkill, 10000, false, 0)
end
function LearnAllSkill(skillType)
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  local isClassType = selfPlayer:getClassType()
  local SkillList_0, SkillList_1, SkillList_2
  if isClassType == __eClassType_Warrior then
    SkillList_0 = PaGlobalQASupport._WarriorSkillList_0
    SkillList_1 = PaGlobalQASupport._WarriorSkillList_1
    SkillList_2 = PaGlobalQASupport._WarriorSkillList_2
  elseif isClassType == __eClassType_ElfRanger then
    SkillList_0 = PaGlobalQASupport._ElfRangerSkillList_0
    SkillList_1 = PaGlobalQASupport._ElfRangerSkillList_1
    SkillList_2 = PaGlobalQASupport._ElfRangerSkillList_2
  elseif isClassType == __eClassType_Sorcerer then
    SkillList_0 = PaGlobalQASupport._SorcererSkillList_0
    SkillList_1 = PaGlobalQASupport._SorcererSkillList_1
    SkillList_2 = PaGlobalQASupport._SorcererSkillList_2
  elseif isClassType == __eClassType_Giant then
    SkillList_0 = PaGlobalQASupport._GiantSkillList_0
    SkillList_1 = PaGlobalQASupport._GiantSkillList_1
    SkillList_2 = PaGlobalQASupport._GiantSkillList_2
  elseif isClassType == __eClassType_Tamer then
    SkillList_0 = PaGlobalQASupport._TamerSkillList_0
    SkillList_1 = PaGlobalQASupport._TamerSkillList_1
    SkillList_2 = PaGlobalQASupport._TamerSkillList_2
  elseif isClassType == __eClassType_BladeMaster then
    SkillList_0 = PaGlobalQASupport._BladeMasterSkillList_0
    SkillList_1 = PaGlobalQASupport._BladeMasterSkillList_1
    SkillList_2 = PaGlobalQASupport._BladeMasterSkillList_2
  elseif isClassType == __eClassType_Valkyrie then
    SkillList_0 = PaGlobalQASupport._ValkyrieSkillList_0
    SkillList_1 = PaGlobalQASupport._ValkyrieSkillList_1
    SkillList_2 = PaGlobalQASupport._ValkyrieSkillList_2
  elseif isClassType == __eClassType_BladeMasterWoman then
    SkillList_0 = PaGlobalQASupport._BladeMasterWomanSkillList_0
    SkillList_1 = PaGlobalQASupport._BladeMasterWomanSkillList_1
    SkillList_2 = PaGlobalQASupport._BladeMasterWomanSkillList_2
  elseif isClassType == __eClassType_Kunoichi then
    SkillList_0 = PaGlobalQASupport._KunoichiSkillList_0
    SkillList_1 = PaGlobalQASupport._KunoichiSkillList_1
    SkillList_2 = PaGlobalQASupport._KunoichiSkillList_2
  elseif isClassType == __eClassType_NinjaMan then
    SkillList_0 = PaGlobalQASupport._NinjaManSkillList_0
    SkillList_1 = PaGlobalQASupport._NinjaManSkillList_1
    SkillList_2 = PaGlobalQASupport._NinjaManSkillList_2
  elseif isClassType == __eClassType_WizardWoman then
    SkillList_0 = PaGlobalQASupport._WizardWomanSkillList_0
    SkillList_1 = PaGlobalQASupport._WizardWomanSkillList_1
    SkillList_2 = PaGlobalQASupport._WizardWomanSkillList_2
  elseif isClassType == __eClassType_WizardMan then
    SkillList_0 = PaGlobalQASupport._WizardManSkillList_0
    SkillList_1 = PaGlobalQASupport._WizardManSkillList_1
    SkillList_2 = PaGlobalQASupport._WizardManSkillList_2
  elseif isClassType == __eClassType_DarkElf then
    SkillList_0 = PaGlobalQASupport._DarkElfSkillList_0
    SkillList_1 = PaGlobalQASupport._DarkElfSkillList_1
    SkillList_2 = PaGlobalQASupport._DarkElfSkillList_2
  elseif isClassType == __eClassType_Combattant then
    SkillList_0 = PaGlobalQASupport._CombattantSkillList_0
    SkillList_1 = PaGlobalQASupport._CombattantSkillList_1
    SkillList_2 = PaGlobalQASupport._CombattantSkillList_2
  elseif isClassType == __eClassType_Mystic then
    SkillList_0 = PaGlobalQASupport._MysticSkillList_0
    SkillList_1 = PaGlobalQASupport._MysticSkillList_1
    SkillList_2 = PaGlobalQASupport._MysticSkillList_2
  elseif isClassType == __eClassType_Lhan then
    SkillList_0 = PaGlobalQASupport._LhanSkillList_0
    SkillList_1 = PaGlobalQASupport._LhanSkillList_1
    SkillList_2 = PaGlobalQASupport._LhanSkillList_2
  elseif isClassType == __eClassType_RangerMan then
    SkillList_0 = PaGlobalQASupport._RangerManSkillList_0
    SkillList_1 = PaGlobalQASupport._RangerManSkillList_1
    SkillList_2 = PaGlobalQASupport._RangerManSkillList_2
  elseif isClassType == __eClassType_ShyWaman then
    SkillList_0 = PaGlobalQASupport._ShyWamanSkillList_0
    SkillList_1 = PaGlobalQASupport._ShyWamanSkillList_1
    SkillList_2 = PaGlobalQASupport._ShyWamanSkillList_2
  elseif isClassType == __eClassType_Guardian then
    SkillList_0 = PaGlobalQASupport._GuardianSkillList_0
    SkillList_1 = PaGlobalQASupport._GuardianSkillList_1
    SkillList_2 = PaGlobalQASupport._GuardianSkillList_2
  elseif isClassType == __eClassType_Hashashin then
    SkillList_0 = PaGlobalQASupport._HashashinSkillList_0
    SkillList_1 = PaGlobalQASupport._HashashinSkillList_1
    SkillList_2 = PaGlobalQASupport._HashashinSkillList_2
  end
  if skillType == 0 then
    for index, value in pairs(SkillList_0) do
      luaTimer_AddEvent(ToClient_qaLearnSkill, 200 * index, false, 0, value)
    end
  elseif skillType == 1 then
    for index, value in pairs(SkillList_1) do
      luaTimer_AddEvent(ToClient_qaLearnSkill, 200 * index, false, 0, value)
    end
  elseif skillType == 2 then
    for index, value in pairs(SkillList_2) do
      luaTimer_AddEvent(ToClient_qaLearnSkill, 200 * index, false, 0, value)
    end
  end
end
function toggleTrace()
  _PA_LOG("\236\139\160\236\138\185\234\182\140", "toggleTrace")
  ToClient_ToggleStateFlag()
  ToClient_SetTraceFlag()
end
function sealAllPet()
  pa_sendMessage("/newpet seal 0")
  pa_sendMessage("/newpet seal 1")
  pa_sendMessage("/newpet seal 2")
  pa_sendMessage("/newpet seal 3")
  pa_sendMessage("/newpet seal 4")
end
local enTimeValue = {
  Second = 1,
  RunningTime = 6,
  StandingTime = 24,
  StandingTime_Half = 12
}
local enCameraValue = {
  UpdateCameraYaw = 0.015,
  SetCameraPich_Low = -0.2,
  SetCameraPich_High = 0.35,
  ForLogAngle = 0.1,
  GoalArea = 300,
  BreakArea = 50
}
local ProcessEnum = {
  eProcessMove = 0,
  eProcessWait = 1,
  eProcessFunc = 2,
  eProcessPosFunc = 3,
  eProcessMovingWait = 4
}
local QASupport = {
  _isOn = false,
  _index = 0,
  _maxIndex = 0,
  _ProcessList = {},
  _oldPositionX = 0,
  _oldPositionY = 0,
  _oldPositionZ = 0,
  _logPositionX = 0,
  _logPositionY = 0,
  _logPositionZ = 0,
  _logCameraYaw = 0,
  _isScopeCapture = false,
  _isWaitting = false,
  _waitTime = 0,
  _goalWaitTime = 0,
  _processQueue = 1
}
function QASupport:goNextProcess()
  self._index = self._index + 1
  if self._maxIndex <= self._index then
    self._isOn = false
    self._index = 0
    self._maxIndex = 0
    self._ProcessList = {}
    self._isWaitting = false
    self._waitTime = 0
    self._goalWaitTime = 0
    self._processQueue = 1
    _PA_LOG("\236\139\160\236\138\185\234\182\140", "############################ QASupport End!! ####################################")
    return
  end
  if ProcessEnum.eProcessMove == self._ProcessList[self._index]._type then
    local X1 = self._ProcessList[self._index]._goalX
    local Y1 = self._ProcessList[self._index]._goalY
    local Z1 = self._ProcessList[self._index]._goalZ
    local Position = float3(X1, Y1, Z1)
    ToClient_StopNavi()
    ToClient_WorldMapNaviStart(Position, NavigationGuideParam(), false, true)
    ToClient_NaviReStart()
    _PA_LOG("\236\139\160\236\138\185\234\182\140", "GotoNextPosition:" .. "(" .. X1 .. "," .. Y1 .. "," .. Z1 .. ")")
  elseif ProcessEnum.eProcessWait == self._ProcessList[self._index]._type then
    self._isWaitting = true
    self._waitTime = 0
    self._goalWaitTime = self._ProcessList[self._index]._time
    _PA_LOG("\236\139\160\236\138\185\234\182\140", "waitTime:" .. self._goalWaitTime)
  elseif ProcessEnum.eProcessFunc == self._ProcessList[self._index]._type then
  elseif ProcessEnum.eProcessPosFunc == self._ProcessList[self._index]._type and false == self._ProcessList[self._index]._isExe then
    _PA_LOG("\236\139\160\236\138\185\234\182\140", "\236\157\180\235\143\153\236\164\145\236\151\144 \237\149\168\236\136\152\234\176\128 \236\139\164\237\150\137\235\144\152\236\167\128\236\149\138\236\149\152\235\139\164!")
  end
end
function QASupport:isArriveGoalbyPosition(X, Y, Z)
  local selfPlayer = getSelfPlayer()
  local nowPositionX = selfPlayer:get():getPositionX()
  local nowPositionY = selfPlayer:get():getPositionY()
  local nowPositionZ = selfPlayer:get():getPositionZ()
  local fixedPositionX = math.abs(X - nowPositionX)
  local fixedPositionY = math.abs(Y - nowPositionY)
  local fixedPositionZ = math.abs(Z - nowPositionZ)
  if fixedPositionX < enCameraValue.GoalArea and fixedPositionY < enCameraValue.GoalArea and fixedPositionZ < enCameraValue.GoalArea then
    return true
  end
  return false
end
function FGlobal_QASupport_addMovePosition(X, Y, Z, strWhere)
  local nowIndex = QASupport._maxIndex
  local tempString = ""
  if nil ~= strWhere then
    tempString = strWhere
  end
  QASupport._maxIndex = QASupport._maxIndex + 1
  QASupport._ProcessList[nowIndex] = {
    _type = ProcessEnum.eProcessMove,
    _goalX = X,
    _goalY = Y,
    _goalZ = Z,
    _where = tempString
  }
end
function FGlobal_QASupport_addWait(time)
  local nowIndex = QASupport._maxIndex
  QASupport._maxIndex = QASupport._maxIndex + 1
  QASupport._ProcessList[nowIndex] = {
    _type = ProcessEnum.eProcessWait,
    _time = time
  }
end
function FGlobal_QASupport_addMovingWaitAndFunc(time, func, param1, param2, param3)
  local nowIndex = QASupport._maxIndex
  QASupport._maxIndex = QASupport._maxIndex + 1
  QASupport._ProcessList[nowIndex] = {
    _type = ProcessEnum.eProcessMovingWait,
    _time = time,
    _func = func,
    _param1 = param1,
    _param2 = param2,
    _param3 = param3
  }
end
function FGlobal_QASupport_addFunc(func, param1, param2, param3)
  local nowIndex = QASupport._maxIndex
  QASupport._maxIndex = QASupport._maxIndex + 1
  QASupport._ProcessList[nowIndex] = {
    _type = ProcessEnum.eProcessFunc,
    _func = func,
    _param1 = param1,
    _param2 = param2,
    _param3 = param3
  }
end
function FGlobal_QASupport_addPositionFunc(X, Y, Z, func, param1, param2, param3)
  local nowIndex = QASupport._maxIndex
  QASupport._maxIndex = QASupport._maxIndex + 1
  QASupport._ProcessList[nowIndex] = {
    _type = ProcessEnum.eProcessPosFunc,
    _goalX = X,
    _goalY = Y,
    _goalZ = Z,
    _func = func,
    _param1 = param1,
    _param2 = param2,
    _param3 = param3,
    _isExe = false
  }
end
function FGlobal_QASupport_Start()
  self = QASupport
  self._index = 0
  self._nowRepeatCount = 0
  self._processQueue = 1
  if ProcessEnum.eProcessMove == self._ProcessList[self._index]._type then
    local X1 = self._ProcessList[self._index]._goalX
    local Y1 = self._ProcessList[self._index]._goalY
    local Z1 = self._ProcessList[self._index]._goalZ
    local Position = float3(X1, Y1, Z1)
    ToClient_StopNavi()
    ToClient_WorldMapNaviStart(Position, NavigationGuideParam(), false, true)
    ToClient_NaviReStart()
  elseif ProcessEnum.eProcessWait == self._ProcessList[self._index]._type then
    self._isWaitting = true
    self._waitTime = 0
    self._goalWaitTime = waitTime
  elseif ProcessEnum.eProcessFunc == self._ProcessList[self._index]._type then
    self._ProcessList[self._index]._func(self._ProcessList[self._index]._param1, self._ProcessList[self._index]._param2, self._ProcessList[self._index]._param3)
  end
  _PA_LOG("\236\139\160\236\138\185\234\182\140", "self._processQueue = " .. self._processQueue)
  _PA_LOG("\236\139\160\236\138\185\234\182\140", "############################ QASupport Start!! ####################################")
  QASupport._isOn = true
end
function QASupport:positionCheck(deltaTime)
  if self._maxIndex <= 0 then
    return false
  end
  local X = self._ProcessList[self._index]._goalX
  local Y = self._ProcessList[self._index]._goalY
  local Z = self._ProcessList[self._index]._goalZ
  local NowWhere = self._ProcessList[self._index]._where
  local selfPlayer = getSelfPlayer()
  if self._index + self._processQueue < self._maxIndex then
    local nextProcess = self._ProcessList[self._index + self._processQueue]
    if nextProcess._type == ProcessEnum.eProcessPosFunc and false == nextProcess._isExe then
      local X = nextProcess._goalX
      local Y = nextProcess._goalY
      local Z = nextProcess._goalZ
      if true == self:isArriveGoalbyPosition(X, Y, Z) then
        nextProcess._func(nextProcess._param1, nextProcess._param2, nextProcess._param3)
        nextProcess._isExe = true
        self._processQueue = self._processQueue + 1
        _PA_LOG("\236\139\160\236\138\185\234\182\140", "self._processQueue = " .. self._processQueue)
      end
    end
    if nextProcess._type == ProcessEnum.eProcessMovingWait then
      if false == self._isWaitting then
        self._isWaitting = true
        self._waitTime = 0
        self._goalWaitTime = nextProcess._time
      else
        self._waitTime = self._waitTime + deltaTime
        if self._goalWaitTime < self._waitTime then
          nextProcess._func(nextProcess._param1, nextProcess._param2, nextProcess._param3)
          self._isWaitting = false
          self._waitTime = 0
          self._goalWaitTime = 0
          self._processQueue = self._processQueue + 1
          _PA_LOG("\236\139\160\236\138\185\234\182\140", "self._processQueue = " .. self._processQueue)
        end
      end
    end
  end
  if true == self:isArriveGoalbyPosition(X, Y, Z) then
    _PA_LOG("\236\139\160\236\138\185\234\182\140", "GoalByPosition")
    ToClient_StopNavi()
    self._processQueue = 1
    return true
  end
  return false
end
function QASupport:waitTimeCheck(deltaTime)
  if false == self._isWaitting then
    return true
  end
  self._waitTime = self._waitTime + deltaTime
  if self._waitTime < self._goalWaitTime then
    return false
  end
  self._isWaitting = false
  self._waitTime = 0
  self._goalWaitTime = 0
  return true
end
local processWaitTime = 0
function QASupport_UpdatePerFrame(deltaTime)
  local self = QASupport
  local processTerm = 0.2
  if false == self._isOn then
    return
  end
  local gotoNext = false
  if ProcessEnum.eProcessMove == self._ProcessList[self._index]._type and processTerm < processWaitTime then
    gotoNext = QASupport:positionCheck(deltaTime)
  elseif ProcessEnum.eProcessWait == self._ProcessList[self._index]._type then
    gotoNext = QASupport:waitTimeCheck(deltaTime)
  elseif ProcessEnum.eProcessFunc == self._ProcessList[self._index]._type then
    gotoNext = true
    self._ProcessList[self._index]._func(self._ProcessList[self._index]._param1, self._ProcessList[self._index]._param2, self._ProcessList[self._index]._param3)
  elseif ProcessEnum.eProcessPosFunc == self._ProcessList[self._index]._type or ProcessEnum.eProcessMovingWait == self._ProcessList[self._index]._type then
    gotoNext = true
  end
  if true == gotoNext then
    QASupport:goNextProcess()
    processWaitTime = 0
  end
  processWaitTime = processWaitTime + deltaTime
end
local count = 0
function sayYea()
  chatting_sendMessage("", "\237\133\140\236\138\164\237\138\184~" .. count, CppEnums.ChatType.Public)
  count = count + 1
end
function sayMove()
  chatting_sendMessage("", "\235\167\136\234\181\191\234\176\132\236\167\128\234\184\176\236\149\158\236\157\132\236\167\128\235\130\156\235\139\164", CppEnums.ChatType.Public)
end
function sayMove2()
  chatting_sendMessage("", "\236\185\188\237\142\152\236\152\168\236\151\144 \236\158\133\236\132\177\237\150\136\235\139\164.", CppEnums.ChatType.Public)
end
function sayMove3()
  chatting_sendMessage("", "\237\148\132\235\161\156\237\140\140\236\157\188\236\139\156\236\158\145", CppEnums.ChatType.Public)
  toggleTrace()
end
function sayWatting1()
  chatting_sendMessage("", "4\236\180\136\234\178\189\234\179\188 \237\148\132\235\161\156\237\140\140\236\157\188 \235\129\157", CppEnums.ChatType.Public)
  toggleTrace()
end
function SummonMonster()
end
function testAutoMoveStart()
  if nil == runningTime then
    runningTime = 5
  end
  if nil == standingTime then
    standingTime = 10
  end
  FGlobal_QASupport_addFunc(pa_sendMessage, "/create item 720710 1")
  FGlobal_QASupport_addMovePosition(-255592.234375, -2507.007734, -25550.748047)
  FGlobal_QASupport_addWait(1)
  local monsterKey = 21135
  local monsterCount = 10
  FGlobal_QASupport_addFunc(PaGlobal_PetList_ReverseAllUnSeal_ForQA)
  FGlobal_QASupport_addFunc(chatting_sendMessage, "", "\235\170\172\236\138\164\237\132\176 \236\134\140\237\153\152", CppEnums.ChatType.Public)
  FGlobal_QASupport_addFunc(pa_sendMessage, "/create monster " .. monsterKey .. " " .. monsterCount)
  FGlobal_QASupport_addWait(3)
  FGlobal_QASupport_addFunc(chatting_sendMessage, "", "\235\170\172\236\138\164\237\132\176 \237\130\172", CppEnums.ChatType.Public)
  FGlobal_QASupport_addFunc(pa_sendMessage, "/killNearAllMonster")
  FGlobal_QASupport_addFunc(chatting_sendMessage, "", "\237\138\184\235\160\136\236\157\180\236\138\164\236\139\156\236\158\145", CppEnums.ChatType.Public)
  FGlobal_QASupport_addFunc(toggleTrace)
  FGlobal_QASupport_addWait(5)
  FGlobal_QASupport_addFunc(chatting_sendMessage, "", "\237\138\184\235\160\136\236\157\180\236\138\164\235\129\157", CppEnums.ChatType.Public)
  FGlobal_QASupport_addFunc(toggleTrace)
  FGlobal_QASupport_addFunc(sealAllPet)
  FGlobal_QASupport_addWait(3)
  FGlobal_QASupport_addFunc(chatting_sendMessage, "", "\235\170\172\236\138\164\237\132\176 \235\163\168\237\140\133 \237\148\132\235\161\156\237\140\140\236\157\188 \236\153\132\235\163\140 \236\157\180\235\143\153 \236\139\156\236\158\145", CppEnums.ChatType.Public)
  FGlobal_QASupport_addFunc(pa_sendMessage, "/create item 720710 1")
  FGlobal_QASupport_addMovePosition(-244949.078125, -3092.061035, -43628.03125)
  FGlobal_QASupport_addPositionFunc(-252103.265625, -2868.881104, -39513.242188, sayMove3)
  FGlobal_QASupport_addMovingWaitAndFunc(4, sayWatting1)
  FGlobal_QASupport_Start()
end
function testSkillStart()
  if nil == runningTime then
    runningTime = 5
  end
  if nil == standingTime then
    standingTime = 10
  end
  local monsterKey = 999
  local monsterCount = 3
  selfPlayerSetCameraPich(-1)
  FGlobal_QASupport_addFunc(chatting_sendMessage, "", "\235\170\172\236\138\164\237\132\176 \236\134\140\237\153\152", CppEnums.ChatType.Public)
  FGlobal_QASupport_addFunc(pa_sendMessage, "/create monster " .. monsterKey .. " " .. monsterCount)
  FGlobal_QASupport_addWait(2)
  FGlobal_QASupport_addFunc(ToClient_ChangeCameraToMonster, monsterKey)
  FGlobal_QASupport_addWait(1)
  FGlobal_QASupport_addFunc(ToClient_InputPhotoModeFromLua)
  FGlobal_QASupport_addWait(1)
  FGlobal_QASupport_addFunc(chatting_sendMessage, "", "\236\158\160\236\139\156 \237\148\132\235\160\136\236\158\132\236\149\136\236\160\149\237\153\148 \235\140\128\234\184\176", CppEnums.ChatType.Public)
  FGlobal_QASupport_addWait(10)
  FGlobal_QASupport_addFunc(chatting_sendMessage, "", "\237\138\184\235\160\136\236\157\180\236\138\164\236\139\156\236\158\145", CppEnums.ChatType.Public)
  FGlobal_QASupport_addFunc(toggleTrace)
  FGlobal_QASupport_addFunc(chatting_sendMessage, "", "\237\128\181\236\138\172\235\161\1751 \236\130\172\236\154\169", CppEnums.ChatType.Public)
  FGlobal_QASupport_addFunc(quickSlot_UseSlot, 0)
  FGlobal_QASupport_addWait(3)
  FGlobal_QASupport_addFunc(chatting_sendMessage, "", "\237\128\181\236\138\172\235\161\1752 \236\130\172\236\154\169", CppEnums.ChatType.Public)
  FGlobal_QASupport_addFunc(quickSlot_UseSlot, 1)
  FGlobal_QASupport_addWait(3)
  FGlobal_QASupport_addFunc(chatting_sendMessage, "", "\237\128\181\236\138\172\235\161\1753 \236\130\172\236\154\169", CppEnums.ChatType.Public)
  FGlobal_QASupport_addFunc(quickSlot_UseSlot, 2)
  FGlobal_QASupport_addWait(3)
  FGlobal_QASupport_addFunc(chatting_sendMessage, "", "\235\170\172\236\138\164\237\132\176 \237\130\172", CppEnums.ChatType.Public)
  FGlobal_QASupport_addFunc(pa_sendMessage, "/killNearAllMonster")
  FGlobal_QASupport_addWait(5)
  FGlobal_QASupport_addFunc(chatting_sendMessage, "", "\237\138\184\235\160\136\236\157\180\236\138\164\235\129\157", CppEnums.ChatType.Public)
  FGlobal_QASupport_addFunc(toggleTrace)
  FGlobal_QASupport_addFunc(ToClient_InputPhotoModeFromLua)
  FGlobal_QASupport_addWait(3)
  FGlobal_QASupport_Start()
end
function testSkillCase1()
  local monsterKey = 999
  local monsterCount = 10
  selfPlayerSetCameraPich(-2)
  FGlobal_QASupport_addFunc(PaGlobal_PetList_ReverseAllUnSeal_ForQA)
  FGlobal_QASupport_addFunc(chatting_sendMessage, "", "\235\170\172\236\138\164\237\132\176 \236\134\140\237\153\152", CppEnums.ChatType.Public)
  FGlobal_QASupport_addFunc(pa_sendMessage, "/create monster " .. monsterKey .. " " .. monsterCount)
  FGlobal_QASupport_addWait(3)
  FGlobal_QASupport_addFunc(chatting_sendMessage, "", "\237\138\184\235\160\136\236\157\180\236\138\164\236\139\156\236\158\145", CppEnums.ChatType.Public)
  FGlobal_QASupport_addFunc(toggleTrace)
  FGlobal_QASupport_addFunc(chatting_sendMessage, "", "\236\138\164\237\130\172 \236\147\176\235\138\148 \235\143\153\236\149\136 \235\140\128\234\184\176", CppEnums.ChatType.Public)
  FGlobal_QASupport_addWait(9)
  FGlobal_QASupport_addFunc(chatting_sendMessage, "", "\235\170\172\236\138\164\237\132\176 \237\130\172", CppEnums.ChatType.Public)
  FGlobal_QASupport_addFunc(pa_sendMessage, "/killNearAllMonster")
  FGlobal_QASupport_addWait(5)
  FGlobal_QASupport_addFunc(chatting_sendMessage, "", "\237\138\184\235\160\136\236\157\180\236\138\164\235\129\157", CppEnums.ChatType.Public)
  FGlobal_QASupport_addFunc(toggleTrace)
  FGlobal_QASupport_addFunc(sealAllPet)
  FGlobal_QASupport_addWait(3)
  FGlobal_QASupport_Start()
end
function testSkillCase2()
  local monsterKey = 999
  local monsterCount = 10
  selfPlayerSetCameraPich(-2)
  FGlobal_QASupport_addFunc(chatting_sendMessage, "", "\235\170\172\236\138\164\237\132\176 \236\134\140\237\153\152 \236\149\136\237\149\152\234\179\160 \237\133\140\236\138\164\237\138\184", CppEnums.ChatType.Public)
  FGlobal_QASupport_addWait(2)
  FGlobal_QASupport_addFunc(chatting_sendMessage, "", "\237\138\184\235\160\136\236\157\180\236\138\164\236\139\156\236\158\145", CppEnums.ChatType.Public)
  FGlobal_QASupport_addFunc(toggleTrace)
  FGlobal_QASupport_addFunc(chatting_sendMessage, "", "\237\128\181\236\138\172\235\161\1751 \236\130\172\236\154\169", CppEnums.ChatType.Public)
  FGlobal_QASupport_addFunc(quickSlot_UseSlot, 0)
  FGlobal_QASupport_addWait(3)
  FGlobal_QASupport_addFunc(chatting_sendMessage, "", "\237\128\181\236\138\172\235\161\1752 \236\130\172\236\154\169", CppEnums.ChatType.Public)
  FGlobal_QASupport_addFunc(quickSlot_UseSlot, 1)
  FGlobal_QASupport_addWait(3)
  FGlobal_QASupport_addFunc(chatting_sendMessage, "", "\237\128\181\236\138\172\235\161\1753 \236\130\172\236\154\169", CppEnums.ChatType.Public)
  FGlobal_QASupport_addFunc(quickSlot_UseSlot, 2)
  FGlobal_QASupport_addWait(3)
  FGlobal_QASupport_addWait(5)
  FGlobal_QASupport_addFunc(chatting_sendMessage, "", "\237\138\184\235\160\136\236\157\180\236\138\164\235\129\157", CppEnums.ChatType.Public)
  FGlobal_QASupport_addFunc(toggleTrace)
  FGlobal_QASupport_addWait(3)
  FGlobal_QASupport_Start()
end
