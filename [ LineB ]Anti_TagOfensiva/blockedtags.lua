local blockedTags = { "[HITLER]", "[PRETO]", "[VAISEFODER]", "[PINTO]","[PENIS]","[BUCETA]","[PORRA]","[VIADO]","[BAITOLA]","[PUTAS]","[PUTA]","[GM]","[ADM]","[MOD]","[SUPERVISOR]","[supervisor]","[adm]","[moderador]","[administrador]","[gm]","[God]","[Fuck]" };

addEventHandler ( "onResourceStart", getResourceRootElement ( getThisResource() ),
	function ()
		for i, p in ipairs ( getElementsByType ( "player" ) ) do
			local tempName = getPlayerName ( p );

			for x = 1, #blockedTags do
				if ( string.find ( tempName, blockedTags [ i ], 1, true ) ~= nil ) then
					kickPlayer ( source, "#ff0000Essa Tag foi banida, troque-a:" );
				end
			end
		end
	end
);

addEventHandler ( "onPlayerJoin", root,
	function ()
		local name = getPlayerName ( source );

		for i = 1, #blockedTags do
			if ( string.find ( name, blockedTags [ i ], 1, true ) ~= nil ) then
				kickPlayer ( source, "#ff0000Essa Tag foi banida, troque-a:" );
			end
		end
	end
);

addEventHandler ( "onPlayerChangeNick", root,
	function ( _, newNick )
		for i = 1, #blockedTags do
			if ( string.find ( newNick, blockedTags [ i ], 1, true ) ~= nil ) then
				kickPlayer ( source, "#ff0000Essa Tag foi banida, troque-a:" );
			end
		end
	end
);