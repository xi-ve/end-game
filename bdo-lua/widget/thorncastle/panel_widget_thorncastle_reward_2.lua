function PaGlobal_ThornCastle_Reward_SetEndGame(isWin)
  if false == PaGlobal_ThornCastle_Reward._initialize then
    return
  end
  PaGlobal_ThornCastle_Reward:prepareOpen(isWin)
end
function HandleEventLUp_Widget_ThornCastle_Reward_Exit_Game()
  ToClient_InstanceOthilitaDisJoin()
end
