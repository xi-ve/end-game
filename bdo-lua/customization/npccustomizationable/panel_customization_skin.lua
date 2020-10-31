local FrameTemplateColor = UI.getChildControl(Panel_CustomizationSkin, "Frame_Template_Color")
local SliderText = UI.getChildControl(Panel_CustomizationSkin, "StaticText_Slider_1")
local SliderControl = UI.getChildControl(Panel_CustomizationSkin, "Slider_R_Controller")
local Button_Slider = UI.getChildControl(SliderControl, "Slider_GammaController_Button")
local Static_Collision = UI.getChildControl(Panel_CustomizationSkin, "Static_Collision")
local Static_CurrentValue = UI.getChildControl(Panel_CustomizationSkin, "Static_Text_Slider_R_Left")
local sliderParamType = 0
local sliderParamIndex = 0
local sliderParam = 0
local sliderParamMin = 0
local sliderParamMax = 255
local sliderParamDefault = 0
if false == _ContentsGroup_RenewUI then
  registerEvent("EventOpenSkinUi", "OpenSkinUi")
  registerEvent("EventCloseSkinUi", "CloseSkinUi")
end
local selectedUiId
local controlOffset = 10
local contentsStartY = 0
local sliderOffset = 7
local sliderValueOffset = 10
local sliderHeight = SliderText:GetSizeY()
local currentuiId = -1
function OpenSkinUi(uiId)
  globalcurrentuiId = uiId
  currentuiId = uiId
  selectedUiId = uiId
  contentsIndex = 0
  local controlPosY = contentsStartY
  local paletteCount = getUiPaletteCount(selectedUiId, contentsIndex)
  if paletteCount == 1 then
    controlPosY = controlPosY + controlOffset
    local paletteParamType = getUiPaletteParamType(selectedUiId, contentsIndex)
    local paletteParamIndex = getUiPaletteParamIndex(selectedUiId, contentsIndex)
    local paletteIndex = getDecorationParamMethodValue(paletteParamType, paletteParamIndex)
    FrameTemplateColor:SetPosY(controlPosY)
    CreateCommonPalette(FrameTemplateColor, Static_Collision, paletteParamType, paletteParamIndex, paletteIndex)
    local colorIndex = getParam(paletteParamType, paletteParamIndex)
    UpdatePaletteMarkPosition(colorIndex)
    local Frame_Content_Color = UI.getChildControl(FrameTemplateColor, "Frame_Content")
    Static_SelectMark_Color = UI.getChildControl(Frame_Content_Color, "Static_SelectMark")
    Frame_Content_Color:SetChildIndex(Static_SelectMark_Color, 9999)
    controlPosY = controlPosY + FrameTemplateColor:GetSizeY() + controlOffset
  end
  local sliderCount = getUiSliderCount(selectedUiId, contentsIndex)
  if sliderCount == 1 then
    local sliderIndex = 0
    sliderParamType = getUiSliderParamType(selectedUiId, contentsIndex, sliderIndex)
    sliderParamIndex = getUiSliderParamIndex(selectedUiId, contentsIndex, sliderIndex)
    local sliderParam = getParam(sliderParamType, sliderParamIndex)
    sliderParamMin = getParamMin(sliderParamType, sliderParamIndex)
    sliderParamMax = getParamMax(sliderParamType, sliderParamIndex)
    sliderParamDefault = getParamDefault(sliderParamType, sliderParamIndex)
    setSliderValue(SliderControl, sliderParam, sliderParamMin, sliderParamMax)
    SliderControl:addInputEvent("Mouse_LPress", "UpdateSkinSlider()")
    Button_Slider:addInputEvent("Mouse_LPress", "UpdateSkinSlider()")
    Button_Slider:addInputEvent("Mouse_LUp", "add_CurrentHistory()")
    SliderControl:addInputEvent("Mouse_LUp", "add_CurrentHistory()")
    local sliderDesc = getUiSliderDescName(selectedUiId, contentsIndex, sliderIndex)
    SliderText:SetText(PAGetString(Defines.StringSheet_GAME, sliderDesc))
    SliderText:SetPosY(controlPosY)
    SliderText:SetShow(true)
    SliderControl:SetPosY(controlPosY + sliderOffset)
    SliderControl:SetShow(true)
    Static_CurrentValue:SetText(sliderParam)
    Static_CurrentValue:SetPosY(controlPosY + sliderValueOffset)
    Static_CurrentValue:SetShow(true)
    controlPosY = controlPosY + sliderHeight
  end
  Panel_CustomizationSkin:SetSize(Panel_CustomizationSkin:GetSizeX(), controlPosY + controlOffset)
  updateGroupFrameControls(Panel_CustomizationSkin:GetSizeY(), Panel_CustomizationSkin)
  Panel_CustomizationSkin:SetShow(true)
  FrameTemplateColor:UpdateContentScroll()
  FrameTemplateColor:UpdateContentPos()
end
function CloseSkinUi()
  globalcurrentuiId = -2
end
function UpdateSkinSlider()
  local value = getSliderValue(SliderControl, sliderParamMin, sliderParamMax)
  setParam(sliderParamType, sliderParamIndex, value)
  Static_CurrentValue:SetText(value)
  setGlobalCheck(true)
end
function SkinHistoryApplyUpdate()
  if globalcurrentuiId ~= currentuiId then
    return
  end
  OpenSkinUi(currentuiId)
end
