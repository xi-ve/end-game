function PaGlobal_SelectInstruments_All:initialize()
  if true == PaGlobal_SelectInstruments_All._initialize then
    return
  end
  local stc_TitleBG = UI.getChildControl(Panel_Window_SelectInstruments_All, "Static_TitleBG")
  self._ui._btn_Close_PC = UI.getChildControl(stc_TitleBG, "Button_Win_Close_PC")
  local stc_MainBG = UI.getChildControl(Panel_Window_SelectInstruments_All, "Static_MainBg")
  self._ui._btn_WayPoint_Shop = UI.getChildControl(stc_MainBG, "Button_WayPoint_Shop")
  local stc_BottomGroup = UI.getChildControl(Panel_Window_SelectInstruments_All, "Static_BottomGroup")
  self._ui._btn_Confirm = UI.getChildControl(stc_BottomGroup, "Button_Confirm")
  local stc_MainBg = UI.getChildControl(Panel_Window_SelectInstruments_All, "Static_MainBg")
  self._ui._list2 = UI.getChildControl(stc_MainBg, "List2_1")
  self._ui._btn_Close = UI.getChildControl(stc_BottomGroup, "Button_Close")
  PaGlobal_SelectInstruments_All:registEventHandler()
  PaGlobal_SelectInstruments_All:validate()
  PaGlobal_SelectInstruments_All._initialize = true
end
function PaGlobal_SelectInstruments_All:registEventHandler()
  if nil == Panel_Window_SelectInstruments_All then
    return
  end
  self._ui._btn_Close_PC:addInputEvent("Mouse_LUp", "PaGloabl_SelectInstruments_All_Close(false)")
  self._ui._btn_Close:addInputEvent("Mouse_LUp", "PaGloabl_SelectInstruments_All_Close(false)")
  self._ui._btn_Confirm:addInputEvent("Mouse_LUp", "PaGloabl_SelectInstruments_All_ConfirmBtn()")
  self._ui._btn_WayPoint_Shop:addInputEvent("Mouse_LUp", "HandleClicked_TownNpcIcon_NaviStart(40)")
  self._ui._list2:registEvent(__ePAUIList2EventType_LuaChangeContent, "PaGlobal_SelectInstruments_All_ListControlCreate")
  self._ui._list2:createChildContent(__ePAUIList2ElementManagerType_List)
end
function PaGlobal_SelectInstruments_All:prepareOpen(musicIndex)
  if nil == Panel_Window_SelectInstruments_All then
    return
  end
  PaGlobal_SelectInstruments_All:update(musicIndex)
  PaGlobal_SelectInstruments_All:open()
end
function PaGlobal_SelectInstruments_All:open()
  if nil == Panel_Window_SelectInstruments_All then
    return
  end
  Panel_Window_SelectInstruments_All:SetShow(true)
end
function PaGlobal_SelectInstruments_All:prepareClose(isConfirm)
  if nil == Panel_Window_SelectInstruments_All then
    return
  end
  self._selectMusicIndex = -1
  self._selectTrackIndex = -1
  if false == isConfirm then
    PaGlobal_MusicBoard_All_SelectTrack(self._selectMusicIndex, self._selectTrackIndex)
  end
  PaGlobal_SelectInstruments_All:close()
end
function PaGlobal_SelectInstruments_All:close()
  if nil == Panel_Window_SelectInstruments_All then
    return
  end
  Panel_Window_SelectInstruments_All:SetShow(false)
end
function PaGlobal_SelectInstruments_All:update(musicIndex)
  if nil == Panel_Window_SelectInstruments_All then
    return
  end
  self._selectMusicIndex = musicIndex
  local musicInfo = ToClient_GetMusicInfoByIndex(musicIndex)
  if nil == musicInfo then
    return
  end
  self._ui._list2:getElementManager():clearKey()
  local instrumentTrackListSize = musicInfo:getTrackSize()
  for index = 0, instrumentTrackListSize - 1 do
    local trackType = musicInfo:getTrackTypeByIndex(index)
    if false == musicInfo:isEmpty(trackType) and true == Toclient_isHaveInstrument(trackType) then
      self._ui._list2:getElementManager():pushKey(trackType)
    end
  end
end
function PaGlobal_SelectInstruments_All:validate()
  if nil == Panel_Window_SelectInstruments_All then
    return
  end
  self._ui._btn_Close_PC:isValidate()
  self._ui._btn_WayPoint_Shop:isValidate()
  self._ui._btn_Confirm:isValidate()
end
function PaGlobal_SelectInstruments_All_ListControlCreate(control, key)
  if nil == Panel_Window_SelectInstruments_All then
    return
  end
  local self = PaGlobal_SelectInstruments_All
  local _key = Int64toInt32(key)
  local btn_Slot = UI.getChildControl(control, "RadioButton_Instruments_Slot")
  local text = UI.getChildControl(btn_Slot, "StaticText_1")
  text:SetText(PAGetString(Defines.StringSheet_GAME, "AUDIO_MIDI_INSTRUMENT_" .. tostring(key)))
  local normalUV, onUV, clickUV
  if 0 == _key then
    normalUV = {
      x1 = 187,
      y1 = 87,
      x2 = 217,
      y2 = 117
    }
    onUV = {
      x1 = 187,
      y1 = 118,
      x2 = 217,
      y2 = 148
    }
    clickUV = {
      x1 = 187,
      y1 = 149,
      x2 = 217,
      y2 = 179
    }
  elseif 1 == _key then
    normalUV = {
      x1 = 1,
      y1 = 87,
      x2 = 31,
      y2 = 117
    }
    onUV = {
      x1 = 1,
      y1 = 118,
      x2 = 31,
      y2 = 148
    }
    clickUV = {
      x1 = 1,
      y1 = 149,
      x2 = 31,
      y2 = 179
    }
  elseif 2 == _key then
    normalUV = {
      x1 = 404,
      y1 = 118,
      x2 = 434,
      y2 = 148
    }
    onUV = {
      x1 = 404,
      y1 = 87,
      x2 = 434,
      y2 = 117
    }
    clickUV = {
      x1 = 404,
      y1 = 149,
      x2 = 434,
      y2 = 179
    }
  elseif 3 == _key then
    normalUV = {
      x1 = 156,
      y1 = 87,
      x2 = 186,
      y2 = 117
    }
    onUV = {
      x1 = 156,
      y1 = 118,
      x2 = 186,
      y2 = 148
    }
    clickUV = {
      x1 = 156,
      y1 = 149,
      x2 = 186,
      y2 = 179
    }
  elseif 4 == _key then
    normalUV = {
      x1 = 94,
      y1 = 87,
      x2 = 124,
      y2 = 117
    }
    onUV = {
      x1 = 94,
      y1 = 118,
      x2 = 124,
      y2 = 148
    }
    clickUV = {
      x1 = 94,
      y1 = 149,
      x2 = 124,
      y2 = 179
    }
  elseif 5 == _key then
    normalUV = {
      x1 = 63,
      y1 = 87,
      x2 = 93,
      y2 = 117
    }
    onUV = {
      x1 = 63,
      y1 = 118,
      x2 = 93,
      y2 = 148
    }
    clickUV = {
      x1 = 63,
      y1 = 149,
      x2 = 93,
      y2 = 179
    }
  elseif 6 == _key then
    normalUV = {
      x1 = 125,
      y1 = 87,
      x2 = 155,
      y2 = 117
    }
    onUV = {
      x1 = 125,
      y1 = 118,
      x2 = 155,
      y2 = 148
    }
    clickUV = {
      x1 = 125,
      y1 = 149,
      x2 = 155,
      y2 = 179
    }
  elseif 7 == _key then
    normalUV = {
      x1 = 342,
      y1 = 87,
      x2 = 372,
      y2 = 117
    }
    onUV = {
      x1 = 342,
      y1 = 118,
      x2 = 372,
      y2 = 148
    }
    clickUV = {
      x1 = 342,
      y1 = 149,
      x2 = 372,
      y2 = 179
    }
  elseif 8 == _key then
    normalUV = {
      x1 = 311,
      y1 = 87,
      x2 = 341,
      y2 = 117
    }
    onUV = {
      x1 = 311,
      y1 = 118,
      x2 = 341,
      y2 = 148
    }
    clickUV = {
      x1 = 311,
      y1 = 149,
      x2 = 341,
      y2 = 179
    }
  elseif 9 == _key then
    normalUV = {
      x1 = 373,
      y1 = 87,
      x2 = 403,
      y2 = 117
    }
    onUV = {
      x1 = 373,
      y1 = 118,
      x2 = 403,
      y2 = 148
    }
    clickUV = {
      x1 = 373,
      y1 = 149,
      x2 = 403,
      y2 = 179
    }
  end
  if nil == normalUV or nil == onUV or nil == clickUV then
    return
  end
  btn_Slot:ChangeTextureInfoName("Combine/Etc/Combine_Etc_Concert_00.dds")
  btn_Slot:ChangeOnTextureInfoName("Combine/Etc/Combine_Etc_Concert_00.dds")
  btn_Slot:ChangeClickTextureInfoName("Combine/Etc/Combine_Etc_Concert_00.dds")
  local x1, y1, x2, y2 = setTextureUV_Func(btn_Slot, normalUV.x1, normalUV.y1, normalUV.x2, normalUV.y2)
  btn_Slot:getBaseTexture():setUV(x1, y1, x2, y2)
  local x1, y1, x2, y2 = setTextureUV_Func(btn_Slot, onUV.x1, onUV.y1, onUV.x2, onUV.y2)
  btn_Slot:getOnTexture():setUV(x1, y1, x2, y2)
  local x1, y1, x2, y2 = setTextureUV_Func(btn_Slot, clickUV.x1, clickUV.y1, clickUV.x2, clickUV.y2)
  btn_Slot:getClickTexture():setUV(x1, y1, x2, y2)
  btn_Slot:setRenderTexture(btn_Slot:getBaseTexture())
  btn_Slot:SetCheck(false)
  text:SetFontColor(Defines.Color.C_FFDDC39E)
  btn_Slot:addInputEvent("Mouse_LUp", "PaGloabl_SelectInstruments_All_SelectTrackIndex(" .. tostring(_key) .. ")")
end
function PaGlobal_SelectInstruments_All:selectTrackIndex(trackIndex)
  if nil == Panel_Window_SelectInstruments_All then
    return
  end
  self._selectTrackIndex = trackIndex
end
function PaGlobal_SelectInstruments_All:confirmBtn()
  if nil == Panel_Window_SelectInstruments_All then
    return
  end
  PaGlobal_MusicBoard_All_SelectTrack(self._selectMusicIndex, self._selectTrackIndex)
  PaGloabl_SelectInstruments_All_Close(true)
end
