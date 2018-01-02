-- Blips 
exports.customblips:createCustomBlip ( 1172.7716064453,-1323.5623779297, 20, 20, "58.png" ) -- LS Hospital
exports.customblips:createCustomBlip ( 2024.5635986328,-1404.2917480469, 20, 20, "58.png" ) -- LS Hospital2
exports.customblips:createCustomBlip ( 1242.8718261719,328.96704101563, 20, 20, "58.png" ) -- Red Country Hospital
exports.customblips:createCustomBlip ( 1607.3248291016,1818.2670898438, 20, 20, "58.png" ) -- LV Hospital
exports.customblips:createCustomBlip ( -323.08554077148,1054.4466552734, 20, 20, "58.png" ) -- Bone County Hospital
exports.customblips:createCustomBlip ( -1514.6828613281,2522.5715332031, 20, 20, "58.png" ) -- Drug Hospital
exports.customblips:createCustomBlip ( -2665.9702148438,636.59899902344, 20, 20, "58.png" ) -- SF Hospital
exports.customblips:createCustomBlip ( -2203.9689941406,-2310.3833007813, 20, 20, "58.png" ) -- Angel Pine Hospital
------------------------------------------------------------------------------------------------------------------------------------------------
local join = createMarker ( 1178.61, -1319.42, 13.12, "cylinder", 2, 0, 255, 255 )
local join1 = createMarker ( 1253.16, 328.22, 18.75, "cylinder", 2, 0, 255, 255 )
local join2 = createMarker ( -2641.51, 636.4, 13.45, "cylinder", 2, 0, 255, 255 )
local join3 = createMarker ( 1600.54, 1818.96, 9.82, "cylinder", 2, 0, 255, 255 )
local join4 = createMarker ( 2036.27, -1404.07, 16.26, "cylinder", 2, 0, 255, 255 )



GUIEditor_Button = {}
GUIEditor_Memo = {}
GUIEditor_gridlist = {}

        windowjob = guiCreateWindow(392, 176, 408, 437, "Médico", false)
        guiWindowSetSizable(windowjob, false)
guiSetVisible(windowjob, false)
        GUIEditor_Memo[1] = guiCreateMemo(18, 30, 362, 221, "Como paramédico seu trabalho é curar as pessoas.\nVocê pode curar usando seu Spreay em Lata sobre a vitima, sempre que curar alguém, irá receber uma quantia em dinheiro.\n\nVocê receberá acesso a Ambulâncias. Para uma emergência distante, pode usar o Helicóptero Médico!", false, windowjob)
        guiMemoSetReadOnly(GUIEditor_Memo[1], true)
        GUIEditor_gridlist[1] = guiCreateGridList(21, 264, 359, 115, false, windowjob)
        guiGridListAddColumn(GUIEditor_gridlist[1], "ID", 0.5)
        guiGridListAddColumn(GUIEditor_gridlist[1], "Nome da Roupa:", 0.5)
        for i = 1, 5 do
            guiGridListAddRow(GUIEditor_gridlist[1])
        end
        guiGridListSetItemText(GUIEditor_gridlist[1], 0, 1, "274", false, false)
        guiGridListSetItemText(GUIEditor_gridlist[1], 0, 2, "Médico 1", false, false)
        guiGridListSetItemText(GUIEditor_gridlist[1], 1, 1, "275", false, false)
        guiGridListSetItemText(GUIEditor_gridlist[1], 1, 2, "Médico 2", false, false)
        guiGridListSetItemText(GUIEditor_gridlist[1], 2, 1, "276", false, false)
        guiGridListSetItemText(GUIEditor_gridlist[1], 2, 2, "Médico 3", false, false)
        GUIEditor_Button[1] = guiCreateButton(21, 379, 175, 48, "Aceitar", false, windowjob)
        GUIEditor_Button[2] = guiCreateButton(206, 379, 174, 48, "Rejeitar", false, windowjob)
        
function SAPDjob(hitElement)
                setElementData ( localPlayer, "ownskin", getElementModel (localPlayer)  )
    if getElementType(hitElement) == "player" and (hitElement == localPlayer) then
    if not guiGetVisible(windowjob) then
        guiSetVisible(windowjob, true)
                      showCursor(true)
                  end
             end
        end
        addEventHandler("onClientMarkerHit", join, SAPDjob)
        addEventHandler("onClientMarkerHit", join1, SAPDjob)
        addEventHandler("onClientMarkerHit", join2, SAPDjob)
        addEventHandler("onClientMarkerHit", join3, SAPDjob)
        addEventHandler("onClientMarkerHit", join4, SAPDjob)
         
        function FBIjobleave(leaveElement)
        
             if getElementType(leaveElement) == "player" and (leaveElement == localPlayer) then
                  if guiGetVisible(windowjob) then
                       guiSetVisible(windowjob, false)
                       showCursor(false)
                  end
             end
        end
        addEventHandler("onClientMarkerLeave", marker, SAPDjobleave)
        function setskintest()
        local skin = guiGridListGetItemText ( GUIEditor_gridlist[1], guiGridListGetSelectedItem ( GUIEditor_gridlist[1] ), 1 )
        setElementModel ( localPlayer, skin )
        end
             addEventHandler ( "onClientGUIClick", GUIEditor_gridlist[1], setskintest, false )
        function joinTeam()
        triggerServerEvent("MMedic",localPlayer)
             local skin = guiGridListGetItemText ( GUIEditor_gridlist[1], guiGridListGetSelectedItem ( GUIEditor_gridlist[1] ), 1 )
             if skin ~= 0 or getElementData(localPlayer, "ownskin") then
             guiSetVisible(windowjob, false)
             showCursor(false)
             setElementModel ( localPlayer, skin )
             else
             exports["DENdxmsg"]:sendClientMessage ("Você não selecionou uma Skin!", 255, 0, 0 )
             
        end
        end
        addEventHandler("onClientGUIClick", GUIEditor_Button[1] , joinTeam, false)
         
        function removeSAPDWindow()
        guiSetVisible(windowjob, false)
        showCursor(false)
        setElementModel(localPlayer, getElementData(localPlayer, "ownskin"))
             
        end
        
        
        addEventHandler("onClientGUIClick", GUIEditor_Button[2] , removeSAPDWindow, false)