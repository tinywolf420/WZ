getgenv().autoMob = false
getgenv().autoMobDetect = 0.001

local AutoMob = {}

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer

local currentMob = nil
local lastSwitch = 0

function AutoMob.getClosestMob()
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

function AutoMob.start()
    if AutoMob.thread then return end

    AutoMob.thread = task.spawn(function()
        while getgenv().autoMob do
            local char = player.Character
            local hrp = char and char:FindFirstChild("HumanoidRootPart")
            local hum = char and char:FindFirstChildOfClass("Humanoid")

            if hrp and hum then
                local now = tick()

                if not currentMob or not currentMob.Parent or now - lastSwitch > 0.15 then
                    currentMob = AutoMob.getClosestMob()
                    lastSwitch = now
                end

                local mob = currentMob
                if mob then
                    local targetPos = mob.Position + Vector3.new(0, 3, 4)

                    hum:ChangeState(Enum.HumanoidStateType.Physics)
                    hrp.AssemblyLinearVelocity = Vector3.zero
                    hrp.AssemblyAngularVelocity = Vector3.zero

                    hrp.CFrame = CFrame.new(targetPos)
                    hrp.CFrame = CFrame.lookAt(hrp.Position, mob.Position)

                    pcall(function()
                        ReplicatedStorage.Remotes.ItemUsed:FireServer("Attack")
                    end)
                end
            end

            task.wait(getgenv().autoMobDetect)
        end

        AutoMob.thread = nil
    end)
end

return AutoMob
