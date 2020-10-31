function PaGlobal_FairyChangeSkill_Viewhelper_All:initialize()
  if true == PaGlobal_FairyChangeSkill_Viewhelper_All._initialize then
    return
  end
  self._ui.stc_TitleArea = UI.getChildControl(Panel_FairySkillChange_Viewhelp, "Static_TitleArea")
  self._ui.stc_Title = UI.getChildControl(self._ui.stc_TitleArea, "StaticText_Title")
  self._ui.btn_Win_Close = UI.getChildControl(self._ui.stc_TitleArea, "Button_Win_Close")
  self._ui.stc_MainArea = UI.getChildControl(Panel_FairySkillChange_Viewhelp, "Static_MainArea")
  self._ui.stc_LineBG = UI.getChildControl(Panel_FairySkillChange_Viewhelp, "Static_LineBG")
  self._ui.stc_Text_Desc = UI.getChildControl(self._ui.stc_LineBG, "StaticText_Desc")
  self._ui_pc.btn_Close_pc = UI.getChildControl(Panel_FairySkillChange_Viewhelp, "Button_Function")
  if _ContentsGroup_UsePadSnapping then
    self._ui_pc.btn_Close_pc:SetShow(false)
    self._ui.btn_Win_Close:SetShow(false)
    Panel_FairySkillChange_Viewhelp:SetSize(Panel_FairySkillChange_Viewhelp:GetSizeX(), Panel_FairySkillChange_Viewhelp:GetSizeY() - self._ui_pc.btn_Close_pc:GetSizeY() - 15)
  end
  PaGlobal_FairyChangeSkill_Viewhelper_All:registEventHandler()
  PaGlobal_FairyChangeSkill_Viewhelper_All:validate()
  PaGlobal_FairyChangeSkill_Viewhelper_All:descSetting()
  self._initialize = true
end
function PaGlobal_FairyChangeSkill_Viewhelper_All:registEventHandler()
  if nil == Panel_FairySkillChange_Viewhelp then
    return
  end
  self._ui.btn_Win_Close:addInputEvent("Mouse_LUp", "PaGlobal_FairyChangeSkill_Viewhelper_Close_All()")
  self._ui_pc.btn_Close_pc:addInputEvent("Mouse_LUp", "PaGlobal_FairyChangeSkill_Viewhelper_Close_All()")
end
function PaGlobal_FairyChangeSkill_Viewhelper_All:prepareOpen()
  Panel_FairySkillChange_Viewhelp:SetPosX(Panel_Window_FairyChangeSkill_All:GetPosX() + Panel_Window_FairyChangeSkill_All:GetSizeX() / 2 + Panel_FairySkillChange_Viewhelp:GetSizeX() / 2)
  Panel_FairySkillChange_Viewhelp:SetPosY(Panel_Window_FairyChangeSkill_All:GetPosY())
  PaGlobal_FairyChangeSkill_Viewhelper_All:open()
end
function PaGlobal_FairyChangeSkill_Viewhelper_All:open()
  if nil == Panel_FairySkillChange_Viewhelp then
    return
  end
  Panel_FairySkillChange_Viewhelp:SetShow(true)
end
function PaGlobal_FairyChangeSkill_Viewhelper_All:prepareClose()
  PaGlobal_FairyChangeSkill_Viewhelper_All:close()
end
function PaGlobal_FairyChangeSkill_Viewhelper_All:close()
  if nil == Panel_FairySkillChange_Viewhelp then
    return
  end
  Panel_FairySkillChange_Viewhelp:SetShow(false)
end
function PaGlobal_FairyChangeSkill_Viewhelper_All:validate()
  if nil == Panel_FairySkillChange_Viewhelp then
    return
  end
  self._ui.stc_TitleArea:isValidate()
  self._ui.stc_Title:isValidate()
  self._ui.btn_Win_Close:isValidate()
  self._ui.stc_MainArea:isValidate()
  self._ui.stc_LineBG:isValidate()
  self._ui.stc_Text_Desc:isValidate()
  self._ui_pc.btn_Close_pc:isValidate()
end
function PaGlobal_FairyChangeSkill_Viewhelper_All:descSetting()
  self._ui.stc_Text_Desc:SetTextMode(__eTextMode_AutoWrap)
  self._ui.stc_Text_Desc:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_FAIRY_SKILLCHANGE_INFO"))
  local addLenY = self._ui.stc_Text_Desc:GetTextSizeY() - self._ui.stc_LineBG:GetSizeY() + self._ui.stc_LineBG:GetSpanSize().y
  self._ui.stc_LineBG:SetSize(self._ui.stc_LineBG:GetSizeX(), self._ui.stc_LineBG:GetSizeY() + addLenY)
  Panel_FairySkillChange_Viewhelp:SetSize(Panel_FairySkillChange_Viewhelp:GetSizeX(), Panel_FairySkillChange_Viewhelp:GetSizeY() + addLenY)
  self._ui.stc_MainArea:SetSize(self._ui.stc_MainArea:GetSizeX(), self._ui.stc_MainArea:GetSizeY() + addLenY)
  self._ui_pc.btn_Close_pc:ComputePos()
  self._ui.stc_LineBG:ComputePos()
  self._ui.stc_Text_Desc:ComputePos()
end
