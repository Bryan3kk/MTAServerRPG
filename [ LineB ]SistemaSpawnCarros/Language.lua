Language =["Português"] = {
		[System.wnd] = ". :: [Sistema Criador de Carros] ::.",
		[GUIEditor.label[1]] = "Bem Vindo ao Sistema de Criar Carros",	
		[GUIEditor.label[2]] = "Posição: ",
		[GUIEditor.label[6]] = "idioma: ",	
		[GUIEditor.label[7]] = "Sistema de Veículo Marker: ",
		[GUIEditor.button[1]] = "A obter posição: ",
		[GUIEditor.button[2]] = "Qual a Cor do Marcador: ",
		[GUIEditor.button[3]] = "Criar Local de Veiculo: ",
	},
}


function getLangage( str )
	if Language[ str ] then
		return true;
	end;
	return false;
end;

function AddLanguage( str )
	local lang = {};
	if getLangage( str ) then
		for k, v in pairs ( Language[ str ] ) do
			if not isElement(k) then
			    outputDebugString ( "Error in Languge table" );
				return {};
			end;
			table.insert(lang, {element = k,id = v});
		end;
	end;
	return lang;
end;