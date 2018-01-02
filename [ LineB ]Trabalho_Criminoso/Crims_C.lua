OskarCrimWindow = guiCreateWindow(0.28, 0.22, 0.48, 0.53, "Trabalho de Criminoso", true)
guiWindowSetSizable(OskarCrimWindow,false)
AcceptCrimJob = guiCreateButton(0.10, 0.84, 0.35, 0.11, "Aceitar", true, OskarCrimWindow)
guiSetFont(AcceptCrimJob, "default-bold-small")
guiSetProperty(AcceptCrimJob, "NormalTextColour", "FFF4E109")
CloseCrimwind  = guiCreateButton(0.55, 0.84, 0.35, 0.11, "Cancelar", true, OskarCrimWindow)
guiSetFont(CloseCrimwind , "default-bold-small")
guiSetProperty(CloseCrimwind , "NormalTextColour", "FFCF0000")
Labelsito  = guiCreateLabel(0.03, 0.46, 0.97, 0.26, "Esse é o trabalho para homens, tente ser um dos cabeças do crime em San Andreas, clique em 'Aceitar', se você não tem coragem pra isso, cliqque em 'Cancelar'. Lembre-se, se você se tornar um criminoso a Policia vai ser sua nova 'Amiga'! ", true, OskarCrimWindow)
guiLabelSetHorizontalAlign(Labelsito, "left", true)
LabelAmarillo = guiCreateLabel(0.42, 0.40, 0.23, 0.05, "Trabalho de Criminoso", true, OskarCrimWindow)
guiLabelSetHorizontalAlign(LabelAmarillo, "left", true)
guiSetFont(LabelAmarillo, "default-bold-small")
guiLabelSetColor(LabelAmarillo, 255, 255, 0)    
guiSetVisible ( OskarCrimWindow, false )
guiSetAlpha ( OskarCrimWindow, 1.0 )
sx,sy = guiGetScreenSize()
textsToDraw = {}
maxrange = 24
addEventHandler("onClientRender",root,
    function()
        for a,b in pairs(textsToDraw) do
            x,y,z = b[1],b[2],b[3]
            scx,scy = getScreenFromWorldPosition (x,y,z)
            camX,camY,camZ = getCameraMatrix()
            if scx and scy and getDistanceBetweenPoints3D(camX,camY,camZ,x,y,z+5) <= maxrange then 
            dxDrawFramedText(b[4],scx-0.5*dxGetTextWidth(b[4],2,"sans"),scy+30-0.5*dxGetFontHeight(2,"sans"),sx, sy+5,tocolor ( b[5], b[6], b[7], 255 ), 2,"sans")
            end
        end
    end
)
function addCrimJobText(x,y,z,text,r,g,b)
    table.insert(textsToDraw,{x,y,z,text,r,g,b})
end
function dxDrawFramedText ( message , left , top , width , height , color , scale , font , alignX , alignY , clip , wordBreak , postGUI , frameColor )
	color = color or tocolor ( 255 , 255 , 255 , 255 )
	frameColor = frameColor or tocolor ( 0 , 0 , 0 , 255 )
	scale = scale or 1
	font = font or "sans"
	alignX = alignX or "left"
	alignY = alignY or "top"
	clip = clip or false
	wordBreak = wordBreak or false
	postGUI = postGUI or false
	dxDrawText ( message , left + 1 , top + 1 , width + 1 , height + 1 , frameColor , scale , font , alignX , alignY , clip , wordBreak , postGUI )
	dxDrawText ( message , left + 1 , top - 1 , width + 1 , height - 1 , frameColor , scale , font , alignX , alignY , clip , wordBreak , postGUI )
	dxDrawText ( message , left - 1 , top + 1 , width - 1 , height + 1 , frameColor , scale , font , alignX , alignY , clip , wordBreak , postGUI )
	dxDrawText ( message , left - 1 , top - 1 , width - 1 , height - 1 , frameColor , scale , font , alignX , alignY , clip , wordBreak , postGUI )
	dxDrawText ( message , left , top , width , height , color , scale , font , alignX , alignY , clip , wordBreak , postGUI )
end
local CrimMarker = createMarker(  2479.2890625, -1685.2705078125, 12.5078125, 'cylinder', 1.7, 255, 2, 0, 130)
addCrimJobText( 2479.2890625, -1685.2705078125, 14.5078125, "Trabalho de Criminoso!",255,2,2)
addCrimJobText( 1756.48828125, 781.0947265625, 11.8203125, "Trabalho de Criminoso!",255,2,2)
addCrimJobText( -2089.7763671875, 84.4169921875, 36.313430786133, "Trabalho de Criminoso!",255,2,2)
addCrimJobText(1443.8271484375, -1324.126953125, 14.539125442505, "Trabalho de Criminoso!",255,2,2)
local CrimPed = createPed ( 299, 2479.2890625, -1685.2705078125, 13.50781252)
local CrimMarkerLV = createMarker(  1756.48828125, 781.0947265625, 9.8203125, 'cylinder', 1.7, 255, 2, 0, 130)
local CrimPedLV = createPed ( 299,1756.48828125, 781.0947265625, 10.8203125)
local CrimMarkerSF = createMarker( -2089.7763671875, 84.4169921875, 34.313430786133, 'cylinder', 1.7, 255, 2, 0, 130)
local CrimPedSF = createPed ( 299, -2089.7763671875, 84.4169921875, 35.313430786133)
local CrimMarkerLS = createMarker( 1443.8271484375, -1324.126953125, 12.539125442505, 'cylinder', 1.7, 255, 2, 0, 130)
local CrimPedLS = createPed ( 299,1443.8271484375, -1324.126953125, 13.539125442505)
setPedRotation(CrimPedLS,180)
setPedRotation(CrimPedLV,90)
setPedRotation(CrimPedSF,90)
setPedFrozen ( CrimPed, not frozen )
setPedFrozen ( CrimPedLV, not frozen )
setPedFrozen ( CrimPedSF, not frozen )
setPedFrozen ( CrimPedLS, not frozen )

 function EnterTakeCrimJob ( hitElement )
	if ( hitElement == localPlayer ) then
		if (isPedInVehicle(localPlayer)) then return end
			guiSetVisible ( OskarCrimWindow, true )
			showCursor ( true )
			guiSetInputEnabled ( true )
			setElementFrozen ( hitElement, true )
    end
end
addEventHandler ("onClientMarkerHit", CrimMarker, EnterTakeCrimJob)
addEventHandler ("onClientMarkerHit", CrimMarkerLV, EnterTakeCrimJob)
addEventHandler ("onClientMarkerHit", CrimMarkerSF, EnterTakeCrimJob)
addEventHandler ("onClientMarkerHit", CrimMarkerLS, EnterTakeCrimJob)
function TakeCriminalJobs (button,state,absoluteX,absoluteY)
    if (source == AcceptCrimJob) then
		jugadorLocal = getLocalPlayer()
                    triggerServerEvent ( "jobDelCrimi",  localPlayer, jugadorLocal, 260 )
		guiSetVisible ( OskarCrimWindow, false )
		showCursor ( false )
		guiSetInputEnabled ( false )
		setElementFrozen ( localPlayer, false )
outputChatBox("Agora você é um Bandido!",255,0,0)
	elseif (source == CloseCrimwind) then
		guiSetVisible ( OskarCrimWindow, false )
		showCursor ( false )
		guiSetInputEnabled ( false )
		setElementFrozen ( localPlayer, false )
	elseif (source == btnClose) then
		guiSetVisible ( windowJobDeliveryMan, false )
		showCursor ( false )
	end
	end
addEventHandler("onClientGUIClick", getRootElement(), TakeCriminalJobs)
