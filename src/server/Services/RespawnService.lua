-- RespawnService.lua
-- Coltrane Willsey
-- 2022-07-26 [20:33]

local Players = game:GetService("Players")

local common = game:GetService("ReplicatedStorage").common
local Packages = common.Packages
local Knit = require(Packages.knit)

local RespawnService = Knit.CreateService {
    Name = "RespawnService";
    Client = {};
}

function RespawnService.RespawnPlayer(player: Player)
    player:LoadCharacter()
end

function RespawnService.Client.RespawnPlayer(_, player: Player)
    RespawnService.RespawnPlayer(player)
end

--

function RespawnService:KnitInit()
end

function RespawnService:KnitStart()
   Players.PlayerAdded:Connect(self.RespawnPlayer)
end

return RespawnService
