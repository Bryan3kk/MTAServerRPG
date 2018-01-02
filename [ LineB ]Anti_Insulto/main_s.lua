local insults = {
	"Puta",
	"noob",
	"puta",
	"Cotoco",
	"cotoco",
	"verme",
	"Caralho",
	"caralho",
	"puto",
	"desgraçado",
	"Hitler",
	"hitler",
	"allahu akbar",
	"hail hitler",
	"Stalin",
	"Lula",
	"lula",
	"Dilma",
	"dilma",
	"toma no cu",
	"cu",
	"buceta",
	"pinto",
	"vagabunda",
	"vagabundo",
	"piranha",
	"baitola",
	"porra",
	"pal no cu",
	"viado",
	"Lula2018",
	"Desgraçado",
	"Seu macaco",
	"Preto favelado",
	"Favelado",
	"Caralho",
	"Tomar no cu",
	"Vai se foder",
	"VSF",
	"VTNC",
	"Puto",
	"Viado",
	"Baitola",
	"Cuzão",
	"Pal no cu",
	"Vai tomar no cu",
	"Piranha",
	"Vagabunda",
	"Vagabundo",
	"Porra",
	"Pinto",
	"Buceta",
	"anal",
	"Sexo",
	"Estuprar",
	"Piranha"
}

local replace_sentence = {
"Evite Ofensas!",
"Leia às Regras!",
"Respeite às Regras!",
}

local max_insult = 3;
local uebereinstimmungsrate = 4;
local handle_type = 1;
-- handle_type 1 = Refaz a frase com aviso de segurança
-- handle_type 2 = kicks o jogador por "max_insult" do servidor.
-- handle_type 3 = Estabelece termos (não completado)
-- handle_type 4 = Não compromete nada

addEventHandler("onPlayerChat", root, function(message, _type)
	for index, val in pairs(insults) do
		local new_val = val:lower();
		local message = message:lower();
		local match = false;
		
		local laufwert = 0;
		if message:len() > new_val:len() then
			laufwert = new_val:len();
		elseif message:len() < new_val:len() then
			laufwert = message:len();
		elseif message:len() == new_val:len() then
			laufwert = new_val:len();
		end	
		
		if ( handle_type == 3 ) then
			-- local currentLaufwert = 1;
			-- local match = false;
			-- local break_schleife = false;
			-- laufwert = message:len();
			-- local inte_laufwert = 1;
			
			-- local search_in_text_match = false
			-- while ( inte_laufwert < laufwert+1 and search_in_text_match == false ) do
				-- if ( string.byte(tostring(message), inte_laufwert) == string.byte(new_val) ) then
					-- search_in_text_match = true
					-- if inte_laufwert == 1 then
						-- outputDebugString("A");
					-- end
				-- end
				-- inte_laufwert = inte_laufwert+1
			-- end
			
			-- if search_in_text_match then
				-- while ( (currentLaufwert < laufwert+1) and ( break_schleife == false ) ) do
					-- if ( string.byte(tostring(message), currentLaufwert+inte_laufwert) ) then
						
						-- if ( string.byte(tostring(message), currentLaufwert+inte_laufwert) ~= string.byte(tostring(new_val), currentLaufwert) ) then
							-- break_schleife = true
						-- else 
							-- if ( currentLaufwert >= uebereinstimmungsrate ) then
								-- match = true
								-- break_schleife = true
							-- end
						-- end
						
						-- currentLaufwert = currentLaufwert+1
					-- end
				-- end
			-- end
		elseif ( handle_type == 2 ) then
			local currentLaufwert = 1;
			local break_schleife = false;
			while ( (currentLaufwert < laufwert+1) and ( break_schleife == false ) ) do
				if ( string.byte(tostring(message), currentLaufwert) ~= string.byte(tostring(new_val), currentLaufwert) ) then
					break_schleife = true
				else 
					if ( currentLaufwert >= uebereinstimmungsrate ) then
						match = true
						break_schleife = true
					end
				end
				
				currentLaufwert = currentLaufwert+1
			end
			
			if ( match ) then
				cancelEvent();
				handle_match(1);
				break;
			end
			
		elseif ( handle_type == 1 ) then
			local currentLaufwert = 1;
			local break_schleife = false;
			while ( (currentLaufwert < laufwert+1) and ( break_schleife == false ) ) do
				if ( string.byte(tostring(message), currentLaufwert) ~= string.byte(tostring(new_val), currentLaufwert) ) then
					break_schleife = true
				else 
					if ( currentLaufwert >= uebereinstimmungsrate ) then
						match = true
						break_schleife = true
					end
				end
				
				currentLaufwert = currentLaufwert+1
			end
		
			if ( match ) then
				cancelEvent();
				handle_match(2);
				break;
			end
		end
			
		
		
	end
end)

function handle_match(_type)
	if ( _type == 1 ) then
		local oriVal = getElementData(source, "b_count")
		if ( oriVal == false ) then
			setElementData(source, "b_count", 1);
			oriVal = 1;
		else
			oriVal = oriVal+1
			setElementData(source, "b_count", oriVal)
		end
		
		if ( oriVal > max_insult ) then
			kickPlayer(source, source, "Você foi expulso por Ofensas, Leia às regras!")
		else
			outputChatBox(string.format("#FF0000 AVISO %d: '%s' Ofensas não são permitidas! Você será expulso:", oriVal, val), source, 255, 0, 0)
		end
	elseif ( _type == 2 ) then
		local rand = math.random(1, #replace_sentence);
		outputChatBox(string.format("%s - #FFFFFF[#FF0000LineB - Security#FFFFFF]", replace_sentence[rand]), root, 100, 100, 0, true);
	end
	
end

addEventHandler("onResourceStop", root, function()
	for index, ply in pairs(getElementsByType("player")) do 
		setElementData(ply, "b_count", 0); -- reset
	end
end)

addEventHandler("onResourceStart", root, function()
	
end)