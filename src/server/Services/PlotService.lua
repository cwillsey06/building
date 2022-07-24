-- PlotService.lua
-- Coltrane Willsey
-- 2022-07-23 [23:52]

local Randomizer = Random.new()

local CollectionService = game:GetService("CollectionService")
local Players = game:GetService("Players")

local StandardPlotComponent = require(script.Parent.Parent.Components.StandardPlot)

local common = game:GetService("ReplicatedStorage").common
local Packages = common.Packages
local Knit = require(Packages.knit)

local PlotService = Knit.CreateService {
    Name = "PlotService";
    Client = {};
    AssignedPlots = {};
}

function PlotService:GetRandomOpenPlotIndex()
    local index

    repeat
        index = Randomizer:NextInteger(1, 9)
    until self.AssignedPlots[index] == nil

    return index
end

function PlotService:GetPlotByIndex(index: number)
    return StandardPlotComponent:FromInstance(
        CollectionService:GetTagged("StandardPlot".. tostring(index))[1]
    )
end

function PlotService:AssignPlot(player: Player, preferredPlot: number?)
    local index = self.AssignedPlots[preferredPlot] == nil and preferredPlot or self:GetRandomOpenPlotIndex()
    local plot = self:GetPlotByIndex(index)

    plot:AssignOwner(player)
end

--

function PlotService:KnitInit()
end

function PlotService:KnitStart()
    Players.PlayerAdded:Connect(function(player)
        self:AssignPlot(player)
    end)
end

return PlotService
