local TweenService = game:GetService("TweenService")
local Finity = shared.Finity

return function(Object)
	local BaseColor
	local Image = false
	local Focused = false
	
	if Object:IsA("ImageButton") then
		BaseColor = Object.ImageColor3
		Image = true
	else
		BaseColor = Object.BackgroundColor3
	end
	
	Object.MouseEnter:Connect(function()
		if Image then
			TweenService:Create(Object, TweenInfo.new(0.2), {
				ImageColor3 = Color3.new(BaseColor.R * 1.1, BaseColor.G * 1.1, BaseColor.B * 1.1)
			}):Play()
		else
			TweenService:Create(Object, TweenInfo.new(0.2), {
				BackgroundColor3 = Color3.new(BaseColor.R * 1.1, BaseColor.G * 1.1, BaseColor.B * 1.1)
			}):Play()
		end
	end)
	
	Object.MouseLeave:Connect(function()
		if not Focused then
			if Image then
				TweenService:Create(Object, TweenInfo.new(0.2), {
					ImageColor3 = BaseColor
				}):Play()
			else
				TweenService:Create(Object, TweenInfo.new(0.2), {
					BackgroundColor3 = BaseColor
				}):Play()
			end
		end
	end)
	
	Object.MouseButton1Down:Connect(function()
		if Image then
			TweenService:Create(Object, TweenInfo.new(0.2), {
				ImageColor3 = Color3.new(BaseColor.R * 0.8, BaseColor.G * 0.8, BaseColor.B * 0.8)
			}):Play()
		else
			TweenService:Create(Object, TweenInfo.new(0.2), {
				BackgroundColor3 = Color3.new(BaseColor.R * 0.8, BaseColor.G * 0.8, BaseColor.B * 0.8)
			}):Play()
		end
	end)
	
	Object.TextBox.Focused:Connect(function()
		Focused = true
	end)
	
	Object.TextBox.FocusLost:Connect(function()
		Focused = false
		
		if Image then
			TweenService:Create(Object, TweenInfo.new(0.2), {
				ImageColor3 = BaseColor
			}):Play()
		else
			TweenService:Create(Object, TweenInfo.new(0.2), {
				BackgroundColor3 = BaseColor
			}):Play()
		end
	end)
end