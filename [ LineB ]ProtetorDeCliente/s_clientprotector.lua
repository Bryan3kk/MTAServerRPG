function pro()
    triggerClientEvent (source,"onClientPlayerLogin",source)
end
addEventHandler("onPlayerLogin", root, pro)