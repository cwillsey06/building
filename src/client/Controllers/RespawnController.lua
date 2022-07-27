-- RespawnController.lua
-- Coltrane Willsey
-- 2022-07-26 [20:33]

local common = game:GetService("ReplicatedStorage").common
local Packages = common.Packages
local Knit = require(Packages.knit)

local RespawnController = Knit.CreateController { Name = "RespawnController"; }

function RespawnController:Respawn()
    self.RespawnService.RespawnPlayer()
end

function RespawnController:KnitInit()
    self.RespawnService = Knit.GetService("RespawnService")
end

function RespawnController:KnitStart()
    local function characterAdded(character: Model)
        local humanoid = character:WaitForChild("Humanoid")
        local deathSound = character:WaitForChild("HumanoidRootPart")
                                    :WaitForChild("Died")
        humanoid.Died:Connect(function()
            task.wait(deathSound.TimeLength + 0.5)
            self:Respawn()
        end)
    end

    if Knit.Player.Character then
        characterAdded(Knit.Player.Character)
    end

    Knit.Player.CharacterAdded:Connect(characterAdded)
end

return RespawnController
