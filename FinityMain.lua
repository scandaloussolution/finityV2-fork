local FinityV2 = {}

FinityV2.DeveloperMode = false

print("monkey")

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()

function FinityV2.require(Path)
    if type(Path) == "string" then
		if FinityV2.DeveloperMode then
			Path = Path:sub(1, string.len(Path) - 4)
			local Child = script
			
			for NextChild in string.gmatch(Path, "%a+") do
				Child = Child:FindFirstChild(NextChild)
			end
			
			if Child and Child:IsA("ModuleScript") then
				return require(Child)
			end
		else
			Path = Path:gsub("\\", "/")
			return loadstring(game:HttpGet("https://raw.githubusercontent.com/detourious/finityV2/master/"..Path, true))()
		end
	end
end

function FinityV2.create(Object)
    if type(Object) == "string" then
		if FinityV2.DeveloperMode then
			if Object and script.Objects:FindFirstChild(Object):IsA("ModuleScript") then
				return require(script.Objects[Object])()
			end
		else
			Object = Object:gsub("\\", "/")
			return loadstring(game:HttpGet("https://raw.githubusercontent.com/detourious/finityV2/master/Objects/"..Object..".lua", true))()()
		end
	end
end

function FinityV2.new(Name, Theme, Hierarchy, AuthToken) -- Constructor
	local Finity = {} -- Main class
	Finity.Directory = {} -- Home directory
	Finity.Repository = {}
	Finity.Version = "2.0.1a"
	
	if not Name then -- If a name wasn't passed
		Name = "Finity - " .. Finity.Version -- Set the default name
	end
	
	if not Theme then
		Theme = {} --Create Empty Object
	end

	if Hierarchy then
		if type(Hierarchy) == "table" then
			Finity.Directory = Hierarchy --Define Finity.Directory as given Hierarchy

			local function Scan(Object, Parent, Name)
				if type(Object) == "table" then
					if Object.Type then
						Object.Parent = Parent or Finity.Directory
						Object.Name = Name or ""
						
						print("Scanning", Name, "with", Parent.Name)
						
						if Object.Type == "Folder" then
							for _, Child in ipairs(Object.Children) do
								Scan(Child, Object, Child.Name)
							end 
						end
					else
						Finity.Directory.Name = "Home"
						
						for _, Child in ipairs(Object) do
							Scan(Child, Object, Child.Name)
						end 
					end
				end
			end
			
			Scan(Hierarchy)
		end
	end
	
	local Window
	local ObjectHolder
	local Breadcrumbs
	local HoveringTopbar, Dragging, MouseOffset = false, false, nil
	
	function Finity:ClearFolder()
		local Objects = ObjectHolder:GetChildren()
		
		for _, Object in next, Objects do
			if not Object:IsA("UIListLayout") and not Object:IsA("UIPadding") then
				Object:Destroy()
			end
		end
	end
	
	function Finity:ClearCrumbs()
		local Crumbs = Breadcrumbs:GetChildren()
		
		for _, Object in next, Crumbs do
			if not Object:IsA("UIListLayout") and not Object:IsA("UIPadding") then
				Object:Destroy()
			end
		end
	end
	
	function Finity:LoadObject(Name, Data)
		if Name and Data then
			if Data.Type then
				local ObjectHolder = Window.Container.Browser.Directory.ObjectHolder
				local Object = Finity.Repository.Objects[Data.Type]:Clone()
				Object.ClickableText.TextShadow.Text = Name
				Object.ClickableText.Text = Name
				Object.Parent = ObjectHolder
				
				local Animation = Finity.Repository.Animations[Data.Type]
				
				if Animation then
					Animation(Object, Data)
				end
				
				Finity.Repository.Classes[Data.Type](Object, Data)
			end
		end
	end
	
	function Finity:OpenFolder(Directory)
		if Directory then
			if not Directory.Type and not Directory.Children then
				self:ClearFolder()
				
				for _, ChildData in ipairs(Directory) do
					self:LoadObject(ChildData.Name, ChildData)
				end
			elseif Directory.Type and Directory.Type == "Folder" then
				self:OpenFolder(Directory.Children)
				self:ApplyCrumbs(Directory)
			end
		end
	end
	
	function Finity:ApplyCrumbs(Object)
		if Object then
			Finity:ClearCrumbs()
			
			local Ancestors = {}
			local Current = Object
			
			while true do
				if Current.Parent then
					table.insert(Ancestors, Current)
					Current = Current.Parent
				else
					break
				end
			end
			
			local function Reverse(Table)
				local Temp = {}
				
				for Iterator = #Table, 0, -1 do
					table.insert(Temp, Table[Iterator])
				end
				
				return Temp
			end
			
			for _, Ancestor in next, Reverse(Ancestors) do 
				local Crumb = Finity.Repository.Objects["Crumb"]:Clone()
				
				Crumb.Parent = Breadcrumbs
				Crumb.CrumbText.Text = Ancestor.Name
				Crumb.Name = #Breadcrumbs:GetChildren() + 1
				
				Crumb.MouseButton1Click:connect(function()
					self:OpenFolder(Ancestor)
					self:ApplyCrumbs(Ancestor)
				end)
				
				if Ancestor ~= Object then
					Crumb.Arrow.TextTransparency = 0
					Crumb.CrumbText.TextTransparency = 0
					Crumb.Size = UDim2.new(0, 20 + Crumb.CrumbText.TextBounds.X, 1, 0)
				else
					Finity.Repository.Animations["Crumb"](Crumb)
				end
			end
		end
	end

	local function DragWindow()
		spawn(function()
			while Dragging and MouseOffset do
				if Finity.Window then
					Finity.Window.Container:TweenPosition(UDim2.new(0, Mouse.X - MouseOffset.X, 0, Mouse.Y - MouseOffset.Y), "Out", "Sine", 0.1, true)
				end
				wait()
			end

			if Finity.Window then
				Finity.Window.Container:TweenPosition(UDim2.new(0, Mouse.X - MouseOffset.X, 0, Mouse.Y - MouseOffset.Y), "Out", "Sine", 0.1, true)
			end
			MouseOffset = nil
		end)
	end

	print("Loaded functions.")

	shared.Finity = Finity

	print("Shared Finity.")

	Finity.Repository.Objects = {
		["Button"] = FinityV2.create("Button"),
		["Crumb"] = FinityV2.create("Crumb"),
		["Folder"] = FinityV2.create("Folder"),
		["TextBox"] = FinityV2.create("TextBox"),
		["Toggle"] = FinityV2.create("Toggle"),
		["Slider"] = FinityV2.create("Slider"),
		["Window"] = FinityV2.create("Window")
	}

	Finity.Repository.Classes = {
		["Button"] = FinityV2.require("Classes\\Button.lua"),
		["Folder"] = FinityV2.require("Classes\\Folder.lua"),
		["TextBox"] = FinityV2.require("Classes\\TextBox.lua"),
		["Toggle"] = FinityV2.require("Classes\\Toggle.lua"),
		["Slider"] = FinityV2.require("Classes\\Slider.lua"),
	}

	Finity.Repository.Animations = {
		["Button"] = FinityV2.require("Animations\\Button.lua"),
		["Crumb"] = FinityV2.require("Animations\\Crumb.lua"),
		["Folder"] = FinityV2.require("Animations\\Folder.lua"),
		["TextBox"] = FinityV2.require("Animations\\TextBox.lua"),
		["Toggle"] = FinityV2.require("Animations\\Toggle.lua"),
		["Slider"] = FinityV2.require("Animations\\Slider.lua"),
	}

	Window = Finity.Repository.Objects["Window"]:Clone()
	Window.Container.Topbar.Title.Text = Name -- Set name 

	if RunService:IsStudio() then
		Window.Parent = LocalPlayer.PlayerGui
	else
		Window.Parent = game:GetService("CoreGui")
	end

	Finity.Window = Window
	
	ObjectHolder = Window.Container.Browser.Directory.ObjectHolder
	Breadcrumbs = Window.Container.Browser.Directory.Breadcrumbs
	
	Finity.Repository.Animations["Button"](Breadcrumbs.Parent.HomeDirectory)
	Finity.Repository.Animations["Button"](Window.Container.Topbar.Close)
	Finity.Repository.Animations["Button"](Window.Container.Topbar.Sidebar)
	
	Breadcrumbs.Parent.HomeDirectory.MouseButton1Click:Connect(function()
		Finity:ClearCrumbs()
		Finity:OpenFolder(Finity.Directory)
	end)
	
	Window.Container.Topbar.Close.MouseButton1Click:Connect(function()
		-- closing stuff
	end)

	Window.Container.Topbar.MouseEnter:Connect(function()
		HoveringTopbar = true
	end)

	Window.Container.Topbar.MouseLeave:Connect(function()
		HoveringTopbar = false
	end)

	UserInputService.InputBegan:Connect(function(Input)
		if Input.UserInputType == Enum.UserInputType.MouseButton1 then
			if HoveringTopbar then
				MouseOffset = {
					X = Mouse.X - Window.Container.Topbar.AbsolutePosition.X,
					Y = Mouse.Y - Window.Container.Topbar.AbsolutePosition.Y
				}

				Dragging = true
				DragWindow()
			end
		end
	end)

	UserInputService.InputEnded:Connect(function(Input)
		if Input.UserInputType == Enum.UserInputType.MouseButton1 then
			Dragging = false
		end
	end)
	
	Finity:OpenFolder(Finity.Directory)
	
	return Finity
end


return FinityV2
