getgenv().StreetFighterESP = {
    Enabled = true, -- true equal ON, false equal OFF
    ShowDistance = true, -- Show distance between you and npc
    Size = {
        CircleOutline = 10,
        Circle = 6,
        Text = 18
    },
    Color = {
        CircleOutline = Color3.fromRGB(0, 0, 0),
        Circle = Color3.fromRGB(255, 255, 255),
        Text = Color3.fromRGB(255, 255, 255)
    }
}

function Draw_new(Name, Parameters)
    local Object = Drawing.new(Name)
    for i,v in next, Parameters do
        Object[i] = v
    end
    return Object
end

function Draw_flush()
    for i,v in next, Render do
        spawn(function()
            for i2,v2 in next, v.Drawings do
                v2:Remove()
            end
        end)
        Render[i] = nil
    end
end

function Draw_remove(Object)
    for i,v in next, Object.Drawings do
        v:Remove()
    end
    for i,v in next, Render do
        if Object == v then
            Render[i] = nil
        end
    end
end

function Draw_unvis()
    for i,v in next, Render do
        spawn(function()
            for i2,v2 in next, v.Drawings do
                v2.Visible = false
            end
        end)
    end
end

function Draw_Find(Object)
    local Find = false
    for i,v in next, Render do
        if v.Object == Object then
            Find = true
        end
    end
    return Find
end

Render = {}

function AddNpc(Npc, Name)
    local Part = Npc.PrimaryPart or Npc:FindFirstChild("HumanoidRootPart") or Npc:FindFirstChildOfClass("Part")
    if not Draw_Find(Part) then
        pcall(function()
            table.insert(Render, {
                Type = "Object",
                Object = Part,
                Text = Name,
                Drawings = {
                    Circle = Draw_new("Circle", {Thickness = 2, NumSides = 6, Radius = getgenv().StreetFighterESP.Size.CircleOutline, Position = Vector2.new(0,0), Filled = false, Color = getgenv().StreetFighterESP.Color.CircleOutline}),
                    Circle2 = Draw_new("Circle", {Thickness = 1, NumSides = 6, Radius = getgenv().StreetFighterESP.Size.Circle, Position = Vector2.new(0,0), Filled = true, Color = getgenv().StreetFighterESP.Color.Circle}),
                    Text = Draw_new("Text", {Size = getgenv().StreetFighterESP.Size.Text, Text = Name, Position = Vector2.new(0,0), Outline = true, Center = true, OutlineColor = Color3.new(0,0,0), Color = getgenv().StreetFighterESP.Color.Text})
                }
            })
        end)
    end
end

if game.Workspace:FindFirstChild("AokiFolder") then
    for i,v in next, game.Workspace.AokiFolder:GetChildren() do
    	if v.ClassName == "Model" and v:FindFirstChildOfClass("Humanoid") and getgenv().StreetFighterESP.Enabled then
    		AddNpc(v, v.Attached.FakeH:FindFirstChildOfClass("Model").Name)
    	end
    end
end
spawn(function()
    game.Workspace:WaitForChild("AokiFolder", 9e9).ChildAdded:Connect(function(v)
        if v.ClassName == "Model" and v:FindFirstChildOfClass("Humanoid") and getgenv().StreetFighterESP.Enabled then
        	AddNpc(v, v.Attached.FakeH:FindFirstChildOfClass("Model").Name)
        end
    end)
end)

if game.Workspace:FindFirstChild("YangFolder") then
    for i,v in next, game.Workspace.YangFolder:GetChildren() do
    	if v.ClassName == "Model" and v:FindFirstChildOfClass("Humanoid") and getgenv().StreetFighterESP.Enabled then
    		AddNpc(v, v.Attached.FakeH:FindFirstChildOfClass("Model").Name)
    	end
    end
end
spawn(function()
    game.Workspace:WaitForChild("YangFolder", 9e9).ChildAdded:Connect(function(v)
        if v.ClassName == "Model" and v:FindFirstChildOfClass("Humanoid") and getgenv().StreetFighterESP.Enabled then
        	AddNpc(v, v.Attached.FakeH:FindFirstChildOfClass("Model").Name)
        end
    end)
end)

for i,v in next, game.Workspace:GetDescendants() do
    if v.Name == "FakeH" and v:FindFirstChildOfClass("Model") and v.Parent.Parent:FindFirstChild("NPC_Config") and getgenv().StreetFighterESP.Enabled then
    	AddNpc(v.Parent.Parent, v:FindFirstChildOfClass("Model").Name)
    end
end

game.Workspace.DescendantAdded:Connect(function(v)
    if v.Name == "FakeH" and v:FindFirstChildOfClass("Model") and v.Parent.Parent:FindFirstChild("NPC_Config") and getgenv().StreetFighterESP.Enabled then
    	AddNpc(v.Parent.Parent, v:FindFirstChildOfClass("Model").Name)
    end
end)

Rendering = game.RunService.RenderStepped:Connect(function()
    if getgenv().StreetFighterESP.Enabled then
        for i,v in next, Render do
            spawn(function()
                if v.Type == "Object" and v.Object ~= nil and v.Object.Parent ~= nil and v.Object:IsDescendantOf(game.Workspace) then
                    local Vec, See = game.Workspace.CurrentCamera:WorldToViewportPoint(v.Object.Position)
                    local Circle = v.Drawings.Circle
                    local Circle2 = v.Drawings.Circle2
                    local Text = v.Drawings.Text
                    if See then
                        Circle.Position = Vector2.new(Vec.X, Vec.Y)
                        Circle.Visible = true
                        Circle2.Position = Vector2.new(Vec.X, Vec.Y)
                        Circle2.Visible = true
                        if getgenv().StreetFighterESP.ShowDistance then
                            local Distance = " [" .. math.floor((game.Workspace.CurrentCamera.CFrame.Position - v.Object.Position).Magnitude) .. "]"
                            Text.Text = v.Text .. Distance
                        end
                        Text.Position = Vector2.new(Vec.X, Vec.Y + 10)
                        Text.Visible = true
                    else
                        Circle.Visible = false
                        Circle.Position = Vector2.new(0,0)
                        Circle2.Visible = false
                        Circle2.Position = Vector2.new(0,0)
                        Text.Visible = false
                        Text.Position = Vector2.new(0,0)
                    end
                end
            end)
        end
    else
        Draw_unvis()
        Rendering:Disconnect()
    end
end)