local allowedTeams = { 
["Mecanicos"] = true,
["Mecanico"] = true,
["Staff"] = true,
["Admins"] = true,
}

function fix ()
car = getPedOccupiedVehicle(source)
if allowedTeams[getTeamName(getPlayerTeam(source))] and getElementHealth(car) < 999 then
price = 1001 - getElementHealth(car) 
givePlayerMoney(source, price*20)
fixVehicle(car) 
outputChatBox("Você reparou o carro", source, 0, 255, 0)
end
end
addEventHandler("onPlayerVehicleEnter", getRootElement(), fix)
