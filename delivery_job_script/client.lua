-- client/main.lua
ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
end)

local deliveryLocation = nil

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if deliveryLocation then
            DrawMarker(1, deliveryLocation.x, deliveryLocation.y, deliveryLocation.z - 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 0, 255, 0, 255, false, true, 2, false, false, false, false)
            
            if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), deliveryLocation.x, deliveryLocation.y, deliveryLocation.z, true) < 1.5 then
                ESX.ShowHelpNotification('Press ~INPUT_CONTEXT~ to complete the delivery')
                if IsControlJustReleased(0, 38) then
                    TriggerServerEvent('esx_delivery:completeDelivery')
                    deliveryLocation = nil
                end
            end
        end
    end
end)

function StartDelivery()
    ESX.TriggerServerCallback('esx_delivery:checkDelivery', function(delivery)
        if delivery then
            deliveryLocation = delivery
            ESX.ShowNotification('A new delivery has been assigned!')
        else
            ESX.ShowNotification('No delivery available at the moment.')
        end
    end)
end

RegisterCommand('startdelivery', function()
    StartDelivery()
end, false)
