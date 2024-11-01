--<< Timeing Start >>--
local startTime = tick()



--<< Advanced Variables >>--
local HumanoidOld
local gmt = getrawmetatable(game)
setreadonly(gmt, false)
local nameCall = gmt.__namecall



--<< Variables >>--
local Script = {
    Author = "Sea And 7PX$",
    Watermark = "SigmaGuard.lua",

    Functions = {}
}

-- Base --
local plrs = game.Players
local plyers = game:GetService("Players")
local lplr = plyers.LocalPlayer
local Camera = game.Workspace.CurrentCamera
local Mouse = game.Players.LocalPlayer:GetMouse()
local humanoid = lplr.Character.Humanoid

-- Script --
local guns = {"Fuzil", "Pistola"}  -- List of possible gun names
local selectedGunName = guns[1]  -- Default selection
local selectedGun



--<< Anti Cheat Bypass >>--

HumanoidOld = hookmetamethod(game,"__index",function(self,key)
    if self == humanoid then
        if key == "WalkSpeed" then
            return 16
        elseif key == "JumpPower" then 
            return 20
        end
    end
    return HumanoidOld(self,key)
end)

local endTime = tick()
local elapsedTime = endTime - startTime



--<< Sense Lib >>--
local Sense = loadstring(game:HttpGet('https://raw.githubusercontent.com/shlexware/Sirius/request/library/sense/source.lua'))()

Sense.teamSettings.enemy.enabled = true
Sense.sharedSettings.textSize = 12
Sense.sharedSettings.textFont = 2
Sense.sharedSettings.limitDistance = false



--<< Library >>--
local repo = 'https://raw.githubusercontent.com/violin-suzutsuki/LinoriaLib/main/'
local Library = loadstring(game:HttpGet(repo .. 'Library.lua'))()
local ThemeManager = loadstring(game:HttpGet(repo .. 'addons/ThemeManager.lua'))()
local SaveManager = loadstring(game:HttpGet(repo .. 'addons/SaveManager.lua'))()

Library:Notify(string.format("AntiCheat Bypassed in %.2f ms", elapsedTime * 1000), 10) -- Notified fast as possible since it's important

local Window = Library:CreateWindow({
    Title = 'SigmaSploit.Ez',
    Center = true,
    AutoShow = true,
    TabPadding = 8
})

local Tabs = {
    Combat = Window:AddTab('Combat'),
    Visuals = Window:AddTab('Visuals'),
    ['UI Settings'] = Window:AddTab('UI Settings'),
}



--<< Combat Tab >>--

-- SilentAim
local SilentAimGroupBox = Tabs.Combat:AddLeftGroupbox('Silent Aim Features')

SilentAimGroupBox:AddToggle('SilentAim', {
    Text = 'Silent Aim',
    Default = false,
    Tooltip = 'Enable Silent Aim',
    Callback = function(Value)
        print('[cb] Silent Aim changed to:', Value)
    end
})

SilentAimGroupBox:AddSlider('FOVCircle', {
    Text = 'FOV Circle Size',
    Default = 50,
    Min = 0,
    Max = 200,
    Rounding = 0,
    Callback = function(Value)
        print('[cb] FOV Circle size changed to:', Value)
    end
})

-- Aimbot
local AimbotGroupBox = Tabs.Combat:AddRightGroupbox('Aimbot Features')

AimbotGroupBox:AddToggle('Aimbot', {
    Text = 'Aimbot',
    Default = false,
    Tooltip = 'Enable Aimbot',
    Callback = function(Value)
        print('[cb] Aimbot changed to:', Value)
    end
})

AimbotGroupBox:AddToggle('RecoilAimFOV', {
    Text = 'Recoil Aim FOV',
    Default = false,
    Tooltip = 'Enable Recoil Aim FOV',
    Callback = function(Value)
        print('[cb] Recoil Aim FOV changed to:', Value)
    end
})

-- Gun Modifications
local GunModsGroupBox = Tabs.Combat:AddLeftGroupbox('Gun Modifications')

--Script.Functions.updateAttribute("FireRate", 0)
GunModsGroupBox:AddSlider('FireRate', {
    Text = 'Fire Rate',
    Default = 0.0,
    Min = 0.0,
    Max = 1.0,
    Rounding = 0,
    Callback = function(Value)
        Script.Functions.updateAttribute("FireRate", Value)  -- Use `Value` with capital V
        print('[cb] Fire Rate changed to:', Value)
    end
})

local FullAuto = GunModsGroupBox:AddButton({
    Text = 'Full Auto Guns',
    Func = function()
        Script.Functions.updateAttribute("FireType", "Auto")
        print('You clicked a button!')
    end,
    DoubleClick = false,
    Tooltip = 'Enable Full Auto for guns'
})

local InstaAim = GunModsGroupBox:AddButton({
    Text = 'Instant Aim',
    Func = function()
        Script.Functions.updateAttribute("AimSpeed", 0)
    end,
    DoubleClick = false,
    Tooltip = 'Enable Instant Aim'
})

local InfAmmo = GunModsGroupBox:AddButton({
    Text = 'Infinite Ammo',
    Func = function()
        Script.Functions.updateAttribute("CurrentAmmo", math.huge)
    end,
    DoubleClick = false,
    Tooltip = 'Enable Infinite Ammo'
})

GunModsGroupBox:AddDropdown('CurrentGun', {
    Values = guns,
    Default = "Pistola", -- number index of the value / string
    Multi = false, -- true / false, allows multiple choices to be selected

    Text = 'Current Gun',
    Tooltip = 'For Gun Mods', -- Information shown when you hover over the dropdown

    Callback = function(selected)
        selectedGunName = selected
        selectedGun = lplr.Backpack:FindFirstChild(selectedGunName) or lplr.Character:FindFirstChild(selectedGunName)
        if not selectedGun then
            warn(selectedGunName .. " not found in Backpack or Character")
        end
    end
})

--<< Visuals Tab >>--

-- ESP
local BoxESPGroupBox = Tabs.Visuals:AddLeftGroupbox('Box ESP')

BoxESPGroupBox:AddToggle('ESPBoxes', {
    Text = 'Enable Boxes',
    Default = false,
    Tooltip = 'Toggle to enable/disable ESP boxes',
    Callback = function(Value)
        Sense.teamSettings.enemy.box = Value
        print('[cb] ESP Boxes changed to:', Value)
    end
})

BoxESPGroupBox:AddLabel('Box Color'):AddColorPicker('BoxColorPicker', {
    Default = Color3.new(0, 1, 0),
    Title = 'Box Color',
    Transparency = 0,
    Callback = function(Value)
        Sense.teamSettings.enemy.boxColor[1] = Value
        print('[cb] Box Color changed!', Value)
    end
})


BoxESPGroupBox:AddToggle('CornerBoxes', {
    Text = 'Enable Corner Boxes',
    Default = false,
    Tooltip = 'Toggle to enable/disable corner boxes',
    Callback = function(Value)
        print('[cb] Corner Boxes changed to:', Value)
    end
})

BoxESPGroupBox:AddToggle('ESP3DBox', {
    Text = 'Enable 3D Box',
    Default = false,
    Tooltip = 'Toggle to enable/disable 3D boxes',
    Callback = function(Value)
        Sense.teamSettings.enemy.box3d = Value
        print('[cb] 3D Box changed to:', Value)
    end
})

local ChamsGroupBox = Tabs.Visuals:AddRightGroupbox('Chams & Highlights')

ChamsGroupBox:AddToggle('PlayerChams', {
    Text = 'Enable Player Chams',
    Default = false,
    Tooltip = 'Toggle to enable/disable player chams',
    Callback = function(Value)
        Sense.teamSettings.enemy.chams = Value
        print('[cb] Player Chams changed to:', Value)
    end
})

ChamsGroupBox:AddLabel('Chams Color1'):AddColorPicker('ChamsColorPicker', {
    Default = Color3.new(0, 1, 0),
    Title = 'Chams Fill Color',
    Callback = function(Value)
        Sense.teamSettings.enemy.chamsOutlineColor[1] = Value
        print('[cb] Chams Color changed!', Value)
    end
})

ChamsGroupBox:AddLabel('Chams Color'):AddColorPicker('ChamsColorPicker', {
    Default = Color3.new(0, 1, 0),
    Title = 'Chams Outline Color',
    Callback = function(Value)
        Sense.teamSettings.enemy.chamsFillColor[1] = Value
        print('[cb] Chams Color changed!', Value)
    end
})

ChamsGroupBox:AddToggle('FillBoxes', {
    Text = 'Enable Fill Boxes',
    Default = false,
    Tooltip = 'Toggle to enable/disable filled boxes',
    Callback = function(Value)
        Sense.teamSettings.enemy.boxFill = Value
        print('[cb] Fill Boxes changed to:', Value)
    end
})

ChamsGroupBox:AddLabel('Fill Box Color'):AddColorPicker('FillBoxColorPicker', {
    Default = Color3.new(1, 0, 0, 0.5),
    Title = 'Fill Box Color',
    Callback = function(Value)
        Sense.teamSettings.enemy.boxFillColor[1] = Value
        print('[cb] Fill Box Color changed!', Value)
    end
})

local IndicatorsGroupBox = Tabs.Visuals:AddLeftGroupbox('Health & Indicators')

IndicatorsGroupBox:AddToggle('PlayerHealthBar', {
    Text = 'Enable Health Bar',
    Default = false,
    Tooltip = 'Toggle to enable/disable player health bars',
    Callback = function(Value)
        Sense.teamSettings.enemy.healthBar = Value
        print('[cb] Player Health Bar changed to:', Value)
    end
})

IndicatorsGroupBox:AddToggle('ESPTracers', {
    Text = 'Enable Tracers',
    Default = false,
    Tooltip = 'Toggle to enable/disable tracers',
    Callback = function(Value)
        Sense.teamSettings.enemy.tracer = Value
        print('[cb] Tracers changed to:', Value)
    end
})

IndicatorsGroupBox:AddToggle('OffscreenArrows', {
    Text = 'Enable Offscreen Arrows',
    Default = false,
    Tooltip = 'Toggle to enable/disable offscreen arrows',
    Callback = function(Value)
        Sense.teamSettings.enemy.offScreenArrow = Value
        print('[cb] Offscreen Arrows changed to:', Value)
    end
})



-- UI Settings
local MenuGroup = Tabs['UI Settings']:AddLeftGroupbox('Menu')
MenuGroup:AddButton('Unload', function() Library:Unload() end)
MenuGroup:AddLabel('Menu bind'):AddKeyPicker('MenuKeybind', { Default = 'End', NoUI = true, Text = 'Menu keybind' })
Library.ToggleKeybind = Options.MenuKeybind



--<< Initalization Managers >>--
ThemeManager:SetLibrary(Library)
SaveManager:SetLibrary(Library)
SaveManager:IgnoreThemeSettings()
SaveManager:SetIgnoreIndexes({ 'MenuKeybind' })
ThemeManager:SetFolder('SigmaSploit')
SaveManager:SetFolder('SigmaSploit/Krush')
SaveManager:BuildConfigSection(Tabs['UI Settings'])
ThemeManager:ApplyToTab(Tabs['UI Settings'])
ThemeManager:ApplyTheme('BBot')
SaveManager:LoadAutoloadConfig()

Library:SetWatermarkVisibility(true)
Library:Notify(Script.Author, 5)
Library:SetWatermark(Script.Watermark)
Library.KeybindFrame.Visible = true;

Library:OnUnload(function()
    Library.Unloaded = true
end)

Sense.Load()



--<< Functions >>--
function Script.Functions.updateAttribute(attribute, value)
    if selectedGun then
        selectedGun:SetAttribute(attribute, value)
    else
        warn("Gun not selected or does not exist.")
    end
end

function Script.Functions.getClosestPlayerToMouse()
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

function Script.Functions.shootClosestPlayer(currentGun)
    local closestPlayer = Script.Functions.getClosestPlayerToMouse()
    if closestPlayer then
        if not lplr.Character:FindFirstChild(currentGun) then
            return
        end
        local args = {
            [1] = closestPlayer.Humanoid,
            [2] = closestPlayer.Head,
            [3] = Vector3.new(closestPlayer.Head.Position.X, closestPlayer.Head.Position.Y, closestPlayer.Head.Position.Z)
        }
        lplr.Character[currentGun].EventsFolder.InflictTarget:FireServer(unpack(args))
    end
end



--<< Initalization >>--
gmt.__namecall = newcclosure(function(self, ...)
    local method = getnamecallmethod()
    if Toggles.SilentAim.Value then
        if tostring(method) == "FireServer" and tostring(self) == "Fire" then
            Script.Functions.shootClosestPlayer(selectedGunName)
        end
    end
    return nameCall(self, ...)
end)