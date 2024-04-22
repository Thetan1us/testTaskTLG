--Fix or improve the implementation of the below method

function printSmallGuildNames(memberCount)
    -- this method is supposed to print names of all guilds that have less than memberCount max members
    local selectGuildQuery = "SELECT name FROM guilds WHERE max_members < %d;"
    local resultId = db.storeQuery(string.format(selectGuildQuery, memberCount))
    -- Check if query brought us any results
    if resultId then
        -- loop through every one of guilds
        repeat
            local guildName = db.getDataString(resultId, "name")
            print(guildName)
        until not db.next(resultId) -- check if there is no more members
    else
        print("No guilds with less than " .. memberCount .. "members found")
    end
end
