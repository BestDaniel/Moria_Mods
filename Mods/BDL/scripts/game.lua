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

function GameTogglePauseServer()
    PlayerController = FindFirstOf("PlayerController")
    if PlayerController:IsValid()
    then       
        PlayerController:ServerPause()
    end
end

local GameWorldStartedCallbacks = {}
function GameRegisterWorldStartedCallback(Callback)
    --First ensure the same callback is not already registered, if it is, don't add it a second time, just return
    for _, cb in ipairs(GameWorldStartedCallbacks) do
        if cb == Callback then
            print("GameRegisterWorldStartedCallback Callback already exists!")
            return
        end
    end
    table.insert(GameWorldStartedCallbacks, Callback)
end

RegisterHook("/Script/Engine.PlayerController:ClientRestart", function(Context, NewPawn)
    for I, Callback in ipairs(GameWorldStartedCallbacks) do
        Callback() -- TODO world context or equivalent object, i.e. world name, etc.
    end
end)