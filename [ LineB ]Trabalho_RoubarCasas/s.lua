function createSAPDTeam ()
    SAPDteam = createTeam ("Criminosos", 255, 0, 0)
end

function joincriminal()
if isObjectInACLGroup("user."..getAccountName(getPlayerAccount(source)), aclGetGroup("Everyone")) then
local wlevel = getPlayerWantedLevel( source )
end
end
addEventHandler ("onResourceStart", resourceRoot, createSAPDTeam)
 
function joinSAPD()
     setPlayerTeam(source,SAPDteam)
     setElementModel(source, 30)
	 setElementFrozen ( ped, true )
	 setElementHealth ( ped, 180 )
     giveWeapon ( source, 3 )
	 giveWeapon ( source, 31,2500 )
	 setElementData( source, "Occupation", "Governo", true )
	 setElementData ( source, "Rank", "Agente Federal" )
end
addEvent("gov", true)
addEventHandler("gov",root,joinSAPD)