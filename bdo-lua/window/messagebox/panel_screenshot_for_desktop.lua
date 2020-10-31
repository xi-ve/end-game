Panel_ScreenShot_For_Desktop:SetShow(false)
local ScreenShotSize = {
  _txt_title = UI.getChildControl(Panel_ScreenShot_For_Desktop, "Static_TitleBG"),
  _screenShotBG = UI.getChildControl(Panel_ScreenShot_For_Desktop, "Static_BG"),
  _txt_descBG = UI.getChildControl(Panel_ScreenShot_For_Desktop, "Static_DescBG"),
  _btn_ScreenShotApply = UI.getChildControl(Panel_ScreenShot_For_Desktop, "Button_Confirm"),
  _btn_ScreenShotCancel = UI.getChildControl(Panel_ScreenShot_For_Desktop, "Button_AlarmCancel")
}
function PaGlobal_Panel_ScreenShot_For_Desktop_Init()
  local self = ScreenShotSize
  local screenShotFileName = getRecentScreenShotFileName()
  self._txt_ScreenShotDesc = UI.getChildControl(self._txt_descBG, "StaticText_ScreenShotDesc")
  self._btn_ScreenShot_Win_Close = UI.getChildControl(self._txt_title, "Button_Win_Close")
  self._txt_ScreenShotDesc:SetTextMode(__eTextMode_AutoWrap)
  if nil == screenShotFileName or "" == screenShotFileName then
    self._txt_ScreenShotDesc:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_SCREENSHOTFORDESKTOP_DESC"))
  else
    self._txt_ScreenShotDesc:SetText(tostring(screenShotFileName) .. "\n" .. PAGetString(Defines.StringSheet_GAME, "LUA_SCREENSHOTFORDESKTOP_DESC"))
  end
  local textSizeY = self._txt_ScreenShotDesc:GetTextSizeY()
  self._txt_descBG:SetSize(self._txt_descBG:GetSizeX(), textSizeY + 10)
  self._screenShotBG:SetSize(self._screenShotBG:GetSizeX(), self._txt_descBG:GetSizeY() + 20)
  Panel_ScreenShot_For_Desktop:SetSize(Panel_ScreenShot_For_Desktop:GetSizeX(), self._txt_title:GetSizeY() + self._screenShotBG:GetSizeY() + 60)
  self._btn_ScreenShotApply:ComputePos()
  self._btn_ScreenShotCancel:ComputePos()
  Panel_ScreenShot_For_Desktop:ComputePos()
  self._btn_ScreenShot_Win_Close:addInputEvent("Mouse_LUp", "PaGlobal_Panel_ScreenShot_For_Desktop_Close()")
  self._btn_ScreenShotApply:addInputEvent("Mouse_LUp", "PaGlobal_Panel_ScreenShot_For_Desktop_Apply()")
  self._btn_ScreenShotCancel:addInputEvent("Mouse_LUp", "PaGlobal_Panel_ScreenShot_For_Desktop_OpenFolder()")
end
function PaGlobal_Panel_ScreenShot_For_Desktop_Position()
  local self = ScreenShotSize
  Panel_ScreenShot_For_Desktop:ComputePos()
  self._btn_ScreenShotApply:ComputePos()
  self._btn_ScreenShotCancel:ComputePos()
end
function PaGlobal_Panel_ScreenShot_For_Desktop_Open()
  local self = ScreenShotSize
  local screenShotFileName = getRecentScreenShotFileName()
  self._txt_ScreenShotDesc:SetTextMode(__eTextMode_AutoWrap)
  if nil == screenShotFileName or "" == screenShotFileName then
    self._txt_ScreenShotDesc:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_SCREENSHOTFORDESKTOP_DESC"))
  else
    self._txt_ScreenShotDesc:SetText(tostring(screenShotFileName) .. "\n" .. PAGetString(Defines.StringSheet_GAME, "LUA_SCREENSHOTFORDESKTOP_DESC"))
  end
  local textSizeY = self._txt_ScreenShotDesc:GetTextSizeY()
  self._txt_descBG:SetSize(self._txt_descBG:GetSizeX(), textSizeY + 10)
  self._screenShotBG:SetSize(self._screenShotBG:GetSizeX(), self._txt_descBG:GetSizeY() + 20)
  Panel_ScreenShot_For_Desktop:SetSize(Panel_ScreenShot_For_Desktop:GetSizeX(), self._txt_title:GetSizeY() + self._screenShotBG:GetSizeY() + 60)
  self._btn_ScreenShotApply:ComputePos()
  self._btn_ScreenShotCancel:ComputePos()
  Panel_ScreenShot_For_Desktop:ComputePos()
  Panel_ScreenShot_For_Desktop:SetShow(true)
end
function PaGlobal_Panel_ScreenShot_For_Desktop_Close()
  Panel_ScreenShot_For_Desktop:SetShow(false)
end
function PaGlobal_Panel_ScreenShot_For_Desktop_Apply()
  local filepath = getRecentScreenShotFileName()
  setWallpaper(filepath)
  PaGlobal_Panel_ScreenShot_For_Desktop_Close()
end
function PaGlobal_Panel_ScreenShot_For_Desktop_OpenFolder()
  ToClient_OpenDirectory(CppEnums.OpenDirectoryType.DirectoryType_ScreenShot)
end
registerEvent("FromClient_luaLoadComplete", "PaGlobal_Panel_ScreenShot_For_Desktop_Init")
registerEvent("onScreenResize", "PaGlobal_Panel_ScreenShot_For_Desktop_Position")
