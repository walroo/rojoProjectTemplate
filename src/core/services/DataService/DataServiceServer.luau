local ReplicatedStorage = game:GetService("ReplicatedStorage")

local packages = ReplicatedStorage.Packages
local DataServiceModule = packages.DataService

if not DataServiceModule then
	error("[DataServiceServer]: DataService module not found in /Packages", 2)
	return {}
end

local DataService = require(DataServiceModule).server

local source = ReplicatedStorage.Source
local DataTemplate = require(source.Game.Items.DataTemplate)

local DataServiceServer = {}

DataServiceServer.service = DataService

function DataServiceServer:init()
	DataService:init({
		template = DataTemplate,
		profileStoreIndex = "PRE",
		useMock = false,
		resetData = true,
		dontSave = false,
	})
end

return DataServiceServer
