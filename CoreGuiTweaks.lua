-- // Consists of Rejoin button. More to come

repeat task.wait() until game:IsLoaded()
local getasset = getsynasset or getcustomasset
local requestfunc = syn and syn.request or http and http.request or http_request or fluxus and fluxus.request or getgenv().request or request
local function getcustomassetfunc(path)
    makefolder("engo")
    makefolder("engo/assets")
	if not isfile(path) then
		local req = requestfunc({
			Url = "https://raw.githubusercontent.com/joeengo/roblox/main/"..path:gsub("engo/assets", "assets"),
			Method = "GET"
		})
		writefile(path, req.Body)
	end
	return getasset(path) 
end

-- // Insert Rejoin Button
local ResetGameButtonButton = Instance.new("ImageButton")
local ResetGameButtonTextLabel = Instance.new("TextLabel")
local UITextSizeConstraint = Instance.new("UITextSizeConstraint")
local ResetGameButtonHint = Instance.new("ImageLabel")

ResetGameButtonButton.Name = "ResetGameButtonButton"
ResetGameButtonButton.Parent = game:GetService("CoreGui"):WaitForChild("RobloxGui"):WaitForChild("SettingsShield"):WaitForChild("SettingsShield"):WaitForChild("MenuContainer"):WaitForChild("BottomButtonFrame")
ResetGameButtonButton.BackgroundTransparency = 1.000
ResetGameButtonButton.Position = UDim2.new(0.5, -130, 0.5, 50)
ResetGameButtonButton.Size = UDim2.new(0, 260, 0, 70)
ResetGameButtonButton.ZIndex = 2
ResetGameButtonButton.AutoButtonColor = false
ResetGameButtonButton.Image = "rbxasset://textures/ui/Settings/MenuBarAssets/MenuButton.png"
ResetGameButtonButton.ScaleType = Enum.ScaleType.Slice
ResetGameButtonButton.SliceCenter = Rect.new(8, 6, 46, 44)

ResetGameButtonTextLabel.Name = "ResetGameButtonTextLabel"
ResetGameButtonTextLabel.Parent = ResetGameButtonButton
ResetGameButtonTextLabel.BackgroundTransparency = 1.000
ResetGameButtonTextLabel.BorderSizePixel = 0
ResetGameButtonTextLabel.Position = UDim2.new(0.25, 0, 0, 0)
ResetGameButtonTextLabel.Size = UDim2.new(0.75, 0, 0.899999976, 0)
ResetGameButtonTextLabel.ZIndex = 2
ResetGameButtonTextLabel.Font = Enum.Font.SourceSansBold
ResetGameButtonTextLabel.Text = "Rejoin"
ResetGameButtonTextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
ResetGameButtonTextLabel.TextScaled = true
ResetGameButtonTextLabel.TextSize = 24.000
ResetGameButtonTextLabel.TextWrapped = true

UITextSizeConstraint.Parent = ResetGameButtonTextLabel
UITextSizeConstraint.MaxTextSize = 24

ResetGameButtonHint.Name = "ResetGameButtonHint"
ResetGameButtonHint.Parent = ResetGameButtonButton
ResetGameButtonHint.AnchorPoint = Vector2.new(0.5, 0.5)
ResetGameButtonHint.BackgroundTransparency = 1.000
ResetGameButtonHint.Position = UDim2.new(0.150000006, 0, 0.474999994, 0)
ResetGameButtonHint.Size = UDim2.new(0, 55, 0, 60)
ResetGameButtonHint.ZIndex = 4
ResetGameButtonHint.Image = getcustomassetfunc("engo/assets/RejoinIcon.png")

ResetGameButtonButton.MouseEnter:Connect(function() 
	ResetGameButtonButton.Image = "rbxasset://textures/ui/Settings/MenuBarAssets/MenuButtonSelected.png"
end)

ResetGameButtonButton.MouseLeave:Connect(function()
	ResetGameButtonButton.Image = "rbxasset://textures/ui/Settings/MenuBarAssets/MenuButton.png"
end)

ResetGameButtonButton.MouseButton1Click:Connect(function()
	game:GetService("TeleportService"):Teleport(game.PlaceId)
end)

game:GetService("UserInputService").InputEnded:Connect(function(input)
	if input.KeyCode == Enum.KeyCode.J and ResetGameButtonButton.Parent.Parent.Parent.Visible then 
		game:GetService("TeleportService"):Teleport(game.PlaceId)
	end
end)

spawn(function() 
    local X, Y, X2, Y2 = 0, 0.676, 0, 0
    if isfolder("engo/savedpositions") then 
        if isfile("engo/savedpositions/chatX.txt") then
            X = readfile("engo/savedpositions/chatX.txt")
        end
        if isfile("engo/savedpositions/chatY.txt") then
            Y = readfile("engo/savedpositions/chatY.txt")
        end
        if isfile("engo/savedpositions/chatY2.txt") then 
            Y2 = readfile("engo/savedpositions/chatY2.txt")
        end
        if isfile("engo/savedpositions/chatX2.txt") then 
            X2 = readfile("engo/savedpositions/chatX2.txt")
        end
    else
        makefolder("engo/savedpositions")
    end
    X = tonumber(X)
    Y = tonumber(Y)
    Y2 = tonumber(Y2)
    X2 = tonumber(X2)
    local chat = game.Players.LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("Chat"):WaitForChild("Frame")
    if shared.CustomChatSize then
	chat.Position = UDim2.new(X, X2, Y, Y2)
    chat.ChatChannelParentFrame.Size = UDim2.new(0.5, 0, 1.2, -46)
    chat.ChatBarParentFrame.Size = UDim2.new(0.5, 0, 0, 42)
    chat.ChatBarParentFrame.Position = UDim2.new(0,0,1,10)
    chat.Draggable = true
    chat.Active = true
			end

    repeat

        if isfile("engo/savedpositions/chatY.txt") then 
            delfile("engo/savedpositions/chatY.txt")
        end
        if isfile("engo/savedpositions/chatX.txt") then 
            delfile("engo/savedpositions/chatX.txt")
        end
        if isfile("engo/savedpositions/chatY2.txt") then 
            delfile("engo/savedpositions/chatY2.txt")
        end
        if isfile("engo/savedpositions/chatX2.txt") then 
            delfile("engo/savedpositions/chatX2.txt")
        end

        writefile("engo/savedpositions/chatX.txt", tostring(chat.Position.X.Offset))
        writefile("engo/savedpositions/chatY.txt", tostring(chat.Position.Y.Offset))
        writefile("engo/savedpositions/chatX2.txt", tostring(chat.Position.X.Scale))
        writefile("engo/savedpositions/chatY2.txt", tostring(chat.Position.Y.Scale))

        task.wait(5)

    until false == true
end)     
