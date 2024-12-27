local DaviHub = loadstring(game:HttpGet("https://raw.githubusercontent.com/Davicoderliner/Davi-library-4.0-/refs/heads/main/DaviHubLibrary.lua"))()

local Window = DaviHub:CreateWindow("Davi Hub 4.0")

local MainTab = Window:CreateTab("Main Features")

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
