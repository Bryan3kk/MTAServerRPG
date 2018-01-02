function vida()
setElementHealth(source, 100)
outputChatBox("#FFFFFFVocê comprou vida:", source, 255, 255, 255, true)
end
addEvent("vida", true)
addEventHandler("vida", root, vida)

function colete()
setPedArmor(source, 100)
outputChatBox("#FFFFFFVocê comprou colete:", source, 255, 255, 255, true)
end
addEvent("colete", true)
addEventHandler("colete", root, colete)