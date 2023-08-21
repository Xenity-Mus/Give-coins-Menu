ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local checkedrembourse = false
local target = "?"
local target2 = "?"
local target3 = "?"
local mainMenu = RageUI.CreateMenu("XenityDev", "Remboursement")
local open = false
local tableremboursement = {}
local remboursementok1 = false
local remboursementok2 = false
local remboursementok3 = false

mainMenu:DisplayGlare(false)
mainMenu.Closed = function()
    tableremboursement = {}
    open = false
    target = "?"
    target2 = "?"
    target3 = "?"
    checkedrembourse = false
end
mainMenu.TitleFont = 4

local function KeyboardInput(entryTitle, textEntry, inputText, maxLength)
	AddTextEntry(entryTitle, textEntry)
	DisplayOnscreenKeyboard(1, entryTitle, '', inputText, '', '', '', maxLength)

	while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do
		Citizen.Wait(0)
	end

	if UpdateOnscreenKeyboard() ~= 2 then
		local result = GetOnscreenKeyboardResult()
		Citizen.Wait(500)
		return result
	else
		Citizen.Wait(500)
		return nil
	end
end

function remboursement()
    if open then return end
    open = true
    CreateThread(function()
        while open do
            Wait(1)
            
            RageUI.IsVisible(mainMenu, function()

                RageUI.Checkbox("Remboursement Boutique", "Menu réservé uniquement aux fondateurs", checkedrembourse, {}, {
                    onChecked = function()
                    end,
                    onUnChecked = function()
                    end,
                    onSelected = function(Index)
                        checkedrembourse = Index
                    end
                })

                if (checkedrembourse) then
                    RageUI.Button('ID du joueur', nil, { RightLabel = target}, true, {
                        onHovered = function()
                        end,
                        onSelected = function()
                            local selecteduser = KeyboardInput('BOX', "ID du joueur à rembourser", '', 10)
                            if selecteduser then
                                tableremboursement.id = tonumber(selecteduser)
                                target = selecteduser
                                remboursementok1 = true
                            else
                                Visual.Subtitle("Information manquante.",2000)
                            end
                        end,
                    })
                    RageUI.Button('Nombre de pulsion', nil, { RightLabel = target2}, true, {
                        onHovered = function()
                        end,
                        onSelected = function()
                            local selectedquantity = KeyboardInput('BOX', "Quantité à rembourser", '', 10)
                            if selectedquantity then
                                tableremboursement.quantity = tonumber(selectedquantity)
                                target2 = selectedquantity
                                remboursementok2 = true
                            else
                                Visual.Subtitle("Information manquante.",2000)
                            end
                        end,
                    });
                    RageUI.Button('Raison', nil, { RightLabel = target3}, true, {
                        onHovered = function()
                        end,
                        onSelected = function()
                            local selectedreason = KeyboardInput('BOX', "Raison du remboursement", '', 15)
                            if selectedreason then
                                tableremboursement.transaction = selectedreason
                                target3 = selectedreason  
                                remboursementok3 = true
                            else
                                Visual.Subtitle("Information manquante.",2000)
                            end
                        end,
                    });
                    RageUI.Button("~g~Rembourser", nil, { RightLabel = "→→"}, true, {
                        onSelected = function()
                        if remboursementok1 and remboursementok2 and remboursementok3 then
                            TriggerServerEvent('MUS:SendPulsion',tableremboursement)
                            Visual.Subtitle("Remboursement effuctué.",2000)
                            RageUI.CloseAll()
                            remboursementok1 = false
                            remboursementok2 = false
                            remboursementok3 = false
                            checkedrembourse = false
                            elseif remboursementok1 == false then
                                Visual.Subtitle("ID du joueur manquante.",2000)
                            elseif remboursementok2 == false then
                                Visual.Subtitle("Quantité de pulsion manquante.",2000)
                            elseif remboursementok3 == false then
                                Visual.Subtitle("Raison manquante.",2000)
                        end
                    end,
                    })
                end
        end)
        end
    end)
end      

Keys.Register('INSERT','INSERT', 'Remboursement', function()
    TriggerServerEvent("menugive:GetGroups")
end)

RegisterNetEvent("menugive:OpenGiveMenu")
AddEventHandler("menugive:OpenGiveMenu", function(license)
    remboursement()
    RageUI.Visible(mainMenu, not RageUI.Visible(mainMenu))
end)