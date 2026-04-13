local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

local Types = require(ReplicatedStorage.Source.Core.Services.RuntimeService.RuntimeServiceTypes)

local PRIORITY_SCORE = {
	First = 10,
	High = 30,
	Standard = 50,
	Low = 70,
	Last = 90,
}

local RuntimeServiceServer = {}
RuntimeServiceServer.subscritions = {} :: Types.SubscriptionArray

function RuntimeServiceServer:init()
	RunService.Heartbeat:Connect(function(deltaTime)
		for _, subscription in self.subscriptions do
			task.spawn(subscription.callback, deltaTime)
		end
	end)
end

function RuntimeServiceServer:subscribe(id: Types.Id, callback: Types.Callback, priority: Types.Priority?)
	local score = PRIORITY_SCORE[priority or "Standard"]

	self:unsubscribe(id)

	table.insert(self.subscritions, {
		id = id,
		score = score,
		callback = callback,
	})

	table.sort(self.subscritions, function(a, b)
		return a.score < b.score
	end)
end

function RuntimeServiceServer:unsubscribe(id: Types.Id)
	for index, subscription in self.subscritions do
		if subscription.id == id then
			table.remove(self.subscriptions, index)
			break
		end
	end
end

return RuntimeServiceServer
