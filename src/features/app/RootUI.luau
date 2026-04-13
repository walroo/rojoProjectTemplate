-- RootUI.luau
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Vide = require(ReplicatedStorage.Packages.Vide)

-- Component Imports
local HUD = require(script.Parent.UI.Screens.HUD)
local Menu = require(script.Parent.UI.Screens.Menu)

local function RootUI()
	local activeMenu = Vide.source("Settings")

	return Vide.create("Frame")({
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.fromScale(0.5, 0.5),
		Size = UDim2.fromScale(1, 1),
		BackgroundTransparency = 1,

		HUD(activeMenu),
		Menu(activeMenu),
	})
end

return RootUI
