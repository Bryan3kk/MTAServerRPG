local sfpdTeam = createTeam ( "Policia San Fierro",13,0,255)

function setTeam()
setPlayerTeam ( source, sfpdTeam )
setElementModel ( source, 281 )
giveWeapon ( source, 3, 1 )
giveWeapon ( source, 23, 250 )
giveWeapon ( source, 25, 10 )
end
addEvent("sfpdTeam",true)
addEventHandler("sfpdTeam",getRootElement(),setTeam)