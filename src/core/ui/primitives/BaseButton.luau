local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

local Spring = require(ReplicatedStorage.Packages.Spring)
local Vide = require(ReplicatedStorage.Packages.Vide)

local MAX_SCALE = 1.1
local MIN_SCALE = 0.95

export type BaseButtonProps = {
	AnchorPoint: Vector2,
	Position: UDim2,
	Size: UDim2,
	MaxScale: number?,
	MinScale: number?,
	Activated: () -> (),
}

local function BaseButton(props: BaseButtonProps)
	local scaleSource = Vide.source(1)
	local scaleSpring = Spring.new(0.6, 7, 1, 1)

	local hovering = false

	local connection = RunService.Heartbeat:Connect(function(deltaTime)
		scaleSource(scaleSpring:step(deltaTime))
	end)

	Vide.cleanup(function()
		connection:Disconnect()
	end)

	return Vide.create("TextButton")({
		AnchorPoint = props.AnchorPoint,
		BackgroundTransparency = 1,
		Position = props.Position,
		Size = props.Size,
		Text = "",

		MouseButton1Down = function()
			scaleSpring:setGoal(props.MinScale or MIN_SCALE)
			if props.Activated then
				props.Activated()
			end
		end,

		MouseButton1Up = function()
			if hovering then
				scaleSpring:setGoal(props.MaxScale or MAX_SCALE)
			else
				scaleSpring:setGoal(1)
			end
		end,

		MouseEnter = function()
			hovering = true
			scaleSpring:setGoal(props.MaxScale or MAX_SCALE)
		end,

		MouseLeave = function()
			hovering = false
			scaleSpring:setGoal(1)
		end,

		Vide.create("Frame")({
			AnchorPoint = Vector2.new(0.5, 0.5),
			Position = UDim2.fromScale(0.5, 0.5),
			Size = UDim2.fromScale(1, 1),
			BackgroundTransparency = 0,

			Vide.create("UIScale")({
				Scale = scaleSource,
			}),
		}),
	})
end

return BaseButton
