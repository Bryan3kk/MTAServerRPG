    function vehicleGodMod(player)
        if not (hasObjectPermissionTo(player,"general.adminpanel",false)) then
        outputChatBox("Comando exclusivo, você não tem permissão!",player,255) 
            return end
        if (isVehicleDamageProof(getPedOccupiedVehicle(player))) then
        setVehicleDamageProof(getPedOccupiedVehicle(player),false)
        outputChatBox("Veiculo Blindado, Desativado!",player,255)
    else
        setVehicleDamageProof(getPedOccupiedVehicle(player),true)
        outputChatBox("Veiculo Blindado, Ativado!",player,0,255)
        end
    end
    addCommandHandler("blindar",vehicleGodMod)
