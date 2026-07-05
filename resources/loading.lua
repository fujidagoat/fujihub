local TweenService = game:GetService("TweenService")
local player = game.Players.LocalPlayer

local Theme = {
    SchemeColor = Color3.fromRGB(80, 140, 255),
    Background = Color3.fromRGB(12, 16, 24),
    TextColor = Color3.fromRGB(235, 240, 255),
}

local gui = Instance.new("ScreenGui")
gui.Name = "LoadingUI"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.Parent = game.CoreGui

-- Overlay
local overlay = Instance.new("Frame")
overlay.Size = UDim2.new(1, 0, 1, 0)
overlay.BackgroundColor3 = Color3.fromRGB(25, 25, 28)
overlay.BackgroundTransparency = 1
overlay.Parent = gui

-- Text
local text = Instance.new("TextLabel")
text.Size = UDim2.new(0, 200, 0, 50)
text.Position = UDim2.new(0.5, 0, 0.5, -15)
text.AnchorPoint = Vector2.new(0.5, 0.5)
text.BackgroundTransparency = 1
text.Text = "Loading"
text.TextColor3 = Theme.TextColor
text.TextTransparency = 1
text.Font = Enum.Font.GothamSemibold
text.TextSize = 24
text.Parent = overlay

-- Dot container
local dotContainer = Instance.new("Frame")
dotContainer.Size = UDim2.new(0, 60, 0, 20)
dotContainer.Position = UDim2.new(0.5, 0, 0.5, 25)
dotContainer.AnchorPoint = Vector2.new(0.5, 0.5)
dotContainer.BackgroundTransparency = 1
dotContainer.Parent = overlay

local function createDot(xOffset)
    local dot = Instance.new("Frame")
    dot.Size = UDim2.new(0, 10, 0, 10)
    dot.Position = UDim2.new(0, xOffset, 0.5, 0)
    dot.AnchorPoint = Vector2.new(0.5, 0.5)
    dot.BackgroundColor3 = Theme.SchemeColor
    dot.BackgroundTransparency = 1
    dot.Parent = dotContainer

    Instance.new("UICorner", dot).CornerRadius = UDim.new(1, 0)

    return dot
end

local dots = {
    createDot(15),
    createDot(30),
    createDot(45),
}

-- Tween helpers
local fadeIn = TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
local fadeOut = TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.In)
local pulseInfo = TweenInfo.new(0.45, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)

local function pulse(dot, delayTime)
    task.spawn(function()
        task.wait(delayTime)
        while dot.Parent do
            local up = TweenService:Create(dot, pulseInfo, {
                Size = UDim2.new(0, 14, 0, 14),
                BackgroundTransparency = 0
            })

            local down = TweenService:Create(dot, pulseInfo, {
                Size = UDim2.new(0, 10, 0, 10),
                BackgroundTransparency = 0.4
            })

            up:Play()
            up.Completed:Wait()
            down:Play()
            down.Completed:Wait()
        end
    end)
end

local function play()
    TweenService:Create(overlay, fadeIn, {BackgroundTransparency = 0}):Play()
    TweenService:Create(text, fadeIn, {TextTransparency = 0}):Play()

    for i, dot in ipairs(dots) do
        TweenService:Create(dot, fadeIn, {BackgroundTransparency = 0.4}):Play()
        pulse(dot, i * 0.12)
    end

    task.wait(1)

    for _, dot in ipairs(dots) do
        TweenService:Create(dot, fadeOut, {BackgroundTransparency = 1}):Play()
    end

    TweenService:Create(overlay, fadeOut, {BackgroundTransparency = 1}):Play()
    TweenService:Create(text, fadeOut, {TextTransparency = 1}):Play()

    task.wait(0.3)
    gui:Destroy()
end

play()
