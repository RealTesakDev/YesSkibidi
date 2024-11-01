local repo = 'https://raw.githubusercontent.com/violin-suzutsuki/LinoriaLib/main/'

local Library = loadstring(game:HttpGet(repo .. 'Library.lua'))()
local ThemeManager = loadstring(game:HttpGet(repo .. 'addons/ThemeManager.lua'))()
local SaveManager = loadstring(game:HttpGet(repo .. 'addons/SaveManager.lua'))()

local Window = Library:CreateWindow({
    Title = 'SigmaSploit.Ez',
    Center = true,
    AutoShow = true,
    TabPadding = 8
})



local Tabs = {
    Visuals = Window:AddTab('Visuals'),
    Combat = Window:AddTab('Combat'),
    ['UI Settings'] = Window:AddTab('UI Settings'),
}

-- Visuals Tab (Keeping the original structure)
local BoxESPGroupBox = Tabs.Visuals:AddLeftGroupbox('Box ESP')

BoxESPGroupBox:AddToggle('ESPBoxes', {
    Text = 'Enable Boxes',
    Default = false,
    Tooltip = 'Toggle to enable/disable ESP boxes',
    Callback = function(Value)
        print('[cb] ESP Boxes changed to:', Value)
    end
})

BoxESPGroupBox:AddLabel('Box Color'):AddColorPicker('BoxColorPicker', {
    Default = Color3.new(0, 1, 0),
    Title = 'Box Color',
    Transparency = 0,
    Callback = function(Value)
        print('[cb] Box Color changed!', Value)
    end
})

BoxESPGroupBox:AddSlider('BoxThickness', {
    Text = 'Box Thickness',
    Default = 1,
    Min = 0,
    Max = 5,
    Rounding = 0,
    Callback = function(Value)
        print('[cb] Box Thickness changed to:', Value)
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
        print('[cb] 3D Box changed to:', Value)
    end
})

-- Chams and Highlights GroupBox
local ChamsGroupBox = Tabs.Visuals:AddRightGroupbox('Chams & Highlights')

ChamsGroupBox:AddToggle('PlayerChams', {
    Text = 'Enable Player Chams',
    Default = false,
    Tooltip = 'Toggle to enable/disable player chams',
    Callback = function(Value)
        print('[cb] Player Chams changed to:', Value)
    end
})

ChamsGroupBox:AddLabel('Chams Color'):AddColorPicker('ChamsColorPicker', {
    Default = Color3.new(0, 1, 0),
    Title = 'Chams Color',
    Callback = function(Value)
        print('[cb] Chams Color changed!', Value)
    end
})

ChamsGroupBox:AddToggle('FillBoxes', {
    Text = 'Enable Fill Boxes',
    Default = false,
    Tooltip = 'Toggle to enable/disable filled boxes',
    Callback = function(Value)
        print('[cb] Fill Boxes changed to:', Value)
    end
})

ChamsGroupBox:AddLabel('Fill Box Color'):AddColorPicker('FillBoxColorPicker', {
    Default = Color3.new(1, 0, 0, 0.5),
    Title = 'Fill Box Color',
    Callback = function(Value)
        print('[cb] Fill Box Color changed!', Value)
    end
})

-- Health and Indicators GroupBox
local IndicatorsGroupBox = Tabs.Visuals:AddLeftGroupbox('Health & Indicators')

IndicatorsGroupBox:AddToggle('PlayerHealthBar', {
    Text = 'Enable Health Bar',
    Default = false,
    Tooltip = 'Toggle to enable/disable player health bars',
    Callback = function(Value)
        print('[cb] Player Health Bar changed to:', Value)
    end
})

IndicatorsGroupBox:AddToggle('ESPTracers', {
    Text = 'Enable Tracers',
    Default = false,
    Tooltip = 'Toggle to enable/disable tracers',
    Callback = function(Value)
        print('[cb] Tracers changed to:', Value)
    end
})

IndicatorsGroupBox:AddToggle('OffscreenArrows', {
    Text = 'Enable Offscreen Arrows',
    Default = false,
    Tooltip = 'Toggle to enable/disable offscreen arrows',
    Callback = function(Value)
        print('[cb] Offscreen Arrows changed to:', Value)
    end
})

-- Text Settings GroupBox
local TextSettingsGroupBox = Tabs.Visuals:AddRightGroupbox('Text Settings')

TextSettingsGroupBox:AddLabel('Text Color'):AddColorPicker('TextColorPicker', {
    Default = Color3.new(1, 1, 1),
    Title = 'Text Color',
    Callback = function(Value)
        print('[cb] Text Color changed!', Value)
    end
})

TextSettingsGroupBox:AddLabel('Text Outline Color'):AddColorPicker('TextOutlineColorPicker', {
    Default = Color3.new(0, 0, 0),
    Title = 'Text Outline Color',
    Callback = function(Value)
        print('[cb] Text Outline Color changed!', Value)
    end
})



-- Combat Tab with Separated GroupBoxes
-- Silent Aim Features GroupBox
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

-- Aimbot Features GroupBox
local AimbotGroupBox = Tabs.Combat:AddRightGroupbox('Aimbot Features')

AimbotGroupBox:AddToggle('Aimbot', {
    Text = 'Aimbot',
    Default = false,
    Tooltip = 'Enable Aimbot',
    Callback = function(Value)
        print('[cb] Aimbot changed to:', Value)
    end
})

AimbotGroupBox:AddToggle('InstantAim', {
    Text = 'Instant Aim',
    Default = false,
    Tooltip = 'Enable Instant Aim',
    Callback = function(Value)
        print('[cb] Instant Aim changed to:', Value)
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

-- Gun Modifications GroupBox
local GunModsGroupBox = Tabs.Combat:AddLeftGroupbox('Gun Modifications')

GunModsGroupBox:AddToggle('InfiniteAmmo', {
    Text = 'Infinite Ammo',
    Default = false,
    Tooltip = 'Enable Infinite Ammo',
    Callback = function(Value)
        print('[cb] Infinite Ammo changed to:', Value)
    end
})

GunModsGroupBox:AddToggle('FullAuto', {
    Text = 'Full Auto Guns',
    Default = false,
    Tooltip = 'Enable Full Auto for guns',
    Callback = function(Value)
        print('[cb] Full Auto changed to:', Value)
    end
})

GunModsGroupBox:AddSlider('FireRate', {
    Text = 'Fire Rate',
    Default = 0.1,
    Min = 0,
    Max = 1,
    Rounding = 2,
    Callback = function(Value)
        print('[cb] Fire Rate changed to:', Value)
    end
})

-- Library functions
Library:SetWatermarkVisibility(true)
Library:Notify("Hello World!", 5)
Library:SetWatermark('This is a really long watermark to test the resizing')
Library.KeybindFrame.Visible = true;

Library:OnUnload(function()
    print('Unloaded!')
    Library.Unloaded = true
end)

-- UI Settings
local MenuGroup = Tabs['UI Settings']:AddLeftGroupbox('Menu')

MenuGroup:AddButton('Unload', function() Library:Unload() end)
MenuGroup:AddLabel('Menu bind'):AddKeyPicker('MenuKeybind', { Default = 'End', NoUI = true, Text = 'Menu keybind' })

Library.ToggleKeybind = Options.MenuKeybind

-- Set up Theme Manager and Save Manager
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
