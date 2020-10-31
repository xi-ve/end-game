function PaGlobal_MyInstruments_All:initialize()
  if true == PaGlobal_MyInstruments_All._initialize then
    return
  end
  local stc_TitleBG = UI.getChildControl(Panel_Window_MyInstruments_All, "Static_TitleBG")
  self._ui._btn_Close_PC = UI.getChildControl(stc_TitleBG, "Button_Win_Close_PC")
  local stc_MainBG = UI.getChildControl(Panel_Window_MyInstruments_All, "Static_MainBg")
  self._ui._btn_WayPoint_Shop = UI.getChildControl(stc_MainBG, "Button_WayPoint_Shop")
  local stc_BottomGroup = UI.getChildControl(Panel_Window_MyInstruments_All, "Static_BottomGroup")
  self._ui._btn_Confirm = UI.getChildControl(stc_BottomGroup, "Button_Confirm")
  local stc_MainBg = UI.getChildControl(Panel_Window_MyInstruments_All, "Static_MainBg")
  self._ui._list2 = UI.getChildControl(stc_MainBg, "List2_1")
  PaGlobal_MyInstruments_All:registEventHandler()
  PaGlobal_MyInstruments_All:validate()
  PaGlobal_MyInstruments_All._initialize = true
end
function PaGlobal_MyInstruments_All:registEventHandler()
  if nil == Panel_Window_MyInstruments_All then
    return
  end
  self._ui._btn_Close_PC:addInputEvent("Mouse_LUp", "PaGlobal_MyInstruments_All_Close()")
  self._ui._btn_Confirm:addInputEvent("Mouse_LUp", "PaGlobal_MyInstruments_All_Close()")
  self._ui._btn_WayPoint_Shop:addInputEvent("Mouse_LUp", "HandleClicked_TownNpcIcon_NaviStart(40)")
  self._ui._list2:registEvent(__ePAUIList2EventType_LuaChangeContent, "PaGlobal__MyInstruments_All_ListControlCreate")
  self._ui._list2:createChildContent(__ePAUIList2ElementManagerType_List)
end
function PaGlobal_MyInstruments_All:prepareOpen()
  if nil == Panel_Window_MyInstruments_All then
    return
  end
  PaGlobal_MyInstruments_All:update()
  PaGlobal_MyInstruments_All:open()
end
function PaGlobal_MyInstruments_All:open()
  if nil == Panel_Window_MyInstruments_All then
    return
  end
  Panel_Window_MyInstruments_All:SetShow(true)
end
function PaGlobal_MyInstruments_All:prepareClose()
  if nil == Panel_Window_MyInstruments_All then
    return
  end
  PaGlobal_MyInstruments_All:close()
end
function PaGlobal_MyInstruments_All:close()
  if nil == Panel_Window_MyInstruments_All then
    return
  end
  Panel_Window_MyInstruments_All:SetShow(false)
end
function PaGlobal_MyInstruments_All:update()
  if nil == Panel_Window_MyInstruments_All then
    return
  end
  self._ui._list2:getElementManager():clearKey()
  local instrumentCount = Toclient_getInstrumentSize()
  for index = 0, instrumentCount - 1 do
    local midiType = Toclient_getInstrumentByIndex(index)
    if -1 ~= midiType then
      self._ui._list2:getElementManager():pushKey(midiType)
    end
  end
end
function PaGlobal_MyInstruments_All:validate()
  if nil == Panel_Window_MyInstruments_All then
    return
  end
  self._ui._btn_Close_PC:isValidate()
  self._ui._btn_WayPoint_Shop:isValidate()
  self._ui._btn_Confirm:isValidate()
end
function PaGlobal__MyInstruments_All_ListControlCreate(control, key)
  if nil == Panel_Window_MyInstruments_All then
    return
  end
  local self = PaGlobal_MyInstruments_All
  local _key = Int64toInt32(key)
  local intrumentsSlot = UI.getChildControl(control, "StaticText_Intruments_Slot")
  local icon = UI.getChildControl(intrumentsSlot, "StaticText_Icon_Instruments")
  icon:ChangeTextureInfoName("Combine/Etc/Combine_Etc_Concert_00.dds")
  icon:SetText(PAGetString(Defines.StringSheet_GAME, "AUDIO_MIDI_INSTRUMENT_" .. tostring(key)))
  local normalUV
  if 0 == _key then
    normalUV = {
      x1 = 187,
      y1 = 149,
      x2 = 217,
      y2 = 179
    }
  elseif 1 == _key then
    normalUV = {
      x1 = 1,
      y1 = 149,
      x2 = 31,
      y2 = 179
    }
  elseif 2 == _key then
    normalUV = {
      x1 = 404,
      y1 = 149,
      x2 = 434,
      y2 = 179
    }
  elseif 3 == _key then
    normalUV = {
      x1 = 156,
      y1 = 149,
      x2 = 186,
      y2 = 179
    }
  elseif 4 == _key then
    normalUV = {
      x1 = 94,
      y1 = 149,
      x2 = 124,
      y2 = 179
    }
  elseif 5 == _key then
    normalUV = {
      x1 = 63,
      y1 = 149,
      x2 = 93,
      y2 = 179
    }
  elseif 6 == _key then
    normalUV = {
      x1 = 125,
      y1 = 149,
      x2 = 155,
      y2 = 179
    }
  elseif 7 == _key then
    normalUV = {
      x1 = 342,
      y1 = 149,
      x2 = 372,
      y2 = 179
    }
  elseif 8 == _key then
    normalUV = {
      x1 = 311,
      y1 = 149,
      x2 = 341,
      y2 = 179
    }
  elseif 9 == _key then
    normalUV = {
      x1 = 373,
      y1 = 149,
      x2 = 403,
      y2 = 179
    }
  end
  if nil == normalUV then
    return
  end
  local x1, y1, x2, y2 = setTextureUV_Func(icon, normalUV.x1, normalUV.y1, normalUV.x2, normalUV.y2)
  icon:getBaseTexture():setUV(x1, y1, x2, y2)
  icon:setRenderTexture(icon:getBaseTexture())
end
