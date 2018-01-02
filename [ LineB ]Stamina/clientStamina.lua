local stamina = 500
local stamina_MAX = 500

function staminaCycle ( )
    if getPedMoveState ( localPlayer ) == "stand" then
        stamina = stamina+5
    elseif getPedMoveState ( localPlayer ) == "walk" then
        stamina = stamina+5
    elseif getPedMoveState ( localPlayer ) == "powerwalk" then
        stamina = stamina+4
    elseif getPedMoveState ( localPlayer ) == "jog" then
        stamina = stamina+3
    elseif getPedMoveState ( localPlayer ) == "sprint" then
        stamina = stamina-5
    elseif getPedMoveState ( localPlayer ) == "jump" then
        stamina = stamina-4
    elseif getPedMoveState ( localPlayer ) == "crouch" then
        stamina = stamina+5
    else
        stamina = stamina+1
    end

    if stamina > stamina_MAX then
        stamina = stamina_MAX
    end
    if stamina > 20 then
        toggleControl("jump", true)
    end
    if stamina > 100 then
        toggleControl("sprint", true)
    end
    if stamina < 0 then
        toggleControl("jump", false)
        toggleControl("sprint", false)
        stamina = 0
    end
    setTimer( staminaCycle, 200, 1)
end
function renderStamina ( )
    dxDrawText ( stamina, 19, 299, 0, 0, tocolor ( 0, 0, 0, 255 ), 1, "arial" )
    dxDrawText ( stamina, 19, 301, 0, 0, tocolor ( 0, 0, 0, 255 ), 1, "arial" )
    dxDrawText ( stamina, 21, 299, 0, 0, tocolor ( 0, 0, 0, 255 ), 1, "arial" )
    dxDrawText ( stamina, 21, 301, 0, 0, tocolor ( 0, 0, 0, 255 ), 1, "arial" )
    dxDrawText ( stamina, 20, 300, 0, 0, tocolor ( 255, 255, 255, 255 ), 1, "arial" )

    dxDrawText ( getPedMoveState ( localPlayer ), 19, 319, 0, 0, tocolor ( 0, 0, 0, 255 ), 1, "arial" )
    dxDrawText ( getPedMoveState ( localPlayer ), 19, 321, 0, 0, tocolor ( 0, 0, 0, 255 ), 1, "arial" )
    dxDrawText ( getPedMoveState ( localPlayer ), 21, 319, 0, 0, tocolor ( 0, 0, 0, 255 ), 1, "arial" )
    dxDrawText ( getPedMoveState ( localPlayer ), 21, 321, 0, 0, tocolor ( 0, 0, 0, 255 ), 1, "arial" )
    dxDrawText ( getPedMoveState ( localPlayer ), 20, 320, 0, 0, tocolor ( 255, 255, 255, 255 ), 1, "arial" )
end

function startStamina ( )
    setTimer( staminaCycle, 200, 1)
    --addEventHandler ( "onClientRender", root, renderStamina )     --draws the amount of "stamina" and the current move state on the screen as a number (mainly for testing)
end

addEventHandler ( "onClientResourceStart", resourceRoot, startStamina )
