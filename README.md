# Davi-library-4.0-

Davi Hub 4.0 - Roblox Lua UI Library

## Overview

Davi Hub Library 4.0 is a modern, stylish, and efficient UI library for Roblox Lua scripts. It features animated, draggable, and modular user interfaces, making it easy to build professional looking game GUIs quickly.

**Features:**
- Multiple tabs and pages
- Buttons, Toggles, Sliders, and Dropdowns
- Labels and Textboxes
- Smooth UI animation with TweenService
- Notification system
- Easy to use API

---

## How It Works

### Creating a Window

```lua
local Window = DaviHub:CreateWindow("Window Title")
```
Creates the main window with a draggable bar.

### Creating a Tab

```lua
local MainTab = Window:CreateTab("Tab Name")
```
Adds a tab on the left side of the window.

### Adding Components

**Button:**
```lua
MainTab:CreateButton("Button Text", function()
    print("Button pressed!")
end)
```

**Toggle:**
```lua
MainTab:CreateToggle("Toggle Text", function(state)
    print("Toggle state is:", state)
end)
```

**Slider:**
```lua
MainTab:CreateSlider("Slider Name", min, max, default, function(value)
    print("Slider value:", value)
end)
```

**Dropdown:**
```lua
MainTab:CreateDropdown("Dropdown Label", {"Option 1","Option 2","Option 3"}, function(selected)
    print("Selected:", selected)
end)
```

**Label:**
```lua
MainTab:CreateLabel("This is a label!")
```

**Textbox:**
```lua
MainTab:CreateTextbox("Placeholder...", function(text)
    print("Input:", text)
end)
```

**Notification:**
```lua
DaviHub:Notify("Message", 2) -- 2 seconds
```

**Managing the GUI:**
```lua
Window:Show() -- Show the UI
Window:Hide() -- Hide the UI
Window:Destroy() -- Remove the UI
```

---

## Example Usage

See [`Example.lua`](./Example.lua) for a ready-to-use code sample:

```lua
local DaviHub = loadstring(game:HttpGet("https://raw.githubusercontent.com/Davicoderliner/Davi-library-4.0-/main/DaviHubLibrary.lua"))()

local Window = DaviHub:CreateWindow("Davi Hub 4.0")

local MainTab = Window:CreateTab("Main Features")

MainTab:CreateLabel("Welcome to Davi Hub 4.0!")

MainTab:CreateButton("Speed Boost", function()
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 50
end)

MainTab:CreateToggle("Infinite Jump", function(state)
    if state then
        print("Infinite Jump Enabled")
    else
        print("Infinite Jump Disabled")
    end
end)

MainTab:CreateSlider("WalkSpeed", 16, 100, 16, function(value)
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = value
end)

MainTab:CreateDropdown("Team", {"Red", "Blue", "Green"}, function(selected)
    print("Team selected:", selected)
end)

MainTab:CreateTextbox("Say something...", function(text)
    print("User said:", text)
end)

DaviHub:Notify("UI Loaded!", 2)
```
---
## Getting the Library

Simply load via:

```lua
local DaviHub = loadstring(game:HttpGet("https://raw.githubusercontent.com/Davicoderliner/Davi-library-4.0-/main/DaviHubLibrary.lua"))()
```

---

## Credits

- Created by [Davicoderliner](https://github.com/Davicoderliner)
- Inspired by UI libraries in the Roblox community

---
