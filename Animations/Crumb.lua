local TweenService = game:GetService("TweenService")
local Finity = shared.Finity

return function(Crumb)
	local BaseColor = Crumb.CrumbText.TextColor3
	
	Crumb.CrumbText.TextTransparency = 1
	Crumb.Arrow.TextTransparency = 1
	
	TweenService:Create(Crumb.CrumbText, TweenInfo.new(0.3), {TextTransparency = 0}):Play()
	TweenService:Create(Crumb.Arrow, TweenInfo.new(0.3), {TextTransparency = 0}):Play()
	
	Crumb.Size = UDim2.new(0, 20 + Crumb.CrumbText.TextBounds.X, 1, 0)
	
	Crumb.MouseButton1Down:Connect(function()
		TweenService:Create(Crumb.CrumbText, TweenInfo.new(0.3), {TextColor3 = Color3.new(BaseColor.R * 0.6, BaseColor.G * 0.6, BaseColor.B * 0.6)}):Play()
		TweenService:Create(Crumb.Arrow, TweenInfo.new(0.3), {TextColor3 = Color3.new(BaseColor.R * 0.6, BaseColor.G * 0.6, BaseColor.B * 0.6)}):Play()
	end)
	
	Crumb.MouseButton1Up:Connect(function()
		TweenService:Create(Crumb.CrumbText, TweenInfo.new(0.3), {TextColor3 = BaseColor, TextTransparency = 0}):Play()
		TweenService:Create(Crumb.Arrow, TweenInfo.new(0.3), {TextColor3 = BaseColor, TextTransparency = 0}):Play()
	end)
	
	Crumb.MouseEnter:Connect(function()
		TweenService:Create(Crumb.CrumbText, TweenInfo.new(0.3), {TextColor3 = Color3.new(BaseColor.R * 1.5, BaseColor.G * 1.5, BaseColor.B * 1.5)}):Play()
		TweenService:Create(Crumb.Arrow, TweenInfo.new(0.3), {TextColor3 = Color3.new(BaseColor.R * 1.5, BaseColor.G * 1.5, BaseColor.B * 1.5)}):Play()
	end)
	
	Crumb.MouseLeave:Connect(function()
		TweenService:Create(Crumb.CrumbText, TweenInfo.new(0.3), {TextColor3 = BaseColor}):Play()
		TweenService:Create(Crumb.Arrow, TweenInfo.new(0.3), {TextColor3 = BaseColor}):Play()
	end)
end