function RegisterKey(Keybinds, KeyBindName, Callable)
    if (Keybinds[KeyBindName] and not IsKeyBindRegistered(Keybinds[KeyBindName].Key, Keybinds[KeyBindName].ModifierKeys)) then
        RegisterKeyBind(Keybinds[KeyBindName].Key, Keybinds[KeyBindName].ModifierKeys, Callable)
    end
end