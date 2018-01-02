local fpsCount = 0


function SendFPSData()
	local source = getLocalPlayer()
	triggerServerEvent ("checkFPSEvent", source, fpsCount)
	fpsCount = 0
end


function onClientResourceStart (resource)
	addEventHandler ("onClientRender", getRootElement(), fpsCounter)
	setTimer ( SendFPSData, 10000, 0)
end
addEventHandler ("onClientResourceStart", getResourceRootElement(getThisResource()), onClientResourceStart)


function fpsCounter ()
	fpsCount = fpsCount + 1
end
addEventHandler("onClientRender", getResourceRootElement(getThisResource()), fpsCounter)