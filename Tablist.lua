-- // Very trash "Universal" Tablist, with support for bedwars (easy.gg)
-- // Made it bedwars only, if you want to make it universal change the settings on line 8

repeat wait() until game:IsLoaded()

getgenv().tablistSettings = {
    KeyCode = Enum.KeyCode.Tab,
    BedwarsOnly = true
}

assert(not getgenv().tablist, "tablist has already been initialized")
getgenv().tablist = true

local requestfunc = syn and syn.request or http and http.request or http_request or fluxus and fluxus.request or getgenv().request or request

function isBedwars() 
    if game.PlaceId == 6872274481 then 
        return true
    end
    return false
end

if tablistSettings.BedwarsOnly then
    if game.PlaceId ~= 6872274481 then
        return 
    end
end

function getGameUniverseId()
    local placeid = game.PlaceId  
    
    local req = requestfunc({
        Url = "https://api.roblox.com/universes/get-universe-containing-place?placeid="..placeid,
        Method = "GET",
    })
    if req.StatusCode == 200 then 
        local old = tostring(req.Body)
        local new1 = old:gsub('{"UniverseId":', "")
        return tonumber(new1:gsub("}", ""):split(" ")[1])
    end
end

function getGameName()
    if isBedwars() then return game:GetService("MarketplaceService"):GetProductInfo(6872265039).Name end
    return game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name
end

function formatGameName()
    local s = getGameName()
    local z = string.gsub(s, "%b[]", "")
    local x = string.match(s, "%[.*%]")
    return z,x
end

spawn(function()
    for i = 1, 5 do
        pcall(function()
            game:GetService("CoreGui"):WaitForChild("PlayerList"):Destroy()
        end)
        wait(0.25)
    end
end)    

if game:GetService("CoreGui"):FindFirstChild("Tablist") then game:GetService("CoreGui").Tablist:Remove() end
local name, desc = formatGameName()
if desc == nil then 
    desc = "Tablist found no description"
end

local Tablist = Instance.new("ScreenGui")
Tablist.Enabled = false
local Tablist_2 = Instance.new("Frame")
local GameContainer = Instance.new("Frame")
local GameDescription = Instance.new("TextLabel")
local GameName = Instance.new("TextLabel")
local PlayerList = Instance.new("Frame")
local UIListLayout = Instance.new("UIListLayout")
Tablist.Name = "Tablist"
Tablist.Parent = game.CoreGui
Tablist.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

Tablist_2.Name = "Tablist"
Tablist_2.Parent = Tablist
Tablist_2.AnchorPoint = Vector2.new(0.5, 0)
Tablist_2.BackgroundColor3 = Color3.fromRGB(26, 26, 26)
Tablist_2.BackgroundTransparency = 0.400
Tablist_2.BorderSizePixel = 0
Tablist_2.Position = UDim2.new(0.5, 0, 0, 0)
Tablist_2.Size = UDim2.new(0, 233, 0, 616)

GameContainer.Name = "GameContainer"
GameContainer.Parent = Tablist
GameContainer.BackgroundColor3 = Color3.fromRGB(22, 22, 22)
GameContainer.BackgroundTransparency = 0.95
GameContainer.BorderColor3 = Color3.fromRGB(27, 42, 53)
GameContainer.Position = UDim2.new(0.5, 0, 0, 0)
GameContainer.Size = UDim2.new(0, 233, 0, 37)
GameContainer.AnchorPoint = Vector2.new(0.5, 0)

GameDescription.Name = "GameDescription"
GameDescription.Parent = GameContainer
GameDescription.AnchorPoint = Vector2.new(0.5, 0)
GameDescription.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
GameDescription.BackgroundTransparency = 1.000
GameDescription.BorderSizePixel = 0
GameDescription.Position = UDim2.new(0.5, 0, 0.550000012, 0)
GameDescription.Size = UDim2.new(0, 183, 0, 15)
GameDescription.Font = Enum.Font.SourceSansSemibold
GameDescription.Text = desc
GameDescription.TextColor3 = Color3.fromRGB(255, 255, 255)
GameDescription.TextScaled = true
GameDescription.TextSize = 14.000
GameDescription.TextWrapped = true

GameName.Name = "GameName"
GameName.Parent = GameContainer
GameName.AnchorPoint = Vector2.new(0.5, 0)
GameName.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
GameName.BackgroundTransparency = 1.000
GameName.BorderSizePixel = 0
GameName.Position = UDim2.new(0.5, 0, 0, 0)
GameName.Size = UDim2.new(0, 183, 0, 21)
GameName.Font = Enum.Font.SourceSansBold
GameName.Text = name
GameName.TextColor3 = Color3.fromRGB(255, 255, 255)
GameName.TextScaled = true
GameName.TextSize = 14.000
GameName.TextWrapped = true

PlayerList.Name = "PlayerList"
PlayerList.Parent = Tablist
PlayerList.AnchorPoint = Vector2.new(0.5, 0)
PlayerList.BackgroundColor3 = Color3.fromRGB(26, 26, 26)
PlayerList.BackgroundTransparency = 1.000
PlayerList.BorderSizePixel = 0
PlayerList.Position = UDim2.new(0.5, 0, 0.056, 0)
PlayerList.Size = UDim2.new(0, 212, 0, 26)

UIListLayout.Parent = PlayerList
UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder

local tabtable = {}
local function UpdateCanvasSize(Canvas)
    Canvas.Size = UDim2.new(0, 233, 0, UIListLayout.AbsoluteContentSize.Y + 75)
end
UpdateCanvasSize(Tablist_2)

function createPlayer(player)
    if tabtable[player.UserId] then
            return
    end

    local Player = Instance.new("Frame")
    local PlayerName = Instance.new("TextLabel")
    local HeadShot = Instance.new("ImageLabel")
    local userid = Instance.new("NumberValue", Player)

    userid.Name = "PlayerUserId"
    userid.Value = player.UserId

    Player.Name = player.DisplayName
    Player.Parent = PlayerList
    Player.BackgroundColor = player.TeamColor
    Player.BackgroundTransparency = 0.55
    Player.BorderSizePixel = 0
    Player.Position = UDim2.new(0.146226421, 0, 0, 0)
    Player.Size = UDim2.new(0, 166, 0, 25)

    PlayerName.Name = "PlayerName"
    PlayerName.Parent = Player
    PlayerName.BackgroundColor3 = Color3.fromRGB(22, 22, 22)
    PlayerName.BackgroundTransparency = 1.000
    PlayerName.BorderColor3 = Color3.fromRGB(27, 42, 53)
    PlayerName.BorderSizePixel = 0
    PlayerName.Position = UDim2.new(0.197297245, 0, 0, 0)
    PlayerName.Size = UDim2.new(0, 126, 0, 25)
    PlayerName.Font = Enum.Font.SourceSans
    PlayerName.Text = player.DisplayName
    PlayerName.TextColor3 = Color3.fromRGB(255, 255, 255)
    PlayerName.TextSize = 14.000
    PlayerName.TextWrapped = true
    PlayerName.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
    PlayerName.TextStrokeTransparency = 0
    if isBedwars() then 
        local value1 = player:WaitForChild("leaderstats"):WaitForChild("Bed").Value
        if value1 == "✅" then 
            PlayerName.TextColor3 = Color3.fromRGB(59, 255, 69)
        else
            PlayerName.TextColor3 = Color3.fromRGB(255, 22, 22)
        end

        player.leaderstats.Bed.Changed:Connect(function(value2)
            if value2 == "✅" then 
                PlayerName.TextColor3 = Color3.fromRGB(59, 255, 69)
            else
                PlayerName.TextColor3 = Color3.fromRGB(255, 22, 22)
            end
        end)
    end
    player:GetPropertyChangedSignal("TeamColor"):Connect(function()
        Player.BackgroundColor = player.TeamColor
    end)

    HeadShot.Name = "HeadShot"
    HeadShot.Parent = Player
    HeadShot.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    HeadShot.BackgroundTransparency = 1.000
    HeadShot.BorderSizePixel = 0
    HeadShot.Size = UDim2.new(0, 25, 0, 25)
    HeadShot.Image = "rbxthumb://type=AvatarHeadShot&id="..player.UserId.."&w=48&h=48"
    tabtable[player.UserId] = Player
end

function removePlayer(userid)
    if tabtable[userid] then
        tabtable[userid].Visible = false
    end
end

for i,v in pairs(game.Players:GetChildren()) do 
    wait()
    createPlayer(v)
    UpdateCanvasSize(Tablist_2)
end

playerjoinconnection = game.Players.ChildAdded:Connect(function(player)
    print(player.UserId)
    createPlayer(player)
    UpdateCanvasSize(Tablist_2)
end)

playerleaveconnection = game.Players.PlayerRemoving:Connect(function(player)
    removePlayer(player.UserId)
    UpdateCanvasSize(Tablist_2)
end)

inputbeganconnection = game:GetService("UserInputService").InputBegan:Connect(function(c)
    if c.KeyCode == tablistSettings.KeyCode then
        Tablist.Enabled = true
    end
end)

inputendedconnection = game:GetService("UserInputService").InputEnded:Connect(function(c)
    if c.KeyCode == tablistSettings.KeyCode then
        Tablist.Enabled = false
    end
end)
