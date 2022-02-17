local ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
	TriggerEvent('esx:setMoneyDisplay', 0.0)
	ESX.UI.HUD.SetDisplay(0.0)

end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer) 
	local data = xPlayer
	local accounts = data.accounts
	for k, v in pairs(accounts) do
		local account = v
		if account.name == "black_money" then
			if account.money > 0 then
			SendNUIMessage({action = "setBlackMoney", black = account.money})
			else
			SendNUIMessage({action = "hideBlackMoney"})
			end
		end
	end
	SendNUIMessage({action = "setVoiceLevel", level = 1})

	SendNUIMessage({action = "setMoney", money = data.money})
end)

hasKM = 0
showKM = 0
factor = 3.6 

function round(num, numDecimalPlaces)
	local mult = 10^(numDecimalPlaces or 0)
	return math.floor(num * mult + 0.5) / mult
end

Citizen.CreateThread(
    function()
        while true do
			local sleep = 500
            local ped = GetPlayerPed(-1)
            if (IsPedInAnyVehicle(ped)) then
				sleep = 15
                local vehicle = GetVehiclePedIsIn(ped, false)
                if vehicle then
                    carSpeed = math.ceil(GetEntitySpeed(vehicle) * factor)
                    carRPM = GetVehicleCurrentRpm(vehicle)
                    fuel = math.floor(GetVehicleFuelLevel(vehicle) + 0.0)

                    if IsVehicleEngineOn(vehicle) then
                        SendNUIMessage({vehicleon = true})
                    else
                        SendNUIMessage({vehicleon = false})
                    end

                    if GetVehicleDoorLockStatus(vehicle) == 2 then
                        SendNUIMessage({locked = true})
                    else
                        SendNUIMessage({locked = false})
                    end

                    SendNUIMessage({
                            zeigehud = true,
                            speed = carSpeed,
                            KMH = KPH,
                            tank = fuel,
                            km = showKM
                        })
                else
                    SendNUIMessage({zeigehud = false})
                    Citizen.Wait(1000)
                end
            else
                SendNUIMessage({zeigehud = false})
                Citizen.Wait(100)
            end
            Citizen.Wait(sleep)
        end
    end
)