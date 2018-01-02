local screen = dxCreateScreenSource ( 340, 380 );
local renderEvent = false
local sx, sy = guiGetScreenSize()
 
local sX = sx/1280
local sY = sy/720

local alpha = 140
local imgAlpha = 255

function daPic()
    dxUpdateScreenSource(screen);
    
	if renderEvent == false then
    addEventHandler("onClientRender", root, showSpeedPic)
	setTimer(removeDaAnnoyingThingy, 5500, 1);
	renderEvent = true
	end
end

addEvent("showPicture", true)
addEventHandler("showPicture", getLocalPlayer(), daPic)

function showSpeedPic()
    rect =  dxDrawRectangle(20.0*sX,209.0*sY,295.0*sX,255.0*sY,tocolor(0,0,0,alpha),false)
    dxDrawImage( 28.0*sX,217.0*sY,279.0*sX,238.0*sY, screen, 0, 0, 0, tocolor(255, 255, 255, imgAlpha), false)
end

function removeDaAnnoyingThingy()
	addEventHandler("onClientRender", getRootElement(), alphaShizz)
end

function alphaShizz()
	alpha = alpha-3
	imgAlpha = imgAlpha-3
	if (alpha <=0) then
		removeEventHandler("onClientRender", root, showSpeedPic)
		removeEventHandler("onClientRender", root, alphaShizz)
		renderEvent = false
		imgAlpha = 255
		alpha = 140
	end
end