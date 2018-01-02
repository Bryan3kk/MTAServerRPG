local x, y = guiGetScreenSize()
addEventHandler("onClientRender", root,)
function()
local time = getRealTime()
local hour = time.hour
local minute = time.minute
local second = time.second
local year = time.year + 1900
local month = time.month + 1
local day  =time.monthday
if ( month < 10 ) then month = 0 .. month end
if ( day < 10 ) then day = 0 .. day end
local date = table.concat ( { year, month, day }, "-" )	
local fps = getElementData(getLocalPlayer(),"FPS")
local ping = getPlayerPing(getLocalPlayer())
local playerHealth = getElementHealth ( localPlayer )
local HPLine = 220 * ( playerHealth / 100 )
local Armor = getPedArmor(getLocalPlayer())
local ArmorLine = 220 * ( Armor / 100 )	

	
        dxDrawRectangle(x * 0.8180, y * 0.0505, x * 0.1650, y * 0.0300, tocolor(0, 0, 0, 200), false) --HP gechis vonal
        dxDrawRectangle(x * 0.8180, y * 0.0900, x * 0.1650, y * 0.0300, tocolor(0, 0, 0, 200), false) --Armor gechis vonal
		dxDrawRectangle(x * 0.8200, y * 0.053,HPLine,19,tocolor(230, 67, 67, 200) ,false) --Health
        dxDrawRectangle(x * 0.8200, y * 0.092,ArmorLine,19, tocolor(57,210,255, 150), false) --Armor
        dxDrawText(playerMoney(), x * 0.8900, y -970, x * 0.9930, y * 0.3250, tocolor(255, 255, 255, 255), 1.00, "pricedown", "center", "center", false, false, false, true, false)
        dxDrawText(hour..":"..minute..":"..second.."", x * 0.74, y -910, x * 0.9464, y * 0.2472, tocolor(255, 255, 255, 255), 1.00, "pricedown", "center", "center", false, false, false, false, false)
		


		
    end
)



---Money
local money = {}
money.nulls = nil
money.string = ""
function playerMoney()

	money.string = "";
	money.nulls = 7 - string.len(tostring(getPlayerMoney(localPlayer)));
	 
	for i = 0, money.nulls, 1 do
		money.string = money.string .. "0";
	end
	
	return "#FFFFFF$" .. money.string .. "#7CC576" .. getPlayerMoney(localPlayer)

end