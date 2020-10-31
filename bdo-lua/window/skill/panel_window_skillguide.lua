local UI_ANI_ADV = CppEnums.PAUI_ANIM_ADVANCE_TYPE
local UI_color = Defines.Color
local IM = CppEnums.EProcessorInputMode
Panel_Window_SkillGuide:setMaskingChild(true)
Panel_Window_SkillGuide:ActiveMouseEventEffect(true)
Panel_Window_SkillGuide:setGlassBackground(true)
Panel_Window_SkillGuide:SetDragAll(true)
Panel_Window_SkillGuide:RegisterShowEventFunc(true, "Panel_Window_SkillGuide_ShowAni()")
Panel_Window_SkillGuide:RegisterShowEventFunc(false, "Panel_Window_SkillGuide_HideAni()")
local isBeastMasterOpen = ToClient_IsContentsGroupOpen("11")
local isBladerOpen = ToClient_IsContentsGroupOpen("12")
local isValkyrieOpen = ToClient_IsContentsGroupOpen("13")
local isMaeHwaOpen = ToClient_IsContentsGroupOpen("14")
local isWizardOpen = ToClient_IsContentsGroupOpen("15")
local isWitchOpen = ToClient_IsContentsGroupOpen("16")
local isKunoichiOpen = ToClient_IsContentsGroupOpen("17")
local isNinjaOpen = ToClient_IsContentsGroupOpen("18")
local isDarkElfOpen = ToClient_IsContentsGroupOpen("19")
local isCombattantOpen = ToClient_IsContentsGroupOpen("20")
local isCombattantWomenOpen = ToClient_IsContentsGroupOpen("917")
Panel_Window_SkillGuide:SetShow(false)
local ui = {
  _mainListBox = UI.getChildControl(Panel_Window_SkillGuide, "Static_Box"),
  _btn_WinClose = UI.getChildControl(Panel_Window_SkillGuide, "Button_Win_Close"),
  _btn_Close = UI.getChildControl(Panel_Window_SkillGuide, "Button_Close"),
  _btn_Question = UI.getChildControl(Panel_Window_SkillGuide, "Button_Question"),
  _verticalScroll = UI.getChildControl(Panel_Window_SkillGuide, "VerticalScroll")
}
ui._verticalScroll:SetShow(false)
local classBtn = {
  _btn_Class_0 = UI.getChildControl(Panel_Window_SkillGuide, "RadioButton_Class0"),
  _btn_Class_1 = UI.getChildControl(Panel_Window_SkillGuide, "RadioButton_Class1"),
  _btn_Class_2 = UI.getChildControl(Panel_Window_SkillGuide, "RadioButton_Class2"),
  _btn_Class_3 = UI.getChildControl(Panel_Window_SkillGuide, "RadioButton_Class3"),
  _btn_Class_4 = UI.getChildControl(Panel_Window_SkillGuide, "RadioButton_Class4"),
  _btn_Class_5 = UI.getChildControl(Panel_Window_SkillGuide, "RadioButton_Class5"),
  _btn_Class_6 = UI.getChildControl(Panel_Window_SkillGuide, "RadioButton_Class6"),
  _btn_Class_7 = UI.getChildControl(Panel_Window_SkillGuide, "RadioButton_Class7"),
  _btn_Class_8 = UI.getChildControl(Panel_Window_SkillGuide, "RadioButton_Class8"),
  _btn_Class_9 = UI.getChildControl(Panel_Window_SkillGuide, "RadioButton_Class9"),
  _btn_Class_10 = UI.getChildControl(Panel_Window_SkillGuide, "RadioButton_Class10"),
  _btn_Class_11 = UI.getChildControl(Panel_Window_SkillGuide, "RadioButton_Class11"),
  _btn_Class_12 = UI.getChildControl(Panel_Window_SkillGuide, "RadioButton_Class12"),
  _btn_Class_13 = UI.getChildControl(Panel_Window_SkillGuide, "RadioButton_Class13"),
  _btn_Class_14 = UI.getChildControl(Panel_Window_SkillGuide, "RadioButton_Class14")
}
local _btn_ScrollBtn = UI.getChildControl(ui._verticalScroll, "VerticalScroll_CtrlButton")
local copyUi = {
  _skillNameBG = UI.getChildControl(Panel_Window_SkillGuide, "Static_SkillList_BG"),
  _btn_PlayButton = UI.getChildControl(Panel_Window_SkillGuide, "Button_MovieTooltip")
}
ui._btn_WinClose:addInputEvent("Mouse_LUp", "Panel_Window_SkillGuide_ShowToggle()")
ui._btn_Close:addInputEvent("Mouse_LUp", "Panel_Window_SkillGuide_ShowToggle()")
local NowTitleInterval = 0
local MinTitleInterval = 0
local MaxTitleInterval = 0
local difficultyDesc_Warrior = {
  [0] = PAGetString(Defines.StringSheet_GAME, "LUA_SKILLGUIDE_DEFFICULTYDESC_MIDDLE"),
  [1] = PAGetString(Defines.StringSheet_GAME, "LUA_SKILLGUIDE_DEFFICULTYDESC_MIDDLE"),
  [2] = PAGetString(Defines.StringSheet_GAME, "LUA_SKILLGUIDE_DEFFICULTYDESC_HIGH"),
  [3] = PAGetString(Defines.StringSheet_GAME, "LUA_SKILLGUIDE_DEFFICULTYDESC_HIGHTOP"),
  [4] = PAGetString(Defines.StringSheet_GAME, "LUA_SKILLGUIDE_DEFFICULTYDESC_HIGHTOP")
}
local difficultyDesc_Warrior_TW = {
  [0] = PAGetString(Defines.StringSheet_GAME, "LUA_SKILLGUIDE_DEFFICULTYDESC_A_TW"),
  [1] = PAGetString(Defines.StringSheet_GAME, "LUA_SKILLGUIDE_DEFFICULTYDESC_B_TW"),
  [2] = PAGetString(Defines.StringSheet_GAME, "LUA_SKILLGUIDE_DEFFICULTYDESC_C_TW")
}
local difficultyDesc_Ranger = {
  [0] = PAGetString(Defines.StringSheet_GAME, "LUA_SKILLGUIDE_DEFFICULTYDESC_MIDDLE"),
  [1] = PAGetString(Defines.StringSheet_GAME, "LUA_SKILLGUIDE_DEFFICULTYDESC_MIDDLE"),
  [2] = PAGetString(Defines.StringSheet_GAME, "LUA_SKILLGUIDE_DEFFICULTYDESC_HIGH"),
  [3] = PAGetString(Defines.StringSheet_GAME, "LUA_SKILLGUIDE_DEFFICULTYDESC_HIGHTOP"),
  [4] = PAGetString(Defines.StringSheet_GAME, "LUA_SKILLGUIDE_DEFFICULTYDESC_HIGHTOP")
}
local difficultyDesc_Ranger_TW = {
  [0] = PAGetString(Defines.StringSheet_GAME, "LUA_SKILLGUIDE_DEFFICULTYDESC_A_TW"),
  [1] = PAGetString(Defines.StringSheet_GAME, "LUA_SKILLGUIDE_DEFFICULTYDESC_B_TW"),
  [2] = PAGetString(Defines.StringSheet_GAME, "LUA_SKILLGUIDE_DEFFICULTYDESC_C_TW")
}
local difficultyDesc_Sorcer = {
  [0] = PAGetString(Defines.StringSheet_GAME, "LUA_SKILLGUIDE_DEFFICULTYDESC_MIDDLE"),
  [1] = PAGetString(Defines.StringSheet_GAME, "LUA_SKILLGUIDE_DEFFICULTYDESC_MIDDLE"),
  [2] = PAGetString(Defines.StringSheet_GAME, "LUA_SKILLGUIDE_DEFFICULTYDESC_HIGH"),
  [3] = PAGetString(Defines.StringSheet_GAME, "LUA_SKILLGUIDE_DEFFICULTYDESC_HIGHTOP"),
  [4] = PAGetString(Defines.StringSheet_GAME, "LUA_SKILLGUIDE_DEFFICULTYDESC_HIGHTOP")
}
local difficultyDesc_Sorcer_TW = {
  [0] = PAGetString(Defines.StringSheet_GAME, "LUA_SKILLGUIDE_DEFFICULTYDESC_A_TW"),
  [1] = PAGetString(Defines.StringSheet_GAME, "LUA_SKILLGUIDE_DEFFICULTYDESC_B_TW"),
  [2] = PAGetString(Defines.StringSheet_GAME, "LUA_SKILLGUIDE_DEFFICULTYDESC_C_TW")
}
local difficultyDesc_Giant = {
  [0] = PAGetString(Defines.StringSheet_GAME, "LUA_SKILLGUIDE_DEFFICULTYDESC_MIDDLE"),
  [1] = PAGetString(Defines.StringSheet_GAME, "LUA_SKILLGUIDE_DEFFICULTYDESC_MIDDLE"),
  [2] = PAGetString(Defines.StringSheet_GAME, "LUA_SKILLGUIDE_DEFFICULTYDESC_HIGH"),
  [3] = PAGetString(Defines.StringSheet_GAME, "LUA_SKILLGUIDE_DEFFICULTYDESC_HIGH"),
  [4] = PAGetString(Defines.StringSheet_GAME, "LUA_SKILLGUIDE_DEFFICULTYDESC_HIGHTOP")
}
local difficultyDesc_Giant_TW = {
  [0] = PAGetString(Defines.StringSheet_GAME, "LUA_SKILLGUIDE_DEFFICULTYDESC_A_TW"),
  [1] = PAGetString(Defines.StringSheet_GAME, "LUA_SKILLGUIDE_DEFFICULTYDESC_B_TW"),
  [2] = PAGetString(Defines.StringSheet_GAME, "LUA_SKILLGUIDE_DEFFICULTYDESC_C_TW")
}
local difficultyDesc_Tamer = {
  [0] = PAGetString(Defines.StringSheet_GAME, "LUA_SKILLGUIDE_DEFFICULTYDESC_MIDDLE"),
  [1] = PAGetString(Defines.StringSheet_GAME, "LUA_SKILLGUIDE_DEFFICULTYDESC_MIDDLE"),
  [2] = PAGetString(Defines.StringSheet_GAME, "LUA_SKILLGUIDE_DEFFICULTYDESC_HIGH"),
  [3] = PAGetString(Defines.StringSheet_GAME, "LUA_SKILLGUIDE_DEFFICULTYDESC_HIGH"),
  [4] = PAGetString(Defines.StringSheet_GAME, "LUA_SKILLGUIDE_DEFFICULTYDESC_HIGHTOP")
}
local difficultyDesc_Tamer_TW = {
  [0] = PAGetString(Defines.StringSheet_GAME, "LUA_SKILLGUIDE_DEFFICULTYDESC_A_TW"),
  [1] = PAGetString(Defines.StringSheet_GAME, "LUA_SKILLGUIDE_DEFFICULTYDESC_B_TW"),
  [2] = PAGetString(Defines.StringSheet_GAME, "LUA_SKILLGUIDE_DEFFICULTYDESC_C_TW")
}
local difficultyDesc_BladeMaster = {
  [0] = PAGetString(Defines.StringSheet_GAME, "LUA_SKILLGUIDE_DEFFICULTYDESC_MIDDLE"),
  [1] = PAGetString(Defines.StringSheet_GAME, "LUA_SKILLGUIDE_DEFFICULTYDESC_MIDDLE"),
  [2] = PAGetString(Defines.StringSheet_GAME, "LUA_SKILLGUIDE_DEFFICULTYDESC_MIDDLE"),
  [3] = PAGetString(Defines.StringSheet_GAME, "LUA_SKILLGUIDE_DEFFICULTYDESC_HIGH"),
  [4] = PAGetString(Defines.StringSheet_GAME, "LUA_SKILLGUIDE_DEFFICULTYDESC_HIGHTOP")
}
local difficultyDesc_BladeMaster_TW = {
  [0] = PAGetString(Defines.StringSheet_GAME, "LUA_SKILLGUIDE_DEFFICULTYDESC_A_TW"),
  [1] = PAGetString(Defines.StringSheet_GAME, "LUA_SKILLGUIDE_DEFFICULTYDESC_B_TW"),
  [2] = PAGetString(Defines.StringSheet_GAME, "LUA_SKILLGUIDE_DEFFICULTYDESC_C_TW")
}
local difficultyDesc_Valkyrie = {
  [0] = PAGetString(Defines.StringSheet_GAME, "LUA_SKILLGUIDE_DEFFICULTYDESC_MIDDLE"),
  [1] = PAGetString(Defines.StringSheet_GAME, "LUA_SKILLGUIDE_DEFFICULTYDESC_MIDDLE"),
  [2] = PAGetString(Defines.StringSheet_GAME, "LUA_SKILLGUIDE_DEFFICULTYDESC_HIGH"),
  [3] = PAGetString(Defines.StringSheet_GAME, "LUA_SKILLGUIDE_DEFFICULTYDESC_HIGH"),
  [4] = PAGetString(Defines.StringSheet_GAME, "LUA_SKILLGUIDE_DEFFICULTYDESC_HIGHTOP")
}
local difficultyDesc_Valkyrie_TW = {
  [0] = PAGetString(Defines.StringSheet_GAME, "LUA_SKILLGUIDE_DEFFICULTYDESC_A_TW"),
  [1] = PAGetString(Defines.StringSheet_GAME, "LUA_SKILLGUIDE_DEFFICULTYDESC_B_TW"),
  [2] = PAGetString(Defines.StringSheet_GAME, "LUA_SKILLGUIDE_DEFFICULTYDESC_C_TW")
}
local difficultyDesc_BladeMasterWomen = {
  [0] = PAGetString(Defines.StringSheet_GAME, "LUA_SKILLGUIDE_DEFFICULTYDESC_LOW"),
  [1] = PAGetString(Defines.StringSheet_GAME, "LUA_SKILLGUIDE_DEFFICULTYDESC_LOW"),
  [2] = PAGetString(Defines.StringSheet_GAME, "LUA_SKILLGUIDE_DEFFICULTYDESC_MIDDLE"),
  [3] = PAGetString(Defines.StringSheet_GAME, "LUA_SKILLGUIDE_DEFFICULTYDESC_HIGH"),
  [4] = PAGetString(Defines.StringSheet_GAME, "LUA_SKILLGUIDE_DEFFICULTYDESC_HIGHTOP")
}
local difficultyDesc_BladeMasterWomen_TW = {
  [0] = PAGetString(Defines.StringSheet_GAME, "LUA_SKILLGUIDE_DEFFICULTYDESC_A_TW"),
  [1] = PAGetString(Defines.StringSheet_GAME, "LUA_SKILLGUIDE_DEFFICULTYDESC_B_TW"),
  [2] = PAGetString(Defines.StringSheet_GAME, "LUA_SKILLGUIDE_DEFFICULTYDESC_C_TW")
}
local difficultyDesc_Wizard = {
  [0] = PAGetString(Defines.StringSheet_GAME, "LUA_SKILLGUIDE_DEFFICULTYDESC_LOW"),
  [1] = PAGetString(Defines.StringSheet_GAME, "LUA_SKILLGUIDE_DEFFICULTYDESC_LOW"),
  [2] = PAGetString(Defines.StringSheet_GAME, "LUA_SKILLGUIDE_DEFFICULTYDESC_MIDDLE"),
  [3] = PAGetString(Defines.StringSheet_GAME, "LUA_SKILLGUIDE_DEFFICULTYDESC_HIGH"),
  [4] = PAGetString(Defines.StringSheet_GAME, "LUA_SKILLGUIDE_DEFFICULTYDESC_HIGHTOP")
}
local difficultyDesc_Wizard_TW = {
  [0] = PAGetString(Defines.StringSheet_GAME, "LUA_SKILLGUIDE_DEFFICULTYDESC_A_TW"),
  [1] = PAGetString(Defines.StringSheet_GAME, "LUA_SKILLGUIDE_DEFFICULTYDESC_B_TW"),
  [2] = PAGetString(Defines.StringSheet_GAME, "LUA_SKILLGUIDE_DEFFICULTYDESC_C_TW")
}
local difficultyDesc_WizardWomen = {
  [0] = PAGetString(Defines.StringSheet_GAME, "LUA_SKILLGUIDE_DEFFICULTYDESC_LOW"),
  [1] = PAGetString(Defines.StringSheet_GAME, "LUA_SKILLGUIDE_DEFFICULTYDESC_LOW"),
  [2] = PAGetString(Defines.StringSheet_GAME, "LUA_SKILLGUIDE_DEFFICULTYDESC_MIDDLE"),
  [3] = PAGetString(Defines.StringSheet_GAME, "LUA_SKILLGUIDE_DEFFICULTYDESC_HIGH"),
  [4] = PAGetString(Defines.StringSheet_GAME, "LUA_SKILLGUIDE_DEFFICULTYDESC_HIGHTOP")
}
local difficultyDesc_WizardWomen_TW = {
  [0] = PAGetString(Defines.StringSheet_GAME, "LUA_SKILLGUIDE_DEFFICULTYDESC_A_TW"),
  [1] = PAGetString(Defines.StringSheet_GAME, "LUA_SKILLGUIDE_DEFFICULTYDESC_B_TW"),
  [2] = PAGetString(Defines.StringSheet_GAME, "LUA_SKILLGUIDE_DEFFICULTYDESC_C_TW")
}
local difficultyDesc_NinjaWomen = {
  [0] = PAGetString(Defines.StringSheet_GAME, "LUA_SKILLGUIDE_DEFFICULTYDESC_LOW"),
  [1] = PAGetString(Defines.StringSheet_GAME, "LUA_SKILLGUIDE_DEFFICULTYDESC_LOW"),
  [2] = PAGetString(Defines.StringSheet_GAME, "LUA_SKILLGUIDE_DEFFICULTYDESC_MIDDLE"),
  [3] = PAGetString(Defines.StringSheet_GAME, "LUA_SKILLGUIDE_DEFFICULTYDESC_HIGH"),
  [4] = PAGetString(Defines.StringSheet_GAME, "LUA_SKILLGUIDE_DEFFICULTYDESC_HIGHTOP")
}
local difficultyDesc_NinjaWomen_TW = {
  [0] = PAGetString(Defines.StringSheet_GAME, "LUA_SKILLGUIDE_DEFFICULTYDESC_A_TW"),
  [1] = PAGetString(Defines.StringSheet_GAME, "LUA_SKILLGUIDE_DEFFICULTYDESC_B_TW"),
  [2] = PAGetString(Defines.StringSheet_GAME, "LUA_SKILLGUIDE_DEFFICULTYDESC_C_TW")
}
local difficultyDesc_NinjaMan = {
  [0] = PAGetString(Defines.StringSheet_GAME, "LUA_SKILLGUIDE_DEFFICULTYDESC_LOW"),
  [1] = PAGetString(Defines.StringSheet_GAME, "LUA_SKILLGUIDE_DEFFICULTYDESC_LOW"),
  [2] = PAGetString(Defines.StringSheet_GAME, "LUA_SKILLGUIDE_DEFFICULTYDESC_MIDDLE"),
  [3] = PAGetString(Defines.StringSheet_GAME, "LUA_SKILLGUIDE_DEFFICULTYDESC_HIGH"),
  [4] = PAGetString(Defines.StringSheet_GAME, "LUA_SKILLGUIDE_DEFFICULTYDESC_HIGHTOP")
}
local difficultyDesc_NinjaMan_TW = {
  [0] = PAGetString(Defines.StringSheet_GAME, "LUA_SKILLGUIDE_DEFFICULTYDESC_A_TW"),
  [1] = PAGetString(Defines.StringSheet_GAME, "LUA_SKILLGUIDE_DEFFICULTYDESC_B_TW"),
  [2] = PAGetString(Defines.StringSheet_GAME, "LUA_SKILLGUIDE_DEFFICULTYDESC_C_TW")
}
local difficultyDesc_Darkelf = {
  [0] = PAGetString(Defines.StringSheet_GAME, "LUA_SKILLGUIDE_DEFFICULTYDESC_LOW"),
  [1] = PAGetString(Defines.StringSheet_GAME, "LUA_SKILLGUIDE_DEFFICULTYDESC_LOW"),
  [2] = PAGetString(Defines.StringSheet_GAME, "LUA_SKILLGUIDE_DEFFICULTYDESC_MIDDLE"),
  [3] = PAGetString(Defines.StringSheet_GAME, "LUA_SKILLGUIDE_DEFFICULTYDESC_HIGH"),
  [4] = PAGetString(Defines.StringSheet_GAME, "LUA_SKILLGUIDE_DEFFICULTYDESC_HIGHTOP")
}
local difficultyDesc_Darkelf_TW = {
  [0] = PAGetString(Defines.StringSheet_GAME, "LUA_SKILLGUIDE_DEFFICULTYDESC_A_TW"),
  [1] = PAGetString(Defines.StringSheet_GAME, "LUA_SKILLGUIDE_DEFFICULTYDESC_B_TW"),
  [2] = PAGetString(Defines.StringSheet_GAME, "LUA_SKILLGUIDE_DEFFICULTYDESC_C_TW")
}
local difficultyDesc_Combattant = {
  [0] = PAGetString(Defines.StringSheet_GAME, "LUA_SKILLGUIDE_DEFFICULTYDESC_LOW"),
  [1] = PAGetString(Defines.StringSheet_GAME, "LUA_SKILLGUIDE_DEFFICULTYDESC_LOW"),
  [2] = PAGetString(Defines.StringSheet_GAME, "LUA_SKILLGUIDE_DEFFICULTYDESC_MIDDLE"),
  [3] = PAGetString(Defines.StringSheet_GAME, "LUA_SKILLGUIDE_DEFFICULTYDESC_HIGH"),
  [4] = PAGetString(Defines.StringSheet_GAME, "LUA_SKILLGUIDE_DEFFICULTYDESC_HIGHTOP")
}
local difficultyDesc_Combattant_TW = {
  [0] = PAGetString(Defines.StringSheet_GAME, "LUA_SKILLGUIDE_DEFFICULTYDESC_A_TW"),
  [1] = PAGetString(Defines.StringSheet_GAME, "LUA_SKILLGUIDE_DEFFICULTYDESC_B_TW"),
  [2] = PAGetString(Defines.StringSheet_GAME, "LUA_SKILLGUIDE_DEFFICULTYDESC_C_TW")
}
local difficultyDesc_CombattantWomen = {
  [0] = PAGetString(Defines.StringSheet_GAME, "LUA_SKILLGUIDE_DEFFICULTYDESC_LOW"),
  [1] = PAGetString(Defines.StringSheet_GAME, "LUA_SKILLGUIDE_DEFFICULTYDESC_LOW"),
  [2] = PAGetString(Defines.StringSheet_GAME, "LUA_SKILLGUIDE_DEFFICULTYDESC_MIDDLE"),
  [3] = PAGetString(Defines.StringSheet_GAME, "LUA_SKILLGUIDE_DEFFICULTYDESC_HIGH"),
  [4] = PAGetString(Defines.StringSheet_GAME, "LUA_SKILLGUIDE_DEFFICULTYDESC_HIGHTOP")
}
local difficultyDesc_CombattantWomen_TW = {
  [0] = PAGetString(Defines.StringSheet_GAME, "LUA_SKILLGUIDE_DEFFICULTYDESC_A_TW"),
  [1] = PAGetString(Defines.StringSheet_GAME, "LUA_SKILLGUIDE_DEFFICULTYDESC_B_TW"),
  [2] = PAGetString(Defines.StringSheet_GAME, "LUA_SKILLGUIDE_DEFFICULTYDESC_C_TW")
}
function Panel_Window_SkillGuide_ShowAni()
  UIAni.AlphaAnimation(1, Panel_Window_SkillGuide, 0, 0.15)
  local aniInfo1 = Panel_Window_SkillGuide:addScaleAnimation(0, 0.08, UI_ANI_ADV.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfo1:SetStartScale(0.5)
  aniInfo1:SetEndScale(1.1)
  aniInfo1.AxisX = Panel_Window_SkillGuide:GetSizeX() / 2
  aniInfo1.AxisY = Panel_Window_SkillGuide:GetSizeY() / 2
  aniInfo1.ScaleType = 2
  aniInfo1.IsChangeChild = true
  local aniInfo2 = Panel_Window_SkillGuide:addScaleAnimation(0.08, 0.15, UI_ANI_ADV.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfo2:SetStartScale(1.1)
  aniInfo2:SetEndScale(1)
  aniInfo2.AxisX = Panel_Window_SkillGuide:GetSizeX() / 2
  aniInfo2.AxisY = Panel_Window_SkillGuide:GetSizeY() / 2
  aniInfo2.ScaleType = 2
  aniInfo2.IsChangeChild = true
end
function Panel_Window_SkillGuide_HideAni()
  local aniInfo = UIAni.AlphaAnimation(0, Panel_Window_SkillGuide, 0, 0.1)
  aniInfo:SetHideAtEnd(true)
end
local tempSkillGuide = {
  _skillListBG = UI.getChildControl(Panel_Window_SkillGuide, "Static_SkillList_BG"),
  _playButton = UI.getChildControl(Panel_Window_SkillGuide, "Button_MovieTooltip")
}
local maxMovieCount = 5
if isGameTypeTaiwan() then
  maxMovieCount = 3
else
  maxMovieCount = 5
end
local classType = {
  [__eClassType_Warrior] = {
    _maxMovieCount = maxMovieCount - 1,
    _currentPos = 0,
    _interval = 0,
    _name = " " .. PAGetString(Defines.StringSheet_GAME, "LUA_GLOBAL_CLASSTYPE_WARRIOR")
  },
  [__eClassType_ElfRanger] = {
    _maxMovieCount = maxMovieCount - 1,
    _currentPos = 0,
    _interval = 0,
    _name = " " .. PAGetString(Defines.StringSheet_GAME, "LUA_GLOBAL_CLASSTYPE_RANGER")
  },
  [__eClassType_Sorcerer] = {
    _maxMovieCount = maxMovieCount - 1,
    _currentPos = 0,
    _interval = 0,
    _name = " " .. PAGetString(Defines.StringSheet_GAME, "LUA_GLOBAL_CLASSTYPE_SORCERER")
  },
  [__eClassType_Giant] = {
    _maxMovieCount = maxMovieCount - 1,
    _currentPos = 0,
    _interval = 0,
    _name = " " .. PAGetString(Defines.StringSheet_GAME, "LUA_GLOBAL_CLASSTYPE_GIANT")
  },
  [__eClassType_Tamer] = {
    _maxMovieCount = maxMovieCount - 1,
    _currentPos = 0,
    _interval = 0,
    _name = " " .. PAGetString(Defines.StringSheet_GAME, "LUA_GLOBAL_CLASSTYPE_TAMER")
  },
  [__eClassType_BladeMaster] = {
    _maxMovieCount = maxMovieCount - 1,
    _currentPos = 0,
    _interval = 0,
    _name = " " .. PAGetString(Defines.StringSheet_GAME, "LUA_GLOBAL_CLASSTYPE_BLADEMASTER")
  },
  [__eClassType_Valkyrie] = {
    _maxMovieCount = maxMovieCount - 1,
    _currentPos = 0,
    _interval = 0,
    _name = " " .. PAGetString(Defines.StringSheet_GAME, "LUA_GLOBAL_CLASSTYPE_VALKYRIE")
  },
  [__eClassType_BladeMasterWoman] = {
    _maxMovieCount = maxMovieCount - 1,
    _currentPos = 0,
    _interval = 0,
    _name = " " .. PAGetString(Defines.StringSheet_GAME, "LUA_GLOBAL_CLASSTYPE_BLADEMASTERWOMAN")
  },
  [__eClassType_WizardMan] = {
    _maxMovieCount = maxMovieCount - 1,
    _currentPos = 0,
    _interval = 0,
    _name = " " .. PAGetString(Defines.StringSheet_GAME, "LUA_GLOBAL_CLASSTYPE_WIZARD")
  },
  [__eClassType_WizardWoman] = {
    _maxMovieCount = maxMovieCount - 1,
    _currentPos = 0,
    _interval = 0,
    _name = " " .. PAGetString(Defines.StringSheet_GAME, "LUA_GLOBAL_CLASSTYPE_WIZARDWOMAN")
  },
  [__eClassType_Kunoichi] = {
    _maxMovieCount = maxMovieCount - 1,
    _currentPos = 0,
    _interval = 0,
    _name = " " .. PAGetString(Defines.StringSheet_GAME, "LUA_GLOBAL_CLASSTYPE_NINJAWOMEN")
  },
  [__eClassType_NinjaMan] = {
    _maxMovieCount = maxMovieCount - 1,
    _currentPos = 0,
    _interval = 0,
    _name = " " .. PAGetString(Defines.StringSheet_GAME, "LUA_GLOBAL_CLASSTYPE_NINJAMAN")
  },
  [__eClassType_DarkElf] = {
    _maxMovieCount = maxMovieCount - 1,
    _currentPos = 0,
    _interval = 0,
    _name = " " .. PAGetString(Defines.StringSheet_GAME, "LUA_GLOBAL_CLASSTYPE_DARKELF")
  },
  [__eClassType_Combattant] = {
    _maxMovieCount = maxMovieCount - 1,
    _currentPos = 0,
    _interval = 0,
    _name = " " .. PAGetString(Defines.StringSheet_GAME, "LUA_GLOBAL_CLASSTYPE_STRIKER")
  },
  [__eClassType_Mystic] = {
    _maxMovieCount = maxMovieCount - 1,
    _currentPos = 0,
    _interval = 0,
    _name = " " .. PAGetString(Defines.StringSheet_GAME, "LUA_GLOBAL_CLASSTYPE_COMBATTANTWOMEN")
  }
}
local maxCount = 9
local skillMovieList = {}
local currentSelectedClass = __eClassType_Warrior
function Panel_Window_SkillGuide_Initialize()
  local player = getSelfPlayer()
  if nil == player then
    return
  end
  local myClassType = getSelfPlayer():getClassType()
  local guideStartY = 5
  local guideGapY = 49
  for idx = 0, maxCount - 1 do
    local createSkillListBG = UI.createControl(__ePAUIControl_StaticText, ui._mainListBox, "StaticText_SkillGuide_" .. idx)
    CopyBaseProperty(copyUi._skillNameBG, createSkillListBG)
    createSkillListBG:SetPosX(5)
    createSkillListBG:SetPosY(guideStartY)
    createSkillListBG:SetShow(true)
    local createPlayButton = UI.createControl(__ePAUIControl_Button, createSkillListBG, "Button_PlayButton_" .. idx)
    CopyBaseProperty(copyUi._btn_PlayButton, createPlayButton)
    createPlayButton:SetPosX(createSkillListBG:GetSizeX() - createPlayButton:GetSizeX() - 10)
    createPlayButton:SetShow(true)
    skillMovieList[idx] = {}
    skillMovieList[idx]._bg = createSkillListBG
    skillMovieList[idx]._btn = createPlayButton
    ui._mainListBox:addInputEvent("Mouse_DownScroll", "Panel_SkillGuide_ScrollEventFunc( false )")
    ui._mainListBox:addInputEvent("Mouse_UpScroll", "Panel_SkillGuide_ScrollEventFunc( true )")
    skillMovieList[idx]._bg:addInputEvent("Mouse_DownScroll", "Panel_SkillGuide_ScrollEventFunc( false )")
    skillMovieList[idx]._bg:addInputEvent("Mouse_UpScroll", "Panel_SkillGuide_ScrollEventFunc( true )")
    skillMovieList[idx]._btn:addInputEvent("Mouse_DownScroll", "Panel_SkillGuide_ScrollEventFunc( false )")
    skillMovieList[idx]._btn:addInputEvent("Mouse_UpScroll", "Panel_SkillGuide_ScrollEventFunc( true )")
    guideStartY = guideStartY + guideGapY
  end
  for _, v in pairs(classBtn) do
    v:SetCheck(false)
  end
  for _, v in pairs(classBtn) do
    v:SetShow(false)
  end
  classBtn._btn_Class_0:addInputEvent("Mouse_LUp", "Panel_SkillGuide_ClassClicked(" .. __eClassType_Warrior .. ")")
  classBtn._btn_Class_1:addInputEvent("Mouse_LUp", "Panel_SkillGuide_ClassClicked(" .. __eClassType_ElfRanger .. ")")
  classBtn._btn_Class_2:addInputEvent("Mouse_LUp", "Panel_SkillGuide_ClassClicked(" .. __eClassType_Sorcerer .. ")")
  classBtn._btn_Class_3:addInputEvent("Mouse_LUp", "Panel_SkillGuide_ClassClicked(" .. __eClassType_Giant .. ")")
  classBtn._btn_Class_4:addInputEvent("Mouse_LUp", "Panel_SkillGuide_ClassClicked(" .. __eClassType_Tamer .. ")")
  classBtn._btn_Class_5:addInputEvent("Mouse_LUp", "Panel_SkillGuide_ClassClicked(" .. __eClassType_BladeMaster .. ")")
  classBtn._btn_Class_6:addInputEvent("Mouse_LUp", "Panel_SkillGuide_ClassClicked(" .. __eClassType_Valkyrie .. ")")
  classBtn._btn_Class_7:addInputEvent("Mouse_LUp", "Panel_SkillGuide_ClassClicked(" .. __eClassType_BladeMasterWoman .. ")")
  classBtn._btn_Class_8:addInputEvent("Mouse_LUp", "Panel_SkillGuide_ClassClicked(" .. __eClassType_WizardMan .. ")")
  classBtn._btn_Class_9:addInputEvent("Mouse_LUp", "Panel_SkillGuide_ClassClicked(" .. __eClassType_WizardWoman .. ")")
  classBtn._btn_Class_10:addInputEvent("Mouse_LUp", "Panel_SkillGuide_ClassClicked(" .. __eClassType_Kunoichi .. ")")
  classBtn._btn_Class_11:addInputEvent("Mouse_LUp", "Panel_SkillGuide_ClassClicked(" .. __eClassType_NinjaMan .. ")")
  classBtn._btn_Class_12:addInputEvent("Mouse_LUp", "Panel_SkillGuide_ClassClicked(" .. __eClassType_DarkElf .. ")")
  classBtn._btn_Class_13:addInputEvent("Mouse_LUp", "Panel_SkillGuide_ClassClicked(" .. __eClassType_Combattant .. ")")
  classBtn._btn_Class_14:addInputEvent("Mouse_LUp", "Panel_SkillGuide_ClassClicked(" .. __eClassType_Mystic .. ")")
  classBtn._btn_Class_0:addInputEvent("Mouse_On", "Panel_SkillGuide_Tooltip( true, " .. __eClassType_Warrior .. ")")
  classBtn._btn_Class_0:addInputEvent("Mouse_Out", "Panel_SkillGuide_Tooltip( false, " .. __eClassType_Warrior .. ")")
  classBtn._btn_Class_1:addInputEvent("Mouse_On", "Panel_SkillGuide_Tooltip( true, " .. __eClassType_ElfRanger .. ")")
  classBtn._btn_Class_1:addInputEvent("Mouse_Out", "Panel_SkillGuide_Tooltip( false, " .. __eClassType_ElfRanger .. ")")
  classBtn._btn_Class_2:addInputEvent("Mouse_On", "Panel_SkillGuide_Tooltip( true, " .. __eClassType_Sorcerer .. ")")
  classBtn._btn_Class_2:addInputEvent("Mouse_Out", "Panel_SkillGuide_Tooltip( false, " .. __eClassType_Sorcerer .. ")")
  classBtn._btn_Class_3:addInputEvent("Mouse_On", "Panel_SkillGuide_Tooltip( true, " .. __eClassType_Giant .. ")")
  classBtn._btn_Class_3:addInputEvent("Mouse_Out", "Panel_SkillGuide_Tooltip( false, " .. __eClassType_Giant .. ")")
  classBtn._btn_Class_4:addInputEvent("Mouse_On", "Panel_SkillGuide_Tooltip( true, " .. __eClassType_Tamer .. ")")
  classBtn._btn_Class_4:addInputEvent("Mouse_Out", "Panel_SkillGuide_Tooltip( false, " .. __eClassType_Tamer .. ")")
  classBtn._btn_Class_5:addInputEvent("Mouse_On", "Panel_SkillGuide_Tooltip( true, " .. __eClassType_BladeMaster .. ")")
  classBtn._btn_Class_5:addInputEvent("Mouse_Out", "Panel_SkillGuide_Tooltip( false, " .. __eClassType_BladeMaster .. ")")
  classBtn._btn_Class_6:addInputEvent("Mouse_On", "Panel_SkillGuide_Tooltip( true, " .. __eClassType_Valkyrie .. ")")
  classBtn._btn_Class_6:addInputEvent("Mouse_Out", "Panel_SkillGuide_Tooltip( false, " .. __eClassType_Valkyrie .. ")")
  classBtn._btn_Class_7:addInputEvent("Mouse_On", "Panel_SkillGuide_Tooltip( true, " .. __eClassType_BladeMasterWoman .. ")")
  classBtn._btn_Class_7:addInputEvent("Mouse_Out", "Panel_SkillGuide_Tooltip( false, " .. __eClassType_BladeMasterWoman .. ")")
  classBtn._btn_Class_8:addInputEvent("Mouse_On", "Panel_SkillGuide_Tooltip( true, " .. __eClassType_WizardMan .. ")")
  classBtn._btn_Class_8:addInputEvent("Mouse_Out", "Panel_SkillGuide_Tooltip( false, " .. __eClassType_WizardMan .. ")")
  classBtn._btn_Class_9:addInputEvent("Mouse_On", "Panel_SkillGuide_Tooltip( true, " .. __eClassType_WizardWoman .. ")")
  classBtn._btn_Class_9:addInputEvent("Mouse_Out", "Panel_SkillGuide_Tooltip( false, " .. __eClassType_WizardWoman .. ")")
  classBtn._btn_Class_10:addInputEvent("Mouse_On", "Panel_SkillGuide_Tooltip( true, " .. __eClassType_Kunoichi .. ")")
  classBtn._btn_Class_10:addInputEvent("Mouse_Out", "Panel_SkillGuide_Tooltip( false, " .. __eClassType_Kunoichi .. ")")
  classBtn._btn_Class_11:addInputEvent("Mouse_On", "Panel_SkillGuide_Tooltip( true, " .. __eClassType_NinjaMan .. ")")
  classBtn._btn_Class_11:addInputEvent("Mouse_Out", "Panel_SkillGuide_Tooltip( false, " .. __eClassType_NinjaMan .. ")")
  classBtn._btn_Class_12:addInputEvent("Mouse_On", "Panel_SkillGuide_Tooltip( true, " .. __eClassType_DarkElf .. ")")
  classBtn._btn_Class_12:addInputEvent("Mouse_Out", "Panel_SkillGuide_Tooltip( false, " .. __eClassType_DarkElf .. ")")
  classBtn._btn_Class_13:addInputEvent("Mouse_On", "Panel_SkillGuide_Tooltip( true, " .. __eClassType_Combattant .. ")")
  classBtn._btn_Class_13:addInputEvent("Mouse_Out", "Panel_SkillGuide_Tooltip( false, " .. __eClassType_Combattant .. ")")
  classBtn._btn_Class_14:addInputEvent("Mouse_On", "Panel_SkillGuide_Tooltip( true, " .. __eClassType_Mystic .. ")")
  classBtn._btn_Class_14:addInputEvent("Mouse_Out", "Panel_SkillGuide_Tooltip( false, " .. __eClassType_Mystic .. ")")
  classBtn._btn_Class_0:SetCheck(true)
  classBtn._btn_Class_0:SetShow(true)
  classBtn._btn_Class_1:SetShow(true)
  classBtn._btn_Class_2:SetShow(true)
  classBtn._btn_Class_3:SetShow(true)
  if true == isBeastMasterOpen then
    classBtn._btn_Class_4:SetShow(true)
  end
  if true == isBladerOpen then
    classBtn._btn_Class_5:SetShow(true)
  end
  if true == isValkyrieOpen then
    classBtn._btn_Class_6:SetShow(true)
  end
  if true == isMaeHwaOpen then
    classBtn._btn_Class_7:SetShow(true)
  end
  if true == isWizardOpen then
    classBtn._btn_Class_8:SetShow(true)
  end
  if true == isWitchOpen then
    classBtn._btn_Class_9:SetShow(true)
  end
  if true == isKunoichiOpen then
    classBtn._btn_Class_10:SetShow(true)
  end
  if true == isNinjaOpen then
    classBtn._btn_Class_11:SetShow(true)
  end
  if true == isDarkElfOpen then
    classBtn._btn_Class_12:SetShow(true)
  end
  if true == isCombattantOpen then
    classBtn._btn_Class_13:SetShow(true)
  end
  if true == isCombattantWomenOpen then
    classBtn._btn_Class_14:SetShow(true)
  end
  classBtn._btn_Class_0:ResetVertexAni()
  classBtn._btn_Class_0:SetVertexAniRun("Ani_Color", true)
  if __eClassType_Warrior == myClassType then
    classBtn._btn_Class_0:SetCheck(true)
    classBtn._btn_Class_1:SetCheck(false)
    classBtn._btn_Class_2:SetCheck(false)
    classBtn._btn_Class_3:SetCheck(false)
    classBtn._btn_Class_4:SetCheck(false)
    classBtn._btn_Class_5:SetCheck(false)
    classBtn._btn_Class_6:SetCheck(false)
    classBtn._btn_Class_7:SetCheck(false)
    classBtn._btn_Class_8:SetCheck(false)
    classBtn._btn_Class_9:SetCheck(false)
    classBtn._btn_Class_10:SetCheck(false)
    classBtn._btn_Class_11:SetCheck(false)
    classBtn._btn_Class_12:SetCheck(false)
    classBtn._btn_Class_13:SetCheck(false)
    classBtn._btn_Class_14:SetCheck(false)
    Panel_SkillGuide_ClassClicked(__eClassType_Warrior)
  elseif __eClassType_ElfRanger == myClassType then
    classBtn._btn_Class_1:SetCheck(true)
    classBtn._btn_Class_0:SetCheck(false)
    classBtn._btn_Class_2:SetCheck(false)
    classBtn._btn_Class_3:SetCheck(false)
    classBtn._btn_Class_4:SetCheck(false)
    classBtn._btn_Class_5:SetCheck(false)
    classBtn._btn_Class_6:SetCheck(false)
    classBtn._btn_Class_7:SetCheck(false)
    classBtn._btn_Class_8:SetCheck(false)
    classBtn._btn_Class_9:SetCheck(false)
    classBtn._btn_Class_10:SetCheck(false)
    classBtn._btn_Class_11:SetCheck(false)
    classBtn._btn_Class_12:SetCheck(false)
    classBtn._btn_Class_13:SetCheck(false)
    classBtn._btn_Class_14:SetCheck(false)
    Panel_SkillGuide_ClassClicked(__eClassType_ElfRanger)
  elseif __eClassType_Sorcerer == myClassType then
    classBtn._btn_Class_2:SetCheck(true)
    classBtn._btn_Class_0:SetCheck(false)
    classBtn._btn_Class_1:SetCheck(false)
    classBtn._btn_Class_3:SetCheck(false)
    classBtn._btn_Class_4:SetCheck(false)
    classBtn._btn_Class_5:SetCheck(false)
    classBtn._btn_Class_6:SetCheck(false)
    classBtn._btn_Class_7:SetCheck(false)
    classBtn._btn_Class_8:SetCheck(false)
    classBtn._btn_Class_9:SetCheck(false)
    classBtn._btn_Class_10:SetCheck(false)
    classBtn._btn_Class_11:SetCheck(false)
    classBtn._btn_Class_12:SetCheck(false)
    classBtn._btn_Class_13:SetCheck(false)
    classBtn._btn_Class_14:SetCheck(false)
    Panel_SkillGuide_ClassClicked(__eClassType_Sorcerer)
  elseif __eClassType_Giant == myClassType then
    classBtn._btn_Class_3:SetCheck(true)
    classBtn._btn_Class_0:SetCheck(false)
    classBtn._btn_Class_1:SetCheck(false)
    classBtn._btn_Class_2:SetCheck(false)
    classBtn._btn_Class_4:SetCheck(false)
    classBtn._btn_Class_5:SetCheck(false)
    classBtn._btn_Class_6:SetCheck(false)
    classBtn._btn_Class_7:SetCheck(false)
    classBtn._btn_Class_8:SetCheck(false)
    classBtn._btn_Class_9:SetCheck(false)
    classBtn._btn_Class_10:SetCheck(false)
    classBtn._btn_Class_11:SetCheck(false)
    classBtn._btn_Class_12:SetCheck(false)
    classBtn._btn_Class_13:SetCheck(false)
    classBtn._btn_Class_14:SetCheck(false)
    Panel_SkillGuide_ClassClicked(__eClassType_Giant)
  elseif __eClassType_Tamer == myClassType then
    classBtn._btn_Class_4:SetCheck(true)
    classBtn._btn_Class_0:SetCheck(false)
    classBtn._btn_Class_1:SetCheck(false)
    classBtn._btn_Class_2:SetCheck(false)
    classBtn._btn_Class_3:SetCheck(false)
    classBtn._btn_Class_5:SetCheck(false)
    classBtn._btn_Class_6:SetCheck(false)
    classBtn._btn_Class_7:SetCheck(false)
    classBtn._btn_Class_8:SetCheck(false)
    classBtn._btn_Class_9:SetCheck(false)
    classBtn._btn_Class_10:SetCheck(false)
    classBtn._btn_Class_11:SetCheck(false)
    classBtn._btn_Class_12:SetCheck(false)
    classBtn._btn_Class_13:SetCheck(false)
    classBtn._btn_Class_14:SetCheck(false)
    Panel_SkillGuide_ClassClicked(__eClassType_Tamer)
  elseif __eClassType_BladeMaster == myClassType then
    classBtn._btn_Class_5:SetCheck(true)
    classBtn._btn_Class_0:SetCheck(false)
    classBtn._btn_Class_1:SetCheck(false)
    classBtn._btn_Class_2:SetCheck(false)
    classBtn._btn_Class_3:SetCheck(false)
    classBtn._btn_Class_4:SetCheck(false)
    classBtn._btn_Class_6:SetCheck(false)
    classBtn._btn_Class_7:SetCheck(false)
    classBtn._btn_Class_8:SetCheck(false)
    classBtn._btn_Class_9:SetCheck(false)
    classBtn._btn_Class_10:SetCheck(false)
    classBtn._btn_Class_11:SetCheck(false)
    classBtn._btn_Class_12:SetCheck(false)
    classBtn._btn_Class_13:SetCheck(false)
    classBtn._btn_Class_14:SetCheck(false)
    Panel_SkillGuide_ClassClicked(__eClassType_BladeMaster)
  elseif __eClassType_Valkyrie == myClassType then
    classBtn._btn_Class_6:SetCheck(true)
    classBtn._btn_Class_0:SetCheck(false)
    classBtn._btn_Class_1:SetCheck(false)
    classBtn._btn_Class_2:SetCheck(false)
    classBtn._btn_Class_3:SetCheck(false)
    classBtn._btn_Class_4:SetCheck(false)
    classBtn._btn_Class_5:SetCheck(false)
    classBtn._btn_Class_7:SetCheck(false)
    classBtn._btn_Class_8:SetCheck(false)
    classBtn._btn_Class_9:SetCheck(false)
    classBtn._btn_Class_10:SetCheck(false)
    classBtn._btn_Class_11:SetCheck(false)
    classBtn._btn_Class_12:SetCheck(false)
    classBtn._btn_Class_13:SetCheck(false)
    classBtn._btn_Class_14:SetCheck(false)
    Panel_SkillGuide_ClassClicked(__eClassType_Valkyrie)
  elseif __eClassType_BladeMasterWoman == myClassType then
    classBtn._btn_Class_7:SetCheck(true)
    classBtn._btn_Class_0:SetCheck(false)
    classBtn._btn_Class_1:SetCheck(false)
    classBtn._btn_Class_2:SetCheck(false)
    classBtn._btn_Class_3:SetCheck(false)
    classBtn._btn_Class_4:SetCheck(false)
    classBtn._btn_Class_5:SetCheck(false)
    classBtn._btn_Class_6:SetCheck(false)
    classBtn._btn_Class_8:SetCheck(false)
    classBtn._btn_Class_9:SetCheck(false)
    classBtn._btn_Class_10:SetCheck(false)
    classBtn._btn_Class_11:SetCheck(false)
    classBtn._btn_Class_12:SetCheck(false)
    classBtn._btn_Class_13:SetCheck(false)
    classBtn._btn_Class_14:SetCheck(false)
    Panel_SkillGuide_ClassClicked(__eClassType_BladeMasterWoman)
  elseif __eClassType_WizardMan == myClassType then
    classBtn._btn_Class_8:SetCheck(true)
    classBtn._btn_Class_0:SetCheck(false)
    classBtn._btn_Class_1:SetCheck(false)
    classBtn._btn_Class_2:SetCheck(false)
    classBtn._btn_Class_3:SetCheck(false)
    classBtn._btn_Class_4:SetCheck(false)
    classBtn._btn_Class_5:SetCheck(false)
    classBtn._btn_Class_6:SetCheck(false)
    classBtn._btn_Class_7:SetCheck(false)
    classBtn._btn_Class_9:SetCheck(false)
    classBtn._btn_Class_10:SetCheck(false)
    classBtn._btn_Class_11:SetCheck(false)
    classBtn._btn_Class_12:SetCheck(false)
    classBtn._btn_Class_13:SetCheck(false)
    classBtn._btn_Class_14:SetCheck(false)
    Panel_SkillGuide_ClassClicked(__eClassType_WizardMan)
  elseif __eClassType_WizardWoman == myClassType then
    classBtn._btn_Class_9:SetCheck(true)
    classBtn._btn_Class_0:SetCheck(false)
    classBtn._btn_Class_1:SetCheck(false)
    classBtn._btn_Class_2:SetCheck(false)
    classBtn._btn_Class_3:SetCheck(false)
    classBtn._btn_Class_4:SetCheck(false)
    classBtn._btn_Class_5:SetCheck(false)
    classBtn._btn_Class_6:SetCheck(false)
    classBtn._btn_Class_7:SetCheck(false)
    classBtn._btn_Class_8:SetCheck(false)
    classBtn._btn_Class_10:SetCheck(false)
    classBtn._btn_Class_11:SetCheck(false)
    classBtn._btn_Class_12:SetCheck(false)
    classBtn._btn_Class_13:SetCheck(false)
    classBtn._btn_Class_14:SetCheck(false)
    Panel_SkillGuide_ClassClicked(__eClassType_WizardWoman)
  elseif __eClassType_Kunoichi == myClassType then
    classBtn._btn_Class_10:SetCheck(true)
    classBtn._btn_Class_0:SetCheck(false)
    classBtn._btn_Class_1:SetCheck(false)
    classBtn._btn_Class_2:SetCheck(false)
    classBtn._btn_Class_3:SetCheck(false)
    classBtn._btn_Class_4:SetCheck(false)
    classBtn._btn_Class_5:SetCheck(false)
    classBtn._btn_Class_6:SetCheck(false)
    classBtn._btn_Class_7:SetCheck(false)
    classBtn._btn_Class_8:SetCheck(false)
    classBtn._btn_Class_9:SetCheck(false)
    classBtn._btn_Class_11:SetCheck(false)
    classBtn._btn_Class_12:SetCheck(false)
    classBtn._btn_Class_13:SetCheck(false)
    classBtn._btn_Class_14:SetCheck(false)
    Panel_SkillGuide_ClassClicked(__eClassType_Kunoichi)
  elseif __eClassType_NinjaMan == myClassType then
    classBtn._btn_Class_11:SetCheck(true)
    classBtn._btn_Class_0:SetCheck(false)
    classBtn._btn_Class_1:SetCheck(false)
    classBtn._btn_Class_2:SetCheck(false)
    classBtn._btn_Class_3:SetCheck(false)
    classBtn._btn_Class_4:SetCheck(false)
    classBtn._btn_Class_5:SetCheck(false)
    classBtn._btn_Class_6:SetCheck(false)
    classBtn._btn_Class_7:SetCheck(false)
    classBtn._btn_Class_8:SetCheck(false)
    classBtn._btn_Class_9:SetCheck(false)
    classBtn._btn_Class_10:SetCheck(false)
    classBtn._btn_Class_12:SetCheck(false)
    classBtn._btn_Class_13:SetCheck(false)
    classBtn._btn_Class_14:SetCheck(false)
    Panel_SkillGuide_ClassClicked(__eClassType_NinjaMan)
  elseif __eClassType_DarkElf == myClassType then
    classBtn._btn_Class_12:SetCheck(true)
    classBtn._btn_Class_0:SetCheck(false)
    classBtn._btn_Class_1:SetCheck(false)
    classBtn._btn_Class_2:SetCheck(false)
    classBtn._btn_Class_3:SetCheck(false)
    classBtn._btn_Class_4:SetCheck(false)
    classBtn._btn_Class_5:SetCheck(false)
    classBtn._btn_Class_6:SetCheck(false)
    classBtn._btn_Class_7:SetCheck(false)
    classBtn._btn_Class_8:SetCheck(false)
    classBtn._btn_Class_9:SetCheck(false)
    classBtn._btn_Class_10:SetCheck(false)
    classBtn._btn_Class_11:SetCheck(false)
    classBtn._btn_Class_13:SetCheck(false)
    classBtn._btn_Class_14:SetCheck(false)
    Panel_SkillGuide_ClassClicked(__eClassType_DarkElf)
  elseif __eClassType_Combattant == myClassType then
    classBtn._btn_Class_13:SetCheck(true)
    classBtn._btn_Class_0:SetCheck(false)
    classBtn._btn_Class_1:SetCheck(false)
    classBtn._btn_Class_2:SetCheck(false)
    classBtn._btn_Class_3:SetCheck(false)
    classBtn._btn_Class_4:SetCheck(false)
    classBtn._btn_Class_5:SetCheck(false)
    classBtn._btn_Class_6:SetCheck(false)
    classBtn._btn_Class_7:SetCheck(false)
    classBtn._btn_Class_8:SetCheck(false)
    classBtn._btn_Class_9:SetCheck(false)
    classBtn._btn_Class_10:SetCheck(false)
    classBtn._btn_Class_11:SetCheck(false)
    classBtn._btn_Class_12:SetCheck(false)
    classBtn._btn_Class_14:SetCheck(false)
    Panel_SkillGuide_ClassClicked(__eClassType_Combattant)
  elseif __eClassType_Mystic == myClassType then
    classBtn._btn_Class_14:SetCheck(true)
    classBtn._btn_Class_0:SetCheck(false)
    classBtn._btn_Class_1:SetCheck(false)
    classBtn._btn_Class_2:SetCheck(false)
    classBtn._btn_Class_3:SetCheck(false)
    classBtn._btn_Class_4:SetCheck(false)
    classBtn._btn_Class_5:SetCheck(false)
    classBtn._btn_Class_6:SetCheck(false)
    classBtn._btn_Class_7:SetCheck(false)
    classBtn._btn_Class_8:SetCheck(false)
    classBtn._btn_Class_9:SetCheck(false)
    classBtn._btn_Class_10:SetCheck(false)
    classBtn._btn_Class_11:SetCheck(false)
    classBtn._btn_Class_12:SetCheck(false)
    classBtn._btn_Class_13:SetCheck(false)
    Panel_SkillGuide_ClassClicked(__eClassType_Mystic)
  end
end
function Panel_SkillGuide_Update()
  if nil == getSelfPlayer() then
    return
  end
  local myClassType = getSelfPlayer():getClassType()
  local iconPosX = 15
  local iconPosY = 48
  if __eClassType_Warrior == myClassType then
    classBtn._btn_Class_0:SetCheck(true)
    classBtn._btn_Class_1:SetCheck(false)
    classBtn._btn_Class_2:SetCheck(false)
    classBtn._btn_Class_3:SetCheck(false)
    classBtn._btn_Class_4:SetCheck(false)
    classBtn._btn_Class_5:SetCheck(false)
    classBtn._btn_Class_6:SetCheck(false)
    classBtn._btn_Class_7:SetCheck(false)
    classBtn._btn_Class_8:SetCheck(false)
    classBtn._btn_Class_9:SetCheck(false)
    classBtn._btn_Class_10:SetCheck(false)
    classBtn._btn_Class_11:SetCheck(false)
    classBtn._btn_Class_12:SetCheck(false)
    classBtn._btn_Class_13:SetCheck(false)
    classBtn._btn_Class_14:SetCheck(false)
    Panel_SkillGuide_ClassClicked(__eClassType_Warrior)
  elseif __eClassType_ElfRanger == myClassType then
    classBtn._btn_Class_1:SetCheck(true)
    classBtn._btn_Class_0:SetCheck(false)
    classBtn._btn_Class_2:SetCheck(false)
    classBtn._btn_Class_3:SetCheck(false)
    classBtn._btn_Class_4:SetCheck(false)
    classBtn._btn_Class_5:SetCheck(false)
    classBtn._btn_Class_6:SetCheck(false)
    classBtn._btn_Class_7:SetCheck(false)
    classBtn._btn_Class_8:SetCheck(false)
    classBtn._btn_Class_9:SetCheck(false)
    classBtn._btn_Class_10:SetCheck(false)
    classBtn._btn_Class_11:SetCheck(false)
    classBtn._btn_Class_12:SetCheck(false)
    classBtn._btn_Class_13:SetCheck(false)
    classBtn._btn_Class_14:SetCheck(false)
    Panel_SkillGuide_ClassClicked(__eClassType_ElfRanger)
  elseif __eClassType_Sorcerer == myClassType then
    classBtn._btn_Class_2:SetCheck(true)
    classBtn._btn_Class_0:SetCheck(false)
    classBtn._btn_Class_1:SetCheck(false)
    classBtn._btn_Class_3:SetCheck(false)
    classBtn._btn_Class_4:SetCheck(false)
    classBtn._btn_Class_5:SetCheck(false)
    classBtn._btn_Class_6:SetCheck(false)
    classBtn._btn_Class_7:SetCheck(false)
    classBtn._btn_Class_8:SetCheck(false)
    classBtn._btn_Class_9:SetCheck(false)
    classBtn._btn_Class_10:SetCheck(false)
    classBtn._btn_Class_11:SetCheck(false)
    classBtn._btn_Class_12:SetCheck(false)
    classBtn._btn_Class_13:SetCheck(false)
    classBtn._btn_Class_14:SetCheck(false)
    Panel_SkillGuide_ClassClicked(__eClassType_Sorcerer)
  elseif __eClassType_Giant == myClassType then
    classBtn._btn_Class_3:SetCheck(true)
    classBtn._btn_Class_0:SetCheck(false)
    classBtn._btn_Class_1:SetCheck(false)
    classBtn._btn_Class_2:SetCheck(false)
    classBtn._btn_Class_4:SetCheck(false)
    classBtn._btn_Class_5:SetCheck(false)
    classBtn._btn_Class_6:SetCheck(false)
    classBtn._btn_Class_7:SetCheck(false)
    classBtn._btn_Class_8:SetCheck(false)
    classBtn._btn_Class_9:SetCheck(false)
    classBtn._btn_Class_10:SetCheck(false)
    classBtn._btn_Class_11:SetCheck(false)
    classBtn._btn_Class_12:SetCheck(false)
    classBtn._btn_Class_13:SetCheck(false)
    classBtn._btn_Class_14:SetCheck(false)
    Panel_SkillGuide_ClassClicked(__eClassType_Giant)
  elseif __eClassType_Tamer == myClassType then
    classBtn._btn_Class_4:SetCheck(true)
    classBtn._btn_Class_0:SetCheck(false)
    classBtn._btn_Class_1:SetCheck(false)
    classBtn._btn_Class_2:SetCheck(false)
    classBtn._btn_Class_3:SetCheck(false)
    classBtn._btn_Class_5:SetCheck(false)
    classBtn._btn_Class_6:SetCheck(false)
    classBtn._btn_Class_7:SetCheck(false)
    classBtn._btn_Class_8:SetCheck(false)
    classBtn._btn_Class_9:SetCheck(false)
    classBtn._btn_Class_10:SetCheck(false)
    classBtn._btn_Class_11:SetCheck(false)
    classBtn._btn_Class_12:SetCheck(false)
    classBtn._btn_Class_13:SetCheck(false)
    classBtn._btn_Class_14:SetCheck(false)
    Panel_SkillGuide_ClassClicked(__eClassType_Tamer)
  elseif __eClassType_BladeMaster == myClassType then
    classBtn._btn_Class_5:SetCheck(true)
    classBtn._btn_Class_0:SetCheck(false)
    classBtn._btn_Class_1:SetCheck(false)
    classBtn._btn_Class_2:SetCheck(false)
    classBtn._btn_Class_3:SetCheck(false)
    classBtn._btn_Class_4:SetCheck(false)
    classBtn._btn_Class_6:SetCheck(false)
    classBtn._btn_Class_7:SetCheck(false)
    classBtn._btn_Class_8:SetCheck(false)
    classBtn._btn_Class_9:SetCheck(false)
    classBtn._btn_Class_10:SetCheck(false)
    classBtn._btn_Class_11:SetCheck(false)
    classBtn._btn_Class_12:SetCheck(false)
    classBtn._btn_Class_13:SetCheck(false)
    classBtn._btn_Class_14:SetCheck(false)
    Panel_SkillGuide_ClassClicked(__eClassType_BladeMaster)
  elseif __eClassType_Valkyrie == myClassType then
    classBtn._btn_Class_6:SetCheck(true)
    classBtn._btn_Class_0:SetCheck(false)
    classBtn._btn_Class_1:SetCheck(false)
    classBtn._btn_Class_2:SetCheck(false)
    classBtn._btn_Class_3:SetCheck(false)
    classBtn._btn_Class_4:SetCheck(false)
    classBtn._btn_Class_5:SetCheck(false)
    classBtn._btn_Class_7:SetCheck(false)
    classBtn._btn_Class_8:SetCheck(false)
    classBtn._btn_Class_9:SetCheck(false)
    classBtn._btn_Class_10:SetCheck(false)
    classBtn._btn_Class_11:SetCheck(false)
    classBtn._btn_Class_12:SetCheck(false)
    classBtn._btn_Class_13:SetCheck(false)
    classBtn._btn_Class_14:SetCheck(false)
    Panel_SkillGuide_ClassClicked(__eClassType_Valkyrie)
  elseif __eClassType_BladeMasterWoman == myClassType then
    classBtn._btn_Class_7:SetCheck(true)
    classBtn._btn_Class_0:SetCheck(false)
    classBtn._btn_Class_1:SetCheck(false)
    classBtn._btn_Class_2:SetCheck(false)
    classBtn._btn_Class_3:SetCheck(false)
    classBtn._btn_Class_4:SetCheck(false)
    classBtn._btn_Class_5:SetCheck(false)
    classBtn._btn_Class_6:SetCheck(false)
    classBtn._btn_Class_8:SetCheck(false)
    classBtn._btn_Class_9:SetCheck(false)
    classBtn._btn_Class_10:SetCheck(false)
    classBtn._btn_Class_11:SetCheck(false)
    classBtn._btn_Class_12:SetCheck(false)
    classBtn._btn_Class_13:SetCheck(false)
    classBtn._btn_Class_14:SetCheck(false)
    Panel_SkillGuide_ClassClicked(__eClassType_BladeMasterWoman)
  elseif __eClassType_WizardMan == myClassType then
    classBtn._btn_Class_8:SetCheck(true)
    classBtn._btn_Class_0:SetCheck(false)
    classBtn._btn_Class_1:SetCheck(false)
    classBtn._btn_Class_2:SetCheck(false)
    classBtn._btn_Class_3:SetCheck(false)
    classBtn._btn_Class_4:SetCheck(false)
    classBtn._btn_Class_5:SetCheck(false)
    classBtn._btn_Class_6:SetCheck(false)
    classBtn._btn_Class_7:SetCheck(false)
    classBtn._btn_Class_9:SetCheck(false)
    classBtn._btn_Class_10:SetCheck(false)
    classBtn._btn_Class_11:SetCheck(false)
    classBtn._btn_Class_12:SetCheck(false)
    classBtn._btn_Class_13:SetCheck(false)
    classBtn._btn_Class_14:SetCheck(false)
    Panel_SkillGuide_ClassClicked(__eClassType_WizardMan)
  elseif __eClassType_WizardWoman == myClassType then
    classBtn._btn_Class_9:SetCheck(true)
    classBtn._btn_Class_0:SetCheck(false)
    classBtn._btn_Class_1:SetCheck(false)
    classBtn._btn_Class_2:SetCheck(false)
    classBtn._btn_Class_3:SetCheck(false)
    classBtn._btn_Class_4:SetCheck(false)
    classBtn._btn_Class_5:SetCheck(false)
    classBtn._btn_Class_6:SetCheck(false)
    classBtn._btn_Class_7:SetCheck(false)
    classBtn._btn_Class_8:SetCheck(false)
    classBtn._btn_Class_10:SetCheck(false)
    classBtn._btn_Class_11:SetCheck(false)
    classBtn._btn_Class_12:SetCheck(false)
    classBtn._btn_Class_13:SetCheck(false)
    classBtn._btn_Class_14:SetCheck(false)
    Panel_SkillGuide_ClassClicked(__eClassType_WizardWoman)
  elseif __eClassType_NinjaMan == myClassType then
    classBtn._btn_Class_11:SetCheck(true)
    classBtn._btn_Class_0:SetCheck(false)
    classBtn._btn_Class_1:SetCheck(false)
    classBtn._btn_Class_2:SetCheck(false)
    classBtn._btn_Class_3:SetCheck(false)
    classBtn._btn_Class_4:SetCheck(false)
    classBtn._btn_Class_5:SetCheck(false)
    classBtn._btn_Class_6:SetCheck(false)
    classBtn._btn_Class_7:SetCheck(false)
    classBtn._btn_Class_8:SetCheck(false)
    classBtn._btn_Class_9:SetCheck(false)
    classBtn._btn_Class_10:SetCheck(false)
    classBtn._btn_Class_12:SetCheck(false)
    classBtn._btn_Class_13:SetCheck(false)
    classBtn._btn_Class_14:SetCheck(false)
    Panel_SkillGuide_ClassClicked(__eClassType_NinjaMan)
  elseif __eClassType_DarkElf == myClassType then
    classBtn._btn_Class_12:SetCheck(true)
    classBtn._btn_Class_0:SetCheck(false)
    classBtn._btn_Class_1:SetCheck(false)
    classBtn._btn_Class_2:SetCheck(false)
    classBtn._btn_Class_3:SetCheck(false)
    classBtn._btn_Class_4:SetCheck(false)
    classBtn._btn_Class_5:SetCheck(false)
    classBtn._btn_Class_6:SetCheck(false)
    classBtn._btn_Class_7:SetCheck(false)
    classBtn._btn_Class_8:SetCheck(false)
    classBtn._btn_Class_9:SetCheck(false)
    classBtn._btn_Class_10:SetCheck(false)
    classBtn._btn_Class_11:SetCheck(false)
    classBtn._btn_Class_13:SetCheck(false)
    classBtn._btn_Class_14:SetCheck(false)
    Panel_SkillGuide_ClassClicked(__eClassType_DarkElf)
  elseif __eClassType_Combattant == myClassType then
    classBtn._btn_Class_13:SetCheck(true)
    classBtn._btn_Class_0:SetCheck(false)
    classBtn._btn_Class_1:SetCheck(false)
    classBtn._btn_Class_2:SetCheck(false)
    classBtn._btn_Class_3:SetCheck(false)
    classBtn._btn_Class_4:SetCheck(false)
    classBtn._btn_Class_5:SetCheck(false)
    classBtn._btn_Class_6:SetCheck(false)
    classBtn._btn_Class_7:SetCheck(false)
    classBtn._btn_Class_8:SetCheck(false)
    classBtn._btn_Class_9:SetCheck(false)
    classBtn._btn_Class_10:SetCheck(false)
    classBtn._btn_Class_11:SetCheck(false)
    classBtn._btn_Class_12:SetCheck(false)
    classBtn._btn_Class_14:SetCheck(false)
    Panel_SkillGuide_ClassClicked(__eClassType_Combattant)
  elseif __eClassType_Mystic == myClassType then
    classBtn._btn_Class_14:SetCheck(true)
    classBtn._btn_Class_0:SetCheck(false)
    classBtn._btn_Class_1:SetCheck(false)
    classBtn._btn_Class_2:SetCheck(false)
    classBtn._btn_Class_3:SetCheck(false)
    classBtn._btn_Class_4:SetCheck(false)
    classBtn._btn_Class_5:SetCheck(false)
    classBtn._btn_Class_6:SetCheck(false)
    classBtn._btn_Class_7:SetCheck(false)
    classBtn._btn_Class_8:SetCheck(false)
    classBtn._btn_Class_9:SetCheck(false)
    classBtn._btn_Class_10:SetCheck(false)
    classBtn._btn_Class_11:SetCheck(false)
    classBtn._btn_Class_12:SetCheck(false)
    classBtn._btn_Class_13:SetCheck(false)
    Panel_SkillGuide_ClassClicked(__eClassType_Mystic)
  end
  if classBtn._btn_Class_0:GetShow() then
    classBtn._btn_Class_0:SetPosX(iconPosX)
    classBtn._btn_Class_0:SetPosY(iconPosY)
    iconPosX = iconPosX + classBtn._btn_Class_0:GetSizeX() + 5
  end
  if classBtn._btn_Class_1:GetShow() then
    classBtn._btn_Class_1:SetPosX(iconPosX)
    classBtn._btn_Class_1:SetPosY(iconPosY)
    iconPosX = iconPosX + classBtn._btn_Class_1:GetSizeX() + 5
  end
  if classBtn._btn_Class_2:GetShow() then
    classBtn._btn_Class_2:SetPosX(iconPosX)
    classBtn._btn_Class_2:SetPosY(iconPosY)
    iconPosX = iconPosX + classBtn._btn_Class_2:GetSizeX() + 5
  end
  if classBtn._btn_Class_3:GetShow() then
    classBtn._btn_Class_3:SetPosX(iconPosX)
    classBtn._btn_Class_3:SetPosY(iconPosY)
    iconPosX = iconPosX + classBtn._btn_Class_3:GetSizeX() + 5
  end
  if classBtn._btn_Class_4:GetShow() then
    classBtn._btn_Class_4:SetPosX(iconPosX)
    classBtn._btn_Class_4:SetPosY(iconPosY)
    iconPosX = iconPosX + classBtn._btn_Class_4:GetSizeX() + 5
  end
  if classBtn._btn_Class_5:GetShow() then
    classBtn._btn_Class_5:SetPosX(iconPosX)
    classBtn._btn_Class_5:SetPosY(iconPosY)
    iconPosX = iconPosX + classBtn._btn_Class_5:GetSizeX() + 5
  end
  if classBtn._btn_Class_6:GetShow() then
    classBtn._btn_Class_6:SetPosX(iconPosX)
    classBtn._btn_Class_6:SetPosY(iconPosY)
    iconPosX = iconPosX + classBtn._btn_Class_6:GetSizeX() + 5
  end
  if classBtn._btn_Class_7:GetShow() then
    classBtn._btn_Class_7:SetPosX(iconPosX)
    classBtn._btn_Class_7:SetPosY(iconPosY)
    iconPosX = iconPosX + classBtn._btn_Class_7:GetSizeX() + 5
  end
  if classBtn._btn_Class_8:GetShow() then
    classBtn._btn_Class_8:SetPosX(iconPosX)
    classBtn._btn_Class_8:SetPosY(iconPosY)
    iconPosX = iconPosX + classBtn._btn_Class_8:GetSizeX() + 5
  end
  if classBtn._btn_Class_9:GetShow() then
    classBtn._btn_Class_9:SetPosX(iconPosX)
    classBtn._btn_Class_9:SetPosY(iconPosY)
    iconPosX = iconPosX + classBtn._btn_Class_9:GetSizeX() + 5
  end
  if classBtn._btn_Class_10:GetShow() then
    classBtn._btn_Class_10:SetPosX(iconPosX)
    classBtn._btn_Class_10:SetPosY(iconPosY)
    iconPosX = iconPosX + classBtn._btn_Class_10:GetSizeX() + 5
  end
  if classBtn._btn_Class_11:GetShow() then
    classBtn._btn_Class_11:SetPosX(iconPosX)
    classBtn._btn_Class_11:SetPosY(iconPosY)
    iconPosX = iconPosX + classBtn._btn_Class_11:GetSizeX() + 5
  end
  if classBtn._btn_Class_12:GetShow() then
    classBtn._btn_Class_12:SetPosX(iconPosX)
    classBtn._btn_Class_12:SetPosY(iconPosY)
    iconPosX = iconPosX + classBtn._btn_Class_12:GetSizeX() + 5
  end
  if classBtn._btn_Class_13:GetShow() then
    classBtn._btn_Class_13:SetPosX(iconPosX)
    classBtn._btn_Class_13:SetPosY(iconPosY)
    iconPosX = iconPosX + classBtn._btn_Class_13:GetSizeX() + 5
  end
  if classBtn._btn_Class_14:GetShow() then
    classBtn._btn_Class_14:SetPosX(iconPosX)
    classBtn._btn_Class_14:SetPosY(iconPosY)
    iconPosX = iconPosX + classBtn._btn_Class_14:GetSizeX() + 5
  end
end
function Panel_SkillGuide_ScrollEventFunc(UpDown)
  if UpDown then
    classType[currentSelectedClass]._currentPos = classType[currentSelectedClass]._currentPos - 1
    if classType[currentSelectedClass]._currentPos < 0 then
      classType[currentSelectedClass]._currentPos = 0
    end
  else
    classType[currentSelectedClass]._currentPos = classType[currentSelectedClass]._currentPos + 1
    if classType[currentSelectedClass]._currentPos > classType[currentSelectedClass]._interval then
      classType[currentSelectedClass]._currentPos = classType[currentSelectedClass]._interval
    end
  end
  ui._verticalScroll:SetControlPos(classType[currentSelectedClass]._currentPos / classType[currentSelectedClass]._interval)
  SetClassMovieInfo(currentSelectedClass)
end
function SetClassMovieInfo(classNo)
  for index = 0, maxCount - 1 do
    skillMovieList[index]._bg:SetShow(false)
  end
  local sizeY = ui._mainListBox:GetSizeY()
  local itemSizeY = skillMovieList[0]._bg:GetSizeY()
  local visibleItemCount = math.floor(sizeY / itemSizeY) - 1
  for index = 0, maxCount - 1 do
    if index > classType[classNo]._maxMovieCount then
      break
    end
    local movieindex = index + classType[classNo]._currentPos
    if classNo == 0 then
      if isGameTypeTaiwan() then
        skillMovieList[index]._bg:SetText(PAGetStringParam2(Defines.StringSheet_GAME, "LUA_SKILLGUIDE_SKILLGUIDEMOVIE", "name", classType[classNo]._name, "index", difficultyDesc_Warrior_TW[index]))
      else
        skillMovieList[index]._bg:SetText(PAGetStringParam2(Defines.StringSheet_GAME, "LUA_SKILLGUIDE_SKILLGUIDEMOVIE", "name", classType[classNo]._name, "index", difficultyDesc_Warrior[index]))
      end
    elseif classNo == 4 then
      if isGameTypeTaiwan() then
        skillMovieList[index]._bg:SetText(PAGetStringParam2(Defines.StringSheet_GAME, "LUA_SKILLGUIDE_SKILLGUIDEMOVIE", "name", classType[classNo]._name, "index", difficultyDesc_Ranger_TW[index]))
      else
        skillMovieList[index]._bg:SetText(PAGetStringParam2(Defines.StringSheet_GAME, "LUA_SKILLGUIDE_SKILLGUIDEMOVIE", "name", classType[classNo]._name, "index", difficultyDesc_Ranger[index]))
      end
    elseif classNo == 8 then
      if isGameTypeTaiwan() then
        skillMovieList[index]._bg:SetText(PAGetStringParam2(Defines.StringSheet_GAME, "LUA_SKILLGUIDE_SKILLGUIDEMOVIE", "name", classType[classNo]._name, "index", difficultyDesc_Sorcer_TW[index]))
      else
        skillMovieList[index]._bg:SetText(PAGetStringParam2(Defines.StringSheet_GAME, "LUA_SKILLGUIDE_SKILLGUIDEMOVIE", "name", classType[classNo]._name, "index", difficultyDesc_Sorcer[index]))
      end
    elseif classNo == 12 then
      if isGameTypeTaiwan() then
        skillMovieList[index]._bg:SetText(PAGetStringParam2(Defines.StringSheet_GAME, "LUA_SKILLGUIDE_SKILLGUIDEMOVIE", "name", classType[classNo]._name, "index", difficultyDesc_Giant_TW[index]))
      else
        skillMovieList[index]._bg:SetText(PAGetStringParam2(Defines.StringSheet_GAME, "LUA_SKILLGUIDE_SKILLGUIDEMOVIE", "name", classType[classNo]._name, "index", difficultyDesc_Giant[index]))
      end
    elseif classNo == 16 then
      if isGameTypeTaiwan() then
        skillMovieList[index]._bg:SetText(PAGetStringParam2(Defines.StringSheet_GAME, "LUA_SKILLGUIDE_SKILLGUIDEMOVIE", "name", classType[classNo]._name, "index", difficultyDesc_Tamer_TW[index]))
      else
        skillMovieList[index]._bg:SetText(PAGetStringParam2(Defines.StringSheet_GAME, "LUA_SKILLGUIDE_SKILLGUIDEMOVIE", "name", classType[classNo]._name, "index", difficultyDesc_Tamer[index]))
      end
    elseif classNo == 19 then
      if isGameTypeTaiwan() then
        skillMovieList[index]._bg:SetText(PAGetStringParam2(Defines.StringSheet_GAME, "LUA_SKILLGUIDE_SKILLGUIDEMOVIE", "name", classType[classNo]._name, "index", difficultyDesc_Combattant_TW[index]))
      else
        skillMovieList[index]._bg:SetText(PAGetStringParam2(Defines.StringSheet_GAME, "LUA_SKILLGUIDE_SKILLGUIDEMOVIE", "name", classType[classNo]._name, "index", difficultyDesc_Combattant[index]))
      end
    elseif classNo == 20 then
      if isGameTypeTaiwan() then
        skillMovieList[index]._bg:SetText(PAGetStringParam2(Defines.StringSheet_GAME, "LUA_SKILLGUIDE_SKILLGUIDEMOVIE", "name", classType[classNo]._name, "index", difficultyDesc_BladeMaster_TW[index]))
      else
        skillMovieList[index]._bg:SetText(PAGetStringParam2(Defines.StringSheet_GAME, "LUA_SKILLGUIDE_SKILLGUIDEMOVIE", "name", classType[classNo]._name, "index", difficultyDesc_BladeMaster[index]))
      end
    elseif classNo == 21 then
      if isGameTypeTaiwan() then
        skillMovieList[index]._bg:SetText(PAGetStringParam2(Defines.StringSheet_GAME, "LUA_SKILLGUIDE_SKILLGUIDEMOVIE", "name", classType[classNo]._name, "index", difficultyDesc_BladeMasterWomen_TW[index]))
      else
        skillMovieList[index]._bg:SetText(PAGetStringParam2(Defines.StringSheet_GAME, "LUA_SKILLGUIDE_SKILLGUIDEMOVIE", "name", classType[classNo]._name, "index", difficultyDesc_BladeMasterWomen[index]))
      end
    elseif classNo == 23 then
      if isGameTypeTaiwan() then
        skillMovieList[index]._bg:SetText(PAGetStringParam2(Defines.StringSheet_GAME, "LUA_SKILLGUIDE_SKILLGUIDEMOVIE", "name", classType[classNo]._name, "index", difficultyDesc_Combattant_TW[index]))
      else
        skillMovieList[index]._bg:SetText(PAGetStringParam2(Defines.StringSheet_GAME, "LUA_SKILLGUIDE_SKILLGUIDEMOVIE", "name", classType[classNo]._name, "index", difficultyDesc_Combattant[index]))
      end
    elseif classNo == 24 then
      if isGameTypeTaiwan() then
        skillMovieList[index]._bg:SetText(PAGetStringParam2(Defines.StringSheet_GAME, "LUA_SKILLGUIDE_SKILLGUIDEMOVIE", "name", classType[classNo]._name, "index", difficultyDesc_Valkyrie_TW[index]))
      else
        skillMovieList[index]._bg:SetText(PAGetStringParam2(Defines.StringSheet_GAME, "LUA_SKILLGUIDE_SKILLGUIDEMOVIE", "name", classType[classNo]._name, "index", difficultyDesc_Valkyrie[index]))
      end
    elseif classNo == 25 then
      if isGameTypeTaiwan() then
        skillMovieList[index]._bg:SetText(PAGetStringParam2(Defines.StringSheet_GAME, "LUA_SKILLGUIDE_SKILLGUIDEMOVIE", "name", classType[classNo]._name, "index", difficultyDesc_NinjaWomen_TW[index]))
      else
        skillMovieList[index]._bg:SetText(PAGetStringParam2(Defines.StringSheet_GAME, "LUA_SKILLGUIDE_SKILLGUIDEMOVIE", "name", classType[classNo]._name, "index", difficultyDesc_NinjaWomen[index]))
      end
    elseif classNo == 26 then
      if isGameTypeTaiwan() then
        skillMovieList[index]._bg:SetText(PAGetStringParam2(Defines.StringSheet_GAME, "LUA_SKILLGUIDE_SKILLGUIDEMOVIE", "name", classType[classNo]._name, "index", difficultyDesc_NinjaMan_TW[index]))
      else
        skillMovieList[index]._bg:SetText(PAGetStringParam2(Defines.StringSheet_GAME, "LUA_SKILLGUIDE_SKILLGUIDEMOVIE", "name", classType[classNo]._name, "index", difficultyDesc_NinjaMan[index]))
      end
    elseif classNo == 27 then
      if isGameTypeTaiwan() then
        skillMovieList[index]._bg:SetText(PAGetStringParam2(Defines.StringSheet_GAME, "LUA_SKILLGUIDE_SKILLGUIDEMOVIE", "name", classType[classNo]._name, "index", difficultyDesc_Darkelf_TW[index]))
      else
        skillMovieList[index]._bg:SetText(PAGetStringParam2(Defines.StringSheet_GAME, "LUA_SKILLGUIDE_SKILLGUIDEMOVIE", "name", classType[classNo]._name, "index", difficultyDesc_Darkelf[index]))
      end
    elseif classNo == 28 then
      if isGameTypeTaiwan() then
        skillMovieList[index]._bg:SetText(PAGetStringParam2(Defines.StringSheet_GAME, "LUA_SKILLGUIDE_SKILLGUIDEMOVIE", "name", classType[classNo]._name, "index", difficultyDesc_Wizard_TW[index]))
      else
        skillMovieList[index]._bg:SetText(PAGetStringParam2(Defines.StringSheet_GAME, "LUA_SKILLGUIDE_SKILLGUIDEMOVIE", "name", classType[classNo]._name, "index", difficultyDesc_Wizard[index]))
      end
    elseif classNo == 31 then
      if isGameTypeTaiwan() then
        skillMovieList[index]._bg:SetText(PAGetStringParam2(Defines.StringSheet_GAME, "LUA_SKILLGUIDE_SKILLGUIDEMOVIE", "name", classType[classNo]._name, "index", difficultyDesc_WizardWomen_TW[index]))
      else
        skillMovieList[index]._bg:SetText(PAGetStringParam2(Defines.StringSheet_GAME, "LUA_SKILLGUIDE_SKILLGUIDEMOVIE", "name", classType[classNo]._name, "index", difficultyDesc_WizardWomen[index]))
      end
    end
    skillMovieList[index]._btn:addInputEvent("Mouse_LUp", "Panel_MovieTheaterSkillGuide640_ShowToggle(" .. classNo .. ", " .. movieindex .. ")")
    if index >= visibleItemCount then
      skillMovieList[index]._bg:SetShow(false)
      skillMovieList[index]._btn:SetShow(false)
    else
      skillMovieList[index]._bg:SetShow(true)
      skillMovieList[index]._btn:SetShow(true)
    end
  end
end
function Panel_SkillGuide_ClassClicked(classNo)
  currentSelectedClass = classNo
  for _, v in pairs(classBtn) do
    v:ResetVertexAni()
  end
  local player = getSelfPlayer()
  if nil == player then
    return
  end
  classType[classNo]._currentPos = 0
  SetClassMovieInfo(classNo)
  local sizeY = ui._mainListBox:GetSizeY()
  ui._verticalScroll:SetShow(false)
  if maxCount < classType[classNo]._maxMovieCount then
    classType[classNo]._interval = classType[classNo]._maxMovieCount - maxCount
    ui._verticalScroll:SetShow(true)
    ui._verticalScroll:SetInterval(classType[classNo]._maxMovieCount - maxCount)
    ui._verticalScroll:SetControlPos(0)
    _btn_ScrollBtn:SetSize(_btn_ScrollBtn:GetSizeX(), sizeY / (classType[classNo]._interval + 1))
  end
end
function Panel_SkillGuide_Tooltip(isShow, classType)
  local name, desc, control
  if __eClassType_Warrior == classType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_GLOBAL_CLASSTYPE_WARRIOR")
    control = classBtn._btn_Class_0
  elseif __eClassType_ElfRanger == classType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_GLOBAL_CLASSTYPE_RANGER")
    control = classBtn._btn_Class_1
  elseif __eClassType_Sorcerer == classType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_GLOBAL_CLASSTYPE_SORCERER")
    control = classBtn._btn_Class_2
  elseif __eClassType_Giant == classType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_GLOBAL_CLASSTYPE_GIANT")
    control = classBtn._btn_Class_3
  elseif __eClassType_Tamer == classType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_GLOBAL_CLASSTYPE_TAMER")
    control = classBtn._btn_Class_4
  elseif __eClassType_BladeMaster == classType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_GLOBAL_CLASSTYPE_BLADEMASTER")
    control = classBtn._btn_Class_5
  elseif __eClassType_Valkyrie == classType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_GLOBAL_CLASSTYPE_VALKYRIE")
    control = classBtn._btn_Class_6
  elseif __eClassType_BladeMasterWoman == classType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_GLOBAL_CLASSTYPE_BLADEMASTERWOMAN")
    control = classBtn._btn_Class_7
  elseif __eClassType_WizardMan == classType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_GLOBAL_CLASSTYPE_WIZARD")
    control = classBtn._btn_Class_8
  elseif __eClassType_WizardWoman == classType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_GLOBAL_CLASSTYPE_WIZARDWOMAN")
    control = classBtn._btn_Class_9
  elseif __eClassType_Kunoichi == classType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_GLOBAL_CLASSTYPE_NINJAWOMEN")
    control = classBtn._btn_Class_10
  elseif __eClassType_NinjaMan == classType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_GLOBAL_CLASSTYPE_NINJAMAN")
    control = classBtn._btn_Class_11
  elseif __eClassType_DarkElf == classType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_GLOBAL_CLASSTYPE_DARKELF")
    control = classBtn._btn_Class_12
  elseif __eClassType_Combattant == classType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_GLOBAL_CLASSTYPE_STRIKER")
    control = classBtn._btn_Class_13
  elseif __eClassType_Mystic == classType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_GLOBAL_CLASSTYPE_COMBATTANTWOMEN")
    control = classBtn._btn_Class_14
  end
  if isShow == true then
    TooltipSimple_Show(control, name, desc)
  else
    TooltipSimple_Hide()
  end
end
Panel_Window_SkillGuide_Initialize()
function Panel_Window_SkillGuide_Close()
  Panel_Window_SkillGuide:SetShow(false, true)
  FGlobal_Panel_MovieTheater_SkillGuide_640_UrlReset()
  Panel_MovieTheater_SkillGuide_640_JustClose()
end
function Panel_Window_SkillGuide_ShowToggle()
  local isShow = Panel_Window_SkillGuide:IsShow()
  if isShow == true then
    Panel_Window_SkillGuide_Close()
  else
    Panel_Window_SkillGuide:SetShow(true, true)
    Panel_MovieTheater_SkillGuide_640_Initialize()
    Panel_MovieTheater640_WindowClose()
    Panel_SkillGuide_Update()
  end
end
