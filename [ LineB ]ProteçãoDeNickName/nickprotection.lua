local nickTimer
local joinTimer
-------------------------------------------------------------------------------------------------------------------------
function lockNick(player, command, name)
	local nick
	local account = getPlayerAccount(player)
	if isGuestAccount(account) then
		outputChatBox("Você precisa se registrar / Estar logado para proteger um Nick!", player, 255, 153, 0, true)
		return
	end
	if not name then
		nick = getPlayerName(player):gsub('#%x%x%x%x%x%x', '')
		setAccountData(account, "protectedNick", nick)
	else
		nick = name:gsub('#%x%x%x%x%x%x', '')
		setAccountData(account, "protectedNick", nick)
	end
	outputChatBox("#fff600 Você protegeu com sucesso o #FFFFFF"..nick.." #fff600 para sua conta.", player, 0, 255, 0, true)
end
addCommandHandler("proteger", lockNick)
-------------------------------------------------------------------------------------------------------------------------
function unlockNick(player, command, name)
	local nick
	local account = getPlayerAccount(player)
	if isGuestAccount(account) then
		outputChatBox("#fff600Você precisa estar logado para desproteger um nick!", player, 255, 153, 0, true)
		return
	end
	if not getAccountData(account, "protectedNick") then
		outputChatBox("#fff600Você desprotegeu esse Nick!", player, 255, 255, 255, true)
		return
	end
	if not name then
		nick = getPlayerName(player):gsub('#%x%x%x%x%x%x', '')
		if getAccountData(account, "protectedNick") and nick == getAccountData(account, "protectedNick"):gsub('#%x%x%x%x%x%x', '') then
			setAccountData(account, "protectedNick", false)
			outputChatBox("#fff60 Você desprotegeu com sucesso o #FFFFFF"..nick.." #fff600 da sua conta.", player, 0, 255, 0, true)
		else
			outputChatBox("#fff600Nick não encontrado no banco de dados.", player, 255, 0, 0, true)
		end
	else
		nick = name:gsub('#%x%x%x%x%x%x', '')
		if nick == getAccountData(account, "protectedNick"):gsub('#%x%x%x%x%x%x', '') then
			setAccountData(account, "protectedNick", false)
			outputChatBox("#fff60 Você desprotegeu com sucesso o #FFFFFF"..nick.." #fff600 na sua conta.", player, 0, 255, 0, true)
		else
			outputChatBox("#fff600Nick não encontrado no banco de dados.", player, 255, 0, 0, true)
		end
	end
end
addCommandHandler("desproteger", unlockNick)
-------------------------------------------------------------------------------------------------------------------------
function checkProtectedNicks(player)
	local account = getPlayerAccount(player)
	if isGuestAccount(account) then
		return
	end
	if getAccountData(account, "protectedNick") then
		outputChatBox("#fff600 Seu nick protegido é #FFFFFF"..getAccountData(account, "protectedNick").."#32CD32.", player, 255, 255, 255, true)
	else
		outputChatBox("#fff600 Você não tem nenhum nick protegido ainda.", player, 255, 255, 255, true)
	end
end
addCommandHandler("protegido", checkProtectedNicks)
-------------------------------------------------------------------------------------------------------------------------
function onNickChange(oldNick, newNick)
	local account = getPlayerAccount(source)
	local allAccounts = getAccounts()
	for k, v in ipairs(allAccounts) do
		if v ~= account then
			if getAccountData(v, "protectedNick") and newNick:gsub('#%x%x%x%x%x%x', '') == getAccountData(v, "protectedNick"):gsub('#%x%x%x%x%x%x', '') then
				setTimer(function(player)
					changeNickToRandom(player)
					outputChatBox("#fff600Seu nick foi renomeado, você estava usando um nickname protegido.", player, 255, 255, 255, true)
				end, 1000, 1, source)
			elseif getAccountData(v, "protectedNick") and newNick:gsub('#%x%x%x%x%x%x', '') ~= getAccountData(v, "protectedNick"):gsub('#%x%x%x%x%x%x', '') then
				if isTimer(nickTimer) then
					killTimer(nickTimer)
				end
			end
		end
	end
	if getAccountData(account, "protectedNick") and newNick:gsub('#%x%x%x%x%x%x', '') == getAccountData(account, "protectedNick"):gsub('#%x%x%x%x%x%x', '') then
		if isTimer(nickTimer) then
			killTimer(nickTimer)
		end
		outputChatBox("#fff600Você pode usar esse nick protegido.", source, 255, 255, 255, true)
	end
end
addEventHandler("onPlayerChangeNick", root, onNickChange)
-------------------------------------------------------------------------------------------------------------------------
function onPlayerJoin()
	joinTimer = setTimer(function(player)
		local account = getPlayerAccount(player)
		local allAccounts = getAccounts()
		local currentNick = getPlayerName(player):gsub('#%x%x%x%x%x%x', '')
		if account and not isGuestAccount(account) then
			local nickData = getAccountData(account, "protectedNick"):gsub('#%x%x%x%x%x%x', '')
			if currentNick == nickData then
				outputChatBox("#fff600 Você pode usar esse nick protegido.", player, 255, 255, 255, true)
				return
			end
		else
			for k, v in ipairs(allAccounts) do
				if getAccountData(v, "protectedNick") and currentNick == getAccountData(v, "protectedNick"):gsub('#%x%x%x%x%x%x', '') then
					outputChatBox("#fff600Seu nick #FFFFFF"..getAccountData(v, "protectedNick"):gsub('#%x%x%x%x%x%x', '').." #fff600é protegido. Porfavor Logue ou mude seu nick:", player, 255, 255, 255, true)
					if isTimer(nickTimer) then
						killTimer(nickTimer)
					end
					nickTimer = setTimer(function(player)
						changeNickToRandom(player)
						outputChatBox("#fff600 Seu nick foi renomeado por usar um nick protegido.", player, 255, 255, 255, true)
					end, 60000, 1, player)
				end
			end
		end
	end, 10000, 1, source)
end
addEventHandler("onPlayerJoin", root, onPlayerJoin)
-------------------------------------------------------------------------------------------------------------------------
function onPlayerLogin()
	local account = getPlayerAccount(source)
	local currentNick = getPlayerName(source):gsub('#%x%x%x%x%x%x', '')
	local nickData = getAccountData(account, "protectedNick"):gsub('#%x%x%x%x%x%x', '')
	local lockedNick
	local allAccounts = getAccounts()
	for k, v in ipairs(allAccounts) do
		if v ~= account then
			lockedNick = getAccountData(v, "protectedNick")
		end
	end
	if nickData and currentNick == nickData then
		if isTimer(nickTimer) then
			killTimer(nickTimer)
		end
		if isTimer(joinTimer) then
			return
		end
		outputChatBox("#fff600 Você pode usar esse nick protegido.", source, 255, 255, 255, true)
		return
	elseif lockedNick and currentNick == lockedNick then
		changeNickToRandom(source)
		outputChatBox("#fff600 Seu nick foi renomeado por usar um nick protegido.", source, 255, 255, 255, true)
	end
end
addEventHandler("onPlayerLogin", root, onPlayerLogin)
-------------------------------------------------------------------------------------------------------------------------
function onPlayerLogout()
	local account = getPlayerAccount(source)
	local curName = getPlayerName(source):gsub('#%x%x%x%x%x%x', '')
	local allAccounts = getAccounts()
	if isGuestAccount(account) then
		for k, v in ipairs(allAccounts) do
			if getAccountData(v, "protectedNick") and curName == getAccountData(v, "protectedNick") then
				changeNickToRandom(source)
				outputChatBox("#fff600 Seu nick foi renomeado por usar um nick protegido.", source, 255, 255, 255, true)
			end
		end
	end
end
addEventHandler("onPlayerLogout", root, onPlayerLogout)
-------------------------------------------------------------------------------------------------------------------------
function changeNickToRandom(player)
	local randomNick = "Guest"..math.random(100000000,999999999)
	while getPlayerFromName(randomNick) do
		randomNick = "Guest"..math.random(100000000,999999999)
	end
	setPlayerName(player, randomNick)
end
-------------------------------------------------------------------------------------------------------------------------
function adminRemoveNick(player, command, name)
	local account = getPlayerAccount(player)
	local accountName = getAccountName(account)
	if isGuestAccount(account) then
		return
	end
	if isObjectInACLGroup("user."..accountName, aclGetGroup("Admin")) or isObjectInACLGroup("user."..accountName, aclGetGroup("SuperModerator")) then
		if not name then
			outputChatBox("#FF0000Comando correto é: #FEFE22/freenick [nick completo]", player, 0, 255, 0, true)
			return
		end
		local allAccounts = getAccounts()
		for k, v in ipairs(allAccounts) do
			if getAccountData(v, "protectedNick") then
				if string.lower(getAccountData(v, "protectedNick"):gsub('#%x%x%x%x%x%x', '')) == string.lower(name:gsub('#%x%x%x%x%x%x', '')) then
					outputChatBox("#fff600Você desbloqueou o nick: #FFFFFF"..getAccountData(v, "protectedNick").."#32CD32.", player, 255, 255, 255, true)
					setAccountData(v, "protectedNick", false)
				else
					outputChatBox("#fff600Nick não encontrado no banco de dados.", player, 255, 0, 0, true)
				end
				return
			end
		end
		outputChatBox("#fff600Nickname não encontrado no banco de dados.", player, 255, 0, 0, true)
	end
end
addCommandHandler("freenick", adminRemoveNick)