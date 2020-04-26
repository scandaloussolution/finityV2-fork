local FinityV2 = {}

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer

function FinityV2.require(Path)
    if type(Path) == "string" then
		Path = Path:gsub("\\", "/")
		return loadstring(game:HttpGet("https://raw.githubusercontent.com/detourious/finityV2/master/"..Path, true))()
	end
end

function FinityV2.create(Object)
    if type(Object) == "string" then
		Object = Object:gsub("\\", "/")
		return loadstring(game:HttpGet("https://raw.githubusercontent.com/detourious/finityV2/master/Objects/"..Object..".lua", true))()()
	end
end

function FinityV2.new(Name, Theme, Hierarchy, AuthToken) -- Constructor
	FinityV2.AuthToken = AuthToken
	
	local Finity = {} -- Main class
	Finity.Directory = {} -- Home directory
	
	if not Name then -- If a name wasn't passed
		Name = "Finity - 2.0.0" -- Set the default name
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
							for Name, Child in next, Object.Children do
								Scan(Child, Object, Name)
							end 
						end
					else
						Finity.Directory.Name = "Home"
						
						for Name, Child in pairs(Object) do
							Scan(Child, Object, Name)
						end 
					end
				end
			end
			
			Scan(Hierarchy)
		end
	end
	
	local Window = FinityV2.create("Window")
	Window.Container.Topbar.Title.Text = Name -- Set name 
	Window.Parent = LocalPlayer.PlayerGui -- Temporary; testing
	Finity.Window = Window
	
	local ObjectHolder = Window.Container.Browser.Directory.ObjectHolder
	local Breadcrumbs = Window.Container.Browser.Directory.Breadcrumbs
	
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
				local Object = FinityV2.create(Data.Type)
				Object.ClickableText.TextShadow.Text = Name
				Object.ClickableText.Text = Name
				
				local Animation = FinityV2.require("Animations\\"..Data.Type..".lua")
				
				if Animation then
					Animation(Object)
				end
				
				FinityV2.require("Classes\\"..Data.Type..".lua")(Object, Data)
				
				Object.Parent = ObjectHolder
			end
		end
	end
	
	function Finity:OpenFolder(Directory)
		print("hi")
		if Directory then
			print("exists")
			if not Directory.Type and not Directory.Children then
				print("is a table of objects")
				self:ClearFolder()
				
				for ChildName, ChildData in next, Directory do
					self:LoadObject(ChildName, ChildData)
				end
			elseif Directory.Type and Directory.Type == "Folder" then
				print("is folder object")
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
				local Crumb = FinityV2.create("Crumb")
				
				Crumb.Parent = Breadcrumbs
				Crumb.CrumbText.Text = Ancestor.Name
				Crumb.Name = #Breadcrumbs:GetChildren() + 1
				
				Crumb.MouseButton1Click:connect(function()
					self:OpenFolder(Ancestor)
					self:ApplyCrumbs(Ancestor)
				end)
				
				FinityV2.require("Animations\\Crumb.lua")(Crumb)
			end
		end
	end
	
	FinityV2.require("Animations\\Button.lua")(Breadcrumbs.Parent.HomeDirectory)
	
	Breadcrumbs.Parent.HomeDirectory.MouseButton1Click:Connect(function()
		Finity:ClearCrumbs()
		Finity:OpenFolder(Finity.Directory)
	end)
	
	shared.Finity = Finity
	
	return Finity
end

return FinityV2