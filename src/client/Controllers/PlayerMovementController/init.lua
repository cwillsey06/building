-- PlayerMovementController.lua
-- Coltrane Willsey
-- 2022-07-24 [00:29]

local common = game:GetService("ReplicatedStorage").common
local Packages = common.Packages
local Knit = require(Packages.knit)

local Modules = common.Modules
local bind = require(Modules.bind)

local PlayerMovementController = Knit.CreateController {
    Name = "PlayerMovementController";
    CurrentState = "None";
    StateTimeout = 5;
}

function PlayerMovementController:ChangeState(stateFunction: (...any?) -> (), ...: any?)
    local function resetState()
        self.CurrentState = "None"
    end

    stateFunction(Knit.Player.Character, ...)
    :timeout(self.StateTimeout)
    :andThen(resetState)
    :catch(warn)
end

--

function PlayerMovementController:KnitInit()
    self.deps = {
        PlayerStates = require(script.PlayerStates)
    }
end

function PlayerMovementController:KnitStart()
    local PlayerStates = self.deps.PlayerStates
    self.bindings = {

        sprintIn = bind({ Enum.KeyCode.LeftShift; }, function()
            self:ChangeState(PlayerStates.Sprint, true)
        end, "Began");

        sprintOut = bind({ Enum.KeyCode.LeftShift; }, function()
            self:ChangeState(PlayerStates.Sprint, false)
        end, "Ended");

    }
end

return PlayerMovementController
