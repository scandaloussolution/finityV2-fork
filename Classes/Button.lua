repeat wait() until shared.Finity

local Finity = shared.Finity

return function(Object, Data)
	Object.MouseButton1Click:Connect(function()
		if Data.Callback and type(Data.Callback) == "function" then
			pcall(function()
				Data.Callback()
			end)
		end
	end)
end