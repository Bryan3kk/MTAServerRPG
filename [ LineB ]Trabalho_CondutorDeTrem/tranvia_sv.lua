trenz = {[449]=true}
tranv = {}
tranv[1] = createMarker( -2274.451171875, 534.4072265625, 34.033840179443, 'cylinder', 2, 255, 255, 0, 200 )

addEventHandler("onResourceStart",resourceRoot,
function ()
	for index, maker in pairs(tranv) do
		createBlipAttachedTo (tranv[index], 56, 2, 255, 0, 0, 255, 0, 200, getRootElement())
		setElementData (maker, "infojob", "Condutor de Trem")
		addEventHandler ("onMarkerHit", tranv[index], verTranviaJob)
	end
end)
function verTranviaJob(hitElement)
	if (getElementType(hitElement) == "player" ) then
		if not isPedInVehicle(hitElement) then
			local wlevel = getPlayerWantedLevel ( hitElement )
			if (wlevel < 1) then
				triggerClientEvent (hitElement, "onBuscaTranviaJob", hitElement)
 		   else
				call(getResourceFromName("guitext"),"outputServerGuiText",hitElement, "Não pode trabalhar aqui se estiver sendo procurado pela policia!",255,0,0)
			end
		end
	end
end

function serTranvia ()
	setPlayerTeam (source, getTeamFromName("Civiles"))
	triggerEvent ("HijackVisible", source, source)
	call(getResourceFromName("guitext"),"outputServerGuiText",source, "[Trabalho]: Agora trabalha como Condutor de Trem:",255,255,0)
	setTimer (createBlipAttachedTo, 100, 1, source, 0, 2, 255, 255, 0)
	setElementData(source,"Ocupacion","Condutor de Trem")
	local accountData = getPlayerAccount (source)
    local datas = getAccountData(accountData, "skin")
    if datas then
    	setElementModel (source, datas)
    else
    	setElementModel (source, 0)
    end  
end
addEvent ("serTranvia", true)
addEventHandler ("serTranvia", root, serTranvia)

tranviasxd = {}
tranviasxd[1] = createMarker( -2265.0947265625, 528.5927734375, 35.210151672363, 'cylinder', 2, 255, 255, 0, 75 )

addEventHandler("onResourceStart",resourceRoot,
function ()
	for index, marker in pairs(tranviasxd) do
		local x,y,z = getElementPosition(marker)
		setElementPosition(marker,x,y,z-1)
		addEventHandler ("onMarkerHit", tranviasxd[index], verBuseroGuiCar)
	end
end)
function verBuseroGuiCar(hitElement)
	if (getElementType(hitElement) == "player" ) then
		if not isPedInVehicle(hitElement) then
			if getElementData (hitElement, "Ocupacion") == "Condutor de Trem" then
				local trenz = {{449}}
				triggerClientEvent (hitElement, "DaGuiAutos", hitElement, trenz)
			end
		end
  	end
end

function TranviaMision (player, seat)
	if getElementType(player) == "player" then
			if trenz[getElementModel(source)] then
				if getElementData (player, "Ocupacion") == "Condutor de Trem" then
					if seat == 0 then
						if getElementData (player, "PuedeHacerMision") == true then
							setElementData (player, "TranviaMision", true)
							triggerClientEvent (player, "IniciarTranvia", player)
							setElementData (player, "PuedeHacerMision", false)
							setTimer (ResetearDataMision, 10000, 1, player)
						else
							call(getResourceFromName("guitext"),"outputServerGuiText",player,"Tire um descanso, você merece...",255,0,0)
						end
					end
				end
			end	
	end
end
addEventHandler ("onVehicleEnter", root, TranviaMision)

function ResetearDataMision (player)
	if player and isElement (player) then
		setElementData (player, "PuedeHacerMision", true)
	end
end
