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

function TimeDemo()
    local GameTimeManager = TimeGetReference()

    print(string.format("RealMinutesPerGameDay %f\n",GameTimeManager.RealMinutesPerGameDay))
    
    
    print(string.format("GameTimeInMinutes %f\n",GameTimeManager.GameTimeInMinutes))
    print(string.format("StartingTimeInHours %f\n",GameTimeManager.StartingTimeInHours))

    print(string.format("GetTimeName %s\n",GameTimeManager:GetTimeName()))


    if GameTimeManager:IsNighttime() then
        print("night time")
    else        
        print("day time")
    end
    print(string.format("NightStart NightEnd %f %f\n",GameTimeManager.NightStart, GameTimeManager.NightEnd))

end