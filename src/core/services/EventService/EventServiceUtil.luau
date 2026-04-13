local RunService = game:GetService("RunService")
local Types = require(script.Parent.EventServiceTypes)

local EVENTS: { [Types.EventType]: Types.EventClass } = {
	Reliable = "RemoteEvent",
	Unreliable = "UnreliableRemoteEvent",
	Function = "RemoteFunction",
}

local EventServiceUtil = {}

function EventServiceUtil:get(eventType: Types.EventType): Types.EventClass
	return EVENTS[eventType]
end

function EventServiceUtil:getNameFromPath(path: Types.Path): string
	return if typeof(path) == "table" then path[#path] else path
end

function EventServiceUtil:pathTo(origin: Folder, path: Types.Path): Folder
	if typeof(path) == "table" then
		local lastFolder = origin
		local pathLength = #path

		for i = 1, pathLength - 1 do -- Last index is the name of the event
			local name = path[i]

			local folder = lastFolder:FindFirstChild(name)
			do
				if not folder then
					if RunService:IsClient() then
						error(`[EventServiceUtil]: Folder "{name}" does not exist on client`)
					else
						folder = Instance.new("Folder")
						folder.Name = name
						folder.Parent = lastFolder
					end
				end
			end

			lastFolder = folder :: Folder
		end

		return lastFolder
	else
		return origin
	end
end

return EventServiceUtil
