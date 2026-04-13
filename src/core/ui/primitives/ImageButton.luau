local ReplicatedStorage = game:GetService("ReplicatedStorage")

local BaseButton = require(script.Parent.BaseButton)
local Vide = require(ReplicatedStorage.Packages.Vide)

export type ImageButtonProps = BaseButton.BaseButtonProps & {
	Image: () -> string | string,
}

local function ImageButton(props: ImageButtonProps)
	local button = BaseButton(props)
	Vide.create("ImageLabel")({
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.fromScale(0.5, 0.5),
		Size = UDim2.fromScale(1, 0.75),
		BackgroundTransparency = 1,
		Image = props.Image,
		Parent = button.Frame,
	})

	return button
end

return ImageButton
