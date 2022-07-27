-- StandardPlot.lua
-- Coltrane Willsey
-- 2022-07-24 [00:04]

local common = game:GetService("ReplicatedStorage").common
local Packages = common.Packages
local Component = require(Packages.component)

local StandardPlot = Component.new { Tag = "StandardPlot"; }

function StandardPlot:AssignOwner(player: Player)
    self.Owner = player
    player.RespawnLocation = self.Instance.PlotSpawnLocation
end

--

function StandardPlot:Construct()
end

function StandardPlot:Start()
end

function StandardPlot:Destroy()
end

return StandardPlot
