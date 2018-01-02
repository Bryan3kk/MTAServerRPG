TranGui = guiCreateWindow(0.32, 0.20, 0.38, 0.65, "Trabalho de Maquinista de Trem", true)
guiSetAlpha(TranGui, 1)
guiSetVisible(TranGui, false)
guiWindowSetSizable(TranGui, false)
guiWindowSetMovable(TranGui, false)
InformacionP = guiCreateLabel(0.03, 0.06, 0.93, 0.51, "Bem-Vindo " .. getPlayerName(localPlayer) .. [[
Aqui você pode se tornar um Condutor de Trem, o trabalho consiste em trafegar pelos trilhos e seguir os marcadores no percurso das estações.]], true, TranGui)
guiLabelSetHorizontalAlign(InformacionP, "center", true)
TrabajarTE = guiCreateButton(0.09, 0.81, 0.35, 0.10, "Aceitar", true, TranGui)
guiSetFont(TrabajarTA, "default-bold-small")
SalirTE = guiCreateButton(0.53, 0.81, 0.36, 0.10, "Cancelar", true, TranGui)
SkinsTE = guiCreateGridList(0.02, 0.37, 0.94, 0.28, true, TranGui)
guiGridListAddColumn(SkinsTE, "Skin", 1)
guiGridListSetItemText(SkinsTE, guiGridListAddRow(SkinsTE), 1, "Não precisa de uma Skin", false, true)
BonificacionTE = guiCreateLabel(0.05, 0.67, 0.91, 0.13, [[
Pressione Aceitar para trabalhar ou Cancelar para sair.]], true, TranGui)
guiLabelSetHorizontalAlign(BonificacionTE, "left", true)
guiSetFont(BonificacionTE, "default-bold-small")
function onBuscaTranviaJob()
  guiSetVisible(TranGui, true)
  showCursor(true)
end
addEvent("onBuscaTranviaJob", true)
addEventHandler("onBuscaTranviaJob", getRootElement(), onBuscaTranviaJob)
function ObtenerAlgoTren()
  if source == TrabajarTE then
    triggerServerEvent("serTranvia", localPlayer)
    guiSetVisible(TranGui, false)
    showCursor(false)
  elseif source == SalirTE then
    guiSetVisible(TranGui, false)
    showCursor(false)
  end
end
addEventHandler("onClientGUIClick", resourceRoot, ObtenerAlgoTren)
Paradores = {
  {
    1,
    -2251.841796875,
    128.306640625,
    35.171875
  },
  {
    2,
    -2006.5087890625,
    90.0078125,
    27.5390625
  },
  {
    3,
    -1606.8125,
    728.806640625,
    12.046772003174
  },
  {
    4,
    -1715.640625,
    1328.9287109375,
    7.0390625
  },
  {
    5,
    -2265.01953125,
    1094.337890625,
    79.859375
  },
  {
    6,
    -2264.8330078125,
    875.1884765625,
    66.492492675781
  },
  {
    7,
    -2264.9375,
    541.541015625,
    35.015625
  }
}
Markers = {}
Blips = {}
function IniciarTranvia()
  triggerEvent("callOutputGuiText", localPlayer, "Bem-Vindo ao trabalho de Condutor de Trem!", 255, 255, 0)
  triggerEvent("callOutputGuiText", localPlayer, "Passe por todos os marcadores e assim irá receber seu pagamento!", 255, 255, 0)
  setElementData(localPlayer, "SXTrenNumero", 0)
  triggerEvent("sdx", localPlayer)
  for index, markers in pairs(Paradores) do
    id, x, y, z = unpack(markers)
    local maxMark = #Markers
    local maxBlip = #Blips
    Markers[maxMark + 1] = createMarker(x, y, z - 1, "cylinder", 9, 255, 255, 0, 200)
    Blips[maxBlip + 1] = createBlipAttachedTo(Markers[maxMark + 1], 0, 3, 0, 0, 255)
    setElementData(Markers[maxMark + 1], "TrenMarker", Blips[maxBlip + 1])
  end
end
addEvent("IniciarTranvia", true)
addEventHandler("IniciarTranvia", root, IniciarTranvia)
function TerminarTrenero(player, seat)
  if player == localPlayer and seat == 0 and getElementData(localPlayer, "TranviaMision") == true then
    setElementData(localPlayer, "TranviaMision", false)
    triggerEvent("Fracasar", localPlayer)
    for index, blp in pairs(Markers) do
      if isElement(blp) then
        destroyElement(blp)
      end
    end
    for index, blp in pairs(Blips) do
      if isElement(blp) then
        destroyElement(blp)
      end
    end
    if isTimer(checkTimer) then
      killTimer(checkTimer)
    end
  end
end
addEvent("TerminarTrenero", true)
addEventHandler("TerminarTrenero", root, TerminarTrenero)
addEventHandler("onClientVehicleExit", root, TerminarTrenero)
addEventHandler("onClientPlayerWasted", root, function()
  TerminarTrenero(source, 0)
end)
function MarkersDeTren(player)
  if isElementLocal(source) and player == localPlayer and isPedInVehicle(localPlayer) then
    if isTimer(checkTimer) then
      killTimer(checkTimer)
    end
    setElementData(localPlayer, "MarcadorTrenIn", source)
    checkTimer = setTimer(PisoElMarkerBien, 100, 0)
    triggerEvent("callOutputGuiText", localPlayer, "Complete a rota para receber seu pagamento!", 255, 255, 0)
  end
end
addEventHandler("onClientMarkerHit", resourceRoot, MarkersDeTren)
function PisoElMarkerBien()
  local vehicle = getPedOccupiedVehicle(localPlayer)
  if not vehicle then
    return
  end
  if getVehicleController(vehicle) ~= localPlayer then
    return
  end
  local g, h, i = getElementVelocity(vehicle)
  if g ~= 0 or h ~= 0 or i ~= 0 then
    return
  end
  if getElementData(localPlayer, "Ocupacion") == "Condutor de Trem" then
    if isTimer(checkTimer) then
      killTimer(checkTimer)
    end
    local mk = getElementData(localPlayer, "MarcadorTrenIn")
    destroyElement(getElementData(mk, "TrenMarker"))
    destroyElement(mk)
    setElementData(localPlayer, "SXTrenNumero", getElementData(localPlayer, "SXTrenNumero") + 1)
    triggerServerEvent("serverGivePlayerMoney", localPlayer, 1000)
    triggerEvent("callOutputGuiText", localPlayer, "Ganhou $1000 por esta Rota!", 255, 255, 0)
    triggerEvent("callOutputGuiText", localPlayer, "Número de rotas concluidas: " .. getElementData(localPlayer, "SXTrenNumero") .. "/7", 0, 255, 0)
    if getElementData(localPlayer, "SXTrenNumero") == 7 then
      for index, blp in pairs(Markers) do
        if isElement(blp) then
          destroyElement(blp)
        end
      end
      for index, blp in pairs(Blips) do
        if isElement(blp) then
          destroyElement(blp)
        end
      end
      setElementData(localPlayer, "display_respeto", "1")
      triggerEvent("dxr", localPlayer)
      triggerServerEvent("serverSetPedStat", localPlayer, 64, getPedStat(localPlayer, 64) + 1)
      triggerEvent("callOutputGuiText", localPlayer, "Parabéns, você concluiu a rota com sucesso!", 0, 255, 0)
      setElementData(localPlayer, "PuedeHacerMision", false)
      setTimer(setElementData, 10000, 1, localPlayer, "PuedeHacerMision", true)
      IniciarTren()
    end
  end
end

----------------------->>>>>>>>>>>>> Bugs fix <<<<<<<<<<<<<<<<<<<<------------


function cancelarInComando ()	
      destroyElement(blip)
      destroyElement(nextb)
	  destroyElement(marker)
end
addCommandHandler ("criminal", cancelarInComando)
addCommandHandler ("equipoadm", cancelarInComando)
addCommandHandler ("sintrabajo", cancelarInComando)
addCommandHandler ("equipoadmin", cancelarInComando)
addCommandHandler ("swat", cancelarInComando)
addCommandHandler ("cia", cancelarInComando)
addCommandHandler ("elite", cancelarInComando)
