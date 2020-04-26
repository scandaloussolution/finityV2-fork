repeat wait() print("Finity not found.. waiting...") until shared.Finity

local Finity = shared.Finity

return function(Object, Data)
	Object.MouseButton1Click:Connect(function()
		Finity:OpenFolder(Data.Children)
	end)
end
