local ReplicatedStorage = game:GetService("ReplicatedStorage")

local services = ReplicatedStorage.Source.Core.Services
local features = ReplicatedStorage.Source.Features

local MountUI = require(ReplicatedStorage.Source.StartUp.MountUI)
MountUI()

local function load(module: ModuleScript)
	local success, result = pcall(function()
		local requiredModule = require(module)

		if type(requiredModule) == "table" and type(requiredModule.init) == "function" then
			requiredModule:init()
		end
		return requiredModule
	end)

	if not success then
		warn(`[Client]: Failed to initialize "{module.Name}"\nError: {result}`)
	end
end

local function loadFolder(folder: Folder)
	for _, child in folder:GetChildren() do
		if not child:IsA("Folder") then
			continue
		end

		local module = child:FindFirstChild(child.Name .. "Client")
		if module and module:IsA("ModuleScript") then
			task.spawn(load, module)
		end
	end
end

loadFolder(services)
loadFolder(features)
