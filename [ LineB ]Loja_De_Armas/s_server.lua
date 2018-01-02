g_Root = getRootElement()
resourceRoot = getResourceRootElement(getThisResource()) 

function giveClientWeapon(weapon, ammo, cost)
	giveWeapon(client, getWeaponIDFromName(weapon), ammo )
	takePlayerMoney( client, cost )
end
addEvent( "onClientGiveWeapon", true )
addEventHandler("onClientGiveWeapon", g_Root, giveClientWeapon)