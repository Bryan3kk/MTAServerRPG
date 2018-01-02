GUIEditor = {
    memo = {},
    button = {},
    window = {},
}

addEventHandler("onClientResourceStart", resourceRoot,
    function()
        GUIEditor.window[1] = guiCreateWindow(0.29, 0.24, 0.42, 0.49, "", true)
        guiWindowSetSizable(GUIEditor.window[1], false)
		guiSetVisible(GUIEditor.window[1], false)

        bAccept = guiCreateMemo(0.08, 0.20, 0.41, 0.67, "", true, GUIEditor.window[1])
		
        bAccept = guiCreateButton(0.60, 0.20, 0.34, 0.17, "Aceitar", true, GUIEditor.window[1])
        guiSetFont(GUIEditor.button[1], "sa-header")
        guiSetProperty(GUIEditor.button[1], "NormalTextColour", "FFAAAAAA")
		addEventHandler("onClientGUIClick", bAccept, showGUIbf, false)
		addEventHandler("onClientGUIClick", bAccept, joinTeam, false)
		
        bClose = guiCreateButton(0.67, 0.61, 0.20, 0.16, "Fechar", true, GUIEditor.window[1])
        guiSetProperty(bClose, "NormalTextColour", "FFAAAAAA") 
		addEventHandler("onClientGUIClick", bClose, showGUIbf, false)
		
		GUIEditor.memo[1] = guiCreateMemo(0.08, 0.20, 0.41, 0.67, "Seja um Taxista e ganhe $500 por corrida realizada! Para começar é simples, entre em um Taxi, dirija até o icone Azul e pegue ele. Leve o passageiro para seu destino final. Fácil!", true, GUIEditor.window[1])
		
    end
)

local joinBD = createMarker(1777.05078125, -1887.853515625, 12.387156486511, "cylinder", 0.9, 255, 0, 0)


addEventHandler( "onClientResourceStart", getRootElement( ),
    function ( startedRes )
        createBlipAttachedTo( joinBD, 60);
    end
);

function showGUIbt(hitElement)
 if getElementType(hitElement) == "player" and (hitElement == localPlayer) then
 guiSetVisible(GUIEditor.window[1], true)
 showCursor( true )
 end
 end
 addEventHandler("onClientMarkerHit", joinBD, showGUIbt) 

function showGUIbf()
	guiSetVisible (GUIEditor.window[1], false )
    showCursor ( false )
end


function joinTeam()
    triggerServerEvent("sTeame", localPlayer, "teamSet")
end

