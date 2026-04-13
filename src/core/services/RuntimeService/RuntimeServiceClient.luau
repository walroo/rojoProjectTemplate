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
RuntimeServiceClient.updateSubscriptions = {} :: Types.SubscriptionArray
RuntimeServiceClient.renderSubscriptions = {} :: Types.SubscriptionArray

function RuntimeServiceClient:init()
	RunService.Heartbeat:Connect(function(deltaTime)
		for _, subscription in self.updateSubscriptions do
			task.spawn(subscription.callback, deltaTime)
		end
	end)

	RunService.RenderStepped:Connect(function(deltaTime)
		for _, subscription in self.renderSubscriptions do
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
			array = self.renderSubscriptions
		else
			array = self.updateSubscriptions
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
	for index, subscription in self.updateSubscriptions do
		if subscription.id == id then
			table.remove(self.updateSubscriptions, index)
			break
		end
	end
	for index, subscription in self.renderSubscriptions do
		if subscription.id == id then
			table.remove(self.renderSubscriptions, index)
			break
		end
	end
end

return RuntimeServiceClient
