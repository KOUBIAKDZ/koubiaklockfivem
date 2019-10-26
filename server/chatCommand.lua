--//EDITED BY KOUBIAK (DEV)#3046

if(globalConf["SERVER"].enableGiveKey)then
    RegisterCommand('anahtarver', function(source, args, rawCommand)
        local src = source
        local identifier = GetPlayerIdentifiers(src)[1]

        if(args[1])then
            local targetId = args[1]
            local targetIdentifier = GetPlayerIdentifiers(targetId)[1]
            if(targetIdentifier)then
                if(targetIdentifier ~= identifier)then
                    if(args[2])then
                        local plate = string.lower(args[2])
                        if(owners[plate])then
                            if(owners[plate] == identifier)then
                                alreadyHas = false
                                for k, v in pairs(secondOwners) do
                                    if(k == plate)then
                                        for _, val in ipairs(v) do
                                            if(val == targetIdentifier)then
                                                alreadyHas = true
                                            end
                                        end
                                    end
                                end

                                
                                if(not alreadyHas)then
                                    TriggerClientEvent("ls:giveKeys", targetIdentifier, plate)
                                    TriggerEvent("ls:addSecondOwner", targetIdentifier, plate)

                                    TriggerClientEvent("ls:notify", targetId, "Vous avez reçu les clés du véhicule " .. plate .. " par " .. GetPlayerName(src))
                                    TriggerClientEvent("ls:notify", src, "Vous avez donné les clés du véhicule " .. plate .. " à " .. GetPlayerName(targetId))
                                else
                                    TriggerClientEvent("ls:notify", src, "La personne a déjà les clés du véhicule")
                                    TriggerClientEvent("ls:notify", targetId, GetPlayerName(src) .. " essayé à vous donner ses clés, mais vous les aviez déjà")
                                end
                            else
                                TriggerClientEvent("ls:notify", src, "Ce n'est pas ta bagnole.")
                            end
                        else
                            TriggerClientEvent("ls:notify", src, "Aucun véhicule avec cette plaque")
                        end
                    else
                        TriggerClientEvent("ls:notify", src, "Le deuxième argument manquant est: /keyver <id> <plaque>")
                    end
                else
                    TriggerClientEvent("ls:notify", src, "Vous ne pouvez pas vous cibler.")
                end
            else
                TriggerClientEvent("ls:notify", src, "Aucun joueur trouvé")
            end
        else
            TriggerClientEvent("ls:notify", src, 'Premier argument manquant : /key <id> <plaque>')
        end

        CancelEvent()
    end)
end
