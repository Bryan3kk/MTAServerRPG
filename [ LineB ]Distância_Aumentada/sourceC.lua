function v1()
	setFarClipDistance(7000)
	setCloudsEnabled(false)	
	setFogDistance(0) 
	outputChatBox("Distância aumentada #FF0000'Ativada'#FFFFFF, para desativar use: /Lag")
end
addEventHandler("onClientResourceStart", resourceRoot, v1)
addEventHandler("onPlayerJoin", resourceRoot, v1)
addCommandHandler("fast", v1)



addCommandHandler("lag", function()
	setFarClipDistance(1000) 
	setCloudsEnabled(false)
	setFogDistance(0)
	outputChatBox("Distância aumentada 'Desativada', para ativar use: /Fast")	
end)



function v2()
	setFarClipDistance(nil)
	setCloudsEnabled(true)	
	setFogDistance(nil) 
	outputChatBox("Distância aumentada 'Desativada'")
end
addEventHandler("onClientResourceStop", resourceRoot, v2)


