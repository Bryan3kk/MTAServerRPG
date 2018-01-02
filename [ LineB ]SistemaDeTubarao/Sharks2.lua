
players = {}
function check()
	players = nil
	players = getElementsByType( "player" )
	for k,v in ipairs (players) do
		if (v ~= false) then
			if (getElementType(v) == "player") then
				if (isElementInWater(v) == true ) then
					if (isPedInVehicle(v) == false ) then
						if getElementData ( v, "sharksPass" ) ~= false then
							setElementData ( v, "sharksPass",getElementData ( v, "sharksPass" )+1 )
						end
						if getElementData ( v, "sharksPass" ) == false then
							setElementData ( v, "sharksPass",1 )
						end
						x,y,z = getElementPosition ( v )
						if z < 1 then
							if (isElement(getElementData ( v, "sharknullObject" )) == false) then
								if isElement(getElementData ( v, "sharknullObject" )) then
									destroyElement(getElementData ( v, "sharknullObject" ))
									setElementData ( v, "sharknullObject",nil )
								end
								if isElement(getElementData ( v, "sharkshark1" )) then
									destroyElement(getElementData ( v, "sharkshark1" ))
									setElementData ( v, "sharkshark1",nil )
								end
								nullObject = createObject( 3027,x,y,z-5)
								setElementData ( v, "sharknullObject", nullObject )
								setElementData ( nullObject, "sharkOwner", v )
								setElementAlpha(nullObject,0)
								shark1 = createObject (1608,x+10,y,z-5)
								setElementData ( v, "sharkshark1", shark1 )
								attachElements(getElementData ( v, "sharkshark1" ),getElementData ( v, "sharknullObject" ),0+10,0,-0.3)
							end
							moveObject(getElementData ( v, "sharknullObject" ),5000,x,y,z,0,0,179.9)
							if getElementData ( v, "sharksPass" ) > 8 then
								setElementData ( v, "sharksPass",0 )
								shark2 = createObject (1608,x,y-15,z-10,45,0,0)
								setElementData ( v, "sharkshark2", shark2 )
								moveObject(getElementData ( v, "sharkshark2" ),2500,x,y-5,z+1,-45,0,0)
								setTimer (function (v)
									if isElement(v) then
										x,y,z = getElementPosition (getElementData ( getElementData ( v, "sharknullObject"), "sharkOwner" ))
										v = getElementData ( getElementData ( v, "sharknullObject"), "sharkOwner" )
										local vx, vy, vz = getElementPosition (getElementData ( v, "sharkshark2" ))
										local sx = x - vx
										local sy = y - vy
										local sz = z - vz
										local new = sx^2 + sy^2 + sz^2
										if new < 30 then
										H = getElementHealth (v)
											if H < 30 then
												setElementHealth (v,1)
												setPedHeadless  (v,true)
												setTimer (function (v)
													local x,y,z = getElementPosition (v)
													killPed ( v, nil, nil, 9 )
													local zone = getZoneName (x, y, z )
													if zone ~= "Unknown" then
													else
													end
												end,2500, 1,v)	
												setTimer (function (v)
													setPedHeadless  (v,false)
												end,4500, 1,v)
											else
												setElementHealth (v,H-100)
											end
											triggerClientEvent ( "ClientSharkFxBlood", getRootElement(), x, y, z )
										end
										triggerClientEvent ( "ClientSharkFxSplash", getRootElement(), x, y, z )
										moveObject(getElementData ( v, "sharkshark2" ),2500,x,y+15,z-10,-45,0,0)
									end
								end,2500, 1,v)
								setTimer (function (v)
									if isElement(v) then
										if isElement(getElementData ( v, "sharkshark2" )) then
											destroyElement(getElementData ( v, "sharkshark2" ))
										end
										setElementData ( v, "sharkshark2",nil )
										setElementData ( v, "sharksPass",0 )
									end
								end,5000, 1,v)
							end
						else
							deleteSharks (v)
						end
					else
						deleteSharks (v)
					end
				else
					deleteSharks (v)
				end
			end
		end
	end
end

function deleteSharks (sharkv)
	if isElement(sharkv) then
		if isElement(getElementData ( sharkv, "sharknullObject" )) then
			moveObject(getElementData ( sharkv, "sharknullObject" ),5000,x,y,z-10,0,0,179.9)
			setTimer (function (sharkv)
				if isElement(getElementData ( sharkv, "sharkshark1" )) then
					destroyElement(getElementData ( sharkv, "sharkshark1" ))
				end
				if isElement(getElementData ( sharkv, "sharknullObject" )) then
					destroyElement(getElementData ( sharkv, "sharknullObject" ))
				end
				if isElement(getElementData ( sharkv, "sharkshark2" )) then
					destroyElement(getElementData ( sharkv, "sharkshark2" ))
				end
				setElementData ( sharkv, "sharknullObject",nil )
				setElementData ( sharkv, "sharkshark1",nil )
				setElementData ( sharkv, "sharkshark2",nil )
				setElementData ( sharkv, "sharksPass",0 )
			end,5000, 1,sharkv)
		end
	end
end

function onLoad ( )
	players = nil
	players = getElementsByType( "player" )
	for k,v in ipairs (players) do
		if isElement(getElementData ( v, "sharknullObject" )) then
			destroyElement(getElementData ( v, "sharknullObject" ))
		end
		if isElement(getElementData ( v, "sharkshark1" )) then
			destroyElement(getElementData ( v, "sharkshark1" ))
		end
		if isElement(getElementData ( v, "sharkshark2" )) then
			destroyElement(getElementData ( v, "sharkshark2" ))
		end
		setElementData ( v, "sharknullObject",nil )
		setElementData ( v, "sharkshark1",nil )
		setElementData ( v, "sharkshark2",nil )
		setElementData ( v, "sharksPass",0 )
	end
	setTimer(check,1000,0)
end
addEventHandler( "onMapLoad", getRootElement(), onLoad)
onLoad ( )

function onJoin ( )
	players = nil
	players = getElementsByType( "player" )	
end
addEventHandler( "onPlayerJoin", getRootElement(), onJoin)

function onQuit ( )
	if isElement(getElementData ( source, "sharknullObject" )) then
		destroyElement(getElementData ( source, "sharknullObject" ))
	end
	if isElement(getElementData ( source, "sharkshark1" )) then
		destroyElement(getElementData ( source, "sharkshark1" ))
	end
	if isElement(getElementData ( source, "sharkshark2" )) then
		destroyElement(getElementData ( source, "sharkshark2" ))
	end
	setElementData ( source, "sharknullObject",nil )
	setElementData ( source, "sharkshark1",nil )
	setElementData ( source, "sharkshark2",nil )
	setElementData ( source, "sharksPass",0 )
	players = nil
	players = getElementsByType( "player" )
end
addEventHandler( "onPlayerQuit", getRootElement(), onQuit)

