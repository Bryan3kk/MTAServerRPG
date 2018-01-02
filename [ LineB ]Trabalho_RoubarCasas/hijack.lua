local ca3 = { { 0, 0, 3 }, { 0, 0, 3 }, { 0, 0, 3 }, { 0, 0, 3 } }
 
local marker = {   --You can add more locations here
    { 511.94174194336, -1655.2518310547, 18.948333740234 },
    { 1841.0515136719, -1797.8941650391, 13.546875 }
}
 
local vehicle_ = {}
local blip = {}
local rand = {}
local Markers = {}
 
function CreatCarRandom ()
    rand.random = ca3[math.random(#ca3)]
    vehicle_.car = createVehicle(560, 2228.9113769531, -1152.0667724609, 25.854433059692)
    blip.blip1Car = createBlipAttachedTo(vehicle_.car, 53)
    outputChatBox("#ffffffO Objetivo marcado no mapa! Vá rápido e pegue o dinheiro!", root, 255, 255, 255, true)
end
addEventHandler("onResourceStart", root, CreatCarRandom)
 
addEventHandler("onPlayerVehicleEnter", root,
    function(vehicle)
        if(isElement(vehicle_.car))then
            if (vehicle == vehicle_.car) then  
                local x,y,z = unpack(marker[math.random(#marker)])
                Markers.Marker = createMarker(x, y, z, "cylinder", 5, 0, 0, 205, 170)
                blip.blipCar2 = createBlipAttachedTo(Markers.Marker, 51)
                setElementVisibleTo(Markers.Marker, root, false)
                setElementVisibleTo(Markers.Marker, source, true)
            end
        end
    end
)
   
addEventHandler( "onMarkerHit", root,
    function(hitElement)
        if ( getElementType( hitElement ) == "player" ) then
            if( isPedInVehicle( hitElement ) )then
                givePlayerMoney ( hitElement, math.random(1293,3000) )
                triggerClientEvent(hitElement, "playSoundC", hitElement)
                for i,v in pairs(vehicle_) do
                    destroyElement(v)
                end
                for i,v in pairs(Markers) do
                    destroyElement(v)
                end
                for i,v in pairs(blip) do
                    destroyElement(v)
                end
                CreatCarRandom ()
               
            end
        end
    end
)
 
addEventHandler("onPlayerVehicleExit", root,
    function(vehicle)
        if( isElement( vehicle_.car ) )then
            if( vehicle == vehicle_.car )then
                for i,v in pairs(vehicle_) do
                    destroyElement(v)
                end
                for i,v in pairs(Markers) do
                    destroyElement(v)
                end
                for i,v in pairs(blip) do
                    destroyElement(v)
                end
            end
        end
    end
)
 