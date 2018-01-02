Slist = {
["Serial do Like"] = true, -- L1K3
["Serial do Andrey"] = true, -- Andrey
["Serial do Pro"] = true, -- Proo
["Serial do Arvena"] = true, -- Arvena
}*
--[[
["Serial"] = true, -- Exemplo
]]--

function serialc (source)
    SV = getPlayerSerial(source)
      if (Slist[SV]) then
	  outputChatBox("Bem-Vindo ao Servidor!",source)
	  return true
	else
	kickPlayer (source,"Desculpe! Você não está autorizado a entrar.")
	return false
end
end
addEventHandler("onPlayerJoin", root, serialc)	

