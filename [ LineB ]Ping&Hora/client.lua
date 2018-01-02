local FPSLimit, lastTick, framesRendered, FPS = 100, getTickCount(), 0, 0
local screenWidth, screenHeight = guiGetScreenSize(); local width, height = screenWidth - 5, screenHeight - 5; screenWidth = nil; screenHeight = nil

local screenW,screenH = guiGetScreenSize()
local resW, resH = 1366, 720
local x, y =  (screenW/resW), (screenH/resH)

Font_1 = dxCreateFont("AldotheApache.ttf", 16)
addEventHandler("onClientRender",root,
    function()
	    local hours = getRealTime().hour
        local minutes = getRealTime().minute
        local seconds = getRealTime().second
  
dxDrawText(hours..":"..minutes..":"..seconds, x*-510, y*1010, x*1064, y*335,tocolor(0,255,221,255),1,Font_1,"center", "center", false, false, true, false, false)
    end
)

function createText ( )
    local playerPing = getPlayerPing ( localPlayer )    
   
    dxDrawText ( playerPing, x*-750, y*1020, x*1074, y*345, tocolor ( 0,255,221,255 ), 1, Font_1, "center", "center", false, false, true, false, false)
    dxDrawText("Ping:", x*-820, y*1020, x*1074, y*345, tocolor(255, 255, 255, 255), 1, Font_1, "center", "center", false, false, true, false, false) 
end
 
function HandleTheRendering ( )
    addEventHandler ( "onClientRender", root, createText )
end
 
addEventHandler ( "onClientResourceStart", resourceRoot, HandleTheRendering )

function onClientDrawFPS()
    local currentTick = getTickCount()
    local elapsedTime = currentTick - lastTick
    
    if elapsedTime >= 1000 then
        FPS = framesRendered
        lastTick = currentTick
        framesRendered = 0
    else
        framesRendered = framesRendered + 1
    end
    
    if FPS > FPSLimit then
        FPS = FPSLimit
    end
    
    if FPS == 20 then
        FPSColor = tocolor(255, 0, 0, 255)
    elseif FPS < 20 then
        FPSColor = tocolor(255, 0, 0, 255)
    elseif FPS >20 then
        FPSColor = tocolor(0, 255, 0, 255)
    end
    dxDrawText(tostring(FPS), x*-920, y*1020, x*1074, y*345, tocolor(0,255,221,255), 1.00, Font_1, "center", "center", false, false, false, false, false)
          dxDrawText("FPS:", x*-990, y*1020, x*1074, y*345, tocolor(255, 255, 255, 255), 1.00, Font_1, "center", "center", false, false, true, false, false)
          dxDrawText("Horas:", x*-660, y*1020, x*1074, y*345, tocolor(255, 255, 255, 255), 1.00, Font_1, "center", "center", false, false, true, false, false)
end
addEventHandler ("onClientRender",root,onClientDrawFPS)