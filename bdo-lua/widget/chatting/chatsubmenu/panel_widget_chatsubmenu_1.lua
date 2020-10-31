function PaGlobal_ChatSubMenu:initialize()
  if true == PaGlobal_ChatSubMenu._initialize then
    return
  end
  PaGlobal_ChatSubMenu._isReportGoldSellerOpen = _ContentsGroup_GoldSellerReport
  PaGlobal_ChatSubMenu._ui._staticBg = UI.getChildControl(Panel_Chat_SubMenu, "Static_SubMenu")
  PaGlobal_ChatSubMenu._ui._buttonWhisper = UI.getChildControl(Panel_Chat_SubMenu, "Button_Whisper")
  PaGlobal_ChatSubMenu._ui._buttonAddFriend = UI.getChildControl(Panel_Chat_SubMenu, "Button_AddFriend")
  PaGlobal_ChatSubMenu._ui._buttonInviteParty = UI.getChildControl(Panel_Chat_SubMenu, "Button_InviteParty")
  PaGlobal_ChatSubMenu._ui._buttonInviteLargeParty = UI.getChildControl(Panel_Chat_SubMenu, "Button_InviteLargeParty")
  PaGlobal_ChatSubMenu._ui._buttonInviteGuild = UI.getChildControl(Panel_Chat_SubMenu, "Button_InviteGuild")
  PaGlobal_ChatSubMenu._ui._buttonInviteCompetition = UI.getChildControl(Panel_Chat_SubMenu, "Button_InviteCompetition")
  PaGlobal_ChatSubMenu._ui._buttonInviteVolunteer = UI.getChildControl(Panel_Chat_SubMenu, "Button_InviteVolunteer")
  PaGlobal_ChatSubMenu._ui._buttonBlock = UI.getChildControl(Panel_Chat_SubMenu, "Button_Block")
  PaGlobal_ChatSubMenu._ui._buttonReportGoldSeller = UI.getChildControl(Panel_Chat_SubMenu, "Button_ReportGoldSeller")
  PaGlobal_ChatSubMenu._ui._buttonBlockVote = UI.getChildControl(Panel_Chat_SubMenu, "Button_BlockVote")
  PaGlobal_ChatSubMenu._ui._buttonIntroduce = UI.getChildControl(Panel_Chat_SubMenu, "Button_ShowIntroduce")
  PaGlobal_ChatSubMenu._ui._buttonWinClose = UI.getChildControl(Panel_Chat_SubMenu, "Button_WinClose")
  PaGlobal_ChatSubMenu._ui._buttonRecommand = UI.getChildControl(Panel_Chat_SubMenu, "Button_Recommand")
  PaGlobal_ChatSubMenu._ui._buttonIntroduce:SetShow(false)
  PaGlobal_ChatSubMenu._ui._staticBg:SetIgnore(false)
  PaGlobal_ChatSubMenu:SetShow(false)
  PaGlobal_ChatSubMenu:registEventHandler()
  PaGlobal_ChatSubMenu:validate()
  PaGlobal_ChatSubMenu._initialize = true
end
function PaGlobal_ChatSubMenu:registEventHandler()
  PaGlobal_ChatSubMenu._ui._staticBg:addInputEvent("Mouse_On", "HandleEventOn_ChattingSubMenu()")
  PaGlobal_ChatSubMenu._ui._buttonWhisper:addInputEvent("Mouse_LUp", "HandleEventLUp_ChatSubMenuSendWhisper()")
  PaGlobal_ChatSubMenu._ui._buttonAddFriend:addInputEvent("Mouse_LUp", "HandleEventLUp_ChatSubMenuAddFriend()")
  PaGlobal_ChatSubMenu._ui._buttonInviteParty:addInputEvent("Mouse_LUp", "HandleEventLUp_ChatSubMenuInviteParty()")
  PaGlobal_ChatSubMenu._ui._buttonInviteLargeParty:addInputEvent("Mouse_LUp", "HandleEventLUp_ChatSubMenuInviteLargeParty()")
  PaGlobal_ChatSubMenu._ui._buttonInviteGuild:addInputEvent("Mouse_LUp", "HandleEventLUp_ChatSubMenuInviteGuild()")
  PaGlobal_ChatSubMenu._ui._buttonInviteCompetition:addInputEvent("Mouse_LUp", "HandleEventLUp_ChatSubMenuInviteCompetition()")
  PaGlobal_ChatSubMenu._ui._buttonInviteVolunteer:addInputEvent("Mouse_LUp", "HandleEventLUp_ChatSubMenuInviteVolunteer()")
  PaGlobal_ChatSubMenu._ui._buttonWinClose:addInputEvent("Mouse_LUp", "HandleEventLUp_ChatSubMenuClose()")
  PaGlobal_ChatSubMenu._ui._buttonBlock:addInputEvent("Mouse_LUp", "HandleEventLUp_ChatSubMenuBlock()")
  PaGlobal_ChatSubMenu._ui._buttonReportGoldSeller:addInputEvent("Mouse_LUp", "HandleEventLUp_ChatSubMenuReportGoldSeller()")
  PaGlobal_ChatSubMenu._ui._buttonBlockVote:addInputEvent("Mouse_LUp", "HandleEventLUp_ChatSubMenuBlockVote()")
  PaGlobal_ChatSubMenu._ui._buttonRecommand:addInputEvent("Mouse_LUp", "HandleEventLUp_Recommand()")
end
function PaGlobal_ChatSubMenu:prepareOpen()
end
function PaGlobal_ChatSubMenu:open()
  Panel_Chat_SubMenu:SetShow(true)
end
function PaGlobal_ChatSubMenu:prepareClose()
end
function PaGlobal_ChatSubMenu:close()
  Panel_Chat_SubMenu:SetShow(false)
end
function PaGlobal_ChatSubMenu:update()
end
function PaGlobal_ChatSubMenu:validate()
end
function PaGlobal_ChatSubMenu:SetShow(isShow, isInviteParty, isInviteGuild, isInviteCompetition, isGameManager, isRecommand, clickedName, clickedUserNickName, isPearlAppUser)
  UI.ASSERT_NAME(nil ~= isShow, "PaGlobal_ChatSubMenu:SetShow isShow nil", "\236\178\156\235\167\140\234\184\176")
  if false == isShow then
    Panel_Chat_SubMenu:SetShow(false)
    return
  end
  UI.ASSERT_NAME(nil ~= isInviteParty, "PaGlobal_ChatSubMenu:SetShow isInviteParty nil", "\236\178\156\235\167\140\234\184\176")
  UI.ASSERT_NAME(nil ~= isInviteGuild, "PaGlobal_ChatSubMenu:SetShow isInviteGuild nil", "\236\178\156\235\167\140\234\184\176")
  UI.ASSERT_NAME(nil ~= isInviteCompetition, "PaGlobal_ChatSubMenu:SetShow isInviteCompetition nil", "\236\178\156\235\167\140\234\184\176")
  UI.ASSERT_NAME(nil ~= isGameManager, "PaGlobal_ChatSubMenu:SetShow isGameManager nil", "\236\178\156\235\167\140\234\184\176")
  UI.ASSERT_NAME(nil ~= clickedName, "PaGlobal_ChatSubMenu:SetShow clickedName nil", "\236\178\156\235\167\140\234\184\176")
  UI.ASSERT_NAME(nil ~= clickedUserNickName, "PaGlobal_ChatSubMenu:SetShow clickedUserNickName nil", "\236\178\156\235\167\140\234\184\176")
  UI.ASSERT_NAME(nil ~= isPearlAppUser, "PaGlobal_ChatSubMenu:SetShow isPearlAppUser nil", "\236\139\160\236\138\185\234\182\140")
  local bgSizeY = 165
  local buttonPosY = 160
  local gapY = 35
  local isCountryShow = true
  local isCountryOpen = _ContentsGroup_ChatBlock
  if isGameTypeJapan() then
    isCountryShow = false
  elseif isGameTypeEnglish() then
    isCountryShow = false
  end
  ToClient_updateAddFriendAllowed()
  if PaGlobal_ChatSubMenu._originBlockButtonPosY < 0 then
    PaGlobal_ChatSubMenu._originBlockButtonPosY = PaGlobal_ChatSubMenu._ui._buttonBlock:GetPosY()
  end
  if true == isPearlAppUser then
    PaGlobal_ChatSubMenu._ui._buttonWhisper:SetShow(false)
    PaGlobal_ChatSubMenu._ui._buttonAddFriend:SetShow(false)
    PaGlobal_ChatSubMenu._ui._buttonInviteParty:SetShow(false)
    PaGlobal_ChatSubMenu._ui._buttonInviteLargeParty:SetShow(false)
    PaGlobal_ChatSubMenu._ui._buttonInviteGuild:SetShow(false)
    PaGlobal_ChatSubMenu._ui._buttonInviteCompetition:SetShow(false)
    PaGlobal_ChatSubMenu._ui._buttonInviteVolunteer:SetShow(false)
    PaGlobal_ChatSubMenu._ui._buttonWinClose:SetShow(true)
    PaGlobal_ChatSubMenu._ui._buttonBlock:SetShow(true)
    PaGlobal_ChatSubMenu._ui._buttonReportGoldSeller:SetShow(false)
    PaGlobal_ChatSubMenu._ui._buttonBlockVote:SetShow(false)
    PaGlobal_ChatSubMenu._ui._buttonRecommand:SetShow(false)
    bgSizeY = 100
    PaGlobal_ChatSubMenu._ui._buttonBlock:SetPosY(50)
  else
    PaGlobal_ChatSubMenu._ui._buttonWhisper:SetShow(true)
    PaGlobal_ChatSubMenu._ui._buttonAddFriend:SetShow(true)
    PaGlobal_ChatSubMenu._ui._buttonInviteParty:SetShow(true)
    PaGlobal_ChatSubMenu._ui._buttonInviteLargeParty:SetShow(true)
    PaGlobal_ChatSubMenu._ui._buttonInviteGuild:SetShow(true)
    PaGlobal_ChatSubMenu._ui._buttonInviteCompetition:SetShow(true)
    PaGlobal_ChatSubMenu._ui._buttonInviteVolunteer:SetShow(true)
    PaGlobal_ChatSubMenu._ui._buttonWinClose:SetShow(true)
    PaGlobal_ChatSubMenu._ui._buttonBlock:SetShow(true)
    PaGlobal_ChatSubMenu._ui._buttonReportGoldSeller:SetShow(true)
    PaGlobal_ChatSubMenu._ui._buttonBlockVote:SetShow(true)
    PaGlobal_ChatSubMenu._ui._buttonBlock:SetPosY(PaGlobal_ChatSubMenu._originBlockButtonPosY)
    bgSizeY = 165
    if true == isGameManager then
      PaGlobal_ChatSubMenu._ui._buttonBlockVote:SetShow(false)
      PaGlobal_ChatSubMenu._ui._buttonReportGoldSeller:SetShow(false)
      PaGlobal_ChatSubMenu._ui._buttonRecommand:SetShow(false)
    else
      PaGlobal_ChatSubMenu._ui._buttonBlockVote:SetShow(isCountryShow)
      PaGlobal_ChatSubMenu._ui._buttonBlockVote:SetIgnore(not isCountryOpen)
      PaGlobal_ChatSubMenu._ui._buttonBlockVote:SetMonoTone(not isCountryOpen)
      PaGlobal_ChatSubMenu._ui._buttonReportGoldSeller:SetShow(PaGlobal_ChatSubMenu._isReportGoldSellerOpen)
      PaGlobal_ChatSubMenu._ui._buttonRecommand:SetShow(isRecommand)
    end
    PaGlobal_ChatSubMenu._ui._buttonInviteParty:SetShow(isInviteParty)
    PaGlobal_ChatSubMenu._ui._buttonInviteGuild:SetShow(isInviteGuild)
    PaGlobal_ChatSubMenu._ui._buttonInviteCompetition:SetShow(isInviteCompetition)
    PaGlobal_ChatSubMenu._ui._buttonInviteParty:SetShow(false)
    PaGlobal_ChatSubMenu._ui._buttonInviteLargeParty:SetShow(false)
    local isEmptyParty = ToClient_IsPartyEmpty()
    if isEmptyParty then
      PaGlobal_ChatSubMenu._ui._buttonInviteParty:SetShow(true)
      if PaGlobal_ChatSubMenu.isLargePartyOpen then
        PaGlobal_ChatSubMenu._ui._buttonInviteLargeParty:SetShow(true)
      else
        PaGlobal_ChatSubMenu._ui._buttonInviteLargeParty:SetShow(false)
      end
    else
      local isPartyType = ToClient_GetPartyType()
      if false == PaGlobal_ChatSubMenu.isLargePartyOpen then
        isPartyType = 0
        PaGlobal_ChatSubMenu._ui._buttonInviteLargeParty:SetShow(false)
      end
      if 0 == isPartyType then
        PaGlobal_ChatSubMenu._ui._buttonInviteParty:SetShow(isInviteParty)
        PaGlobal_ChatSubMenu._ui._buttonInviteLargeParty:SetShow(false)
      elseif 1 == isPartyType then
        PaGlobal_ChatSubMenu._ui._buttonInviteLargeParty:SetShow(true)
        PaGlobal_ChatSubMenu._ui._buttonInviteParty:SetShow(false)
      end
    end
  end
  if PaGlobal_ChatSubMenu._ui._buttonBlockVote:GetShow() then
    PaGlobal_ChatSubMenu._ui._buttonBlockVote:SetPosY(buttonPosY)
    buttonPosY = buttonPosY + gapY
    bgSizeY = bgSizeY + gapY
  end
  if PaGlobal_ChatSubMenu._ui._buttonReportGoldSeller:GetShow() then
    PaGlobal_ChatSubMenu._ui._buttonReportGoldSeller:SetPosY(buttonPosY)
    buttonPosY = buttonPosY + gapY
    bgSizeY = bgSizeY + gapY
  end
  if PaGlobal_ChatSubMenu._ui._buttonInviteParty:GetShow() then
    PaGlobal_ChatSubMenu._ui._buttonInviteParty:SetPosY(buttonPosY)
    buttonPosY = buttonPosY + gapY
    bgSizeY = bgSizeY + gapY
  end
  if PaGlobal_ChatSubMenu._ui._buttonInviteLargeParty:GetShow() then
    PaGlobal_ChatSubMenu._ui._buttonInviteLargeParty:SetPosY(buttonPosY)
    buttonPosY = buttonPosY + gapY
    bgSizeY = bgSizeY + gapY
  end
  if PaGlobal_ChatSubMenu._ui._buttonInviteGuild:GetShow() then
    PaGlobal_ChatSubMenu._ui._buttonInviteGuild:SetPosY(buttonPosY)
    buttonPosY = buttonPosY + gapY
    bgSizeY = bgSizeY + gapY
  end
  if PaGlobal_ChatSubMenu._ui._buttonInviteCompetition:GetShow() then
    PaGlobal_ChatSubMenu._ui._buttonInviteCompetition:SetPosY(buttonPosY)
    buttonPosY = buttonPosY + gapY
    bgSizeY = bgSizeY + gapY
  end
  if PaGlobal_ChatSubMenu._ui._buttonInviteVolunteer:GetShow() then
    local isGuildMaster = getSelfPlayer():get():isGuildMaster()
    local isGuildSubMaster = getSelfPlayer():get():isGuildSubMaster()
    if true == _ContentsGroup_BattleFieldVolunteer and (true == isGuildMaster or true == isGuildSubMaster) then
      PaGlobal_ChatSubMenu._ui._buttonInviteVolunteer:SetPosY(buttonPosY)
      buttonPosY = buttonPosY + gapY
      bgSizeY = bgSizeY + gapY
    else
      PaGlobal_ChatSubMenu._ui._buttonInviteVolunteer:SetShow(false)
    end
  end
  if PaGlobal_ChatSubMenu._ui._buttonRecommand:GetShow() then
    PaGlobal_ChatSubMenu._ui._buttonRecommand:SetPosY(buttonPosY)
    buttonPosY = buttonPosY + gapY
    bgSizeY = bgSizeY + gapY
    PaGlobal_ChatSubMenu._ui._buttonRecommand:SetText(PAGetStringParam2(Defines.StringSheet_GAME, "LUA_THUMBSUP_VOTECOUNT", "currentVoteCount", ToClient_GetThumbsUpVoteCount(), "maxVoteCount", ToClient_getMaxThumbsUpVoteCount()))
  end
  PaGlobal_ChatSubMenu._ui._staticBg:SetText(clickedUserNickName .. "\n" .. clickedName)
  PaGlobal_ChatSubMenu._ui._staticBg:SetSize(PaGlobal_ChatSubMenu._ui._staticBg:GetSizeX(), bgSizeY)
  Panel_Chat_SubMenu:SetShow(true)
end
function PaGlobal_ChatSubMenu:SetPos(x, y)
  local screenSizeX = getScreenSizeX()
  local screenSizeY = getScreenSizeY()
  if screenSizeX <= x + PaGlobal_ChatSubMenu._ui._staticBg:GetSizeX() then
    x = screenSizeX - PaGlobal_ChatSubMenu._ui._staticBg:GetSizeX()
  end
  if screenSizeY <= y + PaGlobal_ChatSubMenu._ui._staticBg:GetSizeY() then
    y = screenSizeY - PaGlobal_ChatSubMenu._ui._staticBg:GetSizeY()
  end
  Panel_Chat_SubMenu:SetPosX(x)
  Panel_Chat_SubMenu:SetPosY(y)
end
function PaGlobal_ChatSubMenuSetClickedInfoInit()
  PaGlobal_ChatSubMenu._currentPoolIndex = nil
  PaGlobal_ChatSubMenu._clickedMessageIndex = nil
  PaGlobal_ChatSubMenu._clickedName = nil
  PaGlobal_ChatSubMenu._clickedUserNickName = nil
  PaGlobal_ChatSubMenu._clickedMsg = nil
  PaGlobal_ChatSubMenu._senderUserNo = nil
  PaGlobal_ChatSubMenu._chatRoomNo = nil
end
function PaGlobal_ChatSubMenuSetClickedInfo(currentPoolIndex, clickedMessageIndex, clickedName, clickedUserNickName, clickedMsg, senderUserNo, chatRoomNo)
  UI.ASSERT_NAME(nil ~= currentPoolIndex, "PaGlobal_ChatSubMenuSetClickedInfo currentPoolIndex nil", "\236\178\156\235\167\140\234\184\176")
  UI.ASSERT_NAME(nil ~= clickedMessageIndex, "PaGlobal_ChatSubMenuSetClickedInfo clickedMessageIndex nil", "\236\178\156\235\167\140\234\184\176")
  UI.ASSERT_NAME(nil ~= clickedName, "PaGlobal_ChatSubMenuSetClickedInfo clickedName nil", "\236\178\156\235\167\140\234\184\176")
  UI.ASSERT_NAME(nil ~= clickedUserNickName, "PaGlobal_ChatSubMenuSetClickedInfo clickedUserNickName nil", "\236\178\156\235\167\140\234\184\176")
  UI.ASSERT_NAME(nil ~= clickedMsg, "PaGlobal_ChatSubMenuSetClickedInfo clickedMsg nil", "\236\178\156\235\167\140\234\184\176")
  UI.ASSERT_NAME(nil ~= senderUserNo, "PaGlobal_ChatSubMenuSetClickedInfo senderUserNo nil", "\234\185\128\236\167\128\237\152\129")
  UI.ASSERT_NAME(nil ~= chatRoomNo, "PaGlobal_ChatSubMenuSetClickedInfo chatRoomNo nil", "\234\185\128\236\167\128\237\152\129")
  PaGlobal_ChatSubMenu._currentPoolIndex = currentPoolIndex
  PaGlobal_ChatSubMenu._clickedMessageIndex = clickedMessageIndex
  PaGlobal_ChatSubMenu._clickedName = clickedName
  PaGlobal_ChatSubMenu._clickedUserNickName = clickedUserNickName
  PaGlobal_ChatSubMenu._clickedMsg = clickedMsg
  PaGlobal_ChatSubMenu._senderUserNo = senderUserNo
  PaGlobal_ChatSubMenu._chatRoomNo = chatRoomNo
end
