-- DaviHubLibrary.lua
-- Enhanced UI Library for Davi Hub 4.0
-- Efficient, Modular, Stylish, Animated, Draggable, and Modern

local DaviHubLibrary = {}

-- SERVICES
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")
local UserInputService = game:GetService("UserInputService")

-- HELPERS

local function createCorner(parent, radius)
    local corner = Instance.new("UICorner")
    corner.CornerRadius = radius or UDim.new(0, 10)
    corner.Parent = parent
    return corner
end

local function createLabel(parent, props)
    local lbl = Instance.new("TextLabel")
    for k, v in pairs(props or {}) do
        lbl[k] = v
    end
    lbl.Parent = parent
    return lbl
end

local function createButton(parent, props)
    local btn = Instance.new("TextButton")
    for k, v in pairs(props or {}) do
        btn[k] = v
    end
    btn.Parent = parent
    return btn
end

local function createSliderBar(parent)
    local sliderBar = Instance.new("Frame")
    sliderBar.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
    sliderBar.Size = UDim2.new(1, -20, 0, 6)
    sliderBar.Position = UDim2.new(0, 10, 0.5, -3)
    sliderBar.Parent = parent
    createCorner(sliderBar, UDim.new(0, 4))
    return sliderBar
end

local function makeDraggable(frame, dragHandle)
    local dragging, dragInput, startPos, dragStart

    local function onInputChanged(input)
        if input == dragInput and dragging then
            local delta = input.Position - dragStart
            frame.Position =
                UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end
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
    UserInputService.InputChanged:Connect(onInputChanged)
end

-- ANIMATION UTILITY
local function animateObjProperty(obj, property, to, tweenInfo)
    TweenService:Create(obj, tweenInfo or TweenInfo.new(0.2, Enum.EasingStyle.Quad), {[property] = to}):Play()
end

-- NOTIFY UTILITY
function DaviHubLibrary:Notify(text, duration)
    local gui = CoreGui:FindFirstChild("DaviHubUI") or Instance.new("ScreenGui", CoreGui)
    gui.Name = "DaviHubUI"
    local notice = Instance.new("TextLabel")
    notice.Parent = gui
    notice.BackgroundTransparency = 0.2
    notice.BackgroundColor3 = Color3.fromRGB(0,0,0)
    notice.Size = UDim2.new(0, 300, 0, 50)
    notice.Position = UDim2.new(0.5, -150, 0.1, 0)
    notice.AnchorPoint = Vector2.new(0.5,0)
    notice.Text = tostring(text)
    notice.TextSize = 20
    notice.Font = Enum.Font.GothamBold
    notice.TextColor3 = Color3.fromRGB(255,255,255)
    notice.ZIndex = 999
    createCorner(notice, UDim.new(0, 10))
    animateObjProperty(notice, "BackgroundTransparency", 0, TweenInfo.new(0.3))
    task.spawn(function()
        task.wait(duration or 2)
        animateObjProperty(notice, "BackgroundTransparency", 1, TweenInfo.new(0.3))
        task.wait(0.3)
        notice:Destroy()
    end)
end

-- MAIN FUNCTION: CREATE WINDOW
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
    createCorner(MainFrame)

    local DragHandle = createLabel(MainFrame, {
        Name = "DragHandle",
        BackgroundColor3 = Color3.fromRGB(25, 25, 25),
        Size = UDim2.new(1, 0, 0, 30),
        Font = Enum.Font.GothamBold,
        Text = title or "Davi Hub",
        TextColor3 = Color3.fromRGB(255, 255, 255),
        TextSize = 16,
        TextXAlignment = Enum.TextXAlignment.Center
    })
    createCorner(DragHandle)
    makeDraggable(MainFrame, DragHandle)

    local TabContainer = Instance.new("Frame")
    TabContainer.Name = "TabContainer"
    TabContainer.Parent = MainFrame
    TabContainer.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    TabContainer.Size = UDim2.new(0, 120, 1, -30)
    TabContainer.Position = UDim2.new(0, 0, 0, 30)
    TabContainer.BorderSizePixel = 0
    createCorner(TabContainer)

    local TabList = Instance.new("UIListLayout")
    TabList.Parent = TabContainer
    TabList.SortOrder = Enum.SortOrder.LayoutOrder
    TabList.Padding = UDim.new(0, 6)

    local PageContainer = Instance.new("Frame")
    PageContainer.Name = "PageContainer"
    PageContainer.Parent = MainFrame
    PageContainer.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    PageContainer.Size = UDim2.new(1, -120, 1, -30)
    PageContainer.Position = UDim2.new(0, 120, 0, 30)
    PageContainer.BorderSizePixel = 0
    createCorner(PageContainer)

    local Pages, Tabs = {}, {}

    local Window = {}

    function Window:Show()
        ScreenGui.Enabled = true
    end

    function Window:Hide()
        ScreenGui.Enabled = false
    end

    function Window:Destroy()
        ScreenGui:Destroy()
    end

    -- TAB FUNCTION
    function Window:CreateTab(name)
        local TabButton = createButton(TabContainer, {
            Name = name .. "Tab",
            BackgroundColor3 = Color3.fromRGB(35, 35, 35),
            Size = UDim2.new(1, 0, 0, 40),
            Font = Enum.Font.Gotham,
            Text = name,
            TextColor3 = Color3.fromRGB(200, 200, 200),
            TextSize = 14,
            BorderSizePixel = 0
        })
        createCorner(TabButton)

        local Page = Instance.new("Frame")
        Page.Name = name .. "Page"
        Page.Parent = PageContainer
        Page.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
        Page.Size = UDim2.new(1, 0, 1, 0)
        Page.Visible = false
        Page.BorderSizePixel = 0

        createCorner(Page)
        local UIList = Instance.new("UIListLayout")
        UIList.Parent = Page
        UIList.SortOrder = Enum.SortOrder.LayoutOrder
        UIList.Padding = UDim.new(0, 10)

        Pages[name]; Tabs[name] = Page, TabButton

        TabButton.MouseButton1Click:Connect(function()
            for _, p in pairs(Pages) do
                p.Visible = false
            end
            for _, t in pairs(Tabs) do
                animateObjProperty(t, "BackgroundColor3", Color3.fromRGB(35, 35, 35))
            end
            Page.Visible = true
            animateObjProperty(TabButton, "BackgroundColor3", Color3.fromRGB(55, 130, 255))
        end)

        if tabCount == nil or tabCount == 0 then
            Page.Visible = true
            animateObjProperty(TabButton, "BackgroundColor3", Color3.fromRGB(55,130,255))
            tabCount = 1
        else
            tabCount = tabCount + 1
        end

        -- TAB APIS
        local Tab = {}

        function Tab:CreateButton(text, callback)
            local Button = createButton(Page, {
                Name = text .. "Button",
                BackgroundColor3 = Color3.fromRGB(50, 50, 50),
                Size = UDim2.new(1, -10, 0, 40),
                Font = Enum.Font.Gotham,
                Text = text,
                TextColor3 = Color3.fromRGB(255, 255, 255),
                TextSize = 14,
                BorderSizePixel = 0
            })
            createCorner(Button)
            Button.MouseButton1Click:Connect(function()
                if typeof(callback) == "function" then callback() end
            end)
            Button.MouseEnter:Connect(function()
                animateObjProperty(Button, "BackgroundColor3", Color3.fromRGB(65,65,80))
            end)
            Button.MouseLeave:Connect(function()
                animateObjProperty(Button, "BackgroundColor3", Color3.fromRGB(50,50,50))
            end)
            return Button
        end

        function Tab:CreateLabel(text)
            local Label = createLabel(Page, {
                BackgroundTransparency = 1,
                Size = UDim2.new(1, -10, 0, 28),
                Font = Enum.Font.GothamSemibold,
                Text = text,
                TextColor3 = Color3.fromRGB(240, 240, 240),
                TextSize = 13,
                TextXAlignment = Enum.TextXAlignment.Left
            })
            return Label
        end

        function Tab:CreateTextbox(placeholder, callback)
            local BoxFrame = Instance.new("Frame")
            BoxFrame.Parent = Page
            BoxFrame.BackgroundColor3 = Color3.fromRGB(51,51,58)
            BoxFrame.Size = UDim2.new(1, -10, 0, 36)
            BoxFrame.BorderSizePixel = 0
            createCorner(BoxFrame)

            local Box = Instance.new("TextBox")
            Box.Parent = BoxFrame
            Box.Size = UDim2.new(1, -16, 1, 0)
            Box.Position = UDim2.new(0, 8, 0, 0)
            Box.PlaceholderText = placeholder or ""
            Box.Text = ""
            Box.BackgroundTransparency = 1
            Box.TextColor3 = Color3.fromRGB(245,245,245)
            Box.TextSize = 15
            Box.Font = Enum.Font.Gotham
            Box.ClearTextOnFocus = false

            Box.FocusLost:Connect(function(enter)
                if enter and typeof(callback) == "function" then callback(Box.Text) end
            end)
            return Box
        end

        function Tab:CreateToggle(text, callback, default)
            local ToggleFrame = Instance.new("Frame")
            ToggleFrame.Name = text .. "Toggle"
            ToggleFrame.Parent = Page
            ToggleFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
            ToggleFrame.Size = UDim2.new(1, -10, 0, 40)
            createCorner(ToggleFrame)

            local ToggleText = createLabel(ToggleFrame, {
                Name = "ToggleText",
                BackgroundTransparency = 1,
                Size = UDim2.new(0.8, 0, 1, 0),
                Font = Enum.Font.Gotham,
                Text = text,
                TextColor3 = Color3.fromRGB(255, 255, 255),
                TextSize = 14,
                TextXAlignment = Enum.TextXAlignment.Left
            })

            local ToggleButton = createButton(ToggleFrame, {
                Name = "ToggleButton",
                BackgroundColor3 = Color3.fromRGB(200, 0, 0),
                Size = UDim2.new(0.2, 0, 1, 0),
                Position = UDim2.new(0.8, 0, 0, 0),
                Font = Enum.Font.Gotham,
                Text = "OFF",
                TextColor3 = Color3.fromRGB(255, 255, 255),
                TextSize = 14
            })
            createCorner(ToggleButton)

            local toggled = (default == true)
            if toggled then
                ToggleButton.BackgroundColor3 = Color3.fromRGB(0,200,0)
                ToggleButton.Text = "ON"
            end

            ToggleButton.MouseButton1Click:Connect(function()
                toggled = not toggled
                if toggled then
                    animateObjProperty(ToggleButton, "BackgroundColor3", Color3.fromRGB(0,200,0))
                    ToggleButton.Text = "ON"
                else
                    animateObjProperty(ToggleButton, "BackgroundColor3", Color3.fromRGB(200,0,0))
                    ToggleButton.Text = "OFF"
                end
                if typeof(callback) == "function" then callback(toggled) end
            end)
            return ToggleButton
        end

        function Tab:CreateSlider(text, min, max, default, callback)
            local min, max, value = tonumber(min or 0), tonumber(max or 100), tonumber(default)
            value = value or min
            local SliderFrame = Instance.new("Frame")
            SliderFrame.Name = text .. "Slider"
            SliderFrame.Parent = Page
            SliderFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
            SliderFrame.Size = UDim2.new(1, -10, 0, 40)
            createCorner(SliderFrame)

            local SliderLabel = createLabel(SliderFrame, {
                BackgroundTransparency = 1,
                Size = UDim2.new(0.5, 0, 1, 0),
                Position = UDim2.new(0, 8, 0, 0),
                Font = Enum.Font.Gotham,
                Text = text..": ".. tostring(value),
                TextColor3 = Color3.fromRGB(255, 255, 255),
                TextSize = 14,
                TextXAlignment = Enum.TextXAlignment.Left
            })
            local sliderBar = createSliderBar(SliderFrame)

            local sliderKnob = Instance.new("Frame")
            sliderKnob.Size = UDim2.new(0, 16, 0, 16)
            sliderKnob.Position =
                UDim2.new(((value-min)/(max-min)), -8, 0.5, -8)
            sliderKnob.BackgroundColor3 = Color3.fromRGB(55,130,255)
            sliderKnob.BorderSizePixel = 0
            sliderKnob.Parent = sliderBar
            createCorner(sliderKnob, UDim.new(1,0))

            local dragging = false

            local function updateSlider(inputPos)
                local rel = math.clamp((inputPos.X - sliderBar.AbsolutePosition.X) / sliderBar.AbsoluteSize.X, 0, 1)
                value = math.floor(min + (max - min) * rel + 0.5)
                sliderKnob.Position = UDim2.new(rel, -8, 0.5, -8)
                SliderLabel.Text = text..": ".. tostring(value)
                if callback then callback(value) end
            end

            sliderKnob.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    dragging = true
                end
            end)
            UserInputService.InputEnded:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    dragging = false
                end
            end)
            UserInputService.InputChanged:Connect(function(input)
                if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
                    updateSlider(input.Position)
                end
            end)
            -- Click directly on bar support:
            sliderBar.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    updateSlider(input.Position)
                end
            end)
            return sliderKnob
        end

        function Tab:CreateDropdown(text, options, callback)
            local DropdownFrame = Instance.new("Frame")
            DropdownFrame.Name = text .. "Dropdown"
            DropdownFrame.Parent = Page
            DropdownFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
            DropdownFrame.Size = UDim2.new(1, -10, 0, 40)
            createCorner(DropdownFrame)

            local DropdownButton = createButton(DropdownFrame, {
                BackgroundTransparency = 1,
                Size = UDim2.new(1, 0, 1, 0),
                Font = Enum.Font.Gotham,
                Text = (text or "Select") .. ": " .. tostring(options and options[1] or ""),
                TextColor3 = Color3.fromRGB(220, 220, 220),
                TextSize = 14
            })
            local open = false
            local function closeDropdown()
                for _,child in pairs(Page:GetChildren()) do
                    if child:IsA("Frame") and child.Name == text.."DropdownList" then
                        child:Destroy()
                    end
                end
                open = false
            end
            DropdownButton.MouseButton1Click:Connect(function()
                if open then
                    closeDropdown()
                    return
                end
                open = true
                local ListFrame = Instance.new("Frame")
                ListFrame.Name = text .. "DropdownList"
                ListFrame.Parent = Page
                ListFrame.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
                ListFrame.Size = UDim2.new(1, -10, 0, #options*30 + 6)
                createCorner(ListFrame)
                ListFrame.Position = UDim2.new(0, 0, 0, DropdownFrame.Position.Y.Offset + DropdownFrame.Size.Y.Offset + 2)

                for i, opt in ipairs(options) do
                    local optBtn = createButton(ListFrame, {
                        Size = UDim2.new(1, 0, 0, 30),
                        Font = Enum.Font.Gotham,
                        Text = tostring(opt),
                        TextColor3 = Color3.fromRGB(255,255,255),
                        TextSize = 13,
                        BackgroundTransparency = 0,
                        BackgroundColor3 = Color3.fromRGB(55, 130, 255)
                    })
                    optBtn.Position = UDim2.new(0, 0, 0, (i-1)*30)
                    createCorner(optBtn)
                    optBtn.MouseButton1Click:Connect(function()
                        DropdownButton.Text = (text or "Select")..": ".. tostring(opt)
                        open = false
                        closeDropdown()
                        if callback then callback(opt) end
                    end)
                end
            end)
            return DropdownButton
        end

        return Tab
    end

    return Window
end

return DaviHubLibrary
