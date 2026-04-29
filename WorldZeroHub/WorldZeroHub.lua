
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

--====================================================
-- SERVICES
--====================================================
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ReplicatedFirst = game:GetService("ReplicatedFirst")
local UserInputService = game:GetService("UserInputService")
local ContextActionService = game:GetService("ContextActionService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")
local CoreGui = game:GetService("CoreGui")
local HttpService = game:GetService("HttpService")
local TeleportService = game:GetService("TeleportService")
local Debris = game:GetService("Debris")
local StarterGui = game:GetService("StarterGui")
local Workspace = game:GetService("Workspace")
local VIM = game:GetService("VirtualInputManager")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()

--====================================================
-- GENV SETTINGS
--====================================================
getgenv().AutoExecHub = true
getgenv().HubLoading = false

-- Combat
getgenv().autoSkills = false
getgenv().autoMob = false
getgenv().autoMobDetect = 0.001

-- Movement
getgenv().rotateMob = false
getgenv().rotateRadius = 8

-- World
getgenv().autoCheckpoints = false
getgenv().autoChests = false
getgenv().autoSellSuggest = false

--====================================================
-- FLUENT UI LOADER
--====================================================
local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()

SaveManager:SetLibrary(Fluent)
InterfaceManager:SetLibrary(Fluent)

LoadingStep("Loading Fluent UI...", 0.2)
task.wait(1)

LoadingStep("Building Interface...", 0.4)
task.wait(1)

LoadingStep("Loading Theme...", 0.6)
task.wait(1)

LoadingStep("Proccessing Data...", 0.8)
task.wait(1)

LoadingStep("Hub Launching Now..", 1)
task.wait(1)
Fluent:Notify({
    Title = "Hub Launching Now..",
    Content = "Proccessing Data...",
    Duration = 5
})
task.wait(2.5)

--====================================================
-- FLUENT WINDOW
--====================================================

local Window = Fluent:CreateWindow({
    Title = "World Zero 🚀 Hub v2.4 |",
    SubTitle = "Fluent Version:  " .. Fluent.Version,
    TabWidth = 160,
    Size = UDim2.fromOffset(650, 580),
    Acrylic = true,
    Theme = "Amethyst",
    MinimizeKey = Enum.KeyCode.LeftControl
})

local Tabs = {
    Main = Window:AddTab({ Title = "Main Terminal 🖥️", Icon = "database" }),
    Combat = Window:AddTab({ Title = "Combat Terminal 🛡️", Icon = "swords" }),
    Teles = Window:AddTab({ Title = "Teleport Terminal 🌎", Icon = "globe" }),
    Events = Window:AddTab({ Title = "Events Terminal 🐰", Icon = "carrot" }),
    Invent = Window:AddTab({ Title = "Inventory Terminal 👜", Icon = "backpack" }),
    PlayerSettings = Window:AddTab({ Title = "Player Terminal 🙍", Icon = "scan-face" }),
    Qlinks = Window:AddTab({ Title = "Launchers Terminal 🧑‍💻", Icon = "crown" }),
    DevLinks = Window:AddTab({ Title = "Developer Terminal 🛠️", Icon = "file-code" }),
    Settings = Window:AddTab({ Title = " Settings Terminal ⚙️", Icon = "settings" })
}

local Options = Fluent.Options

--====================================================
-- UTILITIES
--====================================================

local function Notify(title, content)
    Fluent:Notify({
        Title = title,
        Content = content,
        Duration = 6
    })
end

local function safeLoad(url, name)
    local ok, result = pcall(function()
        return loadstring(game:HttpGet(url))()
    end)

    if not ok then
        Notify("Error loading " .. (name or "script"), tostring(result))
    end
end

local function restoreHumanoid()
    local char = player.Character
    local hum = char and char:FindFirstChildOfClass("Humanoid")

    if hum then
        hum:ChangeState(Enum.HumanoidStateType.Running)
        hum:ChangeState(Enum.HumanoidStateType.GettingUp)
    end
end

local function pressKey(key)
    VIM:SendKeyEvent(true, key, false, game)
    VIM:SendKeyEvent(false, key, false, game)
end

local function QueueHub()
    if queue_on_teleport then
        queue_on_teleport([[
            task.wait(2)
            loadstring(game:HttpGet("https://raw.githubusercontent.com/tinywolf420/World-Zero-Hub/refs/heads/main/WorldZeroHub"))()
        ]])
    end
end



--====================================================
-- MOVEMENT SYSTEM
--====================================================

local noclipEnabled = false

player.CharacterAdded:Connect(function(char)
    character = char
end)

RunService.Stepped:Connect(function()
    if noclipEnabled and character then
        for _, part in ipairs(character:GetChildren()) do
            if part:IsA("BasePart") then
                part.CanCollide = false
            end
        end
    end
end)

function SetNoclip(state)
    noclipEnabled = state
end

RunService.Heartbeat:Connect(function()
    if Options.WalkSpeed then
        local char = player.Character
        if char then
            local hum = char:FindFirstChildOfClass("Humanoid")
            if hum then
                hum.WalkSpeed = Options.WalkSpeed.Value
            end
        end
    end
end)

local function SetWalkSpeed(value)
    local character = player.Character or player.CharacterAdded:Wait()
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    if humanoid then
        humanoid.WalkSpeed = value
    end
end

local function SetJumpHeight(value)
    local character = player.Character or player.CharacterAdded:Wait()
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    if humanoid then
        humanoid.UseJumpPower = true
        humanoid.JumpPower = value
    end
end

--====================================================
-- PLAYER ESP SYSTEM
--====================================================

local espEnabled = false
local nameEspEnabled = false

local function applyESPToCharacter(character, plr)
    if not character or not plr then return end

    local highlight = workspace:FindFirstChild("FluentESP_" .. plr.UserId)
    if not highlight then
        highlight = Instance.new("Highlight")
        highlight.Name = "FluentESP_" .. plr.UserId
        highlight.FillColor = Color3.fromRGB(255, 0, 255)
        highlight.OutlineColor = Color3.fromRGB(127, 0, 255)
        highlight.Adornee = character
        highlight.Parent = workspace
    end

    highlight.Enabled = espEnabled

    local head = character:FindFirstChild("Head")
    if head then
        local tag = head:FindFirstChild("FluentESP_Name")
        if not tag then
            tag = Instance.new("BillboardGui")
            tag.Name = "FluentESP_Name"
            tag.Size = UDim2.new(0, 50, 0, 25)
            tag.AlwaysOnTop = true
            tag.Parent = head

            local label = Instance.new("TextLabel")
            label.Name = "Label"
            label.Size = UDim2.new(1, 0, 1, 0)
            label.BackgroundTransparency = 1
            label.Font = Enum.Font.FredokaOne
            label.TextScaled = true
            label.TextColor3 = Color3.fromRGB(0, 255, 255)
            label.TextStrokeColor3 = Color3.fromRGB(200, 0, 255)
            label.TextStrokeTransparency = 0.5
            label.Parent = tag
        end

        tag.Label.Text = plr.Name
        tag.Enabled = nameEspEnabled
    end
end

local function updateAllESP()
    for _, plr in ipairs(Players:GetPlayers()) do
        if plr ~= Players.LocalPlayer and plr.Character then
            applyESPToCharacter(plr.Character, plr)
        end
    end
end

Players.PlayerAdded:Connect(function(plr)
    plr.CharacterAdded:Connect(function(char)
        task.wait(1)
        applyESPToCharacter(char, plr)
    end)
end)

function SetESP(state)
    espEnabled = state
    updateAllESP()
end

function SetNameESP(state)
    nameEspEnabled = state
    updateAllESP()
end

RunService.RenderStepped:Connect(function()
    if not nameEspEnabled then return end

    local localChar = Players.LocalPlayer.Character
    if not localChar then return end

    local myHRP = localChar:FindFirstChild("HumanoidRootPart")
    if not myHRP then return end

    for _, plr in ipairs(Players:GetPlayers()) do
        if plr ~= Players.LocalPlayer and plr.Character then
            local head = plr.Character:FindFirstChild("Head")
            local hrp = plr.Character:FindFirstChild("HumanoidRootPart")

            if head and hrp then
                local tag = head:FindFirstChild("FluentESP_Name")
                if tag then
                    local distance = math.floor((hrp.Position - myHRP.Position).Magnitude)
                    tag.Label.Text = plr.Name .. " [" .. distance .. "m]"
                end
            end
        end
    end
end)

--====================================================
-- EGG ESP SYSTEM
--====================================================

local EggDropdown -- forward declare

local eggEspEnabled = false
local eggEspObjects = {}
local eggNumberEspEnabled = false
local eggNumberEspObjects = {}

local function ApplyEggESP()
    for _, obj in ipairs(eggEspObjects) do
        if obj and obj.Parent then
            obj:Destroy()
        end
    end
    table.clear(eggEspObjects)

    if not eggEspEnabled then return end

    local root = workspace:FindFirstChild("ScavengerHunts")
    if not root then return end

    local eggHunt = root:FindFirstChild("EggHunt")
    if not eggHunt then return end

    local container = eggHunt:FindFirstChild("_ScavengerHuntContainer")
    if not container then return end

    for _, model in ipairs(container:GetChildren()) do
        if model:IsA("Model") and model.Name:match("LiveModel") then
            local highlight = Instance.new("Highlight")
            highlight.Name = "EggESP_" .. model.Name
            highlight.FillColor = Color3.fromRGB(127, 0, 255)
            highlight.OutlineColor = Color3.fromRGB(255, 0, 255)
            highlight.Adornee = model
            highlight.Parent = model
            table.insert(eggEspObjects, highlight)

            local num = model.Name:match("%d+") or "?"

            local billboard = Instance.new("BillboardGui")
            billboard.Name = "EggNumber_" .. num
            billboard.Size = UDim2.new(0, 50, 0, 25)
            billboard.AlwaysOnTop = true
            billboard.StudsOffset = Vector3.new(0, 4, 0)
            billboard.Parent = model

            local label = Instance.new("TextLabel")
            label.Size = UDim2.new(1, 0, 1, 0)
            label.BackgroundTransparency = 1
            label.Font = Enum.Font.FredokaOne
            label.TextScaled = true
            label.TextColor3 = Color3.fromRGB(0, 255, 255)
            label.TextStrokeColor3 = Color3.fromRGB(200, 0, 255)
            label.TextStrokeTransparency = 0.3
            label.Text = "Egg " .. num
            label.Parent = billboard

            table.insert(eggEspObjects, billboard)
        end
    end
end

local goldenEggEspEnabled = false
local goldenEggEspObject = nil

local function ApplyGoldenEggESP()
    if goldenEggEspObject and goldenEggEspObject.Parent then
        goldenEggEspObject:Destroy()
    end
    goldenEggEspObject = nil

    if not goldenEggEspEnabled then return end

    local goldenRoot = workspace:FindFirstChild("ScavengerHunts")
    if not goldenRoot then return end

    local goldenEgg = goldenRoot:FindFirstChild("GoldenEgg")
    if not goldenEgg then return end

    local highlight = Instance.new("Highlight")
    highlight.Name = "GoldenEggESP"
    highlight.FillColor = Color3.fromRGB(255, 215, 0)
    highlight.OutlineColor = Color3.fromRGB(255, 255, 150)
    highlight.Adornee = goldenEgg
    highlight.Parent = goldenEgg

    goldenEggEspObject = highlight
end

--====================================================
-- MOB ESP SYSTEM
--====================================================

local mobEspEnabled = false
local mobNameEspEnabled = false
local mobEspObjects = {}

local MobsFolder = workspace:FindFirstChild("Mobs")

local function applyESPToMob(mob)
    if not mob or not mob:FindFirstChild("Collider") then return end

    local highlight = mob:FindFirstChild("MobESP_Highlight")
    if not highlight then
        highlight = Instance.new("Highlight")
        highlight.Name = "MobESP_Highlight"
        highlight.FillColor = Color3.fromRGB(255, 50, 50)
        highlight.OutlineColor = Color3.fromRGB(255, 200, 200)
        highlight.Adornee = mob
        highlight.Parent = mob
    end
    highlight.Enabled = mobEspEnabled

    local head = mob:FindFirstChild("Head") or mob:FindFirstChild("Collider")
    if head then
        local tag = head:FindFirstChild("MobESP_Name")
        if not tag then
            tag = Instance.new("BillboardGui")
            tag.Name = "MobESP_Name"
            tag.Size = UDim2.new(0, 50, 0, 25)
            tag.AlwaysOnTop = true
            tag.Parent = head

            local label = Instance.new("TextLabel")
            label.Name = "Label"
            label.Size = UDim2.new(1, 0, 1, 0)
            label.BackgroundTransparency = 1
            label.Font = Enum.Font.FredokaOne
            label.TextScaled = true
            label.TextColor3 = Color3.fromRGB(168, 21, 21)
            label.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
            label.TextStrokeTransparency = 0.5
            label.Parent = tag
        end

        tag.Enabled = mobNameEspEnabled
        tag.Label.Text = mob.Name
    end
end

local function updateAllMobESP()
    if not MobsFolder then return end
    for _, mob in ipairs(MobsFolder:GetChildren()) do
        if mob:FindFirstChild("Collider") then
            applyESPToMob(mob)
        end
    end
end

if MobsFolder then
    MobsFolder.ChildAdded:Connect(function(mob)
        task.wait(0.2)
        applyESPToMob(mob)
    end)
end

RunService.RenderStepped:Connect(function()
    if not mobNameEspEnabled then return end
    if not MobsFolder then return end

    local char = Players.LocalPlayer.Character
    if not char then return end

    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end

    for _, mob in ipairs(MobsFolder:GetChildren()) do
        local head = mob:FindFirstChild("Head") or mob:FindFirstChild("Collider")
        if head then
            local tag = head:FindFirstChild("MobESP_Name")
            if tag then
                local dist = math.floor((head.Position - hrp.Position).Magnitude)
                tag.Label.Text = mob.Name .. " [" .. dist .. "m]"
            end
        end
    end
end)

--====================================================
-- AUTO ATTACK / CLICK LOOP
--====================================================

local function clickLoop()
    task.spawn(function()
        while getgenv().kill do
                local hum = char and char:FindFirstChildOfClass("Humanoid")
                        -- ❌ cancel animations
            if hum then
                for _, track in ipairs(hum:GetPlayingAnimationTracks()) do
                    track:Stop()
                end
            end
            VIM:SendMouseButtonEvent(0, 0, 0, true, game, 0)
            VIM:SendMouseButtonEvent(0, 0, 0, false, game, 0)
            task.wait(0.1)
        end
    end)
end

local function setKill(state)
    getgenv().kill = state
    if state then
        clickLoop()
    end
end

--====================================================
-- AUTO SKILLS SYSTEM
--====================================================

local skillThread = nil

local skills = {
    {key = Enum.KeyCode.E,   delay = 3.0,  lastUsed = 0},
    {key = Enum.KeyCode.R,   delay = 11.0, lastUsed = 0},
    {key = Enum.KeyCode.F,   delay = 9.0, lastUsed = 0},
    {key = Enum.KeyCode.X,   delay = 50.0, lastUsed = 0},
    {key = Enum.KeyCode.One, delay = 1.0,  lastUsed = 0},
}

local function SkillLoop()
    if skillThread then return end

    skillThread = task.spawn(function()
        while getgenv().autoSkills do
            local now = tick()

            for _, skill in ipairs(skills) do
                if now - skill.lastUsed >= skill.delay then
                    pressKey(skill.key)
                    skill.lastUsed = now
                end
            end

            task.wait(0.05)
        end

        skillThread = nil
    end)
end

local function SkillKill(state)
    getgenv().kill = state
    if state then
        SkillLoop()
    end
end

--====================================================
-- AUTO MOB SYSTEM
--====================================================

local mobThread = nil


local function getClosestMob()
    local char = player.Character
    if not char then return nil end

    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return nil end

    local mobsFolder = workspace:FindFirstChild("Mobs")
    if not mobsFolder then return nil end

    local closest, dist = nil, math.huge

    for _, mob in ipairs(mobsFolder:GetChildren()) do
        local part = mob:FindFirstChild("HumanoidRootPart") or mob:FindFirstChild("Collider")
        if part then
            local d = (hrp.Position - part.Position).Magnitude
            if d < dist then
                dist = d
                closest = part
            end
        end
    end

    return closest
end

local function startMobLoop()
    if mobThread then return end

    mobThread = task.spawn(function()
       while getgenv().autoMob do
        local char = player.Character
        local hrp = char and char:FindFirstChild("HumanoidRootPart")
        local hum = char and char:FindFirstChildOfClass("Humanoid")

        if hrp and hum then
            local now = tick()

            -- force re-check every 0.15s OR if current mob is gone
            if not currentMob
                or not currentMob.Parent
                or now - lastSwitch > 0.15 then

                currentMob = getClosestMob()
                lastSwitch = now
            end

            local mob = currentMob

            if mob then
                local targetPos

                if getgenv().rotateMob then
                    local angle = now * getgenv().rotateSpeed
                    local radius = getgenv().rotateRadius

                    targetPos = mob.Position + Vector3.new(
                        math.cos(angle) * radius,
                        3,
                        math.sin(angle) * radius
                    )
                else
                    targetPos = mob.Position + Vector3.new(0, 3, 4)
                end

                hum:ChangeState(Enum.HumanoidStateType.Physics)

                hrp.AssemblyLinearVelocity = Vector3.zero
                hrp.AssemblyAngularVelocity = Vector3.zero

                hrp.CFrame = CFrame.new(targetPos)
                hrp.CFrame = CFrame.lookAt(hrp.Position, mob.Position)

                pcall(function()
                    ReplicatedStorage.Remotes.ItemUsed:FireServer("Attack")
                end)
            else
                currentMob = nil
            end
        end

        task.wait(getgenv().autoMobDetect)
    end

        mobThread = nil
        restoreHumanoid()
    end)
end

--====================================================
-- CHECKPOINT AUTO-TOUCH SYSTEM (UPDATED)
--====================================================

local checkpointThread = nil

local function findCheckpointPart(obj)
    if obj:IsA("BasePart") and obj:FindFirstChild("TouchInterest") then
        return obj
    end
    for _, child in ipairs(obj:GetChildren()) do
        local found = findCheckpointPart(child)
        if found then return found end
    end
    return nil
end

-- 🔥 CLEAN TOUCH FUNCTION
local function touchPart(hrp, part)
    if part and part:IsA("BasePart") and part:FindFirstChild("TouchInterest") then
        pcall(function()
            firetouchinterest(hrp, part, 0)
            task.wait()
            firetouchinterest(hrp, part, 1)
        end)
    end
end
local function bringAndTouch(hrp, obj)
    if not obj then return end

    -- get a BasePart
    local part = obj:IsA("BasePart") and obj
        or obj:FindFirstChildWhichIsA("BasePart")

    if not part then return end

    pcall(function()
        -- move part to player
        part.CFrame = hrp.CFrame

        -- trigger touch
        firetouchinterest(hrp, part, 0)
        task.wait()
        firetouchinterest(hrp, part, 1)
    end)
end

local function startCheckpointLoop()
    if checkpointThread then return end

    checkpointThread = task.spawn(function()
        while getgenv().autoCheckpoints do
            local missionObjects = workspace:FindFirstChild("MissionObjects")

            local char = player.Character
            local hrp = char and char:FindFirstChild("HumanoidRootPart")

            if hrp and missionObjects then

                -- 🔹 Mission Start
                local missionStart = missionObjects:FindFirstChild("MissionStart")
                local startPart = missionStart and missionStart:FindFirstChild("Collider")
                touchPart(hrp, startPart)

                -- 🔹 EXTRA TRIGGERS (YOUR ADDITIONS)
                touchPart(hrp, missionObjects:FindFirstChild("CannonTrigger"))
                touchPart(hrp, missionObjects:FindFirstChild("VineRoomTrigger"))
                touchPart(hrp, missionObjects:FindFirstChild("CheckpointTrigger"))
                touchPart(hrp, missionObjects:FindFirstChild("ObbyTrigger"))
                touchPart(hrp, missionObjects:FindFirstChild("BossTrigger"))

                touchPart(hrp, missionObjects:FindFirstChild("CastleTrigger"))
                bringAndTouch(hrp, workspace:FindFirstChild("Cage1Marker"))
                bringAndTouch(hrp, workspace:FindFirstChild("Cage2Marker"))


                -- 🔹 CHECKPOINTS
                local checkpointsFolder = missionObjects:FindFirstChild("Checkpoints")
                if checkpointsFolder then
                    for _, checkpoint in ipairs(checkpointsFolder:GetChildren()) do
                        local part = findCheckpointPart(checkpoint)
                        touchPart(hrp, part)
                    end
                end
            end

            task.wait(3) -- slightly faster loop
        end

        checkpointThread = nil
        restoreHumanoid()
    end)
end


--====================================================
-- AUTO CHEST OPENER (FINAL FIX)
--====================================================

local chestThread = nil

local function startChestLoop()
    if chestThread then return end

    chestThread = task.spawn(function()
        local remote = ReplicatedStorage:WaitForChild("Shared")
            :WaitForChild("Chests")
            :WaitForChild("OpenChest")

        while getgenv().autoChests do
            local gui = player:FindFirstChild("PlayerGui")
            local rewards = gui and gui:FindFirstChild("MissionRewards", true)

            -- ✅ only run when chest screen is visible
            if rewards and rewards.Enabled then
                -- 🔥 fire ALL chest options (1,2,3)
                for i = 1, 3 do
                    pcall(function()
                        remote:FireServer(i)
                    end)
                end

                -- wait so we don’t spam
                task.wait(1.5)
            end

            task.wait(0.3)
        end

        chestThread = nil
    end)
end




--====================================================
-- INVENTORY ANALYZER
--====================================================

local function getBestUpgradeItem()
    local itemsFolder = player.PlayerGui.Profile.Inventory.Items

    local bestItem = nil
    local bestScore = -math.huge

    for _, item in ipairs(itemsFolder:GetChildren()) do
        local upgrade = item:FindFirstChild("Upgrade")
        local limit = item:FindFirstChild("UpgradeLimit")
        local level = item:FindFirstChild("Level")

        if upgrade and limit and level then
            local remaining = limit.Value - upgrade.Value

            if remaining > 0 then
                local score =
                    level.Value * 1.5 +
                    remaining * 25

                if item:FindFirstChild("Perk1") then
                    score += 10
                end

                if item:FindFirstChild("Perk2") then
                    score += 10
                end

                if item:FindFirstChild("Perk3") then
                    score += 10
                end

                if score > bestScore then
                    bestScore = score
                    bestItem = item
                end
            end
        end
    end

    return bestItem, bestScore
end

local function getScoreData(ratio, results)
    results.stats.total = (results.stats.total or 0) + 1

    if ratio >= 0.95 then
        results.stats.perfect = (results.stats.perfect or 0) + 1
        return "💎 PERFECT", "KEEP"

    elseif ratio >= 0.85 then
        results.stats.excellent = (results.stats.excellent or 0) + 1
        return "🟢 EXCELLENT+", "KEEP"

    elseif ratio >= 0.70 then
        results.stats.excellent = (results.stats.excellent or 0) + 1
        return "🟢 EXCELLENT", "KEEP"

    elseif ratio >= 0.55 then
        results.stats.good = (results.stats.good or 0) + 1
        return "🟡 GOOD+", "KEEP"

    elseif ratio >= 0.40 then
        results.stats.good = (results.stats.good or 0) + 1
        return "🟡 GOOD", "REVIEW"

    elseif ratio >= 0.25 then
        results.stats.weak = (results.stats.weak or 0) + 1
        return "🟠 WEAK", "REVIEW"

    elseif ratio >= 0.15 then
        results.stats.weak = (results.stats.weak or 0) + 1
        return "🟠 VERY WEAK", "SELL"

    elseif ratio >= 0.05 then
        results.stats.bad = (results.stats.bad or 0) + 1
        return "🔴 BAD", "SELL"

    else
        results.stats.trash = (results.stats.trash or 0) + 1
        return "⚫ TRASH", "SELL"
    end
end

local function analyzeInventory(playerEquip)
    local slots = {"Armor", "Primary", "Offhand"}

    local results = {
        keep = {},
        review = {},
        sell = {},

        stats = {
            total = 0,
            perfect = 0,
            excellent = 0,
            good = 0,
            weak = 0,
            bad = 0,
            trash = 0
        }
    }

    for _, slotName in ipairs(slots) do
        local slot = playerEquip:FindFirstChild(slotName)

        if slot then
            for _, item in ipairs(slot:GetChildren()) do
                local upgrade = item:FindFirstChild("Upgrade")
                local limit = item:FindFirstChild("UpgradeLimit")

                if upgrade and limit then
                    local u = tonumber(upgrade.Value or upgrade:GetAttribute("Value"))
                    local l = tonumber(limit.Value or limit:GetAttribute("Value"))

                    if u and l then
                        local ratio = u / math.max(l, 1)

                        local rankText, category = getScoreData(ratio, results)

                        local entry = {
                            name = item.Name,
                            slot = slotName,
                            ratio = ratio,
                            rank = rankText
                        }

                        table.insert(results[category:lower()], entry)

                        print(slotName, item.Name, rankText, ratio)
                    end
                end
            end
        end
    end

    return results
end

local function printSummary(results)
    local stats = results.stats

    local sellCount = (results.sell and #results.sell) or 0
    local keepCount = (results.keep and #results.keep) or 0

    Notify(
        "📊 FULL INVENTORY INTELLIGENCE REPORT",
        "📦 TOTAL ITEMS: " .. stats.total .. "\n\n" ..

        "💎 PERFECT: " .. stats.perfect .. "\n" ..
        "🟢 EXCELLENT: " .. stats.excellent .. "\n" ..
        "🟡 GOOD: " .. stats.good .. "\n" ..
        "🟠 WEAK: " .. stats.weak .. "\n" ..
        "🔴 BAD: " .. stats.bad .. "\n" ..
        "⚫ TRASH: " .. stats.trash .. "\n\n" ..

        "📊 BREAKDOWN:\n" ..
        "KEEP → High performance gear\n" ..
        "REVIEW → Compare before replacing\n" ..
        "SELL → Low value items\n\n" ..

        "🎯 INSIGHT:\n" ..
        (sellCount > keepCount and
            "⚠️ Inventory is heavily weighted toward weak gear"
            or "✅ Loadout is mostly optimized")
    )
end

getgenv().lastInventoryScan = nil

local function getEquippedItems(playerEquip)
    local equipped = {}

    local slots = {"Armor", "Primary", "Offhand"}

    for _, slotName in ipairs(slots) do
        local slot = playerEquip:FindFirstChild(slotName)

        if slot then
            for _, item in ipairs(slot:GetChildren()) do
                equipped[item.Name] = true
            end
        end
    end

    return equipped
end

local function getWorldTeleportFolder()
    local menuRings = workspace:FindFirstChild("MenuRings")
    if not menuRings then return nil end

    return menuRings:FindFirstChild("World_Teleport")
        or menuRings:FindFirstChild("Teleport")
end




--====================================================
-- MAIN TAB UI
--====================================================

Tabs.Main:AddSection("🔮 Misc:")

local chestToggle = Tabs.Main:AddToggle("AutoChests", {
    Title = "🎁 Auto Open Mission Chests",
    Default = false,
    Callback = function(state)
        getgenv().autoChests = state
        if state then
            startChestLoop()
        end
    end
})

local PromoInput = Tabs.Main:AddInput("PromoInput", {
    Title = "Promo Code",
    Default = "",
    Placeholder = "Enter Promo Code...",
    Numeric = false,
    Finished = false,
    Callback = function(Value)
        print("Promo code typed:", Value)
    end
})

PromoInput:OnChanged(function()
    print("Promo code updated:", PromoInput.Value)
end)

Tabs.Main:AddButton({
    Title = "Redeem Promo Code",
    Callback = function()
        local code = PromoInput.Value

        if code == "" then
            print("No promo code entered.")
            return
        end

        print("Redeeming promo code:", code)

        local remote = game:GetService("ReplicatedStorage")
            .Shared
            .PromoCodes
            .RedeemCode

        remote:InvokeServer("RedeemCode", code)
    end
})

---------------------------------------------------------
-- COMBAT TERMINAL
---------------------------------------------------------
Tabs.Combat:AddSection("⚔️ Combat Enable/Disabled Checks🛡️")
-- Create the toggle FIRST

-- Auto Attack (Eight)
local killToggle = Tabs.Combat:AddToggle("KillToggle", {
    Title = "⚔️ Auto Attack | ⬇️  Keybind: [ Three ] \n(Do Not Need To Click This Use Keybind)⚠️",
    Default = false,
    Callback = function(state)
        setKill(state)
    end
})
-- Auto Skills (Nine)
local skillToggle = Tabs.Combat:AddToggle("SkillToggle", {
    Title = "🤺 Auto Skills | ⬇️  Keybind: [ Four ] \n(Do Not Need To Click This Use Keybind)⚠️",
    Default = false,
    Callback = function(state)
        getgenv().autoSkills = state
        if state then
            SkillLoop()
        else
            skillThread = nil
        end
    end
})
-- Auto Move to Mob (Six)
local mobMoveToggle = Tabs.Combat:AddToggle("AutoMobMove", {
    Title = "🧠 Auto Mob Detection | ⬇️  Keybind: [ Five ] \n(Do Not Need To Click This Use Keybind)⚠️",
    Default = false,
    Callback = function(state)
        getgenv().autoMob = state

        if state then
            startMobLoop()
        else
            restoreHumanoid()
        end
    end

})
Tabs.Combat:AddSlider("MobDetectSpeedSlider", {
    Title = "🧠 Mob Detection Speed",
    Min = 0.001,
    Max = 0.1,
    Default = 0.001,
    Rounding = 2,

    Callback = function(Value)
        getgenv().mobDetectSpeed = Value
    end
})

-- Circle Around Mob (Seven)
local rotateToggle = Tabs.Combat:AddToggle("RotateMob", {
    Title = "⭕ Circle Around Mob | ⬇️  Keybind: [ Six ] \n(Do Not Need To Click This Use Keybind)⚠️",
    Default = true,
    Callback = function(state)
        getgenv().rotateMob = state
    end
})
Tabs.Combat:AddSlider("RotateSpeed", {
    Title = "⭕ Rotation Speed",
    Description = "How fast you circle mobs",

    Min = 1,
    Max = 5,
    Default = 3,
    Rounding = 1,
    Callback = function(value)
        getgenv().rotateSpeed = value
    end
})
Tabs.Combat:AddSlider("RotateRadius", {
    Title = "⭕ Rotate Distance",
    Description = "Distance from mob while circling",
    Default = 8,
    Min = 6,
    Max = 20,
    Default = 8,
    Rounding = 0,
    Callback = function(value)
        getgenv().rotateRadius = value
    end
})

Tabs.Combat:AddSection("🐲 Auto Dungeon Progession:")
-- Auto Move to Mob

-- Auto Checkpoints
local checkpointsToggle = Tabs.Combat:AddToggle("autoCheckpoints", {
    Title = "⚔️ Auto Advance",
    Default = false,
    Callback = function(state)
        getgenv().autoCheckpoints = state

        if state then
            startCheckpointLoop()
        else
            restoreHumanoid()
        end
    end
})


Tabs.Combat:AddSection("⚔️ Combat Keybinds:")
local KillKeybind = Tabs.Combat:AddKeybind("KillKeybind", {
    Title = "⚔️ Auto Basic Attack Keybind",
    Mode = "Toggle",
    Default = "Three",

    Callback = function(Value)
        killToggle:SetValue(Value)
        killToggle:SetTitle("⚔️Auto Attack | ⬇️  Keybind: [ " .. tostring(Value) .. " ] \n(Do Not Need To Click This Use Keybind)⚠️")
    end,

    ChangedCallback = function(New)
        killToggle:SetTitle("⚔️Auto Attack | ⬇️  Keybind: [ " .. tostring(Value) .. " ] \n(Do Not Need To Click This Use Keybind)⚠️")
    end
})
local skillKeybind = Tabs.Combat:AddKeybind("SkillKeybind", {
    Title = "🤺 Auto Attack Skills Keybind",
    Mode = "Toggle",
    Default = "Four",

    Callback = function(Value)
        skillToggle:SetValue(Value)
        skillToggle:SetTitle("🤺Auto Skills | ⬇️  Keybind: [ " .. tostring(Value) .. " ] \n(Do Not Need To Click This Use Keybind)⚠️")
    end,

    ChangedCallback = function(New)
        skillToggle:SetTitle("🤺Auto Skills | ⬇️  Keybind: [ " .. tostring(New) .. " ] \n(Do Not Need To Click This Use Keybind)⚠️")
    end
})
local mobMoveKeybind = Tabs.Combat:AddKeybind("AutoMobMoveKeybind", {
    Title = "🧠 Auto Move Keybind",
    Mode = "Toggle",
    Default = "Five",

    Callback = function(Value)
        mobMoveToggle:SetValue(Value)
        mobMoveToggle:SetTitle("🧠 Auto Move to Mob | ⬇️  Keybind: [ " .. tostring(Value) .. " ] \n(Do Not Need To Click This Use Keybind)⚠️")
    end,

    ChangedCallback = function(New)
        mobMoveToggle:SetTitle("🧠 Auto Move to Mob | ⬇️  Keybind: [ " .. tostring(New) .. " ] \n(Do Not Need To Click This Use Keybind)⚠️")
    end
})

local rotateKeybind = Tabs.Combat:AddKeybind("RotateMobKeybind", {
    Title = "⭕ Circle Rotate Mob Keybind",
    Mode = "Toggle",
    Default = "Six",

    Callback = function(Value)
        rotateToggle:SetValue(Value)
        rotateToggle:SetTitle("⭕Circle Around Mob | ⬇️  Keybind: [ " .. tostring(Value) .. " ] \n⚠️(Do Not Need To Click This Use Keybind)⚠️")
    end,

    ChangedCallback = function(New)
        rotateToggle:SetTitle("⭕Circle Around Mob | ⬇️  Keybind: [ " .. tostring(New) .. " ] \n⚠️(Do Not Need To Click This Use Keybind)⚠️")
    end
})




KillKeybind:OnClick(function()
    print("Kill keybind clicked:", KillKeybind:GetState())
end)

KillKeybind:OnChanged(function()
    print("Kill keybind changed:", KillKeybind.Value)
end)

---------------------------------------------------------
-- TELEPORT TAB
---------------------------------------------------------
Tabs.Teles:AddSection("World Teleports🛫")

Tabs.Teles:AddButton({
    Title = "🛫World Teleports (Auto Detect)",
    Callback = function()
        
        local folder = getWorldTeleportFolder()

        if not folder then
            Notify("Not Found", "No World Teleport folder found (World_Teleport / Teleport)")
            return
        end

        local char = player.Character
        local hrp = char and char:FindFirstChild("HumanoidRootPart")

        if not hrp then
            Notify("Error", "Character not loaded.")
            return
        end

        local nearest, dist = nil, math.huge

        for _, ring in ipairs(folder:GetChildren()) do
            if ring:IsA("BasePart") then
                local d = (hrp.Position - ring.Position).Magnitude
                if d < dist then
                    dist = d
                    nearest = ring
                end
            end
        end
        
        if nearest then
            Notify("Teleporting", "Using detected teleport system...")

            ReplicatedStorage.Remotes.SetMounted:FireServer(true)
            task.wait(0.25)

            hrp.CFrame = nearest.CFrame + Vector3.new(0, 3, 0)

            task.wait(0.75)
            ReplicatedStorage.Remotes.SetMounted:FireServer(false)

        else
            Notify("No Rings", "No teleport parts found in folder.")
        end
    end
})


local worldTeleports = {
    {name = "World 1", id = 13},
    {name = "World 2", id = 19},
    {name = "World 3", id = 20},
    {name = "World 4", id = 29},
    {name = "World 5", id = 31},
    {name = "World 6", id = 36},
    {name = "World 7", id = 40},
    {name = "World 8", id = nil},
}

local grouped = {}
for i = 1, #worldTeleports, 2 do
    local a = worldTeleports[i]
    local b = worldTeleports[i + 1]

    table.insert(grouped, {
        title = a.name .. (b and (" & " .. b.name) or ""),
        options = { a.name, b and b.name },
        data = { a, b }
    })
end

for _, group in ipairs(grouped) do
    Tabs.Teles:AddDropdown(group.title, {
        Title = group.title,
        Values = group.options,
        Multi = false,
        Default = nil,
            Callback = function(selected)
                for _, w in ipairs(group.data) do
                    if w and w.name == selected then
                        if w.id then
                            Notify("Teleporting", "Teleporting to " .. w.name)

                            task.wait(1)

                            -- ✅ queue script BEFORE teleport
                            QueueHub()

                            Notify("Queued", "Hub will auto-load after teleport")

                            task.wait(0.5)

                            Fluent:Destroy()

                            ReplicatedStorage.Shared.Teleport.TeleportToHub:FireServer(w.id)

                        else
                            Notify("No Teleport ID", w.name .. " has no teleport ID")
                        end
                    end
                end
            end

    })
end

---------------------------------------------------------
-- WAYSTONES TELEPORT SYSTEM
---------------------------------------------------------

local waystonesFolder = workspace:FindFirstChild("Waystones")

if waystonesFolder then
    
    -- Get all waystone references
    local function GetWaystoneRefs()
        local refs = {}
        for _, obj in ipairs(waystonesFolder:GetChildren()) do
            if obj:IsA("Model") or obj:IsA("Folder") then
                local part = obj:FindFirstChildWhichIsA("BasePart", true)
                if part then
                    refs[obj.Name] = part
                end
            end
        end
        return refs
    end

    -- Build list for dropdown
    local function BuildWaystoneList(refs)
        local list = {}
        for name, part in pairs(refs) do
            table.insert(list, { name = "Waystone " .. name, id = part })
        end
        table.sort(list, function(a,b) return a.name < b.name end)
        return list
    end

    local WaystoneRefs = GetWaystoneRefs()
    local WaystoneTeleports = BuildWaystoneList(WaystoneRefs)

    local function GetWaystoneNames()
        local names = {}
        for _, ws in ipairs(WaystoneTeleports) do
            table.insert(names, ws.name)
        end
        return names
    end

    Tabs.Teles:AddSection("🗿 Waystones:")

    local WaystoneDropdown = Tabs.Teles:AddDropdown("WaystoneDropdown", {
        Title = "🗿 Waystone Teleports: (Dropdown)",
        Values = GetWaystoneNames(),
        Multi = false,
        Default = nil,
        Callback = function(selected)
            for _, ws in ipairs(WaystoneTeleports) do
                if ws.name == selected then
                    if ws.id then
                        Notify("Teleporting", "Mounting and teleporting to " .. ws.name)

                        ReplicatedStorage.Remotes.SetMounted:FireServer(true)
                        task.wait(0.25)

                        local char = player.Character
                        if char and char:FindFirstChild("HumanoidRootPart") then
                            char.HumanoidRootPart.CFrame = ws.id.CFrame + Vector3.new(0, 3, 0)
                        end

                        task.wait(0.55)
                        ReplicatedStorage.Remotes.SetMounted:FireServer(false)
                    else
                        Notify("Missing Part", ws.name .. " has no BasePart")
                    end
                end
            end
        end
    })

    Tabs.Teles:AddButton({
        Title = "♻️ Refresh Waystones",
        Callback = function()
            Notify("Refreshing", "Scanning Waystones...")

            WaystoneRefs = GetWaystoneRefs()
            WaystoneTeleports = BuildWaystoneList(WaystoneRefs)
            WaystoneDropdown:SetValues(GetWaystoneNames())

            Notify("Updated", "Waystone list refreshed")
        end
    })

else
    Tabs.Teles:AddParagraph({
        Title = "Waystones Not Found",
        Content = "workspace.Waystones does not exist in this place."
    })
end

---------------------------------------------------------
-- BANK TAB
---------------------------------------------------------

Tabs.Teles:AddSection("⭕ Interactive Rings:")
Tabs.Teles:AddParagraph({
    Title = "⚠️ Warning",
    Content = "‼️ Auto uses Mount To Not Die when Teleporting✅ ‼️ \nPossible to still Die tho.. "
})
local function TeleportToRing(ringName, displayName)
    local menuRings = workspace:FindFirstChild("MenuRings")
    local folder = menuRings and menuRings:FindFirstChild(ringName)

    if not folder then
        Notify("Not Found", "MenuRings." .. ringName .. " not found.")
        return
    end

    local char = player.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    if not hrp then
        Notify("Error", "Character not loaded.")
        return
    end

    local nearest, dist = nil, math.huge

    for _, ring in ipairs(folder:GetChildren()) do
        if ring:IsA("BasePart") then
            local d = (hrp.Position - ring.Position).Magnitude
            if d < dist then
                dist = d
                nearest = ring
            end
        end
    end

    if nearest then
        Notify("Teleporting", "Teleporting to nearest " .. displayName .. "...")
        ReplicatedStorage.Remotes.SetMounted:FireServer(true)
        task.wait(0.25)
        hrp.CFrame = nearest.CFrame + Vector3.new(0, 3, 0)
        task.wait(0.75)
        ReplicatedStorage.Remotes.SetMounted:FireServer(false)
    else
        Notify("No Rings", "No rings found under MenuRings." .. ringName)
    end
end
Tabs.Teles:AddDropdown("DungeonGuildDropdown", {
    Title = "🚪Dungeon Portals / ⚔️Guild Hall",
    Values = {
        "🚪Dungeon Portals",
        "⚔️Guild Hall"
    },
    Multi = false,
    Default = nil,
    Callback = function(selected)
        if selected == "🚪Dungeon Portals" then
            TeleportToRing("Dungeon_Station", "Dungeon Station")
        elseif selected == "⚔️Guild Hall" then
            TeleportToRing("Guilds", "Guild Hall")
        end
    end
})
Tabs.Teles:AddDropdown("SellUpgradeDropdown", {
    Title = "💰Sell / 🔧Upgrades / 🎁AuraChest",
    Values = {
        "💰Sell",
        "🔧Upgrade",
        "🎁Aura Chest"
    },
    Multi = false,
    Default = nil,
    Callback = function(selected)
        if selected == "💰Sell" then
            TeleportToRing("Sell", "Sell")
        elseif selected == "🔧Upgrade" then
            TeleportToRing("Upgrade", "Upgrade Station")
        elseif selected == "🎁Aura Chest" then
            TeleportToRing("AuraChest", "Aura Chest")
        end
    end
})
Tabs.Teles:AddDropdown("EggPetDropdown", {
    Title = "🥚Egg Shop / 🐈Pet Terminals",
    Values = {
        "🥚Egg Shop",
        "🐈Pet Master",
        "🐣Pet Incubator",
        "☢️Pet Fusion"
    },
    Multi = false,
    Default = nil,
    Callback = function(selected)
        if selected == "🥚Egg Shop" then
            TeleportToRing("EggShop", "Egg Shop")
        elseif selected == "🐈Pet Master" then
            TeleportToRing("PetMaster", "Pet Master")
        elseif selected == "🐣Pet Incubator" then
            TeleportToRing("PetIncubator", "Pet Incubator")
        elseif selected == "☢️Pet Fusion" then
            TeleportToRing("Pet_Fusion_Ring", "Pet Fusion")
        end
    end
})

---------------------------------------------------------
-- EVENTS TAB (EggHunt Teleport List) – SAFE
---------------------------------------------------------
Tabs.Events:AddSection("🐰 Event Interactive Rings:")
Tabs.Events:AddButton({
    Title = "🎉 Event Portal 🐰",
    Callback = function()
        local menuRings = workspace:FindFirstChild("MenuRings")
        local EventPortal = menuRings and menuRings:FindFirstChild("EventPortal")

        if not EventPortal then
            Notify("Bank Not Found", "MenuRings.EventPortal.Ring not found in Workspace.")
            return
        end

        local char = player.Character
        local hrp = char and char:FindFirstChild("HumanoidRootPart")
        if not hrp then
            Notify("Error", "Character not loaded.")
            return
        end

        local nearest, dist = nil, math.huge

        for _, ring in ipairs(EventPortal:GetChildren()) do
            if ring:IsA("BasePart") then
                local d = (hrp.Position - ring.Position).Magnitude
                if d < dist then
                    dist = d
                    nearest = ring
                end
            end
        end

        if nearest then
            Notify("Teleporting", "Teleporting to nearest EventPortal...")
            ReplicatedStorage.Remotes.SetMounted:FireServer(true)
            task.wait(0.25)
            hrp.CFrame = nearest.CFrame + Vector3.new(0, 3, 0)
            task.wait(0.75)
            ReplicatedStorage.Remotes.SetMounted:FireServer(false)
        else
            Notify("No Rings", "No EventPortal rings found under MenuRings.EventPortal.Ring.")
        end
    end
})
Tabs.Events:AddButton({
    Title = "🏪 Easter Booth 🐰",
    Callback = function()
        local menuRings = workspace:FindFirstChild("MenuRings")
        local Booth_Easter_Event = menuRings and menuRings:FindFirstChild("Booth_Easter_Event")

        if not Booth_Easter_Event then
            Notify("Bank Not Found", "MenuRings.Booth_Easter_Event.Ring not found in Workspace.")
            return
        end

        local char = player.Character
        local hrp = char and char:FindFirstChild("HumanoidRootPart")
        if not hrp then
            Notify("Error", "Character not loaded.")
            return
        end

        local nearest, dist = nil, math.huge

        for _, ring in ipairs(Booth_Easter_Event:GetChildren()) do
            if ring:IsA("BasePart") then
                local d = (hrp.Position - ring.Position).Magnitude
                if d < dist then
                    dist = d
                    nearest = ring
                end
            end
        end

        if nearest then
            Notify("Teleporting", "Teleporting to nearest Booth_Easter_Event...")
            ReplicatedStorage.Remotes.SetMounted:FireServer(true)
            task.wait(0.25)
            hrp.CFrame = nearest.CFrame + Vector3.new(0, 3, 0)
            task.wait(0.75)
            ReplicatedStorage.Remotes.SetMounted:FireServer(false)
        else
            Notify("No Rings", "No Booth_Easter_Event rings found under MenuRings.Booth_Easter_Event.Ring.")
        end
    end
})
Tabs.Events:AddSection("🥚Hunt Event")

Tabs.Events:AddParagraph({
    Title = "⚠️ Warning",
    Content = "‼️ Should now Auto Equip Mount ‼️ \nAuto uses Mount To Not Die when Teleporting✅"
})

local scavRoot = workspace:FindFirstChild("ScavengerHunts")
local eggHuntFolder = scavRoot and scavRoot:FindFirstChild("EggHunt")
local spawnsFolder = eggHuntFolder and eggHuntFolder:FindFirstChild("Spawns")

if scavRoot and eggHuntFolder and spawnsFolder then
    local function GetSpawnRefs()
        local refs = {}
        for _, obj in ipairs(spawnsFolder:GetChildren()) do
            if obj:IsA("BasePart") then
                refs[obj.Name] = obj
            end
        end
        return refs
    end

    local function BuildEggList(SpawnRefs)
        return {
            {name = "Egg 1", id = SpawnRefs["Spawn1"]},
            {name = "Egg 2", id = SpawnRefs["Spawn2"]},
            {name = "Egg 3", id = SpawnRefs["Spawn3"]},
            {name = "Egg 4", id = SpawnRefs["Spawn4"]},
            {name = "Egg 5", id = SpawnRefs["Spawn5"]},
            {name = "Egg 6", id = SpawnRefs["Spawn6"]},
            {name = "Egg 7", id = SpawnRefs["Spawn7"]},
            {name = "Egg 8", id = SpawnRefs["Spawn8"]},
            {name = "Egg 9", id = SpawnRefs["Spawn9"]},
            {name = "Egg 10", id = SpawnRefs["Spawn10"]},
        }
    end

    local SpawnRefs = GetSpawnRefs()
    local EggTeleports = BuildEggList(SpawnRefs)

    local function GetEggNames()
        local names = {}
        for _, egg in ipairs(EggTeleports) do
            table.insert(names, egg.name)
        end
        return names
    end

    local EggDropdown = Tabs.Events:AddDropdown("EggHuntDropdown", {
        Title = "🥚Hunt Teleports (Dropdown)",
        Values = GetEggNames(),
        Multi = false,
        Default = nil,
        Callback = function(selected)
            for _, egg in ipairs(EggTeleports) do
                if egg.name == selected then
                    if egg.id then
                        Notify("Teleporting", "Mounting and teleporting to " .. egg.name)

                        ReplicatedStorage.Remotes.SetMounted:FireServer(true)
                        task.wait(0.25)

                        local char = player.Character
                        if char and char:FindFirstChild("HumanoidRootPart") then
                            char.HumanoidRootPart.CFrame = egg.id.CFrame
                        end
                    else
                        Notify("Missing Spawn", egg.name .. " has no spawn part")
                    end
                end
            end
        end
    })

    Tabs.Events:AddButton({
        Title = "♻️Refresh 🥚Hunt Spawns Locations",
        Callback = function()
            Notify("Refreshing", "Scanning EggHunt spawns...")

            SpawnRefs = GetSpawnRefs()
            EggTeleports = BuildEggList(SpawnRefs)
            EggDropdown:SetValues(GetEggNames())

            Notify("Updated", "EggHunt spawn list refreshed")
        end
    })
else
    Tabs.Events:AddParagraph({
        Title = "EggHunt Not Available",
        Content = "ScavengerHunts/EggHunt/Spawns not found in this place (likely a dungeon)."
    })
end

Tabs.Events:AddSection("🥚 Egg / 📛 Name ESP")
Tabs.Events:AddToggle("EggESP", {
    Title = "🥚 ESP (Live Models)",
    Default = false,
    Callback = function(state)
        eggEspEnabled = state
        ApplyEggESP()
    end
})
Tabs.Events:AddToggle("GoldenEggESP", {
    Title = "Golden 🥚 ESP",
    Default = false,
    Callback = function(state)
        goldenEggEspEnabled = state
        ApplyGoldenEggESP()
    end
})

---------------------------------------------------------
-- EVENTS TAB (EggHunt Teleport List) – SAFE
---------------------------------------------------------
Tabs.Invent:AddSection("💪 Gear Upgrades:")

Tabs.Invent:AddButton({
    Title = "🧪 Scan Inventory",
    Callback = function()

        local player = game:GetService("Players").LocalPlayer
        local equipsFolder = game:GetService("ReplicatedStorage"):FindFirstChild("PlayerEquips")
        local playerEquip = equipsFolder and equipsFolder:FindFirstChild(player.Name)

        if not playerEquip then
            warn("No equip data found")
            return
        end

        local results = analyzeInventory(playerEquip)

        printSummary(results)

        -- only shows “suggestions”
        if getgenv().autoSellSuggest then
            Notify("💰 SELL SUGGESTIONS",
                "Items marked SELL: " .. #results.sell ..
                "\n(Check console for details)"
            )
        end
    end
})


Tabs.Invent:AddParagraph({
    Title = "⚠️ Equipped Item Upgrade Detector Info:\n",
    Content =
        "🟢 EXCELLENT = near max\n" ..
        "🟡 GOOD = mid upgraded\n" ..
        "🟠 BAD = low upgraded\n" ..
        "🔴 TERRIBLE = barely touched\n\n" ..
              "📊 ITEM DETECTION:\n" ..
              "Scans all equipped gear (Armor / Primary / Offhand)\n" ..
              "Calculates upgrade progress using Upgrade ÷ UpgradeLimit\n" ..
              "Displays a status rating + numeric score\n\n" ..
        "🎯 PURPOSE:\n" .. "Helps identify which equipped item is weakest and should be upgraded first"
})


Tabs.Invent:AddButton({
    Title = "🧪 Equipped Item Upgrade Detector",
    Callback = function()

        local Players = game:GetService("Players")
        local ReplicatedStorage = game:GetService("ReplicatedStorage")

        local plr = Players.LocalPlayer
        if not plr then
            warn("No LocalPlayer")
            return
        end

        local equipsFolder = ReplicatedStorage:FindFirstChild("PlayerEquips")
        if not equipsFolder then
            warn("PlayerEquips not found")
            return
        end

        local playerEquip = equipsFolder:FindFirstChild(plr.Name)
        if not playerEquip then
            warn("No equip data for player")
            return
        end

        local slots = {"Armor", "Primary", "Offhand"}

        local bestItem = nil
        local bestScore = math.huge

        print("Scanning equipped items...")

        -- 🔥 SCORE COLOR SYSTEM
        local function getScoreStyle(ratio)
            if ratio >= 0.8 then
                return "🟢 EXCELLENT"
            elseif ratio >= 0.5 then
                return "🟡 GOOD"
            elseif ratio >= 0.25 then
                return "🟠 BAD"
            else
                return "🔴 TERRIBLE"
            end
        end

        for _, slotName in ipairs(slots) do
            local slot = playerEquip:FindFirstChild(slotName)

            if slot then
                for _, item in ipairs(slot:GetChildren()) do

                    local upgrade = item:FindFirstChild("Upgrade")
                    local limit = item:FindFirstChild("UpgradeLimit")

                    if upgrade and limit then
                        local u = tonumber(upgrade.Value or upgrade:GetAttribute("Value"))
                        local l = tonumber(limit.Value or limit:GetAttribute("Value"))

                        if u and l then
                            local ratio = u / math.max(l, 1)

                            print(slotName, "|", item.Name, "|", u .. "/" .. l, "|", ratio)

                            local scoreText = getScoreStyle(ratio)

                            -- 🔔 NOTIFY PER ITEM (new order)
                            Notify(
                                "ITEM DETECTED",
                                slotName .. " → " .. item.Name ..
                                "\nStatus: " .. scoreText ..
                                "\nUpgrade: " .. u .. "/" .. l ..
                                "\nScore: " .. string.format("%.2f", ratio)
                            )


                            -- track WORST item (lowest ratio)
                            if ratio < bestScore then
                                bestScore = ratio
                                bestItem = item
                            end
                        end
                    end
                end
            end
        end

        -- 🏆 BEST ITEM NOTIFY (now includes Upgrade)
        if bestItem then
            local upgrade = bestItem:FindFirstChild("Upgrade")
            local limit = bestItem:FindFirstChild("UpgradeLimit")

            local u = upgrade and tonumber(upgrade.Value or upgrade:GetAttribute("Value")) or 0
            local l = limit and tonumber(limit.Value or limit:GetAttribute("Value")) or 1

            Notify(
                "BEST EQUIPPED UPGRADE TARGET",
                bestItem.Name ..
                "\nStatus: " .. getScoreStyle(u / l) ..
                "\nUpgrade: " .. u .. "/" .. l ..
                "\nScore: " .. string.format("%.2f", u / l)
            )

            print("BEST EQUIPPED UPGRADE TARGET:", bestItem.Name, "Score:", bestScore)
        else
            warn("No equipped upgrade items found")
        end


    end
})


---------------------------------------------------------
-- PLAYER SETTINGS TAB
---------------------------------------------------------
Tabs.PlayerSettings:AddSection("ESP Section:")
Tabs.PlayerSettings:AddSection("🙍 Player ESP:")
Tabs.PlayerSettings:AddToggle("ESP", {
    Title = "🙍Player ESP (Highlight)",
    Default = false,
    Callback = function(state)
        SetESP(state)
    end
})

Tabs.PlayerSettings:AddToggle("Player ESP", {
    Title = "📛 Player Name ESP",
    Default = false,
    Callback = function(state)
        SetNameESP(state)
    end
})

Tabs.PlayerSettings:AddSection("🐗 Monster ESP:")
Tabs.PlayerSettings:AddToggle("MobESP", {
    Title = "🐗 Monster ESP",
    Default = false,
    Callback = function(state)
        mobEspEnabled = state
        updateAllMobESP()
    end
})

Tabs.PlayerSettings:AddToggle("MobNameESP", {
    Title = "📛 Monster Name ESP",
    Default = false,
    Callback = function(state)
        mobNameEspEnabled = state
        updateAllMobESP()
    end
})

Tabs.PlayerSettings:AddSection("🚶 Walk-Speed / 🚀 Jump-Height:")
Tabs.PlayerSettings:AddSlider("WalkSpeed", {
    Title = "🚶 Player Walk Speed",
    Description = "Adjust your movement speed",
    Default = 25,
    Min = 25,
    Max = 200,
    Rounding = 0,
    Callback = function(value)
        Options.WalkSpeed = { Value = value }
        SetWalkSpeed(value)
    end
})

Tabs.PlayerSettings:AddSlider("JumpHeight", {
    Title = "🚀 Player Jump Height",
    Description = "Adjust how high you jump",
    Default = 75,
    Min = 75,
    Max = 300,
    Rounding = 0,
    Callback = function(value)
        SetJumpHeight(value)
    end
})

Tabs.PlayerSettings:AddSection("🔍 No-Clip:")
Tabs.PlayerSettings:AddToggle("Noclip", {
    Title = "🔍 Noclip",
    Default = false,
    Callback = function(state)
        SetNoclip(state)
    end
})

---------------------------------------------------------
-- QUICK URLS TAB
---------------------------------------------------------
Tabs.Qlinks:AddSection("🔗 Quick Launch Hubs:")

local OtherHubs = {
    ["JDRS World Zero"] = "https://raw.githubusercontent.com/justdoingrandomstuff/World-Zero/main/autofarm",
}
for name, url in pairs(OtherHubs) do
    Tabs.Qlinks:AddButton({
        Title = name,
        Callback = function()
            Notify("Launching " .. name, "Successfully launched " .. name)
            task.wait(2)
            safeLoad(url, name)
        end
    })
end

---------------------------------------------------------
-- DEV SETTINGS TAB
---------------------------------------------------------
Tabs.DevLinks:AddSection("🔗 Dev Quick Links:")
local DevHubs = {
    ["Dex"] = "https://raw.githubusercontent.com/peyton2465/Dex/master/out.lua",
    ["Clipboard Spy"] = "https://raw.githubusercontent.com/tinywolf420/World-Zero-Hub/refs/heads/Key/Clipboard.lua",
}
for name, url in pairs(DevHubs) do
    Tabs.DevLinks:AddButton({
        Title = name,
        Callback = function()
            Notify("Launching " .. name, "Successfully launched " .. name)
            task.wait(2)
            safeLoad(url, name)
        end
    })
end

Tabs.DevLinks:AddSection("🔗 Older Links:")
local OldLinks = {
    ["Remote Spy v1"] = "https://raw.githubusercontent.com/tinywolf420/World-Zero-Hub/refs/heads/Key/RemoteSpy",
    ["Remote Spy Lite"] = "https://raw.githubusercontent.com/KGuestCheatsJReal/ComeBack/refs/heads/main/RSPY",
}
for name, url in pairs(OldLinks) do
    Tabs.DevLinks:AddButton({
        Title = name,
        Callback = function()
            Notify("Launching " .. name, "Successfully launched " .. name)
            task.wait(2)
            safeLoad(url, name)
        end
    })
end


---------------------------------------------------------
-- SETTINGS TAB
---------------------------------------------------------
Tabs.Settings:AddSection("Server Settings:")
Tabs.Settings:AddButton({
    Title = "♻️ World Zero Reconnection",
    Callback = function()
        Notify("Reconnecting...", "Rejoining World Zero")
        -- ✅ queue script BEFORE teleport
        QueueHub()
        task.wait(1)
        TeleportService:TeleportToPlaceInstance(
            game.PlaceId,
            game.JobId,
            player
        )
    end
})
Tabs.Settings:AddButton({
    Title = "♻️ Reload Hub (5 Second Delay)",
    Callback = function()
        Notify("Destroying Current Hub", "Selected For Quick Reload...")
        Notify("Reloading Hub", "Reloading World Zero Hub...")
        task.wait(5)
        -- destroy current UI
        Fluent:Destroy()
        task.wait(0.5)
        -- reload hub directly
        pcall(function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/tinywolf420/World-Zero-Hub/refs/heads/main/WorldZeroHub"))()
        end)
    end
})

Tabs.Settings:AddButton({
    Title = "❌ Close Hub",
    Callback = function()
        Notify("Closed Hub", "Successfully closed hub")
        task.wait(1)
        Fluent:Destroy()
    end
})
Tabs.Settings:AddSection("📝 Credits:")
Tabs.Settings:AddParagraph({
    Title = "World Zero 🚀 Hub v2.4",
    Content = "Made by 42Oreobun"
})


---------------------------------------------------------
-- SETTINGS TAB — AUTO EXECUTE TOGGLE
---------------------------------------------------------

Tabs.Settings:AddSection("⚙️ Script Behavior:")
---------------------------------------------------------
-- SAVE MANAGER + INTERFACE MANAGER
---------------------------------------------------------
SaveManager:IgnoreThemeSettings()
SaveManager:SetIgnoreIndexes({})

InterfaceManager:SetFolder("WorldZeroLauncher")
SaveManager:SetFolder("WorldZeroLauncher/Configs")

InterfaceManager:BuildInterfaceSection(Tabs.Settings)
SaveManager:BuildConfigSection(Tabs.Settings)

Window:SelectTab(1)

--[[
Fluent:Notify({
    Title = "Loaded successfully.",
    Content = "World Zero LauncherLoaded successfully.",
    Duration = 5
})
task.wait(5)
Fluent:Notify({
    Title = "Much Love From 42Oreobun, Thank you for the Support",
    Content = "Thank you for the Support! <3",
    Duration = 5
})]]

SaveManager:LoadAutoloadConfig({})

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