-- config.lua
local config = {}

local function loadSaved()
    local ok, data = pcall(readfile, "BlackAir/autoexec.txt")
    if ok and data == "true" then return true end
    return false
end

local function save(val)
    pcall(function()
        writefile("BlackAir/autoexec.txt", tostring(val))
    end)
end

config.AutoExec = loadSaved()

function config.SetAutoExec(val)
    config.AutoExec = val
    save(val)
end

config.URL = {
    Loader = "https://raw.githubusercontent.com/TeamB-dot/main/refs/heads/main/main/loader.lua",
    Base   = "https://raw.githubusercontent.com/TeamB-dot/main/refs/heads/main/main/modules/"
}

config.Farm = {
    BANK_CAR_POS = Vector3.new(-404.33,44.61,-204.47),
    BANK_PLAYER_POS = Vector3.new(-382.76,45.39,-234.59),

    Tankstellen = {
        {
            name = "Tankstelle3",
            carTP = Vector3.new(-632.56,44.06,2430.84),
            playerTP = Vector3.new(-636.01,44.11,2474.99)
        },
        {
            name = "Tankstelle4",
            carTP = Vector3.new(-1238.83,44.06,2132.27),
            playerTP = Vector3.new(-1237.77,44.11,2089.23)
        }
    }
}

return config
