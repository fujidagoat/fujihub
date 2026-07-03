local MarketplaceService = game:GetService("MarketplaceService")
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")

local LocalPlayer = Players.LocalPlayer

local Theme = {
    SchemeColor = Color3.fromRGB(80, 140, 255),
    Background = Color3.fromRGB(12, 16, 24),
    Header = Color3.fromRGB(18, 24, 36),
    TextColor = Color3.fromRGB(235, 240, 255),
    ElementColor = Color3.fromRGB(22, 30, 46)
}

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("Fuji1k🐬", Theme)

local Home = Window:NewTab("home")
local Main = Window:NewTab("main")
local Player = Window:NewTab("player")
local Visuals = Window:NewTab("visuals")
local Farms = Window:NewTab("farms")

-- Home

local HomeSection1 = Home:NewSection("home")

local MarketplaceService = game:GetService("MarketplaceService")
local GameInfo = MarketplaceService:GetProductInfo(game.PlaceId)

local GameInfoButton = HomeSection1:NewButton("game name: " .. GameInfo.Name, "the games name", function()
    toClipboard(gameInfo.Name)
end)

local PlayersAmountButton = HomeSection1:NewButton("players in server: " .. #game.Players:GetPlayers(), "the amnt of players in game", function()
    toClipboard(#game.Players:GetPlayers())
end)

game.Players.PlayerAdded:Connect(function()
	PlayersAmountButton:UpdateButton("players in server: " .. #game.Players:GetPlayers())
end)

game.Players.PlayerRemoving:Connect(function()
	PlayersAmountButton:UpdateButton("players in server: " .. #game.Players:GetPlayers())
end)

HomeSection1:NewButton("placeid: " .. game.PlaceId, "the game's place id", function()
    toClipboard(game.PlaceId)
end)

HomeSection1:NewButton("jobid: " .. game.JobId, "the game's place id", function()
    toClipboard(game.JobId)
end)

HomeSection1:NewKeybind("toggle ui", "key to toggle the gui.", Enum.KeyCode.Semicolon, function()
	Library:ToggleUI()
end)

-- Main

local MainSection1 = Main:NewSection("main")

local Players = game:GetService("Players")
local lp = Players.LocalPlayer

local RANGE = 500

local function getHRP(char)
	return char and char:FindFirstChild("HumanoidRootPart")
end

local function attackTarget(plr)
	local char = lp.Character
	local myHRP = getHRP(char)
	local targetChar = plr.Character
	local targetHRP = getHRP(targetChar)

	if not myHRP or not targetHRP then return end

	local hum = targetChar:FindFirstChildOfClass("Humanoid")
	if not hum then return end

	local knife = lp.Backpack:FindFirstChild("Knife") or char:FindFirstChild("Knife")
	if not knife then return end

	while hum.Health > 0 do
		if not targetChar or not targetChar.Parent then break end

		local dist = (myHRP.Position - targetHRP.Position).Magnitude
		if dist > RANGE then break end

		char:PivotTo(targetHRP.CFrame + Vector3.new(0, 0, 2))
		mouse1click()

		task.wait(0.15)
	end
end

local function killAllInRange()
	for _, plr in ipairs(Players:GetPlayers()) do
		if plr ~= lp and plr.Character then
			local myHRP = lp.Character and lp.Character:FindFirstChild("HumanoidRootPart")
			local targetHRP = plr.Character:FindFirstChild("HumanoidRootPart")

			if myHRP and targetHRP then
				local dist = (myHRP.Position - targetHRP.Position).Magnitude
				if dist <= RANGE then
					attackTarget(plr)
				end
			end
		end
	end
end

local KillAll = MainSection1:NewButton("kill all (murderer)", "kills everyone in the lobby", function()
   killAllInRange()
end)

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local function hasGun(player)
    local char = player.Character
    if char and char:FindFirstChild("Gun") then
        return true
    end

    local backpack = player:FindFirstChild("Backpack")
    if backpack and backpack:FindFirstChild("Gun") then
        return true
    end

    return false
end

local TPToSheriff = MainSection1:NewButton("teleport to sheriff", "teleports you to the sheriff", function()
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and hasGun(player) then
            local targetChar = player.Character
            local myChar = LocalPlayer.Character

            if targetChar and targetChar:FindFirstChild("HumanoidRootPart") and myChar and myChar:FindFirstChild("HumanoidRootPart") then
                myChar.HumanoidRootPart.CFrame = targetChar.HumanoidRootPart.CFrame + Vector3.new(0, 3, 0)
            end

            break -- stops at first valid gun holder
        end
    end
end)

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local function hasKnife(player)
    local char = player.Character
    if char and char:FindFirstChild("Knife") then
        return true
    end

    local backpack = player:FindFirstChild("Backpack")
    if backpack and backpack:FindFirstChild("Knife") then
        return true
    end

    return false
end

local TPToKnife = MainSection1:NewButton("teleport to murderer", "teleports you to the knife holder", function()
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and hasKnife(player) then
            local targetChar = player.Character
            local myChar = LocalPlayer.Character

            if targetChar and targetChar:FindFirstChild("HumanoidRootPart") and myChar and myChar:FindFirstChild("HumanoidRootPart") then
                myChar.HumanoidRootPart.CFrame = targetChar.HumanoidRootPart.CFrame + Vector3.new(0, 3, 0)
            end

            break
        end
    end
end)

MainSection1:NewToggle("gun teleport", "automatically teleports you to the gun after sheriff dies.", function(state)
    if state then
        gunTPEnabled = true
        while gunTPEnabled do
            task.wait(.5)
            print("searching")
            -- Find GunDrop anywhere in the workspace
            for _, obj in ipairs(workspace:GetDescendants()) do
                if obj:IsA("BasePart") and obj.Name == "GunDrop" then
                    -- Create ESP effect
                    local position = game.Players.LocalPlayer.Character.HumanoidRootPart.Position
                    game.Players.LocalPlayer.Character.HumanoidRootPart.Position = obj.Position
                    wait(0.5)
                    game.Players.LocalPlayer.Character.HumanoidRootPart.Position = position
                    game.Players.LocalPlayer.Character.HumanoidRootPart.Position = game.Players.LocalPlayer.Character.UpperTorso
                    break
                end
            end
        end
    else
        gunTPEnabled = false
    end
end)

-- Visuals

local VisualsSection1 = Visuals:NewSection("visuals")

local Players = game:GetService("Players")

local enabled = false
local highlights = {}

local function hasGun(player)
    local backpack = player:FindFirstChild("Backpack")
    local character = player.Character

    if backpack and backpack:FindFirstChild("Gun") then
        return true
    end

    if character and character:FindFirstChild("Gun") then
        return true
    end

    return false
end

local function addHighlight(player)
    if highlights[player] then return end

    local char = player.Character
    if not char then return end

    local highlight = Instance.new("Highlight")
    highlight.FillColor = Color3.fromRGB(0, 170, 255)
    highlight.OutlineColor = Color3.fromRGB(0, 170, 255)
    highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    highlight.Adornee = char
    highlight.Parent = char

    highlights[player] = highlight
end

local function removeHighlight(player)
    if highlights[player] then
        highlights[player]:Destroy()
        highlights[player] = nil
    end
end

local function update()
    for _, player in ipairs(Players:GetPlayers()) do
        if player.Character then
            if hasGun(player) then
                addHighlight(player)
            else
                removeHighlight(player)
            end
        end
    end
end

VisualsSection1:NewToggle("Sheriff ESP", "Highlights players holding Gun", function(state)
    enabled = state

    if not enabled then
        for player, hl in pairs(highlights) do
            hl:Destroy()
        end
        highlights = {}
        return
    end

    task.spawn(function()
        while enabled do
            update()
            task.wait(0.5)
        end
    end)
end)

local Players = game:GetService("Players")

local murdererEnabled = false
local murdererHighlights = {}

local function hasKnife(player)
    local backpack = player:FindFirstChild("Backpack")
    local character = player.Character

    if (backpack and backpack:FindFirstChild("Knife")) or
       (character and character:FindFirstChild("Knife")) then
        return true
    end

    return false
end

local function addHighlight(player)
    if murdererHighlights[player] then return end
    if not player.Character then return end

    local h = Instance.new("Highlight")
    h.Adornee = player.Character
    h.FillColor = Color3.fromRGB(255, 0, 0)
    h.OutlineColor = Color3.fromRGB(255, 0, 0)
    h.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    h.Parent = player.Character

    murdererHighlights[player] = h
end

local function removeHighlight(player)
    if murdererHighlights[player] then
        murdererHighlights[player]:Destroy()
        murdererHighlights[player] = nil
    end
end

local function updateMurderer()
    for _, player in ipairs(Players:GetPlayers()) do
        if player.Character and hasKnife(player) then
            addHighlight(player)
        else
            removeHighlight(player)
        end
    end
end

VisualsSection1:NewToggle("Murderer ESP", "Knife holders (red)", function(state)
    murdererEnabled = state

    if not state then
        for _, h in pairs(murdererHighlights) do
            h:Destroy()
        end
        murdererHighlights = {}
        return
    end

    task.spawn(function()
        while murdererEnabled do
            updateMurderer()
            task.wait(0.5)
        end
    end)
end)

-- Players

local PlayersSection1 = Player:NewSection("player")

PlayersSection1:NewSlider("walkspeed", "determines your walkspeed", 40, 16, function(s) -- 500 (MaxValue) | 0 (MinValue)
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = s
end)

PlayersSection1:NewSlider("jumppower", "determines your jumppower", 100, 50, function(s) -- 500 (MaxValue) | 0 (MinValue)
    game.Players.LocalPlayer.Character.Humanoid.JumpPower = s
end)

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local camera = workspace.CurrentCamera

-- create once
local bv, bg
local loop, inputBegan, inputEnded
local keys = {W=false, A=false, S=false, D=false}
local flying = false

local function getChar()
    local char = player.Character or player.CharacterAdded:Wait()
    return char, char:WaitForChild("HumanoidRootPart")
end

local function stopFly()
    flying = false

    if loop then loop:Disconnect(); loop = nil end
    if inputBegan then inputBegan:Disconnect(); inputBegan = nil end
    if inputEnded then inputEnded:Disconnect(); inputEnded = nil end

    if bv then bv:Destroy(); bv = nil end
    if bg then bg:Destroy(); bg = nil end

    local _, hrp = getChar()
    hrp.AssemblyLinearVelocity = Vector3.zero
    hrp.AssemblyAngularVelocity = Vector3.zero
end

PlayersSection1:NewToggle("fly", "wasd fly thingy", function(state)

    local char, hrp = getChar()

    if state then
        stopFly()
        flying = true

        bv = Instance.new("BodyVelocity")
        bv.MaxForce = Vector3.new(1e9, 1e9, 1e9)
        bv.Velocity = Vector3.zero
        bv.Parent = hrp

        bg = Instance.new("BodyGyro")
        bg.MaxTorque = Vector3.new(1e9, 1e9, 1e9)
        bg.CFrame = hrp.CFrame
        bg.Parent = hrp

        inputBegan = UserInputService.InputBegan:Connect(function(input, gp)
            if gp then return end
            local k = input.KeyCode.Name
            if keys[k] ~= nil then keys[k] = true end
        end)

        inputEnded = UserInputService.InputEnded:Connect(function(input)
            local k = input.KeyCode.Name
            if keys[k] ~= nil then keys[k] = false end
        end)

        loop = RunService.RenderStepped:Connect(function()
            if not flying or not hrp.Parent then return end

            local cf = camera.CFrame
            local move = Vector3.zero

            if keys.W then move += cf.LookVector end
            if keys.S then move -= cf.LookVector end
            if keys.D then move += cf.RightVector end
            if keys.A then move -= cf.RightVector end

            bg.CFrame = cf

            if move.Magnitude > 0 then
                bv.Velocity = move.Unit * 60
            else
                bv.Velocity = Vector3.zero
            end
        end)

    else
        stopFly()
    end
end)

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local loop

PlayersSection1:NewToggle("noclip", "walk through walls", function(state)

    local function setCollide(value)
        local char = player.Character
        if not char then return end

        for _, v in ipairs(char:GetDescendants()) do
            if v:IsA("BasePart") then
                v.CanCollide = value
            end
        end
    end

    if state then
        loop = RunService.Stepped:Connect(function()
            setCollide(false)
        end)
    else
        if loop then
            loop:Disconnect()
            loop = nil
        end

        -- force restore for a short time to override physics reset
        for _ = 1, 10 do
            setCollide(true)
            task.wait(0.05)
        end
    end
end)

-- Farms

local FarmsSection1 = Farms:NewSection("farms")

_G.CoinFarm = _G.CoinFarm or {
    Enabled = false,
    Tween = nil,
    Farming = false,
    Count = 0,
    Visited = {}
}

FarmsSection1:NewToggle("coin autofarm", "Autofarms coins.", function(state)
    local Data = _G.CoinFarm
    Data.Enabled = state

    if not state then
        if Data.Tween then
            Data.Tween:Cancel()
            Data.Tween = nil
        end

        Data.Farming = false
        table.clear(Data.Visited)
        return
    end

    if Data.Farming then
        return
    end

    Data.Farming = true

    task.spawn(function()
        while Data.Enabled do
            local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
            local hrp = character:WaitForChild("HumanoidRootPart")

            -- Find the nearest unvisited coin
            local closestObj
            local closestPart
            local closestDistance = math.huge

            for _, obj in ipairs(workspace:GetDescendants()) do
                if obj.Name == "Coin_Server" and not Data.Visited[obj] then
                    local part

                    if obj:IsA("BasePart") then
                        part = obj
                    elseif obj:IsA("Model") then
                        part = obj.PrimaryPart or obj:FindFirstChildWhichIsA("BasePart")
                    end

                    if part and part.Parent then
                        local dist = (hrp.Position - part.Position).Magnitude

                        if dist < closestDistance then
                            closestDistance = dist
                            closestObj = obj
                            closestPart = part
                        end
                    end
                end
            end

            -- All coins visited, reset the visited list
            if not closestPart then
                table.clear(Data.Visited)
                task.wait(0.1)
                continue
            end

            Data.Visited[closestObj] = true

            local speed = 20
            local tweenTime = closestDistance / speed

            Data.Tween = TweenService:Create(
                hrp,
                TweenInfo.new(tweenTime, Enum.EasingStyle.Linear),
                {
                    CFrame = closestPart.CFrame + Vector3.new(0, 3, 0)
                }
            )

            Data.Tween:Play()
            Data.Tween.Completed:Wait()
            Data.Tween = nil

            Data.Count += 1

            if Data.Count >= 50 then
                Data.Count = 0

                if Data.Tween then
                    Data.Tween:Cancel()
                    Data.Tween = nil
                end

                hrp.CFrame = CFrame.new(0, 500, 0)

                local platform = workspace:FindFirstChild("CoinFarmPlatform")

                if not platform then
                    platform = Instance.new("Part")
                    platform.Name = "CoinFarmPlatform"
                    platform.Size = Vector3.new(30, 1, 30)
                    platform.Anchored = true
                    platform.CanCollide = true
                    platform.Parent = workspace
                end

                platform.CFrame = CFrame.new(0, 497, 0)

                -- Stop farming after 50 coins
                Data.Enabled = false
                Data.Farming = false
                break
            end

            task.wait()
        end

        Data.Farming = false
    end)
end)
