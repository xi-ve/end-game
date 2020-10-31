-- Ability Stats (as shown on Profile)
EAbilityStats_Movement = 0
EAbilityStats_Attack = 1
EAbilityStats_Cast = 2
EAbilityStats_MaxMovement = 3
EAbilityStats_MaxAttack = 4
EAbilityStats_MaxCast = 5
EAbilityStats_Crit = 6
EAbilityStats_MaxCrit = 7
EAbilityStats_Luck = 8
EAbilityStats_MaxLuck = 9
EAbilityStats_Fishing = 10
EAbilityStats_MaxFishing = 11
EAbilityStats_Gathering = 12
EAbilityStats_MaxGathering = 13

-- Resistence Stats (as shown on Profile)
EResistance_Knockdown = 0
EResistance_Stun = 1
EResistance_Knockback = 2
EResistance_Catch = 3

-- Stats reducing lifeskilling stuff
EDecreaseTime_Alchemy = 0
EDecreaseTime_Cooking = 1

-- Actor types
---All Actors, regardless of type
EActorType_All = -1
---Player characters
EActorType_Player = 0
---Monsters
EActorType_Monster = 1
---NPCs
EActorType_Npc = 2
---Horses, Ships and Tents
EActorType_Vehicle = 3
EActorType_Gate = 4
EActorType_Alterego = 5
EActorType_Collect = 6
EActorType_Household = 7
EActorType_Installation = 8
EActorType_Deadbody = 9

-- Character Grades. Actors can have these
ECharacterGrade_Normal = 0
ECharacterGrade_Elite = 1
ECharacterGrade_Hero = 2
ECharacterGrade_Legend = 3
ECharacterGrade_Boss = 4
ECharacterGrade_Assistant = 5

-- Item Grades
EItemGrade_White = 0
EItemGrade_Green = 1
EItemGrade_Blue = 2
EItemGrade_Yellow = 3

---Represents a pet
--- @class PcPetData
local PcPetData = {}

---Returns the pet number of the pet as a LuaInt64
---@return LuaInt64 petNo
function PcPetData:getPetNo()
end

---Represents an animation
---@class AnimationData
local AnimationData = {}

---Returns the name of the animation
---@return string animationName
function AnimationData:getName()
end

---Represents a CharacterScene object, which controls a characters animations and rotation
---@class CharacterScene
local CharacterScene = {}
---Returns the current animation speed (float)
---@return number currentAnimationSpeed
function CharacterScene:getAnimationSpeed()
end
---Sets the current animation speed. Do NOT use this! The speedhack script is the only one that should use this function. Unproper usage of this will result in a ban ingame and from our community!
---@param newSpeed number
function CharacterScene:setAnimationSpeed(newSpeed)
end

---Returns the characters rotation. Goes from -PI to +PI.
---@return number currentRotation
function CharacterScene:getRotation()
end

---Sets the characters rotation. Values from -PI to +PI are reasonable.
---@param newRotation number
function CharacterScene:setRotation(newRotation)
end

---Represents a CharacterControler object, which acts as an intermediate to a characters animations, actions and more.
---@class CharacterControler
local CharacterControler = {}
---Returns the characters CharacterScene
---@return CharacterScene characterScene
function CharacterControler:getCharacterScene()
end

---Returns the current animation the character is in
---@return AnimationData animationData
function CharacterControler:getCurrentAnimation()
end

---Returns current set jump height (ingame units)
---@return number currentJumpHeight
function CharacterControler:getJumpHeight()
end

---Sets jump height for the character
---@param newJumpHeight number
function CharacterControler:setJumpHeight(newJumpHeight)
end

---Returns the name of the next queued action. This is more or less equal to the animation name, but is not an AnimationData object, since it is not created yet.
---@return string nextActionName
function CharacterControler:getNextAction()
end

---Represents a MovementControler, which controls the movement of a character.
---@class MovementControler
local MovementControler = {} -- in order to initiate a movement of the character you have to set IsMoving + the destination + the origin
---Returns true if the character is currently moving
---@return boolean currentlyMoving
function MovementControler:getIsMoving()
end
---Sets the moving flag of the character. To move a character you need to set a valid destination, a valid origin and the isMoving flag must be set to true .
---@param newCurrentlyMoving boolean
function MovementControler:setIsMoving(newCurrentlyMoving)
end
---Returns current characters destination
---@return Vector3 destination
function MovementControler:getDestination()
end

---Sets the characters desination. To move a character you need to set a valid destination, a valid origin and the isMoving flag must be set to true .
---@param newDest Vector3
---@see MovementControler:getIsMoving
---@see MovementControler:setOrigin
function MovementControler:setDestination(newDest)
end

---Returns the currently set origin of the character movement.
---@return Vector3 currentOrigin
function MovementControler:getOrigin()
end

---Sets the origin of the current movement. To move a character you need to set a valid destination, a valid origin and the isMoving flag must be set to true .
---@param newOrigin Vector3
function MovementControler:setOrigin(newOrigin)
end

---Camera Manager that can modify the game camera.
---@class CameraManager
local CameraManager = {}

---Returns the current camera roll
---@return number currentRoll
function CameraManager:getRoll()
end
---Sets the camera roll value. The modified value will only be applied if the cursor is deactived (Ctrl)
---@param newRoll number
function CameraManager:setRoll(newRoll)
end

---Returns the current camera pitch. Is between -0.5 PI and +0.5 PI
---@return number currentPitch
function CameraManager:getPitch()
end
---Sets the camera pitch value. The modified value will only be applied if the cursor is deactived (Ctrl)
---@param newPitch number
function CameraManager:setPitch(newPitch)
end

---Returns the current camera Yaw. Is between -PI and +PI
---@return number currentYaw
function CameraManager:getYaw()
end
---Sets the camera yaw value. The modified value will only be applied if the cursor is deactived (Ctrl)
---@param newYaw number
function CameraManager:setYaw(newYaw)
end

---Returns the current camera position.
---@return Vector3 cameraPosition
function CameraManager:getCameraPosition()
end

---@DialogManager to set and get the talker npc.
---@class DialogManager
local DialogManager = {}
---Returns the last talked to NPC's ActorData. Be careful with this, since it could be an expired NPC.
---@return ActorData talkeeActor
function DialogManager:getTalker()
end
---Sets the currently talking to Actor to a given actor. This will not initiate a dialog but will trick some functions that interact with an NPC to work without ever talking to the NPC.
---@param newActor ActorData
function DialogManager:setTalker(newActor)
end
---Resets currently talking to NPC
function DialogManager:resetTalker()
end

---Represents a SectorScene, which is the world geometry of a map sector
---@class SectorScene
local SectorScene = {}
---Memory address of the SectorScene
---@type LuaInt64
SectorScene.address = nil

---Returns map sector XYZ as Vector3
---@return Vector3 sectorXYZ
function SectorScene:getSector()
end
---Returns sector XYZ as string
---@return string sectorXYZString
function SectorScene:getSectorText()
end

---Returns vertices of the level geometry as an array of vertices
---@return table<integer, Vector3> verticesVec3
function SectorScene:getVertices()
end

---Returns polygons of the level geometry as an array of Vector3's which have the three indices of the vertices that build the triangle
---@return table<integer, Vector3> trianglesVec3
function SectorScene:getTriangles()
end

---@see SectorScene:getTriangles
function SectorScene:getPolygons()
end

---SceneManager, which manages all SectorScenes and can be used to raycast the level geometry
---@class SceneManager
SceneManager = {}
---Casts a ray through the level geometry. If it returns 0, no collision was found.
---@param startPos Vector3
---@param directionVector Vector3
---@param rayDistance number
---@param unknownFloat number
---@param unknownUInt number
---@return number distanceToCollision
function SceneManager:CastRay(startPos, directionVector, rayDistance, unknownFloat, unknownUInt)
end

---Returns a table with all SectorScene objects that are nearby
---@return table<integer, SectorScene> sectorScenes
function SceneManager:getAllSectorScenes()
end

---Returns a table with all loaded SectorScene objects that are nearby
---@return table<integer, SectorScene> sectorScenes
function SceneManager:getAllSectorScenes2()
end

---Returns an array of array of all vertices in the loaded sector scenes
function SceneManager:getCurrentSector_CachedTriangles()
end
---Returns an array of array of all triangles in the loaded sector scenes
function SceneManager:getCurrentSector_CurrentTriangle()
end

---WorldmapManager, allows grabbing of ingame nav path
---@class WorldmapManager
local WorldmapManager = {}
---Returns true if a navpath is generated
---@return boolean hasNavPath
function WorldmapManager:hasNavPath()
end
---Returns an array of Vector3 that represent the waypoints in the current navPath
---@return table<integer, Vector3> navPath
function WorldmapManager:getNavPath()
end

---UIManager used to manipulate cursor activity (ctrl)
---@class UIManager
local UIManager = {}
---Returns true if the cursor is currently active
---@return boolean isCurserActive
function UIManager:getIsCursorActive()
end
---Sets the cursor activity state
---@param newIsCursorActive boolean
function UIManager:setIsCursorActive(newIsCursorActive)
end

---ShopManager used to ge the shopSlotId of an item in a given shop
---@class ShopManager
local ShopManager = {}

---Requests the client to load a specific NPCs shop into memory. One pulse later it should be loaded
---@param npcActorKey integer
function ShopManager:requestShopData(npcActorKey)
end
---Returns the shopSlotId of an item by itemId in the currently loaded shop.
---@param itemId integer
function ShopManager:getShopSlotId(itemId)
end

---UIElement is an object representing a single UI Element
---@class UIElement
local UIElement = {}

---Returns the name of the element
---@return string name
function UIElement:getName()
end

---Containing one enhancment level of one item on the marketplace
---@class MarketItemInfo
local MarketItemInfo = {}

---Returns the itemID of the item this MarketItemInfo is linked to
---@return integer itemId
function MarketItemInfo:getItemId()
end
---Returns the registered amount of the item.
---@return LuaInt64 count
function MarketItemInfo:getCount()
end
---Returns the single price of the item.
---@return LuaInt64 price
function MarketItemInfo:getSinglePrice()
end
---Returns the total price of the item.
---@return LuaInt64 price
function MarketItemInfo:getTotalPrice()
end

---Information about one game region
---@class RegionInfo
local RegionInfo = {}
---Returns true if the region is a safe zone
---@return boolean isSafeZone
function RegionInfo:isSafeZone()
end
---Returns true if the region is part of an areana
---@return boolean isArenaZone
function RegionInfo:isArenaZone()
end
---Returns true if the region is part of the desert
---@return boolean isDesert
function RegionInfo:isDesert()
end
---Returns true if the region is part of the ocean
---@return boolean isOcean
function RegionInfo:isOcean()
end
---Returns true if the region is accessable
---@return boolean isAccessable
function RegionInfo:isAccessable()
end

---Represents one Actor in the game (Player, NPC, Monster, Horse, etc.)
---@class ActorData
local ActorData = {}
---@type LuaInt64
ActorData.address = nil

---Returns true if given actor is a valid actor inside the ActorList
---@return boolean isValid
function ActorData:isValid()
end

---Returns the actors character controler
---@return CharacterControler characterControler
function ActorData:getCharacterControler()
end
---Returns the actors movement controler
---@return MovementControler movementControler
function ActorData:getMovementControler()
end
---Returns the actors PetData. Make sure the actor is a pet
---@return PcPetData petData
function ActorData:getPcPetData()
end
---Returns the current region
---@return RegionInfo regionInfo
function ActorData:getCurrentRegion()
end

---Returns actor body height
---@return number height
function ActorData:getBodyHeight()
end

---Returns actor body size
---@return number size
function ActorData:getBodySize()
end

---Returns actor key (will be newly assigned when an actor spawns)
---@return integer actorKey
function ActorData:getActorKey()
end
---Returns actor id (unique to this kind of actor/npc/monster)
---@return integer actorId
function ActorData:getActorId()
end
---Returns Enum Value of actor type. Can be compared with EActorType_* enum
---@return integer EActorType
function ActorData:getActorType()
end
---Returns the actors level
---@return integer level 
function ActorData:getLevel()
end
---Returns the current exp of the actor
---@return LuaInt64 currentExp
function ActorData:getCurrentExp()
end
---Returns the exp one pulse before
---@return LuaInt64 previousExp
function ActorData:getPreviousExp()
end
---Returns required exp for the next level up
---@return LuaInt64 requiredExp
function ActorData:getRequiredExp()
end
---Returns actors mp (0 for other players)
---@return integer mp
function ActorData:getMp()
end
---Returns maximum mp of the actor (0 for other players)
---@return integer maxMp
function ActorData:getMaxMp()
end
---Returns actors hp
---@return integer hp
function ActorData:getHp()
end
---Returns maximum hp of the actor
---@return integer maxHp
function ActorData:getMaxHp()
end
---Returns object id of the actor. Make sure it is an actor that has an ID (Tent) before calling this 
---@return LuaInt64 objectId
function ActorData:getObjectId()
end
---Returns enum value of the actors character grade. Is euqal to ECharacterGrade enum
---@return integer characterGrade
function ActorData:getCharacterGrade()
end
---Returns tribe type as integer
---@return integer tribeType
function ActorData:getTribeType()
end
---Returns actor name (character name for players)
---@return string name
function ActorData:getName()
end
---Returns family name. Make sure the actor is a player before calling this
---@return string familyName
function ActorData:getFamilyName()
end
---Returns position of the actor
---@return Vector3 position
function ActorData:getPosition()
end
---Returns actor dead flag
---@return boolean isDead
function ActorData:getIsDead()
end
---Returns ActorData of the warehouse manager of the current region
---@return ActorData warehouseActor
function ActorData:getCurrentWarehouseManager()
end
---Returns true if any other player is nearby
---@return boolean playerNearby
function ActorData:getIsOtherPlayersNearby()
end
---Returns the current movement speed of the actor
---@return integer movementSpeed
function ActorData:getMovementSpeed()
end

---Sets the movement speed of the actor. The speedhack script is the only one that should use this function. Unproper usage of this will result in a ban ingame and from our community!
---@param newValue integer
function ActorData:setMovementSpeed(newValue)
end
---Returns the time the next fish will bite
---@return LuaInt64 time
function ActorData:getNextFishBite()
end
---Returns the time the next fish will bite for autocatch
---@return LuaInt64 time
function ActorData:getNextFishAutoCatch()
end
---Returns the value for one ability stat. abilityStatToGet is EAbilityStats_*
---@param abilityStatToGet integer
---@return integer stat
function ActorData:getAbilityStat(abilityStatToGet)
end
---Sets a specific ability stat to a new value. Use this with caution as it can get you banned! abilityStatToModify is EAbilityStats_*
---@param abilityStatToModify integer
---@param newValue number
function ActorData:setAbilityStat(abilityStatToModify, newValue)
end
---Returns a specific resistance stat value. resistanceToGet is EResistance_*
---@param resistanceToGet integer
---@return integer stat
function ActorData:getResistance(resistanceToGet)
end
---Sets a given resistance to a new value. Use this with caution as it can get you banned! resistanceToModify is EResistance_*
---@param resistanceToModify integer
---@param newValue integer
function ActorData:setResistance(resistanceToModify, newValue)
end
---Returns a specific resistance stat value. resistanceToGet is EResistance_*
---@param decreaseTimeToGet integer
---@return integer stat
function ActorData:getDecreaseTime(decreaseTimeToGet)
end
---Sets a given decreaseTime to a new value. Use this with caution as it can get you banned! decreaseTimeToMod is EDecreaseTime_*
---@param decreaseTimeToMod integer
---@param newValue integer
function ActorData:setDecreaseTime(decreaseTimeToMod, newValue)
end
---Returns the additional critrate of the actor
---@return integer additionalCritrate
function ActorData:getAdditionalCritrate()
end
---Sets the additional critrate. Use this with caution as it can get you banned!
---@param newAdditionalCritrate integer
function ActorData:setAdditionalCritrate(newAdditionalCritrate)
end
---Returns current combatstance. 0 is no combat, 1 is pre awakening/succession, 2 is awakening
---@return integer combatStance
function ActorData:getCombatStance()
end
---Returns MoneyNo of the actors inventory
---@return LuaInt64 moneyNo
function ActorData:getInventoryMoneyNo()
end
---Returns the players tent id, if the tent is deployed. Only works for localplayer
---@return LuaInt64 tentId
function ActorData:getMyTentObjectId()
end
---Returns true if the actor can set the pvp flag to true.
---@return boolean canPvpEnable
function ActorData:isPvPEnabled()
end
---Returns true if the (player) actor has the pvp flag set to true.
---@return boolean pvpMode
function ActorData:isPvPMode()
end
---Returns actor's karma value
---@return integer karma
function ActorData:getTendency()
end
---Returns true if the (player) actor recently attacked another (player) actor with pvp mode enabled
---@return boolean didPreemtiveStrike
function ActorData:isPreemptiveStrikeBeing()
end
---Returns true if (player) actor is "red" and can be freely attacked.
---@return boolean isMurderer
function ActorData:isMurdererStateBeing()
end

---Represents an item stack in a warehouse
---@class WarehouseItem
local WarehouseItem = {}

---Returns the items itemEnchantKey, which is a combination of the itemId and the enchant level
---@return integer itemEnchantKey
function WarehouseItem:getItemEnchantKey()
end
---Returns the size of the item stack
---@return LuaInt64 count
function WarehouseItem:getCount()
end

---A ItemLevelGroup on the marketplace. 
---@class ItemLevelGroup
ItemLevelGroup = {}
---Returns the itemKey of the item
---@return integer itemKey	
function ItemLevelGroup:getItemKey()
end
---Returns base price of the item
---@return LuaInt64 basePrice
function ItemLevelGroup:getBasePrice()
end
---Returns avaible amount of the item
---@return LuaInt64 count
function ItemLevelGroup:getAvailableCount()
end
---Returns total trades of the item
---@return LuaInt64 count
function ItemLevelGroup:getTotalTrades()
end
---Returns minimum level of the item
---@return integer minLevel
function ItemLevelGroup:getMinLevel()
end
---Returns maximum level of the item
---@return integer maxLevel
function ItemLevelGroup:getMaxLevel()
end
---Returns minimum possible price
---@return LuaInt64 price
function ItemLevelGroup:getMinPossiblePrice()
end
---Returns maximum possible price
---@return LuaInt64 price
function ItemLevelGroup:getMaxPossiblePrice()
end
---Returns most recent traded price
---@return LuaInt64 price
function ItemLevelGroup:getRecentPrice()
end

Infinity.BDO = {}

Infinity.BDO.Utils = {}
--- Returns true if the lua events of BDO are disabled
--- @return boolean eventState
function Infinity.BDO.Utils.getStateLuaEvents()
end
--- If lua events of BDO were disabled, this enables it. If they were enabled, it disables them.
function Infinity.BDO.Utils.toggleLuaEvents()
end
--- Returns true if rendering is disabled
--- @return boolean renderState
function Infinity.BDO.Utils.getStateRendering()
end
--- If rendering is disabled, it will enable it. If rendering is enabled it will be disabled.
function Infinity.BDO.Utils.toggleRendering()
end

Infinity.BDO.Lua = {}
---Executes the given Code in BDOs LuaState. It supports returning strings and numbers, but not tables or userdata.
---@param code string
---@return any returnValues
function Infinity.BDO.Lua.Execute(code)
end

Infinity.BDO.ItemMarket = {}
---Returns an array of all ItemLevelGroups of the currently openend item
---@return table<integer,ItemLevelGroup> itemLevelGroups
function Infinity.BDO.ItemMarket.getItemLevelGroups()
end

---Returns a table with the item prices and counts for the currently openend ItemLevelGroup, where the key of the table is the price and the value is the count. Both the key and the values are LuaInt64s
---@return table<LuaInt64, LuaInt64> priceAndCountList
function Infinity.BDO.ItemMarket.getItemPriceAndCountList()
end

---Returns an array of all prices for the currently openend ItemLevelGroup
---@return table<integer, LuaInt64> itemPriceList
function Infinity.BDO.ItemMarket.getItemPriceList()
end

---Returns amount of items in the Marketplace warehouse
---@return integer count
function Infinity.BDO.ItemMarket.getWarehouseItemsCount()
end

---Returns an array of WarehouseItems that are currently in the players marketplace warehouse
---@return table<integer, WarehouseItem> warehouseItems
function Infinity.BDO.ItemMarket.getWarehouseItems()
end

---Returns amount of silver in the players marketplace warehouse
---@return LuaInt64 balance
function Infinity.BDO.ItemMarket.getWarehouseBalance()
end

---Returns the current weight in the warehouse
---@return number weight
function Infinity.BDO.ItemMarket.getCurrentWeight()
end

---Returns the current max weight in the warehouse. This does NOT contain karma buffs and co. and therefor will always be 5k until the game, if ever, updates to a new default value.
---@return number maxWeight
function Infinity.BDO.ItemMarket.getMaxWeight()
end

---Returns getMaxWeight() - getCurrentWeight() (Therefore does not include karma buffs and co.)
---@return number freeWeight
function Infinity.BDO.ItemMarket.getFreeWeight()
end

---Returns the amount of buy orders the players has currently placed
---@return LuaInt64 buyOrderCount
function Infinity.BDO.ItemMarket.getBuyOrdersCount()
end

---Returns a table with the current buy orders, where the key is the itemId and the value is the corresponding MarketItemInfo
---@return table<integer,MarketItemInfo> buyOrders
function Infinity.BDO.ItemMarket.getBuyOrders()
end

---Returns the amount of sell orders the players has currently placed
---@return integer sellOrderCount
function Infinity.BDO.ItemMarket.getSellItemsCount()
end

---Returns a table with the current sell orders, where they key is the itemId and the value is the correspeonding MarketItemInfo
---@return table<integer, MarketItemInfo>
function Infinity.BDO.ItemMarket.getSellItems()
end

---Return the currently for buying selected item enchant key
---@return integer itemEnchantKey
function Infinity.BDO.ItemMarket.getPurchaseItemEnchantKey()
end

---Returns the minimum enchant level of the selected item
---@return integer itemlevelGroupMin
function Infinity.BDO.ItemMarket.getPurchaseItemLevelGroupMin()
end

---Returns the maximum enchant level of the selected item
---@return integer itemlevelGroupMax
function Infinity.BDO.ItemMarket.getPurchaseItemLevelGroupMax()
end

---Return the currently for purchase selected item level
---@return integer itemLevel 
function Infinity.BDO.ItemMarket.getPurchaseItemSelectedItemLevel()
end

---@return LuaInt64 totalTrades
function Infinity.BDO.ItemMarket.getTotalTrades()
end

---@return LuaInt64 setPrice
function Infinity.BDO.ItemMarket.getSetPrice()
end

---@return LuaInt64 additionalCost
function Infinity.BDO.ItemMarket.getAdditionalCost()
end

---Returns the currently for sale selected item key
---@return integer enchantKey
function Infinity.BDO.ItemMarket.getSellItemEnchantKey()
end

---Returns the currently for sale selected base price
---@return LuaInt64 basePrice
function Infinity.BDO.ItemMarket.getSellItemBasePrice()
end

---Returns the currently for sale selected max count
---@return LuaInt64 count
function Infinity.BDO.ItemMarket.getSellItemMaxCount()
end

Infinity.BDO.Warehouse = {}

---Returns the money number of the storage/warehouse of the current region
---@param key integer
---@return LuaInt64 count
function Infinity.BDO.Warehouse.getCurrentMoneyNoByWaypointKey(key)
end

---Returns the item number of an item in a given warehouse. The warehouse must be loaded for this to work.
---@param slot integer
---@param key integer
---@return LuaInt64 itemNo
function Infinity.BDO.Warehouse.getWarehouseItemNoBySlotAndWaypointKey(slot, key)
end

---Returns the actor of the local player
---@return ActorData localPlayer
function Infinity.BDO.getLocalPlayer()
end

---Returns the camera manager.
---@return CameraManager cameraManager
function Infinity.BDO.getCameraManager()
end

---Returns the worldmap manager
---@return WorldmapManager worldmapManager
function Infinity.BDO.getWorldmapManager()
end

---Returns the UI Manager
---@return UIManager uiManager
function Infinity.BDO.getUIManager()
end

---Returns the currently vehicle
---@return ActorData vehicleActor
function Infinity.BDO.getMyVehicle()
end

---Returns the dialog manager
---@return DialogManager dialogManager
function Infinity.BDO.getDialogManager()
end

---Returns the shop manager
---@return ShopManager shopManager
function Infinity.BDO.getShopManager()
end

---Returns an array with all actors as ActorData objects of the given type. actorType parameter is ActorType_*
---@param actorType integer
---@return table<integer, ActorData> actorDatas
function Infinity.BDO.getActorList(actorType)
end

---Returns the amount of actors of the given type. actorType parameter is ActorType_*
---@param actorType integer
---@return table<integer, ActorData> actorDatas
function Infinity.BDO.getActorListCount(actorType)
end

---Returns a given actor by its actorkey. If no actor with the given actor key exists, the result is nil.
---@param actorKey integer
---@return ActorData actorData
function Infinity.BDO.getActorByActorKey(actorKey)
end

---Returns the BDO internal time
---@return LuaInt64 time
function Infinity.BDO.getTime()
end

---Returns an array of strings of BDOs global functions
---@return table<integer, string> globalFuncNames
function Infinity.BDO.getCachedGlobalFunctions()
end

---Returns the current sectors x value
---@return integer x
function Infinity.BDO.getMapSectorX()
end
---Returns the current sectors y value
---@return integer y
function Infinity.BDO.getMapSectorY()
end
---Returns the current sectors z value
---@return integer z
function Infinity.BDO.getMapSectorZ()
end

Infinity.BDO.Input = {}
---Returns true if the given key is currently pressed. key is KeyCode_*
---@param key integer
---@return boolean pressed
function Infinity.BDO.Input.IsKeyPressed(key)
end

---Creates a new thread that presses down every key in a given table (key is KeyCode_*) and ups it after the given delay. Do not spam this function as it would create a lot of threads.
---@param keysTable table
---@param delay number
function Infinity.BDO.Input.PressKeys_Once(keysTable, delay)
end

---Downs every key in a given table of keys (key is KeyCode_*)
---@param keysTable table
function Infinity.BDO.Input.PressKeys_Down(keysTable)
end

---Ups every key in a given table of keys (key is KeyCode_*)
---@param keysTable table
function Infinity.BDO.Input.PressKeys_Up(keysTable)
end

---Returns true if the input queue of BDO is empty
---@return boolean isEmpty
function Infinity.BDO.Input.isEmptyQueue()
end

---Clears the input queue of BDO
function Infinity.BDO.Input.clearQueue()
end

Infinity.BDO.Selection = {}

---Returns the current crosshair targets actorKey
---@return ActorData actorKey
function Infinity.BDO.Selection.getTarget()
end

---Sets the current crosshair target over actorKey. This will require setting an engine override flag. Use Infinity.BDO.Selection.setNewAttackTarget instead.
---@param actorKey integer
function Infinity.BDO.Selection.setTarget(actorKey)
end

---Returns true if the current crosshair target is an overwritten target
function Infinity.BDO.Selection.isOverride()
end

---Resets the current crosshair target, allowing the game to set it again next frame.
function Infinity.BDO.Selection.reset()
end

---Sets the crosshair target to a new actorKey and sets the override flag in the engine. This will be reset the next frame and must be called once per frame
---@param actorKey integer 
function Infinity.BDO.Selection.setNewAttackTarget(actorKey)
end

Infinity.BDO.FunctionPatchManager = {}

---Disables the camera cursor lock, allowing for turning the camera without having the cursor deactivated
function Infinity.BDO.FunctionPatchManager.disableCameraCursorLock()
end

---Reenables the camera cursor lock, disallowing for turning the camera without having the cursor deactivated
function Infinity.BDO.FunctionPatchManager.enableCameraCursorLock()
end

