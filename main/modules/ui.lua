-- ui.lua
local ui = {}

function ui.init(config,core,runtime)
    local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()

    local Window = Rayfield:CreateWindow({
        Name = "BlackAir AutoFarm",
        LoadingTitle = "BlackAir",
        LoadingSubtitle = "AutoFarm",
        Theme = "Default"
    })

    local Tab = Window:CreateTab("Settings", 4483362458)

    Tab:CreateToggle({
        Name="AutoExec",
        CurrentValue=config.AutoExec,
        Callback=function(v)
            config.SetAutoExec(v)
        end
    })

    Tab:CreateButton({
        Name="Start AutoFarm",
        Callback=function()
            runtime.StartAutoFarm()
        end
    })

    Tab:CreateButton({
        Name="Server Hop",
        Callback=function()
            runtime.ServerHop()
        end
    })
end

return ui
