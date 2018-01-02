function setEngineState(player)
veh = getPedOccupiedVehicle(player)
state = getVehicleEngineState(veh)
if veh then
setVehicleEngineState(veh,not state)
end
end
addCommandHandler("motor",setEngineState)

function command(player,cmd,amount)
local vehicle = getPedOccupiedVehicle(player)
local fuel = getElementData(vehicle,"fuel")
local account = getPlayerAccount(player)
local name = getAccountName(account)
if isObjectInACLGroup("user."..name,aclGetGroup("Admin")) then
if vehicle and tonumber(amount) and (tonumber(fuel) + tonumber(amount)) <= 100 then
setElementData(vehicle,"fuel",tonumber(amount) + tonumber(fuel))
outputChatBox("Seu veículo foi abastecido com sucesso("..(amount).."%)",player)
else
outputChatBox("Por favor, Digite uma quantia que mantenha o carro com menos de 100%",player)
end
else
outputChatBox("Acesso Negado",255,255,0)
end
end
addCommandHandler("abastecer",command)
 