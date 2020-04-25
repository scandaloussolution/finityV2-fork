local Finity = shared.Finity

return function(Object, Data)
	Object.TextBox.FocusLost:Connect(function()
		if Data.Callback and type(Data.Callback) == "function" then
			pcall(function()
				Data.Value = Object.TextBox.Text
				Data.Callback(Object.TextBox.Text)
			end)
		end
	end)
	
	if Data.Value then
		Object.TextBox.Text = Data.Value
	else
		Data.Value = ""
	end
	
	if Data.Placeholder then
		Object.TextBox.PlaceholderText = Data.Placeholder
	else
		Data.Placeholder = "Value"
	end
end