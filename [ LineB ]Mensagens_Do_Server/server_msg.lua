function msg()
local msg = { "#FFFFFF Precisa de ajuda? Chame um Staff!","Reporte problemas com o comando /bug","Acesse o Raidcall: ","Você sabia que a LineB possui servidores em outros jogos? Não! Acesse e saiba mais: ","Precisa de suporte com suas compras? Contate o suporte via Skype: ","Moderadores sempre Online no Raidcall!"}

local ms = math.random(1, #msg)
mensagem = msg[ms]

outputChatBox("#ffffff[#fff600 AJUDA #ffffff]#fff600: "..mensagem..".", getRootElement(), 255, 255, 255, true )
end

setTimer(msg,100000,0)