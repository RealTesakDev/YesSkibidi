--<< Services >>--
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")



--<< UI >>--
function Init(title:string, description:string)
	local SigmasploitLoader = Instance.new("ScreenGui")
	local Base = Instance.new("Frame")
	local Top = Instance.new("Frame")
	local SkeetTypeShi = Instance.new("Frame")
	local Title = Instance.new("TextLabel")
	local UIPadding = Instance.new("UIPadding")
	local Information = Instance.new("TextLabel")
	local UIPadding_2 = Instance.new("UIPadding")
	local Console = Instance.new("Frame")
	local Scrolling = Instance.new("ScrollingFrame")
	local UIListLayout = Instance.new("UIListLayout")
	local UIPadding_3 = Instance.new("UIPadding")
	local Options = Instance.new("Frame")
	local Load = Instance.new("TextButton")
	local Text = Instance.new("TextLabel")
	local InputKey = Instance.new("Frame")
	local Text_2 = Instance.new("TextLabel")
	local InputBox = Instance.new("TextBox")
	local UIPadding_4 = Instance.new("UIPadding")



	SigmasploitLoader.Name = "NIGGER"
	SigmasploitLoader.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
	SigmasploitLoader.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

	Base.Name = "Base"
	Base.Parent = SigmasploitLoader
	Base.AnchorPoint = Vector2.new(0.5, 0.5)
	Base.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
	Base.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Base.Position = UDim2.new(0.5, 0, 0.5, 0)
	Base.Size = UDim2.new(0, 500, 0, 350)

	Top.Name = "Top"
	Top.Parent = Base
	Top.AnchorPoint = Vector2.new(0.5, 0.5)
	Top.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
	Top.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Top.Position = UDim2.new(0.5, 0, 0.0571428575, 0)
	Top.Size = UDim2.new(0, 500, 0, 40)

	SkeetTypeShi.Name = "SkeetTypeShi"
	SkeetTypeShi.Parent = Top
	SkeetTypeShi.AnchorPoint = Vector2.new(0.5, 0.5)
	SkeetTypeShi.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
	SkeetTypeShi.BorderColor3 = Color3.fromRGB(0, 0, 0)
	SkeetTypeShi.Position = UDim2.new(0.5, 0, 0.0321426392, 0)
	SkeetTypeShi.Size = UDim2.new(0, 500, 0, 3)

	Title.Name = "Title"
	Title.Parent = Top
	Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Title.BackgroundTransparency = 1.000
	Title.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Title.BorderSizePixel = 0
	Title.Size = UDim2.new(0, 264, 0, 40)
	Title.SizeConstraint = Enum.SizeConstraint.RelativeYY
	Title.Font = Enum.Font.Code
	Title.Text = title
	Title.TextColor3 = Color3.fromRGB(255, 255, 255)
	Title.TextSize = 17.000
	Title.TextWrapped = true
	Title.TextXAlignment = Enum.TextXAlignment.Left

	UIPadding.Parent = Title
	UIPadding.PaddingLeft = UDim.new(0, 15)

	Information.Name = "Information"
	Information.Parent = Top
	Information.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Information.BackgroundTransparency = 1.000
	Information.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Information.BorderSizePixel = 0
	Information.Position = UDim2.new(0.527999997, 0, 0, 0)
	Information.Size = UDim2.new(0, 236, 0, 40)
	Information.SizeConstraint = Enum.SizeConstraint.RelativeYY
	Information.Font = Enum.Font.Code
	Information.Text = description
	Information.TextColor3 = Color3.fromRGB(111, 111, 111)
	Information.TextSize = 12.000
	Information.TextWrapped = true
	Information.TextXAlignment = Enum.TextXAlignment.Right

	UIPadding_2.Parent = Information
	UIPadding_2.PaddingRight = UDim.new(0, 15)

	Console.Name = "Console"
	Console.Parent = Base
	Console.AnchorPoint = Vector2.new(0.5, 0.5)
	Console.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
	Console.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Console.Position = UDim2.new(0.5, 0, 0.481785715, 0)
	Console.Size = UDim2.new(0, 490, 0, 247)

	Scrolling.Name = "Scrolling"
	Scrolling.Parent = Console
	Scrolling.Active = true
	Scrolling.AnchorPoint = Vector2.new(0.5, 0.5)
	Scrolling.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Scrolling.BackgroundTransparency = 1.000
	Scrolling.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Scrolling.BorderSizePixel = 0
	Scrolling.Position = UDim2.new(0.5, 0, 0.5, 0)
	Scrolling.Size = UDim2.new(0, 490, 0, 247)
	Scrolling.CanvasSize = UDim2.new(0, 0, 0, 0)
	Scrolling.HorizontalScrollBarInset = Enum.ScrollBarInset.ScrollBar
	Scrolling.ScrollBarThickness = 5
	Scrolling.ClipsDescendants = true
	Scrolling.ScrollBarImageColor3 = Color3.fromRGB(0, 0, 0)
	Scrolling.ScrollBarImageTransparency = 0.5
	Scrolling.ScrollBarThickness = 5
	Scrolling.ScrollingDirection = Enum.ScrollingDirection.XY
	Scrolling.AutomaticCanvasSize = Enum.AutomaticSize.Y
	Scrolling.ElasticBehavior = Enum.ElasticBehavior.Never

	UIListLayout.Parent = Scrolling
	UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder

	UIPadding_3.Parent = Scrolling
	UIPadding_3.PaddingLeft = UDim.new(0, 10)
	UIPadding_3.PaddingRight = UDim.new(0, 10)
	UIPadding_3.PaddingTop = UDim.new(0, 5)

	Options.Name = "Options"
	Options.Parent = Base
	Options.AnchorPoint = Vector2.new(0.5, 0.5)
	Options.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
	Options.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Options.Position = UDim2.new(0.5, 0, 0.920357168, 0)
	Options.Size = UDim2.new(0, 490, 0, 46)

	Load.Name = "Load"
	Load.Parent = Options
	Load.AnchorPoint = Vector2.new(0.5, 0.5)
	Load.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
	Load.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Load.Text = ""
	Load.Position = UDim2.new(0.844703376, 0, 0.481746495, 0)
	Load.Size = UDim2.new(0, 131, 0, 30)

	Text.Name = "Text"
	Text.Parent = Load
	Text.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Text.BackgroundTransparency = 1.000
	Text.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Text.BorderSizePixel = 0
	Text.Size = UDim2.new(0, 131, 0, 30)
	Text.SizeConstraint = Enum.SizeConstraint.RelativeYY
	Text.Font = Enum.Font.Code
	Text.Text = "Load"
	Text.TextColor3 = Color3.fromRGB(255, 255, 255)
	Text.TextSize = 15.000
	Text.TextWrapped = true

	InputKey.Name = "InputKey"
	InputKey.Parent = Options
	InputKey.AnchorPoint = Vector2.new(0.5, 0.5)
	InputKey.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
	InputKey.BorderColor3 = Color3.fromRGB(0, 0, 0)
	InputKey.Position = UDim2.new(0.356535494, 0, 0.481746495, 0)
	InputKey.Size = UDim2.new(0, 330, 0, 30)

	
	InputBox.Name = "InputBox"
	InputBox.Parent = InputKey
	InputBox.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
	InputBox.BorderColor3 = Color3.fromRGB(0, 0, 0)
	InputBox.Size = UDim2.new(1, 0, 1, 0)
	InputBox.Font = Enum.Font.Code
	InputBox.PlaceholderText = "Input Key... (CASE SENSITIVE)"
	InputBox.PlaceholderColor3 = Color3.fromRGB(107, 107, 107)
	InputBox.Text = ""
	InputBox.TextColor3 = Color3.fromRGB(255, 255, 255)
	InputBox.TextSize = 14.000
	InputBox.TextWrapped = true
	InputBox.ClearTextOnFocus = false
	InputBox.TextXAlignment = Enum.TextXAlignment.Left

	UIPadding_4.Parent = InputBox
	UIPadding_4.PaddingLeft = UDim.new(0, 7)

    local dragging = false
    local dragInput, mousePos, framePos

    local function update(input)
        local delta = input.Position - mousePos
        local newPosition = UDim2.new(
            framePos.X.Scale,
            framePos.X.Offset + delta.X,
            framePos.Y.Scale,
            framePos.Y.Offset + delta.Y
        )

        local tween = TweenService:Create(Base, TweenInfo.new(0.1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {Position = newPosition})
        tween:Play()
    end

    Top.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            mousePos = input.Position
            framePos = Base.Position

            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    Top.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            dragInput = input
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            update(input)
        end
    end)

	return SigmasploitLoader
end

function Log(instance:Instance, text:string, color)
	local Log = Instance.new("TextLabel")
	Log.Name = "Log"
	Log.Parent = instance
	Log.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Log.BackgroundTransparency = 1.000
	Log.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Log.BorderSizePixel = 0
	Log.Position = UDim2.new(-0.0212765951, 0, 0, 0)
	Log.Size = UDim2.new(0, 470, 0, 22)
	Log.Font = Enum.Font.Code
	Log.Text = text
	Log.TextColor3 = color
	Log.TextSize = 13.000
	Log.TextWrapped = true
	Log.TextXAlignment = Enum.TextXAlignment.Left
end



--<< Main >>--
local ui = Init("Sigmasploit.ez", "Made by [7PX$ & sea]")
Log(ui.Base.Console.Scrolling, "["..os.date("%Y-%m-%d %H:%M:%S").."]: Welcome to Sigmasploit.ez", Color3.fromRGB(255, 255, 255))
Log(ui.Base.Console.Scrolling, "[INFO]: Please input your key to load the script", Color3.fromRGB(30, 146, 255))

ui.Base.Options.Load.MouseButton1Click:Connect(function()
    if ui.Base.Options.InputKey.InputBox.Text == "" then
        Log(ui.Base.Console.Scrolling, "[ERROR]: Please input your key to load the script", Color3.fromRGB(255, 0, 0))
    elseif ui.Base.Options.InputKey.InputBox.Text == "Sigma" then
        Log(ui.Base.Console.Scrolling, "[SUCCESS]: Load CP(Cod Points)", Color3.fromRGB(0, 200, 150))
    else
        Log(ui.Base.Console.Scrolling, "[SUCCESS]: Loading script...", Color3.fromRGB(0, 200, 0))
    end
end)