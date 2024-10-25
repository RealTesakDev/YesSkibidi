local UserInputService = game:GetService("UserInputService")
local VirtualInputManager = game:GetService("VirtualInputManager")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera
local PredictionFactor = 0.1  -- Adjust this for better prediction
local highlightEnabled = false -- Toggle state for highlighting

-- Create a prediction marker part
local predictionMarker = Instance.new("Part")
predictionMarker.Size = Vector3.new(0.5, 0.5, 0.5)  -- 1 stud cube
predictionMarker.Color = Color3.fromRGB(255, 0, 0)  -- Red color
predictionMarker.Material = Enum.Material.Neon
predictionMarker.Anchored = true
predictionMarker.CanCollide = false
predictionMarker.Transparency = 0.5
predictionMarker.Parent = workspace
predictionMarker.Name = "PredictionMarker"

-- Function to add or remove a highlight from an object
local function toggleHighlight(object, enabled)
    if enabled then
        if not object:FindFirstChild("Highlight") then
            local highlight = Instance.new("Highlight")
            highlight.Parent = object
            highlight.FillColor = Color3.fromRGB(255, 101, 27)  -- Customize color as needed
            highlight.OutlineColor = Color3.new(1, 1, 1)  -- White outline
        end
    else
        local highlight = object:FindFirstChild("Highlight")
        if highlight then
            highlight:Destroy()
        end
    end
end

-- Function to highlight players in the workspace
local function highlightPlayers()
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            toggleHighlight(player.Character, highlightEnabled)
        end
    end
end

-- Function to update weapon highlights in viewmodel
local function checkAndHighlightViewmodel()
    local viewmodel = workspace.Camera:FindFirstChild("Viewmodel")
    if viewmodel then
        local ak47H = viewmodel:FindFirstChild("Ak47H")
        local ak47 = viewmodel:FindFirstChild("Ak47")
        
        if ak47H then
            toggleHighlight(ak47H, highlightEnabled)
        end
        if ak47 then
            toggleHighlight(ak47, highlightEnabled)
        end
    end
end

-- Function to get the nearest "John" instance with a "Mask" child
local function getNearestJohnTorso()
    local closestJohn = nil
    local closestDistance = math.huge
    local mousePosition = UserInputService:GetMouseLocation()

    for _, obj in pairs(workspace:GetChildren()) do
        if obj:IsA("Model") and obj:FindFirstChild("Mask") and obj:FindFirstChild("Torso") then
            local torso = obj.Torso
            local distanceToTorso = (LocalPlayer.Character.HumanoidRootPart.Position - torso.Position).magnitude
            
            -- Calculate distance from mouse to torso
            local viewportPoint = Camera:WorldToScreenPoint(torso.Position)
            local distanceToMouse = (Vector2.new(mousePosition.X, mousePosition.Y) - Vector2.new(viewportPoint.X, viewportPoint.Y)).magnitude
            
            -- Determine if this John is closer to the mouse
            if distanceToMouse < closestDistance then
                closestJohn = obj
                closestDistance = distanceToMouse
            end
        end
    end
    
    return closestJohn
end

-- Function to calculate the predicted position of the target's torso based on velocity
local function getPredictedPosition(target)
    if target and target:FindFirstChild("Torso") and target:FindFirstChild("HumanoidRootPart") then
        local torso = target.Torso
        local velocity = target.HumanoidRootPart.Velocity
        
        -- Only apply velocity prediction for the x and z axes
        local predictedX = torso.Position.X + (velocity.X * PredictionFactor)
        local predictedY = torso.Position.Y  -- Keep Y-axis as-is to avoid offset
        local predictedZ = torso.Position.Z + (velocity.Z * PredictionFactor)
        
        return Vector3.new(predictedX, predictedY, predictedZ)
    end
    return nil
end

-- Function to make the camera look at the predicted target position without changing the player's view
local function lookAtPredictedPosition(predictedPosition)
    if predictedPosition then
        -- Calculate the new CFrame for the camera without changing the player's view
        local direction = (predictedPosition - Camera.CFrame.Position).unit
        local newCFrame = CFrame.new(Camera.CFrame.Position, Camera.CFrame.Position + direction)
        Camera.CFrame = newCFrame
    end
end

-- Function to simulate a right mouse hold and left click
local function simulateMouseClick()
    local mouseLocation = UserInputService:GetMouseLocation()
    
    -- Hold Right Mouse (M2)
    VirtualInputManager:SendMouseButtonEvent(mouseLocation.X, mouseLocation.Y, 1, true, game, 0)
    
    wait(0.2)  -- Small delay to stabilize the hold
    
    -- Simulate Left Click
    VirtualInputManager:SendMouseButtonEvent(mouseLocation.X, mouseLocation.Y, 0, true, game, 1)
    wait(0.1)
    VirtualInputManager:SendMouseButtonEvent(mouseLocation.X, mouseLocation.Y, 0, false, game, 1)
    
    -- Release Right Mouse (M2)
    VirtualInputManager:SendMouseButtonEvent(mouseLocation.X, mouseLocation.Y, 1, false, game, 0)
end

-- Toggle highlight state with a keybind (H key)
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed then
        if input.KeyCode == Enum.KeyCode.H then
            highlightEnabled = not highlightEnabled
            highlightPlayers()  -- Highlight players when toggled
            checkAndHighlightViewmodel()
        elseif input.KeyCode == Enum.KeyCode.E then
            local target = getNearestJohnTorso()
            if target then
                local predictedPosition = getPredictedPosition(target)
                
                -- Store current camera CFrame before changing it
                local originalCameraCFrame = Camera.CFrame
                
                lookAtPredictedPosition(predictedPosition)
                simulateMouseClick()
                
                -- Reset camera back to original view after the click
                Camera.CFrame = originalCameraCFrame
                
                -- Update prediction marker position
                if predictedPosition then
                    predictionMarker.CFrame = CFrame.new(predictedPosition)
                    predictionMarker.Transparency = 0.5
                else
                    predictionMarker.Transparency = 1
                end
            else
                predictionMarker.Transparency = 1
            end
        end
    end
end)

-- Update highlights and prediction visualization periodically
game:GetService("RunService").Stepped:Connect(function()
    if highlightEnabled then
        highlightPlayers()  -- Keep updating player highlights
        checkAndHighlightViewmodel()  -- Update weapon highlights
    end
    
    -- Update prediction marker
    local target = getNearestJohnTorso()
    if target then
        local predictedPosition = getPredictedPosition(target)
        if predictedPosition then
            predictionMarker.CFrame = CFrame.new(predictedPosition)
            predictionMarker.Transparency = 0.5
        else
            predictionMarker.Transparency = 1
        end
    else
        predictionMarker.Transparency = 1
    end
end)