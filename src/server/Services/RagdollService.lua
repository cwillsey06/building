-- RagdollService.lua
-- Coltrane Willsey
-- 2022-07-27 [01:42]

local Players = game:GetService("Players")

local common = game:GetService("ReplicatedStorage").common
local Packages = common.Packages
local Knit = require(Packages.knit)

local Modules = common.Modules
local ConstructR6AttachmentRig = require(Modules.constructr6attachmentrig)
local Ragdoll = require(Modules.ragdoll)

local RagdollService = Knit.CreateService {
    Name = "RagdollService";
    Client = {};
}

function RagdollService.RagdollR6Model(model: Model)
    assert(model:FindFirstChildOfClass("Humanoid"), ("No Humanoid found in model '%s"):format(model:GetFullName()))
    ConstructR6AttachmentRig(model)
    Ragdoll(model)
end

--

function RagdollService:KnitInit()
end

function RagdollService:KnitStart()
    local function characterAdded(character: Model)
        local humanoid = character:WaitForChild("Humanoid")
        if humanoid.RigType ~= Enum.HumanoidRigType.R6 then return end
        humanoid.BreakJointsOnDeath = false
        humanoid.Died:Connect(function()
            self.RagdollR6Model(character)
        end)
    end

    local function playerAdded(player: Player)
        if player.Character then
           characterAdded(player.Character)
        end

        player.CharacterAdded:Connect(characterAdded)
    end

    for _, player in ipairs(Players:GetPlayers()) do
        playerAdded(player)
    end

    Players.PlayerAdded:Connect(playerAdded)
end

return RagdollService
