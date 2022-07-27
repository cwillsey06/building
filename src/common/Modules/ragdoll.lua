-- ragdoll.lua
-- Coltrane Willsey
-- 2022-07-27 [01:39]

-- Adapted from an old script dated:
--                        2021-12-19

local common = game:GetService("ReplicatedStorage").common
local Modules = common.Modules
local new = require(Modules.new)

function replaceJoint(joint: Motor6D)
	local shortName = (joint.Name):gsub(" ", '')
	local att0 = joint.Parent:FindFirstChild(shortName.. "0")
	local att1 = joint.Part1:FindFirstChild(shortName.. "1")

	if att0 and att1 then
		new("BallSocketConstraint", joint.Parent, {
			Attachment0 = att0;
			Attachment1 = att1;
		})

		joint:Destroy()
	end
end

function Ragdoll(character: Model)
	for _, obj in ipairs(character:GetDescendants()) do
		if obj:IsA("Motor6D") then
			replaceJoint(obj)
		end
	end
end

return Ragdoll
