function money_func(player,cmd,playername,money)
    if playername and money then
      local player2 = getPlayerFromName(playername)
      if player2 then
       if tonumber(money) and tonumber(money) >= 1 then
           givePlayerMoney(player2,tonumber(money))
           takePlayerMoney(player,tonumber(money))
       end
      end
    else
         outputChatBox("Use: /pagar [Jogador] [Money]",player)
    end
end
addCommandHandler("pagar",money_func)