local remote = game:GetService("ReplicatedStorage").Remotes.ExploitBan
local old

old = hookmetamethod(game, "__namecall", function(self, ...)
    local args = {...}
    if getnamecallmethod() == "FireServer" and self == remote then
        return nil
    end
    return old(self, ...)
end)