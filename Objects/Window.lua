local partsWithId = {}
local awaitRef = {}

local root = {
	ID = 0;
	Type = "ScreenGui";
	Properties = {
		Name = "FinityV2";
		ResetOnSpawn = false;
	};
	Children = {
		{
			ID = 1;
			Type = "ImageLabel";
			Properties = {
				ImageColor3 = Color3.new(32/255,32/255,11/85);
				ScaleType = Enum.ScaleType.Slice;
				BackgroundTransparency = 1;
				Size = UDim2.new(0,425,0,500);
				Image = "rbxassetid://3570695787";
				Name = "Container";
				Position = UDim2.new(0.052099533379078,0,0.07882534712553,0);
				SliceScale = 0.03999999910593;
				ZIndex = 2;
				BackgroundColor3 = Color3.new(1,1,1);
				SliceCenter = Rect.new(Vector2.new(100,100),Vector2.new(100,100));
			};
			Children = {
				{
					ID = 2;
					Type = "ImageLabel";
					Properties = {
						ImageColor3 = Color3.new(7/51,7/51,7/51);
						ScaleType = Enum.ScaleType.Slice;
						AnchorPoint = Vector2.new(0.5,0.5);
						Image = "rbxassetid://1316045217";
						BackgroundTransparency = 1;
						Position = UDim2.new(0.5,0,0.5,4);
						Name = "Shadow";
						Size = UDim2.new(1,6,1,6);
						SliceCenter = Rect.new(Vector2.new(10,10),Vector2.new(118,118));
					};
					Children = {};
				};
				{
					ID = 3;
					Type = "Frame";
					Properties = {
						BackgroundTransparency = 2;
						ZIndex = 2;
						Name = "Topbar";
						Size = UDim2.new(1,0,0,30);
					};
					Children = {
						{
							ID = 4;
							Type = "TextLabel";
							Properties = {
								FontSize = Enum.FontSize.Size14;
								TextColor3 = Color3.new(77/85,77/85,77/85);
								TextStrokeColor3 = Color3.new(22/255,22/255,22/255);
								Text = "Finity - 2.0.0";
								Font = Enum.Font.GothamSemibold;
								Name = "Title";
								Position = UDim2.new(0,30,0,0);
								BackgroundTransparency = 1;
								ZIndex = 3;
								TextSize = 13;
								Size = UDim2.new(1,-60,0,30);
							};
							Children = {};
						};
						{
							ID = 5;
							Type = "TextButton";
							Properties = {
								FontSize = Enum.FontSize.Size14;
								TextColor3 = Color3.new(0,0,0);
								Text = "";
								Font = Enum.Font.SourceSans;
								BackgroundTransparency = 1;
								Size = UDim2.new(0,30,0,30);
								Name = "Sidebar";
								ZIndex = 2;
								TextSize = 14;
								BackgroundColor3 = Color3.new(1,1,1);
							};
							Children = {
								{
									ID = 6;
									Type = "ImageLabel";
									Properties = {
										ImageColor3 = Color3.new(208/255,208/255,208/255);
										AnchorPoint = Vector2.new(0.5,0.5);
										Image = "rbxassetid://4942199748";
										BackgroundTransparency = 1;
										Position = UDim2.new(0.5,0,0.5,0);
										Name = "Image";
										ZIndex = 2;
										Size = UDim2.new(0,24,0,24);
										BackgroundColor3 = Color3.new(1,1,1);
									};
									Children = {};
								};
							};
						};
						{
							ID = 7;
							Type = "TextButton";
							Properties = {
								FontSize = Enum.FontSize.Size14;
								TextColor3 = Color3.new(0,0,0);
								Text = "";
								Size = UDim2.new(0,30,0,30);
								AnchorPoint = Vector2.new(1,0);
								Font = Enum.Font.SourceSans;
								BackgroundTransparency = 1;
								Position = UDim2.new(1,0,0,0);
								Name = "Close";
								ZIndex = 2;
								TextSize = 14;
								BackgroundColor3 = Color3.new(1,1,1);
							};
							Children = {
								{
									ID = 8;
									Type = "ImageLabel";
									Properties = {
										ImageColor3 = Color3.new(208/255,208/255,208/255);
										AnchorPoint = Vector2.new(0.5,0.5);
										Image = "rbxassetid://4942199713";
										BackgroundTransparency = 1;
										Position = UDim2.new(0.5,0,0.5,0);
										Name = "Image";
										ZIndex = 2;
										Size = UDim2.new(0,24,0,24);
										BackgroundColor3 = Color3.new(1,1,1);
									};
									Children = {};
								};
							};
						};
					};
				};
				{
					ID = 9;
					Type = "Frame";
					Properties = {
						Name = "Separator";
						Position = UDim2.new(0,0,0,30);
						Size = UDim2.new(1,0,0,1);
						ZIndex = 6;
						BorderSizePixel = 0;
						BackgroundColor3 = Color3.new(21/85,21/85,13/51);
					};
					Children = {};
				};
				{
					ID = 10;
					Type = "Frame";
					Properties = {
						ClipsDescendants = true;
						BorderColor3 = Color3.new(63/85,182/255,193/255);
						AnchorPoint = Vector2.new(1,0);
						Name = "Browser";
						Position = UDim2.new(1,0,0,30);
						BackgroundTransparency = 1;
						ZIndex = 2;
						Size = UDim2.new(1,0,1,-30);
						BackgroundColor3 = Color3.new(83/85,239/255,1);
					};
					Children = {
						{
							ID = 11;
							Type = "ScrollingFrame";
							Properties = {
								ScrollBarImageColor3 = Color3.new(118/255,118/255,121/255);
								MidImage = "rbxassetid://967852042";
								ScrollBarThickness = 4;
								BottomImage = "rbxassetid://967852042";
								BackgroundTransparency = 1;
								Name = "Directory";
								TopImage = "rbxassetid://967852042";
								Size = UDim2.new(1,0,1,0);
								ZIndex = 2;
								BorderSizePixel = 0;
								CanvasSize = UDim2.new(0,0,0,205);
							};
							Children = {
								{
									ID = 12;
									Type = "Frame";
									Properties = {
										Name = "ObjectHolder";
										Position = UDim2.new(0,0,0,30);
										BackgroundTransparency = 1;
										ZIndex = 2;
										Size = UDim2.new(1,0,1,-30);
										BackgroundColor3 = Color3.new(1,1,1);
									};
									Children = {
										{
											ID = 13;
											Type = "UIListLayout";
											Properties = {
												Padding = UDim.new(0,3);
												SortOrder = Enum.SortOrder.LayoutOrder;
											};
											Children = {};
										};
										{
											ID = 14;
											Type = "UIPadding";
											Properties = {
												PaddingLeft = UDim.new(0,10);
												PaddingRight = UDim.new(0,10);
											};
											Children = {};
										};
									};
								};
								{
									ID = 15;
									Type = "ScrollingFrame";
									Properties = {
										ScrollBarImageColor3 = Color3.new(118/255,118/255,121/255);
										MidImage = "rbxassetid://967852042";
										ScrollBarThickness = 4;
										BottomImage = "rbxassetid://967852042";
										BackgroundTransparency = 1;
										TopImage = "rbxassetid://967852042";
										Name = "Breadcrumbs";
										Position = UDim2.new(0,40,0,0);
										Size = UDim2.new(1,-50,0,30);
										ZIndex = 2;
										BorderSizePixel = 0;
										CanvasSize = UDim2.new();
									};
									Children = {
										{
											ID = 16;
											Type = "UIListLayout";
											Properties = {
												FillDirection = Enum.FillDirection.Horizontal;
											};
											Children = {};
										};
									};
								};
								{
									ID = 17;
									Type = "ImageButton";
									Properties = {
										ImageColor3 = Color3.new(77/85,77/85,77/85);
										Image = "rbxassetid://4942246108";
										Name = "HomeDirectory";
										Position = UDim2.new(0,15,0,3);
										Size = UDim2.new(0,24,0,24);
										ZIndex = 2;
										BackgroundTransparency = 1;
										BackgroundColor3 = Color3.new(1,1,1);
									};
									Children = {};
								};
							};
						};
					};
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