local _panel = Panel_Worldmap_GuildHouseManagement
Panel_Worldmap_GuildHouseManagement:ignorePadSnapMoveToOtherPanel()
local eHouseUseGroupType = CppEnums.eHouseUseType
local isContentsEnable = ToClient_IsContentsGroupOpen("36")
local VCK = CppEnums.VirtualKeyCode
local guildHouse_Img = {
  [2110] = "icon/new_icon/03_etc/06_housing/2110.dds",
  [2140] = "icon/new_icon/03_etc/06_housing/2140.dds",
  [2183] = "icon/new_icon/03_etc/06_housing/2183.dds",
  [2188] = "icon/new_icon/03_etc/06_housing/2188.dds",
  [2228] = "icon/new_icon/03_etc/06_housing/2228.dds",
  [2427] = "icon/new_icon/03_etc/06_housing/2427.dds",
  [2503] = "icon/new_icon/03_etc/06_housing/2503.dds",
  [2569] = "icon/new_icon/03_etc/06_housing/2569.dds",
  [2608] = "icon/new_icon/03_etc/06_housing/2608.dds",
  [2647] = "icon/new_icon/03_etc/06_housing/2647.dds",
  [2691] = "icon/new_icon/03_etc/06_housing/2691.dds",
  [2704] = "icon/new_icon/03_etc/06_housing/2704.dds",
  [2858] = "icon/new_icon/03_etc/06_housing/2858.dds",
  [2880] = "icon/new_icon/03_etc/06_housing/2880.dds",
  [2905] = "icon/new_icon/03_etc/06_housing/2905.dds",
  [3351] = "icon/new_icon/03_etc/06_housing/3351.dds",
  [3352] = "icon/new_icon/03_etc/06_housing/3352.dds",
  [3353] = "icon/new_icon/03_etc/06_housing/3353.dds",
  [3354] = "icon/new_icon/03_etc/06_housing/3354.dds",
  [3355] = "icon/new_icon/03_etc/06_housing/3355.dds",
  [3356] = "icon/new_icon/03_etc/06_housing/3356.dds",
  [3357] = "icon/new_icon/03_etc/06_housing/3357.dds",
  [3358] = "icon/new_icon/03_etc/06_housing/3358.dds"
}
local WorldMapGuildHouseManager = {
  _ui = {
    stc_BG = nil,
    stc_KeyGudideBg = nil,
    txt_title = nil,
    stc_tipBG = nil,
    stc_tipUsageIcon = nil,
    txt_tipIcon = nil,
    txt_tipDesc = nil,
    stc_typeBG = nil,
    frame_houseType = nil,
    stc_houseTypeContentBG = nil,
    rdo_houseTypeTemplate = nil,
    rdo_houseTypes = nil,
    stc_stars = nil,
    txt_detailTitle = nil,
    stc_line = nil,
    txt_descriptions = nil,
    stc_itemSlotBG = nil,
    stc_detailBG = nil,
    scroll_detailList = nil,
    itemSlots = {},
    txt_manage = nil,
    stc_manageBG = nil,
    stc_houseImage = nil,
    chk_buyOrSell = nil
  },
  _houseKey = nil,
  _isPurchasable = nil,
  _needExplorePoint = nil,
  _isSet = nil,
  _receipeCount = nil,
  _houseName = nil,
  _useTypeData = {},
  _starCountMax = 5,
  _houseTypeMax = 8,
  _listDefaultYGap = 37,
  _listStartY = 4,
  _detailListData = {},
  _detailListScrollAmount = 0,
  _detailListRowMax = 3,
  _receipeIconColumnMax = 6,
  _receipeIconCountMax = 18,
  _receipeIconDefaultGap = 50,
  _purposeFliterUVConfig = {
    [0] = {
      x1 = 57,
      y1 = 319,
      x2 = 84,
      y2 = 346
    },
    [1] = {
      x1 = 85,
      y1 = 319,
      x2 = 112,
      y2 = 346
    },
    [2] = {
      x1 = 29,
      y1 = 319,
      x2 = 56,
      y2 = 346
    },
    [3] = {
      x1 = 337,
      y1 = 319,
      x2 = 364,
      y2 = 346
    },
    [4] = {
      x1 = 29,
      y1 = 347,
      x2 = 56,
      y2 = 374
    },
    [5] = {
      x1 = 57,
      y1 = 347,
      x2 = 84,
      y2 = 374
    },
    [6] = {
      x1 = 85,
      y1 = 347,
      x2 = 112,
      y2 = 374
    },
    [7] = {
      x1 = 113,
      y1 = 347,
      x2 = 140,
      y2 = 374
    },
    [8] = {
      x1 = 309,
      y1 = 347,
      x2 = 336,
      y2 = 374
    },
    [9] = {
      x1 = 141,
      y1 = 347,
      x2 = 168,
      y2 = 374
    },
    [10] = {
      x1 = 113,
      y1 = 319,
      x2 = 140,
      y2 = 346
    },
    [11] = {
      x1 = 309,
      y1 = 347,
      x2 = 336,
      y2 = 374
    },
    [12] = {
      x1 = 309,
      y1 = 319,
      x2 = 336,
      y2 = 346
    },
    [13] = {
      x1 = 337,
      y1 = 347,
      x2 = 364,
      y2 = 374
    },
    [14] = {
      x1 = 309,
      y1 = 319,
      x2 = 336,
      y2 = 346
    },
    [15] = {
      x1 = 197,
      y1 = 347,
      x2 = 224,
      y2 = 374
    },
    [18] = {
      x1 = 281,
      y1 = 319,
      x2 = 308,
      y2 = 346
    },
    [19] = {
      x1 = 1,
      y1 = 347,
      x2 = 28,
      y2 = 374
    },
    [20] = {
      x1 = 253,
      y1 = 347,
      x2 = 280,
      y2 = 374
    },
    [21] = {
      x1 = 225,
      y1 = 347,
      x2 = 252,
      y2 = 374
    },
    [23] = {
      x1 = 85,
      y1 = 347,
      x2 = 112,
      y2 = 374
    },
    [24] = {
      x1 = 1,
      y1 = 319,
      x2 = 28,
      y2 = 346
    },
    [16] = {
      x1 = 141,
      y1 = 347,
      x2 = 168,
      y2 = 374
    },
    [17] = {
      x1 = 0,
      y1 = 0,
      x2 = 0,
      y2 = 0
    },
    [22] = {
      x1 = 0,
      y1 = 0,
      x2 = 0,
      y2 = 0
    }
  },
  _purposeFilterUVConfigForOther = {
    [22] = {
      x1 = 141,
      y1 = 347,
      x2 = 168,
      y2 = 374
    },
    [23] = {
      x1 = 141,
      y1 = 347,
      x2 = 168,
      y2 = 374
    },
    [24] = {
      x1 = 141,
      y1 = 347,
      x2 = 168,
      y2 = 374
    },
    [26] = {
      x1 = 141,
      y1 = 347,
      x2 = 168,
      y2 = 374
    },
    [27] = {
      x1 = 141,
      y1 = 347,
      x2 = 168,
      y2 = 374
    },
    [1401] = {
      x1 = 169,
      y1 = 347,
      x2 = 196,
      y2 = 374
    },
    [1402] = {
      x1 = 169,
      y1 = 347,
      x2 = 196,
      y2 = 374
    },
    [1403] = {
      x1 = 169,
      y1 = 347,
      x2 = 196,
      y2 = 374
    },
    [1404] = {
      x1 = 169,
      y1 = 347,
      x2 = 196,
      y2 = 374
    },
    [1405] = {
      x1 = 169,
      y1 = 347,
      x2 = 196,
      y2 = 374
    },
    [1406] = {
      x1 = 169,
      y1 = 347,
      x2 = 196,
      y2 = 374
    },
    [1501] = {
      x1 = 197,
      y1 = 319,
      x2 = 224,
      y2 = 346
    },
    [1504] = {
      x1 = 197,
      y1 = 319,
      x2 = 224,
      y2 = 346
    },
    [1507] = {
      x1 = 197,
      y1 = 319,
      x2 = 224,
      y2 = 346
    },
    [1510] = {
      x1 = 197,
      y1 = 319,
      x2 = 224,
      y2 = 346
    },
    [1513] = {
      x1 = 197,
      y1 = 319,
      x2 = 224,
      y2 = 346
    },
    [1516] = {
      x1 = 197,
      y1 = 319,
      x2 = 224,
      y2 = 346
    },
    [1502] = {
      x1 = 225,
      y1 = 319,
      x2 = 252,
      y2 = 346
    },
    [1505] = {
      x1 = 225,
      y1 = 319,
      x2 = 252,
      y2 = 346
    },
    [1508] = {
      x1 = 225,
      y1 = 319,
      x2 = 252,
      y2 = 346
    },
    [1511] = {
      x1 = 225,
      y1 = 319,
      x2 = 252,
      y2 = 346
    },
    [1514] = {
      x1 = 225,
      y1 = 319,
      x2 = 252,
      y2 = 346
    },
    [1517] = {
      x1 = 225,
      y1 = 319,
      x2 = 252,
      y2 = 346
    },
    [1503] = {
      x1 = 253,
      y1 = 319,
      x2 = 280,
      y2 = 346
    },
    [1506] = {
      x1 = 253,
      y1 = 319,
      x2 = 280,
      y2 = 346
    },
    [1509] = {
      x1 = 253,
      y1 = 319,
      x2 = 280,
      y2 = 346
    },
    [1512] = {
      x1 = 253,
      y1 = 319,
      x2 = 280,
      y2 = 346
    },
    [1515] = {
      x1 = 253,
      y1 = 319,
      x2 = 280,
      y2 = 346
    },
    [1518] = {
      x1 = 253,
      y1 = 319,
      x2 = 280,
      y2 = 346
    },
    [1551] = {
      x1 = 141,
      y1 = 319,
      x2 = 168,
      y2 = 346
    },
    [1553] = {
      x1 = 141,
      y1 = 319,
      x2 = 168,
      y2 = 346
    },
    [1552] = {
      x1 = 169,
      y1 = 319,
      x2 = 196,
      y2 = 346
    },
    [1554] = {
      x1 = 169,
      y1 = 319,
      x2 = 196,
      y2 = 346
    }
  },
  _currentSlotInfo = {
    _slotIndex = 0,
    _index = 0,
    _itemIndex = 0
  },
  _currentTooltipSlot = -1,
  _ownerGuildNoRaw = nil,
  _isMyGuildHouse = false,
  _currentHouseButton = nil,
  _keyGuideAlign = {}
}
local _slotOption = {createIcon = true}
local _starUV = {
  full = {
    248,
    24,
    269,
    45
  },
  empty = {
    248,
    2,
    269,
    23
  }
}
function FromClient_luaLoadComplete_WorldMapGuildHouseManager()
  WorldMapGuildHouseManager:initialize()
end
registerEvent("FromClient_luaLoadComplete", "FromClient_luaLoadComplete_WorldMapGuildHouseManager")
function WorldMapGuildHouseManager:initialize()
  self._ui.stc_BG = UI.getChildControl(_panel, "Static_BG_House")
  self._ui.txt_title = UI.getChildControl(self._ui.stc_BG, "StaticText_Title")
  self._ui.stc_tipBG = UI.getChildControl(self._ui.stc_BG, "Static_Tip")
  self._ui.txt_tipIcon = UI.getChildControl(self._ui.stc_tipBG, "StaticText_Icon")
  self._ui.stc_tipUsageIcon = UI.getChildControl(self._ui.stc_tipBG, "Static_UsageIcon")
  self._ui.txt_tipIcon:SetColor(Defines.Color.C_FF000000)
  self._originalTextSpanY = self._ui.txt_tipIcon:GetTextSpan().y
  self._ui.txt_tipDesc = UI.getChildControl(self._ui.stc_tipBG, "StaticText_Desc")
  self._ui.txt_tipDesc:SetTextMode(__eTextMode_AutoWrap)
  self._ui.txt_tipDesc:SetText(self._ui.txt_tipDesc:GetText())
  self._ui.txt_tipIcon:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_GRAND_GUILDCRAFT_GUILDHOUSE_TITLE"))
  self._ui.txt_tipDesc:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_GRAND_GUILDCRAFT_GUILDHOUSE_DESC"))
  self._ui.stc_typeBG = UI.getChildControl(self._ui.stc_BG, "Static_Type")
  self._ui.frame_houseType = UI.getChildControl(self._ui.stc_typeBG, "Frame_HouseType")
  local frameContent = self._ui.frame_houseType:GetFrameContent()
  self._ui.stc_houseTypeContentBG = UI.getChildControl(frameContent, "Static_ContentBG")
  self._ui.rdo_houseTypes = {}
  for ii = 1, self._houseTypeMax do
    self._ui.rdo_houseTypes[ii] = UI.getChildControl(frameContent, "RadioButton_Content_" .. ii)
    self._ui.rdo_houseTypes[ii]:SetPosY(self._listStartY + (ii - 1) * self._listDefaultYGap)
    self._ui.rdo_houseTypes[ii]:addInputEvent("Mouse_LUp", "Input_WorldMapGuildHouseManager_SetUseType(" .. ii .. ")")
    self._ui.rdo_houseTypes[ii]:addInputEvent("Mouse_On", "Input_WorldMapGuildHouseManager_SetSelectButton(true)")
    self._ui.rdo_houseTypes[ii]:addInputEvent("Mouse_Out", "Input_WorldMapGuildHouseManager_SetSelectButton(false)")
    self._ui.rdo_houseTypes[ii]:SetShow(false)
  end
  self._ui.stc_stars = {}
  for ii = 1, self._houseTypeMax do
    self._ui.stc_stars[ii] = {}
    for jj = 1, self._starCountMax do
      self._ui.stc_stars[ii][jj] = UI.getChildControl(self._ui.rdo_houseTypes[ii], "Static_Star_" .. jj)
    end
  end
  self._ui.frame_houseType:UpdateContentPos()
  self._ui.frame_houseType:UpdateContentScroll()
  self._ui.stc_houseTypeContentBG:SetSize(frameContent:GetSizeX(), frameContent:GetSizeY())
  self:initDetailList()
  self._ui.stc_manageBG = UI.getChildControl(self._ui.stc_BG, "Static_Manage")
  self._ui.txt_GuildName = UI.getChildControl(self._ui.stc_manageBG, "StaticText_GuildName")
  self._ui.stc_GuildIconBG = UI.getChildControl(self._ui.stc_manageBG, "Static_GuildIconBG")
  self._ui.stc_GuildIcon = UI.getChildControl(self._ui.stc_GuildIconBG, "Static_GuildIcon")
  self._ui.txt_GuildMasterName = UI.getChildControl(self._ui.stc_manageBG, "StaticText_GuildMaster_Value")
  self._ui.txt_GuildMasterName:SetTextMode(__eTextMode_AutoWrap)
  self._ui.stc_houseImage = UI.getChildControl(self._ui.stc_manageBG, "static_House_Image")
  self._ui.stc_KeyGudideBg = UI.getChildControl(_panel, "Static_KeyGuideBg")
  self._ui._static_KeyGuide_Select = UI.getChildControl(self._ui.stc_KeyGudideBg, "StaticText_A_ConsoleUI")
  self._ui._static_KeyGuide_Close = UI.getChildControl(self._ui.stc_KeyGudideBg, "StaticText_B_ConsoleUI")
  self._keyGuideAlign = {
    self._ui._static_KeyGuide_Select,
    self._ui._static_KeyGuide_Close
  }
  PaGlobalFunc_ConsoleKeyGuide_SetAlign(self._keyGuideAlign, self._ui.stc_KeyGudideBg, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHT)
  self:registMessageHandler()
end
function WorldMapGuildHouseManager:initDetailList()
  self._ui.stc_line = UI.getChildControl(self._ui.stc_typeBG, "Static_Line")
  self._ui.stc_detailBG = UI.getChildControl(self._ui.stc_typeBG, "Static_DetailListBG")
  self._ui.txt_detailTitle = UI.getChildControl(self._ui.stc_detailBG, "StaticText_DetailTitle")
  self._ui.txt_detailTitle:SetAutoResize(true)
  self._ui.scroll_detailList = UI.getChildControl(self._ui.stc_detailBG, "Scroll_DetailList")
  self._ui.scroll_ctrlButton = UI.getChildControl(self._ui.scroll_detailList, "Frame_1_VerticalScroll_CtrlButton")
  UIScroll.InputEvent(self._ui.scroll_detailList, "InputScroll_WorldMapGuildHouseManager_DetailList")
  self._ui.txt_descriptions = {}
  local startX, startY = self._ui.stc_line:GetPosX(), self._ui.stc_line:GetPosY() + 25
  for ii = 1, self._detailListRowMax do
    self._ui.txt_descriptions[ii] = UI.createAndCopyBasePropertyControl(self._ui.stc_detailBG, "StaticText_DescTemplete", self._ui.stc_detailBG, "StaticText_DescTemplete_" .. ii)
    self._ui.txt_descriptions[ii]:SetPosX(20)
    self._ui.txt_descriptions[ii]:SetPosY(startY + (ii - 1) * self._receipeIconDefaultGap)
  end
  self._ui.stc_itemSlotBG = {}
  for ii = 1, self._receipeIconCountMax do
    self._ui.stc_itemSlotBG[ii] = UI.createAndCopyBasePropertyControl(self._ui.stc_detailBG, "Static_ItemSlotBgTemplete", self._ui.stc_detailBG, "Static_ItemSlotBgTemplete" .. ii)
    self._ui.stc_itemSlotBG[ii]:SetPosX(20 + (ii - 1) % self._receipeIconColumnMax * self._receipeIconDefaultGap)
    self._ui.stc_itemSlotBG[ii]:SetPosY(startY - 12 + math.floor((ii - 1) / self._receipeIconColumnMax) * self._receipeIconDefaultGap)
  end
end
function WorldMapGuildHouseManager:registMessageHandler()
  registerEvent("FromClient_WorldMapGuildHouseLClick", "FromClient_WorldMapGuildHouseLClick")
end
function PaGlobalFunc_WorldMapGuildHouseManager_SetDetailFocus(isFocus)
  local self = WorldMapGuildHouseManager
  self._ui.scroll_ctrlButton:SetShow(isFocus)
  self._ui._static_KeyGuide_Select:SetShow(not isFocus)
end
function PaGlobalFunc_WorldMapGuildHouseManager_IsShow()
  return _panel:GetShow()
end
function PaGlobalFunc_WorldMapGuildHouseManager_Close()
  local self = WorldMapGuildHouseManager
  PaGlobalFunc_WorldMapGuildHouseManager_HideTooltip()
  PaGlobalFunc_WorldMap_TopMenu_Open()
  PaGlobalFunc_WorldMap_RingMenu_Open()
  _panel:SetShow(false)
end
function WorldMapGuildHouseManager:open(houseInfoSSWrapper)
  self._selected = nil
  self._detailListScrollAmount = 0
  self:update(houseInfoSSWrapper)
  _panel:SetShow(true)
end
function WorldMapGuildHouseManager:update()
  local guildHouseInfoSSWrapper = ToClient_GetGuildHouseInfoStaticStatusWrapper(self._houseKey)
  self._houseName = guildHouseInfoSSWrapper:getHouseName()
  self._ui.txt_title:SetText(self._houseName)
  self:updateHouseImage()
  local stc_stars = {}
  for ii = 1, #self._ui.rdo_houseTypes do
    for jj = 1, self._starCountMax do
      stc_stars[jj] = UI.getChildControl(self._ui.rdo_houseTypes[ii], "Static_Star_" .. jj)
      stc_stars[jj]:ChangeTextureInfoName("renewal/ui_icon/console_icon_worldmap_00.dds")
      local x1, y1, x2, y2 = setTextureUV_Func(stc_stars[jj], _starUV.empty[1], _starUV.empty[2], _starUV.empty[3], _starUV.empty[4])
      stc_stars[jj]:getBaseTexture():setUV(x1, y1, x2, y2)
      stc_stars[jj]:setRenderTexture(stc_stars[jj]:getBaseTexture())
    end
  end
  self._ui.frame_houseType:GetVScroll():SetControlPos(0)
  self._ui.frame_houseType:UpdateContentPos()
  self:updateTypeList()
  self:updateGuildInfo()
  Input_WorldMapGuildHouseManager_SetUseType(self._selected)
end
function WorldMapGuildHouseManager:updateHouseImage()
  if nil ~= guildHouse_Img[self._houseKey] then
    self._ui.stc_houseImage:ChangeTextureInfoName(guildHouse_Img[self._houseKey])
  else
    self._ui.stc_houseImage:ChangeTextureInfoName("icon/new_icon/03_etc/06_housing/1201.dds")
  end
  self._ui.stc_houseImage:setRenderTexture(self._ui.stc_houseImage:getBaseTexture())
end
function WorldMapGuildHouseManager:updateTypeList()
  local guildHouseInfoSSWrapper = ToClient_GetGuildHouseInfoStaticStatusWrapper(self._houseKey)
  if nil == guildHouseInfoSSWrapper then
    return
  end
  local MyGuildHouseCraftInfoManager = getSelfPlayer():getGuildHouseCraftInfoManager()
  local recipeLevelCount = MyGuildHouseCraftInfoManager:getReceipeLevelCount()
  local recipeCount = guildHouseInfoSSWrapper:getReceipeCount()
  local frameContent = self._ui.frame_houseType:GetFrameContent()
  self._receipeCount = recipeLevelCount
  self._useTypeData = {}
  for ii = 1, self._houseTypeMax do
    if nil == self._ui.rdo_houseTypes[ii] then
      self._ui.rdo_houseTypes[ii] = UI.cloneControl(self._ui.rdo_houseTypeTemplate, frameContent, "RadioButton_HouseType_" .. ii)
    end
    local houseInfoCraftWrapper = guildHouseInfoSSWrapper:getHouseCraftWrapperByIndex(ii - 1)
    if nil ~= houseInfoCraftWrapper and CppEnums.eHouseUseType.Depot ~= houseInfoCraftWrapper:getGroupType() then
      local recipeName = houseInfoCraftWrapper:getReciepeName()
      local recipeKeyRaw = houseInfoCraftWrapper:getReceipeKeyRaw()
      local maxLevel = guildHouseInfoSSWrapper:getMaxLevel(recipeKeyRaw)
      local currentLevel = MyGuildHouseCraftInfoManager:getLevel(recipeKeyRaw)
      local groupType = houseInfoCraftWrapper:getGroupType()
      if nil == self._selected then
        self._selected = ii
      end
      self._useTypeData[ii] = {}
      self._useTypeData[ii].receipeKey = recipeKeyRaw
      self._useTypeData[ii].useType = groupType
      self._useTypeData[ii].useTypeDesc = PAGetString(Defines.StringSheet_GAME, "LUA_HOUSECONTROL_USETYPE_DESC_EMPTY")
      if self._useTypeData[ii].useType > -1 then
        self._useTypeData[ii].useTypeDesc = PAGetString(Defines.StringSheet_GAME, "LUA_HOUSECONTROL_USETYPE_DESC_" .. tostring(self._useTypeData[ii].useType))
      end
      self._useTypeData[ii].name = recipeName
      local txt_name = UI.getChildControl(self._ui.rdo_houseTypes[ii], "StaticText_Name")
      txt_name:SetText(self._useTypeData[ii].name)
      txt_name:ChangeTextureInfoName("renewal/ui_icon/console_icon_worldmap_00.dds")
      local x1, y1, x2, y2
      if 17 ~= self._useTypeData[ii].useType and 16 ~= self._useTypeData[ii].useType then
        x1, y1, x2, y2 = setTextureUV_Func(txt_name, WorldMapGuildHouseManager._purposeFliterUVConfig[self._useTypeData[ii].useType].x1, WorldMapGuildHouseManager._purposeFliterUVConfig[self._useTypeData[ii].useType].y1, WorldMapGuildHouseManager._purposeFliterUVConfig[self._useTypeData[ii].useType].x2, WorldMapGuildHouseManager._purposeFliterUVConfig[self._useTypeData[ii].useType].y2)
      else
        x1, y1, x2, y2 = setTextureUV_Func(txt_name, WorldMapGuildHouseManager._purposeFilterUVConfigForOther[self._useTypeData[ii].receipeKey].x1, WorldMapGuildHouseManager._purposeFilterUVConfigForOther[self._useTypeData[ii].receipeKey].y1, WorldMapGuildHouseManager._purposeFilterUVConfigForOther[self._useTypeData[ii].receipeKey].x2, WorldMapGuildHouseManager._purposeFilterUVConfigForOther[self._useTypeData[ii].receipeKey].y2)
      end
      txt_name:getBaseTexture():setUV(x1, y1, x2, y2)
      txt_name:setRenderTexture(txt_name:getBaseTexture())
      self._useTypeData[ii].maxLevel = maxLevel
      for jj = 1, self._starCountMax do
        if currentLevel >= jj then
          local x1, y1, x2, y2 = setTextureUV_Func(self._ui.stc_stars[ii][jj], _starUV.full[1], _starUV.full[2], _starUV.full[3], _starUV.full[4])
          self._ui.stc_stars[ii][jj]:getBaseTexture():setUV(x1, y1, x2, y2)
          self._ui.stc_stars[ii][jj]:setRenderTexture(self._ui.stc_stars[ii][jj]:getBaseTexture())
        end
        if jj <= self._useTypeData[ii].maxLevel then
          self._ui.stc_stars[ii][jj]:SetShow(true)
        else
          self._ui.stc_stars[ii][jj]:SetShow(false)
        end
      end
      self._ui.rdo_houseTypes[ii]:SetShow(true)
    else
      self._ui.rdo_houseTypes[ii]:SetShow(false)
    end
  end
  frameContent:SetSize(frameContent:GetSizeX(), self._receipeCount * (self._ui.rdo_houseTypes[1]:GetSizeY() + self._listStartY))
  self._ui.stc_houseTypeContentBG:SetSize(frameContent:GetSizeX(), frameContent:GetSizeY())
  local scroll = self._ui.frame_houseType:GetVScroll()
  if frameContent:GetSizeY() > self._ui.frame_houseType:GetSizeY() then
    scroll:SetShow(true)
  else
    scroll:SetShow(false)
  end
end
function WorldMapGuildHouseManager:updateGuildInfo()
  local guildHouseInfoSSWrapper = ToClient_getHouseholdInfoInClientWrapper(self._houseKey)
  if nil == guildHouseInfoSSWrapper then
    return
  end
  local ownerGuildNoRaw = guildHouseInfoSSWrapper:getOwnerGuildNo()
  local myGuildWrapper = ToClient_GetMyGuildInfoWrapper()
  local myGuildNoRaw = getSelfPlayer():getGuildNo_s64()
  local guildName = ToClient_guild_getGuildName(ownerGuildNoRaw)
  local guildMasterName = ToClient_guild_getGuildMasterName(ownerGuildNoRaw)
  local markData = getGuildMarkIndexByGuildNoForXBox(ownerGuildNoRaw)
  if nil ~= markData then
    self._ui.stc_GuildIconBG:SetShow(true)
    self._ui.stc_GuildIconBG:ChangeTextureInfoName("renewal/commonicon/guildmark/console_icon_guildmark_00.dds")
    local bgx1, bgy1, bgx2, bgy2 = PaGlobalFunc_GuildMark_GetBackGroundUV(markData:getBackGroundIdx())
    local x1, y1, x2, y2 = setTextureUV_Func(self._ui.stc_GuildIconBG, bgx1, bgy1, bgx2, bgy2)
    self._ui.stc_GuildIconBG:getBaseTexture():setUV(x1, y1, x2, y2)
    self._ui.stc_GuildIconBG:setRenderTexture(self._ui.stc_GuildIconBG:getBaseTexture())
    self._ui.stc_GuildIcon:ChangeTextureInfoName("renewal/commonicon/guildmark/console_icon_guildmark_00.dds")
    local iconx1, icony1, iconx2, icony2 = PaGlobalFunc_GuildMark_GetIconUV(markData:getIconIdx())
    local x1, y1, x2, y2 = setTextureUV_Func(self._ui.stc_GuildIcon, iconx1, icony1, iconx2, icony2)
    self._ui.stc_GuildIcon:getBaseTexture():setUV(x1, y1, x2, y2)
    self._ui.stc_GuildIcon:setRenderTexture(self._ui.stc_GuildIcon:getBaseTexture())
  else
    self._ui.stc_GuildIconBG:SetShow(false)
  end
  self._ui.txt_GuildName:SetText(guildName)
  self._ui.txt_GuildMasterName:SetText(guildMasterName)
  if myGuildNoRaw == ownerGuildNoRaw and nil ~= myGuildWrapper then
    self._isMyGuildHouse = true
  else
    self._isMyGuildHouse = false
  end
end
function WorldMapGuildHouseManager:updateDetailList()
  local guildHouseInfoSSW = ToClient_GetGuildHouseInfoStaticStatusWrapper(self._houseKey)
  self:updateDetailData()
  self._exchangeKeyList = {}
  for ii = 1, #self._ui.txt_descriptions do
    self._ui.txt_descriptions[ii]:SetShow(false)
  end
  for ii = 1, #self._ui.stc_itemSlotBG do
    self._ui.stc_itemSlotBG[ii]:SetShow(false)
  end
  local data = self._detailListData
  for ii = 1, self._detailListRowMax do
    local index = ii + self._detailListScrollAmount
    if nil ~= data[index] then
      if nil ~= data[index].desc then
        self._ui.txt_descriptions[ii]:SetShow(true)
        self._ui.txt_descriptions[ii]:SetTextMode(__eTextMode_AutoWrap)
        self._ui.txt_descriptions[ii]:SetText(data[index].desc)
        for jj = 1, self._receipeIconColumnMax do
          self._ui.stc_itemSlotBG[jj + (ii - 1) * self._receipeIconColumnMax]:SetShow(false)
        end
      elseif nil ~= data[index].itemIndexList then
        local recipeKeyRaw = self._useTypeData[self._selected].receipeKey
        local itemCount = guildHouseInfoSSW:getItemExchangeListCount(recipeKeyRaw, data[index].level)
        for jj = 1, self._receipeIconColumnMax do
          local slotIndex = jj + (ii - 1) * self._receipeIconColumnMax
          local slotBG = self._ui.stc_itemSlotBG[slotIndex]
          slotBG:registerPadEvent(__eConsoleUIPadEvent_DpadUp, "")
          slotBG:registerPadEvent(__eConsoleUIPadEvent_DpadDown, "")
          if 1 == ii then
            slotBG:registerPadEvent(__eConsoleUIPadEvent_DpadUp, "InputScroll_WorldMapGuildHouseManager_DetailList(true)")
          end
          if 2 == ii then
            if nil ~= data[index - 1] and nil ~= data[index - 1].desc then
              slotBG:registerPadEvent(__eConsoleUIPadEvent_DpadUp, "InputScroll_WorldMapGuildHouseManager_DetailList(true)")
            end
            if nil ~= data[index + 1] and nil ~= data[index + 1].desc then
              slotBG:registerPadEvent(__eConsoleUIPadEvent_DpadDown, "InputScroll_WorldMapGuildHouseManager_DetailList(false)")
            end
          end
          if self._detailListRowMax == ii then
            slotBG:registerPadEvent(__eConsoleUIPadEvent_DpadDown, "InputScroll_WorldMapGuildHouseManager_DetailList(false)")
          end
          if nil ~= data[index].itemIndexList[jj] then
            local esSSW = guildHouseInfoSSW:getItemExchangeByIndex(data[index].itemIndexList[jj])
            if nil ~= esSSW and esSSW:isSet() then
              slotBG:SetShow(true)
              local esSS = esSSW:get()
              local workIcon = "icon/" .. esSSW:getIcon()
              local itemStatic = esSS:getFirstDropGroup():getItemStaticStatus()
              local itemKey = esSS:getFirstDropGroup()._itemKey
              local staticStatusWrapper = getItemEnchantStaticStatus(itemKey)
              if nil ~= staticStatusWrapper then
                if nil == self._ui.itemSlots[slotIndex] then
                  self._ui.itemSlots[slotIndex] = {}
                  local slot = self._ui.itemSlots[slotIndex]
                  SlotItem.new(slot, "DetailSlot_" .. slotIndex, slotIndex, slotBG, _slotOption)
                  slot:createChild()
                  UIScroll.InputEventByControl(slot.icon, "InputScroll_WorldMapGuildHouseManager_DetailList")
                  self._exchangeKeyList[slotIndex] = data[index].itemIndexList[jj]
                  self._ui.itemSlots[slotIndex] = slot
                end
                self._ui.itemSlots[slotIndex].icon:addInputEvent("Mouse_On", "PaGlobalFunc_WorldMapGuildHouseManager_ShowTooltip(" .. slotIndex .. "," .. index .. "," .. jj .. ")")
                self._ui.itemSlots[slotIndex].icon:addInputEvent("Mouse_Out", "PaGlobalFunc_WorldMapGuildHouseManager_HideTooltip(" .. slotIndex .. ")")
                self._ui.itemSlots[slotIndex]:setItemByStaticStatus(staticStatusWrapper)
              end
            else
              slotBG:SetShow(false)
            end
          else
            slotBG:SetShow(false)
          end
        end
      end
    end
  end
  if #data <= self._detailListRowMax then
    self._ui.scroll_detailList:SetShow(false)
  else
    self._ui.scroll_detailList:SetShow(true)
  end
end
function PaGlobalFunc_WorldMapGuildHouseManager_ShowTooltip(slotIndex, index, jj)
  local self = WorldMapGuildHouseManager
  local uiBase = self._ui.itemSlots[slotIndex].icon
  local data = self._detailListData[index]
  local item = data.itemIndexList[jj]
  if nil == item then
    return
  end
  local guildHouseInfoSSW = ToClient_GetGuildHouseInfoStaticStatusWrapper(self._houseKey)
  local esSSW = guildHouseInfoSSW:getItemExchangeByIndex(item)
  if esSSW:isSet() then
    local esSS = esSSW:get()
    local itemStatic = esSS:getFirstDropGroup():getItemStaticStatus()
    local itemKey = esSS:getFirstDropGroup()._itemKey
    local staticStatusWrapper = getItemEnchantStaticStatus(itemKey)
    PaGlobalFunc_TooltipInfo_Open(Defines.TooltipDataType.ItemSSWrapper, staticStatusWrapper, Defines.TooltipTargetType.Item, getScreenSizeX())
  end
  self._currentTooltipSlot = slotIndex
  self._currentSlotInfo._slotIndex = slotIndex
  self._currentSlotInfo._index = index
  self._currentSlotInfo._itemIndex = jj
  PaGlobalFunc_WorldMapGuildHouseManager_SetDetailFocus(true)
end
function PaGlobalFunc_WorldMapGuildHouseManager_HideTooltip(slotIndex)
  local self = WorldMapGuildHouseManager
  if self._currentTooltipSlot == slotIndex then
    PaGlobalFunc_TooltipInfo_Close()
    self._currentTooltipSlot = -1
  end
end
function WorldMapGuildHouseManager:updateDetailData()
  local guildHouseInfoSSW = ToClient_GetGuildHouseInfoStaticStatusWrapper(self._houseKey)
  if nil == guildHouseInfoSSW or nil == self._selected or nil == self._useTypeData[self._selected] then
    return
  end
  local maxLevel = self._useTypeData[self._selected].maxLevel
  local recipeKeyRaw = self._useTypeData[self._selected].receipeKey
  local houseUseType = self._useTypeData[self._selected].useType
  self._detailListData = {}
  local data = self._detailListData
  local levelTitleRow = 1
  local itemSlotRow = 1
  local itemCountInLevel = {}
  for ii = 1, maxLevel do
    if nil == data[levelTitleRow] then
      data[levelTitleRow] = {}
    end
    data[levelTitleRow].desc = ii .. " " .. PAGetString(Defines.StringSheet_GAME, "LUA_HOUSEWORKLIST_HOUSE_LEVEL")
    itemCountInLevel[ii] = guildHouseInfoSSW:getItemExchangeListCount(recipeKeyRaw, ii)
    local itemRowAmountInLevel = math.ceil(itemCountInLevel[ii] / self._receipeIconColumnMax) + 1
    local itemIndexFromZero = 0
    itemSlotRow = levelTitleRow + 1
    levelTitleRow = levelTitleRow + itemRowAmountInLevel
    for jj = 1, itemCountInLevel[ii] do
      if nil == data[itemSlotRow] then
        data[itemSlotRow] = {}
        data[itemSlotRow].level = ii
      end
      if nil == data[itemSlotRow].itemIndexList then
        data[itemSlotRow].itemIndexList = {}
      end
      data[itemSlotRow].itemIndexList[(jj - 1) % self._receipeIconColumnMax + 1] = itemIndexFromZero
      itemIndexFromZero = itemIndexFromZero + 1
      if 0 == jj % self._receipeIconColumnMax then
        itemSlotRow = itemSlotRow + 1
      end
    end
  end
end
function Input_WorldMapGuildHouseManager_SetSelectButton(isShow)
  local self = WorldMapGuildHouseManager
  self._ui.scroll_ctrlButton:SetShow(false)
  self._ui._static_KeyGuide_Select:SetShow(isShow)
end
function Input_WorldMapGuildHouseManager_SetUseType(index)
  local self = WorldMapGuildHouseManager
  self._selected = index
  for ii = 1, #self._ui.rdo_houseTypes do
    self._ui.rdo_houseTypes[ii]:SetCheck(false)
  end
  self._ui.rdo_houseTypes[index]:SetCheck(true)
  self._detailListScrollAmount = 0
  self._ui.scroll_detailList:SetControlPos(0)
  self:updateDetailList()
  self._ui.frame_houseType:GetVScroll():SetControlPos(0)
  self._ui.frame_houseType:UpdateContentPos()
  self._ui.scroll_detailList:SetControlPos(0)
  self._ui.scroll_ctrlButton:SetShow(false)
  Input_WorldMapGuildHouseManager_SetSelectButton(index)
end
function InputScroll_WorldMapGuildHouseManager_DetailList(isUp)
  local self = WorldMapGuildHouseManager
  local prevScrollAmount = self._detailListScrollAmount
  if false == self._ui.scroll_ctrlButton:GetShow() then
    return
  end
  self._detailListScrollAmount = UIScroll.ScrollEvent(self._ui.scroll_detailList, isUp, self._detailListRowMax, #self._detailListData, self._detailListScrollAmount, 1)
  if prevScrollAmount ~= self._detailListScrollAmount then
    self:updateDetailList()
    ToClient_padSnapIgnoreGroupMove()
    local index = self._currentSlotInfo._index
    if true == isUp then
      index = self._currentSlotInfo._index - 1
    else
      index = self._currentSlotInfo._index + 1
    end
    local data = self._detailListData[index]
    if nil == data then
      return
    end
    if nil ~= data.desc then
      return
    end
    if 0 == self._useTypeData[self._selected].useType then
      return
    end
    PaGlobalFunc_WorldMapGuildHouseManager_HideTooltip()
    PaGlobalFunc_WorldMapGuildHouseManager_ShowTooltip(self._currentSlotInfo._slotIndex, index, self._currentSlotInfo._itemIndex)
  end
end
function FromClient_WorldMapGuildHouseLClick(guildUIButton)
  if not isContentsEnable then
    return
  end
  FGlobal_ClearWorldmapIconTooltip()
  PaGlobalFunc_WorldMap_RingMenu_Close()
  PaGlobalFunc_WorldMap_TopMenu_Close()
  PaGlobalFunc_WorldMap_BottomMenu_Close()
  local guildHouseInfoSSW = guildUIButton:getGuildHouseInfoStaticStatusWrapper()
  WorldMapGuildHouseManager._houseKey = guildHouseInfoSSW:getKeyRaw()
  WorldMapGuildHouseManager:open(guildHouseInfoSSW)
end
