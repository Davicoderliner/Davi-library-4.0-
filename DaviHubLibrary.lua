-- DaviHubLibrary.lua
-- Custom UI Library for Davi Hub 4.0
-- Stylish, Animated, Draggable, and Modern

local DaviHubLibrary = {}

-- Services
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")
local UserInputService = game:GetService("UserInputService")

-- Function to create a draggable frame
local function makeDraggable(frame, dragHandle)
    local dragging
    local dragInput
    local startPos
    local dragStart

    dragHandle.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = frame.Position

            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    dragHandle.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            dragInput = input
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - dragStart
            frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
end

-- Main function to create a new window
function DaviHubLibrary:CreateWindow(title)
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "DaviHubUI"
    ScreenGui.Parent = CoreGui

    local MainFrame = Instance.new("Frame")
    MainFrame.Name = "MainFrame"
    MainFrame.Parent = ScreenGui
    MainFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    MainFrame.Size = UDim2.new(0, 600, 0, 400)
    MainFrame.Position = UDim2.new(0.5, -300, 0.5, -200)
    MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
    MainFrame.ClipsDescendants = true

    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 10)
    UICorner.Parent = MainFrame

    local DragHandle = Instance.new("TextLabel")
    DragHandle.Name = "DragHandle"
    DragHandle.Parent = MainFrame
    DragHandle.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    DragHandle.Size = UDim2.new(1, 0, 0, 30)
    DragHandle.Font = Enum.Font.GothamBold
    DragHandle.Text = title or "Davi Hub"
    DragHandle.TextColor3 = Color3.fromRGB(255, 255, 255)
    DragHandle.TextSize = 16
    DragHandle.TextXAlignment = Enum.TextXAlignment.Center

    local UICornerHandle = Instance.new("UICorner")
    UICornerHandle.CornerRadius = UDim.new(0, 10)
    UICornerHandle.Parent = DragHandle

    makeDraggable(MainFrame, DragHandle)

    local TabContainer = Instance.new("Frame")
    TabContainer.Name = "TabContainer"
    TabContainer.Parent = MainFrame
    TabContainer.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    TabContainer.Size = UDim2.new(0, 120, 1, -30)
    TabContainer.Position = UDim2.new(0, 0, 0, 30)
    TabContainer.BorderSizePixel = 0

    local UICornerTab = Instance.new("UICorner")
    UICornerTab.CornerRadius = UDim.new(0, 10)
    UICornerTab.Parent = TabContainer

    local TabList = Instance.new("UIListLayout")
    TabList.Parent = TabContainer
    TabList.SortOrder = Enum.SortOrder.LayoutOrder

    local PageContainer = Instance.new("Frame")
    PageContainer.Name = "PageContainer"
    PageContainer.Parent = MainFrame
    PageContainer.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    PageContainer.Size = UDim2.new(1, -120, 1, -30)
    PageContainer.Position = UDim2.new(0, 120, 0, 30)
    PageContainer.BorderSizePixel = 0

    local UICornerPage = Instance.new("UICorner")
    UICornerPage.CornerRadius = UDim.new(0, 10)
    UICornerPage.Parent = PageContainer

    local Pages = {}

    local Window = {}

    -- Function to create a new tab
    function Window:CreateTab(name)
        local TabButton = Instance.new("TextButton")
        TabButton.Name = name .. "Tab"
        TabButton.Parent = TabContainer
        TabButton.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
        TabButton.Size = UDim2.new(1, 0, 0, 40)
        TabButton.Font = Enum.Font.Gotham
        TabButton.Text = name
        TabButton.TextColor3 = Color3.fromRGB(200, 200, 200)
        TabButton.TextSize = 14

        local UICornerTabButton = Instance.new("UICorner")
        UICornerTabButton.CornerRadius = UDim.new(0, 10)
        UICornerTabButton.Parent = TabButton

        local Page = Instance.new("Frame")
        Page.Name = name .. "Page"
        Page.Parent = PageContainer
        Page.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
        Page.Size = UDim2.new(1, 0, 1, 0)
        Page.Visible = false

        local UIList = Instance.new("UIListLayout")
        UIList.Parent = Page
        UIList.SortOrder = Enum.SortOrder.LayoutOrder
        UIList.Padding = UDim.new(0, 10)

        Pages[name] = Page

        TabButton.MouseButton1Click:Connect(function()
            for _, p in pairs(Pages) do
                p.Visible = false
            end
            Page.Visible = true
        end)

        local Tab = {}

        -- Function to create a button
        function Tab:CreateButton(text, callback)
            local Button = Instance.new("TextButton")
            Button.Name = text .. "Button"
            Button.Parent = Page
            Button.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
            Button.Size = UDim2.new(1, -10, 0, 40)
            Button.Font = Enum.Font.Gotham
            Button.Text = text
            Button.TextColor3 = Color3.fromRGB(255, 255, 255)
            Button.TextSize = 14

            local UICornerButton = Instance.new("UICorner")
            UICornerButton.CornerRadius = UDim.new(0, 10)
            UICornerButton.Parent = Button

            Button.MouseButton1Click:Connect(function()
                callback()
            end)
        end

        -- Function to create a toggle
        function Tab:CreateToggle(text, callback)
            local ToggleFrame = Instance.new("Frame")
            ToggleFrame.Name = text .. "Toggle"
            ToggleFrame.Parent = Page
            ToggleFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
            ToggleFrame.Size = UDim2.new(1, -10, 0, 40)

            local UICornerToggle = Instance.new("UICorner")
            UICornerToggle.CornerRadius = UDim.new(0, 10)
            UICornerToggle.Parent = ToggleFrame

            local ToggleText = Instance.new("TextLabel")
            ToggleText.Name = "ToggleText"
            ToggleText.Parent = ToggleFrame
            ToggleText.BackgroundTransparency = 1
            ToggleText.Size = UDim2.new(0.8, 0, 1, 0)
            ToggleText.Font = Enum.Font.Gotham
            ToggleText.Text = text
            ToggleText.TextColor3 = Color3.fromRGB(255, 255, 255)
            ToggleText.TextSize = 14
            ToggleText.TextXAlignment = Enum.TextXAlignment.Left

            local ToggleButton = Instance.new("TextButton")
            ToggleButton.Name = "ToggleButton"
            ToggleButton.Parent = ToggleFrame
            ToggleButton.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
            ToggleButton.Size = UDim2.new(0.2, 0, 1, 0)
            ToggleButton.Position = UDim2.new(0.8, 0, 0, 0)
            ToggleButton.Font = Enum.Font.Gotham
            ToggleButton.Text = "OFF"
            ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
            ToggleButton.TextSize = 14

            local UICornerToggleButton = Instance.new("UICorner")
            UICornerToggleButton.CornerRadius = UDim.new(0, 10)
            UICornerToggleButton.Parent = ToggleButton

            local toggled = false

            ToggleButton.MouseButton1Click:Connect(function()
                toggled = not toggled
                if toggled then
                    ToggleButton.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
                    ToggleButton.Text = "ON"
                else
                    ToggleButton.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
                    ToggleButton.Text = "OFF"
                end
                callback(toggled)
            end)
        end

        return Tab
    end

    return Window
end

return DaviHubLibrary
