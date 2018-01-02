function createSAPDTeam ()
    MedicTeam = createTeam ("Paramédicos", 0, 255, 255)
end

function joincriminal()
if isObjectInACLGroup("user."..getAccountName(getPlayerAccount(source)), aclGetGroup("Everyone")) then
local wlevel = getPlayerWantedLevel( source )
end
end
addEventHandler ("onResourceStart", resourceRoot, createSAPDTeam)
 
function joinSAPD()
     setPlayerNametagColor ( source, 0, 255, 255 )
     setPlayerTeam(source,MedicTeam)
     outputChatBox("Você agora é um Paramédico:", source, 0, 255, 255)
     setElementFrozen ( ped, true )
     setElementHealth ( ped, 180 )
     giveWeapon ( source, 41, 99999 )
     setElementData( source, "Occupation", "Paramédico", true )
     setElementData ( source, "Rank", "Agente Federal" )
end
addEvent("MMedic", true)
addEventHandler("MMedic",root,joinSAPD)
addEvent("medic:healing", true)
addEventHandler("medic:healing", root,
function (medic)
    if (getElementHealth(source) < 100) then
        local Heal = getElementHealth(source) + 10 -- New health
        setElementHealth(source, Heal) 
        if (Heal > 100) then
             setElementHealth(source, 100)
        end
        givePlayerMoney(medic, 500) -- Gives 500$ para o paramedico quando curar
        takePlayerMoney(source, 500) -- Takes 500$ quando é curado
    end
end)