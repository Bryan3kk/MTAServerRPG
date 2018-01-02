hamburgerPositions = { {372.82,-65.68,1001.51,10}, {380.44,-8.65,1001.85,9}, {379.42,-119.65,1001.49,5} } -- Locais de Hamburguers no estilo: x,y,z,interior
--[[

Este é o script de fome;é simples de usar, basta colocar o local em hamburgerPositions.
Plugin funciona bem, técnico responsável: L1K3

{x,y,z,interiorID}
Quando isso não for a ultima posição, vai precisar de "," após cada um:

]]--

-- Não mecha em nada no código sem conhecimento:
addEventHandler ("onClientResourceStart",getResourceRootElement(getThisResource()),
function ()
  hungerProcess = guiCreateProgressBar(0.7763,0.28,0.1775,0.04,true)
  guiMoveToBack (hungerProcess)
  guiProgressBarSetProgress(hungerProcess,100)
  hungerLabel = guiCreateLabel(0.7775,0.2817,0.1737,0.0367,"Fome:",true)
  guiLabelSetColor(hungerLabel,255,255,255)
  guiLabelSetVerticalAlign(hungerLabel,"center")
  guiLabelSetHorizontalAlign(hungerLabel,"center",false)
  guiSetFont(hungerLabel,"default-small")
  for i,v in ipairs (hamburgerPositions) do
    local hamburger = createPickup (v[1],v[2],v[3],3,2768,100)
    local hamburgerMarker = createMarker (v[1],v[2],v[3],"corona",1,255,255,0,80)
    setElementData (hamburgerMarker,"HAMBURGER",true)
    setElementInterior (hamburgerMarker,v[4])
    setElementInterior (hamburger,v[4])
  end
  setTimer (dropDownHungerState,45000,0,getLocalPlayer())
end)

function setHungerState (player,hungerState)
  if (player == getLocalPlayer()) then
    guiProgressBarSetProgress(hungerProcess,hungerState)
  end
end 

function getHungerState (player)
  if (player == getLocalPlayer()) then
    return guiProgressBarGetProgress(hungerProcess)
  end
end

function dropDownHungerState (player)
  if (player == getLocalPlayer()) then
    guiProgressBarSetProgress(hungerProcess,guiProgressBarGetProgress(hungerProcess) -1)
    if (guiProgressBarGetProgress(hungerProcess) == 0) then
      setElementHealth (player,getElementHealth (player) -25)
      outputChatBox ("RÁPIDO! Você vai morrer se não comer nada!",255,0,0,false)
    elseif (guiProgressBarGetProgress(hungerProcess) == 10) then
      outputChatBox ("ATENÇÃO! Você está ficando com fome:",255,0,0,false)
    end
  end
end 

addEventHandler ("onClientPlayerSpawn",getRootElement(),
function (team)
  setHungerState (source,100)
end)

addEventHandler ("onClientMarkerHit",getRootElement(),
function(hitEle,dim)
  if (getLocalPlayer() == hitEle) and (getElementData (source,"HAMBURGER!") == true) then
    if (getHungerState (hitEle) < 50) then
      setHungerState (hitEle,100)
      outputChatBox ("Você não está mais com fome!",255,0,255,false)
    else
      outputChatBox ("Você não precisa comer!",255,0,255,false)
    end
  end
end)