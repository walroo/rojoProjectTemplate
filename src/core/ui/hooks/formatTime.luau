return function(seconds: number): string
	seconds = math.floor(math.abs(seconds))

	local d = math.floor(seconds / 86400)
	local h = math.floor((seconds % 86400) / 3600)
	local m = math.floor((seconds % 3600) / 60)
	local s = seconds % 60

	if d > 0 then
		return string.format("%d:%02d:%02d:%02d", d, h, m, s)
	elseif h > 0 then
		return string.format("%d:%02d:%02d", h, m, s)
	else
		return string.format("%d:%02d", m, s)
	end
end
