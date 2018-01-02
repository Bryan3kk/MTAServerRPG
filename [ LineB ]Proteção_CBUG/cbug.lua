function cbug ()
    setGlitchEnabled ( "quickreload", false )
    setGlitchEnabled ( "fastmove", false )
    setGlitchEnabled ( "fastfire", false )
    setGlitchEnabled ( "crouchbug", false )
	end
addEventHandler ( "onResourceStart", getResourceRootElement ( ), cbug )