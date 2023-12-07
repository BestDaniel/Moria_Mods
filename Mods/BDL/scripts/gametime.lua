--[[
MIT License

Copyright (c) 2023 BestDaniel.net

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
--]]

function TimeGetReference()
    local GameTimeManager = FindFirstOf("BP_TimeManager_C")
    if not GameTimeManager:IsValid()
    then
        error("Unable to find the time manager.")
    end

    return GameTimeManager
end

function TimeGetTime()

    local GameTimeManager = TimeGetReference()

    local OutTime = {}
    local Hour = 0
    local Day = 0
    local Minute = 0
    local isPM = false
    local TwentyFourHour = true

    GameTimeManager:GetGameTime(TwentyFourHour, OutTime, OutTime, OutTime, OutTime);
    for k,v in pairs(OutTime) do
        print(string.format("%s == %s\n", k, v))
        if k == "Day" then
            Day = tonumber(v)
        elseif k == "Hour" then
            Hour = tonumber(v)
        elseif k == "Minute" then
            Minute = tonumber(v)
        elseif k == "bPM" then
            isPM = v == "true"
        end
    end
    print(string.format("GetTimeName %f %f %f\n", Day, Hour, Minute))
    return { Hour= Hour, Day = Day, Minute = Minute, isPm = isPM}
end

local TimeOfDay = {
    Sunrise = 400,
    Day = 600,
    Sunset = 1100,
    Night = 1300
}

function TimeGetTimeOfDayFromString(str)
    str = string.lower(str)
    if str == "sunrise" then
        return TimeOfDay.Sunrise
    elseif str == "day" then
        return TimeOfDay.Day
    elseif str == "sunset" then
        return TimeOfDay.Sunset
    elseif str == "night" then
        return TimeOfDay.Night
    else
        return nil
    end
end

local TICKS_PER_DAY = 1440

function TimeSetTime(timeOfDay)
    timeOfDay = timeOfDay or TimeOfDay.Day


    local GameTimeManager = TimeGetReference()
    GameTimeManager:SetShouldDoDayNightCycle(false)
    local CurrentTime = GameTimeManager.GameTimeInMinutes
    --calculate the duration to the next time for the request time then update the time
    local RemainderTime = CurrentTime % TICKS_PER_DAY
    local TimeIncrement = 0

    if RemainderTime > timeOfDay then
        TimeIncrement = TICKS_PER_DAY - RemainderTime + timeOfDay
    else
        TimeIncrement = timeOfDay - RemainderTime
    end

    print(string.format("setting time... Current Time: %s Remainder: %s Increment: %s", CurrentTime, RemainderTime, TimeIncrement))
    GameTimeManager.GameTimeInMinutes = CurrentTime + TimeIncrement
    GameTimeManager:SetShouldDoDayNightCycle(true)
end

function TimeDemo()
    local GameTimeManager = TimeGetReference()

    print(string.format("RealMinutesPerGameDay %f\n",GameTimeManager.RealMinutesPerGameDay))
    
    
    print(string.format("GameTimeInMinutes %f\n",GameTimeManager.GameTimeInMinutes))
    print(string.format("StartingTimeInHours %f\n",GameTimeManager.StartingTimeInHours))


    print(string.format("CurrentPeriodIndex %f\n",GameTimeManager.CurrentPeriodIndex))
    print(string.format("PreviousTimeIndex %f\n",GameTimeManager.PreviousTimeIndex))
    print(string.format("ElapsedPartialGameMinute %f\n",GameTimeManager.ElapsedPartialGameMinute))
    
    print(string.format("TimePeriods array size %f\n",GameTimeManager.TimePeriods:GetArrayNum()))

    GameTimeManager.TimePeriods:ForEach(function(Index, elem)
        object = elem:get()
        object.LightModifier = 99
        print(string.format("GetTimeName %s\n",object:GetFullName()))
        print(string.format("StartHour %s\n",object.StartHour))
        print(string.format("LightModifier %s\n",object.LightModifier))
        print(string.format("TemperatureModifier %s\n",object.TemperatureModifier))
        print(string.format("Time name %s\n",object.Name))
        if object.StartHour < 5.0 then
            print("changing the start time")
            object.StartHour = 26 + object.StartHour 
        end

        if object.StartHour == 5.0 then
            print("changing the start time")
            object.StartHour = 0
        end

    end)

    print(string.format("GetTimeName %s\n",GameTimeManager:GetTimeName()))
end