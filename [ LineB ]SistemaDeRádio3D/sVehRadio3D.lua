g_VehicleList = {}

local radioStreams = 0
local defaultRadio = "http://icecast.funx.nl:8000/funx-dance.m3u"
local defaultRadio = "http://64.56.64.82:14596"

addEventHandler("onResourceStart", resourceRoot,
	function()	
		for i,veh in ipairs(getElementsByType("vehicle")) do
			g_VehicleList[veh] = { }
			g_VehicleList[veh].radio = false
			g_VehicleList[veh].radioStation = defaultRadio
			g_VehicleList[veh].volume = 100.0
		end
	end
)

addEventHandler("onPlayerJoin", root,
	function()		
		for i,veh in ipairs(getElementsByType("vehicle")) do
			if g_VehicleList[veh] ~= nil then
				if g_VehicleList[veh].radio == true then
					triggerClientEvent(source, "onServerToggleRadio", root, true, g_VehicleList[veh].radioStation, veh, g_VehicleList[veh].volume)
				end
			end
		end
	end
)

addEventHandler("onVehicleExplode", root,
	function()
		if g_VehicleList[source] ~= nil then
			if g_VehicleList[source].radio == true then
				triggerClientEvent("onServerToggleRadio", root, false, nil, source)
				g_VehicleList[source].radio = false
				destroyElement(g_VehicleList[source].radioMarker)
				killTimer(g_VehicleList[source].idleTimer)
				if radioStreams ~= 0 then
					radioStreams = radioStreams - 1
				end
			end
		end
	end
)

addEventHandler("onElementDestroy", root,
	function()
		if g_VehicleList[source] ~= nil then
			if g_VehicleList[source].radio == true then
				triggerClientEvent("onServerToggleRadio", root, false, nil, source)
				g_VehicleList[source].radio = false
				destroyElement(g_VehicleList[source].radioMarker)
				killTimer(g_VehicleList[source].idleTimer)
				if radioStreams ~= 0 then
					radioStreams = radioStreams - 1
				end
			end
		end
	end
)

addEvent("onPlayerToggleRadio", true)
addEventHandler("onPlayerToggleRadio", root,
	function()
		if source and getElementType(source) == "player" then
			toggleRadio(source)
		end
	end
)

function toggleRadio(player)
	local veh = getPedOccupiedVehicle(player)
	if veh then
		local occupants = getVehicleOccupants(veh)
		local seats = getVehicleMaxPassengers(veh)
		
		local playerSeat = getPedOccupiedVehicleSeat(player)
		if playerSeat ~= 0 and playerSeat ~= 1 then
			outputChatBox("Você não pode mudar o rádio.", player, 255, 255, 255)
			return
		end

		if g_VehicleList[veh] == nil then
			g_VehicleList[veh] = { }
			g_VehicleList[veh].radio = false
			g_VehicleList[veh].radioStation = defaultRadio
			g_VehicleList[veh].volume = 100.0
		end
		
		if g_VehicleList[veh].radio == false then
			if not get("toggleAntifloodTick") or not get("streamLimit") or not get("radioEnabledIdleTime") then return end

			local settingToggleAntifloodTick = get("toggleAntifloodTick")
			local settingStreamLimit = get("streamLimit")
			local idleTime = get("radioEnabledIdleTime")
			
			if g_VehicleList[veh].lastTick and (getTickCount() - g_VehicleList[veh].lastTick) <= settingToggleAntifloodTick then return end

			if radioStreams >= settingStreamLimit then
				outputChatBox("Você atingiu o limite de streams (" .. settingStreamLimit .. ")", player, 255, 255, 255)
				return
			end
			
			local x, y, z = getElementPosition(veh)
			g_VehicleList[veh].radio = true
			g_VehicleList[veh].lastTick = getTickCount()
			g_VehicleList[veh].turnedOnBy = getPlayerName(player)
			g_VehicleList[veh].radioMarker = createMarker(x, y, z, "corona", 0.05, 255, 0, 0)
			attachElements(g_VehicleList[veh].radioMarker, veh)
			g_VehicleList[veh].idleTimer = setTimer(radioIdleTimer, idleTime, 0, veh)
			
			radioStreams = radioStreams + 1
			outputServerLog(getPlayerName(player) .. " ligou o rádio: (Streams: " .. radioStreams .. ")")

			for seat = 0, seats do
				local occupant = occupants[seat]
				if occupant and getElementType(occupant) == "player" then
					triggerClientEvent("onServerToggleRadio", root, true, g_VehicleList[veh].radioStation, veh, g_VehicleList[veh].volume)
					
					local r, g, b = getPlayerNametagColor(player)
					colorHex = string.format("%02X%02X%02X", r, g, b)
					outputChatBox("#" .. colorHex .. "" .. getPlayerName(player) .. " #FFFFFF[ Rádio ]: #FFFFFF[#00FF00 LIGADO #FFFFFF]", occupant, 0, 0, 0, true)
				end
			end
		else		
			g_VehicleList[veh].radio = false
			destroyElement(g_VehicleList[veh].radioMarker)
			killTimer(g_VehicleList[veh].idleTimer)
			
			radioStreams = radioStreams - 1
			outputServerLog(getPlayerName(player) .. " Desligou o rádio. (Streams: " .. radioStreams .. ")")
			
			for seat = 0, seats do
				local occupant = occupants[seat]
				if occupant and getElementType(occupant) == "player" then
					triggerClientEvent("onServerToggleRadio", root, false, nil, veh, g_VehicleList[veh].volume)
					
					local r, g, b = getPlayerNametagColor(player)
					colorHex = string.format("%02X%02X%02X", r, g, b)
					outputChatBox("#" .. colorHex .. "" .. getPlayerName(player) .. " #FFFFFF[ Rádio ]: #FFFFFF[#ff0000 DESLIGADO #FFFFFF]", occupant, 0, 0, 0, true)
				end
			end
		end
	end
end

function radioIdleTimer(veh)
	if not get("radioIdlePlayerDistanceCheck") then return end
	local settingDist = get("radioIdlePlayerDistanceCheck")
	
	if veh then		
		if g_VehicleList[veh] ~= nil then
			if g_VehicleList[veh].radio == true then
				local playerInRange = false

				local vx, vy, vz = getElementPosition(veh)
				for i,player in ipairs(getElementsByType("player")) do
					local px, py, pz = getElementPosition(player)
					local distance = getDistanceBetweenPoints3D(vx, vy, vz, px, py, pz)
					if distance ~= false and distance < settingDist then
						playerInRange = true
					end
				end
				
				if playerInRange == false then
					triggerClientEvent("onServerToggleRadio", root, false, nil, veh)
					g_VehicleList[veh].radio = false
					destroyElement(g_VehicleList[veh].radioMarker)
					killTimer(g_VehicleList[veh].idleTimer)
					if radioStreams ~= 0 then
						radioStreams = radioStreams - 1
					end
				
					outputServerLog("O " .. getVehicleName(veh) .. " rádio foi alterado (Streams: " .. radioStreams .. ")")
				end
			end
		end
	end
end

addEvent("onPlayerRadioVolumeChange", true)
addEventHandler("onPlayerRadioVolumeChange", root,
	function(currentVol, volumeUp)
		local veh = getPedOccupiedVehicle(source)
		if veh then
			local playerSeat = getPedOccupiedVehicleSeat(source)
			if playerSeat == 0 or playerSeat == 1 then
				if volumeUp == true then
					g_VehicleList[veh].volume = currentVol + 0.05
					if g_VehicleList[veh].volume >= 100.00 then
						g_VehicleList[veh].volume = 1.00
					end
				else
					g_VehicleList[veh].volume = currentVol - 0.05
					if g_VehicleList[veh].volume <= 0.00 then
						g_VehicleList[veh].volume = 0.00
					end
				end
				triggerClientEvent("onServerVolumeChangeAccept", root, veh, g_VehicleList[veh].volume)
			end
		end
	end
)

function cmdChangeRadioURL(source, commandName, url)
	if not url then
		outputChatBox("Tutorial: /setradio [Link]", source, 255, 255, 255)
		return
	end

	local veh = getPedOccupiedVehicle(source)
	if veh then
		local occupants = getVehicleOccupants(veh)
		local seats = getVehicleMaxPassengers(veh)
		
		if g_VehicleList[veh] == nil then
			local x, y, z = getElementPosition(veh)
			g_VehicleList[veh] = { }
			g_VehicleList[veh].radio = true
			g_VehicleList[veh].lastTick = getTickCount()
			g_VehicleList[veh].radioStation = defaultRadio
			g_VehicleList[veh].volume = 100.0
			g_VehicleList[veh].radioMarker = createMarker(x, y, z, "corona", 0.1, 255, 0, 0)
			attachElements(g_VehicleList[veh].radioMarker, veh)
			g_VehicleList[veh].idleTimer = setTimer(radioIdleTimer, idleTime, 0, veh)
		end

		local playerSeat = getPedOccupiedVehicleSeat(source)
		if playerSeat ~= 0 and playerSeat ~= 1 then
			outputChatBox("Você não pode trocar o rádio.", source, 255, 255, 255)
			return
		end
		
		for seat = 0, seats do
			local occupant = occupants[seat]
			if occupant and getElementType(occupant) == "player" then
				g_VehicleList[veh].radioStation = url
				g_VehicleList[veh].changedBy = getPlayerName(source)
				
				if g_VehicleList[veh].radio == true then
					triggerClientEvent("onServerRadioURLChange", root, g_VehicleList[veh].radioStation, veh, g_VehicleList[veh].volume)
				end
				
				local r, g, b = getPlayerNametagColor(source)
				colorHex = string.format("%02X%02X%02X", r, g, b)
				outputChatBox("#" .. colorHex .. "" .. getPlayerName(source) .. " #FFFFFFalterou o rádio.", occupant, 0, 0, 0, true)
				outputConsole(getPlayerName(source) .. " alterou o rádio do carro para: " .. url, occupant)
			end
		end
		outputServerLog(getPlayerName(source) .. " alterou o rádio do carro para: " .. url)
	end
end

function cmdDumpVehRadioInfo(source, commandName)
	for i,veh in ipairs(getElementsByType("vehicle")) do
		if g_VehicleList[veh] ~= nil then
			if g_VehicleList[veh].radio == true then
				local strOut
				if g_VehicleList[veh].changedBy ~= nil then
					strOut = "Carro: " .. getVehicleName(veh) .. ", URL = " .. g_VehicleList[veh].radioStation .. ", Alterado por: " .. g_VehicleList[veh].turnedOnBy .. ", Alterado por: " .. g_VehicleList[veh].changedBy
				else
					strOut = "Carro: " .. getVehicleName(veh) .. ", URL = " .. g_VehicleList[veh].radioStation .. ", Alterado por: " .. g_VehicleList[veh].turnedOnBy
				end
				
				if getElementType(source) == "console" then
					outputServerLog(strOut)
				elseif getElementType(source) == "player" then
					outputChatBox(strOut, source, 255, 255, 255)
				end
			end
		end
	end
end

addCommandHandler("setradio", cmdChangeRadioURL)
addCommandHandler("dumpradio", cmdDumpVehRadioInfo)
