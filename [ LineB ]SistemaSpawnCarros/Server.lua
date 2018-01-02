rRoot = getResourceRootElement(getThisResource())
Cars = {}
antiFloodMarker = {}
local cmd = 'RemoveMarker' --- Comando para Deletar Marcador 
local allowedGroup = 'Admin'
local vehicleIDS = { -- ID Veiculo
462, 549
}

addEventHandler( 'onResourceStart', rRoot,
	function( )
		executeSQLQuery( 'CREATE TABLE IF NOT EXISTS Marker_System ( posX, posY, posZ, r, g, b, ID)' )
        for i, player in ipairs( getElementsByType( 'player' ) ) do
			if isObjectInACLGroup( 'user.'..getAccountName( getPlayerAccount( player ) ), aclGetGroup( allowedGroup ) ) then
				setElementData( player, 'OpenMakerPanel', true)
			else
				setElementData( player, 'OpenMakerPanel', nil)
			end
		end	
		creatMarkerSystem()		
	end
)

function creatMarkerSystem()
	local GetAllMarker = executeSQLQuery( "SELECT * FROM Marker_System" )
	if ( type ( GetAllMarker ) == "table" and #GetAllMarker > 0 ) then
		for i = 1, #GetAllMarker do
		    local n = {GetAllMarker[i]["posX"], GetAllMarker[i]["posY"], GetAllMarker[i]["posZ"], GetAllMarker[i]["r"], GetAllMarker[i]["g"],GetAllMarker[i]["b"]}
            for ii = 1, #n do n[ ii ] = tonumber( n[ ii ] ) end			
			local marker = createMarker( n[1], n[2],   n[3], 'cylinder', 1.25, n[4], n[5], n[6], 255 )
			setElementData( marker, 'id', i )
            setElementData( marker, 'giveCarSystem', true )			
  		end
	end
end

addEventHandler( 'onMarkerHit', rRoot, function( player )
    if getElementType( player ) == 'player' and not getPedOccupiedVehicle( player ) then
      if getElementData( source, 'giveCarSystem' ) then
	  		randomCarID = tonumber(vehicleIDS[math.random(#vehicleIDS)])
			if Cars[player] and getElementType(Cars[player]) == "vehicle" then destroyElement(Cars[player]) end
				x,y,z = getElementPosition(player)
					Cars[player] = createVehicle(randomCarID, x+1,y,z)
				if Cars[player] then
					warpPedIntoVehicle(player,Cars[player])
			end	
      end
    end
end)

addEventHandler( 'onPlayerJoin', root, function()
	setElementData( source, 'OpenMakerPanel', nil)
end )

addEventHandler( 'onPlayerLogin', root, function( _, acc )
	if isObjectInACLGroup( 'user.'..getAccountName( acc ), aclGetGroup( allowedGroup ) ) then
		setElementData( source, 'OpenMakerPanel', true)
	else
		setElementData( source, 'OpenMakerPanel', nil)	
    end
end
)

addEventHandler( 'onPlayerLogout', root, function( _, acc )
    triggerClientEvent( source, 'LogOutSetVisible', root)
    setElementData( source, 'OpenMakerPanel', nil) 
end )

addEvent( 'CreateMarker', true )
addEventHandler( 'CreateMarker', root, 
function( X, Y, Z, r, g, b)
if antiFloodMarker[source] then return outputChatBox( "Por favor, aguarde 6 segundos para criar outro marcador: ", source, 255, 255, 0 ) end
antiFloodMarker[source] = true
if getPedOccupiedVehicle( source ) then Z = Z else Z = Z - 1 end
local AllMarker = executeSQLQuery( "SELECT * FROM Marker_System" )
id = #AllMarker + 1
executeSQLQuery( "INSERT INTO Marker_System ( posX, posY, posZ, r, g, b, ID ) VALUES ( "..X..", "..Y..", "..Z..", "..r..", "..g..", "..b..", "..id..")" )
local marker = createMarker( X, Y, Z, 'cylinder', 1.25, r, g, b, 255 )
setElementData( marker, 'giveCarSystem', true )
setElementData( marker, 'id', id )
outputChatBox( "Marker Was Created", source, 255, 255, 0 )
setTimer(removeFlood, 6000, 1, source)
end
)

function removeFlood(plr)
if antiFloodMarker[plr] then antiFloodMarker[plr] = false end
end

addEventHandler("onPlayerQuit",root,function()
if Cars[source] then destroyElement(Cars[source]) Cars[source] = nil end
end)

addEventHandler("onVehicleExplode",root,function()
setTimer(destroyElement,2000,1,source)
end)

addCommandHandler( cmd, function(player, Command)
    if isObjectInACLGroup( 'user.'..getAccountName( getPlayerAccount( player ) ), aclGetGroup( allowedGroup ) ) then
		local mrker = getMarkerByHit( player )
		if mrker then
			local id = tonumber ( getElementData( mrker, 'id') or 0 )
			if id == 0 then return end
			if executeSQLQuery("DELETE FROM `Marker_System` WHERE `ID`=?", id) then
				destroyElement( mrker )
				outputChatBox( "Marcador foi deletado: ", player, 255, 255, 0 )
			else
				outputChatBox( "Erro: ", player, 255, 255, 0 )		
			end
		end
	else
		outputChatBox( "Accesso negado: ", player, 255, 255, 0 )	
	end	
end
)

function getMarkerByHit( plr )
  for i, v in ipairs( getElementsByType( 'marker', rRoot ) ) do
    if isElementWithinMarker(plr, v) then
      return v
    end
  end
  return false,outputChatBox( "Erro: Por favor tente novamente: ", plr, 255, 255, 0 )
end