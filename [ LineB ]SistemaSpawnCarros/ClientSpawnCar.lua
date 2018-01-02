Color = {255,0,0}
currentPosition = {}
local Key = "o"
local render = false

GUIEditor = {
    combobox = {},
    button = {},
    edit = {},
    label = {},
}

System = {}
itemTextCombobox = {"Português"}


local X, Y = guiGetScreenSize()
System.wnd = guiCreateWindow(X-343, Y/2-269/2, 333, 269, ".:: [ Criador de Spawn de Veiculos ] ::.", false)
guiSetVisible(System.wnd, not guiGetVisible(System.wnd))
guiWindowSetMovable(System.wnd, false)
guiWindowSetSizable(System.wnd, false)
guiSetAlpha(System.wnd, 1.00)
guiSetProperty(System.wnd, "CaptionColour", "FF00D2F8")

GUIEditor.label[1] = guiCreateLabel(7, 27, 415, 25, "Bem Vindo ao Sistema de Carros: ", false, System.wnd)
guiSetFont(GUIEditor.label[1], "default-bold-small")
guiLabelSetColor(GUIEditor.label[1], 248, 0, 0)
GUIEditor.label[2] = guiCreateLabel(11, 59, 111, 25, "Posição :", false, System.wnd)
guiSetFont(GUIEditor.label[2], "default-bold-small")
guiLabelSetColor(GUIEditor.label[2], 240, 237, 7)
GUIEditor.label[3] = guiCreateLabel(11, 92, 118, 21, "x", false, System.wnd)
guiSetFont(GUIEditor.label[3], "default-bold-small")
guiLabelSetColor(GUIEditor.label[3], 99, 244, 2)
GUIEditor.edit[1] = guiCreateEdit(9, 115, 130, 19, "", false, System.wnd)
GUIEditor.label[4] = guiCreateLabel(10, 140, 118, 21, "y", false, System.wnd)
guiSetFont(GUIEditor.label[4], "default-bold-small")
guiLabelSetColor(GUIEditor.label[4], 99, 244, 2)
GUIEditor.edit[2] = guiCreateEdit(10, 167, 130, 19, "", false, System.wnd)
GUIEditor.label[5] = guiCreateLabel(10, 192, 118, 21, "z", false, System.wnd)
guiSetFont(GUIEditor.label[5], "default-bold-small")
guiLabelSetColor(GUIEditor.label[5], 99, 244, 2)
GUIEditor.edit[3] = guiCreateEdit(10, 213, 130, 17, "", false, System.wnd)
GUIEditor.label[6] = guiCreateLabel(148, 59, 125, 23, "Idioma :", false, System.wnd)
guiSetFont(GUIEditor.label[6], "default-bold-small")
guiLabelSetColor(GUIEditor.label[6], 241, 232, 4)
GUIEditor.combobox[1] = guiCreateComboBox(148, 92, 171, 100, "", false, System.wnd)
for i = 1, #itemTextCombobox do
guiComboBoxAddItem(GUIEditor.combobox[1], itemTextCombobox[i])
end
GUIEditor.button[1] = guiCreateButton(146, 129, 175, 22, "Pegar Posição", false, System.wnd)
guiSetFont(GUIEditor.button[1], "default-bold-small")
guiSetProperty(GUIEditor.button[1], "NormalTextColour", "FF5CF202")
GUIEditor.button[2] = guiCreateButton(148, 161, 175, 22, "Definir cor da Marca", false, System.wnd)
guiSetFont(GUIEditor.button[2], "default-bold-small")
guiSetProperty(GUIEditor.button[2], "NormalTextColour", "FF00ACF4")
GUIEditor.button[3] = guiCreateButton(150, 202, 173, 22, "Criar Marca", false, System.wnd)
guiSetFont(GUIEditor.button[3], "default-bold-small")
guiSetProperty(GUIEditor.button[3], "NormalTextColour", "FFF40000")
GUIEditor.button[4] = guiCreateButton(298, 21, 26, 29, "X", false, System.wnd)
guiSetFont(GUIEditor.button[4], "default-bold-small")
guiSetProperty(GUIEditor.button[4], "NormalTextColour", "FFF40000")
GUIEditor.label[7] = guiCreateLabel(9, 242, 322, 21, "Criador de Spawn de Veiculos V2", false, System.wnd)
guiSetFont(GUIEditor.label[7], "default-bold-small")
guiLabelSetColor(GUIEditor.label[7], 30, 213, 207)
for k, v in pairs( GUIEditor.edit ) do guiEditSetReadOnly( v, true ) end


addEventHandler("onClientGUIClick",root,
	function ()
		if ( source == GUIEditor.button[2] ) then
			openColorPicker()
		elseif ( source == GUIEditor.button[1] ) then
			local x,y,z = getElementPosition(localPlayer)	
			guiSetText (GUIEditor.edit[1], x )
			guiSetText (GUIEditor.edit[2], y )
			guiSetText (GUIEditor.edit[3], z )
			currentPosition = {x,y,z}
		elseif ( source == GUIEditor.button[3] ) then
		    if #currentPosition == 0 then return end
			local send = {
			[1] = currentPosition[1], [2] = currentPosition[2], 
			[3] = currentPosition[3], [4] = Color[1],
			[5] = Color[2], [6] = Color[3],
			}
			newPos = {}
			triggerServerEvent("CreateMarker", localPlayer, unpack(send))
		elseif ( source == GUIEditor.button[4] ) then
			guiSetVisible(System.wnd, not guiGetVisible(System.wnd))
			showCursor(guiGetVisible(System.wnd))
			if render then
				openColorPicker()
			end		
       end
	end
)

addEventHandler ( "onClientGUIComboBoxAccepted", guiRoot,
    function ( combo )
        if ( combo == GUIEditor.combobox[1] ) then
			local text = tostring ( guiComboBoxGetItemText ( combo, guiComboBoxGetSelected ( combo ) ) )
			if ( text ) then
				local lang = AddLanguage( text )
				for k, v in pairs ( lang ) do
					guiSetText( v.element, v.id)
				end
            end
        end
    end
)

bindKey (Key, "down",
	function()
		if getElementData( localPlayer, 'OpenMakerPanel') ~= nil then	
			guiSetVisible(System.wnd, not guiGetVisible(System.wnd))
			showCursor(guiGetVisible(System.wnd))
			if render then
				openColorPicker()
			end
		end
	end	
)

addEvent( 'LogOutSetVisible', true )
addEventHandler( 'LogOutSetVisible', root, function()
	if guiGetVisible(System.Wnd) then
		guiSetVisible( System.Wnd, false )
		showCursor( false )
	end	
end)

function openColorPicker()
	if render then
		colorPicker.closeSelect()
		removeEventHandler("onClientRender", root, updateColor)	
	else
		colorPicker.openSelect()
		addEventHandler("onClientRender", root, updateColor)
	end
	render = not render
end


function updateColor()
	if (not colorPicker.isSelectOpen) then return end
	local r, g, b = colorPicker.updateTempColors()
	Color = {r,g,b}
end