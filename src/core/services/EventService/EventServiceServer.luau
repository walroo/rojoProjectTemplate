local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Types = require(ReplicatedStorage.Source.Core.Services.EventService.EventServiceTypes)
local Util = require(ReplicatedStorage.Source.Core.Services.EventService.EventServiceUtil)

local eventsFolder: Folder

local EventServiceServer = {}

type CreateFunc =
	((self: typeof(EventServiceServer), path: { string } | string, eventType: "Reliable") -> RemoteEvent)
	& ((self: typeof(EventServiceServer), path: { string } | string, eventType: "Unreliable") -> UnreliableRemoteEvent)
	& ((self: typeof(EventServiceServer), path: { string } | string, eventType: "Function") -> RemoteFunction)

function EventServiceServer:init()
	eventsFolder = Instance.new("Folder")
	eventsFolder.Name = "Events"
	eventsFolder.Parent = ReplicatedStorage
end

function EventServiceServer:create(path: { string } | string, eventType: Types.EventType): Types.Event
	assert(eventsFolder, "[EventServiceServer]: Events folder does not exist; make sure service is initialized")

	local eventClass = Util:get(eventType)
	assert(eventClass, "[EventServiceServer]: Could not find class for " .. eventType)

	local parent = Util:pathTo(eventsFolder, path)
	assert(parent, "[EventServiceServer]: Error finding path")

	local event = Instance.new(eventClass) :: any
	event.Name = Util:getNameFromPath(path)
	event.Parent = parent

	return event
end

function EventServiceServer:get(path: { string } | string): Types.Event
	assert(eventsFolder, "[EventServiceServer]: Events folder does not exist; make sure service is initialized")

	local parent = Util:pathTo(eventsFolder, path)
	assert(parent, "[EventServiceServer]: Error finding path")

	local event = parent:FindFirstChild(Util:getNameFromPath(path)) :: Types.Event
	assert(event, "[EventServiceServer]: Could not find event")

	return event
end

EventServiceServer.create = EventServiceServer.create :: CreateFunc

return EventServiceServer
