local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Vide = require(ReplicatedStorage.Packages.Vide)

local menus = {
	Template = require(ReplicatedStorage.Source.Features.Template.UI.Screens.TemplateMenu),
}

export type Menus = "None" | "Settings"

local function Menu(activeMenu)
	return Vide.create("Frame")({
		Name = "Menu",
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.fromScale(0.5, 0.5),
		Size = UDim2.fromScale(1, 1),
		BackgroundTransparency = 1,

		Vide.switch(activeMenu)({
			None = function()
				return nil
			end,
			Template = function()
				return menus.Template()
			end,
		}),
	})
end

return Menu
