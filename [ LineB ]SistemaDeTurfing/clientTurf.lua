addEventHandler("onClientResourceStart", resourceRoot,
	function()
		setDevelopmentMode(true)
	end
)

function music()
	local sound = playSound("missionDone.mp3")
end
addEvent("onTakeTurf", true)
addEventHandler("onTakeTurf", resourceRoot, music)
