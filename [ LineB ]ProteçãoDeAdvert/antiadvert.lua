local BannedWords = {"22003", ":22", "22010", "22005", "tasa:","Acesse","010",":22003",":2203","Best Server","mtasa","mtasa:","http","https","www",".net",".br",".eu",".org"}

addEventHandler("onPlayerChat",root,
  function(msg)

    function checkBannedWords(Message)

      for _, BannedWord in ipairs(BannedWords) do
        if (Message:lower()):find(BannedWord:lower()) then
          return 2
        end
      end

      local Chunks = {(Message:gsub("%s+", "")):match("(%d+)%.(%d+)%.(%d+)%.(%d+)")}
      if (#Chunks == 4) then
        return 1
      end

      return 0
    end


    -- Definitions
    -- 1 = Possivel divulgação
    -- 2 = Divulgação Confirmada

    local result = checkBannedWords(msg)
    if (result == 1) then
      cancelEvent()
      outputChatBox("[LineB Security] Suspeita de Divulgação Detectada: ", source, 255, 0, 0)
      outputServerLog("[LineB Security] Usuário: " .. getPlayerName(source) .. " Tentou divulgar: '" .. msg .. "'")
      local _players = getElementsByType("player")
      for _, v in pairs(_players) do
        if (getPlayerAccount(v)) then
          if ((isObjectInACLGroup("user." .. getAccountName(getPlayerAccount(v)), aclGetGroup("Admin"))) or (isObjectInACLGroup("user." .. getAccountName(getPlayerAccount(v)), aclGetGroup("Moderator")))) then
            outputChatBox("[LineB Security] " .. getPlayerName(source) .. " Tentou divulgar: '" .. msg .. "'", v)
          end
        end
      end
    elseif (result == 2) then
      cancelEvent()
      local g_Name = getPlayerName(source)
      local _r,_g,_b = getPlayerNametagColor(source)
      outputChatBox( g_Name .. "[LineB Security]: Divulgação " .. 'foi detectada e banida:' , g_Root, _r, _g, _b, false)
      banPlayer ( source, false, false, true, nil, "[LineB Security]Não divulgue outros servidores:", 604800)
    end
  end
)