-- Enums get assigned 0 here so lua parser can properly parse it. The actual enum value will be different and set by the engine.
ImGuiTreeNodeFlags_None = 0
ImGuiTreeNodeFlags_Selected = 0
ImGuiTreeNodeFlags_Framed = 0
ImGuiTreeNodeFlags_AllowItemOverlap = 0
ImGuiTreeNodeFlags_NoTreePushOnOpen = 0
ImGuiTreeNodeFlags_NoAutoOpenOnLog = 0
ImGuiTreeNodeFlags_DefaultOpen = 0
ImGuiTreeNodeFlags_OpenOnDoubleClick = 0
ImGuiTreeNodeFlags_OpenOnArrow = 0
ImGuiTreeNodeFlags_Leaf = 0
ImGuiTreeNodeFlags_Bullet = 0
ImGuiTreeNodeFlags_FramePadding = 0
ImGuiTreeNodeFlags_NavLeftJumpsBackHere = 0
ImGuiTreeNodeFlags_CollapsingHeader = 0

ImGuiWindowFlags_None = 0
ImGuiWindowFlags_NoTitleBar = 0
ImGuiWindowFlags_NoResize = 0
ImGuiWindowFlags_NoMove = 0
ImGuiWindowFlags_NoScrollbar = 0
ImGuiWindowFlags_NoScrollWithMouse = 0
ImGuiWindowFlags_NoCollapse = 0
ImGuiWindowFlags_AlwaysAutoResize = 0
ImGuiWindowFlags_NoSavedSettings = 0
ImGuiWindowFlags_NoInputs = 0
ImGuiWindowFlags_MenuBar = 0
ImGuiWindowFlags_HorizontalScrollbar = 0
ImGuiWindowFlags_NoFocusOnAppearing = 0
ImGuiWindowFlags_NoBringToFrontOnFocus = 0
ImGuiWindowFlags_AlwaysVerticalScrollbar = 0
ImGuiWindowFlags_AlwaysHorizontalScrollbar = 0
ImGuiWindowFlags_AlwaysUseWindowPadding = 0
ImGuiWindowFlags_NoNavInputs = 0
ImGuiWindowFlags_NoNavFocus = 0
ImGuiWindowFlags_NoNav = 0

ImGuiInputTextFlags_None = 0
ImGuiInputTextFlags_CharsDecimal = 0
ImGuiInputTextFlags_CharsHexadecimal = 0
ImGuiInputTextFlags_CharsUppercase = 0
ImGuiInputTextFlags_CharsNoBlank = 0
ImGuiInputTextFlags_AutoSelectAll = 0
ImGuiInputTextFlags_EnterReturnsTrue = 0
ImGuiInputTextFlags_CallbackCompletion = 0
ImGuiInputTextFlags_CallbackHistory = 0
ImGuiInputTextFlags_CallbackAlways = 0
ImGuiInputTextFlags_CallbackCharFilter = 0
ImGuiInputTextFlags_AllowTabInput = 0
ImGuiInputTextFlags_CtrlEnterForNewLine = 0
ImGuiInputTextFlags_NoHorizontalScroll = 0
ImGuiInputTextFlags_AlwaysInsertMode = 0
ImGuiInputTextFlags_ReadOnly = 0
ImGuiInputTextFlags_Password = 0
ImGuiInputTextFlags_NoUndoRedo = 0
ImGuiInputTextFlags_CharsScientific = 0
ImGuiInputTextFlags_CallbackResize = 0

ImGuiKey_Tab = 0
ImGuiKey_LeftArrow = 0
ImGuiKey_RightArrow = 0
ImGuiKey_UpArrow = 0
ImGuiKey_DownArrow = 0
ImGuiKey_PageUp = 0
ImGuiKey_PageDown = 0
ImGuiKey_Home = 0
ImGuiKey_End = 0
ImGuiKey_Delete = 0
ImGuiKey_Backspace = 0
ImGuiKey_Enter = 0
ImGuiKey_Escape = 0
ImGuiKey_A = 0
ImGuiKey_C = 0
ImGuiKey_V = 0
ImGuiKey_X = 0
ImGuiKey_Y = 0
ImGuiKey_Z = 0

ImGuiCol_Text = 0
ImGuiCol_TextDisabled = 0
ImGuiCol_WindowBg = 0
ImGuiCol_ChildBg = 0
ImGuiCol_PopupBg = 0
ImGuiCol_Border = 0
ImGuiCol_BorderShadow = 0
ImGuiCol_FrameBg = 0
ImGuiCol_FrameBgHovered = 0
ImGuiCol_FrameBgActive = 0
ImGuiCol_TitleBg = 0
ImGuiCol_TitleBgCollapsed = 0
ImGuiCol_TitleBgActive = 0
ImGuiCol_MenuBarBg = 0
ImGuiCol_ScrollbarBg = 0
ImGuiCol_ScrollbarGrab = 0
ImGuiCol_ScrollbarGrabHovered = 0
ImGuiCol_ScrollbarGrabActive = 0
ImGuiCol_CheckMark = 0
ImGuiCol_SliderGrab = 0
ImGuiCol_SliderGrabActive = 0
ImGuiCol_Button = 0
ImGuiCol_ButtonHovered = 0
ImGuiCol_ButtonActive = 0
ImGuiCol_Header = 0
ImGuiCol_HeaderHovered = 0
ImGuiCol_HeaderActive = 0
ImGuiCol_Separator = 0
ImGuiCol_SeparatorHovered = 0
ImGuiCol_SeparatorActive = 0
ImGuiCol_ResizeGrip = 0
ImGuiCol_ResizeGripHovered = 0
ImGuiCol_ResizeGripActive = 0
ImGuiCol_PlotLines = 0
ImGuiCol_PlotLinesHovered = 0
ImGuiCol_PlotHistogram = 0
ImGuiCol_PlotHistogramHovered = 0
ImGuiCol_TextSelectedBg = 0
ImGuiCol_DragDropTarget = 0
ImGuiCol_NavHighlight = 0
ImGuiCol_NavWindowingHighlight = 0
ImGuiCol_NavWindowingDimBg = 0
ImGuiCol_ModalWindowDimBg = 0
ImGuiCol_COUNT = 0

ImGuiStyleVar_Alpha = 0 -- float     Alpha
ImGuiStyleVar_WindowPadding = 0 -- ImVec2    WindowPadding
ImGuiStyleVar_WindowRounding = 0 -- float     WindowRounding
ImGuiStyleVar_WindowBorderSize = 0 -- float     WindowBorderSize
ImGuiStyleVar_WindowMinSize = 0 -- ImVec2    WindowMinSize
ImGuiStyleVar_WindowTitleAlign = 0 -- ImVec2    WindowTitleAlign
ImGuiStyleVar_ChildRounding = 0 -- float     ChildRounding
ImGuiStyleVar_ChildBorderSize = 0 -- float     ChildBorderSize
ImGuiStyleVar_PopupRounding = 0 -- float     PopupRounding
ImGuiStyleVar_PopupBorderSize = 0 -- float     PopupBorderSize
ImGuiStyleVar_FramePadding = 0 -- ImVec2    FramePadding
ImGuiStyleVar_FrameRounding = 0 -- float     FrameRounding
ImGuiStyleVar_FrameBorderSize = 0 -- float     FrameBorderSize
ImGuiStyleVar_ItemSpacing = 0 -- ImVec2    ItemSpacing
ImGuiStyleVar_ItemInnerSpacing = 0 -- ImVec2    ItemInnerSpacing
ImGuiStyleVar_IndentSpacing = 0 -- float     IndentSpacing
ImGuiStyleVar_ScrollbarSize = 0 -- float     ScrollbarSize
ImGuiStyleVar_ScrollbarRounding = 0 -- float     ScrollbarRounding
ImGuiStyleVar_GrabMinSize = 0 -- float     GrabMinSize
ImGuiStyleVar_GrabRounding = 0 -- float     GrabRounding
ImGuiStyleVar_ButtonTextAlign = 0 -- ImVec2    ButtonTextAlign

ImGuiMouseCursor_Arrow = 0
ImGuiMouseCursor_TextInput = 0
ImGuiMouseCursor_ResizeNS = 0
ImGuiMouseCursor_ResizeEW = 0
ImGuiMouseCursor_ResizeNESW = 0
ImGuiMouseCursor_ResizeNWSE = 0

ImGuiCond_Always = 0
ImGuiCond_Once = 0
ImGuiCond_FirstUseEver = 0
ImGuiCond_Appearing = 0

ImGuiColorEditFlags_None = 0
ImGuiColorEditFlags_NoAlpha = 0
ImGuiColorEditFlags_NoPicker = 0
ImGuiColorEditFlags_NoOptions = 0
ImGuiColorEditFlags_NoSmallPreview = 0
ImGuiColorEditFlags_NoInputs = 0
ImGuiColorEditFlags_NoTooltip = 0
ImGuiColorEditFlags_NoLabel = 0
ImGuiColorEditFlags_NoSidePreview = 0
ImGuiColorEditFlags_NoDragDrop = 0
ImGuiColorEditFlags_AlphaBar = 0
ImGuiColorEditFlags_AlphaPreview = 0
ImGuiColorEditFlags_AlphaPreviewHalf = 0
ImGuiColorEditFlags_HDR = 0
ImGuiColorEditFlags_RGB = 0
ImGuiColorEditFlags_HSV = 0
ImGuiColorEditFlags_HEX = 0
ImGuiColorEditFlags_Uint8 = 0
ImGuiColorEditFlags_Float = 0
ImGuiColorEditFlags_PickerHueBar = 0
ImGuiColorEditFlags_PickerHueWheel = 0

---@class ImVec2
local ImVec2 = {}
---@type integer
ImVec2.x = 0
---@type integer
ImVec2.y = 0

---Creates a new ImVec2
---@param x integer
---@param y integer
function ImVec2(x, y)
end

---@class ImVec4
local ImVec4 = {}
---@type integer
ImVec4.x = 0
---@type integer
ImVec4.y = 0
---@type integer
ImVec4.z = 0
---@type integer
ImVec4.w = 0

---Creates a new ImVec4
---@param x integer
---@param y integer
---@param z integer
---@param w integer
function ImVec4(x, y, z, w)
end

---@class ImGuiID
local ImGuiID = {}

ImGui = {}

---@return boolean
---@param name string
function ImGui.Begin(name)
end

---@return boolean
---@param name string
---@param opened boolean
---@param flags number
function ImGui.Begin(name, opened, flags)
end
function ImGui.End()
end

---@return boolean
function ImGui.BeginChild(name, size, border, extra_flags)
end
---@return boolean
function ImGui.BeginChild(id, size, border, extra_flags)
end

function ImGui.EndChild()
end

---@return ImVec2
function ImGui.GetContentRegionMax()
end
---@return ImVec2
function ImGui.GetContentRegionAvail()
end
---@return number 
function ImGui.GetContentRegionAvailWidth()
end
---@return ImVec2 
function ImGui.GetWindowContentRegionMin()
end
---@return ImVec2
function ImGui.GetWindowContentRegionMax()
end
---@return number 
function ImGui.GetWindowContentRegionWidth()
end

function ImGui.SetWindowFontScale(scale)
end
---@return ImVec2
function ImGui.GetWindowPos()
end
---@return ImVec2
function ImGui.GetWindowSize()
end
---@return number 
function ImGui.GetWindowWidth()
end
---@return number 
function ImGui.GetWindowHeight()
end
---@return boolean 
function ImGui.IsWindowCollapsed()
end

function ImGui.SetNextWindowPos(pos, cond)
end

function ImGui.SetNextWindowSize(size, cond)
end

function ImGui.SetNextWindowContentSize(size)
end

function ImGui.SetNextWindowCollapsed(collapsed, cond)
end

function ImGui.SetNextWindowFocus()
end

function ImGui.SetWindowPos(pos, cond)
end

function ImGui.SetWindowSize(size, cond)
end

function ImGui.SetWindowCollapsed(collapsed, cond)
end

function ImGui.SetWindowFocus()
end

---@return number 
function ImGui.GetScrollX()
end
---@return number 
function ImGui.GetScrollY()
end
---@return number 
function ImGui.GetScrollMaxX()
end
---@return number 
function ImGui.GetScrollMaxY()
end

function ImGui.SetScrollX(v)
end

function ImGui.SetScrollY(v)
end

function ImGui.SetScrollHere(center_y_ratio)
end

function ImGui.SetScrollFromPosY(pos_y, center_y_ratio)
end

function ImGui.SetKeyboardFocusHere(offset)
end

function ImGui.PushItemWidth(w)
end

function ImGui.PopItemWidth()
end
---@return number 
function ImGui.CalcItemWidth()
end

function ImGui.BeginGroup()
end

function ImGui.EndGroup()
end

function ImGui.Separator()
end

function ImGui.SameLine(local_pos_x, spacing_w)
end

function ImGui.Spacing()
end

function ImGui.Dummy(size)
end

function ImGui.Indent(w)
end

function ImGui.Unindent(w)
end

function ImGui.Columns(count, id, border)
end

function ImGui.NextColumn()
end
---@return integer
function ImGui.GetColumnIndex()
end
---@return number 
function ImGui.GetColumnOffset(column_index)
end

function ImGui.SetColumnOffset(column_index, offset_x)
end
---@return number 
function ImGui.GetColumnWidth(column_index)
end

function ImGui.SetColumnWidth(column_index, width)
end
---@return integer
function ImGui.GetColumnsCount()
end
---@return ImVec2
function ImGui.GetCursorPos()
end
---@return number 
function ImGui.GetCursorPosX()
end
---@return number 
function ImGui.GetCursorPosY()
end

function ImGui.SetCursorPos(pos)
end

function ImGui.SetCursorPosX(v)
end

function ImGui.SetCursorPosY(v)
end
---@return number 
function ImGui.GetCursorStartPos()
end
---@return number 
function ImGui.GetCursorScreenPos()
end

function ImGui.SetCursorScreenPos(pos)
end
---@return number 
function ImGui.GetTextLineHeight()
end
---@return number 
function ImGui.GetTextLineHeightWithSpacing()
end

function ImGui.PushID(id)
end

function ImGui.PushID(id_begin, id_end)
end

function ImGui.PushID(id)
end

function ImGui.PopID()
end

---@return ImGuiID
function ImGui.GetID(id)
end
---@return ImGuiID
function ImGui.GetID(id_begin, id_end)
end

---@return boolean
function ImGui.ColorButton(str_id, col, size)
end

function ImGui.Text(text)
end

function ImGui.TextColored(color, text)
end

function ImGui.TextDisabled(text)
end

function ImGui.TextWrapped(text)
end

function ImGui.TextUnformatted(text, text_end)
end

function ImGui.LabelText(label, text)
end

function ImGui.Bullet()
end

function ImGui.BulletText(text)
end
---@return boolean
function ImGui.Button(label, size)
end
---@return boolean
function ImGui.SmallButton(text)
end
---@return boolean
function ImGui.InvisibleButton(str_id, size)
end

function ImGui.Image(user_texture_id, size, uv0, uv1, tint_col, border_col)
end
---@return boolean 
function ImGui.ImageButton(user_texture_id, size, uv0, uv1, frame_padding, bg_col, tint_col)
end

---@return boolean
function ImGui.CollapsingHeader(label, default_open, flags)
end
---@return boolean
function ImGui.Checkbox(label, v)
end
---@return boolean
function ImGui.RadioButton(label, active)
end
---@return boolean
function ImGui.Combo(label, current_item, items, height_in_items)
end
---@return boolean
function ImGui.ColorEdit3(label, color, flags)
end
---@return boolean
function ImGui.ColorEdit4(label, color, flags)
end

---@return boolean
function ImGui.DragFloat(label, v, v_speed, v_min, v_max, display_format, power)
end
---@return boolean
function ImGui.DragFloat2(label, items, v_speed, v_min, v_max, display_format, power)
end
---@return boolean 
function ImGui.DragFloat3(label, items, v_speed, v_min, v_max, display_format, power)
end
---@return boolean
function ImGui.DragFloat4(label, items, v_speed, v_min, v_max, display_format, power)
end
---@return boolean
function ImGui.DragFloatRange2(label, v_current_min, v_current_max, v_speed, v_min, v_max, display_format, power)
end

---@return boolean
function ImGui.DragInt(label, v, v_speed, v_min, v_max, display_format)
end
---@return boolean
function ImGui.DragInt2(label, items, v_speed, v_min, v_max, display_format)
end
---@return boolean
function ImGui.DragInt3(label, items, v_speed, v_min, v_max, display_format)
end
---@return boolean
function ImGui.DragInt4(label, items, v_speed, v_min, v_max, display_format)
end
---@return boolean
function ImGui.DragIntRange2(label, v_current_min, v_current_max, v_speed, v_min, v_max, display_format)
end

---@return boolean 
function ImGui.InputText(label, text, max_size, flags)
end
---@return boolean
function ImGui.InputTextMultiline(label, text, max_size, size, flags)
end

---@return boolean
function ImGui.InputFloat(label, v, step, step_fast, extra_flags)
end
---@return boolean
function ImGui.InputFloat2(label, items, extra_flags)
end
---@return boolean 
function ImGui.InputFloat3(label, items, extra_flags)
end
---@return boolean
function ImGui.InputFloat4(label, items, extra_flags)
end

---@return boolean 
function ImGui.InputInt(label, v, step, step_fast, extra_flags)
end
---@return boolean
function ImGui.InputInt2(label, items, extra_flags)
end
---@return boolean
function ImGui.InputInt3(label, items, extra_flags)
end
---@return boolean
function ImGui.InputInt4(label, items, extra_flags)
end

---@return boolean
function ImGui.SliderFloat(label, v, v_min, v_max, display_format, power)
end
---@return boolean
function ImGui.SliderFloat2(label, items, v_min, v_max, display_format, power)
end
---@return boolean
function ImGui.SliderFloat3(label, items, v_min, v_max, display_format, power)
end
---@return boolean
function ImGui.SliderFloat4(label, items, v_min, v_max, display_format, power)
end

---@return boolean 
function ImGui.SliderInt(label, v, v_min, v_max, display_format)
end
---@return boolean
function ImGui.SliderInt2(label, items, v_min, v_max, display_format)
end
---@return boolean
function ImGui.SliderInt3(label, items, v_min, v_max, display_format)
end
---@return boolean
function ImGui.SliderInt4(label, items, v_min, v_max, display_format)
end

---@return boolean
function ImGui.VSliderFloat(label, size, v, v_min, v_max, display_format, power)
end
---@return boolean
function ImGui.VSliderInt(label, size, v, v_min, v_max, display_format)
end

---@return boolean 
function ImGui.TreeNode(label)
end

function ImGui.TreePush(id)
end

function ImGui.TreePop()
end

---@return boolean
function ImGui.Selectable(label, selected, flags, size)
end

---@return boolean
function ImGui.ListBox(label, current_item, items, height_in_items)
end
---@return boolean
function ImGui.ListBoxHeader(label, size)
end
---@return boolean
function ImGui.ListBoxHeader(label, items_count, height_in_items)
end

function ImGui.ListBoxFooter()
end

---@return boolean 
function ImGui.IsItemHovered(flags)
end
---@return boolean 
function ImGui.IsItemActive()
end
---@return boolean 
function ImGui.IsItemFocused()
end
---@return boolean 
function ImGui.IsItemClicked(mouse_button)
end
---@return boolean 
function ImGui.IsItemVisible()
end
---@return boolean 
function ImGui.IsItemEdited()
end
---@return boolean 
function ImGui.IsItemDeactivated()
end
---@return boolean 
function ImGui.IsItemDeactivatedAfterEdit()
end
---@return boolean 
function ImGui.IsAnyItemHovered()
end
---@return boolean 
function ImGui.IsAnyItemActive()
end
---@return boolean 
function ImGui.IsAnyItemFocused()
end
---@return ImVec2 
function ImGui.GetItemRectMin()
end
---@return ImVec2 
function ImGui.GetItemRectMax()
end
---@return ImVec2 
function ImGui.GetItemRectSize()
end

function ImGui.SetItemAllowOverlap()
end
---@return number 
function ImGui.GetTime()
end

function ImGui.PushStyleColor1(idx, color)
end

function ImGui.PushStyleColor2(idx, color)
end

function ImGui.PopStyleColor(count)
end

function ImGui.PushStyleVar1(idx, val)
end

function ImGui.PushStyleVar2(idx, val)
end

function ImGui.PopStyleVar(count)
end

function ImGui.SetTooltip(text)
end

function ImGui.BeginTooltip()
end

function ImGui.EndTooltip()
end

---@return boolean 
function ImGui.BeginMainMenuBar()
end

function ImGui.EndMainMenuBar()
end

---@return boolean 
function ImGui.BeginMenuBar()
end

function ImGui.EndMenuBar()
end

---@return boolean 
function ImGui.BeginMenu(text, enabled)
end

function ImGui.EndMenu()
end

---@return boolean 
function ImGui.MenuItem(text, shortcut, selected, enabled)
end

function ImGui.OpenPopup(id)
end

---@return boolean 
function ImGui.BeginPopup(id)
end
---@return boolean 
function ImGui.BeginPopupModal(name, opened, extra_flags)
end
---@return boolean 
function ImGui.BeginPopupContextItem(id, mouse_button)
end
---@return boolean 
function ImGui.BeginPopupContextVoid(id, mouse_button)
end

function ImGui.EndPopup()
end

function ImGui.CloseCurrentPopup()
end
