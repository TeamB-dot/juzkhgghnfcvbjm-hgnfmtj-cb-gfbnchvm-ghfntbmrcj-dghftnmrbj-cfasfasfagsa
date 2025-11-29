-- runtime.lua
local runtime={}
local Players=game:GetService("Players")
local Teleport=game:GetService("TeleportService")
local Http=game:GetService("HttpService")
local player=Players.LocalPlayer
local Place=game.PlaceId

local config,core

function runtime.init(c,co,ui)
    config=c
    core=co
end

function runtime.ServerHop()
    local servers={}
    local data=game:HttpGet("https://games.roblox.com/v1/games/"..Place.."/servers/Public?limit=100")
    data=Http:JSONDecode(data)
    for _,v in ipairs(data.data) do
        if v.playing<v.maxPlayers then
            table.insert(servers,v.id)
        end
    end
    if #servers>0 then
        Teleport:TeleportToPlaceInstance(Place,servers[math.random(#servers)],player)
    end
end

function runtime.StartAutoFarm()
    task.spawn(function()
        local car = core.findCar()
        if not car then return end

        core.unlock(car)
        task.wait(0.3)

        core.carInFront(car)
        task.wait(0.3)

        core.enter(car)
        task.wait(0.5)

        local posCar = config.Farm.BANK_CAR_POS
        local posPlayer = config.Farm.BANK_PLAYER_POS

        core.carTP(car,posCar)
        task.wait(1)

        if not core.atmBroken() then
            core.exit(posPlayer)
            task.wait(1)

            local count=core.renameATMs()
            task.wait(0.2)

            core.destroyATM(count)
            task.wait(0.4)

            core.collect()
        end

        for _,info in ipairs(config.Farm.Tankstellen) do
            core.enter(car)
            task.wait(0.5)
            core.robTank(info,car)
            task.wait(0.5)
        end

        runtime.ServerHop()
    end)
end

return runtime
