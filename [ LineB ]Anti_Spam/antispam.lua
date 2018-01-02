antiSpam = {} 
function antiChatSpam() 
	if isTimer(antiSpam[source]) then
		cancelEvent()
		outputChatBox("#FFFFFF[ LineB Anti-Spam #FFFFFF] #FFF600 "..getPlayerName(source).."#FF6000 Teve o chat bloqueado por Spam!", getRootElement(), 255, 255, 0, true ) 
		setPlayerMuted(source, true)
		setTimer ( autoUnmute, 300000, 1, source)
	else
		antiSpam[source] = setTimer(function(source) antiSpam[source] = nil end, 300000, 1, source) 
	end
end
addEventHandler("onPlayerChat", root, antiChatSpam)


function autoUnmute ( player )
	if ( isElement ( player ) and isPlayerMuted ( player ) ) then
		setPlayerMuted ( player, false )
		outputChatBox ("#ffffff[#fff600Proteção Contra Spam#ffffff]#FFFFFF"..getPlayerName ( player ).." #fff600Teve o 'Chat Liberado':",getRootElement(), 255, 255, 0,true )
	end
end