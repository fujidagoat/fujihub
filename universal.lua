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

local Home = Window:NewTab("Home")
local Player = Window:NewTab("Player")
local Visuals = Window:NewTab("Visuals")
local Aiming = Window:NewTab("Aiming")
local Trolling = Window:NewTab("Trolling")
local Extra = Window:NewTab("Extra")

-- Home

local HomeSection1 = Home:NewSection("Home")

local MarketplaceService = game:GetService("MarketplaceService")
local GameInfo = MarketplaceService:GetProductInfo(game.PlaceId)

local GameInfoButton = HomeSection1:NewButton("Game Name: " .. GameInfo.Name, "The games name.", function()
    toClipboard(gameInfo.Name)
end)

local PlayersAmountButton = HomeSection1:NewButton("Players In Server: " .. #game.Players:GetPlayers(), "The amount of players in game.", function()
    toClipboard(#game.Players:GetPlayers())
end)

game.Players.PlayerAdded:Connect(function()
	PlayersAmountButton:UpdateButton("Players In Server: " .. #game.Players:GetPlayers())
end)

game.Players.PlayerRemoving:Connect(function()
	PlayersAmountButton:UpdateButton("Players In Server: " .. #game.Players:GetPlayers())
end)

HomeSection1:NewButton("PlaceId: " .. game.PlaceId, "The game's PlaceId.", function()
    toClipboard(game.PlaceId)
end)

HomeSection1:NewButton("JobId: " .. game.JobId, "the game's JobId.", function()
    toClipboard(game.JobId)
end)

HomeSection1:NewKeybind("Toggle UI", "Key to toggle the UI.", Enum.KeyCode.Semicolon, function()
	Library:ToggleUI()
end)

-- Player

local PlayerSection1 = Player:NewSection("Player")

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local wsValue = 16
local jpValue = 50

local function apply()
    local char = player.Character
    if not char then return end
    local hum = char:FindFirstChildOfClass("Humanoid")
    if not hum then return end

    hum.WalkSpeed = wsValue
    hum.JumpPower = jpValue
end

PlayerSection1:NewSlider("Walkspeed (Loop)", "Determines your Walkspeed.", 100, 16, function(s)
    wsValue = s
end)

PlayerSection1:NewSlider("JumpPower (Loop)", "Determines your JumpPower", 500, 50, function(s)
    jpValue = s
end)

player.CharacterAdded:Connect(function()
    task.wait(0.5)
    apply()
end)

RunService.Heartbeat:Connect(function()
    apply()
end)

PlayerSection1:NewSlider("HipHeight", "How much studs your character is from the ground.", 0, 1000, function(s)
    game.Players.LocalPlayer.Character.Humanoid.HipHeight = s
end)

PlayerSection1:NewButton("Reset HipHeight (R6)", "Reset's hipheight to the R6 default.", function()
       game.Players.LocalPlayer.Character.Humanoid.HipHeight = 0
end)

PlayerSection1:NewButton("Reset HipHeight (R15)", "Reset's hipheight to the R15 default.", function()
       game.Players.LocalPlayer.Character.Humanoid.HipHeight = 2
end)

local InfiniteJumpEnabled = false
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")

local Player = Players.LocalPlayer

UserInputService.JumpRequest:Connect(function()
    if InfiniteJumpEnabled then
        local Character = Player.Character
        if Character then
            local Humanoid = Character:FindFirstChildOfClass("Humanoid")
            if Humanoid then
                Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
            end
        end
    end
end)

PlayerSection1:NewToggle("Infinite Jump", "Allows you to jump infinitely", function(state)
    InfiniteJumpEnabled = state

    if state then
        print("Infinite Jump On")
    else
        print("Infinite Jump Off")
    end
end)

PlayerSection1:NewToggle("Low Gravity", "Toggles low gravity.", function(state)
    if state then
        workspace.Gravity = 100
    else
        workspace.Gravity = 196.2
    end
end)

PlayerSection1:NewButton("Anti-Fling", "Toggle: antion/antioff", function()
	--[[
Fedoratum Anti Fling V2
This script is designed to beat that anti fling, this script can fling people while on anti fling which is the most advantage you can take.
This will never be erroring like that free anti fling.
--]]

-- Instances

local plr = game:GetService("Players").LocalPlayer
local plrs = game:GetService("Players")
local char
local chares
local bozo = plr.Character or plr.CharacterAdded:Wait()
local hrp = bozo:WaitForChild("HumanoidRootPart", math.huge) or bozo.HumanoidRootPart
local XPart = Instance.new("Part", game.Workspace)
local hume
local hrpo
local hrpl
XPart.Position = hrp.Position + Vector3.new(0,2,0)
local rs = game:GetService("RunService")
XPart.Anchored = true
XPart.CanCollide = false
XPart.Transparency = 0.5
local GUI = Instance.new("BillboardGui", XPart)
GUI.Size = UDim2.new(4, 0, 2, 0)
GUI.StudsOffsetWorldSpace = Vector3.new(0,1.5,0)
local TextLabel = Instance.new("TextLabel", GUI)
TextLabel.Text = "Anti Fling Part"
TextLabel.Size = UDim2.new(1,0,1,0)
TextLabel.BackgroundTransparency = 1
TextLabel.Font = "AmaticSC"
TextLabel.TextScaled = true

local running = true

-- Update Part

local function UpdatePart()
if running then
pcall(function()
char = plr.Character or plr.CharacterAdded:Wait()
hrpl =  char.HumanoidRootPart
if Update then
XPart.Position = hrpl.Position + Vector3.new(0,2,0)
XPart.CFrame = CFrame.lookAt(XPart.Position, XPart.Position + hrpl.CFrame.LookVector)
end
end)
end
end

-- Fling detection

rs.RenderStepped:Connect(function()
if running then
pcall(function()
chares = plr.Character or plr.CharacterAdded:Wait()
hrpo = chares.HumanoidRootPart
hume = chares.Humanoid
if chares and hrpo then
if hrpo.Velocity.Magnitude > 100 then
hume:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, false)
hume:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)
Update = false
for i,v in ipairs(chares:GetDescendants()) do
if v:IsA("BasePart") then
v.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
vAssemblyLinearVelocity = Vector3.new(0, 0, 0)
v.CustomPhysicalProperties = PhysicalProperties.new(0, 0, 0)
     end
  end
for _, v in pairs(plrs:GetPlayers()) do
if v ~= plr then
local c = v.Character
if c and c.Parent then
for _, v1 in pairs(c:GetDescendants()) do
if v1:IsA("BasePart") then
v1.Velocity = Vector3.new(0,0,0)
v1.RotVelocity = Vector3.new(0,0,0)
	 end
	end
	end
end
end
hrpo.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
hrpo.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
hrpo.CustomPhysicalProperties = PhysicalProperties.new(0, 0, 0)
hrpo.CFrame = XPart.CFrame
else
hume:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, false)
hume:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)
Update = true
hrpo.CustomPhysicalProperties = PhysicalProperties.new(0.7, 0.3, 0.5)
for i,v in ipairs(chares:GetDescendants()) do
if v:IsA("BasePart") then
v.CustomPhysicalProperties = PhysicalProperties.new(0.7, 0.3, 0.5)
 end
 end
end
end
end)
end
end)

spawn(function()
while wait(0.3) do
UpdatePart()
end
end)

-- Notif and msg detection


local nif = Instance.new("Sound")
nif.Parent = game:GetService("SoundService")
nif.SoundId = "rbxassetid://9086208751"
nif.Volume = 1

local function Nifs(text)
game:GetService("StarterGui"):SetCore("SendNotification",{
["Title"] = "(//Fedoratum Anti Fling//)",
["Text"] = text,
["Duration"] = 4
})
nif:Play()
end

plr.Chatted:Connect(function(m)
if m:sub(1, 7) == "antioff" then
Nifs("Anti Fling is Off")
running = false
elseif m:sub(1, 6) == "antion" then
Nifs("Anti Fling is On")
running = true
end
end)

Nifs("Fedoratum Anti Fling Has Loaded.")
Nifs("Type antioff or antioff to toggle Anti Fling")
end)

PlayerSection1:NewToggle("CFrame Fly", "Toggles CFrame-based flight.", function(state)
    local player = game.Players.LocalPlayer
    local char = player.Character
    local root = char and char:FindFirstChild("HumanoidRootPart")

    if not root then return end

    if state then
        -- Create flight movers
        local bv = Instance.new("BodyVelocity")
        bv.MaxForce = Vector3.new(1e6, 1e6, 1e6)
        bv.Velocity = Vector3.zero
        bv.Parent = root

        local bg = Instance.new("BodyGyro")
        bg.MaxTorque = Vector3.new(1e6, 1e6, 1e6)
        bg.CFrame = root.CFrame
        bg.Parent = root

        -- Movement loop
        flyConnection = game:GetService("RunService").RenderStepped:Connect(function()
            local cam = workspace.CurrentCamera
            local move = Vector3.zero

            if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.W) then
                move = move + cam.CFrame.LookVector
            end
            if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.S) then
                move = move - cam.CFrame.LookVector
            end
            if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.A) then
                move = move - cam.CFrame.RightVector
            end
            if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.D) then
                move = move + cam.CFrame.RightVector
            end

            bv.Velocity = move * 60
            bg.CFrame = cam.CFrame
        end)

    else
        -- Disable flight
        if flyConnection then
            flyConnection:Disconnect()
            flyConnection = nil
        end

        if root:FindFirstChild("BodyVelocity") then
            root.BodyVelocity:Destroy()
        end
        if root:FindFirstChild("BodyGyro") then
            root.BodyGyro:Destroy()
        end
    end
end)

local RunService = game:GetService("RunService")
local noclipConnection

PlayerSection1:NewToggle("Noclip", "Toggles noclip (no collisions).", function(state)
    local player = game.Players.LocalPlayer
    local char = player.Character

    if not char then return end

    if state then
        -- Start noclip loop
        noclipConnection = RunService.Stepped:Connect(function()
            for _, part in ipairs(char:GetDescendants()) do
                if part:IsA("BasePart") and part.CanCollide then
                    part.CanCollide = false
                end
            end
        end)
    else
        -- Stop noclip loop
        if noclipConnection then
            noclipConnection:Disconnect()
            noclipConnection = nil
        end

        -- Restore collisions
        for _, part in ipairs(char:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = true
            end
        end
    end
end)


local runService = game:GetService("RunService")
local xrayConnection

PlayerSection1:NewToggle("X-Ray", "See through nearby walls with distance fade.", function(state)
    local player = game.Players.LocalPlayer
    local char = player.Character
    local root = char and char:FindFirstChild("HumanoidRootPart")

    if not root then return end

    -- Settings
    local maxDistance = 40        -- Distance where transparency becomes 0
    local minDistance = 5         -- Distance where transparency becomes 0.8
    local maxTransparency = 0.8   -- Closest transparency
    local minTransparency = 0     -- Farthest transparency

    if state then
        -- Avoid multiple connections
        if xrayConnection then xrayConnection:Disconnect() end

        xrayConnection = runService.RenderStepped:Connect(function()
            for _, part in ipairs(workspace:GetDescendants()) do
                if part:IsA("BasePart") and part.CanCollide and not part:IsDescendantOf(char) then
                    local dist = (part.Position - root.Position).Magnitude

                    if dist <= maxDistance then
                        local alpha = math.clamp((dist - minDistance) / (maxDistance - minDistance), 0, 1)
                        local transparency = minTransparency + (maxTransparency - minTransparency) * (1 - alpha)
                        part.LocalTransparencyModifier = transparency
                    else
                        part.LocalTransparencyModifier = 0
                    end
                end
            end
        end)
    else
        -- Turn off x-ray
        if xrayConnection then
            xrayConnection:Disconnect()
            xrayConnection = nil
        end

        -- Reset transparency modifiers
        for _, part in ipairs(workspace:GetDescendants()) do
            if part:IsA("BasePart") then
                part.LocalTransparencyModifier = 0
            end
        end
    end
end)

-- Visuals

local VisualsSection1 = Visuals:NewSection("ESP")

local Players = game:GetService("Players")

local espEnabled = false
local showName = true
local showDisplayName = true
local showHealth = true

local espFolder = Instance.new("Folder")
espFolder.Name = "ESP_Objects"
espFolder.Parent = workspace

local espData = {}

local function getText(player, humanoid)
    local text = ""

    if showName then
        text ..= player.Name .. " "
    end

    if showDisplayName then
        text ..= "(" .. player.DisplayName .. ") "
    end

    if showHealth and humanoid then
        text ..= "HP: " .. math.floor(humanoid.Health)
    end

    return text
end

local function updateLabel(player)
    local data = espData[player]
    if not data then return end

    local char = player.Character
    if not char then return end

    local humanoid = char:FindFirstChildOfClass("Humanoid")
    if not humanoid then return end

    data.label.Text = getText(player, humanoid)
end

local function createESP(player)
    if player == Players.LocalPlayer then return end
    if espData[player] then return end

    local char = player.Character
    if not char then return end

    local head = char:FindFirstChild("Head")
    local humanoid = char:FindFirstChildOfClass("Humanoid")
    if not head or not humanoid then return end

    local highlight = Instance.new("Highlight")
    highlight.FillColor = Color3.fromRGB(255, 0, 0)
    highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
    highlight.FillTransparency = 0.5
    highlight.Adornee = char
    highlight.Parent = espFolder

    local bill = Instance.new("BillboardGui")
    bill.Size = UDim2.new(0, 200, 0, 50)
    bill.Adornee = head
    bill.AlwaysOnTop = true
    bill.Parent = espFolder

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, 0, 1, 0)
    label.BackgroundTransparency = 1
    label.TextColor3 = Color3.new(1, 1, 1)
    label.TextStrokeTransparency = 0.5
    label.Font = Enum.Font.SourceSansBold
    label.TextScaled = true
    label.Parent = bill

    espData[player] = {
        highlight = highlight,
        billboard = bill,
        label = label,
        connections = {}
    }

    -- initial text
    updateLabel(player)

    -- update on health change (IMPORTANT FIX)
    table.insert(espData[player].connections,
        humanoid.HealthChanged:Connect(function()
            updateLabel(player)
        end)
    )

    -- update on respawn / character swap
    table.insert(espData[player].connections,
        player.CharacterAdded:Connect(function()
            task.wait(0.2)
            removeESP(player)
            if espEnabled then
                createESP(player)
            end
        end)
    )
end

function removeESP(player)
    local data = espData[player]
    if not data then return end

    for _, c in ipairs(data.connections) do
        pcall(function()
            c:Disconnect()
        end)
    end

    if data.highlight then data.highlight:Destroy() end
    if data.billboard then data.billboard:Destroy() end

    espData[player] = nil
end

local function enableESP()
    espEnabled = true

    for _, p in ipairs(Players:GetPlayers()) do
        createESP(p)
    end

    Players.PlayerAdded:Connect(function(p)
        if espEnabled then
            p.CharacterAdded:Connect(function()
                task.wait(0.2)
                createESP(p)
            end)
        end
    end)

    Players.PlayerRemoving:Connect(removeESP)
end

local function disableESP()
    espEnabled = false

    for _, p in ipairs(Players:GetPlayers()) do
        removeESP(p)
    end
end

local function toggleESP(state)
    if state then
        enableESP()
    else
        disableESP()
    end
end

-- UI
VisualsSection1:NewToggle("Player ESP", "Highlights players + info", toggleESP)

VisualsSection1:NewToggle("Show Name", "", function(v)
    showName = v
    for p in pairs(espData) do updateLabel(p) end
end)

VisualsSection1:NewToggle("Show DisplayName", "", function(v)
    showDisplayName = v
    for p in pairs(espData) do updateLabel(p) end
end)

VisualsSection1:NewToggle("Show Health", "", function(v)
    showHealth = v
    for p in pairs(espData) do updateLabel(p) end
end)

local VisualsSection2 = Visuals:NewSection("Lighting")

VisualsSection2:NewToggle("Fullbright", "Makes the game more visible.", function(state)
    local lighting = game:GetService("Lighting")

    if state then
        -- Save old settings
        if not lighting:FindFirstChild("FullBrightSettings") then
            local folder = Instance.new("Folder")
            folder.Name = "FullBrightSettings"
            folder.Parent = lighting

            local brightness = Instance.new("NumberValue")
            brightness.Name = "Brightness"
            brightness.Value = lighting.Brightness
            brightness.Parent = folder

            local ambient = Instance.new("Color3Value")
            ambient.Name = "Ambient"
            ambient.Value = lighting.Ambient
            ambient.Parent = folder

            local outdoor = Instance.new("Color3Value")
            outdoor.Name = "OutdoorAmbient"
            outdoor.Value = lighting.OutdoorAmbient
            outdoor.Parent = folder
        end

        -- Apply fullbright
        lighting.Brightness = 2
        lighting.Ambient = Color3.new(1, 1, 1)
        lighting.OutdoorAmbient = Color3.new(1, 1, 1)

    else
        -- Restore old settings
        local folder = lighting:FindFirstChild("FullBrightSettings")
        if folder then
            lighting.Brightness = folder.Brightness.Value
            lighting.Ambient = folder.Ambient.Value
            lighting.OutdoorAmbient = folder.OutdoorAmbient.Value
            folder:Destroy()
        end
    end
end)

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local enabled = false
local boxes = {}

local function addBox(char)
    if not char then return end

    for _, part in ipairs(char:GetDescendants()) do
        if part:IsA("BasePart") then
            local box = Instance.new("SelectionBox")
            box.Adornee = part
            box.LineThickness = 0.05
            box.Color3 = Color3.fromRGB(255, 0, 0)
            box.Parent = part
            boxes[part] = box
        end
    end
end

local function removeBoxes()
    for part, box in pairs(boxes) do
        if box then
            box:Destroy()
        end
    end
    table.clear(boxes)
end

local function enable()
    for _, player in ipairs(Players:GetPlayers()) do
        if player.Character then
            addBox(player.Character)
        end
        player.CharacterAdded:Connect(function(char)
            if enabled then
                task.wait(0.1)
                addBox(char)
            end
        end)
    end
end

VisualsSection1:NewToggle("Show Hitboxes", "Visualizes player hitboxes", function(state)
    enabled = state

    if state then
        enable()
        print("Hitboxes On")
    else
        removeBoxes()
        print("Hitboxes Off")
    end
end)

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local camera = workspace.CurrentCamera

local lockOn = false
local enabled = false
local target = nil

local MAX_DISTANCE = 120

local function getRoot(char)
	return char and char:FindFirstChild("HumanoidRootPart")
end

local function isValid(char)
	local hum = char and char:FindFirstChildOfClass("Humanoid")
	return hum and hum.Health > 0
end

local function getNearestTarget()
	local closest
	local closestDist = math.huge

	local myChar = player.Character
	local myRoot = getRoot(myChar)
	if not myRoot then return nil end

	for _, plr in ipairs(Players:GetPlayers()) do
		if plr ~= player and plr.Character and isValid(plr.Character) then
			local root = getRoot(plr.Character)
			if root then
				local dist = (root.Position - myRoot.Position).Magnitude
				if dist < closestDist and dist <= MAX_DISTANCE then
					closestDist = dist
					closest = plr.Character
				end
			end
		end
	end

	return closest
end

UserInputService.InputBegan:Connect(function(input, processed)
	if processed then return end
	if not enabled then return end

	if input.KeyCode == Enum.KeyCode.E then
		lockOn = not lockOn
		target = nil
	end
end)

RunService.RenderStepped:Connect(function()
	if not lockOn then return end

	if not target or not isValid(target) then
		target = getNearestTarget()
	end

	if target then
		local root = getRoot(target)
		if root then
			local camPos = camera.CFrame.Position
			local lookAt = root.Position + Vector3.new(0, 1.5, 0)

			camera.CFrame = camera.CFrame:Lerp(
				CFrame.new(camPos, lookAt),
				0.15
			)
		end
	end
end)

-- Aiming

local AimingSection1 = Aiming:NewSection("Aiming")

local AimlockCanBeEnabled = false

local AimlockToggle = AimingSection1:NewToggle("Aimlock", "Enables lock-on system", function(state)
	AimlockCanBeEnabled = state
end)

AimingSection1:NewKeybind("Aimlock Key", "The keybind to bind aimlock to.", Enum.KeyCode.E, function()
	if AimlockCanBeEnabled then
        enabled = not enabled

        if not enabled then
            lockOn = false
            target = nil
        end
    end
end)

-- Extra

local ExtraSection = Extra:NewSection("Extra")

ExtraSection:NewButton("Load IY", "Extra scr 1", function()
	loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))()
end)

ExtraSection:NewButton("Load AntiAFK", "Extra scr 2", function()
	--Roblox Anti Afk Script--
-- Made by aoki0x--
--RemiAPE On Top!--

wait(0.5)
local Main = Instance.new("ScreenGui")
local Title = Instance.new("TextLabel")
local MainFrame = Instance.new("Frame")
local EndTItle = Instance.new("TextLabel")
local AfkStatus = Instance.new("TextLabel")

Main.Parent = game.CoreGui

Main.ZIndexBehavior = Enum.ZIndexBehavior.Sibling;

Title.Parent = Main;

Title.Active = true
Title.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Title.BorderColor3 = Color3.fromRGB(0, 0, 255)
Title.Draggable = true
Title.Position = UDim2.new(0.698610067, 0, 0.098096624, 0)
Title.Size = UDim2.new(0, 370, 0, 52)
Title.Font = Enum.Font.SourceSansBold;
Title.Text = "Anti Afk | by aoki0x"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 22;

MainFrame.Parent = Title

MainFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
MainFrame.BorderColor3 = Color3.fromRGB(0, 0, 255)
MainFrame.Position = UDim2.new(0, 0, 1.0192306, 0)
MainFrame.Size = UDim2.new(0, 370, 0, 107)

EndTItle.Parent = MainFrame
EndTItle.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
EndTItle.BorderColor3 = Color3.fromRGB(0, 0, 255)
EndTItle.Position = UDim2.new(0, 0, 0.800455689, 0)
EndTItle.Size = UDim2.new(0, 370, 0, 21)
EndTItle.Font = Enum.Font.SourceSansBold;
EndTItle.Text = "RemiAPE"
EndTItle.TextColor3 = Color3.fromRGB(255, 255, 255)
EndTItle.TextSize = 20;

AfkStatus.Parent = MainFrame

AfkStatus.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
AfkStatus.BorderColor3 = Color3.fromRGB(0, 0, 255)
AfkStatus.Position = UDim2.new(0, 0, 0.158377, 0)
AfkStatus.Size = UDim2.new(0, 370, 0 ,44)
AfkStatus.Font = Enum.Font.SourceSansBold;
AfkStatus.Text = "Anti Afk Status: Active"
AfkStatus.TextColor3 = Color3.fromRGB(255, 255, 255)
AfkStatus.TextSize = 20;

local abc = game:service'VirtualUser'

game:service'Players'.LocalPlayer.Idled:connect(function()

    AfkStatus:CaptureController()
    AfkStatus:ClickButton2(Vector2.new())

    AfkStatus.Text = "Roblox Tried To Kick You."
    wait(2)
    AfkStatus.Text = "Anti Afk Status: Active"
end)
end)

-- Trolling

local TrollingSection = Trolling:NewSection("Troll Scripts")

TrollingSection:NewButton("Load OP Finality Trolling GUI", "Troll scr 1", function()
	loadstring(game:HttpGet("https://gist.githubusercontent.com/torikooo/54d50877a1388727ea9ca2fa07f3f593/raw/64971f032b6af3023305c57dba0810073a6d5a6b/OP%2520Finality%2520Trolling%2520GUI"))()
end)

TrollingSection:NewButton("Load R6 Trolling GUI", "Troll scr 2", function()
	loadstring(game:HttpGet("https://pastebin.com/raw/MX2s8q5W"))()
end)
