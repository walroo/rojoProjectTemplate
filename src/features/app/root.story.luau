local ReplicatedStorage = game:GetService("ReplicatedStorage")

local RootUI = require(script.Parent.RootUI)
local Vide = require(ReplicatedStorage.Packages.Vide)

return function(target)
	local destroy = Vide.root(function()
		local ui = RootUI()
		ui.Parent = target
	end)

	return destroy
end
