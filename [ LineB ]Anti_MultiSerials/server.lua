addEventHandler("onPlayerConnect",getRootElement(),
function(pName,pIP,pUSername,pSerial)
for i,v in ipairs(getElementsByType("player")) do
	if getPlayerSerial(v) == pSerial then
		cancelEvent(true,"O Serial informado está em uso!")
	end
end
end)