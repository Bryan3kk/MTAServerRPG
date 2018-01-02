-- Começa os blocos de comandos
addEvent("checkFPSEvent", true)
local playerFPS = { }
local PingStrikes = { }
local FPSStrikes = { }
-- Termina os blocos de comandos

-- Começa as configurações do bloco.
local MaxPingCheck = true
local MaxPing = 400

local MinFPSCheck = true
local MinFPS = 15
-- Termina as configurações do bloco.

-- Começo da parte principal do bloco
function getPlayerFPS(v)
    if (playerFPS[v]) then
        return playerFPS[v]
    else
        return nil
    end
end


function KickMaxPing()
    for k, v in ipairs(getElementsByType("player")) do
        local name = getPlayerName(v)
        if (MaxPingCheck == true) then
            if (getPlayerPing(v) > MaxPing) then
                if isObjectInACLGroup("user."..getAccountName(getPlayerAccount(v)), aclGetGroup("Admin")) then
                    if PingStrikes[name] == 0 then
                        outputChatBox("Seu Ping está muito alto!", v, 255, 0, 0, false)
                        PingStrikes[name] = PingStrikes[name] + 1
                    end
                    return false
                end
                if isObjectInACLGroup("user."..getAccountName(getPlayerAccount(v)), aclGetGroup("Level-3")) then
                    if PingStrikes[name] == 0 then
                        outputChatBox("Seu Ping está muito alto!", v, 255, 0, 0, false)
                        PingStrikes[name] = PingStrikes[name] + 1
                    end
                    return false
                end
                if PingStrikes[name] < 3 then
                    PingStrikes[name] = PingStrikes[name] + 1
                    outputChatBox("Seu Ping está muito alto! Será expulso em:" .. PingStrikes[name] .. " em segundos.", v, 255, 0, 0)
                elseif PingStrikes[name] >= 3 then
                    kickPlayer(v, "Security: Seu Ping:(" .. getPlayerPing(v) .. ") está muito alto!")
                    outputChatBox(name .. " Foi expulso por estar com Ping alto.", getRootElement(), 255, 0, 0, false)
                    PingStrikes[name] = nil
                end
            end
        end
    end
end


function checkFPS(rfps)
    local fps = rfps / 10
    playerFPS[source] = fps
    local name = getPlayerName(source)
    if (MinFPSCheck) then
        if (fps < MinFPS) then
            if isObjectInACLGroup("user."..getAccountName(getPlayerAccount(source)), aclGetGroup("Admin")) then
                    if FPSStrikes[name] == 0 then
                        outputChatBox("Seu FPS está baixo!", source, 255, 0, 0, false)
                        FPSStrikes[name] = FPSStrikes[name] + 1
                    end
                return false
            end
            if isObjectInACLGroup("user."..getAccountName(getPlayerAccount(source)), aclGetGroup("Level-3")) then
                    if FPSStrikes[name] == 0 then
                        outputChatBox("Seu FPS está baixo!", source, 255, 0, 0, false)
                        FPSStrikes[name] = FPSStrikes[name] + 1
                    end
                return false
            end
            if FPSStrikes[name] < 3 then
                FPSStrikes[name] = FPSStrikes[name] + 1
                outputChatBox("Seu FPS está baixo e será expulso" .. FPSStrikes[name] .. " em segundos.", source, 255, 0, 0)
            elseif FPSStrikes[name] >= 3 then
                kickPlayer(source, "Security: Seu FPS(" .. getPlayerFPS(source) .. ") está muito baixo!")
                outputChatBox(name .. " Foi expulso por estar com FPS muito baixo!", getRootElement(), 255, 0, 0, false)
            end
        end
    end
end
addEventHandler("checkFPSEvent", getRootElement(), checkFPS)


function OnClearSlot()
    local name = getPlayerName(source)
    playerFPS[name] = nil
end
addEventHandler("onPlayerJoin", getRootElement(), OnClearSlot)
addEventHandler("onPlayerQuit", getRootElement(), OnClearSlot)


function createMyTables()
    for k, v in ipairs(getElementsByType("player")) do
        local name = getPlayerName(v)
        FPSStrikes[name] = 0
        PingStrikes[name] = 0
    end
end
addEventHandler("onResourceStart", getRootElement(), createMyTables)


function updateMyTables()
    local name = getPlayerName(source)
    if eventName == "onPlayerJoin" then
        PingStrikes[name] = 0
        FPSStrikes[name] = 0
    else
        PingStrikes[name] = nil
        FPSStrikes[name] = nil
    end
end
addEventHandler("onPlayerJoin", getRootElement(), updateMyTables)
addEventHandler("onPlayerQuit", getRootElement(), updateMyTables)


function StartTheTimers()
    setTimer(KickMaxPing, 10000, 0)
    PhUx9 = 0
end
addEventHandler("onResourceStart", getResourceRootElement(getThisResource()), StartTheTimers)
-- Final do código de programação