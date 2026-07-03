local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")
local player = game.Players.LocalPlayer

local Theme = {
    SchemeColor = Color3.fromRGB(80, 140, 255),
    Background = Color3.fromRGB(12, 16, 24),
    TextColor = Color3.fromRGB(235, 240, 255),
    ElementColor = Color3.fromRGB(22, 30, 46)
}

-- Blur effect
local blur = Instance.new("BlurEffect")
blur.Size = 0
blur.Parent = Lighting

-- GUI
local gui = Instance.new("ScreenGui")
gui.Name = "CustomNotification"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.Parent = player:WaitForChild("PlayerGui")

-- Dim background
local dim = Instance.new("Frame")
dim.Size = UDim2.new(1,0,1,0)
dim.BackgroundColor3 = Color3.new(0,0,0)
dim.BackgroundTransparency = 1
dim.Parent = gui

-- Main frame
local main = Instance.new("Frame")
main.Size = UDim2.new(0, 380, 0, 190)
main.Position = UDim2.new(0.5, 0, 0.5, 10)
main.AnchorPoint = Vector2.new(0.5, 0.5)
main.BackgroundColor3 = Theme.Background
main.BackgroundTransparency = 1
main.Parent = dim

Instance.new("UICorner", main).CornerRadius = UDim.new(0, 10)

local stroke = Instance.new("UIStroke")
stroke.Color = Theme.SchemeColor
stroke.Thickness = 1.5
stroke.Transparency = 1
stroke.Parent = main

-- Title
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -40, 0, 28)
title.Position = UDim2.new(0, 15, 0, 12)
title.BackgroundTransparency = 1
title.Text = "Game is not supported"
title.TextColor3 = Theme.TextColor
title.TextTransparency = 1
title.Font = Enum.Font.GothamSemibold
title.TextSize = 18
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = main

-- Description
local desc = Instance.new("TextLabel")
desc.Size = UDim2.new(1, -30, 0, 60)
desc.Position = UDim2.new(0, 15, 0, 45)
desc.BackgroundTransparency = 1
desc.Text = "This game is not supported by Fuji1k at the moment."
desc.TextColor3 = Color3.fromRGB(200, 205, 220)
desc.TextTransparency = 1
desc.Font = Enum.Font.Gotham
desc.TextSize = 14
desc.TextWrapped = true
desc.TextXAlignment = Enum.TextXAlignment.Left
desc.Parent = main

-- Button
local execBtn = Instance.new("TextButton")
execBtn.Size = UDim2.new(1, -30, 0, 36)
execBtn.Position = UDim2.new(0, 15, 0, 115)
execBtn.BackgroundColor3 = Theme.SchemeColor
execBtn.BackgroundTransparency = 1
execBtn.Text = "Execute Universal"
execBtn.TextColor3 = Theme.TextColor
execBtn.TextTransparency = 1
execBtn.Font = Enum.Font.GothamSemibold
execBtn.TextSize = 14
execBtn.Parent = main

Instance.new("UICorner", execBtn).CornerRadius = UDim.new(0, 8)

local btnStroke = Instance.new("UIStroke")
btnStroke.Color = Color3.fromRGB(255,255,255)
btnStroke.Transparency = 0.85
btnStroke.Parent = execBtn

-- Close button
local close = Instance.new("TextButton")
close.Size = UDim2.new(0, 26, 0, 26)
close.Position = UDim2.new(1, -34, 0, 10)
close.BackgroundColor3 = Theme.ElementColor
close.BackgroundTransparency = 1
close.Text = "×"
close.TextColor3 = Theme.TextColor
close.TextTransparency = 1
close.Font = Enum.Font.GothamBold
close.TextSize = 18
close.Parent = main

Instance.new("UICorner", close).CornerRadius = UDim.new(1, 0)

-- Tweens
local showTween = TweenInfo.new(0.35, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
local hideTween = TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.In)

local function closeUI()
    TweenService:Create(dim, hideTween, {BackgroundTransparency = 1}):Play()
    TweenService:Create(main, hideTween, {
        BackgroundTransparency = 1,
        Position = UDim2.new(0.5, 0, 0.5, 10)
    }):Play()

    TweenService:Create(stroke, hideTween, {Transparency = 1}):Play()
    TweenService:Create(title, hideTween, {TextTransparency = 1}):Play()
    TweenService:Create(desc, hideTween, {TextTransparency = 1}):Play()

    TweenService:Create(execBtn, hideTween, {
        BackgroundTransparency = 1,
        TextTransparency = 1
    }):Play()

    TweenService:Create(close, hideTween, {
        BackgroundTransparency = 1,
        TextTransparency = 1
    }):Play()

    TweenService:Create(blur, hideTween, {Size = 0}):Play()

    task.wait(0.3)
    gui:Destroy()
    blur:Destroy()
end

local function playOpen()
    TweenService:Create(dim, showTween, {BackgroundTransparency = 0.45}):Play()

    TweenService:Create(main, showTween, {
        BackgroundTransparency = 0,
        Position = UDim2.new(0.5, 0, 0.5, 0)
    }):Play()

    TweenService:Create(stroke, showTween, {Transparency = 0}):Play()
    TweenService:Create(title, showTween, {TextTransparency = 0}):Play()
    TweenService:Create(desc, showTween, {TextTransparency = 0}):Play()

    TweenService:Create(execBtn, showTween, {
        BackgroundTransparency = 0,
        TextTransparency = 0
    }):Play()

    TweenService:Create(close, showTween, {
        BackgroundTransparency = 0,
        TextTransparency = 0
    }):Play()

    TweenService:Create(blur, showTween, {Size = 20}):Play()
end

-- Button click closes UI
execBtn.MouseButton1Click:Connect(function()
	closeUI()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/fujidagoat/fujihub/refs/heads/main/resources/loading.lua"))()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/fujidagoat/fujihub/refs/heads/main/universal.lua"))()
end)

close.MouseButton1Click:Connect(closeUI)

dim.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        closeUI()
    end
end)

playOpen()
