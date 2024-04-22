--Fix or improve the implementation of the below methods

local function releaseStorage(playerID)
    local player = getPlayerByID(playerID)
    -- check for null
    if player then
        player:setStorageValue(1000, -1)
    else
        print("releaseStorage failed")
    end
end

function onLogout(player)
    if player:getStorageValue(1000) == 1 then
        -- async functions are difficult in terms of errors handling, so I'd make it simpler. Especially if a player is logging out and main cycle is not that important for him.
        -- It is safer to pass a playerID to releaseStorage so that the function can't modify a player object.
        releaseStorage(player:getID())
        -- If async is mandatory, additional checks for scheduling and errors handling are required.
    end
    return true
end

-- Not sure if this is a thing in Lua, but I'd make some kind of a table to use it as enum just to avoid mistakes and improve readability. SET instead of 1, RELEASED instead of -1.
