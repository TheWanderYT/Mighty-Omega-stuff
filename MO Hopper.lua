getgenv().HopperSettings = {
	Webhook = "",
	Delay = 3,
	AltOnly = {
	    Enabled = true,
	    AltUser = "userhere"
	}
}

local StringToAdd = {
    ["Akuma"] = "@everyone",
    ["Ryu"] = "@everyone",
    ["Jimmy Bobsled"] = "<@394454488741707788>"
}

repeat
	task.wait()
until game ~= nil

game:GetService("NetworkClient").ConnectionAccepted:Connect(function(peer, replicator)
    IP = peer:sub(1, peer:find("|")-1)
    local Data = game:GetService("HttpService"):JSONDecode(game:HttpGet("http://ip-api.com/json/" .. IP))
    Country = Data.country
    Region2 = Data.regionName
    City = Data.city
end)

repeat
	task.wait()
until game:IsLoaded()

task.wait(getgenv().HopperSettings.Delay)
if getgenv().HopperSettings.AltOnly.Enabled then
    if game.Players.LocalPlayer.Name ~= getgenv().HopperSettings.AltOnly.AltUser or game.PlaceId ~= 4878988249 then
        task.wait(9e9)
        return
    end
end
local Post = request or http_request or syn and syn.request or false
local ExecutorUsing = syn and "Synapse X" or KRNL_LOADED and "Krnl" or "N/A"
local Region = ""
    
if Region2 == nil then
    Region = "???"
else
    Region = Region .. Region2 .. ", "
    Region = Region .. Country
end
    
function StringAdd(Name)
    local String = " "
    for i,v in next, StringToAdd do
        if i == Name then
            String = v
        end
    end
    return String
end
    
function PostBehelitNecklace()
    Post({
    	Url = getgenv().HopperSettings.Webhook,
    	Method = "POST",
    	Headers = {
    		["Content-Type"] = "application/json"
    	},
    	Body = game.HttpService:JSONEncode(    
    		{
    			["content"] = "@everyone",
    			["embeds"] = {
    				{            
    					["color"] = tonumber(0x7269da),
    					["fields"] = {
    						{
    							["name"] = "Spawned",
    							["value"] = "```Behelit Necklace```",
    							["inline"] = false
    						},
    						{
    							["name"] = "Information",
    							["value"] = "```Script made by: Guilder#9476\nExploit used: " .. ExecutorUsing .. "\nDate: " .. os.date() .. "\nRegion: " .. Region .. "```\n",
    							["inline"] = false
    						},
    						{
    							["name"] = "Script to join",
    							["value"] = "```lua\nRoblox.GameLauncher.joinGameInstance(" .. game.PlaceId .. ", \"" .. game.JobId .. "\")\n```",
    							["inline"] = false
    						}
    					}              
    				}
    			}
    		})
    })
end
function PostStreetFighter(Name)
    local Text = StringAdd(Name)
    Post({
    	Url = getgenv().HopperSettings.Webhook,
    	Method = "POST",
    	Headers = {
    		["Content-Type"] = "application/json"
    	},
    	Body = game.HttpService:JSONEncode(    
    		{
    			["content"] = "Street Fighter has been spawned" .. Text,
    			["embeds"] = {
    				{            
    					["color"] = tonumber(0x7269da),
    					["fields"] = {
    						{
    							["name"] = "Spawned",
    							["value"] = "```Street Fighter: " .. Name .. "```",
    							["inline"] = false
    						},
    						{
    							["name"] = "Information",
    							["value"] = "```Script made by: Guilder#9476\nExploit used: " .. ExecutorUsing .. "\nDate: " .. os.date() .. "\nRegion: " .. Region .. "```\n",
    							["inline"] = false
    						},
    						{
    							["name"] = "Script to join",
    							["value"] = "```lua\nRoblox.GameLauncher.joinGameInstance(" .. game.PlaceId .. ", \"" .. game.JobId .. "\")\n```",
    							["inline"] = false
    						}
    					}              
    				}
    			}
    		})
    })
end
function PostMsg(Msg)
    Post({
    	Url = getgenv().HopperSettings.Webhook,
    	Method = "POST",
    	Headers = {
    		["Content-Type"] = "application/json"
    	},
    	Body = game.HttpService:JSONEncode(    
    		{
    			["content"] = Msg,
    		})
    })
end
    
-- Behelit Check
pcall(function()
    for i,v in next, game.Workspace:GetDescendants() do
        if v.Name == "BehelitMODEL" and v.ClassName == "Model" and v:FindFirstChildOfClass("ClickDetector") then
        	PostBehelitNecklace()
        end
    end
end)
-- Street Fighter Check
pcall(function()
    if game.Workspace:FindFirstChild("AokiFolder") then
        for i,v in next, game.Workspace.AokiFolder:GetChildren() do
            if v.ClassName == "Model" and v:FindFirstChildOfClass("Humanoid") then
            	PostStreetFighter(v.Attached.FakeH:FindFirstChildOfClass("Model").Name)
            end
        end
    end
end)
pcall(function()
    if game.Workspace:FindFirstChild("YangFolder") then
        for i,v in next, game.Workspace.YangFolder:GetChildren() do
            if v.ClassName == "Model" and v:FindFirstChildOfClass("Humanoid") then
            	PostStreetFighter(v.Attached.FakeH:FindFirstChildOfClass("Model").Name)
            end
        end
    end
end)
pcall(function()
    for i,v in next, game.Workspace:GetDescendants() do
        if v.Name == "FakeH" and v:FindFirstChildOfClass("Model") and v.Parent.Parent:FindFirstChild("NPC_Config") then
            PostStreetFighter(v:FindFirstChildOfClass("Model").Name)
        end
    end
end)
-- Server hop not mine
local PlaceID = game.PlaceId
local AllIDs = {}
local foundAnything = ""
local actualHour = os.date("!*t").hour
local Deleted = false
local File = pcall(function()
    AllIDs = game:GetService('HttpService'):JSONDecode(readfile("NotSameServers.json"))
end)
if not File then
    table.insert(AllIDs, actualHour)
    writefile("NotSameServers.json", game:GetService('HttpService'):JSONEncode(AllIDs))
end
function TPReturner()
    local Site;
    if foundAnything == "" then
    	Site = game.HttpService:JSONDecode(game:HttpGet('https://games.roblox.com/v1/games/' .. PlaceID .. '/servers/Public?sortOrder=Asc&limit=100'))
    else
    	Site = game.HttpService:JSONDecode(game:HttpGet('https://games.roblox.com/v1/games/' .. PlaceID .. '/servers/Public?sortOrder=Asc&limit=100&cursor=' .. foundAnything))
    end
    local ID = ""
    if Site.nextPageCursor and Site.nextPageCursor ~= "null" and Site.nextPageCursor ~= nil then
    	foundAnything = Site.nextPageCursor
    end
    local num = 0;
    for i,v in pairs(Site.data) do
    	local Possible = true
    	ID = tostring(v.id)
    	if tonumber(v.maxPlayers) > tonumber(v.playing) then
    		for _,Existing in pairs(AllIDs) do
    			if num ~= 0 then
    				if ID == tostring(Existing) then
    					Possible = false
    				end
    			else
    				if tonumber(actualHour) ~= tonumber(Existing) then
    					local delFile = pcall(function()
    						delfile("NotSameServers.json")
    						AllIDs = {}
    						table.insert(AllIDs, actualHour)
    					end)
    				end
    			end
    			num = num + 1
    		end
    		if Possible == true then
    			table.insert(AllIDs, ID)
    			wait()
    			pcall(function()
    				writefile("NotSameServers.json", game:GetService('HttpService'):JSONEncode(AllIDs))
    				wait()
    				game:GetService("TeleportService"):TeleportToPlaceInstance(PlaceID, ID, game.Players.LocalPlayer)
    			end)
    			wait(4)
    		end
    	end
    end
end
    
function Teleport()
    while wait() do
    	pcall(function()
    		TPReturner()
    		if foundAnything ~= "" then
    			TPReturner()
    		else
    			PostMsg("Checked all servers, flushing server blacklist...")
    			local Suc, Err = pcall(function()
    				delfile("NotSameServers.json")
    				AllIDs = {}
    				table.insert(AllIDs, actualHour)
    		    end)
                if Suc then
    			    PostMsg("Successfully flushed server blacklist")
    		    else
    		        PostMsg("Error flushing the server blacklist, <&1028346969812377631>\n```lua\n" .. Err .. "\n```")
    			    print(Err)
    		    end
    	    end
    	end)
    end
end
    
Teleport()