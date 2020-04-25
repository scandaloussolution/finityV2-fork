local partsWithId = {}
local awaitRef = {}

local root = {
	ID = 0;
	Type = "ImageButton";
	Properties = {
		ImageColor3 = Color3.new(3/17,3/17,47/255);
		ScaleType = Enum.ScaleType.Slice;
		BackgroundColor3 = Color3.new(1,1,1);
		Size = UDim2.new(1,0,0,26);
		Image = "rbxassetid://3570695787";
		BackgroundTransparency = 1;
		Name = "Toggle";
		SliceScale = 0.019999999552965;
		ZIndex = 3;
		BorderSizePixel = 0;
		SliceCenter = Rect.new(Vector2.new(100,100),Vector2.new(100,100));
	};
	Children = {
		{
			ID = 1;
			Type = "TextLabel";
			Properties = {
				FontSize = Enum.FontSize.Size14;
				TextColor3 = Color3.new(77/85,77/85,77/85);
				TextStrokeColor3 = Color3.new(22/255,22/255,22/255);
				Text = "Hacking";
				TextXAlignment = Enum.TextXAlignment.Left;
				Font = Enum.Font.GothamSemibold;
				Name = "ClickableText";
				Position = UDim2.new(0,20,0,0);
				BackgroundTransparency = 1;
				ZIndex = 4;
				TextSize = 13;
				Size = UDim2.new(1,-20,1,0);
			};
			Children = {
				{
					ID = 2;
					Type = "TextLabel";
					Properties = {
						FontSize = Enum.FontSize.Size14;
						TextColor3 = Color3.new(8/51,8/51,8/51);
						TextStrokeColor3 = Color3.new(22/255,22/255,22/255);
						Text = "Hacking";
						TextXAlignment = Enum.TextXAlignment.Left;
						Font = Enum.Font.GothamSemibold;
						Name = "TextShadow";
						Position = UDim2.new(0,0,0,2);
						BackgroundTransparency = 1;
						ZIndex = 3;
						TextSize = 13;
						Size = UDim2.new(1,0,1,0);
					};
					Children = {};
				};
			};
		};
		{
			ID = 3;
			Type = "Frame";
			Properties = {
				AnchorPoint = Vector2.new(1,0);
				Name = "CheckboxFrame";
				Position = UDim2.new(1,-20,0,0);
				Size = UDim2.new(0,20,1,0);
				BackgroundColor3 = Color3.new(1,1,1);
			};
			Children = {
				{
					ID = 4;
					Type = "ImageLabel";
					Properties = {
						ImageColor3 = Color3.new(77/85,77/85,77/85);
						ImageTransparency = 1;
						BackgroundTransparency = 1;
						AnchorPoint = Vector2.new(0.5,0.5);
						Image = "rbxassetid://4942141114";
						Name = "Checked";
						Position = UDim2.new(0.5,0,0.5,0);
						Size = UDim2.new(0,24,0,24);
						ZIndex = 4;
						BorderSizePixel = 0;
						BackgroundColor3 = Color3.new(1,1,1);
					};
					Children = {};
				};
				{
					ID = 5;
					Type = "ImageLabel";
					Properties = {
						ImageColor3 = Color3.new(77/85,77/85,77/85);
						BackgroundTransparency = 1;
						AnchorPoint = Vector2.new(0.5,0.5);
						Image = "rbxassetid://4942141053";
						Name = "Unchecked";
						Position = UDim2.new(0.5,0,0.5,0);
						Size = UDim2.new(0,24,0,24);
						ZIndex = 3;
						BorderSizePixel = 0;
						BackgroundColor3 = Color3.new(1,1,1);
					};
					Children = {};
				};
				{
					ID = 6;
					Type = "ImageLabel";
					Properties = {
						ImageColor3 = Color3.new(26/255,26/255,26/255);
						ScaleType = Enum.ScaleType.Slice;
						Visible = false;
						AnchorPoint = Vector2.new(0.5,0.5);
						Image = "rbxassetid://1316045217";
						Name = "Shadow";
						Position = UDim2.new(0.5,0,0.5,1);
						BackgroundTransparency = 1;
						ZIndex = 3;
						Size = UDim2.new(0,26,0,26);
						SliceCenter = Rect.new(Vector2.new(10,10),Vector2.new(118,118));
					};
					Children = {};
				};
			};
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