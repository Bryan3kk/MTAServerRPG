guns = {
	{22,	12},
	{23,	12},
	{24,	12},
	{28,	5},
	{29,	5},
	{32,	5},
	{25,	50},
	{26,	50},
	{27,	50},
	{30,	8},
	{31,	8},
	{33,	80},
	{34,	80},
}

addEventHandler ( "onClientPedDamage", getRootElement(),cancelEvent )

addEventHandler( "onClientResourceStart", getRootElement( ),
    function ( startedRes )
        if startedRes == getThisResource() then
		createGunMenu()
	end
    end
);


m    = { }
local rootNode = xmlLoadFile( "shops.xml" )
local markNodes = xmlNodeGetChildren(rootNode)

for i,node in ipairs(markNodes) do
	local attr = xmlNodeGetAttributes( node )
	local theMarker = createMarker(attr["posX"],attr["posY"],attr["posZ"],"corona",1.5,255,0,0)
	setElementInterior(theMarker,attr["interior"])
	if attr["pedSkinID"] then
		thePed = createPed( attr["pedSkinID"], attr["pedX"],attr["pedY"],attr["pedZ"] )
		setElementInterior(thePed,attr["interior"])
		setElementRotation(thePed,0,0,attr["pedR"])
	end
	m[i] = { theMarker, thePed }
end


function showGunMenu(hitPlayer)
	if hitPlayer == localPlayer then
		for i,v in ipairs(m) do
			if source == v[1] then
				g_px, g_py, g_pz = getElementPosition(v[2])
				playSFX3D ( "spc_fa", 13, math.random(60,72), g_px, g_py, g_pz )
			end
		end	
		guiSetVisible(guiWdw, true)
		showCursor(true)
	end
end
for i,v in ipairs(m) do addEventHandler("onClientMarkerHit",v[1],showGunMenu) end

function createGunMenu()
	guiWdw = guiCreateWindow ( 379, 208, 602, 370, "Munição", false )
	gunList = guiCreateGridList ( 0.05, 0.05, 0.3, 0.9, true, guiWdw )
	local colGun = guiGridListAddColumn( gunList, "Armas", 0.5 )
	local colCost = guiGridListAddColumn( gunList, "Preço Munição", 0.5 )
	local btnDiscard = guiCreateButton(0.4, 0.8, 0.15, 0.15, "Descartar", true, guiWdw)
	local btnClose   = guiCreateButton(0.6, 0.8, 0.15, 0.15, "Fechar", true, guiWdw)
	local btnBuy     = guiCreateButton(0.8, 0.8, 0.15, 0.15, "Comprar", true, guiWdw)
	local btnAdd = guiCreateButton(0.8, 0.1, 0.15, 0.1, "Add ao carrinho", true, guiWdw)
	editAmount = guiCreateEdit (0.4, 0.1, 0.35, 0.1, "Munição", true, guiWdw)
	guiWindowSetSizable( guiWdw, false)
	guiSetVisible(guiWdw, false)
	addEventHandler("onClientGUIClick", btnClose, clientSubmitClose, false)
	addEventHandler("onClientGUIClick", btnDiscard, clientSubmitDiscard, false)
	addEventHandler("onClientGUIClick", btnBuy, clientSubmitBuy, false)
	addEventHandler("onClientGUIClick", btnAdd, clientSubmitCart, false)
	for p,v in ipairs(guns) do
		local row = guiGridListAddRow ( gunList )
		guiGridListSetItemText ( gunList, row, colGun,  getWeaponNameFromID(v[1]), false, false )
		guiGridListSetItemText ( gunList, row, colCost, v[2], false, false )
	end

	cart = guiCreateGridList ( 0.4, 0.25, 0.55, 0.5, true, guiWdw )
	colOrdGun = guiGridListAddColumn( cart, "Arma à Comprar", 0.33 )
	colOrdAmmo = guiGridListAddColumn( cart, "Munição", 0.33 )
	colOrdCost = guiGridListAddColumn( cart, "Custo Total", 0.33 )
end

function clientSubmitBuy(button,state)
	if button == "left" and state == "up" then
		local rowCount = guiGridListGetRowCount ( cart )
		local ordCost = 0
		for i=0,rowCount-1,1 do
			ordCost = ordCost + guiGridListGetItemText ( cart, i, 3 )
		end
		local playerMoney = getPlayerMoney()
		if playerMoney < ordCost then
			outputChatBox( "Você não pode obter isso, precisa de $" .. ordCost .. "!" )
		else
			guiSetText ( editAmount, "" )
			guiSetInputEnabled(false)
			guiSetVisible(guiWdw, false)
			showCursor(false)
			for i=0,rowCount-1 do
				local ordGunName = guiGridListGetItemText ( cart, 0, 1 )
				local ordGunAmmo = guiGridListGetItemText ( cart, 0, 2 )
				local ordGunCost = guiGridListGetItemText ( cart, 0, 3 )
				triggerServerEvent( "onClientGiveWeapon", getLocalPlayer(), ordGunName, ordGunAmmo, ordGunCost )
				guiGridListRemoveRow(cart,0)
			end
			if rowCount > 0 then playSFX3D ( "spc_fa", 13, math.random(8,17), g_px, g_py, g_pz ) end
		end
	end
end

function clientSubmitCart(button,state)
	if button == "left" and state == "up" then
		local gunName = guiGridListGetItemText ( gunList, guiGridListGetSelectedItem(gunList), 1 )
		local ammo = guiGetText(editAmount)
		local cost = ammo * guiGridListGetItemText ( gunList, guiGridListGetSelectedItem(gunList), 2 )
		guiSetText ( editAmount, "" )
		local row = guiGridListAddRow ( cart )
		guiGridListSetItemText ( cart, row, colOrdGun, gunName, false, false )
		guiGridListSetItemText ( cart, row, colOrdAmmo, ammo, false, false )
		guiGridListSetItemText ( cart, row, colOrdCost, cost, false, false )
	end
end

function clientSubmitClose(button,state)
	if button == "left" and state == "up" then
		guiSetText ( editAmount, "" )
		guiSetInputEnabled(false)
		guiSetVisible(guiWdw, false)
		showCursor(false)

		local rowCount = guiGridListGetRowCount(cart)
		if rowCount > 0 then
			for i=0,rowCount-1 do guiGridListRemoveRow(cart,0) end
		end
	end
end

function clientSubmitDiscard(button,state)
	if button == "left" and state == "up" then
		local ar,ac = guiGridListGetSelectedItem(cart)
		guiGridListRemoveRow ( cart, ar )
	end
end