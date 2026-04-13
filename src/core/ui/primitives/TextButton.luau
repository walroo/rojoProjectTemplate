local ReplicatedStorage = game:GetService("ReplicatedStorage")

local BaseButton = require(script.Parent.BaseButton)
local Vide = require(ReplicatedStorage.Packages.Vide)

export type TextButtonProps = BaseButton.BaseButtonProps & {
	Text: () -> string | string,
}

local function TextButton(props: TextButtonProps)
	local button = BaseButton(props)
	Vide.create("TextLabel")({
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.fromScale(0.5, 0.5),
		Size = UDim2.fromScale(1, 0.75),
		BackgroundTransparency = 1,
		Text = props.Text,
		TextScaled = true,
		Parent = button.Frame,
	})

	return button
end

return TextButton
