local SilentHitmarker = Instance.new("Sound")
SilentHitmarker.Name = "SilentHitmarker"
SilentHitmarker.Parent = game:GetService("SoundService")
SilentHitmarker.Volume = 5
local SilentPlayHitmarker = false

local SilentTarget
local SilentTargetPart

local function GetTargetPart(character)
    if SilentAim.TargetPart == "Random" then
        local validPartsInCharacter = {}
        for _, partName in ipairs(SilentAim.ValidParts) do
            local part = character:FindFirstChild(partName)
            if part then
                table.insert(validPartsInCharacter, part)
            end
        end
        return #validPartsInCharacter > 0 and validPartsInCharacter[math.random(1, #validPartsInCharacter)] or nil
    else
        return character:FindFirstChild(SilentAim.TargetPart)
    end
end

local function GetScalingMultiplier()
    local baseMultiplier = (100 - SilentAim.HitChance)
    return baseMultiplier * (0.5 + math.random())
end

local function GetSilentTarget()
    local ClosestPlayer
    local ShortestDistance = math.huge
    local MousePos = UserInputService:GetMouseLocation()

    for _, Player in pairs(Players:GetPlayers()) do
        if Player == LocalPlayer or not Player.Character then 
            continue 
        end

        local TargetPart = GetTargetPart(Player.Character)
        if not TargetPart then 
            continue 
        end

        local Position, IsVisible = Camera:WorldToViewportPoint(TargetPart.Position)
        if not IsVisible then 
            continue 
        end

        local Distance = (Vector2.new(Position.X, Position.Y) - MousePos).Magnitude
        if Distance <= SilentAim.FOV and Distance < ShortestDistance then
            ClosestPlayer = Player
            ShortestDistance = Distance
            SilentTargetPart = TargetPart
        end
    end

    return ClosestPlayer
end

spawn(function()
    while task.wait() do

        if SilentAim.Enabled then
            SilentTarget = GetSilentTarget()
            if not SilentTarget then
                SilentTargetPart = nil
            end
        else
            SilentTarget = nil
            SilentTargetPart = nil
        end

        if SilentPlayHitmarker and SilentAim.HitSound.Enabled then
            local HitmarkerClone = SilentHitmarker:Clone()
            HitmarkerClone.SoundId = "rbxassetid://" .. SilentAim.HitSound.AssetID
            HitmarkerClone.Parent = game:GetService("SoundService")
            HitmarkerClone:Play()
            game.Debris:AddItem(HitmarkerClone, 2)
            SilentPlayHitmarker = false
        end
    end
end)

local SilentOldNameCall
SilentOldNameCall = hookmetamethod(game, '__namecall', function(Self, ...)
    local Args = {...}
    local Method = getnamecallmethod()

    if SilentAim.Enabled and Self == workspace and Method == "FindPartOnRayWithIgnoreList" and getcallingscript().Name == "Client" then
        if SilentTarget and SilentTargetPart then
            local HitRoll = math.random(1, 100)

            if HitRoll <= SilentAim.HitChance then

                if SilentAim.Wallbang then
                    SilentPlayHitmarker = true
                    Args[1] = Ray.new(SilentTargetPart.Position + SilentTargetPart.CFrame.LookVector, -SilentTargetPart.CFrame.LookVector)
                else
                    SilentPlayHitmarker = true
                    Args[1] = Ray.new(Camera.CFrame.p, (CFrame.new(Camera.CFrame.p, SilentTargetPart.Position).LookVector) * 1000000)
                end
            else

                local ScaledPosition = SilentTargetPart.Position + Vector3.new(
                    math.random(-GetScalingMultiplier(), GetScalingMultiplier()),
                    math.random(-GetScalingMultiplier(), GetScalingMultiplier()),
                    math.random(-GetScalingMultiplier(), GetScalingMultiplier())
                )
                Args[1] = Ray.new(Camera.CFrame.p, (ScaledPosition - Camera.CFrame.p).Unit * 1000000)
            end
            return SilentOldNameCall(Self, unpack(Args))
        end
    end

    return SilentOldNameCall(Self, ...)
end)
