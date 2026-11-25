getgenv().Esp = {
    Enabled = true,
    Distance = 1000,
    Size = 18,
    Color = Color3.fromRGB(0,255,0)
}

local Render = {}

local CharacterFolder = game.Players.LocalPlayer.Character.Parent

local function Draw(Index, Args)
    local Draw = Drawing.new(Index)
    for i,v in next, Args do
        Draw[i] = v
    end
    return Draw
end
local function StreetFolder(Folder)
    for i,v in next, Folder:GetChildren() do
    	if v.ClassName == "Model" and v:FindFirstChildOfClass("Humanoid") then
    		local Text = Draw("Text", {Text = v.Attached.FakeH:FindFirstChildOfClass("Model").Name, Color = Color3.new(1,0,0), Size = getgenv().Esp.Size, Position = Vector2.new(0,0), Visible = false, Outline = true})
            table.insert(Render, {
                Texts = {Text},
                Object = v,
                Type = "Part"
            })
    	end
    end
end

for i,v in next, CharacterFolder:GetChildren() do
    if v ~= game.Players.LocalPlayer.Character and v:FindFirstChildOfClass("Humanoid") and v:FindFirstChild("Head") and game.Players:FindFirstChild(v.Name) and getgenv().Esp.Enabled then
        local DisplayName = v.Humanoid.DisplayName
        local Text = Draw("Text", {Text = v.Name, Color = getgenv().Esp.Color, Size = getgenv().Esp.Size, Position = Vector2.new(0,0), Visible = false, Outline = true})
        local Text2 = Draw("Text", {Text = "[HP: " .. math.round(v.Humanoid.Health /  v.Humanoid.MaxHealth  * 100) .. "%, Stamina: " .. math.round(v.CurrentStamina.Value /  v.MaxStamina.Value * 100) .. "%]", Color = Color3.fromRGB(255, 255, 255), Size = 18, Position = Vector2.new(0,0), Visible = false, Outline = true})
        table.insert(Render, {
            Texts = {Text, Text2},
            Object = v,
            Type = "Character"
        })
    end
end

for i,v in next, game.Workspace:GetDescendants() do
	if v.Name == "BehelitMODEL" and v.ClassName == "Model" and v:FindFirstChildOfClass("ClickDetector") then
		local Text = Draw("Text", {Text = "Behelit Necklace", Color = Color3.new(1,0,0), Size = getgenv().Esp.Size, Position = Vector2.new(0,0), Visible = false, Outline = true})
        table.insert(Render, {
            Texts = {Text},
            Object = v:FindFirstChildOfClass("Part"),
            Type = "Part"
        })
	end
end

if game.Workspace:FindFirstChild("AokiFolder") then
    for i,v in next, game.Workspace.AokiFolder:GetChildren() do
    	if v.ClassName == "Model" and v:FindFirstChildOfClass("Humanoid") then
    		local Text = Draw("Text", {Text = v.Attached.FakeH:FindFirstChildOfClass("Model").Name, Color = Color3.new(1,0,0), Size = getgenv().Esp.Size, Position = Vector2.new(0,0), Visible = false, Outline = true})
            table.insert(Render, {
                Texts = {Text},
                Object = v:FindFirstChild("Head"),
                Type = "Part"
            })
    	end
    end
end

CharacterFolder.ChildAdded:Connect(function(v)
    if v ~= game.Players.LocalPlayer.Character and v:WaitForChild("Humanoid", 15) and v:WaitForChild("Head", 15) and game.Players:FindFirstChild(v.Name) and getgenv().Esp.Enabled then
        local DisplayName = v.Humanoid.DisplayName
        local Text = Draw("Text", {Text = v.Name, Color = getgenv().Esp.Color, Size = getgenv().Esp.Size, Position = Vector2.new(0,0), Visible = false, Outline = true})
        local Text2 = Draw("Text", {Text = "[HP: " .. math.round(v.Humanoid.Health /  v.Humanoid.MaxHealth  * 100) .. "%, Stamina: " .. math.round(v.CurrentStamina.Value /  v.MaxStamina.Value * 100) .. "%]", Color = Color3.fromRGB(255, 255, 255), Size = 18, Position = Vector2.new(0,0), Visible = false, Outline = true})
        table.insert(Render, {
            Texts = {Text, Text2},
            Object = v.Head,
            Type = "Character"
        })
    end
end)

game.Workspace.DescendantAdded:Connect(function(v)
    task.wait()
	if v.Name == "BehelitMODEL" and v.ClassName == "Model" and v:FindFirstChildOfClass("ClickDetector") then
		local Text = Draw("Text", {Text = "Behelit Necklace", Color = Color3.new(1,0,0), Size = getgenv().Esp.Size, Position = Vector2.new(0,0), Visible = false, Outline = true})
        table.insert(Render, {
            Texts = {Text},
            Object = v:FindFirstChildOfClass("Part"),
            Type = "Part"
        })
	end
end)

game.Workspace.ChildAdded:Connect(function(v)
    task.wait(0.1)
    if v.ClassName == "Folder" and v.Name == "AokiFolder" then
        for i2, v2 in next, v:GetChildren() do
            if v.ClassName == "Model" and v:FindFirstChildOfClass("Humanoid") then
            	local Text = Draw("Text", {Text = v.Attached.FakeH:FindFirstChildOfClass("Model").Name, Color = Color3.new(1,0,0), Size = getgenv().Esp.Size, Position = Vector2.new(0,0), Visible = false, Outline = true})
                table.insert(Render, {
                    Texts = {Text},
                    Object = v.Head,
                    Type = "Part"
                })
            end
        end
        StreetFolder(v)
    end
end)

while getgenv().Esp.Enabled do task.wait()
    for i,v in next, Render do
        if v.Type == "Character" then
            if v.Object ~= nil and v.Object:FindFirstChild("Humanoid") and v.Object:FindFirstChild("Head") and game.Players.LocalPlayer.Character ~= nil and getgenv().Esp.Enabled then
                task.spawn(function()
                    local Texts = v.Texts
                    local Object = v.Object
                    local Vec, See = game.Workspace.CurrentCamera:WorldToViewportPoint(Object.Head.Position + Vector3.new(0, 2.5, 0))
                    if See and (game.Workspace.CurrentCamera.CFrame.Position - v.Object:FindFirstChild("Head").Position).Magnitude < getgenv().Esp.Distance then
                        Texts[1].Position = Vector2.new(Vec.X - #Texts[1].Text * 3, Vec.Y)
                        Texts[2].Position = Texts[1].Position + Vector2.new(#Texts[2], 15)
                        Texts[2].Text = "[(HP: " .. math.round(Object.Humanoid.Health /  Object.Humanoid.MaxHealth  * 100) .. "%), (Stamina: " .. math.round(Object.CurrentStamina.Value /  Object.MaxStamina.Value * 100) .. "%), " .. "(Distance: " .. math.round((game.Workspace.CurrentCamera.CFrame.Position - Object:FindFirstChild("Head").Position).Magnitude) .. ")]"
                        Texts[1].Visible = true
                        Texts[2].Visible = true
                    else
                        Texts[1].Position = Vector2.new(0, 0)
                        Texts[2].Position = Vector2.new(0, 0)
                        Texts[1].Visible = false
                        Texts[2].Visible = false
                    end
                end)
            else
                for i2, v2 in next, v.Texts do
                    v2.Visible = false
                    v2.Position = Vector2.new(0, 0)
                    pcall(function()
                        v2:Remove()
                    end)
                end
                Render[i] = nil
            end
        elseif v.Type == "Part" then
            if v.Object ~= nil and getgenv().Esp.Enabled then
                task.spawn(function()
                    local Texts = v.Texts
                    local Object = v.Object
                    local Vec, See = game.Workspace.CurrentCamera:WorldToViewportPoint(v.Object.Position + Vector3.new(0, 2.5, 0))
                    if See then
                        Texts[1].Position = Vector2.new(Vec.X - #Texts[1].Text * 3, Vec.Y)
                        if v.Object.Parent.Name == "BehelitMODEL" then
                            Texts[1].Text = "Behelit Necklace [Distance: " .. math.round((game.Workspace.CurrentCamera.CFrame.Position - v.Object.Position).Magnitude) .. "]"
                        elseif v.Object.Parent:FindFirstChild("HumanoidRootPart") then
                            Texts[1].Text = v.Object.Parent.Attached.FakeH:FindFirstChildOfClass("Model").Name .. " [Distance: " .. math.round((game.Workspace.CurrentCamera.CFrame.Position - v.Object.Position).Magnitude) .. "]"
                        end
                        Texts[1].Visible = true
                    else
                        Texts[1].Position = Vector2.new(0, 0)
                        Texts[1].Visible = false
                    end
                end)
            else
                for i2, v2 in next, v.Texts do
                    v2.Visible = false
                    v2.Position = Vector2.new(0, 0)
                    pcall(function()
                        v2:Remove()
                    end)
                end
                Render[i] = nil
            end
        end
    end
end