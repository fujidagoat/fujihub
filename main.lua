--// Fuji1k🐬 Key System
--// LocalScript (StarterPlayerScripts)

local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")

local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

--------------------------------------------------
-- SETTINGS
--------------------------------------------------

local CORRECT_KEY = "fuji1k"

local Theme = {
	SchemeColor = Color3.fromRGB(80, 140, 255),
	Background = Color3.fromRGB(12, 16, 24),
	Header = Color3.fromRGB(18, 24, 36),
	TextColor = Color3.fromRGB(235, 240, 255),
	ElementColor = Color3.fromRGB(22, 30, 46)
}

--------------------------------------------------
-- GUI
--------------------------------------------------

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "Fuji1kKeySystem"
ScreenGui.ResetOnSpawn = false
ScreenGui.IgnoreGuiInset = true
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = game.CoreGui

local Overlay = Instance.new("Frame")
Overlay.Size = UDim2.fromScale(1,1)
Overlay.BackgroundColor3 = Color3.new(0,0,0)
Overlay.BackgroundTransparency = 1
Overlay.BorderSizePixel = 0
Overlay.Parent = ScreenGui

local Main = Instance.new("Frame")
Main.Name = "Main"
Main.Size = UDim2.fromOffset(340,190)
Main.AnchorPoint = Vector2.new(0.5,0.5)
Main.Position = UDim2.fromScale(0.5,0.5)
Main.BackgroundColor3 = Theme.Background
Main.BorderSizePixel = 0
Main.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0,12)
MainCorner.Parent = Main

local Stroke = Instance.new("UIStroke")
Stroke.Color = Theme.SchemeColor
Stroke.Thickness = 1.5
Stroke.Transparency = 1
Stroke.Parent = Main

local UIScale = Instance.new("UIScale")
UIScale.Scale = 0
UIScale.Parent = Main

--------------------------------------------------
-- HEADER
--------------------------------------------------

local Header = Instance.new("Frame")
Header.Size = UDim2.new(1,0,0,45)
Header.BackgroundColor3 = Theme.Header
Header.BorderSizePixel = 0
Header.Parent = Main

local HeaderCorner = Instance.new("UICorner")
HeaderCorner.CornerRadius = UDim.new(0,12)
HeaderCorner.Parent = Header

local HeaderFix = Instance.new("Frame")
HeaderFix.Size = UDim2.new(1,0,0.5,0)
HeaderFix.Position = UDim2.new(0,0,0.5,0)
HeaderFix.BackgroundColor3 = Theme.Header
HeaderFix.BorderSizePixel = 0
HeaderFix.Parent = Header

local Title = Instance.new("TextLabel")
Title.Size = UDim2.fromScale(1,1)
Title.BackgroundTransparency = 1
Title.Text = "Fuji1k🐬"
Title.TextColor3 = Theme.TextColor
Title.Font = Enum.Font.GothamBold
Title.TextSize = 20
Title.Parent = Header

--------------------------------------------------
-- KEY BOX
--------------------------------------------------

local KeyBox = Instance.new("TextBox")
KeyBox.Size = UDim2.new(0.86,0,0,42)
KeyBox.AnchorPoint = Vector2.new(0.5,0)
KeyBox.Position = UDim2.new(0.5,0,0.34,0)
KeyBox.BackgroundColor3 = Theme.ElementColor
KeyBox.BorderSizePixel = 0
KeyBox.PlaceholderText = "Enter Key..."
KeyBox.Text = ""
KeyBox.TextColor3 = Theme.TextColor
KeyBox.PlaceholderColor3 = Color3.fromRGB(140,150,170)
KeyBox.Font = Enum.Font.Gotham
KeyBox.TextSize = 16
KeyBox.Parent = Main

local BoxCorner = Instance.new("UICorner")
BoxCorner.CornerRadius = UDim.new(0,8)
BoxCorner.Parent = KeyBox

--------------------------------------------------
-- BUTTON
--------------------------------------------------

local Submit = Instance.new("TextButton")
Submit.Size = UDim2.new(0.86,0,0,40)
Submit.AnchorPoint = Vector2.new(0.5,0)
Submit.Position = UDim2.new(0.5,0,0.66,0)
Submit.BackgroundColor3 = Theme.SchemeColor
Submit.BorderSizePixel = 0
Submit.Text = "Submit"
Submit.TextColor3 = Theme.TextColor
Submit.Font = Enum.Font.GothamBold
Submit.TextSize = 17
Submit.AutoButtonColor = false
Submit.Parent = Main

local ButtonCorner = Instance.new("UICorner")
ButtonCorner.CornerRadius = UDim.new(0,8)
ButtonCorner.Parent = Submit

--------------------------------------------------
-- OPEN ANIMATION
--------------------------------------------------

TweenService:Create(
	Overlay,
	TweenInfo.new(0.3),
	{BackgroundTransparency = 0.35}
):Play()

TweenService:Create(
	UIScale,
	TweenInfo.new(0.45, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
	{Scale = 1}
):Play()

TweenService:Create(
	Stroke,
	TweenInfo.new(0.35),
	{Transparency = 0.2}
):Play()

--------------------------------------------------
-- DRAGGING
--------------------------------------------------

local Dragging = false
local DragStart
local StartPos

Header.InputBegan:Connect(function(Input)
	if Input.UserInputType == Enum.UserInputType.MouseButton1 then
		Dragging = true
		DragStart = Input.Position
		StartPos = Main.Position

		Input.Changed:Connect(function()
			if Input.UserInputState == Enum.UserInputState.End then
				Dragging = false
			end
		end)
	end
end)

UserInputService.InputChanged:Connect(function(Input)
	if Dragging and Input.UserInputType == Enum.UserInputType.MouseMovement then
		local Delta = Input.Position - DragStart

		Main.Position = UDim2.new(
			StartPos.X.Scale,
			StartPos.X.Offset + Delta.X,
			StartPos.Y.Scale,
			StartPos.Y.Offset + Delta.Y
		)
	end
end)

--------------------------------------------------
-- HOVER EFFECTS
--------------------------------------------------

Submit.MouseEnter:Connect(function()
	TweenService:Create(
		Submit,
		TweenInfo.new(0.15),
		{
			BackgroundColor3 = Theme.SchemeColor:Lerp(Color3.new(1,1,1),0.12)
		}
	):Play()
end)

Submit.MouseLeave:Connect(function()
	TweenService:Create(
		Submit,
		TweenInfo.new(0.15),
		{
			BackgroundColor3 = Theme.SchemeColor
		}
	):Play()
end)

--------------------------------------------------
-- SHAKE ANIMATION
--------------------------------------------------

local function Shake()
	local Original = Main.Position

	for _ = 1,8 do
		TweenService:Create(
			Main,
			TweenInfo.new(0.03),
			{
				Position = Original + UDim2.fromOffset(math.random(-8,8),0)
			}
		):Play()

		task.wait(0.03)
	end

	Main.Position = Original
end

--------------------------------------------------
-- CLOSE ANIMATION
--------------------------------------------------

local function CloseUI()

	local FadeObjects = {
		Main,
		Header,
		HeaderFix,
		KeyBox,
		Submit
	}

	for _,Obj in ipairs(FadeObjects) do
		if Obj:IsA("Frame") or Obj:IsA("TextBox") or Obj:IsA("TextButton") then
			TweenService:Create(
				Obj,
				TweenInfo.new(0.35),
				{
					BackgroundTransparency = 1
				}
			):Play()
		end
	end

	TweenService:Create(
		Title,
		TweenInfo.new(0.35),
		{
			TextTransparency = 1
		}
	):Play()

	TweenService:Create(
		KeyBox,
		TweenInfo.new(0.35),
		{
			TextTransparency = 1
		}
	):Play()

	TweenService:Create(
		Submit,
		TweenInfo.new(0.35),
		{
			TextTransparency = 1
		}
	):Play()

	TweenService:Create(
		Stroke,
		TweenInfo.new(0.35),
		{
			Transparency = 1
		}
	):Play()

	TweenService:Create(
		UIScale,
		TweenInfo.new(0.35, Enum.EasingStyle.Back, Enum.EasingDirection.In),
		{
			Scale = 0.85
		}
	):Play()

	TweenService:Create(
		Overlay,
		TweenInfo.new(0.35),
		{
			BackgroundTransparency = 1
		}
	):Play()

	task.wait(0.4)

	ScreenGui:Destroy()
end

--------------------------------------------------
-- BUTTON CLICK
--------------------------------------------------

Submit.MouseButton1Down:Connect(function()
	TweenService:Create(
		Submit,
		TweenInfo.new(0.08),
		{
			Size = UDim2.new(0.84,0,0,38)
		}
	):Play()
end)

Submit.MouseButton1Up:Connect(function()
	TweenService:Create(
		Submit,
		TweenInfo.new(0.08),
		{
			Size = UDim2.new(0.86,0,0,40)
		}
	):Play()
end)

--------------------------------------------------
-- KEY CHECK
--------------------------------------------------

Submit.MouseButton1Click:Connect(function()

	if KeyBox.Text == CORRECT_KEY then

		Submit.Text = "Access Granted"
		Submit.BackgroundColor3 = Color3.fromRGB(70,200,120)

		TweenService:Create(
			UIScale,
			TweenInfo.new(0.2),
			{
				Scale = 1.03
			}
		):Play()

		task.wait(0.6)

		CloseUI()

		loadstring(game:HttpGet("https://raw.githubusercontent.com/fujidagoat/fujihub/refs/heads/main/resources/bootstrapper.lua"))()

	else

		local Original = Submit.BackgroundColor3

		Submit.Text = "Invalid Key"
		Submit.BackgroundColor3 = Color3.fromRGB(220,70,70)

		Shake()

		task.wait(1)

		Submit.Text = "Submit"
		Submit.BackgroundColor3 = Original
	end
end)
