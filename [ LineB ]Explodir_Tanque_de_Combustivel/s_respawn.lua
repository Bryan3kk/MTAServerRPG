-- Read XML config --
xmlRoot = xmlLoadFile("settings.xml");

explRespawn = tonumber( xmlNodeGetAttribute( xmlFindSubNode(xmlRoot,"explrespawn",0) ,"value") );
fuelTank = xmlNodeGetAttribute( xmlFindSubNode(xmlRoot,"fueltank",0) ,"enabled");


--



function ProcessVehicle(veh)
	local canexp = false;
	if tonumber(fuelTank) == 1 then
		canexp = true;
	end
	setVehicleFuelTankExplodable(veh, canexp);
end

function respawnVehicle(vehicle)
	if vehicle == nil then return; end;
	if getElementType(vehicle) ~= "vehicle" then return; end;

	sx = getElementData(vehicle,"posX");
	sy = getElementData(vehicle,"posY");
	sz = getElementData(vehicle,"posZ");
	rx = getElementData(vehicle,"rotX");
	ry = getElementData(vehicle,"rotY");
	rz = getElementData(vehicle,"rotZ");
	
	spawnVehicle ( vehicle,sx, sy, sz, rx, ry, rz )

end


function ehVehicleExplode()

	setTimer ( respawnVehicle, explRespawn * 1000, 1, source )

end; addEventHandler ( "onVehicleExplode", getRootElement(), ehVehicleExplode );

function ehResStart()

	vehs = getElementsByType ( "vehicle" ) -- 
	for key,veh in ipairs(vehs) do
		ProcessVehicle(veh);
	end

end
addEventHandler ( "onResourceStart", getResourceRootElement(getThisResource()), ehResStart )