local QBCore = exports['qb-core']:GetCoreObject()
local driftMode = false

RegisterNetEvent('cc-driftkit:client:drifmode', function()
    local ped = PlayerPedId()
    if IsPedInAnyVehicle(ped) then
	local vehicle = GetVehiclePedIsIn(ped, false)
	local props = QBCore.Functions.GetVehicleProperties(vehicle)
	QBCore.Functions.TriggerCallback('cc-driftkit:server:isOwner', function(isOwner)
	    if isOwner then
	        if (GetPedInVehicleSeat(vehicle, -1) == ped) then
		    local modifier = 1

		    if GetVehicleHandlingFloat(vehicle, "CHandlingData", "fInitialDragCoeff") > 90 then
			driftMode = true 
		    else 
			driftMode = false 
		    end

		    if driftMode then modifier = -1 end
  		    for index, value in ipairs(Config.handleMods) do
			SetVehicleHandlingFloat(vehicle, "CHandlingData", value[1], GetVehicleHandlingFloat(vehicle, "CHandlingData", value[1]) + value[2] * modifier)
		    end
		    if driftMode then
			exports['okokNotify']:Alert("Standard Mode Activted", "Drift Mode Disabled", 3500, "info")
		    else
			exports['okokNotify']:Alert("Drift Mode Activated", "Make Sure Your RaceHarness Is On", 3500, "warning")
		    end
	            if GetVehicleHandlingFloat(vehicle, "CHandlingData", "fInitialDragCoeff") < 90 then
			SetVehicleEnginePowerMultiplier(vehicle, 0.0)
		    else
			if GetVehicleHandlingFloat(vehicle, "CHandlingData", "fDriveBiasFront") == 0 then
		            SetVehicleEnginePowerMultiplier(vehicle, 190.0)
			else
			    SetVehicleEnginePowerMultiplier(vehicle, 100.0)
			end
		    end
		end
	    else
                driftMode = false
		exports['okokNotify']:Alert("Vehicle Is Not Owned By You", "Make Sure You Own It", 3500, "error")
	    end
	end, props.plate)
    end
end)
