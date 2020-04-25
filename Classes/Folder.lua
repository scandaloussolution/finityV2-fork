local Finity = shared.Finity
print(Finity)

return function(Object, Data)
	Object.MouseButton1Click:Connect(function()
		Finity:OpenFolder(Data)
	end)
end