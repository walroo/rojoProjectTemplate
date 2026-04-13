local ReplicatedStorage = game:GetService("ReplicatedStorage")

local packages = ReplicatedStorage.Packages
local DataServiceModule = packages.DataService

if not DataServiceModule then
	error("[DataServiceClient]: DataService module not found in /Packages", 2)
	return {}
end

local DataService = require(DataServiceModule).client

local DataServiceClient = {}

DataServiceClient.service = DataService

return DataServiceClient
