-- SoundController.lua
-- Coltrane Willsey
-- 2022-07-22 [01:18]

-- TODO: Refactor this script later

type FadeParams = {
    FadeTime: number?;
    FadeDelay: number?;
}

local SoundService = game:GetService("SoundService")

local common = game:GetService("ReplicatedStorage").common
local Packages = common.Packages
local Promise = require(Packages.promise)
local Knit = require(Packages.knit)

local Modules = common.Modules
local tween = require(Modules.tween)

local SoundController = Knit.CreateController { Name = "SoundController"; }

function getSoundGroup(soundGroup: SoundGroup | string): SoundGroup
    return typeof(soundGroup) == "string" and SoundService:FindFirstChild(soundGroup) or soundGroup
end

function SoundController:SoundGroupPlay(soundGroup: SoundGroup | string, volume: number?, fadeInParams: FadeParams?)
    soundGroup = getSoundGroup(soundGroup)
    task.spawn(function()
        task.spawn(function()
            if fadeInParams then
                soundGroup.Volume = 0
                if fadeInParams["FadeDelay"] then
                    task.wait(fadeInParams.FadeDelay)
                end
                tween(soundGroup, { Volume = volume or soundGroup.Volume; }, fadeInParams["FadeTime"] or 1)
            else
                soundGroup.Volume = volume
            end
        end)

        for _, sound in ipairs(soundGroup:GetChildren()) do
            Promise.try(function()
                sound:Play()
            end)
            :catch(warn)
        end
    end)
end

function sg_PauseStop(method: string, soundGroup: SoundGroup | string, fadeOutParams: FadeParams?)
    local fadeTime = fadeOutParams["FadeTime"] or 1
    local initialVolume = soundGroup.Volume
    soundGroup = getSoundGroup(soundGroup)

    task.spawn(function()
        if fadeOutParams then
            if fadeOutParams["FadeDelay"] then
                task.wait(fadeOutParams.FadeDelay)
            end

            tween(soundGroup, { Volume = 0; }, fadeTime)
            task.wait(fadeTime)
        end

        for _, sound in ipairs(soundGroup:GetChildren()) do
            Promise.try(function()
                sound[method](sound)
            end)
            :catch(warn)
        end
        soundGroup.Volume = initialVolume
    end)
end

function SoundController:SoundGroupPause(soundGroup: SoundGroup | string, fadeOutParams: FadeParams?)
    sg_PauseStop("Pause", soundGroup, fadeOutParams)
end

function SoundController:SoundGroupStop(soundGroup: SoundGroup | string, fadeOutParams: FadeParams?)
    sg_PauseStop("Stop", soundGroup, fadeOutParams)
end

--

function SoundController:KnitInit()
end

function SoundController:KnitStart()
    -- if Knit.Player.Character or Knit.Player.CharacterAdded:Wait() then
    --     self:SoundGroupPlay(SoundService.Master.GlobalAmbient, 0.2, { FadeTime = 6; })
    -- end
end

return SoundController
