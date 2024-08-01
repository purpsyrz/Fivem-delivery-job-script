-- server/main.lua
ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local deliveries = {
    {x = 100.0, y = 100.0, z = 28.0}, -- Example delivery location
    {x = 200.0, y = 200.0, z = 28.0}  -- Add more locations as needed
}

ESX.RegisterServerCallback('esx_delivery:checkDelivery', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer then
        local delivery = deliveries[math.random(#deliveries)]
        cb(delivery)
    else
        cb(nil)
    end
end)

RegisterNetEvent('esx_delivery:completeDelivery')
AddEventHandler('esx_delivery:completeDelivery', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer then
        xPlayer.addMoney(100)  -- Amount to be paid for the delivery
        TriggerClientEvent('esx:showNotification', source, 'Delivery completed! You earned $100')
    end
end)
