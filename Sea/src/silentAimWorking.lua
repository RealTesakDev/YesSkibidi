local startTime = tick()

local gmt = getrawmetatable(game)
setreadonly(gmt, false)

local nameCall = gmt.__namecall

local Camera = game.Workspace.CurrentCamera
local Mouse = game.Players.LocalPlayer:GetMouse()
local plrs = game:GetService("Players")
local lplr = plrs.LocalPlayer

local function getClosestPlayerToMouse()
    local closestPlayer = nil
    local shortestDistance = math.huge

    for _, player in pairs(game.Workspace:GetChildren()) do
        if player:IsA("Model") and player:FindFirstChild("Head") and player.Name ~= lplr.Name then
            local head = player.Head
            local headScreenPos, onScreen = Camera:WorldToScreenPoint(head.Position)

            if onScreen then
                local mousePos = Vector2.new(Mouse.X, Mouse.Y)
                local distance = (mousePos - Vector2.new(headScreenPos.X, headScreenPos.Y)).Magnitude
                
                if distance < shortestDistance then
                    closestPlayer = player
                    shortestDistance = distance
                end
            end
        end
    end

    return closestPlayer
end

local function shootClosestPlayer()
    local closestPlayer = getClosestPlayerToMouse()
    if closestPlayer then
        if not lplr.Character:FindFirstChild("Pistola") then
            return
        end
        local args = {
            [1] = closestPlayer.Humanoid,
            [2] = closestPlayer.Head,
            [3] = Vector3.new(closestPlayer.Head.Position.X, closestPlayer.Head.Position.Y, closestPlayer.Head.Position.Z)
        }
        
        lplr.Character.Pistola.EventsFolder.InflictTarget:FireServer(unpack(args))
    end
end

gmt.__namecall = newcclosure(function(self, ...)
    local method = getnamecallmethod()
    if tostring(method) == "FireServer" and tostring(self) == "Fire" then
        print("Sigma")
        shootClosestPlayer()
    end
    return nameCall(self, ...)
end)

local endTime = tick()
local elapsedTime = endTime - startTime
print(string.format("Silent Aim loaded in %.10f ms", elapsedTime * 1000))