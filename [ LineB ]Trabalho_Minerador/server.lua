local StartJob = createMarker ( 577.28497, 871.65967, -44.59248, "cylinder", 1.5, 255, 255, 0, 170 )
local First2 = createMarker ( 264.30255, 1436.28040, 13.46103, "cylinder", 1.5, 255, 255, 0, 170 )
local First = createMarker ( 597.90387, 829.00623, -44.20296, "cylinder", 1.5, 255, 255, 0, 170 )
local myBlip = createBlipAttachedTo ( First2, 51 )
local myBlip2 = createBlipAttachedTo ( First, 41 )
setElementVisibleTo ( First2, root, false )
setElementVisibleTo ( First, root, false )
setElementVisibleTo ( myBlip, root, false )
setElementVisibleTo ( myBlip2, root, false )

m1 = createObject(6930, 271.4658203125, 1457.7819824219, 15.5859375, 0, 0, 0) 
m2 = createObject(3287, 262.82376098633, 1438.1083984375, 12.5859375, 0, 0, 0) 
m3 = createObject(3214, 262.841796875, 1432.919921875, 18.0859375, 0, 0, 0) 


function MarkerHit( hitElement, matchingDimension ) -- define MarkerHit function for the handler  
				setElementData(hitElement, "Occupation", "Minerador")
				setPlayerNametagColor ( hitElement, 222, 255, 4)
				outputChatBox ( "Você agora é um minerador!", hitElement, 255, 255, 255, true )
				setElementVisibleTo ( First, hitElement, true )
				setElementVisibleTo ( myBlip2, hitElement, true )
			end
addEventHandler( "onMarkerHit", StartJob, MarkerHit ) -- attach onMarkerHit event to MarkerHit function

function MarkerHit2(hitElement, matchingDimension) -- define MarkerHit function for the handler
local elementType = getElementType( hitElement)
if not isElementVisibleTo(First,hitElement) then
else
if not isPedInVehicle ( hitElement ) then
setPedFrozen( hitElement, true)
setPedAnimation(hitElement , "ped", "ATM", 5000, false, false, false, false)
s1 = setTimer ( function()
				outputChatBox ( "Chefe: Leve o minério de volta à fábrica!", hitElement, 255, 0, 0, true )
				setElementVisibleTo ( First2, hitElement, true )
				setElementVisibleTo ( myBlip2, hitElement, false )
				setElementVisibleTo ( First, hitElement, false )
				setElementVisibleTo ( myBlip, root, false )
				setElementVisibleTo ( myBlip, hitElement, true )
				setPedAnimation(hitElement,false)
				setPedFrozen( hitElement, false)
				killTimer(s1)
	end, 5000, 1 )
	else
end
end
end
addEventHandler( "onMarkerHit", First, MarkerHit2 ) -- attach onMarkerHit event to MarkerHit function


function MarkerHit3( hitElement, matchingDimension ) -- define MarkerHit function for the handler
local elementType = getElementType( hitElement ) -- get the hit element's type
local myNumber = math.random(1000,10000)
local iron = math.random(50,250)
if not isElementVisibleTo(First2,hitElement) then
else
setPedFrozen( hitElement, true)
setPedAnimation(hitElement , "ped", "ATM", 5000, false, false, false, false)
s2 = setTimer ( function()
				outputChatBox ( "Chefe: Muito bom.. Aqui está o seu dinheiro.. vá buscar mais ferro!", hitElement, 255, 0, 0, true )
				givePlayerMoney ( hitElement, myNumber ) --give the player money according to the amount
				setElementVisibleTo ( First2, hitElement, false )
				setElementVisibleTo ( First, hitElement, true )
				setElementVisibleTo ( myBlip2, hitElement, true )
				setElementVisibleTo ( myBlip, hitElement, false )
				setPedAnimation(hitElement, false)
				setPedFrozen( hitElement, false)
				killTimer(s2)
	end, 5000, 1 )
			end
			end
addEventHandler( "onMarkerHit", First2, MarkerHit3 ) -- attach onMarkerHit event to MarkerHit function

function QuitIronMiner (thePlayer)
if getElementData(thePlayer, "Occupation") == "Iron Miner" then
outputChatBox ( "Você não é mais Mineiro!", thePlayer, 255, 0, 0, true )
setElementData(thePlayer,"Occupation", "")
end
end
-- Attach the 'consoleCreateMarker' function to the "createmarker" command
addCommandHandler ( "quitironminer", QuitIronMiner )


function Check1()
for _,thePlayer in ipairs(getElementsByType("player")) do
        if getElementData(thePlayer, "Occupation") ~= "Iron Miner" then
				setElementVisibleTo ( First2, thePlayer, false )
				setElementVisibleTo ( myBlip, thePlayer, false )
                setElementVisibleTo ( First, thePlayer, false )
				setElementVisibleTo ( myBlip2, thePlayer, false )
				else
		end
		end
		end
setTimer(Check1, 1000, 0)

function Check2()
for _,thePlayer in ipairs(getElementsByType("player")) do
        if getElementData(thePlayer, "Occupation") == "Iron Miner" then
				setElementVisibleTo ( myBlip2, thePlayer, true )
                setElementVisibleTo ( First, thePlayer, true )
				else
		end
		end
		end
addEventHandler ( "onResourceStart", getRootElement(), Check2 )



