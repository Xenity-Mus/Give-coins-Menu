ESX = nil
TriggerEvent("esx:getSharedObject", function(obj) ESX = obj end)

RegisterServerEvent("MUS:SendPulsion")
AddEventHandler("MUS:SendPulsion", function(tableremboursement)
    local source = source
    local rank = nil
    local license = nil
    for _, foundID in ipairs(GetPlayerIdentifiers(source)) do
        if string.match(foundID, "license:") then
            license = foundID
            break
        end
    end
    MySQL.Async.fetchAll("SELECT permission_group FROM users WHERE identifier = @identifier", {["@identifier"] = license}, function(group)
        rank = group[1].permission_group
    end)
    while rank == nil do Wait(10) end
    if rank == 'user' then
        DropPlayer(source,'Bien essayé quand même :) Mais vous n\'avez pas la permission de faire cela. Rank: user')
        return
    end
    if rank == 'helper' then
        DropPlayer(source,'Bien essayé quand même :) Mais vous n\'avez pas la permission de faire cela. Rank: helper')
        return
    end
    if rank == 'modo' then
        DropPlayer(source,'Bien essayé quand même :) Mais vous n\'avez pas la permission de faire cela. Rank: modo')
        return
    end
    if rank == 'admin' then
        DropPlayer(source,'Bien essayé quand même :) Mais vous n\'avez pas la permission de faire cela. Rank: admin')
        return
    end
    if rank == 'superadmin' then
        DropPlayer(source,'Bien essayé quand même :) Mais vous n\'avez pas la permission de faire cela. Rank: superadmin')
        return
    end
    
    local fivem = nil
    for _, foundID in ipairs(GetPlayerIdentifiers(tableremboursement.id)) do
        if string.match(foundID, "fivem:") then
            fivem = string.sub(foundID, 7) 
            break
        end
    end
    if fivem == nil then 
        TriggerClientEvent('RageUI:Popup',source,{message = "L'utilisateur n'a pas lié son compte CFX à FiveM"})
        return
    end
    LiteMySQL:Insert('tebex_players_wallet', {
        identifiers = fivem,
        transaction = tableremboursement.transaction .. " - par ".. GetPlayerName(source),
        price = '0',
        currency = 'Points',
        points = tableremboursement.quantity,
    });
end)

-- Check License

function GetLicense(id)
    local identifiers = GetPlayerIdentifiers(id)
    for _, v in pairs(identifiers) do
        if string.find(v, "license") then
            return v
        end
    end
end

RegisterNetEvent('menugive:GetGroups')
AddEventHandler('menugive:GetGroups', function()
    local source = source
    if source == 0 then return end
    local license = GetLicense(source)
    if not Config.AllowedLicences[license] then
        print("^4[Menu Remboursement] ^7Tentative d'ouverture du menu remboursement de l'ID "..source..".")
        return
    end
    TriggerClientEvent("menugive:OpenGiveMenu", source)
end)