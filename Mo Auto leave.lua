local Settings = {
    ["LowerBodyMuscle"] = {
        Amount = 120,
        Type = "Min" -- Types is Min, Max
    }
}


--Ignore
getgenv().Stats = {
    ["Durability"] = 0,
    ["StrikingPower"] = 0,
    ["StrikingSpeed"] = 0,
    ["UpperBodyMuscle"] = 0,
    ["LowerBodyMuscle"] = 0,
    ["RunningSpeed"] = 0,
    ["Stamina"] = 0,
    ["Height"] = 0
}
Unload = false
function Leave()
    local Arg = {}
    
    local function Holder()
        table.insert(Arg, "Hi")
    end
    
    local Hook = hookfunction(table.insert,Holder)
    
    table.insert(Arg, Holder())
end
function Round(Number)
    if tostring(Number):find(".") then
        local newNum = Number * 100
        local flooredNum = math.floor(newNum + 5)
        local finalNum = flooredNum / 100
        return finalNum
    end
end
local function UpdateStats()
    task.wait(0.05)
    if Script ~= nil and Script.Parent ~= nil and Script.ClassName == "LocalScript" then
        for i,v in next, getreg() do
            if typeof(v) == "function" and islclosure(v) then
                local Script2 = getfenv(v).script
                if Script2 ~= nil and Script2 == Script then
                    local UpValues = getupvalues(v)
                    for i2,v2 in next, UpValues do
                        if type(v2) == "table" and i2 == 1 and v2["Durability"] then
                            for i3,v3 in next, v2 do
                                if getgenv().Stats[i3] then
                                    spawn(function()
                                        while not Unload do task.wait()
                                            getgenv().Stats[i3] = Round(debug.getupvalue(v,i2)[i3])
                                        end
                                    end)
                                end
                            end
                        end
                    end
                end
            end
        end
    else
        Script = game:GetService("Players").LocalPlayer.Backpack:WaitForChild("LocalS", 9e9)
        repeat
            task.wait()
        until Script ~= nil and Script.Parent ~= nil and Script.ClassName == "LocalScript"
    end
end

spawn(function()
    while not Unload do task.wait()
        if Script == nil or Script.Parent == nil or Script.ClassName ~= "LocalScript" then
            UpdateStats()
        end
    end
end)

UpdateStats()
task.wait(1)
while true do task.wait()
    for i,v in next, Settings do
        if getgenv().Stats[i] then
            if v.Type == "Min" then
                if getgenv().Stats[i] <= v.Amount then
                    Leave()
                end
            elseif v.Type == "Max" then
                if getgenv().Stats[i] >= v.Amount then
                    Leave()
                end
            end
        end
    end
end