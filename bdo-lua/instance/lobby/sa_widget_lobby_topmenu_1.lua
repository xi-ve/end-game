function PaGlobal_Lobby_TopMenu:initialize()
  if true == self._initialize then
    return
  end
  if nil == SA_Widget_Lobby_TopMenu then
    return
  end
  self._ui._mainMenu = UI.getChildControl(SA_Widget_Lobby_TopMenu, "Static_MainMenu")
  self._ui._myInfoBG = UI.getChildControl(SA_Widget_Lobby_TopMenu, "Static_MyInfo_BG")
  self._ui._static_OptionBtnBG = UI.getChildControl(self._ui._myInfoBG, "Static_OptionBtnBG")
  self._ui._radioButton_Play = UI.getChildControl(self._ui._mainMenu, "RadioButton_Play")
  self._ui._radioButton_Shop = UI.getChildControl(self._ui._mainMenu, "RadioButton_Shop")
  self._ui._radioButton_Rank = UI.getChildControl(self._ui._mainMenu, "RadioButton_Rank")
  self._ui._static_SelectBar_On = UI.getChildControl(self._ui._mainMenu, "Static_SelectBar_On")
  self._ui._static_SelectBar_Off = UI.getChildControl(self._ui._mainMenu, "Static_SelectBar_Off")
  self._ui._staticText_BlackPointValue = UI.getChildControl(self._ui._myInfoBG, "StaticText_BlackPointValue")
  self._ui._staticText_SilverValue = UI.getChildControl(self._ui._myInfoBG, "StaticText_SilverValue")
  self._ui._static_ProfileIcon_Noimage = UI.getChildControl(self._ui._myInfoBG, "Static_ProfileIcon_Noimage")
  self._ui._static_ProfileIcon = UI.getChildControl(self._ui._myInfoBG, "Static_ProfileIcon")
  self._ui._staticText_UserID = UI.getChildControl(self._ui._myInfoBG, "StaticText_UserID")
  self._ui._staticText_OnLine = UI.getChildControl(self._ui._myInfoBG, "StaticText_OnLine")
  self._ui._staticText_TierIcon = UI.getChildControl(self._ui._myInfoBG, "StaticText_TierIcon")
  self._ui._button_Option = UI.getChildControl(self._ui._static_OptionBtnBG, "Button_Option")
  self._ui._button_Minimization = UI.getChildControl(self._ui._static_OptionBtnBG, "Button_Minimization")
  self._ui._button_Close = UI.getChildControl(self._ui._static_OptionBtnBG, "Button_Close")
  self._ui._radioButton_Play:addInputEvent("Mouse_LUp", "HandleEventLup_Select_TopMenuTap(0)")
  self._ui._radioButton_Shop:addInputEvent("Mouse_LUp", "HandleEventLup_Select_TopMenuTap(1)")
  self._ui._radioButton_Rank:addInputEvent("Mouse_LUp", "HandleEventLup_Select_TopMenuTap(2)")
  self._ui._radioButton_Play:SetCheck(true)
  self:registEventHandler()
  self:validate()
  self:prepareOpen()
  self._initialize = true
end
function PaGlobal_Lobby_TopMenu:registEventHandler()
  if nil == SA_Widget_Lobby_TopMenu then
    return
  end
end
function PaGlobal_Lobby_TopMenu:prepareOpen()
  if nil == SA_Widget_Lobby_TopMenu then
    return
  end
  PaGlobal_Lobby_TopMenu:open()
end
function PaGlobal_Lobby_TopMenu:open()
  if nil == SA_Widget_Lobby_TopMenu then
    return
  end
  SA_Widget_Lobby_TopMenu:SetShow(true)
end
function PaGlobal_Lobby_TopMenu:prepareClose()
  if nil == SA_Widget_Lobby_TopMenu then
    return
  end
  SA_Widget_Lobby_TopMenu:ClearUpdateLuaFunc()
  PaGlobal_Lobby_TopMenu:close()
end
function PaGlobal_Lobby_TopMenu:close()
  if nil == SA_Widget_Lobby_TopMenu then
    return
  end
  SA_Widget_Lobby_TopMenu:SetShow(false)
end
function PaGlobal_Lobby_TopMenu:update()
  if nil == SA_Widget_Lobby_TopMenu then
    return
  end
end
function PaGlobal_Lobby_TopMenu:validate()
  if nil == SA_Widget_Lobby_TopMenu then
    return
  end
  self._ui._mainMenu:isValidate()
  self._ui._myInfoBG:isValidate()
  self._ui._static_OptionBtnBG:isValidate()
  self._ui._radioButton_Play:isValidate()
  self._ui._radioButton_Shop:isValidate()
  self._ui._radioButton_Rank:isValidate()
  self._ui._static_SelectBar_On:isValidate()
  self._ui._static_SelectBar_Off:isValidate()
  self._ui._staticText_BlackPointValue:isValidate()
  self._ui._staticText_SilverValue:isValidate()
  self._ui._static_ProfileIcon_Noimage:isValidate()
  self._ui._static_ProfileIcon:isValidate()
  self._ui._staticText_UserID:isValidate()
  self._ui._staticText_OnLine:isValidate()
  self._ui._staticText_TierIcon:isValidate()
  self._ui._button_Option:isValidate()
  self._ui._button_Minimization:isValidate()
  self._ui._button_Close:isValidate()
end
