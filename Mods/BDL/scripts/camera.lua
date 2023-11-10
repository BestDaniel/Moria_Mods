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

local CameraCurrentFov = 90
local CameraMaxFov = 150
local CameraMinFov = 25
cameraLastFovChangeTick = 0


-- If the player spams the zoom in/out too fast, it will crash the game
-- returns fales if they didn't press it too fast, true if its too fast
function CameraFovChangeTooFast()
    EndTick = os.clock()
    ElapsedTick = EndTick - cameraLastFovChangeTick
    --print(string.format("Ticks:%f %f %f\n", ElapsedTick, EndTick, cameraLastFovChangeTick))
    if ElapsedTick > 0.05
    then
        cameraLastFovChangeTick = EndTick
        return false
    end

    return true
end

function CameraZoomIn()
    NewCameraFov = CameraCurrentFov - 5
    if(NewCameraFov >= CameraMinFov)
    then
        CameraSetFOV(NewCameraFov)
    end
end

function CameraZoomOut()
    NewCameraFov = CameraCurrentFov + 5
    if(NewCameraFov <= CameraMaxFov)
    then
        CameraSetFOV(NewCameraFov)
    end
    CameraSetFOV(NewCameraFov)
end

function CameraSetFOV(NewFov)
    PlayerController = FindFirstOf("PlayerController")

    -- Check if got the instance...if not....silently fail
    if PlayerController:IsValid()
    then          
        if not CameraFovChangeTooFast()
        then
            CameraCurrentFov = NewFov
            ExecuteInGameThread(function()
            PlayerController:FOV(NewFov)
            end)             
        end
    end
end
