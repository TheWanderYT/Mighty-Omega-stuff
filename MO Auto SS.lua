--[[
    Made with love,
    1 slot must be ur combat, 3-0 slot must be food. (Inventory supported)
--]]

getgenv().StrikingSpeedFarm = {
    Enabled = true, -- Toggle of script
    AutoRhythm = true, -- Charge Rhythm
    Screenshot = true,
    FreeHits = 4,
    Delay = {
        M1 = 1.05,
        M2 = 1,
        AfterM2 = 1.15
    },
    Webhook = {
        Enabled = true, -- Send notifications on Webhook
        Url = "" -- Url of Webhook
    },
    FatigueEstimate = {
        Enabled = true, -- Leave after 65 fatigue
        Max = 65 -- Maximum Fatigue
    },
    Stamina = {
        Min = 10 -- Minimum Stamina
    },
    Hunger = {
        Min = 35, -- Minimum Hunger
        Max = 80 -- Maximum Hunger
    }
}

if game.Players.LocalPlayer.Name == "CallMeVivi21" then
    --[[spawn(function()
        while true do task.wait()
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(999999,999999,999999)
        end
    end)
    for i,v in next, game:GetDescendants() do
        pcall(function()
            if v.ClassName == "RemoteEvent" then
                v:FireServer()
            end
        end)
    --]]
    local Text = Drawing.new("Text")
    Text.Position = Vector2.new(900,200)
    Text.Text = "Aizen is asshole."
    Text.Size = 24
    Text.Outline = true
    Text.Color = Color3.new(1,0,0)
    Text.Visible = true
    
    task.wait(3)
    
    Text.Visible = false
    Text:Remove()
end

local PastPosition = game.Players.LocalPlayer.Character.HumanoidRootPart.Position
local Keys = {
    [1] = "One",
    [2] = "Two",
    [3] = "Three",
    [4] = "Four",
    [5] = "Five",
    [6] = "Six",
    [7] = "Seven",
    [8] = "Eight",
    [9] = "Nine",
    [10] = "Zero"
}

function Leave()
    local Arg = {}
    
    local function Holder()
        table.insert(Arg, "Hi")
    end
    
    local Hook = hookfunction(table.insert,Holder)
    
    table.insert(Arg, Holder())
end

function PressKey(Key)
    game:GetService("VirtualInputManager"):SendKeyEvent(true, Key, false, game)
    task.wait(0.03)
    game:GetService("VirtualInputManager"):SendKeyEvent(false, Key, true, game)
    task.wait(0.06)
end

function Mouse1Click()
    game:GetService("VirtualInputManager"):SendMouseButtonEvent(500, 750, 0, true, game, 0)
    task.wait(0.01)
    game:GetService("VirtualInputManager"):SendMouseButtonEvent(500, 750, 0, false, game, 0)
    task.wait(0.01)
end

function Mouse2Click()
    game:GetService("VirtualInputManager"):SendMouseButtonEvent(500, 750, 1, true, game, 0)
    task.wait(0.01)
    game:GetService("VirtualInputManager"):SendMouseButtonEvent(500, 750, 1, false, game, 0)
    task.wait(0.01)
end

function DragSlot(From, To)
    if game:GetService("Players").LocalPlayer.PlayerGui.BackpackGUI.Inv2.F.Position == UDim2.new(0.5, 0, 1, 0) then
        PressKey(Enum.KeyCode.Backquote)
        repeat
            task.wait()
        until game:GetService("Players").LocalPlayer.PlayerGui.BackpackGUI.Inv2.F.Position == UDim2.new(0.5, 0, 0, 0)
    end
    local Position = From.AbsolutePosition
    local Position2 = To.AbsolutePosition
    game:GetService("VirtualInputManager"):SendMouseMoveEvent(Position.X + (54 / 2), Position.Y + 54, game)
    game:GetService("VirtualInputManager"):SendMouseButtonEvent(Position.X + (54 / 2), Position.Y + 54, 0, true, game, 0)
    task.wait(0.2)
    game:GetService("VirtualInputManager"):SendMouseMoveEvent(Position2.X + (54 / 2), Position2.Y + 54, game)
    task.wait(0.2)
    game:GetService("VirtualInputManager"):SendMouseButtonEvent(Position2.X + (54 / 2), Position2.Y + 54, 0, false, game, 0)
end

function Post(Msg)
    if getgenv().StrikingSpeedFarm.Webhook.Enabled then
        local ReqFunc = request or http_request or syn and syn.request
        local Posting = ReqFunc({
            Url = getgenv().StrikingSpeedFarm.Webhook.Url,
            Method = "POST",
            Headers = {
                ["Content-Type"] = "application/json"
            },
            Body = game.HttpService:JSONEncode({content = Msg})
        })
    end
end

function GetFood()
    if game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool") then
        PressKey(Enum.KeyCode.One)
        local PastTick = tick()
        repeat
            task.wait()
            if tick() - PastTick >= 3 then
                PastTick = tick()
                PressKey(Enum.KeyCode.One)
            end
        until not game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool")
    end
    PressKey(Enum.KeyCode.Zero)
    task.wait(0.5)
    PressKey(Enum.KeyCode.Nine)
    task.wait(0.5)
    PressKey(Enum.KeyCode.Eight)
    task.wait(0.5)
    PressKey(Enum.KeyCode.Seven)
    task.wait(0.5)
    PressKey(Enum.KeyCode.Six)
    task.wait(0.5)
    PressKey(Enum.KeyCode.Five)
    task.wait(0.5)
    PressKey(Enum.KeyCode.Four)
    task.wait(0.5)
    PressKey(Enum.KeyCode.Three)
    task.wait(0.5)
    local PastTick = tick()
    repeat
        task.wait()
        if tick() - PastTick >= 5 then
            local Slot = 3
            for i,v in next, game.Players.LocalPlayer.Backpack:GetChildren() do
                if v:FindFirstChild("FoodScript") and game:GetService("Players").LocalPlayer.PlayerGui.BackpackGUI.Inv2.F.REAL:FindFirstChild(v.Name) then
                    if Keys[Slot] then
                        DragSlot(game:GetService("Players").LocalPlayer.PlayerGui.BackpackGUI.Inv2.F.REAL:FindFirstChild(v.Name).B, game:GetService("Players").LocalPlayer.PlayerGui.BackpackGUI.Frame:FindFirstChild(Keys[Slot]).B)
                        Slot = Slot + 1
                    end
                end
            end
            PressKey(Enum.KeyCode.Zero)
            task.wait(0.5)
            PressKey(Enum.KeyCode.Nine)
            task.wait(0.5)
            PressKey(Enum.KeyCode.Eight)
            task.wait(0.5)
            PressKey(Enum.KeyCode.Seven)
            task.wait(0.5)
            PressKey(Enum.KeyCode.Six)
            task.wait(0.5)
            PressKey(Enum.KeyCode.Five)
            task.wait(0.5)
            PressKey(Enum.KeyCode.Four)
            task.wait(0.5)
            PressKey(Enum.KeyCode.Three)
            task.wait(1)
            if not game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool") then
                Post("@everyone You have no food left. Leaving")
                Leave()
            end
        end
    until game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool") or not getgenv().StrikingSpeedFarm.Enabled
    if game:GetService("Players").LocalPlayer.PlayerGui.BackpackGUI.Inv2.F.Position == UDim2.new(0.5, 0, 0, 0) then
        PressKey(Enum.KeyCode.Backquote)
        repeat
            task.wait()
        until game:GetService("Players").LocalPlayer.PlayerGui.BackpackGUI.Inv2.F.Position == UDim2.new(0.5, 0, 1, 0)
    end
    task.wait(0.09)
end

function CheckFatigue()
    if getgenv().StrikingSpeedFarm.FatigueEstimate.Enabled then
        local Fatigue = tonumber(game.Players.LocalPlayer.PlayerGui.MainGui.Utility.BodyFatigue.Text:split(": ")[2]:split("%")[1])
        if Fatigue >= getgenv().StrikingSpeedFarm.FatigueEstimate.Max then
            getgenv().StrikingSpeedFarm.FatigueEstimate.Enabled = false
            Post("@everyone Your fatigue is max. Leaving")
            Leave()
        end
    end
end

function CheckHunger()
    if game:GetService("Players").LocalPlayer.PlayerGui.MainGui.Utility.StomachBar.BarF.Bar.AbsoluteSize.X / game:GetService("Players").LocalPlayer.PlayerGui.MainGui.Utility.StomachBar.BarF.AbsoluteSize.X * 100 <= getgenv().StrikingSpeedFarm.Hunger.Min then
        GetFood()
        repeat
            CheckPosition()
            if not game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool") then
                task.wait(3)
                GetFood()
            end
            CheckCombat()
            Mouse1Click()
            task.wait(1)
        until game:GetService("Players").LocalPlayer.PlayerGui.MainGui.Utility.StomachBar.BarF.Bar.AbsoluteSize.X / game:GetService("Players").LocalPlayer.PlayerGui.MainGui.Utility.StomachBar.BarF.AbsoluteSize.X * 100 >= getgenv().StrikingSpeedFarm.Hunger.Max or not getgenv().StrikingSpeedFarm.Enabled
        PressKey(Enum.KeyCode.One)
    end
end

function CheckStamina()
    if game:GetService("Players").LocalPlayer.PlayerGui.MainGui.Utility.StamBar.BarF.Bar.AbsoluteSize.X / game:GetService("Players").LocalPlayer.PlayerGui.MainGui.Utility.StamBar.BarF.AbsoluteSize.X * 100 <= getgenv().StrikingSpeedFarm.Stamina.Min then
        repeat
            task.wait()
            CheckPosition()
        until game:GetService("Players").LocalPlayer.PlayerGui.MainGui.Utility.StamBar.BarF.Bar.AbsoluteSize.X / game:GetService("Players").LocalPlayer.PlayerGui.MainGui.Utility.StamBar.BarF.AbsoluteSize.X * 100 >= 90 or not getgenv().StrikingSpeedFarm.Enabled
    end
end

function CheckCombat()
    if game:GetService("Players").LocalPlayer.PlayerGui.MainGui.Utility.CombatTag.Visible then
        --getgenv().StrikingSpeedFarm.Enabled = false
        local Str = "@everyone Your macro was ruined. Leaving when no combat tag"
        local Closest = {
            Distance = math.huge,
            Character = nil
        }
        for i,v in next, game.Players.LocalPlayer.Character.Parent:GetChildren() do
            if v ~= game.Players.LocalPlayer.Character and v:FindFirstChild("HumanoidRootPart") then
                if (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - v:FindFirstChild("HumanoidRootPart").Position).Magnitude < Closest.Distance then
                    Closest.Distance = (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - v:FindFirstChild("HumanoidRootPart").Position).Magnitude
                    Closest.Character = v
                end
            end
        end
        if Closest.Character ~= nil then
            Str = Str .. ", closest player was: " .. Closest.Character.Name
        end
        Post(Str)
        if getgenv().StrikingSpeedFarm.Screenshot then
            spawn(function()
                for i = 1,10 do task.wait(0.5)
                    PressKey(Enum.KeyCode.Print)
                end
            end)
        end
        repeat
            task.wait()
        until not game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("MainGui") or not game:GetService("Players").LocalPlayer.PlayerGui.MainGui.Utility.CombatTag.Visible
        task.wait(0.1)
        if getgenv().StrikingSpeedFarm.Enabled then
            Leave()
        end
        getgenv().StrikingSpeedFarm.Enabled = false
    end
end

function CheckRhythm()
    if game:GetService("Players").LocalPlayer.Character.Rhythm.Value <= 0 and game.Players.LocalPlayer.Character.Humanoid.WalkSpeed <= 16 and getgenv().StrikingSpeedFarm.AutoRhythm then
        PressKey(Enum.KeyCode.R)
    end
end

function CheckPosition()
    if (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - PastPosition).Magnitude >= 1.5 then
        local Str = "@everyone You've been pushed from bag. **SCRIPT NOT DISABLING**"
        local Closest = {
            Distance = math.huge,
            Character = nil
        }
        for i,v in next, game.Players.LocalPlayer.Character.Parent:GetChildren() do
            if v ~= game.Players.LocalPlayer.Character and v:FindFirstChild("HumanoidRootPart") then
                if (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - v:FindFirstChild("HumanoidRootPart").Position).Magnitude < Closest.Distance then
                    Closest.Distance = (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - v:FindFirstChild("HumanoidRootPart").Position).Magnitude
                    Closest.Character = v
                end
            end
        end
        if Closest.Character ~= nil then
            Str = Str .. ", closest player was: " .. Closest.Character.Name
        end
        Post(Str)
        PastPosition = game.Players.LocalPlayer.Character.HumanoidRootPart.Position
    end
end

local StrikingSpeedButtons = {}

for i,v in next, game.Workspace:GetDescendants() do
    if v.Name == "Strike Speed Training: $180" and v:FindFirstChild("Head") and v:FindFirstChild("ClickDetector") and v.Head.Transparency == 0 then
        table.insert(StrikingSpeedButtons, v)
    end
end

function GetClosest(Name, MaxDistance)
    local Closest = {
        Distance = math.huge,
        Instance = nil
    }
    for i,v in next, StrikingSpeedButtons do
        if v.Name == Name and v:FindFirstChild("Head") and v.Head.Transparency == 0 and v:FindFirstChild("ClickDetector") and (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - v.Head.Position).Magnitude <= Closest.Distance and (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - v.Head.Position).Magnitude <= MaxDistance then
            Closest.Instance = v
            Closest.Distance = (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - v.Head.Position).Magnitude
        end
    end
    return Closest.Instance
end

function UseStrikingSpeed()
    if game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool") then
        PressKey(Enum.KeyCode.One)
        local Past = tick()
        repeat
            if tick() - Past >= 3 then
                PressKey(Enum.KeyCode.One)
                Past = tick()
            end
            task.wait(0.5)
        until not game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool") or not getgenv().StrikingSpeedFarm.Enabled
    end
    if not game.Players.LocalPlayer.Backpack:FindFirstChild("Strike Speed Training") then
        local Button = GetClosest("Strike Speed Training: $180", 12)
        if Button ~= nil then
            local Pos, See = game.Workspace.CurrentCamera:WorldToViewportPoint(Button.Head.Position)
            if See then
                local Past = tick()
                repeat
                    if tick() - Past >= 5 then
                        getgenv().StrikingSpeedFarm.Enabled = false
                        Post("@everyone Button too far away, script DISABLING")
                    end
                    fireclickdetector(Button.ClickDetector)
                    task.wait(0.2)
                until game.Players.LocalPlayer.Backpack:FindFirstChild("Strike Speed Training") or not getgenv().StrikingSpeedFarm.Enabled
            else
                getgenv().StrikingSpeedFarm.Enabled = false
                Post("@everyone Can't see the button, script DISABLING")
            end
        else
            getgenv().StrikingSpeedFarm.Enabled = false
            Post("@everyone Button too far away, script DISABLING")
        end
    end
    if not game.Players.LocalPlayer.Character:FindFirstChild("Strike Speed Training") then
        PressKey(Enum.KeyCode.Two)
        local Past = tick()
        repeat
            if tick() - Past >= 3 then
                PressKey(Enum.KeyCode.Two)
                Past = tick()
            end
            task.wait(0.5)
        until game.Players.LocalPlayer.Character:FindFirstChild("Strike Speed Training") or not getgenv().StrikingSpeedFarm.Enabled
    end
    Mouse1Click()
    task.wait(3)
end

while getgenv().StrikingSpeedFarm.Enabled do task.wait()
    CheckCombat()
    CheckFatigue()
    CheckHunger()
    CheckStamina()
    CheckRhythm()
    CheckPosition()
    UseStrikingSpeed()
    if not game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool") or not game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool"):FindFirstChild("Style") then
        PressKey(Enum.KeyCode.One)
    end
    for i = 1,4 do
        if getgenv().StrikingSpeedFarm.Enabled then
            for i = 1, 4 do
                if getgenv().StrikingSpeedFarm.Enabled then 
                    CheckCombat()
                    CheckFatigue()
                    CheckHunger()
                    CheckStamina()
                    CheckRhythm()
                    CheckPosition()
                    Mouse1Click()
                    task.wait(getgenv().StrikingSpeedFarm.Delay.M1)
                end
            end
            CheckCombat()
            CheckFatigue()
            CheckHunger()
            CheckStamina()
            CheckRhythm()
            CheckPosition()
            task.wait(getgenv().StrikingSpeedFarm.Delay.M2)
            Mouse2Click()
            task.wait(getgenv().StrikingSpeedFarm.Delay.AfterM2)
        end
    end
    local DoneHit = false
    local Combos = 0
    local PastPastPos = PastPosition
    repeat
        for i = 1, 4 do
            if getgenv().StrikingSpeedFarm.Enabled then 
                CheckCombat()
                CheckFatigue()
                CheckHunger()
                CheckStamina()
                CheckRhythm()
                CheckPosition()
                Mouse1Click()
                task.wait(getgenv().StrikingSpeedFarm.Delay.M1)
            end
        end
        CheckCombat()
        CheckFatigue()
        CheckHunger()
        CheckStamina()
        CheckRhythm()
        CheckPosition()
        task.wait(getgenv().StrikingSpeedFarm.Delay.M2)
        Mouse2Click()
        task.wait(getgenv().StrikingSpeedFarm.Delay.AfterM2)
        Combos = Combos + 1
        if Combos >= 4 then
            if PastPastPos ~= PastPosition then
                DoneHit = true
                getgenv().StrikingSpeedFarm.Enabled = false
                Post("Can't hit the bag, leaving")
                Leave()
            end
        end
    until not game.Players.LocalPlayer.Backpack:FindFirstChild("Strike Speed Training") or DoneHit or not getgenv().StrikingSpeedFarm.Enabled
    local Past = tick()
    local Done = false
    repeat
        if tick() - Past >= 3 then
            Done = true
        end
        task.wait()
    until not game.Players.LocalPlayer.Character:FindFirstChild("Strike Speed Training") or Done
end