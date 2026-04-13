local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Vide = require(ReplicatedStorage.Packages.Vide)

local RootUI = require(ReplicatedStorage.Source.Features.App.RootUI)

return function()
	local player = Players.LocalPlayer
	local playerGui = player:WaitForChild("PlayerGui")

	local container = Vide.create("ScreenGui")({
		Name = "RootUI",
		IgnoreGuiInset = true,
		ResetOnSpawn = false,
		ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
		ClipToDeviceSafeArea = true,
		Parent = playerGui,
	})

	Vide.root(function()
		local ui = RootUI()
		ui.Parent = container
	end)
end
