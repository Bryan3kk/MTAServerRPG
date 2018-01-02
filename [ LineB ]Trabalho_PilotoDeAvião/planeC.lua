--- PLANE SPAWN WINDOW ---
planeWindow = guiCreateWindow(0.35, 0.35, 0.3, 0.3,"Trabalho de Piloto",true)
guiSetVisible (planeWindow, false)
guiSetAlpha(planeWindow,1)
guiWindowSetSizable(planeWindow,false)
selectLabel = guiCreateLabel(0.0423,0.1009,0.8889,0.078,"Selecione seu avião:",true,planeWindow)
guiSetAlpha(selectLabel,1)
guiLabelSetColor(selectLabel,255,255,255)
guiLabelSetVerticalAlign(selectLabel,"top")
guiLabelSetHorizontalAlign(selectLabel,"left",false)
guiSetFont(selectLabel,"default-bold-small")
planeGridList = guiCreateGridList(0.0476,0.1789,0.9048,0.6789,true,planeWindow)
guiGridListSetSelectionMode(planeGridList,0)
planeColumn = guiGridListAddColumn(planeGridList,"ID",0.2)
planeColumn = guiGridListAddColumn(planeGridList,"Avião",0.7)
planes = {[511] = true, [592] = true, [577] = true}
local planelist = {
{511, "KLM  Fokker 50 Cityhopper"},
{577, "KLM  Boeing 737-800"},
{592, "KLM  Boeing 747-400"}}
for i,v in ipairs (planelist) do  
    local row = guiGridListAddRow (planeGridList)
    guiGridListSetItemText (planeGridList, row, 1, (v[1]), false, true)
    guiGridListSetItemText (planeGridList, row, 2, tostring(v[2]), false, true)
end
flyButton = guiCreateButton(0.0476,0.8624,0.905,0.0963,"Get in a plane",true,planeWindow)
guiSetAlpha(flyButton,1)


--- LAS VENTURAS GATE WINDOW ---
gateLVWindow = guiCreateWindow(0.35, 0.35, 0.3, 0.2,"Aeroporto de Las Venturas",true)
guiSetVisible (gateLVWindow, false)
guiSetAlpha(gateLVWindow,1)
guiWindowSetSizable(gateLVWindow,false)
selectDestLabel = guiCreateLabel(0.0423,0.2009,0.8889,0.10,"Selecione seu destino:",true,gateLVWindow)
guiSetAlpha(selectDestLabel,1)
guiLabelSetColor(selectLabel,255,255,150)
guiLabelSetVerticalAlign(selectLabel,"top")
guiLabelSetHorizontalAlign(selectLabel,"left",false)
guiSetFont(selectLabel,"default-bold-small")
LVtoSFbutton = guiCreateButton(0.0476,0.6624,0.45,0.2963,"San Fierro",true,gateLVWindow)
guiSetAlpha(LVtoSFbutton,1)
LVtoLSbutton = guiCreateButton(0.5476,0.6624,0.45,0.2963,"Los Santos",true,gateLVWindow)
guiSetAlpha(LVtoLSbutton,1)

--- SAN FIERRO GATE WINDOW ---
gateSFWindow = guiCreateWindow(0.35, 0.35, 0.3, 0.2,"Aeroporto de San Fierro",true)
guiSetVisible (gateSFWindow, false)
guiSetAlpha(gateSFWindow,1)
guiWindowSetSizable(gateSFWindow,false)
selectDestLabel = guiCreateLabel(0.0423,0.2009,0.8889,0.10,"Selecione seu destino:",true,gateSFWindow)
guiSetAlpha(selectDestLabel,1)
guiLabelSetColor(selectLabel,255,255,150)
guiLabelSetVerticalAlign(selectLabel,"top")
guiLabelSetHorizontalAlign(selectLabel,"left",false)
guiSetFont(selectLabel,"default-bold-small")
SFtoLVbutton = guiCreateButton(0.0476,0.6624,0.45,0.2963,"Las Venturas",true,gateSFWindow)
guiSetAlpha(SFtoLVbutton,1)
SFtoLSbutton = guiCreateButton(0.5476,0.6624,0.45,0.2963,"Los Santos",true,gateSFWindow)
guiSetAlpha(SFtoLSbutton,1)

--- LOS SANTOS GATE WINDOW ---
gateLSWindow = guiCreateWindow(0.35, 0.35, 0.3, 0.2,"Aeroporto de Los Santos",true)
guiSetVisible (gateLSWindow, false)
guiSetAlpha(gateLSWindow,1)
guiWindowSetSizable(gateLSWindow,false)
selectDestLabel = guiCreateLabel(0.0423,0.2009,0.8889,0.10,"Selecione seu destino:",true,gateLSWindow)
guiSetAlpha(selectDestLabel,1)
guiLabelSetColor(selectLabel,255,255,150)
guiLabelSetVerticalAlign(selectLabel,"top")
guiLabelSetHorizontalAlign(selectLabel,"left",false)
guiSetFont(selectLabel,"default-bold-small")
LStoLVbutton = guiCreateButton(0.0476,0.6624,0.45,0.2963,"Las Venturas",true,gateLSWindow)
guiSetAlpha(SFtoLVbutton,1)
LStoSFbutton = guiCreateButton(0.5476,0.6624,0.45,0.2963,"San Fierro",true,gateLSWindow)
guiSetAlpha(SFtoLSbutton,1)


addEvent ("airLVviewGUI", true)
function airLVviewGUI ()
  if (getLocalPlayer() == source) then
    guiSetVisible (planeWindow, true)
    showCursor (true)
  end
end
addEventHandler ("airLVviewGUI", getRootElement(), airLVviewGUI)

addEvent ("gateLVviewGUI", true)
function gateLVviewGUI ()
  if (getLocalPlayer() == source) then
    guiSetVisible (gateLVWindow, true)
    showCursor (true)
  end
end
addEventHandler ("gateLVviewGUI", getRootElement(), gateLVviewGUI)

addEvent ("gateSFviewGUI", true)
function gateSFviewGUI ()
  if (getLocalPlayer() == source) then
    guiSetVisible (gateSFWindow, true)
    showCursor (true)
  end
end
addEventHandler ("gateSFviewGUI", getRootElement(), gateSFviewGUI)

addEvent ("gateLSviewGUI", true)
function gateLSviewGUI ()
  if (getLocalPlayer() == source) then
    guiSetVisible (gateLSWindow, true)
    showCursor (true)
  end
end
addEventHandler ("gateLSviewGUI", getRootElement(), gateLSviewGUI)

addEvent ("onClientGUIClick", true)
function onClientGUIClick (button, state, absoluteX, absoluteY)
if (source == flyButton) then guiSetVisible (planeWindow, false) showCursor (false)
    if (guiGridListGetSelectedItem (planeGridList)) then
      local planeID = guiGridListGetItemText (planeGridList, guiGridListGetSelectedItem (planeGridList), 1)
      triggerServerEvent ("planeSpawn", getLocalPlayer(), planeID)
    end
elseif (source == LVtoSFbutton) then guiSetVisible (gateLVWindow, false) showCursor (false)
	departure = tostring("LV")
	destination = tostring("SF")
      triggerServerEvent ("setFlightPlan", getLocalPlayer(), departure, destination)
elseif (source == LVtoLSbutton) then guiSetVisible (gateLVWindow, false) showCursor (false)
	departure = tostring("LV")
	destination = tostring("LS")
      triggerServerEvent ("setFlightPlan", getLocalPlayer(), departure, destination)
elseif (source == SFtoLVbutton) then guiSetVisible (gateSFWindow, false) showCursor (false)
	departure = tostring("SF")
	destination = tostring("LV")
      triggerServerEvent ("setFlightPlan", getLocalPlayer(), departure, destination)
elseif (source == SFtoLSbutton) then guiSetVisible (gateSFWindow, false) showCursor (false)
	departure = tostring("SF")
	destination = tostring("LS")
      triggerServerEvent ("setFlightPlan", getLocalPlayer(), departure, destination)
elseif (source == LStoLVbutton) then guiSetVisible (gateLSWindow, false) showCursor (false)
	departure = tostring("LS")
	destination = tostring("LV")
      triggerServerEvent ("setFlightPlan", getLocalPlayer(), departure, destination)
elseif (source == LStoSFbutton) then guiSetVisible (gateLSWindow, false) showCursor (false)
	departure = tostring("LS")
	destination = tostring("SF")
      triggerServerEvent ("setFlightPlan", getLocalPlayer(), departure, destination)
  end
  end
  addEventHandler ("onClientGUIClick", getRootElement(), onClientGUIClick)