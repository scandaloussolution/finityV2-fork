local partsWithId = {}
local awaitRef = {}

local root = {
	ID = 0;
	Type = "TextButton";
	Properties = {
		FontSize = Enum.FontSize.Size14;
		TextColor3 = Color3.new(0,0,0);
		Text = "";
		Font = Enum.Font.SourceSans;
		BackgroundTransparency = 1;
		Size = UDim2.new(0,80,1,0);
		Name = "Crumb";
		ZIndex = 3;
		TextSize = 14;
		BackgroundColor3 = Color3.new(1,1,1);
	};
	Children = {
		{
			ID = 1;
			Type = "TextLabel";
			Properties = {
				FontSize = Enum.FontSize.Size14;
				TextColor3 = Color3.new(77/85,77/85,77/85);
				TextStrokeColor3 = Color3.new(22/255,22/255,22/255);
				Text = ">";
				Font = Enum.Font.GothamSemibold;
				Name = "Arrow";
				BackgroundTransparency = 1;
				ZIndex = 3;
				TextSize = 13;
				Size = UDim2.new(0,20,1,0);
			};
			Children = {};
		};
		{
			ID = 2;
			Type = "TextLabel";
			Properties = {
				FontSize = Enum.FontSize.Size14;
				TextColor3 = Color3.new(77/85,77/85,77/85);
				TextStrokeColor3 = Color3.new(22/255,22/255,22/255);
				Text = "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa";
				TextXAlignment = Enum.TextXAlignment.Left;
				Font = Enum.Font.GothamSemibold;
				Name = "CrumbText";
				Position = UDim2.new(0,20,0,0);
				BackgroundTransparency = 1;
				ZIndex = 3;
				TextSize = 13;
				Size = UDim2.new(1,-20,1,0);
			};
			Children = {};
		};
	};
};

local function Scan(item, parent)
	local obj = Instance.new(item.Type)
	if (item.ID) then
		local awaiting = awaitRef[item.ID]
		if (awaiting) then
			awaiting[1][awaiting[2]] = obj
			awaitRef[item.ID] = nil
		else
			partsWithId[item.ID] = obj
		end
	end
	for p,v in pairs(item.Properties) do
		if (type(v) == "string") then
			local id = tonumber(v:match("^_R:(%w+)_$"))
			if (id) then
				if (partsWithId[id]) then
					v = partsWithId[id]
				else
					awaitRef[id] = {obj, p}
					v = nil
				end
			end
		end
		obj[p] = v
	end
	for _,c in pairs(item.Children) do
		Scan(c, obj)
	end
	obj.Parent = parent
	return obj
end

return function() return Scan(root, nil) end