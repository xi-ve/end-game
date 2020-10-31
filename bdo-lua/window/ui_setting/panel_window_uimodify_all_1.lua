function PaGlobal_UIModify:initialize()
  if true == PaGlobal_UIModify._initialize then
    return
  end
  self._ui.panelBG = UI.getChildControl(Panel_Window_UIModify_All, "Static_PanelBG")
  self._ui.titleBG = UI.getChildControl(Panel_Window_UIModify_All, "Static_TitleArea")
  self._ui.chk_Collapse = UI.getChildControl(self._ui.titleBG, "CheckButton_Collapse")
  self._ui.btn_win_close = UI.getChildControl(self._ui.titleBG, "Button_Win_Close")
  self._ui.balckBG = UI.getChildControl(Panel_Window_UIModify_All, "Static_BlackBG")
  self._ui.grid_BG = UI.getChildControl(Panel_Window_UIModify_All, "Static_Grid")
  self._ui.main_BG = UI.getChildControl(Panel_Window_UIModify_All, "Static_MainBG")
  self._ui.btn_UIFreeSet1 = UI.getChildControl(self._ui.main_BG, "Button_Preset1")
  self._ui.btn_UIFreeSet2 = UI.getChildControl(self._ui.main_BG, "Button_Preset2")
  self._ui.btn_UIFreeSet3 = UI.getChildControl(self._ui.main_BG, "Button_Preset3")
  self._ui.btn_CleanMode = UI.getChildControl(self._ui.main_BG, "Button_CleanMode")
  self._ui.btn_RevertMod = UI.getChildControl(self._ui.main_BG, "Button_ReturnClean")
  self._ui.sub_BG = UI.getChildControl(Panel_Window_UIModify_All, "Static_SubBG")
  self._ui.txt_UISize = UI.getChildControl(self._ui.sub_BG, "StaticText_SubTitle")
  self._ui.txt_UI_LOW = UI.getChildControl(self._ui.sub_BG, "StaticText_UI_LOW")
  self._ui.txt_UI_HIGH = UI.getChildControl(self._ui.sub_BG, "StaticText_UI_HIGH")
  self._ui.slider_UI_Scale = UI.getChildControl(self._ui.sub_BG, "Slider_UI_Scaling")
  self._ui.btn_Scale = UI.getChildControl(self._ui.slider_UI_Scale, "Slider_UI_Scaling_Button")
  self._ui.chk_remsaterUI = UI.getChildControl(self._ui.sub_BG, "CheckButton_HP")
  self._ui.chk_FieldView = UI.getChildControl(self._ui.sub_BG, "CheckButton_CameraPosition")
  self._ui.chk_QuickSlotMagnetic = UI.getChildControl(self._ui.sub_BG, "CheckButton_QuickSlotMagnet")
  self._ui.chk_GridView = UI.getChildControl(self._ui.sub_BG, "CheckButton_Grid")
  self._ui.desc_BG = UI.getChildControl(Panel_Window_UIModify_All, "Static_BottomDescBG")
  self._ui.txt_Desc = UI.getChildControl(self._ui.desc_BG, "StaticText_1")
  self._ui.btn_save = UI.getChildControl(Panel_Window_UIModify_All, "Button_Save")
  self._ui.btn_reset = UI.getChildControl(Panel_Window_UIModify_All, "Button_Reset")
  self._ui.chk_FieldView:SetEnableArea(0, 0, self._ui.chk_FieldView:GetTextSizeX() + 25, self._ui.chk_FieldView:GetSizeY())
  self._ui.chk_QuickSlotMagnetic:SetEnableArea(0, 0, self._ui.chk_QuickSlotMagnetic:GetTextSizeX() + 25, self._ui.chk_QuickSlotMagnetic:GetSizeY())
  self._ui.chk_GridView:SetEnableArea(0, 0, self._ui.chk_GridView:GetTextSizeX() + 25, self._ui.chk_GridView:GetSizeY())
  self._ui.chk_remsaterUI:SetEnableArea(0, 0, self._ui.chk_remsaterUI:GetTextSizeX() + 25, self._ui.chk_remsaterUI:GetSizeY())
  self._ui.txt_Desc:SetTextMode(__eTextMode_AutoWrap)
  self._ui.txt_Desc:SetText(self._ui.txt_Desc:GetText())
  self:updateModifyPanelSize()
  self._uiSave.txt_Desc = UI.getChildControl(Panel_Window_SavePreset_All, "StaticText_Desc")
  self._uiSave.btn_SaveClose = UI.getChildControl(Panel_Window_SavePreset_All, "Button_Win_Close")
  self._uiSave.btn_SaveDefault = UI.getChildControl(Panel_Window_SavePreset_All, "Button_DefaultUI")
  self._uiSave.btn_SaveUI1 = UI.getChildControl(Panel_Window_SavePreset_All, "Button_UI1")
  self._uiSave.btn_SaveUI2 = UI.getChildControl(Panel_Window_SavePreset_All, "Button_UI2")
  self._uiSave.btn_SaveUI3 = UI.getChildControl(Panel_Window_SavePreset_All, "Button_UI3")
  self._uiSave.bg_Block = UI.getChildControl(Panel_Window_SavePreset_All, "Static_Block")
  self._uiSave.txt_Desc:SetTextMode(__eTextMode_AutoWrap)
  self._uiSave.txt_Desc:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_SAVEFREESET_DESC"))
  local panelControl = self._panelControl
  local panelID = self._panelID
  self._swapPanelList[0] = panelID.ExpGage
  self._swapPanelList[1] = panelID.Pvp
  self._swapPanelList[2] = panelID.Adrenallin
  self._swapPanelList[3] = panelID.HPBar
  self._swapPanelList[4] = panelID.MainStatusRemaster
  self._swapPanelList[5] = panelID.ClassResource
  panelControl[panelID.ExpGage] = {
    control = Panel_SelfPlayerExpGage,
    showFixed = false,
    posFixed = true,
    isChange = false,
    PAGameUIType = CppEnums.PAGameUIType.PAGameUIPanel_SelfPlayer_ExpGage,
    prePos = {x = 0, y = 0},
    name = PAGetString(Defines.StringSheet_GAME, "LUA_PANELCONTROL_1"),
    isShow = true
  }
  panelControl[panelID.ServantIcon] = {
    control = Panel_Window_Servant,
    showFixed = false,
    posFixed = false,
    isChange = false,
    PAGameUIType = CppEnums.PAGameUIType.PAGameUIPanel_ServantWindow,
    prePos = {x = 0, y = 0},
    name = PAGetString(Defines.StringSheet_GAME, "LUA_PANELCONTROL_2"),
    isShow = true
  }
  panelControl[panelID.Radar] = {
    control = Panel_Radar,
    showFixed = false,
    posFixed = true,
    isChange = false,
    PAGameUIType = CppEnums.PAGameUIType.PAGameUIPanel_RadarMap,
    prePos = {x = 0, y = 0},
    name = PAGetString(Defines.StringSheet_GAME, "LUA_PANELCONTROL_3"),
    isShow = true
  }
  panelControl[panelID.Quest] = {
    control = Panel_CheckedQuest,
    showFixed = false,
    posFixed = false,
    isChange = false,
    PAGameUIType = CppEnums.PAGameUIType.PAGameUIPanel_CheckedQuest,
    prePos = {x = 0, y = 0},
    name = PAGetString(Defines.StringSheet_GAME, "LUA_PANELCONTROL_4"),
    isShow = true
  }
  panelControl[panelID.Chat0] = {
    control = Panel_Chat0,
    showFixed = false,
    posFixed = false,
    isChange = false,
    PAGameUIType = CppEnums.PAGameUIType.PAGameUIPanel_ChattingWindow,
    prePos = {x = 0, y = 0},
    name = PAGetString(Defines.StringSheet_GAME, "LUA_PANELCONTROL_5"),
    isShow = true
  }
  panelControl[panelID.Chat1] = {
    control = Panel_Chat1,
    showFixed = false,
    posFixed = false,
    isChange = false,
    PAGameUIType = CppEnums.PAGameUIType.PAGameUIPanel_ChattingWindow,
    prePos = {x = 0, y = 0},
    name = PAGetString(Defines.StringSheet_GAME, "LUA_PANELCONTROL_6"),
    isShow = false
  }
  panelControl[panelID.Chat2] = {
    control = Panel_Chat2,
    showFixed = false,
    posFixed = false,
    isChange = false,
    PAGameUIType = CppEnums.PAGameUIType.PAGameUIPanel_ChattingWindow,
    prePos = {x = 0, y = 0},
    name = PAGetString(Defines.StringSheet_GAME, "LUA_PANELCONTROL_7"),
    isShow = false
  }
  panelControl[panelID.Chat3] = {
    control = Panel_Chat3,
    showFixed = false,
    posFixed = false,
    isChange = false,
    PAGameUIType = CppEnums.PAGameUIType.PAGameUIPanel_ChattingWindow,
    prePos = {x = 0, y = 0},
    name = PAGetString(Defines.StringSheet_GAME, "LUA_PANELCONTROL_8"),
    isShow = false
  }
  panelControl[panelID.Chat4] = {
    control = Panel_Chat4,
    showFixed = false,
    posFixed = false,
    isChange = false,
    PAGameUIType = CppEnums.PAGameUIType.PAGameUIPanel_ChattingWindow,
    prePos = {x = 0, y = 0},
    name = PAGetString(Defines.StringSheet_GAME, "LUA_PANELCONTROL_9"),
    isShow = false
  }
  panelControl[panelID.GameTip] = {
    control = Panel_GameTips,
    showFixed = false,
    posFixed = true,
    isChange = false,
    PAGameUIType = CppEnums.PAGameUIType.PAGameUIPanel_GameTips,
    prePos = {x = 0, y = 0},
    name = PAGetString(Defines.StringSheet_GAME, "LUA_PANELCONTROL_10"),
    isShow = true
  }
  panelControl[panelID.QuickSlot] = {
    control = Panel_QuickSlot,
    showFixed = false,
    posFixed = false,
    isChange = false,
    PAGameUIType = CppEnums.PAGameUIType.PAGameUIPanel_QuickSlot,
    prePos = {x = 0, y = 0},
    name = PAGetString(Defines.StringSheet_GAME, "LUA_PANELCONTROL_11"),
    isShow = true
  }
  panelControl[panelID.HPBar] = {
    control = Panel_MainStatus_User_Bar,
    showFixed = false,
    posFixed = false,
    isChange = false,
    PAGameUIType = CppEnums.PAGameUIType.PAGameUIPanel_MainStatusBar,
    prePos = {x = 0, y = 0},
    name = PAGetString(Defines.StringSheet_GAME, "LUA_PANELCONTROL_12"),
    isShow = false
  }
  panelControl[panelID.Pvp] = {
    control = Panel_PvpMode,
    showFixed = false,
    posFixed = false,
    isChange = false,
    PAGameUIType = CppEnums.PAGameUIType.PAGameUIPanel_PvpMode,
    prePos = {x = 0, y = 0},
    name = PAGetString(Defines.StringSheet_GAME, "LUA_PANELCONTROL_13"),
    isShow = true
  }
  panelControl[panelID.ClassResource] = {
    control = Panel_ClassResource,
    showFixed = false,
    posFixed = false,
    isChange = false,
    PAGameUIType = CppEnums.PAGameUIType.PAGameUIPanel_ClassResource,
    prePos = {x = 0, y = 0},
    name = PAGetString(Defines.StringSheet_GAME, "LUA_PANELCONTROL_14"),
    isShow = true
  }
  panelControl[panelID.Adrenallin] = {
    control = Panel_Adrenallin,
    showFixed = false,
    posFixed = false,
    isChange = false,
    PAGameUIType = CppEnums.PAGameUIType.PAGameUIPanel_Adrenallin,
    prePos = {x = 0, y = 0},
    name = PAGetString(Defines.StringSheet_GAME, "LUA_PANELCONTROL_15"),
    isShow = true
  }
  panelControl[panelID.UIMain] = {
    control = Panel_UIMain,
    showFixed = false,
    posFixed = true,
    isChange = false,
    PAGameUIType = CppEnums.PAGameUIType.PAGameUIPanel_UIMenu,
    prePos = {x = 0, y = 0},
    name = PAGetString(Defines.StringSheet_GAME, "LUA_PANELCONTROL_16"),
    isShow = true
  }
  panelControl[panelID.House] = {
    control = Panel_MyHouseNavi,
    showFixed = false,
    posFixed = false,
    isChange = false,
    PAGameUIType = CppEnums.PAGameUIType.PAGameUIPanel_MyHouseNavi,
    prePos = {x = 0, y = 0},
    name = PAGetString(Defines.StringSheet_GAME, "LUA_PANELCONTROL_17"),
    isShow = false
  }
  panelControl[panelID.NewEquip] = {
    control = Panel_NewEquip,
    showFixed = false,
    posFixed = false,
    isChange = false,
    PAGameUIType = CppEnums.PAGameUIType.PAGameUIPanel_NewEquipment,
    prePos = {x = 0, y = 0},
    name = PAGetString(Defines.StringSheet_GAME, "LUA_PANELCONTROL_18"),
    isShow = true
  }
  panelControl[panelID.Party] = {
    control = Panel_Party,
    showFixed = false,
    posFixed = false,
    isChange = false,
    PAGameUIType = CppEnums.PAGameUIType.PAGameUIPanel_Party,
    prePos = {x = 0, y = 0},
    name = PAGetString(Defines.StringSheet_GAME, "LUA_PANELCONTROL_19"),
    isShow = true
  }
  panelControl[panelID.TimeBar] = {
    control = Panel_TimeBar,
    showFixed = false,
    posFixed = true,
    isChange = false,
    PAGameUIType = CppEnums.PAGameUIType.PAGameUIPanel_TimeBar,
    prePos = {x = 0, y = 0},
    name = PAGetString(Defines.StringSheet_GAME, "LUA_PANELCONTROL_20"),
    isShow = true
  }
  panelControl[panelID.ActionGuide] = {
    control = Panel_SkillCommand,
    showFixed = false,
    posFixed = false,
    isChange = false,
    PAGameUIType = CppEnums.PAGameUIType.PAGameUIPanel_SkillCommand,
    prePos = {x = 0, y = 0},
    name = PAGetString(Defines.StringSheet_GAME, "LUA_PANELCONTROL_21"),
    isShow = true
  }
  panelControl[panelID.KeyGuide] = {
    control = Panel_Movie_KeyViewer,
    showFixed = false,
    posFixed = false,
    isChange = false,
    PAGameUIType = CppEnums.PAGameUIType.PAGameUIPanel_KeyViewer,
    prePos = {x = 0, y = 0},
    name = PAGetString(Defines.StringSheet_GAME, "LUA_PANELCONTROL_22"),
    isShow = false
  }
  panelControl[panelID.NewQuickSlot0] = {
    control = Panel_NewQuickSlot_0,
    showFixed = false,
    posFixed = false,
    isChange = false,
    PAGameUIType = CppEnums.PAGameUIType.PAGameUIPanel_NewQuickSlot_0,
    prePos = {x = 0, y = 0},
    name = PAGetString(Defines.StringSheet_GAME, "LUA_UI_SETTING_QUICKSLOT_1"),
    isShow = false
  }
  panelControl[panelID.NewQuickSlot1] = {
    control = Panel_NewQuickSlot_1,
    showFixed = false,
    posFixed = false,
    isChange = false,
    PAGameUIType = CppEnums.PAGameUIType.PAGameUIPanel_NewQuickSlot_1,
    prePos = {x = 0, y = 0},
    name = PAGetString(Defines.StringSheet_GAME, "LUA_UI_SETTING_QUICKSLOT_2"),
    isShow = false
  }
  panelControl[panelID.NewQuickSlot2] = {
    control = Panel_NewQuickSlot_2,
    showFixed = false,
    posFixed = false,
    isChange = false,
    PAGameUIType = CppEnums.PAGameUIType.PAGameUIPanel_NewQuickSlot_2,
    prePos = {x = 0, y = 0},
    name = PAGetString(Defines.StringSheet_GAME, "LUA_UI_SETTING_QUICKSLOT_3"),
    isShow = false
  }
  panelControl[panelID.NewQuickSlot3] = {
    control = Panel_NewQuickSlot_3,
    showFixed = false,
    posFixed = false,
    isChange = false,
    PAGameUIType = CppEnums.PAGameUIType.PAGameUIPanel_NewQuickSlot_3,
    prePos = {x = 0, y = 0},
    name = PAGetString(Defines.StringSheet_GAME, "LUA_UI_SETTING_QUICKSLOT_4"),
    isShow = false
  }
  panelControl[panelID.NewQuickSlot4] = {
    control = Panel_NewQuickSlot_4,
    showFixed = false,
    posFixed = false,
    isChange = false,
    PAGameUIType = CppEnums.PAGameUIType.PAGameUIPanel_NewQuickSlot_4,
    prePos = {x = 0, y = 0},
    name = PAGetString(Defines.StringSheet_GAME, "LUA_UI_SETTING_QUICKSLOT_5"),
    isShow = false
  }
  panelControl[panelID.NewQuickSlot5] = {
    control = Panel_NewQuickSlot_5,
    showFixed = false,
    posFixed = false,
    isChange = false,
    PAGameUIType = CppEnums.PAGameUIType.PAGameUIPanel_NewQuickSlot_5,
    prePos = {x = 0, y = 0},
    name = PAGetString(Defines.StringSheet_GAME, "LUA_UI_SETTING_QUICKSLOT_6"),
    isShow = false
  }
  panelControl[panelID.NewQuickSlot6] = {
    control = Panel_NewQuickSlot_6,
    showFixed = false,
    posFixed = false,
    isChange = false,
    PAGameUIType = CppEnums.PAGameUIType.PAGameUIPanel_NewQuickSlot_6,
    prePos = {x = 0, y = 0},
    name = PAGetString(Defines.StringSheet_GAME, "LUA_UI_SETTING_QUICKSLOT_7"),
    isShow = false
  }
  panelControl[panelID.NewQuickSlot7] = {
    control = Panel_NewQuickSlot_7,
    showFixed = false,
    posFixed = false,
    isChange = false,
    PAGameUIType = CppEnums.PAGameUIType.PAGameUIPanel_NewQuickSlot_7,
    prePos = {x = 0, y = 0},
    name = PAGetString(Defines.StringSheet_GAME, "LUA_UI_SETTING_QUICKSLOT_8"),
    isShow = false
  }
  panelControl[panelID.NewQuickSlot8] = {
    control = Panel_NewQuickSlot_8,
    showFixed = false,
    posFixed = false,
    isChange = false,
    PAGameUIType = CppEnums.PAGameUIType.PAGameUIPanel_NewQuickSlot_8,
    prePos = {x = 0, y = 0},
    name = PAGetString(Defines.StringSheet_GAME, "LUA_UI_SETTING_QUICKSLOT_9"),
    isShow = false
  }
  panelControl[panelID.NewQuickSlot9] = {
    control = Panel_NewQuickSlot_9,
    showFixed = false,
    posFixed = false,
    isChange = false,
    PAGameUIType = CppEnums.PAGameUIType.PAGameUIPanel_NewQuickSlot_9,
    prePos = {x = 0, y = 0},
    name = PAGetString(Defines.StringSheet_GAME, "LUA_UI_SETTING_QUICKSLOT_10"),
    isShow = false
  }
  panelControl[panelID.NewQuickSlot10] = {
    control = Panel_NewQuickSlot_10,
    showFixed = false,
    posFixed = false,
    isChange = false,
    PAGameUIType = CppEnums.PAGameUIType.PAGameUIPanel_NewQuickSlot_10,
    prePos = {x = 0, y = 0},
    name = PAGetString(Defines.StringSheet_GAME, "LUA_UI_SETTING_QUICKSLOT_11"),
    isShow = false
  }
  panelControl[panelID.NewQuickSlot11] = {
    control = Panel_NewQuickSlot_11,
    showFixed = false,
    posFixed = false,
    isChange = false,
    PAGameUIType = CppEnums.PAGameUIType.PAGameUIPanel_NewQuickSlot_11,
    prePos = {x = 0, y = 0},
    name = PAGetString(Defines.StringSheet_GAME, "LUA_UI_SETTING_QUICKSLOT_12"),
    isShow = false
  }
  panelControl[panelID.NewQuickSlot12] = {
    control = Panel_NewQuickSlot_12,
    showFixed = false,
    posFixed = false,
    isChange = false,
    PAGameUIType = CppEnums.PAGameUIType.PAGameUIPanel_NewQuickSlot_12,
    prePos = {x = 0, y = 0},
    name = PAGetString(Defines.StringSheet_GAME, "LUA_UI_SETTING_QUICKSLOT_13"),
    isShow = false
  }
  panelControl[panelID.NewQuickSlot13] = {
    control = Panel_NewQuickSlot_13,
    showFixed = false,
    posFixed = false,
    isChange = false,
    PAGameUIType = CppEnums.PAGameUIType.PAGameUIPanel_NewQuickSlot_13,
    prePos = {x = 0, y = 0},
    name = PAGetString(Defines.StringSheet_GAME, "LUA_UI_SETTING_QUICKSLOT_14"),
    isShow = false
  }
  panelControl[panelID.NewQuickSlot14] = {
    control = Panel_NewQuickSlot_14,
    showFixed = false,
    posFixed = false,
    isChange = false,
    PAGameUIType = CppEnums.PAGameUIType.PAGameUIPanel_NewQuickSlot_14,
    prePos = {x = 0, y = 0},
    name = PAGetString(Defines.StringSheet_GAME, "LUA_UI_SETTING_QUICKSLOT_15"),
    isShow = false
  }
  panelControl[panelID.NewQuickSlot15] = {
    control = Panel_NewQuickSlot_15,
    showFixed = false,
    posFixed = false,
    isChange = false,
    PAGameUIType = CppEnums.PAGameUIType.PAGameUIPanel_NewQuickSlot_15,
    prePos = {x = 0, y = 0},
    name = PAGetString(Defines.StringSheet_GAME, "LUA_UI_SETTING_QUICKSLOT_16"),
    isShow = false
  }
  panelControl[panelID.NewQuickSlot16] = {
    control = Panel_NewQuickSlot_16,
    showFixed = false,
    posFixed = false,
    isChange = false,
    PAGameUIType = CppEnums.PAGameUIType.PAGameUIPanel_NewQuickSlot_16,
    prePos = {x = 0, y = 0},
    name = PAGetString(Defines.StringSheet_GAME, "LUA_UI_SETTING_QUICKSLOT_17"),
    isShow = false
  }
  panelControl[panelID.NewQuickSlot17] = {
    control = Panel_NewQuickSlot_17,
    showFixed = false,
    posFixed = false,
    isChange = false,
    PAGameUIType = CppEnums.PAGameUIType.PAGameUIPanel_NewQuickSlot_17,
    prePos = {x = 0, y = 0},
    name = PAGetString(Defines.StringSheet_GAME, "LUA_UI_SETTING_QUICKSLOT_18"),
    isShow = false
  }
  panelControl[panelID.NewQuickSlot18] = {
    control = Panel_NewQuickSlot_18,
    showFixed = false,
    posFixed = false,
    isChange = false,
    PAGameUIType = CppEnums.PAGameUIType.PAGameUIPanel_NewQuickSlot_18,
    prePos = {x = 0, y = 0},
    name = PAGetString(Defines.StringSheet_GAME, "LUA_UI_SETTING_QUICKSLOT_19"),
    isShow = false
  }
  panelControl[panelID.NewQuickSlot19] = {
    control = Panel_NewQuickSlot_19,
    showFixed = false,
    posFixed = false,
    isChange = false,
    PAGameUIType = CppEnums.PAGameUIType.PAGameUIPanel_NewQuickSlot_19,
    prePos = {x = 0, y = 0},
    name = PAGetString(Defines.StringSheet_GAME, "LUA_UI_SETTING_QUICKSLOT_20"),
    isShow = false
  }
  panelControl[panelID.SkillCoolTime] = {
    control = Panel_SkillCooltime,
    showFixed = false,
    posFixed = false,
    isChange = false,
    PAGameUIType = CppEnums.PAGameUIType.PAGameUIPanel_SkillCoolTime,
    prePos = {x = 0, y = 0},
    name = PAGetString(Defines.StringSheet_GAME, "LUA_UISETTING_SKILLCOOLTIME"),
    isShow = false
  }
  panelControl[panelID.MainQuest] = {
    control = Panel_MainQuest,
    showFixed = false,
    posFixed = false,
    isChange = false,
    PAGameUIType = CppEnums.PAGameUIType.PAGameUIPanel_MainQuest,
    prePos = {x = 0, y = 0},
    name = PAGetString(Defines.StringSheet_GAME, "LUA_PANEL_MAINQUEST_TITLE"),
    isShow = false
  }
  panelControl[panelID.LargeParty] = {
    control = Panel_LargeParty,
    showFixed = false,
    posFixed = false,
    isChange = false,
    PAGameUIType = CppEnums.PAGameUIType.PAGameUIPanel_LargeParty,
    prePos = {x = 0, y = 0},
    name = PAGetString(Defines.StringSheet_GAME, "LUA_UI_SETTING_LARGEPARTY_TITLE"),
    isShow = true
  }
  panelControl[panelID.SkillCoolTimeQuickSlot0] = {
    control = Panel_SkillCoolTimeQuickSlot_0,
    showFixed = false,
    posFixed = false,
    isChange = false,
    PAGameUIType = CppEnums.PAGameUIType.PAGameUIPanel_SkillCoolTimeQuickSlot_0,
    prePos = {x = 0, y = 0},
    name = PAGetString(Defines.StringSheet_GAME, "LUA_UI_SETTING_SKILLCOLLTIMEQUICKSLOT_1"),
    isShow = false
  }
  panelControl[panelID.SkillCoolTimeQuickSlot1] = {
    control = Panel_SkillCoolTimeQuickSlot_1,
    showFixed = false,
    posFixed = false,
    isChange = false,
    PAGameUIType = CppEnums.PAGameUIType.PAGameUIPanel_SkillCoolTimeQuickSlot_1,
    prePos = {x = 0, y = 0},
    name = PAGetString(Defines.StringSheet_GAME, "LUA_UI_SETTING_SKILLCOLLTIMEQUICKSLOT_2"),
    isShow = false
  }
  panelControl[panelID.SkillCoolTimeQuickSlot2] = {
    control = Panel_SkillCoolTimeQuickSlot_2,
    showFixed = false,
    posFixed = false,
    isChange = false,
    PAGameUIType = CppEnums.PAGameUIType.PAGameUIPanel_SkillCoolTimeQuickSlot_2,
    prePos = {x = 0, y = 0},
    name = PAGetString(Defines.StringSheet_GAME, "LUA_UI_SETTING_SKILLCOLLTIMEQUICKSLOT_3"),
    isShow = false
  }
  panelControl[panelID.SkillCoolTimeQuickSlot3] = {
    control = Panel_SkillCoolTimeQuickSlot_3,
    showFixed = false,
    posFixed = false,
    isChange = false,
    PAGameUIType = CppEnums.PAGameUIType.PAGameUIPanel_SkillCoolTimeQuickSlot_3,
    prePos = {x = 0, y = 0},
    name = PAGetString(Defines.StringSheet_GAME, "LUA_UI_SETTING_SKILLCOLLTIMEQUICKSLOT_4"),
    isShow = false
  }
  panelControl[panelID.SkillCoolTimeQuickSlot4] = {
    control = Panel_SkillCoolTimeQuickSlot_4,
    showFixed = false,
    posFixed = false,
    isChange = false,
    PAGameUIType = CppEnums.PAGameUIType.PAGameUIPanel_SkillCoolTimeQuickSlot_4,
    prePos = {x = 0, y = 0},
    name = PAGetString(Defines.StringSheet_GAME, "LUA_UI_SETTING_SKILLCOLLTIMEQUICKSLOT_5"),
    isShow = false
  }
  panelControl[panelID.SkillCoolTimeQuickSlot5] = {
    control = Panel_SkillCoolTimeQuickSlot_5,
    showFixed = false,
    posFixed = false,
    isChange = false,
    PAGameUIType = CppEnums.PAGameUIType.PAGameUIPanel_SkillCoolTimeQuickSlot_5,
    prePos = {x = 0, y = 0},
    name = PAGetString(Defines.StringSheet_GAME, "LUA_UI_SETTING_SKILLCOLLTIMEQUICKSLOT_6"),
    isShow = false
  }
  panelControl[panelID.SkillCoolTimeQuickSlot6] = {
    control = Panel_SkillCoolTimeQuickSlot_6,
    showFixed = false,
    posFixed = false,
    isChange = false,
    PAGameUIType = CppEnums.PAGameUIType.PAGameUIPanel_SkillCoolTimeQuickSlot_6,
    prePos = {x = 0, y = 0},
    name = PAGetString(Defines.StringSheet_GAME, "LUA_UI_SETTING_SKILLCOLLTIMEQUICKSLOT_7"),
    isShow = false
  }
  panelControl[panelID.SkillCoolTimeQuickSlot7] = {
    control = Panel_SkillCoolTimeQuickSlot_7,
    showFixed = false,
    posFixed = false,
    isChange = false,
    PAGameUIType = CppEnums.PAGameUIType.PAGameUIPanel_SkillCoolTimeQuickSlot_7,
    prePos = {x = 0, y = 0},
    name = PAGetString(Defines.StringSheet_GAME, "LUA_UI_SETTING_SKILLCOLLTIMEQUICKSLOT_8"),
    isShow = false
  }
  panelControl[panelID.SkillCoolTimeQuickSlot8] = {
    control = Panel_SkillCoolTimeQuickSlot_8,
    showFixed = false,
    posFixed = false,
    isChange = false,
    PAGameUIType = CppEnums.PAGameUIType.PAGameUIPanel_SkillCoolTimeQuickSlot_8,
    prePos = {x = 0, y = 0},
    name = PAGetString(Defines.StringSheet_GAME, "LUA_UI_SETTING_SKILLCOLLTIMEQUICKSLOT_9"),
    isShow = false
  }
  panelControl[panelID.SkillCoolTimeQuickSlot9] = {
    control = Panel_SkillCoolTimeQuickSlot_9,
    showFixed = false,
    posFixed = false,
    isChange = false,
    PAGameUIType = CppEnums.PAGameUIType.PAGameUIPanel_SkillCoolTimeQuickSlot_9,
    prePos = {x = 0, y = 0},
    name = PAGetString(Defines.StringSheet_GAME, "LUA_UI_SETTING_SKILLCOLLTIMEQUICKSLOT_10"),
    isShow = false
  }
  panelControl[panelID.MainStatusRemaster] = {
    control = Panel_MainStatus_Remaster,
    showFixed = false,
    posFixed = true,
    isChange = false,
    PAGameUIType = CppEnums.PAGameUIType.PAGameUIPanel_MainStatusRemaster,
    prePos = {x = 0, y = 0},
    name = PAGetString(Defines.StringSheet_GAME, "LUA_PANELCONTROL_1"),
    isShow = true
  }
  panelControl[panelID.ServantIconRemaster] = {
    control = Panel_Widget_ServantIcon,
    showFixed = false,
    posFixed = false,
    isChange = false,
    PAGameUIType = CppEnums.PAGameUIType.PAGameUIPanel_ServantIcon,
    prePos = {x = 0, y = 0},
    name = PAGetString(Defines.StringSheet_GAME, "LUA_PANELCONTROL_2"),
    isShow = true
  }
  panelControl[panelID.AppliedBuffList] = {
    control = Panel_AppliedBuffList,
    showFixed = false,
    posFixed = false,
    isChange = false,
    PAGameUIType = CppEnums.PAGameUIType.PAGameUIPanel_AppliedBuffList,
    prePos = {x = 0, y = 0},
    name = PAGetString(Defines.StringSheet_GAME, "BUFF_LIST"),
    isShow = true
  }
  panelControl[panelID.LeftIcon] = {
    control = Panel_PersonalIcon_Left,
    showFixed = false,
    posFixed = true,
    isChange = false,
    PAGameUIType = CppEnums.PAGameUIType.PAGameUIPanel_LeftIcon,
    prePos = {x = 0, y = 0},
    name = PAGetString(Defines.StringSheet_GAME, "LUA_UI_SETTING_FAMILYBUFF_NAME"),
    isShow = true
  }
  panelControl[panelID.RightIcon] = {
    control = Panel_Widget_Function,
    showFixed = false,
    posFixed = true,
    isChange = false,
    PAGameUIType = CppEnums.PAGameUIType.PAGameUIPanel_WidgetFunction,
    prePos = {x = 0, y = 0},
    name = PAGetString(Defines.StringSheet_GAME, "LUA_UI_SETTING_FUNCTIONBUTTON_NAME"),
    isShow = true
  }
  panelControl[panelID.AreaOfHadum] = {
    control = Panel_Widget_AreaOfHadum,
    showFixed = false,
    posFixed = false,
    isChange = false,
    PAGameUIType = CppEnums.PAGameUIType.PAGameUIPanel_AreaOfHadum,
    prePos = {x = 0, y = 0},
    name = "\237\149\152\235\145\160\236\157\152 \236\152\129\236\151\173",
    isShow = true
  }
  panelControl[panelID.Stamina] = {
    control = Panel_Stamina,
    showFixed = true,
    posFixed = false,
    isChange = false,
    PAGameUIType = CppEnums.PAGameUIType.PAGameUIPanel_Stamina,
    prePos = {x = 0, y = 0},
    name = PAGetString(Defines.StringSheet_RESOURCE, "CHARACTERINFO_TEXT_STAMINA"),
    isShow = true
  }
  panelControl[panelID.killLog] = {
    control = Panel_Widget_KillLog,
    showFixed = false,
    posFixed = false,
    isChange = false,
    PAGameUIType = CppEnums.PAGameUIType.PAGameUIPanel_KillLog,
    prePos = {x = 0, y = 0},
    name = PAGetString(Defines.StringSheet_GAME, "LUA_UI_SETTING_KILLLOG_NAME"),
    isShow = true
  }
  if false == ToClient_isConsole() then
    if true == _ContentsGroup_NewUI_PartyWidget_All then
      panelControl[panelID.LargeParty] = {
        control = Panel_Widget_Raid_All,
        showFixed = false,
        posFixed = false,
        isChange = false,
        PAGameUIType = CppEnums.PAGameUIType.PAGameUIPanel_LargeParty,
        prePos = {x = 0, y = 0},
        name = PAGetString(Defines.StringSheet_GAME, "LUA_UI_SETTING_LARGEPARTY_TITLE"),
        isShow = true
      }
      panelControl[panelID.Party] = {
        control = Panel_Widget_Party_All,
        showFixed = false,
        posFixed = false,
        isChange = false,
        PAGameUIType = CppEnums.PAGameUIType.PAGameUIPanel_Party,
        prePos = {x = 0, y = 0},
        name = PAGetString(Defines.StringSheet_GAME, "LUA_PANELCONTROL_19"),
        isShow = true
      }
    else
      panelControl[panelID.LargeParty] = {
        control = Panel_Widget_Raid,
        showFixed = false,
        posFixed = false,
        isChange = false,
        PAGameUIType = CppEnums.PAGameUIType.PAGameUIPanel_LargeParty,
        prePos = {x = 0, y = 0},
        name = PAGetString(Defines.StringSheet_GAME, "LUA_UI_SETTING_LARGEPARTY_TITLE"),
        isShow = true
      }
      panelControl[panelID.Party] = {
        control = Panel_Widget_Party,
        showFixed = false,
        posFixed = false,
        isChange = false,
        PAGameUIType = CppEnums.PAGameUIType.PAGameUIPanel_Party,
        prePos = {x = 0, y = 0},
        name = PAGetString(Defines.StringSheet_GAME, "LUA_PANELCONTROL_19"),
        isShow = true
      }
    end
  end
  local swapRadar = ToClient_getGameUIManagerWrapper():getLuaCacheDataListBool(__eRadarSwap)
  if true == swapRadar then
    setChangeUiSettingRadarUI(Panel_WorldMiniMap, CppEnums.PAGameUIType.PAGameUIPanel_WorldMiniMap)
  end
  self._panelCount = #self._panelControl
  PaGlobal_UIModify:initializePanelPool()
  if true == _ContentsGroup_RenewUI_Main then
    Panel_SkillCommand:SetShow(false)
    Panel_UIMain:SetShow(false)
  end
  self._renderMode = RenderModeWrapper.new(100, {
    Defines.RenderMode.eRenderMode_UISetting
  }, false)
  self._renderMode:setClosefunctor(self._renderMode, FGlobal_UiSet_Close)
  self._ui.slider_UI_Scale:SetInterval(160)
  local remasterUIOption = ToClient_getGameUIManagerWrapper():getLuaCacheDataListBool(__eSwapRemasterUISetting)
  self._ui.chk_remsaterUI:SetCheck(not remasterUIOption)
  self._prevRemasterUI = remasterUIOption
  self._isShowRemasterUI = remasterUIOption
  PaGlobal_UIModify:registEventHandler()
  PaGlobal_UIModify:validate()
  self._initialize = true
end
function PaGlobal_UIModify:initializePanelPool()
  if 0 == self._panelCount then
    UI.ASSERT_NAME(0 < self._panelCount, "Panel_Window_UIModify_All\236\157\152 _panelCount\234\176\128 0\236\157\180\235\169\180 \236\149\136\235\144\156\235\139\164.", "\236\134\161\235\175\188\236\160\149")
    return
  end
  self._panelPoolBG = UI.createPanelAndSetPanelRenderMode("Panel_modifyPool", Defines.UIGroup.PAGameUIGroup_Window_Progress, PAUIRenderModeBitSet({
    Defines.RenderMode.eRenderMode_UISetting
  }))
  if nil == self._panelPoolBG then
    UI.ASSERT_NAME(0 < self._panelCount, "Panel_Window_UIModify_All\236\157\152 _panelPoolBG\234\176\128 nil\236\157\180\235\169\180 \236\149\136\235\144\156\235\139\164.", "\236\134\161\235\175\188\236\160\149")
    return
  end
  self._panelPoolBG:SetAlpha(0)
  self._panelPoolBG:SetIgnore(true)
  for idx = 1, self._panelCount do
    local orignalControl = self._panelControl[idx].control
    local slot = {}
    local fixedType = ""
    if self._panelControl[idx].posFixed then
      fixedType = "StaticText_Disable"
    else
      fixedType = "StaticText_Able"
    end
    slot.control = UI.createAndCopyBasePropertyControl(Panel_Window_UIModify_All, fixedType, self._panelPoolBG, "txt_createControl_" .. idx)
    slot.control:SetShow(true)
    slot.control:SetSize(orignalControl:GetSizeX(), orignalControl:GetSizeY())
    slot.control:SetPosX(orignalControl:GetPosX())
    slot.control:SetPosY(orignalControl:GetPosY())
    slot.control:addInputEvent("Mouse_LDown", "HandleEventLUp_UiSet_MoveControlSet_Start( " .. idx .. " )")
    slot.control:addInputEvent("Mouse_LPress", "HandleEventLUp_UiSet_MoveControl( " .. idx .. " )")
    slot.control:addInputEvent("Mouse_LUp", "HandleEventLUp_UiSet_PositionCheck( " .. idx .. " )")
    if idx >= self._panelID.SkillCoolTimeQuickSlot0 and idx <= self._panelID.SkillCoolTimeQuickSlot9 then
      slot.control:addInputEvent("Mouse_On", "PaGlobal_SimpleTooltips_Index(true, " .. idx .. ")")
      slot.control:addInputEvent("Mouse_Out", "PaGlobal_SimpleTooltips_Index(false, " .. idx .. ")")
    end
    slot.close = UI.createAndCopyBasePropertyControl(Panel_Window_UIModify_All, "Button_ShowToggle", slot.control, "btn_createClose_" .. idx)
    slot.close:SetShow(true)
    slot.close:SetPosX(slot.control:GetSizeX() - slot.close:GetSizeX() - 3)
    slot.close:SetPosY(3)
    slot.close:SetCheck(orignalControl:GetShow())
    if idx >= PaGlobal_UIModify._panelID.NewQuickSlot0 and idx <= PaGlobal_UIModify._panelID.NewQuickSlot19 then
      slot.close:addInputEvent("Mouse_LUp", "HandleEventLUp_UiModify_NewQuickSlotShowToggle( " .. idx .. " )")
    else
      slot.close:addInputEvent("Mouse_LUp", "HandleEventLUp_UiSet_ControlShowToggle( " .. idx .. " )")
    end
    self._panelPool[idx] = slot
    if true == self._panelControl[idx].showFixed then
      self._panelControl[idx].isShow = true
      slot.close:SetShow(false)
    else
      self._panelControl[idx].isShow = self._panelControl[idx].control:GetShow()
      slot.close:SetShow(true)
    end
    if self._panelControl[idx].isShow then
      if self._panelControl[idx].posFixed then
        slot.control:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_UI_SETTING_SLOTCONTROL_IMPOSSIBLE", "name", self._panelControl[idx].name))
      else
        slot.control:SetText(self._panelControl[idx].name)
      end
    elseif 21 == idx then
      slot.control:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_UISETTING_SKILLGUIDE_EXTRA"))
    else
      slot.control:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_UI_SETTING_SLOTCONTROL_OFF", "name", self._panelControl[idx].name))
    end
    local stateValue = 0
    if not self._panelControl[idx].isShow then
      stateValue = 1
    elseif self._panelControl[idx].posFixed then
      stateValue = 3
    else
      stateValue = 2
    end
    self:changePanelBGTexture(idx, stateValue)
    if 0 < ToClient_GetUiInfo(self._panelControl[idx].PAGameUIType, 0, CppEnums.PanelSaveType.PanelSaveType_IsSaved) then
      local relativePosX, relativePosY
      if idx >= self._panelID.Chat0 and idx <= self._panelID.Chat4 then
        relativePosX = ToClient_GetUiInfo(self._panelControl[idx].PAGameUIType, idx - self._panelID.Chat0, CppEnums.PanelSaveType.PanelSaveType_RelativePositionX)
        relativePosY = ToClient_GetUiInfo(self._panelControl[idx].PAGameUIType, idx - self._panelID.Chat0, CppEnums.PanelSaveType.PanelSaveType_RelativePositionY)
      else
        relativePosX = ToClient_GetUiInfo(self._panelControl[idx].PAGameUIType, 0, CppEnums.PanelSaveType.PanelSaveType_RelativePositionX)
        relativePosY = ToClient_GetUiInfo(self._panelControl[idx].PAGameUIType, 0, CppEnums.PanelSaveType.PanelSaveType_RelativePositionY)
      end
      if relativePosX == -1 or relativePosY == -1 then
        if 0 < orignalControl:GetRelativePosX() or 0 < orignalControl:GetRelativePosY() then
          self._panelControl[idx].isChange = true
        else
          self._panelControl[idx].isChange = false
        end
      elseif 0 < relativePosX or 0 < relativePosY then
        self._panelControl[idx].isChange = true
      end
      if self._panelControl[idx].posFixed == true then
        self._panelControl[idx].isChange = false
        Panel_Window_UIModify_All:SetChildIndex(slot.control, 0)
      end
      orignalControl:SetRelativePosX(relativePosX)
      orignalControl:SetRelativePosY(relativePosY)
      self._panelPool[idx].control:SetRelativePosX(relativePosX)
      self._panelPool[idx].control:SetRelativePosY(relativePosY)
    end
  end
end
function PaGlobal_UIModify:registEventHandler()
  if nil == Panel_Window_UIModify_All then
    return
  end
  registerEvent("FromClient_getUiSettingPanelInfo", "FromClient_getUiSettingPanelInfo")
  registerEvent("FromClient_getUiSettingChattingPanelInfo", "FromClient_getUiSettingChattingPanelInfo")
  registerEvent("FromClient_applyChattingOptionToLua", "FromClient_applyChattingOptionToLua")
  registerEvent("onScreenResize", "FromClient_UISetting_Resize")
  self._ui.chk_Collapse:addInputEvent("Mouse_LUp", "PaGlobal_UIModify:updateModifyPanelSize()")
  self._ui.chk_Collapse:addInputEvent("Mouse_On", "PaGlobal_UIModify:showCollapseTooltip()")
  self._ui.chk_Collapse:addInputEvent("Mouse_Out", "TooltipSimple_Hide()")
  self._ui.btn_win_close:addInputEvent("Mouse_LUp", "PaGlobal_UIModify:prepareClose()")
  self._ui.btn_save:addInputEvent("Mouse_LUp", "UiSet_FreeSet_Open()")
  self._ui.btn_reset:addInputEvent("Mouse_LUp", "HandleClicked_Reset_UiSetting_Msg()")
  self._ui.chk_GridView:addInputEvent("Mouse_LUp", "HandleLUp_ToggleGrid()")
  self._ui.btn_Scale:addInputEvent("Mouse_LDown", "HandleEventLDown_UiSet_ChangeScale()")
  self._ui.slider_UI_Scale:addInputEvent("Mouse_LDown", "HandleEventLDown_UiSet_ChangeScale()")
  self._ui.btn_Scale:addInputEvent("Mouse_LPress", "HandleEventLPress_UiSet_ChangeScale()")
  self._ui.slider_UI_Scale:addInputEvent("Mouse_LPress", "HandleEventLPress_UiSet_ChangeScale()")
  self._ui.chk_FieldView:addInputEvent("Mouse_LUp", "HandleEventLUp_UiSet_FieldViewToggle()")
  self._ui.chk_remsaterUI:addInputEvent("Mouse_LUp", "HandleEventLUp_UiSet_SwapRemasterUI()")
  self._ui.btn_UIFreeSet1:addInputEvent("Mouse_LUp", "HandleEventLUp_ApplyPresetInfo( " .. __eUISetting_Preset0 .. ", false)")
  self._ui.btn_UIFreeSet2:addInputEvent("Mouse_LUp", "HandleEventLUp_ApplyPresetInfo( " .. __eUISetting_Preset1 .. ", false)")
  self._ui.btn_UIFreeSet3:addInputEvent("Mouse_LUp", "HandleEventLUp_ApplyPresetInfo( " .. __eUISetting_Preset2 .. ", false)")
  self._ui.btn_RevertMod:addInputEvent("Mouse_LUp", "HandleEventLUp_ApplyPresetInfo( " .. __eUISetting_Revert .. ", false)")
  self._ui.btn_CleanMode:addInputEvent("Mouse_LUp", "HandleLUp_UiSetting_DefaultSet(false)")
  self._ui.btn_UIFreeSet1:setButtonShortcutsWithEvent("HandleEventLUp_ApplyPresetInfo( " .. __eUISetting_Preset0 .. ", true)", "PANEL_SAVEFREESET_FREESET1")
  self._ui.btn_UIFreeSet2:setButtonShortcutsWithEvent("HandleEventLUp_ApplyPresetInfo( " .. __eUISetting_Preset1 .. ", true)", "PANEL_SAVEFREESET_FREESET2")
  self._ui.btn_UIFreeSet3:setButtonShortcutsWithEvent("HandleEventLUp_ApplyPresetInfo( " .. __eUISetting_Preset2 .. ", true)", "PANEL_SAVEFREESET_FREESET3")
  self._ui.btn_RevertMod:setButtonShortcutsWithEvent("HandleEventLUp_ApplyPresetInfo( " .. __eUISetting_Revert .. ", true)", "PANEL_UISETTING_REVERT_MODE")
  self._ui.btn_CleanMode:setButtonShortcutsWithEvent("HandleLUp_UiSetting_DefaultSet(true)", "PANEL_UISETTING_COMBAT_FOCUS_MODE")
  self._ui.btn_UIFreeSet1:addInputEvent("Mouse_On", "PaGlobal_UIModify_ButtonTooltip(" .. PaGlobal_UIModify._eBtnType.preset1 .. ", true)")
  self._ui.btn_UIFreeSet2:addInputEvent("Mouse_On", "PaGlobal_UIModify_ButtonTooltip(" .. PaGlobal_UIModify._eBtnType.preset2 .. ", true)")
  self._ui.btn_UIFreeSet3:addInputEvent("Mouse_On", "PaGlobal_UIModify_ButtonTooltip(" .. PaGlobal_UIModify._eBtnType.preset3 .. ", true)")
  self._ui.btn_CleanMode:addInputEvent("Mouse_On", "PaGlobal_UIModify_ButtonTooltip(" .. PaGlobal_UIModify._eBtnType.battleMode .. ", true)")
  self._ui.btn_RevertMod:addInputEvent("Mouse_On", "PaGlobal_UIModify_ButtonTooltip(" .. PaGlobal_UIModify._eBtnType.revertMode .. ", true)")
  self._ui.btn_UIFreeSet1:addInputEvent("Mouse_Out", "PaGlobal_UIModify_ButtonTooltip(" .. PaGlobal_UIModify._eBtnType.preset1 .. ", false)")
  self._ui.btn_UIFreeSet2:addInputEvent("Mouse_Out", "PaGlobal_UIModify_ButtonTooltip(" .. PaGlobal_UIModify._eBtnType.preset2 .. ", false)")
  self._ui.btn_UIFreeSet3:addInputEvent("Mouse_Out", "PaGlobal_UIModify_ButtonTooltip(" .. PaGlobal_UIModify._eBtnType.preset3 .. ", false)")
  self._ui.btn_CleanMode:addInputEvent("Mouse_Out", "PaGlobal_UIModify_ButtonTooltip(" .. PaGlobal_UIModify._eBtnType.battleMode .. ", false)")
  self._ui.btn_RevertMod:addInputEvent("Mouse_Out", "PaGlobal_UIModify_ButtonTooltip(" .. PaGlobal_UIModify._eBtnType.revertMode .. ", false)")
  self._uiSave.btn_SaveClose:addInputEvent("Mouse_LUp", "PaGlobal_UiSet_FreeSet_Close()")
  self._uiSave.btn_SaveDefault:addInputEvent("Mouse_LUp", "HandleClicked_UiSet_ConfirmSetting(false)")
  self._uiSave.btn_SaveUI1:addInputEvent("Mouse_LUp", "HandleLUp_SavePresetInfo( " .. __eUISetting_Preset0 .. ")")
  self._uiSave.btn_SaveUI2:addInputEvent("Mouse_LUp", "HandleLUp_SavePresetInfo( " .. __eUISetting_Preset1 .. ")")
  self._uiSave.btn_SaveUI3:addInputEvent("Mouse_LUp", "HandleLUp_SavePresetInfo( " .. __eUISetting_Preset2 .. ")")
end
function PaGlobal_UIModify:prepareOpen()
  if nil == Panel_Window_UIModify_All then
    return
  end
  if nil == getSelfPlayer() or nil == getSelfPlayer():get() then
    return
  end
  if false == isGameTypeGT() and false == isGameServiceTypeDev() and not IsSelfPlayerWaitAction() then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_UI_SETTING_NOTCURRENTACTION_ACK"))
    return
  end
  local levelLimit = 7
  if levelLimit > getSelfPlayer():get():getLevel() then
    Proc_ShowMessage_Ack(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_UI_SETTING_LEVELLIMIT_ACK", "level", levelLimit))
    return
  end
  self._beforeUiMode = GetUIMode()
  close_force_WindowPanelList()
  ToClient_SaveUiInfo(false)
  self._ui.grid_BG:SetShow(false)
  self._ui.chk_GridView:SetCheck(false)
  if true == _ContentsGroup_RemasterUI_Radar then
    FGlobal_ResetTimeBar()
  end
  if nil ~= FGlobal_WebHelper_ForceClose then
    FGlobal_WebHelper_ForceClose()
  end
  if nil ~= Panel_ProductNote and true == Panel_ProductNote:GetShow() then
    Panel_ProductNote_ShowToggle()
  end
  local remasterUIOption = ToClient_getGameUIManagerWrapper():getLuaCacheDataListBool(__eSwapRemasterUISetting)
  self._ui.chk_remsaterUI:SetCheck(not remasterUIOption)
  self._prevRemasterUI = remasterUIOption
  self._isShowRemasterUI = remasterUIOption
  Panel_FieldViewMode:SetShow(false)
  self:UiSet_Panel_ShowValueUpdate()
  SetUIMode(Defines.UIMode.eUIMode_UiSetting)
  self._renderMode:set()
  self._ui.chk_FieldView:SetCheck(false)
  self._ui.chk_QuickSlotMagnetic:SetCheck(true)
  PaGlobal_UIModify:scaleSet()
  for idx = 1, self._panelCount do
    local slot = self._panelPool[idx]
    if idx == self._panelID.ExpGage then
      slot.control:SetHorizonLeft()
      slot.control:SetVerticalTop()
    elseif idx == self._panelID.TimeBar then
      slot.control:SetHorizonRight()
      slot.control:SetVerticalTop()
    elseif idx == self._panelID.Radar then
      slot.control:SetHorizonRight()
      slot.control:SetVerticalTop()
      slot.control:SetSpanSize(0, 20)
    elseif idx == self._panelID.GameTip then
      slot.control:SetHorizonLeft()
      slot.control:SetVerticalBottom()
    elseif idx == self._panelID.UIMain then
      slot.control:SetHorizonRight()
      slot.control:SetVerticalBottom()
    end
  end
  local count = ToClient_getChattingPanelCount()
  for chattingPanelindex = 0, count - 1 do
    local chatPanel = ToClient_getChattingPanel(chattingPanelindex)
    if chatPanel:isOpen() then
      self._chatPanelIsOpenState[chattingPanelindex + 1] = true
    else
      self._chatPanelIsOpenState[chattingPanelindex + 1] = false
    end
  end
  if false == ToClient_isConsole() then
    ToClient_AudioPostEvent_UIAudioStateEvent("UISTATE_OPEN_UIEDIT")
  end
  PaGlobal_UIModify:update()
  PaGlobal_UIModify:open()
end
function PaGlobal_UIModify:prepareForReplay()
  if nil == Panel_Window_UIModify_All then
    return
  end
  if nil == getSelfPlayer() or nil == getSelfPlayer():get() then
    return
  end
  close_force_WindowPanelList()
  ToClient_SaveUiInfo(false)
  if true == _ContentsGroup_RemasterUI_Radar then
    FGlobal_ResetTimeBar()
  end
  if nil ~= FGlobal_WebHelper_ForceClose then
    FGlobal_WebHelper_ForceClose()
  end
  if nil ~= Panel_ProductNote and true == Panel_ProductNote:GetShow() then
    Panel_ProductNote_ShowToggle()
  end
  Panel_FieldViewMode:SetShow(false)
  self:UiSet_Panel_ShowValueUpdate()
  SetUIMode(Defines.UIMode.eUIMod3e_UiSetting)
  PaGlobal_UIModify:scaleSet()
  for idx = 1, self._panelCount do
    local slot = self._panelPool[idx]
    if idx == self._panelID.ExpGage then
      slot.control:SetHorizonLeft()
      slot.control:SetVerticalTop()
    elseif idx == self._panelID.TimeBar then
      slot.control:SetHorizonRight()
      slot.control:SetVerticalTop()
    elseif idx == self._panelID.Radar then
      slot.control:SetHorizonRight()
      slot.control:SetVerticalTop()
      slot.control:SetSpanSize(0, 20)
    elseif idx == self._panelID.GameTip then
      slot.control:SetHorizonLeft()
      slot.control:SetVerticalBottom()
    elseif idx == self._panelID.UIMain then
      slot.control:SetHorizonRight()
      slot.control:SetVerticalBottom()
    end
  end
  local count = ToClient_getChattingPanelCount()
  for chattingPanelindex = 0, count - 1 do
    local chatPanel = ToClient_getChattingPanel(chattingPanelindex)
    if chatPanel:isOpen() then
      self._chatPanelIsOpenState[chattingPanelindex + 1] = true
    else
      self._chatPanelIsOpenState[chattingPanelindex + 1] = false
    end
  end
  if false == ToClient_isConsole() then
    ToClient_AudioPostEvent_UIAudioStateEvent("UISTATE_OPEN_UIEDIT")
  end
  PaGlobal_UIModify:update()
end
function PaGlobal_UIModify:open()
  if nil == Panel_Window_UIModify_All then
    return
  end
  Panel_Window_UIModify_All:SetShow(true)
  self._panelPoolBG:SetShow(true)
end
function PaGlobal_UIModify:prepareClose()
  if nil == Panel_Window_UIModify_All then
    return
  end
  if false == Panel_Window_UIModify_All:IsShow() then
    return
  end
  if true == _ContentsGroup_RemasterUI_Radar then
    PaGlobalFunc_Radar_Resize()
  end
  PaGlobal_UiSet_FreeSet_Close()
  SetUIMode(Defines.UIMode.eUIMode_Default)
  self._renderMode:reset()
  if self._isMenu then
    Panel_Menu_ShowToggle()
  elseif false == _ContentsGroup_UISkillGroupTreeLayOut then
    Panel_Window_Skill:SetShow(true, true)
    PaGlobal_Window_Skill_CoolTimeSlot:showFunc()
  else
    SetUIMode(self._beforeUiMode)
  end
  local count = ToClient_getChattingPanelCount()
  for chattingPanelindex = 0, count - 1 do
    Chatting_setIsOpenValue(chattingPanelindex, self._chatPanelIsOpenState[chattingPanelindex + 1])
    self._chatPanelIsOpenState[chattingPanelindex + 1] = false
  end
  for idx = 0, 4 do
    if self._closePanelState[idx] == true then
      HandleClicked_Chatting_Close(idx, 0)
    end
    self._closePanelState[idx] = false
  end
  if false == ToClient_isConsole() then
    ToClient_AudioPostEvent_UIAudioStateEvent("UISTATE_CLOSE_DEFAULT")
  end
  if true == ToClient_IsInstanceFieldPlayerbyContentsType(__eInstanceContentsType_SavageDefence) then
    FromClient_BloodAltar_OnScreenResize()
  end
  PaGlobal_UIModify:close()
end
function PaGlobal_UIModify:close()
  if nil == Panel_Window_UIModify_All then
    return
  end
  Panel_Window_UIModify_All:SetShow(false)
  self._panelPoolBG:SetShow(false)
end
function PaGlobal_UIModify:update(isRemasterSwap)
  if nil == Panel_Window_UIModify_All then
    return
  end
  FromClient_UISetting_Resize()
  if true == isRemasterSwap then
    for _, pID in pairs(self._swapPanelList) do
      if nil ~= self._panelControl[pID] then
        self._panelControl[pID].isShow = true
      end
    end
  else
    self._ui.slider_UI_Scale:SetControlPos(self._nowCurrentPercent)
  end
  local scaleText = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_UI_SETTING_SCALETEXT", "currentScale", self._currentScale)
  self._ui.txt_UISize:SetText(tostring(scaleText))
  self._ui.txt_UI_LOW:SetText(self._minScale)
  self._ui.txt_UI_HIGH:SetText(self._maxScale)
  self:updatePanelPool(isRemasterSwap)
end
function PaGlobal_UIModify:validate()
  if nil == Panel_Window_UIModify_All then
    return
  end
  self._ui.grid_BG:isValidate()
  self._ui.balckBG:isValidate()
  self._ui.main_BG:isValidate()
  self._ui.btn_UIFreeSet1:isValidate()
  self._ui.btn_UIFreeSet2:isValidate()
  self._ui.btn_UIFreeSet3:isValidate()
  self._ui.btn_CleanMode:isValidate()
  self._ui.btn_RevertMod:isValidate()
  self._ui.sub_BG:isValidate()
  self._ui.txt_UISize:isValidate()
  self._ui.txt_UI_LOW:isValidate()
  self._ui.txt_UI_HIGH:isValidate()
  self._ui.slider_UI_Scale:isValidate()
  self._ui.btn_Scale:isValidate()
  self._ui.chk_remsaterUI:isValidate()
  self._ui.chk_FieldView:isValidate()
  self._ui.chk_QuickSlotMagnetic:isValidate()
  self._ui.chk_GridView:isValidate()
  self._ui.btn_save:isValidate()
  self._ui.btn_reset:isValidate()
  for idx = 1, self._panelCount do
    self._panelControl[idx].control:isValidate()
    self._panelPool[idx].control:isValidate()
  end
end
function PaGlobal_UIModify:UiSet_Panel_ShowValueUpdate()
  for idx = 1, self._panelCount do
    if true == self._panelControl[idx].showFixed then
      self._panelControl[idx].isShow = true
    else
      self._panelControl[idx].isShow = self._panelControl[idx].control:GetShow()
    end
    self._panelControl[idx].prePos.x = self._panelControl[idx].control:GetPosX()
    self._panelControl[idx].prePos.y = self._panelControl[idx].control:GetPosY()
  end
end
function PaGlobal_UIModify:checkOldMainStatus()
  if true == _ContentsGroup_RemasterUI_Main then
    self._panelControl[self._panelID.MainStatusRemaster].control:SetShow(self._panelControl[self._panelID.MainStatusRemaster].isShow and PaGlobalFunc_IsRemasterUIOption())
    self._panelControl[self._panelID.ExpGage].control:SetShow(self._panelControl[self._panelID.ExpGage].isShow and not PaGlobalFunc_IsRemasterUIOption())
    self._panelControl[self._panelID.Adrenallin].control:SetShow(self._panelControl[self._panelID.Adrenallin].isShow and not PaGlobalFunc_IsRemasterUIOption())
    self._panelControl[self._panelID.Pvp].control:SetShow(self._panelControl[self._panelID.Pvp].isShow and not PaGlobalFunc_IsRemasterUIOption())
    self._panelControl[self._panelID.ClassResource].control:SetShow(self._panelControl[self._panelID.ClassResource].isShow and not PaGlobalFunc_IsRemasterUIOption())
    self._panelControl[self._panelID.HPBar].control:SetShow(self._panelControl[self._panelID.HPBar].isShow and not PaGlobalFunc_IsRemasterUIOption())
    self._panelControl[self._panelID.House].control:SetShow(false)
    self._panelControl[self._panelID.ServantIcon].control:SetShow(false)
    self._panelControl[self._panelID.NewEquip].control:SetShow(false)
  end
end
function PaGlobal_UIModify:scaleSet()
  local scaleValue = FGlobal_getUIScale()
  self._minScale = scaleValue.min
  self._maxScale = scaleValue.max
  self._currentScale = FGlobal_returnUIScale() * 100
  self._replaceScale = self._maxScale - self._minScale
  self._preScale = FGlobal_returnUIScale()
  self._nowCurrentPercent = math.ceil((self._currentScale - self._minScale) / self._replaceScale * 100)
  if true == UI.checkResolution4KForXBox() then
    self._nowCurrentPercent = 200
  end
end
function PaGlobal_UIModify:confrimSetting_Sub()
  local panelControl = self._panelControl
  local scale = self._currentScale / 100
  local preScale = self._preScale
  local panelID = self._panelID
  local currentScreenSize = {
    x = getScreenSizeX(),
    y = getScreenSizeY()
  }
  local preScreenSize = {
    x = currentScreenSize.x / preScale,
    y = currentScreenSize.y / preScale
  }
  local changeScreenSize = {
    x = currentScreenSize.x / scale,
    y = currentScreenSize.y / scale
  }
  for idx = 1, self._panelCount do
    local controlPosX = self._panelPool[idx].control:GetPosX()
    local controlPosY = self._panelPool[idx].control:GetPosY()
    local slot = self._panelPool[idx].control
    local posX = slot:GetPosX()
    local posY = slot:GetPosY()
    local rateX = 0
    local rateY = 0
    local isUseNewQuickSlot = isUseNewQuickSlot()
    rateX = posX + slot:GetSizeX() / 2
    rateY = posY + slot:GetSizeY() / 2
    if panelControl[idx].isChange == false then
      panelControl[idx].control:SetRelativePosX(0)
      panelControl[idx].control:SetRelativePosY(0)
      slot:SetRelativePosX(0)
      slot:SetRelativePosY(0)
    else
      panelControl[idx].control:SetRelativePosX(rateX / currentScreenSize.x)
      panelControl[idx].control:SetRelativePosY(rateY / currentScreenSize.y)
      slot:SetRelativePosX(rateX / currentScreenSize.x)
      slot:SetRelativePosY(rateY / currentScreenSize.y)
    end
    local classType = getSelfPlayer():getClassType()
    if idx == panelID.Pvp then
      if isPvpEnable() and true == ToClient_isAdultUser() then
        panelControl[idx].control:SetShow(panelControl[idx].isShow)
      end
    elseif idx == panelID.Adrenallin then
      panelControl[idx].control:SetShow(getSelfPlayer():isEnableAdrenalin())
    elseif idx == panelID.GameTip then
      panelControl[idx].control:SetShow(panelControl[idx].isShow)
      if false == _ContentsGroup_RenewUI then
        Panel_GameTipMask:SetShow(panelControl[idx].isShow)
        Panel_GameTipMask:SetPosX(controlPosX + 15)
        Panel_GameTipMask:SetPosY(controlPosY - 7)
      end
    elseif idx == panelID.ClassResource then
      if false == _ContentsGroup_RenewUI_Main then
        if __eClassType_Sorcerer == classType or __eClassType_Combattant == classType or __eClassType_Mystic == classType or __eClassType_ShyWaman == classType then
          panelControl[idx].control:SetShow(panelControl[idx].isShow)
        elseif __eClassType_BladeMasterWoman == classType and true == PaGlobal_ClassResource_CanMeahwaIconEnable() then
          panelControl[idx].control:SetShow(panelControl[idx].isShow)
        end
      end
    elseif idx == panelID.ActionGuide then
      setShowSkillCmd(panelControl[idx].isShow)
      if true == _ContentsGroup_NewUI_GameOption_All then
        PaGlobal_GameOption_All_SetSkillCommandPanel(panelControl[idx].isShow)
      else
        isChecked_SkillCommand = panelControl[idx].isShow
      end
      panelControl[idx].control:SetShow(panelControl[idx].isShow)
      GameOption_UpdateOptionChanged()
      FGlobal_SkillCommand_Show(panelControl[idx].isShow)
    elseif idx == panelID.KeyGuide then
      if true == panelControl[idx].isShow then
        FGlobal_KeyViewer_Show()
      else
        FGlobal_KeyViewer_Hide()
      end
      isChecked_KeyViewer = panelControl[idx].isShow
      GameOption_UpdateOptionChanged()
    elseif idx == panelID.UIMain then
      if true == _ContentsGroup_RenewUI_Main then
        panelControl[idx].control:SetShow(false)
      else
        panelControl[idx].control:SetShow(panelControl[idx].isShow)
      end
    elseif idx >= panelID.NewQuickSlot0 and idx <= panelID.NewQuickSlot19 then
      if false == panelControl[idx].isShow and isUseNewQuickSlot then
        quickSlot_Clear(idx - panelID.NewQuickSlot0)
      end
      panelControl[idx].control:SetShow(panelControl[idx].isShow)
    elseif idx >= panelID.SkillCoolTimeQuickSlot0 and idx <= panelID.SkillCoolTimeQuickSlot9 then
      panelControl[idx].control:SetPosX(controlPosX)
      panelControl[idx].control:SetPosY(controlPosY)
      panelControl[idx].control:SetShow(panelControl[idx].isShow)
    elseif idx == panelID.AreaOfHadum then
      if true == _ContentsGroup_AreaOfHadum then
        panelControl[idx].control:SetShow(panelControl[idx].isShow)
      else
        panelControl[idx].control:SetShow(false)
      end
    elseif idx == panelID.Stamina then
      panelControl[idx].control:SetShow(true)
      panelControl[idx].control:SetPosX(controlPosX)
      panelControl[idx].control:SetPosY(controlPosY)
    else
      panelControl[idx].control:SetShow(panelControl[idx].isShow)
    end
  end
  PaGlobal_UIModify:checkOldMainStatus()
  ToClient_SaveUiInfo(true)
  return scale
end
function PaGlobal_UIModify:getLuaCacheDataIndex(presetIndex)
  local remasterUIIndex = 0
  if 0 == presetIndex then
    remasterUIIndex = __eSwapRemasterUISettingPreset0
  elseif 1 == presetIndex then
    remasterUIIndex = __eSwapRemasterUISettingPreset1
  elseif 2 == presetIndex then
    remasterUIIndex = __eSwapRemasterUISettingPreset2
  elseif 3 == presetIndex then
    remasterUIIndex = __eSwapRemasterUISettingRevert
  end
  return remasterUIIndex
end
function PaGlobal_UIModify:getLuaCacheDataIndexSwapRadar(presetIndex)
  local swapRadarIndex = 0
  if 0 == presetIndex then
    swapRadarIndex = __eRadarSwapPreset0
  elseif 1 == presetIndex then
    swapRadarIndex = __eRadarSwapPreset1
  elseif 2 == presetIndex then
    swapRadarIndex = __eRadarSwapPreset2
  elseif 3 == presetIndex then
    swapRadarIndex = __eRadarSwapPresetRevert
  end
  return swapRadarIndex
end
function PaGlobal_UIModify:savePresetInfo(presetIndex)
  local currentScreenSize = {
    x = getScreenSizeX(),
    y = getScreenSizeY()
  }
  for idx = 1, self._panelCount do
    local slot = self._panelPool[idx].control
    local controlPos = float2()
    controlPos.x = slot:GetPosX()
    controlPos.y = slot:GetPosY()
    local rateX = controlPos.x + slot:GetSizeX() / 2
    local rateY = controlPos.y + slot:GetSizeY() / 2
    local relativePos = float2()
    relativePos.x = rateX / currentScreenSize.x
    relativePos.y = rateY / currentScreenSize.y
    local isShow = self._panelControl[idx].isShow
    local controlShowToggle = self._panelPool[idx].close:IsCheck()
    local uiType = self._panelControl[idx].PAGameUIType
    local chatWindowIndex = 0
    if idx >= self._panelID.Chat0 and idx <= self._panelID.Chat4 then
      chatWindowIndex = idx - self._panelID.Chat0
      local chatPanel = ToClient_getChattingPanel(chatWindowIndex)
      local chatPanelSize = float2()
      chatPanelSize.x = chatPanel:getPanelSizeX()
      chatPanelSize.y = chatPanel:getPanelSizeY()
      ToClient_setUISettingChattingPanelInfo(presetIndex, chatWindowIndex, chatPanel:isOpen(), chatPanel:isCombinedToMainPanel(), uiType, controlPos, controlShowToggle, relativePos, chatPanelSize, setUISettingChattingPanelInfo)
      ToClient_setUISettingChattingOption(presetIndex, chatWindowIndex, Chatting_getUsedSmoothChattingUp())
    end
    ToClient_setUISettingPanelInfo(uiType, controlPos.x, controlPos.y, controlShowToggle, chatWindowIndex, relativePos.x, relativePos.y)
  end
  ToClient_getGameUIManagerWrapper():saveUISettingPresetInfo(presetIndex)
  ToClient_getGameUIManagerWrapper():saveUISettingChattingPresetInfo(presetIndex)
  HandleClicked_UiSet_ConfirmSetting(__eUISetting_Revert == presetIndex)
  ToClient_getGameUIManagerWrapper():setLuaCacheDataListBool(self:getLuaCacheDataIndex(presetIndex), not self._ui.chk_remsaterUI:IsCheck(), CppEnums.VariableStorageType.eVariableStorageType_User)
  local swapRadar = ToClient_getGameUIManagerWrapper():getLuaCacheDataListBool(__eRadarSwap)
  ToClient_getGameUIManagerWrapper():setLuaCacheDataListBool(self:getLuaCacheDataIndexSwapRadar(presetIndex), swapRadar, CppEnums.VariableStorageType.eVariableStorageType_User)
end
function PaGlobal_UIModify:applyPresetInfo(presetIndex, isShortcuts)
  if ToClient_getGameUIManagerWrapper():isPresetListEmpty(presetIndex) then
    if __eUISetting_Revert == presetIndex then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_UISETTING_NOMODESETTING"))
    else
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_UISETTING_NOPRESET"))
    end
    return
  end
  if not IsSelfPlayerWaitAction() then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_UI_SETTING_NOTCURRENTACTION_ACK"))
    return
  end
  local isSetRemasterUI = ToClient_getGameUIManagerWrapper():getLuaCacheDataListBool(self:getLuaCacheDataIndex(presetIndex))
  self._prevRemasterUI = self._isShowRemasterUI
  self._isShowRemasterUI = isSetRemasterUI
  self._ui.chk_remsaterUI:SetCheck(not isSetRemasterUI)
  local swapRadarPreset = ToClient_getGameUIManagerWrapper():getLuaCacheDataListBool(self:getLuaCacheDataIndexSwapRadar(presetIndex))
  local currentswapRadar = ToClient_getGameUIManagerWrapper():getLuaCacheDataListBool(__eRadarSwap)
  if swapRadarPreset ~= currentswapRadar then
    PaGlobal_changeRadarUI()
    FGlobal_ResetTimeBar()
  end
  for idx = 1, self._panelCount do
    local chatWindowIndex = 0
    if idx >= self._panelID.Chat0 and idx <= self._panelID.Chat4 then
      chatWindowIndex = idx - self._panelID.Chat0
      ToClient_getUISettingChattingPanelInfo(presetIndex, chatWindowIndex)
    end
    ToClient_getUISettingPanelInfo(presetIndex, idx, self._panelControl[idx].PAGameUIType, chatWindowIndex)
  end
  ToClient_getGameUIManagerWrapper():setLuaCacheDataListBool(__eSwapRemasterUISetting, self._isShowRemasterUI, CppEnums.VariableStorageType.eVariableStorageType_User)
  FromClient_MainStatus_SwapUIOption(self._isShowRemasterUI)
  self:update()
  self:confrimSetting_Sub(false)
  ToClient_CopyEditUiInfo()
  FGlobal_PackageIconUpdate()
  if __eUISetting_Revert == presetIndex then
    HandleClicked_UiSet_ConfirmSetting(isShortcuts)
  end
end
function PaGlobal_UIModify:applyDefaultSet(isShortcuts, isReplay)
  local isUseMode = ToClient_getGameUIManagerWrapper():getLuaCacheDataListBool(__eUiSetting_useMode)
  if false == isUseMode then
    HandleLUp_SavePresetInfo(__eUISetting_Revert)
  end
  local hideControl = {
    self._panelID.ServantIcon,
    self._panelID.Quest,
    self._panelID.Chat0,
    self._panelID.Chat1,
    self._panelID.Chat2,
    self._panelID.Chat3,
    self._panelID.Chat4,
    self._panelID.GameTip,
    self._panelID.UIMain,
    self._panelID.House,
    self._panelID.NewEquip,
    self._panelID.ActionGuide,
    self._panelID.KeyGuide,
    self._panelID.MainQuest,
    self._panelID.ServantIconRemaster,
    self._panelID.LeftIcon,
    self._panelID.RightIcon
  }
  for _, v in pairs(hideControl) do
    if true == self._panelControl[v].isShow then
      HandleEventLUp_UiSet_ControlShowToggle(v)
    end
  end
  if true == _ContentsGroup_NewUI_GameOption_All then
    PaGlobal_GameOption_All_SetSkillCommandPanel(false)
  else
    isChecked_SkillCommand = false
  end
  if false == self._ui.chk_remsaterUI:IsCheck() then
    self._ui.chk_remsaterUI:SetCheck(true)
    HandleEventLUp_UiSet_SwapRemasterUI()
  end
  if true == self._panelControl[self._panelID.ExpGage].isShow then
    HandleEventLUp_UiSet_ControlShowToggle(self._panelID.ExpGage)
  end
  if true == self._panelControl[self._panelID.Radar].isShow then
    HandleEventLUp_UiSet_ControlShowToggle(self._panelID.Radar)
  end
  if true == self._panelControl[self._panelID.TimeBar].isShow then
    HandleEventLUp_UiSet_ControlShowToggle(self._panelID.TimeBar)
  end
  HandleClicked_UiSet_ConfirmSetting(isShortcuts)
  ToClient_getGameUIManagerWrapper():setLuaCacheDataListBool(__eUiSetting_useMode, true, CppEnums.VariableStorageType.eVariableStorageType_User)
  if true ~= isReplay then
    local messageBoxTitle = PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_ALERT_NOTIFICATIONS")
    local messageBoxMemo = PAGetString(Defines.StringSheet_GAME, "LUA_UISETTING_MSGBOX_BATTLEMODE")
    local messageBoxData = {
      title = messageBoxTitle,
      content = messageBoxMemo,
      functionYes = MessageBox_Empty_function,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageBoxData)
  end
end
function PaGlobal_UIModify:getUiSettingPanelInfo(panelIndex, posX, posY, isShow, chatWindowIndex, relativePosX, relativePosY)
  if self._panelControl[panelIndex].posFixed == false then
    self._panelPool[panelIndex].control:SetPosX(posX)
    self._panelPool[panelIndex].control:SetPosY(posY)
    self._panelPool[panelIndex].control:SetRelativePosX(relativePosX)
    self._panelPool[panelIndex].control:SetRelativePosY(relativePosY)
    self._panelControl[panelIndex].control:SetPosX(posX)
    self._panelControl[panelIndex].control:SetPosY(posY)
    self._panelControl[panelIndex].control:SetRelativePosX(relativePosX)
    self._panelControl[panelIndex].control:SetRelativePosY(relativePosY)
    self._panelControl[panelIndex].isChange = true
  else
    self._panelControl[panelIndex].isChange = false
  end
  self._panelPool[panelIndex].control:SetShow(isShow)
  self._panelControl[panelIndex].control:SetShow(isShow)
  if true == _ContentsGroup_RenewUI_Main then
    self._panelControl[panelID.UIMain].control:SetShow(false)
  end
  if self._closeEmptyPanelState[panelIndex - self._panelID.Chat0] == false then
    self._panelControl[panelIndex].control:SetShow(isShow)
  end
  if false == _ContentsGroup_RenewUI and panelIndex == self._panelID.GameTip then
    Panel_GameTipMask:SetShow(isShow)
  end
  if self._panelPool[panelIndex].close:IsCheck() ~= isShow then
    if panelIndex == self._panelID.ActionGuide then
      if true == _ContentsGroup_NewUI_GameOption_All then
        PaGlobal_GameOption_All_SetSkillCommandPanel(isShow)
      else
        isChecked_SkillCommand = isShow
      end
    end
    if panelIndex ~= self._panelID.House and panelIndex ~= self._panelID.NewEquip and panelIndex ~= self._panelID.Party and panelIndex ~= self._panelID.QuickSlot and panelIndex ~= self._panelID.Adrenallin and panelIndex ~= self._panelID.LargeParty then
      HandleEventLUp_UiSet_ControlShowToggle(panelIndex)
    end
  end
end
function PaGlobal_UIModify:changePanelBGTexture(idx, state)
  local control = self._panelPool[idx].control
  control:ChangeTextureInfoName("combine/etc/combine_etc_uicontrolpanel.dds")
  local x1, y1, x2, y2 = setTextureUV_Func(control, self._BG_Texture[state][1], self._BG_Texture[state][2], self._BG_Texture[state][3], self._BG_Texture[state][4])
  control:getBaseTexture():setUV(x1, y1, x2, y2)
  control:setRenderTexture(control:getBaseTexture())
end
function PaGlobal_UIModify:updatePanelPool(isRemasterSwap)
  for idx = 1, self._panelCount do
    local slot = self._panelPool[idx]
    if nil ~= slot and nil ~= slot.control then
      slot.control:SetScale(1, 1)
      slot.control:SetShow(true)
      if idx == self._panelID.LargeParty and false == _ContentsGroup_LargeParty then
        slot.control:SetShow(false)
      end
      local originalControl = self._panelControl[idx].control
      if true ~= isRemasterSwap then
        slot.originPosX = originalControl:GetPosX()
        slot.originPosY = originalControl:GetPosY()
        slot.originSizeX = originalControl:GetSizeX()
        slot.originSizeY = originalControl:GetSizeY()
        slot.control:SetPosX(slot.originPosX)
        slot.control:SetPosY(slot.originPosY)
        slot.control:SetSize(slot.originSizeX, slot.originSizeY)
      end
      slot.close:SetScale(1, 1)
      slot.close:SetShow(false == self._panelControl[idx].showFixed)
      slot.close:SetPosX(slot.control:GetSizeX() - slot.close:GetSizeX() - 3)
      slot.close:SetPosY(3)
      slot.close:SetCheck(self._panelControl[idx].isShow)
      if idx >= self._panelID.Chat0 and idx <= self._panelID.Chat4 then
        local chatPanel = ToClient_getChattingPanel(idx - self._panelID.Chat0)
        if chatPanel:isOpen() then
          if idx == self._panelID.Chat0 then
            slot.control:SetShow(true)
            slot.close:SetShow(true)
          elseif chatPanel:isCombinedToMainPanel() then
            slot.control:SetShow(false)
            slot.close:SetShow(false)
          else
            slot.control:SetShow(true)
            slot.close:SetShow(true)
          end
        elseif chatPanel:isCombinedToMainPanel() == false or idx == self._panelID.Chat0 then
          slot.control:SetShow(true)
          slot.close:SetShow(true)
        else
          slot.control:SetShow(false)
          slot.close:SetShow(false)
        end
      elseif idx == self._panelID.ClassResource then
        local getClassType = getSelfPlayer():getClassType()
        if __eClassType_Sorcerer == getClassType or __eClassType_Combattant == getClassType or __eClassType_Mystic == getClassType or __eClassType_ShyWaman == getClassType or __eClassType_BladeMasterWoman == getClassType then
          slot.control:SetShow(not self._isShowRemasterUI)
          slot.close:SetShow(not self._isShowRemasterUI)
          self._panelControl[pID].isShow = not self._isShowRemasterUI
          if false == PaGlobal_ClassResource_CanMeahwaIconEnable() and __eClassType_BladeMasterWoman == getClassType then
            slot.control:SetShow(false)
            slot.close:SetShow(false)
            self._panelControl[pID].isShow = false
          end
          if __eClassType_Combattant == getClassType or __eClassType_Mystic == getClassType then
            self._panelControl[self._panelID.ClassResource].name = PAGetString(Defines.StringSheet_GAME, "LUA_CLASSRESOURCE_FIGHTERTITLE")
          elseif __eClassType_ShyWaman == getClassType then
            self._panelControl[self._panelID.ClassResource].name = PAGetString(Defines.StringSheet_GAME, "LUA_CLASSRESOURCE_SHY_NAME")
          elseif __eClassType_BladeMasterWoman == getClassType then
            self._panelControl[self._panelID.ClassResource].name = PAGetString(Defines.StringSheet_GAME, "LUA_CLASSRESOURCE_MAEHAW_NAME")
          end
          slot.close:ComputePos()
        else
          slot.control:SetShow(false)
          slot.close:SetShow(false)
          self._panelControl[pID].isShow = false
        end
      elseif idx == self._panelID.ActionGuide then
        local isCheckSkillCommand = FGlobal_IsChecked_SkillCommand()
        if true == isCheckSkillCommand then
          self:changePanelBGTexture(idx, 2)
        else
          self:changePanelBGTexture(idx, 1)
        end
        slot.close:SetCheck(isCheckSkillCommand)
        self._panelControl[idx].isShow = isCheckSkillCommand
      elseif idx == self._panelID.KeyGuide then
        if true == isChecked_KeyViewer then
          self:changePanelBGTexture(idx, 2)
        else
          self:changePanelBGTexture(idx, 1)
        end
      elseif idx == self._panelID.Adrenallin then
        if getSelfPlayer():isEnableAdrenalin() then
          slot.control:SetShow(not self._isShowRemasterUI)
          slot.close:SetShow(not self._isShowRemasterUI)
          self._panelControl[pID].isShow = not self._isShowRemasterUI
        else
          slot.control:SetShow(false)
          slot.close:SetShow(false)
          self._panelControl[pID].isShow = false
        end
      elseif idx == self._panelID.Pvp then
        if isPvpEnable() and true == ToClient_isAdultUser() then
          slot.control:SetShow(not self._isShowRemasterUI)
          slot.close:SetShow(not self._isShowRemasterUI)
          self._panelControl[pID].isShow = not self._isShowRemasterUI
        else
          slot.control:SetShow(false)
          slot.close:SetShow(false)
          self._panelControl[pID].isShow = false
        end
      elseif idx == self._panelID.UIMain then
        if true == _ContentsGroup_RenewUI_Main then
          slot.control:SetShow(false)
        end
      elseif idx == self._panelID.AreaOfHadum and false == _ContentsGroup_AreaOfHadum then
        slot.control:SetShow(false)
        slot.close:SetShow(false)
      end
      if self._panelControl[idx].isShow then
        if self._panelControl[idx].posFixed then
          slot.control:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_UI_SETTING_SLOTCONTROL_IMPOSSIBLE", "name", self._panelControl[idx].name))
        else
          slot.control:SetText(self._panelControl[idx].name)
        end
      elseif 21 == idx then
        slot.control:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_UISETTING_SKILLGUIDE_EXTRA"))
      else
        slot.control:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_UI_SETTING_SLOTCONTROL_OFF", "name", self._panelControl[idx].name))
      end
      local stateValue = 0
      if not self._panelControl[idx].isShow then
        stateValue = 1
      elseif self._panelControl[idx].posFixed then
        stateValue = 3
      else
        stateValue = 2
      end
      self:changePanelBGTexture(idx, stateValue)
      if true == _ContentsGroup_RemasterUI_Main then
        if idx == self._panelID.House or idx == self._panelID.NewEquip or idx == self._panelID.ServantIcon then
          slot.control:SetShow(false)
        elseif idx == self._panelID.ExpGage or idx == self._panelID.HPBar then
          slot.control:SetShow(not self._isShowRemasterUI)
          slot.close:SetShow(not self._isShowRemasterUI)
          self._panelControl[pID].isShow = not self._isShowRemasterUI
        elseif idx == self._panelID.MainStatusRemaster then
          slot.control:SetShow(self._isShowRemasterUI)
          slot.close:SetShow(self._isShowRemasterUI)
          self._panelControl[pID].isShow = self._isShowRemasterUI
        end
      end
    end
  end
end
function PaGlobal_UIModify:changePanelPoolScale(scale)
  local screensizeX = getScreenSizeX()
  local screensizeY = getScreenSizeY()
  for idx = 1, self._panelCount do
    local slot = self._panelPool[idx]
    local parentsPosX = self._cachePosX[idx]
    if nil == parentsPosX then
      parentsPosX = slot.originPosX
    end
    local parentsPosY = self._cachePosY[idx]
    if nil == parentsPosY then
      parentsPosY = slot.originPosY
    end
    local sizeX = self._cacheSizeX[idx]
    if nil == sizeX then
      sizeX = slot.originSizeX
    end
    local sizeY = self._cacheSizeY[idx]
    if nil == sizeY then
      sizeY = slot.originSizeY
    end
    local preScale = self._cachePreScale[idx]
    if nil == preScale then
      preScale = self.preScale
    end
    local rateX = parentsPosX / (screensizeX - sizeX)
    local rateY = parentsPosY / (screensizeY - sizeY)
    slot.control:SetSize(sizeX * (1 / preScale) * scale, sizeY * (1 / preScale) * scale)
    if idx == self._panelID.ExpGage then
      slot.control:SetHorizonLeft()
      slot.control:SetVerticalTop()
    elseif idx == self._panelID.Radar then
      slot.control:SetHorizonRight()
      slot.control:SetVerticalTop()
      slot.control:SetSpanSize(0, 20)
    elseif idx == self._panelID.GameTip then
      slot.control:SetHorizonLeft()
      slot.control:SetVerticalBottom()
    elseif idx == self._panelID.UIMain then
      slot.control:SetHorizonRight()
      slot.control:SetVerticalBottom()
    else
      slot.control:SetPosX(parentsPosX + rateX * sizeX - rateX * slot.control:GetSizeX())
      slot.control:SetPosY(parentsPosY + rateY * sizeY - rateY * slot.control:GetSizeY())
    end
    slot.control:ComputePos()
    slot.close:ComputePos()
  end
end
function PaGlobal_UIModify:updateModifyPanelSize()
  local isCollapseCkeck = PaGlobal_UIModify._ui.chk_Collapse:IsCheck()
  self._ui.main_BG:SetShow(not isCollapseCkeck)
  self._ui.sub_BG:SetShow(not isCollapseCkeck)
  self._ui.desc_BG:SetShow(not isCollapseCkeck)
  self._ui.btn_save:SetShow(not isCollapseCkeck)
  self._ui.btn_reset:SetShow(not isCollapseCkeck)
  if isCollapseCkeck then
    self._ui.panelBG:SetSize(self._ui.panelBG:GetSizeX(), self._ui.titleBG:GetSizeY())
    Panel_Window_UIModify_All:ComputePos()
  else
    local prevSizeY = self._ui.desc_BG:GetSizeY()
    local deffSizeY = 0
    self._ui.desc_BG:SetSize(self._ui.desc_BG:GetSizeX(), self._ui.txt_Desc:GetTextSizeY() + 10)
    self._ui.txt_Desc:ComputePos()
    deffSizeY = self._ui.desc_BG:GetSizeY() - prevSizeY
    self._ui.main_BG:SetSize(self._ui.main_BG:GetSizeX(), self._ui.main_BG:GetSizeY() + deffSizeY)
    self._ui.main_BG:ComputePos()
    self._ui.btn_save:SetPosY(self._ui.btn_save:GetPosY() + deffSizeY)
    self._ui.btn_reset:SetPosY(self._ui.btn_reset:GetPosY() + deffSizeY)
    self._ui.panelBG:SetSize(self._ui.panelBG:GetSizeX(), self._ui.main_BG:GetSizeY() + self._ui.titleBG:GetSizeY())
    Panel_Window_UIModify_All:ComputePos()
  end
end
function PaGlobal_UIModify:showCollapseTooltip()
  local desc = PAGetString(Defines.StringSheet_GAME, "LUA_UIMODIFYCOLLAPSE_TOOLTIP_DESC")
  TooltipSimple_Show(self._ui.chk_Collapse, "", desc)
end
