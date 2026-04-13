local ServerScriptService = game:GetService("ServerScriptService")

local services = ServerScriptService.Core.Services
local features = ServerScriptService.Features

local function load(module: ModuleScript)
	local success, result = pcall(function()
		local requiredModule = require(module)

		if type(requiredModule) == "table" and type(requiredModule.init) == "function" then
			requiredModule:init()
		end
		return requiredModule
	end)

	if not success then
		warn(`[Server]: Failed to initialize "{module.Name}"\nError: {result}`)
	end
end

local function loadFolder(folder: Folder)
	for _, child in folder:GetChildren() do
		if not child:IsA("Folder") then
			continue
		end

		local module = child:FindFirstChild(child.Name .. "Server")
		if module and module:IsA("ModuleScript") then
			task.spawn(load, module)
		end
	end
end

loadFolder(services)
loadFolder(features)
