enableBlips = get("enableSpeedcamBlips")

thisResource = getResourceRootElement(getThisResource())

function createSpeedFunc()
local speedcams = getElementsByType ("speedcam", resourceRoot)
num=0
id=0
speedcam = { }
speedBlip = { }
speedID = { }
	for key,val in ipairs(speedcams) do
		num=num+1
		id=id+1
		speedX = getElementData(val, "x")
		speedY = getElementData(val, "y")
		speedZ = getElementData(val, "z")
		size = getElementData(val, "size")
		ticketCost = getElementData(val, "ticketCost")
		requiredSpeed = getElementData(val, "requiredSpeed")
		speedcam[num] = createMarker (speedX, speedY, speedZ, "cylinder", size, 255, 200, 0, 0, root)
		setElementData(speedcam[num], "id", tonumber(id), true)
		setElementData(speedcam[num], "speedcam", speedcam[num])
		setElementData(speedcam[num], "x", speedX)
		setElementData(speedcam[num], "y", speedY)
		setElementData(speedcam[num], "z", speedZ)
		setElementData(speedcam[num], "ticketCost", ticketCost)
		setElementData(speedcam[num], "requiredSpeed", requiredSpeed)
		speedcamData = getElementData(speedcam[num], "speedcam")
		addEventHandler("onMarkerHit", speedcamData, triggerFlashShit)
		if enableBlips == "true" then
			for m,n in ipairs(speedcam) do
				local blip = createBlip(speedX, speedY, speedZ, 0, 1, 255, 0, 0, 255, 0, 70, getRootElement())
				setBlipVisibleDistance(blip, 200)
			end	
		end
	end
end
addEventHandler("onResourceStart", resourceRoot, createSpeedFunc)
    
	function triggerFlashShit(hitElement)
        if (getElementType(hitElement) == "player" ) then
            local vehicle = getPedOccupiedVehicle(hitElement)
            if (getElementType(vehicle) == "vehicle" ) then
			local driver = getVehicleOccupant ( vehicle )
			if (driver) then
            local speedx, speedy, speedz = getElementVelocity(vehicle)
			local cX, cY, cZ = getElementPosition(vehicle)
                local playerAcc = getPlayerAccount(hitElement)
                local pWanted = getPlayerWantedLevel(hitElement)
                local pMoney = getPlayerMoney(hitElement)
                
                actualSpeed = (speedx^2 + speedy^2 + speedz^2)^(0.5)
                
                mph = math.floor(actualSpeed * 111.847)
                
                if (mph >= tonumber(requiredSpeed) ) and (getPlayerWantedLevel(hitElement) <=6 ) then
                    if (pMoney >= tonumber(ticketCost) ) then
                    outputChatBox("Você foi Multado (Razão : Ultrapassou o limite de: "..requiredSpeed.." Km/h)", hitElement, 255, 200, 0, false)
                    outputChatBox("Velocidade: "..mph.." Km/h", hitElement, 255, 200, 0, false)
                    outputChatBox("Valor da multa: "..ticketCost.."$", hitElement, 255, 200, 0, false)
                    setTimer(triggerClientEvent, 100, 1, "showPicture", hitElement)
                    takePlayerMoney(hitElement, tonumber(ticketCost))
                    fadeCamera(hitElement, false, 0.5, 255, 255, 255)
                    setTimer(fadeCamera, 100, 1, hitElement, true, 1.0, 255, 255, 255)

                        elseif (pMoney <=tonumber(ticketCost) ) and (getPlayerWantedLevel(hitElement) <=6 ) then
                        setPlayerWantedLevel(hitElement, math.min(6, getPlayerWantedLevel(hitElement) + 2))
                        setTimer(triggerClientEvent, 100, 1, "showPicture", hitElement)
                        outputChatBox("Você foi Multado (Razão : Ultrapassou o limite de: "..requiredSpeed.." Km/h)", hitElement, 255, 200, 0, false)
                        outputChatBox("Velocidade : "..mph.." Km/h", hitElement, 255, 200, 0, false)
                        outputChatBox("Você não possui dinheiro para pagar a multa:", hitElement, 255, 0, 0, false)
                        outputChatBox("Multa: "..ticketCost.."$", hitElement, 255, 0, 0, false)
                        outputChatBox("Seu dinheiro: "..getPlayerMoney(hitElement).."$", hitElement, 255, 0, 0, false)
                        fadeCamera(hitElement, false, 0.5, 255, 255, 255)
                        setTimer(fadeCamera, 100, 1, hitElement, true, 1.0, 255, 255, 255) 
                                end
                            end
                    end
					else
					return end
        end
        end