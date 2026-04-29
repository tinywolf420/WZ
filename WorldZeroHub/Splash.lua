--====================================================
-- AAA SPLASH LOADER SYSTEM
--====================================================

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")
local CoreGui = game:GetService("CoreGui")

local player = Players.LocalPlayer

--====================================================
-- BLUR EFFECT
--====================================================
local Blur = Instance.new("BlurEffect")
Blur.Size = 0
Blur.Parent = Lighting

TweenService:Create(Blur, TweenInfo.new(1), {Size = 24}):Play()

--====================================================
-- UI ROOT
--====================================================
local Splash = Instance.new("ScreenGui")
Splash.Name = "AAA_Splash"
Splash.IgnoreGuiInset = true
Splash.ResetOnSpawn = false
Splash.Parent = CoreGui

local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(1,0,1,0)
Frame.BackgroundColor3 = Color3.fromRGB(10,10,10)
Frame.Parent = Splash

local TweenService = game:GetService("TweenService")
local Debris = game:GetService("Debris")

local DustFolder = Instance.new("Folder")
DustFolder.Name = "Dust"
DustFolder.Parent = Frame

local FogOverlay = Instance.new("Frame")
FogOverlay.Size = UDim2.new(1,0,1,0)
FogOverlay.BackgroundColor3 = Color3.fromRGB(255,255,255)
FogOverlay.BackgroundTransparency = 0.97
FogOverlay.ZIndex = 0
FogOverlay.Parent = Frame

--====================================================
-- TITLE
--====================================================
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1,0,0,80)
Title.Position = UDim2.new(0,0,0.35,0)
Title.BackgroundTransparency = 1
Title.Text = "World Zero 🚀 Hub"
Title.TextSize = 42
Title.Font = Enum.Font.GothamBold
Title.TextColor3 = Color3.fromRGB(255,255,255)
Title.Parent = Frame

local Stroke = Instance.new("UIStroke")
Stroke.Thickness = 2
Stroke.Transparency = 0.6
Stroke.Color = Color3.fromRGB(255,255,255)
Stroke.Parent = Title

--====================================================
-- LOADING TEXT
--====================================================
local Sub = Instance.new("TextLabel")
Sub.Size = UDim2.new(1,0,0,40)
Sub.Position = UDim2.new(0,0,0.45,0)
Sub.BackgroundTransparency = 1
Sub.Text = "Initializing..."
Sub.TextSize = 18
Sub.Font = Enum.Font.Gotham
Sub.TextColor3 = Color3.fromRGB(180,180,180)
Sub.Parent = Frame

--====================================================
-- PROGRESS BAR BACK
--====================================================
local BarBack = Instance.new("Frame")
BarBack.Size = UDim2.new(0.3,0,0,8)
BarBack.Position = UDim2.new(0.35,0,0.55,0)
BarBack.BackgroundColor3 = Color3.fromRGB(40,40,40)
BarBack.BorderSizePixel = 0
BarBack.Parent = Frame

-- progress fill
local BarFill = Instance.new("Frame")
BarFill.Size = UDim2.new(0,0,1,0)
BarFill.BackgroundColor3 = Color3.fromRGB(255,255,255)
BarFill.BorderSizePixel = 0
BarFill.Parent = BarBack

--====================================================
-- INTRO ANIMATION
--====================================================
Frame.BackgroundTransparency = 1
TweenService:Create(Frame, TweenInfo.new(0.6), {BackgroundTransparency = 0}):Play()

-- pulse title
task.spawn(function()
    while Splash and Splash.Parent do
        TweenService:Create(Stroke, TweenInfo.new(1), {Transparency = 0.2}):Play()
        task.wait(1)
        TweenService:Create(Stroke, TweenInfo.new(1), {Transparency = 0.7}):Play()
        task.wait(1)
    end
end)
local function LoadingStep(text, progress)
    Sub.Text = text

    TweenService:Create(BarFill, TweenInfo.new(0.4, Enum.EasingStyle.Quad), {
        Size = UDim2.new(progress, 0, 1, 0)
    }):Play()
end
local function CreateDust()
    local dot = Instance.new("Frame")

    -- more variety (looks richer)
    local size = math.random(2, 6)

    dot.Size = UDim2.new(0, size, 0, size)
    dot.Position = UDim2.new(math.random(), 0, math.random(), 0)

    -- layered opacity (more natural fog look)
    dot.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    dot.BackgroundTransparency = math.random(70, 90) / 100

    dot.BorderSizePixel = 0
    dot.ZIndex = 1
    dot.Parent = DustFolder

    -- random drift direction
    local offsetX = math.random(-120, 120)
    local offsetY = math.random(-120, 120)

    TweenService:Create(dot, TweenInfo.new(math.random(2, 5), Enum.EasingStyle.Linear), {
        Position = UDim2.new(dot.Position.X.Scale, offsetX, dot.Position.Y.Scale, offsetY),
        BackgroundTransparency = 1
    }):Play()

    Debris:AddItem(dot, 5)
end
task.spawn(function()
    while Splash and Splash.Parent do
        -- spawn MULTIPLE dust per frame cycle
        for i = 1, 3 do
            CreateDust()
        end

        task.wait(0.03) -- lower = denser (0.02 = insane)
    end
end)
task.spawn(function()
    while Splash and Splash.Parent do
        TweenService:Create(FogOverlay, TweenInfo.new(2), {
            BackgroundTransparency = 0.95
        }):Play()

        task.wait(2)

        TweenService:Create(FogOverlay, TweenInfo.new(2), {
            BackgroundTransparency = 0.98
        }):Play()

        task.wait(2)
    end
end)






TweenService:Create(Blur, TweenInfo.new(1), {Size = 0}):Play()

for i = 1, 10 do
    Frame.BackgroundTransparency = i * 0.1
    Title.TextTransparency = i * 0.1
    Sub.TextTransparency = i * 0.1
    BarBack.BackgroundTransparency = i * 0.1
    BarFill.BackgroundTransparency = i * 0.1
    task.wait(0.03)
end

Splash:Destroy()
Blur:Destroy()