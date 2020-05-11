local TweenService = game:GetService("TweenService")

repeat wait() until shared.Finity

local Finity = shared.Finity

return function(Object, Data)
	Object.MouseButton1Click:Connect(function()
		Data.Value = not Data.Value
		
		if Data.Callback and type(Data.Callback) == "function" then
			if Data.Value ~= nil then
				pcall(function()
					Data.Callback(Data.Value)
				end)
			end
		end
		
		if Data.Value then
			TweenService:Create(Object.CheckboxFrame.Checked, TweenInfo.new(0.2), {
				ImageTransparency = 0
			}):Play()
		else
			TweenService:Create(Object.CheckboxFrame.Checked, TweenInfo.new(0.2), {
				ImageTransparency = 1
			}):Play()
		end
	end)
	
	if Data.Value then
		Object.CheckboxFrame.Checked.ImageTransparency = 0
	else
		Object.CheckboxFrame.Checked.ImageTransparency = 1
	end
end