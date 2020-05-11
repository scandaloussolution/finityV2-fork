local LocalPlayer = game:GetService("Players").LocalPlayer
local Mouse = LocalPlayer:GetMouse()
local UserInputService = game:GetService("UserInputService")

repeat wait() until shared.Finity

local Finity = shared.Finity

return function(Object, Data)
	local InSliderRange = false
	local MouseDown = false
	
	local function SliderLoop()
		while MouseDown do
			wait()
			
			local SliderBarAbsolutePositionX = Object.SliderFrame.SliderBar.AbsolutePosition.X
			local MousePositionX = Mouse.X
			local Value = MousePositionX - SliderBarAbsolutePositionX
			local Ratio = math.clamp(Value / Object.SliderFrame.AbsoluteSize.X, 0, 1)
			local Multiplier = math.clamp((Data.Max or 1) - (Data.Min or 0), (Data.Min or 0), (Data.Max or 1e21))
			local Value = Ratio * Multiplier + (Data.Min or 0)
			
			Data.Value = Value
			
			if Data.Callback and type(Data.Callback) == "function" then
				local S, E = pcall(Data.Callback, Data.Value)
				
				if not S then warn("Callback error:", E) end
			end
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
				SliderLoop()
			end
		end
	end)
	
	UserInputService.InputEnded:Connect(function(Input)
		if Input.UserInputType == Enum.UserInputType.MouseButton1 then
			MouseDown = false
		end
	end)
end