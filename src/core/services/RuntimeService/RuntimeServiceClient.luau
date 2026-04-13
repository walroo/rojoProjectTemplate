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

local RuntimeServiceClient = {}
RuntimeServiceClient.updateSubscritions = {} :: Types.SubscriptionArray
RuntimeServiceClient.renderSubscritions = {} :: Types.SubscriptionArray

function RuntimeServiceClient:init()
	RunService.Heartbeat:Connect(function(deltaTime)
		for _, subscription in self.updateSubscritions do
			task.spawn(subscription.callback, deltaTime)
		end
	end)

	RunService.RenderStepped:Connect(function(deltaTime)
		for _, subscription in self.renderSubscritions do
			subscription.callback(deltaTime)
		end
	end)
end

function RuntimeServiceClient:subscribe(
	id: Types.Id,
	callback: Types.Callback,
	pipeline: Types.ClientPipelines,
	priority: Types.Priority?
)
	local array: Types.SubscriptionArray
	do
		if pipeline == "Render" then
			array = self.renderSubscritions
		else
			array = self.updateSubscritions
		end
	end

	local score = PRIORITY_SCORE[priority or "Standard"]

	self:Unsubscribe(id) -- Check both arrays

	table.insert(array, {
		id = id,
		score = score,
		callback = callback,
	})

	table.sort(array, function(a, b)
		return a.Score < b.Score
	end)
end

function RuntimeServiceClient:unsubscribe(id: Types.Id)
	for index, subscription in self.subscritions do
		if subscription.id == id then
			table.remove(self.subscriptions, index)
			break
		end
	end
end

return RuntimeServiceClient
