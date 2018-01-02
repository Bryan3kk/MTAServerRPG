
local ptMarker = createMarker(2445.3193359375,2376.3627929688,12.163512229919, "cylinder", 1.0,0,246,255,50)
createBlipAttachedTo(ptMarker,60)

local ptLocations = { {2374.6892089844,2453.8020019531,9.8203125,2386.5104980469,2466.0422363281,9.8203125},
						{2285.9223632813,2420.5947265625,9.8203125,2290.1352539063,2429.3674316406,9.8203125},
						{2361.6052246094,2168.8100585938,9.728175163269,2371.3464355469,2166.7875976563,9.826180458069},
						{2490.9536132813,2057.4877929688,9.671875,2489.5717773438,2061.8898925781,9.8203125},
						{2217.6174316406,1879.0073242188,9.8203125,2225.0686035156,1840.8856201172,9.8203125},
						{2159.8227539063,1681.1500244141,9.69529914856,2192.9865722656,1676.9221191406,11.3671875},
						{2038.6607666016,1700.6901855469,9.671875,1968.5078125,1623.4499511719,11.860525131226},
						{2034.4288330078,1915.4116210938,9.177909851074,2021.5031738281,1919.8021240234,11.340227127075},
						{2126.4672851563,2355.6840820313,9.671875,2127.4155273438,2375.6845703125,9.8203125},
						{2039.5809326172,1007.473449707,9.671875,2023.4976806641,1007.5405273438,9.8203125}}
					

local ptNumber = {}--Para pegar um número aleatório


addEventHandler("onMarkerHit",ptMarker,
function(hitElement,matchingDimension)
	if (hitElement and getElementType(hitElement) == "player" and not isPedInVehicle(hitElement)) then
		if not (getElementData(hitElement,"AGJob") == "postman") then -- Usamos isso par verificar se o player já trabalha com isso
			triggerClientEvent("showGui", hitElement, hitElement)
		else
			outputChatBox("Seu trabalho já começou! Volte para seu veiculo e continue a trabalhar!", hitElement,100,100,100)
			
		end
	end
end)
 ptVehicle = {}
 ptVehicleBlip = {}
 ptJobMarker = {}
 ptJobBlip = {}
 newMarker = {}
 nMBlip = {}
 
function startptJob(thePlayer)
setElementData(thePlayer,"AGJob","postman")
ptVehicle[thePlayer] = createVehicle(405, 2434.855468,2376.087890,10.820312)
ptVehicleBlip[thePlayer] = createBlipAttachedTo(ptVehicle[thePlayer],51)


setElementVisibleTo(ptVehicleBlip[thePlayer],getRootElement(),false)
setElementVisibleTo(ptVehicleBlip[thePlayer],thePlayer,true)

setElementData(ptVehicle[thePlayer],"JobOwner", getPlayerName(thePlayer))
setElementData(ptVehicle[thePlayer],"AGJob","postman")
warpPedIntoVehicle(thePlayer,ptVehicle[thePlayer])
ptMarkerJob(thePlayer)
end
addEvent("giveptJob",true)
addEventHandler("giveptJob", root,startptJob)


function ptMarkerJob(thePlayer)
	if ptNumber[thePlayer] then
	--outputChatBox("ptnumber")
		if ptNumber[thePlayer] == 1 then
			ptNumber[thePlayer] = ptNumber[thePlayer] + 1
			--outputChatBox("ptnumber == 1, so + 1")
		elseif ptNumber[thePlayer] == 5 then
			ptNumber[thePlayer] = ptNumber[thePlayer] - math.random(1,3)
			--outputChatBox("ptnumber - ")
		else
			ptNumber[thePlayer] = ptNumber[thePlayer] + 1
			--outputChatBox("ptnumber + 1")
		end
	 
		
		ptJobMarker[thePlayer] = createMarker(ptLocations[ptNumber[thePlayer]][1],ptLocations[ptNumber[thePlayer]][2],ptLocations[ptNumber[thePlayer]][3],"cylinder",2,100,100,0,200)
		ptJobBlip[thePlayer] = createBlipAttachedTo(ptJobMarker[thePlayer],56)
        
		setElementData(ptJobMarker[thePlayer],"JobOwner",getPlayerName(thePlayer))
        
          
		setElementVisibleTo(ptJobMarker[thePlayer],getRootElement(),false)
		setElementVisibleTo(ptJobBlip[thePlayer],getRootElement(),false)
		setElementVisibleTo(ptJobMarker[thePlayer],thePlayer,true)
		setElementVisibleTo(ptJobBlip[thePlayer],thePlayer,true)
		addEventHandler("onMarkerHit", ptJobMarker[thePlayer], hitMarker)

	else
		ptNumber[thePlayer] = math.random(1,5)
		--outputChatBox("no ptnumber")
		--outputChatBox(ptNumber[thePlayer])
		ptJobMarker[thePlayer] = createMarker(ptLocations[ptNumber[thePlayer]][1],ptLocations[ptNumber[thePlayer]][2],ptLocations[ptNumber[thePlayer]][3],"cylinder",2,100,100,0,200)
		
  	    setElementData(ptJobMarker[thePlayer],"JobOwner",getPlayerName(thePlayer))
          
        ptJobBlip[thePlayer] = createBlipAttachedTo(ptJobMarker[thePlayer],56)
		setElementVisibleTo(ptJobMarker[thePlayer],getRootElement(),false)
		setElementVisibleTo(ptJobBlip[thePlayer],getRootElement(),false)
		setElementVisibleTo(ptJobMarker[thePlayer],thePlayer,true)
		setElementVisibleTo(ptJobBlip[thePlayer],thePlayer,true)
		addEventHandler("onMarkerHit", ptJobMarker[thePlayer], hitMarker)		
	
	end
end

function hitMarker(hitElement,matchingDimension)
	if (getElementType(hitElement) == "player" and getElementData(hitElement,"AGJob")== "postman" and isPedInVehicle(hitElement))  then
		--outputChatBox("first step")
 	    if (getElementData(source,"JobOwner") == getPlayerName(hitElement)) then  
			--outputChatBox("second step")
			local vehicle = getPedOccupiedVehicle(hitElement)

			if (getElementData(vehicle,"JobOwner") == getElementData(source,"JobOwner" )) then
				--outputChatBox("third step")
				setElementFrozen(vehicle,true)
				outputChatBox("Get out of the vehicle and go to the next marker", hitElement,0,246,255)
				newMarker[hitElement] = createMarker(ptLocations[ptNumber[hitElement]][4],ptLocations[ptNumber[hitElement]][5],ptLocations[ptNumber[hitElement]][6],"cylinder",2,100,0,100,200)
				nMBlip[hitElement] = createBlipAttachedTo(newMarker[hitElement],44)
  	    
				setElementData(newMarker[hitElement],"JobOwner",getPlayerName(hitElement))
                
				destroyElement(ptJobMarker[hitElement])
				destroyElement(ptJobBlip[hitElement])
				setElementVisibleTo(newMarker[hitElement],getRootElement(),false)
				setElementVisibleTo(nMBlip[hitElement],getRootElement(),false)
				setElementVisibleTo(newMarker[hitElement],hitElement,true)
				setElementVisibleTo(nMBlip[hitElement],hitElement,true)
				addEventHandler("onMarkerHit", newMarker[hitElement], hitMarker2)
			end
		end	
	end
end

function hitMarker2(hitElement,_)
	if (hitElement and getElementType(hitElement) == "player" and not isPedInVehicle(hitElement)) then
		if (getElementData(source,"JobOwner") == getPlayerName(hitElement)) then
        
        	setElementFrozen(hitElement,true)
			outputChatBox("As cartas foram entregues!",hitElement,3,229,250)
			destroyElement(newMarker[hitElement])
			destroyElement(nMBlip[hitElement])
		
			setTimer(unfreeze,3000,1,hitElement)
		end
	else
		local driver = getVehicleOccupant(hitElement)
		outputChatBox("Saia do veiculo para entregar as cartas!",driver,229,250,2)
	end
end

function unfreeze(thePlayer)
setElementFrozen(thePlayer, false)
setElementFrozen(ptVehicle[thePlayer],false)
givePlayerMoney(thePlayer,500)
ptMarkerJob(thePlayer)
end
	

function destroy()
	if getElementData(source,"AGJob") == "postman" then
		if isElement(ptVehicle[source]) then
			destroyElement(ptVehicle[source])
		end
		if isElement(ptVehicleBlip[source]) then
			destroyElement(ptVehicleBlip[source])
		end
		if isElement(ptJobMarker[source]) then
			destroyElement(ptJobMarker[source])
		end
		if isElement(ptJobBlip[source]) then
			destroyElement(ptJobBlip[source])
		end
		if isElement(newMarker[source]) then
			destroyElement(newMarker[source])
		end
		if isElement(nMBlip[source]) then
			destroyElement(nMBlip[source])
		end
		
			ptNumber[source] = nil
		
	end
end
addEventHandler("onPlayerQuit",getRootElement(), destroy)

addEventHandler("onVehicleExplode", getRootElement(),
function()
	if getElementData(source,"AGJob") == "postman" then
		local player = getPlayerFromName(getElementData(source,"JobOwner"))
		if isElement(ptVehicle[player]) then
			destroyElement(ptVehicle[player])
		end
		if isElement(ptVehicleBlip[player]) then
			destroyElement(ptVehicleBlip[player])
		end
		if isElement(ptJobMarker[player]) then
			destroyElement(ptJobMarker[player])
		end
		if isElement(ptJobBlip[player]) then
			destroyElement(ptJobBlip[player])
		end
		if isElement(newMarker[player]) then
			destroyElement(newMarker[player])
		end
		if isElement(nMBlip[player]) then
			destroyElement(nMBlip[player])
		end
		
		
		ptNumber[player] = nil
		setElementData(player,"AGJob",nil)
	end
end)

function allVehiclesAreDoomed ()
		vehicles = getElementsByType("vehicle")
		for i, v in ipairs(vehicles) do
			destroyElement(v)
		end
	
end
addCommandHandler("fayagong",allVehiclesAreDoomed)

addEventHandler("onVehicleStartEnter",getRootElement(),
function(player,seat,jacked,door)
if (getElementData(source,"AGJob") and getElementData(source,"AGJob")=="postman") then
	    if (getElementData(source,"JobOwner") ~= getPlayerName(player)) then
     	    cancelEvent(true)
          	    outputChatBox("Este não é o seu veiculo!",player,200,0,50)
          end
end
end)         

addEventHandler("onElementDataChange",getRootElement(),
function(dataName,oldValue)
	if getElementType(source) == "player" then
		if dataName == "AGJob" then
			if oldValue == "postman" then
				if isElement(ptVehicle[source]) then
					destroyElement(ptVehicle[source])
				end
				if isElement(ptVehicleBlip[source]) then
					destroyElement(ptVehicleBlip[source])
				end
				if isElement(ptJobMarker[source]) then
					destroyElement(ptJobMarker[source])
				end
				if isElement(ptJobBlip[source]) then
					destroyElement(ptJobBlip[source])
				end
				if isElement(newMarker[source]) then
					destroyElement(newMarker[source])
				end
				if isElement(nMBlip[source]) then
					destroyElement(nMBlip[source])
				end
				ptNumber[source] = nil

			end
		end
	end
end)