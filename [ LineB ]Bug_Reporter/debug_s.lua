addEvent("send",true)

function send(player,text,art)
					--resource_name = getResourceName()
					
					report_id = math.random(111111111,999999999) 
					filename = "report/"..tostring(art).." - "..tostring(getPlayerName(player)).." - "..tostring(report_id)..".xml"
					--filename = "report/text.xml"
					
					RootNode = xmlCreateFile(tostring(filename),"Report")
					NewNode = xmlCreateChild(RootNode, "Text" )
					xmlNodeSetValue(NewNode,text)
					xmlSaveFile(RootNode)
					
					
					outputChatBox("O "..art.." foi reportado com sucesso! Report: ",player,255,255,255)
					outputChatBox(tostring(filename),player,255,255,255)
					
					outputChatBox(getPlayerName(player).." Report enviado com Sucesso:",getRootElement(),255,255,100)
					outputChatBox("Use /bug /report /question /problem ... Para reportar algo!",getRootElement(),255,255,100)
					

end
addEventHandler("send",getRootElement(),send)



					

