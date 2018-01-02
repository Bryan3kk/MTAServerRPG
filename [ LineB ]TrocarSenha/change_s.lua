function obteneraccount(playerSource)
	sourceAccount = getPlayerAccount ( playerSource )
	if isGuestAccount ( sourceAccount ) then
		outputChatBox("#A1090D[SERVIDOR]#ffffffVocê precisa estar logado para trocar a senha:", playerSource, 255, 255, 255, true)
	else
		PCuenta = getAccountName(getPlayerAccount(source))
		triggerClientEvent("OnDatas",source,PCuenta)
	end
end
addEvent("obAccount", true)
addEventHandler("obAccount",getRootElement(),obteneraccount)

function errorp()
	outputChatBox("#A1090D[SERVIDOR]#ffffffAs senhas não coincidem:", source, 255, 255, 255, true)
end
addEvent("ErrorPass", true)
addEventHandler("ErrorPass",getRootElement(),errorp)

function cambiar(newpass1)
	local account = getPlayerAccount(source)
	local nCuenta = getAccountName(account)
	if (account) then
		if (isGuestAccount(account)) then
			outputChatBox("#A1090D[SERVIDOR]#FFFFFF Conecte-se para alterar a senha.", source, 255, 255, 255, true)
		else
			setAccountPassword(account, newpass1)
			outputChatBox("#A1090D[SERVIDOR]#ffffffA senha foi alterada com SUCESSO:", source, 255, 255, 255, true)
			outputChatBox("#A1090D[CONTA]#ffffff[Usuário:#9a1409 "..nCuenta.." #ffffff] - [Nova senha:#9a1409 "..newpass1.." #ffffff].", source, 255, 255, 255, true)
		end
	end
end
addEvent("Cambiar", true)
addEventHandler("Cambiar",getRootElement(),cambiar)