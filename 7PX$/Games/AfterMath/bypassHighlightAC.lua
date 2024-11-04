local Antihighligt = game:GetService("Stats").PerformanceStats.Memory.CoreMemory["render/glyphatlas/core"]

if Antihighligt then
    Antihighligt:Destroy()
end

local AdorneeUtility = game:GetService("ReplicatedStorage").EmberSharedLibrary.EmberShared.Utilities.AdorneeUtility

if AdorneeUtility then
    AdorneeUtility:Destroy()
end
