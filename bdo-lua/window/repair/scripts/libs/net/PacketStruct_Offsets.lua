PacketStruct_Offsets = {
	ACK = {
		FishingTime = -- updated
		{NextCatchTime = 0xD, NextAutoCatchTime = 0x0},

		PetUseSkill = -- updated -- gen failed
		{PetNo = 0x3, SkillNo = 0xB},

		BreathGaugeStateChange = -- updated
		{Type = 0x8, ServerTimeMillis = 0xC, SelfActorKey = 0x4},

		RemoveActor = -- updated	--no autogen
		{ActorKey = 0x11},

		SetServantStats = -- updated
		{ActorKey = 0x22, Speeds = 0x1},

		UpdateEnchantFailCount = -- updated
		{FailStack = 0xD},

		PickupDroppedItem = -- updated  --no autogen
		{DeadBody_ActorKey = 0xE},

		GetTradeShopItems = -- updated
		{
			TotalSize = 0x9, --
			TradingType = 0x0, --
			NpcActorKey = 0x5, --
			NpcActorId = 0x1, --
			ItemsSize = 0xE, --

			First_ItemEnchantKeyRaw = 0x1F, --
			ItemDataOffset_ShopSlotId = 0x3C, --gen failed

			ItemEntryDataSize = 0xB9 --
		},

		AddDeadBodys = -- updated
		{
			Count = 0x4, --
			PosX = 0x38, --
			ActorId = 0x4E, --
			ActorKey = 0x24, --
			HasLoot = 0x87, --gen failed

			DeadBodyEntrySize = 0xAC --
		},

		AddItemToInventory = -- updated
		{
			ToActorKey = 0x4, -- 
			ToWhereType = 0xA5, -- gen failed
			ItemEnchantKey = 0x19 --
		},

		GetDroppedItems = -- updated  --no autogen
		{
			ActorKey = 0x2, --
			ListCount = 0x0, --
			Index = 0x9A, --
			ItemEnchantKey = 0xE, --

			ItemEntryDataSize = 0x8D --
		}
	},

	REQ = {
ActorStatusReq = -- updated
{

OpCode = 4284,
Size = 9,

ActorKey = 0x2, --eDataType_DWORD
},
ChangePetSpeedReq = -- updated
{

OpCode = 4740,
Size = 10,

Speed = 0x0, --eDataType_BYTE
PetNo = 0x1, --eDataType_QWORD
},
EnchantItemReq = -- updated
{

OpCode = 4947,
Size = 11,

UnknownValue01 = 0x6, --eDataType_BYTE
UnknownValue02 = 0x9, --eDataType_BYTE
UnknownValue03 = 0x2, --eDataType_BYTE
FixValue01 = 0x0, --eDataType_BYTE
UnknownValue04 = 0xA, --eDataType_BYTE
EnchantItemSlot = 0x5, --eDataType_BYTE
UnknownValue05 = 0x7, --eDataType_BYTE
ItemSlot = 0x8, --eDataType_BYTE
UnknownValue06 = 0x3, --eDataType_BYTE
UnknownValue07 = 0x1, --eDataType_BYTE
},
EquipItemReq = -- updated -- something is wrong here with the gen, it doesnt find the struct + opcode
{

OpCode = 5385,
Size = 16,

EquipSlot = 0x0, --eDataType_BYTE
InventorySlot = 0xF, --eDataType_BYTE
FixValue01 = 0x2, --eDataType_QWORD
SelfActorKey = 0xA, --eDataType_DWORD
InventoryWhereType = 0x1, --eDataType_BYTE
},
GetDroppedItemListReq = -- updated
{

OpCode = 3004,
Size = 4,

ActorKey = 0x0, --eDataType_DWORD
},
GetShopItemsReq = -- updated
{

OpCode = 6255,
Size = 22,

UnknownValue01 = 0x0, --eDataType_BYTE
UnknownValue02 = 0xD, --eDataType_DWORD
UnknownValue03 = 0x5, --eDataType_WORD
NpcActorKey = 0x1, --eDataType_DWORD
},
PickupDroppedItemReq = -- updated -- struct changed -- might be broken
{

OpCode = 3348,
Size = 29,

FixValue01 = 0x11, -- eDataType_BYTE--
FixValue02_2 = 0xC, -- eDataType_BYTE--
FixValue02 = 0x8, -- eDataType_BYTE--
Count = 0x0, -- eDataType_QWORD--
LootBagType = 0xA, -- eDataType_BYTE--
Slot = 0xB, -- eDataType_BYTE--
FixValue01_2 = 0x9, -- eDataType_BYTE--
SelfActorKey = 0x17, -- eDataType_DWORD--
ActorKey = 0xD -- eDataType_DWORD--
},
PopWarehouseItemToInventoryReq = -- updated
{

OpCode = 5308,
Size = 53,

NpcActorKey = 0x2A, --eDataType_DWORD
UnknownValue01 = 0x23, --eDataType_QWORD
UnknownValue02 = 0x2B, --eDataType_QWORD
FixValue01 = 0x14, --eDataType_WORD
ItemEnchantKey = 0x4, --eDataType_DWORD
ItemNo = 0x1A, --eDataType_QWORD
SelfActorKey = 0x16, --eDataType_DWORD
ThroughWhereType = 0x0, --eDataType_DWORD
Count = 0x9, --eDataType_QWORD
},
PushInventoryItemToWarehouseReq = -- updated -- struct changed
{

OpCode = 3439,
Size = 44,

-- Datafield count changed!
NpcActorKey = 0x20, --eDataType_DWORD
UnknownValue01 = 0x24, --eDataType_QWORD
UnknownValue02 = 0x1C, --eDataType_QWORD
ThroughWhereType = 0xA, --eDataType_DWORD
StackeeItemNo = 0x10, --eDataType_QWORD
Count = 0x1, --eDataType_QWORD
Slot = 0x9, --eDataType_BYTE
InventoryType = 0x0, --eDataType_BYTE
SelfActorKey = 0x18, --eDataType_DWORD
},
RepairItemReq = -- updated -- struct changed -- might be broken -- template broken, doesnt find correct struct even with correct template struct
{

OpCode = 4232,
Size = 47,

--[[    		Original generated struct 
		{Name = "", Offset = 0x15, DataType = eDataType_QWORD},
		{Name = "", Offset = 0x1D, DataType = eDataType_QWORD},
		{Name = "", Offset = 0x0, DataType = eDataType_BYTE},
		{Name = "", Offset = 0x26, DataType = eDataType_QWORD},
		{Name = "", Offset = 0x25, DataType = eDataType_BYTE},
		{Name = "", Offset = 0x1, DataType = eDataType_BYTE},
		{Name = "", Offset = 0x14, DataType = eDataType_BYTE},
		{Name = "", Offset = 0x13, DataType = eDataType_BYTE},
		{Name = "", Offset = 0x2, DataType = eDataType_BYTE},
		{Name = "", Offset = 0xB, DataType = eDataType_QWORD},
		{Name = "", Offset = 0x3, DataType = eDataType_DWORD},
		{Name = "", Offset = 0x7, DataType = eDataType_DWORD},
]]--	

FuelQuantity = 0x15, --eDataType_QWORD--
TentObjectId = 0x1D, --eDataType_QWORD--
RepairType = 0x0, --eDataType_BYTE--
MoneyNo = 0x26, --eDataType_QWORD--
MoneyWhereType = 0x25, --eDataType_BYTE--
UnknownValue01 = 0x1, --eDataType_BYTE--
UnknownValue02 = 0x14, --eDataType_BYTE--
FuelSlot = 0x13, --eDataType_BYTE--
InventoryType = 0x2E, --eDataType_BYTE--
Slot = 0xB, --eDataType_QWORD--
SelfActorKey = 0x3, --eDataType_DWORD--
NpcActorKey = 0x7, --eDataType_DWORD--
},
SealPetReq = -- updated
{

OpCode = 4177,
Size = 8,

PetNo = 0x0, --eDataType_QWORD
},
SellItemInShopReq = -- updated  -- something is wrong here with the gen, bdo internally are not enough fields found by asm parser algo
{

OpCode = 3811,
Size = 53,

MoneyNo = 0x29, --eDataType_QWORD
MoneyToWhereType = 0xA, --eDataType_BYTE
SelfActorKey = 0xC, --eDataType_DWORD
Count = 0x10, --eDataType_QWORD
ItemEnchantKeyRaw = 0x18, --eDataType_DWORD
Slot = 0x1C, --eDataType_BYTE
ShopSlotId = 0x1D, --eDataType_WORD
IsTradeShop = 0xB, --eDataType_BYTE
NpcActorKey = 0x31, --eDataType_DWORD
},
UnEquipItemReq = -- updated
{

OpCode = 5437,
Size = 11,

SelfActorKey = 0x0, --eDataType_BYTE
EquipSlot = 0x7, --eDataType_DWORD
},
UnsealPetReq = -- updated
{

OpCode = 3579,
Size = 9,

PetNo = 0x0, --eDataType_QWORD
},
CollectTentReq = -- updated
{

OpCode = 4129,
Size = 14,

FixValue01 = 0xD, --eDataType_BYTE
TentNo = 0x3, --eDataType_QWORD
},
InstallTentReq = -- updated
{

OpCode = 5594,
Size = 40,

UnknownValue01 = 0x8, --eDataType_DWORD
UnknownValue02 = 0x0, --eDataType_FLOAT
PosZ = 0x22, --eDataType_DWORD
PosX = 0x1A, --eDataType_FLOAT
FixValue01 = 0xC, --eDataType_WORD
ActorId = 0x26, --eDataType_WORD
TentNo = 0x11, --eDataType_QWORD
},
PurchaseFromTentReq = -- updated
{

OpCode = 3748,
Size = 55,

UnknownValue03 = 0x1C, --eDataType_QWORD
FixValue01 = 0x9, --eDataType_BYTE
TentNo = 0x26, --eDataType_QWORD
SelfActorKey = 0xA, --eDataType_DWORD
UnknownValue02 = 0x0, --eDataType_BYTE
MoneyNo = 0x2E, --eDataType_QWORD
UnknownValue04 = 0x36, --eDataType_BYTE
IsPotion = 0xE, --eDataType_BYTE
Count = 0xF, --eDataType_DWORD
ItemId = 0x5, --eDataType_DWORD
ShopSlot = 0x17, --eDataType_WORD
TentActorKey = 0x1, --eDataType_DWORD
},
PurchaseVillaBuffFromTentReq = -- updated -- struct changed
{

OpCode = 4524,
Size = 20,

-- Datafield count changed!
FixValue01 = 0x10, --eDataType_BYTE
FixValue02 = 0x0, --eDataType_QWORD
BuffIndex = 0x11, --eDataType_WORD
FixValue03 = 0xB, --eDataType_WORD
},
CleanseItemReq = -- updated
{

OpCode = 5490,
Size = 15,

MoneyNo = 0x5, --eDataType_QWORD
MoneyWhereType = 0xD, --eDataType_BYTE
ItemSlot = 0x0, --eDataType_BYTE
UnknownValue01 = 0xE, --eDataType_BYTE
NpcActorKey = 0x1, --eDataType_DWORD
},
FeedPetReq = -- updated
{

OpCode = 3946,
Size = 27,

FixValue01 = 0x4, --eDataType_WORD
FixValue02 = 0x6, --eDataType_WORD
FixValue03 = 0x17, --eDataType_DWORD
ActorKey = 0x13, --eDataType_DWORD
FixValue04 = 0x0, --eDataType_DWORD
PetNo = 0xB, --eDataType_QWORD
},

	}
}
