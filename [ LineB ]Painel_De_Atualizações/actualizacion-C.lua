panelactual = guiCreateWindow(0.30, 0.18, 0.38, 0.69, "Painel de Atualizações", true)
guiWindowSetSizable(panelactual, false)
xml = xmlLoadFile( "info/infomemo.xml" )
contents = xmlNodeGetValue( xml )
infoactual = guiCreateMemo(0.02, 0.27, 0.96, 0.61, contents, true, panelactual)
guiMemoSetReadOnly(infoactual, true)
aceptar = guiCreateButton(0.02, 0.90, 0.34, 0.06, "Aceitar.", true, panelactual)
guiSetProperty(aceptar, "NormalTextColour", "FFAAAAAA")
asd = guiCreateButton(0.64, 0.90, 0.34, 0.06, "Cancelar.", true, panelactual)
guiSetProperty(asd, "NormalTextColour", "FFAAAAAA")
label1s = guiCreateLabel(0.02, 0.06, 0.96, 0.18, "          Olá " .. getPlayerName(localPlayer).." aqui você se informa sobre as novidades no server.\nPressione 'Aceitar' se entendeu.\nPressione 'Cancelar' se não entendeu.\nDúvidas, chame um Staff.", true, panelactual)
guiSetFont(label1s, "clear-normal")
guiLabelSetColor(label1s, 0, 102, 255)
guiSetVisible(panelactual, false)

function abrirocerrar()
	if (guiGetVisible(panelactual) == false) then
		guiSetVisible(panelactual, true)
		showCursor(true)
	else
		guiSetVisible(panelactual, false)
		showCursor(false)
	end
end
addCommandHandler( "atualizaçao", abrirocerrar)

function cerrarboton()
	outputChatBox( "Você não aceitou os termos do Painel", 0, 102, 255)
	guiSetVisible(panelactual, false)
	showCursor(false)
end
addEventHandler("onClientGUIClick", asd, cerrarboton, false)

function aceptarboton()
	outputChatBox( "Você aceitou os termos do Painel", 0, 102, 255)
	guiSetVisible(panelactual, false)
	showCursor(false)
end
addEventHandler("onClientGUIClick", aceptar, aceptarboton, false)