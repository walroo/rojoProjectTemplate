local ServerScriptService = game:GetService("ServerScriptService")

local services = ServerScriptService.Core.Services
local features = ServerScriptService.Features

local function init(module: ModuleScript)
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

local function initFolder(folder: Folder)
	for _, child in folder:GetChildren() do
		if not child:IsA("Folder") then
			continue
		end

		local name = child.Name
		if not name:find("Service") then
			name = name .. "Service"
		end

		local module = child:FindFirstChild(name .. "Server")

		print(folder.Name, module)
		if module and module:IsA("ModuleScript") then
			task.spawn(init, module)
		end
	end
end

initFolder(services)
initFolder(features)
