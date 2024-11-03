--<< Services >>--
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
--local curretHwid = gethwid()



--<< UI >>--
function Init(title:string, description:string)
    --<< Initializing UI Instances >>--
    local LinoriaKeySystem = Instance.new("ScreenGui", game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui"));
    local Root = Instance.new("Frame", LinoriaKeySystem);
    local Content = Instance.new("Frame", Root);
    local Options = Instance.new("Frame", Content);
    local Load = Instance.new("Frame", Options);
    local LoadButton = Instance.new("TextButton", Load);
    local KeyInput = Instance.new("Frame", Options);
    local InputBox = Instance.new("TextBox", KeyInput);
    local UIPadding = Instance.new("UIPadding", InputBox);
    local Status = Instance.new("Frame", Content);
    local Part1 = Instance.new("TextLabel", Status);
    local Lines = Instance.new("Folder", Status);
    local Part1Folder = Instance.new("Folder", Lines);
    local Part1_1 = Instance.new("Frame", Part1Folder);
    local Part1_2 = Instance.new("Frame", Part1Folder);
    local Part2Folder = Instance.new("Folder", Lines);
    local Part2_1 = Instance.new("Frame", Part2Folder);
    local Part2_2 = Instance.new("Frame", Part2Folder);
    local Part3Folder = Instance.new("Folder", Lines);
    local Part3_1 = Instance.new("Frame", Part3Folder);
    local Part3_2 = Instance.new("Frame", Part3Folder);
    local Part2 = Instance.new("TextLabel", Status);
    local Part3 = Instance.new("TextLabel", Status);
    local Title = Instance.new("TextLabel", Root);
    local UIPadding_2 = Instance.new("UIPadding", Title);
    local Description = Instance.new("TextLabel", Root);
    local UIPadding_3 = Instance.new("UIPadding", Description);



    LinoriaKeySystem["Name"] = [[LinoriaKeySystem]];
    LinoriaKeySystem["ZIndexBehavior"] = Enum.ZIndexBehavior.Sibling;

    Root["BackgroundColor3"] = Color3.fromRGB(30, 29, 30);
    Root["AnchorPoint"] = Vector2.new(0.5, 0.5);
    Root["Size"] = UDim2.new(0, 500, 0, 200);
    Root["Position"] = UDim2.new(0.5, 0, 0.5, 0);
    Root["BorderColor3"] = Color3.fromRGB(0, 0, 0);
    Root["Name"] = [[Root]];

    Content["BackgroundColor3"] = Color3.fromRGB(22, 21, 22);
    Content["AnchorPoint"] = Vector2.new(0.5, 0.5);
    Content["Size"] = UDim2.new(0, 488, 0, 163);
    Content["Position"] = UDim2.new(0.5, 0, 0.5575, 0);
    Content["BorderColor3"] = Color3.fromRGB(51, 52, 52);
    Content["Name"] = [[Content]];

    Options["BackgroundColor3"] = Color3.fromRGB(30, 29, 30);
    Options["AnchorPoint"] = Vector2.new(0.5, 0.5);
    Options["Size"] = UDim2.new(0, 476, 0, 37);
    Options["Position"] = UDim2.new(0.5, 0, 0.84584, 0);
    Options["BorderColor3"] = Color3.fromRGB(51, 52, 52);
    Options["Name"] = [[Options]];

    Load["BackgroundColor3"] = Color3.fromRGB(26, 26, 26);
    Load["AnchorPoint"] = Vector2.new(0.5, 0.5);
    Load["Size"] = UDim2.new(0, 132, 0, 24);
    Load["Position"] = UDim2.new(0.85096, 0, 0.49725, 0);
    Load["BorderColor3"] = Color3.fromRGB(48, 48, 47);
    Load["Name"] = [[Load]];

    LoadButton["BorderSizePixel"] = 0;
    LoadButton["TextSize"] = 12;
    LoadButton["TextColor3"] = Color3.fromRGB(255, 255, 255);
    LoadButton["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
    LoadButton["FontFace"] = Font.new([[rbxasset://fonts/families/Inconsolata.json]], Enum.FontWeight.Medium, Enum.FontStyle.Normal);
    LoadButton["AnchorPoint"] = Vector2.new(0.5, 0.5);
    LoadButton["Size"] = UDim2.new(0, 132, 0, 24);
    LoadButton["BackgroundTransparency"] = 1;
    LoadButton["BorderColor3"] = Color3.fromRGB(0, 0, 0);
    LoadButton["Text"] = [[Load]];
    LoadButton["Position"] = UDim2.new(0.5, 0, 0.5, 0);

    KeyInput["BackgroundColor3"] = Color3.fromRGB(26, 26, 26);
    KeyInput["AnchorPoint"] = Vector2.new(0.5, 0.5);
    KeyInput["Size"] = UDim2.new(0, 325, 0, 24);
    KeyInput["Position"] = UDim2.new(0.35422, 0, 0.497, 0);
    KeyInput["BorderColor3"] = Color3.fromRGB(48, 48, 47);
    KeyInput["Name"] = [[KeyInput]];

    InputBox["CursorPosition"] = -1;
    InputBox["TextColor3"] = Color3.fromRGB(255, 255, 255);
    InputBox["PlaceholderColor3"] = Color3.fromRGB(114, 114, 114);
    InputBox["BorderSizePixel"] = 0;
    InputBox["TextXAlignment"] = Enum.TextXAlignment.Left;
    InputBox["TextWrapped"] = true;
    InputBox["TextSize"] = 12;
    InputBox["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
    InputBox["FontFace"] = Font.new([[rbxasset://fonts/families/Inconsolata.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
    InputBox["AnchorPoint"] = Vector2.new(0.5, 0.5);
    InputBox["PlaceholderText"] = [[Input Key... (CASE SENSITIVE)]];
    InputBox["Size"] = UDim2.new(0, 325, 0, 24);
    InputBox["Position"] = UDim2.new(0.5, 0, 0.5, 0);
    InputBox["BorderColor3"] = Color3.fromRGB(0, 0, 0);
    InputBox["Text"] = [[]];
    InputBox["BackgroundTransparency"] = 1;

    UIPadding["PaddingLeft"] = UDim.new(0, 10);

    Status["BackgroundColor3"] = Color3.fromRGB(30, 29, 30);
    Status["AnchorPoint"] = Vector2.new(0.5, 0.5);
    Status["Size"] = UDim2.new(0, 476, 0, 105);
    Status["Position"] = UDim2.new(0.5, 0, 0.36425, 0);
    Status["BorderColor3"] = Color3.fromRGB(51, 52, 52);
    Status["Name"] = [[Status]];

    Part1["BorderSizePixel"] = 0;
    Part1["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
    Part1["TextSize"] = 11;
    Part1["FontFace"] = Font.new([[rbxasset://fonts/families/Inconsolata.json]], Enum.FontWeight.ExtraLight, Enum.FontStyle.Normal);
    Part1["TextColor3"] = Color3.fromRGB(255, 255, 255);
    Part1["BackgroundTransparency"] = 1;
    Part1["Size"] = UDim2.new(0, 156, 0, 30);
    Part1["BorderColor3"] = Color3.fromRGB(0, 0, 0);
    Part1["Text"] = [[Waiting for key input...]];
    Part1["Name"] = [[KeyInput]];
    Part1["Position"] = UDim2.new(0.03824, 0, 0.18557, 0);

    Lines["Name"] = [[Lines]];

    Part1Folder["Name"] = [[Part1]];

    Part1_1["BorderSizePixel"] = 0;
    Part1_1["BackgroundColor3"] = Color3.fromRGB(51, 52, 52);
    Part1_1["Size"] = UDim2.new(0, 84, 0, 1);
    Part1_1["Position"] = UDim2.new(0.01261, 0, 0.83505, 0);
    Part1_1["BorderColor3"] = Color3.fromRGB(0, 0, 0);

    Part1_2["BorderSizePixel"] = 0;
    Part1_2["BackgroundColor3"] = Color3.fromRGB(51, 52, 52);
    Part1_2["Size"] = UDim2.new(0, 1, 0, 43);
    Part1_2["Position"] = UDim2.new(0.18697, 0, 0.43299, 0);
    Part1_2["BorderColor3"] = Color3.fromRGB(0, 0, 0);

    Part2Folder["Name"] = [[Part2]];

    Part2_1["BorderSizePixel"] = 0;
    Part2_1["BackgroundColor3"] = Color3.fromRGB(51, 52, 52);
    Part2_1["Size"] = UDim2.new(0, 145, 0, 1);
    Part2_1["Position"] = UDim2.new(0.18908, 0, 0.835, 0);
    Part2_1["BorderColor3"] = Color3.fromRGB(0, 0, 0);

    Part2_2["BorderSizePixel"] = 0;
    Part2_2["BackgroundColor3"] = Color3.fromRGB(51, 52, 52);
    Part2_2["Size"] = UDim2.new(0, 1, 0, 43);
    Part2_2["Position"] = UDim2.new(0.4916, 0, 0.43299, 0);
    Part2_2["BorderColor3"] = Color3.fromRGB(0, 0, 0);

    Part3Folder["Name"] = [[Part3]];

    Part3_1["BorderSizePixel"] = 0;
    Part3_1["BackgroundColor3"] = Color3.fromRGB(51, 52, 52);
    Part3_1["Size"] = UDim2.new(0, 234, 0, 1);
    Part3_1["Position"] = UDim2.new(0.494, 0, 0.835, 0);
    Part3_1["BorderColor3"] = Color3.fromRGB(0, 0, 0);

    Part3_2["BorderSizePixel"] = 0;
    Part3_2["BackgroundColor3"] = Color3.fromRGB(51, 52, 52);
    Part3_2["Size"] = UDim2.new(0, 1, 0, 43);
    Part3_2["Position"] = UDim2.new(0.82353, 0, 0.4433, 0);
    Part3_2["BorderColor3"] = Color3.fromRGB(0, 0, 0);

    Part2["BorderSizePixel"] = 0;
    Part2["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
    Part2["TextSize"] = 11;
    Part2["FontFace"] = Font.new([[rbxasset://fonts/families/Inconsolata.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
    Part2["TextColor3"] = Color3.fromRGB(0, 243, 255);
    Part2["BackgroundTransparency"] = 1;
    Part2["Size"] = UDim2.new(0, 156, 0, 30);
    Part2["BorderColor3"] = Color3.fromRGB(0, 0, 0);
    Part2["Text"] = [[Key Valid!]];
    Part2["Name"] = [[KeyStatus]];
    Part2["Position"] = UDim2.new(0.33445, 0, 0.18557, 0);

    Part3["BorderSizePixel"] = 0;
    Part3["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
    Part3["TextSize"] = 11;
    Part3["FontFace"] = Font.new([[rbxasset://fonts/families/Inconsolata.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
    Part3["TextColor3"] = Color3.fromRGB(39, 255, 0);
    Part3["BackgroundTransparency"] = 1;
    Part3["Size"] = UDim2.new(0, 156, 0, 30);
    Part3["BorderColor3"] = Color3.fromRGB(0, 0, 0);
    Part3["Text"] = [[Ready to load]];
    Part3["Name"] = [[LoadStatus]];
    Part3["Position"] = UDim2.new(0.662, 0, 0.186, 0);

    Title["BorderSizePixel"] = 0;
    Title["TextXAlignment"] = Enum.TextXAlignment.Left;
    Title["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
    Title["TextSize"] = 15;
    Title["FontFace"] = Font.new([[rbxasset://fonts/families/Inconsolata.json]], Enum.FontWeight.Medium, Enum.FontStyle.Normal);
    Title["TextColor3"] = Color3.fromRGB(255, 255, 255);
    Title["BackgroundTransparency"] = 1;
    Title["Size"] = UDim2.new(0, 350, 0, 30);
    Title["BorderColor3"] = Color3.fromRGB(0, 0, 0);
    Title["Text"] = title;
    Title["Name"] = [[Title]];

    UIPadding_2["PaddingLeft"] = UDim.new(0, 8);

    Description["BorderSizePixel"] = 0;
    Description["TextXAlignment"] = Enum.TextXAlignment.Right;
    Description["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
    Description["TextSize"] = 11;
    Description["FontFace"] = Font.new([[rbxasset://fonts/families/Inconsolata.json]], Enum.FontWeight.ExtraLight, Enum.FontStyle.Normal);
    Description["TextColor3"] = Color3.fromRGB(255, 255, 255);
    Description["BackgroundTransparency"] = 1;
    Description["Size"] = UDim2.new(0, 150, 0, 30);
    Description["BorderColor3"] = Color3.fromRGB(0, 0, 0);
    Description["Text"] = description;
    Description["Name"] = [[Author]];
    Description["Position"] = UDim2.new(0.7, 0, 0, 0);

    UIPadding_3["PaddingRight"] = UDim.new(0, 8);

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

        local tween = TweenService:Create(Root, TweenInfo.new(0.1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {Position = newPosition})
        tween:Play()
    end

    Root.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            mousePos = input.Position
            framePos = Root.Position

            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    Root.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            dragInput = input
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            update(input)
        end
    end)

    LoadButton.MouseButton1Click:Connect(function()
        if InputBox.Text == "" then
            print("Please enter a key")
        elseif InputBox.Text == "Sigma" then
            print("Loading CP(Cod Points)")
        else
            print("Key is Valid")
        end
    end)

    return LinoriaKeySystem
end

--<< Main >>--
local ui = Init("Sigmasploit.ez", "Made by [7PX$ & sea]")