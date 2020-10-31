PaGlobal_DialogIntimacy_All = {
  _ui = {
    stc_title = nil,
    stc_progressBg = nil,
    stc_progress = nil,
    stc_rewardIcon = nil,
    stc_rewardTemplete = nil,
    stc_npcTagBg = nil,
    stc_tagIcon = nil,
    txt_npcName = nil,
    txt_npcTitle = nil
  },
  _intimacyValueBuffer = {},
  _rewardList = {},
  _text = {
    hasMentalCardText = PAGetString(Defines.StringSheet_GAME, "LUA_INTIMACY_ALL_INFORMATION_HASMENTALCARD"),
    hasntMentalCardText = PAGetString(Defines.StringSheet_GAME, "LUA_INTIMACY_ALL_INFORMATION_HASNTMENTALCARD")
  },
  _maxIntimacyRewardCount = 8,
  _rewardTextPos = {x = nil, y = nil},
  _space = {progressToReward = 30, rewardTextHBorder = 27},
  _intimacyIcon = {
    [0] = {
      [1] = {
        texture = "Combine/ETC/Combine_ETC_IntimacyRing.dds",
        x1 = 1,
        y1 = 198,
        x2 = 28,
        y2 = 225
      },
      [2] = {
        texture = "Combine/ETC/Combine_ETC_IntimacyRing.dds",
        x1 = 29,
        y1 = 198,
        x2 = 56,
        y2 = 225
      },
      [3] = {
        texture = "Combine/ETC/Combine_ETC_IntimacyRing.dds",
        x1 = 57,
        y1 = 198,
        x2 = 84,
        y2 = 225
      }
    },
    [1] = {
      texture = "Combine/ETC/Combine_ETC_IntimacyRing.dds",
      x1 = 113,
      y1 = 198,
      x2 = 140,
      y2 = 225
    },
    [2] = {
      texture = "Combine/ETC/Combine_ETC_IntimacyRing.dds",
      x1 = 85,
      y1 = 198,
      x2 = 112,
      y2 = 225
    },
    [3] = {
      texture = "Combine/ETC/Combine_ETC_IntimacyRing.dds",
      x1 = 141,
      y1 = 198,
      x2 = 168,
      y2 = 225
    },
    [4] = {
      texture = "Renewal/Progress/Console_Progressbar_02.dds",
      x1 = 163,
      y1 = 448,
      x2 = 194,
      y2 = 479
    },
    [5] = {
      texture = "Renewal/UI_Icon/Console_Icon_00.dds",
      x1 = 231,
      y1 = 24,
      x2 = 205,
      y2 = 227
    }
  },
  _operatorString = {
    [CppEnums.DlgCommonConditionOperatorType.Equal] = "",
    [CppEnums.DlgCommonConditionOperatorType.Large] = "<PAColor0xFFFF0000>\226\150\178<PAOldColor>",
    [CppEnums.DlgCommonConditionOperatorType.Small] = "<PAColor0xFF0000FF>\226\150\188<PAOldColor>"
  },
  _npcTypeIconTexturePath = "Combine/Icon/Combine_Dialogue_TagIcon_00.dds",
  _npcTypeIcon = {
    [CppEnums.SpawnType.eSpawnType_NormalNpc] = {
      205,
      154,
      255,
      204
    },
    [CppEnums.SpawnType.eSpawnType_SkillTrainer] = {
      103,
      1,
      153,
      51
    },
    [CppEnums.SpawnType.eSpawnType_ItemRepairer] = {
      205,
      103,
      255,
      153
    },
    [CppEnums.SpawnType.eSpawnType_ShopMerchant] = {
      256,
      103,
      306,
      153
    },
    [CppEnums.SpawnType.eSpawnType_ImportantNpc] = {
      205,
      154,
      255,
      204
    },
    [CppEnums.SpawnType.eSpawnType_TradeMerchant] = {
      154,
      1,
      204,
      51
    },
    [CppEnums.SpawnType.eSpawnType_WareHouse] = {
      1,
      1,
      51,
      51
    },
    [CppEnums.SpawnType.eSpawnType_Stable] = {
      256,
      1,
      306,
      51
    },
    [CppEnums.SpawnType.eSpawnType_Wharf] = {
      154,
      103,
      204,
      153
    },
    [CppEnums.SpawnType.eSpawnType_transfer] = {
      154,
      1,
      204,
      51
    },
    [CppEnums.SpawnType.eSpawnType_intimacy] = {
      205,
      154,
      255,
      204
    },
    [CppEnums.SpawnType.eSpawnType_guild] = {
      52,
      103,
      102,
      153
    },
    [CppEnums.SpawnType.eSpawnType_explorer] = {
      205,
      52,
      255,
      102
    },
    [CppEnums.SpawnType.eSpawnType_inn] = {
      205,
      154,
      255,
      204
    },
    [CppEnums.SpawnType.eSpawnType_auction] = {
      103,
      52,
      153,
      102
    },
    [CppEnums.SpawnType.eSpawnType_mating] = {
      205,
      154,
      255,
      204
    },
    [CppEnums.SpawnType.eSpawnType_Potion] = {
      52,
      1,
      102,
      51
    },
    [CppEnums.SpawnType.eSpawnType_Weapon] = {
      103,
      154,
      153,
      204
    },
    [CppEnums.SpawnType.eSpawnType_Jewel] = {
      1,
      103,
      51,
      153
    },
    [CppEnums.SpawnType.eSpawnType_Furniture] = {
      52,
      154,
      102,
      204
    },
    [CppEnums.SpawnType.eSpawnType_Collect] = {
      1,
      154,
      51,
      204
    },
    [CppEnums.SpawnType.eSpawnType_Fish] = {
      154,
      52,
      204,
      102
    },
    [CppEnums.SpawnType.eSpawnType_Worker] = {
      256,
      52,
      306,
      102
    },
    [CppEnums.SpawnType.eSpawnType_Alchemy] = {
      52,
      52,
      102,
      102
    },
    [CppEnums.SpawnType.eSpawnType_GuildShop] = {
      52,
      103,
      102,
      153
    },
    [CppEnums.SpawnType.eSpawnType_ItemMarket] = {
      154,
      154,
      204,
      204
    },
    [CppEnums.SpawnType.eSpawnType_TerritorySupply] = {
      1,
      52,
      51,
      102
    },
    [CppEnums.SpawnType.eSpawnType_TerritoryTrade] = {
      205,
      1,
      255,
      51
    },
    [CppEnums.SpawnType.eSpawnType_Smuggle] = {
      154,
      1,
      204,
      51
    },
    [CppEnums.SpawnType.eSpawnType_Cook] = {
      103,
      103,
      153,
      153
    },
    [CppEnums.SpawnType.eSpawnType_PC] = {
      205,
      154,
      255,
      204
    },
    [CppEnums.SpawnType.eSpawnType_Grocery] = {
      256,
      103,
      306,
      153
    },
    [CppEnums.SpawnType.eSpawnType_RandomShop] = {
      256,
      103,
      306,
      153
    },
    [CppEnums.SpawnType.eSpawnType_SupplyShop] = {
      1,
      52,
      51,
      102
    },
    [CppEnums.SpawnType.eSpawnType_RandomShopDay] = {
      256,
      103,
      306,
      153
    },
    [CppEnums.SpawnType.eSpawnType_FishSupplyShop] = {
      154,
      52,
      204,
      102
    },
    [CppEnums.SpawnType.eSpawnType_GuildSupplyShop] = {
      52,
      103,
      102,
      153
    },
    [CppEnums.SpawnType.eSpawnType_GuildStable] = {
      256,
      1,
      306,
      51
    },
    [CppEnums.SpawnType.eSpawnType_GuildWharf] = {
      154,
      103,
      204,
      153
    },
    [CppEnums.SpawnType.eSpawnType_Instrument] = {
      1,
      205,
      51,
      255
    },
    [CppEnums.SpawnType.eSpawnType_Count] = {
      256,
      154,
      306,
      204
    }
  },
  _math_AddVectorToVector = Util.Math.AddVectorToVector,
  _math_MulNumberToVector = Util.Math.MulNumberToVector,
  _initialize = false
}
runLua("UI_Data/Script/Widget/Dialogue/Panel_Dialog_Intimacy_All_1.lua")
runLua("UI_Data/Script/Widget/Dialogue/Panel_Dialog_Intimacy_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_PaGlobal_DialogIntimacy_All_Init")
function FromClient_PaGlobal_DialogIntimacy_All_Init()
  PaGlobal_DialogIntimacy_All:initialize()
end
