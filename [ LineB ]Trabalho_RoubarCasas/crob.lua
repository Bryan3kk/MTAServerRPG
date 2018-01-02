local marker = createMarker( 1755.1381835938, 766.87854003906, 10.8203125, "Cylinder", 1.5, 0, 0, 0, 0)
local ped      = createPed          (1755.1381835938, 766.87854003906, 10.8203125, 30., 200)
local marker = createMarker( 1755.1381835938, 766.87854003906, 10.8203125, "Cylinder", 1.5, 0, 0, 0, 0)
createBlip ( 1755.1381835938, 766.87854003906, 10.8203125, 56 )
    
GUIEditor_Button = {}
GUIEditor_Memo = {}
GUIEditor_Label = {}

function guiMyCwindow(w,h,t)
	local x,y = guiGetScreenSize()
	return guiCreateWindow((x-w)/2,(y-h)/2,w,h,t,false)
end
         
windowjob = guiCreateWindow(439,182,361,418,"Trabalho de Criminoso:",false)
guiSetAlpha(windowjob,1)
guiWindowSetMovable(windowjob,false)
guiWindowSetSizable(windowjob,false)
guiSetVisible(windowjob, false)
GUIEditor_Label[1] = guiCreateLabel(193,-103,5,5,"",false,windowjob)
GUIEditor_Button[1] = guiCreateButton(9,332,176,76,"Aceitar",false,windowjob)
GUIEditor_Button[2] = guiCreateButton(187,332,164,77,"Rejeitar",false,windowjob)
GUIEditor_Memo[1] = guiCreateMemo(9,25,462,307,"\n\nTrabalho de Criminoso:-\nSe você aceitar esse trabalho, você pode roubar casas.\nDirija até o local marcado, roube a casa e ganhe dinheiro\nOutra casa poderá ser roubada quando acabar. ",false,windowjob)
guiMemoSetReadOnly(GUIEditor_Memo[1],true)
         
function SAPDjob(hitElement)
    if getElementType(hitElement) == "player" and (hitElement == localPlayer) then
    if not guiGetVisible(windowjob) then
        guiSetVisible(windowjob, true)
                      showCursor(true)
                  end
             end
        end
        addEventHandler("onClientMarkerHit", marker, SAPDjob)
         
        function FBIjobleave(leaveElement)
             if getElementType(leaveElement) == "player" and (leaveElement == localPlayer) then
                  if guiGetVisible(windowjob) then
                       guiSetVisible(windowjob, false)
                       showCursor(false)
                  end
             end
        end
        addEventHandler("onClientMarkerLeave", marker, SAPDjobleave)
         
        function joinTeam()
             triggerServerEvent("gov",localPlayer)
             guiSetVisible(windowjob, false)
             showCursor(false)
        end
        addEventHandler("onClientGUIClick", GUIEditor_Button[1] , joinTeam, false)
         
        function removeSAPDWindow()
             guiSetVisible(windowjob, false)
             showCursor(false)
        end
        addEventHandler("onClientGUIClick", GUIEditor_Button[2] , removeSAPDWindow, false)