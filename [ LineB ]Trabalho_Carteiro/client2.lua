
function postmanGui ()
	postWindow = guiCreateWindow(0.25,0.35,0.4,0.4, "Trabalho de Carteiro", true)
	postLabel = guiCreateLabel(0.09,0.09,0.8,0.5,[[Bem-Vindo ao trabalho de Carteiro. Aqui, você precisa entregar cartas. Você irá ver circulos amarelos no mapa, procure-os e vá entrega-las. Lembre-se, você precisar estar no seu veiculo quando estiver no circulo amarelo:]], true,postWindow)
	guiCreateStaticImage(0.4,0.4,0.2,0.2,"blip.PNG",true, postWindow)
	guiLabelSetHorizontalAlign(postLabel,"center",true)
	btnAccept = guiCreateButton(0.115,0.7,0.25,0.2, "Aceitar",true, postWindow)
	addEventHandler("onClientGUIClick",btnAccept,postAccept)
	btnReject = guiCreateButton(0.615,0.7,0.25,0.2, "Rejeitar", true, postWindow)
	addEventHandler("onClientGUIClick",btnReject,postReject)
	guiSetVisible(postWindow, false)
end


addEventHandler("onClientResourceStart", getResourceRootElement(getThisResource()),
		function ()
				postmanGui ()
		end
)
-- show the gui 
function markerhit(thePlayer)
	if ( thePlayer == getLocalPlayer() ) then
		guiSetVisible(postWindow, true)
		showCursor(true)
	end
end
addEvent("showGui",true)
addEventHandler("showGui", root, markerhit)

function postReject ()
	guiSetVisible(postWindow, false)
	showCursor(false)
end

function postAccept ()
	triggerServerEvent("giveptJob", getLocalPlayer(), getLocalPlayer() )
	postReject()
	
end
