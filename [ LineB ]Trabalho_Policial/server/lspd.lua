local lspdTeam = createTeam ( "Policia Los Santos",13,0,255)

function setTeam()
setPlayerTeam ( source, lspdTeam )
setElementModel ( source, 280 )
giveWeapon ( source, 3, 1 )
giveWeapon ( source, 23, 250 )
giveWeapon ( source, 25, 10 )
end
addEvent("lspdTeam",true)
addEventHandler("lspdTeam",getRootElement(),setTeam)