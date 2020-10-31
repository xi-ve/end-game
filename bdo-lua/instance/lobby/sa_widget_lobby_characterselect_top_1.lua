function PaGlobal_Lobby_CharacterSelect_Top:initialize()
  if true == self._initialize then
    return
  end
  if nil == SA_Widget_Lobby_CharacterSelect_Top then
    return
  end
  self._ui._Button_BackSpaceBG = UI.getChildControl(SA_Widget_Lobby_CharacterSelect_Top, "Button_BackSpaceBG")
  self._ui._Static_RightGroup = UI.getChildControl(SA_Widget_Lobby_CharacterSelect_Top, "Static_RightGroup")
  self._ui._StaticText_BackSpaceArrow = UI.getChildControl(self._ui._Button_BackSpaceBG, "StaticText_BackSpaceArrow")
  self._ui._StaticText_Point = UI.getChildControl(self._ui._Static_RightGroup, "StaticText_Point")
  self._ui._Static_FunctionButtonGroup = UI.getChildControl(self._ui._Static_RightGroup, "Static_FunctionButtonGroup")
  self._ui._Button_Min = UI.getChildControl(self._ui._Static_FunctionButtonGroup, "Button_Min")
  self._ui._Button_Close = UI.getChildControl(self._ui._Static_FunctionButtonGroup, "Button_Close")
  self._ui._Button_BackSpaceBG:addInputEvent("Mouse_LUp", "HandleEventLup_Button_MainMenu()")
  self:registEventHandler()
  self:validate()
  self._initialize = true
end
function PaGlobal_Lobby_CharacterSelect_Top:registEventHandler()
  if nil == SA_Widget_Lobby_CharacterSelect_Top then
    return
  end
end
function PaGlobal_Lobby_CharacterSelect_Top:prepareOpen()
  if nil == SA_Widget_Lobby_CharacterSelect_Top then
    return
  end
  PaGlobal_Lobby_CharacterSelect_Top:open()
  self:update()
end
function PaGlobal_Lobby_CharacterSelect_Top:open()
  if nil == SA_Widget_Lobby_CharacterSelect_Top then
    return
  end
  SA_Widget_Lobby_CharacterSelect_Top:SetShow(true)
end
function PaGlobal_Lobby_CharacterSelect_Top:prepareClose()
  if nil == SA_Widget_Lobby_CharacterSelect_Top then
    return
  end
  SA_Widget_Lobby_CharacterSelect_Top:ClearUpdateLuaFunc()
  PaGlobal_Lobby_CharacterSelect_Top:close()
end
function PaGlobal_Lobby_CharacterSelect_Top:close()
  if nil == SA_Widget_Lobby_CharacterSelect_Top then
    return
  end
  SA_Widget_Lobby_CharacterSelect_Top:SetShow(false)
end
function PaGlobal_Lobby_CharacterSelect_Top:update()
  if nil == SA_Widget_Lobby_CharacterSelect_Top then
    return
  end
  local maxPoint = ToClient_getShadowArenaItemMaxPoint()
  local itemSlot = PaGlobal_Lobby_CharacterSelect_ItemSlot
  if nil == itemSlot then
    return
  end
  local usedPoint = itemSlot:usedPoint()
  self._ui._StaticText_Point:SetText(tostring(maxPoint - usedPoint))
end
function PaGlobal_Lobby_CharacterSelect_Top:validate()
  if nil == SA_Widget_Lobby_CharacterSelect_Top then
    return
  end
  self._ui._Button_BackSpaceBG:isValidate()
  self._ui._Static_RightGroup:isValidate()
  self._ui._StaticText_BackSpaceArrow:isValidate()
  self._ui._StaticText_Point:isValidate()
  self._ui._Static_FunctionButtonGroup:isValidate()
  self._ui._Button_Min:isValidate()
  self._ui._Button_Close:isValidate()
end
