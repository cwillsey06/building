-- PlayerStates.lua
-- Coltrane Willsey
-- 2022-07-24 [00:31]

local common = game:GetService("ReplicatedStorage").common
local Packages = common.Packages
local Promise = require(Packages.promise)

local Modules = common.Modules
local tween = require(Modules.tween)

local PlayerStates = {}

function PlayerStates.Sprint(character: Model, polarity: boolean)
    local Humanoid = character:WaitForChild("Humanoid")
    return Promise.try(function()
        if polarity then
            tween(Humanoid, { WalkSpeed = 32; }, 1.5, Enum.EasingStyle.Exponential)
        else
            tween(Humanoid, { WalkSpeed = 16; }, 1.5, Enum.EasingStyle.Exponential)
        end
    end)
end

return PlayerStates