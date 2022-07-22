local rla = peripheral.find("fissionReactorLogicAdapter")
local boi = peripheral.find("boilerValve")
local trb = peripheral.find("turbineValve")
local ind = peripheral.find("inductionPort")
local mon = peripheral.find("monitor")

local function regulator()
    if rla.getCoolantFilledPercentage() > 0.7 and
        rla.getHeatedCoolantFilledPercentage() < 0.7 and
        rla.getWasteFilledPercentage() < 0.7 and
        rla.getDamagePercent() < 1 and
        ind.getEnergyFilledPercentage() < 0.9 and
        rla.getStatus() == false
    then
        rla.activate()
    elseif rla.getStatus() == true and
        (rla.getCoolantFilledPercentage() < 0.7 or
            rla.getHeatedCoolantFilledPercentage() > 0.7 or
            rla.getWasteFilledPercentage() > 0.7 or
            rla.getDamagePercent() > 1 or
            ind.getEnergyFilledPercentage() > 0.9)
    then
        rla.scram()
    end
end

local function info()
    local fuel = math.ceil(rla.getFuelFilledPercentage() * 100)
    local coolant = math.ceil(rla.getCoolantFilledPercentage() * 100)
    local heated = math.ceil(rla.getHeatedCoolantFilledPercentage() * 100)
    local waste = math.ceil(rla.getWasteFilledPercentage() * 100)
    local steam = math.ceil(trb.getSteamFilledPercentage() * 100)
    local bheated = math.ceil(boi.getHeatedCoolantFilledPercentage() * 100)
    local bcoolant = math.ceil(boi.getCooledCoolantFilledPercentage() * 100)
    local bwater = math.ceil(boi.getWaterFilledPercentage() * 100)
    local bsteam = math.ceil(boi.getSteamFilledPercentage() * 100)

    local status = ""

    if rla.getStatus() then
        status = "Online"
    else
        status = "Offline"
    end

    local production = mekanismEnergyHelper.joulesToFE(trb.getProductionRate())

    local prodDisp = string.format("%.2f", production)
    if production < 1000 then
        prodDisp = production .. " FE/t"
    end
    if production > 1000 then
        prodDisp = string.format("%.2f", production / 1000) .. " kFE/t"
    end
    if production > 1e6 then
        prodDisp = string.format("%.2f", production / 1e6) .. " MFE/t"
    end
    if production > 1e9 then
        prodDisp = string.format("%.2f", production / 1e9) .. " GFE/t"
    end
    if production > 1e12 then
        prodDisp = string.format("%.2f", production / 1e12) .. " TFE/t"
    end

    local input = mekanismEnergyHelper.joulesToFE(ind.getLastInput())

    local inputDisp = string.format("%.2f", input)
    if input < 1000 then
        inputDisp = input .. " FE/t"
    end
    if input > 1000 then
        inputDisp = string.format("%.2f", input / 1000) .. " kFE/t"
    end
    if input > 1e6 then
        inputDisp = string.format("%.2f", input / 1e6) .. " MFE/t"
    end
    if input > 1e9 then
        inputDisp = string.format("%.2f", input / 1e9) .. " GFE/t"
    end
    if input > 1e12 then
        inputDisp = string.format("%.2f", input / 1e12) .. " TFE/t"
    end

    local output = mekanismEnergyHelper.joulesToFE(ind.getLastOutput())

    local outputDisp = string.format("%.2f", output)
    if output < 1000 then
        outputDisp = output .. " FE/t"
    end
    if output > 1000 then
        outputDisp = string.format("%.2f", output / 1000) .. " kFE/t"
    end
    if output > 1e6 then
        outputDisp = string.format("%.2f", output / 1e6) .. " MFE/t"
    end
    if output > 1e9 then
        outputDisp = string.format("%.2f", output / 1e9) .. " GFE/t"
    end
    if output > 1e12 then
        outputDisp = string.format("%.2f", output / 1e12) .. " TFE/t"
    end

    local energy = mekanismEnergyHelper.joulesToFE(ind.getEnergy())

    local energyDisp = string.format("%.2f", energy)
    if energy < 1000 then
        energyDisp = energy .. " FE"
    end
    if energy > 1000 then
        energyDisp = string.format("%.2f", energy / 1000) .. " kFE"
    end
    if energy > 1e6 then
        energyDisp = string.format("%.2f", energy / 1e6) .. " MFE"
    end
    if energy > 1e9 then
        energyDisp = string.format("%.2f", energy / 1e9) .. " GFE"
    end
    if energy > 1e12 then
        energyDisp = string.format("%.2f", energy / 1e12) .. " TFE"
    end
    if energy > 1e15 then
        energyDisp = string.format("%.2f", energy / 1e15) .. " PFE"
    end

    local epercent = math.ceil(ind.getEnergyFilledPercentage() * 100)

    mon.clear()
    mon.setCursorPos(1,1) mon.setTextColor(16) mon.write("Fission Reactor")
    mon.setCursorPos(1,2) mon.setTextColor(512) mon.write("Status: ") mon.setTextColor(1) mon.write(status)
    mon.setCursorPos(1,3) mon.setTextColor(32) mon.write("Fuel: ") mon.setTextColor(1) mon.write(fuel .. "%")
    mon.setCursorPos(1,4) mon.setTextColor(2048) mon.write("Coolant: ") mon.setTextColor(1) mon.write(coolant .. "%")
    mon.setCursorPos(1,5) mon.setTextColor(4) mon.write("Heated: ") mon.setTextColor(1) mon.write(heated .. "%")
    mon.setCursorPos(1,6) mon.setTextColor(4096) mon.write("Waste: ") mon.setTextColor(1) mon.write(waste .. "%")

    mon.setCursorPos(1,8) mon.setTextColor(16) mon.write("Thermoelectric Boiler")
    mon.setCursorPos(1,9) mon.setTextColor(4) mon.write("Heated: ") mon.setTextColor(1) mon.write(bheated .. "%")
    mon.setCursorPos(1,10) mon.setTextColor(2048) mon.write("Cooled: ") mon.setTextColor(1) mon.write(bcoolant .. "%")
    mon.setCursorPos(1,11) mon.setTextColor(8) mon.write("Water: ") mon.setTextColor(1) mon.write(bwater .. "%")
    mon.setCursorPos(1,12) mon.setTextColor(256) mon.write("Steam: ") mon.setTextColor(1) mon.write(bsteam .. "%")

    mon.setCursorPos(1,14) mon.setTextColor(16) mon.write("Industrial Turbine")
    mon.setCursorPos(1,15) mon.setTextColor(8192) mon.write("Production: ") mon.setTextColor(1) mon.write(prodDisp)
    mon.setCursorPos(1,16) mon.setTextColor(256) mon.write("Steam: ") mon.setTextColor(1) mon.write(steam .. "%")

    mon.setCursorPos(1,18) mon.setTextColor(16) mon.write("Induction Matrix")
    mon.setCursorPos(1,19) mon.setTextColor(8192) mon.write("Input: ") mon.setTextColor(1) mon.write(inputDisp)
    mon.setCursorPos(1,20) mon.setTextColor(8192) mon.write("Output: ") mon.setTextColor(1) mon.write(outputDisp)
    mon.setCursorPos(1,21) mon.setTextColor(8192) mon.write("Energy: ") mon.setTextColor(1) mon.write(energyDisp)
    mon.setCursorPos(1,22) mon.setTextColor(8192) mon.write("Filled: ") mon.setTextColor(1) mon.write(epercent .. "%")
end

while true do
    regulator()
    info()
end
