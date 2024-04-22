// Assume all method calls work fine.Fix the memory leak issue in below method

void Game::addItemToPlayer(const std::string &recipient, uint16_t itemId)
{
    Player *player = g_game.getPlayerByName(recipient);
    bool isPlayerCreated = false;

    if (!player)
    {
        player = new Player(nullptr);       // This is a place where we allocate dynamic memory, memory leak is possible here. 
        isPlayerCreated = true              //I'd use a smart pointer to avoid it. If that is not possible, manual actions are required. 
        if (!IOLoginData::loadPlayerByName(player, recipient))
        {
            delete player; // release allocated memory before leaving the fucntion
            return;
        }
    }

    Item *item = Item::CreateItem(itemId);
    if (!item)
    {
        if(isPlayerCreated)
            delete player; // This check is mandatory to prevent unidentified behaviour if the player object is not dynamically allocated.
        return;
    }

    g_game.internalAddItem(player->getInbox(), item, INDEX_WHEREEVER, FLAG_NOLIMIT);

    if (player->isOffline() && isPlayerCreated)
    {
        IOLoginData::savePlayer(player);
        delete player;
    }
    else if (!player->isOffline() && isPlayerCreated)
        delete player;

}
