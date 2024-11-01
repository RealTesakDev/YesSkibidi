local Camera = game.Workspace.CurrentCamera
local Mouse = game.Players.LocalPlayer:GetMouse()
local plrs = game:GetService("Players")
local lplr = plrs.LocalPlayer

local toggleKey = Enum.KeyCode.F
local isEnabled = false

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

game:GetService("UserInputService").InputBegan:Connect(function(input)
    if input.KeyCode == toggleKey then
        isEnabled = not isEnabled
        print("Silent Aim: " .. tostring(isEnabled))
    end
end)

game:GetService("RunService").RenderStepped:Connect(function()
    task.wait(0.05)
    local closestPlayer = getClosestPlayerToMouse()
    if isEnabled then
        if closestPlayer then
            if not lplr.Character:FindFirstChild("Fuzil") then
                return
            end
            local args = {
                [1] = closestPlayer.Humanoid,
                [2] = closestPlayer.Head,
                [3] = Vector3.new(closestPlayer.Head.Position.X, closestPlayer.Head.Position.Y, closestPlayer.Head.Position.Z)
            }
            
            lplr.Character.Fuzil.EventsFolder.InflictTarget:FireServer(unpack(args))
        end
    end
end)


