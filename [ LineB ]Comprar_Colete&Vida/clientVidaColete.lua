painel = false

    function dxpainel()
        dxDrawLine(292 - 1, 252 - 1, 292 - 1, 435, tocolor(255, 255, 255, 255), 1, false)
        dxDrawLine(686, 252 - 1, 292 - 1, 252 - 1, tocolor(255, 255, 255, 255), 1, false)
        dxDrawLine(292 - 1, 435, 686, 435, tocolor(255, 255, 255, 255), 1, false)
        dxDrawLine(686, 435, 686, 252 - 1, tocolor(255, 255, 255, 255), 1, false)
        dxDrawRectangle(292, 252, 394, 183, tocolor(0, 0, 0, 110), false)
        dxDrawLine(292 - 1, 252 - 1, 292 - 1, 285, tocolor(255, 255, 255, 255), 1, false)
        dxDrawLine(686, 252 - 1, 292 - 1, 252 - 1, tocolor(255, 255, 255, 255), 1, false)
        dxDrawLine(292 - 1, 285, 686, 285, tocolor(255, 255, 255, 255), 1, false)
        dxDrawLine(686, 285, 686, 252 - 1, tocolor(255, 255, 255, 255), 1, false)
        dxDrawRectangle(292, 252, 394, 33, tocolor(29, 254, 252, 255), false)
        dxDrawText("Painel Vida e Colete", 375, 259, 561, 285, tocolor(0, 0, 0, 255), 0.70, "bankgothic", "left", "top", false, false, false, false, false)
        dxDrawRectangle(342, 335, 120, 34, tocolor(254, 0, 0, 255), false)
        dxDrawLine(509 - 1, 335 - 1, 509 - 1, 369, tocolor(0, 0, 0, 255), 1, false)
        dxDrawLine(629, 335 - 1, 509 - 1, 335 - 1, tocolor(0, 0, 0, 255), 1, false)
        dxDrawLine(509 - 1, 369, 629, 369, tocolor(0, 0, 0, 255), 1, false)
        dxDrawLine(629, 369, 629, 335 - 1, tocolor(0, 0, 0, 255), 1, false)
        dxDrawRectangle(509, 335, 120, 34, tocolor(255, 255, 255, 255), false)
        dxDrawText("VIDA", 375, 341, 448, 364, tocolor(0, 0, 0, 255), 0.60, "bankgothic", "left", "top", false, false, false, false, false)
        dxDrawText("COLETE", 528, 340, 601, 363, tocolor(0, 0, 0, 255), 0.60, "bankgothic", "left", "top", false, false, false, false, false)
        dxDrawText("- LineB -", 302, 418, 393, 435, tocolor(29, 254, 252, 255), 1.00, "default-bold", "left", "top", false, false, false, false, false)
    end

	function vida(_,state)
if painel then
if state == "down" then
if isCursorOnElement (342, 335, 120, 34) then
triggerServerEvent ("vida", getLocalPlayer())
end
end
end
end
addEventHandler ("onClientClick", root, vida)

function colete(_,state)
if painel then
if state == "down" then
if isCursorOnElement (509, 335, 120, 34) then
triggerServerEvent ("colete", getLocalPlayer())
end
end
end
end
addEventHandler ("onClientClick", root, colete)

function abrir (_,state)
if painel == false then
showCursor(true)
addEventHandler("onClientRender", root, dxpainel)
painel = true
else
showCursor(false)
removeEventHandler("onClientRender", root, dxpainel)
painel = false
end
end
bindKey("F3", "down", abrir)

local x,y = guiGetScreenSize()
 
function isCursorOnElement(x,y,w,h)
 local mx,my = getCursorPosition ()
 local fullx,fully = guiGetScreenSize()
 cursorx,cursory = mx*fullx,my*fully
 if cursorx > x and cursorx < x + w and cursory > y and cursory < y + h then
  return true
 else
  return false
 end
end
