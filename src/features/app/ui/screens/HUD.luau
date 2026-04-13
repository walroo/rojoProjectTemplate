local ReplicatedStorage = game:GetService("ReplicatedStorage")

local TextButton = require(ReplicatedStorage.Source.Core.UI.Primitives.TextButton) -- Change to a component down the road
local Vide = require(ReplicatedStorage.Packages.Vide)

local function HUD(activeMenu)
	local buttons = {
		{
			Text = "Template",
			Activated = function()
				if activeMenu() == "Template" then
					activeMenu("None")
				else
					activeMenu("Template")
				end
			end,
		},
	}

	local buttonsSource = Vide.source(buttons)

	return Vide.create("Frame")({
		Name = "HUD",
		AnchorPoint = Vector2.new(0.5, 1),
		Position = UDim2.fromScale(0.5, 0.95),
		Size = UDim2.fromScale(1, 0.15),
		BackgroundTransparency = 1,

		Vide.create("UIListLayout")({
			FillDirection = Enum.FillDirection.Horizontal,
			HorizontalAlignment = Enum.HorizontalAlignment.Center,
			VerticalAlignment = Enum.VerticalAlignment.Center,
			SortOrder = Enum.SortOrder.LayoutOrder,
			Padding = UDim.new(0.01, 0),
		}),

		Vide.indexes(buttonsSource, function(buttonInfo)
			local button = TextButton({
				AnchorPoint = Vector2.new(0.5, 0.5),
				Position = UDim2.fromScale(0.5, 0.5),
				Size = UDim2.fromScale(1, 1),
				Text = buttonInfo().Text,
				Activated = buttonInfo().Activated,
			})
			button.SizeConstraint = Enum.SizeConstraint.RelativeYY

			return button
		end),
	})
end

return HUD
