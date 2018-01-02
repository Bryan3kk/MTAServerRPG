local lspdMarker = createMarker(1553.77661, -1675.02612, 15.19531,"cylinder",1) 

function onMarkerEnter(hitPlayer)
if hitPlayer == localPlayer and source == lspdMarker then
guiSetVisible(mainGUI,true)
showCursor(true)


mainGUI = guiCreateWindow(262, 215, 314, 206, "Trabalho de Policial", false)
guiWindowSetSizable(mainGUI, false)

mainMemo = guiCreateMemo(10, 41, 290, 110, "Bem-vindo a Delegacia de Los Santos. Aqui você irá combater o crime do mais váriado tipo! Se for isso que deseja, aceite o trabalho ou então cancele:", false, mainGUI)
guiMemoSetReadOnly(mainMemo, true)
mainAccept = guiCreateButton(16, 165, 93, 27, "Aceitar", false, mainGUI)
mainDecline = guiCreateButton(207, 165, 93, 27, "Cancelar", false, mainGUI)


   end
end
addEventHandler("onClientMarkerHit",getRootElement(),onMarkerEnter)

function mainDecline()
if source == mainDecline then
guiSetVisible(mainGUI,false)
showCursor(false)
   end
end
addEventHandler("onClientGUIClick",getRootElement(),mainDecline)

function mainAccept()
if source == mainAccept then
triggerServerEvent("lspdTeam",localPlayer)
   end
end
addEventHandler("onClientGUIClick",getRootElement(),mainAccept)

function lspdAccepted()
if source == mainAccept then
outputChatBox("Agora você é Policial!",9,255,0)
   end
end
addEventHandler("onClientGUIClick",getRootElement(),lspdAccepted)