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

-- This file defines a simple chat interface to send messages to the clients and to get the chat history

require("game")

local chatInitialized = false
local chatRefInitialized = false
local chatManagerReference = nil
local chatWindowReference = nil

local ChatColor = require("chat_color")

-- Initializes all the dependencies used for the chat interface
function ChatInit()
    -- Only initialize if it hasn't been initialzed yet!
    if not chatInitialized
    then
        GameRegisterWorldStartedCallback(ChatReset)

        print("Initializing chat")
        chatManagerReference = FindFirstOf("MorChatManager") -- reference object used to send messages to the clients
        chatWindowReference = FindFirstOf("WBP_UI_ChatWidget_C") -- reference object used to get a dump / history of the chat window
    
        chatRefInitialized = true
        chatInitialized = true
    end

end


--<p0> - orange text
--<p1> - blue text
--<p2> - yellow text
--<p3> - green text
--<p4> - purple text
--<p5> - brown text
--<p6> - teal text
--<p7> - dark brown
function ChatCreateColorString(Color, Colormsg)
    local FinalMessage = Colormsg
    if Color ~= ChatColor.NONE
    then
        FinalMessage = "<p" .. Color .. ">" .. Colormsg .. "</>"
    end
    return FinalMessage
end

-- Sends the text to all connected clients
function ChatSendServerColor(Color, colormsg, msg)
    if ChatVerifyReference()
    then
        local FinalMessage = msg
        if Color ~= ChatColor.NONE
        then
            FinalMessage = "<p" .. Color .. ">" .. colormsg .. "</>" .. msg
        end
        print(string.format("Sending chat message: %s %s", FinalMessage, Color))
        chatManagerReference:ServerChat(FinalMessage)
    end
end

function ChatSendServer(msg)
    if ChatVerifyReference()
    then
        chatManagerReference:ServerChat(msg)
    end
end

-- Unknown what the difference between Multicast and Server chat do differently, this will send the message to all clients
function ChatSendMulticast(msg)
    if ChatVerifyReference()
    then
        chatManagerReference:MulticastChat(msg)
    end
end

function ChatVerifyReference()
    if chatRefInitialized == false
    then
        -- Initialize the chat reference, if it cannot, error out
        ChatInit()      
    end

    if not chatManagerReference:IsValid()
    then
        print("Chat Manager reference not initialized!\n")
        ChatReset()
        return false
    end
    return true
end

-- Gets the history of all chat and returns it as a string
function ChatGetAllChatDump()
    return chatWindowReference.chatlogString:ToString()
end

-- If the user is typing in the chat window, this will return TRUE, if it is not active, returns false
function ChatIsChatWindowActive()
    ChatWidget = FindFirstOf("WBP_UI_ChatWidget_C")
    if not ChatWidget:IsValid()
    then
        error("Unable to find the Chat window widget.")
    end
    return ChatWidget.isChatActive
end

--Clears the flags forcing the chat references to be updated on the next usage.  This should be called when a world is just started or ended
--Tis function is only required for 2.5.2 of UE4SS
function ChatReset()
    chatInitialized = false
    chatRefInitialized = false
    chatManagerReference = nil
end