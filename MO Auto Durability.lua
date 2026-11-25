--[[
    Made with love,
    1 slot must be ur combat, 2-0 slot must be food. (Inventory supported)
--]]

getgenv().DurabilityFarm = {
    Enabled = true, -- Toggle of script
    AutoRhythm = true, -- Charge Rhythm
    Players = {
        FirstAcc = {
            User = "User", -- User of first acc
            MinHP = 20, -- Minimum hp
            UseDura = true
        },
        SecondAcc = {
            User = "User", -- User of second acc
            MinHP = 20, -- Minimum hp
            UseDura = true
        }
    },
    Webhook = {
        Enabled = false, -- Send notifications on Webhook
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

if getgenv().DurabilityFarm.Players.FirstAcc.UseDura == nil then
    getgenv().DurabilityFarm.Players.FirstAcc.UseDura = true
    getgenv().DurabilityFarm.Players.SecondAcc.UseDura = true
end

function Leave()
    repeat
        task.wait()
    until not game:GetService("Players").LocalPlayer.PlayerGui.MainGui.Utility.CombatTag.Visible
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
    if getgenv().DurabilityFarm.Webhook.Enabled then
        local ReqFunc = request or http_request or syn and syn.request
        local Posting = ReqFunc({
            Url = getgenv().DurabilityFarm.Webhook.Url,
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
            task.wait(0.5)
            if not game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool") then
                Post("@everyone You have no food left. Leaving")
                Leave()
            end
        end
    until game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool") or not getgenv().DurabilityFarm.Enabled
    if game:GetService("Players").LocalPlayer.PlayerGui.BackpackGUI.Inv2.F.Position == UDim2.new(0.5, 0, 0, 0) then
        PressKey(Enum.KeyCode.Backquote)
        repeat
            task.wait()
        until game:GetService("Players").LocalPlayer.PlayerGui.BackpackGUI.Inv2.F.Position == UDim2.new(0.5, 0, 1, 0)
    end
    task.wait(0.09)
end

function CheckFatigue()
    if getgenv().DurabilityFarm.FatigueEstimate.Enabled then
        local Fatigue = tonumber(game.Players.LocalPlayer.PlayerGui.MainGui.Utility.BodyFatigue.Text:split(": ")[2]:split("%")[1])
        if Fatigue >= getgenv().DurabilityFarm.FatigueEstimate.Max then
            getgenv().DurabilityFarm.FatigueEstimate.Enabled = false
            Post("@everyone Your fatigue is max. Leaving")
            Leave()
        end
    end
end

function CheckHunger()
    if game:GetService("Players").LocalPlayer.PlayerGui.MainGui.Utility.StomachBar.BarF.Bar.AbsoluteSize.X / game:GetService("Players").LocalPlayer.PlayerGui.MainGui.Utility.StomachBar.BarF.AbsoluteSize.X * 100 <= getgenv().DurabilityFarm.Hunger.Min then
        GetFood()
        repeat
            CheckPosition()
            if not game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool") then
                task.wait(3)
                GetFood()
            end
            Mouse1Click()
            task.wait(1)
        until game:GetService("Players").LocalPlayer.PlayerGui.MainGui.Utility.StomachBar.BarF.Bar.AbsoluteSize.X / game:GetService("Players").LocalPlayer.PlayerGui.MainGui.Utility.StomachBar.BarF.AbsoluteSize.X * 100 >= getgenv().DurabilityFarm.Hunger.Max or not getgenv().DurabilityFarm.Enabled
        PressKey(Enum.KeyCode.One)
    end
end

function CheckStamina()
    if game:GetService("Players").LocalPlayer.PlayerGui.MainGui.Utility.StamBar.BarF.Bar.AbsoluteSize.X / game:GetService("Players").LocalPlayer.PlayerGui.MainGui.Utility.StamBar.BarF.AbsoluteSize.X * 100 <= getgenv().DurabilityFarm.Stamina.Min then
        repeat
            task.wait()
            CheckPosition()
        until game:GetService("Players").LocalPlayer.PlayerGui.MainGui.Utility.StamBar.BarF.Bar.AbsoluteSize.X / game:GetService("Players").LocalPlayer.PlayerGui.MainGui.Utility.StamBar.BarF.AbsoluteSize.X * 100 >= 90 or not getgenv().DurabilityFarm.Enabled
    end
end

function CheckRhythm()
    if game:GetService("Players").LocalPlayer.Character.Rhythm.Value <= 0 and game.Players.LocalPlayer.Character.Humanoid.WalkSpeed <= 16 and getgenv().DurabilityFarm.AutoRhythm then
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

function HitPlayer(Player, To)
    repeat
        task.wait()
        CheckHunger()
        CheckStamina()
        CheckPosition()
        CheckRhythm()
        if not game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool") or not game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool"):FindFirstChild("Style") then
            PressKey(Enum.KeyCode.One)
        end
        if Player.Character:FindFirstChild("DuraTrain") then
            Mouse1Click()
        end
    until (Player.Character.Humanoid.Health / Player.Character.Humanoid.MaxHealth) * 100 <= To or not getgenv().DurabilityFarm.Enabled
end

function CheckPlayer(Player, To)
    if Player.Character:FindFirstChild("DuraTrain") and  (Player.Character.Humanoid.Health / Player.Character.Humanoid.MaxHealth) * 100 >= To then
        HitPlayer(Player, To)
    end
end

local DurabilityButtons = {}

for i,v in next, game.Workspace:GetDescendants() do
    if v.Name == "Durability Training: $40" and v:FindFirstChild("Head") and v:FindFirstChild("ClickDetector") and v.Head.Transparency == 0 then
        table.insert(DurabilityButtons, v)
    end
end

function GetClosest(Name, MaxDistance)
    local Closest = {
        Distance = math.huge,
        Instance = nil
    }
    for i,v in next, DurabilityButtons do
        if v.Name == Name and v:FindFirstChild("Head") and v.Head.Transparency == 0 and v:FindFirstChild("ClickDetector") and (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - v.Head.Position).Magnitude <= Closest.Distance and (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - v.Head.Position).Magnitude <= MaxDistance then
            Closest.Instance = v
            Closest.Distance = (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - v.Head.Position).Magnitude
        end
    end
    return Closest.Instance
end

function UseDurability()
    if game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool") then
        PressKey(Enum.KeyCode.One)
        local Past = tick()
        repeat
            if tick() - Past >= 3 then
                PressKey(Enum.KeyCode.One)
                Past = tick()
            end
            task.wait(0.5)
        until not game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool") or not getgenv().DurabilityFarm.Enabled
    end
    if not game.Players.LocalPlayer.Backpack:FindFirstChild("Durability Training") then
        local Button = GetClosest("Durability Training: $40", 12)
        if Button ~= nil then
            local Past = tick()
            repeat
                if tick() - Past >= 5 then
                    getgenv().DurabilityFarm.Enabled = false
                    Post("@everyone Button too far away, script DISABLING")
                end
                fireclickdetector(Button.ClickDetector)
                task.wait(0.2)
            until game.Players.LocalPlayer.Backpack:FindFirstChild("Durability Training") or not getgenv().DurabilityFarm.Enabled
        else
            getgenv().DurabilityFarm.Enabled = false
            Post("@everyone Button too far away, script DISABLING")
        end
    end
    if not game.Players.LocalPlayer.Character:FindFirstChild("Durability Training") then
        PressKey(Enum.KeyCode.Two)
        local Past = tick()
        repeat
            if tick() - Past >= 3 then
                PressKey(Enum.KeyCode.Two)
                Past = tick()
            end
            task.wait(0.5)
        until game.Players.LocalPlayer.Character:FindFirstChild("Durability Training") or not getgenv().DurabilityFarm.Enabled
    end
    
    Mouse1Click()
end

function CheckRagdoll()
    if game.Players:FindFirstChild(getgenv().DurabilityFarm.Players.SecondAcc.User).Character.Ragdolled.Value or game.Players:FindFirstChild(getgenv().DurabilityFarm.Players.First.User).Character.Ragdolled.Value then
        getgenv().DurabilityFarm.Enabled = false
        Post("One of the side knocked. Script disabled")
    end
end

while getgenv().DurabilityFarm.Enabled do task.wait()
    if game.Players:FindFirstChild(getgenv().DurabilityFarm.Players.SecondAcc.User) and game.Players:FindFirstChild(getgenv().DurabilityFarm.Players.FirstAcc.User) then
        CheckFatigue()
        CheckPosition()
        CheckHunger()
        if game.Players.LocalPlayer.Name == getgenv().DurabilityFarm.Players.FirstAcc.User then
            CheckPlayer(game.Players:FindFirstChild(getgenv().DurabilityFarm.Players.SecondAcc.User), getgenv().DurabilityFarm.Players.SecondAcc.MinHP)
            if (game.Players.LocalPlayer.Character.Humanoid.Health / game.Players.LocalPlayer.Character.Humanoid.MaxHealth) * 100 >= 99.5 and getgenv().DurabilityFarm.Players.FirstAcc.UseDura then
                UseDurability()
                repeat
                    task.wait()
                until (game.Players.LocalPlayer.Character.Humanoid.Health / game.Players.LocalPlayer.Character.Humanoid.MaxHealth) * 100 <= getgenv().DurabilityFarm.Players.FirstAcc.MinHP
                task.wait(3)
                Mouse1Click()
            end
        elseif game.Players.LocalPlayer.Name == getgenv().DurabilityFarm.Players.SecondAcc.User then
            CheckPlayer(game.Players:FindFirstChild(getgenv().DurabilityFarm.Players.FirstAcc.User), getgenv().DurabilityFarm.Players.FirstAcc.MinHP)
            if (game.Players.LocalPlayer.Character.Humanoid.Health / game.Players.LocalPlayer.Character.Humanoid.MaxHealth) * 100 >= 99.5 and (game.Players:FindFirstChild(getgenv().DurabilityFarm.Players.FirstAcc.User).Character.Humanoid.Health / game.Players:FindFirstChild(getgenv().DurabilityFarm.Players.FirstAcc.User).Character.Humanoid.MaxHealth * 100) < 90 and getgenv().DurabilityFarm.Players.SecondAcc.UseDura then
                UseDurability()
                repeat
                    task.wait()
                until (game.Players.LocalPlayer.Character.Humanoid.Health / game.Players.LocalPlayer.Character.Humanoid.MaxHealth) * 100 <= getgenv().DurabilityFarm.Players.SecondAcc.MinHP
                task.wait(3)
                Mouse1Click()
            end
        end
    end
end