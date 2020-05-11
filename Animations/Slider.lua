local LocalPlayer = game:GetService("Players").LocalPlayer
local Mouse = LocalPlayer:GetMouse()
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

repeat wait() until shared.Finity

local Finity = shared.Finity

return function(Object, Data)
	local InSliderRange = false
	local MouseDown = false
	
	local function SliderLoop()
		while MouseDown do
			local SliderBarAbsolutePositionX = Object.SliderFrame.SliderBar.AbsolutePosition.X
			local MousePositionX = Mouse.X
			local Value = MousePositionX - SliderBarAbsolutePositionX
			local Ratio = math.clamp(Value / Object.SliderFrame.AbsoluteSize.X, 0, 1)
			local Multiplier = math.clamp((Data.Max or 1) - (Data.Min or 0), (Data.Min or 0), (Data.Max or 1e21))
			local Value = Ratio * Multiplier + (Data.Min or 0)
			
			Object.SliderFrame.Tooltip.Value.Text = math.floor(Value * 100) / 100
			
			wait()
			
			TweenService:Create(Object.SliderFrame.SliderBar.Subtractor, TweenInfo.new(0.1), {Size = UDim2.new(1 - Ratio, 0, 1)}):Play()
			TweenService:Create(Object.SliderFrame.Slider, TweenInfo.new(0.1), {Position = UDim2.new(Ratio, 0, 0.5)}):Play()
			TweenService:Create(Object.SliderFrame.Tooltip, TweenInfo.new(0.1), {Position = UDim2.new(Ratio), Size = UDim2.new(0, Object.SliderFrame.Tooltip.Value.TextBounds.X + 8, 0, 18)}):Play()
		end
	end
	
	Object.SliderFrame.MouseEnter:Connect(function()
		InSliderRange = true
	end)
	
	Object.SliderFrame.MouseLeave:Connect(function()
		InSliderRange = false
	end)
	
	UserInputService.InputBegan:Connect(function(Input)
		if Input.UserInputType == Enum.UserInputType.MouseButton1 then
			MouseDown = true
			
			if InSliderRange then
				TweenService:Create(Object.SliderFrame.Tooltip, TweenInfo.new(0.1), {ImageTransparency = 0.5}):Play()
				TweenService:Create(Object.SliderFrame.Tooltip.Value, TweenInfo.new(0.1), {TextTransparency = 0}):Play()
				SliderLoop()
			end
		end
	end)
	
	UserInputService.InputEnded:Connect(function(Input)
		if Input.UserInputType == Enum.UserInputType.MouseButton1 then
			MouseDown = false
			
			TweenService:Create(Object.SliderFrame.Tooltip, TweenInfo.new(0.1), {ImageTransparency = 1}):Play()
			TweenService:Create(Object.SliderFrame.Tooltip.Value, TweenInfo.new(0.1), {TextTransparency = 1}):Play()
		end
	end)
end