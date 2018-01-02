names = {
["player"] = "Guest6585",
["guest"] = "Guest7854",
["jogador"] = "Guest4582",
["Puta"] = "Guest9758",
["Viado"] = "Guest0978",
["Cuzao"] = "Guest8097",
["Fodase"] = "Guest8790",
["Foda-se"] = "Guest7098",
["anonymous"] = "Guest9780",
["Anonymous"] = "Guest0789",
["Hacker"] = "Guest7098",
["hacker"] = "Gues8709",
["viado"] = "Guest9087",
["puta"] = "Guest0987"
}

addEventHandler("onPlayerJoin", getRootElement(),
function()
	name = getPlayerName(source)
	if names[name:lower()] == name:lower() and #name == #names[name:lower()] then
		setTimer(setPlayerName,1000,1, source, names[name:lower()]..tostring(math.random(1000,9000)))
		outputChatBox("[LineB Security] Você está usando um nick banido, e será renomeado:", source, 255, 255, 255, true)
	end
end
 )

addEventHandler("onPlayerChangeNick", getRootElement(),
function(old, new)	
	name = new
	if #name == #names[name:lower()] then
		if names[name:lower()] == name:lower() then
			setTimer(setPlayerName,1000,1, source, names[name:lower()]..tostring(math.random(1000,9000)))
			outputChatBox("[LineB Security] Você está usando um nick banido, e será renomeado:", source, 255, 255, 255, true)
		end
	end
end )