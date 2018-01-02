
function animationCommand ( source )
setPedAnimation ( source, "shop", "shp_rob_handsup", -1, true, false, false )
outputChatBox ( "* De /liberado para baixar as mãos!", source, 255, 0, 0 )
end
addCommandHandler ( "render", animationCommand )

function animationCommand2 ( source )
setPedAnimation ( source )
end
addCommandHandler ( "liberado", animationCommand2 )


