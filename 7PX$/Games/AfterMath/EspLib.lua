local ESP = {}
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local DebugEnabled = true
local lighting = game:GetService("Lighting")


-- Constants for size limits
local MIN_BOX_SIZE = Vector2.new(20, 50) -- Minimum box size
local MAX_BOX_SIZE = Vector2.new(200, 400) -- Maximum box size
local MIN_HEALTH_BAR_WIDTH = 4 -- Minimum health bar width
local MAX_HEALTH_BAR_WIDTH = 6 -- Maximum health bar width
local MIN_HEALTH_BAR_HEIGHT = 60 -- Minimum health bar height
local MAX_HEALTH_BAR_HEIGHT = 400 -- Maximum health bar height

-- Previous lighting settings remain the same...
lighting.Brightness = 2
lighting.GlobalShadows = false
lighting.Ambient = Color3.new(1, 1, 1)
lighting.OutdoorAmbient = Color3.new(1, 1, 1)
lighting.FogEnd = 1e6
lighting.FogStart = 1e6
lighting.ColorShift_Bottom = Color3.new(1, 1, 1)
lighting.ColorShift_Top = Color3.new(1, 1, 1)

-- Helper function to clamp a number between min and max
local function clamp(value, min, max)
    return math.min(math.max(value, min), max)
end

-- Helper function to clamp a Vector2 between min and max Vector2s
local function clampVector2(vec, minVec, maxVec)
    return Vector2.new(
        clamp(vec.X, minVec.X, maxVec.X),
        clamp(vec.Y, minVec.Y, maxVec.Y)
    )
end

local function DebugPrint(message)
    if DebugEnabled then
        print("[ESP Debug]: " .. message)
    end
end

function ESP:ToggleDebug(state)
    DebugEnabled = state
end

-- Function to create text with outlines
local function createOutlinedText()
    local textData = {}
    
    -- Create outline objects
    textData.outlines = {
        Drawing.new("Text"), -- top left
        Drawing.new("Text"), -- top
        Drawing.new("Text"), -- top right
        Drawing.new("Text"), -- right
        Drawing.new("Text"), -- bottom right
        Drawing.new("Text"), -- bottom
        Drawing.new("Text"), -- bottom left
        Drawing.new("Text")  -- left
    }
    
    for _, outline in ipairs(textData.outlines) do
        outline.Color = Color3.new(0, 0, 0)
        outline.Size = 12
        outline.Center = true
        outline.Visible = false
    end
    
    -- Create main text
    textData.text = Drawing.new("Text")
    textData.text.Size = 12
    textData.text.Center = true
    textData.text.Visible = false
    
    return textData
end

-- Function to update outlined text
local function updateOutlinedText(textData, position, content, color)
    local outlineOffsets = {
        Vector2.new(-1, -1), Vector2.new(0, -1), Vector2.new(1, -1),
        Vector2.new(1, 0), Vector2.new(1, 1), Vector2.new(0, 1),
        Vector2.new(-1, 1), Vector2.new(-1, 0)
    }
    
    for i, outline in ipairs(textData.outlines) do
        outline.Text = content
        outline.Position = position + outlineOffsets[i]
        outline.Visible = true
    end
    
    textData.text.Text = content
    textData.text.Position = position
    textData.text.Color = color
    textData.text.Visible = true
end

-- Function to get bounds of all character parts
local function getCharacterBounds(model, camera)
    local worldChar = model:FindFirstChild("WorldCharacter")
    if not worldChar then return nil end
    
    local minX, minY = math.huge, math.huge
    local maxX, maxY = -math.huge, -math.huge
    
    -- List of all body parts to check
    local bodyParts = {
        worldChar:FindFirstChild("Head"),
        worldChar:FindFirstChild("LeftFoot"),
        worldChar:FindFirstChild("LeftLowerArm"),
        worldChar:FindFirstChild("LeftHand"),
        worldChar:FindFirstChild("LeftLowerLeg"),
        worldChar:FindFirstChild("LeftUpperArm"),
        worldChar:FindFirstChild("LeftUpperLeg"),
        worldChar:FindFirstChild("LowerTorso"),
        worldChar:FindFirstChild("RightFoot"),
        worldChar:FindFirstChild("RightHand"),
        worldChar:FindFirstChild("RightLowerArm"),
        worldChar:FindFirstChild("RightLowerLeg"),
        worldChar:FindFirstChild("RightUpperLeg"),
        worldChar:FindFirstChild("RightUpperArm"),
        worldChar:FindFirstChild("UpperTorso"),
        worldChar:FindFirstChild("HumanoidRootPart")
    }
    
    for _, part in ipairs(bodyParts) do
        if part then
            local cf = part.CFrame
            local size = part.Size
            local corners = {
                cf * CFrame.new(size.X/2, size.Y/2, size.Z/2),
                cf * CFrame.new(-size.X/2, size.Y/2, size.Z/2),
                cf * CFrame.new(size.X/2, -size.Y/2, size.Z/2),
                cf * CFrame.new(-size.X/2, -size.Y/2, size.Z/2),
                cf * CFrame.new(size.X/2, size.Y/2, -size.Z/2),
                cf * CFrame.new(-size.X/2, size.Y/2, -size.Z/2),
                cf * CFrame.new(size.X/2, -size.Y/2, -size.Z/2),
                cf * CFrame.new(-size.X/2, -size.Y/2, -size.Z/2)
            }
            
            for _, corner in ipairs(corners) do
                local screenPos = camera:WorldToViewportPoint(corner.Position)
                if screenPos.Z > 0 then
                    minX = math.min(minX, screenPos.X)
                    minY = math.min(minY, screenPos.Y)
                    maxX = math.max(maxX, screenPos.X)
                    maxY = math.max(maxY, screenPos.Y)
                end
            end
        end
    end

    local size = Vector2.new(maxX - minX, maxY - minY)
    -- Clamp the size to our minimum and maximum bounds
    size = clampVector2(size, MIN_BOX_SIZE, MAX_BOX_SIZE)
    
    -- Adjust position to maintain center point when clamping size
    local center = Vector2.new(minX + (maxX - minX)/2, minY + (maxY - minY)/2)
    local topLeft = Vector2.new(
        center.X - size.X/2,
        center.Y - size.Y/2
    )
    
    return size, topLeft
end

function ESP:CreateESPForWorldCharacter(playerModel)
    local espData = {
        Connections = {} -- Store connections for cleanup
    }
    
    -- Create outlined texts
    espData.nameText = createOutlinedText()
    espData.distanceText = createOutlinedText()
    espData.weaponText = createOutlinedText()
    
    -- Box with outline
    espData.BoxOutline = Drawing.new("Square")
    espData.BoxOutline.Color = Color3.new(0, 0, 0)
    espData.BoxOutline.Thickness = 3
    espData.BoxOutline.Filled = false

    espData.Box = Drawing.new("Square")
    espData.Box.Color = Color3.new(1, 0, 0)
    espData.Box.Thickness = 1
    espData.Box.Filled = false

    -- Health bar with outline
    espData.HealthBarOutline = Drawing.new("Square")
    espData.HealthBarOutline.Color = Color3.new(0, 0, 0)
    espData.HealthBarOutline.Thickness = 3
    espData.HealthBarOutline.Filled = false

    espData.HealthBarBG = Drawing.new("Square")
    espData.HealthBarBG.Color = Color3.new(0, 0, 0)
    espData.HealthBarBG.Thickness = 1
    espData.HealthBarBG.Filled = true

    espData.HealthBar = Drawing.new("Square")
    espData.HealthBar.Thickness = 1
    espData.HealthBar.Filled = true

    espData.Model = playerModel
    espData.IsVisible = false

    -- Add Ancestor connections to detect when model or WorldCharacter is removed
    espData.Connections.ancestryChanged = playerModel.AncestryChanged:Connect(function(_, parent)
        if not parent then
            self:PlayerRemoving(playerModel)
        end
    end)

    local worldChar = playerModel:FindFirstChild("WorldCharacter")
    if worldChar then
        espData.Connections.worldCharAncestryChanged = worldChar.AncestryChanged:Connect(function(_, parent)
            if not parent then
                self:PlayerRemoving(playerModel)
            end
        end)
    end

    DebugPrint("ESP created for player: " .. playerModel.Name)
    return espData
end

function ESP:UpdateESP(espData)
    local playerModel = espData.Model
    
    if not playerModel or not playerModel.Parent then
        self:PlayerRemoving(playerModel)
        return
    end
    
    local worldCharacter = playerModel:FindFirstChild("WorldCharacter")
    local humanoid = playerModel:FindFirstChild("Humanoid")

    if worldCharacter then
        local rootPart = worldCharacter:FindFirstChild("HumanoidRootPart")
        
        if rootPart then
            local camera = workspace.CurrentCamera
            local screenPos, onScreen = camera:WorldToViewportPoint(rootPart.Position)
            espData.IsVisible = onScreen

            if onScreen then
                -- Calculate distance
                local distance = (camera.CFrame.Position - rootPart.Position).Magnitude
                local distanceText = string.format("%.1fm", distance)
                
                -- Get box size and position using all body parts
                local boxSize, boxTopLeft = getCharacterBounds(playerModel, camera)
                if not boxSize then return end
                
                -- Update box and outline with clamped size
                espData.BoxOutline.Size = boxSize
                espData.BoxOutline.Position = boxTopLeft
                espData.BoxOutline.Visible = true
                
                espData.Box.Size = boxSize
                espData.Box.Position = boxTopLeft
                espData.Box.Visible = true

                -- Calculate health percentage and color
                local healthPercentage = humanoid and (humanoid.Health / humanoid.MaxHealth) or 1
                local healthColor = Color3.new(1 - healthPercentage, healthPercentage, 0)
                
                -- Update health bar with clamped size
                local healthBarWidth = clamp(boxSize.X * 0.05, MIN_HEALTH_BAR_WIDTH, MAX_HEALTH_BAR_WIDTH)
                local healthBarHeight = clamp(boxSize.Y, MIN_HEALTH_BAR_HEIGHT, MAX_HEALTH_BAR_HEIGHT)
                local healthBarPos = Vector2.new(boxTopLeft.X - healthBarWidth - 2, boxTopLeft.Y)

                espData.HealthBarOutline.Size = Vector2.new(healthBarWidth + 2, healthBarHeight + 2)
                espData.HealthBarOutline.Position = Vector2.new(healthBarPos.X - 1, healthBarPos.Y - 1)
                espData.HealthBarOutline.Visible = true

                espData.HealthBarBG.Size = Vector2.new(healthBarWidth, healthBarHeight)
                espData.HealthBarBG.Position = healthBarPos
                espData.HealthBarBG.Visible = true

                espData.HealthBar.Size = Vector2.new(healthBarWidth, healthBarHeight * healthPercentage)
                espData.HealthBar.Position = Vector2.new(healthBarPos.X, healthBarPos.Y + healthBarHeight * (1 - healthPercentage))
                espData.HealthBar.Color = healthColor
                espData.HealthBar.Visible = true

                -- Update text positions based on clamped box size
                updateOutlinedText(
                    espData.nameText,
                    Vector2.new(boxTopLeft.X + boxSize.X/2, boxTopLeft.Y - 20),
                    playerModel.Name,
                    healthColor
                )
                
                -- Try to find equipped weapon (adjust this based on your game's weapon system)
                local weaponName = "None"
                local inventoryItem = worldCharacter:FindFirstChild("InventoryItem")
                if inventoryItem and inventoryItem.Value then
                    local itemName = inventoryItem.Value
                    -- Look for the object value with the same name as InventoryItem's value
                    local weaponObject = worldCharacter:FindFirstChild(itemName)
                    if weaponObject and weaponObject:IsA("ObjectValue") and weaponObject.Value then
                        weaponName = weaponObject.Value
                    end
                end
                
                -- Update weapon text above distance
                updateOutlinedText(
                    espData.weaponText,
                    Vector2.new(boxTopLeft.X + boxSize.X/2, boxTopLeft.Y + boxSize.Y + 5),
                    weaponName,
                    Color3.new(1, 1, 1)
                )
                
                -- Update distance text below weapon
                updateOutlinedText(
                    espData.distanceText,
                    Vector2.new(boxTopLeft.X + boxSize.X/2, boxTopLeft.Y + boxSize.Y + 25),
                    distanceText,
                    Color3.new(1, 1, 1)
                )

                -- Update health bar with outline
                local healthBarWidth = 4
                local healthBarHeight = boxSize.Y
                local healthBarPos = Vector2.new(boxTopLeft.X - healthBarWidth - 2, boxTopLeft.Y)

                espData.HealthBarOutline.Size = Vector2.new(healthBarWidth + 2, healthBarHeight + 2)
                espData.HealthBarOutline.Position = Vector2.new(healthBarPos.X - 1, healthBarPos.Y - 1)
                espData.HealthBarOutline.Visible = true

                espData.HealthBarBG.Size = Vector2.new(healthBarWidth, healthBarHeight)
                espData.HealthBarBG.Position = healthBarPos
                espData.HealthBarBG.Visible = true

                espData.HealthBar.Size = Vector2.new(healthBarWidth, healthBarHeight * healthPercentage)
                espData.HealthBar.Position = Vector2.new(healthBarPos.X, healthBarPos.Y + healthBarHeight * (1 - healthPercentage))
                espData.HealthBar.Color = healthColor
                espData.HealthBar.Visible = true

            else
                espData.BoxOutline.Visible = false
                espData.Box.Visible = false
                espData.HealthBarOutline.Visible = false
                espData.HealthBarBG.Visible = false
                espData.HealthBar.Visible = false
                
                -- Hide all text outlines
                for _, outline in ipairs(espData.nameText.outlines) do
                    outline.Visible = false
                end
                espData.nameText.text.Visible = false
                
                for _, outline in ipairs(espData.distanceText.outlines) do
                    outline.Visible = false
                end
                espData.distanceText.text.Visible = false
                
                for _, outline in ipairs(espData.weaponText.outlines) do
                    outline.Visible = false
                end
                espData.weaponText.text.Visible = false
            end
        else
            DebugPrint("No HumanoidRootPart found for player: " .. playerModel.Name)
            self:PlayerRemoving(playerModel)
        end
    else
        DebugPrint("WorldCharacter not found for player: " .. playerModel.Name)
    end
end

function ESP:Enable()
    self.ESPData = {}
    self.Connections = {}

    -- Monitor workspace for model removals
    self.Connections.workspaceRemoval = workspace.ChildRemoved:Connect(function(child)
        if self.ESPData[child] then
            self:PlayerRemoving(child)
        end
    end)

    self.Connections.renderStepped = RunService.RenderStepped:Connect(function()
        local notRenderedCount = 0
        local renderedCount = 0

        for model, espData in pairs(self.ESPData) do
            if not model or not model.Parent then
                self:PlayerRemoving(model)
                continue
            end
        end

        for _, player in pairs(Players:GetPlayers()) do
            local playerModel = workspace:FindFirstChild(player.Name)
            if playerModel and playerModel:FindFirstChild("WorldCharacter") then
                if not self.ESPData[playerModel] then
                    self.ESPData[playerModel] = self:CreateESPForWorldCharacter(playerModel)
                end
                self:UpdateESP(self.ESPData[playerModel])
                renderedCount = renderedCount + 1
            else
                notRenderedCount = notRenderedCount + 1
            end
        end

        DebugPrint("Players rendered: " .. renderedCount .. ", Players not rendered: " .. notRenderedCount)
        wait(2)
    end)

    DebugPrint("ESP Enabled.")
end

function ESP:Disable()
    -- Disconnect all main connections
    for _, connection in pairs(self.Connections) do
        if connection then
            connection:Disconnect()
        end
    end
    self.Connections = {}

    -- Clean up all ESP data
    for model, _ in pairs(self.ESPData) do
        self:PlayerRemoving(model)
    end

    self.ESPData = {}
    DebugPrint("ESP Disabled.")
end

function ESP:PlayerRemoving(playerModel)
    if not self.ESPData[playerModel] then return end

    local espData = self.ESPData[playerModel]
    
    -- Disconnect all connections for this ESP
    for _, connection in pairs(espData.Connections) do
        if connection then
            connection:Disconnect()
        end
    end

    -- Remove all drawings
    local drawingsToRemove = {
        espData.Box,
        espData.BoxOutline,
        espData.HealthBarOutline,
        espData.HealthBarBG,
        espData.HealthBar
    }
    
    for _, drawing in ipairs(drawingsToRemove) do
        if drawing then
            drawing:Remove()
        end
    end

    -- Remove text objects
    local textObjects = {espData.nameText, espData.distanceText, espData.weaponText}
    for _, textData in ipairs(textObjects) do
        if textData then
            for _, outline in ipairs(textData.outlines) do
                if outline then
                    outline:Remove()
                end
            end
            if textData.text then
                textData.text:Remove()
            end
        end
    end

    self.ESPData[playerModel] = nil
    DebugPrint("ESP removed for player: " .. (playerModel.Name or "Unknown"))
end

-- Enable ESP
ESP:Enable()

-- Toggle debugging
ESP:ToggleDebug(true)

return ESP
