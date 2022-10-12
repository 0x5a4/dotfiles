#!/usr/bin/env luajit
local result = {}

local read_output = function(command)
    local handle = io.popen(command)

    if handle == nil then
        return "couldnt open command"
    end

    local output = handle:read("*a")
    handle:close()
    return output

end

-- Get a bunch of window properties
local id = arg[1]
local class = arg[2]
local instance = arg[3]
local pid = tonumber(read_output("xdo pid " .. id))
local command = ""

if pid ~= nil then
    command = read_output("ps -o comm= -p " .. pid):gsub("\n", "")
end

-- Checks if the given property exists for the given window id
local check_property = function(property)
    local xprop = read_output("xprop -id " .. id .. " " .. property):gsub("\n", "")
    -- this will no longer work by tommorrow
    if xprop == property .. ":  not found." or xprop == property .. ":  no such atom on any window." then
        return false
    else
        return true
    end
end

--Match windows
if class == "Steam" or class == "PolyMC" then -- LAUNCHERS
    result.desktop = "V"
elseif check_property("STEAM_GAME") then -- STEAM GAMES
    result.desktop = "IV"
elseif class == "librewolf" then -- LIBREWOLF
    result.desktop = "II"
    result.follow = "off"
elseif class == "discord" then --DISCORD
    result.desktop = "IX"
elseif command == "spotify" then --SPOTIFY
    result.desktop = "X"
elseif string.sub(class, 1, string.len("Minecraft")) == "Minecraft" then -- MINECRAFT
    result.desktop = "IV"
    result.state = "fullscreen"
elseif class == "Zathura" then
    result.state = "tiled"
end

-- Abort if no option was set
if not next(result) then
    return
end

--Merge options and print them
local result_string = ""

for k, v in pairs(result) do
    result_string = result_string .. k .. "=" .. v .. " "
end

print(result_string)
