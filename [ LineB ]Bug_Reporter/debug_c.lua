x, y = guiGetScreenSize()

function ininstall()

				main_window = guiCreateWindow((x/2)-150,(y/2)-200,300,400,"Entre em Contato!  -  Sugestões, Novidades ou Bugs? ",false)
				guiSetAlpha(main_window,255)
				
				radio_bug=guiCreateRadioButton(0.1,0.04,0.4,0.1,"Bug",true,main_window)
				radio_idea=guiCreateRadioButton(0.4,0.04,0.4,0.1,"Idea",true,main_window)
				radio_question=guiCreateRadioButton(0.7,0.04,0.4,0.1,"Question",true,main_window)
				guiRadioButtonSetSelected(radio_idea,true)
				
				main_memo = guiCreateMemo ( 0.05, 0.15, 0.96, 0.75,"Ao reportar bug's você pode receber uma quantia em dinheiro por isso: ", true, main_window)
				
				button_send = guiCreateButton( 0.15,0.93,0.3,0.05,"Enviar",true,main_window)
				button_cancel = guiCreateButton(0.55, 0.93,0.3,0.05,"Cancelar",true,main_window)
				guiSetVisible(main_window,false)

				addEventHandler("onClientGUIClick",button_send,function()
					if button_send==source then
					send()
					end
				end)
				
				addEventHandler("onClientGUIClick",button_cancel,function()
					if button_cancel==source then
						cancel()
						guiSetVisible(main_window,false)
					end
				end)
end
addEventHandler("onClientResourceStart", getRootElement(),ininstall)

function visible()
		if guiGetVisible(main_window)==true then
		showChat(true)
		showCursor(false)
		guiSetVisible(main_window,false)
		else 
		showChat(false)
		showCursor(true)
		guiSetVisible(main_window,true)
		end
end
addCommandHandler("bug",visible)
addCommandHandler("ideia",visible)
addCommandHandler("duvida",visible)
addCommandHandler("sugestao",visible)
addCommandHandler("problema",visible)
addCommandHandler("reportar",visible)


function message_one()
	outputChatBox("Dúvidas, Sugestões ou Bugs? Use o /reportar para gerar um ticket: ",100,100,255)
	
end	
setTimer(message,900000,0)	

function message_two()
	outputChatBox("Você é criativo? Cheio de ideias? Use o /ideia e gere um ticket: ",255,255,100)
end
setTimer(message,800000,0)



function send()
	text=guiGetText(main_memo)
	--if not text==nil then 
			local time=getRealTime()
			text="User:  "..tostring(getPlayerName(getLocalPlayer())).."  Time: "..time.hour..":"..time.minute.."\n\n"..text
			
				if (guiRadioButtonGetSelected(radio_bug)) then
				art="Bug"
				elseif (guiRadioButtonGetSelected(radio_idea)) then
				art="Ideia"
				elseif (guiRadioButtonGetSelected(radio_question)) then
				art="Duvida"
				end
			
			triggerServerEvent("send",getLocalPlayer(),getLocalPlayer(),text,art)
			visible()
	--else
	--showChat(true)
	--outputChatBox("Não é possivel reportar, seu ticket está em branco!",100,100,255)
	--end
end



function cancel()
		visible()
end