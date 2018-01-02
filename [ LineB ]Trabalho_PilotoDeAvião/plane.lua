rootElement = getRootElement()
local lvairportblip = createBlip(1674, 1447.5, 11, 5)

planemarkerlv = createMarker(1674, 1447.5, 9.5, "cylinder", 5, 255, 0, 0, 160)
gate1LVmarker = createMarker(1576.5, 1495.30, 13, "cylinder", 18, 0, 155, 255, 30)
gate2LVmarker = createMarker(1570.8, 1532.87, 13, "cylinder", 18, 0, 155, 255, 30)
gate3LVmarker = createMarker(1602.5, 1546.54, 13, "cylinder", 18, 0, 155, 255, 30)
gate4LVmarker = createMarker(1576.7, 1401.46, 13, "cylinder", 18, 0, 155, 255, 30)
gate5LVmarker = createMarker(1570.8, 1363.94, 13, "cylinder", 18, 0, 155, 255, 30)
gate6LVmarker = createMarker(1601.4, 1350.91, 13, "cylinder", 18, 0, 155, 255, 30)


gate1SFmarker = createMarker(-1350.1, -235.77, 16, "cylinder", 18, 0, 155, 255, 30)
gate2SFmarker = createMarker(-1298.6, -366.46, 16, "cylinder", 18, 0, 155, 255, 30)
gate3SFmarker = createMarker(-1462.2, -157.35, 16, "cylinder", 18, 0, 155, 255, 30)
gate4SFmarker = createMarker(-1362.5, -146.57, 16, "cylinder", 18, 0, 155, 255, 30)
gate5SFmarker = createMarker(-1257.2, -252.85, 16, "cylinder", 18, 0, 155, 255, 30)

gate1LSmarker = createMarker(1569.78, -2433.4, 15, "cylinder", 18, 0, 155, 255, 30)
gate2LSmarker = createMarker(1654.20, -2440, 15, "cylinder", 18, 0, 155, 255, 30)
gate3LSmarker = createMarker(1884.6, -2388.15, 15, "cylinder", 18, 0, 155, 255, 30)

addEvent ("airLVviewGUI", true)
function markerHit (hitPlayer, matchingDimension)
  if (source == planemarkerlv) then
    triggerClientEvent ("airLVviewGUI", hitPlayer)
    outputChatBox ("#ffffffBem-Vindo ao aeroporto de Las Venturas!", hitPlayer, 255, 255, 255)
  end
end
addEventHandler ("onMarkerHit", getRootElement(), markerHit)

addEvent ("gateLVviewGUI", true)
function markerHitLVgate (hitPlayer, matchingDimension)
local theVehicle = getPedOccupiedVehicle (hitPlayer)
local id = getElementModel(theVehicle)
  if ((source == gate1LVmarker) or (source == gate2LVmarker) or (source == gate3LVmarker) or (source == gate4LVmarker) or (source == gate5LVmarker) or (source == gate6LVmarker)) and (id == 511 or id == 577 or id == 592) then
    if ((getAccountData (getPlayerAccount (hitPlayer), "flightDestination")) == "LV") then
	givePlayerMoney (hitPlayer, 2000)
	outputChatBox ("#ffffffBem-Vindo à Las Venturas Int. Espere enquanto você é descarregado.", hitPlayer, 255, 255, 0)
	end	
	triggerClientEvent ("gateLVviewGUI", hitPlayer)
	setTimer(function()
    outputChatBox ("#ffffffVocê está carregado e pronto para decolar!", hitPlayer, 255, 255, 0) end,
	5000,1)
		elseif ((source == gate1LVmarker) or (source == gate2LVmarker) or (source == gate3LVmarker) or (source == gate4LVmarker) or (source == gate5LVmarker) or (source == gate6LVmarker)) then
	outputChatBox ("#ffffffVocê não pode pegar passageiros sem um avião!", hitPlayer, 255, 0, 0)
  end
end
addEventHandler ("onMarkerHit", getRootElement(), markerHitLVgate)


addEvent ("gateSFviewGUI", true)
function markerHitSFgate (hitPlayer, matchingDimension)
local theVehicle = getPedOccupiedVehicle (hitPlayer)
local id = getElementModel(theVehicle)
  if ((source == gate1SFmarker) or (source == gate2SFmarker) or (source == gate3SFmarker) or (source == gate4SFmarker) or (source == gate5SFmarker)) and (id == 511 or id == 577 or id == 592) then
    if ((getAccountData (getPlayerAccount (hitPlayer), "flightDestination")) == "SF")  then
	givePlayerMoney (hitPlayer, 2000)
	outputChatBox ("#ffffffBem-Vindo à San Fierro Int. Espere enquanto você é descarregado.", hitPlayer, 255, 255, 0)
	end
	triggerClientEvent ("gateSFviewGUI", hitPlayer)
	setTimer(function()
    outputChatBox ("#ffffffVocê está carregado e pronto para decolar!", hitPlayer, 255, 255, 0) end,
	5000,1)
	elseif ((source == gate1SFmarker) or (source == gate2SFmarker) or (source == gate3SFmarker)) then
	outputChatBox ("#ffffffVocê não pode pegar passageiros sem um avião!", hitPlayer, 255, 0, 0)
  end
end
addEventHandler ("onMarkerHit", getRootElement(), markerHitSFgate)

addEvent ("gateLSviewGUI", true)
function markerHitLSgate (hitPlayer, matchingDimension)
local theVehicle = getPedOccupiedVehicle (hitPlayer)
local id = getElementModel(theVehicle)
  if ((source == gate1LSmarker) or (source == gate2LSmarker) or (source == gate3LSmarker)) and (id == 511 or id == 577 or id == 592) then
	if ((getAccountData (getPlayerAccount (hitPlayer), "flightDestination")) == "LS")  then
	outputChatBox ("#ffffffBem-Vindo à Los Santos Int. Espere enquanto você é descarregado.", hitPlayer, 255, 255, 0)
    givePlayerMoney(hitPlayer, 2000)	
	end
	triggerClientEvent ("gateLSviewGUI", hitPlayer)
    setTimer(function()
    outputChatBox ("#ffffffVocê está carregado e pronto para decolar!", hitPlayer, 0, 255, 0) end,
	5000,1)
	elseif ((source == gate1LSmarker) or (source == gate2LSmarker) or (source == gate3LSmarker)) then
	outputChatBox ("#ffffffVocê não pode pegar passageiros sem um avião!", hitPlayer, 255, 0, 0)
  end
end
addEventHandler ("onMarkerHit", getRootElement(), markerHitLSgate)

addEvent ("planeSpawn", true)
addEventHandler ("planeSpawn", getRootElement(),
	function (aircraft)
	Plane = createVehicle(tonumber(aircraft), 1477.4, 1270.9, 11)
	setCameraMatrix(1502, 1292, 11, 1475, 1288, 13.8, 90, 90)
	warpPedIntoVehicle ( source, Plane )
    outputChatBox ("Pegue passageiros no terminal.", source, 0, 255, 0)
	
end)

addEvent ("setFlightPlan", true)
addEventHandler ("setFlightPlan", getRootElement(),
	function (departure, destination)
	
	outputChatBox (departure.." #fff600[Torre de Controle]: #ffffffVocê tem permissão para pousar na pista 69.", source, 255, 255, 255) 
	setTimer(function() 
	outputChatBox (departure.." #fff600[Torre de Controle]: #ffffffVocê tem permissão para decolar.", source, 0, 255, 0) 
	outputChatBox (departure.." #fff600[Torre de Controle]: #ffffffTenha um bom vôo para "..destination, source, 0, 255, 0) end, 12000,1)
	
	setAccountData (getPlayerAccount (source), "flightDeparture", (tostring(departure)))
    setAccountData (getPlayerAccount (source), "flightDestination", (tostring(destination)))
	setElementData(source, "flightDeparture", departure)
	setElementData(source, "flightDestination", destination)
	
end)

addEvent ("destroyPlane", true)
function destroyplane()
local theVehicle = getPedOccupiedVehicle (source)
local id = getElementModel(theVehicle)
if (id == 511 or id == 577 or id == 592) then
destroyElement(Plane)
else
end
end


addEvent ("visiblePlaneMarkers", true)
function visiblePlaneMarkers(thePlayer)
local theVehicle = getPedOccupiedVehicle (thePlayer)
local id = getElementModel(theVehicle)
if (id == 511 or id == 577 or id == 592) then

else 
end
end

addEventHandler("onVehicleEnter", rootElement, visiblePlaneMarkers)
addEventHandler("onVehicleExit", rootElement, destroyplane)
addEventHandler("onPlayerQuit", rootElement, destroyplane)