-- constructr6attachmentrig.lua
-- Coltrane Willsey
-- 2022-07-27 [01:36]

-- Adapted from an old script dated:
--                        2021-12-16

local common = game:GetService("ReplicatedStorage").common
local Modules = common.Modules
local new = require(Modules.new)

type AttachmentInfo = {[string]: {[string]: Vector3}}

local RigAttachments: AttachmentInfo = {
	["Torso"] = {
		["Neck0"] = Vector3.new(0, 1, 0);
		["RightShoulder0"] = Vector3.new(1, 1, 0);
		["LeftShoulder0"] = Vector3.new(-1, 1, 0);
		["RightHip0"] = Vector3.new(1, -1, 0);
		["LeftHip0"] = Vector3.new(-1, -1, 0);
	};

	["Head"] = {
		["Neck1"] = Vector3.new(0, 0.5, 0);
	};

	["Right Arm"] = {
		["RightShoulder1"] = Vector3.new(-0.5, 1, 0);
	};

	["Left Arm"] = {
		["LeftShoulder1"] = Vector3.new(0.5, 1, 0);
	};

	["Right Leg"] = {
		["RightHip1"] = Vector3.new(0.5, 1, 0);
	};

	["Left Leg"] = {
		["LeftHip1"] = Vector3.new(-0.5, 1, 0);
	};
}

function construct(r6Rig: Model, rigOverride: AttachmentInfo?)
	for target: string, attachments: any in pairs(rigOverride or RigAttachments) do
		for name: string, offset: Vector3 in pairs(attachments) do
			new("Attachment", r6Rig[target], {
				Name = name;
				Position = offset;
			})
		end
	end
end

return construct
