local old

local plrs = game.Players
local lplr = plrs.LocalPlayer

local humanoid = lplr.Character.Humanoid

old = hookmetamethod(game,"__index",function(self,key)
    if self == humanoid and key == "WalkSpeed" then
        return 16
    end
    return old(self,key)
end)