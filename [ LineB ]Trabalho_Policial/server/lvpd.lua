local lvpdTeam = createTeam ( "Policia Las Venturas",13,0,255)

function setTeam()
setPlayerTeam ( source, lvpdTeam )
setElementModel ( source, 282, 283  )
giveWeapon ( source, 3, 1 )
giveWeapon ( source, 23, 250 )
giveWeapon ( source, 25, 10 )
end
addEvent("lvpdTeam",true)
addEventHandler("lvpdTeam",getRootElement(),setTeam)