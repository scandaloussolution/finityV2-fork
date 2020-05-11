repeat wait() until shared.Finity

local Finity = shared.Finity

return function(Object, Data)
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

	Object.MouseButton1Click:Connect(function()
		Object.Textbox:CaptureFocus()
	end)

	Object.TextBox.FocusLost:Connect(function()
		if Data.Callback and type(Data.Callback) == "function" then
			pcall(function()
				Data.Value = Object.TextBox.Text
				Data.Callback(Object.TextBox.Text)
			end)
		end
	end)
end