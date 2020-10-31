Inspector = { }
Inspector.Running = false

Inspector.UIElement_Name_LastInteraction = ""

Inspector.Rendering_SectorScene_Triangles = nil
Inspector.Rendering_SectorScene_ShowVerticesLayers = false
Inspector.Rendering_SectorScene_Layer = 0
Inspector.Rendering_SectorScene_MapDataReal = nil
Inspector.Rendering_SectorScene_Objects = nil
Inspector.Rendering_SectorScene_Objects_Triangles = nil
Inspector.Rendering_SectorScene_Objects_LowPoly = false
Inspector.Rendering_Current_SectorScene_Triangles = false
Inspector.Rendering_Current_SectorScene_CurrentTriangle = false

Inspector.Rendering_SectorScene_SingleObject = nil
Inspector.Rendering_SingleObject_LowPoly = false

Inspector.Cached_Object_VertsPolys = {}
Inspector.Cached_Scene_VertsPolys = {}

Inspector.RenderSettings_Scenes_ShowBox = true
Inspector.RenderSettings_Scenes_ShowMesh = true
Inspector.RenderSettings_Objects_DistanceLimit_Trigger = true
Inspector.RenderSettings_Objects_DistanceLimit_Value = 500.0

function Inspector.Start()
  Inspector.Running = true	
end

function Inspector.Stop()
  Inspector.Running = false  
end

function Inspector.OnPulse()
  if Inspector.Running == false then
    return
  end
  
end

function Inspector.OnGuiDraw()
	MainWindow.DrawMainWindow()

	if BinaryDataInspector.Draw then
		BinaryDataInspector.DrawMainWindow()
	end
end

function Inspector.Render_SectorSceneTriangles()	
	for k,trianglePoints in pairs(Inspector.Rendering_SectorScene_Triangles) do
		
		RenderHelper.DrawWorldTriangle(trianglePoints[1], trianglePoints[2], trianglePoints[3], "30FFFFFF", 1, false)
	end
end

function Inspector.Render_ShowVerticesLayers()	

	for k,v in pairs(Inspector.Rendering_SectorScene_MapDataReal:getVerticesLayer(Inspector.Rendering_SectorScene_Layer)) do
		
		RenderHelper.DrawWorldSquare(v, 20, "FFFF0000", 1, true)
	end
end

function Inspector.Render_SectorScene_Objects()	

	local lowPoly = Inspector.Rendering_SectorScene_Objects_LowPoly
	
	for k,o in pairs(Inspector.Rendering_SectorScene_Objects) do
				
		if o:isVisible() then
		
			for k,tp in pairs(o:getTriangles(lowPoly)) do
		
				RenderHelper.DrawWorldTriangle(tp[1], tp[2], tp[3], "30FFFF00", 1, false)				
			end
		end
	end	
end

function Inspector.Render_SectorScene_SingleObject()	

	local o = Inspector.Rendering_SectorScene_SingleObject
	local lowPoly = Inspector.Rendering_SingleObject_LowPoly

	for k,tp in pairs(o:getTriangles(lowPoly)) do
		
		RenderHelper.DrawWorldTriangle(tp[1], tp[2], tp[3], "30FFFF00", 1, false)				
	end

	--RenderHelper.DrawWorldSquare(o:getObjectPointA(lowPoly), 10, "FFFFFF00", 1, true)
	--RenderHelper.DrawWorldSquare(o:getObjectPointB(lowPoly), 10, "FFFFFF00", 1, true)

	--RenderHelper.DrawWorldSquare(o:getPointA(), 10, "FFFF0000", 1, true)
	--RenderHelper.DrawWorldSquare(o:getPointB(), 10, "FFFF0000", 1, true)
end

function Inspector.Render_Current_SectorSceneTriangles()

	for k,trianglePoints in pairs(Infinity.BDO.getSceneManager():getCurrentSector_CachedTriangles()) do
		
		RenderHelper.DrawWorldTriangle(trianglePoints[1], trianglePoints[2], trianglePoints[3], "50FFFFFF", 2, false)
	end
end

function Inspector.Render_Current_SectorSceneCurrentTriangle()

	local currentTriangle = Infinity.BDO.getSceneManager():getCurrentSector_CurrentTriangle()

	if table.length(currentTriangle) == 0 then
		--print("currentTriangle == 0")
		return
	end

	RenderHelper.DrawWorldTriangle(currentTriangle[1], currentTriangle[2], currentTriangle[3], "50FF50FF", 1, true)
end

function Inspector.Render_Cached_Objects()

	local lPos = Infinity.BDO.getLocalPlayer():getPosition()

	for k,entry in pairs(Inspector.Cached_Object_VertsPolys) do
		
		local show = true

		if Inspector.RenderSettings_Objects_DistanceLimit_Trigger and lPos:getDistance(entry.Object:getPosition()) > Inspector.RenderSettings_Objects_DistanceLimit_Value then
			show = false
		end

		if show and entry.Object:isVisible() then

			for kp,polygon in pairs(entry.Polygons) do

				RenderHelper.DrawWorldTriangle(entry.Vertices[polygon.X + 1], entry.Vertices[polygon.Y + 1], entry.Vertices[polygon.Z + 1], "30FFFF00", 1, false)			
			end		
		end
	end
end

function Inspector.Render_Cached_Scenes_Mesh()

	for k,entry in pairs(Inspector.Cached_Scene_VertsPolys) do
		
		for kp,polygon in pairs(entry.Polygons) do

			RenderHelper.DrawWorldTriangle(entry.Vertices[polygon.X + 1], entry.Vertices[polygon.Y + 1], entry.Vertices[polygon.Z + 1], "30FFFFFF", 1, false)			
		end	
	end
end

function Inspector.Render_Cached_Scenes_Box()

	for k,entry in pairs(Inspector.Cached_Scene_VertsPolys) do
				
		local boxA = entry.Scene:getBoxA()
		local boxAColor = "50FF0000"
		local thickness = 2

		RenderHelper.DrawWorldLine(boxA[9], boxA[10], boxAColor, thickness)
		RenderHelper.DrawWorldLine(boxA[10], boxA[6], boxAColor, thickness)
		RenderHelper.DrawWorldLine(boxA[6], boxA[5], boxAColor, thickness)
		RenderHelper.DrawWorldLine(boxA[5], boxA[9], boxAColor, thickness)

		RenderHelper.DrawWorldLine(boxA[3], boxA[7], boxAColor, thickness)
		RenderHelper.DrawWorldLine(boxA[7], boxA[8], boxAColor, thickness)
		RenderHelper.DrawWorldLine(boxA[8], boxA[4], boxAColor, thickness)
		RenderHelper.DrawWorldLine(boxA[4], boxA[3], boxAColor, thickness)

		RenderHelper.DrawWorldLine(boxA[3], boxA[5], boxAColor, thickness)
		RenderHelper.DrawWorldLine(boxA[4], boxA[6], boxAColor, thickness)
		RenderHelper.DrawWorldLine(boxA[8], boxA[10], boxAColor, thickness)
		RenderHelper.DrawWorldLine(boxA[7], boxA[9], boxAColor, thickness)
	end
end

function Inspector.Render_Cached_Scenes()

	if Inspector.RenderSettings_Scenes_ShowMesh then
		Inspector.Render_Cached_Scenes_Mesh()
	end

	if Inspector.RenderSettings_Scenes_ShowBox then
		Inspector.Render_Cached_Scenes_Box()
	end
end

function Inspector.OnRenderD2D()

	if Inspector.Rendering_SectorScene_Triangles ~= nil then

		Inspector.Render_SectorSceneTriangles()
	end

	if Inspector.Rendering_SectorScene_ShowVerticesLayers and Inspector.Rendering_SectorScene_MapDataReal ~= nil then

		Inspector.Render_ShowVerticesLayers()
	end
	
	if Inspector.Rendering_SectorScene_Objects ~= nil then
		Inspector.Render_SectorScene_Objects()	
	end

	if Inspector.Rendering_SectorScene_SingleObject ~= nil then
		Inspector.Render_SectorScene_SingleObject()	
	end

	if Inspector.Rendering_Current_SectorScene_Triangles then

		Inspector.Render_Current_SectorSceneTriangles()
	end

	if Inspector.Rendering_Current_SectorScene_CurrentTriangle then

		Inspector.Render_Current_SectorSceneCurrentTriangle()
	end

	Inspector.Render_Cached_Scenes()
	Inspector.Render_Cached_Objects()
end

function Inspector.OnUIInteraction_KeyDown(uiElement, keyCode)	
	Inspector.UIElement_Name_LastInteraction = uiElement:getName()
end

function Inspector.getInventoryInfo()
  local code =
  [[
    local selfPlayerWrapper = getSelfPlayer()
    local selfPlayer = selfPlayerWrapper:get()
    local inventory = selfPlayer:getInventoryByType(CppEnums.ItemWhereType.eInventory)

      if inventory == nil then
        return 0
      end

      local selfPlayer = selfPlayerWrapper:get()
      local useStartSlot = inventorySlotNoUserStart()
	  local invenMaxSize = inventory:sizeXXX()
	  local freeCount = inventory:getFreeCount()
	  local invenUsedSize = selfPlayer:getInventorySlotCount(false) - useStartSlot
	  local invenUsableSize = invenUsedSize - freeCount

      return invenUsableSize, freeCount, invenUsedSize
  ]]
  
  return Infinity.BDO.Lua.Execute(code)
end

function Inspector.getInventoryItems()
    local invenMaxSize = Inventory.getMaxSize()

    if invenMaxSize == 0 then return end

    local itemsTable = {}

    for i = 2, invenMaxSize - 1 do
		if Inventory.hasItemWrapper(i) then
			local name
			local slot = i
            local itemId
            local count
            local enchantKey

            name, itemId, count, enchantKey = Inventory.getItemData(i)

            if name ~= nil and itemId ~= nil then
                itemsTable[slot] =
                {
					itemId = itemId,
					slot = slot,
                    name = name,
                    count = count,
                    enchantKey = enchantKey
                }
            end
        end
    end

    return itemsTable
end

function Inspector.getEquipInfo()
  local code =
  [[
	  local invenUseSize = 0
	  local invenMaxSize = CppEnums.EquipSlotNoClient.eEquipSlotNoCount
	  
	  for i = 0, invenMaxSize do
		local itemWrapper = ToClient_getEquipmentItem(i)

		if itemWrapper ~= nil then
			invenUseSize = invenUseSize + 1
		end
	  end

	  local freeCount = invenMaxSize - invenUseSize

      return invenMaxSize, freeCount, invenUseSize
  ]]
  
  return Infinity.BDO.Lua.Execute(code)
end

function Inspector.getEquippedItems()
    local invenMaxSize = Equip.getMaxSize()

    if invenMaxSize == 0 then return end

    local itemsTable = {}

    for i = 0, 31 do
		if Equip.hasItemWrapper(i) then
			local name
			local slot = i
            local itemId
            local count
            local enchantKey

            name, itemId, count, enchantKey = Equip.getItemData(i)

            if name ~= nil and itemId ~= nil then
                itemsTable[slot] =
                {
					itemId = itemId,
					slot = slot,
                    name = name,
                    count = count,
                    enchantKey = enchantKey
                }
            end
        end
    end

    return itemsTable
end