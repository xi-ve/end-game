DebugUI = {}


local _ = nil
local _Grinder = nil
local _Cache = nil

function DebugUI.init()
  _Grinder = Grinder
  _Cache = Cache
end


DebugUI.raycastCheckDest = nil
DebugUI.raycastCheckSafe = true

DebugUI.combo1Index = -1
DebugUI.combo2Index = -1

DebugUI.actorName = nil
DebugUI.actorKey = nil
DebugUI.actorType = nil
DebugUI.actorDistance = nil
DebugUI.npcInfo = ""

DebugUI.testNavDest = Vector3(0, 0, 0)


local devMode_draw
local onGuiDraw
local isEmpty
local parse
local table_length
local table_deepLength
local hasValidItem
local sortByType

local parserEnabled = true
local parserFilterText = nil
local showFunctions = false
local displayDeepLength = false

local rainbow_showColor = false
local rainbow = false
local rainbow_l = 3
local rainbow_a_use = false
local rainbow_a = 125

local color = RenderHelper.GetColorImVec4FromHexColorString

local function getRandomColor()
  return ImVec4(255, math.random(0, 255) / 255, math.random(0, 255) / 255, math.random(0, 255) / 255)
end

local function getLightColor(degree)
  return ImVec4(degree / 255, math.random(0, 255) / 255, math.random(0, 255) / 255, math.random(0, 255) / 255)
end

devMode_draw = function()
  ImGui.Separator()

  if ImGui.Button("Test") then
    print(tostring(Server.changeToChannel_original))
    Server.changeToChannel(-5)
  end

  ImGui.Text("Last tick ms: " .. Grinder.lastPulseTime)
  ImGui.Text("Crosshair Pos: " .. VectorUtils.toString(Infinity.BDO.getLocalPlayer():getCrossHairPosition()))

  ImGui.Separator()
  ImGui.Text("Parser")

  _, parserEnabled = ImGui.Checkbox("Parser##dev_parser", parserEnabled)

  if parserEnabled then
    _, showFunctions = ImGui.Checkbox("Show functions##show_func", showFunctions)
    --  _, displayDeepLength = ImGui.Checkbox("Show (deep) table length##deep_table_length", displayDeepLength)
    --_, parserFilterText = ImGui.InputText("Filter##parser_filter", parserFilterText)
    --ImGui.SameLine()

    parse("Grinder", Grinder, false)
    parse("Cache", Cache, false)
    parse("Global", _G, false)

  end

  ImGui.Separator()

  ImGui.Text("Path:")
  if Grinder.currentProfile and Grinder.currentProfile.nav then
    if Grinder.currentProfile.nav.path then

      if Grinder.currentProfile.nav.path.dest then
        ImGui.Text("Destination: " .. VectorUtils.toString(Grinder.currentProfile.nav.path.dest))
        ImGui.Text("3D Distance: " .. Cache.playerPos:getDistance(Grinder.currentProfile.nav.path.dest))
      end

      if Grinder.currentProfile.nav.path then
        if ImGui.TreeNode("T1##t1_debug") then
          if Grinder.currentProfile.nav.path.waypoints then
            for k, v in ipairs(Grinder.currentProfile.nav.path.waypoints) do
              ImGui.Text(VectorUtils.toString(v))
            end
          end
          ImGui.TreePop()
        end

        if ImGui.TreeNode("T2##t2_debug") then
          if Grinder.currentProfile.nav.path.tier_nodes then
            for k, v in ipairs(Grinder.currentProfile.nav.path.tier_nodes.tier2_nodes) do
              ImGui.Text(VectorUtils.toString(v))
            end
          end
          ImGui.TreePop()
        end

        if ImGui.TreeNode("T3##t3_debug") then
          if Grinder.currentProfile.nav.path.tier_nodes then
            for k, v in ipairs(Grinder.currentProfile.nav.path.tier_nodes.tier3_nodes) do
              ImGui.Text(VectorUtils.toString(v))
            end
          end
          ImGui.TreePop()
        end
      end
    end
  end

  ImGui.Separator()

  ImGui.Text("Careful!! This might be able to trigger epilepsy and/or siezures!")
  _, rainbow = ImGui.Checkbox("Show internal bits (might be hard to read)##rainbow", rainbow)
  if rainbow then
    _, rainbow_showColor = ImGui.Checkbox("Show bit color##rainbow_showColor", rainbow_showColor)
    if rainbow_showColor then
      _, rainbow_a_use = ImGui.Checkbox("Set Bit mood", rainbow_a_use)
      if rainbow_a_use then
        _, rainbow_a = ImGui.SliderInt("How is their mood?", rainbow_a, 0, 255)
      end
    end
    _, rainbow_l = ImGui.SliderInt("Data amount##rainbow_l", rainbow_l, 1, 50)
    local dataAmount = rainbow_l - 1
    for i = 0, dataAmount do
      for i2 = 0, dataAmount do
        local randomColor = nil
        if rainbow_showColor then
          if rainbow_a_use then
            randomColor = getLightColor(rainbow_a)
          else
            randomColor = getRandomColor()
          end
        else

          randomColor = color("FFFFFFFF")
        end
        ImGui.TextColored(randomColor, math.random(0, 1))
        if i2 ~= dataAmount then
          ImGui.SameLine()
        end
      end
    end
  end

end

sortByType = function(key, value, useFilter)
  local filter = parserFilterText

  if type(value) == "table" then

    local useRecursiveFilter = false
    if useFilter then
      useRecursiveFilter = not (filter == nil or isEmpty(filter) or string.find(key, filter) or string.find(type(value), filter))
    end
    parse(key, value, useRecursiveFilter)
    filter = nil
    return
  end

  if (not useFilter) or (isEmpty(filter) or string.find(key, filter) or string.find(type(value), filter)) then
    if type(value) == "function" then
      if showFunctions then
        ImGui.Text(tostring(key) .. " (function)")
      end
    else
      ImGui.Text(tostring(key) .." (" .. type(value) .. ") : " .. tostring(value))
    end
  end

  filter = nil
end

hasValidItem = function(key, value, filter)
  if isEmpty(filter) then
    return true
  end

  if string.find(key, filter) or string.find(type(value), filter) then
    return true
  end


  if type(value) == "table" then
    for k, v in pairs(value) do
      local isValid = hasValidItem(k, v, filter)
      if isValid then
        return true
      end
    end
  end

  return false
end

table_deepLength = function(t)
  local count = 0
  for k, v in pairs(t) do
    if v ~= nil then
      if type(v) == "table" then
        count = count + table_deepLength(v)
      else
        count = count + 1
      end
    end
  end
  return count
end

table_length = function(t)
  local count = 0
  for k, v in pairs(t) do
    if v ~= nil then
      count = count + 1
    end
  end
  return count
end

parse = function(treenode_name, table, useFilter)
  if treenode_name and table then
    if useFilter == nil then
      useFilter = true
    end

    local filter = parserFilterText
    local isValid = hasValidItem(treenode_name, table, filter)

    if (not useFilter) or isValid then
      local lengthText = ""
      if displayDeepLength then
        lengthText = " #" .. tostring(table_length(table)) .. " (" .. tostring(table_deepLength(table)) .. ")"
      end

      ImGui.Text(lengthText)
      ImGui.SameLine()
      if ImGui.TreeNode(treenode_name) then
        for key, value in pairs(table) do
          sortByType(key, value, useFilter)
        end
        ImGui.TreePop()
      end
    end
  end

end

isEmpty = function(string)
  return (string == "" or string == nil or string == " " or string == "  ")
end

function DebugUI.draw(newWindow)
  if newWindow == nil then
    newWindow = true
  end
  if newWindow then
    ImGui.Begin("[Grinder] Debug")
  end

  if ImGui.SmallButton("Export global variables") then
    ExportGlobals()
  end

  if ImGui.Button("Run ChooseIfTownRun once (Won't do anything for u ^^)") then
    ChooseIfTownRunTask.work()
  end

  _, _Grinder.settings.log_debug = ImGui.Checkbox("Debug log (FPS drop)", _Grinder.settings.log_debug)

  ImGui.Separator()
  _, _Grinder.settings.draw_debug_freeMoveTask = ImGui.Checkbox("Render freemoving nodes (FPS drop)", _Grinder.settings.draw_debug_freeMoveTask)
  ImGui.Separator()

  if ImGui.Button("FreeMove Test") then
    local pp = _Cache.playerPos
    local randomPos = Vector3(pp.X + math.random(-1000, 1000), pp.Y, pp.Z + math.random(-1000, 1000))
    local canMoveFree = FreeMoveTask.init(randomPos)

    pp = nil
    randomPos = nil
    canMoveFree = nil
  end

  ImGui.Separator()
  ImGui.Text("Raycast Check:")
  ImGui.SameLine()
  if DebugUI.raycastCheckDest then
    ImGui.InputText("", VectorUtils.toString(DebugUI.raycastCheckDest))
  end

  if ImGui.SmallButton("Set Pos") then
    DebugUI.raycastCheckDest = _Cache.playerPos
  end
  ImGui.SameLine()
  if ImGui.SmallButton("Reset") then
    DebugUI.raycastCheckDest = nil
  end
  _, DebugUI.raycastCheckSafe = ImGui.Checkbox("Raycast Check: Safe raycast (stricter)", DebugUI.raycastCheckSafe)

  ImGui.Separator()

  ImGui.Separator()

  if DebugUI.actorKey and ActorUtils.getActor(DebugUI.actorKey) then
    DebugUI.npcInfo = tostring(DebugUI.actorName) .. " | Key: " .. tostring(DebugUI.actorKey) .. " | Type: " .. tostring(DebugUI.actorType) .. " | Distance: " .. ActorUtils.getActor(DebugUI.actorKey):getPosition():getDistance(_Cache.playerPos)
  else
    DebugUI.npcInfo = ""
  end
  ImGui.Text("Closest Actor: " .. DebugUI.npcInfo)
  ImGui.SameLine()
  if ImGui.Button("Refresh") then
    DebugUI.actorName, DebugUI.actorKey, DebugUI.actorType, DebugUI.actorDistance = ActorUtils.getClosestActorInfo()
  end
  if DebugUI.actorKey then
    if ImGui.Button("Request Shopitems") then
      Infinity.BDO.Lua.Execute("npcShop_requestList(CppEnums.ContentsType.Contents_Shop, true)")
    end
    if ImGui.Button("Sell first slot once") then
      Infinity.BDO.Lua.Execute([[getSelfPlayer():get():requestSellItem(2, 1, CppEnums.ItemWhereType.eInventory, CppEnums.ItemWhereType.eWarehouse, false)]])
    end
  end

  ImGui.Separator()
  ImGui.Text("Test navigation (using nodes):")
  ImGui.Text("Dest: " .. VectorUtils.toString(DebugUI.testNavDest))
  if ImGui.Button("Set Dest") then
    DebugUI.testNavDest = _Cache.playerPos
  end
  ImGui.SameLine()
  if ImGui.Button("Start nav") then
    _Grinder.currentlyTestingNav = true
    _Grinder.currentDest = DebugUI.testNavDest
    _Grinder.currentDestIsNode = true
  end

  devMode_draw()

  if newWindow then
    ImGui.End()
  end
end


function ExportGlobals()
  local fileName = "globalsDump.txt"
  local content = table.toString(_G)
  Infinity.FileSystem.WriteFile(fileName, content)
  fileName = nil
  content = nil
end
