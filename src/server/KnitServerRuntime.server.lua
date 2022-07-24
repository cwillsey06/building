-- KnitServerRuntime.server.lua
-- Coltrane Willsey
-- 2022-04-13 [16:21]

local common = game:GetService("ReplicatedStorage").common
local Packages = common.Packages
local Knit = require(Packages.knit)
local Loader = require(Packages.loader)

Knit.AddServices(script.Parent.Services)
Knit.Start()
:andThen(function()
    Loader.LoadChildren(script.Parent.Components)
end)
:catch(warn)