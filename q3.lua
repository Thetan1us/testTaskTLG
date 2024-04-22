-- Fix or improve the name and the implementation of the below method

-- The name itself wasn't informative.
function removePartyMemeber(playerId, memberName)
    -- no need to have a global variable here
    local player = Player(playerId)
    local party = player:getParty()

    -- check if a player is not playing solo
    if not party then
        return
    end
-- Readability improvement + no need to create Player(memberName) every time in the cycle
    local partyMembers = party:getMembers()
    local memberToRemove = Player(memberName)

    for k, v in pairs(partyMembers) do
        if v == memberToRemove then
            party:removeMember(memberToRemove)
            break -- no need to continue iterating after needed player found
        end
    end
end
