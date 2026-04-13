local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Types = require(script.Parent.EventServiceTypes)
local Util = require(script.Parent.EventServiceUtil)

local eventsFolder: Folder

local YIELD_TIMEOUT = 10 -- Seconds

local EventServiceClient = {}

type GetFunc =
	((self: typeof(EventServiceClient), path: { string } | string, yield: boolean?) -> RemoteEvent)
	& ((self: typeof(EventServiceClient), path: { string } | string, yield: boolean?) -> UnreliableRemoteEvent)
	& ((self: typeof(EventServiceClient), path: { string } | string, yield: boolean?) -> RemoteFunction)

function EventServiceClient:init()
	eventsFolder = ReplicatedStorage:WaitForChild("Events")
end

function EventServiceClient:get(path: { string } | string, yield: boolean?): any
	assert(eventsFolder, "[EventServiceClient]: Events folder does not exist; make sure service is initialized")

	local parent = Util:pathTo(eventsFolder, path)
	assert(parent, "[EventServiceClient]: Error finding path")

	local event: Types.Event
	if yield then
		for i = 1, YIELD_TIMEOUT do
			event = parent:FindFirstChild(Util:getNameFromPath(path))

			task.wait(1)

			if event ~= nil then
				break
			end
		end
	else
		event = parent:FindFirstChild(Util:getNameFromPath(path))
	end
	assert(event, "[EventServiceClient]: Could not find event")

	return event
end

EventServiceClient.get = EventServiceClient.get :: GetFunc

return EventServiceClient
